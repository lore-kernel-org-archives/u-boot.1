Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FCB5CDB479
	for <u-boot@archiver.kernel.org>; Wed, 24 Jun 2026 21:20:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D168E849D2;
	Wed, 24 Jun 2026 23:20:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="lmaIJLKO";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="H3cMXPfy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18851847C8; Wed, 24 Jun 2026 23:20:10 +0200 (CEST)
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17BB18460E
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 23:20:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65OJsJCx1332358; Wed, 24 Jun 2026 16:19:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=b0GxerSCSh9M30ckFh5QeHLkDek4qGsQnHQj1lXFR
 7Q=; b=lmaIJLKOKhK7qv9eYInjrr/oeq8WPXh8tMJfZdCxPDg8sPajOfZKovxKK
 rjM3044Ows3/0NzkbyBaUmoZ80WejLloL6+ophy5PBozzgChnx454fqkGMz2v9gD
 ysT+1So6Z25LPaGP5CGPRb5MqaExK4szArjZK6BAtnTdTUspvxfuxf7/E5BrUm3V
 R81fb23qjuUwBJAgK2FcexUQ4dJTfoGTDY/hSWkvVp+m2HNVsjYu3y7DGljZK0+f
 25tzdFMv866FKTuW+xr1aLvnmCmVhaq975pPPg04vh3Rh5hCW5WRzjGEUoUWsK/u
 GsVDmPufHLqMTUBySAtMw321XqEaQ==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11010071.outbound.protection.outlook.com [52.101.85.71])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4f0aspcuxs-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 24 Jun 2026 16:19:57 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lyyXPDEiqPytZNlK2P/pv86VC7hUQQBMhhJZtOamZVlGGc7ux6y2CbDkdPYuJqfnpT692dcqQsp2M+SxsF0dlS+sY5AY/EUUimofrXbNDkyIZRcg5f68q2/glLH1HPN8K/5X0J4ih8U1diVRgqaHFd93FTEZ+Rq6LzkOPjE0Q0lIgB4rCvWiAWNNOC3hPi/5B09Rd8Bq0TV+3bzQSIXLskgU70gGrnPtTgprVhzFJn7PqfCkq+Vd9VdBCgP6FhrTenGnNhAhhZTSzfGxZOa8JYg69wVamrUOpcFpRGXw6MlPYRgTmBxmIBxIgLvUiZfLEVwatAWZBL+o0rex59hhfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b0GxerSCSh9M30ckFh5QeHLkDek4qGsQnHQj1lXFR7Q=;
 b=LKFIHzDNwMY3fuNkitt11b3aXubCAsri0n15DS6XIlj48qF8mfCRrnrvbiXweIpXfCfPi2hlT/WOYFtxrbVoX37LnOu+Ma2AXuK3Q36I2ML/i6/Xn2rtPghkQJDJZR/ZMxghG5vTitfdGqblJDdondvrXAzRmMKJwK01fWPUM416QSQjTDW/mFyhUR5PYwNZ3mw8Gk74/NRT5nQ7GW9YuzTmRjHf3FW2dh6gg7byCxZ0yPHKwX+k2a95Qw6FSVwSWFrwh3AWs3QPyL7ArfTm+Epvge7jZzVKlgLkGBG4JqzunBp2N6yNM2mJIHTTLEj3T9CADrQwftq+rjRxsXm4VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b0GxerSCSh9M30ckFh5QeHLkDek4qGsQnHQj1lXFR7Q=;
 b=H3cMXPfy2ysaHUG0ADStqJoT5UW9FKUNTpW1NNrfKct86bkHczoWGKL9m2aznGISNVH+U3xvbzRK4Gn9GmeFJBppd8lMOqUAwQ85VNbSUTfCWHrvH6k/+SNm+1DGhxYqw7EPThG2kjIRlzB99GstXpowCf2NLW2KlnWoUXE8mNM=
Received: from MN2PR03CA0012.namprd03.prod.outlook.com (2603:10b6:208:23a::17)
 by DS0PR10MB8006.namprd10.prod.outlook.com (2603:10b6:8:1f5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.12; Wed, 24 Jun
 2026 21:19:52 +0000
Received: from MN1PEPF0000F0E1.namprd04.prod.outlook.com
 (2603:10b6:208:23a:cafe::25) by MN2PR03CA0012.outlook.office365.com
 (2603:10b6:208:23a::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.13 via Frontend Transport; Wed,
 24 Jun 2026 21:19:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 MN1PEPF0000F0E1.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Wed, 24 Jun 2026 21:19:52 +0000
Received: from DLEE215.ent.ti.com (157.170.170.118) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 24 Jun
 2026 16:19:51 -0500
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 24 Jun
 2026 16:19:51 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 24 Jun 2026 16:19:51 -0500
Received: from rs-desk.dhcp.ti.com (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65OLJprD1851589;
 Wed, 24 Jun 2026 16:19:51 -0500
From: <rs@ti.com>
To: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>, <sjg@chromium.org>
CC: <u-boot@lists.denx.de>
Subject: [PATCHv3 1/4] arm: mach-k3: am62: add &main_uart6 to clock and pwr
 tree
Date: Wed, 24 Jun 2026 16:19:46 -0500
Message-ID: <20260624211949.327905-2-rs@ti.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260624211949.327905-1-rs@ti.com>
References: <20260624211949.327905-1-rs@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E1:EE_|DS0PR10MB8006:EE_
X-MS-Office365-Filtering-Correlation-Id: 87290263-dc9b-4660-1bd6-08ded23654b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|23010399003|82310400026|56012099006|18002099003|22082099003|3023799007|13003099007|921020;
X-Microsoft-Antispam-Message-Info: l5kKuIDs91fLeaDkV6Wcny4lFNVh46VSff5UdhowfrXnielqzrsvYm1Jq0DC8VYX+uzyBK+uBZWVR8WHV665MHlMMsTgIMe7bh+mIG3pXC+zPMC5t/aioEfzwH1l6jih/jVt9mTQfzsKQX+v8OxYvdrG6ayPZBtGVtybwnpxoE3Htb+vLk3meUbPkOLmXuO2SoYvZmCefhtnMWav1KYLKmhD+Se3QgLExQ2KRTXREl5ZMBYINhREE8RC9uvWFJ0CdCbxKPhl9B6rmnde9QFxmA4ZLIcplVWFVm34h6nkDmt/OZJTR8Zfw5kKB0aULw+Wy4fhDPMVIZPmKkeDk/K+L9fyyUzk3fqaPZ/yj/YJ7CskPsCn8NtNzh59bo+VkLK5TqdfjrytbXq9JWBpoum5wAjh8rAAH9giZ3wFpcTjoCawS8IqDS+G5gY3FzNDMmR4N+TtvD63MoYbPqy60KA5a42fyNgUPArcfOdJ6taQO2SN7Y+uSt2oi7CMpYxVRoZb4/86EphBFvNLQuwO0078FW8mxn02M4q6hbKddNHaWuljkBqJIz9oUA32OEKjlnIr/ZKNH0Uqzzc1EBBwYJmdTT/Aj1Tpe/hDqc0HBOfez/xWI1/k92Cd1ZsMrI31q9getUv0fbMUX+WIdFMnRlkZxqGFJWUwxusdXE9o8S3cNCmUz3Mvo/khA1lqlAFdi/fS
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(23010399003)(82310400026)(56012099006)(18002099003)(22082099003)(3023799007)(13003099007)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5B1PKBgxOtdStkB/2D9HSMIZdTgpXHAH6pfZbM5cRL1PuaGCdmKP+FeRbOOZYmeSSlZafp+A6Lwgch6GbYjnxuq8hNiULaG+CPi3lriFSqKxD7xVfzgDF+bXOS1wTRPZs0km22llxZt6GBtJv/yP3r97FCF8fecLazSHy6fNyQ8YbDqeYOeplJx9ojm501DIKoZKgm/0RiWedKUDfDNx7mcz1DIPU8JKjb95ceVxlO//UDiLIZl86cTDZPq5LHZ11HmvmJzN8rz30q1lAUUWI5JSn+pAx7CSQEerJHZ9y99fW8YDbUPIxrGRLuM2eDqn/koDN0K8V4BvV2n+B6l+Vd1rz7LgscZXluGAN/DqQm/XDGTVSP4sjLx47driNXR+L7+FSShN/mfGwTWvOcrR7VRlk5yGKGIkQD2QIxC/zbt7xl/4lzxkiv/iYDDkKtlo
X-Exchange-RoutingPolicyChecked: Qa+ed2kKjHbXKpKp/cwA/NHVyOUEQL/1IIkvKTGQoR4rHu03ZFyHR1x05mhpPrWvoRjNwDuZ6OXn2xb2wG6msN7JBdxVlm+BGOg9e02PLvnMQZ7chyDwvqHmGItHdrLKt//yHXtzCbwLMN3sOb9rMabXsIactFLSiQYYjttJ8QaaQnWmFAXq46pLDADdHqJPcUarPrOsZKc237iyYYlIgHTT6LKeAQmLwF/Los229na6EE0+IssGf3ZmTODnNNgvwXD61KwCE2bYrqW+FHroqxVDEtya0BoUaYzDbAzYxDI+oBQDo7Etv3+wqWegdkujdqzzwQkozeSkqVzworcTaA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 21:19:52.3033 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87290263-dc9b-4660-1bd6-08ded23654b3
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8006
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDE3OCBTYWx0ZWRfX7WJa2mnwFg7A
 aiP+cYzn2W0bXGta/EebFuE+AijBwr2I6M2QAMrz1QYk3B3mScLNe8zLFaPKUPJU3NpkHBFjAoi
 ysYiY6ZuYS5xqZt8gP2E1xW+rZjf8OFih1RzwEZneIcukPSb2jmySUZNjG6/rjn7e5p3Fhkj2hm
 cJClmib/5PGzXlKp88IS4pSTnNWpWm+2gHeeVrXi5qPWwuxMFFXows17cAkfkFbrpVLPBoLzOlF
 3R+C5zPZ4czLVl0eNO/iAyiv3OO4UZjlmVXmZ8fAoheWzFbwOUtIrjpAvdkE+afjbMOTfTwqzTF
 FGIl/uPPfCazGqSUqAnkf6LljkDqm4mnlyI/qFnMY5XEyXErx1Sk2488BeQ83lsCQ3xfm9V37U1
 X4C2QiYFNmHczQiNiOo5lYCF44djRwRMNw9jRV0qBBDrZs4IVx4Iccq77pvNVCE4M2r4qmHQlZd
 t9Asz9Dl/teEG05AfWg==
X-Proofpoint-ORIG-GUID: yrOzGxls_HPTWdxr4jWYXJl2o8PGVPL-
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDE3OCBTYWx0ZWRfX+9+sAlFfhZka
 ufS6dPG1ErAomhO4bTIZVGsGQCqevKXx2y6QdDNBVTUxUe29xPDKPXeZEz5msyjefI+5G7qvP+i
 heSvjY2+fTvGSMCTA2phzVEnguNi2q4=
X-Authority-Analysis: v=2.4 cv=RMCD2Yi+ c=1 sm=1 tr=0 ts=6a3c49fd cx=c_pps
 a=OGRNNHJcR/XwrOfql3gobQ==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=FelO9ux0wxsA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8 a=WtDTEybOK8mIDu76bVQA:9
X-Proofpoint-GUID: yrOzGxls_HPTWdxr4jWYXJl2o8PGVPL-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_04,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 bulkscore=0 priorityscore=1501 suspectscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606240178
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

