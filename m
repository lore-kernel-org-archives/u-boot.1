Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC285C88E72
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 12:50:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 798F060890;
	Thu, 17 Sep 2026 12:50:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XDw7J2v_wtLe; Thu, 17 Sep 2026 12:50:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B584C608A5
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789649453;
	b=Ov3V4o/z6Rt4l7WJmugED43lCW8XDmWvjAN9fvmTUol2MOgsuEOEuAoKKnozNl5XRzRG
	 7IhFFrii940ibYVVlrOxIZ/ZV9va+uyIcSZMyjRoQ4qHkn0J/9Rh5BUb6SNHVIKrv2cfJ
	 eZ0mvZ9nAgt4K22WuqJdtRHPy0lfZyetK1a6RD+xnEN5qPL7lwN5grbJikgt4OBopYxDz
	 CYJtQcXBJqCjAHTdDMb5yqD5SsOeiMH1GkBMqaFUdKvpq0BRiP79pA6vK7P72gd3fbI72
	 Sn0vmgjCtbul5cpdTnMuDn6Jq1Ag2Sops9/GlfEttQ2PFvTvBc3ZlsxSfWfU9wlpamQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789649453;
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
	b=NFOsYr6ANUX508oVG8plG9RDEEjibFJms/7GSaNK8Ulk/tdUOPVcLSrICRgVRhYhjvp4
	 PSK8i1G2EF9ocnZqLj33Gl1nISUuNlL4eyo9FHQmMKTWL0f6gWnOsOi6pAlZOaCKaw2q7
	 pGYC+MI3pGNnmhHRiCXE5f97CPYJupvzf5bSptp7SG4OKr0gVAOg5DwMT/YtpXWIsrSYo
	 mWr+OSYSTaN2Q7v4IXQiTWrOkVD5PyzyaKwx8JTolDN6eXtaPrFOnd8Pok/Q2KgM0Mo/N
	 6lpCUK3LM/H9579R9fu5QQowcq+InyIebgs3aV4qBJiQAyC1Uc0c1/EqTLJR3g2z8sw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789649453;
	bh=5s7W06lDGYCwEECvDwbfKLF9TdUfFZQLiXhcG5yS1mI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MjBZwOkNAuXCJvxb1zXKhkhfIcjNI+7A+fNCOXqoNzecrag3T8UYZaQjvYj8Bacc/
	 IJCNklxis9cCUPueyYYZ5wJcQ++gbbEJra6qnsf01Tn0RmzwIcfPnU+a3mCepCuMgn
	 L826UJaHloZNVbsMyc6pUywBgYYOjsBUORa2PAQQRy/Sj8kaKq4Iy2FlfcNGe5SfAu
	 PWf4OJySwJQH0YcfnTiVQYAOWExFI5o+JEmOZKpbHfij02dKqzKbyt2W++/0vw5DNo
	 TCCXtnP1OggY46guu6UCAxZrU+amlTpszp+WMTQi9PY2eeEDNbrqwrDY0tgpxLklga
	 cPxf2ssNJ/Wfg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B584C608A5;
	Thu, 17 Sep 2026 12:50:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id D112C3AF
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 12:50:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B7BD040346
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 12:50:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6qHvD9YXpnHL for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 12:50:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org A051940355
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789649450;
 b=gWW2s4eb6E5D1GwyARmieHQDpWC2QE9/WA6lSaB/w0QqOBSl+71ar/3oSHSAZP7oIz6r
 258J8H+VlJeg4p2CNKWhgndGJb0MrG7GD4kE9RCLL3InvtUTzhpAxOnv1fQdBRDPZcLiJ
 Z3Yqqyz6SBpu7qvkDTYct+IhU/R29ihkHDTBWWqA+/rR7VOa8/GvfNVfcKW/OZ90F7uvU
 SS+KKbbhYogTZ1IkrjoRPMH+vw+p2aMb3+RR4TNaw4Yqip8qcg0vNVKn/aDT9J7qN/YO8
 2ograQQ3gcNO//UlJv0qQrLyfBf1EO+/7XHhNLF4YFql9AP1yUrzZg1A5K4162oa2Hw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789649450;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=5s7W06lDGYCwEECvDwbfKLF9TdUfFZQLiXhcG5yS1mI=;
 b=jvnXJ7jvXONrSrPH46fvu9aOEUWycvsW1LwR00dSoK2eYF6CX8cfGwtRiQRido3ovP8L
 mZo1tK4cfTmkA8bEivbPzQ5ydJ1JdR9U5+BUfM6E2ru7xeLnG7dYnEHLbrwrIbubrSmoH
 NvvisxY2sq6kvLG5Sc+RCOqE+eZvR9KWiMGztV1fPVViE+cVu8yOGzzZkPmIJLhghQLI2
 gLvdF7QRSKIc7wCapmRgcdPnMhNm9cGAo0T4XI+sXsg4dYVeTEbxVsWzzcbPlchY0CNhG
 GHsfMwd8fZCwFE1VzkVB4jdRLb4OFQ5piPXN3Ab2KMIC1tBgKowtlyi0oicno+mSXBA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=dpNZpYZ3; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=dpNZpYZ3
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A051940355
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 12:50:48 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b965f447cso6864985e9.3
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 05:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1789649447; x=1790254247;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5s7W06lDGYCwEECvDwbfKLF9TdUfFZQLiXhcG5yS1mI=;
 b=dpNZpYZ3kXksMDika0iYl3NYNS3t884OjXvuMwIa+5Wfkt7YsDXH0P7Qc2vNKXisE7
 VBSnhqD0ovgJeqRZ5IcnThM7Ndra4iiUOW9hNLIDV2SaOCFQ8w6029vHXEM0W+m8GpfO
 xZtjL5C2HQD2D2tYoU4IIo49IruI2u294ShWS063q/nq1i1MI0ia+5/JCqosP/UB8QYQ
 1ZBlGxmqdccQxZUnE6miNkQqkol65NMwHdMSzVdOI1mrqQR10tZEcka469s8mpxfbg5G
 yhoeeeIaVn9vMx0Rr1LrWejZpJAF987X9lb1lkOt54imH/rbiKg5bsdl6ipEVAzrVE3R
 VAQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789649447; x=1790254247;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5s7W06lDGYCwEECvDwbfKLF9TdUfFZQLiXhcG5yS1mI=;
 b=vS+OE9T1Y9I6thbPKjsYNLjMtzjsuJghW5X+YZKt2rEV2OoTbHXqTyzKQyd/xQJcOI
 y7prhqPt0PCXXf/GjaKrCyqePdMFw/GBUY/ozWfUQxxHfrtyCXPMupRh8xHTCtaCLsBd
 p8f4YLejERIXqC07Yc33XLiNQoc1hjSbtuvVmQRiQjNKi0bT6lmD4rtcSXEfHa+VLk2R
 8ZOX9TB7go4zglh5VWK57sy+wmuYJipE0y3EJ1sBlYiTIQHzwLNbXM6htlFQejbezbqJ
 zMfEcgcBucaERwEYqbb5IoObJYe9sRQY/QTv4p0fgkfiwlszUuPx9K/sejTSr253Dz5G
 qsBg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzhMtqG9xSyeXbzqUIKRtLxGmRLHJKe7YilVq/oxu7p5siPU0Yd98GmoV9mzWH0t3YrnVsLCpg=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++k331mnFg0bJnTREXGYSAvF2FiZ2gbfyWQUpUhzPBJgVBRFVfhj
 OVHpsBY9uaYJZ4lkozQzLgeVTi879oX2EHDmRaa+vqhQ4CljZDbmawhUTqNcpBQqlDA=
X-Gm-Gg: AYBFou2ImDj8AezyXNOS8dUfJg3PB6ltjV9Eo0dP1hmvS8Qj2uqfYVCah/Y6uW+kuuh
 v90U3JJphGuMuKRnORRU1JsFL8eazMVxRxBu8aSCjoDaiIyrihrmjPggThhjRZ8F70O6IJ3rp/v
 4Wtv3ZXyeGB1SLJSRaXxjOe2IU1RC7tTdbikxrGuC1fYPMtOXEwOwj7O2lodgaypiMXaO8cvLsf
 7BF2eBM9gU/WwiuTaE6zqN7QWfz78Ap6+HI+qnH59lh7du4lWaeCJ5fqBsAFgwciRsp3KN35Fiv
 94Y28qRQWG8tzMZ9Z+yXxzYhUXM6TL8vW4jsV82w5KJ9njm2SfjVBB2lHtWMO68l3wMgOmlgl/a
 G8T5OYZUMAA59Jui+fr5OI/IiV/3OB2IyrfCeD+36Bf/CbshH6CW0wAJ38ouwrA9GNaB73GHI0/
 7GnnNvPHark4KnBr68kXZnKLyxz8qcxFbDFSkFF8QYd5mYjn017J0Fia5NZlGllWO11CJK7lyqJ
 m24iCGEyG9vceHKwLZL4KgkG42Os7gd+G6aDkBbeA3NdgQqmCF7Gi2rYV7o+MEWloYv9hYXaqI6
 k86C3KRRkM9yA8RfLsucrmyLZke6kepw0eeyVjiajNTTxhN5Fz06t0U=
X-Received: by 2002:a05:600c:698e:b0:493:aa0a:45ad with SMTP id
 5b1f17b1804b1-49eac463710mr72882045e9.2.1789649446956; 
 Thu, 17 Sep 2026 05:50:46 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbd23f4e6sm88614255e9.8.2026.09.17.05.50.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 05:50:46 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 17 Sep 2026 14:51:56 +0200
Subject: [PATCH 01/11] clk: mediatek: mt8188: make the clock trees static
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-clk-mediatek-cleanups-v1-1-4dccf8ed98fc@baylibre.com>
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

