Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B6BECFA749
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 06:25:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B16788FF7;
	Fri,  4 Oct 2024 08:24:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="A9JTziis";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 669BB88CE5; Fri,  4 Oct 2024 08:24:52 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EBF589055
 for <u-boot@lists.denx.de>; Fri,  4 Oct 2024 08:24:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4946Omxq112746;
 Fri, 4 Oct 2024 01:24:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1728023088;
 bh=qZWhwrbzmj4gj4yDcqD2n2gkCzofyTgPfSA5LCLnX+A=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=A9JTziisNomnO95kUrUAFBp89nwRsg65ImSYVr/l3nmc8Fy3mSjZS4dGIQ46sQxa4
 G8BFTdoUHH31Yu4sKYMD83P2fjBJL4WQ9bsP+vwF+9QYX9bsDKCK4AlfbJ3WQHIy0D
 WRoGLPq5PmokGE7562Vz9NrWNK5soq7x1Oga3oKo=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4946Omg0116849
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 4 Oct 2024 01:24:48 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 4
 Oct 2024 01:24:48 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 4 Oct 2024 01:24:48 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4946OVZ1100112;
 Fri, 4 Oct 2024 01:24:45 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Fri, 4 Oct 2024 11:54:32 +0530
Subject: [PATCH v4 4/7] drivers: misc: k3_avs: Extract MPU clk and dev ID
 from DT
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241004-b4-upstream-j721s2-avs-v4-4-6d71c6bab9f4@ti.com>
References: <20241004-b4-upstream-j721s2-avs-v4-0-6d71c6bab9f4@ti.com>
In-Reply-To: <20241004-b4-upstream-j721s2-avs-v4-0-6d71c6bab9f4@ti.com>
To: Jaehoon Chung <jh80.chung@samsung.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Keerthy J
 <j-keerthy@ti.com>, Udit Kumar <u-kumar1@ti.com>, Aniket Limaye
 <a-limaye@ti.com>, Tom Rini <trini@konsulko.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728023071; l=2126;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=JbKIbs4M2o+7lxHqp29d7HgiWlF7MY+/rKkI8ot7NF4=;
 b=AUcEBmYieo++6DDdRVUd6P4VSXaknhCnr57E+UNGU3r8rN2RIkPmrF381+WF3mzPFsIa4OY8r
 HXjNpNayqNrA3jnLQvlLNG7+bAGkPqsuJJc6NbyibB+atacmCvoDcAA
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

Different devices have different MPU clk and dev ID. Currently it had
been hardcoded. Move it to DT based extraction.

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 drivers/misc/k3_avs.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/misc/k3_avs.c b/drivers/misc/k3_avs.c
index 66ad747f2dd8..99a18a109b7c 100644
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
@@ -367,6 +370,32 @@ static int k3_avs_probe(struct udevice *dev)
 		return -ENODEV;
 
 	for (vd = priv->vd_config->vds; vd->id >= 0; vd++) {
+		/* Get the clock and dev id for Jacinto platforms */
+		if (vd->id == J721E_VDD_MPU) {
+			node = ofnode_by_compatible(ofnode_null(), "ti,am654-rproc");
+			if (!ofnode_valid(node))
+				return -ENODEV;
+
+			i = ofnode_stringlist_search(node, "clock-names", "core");
+			if (i < 0)
+				return -ENODEV;
+
+			ret = ofnode_parse_phandle_with_args(node, "clocks",
+							     "#clock-cells",
+							     0, i,
+							     &phandle_args);
+			if (ret) {
+				printf("Couldn't get the clock node, ret = %d\n", ret);
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
@@ -463,6 +492,12 @@ static struct vd_data j721e_vd_data[] = {
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

