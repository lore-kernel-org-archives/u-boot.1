Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46773C02181
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 09:28:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D67C0807E5;
	Wed, 22 Jan 2025 10:28:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=vaisala.com header.i=@vaisala.com header.b="c6JN7Qm7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2194807E4; Wed, 22 Jan 2025 10:28:21 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20729.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::729])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD76080763
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 10:28:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Tapio.Reijonen@vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SMPwbAOSCw81ZirevRsK4GL/giPtDp6cQTKat7TgrVGW4LMqZLAnfT9J+PcV2AD+SfrOpMMu3MvrsEoSHFq0AzbPvMX6CJf7Mvx4/as1P7nwhqFLKuQA3tl6MAWi2Hdx0OqSFL/hSSkoGAKQDZqstO+J/LcG0xDH3Dt3osPDofY/6vvKSwLrTLzcsZm2NoTuwR7aO4kZGM2J/UtMvMqKwzMXyInJh7Wr3zOPTpxZ1zsapWT8HuXY/noZ3ylP2ZRLmGgWN0CUcGLyvWtlmvNxz4+SHgrqrbKqr/4D3R5+39C/IiDJra4VFLmcmG/9Xqe+EPSjAuXw16D4YL7fv0czPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JwdG6xXY6TrzsleJ/ltxeBfRQfwWMpYQryahGXJ6fcM=;
 b=QVEiOfq+WTjrxuIYPjvx480HcRprnmMKSV7MCU4cUhzJGsRC3jb0jodPa2Ywe6KPvrmLVM+rpRjBzN2xJwcdDhgFMfecawFtkTjpvDILMtYP00PMUIHHYDVOdkwSyNVQqF+1QL9evciseqdmGPsWnw94MS3qiXxKOPzsPhEqjL4byAdbV/fwn4z85tMx3W7FhumvOT2gdLpPQqcUWrbVWc5NmGWKd6yshavV3Ci7VajV0FecY8ZG9KqA0+Ac+hJipY5dl+rHE2OWhOfpmTckWb2IY5+HNt8rD85s4x5PUynlMEYMkmFnPQOxJgE1+GcS3QauDqjiBTKjdy4T25Xr/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JwdG6xXY6TrzsleJ/ltxeBfRQfwWMpYQryahGXJ6fcM=;
 b=c6JN7Qm7Ihlli63utr9YGnubIkd1YMZ+HK4hnuBQ5zp/l6FvXJZydIN/ct4TlG9JBe/UuexCEn4YhmjMOHaxL2npj0Qs7KXoVXqU5WByPXt/bH5kyDeuRyyoWrq0/EnA00Hn482zZ6t0TlOs9ppn4RSt4xlEs8t6Qj2+vP8g0MmSSeXzzTeLsm+nj370nZvOCRnhJg3PjFVckATDuPhTsb8QClQ1gYNfvQ8ynvL1tArZ+U3eHWyMIGWJZFGzmbWBmvg2rpGLgRb7gxHdFj5FPgAgeUldtoGrbfUFtXF3aANNvaUtycHgJv4p4ZT82aZGkIYnCJ6hBBCTXviX/Aqfzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from GVXPR06MB9065.eurprd06.prod.outlook.com (2603:10a6:150:11f::17)
 by PAWPR06MB8691.eurprd06.prod.outlook.com (2603:10a6:102:387::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Wed, 22 Jan
 2025 09:28:18 +0000
Received: from GVXPR06MB9065.eurprd06.prod.outlook.com
 ([fe80::7675:1098:3208:53e7]) by GVXPR06MB9065.eurprd06.prod.outlook.com
 ([fe80::7675:1098:3208:53e7%5]) with mapi id 15.20.8356.020; Wed, 22 Jan 2025
 09:28:18 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
To: u-boot@lists.denx.de
Cc: Tapio Reijonen <tapio.reijonen@vaisala.com>,
 Eugeniu Rosca <erosca@de.adit-jv.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jacky Chou <jacky_chou@aspeedtech.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>, Ramon Fried <rfried.dev@gmail.com>,
 T Karthik Reddy <t.karthik.reddy@xilinx.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 1/2] net: phy: Let gmiitorgmii converter create additional
 PHY
Date: Wed, 22 Jan 2025 09:22:49 +0000
Message-Id: <20250122092250.722356-2-tapio.reijonen@vaisala.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250122092250.722356-1-tapio.reijonen@vaisala.com>
References: <20250122092250.722356-1-tapio.reijonen@vaisala.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0048.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:9::29) To GVXPR06MB9065.eurprd06.prod.outlook.com
 (2603:10a6:150:11f::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR06MB9065:EE_|PAWPR06MB8691:EE_
X-MS-Office365-Filtering-Correlation-Id: 97f4f08d-02b0-4e51-e8e6-08dd3ac71aff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NHfidmT64z+jvMueKpPU/h2iEcF/nfxNMO5h2Fn2FcO20t7DY0kMCoSi31ge?=
 =?us-ascii?Q?zdAkKFHJTKzQzufyQX8/gc1F/G9TJD3PNygb+zdifyGCIyzBrBzww3/py3Tv?=
 =?us-ascii?Q?ms7LxgIuVrNRr5jl+Tmm8IFsgkGj9VQmzWyuhl2lPzk4HqiHPLGIRPyrnT8v?=
 =?us-ascii?Q?aE4Y60pvi9NOQ8h73hkfsiplXorx2wIqicte6mEPzLWDEmlQJYGDK0sxtoJN?=
 =?us-ascii?Q?JBmRyiwZSlfSZYZduFAFaXQKeF5VxB+DBzLAhtjLP9CzcSCyo4VFdE0UIMvE?=
 =?us-ascii?Q?p+0dfJbEzn2XOZERiDye9Gn+kalr65aJ48D0cdQAhgLZkbMy4Q3Vm5lA0yDB?=
 =?us-ascii?Q?nEn3KNjAhGM/oMDbSTV2OLsdCwdjGze3BNi1WBKurxRko9Z3Izaegb8RuztH?=
 =?us-ascii?Q?OwtE1xG1hY7oJEQBHIUelBKRimPKrrBtliF/+fmmNHUJlaSPtTMyFr4do7bN?=
 =?us-ascii?Q?fhfk+giVL+XTB0ePDaHeb5fK2NeIbSKWDP24HBNmnByM0F5kMDEiLXsORB6n?=
 =?us-ascii?Q?CcYcHchO5HmP+PZPAROk2Lyt2y2CB3vVJQo0sLBnnlc1i2VkJwz3typcdjA7?=
 =?us-ascii?Q?WpALs7qNOHdHO7DfRa7djtOXu+CJH5qT+qbPkVjEZvdnZbFyUA8lnl/gqMCB?=
 =?us-ascii?Q?0iGNT26RMGkH/qL6OX8EwMFh3cUrCnETEM5dW6JhLe907s+ENyF9V08WJ2+d?=
 =?us-ascii?Q?E2fmiiAswCn+64hd9cxLH2Kz0g9gUzIK+jU6bp3bjJjYoesy2JJFmQNXxcb4?=
 =?us-ascii?Q?/wyZdTDPMRxW14Ig6NwD63bLdU7DHIqD87W/SdpcRpzYHNf/996jTckjCyxA?=
 =?us-ascii?Q?zBF1w6c9qb1f2VtVPvgK1uBPDNkt4Qreqm6cDzdEkqD2fArGI69qucLIjRFo?=
 =?us-ascii?Q?3rBYLqq9ttK6aYHmu3KL5KJkKdgYi5sF8999pizvRTmuFzt7pmJyrNjTVMHF?=
 =?us-ascii?Q?eec+ZICbggBgPHAN0hn8gMXPece9KsR9s7QHNL8zJ7olZMdvOLrjM8ahk/1a?=
 =?us-ascii?Q?RQQWhEtc5aOrrdIwOxhLWms+WWv7QI3oZlv3gPzaLnhSwiusWPQHEIfD05bK?=
 =?us-ascii?Q?MV1ujygVgGWqPEMzc1NXzL5Ir/oQJ0nGVlSTRnH5IJ9SKILylGDTFNpc5JHe?=
 =?us-ascii?Q?Bo14AJEKrIrQLzqJvuBwu9O53DmptNo9untPybld6FcKlC1aEKY1us2LFzBE?=
 =?us-ascii?Q?iN38rmSA7evILz9F8/DBr9/21u7GF06lqc3jIZ03zKPBc5wiN7sCg41RvBgp?=
 =?us-ascii?Q?TJZYl0OodYuuK71TM04bgtUyP7WfN9Q/lb2ShrTaR9fFFw1vHpECpCqoqiC9?=
 =?us-ascii?Q?SO1Ur5C8FeIx6ZkbeP2o/TdrTnN3r1vzQatgv8nQFr+Nv3h+uAEDSCJ1qoPX?=
 =?us-ascii?Q?kKnWJ0E7TO6kHZTsUfKLe+tjbaybeLBxHkXCJCQPEUJta3Ietyqx8GSWwtzK?=
 =?us-ascii?Q?LvhLiVFTZA2Be3JYhCyel1K20Wlry8vt?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR06MB9065.eurprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?49y0zDyNtt7LzDKVk/u4CbQBnPJdI9oEOPcnVJ+uCwrS60ScFVkwpaaeH/M9?=
 =?us-ascii?Q?Kl4v1u9sHPRss5Ygsb8E0r+NO6VUKQyTulMwX9HC617YrUm7WdavpucrG2qc?=
 =?us-ascii?Q?hoXTYVIQxZMfUhJwjTW3azgD8c3qRHGuG3A7suTihJ+nr4v4Prb66Ey5vcAO?=
 =?us-ascii?Q?4ugIpWEHuCbowJLzs41KJfZbVG7j3zc2kHunrlS6ox5q2hDl4HuSNOfxc047?=
 =?us-ascii?Q?ji+9TKMjigL1u81qcqRp2RSa/7MpjSxLf4Kprhw16xUsrsdSeLR+Srmb5XfP?=
 =?us-ascii?Q?mVhjNzjyV/mHl0yVMOngbhOHQinvrdHQoPVAB9hpLbIsYwSzExF+jzp4q6mE?=
 =?us-ascii?Q?jL12gSlbFHtOiFREsH1gjhc3EmMQoFmBMqG92GZl2O+6aycx3Pzo3HlorKEf?=
 =?us-ascii?Q?0Pi9iRoPgMe+F9C/R9QDp1S9G6JzFUIPCAuHdq94ApcUG+wtGqel8nySPG59?=
 =?us-ascii?Q?Da/k4ani5h37mGWWqZuR40Q/T7zvgvvRWJ5J8XFMXBZkqkVLjwYIZSg+4eTy?=
 =?us-ascii?Q?J0d5WUZVtNy4nQ6Vy4aM5oSlphdA/UpbG++mg3NTO8jQZMswvIMxTfTzqaTP?=
 =?us-ascii?Q?AjgFgWfAlBBuOakpnmarARMhWyXyt9BnMw0lES6a8neq1RQs5lUKEQwkwyhZ?=
 =?us-ascii?Q?947EMASZZe0pp/pTm/1xv0Royld1dksIxBU+Rrrr8R/3FF9uSg4V+2pjUZLD?=
 =?us-ascii?Q?u+wrf1woTf7LR0pu5CCiBMz6qJ1Hpo+7PGzw1pXgPW+YF1xLVGA0FXB3mTeX?=
 =?us-ascii?Q?HWbAdJcWji645FjMdsY6t8LhNes4WhvhH5ufPRKf4zOae7/MVSN9NHilEirQ?=
 =?us-ascii?Q?M2zSOtq/us9/iYeY9fOf+5Ah2DQrtvZL9fHQ7IuMHbw0hFD8K5XenuldQfHG?=
 =?us-ascii?Q?c4kUY2be1lhgQy+65dUZkG5dERQ9FYakRrrOlqL/XFqFQndVTMzGxTS4Xd95?=
 =?us-ascii?Q?alpXKAeYIOyzdTnWRvRWHCY9sfqbpdA8J+SbsbxPOkOykj2F1528TFP8i93r?=
 =?us-ascii?Q?kRJR0/6vaoheA911+gkpFumXV+mqJl4RNsrJccyMUdiYYo9kyzPgJiWTy1ej?=
 =?us-ascii?Q?uoTsVT6AfY/Ra0JIIlRsE6trd4BsLQvEInq74/B709mdiZaegAO32UF1lSLW?=
 =?us-ascii?Q?C1ruuDSJFJgJmrrtKDCvHopKgle2WLcHtysaAbOt2F9nDfwqaAlWJzlxZy/F?=
 =?us-ascii?Q?3X/ZWoyk9X245I62TVdQyzelgE51XEU7PODsQoHBImbmpWFDfhT0ucqzU+Qx?=
 =?us-ascii?Q?0ulURnx8scKvd0u0T/Ez7i+P0nm//8FXNbbmDGewVUN2iuLfZ67YuBMeumNj?=
 =?us-ascii?Q?rJ9Ftn5hnQLstCAbUI9m97zrsBBlluRzJpnP5D3iFRFaqIm2vwfKS9YZJUZZ?=
 =?us-ascii?Q?9Vo0HhWPdA0b7Nee50kSGFJGmP9jsQ76hwUy9SAfnKByp0qnDbOqYZJ1C6up?=
 =?us-ascii?Q?Q/HGXUVdxrphT6elM+ogVSiqDmi7nKhx8GbFOBhSTQD+04xo6pv5vZFUq7nP?=
 =?us-ascii?Q?Jfi4+pXz+mLQU1Sq4JWYneD3Dl0xQbEkCInbHzZQOK4aJzekrMBMKMsHsPuG?=
 =?us-ascii?Q?+b4rzS/8dWEO6JhhbCX2ZeI9pHRgicXX2vHNQks2fG8nN0lneE8BGZLMOmmp?=
 =?us-ascii?Q?xQ=3D=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97f4f08d-02b0-4e51-e8e6-08dd3ac71aff
X-MS-Exchange-CrossTenant-AuthSource: GVXPR06MB9065.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 09:28:18.4097 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3c26u02zrxvHwsvZmlSQlx1tB83LTNMje8luJJK4D7rRZgOnghjwdi+M4ONgOPCQI4jiTlyy6J3vg0HHitqrB1XnQoYuGiEMEsUtE692Tp0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR06MB8691
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

Change the order to connect gmiitorgmii before PHY creation.
The gmiitorgmii create additional in DTS configured PHY during
it's configuration. This ensures, that converter sits between the
MAC and the external phy
MAC <==> GMII2RGMII <==> RGMII_PHY.

Fixes: a744a284e354 ("net: phy: Add support for ethernet-phy-id with gpio reset")
Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>

---

(no changes since v1)

---
 drivers/net/phy/phy.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 716a1d461115..740533adecac 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -939,14 +939,14 @@ struct phy_device *phy_connect(struct mii_dev *bus, int addr,
 		phydev = phy_device_create(bus, 0, PHY_NCSI_ID, false);
 #endif
 
-#ifdef CONFIG_PHY_ETHERNET_ID
+#ifdef CONFIG_PHY_XILINX_GMII2RGMII
 	if (!phydev)
-		phydev = phy_connect_phy_id(bus, dev, addr);
+		phydev = phy_connect_gmii2rgmii(bus, dev);
 #endif
 
-#ifdef CONFIG_PHY_XILINX_GMII2RGMII
+#ifdef CONFIG_PHY_ETHERNET_ID
 	if (!phydev)
-		phydev = phy_connect_gmii2rgmii(bus, dev);
+		phydev = phy_connect_phy_id(bus, dev, addr);
 #endif
 
 	if (!phydev)
-- 
2.39.5

