Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6258CFF8867
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 12:41:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E16C8485A;
	Wed, 29 Apr 2026 14:40:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="MA9RUmi1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA32584705; Wed, 29 Apr 2026 11:17:30 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0250784705
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 11:17:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-48909558b3aso123654075e9.0
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 02:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777454247; x=1778059047;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=F580oyhz2uHlMsW9XS0EQv3NtI7Y8wjVpQml6aR8e/o=;
 b=MA9RUmi1eiGAyAMjj+8GIztP2PyLMEdQidZH/yVQ6ahiNA5Gh6mFWTNotBFqxiUGND
 XYq/fQ0Q36eRvcgz+9rWLQESbivJCnmSIr33300zCwkQ/y9PU3cByFoNKxrT2xByQw5f
 8yBos/qB6sgoSVugyFZJriXd8IqnxDWg/ANMYLw6jYP26jHfiyI5doL93L88m4ouUGNh
 453Wl81Po5gqR3N2sVu4SqQ0ai4k0T8jccBPZP3A67MDzyUr595cJenhAjRlTDPrMcKT
 pAhR6TlNCsewPkWIw5rnjsgV7ebVkEoxph56B//BgoyerwnF5adQwidDg6VneODhc7MC
 FUOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777454247; x=1778059047;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=F580oyhz2uHlMsW9XS0EQv3NtI7Y8wjVpQml6aR8e/o=;
 b=il64jP4sjeSdSCTh8iPSnn0XSP6WbYkuGFV8e09SZRVxAR0ObSZGp3UznY7WTb4xLp
 0LVoUoNam9/Hew8oPjwBd/VsMlJgZWCGgqXoZ45Z/IbNbCTGtfYhp7gRwlewxocehUtO
 6qrg+W0i9toU/beynP4KwB2RBOnrY1Hs3fjd25OJZGveS+he2H+bV+HgSLnc6lRj1Y37
 VTkxi7Cr+DZS2cMRklW4XlikFuSmA/9BUanwFZyGOA743KYhTCFYXVYDl2Z0POG/CbPL
 BeUKPuMQf4UanMAntDSQBc+uQEhsijFK53DnT+6w/7Y0bLNrdrxfVurn+JoEgdsbW8SR
 yeyQ==
X-Gm-Message-State: AOJu0YyTivpTlLl4CcFT9WCTI6QzA3956OqZwIasb6r20jpcWCcl8OqI
 Y1eoXrUG6VzbZCSPuJyiOX6sEXkzzQLvG6I60HsjhJROi8t7i8uHg70R4eelhVfytuo=
X-Gm-Gg: AeBDiessqezcY3sa1LqzqT/t+NUdTQQUGo70S8oKL9nGe05VA6df6yv8eFmkCn9hn2P
 1unm3HXbFFNCP6lleYaAAEp6rxurPVamZifdT9OmhqNhMfcNEQxdGE5qECFVJNC4Rh94AGkCSKU
 4NjBoKnaDfdRosoB1Ng8BYMaei0QoZ56udCcYg0NJrw1CzDNTkYHBTCyVV5j92hJ2K1wzFJcT6F
 6/2fWwH2AhRfbIdNImuEv6r2JVQwQJ9NJdSD/V8KNY62bc1hYckLUVlG9p3tPhkzdLolB/tA/wR
 deiWOyEuMoyCcpxSZSYMHDoNO8B7WTyfc0j7sENX0wuekaUDNXdyWZH8uLvv2gbuv5LfXFfSN0u
 8AOnCVov7fy0/LymVgsrKThMMasBxs2FvO7x0PjVhDIhzuKaAkjI9rdPHDtYlm2nPP2vDSMX5S6
 YhJZqof99ozcONlpg8Gjf2bNlHUSy2GZ3oG84U4WDJGRkZ6IH5zl4S2x7GdMznV5bzfouciCbqS
 40vGkWFG4+H+P22PRsTtXVlpgBZYvt4b2epB0c6j7HYjWNdJmprdhp4cyVHdOgSfE208liN63Nz
 V6y/Jypiq1KpeH9/
X-Received: by 2002:a05:600c:a118:b0:488:ae6c:42c0 with SMTP id
 5b1f17b1804b1-48a7b51c1f3mr38751395e9.7.1777454247246; 
 Wed, 29 Apr 2026 02:17:27 -0700 (PDT)
Received: from [192.168.1.64]
 (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net.
 [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a7b9dee18sm44478375e9.0.2026.04.29.02.17.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 02:17:26 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 29 Apr 2026 11:17:10 +0200
Subject: [PATCH v3 2/9] MAINTAINERS: add maintainer entry for air_en8811 driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-add-ethernet-support-for-genio-520-720-v3-2-1f65e18d4f54@baylibre.com>
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

Add a new entry for drivers/net/phy/airoha/air_en8811.c  driver.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ce4e9d58037..105590ffad0 100644
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

