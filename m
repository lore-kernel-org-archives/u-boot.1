Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DED8CCD199
	for <u-boot@archiver.kernel.org>; Mon, 20 Oct 2025 13:15:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B356883741;
	Mon, 20 Oct 2025 15:15:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="miof6QCr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C669807C0; Mon, 20 Oct 2025 15:15:24 +0200 (CEST)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DC8583804
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 15:15:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-793021f348fso3861500b3a.1
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 06:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760966120; x=1761570920; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=gzIcTt4iDMXw7TTXuXkqXur5wFoYvPduhxZcnc0xbwY=;
 b=miof6QCrxMYik95ofYaT91dmwfeC5Y4ypUToyxENPHAfKhyIdRTSN6OfEuhLxgrxAd
 eMFIpu1TtxVYwv1eEtL7Tq2SS+1LgjFzEu/F5MLG2MRU69MK9eA/mcb5kyQQ6HUnXgxj
 sfXSwRTxlIvdMoB0w8ntgRVfCxgKG+fDYKB5H7RMQtr0MbEEadr3+WQRobN8kAosDtSs
 EReXGtJaEj9nFHPqtJHvHfUZXawMPLdMqeCpwpZX28sVG9iUIvQn2s/ZbIA+sbNZgkeN
 GkDY1YgfJMH5hpwv8zEe/FOb2ZwCSA16xVOpn2l2NhcLAgAOBw4LTVd9vv1HQe1eC6B4
 PxnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760966120; x=1761570920;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gzIcTt4iDMXw7TTXuXkqXur5wFoYvPduhxZcnc0xbwY=;
 b=BCip+kkJhJBR44e+84uQnJP/WY/iCi072iueD8ZcxADGWrp8uBLHy1Z4gQH/dExW3+
 Ib/YydgAcxNs2ensG42Cogh7vkk7LrHqdcgK37xFPvSELeEEjYLWSMGRi7OfT/Osl4Uj
 1r4+1KxguOd6LzfTTjYy0wIoJicY16fTqqft7YBFBCFHJQlaHTBjL+w70TcsModqxjYH
 tFa3etEM/PkxUXzFloGV5GdkV/hGh95pih90AY3Pf8TuhLYf0I/qvE4IIOTimvrPPAxh
 v6UiDA+8y0OYmkXXg7ICjTm1EjD2d6TQMSViOHlxmhLBPhfFNLonXABEpf0rlecYFnkM
 06ug==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/VucmjlzuCzU2kYp++8Q6RxqLE4n8kU9p/AFsQSXxvOwsw6pDYBk0AMAg7EPX/OvwlM+WZGI=@lists.denx.de
X-Gm-Message-State: AOJu0YxFoJXnn2TekS9FoGzSnjgquusaZHeXpDyTY705/7H1WrUeUpKV
 RkZZahxl82Uw+cMZYGOLlCvpeNq2EwQOk5CK2aKPwkptifJl2bJ7LYWF
X-Gm-Gg: ASbGncsVBz+Gw4PYtLAjZm/1faGw/gid5jlrZDXfEvjNdlXaCJSRFCHIQG4X8VYiwZw
 4h+WjFFKh/pmx2qgKeaY1Ja/Wa7eeTImHDsXpDd7HyP5b5wNvfl5yYbS2HifNG9Hqs9TCp+z7QJ
 4r0aKdJfiUq0ABgg4jYo2mOqCdBtwTyeX4ovQilGTc33wePHwwdwoT7J4GYMMiZ4YUtOwvnDXha
 OKPPK3Jx6xJ+Bn62V81VyZGtWsJp7VxiGsv7Hp6HM1mo6/N4M83Uad4G/WYFPyQUyJ0uqHBCqIt
 qxBh6mZzEOBMXjFfTE68IMNfFZTvk4gUjEmG5ywSf2sVlXsxhJOR3pu6AoOeWM2qtO35vY9TX/c
 nFuoaatXyvrKEPp6z9UjS4z5j/lIDeHyLgJalZOwqIZLTkHoUrjzGzfB5eyPlyLeualCU/F/R/g
 yCF9+c5VXwdFEPX6SmQNNAqHSa/Q==
X-Google-Smtp-Source: AGHT+IHUvSi8XeAg1+KzxyeDKFyTDauQAZGOAGEEmQpo+rWrKzQC+uX2gPwk7BbOLvEqGeCwGLGLjw==
X-Received: by 2002:a17:902:ef4c:b0:290:7803:9e8 with SMTP id
 d9443c01a7336-290cb659d58mr162428405ad.48.1760966120433; 
 Mon, 20 Oct 2025 06:15:20 -0700 (PDT)
Received: from localhost.localdomain ([185.213.82.51])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-292471d5868sm79575855ad.60.2025.10.20.06.15.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Oct 2025 06:15:20 -0700 (PDT)
From: Brian Sune <briansune@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Subject: [PATCH] FPGA2SDRAM setup fix
Date: Mon, 20 Oct 2025 21:15:04 +0800
Message-ID: <20251020131504.1796-1-briansune@gmail.com>
X-Mailer: git-send-email 2.47.1.windows.1
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

From: intel <intel@intel.com>

After testing, w/o proper setup
the FPGA2SDRAM bridge will not work and stall.
Pulling from official fix and w/o this initialization,
both 2025.07 and 2025.10 also suffer stall on U-Boot
and distro. Any FPGA to HPS-SDRAM action will immediate
stall the CPU. As such, this patch fix the issue.

Signed-off-by: Brian Sune <briansune@gmail.com>
---
 arch/arm/mach-socfpga/misc_gen5.c | 34 ++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-socfpga/misc_gen5.c b/arch/arm/mach-socfpga/misc_gen5.c
index b136691c685..5259ef54d73 100644
--- a/arch/arm/mach-socfpga/misc_gen5.c
+++ b/arch/arm/mach-socfpga/misc_gen5.c
@@ -217,6 +217,34 @@ int arch_early_init_r(void)
 static struct socfpga_sdr_ctrl *sdr_ctrl =
 	(struct socfpga_sdr_ctrl *)SDR_CTRLGRP_ADDRESS;
 
+void socfpga_sdram_apply_static_cfg(void)
+{
+	const u32 applymask = 0x8;
+	u32 val = readl(&sdr_ctrl->static_cfg) | applymask;
+
+	/*
+	 * SDRAM staticcfg register specific:
+	 * When applying the register setting, the CPU must not access
+	 * SDRAM. Luckily for us, we can use i-cache here to help us
+	 * circumvent the SDRAM access issue. The idea is to make sure
+	 * that the code is in one full i-cache line by branching past
+	 * it and back. Once it is in the i-cache, we execute the core
+	 * of the code and apply the register settings.
+	 *
+	 * The code below uses 7 instructions, while the Cortex-A9 has
+	 * 32-byte cachelines, thus the limit is 8 instructions total.
+	 */
+	asm volatile(".align	5			\n"
+		     "		b 2f			\n"
+		     "1: 	str %0,	[%1]		\n"
+		     "		dsb			\n"
+		     "		isb			\n"
+		     "		b 3f			\n"
+		     "2:	b 1b			\n"
+		     "3:	nop			\n"
+		    : : "r"(val), "r"(&sdr_ctrl->static_cfg) : "memory", "cc");
+}
+
 void do_bridge_reset(int enable, unsigned int mask)
 {
 	int i;
@@ -234,7 +262,10 @@ void do_bridge_reset(int enable, unsigned int mask)
 		writel(iswgrp_handoff[2],
 		       socfpga_get_sysmgr_addr() +
 		       SYSMGR_GEN5_FPGAINFGRP_MODULE);
-		writel(iswgrp_handoff[3], &sdr_ctrl->fpgaport_rst);
+		if (iswgrp_handoff[3]) {
+			writel(iswgrp_handoff[3], &sdr_ctrl->fpgaport_rst);
+			socfpga_sdram_apply_static_cfg();
+		}
 		writel(iswgrp_handoff[0],
 		       socfpga_get_rstmgr_addr() + RSTMGR_GEN5_BRGMODRST);
 		writel(iswgrp_handoff[1], &nic301_regs->remap);
@@ -246,6 +277,7 @@ void do_bridge_reset(int enable, unsigned int mask)
 		writel(0, socfpga_get_sysmgr_addr() +
 		       SYSMGR_GEN5_FPGAINFGRP_MODULE);
 		writel(0, &sdr_ctrl->fpgaport_rst);
+		socfpga_sdram_apply_static_cfg();
 		writel(0x7, socfpga_get_rstmgr_addr() + RSTMGR_GEN5_BRGMODRST);
 		writel(1, &nic301_regs->remap);
 	}
-- 
2.25.1

