Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A290FF885A
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 22:34:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F423B842E7;
	Sun, 26 Apr 2026 00:34:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hMde7bjc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7D9384376; Sat, 25 Apr 2026 23:31:00 +0200 (CEST)
Received: from mail-dl1-x1241.google.com (mail-dl1-x1241.google.com
 [IPv6:2607:f8b0:4864:20::1241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1DF38407E
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 23:30:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-dl1-x1241.google.com with SMTP id
 a92af1059eb24-12c637089ccso11171625c88.1
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 14:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777152657; x=1777757457; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bc6d6jriUzP78hbCPqkj8Cix2YelQeCkUK+GUtgCJnk=;
 b=hMde7bjcaTx8SdRKKlaUjLYqae6II+K347Kmxn83d+i0U60bvqAMB8/Z0Ktd6tKLuu
 fD158UujMoBXU9woIb4xGkNXE6eN/V4GJ5smO629dCPYcuYZ4GsM7kIi8ePea+hq25Z8
 ctBVzdfKraaEJgaMcFZNJWTtRtU5ku1kocyZJhFXKKXiSBg2kwjpiDy8pf1pywxkFf7D
 Z5VWBEbMyoh759OcefWYGFWQgktPxGiSrbnVry/Fik1IKui46xWcxedtICXyMC+PngRg
 myY5bWGTYb7Kh7Clr5j31yeuHxMf/pT2c6X2VPAfhi/u26hTfAeV8qn6agK9cilLFsmV
 /hKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777152657; x=1777757457;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Bc6d6jriUzP78hbCPqkj8Cix2YelQeCkUK+GUtgCJnk=;
 b=IdJILKxQ7BoPb4ayMw4StHzr0DjIF3GeIjQovqveqMED6guAjref+y3DFQpBlzUg9Z
 eRPUe7eWp+QW25UrzQKwkKRNrnvH2mmQY60sPWr2J0BpcUrnWB9tXrfYQ2jfcl2WCHuv
 5hfBNc+dAuJMB/si4YJRHuhA4cd9Ls3cfcmQqVdLwPBQTpnD2E8NAFGG+50PZvdTUJJo
 YVgYnR/0etGuRYADdzCJHZspxATIMr/YyaVflYtmymvv82wbFPsOgPCf9/adv0k6gJ64
 Dj1BVmUFDTJZB+6in0VxogVORrkLLjeMt/jLQu8qkg6Nw4oNENEC90aQujAshBn3LrT1
 1gBw==
X-Gm-Message-State: AOJu0YwaFH4NMe834PnfwKhA5c/yY2MjrVL5JpQW55phOjX0SG+u3cHv
 T/argegWrjLzy5aW6MM1/3R7gIaL6IF9lvH34O9LbWzpAwMwzGNg3FjVV+lbBKi9
X-Gm-Gg: AeBDiesZp3MpGr+bBZPI2RpHZABJC6WdFkORHA2yrI+EQmQkywsbgM2FYYkVEETs5c+
 880pBfhg+stD9ave5NDeL5wIrAveCaF1CvOn++ymqd/DZmtpr9YC0Mw9RlVhVMFUBvtRtCJVHpi
 r3KQoyJS1b6QJ3HozyCQSqYapbqKm5eJ9+WgyI6PHkpr5Am93g7CuyScwT+ZoFwGO1ZsOzFLK2w
 7Xxm2Uy5mEpHp7dEX1GO4T7lZGebWsCyU2LTLuCGPaXoFT6KgZMpn4eoUfi/m+/WH3LZEIlkN+x
 LBa2hYHLsa+zkCUTro4GBq0AG4GU5tIxekZ1hskLzUxpiDXjgYi8jfsB2E7kH5/96mQPG6Y4s8d
 ggR8CKk9ar6DkAqMrSkfUcLLWJJPaDjjM/gWb01FR+yrYAKeSzNzzmcGD1vG0eg88MZTV9dkMSb
 ANbY/L0gCzTzTH00BKFRZANsQ67vC8Wwl673gHvrSrOVFM
X-Received: by 2002:a05:6102:5:b0:61d:8fd9:fb26 with SMTP id
 ada2fe7eead31-61d8fd9fb77mr4216074137.7.1776954353429; 
 Thu, 23 Apr 2026 07:25:53 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b02aa4f1f9sm157183266d6.0.2026.04.23.07.25.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 07:25:53 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: u-boot@lists.denx.de
Cc: malysagreg@gmail.com, trini@konsulko.com, linux@analog.com,
 philip@philipmolloy.com, sjg@chromium.org,
 Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [PATCH v5 11/15] configs: sc5xx: Set default bootcmd to SPI boot
Date: Thu, 23 Apr 2026 10:24:46 -0400
Message-Id: <5d645926dd3c38d172b6bf28b4ee7ff8981ad865.1776954004.git.jcethrid@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1776954004.git.jcethrid@gmail.com>
References: <cover.1776954004.git.jcethrid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 26 Apr 2026 00:34:30 +0200
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
index a249fe8df7b..d8982f62d82 100644
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
index 25285695367..78b39b6dd73 100644
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
index 89ef08c1a72..23951d0b5f1 100644
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
index 9e907d31136..b4e71b5d2eb 100644
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

