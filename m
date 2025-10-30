Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEABBCCF9FC
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 13:02:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 552348393C;
	Thu, 30 Oct 2025 14:00:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="UAOe1184";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B17C6838D7; Thu, 30 Oct 2025 11:01:31 +0100 (CET)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1018800B1
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 11:01:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-4283be7df63so407943f8f.1
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 03:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761818489; x=1762423289;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ezDUt8ZSTUAkzpv9jxjK0FauMuSqIsQ3/ODVn1cb3Dw=;
 b=UAOe1184DL93eph+W7YeK26U54paHrMAHZuBZXfLIkxkNcszLAemlbR2UnPfITE52v
 LxWmlzmNUouoc+xEKW5pzO/+I2cxrR0UGv43C24tmBJD2IAqMtLQSm0SSGpNxV25Qthp
 kVVCoiiJWBMReWvhor28ZBCLOT6Bzj5mLxeOFDm+730ZdPPUNSBXM62aivmxjQuMPmiH
 i1F08L5/cHP57m1s8KKocYJPJ4lHhyTIrgHaf48c0ciGFWVbefXiZUaIdnuO2UrTULQT
 YH7MuruMn4psWibM5MO+Q+BsZOGVyBg80wKp0r43fICWLLaxMnokL+0djOfEQWDwEU3y
 Hd+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761818489; x=1762423289;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ezDUt8ZSTUAkzpv9jxjK0FauMuSqIsQ3/ODVn1cb3Dw=;
 b=UFH4F6xA7CZrydK2YwpNzcBCVtyY5e5F0atMxQdvdTdiCso2pEteiSNlAkepNsKmHy
 TFwcBzmvlggF30emvEXGjeFRqVkSk2FMvci0pIPdo7JbtY1AZZkELLlOBL6dibOwPX5G
 NBhfdITyXzdFUVcGoIRu5g/Nkd8Zh10WOIk+HoMlMnqKtZR270nyeO+kKFBgcGZs/35r
 TWyNP/03daarvJ+6rMRphOcLASfxXFfMcKk69rI//nrq1vROPwmmxAvNPs2oOZM08LfM
 5caHDEaFWIuLG6OXxeLpR1NaU5ijV1tNPRsMhB75Fg6O+5ke8FkBaQerExPMCpOEdi2F
 hOJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtI0PQhhludnwgYGf2/ApGZ3LPu15BuD4wz8pAFQIG+X7ilYTU0W/7rbQWOkQJ/xv0cu6KGnQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxhWzdrvOEsPkif0UYvdc8PU3wjzC7eDdjBDurPsnVpJTTnwSbL
 VQhl/27xhnXAcSNHnfBeRz1CKL9T95KhBgC5UJ2RXVVWvJWiKIvOBJaWbOibg+++P6Q=
X-Gm-Gg: ASbGnctqO45ppeIDnctA2twvMQjhzniW0qkiph+54xel/nyaV0s+zdPF1iKYXIDnxbA
 TZLNqAW3xo40dz5WNys3VxnNK9/nFHoVdaI+znfbReprbd02Pn13CQ4903L8Yo7V2FkFer+lv46
 UGiPdpuqvncNgMxpjZ4BMYIk05f7/0kmSgm7q6pR2xnVuoWN5V5uUJZxxVHwmSjfpSq2162UOnN
 eOuZOmi6p2lRbfyfq3gnM7yfG/QOTFY0djzYrALQW+fxYxNKzRTwrAO0/yTM0SmCH4X2vPHTAhv
 snIT+swUg5nJedWg/++ZsLdKLkEDeGBpnWQF6UgQK22i9M0hbGw5tFR3DKwRgcmZg+6i/PG90YS
 egXGqy44i6INEtJYg8y9ZXdpkcH3ovnWP2GTHjh5HDOvs2QC1QXvlvQmylNa+fcrpFVfjzCxY9Z
 pWI9o89ASp
X-Google-Smtp-Source: AGHT+IGbauE+XPgw2i8BsB8WNAi0hPzII+XN7f0f0aiET6gf8RydFV8W0jStGCNermmnID1zEB7szA==
X-Received: by 2002:a05:6000:2c0e:b0:425:8133:8a89 with SMTP id
 ffacd0b85a97d-429aef83e7dmr5233403f8f.22.1761818489093; 
 Thu, 30 Oct 2025 03:01:29 -0700 (PDT)
Received: from localhost ([2001:4090:a245:8496:49da:2c07:5e9a:7fb9])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-429ba699642sm1453349f8f.16.2025.10.30.03.01.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Oct 2025 03:01:28 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Thu, 30 Oct 2025 10:59:20 +0100
Subject: [PATCH v4 02/13] arm: mach-k3: Kconfig: Add symbols for IO+DDR Low
 Power Mode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-topic-am62-ioddr-v2025-04-rc1-v4-2-4cef18af0226@baylibre.com>
References: <20251030-topic-am62-ioddr-v2025-04-rc1-v4-0-4cef18af0226@baylibre.com>
In-Reply-To: <20251030-topic-am62-ioddr-v2025-04-rc1-v4-0-4cef18af0226@baylibre.com>
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
 Prasanth Babu Mantena <p-mantena@ti.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Beleswar Padhi <b-padhi@ti.com>, 
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1198; i=msp@baylibre.com;
 h=from:subject:message-id; bh=rArpAisMCN24HzB7/ChXN/k67oUE6/e9VE7wWOsHxQ8=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkxmc87f8725Dus0Kj2vaLCT1H3KdP7VqsotEdtjKpl//
 FbKcb7bUcrCIMbFICumyNKZGJr2X37nseRFyzbDzGFlAhnCwMUpABM5uJiR4eXpmbHbf7xjjUye
 e/G2+Ndb66K2LLi15rXt7LPT77C+y1dmZFjf6dj25s7JG9msulOFQ1cJyvbP6vN/r/LFdXZ3p1Z
 iGC8A
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Thu, 30 Oct 2025 14:00:47 +0100
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

There is one new symbol to enable support to resume from IO+DDR where
the SoC is turned off and DDR is in self-refresh.

The other symbol is the address of a memory region to be used to store
meta data. This has to be the same address as is used by the firmware.

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

