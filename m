Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E17FECE7A9D
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 16:33:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59EFD86B4E;
	Mon, 25 Sep 2023 18:33:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HYdQsDzH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63F8E86ADA; Mon, 25 Sep 2023 18:33:26 +0200 (CEST)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EC0A86BCF
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 18:33:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1c5faa2af60so6856045ad.0
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 09:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695659600; x=1696264400; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QpH1SCA3IQGuACjlnZVeqMEb2LF9+aowfuzNVXi7BRc=;
 b=HYdQsDzHdSaYd6yVlBICoYyYaxLhQu6lIp4uEDUMmJEzxd98Ql4QBdRWEfCFtQbSxs
 Cqo4qGSm7KtxWnqSi5At2Lz7ffmsZR7XQFDVDb9zso4l5QOjngA9BGQc0/ZPcRYMx/l9
 69PcXDKxhfPim1Ol+p4fxcAIHmDsasOZI/y0hPdVd+JGLLGuSb/NkTa8fSvNIJ86zmJK
 aqbTq0jYeWN5KazXgugr7zAo4aLjA9miN04gF0gdhmFk5nmJjfF5oYRCd7vIvAcs/X7+
 pheebIrqPDHMWbNVeBzM4uHaOeya+UY08KflCUQIhAJtrhpE3pO6FIs27AYINchmQTc+
 EYwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695659600; x=1696264400;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QpH1SCA3IQGuACjlnZVeqMEb2LF9+aowfuzNVXi7BRc=;
 b=ETGWgjwTOGKZ1FYdwdwoiOQywiD78Brp4L1Khok/7Zal+vhp3acvn6I6/NLjDrg+Tl
 IwKynbJLtamvEyOfRWS3LRZOg/t5QbB+SX9U95Qt5fO6hvhzIbNYM+hnIKZS0jGNw63R
 mG3DVPbXQC9j036uBG5ZQFwfX1to7qhJ8+0QEY8tTOeBd8mfzDhONDcZbwV2VoMrgAeY
 gFkjPSDjJuwqcR2nQHlh2RQHMqhq8ZRDF1lpXtUUYg7MFGyvbdEn11McNMx8k5ubVE67
 y8bbbVzKSKeu3EkzwLOVky4a76F3uI8Ldh+xxIGDgQUsTUMti9hYxY/G17tMbvuHDTYx
 QOvw==
X-Gm-Message-State: AOJu0YzSEvtvfc66IVInbestxUpMHVs2ptMYS9MRr4uNmBuOhBVJVRCk
 cOXHofcV28J0qQyaUdRTcasdEVf8CJ0=
X-Google-Smtp-Source: AGHT+IFv7Yo2AV9mUPl6XEUOwTForB8msJAX1Pt6DZ5fX2wDRGUT3FjI5P3lD26B5ILDfdYMAHDBxg==
X-Received: by 2002:a17:902:d2ce:b0:1c3:8dbe:aecb with SMTP id
 n14-20020a170902d2ce00b001c38dbeaecbmr9263023plc.2.1695659600335; 
 Mon, 25 Sep 2023 09:33:20 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:5f5a:749e:ff1d:22f3])
 by smtp.gmail.com with ESMTPSA id
 jb22-20020a170903259600b001bd41b70b60sm9102217plb.45.2023.09.25.09.33.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 09:33:19 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: sbabic@denx.de, eduard@lionizers.com, u-boot@lists.denx.de,
 Fabio Estevam <festevam@denx.de>
Subject: [PATCH] smegw01: Fix inverted CONFIG_SYS_BOOT_LOCKED logic
Date: Mon, 25 Sep 2023 13:32:59 -0300
Message-Id: <20230925163259.9442-1-festevam@gmail.com>
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

CONFIG_SYS_BOOT_LOCKED means that a restricted boot environment will
be used. In this case, hab_auth_img_or_fail should be called to prevent
U-Boot to continue running when the fitImage authentication fails.

Fix the logic accordingly.

Additionally, select CONFIG_SYS_BOOT_LOCKED by default.

Signed-off-by: Eduard Strehlau <eduard@lionizers.com>
Signed-off-by: Fabio Estevam <festevam@denx.de>
---
Hi Tom,

We have just identified this bug.

Could you please pick this one directly for U-Boot 2023.10?

Thanks

 board/storopack/smegw01/smegw01.env | 4 ++--
 configs/smegw01_defconfig           | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/board/storopack/smegw01/smegw01.env b/board/storopack/smegw01/smegw01.env
index 528310dd81..93de866910 100644
--- a/board/storopack/smegw01/smegw01.env
+++ b/board/storopack/smegw01/smegw01.env
@@ -67,9 +67,9 @@ mmcboot=
 		run altbootcmd;
 	fi;
 #ifdef CONFIG_SYS_BOOT_LOCKED
-	hab_auth_img ${fileaddr} ${filesize};
-#else
 	hab_auth_img_or_fail ${fileaddr} ${filesize};
+#else
+	hab_auth_img ${fileaddr} ${filesize};
 #endif
 	run mmcargs;
 	if bootm; then
diff --git a/configs/smegw01_defconfig b/configs/smegw01_defconfig
index 616038387e..03d403ddc8 100644
--- a/configs/smegw01_defconfig
+++ b/configs/smegw01_defconfig
@@ -7,7 +7,7 @@ CONFIG_ENV_OFFSET=0x100000
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="imx7d-smegw01"
 CONFIG_TARGET_SMEGW01=y
-# CONFIG_SYS_BOOT_LOCKED is not set
+CONFIG_SYS_BOOT_LOCKED=y
 CONFIG_ENV_OFFSET_REDUND=0x110000
 CONFIG_ARMV7_BOOT_SEC_DEFAULT=y
 # CONFIG_ARMV7_VIRT is not set
-- 
2.41.0

