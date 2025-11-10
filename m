Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A06B5CCF9E3
	for <u-boot@archiver.kernel.org>; Mon, 10 Nov 2025 20:14:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D259883F26;
	Mon, 10 Nov 2025 21:13:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="TtExZCaw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E03583AA0; Mon, 10 Nov 2025 21:11:54 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 359FE83A98
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 21:11:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b7291af7190so502019966b.3
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 12:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1762805512; x=1763410312;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zCW/KzqwTgPbwOzgdpVxKt0fOuIKjwrbFupJyE3SaaA=;
 b=TtExZCawJ9OuotOCzuVgUi3Xuw36mh1b/3AtBeVHrVnKZVvAXHh+4Brb7LfuA7cWLM
 UuRpu33IbyGtS0gEkcY2vE9yfNszCSiOqKOzyPNEPvS+zmnwzctCr79R0UZcMz0fjEo6
 P+lPZpU6acL+rX4jEOga/xdSLQOPobIkYakYrBCKOvCow20teDi2fZKA4qH2/cAMUdlX
 lNlfJcMHuLWnoM5O/I3UbJvhAZRHEpfQNRe9Bnq2UmqoJ3atoJQOK2cv9PqlUQuHQIkA
 X56PUGVB0ciiGWe/nwFSkuLZwhXa0/owhL+eEYVZZaO5wMhvUrVDelDzqkS2WEsguNs0
 F/YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762805512; x=1763410312;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zCW/KzqwTgPbwOzgdpVxKt0fOuIKjwrbFupJyE3SaaA=;
 b=uKvTbVI1Fez0cOy/pVesD0/MmcJoTUStWqNDl4ZMEQpCOvuMcbJa1B1Rv26Z2f0ANJ
 pxFXNUgLs5AT+vR/sqJ7x8FmCihiTQ+nlrJQteSI9F3dasGaQESzS0yns1ji3vyteUxA
 Psp/4xPqAuo5utYPNDFIT2dJXMsyLO6wfQRk4uobaBFKaEchOkUtmRPYAuZr3Nzb/WAO
 QgatU9xBYCB8EsYmPtvS2lSnD6edEmVzQlzdsiG0f3WknisjT+B7kvbjWI3lQGsbMrPk
 TBdpz+ES+Pu1nkMpNj3Aoxn7LxGG3LpHyUXObijuMmJyL/A2ky+5lu6t2sOFxvj0kqT+
 IY6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxRQs1wPs/0ApYoEx4U/a6qIILtKCE2mC0HZS6+fLpW2lXFa1njYJcpMyjHK7nz5XTqoUDuqU=@lists.denx.de
X-Gm-Message-State: AOJu0YykH08kJqJq8RWcmPZYnAcmdA5VWiWdtTfvDeAqqFGornCta9Ze
 vV9USGfoOmkx3pNM+Y+VX7R8vXF8EOW0umW504qSaTSN9+FLbQ5dFIO6gRgO+KK0UE8=
X-Gm-Gg: ASbGncst6ZDea9s+2bbEY0HLblZQlbG35OeHws2xAoUapEc07PZNnA5lFdq28qYOe3C
 y24Cii1+rk/0pQDJoCYm4OAXM9zsDZUOa4vCVTU2tD4S0DEijDjCok7CUl/X/D0tSW/XX/WMPgC
 0ZdGp1AdSlvEfQ/XTW+pEDEgeaNt3tYdKWNy7i/QevtjNB5viKkrdbbhRMgoFdiDSxksrj34HZb
 lPUQ91h+zXHqDn3uy++ra5xg+zwUsjoz4dAKvYey1dxoY6Cx/ji77+ViFH5E3Omy2AmcoBiQxGD
 Y4iW0ZGcuxVaTb5fQ7WAhSvw9d4ML1+M5kEIp4HjsJHtEXt8WZWVL0weeeE6ffd+OJXwpx14iyd
 tjnPpb0wygeKTsPH6SxEM0avcT9guyhqwttSh+Yyu3nhroCy1c4bVbfRu+T327zjuMxItOz0=
X-Google-Smtp-Source: AGHT+IGUTUteu9wB3BKn+RC1g42qtCd3Q1iLj6kWcMzNjN+MOY9g5LN5vWhnxrumhAzd8KoQZfdXTA==
X-Received: by 2002:a17:906:ef02:b0:b72:b97b:b6fc with SMTP id
 a640c23a62f3a-b72e03ef38emr1012105466b.30.1762805511652; 
 Mon, 10 Nov 2025 12:11:51 -0800 (PST)
Received: from localhost ([2001:4090:a247:830a:fe22:a8:f29a:a5c3])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-b72bf312e51sm1158629666b.17.2025.11.10.12.11.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 12:11:51 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Mon, 10 Nov 2025 21:10:34 +0100
Subject: [PATCH v5 10/13] arm: dts: k3-am62a: Add r5 device nodes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251110-topic-am62-ioddr-v2025-04-rc1-v5-10-980ee0036c26@baylibre.com>
References: <20251110-topic-am62-ioddr-v2025-04-rc1-v5-0-980ee0036c26@baylibre.com>
In-Reply-To: <20251110-topic-am62-ioddr-v2025-04-rc1-v5-0-980ee0036c26@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=983; i=msp@baylibre.com;
 h=from:subject:message-id; bh=N/4IPP68xX9ZB44FabIhYzh+dnNlUJfRbK9Xg/viI2k=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkwht6d3qhfLhvac/t10QbNA/0OmyQmhqGkbTupdmcWvI
 f9Vq8S3o5SFQYyLQVZMkaUzMTTtv/zOY8mLlm2GmcPKBDKEgYtTACZSZs3wP8V7ziTLTPv4syGf
 3Lz/Xfd4KXxc6kiiwZtA/VLXQm/jHEaGQ/Nu71o6u8pb7IVcZGd8Btujfyoyq0uTirzbVZNYq/6
 zAQA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Mon, 10 Nov 2025 21:13:08 +0100
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
 arch/arm/dts/k3-am62a7-sk-u-boot.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/dts/k3-am62a7-sk-u-boot.dtsi b/arch/arm/dts/k3-am62a7-sk-u-boot.dtsi
index a70fc88317e04de032e4da1428e25eb78ecc30cf..7e6a76f72b2a63bf706c3839189b6213aee4497d 100644
--- a/arch/arm/dts/k3-am62a7-sk-u-boot.dtsi
+++ b/arch/arm/dts/k3-am62a7-sk-u-boot.dtsi
@@ -14,6 +14,14 @@
 	memory@80000000 {
 		bootph-all;
 	};
+
+	reserved-memory {
+		bootph-pre-ram;
+	};
+};
+
+&wkup_r5fss0_core0_memory_region {
+	bootph-pre-ram;
 };
 
 &cbass_main {
@@ -68,6 +76,14 @@
 	bootph-all;
 };
 
+&wkup_r5fss0 {
+	bootph-pre-ram;
+};
+
+&wkup_r5fss0_core0 {
+	bootph-pre-ram;
+};
+
 &cbass_wakeup {
 	bootph-all;
 };

-- 
2.51.0

