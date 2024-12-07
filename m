Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D60BE7717D
	for <u-boot@archiver.kernel.org>; Sat,  7 Dec 2024 17:26:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99F1289376;
	Sat,  7 Dec 2024 18:26:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nMVMDtmy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AD3388FB4; Sat,  7 Dec 2024 18:26:10 +0100 (CET)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B70E089428
 for <u-boot@lists.denx.de>; Sat,  7 Dec 2024 18:26:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-84197c469cfso95432539f.3
 for <u-boot@lists.denx.de>; Sat, 07 Dec 2024 09:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733592366; x=1734197166; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2lG7yZEBrm4ZJcy4WFBOngwrT3gczjb1H7yUaUlX1mg=;
 b=nMVMDtmyxfVM6ZFAg9kt7ejE1H4b/C12QsdP578qUQj8UHPWu4SFJTuNaQqlXv2CYf
 nLktUwMpB21UUWz1dTpPhSlIdE6A5f/aQ/5dQb+L+becA59bcQbB3OiyvBy5Tdpk2e4V
 6uzh8CAWQ2z6Yiw34HIYW8itdMm6p8arRoWIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733592366; x=1734197166;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2lG7yZEBrm4ZJcy4WFBOngwrT3gczjb1H7yUaUlX1mg=;
 b=S/TycxnYKPzT9WgO90uLcwywGwiA6eMzv0TX/rrvIUDF+UWiV2+rWgGXz4vgkInXki
 /RYWTmAtK81+hFimqCrIYXX3qS/kbeM9rBdVfucOAkF2mYY5Das4vnonkzdbzUBLwCew
 /fYdHEZQ4BTF1Vnvke7+qtTRSFdw2aLffCBgoxwhdh9uPTd/gpy61g2Yu/gJanZyASYw
 pc/IoFu5eeKwBM/HhVQXlLICHqBL8rUxBdvtjn8ZMT4yjV0QwL0x4EWvTcJO2ywgl99X
 moDrrp4LoI1hhnPEwimnvFHYcW6uYGNOtBDhSwf/h4So9vPaesmWRvE657zmGuPGUj2/
 YDbQ==
X-Gm-Message-State: AOJu0Yy+rIUv7sz+mDtMZM8Cv8uA9njzwm1SrhU/wvOHS16Dw1wZ62dy
 FoTaQ5DFcbxP1oyTJZsALkwXADPSmd1V5zy0nQiPdiuTkPmq5PDsuh0lJbchXhmn45dkL/3Gskw
 =
X-Gm-Gg: ASbGncuVnU4960CGXmF3zJIALyCMtEpTqSGVW0IqB8jZgBYaEnwmlfRssW/2afNToDe
 Wor+6+sKWBqtNJnH5KR2VkO1C4vhVAl2WGKJfBQ0n1UwgYPmCul9NtAre4BDux0jIeUOsf6uSKk
 f1yO3zCPzD8E1InkmAwCGX0zI5UYpZ9n+u/pUylsoiblNOo6AvYVnXB/GriWqv34doPLBKgUYVo
 7M7xfEa3cBpjBjvLuHVfYEVz6Cb+YFhwlRXBhjnxSLtlrSvZZ1TOMCn0BuUGLcbjIcmH54H3QlJ
 zZzlxUnAPR8=
X-Google-Smtp-Source: AGHT+IEioTJHp4++UT6L5bgtCBboRRmnelWBnuWirBNx9BthNDfC0Yru3B0iwWrMOf/i59S9aSKAMg==
X-Received: by 2002:a05:6602:6d01:b0:83a:639b:bc44 with SMTP id
 ca18e2360f4ac-8447e200059mr709002439f.3.1733592365948; 
 Sat, 07 Dec 2024 09:26:05 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84473a7080csm171745739f.45.2024.12.07.09.26.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Dec 2024 09:26:04 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Guillaume La Roque <glaroque@baylibre.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>, Michael Walle <mwalle@kernel.org>,
 Paul-Erwan Rio <paulerwan.rio@gmail.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 03/19] boot: Allow FIT to fall back from best-match option
Date: Sat,  7 Dec 2024 10:23:56 -0700
Message-Id: <20241207172412.1124558-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241207172412.1124558-1-sjg@chromium.org>
References: <20241207172412.1124558-1-sjg@chromium.org>
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

