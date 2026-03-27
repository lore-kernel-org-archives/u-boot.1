Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0D5D10F284A
	for <u-boot@archiver.kernel.org>; Fri, 27 Mar 2026 16:24:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B97983F14;
	Fri, 27 Mar 2026 17:24:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PihjTOYH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6739183E7A; Fri, 27 Mar 2026 14:51:43 +0100 (CET)
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D9D783DA7
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 14:51:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-qt1-x841.google.com with SMTP id
 d75a77b69052e-509061dab77so18801891cf.2
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 06:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774619500; x=1775224300; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eAPXH6MuWC9YFP8aSpcf5owuSmE63d3dNYY0ZrZ8ZcI=;
 b=PihjTOYHC8RBDa8Pc+x3L/yu1j3T/edS+dEWiaWd/rErN6rVr/1zwGbrjc/Qxo2+x0
 FJQP3V8YJ27m45NheS6zH88MMAc03uTBcKs+p2QjUu6un/Dz4aNZIXB5ehAo4X6iJdjb
 BhdGszTXNEZMDPOYBLaRZtVnCTOJ+HHUiZYyrqFn6j7EkrhnsginMzYqeiT7I9TV2pMY
 P92esI1v3o5TGpQwk+vsX+PvmWo0gNwFbJy50yz9QLGLI1XWV+y8dPDl8uaeWKtDFk+x
 EMdyQpQjlN4m7lq6W5id0DpiYrG3kqPolcSU2FapFwRrN58/g6x6nz//jbYxfHVvjsYR
 19iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774619500; x=1775224300;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eAPXH6MuWC9YFP8aSpcf5owuSmE63d3dNYY0ZrZ8ZcI=;
 b=OapYbEtqv1z7zdNy8wswozcXUgDGy0CNkvXs9xXpwU+QJ3KTyc71vChbVB1FT+jlZl
 l0Q11l6K9VfzE2SHfwqEc4AK5GOSsA5s0dk/uIZsieVwClRwN08+l1SfUw2migCB1jrs
 ElKyXcGTZekK0+6Vq8QyNyHHw90XnJnqz5lbZpWOuxjYWOiFOuouYd9u2AdHaFfuW5kH
 5/Inv5UeFvcaRs8+kBx91XpiVqUdjwFppFh321l/kQdGBtTo0qw7b7Ye/7Frw+d6kvSF
 M248L1FvrIDEGGu/5NJgRE9lHqEEpb6y0bGvc2F5AmqP8o4p7ZI6OuhHDKL/dID8eXK+
 0lrA==
X-Gm-Message-State: AOJu0Yy/Lf19l3lBbtx/jm7hyGwPHFx9z7WaZi3Kmqq00JrJQVzkPHDZ
 xghsWRozrI6zvSBFCk5aA8gBwAT09AaJWdx5kxtwvazX7bWsff9ggkm00V0mhvRE
X-Gm-Gg: ATEYQzz7pF9gJZIEuQZlIHyfkDDbkZbHuxs0RwNLMCMnWgaLM7OFNTzafPQwbNgVA68
 EvbuDuXpKJv9CLtEd1KZp2xG0Aioe05PNrGd451qDWv9k0fjgGDhPjsFiQoekUzny+jrldp9/1h
 RQXavKRENAOEtelbBPgoZxmc6cFWzeyTNRhdtFOhp6CBvWY7M2Gfzru9Whg7YRvvdZOQCyJa5lh
 xhs6Xy/HChHyNvA5WYWZBoFrgy9VCxtKZLvocBTgVNjkatXQj1npd7P5hAqbs/ZmBCXEctA9XRu
 +Kesfy4YeG6Ym6UzzJHddOYmJ/GOUgIi7Uj5u94v/IlKUXAVu8jPkQgfTMwBhXojqug7iJefvPg
 n6WiTfgiDpswlPCX+8uEmgB9KO7IJtBlpuonFOCQhtiTNx+FRbHkeaDXD9/gmYcISLR3aUFQYcR
 iXcZ1+QDKOw18E0zSHVCAzmjuglsMu5KJ1Mw==
X-Received: by 2002:a05:622a:4812:b0:509:1590:f5b3 with SMTP id
 d75a77b69052e-50ba395ec7bmr33572691cf.35.1774619499840; 
 Fri, 27 Mar 2026 06:51:39 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89cd588969dsm48691356d6.12.2026.03.27.06.51.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 06:51:39 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: u-boot@lists.denx.de
Cc: malysagreg@gmail.com, trini@konsulko.com, linux@analog.com,
 philip@philipmolloy.com, Caleb Ethridge <caleb.ethridge@analog.com>,
 Ozan Durgat <ozan.durgat@analog.com>
Subject: [PATCH v2 01/13] configs: sc5xx: Do not store environment in SPI flash
Date: Fri, 27 Mar 2026 09:49:16 -0400
Message-Id: <935cde091743358b851eb8703245d7da5a5d439c.1774618658.git.jcethrid@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1774618658.git.jcethrid@gmail.com>
References: <cover.1774618658.git.jcethrid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 27 Mar 2026 17:24:39 +0100
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
index 60772ed013e..66d6d4b1155 100644
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
@@ -52,7 +49,6 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_EMBED=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_USE_HOSTNAME=y
 CONFIG_HOSTNAME="sc573-ezkit"
 CONFIG_NET_RETRY_COUNT=20
diff --git a/configs/sc584-ezkit_defconfig b/configs/sc584-ezkit_defconfig
index 262f29eb087..c34e467b005 100644
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
index 19567a43ca1..b23cc803d34 100644
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
index 362d7790d75..8c0d68755ad 100644
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
index 9f02bc97704..5c0f7844630 100644
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
@@ -40,7 +37,6 @@ CONFIG_CMD_EXT4=y
 CONFIG_CMD_FAT=y
 CONFIG_OF_EMBED=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_USE_HOSTNAME=y
 CONFIG_HOSTNAME="sc594-som-ezkit"
 CONFIG_NET_RETRY_COUNT=20
diff --git a/configs/sc594-som-ezlite-spl_defconfig b/configs/sc594-som-ezlite-spl_defconfig
index 2252d063770..7840b47a1aa 100644
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
@@ -45,7 +42,6 @@ CONFIG_CMD_FAT=y
 # CONFIG_DOS_PARTITION is not set
 CONFIG_OF_EMBED=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_ENV_IS_IN_SPI_FLASH=y
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
index 4101af66127..cce06cd931a 100644
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

