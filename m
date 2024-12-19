Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3295E77184
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 18:29:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 979E180352;
	Thu, 19 Dec 2024 19:29:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Viw7hu8o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4268480351; Thu, 19 Dec 2024 19:29:24 +0100 (CET)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 047BE8031D
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 19:29:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-3a81a0277d3so3349115ab.3
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 10:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734632960; x=1735237760; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2lG7yZEBrm4ZJcy4WFBOngwrT3gczjb1H7yUaUlX1mg=;
 b=Viw7hu8oKz2+r6Uq886OaIIk8/I/TvauhpxL7qsxgbbuposu3VLl5xt7kNAp8vK3qe
 atva5PyBp4gQLpJ6P6wFQjtm7I3sxaK9jLD6xGZyXdyKedQPAOQw+Rm2UdxsfuP2AQkl
 dG1MDid3t+FnBbdwlsdxOmJAgBBmkiqZTwmIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734632960; x=1735237760;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2lG7yZEBrm4ZJcy4WFBOngwrT3gczjb1H7yUaUlX1mg=;
 b=SkpaSzQMtwY3FkjiTY/Y7/3IY4aYXEJk57HjClr1LWsiDujcWGI9xY53GWD0honDGJ
 CIXU/30oDyMu4pa0s9BeqA/9RKLp9b2EsO5MWHGHoCt9rZNSmTAdj1sIGIdBBzBzWd2O
 OnYninxannG0hvHJ+MR/jjVBEmG0HTrLWACq4rJywfnm0GiY+85+yII3BzTazgTidIkD
 tuCfu67nh2GQ+FYw5bPFTCziSqeBHYM6nTZ2Pb/enWx28QC5/vyF9SBdMK5QAHbfVbLZ
 hSw1ZGtTSyI6JPfZKdmx9c8FcbKX+vPa1bSr5moILG0XoExJjSp3clWwQP61Shi92VZE
 BsLw==
X-Gm-Message-State: AOJu0Ywo4ga6ovNJKTpR1Br840sjtpluVbafDNoyQoO27DmgnCOq9Jfl
 XnhvrrqxWe0TFsabloizRBGWMC+kn/3NZMQiRl+i0U/EhtUHjC6RgWOe90Smn+6/ZhGYnU2Aro8
 =
X-Gm-Gg: ASbGncvG7Kh4nAdklgrMuGbqAe4xHPxUkhRhOJldBiClwtH7LBZExV17s/q599WlKiq
 75T2d5M7ZTW4g9T5OTXm23ai3Rj7InnCAmRrcoAGYW7IyvOuYnJX7jlzCAaW8Qd17b8wCAkmj/V
 6ZRb48VYDh87/CCcFs3Ncq3Xh8OVKYubxo8dVbQJcCVrW7JnIVYeVajNoslQljt/YnSxvPxuOWX
 2Ocr0nI+erEJljnt7ka03rI2IZC6VjBZzMOiQmjKyiI4MPQTFS2OqLO5dZ3P700XbTxvgu8MFgd
 6Gt85FIP1etsaGigQw==
X-Google-Smtp-Source: AGHT+IG/xZXun0x4crhnYXIE45SMTE6pdxxjLH7Entrpnb3y25EznYm4pmIm0oyW1WDWYqEqTYiScA==
X-Received: by 2002:a05:6e02:216b:b0:3a7:a553:72f with SMTP id
 e9e14a558f8ab-3c2d51501d1mr1134345ab.18.1734632960154; 
 Thu, 19 Dec 2024 10:29:20 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e68bf676c6sm393655173.50.2024.12.19.10.29.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 10:29:19 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Julien Masson <jmasson@baylibre.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Roman Stratiienko <r.stratiienko@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 03/19] boot: Allow FIT to fall back from best-match option
Date: Thu, 19 Dec 2024 11:28:51 -0700
Message-Id: <20241219182907.2609704-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241219182907.2609704-1-sjg@chromium.org>
References: <20241219182907.2609704-1-sjg@chromium.org>
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
index bb15ef69871..ab96510f62c 100644
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
2.34.1

