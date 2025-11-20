Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDE79CF8864
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 16:10:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 977D184132;
	Thu, 20 Nov 2025 17:09:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="wiPezj8Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BC00840AA; Thu, 20 Nov 2025 17:05:12 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87AB483935
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 17:05:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b7277324204so175463966b.0
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 08:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763654710; x=1764259510;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nfERZQolokcP5IlX8ZWhplLYx5nu4wMQpl39XeloOOY=;
 b=wiPezj8Q957E7YoczNPg6iXFJTmHT/W5MfLekIzmCsxWiMYr0koyyCsXo8fC2yJcug
 66VQFmDVNO1wjNzFsJFuGx5W9c2fZUAoG3cOE0wIT+TGsgLFail7oJCHF4QEx4+dspTB
 LE66f5GWsLbM8FrCIZQLceByXjvIeFifK2R5EBSdCJAUd++mgegFobTcUMX9xzFoUQS3
 mmP3gexCZOU3NaOykBJ1+ntHm8Cv8Yt4ArO+NPHjmCW+Jln1Z1lqsUJ0UhudI0LEXRPL
 vjMihJleYJR0cIKtO04uPbSkFVe0ikBd6uon3Ki0F64vQQPmtpQnArZbecu0VL/TqV3z
 G9Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763654710; x=1764259510;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nfERZQolokcP5IlX8ZWhplLYx5nu4wMQpl39XeloOOY=;
 b=fjwmr4GiGAybJKaW61y/EIXiVK1T2sECISZdokvzhz96UncpRa7ApQa5ebrfWnRKOL
 SDRrKtDyegjUtvvDwEpQBjxcHONm1wDyIKXjwGGwW9FnEHT9T8YLTKiD1LCL6oc2U4uG
 b6kguwt3TZ6iErsPmNIjX+nMUPgHazacTw9PorxDpo4cgsppPqm0pPjIhXjU9F5v6YEd
 OG8hxuPP7cxzRUKr2uEYmn10lEFBLhacz3s4O5zR5s3yfU19SPs2pK9VuGVNd/XEX0BC
 be98OOZqWPF7Jb9aqTRyvAvgDcrlLTwoVKK6ptthFqy+iO7ZmYTDEuQWmJiems1wON6X
 0aCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNv9e5GqsjPZEYSk+RZVnUu64nzxbgFmIHceAgXxB447COPJsmBMavyuTcinroxgFK/mmlaAk=@lists.denx.de
X-Gm-Message-State: AOJu0YyTFtbeiepnqXjV/AirB0U1CNpA3/XXsNHbKWVY/43GBbDskc1F
 gh9efHApboqkrX/OlvTHxoIf70AE1yVwwTxlRRxrMA2IHCrtghf3JYuRbQM/6PLG7t4=
X-Gm-Gg: ASbGncs3LZS6YOLzRO5rKnDAwx9f2W03IwK55zxcGFMjzKHuLs426YW1Z+5tUmfj3WI
 FvIDf7nYSy3zR3GhxHCv9IXFWBl3uJgAbRF/bKJqaIUrpOZQR9d0KadDPQp2d68m9LQ0BNMelJG
 9S5lsjuKRZZz5QwSMRCXewuVn9crKZu/Yj/r93GpUj1faThVXoTUjBa5ugmhSShxnuvpqjkc3Cs
 lZX+aK3s+WfGWXhSkVw9RiuXHcPLsxJqgGSWG82qJTe0/ZwWFu7rG3E7Cz/Xc/4jftCkfVAyqty
 9o84WfkETQM4v316xHnlnFZNAkELrsK6D7Ed1IjGnHThpmbg+SBzQDZJ+zUsfD/tb4lBQBv7nIh
 60Ew+DX5G1PvvPmFMjGUhj/eK/MfLusNQpoj2RHwbt36aa7x3fnrGK2nS1iexrvkTV/+cCUNBwc
 lB9E97lxE=
X-Google-Smtp-Source: AGHT+IG3obnFXlwugYNRAIrJZtFuCLC5PnCs9qjrIvoyQ7TqbxLiIvDHLPUE9gr5yK16RKczLzOdaQ==
X-Received: by 2002:a17:907:a089:b0:b72:6728:5bb1 with SMTP id
 a640c23a62f3a-b7654f5f5b4mr346890266b.56.1763654709797; 
 Thu, 20 Nov 2025 08:05:09 -0800 (PST)
Received: from localhost ([2001:4090:a247:809c:875a:7c11:12fc:ed9])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-b765505dac2sm233692166b.69.2025.11.20.08.05.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Nov 2025 08:05:09 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Thu, 20 Nov 2025 17:03:26 +0100
Subject: [PATCH v6 09/13] arm: mach-k3: am62p5_init: Resume on LPM exit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-topic-am62-ioddr-v2025-04-rc1-v6-9-6dd99a7271bb@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1077; i=msp@baylibre.com;
 h=from:subject:message-id; bh=/erII1+lVNIHBmpEjSEwPlbYtvRlk4kmTTFsi1Wpkrg=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkx5Gz7DgA2JCaIWn81PHWrkeRSxoMv3fc+8eJM/Zwz65
 Ew2NuztKGVhEONikBVTZOlMDE37L7/zWPKiZZth5rAygQxh4OIUgIncKWBkONliWRtVW/ozoN00
 li1F+qKeZezc5+ufO+p/Nl/PH757AcP/gnTeTIWsSXFzZ5hmGXh7BhTNrblTYOh8k/nTmQ/NV68
 zAQA=
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

When exiting a low power mode with DDR self-refresh, we can directly
resume after DDR setup is done. Call the common function to resume.

Tested-by: Anshul Dalal <anshuld@ti.com>
Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 arch/arm/mach-k3/am62px/am62p5_init.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/mach-k3/am62px/am62p5_init.c b/arch/arm/mach-k3/am62px/am62p5_init.c
index 1c47debca61598ecacae03d83b4001a72dda164a..f69bb8b7bfd4eb244803490b1cd1c36ab8ab608b 100644
--- a/arch/arm/mach-k3/am62px/am62p5_init.c
+++ b/arch/arm/mach-k3/am62px/am62p5_init.c
@@ -253,6 +253,16 @@ void board_init_f(ulong dummy)
 	spl_enable_cache();
 
 	setup_qos();
+
+	if (wkup_ctrl_is_lpm_exit()) {
+		u64 meta_data_addr;
+
+		ret = wkup_r5f_am62_lpm_meta_data_addr(&meta_data_addr);
+		if (ret)
+			panic("Failed to get LPM meta data address %d\n", ret);
+		lpm_resume_from_ddr(meta_data_addr);
+	}
+
 	debug("am62px_init: %s done\n", __func__);
 
 	fixup_a53_cpu_freq_by_speed_grade();

-- 
2.51.0

