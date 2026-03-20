Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2921D1098782
	for <u-boot@archiver.kernel.org>; Fri, 20 Mar 2026 13:08:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94B2C840A9;
	Fri, 20 Mar 2026 14:06:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nsac7wQZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5066D83D71; Fri, 20 Mar 2026 13:53:04 +0100 (CET)
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com
 [IPv6:2607:f8b0:4864:20::f44])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9553883CEA
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 13:53:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-qv1-xf44.google.com with SMTP id
 6a1803df08f44-89a05955720so19062846d6.2
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 05:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774011180; x=1774615980; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+y6ke/6p9bjTVu9WzGii8xrtjIY8oLvlx5CL5ZBKuPA=;
 b=nsac7wQZbIOxrrnX/AdvyZDpkwylmrXm7J/b31RwXrqZqvWZm57W4OUq+W3Ikb2fV+
 muEyQjZSwTJ3X3dhb6uVbqh3IVhiCd84Xr20mh+J7esLoyuac9mj3PPkrVPODTUK5Bk3
 8DWDmEj5JbGoIAjM25Ihv4xKozKw0Bw/lbk26poZRbxgm+J8hEIMbnVEZtnUd+7qARWc
 vAtWJ92PgQv8a9QsHGvdFdZ6aRx3E56ilnWpp7LKVNBkNmaeIKodhUoSsc423XgAhPBW
 qwxC6qyGcxO4FomW+Y3H9BLNY7jjs687OVfJPXgoINu/+PMqhsX5CiRiFkj6osNwLqd7
 koVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774011180; x=1774615980;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+y6ke/6p9bjTVu9WzGii8xrtjIY8oLvlx5CL5ZBKuPA=;
 b=QGlSeueAFJ/OtQVoFCRKxuP4oXILH7x1Erqlzunm/y56we+WtpOeLsQsfzIw8l8AMS
 sCks5zlE22hfyDn/EhlTHoh5k12iz3vGiFu3uHYM/8Dg8gPOWPgjNAAmRA3PQvVxps0z
 xaM+Qma/Hry5NxIUvmGtvVCuTHz4Il4+Ydb+i18WMM+PZ8PA+F2A1WenQO3TkJ8Aj9Dk
 e7WLMME5tAjAa/q/Ekv2i+A10ywscW9N0wVntZEuMNXhM+13I0O3YK1tiR+iEwrZp8q9
 trtEc32CbDf+su+BCZhcI+dV0HuSzcK3Ragr9kjbLwQd6Y2bS62qk7MqLRQjP1lyW00s
 /eIA==
X-Gm-Message-State: AOJu0YzFfh95i9eabyfTzER4Xyif85uQeqm4/Bf0y1EJd+BfxM+ZJRtO
 ewdM87oJ2uvhJj4R8C4wYu/F4xVo7M97xWdTnG25gjIzH0oFwHYi493zOGbtzBEVQz6UUg==
X-Gm-Gg: ATEYQzw1rFs1q3ebdAk/pJJvTOQZNelGLMSYAmSVLPEPJal8bqVp3RxzoLxbQlJgDC5
 +LS9YMHsxkrd//P6avmqXBlFlGRqKCuTibq1XrNeCYJw1iak6i3/IRCGswMN9UoKxFX5fdrw9n7
 tt/73XZNlljnK4RKFmKv244iRfX77z7c8B/PYUXyMDCj9zoMZafN8FiL/Tx4ze9xyLp/0V3gT0j
 AdcG1sDNkkjsIdrsAl2Bg/kh+Q1Eg95grrcbZ38RAmb7bzmi7YSFjpM6leMSY8ITbdhEuwTo5b3
 Fgp9kPmbWQ72sCIRppFYkaQEjgk8vkMON6V5cGduhz2IELfBmI4F02cPTofAZ/0+6gIRC18rXdZ
 6im+YzJyRdF/KcIZcgwCF8Z3RE+z5FH8859tEm+EDOOrSMChMarCadn9CBUk85wYq4GOBHlbb4n
 +HfA8dQedTCmlAxS8+Qiq+rx5hFW6BUH3MnQ==
X-Received: by 2002:a05:6214:4598:b0:89c:69be:2c43 with SMTP id
 6a1803df08f44-89c859cea72mr45658096d6.15.1774011180241; 
 Fri, 20 Mar 2026 05:53:00 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89c8537c3b5sm19168166d6.47.2026.03.20.05.52.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 05:52:59 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: u-boot@lists.denx.de
Cc: malysagreg@gmail.com, philip@philipmolloy.com, trini@konsulko.com,
 linux@analog.com, Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [PATCH 11/11] configs: sc5xx: Set default bootcmd to SPI boot
Date: Fri, 20 Mar 2026 08:50:26 -0400
Message-Id: <c285988ef1556435b9139e3080284c9417ba75fd.1774008927.git.jcethrid@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1774008927.git.jcethrid@gmail.com>
References: <cover.1774008927.git.jcethrid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 20 Mar 2026 14:06:14 +0100
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
index 334dbc9e700..a7911e9369f 100644
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
index e6f061c9496..566769e8cee 100644
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
index 2d673f6357f..d467f4bd44e 100644
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
index e33cf682a7a..c703d12a76d 100644
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

