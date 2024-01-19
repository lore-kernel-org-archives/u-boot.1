Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3BDBC4725D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 17:53:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2AA887DB6;
	Fri, 19 Jan 2024 18:52:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="vsrxlK2m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEE5687DB6; Fri, 19 Jan 2024 18:52:43 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CA6887DC0
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 18:52:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-nandan@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40JHqWKf087196;
 Fri, 19 Jan 2024 11:52:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1705686752;
 bh=m4ieiLWtVOMbjELWNI57+3c5+yRK5TZ9//o3WHXvjC0=;
 h=From:To:Subject:Date:In-Reply-To:References;
 b=vsrxlK2mvWS8XPJXoIC+uyzbuRypAh/LpHvGs4nDzLX+cQP97SK3vYMdqAn3h/WuS
 BB0IvNIwbrMVypCdGAVgzTg+wof2uK6vmSI/1vBGMLRG71dKo9Hu30gBOj3K4ZndfE
 vXUVV4LlXCv5xtK2epGZY59Q4HY2K6+jYTQtD+uk=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40JHqWGE119668
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 19 Jan 2024 11:52:32 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 19
 Jan 2024 11:52:31 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 19 Jan 2024 11:52:31 -0600
Received: from TI.dhcp.ti.com (ti.dhcp.ti.com [10.24.68.115] (may be forged))
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40JHoiDb054787; 
 Fri, 19 Jan 2024 11:52:25 -0600
From: Apurva Nandan <a-nandan@ti.com>
To: Apurva Nandan <a-nandan@ti.com>, Hari Nagalla <hnagalla@ti.com>, Lukasz
 Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Neha Malcom Francis <n-francis@ti.com>,
 Simon Glass <sjg@chromium.org>, Andrew Davis <afd@ti.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, Dasnavis Sabiya <sabiya.d@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Aradhya Bhatia <a-bhatia1@ti.com>, Bryan Brattlof <bb@ti.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>, Nishanth Menon
 <nm@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Marcel Ziswiler
 <marcel.ziswiler@toradex.com>, Roger Quadros <rogerq@kernel.org>, Jayesh
 Choudhary <j-choudhary@ti.com>, Ralph Siemsen <ralph.siemsen@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, <u-boot@lists.denx.de>, Sinthu Raja M
 <sinthu.raja@mistralsolutions.com>, Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH v8 15/16] configs: Add am69_sk_* defconfig fragments
Date: Fri, 19 Jan 2024 23:20:42 +0530
Message-ID: <20240119175043.3904751-16-a-nandan@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240119175043.3904751-1-a-nandan@ti.com>
References: <20240119175043.3904751-1-a-nandan@ti.com>
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

From: Dasnavis Sabiya <sabiya.d@ti.com>

Add config fragments for am69_sk A72 and R5 configuration.

This applies on to:
j784s4_evm_a72_defconfig -> am69_sk_a72.config
j784s4_evm_r5_defconfig -> am69_sk_r5.config

The usage model (with the fragment) would be:
make j784s4_evm_a72_defconfig am69_sk_a72.config
make

OR

make j784s4_evm_r5_defconfig am69_sk_r5.config
make

Signed-off-by: Dasnavis Sabiya <sabiya.d@ti.com>
Signed-off-by: Apurva Nandan <a-nandan@ti.com>
---
 board/ti/j784s4/MAINTAINERS | 2 ++
 configs/am69_sk_a72.config  | 5 +++++
 configs/am69_sk_r5.config   | 5 +++++
 3 files changed, 12 insertions(+)
 create mode 100644 configs/am69_sk_a72.config
 create mode 100644 configs/am69_sk_r5.config

diff --git a/board/ti/j784s4/MAINTAINERS b/board/ti/j784s4/MAINTAINERS
index 4433ead66b..69be13f533 100644
--- a/board/ti/j784s4/MAINTAINERS
+++ b/board/ti/j784s4/MAINTAINERS
@@ -20,3 +20,5 @@ AM69 SK BOARD
 F:	arch/arm/dts/k3-am69-sk.dts
 F:	arch/arm/dts/k3-am69-sk-u-boot.dtsi
 F:	arch/arm/dts/k3-am69-r5-sk.dts
+F:	configs/am69_sk_r5.config
+F:	configs/am69_sk_a72.config
diff --git a/configs/am69_sk_a72.config b/configs/am69_sk_a72.config
new file mode 100644
index 0000000000..03e74a8a56
--- /dev/null
+++ b/configs/am69_sk_a72.config
@@ -0,0 +1,5 @@
+# Defconfig fragment to apply on top of j784s4_evm_a72_defconfig
+
+CONFIG_DEFAULT_DEVICE_TREE="k3-am69-sk"
+CONFIG_SPL_OF_LIST="k3-am69-sk"
+CONFIG_OF_LIST="k3-am69-sk"
diff --git a/configs/am69_sk_r5.config b/configs/am69_sk_r5.config
new file mode 100644
index 0000000000..c42b6f3380
--- /dev/null
+++ b/configs/am69_sk_r5.config
@@ -0,0 +1,5 @@
+# Defconfig fragment to apply on top of j784s4_evm_r5_defconfig
+
+CONFIG_DEFAULT_DEVICE_TREE="k3-am69-sk"
+CONFIG_SPL_OF_LIST="k3-am69-r5-sk"
+CONFIG_OF_LIST="k3-am69-r5-sk"
-- 
2.34.1

