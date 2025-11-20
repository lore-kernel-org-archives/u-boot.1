Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55586CF856E
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 16:09:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DFE1840E6;
	Thu, 20 Nov 2025 17:09:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yTQkgB0X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB89E840AB; Thu, 20 Nov 2025 17:05:07 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAEE883935
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 17:05:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-64162c04f90so1784726a12.0
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 08:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763654705; x=1764259505;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UM93akFilknRKG1nlexl0t6pZHuO7AVkw/4R9HY9vYc=;
 b=yTQkgB0X3qEaeTL9jpAjonYpqoGooYMfrCfHyw36+ZtisrfGkbcPhAcDzIRHqBRZCA
 f0P9eYMmgsqB73Dcnnb0ukG7wTM1DkmPgD+rzBmRJGBtvjVsZM1oeZX7mtNV6alIcDF/
 hZpyX3e0ffvg25TSJZHbMefiLX1tHCyCqYSqnTqpA6p1lzb1UF6wDjvy1Ez+Khpzaxaw
 seCCRGSUuCVFP4C4LMOrUwg0WiD0mkiwTxOfqZ42SYXkF6ukVcuXb3+OP53gRKCTmFgS
 F/vpJ0H8Bq0dJqcloDk0sPmNCev0n2f5Mj+gekxoDlfcbjVNMRCGPAeVvuITW69GdIBD
 nXMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763654705; x=1764259505;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=UM93akFilknRKG1nlexl0t6pZHuO7AVkw/4R9HY9vYc=;
 b=Oo8bBSvmNN92nbfQq9tToyOg923n4bBkMzIeu/+AojGVe1l+w5yHtOvVv5Zgqi7EBP
 H0pXQ/pCTFUUmONT/0QhqWExEsnHBvILS0PjdnoPFkGQxXvzFb+pESkf5gow7K28rUMv
 JC8WNfujni07xo88ieTJ6JQS+xAO3BCU2Ha0Ilj6DpYCCXE3YkhS5NlQA093hBKkWLdP
 0/HFLh9ZDS5lESEVZOiLOaaYoQkNE/Z/TCIxzqa4d+hi9Z62aXxz/jreavyycfbhhFhV
 /PIjne+SUdYrfF71o80kXCAqQkzkNrwt3G9uStYZr0thKxxVkhb+SnaFQBVtiYHa1kqC
 dr1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUs/QECG3fSuRQO4fglNcQCv5YO/9rMhU1T7K7RE38+czUGJ1tN20GWXnNE286oBGmKNr3wlM8=@lists.denx.de
X-Gm-Message-State: AOJu0YwyLatiG1QQPbKFhrdxvRisj48Wx+Pxzd1l0mFCklYf0O8RlRtD
 S6PeMbRaIIHHeqvKeYjrLNPGET5HIUhJTuJU8QaSro5+jf1pFocO6iRskZx9/wsGJ20=
X-Gm-Gg: ASbGncurIF0dJZcfWySXhb+cOywlQm489KPCFn+LGzD2MkVLFE2nW03IiGGkEv5nRhR
 T1trpUdfSed+F5S7gsPYjhQS/k/LqzUD9t9cIZYKejG7VKIP02RORSGA/PkmYYaUM5DuXONWm5g
 EqU3fsnzjHJ9QSLOBOmhXzaFsoyjScI9N4oBcNw/CbSZnb1B2esEFba6bhGWmc2WkVbmVX9qUIz
 cQwCok1rK2H67o4FtLK5tlyvM2uB62hkNYMdDJr/+4EA/kqFeoEs/97sb/UDs1zemRRPZh1yEO4
 UeS4PW9tnJTdw+U0/X717Txn/fuqFibL5lZuyycDOCbdoC0aK8AXMdfO3UEHlsgcSKCom3E/pH/
 kk7kSyygMo+GPGqDNqzakmeUY1oH3/Kdgaxew9tX3q/xt3k2qUunBEByHUJZJnoSykdQOTgpsaE
 XPC/24vmZInaKlcefSJA==
X-Google-Smtp-Source: AGHT+IGzpbTSyFPkKtaZxmUl1f0pgTp3QBkFhtEvssAIBlKQ2Cm11ZD5NgPywCiXfulrWVjV9yf07g==
X-Received: by 2002:a05:6402:2790:b0:640:c460:8a90 with SMTP id
 4fb4d7f45d1cf-64536407322mr3294461a12.12.1763654705033; 
 Thu, 20 Nov 2025 08:05:05 -0800 (PST)
Received: from localhost ([2001:4090:a247:809c:875a:7c11:12fc:ed9])
 by smtp.gmail.com with UTF8SMTPSA id
 4fb4d7f45d1cf-6453642d2fcsm2392343a12.16.2025.11.20.08.05.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Nov 2025 08:05:04 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Thu, 20 Nov 2025 17:03:22 +0100
Subject: [PATCH v6 05/13] arm: mach-k3: common: Add CANUART wakeup check
 helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-topic-am62-ioddr-v2025-04-rc1-v6-5-6dd99a7271bb@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3255; i=msp@baylibre.com;
 h=from:subject:message-id; bh=QpoJGQ8XFHSjjAa4bJ20NhBihu0he4FdbVUwdInGiVg=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkx561/NKicUpdf92ff33kHPrxfZiq4E82XYC6mJuzzY+
 ka6gqOmo5SFQYyLQVZMkaUzMTTtv/zOY8mLlm2GmcPKBDKEgYtTACayo5qRoeOHYXZMCkfdsQ6x
 mD1ztH1PW3Y3njud38xlf+qX6qwJaYwM0/h5fjVm12y6/3qx41W3I1u65LR2c/hvPXPy7ZLtHUx
 G/AA=
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

Add dedicated helper functions to check CANUART wake registers and magic
word. This helps determining if we are in a wakeup or if CAN IO
isolation has to be removed.

Also add a helper to detect a low power mode exit/resume.

Tested-by: Anshul Dalal <anshuld@ti.com>
Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 arch/arm/mach-k3/common.c                | 22 ++++++++++++++++++++--
 arch/arm/mach-k3/common.h                |  1 +
 arch/arm/mach-k3/include/mach/hardware.h |  3 +++
 3 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
index 3cc4e7cba0d1e834280fcce3d1140ca32247d807..7780c7740d5ea2a5dcbb442210ce46e25c5bb61c 100644
--- a/arch/arm/mach-k3/common.c
+++ b/arch/arm/mach-k3/common.c
@@ -165,13 +165,31 @@ static void wkup_ctrl_remove_can_io_isolation(void)
 	writel(0, WKUP_CTRL_MMR0_BASE + WKUP_CTRL_MMR_PMCTRL_IO_GLB);
 }
 
+static bool wkup_ctrl_canuart_wakeup_active(void)
+{
+	return !!(readl(WKUP_CTRL_MMR0_BASE + WKUP_CTRL_MMR_CANUART_WAKE_STAT1) &
+		WKUP_CTRL_MMR_CANUART_WAKE_STAT1_CANUART_IO_MODE);
+}
+
+static bool wkup_ctrl_canuart_magic_word_set(void)
+{
+	return readl(WKUP_CTRL_MMR0_BASE + WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_STAT) ==
+		WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_STAT_MW;
+}
+
 void wkup_ctrl_remove_can_io_isolation_if_set(void)
 {
-	if (readl(WKUP_CTRL_MMR0_BASE + WKUP_CTRL_MMR_CANUART_WAKE_STAT1) &
-	    WKUP_CTRL_MMR_CANUART_WAKE_STAT1_CANUART_IO_MODE)
+	if (wkup_ctrl_canuart_wakeup_active() && !wkup_ctrl_canuart_magic_word_set())
 		wkup_ctrl_remove_can_io_isolation();
 }
 
+bool wkup_ctrl_is_lpm_exit(void)
+{
+	return IS_ENABLED(CONFIG_K3_IODDR) &&
+		wkup_ctrl_canuart_wakeup_active() &&
+		wkup_ctrl_canuart_magic_word_set();
+}
+
 bool is_rom_loaded_sysfw(struct rom_extended_boot_data *data)
 {
 	if (strncmp(data->header, K3_ROM_BOOT_HEADER_MAGIC, 7))
diff --git a/arch/arm/mach-k3/common.h b/arch/arm/mach-k3/common.h
index 49417679e2ec7210d5c95540f476a5d8ee548617..b7dd52fd1792cb6e3eab5c9f3863f983a8ac08df 100644
--- a/arch/arm/mach-k3/common.h
+++ b/arch/arm/mach-k3/common.h
@@ -52,6 +52,7 @@ void do_board_detect(void);
 void ti_secure_image_check_binary(void **p_image, size_t *p_size);
 int shutdown_mcu_r5_core1(void);
 void wkup_ctrl_remove_can_io_isolation_if_set(void);
+bool wkup_ctrl_is_lpm_exit(void);
 
 #if (IS_ENABLED(CONFIG_K3_QOS))
 void setup_qos(void);
diff --git a/arch/arm/mach-k3/include/mach/hardware.h b/arch/arm/mach-k3/include/mach/hardware.h
index d7c759420524faf48ea26c66607c6a899d1321b3..e4e7dd61c0689db11083b81f2e74ba8bea74577e 100644
--- a/arch/arm/mach-k3/include/mach/hardware.h
+++ b/arch/arm/mach-k3/include/mach/hardware.h
@@ -128,6 +128,9 @@ K3_SOC_ID(j722s, J722S)
 #define WKUP_CTRL_MMR_CANUART_WAKE_STAT1			0x1830c
 #define WKUP_CTRL_MMR_CANUART_WAKE_STAT1_CANUART_IO_MODE	BIT(0)
 
+#define WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_STAT		0x18318
+#define WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_STAT_MW		0x555555
+
 #define WKUP_CTRL_MMR_PMCTRL_IO_0				0x18084
 #define WKUP_CTRL_MMR_PMCTRL_IO_0_ISOCLK_OVRD_0			BIT(0)
 #define WKUP_CTRL_MMR_PMCTRL_IO_0_ISOOVR_EXTEND_0		BIT(4)

-- 
2.51.0

