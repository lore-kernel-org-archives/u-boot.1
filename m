Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35F99C5AD55
	for <u-boot@archiver.kernel.org>; Mon, 10 Aug 2026 22:11:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F34DE6079D;
	Mon, 10 Aug 2026 22:11:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uAf0LLsWvWrg; Mon, 10 Aug 2026 22:11:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2CEA660776
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786399907;
	bh=vX7iXeNpsBT7f+hseVvV7+4pdsVcMPio/hKsZHziSYw=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=SFGSljKO8qpVaLEVvXkCuPuhbERXunIv2gjN9ym0PJrgToxPP85RJv7wmkcgfuEXQ
	 JPIl2OmAaRvxRMAHzdRSQOn2zp8XyImTKzTLy0gC8WxtldtHT0zL2c3WKphl1ZKilA
	 4lS5xEKY/hNqB+PNkImReOv36Scqo5u6Fv5/1sIbXEj0CR+FJuzLZb7hGLD8gSXg1+
	 wAtMIdDGSojdzEB/kBc93Picys6Nj5/RTsLssUv1aN93wkAhC54ABKebttoAAVSObG
	 +p0jpwtxVmusc3pRQvFFsQiIJGwrakc+xHUGka+FuHmTr/071zkvbopkSWhp5op36W
	 0az+Fxii7YiCw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2CEA660776;
	Mon, 10 Aug 2026 22:11:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id E1F6A4E0
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 22:10:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D46FD80F05
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 22:10:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id orqt9wrmP1UQ for <u-boot@lists.u-boot-project.org>;
 Mon, 10 Aug 2026 22:10:12 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::832; helo=mail-qt1-x832.google.com;
 envelope-from=anton@binarly.io; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org EF28C80EFE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EF28C80EFE
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EF28C80EFE
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 22:10:11 +0000 (UTC)
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-51c0a81d286so2439741cf.1
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 15:10:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786399811; x=1787004611;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vX7iXeNpsBT7f+hseVvV7+4pdsVcMPio/hKsZHziSYw=;
 b=WWfCUyNGYUQj6FB457/uq+Y+8+15DxW120ecEb6JzLAF+D1rzyVPQBRoroZk1CV4MB
 ss02k3kKSddQzFfoxTIqLtgWNPpauRE4wYU10HeBpGeNVZx+KTrkvDQJGNbHr75YDJkN
 G7Cqb+rL7VSwxfwtYUQNGcv69nPAAh9FY+dJh4t2E9yhlR/4Sh1ukE3WGGmcIDY7Tjif
 qWMhIpuli7pFL1RPlQkXbidYd/u1m9bUP6AaG9JzBgMHdqp229Nq0tZ+ShVdRWz/LnFe
 zXsF5B9M598UWTO+3fWkzVCEvBYnlX1xfhK4M8M//r0Gbjpnpr3u9AhYXX439i1XStV6
 M10w==
X-Gm-Message-State: AOJu0Yy4EmINhgtTE20auV4mFSLxIOHApBhJfLPd12BClFZTCK9ZMJpO
 Y/Cax/x2pHedSmOZ2EZsqJonixpgML9DGzHLf8nIxILq2UAEq3Ki7xZleeW4rNSfxRTl/ZBZDXr
 RdBHSdY4KGzCJ0FY=
X-Gm-Gg: AR+sD13oo1njL41u8LRnU136YaSht3wXE+VUoSEuUFLV2PF1YMkP7svlzpFqWA2fc0v
 1OT6D9stzbfOe/u2hG3CjpxOXK+UgWS0bYe4OFWeZnfZ8tYLu1j4b9nQgHqtpl/mOf9ssHKkNpN
 dVXadU1WA4DdakpXOet/VPHL1jXTlVLFw513BgoVvvGOAUjOmDPf60sUU3jMeo3LCjO0Ot61rYT
 rExmCLSScBsXVR+5wT/57skoBu3R/nfTYyLvQ7SHkrWtyhXRaCqR4OZZ3guFFdkE+ISIJjo5gya
 F/vz/S+bxVlzojUpMY+PyAWcz10ZxWnI3uXd/IFJ1ha0eVpL08iUgeaYWgrlPOgRECo/rATRlnt
 jAtxa/S7jFcXRWWB3CeemdXIqxdKLR3OSCgZEBMCT4VHlzN1Ngf6vqvDUYfyBSQER3Lmb5C91Aw
 w40g6O62Q3LpGcX1joE8/YApp5T9tNOrGZ6rAb6anCkz99mbXKbW5cFxzOi7KEhBFIxMk8EC69N
 /eFmgMiycafD9f8
X-Received: by 2002:ac8:7f13:0:b0:517:146d:2cb5 with SMTP id
 d75a77b69052e-52d5155d68emr17827361cf.20.1786399810595; 
 Mon, 10 Aug 2026 15:10:10 -0700 (PDT)
Received: from Ivanovs-MacBook-Pro.local ([93.174.85.138])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2080c90e87sm441651666b.34.2026.08.10.15.10.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 15:10:09 -0700 (PDT)
Date: Mon, 10 Aug 2026 23:09:55 +0100
Subject: [PATCH v3 2/4] test: spl: Factor out external-data FIT property checks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-b4-fit-ext-data-hardening-v3-2-17184cdb87fd@binarly.io>
References: <20260810-b4-fit-ext-data-hardening-v3-0-17184cdb87fd@binarly.io>
In-Reply-To: <20260810-b4-fit-ext-data-hardening-v3-0-17184cdb87fd@binarly.io>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>, 
 Simon Glass <sjg@chromium.org>, Anton Ivanov <anton@binarly.io>, 
 Daniel Golle <daniel@makrotopia.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Francesco Valla <francesco@valla.it>, Anshul Dalal <anshuld@ti.com>, 
 Randolph Sapp <rs@ti.com>, Binarly Research <vr@binarly.io>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1786399803; l=3899;
 i=anton@binarly.io; s=default; h=from:subject:message-id;
 bh=JAMSc4FE1M3IWfbyoHw8eoQeOeJOpLninBT1JWwyBdU=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgLlci93RPwSlisH3PzSX3+CiC/xruz
 nbNSGHIKfmW2YQAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QHeHSi2wQc1hiaobeX0+R23I7SUDxIvMwLUKZAfheqNPeN01nT5mLIAmyJErlMRmBI94QnBrSb8
 cSaspZBlFrgs=
X-Developer-Key: i=anton@binarly.io; a=openssh;
 fpr=SHA256:OWnvXkgcqeWMXacIaCJR2oikuTmVTaSodreIHEJTWEc
X-Mailman-Approved-At: Mon, 10 Aug 2026 22:11:43 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=binarly.io; s=google; t=1786399811; x=1787004611;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vX7iXeNpsBT7f+hseVvV7+4pdsVcMPio/hKsZHziSYw=;
 b=Y5yq9FcVgjXcioGlj/F/22NNIDRUNIlmR18jnJEf0qx21rzcVsgbMJmP3Pvnu3DVx9
 NEH8InSmn0Nkn2ko16+cFyne6p3j5b2SMuArEHrJ6e+KQWKXWePg8aAb9B77nnQYqw5+
 +iIcvr1/4yvOU9vNYpWRd6IR2Xy7H9pb46hXCdgXd9RFvWKtk1wq7VIWHGLTZ5uExbf6
 /o+RRRx1BBlMMNKrxK2t2VK/dC0briUfoe0VPL5l29DFdRlhsJtbezcQd52vvjHAl07B
 nNvp2kYI35KS5/mwt0puqkxgLiqsiVfgNHjys6aBUh+nbFkV1tJfQpWgcSYGC600kY+E
 RJyw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=binarly.io
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=binarly.io header.i=@binarly.io header.a=rsa-sha256
 header.s=google header.b=Y5yq9FcV
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
Reviewed-by: Simon Glass <sjg@chromium.org>
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

