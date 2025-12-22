Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCE14E69160
	for <u-boot@archiver.kernel.org>; Mon, 22 Dec 2025 20:06:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 663E784150;
	Mon, 22 Dec 2025 21:04:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jUyOIE4/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A69183B95; Mon, 22 Dec 2025 21:03:08 +0100 (CET)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A66F783E88
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 21:03:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x343.google.com with SMTP id
 5b1f17b1804b1-4779adb38d3so29030435e9.2
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 12:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1766433780; x=1767038580;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=blqjGrHdvczcvy22cMWGJ0aN1/O3hJRnxQpcwiaor4g=;
 b=jUyOIE4//ifxVAg+yaZfPNRz63UJuUA+HKjVqzFq9xF8Xww43Z76MschKcl2bpoSww
 UYHaDHsUYx63RGH3Wfn6p4O+hY193Uh3LyOAwDOkSruk/8kEEKHp84kkZRfF2d3KcCeo
 F1PXQ7Qt/8ia4fOB4f0k2Qff6PpbeeARpaCB9xGZW68BNb1a8e3GOyWPP/ZFKC6Fwqw8
 pC9gxQwr9xZZMaeIk+H4g7udVH+Kp3OH6iz5+3W4TLO6KUM06LTUXX3H3D/S5a+BdfsW
 FHAff9s5qTB+kqX1euwrlqkki+vGdd6NAeGmqv85bKlXEibH0yzyS84tMSg21/MtsjWD
 6gMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766433780; x=1767038580;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=blqjGrHdvczcvy22cMWGJ0aN1/O3hJRnxQpcwiaor4g=;
 b=ih+KNY0xKDJ2WZTkFcSDURmHliqPE59ZErluSsSZFxDd0OBADHHn29fT6nbp82l6Oa
 LriIvF8SjcAG+cDR/CS2TQmo+/Jo3YilKLZWsOyVXlGWXoFsaD9UFOzw5pT3EjsuyWnK
 gAU6k7rLbGm7dSG2mcNiDC1Aa9y7gJTyjMzYaFrQkOD7pszAF1y36iSN2v2AEpUmFJ3W
 vb4Ue3lY46xQKC/M57/8JXRyv97mWGZcu0V5vfFfRosY9gay8zo9/SLjgR2pe0n3R7up
 /lifJ9cZfc0uX5xSo99ZF9R+zxwLmU8CdvzwPibo9CDIZ1nlg19hGp+cP4ruYRedpeYc
 R3yg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVBOLIMLSqRjQXgwPC+uwnqcmqvnc4QOv7dds6RVMGYy/JZLwNcf4EsDcm1yzAi9C5WrpsliY=@lists.denx.de
X-Gm-Message-State: AOJu0YyKgXxV5xkf/LfxtlawCbkpi+78c7GJdbYrwcSmWRaRuXmy0afK
 CCtd8DQ4PC/5IszaPDhBmPAvRvpa5X2qILFWXUWU5UMCJAVO5+dUmM3eGQY8wJO0jpQ=
X-Gm-Gg: AY/fxX7soXB3B8ePVtTOyY1ZqBjQ7aaSFDQ4F+ChHRepY/wDL7xkhHc1Cdb8Rqy2csx
 /PWJqGRMNXBCJ/p5FID1iWRf3YepVEseApVijKNPq5ssEB63ftg6jRrxYEe//+JesOaVvIu7uX2
 1OZgm3Hmr94y95efN/32GbC++KmdGG0ATTGRfCBQ9qM1a1MGjwFwfCDWJzEdtopJfAImGMyx0ph
 65ZIuW3KvQEF1I5rfST7XSHffPjRta2OD/vO/4UjFCtAYgrAIOEixuxgsqFrnoYKNBGBlh/TeDE
 82MqH6ziPmypZFBgJcpQsh2jx32rq+dztxyqQ6MLc8rk4uzYzOcGngf0oItFw8cW2xHbcq4I4gx
 C1kVPZR5F6MRHb+6Z3sBKa7V6f2Ms80OUMraa6ioiMhzHY4R9LxIh1vX+lJEniCpuTVaR6qSTeQ
 fyYny/JM7v
X-Google-Smtp-Source: AGHT+IHas3yXtS5CJVgC8fzMkWjnaoNKYaqKo02N0JKcDB4e61bp/6q4Yi1SFDQZLKYyXFIZK4kVvQ==
X-Received: by 2002:a05:600c:4746:b0:479:33be:b23e with SMTP id
 5b1f17b1804b1-47d34de4cacmr6665965e9.17.1766433780104; 
 Mon, 22 Dec 2025 12:03:00 -0800 (PST)
Received: from localhost ([2001:4091:a246:82fd:4350:c3d9:84a3:70dd])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be3a49315sm108642155e9.2.2025.12.22.12.02.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Dec 2025 12:02:59 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Mon, 22 Dec 2025 21:01:30 +0100
Subject: [PATCH v8 09/13] arm: mach-k3: am62p5_init: Resume on LPM exit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251222-topic-am62-ioddr-v2025-04-rc1-v8-9-e70fed16b166@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=976; i=msp@baylibre.com;
 h=from:subject:message-id; bh=Kw/YLiWB1crqHGCtz6rFqBf9zuLP01gg+5M4GTlr0Fk=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkzPxce3cBl2ewXePSRdlMh2SGv1q+VLC6pF1Q36y9z3a
 hYIJa/vKGVhEONikBVTZOlMDE37L7/zWPKiZZth5rAygQxh4OIUgIkIyjD809y97h77oT8n+mc7
 75PgY1K7x/TKTGZxBncYS5va5Lj9Vxn+Cp2bWa24MPDz6pUmdTxHbjIn3ZXSSPU7PVNO5fXMUwq
 PeQA=
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
 arch/arm/mach-k3/am62px/am62p5_init.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/mach-k3/am62px/am62p5_init.c b/arch/arm/mach-k3/am62px/am62p5_init.c
index a74fe3d23d7c4b66ac95aa5a01c2a32a586e9ced..63cc9827b6a178d36f054400772417411cb508f5 100644
--- a/arch/arm/mach-k3/am62px/am62p5_init.c
+++ b/arch/arm/mach-k3/am62px/am62p5_init.c
@@ -253,6 +253,15 @@ void board_init_f(ulong dummy)
 		enable_mcu_esm_reset();
 	}
 
+	if (wkup_ctrl_is_lpm_exit()) {
+		u64 meta_data_addr;
+
+		ret = wkup_r5f_am62_lpm_meta_data_addr(&meta_data_addr);
+		if (ret)
+			panic("Failed to get LPM meta data address %d\n", ret);
+		lpm_resume_from_ddr(meta_data_addr);
+	}
+
 	spl_enable_cache();
 
 	setup_qos();

-- 
2.51.0

