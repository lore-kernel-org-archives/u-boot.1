Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C5261112242
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 23:25:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEAD184129;
	Thu,  2 Apr 2026 01:24:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="GhvQmQxF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7728184099; Wed,  1 Apr 2026 23:02:50 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D45D884056
 for <u-boot@lists.denx.de>; Wed,  1 Apr 2026 23:02:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 2CD06112C9C; Wed,  1 Apr 2026 23:02:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1775077367; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=TB8AmE8toKxrGIMdHx7s2GCUE9CId6Ue08zeAn4FQ9I=;
 b=GhvQmQxFuXdUEyBntHsTAaFGDvkqreIpXvChumRB5qkVmah839ER7llwT9b4esEvG2ija4
 /LyoiivwS0niQtQQOOPQJN6zZqaHLbOt3Yz+henSMdNdiNdBwyXxB4dkgEUhi1S1OW7UUL
 7hpolnLVDMqw1B/UNK+apCPCCReeFNXVh+B8p3Sun7wqHI0jysFKmoA/FwBQrdhBxhitr9
 h8Ick9u9qZYURRxNDC1clnZlcp+c/9Pz1tLcRWGIqNptqBlIndf4Sx0Fg6td+oI1waswui
 tJCym7a5ECzRH4GHVBEzM41wZ6E/daJ0R9wWpjFF8T4Xhmcn7IHP1NDWxtDMfA==
From: Marek Vasut <marex@nabladev.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 u-boot@dh-electronics.com
Subject: [PATCH 4/4] arm64: imx8mp: Add 4G 1r DRAM timings on DH i.MX8MP DHCOM
 SoM
Date: Wed,  1 Apr 2026 23:02:20 +0200
Message-ID: <20260401210238.60010-4-marex@nabladev.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260401210238.60010-1-marex@nabladev.com>
References: <20260401210238.60010-1-marex@nabladev.com>
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

Introduce timing patch which converts 2 GiB DRAM timings to 4 GiB 1-rank
timings. This is a new configuration which carries IS43LQ32K01B DRAM part.
The 512 MiB SoM strapping that was never used is repurposed for this part.

Signed-off-by: Marek Vasut <marex@nabladev.com>
---
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@dh-electronics.com
Cc: u-boot@lists.denx.de
---
 board/dhelectronics/dh_imx8mp/lpddr4_timing.h |   3 +-
 .../dh_imx8mp/lpddr4_timing_2G_32.c           | 138 ++++++++++++++++++
 board/dhelectronics/dh_imx8mp/spl.c           |   4 +-
 3 files changed, 142 insertions(+), 3 deletions(-)

diff --git a/board/dhelectronics/dh_imx8mp/lpddr4_timing.h b/board/dhelectronics/dh_imx8mp/lpddr4_timing.h
index ef899dc0678..5dc841a7f5a 100644
--- a/board/dhelectronics/dh_imx8mp/lpddr4_timing.h
+++ b/board/dhelectronics/dh_imx8mp/lpddr4_timing.h
@@ -7,7 +7,7 @@
 #define __LPDDR4_TIMING_H__
 
 static const u16 dh_imx8mp_dhcom_dram_size[] = {
-	512, 1024, 1536, 2048, 3072, 4096, 6144, 8192
+	4096, 1024, 1536, 2048, 3072, 4096, 6144, 8192
 };
 
 extern struct dram_timing_info dh_imx8mp_dhcom_dram_timing_16g_x32;
@@ -15,6 +15,7 @@ static __maybe_unused struct dram_timing_info *dh_imx8mp_dhcom_dram_timing =
 	&dh_imx8mp_dhcom_dram_timing_16g_x32;
 void dh_imx8mp_dhcom_dram_patch_16g_x32_to_16g_x32(void);
 void dh_imx8mp_dhcom_dram_patch_16g_x32_to_32g_x32_2r(void);
+void dh_imx8mp_dhcom_dram_patch_16g_x32_to_32g_x32_1r(void);
 
 u8 dh_get_memcfg(void);
 
diff --git a/board/dhelectronics/dh_imx8mp/lpddr4_timing_2G_32.c b/board/dhelectronics/dh_imx8mp/lpddr4_timing_2G_32.c
index f93b3082b63..9574e920352 100644
--- a/board/dhelectronics/dh_imx8mp/lpddr4_timing_2G_32.c
+++ b/board/dhelectronics/dh_imx8mp/lpddr4_timing_2G_32.c
@@ -1910,3 +1910,141 @@ void dh_imx8mp_dhcom_dram_patch_16g_x32_to_32g_x32_2r(void)
 			ddr_fsp0_2d_cfg[i].val = 0x3;
 	}
 };
+
+/* Convert 2 GiB DRAM settings to 4 GiB 1-rank DRAM settings. */
+void dh_imx8mp_dhcom_dram_patch_16g_x32_to_32g_x32_1r(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(ddr_ddrc_cfg); i++) {
+		if (ddr_ddrc_cfg[i].reg == 0x3d400064)
+			ddr_ddrc_cfg[i].val = 0x6d0156;
+		if (ddr_ddrc_cfg[i].reg == 0x3d400138)
+			ddr_ddrc_cfg[i].val = 0x15d;
+#if IS_ENABLED(CONFIG_IMX8M_DRAM_INLINE_ECC)
+		if (ddr_ddrc_cfg[i].reg == 0x3d400200)
+			ddr_ddrc_cfg[i].val = 0x1f;
+		if (ddr_ddrc_cfg[i].reg == 0x3d40020c)
+			ddr_ddrc_cfg[i].val = 0x14141400;
+#else
+		if (ddr_ddrc_cfg[i].reg == 0x3d400200)
+			ddr_ddrc_cfg[i].val = 0x17;
+#endif
+		if (ddr_ddrc_cfg[i].reg == 0x3d40021c)
+			ddr_ddrc_cfg[i].val = 0xf04;
+		if (ddr_ddrc_cfg[i].reg == 0x3d402024)
+			ddr_ddrc_cfg[i].val = 0x61a800;
+		if (ddr_ddrc_cfg[i].reg == 0x3d402064)
+			ddr_ddrc_cfg[i].val = 0x18004c;
+		if (ddr_ddrc_cfg[i].reg == 0x3d4020dc)
+			ddr_ddrc_cfg[i].val = 0x940009;
+		if (ddr_ddrc_cfg[i].reg == 0x3d402100)
+			ddr_ddrc_cfg[i].val = 0xc080609;
+		if (ddr_ddrc_cfg[i].reg == 0x3d402104)
+			ddr_ddrc_cfg[i].val = 0x3040d;
+		if (ddr_ddrc_cfg[i].reg == 0x3d402108)
+			ddr_ddrc_cfg[i].val = 0x3060a0c;
+		if (ddr_ddrc_cfg[i].reg == 0x3d402110)
+			ddr_ddrc_cfg[i].val = 0x4040204;
+		if (ddr_ddrc_cfg[i].reg == 0x3d402114)
+			ddr_ddrc_cfg[i].val = 0x2030303;
+		if (ddr_ddrc_cfg[i].reg == 0x3d402138)
+			ddr_ddrc_cfg[i].val = 0x4e;
+		if (ddr_ddrc_cfg[i].reg == 0x3d402144)
+			ddr_ddrc_cfg[i].val = 0x280014;
+		if (ddr_ddrc_cfg[i].reg == 0x3d402180)
+			ddr_ddrc_cfg[i].val = 0xc80006;
+		if (ddr_ddrc_cfg[i].reg == 0x3d402190)
+			ddr_ddrc_cfg[i].val = 0x3878202;
+		if (ddr_ddrc_cfg[i].reg == 0x3d4021b4)
+			ddr_ddrc_cfg[i].val = 0x702;
+		if (ddr_ddrc_cfg[i].reg == 0x3d403024)
+			ddr_ddrc_cfg[i].val = 0x493fe1;
+		if (ddr_ddrc_cfg[i].reg == 0x3d403064)
+			ddr_ddrc_cfg[i].val = 0x12003a;
+		if (ddr_ddrc_cfg[i].reg == 0x3d403100)
+			ddr_ddrc_cfg[i].val = 0xa070507;
+		if (ddr_ddrc_cfg[i].reg == 0x3d403104)
+			ddr_ddrc_cfg[i].val = 0x3040a;
+		if (ddr_ddrc_cfg[i].reg == 0x3d403108)
+			ddr_ddrc_cfg[i].val = 0x203070b;
+		if (ddr_ddrc_cfg[i].reg == 0x3d403110)
+			ddr_ddrc_cfg[i].val = 0x3040203;
+		if (ddr_ddrc_cfg[i].reg == 0x3d403114)
+			ddr_ddrc_cfg[i].val = 0x2030303;
+		if (ddr_ddrc_cfg[i].reg == 0x3d403138)
+			ddr_ddrc_cfg[i].val = 0x3b;
+		if (ddr_ddrc_cfg[i].reg == 0x3d403144)
+			ddr_ddrc_cfg[i].val = 0x1f0010;
+		if (ddr_ddrc_cfg[i].reg == 0x3d403180)
+			ddr_ddrc_cfg[i].val = 0x970005;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(ddr_ddrphy_cfg); i++) {
+		if (ddr_ddrphy_cfg[i].reg == 0x12002e)
+			ddr_ddrphy_cfg[i].val = 0x1;
+		if (ddr_ddrphy_cfg[i].reg == 0x22002e)
+			ddr_ddrphy_cfg[i].val = 0x1;
+		if (ddr_ddrphy_cfg[i].reg == 0x120008)
+			ddr_ddrphy_cfg[i].val = 0xc8;
+		if (ddr_ddrphy_cfg[i].reg == 0x220008)
+			ddr_ddrphy_cfg[i].val = 0x96;
+		if (ddr_ddrphy_cfg[i].reg == 0x200f0)
+			ddr_ddrphy_cfg[i].val = 0x500;
+		if (ddr_ddrphy_cfg[i].reg == 0x200f4)
+			ddr_ddrphy_cfg[i].val = 0x5555;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(ddr_fsp1_cfg); i++) {
+		if (ddr_fsp1_cfg[i].reg == 0x54002)
+			ddr_fsp1_cfg[i].val = 0x1;
+		if (ddr_fsp1_cfg[i].reg == 0x54003)
+			ddr_fsp1_cfg[i].val = 0x320;
+		if (ddr_fsp1_cfg[i].reg == 0x54019)
+			ddr_fsp1_cfg[i].val = 0x994;
+		if (ddr_fsp1_cfg[i].reg == 0x5401f)
+			ddr_fsp1_cfg[i].val = 0x994;
+		if (ddr_fsp1_cfg[i].reg == 0x54032)
+			ddr_fsp1_cfg[i].val = 0x9400;
+		if (ddr_fsp1_cfg[i].reg == 0x54033)
+			ddr_fsp1_cfg[i].val = 0xf309;
+		if (ddr_fsp1_cfg[i].reg == 0x54038)
+			ddr_fsp1_cfg[i].val = 0x9400;
+		if (ddr_fsp1_cfg[i].reg == 0x54039)
+			ddr_fsp1_cfg[i].val = 0xf309;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(ddr_fsp2_cfg); i++) {
+		if (ddr_fsp2_cfg[i].reg == 0x54002)
+			ddr_fsp2_cfg[i].val = 0x2;
+		if (ddr_fsp2_cfg[i].reg == 0x54003)
+			ddr_fsp2_cfg[i].val = 0x258;
+		if (ddr_fsp2_cfg[i].reg == 0x54019)
+			ddr_fsp2_cfg[i].val = 0x994;
+		if (ddr_fsp2_cfg[i].reg == 0x5401f)
+			ddr_fsp2_cfg[i].val = 0x994;
+		if (ddr_fsp2_cfg[i].reg == 0x54032)
+			ddr_fsp2_cfg[i].val = 0x9400;
+		if (ddr_fsp2_cfg[i].reg == 0x54033)
+			ddr_fsp2_cfg[i].val = 0xf309;
+		if (ddr_fsp2_cfg[i].reg == 0x54038)
+			ddr_fsp2_cfg[i].val = 0x9400;
+		if (ddr_fsp2_cfg[i].reg == 0x54039)
+			ddr_fsp2_cfg[i].val = 0xf309;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(ddr_phy_pie); i++) {
+		if (ddr_phy_pie[i].reg == 0x12000b)
+			ddr_phy_pie[i].val = 0xe1;
+		if (ddr_phy_pie[i].reg == 0x12000c)
+			ddr_phy_pie[i].val = 0x32;
+		if (ddr_phy_pie[i].reg == 0x12000d)
+			ddr_phy_pie[i].val = 0x1f4;
+		if (ddr_phy_pie[i].reg == 0x22000b)
+			ddr_phy_pie[i].val = 0xa8;
+		if (ddr_phy_pie[i].reg == 0x22000c)
+			ddr_phy_pie[i].val = 0x25;
+		if (ddr_phy_pie[i].reg == 0x22000d)
+			ddr_phy_pie[i].val = 0x177;
+	}
+};
diff --git a/board/dhelectronics/dh_imx8mp/spl.c b/board/dhelectronics/dh_imx8mp/spl.c
index 8b9dddab79a..aab8550023e 100644
--- a/board/dhelectronics/dh_imx8mp/spl.c
+++ b/board/dhelectronics/dh_imx8mp/spl.c
@@ -107,7 +107,7 @@ static int dh_imx8mp_board_power_init(void)
 typedef void (*patch_func_t)(void);
 
 static const patch_func_t dram_patch_fn[8] = {
-	NULL,							/* 512 MiB */
+	dh_imx8mp_dhcom_dram_patch_16g_x32_to_32g_x32_1r,	/* 4096 MiB 1-rank */
 	NULL,							/* 1024 MiB */
 	NULL,							/* 1536 MiB */
 	dh_imx8mp_dhcom_dram_patch_16g_x32_to_16g_x32,		/* 2048 MiB */
@@ -168,7 +168,7 @@ static void dh_imx8mp_dhcom_dram_scrub_32g_x32(void)
 typedef void (*scrub_func_t)(void);
 
 static const scrub_func_t dram_scrub_fn[8] = {
-	NULL,					/* 512 MiB */
+	dh_imx8mp_dhcom_dram_scrub_32g_x32,	/* 4096 MiB 1-rank */
 	NULL,					/* 1024 MiB */
 	NULL,					/* 1536 MiB */
 	dh_imx8mp_dhcom_dram_scrub_16g_x32,	/* 2048 MiB */
-- 
2.53.0

