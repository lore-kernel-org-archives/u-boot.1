Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E9E5C52D7C
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 16:19:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FBED88E0A;
	Wed, 21 Aug 2024 18:19:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Pt4oEsQI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEB4688E0A; Wed, 21 Aug 2024 18:19:39 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0A1588C05
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 18:19:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-70943b07c2cso3863091a34.1
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 09:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724257176; x=1724861976; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oZOaxOWgCRZnzfHu3nJerpfmZkHRW68UST8KIHRI/0M=;
 b=Pt4oEsQIqJUsZjlLst5FDOG/WAx2MRMBvzCYfCQrCZfBa636UYO5J2oCGFg3I1ngD7
 MkdEvPCHcJD/lvfp8R4HahS4rcWoLLlgcerzHUCNW3lEoTxSb6sSDEbw/blG2Tl1pWqH
 4QiP1vg/tkiyEAKICPNynYWrl+1K/wwxgKKzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724257176; x=1724861976;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oZOaxOWgCRZnzfHu3nJerpfmZkHRW68UST8KIHRI/0M=;
 b=WcZ9WTt/+uOBawpLfaxMuKNA5RTw4E8S+0PtPL53cOnCKeUNL1QRiQDLuJKdRO2xWG
 CHWx8o7GlsVC/XnTYNxn6+jiwd2mK7qFHbtCovXLWF6bYU3YQWQtMUcajbv0289HOd+X
 /94P322QDQtfLvZPESx+1vWPKhZ1na5zSKiaphSOowARg5IQvnaTUhDPHJHgqTVrBBPY
 rQm8aazK8llA+A0kLttpjwbkAZGlym1gFG8g0FBUX85d9REggq/+3dpaIVWHTEjod33n
 ZGDx4BLLTRScFJ/xvCm2p9VzzI356vHojyolfwOMRogT7P3rt3OpcQT8Abg0ifjh4WH0
 5LUw==
X-Gm-Message-State: AOJu0YxcvCVpF8Vnp2IXuWO7Nz3ZQlrCmcClUT0q2LhlnEUPCw0HIC2V
 GKYV0kglgeTQu7Ox6kxiV/gsFRqDpHBTkHu9pjYOp50qdaDbWmaDWUs3laI4wCq4XLeZPVg5bY4
 =
X-Google-Smtp-Source: AGHT+IFLEmZ4Ifz5j5DH5ILGXOo8oHpExKG+su6or/+p4q7hRngsQ3Gz31/NTtoAg6FQ4gQ85MZWsw==
X-Received: by 2002:a05:6830:6189:b0:703:5dbc:1aa9 with SMTP id
 46e09a7af769-70df87015a0mr3770507a34.13.1724257176313; 
 Wed, 21 Aug 2024 09:19:36 -0700 (PDT)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70ca6629792sm3222376a34.72.2024.08.21.09.19.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 09:19:36 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 01/35] global_data: Move pci_clk to m68k and powerpc
Date: Wed, 21 Aug 2024 10:18:53 -0600
Message-Id: <20240821161927.695717-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821161927.695717-1-sjg@chromium.org>
References: <20240821161927.695717-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Only m68k and powerpc use this field, so move it to the arch-specific
info, to reduce the size for other archs.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/m68k/cpu/mcf5445x/cpu.c           | 2 +-
 arch/m68k/include/asm/global_data.h    | 2 ++
 arch/m68k/lib/bdinfo.c                 | 2 +-
 arch/powerpc/cpu/mpc83xx/pci.c         | 4 ++--
 arch/powerpc/cpu/mpc83xx/speed.c       | 2 +-
 arch/powerpc/include/asm/global_data.h | 2 ++
 drivers/clk/mpc83xx_clk.c              | 2 +-
 include/asm-generic/global_data.h      | 5 -----
 8 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/arch/m68k/cpu/mcf5445x/cpu.c b/arch/m68k/cpu/mcf5445x/cpu.c
index b811ac355e4..3fbd6a58c7d 100644
--- a/arch/m68k/cpu/mcf5445x/cpu.c
+++ b/arch/m68k/cpu/mcf5445x/cpu.c
@@ -92,7 +92,7 @@ int print_cpuinfo(void)
 		       strmhz(buf3, gd->arch.flb_clk));
 #ifdef CONFIG_PCI
 		printf("       PCI CLK %s MHz INP CLK %s MHz VCO CLK %s MHz\n",
-		       strmhz(buf1, gd->pci_clk),
+		       strmhz(buf1, gd->arch.pci_clk),
 		       strmhz(buf2, gd->arch.inp_clk),
 		       strmhz(buf3, gd->arch.vco_clk));
 #else
diff --git a/arch/m68k/include/asm/global_data.h b/arch/m68k/include/asm/global_data.h
index 93efc722ba8..4ac886933c6 100644
--- a/arch/m68k/include/asm/global_data.h
+++ b/arch/m68k/include/asm/global_data.h
@@ -26,6 +26,8 @@ struct arch_global_data {
 #if defined(CONFIG_FSL_ESDHC)
 	unsigned long sdhc_per_clk;
 #endif
+	/** @pci_clk: PCI clock rate in Hz */
+	unsigned long pci_clk;
 };
 
 #include <asm-generic/global_data.h>
diff --git a/arch/m68k/lib/bdinfo.c b/arch/m68k/lib/bdinfo.c
index cf6ae5adddf..891e94bbd3f 100644
--- a/arch/m68k/lib/bdinfo.c
+++ b/arch/m68k/lib/bdinfo.c
@@ -22,7 +22,7 @@ int arch_setup_bdinfo(void)
 	bd->bi_busfreq = gd->bus_clk;	/* Bus Freq,      in Hz */
 
 	if (IS_ENABLED(CONFIG_PCI))
-		bd->bi_pcifreq = gd->pci_clk;
+		bd->bi_pcifreq = gd->arch.pci_clk;
 
 #if defined(CONFIG_EXTRA_CLOCK)
 	bd->bi_inpfreq = gd->arch.inp_clk;	/* input Freq in Hz */
diff --git a/arch/powerpc/cpu/mpc83xx/pci.c b/arch/powerpc/cpu/mpc83xx/pci.c
index 6f378c4e221..aef1123a2b7 100644
--- a/arch/powerpc/cpu/mpc83xx/pci.c
+++ b/arch/powerpc/cpu/mpc83xx/pci.c
@@ -45,7 +45,7 @@ void ft_pci_setup(void *blob, struct bd_info *bd)
 			do_fixup_by_path(blob, path, "bus-range",
 				&tmp, sizeof(tmp), 1);
 
-			tmp[0] = cpu_to_be32(gd->pci_clk);
+			tmp[0] = cpu_to_be32(gd->arch.pci_clk);
 			do_fixup_by_path(blob, path, "clock-frequency",
 				&tmp, sizeof(tmp[0]), 1);
 		}
@@ -60,7 +60,7 @@ void ft_pci_setup(void *blob, struct bd_info *bd)
 			do_fixup_by_path(blob, path, "bus-range",
 				&tmp, sizeof(tmp), 1);
 
-			tmp[0] = cpu_to_be32(gd->pci_clk);
+			tmp[0] = cpu_to_be32(gd->arch.pci_clk);
 			do_fixup_by_path(blob, path, "clock-frequency",
 				&tmp, sizeof(tmp[0]), 1);
 		}
diff --git a/arch/powerpc/cpu/mpc83xx/speed.c b/arch/powerpc/cpu/mpc83xx/speed.c
index 72464962613..0185ab50ad9 100644
--- a/arch/powerpc/cpu/mpc83xx/speed.c
+++ b/arch/powerpc/cpu/mpc83xx/speed.c
@@ -456,7 +456,7 @@ int get_clocks(void)
 #if defined(CONFIG_ARCH_MPC837X)
 	gd->arch.sata_clk = sata_clk;
 #endif
-	gd->pci_clk = pci_sync_in;
+	gd->arch.pci_clk = pci_sync_in;
 	gd->cpu_clk = gd->arch.core_clk;
 	gd->bus_clk = gd->arch.csb_clk;
 	return 0;
diff --git a/arch/powerpc/include/asm/global_data.h b/arch/powerpc/include/asm/global_data.h
index a9efbbdd3d4..cc2ce617350 100644
--- a/arch/powerpc/include/asm/global_data.h
+++ b/arch/powerpc/include/asm/global_data.h
@@ -87,6 +87,8 @@ struct arch_global_data {
 #if defined(CONFIG_LWMON5)
 	unsigned long kbd_status;
 #endif
+	/** @pci_clk: PCI clock rate in Hz */
+	unsigned long pci_clk;
 };
 
 #include <asm-generic/global_data.h>
diff --git a/drivers/clk/mpc83xx_clk.c b/drivers/clk/mpc83xx_clk.c
index a29ad0d7a68..a43fff2e7ed 100644
--- a/drivers/clk/mpc83xx_clk.c
+++ b/drivers/clk/mpc83xx_clk.c
@@ -358,7 +358,7 @@ static int mpc83xx_clk_probe(struct udevice *dev)
 	gd->mem_clk = priv->speed[MPC83XX_CLK_MEM];
 
 	if (mpc83xx_has_pci(type))
-		gd->pci_clk = priv->speed[MPC83XX_CLK_PCI];
+		gd->arch.pci_clk = priv->speed[MPC83XX_CLK_PCI];
 
 	gd->cpu_clk = priv->speed[MPC83XX_CLK_CORE];
 	gd->bus_clk = priv->speed[MPC83XX_CLK_CSB];
diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
index 19c66e1fe5d..79d2aa4c6f5 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -60,11 +60,6 @@ struct global_data {
 	 * @bus_clk: platform clock rate in Hz
 	 */
 	unsigned long bus_clk;
-	/**
-	 * @pci_clk: PCI clock rate in Hz
-	 */
-	/* We cannot bracket this with CONFIG_PCI due to mpc5xxx */
-	unsigned long pci_clk;
 	/**
 	 * @mem_clk: memory clock rate in Hz
 	 */
-- 
2.34.1

