Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD042CA5FA1
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 12:36:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9186380E91;
	Tue, 29 Sep 2026 12:36:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6szoPCOnlxRn; Tue, 29 Sep 2026 12:36:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org CCBB980E55
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790685417;
	b=Ww9KYuKVrGCJDnXV5rJ8hIVRRloMpeV0L9eFMRmJxVijJtErhE6OW3MNDjtgnAbVgG2w
	 ToCOhqQQaw1dL7VsKwaT+bbiL6iTp7LMYgEK6VUzEjT4xpp/cDGtDGMogVeVp4nTDWfJI
	 FZwlOz1W2O4HfVEjg7a7iQf2FtL87zkd2wNdD8Dbm16PpG5H6v3wuPA4LDku3hYz9sWuL
	 8OQLg2gQ5qf5tz+EzWcPZVVJsTb1jXWHQsV0aBpxriAyDcH0S9No7zdH3iKMHb6tiIldM
	 wfKsXoVTwZvEzihezirrP6uf15Xf5KjLmRIbb2hygXM53udNkuoFr7jtirCPco9KH8g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790685417;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=1Q7FRePBUEfkLCsLKGLFasCLs98WWG7h/XIIpQNG5i8=;
	b=ar93RkocT7twoATCz+PsI0zvRdUGAYtc/bbBXf+n4aJ2tb2h38hfkoflGc7UyKy8L/c2
	 DUI/aDT8DO5vT66neA47NecbRcYCqgMX7WOl8F+nxDE2uVkF5CMaPyp95nwZ+NY477o5d
	 Xw/K9YDt3F3lrzwYF0d36NVV+k0ynHohHRmzeXMldbuzUcgnMdtRb+DsHDAXE7hJZ7DpQ
	 WoYWj/8Rw6+fkMfACR0LUZGf3rGRhI4vxK+rhPO7DegCroOl5PjIwSnmfwIp6TijAziZI
	 CtITB5SYIP41RkrchdX5tGmVC2O2hh2At9Ska4em+1aJDhQIi53UY2Gy/roHh6WKV1w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790685416;
	bh=1Q7FRePBUEfkLCsLKGLFasCLs98WWG7h/XIIpQNG5i8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IS0/Pi/Z61X6DVh3EzZ64CPGk9ds5RAUG2jvrbISYIxg9SDWqlUpvFaojV7kXft/2
	 2EhTHeEKDOQwpUq3eJG/XR0Z0NwlZUzfOZZ1+YkykHQ3wbNrNnA5cwUsGg/x8eKqxW
	 Ow7txLIbw3j5VhkM37efbkOCsCvS2URNdBTuBCpyiOZrdG7zb31ZcjdTA8DuhWkLcw
	 7tmWoT95sLZDahvUiYcMiNaCN2XLht6AkJMiboLJi3Szz0GgQ27F/ZFLsKI1CbkY9U
	 o0hAokl8DP+oUxoUBmKCK0Vk2bTWqBpQYVD/7DVFlEMN2mHn6/GwNjre4GaEJzj+xk
	 4TQNKj5rkTJ7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CCBB980E55;
	Tue, 29 Sep 2026 12:36:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7CCFB335
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 12:36:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 60739402DB
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 12:36:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DYP_vfr2-m6Z for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 12:36:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 6FCD940082
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790685399;
 b=a4DHq/t7u3135N7E0l2cAUkE4Gu8UBASxvF/ZGQMzTNq1xFNM0IAJvSX/UvrkZUV68tk
 AfKImRogaoSG8w4oiNG2eshudRVnud5aSuVBFYpGyfa168V8fjo/BJK6+K+gdO0vYI1gP
 A1j26JJmwRkcCIMFm63hsJv+pIlqkDiUXAsARHUj2jJLf9JkMEb/NwV6yoVcfgWA4s0SH
 wE4Fw+1UCAlt2iMddMWBft8cY7u18Q1pynGlW5BtkNH4Wa3HrBZdxNKRGbaBo1+YZytQ8
 qHazjBH8hlkQqHrytCFNjy0kyU1m92mlrmzv43dYwhH3VV+8J+YokHXwfNmYPMiPOiA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790685399;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=1Q7FRePBUEfkLCsLKGLFasCLs98WWG7h/XIIpQNG5i8=;
 b=oQz3ABKIelG98GeBNvHIZ0fmZOyHtRk19+25UKgrvTjJZZbsP74kZgerP8gNIAJqei2p
 W/HVun2nBKaL1lh7nfJxcAXcK5WzY8sSUBmPe2+t/tfjUOV7WvY0gazupbz5O+RiGJk0o
 zKWVc8pQb3ytnBxg4GyPRiDNoIRMN+OIRYLs5Mh262qBpDjldiZCcCPFog99rHNnC3CMD
 lE5VLKy9T/rw+wij+h45S8LasopHSDK9ACBX9gktZNHC99LSf7QdxtcF62cGzUci9pwwn
 DO1Zm/GpCFjxslVxmU+8K7FMHFn7GypjHI345FXJ7/5Gw+0DclqglEXMlcZE/Q7oeCQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=HCBn2ias; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=HCBn2ias
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6FCD940082
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 12:36:39 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-4a00d8bec5aso5311895e9.2
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 05:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790685397; x=1791290197;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1Q7FRePBUEfkLCsLKGLFasCLs98WWG7h/XIIpQNG5i8=;
 b=HCBn2iasK44T7y3aWRkoYqPBLDCDVeRw6VC6lEEqGY6LDMiZZB5SJOXQMLEp/G6HCV
 E5JpCo38GzKyKq2DwFGfpmMUUy4+Qbj/9X/YLzh1nn0ZovbzrmmYZJibOhG8n/5YMGYI
 Qds1D+2Rk21rVumxIooFU5nhUPAQiyx2u9hdpiFdnl5OlWPXy/r5Z/qiRiZQzzTGlZYs
 ZL4Aaz8g6mk+Igy8ryG1qoIAG5JVokfRWZojM+0cHGAze8ACXxLbUH2pskSGYh1EuRbd
 1TxcDEyo5kKx7hQ7H2ikO3+Mgcl6P7quNwYV0+Y+FQUe5NPfWyq84oj3ldqF0WCWrnRl
 /Llg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790685397; x=1791290197;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1Q7FRePBUEfkLCsLKGLFasCLs98WWG7h/XIIpQNG5i8=;
 b=oLVPrCrXHm6LzxPfbKoMNxT36ygKcTZRy8MIg6+lrKvbNadtG1hnF+AcpHWN6N8c2x
 oLSRn9orV7MZm5zrmnYsBhlkV9ShuHOZR8Lf9V8vSEZWGMXcN5XQNER5E+9fdYm9+q6T
 KrkOn+0aC5MxfOaHAwYjN4MTDmIuTVeoSuj1vjbW7IKJXIcro/JOPHA6frI4mhhZja1x
 rhNm5cvYG0TcItYMcWXqKevX7UF1aux2RYaQe87+MXNib3AEZS2pyNu7pBfUnHNz3Y4h
 g1Mix4AJQAFk859IdTx3M/wqupfo+kYY/QE+5z3fzbA0bsN00oWh3K6flZ3HGO2aJebK
 oKug==
X-Forwarded-Encrypted: i=1;
 AKwUvBzpqVt2XYqOuxp7wfYMXle/Eo+SBosLNumsWX30EeimrkE5EgLK0bu+BEHWLTcFJAFOzdt58D8=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++k+pJkjOrSXm2BJL+jWocnkBNl7RlVguYjdvPrQP1zByliwTza+
 uTAEtGZdt0H1YnaGlJEwtNs17gxpalpvgll1omBsBXJsxxxev9M9TZ2tLfJrha6G5zs=
X-Gm-Gg: AYBFou2hEyT/3rt4xn8KLyyC+C8idoRURgMk3Ze6xNEWdC0mD6n5FQxoRFkiIvqRFCg
 5kAS25hh0g3qAxhITchInE1Z6hI8aOllQdvzraa6FDwGrSyGqtx/joIoHeeFNhy+FxUlhOBIo0L
 dEt5QFSdfzdeYu/WDG2m9bfNU5UodrTqRGk/TaZzbscEm/wz26woSazMbaSVx3vvUCkL+mTyo0y
 hsGF0zlqSj8CTBXLzF5POEjgx9lbDpQzwSLB5lsAzYPUCYKQWGq1b1D2yqqWmxaAEF1d+wCovIM
 lYfcHXCSOrlK+cPn0rPs1Y9eUA2mkvmiXlwJLy/XUNFRGpTpUVsxYy9omqf7fW1LCE6IAbSy0HV
 5budSlX1U1dLaf3fCbbmRpYYLEjgU8ZkX5dvihKndDyDQi0fmNvRFJ1bNjFQOacQfkhKNic+jIg
 2Ez8hd5gRkeVagnxhET57solJVfXn9TAAZldxFBjAbDP+VErPhWfngImOfhuJk0lnLOe33CdU2L
 cEnpsf7L+Wr6IVSdb4Fpxtx5q5wFYlZcBbiTbEbcQq0NBLyZcJz4UnZfAvnatrgvRNFlOluPLBv
 jC2A+UqADars2rMZUpF64sNgRLZ+y+uNlHOVrzY6GyTSJqBh1rLb8Is=
X-Received: by 2002:a05:600c:c16d:b0:49f:cac3:c68a with SMTP id
 5b1f17b1804b1-49fe66f9ff1mr258082165e9.31.1790685397089; 
 Tue, 29 Sep 2026 05:36:37 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a013cfc788sm450305e9.2.2026.09.29.05.36.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 05:36:36 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 29 Sep 2026 14:38:49 +0200
Subject: [PATCH v2 11/11] clk: mediatek: mt8518: merge the clock drivers
 into a single driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-clk-mediatek-cleanups-v2-11-b296bf3a4a93@baylibre.com>
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
index dac5b0a6f62..5972f53c836 100644
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

