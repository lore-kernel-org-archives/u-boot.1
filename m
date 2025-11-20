Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6450DCF856E
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 16:09:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D97284106;
	Thu, 20 Nov 2025 17:09:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="sUUBnQ70";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A411840AA; Thu, 20 Nov 2025 17:05:09 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E960383E0E
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 17:05:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b7277324054so168364466b.0
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 08:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763654706; x=1764259506;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9OJN47lA2Gn1CIskMHsnd+E+ZarYV4ssEmT70sdqm+Y=;
 b=sUUBnQ70p/BAiZovqUWu6HjnwLJWmRJMrereHrykBYrdN8Fu3i5+pbmw0md3U2w0RY
 8fks56rAsktpjJkVvGk4B+IImfZVNGqVK89pFtqK19hb4GC2hgPgYGr0Co86w7Vr0TKF
 3yw1joKvJCotRie0FtRnImQ1I7fz8h57/tPJp1ObCGLAM+QCfVJ89Y4ulZFnJcPvPi+b
 SxOuOsM9i06Ru9c2OOJb8zeBNM+E4+qaaUmgy4CXFuEIvFcNtFXV4brYVLg4D8YBptLA
 ndwEO0nSgiRZpZK+gFtN0nGtbLovV3aYixTa/JJBPvZa7Xyr5vODuajXwn6cF9o3qCsf
 mk7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763654706; x=1764259506;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9OJN47lA2Gn1CIskMHsnd+E+ZarYV4ssEmT70sdqm+Y=;
 b=QVtIdWyVX8oyQ9VLDmyimJUAiABOVpptBmZKMlQlArcy4sU+DMcJaTy+n7RXIUdt/M
 e34ObgFCWzCYm4K50UGfw13A8rs91y52pq9l1THqjsWq4qNYNx9D/+EVahq18JeBwhr2
 booKx9QK+fjGuuRL5GfdhtDmTBIYAnYnPTmn2DqlgUfvkKN01v8J8bADVEm465lAdmur
 AlmZlWGpcHtkuwCXKuoguDG7FZilBdqdEJ0l9id69KqNgaVE8BKtS3dC3uiXkoH9Q4+F
 0ewzMtCciKyxqY6zcBFuUHFB7KPjwTt2K5Puq/DUWifaviRawLNuuamdgMd2fxsSvGqg
 qDZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlwvL1XLfgUTLBQlseVANGSpy1dtjGRNnSMW1Xw02RYrbAnwHvOIXpA2DCtY343/pUqX6jofg=@lists.denx.de
X-Gm-Message-State: AOJu0Yx762Q9vbg5cZzV4ksJGnTwtubusTQcbuRwMIY+JoEuHXEVad8s
 KV5UqBaz3Dy9zoULSrgg8V3OiKXCFRapADauaNghWP8mp4BLqIML4j0tYAhAguX8SxQ=
X-Gm-Gg: ASbGncvyVruF7BBk++wXug7oVj/m+a7wxi3GyrDOIl7qCjrlnOn3F6++Sx0nHjxz6yC
 /GPCWWKpfMbw5F+NFiFtPSB9Hqj7qXt5BNmIBJKWC06b65RiUPwkwoJklvoHECLqotzUSQa6oNN
 elnuI4u7qL8QE2agC4xalZw/dMX0XsT4cY/TDPgICK7oCgmlaCfaL013jR62vD2b0OlqJXnEdHi
 RKJhOLB7oBMQJU+q1323hlM4PcVtkAMPDWKIqSOaERj7AeE+IjiwXbLsxGSxrErQfS0Vd33EUOZ
 D2ViQBmPdeNh9hzimDST/9ft7aOrDr24jvsG7dWvvX5Ve8x6OJOWKpujOC48SKFIX6vzoQq2wJl
 VlR1xX4Jtazq3ix0TQDDp76zyH4s1Qf7hdNFXunJ6AEphT/wpxDYnac4Jn6Njj/rBM/kCwDLOtd
 NPy5d8R6c=
X-Google-Smtp-Source: AGHT+IGV/uoeoh1DOJrxwUbeWDhoksdNVF69OPD+ThcHAqMiowTKXEsTeX0B0s14p05+PTM9GCdaIA==
X-Received: by 2002:a17:907:72c7:b0:b72:b8e4:3aea with SMTP id
 a640c23a62f3a-b766aa75d52mr5833066b.10.1763654706252; 
 Thu, 20 Nov 2025 08:05:06 -0800 (PST)
Received: from localhost ([2001:4090:a247:809c:875a:7c11:12fc:ed9])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-b7654fd4f14sm230931866b.35.2025.11.20.08.05.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Nov 2025 08:05:05 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Thu, 20 Nov 2025 17:03:23 +0100
Subject: [PATCH v6 06/13] arm: mach-k3: common: Add lpm_resume_from_ddr
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-topic-am62-ioddr-v2025-04-rc1-v6-6-6dd99a7271bb@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3026; i=msp@baylibre.com;
 h=from:subject:message-id; bh=Nhh3QKvqN//8lrUPSGIUuw3xFs8IOOn7iEpGyc1UoBY=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkx56/9yIS8Te+MmCCex+RXvFdm0Xu/c6pbHXIWc+XqOV
 fvsJVd0lLIwiHExyIopsnQmhqb9l995LHnRss0wc1iZQIYwcHEKwEQO7mD4X5tkvfLP/Uvu8p/u
 Z/rEn8z6Kx9Wzhfmy7Z57addbziO/2L4p3siJ0Fn270tOxdXODresjuaYBUlIpbLcOZCaYyJnJI
 uCwA=
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

This is a common function that helps to resume from DDR. There are two
pointers which are fetched from DDR to resume, the TIFS context pointer
which points to the context in DDR. There is another pointer to the DM
loadaddr to jump back into DM.

Tested-by: Anshul Dalal <anshuld@ti.com>
Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 arch/arm/mach-k3/common.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-k3/common.h |  1 +
 2 files changed, 50 insertions(+)

diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
index 7780c7740d5ea2a5dcbb442210ce46e25c5bb61c..b28c2cd5776f29d75d54da9078e5fb17768d69c9 100644
--- a/arch/arm/mach-k3/common.c
+++ b/arch/arm/mach-k3/common.c
@@ -190,6 +190,55 @@ bool wkup_ctrl_is_lpm_exit(void)
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
+	struct lpm_meta_data lpm_data = *(struct lpm_meta_data *)(uintptr_t)meta_data_addr;
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
+	image_entry = (image_entry_noargs_t)(uintptr_t)lpm_data.dm_jump_address;
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

