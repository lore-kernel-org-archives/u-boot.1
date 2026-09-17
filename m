Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 891D8C88E72
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 12:51:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4EF9A40809;
	Thu, 17 Sep 2026 12:51:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mX3ukRo5Mdnk; Thu, 17 Sep 2026 12:51:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 8861C40805
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789649465;
	b=kV/Gcj0F+lER4fmAAeEZb9UTsBSDo/wNd7nnLoZEofO5gBiC4Zdw3E3KACljBIM2vc/1
	 2YFbk2zcdXKqwXidsis4/u0qoipEQFP7zBGB+20jh19jcNbZG1I6Kcdod9Y8iG7IhP6W/
	 opshyrpGQcHTOxAASl+Z+wCiz4Cy6z7cCoenmtfCjo9VerZeznQqfm126rBqUl7ai2ynA
	 i96O3sv8kIyDdPmDNR1IXLe56hzaiKHhJEuCA26P3J93iw4yX4LCVyTn9/Wern4lyp5P/
	 of/QV5Gubd4touyDqqwf1BUz+3mwVr1lk0uacwR49rUPOV9b6xRgK3hnKKqm/Mai9pQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789649465;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=J7nda8Z9ePUU5I5sJvCXxaNrGD1U89Tk9QVm75VKF34=;
	b=DIUFcSYXV5+kw977F2KcC4EmAOedqxa7Fyb2Gw8ADSKfR68F/vnvPLr/csDhUV2xEvAy
	 Kz7mzHRdxjKQtdvV1cfBVHPyPomd5IpTByrsC6geD7KoM6cY+4ii8c6nrnO6bzXWEIrsb
	 QCRCywY9yoFgeEPdwBtN1UupP5xzar62gquZk26SVshrAfo4dnbGzpfA8QTiO69g0Xatg
	 bpwwjgd1VR/XXgpm4LX98DkkKIv1QZ+lhci0H3C4pmpJlG42u1NK7L9ijBuqWs2/hgWk/
	 vgb2L2YG7KbxRz161ftBMXKDoz7U48M1GjV3f7VK1pIbQoTUj3azP9g6s57aFlFavxA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789649465;
	bh=J7nda8Z9ePUU5I5sJvCXxaNrGD1U89Tk9QVm75VKF34=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XSG5k0iOFs8U1DoUJBtSmd23YOSUxrh8lOTzTei4qvb7zbf1tn7J5wqvnwnacjnYC
	 LdBG5Zma43ESuuN7YnRF8VLOjpHBLih//lEJLKFoeAlamzKhNgheu/6uA9fJQM777T
	 Wui6yato5QLGlX+BUuyUq+X2atA0HdCeJhgCTuGCt8BicCMbS6ENuj5CTxZJI37Ini
	 2ZQevLfMmVN31/ucPtPGAn6CaMPMLl0g3DA3LADYD0+9mhzXeKe3cg0C53xQUPPjE6
	 f5akOiHPhq1pFQo7o1qcscwkdfbPqqHbtQ4ca35qHm3drQp6W7d0+FnsdxmAJsJgic
	 VCb9hj3UWhjmw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8861C40805;
	Thu, 17 Sep 2026 12:51:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4D5C337A
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 12:51:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3EA8180FA2
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 12:51:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GMeAmVEf1cjv for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 12:51:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 06F1880FFA
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789649460;
 b=iVr1EE+R96O3iF/dcrT9PedapZSmDtYKHDko6KqNIAnKgSwrqGUZJwYi6eZqwHMj1Vq+
 H4zisoRkJIQE23gU2HEN+rasS6Kq4wI/b86QK3HCIT3BQF+oMCvcrkFEZhEc2Q07ADdPL
 R7jYSieDwegL8xHnP7Qrb2dUJSCw4NKfy3LCpvBxTm3XWuhYMGOw6HzRCbaQEImUpf3oC
 OMeZpUsXtW5KwEs5RcrXuPhNYwxPeA0JqFot/z/t1+liUK5n8nSZh9x6B0iIVmiD3YZ2B
 jKabENuTuFzo1Ypa9lHU7fUdKe9mIU/5IM+5lM2UlEaiB/k14RDoXmlHyCorm0krbAg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789649460;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=J7nda8Z9ePUU5I5sJvCXxaNrGD1U89Tk9QVm75VKF34=;
 b=judQBj+pok9belvwrGn4v2u+0wOwCocUT/wZaVSNfpYdAXsFbpncWQ8NU2T0BXknbbDR
 ItXkLrhIx+QyD2HZtKgLukr7+3UYkfDtmV5VBXEdZJLxKdXQgH11ysRgJp/7wmU9hFiYd
 TVnRjp0nnQatrg7clJ3SQ3VLUskBqgPAzl27vZymvfjIOt6c4Ga52MgS7/4hZMlWrDjcG
 Rog3zY49byqJF88Z4h5BbVlAwpej7/tfd6T6B+k+JwD4nJCsuFMrEPT1NNgVeMaxUYicl
 liJFoHOX6GisHXty8Omp6tjB0bSxN4xcQ7fVSF5TLq/Nv0GqRQlxUIfaKOdbEL0F94A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=l7HWs1wM; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=l7HWs1wM
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 06F1880FFA
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 12:50:59 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912df756so5803725e9.3
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 05:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1789649457; x=1790254257;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=J7nda8Z9ePUU5I5sJvCXxaNrGD1U89Tk9QVm75VKF34=;
 b=l7HWs1wMsQ8WXKiEKxN49VNGZoGzkufIYj3W0WEB6CEa7CqzbHDMwCIUdsf8GEPqp+
 YMLv61T9h+LmpW1rofZyjgYQZChFX4lZssBY74HLXffoZVPFSKU+EJ4vAP4RK4ty3T2J
 H0SbHFKB8a8hxZc8x6N0cq3WJFGBgxMZb5XzGa3yGVRhU3KyXvjyBXSqSOAxjgiL88sH
 P6g1RLV8rRxXlT1S1EQouA/TqudBZnxo3upx5cYZtIWzrtBc14SkpS0DqBmpjZERWzFx
 wRbH5KCnZgsmKiqoaKys2zb17dIUKxs7Ho/95U6DL88+M3or0SrCsSm1GlAs0C1D8JAw
 HP0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789649457; x=1790254257;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=J7nda8Z9ePUU5I5sJvCXxaNrGD1U89Tk9QVm75VKF34=;
 b=PnTRDfUt+s0VJMZKceRys2yI8SChxBiYR5HqwHdkRSV6AQ+m5yaSoO8xAM2z0Xj5w4
 et5r5j0NnRcAgSADahYtviUkS86qpAq4Ob70hsZ+WA5wxqNc1XR/aNCqCNLz0YYyYdtf
 6mUTri9KcUPu+WMLCtXptWKYMAxnquNuAatT19jwRs3FlQELleqXg/YIJz/fwQ/T7LCP
 It1aUPH71ib1v2dJ33A7qCl1ComBnvfDkYncyuFtFixKZ6xsCcCXf4uFMmBhq5DugMkf
 zuV28fPV7UU8nloOorHuRGo2n11Byn26ZkJtzO9K+ENdsmXsns38uYdqkXF9jtdYu8T3
 IpyQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy4+sV3lwcCI+EwXo8SNDhvH6xsarJr3s2iivry+IEB7V2YzQJcLrozZ0w82Sah0DIu7+MBMTs=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++m7XOfPRXiyTmVZ/JMaJ9EIUdsH7wiwA3TwbX5VA19/g+w71P7I
 98WWSYNs4yceOccSxap45W/KQt1liJSq2dlh6qG6efsIahVDcF5FvZ2ZxvYwDuCqtHA=
X-Gm-Gg: AYBFou0sJrBy0ifU17C+dZoRIi88QPTCjK0ybo6tKQyQv7mgf0DhlQMIaEsA0APYoz5
 BAPuou5ayODWAoof4YfB3Gr2tpXnu9SdN/hPoR5efh5WKrSq8cTix/rVfsDmX2Mk+Xt2/tRxIea
 2Ym6UY8hhCNdd5vKb/lorZzNhkDgHjHEcrgVd4vavwRxAyCQFgBX0LD/0Tdi3HUwhqC3xkq8DvH
 1EE1mhBAMYzDxLq1xD7fcheTo1GAr9Rwx41CSOiUQPF1cQ7vDbspW3iNJArZ71VUpwQB54hfBID
 ad4rsqUK/gw+RbytYCmWIXRLbZ2/egapiSeORt8KRkxxkF4SagL65f15BvuHFC1Bh4W0fqWMx++
 PEKAoZxUpfSEly07PUgzOsUeaAjt4I0vL5knuXJ16dw0UxGZqwIYVZO08Zng1UZUb9X1Ri2vyit
 IB8tzKid66GWSVROscIZflKhSaRzg3UmSzlXZRaL5Uc69ppeoVQFHXb+x8EMcixMU6N7g51csdL
 WX0W6sU1LCr5NImyvVP2zVhNXt/n7KRy9mgp80MVjs5eQBKbW2izR26Y3Hyz7NciRXNv0WvCRqN
 XvLYICTguznY9EIJ3CRE1BSge3xBRZ/VqavzfQ3pztRi3mIr8zvaHiDsIJaNsRwuITA=
X-Received: by 2002:a05:600c:698c:b0:49e:79c5:ee93 with SMTP id
 5b1f17b1804b1-49eb731eccbmr73972705e9.8.1789649457265; 
 Thu, 17 Sep 2026 05:50:57 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbd23f4e6sm88614255e9.8.2026.09.17.05.50.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 05:50:56 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 17 Sep 2026 14:52:03 +0200
Subject: [PATCH 08/11] clk: mediatek: mt8365: merge the clock drivers into
 a single driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-clk-mediatek-cleanups-v1-8-4dccf8ed98fc@baylibre.com>
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

The topckgen and infracfg U_BOOT_DRIVER entries only differ by
their of_match table: they share the same probe, ops, private data
and flags. Merge them into a single mt8365-clk driver, the way
clk-mt8366.c already does, so that a new clock block only needs a
new of_match entry.

No functional change.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8365.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8365.c b/drivers/clk/mediatek/clk-mt8365.c
index 872de82d6f3..0d74561ace0 100644
--- a/drivers/clk/mediatek/clk-mt8365.c
+++ b/drivers/clk/mediatek/clk-mt8365.c
@@ -764,15 +764,11 @@ static const struct udevice_id mt8365_apmixed_compat[] = {
 	{ }
 };
 
-static const struct udevice_id mt8365_topckgen_compat[] = {
+static const struct udevice_id mt8365_clk_compat[] = {
 	{
 		.compatible = "mediatek,mt8365-topckgen",
 		.data = (ulong)&mt8365_topckgen_tree,
 	},
-	{ }
-};
-
-static const struct udevice_id mt8365_infracfg_compat[] = {
 	{
 		.compatible = "mediatek,mt8365-infracfg",
 		.data = (ulong)&mt8365_infracfg_tree,
@@ -790,20 +786,10 @@ U_BOOT_DRIVER(mt8365_clk_apmixedsys) = {
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
-U_BOOT_DRIVER(mt8365_clk_topckgen) = {
-	.name = "mt8365-topckgen",
-	.id = UCLASS_CLK,
-	.of_match = mt8365_topckgen_compat,
-	.probe = mtk_clk_probe,
-	.priv_auto = sizeof(struct mtk_clk_priv),
-	.ops = &mtk_clk_topckgen_ops,
-	.flags = DM_FLAG_PRE_RELOC,
-};
-
-U_BOOT_DRIVER(mt8365_clk_infracfg) = {
-	.name = "mt8365-infracfg",
+U_BOOT_DRIVER(mt8365_clk) = {
+	.name = "mt8365-clk",
 	.id = UCLASS_CLK,
-	.of_match = mt8365_infracfg_compat,
+	.of_match = mt8365_clk_compat,
 	.probe = mtk_clk_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,

-- 
2.55.0

