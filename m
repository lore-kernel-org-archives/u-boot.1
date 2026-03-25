Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1563E109C046
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 16:55:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A9E78352B;
	Wed, 25 Mar 2026 17:55:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JwWajHy2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94DEF81E18; Wed, 25 Mar 2026 17:55:37 +0100 (CET)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EBCA83CE3
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 17:55:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-4671cbce32bso1263572b6e.3
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 09:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1774457733; x=1775062533; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0aJrQG8XRWBHZl6VfER3lu7iHsqvl7UsVZRmTMouPOg=;
 b=JwWajHy2vIdjbJ4yWHrk1HyGeVYle9CrWkgmFy5SWEiN4XKFyZ08iwGY0o8DAjLABi
 cw3PDYAfvo83K/AFVtjUaXTuioTvSs1TwdfJ1lRtJ1aEQAxIGRPSON1wyx9KGeJsaBhK
 hn/kk3D8kKd5u/r8ly+pujYpQQc2Bf3HRpKAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774457733; x=1775062533;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0aJrQG8XRWBHZl6VfER3lu7iHsqvl7UsVZRmTMouPOg=;
 b=lIwt7S+0/GVICjyWsVLAT+3ftet/dA2RkmevpOhSmz4q0L+znEV6LFu0/FDIVHQwRN
 KIrG6SNp4ac0E8D5+a4wwJHo9olUVFtvtVY6HPAnkTnLRtZpet8MDNfSa3k4h1+f9Bog
 JbLwApLAIShxYd3KrlRG39GZLJgxm8laNuQmxShK3cXxYA+QqZ7ezFZPh1ba/+vh36MW
 Z4B442mmkm0vmt5lGIS0jgoCNHVHOgsmDDUIb+CkPcZvMNg8liEAlT1uJDSIjvVkDnQi
 uTbyde3YdqG8YlminZk4ZRhD1nqnODPAgmrY6JDytXsZFbP0EO/NV6UHK4JOaOEuOKHF
 TGzQ==
X-Gm-Message-State: AOJu0YxUOLyVI9uhz4SNE+Ftrp13DF5UAakAb3zKkRIl9Bd06oHkiqA8
 eeVMOSU0PIQCSEeKQ+r7WIpVv7xOiFx7kVnNx6Z3BDT+K8XcVn2M0CMDRr83I8Je5yBQfyLKgG1
 cbIjR5g==
X-Gm-Gg: ATEYQzzzwRehmlLQMkfbTMq2/yzry4OGt5KQ/CmEWq5H1lrvmCXu5psYnlhYvr5ssiW
 GxbkKg5XIWpH+BjcGK9OYJA2C3P+qvDKKjl5XHSEkL1tDM7uI9/SCtTZ7sFfxIaYY1XHtpjNdnS
 zqZJfF260sCrxqLVim4b39SEh+gi8raN2qcgP2uK1rP3BwpShKlMEN6Gar1ZA+kltVgevss5Ktq
 NQf1vqTfDHSgaLSYpEOVanZrz7GnMq8wQeziywLnETtIrI7+15uHKGBFefcI2hPAdnYnnAO7wDK
 v77W+0olRNKpaxSO3YE1GcXO+cXpKw4an79+I+2hlFBpbJ2JpDEiOFUlDbTnPLxvudLtUPznFe/
 dcFEhcmXxOpems+Vx7hXqJSIW4xGAuy2SfXCWYDRlcUXhLByh42nJDyiFUGxTeeL/wOk0juF0NM
 fjtERZ1CNnTy1mpuFPIg==
X-Received: by 2002:a05:6808:1a02:b0:468:e7b:c8eb with SMTP id
 5614622812f47-46a5c7248f6mr1962771b6e.37.1774457733615; 
 Wed, 25 Mar 2026 09:55:33 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-46a7099df08sm30481b6e.15.2026.03.25.09.55.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 09:55:32 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, James Hilliard <james.hilliard1@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 02/13] boot: Move call to fit_image_select() and rename it
Date: Wed, 25 Mar 2026 10:54:11 -0600
Message-ID: <20260325165431.1027591-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260325165431.1027591-1-sjg@chromium.org>
References: <20260325165431.1027591-1-sjg@chromium.org>
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

This function is named a bit vaguely, since it prints some info and then
does verification of the image.

Rename it to print_and_verify() and move the call to select_image().

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/image-fit.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index a4402dcff63..f8772f64cb3 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -1989,7 +1989,7 @@ int fit_get_data_conf_prop(const void *fit, const char *prop_name,
 	return fit_get_data_tail(fit, noffset, data, size);
 }
 
-static int fit_image_select(const void *fit, int rd_noffset, int verify)
+static int print_and_verify(const void *fit, int rd_noffset, int verify)
 {
 	fit_image_print(fit, rd_noffset, "   ");
 
@@ -2168,6 +2168,11 @@ static int select_image(const void *fit, struct bootm_headers *images,
 		*fit_unamep = fit_get_name(fit, noffset, NULL);
 
 	printf("   Trying '%s' %s subimage\n", *fit_unamep, prop_name);
+	ret = print_and_verify(fit, noffset, images->verify);
+	if (ret) {
+		bootstage_error(bootstage_id + BOOTSTAGE_SUB_HASH);
+		return ret;
+	}
 
 	return noffset;
 }
@@ -2190,7 +2195,6 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 	ulong load, load_end, data, len;
 	uint8_t os, comp;
 	const char *prop_name;
-	int ret;
 
 	fit = map_sysmem(addr, 0);
 	prop_name = fit_get_image_type_property(ph_type);
@@ -2205,12 +2209,6 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 	if (noffset < 0)
 		return noffset;
 
-	ret = fit_image_select(fit, noffset, images->verify);
-	if (ret) {
-		bootstage_error(bootstage_id + BOOTSTAGE_SUB_HASH);
-		return ret;
-	}
-
 	bootstage_mark(bootstage_id + BOOTSTAGE_SUB_CHECK_ARCH);
 	if (!tools_build() && IS_ENABLED(CONFIG_SANDBOX)) {
 		if (!fit_image_check_target_arch(fit, noffset)) {
-- 
2.43.0

