Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E33E9FCA18D
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 21:30:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5337083FF9;
	Mon,  9 Mar 2026 22:29:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="INudIbRm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18EC883FF9; Mon,  9 Mar 2026 22:29:32 +0100 (CET)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B27C583A8C
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 22:29:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-41708e43f61so946911fac.1
 for <u-boot@lists.denx.de>; Mon, 09 Mar 2026 14:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773091767; x=1773696567;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NXTe3/ffbbaTUOXsi96ptGHnCoGFty8t5MRUfo4qo8s=;
 b=INudIbRmcS8oBV/nGMEtt/MYOCMfPKhHSwsXpHI8gtYcVOzB767ARWoEwKWuNipOI5
 bGGMkhjHx3WINTUncuFo1Bv3axZzN4Tht0btMnj1ONT8Cc6bJ+z+8wzBjby04W9ETETQ
 D5EYsumFMyjA0AW8CZ2fYuQ2Wi+Hg4s7UifzctiJAKq4cgxjzVchT7vFS43y4wqHNGbi
 jfRoGe9Z1S37pWHhbOmzOanCMfhU8NAkrdj9aX5RK3Uuv268aAC0oqxENWjqqxjvn4N2
 rPlx7e3gAVUYugPZLQJjP7bXoqxc5vlWkqtzOdx9yXBgh64lwTqExIDowr8oAg0hsYa+
 tb2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773091767; x=1773696567;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NXTe3/ffbbaTUOXsi96ptGHnCoGFty8t5MRUfo4qo8s=;
 b=xT+FN7YRWB5Pg2mx4OWlXzVPNt/gqm+QV6CWVQG+D8bDojy4d+uJVm0Q8i9z2DDJLl
 +v3EvTmnwKmbZvzqv3pz462DktufsRtZx49XisVoX/AeOv3OloQarwZAMo/3i28LUL5D
 DvBAndMs4FifeeFminGsfs6xt2GpWz8ZFrE6qh1IGqk35KxuCNAL8joiuNyjGOwe9HoC
 ArGkleTXsxISTZcOsV9vOkZpAZNkuzhGUADzMRpFfee703XwJQM/NC9EkspJxMrngPe9
 JdrH8lT3bUnrpTOhf+y2bOSuEeP0ZtfLf9uaz3leFI3hrLmVi4HqtJqe7409opkt1ZAK
 eqVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiA+wCQFYxd3l/RcRWgLnKAhaYZHdSNWqIy8K5FsFsqB7/gSTi+BKWkeYSqt5Ve9OPJzd2cBw=@lists.denx.de
X-Gm-Message-State: AOJu0Yy2uz8hKDDrq4gsAbju1UPqJuI+/fvUorkcON2WA/4MrrkvOxFL
 fwJjYK7QbTZvDnhLs9EcTqPyGCwLN7ETBCPXPL5aypj3S6SaAJHppUg4LL3HeV4eZbc=
X-Gm-Gg: ATEYQzxhDETm9YJP/4UGnv63SMkceoZzU+OS2MOhs1YwIdVXYOGxJJ2C9TIGo+rJd4K
 qi5Aa/FErhxJ9ykqZ2hlzG4mWVI7pAv9XJuoPlqOYf5+DA9vC704PJwHVxPvx10BNi3LaFuqwtq
 wN7so3T7DYrYvPPnFHDFFfhZu69rfKtH2gMhcxCKPUYKf2QJxnjvR+xjbYUqN03P4jk1Gu6Q6E7
 aEzVJTcSolg0hUDe8pCsxT4i/UsWMNTtmXEygUqwra5ZEN8DTg89uFQPtJ3B4Ll4LBuKcPF/Aep
 GlhbZUNC8NM+ta4xN1Hi9bDOCbDfUcroMJzvaknQjQfdT/YjW56h7Ivf98KelTUKySd5YdG5Nz8
 Yg49TtLiJ2W0CxUApWkpP4969n8EzlZPoitbUp2+3tCUAVV6BGRSK5TjUaMMtIc5j2fTL3xGQka
 vRQiOIp+WTaOj36C9Bc2nvNR+pZA==
X-Received: by 2002:a05:6870:9a23:b0:40e:e931:e7ed with SMTP id
 586e51a60fabf-416e43eb032mr6600268fac.42.1773091767309; 
 Mon, 09 Mar 2026 14:29:27 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:77:c35f:9c1b:c75f])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41756b47f0asm826221fac.8.2026.03.09.14.29.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 14:29:26 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 09 Mar 2026 16:27:44 -0500
Subject: [PATCH v2 09/13] clk: mediatek: mt8512: convert to struct mtk_parent
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260309-clk-mtk-unify-mux-parents-v2-9-b084ea74b99d@baylibre.com>
References: <20260309-clk-mtk-unify-mux-parents-v2-0-b084ea74b99d@baylibre.com>
In-Reply-To: <20260309-clk-mtk-unify-mux-parents-v2-0-b084ea74b99d@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=25777;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=dTH4FFgaN7lYnE0UV5x+I78Z2P92lY9ogNtXDvsABTI=;
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBprzuJc5f0zY+erdE14Mmn7jGS2Va9OdAEyjpkr
 CjvW4f6xbqJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaa87iRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ACHsH/iSiMwUDSa9E/MtthxcX2TYrm3cD7heDFqxk0OD
 Q+tcW+VsG+30BtteA01V9mBYJbQFWgkphXof912aXUATrG9fGiNiQ3DXSPCMxXEDA07rFV0RyT8
 0da/RglI4EhpTVYS7ypYt7QJdr+16+8SIF5VWtxCXWC0w2W2MejjpSCRDvME87NjOctBCVeTjxG
 L+FVvJK0784Z7X+kYDdX5AmVomR+DsqhoC7zUGqxrMuc9VT+Slru3mYfS1W2Jsve7HmBAbc5oEE
 ODUZAlwO8qcdCrAUR9WmaffCrVXah7hAinCUh2nwGxhaRvqqdgjh8DnUvSzMqAxzQbtXUAoVkc1
 9ilU=
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

Convert all parent clock arrays to use struct mtk_parent. This will
allow us to simplify core code later by having only one possible data
type for mux parent arrays.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8512.c | 692 +++++++++++++++++++-------------------
 1 file changed, 346 insertions(+), 346 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8512.c b/drivers/clk/mediatek/clk-mt8512.c
index 7af5858286c..0ea600b577a 100644
--- a/drivers/clk/mediatek/clk-mt8512.c
+++ b/drivers/clk/mediatek/clk-mt8512.c
@@ -135,465 +135,465 @@ static const struct mtk_fixed_factor top_fixed_divs[] = {
 	FACTOR1(CLK_TOP_NFI2X_CK_D2, CLK_TOP_NFI2X_SEL, 1, 2),
 };
 
-static const int axi_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_SYSPLL1_D4,
-	CLK_TOP_UNIVPLL3_D2,
-	CLK_TOP_SYSPLL1_D8,
-	CLK_TOP_SYS_26M_D2,
-	CLK_TOP_CLK32K
-};
-
-static const int mem_parents[] = {
-	CLK_TOP_DSPPLL,
-	CLK_TOP_IPPLL,
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL_D3
-};
-
-static const int uart_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL2_D8
-};
-
-static const int spi_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL2_D2,
-	CLK_TOP_SYSPLL2_D2,
-	CLK_TOP_UNIVPLL1_D4,
-	CLK_TOP_SYSPLL1_D4,
-	CLK_TOP_UNIVPLL3_D2,
-	CLK_TOP_UNIVPLL2_D4,
-	CLK_TOP_SYSPLL4_D2
-};
-
-static const int spis_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL_D3,
-	CLK_TOP_SYSPLL_D3,
-	CLK_TOP_UNIVPLL1_D2,
-	CLK_TOP_UNIVPLL2_D2,
-	CLK_TOP_UNIVPLL1_D4,
-	CLK_TOP_UNIVPLL2_D4,
-	CLK_TOP_SYSPLL4_D2
-};
-
-static const int msdc50_0_hc_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_SYSPLL1_D2,
-	CLK_TOP_UNIVPLL1_D4,
-	CLK_TOP_SYSPLL2_D2
-};
-
-static const int msdc50_0_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_MSDCPLL_D2,
-	CLK_TOP_UNIVPLL2_D2,
-	CLK_TOP_SYSPLL2_D2,
-	CLK_TOP_UNIVPLL1_D4,
-	CLK_TOP_SYSPLL1_D4,
-	CLK_TOP_SYSPLL2_D4,
-	CLK_TOP_UNIVPLL2_D8
-};
-
-static const int msdc50_2_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_MSDCPLL,
-	CLK_TOP_UNIVPLL_D3,
-	CLK_TOP_UNIVPLL1_D2,
-	CLK_TOP_SYSPLL1_D2,
-	CLK_TOP_UNIVPLL2_D2,
-	CLK_TOP_SYSPLL2_D2,
-	CLK_TOP_UNIVPLL1_D4
-};
-
-static const int audio_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL2_D8,
-	CLK_TOP_APLL1_D4,
-	CLK_TOP_APLL2_D4
-};
-
-static const int aud_intbus_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_SYSPLL1_D4,
-	CLK_TOP_UNIVPLL3_D2,
-	CLK_TOP_APLL2_D8,
-	CLK_TOP_SYS_26M_D2,
-	CLK_TOP_APLL1_D8,
-	CLK_TOP_UNIVPLL3_D4
-};
-
-static const int hapll1_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_APLL1,
-	CLK_TOP_APLL1_D2,
-	CLK_TOP_APLL1_D3,
-	CLK_TOP_APLL1_D4,
-	CLK_TOP_APLL1_D8,
-	CLK_TOP_APLL1_D16,
-	CLK_TOP_SYS_26M_D2
-};
-
-static const int hapll2_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_APLL2,
-	CLK_TOP_APLL2_D2,
-	CLK_TOP_APLL2_D3,
-	CLK_TOP_APLL2_D4,
-	CLK_TOP_APLL2_D8,
-	CLK_TOP_APLL2_D16,
-	CLK_TOP_SYS_26M_D2
-};
-
-static const int asm_l_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL2_D4,
-	CLK_TOP_UNIVPLL2_D2,
-	CLK_TOP_SYSPLL_D5
-};
-
-static const int aud_spdif_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL_D2,
-	CLK_TOP_DSPPLL
-};
-
-static const int aud_1_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_APLL1
-};
-
-static const int aud_2_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_APLL2
-};
-
-static const int ssusb_sys_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL3_D4,
-	CLK_TOP_UNIVPLL2_D4,
-	CLK_TOP_UNIVPLL3_D2
-};
-
-static const int spm_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_SYSPLL1_D8
-};
-
-static const int i2c_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_SYS_26M_D2,
-	CLK_TOP_UNIVPLL3_D4,
-	CLK_TOP_UNIVPLL3_D2,
-	CLK_TOP_SYSPLL1_D8,
-	CLK_TOP_SYSPLL2_D8,
-	CLK_TOP_CLK32K
-};
-
-static const int pwm_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL3_D4,
-	CLK_TOP_SYSPLL1_D8,
-	CLK_TOP_UNIVPLL2_D4,
-	CLK_TOP_SYS_26M_D2,
-	CLK_TOP_CLK32K
-};
-
-static const int dsp_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_DSPPLL,
-	CLK_TOP_DSPPLL_D2,
-	CLK_TOP_DSPPLL_D4,
-	CLK_TOP_DSPPLL_D8,
-	CLK_TOP_APLL2_D4,
-	CLK_TOP_SYS_26M_D2,
-	CLK_TOP_CLK32K
-};
-
-static const int nfi2x_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_SYSPLL2_D2,
-	CLK_TOP_SYSPLL_D7,
-	CLK_TOP_SYSPLL_D3,
-	CLK_TOP_SYSPLL2_D4,
-	CLK_TOP_MSDCPLL_D2,
-	CLK_TOP_UNIVPLL1_D2,
-	CLK_TOP_UNIVPLL_D5
-};
-
-static const int spinfi_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL2_D8,
-	CLK_TOP_UNIVPLL3_D4,
-	CLK_TOP_SYSPLL1_D8,
-	CLK_TOP_SYSPLL4_D2,
-	CLK_TOP_SYSPLL2_D4,
-	CLK_TOP_UNIVPLL2_D4,
-	CLK_TOP_UNIVPLL3_D2
-};
-
-static const int ecc_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_SYSPLL_D5,
-	CLK_TOP_SYSPLL_D3,
-	CLK_TOP_UNIVPLL_D3
-};
-
-static const int gcpu_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL_D3,
-	CLK_TOP_SYSPLL_D3,
-	CLK_TOP_UNIVPLL1_D2,
-	CLK_TOP_SYSPLL1_D2,
-	CLK_TOP_UNIVPLL2_D2
+static const struct mtk_parent axi_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL3_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D8),
+	TOP_PARENT(CLK_TOP_SYS_26M_D2),
+	TOP_PARENT(CLK_TOP_CLK32K),
+};
+
+static const struct mtk_parent mem_parents[] = {
+	TOP_PARENT(CLK_TOP_DSPPLL),
+	TOP_PARENT(CLK_TOP_IPPLL),
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D3),
+};
+
+static const struct mtk_parent uart_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D8),
+};
+
+static const struct mtk_parent spi_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL2_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL3_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL4_D2),
+};
+
+static const struct mtk_parent spis_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D3),
+	TOP_PARENT(CLK_TOP_SYSPLL_D3),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL4_D2),
+};
+
+static const struct mtk_parent msdc50_0_hc_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL2_D2),
+};
+
+static const struct mtk_parent msdc50_0_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_MSDCPLL_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL2_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL2_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D8),
+};
+
+static const struct mtk_parent msdc50_2_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_MSDCPLL),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D3),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL2_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D4),
+};
+
+static const struct mtk_parent audio_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D8),
+	TOP_PARENT(CLK_TOP_APLL1_D4),
+	TOP_PARENT(CLK_TOP_APLL2_D4),
+};
+
+static const struct mtk_parent aud_intbus_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL3_D2),
+	TOP_PARENT(CLK_TOP_APLL2_D8),
+	TOP_PARENT(CLK_TOP_SYS_26M_D2),
+	TOP_PARENT(CLK_TOP_APLL1_D8),
+	TOP_PARENT(CLK_TOP_UNIVPLL3_D4),
+};
+
+static const struct mtk_parent hapll1_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_APLL1),
+	TOP_PARENT(CLK_TOP_APLL1_D2),
+	TOP_PARENT(CLK_TOP_APLL1_D3),
+	TOP_PARENT(CLK_TOP_APLL1_D4),
+	TOP_PARENT(CLK_TOP_APLL1_D8),
+	TOP_PARENT(CLK_TOP_APLL1_D16),
+	TOP_PARENT(CLK_TOP_SYS_26M_D2),
+};
+
+static const struct mtk_parent hapll2_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_APLL2),
+	TOP_PARENT(CLK_TOP_APLL2_D2),
+	TOP_PARENT(CLK_TOP_APLL2_D3),
+	TOP_PARENT(CLK_TOP_APLL2_D4),
+	TOP_PARENT(CLK_TOP_APLL2_D8),
+	TOP_PARENT(CLK_TOP_APLL2_D16),
+	TOP_PARENT(CLK_TOP_SYS_26M_D2),
+};
+
+static const struct mtk_parent asm_l_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL_D5),
+};
+
+static const struct mtk_parent aud_spdif_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D2),
+	TOP_PARENT(CLK_TOP_DSPPLL),
+};
+
+static const struct mtk_parent aud_1_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_APLL1),
+};
+
+static const struct mtk_parent aud_2_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_APLL2),
+};
+
+static const struct mtk_parent ssusb_sys_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL3_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL3_D2),
+};
+
+static const struct mtk_parent spm_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D8),
+};
+
+static const struct mtk_parent i2c_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_SYS_26M_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL3_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL3_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D8),
+	TOP_PARENT(CLK_TOP_SYSPLL2_D8),
+	TOP_PARENT(CLK_TOP_CLK32K),
+};
+
+static const struct mtk_parent pwm_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL3_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D8),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D4),
+	TOP_PARENT(CLK_TOP_SYS_26M_D2),
+	TOP_PARENT(CLK_TOP_CLK32K),
+};
+
+static const struct mtk_parent dsp_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_DSPPLL),
+	TOP_PARENT(CLK_TOP_DSPPLL_D2),
+	TOP_PARENT(CLK_TOP_DSPPLL_D4),
+	TOP_PARENT(CLK_TOP_DSPPLL_D8),
+	TOP_PARENT(CLK_TOP_APLL2_D4),
+	TOP_PARENT(CLK_TOP_SYS_26M_D2),
+	TOP_PARENT(CLK_TOP_CLK32K),
+};
+
+static const struct mtk_parent nfi2x_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_SYSPLL2_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL_D7),
+	TOP_PARENT(CLK_TOP_SYSPLL_D3),
+	TOP_PARENT(CLK_TOP_SYSPLL2_D4),
+	TOP_PARENT(CLK_TOP_MSDCPLL_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5),
+};
+
+static const struct mtk_parent spinfi_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D8),
+	TOP_PARENT(CLK_TOP_UNIVPLL3_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D8),
+	TOP_PARENT(CLK_TOP_SYSPLL4_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL2_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL3_D2),
+};
+
+static const struct mtk_parent ecc_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_SYSPLL_D5),
+	TOP_PARENT(CLK_TOP_SYSPLL_D3),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D3),
+};
+
+static const struct mtk_parent gcpu_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D3),
+	TOP_PARENT(CLK_TOP_SYSPLL_D3),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D2),
 };
 
-static const int gcpu_cpm_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL2_D2,
-	CLK_TOP_SYSPLL2_D2,
-	CLK_TOP_UNIVPLL1_D4
+static const struct mtk_parent gcpu_cpm_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL2_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D4),
 };
 
-static const int mbist_diag_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_SYS_26M_D2
-};
-
-static const int ip0_nna_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_DSPPLL,
-	CLK_TOP_DSPPLL_D2,
-	CLK_TOP_DSPPLL_D4,
-	CLK_TOP_IPPLL,
-	CLK_TOP_SYS_26M_D2,
-	CLK_TOP_IPPLL_D2,
-	CLK_TOP_MSDCPLL_D2
-};
-
-static const int ip2_wfst_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL_D3,
-	CLK_TOP_UNIVPLL1_D2,
-	CLK_TOP_UNIVPLL2_D2,
-	CLK_TOP_IPPLL,
-	CLK_TOP_IPPLL_D2,
-	CLK_TOP_SYS_26M_D2,
-	CLK_TOP_MSDCPLL
-};
-
-static const int sflash_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_SYSPLL1_D16,
-	CLK_TOP_SYSPLL2_D8,
-	CLK_TOP_SYSPLL3_D4,
-	CLK_TOP_UNIVPLL3_D4,
-	CLK_TOP_UNIVPLL1_D8,
-	CLK_TOP_USB20_192M_D2,
-	CLK_TOP_UNIVPLL2_D4
-};
-
-static const int sram_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_DSPPLL,
-	CLK_TOP_UNIVPLL_D3,
-	CLK_TOP_SYSPLL1_D2,
-	CLK_TOP_APLL1,
-	CLK_TOP_APLL2,
-	CLK_TOP_SYSPLL1_D4,
-	CLK_TOP_SYS_26M_D2
-};
-
-static const int mm_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_SYSPLL_D3,
-	CLK_TOP_SYSPLL1_D2,
-	CLK_TOP_SYSPLL_D5,
-	CLK_TOP_SYSPLL1_D4,
-	CLK_TOP_UNIVPLL_D5,
-	CLK_TOP_UNIVPLL1_D2,
-	CLK_TOP_UNIVPLL_D3
-};
-
-static const int dpi0_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_TCONPLL_D2,
-	CLK_TOP_TCONPLL_D4,
-	CLK_TOP_TCONPLL_D8,
-	CLK_TOP_TCONPLL_D16,
-	CLK_TOP_TCONPLL_D32,
-	CLK_TOP_TCONPLL_D64
-};
+static const struct mtk_parent mbist_diag_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_SYS_26M_D2),
+};
+
+static const struct mtk_parent ip0_nna_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_DSPPLL),
+	TOP_PARENT(CLK_TOP_DSPPLL_D2),
+	TOP_PARENT(CLK_TOP_DSPPLL_D4),
+	TOP_PARENT(CLK_TOP_IPPLL),
+	TOP_PARENT(CLK_TOP_SYS_26M_D2),
+	TOP_PARENT(CLK_TOP_IPPLL_D2),
+	TOP_PARENT(CLK_TOP_MSDCPLL_D2),
+};
+
+static const struct mtk_parent ip2_wfst_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D3),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D2),
+	TOP_PARENT(CLK_TOP_IPPLL),
+	TOP_PARENT(CLK_TOP_IPPLL_D2),
+	TOP_PARENT(CLK_TOP_SYS_26M_D2),
+	TOP_PARENT(CLK_TOP_MSDCPLL),
+};
+
+static const struct mtk_parent sflash_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D16),
+	TOP_PARENT(CLK_TOP_SYSPLL2_D8),
+	TOP_PARENT(CLK_TOP_SYSPLL3_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL3_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D8),
+	TOP_PARENT(CLK_TOP_USB20_192M_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D4),
+};
+
+static const struct mtk_parent sram_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_DSPPLL),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D3),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D2),
+	TOP_PARENT(CLK_TOP_APLL1),
+	TOP_PARENT(CLK_TOP_APLL2),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D4),
+	TOP_PARENT(CLK_TOP_SYS_26M_D2),
+};
+
+static const struct mtk_parent mm_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_SYSPLL_D3),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL_D5),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D3),
+};
+
+static const struct mtk_parent dpi0_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_TCONPLL_D2),
+	TOP_PARENT(CLK_TOP_TCONPLL_D4),
+	TOP_PARENT(CLK_TOP_TCONPLL_D8),
+	TOP_PARENT(CLK_TOP_TCONPLL_D16),
+	TOP_PARENT(CLK_TOP_TCONPLL_D32),
+	TOP_PARENT(CLK_TOP_TCONPLL_D64),
+};
 
-static const int dbg_atclk_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL1_D2,
-	CLK_TOP_UNIVPLL_D5
+static const struct mtk_parent dbg_atclk_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5),
 };
 
-static const int occ_104m_parents[] = {
-	CLK_TOP_UNIVPLL2_D4,
-	CLK_TOP_UNIVPLL2_D8
+static const struct mtk_parent occ_104m_parents[] = {
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D8),
 };
 
-static const int occ_68m_parents[] = {
-	CLK_TOP_SYSPLL1_D8,
-	CLK_TOP_UNIVPLL2_D8
-};
+static const struct mtk_parent occ_68m_parents[] = {
+	TOP_PARENT(CLK_TOP_SYSPLL1_D8),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D8),
+};
 
-static const int occ_182m_parents[] = {
-	CLK_TOP_SYSPLL2_D2,
-	CLK_TOP_UNIVPLL1_D4,
-	CLK_TOP_UNIVPLL2_D8
+static const struct mtk_parent occ_182m_parents[] = {
+	TOP_PARENT(CLK_TOP_SYSPLL2_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D8),
 };
 
 static const struct mtk_composite top_muxes[] = {
 	/* CLK_CFG_0 */
-	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_AXI_SEL, axi_parents,
+	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_AXI_SEL, axi_parents,
 			      0x040, 0x044, 0x048, 0, 3, 7,
 			      0x4, 0, CLK_MUX_SETCLR_UPD),
-	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_MEM_SEL, mem_parents,
+	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_MEM_SEL, mem_parents,
 			      0x040, 0x044, 0x048, 8, 2, 15,
 			      0x4, 1, CLK_MUX_SETCLR_UPD),
-	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_UART_SEL, uart_parents,
+	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_UART_SEL, uart_parents,
 			      0x040, 0x044, 0x048, 16, 1, 23,
 			      0x4, 2, CLK_MUX_SETCLR_UPD),
-	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_SPI_SEL, spi_parents,
+	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_SPI_SEL, spi_parents,
 			      0x040, 0x044, 0x048, 24, 3, 31,
 			      0x4, 3, CLK_MUX_SETCLR_UPD),
 	/* CLK_CFG_1 */
-	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_SPIS_SEL, spis_parents,
+	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_SPIS_SEL, spis_parents,
 			      0x050, 0x054, 0x058, 0, 3, 7,
 			      0x4, 4, CLK_MUX_SETCLR_UPD),
-	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_MSDC50_0_HC_SEL, msdc50_0_hc_parents,
+	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_MSDC50_0_HC_SEL, msdc50_0_hc_parents,
 			      0x050, 0x054, 0x058, 8, 2, 15,
 			      0x4, 5, CLK_MUX_SETCLR_UPD),
-	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_MSDC2_2_HC_SEL, msdc50_0_hc_parents,
+	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_MSDC2_2_HC_SEL, msdc50_0_hc_parents,
 			      0x050, 0x054, 0x058, 16, 2, 23,
 			      0x4, 6, CLK_MUX_SETCLR_UPD),
-	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_MSDC50_0_SEL, msdc50_0_parents,
+	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_MSDC50_0_SEL, msdc50_0_parents,
 			      0x050, 0x054, 0x058, 24, 3, 31,
 			      0x4, 7, CLK_MUX_SETCLR_UPD),
 	/* CLK_CFG_2 */
-	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_MSDC50_2_SEL, msdc50_2_parents,
+	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_MSDC50_2_SEL, msdc50_2_parents,
 			      0x060, 0x064, 0x068, 0, 3, 7,
 			      0x4, 8, CLK_MUX_SETCLR_UPD),
-	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_MSDC30_1_SEL, msdc50_0_parents,
+	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_MSDC30_1_SEL, msdc50_0_parents,
 			      0x060, 0x064, 0x068, 8, 3, 15,
 			      0x4, 9, CLK_MUX_SETCLR_UPD),
-	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_AUDIO_SEL, audio_parents,
+	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_AUDIO_SEL, audio_parents,
 			      0x060, 0x064, 0x068, 16, 2, 23,
 			      0x4, 10, CLK_MUX_SETCLR_UPD),
-	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_AUD_INTBUS_SEL, aud_intbus_parents,
+	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_AUD_INTBUS_SEL, aud_intbus_parents,
 			      0x060, 0x064, 0x068, 24, 3, 31,
 			      0x4, 11, CLK_MUX_SETCLR_UPD),
 	/* CLK_CFG_3 */
-	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_HAPLL1_SEL, hapll1_parents,
+	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_HAPLL1_SEL, hapll1_parents,
 			      0x070, 0x074, 0x078, 0, 3, 7,
 			      0x4, 12, CLK_MUX_SETCLR_UPD),
-	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_HAPLL2_SEL, hapll2_parents,
+	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_HAPLL2_SEL, hapll2_parents,
 			      0x070, 0x074, 0x078, 8, 3, 15,
 			      0x4, 13, CLK_MUX_SETCLR_UPD),
-	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_A2SYS_SEL, hapll1_parents,
+	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_A2SYS_SEL, hapll1_parents,
 			      0x070, 0x074, 0x078, 16, 3, 23,
 			      0x4, 14, CLK_MUX_SETCLR_UPD),
-	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_A1SYS_SEL, hapll2_parents,
+	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_A1SYS_SEL, hapll2_parents,
 			      0x070, 0x074, 0x078, 24, 3, 31,
 			      0x4, 15, CLK_MUX_SETCLR_UPD),
 	/* CLK_CFG_4 */
-	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_ASM_L_SEL, asm_l_parents,
+	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_ASM_L_SEL, asm_l_parents,
 			      0x080, 0x084, 0x088, 0, 2, 7,
 			      0x4, 16, CLK_MUX_SETCLR_UPD),
-	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_ASM_M_SEL, asm_l_parents,
+	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_ASM_M_SEL, asm_l_parents,
 			      0x080, 0x084, 0x088, 8, 2, 15,
 			      0x4, 17, CLK_MUX_SETCLR_UPD),
-	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_ASM_H_SEL, asm_l_parents,
+	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_ASM_H_SEL, asm_l_parents,
 			      0x080, 0x084, 0x088, 16, 2, 23,
 			      0x4, 18, CLK_MUX_SETCLR_UPD),
-	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_AUD_SPDIF_SEL, aud_spdif_parents,
+	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_AUD_SPDIF_SEL, aud_spdif_parents,
 			      0x080, 0x084, 0x088, 24, 2, 31,
 			      0x4, 19, CLK_MUX_SETCLR_UPD),
 	/* CLK_CFG_5 */
-	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_AUD_1_SEL, aud_1_parents,
+	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_AUD_1_SEL, aud_1_parents,
 			      0x090, 0x094, 0x098, 0, 1, 7,
 			      0x4, 20, CLK_MUX_SETCLR_UPD),
-	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_AUD_2_SEL, aud_2_parents,
+	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_AUD_2_SEL, aud_2_parents,
 			      0x090, 0x094, 0x098, 8, 1, 15,
 			      0x4, 21, CLK_MUX_SETCLR_UPD),
-	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_SSUSB_SYS_SEL, ssusb_sys_parents,
+	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_SSUSB_SYS_SEL, ssusb_sys_parents,
 			      0x090, 0x094, 0x098, 16, 2, 23,
 			      0x4, 22, CLK_MUX_SETCLR_UPD),
-	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_SSUSB_XHCI_SEL, ssusb_sys_parents,
+	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_SSUSB_XHCI_SEL, ssusb_sys_parents,
 			      0x090, 0x094, 0x098, 24, 2, 31,
 			      0x4, 23, CLK_MUX_SETCLR_UPD),
 	/* CLK_CFG_6 */
-	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_SPM_SEL, spm_parents,
+	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_SPM_SEL, spm_parents,
 			      0x0a0, 0x0a4, 0x0a8, 0, 1, 7,
 			      0x4, 24, CLK_MUX_SETCLR_UPD),
-	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_I2C_SEL, i2c_parents,
+	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_I2C_SEL, i2c_parents,
 			      0x0a0, 0x0a4, 0x0a8, 8, 3, 15,
 			      0x4, 25, CLK_MUX_SETCLR_UPD),
-	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_PWM_SEL, pwm_parents,
+	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_PWM_SEL, pwm_parents,
 			      0x0a0, 0x0a4, 0x0a8, 16, 3, 23,
 			      0x4, 26, CLK_MUX_SETCLR_UPD),
-	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_DSP_SEL, dsp_parents,
+	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_DSP_SEL, dsp_parents,
 			      0x0a0, 0x0a4, 0x0a8, 24, 3, 31,
 			      0x4, 27, CLK_MUX_SETCLR_UPD),
 	/* CLK_CFG_7 */
-	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_NFI2X_SEL, nfi2x_parents,
+	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_NFI2X_SEL, nfi2x_parents,
 			      0x0b0, 0x0b4, 0x0b8, 0, 3, 7,
 			      0x4, 28, CLK_MUX_SETCLR_UPD),
-	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_SPINFI_SEL, spinfi_parents,
+	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_SPINFI_SEL, spinfi_parents,
 			      0x0b0, 0x0b4, 0x0b8, 8, 3, 15,
 			      0x4, 29, CLK_MUX_SETCLR_UPD),
-	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_ECC_SEL, ecc_parents,
+	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_ECC_SEL, ecc_parents,
 			      0x0b0, 0x0b4, 0x0b8, 16, 2, 23,
 			      0x4, 30, CLK_MUX_SETCLR_UPD),
-	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_GCPU_SEL, gcpu_parents,
+	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_GCPU_SEL, gcpu_parents,
 			      0x0b0, 0x0b4, 0x0b8, 24, 3, 31,
 			      0x4, 31, CLK_MUX_SETCLR_UPD),
 	/* CLK_CFG_8 */
-	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_GCPU_CPM_SEL, gcpu_cpm_parents,
+	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_GCPU_CPM_SEL, gcpu_cpm_parents,
 			      0x0c0, 0x0c4, 0x0c8, 0, 2, 7,
 			      0x8, 0, CLK_MUX_SETCLR_UPD),
-	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_MBIST_DIAG_SEL, mbist_diag_parents,
+	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_MBIST_DIAG_SEL, mbist_diag_parents,
 			      0x0c0, 0x0c4, 0x0c8, 8, 1, 15,
 			      0x8, 1, CLK_MUX_SETCLR_UPD),
-	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_IP0_NNA_SEL, ip0_nna_parents,
+	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_IP0_NNA_SEL, ip0_nna_parents,
 			      0x0c0, 0x0c4, 0x0c8, 16, 3, 23,
 			      0x8, 2, CLK_MUX_SETCLR_UPD),
-	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_IP1_NNA_SEL, ip0_nna_parents,
+	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_IP1_NNA_SEL, ip0_nna_parents,
 			      0x0c0, 0x0c4, 0x0c8, 24, 3, 31,
 			      0x8, 3, CLK_MUX_SETCLR_UPD),
 	/* CLK_CFG_9 */
-	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_IP2_WFST_SEL, ip2_wfst_parents,
+	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_IP2_WFST_SEL, ip2_wfst_parents,
 			      0x0d0, 0x0d4, 0x0d8, 0, 3, 7,
 			      0x8, 4, CLK_MUX_SETCLR_UPD),
-	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_SFLASH_SEL, sflash_parents,
+	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_SFLASH_SEL, sflash_parents,
 			      0x0d0, 0x0d4, 0x0d8, 8, 3, 15,
 			      0x8, 5, CLK_MUX_SETCLR_UPD),
-	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_SRAM_SEL, sram_parents,
+	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_SRAM_SEL, sram_parents,
 			      0x0d0, 0x0d4, 0x0d8, 16, 3, 23,
 			      0x8, 6, CLK_MUX_SETCLR_UPD),
-	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_MM_SEL, mm_parents,
+	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_MM_SEL, mm_parents,
 			      0x0d0, 0x0d4, 0x0d8, 24, 3, 31,
 			      0x8, 7, CLK_MUX_SETCLR_UPD),
 	/* CLK_CFG_10 */
-	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_DPI0_SEL, dpi0_parents,
+	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_DPI0_SEL, dpi0_parents,
 			      0x0e0, 0x0e4, 0x0e8, 0, 3, 7,
 			      0x8, 8, CLK_MUX_SETCLR_UPD),
-	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_DBG_ATCLK_SEL, dbg_atclk_parents,
+	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_DBG_ATCLK_SEL, dbg_atclk_parents,
 			      0x0e0, 0x0e4, 0x0e8, 8, 2, 15,
 			      0x8, 9, CLK_MUX_SETCLR_UPD),
-	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_OCC_104M_SEL, occ_104m_parents,
+	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_OCC_104M_SEL, occ_104m_parents,
 			      0x0e0, 0x0e4, 0x0e8, 16, 1, 23,
 			      0x8, 10, CLK_MUX_SETCLR_UPD),
-	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_OCC_68M_SEL, occ_68m_parents,
+	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_OCC_68M_SEL, occ_68m_parents,
 			      0x0e0, 0x0e4, 0x0e8, 24, 1, 31,
 			      0x8, 11, CLK_MUX_SETCLR_UPD),
 	/* CLK_CFG_11 */
-	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_OCC_182M_SEL, occ_182m_parents,
+	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_OCC_182M_SEL, occ_182m_parents,
 			      0x0ec, 0x0f0, 0x0f4, 0, 2, 7,
 			      0x8, 12, CLK_MUX_SETCLR_UPD),
 };

-- 
2.43.0

