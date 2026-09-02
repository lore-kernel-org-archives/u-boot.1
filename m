Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA6C9C624D7
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 21:58:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3479340637;
	Wed,  2 Sep 2026 21:58:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XN1fJNrGaNJM; Wed,  2 Sep 2026 21:58:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 5A99640545
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788386337;
	b=BklTSvouxH+vITlrvHixeHhufdcydvwGB/iW7GoMh2WveuqxwXQpArohdOjS5n0f2+3V
	 Z+/HXE25kWgN0ZFRj8joRAMgt4glf9UZllDpdLeKqi9krU08e6Lu6MV0Vvf8QIxesjThV
	 zHkH18UIonTbUenFpJTuBFZfJ08p9DXnwxDbfnGQXGljn4DFX/dc6NP3lnZNPy8GuPRBm
	 8Vv4D5vmkG567SLYc27+v8B/GVrUEEQfJOCwsahE9kJlujfVGO8EQQ/OA3NklTykMqi7T
	 oxm7z1E9byRZK1OEjAHN5yp8sOdUjZoYzRsg5XaUbPTAlq01p9vSZ2NP0HABZqnkCFQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788386337;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=vX7iXeNpsBT7f+hseVvV7+4pdsVcMPio/hKsZHziSYw=;
	b=Nd0wMx5KhDf6P2q07SzFLiTPG5SNtWSGROamaYRYNhXwlF7avcXrPZKhwtdv4YtfnLYy
	 9Nqkar/hBnTDNinnrQldvx3pCKrudSicaC1ncI8A16Nn8LwA3kzHkuYa6tBEmGVHQHI19
	 RcDPTKVdhqA2Yo+weQPsihsu4j61BsNFIkI/iapq8+U31P8+NTLWRP1jM7DvYnei+R4Mk
	 RQlfaot4OpITl6Voeq+a+VhN5Ri6MWB7IN2eM2aKYKdCJ8C8FKhS3Ui9xixMDxfI9e2PI
	 Kl7k3ezIq3qfofGQFV1cywyu18/5RS92C+muMWeoZEsKDj+LdC/qf99iYN9OaJNg3CA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788386337;
	bh=vX7iXeNpsBT7f+hseVvV7+4pdsVcMPio/hKsZHziSYw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VwCJDMsUn85Vi+kxWK2ELo3EaCtD856IiFWD7RI66hhnbo3MwypAadC2gD0+7UxkR
	 85O2FBUXtF9z8bI6XPWxP1mdADtvhoxUNGMiGLVJGusDdDU7aH6dwcpWpC0aKuBXQb
	 LIrFjS1+7Y/Dulx4IxdfuvRsJwdLe/+mGzCAZ1g4FhJcDPc8iefOdNt+YzGGW5cqQu
	 VL9EE8hbNPVk80E2ElR03HDoMphyB3sfkwjEZ4rlAQblqcf/Gd+kVrOTa3P0ZnqiPV
	 ImPU91AcnwnET5F9H4DvwfMrIYemOwh1WGkxQJIT33M0ndh/70NEm+Er8zC7caQGK6
	 XTDGxlJ9yzkEw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5A99640545;
	Wed,  2 Sep 2026 21:58:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 788BF1D9
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 21:23:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5E55E607F5
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 21:23:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WmjXLRUIIqRr for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 21:23:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 73EB660679
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::734"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788384232;
 b=Fp/meOBHyGgktLL3sO3iav7cMpJvzWfSsQqPMLZGT0Mt4iBOHi8IJFgPkCMz4br44vQg
 Sh0xPWE49u3LY4H/oohbksxbUSPYJPgJcrdRMFV+NBQC+3VGpHjFrO538WtoDMcZJ2VpW
 eBhA7FGTb0zLEBzewLcOH8AnBLQJYVf4+l0YG3MWy44obbzZB1g3q5uSPJL0aedvZTLTI
 WbZgyM1pWdv1WEyLAPfGqJDZveZoJIGMqlJCTC0ixfEMNIihypXCB7w0Xxi+xskFMwr+h
 +3Ap7S2UuQe+7muxALyHW5D250Bud0wtBNzXiApMqrdscozlnCw53BFY4Dn/4P9wg4w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788384232;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=vX7iXeNpsBT7f+hseVvV7+4pdsVcMPio/hKsZHziSYw=;
 b=h0ObZhNqtJ58rTSqV/2Jik4013owgrpF9dZ1oWiqxMT3dR/8zTtSMrpH51Vg2g9UvGkW
 Kau8Yjt7+1gIOGnxPZ5LQFINyGKhjUkppdZjraVSAKn8J/Wg3N2ywKoLfMeCyb4zDrWHf
 JcD4Z3yaB2E8ThIELkq8CEuZZ7TnYK6u6+YDh+BTvXIdC0zMk9zBnfZuuKETF4VBIZVS4
 9Pv1eucKZrKRjESI6XvGyDLojGTMF0xLzHgOm3nKcApbQzDNTa9lRAO7OtqbXsnYz/OEC
 aXIegksu7S5+nS71XlN7xC4AqqTzQd1AcANFmhQlv3iSlCcjy9DHkkMyf4+iMkDVNIQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=binarly.io; 
 dkim=pass header.d=binarly.io header.i=@binarly.io header.a=rsa-sha256
 header.s=google header.b=eiG64bF4; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::734"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::734; helo=mail-qk1-x734.google.com;
 envelope-from=anton@binarly.io; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=binarly.io
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=binarly.io header.i=@binarly.io
 header.a=rsa-sha256 header.s=google header.b=eiG64bF4
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 73EB660679
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 21:23:51 +0000 (UTC)
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-936c02e58dfso153565585a.3
 for <u-boot@lists.u-boot-project.org>; Wed, 02 Sep 2026 14:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=binarly.io; s=google; t=1788384230; x=1788989030;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vX7iXeNpsBT7f+hseVvV7+4pdsVcMPio/hKsZHziSYw=;
 b=eiG64bF4S5h/z2wDr3nPukYRfnYpZhg4Ml/lfY49Cr5LRewjI85tfhvndhmVDLPhse
 aaZ3BkZrOjhDUonaZYgsrtptX8jxb+s7cwW7s+VO3ZtcBvTOKeX5jCaAxOBjpY3yIgU6
 eczV9fGt90qMC4OpZsdZWsPOv2sKKGWXKg4V08+W83wbAy6aqAdJmS1HOiHNwYOvXkj0
 IrO7f1ntNf+Dgc/wnTz9vKEJtSQq8LOKCfsvtmSMHlVJSxLOsRW5A4Q9uWAPmLEdVLah
 nn36URi+WL3l/KWr+PQ4i1EYwxCE/Qd+seq8yVsqJaN3uVWukxMYY0ZFrPnv/ry6qW4K
 CVng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788384230; x=1788989030;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vX7iXeNpsBT7f+hseVvV7+4pdsVcMPio/hKsZHziSYw=;
 b=H7fMK6vNvpwUcHfj4iLVYvybWIPSxOxD3Myb3zaPM4NtlL9+5csz0zOL/AukghAH5H
 9t1Op/j4RY/MvPFV9Awl88D7jzr5oImz8UNCPKl6J/Y3yDvBsF4ygHNboaXeYeWsn0eU
 16weYqvxyGZrP+jLRr1P8IUsEJ0fBn7WlmC6uzIHHTACgerulNfUDpjMglZLRjZiRMtp
 MutgDPyhHzHk87ex7XiNqRRFPbe/fg5l7IV4pXomDVQOnTZ62MFLyllI007aAwShWJ7L
 kcwBX7TJ/SnZj8H2L0eE0oFWy9C813w1klgwEGuYidbbM1ngdqa99g3mp28hXHjmmOKf
 gADA==
X-Gm-Message-State: AFuF++kQn0fgGfp64lZVdRGLa3IV4KUWNv85GbAlQllI4OF5v0fA5jDE
 cAC6jrDMXm8dpGRy1zl8whWpcMob4hJ9+G00GomDry0UPvbr8nUVE9pi73GNHFlh9SY=
X-Gm-Gg: AYBFou0vegHtvdyN+O034mM9F2hv3l3nOU/XukBEHkxOFjtVJje85RnecdQvwBexSkF
 uceSRctF1lQUL9p1lXKxnjUdGrDddidcMX2Bim8uTeeVM+QvtbCrkE74BGgXk5GYVK+j6aXiV85
 pG2PiO6K14fZea6N/Se4crl+w8MVyLtvkFyo0zVViqA1IDs3tZuAScNYofLlse+Ihe3HmHI1V2o
 TjHepLL6aJlzXD+vUiA0I3roXme/ibpXV0XhZSp4+7hdPAM279J7pg0sJ8ZPFKh20gaC2K12jYk
 /0HTq1aHygNM2KE0SK5I2MzN+v4VZYTmBYL0DO64EMPT8pJpmSZ3k9pw9om6YRyBTFSLibJN8QK
 xxy/Z3na9M/kWvdOSLvQTLPju63JnQVqTVgh6uFLtow7KZaKdc0Anb0M1U1XWNT4v8kSZk9c2kx
 zm15d/xMxUp6jjm5+1lAd0HWtVOhn0XuhaRUX0dwg+axAjp3hIv/H5y8PVbE3hVj9h0Z6FBwgsZ
 PYjKHDHSohdN5l4BMRW+g34CVc=
X-Received: by 2002:a05:620a:19a4:b0:936:ca57:25da with SMTP id
 af79cd13be357-93960fb0a7emr854657685a.37.1788384230341; 
 Wed, 02 Sep 2026 14:23:50 -0700 (PDT)
Received: from Ivanovs-MacBook-Pro.local ([93.174.85.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee7fec25sm19948755e9.13.2026.09.02.14.23.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 14:23:49 -0700 (PDT)
From: Anton Ivanov <anton@binarly.io>
Date: Wed, 02 Sep 2026 22:23:24 +0100
Subject: [PATCH v4 2/4] test: spl: Factor out external-data FIT property checks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-b4-fit-ext-data-hardening-v4-2-a884a5de96ea@binarly.io>
References: <20260902-b4-fit-ext-data-hardening-v4-0-a884a5de96ea@binarly.io>
In-Reply-To: <20260902-b4-fit-ext-data-hardening-v4-0-a884a5de96ea@binarly.io>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>, 
 Simon Glass <sjg@chromium.org>, Anton Ivanov <anton@binarly.io>, 
 Daniel Golle <daniel@makrotopia.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Francesco Valla <francesco@valla.it>, Anshul Dalal <anshuld@ti.com>, 
 Randolph Sapp <rs@ti.com>, Binarly Research <vr@binarly.io>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1788384226; l=3899;
 i=anton@binarly.io; s=default; h=from:subject:message-id;
 bh=JAMSc4FE1M3IWfbyoHw8eoQeOeJOpLninBT1JWwyBdU=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgLlci93RPwSlisH3PzSX3+CiC/xruz
 nbNSGHIKfmW2YQAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QARsUPwQpfQmiwvct5SVEyZTg/Pb6nbwprqxDbzPgscFTKjw8x3pzVFw2GVsck2s/lgCRB+4M5f
 UPZZrDat1QwE=
X-Developer-Key: i=anton@binarly.io; a=openssh;
 fpr=SHA256:OWnvXkgcqeWMXacIaCJR2oikuTmVTaSodreIHEJTWEc
X-Mailman-Approved-At: Wed, 02 Sep 2026 21:58:52 +0000
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
Errors-To: u-boot-bounces@lists.u-boot-project.org

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

