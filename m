Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B184D3C925
	for <u-boot@archiver.kernel.org>; Wed, 10 Dec 2025 15:54:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0A9683D0F;
	Wed, 10 Dec 2025 16:53:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="O9k2RVw4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AA7583A71; Wed, 10 Dec 2025 15:10:59 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B57980077
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 15:10:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b7697e8b01aso944870266b.2
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 06:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765375857; x=1765980657;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=G0rGZF5ElgyA8f/pAD3a8lZaIIPCe+CH/XgFJz1g7kc=;
 b=O9k2RVw4ktvkheduy2w0htDUTS8EKT43/b1r+BEwdVqhWsTDSu2PVNDtj+1csFR2Fy
 ZFtNzSeM5idTX+SI8xN/NrqFokYfQAwlwbnRccxaXsLZqFwC8UsnOtvE6tVHtWbq6TRl
 qPllPsLOmmGHsw+G18UzVhP3U0qvVLbSXmcjdXRRUmkenmTvFbXpKgTu8EGfgp+9Abiu
 j84lSiY6uw58FN/bEsfGeKAisIsoiypaPkZbjKop7fLMcawqWUzAa8ovNZenFKRXzTcQ
 Mk9V/XRalO+TVEs5N6hOI1epG24bXZRZ6OcJG8RezZJEXkGA5HXEYS38Mk3KgnooDgsl
 hW4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765375857; x=1765980657;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=G0rGZF5ElgyA8f/pAD3a8lZaIIPCe+CH/XgFJz1g7kc=;
 b=Fa6VANGkethQUH0wq5YDF1CcO7SoU9Cx5AP+hCJC4NgI2DBaCb3uS1y8vKCtw7YW46
 5JGiVpmxOFv/Oiv7z23G6/kji9sGFAZ5AybddiAFbmgWMtAClW9lID7lWHIRsnrkERgL
 RRiGbD6MTdpgI7Gb0kfjmkrVt6MXkDK5NOYUgKOk9C+Oxzof2IHkGsarSuyNJ0Iqzntb
 0krUUC2zXX7vc4D8PHAu09+bfESV1O6VpITb+IrDr246t+J43SdVL5AIItdj99Z4TsCO
 ++42oKNFIzgsAxOiLhzEzboYeO22D7dt0oCnAKipFaHXCha72/4RH1Xedvhb96fouLMh
 6JgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwE2k3W/hbh4+IW2DR45ytt+dx4e+sYjMya+60AtSO6GZ/2YMeYy00XefhZsKRxClgj4YaC0U=@lists.denx.de
X-Gm-Message-State: AOJu0Yx+OTZPBFQJ7kHqurFq/vcoX2Yq4XfuSeBvWrTBx6YYnrFME0x1
 E+pyzehIIf9S7hWNXrGxr2iy4CmNhR8Gd2y9C5/H2dbSHdSzOqvSZrPulgqHFP3Ct7y7ZumLimr
 VCegx
X-Gm-Gg: ASbGncvggwr590mkQo2YH6Y3qOkz5yiM+XEMUXOBB/AW3W3kHvPKTIEZVrmvpNm4F98
 yQ+4MnlxHQogBLZiGUM3koJdMYF2YyZat2sdHqfsPC5YG5/UCBrMdOPvIKo2ieoZyHaEkVVUx0M
 /85Wcs0xEI9VvfdABggIgx1VrAlvHkdUFDPZNQ3NmQXlimMBqTXOCfp33VjoATmOAtuMN15Dvey
 0CUwBPiGWLWNO1oo4Z9EM6pXavZiuYzCn/42pot5tpQvibbaJxxDlRQZsrk3g9FcfnVau0jiqdU
 OvEDHtJGHEJ4ns7fpqW1Yxd+NK2iT+H3kNkfe1qIpNqpb86QuhEQR9azbUzIcp41v41TtoZciBn
 We7pkh40KIyHs2KRk6aqvlofwncLNsDTqt/Nw8tY284VMAsSiFs+NWIsGtzrT16iURHwoUtsux6
 Xl2Qnxaq8Y
X-Google-Smtp-Source: AGHT+IHgXMzNb9TsOG8cbCN2QrLgC8oWmPE9uZgYYIOevRDXGQEORG+Zdbh3EMlSDLI8J0B4nqMTkA==
X-Received: by 2002:a17:907:a08a:b0:b7a:1bde:a01b with SMTP id
 a640c23a62f3a-b7ce852ddefmr291099666b.63.1765375856762; 
 Wed, 10 Dec 2025 06:10:56 -0800 (PST)
Received: from localhost ([2001:4091:a246:86d6:2b1a:7262:ad08:3918])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-647b4121d05sm16869977a12.29.2025.12.10.06.10.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 06:10:56 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Wed, 10 Dec 2025 15:09:00 +0100
Subject: [PATCH v7 06/13] arm: mach-k3: common: Add lpm_resume_from_ddr
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251210-topic-am62-ioddr-v2025-04-rc1-v7-6-f113b156f83f@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3085; i=msp@baylibre.com;
 h=from:subject:message-id; bh=hsU/1F8W4SFlQmJnCk5ppaigD+RfHlqc0XaUEct5Yow=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkzLeo2Jf1Y/T7Gex6lxe5WA6xvn2xnH1zMEeZr6/Zzb6
 c2c/z2lo5SFQYyLQVZMkaUzMTTtv/zOY8mLlm2GmcPKBDKEgYtTACZSa83IcCDtkmiG6NRMdseV
 Qe/lu9enHD5SUqu65cHzP8w2V9/w+jD8D8xiDpx7/5fv5EIei4121xWeLbo/me9etuXux9JTe7d
 3sAEA
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
index 81e180c8706445c270cfecb0500015eee7547f98..ee56f0b86ce303e319cfcd2b0db3bade1540635b 100644
--- a/arch/arm/mach-k3/common.c
+++ b/arch/arm/mach-k3/common.c
@@ -193,6 +193,55 @@ int __maybe_unused wkup_ctrl_remove_can_io_isolation_if_set(void)
 	return 0;
 }
 
+#if IS_ENABLED(CONFIG_K3_IODDR)
+static int lpm_restore_context(u64 ctx_addr)
+{
+	struct ti_sci_handle *ti_sci = get_ti_sci_handle();
+	int ret;
+
+	ret = ti_sci->ops.lpm_ops.min_context_restore(ti_sci, ctx_addr);
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
index a68924a2123961642b63401f3600ac825fb62da5..2c7cc552505bcdffc17fd469db3ee90779f3c192 100644
--- a/arch/arm/mach-k3/common.h
+++ b/arch/arm/mach-k3/common.h
@@ -53,6 +53,7 @@ void ti_secure_image_check_binary(void **p_image, size_t *p_size);
 int shutdown_mcu_r5_core1(void);
 bool wkup_ctrl_is_lpm_exit(void);
 int wkup_ctrl_remove_can_io_isolation_if_set(void);
+void lpm_resume_from_ddr(u64 meta_data_addr);
 
 #if IS_ENABLED(CONFIG_SPL_OS_BOOT_SECURE) && !IS_ENABLED(CONFIG_ARM64)
 int k3_r5_falcon_bootmode(void);

-- 
2.51.0

