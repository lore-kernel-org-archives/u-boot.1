Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DBBFEE8009
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 14:03:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C3B586B0A;
	Fri,  8 Sep 2023 16:01:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="GR9BefH9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBD6386A2B; Fri,  8 Sep 2023 13:06:52 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C1D586A24
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 13:06:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-nandan@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 388B6fIO000690;
 Fri, 8 Sep 2023 06:06:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1694171201;
 bh=lx2ShItbrnm24Gk4lkGCArW+j3Vug00vNSJ23oEzVD0=;
 h=From:To:Subject:Date:In-Reply-To:References;
 b=GR9BefH9rT6u1GAti86s4LBvFkrEahRRGJgV7RESNLyakULsmutggmI4aL3Y9+mIL
 GnDBbory4OBBWWdiqx7RnPxa4ThQOCbwW2Oq+o5as6OYQIqoeYz1CHDoUfKoEGCVlR
 gTNP/ZyVxobisbfrh9QvDuzJBicNLBjXUFgynlGY=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 388B6foh094455
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 8 Sep 2023 06:06:41 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 8
 Sep 2023 06:06:41 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 8 Sep 2023 06:06:41 -0500
Received: from TI.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 388B5qEJ018063;
 Fri, 8 Sep 2023 06:06:34 -0500
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
 <marcel.ziswiler@toradex.com>, Roger Quadros <rogerq@kernel.org>, Jason
 Kacines <j-kacines@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>, Ralph
 Siemsen <ralph.siemsen@linaro.org>, Yanhong Wang
 <yanhong.wang@starfivetech.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, <u-boot@lists.denx.de>
Subject: [PATCH v3 06/16] remoteproc: k3-r5: Extend support for R5F clusters
 on J784S4 SoCs
Date: Fri, 8 Sep 2023 16:35:41 +0530
Message-ID: <20230908110551.861575-7-a-nandan@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230908110551.861575-1-a-nandan@ti.com>
References: <20230908110551.861575-1-a-nandan@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Fri, 08 Sep 2023 16:01:41 +0200
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

From: Hari Nagalla <hnagalla@ti.com>

The K3 J784S4 SoCs have four dual-core R5F subsystems, one in MCU
voltage domain and the other three in MAIN voltage domain. These R5F
clusters are similar to the R5F clusters in J7200 and J721S2 SoCs.

Extend support to the R5F clusters for J784S4 with J721S2 compatible
string.

Signed-off-by: Hari Nagalla <hnagalla@ti.com>
Signed-off-by: Apurva Nandan <a-nandan@ti.com>
---
 drivers/remoteproc/ti_k3_r5f_rproc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/ti_k3_r5f_rproc.c b/drivers/remoteproc/ti_k3_r5f_rproc.c
index 6f3e12d915..631e548dcc 100644
--- a/drivers/remoteproc/ti_k3_r5f_rproc.c
+++ b/drivers/remoteproc/ti_k3_r5f_rproc.c
@@ -855,7 +855,7 @@ static const struct k3_r5f_ip_data k3_data = {
 	.tcm_ecc_autoinit = false,
 };
 
-static const struct k3_r5f_ip_data j7200_data = {
+static const struct k3_r5f_ip_data j7200_j721s2_data = {
 	.tcm_is_double = true,
 	.tcm_ecc_autoinit = true,
 };
@@ -863,7 +863,8 @@ static const struct k3_r5f_ip_data j7200_data = {
 static const struct udevice_id k3_r5f_rproc_ids[] = {
 	{ .compatible = "ti,am654-r5f", .data = (ulong)&k3_data, },
 	{ .compatible = "ti,j721e-r5f", .data = (ulong)&k3_data, },
-	{ .compatible = "ti,j7200-r5f", .data = (ulong)&j7200_data, },
+	{ .compatible = "ti,j7200-r5f", .data = (ulong)&j7200_j721s2_data, },
+	{ .compatible = "ti,j721s2-r5f", .data = (ulong)&j7200_j721s2_data, },
 	{}
 };
 
@@ -901,6 +902,7 @@ static const struct udevice_id k3_r5fss_ids[] = {
 	{ .compatible = "ti,am654-r5fss"},
 	{ .compatible = "ti,j721e-r5fss"},
 	{ .compatible = "ti,j7200-r5fss"},
+	{ .compatible = "ti,j721s2-r5fss"},
 	{}
 };
 
-- 
2.34.1

