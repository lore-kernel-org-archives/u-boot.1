Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB2DAFF885C
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 20:37:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F615844AF;
	Sat, 25 Apr 2026 22:36:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="oVVQ0Asp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E74D484376; Sat, 25 Apr 2026 20:37:07 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98C8E84314
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 20:37:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-488d2079582so104081455e9.2
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 11:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777142224; x=1777747024;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jkctqVdA6nEAuGRoPYxhlry1u5Dr+3ZhtxI7qo1mEOs=;
 b=oVVQ0Asp6KE15rr3qHAr2hWtIOXFH3JxlkEGY9W/lpVWwyqtZx4vUtxn4slKcOD54H
 ue/RSG/JlrtSG0eRC8A0VAY8ObRHpy1raQc2iU9kgR+yj4E5k82iqExA8TWf3MneAM6x
 u/JqQtEdi3gubu+a04En/SVbJTBKpCoQX1E9mxxU8hf4U5RNKkqKCnWpO8p5moEZ5eWe
 xhemG/ZRcrKgu9lk6Y5HmXQm7wTeHaxAmSsKNCYNMORHpoB/36Mqhwx/R8dUVpySH/Xr
 qbhcqLd3aq66A4oQJX8StjMsFeeTpmWi+a0gpYSX41gL+aiuJFHXVVCvIqWa/qhb5QDe
 2kkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777142224; x=1777747024;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jkctqVdA6nEAuGRoPYxhlry1u5Dr+3ZhtxI7qo1mEOs=;
 b=RXCrenxpDOIfOWpmP7/eNRkerQ0Z0X4wBjvgY+rZ4ylsE2zxPXmv2xcJ7WleajdaMM
 2+k6kH4+mRG9m9hCqLLVIc4dZ+IS52jV22R4fxH2oi/2DXW0rlU4R/3LuFZN0vbr0IvT
 oIfPBtyxYFk+lLkxZKwyT6+Ds/uDrLl8xR0G2i8o888G1TmXlTiIhbb//4V8FIjA4Yme
 j8xYniYXbYKtgeUfPw14SjCGY010tUt/qSzRD16YJPIXG5lHsbnmbicb8YeCl4bJAt0q
 KS7XVu8D65DmlF+vBpQoDOrtYP0rXzMd61O0g2srs+6mwUuAKABixD6UCTZ1bNt85XB7
 OOUg==
X-Gm-Message-State: AOJu0YwWbWojAVHhPdNg79W20Qz9TV2rOWI1GR3d7lBIdF7E0wodvVNZ
 l3mYb+C/kEyhKS4Yr+DTwQznIonYH0yhA2mvKOxu/wPWdZ0V31bNhERnXEjwSUYzb/XfkEE/lCQ
 2go5zgSk=
X-Gm-Gg: AeBDietNc+6z7xBaIr1N4Oh46A/j3OKXF/lKs4DGf1zSwz3+bRlKvp2r4GpnoE8Mrs6
 yuco8wqsTwhr4Ux7TXpzEg4sobhySbGfj1DR6cH1YwXD44Bba64S1O+fmC6xhkst7SSPFUMZ1wl
 fB8J/rVVP3P6uduxCSBLXzs8eKu3U5hWsYY3+0nXK+QntJPI4nsNWVNKtzRNLqHngezRBg5Lhvo
 izqHbhDBW3zriAw8VedzvqQfhssxHQjLKflNnCY4kRrU1KsSmtw2JohioQdMAxJht/P/OthEI6o
 z0coGoKfQ65Tq4VLO3wogBFRwS/JIONnNv2YJY57MzwX4N5NzBKvadW6b9knHXUlmtkcEK3vxqB
 Swec//VJ5dE32g7xWMkqLCUsztr4Ksrli50CScNpWJqHkDjI77QpUXYCVjoD5H6ZT6l46qrmoFb
 8gYYMm+8xPaxnAsy5F80+F9vKizeaopC+qXFPERxFz3hVbBaYficGwxme9pdnhXFS0+lbDy1pQP
 EyAe0AKpBQgQbCdI9TudyJizTo/NzcqlRPVxCWLYTGeWQathHGpRF46A7ME7xUlnf8DYw52EjPU
 B6+AC0bBZxV4DVWdgQ==
X-Received: by 2002:a05:600c:1614:b0:489:1e8a:90b4 with SMTP id
 5b1f17b1804b1-4891e8a91e8mr145476885e9.21.1776950757663; 
 Thu, 23 Apr 2026 06:25:57 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-56a2-efb9-07f1-cf08.rev.sfr.net.
 [2a02:842a:d52e:6101:56a2:efb9:7f1:cf08])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4891bb3d121sm500300885e9.14.2026.04.23.06.25.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 06:25:57 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 23 Apr 2026 15:25:52 +0200
Subject: [PATCH 1/9] MAINTAINERS: remove trailing colons from section
 titles
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-add-ethernet-support-for-genio-520-720-v1-1-47ca918e0017@baylibre.com>
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

For consistency, remove trailing colons for the three following
sections: ACPI, ALIST, and INTERCONNECT.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 056902f6ef2..9d68e8e3bb7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -50,7 +50,7 @@ so much easier [Ed]
 Maintainers List (try to look for most precise areas first)
 
 		-----------------------------------
-ACPI:
+ACPI
 M:	Simon Glass <sjg@chromium.org>
 S:	Maintained
 F:	board/emulation/configs/acpi.config
@@ -58,7 +58,7 @@ F:	cmd/acpi.c
 F:	include/acpi/
 F:	lib/acpi/
 
-ALIST:
+ALIST
 M:	Simon Glass <sjg@chromium.org>
 S:	Maintained
 F:	include/alist.h
@@ -1273,7 +1273,7 @@ S:	Maintained
 F:	drivers/timer/goldfish_timer.c
 F:	include/goldfish_timer.h
 
-INTERCONNECT:
+INTERCONNECT
 M:	Neil Armstrong <neil.armstrong@linaro.org>
 S:	Maintained
 T:	git https://source.denx.de/u-boot/u-boot.git

-- 
2.52.0

