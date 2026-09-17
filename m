Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D91C6C88E72
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 12:51:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A09EB608A3;
	Thu, 17 Sep 2026 12:51:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XwpE1FBNLKLp; Thu, 17 Sep 2026 12:51:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D99CE608A4
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789649469;
	b=c9iLvBPCR3z5jlCX9Uij2PrRvnHVQ9klf0zMr+ceM4Nc+z6YDVjeDv6rlVKuln9E4Reh
	 Mo12iLroFk7zd5B3Ygapxqd3k+v1Dozsu46HOf/vYB/pxvCazTv+T7IJlipIca+b/zhII
	 PGVHkNFloo491ofuk94ZefmIwlGk/K3Y7ycndt1SyH8h10CH8iSz0L5BGRJqbsWU9WqT6
	 1FBBM/qGsxsJGPGB0YKBV4O7fqMzjjPv+KpKrnuhTY0GADfocj0Axwoi54RgEFb0gD52U
	 8tIMKw3ezA4wP/B6v8KRr7tWDDgblJw2UY1/mg7GV+uFqnzjm541KkXcYeG6y7zY7sg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789649469;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=oTwwXvoIhclmoVXmdg4UXq691uSCdcFXIbHWyq5aMe8=;
	b=oTFv+WCxysQv+hfzHx3sUAElGuq6eEN7l2hOimjvDwOzBM/S6T7BD0Fyq9W3MhM+W1/p
	 PgPgyYOCRR/ePNF1V8pTOzYvYztxSG1+UZ3U7XgWxmPIoq5wdU/StRfGOVOmWZE6LSihk
	 x0RH+IHfitTnYkKgvwBzqbkR9+eRxL4CvNEVzDQ5TprEPgRu9dudQUR+pwr7T62NMdQPH
	 YBPccO4XjH77SJ1bPGFt58gqYHJthv/5hxBRaCr52urB6lKYeiA+cPeD0lLwoqUQONVJC
	 RBR+D6wPXGnT7xVnHxULO6HbzswSYSYPSjM/F+EZj3yP3pIk2IA7AbjCfpYhjq5WzbA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=L3uyOkwh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789649469;
	bh=oTwwXvoIhclmoVXmdg4UXq691uSCdcFXIbHWyq5aMe8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JrV6ZJNGViCZv8nEjMn4mESpaCpAQKkGphAvwPSrTOt7/V2fYz6rhunvzWNu9eLZ4
	 kA7xu8RTsVtA9UJGwFF9Bk5uZiGvEaWeGLJ9Ar+mJe74dWiYQNcuHzJYoDV0w/ZP5R
	 XvQRafqkrfp153pAk3oxCrqr55Q9PGm9ANbvF5IV0Fmh7SCYPQsCZ8iyH7bT96C4lo
	 K0oYEwAq+olKqZI28Y3UiVrzMs1CA9+9GpiJ4RzWBD1hGJS6Gpul1FtIFq44hA6E/H
	 d7bYe3j6+Muq4X9AGZawAu2w2AgvbI+8nYXOY7EbhhlQ9HSuzM5fkwACWh6dMbw5up
	 PGA02bg6z39rw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D99CE608A4;
	Thu, 17 Sep 2026 12:51:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1C8A837A
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 12:51:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0E8CA60B04
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 12:51:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Vq6aArvJXwoq for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 12:51:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 689AF608A3
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789649462;
 b=KEjNO7AS9JCmzimyaXjsxDrlCGmNambGaPbd15b/xaizqXWmX1KLPAUwOIrRdn1luI2K
 49c5WG17zWhTZxKwkLfueId8GPOUMMrI9v/fLmfksJYPhgU1p+dZG3UB8e06dYm+407FL
 iC9pU3IEL/B7TrFnqiXVPKyf/6cFe+BU1TjwbslLNaWldMM4vOwzGX7BEampX1WwRN88+
 bwHZOrMdlHztyK3u3ASl9tr/DD8iOL31Fkd0O+yzdJWHX7daSXckeWHizTO7SqTOdLh+C
 pWME0YYM3M0v+SvhS6CbFU3LmjRZtD2tHBRGoJhDXTgJng8c3xkBSTJoxyAtFPk0bEw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789649462;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=oTwwXvoIhclmoVXmdg4UXq691uSCdcFXIbHWyq5aMe8=;
 b=nFPhDud7xbq88cWaTmJU4yhyf0Nv5EvheYqNdIdWyOo/VW6wLSe6oQBcDesjg2kLglHv
 yndhIDkBv8lTh4/gDVqSy7FLMl3BlRc79kN2H2clgBJlAvdOIktPW3axvXBiklv0IBAQH
 9CoGGlKF2V3q4NyBBlCSfQrPNQUiGZ2q+FVsdw6SJ65AwLhelAaCOFxY8bdYVBPHZD3uB
 lGImKKUNcHNtk6HxoGFmvRg7wQcbFyIx2MHfM7A7sFW+d5Lvt3m98nDS8nufcOGBZ8QhQ
 XwzpFpoX3SsUiX6D5UX/RQSCSCwYPG/beve69zecoffqNn60m9j0XDw49i2+fN+glsg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=L3uyOkwh; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=L3uyOkwh
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 689AF608A3
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 12:51:02 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e6b885ef8so4601705e9.1
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 05:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1789649460; x=1790254260;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oTwwXvoIhclmoVXmdg4UXq691uSCdcFXIbHWyq5aMe8=;
 b=L3uyOkwhhNTokXDM8edRgRrzJGYtFBWYSSeYRFO23xxxQQ5ijuL/6yEvgmx12Yn9Sl
 eOpXvzZxw96m9i+TZ3EBfXEz3XI3nj1ffozRYKToIJi8VAA2rGODEpSKgm3LjBzuj5wS
 rOd4NdsPGXDulvih1LjUNWLXfrY5mNgQvlkU2ZgEdV4an2U5yUdOstFAdLkDCjl9771D
 6mBos1JvkGqpL6cEq71VzV/MTPxL41nLZFs29Mx3Fijw3DHomS3BbZ8ryEkCmiBzDL5T
 YnIeLkzTaars5Wd9J04KgouK7OYtnbAV/vMplBOgw9kcoDvlh2e/REnMBduVvc8N22ED
 uB5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789649460; x=1790254260;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oTwwXvoIhclmoVXmdg4UXq691uSCdcFXIbHWyq5aMe8=;
 b=ivd2miPrOe3/DrFYPe0oEFvNYUt/K2w3tlXYzbyg/pcRNjMZUGKUTihidtiyRDqg3t
 GkyduRUdN9afKrUyEBGLAUCs/k6xCmYdJHOsit5k0QnnbZcwiRB7l+9uZkou7xNwxGUK
 jxdekfQ6bL+zljaL03Aw+ia8i6FXFtMAGET6tr6yltnSpX7hZnUAiSWs2hBioOarNS+m
 QX9XkrXQ+0I5KzX5Evwit3wc59XC3mdyBAyupODb9xSlvV6v2GvRe040gQBPQoSTiAeJ
 O2R/eXvzdJWTbYi5GW7alwU+N9ch084bs0Gk3dTahXnJZBCZQjFhW8R8Ir8Fn/zS2VfI
 eUWQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwjr4cDcAFs1bIZDSeEldDJ3JxZYU1nh90rLTgFeboVcyWv5Zu0KgUr9VOXio9HLIMASLnyko4=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mGYLeVDSNMwebRahKSS66iZT8OgW9GDT8nK9b4oHxucO1oftSc
 dRJ2m3xranaQs7NG745GqurYrIRMbDC3sRp1J44sDEjWVSodw6a/BSlr/o9zpMQDu+Y=
X-Gm-Gg: AYBFou0gJgNCWu+6yda/hfGsXEqj2jBkaFR0gjW2UR50j3WQYDwjAWWVIPicxhE1emz
 wruyFmnXt2fLebE/uPk7VRUZVW8vSYcvKP9IQqYahnSY0EvGHMy5pz3UapeMSiSXw3N4QpjOz0d
 3Ht6NIPBTCQxVNJeJpTDzPAQSAFgSw4CqEvWG5q0pgoI+V1h1v3B1olgdN6wgqA+MAjClIMKpRm
 sctwN5QUEzRdD61g+CNZVgMOi5xa61jjojhbrqHtApQHEEnIHi7MeErIgjXU71CMZmts2oBXWQ8
 kK367VRQl0s+pMKtldSBrpzek6JVsGFbgYG1Ky8iUPfkEfLl/UnpvJ8iH8F4wSVHGqIOmCOKBZh
 ZQS5m+KeJPLnUJGduuLR6WV6u8ea5dhBKfXRXaEIDQeNZ6XAkCyinX6CoYQqQpLtHSJI4Zn9fKE
 1FzgACXmHS6OLseHK8L8x71PINK+seExem8qIOr0cRrd94NRktC9tV2AycOeVhKsZCDRNrn8kO3
 RpZ3yenjvq44/vctj6JV9C5EjqSpYmj/IFLy8z0t28Fl754nVXWrnZ8AxA6KssP0qtEG2o1kLj+
 LdPYKpkm9K6e75A7SGSFkTMj1+Cm1dyIx8yHSCM9HvMQv17Pjj5W7Qc=
X-Received: by 2002:a05:600c:1986:b0:49e:8184:f619 with SMTP id
 5b1f17b1804b1-49eb732e3bdmr84161895e9.22.1789649460267; 
 Thu, 17 Sep 2026 05:51:00 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbd23f4e6sm88614255e9.8.2026.09.17.05.50.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 05:50:59 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 17 Sep 2026 14:52:05 +0200
Subject: [PATCH 10/11] clk: mediatek: mt8516: merge the clock drivers into
 a single driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-clk-mediatek-cleanups-v1-10-4dccf8ed98fc@baylibre.com>
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
and flags. Merge them into a single mt8516-clk driver, the way
clk-mt8366.c already does, so that a new clock block only needs a
new of_match entry.

While at it, fix the indentation of the .priv_auto assignments.

No functional change.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8516.c | 24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8516.c b/drivers/clk/mediatek/clk-mt8516.c
index 458aad3c5df..068327783c6 100644
--- a/drivers/clk/mediatek/clk-mt8516.c
+++ b/drivers/clk/mediatek/clk-mt8516.c
@@ -777,15 +777,11 @@ static const struct udevice_id mt8516_apmixed_compat[] = {
 	{ }
 };
 
-static const struct udevice_id mt8516_topckgen_compat[] = {
+static const struct udevice_id mt8516_clk_compat[] = {
 	{
 		.compatible = "mediatek,mt8516-topckgen",
 		.data = (ulong)&mt8516_topckgen_clk_tree,
 	},
-	{ }
-};
-
-static const struct udevice_id mt8516_topckgen_cg_compat[] = {
 	{
 		.compatible = "mediatek,mt8516-topckgen-cg",
 		.data = (ulong)&mt8516_clk_tree,
@@ -798,25 +794,15 @@ U_BOOT_DRIVER(mt8516_clk_apmixedsys) = {
 	.id = UCLASS_CLK,
 	.of_match = mt8516_apmixed_compat,
 	.probe = mtk_clk_probe,
-	.priv_auto	= sizeof(struct mtk_clk_priv),
+	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_apmixedsys_ops,
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
-U_BOOT_DRIVER(mt8516_clk_topckgen) = {
-	.name = "mt8516-topckgen",
-	.id = UCLASS_CLK,
-	.of_match = mt8516_topckgen_compat,
-	.probe = mtk_clk_probe,
-	.priv_auto	= sizeof(struct mtk_clk_priv),
-	.ops = &mtk_clk_topckgen_ops,
-	.flags = DM_FLAG_PRE_RELOC,
-};
-
-U_BOOT_DRIVER(mt8516_clk_topckgen_cg) = {
-	.name = "mt8516-topckgen-cg",
+U_BOOT_DRIVER(mt8516_clk) = {
+	.name = "mt8516-clk",
 	.id = UCLASS_CLK,
-	.of_match = mt8516_topckgen_cg_compat,
+	.of_match = mt8516_clk_compat,
 	.probe = mtk_clk_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,

-- 
2.55.0

