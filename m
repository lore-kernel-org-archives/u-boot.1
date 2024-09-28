Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 971ADCF6491
	for <u-boot@archiver.kernel.org>; Sat, 28 Sep 2024 20:02:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67B9988CBB;
	Sat, 28 Sep 2024 22:00:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lvdvwlP9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90EFF88CEC; Sat, 28 Sep 2024 22:00:56 +0200 (CEST)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A9D588D03
 for <u-boot@lists.denx.de>; Sat, 28 Sep 2024 22:00:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-3a27599274eso10804915ab.0
 for <u-boot@lists.denx.de>; Sat, 28 Sep 2024 13:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727553653; x=1728158453; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a7c73vWIxd7nX0BBNjOiZaml+da+5Tcj8xZdEC9QEN4=;
 b=lvdvwlP9NJorhqYmIDgosit2v1JFxDzozG/tSVVUHV2HPGtztg/gud8vz6KpVMHsqk
 sajhA8TOVGILFOepawVueTMQDmKy/uHBILjyzlVEGuNksya7N5dpphvo5Wdf1Wsa+H+h
 /HfJ22DUS5y0uc15ceb3C3zw8jrTPU6NsQGZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727553653; x=1728158453;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a7c73vWIxd7nX0BBNjOiZaml+da+5Tcj8xZdEC9QEN4=;
 b=lKQXWGRhZ1d2BJ0qWf9exmGJ8DbWgMvs44F4KA8FSFTXCfsNq4GWq7WnaZpm+HgUYx
 lfgb55r3g6vZoO8yaCHQLatifISJvVF2Gyqa3hJZx7ZrSmHHmTaSkG+um2x6ArGRinRx
 wvJoOtUgFJuBF33C8VJ0pyahC4XYTKPhO9iem81Z9hQgLPF79GYDV+jcgR8mMVaI47Rm
 QWYT0Nr7QaNgGFBQLo+0j4gGEYq9n9z9AgTKU+VqEeqUQayu590mSm/A0MwYb83kdnIK
 7vPBqVGzF/3q2KlfMEwzs9a7ymSzBpoK45ami4ttsXSy0WHzAjfvhbDWkd46+fve9qnC
 BXnA==
X-Gm-Message-State: AOJu0YyOnAVshQXwktBY9kI2pvSbu35xpO5GEsXdOCnr5tV1Eb2FJmTF
 xXrYeXT7YgOYxNQ8mb6dbXbUCCwMB72MoKR2uYayS65X9V3vEtHVySjym5cT9Rgd+O1xKiM7r3v
 Vnw==
X-Google-Smtp-Source: AGHT+IFDwbufbbuv9a6ny0Lgt5LIoKPiR0uHmIAnXoun6pjg+lTF8c/Pjakf6z2/V9e5ydjnKKOs+g==
X-Received: by 2002:a92:c266:0:b0:3a0:9fc6:5437 with SMTP id
 e9e14a558f8ab-3a3451a2361mr56747695ab.18.1727553652856; 
 Sat, 28 Sep 2024 13:00:52 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4d888835307sm1242590173.2.2024.09.28.13.00.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Sep 2024 13:00:52 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 William Zhang <william.zhang@broadcom.com>
Subject: [PATCH v2 10/30] log: global: Rename warn_non_spl() and update the
 condition
Date: Sat, 28 Sep 2024 14:00:10 -0600
Message-Id: <20240928200030.194546-11-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240928200030.194546-1-sjg@chromium.org>
References: <20240928200030.194546-1-sjg@chromium.org>
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

(no changes since v1)

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
2.34.1

