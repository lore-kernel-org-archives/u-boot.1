Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B2AAE748F3
	for <u-boot@archiver.kernel.org>; Sun,  1 Oct 2023 16:58:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 881D4870E5;
	Sun,  1 Oct 2023 18:57:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="qST1CA02";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1318886D96; Sun,  1 Oct 2023 18:57:51 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 068C5870E9
 for <u-boot@lists.denx.de>; Sun,  1 Oct 2023 18:57:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-nandan@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 391GveQE018906;
 Sun, 1 Oct 2023 11:57:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1696179460;
 bh=wEDVssTLkaspGtiuCNp7zznUcaBssdopWsfAI/vBg6A=;
 h=From:To:Subject:Date:In-Reply-To:References;
 b=qST1CA02GOfgwrzykilTbjp2sgh9ImNKq1kaOubm/Dg3nAfEcHhYdZ7ShuF8z6g2G
 //mRdBx1kIHb+sPwFH9PBMtLvbkH/vd4lE9HPX+9zwDuOLUeNVC9jv4clvsQ17oa10
 PjC83IRQRlGouyP9yZ1OHW3SLrTOJJl4gb+vLVRI=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 391GveBQ026314
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sun, 1 Oct 2023 11:57:40 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 1
 Oct 2023 11:57:40 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 1 Oct 2023 11:57:40 -0500
Received: from TI.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 391GtkAc002403;
 Sun, 1 Oct 2023 11:57:33 -0500
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
 Yanhong Wang <yanhong.wang@starfivetech.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, <u-boot@lists.denx.de>, Sinthu Raja M
 <sinthu.raja@mistralsolutions.com>, Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH v4 15/16] configs: Add am69_sk_* defconfig fragments
Date: Sun, 1 Oct 2023 22:25:44 +0530
Message-ID: <20231001165545.494212-16-a-nandan@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231001165545.494212-1-a-nandan@ti.com>
References: <20231001165545.494212-1-a-nandan@ti.com>
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
make ARCH=arm j784s4_evm_a72_defconfig am69_sk_a72.config
make ARCH=arm

OR

make ARCH=arm j784s4_evm_r5_defconfig am69_sk_r5.config
make ARCH=arm

Signed-off-by: Dasnavis Sabiya <sabiya.d@ti.com>
Signed-off-by: Apurva Nandan <a-nandan@ti.com>
---
 configs/am69_sk_a72.config | 5 +++++
 configs/am69_sk_r5.config  | 3 +++
 2 files changed, 8 insertions(+)
 create mode 100644 configs/am69_sk_a72.config
 create mode 100644 configs/am69_sk_r5.config

diff --git a/configs/am69_sk_a72.config b/configs/am69_sk_a72.config
new file mode 100644
index 0000000000..18af815cc3
--- /dev/null
+++ b/configs/am69_sk_a72.config
@@ -0,0 +1,5 @@
+# Defconfig fragment to apply on top of j784s4_evm_a72_defconfig
+
+CONFIG_DEFAULT_DEVICE_TREE="k3-am69-sk"
+CONFIG_OF_LIST="k3-am69-sk"
+CONFIG_SPL_OF_LIST="k3-am69-sk"
diff --git a/configs/am69_sk_r5.config b/configs/am69_sk_r5.config
new file mode 100644
index 0000000000..9194694393
--- /dev/null
+++ b/configs/am69_sk_r5.config
@@ -0,0 +1,3 @@
+# Defconfig fragment to apply on top of j784s4_evm_r5_defconfig
+
+CONFIG_DEFAULT_DEVICE_TREE="k3-am69-r5-sk"
-- 
2.34.1

