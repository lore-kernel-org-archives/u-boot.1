Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99A0EC71153
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 14:00:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A04B82D7C;
	Fri, 13 Jun 2025 15:59:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1v+aFh/c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26A1E82D17; Fri, 13 Jun 2025 15:22:03 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49A8782CA8
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 15:22:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-60780d74c8cso3947674a12.2
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 06:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749820921; x=1750425721;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KJ+F0IATWQ3+4zvvPdBG+Je2AsQg849UBs68Y+eA8Do=;
 b=1v+aFh/c/gb0glzXhQYDQSexNP27dcKbWCLpZT7EP1oynsJlxV5CiAJ3nxd7MRhiZs
 lvHZ1P8K2z4ilNkVxip5drULDDyIPQxI0bZkd40umSaYrzOf8nN0XSFkMM7XS9HMqx6u
 jbs/bcqwcteqgRW1csGyeAWf07DgUZuUoD7Xxc97uJtJVUEw/fHvzMrzwOrQT/vWhctv
 Sdvbu+NyJiE79irs3ZCHFZTXueEPMwU9Bqti+WAOn+GfUj9Cw+vyTy7eg454Wn8DMBKP
 pKYWg5XcFzFAlqXxaQUMcoPl8BmY44iiAIKgC1fsDH3Q/9up0W+rPSIgbuW/ZzeVH9Lw
 QTDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749820921; x=1750425721;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KJ+F0IATWQ3+4zvvPdBG+Je2AsQg849UBs68Y+eA8Do=;
 b=ZKexz/Qhjg2iGM9W++f722yTaTcFXlM1SilcI6e79gLSwFQBnC5wRSC6JE8uKIOl2/
 OPvCMKiXMh0Ecta0PjPb/IDnOeeN30ig9nkqQySLrMYeXkmfZWMTbTn8Quef5UeeaCP/
 tDTnP8+apHPpeTzKnP6LTb909CLsaO1XWok2tr44MKgKoqMUGu22n3CUaCcsd9sjjgez
 V2UzmGwcqZtVMKZa8Fv0b9vNaDG++2m1c3BYzM6rPR11I50Hjj6iHWwd5Xx+87Y0dJAA
 6Gq0B9DOrtxIw123iRrmfr9gZxdxOpyEy8lRzkzXs+aE1YRmlJwTbKHNYFEk4fG9QR4o
 9qng==
X-Gm-Message-State: AOJu0Yxyiv6FXoxdJUCDvpeHlohwkvHYumMf+sGYqHYyUNypt39GuIIG
 oxtKZZXey2JXQ6k0obF+YJp0v2HQzf5nYWAiW3M9Tjl0XdHdjYy6IGhXzki5DPZVJ64s7sh8VKa
 wWpC2
X-Gm-Gg: ASbGncsvZeVr1nVERgrPXXyQeLgNRqEuY8jPjnBm85O3DNdtR+cHow4ubU3Ius0FI3p
 99/O17FY1itscmf/sLp7a3/TXQVT8Bkqm+JpxwZo+0+fSrsRzvRc9/KU3EMbv5GisIA8NovcwTA
 cEd/DM2hgL5k572ruUqqu++zt8gjswI/qChyOlm8FuCBCLNDdVcVUuTuS3HN1HltYXyNusxmHSm
 lAMGBiOJS9lMnryYRZfYLVSc5R69qB8G82iSs3R51y6K57BKftvXjE4EP5XDbTUBZKG1EpBhM4+
 kxmBeGDLYiduthCXBBK3U/h8paix4uBmEGGgHLFHqqhKM+L9JrGf2eyY4EI=
X-Google-Smtp-Source: AGHT+IFrSQK/7zv1EreQolmwW7k089834LMQAN+npN+imvB9DMs6kS5PpBsKokTAiB23IonO/6J8NA==
X-Received: by 2002:a17:907:1b13:b0:ad8:959c:c55d with SMTP id
 a640c23a62f3a-adec555b59amr311695866b.2.1749820920650; 
 Fri, 13 Jun 2025 06:22:00 -0700 (PDT)
Received: from localhost ([2001:4090:a244:83c4:9fe4:a128:a20c:8b84])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-adec8929d8bsm125588166b.122.2025.06.13.06.22.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jun 2025 06:22:00 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Fri, 13 Jun 2025 15:19:26 +0200
Subject: [PATCH v2 06/22] arm: mach-k3: common: Add lpm_resume_from_ddr
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250613-topic-am62-ioddr-v2025-04-rc1-v2-6-3d233aaea355@baylibre.com>
References: <20250613-topic-am62-ioddr-v2025-04-rc1-v2-0-3d233aaea355@baylibre.com>
In-Reply-To: <20250613-topic-am62-ioddr-v2025-04-rc1-v2-0-3d233aaea355@baylibre.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, 
 Sumit Garg <sumit.garg@kernel.org>, Robert Nelson <robertcnelson@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Bryan Brattlof <bb@ti.com>
Cc: u-boot@lists.denx.de, Kevin Hilman <khilman@baylibre.com>, 
 Vishal Mahaveer <vishalm@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, 
 Kendall Willis <k-willis@ti.com>, Sebin Francis <sebin.francis@ti.com>, 
 Dhruva Gole <d-gole@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2756; i=msp@baylibre.com;
 h=from:subject:message-id; bh=RJiB7bd+Cdsqz/Jom8DHpish3BsFyjnjdX9SRT1Lki8=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhgwf1Uknr8yxzGjXXnbOy/rjzFsvJ+5aXT7zYu6DZLdHs
 yU95P3PdJSyMIhxMciKKbJ0Joam/ZffeSx50bLNMHNYmUCGMHBxCsBEdp5nZPh2fyqr6IXmRcmr
 3Aunh4ddXfuooVVUUj3cMvLa3Ajn2TWMDO3R9a+dN4olT1pjwycuHpl2u2P13gublsZ8fNF6mdm
 onA0A
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Fri, 13 Jun 2025 15:59:32 +0200
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

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 arch/arm/mach-k3/common.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-k3/common.h |  1 +
 2 files changed, 46 insertions(+)

diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
index 9ee47732929dd08f77aefb2f0d65ac93c79d25a2..c6b230ad46a891ff0250a2bc65af2aa72d09fbc9 100644
--- a/arch/arm/mach-k3/common.c
+++ b/arch/arm/mach-k3/common.c
@@ -152,6 +152,51 @@ bool wkup_ctrl_is_lpm_exit(void)
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
+	struct lpm_meta_data *lpm_data = (struct lpm_meta_data *)meta_data_addr;
+	typedef void __noreturn (*image_entry_noargs_t)(void);
+	image_entry_noargs_t image_entry;
+	int ret;
+
+	ret = lpm_restore_context(lpm_data->tifs_context_save_address);
+	if (ret)
+		panic("Failed to restore context from 0x%p\n",
+		      (void *)lpm_data->tifs_context_save_address);
+
+	image_entry = (image_entry_noargs_t)(u64 *)lpm_data->dm_jump_address;
+	printf("Resuming from DDR, jumping to stored DM loadaddr 0x%p, TIFS context restored from 0x%p\n",
+	       image_entry, (void *)lpm_data->tifs_context_save_address);
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
index b3c1702b8125d0c8248ac15dee4387a807b516d6..53a509f4ff5159b32d1c359ab458ec9a7aa07956 100644
--- a/arch/arm/mach-k3/common.h
+++ b/arch/arm/mach-k3/common.h
@@ -51,6 +51,7 @@ void do_board_detect(void);
 void ti_secure_image_check_binary(void **p_image, size_t *p_size);
 void wkup_ctrl_remove_can_io_isolation_if_set(void);
 bool wkup_ctrl_is_lpm_exit(void);
+void lpm_resume_from_ddr(u64 meta_data_addr);
 
 #if (IS_ENABLED(CONFIG_K3_QOS))
 void setup_qos(void);

-- 
2.49.0

