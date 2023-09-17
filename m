Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3A66CD13CF
	for <u-boot@archiver.kernel.org>; Sun, 17 Sep 2023 19:27:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3422E8689A;
	Sun, 17 Sep 2023 21:26:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="hDx/j2I7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A54EF86828; Sun, 17 Sep 2023 21:26:46 +0200 (CEST)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73E05863E5
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 21:26:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=abbaraju.manojsai@amarulasolutions.com
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1bf5c314a57so26730875ad.1
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 12:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1694978803; x=1695583603;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cj81afFQT9PjWhuyVuCqKYUPdiMXwjg/z05RU2PO3EY=;
 b=hDx/j2I79gXsFizGLGbmEPusjkzAGsMGofCk0mcJEbQeEREejM4+20txOr0Gn+jAx4
 78M9d7ai5IzUag40nSDLGD3TTk29eDcrWWOtjMasfecN/GRQlN6zZ2iWyjrxIqvA00ox
 tILknO3+8pNANTYmrH+XbrZWd2lNehENVBnTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694978803; x=1695583603;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cj81afFQT9PjWhuyVuCqKYUPdiMXwjg/z05RU2PO3EY=;
 b=PpsN4utKEhf9c1I9h6MSRw8qZZd6voaBs1yfbdoHRoepaY/zyN2R2iSEHI/fDCOhYI
 8sYbQqxlf/yeSIzrK7GUNwIfUT9xODfwb8TJVgg1e3k26R48xRtKynDiP3z9V5trXkpi
 D45WtWskhSBaWq2Dbehg4ZlBdfIIxaz83YAjbEWnX58jxQVBoGMm0tYAK1bq6eBDxJzm
 2gG+MhRQUzTttXOHimNRky1JVWRACFVzSOxyIcVZt1mvfHWtxK7SXHX/TGOHPTiaLnLg
 tpJignf10CN3TsrZ8Wbvtk9nbhcINHp/cm4/j3AFdNr5IwFXoDzzIbpZ6NS9gji7BbCd
 +2Xg==
X-Gm-Message-State: AOJu0YxRi8C7oLryxmXWsqgIOZw/L1n78c1KPPKSceY3bOjSrnad9J3N
 gWOPKL+GnNQYV6KTvQ3wGjB5kg==
X-Google-Smtp-Source: AGHT+IGpf2uI8plE7rYWRd2rIAOnn3+kzOy9G77zeUEBfsSslCBwusmZJYPe2AtWqmdr8yNuEg2/eQ==
X-Received: by 2002:a17:902:aa08:b0:1c5:6157:f068 with SMTP id
 be8-20020a170902aa0800b001c56157f068mr843042plb.69.1694978802743; 
 Sun, 17 Sep 2023 12:26:42 -0700 (PDT)
Received: from localhost.localdomain ([49.204.31.54])
 by smtp.gmail.com with ESMTPSA id
 iw7-20020a170903044700b001b83e624eecsm6976991plb.81.2023.09.17.12.26.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Sep 2023 12:26:42 -0700 (PDT)
From: Manoj Sai <abbaraju.manojsai@amarulasolutions.com>
To: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.denx.de
Cc: dsx724 <da@lessconfused.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Suniel Mahesh <sunil@amarulasolutions.com>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>
Subject: [PATCH v4 2/4] spl: fit: support for booting a LZMA-compressed U-boot
 binary
Date: Mon, 18 Sep 2023 00:56:26 +0530
Message-Id: <20230917192628.363502-3-abbaraju.manojsai@amarulasolutions.com>
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

If LZMA Compression support is enabled, LZMA compressed U-Boot
binary will be placed at a specified RAM location which is
defined at CONFIG_SYS_LOAD_ADDR and will be assigned  as the
source address.

image_decomp() function, will decompress the LZMA compressed
U-Boot binary which is placed at source address(CONFIG_SYS_LOAD_ADDR)
to the default CONFIG_SYS_TEXT_BASE location.

spl_load_fit_image function will load the decompressed U-Boot
binary, which is placed at the CONFIG_SYS_TEXT_BASE location.

Signed-off-by: Manoj Sai <abbaraju.manojsai@amarulasolutions.com>
Signed-off-by: Suniel Mahesh <sunil@amarulasolutions.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
---
Changes in v4:
 - None

Changes in v3:
 - added IS_ENABLED(CONFIG_SPL_LZMA) to spl_decompression_enabled() function.
 - Removed extra parentheses.

Changes in v2:
 - New patch for v2

 common/spl/spl_fit.c | 13 ++++++++++++-
 include/spl.h        |  2 +-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index eb97259f57..75895ef15c 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -281,7 +281,8 @@ static int spl_load_fit_image(struct spl_load_info *info, ulong sector,
 			return 0;
 		}
 
-		if (spl_decompression_enabled() && image_comp == IH_COMP_GZIP)
+		if (spl_decompression_enabled() &&
+		    (image_comp == IH_COMP_GZIP || image_comp == IH_COMP_LZMA))
 			src_ptr = map_sysmem(ALIGN(CONFIG_SYS_LOAD_ADDR, ARCH_DMA_MINALIGN), len);
 		else
 			src_ptr = map_sysmem(ALIGN(load_addr, ARCH_DMA_MINALIGN), len);
@@ -329,6 +330,16 @@ static int spl_load_fit_image(struct spl_load_info *info, ulong sector,
 			return -EIO;
 		}
 		length = size;
+	} else if (IS_ENABLED(CONFIG_SPL_LZMA) && image_comp == IH_COMP_LZMA) {
+		size = CONFIG_SYS_BOOTM_LEN;
+		ulong loadEnd;
+
+		if (image_decomp(IH_COMP_LZMA, CONFIG_SYS_LOAD_ADDR, 0, 0,
+				 load_ptr, src, length, size, &loadEnd)) {
+			puts("Uncompressing error\n");
+			return -EIO;
+		}
+		length = loadEnd - CONFIG_SYS_LOAD_ADDR;
 	} else {
 		memcpy(load_ptr, src, length);
 	}
diff --git a/include/spl.h b/include/spl.h
index 3a7e448cc7..9de93a34cd 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -905,6 +905,6 @@ void spl_save_restore_data(void);
  */
 static inline bool spl_decompression_enabled(void)
 {
-	return IS_ENABLED(CONFIG_SPL_GZIP);
+	return IS_ENABLED(CONFIG_SPL_GZIP) || IS_ENABLED(CONFIG_SPL_LZMA);
 }
 #endif
-- 
2.25.1

