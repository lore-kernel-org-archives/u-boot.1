Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07ABDCCF9E3
	for <u-boot@archiver.kernel.org>; Mon, 10 Nov 2025 20:14:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AECEF83D2E;
	Mon, 10 Nov 2025 21:13:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GjuGG8CV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3416983AAC; Mon, 10 Nov 2025 21:11:49 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3760C83A98
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 21:11:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b5b823b4f3dso502701266b.3
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 12:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1762805507; x=1763410307;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0IMy9M+4LygqPG9qDHPTIug2XLHNZaAJarg5Y1BdG1I=;
 b=GjuGG8CV+dYv7ziR3bw8YDXEZl3sHNbWEU1gvXMptASdzqGOiRo6VXDaIBHGPkC7MD
 X6ELqZuj1NO35LuLN0vSKeAvBvOqNtJJZGZADX+kIcVD3DbiogO463Qh+TvEEe0o5QBJ
 i/EOsUH9Q/tFy2JA5tRLuT728qoptTNT+PuGQShHgaiDN/aeYT/leInMw2LnnqVvuc9A
 PPfchrrvaNQiZdxEKh6zakj/MW8Zugx/tYuuskZclybfXfT8s2q0SRQbjPZAzkRA6xfB
 wGC2ZhXY3HiW/PpPosLEsgqIDuJdwtgWD1BELJsGujEGeSkftI9amrE9yjR/T5BnDGjm
 geAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762805507; x=1763410307;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0IMy9M+4LygqPG9qDHPTIug2XLHNZaAJarg5Y1BdG1I=;
 b=RwvDXwg7N0P1nw0BNtg38M7vlf0Th7RKrMHYk41v2HTA1QK34Iad07RGynnLYjDo0q
 vV2SuerfsrODm41BmuhD31e9uMW50NHiF7vvsBZwxq/DnxwJ621bsf/Jvh7Df5RmHS8a
 waVLs+s/XvM6GC1wPdwrDeRYKRItkpz8fFYlmFwOdWZ0LhGEzBUSxZYHtPyvbLS6Yfx6
 3Pl5q5DVnbGXcFwE47U4TuUUkKF7fMDnUkaoCyJ8YI+aeN+ItLoJ4wneQglmmwm2ecYq
 W6NmQYkTgW9j9o93Ch57+WPA714OlYP6peUnDPwuKhLLlhYOvQN3tXlycNOfqceoBhRz
 vOCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPJn12DsGkKJJFYKc3Kw6joUpAqu+ITNDeoGfS8tPDLDHHwQkgNPOP0xOWYBO8hy35IOOOE6E=@lists.denx.de
X-Gm-Message-State: AOJu0YwCJSTDprwhmJ+COPFY0Prz6xLe1mH82kNLSVJ9wHMacBRGVoR/
 6WoEf6ePCOPNv3kPSD8vAvRQxS2P4S7U5L6zEKguOabiNfY5NflViW8fS6nD7ZCD8Ys=
X-Gm-Gg: ASbGncu+9tuT/dN4pjSDB755ES/JkxxMhFPvvL2o5RzlbUwgjVzQRcTkuMD0l/tiDFF
 +JG1wkFIMVM5bPTBQVUjSt9qJk7wy3JEmia0md4mNbeXLOFF/sUQBj22sq3b2vmh9zOHVHUBouO
 /YYf7z4VeFyuHVGx1izBnv2lMU2mLiUIOSQWR/4bYY52maDMOch6cnovVmBKVSdmCShVnv4728T
 q9s+dGwDUF1dXVqwqBvzxVgVpF1hYd6J4+jdJOPzZsLEv8R5K27HgutxZ5qeSmnHGxsyJxbzvxQ
 8yjW3YWQ0YbupTUriXqMfTs6JvpZTkjgu29vVN2Xo3i3rPWxm1xdlhdBRzGf4U4oreBPmOklSsh
 UL2p4BiWaFtqy37PMD1AZ/si2mw1oP1vo/8CyP6DMkE4suMiRVUyEaVHYclI4v4UmVDWeZMvPxA
 2qpWSXbg==
X-Google-Smtp-Source: AGHT+IFtKAFrEgxtPvvXJ5u20Axn1zMKP1S1WxGnQnwwP4ROSzDinmvi7vqWm84YS5V/OeiTG8gcRg==
X-Received: by 2002:a17:907:6e9e:b0:b70:b13c:3634 with SMTP id
 a640c23a62f3a-b72e041d1damr1007767266b.25.1762805506585; 
 Mon, 10 Nov 2025 12:11:46 -0800 (PST)
Received: from localhost ([2001:4090:a247:830a:fe22:a8:f29a:a5c3])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-b73108b0937sm247824066b.3.2025.11.10.12.11.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 12:11:46 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Mon, 10 Nov 2025 21:10:30 +0100
Subject: [PATCH v5 06/13] arm: mach-k3: common: Add lpm_resume_from_ddr
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251110-topic-am62-ioddr-v2025-04-rc1-v5-6-980ee0036c26@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3026; i=msp@baylibre.com;
 h=from:subject:message-id; bh=9kOcSfg3Zu4PZBs87pvpOrjEBGf3LPARIK+mem9356Y=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkwht4sPnutGLV2dXDhNMjR7xve3Gzfav/3a3TPvyV6Wh
 3NufUjV6ChlYRDjYpAVU2TpTAxN+y+/81jyomWbYeawMoEMYeDiFICJbNNi+J+x7fWNByr3fB5Z
 /HI+4pzSp21zIEfzrNRkjwmfZzmVi4oxMqy68YObWU0v7/TGiBOHbDvWCB+cbvgq4uuUjzPt0wV
 tStkB
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
index 10964417295c1b3b1e0a36e03617cf1b32d09b97..38d6c88644705ca55b669aee081c8bcf33df8540 100644
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

