Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EB84CCFA13
	for <u-boot@archiver.kernel.org>; Mon, 10 Nov 2025 20:14:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A84C83EA9;
	Mon, 10 Nov 2025 21:13:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0parTxe2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61D8A83AAC; Mon, 10 Nov 2025 21:11:51 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D8BE83A98
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 21:11:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b714b1290aeso582216566b.2
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 12:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1762805509; x=1763410309;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xHdmZYgxFu/tr9qCSJ+81m9S5KiLKDISdGBdCf2Pmfc=;
 b=0parTxe2ZMWsXzRxhhfGXv+BRrH+lXexZAO1BCoMdA5KNcW/5I5ggLZGhKkB501BZQ
 15xUwSlTq7SzPa/haVXH35khBIgPaPhqdjg9dUZVrWsAOamIkseE0Zx6Ep6bjTg5Dlav
 +x9GGa1oVzxVLT865k8WwMRCrH20U81AGAXKWzTvsg3t38Gza4EciAFTJa7+bGT1ZbJX
 1YVsYOZaGnpApkKeksvKmGBcIPaBRo0OE3bNQTgkSvHFYVDdqzcygd2xNi9xlmwOuqqo
 2AcuSt/sLhtK3HjhVYjpXc5uPG37lCi3HLY8dQoyDOtgnfSWQXeU6gqeSqZmhTh7xxvH
 uB+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762805509; x=1763410309;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xHdmZYgxFu/tr9qCSJ+81m9S5KiLKDISdGBdCf2Pmfc=;
 b=Y+HauK33CbbQfjp0lccMpcO+td1PswHsuiJGnKeihQ8GYLc+JZFB3d4XMw5ZTRlA1p
 X9j+SbOf6l4BpCQkQxSQgO28IybxKeDZ6YM5hmuCxVHk9GgZSMVfGoCqykq31Py7ikKs
 GCkjpxtZ0tpBZhhCTpLNrgvsdk0zDb4bhzRK27x0wfpx8eNlspiKBisc5/GXW9k07xos
 10qrlhxktnb7pnuIcoSpm/1Erq/uBMHw2glkxuR4IEWqRoXwo/1pgnx5+4uZP6DJqOLO
 qybyui9XXnq/3owPY7aV6d3+JbuRDh8xtp2O/+9OdRQZqTmLfDAWBQPkaQMmXWGiZQVD
 /p7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVodS5uOuB1oYppvp5GnJGbHs5lPHMSofK7CjTomo+mZu6hbmK5z37mhI9avatjilelme6EYc=@lists.denx.de
X-Gm-Message-State: AOJu0Yz/ptbkreDkV0iwKPA2xjCv98rFzHxPccw+QqQ1U65x1t5QBCsd
 Qn3OfaigoA0qk6vpWDlJFErh30uaVoinC1k8JDpAU6rCLfdcYiprIjWWme361INrqOg=
X-Gm-Gg: ASbGncsQGL3gdq0Yssc8mAIfV/hJd8Il91XlZ6zJ0OM9SbFmS91z2LcF8ML46OcVVGo
 9CERCk0RUULKajCx8T1rVd80gFHAHWeKJLnGUAZf6PzV1Nu1wOkCXFO+C09KaiHJRT1GQnmMBa8
 5HKPUc+A9wEsMQwXvKy4a0iW/7vrRT/1bo5GzZJYXIH/59G06Rtr33tqEaQ7zTWYdzWaMJrdYwa
 ghYMit+sr/8cXEcSMya/DZ+Hx/YvKxZRu3fk23xqsotOHAVS177+sIwAq+FqbPbFi/Il4tQAln+
 0Flhk8fFOKRSB3eTALRujESkcDvsk0Iyyj7/q867azC9bRWQu1a6ZHKkfbI9TJmeKuW9mud+fvT
 MBq62Jo1vQXZm8knoEbldSAkrrsOMb8Ku8YP6Au6INTbhuKm26mreO3dxdf4PCpVUzZpRszE=
X-Google-Smtp-Source: AGHT+IE7wMjS46Izju7LS1lcqY6dyzJj80b63U0w8DMPxDkqHsf11WpwqMc8dRFHl8hJq5sb/tJg5g==
X-Received: by 2002:a17:907:3d90:b0:b41:4e72:309f with SMTP id
 a640c23a62f3a-b72e0592203mr898187266b.50.1762805508835; 
 Mon, 10 Nov 2025 12:11:48 -0800 (PST)
Received: from localhost ([2001:4090:a247:830a:fe22:a8:f29a:a5c3])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-b72bf9bd3d1sm1207250866b.58.2025.11.10.12.11.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 12:11:48 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Mon, 10 Nov 2025 21:10:32 +0100
Subject: [PATCH v5 08/13] arm: mach-k3: am62a7_init: Resume on LPM exit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251110-topic-am62-ioddr-v2025-04-rc1-v5-8-980ee0036c26@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1078; i=msp@baylibre.com;
 h=from:subject:message-id; bh=SVtu96f4IJxy10qV4vI/CLbyRvlaK2yL2Br3S7R9VOk=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkwht9tseyZ0X5c7fcLPpml5ZrwXM8/RDfFWibPPP9tSF
 bPHaH90RykLgxgXg6yYIktnYmjaf/mdx5IXLdsMM4eVCWQIAxenAEzkYjgjw+1K/fmLI6TL/D79
 tbC9cyH3nJ5N8QddwTtFP/kcZbRiVRgZTkyb7hnZHHBBu5LjlT77hAl7fA6uXz1rZs1+XcutSdq
 H2QA=
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

When exiting a low power mode with DDR self-refresh, we can directly
resume after DDR setup is done. Call the common function to resume.

Tested-by: Anshul Dalal <anshuld@ti.com>
Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 arch/arm/mach-k3/am62ax/am62a7_init.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/mach-k3/am62ax/am62a7_init.c b/arch/arm/mach-k3/am62ax/am62a7_init.c
index 60645272c816023798cc5d6fa46a2c569143343b..4f0a8ed66179e7f7445f9c250ffb4f53f4977546 100644
--- a/arch/arm/mach-k3/am62ax/am62a7_init.c
+++ b/arch/arm/mach-k3/am62ax/am62a7_init.c
@@ -195,6 +195,15 @@ void board_init_f(ulong dummy)
 	ret = uclass_get_device(UCLASS_RAM, 0, &dev);
 	if (ret)
 		panic("DRAM init failed: %d\n", ret);
+
+	if (wkup_ctrl_is_lpm_exit()) {
+		u64 meta_data_addr;
+
+		ret = wkup_r5f_am62_lpm_meta_data_addr(&meta_data_addr);
+		if (ret)
+			panic("Failed to get LPM meta data address %d\n", ret);
+		lpm_resume_from_ddr(meta_data_addr);
+	}
 #endif
 	spl_enable_cache();
 

-- 
2.51.0

