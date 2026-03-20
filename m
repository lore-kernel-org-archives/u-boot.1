Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAFBF1098783
	for <u-boot@archiver.kernel.org>; Fri, 20 Mar 2026 13:06:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2271A83F8A;
	Fri, 20 Mar 2026 14:06:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DQVa30zU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11B8D83D71; Fri, 20 Mar 2026 13:52:29 +0100 (CET)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE2BC83CEA
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 13:52:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-qk1-x742.google.com with SMTP id
 af79cd13be357-8cbc593a67aso161947285a.2
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 05:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774011145; x=1774615945; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RvXKWxbznwl8TgSq1130g0TMM0GizYW18K6PIfn6DH0=;
 b=DQVa30zU3mSIYDnQCO07atgNaALN/AqDzx6aNqz4tcrJU9bPCyA8q/xXA97W4mCn3M
 C7Wi8Lrn+jNubQG/FtWb5EO2obtu1SqfXFHVPL0OnPccpKt2umY6qi8mBq3WzuJHQIZ0
 lzHvB8/ku5YCXn1S1WgrKtMXDWESAGnRNBuWrd6ARO8X+ek28HT/vxZTxnj1DIxdgvME
 gwpF03UAVO2QEe7G7nmY3EaWgCbiBv2jKgz2fJrEXQrOhXo7wJc2ifQVIj+XlNNgZ8HX
 qfbfX2DCQDGlphAzyyqwlx9Kdj/bnG3bVGqovEC53Gh+qRtZD4jrm5jIVCBkuFE06xiV
 bJwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774011145; x=1774615945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RvXKWxbznwl8TgSq1130g0TMM0GizYW18K6PIfn6DH0=;
 b=leeozF2addnl/pdmvdRk8xAvn5J1m0Y7Ffu/bqdRv0fFGlMyQadui43qrtB7TXCC3y
 8niAepu/NguQP2kmTx5fc7zDQb3MVo+eQp+9NnGmT0PR9hmA9z+RPgvHERWKI27JInGI
 fbg6KPSTKcQm9o+ALD3eiMzNe1C/HDwZpBkX/y+jnF03mDulTsFo7Y91DbMWnRU6JrSu
 ACN4mtnWs+7SzGGcZ0+4fUxb5mNNILPeaTm5CMSyVHhqVpSd7GY1OHDHjzol0mAjP01W
 oqOjnOgmdeOhnhea4PPZMPBzJY1Tx2sCv4ePqnuHFb3WuGiIJH5XKmQ9HmhIHauOjZML
 4OKQ==
X-Gm-Message-State: AOJu0Yxc+xOvhFuYn+/MKm5oKItay3WMJGQeJTmxaMbNUmzpftFNGaBx
 96Vodzu579ONq6/zmTnbAUnP5LZwGxzNcBG8eDcpjDxSYbz6EjrqmJK3PtSWLJoIt2GZFw==
X-Gm-Gg: ATEYQzwmAfsi5t7TXEWOBEF7h0xaSU+vIz7ylnnc2u8jn/9iP12c0JxdglSc+KBdYiK
 ABtDLHCLbqHumIzDFtoIjhioXC3QlhiBEqulMPZjDhDdnp5FVhkY8Z4bWagf2Bx/l3KYhJgKZo5
 4wDuLzWDkyBjqW1Mun1bU+mO2a4fQkB+V0nL4QqcYTQvP2kUmpO/MQry/3GOtWb6A+soYEEcAsR
 V/N3cTxbkczBBnMlh4P3T1McgycUcKHkgh1W91GT1rVMacAihJmf1R+JdtCYC80m48aZbqaanRD
 DNwojAe+2tBrGQRWNx/IyXo4dHErTDSvVXDUIQ+Hlet98ZVIMPOvT424jQTsp0M+obgE7YjaOG6
 q0Rmw58CzmAZpbmROG5sL2xNLNt41P8DoRDUY9jgOyTHQaXhPf9ye3Xa8dK1dYVXWpu9i56fyBI
 qPJ5su5CeTjVARsJiZrldDrq9GfTeqTCbTVmiB4C9OV9yA
X-Received: by 2002:a05:6214:dab:b0:89c:8796:5dd6 with SMTP id
 6a1803df08f44-89c87965f56mr29083896d6.35.1774011145109; 
 Fri, 20 Mar 2026 05:52:25 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89c8537c3b5sm19168166d6.47.2026.03.20.05.52.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 05:52:24 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: u-boot@lists.denx.de
Cc: malysagreg@gmail.com, philip@philipmolloy.com, trini@konsulko.com,
 linux@analog.com, Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [PATCH 01/11] configs: sc5xx: Do not store environment in SPI flash
Date: Fri, 20 Mar 2026 08:50:16 -0400
Message-Id: <098b06efa6424cd422c8c6d53f3600ed60432719.1774008927.git.jcethrid@gmail.com>
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

Remove config option enabling storage of the environment
in the SPI flash, to match shift of programming boot media
to Linux.

Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>
---
 configs/sc573-ezkit_defconfig          | 5 +----
 configs/sc584-ezkit_defconfig          | 5 +----
 configs/sc589-ezkit_defconfig          | 5 +----
 configs/sc589-mini_defconfig           | 5 +----
 configs/sc594-som-ezkit-spl_defconfig  | 5 +----
 configs/sc594-som-ezlite-spl_defconfig | 5 +----
 configs/sc598-som-ezkit-spl_defconfig  | 4 ----
 configs/sc598-som-ezlite-spl_defconfig | 5 +----
 8 files changed, 7 insertions(+), 32 deletions(-)

diff --git a/configs/sc573-ezkit_defconfig b/configs/sc573-ezkit_defconfig
index 60772ed013e..f6ccf9e0968 100644
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
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x10000
@@ -52,7 +49,7 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_EMBED=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_ENV_IS_IN_SPI_FLASH=y
+CONFIG_ENV_IS_NOWHERE=y
 CONFIG_USE_HOSTNAME=y
 CONFIG_HOSTNAME="sc573-ezkit"
 CONFIG_NET_RETRY_COUNT=20
diff --git a/configs/sc584-ezkit_defconfig b/configs/sc584-ezkit_defconfig
index 262f29eb087..9b42afc8e1c 100644
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
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_STACK=0x200C0000
@@ -57,7 +54,7 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_EMBED=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_ENV_IS_IN_SPI_FLASH=y
+CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_SPI_MAX_HZ=10000000
 CONFIG_USE_HOSTNAME=y
 CONFIG_HOSTNAME="sc584-ezkit"
diff --git a/configs/sc589-ezkit_defconfig b/configs/sc589-ezkit_defconfig
index 19567a43ca1..1963d2caa3f 100644
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
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_STACK=0x200C0000
@@ -61,7 +58,7 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_EMBED=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_ENV_IS_IN_SPI_FLASH=y
+CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_SPI_MAX_HZ=10000000
 CONFIG_USE_HOSTNAME=y
 CONFIG_HOSTNAME="sc589-ezkit"
diff --git a/configs/sc589-mini_defconfig b/configs/sc589-mini_defconfig
index 362d7790d75..adc85547c1d 100644
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
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_STACK=0x200C0000
@@ -58,7 +55,7 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_EMBED=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_ENV_IS_IN_SPI_FLASH=y
+CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_SPI_MAX_HZ=10000000
 CONFIG_USE_HOSTNAME=y
 CONFIG_HOSTNAME="sc589-mini"
diff --git a/configs/sc594-som-ezkit-spl_defconfig b/configs/sc594-som-ezkit-spl_defconfig
index 9f02bc97704..2de5e625e6f 100644
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
 CONFIG_SPL_SERIAL=y
@@ -40,7 +37,7 @@ CONFIG_CMD_EXT4=y
 CONFIG_CMD_FAT=y
 CONFIG_OF_EMBED=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_ENV_IS_IN_SPI_FLASH=y
+CONFIG_ENV_IS_NOWHERE=y
 CONFIG_USE_HOSTNAME=y
 CONFIG_HOSTNAME="sc594-som-ezkit"
 CONFIG_NET_RETRY_COUNT=20
diff --git a/configs/sc594-som-ezlite-spl_defconfig b/configs/sc594-som-ezlite-spl_defconfig
index 2252d063770..80e3d64987a 100644
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
 CONFIG_SPL_SERIAL=y
@@ -45,7 +42,7 @@ CONFIG_CMD_FAT=y
 # CONFIG_DOS_PARTITION is not set
 CONFIG_OF_EMBED=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_ENV_IS_IN_SPI_FLASH=y
+CONFIG_ENV_IS_NOWHERE=y
 CONFIG_USE_HOSTNAME=y
 CONFIG_HOSTNAME="sc594-som-ezlite"
 CONFIG_NET_RETRY_COUNT=20
diff --git a/configs/sc598-som-ezkit-spl_defconfig b/configs/sc598-som-ezkit-spl_defconfig
index f1a6af43edc..d19c3c6018d 100644
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
 CONFIG_SPL_SERIAL=y
@@ -63,7 +60,6 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_CMD_FAT=y
 CONFIG_OF_EMBED=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_USE_HOSTNAME=y
 CONFIG_HOSTNAME="sc598-som-ezkit"
 CONFIG_NET_RETRY_COUNT=20
diff --git a/configs/sc598-som-ezlite-spl_defconfig b/configs/sc598-som-ezlite-spl_defconfig
index 4101af66127..e10688ad724 100644
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
 CONFIG_SPL_SERIAL=y
@@ -62,7 +59,7 @@ CONFIG_CMD_EXT4=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_EMBED=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_ENV_IS_IN_SPI_FLASH=y
+CONFIG_ENV_IS_NOWHERE=y
 CONFIG_USE_HOSTNAME=y
 CONFIG_HOSTNAME="sc598-som-ezlite"
 CONFIG_NET_RETRY_COUNT=20
-- 
2.34.1

