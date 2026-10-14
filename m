Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12676CC6B27
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 08:39:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C5A7C60818;
	Wed, 14 Oct 2026 08:39:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YyX-cjL7BO3c; Wed, 14 Oct 2026 08:39:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 18F3F607ED
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791967162;
	b=d0g38o436YBVvw4arPLI5l/oaEd6F0h3KZjZlrmU4SIWk04kR9hCvgQo/+R+Er7WBqoY
	 JZKvAg6o+CAjKZdKppduUvF27GxQjJr2AyrIgLg1GqhbCLzOE75339Aup2CHMKhYb6Kv6
	 oe+X7HkOv+E68hS15EWJqi0yYxcyICKbVflPKAlz+KOeWW4YKarXboZftf8gdJpOueeIg
	 IvMDXYDr2N5WX750TSHIpkikRWuNU36gB+2RR53kkKJO38IkdJc9va5NHAbEQZdbMRLJE
	 xc5FAPBIveeYPuscUeQlL1quSzLIWHJLyrRJ5BNpVwT98lP7R7KUYf3cLlmEKbTIqFg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791967162;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:Date:
	 From:To:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=+EUSF1iNQPxZCGJjZv2218Zf6DhRm6lPZqrfDPBDJlk=;
	b=ku5dtBOYv5iS9w1C+7yIv48W1J/F1HCioSBul5weC0uZvHGvsey9Wd+kHg90VY5svfxa
	 9jSBRuLSxxTKaen9/PiZBLZr30ISELqqfC4lDtBnIfR3gKB7GJtUG6jiT1d/kxyifDqCF
	 YFvlodV/iM2ZgzNxv5jdb6d8JQNi5RFCMqxLIFdI4tMSTWd9jYL9w1D/ZGJC02LRhIm+P
	 NKb+ai8b0GxEFeymHiuYRS6dNghWftUxzHsy91nWH8Ieuqnpag9m6Ju+vO2SlPZkuP/6Z
	 3m2pK4RkjmwFUHD8HxP9yyEtAOk5t67ORwPO+X5gyxSwQrMvxWqh26B7G4H6AzX9h8A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791967162;
	bh=+EUSF1iNQPxZCGJjZv2218Zf6DhRm6lPZqrfDPBDJlk=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hKURZOLI5sW3Dn2cW1FefYzmmJM6uOA1rNb/PErrRVo9nXO+3VNgJYeAzSIHC+FlE
	 TG+qOGcQKAxJ2z3oGAGqiajXIObQTPBKaSjbjV89URTVNDKsTf6x5q3fr8hiZlE/3D
	 iQwpWJWipNEh9UUbf0zXdCRjlQ3+/JFu5d1p0CzpILiX4HX7ehfn3S4clpYRj/2bOk
	 Q5DelZRTpVtaKfA2KWVNRcrHyXiPD3Uyy9RBHCunHQVGABj93jvI056yHsubBjwy/e
	 4JjLsHRuuW5dTdbqnHZMb9Gu5tWs1bk+L9kwPhtgp3tN5hgoCpS/YEfgrNcN2R3RTT
	 oF7tRZZcjT3dg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 18F3F607ED;
	Wed, 14 Oct 2026 08:39:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7D219235
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 08:39:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7B00640080
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 08:39:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oJRXsiEezu6l for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 08:39:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D064240079
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791967160;
 b=sl14sbgbmbBU/VOhWOVhNUYERJrVt2rLibRund7PE7gEGtKIY/o44AoiP3zzLnW8tkYw
 yaVCJ73Eu9D9BOuSt+sH5XbEKlSNxxjtAMgkSuhRW0iR7QX/xhFDwrpXZzs5QXL1CgZX6
 ghQ1p5tr+u5/JR/vzmsOm9LoWp40fo/Wfahz0BWcImX84FNQVW13ZNGIKur6WwsLip8Q4
 sh/azH/hyYyr/IptCOarrLKDZsi/hW41uMevycxqvQeo6hvaC7vboyfECwMzg+7jYiv2h
 4JmcbRmKkDAF+JtBk19XEkKNoq4wSNFJl67gjziqka5y9XrIK82DOBd3WeFTJGyt5CQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791967160;
 h=Received-SPF:Received:Date:From:To:Subject:Message-ID:References:
 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
 bh=+EUSF1iNQPxZCGJjZv2218Zf6DhRm6lPZqrfDPBDJlk=;
 b=GIwb7CecKjZaiwy8/3Tjg2JjOjg3SdtoU5pXpxhfRQvTVR51ZVlwJhV0w+V/zUB7fCNw
 RKK9jru4v6kWrEuc4sYnLsUcIfDiT5vGt31vHetxugizG3YrjjgoEoNFPlXaenswwPea7
 RMuLwnpXJNnbBtbwHm2P41lV7g5Pn9AQu5/fLmAv8atZBe+el1fFlQ8Lu/dWN+09h93sg
 5tKZFx39cUAr0a3pCvSXm0ERpFus5f+wu1EZMGgIJO82tBkGygjowS1wg4YQGIDgRcbIC
 WIFxilkqfm20SI4brfmY3Mc4U7sGTfxdbTnRkuppkozXFoRuWRkEvNILLhaX9C7arBg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=makrotopia.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a07:2ec0:3002::65;
 helo=pidgin.makrotopia.org; envelope-from=daniel@makrotopia.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D064240079
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 08:39:19 +0000 (UTC)
Received: from local by pidgin.makrotopia.org with esmtpsa
 (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768) (Exim 4.100.1)
 (envelope-from <daniel@makrotopia.org>) id 1xGuW3-000000005c2-1juD;
 Wed, 14 Oct 2026 08:39:15 +0000
Date: Wed, 14 Oct 2026 09:39:12 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Tom Rini <trini@konsulko.com>, Daniel Golle <daniel@makrotopia.org>,
 Simon Glass <sjg@chromium.org>, Aristo Chen <aristo.chen@canonical.com>,
 Vincent Jardin <vjardin@free.fr>, Anton Ivanov <anton@binarly.io>,
 Randolph Sapp <rs@ti.com>, Anders Roxell <anders.roxell@linaro.org>,
 u-boot@lists.u-boot-project.org, openwrt-devel@lists.openwrt.org
Subject: [PATCH 04/11] test: boot: imagemap: declare locals at the top
Message-ID: <d21c48b8c37cb9225e76c996a102a3576fbd2e76.1791966831.git.daniel@makrotopia.org>
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

Two tests declare variables away from the top of the function body: the
extend test wraps its last assertions in an anonymous block to scope p3
and p2_end, and the out-of-bounds test declares dst after a statement.
Neither shape is used elsewhere in U-Boot.

Hoist all four to the declaration block.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
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
