Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD504CA5FA5
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 12:36:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4E24A606A8;
	Tue, 29 Sep 2026 12:36:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wVCaIVhi-N77; Tue, 29 Sep 2026 12:36:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 89DC96078C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790685393;
	b=mejbftl0ayUfmJp3OJTO0h5OLQHc2o9pAi0lBTLt5GUvOO1c9lFl7w8L9dAvLujTY5GS
	 OIkF8kO4ep4ICITCzm30phLBo+1hzk63wgXeK5VaU+BL2CwyypeKVOW9DMyPXp+gw4D9O
	 TwmI0JkPCUoWNpZAZV4CLmqaJblbjuRyiOjG3zyd58BcUWh3khfbJWh0WUDP/gteIhtNU
	 Q9Mr8sovK6C9JYtcSQXM4FMBDQ/4iUu+KIHDe6mYDOPanp7Hv7XrDW/UBJMWWl0lZBpEC
	 ptG4sHGYAscL11WF52gLwMJehxX5A7u92ziJqZwdiImRMrXEt6uEyVYPWX28odL/c8g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790685393;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=5s7W06lDGYCwEECvDwbfKLF9TdUfFZQLiXhcG5yS1mI=;
	b=Hzr6aYwkP1zArMk8dP9uGygWAsXa9CaVx/zALDv8jKTONoZ83y5m4laH3UsP7Zs1j/GD
	 14DnSaLB7XOYuZHj0/Kkz2c92x7l8a300uPvkCzkwF91CmWYpbxAHZ1b3N7LKqmQR0JtZ
	 31fDxXJhp0GmFd59HP5XPF8mZyoJtdhePuBJt5KDzqfujZoc+RXIhyuRSKaMIT9Vrw3Xt
	 56Rd+Syp2EsUeAvLua3NqwYAtwsH+Jtz/h1wNK3ucs2opqJSuZS8pzmDN2bJQoj7EOgoz
	 6hh9lCr9a8Dud90sc3XaA8gXpgqxCtTKmMgvlFboUvB8BXWOwiyvgOrksSSkP2iTzWw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790685393;
	bh=5s7W06lDGYCwEECvDwbfKLF9TdUfFZQLiXhcG5yS1mI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uQ5WfeaBJR/8iq6A+6zZeZ97oyr2wgMZjtvo5CCIQeNe9Gke4IyVfu1d6o2qN0Fym
	 mQe1gay7vJL2hH9u+Ae2WuYy1dIPZeOPBxPMD76AxBVhVCwifPn6J8MmrP2DEzbAiJ
	 /9elRyxCmlBGMU/aw28ItUGr2Dnhm1e5IgGPMHXycVVGp4YYGchP7et9JbmssN2UW6
	 l0arcQ1KSf9Ff/412OgfFxTEqr86uCErMwr4KdbChqjxq558ZbbkoYCe7MEv7K11dn
	 JNmpx6Xa4nNacwoXgTNFLmH3NyGq53+nuLdE02GEDPmAZuHHZN0tFbzt/W56DIzKFM
	 3Jg8kpYqVJWNQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 89DC96078C;
	Tue, 29 Sep 2026 12:36:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6BF81335
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 12:36:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5D60380E2E
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 12:36:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RFulml98iWPC for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 12:36:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E20DA80E25
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790685391;
 b=U2JEN17TN64MY8R6lgmiHRSMbLfNywpdD89JkQCxua82yJeqzy9+koFwkUpQNwhfaoaF
 x2d3H9KAGnoxe4RtZPsy3DiBqkREBLlHY4PTcgjG/fmdj3KP4sXD6zCBSDIaIURC7B0NC
 bGgs2t93+9C0yWkcayOlvleY8cQKs+kmfs+dndsvTF8V+ZLIP26GcvE/9MW2YL2M7Hews
 zf3g/ESJY8K5qT/psOC28BtIAb8F1rCmT2rV798/x7hYsFQZKKmaaquhxboBO7f9KfRIS
 wkOIjcV5Bq1yQS0dAdrAfX1qyd0V6khnqZlfn57liXNMD8HRRQUQMCR787/Xcx3j+vg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790685391;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=5s7W06lDGYCwEECvDwbfKLF9TdUfFZQLiXhcG5yS1mI=;
 b=VT/ztZqiZP9pyuWbIQveTsMb9YDoybYJFEcB5aVgQfMYtjKHEnQxmN2HvcoT/zplGnV9
 L/jtTNcw0r+JkKfNQv5VzEwf3wdRTNsJfN+BDiJdyZCS/6nHLA/7dkr14RAekmkdERAmJ
 GrbnpRNCLY4vngQPHHVn+GF061I7+cpJkJ04nMIRVWGas9zcB8h2qXvzEalklOISUTkmF
 1/aqd17LwXCHlc6A/4tf0+zZVcxc1tpMwcgkxc+iBU0yjMWUxsijHQWN8VzONH3n3zkMB
 X1kqozfIgUBPb8oCr/cbEpBkp4UZNhd3rvPU1kNaRObZ5jprF+0Nmj1CKVAqKnqE6dw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=YFEfNCXE; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=YFEfNCXE
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E20DA80E25
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 12:36:30 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e8185e037so23222675e9.3
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 05:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790685388; x=1791290188;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5s7W06lDGYCwEECvDwbfKLF9TdUfFZQLiXhcG5yS1mI=;
 b=YFEfNCXEXEbpxHzj03dX/XaLqxMi+eDi6GttLy45I5QWdYJKsW+Mj3iIe+2xWTrxkO
 vkxyyOQCxCPkwa9wkHua44I4ctf+DeW7vJPrZ1cCwVZElBV8sKwszWv7c3uPlYLMm8bO
 qaNvWzJ+lgRwna9klHOaCb4NyJYJsAXROzdhsm1lo+XEwMHioxwGyrLnN1fTEL3ULEzD
 ZDgoDtOg0d8YpHG4tVcYchEIn+6cf5JwC2DMyegs6p/whecGEjfgntihnn3GFYKcNgWR
 Sh4COLKhlC6OuTAvPEiPo6XdPdB1pi/Q+mDhHaP5lVjhFthuvP0aVcQQfxdBE/YgzNlg
 0yOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790685388; x=1791290188;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5s7W06lDGYCwEECvDwbfKLF9TdUfFZQLiXhcG5yS1mI=;
 b=XrXggVT1mIZHV2p9RN90kFdHdqeG8qcZ/OHU4mTqlE+O6orPd/uCDtQUTSY/CkeIko
 aCcuYISF2gk5IucNef2YAo5+KvBEPOdWJvDash7XfxseVGwi/QuSRGeeBro/NrHrSU5Q
 hpoqEdy/w8Nxr53BYSVHYLcBb2PKl1n0r/m2Im6345s4IDS2fabO9wGD5BIraoWu4CC4
 jSL4wkZXYhVCcWKCsqDvjb9Gs2UHBxZ1skzUkQiuzZ7VccrOPRGsKU8IZ9UZwgJQqcUm
 GFZVYrSpz0PaPygwHs78l/nKyDFXNyDMoEzgm7nnzynFdSYbFYe5UnqRj0j4nB5HSOg2
 jj9A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxmZuLkZCMxrP9zaKPx4udExpuUUyD45WxaHhnMZ/BVbejP4eyt0XMg1wtm3lKv5FkANIpqReM=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mIJoBQgMnFyLbYbILBnRslwmWk+nDosMeJfVVp9Vviwi1kOy5V
 +CVeChhjhc1REBEnO0y/HVWpDR65QG1IjwXajPhfF3FBdjf6MwaQ1PlTrwQ1uhEJTMA=
X-Gm-Gg: AYBFou2COYQeGGaRer1i0uwVdIpmw6BfjcJJPKZpLPjfwEhQadozGdnKn/hMv7E8ESv
 wRhwc0dJru4Xe6bESoiM+ljt8x4oXQlWncnzfr4oVJXljFR4FNvqrHhJPF1oobshi1NlI2Zwbhq
 EItc+g0ukklsAw/qSwr2hU2iiA2PNGKC59zVU8zCf4YjWOeiBCSFqLF6kPw2vv0uRDt0bExeNq5
 SYAMSu06h1BQnjjaVNErYF5ulMdJk2awYmoaL3xZdm2dHFYCLGri1KuneZB0eWSQpCJND+eIgSN
 7Z4rAk1+45EErvNp9ZdDE6Bb9fWbDzRnwBtc/FAjYTLizWoRP/RiAIlczzgFeO8CV4xapcAr3MZ
 tT1l0A84yfDb2FpDAY5Fq7SkLAG1Xm3q38GI8yaUx2oDkGmUEIIU7354kFvaUm7gekP5w70IcHH
 hvnoY2tP60mUFmMnfrSICZMVfCjOaSLW7kM/YTfZDqPIPPw8PIfTARWX7MXSU6UVQSq6WPjnwM2
 cdev+SLocmtgruXH5Nwfad8KvZubhv5jmCrjfMFnKXgwGZx5B13ArxcoE71eh/gJE9ljLXknl7m
 oc/GSE87WBQw5GH3PqKp8GRChfO2n47NGtrf/twf/y6Gv8z3nDqFAnw=
X-Received: by 2002:a05:600d:15a:20b0:49f:f963:7093 with SMTP id
 5b1f17b1804b1-49ff9637122mr124648545e9.23.1790685388454; 
 Tue, 29 Sep 2026 05:36:28 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a013cfc788sm450305e9.2.2026.09.29.05.36.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 05:36:28 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 29 Sep 2026 14:38:39 +0200
Subject: [PATCH v2 01/11] clk: mediatek: mt8188: make the clock trees
 static
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-clk-mediatek-cleanups-v2-1-b296bf3a4a93@baylibre.com>
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

The imp_iic_wrap, vppsys and vdosys clock trees are only referenced by
the of_match table of this file. Make them static.

No functional change.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8188.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8188.c b/drivers/clk/mediatek/clk-mt8188.c
index 0829ebf4f9a..90effc29ab2 100644
--- a/drivers/clk/mediatek/clk-mt8188.c
+++ b/drivers/clk/mediatek/clk-mt8188.c
@@ -1701,21 +1701,21 @@ static const struct mtk_gate imp_iic_wrap_en_clks[] = {
 	GATE_IMP_IIC_WRAP(CLK_IMP_IIC_WRAP_EN_AP_CLOCK_I2C6, CLK_TOP_I2C, 1),
 };
 
-const struct mtk_clk_tree mt8188_imp_iic_wrap_c_clk_tree = {
+static const struct mtk_clk_tree mt8188_imp_iic_wrap_c_clk_tree = {
 	.ext_clk_rates = ext_clock_rates,
 	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 	.gates = imp_iic_wrap_c_clks,
 	.num_gates = ARRAY_SIZE(imp_iic_wrap_c_clks),
 };
 
-const struct mtk_clk_tree mt8188_imp_iic_wrap_w_clk_tree = {
+static const struct mtk_clk_tree mt8188_imp_iic_wrap_w_clk_tree = {
 	.ext_clk_rates = ext_clock_rates,
 	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 	.gates = imp_iic_wrap_w_clks,
 	.num_gates = ARRAY_SIZE(imp_iic_wrap_w_clks),
 };
 
-const struct mtk_clk_tree mt8188_imp_iic_wrap_en_clk_tree = {
+static const struct mtk_clk_tree mt8188_imp_iic_wrap_en_clk_tree = {
 	.ext_clk_rates = ext_clock_rates,
 	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 	.gates = imp_iic_wrap_en_clks,
@@ -2080,28 +2080,28 @@ static const struct mtk_gate vdo1_clks[] = {
 	GATE_VDO1_5(CLK_VDO1_DPI1_HDMI, CLK_TOP_VPP, 0),
 };
 
-const struct mtk_clk_tree mt8188_vpp0_clk_tree = {
+static const struct mtk_clk_tree mt8188_vpp0_clk_tree = {
 	.ext_clk_rates = ext_clock_rates,
 	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 	.gates = vpp0_clks,
 	.num_gates = ARRAY_SIZE(vpp0_clks),
 };
 
-const struct mtk_clk_tree mt8188_vpp1_clk_tree = {
+static const struct mtk_clk_tree mt8188_vpp1_clk_tree = {
 	.ext_clk_rates = ext_clock_rates,
 	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 	.gates = vpp1_clks,
 	.num_gates = ARRAY_SIZE(vpp1_clks),
 };
 
-const struct mtk_clk_tree mt8188_vdo0_clk_tree = {
+static const struct mtk_clk_tree mt8188_vdo0_clk_tree = {
 	.ext_clk_rates = ext_clock_rates,
 	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 	.gates = vdo0_clks,
 	.num_gates = ARRAY_SIZE(vdo0_clks),
 };
 
-const struct mtk_clk_tree mt8188_vdo1_clk_tree = {
+static const struct mtk_clk_tree mt8188_vdo1_clk_tree = {
 	.ext_clk_rates = ext_clock_rates,
 	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 	.gates = vdo1_clks,

-- 
2.55.0

