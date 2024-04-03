Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA711CD1288
	for <u-boot@archiver.kernel.org>; Wed,  3 Apr 2024 13:59:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FBE588388;
	Wed,  3 Apr 2024 15:59:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="SqZhApjp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5449881BE; Wed,  3 Apr 2024 15:59:21 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9858D88242
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 15:59:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1712152759; x=1714744759;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GdbrgGR4HorbZNMYDX6T7XK/xdYrAbVHkpgeSJSJeec=;
 b=SqZhApjpYYMC3/Renq5O6Jz4urXpklgDtSx/M1x6UunKG/Uv41ZBNLZrzCAmzY5D
 bt9FDfkA/QxKw0G5tyB3vFbF2fFCunNprEmgWkUXfkjwhXMw73RqPF6kszVMc/xk
 MXOMPqopiXse6jA/tSeaVVAkCJ6QrKKFFDnsvtcrifY=;
X-AuditID: ac14000a-fbefe7000000290d-ff-660d60b7e50a
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 4C.D4.10509.7B06D066;
 Wed,  3 Apr 2024 15:59:19 +0200 (CEST)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 3 Apr 2024
 15:59:19 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>
CC: <nm@ti.com>, <upstream@lists.phytec.de>, <bb@ti.com>, <vigneshr@ti.com>
Subject: [PATCH v2 1/3] arm: mach-k3: am625: copy bootindex to OCRAM for main
 domain SPL
Date: Wed, 3 Apr 2024 15:59:09 +0200
Message-ID: <20240403135911.1987293-2-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240403135911.1987293-1-w.egorov@phytec.de>
References: <20240403135911.1987293-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDLMWRmVeSWpSXmKPExsWyRpKBR3d7Am+awaLLohZz3xxgtXjz4yyT
 xdu9newW3e/ULf6f/cDuwOpx9s4ORo/+7hZWj+M3tjMFMEdx2aSk5mSWpRbp2yVwZWy9dIy9
 4DFPxbHjUg2Ml7i6GDk5JARMJBqPbmDqYuTiEBJYwiTxat9BZgjnEaPE5Y4XrCBVbALqEnc2
 fAOzRQSkJF52bgQq4uBgFvCWuDuNDSQsLBAhcWX5fiaQMIuAisSVR+UgYV4BS4lN194wQuyS
 l5h56Ts7iM0pYCVx98IpsIlCQDU3f3cyQtQLSpyc+YQFxGYGqm/eOpsZwpaQOPjiBTNEvbzE
 i0vLWWBmTjv3mhnCDpXY+mU70wRGoVlIRs1CMmoWklELGJlXMQrlZiZnpxZlZusVZFSWpCbr
 paRuYgSFuAgD1w7GvjkehxiZOBgPMUpwMCuJ8HY78KYJ8aYkVlalFuXHF5XmpBYfYpTmYFES
 513dEZwqJJCeWJKanZpakFoEk2Xi4AQGtrWu3AJT5lK3VkvNnpRPTJOOcwvJKnbmb/aQ2Nn4
 vipoDufB+vKeorgVJ73O51wMDvgquTJadhXXqexr5/Y6ZtYK/+hm3CjRpHA08MzHjtyCB68i
 e/jEXZvkfx291rjiAbtqe7333K0dO37UfVatdZh/8sKza0/SIvdFym/MPneK7+IS3Zv9SizF
 GYmGWsxFxYkAvP7Vt18CAAA=
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

Relocate booindex to OCRAM region after it gets opened by TIFS so
the main domain bootloaders can have access to this data.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
v2:
  - Relocate bootindex to OCRAM, drop misleading comments and remove not needed changes
---
 arch/arm/mach-k3/am625_init.c                 | 8 ++++++++
 arch/arm/mach-k3/include/mach/am62_hardware.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/arch/arm/mach-k3/am625_init.c b/arch/arm/mach-k3/am625_init.c
index 6c96e881146..c9c97b6ce19 100644
--- a/arch/arm/mach-k3/am625_init.c
+++ b/arch/arm/mach-k3/am625_init.c
@@ -175,6 +175,14 @@ void board_init_f(ulong dummy)
 		k3_sysfw_loader(true, NULL, NULL);
 	}
 
+	/*
+	 * Relocate boot information to OCRAM (after TIFS has opend this
+	 * region for us) so the next bootloader stages can keep access to
+	 * primary vs backup bootmodes.
+	 */
+	if (IS_ENABLED(CONFIG_CPU_V7R))
+		writel(bootindex, K3_BOOT_PARAM_TABLE_INDEX_OCRAM);
+
 	/*
 	 * Force probe of clk_k3 driver here to ensure basic default clock
 	 * configuration is always done.
diff --git a/arch/arm/mach-k3/include/mach/am62_hardware.h b/arch/arm/mach-k3/include/mach/am62_hardware.h
index 54380f36e16..30c2f11062c 100644
--- a/arch/arm/mach-k3/include/mach/am62_hardware.h
+++ b/arch/arm/mach-k3/include/mach/am62_hardware.h
@@ -76,6 +76,7 @@
 #define CTRLMMR_MCU_RST_CTRL			(MCU_CTRL_MMR0_BASE + 0x18170)
 
 #define ROM_EXTENDED_BOOT_DATA_INFO		0x43c3f1e0
+#define K3_BOOT_PARAM_TABLE_INDEX_OCRAM		0x7000F290
 
 #define TI_SRAM_SCRATCH_BOARD_EEPROM_START	0x43c30000
 
-- 
2.34.1

