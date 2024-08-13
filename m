Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDC63C52D7C
	for <u-boot@archiver.kernel.org>; Tue, 13 Aug 2024 10:55:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C150488966;
	Tue, 13 Aug 2024 12:54:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Zg7ElLPl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AF1C88747; Tue, 13 Aug 2024 12:54:38 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACE2488980
 for <u-boot@lists.denx.de>; Tue, 13 Aug 2024 12:54:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47DAsMAE063225;
 Tue, 13 Aug 2024 05:54:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1723546462;
 bh=ALpOIJvWAouy1hOcHL6hQbAV5o1g6jj/iqvsG+R/JHY=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=Zg7ElLPlOI2AvIswbvzQprhQUjoJKpOJxIJzT09sRQ+g3Rdoo2WtoEq2MYjh933/n
 ilMjNCMaW/hmISrRntiowvC63MIC3LrBZJd1nFMi+cXjwp3JGRkR3qQ1VXBSEtm7uy
 +QAlgfGwEg97LxVD+gBMGJux3tOjWopN2H7++i9w=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47DAsM7b071840
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 13 Aug 2024 05:54:22 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 13
 Aug 2024 05:54:21 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 13 Aug 2024 05:54:21 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.227.220])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47DAsLvh120955;
 Tue, 13 Aug 2024 05:54:21 -0500
From: Chintan Vankar <c-vankar@ti.com>
To: Michal Simek <michal.simek@amd.com>, =?UTF-8?q?Marek=20Beh=C3=BAn?=
 <kabel@kernel.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>, "Neha
 Malcom Francis" <n-francis@ti.com>, MD Danish Anwar <danishanwar@ti.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Ravi Gunasekaran
 <r-gunasekaran@ti.com>, Udit Kumar <u-kumar1@ti.com>, Matthias Schiffer
 <matthias.schiffer@ew.tq-group.com>,
 Jonas Karlman <jonas@kwiboo.se>, "Devarsh Thakkar" <devarsht@ti.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Andrew Davis <afd@ti.com>, Michael Trimarchi
 <michael@amarulasolutions.com>, Joao Paulo Goncalves
 <joao.goncalves@toradex.com>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, Wadim Egorov <w.egorov@phytec.de>, Dhruva Gole
 <d-gole@ti.com>, Francesco Dolcini <francesco.dolcini@toradex.com>,
 "Nishanth Menon" <nm@ti.com>, Sumit Garg <sumit.garg@linaro.org>, Tom Rini
 <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Kishon Vijay Abraham I <kishon@ti.com>, "Chintan
 Vankar" <c-vankar@ti.com>
Subject: [PATCH v5 08/10] configs: am62: Enable configs required for Ethboot
Date: Tue, 13 Aug 2024 16:23:58 +0530
Message-ID: <20240813105400.4054657-9-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240813105400.4054657-1-c-vankar@ti.com>
References: <20240813105400.4054657-1-c-vankar@ti.com>
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

From: Kishon Vijay Abraham I <kishon@ti.com>

Enable config options needed to support Ethernet boot on AM62x SK.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---

Link to v4:
https://lore.kernel.org/r/20240812114922.3844009-1-c-vankar@ti.com/

Changes from v4 to v5:
- No Changes.

 configs/am62x_evm_a53_ethboot_defconfig | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 configs/am62x_evm_a53_ethboot_defconfig

diff --git a/configs/am62x_evm_a53_ethboot_defconfig b/configs/am62x_evm_a53_ethboot_defconfig
new file mode 100644
index 00000000000..9d3c6b889f0
--- /dev/null
+++ b/configs/am62x_evm_a53_ethboot_defconfig
@@ -0,0 +1,17 @@
+#include <configs/am62x_evm_a53_defconfig>
+
+CONFIG_ARM=y
+CONFIG_ARCH_K3=y
+CONFIG_SOC_K3_AM625=y
+CONFIG_TARGET_AM625_A53_EVM=y
+CONFIG_DEFAULT_DEVICE_TREE="ti/k3-am625-sk"
+CONFIG_SPL_STACK_R_ADDR=0x83000000
+CONFIG_SPL_SIZE_LIMIT=0x80000
+CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_BOARD_INIT=y
+CONFIG_SPL_DMA=y
+CONFIG_SPL_ENV_SUPPORT=y
+CONFIG_SPL_ETH=y
+CONFIG_SPL_NET=y
+CONFIG_SPL_NET_VCI_STRING="AM62X U-Boot A53 SPL"
+CONFIG_SPL_SYSCON=y
-- 
2.34.1

