Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9742C1112241
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 23:24:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BC21839DF;
	Thu,  2 Apr 2026 01:24:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="JxV88rfI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7ECB83D8A; Wed,  1 Apr 2026 21:16:38 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCAA483CE3
 for <u-boot@lists.denx.de>; Wed,  1 Apr 2026 21:16:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 1DD7A112C70; Wed,  1 Apr 2026 21:16:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1775070996; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=oyFogTgRtUvaDDgj6DDgHY1Ox65CuvP8Dusr5r375o0=;
 b=JxV88rfI+k3ZSxxCVptVjXFLaB2RiZ0G1s9FgNU/ESGdFgnNNghYa4xBLU5jFwoJqWxbAO
 q0tS/uTGSFPd39vR5aLP95qMqp9fPyQXGKNCeSw1tZm/mYv5iesvYAoh4ss+YJvm+1Imro
 CsWUWpLNsdV+nM6T06OUgiOxZQTbSgAqe5trPUPOmN9r0SZKqt9OwYzMrixrE99n/zQk4a
 F7hVrxVLmISi+SvZOVHFj0+5LQLx5dXWrbibVWt1tcBsrbrL5CikjX4sWT5AgGdl48jnLn
 P5hiKzGywCaAOF0NsjKmM0ubmBjtylRGBmDN8lpdpDjA/Hivjrq4IrdmnPCQ6A==
From: Marek Vasut <marex@nabladev.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 u-boot@dh-electronics.com
Subject: [PATCH 2/4] arm64: imx8mp: Deduplicate DRAM size tables on DH i.MX8MP
 DHCOM SoM
Date: Wed,  1 Apr 2026 21:15:54 +0200
Message-ID: <20260401191617.20141-2-marex@nabladev.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260401191617.20141-1-marex@nabladev.com>
References: <20260401191617.20141-1-marex@nabladev.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Thu, 02 Apr 2026 01:24:51 +0200
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

The DRAM size tables are shared by SPL and U-Boot proper, deduplicate
those tables into lpddr4_timing.h . No functional change.

Signed-off-by: Marek Vasut <marex@nabladev.com>
---
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@dh-electronics.com
Cc: u-boot@lists.denx.de
---
 board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c | 3 +--
 board/dhelectronics/dh_imx8mp/lpddr4_timing.h     | 4 ++++
 board/dhelectronics/dh_imx8mp/spl.c               | 3 +--
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c b/board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c
index 3fe98d36f5b..3424be10936 100644
--- a/board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c
+++ b/board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c
@@ -28,12 +28,11 @@ int mach_cpu_init(void)
 
 int board_phys_sdram_size(phys_size_t *size)
 {
-	const u16 memsz[] = { 512, 1024, 1536, 2048, 3072, 4096, 6144, 8192 };
 	const u8 ecc = readl(DDRC_ECCCFG0(0)) & DDRC_ECCCFG0_ECC_MODE_MASK;
 	u8 memcfg = dh_get_memcfg();
 
 	/* 896 kiB, i.e. 1 MiB without 12.5% reserved for in-band ECC */
-	*size = (u64)memsz[memcfg] * (SZ_1M - (ecc ? (SZ_1M / 8) : 0));
+	*size = (u64)dh_imx8mp_dhcom_dram_size[memcfg] * (SZ_1M - (ecc ? (SZ_1M / 8) : 0));
 
 	return 0;
 }
diff --git a/board/dhelectronics/dh_imx8mp/lpddr4_timing.h b/board/dhelectronics/dh_imx8mp/lpddr4_timing.h
index f8078051f2f..0f9f47bbe11 100644
--- a/board/dhelectronics/dh_imx8mp/lpddr4_timing.h
+++ b/board/dhelectronics/dh_imx8mp/lpddr4_timing.h
@@ -6,6 +6,10 @@
 #ifndef __LPDDR4_TIMING_H__
 #define __LPDDR4_TIMING_H__
 
+static const u16 dh_imx8mp_dhcom_dram_size[] = {
+	512, 1024, 1536, 2048, 3072, 4096, 6144, 8192
+};
+
 extern struct dram_timing_info dh_imx8mp_dhcom_dram_timing_16g_x32;
 extern struct dram_timing_info dh_imx8mp_dhcom_dram_timing_32g_x32;
 
diff --git a/board/dhelectronics/dh_imx8mp/spl.c b/board/dhelectronics/dh_imx8mp/spl.c
index d8a928639b2..ece790da66a 100644
--- a/board/dhelectronics/dh_imx8mp/spl.c
+++ b/board/dhelectronics/dh_imx8mp/spl.c
@@ -117,11 +117,10 @@ static struct dram_timing_info *dram_timing_info[8] = {
 
 static void spl_dram_init(void)
 {
-	const u16 size[] = { 512, 1024, 1536, 2048, 3072, 4096, 6144, 8192 };
 	u8 memcfg = dh_get_memcfg();
 	int i;
 
-	printf("DDR:   %d MiB [0x%x]\n", size[memcfg], memcfg);
+	printf("DDR:   %d MiB [0x%x]\n", dh_imx8mp_dhcom_dram_size[memcfg], memcfg);
 
 	if (!dram_timing_info[memcfg]) {
 		printf("Unsupported DRAM strapping, trying lowest supported. MEMCFG=0x%x\n",
-- 
2.53.0

