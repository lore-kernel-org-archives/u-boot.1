Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D29BFC4332F
	for <u-boot@archiver.kernel.org>; Fri,  3 Nov 2023 14:34:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF47D871CD;
	Fri,  3 Nov 2023 15:34:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zR6M2tlM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1E8E871BC; Fri,  3 Nov 2023 15:34:39 +0100 (CET)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 293CC871E1
 for <u-boot@lists.denx.de>; Fri,  3 Nov 2023 15:34:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=loic.poulain@linaro.org
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-507a29c7eefso2645163e87.1
 for <u-boot@lists.denx.de>; Fri, 03 Nov 2023 07:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699022075; x=1699626875; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d1blHmjAjkOpfB5rtWBv7BqFpGVriQg1Lyul871M1W4=;
 b=zR6M2tlMzQd8fqG+LPRioMEZ4gAWe0bBhY2bdHops45nkpCAQkswttDqavMgtb7gkv
 LjmpmlYDwad7AHwDTUreyK0B7dXavLCrnjzT4KN416w6nAVXpZbMLkUUsJ5vRqdUlXMe
 CXASTvCCrt621S7lMO3rZzbVzf5uIJ2WrIlQT7iqWCiTI+AQKHSLjH6aGhUx0LnmWji6
 srVqY2BqIIe05a3rjr46GncPO8MmpQg2jlieHj7DC/nwDPyHrj1b3elwSnC3S/GPAXzT
 Gut3bL+CyHlvJhTqXFE20+C7kpIz22kHSN6mbbhYug3GhoC0rXm4rpZZrCqwEjHW5kk7
 cu+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699022075; x=1699626875;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d1blHmjAjkOpfB5rtWBv7BqFpGVriQg1Lyul871M1W4=;
 b=GO00YPriL0+4Jw8zTUlyRzDs2cXnh0JzZ9QWMJEwaLPu2ndV7RxaRpX6y4ntzpigdj
 lfRx42WxDXWmEzHBQ++6N0yx66GUhYulj/3KtUNJLoLICuOlDqIhfS2U1v4BsHK+3QxV
 7SJxMazPMNdybCe7JDoQbI7c09NZ+vuAVMRLgLua5RWIwWpKnu3HiPyqOk8nB986yata
 fACC9RG5xSoZOVwG7KjMlwlHou9oGQ1+vQtkgp6khS2+1THcWvirtAPhzaGPbanfozYU
 ykQDZvKqzQGMZuT386GRBQ7vrb7SyGnHmppTB3Ke5kbH88unmkb9rrQziii4cioshFn+
 rGCw==
X-Gm-Message-State: AOJu0Yxwox4MCfFal4jkkuhFa+iWqYTP2zSF+QHHWCp1I4Z6hIfWW30b
 8mE8MfymQUexm9IcfgbIrkBIGg==
X-Google-Smtp-Source: AGHT+IHY+TnSFQVWdLIiM/OfnvZkZjqRV7xApvOLI20aqZn790w/HtY9tmv/ai+vCQVUkPCkmnQ88A==
X-Received: by 2002:ac2:4c3c:0:b0:509:44bc:8596 with SMTP id
 u28-20020ac24c3c000000b0050944bc8596mr4680469lfq.58.1699022075299; 
 Fri, 03 Nov 2023 07:34:35 -0700 (PDT)
Received: from loic-ThinkPad-T470p.. ([2a01:e0a:82c:5f0:bd3f:e301:dcee:2fff])
 by smtp.gmail.com with ESMTPSA id
 12-20020a05600c020c00b004063ea92492sm2683598wmi.22.2023.11.03.07.34.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Nov 2023 07:34:34 -0700 (PDT)
From: Loic Poulain <loic.poulain@linaro.org>
To: sjg@chromium.org,
	marex@denx.de
Cc: u-boot@lists.denx.de, abbaraju.manojsai@amarulasolutions.com,
 seanga2@gmail.com, Loic Poulain <loic.poulain@linaro.org>
Subject: [PATCH 3/3] spl: fit: Load compressed blob to heap buffer
Date: Fri,  3 Nov 2023 15:34:26 +0100
Message-Id: <20231103143426.3643712-3-loic.poulain@linaro.org>
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

CONFIG_SYS_LOAD_ADDR is usually configured as the address where
the kernel should be loaded at. It can be problematic to use it
as a generic temporary buffer for FIT compressed blobs.

An example is when the image is a compressed kernel with load
address equal to CONFIG_SYS_LOAD_ADDR, this causes (inplace)
decompression to fail.

Instead we can simply allocate a temporary buffer in the heap

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
---
 common/spl/spl_fit.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index 08428660b0..8a807db5ba 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -249,7 +249,7 @@ static int load_simple_fit(struct spl_load_info *info, ulong sector,
 	ulong size;
 	ulong load_addr;
 	void *load_ptr;
-	void *src;
+	void *src, *src_ptr;
 	ulong overhead;
 	int nr_sectors;
 	uint8_t image_comp, type = -1;
@@ -289,8 +289,6 @@ static int load_simple_fit(struct spl_load_info *info, ulong sector,
 	}
 
 	if (external_data) {
-		void *src_ptr;
-
 		/* External data */
 		if (fit_image_get_data_size(fit, node, &len))
 			return -ENOENT;
@@ -302,10 +300,13 @@ static int load_simple_fit(struct spl_load_info *info, ulong sector,
 			return 0;
 		}
 
-		if (image_comp != IH_COMP_NONE)
-			src_ptr = map_sysmem(ALIGN(CONFIG_SYS_LOAD_ADDR, ARCH_DMA_MINALIGN), len);
-		else
+		if (image_comp != IH_COMP_NONE) {
+			src_ptr = malloc_cache_aligned(len + 2 * info->bl_len);
+			if (!src_ptr)
+				return -ENOMEM;
+		} else {
 			src_ptr = map_sysmem(ALIGN(load_addr, ARCH_DMA_MINALIGN), len);
+		}
 		length = len;
 
 		overhead = get_aligned_image_overhead(info, offset);
@@ -383,6 +384,9 @@ static int load_simple_fit(struct spl_load_info *info, ulong sector,
 			image_info->entry_point = FDT_ERROR;
 	}
 
+	if (external_data && image_comp != IH_COMP_NONE)
+		free(src_ptr);
+
 	return 0;
 }
 
-- 
2.34.1

