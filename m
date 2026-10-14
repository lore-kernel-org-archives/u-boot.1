Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E6D2CC6B1A
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 08:40:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 55472406C3;
	Wed, 14 Oct 2026 08:40:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PO1MWbCjvvSo; Wed, 14 Oct 2026 08:40:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 76C98405E2
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791967235;
	b=Wl8EXTRwJKdnzNdt+BFi2i5E2Uj5IO7KpeqZXsin2HimqVjXcbwaUqBRx0e8cfpQBB1R
	 MODYd0cdu6APkiBEJDa8D3asgIL23h6Sqhc4fAw1uxGCO0g1Fc7ndyuNdSdGPnWDZ3yw+
	 xXYSNWSWterGRGfaQ3/GmQqrrX1DaULHAwrYJwvzzoomcFbD+PSM0WdSqP8cJ+rBt8pLI
	 12p1ww5FT/s/wc/drcPM4I0a/YaiQ9+FVYMWwIuyNP6QJhZqAbuOV3EIAsxSwjPsITVzl
	 oG42Z8E3jmqJMfq6GCA9VhSapz6OeUfr87FxpZa7DKFztsocbA7qJwiQLIiHAp7HlPA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791967235;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:Date:
	 From:To:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=XDX/fL/SALG4603mdEH9Ps6XE4P5HxnX5V80UaElfIc=;
	b=lhOmNVB2vo4lgvYLZtM1DFxbpclensIq0z7ge6HLeZ87B3u6yMmIu1rOdcXo5FSx1LtO
	 6G1XqukRqccJb2ritWbpH3HpevHZAWeJcECk9bLnOvB9qULjZ7hEkxUNubU3s9HPyWj8S
	 BevmDMJt+xxWF8gbZc63QAfVlsogUDOGo2YFTqecf/0CImXA3QJYMvoFeU8gC5ELUhUHx
	 Na1iOprcheYeTaJ3pSt2E07glHBLzPpF9axNEyRHW55DR9+BWeMMGEhsBHH+jQwT0aTEm
	 VWLd0c2aH+ipsPauOghh4cgf6pEezAc4X2cCWeIGIlePc9xTwjF6TU6sZOLYD+8wYtQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=none header.from=makrotopia.org;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791967235;
	bh=XDX/fL/SALG4603mdEH9Ps6XE4P5HxnX5V80UaElfIc=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LUEjIi3qvtXV0hg9D1IDx0RXh/rOUSll/FeWLr5Bk7Scs0gciqZ3v3oR3NYCqtHKW
	 8KJXz9mFeUgSAX2XI4g9yl6cB9aZ6yspEKernQDEwOW1rE94YjPNRQ8RCLi0U8lD0M
	 dlo1Ed7+nwTVvHyg+KjkSVRLnjUJHk1Xjyrsp8R1tInCf+uw8rEDz7VOKUyOK/mQfb
	 Xrs1C3qXT6Ub8vbz14oMbcMXLVlm8vCbBYisFyJWCdveGBVAnuWxuZMz4NPSmEI3oq
	 2C+oGvTntLFb/GILjfwJ4DLrVNRkEr09oP9o7SeZoG1jk80taQsmNUgzkwHxsfD+T3
	 oibrjySmQlpcQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 76C98405E2;
	Wed, 14 Oct 2026 08:40:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9373975
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 08:40:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 85867405CE
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 08:40:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L1z6oM0Z-JtU for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 08:40:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C0189405E2
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791967234;
 b=KKTTFZ5OoWduadGw3w5GOd6gN+iSsw09lRlYZh9VDWGgPBSXzIiK4gOFzxRrqjGIBbUt
 RCmAvCrKj58CH4c6pi0T3BQvgBHD7pU/lxeM4SvqeQRg0/b2OXTqGPpRSJu0pmgLZNSpX
 B29h86ntiTAgiifvSe7Wt4jmkgTBOs7bI5/RCv5Xq6gxNajexdX49fFu/8VQjLo18AwTd
 D8svOj5o/aM7rc5r9jtJJYmPo4VeKAgOQ74yR/EYpZrd+shpi9meR2UkANerbd4LmnLEl
 TRJ7+DZxJ08UtmGCYnLDTgc06hAi9TIzoH6NnKCVrDJR/uATQeIFfA88yjfJzKGmanQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791967234;
 h=Received-SPF:Received:Date:From:To:Subject:Message-ID:References:
 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
 bh=XDX/fL/SALG4603mdEH9Ps6XE4P5HxnX5V80UaElfIc=;
 b=JaaqRb+PybuGISj1WoHTTvcTiEg5R1CMCVOxfJ3C040fufGARqAHkrEjLIygzHeb5BFC
 PecPWyDtumJ61GWOGM4LZy/c0Gep1DZn2I9GQWlYwfqqWI9yyQjvhjdT8Tqz630A25GKL
 v95W/uuXhWuvx7GoF+W+lIWqjJDQEXKtHyUJaABQRBfcnhvw70DdeqDcUK5oZIlH6v94f
 +GG13P/3FPPUs24GjgaLLJhTrZrMalJfdaTTkTpUbXmllW/gmFM6yutpM4ZURChz1OTXi
 HjW8PhrzMwTm9Z8u7eTNU+wsqMnw+NQnT+nEtVuGWpG8QEpUtp0yMmjBe9h5lPo9eig==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=makrotopia.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a07:2ec0:3002::65;
 helo=pidgin.makrotopia.org; envelope-from=daniel@makrotopia.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C0189405E2
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 08:40:33 +0000 (UTC)
Received: from local by pidgin.makrotopia.org with esmtpsa
 (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768) (Exim 4.100.1)
 (envelope-from <daniel@makrotopia.org>) id 1xGuXG-000000005gx-0Rq4;
 Wed, 14 Oct 2026 08:40:30 +0000
Date: Wed, 14 Oct 2026 09:40:27 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Tom Rini <trini@konsulko.com>, Daniel Golle <daniel@makrotopia.org>,
 Simon Glass <sjg@chromium.org>, Aristo Chen <aristo.chen@canonical.com>,
 Vincent Jardin <vjardin@free.fr>, Anton Ivanov <anton@binarly.io>,
 Randolph Sapp <rs@ti.com>, Anders Roxell <anders.roxell@linaro.org>,
 u-boot@lists.u-boot-project.org, openwrt-devel@lists.openwrt.org
Subject: [PATCH 11/11] test: boot: imagemap: caller-owned region not resized
Message-ID: <a29db1a74718b863e7c507af877f0c1f823e0bcd.1791966831.git.daniel@makrotopia.org>
References: <cover.1791966831.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1791966831.git.daniel@makrotopia.org>
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
 test/boot/imagemap.c | 97 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/test/boot/imagemap.c b/test/boot/imagemap.c
index c7289db3995..e038f5377cd 100644
--- a/test/boot/imagemap.c
+++ b/test/boot/imagemap.c
@@ -316,6 +316,103 @@ static int imagemap_test_map_to(struct unit_test_state *uts)
 
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
+ *
+ * Mirrors the scenario Simon Glass asked to be locked down: a guard
+ * pattern in dst beyond the requested 64 bytes must survive, the returned
+ * pointer must differ from dst, and the new region must be LMB-reserved.
+ */
+static int imagemap_test_map_to_not_resized(struct unit_test_state *uts)
+{
+	struct udevice *dev;
+	struct imagemap_priv *priv;
+	struct mock_priv *mock;
+	u8 image[IMAGE_SIZE];
+	phys_addr_t dst_phys;
+	u8 *dst;
+	const ulong dst_size = 512;
+	u8 guard[512 - 64];
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
+	memcpy(dst + 64, guard, sizeof(guard));
+
+	/*
+	 * Caller records a 64-byte region at its chosen address; imagemap
+	 * must NOT claim an LMB reservation for it.
+	 */
+	p = imagemap_map_to(dev, 0, 64, dst);
+	ut_assert(!IS_ERR(p));
+	ut_asserteq_ptr(dst, p);
+	ut_asserteq_mem(image, dst, 64);
+	r = alist_get(&priv->regions, 0, struct imagemap_region);
+	ut_assert(r && !r->lmb_reserved);
+	ut_asserteq(1, priv->regions.count);
+
+	/*
+	 * Larger request at the same base: must fall through to a fresh
+	 * LMB allocation rather than resizing the caller's region.
+	 */
+	p = imagemap_map(dev, 0, 256);
+	ut_assert(!IS_ERR(p));
+	/* Returned pointer must be a different buffer */
+	ut_assert((char *)p != (char *)dst);
+	/* Caller's guard tail must remain intact */
+	ut_asserteq_mem(guard, dst + 64, sizeof(guard));
+	/* The new region is LMB-reserved and holds the full 256 bytes */
+	ut_assert(lmb_is_reserved_flags(map_to_sysmem(p), LMB_NONE));
+	ut_asserteq_mem(image, p, 256);
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
