Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52111D3C93E
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 04:42:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57ED7892DA;
	Mon, 21 Oct 2024 06:41:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="mmqdd28K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE6C0892C7; Mon, 21 Oct 2024 06:41:28 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA428891FE
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 06:41:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-k6@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49L4fOB2011044;
 Sun, 20 Oct 2024 23:41:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1729485684;
 bh=EEaics+5Rvlw365VvmhwT5iSDLDuw4Hq50aVKkd8/NU=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=mmqdd28KJMgndk3DLe5hr9fgmTtftHcHemINgEhFoWqdxEhhna0fUJNWfU620sGNk
 lIw9KInsbAMPD/W9DRdLje79z5AuLN1rq1Bvo27w+dJI13GQpLOaMIupoYCsdTzeg2
 h7p5Y7HsxNdEi6W1XFUzVoIgUgzmOVjmVfRTqNys=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49L4fOv7121101
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sun, 20 Oct 2024 23:41:24 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 20
 Oct 2024 23:41:23 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 20 Oct 2024 23:41:23 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com
 [172.24.227.241])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49L4f2tx059251;
 Sun, 20 Oct 2024 23:41:21 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <trini@konsulko.com>, <m-chawdhry@ti.com>, <nm@ti.com>, <u-kumar1@ti.com>, 
 <vigneshr@ti.com>, <bb@ti.com>
CC: <u-boot@lists.denx.de>, <w.egorov@phytec.de>, <n-francis@ti.com>,
 <s-k6@ti.com>
Subject: [PATCH v4 6/8] configs: j7*_evm_r5_defconfig: Set NR_DRAM_BANKS to 2
Date: Mon, 21 Oct 2024 10:10:22 +0530
Message-ID: <20241021044024.835846-7-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241021044024.835846-1-s-k6@ti.com>
References: <20241021044024.835846-1-s-k6@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

From: Neha Malcom Francis <n-francis@ti.com>

Set CONFIG_NR_DRAM_BANKS to 2 as we have two banks described in the
memory/ node for lower and higher addressible DDR regions.

This allows use of FDT functions from fdt_support.c to set up and fixup
the memory/ node correctly.

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
 configs/j7200_evm_r5_defconfig  | 1 +
 configs/j721e_evm_r5_defconfig  | 1 +
 configs/j721s2_evm_r5_defconfig | 1 +
 configs/j784s4_evm_r5_defconfig | 1 +
 4 files changed, 4 insertions(+)

diff --git a/configs/j7200_evm_r5_defconfig b/configs/j7200_evm_r5_defconfig
index 774a9eff439d..78dbd44f845f 100644
--- a/configs/j7200_evm_r5_defconfig
+++ b/configs/j7200_evm_r5_defconfig
@@ -5,6 +5,7 @@ CONFIG_SYS_MALLOC_F_LEN=0x70000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_NR_DRAM_BANKS=2
 CONFIG_SOC_K3_J721E=y
 CONFIG_K3_EARLY_CONS=y
 CONFIG_TARGET_J7200_R5_EVM=y
diff --git a/configs/j721e_evm_r5_defconfig b/configs/j721e_evm_r5_defconfig
index 3b4a7c3c0eeb..dc391f14b193 100644
--- a/configs/j721e_evm_r5_defconfig
+++ b/configs/j721e_evm_r5_defconfig
@@ -5,6 +5,7 @@ CONFIG_SYS_MALLOC_F_LEN=0x70000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_NR_DRAM_BANKS=2
 CONFIG_SOC_K3_J721E=y
 CONFIG_K3_EARLY_CONS=y
 CONFIG_K3_QOS=y
diff --git a/configs/j721s2_evm_r5_defconfig b/configs/j721s2_evm_r5_defconfig
index b6adb6a77d7e..374bc283be2d 100644
--- a/configs/j721s2_evm_r5_defconfig
+++ b/configs/j721s2_evm_r5_defconfig
@@ -5,6 +5,7 @@ CONFIG_SYS_MALLOC_F_LEN=0x10000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_NR_DRAM_BANKS=2
 CONFIG_SOC_K3_J721S2=y
 CONFIG_K3_EARLY_CONS=y
 CONFIG_K3_QOS=y
diff --git a/configs/j784s4_evm_r5_defconfig b/configs/j784s4_evm_r5_defconfig
index a11688194977..6fe36ab38f02 100644
--- a/configs/j784s4_evm_r5_defconfig
+++ b/configs/j784s4_evm_r5_defconfig
@@ -5,6 +5,7 @@ CONFIG_SYS_MALLOC_F_LEN=0x10000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_NR_DRAM_BANKS=2
 CONFIG_SOC_K3_J784S4=y
 CONFIG_K3_EARLY_CONS=y
 CONFIG_K3_QOS=y
-- 
2.34.1

