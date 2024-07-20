Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E85BFC3DA59
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 10:50:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBC1288C2F;
	Sat, 20 Jul 2024 12:50:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dgJjTJ8g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32E5B886F9; Sat, 20 Jul 2024 12:50:07 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3D8B88719
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 12:50:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-367e50f71bbso1293973f8f.2
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 03:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721472604; x=1722077404; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GHLm0SmoLQYiUDyEBdTJJMeoIs9kvx/JX2BIscoUFN0=;
 b=dgJjTJ8gdliLJVwnmH/ExHcu562R+SYCEwhORlHlipKojG0jjMQX5MRuOVvnqc60Bt
 +jxxlHSRp5cU2wHRy3ISL1uGFu6xKEwjymmksgizuoytd9iYpg4OPThQ2vASg6NcFT0A
 ja1V4W6LnOF/j+oRrmXyouuUKOFcX0QInDX1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721472604; x=1722077404;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GHLm0SmoLQYiUDyEBdTJJMeoIs9kvx/JX2BIscoUFN0=;
 b=vMxMUTLnI9/5HyzkwyXJIfFpl7xFoTycXTB/cu4zdg7AGNvCv2j+pmu+RyRGNsVR6g
 pm2yjU2gQlTY6gFaBdBLdvHKfAPy1zGA5rMkCnocbqW7lDcDk6gEycw8hu3xd8t8s/nR
 hEUTuZm/1Pfh4rCqZttR4enZu4xjPuHx/5Sq2pOPAETuHofJ9mQlELYb/ae+rY2O8dWr
 rK8LrKJ+mEs+ORdKSxxQJ39a+rqusaWa3b37Ri9+qUEkkt2QQcmPYl9rLip1kqi6EzMo
 Jo8fJpd3bl0Ogz9zr/EyDImxxvpOfmRWz47EJxzygbjMDzkkq62lwznPRxoSo0FdjNId
 MiKQ==
X-Gm-Message-State: AOJu0YyOiDJIh8g03lLA8VnyryVaYczO52CouAkt7Ec2/Qe48asm/itZ
 IFhWtjbyxDD5h5RjV3aVTw615Io2/CkP4ZbEEBDgoz0vcwpUwG104J0jNaMNGlevBWxQvqlEX6c
 =
X-Google-Smtp-Source: AGHT+IHWL0GX8eRUf9P0m5VpCyoplp2pw7fgrYlkaHMKpJxObMEUSjIq53kAiUuEKr1c2+Z8f1GBWA==
X-Received: by 2002:a5d:4ecc:0:b0:368:36e6:b23a with SMTP id
 ffacd0b85a97d-369bb2dd18fmr623872f8f.55.1721472603637; 
 Sat, 20 Jul 2024 03:50:03 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36878684225sm3715616f8f.9.2024.07.20.03.50.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jul 2024 03:50:03 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 03/20] binman: Tidy up bintool docs
Date: Sat, 20 Jul 2024 11:49:33 +0100
Message-Id: <20240720104950.2730773-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240720104950.2730773-1-sjg@chromium.org>
References: <20240720104950.2730773-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

The docs have somehow got out of sync. Regenerate the file to fix the
problem.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/bintools.rst | 61 ++++++++++++++++++++++++---------------
 1 file changed, 38 insertions(+), 23 deletions(-)

diff --git a/tools/binman/bintools.rst b/tools/binman/bintools.rst
index 1336f4d0115..fa44d9c6872 100644
--- a/tools/binman/bintools.rst
+++ b/tools/binman/bintools.rst
@@ -10,6 +10,15 @@ binaries. It is fairly easy to create new bintools. Just add a new file to the
 
 
 
+Bintool: bootgen: Generate bootable fsbl image for zynq/zynqmp
+--------------------------------------------------------------
+
+This bintools supports running Xilinx "bootgen" in order
+to generate a bootable, authenticated image form an SPL.
+
+
+
+
 Bintool: bzip2: Compression/decompression using the bzip2 algorithm
 -------------------------------------------------------------------
 
@@ -37,6 +46,25 @@ Documentation about CBFS is at https://www.coreboot.org/CBFS
 
 
 
+Bintool: cst: Image generation for U-Boot
+-----------------------------------------
+
+This bintool supports running `cst` with some basic parameters as
+needed by binman.
+
+
+
+Bintool: fdt_add_pubkey: Add public key to control dtb (spl or u-boot proper)
+-----------------------------------------------------------------------------
+
+This bintool supports running `fdt_add_pubkey`.
+
+Normally mkimage adds signature information to the control dtb. However
+binman images are built independent from each other. Thus it is required
+to add the public key separately from mkimage.
+
+
+
 Bintool: fiptool: Image generation for ARM Trusted Firmware
 -----------------------------------------------------------
 
@@ -143,11 +171,20 @@ Documentation is available via::
 
 
 
+Bintool: mkeficapsule: Handles the 'mkeficapsule' tool
+------------------------------------------------------
+
+This bintool is used for generating the EFI capsules. The
+capsule generation parameters can either be specified through
+commandline, or through a config file.
+
+
+
 Bintool: mkimage: Image generation for U-Boot
 ---------------------------------------------
 
 This bintool supports running `mkimage` with some basic parameters as
-neeed by binman.
+needed by binman.
 
 Normally binman uses the mkimage built by U-Boot. But when run outside the
 U-Boot build system, binman can use the version installed in your system.
@@ -194,25 +231,3 @@ Documentation is available via::
 
 
 
-Bintool: fdt_add_pubkey: Add public key to device tree
-------------------------------------------------------
-
-This bintool supports running `fdt_add_pubkey` in order to add a public
-key coming from a certificate to a device-tree.
-
-Normally signing is done using `mkimage` in context of `binman sign`. However,
-in this process the public key is not added to the stage before u-boot proper.
-Using `fdt_add_pubkey` the key can be injected to the SPL independent of
-`mkimage`
-
-
-
-Bintool: bootgen: Sign ZynqMP FSBL image
-----------------------------------------
-
-This bintool supports running `bootgen` in order to sign a SPL for ZynqMP
-devices.
-
-The bintool automatically creates an appropriate input image file (.bif) for
-bootgen based on the passed arguments. The output is a bootable,
-authenticated `boot.bin` file.
-- 
2.34.1

