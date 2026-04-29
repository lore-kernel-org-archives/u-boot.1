Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D6B1FF8867
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 12:42:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF18D848A0;
	Wed, 29 Apr 2026 14:40:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="czvWdr+z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AA9C84711; Wed, 29 Apr 2026 11:17:49 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F77984705
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 11:17:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-488b3f8fa2bso6194345e9.1
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 02:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777454267; x=1778059067;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PKZajtnxuquByd82zKC7xi3sY6wzeZyzPF0oTBC4qiY=;
 b=czvWdr+zyJCYsi9rRR5x3Zb85XiiSXWdOYuwjzacVrsU36ibmlDcsxf/Ia8rMJobOD
 gefw3q/j9c8y7Wd134T/bimc+5hfgPZzGogcZ9L8c93CSyRAGlFvygd2dNU8IifRFr9S
 gsAI8bT/UXEjdVKeQ90YtW0tI01NBm/fohv2FwBzr9bKYqWrrcv8mnaz7SM5889bOLQP
 2UQA1PiKlkjjbLhWEkgKZkF1rYlIznUUH+i7pM11+CG/enWe2CUIbnmoQmi7mvhvQlvS
 RaZGoGA9D3FRwTBH0/8mPd6u63mM3XJwW0GFaNaXoB5T15fVwv3JWB55bLTlZdazodv2
 PCOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777454267; x=1778059067;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=PKZajtnxuquByd82zKC7xi3sY6wzeZyzPF0oTBC4qiY=;
 b=fLK1SZTCDdOnyNKWi53+RQG64OZf5ksIEPlvtsn9M6u8mi2HgEpE8rpCqjHuYfeYVp
 b38EcQzHIZC2/00Ar5/d6sUAbEuSJnZ61mAqlgzMT4IsvbMnWPUH6D3bELAnxL+4FH64
 di6WMYKzvm56xmcLqgGzQtXHPNTJJHF/FZ2bwm40WRCCOuD9B6jJ9/59uyDUlC5HZxyg
 xytm3Px7Z7hmQhSksJwj/kOQpRh8tpgKOsP5pvNWKvEpwlYvMyfAFKcQivTfnUgGIyJ8
 x9MXg7T6DsKm3i4fBtAi0SzuddBZuEQQd6vihD5gq264cuIflA8ORK6gZIZsOv0ogrK5
 YhCw==
X-Gm-Message-State: AOJu0Yz52LqNIjTGCj9phUjJDOgQwySaGJuuwL4Xo+lo67R5GmkOKhut
 a3GinCtZK5Fv9lBdDKUFFU8IaK25C9wooFcEBNcPHf1gIGYD+5LF2+O3xcbrxATCkUQ=
X-Gm-Gg: AeBDietNnjAD8JdnJY0wL+xjoZVZOYG/RGj7pkDjP3YNHYyA2ds/myi43+8tM+LvHCw
 DgZySNYyUjkGhqtJFLpE5/PssTXFKbpccjUHz9b56YBcg20/RrweLX+YfPy/98V1oXvarGP5sSX
 PQiGFwAgKcKQRUAymNpPPQ3GGD8jRYQPqSqiEJzOrrPZpRlI6SA2dL7BjOvUR2EyFbFJ9CmVpZN
 6Sj+wcnkFL9CjPC/Wcy5/5bfN33kzWXitFeXPCaRv5HvJKkWpwHP1CevUq3i0QaiH8qH7eeVbYR
 fdfR/Q22jR2Xc4CV+KY0xENXyMHjwOZ6wZWbRLevrrsyOnP5qbH4l/UVlCh5rJd0mKzq/FkiXt0
 r+gUGk6ie5qtvNf0QGaMuTlMhfMn1e4w2LLDO8WIHE9DDzJEnlpHGSZ9CijmKm6F0BDqeLdcNox
 e2BU4bsvgAdxTo9H7b9FJ9MW0ND8i1TTESEuYLWkjtum0cYodLVLt0deVBxi/EpRlI9Cx0yyWvC
 /hSB3WvRfLCtWI4jAmtf11edi0MRh7dJnHv2oCP+Lb+PvfjcabIdcJJjudHQ6QBJWWJZn/5nmtN
 thrxzYLhY4nXZ3kH
X-Received: by 2002:a05:600c:1f96:b0:485:3cef:d6ea with SMTP id
 5b1f17b1804b1-48a7bfc4834mr34890225e9.13.1777454266445; 
 Wed, 29 Apr 2026 02:17:46 -0700 (PDT)
Received: from [192.168.1.64]
 (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net.
 [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a7b9dee18sm44478375e9.0.2026.04.29.02.17.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 02:17:45 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 29 Apr 2026 11:17:17 +0200
Subject: [PATCH v3 9/9] configs: mt8189: Enable ethernet support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-add-ethernet-support-for-genio-520-720-v3-9-1f65e18d4f54@baylibre.com>
References: <20260429-add-ethernet-support-for-genio-520-720-v3-0-1f65e18d4f54@baylibre.com>
In-Reply-To: <20260429-add-ethernet-support-for-genio-520-720-v3-0-1f65e18d4f54@baylibre.com>
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
X-Mailman-Approved-At: Wed, 29 Apr 2026 14:40:47 +0200
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
index ecf8c5f4b4b..f86bb50bb5c 100644
--- a/configs/mt8189.config
+++ b/configs/mt8189.config
@@ -23,6 +23,11 @@ CONFIG_CLK=y
 # CONFIG_MMC_QUIRKS is not set
 CONFIG_MMC_HS200_SUPPORT=y
 CONFIG_MMC_MTK=y
+CONFIG_DWC_ETH_QOS=y
+CONFIG_DWC_ETH_QOS_MTK=y
+CONFIG_PHY_AIROHA=y
+CONFIG_PHY_AIROHA_AN8801=y
+CONFIG_PHY_ETHERNET_ID=y
 CONFIG_PHY=y
 CONFIG_PHY_MTK_TPHY=y
 CONFIG_PHY_MTK_XSPHY=y

-- 
2.52.0

