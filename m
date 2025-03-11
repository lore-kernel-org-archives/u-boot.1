Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C35C6C28B2E
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 13:17:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93B3E81D3B;
	Tue, 11 Mar 2025 14:13:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dFOku2jo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3F5A80FB9; Tue, 11 Mar 2025 11:33:22 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81739817EC
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 11:33:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-ac25520a289so690523566b.3
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 03:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741689176; x=1742293976;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ItSlqrQ1bPR+VKxPFrhzL1fLWh16Ys3gxQMqNVOuWnk=;
 b=dFOku2joer68aOQMOoEfyZmGENggQOb7qf8d7vELT+yblTPuqXYDiVC3QYh0t6X5oX
 XxFzX2HbXH1BIkIKz8jJYvxh801KejUdJseGCotVdq/3izEf/UXPCU49GBxw/S/nrY1q
 o05oNoxo8hEu+zxveHN8gTKuo7+ZieBcSn1yermDHFxFAV1cYhxNXp7im07+QV++n7j0
 Cumx/M8NKwhj9CU72+1/hglRHD3XZfMQnNzv88Klfm6QVT7g/GaXQL3notl0S58yM3dH
 islU44r2HEWA5/9mHPCMbLOwtS/vQMqUSJZIJtyfTSfimJhGtwQ+TkQVqXfGjHxvDYrp
 WpIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741689176; x=1742293976;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ItSlqrQ1bPR+VKxPFrhzL1fLWh16Ys3gxQMqNVOuWnk=;
 b=O8sC3KUMNIRwbj9jTgEUQFCv4wPXZsIXfFFWNO87cQwMrXmNwluDUJDOEWuaQiBxpS
 WlxBKTUfiOyr4SUpkl5TF7x1HSLSxY9sJUd8uh9aEPiBUl7Ry78lfTkknL6X/n1AF2Bu
 I9tz/Z78nKqaBV3VdVaO3BzrIzAZ/c1A4Xmlwwq1GT1jesWhgFeYldPfCMVdF4o3mhAJ
 n2U0aMNDDepPFO6k0XXsdQ3Y5Xp59XjCdGFRtNmE6VutpFX9sVYB4du84CWMntoDtTOL
 G75/6GVwjpZl+IVpibNaoXUePrG2Aq3LWpjsjUiXkHJ47PVCWyjtjTzTwA1StCWi5fiB
 q2ig==
X-Gm-Message-State: AOJu0YxQEh/4zV1rQagLOwApVfYjp95zYQQSKMrP4mhZVr+Q9rS9AkKL
 HX/EK9wcsHWhgQOSlSoqgdT17/fAjr8Wfubirda/rNzeBEmpugDCbKMAJL5dZ6CqXesJ9GvqGAF
 s
X-Gm-Gg: ASbGncuUqPuVKGIyLHMRXBvLyDktkq2aHdufHbOlnBFQQVaQNQXaGo248TN1/8uapbB
 /xJmvPMXcCTEwMJ/zPkyQ9tfWQR3UyETRKnV3jX0u3GWj7cQcrIjpR5lsBjsfi8tjirMneH+8XL
 h75DSfUYizyVDCee0VpVN/m6rwQjLxIL7Z0SHDfKaYtjtUmyAAi3KE0XIcpmxwYySpLPqaz28Gx
 VZq270FoltqEFT4fEPs3LX/nrOZWRSEg0KE3ibAXL8DstE0IiNRoeWcLYeVd/E50BIHBgeEsPDA
 9Lzixmp9k8u87gysGYlJ2Bo9IG5KyA2QgTJ1lCsN
X-Google-Smtp-Source: AGHT+IGR71U4lkwMVOareNe2IQeQUGCWws0DVbP455qJVU507/C8XPvA1Hy9cUgGvxAhYzPe013X/A==
X-Received: by 2002:a17:907:94c5:b0:ac1:e752:17d2 with SMTP id
 a640c23a62f3a-ac2527048bdmr1668810366b.19.1741689176611; 
 Tue, 11 Mar 2025 03:32:56 -0700 (PDT)
Received: from localhost ([2001:4090:a247:83e0:938:b3cb:2c1b:889c])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-ac29fd8e063sm318255066b.42.2025.03.11.03.32.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 03:32:56 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Tue, 11 Mar 2025 11:30:48 +0100
Subject: [PATCH 09/19] arm: mach-k3: am62p5_init: Resume on LPM exit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-topic-am62-ioddr-v2025-04-rc1-v1-9-666de9c105cb@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1026; i=msp@baylibre.com;
 h=from:subject:message-id; bh=45mUpYpADwpI9p4cBN/e2KEb2FlrZq2BgODnZVZeQjU=;
 b=owGbwMvMwCGm0rPl0RXRdfaMp9WSGNIvCIqeWvuB6bSn2sGKdINX8/O4Xx9Ij35uVnJ/tp1Y0
 fwy5082HaUsDGIcDLJiiix3Pyx8Vyd3fUHEukeOMHNYmUCGMHBxCsBElsxi+Cs3QeJt1RaVvfw+
 F4/9n/JwD1PIlLXpp8Xff7dvkf2zwkCQ4X/233Pm258kziuQSwtbqnZp8cd9Dd7H9S3kjBeZng6
 tVeMFAA==
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

When exiting a low power mode with DDR self-refresh, we can directly
resume after DDR setup is done. Call the common function to resume.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 arch/arm/mach-k3/am62px/am62p5_init.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/mach-k3/am62px/am62p5_init.c b/arch/arm/mach-k3/am62px/am62p5_init.c
index a61dcaeb00f799a1f9c42f48d63c42815c4dcae3..af63cbe3191526add83652af4003974cbaeff0e5 100644
--- a/arch/arm/mach-k3/am62px/am62p5_init.c
+++ b/arch/arm/mach-k3/am62px/am62p5_init.c
@@ -223,6 +223,16 @@ void board_init_f(ulong dummy)
 	spl_enable_cache();
 
 	setup_qos();
+
+	if (wkup_ctrl_is_lpm_exit()) {
+		u64 meta_data_addr;
+
+		ret = wkup_r5f_am62_lpm_meta_data_addr(&meta_data_addr);
+		if (ret)
+			panic("Failed to get LPM meta data address %d\n", ret);
+		lpm_resume_from_ddr(meta_data_addr);
+	}
+
 	debug("am62px_init: %s done\n", __func__);
 
 	fixup_a53_cpu_freq_by_speed_grade();

-- 
2.47.2

