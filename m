Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A8C4CF8864
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 16:11:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53A6584141;
	Thu, 20 Nov 2025 17:09:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="j065Spd2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C11A8409E; Thu, 20 Nov 2025 17:05:14 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B438883935
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 17:05:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b713c7096f9so181406966b.3
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 08:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763654712; x=1764259512;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xny7skziXwZhA/ALHX6YBX/He2KmlPgGim3Zv6mNcco=;
 b=j065Spd27IXi2AbJp7JWVOmKNl1detEmVjdQNd1dHZCrTRB1Uq1qjqR+wwLjY5ckqO
 RNUgPccMixmkewU5dCy36QZM5MZ4vxaUKDo5tLwmGQiq0/CU/b8wGX4wCAOqgcEDjnU5
 CEJGGQ+VWBH7WYh6xZ0aaLfgjkpygfFD0tWeKyABpI8peKksgCQ6GmBcbjpGEwQ4omgb
 PyJf3k5lAe3NyKXZ1cKZipOWxCEk6t898MmPoAeD16jldNUUSlZ10P55Hxd+8OSXBAF/
 h/trCAiycLCUa0kPBrV49xcixKfUDSCqqFP9SqAvoytlxS+/DsN/iII+0nQnwxncbVBb
 ajCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763654712; x=1764259512;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xny7skziXwZhA/ALHX6YBX/He2KmlPgGim3Zv6mNcco=;
 b=TwZ1e3bWhbI4kQ4DxEVJRKM7DhjJcD2PuQDpk84lD50SchIROFQIM/ikNxMkCY/wB8
 wguGsZFGa9fLoI75X/Sv7J4X6i7D94tZG0vk1Ye9LcSXKUhPhfazsFTSJpg6l59WtQch
 1vY3X63oQZV9bu31NErngjLIODhAl9lDqeuC6Hr7mIDnt2rV+pJvCsKtrgCT/IdnJcZX
 tht8CU4dIp4ysA4uHiMjup5lGqkLeBIywbSU7T0v4rFmhvEbBXH0bUWeBvcHv7O5/lDS
 7yrWJ8Dmc7eG4U2SkQ7vROW3MGtfr7+1ytnbThjSugiF52o2y009+jXpMT754MgnLpWk
 HfvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDVDEJxzQg6IWiQGYyA7MnSu/TxLixn59Nxs9m7FpUa4Rvc9tAbGcj22WkAHp89VYj1/plMPk=@lists.denx.de
X-Gm-Message-State: AOJu0YzAh+6FCwQi6FHzMZpLs2HYbsOd7EoZVdx2sDtJG8M4fM1bvFiB
 Ubm/KP+ZiF0c0JcTuusp4oPHcWkI/mz8KitEqmjtH4TT4QLo+GeYkJ62dbTU7F/chhw=
X-Gm-Gg: ASbGncvoTEIQ14KQ3xOBjoaZhsa57KVkxHcuzfJRzPKfVKlg4KZWCl0Up6tYWztijNE
 mnrHTWDNX+GyGUTEAswTqAppTnwREp8sCKaqY70UeKdYVBPk9XtNLeNWrWSSssxy35dneztZpEZ
 sbXdTy5+XjqbpAisbOKH/3NAhOEQEhEpIkxp6BYrrMRmvvCGNP/InpZJYHT9J+bLD/HlpSjw+JF
 H3h7qky6/wS/JGzdv2nFI5Yt712h1Ow55GE88gOwQ8fpAiDgmLMn49rBeQrA9pcvMSicQ7D1dqB
 wyHS3gAWQRZqviZB2WMHqtWtWQmWdghP1s3dxfmbO5ywu3Ch1M1s0ttXZgGGau6gXR8oxZKoTb1
 /FJa4WE5mfqzyE900900mHid+DssUHghhi6PQFiDyQzRpcMavBXtGvETcHvuuQ6p3L+ntS5N8Ua
 /gXpxIzkU=
X-Google-Smtp-Source: AGHT+IG5dVCMUY2fky4SJOfitnYSm4KrAkQyCOEHh7ETvYK5Sq++DwWdCeRYyItCCbXx+v7YZ07/8g==
X-Received: by 2002:a17:907:2da5:b0:b74:9833:306c with SMTP id
 a640c23a62f3a-b7654f30061mr3303966b.47.1763654712116; 
 Thu, 20 Nov 2025 08:05:12 -0800 (PST)
Received: from localhost ([2001:4090:a247:809c:875a:7c11:12fc:ed9])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-b765502a9cfsm230551066b.57.2025.11.20.08.05.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Nov 2025 08:05:11 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Thu, 20 Nov 2025 17:03:28 +0100
Subject: [PATCH v6 11/13] arm: dts: k3-am62p: Add r5 device nodes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-topic-am62-ioddr-v2025-04-rc1-v6-11-6dd99a7271bb@baylibre.com>
References: <20251120-topic-am62-ioddr-v2025-04-rc1-v6-0-6dd99a7271bb@baylibre.com>
In-Reply-To: <20251120-topic-am62-ioddr-v2025-04-rc1-v6-0-6dd99a7271bb@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1001; i=msp@baylibre.com;
 h=from:subject:message-id; bh=I2WIWrzTGwlvqucEtjNtIVhplM8Na9O0kf0e2P3kAvI=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkx5GwnGRxe/8t8MXvDo+qKARwWLE891Mkm+rnRXuKsw/
 bzu7Cq1jlIWBjEuBlkxRZbOxNC0//I7jyUvWrYZZg4rE8gQBi5OAZjIlHxGhr+6K+2+sopF7Xg2
 1f38532CXjfm6x9ZJ33gy/Uj1ZINyXIM//Qm3umb6xLqq2vvPdtDxkoh/karRuWP6x/nazROMv/
 /hgUA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Thu, 20 Nov 2025 17:09:03 +0100
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

Tested-by: Anshul Dalal <anshuld@ti.com>
Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 arch/arm/dts/k3-am62p5-sk-u-boot.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/dts/k3-am62p5-sk-u-boot.dtsi b/arch/arm/dts/k3-am62p5-sk-u-boot.dtsi
index cf087c6e343a8af6f4bb2093bb6c3f28395a2686..8c2b198dede03fd77f16786f8743313a34902e46 100644
--- a/arch/arm/dts/k3-am62p5-sk-u-boot.dtsi
+++ b/arch/arm/dts/k3-am62p5-sk-u-boot.dtsi
@@ -11,8 +11,28 @@
 		stdout-path = "serial2:115200n8";
 		tick-timer = &main_timer0;
 	};
+
+	reserved-memory {
+		bootph-pre-ram;
+	};
+};
+
+&wkup_r5fss0_core0_memory_region {
+	bootph-pre-ram;
+};
+
+&cbass_wakeup {
+	bootph-pre-ram;
 };
 
 &dmsc {
 	bootph-pre-ram;
 };
+
+&wkup_r5fss0 {
+	bootph-pre-ram;
+};
+
+&wkup_r5fss0_core0 {
+	bootph-pre-ram;
+};

-- 
2.51.0

