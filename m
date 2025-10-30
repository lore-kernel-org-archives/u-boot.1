Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF639CCF9FC
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 13:03:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7D3883979;
	Thu, 30 Oct 2025 14:00:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Zysjl1SA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14E3883623; Thu, 30 Oct 2025 11:01:39 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D32D832AD
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 11:01:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-4283be7df63so408037f8f.1
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 03:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761818496; x=1762423296;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sZPFFRx48K1yIqJp3OgFJ37AF5VrHxYhDDd+upYTU8w=;
 b=Zysjl1SAlrkGh21fy413vv4+Skji6qGcnZj1CvYlU7ZpMqnTnVpPfjNEe/NPvAXgYK
 jEpGSikC81ftMzsJYbF0b9wOnci80A6jx9W2eRM1KKzxDiKBJ4J9w0pXGloN2kEvLOkb
 0mMcZMLpiSRrwMu0MOBPKBHGoZvLFYNZzzLjl8GH+VQgEiS/THH1JbB7eZ3FdwvZLJrn
 PS6VIzlUsPtfYgvxQw33pEVqZGJn6AcSbPFTJ/A3WrIzXJSjsBgiUDN8cD+viHbo8pg5
 HSfVL7GMO2RzsPoDlOQJoHU26ZJ0xRzvsahiwX8TnDo0mQushOiYRVkhhdATINJD20OJ
 snwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761818496; x=1762423296;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sZPFFRx48K1yIqJp3OgFJ37AF5VrHxYhDDd+upYTU8w=;
 b=uLG77hAk4zg29DpWgxmhdKEtWUNTlaaFRD1yyjiWxW9TkS+6cPecZf/v9r/Hc6neHN
 IrAfxMyZPuYpQfwcqxxbBXshf3RtvnqpzaRV1sVcXtgLlNHb0CGxpEIV9z3UbClyE+F4
 bQBu14EpNV1QHNQBiaiDXA87ZDKZJL4uCRGFIKMYjGFqjwl5JqyOIdn6Jo1u5WBGsylK
 Hlezpa3RHJomefqfI570AkQLADgGiV6SlYiUzXp0Ku0jrJn8l5uqcLLpHusN5qTX64L2
 O0RjmyEDfDc/nrcTTmpgaVlWtrmJ1HsRQbUdviSjUYlgtXgwYzKLxdOqmk+EFp5o+PpR
 hACQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFfGYS2LA3uYuirn7iocWqeOVKKkLunDnduW+ixSVeTofoY59DNCTx72AzP7vvVkAbpYS8HCs=@lists.denx.de
X-Gm-Message-State: AOJu0YxGsaGkmzyxXMBwEZF/M5hx+rGVZFbrmDD1YdIyQsR7P9JbhvBY
 q1Q9b5AYgWzY9S0wXZmc/0elSYBIzoNvHFr1etVnZEnVOCUFckKoqNUtGi97X2IfEr0=
X-Gm-Gg: ASbGncsXRde0cicu+CyaqGORA6KODlNjJf48+msFTBADxCpNt0Z+SXpajfgAbMwIxuq
 CQHmGimP8ZUis/SIisp6neiYNmmqEhlGZPfFFvU8GXU/jTWyQ0IjgeJLflXLKuZmFhbW0rja4EO
 DGaOV0/R60AG9q7HA3/nrM7gXvhO4aNVssHueMtTlyt9n964lru/JuOaYWqtNFWndvz3O/B9kuT
 anfAc8x+QbfWkr5n48jkmIy+n7+Z+J9XtJZ0CMeX5Atx5WvFHTycM/KFluYu5o+mKLx9qQnGJ3x
 5T/voDOE8tXVMSAy6v70yv43/gILARdGaRo6LWhDnp7jkPmrkM/F1brdIXqv8oF9Fz/CKwl5/d3
 6DGdShNXKWFB2gh7Hozvj0uuyRk5HnbA+OUgPfSPBFJA14dJ3iFld7uhu4MuUkaDB8VjhvkVj26
 Vo9KxTKmvVLVoQuKKC0N0=
X-Google-Smtp-Source: AGHT+IFX2vJf9QcVkMKxVG4cxTwBOVrnPcO06iQnp+YsGatAgBdPlJKmpJ9xYoR5QGc8Y4xLEvB+yw==
X-Received: by 2002:a05:6000:2405:b0:427:928:789e with SMTP id
 ffacd0b85a97d-429aefda946mr5025833f8f.61.1761818495218; 
 Thu, 30 Oct 2025 03:01:35 -0700 (PDT)
Received: from localhost ([2001:4090:a245:8496:49da:2c07:5e9a:7fb9])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-429952b79cbsm31167231f8f.4.2025.10.30.03.01.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Oct 2025 03:01:34 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Thu, 30 Oct 2025 10:59:24 +0100
Subject: [PATCH v4 06/13] arm: mach-k3: common: Add lpm_resume_from_ddr
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-topic-am62-ioddr-v2025-04-rc1-v4-6-4cef18af0226@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2969; i=msp@baylibre.com;
 h=from:subject:message-id; bh=Q3qhfbChLiydWWNQYLk8KQDRxNXVbH88LtSrg8iFmS8=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkxmc3UlsffJfzYwq3elp17LiX4hHLn3waFfn3rlFl6+c
 JNB3eVdRykLgxgXg6yYIktnYmjaf/mdx5IXLdsMM4eVCWQIAxenAExEvIXhf/mGrfnPPT/93L10
 weyffVVVCbyZxu/3Ck6/x+VnO9O6uYiR4eTxRzWHtitufHJ2mels1awvM+KOzdm6e8ahpGlSHHz
 /1XgA
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

This is a common function that helps to resume from DDR. There are two
pointers which are fetched from DDR to resume, the TIFS context pointer
which points to the context in DDR. There is another pointer to the DM
loadaddr to jump back into DM.

Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 arch/arm/mach-k3/common.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-k3/common.h |  1 +
 2 files changed, 50 insertions(+)

diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
index 10964417295c1b3b1e0a36e03617cf1b32d09b97..69134a1fce1b1ab9131d9f6e4c40b291c10cd2a6 100644
--- a/arch/arm/mach-k3/common.c
+++ b/arch/arm/mach-k3/common.c
@@ -189,6 +189,55 @@ bool wkup_ctrl_is_lpm_exit(void)
 		wkup_ctrl_canuart_magic_word_set();
 }
 
+#if IS_ENABLED(CONFIG_K3_IODDR)
+static int lpm_restore_context(u64 ctx_addr)
+{
+	struct ti_sci_handle *ti_sci = get_ti_sci_handle();
+	int ret;
+
+	ret = ti_sci->ops.lpm_ops.restore_context(ti_sci, ctx_addr);
+	if (ret)
+		printf("Failed to restore context from DDR %d\n", ret);
+
+	return ret;
+}
+
+struct lpm_meta_data {
+	u64 dm_jump_address;
+	u64 tifs_context_save_address;
+	u64 reserved[30];
+} __packed__;
+
+void __noreturn lpm_resume_from_ddr(u64 meta_data_addr)
+{
+	struct lpm_meta_data lpm_data = *(struct lpm_meta_data *)meta_data_addr;
+	typedef void __noreturn (*image_entry_noargs_t)(void);
+	image_entry_noargs_t image_entry;
+	int ret;
+
+	ret = lpm_restore_context(lpm_data.tifs_context_save_address);
+	if (ret)
+		panic("Failed to restore context from 0x%x%08x\n",
+		      (u32)(lpm_data.tifs_context_save_address >> 32),
+		      (u32)lpm_data.tifs_context_save_address);
+
+	image_entry = (image_entry_noargs_t)(u64 *)lpm_data.dm_jump_address;
+	printf("Resuming from DDR, jumping to stored DM loadaddr 0x%x%08x, TIFS context restored from 0x%x%08x\n",
+	       (u32)(lpm_data.dm_jump_address >> 32),
+	       (u32)lpm_data.dm_jump_address,
+	       (u32)(lpm_data.tifs_context_save_address >> 32),
+	       (u32)lpm_data.tifs_context_save_address);
+
+	image_entry();
+}
+#else
+
+void __noreturn lpm_resume_from_ddr(u64 meta_data_addr)
+{
+	panic("No IO+DDR support");
+}
+#endif
+
 bool is_rom_loaded_sysfw(struct rom_extended_boot_data *data)
 {
 	if (strncmp(data->header, K3_ROM_BOOT_HEADER_MAGIC, 7))
diff --git a/arch/arm/mach-k3/common.h b/arch/arm/mach-k3/common.h
index b7dd52fd1792cb6e3eab5c9f3863f983a8ac08df..3333b30b56e711b082d4da7f6773cf0002bbfe30 100644
--- a/arch/arm/mach-k3/common.h
+++ b/arch/arm/mach-k3/common.h
@@ -53,6 +53,7 @@ void ti_secure_image_check_binary(void **p_image, size_t *p_size);
 int shutdown_mcu_r5_core1(void);
 void wkup_ctrl_remove_can_io_isolation_if_set(void);
 bool wkup_ctrl_is_lpm_exit(void);
+void lpm_resume_from_ddr(u64 meta_data_addr);
 
 #if (IS_ENABLED(CONFIG_K3_QOS))
 void setup_qos(void);

-- 
2.51.0

