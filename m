Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A44ACDE03F
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 22:41:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0A5A88F89;
	Fri, 27 Sep 2024 00:41:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SJvJREFu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D800488F89; Fri, 27 Sep 2024 00:41:25 +0200 (CEST)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0227188FA9
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 00:41:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-e25cb91f3b3so1478118276.1
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 15:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727390482; x=1727995282; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oNqcdDhF1W6m7hcvpgnWvXkmBnWFMtedcUg+/mvi1zg=;
 b=SJvJREFuHgxkYqniyi1G4OV6pJUKaoM5UvZXXOt+U7nU6luyy2bujHngh2X35LDSqi
 RcDxxd1/HMjcfIsXbh7OaKY+ZnYciaGHEXPmiEd//Dw0O2ciBCEQkWimPl8rbLlOgKBL
 JQpSuOSJ4VjdUNWkQUjSN3yB3EY/PVK1Jaoog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727390482; x=1727995282;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oNqcdDhF1W6m7hcvpgnWvXkmBnWFMtedcUg+/mvi1zg=;
 b=RcgLWNsztmb4HfO3Pn0pVjxDagzi8BZ1HaIdZOqf5DcEtHQwnRd4igBT89z0CZzx19
 8b7ePWV5p5roqzx6zPYtjO08Rl5qSIZiZ9R/gDSFIU9PJsMXCEMV+CJ8kkx2rPFXeDlO
 lr9Aci9EGHo7SVGP8eU/JoTjkX9QGes4Rvfb0oqbz1fFsDk1beImA9DssK/+wQ9XHe38
 6mggDZDgj764weHZJOBXQq0lMic7xVYLh3CmFk37fa0JFQ6KfNziYPLYoB0/wHFQjw4a
 RIHZB/O8/RPSYiTNEtUfniU3Zwa8SNwNzmAvEaqXL/C7icbVGxV9w1rK3O7Uhg1kOKJw
 nKww==
X-Gm-Message-State: AOJu0YwBkXP18GiuKfrsC+xMuzJSVQyvTZu0t1mJCRA/2eHLHXNt9kMC
 32OdgvLTjPQOcEnF/+3/NTrvc28/f2bxqnznERf4iI01VTyMJSoIJfpiuSeh+Yy8S3KwHu34oET
 w5uRhFE0=
X-Google-Smtp-Source: AGHT+IFZdgPN7Ozc6c/PMxdiRKvPCq0tI+AXz135lN2TfGyXlaT1SRerM/bSpRAH/KIKYpuSpKxkXA==
X-Received: by 2002:a05:6902:2411:b0:e25:e343:573d with SMTP id
 3f1490d57ef6-e2604b6dd9emr960391276.17.1727390481715; 
 Thu, 26 Sep 2024 15:41:21 -0700 (PDT)
Received: from chromium.org ([205.220.129.31])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45c9f350fadsm2738461cf.80.2024.09.26.15.41.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 15:41:21 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 William Zhang <william.zhang@broadcom.com>
Subject: [PATCH 10/42] log: global: Rename warn_non_spl() and update the
 condition
Date: Fri, 27 Sep 2024 00:35:35 +0200
Message-ID: <20240926223814.1276764-11-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240926223814.1276764-1-sjg@chromium.org>
References: <20240926223814.1276764-1-sjg@chromium.org>
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

This should now refer to xPL rather than SPL, so update it throughout
the tree.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/arm/lib/cache.c     |  2 +-
 doc/develop/logging.rst  |  2 +-
 drivers/spi/spi-uclass.c |  4 ++--
 include/log.h            | 10 +++++-----
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/lib/cache.c b/arch/arm/lib/cache.c
index b2ae74a59f1..cac2159fe1a 100644
--- a/arch/arm/lib/cache.c
+++ b/arch/arm/lib/cache.c
@@ -62,7 +62,7 @@ int check_cache_range(unsigned long start, unsigned long stop)
 		ok = 0;
 
 	if (!ok) {
-		warn_non_spl("CACHE: Misaligned operation at range [%08lx, %08lx]\n",
+		warn_non_xpl("CACHE: Misaligned operation at range [%08lx, %08lx]\n",
 			     start, stop);
 	}
 
diff --git a/doc/develop/logging.rst b/doc/develop/logging.rst
index 704a6bf1d84..d7a40c94bf0 100644
--- a/doc/develop/logging.rst
+++ b/doc/develop/logging.rst
@@ -292,7 +292,7 @@ Convert debug() statements in the code to log() statements
 
 Convert error() statements in the code to log() statements
 
-Figure out what to do with BUG(), BUG_ON() and warn_non_spl()
+Figure out what to do with BUG(), BUG_ON() and warn_non_xpl()
 
 Add a way to browse log records
 
diff --git a/drivers/spi/spi-uclass.c b/drivers/spi/spi-uclass.c
index 6e281725239..f6efebd2e90 100644
--- a/drivers/spi/spi-uclass.c
+++ b/drivers/spi/spi-uclass.c
@@ -538,7 +538,7 @@ int spi_slave_of_to_plat(struct udevice *dev, struct dm_spi_slave_plat *plat)
 		mode |= SPI_TX_OCTAL;
 		break;
 	default:
-		warn_non_spl("spi-tx-bus-width %d not supported\n", value);
+		warn_non_xpl("spi-tx-bus-width %d not supported\n", value);
 		break;
 	}
 
@@ -556,7 +556,7 @@ int spi_slave_of_to_plat(struct udevice *dev, struct dm_spi_slave_plat *plat)
 		mode |= SPI_RX_OCTAL;
 		break;
 	default:
-		warn_non_spl("spi-rx-bus-width %d not supported\n", value);
+		warn_non_xpl("spi-rx-bus-width %d not supported\n", value);
 		break;
 	}
 
diff --git a/include/log.h b/include/log.h
index 371f99d82e7..bf81a27011f 100644
--- a/include/log.h
+++ b/include/log.h
@@ -247,9 +247,9 @@ int _log_buffer(enum log_category_t cat, enum log_level_t level,
 #endif
 
 #ifdef CONFIG_XPL_BUILD
-#define _SPL_BUILD	1
+#define _XPL_BUILD	1
 #else
-#define _SPL_BUILD	0
+#define _XPL_BUILD	0
 #endif
 
 #if CONFIG_IS_ENABLED(LOG)
@@ -281,9 +281,9 @@ int _log_buffer(enum log_category_t cat, enum log_level_t level,
 #define debug(fmt, args...)			\
 	debug_cond(_DEBUG, fmt, ##args)
 
-/* Show a message if not in SPL */
-#define warn_non_spl(fmt, args...)			\
-	debug_cond(!_SPL_BUILD, fmt, ##args)
+/* Show a message if not in xPL */
+#define warn_non_xpl(fmt, args...)			\
+	debug_cond(!_XPL_BUILD, fmt, ##args)
 
 /*
  * An assertion is run-time check done in debug mode only. If DEBUG is not
-- 
2.43.0

