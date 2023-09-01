Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2721CA0FE2
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 01:15:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 066678683C;
	Fri,  1 Sep 2023 03:14:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="F3p//krz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0A428681D; Fri,  1 Sep 2023 03:14:17 +0200 (CEST)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1ED148671C
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 03:14:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-792965813e7so57158039f.2
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 18:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693530853; x=1694135653; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oDtqdLZf1ehGok3vy0L5t9U1SOZfKIlsL1OfFu4aJfQ=;
 b=F3p//krzwvv/HKPM4HuaI46GsHdfSc7zdUjzlV/eWFU37A7VUmk6gYdpn/0In+HJTt
 N9XW5Rjqmmy+91q8xhhF1SGk0Gjx1ZkvfUwOTPI3YUr0/MDnAmNLs5AxWTpYSwLcWtci
 6HY3SYbnGEnOr84+wewx+Aon37PSaB9OAOrh8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693530853; x=1694135653;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oDtqdLZf1ehGok3vy0L5t9U1SOZfKIlsL1OfFu4aJfQ=;
 b=ecttFjHWAZZCej/yOobS7joTCPdkhtFstXYL5QHwtV0u5/TI9MQyyMKJMTNab3Tq9V
 HphkKbzBKB8pbk9J5nOgSCK+1V/o/wzqNQo/x+7UMk7//pESawJ6otlDJbBHnIgS0CUR
 RygsBVlUTAiOp6bAkKP9w4ARI8BOuXrs3+SzaOa9f52YEtYuu8q2GTvoB+uu9uh5zJWq
 w6hKbpFljgk1C1ZCnfZc2nxmYZREdFxgvxRd5IAIlzJUOjtbJ8Q3GDlHU2qjXBeTrJc3
 /cofnNX5u3svoomax5OW6ETNSiYhPo9u+ecFeWKOIZfRggx8VqPAMFXHYH5c+N1xyVjr
 SfuQ==
X-Gm-Message-State: AOJu0YzB/UYQkQwdb2xFllI1BR0M4Jbr8X0MZAfzTf5DNl1FtU4TYHME
 Iuc+M1i7e/8YQfbygrQANIw8KoIVCzhy/Ny0kgk=
X-Google-Smtp-Source: AGHT+IFIBc5POf9+LxinBE69EOReQ/Ese7wh41IPd91pW4xa6QHC4uZO8kp2uuUY5i0XZBL5KzQDgQ==
X-Received: by 2002:a5e:aa03:0:b0:794:d9f6:e234 with SMTP id
 s3-20020a5eaa03000000b00794d9f6e234mr971147ioe.13.1693530853677; 
 Thu, 31 Aug 2023 18:14:13 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 dk8-20020a0566384bc800b0042b279bb086sm712101jab.66.2023.08.31.18.14.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 18:14:13 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Brandon Maier <brandon.maier@collins.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Kautuk Consul <kconsul@ventanamicro.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Michal Simek <michal.simek@amd.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sjoerd Simons <sjoerd@collabora.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2 05/14] lmb: Rename LMB_MAX_REGIONS and LMB_USE_MAX_REGIONS
Date: Thu, 31 Aug 2023 19:13:43 -0600
Message-ID: <20230901011357.2482203-6-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230901011357.2482203-1-sjg@chromium.org>
References: <20230901011357.2482203-1-sjg@chromium.org>
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

These are the number of areas within a region, so rename them.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Add new patch to rename LMB_MAX_REGIONS and LMB_USE_MAX_REGIONS

 configs/stm32mp13_defconfig         |  4 ++--
 configs/stm32mp15_basic_defconfig   |  4 ++--
 configs/stm32mp15_defconfig         |  4 ++--
 configs/stm32mp15_trusted_defconfig |  4 ++--
 include/lmb.h                       | 10 +++++-----
 lib/Kconfig                         |  6 +++---
 lib/lmb.c                           |  4 ++--
 7 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/configs/stm32mp13_defconfig b/configs/stm32mp13_defconfig
index 82b62744f6db..98fcfeb5fa61 100644
--- a/configs/stm32mp13_defconfig
+++ b/configs/stm32mp13_defconfig
@@ -74,5 +74,5 @@ CONFIG_OPTEE=y
 # CONFIG_OPTEE_TA_AVB is not set
 CONFIG_ERRNO_STR=y
 # CONFIG_LMB_USE_MAX_REGIONS is not set
-CONFIG_LMB_MEMORY_REGIONS=2
-CONFIG_LMB_RESERVED_REGIONS=16
+CONFIG_LMB_MEMORY_AREAS=2
+CONFIG_LMB_RESERVED_AREAS=16
diff --git a/configs/stm32mp15_basic_defconfig b/configs/stm32mp15_basic_defconfig
index 9ea5aaa7145a..7b5655d957d9 100644
--- a/configs/stm32mp15_basic_defconfig
+++ b/configs/stm32mp15_basic_defconfig
@@ -189,5 +189,5 @@ CONFIG_WDT_STM32MP=y
 # CONFIG_BINMAN_FDT is not set
 CONFIG_ERRNO_STR=y
 # CONFIG_LMB_USE_MAX_REGIONS is not set
-CONFIG_LMB_MEMORY_REGIONS=2
-CONFIG_LMB_RESERVED_REGIONS=16
+CONFIG_LMB_MEMORY_AREAS=2
+CONFIG_LMB_RESERVED_AREAS=16
diff --git a/configs/stm32mp15_defconfig b/configs/stm32mp15_defconfig
index 4d0a81f8a871..643ec201c644 100644
--- a/configs/stm32mp15_defconfig
+++ b/configs/stm32mp15_defconfig
@@ -165,5 +165,5 @@ CONFIG_WDT_STM32MP=y
 # CONFIG_BINMAN_FDT is not set
 CONFIG_ERRNO_STR=y
 # CONFIG_LMB_USE_MAX_REGIONS is not set
-CONFIG_LMB_MEMORY_REGIONS=2
-CONFIG_LMB_RESERVED_REGIONS=16
+CONFIG_LMB_MEMORY_AREAS=2
+CONFIG_LMB_RESERVED_AREAS=16
diff --git a/configs/stm32mp15_trusted_defconfig b/configs/stm32mp15_trusted_defconfig
index 0a7d8624858d..2a8162a870c5 100644
--- a/configs/stm32mp15_trusted_defconfig
+++ b/configs/stm32mp15_trusted_defconfig
@@ -165,5 +165,5 @@ CONFIG_WDT_STM32MP=y
 # CONFIG_BINMAN_FDT is not set
 CONFIG_ERRNO_STR=y
 # CONFIG_LMB_USE_MAX_REGIONS is not set
-CONFIG_LMB_MEMORY_REGIONS=2
-CONFIG_LMB_RESERVED_REGIONS=16
+CONFIG_LMB_MEMORY_AREAS=2
+CONFIG_LMB_RESERVED_AREAS=16
diff --git a/include/lmb.h b/include/lmb.h
index 92332eb63069..d963ac28d9ac 100644
--- a/include/lmb.h
+++ b/include/lmb.h
@@ -46,11 +46,11 @@ struct lmb_area {
  *
  * case 2. CONFIG_LMB_USE_MAX_REGIONS is not defined, the size of each
  *         region is configurated *independently* with
- *         => CONFIG_LMB_MEMORY_REGIONS: struct lmb.memory_regions
- *         => CONFIG_LMB_RESERVED_REGIONS: struct lmb.reserved_regions
+ *         => CONFIG_LMB_MEMORY_AREAS: struct lmb.memory_regions
+ *         => CONFIG_LMB_RESERVED_AREAS: struct lmb.reserved_regions
  *         lmb_region.region is only a pointer to the correct buffer,
  *         initialized in lmb_init(). This configuration is useful to manage
- *         more reserved memory regions with CONFIG_LMB_RESERVED_REGIONS.
+ *         more reserved memory regions with CONFIG_LMB_RESERVED_AREAS.
  */
 
 /**
@@ -87,8 +87,8 @@ struct lmb {
 	struct lmb_region memory;
 	struct lmb_region reserved;
 #if !IS_ENABLED(CONFIG_LMB_USE_MAX_REGIONS)
-	struct lmb_area memory_areas[CONFIG_LMB_MEMORY_REGIONS];
-	struct lmb_area reserved_areas[CONFIG_LMB_RESERVED_REGIONS];
+	struct lmb_area memory_areas[CONFIG_LMB_MEMORY_AREAS];
+	struct lmb_area reserved_areas[CONFIG_LMB_RESERVED_AREAS];
 #endif
 };
 
diff --git a/lib/Kconfig b/lib/Kconfig
index 42e559ad0b51..53f1332a8f83 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -1082,7 +1082,7 @@ config LMB_USE_MAX_REGIONS
 	  Define the number of supported memory regions in the library logical
 	  memory blocks.
 	  This feature allow to reduce the lmb library size by using compiler
-	  optimization when LMB_MEMORY_REGIONS == LMB_RESERVED_REGIONS.
+	  optimization when LMB_MEMORY_AREAS == LMB_RESERVED_AREAS.
 
 config LMB_MAX_REGIONS
 	int "Number of memory and reserved regions in lmb lib"
@@ -1092,7 +1092,7 @@ config LMB_MAX_REGIONS
 	  Define the number of supported regions, memory and reserved, in the
 	  library logical memory blocks.
 
-config LMB_MEMORY_REGIONS
+config LMB_MEMORY_AREAS
 	int "Number of memory regions in lmb lib"
 	depends on !LMB_USE_MAX_REGIONS
 	default 8
@@ -1101,7 +1101,7 @@ config LMB_MEMORY_REGIONS
 	  memory blocks.
 	  The minimal value is CONFIG_NR_DRAM_BANKS.
 
-config LMB_RESERVED_REGIONS
+config LMB_RESERVED_AREAS
 	int "Number of reserved regions in lmb lib"
 	depends on !LMB_USE_MAX_REGIONS
 	default 8
diff --git a/lib/lmb.c b/lib/lmb.c
index 2669868f0dda..f4321d10118b 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -111,8 +111,8 @@ void lmb_init(struct lmb *lmb)
 	lmb->memory.max = CONFIG_LMB_MAX_REGIONS;
 	lmb->reserved.max = CONFIG_LMB_MAX_REGIONS;
 #else
-	lmb->memory.max = CONFIG_LMB_MEMORY_REGIONS;
-	lmb->reserved.max = CONFIG_LMB_RESERVED_REGIONS;
+	lmb->memory.max = CONFIG_LMB_MEMORY_AREAS;
+	lmb->reserved.max = CONFIG_LMB_RESERVED_AREAS;
 	lmb->memory.area = lmb->memory_areas;
 	lmb->reserved.area = lmb->reserved_areas;
 #endif
-- 
2.42.0.283.g2d96d420d3-goog

