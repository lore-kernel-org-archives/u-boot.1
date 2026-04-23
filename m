Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7087FFF885A
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 20:38:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F155B84540;
	Sat, 25 Apr 2026 22:36:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="ImrDsjTZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF25B84480; Sat, 25 Apr 2026 21:40:57 +0200 (CEST)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 429E484353
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 21:40:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-5a3af1b7549so11161814e87.1
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 12:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777146054; x=1777750854;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JHdXH/OXUceNboGPWKDqrUgr/h8EL4kfl0FgGMreXUY=;
 b=ImrDsjTZPI9zkPq0NjTtHVNRbPaHrQJra9rG1L8rxgbpvTkldibTYRJV444giJKih1
 4gxtsCjNVkF+fKwv2hYhEbI/41MgbmIMWTGen6rfdmNr3oio/rV3cXe2EK+QY2+OE1C4
 qGdazgvxGrHlhLrmL2VQ4rMl7ZAVz3yKLreoxJDKOVZUscfXsN8BJIgr6Lul3+tIkchh
 DOHlx5HGImb2HYlAn9pGdi6lqBluCHzO4UIowqvG6twydsBzzsN+nSwUG9SnAY/BVSOM
 ooVeUcqr3QTsZwm1hZVSEEmUYjHKIwVkK/vDsaInMxekp37VPMxj0cup4B5n7ojOUyNX
 dQdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777146054; x=1777750854;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JHdXH/OXUceNboGPWKDqrUgr/h8EL4kfl0FgGMreXUY=;
 b=EboSC+n86dG2S08wsI/qgOv+2EW8BZwFXKmoXqk7TXil4YpTrK+9rFx7+qkKTHq9kn
 1IqNu2MB2WRVSDyaD4tTiDNWoF0vcctC6olQjkC9+upGVW0mhcnHbBaGFTscsR5GnJ2D
 LpvbJX3+UN7PewYbnuoS9Ofu4TP5L5V/Dsr53TGqS6LIIYUhCCeecvrotZzciyEkJTtO
 VpFReXhkBIbibMpLkWXTf2r8Kn3f2C7dxuxSnJQuxPMiVsMhxqiwdRQkjvO18K6TXcBc
 RS4D+8fWi5TWa/+X+Nv0MKpp6OkIqtFx2kLuDErQM6SIAsyy5lYMXpvHjGD54k3aLnwc
 xhOg==
X-Gm-Message-State: AOJu0Yyec7HENYyHyUzxOfVZx4jGJSMixRgMjV+/w5B7Sx17Y2Mhmuvt
 Bg4CSUa1+8H3KpEhOEryVTqLOX65LDrvvKRrABE7bSja1RPWXkoc5wLOruSEsrtcsMwWV+D2bVp
 cnZLHXto=
X-Gm-Gg: AeBDieuSzuEm1+ZSKvEd/rpE3koLl+lYwa0jtFY7xTXENM+hr1oU0f2to1eTkaXviBN
 zmaUIPdFm+rJr7EY/8ftJUXO4/bVLomwFDRD+oGOkEw+V/PDCIJ3gGm75+sX/3nPIlhAkYFurw6
 AgMB5Igl2OMJJGzuI11DJ2uETgdC1muEay4PfZ4mwfA/Lqu9guXNwvuvIlzJKKxctoE2kJereCO
 lQUdC2xzRaJ/zkMCIi+FRc3xCNOi5Q56EXcD4UZF2guMBi8/QnvwhV3zMwAEP8C5MdSXSMeYbZS
 bKs6t4Upw9D8dUeP6leng8KK+ma/Gq/BBNraOJkFFZ7zuJukAfxLizGDLjBn8SkbCJWfEmpk14l
 b9ca/eBb+DsUCEusHdKLvTMF86yYbPyyt33q81MvlmCFRGymOs6cyI8za2+dWvLXFdONYmu+Vlk
 Y7JIDWPvbHKD5m/+uDxcZ9uOHh7vxI0Xrw9EpOma5dLnU9JBHQX9AEXlKRXKVhOh66c2SVnBPHl
 bwLXj6AAa6KIi7ppDOD6n0ffO+P2W2krRTwgopqfWY1fTJ2u1hIIF9Or2B3Uzm4BiWpeIqbWsaI
 Yo6pn3wIOJLZ3kyoYQ==
X-Received: by 2002:a05:600c:a314:b0:48a:54a1:38bd with SMTP id
 5b1f17b1804b1-48a54a13b5amr144599185e9.21.1776950760077; 
 Thu, 23 Apr 2026 06:26:00 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-56a2-efb9-07f1-cf08.rev.sfr.net.
 [2a02:842a:d52e:6101:56a2:efb9:7f1:cf08])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4891bb3d121sm500300885e9.14.2026.04.23.06.25.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 06:25:59 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 23 Apr 2026 15:25:53 +0200
Subject: [PATCH 2/9] MAINTAINERS: add maintainer entry for air_en8811
 driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-add-ethernet-support-for-genio-520-720-v1-2-47ca918e0017@baylibre.com>
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

Add a new entry for drivers/net/phy/airoha/air_en8811.c  driver.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9d68e8e3bb7..40ba3542ca3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -58,6 +58,11 @@ F:	cmd/acpi.c
 F:	include/acpi/
 F:	lib/acpi/
 
+AIROHA PHY
+M:	Tommy Shih <tommy.shih@airoha.com>
+S:	Maintained
+F:	drivers/net/phy/airoha/air_en8811.c
+
 ALIST
 M:	Simon Glass <sjg@chromium.org>
 S:	Maintained

-- 
2.52.0

