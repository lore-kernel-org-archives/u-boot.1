Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA0BDCCD199
	for <u-boot@archiver.kernel.org>; Mon, 20 Oct 2025 13:36:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 674CD82C84;
	Mon, 20 Oct 2025 15:36:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TcJ++IuO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E7178334F; Mon, 20 Oct 2025 15:36:12 +0200 (CEST)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19981807C0
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 15:36:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-28e7cd6dbc0so54879865ad.0
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 06:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760967368; x=1761572168; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=lcquew1MTekz0f+JyHC96hnkZ0V4MNGvm5RNzku5FN8=;
 b=TcJ++IuOptSPV2oUrto/UPgjZrtnS8Xc9HwvtMlTGR+gLR23ACpVdCkccfhy92J/TE
 ufqtWN+G/heeKcglEoWPKcB7upNNshnYQLWGD0c5g1dYRCzaU/ikGqCqccQA5XtCuTgA
 nRFjoSy6TXy+M5JPsPiwF/V938JDV3ffYv/UA7s8wPgYs8olgxsBKNYcBxU/GCK/0eTR
 mSYhA6o8rh6lG0wa61+HU0GxXDyyWJpSrH6jLt1OzF/T7VG3pfv+Hf1cSEZom8xiv+tC
 SMyJ3r3HYICo5xrtxBoEupWvLJic0linKNTvSKi+kiZ+aPVSKIoUwrk9Xl0L2JPqCO2Q
 4g6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760967368; x=1761572168;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lcquew1MTekz0f+JyHC96hnkZ0V4MNGvm5RNzku5FN8=;
 b=N/ot0GHu5GgWbdeLYngvhhGPxrolPVBoM3LJKmGOCN8fRH1koGub42Ap8mbIdZ+Cpn
 o6tUaYbWhB6/5NoFCKqKXhVMm83rLq/MehgA51cNuVED1lFJIh2Y55SKlZI4kGMwxmWh
 jqW9x4qYf6pjQ8y9G89XJfjYsnt4i2gH85J68nF3LFcTPfPq9d7nDuzs8HBeV1q9HHYG
 trj+CbaXVcde+Pvn30ZQUcw+f0VxKIW++0tWGTrf/rQuoQZ2UivMEHI9R6V+LIvZcGM0
 U8broTBnCnC7swYLduKz/iF2IUtD2ZdmhOKosgcW50KTSLz/HKbfSR5Mg26qUUSRHMfb
 KBcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV059lxmq+qmNiDNt+zeyn5xMn7VFDVsY5F24zrZ8eJX5JD+hFekevKu9cRHwA2QjN2fOwhH4U=@lists.denx.de
X-Gm-Message-State: AOJu0YyJKAbRUO39qfVCPL+wKS/pHrM4FqqQg8VGxgn+sGO/Y5+cXPf8
 e38V1Raxi+mTFV35tnUWBt4Pmuh0f0NBMCfGjsJ44YROkzJzrzZjDSuCzYNSwkRd
X-Gm-Gg: ASbGncvUHR6xBmFCIj9DUgwIxueIDMtVoKWb8NPwjoxDyR475/1VSAGc9wOcQv6TYxT
 o8KmgEp4KORhZXhC0PiH1vyIeoq3oc8xXMvp0xwjO3bP4Zl7sIl1fu8vCOhgKlLmjRTJnpqSD8y
 ka4X0psw1zNkoTYj/O5rEWQ8GzYilxcH4iJGoIhW3MRlinyxh2jgUbGP/KybM1bR0mWpc8AD+cG
 xigyGttTIWNNaU01m1uzDgxhYkhq77OWPZczPNsC5B/i3tbi00G3grvUUO3V3PZUG9ibmEVvW94
 6f9KYiW2i/y9AYlQ0ItBH7WqysNgD42MA1K2jMw48q5jyZ6t3ivhH1CETosLCDeiNEcL8BabgxS
 B5ju4yPsAVwg3TS+rUxhviWv3KOL5uA4EeEoEZ2kECQFh3YWWzxDH81SbFPLsD46LbeLPt6lj3l
 Xer3XC2a+9JxiM2w6XMY9EhPKXf1OMIKIKvR80
X-Google-Smtp-Source: AGHT+IEc8NJbTVBmGhgZJZpCOT3DT7ijRbi52ya0RVhS0nu7c3JRDAzDNdqMLr/hZ9CmdIIXlK/Maw==
X-Received: by 2002:a17:903:350d:b0:28b:4ca5:d522 with SMTP id
 d9443c01a7336-290cb94765fmr188413185ad.39.1760967368261; 
 Mon, 20 Oct 2025 06:36:08 -0700 (PDT)
Received: from localhost.localdomain ([185.213.82.51])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b6a76b671fcsm7579416a12.35.2025.10.20.06.36.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Oct 2025 06:36:08 -0700 (PDT)
From: Brian Sune <briansune@gmail.com>
To: Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Subject: [PATCH] FPGA2SDRAM setup fix
Date: Mon, 20 Oct 2025 21:35:54 +0800
Message-ID: <20251020133554.1901-1-briansune@gmail.com>
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

