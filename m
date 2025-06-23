Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87B91C77B7F
	for <u-boot@archiver.kernel.org>; Mon, 23 Jun 2025 12:24:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83D6C82E66;
	Mon, 23 Jun 2025 14:23:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="CBO/U56I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42BC782977; Mon, 23 Jun 2025 14:10:36 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F265282D21
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 14:10:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-ade48b24c97so719983766b.2
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 05:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1750680633; x=1751285433;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=D7qQkFC0Diw2/8lrJFTv51dzYtPNhaGLiTc4vichcwg=;
 b=CBO/U56I5K8gfFrYsb5922W7+B6JQDgNegcNelApACH7R6qVjtKo3PxUVJAgsWWJEH
 J9N/MvRMzDFxcQGeOuhOiHSI1slyO0w0H0Ab5QiqIpdRVrzmi5XGmX4Nj88QUbYCKah1
 q4YeG2olKVVICC2wvdYXAmJSoMnM9064iwvmOcCrKILdS7/cpTM9UeXNHJIyyJzX4fdW
 rVUclALKjibEnVzwo22hq13ZUykUo22alkcQvN48cF+81DIAuHLmpiVnkQR/jvl3qmfO
 hE0iEpEJom18VCSfxrc97tcHzNtudjOTkno9hdKG0EQqWbRPSVMiXX/hPAip833eb1wS
 YDAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750680633; x=1751285433;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D7qQkFC0Diw2/8lrJFTv51dzYtPNhaGLiTc4vichcwg=;
 b=Jw0TYN+sRXnPHC1HIyS2ZDg3wz9ub+dNodWJHorefedqwW3KV7CmDcBPxK9BVgJYO8
 lt1GOhhvypUfwSgEqLOl5EIGZf+Xi6hqDsc5Ku3i4DKixZJwbQelZ84Nr5McmvpPOC32
 cPWDDfLTLBKfTh2hAg1rd4fBCj/VYxyuESTdASTN16FcEHiFD5pTxwcFkBa58ipOVA+f
 WnEoN8Y1J+YOY0K2DJgQcQvdDb+jWAlcEKp8Cvh0jsGADNVZz8WiT0oYtChbdwWwdXTo
 SQ5h/5P2Sga6DdFuSpkE8f4bllOk29EZ8yWusSnxdcMWzv9NaSxr1EAJbwFvTPWQJpRX
 8rMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFNamrlDGF/UjIYl2h8J/nlkgadGzK987t+XNhgCx/rk3DSAz10BXV1+VXNi6iFNxx7tVaVMg=@lists.denx.de
X-Gm-Message-State: AOJu0YxsLAq7UA36bkUjdXQs0VeYEJesetwOdZZxRgii/FzJvoUnZNgv
 pdiyyPmfD+EnW8SXrLpHBAB5Q0hz+rkXjyosrcWKdy5jTGnfSYK4UtA6H61M6e2FQDQ=
X-Gm-Gg: ASbGncuxEPHG8M1Y7R0pUhXwpFZ8DjjPcM8BmkGNo5ajl4wsC/ruvEdc7Fd0YXhN996
 lymEn+FOaZ+bWnKnqhEDXdUcBQDKwhmUckhVRlSp2Vx+2xxCWReAMXQlSSy0pjdn+ZQzF2MUw0o
 MdznXqzz2S06u8jhZ7A1bJhRSwqd5WMTgyNVnQHLJLXna98S1/luLRIBpZwRIpnMpcT92NQMB+a
 GgNctLrGxAMUArcQke9VyhEzm01JZzhJ0tZdR0P8BIRV1/BB4bRT721fxbw/eL0/qt/1L+qrquh
 w0UwYprQbdKNa1hzFZeslM4ONFe9G0558lzirkIQfTVWhkecZMskWWu/Y5E=
X-Google-Smtp-Source: AGHT+IFHktGauR4Tn2yMc0Vfvv1kb8p2TGn7lHVcxHV+Q0cBEWYWBDZVPow3FCZfdTifBciGVayS5A==
X-Received: by 2002:a17:907:d16:b0:ae0:6880:634a with SMTP id
 a640c23a62f3a-ae0688068ccmr878799466b.50.1750680633346; 
 Mon, 23 Jun 2025 05:10:33 -0700 (PDT)
Received: from localhost ([2001:4090:a244:83c4:9fe4:a128:a20c:8b84])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-ae0541b6fa0sm694251566b.123.2025.06.23.05.10.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 05:10:32 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Mon, 23 Jun 2025 14:08:28 +0200
Subject: [PATCH v3 05/22] arm: mach-k3: common: Add CANUART wakeup check
 helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250623-topic-am62-ioddr-v2025-04-rc1-v3-5-a4da322c16af@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3204; i=msp@baylibre.com;
 h=from:subject:message-id; bh=Ij3NNHh6e9Y6QD9i/scgzkSYxKuXlilhT+p/NCfYcz4=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhoxI52uneabdeWNet1u/rmz3hMl1BS+lov5MPPbsenO30
 9kwN62PHSUsDGJcDLJiiiydiaFp/+V3HktetGwzzBxWJpAhDFycAjARzkSG/0HW7SHLtL7tszSr
 LVwo/efRMcMn6ZJ7/hdMvmn2bNWh/ZMZvudcypa1fWBh581/JJ0zId8yxbl/0jZG2XnLFe4LbTn
 EBgA=
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
index ff4f2150d318689a87909eb106b0b6fa8ff98f70..7c3f42e35b0f3a5aa7ed0bf01a1479b29d947540 100644
--- a/arch/arm/mach-k3/common.c
+++ b/arch/arm/mach-k3/common.c
@@ -161,13 +161,31 @@ static void wkup_ctrl_remove_can_io_isolation(void)
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
2.49.0

