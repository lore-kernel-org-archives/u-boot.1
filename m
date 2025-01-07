Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD8F7E77198
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 09:39:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1302806CB;
	Tue,  7 Jan 2025 10:39:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Ww/454Uz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3E1B8061B; Tue,  7 Jan 2025 10:39:07 +0100 (CET)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F344C805FA
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 10:39:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 5079cpur2928640
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 7 Jan 2025 03:38:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1736242731;
 bh=C5kn2T6EZS89+e0ZZOKX07wvaVFpBJPGsHwCcowr3iA=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=Ww/454UzQrMWfI9KDmes+qE2w8lTMIEAw7Hsofm38XomNfN967VqbEWEgewLVeBAo
 J4ipMQygtlexp0sPC5a1Cuy2euCojb/cQPv3kPU99FnkbSWqRxIh8INjDGM01mlVem
 PkNQkHJeYcdnnICouUwWs1EtmKzflHcPGqvHIrVM=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5079cpjp063727;
 Tue, 7 Jan 2025 03:38:51 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 7
 Jan 2025 03:38:50 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 7 Jan 2025 03:38:50 -0600
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.227.220])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5079cnbF057453;
 Tue, 7 Jan 2025 03:38:50 -0600
From: Chintan Vankar <c-vankar@ti.com>
To: AKASHI Takahiro <akashi.tkhro@gmail.com>, Mikhail Kshevetskiy
 <mikhail.kshevetskiy@iopsys.eu>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Nishanth Menon <nm@ti.com>, Roger Quadros
 <rogerq@kernel.org>, Hari Nagalla <hnagalla@ti.com>, Jonathan Humphreys
 <j-humphreys@ti.com>, Andreas Dannenberg <dannenberg@ti.com>, Simon Glass
 <sjg@chromium.org>, Jayesh Choudhary <j-choudhary@ti.com>, Aniket Limaye
 <a-limaye@ti.com>, Aradhya Bhatia <a-bhatia1@ti.com>, Chintan Vankar
 <c-vankar@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Andrew Davis
 <afd@ti.com>, Ramon Fried <rfried.dev@gmail.com>, Joe Hershberger
 <joe.hershberger@ni.com>, Bryan Brattlof <bb@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Tom Rini
 <trini@konsulko.com>
CC: <srk@ti.com>, <s-vadapalli@ti.com>, <danishanwar@ti.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH 06/13] configs: am68: Enable configs required for Ethernet boot
Date: Tue, 7 Jan 2025 15:08:33 +0530
Message-ID: <20250107093840.2211381-7-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250107093840.2211381-1-c-vankar@ti.com>
References: <20250107093840.2211381-1-c-vankar@ti.com>
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

Enable config options needed to support Ethernet boot on AM68-SK.

Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---
 configs/am68_sk_a72_ethboot_defconfig | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 configs/am68_sk_a72_ethboot_defconfig

diff --git a/configs/am68_sk_a72_ethboot_defconfig b/configs/am68_sk_a72_ethboot_defconfig
new file mode 100644
index 00000000000..42469861961
--- /dev/null
+++ b/configs/am68_sk_a72_ethboot_defconfig
@@ -0,0 +1,18 @@
+#include <configs/am68_sk_a72_defconfig>
+
+CONFIG_ARM=y
+CONFIG_ARCH_K3=y
+CONFIG_SOC_K3_J721S2=y
+CONFIG_TARGET_J721S2_A72_EVM=y
+CONFIG_DEFAULT_DEVICE_TREE="ti/k3-am68-sk-base-board"
+CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_BOARD_INIT=y
+CONFIG_SPL_DMA=y
+CONFIG_SPL_ENV_SUPPORT=y
+CONFIG_SPL_ETH=y
+CONFIG_SPL_NET=y
+CONFIG_SPL_NET_VCI_STRING="AM68 U-Boot A72 SPL"
+CONFIG_SPL_SYSCON=y
+CONFIG_SPL_RAW_IMAGE_SUPPORT=y
+CONFIG_OF_UPSTREAM=y
+CONFIG_SPL_STACK_R_ADDR=0x83000000
-- 
2.34.1

