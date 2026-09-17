Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2FB8C88E72
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 12:50:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 955AB608E7;
	Thu, 17 Sep 2026 12:50:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vANPv0_-6o9S; Thu, 17 Sep 2026 12:50:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C51A2608B5
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789649458;
	b=TzEa8A2yHevDByp0R1y/yJAmIaeG+c6CwhOPyNzi/8h7U78vbCKZnO/9c/G+K/0vuRWe
	 jH2GL+sLpgEV8norLGf/G8Mv4+SuTs+0dMiOjy53iJqWOcNbAlvYDloZA+Xl8s/faEGe4
	 RZNH1sVeHHzbobch1DS/KW7dBAHFJv/kbYmuGu5ghRh0WK1NRzpPhjiSWLLCK9l7F9EWt
	 4Z+Ceqrv4/d/+UXHmofkEdfqxrxte37UijB/mRRg4R7OdfUbcwp52/dz+bkToUzgMwO7q
	 jfN6tiwpZTxoF90Oi4BZWNIMblY7xiQWrJ2I5kglxY2K6zztxbRZ0zZmNDOW9tHKPMg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789649458;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=TvJzuxJZZ3hgMVC5k3xiLuSKN1w586mPLJlcg7aOOm8=;
	b=e//qlLd6ROfFhpYT9CZcx+w7QG2fVLIwEN2N2ETLFcKpETqmGLdHBVPVGLCmOGocNqeM
	 4BDu8+Qpv2SjYHK/oSU1sXn19MiqORqxAueIASoK5+QtsMLYyauNX1zA+VIdLkuN8bvbK
	 LPwT6uVob8MVYJAw7pZGrLRuRsctXs+OsyUnWm2xOZjop5j7W3XsCOze0T9cdX1/RiGgp
	 crGRmjkZKuw5rsQVwhDIBjV92ttL67c7SF9iZwP92Dbt1jXsBGmnBP2NgB6g9XQFEqL3G
	 oCrwhRf4z4QS8yzslbMq6174/0G3yygj5+zNouZFxfgLf+5C2AW7s1BakX+1BxGU3IQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=LZfN0hCo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789649458;
	bh=TvJzuxJZZ3hgMVC5k3xiLuSKN1w586mPLJlcg7aOOm8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cdNVy/8ql46utgy3e+TGZWyO3rlvHWig8b//jQYvi4o1eYNr6yR7xpnelLqrPbJ0V
	 Pk4GfHjgaqHUByqPuZSqAz6mYlRAHkh77poJV+plKl9U3zGy/nh5S7cBd1DtJjoGDF
	 iL7esF+hFoB38FMPD7Be1ZzkTKq1VTz3bhvO8eCzILv8bvaWmk4FhYXLlCM2HQNLFS
	 KXPKMAvsdf+84+Bp4IsR4qVZNcUAq050bjVpZ17ZMC3QbNrSZXnDRPwCQIH2fYGiEC
	 6TTk7gPgi1pfAeF/lMVuDjdZBKqbfauqShTdXd/z3uKZPLVIk98TMJtv73m9Fc+NwG
	 zxu3m8wF+V2Hg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C51A2608B5;
	Thu, 17 Sep 2026 12:50:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id AB56629B
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 12:50:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9AB3E608A5
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 12:50:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yS5r6Vatrn1s for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 12:50:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8D5EC608A3
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789649454;
 b=s6OsoSd4+FC6Xd1DupJpMJZi/7BkgNEF0y8dg4FR8aUTXLyvOvbevFkoz6T9d215B0bh
 WQQ4OvmURU3LGR2yGgNy2p8ie56Ar8CJ6jKO480J8XYbkSMKmcgfGypwu+J97RAyEVAaG
 jTWl6UZkkR/zdk2p+9SK4h0ryFZ8ULDNRufUbNYyBoenk3NegP1dZMc8JZk7DyF6KmgF+
 uEks/jSYwwOBLen6hqT8b2v0i1n15EfoiqYwEHlwFTTP9CowGH8y/B/RKd5nkpfwAOrnD
 gFtM1larmh1F/ImElj7eh0RrFrI2CQ+NlyPaZogO75pAjonGZ/Q/BHrTglNJYXq6XHw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789649454;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=TvJzuxJZZ3hgMVC5k3xiLuSKN1w586mPLJlcg7aOOm8=;
 b=ba5AWitC3tRMQ5oFq26S2CaS94eOKGk5WPJZbtFOhicXKFmhSWQQX7IQmKI6sUI44/Re
 sQEK+GbcNP2nattyBhtuazt0S0WvqWBkl+qi9WlC+0SscODvDTtZQSofSwKflpZewLB+W
 +56xC9ULRl8Gcr+IQ/hv8mPgE/sabUowdV9JdtkSYEn7XDe369z2ZuTYaxqCPJTy/DTbJ
 E3Gw27v9DWhcru7FWPZXaNwOtyKRSKhcIYRZP7tbHU1OYy5hFgR6IpbjLNAHL4aAXkY3M
 /qr0VXb/DhLqGTyO7CJeLZa9TJ1AiDmfAk7cBFrzEreIoIJdYleWUNdtea4+glss+sA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=LZfN0hCo; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=LZfN0hCo
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8D5EC608A3
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 12:50:53 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49ce364488dso2116805e9.0
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 05:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1789649451; x=1790254251;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TvJzuxJZZ3hgMVC5k3xiLuSKN1w586mPLJlcg7aOOm8=;
 b=LZfN0hCohBBulHZx30b0SkWWQm7rxZRukHt8VSPzPa4BJ8BnRZpYEerrQMt5bYLG9Z
 jvVxF5D3IDMGkc+fOAJAZAFFtaqlGTf5YvY0BS5ggzDPsbz8SWn9xM9M4KtsMHEJda7S
 zJKFm7xv3+P8EFij8tEI/qv3PxNbp3CmbCSNZW9ykjJWdAi+jbEypcRGMi6lP6QJMK0w
 m8IdBQzfApgslyVFm+Vw0YFYcZLscqQ9PZeqsmEGaZjWfcqqQtfpxHmIo2JVh9+bbXQX
 ed6q7NmQ/2OpPhQS9UsAl3beOGccDk0krqUL1+hLE9GmcDbwlR+5YFslykvqiKUOLLa0
 ZLhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789649451; x=1790254251;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TvJzuxJZZ3hgMVC5k3xiLuSKN1w586mPLJlcg7aOOm8=;
 b=hWtfiWEgB2dwuCoAYQ8r55q1r+trgEdUBK9DPWolOsQODgKwnk1yStCE9vk1wEvi74
 a5aNbN9iLXYa4iFwXOKZ36itCKGWfGu9Kuk4RHm3ZvIxfzANMQfOB0HZn45O604tziP+
 gx2MSf5H96szH9Zgw49Bo1n3Gy+vD/zvd1GchRHF/us1iBhnJAKleRYz/PZmVXgcH9W5
 ZgEICzEi5+wQQLcmWVfuncu70Dzey2i5Ke+bsSF0z5ssak1RAqeVf0Wrl5vxozJBzzyd
 yYQZLV/wsFRuXHMK3wKIx8SX8XifnXSA5RFrU+gqqg6xESY1sLcdpfQghVJnMyO5hR1B
 QEIg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzPJz2y/fJzSf1FRvSXOL7gcM7XuR9X8EYVfM3sJwGf69jNEXYFRGGyCk267OxgZ2rbD6nLeIQ=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++k8Gnxli8HlhnQ75poZ8ddBvaKoFXXHzijwMHaAiRXmXgwI2AAJ
 DD/8xDKkYJ3NifXd6zFxNgHGs9t0gVKujI0aCBMpAo/oUaFruAayhkFbnCDI4fpxuPQ=
X-Gm-Gg: AYBFou1apWtqaXXPxN4SN/xLa2dcBIFRbL8Epd+q183BPxGtFt4Ok0CoxjsO2C565r/
 wowdNoMr3hmi6u4HiwNUMVccrNkp6lGxd34+0T/TK5YMOxAQfdy0poD9ITp67Ky0x3qcLaZEBhZ
 bPd2v4fvJU8Mkhju0PPB1bLms+MjNK0kFBz1F516pMRk2DdIUWOyRfhL5P5qyieHa8uPMLcMzSB
 CCjXi3FTIsBte9PgASU3kpSM97SqkyzIRtG+ZaJtYnG60FqmCEJXkIUStBPSu/1THp+4Q9bfgw8
 LJGWvSlFkUHCWkSOS+xcoS/M3Y3xe/iCLhxK6h6BFWef/u1ms0m3UBUzuFLnZmW5vYzdwHyZmx/
 VKPXBNDoQ9+YbR7Wx4+hh40zyKYqAZ6eKVf1+NOoJNEKlBm9q3mMa6yT8Uye1EjBNIIeCimF07p
 PBsJBFhYUVIiQHIdFfBr/VAHhW+X2eHcA47wJ1AMA/J0utVKJMhbhpfr4mhlVhUb3QCMdE0GP5I
 Hk+FH53bkXzsWTt4VeW1eFE3Qx0BmSmO3mztsCGvRKrAcf5n7c4S6C+CJWDMcg6oDgE+mggOCmj
 Cz6eFDxz1vxvSEPWOgL31TYYTtjPIlAm7LODIdaIDs4USkWbZdj1AF8=
X-Received: by 2002:a05:600d:849b:10b0:49e:6581:7baf with SMTP id
 5b1f17b1804b1-49fbd1af3c8mr32719375e9.2.1789649451376; 
 Thu, 17 Sep 2026 05:50:51 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbd23f4e6sm88614255e9.8.2026.09.17.05.50.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 05:50:50 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 17 Sep 2026 14:51:59 +0200
Subject: [PATCH 04/11] clk: mediatek: mt8183: merge the clock drivers into
 a single driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-clk-mediatek-cleanups-v1-4-4dccf8ed98fc@baylibre.com>
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
and flags. Merge them into a single mt8183-clk driver, the way
clk-mt8366.c already does, so that a new clock block only needs a
new of_match entry.

No functional change.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8183.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk-mt8183.c
index 13fee7a75a0..08e06c60f68 100644
--- a/drivers/clk/mediatek/clk-mt8183.c
+++ b/drivers/clk/mediatek/clk-mt8183.c
@@ -797,15 +797,11 @@ static const struct udevice_id mt8183_apmixed_compat[] = {
 	{ }
 };
 
-static const struct udevice_id mt8183_topckgen_compat[] = {
+static const struct udevice_id mt8183_clk_compat[] = {
 	{
 		.compatible = "mediatek,mt8183-topckgen",
 		.data = (ulong)&mt8183_topckgen_clk_tree,
 	},
-	{ }
-};
-
-static const struct udevice_id mt8183_infracfg_compat[] = {
 	{
 		.compatible = "mediatek,mt8183-infracfg",
 		.data = (ulong)&mt8183_infracfg_tree,
@@ -823,20 +819,10 @@ U_BOOT_DRIVER(mt8183_clk_apmixedsys) = {
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
-U_BOOT_DRIVER(mt8183_clk_topckgen) = {
-	.name = "mt8183-topckgen",
-	.id = UCLASS_CLK,
-	.of_match = mt8183_topckgen_compat,
-	.probe = mtk_clk_probe,
-	.priv_auto = sizeof(struct mtk_clk_priv),
-	.ops = &mtk_clk_topckgen_ops,
-	.flags = DM_FLAG_PRE_RELOC,
-};
-
-U_BOOT_DRIVER(mt8183_clk_infracfg) = {
-	.name = "mt8183-infracfg",
+U_BOOT_DRIVER(mt8183_clk) = {
+	.name = "mt8183-clk",
 	.id = UCLASS_CLK,
-	.of_match = mt8183_infracfg_compat,
+	.of_match = mt8183_clk_compat,
 	.probe = mtk_clk_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,

-- 
2.55.0

