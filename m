Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B8DDCFD31C
	for <u-boot@archiver.kernel.org>; Mon, 24 Nov 2025 08:25:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1001D83C7B;
	Mon, 24 Nov 2025 09:25:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="cSTHf2ws";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15E6683D01; Mon, 24 Nov 2025 09:25:28 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0830383BF1
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 09:25:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TGNsqHHK7f80MVqUm1cw55dZ8cGmrNTxzORrVEGGWCRmeXttMAeKzykbYDyzawau42O+Ue2855MyutZAziSzK2vr6sMYreEqlhrM1KEl1Ux+gbns3dFpkYhBcp139Q06YksoQEa3pCkeN26RJg+DrHwEdzdKgs1kgkBUa42eIp2xBrHb38GLfTtXZmIz0Wygk8eOBsxHybWTn0cX8ZXFdx2XZAU8XLwAUk9vhWn72mawlQ22cqYDt8wfD7z1cnjSYuJbdvm582hcuIPjdtfIb5EpkAt8hCajgyR07BB9Qw2ezOclsEkFf5UcKJJ67nu9OVOLnKA4aIs0KgjZcGhI0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eRouy3WOQ5kzrHENMJ0+rgrdwChCk4Fgz2thntkPA8o=;
 b=WyNCFihhcquoaJSR71JWMkt56X7Jk635GHxnd+Y8SaGUubYUuwGsML0gS5SewZ+4u7AyPcit1wLj6DpFxNDSNLtxx/0ywlgBl3nCcGqQU3qj5dHHJqSucXdKqZMmpq1o0y9T0wNTFYF+dlKX7q7tokUqBWdZfEXExKhQiQ/+zPBcXtt6Wjogd98RFPoFklddCfI62S1azEBiUR65pAE3VKzFqUqMcVby4qY+qoMbhc+zx5aqOKZNm1s+4MuLd3Gg9W/wdhdc/vr/e622UyPGsFJMxWqk2KQzvvgPbL105cacV/ni2xYqKagbpxLZTCAbdpC3j7Oph3qRrVF4ZEwqlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eRouy3WOQ5kzrHENMJ0+rgrdwChCk4Fgz2thntkPA8o=;
 b=cSTHf2wsj6nu0ZDrjBC8eq5Em4vmW2HLpg1PlOwfzPYqO0ZL5tKKeT1mgM6fy3ggEljl8+fAynGgbjTC6SOf4O+1LG3EKaFPoZIEknTolFI5GQP4UMFWZgVVsx8pluloRooaMqxTJ7DhDKNRZHxfopCJZMymDzTtNXRNAm+QhtHUUqP89mhTQIoAsdNKuSNqYotVi9iIqPUgBSY83HUlCkfB8kSthVKBpdbjY0JWdGIQUJNUZaWOwqB1txKqJb7R7rWpXk8h3b8WYTzpUSB0QaKC3fH3AR0WSAWLD3ED7VV/o7x/wGN/IsY/4ERvH39iFhgGmmBhnxBkO6Wq2I7m7g==
Received: from DU7P195CA0028.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:54d::28)
 by DB9P195MB1611.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:37e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 08:25:22 +0000
Received: from DB1PEPF000509FD.eurprd03.prod.outlook.com (2603:10a6:10:54d::4)
 by DU7P195CA0028.outlook.office365.com (2603:10a6:10:54d::28) with
 Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.17
 via Frontend Transport; Mon, 24 Nov 2025 08:25:20 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 DB1PEPF000509FD.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Mon, 24 Nov 2025 08:25:22 +0000
Received: from ls-radium.phytec (172.25.39.17) by Postix.phytec.de
 (172.25.0.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Mon, 24 Nov
 2025 09:25:20 +0100
From: Daniel Schultz <d.schultz@phytec.de>
To: <trini@konsulko.com>, <u-boot@lists.denx.de>
CC: <upstream@lists.phytec.de>, <primoz.fiser@norik.com>, Daniel Schultz
 <d.schultz@phytec.de>
Subject: [PATCH v2 1/2] board: phytec: phytec_som_detection: Add missing
 assignment
Date: Mon, 24 Nov 2025 00:25:05 -0800
Message-ID: <20251124082506.3376876-1-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.39.17]
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509FD:EE_|DB9P195MB1611:EE_
X-MS-Office365-Filtering-Correlation-Id: 208e6e49-230c-423f-5905-08de2b3302cc
X-LD-Processed: e609157c-80e2-446d-9be3-9c99c2399d29,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2bbsFw37K5u4e6Lk96ycVUsOREe0Rh+R9XIyp9LBIZF3i61tqWAkzdC41JQO?=
 =?us-ascii?Q?E09/3jiVM/RCEn2Z2DPtpcAw9nhBLICJ15NFKaGQv7spUcywjBjfNaaIU6+g?=
 =?us-ascii?Q?TRJlNJ+Y+Axhpuulro2JjI/zRkKLue70qLEJFFLlOe1P1k5FZxiaX4Pm2t3m?=
 =?us-ascii?Q?KGavlOZ9yBYmqiFbbsFUCSTOYvnVcUwTu0p07zPF7ih0qwLV5oVizVgHX8YA?=
 =?us-ascii?Q?GjIb5hnT2viQs88GASfQlazSjj/u3vCQZGp7baInipvL/kvkhwvGRMcil/Tc?=
 =?us-ascii?Q?mo7kYBCW8v9mmVe7KSehwJXcYn7UPn4yLaS0ZFFqmzWf0CnQB8SL26hGpNoU?=
 =?us-ascii?Q?ufd0ruvtDbF38BXzV8CzbGCWnCAfXqVG8jjxUD4Rduo+w+33B3ZwuhJX5BIk?=
 =?us-ascii?Q?m5kXi9Q9t9T1hBH1sn84J8+M41NAFz3H2u+EOW1zlTD0pJqwtJd5U/R1Tu5D?=
 =?us-ascii?Q?Zq6x+ieW07Kqik3xISRUGCofOcq72W+OabF56Y9rB9RQZMdHNapfUi2L2nu8?=
 =?us-ascii?Q?od62FAa2+gmdnFT4PkZZnFPcijuvi0b9qeSxJuAsonOYT1W/TpZ57h7XYYtD?=
 =?us-ascii?Q?QeX2lNEqgIi67oxh/8iuG3MD2SaquBaaW7fBRRus2JgTl9pfbjJNeBnwONhr?=
 =?us-ascii?Q?NPQZA9NYZfmPVU1xTfuSYGa2x8LMEUClPMTXoQyseekTZNtpNu6T/xGPMYce?=
 =?us-ascii?Q?hf7r6gUk/SBrOaRPxI4vzNuR3dD1qK5Dcto4pe7nSgc/TfdRkl7/GwwIkunD?=
 =?us-ascii?Q?pedCD77evEDTvGk+2n7dte/i+tlh0HZm+ZQPW4xfpGlvkEw+3eY7dpc7tIGS?=
 =?us-ascii?Q?UtxTkgTyolXZWtCVSceB9gkwk04EdfJLPI6XctTfDbIcbHQvQaVa6fKQHvgk?=
 =?us-ascii?Q?6JqCFgetoODdge2Hc0/tOj7VTl+oYeyM6ciufzUfoAva33LjP3Wi+OvfsvFG?=
 =?us-ascii?Q?T2LEh/qLhIYBvB9D91VJz+mbcXEH8EPPhGe3LkFoEqcQKhCELECf5iuBjQhb?=
 =?us-ascii?Q?cmHLZLX59gd740QsEFnPy7xrsr9UVk3SQu9Pl79S9WfSm37W93D+UAvHObyf?=
 =?us-ascii?Q?SsDZaIheu7szRiwesfqprfPF695IKKc2U9Hv2GOOyiEPuB9kVvz/ZZagiaHa?=
 =?us-ascii?Q?wDhdxnEHEDeMYWy534yiKXJWAuDUunLiHUkxbhPY4atLr/P2dfRZHk/hlMYl?=
 =?us-ascii?Q?kw+evlxlW1X/WNJtLmmWJxnW5rz834Py4DMSG1uk4IHOy2pJ2pE0NrH4+Qom?=
 =?us-ascii?Q?vCmVMLRuVymdJTeboz6lscACx7vugOEgM/R0NHOt5Dew7ynCVoVfbaWnG5nw?=
 =?us-ascii?Q?bCtTwNhbJtVBjvLxUWF1rQKhqs0l8gQFxd6+cHKdZt+keZh6R1XwaglsIhBu?=
 =?us-ascii?Q?V299Psv0ouUxxfsvTDZdrLggGbYYYgNCWz1rVDOTrMb/TDiSKGuuWPjipLUs?=
 =?us-ascii?Q?Dz2Ji1kSKqDgmVrEigqQxUwnF6omj3gfIrrXrTnhvioO7CmuiH74z5onWHa+?=
 =?us-ascii?Q?2cyv3zeTRUAHrph8NudM6ci+8ieUCxKtGSpTAr0+94E5KA5CVZoYJ6yD3hEu?=
 =?us-ascii?Q?nf1amV5Cu+ghnJU+LLQ=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Postix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 08:25:22.2739 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 208e6e49-230c-423f-5905-08de2b3302cc
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509FD.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P195MB1611
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

Assign the return value of snprintf (total length) to a variable to
properly check if the string has the correct length.

Currently, this variable is always zero and the length check after
snprintf will always fail.

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
No changes between v1 and v2.

 board/phytec/common/phytec_som_detection.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/board/phytec/common/phytec_som_detection.c b/board/phytec/common/phytec_som_detection.c
index 136f4486eb0..ff1711c24b4 100644
--- a/board/phytec/common/phytec_som_detection.c
+++ b/board/phytec/common/phytec_som_detection.c
@@ -346,8 +346,8 @@ static int phytec_get_part_number(struct phytec_eeprom_data *data,
 		return 0;
 	}
 	if (api2->som_type <= 3) {
-		snprintf(part, PHYTEC_PART_NUMBER_MAX_LEN + 1, "%s.%s",
-			 product_name, api2->bom_rev);
+		len = snprintf(part, PHYTEC_PART_NUMBER_MAX_LEN + 1, "%s.%s",
+			       product_name, api2->bom_rev);
 		if (len != PHYTEC_PART_NUMBER_KSP_LEN)
 			return -EINVAL;
 		return 0;
-- 
2.25.1

