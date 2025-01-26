Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D45FAC0218D
	for <u-boot@archiver.kernel.org>; Sun, 26 Jan 2025 18:44:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BEC180FDE;
	Sun, 26 Jan 2025 19:44:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NmIJ35+S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4789A80FD2; Sun, 26 Jan 2025 19:44:10 +0100 (CET)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09FCD80FDC
 for <u-boot@lists.denx.de>; Sun, 26 Jan 2025 19:44:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3cfc8a2415fso8158145ab.2
 for <u-boot@lists.denx.de>; Sun, 26 Jan 2025 10:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737917044; x=1738521844; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r2GnNt+dPJqqlefHZfEztVTc9ypslZro5cxN4kKjfxQ=;
 b=NmIJ35+SjqIhuMAQFxvC2Qi+PDpurkXjAJYilUlqVCnVSxNIlBVXnNT/kBp1FN0WWe
 twHEM07mHg3HvIOa3He1uPWOPWccGYiOR7D+JF4v3M4Qkny54vH3cXqwTT3ltFPXPg/P
 TnvPjXkoueyPah0sumaLDfsoEe5zpYXihaj0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737917044; x=1738521844;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r2GnNt+dPJqqlefHZfEztVTc9ypslZro5cxN4kKjfxQ=;
 b=JjeRIKVHFi5sOvfQoC0tgrxj4vlBhyrpQJs8ivuBDFEykRfM8DRRO9jBAs2H5IIKOh
 zBdU50cDer9quBZruUu1gDmqE4nbPFQIMHPjjIhvCa2kc8UJK3nxo1lPYavyAVuQt4fB
 WO88WkaUho0q4uSJ3iuIFIVZ6CGVMOZx5VSJxYPTJJFWyKNVZBqQDYco3WcgEb/4RWji
 QA1+m63gbSritHCkvm1/WmAQPPywkh8jb5t1eRqJapX6qpSjDovDpQ9GHO3Qba6hL2UG
 iU2j1g8Q6+s37cf4DvYzOi2XjZADv6sS4vVeVQF1bYcQxhjpLvWs3m1wLHmwH7vKeaPX
 rpYw==
X-Gm-Message-State: AOJu0YysLk47OiIqunT30yffz8s45SHXM4W5wd15bSGai43816bGB2aX
 ztHxbO60ZlZbx4O5WFAQgIg+mn3PUQEvcAzRB5V5k8MvnUe9aK94A/TAVvfsjcc9Rd3bBHyq5RA
 =
X-Gm-Gg: ASbGncta8xDlvqiFaAwxkooCJFQza8oYvU+xiPtIoz6481zC5PclNM+vO35YgLu9WxA
 v5pkTP+1Nnu8V//eVfK9VMP0gVYASy03zhfHDwRYO+s+wtG0Aso/L9eU7vKew85AeI0qAsff5fB
 EHRZ9miA5pS0j2Eu9qXmzIC4QKJPwGZhAbg/kkKBL1RHjHGo3STQ39FhAN54Dhdg1jKqCRdoUvd
 OVMOW5AIcTj1IcehwBw0eu9NA7xIDPdhIs9w/FazN7pbNZQUA1EXjTwl+OasakfTNfxGxKZVGa1
 SRTQiDslIZP7XYkQYi4BluoeqAu5miqvyrcCvLkXww==
X-Google-Smtp-Source: AGHT+IHHJDnxvU+IcgCzKh8vcO37FE62JzHTTpRNqTADl08UxO5DvHgnOpO6uAxutI6OEcUpLK4f8Q==
X-Received: by 2002:a05:6e02:2161:b0:3ce:4b12:fa17 with SMTP id
 e9e14a558f8ab-3cf7449dae5mr311097855ab.19.1737917043799; 
 Sun, 26 Jan 2025 10:44:03 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ec1da317fesm2160641173.42.2025.01.26.10.44.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jan 2025 10:44:02 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 08/19] vbe: Support selecting images based on phase in FIT
Date: Sun, 26 Jan 2025 11:43:18 -0700
Message-ID: <20250126184333.4058848-9-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250126184333.4058848-1-sjg@chromium.org>
References: <20250126184333.4058848-1-sjg@chromium.org>
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

With SPL we want to specify the phase of the image to be loaded. Add
support for this.

This is the implementation of a FIT feature added to the spec a few
years ago and entails a small code-size increase, about 70 bytes on
Thumb2.

Signed-off-by: Simon Glass <sjg@chromium.org>
Link: https://docs.u-boot.org/en/latest/usage/fit/index.html
---

 boot/image-fit.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index db7fb61bca9..40335bc3345 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -1908,24 +1908,30 @@ int fit_conf_get_prop_node(const void *fit, int noffset, const char *prop_name,
 	count = fit_conf_get_prop_node_count(fit, noffset, prop_name);
 	if (count < 0)
 		return count;
+	log_debug("looking for %s (%s, image-count %d):\n", prop_name,
+		  genimg_get_phase_name(image_ph_phase(sel_phase)), count);
 
 	/* check each image in the list */
 	for (i = 0; i < count; i++) {
-		enum image_phase_t phase;
+		enum image_phase_t phase = IH_PHASE_NONE;
 		int ret, node;
 
 		node = fit_conf_get_prop_node_index(fit, noffset, prop_name, i);
 		ret = fit_image_get_phase(fit, node, &phase);
+		log_debug("- %s (%s): ", fdt_get_name(fit, node, NULL),
+			  genimg_get_phase_name(phase));
 
 		/* if the image is for any phase, let's use it */
-		if (ret == -ENOENT)
+		if (ret == -ENOENT || phase == sel_phase) {
+			log_debug("found\n");
 			return node;
-		else if (ret < 0)
+		} else if (ret < 0) {
+			log_debug("err=%d\n", ret);
 			return ret;
-
-		if (phase == sel_phase)
-			return node;
+		}
+		log_debug("no match\n");
 	}
+	log_debug("- not found\n");
 
 	return -ENOENT;
 }
@@ -2013,13 +2019,15 @@ int fit_get_node_from_config(struct bootm_headers *images,
 }
 
 /**
- * fit_get_image_type_property() - get property name for IH_TYPE_...
+ * fit_get_image_type_property() - get property name for sel_phase
  *
  * Return: the properly name where we expect to find the image in the
  * config node
  */
-static const char *fit_get_image_type_property(int type)
+static const char *fit_get_image_type_property(int ph_type)
 {
+	int type = image_ph_type(ph_type);
+
 	/*
 	 * This is sort-of available in the uimage_type[] table in image.c
 	 * but we don't have access to the short name, and "fdt" is different
@@ -2071,8 +2079,9 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 	fit_uname = fit_unamep ? *fit_unamep : NULL;
 	fit_uname_config = fit_uname_configp ? *fit_uname_configp : NULL;
 	fit_base_uname_config = NULL;
-	prop_name = fit_get_image_type_property(image_type);
-	printf("## Loading %s from FIT Image at %08lx ...\n", prop_name, addr);
+	prop_name = fit_get_image_type_property(ph_type);
+	printf("## Loading %s (%s) from FIT Image at %08lx ...\n",
+	       prop_name, genimg_get_phase_name(image_ph_phase(ph_type)), addr);
 
 	bootstage_mark(bootstage_id + BOOTSTAGE_SUB_FORMAT);
 	ret = fit_check_format(fit, IMAGE_SIZE_INVAL);
-- 
2.43.0

