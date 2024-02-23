Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F837C5478C
	for <u-boot@archiver.kernel.org>; Fri, 23 Feb 2024 20:38:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E77387D97;
	Fri, 23 Feb 2024 21:27:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ZRJ0bhbS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7132486EEC; Fri, 23 Feb 2024 19:55:20 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1F5587C0A
 for <u-boot@lists.denx.de>; Fri, 23 Feb 2024 19:55:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-nandan@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41NIslmv024888;
 Fri, 23 Feb 2024 12:54:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1708714487;
 bh=9y4eUMil0pXqmiiv4YykvZAaGbdhtVgZ6v7iR5mxieM=;
 h=From:To:Subject:Date:In-Reply-To:References;
 b=ZRJ0bhbSpBc0HcUMGeamcTE+MIuSEbfmuU/fEvt/BKMvb8QpeWk5exiy+ABq4IhHW
 CLWtpc3B/rw3+aY3D179Iy7LeBA3WMt2kV0st1X7xykLiG66xt+bFbxhZBqrmy/4qF
 7uNCtJfYj8p6+iYMCeRF8Ohsx4sIsQO6vL1QKu7A=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41NIslfP101866
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 23 Feb 2024 12:54:47 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 23
 Feb 2024 12:54:47 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 23 Feb 2024 12:54:47 -0600
Received: from TI.dhcp.ti.com (ti.dhcp.ti.com [10.24.68.115] (may be forged))
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41NIpvhv051632; 
 Fri, 23 Feb 2024 12:54:36 -0600
From: Apurva Nandan <a-nandan@ti.com>
To: Tom Rini <trini@konsulko.com>, Apurva Nandan <a-nandan@ti.com>, "Lukasz
 Majewski" <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>, Sumit Garg
 <sumit.garg@linaro.org>, Jesse Taube <mr.bossman075@gmail.com>, "Bryan
 Brattlof" <bb@ti.com>, Kever Yang <kever.yang@rock-chips.com>, Michal Simek
 <michal.simek@amd.com>, Marek Vasut <marex@denx.de>, Neil Armstrong
 <neil.armstrong@linaro.org>, Jonas Karlman <jonas@kwiboo.se>, Tianling Shen
 <cnsztl@gmail.com>, Svyatoslav Ryhel <clamor95@gmail.com>, Hai Pham
 <hai.pham.ud@renesas.com>, FUKAUMI Naoki <naoki@radxa.com>,
 Christian Hewitt <christianshewitt@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Dasnavis Sabiya <sabiya.d@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, "Hari Nagalla" <hnagalla@ti.com>,
 Andrew Davis <afd@ti.com>, Nishanth Menon <nm@ti.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, Christian Gmeiner
 <christian.gmeiner@gmail.com>, Emanuele Ghidoli
 <emanuele.ghidoli@toradex.com>, Francesco Dolcini
 <francesco.dolcini@toradex.com>, Roger Quadros <rogerq@kernel.org>,
 "Aradhya Bhatia" <a-bhatia1@ti.com>, Joao Paulo Goncalves
 <joao.goncalves@toradex.com>, Bhavya Kapoor <b-kapoor@ti.com>, Jonathan
 Humphreys <j-humphreys@ti.com>, Nikhil M Jain <n-jain1@ti.com>, Mattijs
 Korpershoek <mkorpershoek@baylibre.com>, Marcel Ziswiler
 <marcel.ziswiler@toradex.com>, Vignesh Raghavendra <vigneshr@ti.com>, Udit
 Kumar <u-kumar1@ti.com>, "Heinrich Schuchardt" <xypron.glpk@gmx.de>, Jason
 Kacines <j-kacines@ti.com>, "Jayesh Choudhary" <j-choudhary@ti.com>, Andre
 Przywara <andre.przywara@arm.com>, Yanhong Wang
 <yanhong.wang@starfivetech.com>, Ralph Siemsen <ralph.siemsen@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, <u-boot@lists.denx.de>
Subject: [PATCH v9 14/15] configs: am69_sk: Add defconfig for AM69 SK board
Date: Sat, 24 Feb 2024 00:21:55 +0530
Message-ID: <20240223185156.3065032-15-a-nandan@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240223185156.3065032-1-a-nandan@ti.com>
References: <20240223185156.3065032-1-a-nandan@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Fri, 23 Feb 2024 21:25:51 +0100
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

From: Dasnavis Sabiya <sabiya.d@ti.com>

Add defconfig for AM69 SK A72 and R5 configuration.

This inlcudes and modifies the J784S4 EVM defconfigs:
j784s4_evm_a72_defconfig -> am69_sk_a72_defconfig
j784s4_evm_r5_defconfig -> am69_sk_r5_defconfig

Signed-off-by: Dasnavis Sabiya <sabiya.d@ti.com>
Signed-off-by: Apurva Nandan <a-nandan@ti.com>
---
 board/ti/j784s4/MAINTAINERS   |  2 ++
 configs/am69_sk_a72_defconfig | 10 ++++++++++
 configs/am69_sk_r5_defconfig  | 10 ++++++++++
 3 files changed, 22 insertions(+)
 create mode 100644 configs/am69_sk_a72_defconfig
 create mode 100644 configs/am69_sk_r5_defconfig

diff --git a/board/ti/j784s4/MAINTAINERS b/board/ti/j784s4/MAINTAINERS
index 2b6bff2f5be..46f4ba5da96 100644
--- a/board/ti/j784s4/MAINTAINERS
+++ b/board/ti/j784s4/MAINTAINERS
@@ -16,3 +16,5 @@ M:	Apurva Nandan <a-nandan@ti.com>
 S:	Maintained
 F:	arch/arm/dts/k3-am69-sk-u-boot.dtsi
 F:	arch/arm/dts/k3-am69-r5-sk.dts
+F:	configs/am69_sk_r5_defconfig
+F:	configs/am69_sk_a72_defconfig
diff --git a/configs/am69_sk_a72_defconfig b/configs/am69_sk_a72_defconfig
new file mode 100644
index 00000000000..74588160078
--- /dev/null
+++ b/configs/am69_sk_a72_defconfig
@@ -0,0 +1,10 @@
+#include <configs/j784s4_evm_a72_defconfig>
+
+CONFIG_ARM=y
+CONFIG_ARCH_K3=y
+CONFIG_SOC_K3_J784S4=y
+CONFIG_TARGET_J784S4_A72_EVM=y
+
+CONFIG_DEFAULT_DEVICE_TREE="k3-am69-sk"
+CONFIG_SPL_OF_LIST="k3-am69-sk"
+CONFIG_OF_LIST="k3-am69-sk"
diff --git a/configs/am69_sk_r5_defconfig b/configs/am69_sk_r5_defconfig
new file mode 100644
index 00000000000..2186b9a0490
--- /dev/null
+++ b/configs/am69_sk_r5_defconfig
@@ -0,0 +1,10 @@
+#include <configs/j784s4_evm_r5_defconfig>
+
+CONFIG_ARM=y
+CONFIG_ARCH_K3=y
+CONFIG_SOC_K3_J784S4=y
+CONFIG_TARGET_J784S4_R5_EVM=y
+
+CONFIG_DEFAULT_DEVICE_TREE="k3-am69-r5-sk"
+CONFIG_SPL_OF_LIST="k3-am69-r5-sk"
+CONFIG_OF_LIST="k3-am69-r5-sk"
-- 
2.34.1

