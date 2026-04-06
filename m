Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FCB9F46C78
	for <u-boot@archiver.kernel.org>; Mon,  6 Apr 2026 19:48:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A387841C2;
	Mon,  6 Apr 2026 21:46:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YsP6hubb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4184D83C2B; Mon,  6 Apr 2026 21:21:52 +0200 (CEST)
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20::843])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 301008352B
 for <u-boot@lists.denx.de>; Mon,  6 Apr 2026 21:21:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-qt1-x843.google.com with SMTP id
 d75a77b69052e-50b2b289925so38944741cf.2
 for <u-boot@lists.denx.de>; Mon, 06 Apr 2026 12:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775503309; x=1776108109; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xz/PrIKr78Lq5gz51kg7YWKzaG9j6PB5MtE7hX+/bxg=;
 b=YsP6hubbbF6ffe+ePqM2SJxmMo4wgdWqtDI0ylVSHEVboLACuYX4ONjzhlwoIdKBR/
 0UG8yrv/LnUUZ6V8AmNPgOW5L6ePpEuA8xPSAK2MeqXqfxrR41t8pPFjVXJ3ZemHOKpG
 yhKk6/cGl6UpebHE/DmwPVMabYsS4qAYCa9GZjfRkEK0D4/zhaKliGPDJUxF8TOcsB5W
 MqiAJzvd+S8LxcxWKNBCitID5EoaxeR9D04DXLxWBiTkhXpC6JBSl1yyExaFRkb73ve1
 xMhAaH/FO0sqtvOMwnEjJFDT6i+fjhB8wA/EvhXEzwABZXhvS+R3dgGg0INexMCZ9Qu6
 Y9PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775503309; x=1776108109;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xz/PrIKr78Lq5gz51kg7YWKzaG9j6PB5MtE7hX+/bxg=;
 b=HB/ejI2P/pxo8qgj1ep/jt8e1u65hVM4V4fyhGAe+lRt1yxnTEaQ9CO2N4zms+A/75
 zVYEk9MXuv3gklqgvxGbjf2B5RSxg676bHjCmZWomoTZiApIwq5iSfq0UHDnYr9qnOKf
 37Pd4Aw86EB5w9jQtuEIneH7nTJBPBTa2N3qCBiqOMjaATH90KpVbUZyjL1egCTwKO7V
 9Cnf11aaKpqfsrZBVY/LfImx3SFSuy8zAwi5/TYDFVmn2eVmzb9LlTUT45aiVIRQqLiJ
 9JC4WA85IU/bwpEmnoli6pKRw4YXbkRDD4tTV6bnFhwzdYsXycZWwImhusBOrCBzhRES
 b55g==
X-Gm-Message-State: AOJu0YxQGYYYOUbnx3tqJSYOLDQu1EmFVLRjS1fdvSWLgbNNm4ZbKI0F
 dVcb0hStI6LLmG199zVAc+AN1USnl5RxJXPrsWW5N+jjs3NSYdJ7cmgWm+MVj211
X-Gm-Gg: AeBDietgzph8VGrp83UB5WxtKoRY49GbGyIw68hVBkpywIDfoQJVoLcbERA0FkyKRoD
 XfNi1hu5G/r6KC108tsmzlvMSwqHut8PSM+Lz+61rdPlEqScmBPV/Jmlrc1OQ8uyVo1QXgLT26v
 qPD7eKYHC/8qoMh9NTUbI405J2lNSLLuuoGFD+RGbjkgoQsfj3xpmiqA5jMikuKoDuwI9P4dbQh
 koMWGCiJJeZs/nq1yEc85frgeAnC8cU7Bd6+bb6pPZzvvFb7nqX9KdJfSb/kSV3gvf5gBei/KvY
 OLdaxjYRXLSNauP3lVF6gvAbH0DtiOzABsvqX5ZQhkmFOh/CKrYTCDy8B4kYXxIl/2BlKhvWHGJ
 CXgi+bugbFeLbvwSkH6HJiMdFHJCDMdFcFNj4p5dmj/8ULsV9ZGE5WwQXX2RHeZksTlCDL/kkag
 9qYsRjPm8EihG5pBvGFzD4qXjPcu1Sgao2qg==
X-Received: by 2002:a05:622a:a948:10b0:50b:3788:ab58 with SMTP id
 d75a77b69052e-50d62773555mr160034921cf.17.1775503308923; 
 Mon, 06 Apr 2026 12:21:48 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8a596e03dc6sm150191166d6.34.2026.04.06.12.21.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 12:21:48 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: u-boot@lists.denx.de
Cc: malysagreg@gmail.com, trini@konsulko.com, linux@analog.com,
 philip@philipmolloy.com, Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [PATCH v3 11/13] configs: sc5xx: Set default bootcmd to SPI boot
Date: Mon,  6 Apr 2026 15:06:13 -0400
Message-Id: <2b52413bc911875732ac02f860d92dee317c64a1.1775500819.git.jcethrid@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1775500819.git.jcethrid@gmail.com>
References: <cover.1775500819.git.jcethrid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 06 Apr 2026 21:46:28 +0200
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

From: Caleb Ethridge <caleb.ethridge@analog.com>

Align configs to use the same default bootcommand.

Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>
---
 configs/sc589-ezkit_defconfig          | 2 +-
 configs/sc589-mini_defconfig           | 2 +-
 configs/sc594-som-ezkit-spl_defconfig  | 2 +-
 configs/sc594-som-ezlite-spl_defconfig | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/configs/sc589-ezkit_defconfig b/configs/sc589-ezkit_defconfig
index e4fe4db774f..fbf29ac32bb 100644
--- a/configs/sc589-ezkit_defconfig
+++ b/configs/sc589-ezkit_defconfig
@@ -22,7 +22,7 @@ CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="run ramboot"
+CONFIG_BOOTCOMMAND="run spiboot"
 CONFIG_SYS_CBSIZE=512
 CONFIG_CYCLIC_MAX_CPU_TIME_US=1000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
diff --git a/configs/sc589-mini_defconfig b/configs/sc589-mini_defconfig
index ebc9761607a..d812e6ec4fa 100644
--- a/configs/sc589-mini_defconfig
+++ b/configs/sc589-mini_defconfig
@@ -20,7 +20,7 @@ CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="run ramboot"
+CONFIG_BOOTCOMMAND="run spiboot"
 CONFIG_SYS_CBSIZE=512
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_I2C=y
diff --git a/configs/sc594-som-ezkit-spl_defconfig b/configs/sc594-som-ezkit-spl_defconfig
index ef23b97b89c..cbed13bbf0d 100644
--- a/configs/sc594-som-ezkit-spl_defconfig
+++ b/configs/sc594-som-ezkit-spl_defconfig
@@ -15,7 +15,7 @@ CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="run ospiboot"
+CONFIG_BOOTCOMMAND="run spiboot"
 CONFIG_SYS_CBSIZE=512
 CONFIG_SPL_I2C=y
 CONFIG_SPL_DM_SPI_FLASH=y
diff --git a/configs/sc594-som-ezlite-spl_defconfig b/configs/sc594-som-ezlite-spl_defconfig
index 05711b85824..9c3f400f8c5 100644
--- a/configs/sc594-som-ezlite-spl_defconfig
+++ b/configs/sc594-som-ezlite-spl_defconfig
@@ -18,7 +18,7 @@ CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="run ospiboot"
+CONFIG_BOOTCOMMAND="run spiboot"
 CONFIG_SYS_CBSIZE=512
 CONFIG_CYCLIC_MAX_CPU_TIME_US=1000
 CONFIG_SPL_I2C=y
-- 
2.34.1

