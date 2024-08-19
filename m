Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 551AFC3DA4A
	for <u-boot@archiver.kernel.org>; Mon, 19 Aug 2024 15:03:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 215FE88CFA;
	Mon, 19 Aug 2024 17:02:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nGzAF8gu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19AC988CFF; Mon, 19 Aug 2024 17:02:13 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8455488CED
 for <u-boot@lists.denx.de>; Mon, 19 Aug 2024 17:02:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7094641d4e6so1726751a34.3
 for <u-boot@lists.denx.de>; Mon, 19 Aug 2024 08:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724079729; x=1724684529; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C0tFfXayi3urLhZKNL3vguNmsKHroWu87sYhuZkNjDs=;
 b=nGzAF8gunV88O3Npn52X3uVEOEESEXKxP9JFQF1w78OSPbvZtc+6bZo8skk5GzL54f
 DAX8EI7t1y2l5uL69VoJVOburUK4UnAw9T0Aa6ASkEsuSBy7/ImTjKNZiGzcQBSPkRho
 /tl6aJUwISXyk9tCsjWaz53EY7aiHvj9m+D9QGoSmmB9A/8gysv7OuGOayRaLS1AP1am
 4X9veaMqs6zBkCU5k5BqOzZmR3F0/CKtTB0+YN2jWLtcGoHuLJEmVVfmkc4eymp1dzx3
 RlkhtKmM9BaTbmN19HDkN3deD86s93u7LLBYoGVUInckLCIJ4wfql0Nou1+Lnwm2z96J
 CYFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724079729; x=1724684529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C0tFfXayi3urLhZKNL3vguNmsKHroWu87sYhuZkNjDs=;
 b=YEBRxHZg2HVwwDOpArzk0ZMwkplUc9rgmC1lzPgleVLgYGkXmbNG4tJTGfQYzv+DQi
 c3mPnAsi+KphyGaP43mdbPLNCw9YeR6GlY8fhychXL6+MmryAcdGcrM7WUeyEvvToz5A
 MYnQyBL3t612x5uSO2qGk2BVc5/G2SGjGUoGSkHX8Q4wrN4klxDWdAHa3iPXGiOmRBRE
 Gwe2YB8dISP3yUbnHhXJ5dyJaQtrWQiUotQyrT5bD/XcoIJohvPScii4MEDIM7HeenmF
 XuY8hCp2tPbsvnxHaTGrkFXdbdzqjoRQM1b+2MBtq9tdyf3hoqWNmg1/CZ0uSuL23Ukk
 gcRQ==
X-Gm-Message-State: AOJu0YzAP9fQX23i9YSIJxPxhZBo8w54lM9V81kr1UlqUL/xi/847QkR
 MAw5lyAs/pMZythsv5c3S3bwBSgXdKOoN6ghIT8azQBXb0/Kmu4TjhJrig==
X-Google-Smtp-Source: AGHT+IH8NUxaXdLo7mWZx2C4Z9V3JNgksBmbWF5RRww8JjuecrZvMYCDjeW4OaeGi3scxyHF7da5Zg==
X-Received: by 2002:a05:6870:5251:b0:260:e3fa:ab8d with SMTP id
 586e51a60fabf-2701c52e424mr12734036fac.37.1724079728780; 
 Mon, 19 Aug 2024 08:02:08 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf::54])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-27004432d18sm2945189fac.7.2024.08.19.08.02.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2024 08:02:08 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, jernej.skrabec@gmail.com, neil.armstrong@linaro.org,
 hdegoede@redhat.com, andre.przywara@arm.com, jagan@amarulasolutions.com,
 trini@konsulko.com, ryan@testtoast.com, iuncuim@gmail.com,
 sumit.garg@linaro.org, Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V2 8/9] arm64: dts: allwinner: h616: Change RG35XX Series from
 r_rsb to r_i2c
Date: Mon, 19 Aug 2024 09:59:37 -0500
Message-Id: <20240819145938.503221-9-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240819145938.503221-1-macroalpha82@gmail.com>
References: <20240819145938.503221-1-macroalpha82@gmail.com>
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

From: Chris Morgan <macromorgan@hotmail.com>

Change the Anbernic RG35XX series to use the r_i2c bus for the PMIC
instead of the r_rsb bus. This is to keep the device tree consistent
as there are at least 3 devices (the RG35XX-SP, RG28XX, and RG40XX-H)
that have an external RTC on the r_i2c bus.

Link: https://lore.kernel.org/linux-sunxi/172252952262.1669767.7675865282122079154.b4-ty@csie.org/

[ upstream commit: c712e5d0985628b1df13930489b49b740e610a2b ]

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 .../arm64/allwinner/sun50i-h700-anbernic-rg35xx-2024.dts    | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/dts/upstream/src/arm64/allwinner/sun50i-h700-anbernic-rg35xx-2024.dts b/dts/upstream/src/arm64/allwinner/sun50i-h700-anbernic-rg35xx-2024.dts
index ee30584b6a..e2bbd22bd8 100644
--- a/dts/upstream/src/arm64/allwinner/sun50i-h700-anbernic-rg35xx-2024.dts
+++ b/dts/upstream/src/arm64/allwinner/sun50i-h700-anbernic-rg35xx-2024.dts
@@ -201,12 +201,12 @@
 	vcc-pi-supply = <&reg_cldo3>;
 };
 
-&r_rsb {
+&r_i2c {
 	status = "okay";
 
-	axp717: pmic@3a3 {
+	axp717: pmic@34 {
 		compatible = "x-powers,axp717";
-		reg = <0x3a3>;
+		reg = <0x34>;
 		interrupt-controller;
 		#interrupt-cells = <1>;
 		interrupt-parent = <&nmi_intc>;
-- 
2.34.1

