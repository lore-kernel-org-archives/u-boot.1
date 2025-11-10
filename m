Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92143CCFA13
	for <u-boot@archiver.kernel.org>; Mon, 10 Nov 2025 20:13:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65CFB83B9B;
	Mon, 10 Nov 2025 21:13:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Bt1R/hdF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13C4F83AB0; Mon, 10 Nov 2025 21:11:48 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03F1D83AAD
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 21:11:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-640b06fa959so5607057a12.3
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 12:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1762805505; x=1763410305;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=z6lUeC5scD5yllL0e+4Kj6E93XTYhBVxdvDFBglRffY=;
 b=Bt1R/hdF0cye1HqQGgK/c2Eg2ZeyOGfd7s6UeQpmXzr7uSaPntOuJuNwl8WftX9s6n
 TAqfICW123Mb9oY3gVFaoztkKCkpcnMqQkVDdNgcB0/EnNOI0bkw6oCY3f2PFRW0Hg+t
 wWx4hKJ8mtSHx3hfc6/jrReRMvZuROBymP1xRnK83vkAKRmGSsOZQsWy4YLwodNw3p3j
 P7RK+xiE/7sPdr/+lDmyqHnjyf1U+nbsTagBm0i/kREwn1SM0zjMZxVTopYCF1XXISGR
 sYTL/w6X8fMQvTChI21dGnR4wwt6c/1gvyN4JugHZN+f4ivmuaEX5XG++QKU2R6zJGne
 mMLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762805505; x=1763410305;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=z6lUeC5scD5yllL0e+4Kj6E93XTYhBVxdvDFBglRffY=;
 b=kUGtLoAcExuJAFq7kkeJG7iYz+0Eve3QUxpb/Hzf3vv904PnoEFQdaCUXr0tdsTePS
 GCpvKV6dtn82LFJ46bkgtV7gfKnj8COusmcWKY5lZ/MhJaFihcJD7FPUXLqoagtd1lJA
 27kgSSUlkFoq2f5xZPzJ1u8F4WnIIi4HgLYjhht6jiBnf2xhl2tj1DnN+0amYbZryX8x
 waGnjwGYkUkWIYy1z757H/i+aYP7aulMCEf7FNUomcfLDzTON8CBqPZE6a1jA13IDBev
 TnV+MgUbdXW1EV4ZjHWFzBbwJzDZ7Zd27oPzJzXAkoaOIPLW3Kqh1wVkqsGDFqIayVrK
 XcbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXc0O9DkkYtbG17Kx+tGPOLQ2Yw8mZY09nhZGjOEJKCrHwfU1+L1e8d7UrfHY0rieqLrbFwwUQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxYJsE7xZsHarEoJs3yF36FlkzKKoVAZn4/IBJNHSGwxfB1WE1D
 WIImSPZAJtQzd2+vBZWv4dw79EkAPe0qo7M0Ti19KNhGaFSonUcL/VVPps+/N8dHZyM=
X-Gm-Gg: ASbGncscBm39d4jESn3ZO2FG3JzsN3ktoLZMY246+YHscp1IhLxv+SXSXsFmwR0r14T
 xc05pSk5Y85iDW7rdZrItXPp0SaGmBlri2E+/qMNgeBBHGvcW8Kjx4vG2WOqV9A3WlZw0vKW2Tp
 bGrwAEWf6AC9dpuZnb50Qa2UqgV8TJoEwsn0fjNBnL9AjvL8lH42i47YRI7PDbSOmM46mxkixwY
 fy/FqeiUbB7/ocMmX4qF/ZR4uLT22Dl38ROPID/DUykt5buU7Vm0DSdLvNnzhXIWtHWbQ7D3Tkf
 V9nOIvEv2h2sMsSzwqWgBKVkbO0Ho0UwnzyDxefCuyhXxCOWWxUKuymLVYNah25W7Jj0cv+NeSU
 n2be6sN7OLElXXPrJYLgifGAoDo5Ofo2UNwx+1gGRgz9wFdexr8MyobwnCtJzKxQvzfCzIFU=
X-Google-Smtp-Source: AGHT+IHaq2WY5xy8vVLqeVpbscUvhFSiGcZ7B0dgHuAGl/AXXIdUTPt+yMRzGwfkmZqfUdlndVlhYw==
X-Received: by 2002:a17:907:3e25:b0:b71:51b:bd4c with SMTP id
 a640c23a62f3a-b72e04ad8a8mr908848266b.50.1762805505409; 
 Mon, 10 Nov 2025 12:11:45 -0800 (PST)
Received: from localhost ([2001:4090:a247:830a:fe22:a8:f29a:a5c3])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-b72bf72337dsm1153194866b.33.2025.11.10.12.11.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 12:11:45 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Mon, 10 Nov 2025 21:10:29 +0100
Subject: [PATCH v5 05/13] arm: mach-k3: common: Add CANUART wakeup check
 helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251110-topic-am62-ioddr-v2025-04-rc1-v5-5-980ee0036c26@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3255; i=msp@baylibre.com;
 h=from:subject:message-id; bh=cMk5McqPN/763fhqQXqyTdzDnL1nha1VrbIozLouUYQ=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkwhtzObj3UtVpn4a8HGha6hE1bmrP3ju9qrobt9Qdw0i
 zP7V22y7ChlYRDjYpAVU2TpTAxN+y+/81jyomWbYeawMoEMYeDiFICJzHjL8D96b+n9zRfrNh7q
 95SwveX6z75NMSadsSnp233W1ftZdCoY/im63pIt2V5zLCZe7LJRUJ2R7DQJtxVXfL6dys7bylt
 QyggA
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
index b4a605503d27b29d0fb962fbe4c94650a1f6c54f..10964417295c1b3b1e0a36e03617cf1b32d09b97 100644
--- a/arch/arm/mach-k3/common.c
+++ b/arch/arm/mach-k3/common.c
@@ -164,13 +164,31 @@ static void wkup_ctrl_remove_can_io_isolation(void)
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

