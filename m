Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D3D606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 11:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=V7sICZgb
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 75D9C40AC5;
	Sat, 31 Oct 2026 11:13:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5PhFy2LLFwHJ; Sat, 31 Oct 2026 11:13:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 832A840AD3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793445208;
	b=dzTe6jzpQYHQYXGiTUay6OP7hGR4UueE8Dfb7LLcwT5c0cYuizxPYzwxf2CirUfJuTQ2
	 MDoA9wPuC9vV3M3ix7xcv03IXo/5gzd5xJxro2BiuJHYZGVqo030KXTdP5Ibm/HDUqLkT
	 nIgn4OuMUBSurMjz2ujCYNtNY8C28O9kyGRu9/6Haw+lQrBWgekOnrEPPzRiaavl7pnWO
	 sLXVlh+Pw32QXzQlaRiXzqLJsM97W8GtY6/RdHdGhPnesZ2TcHupHtLatC3eL4wTL+PZq
	 R78dN8Xf1eCoOA34h4jLiEXBb5T2BiP0OkS7PMZ1yhmDq4bWosOW0LbNm4tHQvh4Fow==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793445208;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:Date:
	 From:To:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=B2D888FmvLMmzaCLzEUoEwQXY2/ebYK7VowJFkNoeQ8=;
	b=ML/DwfldpiDwtfADdJTLM5pI/K7dPN2bVs6WvghhlOCfk6vBVzhh77KzfFlPF4ESjaYH
	 Itaz4HIy16TH4lSr7aJlvYoKr/enQSNOHb+NHbzFsBi/+DE2g3oX+Qnf10yKbFNTzHVyC
	 tQ4mCnAINb4a5uY/KrM7TqmfVyewJi+g+rvI2cvSo09zR/UzrS+0U4DMYsML5n6ph7G8M
	 A6DVCnRw8+QX8opbvbBjfaao8j00X0fb5xz5aUdrKv9mLLFDMoBczkIGxP+12b0QcB4W+
	 SW2/EiQFCzUg4Alvo4oG6BecY+O0IXtmHUW0BIKhDY/Or8mnc5kApcvm8QJe37FHvhg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793445208;
	bh=B2D888FmvLMmzaCLzEUoEwQXY2/ebYK7VowJFkNoeQ8=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=V7sICZgbdasp7Xw9Uf2gn6TfnYjMQnn4J2MR6tIY6Ag9FZWsd1eztkxiL+TVGetvY
	 IN0ZvjQKehA3nmLdOMxS2+Ajj7a+bVSafNR7eTXWyJCtZ7IGZLu6IApbWBr+jrxxkh
	 XHG/ANqxmuyj5fAw2fOZsecbOKHZqhQ1EpM2egdbCFsb27rrzKKxorc9ulSIK5XGsh
	 shnzH9diz1qMk0uoDmbHRsJiCQSBrfK1QQ4fj0L5NNiOgruobmBLsB5ef53wPL6nKh
	 UMU0vPWMnJrShZo/H6cY8Ewc91hBjwOUigQeRBOEjxEU1zkB/nMj3wjNHSn8Oo8c7n
	 poQn/SEWR/ohg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 832A840AD3;
	Sat, 31 Oct 2026 11:13:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 24117473
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 11:13:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8AB708118F
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 11:13:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DZPC7UXmVZr3 for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 11:13:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CAB2581173
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793445203;
 b=qrab+j+TwmlmN2H+0je7prrizdSnHh4td2J5j3NL/CzYIW0pw+cXIKNzdi2Wuj62D29x
 3lk1Ce+uWwynZGfhBDZKkdXWZa/6POThDMdBVzGA/ayjb51lBN121gWobSawdSQ3mCt5U
 uNJIO3R7Le8xl9oUZEb45y8cFZKpejXMzb3a7acQWZvDZkKg1voo/JrrI/39Ze7ZAqyI0
 qxq0/3begob2JE6Uqj+Qpgv4qEjHlCoUJ5/H+SNXZO1qFooKLBCXbEC5SNX1AYyWvAV4f
 yhcv1FtlFJbHQaUMuSDvyrHLVWVoWrar5oVNTFUNxD2Lj1X7jkRIpZDdizKbcBTAoTQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793445203;
 h=Received-SPF:Received:Date:From:To:Subject:Message-ID:References:
 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
 bh=B2D888FmvLMmzaCLzEUoEwQXY2/ebYK7VowJFkNoeQ8=;
 b=d/XpV5aoyh4RzCPyapCJo6P2RqOm8KCwJkAJz21o4xPcqUXfLzNUPCzI7bAHaVRB/eWY
 9OngJfheQm3qwrSWNfSUFxPnKzgiyhWEVSgzFIy8BBwkldUsVjkv2S4pttyu3qebDx1kD
 +RtQ0BqJxoz3GXEWCtGBh504N6Dbt+nBoCSWrnWRoyAVoEzm/EJirfX7N5xr37A4vHkAB
 FzaYF5skKOHEKL84T/9BXsHwxWZ3Mj5HZHgs7apih2bgh3LAlgz5UOS7av1DXrBrQI1/7
 oOgrRsMnBlFG0q3JRxCG0h3oqOm97QHntfRNhA+0xwO00IiuYv8m0AHi8KuB2L9eGBw==
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
 by smtp1.osuosl.org (Postfix) with ESMTPS id CAB2581173
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 11:13:22 +0000 (UTC)
Received: from local by pidgin.makrotopia.org with esmtpsa
 (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768) (Exim 4.100.1)
 (envelope-from <daniel@makrotopia.org>) id 1xN6yL-000000003T2-1n0R;
 Sat, 31 Oct 2026 11:13:19 +0000
Date: Sat, 31 Oct 2026 11:13:16 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Tom Rini <trini@konsulko.com>, Daniel Golle <daniel@makrotopia.org>,
 Simon Glass <sjg@chromium.org>, Aristo Chen <aristo.chen@canonical.com>,
 Vincent Jardin <vjardin@free.fr>, Anton Ivanov <anton@binarly.io>,
 Randolph Sapp <rs@ti.com>, Anders Roxell <anders.roxell@linaro.org>,
 u-boot@lists.u-boot-project.org, openwrt-devel@lists.openwrt.org
Subject: [PATCH v3 11/11] test: boot: imagemap: caller-owned region not resized
Message-ID: <f2954ac43ec709aaa1d89cbf362f86c487e17524.1793384548.git.daniel@makrotopia.org>
References: <cover.1793384548.git.daniel@makrotopia.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1793384548.git.daniel@makrotopia.org>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
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

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v3:
 - Declare the region pointer as const struct imagemap_region *.
   alist_get() yields a const pointer, so the assignment failed the
   CI build with -Werror=discarded-qualifiers.
 - Give the three sizes macro names, so the guard array has a
   constant size.
v2:
 - Drop the reviewer's name from the scenario comment; the
   preceding paragraphs already explain it.
 - The bare 64 and 256 spellings become the record_size and
   request_size constants alongside dst_size, so they cannot drift.
 - Drop the pointless char * casts from the pointer comparison.

 test/boot/imagemap.c | 97 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/test/boot/imagemap.c b/test/boot/imagemap.c
index c7289db3995..2c6f23fb4f0 100644
--- a/test/boot/imagemap.c
+++ b/test/boot/imagemap.c
@@ -316,6 +316,103 @@ static int imagemap_test_map_to(struct unit_test_state *uts)
 
 IMAGEMAP_TEST(imagemap_test_map_to, UTF_DM);
 
+/* Sizes for imagemap_test_map_to_not_resized() */
+#define NOT_RESIZED_DST 512 /* caller-owned buffer */
+#define NOT_RESIZED_RECORD 64 /* recorded via imagemap_map_to() */
+#define NOT_RESIZED_REQUEST 256 /* larger request, gets fresh memory */
+
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
+	u8 guard[NOT_RESIZED_DST - NOT_RESIZED_RECORD];
+	const struct imagemap_region *r;
+	phys_addr_t dst_phys;
+	u8 *dst;
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
+				  &dst_phys, NOT_RESIZED_DST, LMB_NONE));
+	dst = map_sysmem(dst_phys, NOT_RESIZED_DST);
+
+	/* Distinct guard pattern beyond the 64 requested payload bytes */
+	memset(guard, 0xa5, sizeof(guard));
+	memcpy(dst + NOT_RESIZED_RECORD, guard, sizeof(guard));
+
+	/*
+	 * Caller records a 64-byte region at its chosen address; imagemap
+	 * must NOT claim an LMB reservation for it.
+	 */
+	p = imagemap_map_to(dev, 0, NOT_RESIZED_RECORD, dst);
+	ut_assert(!IS_ERR(p));
+	ut_asserteq_ptr(dst, p);
+	ut_asserteq_mem(image, dst, NOT_RESIZED_RECORD);
+	r = alist_get(&priv->regions, 0, struct imagemap_region);
+	ut_assert(r && !r->lmb_reserved);
+	ut_asserteq(1, priv->regions.count);
+
+	/*
+	 * Larger request at the same base: must fall through to a fresh
+	 * LMB allocation rather than resizing the caller's region.
+	 */
+	p = imagemap_map(dev, 0, NOT_RESIZED_REQUEST);
+	ut_assert(!IS_ERR(p));
+	/* Returned pointer must be a different buffer */
+	ut_assert(p != dst);
+	/* Caller's guard tail must remain intact */
+	ut_asserteq_mem(guard, dst + NOT_RESIZED_RECORD, sizeof(guard));
+	/* The new region is LMB-reserved and holds the full 256 bytes */
+	ut_assert(lmb_is_reserved_flags(map_to_sysmem(p), LMB_NONE));
+	ut_asserteq_mem(image, p, NOT_RESIZED_REQUEST);
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
+	lmb_free(dst_phys, NOT_RESIZED_DST, LMB_NONE);
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
