Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20580C61DB2
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 19:08:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8141F82B20;
	Tue, 10 Jun 2025 21:08:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Rcl/2sRU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6E7E82B07; Tue, 10 Jun 2025 21:08:31 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC82482B20
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 21:08:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=christianshewitt@gmail.com
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3a548a73ff2so2483920f8f.0
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 12:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749582509; x=1750187309; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3hnkAewes4mfprCkoFW1s2NFuezcQSNGjn/5qMZE0lM=;
 b=Rcl/2sRU7/d5usHAw/NBSzBe5DtFW5EnfoQB6WHTKnzlYrS2Et7nREualx+C9bEj3c
 5HkbsdZ36bsSM+cOFAA45M+nbc4Uh6Y62CEmSwDE+AyLN7JwV4nMWU8cy135M4rHmiFc
 ksKlhz1JfBVsFWbu5V86NwtDnf9Ka02hvhTbzdOPMyMtytmy3pzLxZkX9phbOPdYHasL
 ZsmPH0AooOTgTnnFKAJAgv+NR9vtFb1NXky9m4Nmv7zOVg4iCifsTbM1MqNpGRyzyVZR
 jMVCU54LnA3VEgkrDfmQMxm1sd7+4Injfph78udVaSzK022/7NRXDJW3saYQhjAoJ+WN
 GvHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749582509; x=1750187309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3hnkAewes4mfprCkoFW1s2NFuezcQSNGjn/5qMZE0lM=;
 b=AAS7yNYYcaZ5UTgy2rRIIX9ywm0Qri4SgqtYyo+kZ2wX1B7kapnakH6L1MAUQ3CYRg
 oNKBQ/h9+0439osSag/T8TCE0mx3KTJP006+CB+X6zOdfhn53O5pY9dJNX6SRe8ucEnx
 DqxWguV+t8rX4Xz5zLO1usLQ21O2aXJvlUkkN/MJWG3VXvGXUUCYIGptUXYwaEm6dfra
 lrZbk72PQBmcPNMQ45kzl3y7i5475PG9bf1edoa5UzJ6yfHSqPIuhzlRpr9J4MmnQqQP
 6ghI+2PRruwV8m2pPHTl5oaAHPov9AHsijK/KZl+vNgIECcAGYDrOXM42eCgRu0oCUIi
 5GGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmGiBTjreKg5VO3mLkC21+MwF1wJpDV7DpbMM2/BRxU2fhLAxW7AKWgUPHhPBjLGdO0R3JgrU=@lists.denx.de
X-Gm-Message-State: AOJu0Yw0f4skSrXZUochG7txm9rJw6bNiJNS4mUgRR4yVpFOOIOkcCm7
 PrQfqbv8Gux9274N2bg6UUI+Nq9OL4CCVwefBD8ezfBF8P7/964lrDJI
X-Gm-Gg: ASbGnctmnGGDlhQoF4a36xjGjzU9xfMsacm7j2Jio2RARuI5ihLG0/XSNkr/I4i3nY4
 +6wVBTUOVLOvf2JK7E7H3w0ZU0nnb+O8SkiH6uiH47yNBdMc09OzhyZy7InzAgZ3NWqQ5HGKCjc
 J8/Zj4DT/JipLmixUm8F0Kh6Od5ymzS8btKUSZmy2zOYRvg3SugnsvQvhooGwNGboFpy9t5N+zg
 YH36isvA3NNGN+FtFT+KJAdKvvv/9n7HpmawjUZAVwn5eAkYuEg9fgbCH/xDHR58tOVy7XWhQwd
 F8ekSL9MJog2/j0D+RmZs9FNHx+0fTd/
X-Google-Smtp-Source: AGHT+IHgBeKBuZK+MZh7sPuMUeIZzXIdewT5GB66TuAUPvPe7t375mXq/U3R1VaMUPmxmZ/jJKpDxQ==
X-Received: by 2002:a05:6000:420c:b0:3a4:e4ee:4c7b with SMTP id
 ffacd0b85a97d-3a5586f27bdmr200604f8f.15.1749582509136; 
 Tue, 10 Jun 2025 12:08:29 -0700 (PDT)
Received: from toolbox.. ([87.200.95.144]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a5323c0819sm12821487f8f.45.2025.06.10.12.08.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Jun 2025 12:08:28 -0700 (PDT)
From: Christian Hewitt <christianshewitt@gmail.com>
X-Google-Original-From: Christian Hewitt <christianshewitt@gmail.com
To: Loic Devulder <ldevulder@suse.com>, Chen-Yu Tsai <wens@csie.org>,
 Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Da Xue <da@libre.computer>, u-boot@lists.denx.de
Cc: Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 2/2] arm64: dts: rockchip: roc-3328-cc: use 1600 ddr4 timing
Date: Tue, 10 Jun 2025 19:08:20 +0000
Message-Id: <20250610190820.1462097-3-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250610190820.1462097-1-christianshewitt@gmail.com>
References: <20250610190820.1462097-1-christianshewitt@gmail.com>
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

From: Da Xue <da@libre.computer>

Swap the ROC-3328-CC from DDR4 666 to 1600 timing to boost performance.

Signed-off-by: Da Xue <da@libre.computer>
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 arch/arm/dts/rk3328-roc-cc-u-boot.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/dts/rk3328-roc-cc-u-boot.dtsi b/arch/arm/dts/rk3328-roc-cc-u-boot.dtsi
index 582d6ba49b4..c47d29c59de 100644
--- a/arch/arm/dts/rk3328-roc-cc-u-boot.dtsi
+++ b/arch/arm/dts/rk3328-roc-cc-u-boot.dtsi
@@ -4,7 +4,7 @@
  */
 
 #include "rk3328-u-boot.dtsi"
-#include "rk3328-sdram-ddr4-666.dtsi"
+#include "rk3328-sdram-ddr4-1600.dtsi"
 
 / {
 	smbios {
-- 
2.34.1

