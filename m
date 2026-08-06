Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77331C5AC7A
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 01:50:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 45C8E60889;
	Fri,  7 Aug 2026 01:50:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aDnAgJBbgFTv; Fri,  7 Aug 2026 01:50:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B133C608A5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786067438;
	bh=RIXCc9XNH72P3QRV+Ej7hO1JBjxQRBgoCTOkCW8lDKo=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=dFdDiH7rkjU8OsjuA5cDvH/dNoAAEfm+qAt37G6GDfZQKoOo9H3C0HDcbJq879Fl4
	 A2pYP6r2TQM0yPTQeozlX6yV9ysJEmEgPYDkgvgHbBixoYsWn3Atea0ddJPxToREQf
	 dpGr9CCVLNFy4YdlqWiHADj61BlFK6LgejjTGhysjaPg0VlK+vqX/oll1aplIZxPHz
	 ii7rc5o7vpUj7sqtuqqZoX7UFkDV7HUoVVVwIYu7hWys8vCpUqsjcno8wQCvACNxOp
	 V57u2APcabVJ+udW2C0+Aoq7DB9SyPMNv6keS5svFjF1MtHYYbzR3Lny7B9wREU5Tw
	 ub8rz1Gyen+rw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B133C608A5;
	Fri,  7 Aug 2026 01:50:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 19F63397
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 21:29:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0BEAF80F49
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 21:29:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BgCfvfWFotjo for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 21:29:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::82f; helo=mail-qt1-x82f.google.com;
 envelope-from=anton@binarly.io; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org DCF0D80F40
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DCF0D80F40
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DCF0D80F40
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 21:29:45 +0000 (UTC)
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-51c2a76536bso24672271cf.1
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 14:29:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786051784; x=1786656584;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RIXCc9XNH72P3QRV+Ej7hO1JBjxQRBgoCTOkCW8lDKo=;
 b=Zn4zE7TRNZcPJx7kdEfHZuXavC7jyz301hOdN2VP/9XuTm3AvaTR/NWFDjMbSC9Kly
 pPHLQ+sjIr5VvkUKA9iAOpu4L8Kmtu/D15yo/4GWyLcF1B4tCE6LCNyzvjdU3D9c2bkP
 ZSwoEo+tWcl71HibE0GqtqGkje98s4I8RsorDEqRlrYOeO5++5OxsSGYp/S+u4ueNr8P
 uNGAzk2gb8jZlRzvYXnXPxLJZ5r9EQ8JfP7jHe7Zk//Z0qgP1/H7+BQChDD0eS2InPnd
 GkdUEG95mZSyRucShEF6cAEcBM1csBYxNxgqez/6Ge3+u6qYyiedOqxoITotZAsUwxZL
 qpXA==
X-Gm-Message-State: AOJu0Yx2jAmQ8mYlU7DbAcLuUG6lwKr9GlcPInEuM/29FxJZuo80THP/
 1dJMU6CAy7IrEp2MK9Wohw4pfPGcDCKJJ+s2pOfLJcKdM4bkS3ECHNgoI7z+YkjFp8w=
X-Gm-Gg: AR+sD13NdyDXMNhU1khs3F706XYFCTjCEECIzTmsZIYCAYo0iDWIhFoV7v/vDwjj31m
 R5Twu6rGG1AOoK/tWgZJ9685cJP+pt2Tt1lc/CmctQkqiGqldoyzrXbVbx3SOIcxyyatRR5OF0i
 4Kon8/fBaLRGUTm4sFbMijxCwRynYLJAOyClrt3z5myC5K1Rtg+ewQtGuSILYeVqzAm1aSRCYCD
 jWDeKsJ5nIvHKCE2QZ+zCQl9SHcPbPEuVjhCBYCHuVQoKv4J9V7LoLRr6dlBE+wr9133Rc3z8FR
 5tLGFchM5S+Z7lExDFseid8bSj0n9jhrQ8MOaiwj3HzXSKqM/e+n3TML0RcTeqy35yD6EcEnkj5
 54NdLLVs000lMaiQjmP+frCkg3pn5VZDcvCiKXqXvduR9cEe3Tu8LdGLtjAYwVMJGD7eOsO3mtI
 nOtUHPuB3+edH59qM70L0jCUYwmL/Y0wnomTzNvZE2LOV0+5HOlpbJaMqTl1FHXuD5zjxOC78ZC
 +9sfOqqRK2j9kFH
X-Received: by 2002:a05:622a:1112:b0:51c:24a:ea6b with SMTP id
 d75a77b69052e-52ce5fa4664mr172520701cf.4.1786051784504; 
 Thu, 06 Aug 2026 14:29:44 -0700 (PDT)
Received: from Ivanovs-MacBook-Pro.local ([93.174.85.138])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c207b4fffcdsm2071466b.46.2026.08.06.14.29.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 14:29:42 -0700 (PDT)
Date: Thu, 06 Aug 2026 22:29:20 +0100
Subject: [PATCH v2 2/4] test: spl: Factor out external-data FIT property checks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-b4-fit-ext-data-hardening-v2-2-b181cac15c29@binarly.io>
References: <20260806-b4-fit-ext-data-hardening-v2-0-b181cac15c29@binarly.io>
In-Reply-To: <20260806-b4-fit-ext-data-hardening-v2-0-b181cac15c29@binarly.io>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>, 
 Simon Glass <sjg@chromium.org>, Anton Ivanov <anton@binarly.io>, 
 Daniel Golle <daniel@makrotopia.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Francesco Valla <francesco@valla.it>, Anshul Dalal <anshuld@ti.com>, 
 Randolph Sapp <rs@ti.com>, Binarly Research <vr@binarly.io>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1786051774; l=3854;
 i=anton@binarly.io; s=default; h=from:subject:message-id;
 bh=uAfnXwjpnhKCKH6doiL2rCPWvg1KXkeFhR7TkfOvGrk=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgLlci93RPwSlisH3PzSX3+CiC/xruz
 nbNSGHIKfmW2YQAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QGig/OZH47E3fpGKX1O0hui9UJPwMBSkC22TJp5wB04Uw6YIvyxBKRjurhpXPsjrgnm2R3mbPJt
 xoxWp6olx3go=
X-Developer-Key: i=anton@binarly.io; a=openssh;
 fpr=SHA256:OWnvXkgcqeWMXacIaCJR2oikuTmVTaSodreIHEJTWEc
X-Mailman-Approved-At: Fri, 07 Aug 2026 01:50:23 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=binarly.io; s=google; t=1786051784; x=1786656584;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RIXCc9XNH72P3QRV+Ej7hO1JBjxQRBgoCTOkCW8lDKo=;
 b=NJhebTk/0FK/qGXfTUWPLBiOSp1bk5tdE73266kz+Xd5z44jkc16xPNiLJ75LxaUKA
 41lzf+jejd0yagRItHqcIbHJpuYW7TBTnYUgt/p3fN29nenuDSF7NYy+2qDw8WKOmv9u
 RzSLyOgbulxRrBQlsPOV/iHqOVkMC4to4sWUxrl7N99dERoH+iRHvgL7SRM1JHTB42Jq
 ADIABfybZqPBjjdtDVZEdhjmGvKHEhtUlHzCirRlE7fdA7Bk8OJJNzkV/koZQ3HZ1gyR
 sOpGfvlMXs1+tulwCL/NWzK0oP/egarzSd59NCRzLurbXMImlXg4tifDywDGD2bjUmvu
 6yLQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=binarly.io
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=binarly.io header.i=@binarly.io header.a=rsa-sha256
 header.s=google header.b=NJhebTk/
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
2.55.0

