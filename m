Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4CE9C44507
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 09:10:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B70784B32;
	Wed, 15 Jul 2026 11:10:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="c0YCs+8e";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="OrZW2dH7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BD4684B43; Wed, 15 Jul 2026 11:10:04 +0200 (CEST)
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C239849A1
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 11:09:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66F3jbvu2575449;
 Wed, 15 Jul 2026 04:09:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=jexmSL2qVITMxnbYk2m1Vb1OBCFilYqlbTyMOXL3t
 TA=; b=c0YCs+8eMd0pBykc69d9shyIHuFAxVPOchW6LX7S3qvaeqPKcYfe3E6xm
 9xgsGAcUKZKKYbE+wQ18KRJ9ImS3NMZeYCa+w2J3YSSrI11q1dWtY55+ty7cTqY6
 6J+V/PNeIP1khUYzX+nB/lTlR/c+3ibET1+Y9ndPIAikAwkJ/6fJAsJgqjlQ3DNK
 vgswge3oLzlSfYyaA/0zaRIaO7LV4qoWwKFmAN3ni8lMjOxB6txYnEcuCnMDJz4W
 cxLn5/DLXsYppRpNMv2bTB9vhHYelGky27DDyzOqiUOEzXh9I4Q1gygBbsGEVToN
 pGf2X0zB/FibttSS6i1Z1VRXyC5LA==
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azon11011028.outbound.protection.outlook.com [52.101.57.28])
 by m0384305.ppops.net (PPS) with ESMTPS id 4fe05021gb-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 15 Jul 2026 04:09:55 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P+B04NPZMlwG0R30OCyR4eZUQTwoh7xLBBsRURkk5ZmlY5T2Z3mAIzisOevP5IP+v+nw4bNWJJMPUvl++9Z20gjf0n3cNKGgpaItuI1IGBmX7RtS9o6o63PS3hu2LE7IC2qGipoqYO0D4YO5mHvCycaD4BcqbM2sHJR/M3Y1K6ExF9KgFYpSoJbtG2LDF6bsTDXXWrVU+9JVqvM3I0Leha0Mq88uSAw5iJs+d6VbZOOiScU0kDHNpRMnHYoIFg2NO4csikCeW2vofRZ+e6e12F3D4rAyysChe+3uq9iLxswzSdIU5zMFzniiuznL7XTYHKHZaZHuznwyRUVpUyr6ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jexmSL2qVITMxnbYk2m1Vb1OBCFilYqlbTyMOXL3tTA=;
 b=ujJmmaSx9XHpSLK1FsRAzEQ5Sd/LRm2brSwbC1HIcOWKelCOlLFN2mkfDk25pAWkH+oYPtQeyj9gYuENsHOIAq/hwQAQllupWA9kVA6Er3xnwXi+KHIYkt6q6cHgYZMnnASaOwJJ8yZ7UaMSOSFZmvXKWgwc72/zMaqwqdtVBIhHKOBmCi7GXR1bR8cEmQfqOfW/s56ZGinHxCtSPwYJ2xCEPzzzfdVkJiubUG9Nw3vsEBRYN2h5jVGaUi2qGHmdtCcuFapeSmnaE3xh3TEvsbd7RSx5qkAR15+UPdLFEb9ebUwsDPES9FkxSgVzozHzdvunDGKcihVJldwgXkhtTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jexmSL2qVITMxnbYk2m1Vb1OBCFilYqlbTyMOXL3tTA=;
 b=OrZW2dH77ybdeIcp58OYIxDYBhCcgSUTR+HsTWSNBtbUUeVnO6LVLJkQ5UMzOazaLWi38ImHDM8OVSiBHA1riBQI/34r1Dtpru8Xrt7LnqdeR169fEfwq7aoMjT5nTa4ZGR244HhcOLqUdbe3pp4Gd1tA7xI/HJddfRrMeqeoEU=
Received: from SJ0PR13CA0234.namprd13.prod.outlook.com (2603:10b6:a03:2c1::29)
 by SN7PR10MB6666.namprd10.prod.outlook.com (2603:10b6:806:298::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.9; Wed, 15 Jul
 2026 09:09:52 +0000
Received: from SJ1PEPF000026C7.namprd04.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::93) by SJ0PR13CA0234.outlook.office365.com
 (2603:10b6:a03:2c1::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.9 via Frontend Transport; Wed, 15
 Jul 2026 09:09:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ1PEPF000026C7.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 09:09:51 +0000
Received: from DLEE212.ent.ti.com (157.170.170.114) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 15 Jul
 2026 04:09:51 -0500
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 15 Jul
 2026 04:09:51 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 15 Jul 2026 04:09:50 -0500
Received: from localhost (ada0543016.dhcp.ti.com [10.24.50.146])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66F99nkf2112318;
 Wed, 15 Jul 2026 04:09:50 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 15 Jul 2026 14:39:49 +0530
Message-ID: <DJZ104DFNA3L.1JQXVSDWG8IFK@ti.com>
CC: <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 0/3] Enable Ethernet boot on SK-AM62A-LP
From: Anshul Dalal <anshuld@ti.com>
To: Chintan Vankar <c-vankar@ti.com>, Andrew Davis <afd@ti.com>, "Bryan
 Brattlof" <bb@ti.com>, Wadim Egorov <w.egorov@phytec.de>, Anshul Dalal
 <anshuld@ti.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini
 <trini@konsulko.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260710102229.2980029-1-c-vankar@ti.com>
In-Reply-To: <20260710102229.2980029-1-c-vankar@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C7:EE_|SN7PR10MB6666:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b921195-f556-481d-fb39-08dee250d3fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|23010399003|36860700016|56012099006|13003099007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: +CtWukoTk63hoeBKAF8Pw98a6IAWLenU8uij1jgbjK64p7suhVfGCYV7HTFthRK0S09X02iEhsejSHB4qdbEI7WUkgrPSaIGQ7YKCBMPO6R3BeHWTt/4v4NpcZDqSpfXGu44Qnca6xHIuO6MVx/KNRJ5SzFcDHBbOwLc4rYKScw1kf3Yi0kwhGngxdkAV0lVbcoHU88rENviUilMzXhFD/woO1rBkLfEOPFIKsfCf7Y5EN7RIr/xNWTK4PKy564CfM7fdAi9t+zOY7Qh7a3KHV3nckqDxd9utGw/wQz+6BaUKbjdif5zacjkazFy27XOzwetZfBt3p1O4t2298OZEyOLb0pUTsd0hUcCGdQzEq+FTnz8TaNhaOK5Co+fw5C1cRNnQ+JzOuKzS/jKXRx1tI7V+FdXpGqGSQzTLbSXWxkPGJHj/ZmqPXVDheIpqam9R65RKWmIggOLFvEzBt7AiLt8Zp8b4CBNwFq8ZnWN0yh09X4m5+rKH2mAfkGr2ahA42WDpVZvcufDpGW+iPKGneGCbTayIZg7V98AKldUHAUEalkKIA20y5faE9QSUdxelLzyZmfDMyzQMKk7Q5JbEtjIwOxt3abwj8ZUGhQYE9aXNq81qwzIsxIbRljkSk3pYm1nUOe+GXMhqrKiTcF1UhueFDxPtd87kIDkzadA1PYhWAxX/riF27JIiGPqULMm6BoQ5MD+1/LBpE0Sp1Fu/w==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(23010399003)(36860700016)(56012099006)(13003099007)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jut1/Ulj9VkOJKJ/mQYU8FSQLCMAmGwQaIoClnL4Zh9cxctDOVKdm7/iytC9Gv+6CYG3vOFM3zVKJLTzZFvWKVG48gc9/FeUtDpoQA/2wVqrZEJu7cg17GvROWn5DrKX4udNBtByB0ZArLmV50cVZOZiuMazSaN2Ge9Fdo8r0NW3CBI3Z5pHr+VwkFfX92AuL8rDayQKiCLRNuD50ydbCmp7eJb5gCCjs8MLWMZvcDMWIUZXJhVgUbSq99caBhLinX7i2UHyhUbozrjjvFDD/YDxM3SyblMN0mJytaHrFJHfF/hpDj/BOUVT5mx/zI2JTaEgZWx+hE7RnyXZxU+QcGUyF4KJPtiwswmtxZAeHptH3crUx+oX5QzcJY5ANYEDHpx71tyRXjder4KrN4UTkar4VQoX7cV42udF9c1A68CL4biapZX7GRP91sJDaSca
X-Exchange-RoutingPolicyChecked: bXe9Ud264XzzVTb4KTy+UM54Jt7YYOTXLEKLkLq78wQYQPgXLqFq43cT2P7p7O+ZOARV4rOG7uOIlyjs4Pjjw1FOq3sTLzM0UcCCSLbsXU2A5an3wWES8Hi0NVKnwB1fyhVz92jLfZFk+jWapJPmitoGqW7p1OiPewoDX6wwAvlSRVuVd9JYySIlyD7T6evbLvlZcPVj/Tvv3yDXvUKqYJ9xO77Dienm33FSjJvLPMr19yubfNG5MgMOfKCDUT6u0JthNwmNIVWYIrdFmkSYvVYE1lZn0J54H4xvXmuUp3+NUUuo3ylBb71Ocp1/wBUQU/B+rzLnv3FJFbqL97LiYg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 09:09:51.3476 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b921195-f556-481d-fb39-08dee250d3fa
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6666
X-Proofpoint-ORIG-GUID: zdx2HTHhMJb2eHpb43vaYjLFa0JwH2vC
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDA4OCBTYWx0ZWRfX64V7dx7eHT8o
 yP9S5zPpToVLZKMpIq4XRxVkafcYtqLpG5FSSsnoCtmgoAgcX/xDYtIYl7Cze7QbASK+Z+i0w+m
 iXjPZwRmb+usIAtwIeNCKpRWU6Q6jkg=
X-Authority-Analysis: v=2.4 cv=KfLidwYD c=1 sm=1 tr=0 ts=6a574e63 cx=c_pps
 a=XNfUKZRMy1FbR/3CVfPpdw==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22 a=VwQbUJbxAAAA:8
 a=sozttTNsAAAA:8 a=NEAV23lmAAAA:8 a=Up-c8VpWnbq0X6Ro7ogA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDA4OCBTYWx0ZWRfX1tX7DqU6Xufl
 RpRDguazRjjjgfV80LwPdAN218LBvdg8itDHi2rNdwdbLbHHtElldWQn/NrTCXWlrTrZFzVAcbh
 ZQ6niAuGl6RvXlRIqP0lj+TOpkbN3yqjrUMIU5dktyAWttvITsWxvtm0JXKuNiS2v3717QA55vj
 bqTnR3V2LXKofOKzNApw4+0UJOHWzn0r71zpeaprmnJ0sBvKQbKW8TK/nhHSeRrgZi46w/SZyX0
 P2/sOQPd+tFwRnIHcJPDG+x8g7QSgpilWxO+qnWGww+ryC3g1Inv9lWpMw899dZ97THKlEq/zXK
 IHCKeKUPyZ2SueCdzEIXT2pC+UXkWcpjMBztyRWIr7tdaNFqVKXpA9IMQs8DNPtDYMduYmA+UEo
 ec/igNV0X+KPWKldMN3pXVi2/b+9HJv4Lx3jpcKWvkZ0nTOii/lPeIZgK0AndxgmnOqgunWWIVa
 eJ43G+/NYhRi4TNEb2Q==
X-Proofpoint-GUID: zdx2HTHhMJb2eHpb43vaYjLFa0JwH2vC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_02,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607150088
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

On Fri Jul 10, 2026 at 3:52 PM IST, Chintan Vankar wrote:
> This series enables Ethernet boot on SK-AM62A-LP. The series is based on
> commit 'a18265f1ccb7' of origin/next branch of U-Boot repo.
>
> Link to v1:
> https://lore.kernel.org/all/20260702081251.2691159-1-c-vankar@ti.com/
>
> Logs:
> https://gist.github.com/chintan013/db875ef8b703094af70ca681659ba7f0
>

I forgot to mention in my last reply but with ethernet boot added, it
would be helpful to document it in the respective board RST as well.

> Changes from v1 to v2:
> -> Removed the duplicate config options from r5 and a53 defconfig.
> -> Updated commit message for [PATCH 1/3].
>
> Chintan Vankar (3):
>   configs: am62ax_evm_r5_ethboot: Enable config options required for
>     Ethernet boot
>   configs: am62ax_evm_a53_ethboot: Enable config options required to
>     enable Ethernet boot
>   arm: dts: k3-am62a7-sk-u-boot: Enable DM services for main_pktdma
>
>  arch/arm/dts/k3-am62a7-r5-sk.dts         |  5 +++++
>  configs/am62ax_evm_a53_ethboot_defconfig | 10 ++++++++++
>  configs/am62ax_evm_r5_ethboot_defconfig  | 22 ++++++++++++++++++++++
>  3 files changed, 37 insertions(+)
>  create mode 100644 configs/am62ax_evm_a53_ethboot_defconfig
>  create mode 100644 configs/am62ax_evm_r5_ethboot_defconfig

