Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8247BCC6B3D
	for <u-boot@archiver.kernel.org>; Thu, 15 Oct 2026 13:55:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1311760907;
	Thu, 15 Oct 2026 13:55:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Sl-oRnKzfvqq; Thu, 15 Oct 2026 13:55:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 59EBE608D9
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792072525;
	b=imYB5njzkZMkXoth3+idA23KWK6mToZaL22MW8fZXhH+MXEf5vSEikhpOscx9hOgTPhH
	 cZH1Hdoq6rT7PlZOL4xiBPkg/G9Yk/UCZwsSgtHNRbf/WkdCcLVqP+0n98F1qLgTPhYxQ
	 LiM3KFxEHuQl6SMWdjCiqbIFTP9l6ZtVIMycIMia86xHSflFWHwqMh+hnPvRvUAYNlMB5
	 cvrQZlfMz+OnJnDk0M1ybGd2NXdm4lJBDHdrHUaRs3x5B77EzudYPnzCXkJ/QJDr/ncWs
	 gjb+vWVXUkjGT+duAJxnHJLyUdEVVBcD55Z8r4PGAWtf44ox9kat7qLDwlhTD0tV5tg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792072525;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=v2pq3Hfl0wleyrXH0AJ94bCd3Qj1Fx69tS/ISmO9PwA=;
	b=KloGpV5gVs171OzvomPeg4G1fM/ansYJND7gxU+4tKcwLqWrJU49Czxo8trz/GVYlMrJ
	 njZK+T00S38E9zCc7e1BUbSgQyEN1yNeyazq994NVhDz1SQyQlNewRen9y8TXoOERv5Y3
	 hK4PlsciJ34bYoDZkaWxBaIVInfEkRaU4r1rVl/UWhPJCqhVfagBm3+P5eSD2tskiH0jr
	 Cg/mot/S73NV1Txm5xQDMaH77CVzODvEgWCEchnN+0VSWoFWYW8Mr9QEdFZ+uWpRN+cHX
	 M4QpJh+pBESpmO/olQdpVdJ2CVTeP3mwxPm8nln1J3ImIALylXBRVqpQUUw1ouvZSDw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792072525;
	bh=v2pq3Hfl0wleyrXH0AJ94bCd3Qj1Fx69tS/ISmO9PwA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Q42P/IQYBNmvq504Cn9kCbJfotKEdzlRgd4/xps14FeTmBeLgcEGFnhWldbwYm5W0
	 AKVhZcmPvgBk1sABV7fw5hBfPnorgzm/+F10Tq7GKAW1FWIqKzkECaB81Y6GHU1uqn
	 EOXPwTE3RkZ8owM1zy564pzyjvHKy8260/o1sb9V02BO4ZOhzRYYMd2/BJe+aRV24c
	 QXRTTkMIuZCojqvFtJ42S7kOMdU5l7daGirPxqmFP9Lw1GRyi2T8VjKqDQsPWZtOwh
	 Ybdz6fRFPatZgNtyuK6vIt0OieVLKm44Wi0U2xgTSdwU5bXQ0lQ0w5qnGgW25//R/V
	 Agi+Gyz77Zq6g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 59EBE608D9;
	Thu, 15 Oct 2026 13:55:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 10D8B2E0
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 13:55:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0299681212
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 13:55:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ye56mCJiJdno for <u-boot@lists.u-boot-project.org>;
 Thu, 15 Oct 2026 13:55:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5ECB280E47
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792072518;
 b=paUl6RSMPjnbE7lSFXPSMjXcI6ylfmvVM43Gxwa5aIqcMO5vQ/Fv/4h1+kAzvt3O20l8
 wojL4zAfgNgXyxUMLB/y7+rnzzLm7RQYTph7mmzBae61SqvJCDMICSGd0QsDQL4fl5Tm8
 W54bn+ESCx09MNHnguCkcRwFiC/f9MufNBprD/nhRCQok5CcE9JeMuH4Oeggi/oSKhCJ5
 tLHWpvqJ9Tdj8dyQU5gIVms4NeHNk4KPF7vgp47qQf+si2jyLaGX5f09V9BmCCvQXjI0y
 hVuXdDFnoOQS3rf91p7WrbkXxdRWpBj1Ml0RCgxqS2C6JhfXzAxJw1MJ2u3F+9SzK1Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792072518;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=v2pq3Hfl0wleyrXH0AJ94bCd3Qj1Fx69tS/ISmO9PwA=;
 b=ZItld8yQqtuEMypJQB0S1ObdCxPLxOCd6wWvF8XFgLmcmB5px3F0DS2iU8hq4jCEk1hv
 B7vWKxQa6jYzqOuJLOYC6FcgQ3pHZCGy39W89qatiB54QCQg/AbcoUK2SH2aW8WZGsoMJ
 /e8iiMvFuYnPcV5Wlznq+Zli9KD57biXtjHPDRpZQGqc5T1vRysUTppx6qN+Rkc97spod
 4Rd8DWNoTfqeTvUfEeUCFmA7f7+4XC8xEM9n7a7CO7wjKRXAvfKDF4A3ihCw8+38lZ0rQ
 CJWUnep9kcut2rhRkc75LzwkrcKJepLlM7pTs9Z1cM5bj48vVQtUU0uxmpSwAk1rV4w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=eWnF6Ljd; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=eWnF6Ljd
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5ECB280E47
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 13:55:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 01749435BB;
 Thu, 15 Oct 2026 13:55:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6626B1F000C4;
 Thu, 15 Oct 2026 13:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792072516;
 bh=v2pq3Hfl0wleyrXH0AJ94bCd3Qj1Fx69tS/ISmO9PwA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=eWnF6LjdWaB0mkbDcczFVpT2VRxUaMepMI0xaYPkFjPuYa858e1DqzzIvTc5DaxHe
 DletgbTCrUMgsmmOr9i+iwXR6kZcso508PsxayJPFIq2PzzUqzBp8ROCMZq4RzjBL0
 DMDpA+68cVT/+E3I8GLvzWuBszGz5ckZ3vqlOc7QI81yrzy5w2mz3uBBXzm3ht80qJ
 LdAD4B5a4/YVRNzu0yMMlpYMFfrVG/Zq1HCNg9hbRtDUfwCZv2aLtr4QgdjubbzGj9
 JOYxakFY4bK0UF3a1su+kdVq6Y77Z+oAOaOGEJtY6fAlCjD4Rx7rfueoTNfNlLZXKq
 GvQdYMHFdMGSw==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
Date: Thu, 15 Oct 2026 15:54:51 +0200
Subject: [PATCH 01/10] avb: Use map_to_sysmem() for flush_cache() address
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-test-avb-fixes-v1-1-9e5b82644359@kernel.org>
References: <20261015-test-avb-fixes-v1-0-9e5b82644359@kernel.org>
In-Reply-To: <20261015-test-avb-fixes-v1-0-9e5b82644359@kernel.org>
To: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Jan Kehren <jan.kehren@emteria.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1350;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=pEmnykcT+C2wgzZoMN1tlz/Zbh7iA/V037I+KsDXvS0=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBq0Ns+Oiu41R9L1XmKKG6UG/8aW8U4hnH1RsQ1D
 8IMQJAIh9OJATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCatDbPgAKCRAZDR20Zk4Z
 NdLsCACT2Rga1GQzLVb3falohDrDNJCO1OK1P4HE4o/mmjYx1pCv3wmpFDHTC4GeB9x4wOYnwCi
 od6vtFmKWU0d9C8PoFb6JFezEawvPYwtz9NeBI/qbvqqEoBLHOKohVPUaLAZpGNDid29j2Q7Div
 dNM2QO3LDxLs2Gi3CnXMvTzwss04W6R1LNixIgFJD5CG3S7bBJfFqVmUIH26JiEU2ywPPSvdWI7
 el6ShDkBHj4zzqlKihCHuuE+z8TkwcPdzi5J7d6cR7NiSyd+depalhHLl4jT0TYEXeycuAQ9nGd
 XQimajqryiVpWytz95O6isZlHsbjHGRt3BjLFrS+409ngvBC
X-Developer-Key: i=mkorpershoek@kernel.org; a=openpgp;
 fpr=8234A35B45C0D26B31C1A2DA570338B018144F28
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

flush_cache() expects a U-Boot physical address, but avb_verify's
mmc_read_and_flush() passes a raw pointer cast to ulong.
On sandbox, host heap pointers (e.g. 0x1a27ee70) can be outside the
emulated SDRAM region (0x0 to gd->ram_size), causing map_sysmem()
inside flush_cache() to crash:

  phys_to_virt: Cannot map sandbox address 1a27ee70
    (SDRAM from 0 to 10000000)

Fix the crash by using map_to_sysmem() to convert the buffer
pointer to a proper U-Boot address.

Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 common/avb_verify.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/common/avb_verify.c b/common/avb_verify.c
index 09f1534c3cc5..d157adc4af07 100644
--- a/common/avb_verify.c
+++ b/common/avb_verify.c
@@ -7,6 +7,7 @@
 #include <blk.h>
 #include <cpu_func.h>
 #include <image.h>
+#include <mapmem.h>
 #include <malloc.h>
 #include <part.h>
 #include <tee.h>
@@ -346,7 +347,7 @@ static unsigned long mmc_read_and_flush(struct mmc_part *part,
 	blks = blk_dread(part->mmc_blk,
 			 start, sectors, tmp_buf);
 	/* flush cache after read */
-	flush_cache((ulong)tmp_buf, sectors * part->info.blksz);
+	flush_cache(map_to_sysmem(tmp_buf), sectors * part->info.blksz);
 
 	if (unaligned)
 		memcpy(buffer, tmp_buf, sectors * part->info.blksz);

-- 
2.56.0

