Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E87ACC83F2C
	for <u-boot@archiver.kernel.org>; Sun,  3 Sep 2023 20:34:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 765158688B;
	Sun,  3 Sep 2023 22:34:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="bZKeG4Jf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC5638682B; Sun,  3 Sep 2023 22:34:02 +0200 (CEST)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D35E986504
 for <u-boot@lists.denx.de>; Sun,  3 Sep 2023 22:33:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2bd0a5a5abbso11717161fa.0
 for <u-boot@lists.denx.de>; Sun, 03 Sep 2023 13:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1693773239; x=1694378039;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sD2hlYlCgVuW77uU7td9BkSqqVZKqgGImD1ny70Cgk8=;
 b=bZKeG4JfwXkcvWlA23dxsUMkiZVsB3+aF1pp7KIc7ca+R4aCxaJWcpERwEP2cZCCSm
 rmqHXIy4S2w6MtgIZmHCqEh0jvZox0bunEZcpwukewIbajmIA21QlPo6k0fLbvoLSXXr
 mh1bU7mKv8jBx0YOpeUtACL+ZNFNENh3jMfS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693773239; x=1694378039;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sD2hlYlCgVuW77uU7td9BkSqqVZKqgGImD1ny70Cgk8=;
 b=jGOHAsuPo4MqxaFetjK7Q7fPGqtkocTe6dPSyWahOR8efoHK7WuSdqOru8+JtN/bSo
 921pwoc2PrP7WpLqDsfiAALSixsetUWadhoYB5F9xZJG0dqtUY8lednXLNc4suxodgAi
 BCrtIfRoCsAtQ5/0VQiLd6Qr4qFrlwf6Ne5dunXxwRQIeNVDG/MsZoYLcuBzVKQwNlef
 myJRmdZjLQajuIzILJe3HG5GIIK/ib5oTnoN6I8IeoF8Rysi+2Ch6MJZ6S6uS+/EDdqI
 X0OWvudW/BKcqk3Dyn5nNa3WLo23RZvrQuLR7lRXkcZUtsfjlfg2d6En6z2kMKDYYV8k
 jjEg==
X-Gm-Message-State: AOJu0YzjmkTYD9guGqYW/MeXLHtgHKH1vegRrAOBIipcCEuA68y9hbVH
 CaVJXbp5QHw34IxR0YUwKmgyfHUOc9vJpulnEueYzw==
X-Google-Smtp-Source: AGHT+IHbt/tGXxwRItjjCYYthkLlY11NA6kxY6S3nYRYgum6PIYquSnkon8xKeF5RcI5LoHQFUpKHQ==
X-Received: by 2002:a2e:a401:0:b0:2bb:a14c:f6de with SMTP id
 p1-20020a2ea401000000b002bba14cf6demr5821058ljn.21.1693773238951; 
 Sun, 03 Sep 2023 13:33:58 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it
 (host-79-54-71-141.retail.telecomitalia.it. [79.54.71.141])
 by smtp.gmail.com with ESMTPSA id
 pw9-20020a17090720a900b0098884f86e41sm5103232ejb.123.2023.09.03.13.33.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Sep 2023 13:33:58 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tom Rini <trini@konsulko.com>, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 3/3] ARM: dts: stm32f429: put can2 in secondary mode
Date: Sun,  3 Sep 2023 22:33:52 +0200
Message-Id: <20230903203352.658691-4-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230903203352.658691-1-dario.binacchi@amarulasolutions.com>
References: <20230903203352.658691-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

commit 6b443faa313c519db755ff90be32758fd9c66453 Linux upstream.

This is a preparation patch for the upcoming support to manage CAN
peripherals in single configuration.

The addition ensures backwards compatibility.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Link: https://lore.kernel.org/all/20230427204540.3126234-3-dario.binacchi@amarulasolutions.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

---

 arch/arm/dts/stm32f429.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/dts/stm32f429.dtsi b/arch/arm/dts/stm32f429.dtsi
index 22225104fca8..8133ea15b036 100644
--- a/arch/arm/dts/stm32f429.dtsi
+++ b/arch/arm/dts/stm32f429.dtsi
@@ -346,6 +346,7 @@
 			interrupt-names = "tx", "rx0", "rx1", "sce";
 			resets = <&rcc STM32F4_APB1_RESET(CAN2)>;
 			clocks = <&rcc 0 STM32F4_APB1_CLOCK(CAN2)>;
+			st,can-secondary;
 			st,gcan = <&gcan>;
 			status = "disabled";
 		};
-- 
2.34.1

