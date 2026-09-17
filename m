Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83F2FC982D1
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 12:51:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 49095407F9;
	Thu, 17 Sep 2026 12:51:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ebgm16x1CRkL; Thu, 17 Sep 2026 12:51:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 7831240808
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789649470;
	b=dlrl4lMoVAXwEn124SqHcutGfCjXyxppZtedRpCjcck4+VdIC54C09vMubshJsWmuHuK
	 MgiXECm9OAGeDlXgQanSshXFSADqsfomaEscv+w0aZ65346lE2BlXfttInDU/tVPxt1dB
	 tNP4++urmucOg64pzE4zuoCMMsx76YhG6xlxm2uSsJ9gPDvtXgYYxuBXA/4aZmhiNRT/u
	 cZjj3jppT0X6+md698ZpZcu2pW+lSmiQe2Dz2hyjZb6mqPk+Cwj0SQPBqDdYCZ2pJ47xt
	 YgVtHM2sVx4djDIrDmKFU2SqdP6GLEyWqWWBXKbAUI0j7umqJHCR/S4DqDN8F04tD7A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789649470;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=iKEddE8mEErDygiEGgLUTBVAW4L71WU57xF8oHMLJB0=;
	b=lBzTZlEyF+DiKWHPTz6xNsS7sCwvwP421zymmnyWFNT8ayv3OVQk1ZXSjQxKd8P1aJkh
	 VTE17+vvl7IJnBSglVbq5fBg/LLOljWwPb0ecK1rgyIWGsM0X4mtCNTqfB6OdfKkpNUml
	 zEq7wiOoJBMeBK/d3Z01z79fEg9Oxv418mKdO8z5Znz9NvKmhHBBFX7RwMBV30vp3EDYz
	 qmZUttvmwBjGo5s6h/Lnw0QVq8o8gkQKfBBaYkszgcBarOXEGv/vj2wE9mBDvu+t2SSMx
	 IEC/bSo6gTkWjOGaM9eGfUphr9cm10zzNvT2NWadhK5nE3tbfE61cto5dgDnsJu8aUg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789649470;
	bh=iKEddE8mEErDygiEGgLUTBVAW4L71WU57xF8oHMLJB0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WS/cefNrCpk3S+GOClZA4VriIZYBTIfKHflRTRVY2Up02Ua1FUoHWrez82V7fqH4e
	 9lxdp19trQrqSfeTMqdxm6cMqWb1HokVaSol+j5TGXo3o2w7rnJ+sRqO/+xQ2E0tr5
	 TuGTU07K88kGL02hl6iVCth/MT3Ka0Fv/DLVSyX8BbVQmQRpffCsoNCmCKazx3kE3r
	 7gwGw8Iq7CnwT5DrCaAGui/obYoFxhNEKNIzSkBOk3Pccu/fMl0Ic53xSxuJle454C
	 C2XYsExUj03188abxQkRKtiS26zKis1MvuYTen70zJc8oEQ2RWdag5NKaX4shyGPag
	 KYgpghworRwmg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7831240808;
	Thu, 17 Sep 2026 12:51:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2EF113AF
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 12:51:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1513840346
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 12:51:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K3JdKCPPwPU5 for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 12:51:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 0E10A4035F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789649465;
 b=NQhOre8byibV2HBaQCqtN7PeTJmVcxhuWFTY+/99WMXH5ssCwme7keKsVeoPb1/nlBGm
 D8jOh+X6WQruU+k5TjrEXhlZZ0ASyzjqATBY3WZ8ZwFp1XK2JyjQe38meKKz98SEXOptm
 7f3jrO9T13R0YwmbhbkfmYzwggMmpblIw0gaku5FMA6diZuqED7kDLXAC0Voco9+KFYHA
 3ozi2PbZ5FGx1Q2MUgZy4Dfov5cW1pKkXb+LRocaN6rQyqfDRlxW0grjlrCzkVlcned1X
 9w6ZOKpLT+JR0n8WbNZFT6T69msZhZbg215ud7HOtubfhotIedpDqLM2S24X34kYyWw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789649465;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=iKEddE8mEErDygiEGgLUTBVAW4L71WU57xF8oHMLJB0=;
 b=iwmV+QhN89xdpW+UpGmq3evo5SBlBJvxS7jysLAh+2f1DLNnAQqLlQHzJCYY0yf4npvs
 fsxdIRfmp50VnnB0vTGcIK1IYrpdAwIKz8G4C2hnY9P+0CEFGZ4TfaITdP+kL00/Tl88w
 X3FLqyXB1rK8Xbp+mQi9WR0XQgOdoHLBxrVD/zgTkeG2T6S8LYFJ6Xcm7El0fwWcLWuEF
 DsIEOqd2KW/S0QdB1rn11GICaCSJWRXRe7kL4UvZ65aHUv7UMq/JQ86hfXC4W5jhOH1wZ
 pWGhRZXM+skM1gTTw3eKkx85JEl+fnu1IXcYE/5dvNDfBNsGdeyME4ShnjraEtONHbw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=bzFt9zAe; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=bzFt9zAe
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0E10A4035F
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 12:51:03 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e6b885ef8so4601895e9.1
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 05:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1789649462; x=1790254262;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iKEddE8mEErDygiEGgLUTBVAW4L71WU57xF8oHMLJB0=;
 b=bzFt9zAeTdObALLZQVGCJ3ZEv55r2j/ut/pB1qYrVTqPsVubcpxFvyHSCOEebtn7lY
 2RoONKypZ3o1/n+eqznvwU5AqhWVMSiHcmg9DpRFBR4ztt9/qczu4n7UZdzuzBcbALB8
 1za06o80oD6L9mJH4CJB2dtDegafrMPcYt7DJ8VVZSMfSXowAUswGXJuDpCPxzos/k2g
 q4Ejt6kXfDY9n7cHVrKaaA6EL7Hi3tPmKCYdR4Wkx34dkI5o31dpruMhfgw23OJOgzic
 NcGpM1CSppuOzD/oSD8raqM1flaqlBCmnFedzHT/Qtoxp0YYm6FzBSMcYEo9eGhr9m5c
 1eSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789649462; x=1790254262;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iKEddE8mEErDygiEGgLUTBVAW4L71WU57xF8oHMLJB0=;
 b=Xg9vF3RTEY9kx4Y3OWHsi5rhhrfnMnAH78OGkrZskn6PGDpD7xd+c8H2M1we0WiFVg
 n+9ZnV3NnogV+KjvBSHndFSUOr04ywehOTBqo1yjsUj9+kaT3oHikUIs635tghizlr51
 x0huYM5rj7gSTyYuhrzM5BCPNHnMDPJ2H/pQIudaKTiWXq/Oz7/JEjEVN1CFYLn/HKly
 6ZXCr/VmDmiE9N34v7l3liBOfX3cVtldeFP4Ru3ZKs6WP3oRBJ1KcQ4DYwN19CFrinyn
 dVL3zfh8fydBBVu7759Qo/aIzhv5zQvbis9BV8TfbXK1GdK6j3QqNB38Qdr6gPXr5AwW
 /WuQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxt/q1Nfch8Abf1Uy0Sjow+u0+Fgfi7CdQqd68PmP86hUugCELaD7N+y7Vb/NRGc1FGoEu2CW4=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lx7kOdekRRqat/Q5e2P0klvIDHcbkxoThpT1vNAhoUlpBfHOHa
 YArXOAQkt7GHkSMgLBkLXrfFY1snQ82Ey81cSTQkl3zZvOcuIGnxkkeAX6i3kfWbdSU=
X-Gm-Gg: AYBFou1VucD/DdRrJRocM7RXvzSgYiEBEZW2VoRnpA7adPBmy4xMVhL+IzrDpsq736T
 TyAwx7LkOMzPQnumlyIvoF8U7yo9HkIYj3gjtSP3KQ+2Ld6FQS2sPoEzGkiObf50wgg23k4lTRp
 9M2csz4wpNZPuSSlg7ygpE6prVz7i/wsTnmY/RggLpJZ/4iljuYeBCZdTDjjzUavY5+Hc+T1s8S
 PCpEYMDXzwNSVUK851s2DGHqN8MZ7NktpULfRIjTZ/h4lmLMBcDmIbg4/fuoBv9kJSXmv+9I4lc
 Kfm7FchPtUv9Hg3afxQOWstYGpTDZNtaZbsExX0dGmd8ZoMeQnvS0YCG07gdFtHTUl+bk0q47vn
 Jf+jX5x4pkWFhro0iJIG4eQLuAYt5JaIKoOlzsuI3TSYqegQ/neGdib1/BO84X3/JoNQJ36E5b2
 pUebic2zRvk0tZrgJ4DM2XsbXHfvS8566GeGpAfdytdGkXsxo7oBISpHAUrr1ytEPIM69sElOMj
 Kw5L2+c7j1m9rG39l9OSgDRR0pp84qfWoX/ttJnhy/RAKs8SQ23OScXYbgbYsTE/wh9d6UmzLQH
 RikNpUD8UINOuyD9Eqe0Pw5cyD1Lov4fvhKPFUELJ/dE+yPHdSaP+Xsdkbbovv5HSg==
X-Received: by 2002:a05:600c:34c2:b0:49d:7f5:4cdd with SMTP id
 5b1f17b1804b1-49eb732f825mr73946935e9.27.1789649461731; 
 Thu, 17 Sep 2026 05:51:01 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbd23f4e6sm88614255e9.8.2026.09.17.05.51.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 05:51:00 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 17 Sep 2026 14:52:06 +0200
Subject: [PATCH 11/11] clk: mediatek: mt8518: merge the clock drivers into
 a single driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-clk-mediatek-cleanups-v1-11-4dccf8ed98fc@baylibre.com>
References: <20260917-clk-mediatek-cleanups-v1-0-4dccf8ed98fc@baylibre.com>
In-Reply-To: <20260917-clk-mediatek-cleanups-v1-0-4dccf8ed98fc@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Chris Chen <chris-qj.chen@mediatek.com>, 
 "irving.ch.lin" <irving-ch.lin@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>
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

The topckgen and topckgen-cg U_BOOT_DRIVER entries only differ by
their of_match table: they share the same probe, ops, private data
and flags. Merge them into a single mt8518-clk driver, the way
clk-mt8366.c already does, so that a new clock block only needs a
new of_match entry.

While at it, fix the indentation of the .priv_auto assignments.

No functional change.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8518.c | 24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8518.c b/drivers/clk/mediatek/clk-mt8518.c
index f2472d039b0..70dc659419c 100644
--- a/drivers/clk/mediatek/clk-mt8518.c
+++ b/drivers/clk/mediatek/clk-mt8518.c
@@ -1533,15 +1533,11 @@ static const struct udevice_id mt8518_apmixed_compat[] = {
 	{ }
 };
 
-static const struct udevice_id mt8518_topckgen_compat[] = {
+static const struct udevice_id mt8518_clk_compat[] = {
 	{
 		.compatible = "mediatek,mt8518-topckgen",
 		.data = (ulong)&mt8518_topckgen_clk_tree,
 	},
-	{ }
-};
-
-static const struct udevice_id mt8518_topckgen_cg_compat[] = {
 	{
 		.compatible = "mediatek,mt8518-topckgen-cg",
 		.data = (ulong)&mt8518_clk_tree,
@@ -1554,25 +1550,15 @@ U_BOOT_DRIVER(mt8518_clk_apmixedsys) = {
 	.id = UCLASS_CLK,
 	.of_match = mt8518_apmixed_compat,
 	.probe = mtk_clk_probe,
-	.priv_auto	= sizeof(struct mtk_clk_priv),
+	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_apmixedsys_ops,
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
-U_BOOT_DRIVER(mt8518_clk_topckgen) = {
-	.name = "mt8518-topckgen",
-	.id = UCLASS_CLK,
-	.of_match = mt8518_topckgen_compat,
-	.probe = mtk_clk_probe,
-	.priv_auto	= sizeof(struct mtk_clk_priv),
-	.ops = &mtk_clk_topckgen_ops,
-	.flags = DM_FLAG_PRE_RELOC,
-};
-
-U_BOOT_DRIVER(mt8518_clk_topckgen_cg) = {
-	.name = "mt8518-topckgen-cg",
+U_BOOT_DRIVER(mt8518_clk) = {
+	.name = "mt8518-clk",
 	.id = UCLASS_CLK,
-	.of_match = mt8518_topckgen_cg_compat,
+	.of_match = mt8518_clk_compat,
 	.probe = mtk_clk_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,

-- 
2.55.0

