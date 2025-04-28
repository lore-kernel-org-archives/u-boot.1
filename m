Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55743C369D9
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 17:12:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3985820EB;
	Mon, 28 Apr 2025 19:10:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="YPwymvQ/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D429A820B7; Mon, 28 Apr 2025 11:16:32 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4F3082162
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 11:16:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-39c14016868so4406029f8f.1
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 02:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1745831790; x=1746436590;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Rov5p8hQSLdNo/D9JPD/Jf5oHMe60Xd9gvYtJ0YxTok=;
 b=YPwymvQ/qy5LIoBstvCRUwQuyEt2BkViubc6ZTPRSd7g0TKp6ZfTUEB7f4OBwdOrG1
 TrwMiu7pv/Poixk+/EyjDJTKLYFeqevFktP9VZuI8ZHDehb13tW5e+QMMMUsMT05gD3W
 3XxmPBuD3U4vW9ftkymBHSNw8hnvxv7VzXy3i+ChbfxkJBAYZVqR7Ls1N7bjGolex30A
 kXxW8whfbgl6puyHnudaVzon/zp6YEe+KLQDbmJV8aj+l40CPj5GzGpUem2CZhZktD6J
 MtC/1moM7oBaVxyKex0X00H0AP70cdhrUib/ZLUVv2mtm2jmGqRlL36Iq61KMZAKNfZ6
 89Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745831790; x=1746436590;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rov5p8hQSLdNo/D9JPD/Jf5oHMe60Xd9gvYtJ0YxTok=;
 b=UKfH/1yFw4gZzDBoBJlh51XAzmMdyp0iMzsCcaP1BfNZGWT/R4WsjTkXxsgFEdHU63
 +ZQbUTLsE/yfettWzqH2T4CYpMkFNYeop9p6ugstFvD2MJM2Bl9WSCKZsltFP0ttrcVm
 t99x3Zd145+AJR2jotF78/zKAhyupr0EiGcGRB5zzygv9CrjKCVOIEcuqOH16LrCS/st
 EcYCiXUC1WB+uGo+2AXP77gOU9hHYTk/LOBYqDxetuAVEBCjz8fkq9yQddT8obDfepBk
 KWFphItQk1AVhRnw45G0jQ6olCTpVKF2SNrHhovxGiMIvdoJyl3awXwz/IeC2ORnCHaq
 sfGA==
X-Gm-Message-State: AOJu0Yzd1g47PxDJK3azrrejO2m7VxtxyzIf4aWmiolVT5h7xYnZ5hxj
 ebXbQS6OksxEwxnoA7OJUPqNAuT0+UfukasYSXAYKoSZQfsk0s4fHOZsrKjXV1g=
X-Gm-Gg: ASbGnctLhDjzmtDF+/CnVJDFpiV5P2pMrDmp3YSILPsvv65tB9zSJp+mGSauee1VeBs
 3C6QNZN2E1PXqWr1TF6MxCM0kLTqU7QMVrx2JvPntUOiEv+1bRLQU3uIHmICbz+pq12o4k0qWgm
 4NyH6peWkex/olExR04eRuK0GN1b/C6U5uRiGu/Q9Z0g90EGYDCz0+mQcR3hr7DzsG6rtdA2gH8
 JxhETyu2K6KeWw4S39LvkfpJyJpHZbmAT0sJm9QtqslMa8+mYWNKZWRyBFGKavbtyRjLFIfOmkQ
 CP/Qaqh3n/jeLhNWA88/YWQN+vHOn5ViSAiokmA=
X-Google-Smtp-Source: AGHT+IGao808jay9TlNY7XTcKH1wB8HJyEV7lcQhXqyiFi9YAjaWMWAsIpLPm74Dgs0xXidvSxxnjw==
X-Received: by 2002:a05:6000:4284:b0:3a0:836e:4a26 with SMTP id
 ffacd0b85a97d-3a0836e4a7cmr2581589f8f.37.1745831790332; 
 Mon, 28 Apr 2025 02:16:30 -0700 (PDT)
Received: from [127.0.1.1] ([78.199.60.143])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3a073e5da0dsm10345258f8f.88.2025.04.28.02.16.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 02:16:29 -0700 (PDT)
From: Zixun LI <admin@hifiphile.com>
Date: Mon, 28 Apr 2025 11:16:27 +0200
Subject: [PATCH v4 5/6] ARM: dts: sam9x60: Add watchdog DT node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250428-wdt-v4-5-bb7d1c7c051a@hifiphile.com>
References: <20250428-wdt-v4-0-bb7d1c7c051a@hifiphile.com>
In-Reply-To: <20250428-wdt-v4-0-bb7d1c7c051a@hifiphile.com>
To: Eugen Hristev <eugen.hristev@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de, Zixun LI <admin@hifiphile.com>
X-Mailer: b4 0.14.2
X-Mailman-Approved-At: Mon, 28 Apr 2025 19:10:16 +0200
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

Add the watchdog timer node for the sam9x60 SoC's.

Signed-off-by: Zixun LI <admin@hifiphile.com>
---
 arch/arm/dts/sam9x60.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/dts/sam9x60.dtsi b/arch/arm/dts/sam9x60.dtsi
index 7631dfaa07fc1e7c605c70840da1196c1daeb638..79449042c24f90686613f0082f40d4f2c13f122f 100644
--- a/arch/arm/dts/sam9x60.dtsi
+++ b/arch/arm/dts/sam9x60.dtsi
@@ -311,6 +311,14 @@
 				clocks = <&slow_rc_osc>, <&slow_xtal>;
 				#clock-cells = <1>;
 			};
+
+			watchdog: watchdog@ffffff80 {
+				compatible = "microchip,sam9x60-wdt";
+				reg = <0xffffff80 0x24>;
+				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+				clocks = <&clk32 0>;
+				status = "disabled";
+			};
 		};
 	};
 

-- 
2.49.0

