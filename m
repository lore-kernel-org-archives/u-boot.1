Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5187C48297
	for <u-boot@archiver.kernel.org>; Tue,  6 Feb 2024 12:22:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 744D587CCF;
	Tue,  6 Feb 2024 13:21:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="pe8+bkPz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E17D187CCD; Tue,  6 Feb 2024 13:21:34 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF27687C68
 for <u-boot@lists.denx.de>; Tue,  6 Feb 2024 13:21:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 416CLUBJ017318;
 Tue, 6 Feb 2024 06:21:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1707222090;
 bh=mBGWR1iriaq1+decHFsVOj0HRBhSMEsA3Ybpw2FuNpg=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=pe8+bkPzc4f/3pCxaEKHae9JimB6Ghnl8IL/yuTTaqjBFNipudbAFZciKEVBvlGiy
 XxzH9yRRMFSfI9OQqjaIGz2dYxg7jAXMPGH9cgpK8rDrqZAxghRwqPmUqqK9yKdfRG
 bS+Ig9+yGWDlhRa7cURp1KzPPK1STafdE/6fC4GM=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 416CLUEu096410
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 6 Feb 2024 06:21:30 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Feb 2024 06:21:30 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Feb 2024 06:21:30 -0600
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 416CLAi4081923;
 Tue, 6 Feb 2024 06:21:27 -0600
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Tue, 6 Feb 2024 17:51:12 +0530
Subject: [PATCH 05/10] drivers: misc: k3_avs: Add AVS Support for J721S2.
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240206-b4-upstream-j721s2-avs-v1-5-b75043c59969@ti.com>
References: <20240206-b4-upstream-j721s2-avs-v1-0-b75043c59969@ti.com>
In-Reply-To: <20240206-b4-upstream-j721s2-avs-v1-0-b75043c59969@ti.com>
To: Jaehoon Chung <jh80.chung@samsung.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Keerthy J
 <j-keerthy@ti.com>, Udit Kumar <u-kumar1@ti.com>, Aniket Limaye
 <a-limaye@ti.com>, Tom Rini <trini@konsulko.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707222070; l=1390;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=0kactDGQ4l0ZiOO9uoSCmnf2HEWkZ/ajhOzP3oTlrS0=;
 b=RTguPX/lFV7p36FZIUObwuuiG1k4XL+9ZNJUgI8arft51YnH11ZVhkAddBT28XNDg/jUVvcZl
 KgYsZV1HY2ECNy2WfSdy6uVXwifjYBbly90JaspFMpbSS0XHX1fyHjB
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

Add AVS Support for J721S2.

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 drivers/misc/k3_avs.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/misc/k3_avs.c b/drivers/misc/k3_avs.c
index e20dc6755c29..28e59fcf41d4 100644
--- a/drivers/misc/k3_avs.c
+++ b/drivers/misc/k3_avs.c
@@ -185,6 +185,22 @@ static struct vd_data j721e_vd_data[] = {
 	{ .id = -1 },
 };
 
+static struct vd_data j721s2_vd_data[] = {
+	{
+		.id = J721E_VDD_MPU,
+		.opp = AM6_OPP_NOM,
+		.dev_id = 202, /* J721S2_DEV_A72SS0_CORE0 */
+		.clk_id = 0, /* ARM clock */
+		.opps = {
+			[AM6_OPP_NOM] = {
+				.volt = 880000, /* TBD in DM */
+				.freq = 2000000000,
+			},
+		},
+	},
+	{ .id = -1 },
+};
+
 static struct vd_config j721e_vd_config = {
 	.efuse_xlate = am6_efuse_xlate,
 	.vds = j721e_vd_data,
@@ -195,10 +211,16 @@ static struct vd_config am654_vd_config = {
 	.vds = am654_vd_data,
 };
 
+static struct vd_config j721s2_vd_config = {
+	.efuse_xlate = am6_efuse_xlate,
+	.vds = j721s2_vd_data,
+};
+
 const struct soc_attr vtm_soc_list[] = {
 	{ .family = "AM65X", .data = (void *)&am654_vd_config },
 	{ .family = "J721E", .data = (void *)&j721e_vd_config },
 	{ .family = "J7200", .data = (void *)&j721e_vd_config },
+	{ .family = "J721S2", .data = (void *)&j721s2_vd_config },
 	{}
 };
 

-- 
2.43.0

