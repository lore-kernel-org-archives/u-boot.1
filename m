Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 051E1D10C0B
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 12:44:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02B9E89143;
	Mon, 28 Oct 2024 13:42:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZvjGx6tR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A86E98913B; Mon, 28 Oct 2024 13:42:06 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C03878911B
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 13:42:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a93c1cc74fdso596188866b.3
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 05:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730119324; x=1730724124; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d39zuHqy6Sf9b7CLwMomc0FX2z6OiePH1iAw+wN3mZo=;
 b=ZvjGx6tRl13x3vE1gfBQlGyNdNY3nvrfZUIWDqHclK2PntwoNWcYrQSeHUJyhaFgcy
 Wr8+dNy+J0Jwi0WXGCsblGE0+KY6s74TaLSaIufPgQOBrJuiP+rgNQK8KR6Lf0Ay+L99
 V631lfTiubLW7gue77zTdy415hkonEtB/ehFY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730119324; x=1730724124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d39zuHqy6Sf9b7CLwMomc0FX2z6OiePH1iAw+wN3mZo=;
 b=tx1sgM//U+owYK/fJfPbgFeyNJBK4AFHLQsA0gwzsepFzFV2vqozzxPhuQ2xMDRPTm
 JfcQqOM+RDvYzxY9jpHhxbUPiyjzU49fKditdXAIHRF4KJhPGYlcpTqglQb49R9e3h++
 L5GY6qKqvOI5Or+zEvmRLRlUOhcsRY//EeIeVgIQKBrqRdawuWL3zGOJXGjhpqWKu01q
 JmAEA9AAOINDDAxDjdMNkOOMYKfr+spLh3RrV7VuT+10NWfpAfOmuD6+pwJJ5hPprFxp
 QF893Kv2yMjV0FF3YjhEfVEZNJZMdfN6OSV6z9kfBYYKzR9yJ4Dtn2Ph2wElL3a0EXVc
 HKbw==
X-Gm-Message-State: AOJu0YwL/GMbdDGELR96zLcJXu2UBWCDtMbUKe+8FOm+qF70mX/4XEBR
 EEJgAIYshfcapjPDkeXK0DBbcWlYR2RdOzgGns/hHjlmI6nqbA54+X/lpJglnq7CqI4L7LA3aUK
 LsA==
X-Google-Smtp-Source: AGHT+IHZbcqy4rz/Ij/f6e1NAew7Mx+ZfhcSBbHanggPvP0mYFTKTjxLtjKc7pKtH7nBJlLtADKb2g==
X-Received: by 2002:a17:907:ea1:b0:a9a:4fd3:c35f with SMTP id
 a640c23a62f3a-a9de5c9f365mr753624566b.9.1730119323716; 
 Mon, 28 Oct 2024 05:42:03 -0700 (PDT)
Received: from chromium.org (43-114-103-145.static.glaslokaal.nl.
 [145.103.114.43]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9b30c7ae0bsm375313766b.156.2024.10.28.05.42.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 05:42:02 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 17/21] test: Move time_ut test into lib
Date: Mon, 28 Oct 2024 13:41:22 +0100
Message-ID: <20241028124130.32072-18-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241028124130.32072-1-sjg@chromium.org>
References: <20241028124130.32072-1-sjg@chromium.org>
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

 test/Makefile                  | 1 -
 test/lib/Makefile              | 1 +
 test/{time_ut.c => lib/time.c} | 0
 3 files changed, 1 insertion(+), 1 deletion(-)
 rename test/{time_ut.c => lib/time.c} (100%)

diff --git a/test/Makefile b/test/Makefile
index 0b1affcf445..47a07d653a9 100644
--- a/test/Makefile
+++ b/test/Makefile
@@ -14,7 +14,6 @@ endif
 ifneq ($(CONFIG_HUSH_PARSER),)
 obj-$(CONFIG_$(XPL_)CMDLINE) += hush/
 endif
-obj-$(CONFIG_UT_TIME) += time_ut.o
 obj-y += ut.o
 
 ifeq ($(CONFIG_XPL_BUILD),)
diff --git a/test/lib/Makefile b/test/lib/Makefile
index c36c8b0917d..217c3baf881 100644
--- a/test/lib/Makefile
+++ b/test/lib/Makefile
@@ -27,6 +27,7 @@ obj-$(CONFIG_AES) += test_aes.o
 obj-$(CONFIG_GETOPT) += getopt.o
 obj-$(CONFIG_CRC8) += test_crc8.o
 obj-$(CONFIG_UT_LIB_CRYPT) += test_crypt.o
+obj-$(CONFIG_UT_TIME) += time.o
 obj-$(CONFIG_$(XPL_)UT_UNICODE) += unicode.o
 obj-$(CONFIG_LIB_UUID) += uuid.o
 else
diff --git a/test/time_ut.c b/test/lib/time.c
similarity index 100%
rename from test/time_ut.c
rename to test/lib/time.c
-- 
2.43.0

