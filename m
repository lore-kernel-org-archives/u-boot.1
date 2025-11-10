Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1884CCCFA13
	for <u-boot@archiver.kernel.org>; Mon, 10 Nov 2025 20:14:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EC7183EDC;
	Mon, 10 Nov 2025 21:13:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="E3Q512gP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2532D83AA0; Mon, 10 Nov 2025 21:11:53 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 322E183AE4
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 21:11:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-6418b55f86dso2059129a12.1
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 12:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1762805511; x=1763410311;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nfERZQolokcP5IlX8ZWhplLYx5nu4wMQpl39XeloOOY=;
 b=E3Q512gPR0xpLVs9m8Q7faBaTzlD8qhMHZzZIS6+42ltTMtirdbK9Ayx58gxwDRtOX
 6C/9Sw16EbS7+M6I595HVQp8wgNRh0qFkYBw0x0F4VN9gB7LR4gOWI6RcfSQ5vALgAmI
 HkxQKYDpRbcSeIUq7PuBAbaSgaNSEARZb5V0mHvj901K67NukHOYLrQIH1EPx2JoHN2S
 EfQFwgCNcoeDKQbWgZvsXUXhA36TGrQOhDpH5KR9jfw7o1T80rEucny2W6OG8/sZ4oZP
 VncOfM2AQoAzOkNoBiJbAkV2gw8k983MzXAyJ7y/dSai2VweKbERGc2SX70uO0Oor5kk
 MQTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762805511; x=1763410311;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nfERZQolokcP5IlX8ZWhplLYx5nu4wMQpl39XeloOOY=;
 b=vg93+2gJ3oYY+7EpO+MOBLjdFd56mYUYnpcQ8W8NYPrbmfjPYfaZf+liyG+C4ZJDNd
 qUW1DRB0nSPIeZeld/5pbHcvx3vn7T5ZW+aRNCVOS5ru9k9+9IB24nHJsqpKfSoCsjTo
 dQAkh7FDASdbQvN/KADIP525/iBxAmfY1fHOQgRC5SI193tNufJ9S6bvcgHIuvO1QAaX
 t7AHNhftC10uVPZ03kyu7IYYwI5EXa7OSJbNdrCQX1pjwrdu9ooA0QvWUHPJc0EylkwX
 IK7wOFQ2QRaYjt1wJKH6cpDC/glz1Gp8WK+mAbvLuNlD/o0gVi2ypRSuwl+ZzYWJ8d2p
 jYVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6DJP4mp5EvHEF+Kp3OkFTym4G4lk3L6HXnN/pvFV60MuQx3h2fK3/nIMjQqXstEC4+Zm+wt8=@lists.denx.de
X-Gm-Message-State: AOJu0YxWrIrAzDpBc6I9AtJ4v4LEexEYpo6tnpTouXrQpbJ542Xsf+/z
 x5nP41CqRL/V8rXTZ+7THV6AnAePCuZsqRpfaPm/ZjAwUMEHWFRGsbW0L93iut/jvHM=
X-Gm-Gg: ASbGnctD4VpqavsY/ClYomo84jOFmuj0iqKBXsIT7PT3X3an3bMAFTOwUWZhHeINyHV
 NWvYaa0A0x7oeWW9mV1GE9YtPNbdudHDitt5aeVWKmrMX8oemBLAmYUTozKPFg3Vd+ehtZGIWrC
 Fp8FfvZP2DV+rmgkE+6vFr/Nt1Q5jf2AsH2cJIuMgrhBt9MbbkhUjYfRKnJjvpX0cM+wu84h5nV
 HXptT4r1tyRK7R3MJRe36VU+PTsEDi5HV0RigWlW7HHLRf9MsLLmYrC3BfVSY7McPRs0615bm00
 jZFOVIp625j6ZPcVix+F/ZCqbQov/hFk3hNxJjc+KTxPn0PJKHF8Hw4yM5N5ntagG2RMcyNbaXt
 tGIqDYR3gAt5ORAf1TFMtTE0Dkxwrq8jhsawaEYsn25RY7ZKksgOP26duLZNuKqkYdWCAz+q1b+
 kqHW1z1Q==
X-Google-Smtp-Source: AGHT+IGCwB9hg/nhDOc0eeVD2OqxqENkfnMqfqXnOXrc6fwPYVapLRxtZYWXsWlt2qmwGaUMzS6pVA==
X-Received: by 2002:a05:6402:26c1:b0:63c:2d72:56e3 with SMTP id
 4fb4d7f45d1cf-6415e6f1b65mr7462904a12.23.1762805510603; 
 Mon, 10 Nov 2025 12:11:50 -0800 (PST)
Received: from localhost ([2001:4090:a247:830a:fe22:a8:f29a:a5c3])
 by smtp.gmail.com with UTF8SMTPSA id
 4fb4d7f45d1cf-64166d06531sm6416222a12.27.2025.11.10.12.11.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 12:11:49 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Mon, 10 Nov 2025 21:10:33 +0100
Subject: [PATCH v5 09/13] arm: mach-k3: am62p5_init: Resume on LPM exit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251110-topic-am62-ioddr-v2025-04-rc1-v5-9-980ee0036c26@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1077; i=msp@baylibre.com;
 h=from:subject:message-id; bh=/erII1+lVNIHBmpEjSEwPlbYtvRlk4kmTTFsi1Wpkrg=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkwhtwfslz4FVYY2uGUqW/F0Ha0UTeVMu/mefX35tzULm
 a9f3+HYUcrCIMbFICumyNKZGJr2X37nseRFyzbDzGFlAhnCwMUpABNxtGNkWMyWoxp7/zbDl93v
 015U1T5IPf1jrtTGw1Pivh3N9Xsdnc7wP8CuOHuG/5y1s28v9nW1s/e1y7URqgu/yHZ7boXD8mc
 X+QE=
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

