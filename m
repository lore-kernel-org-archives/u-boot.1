Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B27BED3C924
	for <u-boot@archiver.kernel.org>; Wed, 10 Dec 2025 15:54:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D29EB83CBD;
	Wed, 10 Dec 2025 16:53:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="VAXAnG8o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A30983A71; Wed, 10 Dec 2025 15:10:54 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E441D80077
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 15:10:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b79ea617f55so80457666b.3
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 06:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765375851; x=1765980651;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Gkj9NXrUCiA8V/XmiGBhfcXd9UIZZVVTZwyhecOZVK4=;
 b=VAXAnG8ovPShHO0ZJv8RedQSMQ7dzOkMSWKLKRM/+G+FFymh8waWaT+cLhjyWJhhEg
 3/OozyoX6N3XF0DpyeZpxYHQxOfHKf3AzPLiu3+X5rjOdFRw0d6MI668Mk4ZDZgAnoLL
 TeJq3HGadzMHfqBM+nmx0nqSP4dT4nkUypy5yObgLKvFTueksxdqFArKEncrKr7cCOXh
 71geHbIIvJNzE0YQU9Ak2jIecIpG5gBCJ70hS9miJrXE9jfwBcvW7Db3iYcR5mDUXfqp
 +0SH0Nb2yDzjjfyw/eA5yRhUg0qem+pkVdZd2F3OLAeml5mKPOGs6J2MWx4iiGAAmCH+
 DBHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765375851; x=1765980651;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Gkj9NXrUCiA8V/XmiGBhfcXd9UIZZVVTZwyhecOZVK4=;
 b=t5VuYgdSmK8GpcvMARFEg1Nf2ywlmudPFt6tkfeb5jbTcfqMpLiJS6AlfDC60x5dh/
 5UnKIif90qY73/nSFPPRuDd7NeGv72ZdrajRJXy7KKjnOxId04aAsLQ5una37xHGU7Tw
 +at8BgVyPivSmC+PpiQFwfaoMYfalTzDqPtipE9lQxMGi/leDNHTvmZKObxtWYyehaKi
 dep/DUBR9IvCHyyNOfECIVfEfINXdd2J91+82D9c//ey/alQBlj3yjl3NY4aF5ddl7JW
 HsPzGerMqQkuYdIDHGvwWFUg1iNEZZKtuwVNMXVt/Tb6JBEUoFj74N8aEEX+PJwPHQ+e
 FNZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjWbp1KB0txYiBx1cYY+/taIPmOnPAPrYraHirr5zCzdKLo65iESvkyTNMXucfjiQ+PCJfd6M=@lists.denx.de
X-Gm-Message-State: AOJu0YyoBUBAvU5WjTyFJn40Ytt3tYGz1wdfv+XzcnyRYzBic9S+/CAV
 jr9cwXHNTuQCFQ760suwJnbCTwJxTfequiT+wUwq933DA97aYXd/N48xeb0cHWGl7ZFuvnexre1
 xUcZN
X-Gm-Gg: ASbGnctfmrF5X8k50ugfPcDuhis2w1r8C3/DQOtacQx9ZIPNuGsUmYksnnZQbteVmzm
 pirNo2hxa/Qv9+CBPo7+lNSGlaMK3oIcSO+ENJlZFyy+AxAHljTEXwUSKFFWp7T7aWVb26WwQOM
 JzC0sIf6f1qAj+Rsecqr4vyydZUxP5c79tOLKkrSPWfUKd0OdNLxo7sYI36tED6sO9SR4t6t4NQ
 ZWy6v39PS7IT/FDGTZZwzv3CqLDaMqq1bAKnn7f4PGQzEXMCiST6amNoExFRQuvo5ztvadgb0Hn
 VhnzhO07We+OLk+t05ixgZGTFor2oGHoys1zN1fDfGmkkChMHxdev6KnqoS0OH+k43gzZWbfUnt
 4A+PU3jl/vlQyzjDts0nLPCpOMYNj5A6RcC/gnM13OFbacJwUYkIjX1A71e976p4l7Y1NJk9Azq
 pUQ8fWA4vV
X-Google-Smtp-Source: AGHT+IEcz7vKfp6S+u8TGDAx0n/wRSA7rUh2ERuUqGhIdc//5ilI4I55r+QsE+fxfRVmaSwOTpzV5Q==
X-Received: by 2002:a17:907:3f18:b0:b76:277b:9a5b with SMTP id
 a640c23a62f3a-b7ce82d3515mr278579366b.6.1765375851233; 
 Wed, 10 Dec 2025 06:10:51 -0800 (PST)
Received: from localhost ([2001:4091:a246:86d6:2b1a:7262:ad08:3918])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b79f4498d2fsm1728349866b.21.2025.12.10.06.10.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 06:10:50 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Wed, 10 Dec 2025 15:08:56 +0100
Subject: [PATCH v7 02/13] arm: mach-k3: common: Add CANUART wakeup check
 helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251210-topic-am62-ioddr-v2025-04-rc1-v7-2-f113b156f83f@baylibre.com>
References: <20251210-topic-am62-ioddr-v2025-04-rc1-v7-0-f113b156f83f@baylibre.com>
In-Reply-To: <20251210-topic-am62-ioddr-v2025-04-rc1-v7-0-f113b156f83f@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2981; i=msp@baylibre.com;
 h=from:subject:message-id; bh=n/aBq4IP45he5Efmu4i5BbNGVo+s5rMoahcECtCerLc=;
 b=kA0DAAoWhcFWaZAVSlMByyZiAGk5fwuhFiySWF/tACEmoaAHYwA4d3+weG0phS0Iv4QVn21Vp
 4h1BAAWCgAdFiEEiWFVZv8fucZjoqazhcFWaZAVSlMFAmk5fwsACgkQhcFWaZAVSlOnYgEA6U6o
 A07aLWTPTqRgRhFwyE7faaOUyvhK6d9UW/4ee38A+gKlb6PTr3tl7cwjR1hJHBzkcVpn5g+Q4io
 ADcf/sm4O
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Wed, 10 Dec 2025 16:53:41 +0100
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
 arch/arm/mach-k3/common.c                | 19 +++++++++++++++++++
 arch/arm/mach-k3/common.h                |  1 +
 arch/arm/mach-k3/include/mach/hardware.h |  6 ++++++
 3 files changed, 26 insertions(+)

diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
index 760aaad03411441e3cc169f2501134cf69dcbee6..a80cf87ce65a44c386539ade17c0f435e09de841 100644
--- a/arch/arm/mach-k3/common.c
+++ b/arch/arm/mach-k3/common.c
@@ -115,6 +115,25 @@ void mmr_unlock(uintptr_t base, u32 partition)
 	writel(CTRLMMR_LOCK_KICK1_UNLOCK_VAL, part_base + CTRLMMR_LOCK_KICK1);
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
index cd3e19374dc35bd3745a0261e8b8395d47d95283..55fe1f06d8b04a0bc27a88bb63a1fdc0b1eb383f 100644
--- a/arch/arm/mach-k3/common.h
+++ b/arch/arm/mach-k3/common.h
@@ -51,6 +51,7 @@ struct ti_sci_handle *get_ti_sci_handle(void);
 void do_board_detect(void);
 void ti_secure_image_check_binary(void **p_image, size_t *p_size);
 int shutdown_mcu_r5_core1(void);
+bool wkup_ctrl_is_lpm_exit(void);
 
 #if IS_ENABLED(CONFIG_SPL_OS_BOOT_SECURE) && !IS_ENABLED(CONFIG_ARM64)
 int k3_r5_falcon_bootmode(void);
diff --git a/arch/arm/mach-k3/include/mach/hardware.h b/arch/arm/mach-k3/include/mach/hardware.h
index 81b5f1fa45ea30456a43c6640aad01388ea6a3f2..6f425d03be5d9cbc03a0daac5e9b10fadd176335 100644
--- a/arch/arm/mach-k3/include/mach/hardware.h
+++ b/arch/arm/mach-k3/include/mach/hardware.h
@@ -117,6 +117,12 @@ K3_SOC_ID(j722s, J722S)
 #define CTRLMMR_LOCK_KICK1			0x100c
 #define CTRLMMR_LOCK_KICK1_UNLOCK_VAL		0xd172bc5a
 
+#define WKUP_CTRL_MMR_CANUART_WAKE_STAT1			0x1830c
+#define WKUP_CTRL_MMR_CANUART_WAKE_STAT1_CANUART_IO_MODE	BIT(0)
+
+#define WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_STAT		0x18318
+#define WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_STAT_MW		0x555555
+
 #define K3_ROM_BOOT_HEADER_MAGIC	"EXTBOOT"
 
 struct rom_extended_boot_data {

-- 
2.51.0

