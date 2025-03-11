Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAC7CC28B2E
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 13:17:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4976881D1F;
	Tue, 11 Mar 2025 14:13:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OyclqslY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71008814B6; Tue, 11 Mar 2025 11:33:20 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65D3D817D3
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 11:33:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-aaf900cc7fbso1085585366b.3
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 03:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741689172; x=1742293972;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rCFdMQbOn5HP2t7PCmbK7jYrnj38Djj6lbXR62/p/kg=;
 b=OyclqslYELqs9NTrfppTPPDkKYff/nzOuJ0T7RtWCFsh01BBrq1iu2tKzQxfV6h1Wh
 7Terbvl1dub9cZ9DExsBoOmmi/YMaZ2PP5FUNFmI0rWKlbgIbWnOQzCIKxV2JqdIrj03
 2rY5GjYBgtgP4r/aMzS05X2cpDorK0DOnWwcTQZ3wuoNoFf1uR6DEEpxhpudaZcBgM5E
 /Uct/SjeLBtUZfHo1Vo6GH0MgtX5EW/Wt3ii9pAVEnmo33jBM47gJd/tOrpISxs+vzw8
 Msm1+xT5HnBq1wZ/NSjq3t+d5IKQdFquexNYmXAY2TXNmsNnDWK7k3s1thnqFQ2HzD3d
 kSBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741689172; x=1742293972;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rCFdMQbOn5HP2t7PCmbK7jYrnj38Djj6lbXR62/p/kg=;
 b=dZP3Z40Y1HMZjOvZRzvbYsgR/ISJZ3F1graKvS7VGwQBoVPQmkLR3WECeee7QKBgD/
 esk2iWtNi8r27hUTu+RDcdeIWyEA2x9yRPf3THffyBKkWXHSR7zLFHFUTYqtxQX6Ogp9
 p2Wuepfa+4IFsX/tQyHZNETkyWZJQQuiiFZQBDGdCVlxT3ex2zrSZT1P+/ij2ADA7Mst
 c6MexXvB053O5O6bbDDTrdmxv4EUkY5KxDwITwU3F9uW/AgwalHNDROuemYTtUTELMUw
 fLSpgG6RaVJsL4MzfAs7lRQlWt5wMq8LCU3zbgLS7AbzRGdBR4kOfz5Xmz0So32Kub69
 0M8Q==
X-Gm-Message-State: AOJu0YwVZ/RPAXX8R2rAwAGt5UqvxMHlq2JYmAU1hBwGhIVcJXQvOoah
 ILZMJD2NgvDTn4b1GEIuxguMxvMg3XhdmjXqMFI03XAFUwdb0ez6Tq/SndL6kQQ42FM89w8ZS/E
 p
X-Gm-Gg: ASbGnct/nzzp+JCcFDakFEQ2/Q/KYiOZlb8tzd6R0s81DN4GuMnoR2jaVXkq080geLY
 7U5Ix7zm4e3swBp/SnxuE9nPZbcmJVBslJ77v/1IE/s/f6wlWIoMdWFDItCHEwrOZce+UpWNHg8
 S1Aaxj1VO/xPVtQAx8E82QuHeTv5i2jbJ8nfBE+9ezspN4QnBg6Q7t7ygGdHvwRdCIq0tzUVg34
 JHiBo9ah2DAnCCbONDhZWNHqY6THTylTzYooxx9dJvam9EpnxmceB7tXq0bz+jTdmn9lx8sFabf
 7NVMtdtkFy8XU9HawaR6EGHVPHKHybfPKQf+AZ1i
X-Google-Smtp-Source: AGHT+IEI3k+dobF0vur1LEghGbWx+zKNWkl2jFxJAukdxlstI1bfezvWTI9mzGutGsQguFJHVcbWBg==
X-Received: by 2002:a17:907:60d5:b0:abf:78b6:c565 with SMTP id
 a640c23a62f3a-ac2b9db4878mr385811066b.4.1741689172190; 
 Tue, 11 Mar 2025 03:32:52 -0700 (PDT)
Received: from localhost ([2001:4090:a247:83e0:938:b3cb:2c1b:889c])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-ac2a27d2613sm304919666b.12.2025.03.11.03.32.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 03:32:51 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Tue, 11 Mar 2025 11:30:44 +0100
Subject: [PATCH 05/19] arm: mach-k3: common: Add CANUART wakeup check helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-topic-am62-ioddr-v2025-04-rc1-v1-5-666de9c105cb@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3218; i=msp@baylibre.com;
 h=from:subject:message-id; bh=QKzluirgtPoy++0BTejuCDxVxAbRbYrAqMVyVkjORmU=;
 b=owGbwMvMwCGm0rPl0RXRdfaMp9WSGNIvCDL1JHnoBZ1p3LB0SUOyT+p9uVU7+n1UzNZIKopol
 b+97bKjo5SFQYyDQVZMkeXuh4Xv6uSuL4hY98gRZg4rE8gQBi5OAZhIvTDDX/nDp5pua0l+ad3p
 uXOm9AuHLbIzHh0VX/5q0dEPE/Y0mQkzMry+MrHlCt/HwkvnlJo61HY/TKkTuX3waNPzt1uDPxq
 9ZGEFAA==
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

Add dedicated helper functions to check CANUART wake registers and magic
word. This helps determining if we are in a wakeup or if CAN IO
isolation has to be removed.

Also add a helper to detect a low power mode exit/resume.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 arch/arm/mach-k3/common.c                | 22 ++++++++++++++++++++--
 arch/arm/mach-k3/common.h                |  1 +
 arch/arm/mach-k3/include/mach/hardware.h |  3 +++
 3 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
index ef40d623058072e89e9b3e53fc0f7ea6b78f96e3..e3554ee6aa8957b8cfcacb452ba391d7b3abf2a9 100644
--- a/arch/arm/mach-k3/common.c
+++ b/arch/arm/mach-k3/common.c
@@ -127,13 +127,31 @@ static void wkup_ctrl_remove_can_io_isolation(void)
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
index 0359fea5675bdaf8cdde7989eebac1a695a065ba..5d347c7252d18c06dac21813b8247fa2c57902bc 100644
--- a/arch/arm/mach-k3/common.h
+++ b/arch/arm/mach-k3/common.h
@@ -46,6 +46,7 @@ struct ti_sci_handle *get_ti_sci_handle(void);
 void do_board_detect(void);
 void ti_secure_image_check_binary(void **p_image, size_t *p_size);
 void wkup_ctrl_remove_can_io_isolation_if_set(void);
+bool wkup_ctrl_is_lpm_exit(void);
 
 #if (IS_ENABLED(CONFIG_K3_QOS))
 void setup_qos(void);
diff --git a/arch/arm/mach-k3/include/mach/hardware.h b/arch/arm/mach-k3/include/mach/hardware.h
index bd7407a4b9498207d94a35d8f73b852c7528a086..949badb18dc453421ce0f0d403554ac604cf4534 100644
--- a/arch/arm/mach-k3/include/mach/hardware.h
+++ b/arch/arm/mach-k3/include/mach/hardware.h
@@ -118,6 +118,9 @@ K3_SOC_ID(j722s, J722S)
 #define WKUP_CTRL_MMR_CANUART_WAKE_STAT1			0x1830c
 #define WKUP_CTRL_MMR_CANUART_WAKE_STAT1_CANUART_IO_MODE	BIT(0)
 
+#define WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_STAT		0x18318
+#define WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_STAT_MW		0x555555
+
 #define WKUP_CTRL_MMR_PMCTRL_IO_0				0x18084
 #define WKUP_CTRL_MMR_PMCTRL_IO_0_ISOCLK_OVRD_0			BIT(0)
 #define WKUP_CTRL_MMR_PMCTRL_IO_0_ISOOVR_EXTEND_0		BIT(4)

-- 
2.47.2

