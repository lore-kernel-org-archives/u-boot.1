Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B7A5CF58E5
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 08:13:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E9F3893EC;
	Fri, 20 Sep 2024 10:13:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WXPoPn8+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBC5B893BE; Fri, 20 Sep 2024 10:13:25 +0200 (CEST)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD883893C5
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 10:13:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-535be093a43so2270425e87.3
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 01:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726820003; x=1727424803; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0SVQLx15FN6YcUVrnEKqeznpC7TKhyJucaP2+ar0imA=;
 b=WXPoPn8+rtu+0HMcSRQiTf4mN8qJEze4VxrcTnf26is2C3TjmOUe/obpN6i4/wUlE7
 Z40aR+20mIJOOjSJ+QAEpgN7ngeT0QkucZLrQjiTG/PGtjxMmy4YBrTNDzGLSuD0XhqF
 IBFFniaVmGPpjgRkTsdsqJyTN50DRcgD2BdCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726820003; x=1727424803;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0SVQLx15FN6YcUVrnEKqeznpC7TKhyJucaP2+ar0imA=;
 b=SFs7p0pP0f9Ry16bAWn+7n0cENfg/DT35hW5Gjp6Cyi5UpB3i4F5YxCRh9YfwehmtK
 vSC3NwKyaav3YCv0O4V7zuxFAtnnB3duWCiljcp1MvI5yNBklYk+q6Knh2wSKrxRzG44
 g6Kpr3jfm3+aikmLxnzUgr18a69Bw1zDqfyf33fwId0Xp8hCvbkgimVQ3Fwk9vNNHhfB
 VrUY9CLpThqI2Ngp9ociLqGDjcVsiUeZxAIj91YgiUvDiHEkuctpdIltNzSn9UXhrjBj
 SWR82FKWX1vjtVLXxmdVIvOD/d746ssZ+jk1hDZbYrwu42SXLPBmamnA8RklAgOD6WsN
 EJVQ==
X-Gm-Message-State: AOJu0YxIFBjPaf/0Fc0NJelfWc3fJFmf794lJWlBpxc83M4mB2aTZD2S
 o9S9T6iuj5he1fqR6fz4IuUImvh1ChAq31+y9//UoivewWBUjj6jc4FbhsRh+7Tp8+qTdVJNv3E
 12Dl7
X-Google-Smtp-Source: AGHT+IGTNJdxbNV87pvWNLyiq0sS//F6JekjsJXWCyU7U4f5mf/uJi3I2RxGStnMyL5HV9l2uxhiVg==
X-Received: by 2002:a05:6512:398f:b0:535:63a9:9d8c with SMTP id
 2adb3069b0e04-536ac2e511cmr793414e87.17.1726820002850; 
 Fri, 20 Sep 2024 01:13:22 -0700 (PDT)
Received: from chromium.org ([83.68.141.146]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c42bc88cf7sm6804447a12.90.2024.09.20.01.13.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 01:13:21 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>, Michael Walle <mwalle@kernel.org>,
 Paul-Erwan Rio <paulerwan.rio@gmail.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 02/18] boot: Allow FIT to fall back from best-match option
Date: Fri, 20 Sep 2024 10:12:41 +0200
Message-ID: <20240920081309.140426-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240920081309.140426-1-sjg@chromium.org>
References: <20240920081309.140426-1-sjg@chromium.org>
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

(no changes since v1)

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
index 9da55fe23c2..5d8bee80053 100644
--- a/include/image.h
+++ b/include/image.h
@@ -1411,7 +1411,9 @@ int fit_check_format(const void *fit, ulong size);
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
2.43.0

