Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B5BEC43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 06:59:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8742984C51;
	Thu,  2 Jul 2026 08:59:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="UU8ssSiV";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="RFNbzVMm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6E3484C5C; Thu,  2 Jul 2026 08:59:50 +0200 (CEST)
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8358184C39
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 08:59:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6626XlpW659076;
 Thu, 2 Jul 2026 01:59:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint-05-2026; bh=u1MrjWAT/ibeW
 A+Z1O2oiqfo3fmG8dYeF/HEmFArDzo=; b=UU8ssSiVGzz7gD9b5CkIx6gGGB8rl
 f8zJ9AXWUoGN431nHpEEk+8gEDivpQXE9LRFu2gWnovdhpOrVAhtX30HH1rreN0i
 6K/8RVNKF/i2ZInYG9G8K+4bqgdBaAkiOct/CN5uff16OTa2JGPOypf1X1SO0Rzc
 lz+puYl0P2vmmrs8XJgCGn3+iiSiPBA+VQ7pSlLK1NEF1ROmWRBrxSyJGB7Ni4Xs
 pMrvk2i68G+LaHQhFbrQfxDINeXCxpb44t5aWkhAXtiJI1+zGpC5wb0W6f+JJ+QP
 56PJy0jIrjMgqRG6+qAg91bY0Dxnomw1ux09VvXmtWlH6MaCo43Anc94Q==
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazon11012005.outbound.protection.outlook.com
 [40.107.200.5])
 by m0384305.ppops.net (PPS) with ESMTPS id 4f5240xemf-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2026 01:59:44 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TSV9f6/JVBKzwyGKyVGbe3pvIO21YcZK4ZUG+PZNjIB7dI/3KOrEBI6uspzW5HkGlLkirZnXKgY89iiDShG9Xx6gkuj2xdJGmT6SnxgVvd7il6e95DVawg+MzzEJFEm6PrVVEE1EIg+hKTl0IAw1B+X3Ani1TZvHKtaXfN0AcNg8dPeDrFYMHFJIw9y+JjgcsMyIOR+BNe0WBz3fTnvxsZrwc2CFqTv930GguSKu9RtSz1sj69XlLxu5i3yspvmjeIUFcear4BofdXJe7+ZKSCjOmgdZn42cYN2rJipgxrrV7dEmZhzP6wgGa1L3hAdeSuW+QIjE0qKDjZmx7Kt83w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u1MrjWAT/ibeWA+Z1O2oiqfo3fmG8dYeF/HEmFArDzo=;
 b=I9wdTNKH7PFM8GICrbmBn8OfXfojDUb+nvCPqN9b2fTAYiepg2O7x7hiifHO7FVNj9nsdGZbuWx1TcwLj0P9WRZ+PU+hivXjje4j/P8Pk6ToEfKVBd4kLKg/TrmJ9UksLFWkP2+mBLDndnzIJvW8cNTJHOayOVy9qYeOkZ29AbUB+8Y9HWkMfctJ8ALsDIDe1FHiConpyQeuevgfi/0udiNDqUE/DUnALpnuBMaM7bZb5ks0XxvFXxWjOYiFB7me3f8bO6NC5LYcApuMj53rwwk3P48WKJrxDOFV12FvNyURmurOLlP7pk9pD+xzPmI6JCuOpwyBZSrjE7/aFNteoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u1MrjWAT/ibeWA+Z1O2oiqfo3fmG8dYeF/HEmFArDzo=;
 b=RFNbzVMmZEcr+nNtdTlNrEvCh4NsW8g8lErrTSXd7X+IJOpQafaKF4uQnEGGJq4FCEeIq/jsCKNAeXYeN61f+nQO5RR3OhUnqIQcytLvdBMHEJrQyHJhbY+eYrPNvRaqnxi5/QyHnlLOY+qLnwz70z3SnInvtzZB7L6q9zv1hts=
Received: from BY3PR05CA0017.namprd05.prod.outlook.com (2603:10b6:a03:254::22)
 by DS0PR10MB997578.namprd10.prod.outlook.com (2603:10b6:8:316::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 06:59:42 +0000
Received: from SJ5PEPF000001EF.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::4a) by BY3PR05CA0017.outlook.office365.com
 (2603:10b6:a03:254::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Thu, 2
 Jul 2026 06:59:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ5PEPF000001EF.mail.protection.outlook.com (10.167.242.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 2 Jul 2026 06:59:40 +0000
Received: from DFLE213.ent.ti.com (10.64.6.71) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 2 Jul
 2026 01:59:38 -0500
Received: from DFLE212.ent.ti.com (10.64.6.70) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 2 Jul
 2026 01:59:38 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 2 Jul 2026 01:59:38 -0500
Received: from localhost (ada0543016.dhcp.ti.com [10.24.50.146])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6626xbv32753487;
 Thu, 2 Jul 2026 01:59:38 -0500
From: Anshul Dalal <anshuld@ti.com>
Date: Thu, 2 Jul 2026 12:29:35 +0530
Subject: [PATCH] mach-k3: am64x: clear MCU_RST_SRC before reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260702-am64x_sw_rst_fix-v1-1-c45a775e257c@ti.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXM7QpFQBDG8VvRfLa1BktuRafNy2AU57TjoOTeL
 T7+nnr+Bwg5JoEiOMDRysLf2SMKA2iGau5JcesNqNHoTKOqJpPsVjbrZLEd74rqNIlNhJjlGvz
 t58jPT7L8vJZ/PVKz3B04zwvXuF2LdAAAAA==
X-Change-ID: 20260702-am64x_sw_rst_fix-eb5436122780
To: <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Chintan Vankar <c-vankar@ti.com>, T Pratham
 <t-pratham@ti.com>, Anshul Dalal <anshuld@ti.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782975577; l=1119;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=jfyr9cfw5dshKMENWJyZL4VVsaDZh2ubn4+BN6FzAxY=;
 b=MV6upTQS693OpOk7+nRVELRXVsdICiOMSLfd/d+h4sQXV7DQo6l+UX0YCxHrZWhsTgNPRFLKn
 /sWhJEu4Zw/AV5H7pTW2X847bv/4VXmA6kyxc7D9orGP1f8YBc/v63O
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EF:EE_|DS0PR10MB997578:EE_
X-MS-Office365-Filtering-Correlation-Id: c3318531-4c92-4412-0761-08ded8077cf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|23010399003|56012099006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: hSlXredy/2lrdOc8PyiiJ8/rYln/3JYsb07n0+gUMtiKxnBwDB3L8qVnFSDvHfCITpuKsotovmjgNAkalum8P0kHSjbEcfun4h4Ko1YOGICvqdjUSNn36CJHPTAEuYk0QIY0DUTAtccAXPA/oRrLzBeuIEauIBT3U6GWAkmToBNuj6RnJV/puMDCyUD0arUi0OkP87JdzesqvE/vkf5axZnWlNHlbGkSrYPV9eUKjwY443E02ZBw1wzhLGykk8DChk6riGIn0D8OxJDo6RtVzpMZLW2I31a6Fg7ZqN2oElGQBmVewBeb/HoBB2grNrCXdI9lc83+dPZeYIPwA3x0X3R6SqgwsXlZYfViB6kJc7TL2CJyx4QpPSOBZmAGDj0gQVnvRlrLv+x/30CYqOCTkIFrgCPK3jjboE9p/QQ9D75A6UU99m60W9rz/baNsj1TW4R/rj/VSy+M22M8MV3AU/KN0RRbDfpu3rZQivqcxiYLPWmzrFwJiF+3wdgMR61GrWSrLV8nQyLi0C3mv/MWABz/q/D4BZgiv7KaW3f5LbVqVRwPdjg0TjzjVFUK161w1R/oLvPr1oJ9/CRxOUi55FCCKTYJ5hcsJVq5vGHZAsvNnpQlp8S2CnW0nXdQw7Moe+wzud60bQoJnWSSpQikah13PFKZH/fT8nL7NiD6GtuEXLryX/7auSMhOETMl36bysFg+7694mnShdvUiGMllw==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(23010399003)(56012099006)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uh8Eg1wVm2Sx/dz5LW3ATl+cnFq0FjayNs2oELICtZjF8m4o6rvPPWsAivWxXBleMn9097ZUut/GFhM2DBaSo4kcs0Lw2vuonJqyae1DoS6e76rp+59ZvA96uO2HtR1yDzMZlqI22PzFtGEp+6lrV0HTpFDbP+1V1EKRkVcbJCZgmOFagZmfgyXaLMcyZP20rrRK7ByNznPZUE4I6NbAKZBKgb+mdRSjv3a+sQnsusntyJHk9vzyz6KPiczuFfTNbjOsxZYHbVDFDQEaibR5jc+luZYxbA12tcE7Ljyri2dEd7EBGxR2lSwAcDMiBr6rUc9iIoNpKMRk2GlYFMTjV+bWcc5GKkakMt+r3pmJtgdxswWlo0vNHlw2Lronu4UvEhlQmlsoIXhpFQariS+MUtuOwLZnhxNyAau7QSZxK/6YQxfc4yck/xZ0H3xDh/th
X-Exchange-RoutingPolicyChecked: eilen3GZPAUCCe+owVlJneH2Sf972T8nGtF4C71FMfCi5MnbcIA0y6JbWn5cEPS0Z86ToK8k0+JXKxP/ycYlFn2xpQLdMO5ZiHK74go1iWsBThVDHqpEZ0+o6maaZYMXD1H9s2s3pOrphAuV2/2nZWlJNzRNpPgzkBR9M298X4jbYK2sOg4jheu64qfk02HXdkEzpSMeLXG9FWXt8KRkJddBzFEL+4BdxLxrxMqQLWshh0iNly2078v4aT7t+D6myeWRk0Zp1InYzYCXkmQKtHcU3AkbYGGIvPJPxMDkN6cmVua6QzrPRwWclMGCCHcEVUBUYN672LRwxipD0AZ06Q==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 06:59:40.4878 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3318531-4c92-4412-0761-08ded8077cf8
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB997578
X-Proofpoint-GUID: seNuSKW-FRiiamWsvkObxu9TxBCoHqr4
X-Proofpoint-ORIG-GUID: seNuSKW-FRiiamWsvkObxu9TxBCoHqr4
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDA2OSBTYWx0ZWRfXx2gEGUs+EkK9
 5FE/hhaDgT06+JQNIDXAiyYAatyzcLIbUqE9WO5RA8rFwztMkT6VFz8iSqZEePvmroyXbQ3hL8/
 4YPAeMBlJkj+qnSQTIKaSRSG1B5yueg=
X-Authority-Analysis: v=2.4 cv=cfPiaHDM c=1 sm=1 tr=0 ts=6a460c60 cx=c_pps
 a=Mu8XLVeRokUZEw2RBKxlnQ==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=sozttTNsAAAA:8 a=OAlMMrMIfnwMU6RXJ2oA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDA2OSBTYWx0ZWRfX1q7QIOgjfEDr
 ZJRlmdTyvdFTnyK/RBwMf8R4pEz34iRQRcuemgM2V1KCFXQrhaC75UHnb4oJ4+3t1IAlLSLdQVe
 qdCnc422JVOpR1WjwtwS90Zkgg5s5gwy0UWDc4wGlUDqlkU2jI6tV/0IFfTeG2FGRIMdxBGszcw
 ISuYszet+BAT4LlIf2xlhZRnxXtVy6ntEO0WV/Cj14Q552tOOgBkTVEbknLQw8uys2aMBdbe/op
 yuPujygAg2tK2jm3BoPECTqif7lFKdAaJv3xb40dWenSzrrn2Saxtt+646RHYnA6lNnDcHoLNKM
 s2pEDRvTk1CqB1XBKzx10zG+BM5anE+7WBG2txrERIDV+4+jPB1/xI6OWhX2843CjzD+jX9K38t
 d/6TUEFljArsXbhoR30JHO/pnERZpLQdnUbu8EAwxCAls6Al4xi91BH/bIE10Wc70rupCDCZ5+0
 SakHcVw5reweqL0wxvQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020069
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

In cold boot, the value of CTRLMMR_MCU_RST_SRC was not being reset.

This leads to a reset-loop boot failure when a warm reset is triggered
from the MAIN domain (by writing 0x2006 to MCU_RST_CTRL).

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 arch/arm/mach-k3/am64x/am642_init.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-k3/am64x/am642_init.c b/arch/arm/mach-k3/am64x/am642_init.c
index a15adf1cb1e7..a177c2658d49 100644
--- a/arch/arm/mach-k3/am64x/am642_init.c
+++ b/arch/arm/mach-k3/am64x/am642_init.c
@@ -255,6 +255,8 @@ void board_init_f(ulong dummy)
 	if (rst_src == COLD_BOOT || rst_src & (SW_POR_MCU | SW_POR_MAIN)) {
 		printf("Resetting on cold boot to workaround ErrataID:i2331\n");
 		printf("Please resend tiboot3.bin in case of UART/DFU boot\n");
+		/* clear MCU_RST_SRC register before reset */
+		writel(0xFFFFFFFF, CTRLMMR_MCU_RST_SRC);
 		do_reset(NULL, 0, 0, NULL);
 	}
 #endif

---
base-commit: e800cc67f5b6cb50a20f37c993ec1cd4063bdbd3
change-id: 20260702-am64x_sw_rst_fix-eb5436122780

Best regards,
--  
Anshul Dalal <anshuld@ti.com>

