Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E0D6CD37B4
	for <u-boot@archiver.kernel.org>; Sun, 17 Sep 2023 19:26:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D16FF86785;
	Sun, 17 Sep 2023 21:26:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="esVYhcVP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FE978654B; Sun, 17 Sep 2023 21:26:44 +0200 (CEST)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D39CD863E5
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 21:26:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=abbaraju.manojsai@amarulasolutions.com
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1c0c6d4d650so34792475ad.0
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 12:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1694978800; x=1695583600;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rwLYS4ljijtQyrK66wwZh+ZPMUA7Vw5GskhBFeBiClI=;
 b=esVYhcVPDKryX4EesIi8643avWyqhlDD+qbVeTwpJS6dxk0PbGDr/Jro07Q/THNWiN
 ZZhZVv7Yg1VkaTOWYJFLImrPVvZ10ouM0q8spFHUlXqA03a+a9rpJCKJziI2AixhXt0Q
 ++Czjpae0FFZ0ZlQ5a9eqAhjAhtrTd8wZ7VFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694978800; x=1695583600;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rwLYS4ljijtQyrK66wwZh+ZPMUA7Vw5GskhBFeBiClI=;
 b=ffomuc4V56QT7Zmi1OtVKu+8mxaHiprh6EkxteIhia131wRxjju6WK2JfcrPF8/ZKq
 8N5qFIUFfZfMjGNDrPAnykbz3Dxs/4oV7/k7KNfIuKJ1lT4PPIm0ou5qcUE6GJuk2WYa
 HSe8Lz+d8vO7IrNE+SFucw8aaOwUT1CjwkVVPfSStJ3a83Kj1jnSxWaDJ9DmzhFJZRzs
 +uz1uGKy5IZz0J0YlT2LTJO0Z4VSRsSFoBQsJAQGwmakN1MmpFcNzVmxqPh4+sX3yVxe
 Brug3OFNSmNC6489tJQa1qzsv3CLSf/KDGDnYrm6uoVCL4j0N1DItn/ERJsBWpNjx0lw
 ogXQ==
X-Gm-Message-State: AOJu0YzaXwiUgL426pUSXaVoaVUB6ZiCg6mj1+vFDj6c6HLTKTbcy5Tx
 UDrgZuBSfQlhv4AHRcJRwTzMcWu8MNqIOOd2ukN9zw==
X-Google-Smtp-Source: AGHT+IFSdnJBQ7qtpfbO5e0HNlUrxuT1jwtR0hCPFmuEvvirwu6WdBfKz7LuXZuvUIHK1Sggs1QDlQ==
X-Received: by 2002:a17:903:124c:b0:1bd:e998:ec0a with SMTP id
 u12-20020a170903124c00b001bde998ec0amr9956346plh.67.1694978800026; 
 Sun, 17 Sep 2023 12:26:40 -0700 (PDT)
Received: from localhost.localdomain ([49.204.31.54])
 by smtp.gmail.com with ESMTPSA id
 iw7-20020a170903044700b001b83e624eecsm6976991plb.81.2023.09.17.12.26.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Sep 2023 12:26:39 -0700 (PDT)
From: Manoj Sai <abbaraju.manojsai@amarulasolutions.com>
To: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.denx.de
Cc: dsx724 <da@lessconfused.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Suniel Mahesh <sunil@amarulasolutions.com>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>
Subject: [PATCH v4 1/4] spl: fit: support for booting a GZIP-compressed U-boot
 binary
Date: Mon, 18 Sep 2023 00:56:25 +0530
Message-Id: <20230917192628.363502-2-abbaraju.manojsai@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230917192628.363502-1-abbaraju.manojsai@amarulasolutions.com>
References: <20230910182448.285542-1-abbaraju.manojsai@amarulasolutions.com>
 <20230917192628.363502-1-abbaraju.manojsai@amarulasolutions.com>
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
Changes in v4:
 - None

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

