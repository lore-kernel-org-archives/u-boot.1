Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16B71C021A7
	for <u-boot@archiver.kernel.org>; Thu, 13 Feb 2025 07:38:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85EE180EC0;
	Thu, 13 Feb 2025 08:37:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="tje3Del5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE74080ECB; Thu, 13 Feb 2025 08:37:30 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D7C280C96
 for <u-boot@lists.denx.de>; Thu, 13 Feb 2025 08:37:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51D7bLYO598499
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 13 Feb 2025 01:37:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1739432241;
 bh=o3IPnp/DicRaWmr7m7IT8JF/u6dJ2qUlEBhYE/xrfjM=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=tje3Del5uuwuMf60SC8rm0pFkqTXyZZDqVZl8g8Uhlv+r2dPosNSt2AdhZzq+LkcO
 RI31FterP7uqWzfdxmIt2BgihTHm8Y5tfYglOO4Tf/+Fh90IknPxTc1uBUuTs2Wrus
 7kmYflNrhuAXL3v0U970IW0zt67wR9Des2SANEpw=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51D7bLe7106116;
 Thu, 13 Feb 2025 01:37:21 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 13
 Feb 2025 01:37:20 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 13 Feb 2025 01:37:20 -0600
Received: from [127.0.1.1] (uda0497581-hp.dhcp.ti.com [172.24.227.253])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51D7agtX101327;
 Thu, 13 Feb 2025 01:37:16 -0600
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Thu, 13 Feb 2025 13:06:45 +0530
Subject: [PATCH v3 8/8] configs: Introduce configs for J742S2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250213-b4-upstream-j742s2-v3-8-e00f2a73efb0@ti.com>
References: <20250213-b4-upstream-j742s2-v3-0-e00f2a73efb0@ti.com>
In-Reply-To: <20250213-b4-upstream-j742s2-v3-0-e00f2a73efb0@ti.com>
To: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, Lukasz Majewski
 <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Jaehoon Chung
 <jh80.chung@samsung.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Aniket
 Limaye <a-limaye@ti.com>, Beleswar Padhi <b-padhi@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Nishanth Menon <nm@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Andrew Davis <afd@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>, Keerthy <j-keerthy@ti.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739432202; l=1883;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=DjsZoM+tZLu7JR3bWawyjs9tvXvH6XLWLcO9Bh6kA3A=;
 b=y7iJwrWbgnltQAG88mTHynBjUVUV1Re1Zy0APrOW9t0RqZXwH/s2vE5I4SGeSw2s8wv1ofFxo
 3jmzHlA2c8+AEsnQqbkmggbVvIJGt8zfMNsUVsL6YbeUB/hg3kZQqgA
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
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

Based off j784s4 configs with delta changes for J742S2

[ Add AVS support for J742S2 ]
Signed-off-by: Keerthy <j-keerthy@ti.com>
Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 board/ti/j784s4/MAINTAINERS      | 2 ++
 configs/j742s2_evm_a72_defconfig | 9 +++++++++
 configs/j742s2_evm_r5_defconfig  | 9 +++++++++
 3 files changed, 20 insertions(+)

diff --git a/board/ti/j784s4/MAINTAINERS b/board/ti/j784s4/MAINTAINERS
index bc3a726228c75e7db7547abd2d7d6a13f043bdae..b289c639f3f880ef50b2e0b2c7e586c7d2ccad71 100644
--- a/board/ti/j784s4/MAINTAINERS
+++ b/board/ti/j784s4/MAINTAINERS
@@ -28,3 +28,5 @@ F:	arch/arm/dts/k3-j784s4-j742s2-ddr.dtsi
 F:	arch/arm/dts/k3-j742s2-r5-evm.dts
 F:	arch/arm/dts/k3-j742s2-evm-u-boot.dtsi
 F:	arch/arm/dts/k3-j742s2-ddr-evm-lp4-4266.dtsi
+F:	configs/j742s2_evm_r5_defconfig
+F:	configs/j742s2_evm_a72_defconfig
diff --git a/configs/j742s2_evm_a72_defconfig b/configs/j742s2_evm_a72_defconfig
new file mode 100644
index 0000000000000000000000000000000000000000..e534ce4c2e3bf28a78eff241c4b035917e3fb61c
--- /dev/null
+++ b/configs/j742s2_evm_a72_defconfig
@@ -0,0 +1,9 @@
+#include <configs/j784s4_evm_a72_defconfig>
+
+CONFIG_ARM=y
+CONFIG_ARCH_K3=y
+CONFIG_SOC_K3_J784S4=y
+CONFIG_TARGET_J742S2_A72_EVM=y
+
+CONFIG_DEFAULT_DEVICE_TREE="ti/k3-j742s2-evm"
+CONFIG_SPL_OF_LIST="ti/k3-j742s2-evm"
diff --git a/configs/j742s2_evm_r5_defconfig b/configs/j742s2_evm_r5_defconfig
new file mode 100644
index 0000000000000000000000000000000000000000..2be6318df76632dd2cc5cbeebcb6ce674cd80338
--- /dev/null
+++ b/configs/j742s2_evm_r5_defconfig
@@ -0,0 +1,9 @@
+#include <configs/j784s4_evm_r5_defconfig>
+
+CONFIG_ARM=y
+CONFIG_ARCH_K3=y
+CONFIG_SOC_K3_J784S4=y
+CONFIG_TARGET_J742S2_R5_EVM=y
+
+CONFIG_DEFAULT_DEVICE_TREE="k3-j742s2-r5-evm"
+CONFIG_SPL_OF_LIST="k3-j742s2-r5-evm"

-- 
2.34.1

