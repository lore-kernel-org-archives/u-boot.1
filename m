Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9019FFF885A
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 20:37:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3205884514;
	Sat, 25 Apr 2026 22:36:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="JPwX14FL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E4278439F; Sat, 25 Apr 2026 21:13:28 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44D7C84372
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 21:13:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b9c3e2cf3c0so1556717266b.1
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 12:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777144406; x=1777749206;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3RweLXD/ZJiCygc4L/BhMPJCrBSq4SODmjOB3plrdz8=;
 b=JPwX14FLlyiTBS0wOC+ERvDUVZGHHK005xROLjZeCYX4nEwuZ4iR7tviLQrfoQeQ4g
 j6U+HyMPLmv1Y5Pqy9zlcuEqdmStWZShUNaGD3sEaKx+gceFyBfmvyUPHdelH6F/6Xas
 CyRxe3mhXPZ4JSJ5IcUa/sqtI6OCsoox2WdBgqaHKoMeD8cY6vhj5jXfxJYLzPF1YdBr
 Dp+0rseTiJA2qei8yKwDfmbItZXbB0jMF5HpPQ8nurDfrPEA5XUDFR9em9/N+yPluUXy
 0H+Ry2NHO/qpXarJP944Os2xMdE0DpLs7rBoJ/LQ4KglhRIG4W+JGsYNqT0d9EWub31c
 MPzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777144406; x=1777749206;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3RweLXD/ZJiCygc4L/BhMPJCrBSq4SODmjOB3plrdz8=;
 b=hMIuuXeK3+3X7wQJcWZD6hiYylG2iC8RtvpvGgEysahM+e5xcxHUZTuzVL9jGiq/Pa
 b0WF7LQHf1Qh4yNIXkx6QCuG0iS+Prnam1PwsSKKRzLshsV122fOZW7ELVNzn+aGoncT
 4nxWZmw07a2v3+yzk9GbQPXy6XjwFQ/q3MeKE+7fVo/5HwIDaZ3bI2nAD2RQdAcaDYW9
 shOpJnZGdRWuYuCxvmcxMx3Q5Fx3S1KXa+XVIIs8Uvq5u0fiQVjYNF8vcoyg3QORX0iM
 I6lOzb23oK85yFC7uxqPa6BnLHBgNyGN2y/wLNF//8fwLEd05jV8+LIZ0Xs9LHklIxri
 cjIA==
X-Gm-Message-State: AOJu0Yx+tCwDCFdA4Vqz7P32NPvDsAoxym8GmLQVhJlQALXT/zPao7cf
 A8TENvmgioEg5vUMUsROviSO7m+N8WZ3ALITS4m48INej3BD48Se73ICojZAImHgyIQhoNutLx1
 BTU9G7eY=
X-Gm-Gg: AeBDieuIrU33J4BNoysbujkjixAbxUNb6iIeC/6OyafKsrXrkXXwNl3yl/CS7emVAdH
 /S/bd1U82CyDbZAVdHlUkmQ+KTWUendJOjUhoyM3nr0aTtKgU5DTLQa8nE57+v8Gk5qw+u2L32A
 z59PhGgIKf++Zo34sQCzqJKUePisDKybwTBMCYDwB6EvvE/H14e9RTRYhTNyhyAg7Jm6Vs8G2C0
 idsg8kj8VwLuBhLCc3nLXvXK4ONJxKnHubAmoPmsZUVNV75Zb94GwqcvQwjzIFISKHJzojmavuH
 cwCKwab/gaat1+OtOusOPFRWmi09DmEuktgBtJGiqxR/8VeGW4KmUR0TbEejvb1QMJ1L+ZWnedK
 bNzgYQShO0HmGGnhFGvRhMujGtFYNwrAc7kMcit/npHlC2KEO52RtjZ6oIEmY5ouFQXh73F+bat
 rJE90ettMuq1Xzugdg6+OMYuiOiA6AgYKYfQmFMlqz67zyuI72W9E08s18Pu/gTwIA8/WrzZne2
 wD1TODqM0/rKijB+ch3ktKQyxxKoYIHyiZROeeuOuT+4c0Kyf7ngr6/faJYoCAbSV/RuPw/27ni
 7kFEbOX6BooBdITJ4/5/AtMUsB9v
X-Received: by 2002:a05:600c:5299:b0:48a:5342:36b5 with SMTP id
 5b1f17b1804b1-48a54514646mr183867675e9.21.1776950791010; 
 Thu, 23 Apr 2026 06:26:31 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-56a2-efb9-07f1-cf08.rev.sfr.net.
 [2a02:842a:d52e:6101:56a2:efb9:7f1:cf08])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4891bb3d121sm500300885e9.14.2026.04.23.06.26.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 06:26:30 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 23 Apr 2026 15:26:00 +0200
Subject: [PATCH 9/9] configs: mt8189: Enable ethernet support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-add-ethernet-support-for-genio-520-720-v1-9-47ca918e0017@baylibre.com>
References: <20260423-add-ethernet-support-for-genio-520-720-v1-0-47ca918e0017@baylibre.com>
In-Reply-To: <20260423-add-ethernet-support-for-genio-520-720-v1-0-47ca918e0017@baylibre.com>
To: u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Robert Marko <robert.marko@sartura.hr>, Simon Glass <sjg@chromium.org>, 
 Yao Zi <me@ziyao.cc>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Yanqing Wang <ot_yanqing.wang@mediatek.com>, Beiyan Yun <root@infi.wang>, 
 Ryder Lee <ryder.lee@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Peng Fan <peng.fan@nxp.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Philip Molloy <philip.molloy@analog.com>, 
 fanyi zhang <fanyi.zhang@mediatek.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Marek Vasut <marek.vasut@mailbox.org>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Heiko Stuebner <heiko@sntech.de>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Christophe Roullier <christophe.roullier@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Sky Huang <SkyLake.Huang@mediatek.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Tommy Shih <tommy.shih@airoha.com>, 
 Kevin-KW Huang <kevin-kw.huang@airoha.com>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.3
X-Mailman-Approved-At: Sat, 25 Apr 2026 22:36:28 +0200
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

Enable configs needed to support ethernet on MT8189-based boards.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 configs/mt8189.config | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/configs/mt8189.config b/configs/mt8189.config
index 55c2ccfc01f..8bb25863687 100644
--- a/configs/mt8189.config
+++ b/configs/mt8189.config
@@ -22,6 +22,11 @@ CONFIG_CLK=y
 # CONFIG_MMC_QUIRKS is not set
 CONFIG_MMC_HS200_SUPPORT=y
 CONFIG_MMC_MTK=y
+CONFIG_DWC_ETH_QOS=y
+CONFIG_DWC_ETH_QOS_MTK=y
+CONFIG_PHY_AIROHA=y
+CONFIG_PHY_AIROHA_AN8801=y
+CONFIG_PHY_ETHERNET_ID=y
 CONFIG_PINCTRL=y
 CONFIG_PINCONF=y
 CONFIG_PINCTRL_MT8189=y

-- 
2.52.0

