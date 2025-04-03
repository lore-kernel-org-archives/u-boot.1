Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAFF2C3600C
	for <u-boot@archiver.kernel.org>; Thu,  3 Apr 2025 15:11:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 379F182075;
	Thu,  3 Apr 2025 17:11:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WUeOQSRZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AF218210D; Thu,  3 Apr 2025 17:11:05 +0200 (CEST)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 054BC82054
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 17:10:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2243803b776so15992165ad.0
 for <u-boot@lists.denx.de>; Thu, 03 Apr 2025 08:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743693057; x=1744297857; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/O6dEoG4CU4vMb5eKi+n5gCEI8FXU+lIb127wbKmTWI=;
 b=WUeOQSRZR/XiUZNQHzJBZCtI+DNdqPIWTHGuWe7illMLQY/a/DmI2ehmqUmMPsgdgD
 yifwwKYZ3gBobEcz6DqwT3pIjQvZJtsyLjSDYR9d1ei8csqfJB34VF5jAk8/D/hwfKPC
 pIq3gFqfzIbUizQ7+GqeZIVVwk81cNmagf/Ji7hVGzJzyc0rTQN3Vehphn8jtQJJvsGq
 Ci9PUY5BRadvPaix6G7UbNyZRtTxbERDCuag2vhO55lx5PgIAuC7Kr5maeGXrN6XsFu4
 J/RdZU9hN70Ug5YBwLkf+5weUFg5ikTQxBH2jN9BvkcBzRIGtKLzRJUU4yrah/NOUgZL
 PJZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743693057; x=1744297857;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/O6dEoG4CU4vMb5eKi+n5gCEI8FXU+lIb127wbKmTWI=;
 b=Tmg+tKOnn5e9HH4gziPRhDfVIoEVKPvBjbheOxV3aO88/4XBNv/b9FGE0dsmtVS4qm
 yY3tGe2JhSMmtwKw1NKzaaP6ePe9AzduJIYQ0E9SwL5Ryhmit2laR4kNgDlU65S+1BO2
 Aa5sAc0Dr7YTjq3qCnyIxOai3OCrt09UY4IzlKaLs5hWVPuhAr5I58IXFu4aQXcu6c0S
 fblXKqV6kPoxYf0mSpwzu5Tgp5V+WcglaIGtscoYV8HnoGUn7TT0YDtR56hp6sU6sOJO
 h1+lr+NeoVPflJqwCkgTNVViFcOWnQ3J5mZjFivocS0WI2ML/hb2vNq0x0yDVYuOS+Py
 FDMA==
X-Gm-Message-State: AOJu0Yz3hg8tK3EhB/PpJ2q2WJwhhVuK7CB9/j+eOdnaAsULagXC+waD
 tWjfQ5C2O9buRyIO/CfYbYjXBcxeIZKP1DAPXC/yZgo4vyeHhv8AH2MO3w==
X-Gm-Gg: ASbGncskMO+yzOQZck2eUGk2fy4YgFwMYcjhxElc4yQhwzM4vvpwhePHXRNeuJ/ac8X
 fEBZZ7ojMHsRfJ9QqF3jalkf7AMt8gD/ZNAg3eO8dGV/R3HE/ccOauBmythTV4gFOTj8zPTRBFA
 85cdhqPEgx2bORk9jHYhxamQntlDQkEoutyfGuibXg3vNEKokO6FI2ceKkhs9SDSpXBwworJHez
 9fzdqndwMn8WqFrVcpX89Qw0SzSj8x82vO5zZTIre1QOqLg5WUySOMQ82ggnCAvY6wi7LaO5cu5
 ZHAvCDCIyoJM010wdCskg619yaGgeuHlcNyth16LaAXan4nYZ4xLtN7+FPY=
X-Google-Smtp-Source: AGHT+IFjd8tY2BlQIKF5aRwksfe8EZZCUD8F698nbLBHfMzdi6lBHvtsJEnZzbSjAsY9CeC6B7TQzw==
X-Received: by 2002:a17:902:f610:b0:223:501c:7581 with SMTP id
 d9443c01a7336-2296c65f1fbmr92021335ad.16.1743693057486; 
 Thu, 03 Apr 2025 08:10:57 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:19ac:36de:449f:c706])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-229785ad9c3sm15691885ad.30.2025.04.03.08.10.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Apr 2025 08:10:56 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: eugen.hristev@linaro.org
Cc: u-boot@lists.denx.de, trini@konsulko.com, Fabio Estevam <festevam@denx.de>
Subject: [PATCH] ARM: dts: at91: sama5d2: Pass bootph-all to the PIT timer
Date: Thu,  3 Apr 2025 12:10:50 -0300
Message-Id: <20250403151050.3649150-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
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

From: Fabio Estevam <festevam@denx.de>

The PIT timer needs to be available early in the SPL phase,
otherwise SPL fails to boot and only prints:

Could not initialize timer (err -96)

Fix this problem by passing 'bootph-all' to the sama5d2 PIT node.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 arch/arm/dts/sama5d2.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/dts/sama5d2.dtsi b/arch/arm/dts/sama5d2.dtsi
index 7b62fffb4ff..62191ff5d97 100644
--- a/arch/arm/dts/sama5d2.dtsi
+++ b/arch/arm/dts/sama5d2.dtsi
@@ -778,6 +778,7 @@
 				compatible = "atmel,at91sam9260-pit";
 				reg = <0xf8048030 0x10>;
 				clocks = <&h32ck>;
+				bootph-all;
 			};
 
 			watchdog: watchdog@f8048040 {
-- 
2.34.1

