Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60010606A31B
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 14:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=rNu0hnGU
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 401F8811B3;
	Wed, 21 Oct 2026 14:10:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HOVP20d6f3t6; Wed, 21 Oct 2026 14:10:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4062C8118C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792591820;
	b=EisFbImPEdo0TuhVv4duhntBYLrKEi1v/Qt9OjzVZnacqwtuk/LS1ijQtn9cqvoUdSfs
	 y8M142vWJQQMrhJLJiI1uMM5fGQzi8YqFBh9EH5bjWITXZ8DvP1Dv4EK41VnCESeRGzDD
	 IK6lfLX0nKBB1Tn5VD0PxVmbYvES10sGQFSRyQxxpReaAuFDAxiHZEn0PVMN6RuXQtssu
	 t2BFbH8wvXPPbAQtJcTjpRFjKbiTMPIYz/1tIwWPaQu/SYpBxE/XD4j4dPKi45Fp3DIJt
	 HroqyKAcKWKkuskSemKiUcgQ3L8QyohjYj/wN6/qwuEGAZ2t3KXX2qq9E8cZsBgmDgg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792591820;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:Date:
	 From:To:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=1PCLUEZoDYpNjVR4Sy+nOUN/NoSziaKtmnmu/0mu/LA=;
	b=WqXZe4cCR47ap31N5crAtT68YOsSuuLllE5wv4qWTzneznGfDFXFB743xEUj6xODNSZm
	 wmBEds7kopjkv+7nIWV1y/z6WY2Ilqs3+YFBSIVtoHPMEbSomB98HyVQeO52RuU3wk/oG
	 p1nvXEJH97MCJJTMdmXDYeu0O2OGXImpnP/659k6P9uURB+g/FBKm44megKEyMKQ0Ftep
	 7knXnDdZ+ip74H8t/EOB0fGR3jLnqBnK6oTGv34JXIPXL0jB/0eYINI/WPxiM1r+llqJg
	 TqrWC2CpUUPSQzlptsGBdf54TPJoX2cw/6QPFD1q+RXj4V9SoLs3ekUpb45r+Bay8KA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=none header.from=makrotopia.org;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792591820;
	bh=1PCLUEZoDYpNjVR4Sy+nOUN/NoSziaKtmnmu/0mu/LA=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rNu0hnGU0GsS/EkQs2UKfdOrS7dOg9vhA3W/jeZeHtibNyuDAxQsYZxbEZwwjmt1Q
	 U+i44l5pUVrEzdyTq031R8nOb8xXs84PIj8D2+EFuiQurQTqpHUz1IiNkFJ/jrzoWE
	 8ZrF3x5CZwbDoEnAO35IEWlONNK5Q0TISMgry/iLNFY3m7cS5dvrrkAVum4J5me6ln
	 7MxtiF/hQfOmWUf7Mc+MrSMpNx1ub9I6aw4MAcfvNNrzxjzGxenFHpTDeVXdPbGFdQ
	 M569l1MnZN51mtuTvSgaVUfRoxLOurfLb0rFmVwBV5xHSVXNtmswR7qqeYZE3pHJVU
	 Xc/oGwuExNe+w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4062C8118C;
	Wed, 21 Oct 2026 14:10:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 697D9E50
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 14:10:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6753381192
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 14:10:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hV7UUm2GJEtD for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 14:10:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9988D81184
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792591818;
 b=Wy9wHDkzWJ3R8pg+hQZJglesklBbn5z1QDMoLbmiMFNIe26QfNAZoypyv/RGiJH/8A1j
 WyJZI2sBEk4MX1K/2T6vwkAXsdQJDcS8p9yn32fIdOSVzU+5QJhYLOO0c6XpnctjJoNFc
 G+7UQIHb7H7uHQYWlZHjdWd5atJhuccMCmhqngiRs4Zfvi5QN+H3r9kL6mD5W10et60fo
 bYw642fDai4vyYoFFlvJgagnF2v2aDWqo+Od4wtWeUPdaYLkYD9oREBSVHMuU1P7+25Xt
 1Vx04ZMh2pFpTKF7NeUHlSqE2gi5Q54uWEt0EOJ81b/0EfWn0ELVEn/gef+4AjqOgaw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792591818;
 h=Received-SPF:Received:Date:From:To:Subject:Message-ID:References:
 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
 bh=1PCLUEZoDYpNjVR4Sy+nOUN/NoSziaKtmnmu/0mu/LA=;
 b=Up0aMU3q249+ndvNuDZQZ9Mji0li/6VU40ZIq3foWEcvhBGHwqRRFrNX7MORP+GkKs8N
 Owvjte4H1itajmVznUaeSzklEc4JdzL8hDX4x3LxzCJZxtY2mF9aYoNsWx5aEDonXc/+i
 ssYZD5edTvgtYivTHjUiAb2uUwgF0tgE/n6Q+RhLVmtCW5v0wktWWEpDWYScY66aaL91e
 s6Licq1EwCgWpoXOFLCpv1hyBhYMl3e5OqvMQ7Ndxt/PoPpfuv0f5/0s1Hngx+9fZy5Lh
 VWRDg/Z0SmSBoFRIulqy6aV6TfJ+o6v9ei/OVb4PaCN/+ynRNXCn/ZmxQ0EMY92Ujpg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=makrotopia.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a07:2ec0:3002::65;
 helo=pidgin.makrotopia.org; envelope-from=daniel@makrotopia.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9988D81184
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 14:10:18 +0000 (UTC)
Received: from local by pidgin.makrotopia.org with esmtpsa
 (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768) (Exim 4.100.1)
 (envelope-from <daniel@makrotopia.org>) id 1xJWy5-0000000029n-2hur;
 Wed, 21 Oct 2026 14:10:15 +0000
Date: Wed, 21 Oct 2026 15:10:12 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Tom Rini <trini@konsulko.com>, Daniel Golle <daniel@makrotopia.org>,
 Simon Glass <sjg@chromium.org>, Aristo Chen <aristo.chen@canonical.com>,
 Anton Ivanov <anton@binarly.io>, Vincent Jardin <vjardin@free.fr>,
 Randolph Sapp <rs@ti.com>, Anders Roxell <anders.roxell@linaro.org>,
 u-boot@lists.u-boot-project.org, openwrt-devel@lists.openwrt.org
Subject: [PATCH v2 11/11] test: boot: imagemap: caller-owned region not resized
Message-ID: <18ba08d92985d340aed6dd006b99321f0c443f17.1792591479.git.daniel@makrotopia.org>
References: <cover.1792591479.git.daniel@makrotopia.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1792591479.git.daniel@makrotopia.org>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a unit test that locks down the fix in imagemap_map(): a larger
request against a region recorded by imagemap_map_to() (which the
caller owns and is not LMB-reserved) falls through to a fresh LMB
allocation instead of resizing the caller's memory.

The test reserves a caller-owned buffer inside the LMB-managed RAM,
records a 64-byte region there via imagemap_map_to() with a guard
pattern beyond the payload, then issues a 256-byte imagemap_map() at the
same base. It verifies the returned pointer differs from the caller's
buffer, the guard tail is unchanged, and the new region is LMB-reserved.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v2:
 - Drop the reviewer's name from the scenario comment; the
   preceding paragraphs already explain it.
 - The bare 64 and 256 spellings become the record_size and
   request_size constants alongside dst_size, so they cannot drift.
 - Drop the pointless char * casts from the pointer comparison.

 test/boot/imagemap.c | 95 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/test/boot/imagemap.c b/test/boot/imagemap.c
index c7289db3995..9024d42ea50 100644
--- a/test/boot/imagemap.c
+++ b/test/boot/imagemap.c
@@ -316,6 +316,101 @@ static int imagemap_test_map_to(struct unit_test_state *uts)
 
 IMAGEMAP_TEST(imagemap_test_map_to, UTF_DM);
 
+/*
+ * Test: map() must NOT resize a region the caller recorded via map_to().
+ *
+ * The caller reserves (owns) its own load address through the LMB, then
+ * asks imagemap_map_to() to load 64 bytes there and records it as a
+ * caller-owned region (lmb_reserved = false).  A later, larger request at
+ * the same base must fall through to a fresh LMB allocation, leaving the
+ * caller's memory untouched.
+ *
+ * Without the guard in imagemap_map() this path would lmb_free() the
+ * caller's reservation, re-reserve the same address and re-read in place,
+ * clobbering whatever the caller kept beyond the 64 requested bytes.
+ *
+ * dst must live inside the LMB-managed RAM (here: a caller-reserved
+ * buffer) so the buggy in-place re-read actually happens; a plain stack
+ * buffer sits outside that region and would mask the bug.
+ */
+static int imagemap_test_map_to_not_resized(struct unit_test_state *uts)
+{
+	struct udevice *dev;
+	struct imagemap_priv *priv;
+	struct mock_priv *mock;
+	u8 image[IMAGE_SIZE];
+	phys_addr_t dst_phys;
+	u8 *dst;
+	const ulong dst_size = 512;	/* caller-owned buffer */
+	const ulong record_size = 64;	/* region recorded via imagemap_map_to() */
+	const ulong request_size = 256;	/* larger request that must fall through */
+	u8 guard[dst_size - record_size];
+	struct imagemap_region *r;
+	void *p;
+
+	for (int i = 0; i < IMAGE_SIZE; i++)
+		image[i] = (u8)(i & 0xff);
+
+	ut_assertok(create_mock_loader(image, IMAGE_SIZE, &dev));
+	mock = get_mock_priv(dev);
+	priv = dev_get_uclass_priv(dev);
+
+	/* Caller reserves its own load address and owns the memory */
+	ut_assertok(lmb_alloc_mem(LMB_MEM_ALLOC_ANY, ARCH_DMA_MINALIGN,
+				  &dst_phys, dst_size, LMB_NONE));
+	dst = map_sysmem(dst_phys, dst_size);
+
+	/* Distinct guard pattern beyond the 64 requested payload bytes */
+	memset(guard, 0xa5, sizeof(guard));
+	memcpy(dst + record_size, guard, sizeof(guard));
+
+	/*
+	 * Caller records a 64-byte region at its chosen address; imagemap
+	 * must NOT claim an LMB reservation for it.
+	 */
+	p = imagemap_map_to(dev, 0, record_size, dst);
+	ut_assert(!IS_ERR(p));
+	ut_asserteq_ptr(dst, p);
+	ut_asserteq_mem(image, dst, record_size);
+	r = alist_get(&priv->regions, 0, struct imagemap_region);
+	ut_assert(r && !r->lmb_reserved);
+	ut_asserteq(1, priv->regions.count);
+
+	/*
+	 * Larger request at the same base: must fall through to a fresh
+	 * LMB allocation rather than resizing the caller's region.
+	 */
+	p = imagemap_map(dev, 0, request_size);
+	ut_assert(!IS_ERR(p));
+	/* Returned pointer must be a different buffer */
+	ut_assert(p != dst);
+	/* Caller's guard tail must remain intact */
+	ut_asserteq_mem(guard, dst + record_size, sizeof(guard));
+	/* The new region is LMB-reserved and holds the full 256 bytes */
+	ut_assert(lmb_is_reserved_flags(map_to_sysmem(p), LMB_NONE));
+	ut_asserteq_mem(image, p, request_size);
+
+	/*
+	 * The fall-through replaced the caller's record via
+	 * imagemap_record() (same img_offset); the table keeps one entry,
+	 * now LMB-reserved (the fresh allocation).
+	 */
+	ut_asserteq(1, priv->regions.count);
+	ut_assert(alist_get(&priv->regions, 0, struct imagemap_region)->lmb_reserved);
+
+	imagemap_cleanup(dev);
+
+	/*
+	 * The caller's own reservation was never taken over by imagemap and
+	 * is still ours to release.
+	 */
+	lmb_free(dst_phys, dst_size, LMB_NONE);
+
+	return 0;
+}
+
+IMAGEMAP_TEST(imagemap_test_map_to_not_resized, UTF_DM);
+
 /* Test: lookup() returns NULL for unmapped ranges */
 static int imagemap_test_lookup_miss(struct unit_test_state *uts)
 {
-- 
2.56.0
