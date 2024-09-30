Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D0FCCF6495
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 01:52:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AAB588E99;
	Mon, 30 Sep 2024 03:50:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="a6wP5EX1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2916C88D9B; Mon, 30 Sep 2024 03:50:33 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF79688E11
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 03:50:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-8323b555ae2so185758639f.2
 for <u-boot@lists.denx.de>; Sun, 29 Sep 2024 18:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727661028; x=1728265828; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l70A8cnCjXu+N0b4rxmDpAbzJSJgqOiNR77Hi556dOQ=;
 b=a6wP5EX1pluOpxkOu2xoSF33J7okEubOpQlinNwnsciaJY0KO+VLCkE0lIU60MGqJ8
 ykvK1+EwQsxD35FJOic5xxTmORJpW4QeEjelbK4kpgIUxrdo0d1vaowszuO5aGoOU3aZ
 WAZ6BLi/A/P83BYxYt5bkYAASBBEM9abAoSxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727661028; x=1728265828;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l70A8cnCjXu+N0b4rxmDpAbzJSJgqOiNR77Hi556dOQ=;
 b=ZcyzJLpamGYttSP887UdQKD+FBwHUX4J27GScg66j1XA1D0K+nzZ13L6k1fMaOz3Y5
 bC2B8raXFz2ZunmWdkhr9CRVHlaHvgHYer99KKODNj0BeGwicw08NDGHV/k1Vww6sKKw
 +SZmx6dgJVbILwsjpEOEgHX+uiEo7sWBFRb3B/xxNKoPIvwX7m3dDIMIFpzL0l5ZX/bd
 EWtqFGuGPIIISGUEQLs7c0C7b6oN1PtDs6sU3Yfi4vPGUe+gQin5xoLlAiKo22+UkxiA
 0FD10q9FivvOTfIY0UhbgHTKvCp2khExK6vyPczR7VrH4I9YAgGYI0etkmuneQKKTsmp
 JoKg==
X-Gm-Message-State: AOJu0YyqolAsDVjQ/xsS80xkie8+ByM6fMEudBmQikUOdpTpjnfjmzyJ
 2+Syxg0nT4rcSv0YeMiFAycStGtRDnzbkoodPS7tSA4Mv1yu5xpig0RoUHfgRVBQGHiZHYtzQWF
 LQQ==
X-Google-Smtp-Source: AGHT+IGAcmneKXlyWAFe6IWPT66V26dvwlB0oU+gkhpxs8wLqFR6VHsUlCELrI6QyG4fhmwhgXVwWw==
X-Received: by 2002:a05:6e02:12c4:b0:3a0:8dcb:b033 with SMTP id
 e9e14a558f8ab-3a3451b72bdmr89356485ab.24.1727661028520; 
 Sun, 29 Sep 2024 18:50:28 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a344de1d5fsm22074185ab.62.2024.09.29.18.50.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Sep 2024 18:50:28 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 William Zhang <william.zhang@broadcom.com>
Subject: [PATCH v3 18/33] log: global: Rename warn_non_spl()
Date: Sun, 29 Sep 2024 19:49:41 -0600
Message-Id: <20240930014956.1434060-19-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240930014956.1434060-1-sjg@chromium.org>
References: <20240930014956.1434060-1-sjg@chromium.org>
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

Changes in v3:
- Move to earlier in the series

 arch/arm/lib/cache.c     |  2 +-
 doc/develop/logging.rst  |  2 +-
 drivers/spi/spi-uclass.c |  4 ++--
 include/log.h            | 12 ++++++------
 4 files changed, 10 insertions(+), 10 deletions(-)

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
index 7c25bf0b081..bf81a27011f 100644
--- a/include/log.h
+++ b/include/log.h
@@ -246,10 +246,10 @@ int _log_buffer(enum log_category_t cat, enum log_level_t level,
 #define _DEBUG	0
 #endif
 
-#ifdef CONFIG_SPL_BUILD
-#define _SPL_BUILD	1
+#ifdef CONFIG_XPL_BUILD
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
2.34.1

