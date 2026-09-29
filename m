Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 386BDCA5FA1
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 12:36:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0294B80EA1;
	Tue, 29 Sep 2026 12:36:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GXDQMiPwYDq2; Tue, 29 Sep 2026 12:36:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 393C780E57
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790685405;
	b=QVRY5zH3ETgf6q05BTqwnWvNPujEISud40xfAavTxC+OKXmglCERfObFymb/yS7WQk8b
	 igPc4TTjoGMueayj40EsodMTbyyWxDFsAbxFsPh/umGrAsX/IhjszJMIMgeH5hDJpJW4R
	 GC/sXI63dZfpRscNe8jAg3g6/7QuYxohZ6BeBXH7D1DGTazUCua/6Ob4KcpRewu9WpVko
	 gWGbKaVRThCWIUIWDUN5xXShtNDoOCU2hgnkLrwQ3tAjtl+iivqiPs/Eg1AHCT9tHbDUb
	 03KBGTVo7x2i1y8zMv6I9yB63eqwPaT++NBYQyTwgT8OczOLr/5pmbxn5JAc7l5ZPoA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790685405;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=lsqqwX+MJVe8hR8IPTgdKRYuo3YkvXWerP3zviIJgK4=;
	b=ZYZymyOyO03DuB9MsPnWRk2p3fmpXANaMc/C59AH8vaVzvXzRzEItNr44qPg+i/IT0PM
	 4qJbNIf5wBFZNauOfbddUDuMVyQFKrJbqxOTDWZwjndSPL2NNUlddDM+Vxr682obSmw2C
	 32ZWR0q6JOvungm76/70Qj3XcVpyY5va7M7nG4yx0ubINPcqzNlwIKTYvazqWqqhPszFq
	 j6GBruI3DNtRFM1x86EJwe1lMO6un75FkJTXI1zSOHnYxoMkeEPYsG6aTWIBnmxHKu9RF
	 rCjbJcWcmd+T/cS8GOI7S3CFrc5h8Y1+D1wH4lTwwa85JoY/KlKpRj2r51fk7SIYRuw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=NWZ1obQa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790685405;
	bh=lsqqwX+MJVe8hR8IPTgdKRYuo3YkvXWerP3zviIJgK4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I1GvS7FXMOte3pqlpJVjoqYyS0OeCq5bdsue2WyhCQFbyQeYsXR/Fkc7kSpVQaXRu
	 DB2dt4aKWEazOFJOseOEBdeUKfCphhbgQ7MVdxB5LNdvh86SaYpLMGM0xIgW9XtzPm
	 A2J5dAcweMtMJdcL748qDSf+u4n+B65awRcDcRHET/ruhhMBlUNocgrgnd/GOLK9hu
	 vqsVI0pG97lbjqZE2IR8YdQcdyiMkxWFsuIJ5jBbo935RllQSd/0Lsw4fHxevN8vfD
	 QkgAmG/QF/245kJ5AKz1/U2itEShTd7YVM2w9X4X97f38QsiDiHKGZwXXcdIbMBO3E
	 6yRsjHA+hSPjg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 393C780E57;
	Tue, 29 Sep 2026 12:36:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D04B732F
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 12:36:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B641480E44
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 12:36:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0NEBp0j8s_Yd for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 12:36:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org D81BD80E32
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790685396;
 b=miASDna8yAZ6ihZ3znU8H5uwcid2gFT4K3G4nOXeA0HMoIxQHvSNmfnwussGPi/SwQrq
 2YN4+k0GV9DYTvJjHqmavr1hZAamRDcwQpXiBLDVgDKK/HEUKqNEw1rT3sE3DeWE3GTJG
 FYsVkJ64oQS2ynGIAyqE1xlx4D/d4RhKJJ943198FcwNYTZGoXe4iXBK/L5w9t9m5P7eR
 IXMijej62qZi5x+yaHa3KLFgLnndh1uLtQeVjnHxGUoSafggKNbHxviaV8qPvzkMLYEj3
 G1PZeCyvej1ANScr4NH5v+n0ghxuxRZhmxvIkF0oHCfvNj9R5t9YFbg1sYq+pouQ/TA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790685396;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=lsqqwX+MJVe8hR8IPTgdKRYuo3YkvXWerP3zviIJgK4=;
 b=kZJW4QIjm2Zet6qoozNOQTdqwnXYO4KeTaJBgHwYATiBav5tZ35GFPUWu6M5Fs7WXKIh
 Y3ltkHGDMPzGeSwJVUc9pchFKC+kAmfJ4+789SyNGZi14QFWjkVlA0nF0FnvmuKXwjbqC
 BOfhn0Vid6s3gnegzIkPyd2HviEDntudpP/Iknfc7Bxgwn+n4Ou6B2WMaTt0qM0gi48/d
 eN3IjHmvoVeWf5Y6kZ085v8Jw49Wb1MnyayXp5wo2isIlLSGu950+7GQ98b511N9uPNFa
 PKRNDQJJRAZiT4bWQ7ib2kgCipCvXe/5PxcC7mWkHcYEtTyyzVteTlwGBH4PuHFEfIw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=NWZ1obQa; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=NWZ1obQa
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D81BD80E32
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 12:36:33 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49ff9621c5dso21837085e9.0
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 05:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790685392; x=1791290192;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lsqqwX+MJVe8hR8IPTgdKRYuo3YkvXWerP3zviIJgK4=;
 b=NWZ1obQa6wyxdxm4gcIu0B4JSejuVtE+pXNFk8Go24WVjDFOzALyUeCCFUUBcjwaap
 wWLRwflBl6J2lJ3WKnjg3zB0m0f3Q+YoJPu6buhaqDgmqbfvCftPSqa98k3niUiwbZo1
 /EZGSaeq3V2jmD6vRH+gLHrwcjxehrAJwz9Zs487gt058U2hy+xrhSrfqVHsQvVc6Mrw
 IMDATSrTzFm9FCF/hhCqBdmdZwO6kb7qQtPOHuRXbwOLs2AubWsIWgldVdTQkt0hbbiJ
 FdDTAUlFABzeXJ3RyzPFXkJ5tlH0gUQn8C8dlCNjGYEbHHcDtWJW3vJOvvuHV1NfMepa
 13ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790685392; x=1791290192;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lsqqwX+MJVe8hR8IPTgdKRYuo3YkvXWerP3zviIJgK4=;
 b=eOnfh/9egLvHM/w2D6NcHJ+d0xehYhcke0VeNizXta0fogCoJlXpL0cOK+Z6DFUnI/
 2RFiaLeTbW/vTeUPTSKALEPLTJTEC/AcbJP0LlNGIhlm4ip+1qgxEdMhWBIYjSlzUkJK
 0EpMFob8uQifT1syGGXKDgFDnd+fSgDrob8Mv6EvGnZ7tLpS4YAOnhi3L+qFMjFOarpD
 SrU6OQ760UjdHgB3fOrTi4RkS9UwoKBfc2c8NvedusZBkGzo+aeVnDJbTd3J6KDe9w0R
 lbDs6lPCBsxwal1Q7MqsfrApBHNR4WS5rLviqQagOGvt6OrllqzNVROFoUWAHU4hgg0Y
 U/Dg==
X-Forwarded-Encrypted: i=1;
 AKwUvBx2wZs4ddx/grj3ywTxmJHmW1WXzJnc4kj5WlYsg10NwgJBTGwizuqa2kTBRt+qObS38QW455A=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nDyIYNJRHVFd68zf+UE+5FZctcu9BhK+AxJ/meG6w4hjTvghvv
 BiVU7TDw7R6s0CYgI1ep14nHsPoOw4W4NRJXJ44SvOv+NiXX6oD/OZrMlnY1igCSlk0=
X-Gm-Gg: AYBFou1biY7MCJsfGL2MMaUNh7cOFalQaEquzksJT+8Eea16OrWjdY2cIGfzPh4hAxY
 b7zt/yZ9TqlvmRw7twK/y6UQDjcYDliLzf1IBYwIRRjbOq4V5xcF6F4KeXkkTlnmVDm5snnc4k6
 GO9Zp6YoMj/dHG0z1JszU0jOlVeUcIsCoIONRXtcqppeLOT0WXrO1mHnR/rIa/OMsEzR65FACua
 SMQ9acgZVVOFxycyirBatB6s3jYqklgLoICnEmKjyoax8/+sM3ms4KBEQbuBkECbn2OGisblsfE
 uvAnmDiPDgBNQYzX4dFHviDcNa7G3x2TYZ6mH3nDi33PuXOjfE3Y0QWOnli7OMGvbcWwSk+nQea
 k2NJtN7ZlDkJM8u/eUWdrJsJqvwx3yvgNNwiTYshVh5YubilY/CBJTbo4unTGkJbKZFYVsf/Gtl
 q7uFYmtA5qBgJSBVQZPCuz80GvhMEwqa+JfvwHaW+bcvApUzkYoU3oeO4LSxbmIIsTXHfxeuNM5
 KU90KbnfFftVaKDPKJ5XdnmpNQz7UNh/ROXF+Lggduu1sqsg4a7P7rZ3gfFnFQFWKWltg87V/wc
 bkDMnTREgL/QtjvJNhRXLA/pir1QzfuTplXl39peSEx3OakzRUF/MRg=
X-Received: by 2002:a05:600c:8b6e:b0:49c:fc6e:8cbb with SMTP id
 5b1f17b1804b1-49fe66f9fe3mr283764385e9.31.1790685391979; 
 Tue, 29 Sep 2026 05:36:31 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a013cfc788sm450305e9.2.2026.09.29.05.36.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 05:36:31 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 29 Sep 2026 14:38:43 +0200
Subject: [PATCH v2 05/11] clk: mediatek: mt8188: merge the clock drivers
 into a single driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-clk-mediatek-cleanups-v2-5-b296bf3a4a93@baylibre.com>
References: <20260929-clk-mediatek-cleanups-v2-0-b296bf3a4a93@baylibre.com>
In-Reply-To: <20260929-clk-mediatek-cleanups-v2-0-b296bf3a4a93@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Chris Chen <chris-qj.chen@mediatek.com>, 
 "irving.ch.lin" <irving-ch.lin@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>
X-Mailer: b4 0.15.2
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

The topckgen and generic clock U_BOOT_DRIVER entries only differ by
their of_match table: they share the same probe, ops, private data
and flags. Merge them into a single mt8188-clk driver, the way
clk-mt8366.c already does, so that a new clock block only needs a
new of_match entry.

No functional change.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8188.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8188.c b/drivers/clk/mediatek/clk-mt8188.c
index ef7a7fea79e..1294990de61 100644
--- a/drivers/clk/mediatek/clk-mt8188.c
+++ b/drivers/clk/mediatek/clk-mt8188.c
@@ -2071,15 +2071,11 @@ static const struct udevice_id mt8188_apmixed_compat[] = {
 	{ }
 };
 
-static const struct udevice_id mt8188_topckgen_compat[] = {
+static const struct udevice_id mt8188_clk_compat[] = {
 	{
 		.compatible = "mediatek,mt8188-topckgen",
 		.data = (ulong)&mt8188_topckgen_clk_tree,
 	},
-	{ }
-};
-
-static const struct udevice_id of_match_mt8188_clk[] = {
 	{
 		.compatible = "mediatek,mt8188-infracfg-ao",
 		.data = (ulong)&mt8188_infracfg_ao_clk_tree,
@@ -2129,20 +2125,10 @@ U_BOOT_DRIVER(mt8188_clk_apmixedsys) = {
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
-U_BOOT_DRIVER(mt8188_clk_topckgen) = {
-	.name = "mt8188-topckgen",
-	.id = UCLASS_CLK,
-	.of_match = mt8188_topckgen_compat,
-	.probe = mtk_clk_probe,
-	.priv_auto = sizeof(struct mtk_clk_priv),
-	.ops = &mtk_clk_topckgen_ops,
-	.flags = DM_FLAG_PRE_RELOC,
-};
-
 U_BOOT_DRIVER(mt8188_clk) = {
 	.name = "mt8188-clk",
 	.id = UCLASS_CLK,
-	.of_match = of_match_mt8188_clk,
+	.of_match = mt8188_clk_compat,
 	.probe = mtk_clk_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,

-- 
2.55.0

