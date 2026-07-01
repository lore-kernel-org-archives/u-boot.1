Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 262ADC43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 15:12:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9291C84BC9;
	Wed,  1 Jul 2026 17:12:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="i43FRT/I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3F0584BFB; Wed,  1 Jul 2026 17:12:53 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1706084B53
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 17:12:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-47231f1f8f3so969430f8f.1
 for <u-boot@lists.denx.de>; Wed, 01 Jul 2026 08:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1782918771; x=1783523571; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=UGNIOl/sPWnSRlU0g/kIJykYLZOpy4k1m+IXANQF27c=;
 b=i43FRT/IkEfEQyHdVYdwnK3iAsoyCMkCtbLJY+SkfwSnUYdbHX0TbI7eAa5YGjl8Ab
 Z+l597cliLuZVeM2LB/IWjmaYdp5cXKFKdPRWOyB+nV38im4L1HEzfzzyMqAFqDVuU9R
 4DWJmvhcMXxshUHbPEIAIf/7OGah+wR1fUFtC9JuIKCNAXN/Ry+3aXpAxxqLaHd6yFqs
 X9jDm/k/wopVE4NyMHN0eg4IuV0oMuVCrNjQ/C3nXx3sG/1S4MySUFSPDxRYRM9KFibj
 fvJvJiXBpF3XPQFM/NgJTTfyBeuy6oBP24MbvzpIsPSUEyLmqKj3Z6d70OPTk1+dVvej
 hK1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782918771; x=1783523571;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=UGNIOl/sPWnSRlU0g/kIJykYLZOpy4k1m+IXANQF27c=;
 b=MnKD4SVBYetpqF0OoclLzjs66gmOimaY1cQ0yzdRR4G0meI6nnhWpMLrviIAZNoMEg
 lFKT+GvSsAoFi5nG9ZPIIb2LBG7A4R6OdueaY2ACq+mDKQRfh2DorlooKsyuICtwTG05
 EaP9QidsN6t3HnedbT/RW97j1D8EBDXd+MAWdftKvfSBx4vIRFf+DFs72Wd5k9Zix7Ry
 Cn1eFhfHRjo1J/lwPlmE9vVXNziLQX/H2Hxp7ASFnEksl4ZS22afcz8db/Id4JtBees0
 FQI6QOUyU3Ywl1cYVW0WhCvtQK40ie3eQuF3q1LrGcEc6mEFx+WTzMbtn2RXs70V3MhO
 Oe5w==
X-Gm-Message-State: AOJu0YyGnXYuz8mB/iCktD9h+d3/xXfeUHa8FiWQgvMUR6Zx9igqNEB4
 6TEbnI4+WIJfn3MS/IHXipS7EDP/XDNR+LrRKgpzPsHS2nsYNbvm+G6TjtmgHCQujpc=
X-Gm-Gg: AfdE7ckPWelYPnUklfuIRnZ+Ah4rKRtorynQRQ7EWlITVZUXCCgurezDSbVen3nkKH2
 syq9RMtvFdUH2L3mU6uLLqjAQmPjoQkOm8kL3UgeGFCIrg5uKaFLuVaUnDXlEYTICj2sOvpzzKf
 x9UNSFZd4edj75kIkGeYiv/X0Tq11OxT24mx7V3NkJkMEvQR8okGDWG/8xr5tXXBTQQ1t4DMhma
 L5F/Ptmfxzft5XyNUmWpTLzf5yYy53cIa+E1Hw4I6Bo62EQ8UEOuyR5rtBQJEV5H6+nO2y1ia1w
 GJTv5j3hifPQiipziFH0CmcE4RLO/Mj4xUU7leV6skKcFg7xdJSiWhO8ksBuSGSTRCrkOOR6TMg
 clYT0VJ106ZJ6aC4sX7bQWxxoJO7LqgJNwLTZxzXc9Q2URpO/rDyu6+W1Oq0ApN8eiLcnM/AV6K
 uFE68BXYF83CUgtLZJyvw0Ba8rtuBUwWDsqe8x16QEc0kyVIRzHuHmrTo2QTGHTqv/+XMa2lMGi
 PPB9XeFU0D4vxKIDnZBtMDVXTEvYC9EXgDoR0GuTbC648G4+yiJ2e/Yb5sJmiAOegbtCvw=
X-Received: by 2002:a05:600d:109:b0:493:bb29:af40 with SMTP id
 5b1f17b1804b1-493c3cd7101mr14370835e9.14.1782918771453; 
 Wed, 01 Jul 2026 08:12:51 -0700 (PDT)
Received: from [192.168.1.65]
 (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net.
 [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493be45f244sm94622405e9.0.2026.07.01.08.12.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 08:12:51 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 01 Jul 2026 17:13:00 +0200
Subject: [PATCH] clk: mediatek: mt8188: add missing clock in pericfg_ao
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-mt8188-clk-add-missing-clock-in-pericfg-ao-v1-1-13109b199248@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNQQ7CIBBA0as0s3YShoUQr2Jc4DDFsRYaqMak6
 d1FXb7N/xs0qSoNTsMGVV7atOQOOgzAt5CToMZusMYejTOE8+rJe+THhCFGnLU1zam78ISacek
 9HhOGguyCUDDsiCz04FJl1Pdvdr783Z7Xu/D6PcC+fwD+nU/zjgAAAA==
X-Change-ID: 20260701-mt8188-clk-add-missing-clock-in-pericfg-ao-c7ae1a0c7112
To: u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Julien Masson <jmasson@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.15.2
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

Add CLK_PERI_AO_PCIE_P0_FMEM clock in pericfg_ao.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8188.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/mediatek/clk-mt8188.c b/drivers/clk/mediatek/clk-mt8188.c
index 3e413e111f1..b82a6ab5452 100644
--- a/drivers/clk/mediatek/clk-mt8188.c
+++ b/drivers/clk/mediatek/clk-mt8188.c
@@ -1657,6 +1657,7 @@ static const struct mtk_gate pericfg_ao_clks[] = {
 	GATE_PERI_AO(CLK_PERI_AO_SSUSB_BUS, CLK_TOP_USB_TOP, 13),
 	GATE_PERI_AO(CLK_PERI_AO_SSUSB_XHCI, CLK_TOP_SSUSB_XHCI, 14),
 	GATE_PERI_AO(CLK_PERI_AO_ETHERNET_MAC, CLK_TOP_SNPS_ETH_250M, 16),
+	GATE_PERI_AO(CLK_PERI_AO_PCIE_P0_FMEM, CLK_TOP_466M_FMEM, 24),
 };
 
 static const struct mtk_clk_tree mt8188_pericfg_ao_clk_tree = {

---
base-commit: 6f096061d08da9255dd5fa91e5b5a787856b53ac
change-id: 20260701-mt8188-clk-add-missing-clock-in-pericfg-ao-c7ae1a0c7112

Best regards,
--  
Julien Stephan <jstephan@baylibre.com>

