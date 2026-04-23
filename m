Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2785DFF885C
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 21:08:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C2F28435B;
	Sat, 25 Apr 2026 23:08:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FCYJPeq6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BCD084534; Sat, 25 Apr 2026 22:48:12 +0200 (CEST)
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com
 [IPv6:2607:f8b0:4864:20::f44])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B76584540
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 22:48:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-qv1-xf44.google.com with SMTP id
 6a1803df08f44-8aca6bd57cfso84550686d6.0
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 13:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777150089; x=1777754889; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+6gUZivq8PD3uTPMd+4hu8dE2KyTc38gDyskWGzZWwI=;
 b=FCYJPeq6qSxNPP75yprCuk98hTNN4moj0LK5bL1Rm47SAqxlnYoAXDxGxsAZ//Xsh+
 bxufmY2XQn73XFrZ6FcsVwZmiEW3tnoe3gH0poTqAW5YyiO3UZoBQB9PiTa1W979LkRE
 UmSTwpwyttwj3iCeEiW0EVVGHNKljjhUUGHaucqViii456OWFtd+x9wzaLFkoWaa8vjK
 vpmvuj37jsrFu40mbHdUEV9ecLhfcPwTV49TmB1wrPgb3w5jOLjRIcXeAOkCPoiXW2zO
 9+niNB5jhB8T2T2Coyy37OAXMwIu6hrtRfkamYMWAe9tIsW4dW+btdYsK6YPlqa8CNQS
 SgSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777150089; x=1777754889;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+6gUZivq8PD3uTPMd+4hu8dE2KyTc38gDyskWGzZWwI=;
 b=af7uv5H0C0rULFYUZA5aXg90Nnu9fp6b3nwQsduVathlVhBwi9TPU89uLbNMIc+I/6
 9er4qw9Llhg4IcuZ0qpEiihUnw8a7vSIjbN3ONOWyqcC6YlMeM395ID5+zZ2q13vnvIs
 ON/ywMIQ397/etk6FMF6VeKNQ/DNHSwW00EEei6xo6iCYvHbRUEN7OmYnnVuvAswTM6c
 4uzRXarB3nSeYYyoi3IPw86LO95vh9EagShS4LViVwUi8tnhPiHvrHY1yaGXeE28pyZ6
 4kynGqHh/Kpe7B5gfQd4tAUnOQL9Blv34SE8xOtsEvnKYJpYmzA3ZyfT8jktiDaoVidE
 A8Pg==
X-Gm-Message-State: AOJu0YxlJuas7/PzLffxvAj2dAi8rXKSRQgRehfSwLaP1EHL/iiSNbE4
 D/xH/stg5V4ZT2pJ+xRT6eCWSV+Tn3IwGW3pid6eo5XW1ZrDcP5kUjwa1XlVeoZn
X-Gm-Gg: AeBDies7MOsQhPInBEK1eQGUTQpQLImiO6Z17iMFnsycx9v2dsAhaKGWaU5RKcZTDK2
 5645cB9l0/dAnlsbz3VYcrVRFta+0fTwHP8Aj+ByyEqbiAlKkRPbFPxB/Z0SeyfQAYrEyGWUvhk
 uQSQLchCc9CVBpZC1QpaOYOUDowwy3YTqc3D3w5VsudyBwae5P2FZ5EJxF9CYxUrGJ1xMYOOgz3
 Ewxbe57qpUxUwIE2CLwVS/k9NRHa+sDaHTsoLR3lDpuAbtEpoxTDRGIHhRDnoLCnRRoCb9PgzNh
 t7MJiwSzJ68OCG8CPhPpHiKd2JX+cvOZs9q8SRyrH57W0Zh3hrLzKksO1LxzbAqFowr4wi2AZku
 urkZ+5ULsJpjHwv6JZ/IYLfVLO1oWHMrVTkNNXxuGrkDodcfYclxEsB1rUDySVZDaCu/Mcgrv4y
 1GT8NqRuqx1PnoZZsgTYU205FlVPaK/w/kanoA7NFmKVVK
X-Received: by 2002:a05:6214:2f0e:b0:89c:4cac:74c5 with SMTP id
 6a1803df08f44-8b0280f81aemr407391126d6.25.1776954311780; 
 Thu, 23 Apr 2026 07:25:11 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b02aa4f1f9sm157183266d6.0.2026.04.23.07.25.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 07:25:11 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: u-boot@lists.denx.de
Cc: malysagreg@gmail.com, trini@konsulko.com, linux@analog.com,
 philip@philipmolloy.com, sjg@chromium.org,
 Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [PATCH v5 01/15] configs: sc5xx: Do not store environment in SPI flash
Date: Thu, 23 Apr 2026 10:24:36 -0400
Message-Id: <d86949c4ae8dd1314af7537c5799c7b92ddc17cb.1776954004.git.jcethrid@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1776954004.git.jcethrid@gmail.com>
References: <cover.1776954004.git.jcethrid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 25 Apr 2026 23:08:00 +0200
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

Remove config option enabling storage of the environment
in the SPI flash, to match shift of programming boot media
to Linux.

Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>
---
 configs/sc573-ezkit_defconfig          | 4 ----
 configs/sc584-ezkit_defconfig          | 5 -----
 configs/sc589-ezkit_defconfig          | 5 -----
 configs/sc589-mini_defconfig           | 5 -----
 configs/sc594-som-ezkit-spl_defconfig  | 4 ----
 configs/sc594-som-ezlite-spl_defconfig | 4 ----
 configs/sc598-som-ezkit-spl_defconfig  | 4 ----
 configs/sc598-som-ezlite-spl_defconfig | 4 ----
 8 files changed, 35 deletions(-)

diff --git a/configs/sc573-ezkit_defconfig b/configs/sc573-ezkit_defconfig
index fc4ce13cc70..976d8e0306a 100644
--- a/configs/sc573-ezkit_defconfig
+++ b/configs/sc573-ezkit_defconfig
@@ -3,9 +3,6 @@ CONFIG_SYS_ARM_CACHE_WRITETHROUGH=y
 CONFIG_ARCH_SC5XX=y
 CONFIG_SYS_MALLOC_LEN=0x100000
 CONFIG_SPL_GPIO=y
-CONFIG_ENV_SIZE=0x4000
-CONFIG_ENV_OFFSET=0xD0000
-CONFIG_ENV_SECT_SIZE=0x4000
 CONFIG_DM_GPIO=y
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x10000
 CONFIG_SPL_SERIAL=y
@@ -52,7 +49,6 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_EMBED=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_USE_HOSTNAME=y
 CONFIG_HOSTNAME="sc573-ezkit"
 CONFIG_NET_RETRY_COUNT=20
diff --git a/configs/sc584-ezkit_defconfig b/configs/sc584-ezkit_defconfig
index a8c6b9f1224..27f55804199 100644
--- a/configs/sc584-ezkit_defconfig
+++ b/configs/sc584-ezkit_defconfig
@@ -3,9 +3,6 @@ CONFIG_SYS_ARM_CACHE_WRITETHROUGH=y
 CONFIG_ARCH_SC5XX=y
 CONFIG_SYS_MALLOC_LEN=0x100000
 CONFIG_SPL_GPIO=y
-CONFIG_ENV_SIZE=0x4000
-CONFIG_ENV_OFFSET=0xD0000
-CONFIG_ENV_SECT_SIZE=0x4000
 CONFIG_DM_GPIO=y
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x8000
 CONFIG_SPL_SERIAL=y
@@ -57,8 +54,6 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_EMBED=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_ENV_SPI_MAX_HZ=10000000
 CONFIG_USE_HOSTNAME=y
 CONFIG_HOSTNAME="sc584-ezkit"
 CONFIG_NET_RETRY_COUNT=20
diff --git a/configs/sc589-ezkit_defconfig b/configs/sc589-ezkit_defconfig
index 9cd204e40ab..180b6904d95 100644
--- a/configs/sc589-ezkit_defconfig
+++ b/configs/sc589-ezkit_defconfig
@@ -5,9 +5,6 @@ CONFIG_SYS_MALLOC_LEN=0x100000
 CONFIG_SPL_GPIO=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xC203F000
 CONFIG_SF_DEFAULT_SPEED=1000000
-CONFIG_ENV_SIZE=0x4000
-CONFIG_ENV_OFFSET=0xD0000
-CONFIG_ENV_SECT_SIZE=0x4000
 CONFIG_DM_GPIO=y
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x8000
 CONFIG_SPL_SERIAL=y
@@ -61,8 +58,6 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_EMBED=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_ENV_SPI_MAX_HZ=10000000
 CONFIG_USE_HOSTNAME=y
 CONFIG_HOSTNAME="sc589-ezkit"
 CONFIG_NET_RETRY_COUNT=20
diff --git a/configs/sc589-mini_defconfig b/configs/sc589-mini_defconfig
index 0908ab1708b..92c2741f701 100644
--- a/configs/sc589-mini_defconfig
+++ b/configs/sc589-mini_defconfig
@@ -4,9 +4,6 @@ CONFIG_ARCH_SC5XX=y
 CONFIG_SYS_MALLOC_LEN=0x100000
 CONFIG_SPL_GPIO=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xC203F000
-CONFIG_ENV_SIZE=0x10000
-CONFIG_ENV_OFFSET=0xD0000
-CONFIG_ENV_SECT_SIZE=0x10000
 CONFIG_DM_GPIO=y
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x8000
 CONFIG_SPL_SERIAL=y
@@ -58,8 +55,6 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_EMBED=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_ENV_SPI_MAX_HZ=10000000
 CONFIG_USE_HOSTNAME=y
 CONFIG_HOSTNAME="sc589-mini"
 CONFIG_NET_RETRY_COUNT=20
diff --git a/configs/sc594-som-ezkit-spl_defconfig b/configs/sc594-som-ezkit-spl_defconfig
index c62097a2ac9..c379de2c146 100644
--- a/configs/sc594-som-ezkit-spl_defconfig
+++ b/configs/sc594-som-ezkit-spl_defconfig
@@ -4,9 +4,6 @@ CONFIG_ARCH_SC5XX=y
 CONFIG_SYS_MALLOC_LEN=0x100000
 CONFIG_SPL_GPIO=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x8203f000
-CONFIG_ENV_SIZE=0x20000
-CONFIG_ENV_OFFSET=0x100000
-CONFIG_ENV_SECT_SIZE=0x20000
 CONFIG_DM_GPIO=y
 CONFIG_SPL_DM_SPI=y
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x10000
@@ -40,7 +37,6 @@ CONFIG_CMD_EXT4=y
 CONFIG_CMD_FAT=y
 CONFIG_OF_EMBED=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_USE_HOSTNAME=y
 CONFIG_HOSTNAME="sc594-som-ezkit"
 CONFIG_NET_RETRY_COUNT=20
diff --git a/configs/sc594-som-ezlite-spl_defconfig b/configs/sc594-som-ezlite-spl_defconfig
index 39481351102..54b26ed85c2 100644
--- a/configs/sc594-som-ezlite-spl_defconfig
+++ b/configs/sc594-som-ezlite-spl_defconfig
@@ -3,9 +3,6 @@ CONFIG_SYS_ARM_CACHE_WRITETHROUGH=y
 CONFIG_ARCH_SC5XX=y
 CONFIG_SYS_MALLOC_LEN=0x100000
 CONFIG_SPL_GPIO=y
-CONFIG_ENV_SIZE=0x20000
-CONFIG_ENV_OFFSET=0x100000
-CONFIG_ENV_SECT_SIZE=0x20000
 CONFIG_DM_GPIO=y
 CONFIG_SPL_DM_SPI=y
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x10000
@@ -45,7 +42,6 @@ CONFIG_CMD_FAT=y
 # CONFIG_DOS_PARTITION is not set
 CONFIG_OF_EMBED=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_USE_HOSTNAME=y
 CONFIG_HOSTNAME="sc594-som-ezlite"
 CONFIG_NET_RETRY_COUNT=20
diff --git a/configs/sc598-som-ezkit-spl_defconfig b/configs/sc598-som-ezkit-spl_defconfig
index ad3a6fcc236..7027a7f8a2a 100644
--- a/configs/sc598-som-ezkit-spl_defconfig
+++ b/configs/sc598-som-ezkit-spl_defconfig
@@ -4,9 +4,6 @@ CONFIG_COUNTER_FREQUENCY=31250000
 CONFIG_ARCH_SC5XX=y
 CONFIG_SYS_MALLOC_LEN=0x100000
 CONFIG_SPL_GPIO=y
-CONFIG_ENV_SIZE=0x20000
-CONFIG_ENV_OFFSET=0x180000
-CONFIG_ENV_SECT_SIZE=0x20000
 CONFIG_DM_GPIO=y
 CONFIG_SPL_DM_SPI=y
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x10000
@@ -63,7 +60,6 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_CMD_FAT=y
 CONFIG_OF_EMBED=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_USE_HOSTNAME=y
 CONFIG_HOSTNAME="sc598-som-ezkit"
 CONFIG_NET_RETRY_COUNT=20
diff --git a/configs/sc598-som-ezlite-spl_defconfig b/configs/sc598-som-ezlite-spl_defconfig
index 34dbedf12b4..0b59b36f264 100644
--- a/configs/sc598-som-ezlite-spl_defconfig
+++ b/configs/sc598-som-ezlite-spl_defconfig
@@ -4,9 +4,6 @@ CONFIG_COUNTER_FREQUENCY=31250000
 CONFIG_ARCH_SC5XX=y
 CONFIG_SYS_MALLOC_LEN=0x100000
 CONFIG_SPL_GPIO=y
-CONFIG_ENV_SIZE=0x20000
-CONFIG_ENV_OFFSET=0x180000
-CONFIG_ENV_SECT_SIZE=0x20000
 CONFIG_DM_GPIO=y
 CONFIG_SPL_DM_SPI=y
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x10000
@@ -62,7 +59,6 @@ CONFIG_CMD_EXT4=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_EMBED=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_USE_HOSTNAME=y
 CONFIG_HOSTNAME="sc598-som-ezlite"
 CONFIG_NET_RETRY_COUNT=20
-- 
2.34.1

