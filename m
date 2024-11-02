Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBA91E67805
	for <u-boot@archiver.kernel.org>; Sat,  2 Nov 2024 19:39:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AB9589300;
	Sat,  2 Nov 2024 20:37:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="b2LxCZwU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 504E98860B; Sat,  2 Nov 2024 20:37:58 +0100 (CET)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F61B8860B
 for <u-boot@lists.denx.de>; Sat,  2 Nov 2024 20:37:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6ce3fc4e58bso18837536d6.0
 for <u-boot@lists.denx.de>; Sat, 02 Nov 2024 12:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730576274; x=1731181074; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9ARjAduz3TwCwd7DyuAdcCzqcx3jmKJDY9/HJD+VYCE=;
 b=b2LxCZwUxzx2oQBItaN8EU1rIAyxuwQAL1/Omh6oTYmFtgU8JaL+0jwjWJrOjsAo7v
 CetctUhOuxerOHCNvgc7G+Qq0LaYn1eBAtHKEadgXn67RqbHHRxhBrYT+XAZna8jJ6Kf
 2RLRgSd/3a+S+CdXxqSluVxQxTQ9gUsFrUV6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730576274; x=1731181074;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9ARjAduz3TwCwd7DyuAdcCzqcx3jmKJDY9/HJD+VYCE=;
 b=HZex51RSCrnAtfRt92VsZFt26K+1fmiGVPd5uS7s3ds1/vf9b3Kgnnrjc+ODf846cx
 6Glxaw7F2KGIt0v3B6gJWXZvTict8fL+8KyVfkTGJn2qQB7PiA5omuHCqNe4fxPNkrXd
 W2Wa+l9pGKqsjA7qzTq0xEXDmq+vFjbHDYx+CPDgTsRXxQ3LS7U9W9W6Yu8H+mT2C6p2
 SeO1hcDPh9U3nyBd+p6+rJnMmgPiT13WLXQuCopcuq76G7olvaTv7li1ZRNzUB4NZz+M
 6jZuNonabb48o6d/08bYYo6p4k+PYIL5lJLoUoTHzuQXcT9tlbEDAxkAhBuz4kWKVgK6
 Muew==
X-Gm-Message-State: AOJu0Yyw+Jhgcwp4UygSxLzuz9M2As7XDtqHLihjwMM1pMdt7GMdUB0y
 lQH0LGSkpWWVHiLzW4DSyABY+dL/sbKaZq95F309MQyoznWO8aVAdTZtSDM/ecIFWek0X2X7Ysn
 d88aZ
X-Google-Smtp-Source: AGHT+IGytiqkxDXxTJtfYnJPPBBCS1m3Ssy+829ZNbnWFkxUukqgqaqSo9wSPk0OlilzwJkHN2SJIw==
X-Received: by 2002:a05:6214:5d0e:b0:6cb:c882:b1d9 with SMTP id
 6a1803df08f44-6d351abbb4amr161394686d6.21.1730576274255; 
 Sat, 02 Nov 2024 12:37:54 -0700 (PDT)
Received: from chromium.org ([165.225.8.161]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d353f9dfeasm32324976d6.14.2024.11.02.12.37.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 12:37:53 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 14/20] test: Move unicode_ut test into lib
Date: Sat,  2 Nov 2024 13:36:59 -0600
Message-ID: <20241102193715.432529-15-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241102193715.432529-1-sjg@chromium.org>
References: <20241102193715.432529-1-sjg@chromium.org>
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

This test doesn't belong at the top level. Move it into the lib/
directory, to match its implementation. Rename it to drop the
unnecessary _ut suffix.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/Makefile                        | 1 -
 test/lib/Makefile                    | 1 +
 test/{unicode_ut.c => lib/unicode.c} | 0
 3 files changed, 1 insertion(+), 1 deletion(-)
 rename test/{unicode_ut.c => lib/unicode.c} (100%)

diff --git a/test/Makefile b/test/Makefile
index 220a249c397..0b1affcf445 100644
--- a/test/Makefile
+++ b/test/Makefile
@@ -21,7 +21,6 @@ ifeq ($(CONFIG_XPL_BUILD),)
 obj-y += boot/
 obj-$(CONFIG_UNIT_TEST) += common/
 obj-y += log/
-obj-$(CONFIG_$(XPL_)UT_UNICODE) += unicode_ut.o
 else
 obj-$(CONFIG_SPL_UT_LOAD) += image/
 endif
diff --git a/test/lib/Makefile b/test/lib/Makefile
index be20bbc047f..c36c8b0917d 100644
--- a/test/lib/Makefile
+++ b/test/lib/Makefile
@@ -27,6 +27,7 @@ obj-$(CONFIG_AES) += test_aes.o
 obj-$(CONFIG_GETOPT) += getopt.o
 obj-$(CONFIG_CRC8) += test_crc8.o
 obj-$(CONFIG_UT_LIB_CRYPT) += test_crypt.o
+obj-$(CONFIG_$(XPL_)UT_UNICODE) += unicode.o
 obj-$(CONFIG_LIB_UUID) += uuid.o
 else
 obj-$(CONFIG_SANDBOX) += kconfig_spl.o
diff --git a/test/unicode_ut.c b/test/lib/unicode.c
similarity index 100%
rename from test/unicode_ut.c
rename to test/lib/unicode.c
-- 
2.43.0

