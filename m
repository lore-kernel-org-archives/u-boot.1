Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAEA3D3B7D3
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 04:12:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7CBA899F0;
	Mon, 25 Nov 2024 05:12:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nYBK5BR/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F299D899FC; Mon, 25 Nov 2024 05:12:48 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::607])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F24E890B9
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 05:12:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ciheohvXUf/VXafLg4Ijz24gis8o/b1bcuLw7J0/dJr4Uo6TP09NRn+/c+ghfJxPkS2wmDfAvNWkltv4ZNKZS56O3HKYxafp0FID/a90TdFn/I5JgqHpIL9brxdxseqJiH1Vy3/RhoP8KANrOdLWB7qI6IwZW4dcdo8LsEkpJmxGVfx8qjHv4bFvghG3LnUtn26UtFhUAQC8HyU/fqZoeJSPfIM3yvJakBNOI8fAXArbTq/cd9gq3G4xgLMQyBCd4ag3UY7Thg5eRdn6HTKSUg4q8+hK2yADO9pgN2PIU0723p0DJGKyiPR989Zq3SfOTNdW20ysBJ/Mtp6BBLuLgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sHQlQ9oRO5xC2gvZGBzNkgQ8IgxqL81IfTHZKS9oLSI=;
 b=xUpXWxAV/b1kSuN8tt+Os5J1YQXVBnNhlCuFMOg6J4QQvxDVKZluKmuyz128mz0aKJ2gdIoMZSp/QhRTnTg6Qm6e9PjYnH9uA6ZUPUWgrTUnxTUeqHa2bI3URdTgQ2a0UBYOPBXQkyGzA/iSdjWNKLK+MMi/Du3rC3KXTkOTAsrCiQNIdyXvfhSAy+IrZaR5OD3vzIEYpigMFRl/iDwTB9wIT+OzniMNsnf84ecZrSkh+L0RbYDGW3NzBTJ95BqwdInHHF2VF4sk0JUSlVIyQT4sLGMBZNTNPRfGV9AyEw0BAyD0dzvLJXS2OaPJbdM7c4yO92VXzS86pGhtF66Fsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sHQlQ9oRO5xC2gvZGBzNkgQ8IgxqL81IfTHZKS9oLSI=;
 b=nYBK5BR/urqryHYVP68FZ31WTXZBeYVmabcc1zMXqabjS2ZCsrfk3Ic43HjHpsPPKrHaI59A9IYt4RseLADEpFO/vpJQDwtoR1rVQTXLQY/4Y/5mBjk9fkY5Q8H7Axno3Ns/xyVc+FKrkGrxDBEgewHDMF/tn3PPqT02GJrccUA=
Received: from CY5PR15CA0165.namprd15.prod.outlook.com (2603:10b6:930:81::7)
 by MN2PR12MB4302.namprd12.prod.outlook.com (2603:10b6:208:1de::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.18; Mon, 25 Nov
 2024 04:12:41 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:930:81:cafe::62) by CY5PR15CA0165.outlook.office365.com
 (2603:10b6:930:81::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21 via Frontend
 Transport; Mon, 25 Nov 2024 04:12:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Mon, 25 Nov 2024 04:12:40 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 24 Nov
 2024 22:12:39 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 24 Nov
 2024 22:12:38 -0600
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Sun, 24 Nov 2024 22:12:37 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v14 5/5] usb: onboard-hub: Bail out if peer hub is already
 probed
Date: Mon, 25 Nov 2024 09:42:02 +0530
Message-ID: <20241125041202.980-6-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241125041202.980-1-venkatesh.abbarapu@amd.com>
References: <20241125041202.980-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|MN2PR12MB4302:EE_
X-MS-Office365-Filtering-Correlation-Id: bee22160-869d-4a3b-454c-08dd0d076765
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qV5AY7rLYy5sbOdr/bBozozMksjeMqSvcvEyYwSii+ceDzGh/LwSAokSEGyq?=
 =?us-ascii?Q?Kr4ZxuMw4cJDqwsgbspvlgNKgFka2p+2zGsFlEREvdCBrmBxDk3I/1TSlJZw?=
 =?us-ascii?Q?GspHqOBz0TmhY+2TyR4GsHbN2vrnP5PXRhjtVjQylLSo8yv6F/d53ND7amdI?=
 =?us-ascii?Q?8Kr+kzUj20xy0tQxu7Ah/FYzl999SAYbLCa3DIzHEoQfmEaR4vCo0hOL8jdi?=
 =?us-ascii?Q?kZmTJNKPbWclKHc8HpuMExAJK1BLV5VXawkkhwoEEutx+awasx+WUl8yXYPD?=
 =?us-ascii?Q?/wSqKrJaYENfLYJx7FlIHFLFGr4o9YYLsp58LowGOPgq/QqrIShz4dR9fJWI?=
 =?us-ascii?Q?K8FOCAf+Oi/+V4civ4W6m0MtxPEgdNF94U1SO7J8D1UaThjpv0NwsFIjwqhU?=
 =?us-ascii?Q?dx/WhITkNm7AL03grctSJlY7rtkxtdH3rV/TR19WE/rbizi1lZxW8AvrKBg6?=
 =?us-ascii?Q?yCf3vWqCuOPRO0wFo1SceTcT7Mzb0LmE12BIj8yjWxmecJ9Fv4L9feRlNYdD?=
 =?us-ascii?Q?evvMC4YFgyf4Tykxen28FyYZHPJsTwGW7SriXazuniU8z5MkW4o/0tjmk9J8?=
 =?us-ascii?Q?zbFlzSuw3dCoN19Xe4v4uqxErC9C1W4aXVDYGiMjeB3aHVPpGeSe4Dis1UYc?=
 =?us-ascii?Q?ejl2yUfoZoIkM1Fe9uRNsPgmBfWu8ypXP2qt04YCkS5II+zdY1JpWoBkj4Vh?=
 =?us-ascii?Q?GvXtExBzPM6NqHTUmVazllGKTc/AL1unZsKTmhpQ7oEQpMmRREO+yFMYAxrZ?=
 =?us-ascii?Q?f8fT0YA+YHvQw5FeoBoDligt6wavARF96Oznhk8ZYISVx0BWnIB42exJR2et?=
 =?us-ascii?Q?bEU4M0dxoREpT4gJfNP672CINQci4zcj8MPdonofU7RJ+yI6m8dXPetXARw7?=
 =?us-ascii?Q?hK8/NA+H/bLWZQ10yYxchgTmyp9aDbHUlxp7tKh9AjRB/7XZeakqM5ad+mAy?=
 =?us-ascii?Q?V5mqbcoDsomNW9Du10/MFZHNc5NhPVsm1GEj5W0+Jo9IcQpVfkKyLIe6C3nP?=
 =?us-ascii?Q?gSycFt0ih3IBN4Ia+X3JDPzKI41rMxwMWMd/88oqDQNvyjmC2HveQaxRfzCN?=
 =?us-ascii?Q?XpI69bfv2hGwrqg1TLzbW1prnTw0sLLGzQXS7MTaiN0sBqTUe/XQXM5yH3Xb?=
 =?us-ascii?Q?mDgYWp1ito/4xIxp/z9zi0lH78paaFXX/m2EHAbyfbWtL0M7Ka1Z/FSDEl/a?=
 =?us-ascii?Q?rw9UzurswhidM64XGjJr+VwuaJaPKxf6FVTTvny22guG6ENRNpKLJAlXSNV9?=
 =?us-ascii?Q?dVwQqR8wlh2ZZnwxvw6J07ydx15wO97XTsqKnH9F8gixTju5Q3LWsgTXxxor?=
 =?us-ascii?Q?c20dUBZVbwswVX1+KCfJM6q5629J10/bkr3curU8oi2v4lV+7zolybaJJqEo?=
 =?us-ascii?Q?kpYBL5kQXe1GvlvI7cy9s34DQD5Ki/AdUH7ql5MisbRMR4pmDiN6zsfMdE9/?=
 =?us-ascii?Q?gFwzpz8RBpPLY2XJbkmzit8xPZOaW6eA?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 04:12:40.5381 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bee22160-869d-4a3b-454c-08dd0d076765
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4302
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

The .bind function is implemented to bind the correct
"half" of the hub that the driver wants to bind,
and returning -ENODEV for the other "half".

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Reviewed-by: Marek Vasut <marex@denx.de>
---
 common/usb_onboard_hub.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
index bf71266272..6f28036e09 100644
--- a/common/usb_onboard_hub.c
+++ b/common/usb_onboard_hub.c
@@ -176,6 +176,26 @@ err:
 	return ret;
 }
 
+static int usb_onboard_hub_bind(struct udevice *dev)
+{
+	struct ofnode_phandle_args phandle;
+	const void *fdt = gd->fdt_blob;
+	int ret, off;
+
+	ret = dev_read_phandle_with_args(dev, "peer-hub", NULL, 0, 0, &phandle);
+	if (ret)  {
+		dev_err(dev, "peer-hub not specified\n");
+		return ret;
+	}
+
+	off = ofnode_to_offset(phandle.node);
+	ret = fdt_node_check_compatible(fdt, off, "usb424,5744");
+	if (!ret)
+		return 0;
+
+	return -ENODEV;
+}
+
 static int usb_onboard_hub_remove(struct udevice *dev)
 {
 	struct onboard_hub *hub = dev_get_priv(dev);
@@ -218,6 +238,7 @@ static const struct udevice_id usb_onboard_hub_ids[] = {
 U_BOOT_DRIVER(usb_onboard_hub) = {
 	.name	= "usb_onboard_hub",
 	.id	= UCLASS_USB_HUB,
+	.bind   = usb_onboard_hub_bind,
 	.probe = usb_onboard_hub_probe,
 	.remove = usb_onboard_hub_remove,
 	.of_match = usb_onboard_hub_ids,
-- 
2.25.1

