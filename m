Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA376EEC2AD
	for <u-boot@archiver.kernel.org>; Mon, 23 Feb 2026 23:24:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC16783E88;
	Tue, 24 Feb 2026 00:23:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="njkVBBef";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C054483D3D; Tue, 24 Feb 2026 00:23:04 +0100 (CET)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1145883D8A
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 00:22:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7d1959ba05cso2249829a34.2
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 15:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1771888976; x=1772493776;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jb6UwsJpHNsEpwqgik/cLv8IEB/Z8CCShduXpKgpi0Y=;
 b=njkVBBef7Rl1L3rTQdcuy0DkcEsIZtO37EfYMdDpK3KNxjKrOaTY0LOAuy6osq7gAw
 7+oMEoj24CfS9UpnXeFfGSbyVyeasXoVBGS9oyc7pI1otBBTfmcbTRTq4tbHjLo9IBHh
 0h+tTM/dvrG51T07/bZBj8kRlXsBY7Zt4X7u1n3mLWpoF0EMjV/1ayyReV2QCLpXioNP
 gxmwqS+kQkWXzmtwGWz0L4Kt3s4kDaG69jhvkVSSqxb1a4BFMLNCoPQXfKQTXyeJFki+
 fQPhlTLya0DbJDANH0FRNn94myAhv7jvyCDatN3HxFZDLylse6zdkvGMXvFZjWJnrsDT
 nVXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771888976; x=1772493776;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jb6UwsJpHNsEpwqgik/cLv8IEB/Z8CCShduXpKgpi0Y=;
 b=qhXdGalEuP0X8R1mR33xsM6ag/wfEVqCa8CBQDUHgik/A44Td+H4HUeNB6iiNfpqwE
 h3tL1WFn6nQ6C8s/oTAyOMY/C8GevE3r40oQpC7LtaE9JwHzduOo+3GziLkhlLpwBeIN
 oZuf87puuSa2+RNx/2W4kOVWF++QQZJB8LfOp5Zr0H3ToROK1xeGFHcJ90fhdMfDshgr
 xwshCvrHMPxWUlSr96zvESSn2JL+z/D8K8/dL3FWn4mDconYnKuQwl9Ih/w+YRfEpD2+
 hY36CY7N+kd5vAIhvMH49J9cst/ozP5J8umlCvHTi+hmG7tDRR1YjLTWBEtaBkFcMmIP
 tubQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPJS92J8hJsa4Li/+xPq3IKSrmbwFmf8B1ibmEQ9gUeZAha1SIlOM/zfvevtOraqhIdIK6mCU=@lists.denx.de
X-Gm-Message-State: AOJu0YwJnXGZvjeEDWRIfP3RYB6d7T0LxGDQkCN+mww7m9jNvVPhSu+P
 MyFc0V5UUOxlsAq5OSMu3RPRU79oKGWOjTzFGIhuKdBc4skqcKLY+8AEQbXvhigFpIE=
X-Gm-Gg: AZuq6aLpDfasDsFVICeaNZVkE+o8yWQiAZ/HSofnPiotUyxsGRL+xk/vP5xsW/FuY5R
 i7mg3CRF5TqEGta3BHWl81DqfXGWj4fmyU9s17x0tUCMOv7f3WzpoJsthdnQmvHRzMGgPtNAaVq
 lqOSgh7X1POkEKeTMr43e8pEpTh3/H4fbvzBrUe8/QziAeormhuqL83R/cQnD4U9vo5Uns8B8g5
 b5Bfmc9yB5BeNcv3zChxRwjyV97/1b2W/K5OxzexLar7z/D68JKp9h3YvxlyxS0v7wentQiA5UV
 d8S4/GolSvzNWaktWVKpk6Ow7tXef+bdcghx8UuZodWH10d1qgTtdTYa8kL72BOatifduxTUfJ6
 7jWwP8QHQJSevwNeAOPyDK3cOnfZ/jzwxkCLUbBsr4tbLLsTRqHHkf+X5K0Xtkgo5QHYnOg+yRC
 9LoQErSwobjNH0jO/nFEqyIZgQW18c
X-Received: by 2002:a05:6830:6210:b0:7d5:1850:b26d with SMTP id
 46e09a7af769-7d52bea886cmr5822451a34.0.1771888976359; 
 Mon, 23 Feb 2026 15:22:56 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:cb87:475c:5c04:ac92])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d52cf78736sm8911230a34.5.2026.02.23.15.22.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 15:22:56 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 23 Feb 2026 17:21:58 -0600
Subject: [PATCH 6/7] clk: mediatek: mt7629: change to struct mtk_parent
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-clk-mtk-remove-clk-bypass-xtal-flag-v1-6-a7dc97bc2660@baylibre.com>
References: <20260223-clk-mtk-remove-clk-bypass-xtal-flag-v1-0-a7dc97bc2660@baylibre.com>
In-Reply-To: <20260223-clk-mtk-remove-clk-bypass-xtal-flag-v1-0-a7dc97bc2660@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=15654;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=Kz8XRdmkj+Tl8dmQQixLrBACxMH2ud7M0W2R1GQ+Joc=;
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpnOE8MhSxWGKT8kyVoufi1eZ5w0OMbCww+BrEO
 oZnOuUtu0OJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaZzhPBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ALtMH/ReA0mMbJ9dXUxOH1H2Hn2+QJX6zet9flqtNSa7
 xVw0/rpqBZDeftkP7TSJmg0rNQ39OXUKjr5eSW1gFPXeHC62WWr+/SBGZSFFBK39oYUPgTJQqE6
 aOFuhzvz1ajMEmlgHVTDRUjKm6KLFVYzwlG9MUMfHJdNbafNOyCISN6DKa4t+yGatT0VzIziiHS
 zacj0pHdc/JjsddddT4NUp5M2QkeQOch2BeO3kEnui2k4g8+KX/a4AfHSd5xjf5CH1obRppDgWT
 YCkJcmLmX2A2DbJ6CXPyBgXSX/Yj16jUx/Qa0iH/NUkNFqxEe+DNcW616nBUpeCz5Ao+0rHWQ+j
 PXyE=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Change mux parents to use struct mtk_parent instead of int. Since these
clocks have mixed parents, we should be using struct mtk_parent which
specifically handles this case.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt7629.c | 444 +++++++++++++++++++-------------------
 1 file changed, 224 insertions(+), 220 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7629.c b/drivers/clk/mediatek/clk-mt7629.c
index 85011f5327b..56f4c99d84b 100644
--- a/drivers/clk/mediatek/clk-mt7629.c
+++ b/drivers/clk/mediatek/clk-mt7629.c
@@ -152,271 +152,275 @@ static const struct mtk_fixed_factor top_fixed_divs[] = {
 	FACTOR1(CLK_TOP_PCIE0_MAC_EN, CLK_TOP_UNIVPLL1_D4, 1, 1),
 };
 
-static const int axi_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_SYSPLL1_D2,
-	CLK_TOP_SYSPLL_D5,
-	CLK_TOP_SYSPLL1_D4,
-	CLK_TOP_UNIVPLL_D5,
-	CLK_TOP_UNIVPLL2_D2,
-	CLK_TOP_UNIVPLL_D7,
-	CLK_TOP_DMPLL
-};
-
-static const int mem_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_DMPLL
-};
-
-static const int ddrphycfg_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_SYSPLL1_D8
-};
-
-static const int eth_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_SYSPLL1_D2,
-	CLK_TOP_UNIVPLL1_D2,
-	CLK_TOP_SYSPLL1_D4,
-	CLK_TOP_UNIVPLL_D5,
-	CLK_TOP_SGMIIPLL_D2,
-	CLK_TOP_UNIVPLL_D7,
-	CLK_TOP_DMPLL
-};
-
-static const int pwm_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_UNIVPLL2_D4
-};
-
-static const int sgmii_ref_1_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_SGMIIPLL_D2
-};
-
-static const int nfi_infra_parents[] = {
-	CLK_XTAL,
-	CLK_XTAL,
-	CLK_XTAL,
-	CLK_XTAL,
-	CLK_XTAL,
-	CLK_XTAL,
-	CLK_TOP_UNIVPLL2_D8,
-	CLK_TOP_UNIVPLL3_D4,
-	CLK_TOP_SYSPLL1_D8,
-	CLK_TOP_UNIVPLL1_D8,
-	CLK_TOP_SYSPLL4_D2,
-	CLK_TOP_SYSPLL2_D4,
-	CLK_TOP_UNIVPLL2_D4,
-	CLK_TOP_UNIVPLL3_D2,
-	CLK_TOP_SYSPLL1_D4,
-	CLK_TOP_SYSPLL_D7
-};
-
-static const int flash_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_UNIVPLL_D80_D4,
-	CLK_TOP_SYSPLL2_D8,
-	CLK_TOP_SYSPLL3_D4,
-	CLK_TOP_UNIVPLL3_D4,
-	CLK_TOP_UNIVPLL1_D8,
-	CLK_TOP_SYSPLL2_D4,
-	CLK_TOP_UNIVPLL2_D4
-};
-
-static const int uart_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_UNIVPLL2_D8
-};
-
-static const int spi0_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_SYSPLL3_D2,
-	CLK_XTAL,
-	CLK_TOP_SYSPLL2_D4,
-	CLK_TOP_SYSPLL4_D2,
-	CLK_TOP_UNIVPLL2_D4,
-	CLK_TOP_UNIVPLL1_D8,
-	CLK_XTAL
-};
-
-static const int spi1_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_SYSPLL3_D2,
-	CLK_XTAL,
-	CLK_TOP_SYSPLL4_D4,
-	CLK_TOP_SYSPLL4_D2,
-	CLK_TOP_UNIVPLL2_D4,
-	CLK_TOP_UNIVPLL1_D8,
-	CLK_XTAL
-};
-
-static const int msdc30_0_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_UNIVPLL2_D16,
-	CLK_TOP_UNIV48M
-};
-
-static const int msdc30_1_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_UNIVPLL2_D16,
-	CLK_TOP_UNIV48M,
-	CLK_TOP_SYSPLL2_D4,
-	CLK_TOP_UNIVPLL2_D4,
-	CLK_TOP_SYSPLL_D7,
-	CLK_TOP_SYSPLL2_D2,
-	CLK_TOP_UNIVPLL2_D2
+#define XTAL_PARENT(id)	PARENT(id, CLK_PARENT_XTAL)
+#define TOP_PARENT(id)	PARENT(id, CLK_PARENT_TOPCKGEN)
+#define VOID_PARENT	PARENT(-1, 0)
+
+static const struct mtk_parent axi_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL_D5),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D7),
+	TOP_PARENT(CLK_TOP_DMPLL),
+};
+
+static const struct mtk_parent mem_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_DMPLL),
+};
+
+static const struct mtk_parent ddrphycfg_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D8),
+};
+
+static const struct mtk_parent eth_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5),
+	TOP_PARENT(CLK_TOP_SGMIIPLL_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D7),
+	TOP_PARENT(CLK_TOP_DMPLL),
+};
+
+static const struct mtk_parent pwm_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D4),
+};
+
+static const struct mtk_parent sgmii_ref_1_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SGMIIPLL_D2),
+};
+
+static const struct mtk_parent nfi_infra_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	XTAL_PARENT(CLK_XTAL),
+	XTAL_PARENT(CLK_XTAL),
+	XTAL_PARENT(CLK_XTAL),
+	XTAL_PARENT(CLK_XTAL),
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D8),
+	TOP_PARENT(CLK_TOP_UNIVPLL3_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D8),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D8),
+	TOP_PARENT(CLK_TOP_SYSPLL4_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL2_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL3_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL_D7),
+};
+
+static const struct mtk_parent flash_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D80_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL2_D8),
+	TOP_PARENT(CLK_TOP_SYSPLL3_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL3_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D8),
+	TOP_PARENT(CLK_TOP_SYSPLL2_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D4),
+};
+
+static const struct mtk_parent uart_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D8),
+};
+
+static const struct mtk_parent spi0_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL3_D2),
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL2_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL4_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D8),
+	XTAL_PARENT(CLK_XTAL),
+};
+
+static const struct mtk_parent spi1_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL3_D2),
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL4_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL4_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D8),
+	XTAL_PARENT(CLK_XTAL),
+};
+
+static const struct mtk_parent msdc30_0_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D16),
+	TOP_PARENT(CLK_TOP_UNIV48M),
+};
+
+static const struct mtk_parent msdc30_1_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D16),
+	TOP_PARENT(CLK_TOP_UNIV48M),
+	TOP_PARENT(CLK_TOP_SYSPLL2_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL_D7),
+	TOP_PARENT(CLK_TOP_SYSPLL2_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D2),
 };
 
-static const int ap2wbmcu_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_SYSPLL1_D2,
-	CLK_TOP_UNIV48M,
-	CLK_TOP_SYSPLL1_D8,
-	CLK_TOP_UNIVPLL2_D4,
-	CLK_TOP_SYSPLL_D7,
-	CLK_TOP_SYSPLL2_D2,
-	CLK_TOP_UNIVPLL2_D2
+static const struct mtk_parent ap2wbmcu_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D2),
+	TOP_PARENT(CLK_TOP_UNIV48M),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D8),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL_D7),
+	TOP_PARENT(CLK_TOP_SYSPLL2_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D2),
 };
 
-static const int audio_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_SYSPLL3_D4,
-	CLK_TOP_SYSPLL4_D4,
-	CLK_TOP_SYSPLL1_D16
+static const struct mtk_parent audio_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL3_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL4_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D16),
 };
 
-static const int aud_intbus_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_SYSPLL1_D4,
-	CLK_TOP_SYSPLL4_D2,
-	CLK_TOP_DMPLL_D4
-};
+static const struct mtk_parent aud_intbus_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL4_D2),
+	TOP_PARENT(CLK_TOP_DMPLL_D4),
+};
 
-static const int pmicspi_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_SYSPLL1_D8,
-	CLK_TOP_SYSPLL3_D4,
-	CLK_TOP_SYSPLL1_D16,
-	CLK_TOP_UNIVPLL3_D4,
-	CLK_XTAL,
-	CLK_TOP_UNIVPLL2_D4,
-	CLK_TOP_DMPLL_D8
+static const struct mtk_parent pmicspi_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D8),
+	TOP_PARENT(CLK_TOP_SYSPLL3_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D16),
+	TOP_PARENT(CLK_TOP_UNIVPLL3_D4),
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D4),
+	TOP_PARENT(CLK_TOP_DMPLL_D8),
 };
 
-static const int scp_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_SYSPLL1_D8,
-	CLK_TOP_UNIVPLL2_D2,
-	CLK_TOP_UNIVPLL2_D4
+static const struct mtk_parent scp_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D8),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D4),
 };
 
-static const int atb_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_SYSPLL1_D2,
-	CLK_TOP_SYSPLL_D5
+static const struct mtk_parent atb_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL_D5),
 };
 
-static const int hif_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_SYSPLL1_D2,
-	CLK_TOP_UNIVPLL1_D2,
-	CLK_TOP_SYSPLL1_D4,
-	CLK_TOP_UNIVPLL_D5,
-	-1,
-	CLK_TOP_UNIVPLL_D7
+static const struct mtk_parent hif_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5),
+	VOID_PARENT,
+	TOP_PARENT(CLK_TOP_UNIVPLL_D7),
 };
 
-static const int sata_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_UNIVPLL2_D4
+static const struct mtk_parent sata_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D4),
 };
 
-static const int usb20_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_UNIVPLL3_D4,
-	CLK_TOP_SYSPLL1_D8
+static const struct mtk_parent usb20_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_UNIVPLL3_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D8),
 };
 
-static const int aud1_parents[] = {
-	CLK_XTAL
+static const struct mtk_parent aud1_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
 };
 
-static const int irrx_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_SYSPLL4_D16
+static const struct mtk_parent irrx_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL4_D16),
 };
 
-static const int crypto_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_UNIVPLL_D3,
-	CLK_TOP_UNIVPLL1_D2,
-	CLK_TOP_SYSPLL1_D2,
-	CLK_TOP_UNIVPLL_D5,
-	CLK_TOP_SYSPLL_D5,
-	CLK_TOP_UNIVPLL2_D2,
-	CLK_TOP_SYSPLL_D2
+static const struct mtk_parent crypto_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D3),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5),
+	TOP_PARENT(CLK_TOP_SYSPLL_D5),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL_D2),
 };
 
-static const int gpt10m_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_CLKXTAL_D4
+static const struct mtk_parent gpt10m_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_CLKXTAL_D4),
 };
 
 static const struct mtk_composite top_muxes[] = {
 	/* CLK_CFG_0 */
-	MUX_GATE(CLK_TOP_AXI_SEL, axi_parents, 0x40, 0, 3, 7),
-	MUX_GATE(CLK_TOP_MEM_SEL, mem_parents, 0x40, 8, 1, 15),
-	MUX_GATE(CLK_TOP_DDRPHYCFG_SEL, ddrphycfg_parents, 0x40, 16, 1, 23),
-	MUX_GATE(CLK_TOP_ETH_SEL, eth_parents, 0x40, 24, 3, 31),
+	MUX_GATE_MIXED(CLK_TOP_AXI_SEL, axi_parents, 0x40, 0, 3, 7),
+	MUX_GATE_MIXED(CLK_TOP_MEM_SEL, mem_parents, 0x40, 8, 1, 15),
+	MUX_GATE_MIXED(CLK_TOP_DDRPHYCFG_SEL, ddrphycfg_parents, 0x40, 16, 1, 23),
+	MUX_GATE_MIXED(CLK_TOP_ETH_SEL, eth_parents, 0x40, 24, 3, 31),
 
 	/* CLK_CFG_1 */
-	MUX_GATE(CLK_TOP_PWM_SEL, pwm_parents, 0x50, 0, 2, 7),
-	MUX_GATE(CLK_TOP_F10M_REF_SEL, irrx_parents, 0x50, 8, 1, 15),
-	MUX_GATE(CLK_TOP_NFI_INFRA_SEL, nfi_infra_parents, 0x50, 16, 4, 23),
-	MUX_GATE(CLK_TOP_FLASH_SEL, flash_parents, 0x50, 24, 3, 31),
+	MUX_GATE_MIXED(CLK_TOP_PWM_SEL, pwm_parents, 0x50, 0, 2, 7),
+	MUX_GATE_MIXED(CLK_TOP_F10M_REF_SEL, irrx_parents, 0x50, 8, 1, 15),
+	MUX_GATE_MIXED(CLK_TOP_NFI_INFRA_SEL, nfi_infra_parents, 0x50, 16, 4, 23),
+	MUX_GATE_MIXED(CLK_TOP_FLASH_SEL, flash_parents, 0x50, 24, 3, 31),
 
 	/* CLK_CFG_2 */
-	MUX_GATE(CLK_TOP_UART_SEL, uart_parents, 0x60, 0, 1, 7),
-	MUX_GATE(CLK_TOP_SPI0_SEL, spi0_parents, 0x60, 8, 3, 15),
-	MUX_GATE(CLK_TOP_SPI1_SEL, spi1_parents, 0x60, 16, 3, 23),
-	MUX_GATE(CLK_TOP_MSDC50_0_SEL, uart_parents, 0x60, 24, 3, 31),
+	MUX_GATE_MIXED(CLK_TOP_UART_SEL, uart_parents, 0x60, 0, 1, 7),
+	MUX_GATE_MIXED(CLK_TOP_SPI0_SEL, spi0_parents, 0x60, 8, 3, 15),
+	MUX_GATE_MIXED(CLK_TOP_SPI1_SEL, spi1_parents, 0x60, 16, 3, 23),
+	MUX_GATE_MIXED(CLK_TOP_MSDC50_0_SEL, uart_parents, 0x60, 24, 3, 31),
 
 	/* CLK_CFG_3 */
-	MUX_GATE(CLK_TOP_MSDC30_0_SEL, msdc30_0_parents, 0x70, 0, 3, 7),
-	MUX_GATE(CLK_TOP_MSDC30_1_SEL, msdc30_1_parents, 0x70, 8, 3, 15),
-	MUX_GATE(CLK_TOP_AP2WBMCU_SEL, ap2wbmcu_parents, 0x70, 16, 3, 23),
-	MUX_GATE(CLK_TOP_AP2WBHIF_SEL, ap2wbmcu_parents, 0x70, 24, 3, 31),
+	MUX_GATE_MIXED(CLK_TOP_MSDC30_0_SEL, msdc30_0_parents, 0x70, 0, 3, 7),
+	MUX_GATE_MIXED(CLK_TOP_MSDC30_1_SEL, msdc30_1_parents, 0x70, 8, 3, 15),
+	MUX_GATE_MIXED(CLK_TOP_AP2WBMCU_SEL, ap2wbmcu_parents, 0x70, 16, 3, 23),
+	MUX_GATE_MIXED(CLK_TOP_AP2WBHIF_SEL, ap2wbmcu_parents, 0x70, 24, 3, 31),
 
 	/* CLK_CFG_4 */
-	MUX_GATE(CLK_TOP_AUDIO_SEL, audio_parents, 0x80, 0, 2, 7),
-	MUX_GATE(CLK_TOP_AUD_INTBUS_SEL, aud_intbus_parents, 0x80, 8, 2, 15),
-	MUX_GATE(CLK_TOP_PMICSPI_SEL, pmicspi_parents, 0x80, 16, 3, 23),
-	MUX_GATE(CLK_TOP_SCP_SEL, scp_parents, 0x80, 24, 2, 31),
+	MUX_GATE_MIXED(CLK_TOP_AUDIO_SEL, audio_parents, 0x80, 0, 2, 7),
+	MUX_GATE_MIXED(CLK_TOP_AUD_INTBUS_SEL, aud_intbus_parents, 0x80, 8, 2, 15),
+	MUX_GATE_MIXED(CLK_TOP_PMICSPI_SEL, pmicspi_parents, 0x80, 16, 3, 23),
+	MUX_GATE_MIXED(CLK_TOP_SCP_SEL, scp_parents, 0x80, 24, 2, 31),
 
 	/* CLK_CFG_5 */
-	MUX_GATE(CLK_TOP_ATB_SEL, atb_parents, 0x90, 0, 2, 7),
-	MUX_GATE_FLAGS(CLK_TOP_HIF_SEL, hif_parents, 0x90, 8, 3, 15,
-		       CLK_MUX_DOMAIN_SCPSYS),
-	MUX_GATE(CLK_TOP_SATA_SEL, sata_parents, 0x90, 16, 1, 23),
-	MUX_GATE(CLK_TOP_U2_SEL, usb20_parents, 0x90, 24, 2, 31),
+	MUX_GATE_MIXED(CLK_TOP_ATB_SEL, atb_parents, 0x90, 0, 2, 7),
+	MUX_GATE_MIXED_FLAGS(CLK_TOP_HIF_SEL, hif_parents, 0x90, 8, 3, 15,
+			     CLK_MUX_DOMAIN_SCPSYS),
+	MUX_GATE_MIXED(CLK_TOP_SATA_SEL, sata_parents, 0x90, 16, 1, 23),
+	MUX_GATE_MIXED(CLK_TOP_U2_SEL, usb20_parents, 0x90, 24, 2, 31),
 
 	/* CLK_CFG_6 */
-	MUX_GATE(CLK_TOP_AUD1_SEL, aud1_parents, 0xA0, 0, 1, 7),
-	MUX_GATE(CLK_TOP_AUD2_SEL, aud1_parents, 0xA0, 8, 1, 15),
-	MUX_GATE(CLK_TOP_IRRX_SEL, irrx_parents, 0xA0, 16, 1, 23),
-	MUX_GATE(CLK_TOP_IRTX_SEL, irrx_parents, 0xA0, 24, 1, 31),
+	MUX_GATE_MIXED(CLK_TOP_AUD1_SEL, aud1_parents, 0xA0, 0, 1, 7),
+	MUX_GATE_MIXED(CLK_TOP_AUD2_SEL, aud1_parents, 0xA0, 8, 1, 15),
+	MUX_GATE_MIXED(CLK_TOP_IRRX_SEL, irrx_parents, 0xA0, 16, 1, 23),
+	MUX_GATE_MIXED(CLK_TOP_IRTX_SEL, irrx_parents, 0xA0, 24, 1, 31),
 
 	/* CLK_CFG_7 */
-	MUX_GATE(CLK_TOP_SATA_MCU_SEL, scp_parents, 0xB0, 0, 2, 7),
-	MUX_GATE(CLK_TOP_PCIE0_MCU_SEL, scp_parents, 0xB0, 8, 2, 15),
-	MUX_GATE(CLK_TOP_PCIE1_MCU_SEL, scp_parents, 0xB0, 16, 2, 23),
-	MUX_GATE(CLK_TOP_SSUSB_MCU_SEL, scp_parents, 0xB0, 24, 2, 31),
+	MUX_GATE_MIXED(CLK_TOP_SATA_MCU_SEL, scp_parents, 0xB0, 0, 2, 7),
+	MUX_GATE_MIXED(CLK_TOP_PCIE0_MCU_SEL, scp_parents, 0xB0, 8, 2, 15),
+	MUX_GATE_MIXED(CLK_TOP_PCIE1_MCU_SEL, scp_parents, 0xB0, 16, 2, 23),
+	MUX_GATE_MIXED(CLK_TOP_SSUSB_MCU_SEL, scp_parents, 0xB0, 24, 2, 31),
 
 	/* CLK_CFG_8 */
-	MUX_GATE(CLK_TOP_CRYPTO_SEL, crypto_parents, 0xC0, 0, 3, 7),
-	MUX_GATE(CLK_TOP_SGMII_REF_1_SEL, sgmii_ref_1_parents, 0xC0, 8, 1, 15),
-	MUX_GATE(CLK_TOP_10M_SEL, gpt10m_parents, 0xC0, 16, 1, 23),
+	MUX_GATE_MIXED(CLK_TOP_CRYPTO_SEL, crypto_parents, 0xC0, 0, 3, 7),
+	MUX_GATE_MIXED(CLK_TOP_SGMII_REF_1_SEL, sgmii_ref_1_parents, 0xC0, 8, 1, 15),
+	MUX_GATE_MIXED(CLK_TOP_10M_SEL, gpt10m_parents, 0xC0, 16, 1, 23),
 };
 
 /* infracfg */

-- 
2.43.0

