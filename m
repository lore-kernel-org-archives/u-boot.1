Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACAE1C44515
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 08:01:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FAA484659;
	Mon, 20 Jul 2026 10:01:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="JP0RtSri";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="KhQiVOcF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69D8084659; Mon, 20 Jul 2026 10:01:47 +0200 (CEST)
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2D2D80517
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 10:01:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66K6TviT1455411;
 Mon, 20 Jul 2026 03:01:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=BUCewu5hczMI5UjcWBMv7kET+Nbwuiutv9wTvr3sX
 SI=; b=JP0RtSriup5EsjvJh+3InoUtQMvuDuU9wL2TLhXUkgP5STj0DwcVx0jDT
 1P2AJBzaby6OVTjXzZ7EkajFR/lp//s3iki+QUUhGBOybNKU+6T0MCoABzbkkaO0
 MbezlugRz0RqtAl9WXSFHbV8rAek5avsFLbH+6d+0xj98ifOz/QN5f4Pr815OcDA
 chX6Sz+gvjI3bh+8NWcxDppfKXmrdM4CjrHFTh+j7rRy8xEHrh8vrc1YcAxg3cqV
 bdvAIgBbj6hc45gitf53vRwmmTBVqoE/hmHClycgJy+ESgdedeq3OM4BtZj8TfMo
 UN8MVu5NpFDUDuB0BiiO1t93LJBig==
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11011015.outbound.protection.outlook.com [52.101.62.15])
 by m0380145.ppops.net (PPS) with ESMTPS id 4fgtgh4mga-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 20 Jul 2026 03:01:40 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q/ZvuUgBGsNpg19TvVVMW8PdOHAn+v4ywMoxJK7/kdkIx+3to6nFihYZlksa10ceQK3SftEyNw9KR6u7qIwFXK1XH9rqmtnP2Muu4C7MiburlhI7Y7K29ZKQiQWMtp/+pi4fVSyiKsAfkQAV/Ww3oTSs39dMPYAWPCSS5KIdAxW/Q8/GlKwEcTrd/xqf1iOXTlcudISUNllCfKazSLcKEnuDl+Ea6uXSbJoHlYum/t4EQMZVzppGINkTXclt/QBerc9ldmrH71dRRsLNPD1ICAFOMuQFfnXXGFxYZ2w4g67fx3uTZG2hRX/u8f+skiJW1BAyIPyiSVbpBqsjXcX6Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BUCewu5hczMI5UjcWBMv7kET+Nbwuiutv9wTvr3sXSI=;
 b=Hv67mBdFDPJSBJ3RguCsY44xzYoc8NzbCqEdFw0OIwXSk4tt8DANpT7UQTz6BRNoRaFdOuza65VzGEIlESIVeJCGS5aSAOHZmdNM+YmklLpWHcXokDBpEKH1tPTK8D8b9iiYnHRb22FvUdI8iiyDC7Qqwwq7xCGPAnK49qBKen2MD71WuJ74Xh2c4E3dE+V4vecsWGX+Cgxd20RLPOw/u3VxxbpxTjZI09dO/7L2ZvvwR1d77QdZIGSrK0CRhgsHwDPg3ImDS58BQ+v+yKNzCzRbedGmZQZCBSui7GwAMh9Hjsln28SKrZV0WI7f6vbu+qps8MlJ6NkGrg1Bxs8DgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BUCewu5hczMI5UjcWBMv7kET+Nbwuiutv9wTvr3sXSI=;
 b=KhQiVOcFhC9sFOl2QppTD5I/vTotvTmX0nghuOrHZis85/255BKBrdUkfY9yYuTlDJNQAprUVLHQv61YjHmpjw+IMyTATxIcrQwgRfoZCPV/YrXtZ5k1FhB4ZEkCJQc0ZaWcSyj81LVNEKxF8cGQ7C+1dqkXqtLIy4lxh7JWo+s=
Received: from BN9PR03CA0204.namprd03.prod.outlook.com (2603:10b6:408:f9::29)
 by PH0PR10MB5708.namprd10.prod.outlook.com (2603:10b6:510:146::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 08:01:37 +0000
Received: from BN3PEPF0000B069.namprd21.prod.outlook.com
 (2603:10b6:408:f9:cafe::6) by BN9PR03CA0204.outlook.office365.com
 (2603:10b6:408:f9::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.16 via Frontend Transport; Mon,
 20 Jul 2026 08:01:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN3PEPF0000B069.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.0 via Frontend Transport; Mon, 20 Jul 2026 08:01:35 +0000
Received: from DFLE211.ent.ti.com (10.64.6.69) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 20 Jul
 2026 03:01:27 -0500
Received: from DFLE211.ent.ti.com (10.64.6.69) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 20 Jul
 2026 03:01:26 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 20 Jul 2026 03:01:26 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [10.24.50.162])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id
 66K81FFn2478591; Mon, 20 Jul 2026 03:01:23 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <trini@konsulko.com>, <sjg@chromium.org>
CC: <afd@ti.com>, <bb@ti.com>, <anshuld@ti.com>, <hnagalla@ti.com>,
 <jm@ti.com>, <nm@ti.com>, <n-francis@ti.com>, <u-kumar1@ti.com>,
 <b-padhi@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH v5 2/7] arm: mach-k3: Add config options for packaging HSM
 firmware
Date: Mon, 20 Jul 2026 13:31:09 +0530
Message-ID: <20260720080114.775206-3-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260720080114.775206-1-b-padhi@ti.com>
References: <20260720080114.775206-1-b-padhi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B069:EE_|PH0PR10MB5708:EE_
X-MS-Office365-Filtering-Correlation-Id: 1404bca7-2933-4472-60fa-08dee6351eae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|13003099007|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: AcTbWg2sYzNFMch+RyTN6PkglrTS2jtsQtvRuFd3bkrixvVyXvboMGEw7yMbzQrsKwxK4LMTV+IXB7KzwZHlRZbATrwh0J/xxtvxpf4ijwIUkRnsqqjt3ikTK4yMV1JezVXU6AcIFOzLeFNmFTQ9OKnEk72BumCGKXOQo4o5shBKZ1wZXyZS0GYZY21Enux01Bmu9Ar98EVyMJFH9yzgi5U3m139U9RHC94zf0zsSPHG2eQ4R2eh8ZNbX6lxG8FM2NeHk8+oDOXgTK+GbtepL40ObLvFBjPpQbbguhSjtPH0LjFlqLsFibkqZlHMDxbKYIz7BRrKCbOpsKwGhFUvpQ9LQpthXhAJw3L+fb+wV7dOJiBm3fugUi8jbuF4oBG5Wlksd/GlP/8G1jZVemi/O9oUy1cCRIeWYwrz9Lww8a62EFBQYGS3meyxfwniMSR/+pE2KVmx1IYPWGkQaUoDn/IdHpolfj+M5b+Yjg+buFoUTCTFFyfkYlF65C3J4d3Pmcyt40UPK+RwW3cwsMP6DQ0OVB0UvCQTwu2CBJYXEZTRm3HCiY7ye3O3aqnaSMW62X7nJ0ibLwnx7Wt2yQDPDjJ5xolqn8s8fi0biCABoPqHCyjcsVdXURARTe14XNyyiFr/cpuW2QvLtmf0YNYaO3i2KhedIqbkPatsj6oxCNUm9i/M9FM7EwC+01hI6JZJ0f5ijLReujCNlp9GnnAItg==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(13003099007)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BTXV36FTATHhCRiSwYbgTvkwUKEw8623M9mrighvqY3VgH6ekYV4bzOHkn+KaySpbNImCnAxyDMgJhZSJGmVXy2W6I/Ag7qRIgEtYOlvl8A1fbH0xiM2IShmNdVfbPYdyy4oPDrFELcapsBTrfJsphQtdPzunajDEZCQPT2dMm2N4LKFc2Fso7prGgSuXT41O2eRQ6x/6R+xrPLLzUyMFymw1q3FIE5tmsUj7Hde9SS3pVbpfFsu4NwdIhwLnUGrxskmnLvRTyZSfKINfJAgZwQ7Az/GaRTtKBgatFdqhS8X79XxSnuOwa8irBqv4V6fmVMjAuJuTX9Af9+35nJRKXtCDyOCA/jpSZ1od0xHV4jFp/btOQFzCKhu8pPICIf/nbk62M6eGPeW4OEY+L+ZDDlANE2NkfOpAdEvpL1hui4EQgnpA4MwGc9fKUzpJrK6
X-Exchange-RoutingPolicyChecked: Rb/UUu2J2AmuGzDrv6xDLbHfRXAhiwW9dLfpMcFsYk8D0rICy89/XBFPixal/ajT08u/MtnapjKx+HMIcfmlt1A6EWPLs7xFinuixmF/38gt+IbC4Y/le0acEl/xBgMibXirZwbNKlcFiQBbakV6gAibR9Z3mYCZwvAKPoZ+J3/TDfxKZwQUt9960FH6F+8+qNH2rUoM1d03WQerPwWZ6j1kUH04zoS264prkv1Vawv/Xdsy9bh0pIKIm1mtNaxnlO/LAgEOE68Lcz1+Hyrvrn+/Dg5i82DZTuhVpzYx0KEPuFpcaTfgKwb+afpeJs139O9hv39H9G+SPDoehgUlMA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 08:01:35.4299 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1404bca7-2933-4472-60fa-08dee6351eae
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B069.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5708
X-Proofpoint-GUID: Udh674AkXv22bbemnqOx7aw50T4NCZYq
X-Authority-Analysis: v=2.4 cv=LtiiDHdc c=1 sm=1 tr=0 ts=6a5dd5e4 cx=c_pps
 a=+kBkz34/1DjdJIz+AnMsKg==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22
 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=cm27Pg_UAAAA:8 a=Vh17HNacWqn-ezHjO_YA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA4OCBTYWx0ZWRfX3O1QGuljj1W6
 Sa5VLcI89qc5J6T8dMBDoxHlqdI3s+Eni3AePCrDDX9gnIzUrLWBRzvKhdED3JPNXVEkinxtePh
 +ySlt1wJZazYPO/N5pGT35X3zuSVzb0vXwur7t4bsRZgfhOj7B+7fpCRacAMaWJiq00mLE+u9WG
 4Ina5fQpbGmScuFv3DicdYmA9++6Xyy7dBb2XXd4VDAwTk09wyjMLzKzf7ARTEmyoV9wh3kGR9m
 sokSZKk2ghq5+nnTeca1OAjsWhGXTDVfGarQZAGZhBbaMjd8iR+l97fMXuk0pYoSGyiO06JE+wu
 Et3dNCyh9EvjU19WmROBZZK72phJlUssB67VbwCCHpT6zs8WhIyXuN466b6DAVtG6ETiyfK7rTx
 uDOCYKfNXKHWFa6/A4iTsnLCDzqEQ7Az/aTp+5XAMwCJ94kPhRCA/spuHIrwAaZLow8lRkkcK4m
 lNLrZiqZgBprpK2f+Iw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA4OCBTYWx0ZWRfX/RlXx1xCPdVQ
 9o8DOwS/40SUCR0yIwEFm8nB2gU0OFOZn/e4Ewk/x+5tREONY+SC/uKmWVo0NmHbCBhDXx1wpgC
 Lhl1vgpf8stzz2YikaRm4PRvkmwqF/s=
X-Proofpoint-ORIG-GUID: Udh674AkXv22bbemnqOx7aw50T4NCZYq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 spamscore=0 adultscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 clxscore=1011 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200088
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

Some K3 SoCs like J721S2, and J784S4 have a HSM (High Security Module)
M4F core in the Wakeup Voltage Domain which could be used to run secure
services like Authentication. Add a config option which indicates that
the SoC has a HSM core and the firmware for the core is available.

Add another config option (K3_HSM_LOAD_ADDR) to specify the load address
for the HSM firmware image. This address is used to build the FIT image
header that places the HSM image in memory during boot.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Neha Malcom Francis <n-francis@ti.com>
---
v5: Changelog:
1. Add new config option to specify the load address of HSM firmware in
memory.
2. Add R/B tags.

Link to v4:
https://lore.kernel.org/all/20260425033742.1519298-5-b-padhi@ti.com/

v4: Changelog:
1. None

Link to v3:
https://lore.kernel.org/all/20251231173621.1069988-5-b-padhi@ti.com/

v3: Changelog:
1. Updated description of config to match with functionality.

Link to v2:
https://lore.kernel.org/all/20250506104202.16741-2-b-padhi@ti.com/

v2: Changelog:
1. Removed 'default = n' line from CONFIG.

Link to v1:
https://lore.kernel.org/all/20250422095430.363792-2-b-padhi@ti.com/

 arch/arm/mach-k3/Kconfig | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
index a32ed3a9683..f7b42a4912b 100644
--- a/arch/arm/mach-k3/Kconfig
+++ b/arch/arm/mach-k3/Kconfig
@@ -198,6 +198,22 @@ config K3_REMOTEPROC_PRU
 	imply REMOTEPROC_TI_PRU
 	default y if (SOC_K3_AM642 || SOC_K3_AM654)
 
+config K3_HSM_FW
+	bool "Package firmware for HSM core"
+	depends on (SOC_K3_J721S2 || SOC_K3_J784S4 || SOC_K3_J722S)
+	help
+	  Enabling this will indicate that the system has a HSM (High Security
+	  Module) M4 Core and the firmware for the core is available. When
+	  enabled, the firmware for HSM core will be packaged inside tispl.bin.
+
+config K3_HSM_LOAD_ADDR
+	hex "Load address of HSM image"
+	depends on K3_HSM_FW
+	default 0x82000000
+	help
+	  The load address for the HSM image. This value is used to build the
+	  FIT image header that places HSM image in memory.
+
 if CPU_V7R
 source "arch/arm/mach-k3/r5/Kconfig"
 endif
-- 
2.34.1

