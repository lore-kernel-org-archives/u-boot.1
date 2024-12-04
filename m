Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 100E3E7716B
	for <u-boot@archiver.kernel.org>; Wed,  4 Dec 2024 04:40:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4704988EA3;
	Wed,  4 Dec 2024 05:40:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XzuLIqL+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C86788EA3; Wed,  4 Dec 2024 05:40:24 +0100 (CET)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2408::610])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD30288EAF
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 05:40:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IPlCsUDKzZjmMqTCFoDqg4s4SfMtc9dCBDrr50MhR/y2yii6T+baTaA9xCkX7su8D+jAqjKy23f/7pjn8I8+u0n4QWnB1wqECz3nMY4Oh/YyCfwEJLq+3fO/tXf6lEWzqMtYO610uOnwxxPbRSEDvnQsUyE257j3fBDLGIlwnR02wnZ45DNEDlAE1MNDDLZuuEKIXcLU7TuzpX6kPAWlZCB/XLwvo5wXsoxw1696ChDsJePJGRseCUOD8hghoSE/yo1fWv3nOcK8UEzABEv+NgFVsBUtH5R/talX5MUYpp0jTfAIx//HqhO7kMyol2hS9aoua3VuUyoMqaUaCOaCoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yBH1flK1vdcrOvU82U+c7rQ6cvnggJ1IT4z0R6IPYm8=;
 b=H1JyNPvbu8A9ehYjnCd1BB7vUuzWpSZuidtz0sf1TVhaD//O4pSs0e9gfKGvdc38L5hGekzlXfefppz6n9VVM3cZIruj0sGmTEOc1lKVag53flesD5g2Nzm1dROcahiNccSsYR6w9xmkfcWsnIlb0hscPXmEBe7r38oU291dsQ9be7a+DgIIH0qIHPypV+umwVjAC7DRwfqFLpkN/CqVJtoGo24EG46kH5WUzK/iiuFFA1LrupG6bD8UxPjelXygthi7ZCs6hrRKbGajbDkVVmzQYNJNnuiX5aZkDanv1AfBa3tDV9b90+eopJtrx+J4+GaLZQoAb7T5ZOAtTdtTUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yBH1flK1vdcrOvU82U+c7rQ6cvnggJ1IT4z0R6IPYm8=;
 b=XzuLIqL+gwVekNnUkfwRvI+V8ZUvV9jnKIB/KHLUC7HQudA15LY2s/UBGW2cQDqg+DD+Xirlny4kJI5DrgG1tdlzd9T4CHTr5AYCuyXPWSf+jO1JXBhzmY93kWCW0zB71mU0YFff3qhEGL7O91fIniZQBogB1l7switaFI9gd9I=
Received: from CH2PR10CA0019.namprd10.prod.outlook.com (2603:10b6:610:4c::29)
 by IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Wed, 4 Dec
 2024 04:40:16 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:610:4c:cafe::db) by CH2PR10CA0019.outlook.office365.com
 (2603:10b6:610:4c::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.10 via Frontend Transport; Wed,
 4 Dec 2024 04:40:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Wed, 4 Dec 2024 04:40:16 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Dec
 2024 22:40:12 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Dec
 2024 22:39:16 -0600
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 3 Dec 2024 22:39:15 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v2] usb: onboard-hub: Update the bind function based on
 peer-hub property
Date: Wed, 4 Dec 2024 10:09:08 +0530
Message-ID: <20241204043908.186431-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|IA1PR12MB6604:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e0fa5a6-918b-4d9a-769d-08dd141dbfda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?r8OoXZmC0rO2YLWf9ECWQlUiBwatqioFopjxZCTTby2hB9TISxbe8u5i0ZMn?=
 =?us-ascii?Q?yFzPV3ioDlhn2EpSQTg0TTImOXedQNCxNviFEEElVtlju9YufZCbNAeXpBUT?=
 =?us-ascii?Q?V0PVniC7K81qrcyhimaYmAi/YbHI2euQvj59eNAQn6F2pF3txACC//zwBxV0?=
 =?us-ascii?Q?CWRPjJD9T6ownjnx4W7NvvGEdalfXd9w/75ehqeLVE5YO4ZiWamB5yDfURCI?=
 =?us-ascii?Q?NLPfyOGsFtczibIwIfowkyh3a0yBdFNQQDd62eiZBPTUH45Ql2M8pUL23X6y?=
 =?us-ascii?Q?m2BtXzRSSRaIg9Fd3y1DMRsYOm+papN5biwM22F258WAgy7OFCaJ3fXTNqId?=
 =?us-ascii?Q?od/7cUALHf+NCcmGDKi12+RihLnTY2oVxvFurqYfCEgdaHsCKzJJXvPqWV3m?=
 =?us-ascii?Q?wdzY8T7OyJyK3KxEC5HNdbTHOEEFHUNpvADRU7Mi/kLAKMWcBgEQ+AaUjew3?=
 =?us-ascii?Q?ho6KsSGLlC6wApGEblGha1gA+7tfVEoLpCEGvfxOzJkZz0FZnMvZUPX2n8z6?=
 =?us-ascii?Q?Wxe1HQiKceUe6KxJHShniFLkECSUVIzIdPUPK81c95hXvQI1vT2Szjp4ehMI?=
 =?us-ascii?Q?1/Jp1bwMpCPTZpFfdbZ0Q2wBeOV+1DM2ylftaPx2Ca9Bq/TGvyneELNpWdM1?=
 =?us-ascii?Q?oj6FsqFIovtj+PIw3i3+P4JwJkZkPSeMDN5huY/vJ73gfbMAXOSOY1BvVNGK?=
 =?us-ascii?Q?V7SPdO7yHY7ICsKoJAYzH9BAPPT34hqzA20oVfLLn2/20rTLoTtZnZaTsJRh?=
 =?us-ascii?Q?Ka/3pX/uZ7Fljr6RBNgUoWViEYHZMCI2entgVUH/sb19K88ymEAfwanpsAPp?=
 =?us-ascii?Q?vHn708aIIGISK9k8KxEoFmzO333GSo61MRy2PK9H+hLkrIHJy1W0Iw/XbO3w?=
 =?us-ascii?Q?M2EpzRcbz4ItQtKVPc1u6qTKAiiZXbUOD7CQq+sT6mLoJWprFjb8XD6LhWuA?=
 =?us-ascii?Q?Eunps/DT6dyKQafDGMv/y+Egb+6nmX39A02eItyvNuUnCrlcmox1/gPHob+E?=
 =?us-ascii?Q?hcS6xME62bhmZokEhshXYVgV48E81krbKCAoVb8FCIli+oadbWphaLboUX6L?=
 =?us-ascii?Q?iDI/vQzthecKwfyKV8B1UM2jLZtn+mItm0BlHNRkQqhDvDx0p9lZvcOs7DJ5?=
 =?us-ascii?Q?Zgk8gOrWXFeJLxpmLYgFakufySfIRrpm1BkqIdKTBRbUJcBA3tik3V1cXpCl?=
 =?us-ascii?Q?Kp0F7VQFTI5RvFQJ3nkRziV66mXLUdS/lsCniMQtDrrmpXuPYeq3Udmy4ByZ?=
 =?us-ascii?Q?Ams42CuaNzmF89ipd9wTuX1vD+u1jAx7qWdCh+pqb93cKxF2nro7xKIe9vh/?=
 =?us-ascii?Q?/w6bO8C7ZpUqPG14HRL7Y1S+Bw7GplphAgux2Z5MCcIOkwhkzvB1fS5VHLM+?=
 =?us-ascii?Q?m6JAObPDNuGSfEb5neQgN4TzfJTtcEb3Wc6DyxhBSxf7BFWB9PriNmGFd5MN?=
 =?us-ascii?Q?zrFy1yefoJ20G0Z8q5rF/2uuvAnJWO2P?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 04:40:16.0913 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e0fa5a6-918b-4d9a-769d-08dd141dbfda
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6604
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

As the "peer-hub" property is optional, don't error out just
skip the bind function.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
Changes in v2:
- Removed the peer_hub variable and used the return value.
---
 common/usb_onboard_hub.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
index 6f28036e09..be83f168e1 100644
--- a/common/usb_onboard_hub.c
+++ b/common/usb_onboard_hub.c
@@ -183,7 +183,11 @@ static int usb_onboard_hub_bind(struct udevice *dev)
 	int ret, off;
 
 	ret = dev_read_phandle_with_args(dev, "peer-hub", NULL, 0, 0, &phandle);
-	if (ret)  {
+
+	if (ret == -ENOENT) {
+		dev_dbg(dev, "peer-hub property not present\n");
+		return 0;
+	} else if (ret) {
 		dev_err(dev, "peer-hub not specified\n");
 		return ret;
 	}
-- 
2.34.1

