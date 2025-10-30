Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85F40CCF9FC
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 13:03:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBBD0838DD;
	Thu, 30 Oct 2025 14:00:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="F6WNnxpw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 780C7800B1; Thu, 30 Oct 2025 11:01:41 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E90C808AF
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 11:01:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4711b95226dso10747865e9.0
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 03:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761818499; x=1762423299;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5A7TEH5cwy8gA5u1GM9uB6VNMYvQihiWHWZX7RCjKmQ=;
 b=F6WNnxpwSoeAn5Ef/rxaTaEmNyXW2X89geC3ZxfShi6oYgN2O4yRIiILKDPWUpE7x0
 rFR5RrJ5x8eFlLqBlyqLZcKU2YbzL90DW8F8AH58iEDh4inC+MPGYFJUvGvXNNNohZ4o
 Qs5tQEGsdJ5hdkYDiK4rfEheAwbZHIqXAgLSGH3RebAhojEh5DYjF2y/aufd+9xPTk/d
 n90BoKeG66k3dZkgpA0/8yvj2o8CF8BQ4FVVaOhN6Nfki6E+1w1KZgf+UWx1LwBgvXvr
 7lawdQN30rs2XtFd4C368c23J3T9goKnZqh4DWLq/XxSuqx5VmbKmY815mbLVW8xrqMS
 HUdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761818499; x=1762423299;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5A7TEH5cwy8gA5u1GM9uB6VNMYvQihiWHWZX7RCjKmQ=;
 b=coUdoCoPrWtgJ/VtU/DCMLCxvRNMudAs9urB8GcWYmC9Vhpx9zH1kcyHpecir59MuS
 j8ouVqSnL2fgjY/rPFzNc+1/uU80QDuzSMvU1/bkiuO1kR+vmm1aHdoBQBN6XQF8DY0l
 dheaXUDpOzJFaviVj7IYJ3uki6FqTK+4FvKiCfuiycEMgg/GyRtUKsJ25lOnYvpfF1VG
 oPWhVL4uUPVlMByYJTLb7YUAFvvbWqrHNsL9clvV3Doy+3jAs6BXRSRtkgH/rLR5EvEB
 /aobdqBSAbW2IqAIFnzPPJ2jeObu1LLZb2ermKRACEMUdoqbjSz7GddNxK3n51HuwiLo
 y6Zg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGhBEtyUmZFVD407Nwfugfv0KgE3eqdtfW7qhJORXL9ZvbdF87aFgkrKtDITJKh6ZEK6d6aAw=@lists.denx.de
X-Gm-Message-State: AOJu0YxJw+qXN10NinnqTSh/Zd209KqyGyDQ3crPRTkvXNKDY22D9dB8
 Hs/waawPmQutnd5/tJjtxo7RX2hgT38MbkjBvDzJX95IH9dFkWhK0v+XnF0FAPIiAzo=
X-Gm-Gg: ASbGncuExnJs9zKOEDe9z1nxXvH+pFQiPdsmRPTltNo1tH2khml1MwP7mGKZCB/Xyq4
 Ywt64t1+gIeqxlLcYPAr8s9Hj0V4MXVLQ5DDuKGkmbDG+HvAOIPJF48oEHlymzKa9zZFD1yD0+N
 l1zLIjjYRhavojyPU6zZK3TzFrLq3IM5+MCs/j7cFqlcCrFENZXh7/DavcqwopznLwX0nNoWXwW
 qgDbjloXyVdP+Ui++rHHCaSuKkvuFDERT9iM/c7yzaZuDKvNnlO6m+/LeJsUb3lib+AiOrsjBvw
 4XuHSHjhapcARXHj1Li6Q9lDlXIuSS4G9W+kx15DIX1MIisSqb7rOWWWSnpeIXSK9WGT7q7pT+N
 4yGuSz8m0MNpqEsu+kBk3jtnKLGwNqpytD1p11il+aNagWqOlvyP36izcuPq3jxKBJgyVGOtZRQ
 ==
X-Google-Smtp-Source: AGHT+IEpZQBUBwguBsBss/WlnmudjVJyowEa0bC+Z1t+aV//N+6EkgYR1jNaL8roWrrV3SB7/E5bLw==
X-Received: by 2002:a05:600c:3b1e:b0:471:a73:a9d2 with SMTP id
 5b1f17b1804b1-4771e39c8damr46997115e9.11.1761818498894; 
 Thu, 30 Oct 2025 03:01:38 -0700 (PDT)
Received: from localhost ([2001:4090:a245:8496:49da:2c07:5e9a:7fb9])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-429952b7a7csm31450665f8f.8.2025.10.30.03.01.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Oct 2025 03:01:38 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Thu, 30 Oct 2025 10:59:26 +0100
Subject: [PATCH v4 08/13] arm: mach-k3: am62a7_init: Resume on LPM exit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-topic-am62-ioddr-v2025-04-rc1-v4-8-4cef18af0226@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1036; i=msp@baylibre.com;
 h=from:subject:message-id; bh=e335PCy/Ng/VN9qMbvBwIK2XLeH+18sFRlQOxW2cNWo=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkxmc8trlleYlrte/D9pzWcRx/6LolEHzghvnH3i/BcZO
 Y9Hwf4yHaUsDGJcDLJiiiydiaFp/+V3HktetGwzzBxWJpAhDFycAjCRHVoM/4t0Ig0lcpd/SWZx
 2C8QUPtQsY+5V+ncHr3X0tGbttl4ZjIybIu2fCGW/WVDyyZt9mcf/4taf6/5oiN/cvXOpU9/FR7
 YywgA
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

When exiting a low power mode with DDR self-refresh, we can directly
resume after DDR setup is done. Call the common function to resume.

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

