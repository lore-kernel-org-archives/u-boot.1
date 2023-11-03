Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37633C4332F
	for <u-boot@archiver.kernel.org>; Fri,  3 Nov 2023 14:34:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F1E1871D7;
	Fri,  3 Nov 2023 15:34:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="J3Q1frg3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9FBF871F8; Fri,  3 Nov 2023 15:34:39 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47A57871BC
 for <u-boot@lists.denx.de>; Fri,  3 Nov 2023 15:34:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=loic.poulain@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-409299277bbso15340125e9.2
 for <u-boot@lists.denx.de>; Fri, 03 Nov 2023 07:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699022074; x=1699626874; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cJhhyMenV7+iux6HdJl6SCGZhk9zr2Y8OMnHhWQG64E=;
 b=J3Q1frg3uwRI0h4O3lLQV6HHr0I4pTRRn3Dc1t1YCcuV3xkPCMHxNgCB6BkglGnELE
 Y6MkCRm8ostFVw2VOwWdTicaxrl//VEAO1jXgm7tK9f62cZ2WVQ/68Iletz2VgobFqGE
 aQtWNBBSYA+lrsgWBewyoauXJ36AfOfN2IBDKTVTGUcalvSeYpTfH3YX9t8bSjItdw6u
 jbwerhPk68wKui3dAQA513GTP7o7wncR0KiLuh80r+Em1To417dP8IiMrK8SzaoKL8ce
 C3biUHCfM08LkUDECQZj3qK3fUVO+7J2GG6gOuT70pKYgQE0V3WIBNnqgaGYG4GTgrxt
 FASw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699022074; x=1699626874;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cJhhyMenV7+iux6HdJl6SCGZhk9zr2Y8OMnHhWQG64E=;
 b=McOJx5KbpSq5E2wmhOnai5zQv6lvTvWpMaTsmur6eL7zeCsUiCN9BuFY+fNlPbcZLN
 b36EHQxRay1MXeuTEodtiZZRPy6H+LXAh0L8PPGqdNIenxC8dq3RfmxOPRnCVzyzZxri
 adoTjiyT3Yca10WHatwlI0bRfv2uv4ZkwoRJe6d4Oi7n8+ISCP/1kFxXjiQ8uVJsi9MD
 r6uoZxi+cwVThqItRBMK5xlYukKPNXUB6cika9FcVgxfozGM6JL+qA1JPbV7KBGHQcMW
 Z8jrjg1pMXbgoToPmpozj8BamU5SfWbgtlKKad5vh3I5YAJoHrMUKdjuqLs99rfIamZG
 Evgg==
X-Gm-Message-State: AOJu0Yxldp+pTUapQQ+MWZB/ajcFlHA/j30MNE2LBguiFjha9gFqGjxY
 mB7LztPhY6Y6ph5spsAsCGUw3Q==
X-Google-Smtp-Source: AGHT+IFNKW9M/cfpkIY23CEl7VzIHLqOLpoWNCOjpmEbVVLOL6Z/jIoDsRXYT2NLC7/up7mYKO1FKQ==
X-Received: by 2002:a05:600c:4f92:b0:402:f55c:faee with SMTP id
 n18-20020a05600c4f9200b00402f55cfaeemr17245326wmq.26.1699022073657; 
 Fri, 03 Nov 2023 07:34:33 -0700 (PDT)
Received: from loic-ThinkPad-T470p.. ([2a01:e0a:82c:5f0:bd3f:e301:dcee:2fff])
 by smtp.gmail.com with ESMTPSA id
 12-20020a05600c020c00b004063ea92492sm2683598wmi.22.2023.11.03.07.34.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Nov 2023 07:34:33 -0700 (PDT)
From: Loic Poulain <loic.poulain@linaro.org>
To: sjg@chromium.org,
	marex@denx.de
Cc: u-boot@lists.denx.de, abbaraju.manojsai@amarulasolutions.com,
 seanga2@gmail.com, Loic Poulain <loic.poulain@linaro.org>
Subject: [PATCH 2/3] spl: fit: Add support for LZO compressed images
Date: Fri,  3 Nov 2023 15:34:25 +0100
Message-Id: <20231103143426.3643712-2-loic.poulain@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231103143426.3643712-1-loic.poulain@linaro.org>
References: <20231103143426.3643712-1-loic.poulain@linaro.org>
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

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
---
 common/spl/spl_fit.c | 10 ++++++++++
 include/spl.h        |  4 +++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index 1d42cb1d10..08428660b0 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -18,6 +18,7 @@
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <linux/libfdt.h>
+#include <linux/lzo.h>
 #include <linux/printk.h>
 
 DECLARE_GLOBAL_DATA_PTR;
@@ -215,6 +216,8 @@ static inline bool spl_fit_decompression_supported(uint8_t comp)
 		return IS_ENABLED(CONFIG_SPL_GZIP);
 	case IH_COMP_LZMA:
 		return IS_ENABLED(CONFIG_SPL_LZMA);
+	case IH_COMP_LZO:
+		return IS_ENABLED(CONFIG_SPL_LZO);
 	case IH_COMP_NONE:
 		return true;
 	}
@@ -357,6 +360,13 @@ static int load_simple_fit(struct spl_load_info *info, ulong sector,
 			return -EIO;
 		}
 		length = loadEnd - CONFIG_SYS_LOAD_ADDR;
+	} else if (IS_ENABLED(CONFIG_SPL_LZO) && image_comp == IH_COMP_LZO) {
+		size = CONFIG_SYS_BOOTM_LEN;
+		if (lzop_decompress(src, length, load_ptr, &size)) {
+			puts("Uncompressing error\n");
+			return -EIO;
+		}
+		length = size;
 	} else {
 		memcpy(load_ptr, src, length);
 	}
diff --git a/include/spl.h b/include/spl.h
index 8ff20adc28..e07092372a 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -1016,6 +1016,8 @@ int spl_load_fit_image(struct spl_image_info *spl_image,
  */
 static inline bool spl_decompression_enabled(void)
 {
-	return IS_ENABLED(CONFIG_SPL_GZIP) || IS_ENABLED(CONFIG_SPL_LZMA);
+	return IS_ENABLED(CONFIG_SPL_GZIP) || IS_ENABLED(CONFIG_SPL_LZMA) ||
+		IS_ENABLED(CONFIG_SPL_LZO);
 }
+
 #endif
-- 
2.34.1

