Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C94C2CD6E74
	for <u-boot@archiver.kernel.org>; Thu,  5 Sep 2024 17:19:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3A3188CC6;
	Thu,  5 Sep 2024 19:18:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="NQMuOeAm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 268F888C1C; Thu,  5 Sep 2024 19:18:51 +0200 (CEST)
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com
 [95.215.58.189])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 399FA88CC1
 for <u-boot@lists.denx.de>; Thu,  5 Sep 2024 19:18:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1725556728;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CMbRrUyLtrUXaHwj1cEsoqC3jP/AwJqKyCm2DlHaFkQ=;
 b=NQMuOeAmLLfzcj3WyTumkvwGXY/zvTC2oiMabCnBlz2P7JDKpcFMRaiTb1UOzSMD8tXmw2
 6UpLLPlY/X+3KyftuchQkGbpfIZ72gkSYdNYxAxyVDrbEEUQFGjIuXlRdN6W11RODIYwPu
 vu7XcmPBd9FfaBYskC1i8+LutLwgj8Q=
From: Sean Anderson <sean.anderson@linux.dev>
To: Michal Simek <michal.simek@xilinx.com>,
	u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Sean Anderson <sean.anderson@linux.dev>,
 Michal Simek <michal.simek@amd.com>
Subject: [PATCH v2 2/2] arm: zynqmp: Enable non-invasive CCI-400 PMU debug
Date: Thu,  5 Sep 2024 13:18:33 -0400
Message-Id: <20240905171833.325548-3-sean.anderson@linux.dev>
In-Reply-To: <20240905171833.325548-1-sean.anderson@linux.dev>
References: <20240905171833.325548-1-sean.anderson@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
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

Set NIDEN, enabling non-invasive debug for the CCI-400 PMU. Otherwise,
the PMU is effectively disabled.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
Reviewed-by: Michal Simek <michal.simek@amd.com>
---

(no changes since v1)

 arch/arm/mach-zynqmp/include/mach/hardware.h | 3 +++
 board/xilinx/zynqmp/zynqmp.c                 | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/arch/arm/mach-zynqmp/include/mach/hardware.h b/arch/arm/mach-zynqmp/include/mach/hardware.h
index f1514d6a869..51eab3509b8 100644
--- a/arch/arm/mach-zynqmp/include/mach/hardware.h
+++ b/arch/arm/mach-zynqmp/include/mach/hardware.h
@@ -128,6 +128,9 @@ struct crfapb_regs {
 
 #define crfapb_base ((struct crfapb_regs *)ZYNQMP_CRF_APB_BASEADDR)
 
+#define ZYNQMP_CCI_REG_CCI_MISC_CTRL	0xFD5E0040
+#define ZYNQMP_CCI_REG_CCI_MISC_CTRL_NIDEN	BIT(1)
+
 #define ZYNQMP_APU_BASEADDR	0xFD5C0000
 
 struct apu_regs {
diff --git a/board/xilinx/zynqmp/zynqmp.c b/board/xilinx/zynqmp/zynqmp.c
index 56e3b36ca99..20a675c010d 100644
--- a/board/xilinx/zynqmp/zynqmp.c
+++ b/board/xilinx/zynqmp/zynqmp.c
@@ -76,6 +76,10 @@ int __maybe_unused psu_uboot_init(void)
 	writel(0x04920492, ZYNQMP_IOU_SECURE_SLCR);
 	writel(0x00920492, ZYNQMP_IOU_SECURE_SLCR + 4);
 
+	/* Enable CCI PMU events */
+	writel(ZYNQMP_CCI_REG_CCI_MISC_CTRL_NIDEN,
+	       ZYNQMP_CCI_REG_CCI_MISC_CTRL);
+
 	/* Delay is required for clocks to be propagated */
 	udelay(1000000);
 	
-- 
2.35.1.1320.gc452695387.dirty

