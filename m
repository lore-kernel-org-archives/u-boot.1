Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC243D6B6AD
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 16:48:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DA9289228;
	Wed, 30 Oct 2024 17:48:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="MDMTDoeq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A7DE89206; Wed, 30 Oct 2024 17:48:33 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on2072d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::72d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 213DD89212
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 17:48:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VUjGv0nbZVorTGIuyWcozZHf9WkHt+afKBy+bgczEBjXDUjgiGnDW81v1KHR7XuvVq8Fu5ZGQfLIj4LlFK4ZV4n/p9dIFOzPVz5ukiF2kW2FnML7WnvsHBInEex6Lr6TGIt6KHEIg06XvZpOtvgSkZO5yuC6Tr3YXf3v2Hrdl0EaRpk5q+U1SaSvETHWS7Rqe7ZmIIMP97QvPBCX6yfSPcKdm7icjLszs4efTv5pWwUck8amL9mspdvULbdvD35HGraOCQqv35hziKs9pkIxNfrXuMY8uYcDr4KzEqfcDSGD2mJaHoU8LiU+dWtR3WgTr4hr5I2Xo0PQ6epfSMT8ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ERcRTFur7PqhxGCHTOCNt0akNrHgQ37oOjeCW7LDnu4=;
 b=R0hs6MF206eHYIl8j8ef4osHGEoYHSb6uCistRwkcElOluxQIZcp3Aut9EBh8Ykv/P4RRns+xwqtPVGSIIRJk5jqk1NY866Fv68AytBWrDCD4rPgkPNwLMWWLoPr/ISQpY3AKl/s0cMSLg78Vkh+M9EElkjRaHZwJ8u9ERDky53OefYjLhpTqd1OFPsd5loP8TQtOZxeNZS+bdZ5ZcWLKiX8WGjbrfZYVtjmuuBd2Bixl6W1sLN3NLe37hV9Bl6Kzgs4PKFBFGvGQMfl4dnajHxjhD4ciWvnCMcOVw+Mu7fmws9LAsSQcQbg1iirMzNSAmw/wNeb+isbFdwvuwVRTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=none action=none header.from=phytec.de; dkim=none (message not signed); 
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ERcRTFur7PqhxGCHTOCNt0akNrHgQ37oOjeCW7LDnu4=;
 b=MDMTDoequVmYEaSfuOGy1yTjGFHGxYDyUnEiu1Kx+nQrxcUSkFJpwW2Ofophzdh5RuXrVM6o+jJ5xjdfGco+PfaJuEvKc1vtiFZ6moUwDbBQ7hQyOktfikAPC+c5G6qAtGnoJx/DuZXOV7w5KKsVgK2vDRX8Uoi5vDOulhXhKIM=
Received: from AM0PR01CA0125.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::30) by PAXP195MB1326.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:102:1a1::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Wed, 30 Oct
 2024 16:48:28 +0000
Received: from AM3PEPF00009BA1.eurprd04.prod.outlook.com
 (2603:10a6:208:168:cafe::71) by AM0PR01CA0125.outlook.office365.com
 (2603:10a6:208:168::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.29 via Frontend
 Transport; Wed, 30 Oct 2024 16:48:28 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM3PEPF00009BA1.mail.protection.outlook.com (10.167.16.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Wed, 30 Oct 2024 16:48:28 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 30 Oct
 2024 17:48:27 +0100
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 30 Oct
 2024 17:48:27 +0100
From: Wadim Egorov <w.egorov@phytec.de>
To: <trini@konsulko.com>, <n-francis@ti.com>, <afd@ti.com>, <d-gole@ti.co>,
 <sjg@chromium.org>
CC: <d.schultz@phytec.de>, <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
Subject: [PATCH 1/6] configs: phycore_am62x_a53_defconfig: Add SoM overlays to
 OF_OVERLAY_LIST
Date: Wed, 30 Oct 2024 17:48:10 +0100
Message-ID: <20241030164815.1763506-2-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241030164815.1763506-1-w.egorov@phytec.de>
References: <20241030164815.1763506-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009BA1:EE_|PAXP195MB1326:EE_
X-MS-Office365-Filtering-Correlation-Id: a47e2e93-c386-44eb-096e-08dcf902ae15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NiVx9sEBBPL5ASGaaGyW3HRLP0XwKYw2bfNUI5mZX4NG3B8AK6/xul71KEk+?=
 =?us-ascii?Q?9JQJkDIdd2e+CYFZzJv5buhs1Nl+0itS55keywoBw3EhWiI9gK4AaaIBi57I?=
 =?us-ascii?Q?NZqyt3PJN9jZ7+//LHKmVtdZbqHm4+bq9l1mEddnyf1prauxZjSHTrtp/vnh?=
 =?us-ascii?Q?NDBMOVZxDL4MKB69GcgR6KjIhYFse7ITfYe7E+nrRJ8S/RWvn9coMV7CsrJl?=
 =?us-ascii?Q?iwcHC0FYXVcp7+ePQZ4SHhC/oXMP0taIDC+2f3by8sSot+eDLN7eqaQmhB4I?=
 =?us-ascii?Q?eZe8fEzZzFCJh1QBLxxuWEu4/RSjfAmhar18EEgUY6SXaT6zuKflfU9wwPrj?=
 =?us-ascii?Q?IEeYnBv3Khrz5O+SxgYq69AhVbrk5AF96BfSt2mK5Pkb2qzGGEcYCzWpAGE9?=
 =?us-ascii?Q?Mvgw9pdfjNxNdQp0vhB9V4Lv48yBSJ+jnaWozeU+zNydnh+nxlz+Ro4HWHzN?=
 =?us-ascii?Q?FepBw+OLVd24pBRGh2+s8B35b8p6h4zaGSwp6OyyPz7YRCQkXCvOQAlY9eoK?=
 =?us-ascii?Q?sU8fwS2BU6dWb75T+byidJ43A2t/5hWLfOymLmqNzIREmpoATBj5UasT5JWL?=
 =?us-ascii?Q?UH8pOEnlzdQ+Zcr1akL8el8SREs4WYpfXobfCfxfNxrxkKXDpHEgAl9MrxhE?=
 =?us-ascii?Q?Q6p9+8aC658dYmuTbQMDh6jQuIh2J4gvQBZcSWunAOESYeChsfUGXT9sdl4U?=
 =?us-ascii?Q?4vyOM22A+/goSXFBuiwg7bUFZ2Y+94U8IMRakKHNcO/O/rIzFC+HZJeWWEMe?=
 =?us-ascii?Q?XKxG3THbwgyXJQ3GIkoNixmOqjgo8uf2XiF0fRpHZPq3fxFqnR6aKxdaTYgv?=
 =?us-ascii?Q?nr/0dh3ps/RRu6kxCk8S4EgLR8XFRp3uv2X0NzMkz+WJxzbHFLNUpvXu17N6?=
 =?us-ascii?Q?oHq2s6FbZggFIpmFokpQUUvh7P9am25AEIwS7hx8UbaFHvEfndwP/VvxY070?=
 =?us-ascii?Q?RLvwIxSANfICI1bdw9HUSjXUGMvnErJh5rGfgOcUIjFlWNqb/L4g7kRdt0ab?=
 =?us-ascii?Q?6HqjhwliEvICx/mr/IGvA8sYNL8BqD6i9wtIRw7p/Mx7qvElY1ZQz/Zw2l/X?=
 =?us-ascii?Q?+eawVBEhcXjByTLOOXUykOUBVbRL8AQUCbf0u5XKmxeqcq/fr736kG+KGoQv?=
 =?us-ascii?Q?Kxh71QvacN590YfHe7OzzFZme5FgJZgL69drETpdkdrDfkE8lneods87WAv4?=
 =?us-ascii?Q?wQnfeAZmfetXRHdrEgW2m1sRkFFsY7PXvCFN4bYI2tfKEJzJ+vGd3Dx8M8OS?=
 =?us-ascii?Q?d+tBVLRJApvZgmM4Lo8x2St9wXBw50Ur5J3MZ2j7n3TQ2LEHToXk4edr2zGv?=
 =?us-ascii?Q?7kNaSsNpn01q8KP+9nfnV9cRokUEdS9F1qJImTUF/RtRTskAA/TR6NUrk1tL?=
 =?us-ascii?Q?4tHyQCwY73JQnjMOC/+FyLp0KdJZXa7ma1plgooSJaG2MVxYNg=3D=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 16:48:28.5320 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a47e2e93-c386-44eb-096e-08dcf902ae15
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF00009BA1.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP195MB1326
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

Include SoM dt-overlays for DT control so we can include them
into our u-boot FIT image.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 configs/phycore_am62x_a53_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/phycore_am62x_a53_defconfig b/configs/phycore_am62x_a53_defconfig
index dfff58670a0..d4b5191af7d 100644
--- a/configs/phycore_am62x_a53_defconfig
+++ b/configs/phycore_am62x_a53_defconfig
@@ -72,6 +72,7 @@ CONFIG_CMD_SMC=y
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_MULTI_DTB_FIT=y
+CONFIG_OF_OVERLAY_LIST="ti/k3-am6xx-phycore-disable-spi-nor ti/k3-am6xx-phycore-disable-rtc ti/k3-am6xx-phycore-disable-eth-phy ti/k3-am6xx-phycore-qspi-nor"
 CONFIG_SPL_MULTI_DTB_FIT=y
 CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
 CONFIG_ENV_OVERWRITE=y
-- 
2.34.1

