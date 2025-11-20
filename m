Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39BB0CF8864
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 16:10:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B0FD840AA;
	Thu, 20 Nov 2025 17:09:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gPkx+yc0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7955083F33; Thu, 20 Nov 2025 17:05:11 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AFDD83E0E
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 17:05:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b762de65c07so165189066b.2
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 08:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763654709; x=1764259509;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xHdmZYgxFu/tr9qCSJ+81m9S5KiLKDISdGBdCf2Pmfc=;
 b=gPkx+yc07X+6dUlSvlyCjsdeUG9TKGju9bV+NnoLryL6lgp0J0v2g76TyocJBpph/a
 +lVQ/vG5To5xGKQsIOZwriBGtb8/M5j3R8A9eEEbao5Yc8LNFJyzAn1DnKnPYd5oiFs4
 HHiTMVqZEmYvTbKaTk/WDwttohSn4vofLzjdY/94k8IAbUb9XLk5huTSOpQDHHaXPq+z
 mZZxm5hBQYUVDGEZX19K9RowZZHuC9eC7EQyfwMRmzRLqRzzyppQwLbm5A1gHMeSNtg0
 eVy9QJQ8/9lFQuQxtQBHmXqGzr6ZoLVyGYuepzWWkIlSfkhmeFp+VoKesY5v4BfGbt+A
 +5gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763654709; x=1764259509;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xHdmZYgxFu/tr9qCSJ+81m9S5KiLKDISdGBdCf2Pmfc=;
 b=kpFLrYRtDcQHhwIvIbBfiel27nbMhRD35vB/aYN+8wIfqS3t6+Cj2G6D5C/MvvZl35
 h2qxG8NA2kSKolAKcNSE0G2jKmNunPuB7btzn9UHcRhuV59yv+eWEb/7DM6g4f77dfut
 sD+qMeTl0XDa6UGIjH8Bzk0dY0k0KyH1TEQEHmEn88OqmCqplyZUI2W4znYgQUGo+oYp
 N4uIkHNb53YNt9JfqBP3Sxtlub9GFrU3pK8v4ut8w56DuHosuL66jHuyR/uwfnyUBVa9
 3BJM68UQjbgyDqXHvbjHY+fh9rqSRjTXMU6uJZ61fWSISgII+E+bbcXIoRrhRxfZOd6+
 PHmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXr2T7pqllWPQAsn+fMvYlsKmsTg3BWq3IjrRj17fLoldpQGmXrKAGltGSDqvqiLPXuS09jVyE=@lists.denx.de
X-Gm-Message-State: AOJu0YwPdPWNObYibmkPGoPvg3/lPf/EjLUZ5G3FaLVdrCaCI7XZNIYZ
 aM4ySGUc7LOtEZPMfD4k723UCQYdqUthNppUvUZmSgFmqi1m5b8sG4BYwbIpNmv0pEA=
X-Gm-Gg: ASbGncvVprJy6g2/Ocm6Ow6bP9L2nkE52s+t9xjAYraxkNTl/tlqR06GPL8+oHI/08P
 0w0XWsuZUFge0SVU4LVir6PQRixw2KVsoppQN8Xkkrmcio1CDIbeWZ0JYCpzi1oR+Z6WBF3N4R4
 LBNyQjFxy3PMlFVQiPxzh9CN5D+UcJVQAnFbQrL5t/pv+4FL8bb5ehb3EQTuDB+D3wja8wE7MvP
 hNIenSqm6jt5553nmhGmFm9tbDnOVpqW8DBT2Ab614TJXrS4FuZ3A2C0ikGiHgRUcFqqfRTMu+c
 kgnZAToOKngOqSHxmumsRfAWbLhJwn6S/aYaHJkXvYfYWpgAPShO3HR2NL1n/Xk8hT5JFbN5o+q
 ablJCrR4nmDK/jmcgamDXX1tv4DJbbPXHp1unlTXNoOjRDQabcxA95MET3rIu0wpZkS45gK/ZTo
 L4LrO5bqc=
X-Google-Smtp-Source: AGHT+IEnt14J+pOKieGZjT9BMpSrzsADuXe5HpX36JkZ3PAuWbETd2IIZIsR8+kkA3VQ6sSh+wWXZg==
X-Received: by 2002:a17:906:8a46:b0:b76:69d6:f9fe with SMTP id
 a640c23a62f3a-b7669d6ff84mr17828466b.60.1763654708593; 
 Thu, 20 Nov 2025 08:05:08 -0800 (PST)
Received: from localhost ([2001:4090:a247:809c:875a:7c11:12fc:ed9])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-b7654d7cafdsm235523866b.30.2025.11.20.08.05.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Nov 2025 08:05:08 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Thu, 20 Nov 2025 17:03:25 +0100
Subject: [PATCH v6 08/13] arm: mach-k3: am62a7_init: Resume on LPM exit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-topic-am62-ioddr-v2025-04-rc1-v6-8-6dd99a7271bb@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1078; i=msp@baylibre.com;
 h=from:subject:message-id; bh=SVtu96f4IJxy10qV4vI/CLbyRvlaK2yL2Br3S7R9VOk=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkx5G84lzfWzc7bE7PywrH7xaYkyj+KpG+/pv/MInHPb5
 vehVzO/dpSyMIhxMciKKbJ0Joam/ZffeSx50bLNMHNYmUCGMHBxCsBEtGQYGS5ER1RmLv/L+7tn
 3vYC/1+mielH71h17nv5+I5RuCJz6kVGhq+z/zS43lv+NaPnQMRsW3W24sTHevy+Ux6WfpH+dbd
 sDj8A
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

