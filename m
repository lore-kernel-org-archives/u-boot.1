Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E49F4C28B2E
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 13:14:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4518681703;
	Tue, 11 Mar 2025 14:13:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="e7zxiYzN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77DCB817D8; Tue, 11 Mar 2025 11:33:15 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC2558164E
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 11:33:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5e5b572e45cso9542830a12.0
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 03:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741689173; x=1742293973;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qhz8KgkRG21Rth6gCkWCqixI/EYsD9p2a2KTN4+XAJM=;
 b=e7zxiYzNkM2ytPeajxczuLga51Bl7T4TJsNnoq0gNM4hXFzpss3t+d+vmKK0MOoaJz
 m6ngDNq2N11x3euq5aOuBUjRhXlRMCnk2GsNmG/endVh6D1lx99rZHX0JT/+pl4i0yY5
 cuhnh30SYo0v4Ia4qZOQmjpPqbirirenPtiBy/9PCzbuiLWxu/pNjzKVZXGAEhJ9MD3f
 +/YFSB+/yC3Q2mMG7DWi9KWFf1xxaIkjeBoC52f++GRqNW+Y6+n4OVjx8AS5Vbu9hok9
 2XIwPycaPAM62hQAjXu9fbzQh9VBFhvqlbMPruNzHlrelSZh1UdYNemJCmKpd7FzxeIT
 X4FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741689173; x=1742293973;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qhz8KgkRG21Rth6gCkWCqixI/EYsD9p2a2KTN4+XAJM=;
 b=FSrf3ZbuHaYVnYDYYsxF0GaUR/lZBsUdNMrU3WBySyZZ6PNI0wgpmg+WPovM+YIFqA
 fpQfIc302Nl14Oz8tIIcdDAb2K1rRUTloxI/maHxWvonMjU55bWqtcg6Kc06x+EUHWk/
 gcjzdoWF10LcBhsmrAa1CIwFBJ3m+ytgcR2p4/fUUyeMZL2XgVG/gURrM6MNU5CatmwF
 8KT11A2zWBsmB8pTOG88EwSIYM3UyRkSOL6A67nhUcmyubrvZwCuZ4Iv0cT/TVzKOVT/
 BtgD3ZXtrHVXeM9ZmXN/rzYwZr4ObheQ4oY3pIBvXNkTXf6LEwJzftX51tw7DxAANG2B
 N1lg==
X-Gm-Message-State: AOJu0YxTBd/ZN4p0cod0aG/Ka1FiGcaymFrlvGlmL/AvFUi8kIJXLR4H
 hqcLu+4WXVas0lHn8c9XiRIcWNGoXDVMzTpIH9+LRmwvpsJpRaU8aF5YhoueQwh+6GzIOxwXuKv
 9
X-Gm-Gg: ASbGncs7/pz8ShfL+v8NbgsMhgUuvdZPDVRzgTk/stL+oTIuVcnpPA7m7BLgzYlk/Zt
 iV7oC17HP7VIgp6I7+wT2MOsqlPX8Yikc0vQYCgBg2tbFcvzxtGeVWrwX7xUOmX9Ofh8wwH2x/W
 e8eap3nkEUoZ6Adoe+z8yrowE/NHUqai+VsXsXNihcf+uob8478DG9rwb66NuKcSPnxtu5zm5YS
 OuTHEhDb7WBfjZpU+tqn/5gddZd7X6vpHpSw7VVYSif592niZo8SJ1OpW8a/KsJrBKWn3IarHqD
 xv+INFbjoc1niixcfccbGZveStVfV3duBHlKPIgAozdAcpyHhkM=
X-Google-Smtp-Source: AGHT+IEsAFVVvLoxQkEpgGCF9bkTcr2jL4R6gC/kyuugukznX0fmJSLnTVT9TAJjlmUuNOIlIYGm4Q==
X-Received: by 2002:a17:907:9490:b0:ac1:ebfe:fd90 with SMTP id
 a640c23a62f3a-ac2525980femr2104346266b.1.1741689173292; 
 Tue, 11 Mar 2025 03:32:53 -0700 (PDT)
Received: from localhost ([2001:4090:a247:83e0:938:b3cb:2c1b:889c])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-ac2523d940csm780609066b.178.2025.03.11.03.32.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 03:32:52 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Tue, 11 Mar 2025 11:30:45 +0100
Subject: [PATCH 06/19] arm: mach-k3: common: Add lpm_resume_from_ddr
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-topic-am62-ioddr-v2025-04-rc1-v1-6-666de9c105cb@baylibre.com>
References: <20250311-topic-am62-ioddr-v2025-04-rc1-v1-0-666de9c105cb@baylibre.com>
In-Reply-To: <20250311-topic-am62-ioddr-v2025-04-rc1-v1-0-666de9c105cb@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@linaro.org>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>
Cc: u-boot@lists.denx.de, Vishal Mahaveer <vishalm@ti.com>, 
 Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>, 
 Sebin Francis <sebin.francis@ti.com>, Kendall Willis <k-willis@ti.com>, 
 Akashdeep Kaur <a-kaur@ti.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2756; i=msp@baylibre.com;
 h=from:subject:message-id; bh=sa4er2TDgEfAsnpUrh+EsjKntrm9MqVFH9nPSk9O8RY=;
 b=owGbwMvMwCGm0rPl0RXRdfaMp9WSGNIvCLK9j/jqobxo89yFhkoLFiw3m7bH5PYGvzvXX8geC
 JN7vJTRpKOUhUGMg0FWTJHl7oeF7+rkri+IWPfIEWYOKxPIEAYuTgGYyHNJRoabu3tCmm9oi84S
 vnnU4cISqcO1V/4sFuPpuxMfOWXy/LsHGBmedHer7zuyy8/AuMLjzuX8jpsFWz0WHrdznCBU68L
 Oe5ADAA==
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Tue, 11 Mar 2025 14:13:18 +0100
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
index e3554ee6aa8957b8cfcacb452ba391d7b3abf2a9..2d9f34e61d916ce3a252e9cc3c2fd5475e60799e 100644
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
index 5d347c7252d18c06dac21813b8247fa2c57902bc..47f2dbf2accd9029d6f1905fe8d3f93381032a81 100644
--- a/arch/arm/mach-k3/common.h
+++ b/arch/arm/mach-k3/common.h
@@ -47,6 +47,7 @@ void do_board_detect(void);
 void ti_secure_image_check_binary(void **p_image, size_t *p_size);
 void wkup_ctrl_remove_can_io_isolation_if_set(void);
 bool wkup_ctrl_is_lpm_exit(void);
+void lpm_resume_from_ddr(u64 meta_data_addr);
 
 #if (IS_ENABLED(CONFIG_K3_QOS))
 void setup_qos(void);

-- 
2.47.2

