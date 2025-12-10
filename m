Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1FF3D3C925
	for <u-boot@archiver.kernel.org>; Wed, 10 Dec 2025 15:55:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F2E283D90;
	Wed, 10 Dec 2025 16:53:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mHgLSj0y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED6F88042F; Wed, 10 Dec 2025 15:11:08 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 122E3836C8
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 15:11:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b77030ffad9so1000221266b.0
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 06:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765375866; x=1765980666;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1tDVkd3o879IlwHgZydu0BSIKRCIBUBwvbkvP65J67o=;
 b=mHgLSj0yzCAtRqel3e5D4Mk5BYDDruyxy96Z3rk+uK1KTNANHnyTjGi/fZIhHLYnlS
 xQj2U0Hx7tD3f/SCTAJx41cmoy5V+Ul3im2mU6GFTOFxXI/GrOj2OUkfX6cf5n1ZUAKT
 9UYcdm3/BLvMcoR3P91aPDUsun7Ebg41qsEAw93DNIL8rgn2AfdeDD2T4nUsE+k5Yf1Z
 9pQs/DZSySCYUcJ+SM5U2tX0z+ulP15FOjyxqcwHbzdLw3lVU6JSVxS3gwyJkHpQLCli
 G0lp5X2yUNFLYvEC7QYDx5nvQKvMEI0bmWS+HbVwJt8bujRedIOUMwsdEXAh4swoZy26
 /kTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765375866; x=1765980666;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1tDVkd3o879IlwHgZydu0BSIKRCIBUBwvbkvP65J67o=;
 b=QafJE/cq9PHanJczCaC5OaPX9+J/9yWMDdcia+GUkEkR3Oi/dIzDI0gIm/Ks0I5tuo
 LV8oI6L3U8p+6DS/f5ss2oWpZENOQffpefwp1H9rGTJt1VXd2Oh4kBRXJb2kh019Vk0x
 wH1Ls1n9td3ZbAOHan5BE2fB6SaPP9CE1StDbweW1c6Zelo7UedflZNI/K06LT1QGWwk
 6EccNHYZLAJPSBmJqP9HMpkXC3uzSONwkYYMmkVlMJ5gzWA1oMAA5DR458JJqyNAPGEI
 YhrF0n72YE3+9zLvZr659vRgQRODv5BdkLhYDE+t4SDsqExv54udBzc/qrwohVx03Axa
 v2sA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRuwcvbz7K0dmtYSuKUhrpa61hQcqb9kLWZLVkBuOzJGSb314lVdZe+IxKs0rfOF437b3kiqc=@lists.denx.de
X-Gm-Message-State: AOJu0Yz0L8tL9hC1OoN7UqqfuFH2r+sctx86dSdqu05Muf5rP1gV4NAT
 kL3QBFyrvFsojuU0jF7ly5BNPoN6v7QYtK7agw9ZZG+cwjbN+CXtHPlBYq6GBTzP4nvLpfaZVtO
 WHdT8
X-Gm-Gg: ASbGncv+GOfelqWROU45koTmFw5+PE5Pbz5h9uvNOgLKdMvL5rQh8XEGJY8koZ1vtOb
 R6UTEJDn2tfA0pBrBbQtbcd2Rvne51RhfTFBbvfT+1gwh1LhNqA8CRaxt1PjF7hdzSNh4fMgPfv
 rX/35OXdMLJebR1iJQ3tkJTRKHjBP5XYOsg45D5w9NYx5J/uWcTI8H/DD0/qiH9Id8LsfyMKRE+
 anMI69dDlyPeP2JeuUagnNloQCga7gKfhEkDQ8zLQVqE1bmLv1aAx0mq9IKsaMsMu9oj5FJlWH/
 kZXJM0BkPfSeU9oHtH2yCIqopcqLcxcZ+aVsg6UrohJ2uQa4WB89SoZotlrYg+ERX1fb47xEyUN
 LDoXXOFi5n7v0XNyE+yX2K3+00/8mzWm2xNSJq3np3F5XLblqxzo/yv0ZXLPgWgEI9QuzPudmio
 hpohOWrj46
X-Google-Smtp-Source: AGHT+IFN/k8UmLmvYoLByTOGYulC4anPeRcWEZACQbWMLnm4JoMsXkOVIAc+p8k3qzZTxRIAV1hEeg==
X-Received: by 2002:a17:907:9405:b0:b73:51f3:a806 with SMTP id
 a640c23a62f3a-b7ce84c4e67mr283308766b.51.1765375866501; 
 Wed, 10 Dec 2025 06:11:06 -0800 (PST)
Received: from localhost ([2001:4091:a246:86d6:2b1a:7262:ad08:3918])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b7cf2a9717fsm92914766b.24.2025.12.10.06.11.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 06:11:04 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Wed, 10 Dec 2025 15:09:05 +0100
Subject: [PATCH v7 11/13] arm: dts: k3-am62p: Add r5 device nodes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251210-topic-am62-ioddr-v2025-04-rc1-v7-11-f113b156f83f@baylibre.com>
References: <20251210-topic-am62-ioddr-v2025-04-rc1-v7-0-f113b156f83f@baylibre.com>
In-Reply-To: <20251210-topic-am62-ioddr-v2025-04-rc1-v7-0-f113b156f83f@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=737; i=msp@baylibre.com;
 h=from:subject:message-id; bh=MaU4GzcNQzhzcHBaYfPHJSueRJdF372anHRi7mMvENQ=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkzLep8YHSnmLq8Fq6zuNk77lbPRuPZXHIPidnEnZr6TC
 d+nzTzfUcrCIMbFICumyNKZGJr2X37nseRFyzbDzGFlAhnCwMUpABO5wsnwT/X0lX2qG2o1vOVj
 TyvdsXC7VXfta/4RlupKWS7uWdHHDRgZZj0Myo9atE1rnpT8N32rzxYvPS+/YDmoe7SYzb5whcE
 jLgA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Wed, 10 Dec 2025 16:53:41 +0100
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

These are needed in SPL to be able to resume from DDR immediately after
booting from IO+DDR.

Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 arch/arm/dts/k3-am62p5-sk-u-boot.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/dts/k3-am62p5-sk-u-boot.dtsi b/arch/arm/dts/k3-am62p5-sk-u-boot.dtsi
index cf087c6e343a8af6f4bb2093bb6c3f28395a2686..26133d818973214914f68838f678dda5aba63970 100644
--- a/arch/arm/dts/k3-am62p5-sk-u-boot.dtsi
+++ b/arch/arm/dts/k3-am62p5-sk-u-boot.dtsi
@@ -13,6 +13,14 @@
 	};
 };
 
+&wkup_r5fss0_core0_memory_region {
+	bootph-pre-ram;
+};
+
 &dmsc {
 	bootph-pre-ram;
 };
+
+&wkup_r5fss0_core0 {
+	bootph-pre-ram;
+};

-- 
2.51.0

