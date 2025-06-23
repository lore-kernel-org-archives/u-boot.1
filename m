Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94B3BC77B7F
	for <u-boot@archiver.kernel.org>; Mon, 23 Jun 2025 12:24:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7F1C82E8C;
	Mon, 23 Jun 2025 14:23:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="EznsnYU6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 934B682D17; Mon, 23 Jun 2025 14:10:37 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 787B081E13
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 14:10:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-ad891bb0957so752601066b.3
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 05:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1750680635; x=1751285435;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zPlwwRNYH4ebdPsBsxVwRCMGTI8zVrWd1metBWQuUJo=;
 b=EznsnYU6VBQ122yKjASa3kZIMnl8fAC5HC3GAeAWm67beuW8XWG+GpCc6AD9TeMy/c
 vqkmNdFHJSo3U3LEIiwqrNtlh1gry4HPIQadnou91dVj5T34PJKK/DMCtEmRT6BmNTpS
 3psECPfutabzwUXnXRtITxCBIpAUJnfmCZsSBCSOuX0At77EhzJSzCOiHipnfcO3AQyD
 CLu/DAnTzK0OQIk85HWOSG7poL9k5Scwnzz1ZJKwpSXzqsTK2FNZvu+ZpRIBEzspTKXJ
 kZakAkBNC9cKGdvUVYHh6qwkC1eoyDihwWfp3jgRp69l5pHqJSFgGsorPewXIHVHweBD
 CA4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750680635; x=1751285435;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zPlwwRNYH4ebdPsBsxVwRCMGTI8zVrWd1metBWQuUJo=;
 b=MhmDwWU5CHxIOfkpUFTv8O9Qtnq5YzS9JtWW1LyqocoB9I1vsZePh6WZjHaqqq0IOx
 6VwA2vxJkE3RVYLCQSMcXihv8hR2VhWZ3fQtdHHPeeZPRonbYkn+CCKMp5YrDjkW2pd4
 pJ659np1SJp3EUhrRBylh+iCdKLt4dRTR2Zqf3RMBkJJbxiFUBGBXo61VYzvfCIPkVuZ
 c3UC4PpQE+dmnesJb96E4rYcLPS+s5psy6b46bpLaOuAtpUOw+jV9QxQTT09UweHRvue
 xY0xeCt8Byw7j5sYknDjUIwaBgz7UulsDAmbUej3WkOyxoK7WS0CIAlYrVQrmKP/p2Ce
 JEQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbZBF2dTcfmqJo6AqIRjznhvctRgoV2iaQ5K67zVKNsthW1G46qAMydw9XQeC3AgthkaU4Sws=@lists.denx.de
X-Gm-Message-State: AOJu0Yxp2nvdnKMrtmIS3VnGzxkuVHW7XwOlw9Mcf7a2Az6ETWIsXfiE
 4WWvkW+NyJuV21QBGaRX/mFM1Evhmwgn7r9k6C4Z0HuLUiwonHFYbzQvQIpEwWMSdq4=
X-Gm-Gg: ASbGnct3t4+YO6sVtW+c6JlgFuH3SSPMbnGRRFgiUVRhSQq0Pp8FniKJOyaXTi9oIsT
 un29qePOgcY8qj992uPTQ+vWvr3lawrFME3TSUcSEhXFQw7vMbnSN3vNaaI/rYjIoYdlxI6rhuz
 ZD5RVBTfyzeGFKIFVWHje5wSs7fo99aZvFATVcEU8OF57ocqbd/641j9rdfRZyxIaawRgUQWETU
 dFX3Mc6k1Cs/ZpB12070sriK4/cFdNRn7tKIezKhvMUczBs3fHDpIyWoW8A9duCvgIE+bcYQAPC
 nQ5S6aRhhJGgsJs4KwG09L5eWElcJPkD2dlfY4R/6s63LcoBqoXkru7EVKxo4UIbGgL2Tg==
X-Google-Smtp-Source: AGHT+IEpI75SV8swBlrwczh+NAo4WGc+yq7hTGf7/Ii9QsMSZ+7iCT6lTk0d3d0+9IxWAJC9OXxxdQ==
X-Received: by 2002:a17:906:4e8f:b0:ad8:a4a8:1038 with SMTP id
 a640c23a62f3a-ae057c7d7b2mr1004766566b.53.1750680634920; 
 Mon, 23 Jun 2025 05:10:34 -0700 (PDT)
Received: from localhost ([2001:4090:a244:83c4:9fe4:a128:a20c:8b84])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-ae0541b6894sm699554666b.111.2025.06.23.05.10.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 05:10:34 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Mon, 23 Jun 2025 14:08:29 +0200
Subject: [PATCH v3 06/22] arm: mach-k3: common: Add lpm_resume_from_ddr
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250623-topic-am62-ioddr-v2025-04-rc1-v3-6-a4da322c16af@baylibre.com>
References: <20250623-topic-am62-ioddr-v2025-04-rc1-v3-0-a4da322c16af@baylibre.com>
In-Reply-To: <20250623-topic-am62-ioddr-v2025-04-rc1-v3-0-a4da322c16af@baylibre.com>
To: Sumit Garg <sumit.garg@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Bryan Brattlof <bb@ti.com>, Tom Rini <trini@konsulko.com>, 
 Robert Nelson <robertcnelson@gmail.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: Sebin Francis <sebin.francis@ti.com>, Dhruva Gole <d-gole@ti.com>, 
 Akashdeep Kaur <a-kaur@ti.com>, u-boot@lists.denx.de, 
 Kevin Hilman <khilman@baylibre.com>, Vishal Mahaveer <vishalm@ti.com>, 
 Kendall Willis <k-willis@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2761; i=msp@baylibre.com;
 h=from:subject:message-id; bh=ENOE/vHBBGZqA0ss48DaPbp9oy905FO2e2BTAQuW5fg=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhoxI59sSkW0Lt8q4aaeLMiRVv1x4L3vCKpFTCtxR/lU/u
 uw/JhZ0lLIwiHExyIopsnQmhqb9l995LHnRss0wc1iZQIYwcHEKwERCpRh+s11WyLqV0OPfHX9v
 1SSZtWa7dXTV5p/4sa83yslba+UtQ0aGfeW79nR9nWddku66QmGWyPf88w4CW63ZWNlXvS4/fGY
 KEwA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Mon, 23 Jun 2025 14:23:35 +0200
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
index 7c3f42e35b0f3a5aa7ed0bf01a1479b29d947540..1ef560e2fb936c4245323bbebc5af3ec277b8792 100644
--- a/arch/arm/mach-k3/common.c
+++ b/arch/arm/mach-k3/common.c
@@ -186,6 +186,51 @@ bool wkup_ctrl_is_lpm_exit(void)
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
2.49.0

