Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BD00CE79C2
	for <u-boot@archiver.kernel.org>; Wed, 20 Sep 2023 10:49:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67D6386BFF;
	Wed, 20 Sep 2023 12:49:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FcVYoEaP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E17886C3C; Wed, 20 Sep 2023 12:49:30 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F350C86AEE
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 12:49:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-6bf3850bcd2so760870a34.1
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 03:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695206966; x=1695811766; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PfEosW7KxOJtPQHc2tBdv6sRFBPV50J+ciKOlUy6RG0=;
 b=FcVYoEaPhXSGGSdyELZYpbju+bBXxRwekaWmG7zy6yIGt9sUzRlWLlhnChCwG3CekX
 THtI///+mlSUm8uQSbLjQhgUgIwgN96C16SvRUZ9CIANcnDNGu1xEKN+SG03aM/miwt0
 wa2ic5qouV6vKcB1Asmyj1v57rWKG3RqN04PApMyPg7PiqZN2QI4RAqIXtLYIETrnMp5
 oi80MTxgYD3z6UDYZ4Ckdy0N0em3QYXVn5EaICn4yHG0f0tYgxvTEWKgyT91bp1kCjIx
 RZIHz6nVvxjhwa3VxX/VFSooU9NUKjDCjAdLPXjFY3vI7e8rnWrD2iMgRqoKm29XsGYu
 FOCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695206966; x=1695811766;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PfEosW7KxOJtPQHc2tBdv6sRFBPV50J+ciKOlUy6RG0=;
 b=nSOmgSmHjMq1tgItC2khTNsdF8zWpkNaM9fjQmAh1Gust1c8+RtrjjybHZbcMioTgG
 A0X8Yf67ocQSt56714Kvp5wqIrRE1e8oz4uxbi3g/X5WV5itiJvaT8j9hNVbdEDaaghK
 ELI7xJTLCE505cf2ipLAEysCIp8mX0wk0q1gikiWF3mfwrROnnFzVQNvGmQAtd3/BZhX
 Zg/YA8QSGEfkDRVOn/eBoK79f8Rv6OUBYi97JVmFcYTbLEThmeyAhz2SHmoqqMxr8H6F
 fbjMJffVmShx94Ze+VCPH70+Uyut9+n7QaRnvgT3z/GleBsIogPF/Lmq1hv55L8F+4de
 aWuQ==
X-Gm-Message-State: AOJu0Yy/a8ykjSOLcm+xrrHNPE7XzZqQTDrkEvK8l4D4bbSFzut7ypQR
 ls+lc+8EGm4wJgWqZVC/868=
X-Google-Smtp-Source: AGHT+IFzIYI8zH35/gkMLh2efD8lXzA8RkZyXZ+uFC+f1aC7qTcFOSUOD5h7GFHD4odME0bsG+Ontg==
X-Received: by 2002:a05:6870:c6a9:b0:1d0:e372:6cf8 with SMTP id
 cv41-20020a056870c6a900b001d0e3726cf8mr2531935oab.2.1695206966475; 
 Wed, 20 Sep 2023 03:49:26 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:7290:a7f7:69b2:711b])
 by smtp.gmail.com with ESMTPSA id
 lg20-20020a0568700b9400b001d6631fd08fsm5659985oab.47.2023.09.20.03.49.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Sep 2023 03:49:26 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: sbabic@denx.de
Cc: u-boot@lists.denx.de, Eduard Strehlau <eduard@lionizers.com>,
 Fabio Estevam <festevam@denx.de>
Subject: [PATCH] smegw01: Use CONFIG_SYS_LOAD_ADDR for loading fitImage
Date: Wed, 20 Sep 2023 07:49:08 -0300
Message-Id: <20230920104908.4117686-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
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

From: Eduard Strehlau <eduard@lionizers.com>

Set CONFIG_SYS_LOAD_ADDR=0x88000000 and use this address for
loading fitImage.

Also pass the standard CONFIG_BOOTFILE option to indicate
the fitImage file.

Signed-off-by: Eduard Strehlau <eduard@lionizers.com>
Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 board/storopack/smegw01/smegw01.env | 14 +++++++-------
 configs/smegw01_defconfig           |  3 +++
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/board/storopack/smegw01/smegw01.env b/board/storopack/smegw01/smegw01.env
index 1263ddac8ed0..528310dd810f 100644
--- a/board/storopack/smegw01/smegw01.env
+++ b/board/storopack/smegw01/smegw01.env
@@ -48,13 +48,8 @@ commit_mmc=
 		saveenv;
 	fi;
 console=ttymxc0
-fdt_addr=0x83000000
-fdtfile=imx7d-smegw01.dtb
-fit_addr=0x88000000
-image=fitImage
-loadaddr=0x80800000
 loadbootpart=mmc partconf 1 boot_part
-loadimage=load mmc ${mmcdev}:${gpt_partition_entry} ${fit_addr} boot/${image}
+loadimage=load mmc ${mmcdev}:${gpt_partition_entry}
 loadpart=gpt setenv mmc ${mmcdev} rootfs-${mmcpart_committed}
 mmcargs=
 	setenv bootargs console=${console},${baudrate} root=/dev/mmcblk${mmcdev}p${gpt_partition_entry} rootwait rw SM_ROOT_DEV=${mmcdev} SM_ROOT_PART=${gpt_partition_entry} SM_BOOT_PART=${boot_part}
@@ -71,8 +66,13 @@ mmcboot=
 	else
 		run altbootcmd;
 	fi;
+#ifdef CONFIG_SYS_BOOT_LOCKED
+	hab_auth_img ${fileaddr} ${filesize};
+#else
+	hab_auth_img_or_fail ${fileaddr} ${filesize};
+#endif
 	run mmcargs;
-	if bootm ${fit_addr}; then
+	if bootm; then
 		;
 	else
 		run altbootcmd;
diff --git a/configs/smegw01_defconfig b/configs/smegw01_defconfig
index 7f1b2bee8e16..616038387e27 100644
--- a/configs/smegw01_defconfig
+++ b/configs/smegw01_defconfig
@@ -14,6 +14,7 @@ CONFIG_ARMV7_BOOT_SEC_DEFAULT=y
 CONFIG_IMX_RDC=y
 CONFIG_IMX_BOOTAUX=y
 CONFIG_IMX_HAB=y
+CONFIG_SYS_LOAD_ADDR=0x88000000
 CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0xa0000000
 CONFIG_FIT=y
@@ -54,6 +55,8 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_ENV_WRITEABLE_LIST=y
 CONFIG_ENV_ACCESS_IGNORE_FORCE=y
+CONFIG_USE_BOOTFILE=y
+CONFIG_BOOTFILE="boot/fitImage"
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_BOUNCE_BUFFER=y
 CONFIG_BOOTCOUNT_LIMIT=y
-- 
2.34.1

