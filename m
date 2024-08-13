Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A7EEC52D7B
	for <u-boot@archiver.kernel.org>; Tue, 13 Aug 2024 06:11:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8ABC888997;
	Tue, 13 Aug 2024 08:11:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="AcFVum5Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDD48889BD; Tue, 13 Aug 2024 08:11:03 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8608888997
 for <u-boot@lists.denx.de>; Tue, 13 Aug 2024 08:11:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47D6AxsP042857;
 Tue, 13 Aug 2024 01:10:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1723529459;
 bh=QjpO9SabBjYQbvLr0M1jZkgloDqREJue5ZWN0wPq++o=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=AcFVum5YsTu3Z13SkIJ+vOiDYlK/B8+2brMoDMsUjYd/Lwg5+eygZDKrQm7KYSb6p
 raGuPAhnfvjyjwYo6IKhVm9Ct/BDQQ8GOOXQFPy7emPBKrDR+5dJ4WO42tQV60bYcO
 rh0xepYR7yPgGw2WeylKYLRf97RWFYCwWI0whfvk=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47D6AxND009042
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 13 Aug 2024 01:10:59 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 13
 Aug 2024 01:10:59 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 13 Aug 2024 01:10:59 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47D6AgHk016562;
 Tue, 13 Aug 2024 01:10:56 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Tue, 13 Aug 2024 11:40:44 +0530
Subject: [PATCH v3 4/7] drivers: misc: k3_avs: Extract MPU clk and dev ID
 from DT
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240813-b4-upstream-j721s2-avs-v3-4-5115d93cdeb2@ti.com>
References: <20240813-b4-upstream-j721s2-avs-v3-0-5115d93cdeb2@ti.com>
In-Reply-To: <20240813-b4-upstream-j721s2-avs-v3-0-5115d93cdeb2@ti.com>
To: Jaehoon Chung <jh80.chung@samsung.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Keerthy J
 <j-keerthy@ti.com>, Udit Kumar <u-kumar1@ti.com>, Aniket Limaye
 <a-limaye@ti.com>, Tom Rini <trini@konsulko.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723529443; l=2141;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=iDYRXKSE4WtXnOuUfLcDEEFmq1w/Gr+EFPV2OYoi4Qo=;
 b=eMhQAVZVK6D+C2rEGqoGA2tW01gTqHHiDpz5g8c/3OD7jlsnBK8PV/sInv7MqRHZZRqfE0zCM
 U5PLSiUQkOjBlPMia+n5IUql79FfXYpzev4IqRnR4nNzhVPonspCsey
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
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

Different devices have different MPU clk and dev ID. Currently it had
been hardcoded. Move it to DT based extraction.

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 drivers/misc/k3_avs.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/misc/k3_avs.c b/drivers/misc/k3_avs.c
index 568cf5b20d51..f94eee5b1c64 100644
--- a/drivers/misc/k3_avs.c
+++ b/drivers/misc/k3_avs.c
@@ -352,6 +352,9 @@ static int k3_avs_probe(struct udevice *dev)
 	struct k3_avs_privdata *priv;
 	struct vd_data *vd;
 	int ret;
+	ofnode node;
+	struct ofnode_phandle_args phandle_args;
+	int i = 0;
 
 	priv = dev_get_priv(dev);
 	priv->dev = dev;
@@ -367,6 +370,34 @@ static int k3_avs_probe(struct udevice *dev)
 		return -ENODEV;
 
 	for (vd = priv->vd_config->vds; vd->id >= 0; vd++) {
+		/* Get the clock and dev id for Jacinto platforms */
+		if (vd->id == J721E_VDD_MPU) {
+			node = ofnode_get_aliases_node("remoteproc1");
+			if (!ofnode_valid(node))
+				return -ENODEV;
+
+			i = ofnode_stringlist_search(node, "clock-names", "core");
+			if (i < 0)
+				return -ENODEV;
+
+			debug("%s: i: %d\n", __func__, i);
+
+			ret = ofnode_parse_phandle_with_args(node, "clocks",
+							     "#clock-cells",
+							     0, i,
+							     &phandle_args);
+			if (ret) {
+				printf("Couldn't get the clock node\n");
+				return ret;
+			}
+
+			vd->dev_id = phandle_args.args[0];
+			vd->clk_id = phandle_args.args[1];
+
+			debug("%s: MPU dev_id: %d, clk_id: %d", __func__,
+			      vd->dev_id, vd->clk_id);
+		}
+
 		if (!(readl(AM6_VTM_DEVINFO(vd->id)) &
 		      AM6_VTM_AVS0_SUPPORTED)) {
 			dev_warn(dev, "AVS-class 0 not supported for VD%d\n",
@@ -463,6 +494,12 @@ static struct vd_data j721e_vd_data[] = {
 	{
 		.id = J721E_VDD_MPU,
 		.opp = AM6_OPP_NOM,
+		/*
+		 * XXX: DEPRECATION WARNING: Around 2 u-boot versions
+		 *
+		 * These values will be picked up from DT, kept for backward
+		 * compatibility
+		 */
 		.dev_id = 202, /* J721E_DEV_A72SS0_CORE0 */
 		.clk_id = 2, /* ARM clock */
 		.opps = {

-- 
2.46.0

