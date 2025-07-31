Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C455CC83F17
	for <u-boot@archiver.kernel.org>; Thu, 31 Jul 2025 08:19:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BC4883423;
	Thu, 31 Jul 2025 10:19:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="CPSE9iNq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47BDA83438; Thu, 31 Jul 2025 10:01:56 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D40FD833ED
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 10:01:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56V81jPL2955323;
 Thu, 31 Jul 2025 03:01:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1753948905;
 bh=HJWjIYFuo7mNakh/N9UxvKMxRVFg1vC0cr9NATyuX/4=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=CPSE9iNqtpRt0qaSf14EyI6mvAnB0bbG8D8M8sgQN+8dEpCl4EmLHdSFdKSCBWXIr
 RoqnK+jgqz/E/0qE7g+hCQ4DqV1suQTO398JbLIhFilJyOGfvqdya4bRZfOXkZ4x2e
 buk+umtdnEpSuo+VCU9FXJvag/ENAA+k3Wyi26j0=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56V81jqG2549216
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 31 Jul 2025 03:01:45 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 31
 Jul 2025 03:01:44 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 31 Jul 2025 03:01:44 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.231.164])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56V80ZSW2573540;
 Thu, 31 Jul 2025 03:00:36 -0500
From: Chintan Vankar <c-vankar@ti.com>
To: Richard Genoud <richard.genoud@bootlin.com>, Sam Protsenko
 <semen.protsenko@linaro.org>, Santhosh Kumar K <s-k6@ti.com>, "Jonathan
 Humphreys" <j-humphreys@ti.com>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bhavya Kapoor <b-kapoor@ti.com>,
 Parth Pancholi <parth.pancholi@toradex.com>,
 Andreas Dannenberg <dannenberg@ti.com>, Moteen Shah <m-shah@ti.com>,
 "Beleswar Padhi" <b-padhi@ti.com>, Anshul Dalal <anshuld@ti.com>, Sughosh
 Ganu <sughosh.ganu@linaro.org>, Neha Malcom Francis <n-francis@ti.com>,
 "Prasanth Babu Mantena" <p-mantena@ti.com>, Wadim Egorov
 <w.egorov@phytec.de>, "Simon Glass" <sjg@chromium.org>, Alexander Sverdlin
 <alexander.sverdlin@siemens.com>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Kishon Vijay Abraham I <kishon@ti.com>,
 Chintan Vankar <c-vankar@ti.com>, Ramon Fried <rfried.dev@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Jayesh Choudhary <j-choudhary@ti.com>,
 Vaishnav Achath <vaishnav.a@ti.com>, Bryan Brattlof <bb@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>
Subject: [PATCH v4 16/21] configs: j722s_evm_r5_ethboot: Add configs to enable
 Ethernet boot in R5SPL
Date: Thu, 31 Jul 2025 13:29:51 +0530
Message-ID: <20250731075956.605474-17-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250731075956.605474-1-c-vankar@ti.com>
References: <20250731075956.605474-1-c-vankar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-Mailman-Approved-At: Thu, 31 Jul 2025 10:19:27 +0200
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

Add configs to enable Ethernet boot in R5SPL, also disable not required
configs to avoid memory limitation.

Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---

Link to v3:
https://lore.kernel.org/u-boot/20250225114903.2080616-15-c-vankar@ti.com/

Changes from v3 to v4:
- No changes.

 configs/j722s_evm_r5_ethboot_defconfig | 30 ++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 configs/j722s_evm_r5_ethboot_defconfig

diff --git a/configs/j722s_evm_r5_ethboot_defconfig b/configs/j722s_evm_r5_ethboot_defconfig
new file mode 100644
index 00000000000..fd58485bff2
--- /dev/null
+++ b/configs/j722s_evm_r5_ethboot_defconfig
@@ -0,0 +1,30 @@
+#include<configs/j722s_evm_r5_defconfig>
+
+CONFIG_ARM=y
+CONFIG_ARCH_K3=y
+CONFIG_SOC_K3_J722S=y
+CONFIG_TARGET_J722S_R5_EVM=y
+CONFIG_DEFAULT_DEVICE_TREE="k3-j722s-r5-evm"
+CONFIG_NET=y
+CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_BOARD_INIT=y
+CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x200000
+CONFIG_SPL_DMA=y
+CONFIG_SPL_ENV_SUPPORT=y
+CONFIG_SPL_ETH=y
+CONFIG_SPL_I2C=y
+CONFIG_SPL_NET=y
+CONFIG_SPL_NET_VCI_STRING="J722S U-Boot R5 SPL"
+CONFIG_TI_K3_NAVSS_UDMA=y
+CONFIG_TI_AM65_CPSW_NUSS=y
+CONFIG_SPL_MMC=n
+CONFIG_SPL_SPI=n
+CONFIG_SPL_MTD_LOAD=n
+CONFIG_SPL_NAND_SPI_SUPPORT=n
+CONFIG_SPL_DM_DEVICE_REMOVE=n
+CONFIG_DM_MTD=n
+CONFIG_MTD_SPI_NAND=n
+CONFIG_DM_SPI_FLASH=n
+CONFIG_SPI=n
+CONFIG_DM_SPI=n
+CONFIG_CADENCE_QSPI=n
-- 
2.34.1

