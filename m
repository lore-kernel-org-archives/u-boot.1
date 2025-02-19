Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7290C021AA
	for <u-boot@archiver.kernel.org>; Wed, 19 Feb 2025 10:51:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09BDC80F77;
	Wed, 19 Feb 2025 11:49:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="iNyzZj2n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A73C80F88; Wed, 19 Feb 2025 11:49:13 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38BF780A46
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 11:49:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51JAmqqZ1950565
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Feb 2025 04:48:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1739962132;
 bh=+k3sTpqWnG6B0taxlxtDOTs5BP6KFTVoyEmpixGlEYM=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=iNyzZj2nX4LF8Xza/8N17O4MqsfZZoo8yU06V6ZhHCGjFVduEgwhOxYl7t7PAsf/6
 04ZgzKdhi+cuNT3V3MSCsZVRfemcU6553dMxoUIxu1POLcPsoYygNJxfUaenYYyqCY
 y4Msk4wi3sPsoMMEQLM7yEs2x3DWz6WqJpRTovw0=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51JAmqJD013372
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 19 Feb 2025 04:48:52 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 19
 Feb 2025 04:48:51 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 19 Feb 2025 04:48:52 -0600
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.227.220])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51JAmpHt030341;
 Wed, 19 Feb 2025 04:48:51 -0600
From: Chintan Vankar <c-vankar@ti.com>
To: Christian Marangi <ansuelsmth@gmail.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Mikhail Kshevetskiy
 <mikhail.kshevetskiy@iopsys.eu>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>,
 Michael Walle <mwalle@kernel.org>, "Roger Quadros" <rogerq@kernel.org>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Santhosh Kumar K <s-k6@ti.com>, "Hari Nagalla" <hnagalla@ti.com>,
 Nishanth Menon <nm@ti.com>, Jonathan Humphreys <j-humphreys@ti.com>,
 Andreas Dannenberg <dannenberg@ti.com>, "Kishon Vijay
 Abraham I" <kishon@ti.com>, Joao Paulo Goncalves
 <joao.goncalves@toradex.com>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>, Wadim Egorov
 <w.egorov@phytec.de>, "Udit Kumar" <u-kumar1@ti.com>, Neha Malcom Francis
 <n-francis@ti.com>, Andrew Davis <afd@ti.com>, Chintan Vankar
 <c-vankar@ti.com>, Ramon Fried <rfried.dev@gmail.com>, Joe Hershberger
 <joe.hershberger@ni.com>, "Bryan Brattlof" <bb@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Tom Rini
 <trini@konsulko.com>
CC: <u-boot@lists.denx.de>
Subject: [PATCH v2 12/13] configs: am62p: Enable configs required for Ethboot
Date: Wed, 19 Feb 2025 16:18:30 +0530
Message-ID: <20250219104831.2315464-13-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250219104831.2315464-1-c-vankar@ti.com>
References: <20250219104831.2315464-1-c-vankar@ti.com>
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

Enable config options needed to support Ethernet boot on AM62p SK.

Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---

Link to v1:
https://lore.kernel.org/r/20250107093840.2211381-13-c-vankar@ti.com/

Changes from v1 to v2:
- Removed commented config option which was not required.

 configs/am62px_evm_a53_ethboot_defconfig | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 configs/am62px_evm_a53_ethboot_defconfig

diff --git a/configs/am62px_evm_a53_ethboot_defconfig b/configs/am62px_evm_a53_ethboot_defconfig
new file mode 100644
index 00000000000..0bdb4501c34
--- /dev/null
+++ b/configs/am62px_evm_a53_ethboot_defconfig
@@ -0,0 +1,14 @@
+#include <configs/am62px_evm_a53_defconfig>
+
+CONFIG_ARM=y
+CONFIG_ARCH_K3=y
+CONFIG_SOC_K3_AM62P5=y
+CONFIG_TARGET_AM62P5_A53_EVM=y
+CONFIG_DEFAULT_DEVICE_TREE="ti/k3-am62p5-sk"
+CONFIG_SPL_STACK_R_ADDR=0x82000000
+CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_DMA=y
+CONFIG_SPL_ETH=y
+CONFIG_SPL_NET=y
+CONFIG_SPL_NET_VCI_STRING="AM62PX U-Boot A53 SPL"
+CONFIG_SPL_SYSCON=y
-- 
2.34.1

