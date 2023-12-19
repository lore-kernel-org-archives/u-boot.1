Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23D4DC46CA2
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 19:18:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBFF787800;
	Tue, 19 Dec 2023 20:17:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="sdc5ZE6v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D8AC87823; Tue, 19 Dec 2023 20:17:34 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D60AC877E7
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 20:17:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-nandan@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BJJHLot060692;
 Tue, 19 Dec 2023 13:17:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1703013442;
 bh=qbdzRP/VdAICvHetmJ1T+O8YhU1T9yxSH4M7zhpxz04=;
 h=From:To:Subject:Date:In-Reply-To:References;
 b=sdc5ZE6vtNAm9IbUhnOZLPWAgMkJNV2eu2LmbgRlE7MJ8wpdGPq2oFYFUVrkhFg0z
 UUXVUvMZEja1Z/I243f9GBVKlGYkOmEEnYJ8md9h/wsAQHdsyb4CMuxx+EBD6O14qh
 TzU6EVdvz39B05FBYATL9gaslZEqkIUKKuHo7we8=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BJJHLGk053915
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 19 Dec 2023 13:17:21 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 19
 Dec 2023 13:17:21 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 19 Dec 2023 13:17:21 -0600
Received: from TI.dhcp.ti.com (ti.dhcp.ti.com [10.24.69.34] (may be forged))
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BJJFcAO065909;
 Tue, 19 Dec 2023 13:17:15 -0600
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
Subject: [PATCH v7 15/17] configs: Add am69_sk_* defconfig fragments
Date: Wed, 20 Dec 2023 00:45:35 +0530
Message-ID: <20231219191537.4039361-16-a-nandan@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219191537.4039361-1-a-nandan@ti.com>
References: <20231219191537.4039361-1-a-nandan@ti.com>
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

