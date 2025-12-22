Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30240E69167
	for <u-boot@archiver.kernel.org>; Mon, 22 Dec 2025 20:04:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8007683EC0;
	Mon, 22 Dec 2025 21:04:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FTUNn7tL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5082E83E70; Mon, 22 Dec 2025 21:02:57 +0100 (CET)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5114C83B99
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 21:02:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x342.google.com with SMTP id
 5b1f17b1804b1-47798ded6fcso24649245e9.1
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 12:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1766433770; x=1767038570;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zimDLWe+R6g4KrPX4q8XkSHuS6mFsYagnzp4PJDzHkw=;
 b=FTUNn7tL30cS35b099FLlZPjoYj+fkOGXew8sq8M76gp0zoqAU73nKXyfRYn33ak0Q
 gXn9B9nAtTfTsdoBamBWHAyxTMDyIcW/hzetunhuKVSrfxCtYraiAM3ffGpqAU8L8ttQ
 l9Kgp4J3esxL1fmu0SatxrBTfDDVimZ3QA8rmwDf4Ihcpls5tDj3WgQ3fVOXYasEYJke
 2b6EasgWzfS2sVP+340QsttN3pBg1L1tI7esdXmFTt39TEdn9ZTLHiarpz/zMT3Avtk3
 Po6I/XmG/06cXnaKlWKSICzMndYfXh7mFf/RYZRp9xvCKyHpw7Mt3F6fFY1nBYEBMFGV
 YKdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766433770; x=1767038570;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zimDLWe+R6g4KrPX4q8XkSHuS6mFsYagnzp4PJDzHkw=;
 b=YRN/WOt5632sgWdfjtTWhkji9AUwiqJWIYrTbtfopLH7G00CL9vOaZ8t4ov2JiInZb
 hjEE9mYNWH0Ujg4vO4htekhHDN6Q7VgJru8YT6V3/Nwzx2amycwf9Gr9/06lvVzIKi/1
 Px8jmRluOPNSln1ICctzHLYTvsr7+t/9rgH5z/9igK/nvSQjZwPydUGAz/DHrpzUpAiT
 ssvRK3FExYoEXZj8sUKd97Jr5sjLjALxndByohn/TtAsYCTESGgiYbVfqOFq3GCPTcHV
 v0lhSX61uKusU9takUscNW9QxRIT6TYQnkOIbTSR35P7ngheNYzwTq3I+Q+pqCkGQb3v
 qdpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMTgJ+vN98C/xdGTwsU79sTD7yG/9UlTIK9TvFw6e2Rr8fwd5GnEl1Al8BI8q/DMn+RdvQJdc=@lists.denx.de
X-Gm-Message-State: AOJu0Yzmc/sKsm0/ip2JC7vp4pR1vfFab2sgNqB7cMW71nPobeB+Z3iU
 NeiGAOyfOB7x/iOACVcRBfAsovi9KaExK0Ix4/QfY+44Hb06qi66fFAUAj3m05IAu+s=
X-Gm-Gg: AY/fxX5M/stittNT//akdhm2fsmBDdCTeiqPJIBOWM+C3tObfT2A+XbjXpWyzbKb0Kt
 MVQF1n5lL0hc41hnpn8ToZ7NL+XF7ms+wwNTjWSKWpME02xgMDddDz5c5mzzlUqBbrW314W74yW
 hBgqsubChoK1YHHtlwBESM2I/qFNA+rdf98l6vtjw80MDr3EK+s6T8/4G/DhFK6oqNUDpdTzTqS
 zCnPgHR8/If+ssSe/W0dLQ8b7SvainYTYSWKA2hmj//oHL3N1XXT4WlF33FRQmdbwVb8M8DrC9p
 hvNGUGLjwPqGK7t7+2u7tDnHNSGbKY5jZXIq5g0BKQDXq7go97GPChS2MokkNQvI/1WygWhX7uW
 Jt+pWssBxqUj5HBjO9QsLSB8ZO+x8JJeKPc9mv5czwwRyT0Kpg5CaZm40xFzmVgU9aBvEgJyjYG
 1vuCiN6ehb
X-Google-Smtp-Source: AGHT+IH3dipVXtoX5qjYga1eHeVFrF6e04spJ/4KU01GCGFAbeMyLsVmi6IjMks4rViILE64mUEsJg==
X-Received: by 2002:a05:600c:4f15:b0:477:b734:8c41 with SMTP id
 5b1f17b1804b1-47d19538dfbmr142396325e9.1.1766433769696; 
 Mon, 22 Dec 2025 12:02:49 -0800 (PST)
Received: from localhost ([2001:4091:a246:82fd:4350:c3d9:84a3:70dd])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d19362345sm205352645e9.6.2025.12.22.12.02.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Dec 2025 12:02:49 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Mon, 22 Dec 2025 21:01:22 +0100
Subject: [PATCH v8 01/13] arm: mach-k3: Kconfig: Add symbol for IO+DDR Low
 Power Mode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251222-topic-am62-ioddr-v2025-04-rc1-v8-1-e70fed16b166@baylibre.com>
References: <20251222-topic-am62-ioddr-v2025-04-rc1-v8-0-e70fed16b166@baylibre.com>
In-Reply-To: <20251222-topic-am62-ioddr-v2025-04-rc1-v8-0-e70fed16b166@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>
Cc: Vishal Mahaveer <vishalm@ti.com>, Kevin Hilman <khilman@baylibre.com>, 
 Dhruva Gole <d-gole@ti.com>, Sebin Francis <sebin.francis@ti.com>, 
 Kendall Willis <k-willis@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, 
 u-boot@lists.denx.de, Anshul Dalal <anshuld@ti.com>, 
 Moteen Shah <m-shah@ti.com>, Santhosh Kumar K <s-k6@ti.com>, 
 Nathan Morrisson <nmorrisson@phytec.com>, 
 Garrett Giordano <ggiordano@phytec.com>, Judith Mendez <jm@ti.com>, 
 Aparna Patra <a-patra@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>, 
 Chintan Vankar <c-vankar@ti.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Prasanth Babu Mantena <p-mantena@ti.com>, Beleswar Padhi <b-padhi@ti.com>, 
 Manorit Chawdhry <m-chawdhry@ti.com>, Andrew Davis <afd@ti.com>, 
 Wadim Egorov <w.egorov@phytec.de>, Udit Kumar <u-kumar1@ti.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, E Shattow <e@freeshell.de>, 
 Devarsh Thakkar <devarsht@ti.com>, Peng Fan <peng.fan@nxp.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Andre Przywara <andre.przywara@arm.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1035; i=msp@baylibre.com;
 h=from:subject:message-id; bh=Op+O6gzW8LIXkNV/KvnP7P+ut0cXOoRR7MXS+CuUb6I=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkzPxXPEuzrYlYsnZy2Za+vS2D7rpbbolyDrvPnhLefCT
 K/+qOHtKGVhEONikBVTZOlMDE37L7/zWPKiZZth5rAygQxh4OIUgInEiDD8dxI3vrVz/6p5DNsU
 9+XYqtQ6XWR9G/btdOs7iXDtC7wzFBgZltWvncPXXeLO4Wj55+TZLjt7Lm1v1uYlNwPnCORztxz
 jBQA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Mon, 22 Dec 2025 21:04:36 +0100
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

Symbol to enable support to resume from IO+DDR where the SoC is turned
off and DDR is in self-refresh.

Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 arch/arm/mach-k3/Kconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
index 1b8c0b1eb968f0414107c0bf3142f744ce8364c8..4b7cef64935c7b403051c080eba7bdb48f727bf1 100644
--- a/arch/arm/mach-k3/Kconfig
+++ b/arch/arm/mach-k3/Kconfig
@@ -148,6 +148,14 @@ config K3_DM_FW
 	  bootloader, it makes RM and PM services not being available
 	  during R5 SPL execution time.
 
+config K3_IODDR
+	bool "Enable IO+DDR Low Power Mode support"
+	depends on SPL && (SOC_K3_AM62A7 || SOC_K3_AM62P5)
+	help
+	  Enable support for IO+DDR Low Power Mode. If this is enabled and a
+	  resume from IO+DDR is detected, metadata in the DDR is used to
+	  restore TIFS and resume DM.
+
 config K3_X509_SWRV
 	int "SWRV for X509 certificate used for boot images"
 	default 1

-- 
2.51.0

