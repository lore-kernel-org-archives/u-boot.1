Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AA66C4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 12:40:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B0F7878B9;
	Wed,  6 Dec 2023 13:39:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="N7ZK3XAM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86C3A878AF; Wed,  6 Dec 2023 13:39:51 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D2BD878CF
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 13:39:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-nandan@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B6CdeAd025493;
 Wed, 6 Dec 2023 06:39:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1701866380;
 bh=qbdzRP/VdAICvHetmJ1T+O8YhU1T9yxSH4M7zhpxz04=;
 h=From:To:Subject:Date:In-Reply-To:References;
 b=N7ZK3XAMAPP25mXm2k9wKlzZKSqHs3Jw00R9vfodTAx4IpU44RkbKObcjqmav7ROr
 G/Brq7imCCbRaEqy0vkoxWTz4HrATDm931sLwzQTOUj/Jfmut7wBKQ2WUGd6rjUYNS
 VkQQ7Hh6V1IaFRcUhRqnGsS/RGSkhs6yowSHAH+Y=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B6CdenL029087
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 6 Dec 2023 06:39:40 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 6
 Dec 2023 06:39:40 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 6 Dec 2023 06:39:40 -0600
Received: from TI.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B6Cbrqq096939;
 Wed, 6 Dec 2023 06:39:34 -0600
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
Subject: [PATCH v6 15/17] configs: Add am69_sk_* defconfig fragments
Date: Wed, 6 Dec 2023 18:07:51 +0530
Message-ID: <20231206123753.1486031-16-a-nandan@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231206123753.1486031-1-a-nandan@ti.com>
References: <20231206123753.1486031-1-a-nandan@ti.com>
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
 configs/am69_sk_a72.config | 3 +++
 configs/am69_sk_r5.config  | 3 +++
 2 files changed, 6 insertions(+)
 create mode 100644 configs/am69_sk_a72.config
 create mode 100644 configs/am69_sk_r5.config

diff --git a/configs/am69_sk_a72.config b/configs/am69_sk_a72.config
new file mode 100644
index 0000000000..5668e23b37
--- /dev/null
+++ b/configs/am69_sk_a72.config
@@ -0,0 +1,3 @@
+# Defconfig fragment to apply on top of j784s4_evm_a72_defconfig
+
+CONFIG_DEFAULT_DEVICE_TREE="k3-am69-sk"
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

