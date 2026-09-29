Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC9F6CA5FA1
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 00:05:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6A66460717;
	Tue, 29 Sep 2026 00:05:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8bVjFEtdvydC; Tue, 29 Sep 2026 00:05:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org BA975605E7
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790640330;
	b=nkdl6dNH0LlQkSyBy5Be8dXc7sqoSvHk35GFlbJmTZugu8deynVJjkiRu/91S0LMu81X
	 dl9cHf6nOApb3fzkiRVnhSKyPjnR4VzdOdca5ISsY3cKOCfpOGX0hAl8ic02JOAJysF57
	 cQ2NFPckERQlsyhNQWTDLs5YQh6OmaAK0GnCB6ITChaHZW2DRe0AKnMmctDNApN04vEsR
	 RRUY0g3bAr/UA0UCK2QYUklfxkuQ/0iKlkni0tmCo+YrIFyqq1CJ93Athy1RJ/irFmKpj
	 vc26PZxFpBjO6odrGZkuUg5QeDTI0KFetf0X24ELyFWA4SPj0uH4KyUP3zM7zNzSuzw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790640330;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:Date:
	 From:To:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=RysI9jMR1QaluaMwgTN4HdCZ8yadsra/+dYAXgPOttU=;
	b=WfHBn80MiESQ7RKDafJ6U4xHyV8D6eOiZZolI12XsHLG3Gn2+8aDF43+MFFj25M/SWp2
	 m5B7fb30ROaZO1hjOMS5ZQ4SIiRz3odOGv4cISW2WLQYMJj8ObkNFpgUlD0rH6aZH8gAc
	 asEKWue111QICGw+eID90xyUrpIENgmHZhgckojLz6dClFrqVJPlOpgEnoAC9ShGqj02/
	 n3gpk705J4Jj1iaird1isWZ/cOv/x24bqqCZeKwYvArIcr5t7oWzFg0DFmoc56E5PtmXX
	 iJs6HTNsq7SYH24ZJ5i/6AyUUh3z98hs1CXFtniFk8B4lLVLUmRiq8W09zj99no5Q0A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=none header.from=makrotopia.org;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790640330;
	bh=RysI9jMR1QaluaMwgTN4HdCZ8yadsra/+dYAXgPOttU=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lC5JR8f638symSZdyx+Sqs696W025zXbpJBdPS6jdXGkdPX339rlYo3SGTsMQO/eG
	 k+x82x2m52a5/58U/OLz/GsC/3XLcZml6fPRfnmKy0fSsanGvT/3ehlfGVyddh76Vp
	 iJQm+KqCMgc7AF0Z8fWVKfErcKvhn7OUf1emQDQiUvnl5mLCRWXz/LuZeSXw3fEvsV
	 7aSRJqUYyWMitJf29HPcvuLsqIqA7y+aSflkMI7witTIRCodySiw5KbLvifASWYIOM
	 cAYKDs8U4DGT5zuRDhsX+1JP/s8qMgZINuXyJOvoGD4qFPXOmJYgjHBQoGazKpi1kN
	 nfQy2/CrFbq9A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BA975605E7;
	Tue, 29 Sep 2026 00:05:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 09287335
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:05:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DE6CC605E7
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:05:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Lql3olnFl5AA for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 00:05:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 3CD75605E4
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790640328;
 b=mOAZ89MQSYFzmn1fidm6q6UzlUaz4TqzWYaqtLZPbcL0+O6pqx+RhJHTed3kDBDjR5qi
 37WvvLQ8vrOMuWx7wPNWmfegpZFLpui6+wjqXah+1ga5V/Uz/O3tVfa0kGL1Js8aiQMfS
 a0Jy7QEBKwcWRxYwvxJwviG7NXWb+Sxf3nAAWb7fKABGOgohYfBAv/FQT1a7IM5KpWvYm
 Fp980bZbgTQKUeu7tFu3d+Gz2L6iodkoRdzfJRj0Pz3ARNh+MZq/5hUIMfOTGEeV3xwCQ
 S5lbDy9pvqTX30Q9AS9wB7VthNWALxSPeEeHGqnyTV1VWdWQcE/cOVlvIiVLPQQGT3g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790640328;
 h=Received-SPF:Received:Date:From:To:Subject:Message-ID:References:
 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
 bh=RysI9jMR1QaluaMwgTN4HdCZ8yadsra/+dYAXgPOttU=;
 b=Khbc1/W+ibH5++okazTCugCcK9OMAZmJ/f5z3zLpsawnbqRk14/tUBakXv3OajLf4H0U
 TdCdTL8g4IIdNRz730yjFXTye4L6xdL4PD8xEEpiYk9m5MD+QSYDo/4lJRA4sxDUc6GEK
 fOLIVFRrfpl9y0pv2mGQxXNHP9RVMvyLoWya2frqGYZjIC30NUDKdYDsE/RZTJvSIYjBF
 QFUIpYTafLPexyrapkHRKMj2nt44uD7+6ZqCRex2/OPh6/yU45QuBPhoKM+zoy0xhtyC+
 KoY4i5sZX3THz5DwW5+KdrGCw1LrZprBxihCf7lx5RuSPEMo79HVptrcO8KjBRiUgeg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=makrotopia.org; 
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a07:2ec0:3002::65;
 helo=pidgin.makrotopia.org; envelope-from=daniel@makrotopia.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3CD75605E4
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:05:27 +0000 (UTC)
Received: from local by pidgin.makrotopia.org with esmtpsa
 (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768) (Exim 4.100)
 (envelope-from <daniel@makrotopia.org>) id 1xBLLY-000000001N4-3kNq;
 Tue, 29 Sep 2026 00:05:24 +0000
Date: Tue, 29 Sep 2026 01:05:22 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Tom Rini <trini@konsulko.com>, Daniel Golle <daniel@makrotopia.org>,
 Kyungmin Park <kmpark@infradead.org>,
 Heiko Schocher <hs@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Aristo Chen <aristo.chen@canonical.com>, Anton Ivanov <anton@binarly.io>,
 Weijie Gao <weijie.gao@mediatek.com>,
 u-boot@lists.u-boot-project.org, openwrt-devel@lists.openwrt.org
Subject: [PATCH 05/11] boot: imagemap: do not resize a region the caller owns
Message-ID: <7bbbd8ae1f506f1d50cae0cf224675811d324ff0.1790626459.git.daniel@makrotopia.org>
References: <cover.1790626459.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1790626459.git.daniel@makrotopia.org>
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

The extend path reserves memory at the recorded address and re-reads the
region into it. For a region recorded by imagemap_map_to() that address
belongs to the caller, which asked for the payload to be placed there:
imagemap reserves memory it was never given and overwrites whatever the
caller had put at the destination.

Restrict the extend path to regions allocated from LMB by imagemap
itself. A larger request against a caller-owned region now falls through
to a fresh allocation, leaving the caller's memory untouched.

Fixes: 9b41c7dbee96 ("boot: add imagemap on-demand loading from storage")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 boot/imagemap.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/boot/imagemap.c b/boot/imagemap.c
index 89396a03730..a28c7928e46 100644
--- a/boot/imagemap.c
+++ b/boot/imagemap.c
@@ -233,13 +233,18 @@ void *imagemap_map(struct udevice *dev, loff_t img_offset, ulong size)
 	 */
 	alist_for_each(r, &priv->regions) {
 		if (r->img_offset == base_off && r->size < read_size) {
+			/*
+			 * Only a region this device allocated may be resized;
+			 * one recorded by imagemap_map_to() lives at an address
+			 * the caller chose and owns.
+			 */
+			if (!r->lmb_reserved)
+				break;
+
 			addr = map_to_sysmem(r->ram);
 
-			/* Free old LMB reservation if we own it */
-			if (r->lmb_reserved)
-				lmb_free(addr,
-					 ALIGN(r->size, ARCH_DMA_MINALIGN),
-					 LMB_NONE);
+			lmb_free(addr, ALIGN(r->size, ARCH_DMA_MINALIGN),
+				 LMB_NONE);
 
 			/* Try to re-reserve at the same address with new size */
 			if (lmb_alloc_mem(LMB_MEM_ALLOC_ADDR, 0, &addr,
-- 
2.55.0
