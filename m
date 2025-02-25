Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83A61C021B2
	for <u-boot@archiver.kernel.org>; Tue, 25 Feb 2025 11:51:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3E0681120;
	Tue, 25 Feb 2025 12:49:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="fYU1oAvj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C8B8810DC; Tue, 25 Feb 2025 12:49:34 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFADA810F1
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 12:49:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51PBnFbI1152578
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 25 Feb 2025 05:49:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1740484155;
 bh=Ze3/WDVRu0RwE7GX3iyqymUaFV7yueAAg0Kq/kpjRCI=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=fYU1oAvjCQTldr0avPGogT2v9K4Mt4w8ZdfJaJX0FJq1sX1/Tt8+IuFKpU+Phaaa4
 h0GPD0RYh/3P0oSV9D1vqlX7uyOzIYxXYebJruD4BAnt5s3qXgc4cSlzG+mIN/G43G
 YnAYHR4vKobruhU/un7/QdERoqDKVanwZiHugoSs=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51PBnF5s056935
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 25 Feb 2025 05:49:15 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 25
 Feb 2025 05:49:14 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 25 Feb 2025 05:49:14 -0600
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.227.220])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51PBnDYd112368;
 Tue, 25 Feb 2025 05:49:14 -0600
From: Chintan Vankar <c-vankar@ti.com>
To: Michael Walle <mwalle@kernel.org>, Matthias Schiffer
 <matthias.schiffer@ew.tq-group.com>, MD Danish Anwar <danishanwar@ti.com>,
 Roger Quadros <rogerq@kernel.org>, Hari Nagalla <hnagalla@ti.com>, "Manorit
 Chawdhry" <m-chawdhry@ti.com>, Jonathan Humphreys <j-humphreys@ti.com>,
 Santhosh Kumar K <s-k6@ti.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Neha Malcom Francis <n-francis@ti.com>,
 Andreas Dannenberg <dannenberg@ti.com>, Andrew Davis <afd@ti.com>,
 "Alexander Sverdlin" <alexander.sverdlin@siemens.com>, Joao Paulo Goncalves
 <joao.goncalves@toradex.com>, Kishon Vijay Abraham I <kishon@ti.com>,
 "Chintan Vankar" <c-vankar@ti.com>, Wadim Egorov <w.egorov@phytec.de>,
 Ramon Fried <rfried.dev@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 "Jayesh Choudhary" <j-choudhary@ti.com>,
 Vaishnav Achath <vaishnav.a@ti.com>, "Bryan Brattlof" <bb@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tom Rini <trini@konsulko.com>
CC: <s-vadapalli@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH v3 06/15] configs: am68: Add configs for enabling Ethboot in
 R5SPL
Date: Tue, 25 Feb 2025 17:18:54 +0530
Message-ID: <20250225114903.2080616-7-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250225114903.2080616-1-c-vankar@ti.com>
References: <20250225114903.2080616-1-c-vankar@ti.com>
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

Add configs for enabling Ethernet boot in R5SPL, also disable not required
configs to avoid memory limitation.

Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---

Link to v2:
https://lore.kernel.org/r/20250219104831.2315464-7-c-vankar@ti.com/

Changes from v2 to v3:
- Removed not required config options from the file as suggested by
  Andrew Davis.

 configs/am68_sk_r5_ethboot_defconfig | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 configs/am68_sk_r5_ethboot_defconfig

diff --git a/configs/am68_sk_r5_ethboot_defconfig b/configs/am68_sk_r5_ethboot_defconfig
new file mode 100644
index 00000000000..f0815b781d5
--- /dev/null
+++ b/configs/am68_sk_r5_ethboot_defconfig
@@ -0,0 +1,23 @@
+#include <configs/am68_sk_r5_defconfig>
+
+CONFIG_ARM=y
+CONFIG_ARCH_K3=y
+CONFIG_SOC_K3_J721S2=y
+CONFIG_TARGET_J721S2_R5_EVM=y
+CONFIG_DEFAULT_DEVICE_TREE="k3-am68-sk-r5-base-board"
+CONFIG_SPL_BOARD_INIT=y
+CONFIG_SPL_DMA=y
+CONFIG_SPL_ETH=y
+CONFIG_SPL_NET=y
+CONFIG_SPL_NET_VCI_STRING="AM68 U-Boot R5 SPL"
+CONFIG_TI_K3_NAVSS_UDMA=y
+CONFIG_TI_AM65_CPSW_NUSS=y
+CONFIG_SPI=n
+CONFIG_SPL_SPI=n
+CONFIG_DM_SPI=n
+CONFIG_MTD=n
+CONFIG_SPL_MTD=n
+CONFIG_SPL_NAND_SPI_SUPPORT=n
+CONFIG_NOR_SUPPORT=n
+CONFIG_SPL_NOR_SUPPORT=n
+CONFIG_SYS_MALLOC_CLEAR_ON_INIT=n
-- 
2.34.1

