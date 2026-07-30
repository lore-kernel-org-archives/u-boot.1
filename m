Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD058C55162
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 15:31:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7E09081117;
	Thu, 30 Jul 2026 15:31:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sUAeg3_lya2p; Thu, 30 Jul 2026 15:31:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DF7F1810FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785425482;
	bh=XkLk629i+NRG/aGBmGqn7vV/aERQdO9unp1kUVVn5cw=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=Yvl8EUHRiDSuFXuA6KPRWmnc+lZpqiFHYg55Ij1bfvzN+XE62IL4n6U3mgeRz9jKy
	 997WoT3gLhPi9Jwt9l2R583Ix2UHFxnrwmyuyyArZk0Yq8ANsC5XXusqpHLpSpDiJe
	 GG8GxK/D7HOOP3JATFxCyPGVQGXzOr7WRKIKfRO7xnfjcJNWdq3wt4t7W+cpiztiZd
	 OqRJizy6UFKqCZGwTLxNn9yxcqgXEQOrky5DZ/of0Xvhp261Chzju/Tpld9rKv1DD3
	 0byRdA/UD0NGXNN4kKHSgQ4b0PJETIx/yfdVzCU3h600BOc0CYRUnRGUD+QSkD6VNw
	 UCcHjVf90kJtg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DF7F1810FA;
	Thu, 30 Jul 2026 15:31:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id AED642CE
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 15:04:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AC9C680FE8
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 15:04:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9G3pkqBb3Fmp for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 15:04:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::933; helo=mail-ua1-x933.google.com;
 envelope-from=anton@binarly.io; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org B969D80FB5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B969D80FB5
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com
 [IPv6:2607:f8b0:4864:20::933])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B969D80FB5
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 15:04:16 +0000 (UTC)
Received: by mail-ua1-x933.google.com with SMTP id
 a1e0cc1a2514c-967327a0c7dso583298241.1
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 08:04:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785423855; x=1786028655;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XkLk629i+NRG/aGBmGqn7vV/aERQdO9unp1kUVVn5cw=;
 b=Nz1ll3aqh/Zm1mQRAktFHCWmQVf9+BMlbPVKyEtu8xl9B0gS/6pn2HYbNAzxsbXL9M
 X3EDeuyP/nJxhaNaJy7Bnu96TN1LmdMEEWz2g4XEg8/Lfhe11mILA/HUO+fZV7reRxJp
 zSsTuJB5WVqeUT+myZRExQgDq/JwbwFC92tpLLwhlBXfhkhHsdTmPigFJSidxN91pyil
 SHkxZY0pQfzwZOUMpbatkzf9oSAflWut4VSCfejtYhpVQsGWzT8hyy7DdmkoTRrqzB1M
 3gB3IP2OmAfJ16ws/pXKF/OVMU4IDU8uwZqMut0LWoO6Z4l20HwguUvv803l270524r/
 u4tA==
X-Gm-Message-State: AOJu0YxkZ0l/8FBCmX/oyKEwJTMRBiXHZygPu+blwdZbRRuxHPLjacIb
 OVebuf7vlw26ABfrxuoujZOYs9yZIfVW/zcyiCC/IrLoOupl0ZR61b5iSMB2BhqDBSs=
X-Gm-Gg: AR+sD13Z0PrR2KTgoMl8jE6CweREJainydhkV5Gg5bLR0jKA6eg62LIb700ozfc2eF2
 gmLOLPxe1MA2f9JO0LT7doTamw8CSXD7LRlJQhlStdmOz+TQ4YDjMZKXV14XHkx82niQTMQ4KLM
 sk/Aajuw6WDmZIOT5NihI0be3EkHDMpdRtROC3LKxUBY8UGbvQ2vh/8RCgESvAASVkUjTJXXAin
 6gc1JKEdxzpB1U47HASwWNm0zMdS5ivA2GVuSor0rUosF1m+htF5C8VY7ZSS1XmeHVfGz65CLdS
 29A5p4FF4rff0FastDlwBFErY634NYhlGtql+O9WXNGUQfhYIHxZ/3JYakOuORkYD6Ev/V6vrt8
 xrMk7XVQtaAb5yHhTpbicf3kdLRWxlIlIK6mPCcdsnnjZFlkOQ34HUoD8RA/+I5TowesGG4JxCC
 vgqRzV9o0qiLTysZYiSOpyo2+v5gft5UdUUZwNwB+wVvFGl3Gdf2Kj5bHZ6wvGQeO687gy3ADGN
 BgsWoBo7FjIsTr6
X-Received: by 2002:a05:6102:f0e:b0:71e:1c56:e78e with SMTP id
 ada2fe7eead31-758429afe41mr161397137.17.1785423853012; 
 Thu, 30 Jul 2026 08:04:13 -0700 (PDT)
Received: from Ivanovs-MacBook-Pro.local ([93.174.85.138])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1fa8bbc755sm78846966b.54.2026.07.30.08.04.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 08:04:12 -0700 (PDT)
Date: Thu, 30 Jul 2026 16:03:42 +0100
Subject: [PATCH 2/4] test: spl: Factor out external-data FIT property
 checks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-b4-fit-ext-data-hardening-v1-2-4a6b91e37b51@binarly.io>
References: <20260730-b4-fit-ext-data-hardening-v1-0-4a6b91e37b51@binarly.io>
In-Reply-To: <20260730-b4-fit-ext-data-hardening-v1-0-4a6b91e37b51@binarly.io>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>, 
 Simon Glass <sjg@chromium.org>, Anton Ivanov <anton@binarly.io>, 
 Daniel Golle <daniel@makrotopia.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Francesco Valla <francesco@valla.it>, Anshul Dalal <anshuld@ti.com>, 
 Randolph Sapp <rs@ti.com>, Binarly Research <vr@binarly.io>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1785423847; l=3854;
 i=anton@binarly.io; s=default; h=from:subject:message-id;
 bh=ai4IlBVJjRbzPXxf7hxCVaDGkoPu91bClA7nyYTWTug=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgLlci93RPwSlisH3PzSX3+CiC/xruz
 nbNSGHIKfmW2YQAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QB0JwM5CLeFMkx0EgoZg9GrJ+5nTjN61oaaPHgw649Dsftwwcex+f7wmIKiYcMffR0BIXCtUw0C
 O3+M8/3xhggE=
X-Developer-Key: i=anton@binarly.io; a=openssh;
 fpr=SHA256:OWnvXkgcqeWMXacIaCJR2oikuTmVTaSodreIHEJTWEc
X-Mailman-Approved-At: Thu, 30 Jul 2026 15:31:18 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=binarly.io; s=google; t=1785423855; x=1786028655;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XkLk629i+NRG/aGBmGqn7vV/aERQdO9unp1kUVVn5cw=;
 b=GZ263GbpD3YAk8btKm2vSWBVtY+mQbGnzc/5XF0dx0neb0LDYnwkfcGfLpAnzWuOb1
 ibJSjD7DgdhJVHSTY+whXGFjqrxs9RFuiqZPWQ8QJRoDpOeH38lCBS9tyEJC6tfhi4nm
 h1EMFqq3vdDGp6ajUAs3hMYoOCQ17ZpM2LylNuuo7e+KxKe16s9QmTl2ydL2HWQRUNlR
 q/8TUU/D6zczpN1C/cpAftqHjcUF/Ud97sI3uOAReFJs2IzMZ3EFoNvUEUc2SlajRkra
 Bq90KuESl7ZJ6hNS39H7/izPxgdeOOUxVNKtrDD39K/GpaANB/NzZKcoggB2aS2rubMY
 DyhA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=binarly.io
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=binarly.io header.i=@binarly.io
 header.a=rsa-sha256 header.s=google header.b=GZ263Gbp
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Anton Ivanov via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Anton Ivanov <anton@binarly.io>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Turn spl_test_fit_external_oversize() into a parameterized helper
which builds a FIT with external data, overwrites one property of the
image node with a hostile value and checks that spl_load_simple_fit()
fails with the expected error.

This is in preparation for adding tests for the remaining
external-data properties.

No functional change.

Signed-off-by: Anton Ivanov <anton@binarly.io>
---
 test/image/spl_load.c | 48 +++++++++++++++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 19 deletions(-)

diff --git a/test/image/spl_load.c b/test/image/spl_load.c
index c43c977f784..49bfce15c08 100644
--- a/test/image/spl_load.c
+++ b/test/image/spl_load.c
@@ -368,52 +368,62 @@ SPL_IMG_TEST(spl_test_image, FIT_INTERNAL, 0);
 SPL_IMG_TEST(spl_test_image, FIT_EXTERNAL, 0);
 
 /*
- * A FIT image's data-size property is not covered by the configuration
- * signature, so it is untrusted input. load_simple_fit() must reject a
- * data-size larger than the destination rather than overrun it, because the
- * device read happens before the image hash is verified.
+ * Build a FIT with external data, overwrite one property of the image node
+ * with a hostile value and check that loading fails with the expected error.
+ * The external-data properties are excluded from the configuration signature,
+ * so load_simple_fit() must reject values that would wrap its offset/size
+ * arithmetic rather than read from a bogus location.
  */
-static int spl_test_fit_external_oversize(struct unit_test_state *uts)
+static int check_fit_ext_prop(struct unit_test_state *uts, const char *prop,
+			      u32 value, uint bl_len, spl_load_reader h_read,
+			      ulong fit_offset, int expected)
 {
 	size_t img_size, img_data, data_size = SPL_TEST_DATA_SIZE;
 	struct spl_image_info info_write = {
-		.name = "oversize",
+		.name = "ext-prop",
 		.size = data_size,
 	}, info_read = { };
 	struct spl_load_info load;
 	void *img;
 	int node;
 
-	if (!image_supported(FIT_EXTERNAL))
-		return -EAGAIN;
-
 	img_size = create_image(NULL, FIT_EXTERNAL, &info_write, &img_data);
 	ut_assert(img_size);
 	img = calloc(img_size, 1);
 	ut_assertnonnull(img);
 
-	generate_data(img + img_data, data_size, "oversize");
+	generate_data(img + img_data, data_size, "ext-prop");
 	ut_asserteq(img_size, create_image(img, FIT_EXTERNAL, &info_write,
 					   NULL));
 
-	/*
-	 * Inflate data-size far beyond the image buffer and any plausible
-	 * load region. Without a bounds check, load_simple_fit() reads this
-	 * many bytes off the "device" before the hash is checked.
-	 */
 	node = fdt_path_offset(img, FIT_IMAGES_PATH);
 	ut_assert(node >= 0);
 	node = fdt_first_subnode(img, node);
 	ut_assert(node >= 0);
-	ut_assertok(fdt_setprop_inplace_u32(img, node, FIT_DATA_SIZE_PROP,
-					    0x40000000));
+	ut_assertok(fdt_setprop_inplace_u32(img, node, prop, value));
 
-	spl_load_init(&load, spl_test_read, img, 1);
-	ut_asserteq(-EFBIG, spl_load_simple_fit(&info_read, &load, 0, img));
+	spl_load_init(&load, h_read, img, bl_len);
+	ut_asserteq(expected,
+		    spl_load_simple_fit(&info_read, &load, fit_offset, img));
 
 	free(img);
 	return 0;
 }
+
+/*
+ * A FIT image's data-size property is not covered by the configuration
+ * signature, so it is untrusted input. load_simple_fit() must reject a
+ * data-size larger than the destination rather than overrun it, because the
+ * device read happens before the image hash is verified.
+ */
+static int spl_test_fit_external_oversize(struct unit_test_state *uts)
+{
+	if (!image_supported(FIT_EXTERNAL))
+		return -EAGAIN;
+
+	return check_fit_ext_prop(uts, FIT_DATA_SIZE_PROP, 0x40000000, 1,
+				  spl_test_read, 0, -EFBIG);
+}
 SPL_TEST(spl_test_fit_external_oversize, 0);
 
 /*

-- 
2.51.0

