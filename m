Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5675D6AAE6
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 15:48:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 186B784099;
	Thu,  2 Apr 2026 17:48:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S7Or0ge2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 988E383CF5; Thu,  2 Apr 2026 17:28:55 +0200 (CEST)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EEE283CF5
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 17:28:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-qk1-x744.google.com with SMTP id
 af79cd13be357-8cfd44fa075so138964885a.0
 for <u-boot@lists.denx.de>; Thu, 02 Apr 2026 08:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775143732; x=1775748532; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ar0/JLIiJoSuvkIYphg+/V4cCTNfuTtL7k4ZGGMyaUA=;
 b=S7Or0ge26JZRQHIdJ0JmlU0vFyp2wna//1en+A+JFA3Wsfjw1nn6gAd90MGOVOBymy
 WwEcDHYT75B1ylfrG7J1voZTx1oxnfP7TWJt4AnraeR9iahrsv7D0JoY5kJhhP9DGHLa
 cBooKBqY2+lgznvDN0NsHpPsVf6PbUo5rDKreDWDJOjmFgw940D0XuIZHoKA/WCG+7gg
 vlwSfij5bud5ijpPTFow2ugAEKVbBVLtFYU/A0j57MjJYrpEG+E5nu32AqD1h2UFklUw
 /8jm+CYybNnA/jnBtNhTSxhpOgsfw6dzvZGJpVrmVyT3Hr0LTalG1090bzGBb5k2Z8tA
 cqIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775143732; x=1775748532;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ar0/JLIiJoSuvkIYphg+/V4cCTNfuTtL7k4ZGGMyaUA=;
 b=r82y5pvT5L5BxEXj3Ue7VtF8hOnfA4utW2ZPKrpNllwqCJjtLcaxWvmpsApwnMwnyp
 fiWv7JIXFjdMZUWitJJiSzT0eEPJo1U+BcH1LkvimdgF8smNrOOwDejRWFSTET2x6+Ab
 t+ETUn6kZVWWdL6eOQiCYCANeyKzU2UwNwGHvbiJhpc4CaWwu2Ete1ZAyfGW4qYA97JP
 jqGDAp5I7Y79CUTefpj7hoErCUHUjpRLC6z3WIJAQSujgyo1/2uDCs/l39irYcSAk2TE
 g8tzJhpHtUo53uPQ5z+yZ4QPkEFDRfEcraqlTSRqQXcTnlI1i019wb0hHbQIKqmr3HX2
 Xygg==
X-Gm-Message-State: AOJu0YyhiKO6KjUixuSb3vQqNyuzPRkR8ZYVwYq9xY6qixA4/ziqchC2
 mCmkEPK6K2qjRpKgyMZ81rQ9KiS27PO3Y+uOoSRZLPRaOh3XgGI0za2G3+UDTBIH
X-Gm-Gg: ATEYQzya1zLMimGsQflpfQBtZeXJliTaapAHfSysT9lIxrAW8pxmaajxVMARhpOMGDf
 7xF8fnBXvS0lL5Ba2WmWTjPAQxinMlyxQeXGUEuX4SwxHLBY/mOU2rac5m7zztBILs77tOrZtNJ
 o7MnMtR1OEEd+AHpeHz2ikWUK6Vcq/xVyT/YyenrPnx+FSu7UnJ8VJ0EEs7dn4FTkMs9/iNuPgN
 ZPenH3goqiSyl2HJRb3dzGcf1HC5EX+HggbBv8ELKNl0LfzgWCCVcUZwvqd1/J/UwbmNoO9c5Fj
 ZilJ530+/uOF57nlkXfJ65K+vvt4X0DPcejh8U4+LqWYAV1hijUy0zQqyr8nZLUQBZI6+sdMXKb
 mjxOk28ytzaKZMtJOKRD3aOq3+Z35FJzNkQa3LrvpgYaez6eYemAz2jxzRj94UP0rqykYifMHMG
 KLdPkCgJqvVzI1MQCzsVqbkoPCEgCwhSLg3w==
X-Received: by 2002:a05:620a:46a5:b0:8cd:982d:411d with SMTP id
 af79cd13be357-8d1b5c17ec3mr1161326085a.52.1775143732037; 
 Thu, 02 Apr 2026 08:28:52 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8d2a5393a07sm239037485a.4.2026.04.02.08.28.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 08:28:51 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: u-boot@lists.denx.de
Cc: malysagreg@gmail.com, trini@konsulko.com, linux@analog.com,
 philip@philipmolloy.com, Caleb Ethridge <caleb.ethridge@analog.com>,
 Ozan Durgat <ozan.durgat@analog.com>
Subject: [RESEND v2 01/13] configs: sc5xx: Do not store environment in SPI
 flash
Date: Thu,  2 Apr 2026 11:28:24 -0400
Message-Id: <14e70282b3863934c1676f1429a7ceb4837b50de.1775143241.git.jcethrid@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1775143241.git.jcethrid@gmail.com>
References: <cover.1775143241.git.jcethrid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 02 Apr 2026 17:48:00 +0200
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

Signed-off-by: Ozan Durgat <ozan.durgat@analog.com>
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
index 1d2112c3f52..e5924b858fb 100644
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
@@ -49,7 +46,6 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_EMBED=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_USE_HOSTNAME=y
 CONFIG_HOSTNAME="sc573-ezkit"
 CONFIG_NET_RETRY_COUNT=20
diff --git a/configs/sc584-ezkit_defconfig b/configs/sc584-ezkit_defconfig
index b7116bb5c8f..60fbc2f9b83 100644
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
@@ -54,8 +51,6 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_EMBED=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_ENV_SPI_MAX_HZ=10000000
 CONFIG_USE_HOSTNAME=y
 CONFIG_HOSTNAME="sc584-ezkit"
 CONFIG_NET_RETRY_COUNT=20
diff --git a/configs/sc589-ezkit_defconfig b/configs/sc589-ezkit_defconfig
index 74305765ed5..e4f9144167d 100644
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
@@ -58,8 +55,6 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_EMBED=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_ENV_SPI_MAX_HZ=10000000
 CONFIG_USE_HOSTNAME=y
 CONFIG_HOSTNAME="sc589-ezkit"
 CONFIG_NET_RETRY_COUNT=20
diff --git a/configs/sc589-mini_defconfig b/configs/sc589-mini_defconfig
index 1141237d58b..2241808b6ef 100644
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
@@ -55,8 +52,6 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_EMBED=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_ENV_SPI_MAX_HZ=10000000
 CONFIG_USE_HOSTNAME=y
 CONFIG_HOSTNAME="sc589-mini"
 CONFIG_NET_RETRY_COUNT=20
diff --git a/configs/sc594-som-ezkit-spl_defconfig b/configs/sc594-som-ezkit-spl_defconfig
index a9f06d603f8..7f196e673f4 100644
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
@@ -37,7 +34,6 @@ CONFIG_CMD_EXT4=y
 CONFIG_CMD_FAT=y
 CONFIG_OF_EMBED=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_USE_HOSTNAME=y
 CONFIG_HOSTNAME="sc594-som-ezkit"
 CONFIG_NET_RETRY_COUNT=20
diff --git a/configs/sc594-som-ezlite-spl_defconfig b/configs/sc594-som-ezlite-spl_defconfig
index 58392dc0ac5..433b3964188 100644
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
@@ -42,7 +39,6 @@ CONFIG_CMD_FAT=y
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
index 739a774a918..668605c50f6 100644
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
@@ -59,7 +56,6 @@ CONFIG_CMD_EXT4=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_EMBED=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_USE_HOSTNAME=y
 CONFIG_HOSTNAME="sc598-som-ezlite"
 CONFIG_NET_RETRY_COUNT=20
-- 
2.34.1

