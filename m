Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 906F4C021A4
	for <u-boot@archiver.kernel.org>; Tue, 25 Feb 2025 01:45:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B124C80977;
	Tue, 25 Feb 2025 02:45:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ksyqk4wQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B711480EC0; Tue, 25 Feb 2025 02:45:21 +0100 (CET)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73E0280540
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 02:45:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2230c74c8b6so2892265ad.0
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 17:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740447918; x=1741052718; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Pa+AM5wKeo/OQnzbaaeoR1jc2Kpan0caGmuhPRFoY8w=;
 b=Ksyqk4wQhytLBUk7Elk9nvjJxZg4Xxk6pk6LAzVNtgTLp86vi0R4h91ef7nIlyjJkC
 P7U4Klh2l5oRbqRJaWwhzuoAtq+8PD0xiTEHB9gel2UBGvRt1TudTH3EI3FpTjC7ij/R
 OZUNiW6tb5B1UdW/JlaepWY9ARiHcyvOWK7YWd/8pfrYkz45UbVk2AWPIwq6geaoKM5d
 NhbHnjSZUqL0xn/P2m+6EEnenBU6JQQImBunrfXfs3fCojT7J1drdzrYglMA3D+WPX8m
 zMrcxDprvvioLW/JuAxnSNcduYRxoqIPQhUdA3PS8bpvGHvNCbAbS6mU2y6cnxDrV0o+
 +IgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740447918; x=1741052718;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Pa+AM5wKeo/OQnzbaaeoR1jc2Kpan0caGmuhPRFoY8w=;
 b=KBd+/pzZcvcmCwExCbSM5IFM7nRGs/nsw9tnyRszt5ZuT4h98g5QzjXhLR8F5/l3yO
 pYro9u+4ZGLCKFNTdlbGPhsX2kwSFpwDhqGCCsCUMCj3KjH1LNxAgJ5n93ff6okiqB7G
 oBMHpngbCaROuamW54RLOMw2Hdkbt01zwKrG0YldW1JCYAt4QqpD+b66Om7eKaJy7YBq
 +XJV+gSvLa9nZawR8uVw00CiA2JG/6wTjd/TIK7OXPwrSHYUAsxzShXRHNKlRDLF0lSP
 ByG3Ctceo4LoCtabeVw2eTHwY5qOA03rg9+77VZYzn33SHkaFlTr7Xyqf7DwH71wT5fv
 9cEA==
X-Gm-Message-State: AOJu0Yybsm5nTYorBOlYPLbeGFUHw56LvTcG+8JRQyN2VSS82HT0Ul3n
 jZlOeu340HQp96ko7cTKsVI45R7iyVW8nQaVapE/Y6u+iBPs/UF8
X-Gm-Gg: ASbGnctLPDGAon6nOWrAbyBh7GlYh7AERJEQNOXsVl1VACAgzd/wRdLi1Cl7q7cHOJq
 PgVSOg8YJtHnpgxHJEdd2JEpc+aUZ7C++XS1Bm/jvfXgTt6pNmvvoQH5FiisnxqQ8LSowTegsQQ
 zoBXwZ28Vy50OBH3Uh9bA+gM6qOOcFojGk+ktUsYgQzpKLn2vymfiEoOZeiI4+jKrxVT4fmseVn
 pAR2ucj7dI3lmtgHHQqe0fdnXgYScI9xp7pkhnqT9OJIZVqFvzS1MeL3G9P63Mmy+Qjy4H/zfqd
 05Kz8rCVbCt0z7h2pkQZKvRe6MmEuE2v8mdQjA==
X-Google-Smtp-Source: AGHT+IGYDEVZVNxUXCy4lzcD4PHDrqgxIf1xsolRVotZEY35r26omchoLE1LFjXAvcI0mZ3FjZHyyg==
X-Received: by 2002:a17:902:ced1:b0:21f:85ee:f2df with SMTP id
 d9443c01a7336-22307b496fcmr19466645ad.15.1740447917913; 
 Mon, 24 Feb 2025 17:45:17 -0800 (PST)
Received: from cs20-buildserver.lan ([2403:c300:cd02:bc36:2e0:4cff:fe68:863])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2230a01fe8bsm2715265ad.54.2025.02.24.17.45.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 17:45:17 -0800 (PST)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com,
	jim.t90615@gmail.com,
	trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v1] arm: dts: npcm7xx: correct the timer node
Date: Tue, 25 Feb 2025 09:45:05 +0800
Message-Id: <20250225014505.1913214-1-JJLIU0@nuvoton.com>
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

Correct the timer node of dts

Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
---
 arch/arm/dts/nuvoton-common-npcm7xx.dtsi | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/arm/dts/nuvoton-common-npcm7xx.dtsi b/arch/arm/dts/nuvoton-common-npcm7xx.dtsi
index feb88872fc7..093d5427e30 100644
--- a/arch/arm/dts/nuvoton-common-npcm7xx.dtsi
+++ b/arch/arm/dts/nuvoton-common-npcm7xx.dtsi
@@ -95,6 +95,11 @@
 			compatible = "nuvoton,npcm750-rst", "syscon", "simple-mfd";
 			reg = <0x801000 0x6C>;
 		};
+
+		timer0: timer@f0801068 {
+			compatible = "nuvoton,npcm750-timer";
+			reg = <0x801068 0x8>;
+		};
 	};
 
 	ahb {
@@ -245,13 +250,6 @@
 				status = "disabled";
 			};
 
-			timer0: timer@8000 {
-				compatible = "nuvoton,npcm750-timer";
-				interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x8000 0x1C>;
-				clocks = <&clk NPCM7XX_CLK_TIMER>;
-			};
-
 			watchdog0: watchdog@801C {
 				compatible = "nuvoton,npcm750-wdt";
 				interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.34.1

