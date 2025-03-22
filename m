Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0001DC36002
	for <u-boot@archiver.kernel.org>; Sat, 22 Mar 2025 18:39:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3258881BC0;
	Sat, 22 Mar 2025 19:38:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="l/7C4DMe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8898681D4F; Sat, 22 Mar 2025 19:38:47 +0100 (CET)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EF29810FE
 for <u-boot@lists.denx.de>; Sat, 22 Mar 2025 19:38:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7c592764e54so376356485a.3
 for <u-boot@lists.denx.de>; Sat, 22 Mar 2025 11:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742668724; x=1743273524; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sir0FUv0xPJ+DDY9BCOswbpmFgvsHYbytgH2UQU40h8=;
 b=l/7C4DMeXIErgYnpB8L3R4tuChGEv2PQ21RclJSz+dvKpwAh4kYdV3RLzxf9WAj7u7
 mgxEc5W6DkId7ELuFvQednEVgGPBOkVaODzddEAMEzs/sZEQfEktgDb7OJ7BkdmxVqs6
 q2EN9bobSX6W/29i8xLcFG93WfBcKqMw4gGO2gpwUYz7VHkaT4GqgMAzRFM1R1iag2Z/
 9PqnTeGK13bMOZc5I02a7AeWNatem062gQJ+J4CajaepxhG/zyTxTf2Y15ft3GMN+T07
 GGNluAmeh++8pgw4tgdutgazfM+MNjQkfEkeaEYs1ghFewJyQ9KIlKxRxYqNwEP8aq2R
 1Gzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742668724; x=1743273524;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Sir0FUv0xPJ+DDY9BCOswbpmFgvsHYbytgH2UQU40h8=;
 b=A3kT2TRlQth5BEDwoFg9KB+VCSi4OGo+bHjUPKw9XeEEybELosL8a1+QovuFWr1WDC
 Rv7AnHAKLT6aBFQ14EVW8UqnTCJGCE4tckJ9uKrxHhKILbvc98u+PrR9MDb9KB2+bzjM
 c61WNvT1Yfx00nXbfwqpQ5ATWXkUKoCTkSccTHkJjEh1E5jJcD+WZI7MVg+b913MvZwV
 MDUdXkqN7BXJNqVbb/0lOq9GzeZir8eTb8+uQmKMTpodsWFrlvAD68iz8fFT1PI/CJ5o
 c60G1IRoI+Y5xTtWPOgHZt2eia2on6YYj3ebQvmTaeu9a4INsw/sXC+Itx1x0H9iK+Wy
 pfLA==
X-Gm-Message-State: AOJu0Yz7jJdm0MAF/4BEdPDe0oSvpvv5TIhXkfvaWsfu2x+6xNup/rHz
 fpjZ5NBQVTQwIiGRvq7EqtF8HuvQLERSYE7T00tDDXYnAfV4Vi35VZ2JiA==
X-Gm-Gg: ASbGnctN4mwjQs0mpJBFEAxLgHPSwfgIBzS2lNOQKc0UGnjpTmzyQHzWcTULYQ3AXfj
 sInrvaPhSjplD2ixqYN2WH8rovUHWlWdho6t0OrzFy+SBJdIZX2cF9juHuzlsDUE/f9voYhIyzK
 jCTHWt04usIM7kjpZvW5EXTPRa2mENgBxmXfi1dXKFUezohhpXylBmU9jsGhe6mRnPXKxjjtrEM
 kmS52xet/xWtrr1MwCWRRL2+B36szjapRNj/XqK4gpH2+iz+D3vqiIb/Sn5ssX6N4j52YR40RaL
 BY0e6EuBMqxmRaDJEa17lT3ZNmttOG0+Q3tr9sa8EI12vgiDakRmzpVVM+cxXI4b1jsuN4VaD82
 qSkq1I9Havkz2I5lmUbI=
X-Google-Smtp-Source: AGHT+IFsG0p93jijpHWX+QrNnnTzZ3/hOuMd8ujGchxNtaOrPDvILggwU4UdCml4kQw9gA9YZPdbVQ==
X-Received: by 2002:a05:620a:46a5:b0:7c5:4738:8a0f with SMTP id
 af79cd13be357-7c5ba1476f2mr958917785a.15.1742668723472; 
 Sat, 22 Mar 2025 11:38:43 -0700 (PDT)
Received: from aford-System-Version.. (c-75-72-162-184.hsd1.mn.comcast.net.
 [75.72.162.184]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c5b92ec648sm278126185a.61.2025.03.22.11.38.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Mar 2025 11:38:43 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: u-boot@lists.denx.de
Cc: aford@beaconembedded.com, marek.vasut@mailbox.org, festevam@gmail.com,
 Adam Ford <aford173@gmail.com>, Stefano Babic <sbabic@denx.de>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Enrico Leto <enrico.leto@siemens.com>, Heiko Schocher <hs@denx.de>,
 Peng Fan <peng.fan@nxp.com>, Yannic Moog <y.moog@phytec.de>,
 Gilles Talis <gilles.talis@gmail.com>,
 Patrick Barsanti <patrick.barsanti@amarulasolutions.com>,
 Ye Li <ye.li@nxp.com>, Christoph Stoidner <c.stoidner@phytec.de>,
 Wadim Egorov <w.egorov@phytec.de>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH V3 5/6] imx: imx8: Imply CPU_IMX by default
Date: Sat, 22 Mar 2025 13:38:07 -0500
Message-ID: <20250322183812.784676-6-aford173@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250322183812.784676-1-aford173@gmail.com>
References: <20250322183812.784676-1-aford173@gmail.com>
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

The imx8_cpu driver is a CPU Driver that supports the i.MX8Q
family. When it is enabled, it acts as an alternative to
arch/arm/mach-imx/cpu.c, but the imx8_cpu supports the driver
model where cpu.c does not.  Imply this newer driver by default.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
 arch/arm/mach-imx/imx8/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-imx/imx8/Kconfig b/arch/arm/mach-imx/imx8/Kconfig
index 9a43beda6fa..257c14e61b6 100644
--- a/arch/arm/mach-imx/imx8/Kconfig
+++ b/arch/arm/mach-imx/imx8/Kconfig
@@ -9,6 +9,8 @@ config AHAB_BOOT
 config IMX8
 	bool
 	select HAS_CAAM
+	imply CPU
+	imply CPU_IMX
 
 config MU_BASE_SPL
 	hex "MU base address used in SPL"
-- 
2.45.2

