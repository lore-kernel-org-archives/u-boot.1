Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A66EE69166
	for <u-boot@archiver.kernel.org>; Mon, 22 Dec 2025 20:06:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D48BE84132;
	Mon, 22 Dec 2025 21:04:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Vuh5HWee";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E278083EC0; Mon, 22 Dec 2025 21:03:06 +0100 (CET)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BE9F83F1F
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 21:02:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-4779adb38d3so29030285e9.2
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 12:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1766433779; x=1767038579;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gxcXGW2Zqzr2v3pIbPNSvhKDhe+BcEIbyU89vsVf/HA=;
 b=Vuh5HWeeeou040iaUHLJaz2/oiPh0ENFqHRYH93QpTb0sA0A0H5X7GemBEg3W/eI5c
 3DRcYBL3uwcTlsXsPpGTEtVLFK4/w9IR3LvkO5PbAq5oC7M3DDfOJWoTjWr33Fc455KP
 sh5wnwsgqpF7S5TQvq2f+UaG/o93RiW1AD+vKWmtJD90oglYzaNlcNPJPU09IpU/Xe3H
 Tcy8F/Lr5teqG37mKplnS5ORuQv4wOm0pcxkgFkD1SDwZinjGlPAaST6sy2VxPrXkrzf
 aJbu+03OYIxSX9/B9M+/MorED6j89D8Kin3xPqrw3YY62ZRfYzBTH+Cq0E+Id8mYsgLQ
 BlPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766433779; x=1767038579;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=gxcXGW2Zqzr2v3pIbPNSvhKDhe+BcEIbyU89vsVf/HA=;
 b=UKW/5RrwhUubPsa+yO6Sx4A4VQzqdQ+FEHrMun8legvbwwPB1WwtrVlbV0gCTa+qOe
 foqoQSCudhsURT7H/Zk71bNnGQcLYlbqjMIp9SZaaul+YoGZzzw0FBpWd25CsPOCTShs
 myJTfdw2ul+sfLDYhvktiQXT6Nvj2EO2tf2/EHS/2pkA9nj2RWsnaEHhtuNFGrBjmY3p
 n85NZ91yEKNuiNotnTQJ6huVadYQUmx4yRIpWmx/jGnwbR+eClAq1Vv3rJDOBA+FnsdY
 rlF5KKYl3M5IjNV/0rkym0HhQfBdltdIAvye2mnhM8jHKFJfEzYG+ztPAgEA1j6gMeyb
 HemQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLCtEgcsazWFOOhMH4BYCJA03yVUiSyJuMunImdqUW/8tgOGGWgetTqhsnw/WvgRllj312nck=@lists.denx.de
X-Gm-Message-State: AOJu0YzmOO7akC9DM6iRPVhCz3xdEVZEQSn8raFZob38JzBrQxrrPy9o
 2DTKntsYVxBFINm5P7bGdjPqUI17GUC7vrYYKSRoa7Ji8ZjUny9bsRAT8EWX1u11Tcc=
X-Gm-Gg: AY/fxX56K5Tfnz31rv+SRbjSE76JQjWyNE40TLibovc1k3Dbi/iIk9xD7UTUra692p2
 gEITpXVmSX55GaOJVB2a3pJTEqg6lCK47+a3drcLHFFr/83yAX5OqsjRS8YWERtCSP1Yi7cWGj3
 LDdkotxnD1UWioam8XPscW9lpqb3Cah3jNsAbuuRy2NZspAuTOmRdnLa0+x0WSZPX2UC8m3hFPU
 jAwhpmfCeud045JEo3evEweNNlNmXhs59QiOaf57jPXejw7A1/DGdilDVEjRPxFm0uWOh0fx3J6
 Hqylnm3m1UaTm0DvdL2PfBMTqowPBrUT2Lkj79VnjPYOAjd54PXEbW6cLcFpq4D0STrrA4oaqc5
 DLspm0nSmNrx3qcdxSR/zIa7CpG8nSrM6zMQIhcScj7M/Q5jaadm/YZuiifIWdYATCL6OpuJusZ
 H/JfIIjNwX
X-Google-Smtp-Source: AGHT+IF4dF/IO2kVTsbHIw7qPlB5paR6CwTXJlveuTTgIj6Ryw7zHLiz5o71uOyr9NF0Klu/+PM6ww==
X-Received: by 2002:a05:600c:8588:b0:47b:deb9:f8a with SMTP id
 5b1f17b1804b1-47d19975bb7mr97204695e9.30.1766433778947; 
 Mon, 22 Dec 2025 12:02:58 -0800 (PST)
Received: from localhost ([2001:4091:a246:82fd:4350:c3d9:84a3:70dd])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be3a4651bsm101778975e9.7.2025.12.22.12.02.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Dec 2025 12:02:58 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Mon, 22 Dec 2025 21:01:29 +0100
Subject: [PATCH v8 08/13] arm: mach-k3: am62a7_init: Resume on LPM exit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251222-topic-am62-ioddr-v2025-04-rc1-v8-8-e70fed16b166@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1036; i=msp@baylibre.com;
 h=from:subject:message-id; bh=KVntDryZS2bKGRckRnqzdUpT8W1RjBMVEtsouZOkXkM=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkzPxQfPtK69VmScH/hy8qrdOVXn+SJ5vyvoHPK+dJx96
 l0Fx3ifjlIWBjEuBlkxRZbOxNC0//I7jyUvWrYZZg4rE8gQBi5OAZhIUhXDb5ZZlYkS3kyL/abG
 V3E++HJRkD+1QFbItEdwknpp7NzOUob/7g4T2rXXlG9oWW4kpjnfJLb9ctexBb+r7OR8gziXmd1
 iAAA=
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

When exiting a low power mode with DDR self-refresh, we can directly
resume after DDR setup is done. Call the common function to resume.

Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 arch/arm/mach-k3/am62ax/am62a7_init.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/mach-k3/am62ax/am62a7_init.c b/arch/arm/mach-k3/am62ax/am62a7_init.c
index c1c7d669a45f53b7528c80d44bf9b914fed1cc10..51b0386853b065d62cd0ecac589e316de5ab4038 100644
--- a/arch/arm/mach-k3/am62ax/am62a7_init.c
+++ b/arch/arm/mach-k3/am62ax/am62a7_init.c
@@ -198,6 +198,15 @@ void board_init_f(ulong dummy)
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

