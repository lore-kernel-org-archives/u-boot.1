Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3439EC43458
	for <u-boot@archiver.kernel.org>; Mon,  6 Jul 2026 23:53:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19F7C846B4;
	Tue,  7 Jul 2026 01:53:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="FoZ+3iUZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E26DC84844; Tue,  7 Jul 2026 01:52:59 +0200 (CEST)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86E39801A9
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 01:52:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-4472500e25fso1550152fac.1
 for <u-boot@lists.denx.de>; Mon, 06 Jul 2026 16:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783381976; x=1783986776; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=e/4uh7F+KrAKUeOREwCEF9hlXb+NGKZViXaJtFlJtbk=;
 b=FoZ+3iUZDb1eug2z/oVauVM3qFp0AmQipaAhqmbsHY4yp8e6e7OEAGp3Y7jEz5LZ8T
 sPVifbOE87wptJjR3ZlEeuulKOvY3jwfS/+v9737X9nV18cQTI1IvRPdWoicNw0ux9Pa
 JlTu1qJ9Q3xfpPFiAUpyNhDZt198xpF6hKm8U5XiJnC6/K3EsMmzmHYMZDp6Uvr4RWca
 pszvCw6RDpSPs0UDCosk3W5OMe2qvezBgPEVUuK3E5oQJf4yA+vUn+PInR3gtBpAuOSy
 YbSgd8s4LzgnEQcqAaJOpZ/jyV0cnaTT0oNr3DGCaUNoQ0FY4nxGa5JzVXE+4IYybWtq
 N4nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783381976; x=1783986776;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e/4uh7F+KrAKUeOREwCEF9hlXb+NGKZViXaJtFlJtbk=;
 b=BzEKmPtgu+HKP+eOYmbN4VyYCtOLK2A5JgblmdkBKgZxoDDIs1yyZLL7zuONofQumF
 pfqz5015y9i1NmgB2A7U9y/e9nSD9ULdj80IjJ/fqqgA00xbkhuOwDrI5QWUQzGRrDrF
 QbC9f9kioNQC4+72P6UtlRNttBqxHYMVQRgnrTVHZGHrn11T1gnW23NOdjYoZkJsPr7a
 RxEJfWBQs8Gz/atWHkXB0vjYgTBSk6p6MTcz0Nq37xr61rWkxf7SYURb7I0964QJytFL
 bxDbUSPjPjWwIgIGmSY7aaEN/lzr11kXbq8M7IaEd+HrUWSK4B9trWEO00kVxw2lrqMM
 EmSA==
X-Gm-Message-State: AOJu0Yz9IWpzvYoSxRLKr+3rifc7yqGsyS3R0jnhtH0mYxfDl2Aqqi+L
 2uZNF549N9BjGYK6Zh6SZ+djKOlej17h9N+rDebC0nmX8JkE32x0Xy9dUiv3jX2GAd0=
X-Gm-Gg: AfdE7ckF3kpIOf3CQvTAT/lwvJchR4/zeZiRrcT/PTRXyN8nk4U0SBCeiIOLx1j1/a+
 gIM9F53Y/MPINiExmX05/nOz2wz/AFz+FOynXNNZa3XSlzNLCYspzboA5rfW+9AyIJ1yjI4aRLA
 VkOwRzknTSQlX1gXFvb+UnMp3cjHxA0wFW1XTVb0nIoVYwQ2UIW0zeIOmBfZJfb1H1Ab+ViRMbi
 aPpza6CY4EC1miBT8N7KqudCEYSzgrCCd0dIVvOuAGlm45PM4s2BEPY0UcVp8NzDAeIxyKNbpDV
 jjZ6wkCYwc3nE8DWMsLMRj3hj4KEhHUSrI7EqVJAMad0DkoqKC0SW2glZerIoxDo/FxJP7GM+PK
 4KJxvFJmBCaNW/4++LnNqGGbK29Wb9/0ia9G/kDqcPzhlmpKk/l0Xe9djpaONfLWr3n1M3h4OgH
 TVZNf3imGzLa51W6/LRg==
X-Received: by 2002:a05:6870:d1c6:b0:44c:e350:a0b7 with SMTP id
 586e51a60fabf-451065bf419mr1912336fac.27.1783381975845; 
 Mon, 06 Jul 2026 16:52:55 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:a38a:a0af:ed1d:5c77])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44cfb54f775sm12085603fac.10.2026.07.06.16.52.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 16:52:55 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 06 Jul 2026 18:52:44 -0500
Subject: [PATCH] clk: mediatek: mt8189: fix VLP_CK wrong parents
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-mtk-clk-mt8189-fix-vlp-parent-v1-1-aedc2f8cc69d@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6CMBCF4auQWTtJqSlWr2Jc0DLICNamrcSEc
 HcGWb18ycu/QKbElOFWLZBo5syfIKhPFfihDU9C7sSglW7URTX4LiP6aZS1tb1izz+cp4ixTRQ
 KnrUipx0ZYw1IIyaSx79/fxzOX/ciX/YorOsG//3sj4EAAAA=
X-Change-ID: 20260706-mtk-clk-mt8189-fix-vlp-parent-320eb2be5585
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1547; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=pWZFNkgKPQGsg0tAUH3biRx2kPeV4CLP2CqRyoxdU/8=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqTD/P1UilJC4M09M6pESdn5YsdkXCd6uh1OHzn
 tWvknACJR6JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCakw/zxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AZH4H+wW5b+4NUhM/xIk+7erMhyx62BpwEAyNeaRynWK
 1O6oB+r0LMW57m/Las0EfMmMpfoTYWFT4CR0k018x1YwEzsqWhCXs5/aDOuKqSP/NOF+aUnIGv6
 FDZKW2Q8mNra/nRvOHNEPfspL6kggLbPFL41mGNh5lMkbLoTNSHy6aic19lvFETBuAgl3ovpNQB
 LLF75xkouZ2ZWGBhioJ70wQjR2fMVnI2pMIICRlyLxJF2JlhmfoR6o41UP+UnMF2unY2kCuq2kS
 GTd8P0Vo07cdj8Y54E1JWrqtIi1ImxN38ReHPFW/JkpJN8z+pxEgWYNnvZJ0CNhdQaNflvdrn5k
 ZGV0=
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

Fix a couple of places where we used the wrong macro to set the parent
flag for vlpcfg_ao_clks.

Fixes: 04b3a834c654 ("clk: mediatek: mt8189: add some VLP clocks")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8189.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8189.c b/drivers/clk/mediatek/clk-mt8189.c
index d11947ee461..b174e259f28 100644
--- a/drivers/clk/mediatek/clk-mt8189.c
+++ b/drivers/clk/mediatek/clk-mt8189.c
@@ -1915,8 +1915,8 @@ static const struct mtk_gate vlpcfg_ao_clks[] = {
 	GATE_VLPCFG_AO_VLP(CLK_VLPCFG_REG_SCP, CLK_VLP_CK_SCP_SEL, 28),
 	GATE_VLPCFG_AO_EXT(CLK_VLPCFG_REG_RG_R_APXGPT_26M, CLK_PAD_CLK26M, 24),
 	GATE_VLPCFG_AO_EXT(CLK_VLPCFG_REG_DPMSRCK_TEST, CLK_PAD_CLK26M, 23),
-	GATE_VLPCFG_AO_VLP(CLK_VLPCFG_REG_RG_DPMSRRTC_TEST, CLK_PAD_CLK32K, 22),
-	GATE_VLPCFG_AO_VLP(CLK_VLPCFG_REG_DPMSRULP_TEST, CLK_TOP_OSC_D10, 21),
+	GATE_VLPCFG_AO_EXT(CLK_VLPCFG_REG_RG_DPMSRRTC_TEST, CLK_PAD_CLK32K, 22),
+	GATE_VLPCFG_AO_TOP(CLK_VLPCFG_REG_DPMSRULP_TEST, CLK_TOP_OSC_D10, 21),
 	GATE_VLPCFG_AO_VLP(CLK_VLPCFG_REG_SPMI_P_MST, CLK_VLP_CK_SPMI_P_MST_SEL, 20),
 	GATE_VLPCFG_AO_EXT(CLK_VLPCFG_REG_SPMI_P_MST_32K, CLK_PAD_CLK32K, 18),
 	GATE_VLPCFG_AO_VLP(CLK_VLPCFG_REG_PMIF_SPMI_P_SYS, CLK_VLP_CK_PWRAP_ULPOSC_SEL, 13),

---
base-commit: 861858fd3a984cbdd1c7a39c6a4b126f814dbe6d
change-id: 20260706-mtk-clk-mt8189-fix-vlp-parent-320eb2be5585

Best regards,
--  
David Lechner <dlechner@baylibre.com>

