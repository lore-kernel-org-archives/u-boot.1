Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59984CD98F6
	for <u-boot@archiver.kernel.org>; Fri, 19 Jun 2026 23:17:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA497849A4;
	Sat, 20 Jun 2026 01:17:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="QZV/jExK";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="xUFRJ+1l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 318A6849AA; Sat, 20 Jun 2026 01:17:45 +0200 (CEST)
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1171284873
 for <u-boot@lists.denx.de>; Sat, 20 Jun 2026 01:17:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 65JLY73P095828;
 Fri, 19 Jun 2026 18:17:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=b0GxerSCSh9M30ckFh5QeHLkDek4qGsQnHQj1lXFR
 7Q=; b=QZV/jExKSjZSFGYWLCubuKJAAhGGw08FPQ7kKG1yF43pEJ9sBYMu7xOml
 aPLLh807EPYmeX2dD8KTf78lE2od5aXiQp9QrKWgt2Rstcmhm8dHgGRhNafl15ns
 PcosL7UI2rhuLXfGN9CA2VhFHBJlLl3KWzPsOHvYQPpDwCwqiC956tcptOeuDYiK
 qhtH0Ux5WJMm8Sn/8I/jq6UfPurWmzS7NptD8N1aT+pnVxXaaXRub6NegitRUOTN
 jFbDwxzOew7W0dvU31JrnGkji75ANm0svlV1LzrCUrVByI3+8r2V45tKkhIKyhq/
 W1d/oMJNwuk+/PuQGyp2jnaemD2fQ==
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azon11011035.outbound.protection.outlook.com [52.101.57.35])
 by m0380145.ppops.net (PPS) with ESMTPS id 4ew4s643je-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 19 Jun 2026 18:17:29 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tcTXPnbJwizb77VvWRbO4YRe57J/fbLR21KrIjTH7x/EPKh3s4n26d7xZCT7IDyDSnj0Qi4RQbwBGKg3b8QCtm66pj1nHeJLh9zHnf79UG9cyiKvv0oveW36e3nvd7pyDWks4lTnZiWRMnUUr0DQMVCO1Oa7Owrx9ujn9/i4ApaPJvnMXtlIE2BB+fOuXoe7FYzrcTnEziggtRwntmfUp5ddB/QWxjqbRmNICzCA/MZzA2maHVsqT6xusuzedyQ8kDJbD38Uh/Vy/sTbK3LLbTkC+0fvu/25n9dt8j5r1GF6+NYD0fw9EPtniUcwwqfAS3J/WjM2MQOHbnv3glFpzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b0GxerSCSh9M30ckFh5QeHLkDek4qGsQnHQj1lXFR7Q=;
 b=t6pn245LGz3PF6hldBOVDO5Yvlu36wHg/Wz2tLNjxCd56DdU+/7oc1NvIb8/16p3XizApTyDAmL19U5EZyZuoCxNRHTUFUxPFnR5l/oJiyRUluBw7yJMdcZ3UGB/LewH8IB7BJjphyxViNFg2kJ3EMTEBV2M0/nnwDeBd38p5TqnclFJoEMlZ6MJRGcGN+4txBLGJIGtrUo8d9Zj7H55U4UVDsz0L8AE2EuOboVWlcFw8Jht6vLg1dSqMmP3dTNEB1iGvwplh4vBQ+Mpp37Eo4vPI4X+I1/EkG4tBtFHFsJpRfbxhQI3tYR1grHvOWeL8+1oqd7qaRsvEba+osdQpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b0GxerSCSh9M30ckFh5QeHLkDek4qGsQnHQj1lXFR7Q=;
 b=xUFRJ+1lP8rJ3YIJGC/rHJkFe8y043klmX88jw5YZmJlICyhNBQWh9WmGvYGjgLrvTV1GGFlhhRZ7F8xlAFcKaaAhzZuuIL/AHyS35joHQutmnBlCC+EQREaP2myCVWXgU/JStqOW8Ml/vVQsBp2RLyN7FTmMwUj/Fn9p5NQi/g=
Received: from SJ0PR03CA0123.namprd03.prod.outlook.com (2603:10b6:a03:33c::8)
 by IA1PR10MB6853.namprd10.prod.outlook.com (2603:10b6:208:426::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Fri, 19 Jun
 2026 23:17:26 +0000
Received: from SJ1PEPF00001CE0.namprd05.prod.outlook.com
 (2603:10b6:a03:33c:cafe::58) by SJ0PR03CA0123.outlook.office365.com
 (2603:10b6:a03:33c::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Fri,
 19 Jun 2026 23:17:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF00001CE0.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Fri, 19 Jun 2026 23:17:26 +0000
Received: from DLEE211.ent.ti.com (157.170.170.113) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 19 Jun
 2026 18:17:25 -0500
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 19 Jun
 2026 18:17:25 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 19 Jun 2026 18:17:25 -0500
Received: from rs-desk.dhcp.ti.com (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65JNHPGV3686026;
 Fri, 19 Jun 2026 18:17:25 -0500
From: <rs@ti.com>
To: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>, <sjg@chromium.org>
CC: <u-boot@lists.denx.de>
Subject: [PATCHv2 2/5] arm: mach-k3: am62: add &main_uart6 to clock and pwr
 tree
Date: Fri, 19 Jun 2026 18:17:16 -0500
Message-ID: <20260619231719.3823195-3-rs@ti.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260619231719.3823195-1-rs@ti.com>
References: <20260619231719.3823195-1-rs@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE0:EE_|IA1PR10MB6853:EE_
X-MS-Office365-Filtering-Correlation-Id: 668b7e64-2bb6-4ba6-eddb-08dece58ed33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|23010399003|1800799024|921020|13003099007|18002099003|22082099003|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info: d2LTsCKk2cXd4QpOelRy3NGvrFxbQiA3FGZCBEYjYjVNe13G1HY+KOXY0fc3dXirC7hBYrp1HoEYGqbTR6BK8oa6ZkaTuGMSrhg9WMpNrSLfnWSrG2bwYiujLq0xxOsu8Yv1GB66iokcmn6y3jIUrje3H5O5xHyeWNuEh4/CKhGlY2HXvHNCGbpPuRllHNpNWIRr5X3wl/bZy1OVAg2GNmsEuzJW0xs8JPx0cECIzMm9Oal8wDhVeeRKiu/v87W2WbNgAgZ7kOZEvCMWIPl/TiFuRqEpTGCxv552gPdI4WiMRtbf9telwITZf88ScaSVf4knG28cIF602uKCkLyY+dKwx1xGN1FnbxNYjtWPM2/vVFZ2HknVeOGAxzihRvW+hxl0WXhgdzG9g7l2E4ZCMZi/ohYkgglEnOA2I3p7qqOmUMxMpA2vBLAbC1todRqgUPQdxKz9FI0AehodQENRLJ3rL4dcU7R3AWsbF7M5MbpQpBs5ZZgfycCwrJQC5ri5YE6I4l6jttqWkELYovAG+n6VrHViBtGV9VllDbWrZnKJl1Rc+IDmihIlSWcnAmCCUUUSaohBHwBLfq6/c6YZtP4+QMqLFyOwTqrbHNDE2iJvEkvx+V+4ielCegKo2CPQaJanDTgVsBTsK5/hRGBq2bSRtQI+IAtAW+CigW5+8FHpwF3RxwVcE0dOLth+kbv9
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(921020)(13003099007)(18002099003)(22082099003)(56012099006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lW8/AZ+uw79fKMWrQ6okrROs1EYWiuT0NoXFaYWJKk+YEgo0CZ38XZtwj2H6K+hfAAisHQWR8VkEeB7zwM2PaC3yoN8OZM1suuSpvF9raMfYgIaPk69JiAxdgey+XfuENmPGqnYqk4Td5h0lp7oVJ5YXl/+pXjvP2uB1zv44hGaREfbCW1gXM7sgkU0AQgoOvwLNoGW9M1n8pg9ruR48Gew/FRCzBJt9k7FB0v+Les7dDqZhe4IplCKbXEF9y580r8+qhEgQQ3ruWfXVpTj32qVbIe1BqvDDSWne70At/tbHpyrufxobS08nZGGx/TUliDJUmiX7/VowSOQtVrWMSlL1CGyxQx5gxkuqOUBXyL8pY46mNiLp0HPRZ607E1kEk6KY0Ey3HPGbxOhFnTNAScFFtVCt3JORSagWWmc3LrEvDSxU96Hq3VBy4ZDNol5p
X-Exchange-RoutingPolicyChecked: iPdh3gHbPlWS81cD6yqZofK77C3+DZnPd+m4LWnqtrQ+bH0qv146U7EuMnAxzzAn3/t3PqXt92WzxfdoyDwEzF0VDNjgiZBZxTdZPwT/S0eJqLg6mVgnBNZrRpHnCFMTWRs19CbCN2jgI/gk81l1D8akyeMTDkhG5RZqYz2pBwzzXc2nPuCRhhvWLHYsmhF1HT7glOMbKEDw9mqXwRuQERIm6nwGdT17KoHg0n560DVRwWgK43UX/nzFV2WtLX25RVCGAG2ydigWX5N1BPJjcxW9+1IlWH9Idci+oS3KaZ2EnWXERLttGSOrKoUbsYsKXxC/F9h/UJ0W8gWs0PXYHw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 23:17:26.3985 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 668b7e64-2bb6-4ba6-eddb-08dece58ed33
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6853
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDIyMyBTYWx0ZWRfXxnTCMZDMFJta
 w3ZNjDKMH7cxgMcc6UlnIkEVkTXJTsszLQLzTh5cV1qIuj32Ix9yMYUDOM9sbyrEP4+wowa9Yjj
 Z0GWearadVchihCVbS3n4uaO2ROkhgE=
X-Proofpoint-ORIG-GUID: fE_AFt1HwvxVvZWdAXNO3-hSCKsHi6Ty
X-Proofpoint-GUID: fE_AFt1HwvxVvZWdAXNO3-hSCKsHi6Ty
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDIyMyBTYWx0ZWRfX14PDkDUvZ457
 lcvaQJvK6xELPezzI0UVggWKYQHMk1ZUvapHsXN+InvvQwPSJFUtwHqUhMHgq9o6Tx80/0y89mT
 ZeJYJ6Z9yC+dcNkNmVWDGmRllryp8osNvDK4wK9q0wNTPH/qTsYArl1UY03PSVdw3Q7malV9QkT
 O6iZbaYtu2EhV6hGp4/9CCrYCO27lvkpo382UgAnltRO0TAZehgVR7NYHts1+YpeR4CAcCYIJ7o
 Pv3Sxetu6OBm528525aAzWCZWbd/Qt/VI/E1q2iYqXXXlHVWSE4zHlH+tRb5kjP2m4VuyOosJBa
 kogjYZj2Zpxp8gMPdxuAey3awAdDLXjQNYGiMcJPk2PEUJtmr3lpAelaj0TMBK5h/XAEZNOV1LZ
 gNRpwssA+gMoXPLe0foVkgdwFpXD/aEa0LKF8nkFvhIJw4qXqgZBDWaeztnZdfIRgoAnOXmJOMO
 EjRKaG/ek1Wd945gGyQ==
X-Authority-Analysis: v=2.4 cv=P6QKQCAu c=1 sm=1 tr=0 ts=6a35ce09 cx=c_pps
 a=MvJzBjTJNBx6A1eu3kpgJw==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=FelO9ux0wxsA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8 a=WtDTEybOK8mIDu76bVQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_05,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1011 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190223
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

From: Bryan Brattlof <bb@ti.com>

The pocketbeagle2 uses the main_uart6 as the debug console. To get debug
console prints at the R5 SPL stage, add the &main_uart6 to the R5 clk
and dev data so we can configure the uart as early as possible during
the bootup of the pocketbeagle2

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm/mach-k3/r5/am62x/clk-data.c | 19 +++++++++++++++----
 arch/arm/mach-k3/r5/am62x/dev-data.c |  5 +++--
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-k3/r5/am62x/clk-data.c b/arch/arm/mach-k3/r5/am62x/clk-data.c
index d7bfed0e031c..05cced0b313b 100644
--- a/arch/arm/mach-k3/r5/am62x/clk-data.c
+++ b/arch/arm/mach-k3/r5/am62x/clk-data.c
@@ -3,9 +3,9 @@
  * AM62X specific clock platform data
  *
  * This file is auto generated. Please do not hand edit and report any issues
- * to Dave Gerlach <d-gerlach@ti.com>.
+ * to Bryan Brattlof <bb@ti.com>.
  *
- * Copyright (C) 2020-2022 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2020-2025 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #include <linux/clk-provider.h>
@@ -125,6 +125,11 @@ static const char * const main_usart0_fclk_sel_out0_parents[] = {
 	"hsdiv4_16fft_main_1_hsdivout1_clk",
 };
 
+static const char * const main_usart6_fclk_sel_out0_parents[] = {
+	"usart_programmable_clock_divider_out6",
+	"hsdiv4_16fft_main_1_hsdivout1_clk",
+};
+
 static const struct clk_data clk_list[] = {
 	CLK_FIXED_RATE("osc_26_mhz", 26000000, 0),
 	CLK_FIXED_RATE("osc_25_mhz", 25000000, 0),
@@ -210,9 +215,11 @@ static const struct clk_data clk_list[] = {
 	CLK_MUX("main_gtcclk_sel_out0", main_gtcclk_sel_out0_parents, 8, 0x43008030, 0, 3, 0),
 	CLK_MUX("main_ospi_ref_clk_sel_out0", main_ospi_ref_clk_sel_out0_parents, 2, 0x108500, 0, 1, 0),
 	CLK_DIV_DEFFREQ("usart_programmable_clock_divider_out0", "hsdiv4_16fft_main_1_hsdivout0_clk", 0x108240, 0, 2, 0, 0, 48000000),
+	CLK_DIV_DEFFREQ("usart_programmable_clock_divider_out6", "hsdiv4_16fft_main_1_hsdivout0_clk", 0x108258, 0, 2, 0, 0, 48000000),
 	CLK_MUX("wkup_clkout_sel_out0", wkup_clkout_sel_out0_parents, 8, 0x43008020, 0, 3, 0),
 	CLK_MUX("wkup_clksel_out0", wkup_clksel_out0_parents, 2, 0x43008010, 0, 1, 0),
 	CLK_MUX("main_usart0_fclk_sel_out0", main_usart0_fclk_sel_out0_parents, 2, 0x108280, 0, 1, 0),
+	CLK_MUX("main_usart6_fclk_sel_out0", main_usart6_fclk_sel_out0_parents, 2, 0x108298, 0, 1, 0),
 	CLK_DIV("hsdiv4_16fft_mcu_0_hsdivout1_clk", "pllfracf_ssmod_16fft_mcu_0_foutvcop_clk", 0x4040084, 0, 7, 0, 0),
 	CLK_FIXED_RATE("mshsi2c_wkup_0_porscl", 0, 0),
 	CLK_DIV("sam62_pll_ctrl_wrap_main_0_chip_div24_clk_clk", "sam62_pll_ctrl_wrap_main_0_sysclkout_clk", 0x41011c, 0, 5, 0, 0),
@@ -336,6 +343,10 @@ static const struct dev_clk soc_dev_clk_data[] = {
 	DEV_CLK(157, 164, "clk_32k_rc_sel_out0"),
 	DEV_CLK(157, 165, "gluelogic_rcosc_clkout"),
 	DEV_CLK(157, 166, "gluelogic_hfosc0_clkout"),
+	DEV_CLK(158, 0, "main_usart6_fclk_sel_out0"),
+	DEV_CLK(158, 1, "usart_programmable_clock_divider_out6"),
+	DEV_CLK(158, 2, "hsdiv4_16fft_main_1_hsdivout1_clk"),
+	DEV_CLK(158, 5, "sam62_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
 	DEV_CLK(161, 0, "sam62_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
 	DEV_CLK(161, 1, "sam62_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
 	DEV_CLK(161, 2, "sam62_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
@@ -361,7 +372,7 @@ static const struct dev_clk soc_dev_clk_data[] = {
 
 const struct ti_k3_clk_platdata am62x_clk_platdata = {
 	.clk_list = clk_list,
-	.clk_list_cnt = 90,
+	.clk_list_cnt = 92,
 	.soc_dev_clk_data = soc_dev_clk_data,
-	.soc_dev_clk_data_cnt = 137,
+	.soc_dev_clk_data_cnt = 140,
 };
diff --git a/arch/arm/mach-k3/r5/am62x/dev-data.c b/arch/arm/mach-k3/r5/am62x/dev-data.c
index 59c95df2a887..ea1e76a8a758 100644
--- a/arch/arm/mach-k3/r5/am62x/dev-data.c
+++ b/arch/arm/mach-k3/r5/am62x/dev-data.c
@@ -3,9 +3,9 @@
  * AM62X specific device platform data
  *
  * This file is auto generated. Please do not hand edit and report any issues
- * to Dave Gerlach <d-gerlach@ti.com>.
+ * to Bryan Brattlof <bb@ti.com>.
  *
- * Copyright (C) 2020-2022 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2020-2025 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #include "k3-dev.h"
@@ -61,6 +61,7 @@ static struct ti_dev soc_dev_list[] = {
 	PSC_DEV(36, &soc_lpsc_list[11]),
 	PSC_DEV(102, &soc_lpsc_list[11]),
 	PSC_DEV(146, &soc_lpsc_list[11]),
+	PSC_DEV(158, &soc_lpsc_list[11]),
 	PSC_DEV(13, &soc_lpsc_list[12]),
 	PSC_DEV(166, &soc_lpsc_list[13]),
 	PSC_DEV(135, &soc_lpsc_list[14]),
-- 
2.54.0

