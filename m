Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFE78CD1284
	for <u-boot@archiver.kernel.org>; Tue,  2 Apr 2024 08:49:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B7218808A;
	Tue,  2 Apr 2024 10:49:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="F9s9Oiza";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A202188339; Tue,  2 Apr 2024 10:49:24 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4BE687E30
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 10:49:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E114142494
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 08:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1712047760;
 bh=jGfCyigdV5qIBn7xiTOC6sWrrihMectfEY6o36E85X4=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=F9s9OizaN9TdslFjPNFzrZdUAw9LS08O/FukcfTWkVZR6rfwPtlJh6uN20Djj+HFP
 ONO3ovyV/gq7i3OqMeG8S94Lgh4QNeeT+Eh9k8DPEm6VLI0OIQYtEMtQKOCgEHkVX7
 dNh7e63r6/fh4NV6E8KAHXOJPykMTOhbrLAbToomVT38JC0LVPpX1B/REaPYYSBR0F
 DHo5if75lZAbYsiqXHNHCaNJxORkKKM2T4m1xIIMB5d0sp/ohQp25v0ugTXKsZyNyH
 kGIGVdSFmlpqfbowzgm8OGqcmlJoTLSHT22Odo519dsxaCoOyAooqC/wJayY1NXu05
 pywU85tfQH24A==
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2d81eef59e8so11447461fa.3
 for <u-boot@lists.denx.de>; Tue, 02 Apr 2024 01:49:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712047760; x=1712652560;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jGfCyigdV5qIBn7xiTOC6sWrrihMectfEY6o36E85X4=;
 b=CIP0zkkBL5tq3V7QnmdhQltWB37sM8XHlE5hqQQVfmsTzTEwAHbcoxju5zeJo3d/C8
 W9gIOMHErw9m0ySj2sv8n74Z4zcxcn4XYtMF8tZY+xTDwdsmu1GPomps+HYbNRMBnxb7
 B9+SjD0fIMJbNXMqr5Dq6dK78jADYAUKIa05idcFvT6uYsd/6440VvrggpB6M26A5p9/
 vjUtq2oFPDLljgw9RNrHqRhuVCeSQNUDswlI84TkAeafjn1YW5WQYRMyANv2NF953a3S
 gT3fYEz3IoOLl1bXbkMtHPITp+4QHYaLjxW1Fi2o/lMU6MaKSc8XxRL/nnzYxVe3FoDs
 21cg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDXpFLVAl/dRdRZSnVNZT2qV3Bn8HrRpklyUpTKQwNSBFW/oNbiHevZuOkSgrnpB/MO9qg+vWaZBUBW5R2fWk8m32zVw==
X-Gm-Message-State: AOJu0YylmZRCra0uyVyf8GWe4XSxfQxKxbjCvF1ffUZPXnSZpbeW7oGG
 pxDlY9lqhhNrSQYZ4j9wazTdT2mAP9yiMBCnsH76GmT75cGuiedFOa2D9RzF5kKs+DEnL+1fF8r
 zLByyzYklW4itQhZVm2z5cpksNwRkAOJwazWenkm26IPy8PAOmO1GvVOlBBE88X5F3jE=
X-Received: by 2002:a05:651c:208:b0:2d8:12a4:8c5b with SMTP id
 y8-20020a05651c020800b002d812a48c5bmr3684105ljn.16.1712047760251; 
 Tue, 02 Apr 2024 01:49:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUWuQ4x4Ao2En4w8SOgAziPnyXjEVMzSZGZ+PSFKj4spM9TYwSPVLa5mxMZmOFav7ssSNdUg==
X-Received: by 2002:a05:651c:208:b0:2d8:12a4:8c5b with SMTP id
 y8-20020a05651c020800b002d812a48c5bmr3684088ljn.16.1712047759885; 
 Tue, 02 Apr 2024 01:49:19 -0700 (PDT)
Received: from workstation5.fritz.box
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 n18-20020a05600c4f9200b004148c3685ffsm17409318wmq.3.2024.04.02.01.49.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Apr 2024 01:49:19 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Lukasz Tekieli <tekieli.lukasz@gmail.com>,
 Shiji Yang <yangshiji66@outlook.com>, Shengyu Qu <wiagn233@outlook.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>, E Shattow <lucent@gmail.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v3 1/6] riscv: do not set default fdt for VisionFive 2
Date: Tue,  2 Apr 2024 10:49:07 +0200
Message-ID: <20240402084912.43228-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240402084912.43228-1-heinrich.schuchardt@canonical.com>
References: <20240402084912.43228-1-heinrich.schuchardt@canonical.com>
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

Currently in set_fdtfile() we set the value of environment variable fdtfile
unconditionally. The implies that a value in the environment will be
ignored.

With the patch environment variable fdtfile will only be set if it does not
yet exist. This requires that CONFIG_DEFAULT_FDT_FILE is not set.

Now the user can either set and save fdtfile interactively or in the U-Boot
configuration to overrule the device-tree name chosen based on the
hardware in set_fdtfile().

Reported-by: E Shattow <lucent@gmail.com>
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v3:
	Rephrase last added sentence in doc/board/starfive/visionfive2.rst
v2:
	new patch
---
 .../visionfive2/starfive_visionfive2.c         |  4 ++++
 configs/starfive_visionfive2_defconfig         |  1 -
 doc/board/starfive/visionfive2.rst             | 18 ++++++++++++++++++
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/board/starfive/visionfive2/starfive_visionfive2.c b/board/starfive/visionfive2/starfive_visionfive2.c
index 78e118d5a05..76439179fa7 100644
--- a/board/starfive/visionfive2/starfive_visionfive2.c
+++ b/board/starfive/visionfive2/starfive_visionfive2.c
@@ -49,6 +49,10 @@ static void set_fdtfile(void)
 	u8 version;
 	const char *fdtfile;
 
+	fdtfile = env_get("fdtfile");
+	if (fdtfile)
+		return;
+
 	version = get_pcb_revision_from_eeprom();
 	switch (version) {
 	case 'a':
diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_visionfive2_defconfig
index 7a3f1d4dbdf..fa80d489f5e 100644
--- a/configs/starfive_visionfive2_defconfig
+++ b/configs/starfive_visionfive2_defconfig
@@ -40,7 +40,6 @@ CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 debug rootwait earlycon=sbi"
 CONFIG_USE_PREBOOT=y
 CONFIG_PREBOOT="nvme scan; usb start; setenv fdt_addr ${fdtcontroladdr}; fdt addr ${fdtcontroladdr};"
-CONFIG_DEFAULT_FDT_FILE="starfive/jh7110-starfive-visionfive-2.dtb"
 CONFIG_SYS_CBSIZE=256
 CONFIG_SYS_PBSIZE=276
 CONFIG_DISPLAY_CPUINFO=y
diff --git a/doc/board/starfive/visionfive2.rst b/doc/board/starfive/visionfive2.rst
index abda8ac21bc..2c68df3ce4d 100644
--- a/doc/board/starfive/visionfive2.rst
+++ b/doc/board/starfive/visionfive2.rst
@@ -71,6 +71,24 @@ Now build the U-Boot SPL and U-Boot proper
 This will generate the U-Boot SPL image (spl/u-boot-spl.bin.normal.out) as well
 as the FIT image (u-boot.itb) with OpenSBI and U-Boot.
 
+Device-tree selection
+~~~~~~~~~~~~~~~~~~~~~
+
+Depending on the board version U-Boot set variable $fdtfile to either
+starfive/jh7110-starfive-visionfive-2-v1.2a.dtb or
+starfive/jh7110-starfive-visionfive-2-v1.3b.dtb.
+
+To overrule this selection the variable can be set manually and saved in the
+environment
+
+::
+
+    setenv fdtfile my_device-tree.dtb
+    env save
+
+or the configuration variable CONFIG_DEFAULT_FDT_FILE can be used to provide
+a default value.
+
 Flashing
 ~~~~~~~~
 
-- 
2.43.0

