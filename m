Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2117DC25B10
	for <u-boot@archiver.kernel.org>; Fri, 10 May 2024 08:49:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FA558880C;
	Fri, 10 May 2024 10:48:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="w81wYuUO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33D6188808; Fri, 10 May 2024 10:48:35 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12EA88818B
 for <u-boot@lists.denx.de>; Fri, 10 May 2024 10:48:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-k6@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44A8mVmN022458;
 Fri, 10 May 2024 03:48:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1715330911;
 bh=7ZW6Yn0wO8pP1OgQH+7rSlIFUl+5aXOwgZzMaCcJzoc=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=w81wYuUOg2j+qsDt08Z33XFLnoTmKs7EMDlNZfzJj4GnatJCwoSW4OIwLGWv+uldq
 t4rWRQVw+njXRINhP/Av+vSqMC6uvPKqymyCiNBGnaqqQZhmqJAHINCIwAZp2BMsF/
 IocVfRMr/QlRmlKEFziLXHgrROFoWTcs5X3kDDYM=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44A8mVRQ007207
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 10 May 2024 03:48:31 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 10
 May 2024 03:48:31 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 10 May 2024 03:48:31 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com
 [172.24.227.241])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44A8mA1f107745;
 Fri, 10 May 2024 03:48:28 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <trini@konsulko.com>, <nm@ti.com>, <vigneshr@ti.com>, <bb@ti.com>,
 <u-kumar1@ti.com>, <m-chawdhry@ti.com>
CC: <u-boot@lists.denx.de>, <n-francis@ti.com>, <s-k6@ti.com>
Subject: [PATCH v2 6/8] configs: j7*_evm_r5_defconfig: Set NR_DRAM_BANKS to 2
Date: Fri, 10 May 2024 14:17:05 +0530
Message-ID: <20240510084707.1903133-7-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240510084707.1903133-1-s-k6@ti.com>
References: <20240510084707.1903133-1-s-k6@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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
index e023af24674a..6494136d735a 100644
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
index cea48b26136c..1c575e278c90 100644
--- a/configs/j721e_evm_r5_defconfig
+++ b/configs/j721e_evm_r5_defconfig
@@ -5,6 +5,7 @@ CONFIG_SYS_MALLOC_F_LEN=0x70000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_NR_DRAM_BANKS=2
 CONFIG_SOC_K3_J721E=y
 CONFIG_K3_EARLY_CONS=y
 CONFIG_TARGET_J721E_R5_EVM=y
diff --git a/configs/j721s2_evm_r5_defconfig b/configs/j721s2_evm_r5_defconfig
index 5ef5247a3e00..a6c2d7276e07 100644
--- a/configs/j721s2_evm_r5_defconfig
+++ b/configs/j721s2_evm_r5_defconfig
@@ -5,6 +5,7 @@ CONFIG_SYS_MALLOC_F_LEN=0x10000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_NR_DRAM_BANKS=2
 CONFIG_SOC_K3_J721S2=y
 CONFIG_K3_EARLY_CONS=y
 CONFIG_TARGET_J721S2_R5_EVM=y
diff --git a/configs/j784s4_evm_r5_defconfig b/configs/j784s4_evm_r5_defconfig
index f5fe7432206b..bdb4d10e2f84 100644
--- a/configs/j784s4_evm_r5_defconfig
+++ b/configs/j784s4_evm_r5_defconfig
@@ -4,6 +4,7 @@ CONFIG_SYS_MALLOC_F_LEN=0x10000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_NR_DRAM_BANKS=2
 CONFIG_SOC_K3_J784S4=y
 CONFIG_K3_EARLY_CONS=y
 CONFIG_TARGET_J784S4_R5_EVM=y
-- 
2.34.1

