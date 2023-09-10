Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8325BC71153
	for <u-boot@archiver.kernel.org>; Sun, 10 Sep 2023 18:25:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A88B86CD9;
	Sun, 10 Sep 2023 20:25:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="dLQ2HX+D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDE1086CD6; Sun, 10 Sep 2023 20:25:02 +0200 (CEST)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF13186BFE
 for <u-boot@lists.denx.de>; Sun, 10 Sep 2023 20:24:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=abbaraju.manojsai@amarulasolutions.com
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-68fb79ef55eso584002b3a.0
 for <u-boot@lists.denx.de>; Sun, 10 Sep 2023 11:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1694370298; x=1694975098;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8NFcFUftAGw4mATUlBHPwydw3iQqOBubNHFK1k/szH4=;
 b=dLQ2HX+DeEaI4jqlGuPAN1yE0E/LY+/jaQVLHIEBbj64mC2TI5Njr7PTB6ShZS7dJJ
 DrQL+K6qcy3cJWKVMiaHkiDo2yw5nEPDzd/wOYC8J2GM/hgrdrM4ldwhsfi8zxme8d+v
 sVLlrm9qOUNWHY0qpKN7IeAEhz8F3ofmKklm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694370298; x=1694975098;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8NFcFUftAGw4mATUlBHPwydw3iQqOBubNHFK1k/szH4=;
 b=CDV833wkbY6suTQUd/dfzcPm3ekMDhCm3wJGx/8uoCj0ugX0/kwtEj4xw4+u2bXuYr
 1Ot/+K5d5t0GO33f78QQL3qYt5bFOfwMuFTLcpwV1RXr4k2sgT8zZ+W8dgrdLFTjbYg8
 EhF2cnukBAxZqyZiAcuoBLLQgqmte/Lyhbd32lKd561pbV3GdUg41Ly3Ah8gXQIFEOes
 lQAVLIH1Be44dWG4k203kWdNqhmfKi5+j6xGZS3GRcuidzN8vVSGqst0bMtLrhvZmAii
 DSs7bChy73zxcnmillw92yJapNuy45vR2ug9KFO4F6pFSGGbTAc6p2IDcucaCyUIvDpb
 w8cw==
X-Gm-Message-State: AOJu0YzYQMLWVz9rr9vu3BAietW9aYxngc2cNx9I/tnypk1YFAwl6nrK
 yjdXZMe3261ezi/mqu5nBK2uIQ==
X-Google-Smtp-Source: AGHT+IHgw9Gc37mXpaXwmlo3ct/JTbROj/8rUhbnxKG3QjBawdbpeNhsIeHlpf2swB8TZlaCXOAAuw==
X-Received: by 2002:a05:6a00:2384:b0:68b:fcb9:74f9 with SMTP id
 f4-20020a056a00238400b0068bfcb974f9mr10159053pfc.33.1694370297987; 
 Sun, 10 Sep 2023 11:24:57 -0700 (PDT)
Received: from localhost.localdomain ([49.204.31.103])
 by smtp.gmail.com with ESMTPSA id
 a5-20020a655c85000000b0055b61cd99a1sm3720593pgt.81.2023.09.10.11.24.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Sep 2023 11:24:57 -0700 (PDT)
From: Manoj Sai <abbaraju.manojsai@amarulasolutions.com>
To: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.denx.de
Cc: dsx724 <da@lessconfused.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Suniel Mahesh <sunil@amarulasolutions.com>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>
Subject: [PATCH v3 1/4] spl: fit: support for booting a GZIP-compressed U-boot
 binary
Date: Sun, 10 Sep 2023 23:54:45 +0530
Message-Id: <20230910182448.285542-2-abbaraju.manojsai@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230910182448.285542-1-abbaraju.manojsai@amarulasolutions.com>
References: <20230725035101.281325-1-abbaraju.manojsai@amarulasolutions.com>
 <20230910182448.285542-1-abbaraju.manojsai@amarulasolutions.com>
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

If GZIP Compression support is enabled, GZIP compressed U-Boot binary
will be at a specified RAM location which is defined at
CONFIG_SYS_LOAD_ADDR and will be assign it as the source address.

gunzip function in spl_load_fit_image ,will decompress the GZIP
compressed U-Boot binary which is placed at
source address(CONFIG_SYS_LOAD_ADDR)  to the default
CONFIG_SYS_TEXT_BASE location.

spl_load_fit_image function will load the decompressed U-Boot
binary, which is placed at the CONFIG_SYS_TEXT_BASE location.

Signed-off-by: Manoj Sai <abbaraju.manojsai@amarulasolutions.com>
Signed-off-by: Suniel Mahesh <sunil@amarulasolutions.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
Changes in v3:
 - Replaced spl_decompression_enabled() function instead of
   checking IS_ENABLED(CONFIG_SPL_GZIP).

 - Removed checking IS_ENABLED(CONFIG_SPL_LZMA) in spl_decompression_enabled()
   function.

Changes in v2:
 - New patch for v2

 common/spl/spl_fit.c |  9 ++++++---
 include/spl.h        | 10 ++++++++++
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index 730639f756..eb97259f57 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -239,14 +239,14 @@ static int spl_load_fit_image(struct spl_load_info *info, ulong sector,
 	bool external_data = false;
 
 	if (IS_ENABLED(CONFIG_SPL_FPGA) ||
-	    (IS_ENABLED(CONFIG_SPL_OS_BOOT) && IS_ENABLED(CONFIG_SPL_GZIP))) {
+	    (IS_ENABLED(CONFIG_SPL_OS_BOOT) && spl_decompression_enabled())) {
 		if (fit_image_get_type(fit, node, &type))
 			puts("Cannot get image type.\n");
 		else
 			debug("%s ", genimg_get_type_name(type));
 	}
 
-	if (IS_ENABLED(CONFIG_SPL_GZIP)) {
+	if (spl_decompression_enabled()) {
 		fit_image_get_comp(fit, node, &image_comp);
 		debug("%s ", genimg_get_comp_name(image_comp));
 	}
@@ -281,7 +281,10 @@ static int spl_load_fit_image(struct spl_load_info *info, ulong sector,
 			return 0;
 		}
 
-		src_ptr = map_sysmem(ALIGN(load_addr, ARCH_DMA_MINALIGN), len);
+		if (spl_decompression_enabled() && image_comp == IH_COMP_GZIP)
+			src_ptr = map_sysmem(ALIGN(CONFIG_SYS_LOAD_ADDR, ARCH_DMA_MINALIGN), len);
+		else
+			src_ptr = map_sysmem(ALIGN(load_addr, ARCH_DMA_MINALIGN), len);
 		length = len;
 
 		overhead = get_aligned_image_overhead(info, offset);
diff --git a/include/spl.h b/include/spl.h
index 93e906431e..3a7e448cc7 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -897,4 +897,14 @@ struct legacy_img_hdr *spl_get_load_buffer(ssize_t offset, size_t size);
 
 void board_boot_order(u32 *spl_boot_list);
 void spl_save_restore_data(void);
+
+/*
+ * spl_decompression_enabled() - check decompression support is enabled for SPL build
+ *
+ * Returns  true  if decompression support is enabled, else False
+ */
+static inline bool spl_decompression_enabled(void)
+{
+	return IS_ENABLED(CONFIG_SPL_GZIP);
+}
 #endif
-- 
2.25.1

