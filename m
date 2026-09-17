Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF868C982CF
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 12:51:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9BF0D60B04;
	Thu, 17 Sep 2026 12:51:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l30478dSH_yn; Thu, 17 Sep 2026 12:51:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org DCFD5608B5
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789649464;
	b=j7tWpCgwtCkrFjMiaGoEnNsyMW77Ihmqmte36+D04jrT3fVzVF4xBuKaxEDWElLDt+Uv
	 YIF070Gr2O/eS60U9UN+X4Nn20r1OW9y9+o4MoGgheZR5jkGrFF6wQQmx1dv9dN2hFETM
	 vcjUTMJrCfZJxiICOx17F0/Ndvh3kbMCOdhMp47EUcesJ2yaB4PBdHywPwQ4XXxmLVqjY
	 /eezVDEnN1Unp/+mIiqV5Vn1lRcPxaA2djilWJt/Uun9H9vkQvTuwEjzcH+EdvPROuQ57
	 jFrNFRsS/0zbsRd/AeVQbL/DHXGkGiNlnfVY4l5wfW4xdWI7JJo/GF+9cJIiUOO8yqQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789649464;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=cJYqsd7WrWYkdFGLZaPOYS18YtWfgcYGWHsanEQDeMM=;
	b=EaMxEqMt9I7AvyXZAOUmnQr7/yT38+Kirn+qoMcVhfF6KdHslTyB0NH3CwoLqM3gmMP5
	 7pXmnnkbyR1wIQU04RLVjsI78PY4OrGc7JiTwxk5GCqoo/wOHKwRZQVynlPChX2umXgf9
	 8rCEPWLts/8SzHv4mibu2iIjWFehNHT1Ow4j4z9DuBFAbZnPDu+Y8kGOPnAWST0k/2Vbu
	 JuVlwgNmLpMQBREATOQDfJQf3lUOmbSahk7gJJcJHEh2MI0JkaUU+XRhCzZdU/mEC9nDM
	 +vJvGu6nN0C9DCp9xmp9POtxhW5VesDHpvLDKSh93SDphlMXGSyvLRjYhLBvPpWss+w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789649464;
	bh=cJYqsd7WrWYkdFGLZaPOYS18YtWfgcYGWHsanEQDeMM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=p2d5EVuyhU7yKyjxDgcOiblImL88KByEcrgpVafNUbZCJMTkVJeifHl+WN78MwmoD
	 dTcW2GZLn2uijzuO4P1fFOy0Y+mDqC3QVXg95cCbo64h+YfWWTJdBi7kE01RnwOwZV
	 ZwMdifMpQmCQwbKIwzwzzmJJ8TWzQtvln7RoqzNHDdZ44O0Y+iD2iqUyMootZVEZRI
	 e8blIQhEhKGMZi+5anjEXrONPRJwU0TAoTuLss5cmTzu/IDf6YssUzRHtbUwFl5Rn+
	 /Tkz6SnukX0oUS6Sbv1gTeJxnwGX4r+j1pacgYI4B96UR9PDv1QlTeNwhUNaVEVYCk
	 e8qF4Jyc2P53g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DCFD5608B5;
	Thu, 17 Sep 2026 12:51:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3BA4929B
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 12:50:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 396EB4035F
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 12:50:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K1KbJ-3ekzQt for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 12:50:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 2CC3540355
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789649458;
 b=RqI0s+kAvObZAiSDWESnANCzdujFB62kBkeh+Sz+RrM0LYX3mZrBpyqNeGjYrXNWc99B
 8cFv5mMflQNESHP/Sgykrcp8c50hoYgUeNuVGCcZlzevitkcYf5ggYqQteqFA1ZOGzXtm
 uLqTPNmv9bXXKfWxqmv8Sxgq+lpZgU5mXqg3cvZ83kZVRqR+wid2jNPtS67PeZ/D5AlTV
 PFaGggiOlD2vUPp5cGUUYq8axABR5d6dvqzFWBaLnO9nIDfGxBQ+cyq5wU8CKU6EQlSaf
 xjXOZ59OZbq343JWdjvPTCw3Z06BRMXRKG2HMDhPOM3J2v/KCLg5gjwpdRM5XcnhcGA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789649458;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=cJYqsd7WrWYkdFGLZaPOYS18YtWfgcYGWHsanEQDeMM=;
 b=qvWr+SDh+qkvsOYw2ktU/lDnVKgBTTRMraL+AJgq0yqunwhpccGQS9WMybAmgnrR+eXq
 hybIs7OjP26col8a5FasYrqEwICbSqSZvymKRwqiosMVVkUcgRVTeEhKyoJjnJxfAauSM
 LM+o2JUya0HRexgonBvjHUk2T2goCVA2X0C19yd9+KbyDG7Y+pcE6FmDnD27sSsjvAcfI
 Xc/CdXP9Dx4Bg4bZ0RooQWQpsdyChnhyGbkwfMcJSO7UgNViuuJwtbVWoKyWGCUlp0Wxz
 ahVM0SW0oFHQwehEoIlUj0MPoVgzzGsgX2hZsLHkZ+G1jnHcdqvezpp+03IUen8XtPg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=myqbDwJf; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=myqbDwJf
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2CC3540355
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 12:50:57 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912d37b5so5055555e9.2
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 05:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1789649456; x=1790254256;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cJYqsd7WrWYkdFGLZaPOYS18YtWfgcYGWHsanEQDeMM=;
 b=myqbDwJfY+6gnOmBZ1kYnlyyUecOAHvYx4F7pnKgyAExyXJLIyao9woTNPoE6bxakl
 ByLnnxacUEPojJSUZyU9zinOVSL1Ui/Ue2334aPQeFQiysAmSyLXX5Erem5x8MG1JL0f
 CZrLv/pd5YxX/tdD2PsmaXewfVTcfBiaXRtSPd+83N9PYq0LlCp0SacF/kOfinC1+Bib
 VsxgEjvIw8dpIhJ4SDwTMOhHms1XEf/2dE87gMZxlXYsobLyueF9mUz9UimWtpGpQts3
 c4H8EAURWtPQ/26br3do1SBqCkJ58xdQwfBvv5AZog8U8iqZcRdfQK6crHbDDXX6SLwJ
 jBfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789649456; x=1790254256;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cJYqsd7WrWYkdFGLZaPOYS18YtWfgcYGWHsanEQDeMM=;
 b=MizRtsonZJKTNYFsJEOjlIdpFaDKhaev2usyr+yG8kapS7T1RKZrozYnnaH8SyLDux
 g2fTtArPDom7V/4Acnq7iwA64XusW1PpUkwmqN1RhfhwVMnXPcDk5nngVaE5D+NkwKkj
 gUMWHDHiHNzQRWVLCfdv5gufZGWSRVcY1iD63IHz+ms/EobBthyZZxx7k40sQLkFmcPX
 zTgkqjdjejaMljfLRJ+UMwFiCElk7fEaHKR78kUBKPVYhXvuupCwVuj3D0edt9ytGO50
 WFnLXfHanX1c/bA7bspi+LHOCM17t8toGeVJTiqJQb1cN8Ot5Mw1THEsJPZ1SL6ByN/A
 G33w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxckGc8T3HrOUcaNBmEGHndLymWkBADHLl1n7c9WoDqZ6AI8BfzsGn2mwJ9oMJ1SFpHoKhYFnA=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kUGvY5F2N8DCOmZnogxcOIMETMe76PwBt1IMipGanq0tiVhhIz
 sDCNW1ijZxLNCLRm2ioA2ari/nNYsu/dBLReFOs9i9WFj2LU7d5ZIKWhs8GATqPoD4c=
X-Gm-Gg: AYBFou168uZKsa1l/bvbTY0gkGOYjg3xIMHMfNJLySfJWFfCeoPDEDQcJ+sFxKobPmp
 w3WQPNtkW2Ef61qV/8OEbyvkHX9avWM8tsFIjtNj2f8Eg+J7XDvejIGVn/xsqZTXvF+IFH7McWw
 GChbaLQfaB5P98o4VpUZN+unolAJHHzcbwdvknyrEqmbWylf1JrlNJvteKmhef6RBq9KhNfsETF
 kDDKftQnuMgvT2EWux3YNgVK8Cqy4ly+Y/RlF5wCyA0+g3sX4yF0CueC22lfPC0QG5eDqRElEym
 wXlv25kkHSxlTQWIcDdL+AWipVkzDcOOT24/tl6WdCxY+aLig6qof0KQWkrpn515l3v3F6ESXWG
 TVPm2TQO1CVBsaYNdSHx08prN23kcjnEWMfD7cu60iOscm0Mi0Rg25lDqP7J+sAUs9grSVXk6+C
 BiLdWLOJ+qbXY7DtGujg+mDHzWrwzHPWN3FAiN30h6bqUF0NvcPFZHGnI2QD/FPSV2/uQ4J7cmY
 rR9UVOap4uv/bDNZrdLEJzlgWCqW89Kyuw6ilU3LFNkxgHErlUGzMX1Lq2c6zlZvtwAbFTcYYxV
 x/oiJh4ql3qYrBWYOCRl4Rtu1/8w58k+imoq3ZXe7YJU8WjP8eXoWzM=
X-Received: by 2002:a05:600c:8b30:b0:49e:823a:9dec with SMTP id
 5b1f17b1804b1-49eac46434fmr165823865e9.3.1789649455693; 
 Thu, 17 Sep 2026 05:50:55 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbd23f4e6sm88614255e9.8.2026.09.17.05.50.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 05:50:54 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 17 Sep 2026 14:52:02 +0200
Subject: [PATCH 07/11] clk: mediatek: mt8195: merge the clock drivers into
 a single driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-clk-mediatek-cleanups-v1-7-4dccf8ed98fc@baylibre.com>
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

The topckgen and infra_ao U_BOOT_DRIVER entries only differ by
their of_match table: they share the same probe, ops, private data
and flags. Merge them into a single mt8195-clk driver, the way
clk-mt8366.c already does, so that a new clock block only needs a
new of_match entry.

No functional change.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8195.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8195.c b/drivers/clk/mediatek/clk-mt8195.c
index fa1480e19bf..a8a4caf0fd6 100644
--- a/drivers/clk/mediatek/clk-mt8195.c
+++ b/drivers/clk/mediatek/clk-mt8195.c
@@ -1606,15 +1606,11 @@ static const struct udevice_id mt8195_apmixed[] = {
 	{ }
 };
 
-static const struct udevice_id mt8195_topckgen_compat[] = {
+static const struct udevice_id mt8195_clk_compat[] = {
 	{
 		.compatible = "mediatek,mt8195-topckgen",
 		.data = (ulong)&mt8195_topckgen_clk_tree,
 	},
-	{ }
-};
-
-static const struct udevice_id of_match_clk_mt8195_infra_ao[] = {
 	{
 		.compatible = "mediatek,mt8195-infracfg_ao",
 		.data = (ulong)&mt8195_infracfg_ao_clk_tree,
@@ -1632,20 +1628,10 @@ U_BOOT_DRIVER(mt8195_clk_apmixedsys) = {
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
-U_BOOT_DRIVER(mt8195_clk_topckgen) = {
-	.name = "mt8195-topckgen",
-	.id = UCLASS_CLK,
-	.of_match = mt8195_topckgen_compat,
-	.probe = mtk_clk_probe,
-	.priv_auto = sizeof(struct mtk_clk_priv),
-	.ops = &mtk_clk_topckgen_ops,
-	.flags = DM_FLAG_PRE_RELOC,
-};
-
-U_BOOT_DRIVER(mt8195_clk_infra_ao) = {
-	.name = "mt8195-infra_ao",
+U_BOOT_DRIVER(mt8195_clk) = {
+	.name = "mt8195-clk",
 	.id = UCLASS_CLK,
-	.of_match = of_match_clk_mt8195_infra_ao,
+	.of_match = mt8195_clk_compat,
 	.probe = mtk_clk_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,

-- 
2.55.0

