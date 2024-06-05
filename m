Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24C84C27C53
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 10:03:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92BB1882E2;
	Wed,  5 Jun 2024 12:02:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="36lHQTBs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CC038836D; Wed,  5 Jun 2024 12:02:43 +0200 (CEST)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2409::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BD5588379
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 12:02:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SfXFleHWr8JeQ/1RO84kwngdn1zhG+VUufCf9o37L/dZtKEmya9OGsjZ6odpDBIot8HmUMVpErQ7WDOSEz/DZiUMgd+TQ24ohGz4dRUTQ6c40qLriunkdSPZqjHRN0LaC/R5+K1AfLMLQ/uViwpF/wqxu10gvWDFcDECAtHAjBeK6wUZr36t+v83Tx9Fq2Bg+WAMztH3fIj3kQgNGo///kuDdyKAak5T1AMpLOdVD1FOcBP/6hXqA5Ol1v3EOwKUILCjEEIgHldNgUWpfU/9Ex/A23CfG7QDea9zEVQ1X5hJ8Qi06SC8GAg+NGtWVm88yM/3DqBj4NM3M+mZYH82QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vUrDmZ5Timj+4hwhxJLHNi4exxDIsnHiwFbBk7wO9zA=;
 b=ap0mgwNWj5ncs+pAPQ4m3Un3uiYDfUGnaDMnOgdGpJwPIQnBOY2DO5wE5xzwr/sxbTyfiFhOuZAJsrSM03Ct+p6L/EjWuFgN7+2hRY70AlqajXALx2qdxYAalF6IG6G7XJ4XQfBcfga4DUC9aLCrz70ftksQqXn8ZUnNJujCved8gVtrAvOM123OyfSPObwAM5gNqmPLygj1AWEmJv22R+aQxmudTign65MDFhdLAE+0B1rGcVVXMK7IajFm7+oMnpYgBescTiBAzcx93xDhgm3c6FtoghEY3oCWmpPBTT29rMH5BAG9xFfk455Z0d3aQT/C9UDEAGFwsa3ZcGKiaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vUrDmZ5Timj+4hwhxJLHNi4exxDIsnHiwFbBk7wO9zA=;
 b=36lHQTBsbwJAWDjWXelgAzxjCWLZSEjjm+qpjxFb5l3Z0HQnIU1aBj+NsnFMtvvBiCMwxXNzVkOoHFGk7nKLcpR3oxAXDYgmDyFHwWTUWZ/3N8eAbbQqeWqtIrEV0QEOF8QnXrYUeaYXWm2/MJeEvJnBnPkW7kxc43ZJHQVngUU=
Received: from DS7PR03CA0064.namprd03.prod.outlook.com (2603:10b6:5:3bb::9) by
 DM4PR12MB7624.namprd12.prod.outlook.com (2603:10b6:8:107::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.31; Wed, 5 Jun 2024 10:02:38 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:5:3bb:cafe::1c) by DS7PR03CA0064.outlook.office365.com
 (2603:10b6:5:3bb::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.16 via Frontend
 Transport; Wed, 5 Jun 2024 10:02:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Wed, 5 Jun 2024 10:02:37 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 5 Jun
 2024 05:02:37 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 5 Jun
 2024 05:02:36 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Wed, 5 Jun 2024 05:02:34 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH 3/7] usb: onboard-hub: add support for Microchip USB5744
Date: Wed, 5 Jun 2024 15:32:17 +0530
Message-ID: <20240605100221.3571-4-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240605100221.3571-1-venkatesh.abbarapu@amd.com>
References: <20240605100221.3571-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|DM4PR12MB7624:EE_
X-MS-Office365-Filtering-Correlation-Id: 17ec82e4-ebc8-495a-a659-08dc8546a145
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|36860700004|1800799015|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ce0g+WRaJtMgFRXR8RUtPE6xHdi2e7WG7usso9MsJ217dgI4q7iLhS2TwtqO?=
 =?us-ascii?Q?6EevbfNY5FAzt5gic6272cKyS0Xxbu3HWnHdpu61Fu1MqbJ1rtQ4IU0nmqPR?=
 =?us-ascii?Q?x4XzKO9TmLbv4TBarSzd7BoR2lsmwtb+g/gF8pj6nckfeG6P2/X/5WiZVwYW?=
 =?us-ascii?Q?Ct+uZ16hBqRx+U6fidhPAeYDDo6o2leiu2ciLZtnXbJQ9dBwSapUS2ElDm1z?=
 =?us-ascii?Q?8io3y3lbtzVtf2gjNHWK2SQ3Frkk+iI2dWXNXgRKf1a1ousGvRzM9mB7wCz1?=
 =?us-ascii?Q?GJw2k/oF/5zGlOX69PgGfZkresFu9Rrq5mREWwJJWHGxfMvKgUd7BOtJAbhZ?=
 =?us-ascii?Q?lAyrEXReYmm6I0v433D6k9g8hXj0MKi2t7ehOHYgeLbUPXZp88ZxPJMej3sF?=
 =?us-ascii?Q?HdqJSAzm7LiFmQ/H6DPspuLm3q42ZbqF8vH2mSu0QH5EOIQNO8dz1Sv7/cv8?=
 =?us-ascii?Q?/pChuEDh3wlNasVr9ScWj+JtZ9nPze7y463OAuoLZn625lK9RZxo/MTg/q+v?=
 =?us-ascii?Q?7Nw1HkujlmZvzyr/jXFJWC83Nk0XSwFAJzw8cMzWHjuOC5QBODz53FY5TVQD?=
 =?us-ascii?Q?qgyB/cvrtVayw8kwt6cx9YK0+UXvolHhFVl8o9EGmeBSWyNWFSECho1RktHI?=
 =?us-ascii?Q?J/hWrB8p1UdsCm4K3k4KeWB2Xp+4Rx5kkY+0HQF/vPaDZKqnI/y6dRrgbIRn?=
 =?us-ascii?Q?segZiLMTeMab+fnph0+fWKfbSPbzrxLI0NLlNg2uIp1tvFp6HfDznGajC9g3?=
 =?us-ascii?Q?WQ9q9h5AZUnvlLhJRoQmh0f0fvvnqq80/XjhFY4nnh2juTY6uAL0eI31JNRY?=
 =?us-ascii?Q?7sGNsRTQLgckcOl5gFynhcRK+ImvME7oDPHX6HhAO1od5S7lk6DhdJGPn62x?=
 =?us-ascii?Q?bIXCKf0QtRGM41uV2CFxwuSE4cagUd9WD6d2xurb4KNCg88wMj0GY+s2+mja?=
 =?us-ascii?Q?sHYvGvtef/TrlAIPGAvITCSGrgESRRBn0+VnwtMyo2yF8LwtliYFo6w2elFo?=
 =?us-ascii?Q?yepOL6gXWyETymhHNhE7SrZxyoCVDvzvbZVa8cSx5SmibnLmrHKqAFqmXAdy?=
 =?us-ascii?Q?kMpGwySllBFUYYrh4pvm/bX/7GAjFXeQ8s+yo92ZAmEJWSNrbDASH+CZoRCE?=
 =?us-ascii?Q?shrxcffdXLDlUC5uu9BsBvvpMyT+RIGafAu00fdIFnKSyw2qw/DQO8wuTmcM?=
 =?us-ascii?Q?eiGnt3oZAntMZwAa5z6wI63aNFVJe2Ho8/tJ8uGCMFY9utoj9WLsEKpf/2R4?=
 =?us-ascii?Q?/UElEutE+cSNjhySktinxp6+GR/vjnSnmnkpCo0WUEuRoJXrqtHwn9LpgtdX?=
 =?us-ascii?Q?V6Od7R24BSaYEBtqacON8KnOdMy0OHezUh1+S6ZVwP92XhXEL+N7+H/usCno?=
 =?us-ascii?Q?7CRTw+uNlOrNJ7cNn53+neTdtvEA?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(36860700004)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 10:02:37.8575 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17ec82e4-ebc8-495a-a659-08dc8546a145
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7624
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

Add support for the Microchip USB5744 USB3.0 and USB2.0 Hub.
The usb5744 driver trigger hub reset signal after soft reset.
The usb5744 hub need to reset after the phy initialization,
which toggles the gpio.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 common/usb_onboard_hub.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
index 0cfaa90fce3..50870285995 100644
--- a/common/usb_onboard_hub.c
+++ b/common/usb_onboard_hub.c
@@ -88,11 +88,21 @@ static const struct onboard_hub_data usb2514_data = {
 	/* TBD */
 };
 
+static const struct onboard_hub_data usb5744_data = {
+	.reset_us = 10000,
+};
+
 static const struct udevice_id usb_onboard_hub_ids[] = {
 	/* Use generic usbVID,PID dt-bindings (usb-device.yaml) */
 	{
 		.compatible = "usb424,2514", /* USB2514B USB 2.0 */
 		.data = (ulong)&usb2514_data,
+	}, {
+		.compatible = "usb424,5744", /* USB5744 USB 3.0 */
+		.data = (ulong)&usb5744_data,
+	}, {
+		.compatible = "usb424,2744", /* USB2744 USB 2.0 */
+		.data = (ulong)&usb5744_data,
 	}
 };
 
-- 
2.17.1

