Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21E78CA5FA1
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 12:36:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CAFF280E75;
	Tue, 29 Sep 2026 12:36:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MT3kz87aDnFr; Tue, 29 Sep 2026 12:36:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 198B480E2E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790685411;
	b=I4VqLGzc2HeuIWuRvhH+XNmnc0AcXfevUdlzakoXXr1zA/Amo2eWCzJmQwGCjPjzDUDX
	 C/NeSM46YjhvNNvTG+umS/14ylkAWhPXOP7YSecG0MgTgsWIyNk8oIKnXmHT3pEkdyil/
	 0MMgujsAz09MIxr+ZBkQ+sAMnLatyXpP7lVc2vPtoFA5mMeldqFryb7Zniir7rNMVEI6a
	 cn2wt7N33mnZKxRhTEed3r0u5NZK5yu2ICVgguz0PDDpoH+DOXiJwPgvkAZl1lkVwUXqo
	 +V2038M+NVc9WjPKeGh15AlDJM+bUZbgBzORKF8Jcwo6MT3Bw5EeSOstzExIOOPf75w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790685411;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=BiGlSOpBr2uKO4EDnwXzRKbOhTfqkdUw3l7S76tVsmQ=;
	b=cu4Zp+WQIhkHrSpxdiAHPVUvzkE63u5GKdjMlQ9SXIcX4kU2x9SZz35w9WjGT45G1P/n
	 b27mbunKSNDABYhOm3L7mBppNOXFE+t+tul2tBRfLJ8xnJCIYJnPE08mR5sCwUtBHNG7G
	 k/SjfGvnPFBySAviMeRsWNVZlHkSIiXmMRm4ej1orOY3OiVfnws1JPL+elUgStm5PCbhD
	 yBXTJN1Blc0MNQokUrftWdOKGtbQdQwVG0A8uZb18N+u7f2FArwu16l0pVsJGDNj1JZ+v
	 JSKrOXES/WbCr9PiSIZW+VQZiYEx7WwxIcb89e90RQqU9cuLEXf3X9CRnZ1opGoSaMA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790685411;
	bh=BiGlSOpBr2uKO4EDnwXzRKbOhTfqkdUw3l7S76tVsmQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rfXkgt2E7jtlGEKVaqD8IymcFFjhYuNgUgxAc92+X2dCrHFoH83fg2CvjFRhbuL6a
	 lV9+xsDwf4z+k5vPYeS8T3BGi1W0u4YLyP9k6lKUAf/pzBbwWotuyPZtwraWGpye3A
	 kOY41AWRVawDJu2kvVbVPznAgi9xv7Y2Q1mJvoreMPv7rg4SJKw4DnKOSiwyHTSgkj
	 Wnj+43NW3DVtd0+AikQyRahLf6rQKHMCTUlbmxrDRzQvJfD3vsoyfdkGzzl58B/L5Y
	 yYXX+LAMY+RoOiZA8z6AmjUQnDPLx8XKcvCL00WndMBQAAjsLflOYOQfvM989MSn3h
	 2jMgb3i/pe0Yw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 198B480E2E;
	Tue, 29 Sep 2026 12:36:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id C0B67D1
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 12:36:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BD7FD40082
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 12:36:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CpTrqwE-z6kE for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 12:36:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org D980B402DB
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790685398;
 b=NLl9Mq4tZEf6den5DzaBMe1coQZWit1gmgnnd7cUDRPN/73B738gXo49lupgkJwRHd8V
 JaZeXXNCKJstWG11EexD3AZrsmMcNMHGA9vza6/nifkmUOdSDYnPP6pPerxjk2lcXQqDk
 GsUzGKk+bhInA563Gov4cjgUqAT16DQyRNtKPOBViq1/1UNZHiDEBbCxI0yFC767vFaIH
 YBxsygXC7m0M6OOwveHk4FcWxG5ZZBPkoBMEyBmCGsT+6UN9T9fSSOBYlbM1y4FEO+hpA
 Lwm6U+OpLM1ReNjQvWfGuzYl3Sj7LE0Lr8HXnUJSZEJMBg5pySZUXikDAJckS73MLHQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790685398;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=BiGlSOpBr2uKO4EDnwXzRKbOhTfqkdUw3l7S76tVsmQ=;
 b=kFx7FFa7YDNUXip9djXOHkJfP/2X1rCAyip0iXrozctYZy7JMSZ7AA3w9xCKMmQdxNb3
 29dCPKrtmyfMoB1CS3jz+2Ht53v2mYJDhMM/ERt1OBM6POTimxhx8jcfhcH05nIh1V1WA
 ylnGP/leCiqnKCbL236fAgyeZ9YkyjnKShawRZQIzG0jIL4wISnhIYSS0NRochh9MbuQj
 EXDtLDR0Z7HWnl4+vIkYHITmb/JUikoZPpDTJSQoDrI4R7I9ENfVUGZDEFyA/8HMzNKIB
 GBjWo4N9u0xrUNBVJcOL7dpw3I9CnpadVf0B537PimLbRUhFPtlOy2QniMyWmf9xP2g==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=ifvxyqMv; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=ifvxyqMv
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D980B402DB
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 12:36:37 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e6b885ef8so23577125e9.1
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 05:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790685395; x=1791290195;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BiGlSOpBr2uKO4EDnwXzRKbOhTfqkdUw3l7S76tVsmQ=;
 b=ifvxyqMvmCHb0bLRUbuB/3kR+iUN0d8BA7/K4ZryQ4Ow3Q/nCGhn/aSLSA4r/uaHQU
 2WCkZG36DY5uofDlOy2kz5D2X+1iKdQFWFfb1ysC0MJbnXpfwLqKeDFpgQrrwoQDsz6J
 qfwkAft0BvaCJ61StXVutd1uHYYdeFS7STlELMiANuGmWATUCLtNOynDKRLdaGCxdxvK
 ZY3s9qJVclLfyRSQ7utGA+riRvge5S+A+VbKjaA+qp2lUcw8tHklFs0VEhtzfGZiV03p
 c55ms+dt/EuJy5I5yYEcaVRpV9Me1gNSbx7ec7uGH/lxMo6yZZUrQC+q/a22e6DJuaQV
 QjUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790685395; x=1791290195;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BiGlSOpBr2uKO4EDnwXzRKbOhTfqkdUw3l7S76tVsmQ=;
 b=Yph0VKWHi56DeDhgM5eRDEKAIy/BYe/s5ZCuisW3scVGRpdnMS4z661Jjd2JtSb57u
 yVc6T/0lovRYSTEXAJUVnLlgH9TCJJK2OUB3JLcLQBq2zmfTEVCRXCPvVre3KXSkW5U9
 rKo7kisshk6BVeQ+jRj4lJCzYYZSzeqqeNINItwYfErpwzOCr7z5VzNvKieKpWDxa2A+
 EQ0ah0AxYrHYe2Qk+sb6kFe+ExT97MQGRlwpOkcr3EPWrqqfVfsapTs052KkOrthLfjh
 7DaFPD4msY7YUyWyyerdiev+qa5D5VY56PT6Yz5i8HFj4SUhtKLYHL0aPS7QbTTI1O5q
 xRpg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxnl7vmDqHh1hIwRkBflbpZRisZRCM4/z9RAmMlStTZ8mD8YZzmsKvUXaNB/64rZBcbEHM9XDY=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kH6WNi4bXerQc8TzsnV+gnubl4AuOrG2WaUUiIVb2tKJA9dMXV
 lGkxMci9bXQDrXu8tuPsq3ugpv51EQtm/iFViVU6HNRyQKS/sP2hVpHeE5f4qPzuuOU=
X-Gm-Gg: AYBFou0zFEzEhUYOHMDTkNCkqkeRKf0Q8RplQJJKqDNyuYHHgXgbqsd/PYzGrU9MR/p
 4Lh3V0j+f/O16c13hkGMNG5UGLPRcNWR0sCgd7NBzFhdFlCjmdKLm/IVKloD1gJrA+MMBsgzh+B
 3hj2CnOW0FtbMH8Eza9EJpeq3oreuL5Wb8PIuWsoAX9zCSOhslh1VRtCiHiSsCt1is/8dpClm8v
 leyzSnTi4UmpfrxJTVRhAVuDObgSQiOd2Efz/bLWNAaBcTF1h2Zro7KErJu6O+3g7qtFZ1ibO0+
 +1LWSOP9+GV+XhiCJPLb6gWp1+IaIPoKwrPv+rMET6gS4oJCkvWDHURS57FjSsQCE5dW0oN9FfQ
 iOjiI7VFT1AgoOCRfOtdot6gbL81DsfDm3HiTZRyIldLsRPQv/Kyh9WxvbUParrAGtvx+fUbz1L
 K7EWLKsvBR1o2JannCDR4T27MNTMPshXyMIAKGWs+UzBM1KKRCOM7/pbWONDpMwNcGrXWgKGM8V
 r9rIz5g5fGqX4Apo8AAL85RejJ18PDvZbteezwUvLu4AT4t1uGPrWwuGErNXaZP2QXyEXsvGwaM
 +G2UpETPo5SmaX3ZGESe8VbOqOg32MhA4BEqLR+2y1QEqr8GXHGg4nY1
X-Received: by 2002:a05:600c:a08:b0:49e:73e7:888c with SMTP id
 5b1f17b1804b1-49fe66c8a3emr297274585e9.4.1790685395479; 
 Tue, 29 Sep 2026 05:36:35 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a013cfc788sm450305e9.2.2026.09.29.05.36.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 05:36:35 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 29 Sep 2026 14:38:47 +0200
Subject: [PATCH v2 09/11] clk: mediatek: mt8512: merge the clock drivers
 into a single driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-clk-mediatek-cleanups-v2-9-b296bf3a4a93@baylibre.com>
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

The topckgen and gate clock U_BOOT_DRIVER entries only differ by
their of_match table: they share the same probe, ops, private data
and flags. Merge them into a single mt8512-clk driver, the way
clk-mt8366.c already does, so that a new clock block only needs a
new of_match entry.

While at it, fix the indentation of the .priv_auto assignments.

No functional change.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8512.c | 24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8512.c b/drivers/clk/mediatek/clk-mt8512.c
index 6c0bb0944d4..5b7587ee9bf 100644
--- a/drivers/clk/mediatek/clk-mt8512.c
+++ b/drivers/clk/mediatek/clk-mt8512.c
@@ -827,15 +827,11 @@ static const struct udevice_id mt8512_apmixed_compat[] = {
 	{ }
 };
 
-static const struct udevice_id mt8512_topckgen_compat[] = {
+static const struct udevice_id mt8512_clk_compat[] = {
 	{
 		.compatible = "mediatek,mt8512-topckgen",
 		.data = (ulong)&mt8512_topckgen_clk_tree,
 	},
-	{ }
-};
-
-static const struct udevice_id of_match_mt8512_clk_gate[] = {
 	{
 		.compatible = "mediatek,mt8512-topckgen-cg",
 		.data = (ulong)&mt8512_topckgen_cg_tree,
@@ -852,25 +848,15 @@ U_BOOT_DRIVER(mt8512_clk_apmixedsys) = {
 	.id = UCLASS_CLK,
 	.of_match = mt8512_apmixed_compat,
 	.probe = mtk_clk_probe,
-	.priv_auto	= sizeof(struct mtk_clk_priv),
+	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_apmixedsys_ops,
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
-U_BOOT_DRIVER(mt8512_clk_topckgen) = {
-	.name = "mt8512-topckgen",
-	.id = UCLASS_CLK,
-	.of_match = mt8512_topckgen_compat,
-	.probe = mtk_clk_probe,
-	.priv_auto	= sizeof(struct mtk_clk_priv),
-	.ops = &mtk_clk_topckgen_ops,
-	.flags = DM_FLAG_PRE_RELOC,
-};
-
-U_BOOT_DRIVER(mt8512_clk_gate) = {
-	.name = "mt8512-clk-gate",
+U_BOOT_DRIVER(mt8512_clk) = {
+	.name = "mt8512-clk",
 	.id = UCLASS_CLK,
-	.of_match = of_match_mt8512_clk_gate,
+	.of_match = mt8512_clk_compat,
 	.probe = mtk_clk_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,

-- 
2.55.0

