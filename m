Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59E43CE7AEE
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 11:46:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90EAD83EF5;
	Fri, 14 Nov 2025 12:46:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="b8mr/nza";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AA7684081; Fri, 14 Nov 2025 12:46:08 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10A3083EE8
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 12:46:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a3iCsCsumtNbBX54tyLwkovF0garS7DwS9o7XW488Hfsv1wtqhgoM8gnfXV5W4SqEfJCKMJPHGzC3+8ZDUaU+qqeYq9xt7rZWMjj83Goq50YP8oL3jrNvQ1HP1j+03XATEtp/fs3vFCdAgVl42ULyrUGwofxbmx7WdtjMOH1xgp4XKyhDagvX8md4NMR4epAuXywfoqkYWUfglKF6PpYxtys2XePdsKJGG9WmMY6ZB5R81DHJle4sCSy2iaeEOjXhzigAixPsJHSe0UZHooyZGLp1B7sT2/ntHCu4ZqDxCRpoK4XsrMV0nVRQfOKb1XW4zpA2hSMIx8ZtzZIf7pplQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HnEHlGQlssO2eTxfJsceMG3ldnBw14Cw289m7uGE9j0=;
 b=dyxgXtXHq6GGYLXnOsigTw7HO82hcgFy9dVs0c0NevHzg7qpQnE3Dp2aem82FIeowKEz7/gdF0gyha6lrcKwyOUKitGqtXpzzhNzC4fyQd8xF41XOqcI+xhjiltBHRRd3v0b41wO0TZyLcjZFwudwrKNRzDwuM89po3GDJzysa8hlqVKHvNNcL9P2qsW0bgdhRWVNdVRXSRqVY7Cb+XBl0vQS76zAED9oGd21HwTJ7XPfSnTKjPL12SSyDOItW4kNjvGLC3d7hTfGcME0UChmBN43o/Q1t/7fRicIOiuHCbbNclfn8FBRGRLMLYquBU0s+MPTBBn3NikWDkEVo6bfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HnEHlGQlssO2eTxfJsceMG3ldnBw14Cw289m7uGE9j0=;
 b=b8mr/nzamXCoIyD2QR9/nPCWDc8QZsSulbgkTwwMKaWIHBnD8AXtuysCxFDj7MZIUNplHCVIus0moTyL2L3Cw0/lx21ryqrMzz1kxhZxZI4tTDtHbKyqhSKAyIF+knu89v69soXsR6n7HetORU6iRn/4XAquPxDUPb/sybNkpiU=
Received: from SN6PR16CA0069.namprd16.prod.outlook.com (2603:10b6:805:ca::46)
 by SJ2PR10MB7785.namprd10.prod.outlook.com (2603:10b6:a03:56b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 11:46:01 +0000
Received: from SN1PEPF00036F3F.namprd05.prod.outlook.com
 (2603:10b6:805:ca:cafe::31) by SN6PR16CA0069.outlook.office365.com
 (2603:10b6:805:ca::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.18 via Frontend Transport; Fri,
 14 Nov 2025 11:46:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SN1PEPF00036F3F.mail.protection.outlook.com (10.167.248.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Fri, 14 Nov 2025 11:46:01 +0000
Received: from DLEE202.ent.ti.com (157.170.170.77) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 14 Nov
 2025 05:45:59 -0600
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 14 Nov
 2025 05:45:58 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 14 Nov 2025 05:45:58 -0600
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AEBjtfx1972612;
 Fri, 14 Nov 2025 05:45:55 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <jh80.chung@samsung.com>, <peng.fan@nxp.com>,
 <afd@ti.com>, <u-kumar1@ti.com>, <m-chawdhry@ti.com>, <t-kristo@ti.com>
CC: <h-salunke@ti.com>, <u-boot@lists.denx.de>, <srk@ti.com>,
 <s-vadapalli@ti.com>
Subject: [PATCH] power: domain: ti: fix ti_pd_get() to return after verifying
 transition
Date: Fri, 14 Nov 2025 17:16:10 +0530
Message-ID: <20251114114611.57032-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3F:EE_|SJ2PR10MB7785:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c648e34-61b1-4488-490b-08de2373627b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gEnBXFVAKmTsCNwc1ZWWVQLsmiVFKqv46iylbyFKCcZ85rDduUcZaN0gDPVb?=
 =?us-ascii?Q?psMcTa15IptX7PoGT0IAiDjvuqybiKVAuX8TPr3MVD9ZUP4Qi37KcXapFrvW?=
 =?us-ascii?Q?ONb1wqT5DGlR44HyK5/8qBan7Csn4fl/i/Kj2/8+HFOCFVfpm4k/XZQeVPe0?=
 =?us-ascii?Q?edfuepbxrJIEne+W5TeDVyaqqd8IlQfxUIgwtUKJ3dJ3rdfe+yzD7Lb72lt9?=
 =?us-ascii?Q?7cH8zQEBxKoSZCCW4FZuJqK8OKFvcuxF1paBVJUHYoLMJFyuBCZ/VsxKEU1w?=
 =?us-ascii?Q?0dgsABaH18nnbHkMdhLoHAkOeNC8jqLBPIFMInpg4BkGSoSIKQEJQ0Sf/n2v?=
 =?us-ascii?Q?RwD7aTo7eI1jZWBA4BhLXnxHPDYGAKViVdeoH3XXer2dht3/7ORKGIdlcEfN?=
 =?us-ascii?Q?Gp1jbwhhW9Yo3q81lmL/kmh+xmMNMp3pYHaLAAUKwB0DNia0/oupluprx1zi?=
 =?us-ascii?Q?VrSNEJQNIjD/Fdy8yamU9GEwNkOEiq9GBNhu7Z+NNtJvVwa4fnfLcDNEUpqT?=
 =?us-ascii?Q?MdgyPz/1rRGcZjH1JM1t1rKU90VPavOymrNNT1jJH3xj8PcUvlJzuZE5S+2z?=
 =?us-ascii?Q?DTkIzEUDCSmtmTgsTD6LuBU8Q6rlp/VSWWR98b16JeYx1nXW2Bm6C22LXu7K?=
 =?us-ascii?Q?VJvn+5gVJ7MgkuLq2qdkGfTHuqCyp227tb288gTKYFZj+zpCy9XmwTfKv5jI?=
 =?us-ascii?Q?+D9s3XfXVH5+RCT95b+Q8g3jZtZwPYJJaA3Hdr4RCohDEaKVkBSesus69Vmh?=
 =?us-ascii?Q?UduJlGG6kbebG2U62lDoElkSSUBFjIpWiOI2+f9S8Wr+eEkHArEaZHqi0WJL?=
 =?us-ascii?Q?i9lKApvsFJS5+PgiIL990LYnFKA7FPQlcKBVDFNR0rzK10DdPf3N/epvIHk+?=
 =?us-ascii?Q?yAsY8mpMGDbKplGqYfowAsrd+laiusD3xOXLj6rImA7bINiSGPEvPxi7Qi05?=
 =?us-ascii?Q?47SyM7amZ+oAGq2O0D4wW8F0O9j3L1aEjim8pjCoTG7J6raD89O1XrFZ5cpo?=
 =?us-ascii?Q?FWA9FZJJ37MQMn8+RE/x+Qc6WpcjfXdTvh2N2s+l4FOnPsmIro8dr/ETm4j+?=
 =?us-ascii?Q?UF5qPHmhZC6AhEk7MM5wbN+pa8TMmKWz4AeGgmrbuuW1D05cRYp8MKOpgMnf?=
 =?us-ascii?Q?oud/A/9sslmb1fZSmB9A1EK7qKp1rSyTePe81yQpXNplJ+kvrTWsW5iQ+bcO?=
 =?us-ascii?Q?rfGAiU2cP6gDgkbzRR0gPoJb+1ueXSd8/jHWiU1npxkcocsuYoMlZ8uAShxY?=
 =?us-ascii?Q?4YKMlDX/CvDmDr7Z1uisEj2ZeuRW1dz0Ngldb2jDx59k8i6tmk1D7Cs9FPnD?=
 =?us-ascii?Q?Z8MOZZV3zlgXdnZl9ax3HwhrGMV7FQd6VmHg5GtsppuPD7CADQieSpEWjQcF?=
 =?us-ascii?Q?0miWEbYjr0pW0W8OiXB4ssQb27lnFcd9RvzKv9EWF6eVlAqCJgw0DNhxfmBD?=
 =?us-ascii?Q?RDO5vCJLse2iOlEd/b8GNuDCTHh7KfJz5k3Ve4uojloIp5JDhkIHt1BNb2UD?=
 =?us-ascii?Q?oCjJ61/Lbm0Bv9ANSADnOBvCjjWkk9w1RyEg4/3yPuUL+Ara2TIFW2Jy6eG2?=
 =?us-ascii?Q?HcmTSl5uJzILQqdgtMY=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 11:46:01.3171 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c648e34-61b1-4488-490b-08de2373627b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7785
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

The helper function "ti_pd_get()" is responsible for powering on a
domain if it is powered off. In the current implementation, if a power
domain is determined to be powered off - no prior users and the PDCTL
register indicates that the user desired state is OFF, then powering on
the domain constitutes setting 'PDCTL_STATE_ON' field of the PDCTL
register.

While the current implementation indeed requests the power domain to be
transition to the ON state, the helper function "ti_pd_get()" doesn't
verify that the power domain has 'transitioned' to the ON state before
returning to its caller. As a result, it is possible that the device(s)
belonging to the power domain may be accessed before it is truly powered
on, leading to a bus abort.

Fix this by waiting for the power domain to transition to the ON state
before returning from "ti_pd_get()".

Fixes: 144464bd2c67 ("power: domain: Introduce driver for raw TI K3 PDs")
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

Hello,

This patch is based on commit
6c2f2d9aa63 Merge branch 'master' of git://source.denx.de/u-boot-usb
of the master branch of Mainline U-Boot.

Regards,
Siddharth.

 drivers/power/domain/ti-power-domain.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/power/domain/ti-power-domain.c b/drivers/power/domain/ti-power-domain.c
index c3519307340..8f43d0fed30 100644
--- a/drivers/power/domain/ti-power-domain.c
+++ b/drivers/power/domain/ti-power-domain.c
@@ -227,6 +227,10 @@ static int ti_pd_get(struct ti_pd *pd)
 
 	pd_write(pdctl, pd, PSC_PDCTL);
 
+	ret = ti_pd_wait(psc_pd);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
-- 
2.51.1

