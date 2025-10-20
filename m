Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 512DBCCD193
	for <u-boot@archiver.kernel.org>; Mon, 20 Oct 2025 08:23:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1FB782C84;
	Mon, 20 Oct 2025 10:23:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eTWDOrLX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BAB6807C0; Mon, 20 Oct 2025 10:23:23 +0200 (CEST)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D15D282C84
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 10:23:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-33badfbbc48so5231704a91.2
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 01:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760948599; x=1761553399; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=t7EOaucezWRu7mlWTsHGAZihEplkSAz26bXX96QKz0w=;
 b=eTWDOrLX8Dkv8uLLUeY2v3iSiWlkEDuShX0D2P2KWyEGopzjmaLK8Cg2Qc9ELg7OJy
 THgRuLt2Bd8gaNb8EssyDF17NjcAa5HLFO8Xqm5yu6PnddkQMCDDcPRrYzU3iJFQD1xB
 GrDhJFMwW8xdC/r1vvayDhpQIr1b0lbn2GsGUrBM+52hHwj3Q3WUyDSVvQuqe+YEPxhL
 9s/eZ+aHXL0Mw273S4OnIT2npXr03lNgM2hdeFRgwZ2wNsEu6h9ajKHfxk1PP8gcuDno
 DQ3+y4M4+SIMcquNpBAeQReV0Pzls5rkLjQze1qAcmbhkhiJCOCjHs2Srg8UBV7FzyiJ
 E0AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760948599; x=1761553399;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t7EOaucezWRu7mlWTsHGAZihEplkSAz26bXX96QKz0w=;
 b=F6s3y99IE82Weij0VOWTUUkpYpFaj4uA5MA4cdCaCTCeN2e//KTOSV6xT0CHerD3FY
 mWstlbEOC1E+ib7LfKSUlOXOL3o2cIIXrsb7CmaMCp1ztH1CFwra0M1tk8w2v3BIwTWX
 KZEZMVaKNN/Py5Yi8/UQxHuvPSV78MiZbkc3wQF8ahVkRRdkzPOxGRuBUo5MrbUahbkC
 lUzxPzzRCANbB3VIO7mRwTZfa+59fGXqdqLRNdVN6X9or8hXUydMvvNYZ2B2z/OJlx7I
 fliPxJ/9oM+4cijfaCMz0XB7+3vUg0mZ/X/hzkgl4yE/EytpkyTTtlQbWfA7pNvMHdVR
 KHtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhtyEPnxTrtGGYdydZzBmbraS8kTGNMGjUb8TfoxehOqlqmgSOHOqS/qz7Krz+LZNTmYX+Fl0=@lists.denx.de
X-Gm-Message-State: AOJu0YzrJsTPQ0A05f4ruPyvBcmRm6tcVH1Ap+YdBS0FikOxLdf+D0pV
 R+mrw+jzJr3z4qvelBmEi0P1v2uotbe+q9Yxfub7k0tq3/oFFW8zsEPImnms8t3v
X-Gm-Gg: ASbGncuxTa8x2ByYbk5WwJb6eYZ5MOgTbrl5GCxnDhulEENQhgGzBUVsUKmiwy48Mkr
 v8SomIlsQ6L2/G4XTJz5siKc576nAN3c1lFtORAg2fISJEZ2XMk29buLY9h/mzN5sVZOTKbboEv
 D1yfMk/c0a3JZuNkRSDJm6F+lYiaABkxTV/n5U3+Lv0e0485+6tk2gnXVXi0Zfq8QopREghUXKP
 9TqpEUZtIiTJeelsrSG4w8TblMn4o1x+4ZLdV49MaUw9KBIVjAx2TQ5jBzhbo1U0cAIA4rTlr50
 CryIz6A/laSu62FyGD9OmKZtvMrOeNvuZbfdCcRCUavsyVAZ50X9EYGdT2DwyZCO6HUHAdGWsKL
 tPSsiGpjvQSjbmSLftDcOxXVHAf3iXHYoqUdD0BIgh1Y9vPGnrZ9d67kBUvUpTp8ix/gmLsOIuZ
 QA08VaOU7l6VArycKlBYkQEEyZjE9X15pXlrJd
X-Google-Smtp-Source: AGHT+IHclxZ2POYU5l5unrt+Z9+RnPi0yxnCkfsh0kDbnAGvOMwDoqWDrCJp6TYijnxwsn1mKL+3gA==
X-Received: by 2002:a17:90a:ec8b:b0:339:d03e:2a11 with SMTP id
 98e67ed59e1d1-33bcf88b534mr15938603a91.14.1760948599258; 
 Mon, 20 Oct 2025 01:23:19 -0700 (PDT)
Received: from localhost.localdomain ([185.213.82.51])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33d5de0df14sm7453034a91.10.2025.10.20.01.23.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Oct 2025 01:23:19 -0700 (PDT)
From: Brian Sune <briansune@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Subject: [PATCH] FPGA2SDRAM setup fix
Date: Mon, 20 Oct 2025 16:23:04 +0800
Message-ID: <20251020082304.1778-1-briansune@gmail.com>
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

Signed-off-by: intel <intel@intel.com>
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

