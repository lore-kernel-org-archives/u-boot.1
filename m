Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BEA8C3ABA5
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 14:07:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 639B982B17;
	Mon, 28 Apr 2025 15:45:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="JmhyUhh9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43B1782B07; Mon, 28 Apr 2025 15:45:49 +0200 (CEST)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20726.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::726])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 532D582935
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 15:45:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mA7EPkMPXxE9MTjqBXz9V5WvqYBzh+UAbcdmS4VGavReTknRlRByH5EmlIv3o1tLkS6o25QbkOeQCPEgOwWpdHBu7C12b8ZuKJW1l1EtFHjLp6mAS1hWnn2j00CtVlBgai932lasRSJ2tdC8HX2rk2lAlAQeWMVyAjHrGal9W9ZdmfLLl2C/tXmUAh0s03S4dy9HOdt10flQh5tbc3ZbqMBY8Fx05zjkNVueC+p2pmVJUG5x7j0FRDNQv097fzNqgZPDHOYJyxSTkf1jDkWGoouVNUD5q2JSZldwjducNdw7vdzvQcjHlBzCzvo42okX7bv/HtnmSBClpPqdyNQaDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q6mnDafIYh0/I7Xxt0x+c8ak3OGSe3pS2KGo9AEUWaE=;
 b=dqyUmt1vrmKS32LEkCDZt5rMHEKeu6fwyt2Pe03SV/jOScD/JtXyun8nAMTVbzB7a36jDXabJrEzP0RRyWhf5DxGDoKgJE4DFzPCw+DScetiANks6uUeEsHWR5gkIrFhuMn5U42rM/3nAKMUeqgNa+98DXkKSG2GrHcdoKRXrvVrOoVqNQ3JeHS/xnY/HQPhrLsKmlBj8l+KZMYW7l0gWKbZwLSg5wyDAWbYcoisIAHcP/qcH3UYz1PFaXTrLU18xDzvEMwQCAeQCdzQRcODXaenjj2XPffS5oCUDDv6XvxsfJmHDwHOsFrwF5mnHkA8uwuvDNjbIxDEGU1BowlWLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q6mnDafIYh0/I7Xxt0x+c8ak3OGSe3pS2KGo9AEUWaE=;
 b=JmhyUhh9h8ll9OnUmJVFGbe2afJHRo9S+fLAJJtAyI3fHlVIaLnop+ZvDHLuzTvjRSnCdFZ5NBqQiF403JoJj4UtX2i1b/URVNDnRzH+craySEbHxhQloDjWglsGT/muZg3zoU8YrTX3ivJvl+TXt1adKvk2PyocimAAjcZATe65BNDkoJJUCo5qEEvfltthH0cXVBJR6XNrthTdU7BV5T5ydOgHLUZwqyOpR+vpy4ziVFaMdRqLVRJ0Efh1askhxc4OGwOeGFfNih+sCPJe2h+B2+Hi8Ullhhd6z3AR4UbXP2r6MeMZ4K/NBVSiV02GouKxyvBW58yhAWf0yqL/vA==
Received: from DU2PR04CA0060.eurprd04.prod.outlook.com (2603:10a6:10:234::35)
 by DB9P195MB1145.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:29b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Mon, 28 Apr
 2025 13:45:41 +0000
Received: from DB1PEPF000509ED.eurprd03.prod.outlook.com
 (2603:10a6:10:234:cafe::9d) by DU2PR04CA0060.outlook.office365.com
 (2603:10a6:10:234::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.41 via Frontend Transport; Mon,
 28 Apr 2025 13:45:41 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DB1PEPF000509ED.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 13:45:41 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Mon, 28 Apr
 2025 15:45:41 +0200
Received: from phytec.de (172.25.0.51) by Florix.phytec.de (172.25.0.13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Mon, 28 Apr
 2025 15:45:41 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: <trini@konsulko.com>, <ggiordano@phytec.com>, <d.schultz@phytec.de>,
 <n-francis@ti.com>, <nmorrisson@phytec.com>
Subject: [PATCH 2/7] board: phytec: phycore_am64x: Update environment for
 fitboot
Date: Mon, 28 Apr 2025 15:45:26 +0200
Message-ID: <20250428134531.2884940-2-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250428134531.2884940-1-w.egorov@phytec.de>
References: <20250428134531.2884940-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.51]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509ED:EE_|DB9P195MB1145:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c220b6e-33bc-4c35-50ec-08dd865af7a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ykeZBQKjMJWEleeD2m8cgr9JYDqFQGUfFwjSa7wFtb3AIEhcaXRXgDLgPDUw?=
 =?us-ascii?Q?QCchdVs2gyREYsWe3RjGWaqX2I1tqXd+0XzlcVdKsH5N4LzXk4yI1Hgu2Y9t?=
 =?us-ascii?Q?6Yjo48ALDS7MshIOmtmejY2S057/GplNZLGqzNWCSkFIuoNq4rEY1JIWbcKV?=
 =?us-ascii?Q?2TPoZgq46Y5Zx9soBTf/vIMX9ksrQmQcJ0R4IHXsT22TXq2OjSSxZHYRVsAO?=
 =?us-ascii?Q?RwW+98a9OFlCdA/xE2Z4a44NAng1xsAvnD6JaowafbI9Mw7448jkj0nlxRi3?=
 =?us-ascii?Q?E6OKet/O0hAymE7wn/Rc5Pr63dc9uTUseKeamguPUQlg2utwglURq4v8Z7lb?=
 =?us-ascii?Q?3FDwP2W3POSvU5WwQ/LRFZ3vFk17+4eFClrKethKShq6GmkLAlgkPtB6km+1?=
 =?us-ascii?Q?tEWkYLOpZX0kDsrI3UFBmopPB2dnPZi7Y8PGYKKzYuFr429VuaR7+gPv+S0x?=
 =?us-ascii?Q?/30WyzqbTtIXu/b5U4ggyS2xrWF/pdIRwQrtkgaPxiCgZVW4/ll5fx3SqKcE?=
 =?us-ascii?Q?Q9VmU+DG7BIdEX8QCCGEPZX2N/629BX4VWb85dAX43caBDUOiTEZrzoKxR6p?=
 =?us-ascii?Q?iaQVW8jrxjCfP2rn4rNYHx1P5sF8/34xw6ivt6nTvS2q6B/iVtOS1jo0LmBB?=
 =?us-ascii?Q?Ok/Fq9Qshs7HpFv0S/JTxIUdHeinHG1sNdAraK4b4VtfWKMXejyYTONe5GP4?=
 =?us-ascii?Q?V/kwyxe65mq0OqwFF1Z/9/PctrYs6Yr8I00Ai7bO9FkYBflLHttd26d825tt?=
 =?us-ascii?Q?nL3x5MYdpqUHTg7ffcwVkKtHF9UJNfTOTlsrkD30Qn85rKu7XjRU8w7LprOG?=
 =?us-ascii?Q?wOE+g8zvp47TaETnS0+DoTYnefHytJ5QBxhtBA6+/FND87uh1HxMdm5ODF7t?=
 =?us-ascii?Q?YA0BtcrMgMXwAh6DwucRmZV5BMjmP/+oovbMrxAb5q5d9XI0B7b+V0jWMVmp?=
 =?us-ascii?Q?IHQK0Meo41p4iK2lZTR00wZpCq9gtLQYEXTBe7zt0+H2Whobtg6RB0khjCYd?=
 =?us-ascii?Q?26P3F6uzKJWG2A12M0v7B5BbACbXKUYp3rsXfdHMVHONnbqxgrMZ0AkDl/xI?=
 =?us-ascii?Q?4uDHsCbvDt3No759DGO5HQswRvqUpoP1Tx0lLRoUGsF9Q0ly3Y2v3wGwsAdG?=
 =?us-ascii?Q?BLWLL3QjmrvtnDvKU4K4nPRORoObAp4zcfSBJW3p4AhyKvFu3w6egoHROPht?=
 =?us-ascii?Q?kUDmZdSjfrTPrsGaUQQ+NspD5CXVwvy/XrpezZ2Q6CwCWvZw4+OGrMzufC+T?=
 =?us-ascii?Q?MxauHBtzqBabQP3oP01PAKhzzKpWWxVgWJx9yoFE6imXJS/+lEaBppTC9rws?=
 =?us-ascii?Q?R8ryc3HGZtWoTxJwADV/43akeAP+YkVoU1+5bA/G4mLqf9jjXJlDNFQ5OuOo?=
 =?us-ascii?Q?dfxII4Oe6g6FysgTB2eB1Vab/mww7fhveUcUVqbw7feAAC6RxgURodskulxq?=
 =?us-ascii?Q?Mqigrv5AiDBNEL1JT7W4Gbz+2DV7syt9/iQ5DWzboA0okUp24pCUPN0KbnZr?=
 =?us-ascii?Q?a8x6eP6zE5kNsQU/Ifc9RdXPmmrVLwnEt3Te?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 13:45:41.5743 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c220b6e-33bc-4c35-50ec-08dd865af7a5
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509ED.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P195MB1145
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

From: Nathan Morrisson <nmorrisson@phytec.com>

Add fit_addr_r to the environment to allow us to boot from a FIT image.

Signed-off-by: Nathan Morrisson <nmorrisson@phytec.com>
Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 board/phytec/phycore_am64x/phycore_am64x.env | 1 +
 1 file changed, 1 insertion(+)

diff --git a/board/phytec/phycore_am64x/phycore_am64x.env b/board/phytec/phycore_am64x/phycore_am64x.env
index d69dfe75674..d04a3be6864 100644
--- a/board/phytec/phycore_am64x/phycore_am64x.env
+++ b/board/phytec/phycore_am64x/phycore_am64x.env
@@ -9,6 +9,7 @@ fdt_addr_r=0x88000000
 kernel_addr_r=0x82000000
 ramdisk_addr_r=0x88080000
 fdtoverlay_addr_r=0x89000000
+fit_addr_r=0x90000000
 
 fdtfile=CONFIG_DEFAULT_FDT_FILE
 mmcdev=1
-- 
2.34.1

