Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA023606A331
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 14:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Rf/CiCm8
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 73861408EB;
	Wed, 21 Oct 2026 14:09:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RDTOgcuTWKGL; Wed, 21 Oct 2026 14:09:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AA2B5408DE
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792591776;
	b=KJzuI2myAz8xBfIsEA6/6Swr5WFTz1M3iV33SDaqOD/YxWDC/sBI0aCpk+627fly+bL6
	 f+GDwJEQQIHNRGbzKbxzLfZlR5EinpkfyOY7XzeiU5xhk90ClxZlbxNhOfF+lga3e6WQf
	 cEY+pBmOkChy7ZSpCLt/RQfzF/q/3Lknya9xI2yrwfgpeVHC0uo9fTTlNtkVoRluLcd/T
	 uymR8Q3oZmGseZ3ABkmJFIAsPVSF1CV8fbqIL79YuWaM+8G4iIC7bqerEQzyjaTfCtro5
	 t84ZVe5O3Thv9LDI48Id7ZPc8acAKX6iNCipo4pPixQ+l3fJl/5spmQtjkCcB3zQTuA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792591776;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:Date:
	 From:To:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=xC1to4VE0fOlkWnhLYhDk9p5TzsJXS2cn77K+rDrv9A=;
	b=LUQqSD7/KMpyOBUZDKt08lsVTvat5RZEPre3/rFrRhiA7OH1eGFunXtBLpB9UO0FczcJ
	 zIZsD2DCgy5006d9BZ0WoWIew7ZRVRjkwtQMmREvxsK8reZNs5rEZzmBWL99htpAzWeFk
	 XDZ7EcjVLhBgsXpP0E19rgV/3CnunQYCElCddWA8dnuSLmZyKbWIwI7LzzdbVS+mM7T1b
	 gExuNu+5ioioSO936CC04MIcLR5iqWls+bjfYwVQayj1tHWF2G+8pflMuArDfwGZhaNBQ
	 aiqvyI1J5qdQ56dKG8kdPdtafLdZW3/1jyPoFnoNp9eDZrC+19SVXcZYoA3VUqTlJdQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792591776;
	bh=xC1to4VE0fOlkWnhLYhDk9p5TzsJXS2cn77K+rDrv9A=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Rf/CiCm8W1i8eDQkcQ8KhLmxDHQi1TjISQkH6Skw6iM/Tnjv1mLtAmaaI/MMxWExI
	 lky7TccEeIx3/RC5KMfgSvKM1V/St4C7REZbPUt/ac5BvBHFRH6LnfStrrqszy7+ss
	 Tom57pK/Wx4dxQYW+BEdxUplSsb1MpO49R48Hsmsp+BKwvyCEAPW5qxMxTaYeabqri
	 2HVft7RMqqfMDJyjU6icvMAlieRDcr/lGQk0GJjftx6U1SoCdb5ll9J9xK4JQrNyOR
	 gFKFPo/hV8UmEPBeFJ3trtlkS6GgoCNLYv95lJATzYDTUxpuQ2OX+LPgWlViabVHq5
	 MM9xcPjWWIgKA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AA2B5408DE;
	Wed, 21 Oct 2026 14:09:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2B38D3A4
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 14:09:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1122D811A0
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 14:09:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mp1AlLjHcHYu for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 14:09:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4A87B8116F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792591775;
 b=NVGAC3uv7WOxjGpUarl5IkNuNt3fYggrBl3W+5Q/7CfvsBSzBNXs7/hJ0HDJvPLXs1Aa
 kVhSDnCbT0RkkJTPIPZkbVp+lChlVJaYDqUmOqd4/fgygBQK/tNDynqvJ416fB3evgEga
 Aok03Oute7FlULIqOmUmWC5LBgrfIvqviKunt3LXAxfGOvva2jp33SPaG0sVdxwKXIJVR
 CeLApmnpT/1Vm1KIPUzZT4numXga5C+OeUoI/2t0TpU7Wy3eHETCWm5A8e7xo0OkNjIXv
 q9JE5FAg8kuqpXSi2I6eVsjjiTvfYYwsjaXcOzzLkx5ZPbwFAg8w6x6bhFMfM3f4RmQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792591775;
 h=Received-SPF:Received:Date:From:To:Subject:Message-ID:References:
 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
 bh=xC1to4VE0fOlkWnhLYhDk9p5TzsJXS2cn77K+rDrv9A=;
 b=jkbXQbUwwpxjEBhH2qgKTHlDIupZD8bedsws1Xeg4nYCbOd12sV89LX3pcf+amNgEuLT
 NQk1/bXA9vuziYKdm+RwJ31w/OTHOnc2FTiozIubYIsV2VYAtSXlqbAMH1ex7KTIX08h2
 Pvsyyyg1/33n+YEE/cIaJsU0QGP9m8ZRvBhLIbVqRRd6ZWUbshXfHvpsVC8GiB4Sb4IFG
 3ydFpOI62v9y8OLFMESsTu1DlbuISDb4cW1OOiI15Llxj+5Xg/0mp4GA9WMVMJMIXvWt0
 o33S6uhBYxGCbeX5ExoOYrHCXpebkM6dzC4/tefL3D6fmn5KE9hhX3hxrKccpROfXqQ==
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
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4A87B8116F
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 14:09:33 +0000 (UTC)
Received: from local by pidgin.makrotopia.org with esmtpsa
 (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768) (Exim 4.100.1)
 (envelope-from <daniel@makrotopia.org>) id 1xJWxM-0000000024r-1G2R;
 Wed, 21 Oct 2026 14:09:30 +0000
Date: Wed, 21 Oct 2026 15:09:27 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Tom Rini <trini@konsulko.com>, Daniel Golle <daniel@makrotopia.org>,
 Simon Glass <sjg@chromium.org>, Aristo Chen <aristo.chen@canonical.com>,
 Anton Ivanov <anton@binarly.io>, Vincent Jardin <vjardin@free.fr>,
 Randolph Sapp <rs@ti.com>, Anders Roxell <anders.roxell@linaro.org>,
 u-boot@lists.u-boot-project.org, openwrt-devel@lists.openwrt.org
Subject: [PATCH v2 04/11] test: boot: imagemap: declare locals at the top
Message-ID: <2f55498f244409ac042e1dc2f5550f27cae3e879.1792591479.git.daniel@makrotopia.org>
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

Two tests declare variables away from the top of the function body: the
extend test wraps its last assertions in an anonymous block to scope p3
and p2_end, and the out-of-bounds test declares dst after a statement.
Neither shape is used elsewhere in U-Boot.

Hoist all four to the declaration block.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v2: No changes since v1.

 test/boot/imagemap.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/test/boot/imagemap.c b/test/boot/imagemap.c
index de00a174470..c7289db3995 100644
--- a/test/boot/imagemap.c
+++ b/test/boot/imagemap.c
@@ -231,7 +231,8 @@ static int imagemap_test_map_extend(struct unit_test_state *uts)
 	struct imagemap_priv *priv;
 	struct mock_priv *mock;
 	u8 image[IMAGE_SIZE];
-	void *p1, *p2;
+	void *p1, *p2, *p3;
+	ulong p2_end;
 
 	for (int i = 0; i < IMAGE_SIZE; i++)
 		image[i] = (u8)(i & 0xff);
@@ -264,17 +265,15 @@ static int imagemap_test_map_extend(struct unit_test_state *uts)
 	 * With LMB allocation this cannot happen because each allocation
 	 * reserves distinct memory.
 	 */
-	{
-		void *p3 = imagemap_map(dev, 256, 128);
-		ulong p2_end = map_to_sysmem(p2) + 256;
-
-		ut_assert(!IS_ERR(p3));
-		ut_asserteq(2, priv->regions.count);
-		/* New region must not overlap the extended first region */
-		ut_assert(map_to_sysmem(p3) >= p2_end ||
-			  map_to_sysmem(p3) + 128 <= map_to_sysmem(p2));
-		ut_asserteq_mem(image + 256, p3, 128);
-	}
+	p3 = imagemap_map(dev, 256, 128);
+	p2_end = map_to_sysmem(p2) + 256;
+
+	ut_assert(!IS_ERR(p3));
+	ut_asserteq(2, priv->regions.count);
+	/* New region must not overlap the extended first region */
+	ut_assert(map_to_sysmem(p3) >= p2_end ||
+		  map_to_sysmem(p3) + 128 <= map_to_sysmem(p2));
+	ut_asserteq_mem(image + 256, p3, 128);
 
 	imagemap_cleanup(dev);
 
@@ -455,6 +454,7 @@ static int imagemap_test_read_oob(struct unit_test_state *uts)
 {
 	struct udevice *dev;
 	u8 image[IMAGE_SIZE];
+	u8 dst[64];
 	void *p;
 
 	ut_assertok(create_mock_loader(image, IMAGE_SIZE, &dev));
@@ -464,8 +464,6 @@ static int imagemap_test_read_oob(struct unit_test_state *uts)
 	ut_assert(IS_ERR(p));
 
 	/* map_to should also fail */
-	u8 dst[64];
-
 	p = imagemap_map_to(dev, IMAGE_SIZE - 32, 64, dst);
 	ut_assert(IS_ERR(p));
 
-- 
2.56.0
