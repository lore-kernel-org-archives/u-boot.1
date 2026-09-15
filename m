Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B607DC88E75
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 15:00:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BC60D80BE7;
	Tue, 15 Sep 2026 15:00:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9m34UT0OpUu4; Tue, 15 Sep 2026 15:00:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 6D30A80BEA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789484416;
	b=Dtw7UC4d9ZtPZOIR5JBpiMKblwx1PKlxGma0vOL4HD4Q2LrWFo937pzHsH5Ysgs5pvLl
	 8UJ4xaN75YzQeMFH5bBpz0pU6EsxbMcwrRQti22af0nlD5BuevUhHhnjUDBFUcJf9nKns
	 t2vkICjKRhNbWwzpeYrAE7woPeJx4zC+1JTys6Hc1LksjndjhqvWrBsfEvxXVveF4QPvq
	 CXOzrPrm3Bh3HtmT42FyFg5XctkKlUbJWdunVa4nnX/1wTjhtWv3Bl+2X5jadMQG2lvFX
	 BP/ZNsfzIMdcmkOJya030ne3985GTlL6gnL7KGTASQTW36Qd9cZV1hypv5iO82YAgAg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789484416;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=40RGptQ8bQ7z1CJbLmtJx2wwxL6djJDb4G7uHnWh96A=;
	b=b45HzQHEMDh2ofaLXKoKAqGoY5FTYM01X/D8JDk4z+yJtIWEg1ci41Qh+ctm7A7lx46R
	 tsq6MFy0j4XECHFGGL258oPDWd9I4p+B8dYQnt0fqJ/7ocoFtLbZbR+yeOS1VPlgNsyBd
	 LouGNAafbF6JENxTDPGazj98/LX/MzEw6kbet1O5zapvSaFXAu+VlGiaI/xULzQqp5RCV
	 YGsE32rJ07/TqRbb/5WucaZe0g4YKhsLOY7kCZ6GFGOUIm7IIVBcTtwXuq5ke9WM7iWzR
	 w57E2gLsAAlBwyEDgGqMGelHlVoxzR3Lz6vIzAiLqDFpTHYfQ59RXEz29ExYBZg6nNA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=DTRYnUyX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789484416;
	bh=40RGptQ8bQ7z1CJbLmtJx2wwxL6djJDb4G7uHnWh96A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jla3kEw1ibJZCp73+moaDM2HqYvCb10PT3+datWZGZG7BL2N1CsnEKVAsX8CdjVU7
	 fyBN34dPqsJkzD1CuyFfarOh2hE4E8JPIh4OyosvyAfu5E9kdDdZcMWU8Wl7bKfj43
	 QTGtjURF1h2gY39saL8Poz8v09egi1RkOjvTX5sC+xcHd5JJ7GfaCb70KuFTTLSwjw
	 huceTsP/cszr8c3fEh/5e/TCTMtC6QSUsWr8p/ZmYLrljMXkr5i3RYiY+dWkkGn3iN
	 OeMMq2noQ32iXtlIW4TghJmCNCwnTaESo2R1m9HWeHpoq0ngWstY2aq2CGz/N708vl
	 tTdbVMA9RdGyg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6D30A80BEA;
	Tue, 15 Sep 2026 15:00:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 69370EB
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 15:00:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4248580A66
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 15:00:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XuAoJQMTlvsB for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 15:00:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 89FE4808AE
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789484409;
 b=Ijx3MfyDrWNdsg6RIYnZLe0yXS7ZrAuypTnLRX4Nwuu7jlOsFu+ZUVyUg/1P887jPfEW
 zHU9hnaDVJgXkUxb+fHxGpDPOIST70tNhRIw/JybV+lOyKZ1Dig4nYwA0qHMZQRbicbN/
 F7U28thW1YCBh6awvGZbi08BGTrS/ddHzrh8zTQwoXzbtqVoLr8ij94j2v0QJMU5xmMSg
 BzwOdcSJ9fjfRg4tUJfaTPMUGWKMWF26+Q71lKln6tBn8sb2SVlYIEtpSITOTgpAjmgSq
 6x49/tqlQwTIZr29BwZlveXN0o7+Hq3jk9+DdF/XONGvCBHAJs6lV87esY5j2tiVZAg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789484409;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=40RGptQ8bQ7z1CJbLmtJx2wwxL6djJDb4G7uHnWh96A=;
 b=NxgDnAs/uFmocontqB5DVgRm0ygbEz7CU8tExtWzU4QPFDk8XTkONXsYZzQJBJ8pP28H
 45e8iRN2Rrpe14zMIe29DCqmwjWXgfuPrQ+I3vuf2AK0+Q6WRgfyfO0odGiQv9hw0Vlr/
 Oed6W+x/kNb8xkQ31oW3UBGSMh6OnjCMig7Bun0XbanI/Ou+hwi15gyKhfHn/8fnFggh3
 ULbQrj2v64w1j6aQCiUv37//38AZnSSUomoM1Dijtvrh1uji+p3QDPz+jMuvwvD7jOkHH
 oA6Dd8DHqPs4MQA8GZ6vL/fug2E/eBe3FlcC9imNLF3zpP88lp6PF4RCugP5dOsLdbw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=DTRYnUyX; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=DTRYnUyX
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 89FE4808AE
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 15:00:08 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49d1ca5b0d6so3080105e9.0
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 08:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1789484406; x=1790089206;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=40RGptQ8bQ7z1CJbLmtJx2wwxL6djJDb4G7uHnWh96A=;
 b=DTRYnUyXqIhibpQ8koCjyoxIYA+V3eqJotLtoRJeFWSPoud5pLvNRJx2yFnujdwX0k
 +RFLCvengtUXJQR7cRN1IBUaw9rWOYDhLNA2wEfxfUysuoBY75QtgJoCtg326PLLNcpf
 1Gw/xnzwgV6Da90xiLvyRkXSa6B5JDNSQUA3dqTQuTxmnJQES7JNsDuknzHZWU3kzyYG
 OacQzpuzsvsFWZexG4t7G2w/ZhA+uGN5JrRmc9sO38AHHuiejfWxd2KuVXuUPvwXPikD
 lj3pLt6vPoO6y5SK6pR+IuZyB/Ke+NcusV9Gyq4x1on5LV66ypAts6b+galZ7wxI1Aon
 T1BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789484406; x=1790089206;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=40RGptQ8bQ7z1CJbLmtJx2wwxL6djJDb4G7uHnWh96A=;
 b=ASRvSD+tI4ZK+cdf1iA4TxBvURiFs0BEU6/iik2ij7amS9bxMy0BUlIKV6lq00F2ke
 sZdJdIwt3bh/XA4dSIZr2Q1L3+B4Wu9gSCWn7K5dzWk+5P6zKkIiIrCPW7o8a+wDpHia
 2IlUkJkWKSZQP1c/cxUjt98ma81tuSGNr7WFe2qW/Qt0KGCAccTIqNAwyf7uel/8sRpx
 cCdeEu+G95HoW1ZwSoVnl3zjow/Gmv9gLsQi7D9vY0Rn+xqbB/Wj1MFiIkBy5S/Bun24
 w105ie7r55zrwfOD4pP2XkZHX9Uj6N9QxvLAgMxiO1kk6JNhexzWJ4zShmirAFktyDx1
 rw0g==
X-Gm-Message-State: AFuF++mMzgc4i+DKBiBeAM4B3G9HRs6QlbnbksLv6YiAHkx9SPyP00Ej
 w6yr3X67MCrSCMyg0K00powPxN8ruYGogxLHl69VDEnagUgyFg/MbweXyeED93gS2Go=
X-Gm-Gg: AYBFou3CkLSR4M30XMrdML4ho4OoSjIMtxbyMVOYJjVobKlYdBDyehwwMWyi83ctM+u
 A+oylahpJrCl01Axa1vNX4mATvup7Otpi5l0rzR70KvQd8mxo3541i7c1te22JROu4iNg7lhIWy
 s7RccjeCHiUkndSQWCMEQ4FMuPJS6Fke3XDixrBbDxBRPpHNpZOdU2XpXehzXJu1zmPqmEsvGq0
 Bj2uOZ4E3TVwKXe0zyDOf+I83VGU0q4AGWvgXRZifMRopJTWWqY6s2fPiGyprscFKDF/spehoI0
 xo6h1A81L8M87orJwHbxzq1iRoAniKT8r5axd6qnZ0ZUa5gzO97ByRh9iRMm5yyMUSIPrzQFnj5
 TXt387e5vK6FZBpfy5Rc8ZrhQWWEYaaCICknm/YuYszQDOYZye7/1LinDCBv/77XV1mvSNW5r/P
 NTs+7oZuxMxw1PoqHILjtFzYzhwNUzG3EHBWotUJfnurpgalboMwg/8j8Mgjvjor56XBr70/ZSJ
 DL3P4N6o51M28qRFD06HAzhSTU1QUsCVB+cASVSAgnph0k0I1xXeESSiLTD9hMFgMPifXHuuBJS
 QYy+v1pCopZPhW2R6XF7Z63NisQ8SWC03NPXMKc4FnVUjt40BvxPFy0=
X-Received: by 2002:a05:600c:3b11:b0:49c:fc6e:8cbb with SMTP id
 5b1f17b1804b1-49e822a6cbemr20557525e9.31.1789484405996; 
 Tue, 15 Sep 2026 08:00:05 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e83aeb654sm1538675e9.8.2026.09.15.08.00.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 08:00:05 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 15 Sep 2026 17:00:32 +0200
Subject: [PATCH 3/3] phy: phy-mtk-mipi-dsi: add new driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-mt8365-add-phy-mtk-mipi-dsi-driver-v1-3-83707ed5242a@baylibre.com>
References: <20260915-mt8365-add-phy-mtk-mipi-dsi-driver-v1-0-83707ed5242a@baylibre.com>
In-Reply-To: <20260915-mt8365-add-phy-mtk-mipi-dsi-driver-v1-0-83707ed5242a@baylibre.com>
To: u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Tom Rini <trini@konsulko.com>, David Lechner <dlechner@baylibre.com>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Pavlo Yadvychuk <pyadvychuk@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
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

Add a new driver for the MIPI DSI PHY. The driver supports MT8183
compatible SoCs. The driver is base on the corresponding kernel driver
commit 2ec9c210c1f9 ("phy: mediatek: Add support for MT8196 MIPI DSI PHY")

Few notes about the port from kernel:
- tested on Genio-350 which does not have nvmem-cells, so keep rt_code[]
  zeroed and fallback to 0x210 has kernel does when no cell available.
  Can be implemented later.
- PLL is not registered as a clock provider:
    - configure() = determine_rate+set_rate
    - power_on() = clk_prepare_enable
  configure() takes a struct phy_configure_opts_mipi_dphy and uses its
  hs_clk_rate member, which carries the per-lane data rate the kernel
  would have set on the "hs" clock.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/phy/mediatek/Kconfig                   |  11 ++
 drivers/phy/mediatek/Makefile                  |   1 +
 drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8183.c | 175 +++++++++++++++++++++++++
 drivers/phy/mediatek/phy-mtk-mipi-dsi.c        | 144 ++++++++++++++++++++
 drivers/phy/mediatek/phy-mtk-mipi-dsi.h        |  45 +++++++
 5 files changed, 376 insertions(+)

diff --git a/drivers/phy/mediatek/Kconfig b/drivers/phy/mediatek/Kconfig
index 29a46ea9350..f4049afc43f 100644
--- a/drivers/phy/mediatek/Kconfig
+++ b/drivers/phy/mediatek/Kconfig
@@ -11,6 +11,17 @@ config PHY_MTK_HDMI
 	  MT8188 and MT8195. The PHY provides the TMDS links and the pixel
 	  clock PLL to the HDMI TX controller.
 
+config PHY_MTK_MIPI_DSI
+	bool "MediaTek MIPI-DSI PHY Driver"
+	depends on PHY
+	depends on ARCH_MEDIATEK
+	depends on ARM64
+	depends on CLK
+	help
+	  Support for the MIPI TX D-PHY found on MediaTek SoCs such as the
+	  MT8183 and MT8365. The PHY provides the D-PHY lanes and the byte
+	  clock PLL to the DSI host controller.
+
 config PHY_MTK_TPHY
 	bool "MediaTek T-PHY Driver"
 	depends on PHY
diff --git a/drivers/phy/mediatek/Makefile b/drivers/phy/mediatek/Makefile
index 00ab10a238e..6dedec70edc 100644
--- a/drivers/phy/mediatek/Makefile
+++ b/drivers/phy/mediatek/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 obj-$(CONFIG_PHY_MTK_HDMI) += phy-mtk-hdmi.o phy-mtk-hdmi-mt8195.o
+obj-$(CONFIG_PHY_MTK_MIPI_DSI) += phy-mtk-mipi-dsi.o phy-mtk-mipi-dsi-mt8183.o
 obj-$(CONFIG_PHY_MTK_TPHY) += phy-mtk-tphy.o
 obj-$(CONFIG_PHY_MTK_UFS) += phy-mtk-ufs.o
 obj-$(CONFIG_PHY_MTK_XSPHY) += phy-mtk-xsphy.o
diff --git a/drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8183.c b/drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8183.c
new file mode 100644
index 00000000000..1fce03fcf45
--- /dev/null
+++ b/drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8183.c
@@ -0,0 +1,175 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2019 MediaTek Inc.
+ * Copyright (c) 2026 BayLibre, SAS
+ * Author: Jitao Shi <jitao.shi@mediatek.com>
+ */
+
+#include <dm/device_compat.h>
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/math64.h>
+
+#include "phy-mtk-io.h"
+#include "phy-mtk-mipi-dsi.h"
+
+#define MIPITX_LANE_CON		0x000c
+#define RG_DSI_BG_LPF_EN		BIT(6)
+#define RG_DSI_BG_CORE_EN		BIT(7)
+#define RG_DSI_PAD_TIEL_SEL		BIT(8)
+
+#define MIPITX_VOLTAGE_SEL	0x0010
+#define RG_DSI_HSTX_LDO_REF_SEL		GENMASK(9, 6)
+
+#define MIPITX_PLL_PWR		0x0028
+#define AD_DSI_PLL_SDM_PWR_ON		BIT(0)
+#define AD_DSI_PLL_SDM_ISO_EN		BIT(1)
+
+#define MIPITX_PLL_CON0		0x002c
+
+#define MIPITX_PLL_CON1		0x0030
+#define RG_DSI_PLL_EN			BIT(4)
+#define RG_DSI_PLL_POSDIV		GENMASK(10, 8)
+
+#define MIPITX_PLL_CON4		0x003c
+#define RG_DSI_PLL_IBIAS		GENMASK(11, 10)
+
+#define MIPITX_D2P_RTCODE	0x0100
+#define MIPITX_D2_SW_CTL_EN	0x0144
+#define MIPITX_D0_SW_CTL_EN	0x0244
+
+#define MIPITX_CK_CKMODE_EN	0x0328
+#define DSI_CK_CKMODE_EN		BIT(0)
+
+#define MIPITX_CK_SW_CTL_EN	0x0344
+#define MIPITX_D1_SW_CTL_EN	0x0444
+#define MIPITX_D3_SW_CTL_EN	0x0544
+#define DSI_SW_CTL_EN			BIT(0)
+
+/* Reference clock feeding the PLL, fixed at 26MHz on all supported SoCs. */
+#define MIPITX_PLL_REF_RATE	26000000
+
+#define MIPITX_DATA_RATE_MIN	125000000ULL
+#define MIPITX_DATA_RATE_MAX	1600000000ULL
+
+static u64 mtk_mipi_tx_pll_determine_rate(struct mtk_mipi_tx *mipi_tx, u64 rate)
+{
+	return clamp_val(rate, MIPITX_DATA_RATE_MIN, MIPITX_DATA_RATE_MAX);
+}
+
+static int mtk_mipi_tx_pll_enable(struct mtk_mipi_tx *mipi_tx)
+{
+	void __iomem *base = mipi_tx->regs;
+	unsigned int txdiv, txdiv0;
+	u64 pcw;
+
+	dev_dbg(mipi_tx->dev, "enable: %llu bps\n", mipi_tx->data_rate);
+
+	if (mipi_tx->data_rate >= 2000000000) {
+		txdiv = 1;
+		txdiv0 = 0;
+	} else if (mipi_tx->data_rate >= 1000000000) {
+		txdiv = 2;
+		txdiv0 = 1;
+	} else if (mipi_tx->data_rate >= 500000000) {
+		txdiv = 4;
+		txdiv0 = 2;
+	} else if (mipi_tx->data_rate > 250000000) {
+		txdiv = 8;
+		txdiv0 = 3;
+	} else if (mipi_tx->data_rate >= 125000000) {
+		txdiv = 16;
+		txdiv0 = 4;
+	} else {
+		return -EINVAL;
+	}
+
+	mtk_phy_clear_bits(base + MIPITX_PLL_CON4, RG_DSI_PLL_IBIAS);
+
+	mtk_phy_set_bits(base + MIPITX_PLL_PWR, AD_DSI_PLL_SDM_PWR_ON);
+	mtk_phy_clear_bits(base + MIPITX_PLL_CON1, RG_DSI_PLL_EN);
+	udelay(1);
+	mtk_phy_clear_bits(base + MIPITX_PLL_PWR, AD_DSI_PLL_SDM_ISO_EN);
+	pcw = div_u64(mipi_tx->data_rate * txdiv << 24, MIPITX_PLL_REF_RATE);
+	writel(pcw, base + MIPITX_PLL_CON0);
+	mtk_phy_update_field(base + MIPITX_PLL_CON1, RG_DSI_PLL_POSDIV, txdiv0);
+	mtk_phy_set_bits(base + MIPITX_PLL_CON1, RG_DSI_PLL_EN);
+
+	return 0;
+}
+
+static void mtk_mipi_tx_pll_disable(struct mtk_mipi_tx *mipi_tx)
+{
+	void __iomem *base = mipi_tx->regs;
+
+	mtk_phy_clear_bits(base + MIPITX_PLL_CON1, RG_DSI_PLL_EN);
+
+	mtk_phy_set_bits(base + MIPITX_PLL_PWR, AD_DSI_PLL_SDM_ISO_EN);
+	mtk_phy_clear_bits(base + MIPITX_PLL_PWR, AD_DSI_PLL_SDM_PWR_ON);
+}
+
+static void mtk_mipi_tx_config_calibration_data(struct mtk_mipi_tx *mipi_tx)
+{
+	int i, j;
+
+	for (i = 0; i < 5; i++) {
+		if ((mipi_tx->rt_code[i] & 0x1f) == 0)
+			mipi_tx->rt_code[i] |= 0x10;
+
+		if ((mipi_tx->rt_code[i] >> 5 & 0x1f) == 0)
+			mipi_tx->rt_code[i] |= 0x10 << 5;
+
+		for (j = 0; j < 10; j++)
+			mtk_phy_update_bits(mipi_tx->regs +
+				MIPITX_D2P_RTCODE * (i + 1) + j * 4,
+				1, mipi_tx->rt_code[i] >> j & 1);
+	}
+}
+
+static void mtk_mipi_tx_power_on_signal(struct mtk_mipi_tx *mipi_tx)
+{
+	void __iomem *base = mipi_tx->regs;
+
+	/* BG_LPF_EN / BG_CORE_EN */
+	writel(RG_DSI_PAD_TIEL_SEL | RG_DSI_BG_CORE_EN, base + MIPITX_LANE_CON);
+	udelay(30);
+	writel(RG_DSI_BG_CORE_EN | RG_DSI_BG_LPF_EN, base + MIPITX_LANE_CON);
+
+	/* Switch OFF each Lane */
+	mtk_phy_clear_bits(base + MIPITX_D0_SW_CTL_EN, DSI_SW_CTL_EN);
+	mtk_phy_clear_bits(base + MIPITX_D1_SW_CTL_EN, DSI_SW_CTL_EN);
+	mtk_phy_clear_bits(base + MIPITX_D2_SW_CTL_EN, DSI_SW_CTL_EN);
+	mtk_phy_clear_bits(base + MIPITX_D3_SW_CTL_EN, DSI_SW_CTL_EN);
+	mtk_phy_clear_bits(base + MIPITX_CK_SW_CTL_EN, DSI_SW_CTL_EN);
+
+	mtk_phy_update_field(base + MIPITX_VOLTAGE_SEL, RG_DSI_HSTX_LDO_REF_SEL,
+			     (mipi_tx->mipitx_drive - 3000) / 200);
+
+	mtk_mipi_tx_config_calibration_data(mipi_tx);
+
+	mtk_phy_set_bits(base + MIPITX_CK_CKMODE_EN, DSI_CK_CKMODE_EN);
+}
+
+static void mtk_mipi_tx_power_off_signal(struct mtk_mipi_tx *mipi_tx)
+{
+	void __iomem *base = mipi_tx->regs;
+
+	/* Switch ON each Lane */
+	mtk_phy_set_bits(base + MIPITX_D0_SW_CTL_EN, DSI_SW_CTL_EN);
+	mtk_phy_set_bits(base + MIPITX_D1_SW_CTL_EN, DSI_SW_CTL_EN);
+	mtk_phy_set_bits(base + MIPITX_D2_SW_CTL_EN, DSI_SW_CTL_EN);
+	mtk_phy_set_bits(base + MIPITX_D3_SW_CTL_EN, DSI_SW_CTL_EN);
+	mtk_phy_set_bits(base + MIPITX_CK_SW_CTL_EN, DSI_SW_CTL_EN);
+
+	writel(RG_DSI_PAD_TIEL_SEL | RG_DSI_BG_CORE_EN, base + MIPITX_LANE_CON);
+	writel(RG_DSI_PAD_TIEL_SEL, base + MIPITX_LANE_CON);
+}
+
+const struct mtk_mipitx_data mt8183_mipitx_data = {
+	.pll_determine_rate = mtk_mipi_tx_pll_determine_rate,
+	.pll_enable = mtk_mipi_tx_pll_enable,
+	.pll_disable = mtk_mipi_tx_pll_disable,
+	.mipi_tx_enable_signal = mtk_mipi_tx_power_on_signal,
+	.mipi_tx_disable_signal = mtk_mipi_tx_power_off_signal,
+};
diff --git a/drivers/phy/mediatek/phy-mtk-mipi-dsi.c b/drivers/phy/mediatek/phy-mtk-mipi-dsi.c
new file mode 100644
index 00000000000..918636a8df1
--- /dev/null
+++ b/drivers/phy/mediatek/phy-mtk-mipi-dsi.c
@@ -0,0 +1,144 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2015 MediaTek Inc.
+ * Copyright (c) 2026 BayLibre, SAS
+ */
+
+#include <clk.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <generic-phy.h>
+#include <linux/kernel.h>
+#include <phy-mipi-dphy.h>
+
+#include "phy-mtk-mipi-dsi.h"
+
+#define MIPITX_DRIVE_DEFAULT_UA		4600
+#define MIPITX_DRIVE_MIN_UA		3000
+#define MIPITX_DRIVE_MAX_UA		6000
+
+static int mtk_mipi_tx_power_on(struct phy *phy)
+{
+	struct mtk_mipi_tx *mipi_tx = dev_get_priv(phy->dev);
+	int ret;
+
+	if (!mipi_tx->data_rate) {
+		dev_err(phy->dev, "No data rate set, configure the PHY first\n");
+		return -EINVAL;
+	}
+
+	/* Power up core and enable PLL */
+	ret = mipi_tx->driver_data->pll_enable(mipi_tx);
+	if (ret)
+		return ret;
+
+	/* Enable DSI Lane LDO outputs, disable pad tie low */
+	mipi_tx->driver_data->mipi_tx_enable_signal(mipi_tx);
+
+	return 0;
+}
+
+static int mtk_mipi_tx_power_off(struct phy *phy)
+{
+	struct mtk_mipi_tx *mipi_tx = dev_get_priv(phy->dev);
+
+	/* Enable pad tie low, disable DSI Lane LDO outputs */
+	mipi_tx->driver_data->mipi_tx_disable_signal(mipi_tx);
+
+	/* Disable PLL and power down core */
+	mipi_tx->driver_data->pll_disable(mipi_tx);
+
+	return 0;
+}
+
+/*
+ * Equivalent of the kernel PLL clock's determine_rate and set_rate ops: clamp
+ * the requested data rate to what the PLL can lock to and latch it, the
+ * hardware is programmed when the PHY is powered on.
+ */
+static int mtk_mipi_tx_configure(struct phy *phy, void *params)
+{
+	struct mtk_mipi_tx *mipi_tx = dev_get_priv(phy->dev);
+	struct phy_configure_opts_mipi_dphy *opts = params;
+
+	if (!opts)
+		return -EINVAL;
+
+	mipi_tx->data_rate =
+		mipi_tx->driver_data->pll_determine_rate(mipi_tx,
+							 opts->hs_clk_rate);
+
+	return 0;
+}
+
+static int mtk_mipi_tx_probe(struct udevice *dev)
+{
+	struct mtk_mipi_tx *mipi_tx = dev_get_priv(dev);
+	int ret;
+
+	mipi_tx->dev = dev;
+	mipi_tx->driver_data =
+		(const struct mtk_mipitx_data *)dev_get_driver_data(dev);
+	if (!mipi_tx->driver_data)
+		return -ENODEV;
+
+	mipi_tx->regs = dev_remap_addr(dev);
+	if (!mipi_tx->regs)
+		return -EINVAL;
+
+	ret = clk_get_by_index(dev, 0, &mipi_tx->ref_clk);
+	if (ret) {
+		dev_err(dev, "Failed to get reference clock: %d\n", ret);
+		return ret;
+	}
+
+	ret = clk_enable(&mipi_tx->ref_clk);
+	if (ret) {
+		dev_err(dev, "Failed to enable reference clock: %d\n", ret);
+		return ret;
+	}
+
+	mipi_tx->mipitx_drive = dev_read_u32_default(dev, "drive-strength-microamp",
+						     MIPITX_DRIVE_DEFAULT_UA);
+	if (mipi_tx->mipitx_drive > MIPITX_DRIVE_MAX_UA ||
+	    mipi_tx->mipitx_drive < MIPITX_DRIVE_MIN_UA) {
+		dev_warn(dev, "drive-strength-microamp is invalid %u, not in %u ~ %u\n",
+			 mipi_tx->mipitx_drive, MIPITX_DRIVE_MIN_UA,
+			 MIPITX_DRIVE_MAX_UA);
+		mipi_tx->mipitx_drive = clamp_val(mipi_tx->mipitx_drive,
+						  MIPITX_DRIVE_MIN_UA,
+						  MIPITX_DRIVE_MAX_UA);
+	}
+
+	/*
+	 * The kernel reads the per-lane impedance trim codes from the
+	 * "calibration-data" nvmem cell. No MediaTek board describes that cell
+	 * in its device tree yet, so rt_code[] is left zeroed here and the
+	 * SoC layer substitutes the same mid-scale default the kernel uses
+	 * when the cell is absent.
+	 */
+
+	return 0;
+}
+
+static const struct phy_ops mtk_mipi_tx_phy_ops = {
+	.power_on	= mtk_mipi_tx_power_on,
+	.power_off	= mtk_mipi_tx_power_off,
+	.configure	= mtk_mipi_tx_configure,
+};
+
+static const struct udevice_id mtk_mipi_tx_ids[] = {
+	{ .compatible = "mediatek,mt8183-mipi-tx",
+	  .data = (ulong)&mt8183_mipitx_data,
+	},
+	{ /* sentinel */ }
+};
+
+U_BOOT_DRIVER(mtk_mipi_tx) = {
+	.name		= "mtk-mipi-tx",
+	.id		= UCLASS_PHY,
+	.of_match	= mtk_mipi_tx_ids,
+	.ops		= &mtk_mipi_tx_phy_ops,
+	.probe		= mtk_mipi_tx_probe,
+	.priv_auto	= sizeof(struct mtk_mipi_tx),
+};
diff --git a/drivers/phy/mediatek/phy-mtk-mipi-dsi.h b/drivers/phy/mediatek/phy-mtk-mipi-dsi.h
new file mode 100644
index 00000000000..96a93e5ba5f
--- /dev/null
+++ b/drivers/phy/mediatek/phy-mtk-mipi-dsi.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2019 MediaTek Inc.
+ * Copyright (c) 2026 BayLibre, SAS
+ * Author: Jitao Shi <jitao.shi@mediatek.com>
+ */
+
+#ifndef _PHY_MTK_MIPI_DSI_H
+#define _PHY_MTK_MIPI_DSI_H
+
+#include <clk.h>
+#include <linux/compiler.h>
+#include <linux/types.h>
+
+struct mtk_mipi_tx;
+struct udevice;
+
+/*
+ * The Linux driver models the MIPI TX PLL as a clock provider (struct clk_hw /
+ * struct clk_ops) fed to the DSI host as its "hs" clock. U-Boot has no consumer
+ * for that clock, so the PLL clk_ops are folded into the callbacks below
+ * (keeping the kernel determine_rate/enable/disable naming) and are driven
+ * directly from the PHY ops.
+ */
+struct mtk_mipitx_data {
+	u64 (*pll_determine_rate)(struct mtk_mipi_tx *mipi_tx, u64 rate);
+	int (*pll_enable)(struct mtk_mipi_tx *mipi_tx);
+	void (*pll_disable)(struct mtk_mipi_tx *mipi_tx);
+	void (*mipi_tx_enable_signal)(struct mtk_mipi_tx *mipi_tx);
+	void (*mipi_tx_disable_signal)(struct mtk_mipi_tx *mipi_tx);
+};
+
+struct mtk_mipi_tx {
+	struct udevice *dev;
+	void __iomem *regs;
+	struct clk ref_clk;
+	u64 data_rate;
+	u32 mipitx_drive;
+	u32 rt_code[5];
+	const struct mtk_mipitx_data *driver_data;
+};
+
+extern const struct mtk_mipitx_data mt8183_mipitx_data;
+
+#endif /* _PHY_MTK_MIPI_DSI_H */

-- 
2.55.0

