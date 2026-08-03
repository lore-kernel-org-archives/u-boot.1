Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32088C55184
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 23:21:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E948480B99;
	Mon,  3 Aug 2026 23:21:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hRrJQBEaRQiQ; Mon,  3 Aug 2026 23:21:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E0A7980B92
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785799296;
	bh=g513syghKrDoDzC68tm9Pj1GjzrwUDo2qe8w3wN9B3E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FOCixku2XrzS3gWD7cbyUDBBnnMISwidAgDEn5ot1gqP8+5BUu7P48YPtcU16JFbG
	 TNYE+2s472Up+w1Qv9oeX7RVUiJ4yWSTxz5hDbpg3qoTlCQPPJ0kgjrT4udUucupMU
	 B9XhvgBW84M7JCHcZOy94Py/ir3pD0549qQCNA6XXnDzmAR87WKrsnDy8Kjo89byQA
	 xuZsxUXIz1G9YH8vqgkT57yp6VayX7rNQxgwNto2bZE+gQK83zaisrYZeBfZnReHmQ
	 m4pdDeICHILEvijsPv8HlpIVZaB77IHpBuTyEuf4NheUJdRKXUTvvGRFXEKUEFFWxo
	 JofJFzTcAtJCw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E0A7980B92;
	Mon,  3 Aug 2026 23:21:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id B47AE3A6
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 23:21:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9A033400DA
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 23:21:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id twOCoqbwmc-i for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 23:21:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c36; helo=mail-oo1-xc36.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 7B186400B4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7B186400B4
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7B186400B4
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 23:21:33 +0000 (UTC)
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-6ab04bbcc8fso2032595eaf.1
 for <u-boot@lists.u-boot-project.org>; Mon, 03 Aug 2026 16:21:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785799292; x=1786404092;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=g513syghKrDoDzC68tm9Pj1GjzrwUDo2qe8w3wN9B3E=;
 b=QbZh+kKQJsSFjbywOJ0EWLXO2gegU+6eRj+HvStUkN2/Y9nfcNNwD1UgJBGS0r1n/8
 KeKVdXFZC67+wtpO1q+cYrfTvLELX94eLTQmKqdZlmYQZ2INCtS3KEou8H7jUknJEyX5
 9sTLO85anucQULwPkJOZ2wYPpzjpM/bUBH33QTubsY1dlIXUJeumGBVHBHP/Cr5BcGPX
 7joH8aqLzf1GKwlcrg24GImNEXPVwGKxInXWIocc1E43OCaOyM42eOUWhbH++KwlJbAl
 4wB4gS31/KlZsXW7Cm4OUjoF/XlcH5oIRggRfeFLkxfBB89gHMRsVEUYYbcJDcnZd2GQ
 lCog==
X-Gm-Message-State: AOJu0Yzv3afj7GABD+0cMXPUAaII3hdTBTnZaH7NpmGwgRHppq/2VO19
 m6+g491DkHoOEB70MSsUsgCLz/hb6R3Nw6n2fXxgSoUewIYS3qi0Dqq4HzFsNnyqKL4=
X-Gm-Gg: AR+sD11EcT1aV3m2amO/SSkzXVeGkaEkFAZLpk15/TbuPgU7vsMXBMdCDrNvUxCOhUo
 blNCnimVOrmAIdTzkWYdCxGWq57BAH1EbwQsYNTbNGMjeysE3nVgW835Vr/ZE879UUst412VLUI
 qn711V2d2M4f1R7pktdAhOMopCg04TrGI7mBs7yuq2HQ0K4jU5Rv9yB2uFNpVd6hO1/TileJH4n
 /j0KLzCL6lV3Kn+AA7V77/utAXFulNHWCpJ4hLwGysDTDggTqbmkzd2B54at38QASBMi149g+1T
 rgc+9cf2VWALjg2uIIK7sUja+V6ZyZL+jcN+Qb8848IIkeCxhjDrSDXQ9+EBhURBjniYjjRyYmv
 D4388pQSwZ2Oy3hyfAASOxueSVnbYwUtZkr2ndpTA5IHcfmViqE0EwSS6YVBsCESKBz/S9gNS2m
 UYZuC5wl6n3rMIno7IXLK/uVGk4s2ygzEO7hYYaUvSZwz5pYu7Mw2lo2v6uLP0qIQ=
X-Received: by 2002:a05:6820:2227:b0:6ae:8823:273f with SMTP id
 006d021491bc7-6ae882331aemr107078eaf.18.1785799292247; 
 Mon, 03 Aug 2026 16:21:32 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:b8f7:1f5e:7c:a7d1])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-458f60df63fsm9440852fac.6.2026.08.03.16.21.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 16:21:30 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 03 Aug 2026 18:20:40 -0500
Subject: [PATCH 1/6] dt-bindings: clock: add MT8366 clock header
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-mtk-genio-360-bringup-v1-1-606ee60755b5@baylibre.com>
References: <20260803-mtk-genio-360-bringup-v1-0-606ee60755b5@baylibre.com>
In-Reply-To: <20260803-mtk-genio-360-bringup-v1-0-606ee60755b5@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>, 
 Irving-CH Lin <irving-ch.lin@mediatek.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=13443;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=9ibaMnpPyP1Jh0CVRffUuUI91ISnJZ6GVfh5ikyr0KE=;
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqcSJQ1Rs9XF0Tf3LLh0btV6l4LsLLp85bbOxYF
 PN3bDxCG6GJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCanEiUBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/Ac1EH/11yrtVxFjS0HzI8+tYLh7rmLOKHU7FTme+rusa
 GKZtmTcoPqbV4NmE4KdJ3V4DvN+t4BFmokJPVusNtaYd4SxEk0oyp1L5ROx6Cs4lf2HGj7pPOC3
 jtXf1umCOV03H23ykxit/6C8r4RF/QliXV45IfqRBQmJg1WupWXvAc87foGn+1340YFLaBFJyqf
 lC3FOWoGUxFJf/L0ufv1hmuHpuMAimZkynqqUe9W+Ae5D8k9sehsY++W3fWcQrnHg65SyToXN2T
 vnPFNGCLBRXBCUS9do6E/B9rG+CyI73brrtk2WBaWPI1ZKRb91aLNmJwbW9sdprXAtMPy9x7QC5
 f2x4=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785799292; x=1786404092;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=g513syghKrDoDzC68tm9Pj1GjzrwUDo2qe8w3wN9B3E=;
 b=oYwYobGGXpfcETKKRt6YQtl1fM55hz7iFBYd0NLSqSzkFX5KgJcjTov1nvZORBeN2s
 b9bJXd0jy7G4pWi3uRLgQixvFGVyxb3frbIwbwqRWn28iGphC5kpLt8HFFeojT2LZ2UO
 Ot5ZHKxeSRL1hksDqaZNgDqdCi8aIQkhOtOZN+HtzOxFCgHokStNr6j9EDzcnohGlE4k
 dX7C7te/0SkCAzpG/4avocV7jJ2Wk+nM3RqMCnLLYKdEYgmaBOvtE03aTDhbUE5eS32M
 es1RhaemvFUcKJ7iSCFy3guxEYMFL3jN+TWI0ru2VskUNFlQSLadFqsDskkJnfIlxaon
 T01Q==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=oYwYobGG
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Irving-CH Lin <irving-ch.lin@mediatek.com>

Add a header with MT8366 clock definitions for use in devicetrees.

Upstreaming of MT8366 has not even started yet, so we will have to
carry a downstream version of this for some time.

Signed-off-by: Irving-CH Lin <irving-ch.lin@mediatek.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 include/dt-bindings/clock/mt8366-clk.h | 342 +++++++++++++++++++++++++++++++++
 1 file changed, 342 insertions(+)

diff --git a/include/dt-bindings/clock/mt8366-clk.h b/include/dt-bindings/clock/mt8366-clk.h
new file mode 100644
index 00000000000..501b65ce69d
--- /dev/null
+++ b/include/dt-bindings/clock/mt8366-clk.h
@@ -0,0 +1,342 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)  */
+/*
+ * Copyright (c) 2026 MediaTek Inc.
+ * Author: Irving-CH Lin <irving-ch.lin@mediatek.com>
+ */
+
+#ifndef _DT_BINDINGS_CLK_MT8366_H
+#define _DT_BINDINGS_CLK_MT8366_H
+
+/* APMIXEDSYS */
+#define CLK_APMIXED_MAINPLL				0
+#define CLK_APMIXED_UNIVPLL				1
+#define CLK_APMIXED_MMPLL				2
+#define CLK_APMIXED_TVDPLL1				3
+#define CLK_APMIXED_TVDPLL2				4
+#define CLK_APMIXED_MSDCPLL				5
+#define CLK_APMIXED_CANPLL				6
+#define CLK_APMIXED_EMIPLL				7
+#define CLK_APMIXED_ETHPLL				8
+#define CLK_APMIXED_APLL1				9
+#define CLK_APMIXED_APLL2				10
+
+/* TOPCKGEN */
+#define CLK_TOP_MAINPLL_D4				0
+#define CLK_TOP_MAINPLL_D4_D2				1
+#define CLK_TOP_MAINPLL_D4_D4				2
+#define CLK_TOP_MAINPLL_D4_D8				3
+#define CLK_TOP_MAINPLL_D5				4
+#define CLK_TOP_MAINPLL_D5_D2				5
+#define CLK_TOP_MAINPLL_D6				6
+#define CLK_TOP_MAINPLL_D6_D2				7
+#define CLK_TOP_MAINPLL_D6_D4				8
+#define CLK_TOP_MAINPLL_D7_D2				9
+#define CLK_TOP_MAINPLL_D7_D4				10
+#define CLK_TOP_MAINPLL_D7_D8				11
+#define CLK_TOP_UNIVPLL_D4				12
+#define CLK_TOP_UNIVPLL_D4_D2				13
+#define CLK_TOP_UNIVPLL_D4_D4				14
+#define CLK_TOP_UNIVPLL_D4_D8				15
+#define CLK_TOP_UNIVPLL_D5_D2				16
+#define CLK_TOP_UNIVPLL_D5_D4				17
+#define CLK_TOP_UNIVPLL_D5_D8				18
+#define CLK_TOP_UNIVPLL_D6				19
+#define CLK_TOP_UNIVPLL_D6_D2				20
+#define CLK_TOP_UNIVPLL_D6_D4				21
+#define CLK_TOP_UNIVPLL_D6_D8				22
+#define CLK_TOP_UNIVPLL_D7_D3				23
+#define CLK_TOP_UNIVPLL_192M_D4				24
+#define CLK_TOP_MMPLL_D4_D4				25
+#define CLK_TOP_MMPLL_D5				26
+#define CLK_TOP_MMPLL_D5_D2				27
+#define CLK_TOP_MMPLL_D6_D2				28
+#define CLK_TOP_MMPLL_D7				29
+#define CLK_TOP_TVDPLL1_D2				30
+#define CLK_TOP_TVDPLL1_D4				31
+#define CLK_TOP_TVDPLL1_D8				32
+#define CLK_TOP_TVDPLL1_D16				33
+#define CLK_TOP_TVDPLL2_D4				34
+#define CLK_TOP_TVDPLL2_D8				35
+#define CLK_TOP_MSDCPLL_D2				36
+#define CLK_TOP_CANPLL_D5				37
+#define CLK_TOP_CANPLL_D10				38
+#define CLK_TOP_CANPLL_D20				39
+#define CLK_TOP_CANPLL_D25				40
+#define CLK_TOP_ETHPLL_D2				41
+#define CLK_TOP_ETHPLL_D8				42
+#define CLK_TOP_ETHPLL_D10				43
+#define CLK_TOP_APLL1_D3				44
+#define CLK_TOP_APLL2_D3				45
+#define CLK_TOP_OSC_D2					46
+#define CLK_TOP_OSC_D4					47
+#define CLK_TOP_OSC_D8					48
+#define CLK_TOP_OSC_D10					49
+#define CLK_TOP_OSC_D16					50
+#define CLK_TOP_AXI_SEL					51
+#define CLK_TOP_DISP_SEL				52
+#define CLK_TOP_EPD_SEL					53
+#define CLK_TOP_DP_SEL					54
+#define CLK_TOP_SPI0_SEL				55
+#define CLK_TOP_SPI1_SEL				56
+#define CLK_TOP_SPI2_SEL				57
+#define CLK_TOP_SPI3_SEL				58
+#define CLK_TOP_SPI4_SEL				59
+#define CLK_TOP_SPI5_SEL				60
+#define CLK_TOP_I2CP_SEL				61
+#define CLK_TOP_I2C_SEL					62
+#define CLK_TOP_PWM_SEL					63
+#define CLK_TOP_AES_MSDCFBE_SEL				64
+#define CLK_TOP_MSDC50_0_SEL				65
+#define CLK_TOP_MSDC30_1_SEL				66
+#define CLK_TOP_MSDC30_2_SEL				67
+#define CLK_TOP_MSDC50_0_HCLK_SEL			68
+#define CLK_TOP_MSDC30_1_HCLK_SEL			69
+#define CLK_TOP_MSDC30_2_HCLK_SEL			70
+#define CLK_TOP_MCUPM_SEL				71
+#define CLK_TOP_DSI_OCC_SEL				72
+#define CLK_TOP_KP_IRQ_GEN_SEL				73
+#define CLK_TOP_NFI_BCLK_SEL				74
+#define CLK_TOP_SFLASH_SEL				75
+#define CLK_TOP_EMI_SEL					76
+#define CLK_TOP_MAC_TL_SEL				77
+#define CLK_TOP_SNPS_ETH_250M_SEL			78
+#define CLK_TOP_SNPS_ETH_62P4M_PTP_SEL			79
+#define CLK_TOP_SNPS_ETH_50M_RMII_SEL			80
+#define CLK_TOP_LVDSTX_CLKDIG_CTS_SEL			81
+#define CLK_TOP_VPLL_DPIX_SEL				82
+#define CLK_TOP_EPD_DPI_SEL				83
+#define CLK_TOP_ECC_SEL					84
+#define CLK_TOP_GCPU_SEL				85
+#define CLK_TOP_USB_TOP_P0_SEL				86
+#define CLK_TOP_USB_XHCI_P0_SEL				87
+#define CLK_TOP_USB_TOP_P1_SEL				88
+#define CLK_TOP_USB_XHCI_P1_SEL				89
+#define CLK_TOP_USB_TOP_P2_SEL				90
+#define CLK_TOP_USB_XHCI_P2_SEL				91
+#define CLK_TOP_PWRAP_ULPOSC_SEL			92
+#define CLK_TOP_CAN0_SEL				93
+#define CLK_TOP_DISP_PWM_SEL				94
+#define CLK_TOP_F26M_CK_EN				95
+#define CLK_TOP_USB_F26M_CK_EN				96
+#define CLK_TOP_USB2_PHY_REFCK_P0_EN			97
+#define CLK_TOP_USB2_PHY_REFCK_P1_EN			98
+#define CLK_TOP_USB2_PHY_REFCK_P2_EN			99
+#define CLK_TOP_USB2_26M_CK_P0_EN			100
+#define CLK_TOP_USB2_26M_CK_P1_EN			101
+#define CLK_TOP_USB2_26M_CK_P2_EN			102
+#define CLK_TOP_FMCNT_P0_EN				103
+#define CLK_TOP_FMCNT_P1_EN				104
+#define CLK_TOP_FMCNT_P2_EN				105
+
+/* INFRACFG_AO_REG */
+#define CLK_INFRACFG_AO_REGP_UART0			0
+#define CLK_INFRACFG_AO_REGP_UART1			1
+#define CLK_INFRACFG_AO_REGP_UART2			2
+#define CLK_INFRACFG_AO_REGP_UART3			3
+#define CLK_INFRACFG_AO_REGP_DISP_PWM0			4
+#define CLK_INFRACFG_AO_REGP_DISP_PWM1			5
+#define CLK_INFRACFG_AO_REGP_SPI0_B			6
+#define CLK_INFRACFG_AO_REGP_SPI1_B			7
+#define CLK_INFRACFG_AO_REGP_SPI2_B			8
+#define CLK_INFRACFG_AO_REGP_SPI3_B			9
+#define CLK_INFRACFG_AO_REGP_SPI4_B			10
+#define CLK_INFRACFG_AO_REGP_SPI5_B			11
+#define CLK_INFRACFG_AO_REGP_SPI0_H			12
+#define CLK_INFRACFG_AO_REGP_SPI1_H			13
+#define CLK_INFRACFG_AO_REGP_SPI2_H			14
+#define CLK_INFRACFG_AO_REGP_SPI3_H			15
+#define CLK_INFRACFG_AO_REGP_SPI4_H			16
+#define CLK_INFRACFG_AO_REGP_SPI5_H			17
+#define CLK_INFRACFG_AO_REGP_AXI			18
+#define CLK_INFRACFG_AO_REGP_AHB			19
+#define CLK_INFRACFG_AO_REGP_TL				20
+#define CLK_INFRACFG_AO_REGP_REF			21
+#define CLK_INFRACFG_AO_REGP_DMA_B			22
+#define CLK_INFRACFG_AO_REGP_SSUSB0_PIPE		23
+#define CLK_INFRACFG_AO_REGP_SSUSB0_REF			24
+#define CLK_INFRACFG_AO_REGP_SSUSB0_FRMCNT		25
+#define CLK_INFRACFG_AO_REGP_SSUSB0_UTMI		26
+#define CLK_INFRACFG_AO_REGP_SSUSB0_SYS			27
+#define CLK_INFRACFG_AO_REGP_SSUSB0_XCHI		28
+#define CLK_INFRACFG_AO_REGP_SSUSB0_F			29
+#define CLK_INFRACFG_AO_REGP_SSUSB0_H			30
+#define CLK_INFRACFG_AO_REGP_SSUSB1_REF			31
+#define CLK_INFRACFG_AO_REGP_SSUSB1_FRMCNT		32
+#define CLK_INFRACFG_AO_REGP_SSUSB1_UTMI		33
+#define CLK_INFRACFG_AO_REGP_SSUSB1_SYS			34
+#define CLK_INFRACFG_AO_REGP_SSUSB1_XCHI		35
+#define CLK_INFRACFG_AO_REGP_SSUSB1_F			36
+#define CLK_INFRACFG_AO_REGP_SSUSB1_H			37
+#define CLK_INFRACFG_AO_REGP_SSUSB2_REF			38
+#define CLK_INFRACFG_AO_REGP_SSUSB2_FRMCNT		39
+#define CLK_INFRACFG_AO_REGP_SSUSB2_UTMI		40
+#define CLK_INFRACFG_AO_REGP_SSUSB2_SYS			41
+#define CLK_INFRACFG_AO_REGP_SSUSB2_XCHI		42
+#define CLK_INFRACFG_AO_REGP_SSUSB2_F			43
+#define CLK_INFRACFG_AO_REGP_SSUSB2_H			44
+#define CLK_INFRACFG_AO_REG_PMIC_TMR			45
+#define CLK_INFRACFG_AO_REG_PMIC_AP			46
+#define CLK_INFRACFG_AO_REG_SEJ				47
+#define CLK_INFRACFG_AO_REG_MCUPM			48
+#define CLK_INFRACFG_AO_REG_GCE				49
+#define CLK_INFRACFG_AO_REG_GCE2			50
+#define CLK_INFRACFG_AO_REG_PWM_H			51
+#define CLK_INFRACFG_AO_REG_PWM1			52
+#define CLK_INFRACFG_AO_REG_PWM2			53
+#define CLK_INFRACFG_AO_REG_PWM3			54
+#define CLK_INFRACFG_AO_REG_PWM4			55
+#define CLK_INFRACFG_AO_REG_PWM				56
+#define CLK_INFRACFG_AO_REG_GCE_26M			57
+#define CLK_INFRACFG_AO_REG_CQ_DMA_FPC			58
+#define CLK_INFRACFG_AO_REG_BTIF			59
+#define CLK_INFRACFG_AO_REG_SPI0			60
+#define CLK_INFRACFG_AO_REG_AUXADC			61
+#define CLK_INFRACFG_AO_REG_CPUM			62
+#define CLK_INFRACFG_AO_REG_CCIF1_AP			63
+#define CLK_INFRACFG_AO_REG_CCIF1_MD			64
+#define CLK_INFRACFG_AO_REG_AUXADC_MD			65
+#define CLK_INFRACFG_AO_REG_TL_26M			66
+#define CLK_INFRACFG_AO_REG_TL_96M			67
+#define CLK_INFRACFG_AO_REG_PL_P_250M			68
+#define CLK_INFRACFG_AO_REG_CCIF_AP			69
+#define CLK_INFRACFG_AO_REG_DEBUGSYS			70
+#define CLK_INFRACFG_AO_REG_AUDIO			71
+#define CLK_INFRACFG_AO_REG_CCIF_MD			72
+#define CLK_INFRACFG_AO_REG_DBG_TRACE			73
+#define CLK_INFRACFG_AO_REG_CLDMA_BCLK			74
+#define CLK_INFRACFG_AO_REG_AUDIO_26M_BCLK		75
+#define CLK_INFRACFG_AO_REG_MODEM_TEMP_SHARE		76
+#define CLK_INFRACFG_AO_REG_SPI1			77
+#define CLK_INFRACFG_AO_REG_SPI2			78
+#define CLK_INFRACFG_AO_REG_SPI3			79
+#define CLK_INFRACFG_AO_REG_U_SAP_B			80
+#define CLK_INFRACFG_AO_REG_UNIPRO_MBIST		81
+#define CLK_INFRACFG_AO_REG_SPI4			82
+#define CLK_INFRACFG_AO_REG_SPI5			83
+#define CLK_INFRACFG_AO_REG_CQ_DMA			84
+#define CLK_INFRACFG_AO_REG_KP_IRQ_GEN			85
+#define CLK_INFRACFG_AO_REG_KP_32K			86
+#define CLK_INFRACFG_AO_REG_U_AXI			87
+#define CLK_INFRACFG_AO_REG_CCIF5_AP			88
+#define CLK_INFRACFG_AO_REG_CCIF5_MD			89
+#define CLK_INFRACFG_AO_REG_CCIF2_AP			90
+#define CLK_INFRACFG_AO_REG_CCIF2_MD			91
+#define CLK_INFRACFG_AO_REG_CCIF3_AP			92
+#define CLK_INFRACFG_AO_REG_CCIF3_MD			93
+#define CLK_INFRACFG_AO_REG_SEJ_F13M			94
+#define CLK_INFRACFG_AO_REG_AES				95
+#define CLK_INFRACFG_AO_REG_GCPU			96
+#define CLK_INFRACFG_AO_REG_ECC				97
+#define CLK_INFRACFG_AO_REG_CCIF4_AP			98
+#define CLK_INFRACFG_AO_REG_CCIF4_MD			99
+#define CLK_INFRACFG_AO_REGP_AUXADC_26M			100
+#define CLK_INFRACFG_AO_REGP_MSDC0			101
+#define CLK_INFRACFG_AO_REGP_MSDC0_H			102
+#define CLK_INFRACFG_AO_REGP_MSDC0_FAES			103
+#define CLK_INFRACFG_AO_REGP_MSDC0_MST_F		104
+#define CLK_INFRACFG_AO_REGP_MSDC0_SLV_H		105
+#define CLK_INFRACFG_AO_REGP_MSDC1			106
+#define CLK_INFRACFG_AO_REGP_MSDC1_H			107
+#define CLK_INFRACFG_AO_REGP_MSDC1_MST_F		108
+#define CLK_INFRACFG_AO_REGP_MSDC1_SLV_H		109
+#define CLK_INFRACFG_AO_REGP_MSDC2			110
+#define CLK_INFRACFG_AO_REGP_MSDC2_H			111
+#define CLK_INFRACFG_AO_REGP_MSDC2_MST_F		112
+#define CLK_INFRACFG_AO_REGP_MSDC2_SLV_H		113
+#define CLK_INFRACFG_AO_REGP_SFLASH			114
+#define CLK_INFRACFG_AO_REGP_SFLASH_F			115
+#define CLK_INFRACFG_AO_REGP_SFLASH_H			116
+#define CLK_INFRACFG_AO_REGP_SFLASH_P			117
+#define CLK_INFRACFG_AO_REGP_BTIF_B			118
+#define CLK_INFRACFG_AO_REGP_CAN0_P			119
+#define CLK_INFRACFG_AO_REGP_CAN0			120
+#define CLK_INFRACFG_AO_REGP_NFI_H			121
+#define CLK_INFRACFG_AO_REGP_NFI_B			122
+#define CLK_INFRACFG_AO_REGP_NFIECC_B			123
+
+/* IMP_IIC_WRAP_C */
+#define CLK_IMPC_I2C1					0
+#define CLK_IMPC_I2C2					1
+#define CLK_IMPC_I2C3					2
+#define CLK_IMPC_I2C5					3
+#define CLK_IMPC_I2C6					4
+#define CLK_IMPC_I2C7					5
+#define CLK_IMPC_I2C8					6
+#define CLK_IMPC_I2C9					7
+
+/* IMP_IIC_WRAP_E */
+#define CLK_IMPE_I2C0					0
+#define CLK_IMPE_I2C4					1
+
+/* DISPSYS_CONFIG */
+#define CLK_MM_DISP_OVL0_4L				0
+#define CLK_MM_DISP_OVL1_4L				1
+#define CLK_MM_DISP_RSZ0				2
+#define CLK_MM_DISP_RSZ1				3
+#define CLK_MM_DISP_RDMA0				4
+#define CLK_MM_DISP_RDMA1				5
+#define CLK_MM_DISP_COLOR1				6
+#define CLK_MM_DISP_CCORR1				7
+#define CLK_MM_DISP_CCORR3				8
+#define CLK_MM_DISP_AAL1				9
+#define CLK_MM_DISP_GAMMA1				10
+#define CLK_MM_DISP_DITHER1				11
+#define CLK_MM_VPP_MERGE0				12
+#define CLK_MM_DISP_DSI0_MM				13
+#define CLK_MM_DP_INTF0_MM				14
+#define CLK_MM_DPI0_MM					15
+#define CLK_MM_DISP_WDMA0				16
+#define CLK_MM_DISP_DSI1_MM				17
+#define CLK_MM_DISP_FAKE_ENG0				18
+#define CLK_MM_DISP_FAKE_ENG1				19
+#define CLK_MM_SMI_SUB_COMMON				20
+#define CLK_MM_DISP_MUTEX0				21
+#define CLK_MM_DISP_APB_BUS				22
+#define CLK_MM_LVDS_ENCODER				23
+#define CLK_MM_EPD_DLI_ASYNC				24
+#define CLK_MM_SMI					25
+#define CLK_MM_DISP_DSI0				26
+#define CLK_MM_DPI0					27
+#define CLK_MM_LVDS_ENCODER_PXL				28
+#define CLK_MM_DISP_DSI1				29
+#define CLK_MM_DP_INTF0					30
+#define CLK_MM_LVDS_ENCODER_CTS				31
+#define CLK_MM_AXI					32
+#define CLK_MM_EPDSYS					33
+#define CLK_MM_MM_CK_GLOBAL				34
+#define CLK_MM_DISP_DSI0_CK_GLOBAL			35
+#define CLK_MM_LVDS_PXL_CK_GLOBAL			36
+#define CLK_MM_DISP_DSI1_GLOBAL				37
+#define CLK_MM_DP_CK_GLOBAL				38
+#define CLK_MM_LVDS_CTS_CK_GLOBAL			39
+#define CLK_MM_AXI_CK_GLOBAL				40
+#define CLK_MM_EPDSYS_CK_GLOBAL				41
+#define CLK_MM_26M					42
+#define CLK_MM_32K					43
+
+/* DPTX_PHYD_SIFSLV_DIG_GLB */
+#define CLK_DPTX_PHYD_SIFSLV_DIG_GLB_RG_REF_CK_ENA	0
+
+/* EPDSYS_CONFIG */
+#define CLK_EPDSYS_PIPELINE_TOP				0
+#define CLK_EPDSYS_PIPELINE_IMAGE_RDMA			1
+#define CLK_EPDSYS_PIPELINE_WORKING_RDMA		2
+#define CLK_EPDSYS_PIPELINE_WDMA			3
+#define CLK_EPDSYS_PIPELINE_WF_LUT_TOP			4
+#define CLK_EPDSYS_PIPELINE_DPI				5
+#define CLK_EPDSYS_PIPELINE_6				6
+#define CLK_EPDSYS_PIPELINE_IMAGE_PROCESS		7
+#define CLK_EPDSYS_DISP_COLOR				8
+#define CLK_EPDSYS_DISP_CCORR				9
+#define CLK_EPDSYS_DPI					10
+#define CLK_EPDSYS_TCON					11
+#define CLK_EPDSYS_SMI_LARB3				12
+#define CLK_EPDSYS_SMI_LARB8				13
+#define CLK_EPDSYS_IMG_DL_RELAY				14
+#define CLK_EPDSYS_26M_HRTWT				15
+#define CLK_EPDSYS_DPI0_MM				16
+
+/* GCE */
+#define CLK_GCE_TOP					0
+
+#endif /* _DT_BINDINGS_CLK_MT8366_H */

-- 
2.43.0

