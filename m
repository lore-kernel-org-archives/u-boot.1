Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A8B0C83F2D
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 14:58:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16E7E88C55;
	Thu, 29 Aug 2024 16:58:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LjohDyRd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2311388C2A; Thu, 29 Aug 2024 16:58:22 +0200 (CEST)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06F5D88C2A
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 16:58:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-39d30f0f831so2669385ab.0
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 07:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724943498; x=1725548298; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=keDK8WpoxdnmmrGjty9ESHIp4bSmIGar8WQ+2qG+S3g=;
 b=LjohDyRd6buFHRFtHxfg92WwTPB30AsUkPzhxno0sK/0PQUSbZfTr5ZaJnlmK2rEbN
 l7S6revG7hipgiw80M1thIl6Jk4WyMj6O1pZ2UoUpurKqZcQPn3JBfbqPIHCRvBq/ySD
 fPqrRyVAA5jkWN437bNnrjEpO/H7JStN55PWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724943498; x=1725548298;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=keDK8WpoxdnmmrGjty9ESHIp4bSmIGar8WQ+2qG+S3g=;
 b=Oh+0WloYoiPvMD3RvmbLv7RGCCYR0/Whog+BHtUyQ6tya7/x1Hcr0Vwg8gsKauoIr2
 O/kLGwbGRjVSasrJC84xeKM9wOXMHTC2K2gwCxCp+sfj+JQW6/6AWXS2FbjQWHL1/Js9
 ffvGPZfqo29/3gPenznbQvxQC2WaFmR4yByAUQz95pUKJLxfJiia+kcsc1RINPGDJMVd
 haIAt+Y9kmgjKbQIxCGsZm+a9xw75duq9UGH+74P16UzRZFnyw1pUGmulFGoYVwTdqfE
 t9vjBYPQ7hrbZBo0+Yjf/Wdmnp+oSZlfAGaYB6nPnwUNX6usHszzMz42tMdYBXv1bA7d
 VHpA==
X-Gm-Message-State: AOJu0YwsQCGwyWziPD3xNjyGa53v43Qfj6FCSciimOcbY8rpds0Nm4Yf
 FXzcxquRrJG5m5J70EclvDyIl4aGuUYxM4uXaRb18Xq0KtfbX6Jaq7OYlv3UokTCGhLHB+Pkh1M
 =
X-Google-Smtp-Source: AGHT+IGn6D9AoY6Uurr3jbgC/eeRWGlQrmySf+iufriJPnz9xmeELXELcLBfwvVYa4gewU9QFjDeIg==
X-Received: by 2002:a05:6e02:2183:b0:39f:3692:7cdd with SMTP id
 e9e14a558f8ab-39f377cb8ffmr36416865ab.3.1724943498439; 
 Thu, 29 Aug 2024 07:58:18 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ced2dcdd2bsm284900173.21.2024.08.29.07.58.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2024 07:58:18 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Eddie James <eajames@linux.ibm.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Paul-Erwan Rio <paulerwan.rio@gmail.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Roman Stratiienko <r.stratiienko@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 03/19] boot: Allow FIT to fall back from best-match option
Date: Thu, 29 Aug 2024 08:57:46 -0600
Message-Id: <20240829145802.1827952-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240829145802.1827952-1-sjg@chromium.org>
References: <20240829145802.1827952-1-sjg@chromium.org>
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

When the best-match feature fails to find something, use the provided
config name as a fallback. The allows SPL to select a suitable config
when best-match is enabled.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/image-fit.c | 19 ++++++++++---------
 include/image.h  |  4 +++-
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index 7d56f0b5e6e..439ff51edf6 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -1729,13 +1729,13 @@ int fit_conf_find_compat(const void *fit, const void *fdt)
 	images_noffset = fdt_path_offset(fit, FIT_IMAGES_PATH);
 	if (confs_noffset < 0 || images_noffset < 0) {
 		debug("Can't find configurations or images nodes.\n");
-		return -1;
+		return -EINVAL;
 	}
 
 	fdt_compat = fdt_getprop(fdt, 0, "compatible", &fdt_compat_len);
 	if (!fdt_compat) {
 		debug("Fdt for comparison has no \"compatible\" property.\n");
-		return -1;
+		return -ENXIO;
 	}
 
 	/*
@@ -1812,7 +1812,7 @@ int fit_conf_find_compat(const void *fit, const void *fdt)
 	}
 	if (!best_match_offset) {
 		debug("No match found.\n");
-		return -1;
+		return -ENOENT;
 	}
 
 	return best_match_offset;
@@ -2095,17 +2095,18 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 		 * fit_conf_get_node() will try to find default config node
 		 */
 		bootstage_mark(bootstage_id + BOOTSTAGE_SUB_NO_UNIT_NAME);
-		if (IS_ENABLED(CONFIG_FIT_BEST_MATCH) && !fit_uname_config) {
-			cfg_noffset = fit_conf_find_compat(fit, gd_fdt_blob());
-		} else {
-			cfg_noffset = fit_conf_get_node(fit, fit_uname_config);
-		}
-		if (cfg_noffset < 0) {
+		ret = -ENXIO;
+		if (IS_ENABLED(CONFIG_FIT_BEST_MATCH) && !fit_uname_config)
+			ret = fit_conf_find_compat(fit, gd_fdt_blob());
+		if (ret < 0 && ret != -EINVAL)
+			ret = fit_conf_get_node(fit, fit_uname_config);
+		if (ret < 0) {
 			puts("Could not find configuration node\n");
 			bootstage_error(bootstage_id +
 					BOOTSTAGE_SUB_NO_UNIT_NAME);
 			return -ENOENT;
 		}
+		cfg_noffset = ret;
 
 		fit_base_uname_config = fdt_get_name(fit, cfg_noffset, NULL);
 		printf("   Using '%s' configuration\n", fit_base_uname_config);
diff --git a/include/image.h b/include/image.h
index dbf8d0e7ba9..92128180e0f 100644
--- a/include/image.h
+++ b/include/image.h
@@ -1423,7 +1423,9 @@ int fit_check_format(const void *fit, ulong size);
  * copied into the configuration node in the FIT image. This is required to
  * match configurations with compressed FDTs.
  *
- * Returns: offset to the configuration to use if one was found, -1 otherwise
+ * Returns: offset to the configuration to use if one was found, -EINVAL if
+ * there a /configurations or /images node is missing, -ENOENT if no match was
+ * found, -ENXIO if the FDT node has no compatible string
  */
 int fit_conf_find_compat(const void *fit, const void *fdt);
 
-- 
2.34.1

