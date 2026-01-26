Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37AAFD19503
	for <u-boot@archiver.kernel.org>; Mon, 26 Jan 2026 16:15:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D02A83EA9;
	Mon, 26 Jan 2026 17:15:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Uk2TplrG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33FC883EEF; Mon, 26 Jan 2026 17:15:18 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 544E583B03
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 17:15:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ozndrgt@gmail.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4801bc328easo53191575e9.3
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 08:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769444115; x=1770048915; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q9TgC3I59QD3PvqvseW1viZTMJWVcil+mdaW9CQ7l58=;
 b=Uk2TplrGO99v1P2IN6S5+ZIRZXIiplMT0F+l9bOO9jo4WkAd6e9wR/fPy/iQj5pjwc
 vLqMLGByU4waLvUf8jVRo2y435NsAlcMumhXrJresgizfFx2kqrGlUbixUTjRuu4u8Bm
 j3lpIJEEUMR/KFhYRRc3c8wGESpt1fyH+5u0kJF0BE3E9UH1ec92PPb9jvzdDNf/vw/0
 LkfHTnMO3sAER8KBlpYYTzoXWT01AjUKpgu1EMqlrgbgjkhQGlpDjn84eVNjEtVcmMUZ
 nwT0AckjbqebQ2/SlTYAm0pkIx5Nr0ZTlDfvA9XXLsAn6l2HLGP5t3p5sUKbYmKCYSC2
 OArg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769444115; x=1770048915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=q9TgC3I59QD3PvqvseW1viZTMJWVcil+mdaW9CQ7l58=;
 b=gO4ro0DLw3MnbJ6TBk67X/71Si2rsqA39jrc7bGWOSy5SMPxPPG6KglFknSHFaqQZZ
 WW6Jlb2qC2vSUzlWbLX2N8iTfhMgmne0BlOotXdvIhbsiPC9EdwGGK9WGJprdhNPBklw
 3b6R8imVdBvCsjTyV4auqhkapCMQIVgzvWCxqD5kUgFT9HjmMigBhGPgnrBN6ytVfM8z
 gxgFItIzsjQMRL3WWcYEwuW4wnD5UOk3YqB7KMe/IRKCKmHUVOa5+tqTMxMDXOlKfVgo
 pwymoFiImJq9t6rZPscDu64RIDIw1lpz77SDIgkgZXw1jY1IdORC99ZCXh8ssxgouG/F
 nZcQ==
X-Gm-Message-State: AOJu0YxP4SXJEw4lgL0zx6j7ps8pYU8CEplAqBEJeMBvgm79ePYnde/D
 buUYkNppFOepn28qfbKKNkDZUkvJCgxvMG3Gg/6hli2yWcdiksC29j0+FesrBw==
X-Gm-Gg: AZuq6aJucbYh2igiyg5zFqL81UULCEyU0TdfThDYJOn3u3pMrRRCw6gvQM+Ahl5qasw
 v0bOS9d/1veBzVPNmQsvtPLGigprzTAfCg+Q1hcJAVj38K7gRZfnm8yV0Ox80QaVgJwBMVlA5XV
 x+9Pv8VlzEo/ekn8AFB+zaGCqoBjXsAUGWa7Yie5On/FFyvBZdG/RyMCfiMrHdM12NNubMkWTRe
 lOoHqA8Nxe+OntUFK0dDv3aT/XfNY8XZfw5aF/L8z7We073Lr/vhbyU2S5zLIZh/2q0m9XOsQDL
 PXJYG+IPSIC/9HFu3sBQL75f99vXE/KbGdPYeVWQTj1+m4icpQwtnfm47TxOcaqRU7xKLIYAUHT
 nd9VC8Qcu4R/Ekm5MWKQ/P/uMn2qg9PJTRQK5J8XX33dJLi8d3JIgQzgyw/dNq+WlfMTkdp0cb7
 rWoiQXXpyT3JLyQ0XmnNTifU1CFrM1PNYYtw==
X-Received: by 2002:a05:600c:3b17:b0:47e:e970:cf28 with SMTP id
 5b1f17b1804b1-4805d066140mr69902155e9.30.1769444115274; 
 Mon, 26 Jan 2026 08:15:15 -0800 (PST)
Received: from odurgut-Precision-5570..
 ([2a00:20:c361:3985:cfa:b5c2:f360:f511])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4804d5ffe12sm107368615e9.3.2026.01.26.08.15.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 08:15:14 -0800 (PST)
From: ozndrgt@gmail.com
To: u-boot@lists.denx.de
Cc: linux@analog.com, malysagreg@gmail.com,
 Philip Molloy <philip.molloy@analog.com>,
 Ozan Durgut <ozan.durgut@analog.com>
Subject: [PATCH 3/5] arm: dts: sc5xx: drop SPI flash from common dtsi
Date: Mon, 26 Jan 2026 17:15:03 +0100
Message-ID: <d4c06bbe3be760eeeb6fdda5adc74e9a287e2d7a.1769439596.git.ozan.durgut@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1769439596.git.ozan.durgut@analog.com>
References: <cover.1769439596.git.ozan.durgut@analog.com>
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

From: Philip Molloy <philip.molloy@analog.com>

SPI flash devices are not common across all SC5xx boards. They
already defined in the SoM-specific dtsi files. Keeping the
definition in the common dtsi is therefore incorrect.

Fixes: c9e893d ("board: adi: Add support for SC598")
Signed-off-by: Philip Molloy <philip.molloy@analog.com>
Signed-off-by: Ozan Durgut <ozan.durgut@analog.com>
---
 arch/arm/dts/sc5xx.dtsi | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/arch/arm/dts/sc5xx.dtsi b/arch/arm/dts/sc5xx.dtsi
index 483661d0b1b..9d346ae62e0 100644
--- a/arch/arm/dts/sc5xx.dtsi
+++ b/arch/arm/dts/sc5xx.dtsi
@@ -154,17 +154,6 @@
 			clock-names = "spi";
 			status = "okay";
 			bootph-pre-ram;
-
-			flash1: is25lp512@1 {
-				#address-cells = <1>;
-				#size-cells = <1>;
-				compatible = "jedec,spi-nor", "is25lp512";
-				reg = <1>;
-				spi-tx-bus-width = <4>;
-				spi-rx-bus-width = <4>;
-				spi-max-frequency = <10000000>;
-				bootph-pre-ram;
-			};
 		};
 
 		wdog: watchdog@31008000 {
-- 
2.43.0

