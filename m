Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35846C43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 06:17:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 665B884118;
	Wed,  8 Jul 2026 08:17:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="OiCv0/C7";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="E0PMD0az";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AF018497A; Wed,  8 Jul 2026 08:17:38 +0200 (CEST)
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CD7D838D7
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 08:17:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=m-shah@ti.com
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6685CMEG633073; Wed, 8 Jul 2026 01:17:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=1H25LY1EhP4prwjricd/ifMh6x+HBfl5jTlVQNlLk
 ok=; b=OiCv0/C7IDBvaImLONXzrfR1vsTRGG/rP41pGzfJsHN4zv0ERdrRTrTzx
 wFq8iy4cTZFr6L1V4nGsRSZNz9oDe5nKdqgUPyYicgR2wECLCulZqwrpQxTxoOIp
 U8oUVWRSNq/inn5MR6fXkYemvNIUXe2eO6CyveB/LoYMTJoeWX2BnVHeQGXY0I3Q
 VXVKnNg0EhQ0/Y7zErJLyI6id5BZ0/OCoPOgXP8FR7FPkGjfM0waaEzKFpHKL1+x
 zAC2AacPRYBVq29WpycCm09JlZTbvvQKxt3dQ2sGUVfBGWbgpu22Tsm0MiMWJndt
 S3dp1zvALoSJxNDWUgsYIR48vYVvQ==
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11013006.outbound.protection.outlook.com
 [40.93.201.6])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4f90cb6m5s-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 08 Jul 2026 01:17:24 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ibdm3rFYQ3pv7ohD8MEe+LW+TUMYWIjwZ5dZ6VPblN/nwNqd8RHMYBQuOpy/3xF8tbqu97ZXp+HHNGkCzokA3rnBMPTtsEOvGauo6lh1HnNbxaTwW/VTHMhfrb90lfqUUpMY9Ow3ld3Tv6i0a+yIjH9jo86+KXw/bmoGxPR4nQS/mqcvlyFDvsxIOfNvNPSsE4mNgTQIJmeGTxEIifSmDpTOzoBavyeizFfgY98PmL+/ZqvHSZ9+8OItDaZor7Ws7ksatas/tQTVqhUbRPTTbFQgx92Z5220cqtxEZxQP4GBuA6jSYn5qPcqEB7VlF8tN4goZcr2zhJEDXkfeBSWZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1H25LY1EhP4prwjricd/ifMh6x+HBfl5jTlVQNlLkok=;
 b=Hd3H/ou+UOmyvUcAUzMHijTP8tH6jvxShDqyWHi2u4eGGrnHjEok7MY0YYrl7l0dnNv4Ia34GG1Y6XyIwl5TlioN/qJhb0Q2nSoK9kVNQ7EwdXViBaJ01X09fuayNqCBsFpWrL1kpiHz4m6LWQqjVil42US4u3C5da0yD5kUgQ5yhxxqsEGPEzrN6d8OjFDR/Mv1IlhjD3+VylGWPfelyBkXw1lFW+vD/IwWf3/+R73uC5yzhqWwGMiCu51mGSyg1dD93qDKduJJ/VAqc0LoLcNNV9hsD57oSWiV5h93bVVUyLVeSGSUguIrk+IKngzxuFb0ShFHcDGU37/XUp2G6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=mt.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1H25LY1EhP4prwjricd/ifMh6x+HBfl5jTlVQNlLkok=;
 b=E0PMD0azfQ4PpYDkOa2gXZRIGhre4A4IEzU+7avMlj18v1VCo2BpV3gMGJYH6RzWvv0SBiDksw8qT6ircMOavNo7DF4nt/wcRHRG0uNaVwhvS37FEUEMvWSSKYGH5nwqvVUDSTsntXF6v/oduIhHf6R0g/y2gvp4NjTXQ5AAj8U=
Received: from SJ0PR03CA0130.namprd03.prod.outlook.com (2603:10b6:a03:33c::15)
 by SA1PR10MB6493.namprd10.prod.outlook.com (2603:10b6:806:29c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 8 Jul 2026
 06:17:21 +0000
Received: from SJ1PEPF00001CE6.namprd03.prod.outlook.com
 (2603:10b6:a03:33c:cafe::66) by SJ0PR03CA0130.outlook.office365.com
 (2603:10b6:a03:33c::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Wed, 8
 Jul 2026 06:17:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF00001CE6.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 8 Jul 2026 06:17:20 +0000
Received: from DLEE204.ent.ti.com (157.170.170.84) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 8 Jul
 2026 01:17:01 -0500
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 8 Jul
 2026 01:17:01 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 8 Jul 2026 01:17:01 -0500
Received: from [10.24.50.20] (moteen-ubuntu-desk.dhcp.ti.com [10.24.50.20])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6686GurT1504705;
 Wed, 8 Jul 2026 01:16:57 -0500
Message-ID: <203c16ef-b3ec-49cc-b0aa-431de4b2bb71@ti.com>
Date: Wed, 8 Jul 2026 11:46:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools: binman: fix changes not being written to source.dtb
To: Anshul Dalal <anshuld@ti.com>, <u-boot@lists.denx.de>
CC: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, Bryan Brattlof
 <bb@ti.com>, Quentin Schulz <quentin.schulz@cherry.de>, Yannic Moog
 <y.moog@phytec.de>, Chukun Pan <amadeus@jmu.edu.cn>, Marek Vasut
 <marex@nabladev.com>, Aristo Chen <jj251510319013@gmail.com>, "Wojciech
 Dubowik" <Wojciech.Dubowik@mt.com>,
 "Francis, Neha" <n-francis@ti.com>, "Kumar, Udit" <u-kumar1@ti.com>
References: <20260707-binman_bootph_fix-v1-1-3603996799e0@ti.com>
Content-Language: en-US
From: Moteen Shah <m-shah@ti.com>
In-Reply-To: <20260707-binman_bootph_fix-v1-1-3603996799e0@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE6:EE_|SA1PR10MB6493:EE_
X-MS-Office365-Filtering-Correlation-Id: 07fd0ba3-0b15-4f77-d560-08dedcb89195
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|82310400026|23010399003|36860700016|1800799024|6133799003|56012099006|22082099003|18002099003|17002099007|5023799004|3023799007;
X-Microsoft-Antispam-Message-Info: YRcXnGZ6S2kIfTBhQqTjLxqYUGNCuQe0hhkM1rxtVrLZmujP4AvxtxOV7m9gw6K+ssPmyPPH1gaq54aLFfFJm/DaBxiqYzeib1rSLStHwEgBwCvCiF4pwfA7646x8N//HGkQaKZzZcmAHVNHX6EEq1hvh7Hqm0cTuTfdUJUXtYn6YmFNMvNHRiDHQ9Z1cjqMqnI1xR4sLFyceGezn96LmJO7VklrWNqVySZ8v5JnXbaxMZXBhmvGgfnZkKrMrXX/bDKPhLtGby5GIKKLJEi/hzEdcj7ntIebUcHMOO757lv17DL7+sHd9SW6BT/PAFrsovMZIFg+m2CelChsLnYVzzA2OtPa2wCyYJX51tVRqppSnohIaf2XqYbtme70W6/9Fk31q8ngNAtQlMiOFpS6f9IXRmVj5gNGgnfBBF4pVW35UzJ1KUlLysmlTC6nKukXyiwsmA5n2LwplYR5xw9d13jDxSNfKhKvVXwhnvcO0OQ6K4BvGLxo1Kv7cAnT0M9owI9jdBwzEw3ZIx/FYr3YAv+nD4FhTYa1EnoIZH9WSDsnBdUnVyEfSfCKJxSSFLdEVq15PByEOGJ7YcoD0ZK1v/BOMaPlSWwfL+8CFS4afMEwiOcz74YGYRmWSXUvJ9EIpXnhD3BJ50v1XMPukW/Tpt/tUW1SPi1sP/9fia7884IAdMOlMUUGP3kJMjDZeOWr6DyAcJFkARKIwX2hwJZ3Ig==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(7416014)(376014)(82310400026)(23010399003)(36860700016)(1800799024)(6133799003)(56012099006)(22082099003)(18002099003)(17002099007)(5023799004)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HsJxgEijASmN7ZzhxLqW8Qr8678yi8wdJKaa3EENonw1rCY5MHvTpz+EqgawIxZdCZYGHUCEn0yiJhdFj0EKm5nEHNmKjVOiVtn2YCrAKmTGe3pnd68N9PxaUZA7tbhbyL26yKzAAKknd3tfEs13UinfWgrxDFI68R4gPL/GMIQiuzH03CqRpqiLMZMfPYg7BsyJ5/TICfJDq/xueuX1+i6GTuUza6TzCEb4ufpbLtKx3/KGaXdDWgVuCJJO1Fe27msvSe+3Mwm7neb7Myjj1oYKzeolJ3zE/52vpLvUr/rH5R5stwIibccsMe6efolL8LP+mzNesb/voCmQs73/mknWSmLtQaG8Ay6+FUHldVU7H5/A3UINZ4BLW0Ems0lEu5U1UeiZPqC8SwPAfk8NXWUMkmwprlA2YS7qnZioPa1PgQLF8r+Vmty2tbNOsHVk
X-Exchange-RoutingPolicyChecked: W2RLukjR6aHte5z2tKtE2RzlxXrk3nuS5OjidFtwcxRAMAb+BBKDChiB4JcpuaaLKFg/En0jZp7lw53tJY93YqFVBgHgkzpMD79Ob8NEpAgw97AfMDIY5WSpALSk8XoQJ5mxSOhwi9+BlRDnOjSzu+T9facboJaQDA34fx+sXGzaLpayKLXFpgT0HpvAB2noDDTeEvEddykbGiV8NLmY3ze6JZ9UF7l7Stc9tjkrul1oIa+HTo3qYAYYM2xj1TDAXtPmGMCDziVNsSh5HnhEaVj8ql+5UQf7lIjBrdVY+W1fMxU7iUMxoXQqR0wdAwTZh4YMatP+GFxDfq/UODYuVQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 06:17:20.6339 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07fd0ba3-0b15-4f77-d560-08dedcb89195
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6493
X-Authority-Analysis: v=2.4 cv=Iey3n2qa c=1 sm=1 tr=0 ts=6a4deb75 cx=c_pps
 a=/+xYJgQt7uUW31a/4HdwMg==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8
 a=6XI2D4fptlc7P3fkUgUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 1EC9-D2Qe_JGW4V4AzTdaeGc-wcfC2vw
X-Proofpoint-GUID: 1EC9-D2Qe_JGW4V4AzTdaeGc-wcfC2vw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDA1OCBTYWx0ZWRfX/7is77R4quz3
 tMkEs+9Ez1urIU65uD1/HKvyLdlP1XRbM63evJP8RtP7ZUrqX0LqhGzjMdOlYZLkgF7exL2KeZ3
 37VUJnIENxDw4bgtiV5ig91hEIHEjTL5cEzXMnMfFHRKSbjy5aYs418XAxPQpHi+8nHZ7eOa4ro
 Ebtk08nF3D1zyaHFRUyeUTGAfQMOgxOWy8l2U7oxpUQG/vrAkg8LUcmozZxlTJ6FiLyBGvHnC/s
 sFsorLiIO+4pNH5Y0XJiRGEKKtjHyeF54IfCfXCizEVeibZVhdNvFUBT4hTnxJxaEi/EJQcLXUn
 1VT8WEogt8p+tw8slADfMzWSBFSK5oQ2RF+EkMdyCmDbSpZ7MbbD8sdvbPUt1FE9QDtPXfFaKEA
 wAynobAWEE5WDMaofRLVmWZjOm7EFNLMToEJwssPnL48jlEhy2vF9sanZ2ESpjw7RSniIR+1rfL
 h4Ifn0E1rjSaXdv5IJw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDA1OCBTYWx0ZWRfXzkgUpFsC5eP0
 kQBORRwATV4BIF9HT15UDby3b5aQ28Ec7RO4wU2pOS2JNisPDDgF7df4mjxkNj623TTEq0kqA8l
 KLAw06A55yK4B11m7n9M9FLBxy2MBts=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_06,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607080058
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

Hey Anshul,
Thanks for the patch

On 07/07/26 16:14, Anshul Dalal wrote:
> In the current setup the changes done to the dtb by binman such as
> bootph propagation are only made to the intermediary *.dtb.out but not
> the final dtb.
>
> This means the final dtb that's in *-binman.dtsi never gets the required
> changes applied. Therefore this patch fixes the behaviour by writing to
> the supplied dtb before exiting with a modified test to catch any future
> regressions.
>
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> ---
>   tools/binman/control.py |  3 +++
>   tools/binman/ftest.py   | 41 ++++++++++++++++++++++-------------------
>   2 files changed, 25 insertions(+), 19 deletions(-)
>
> diff --git a/tools/binman/control.py b/tools/binman/control.py
> index 816f7c1eba26..a500e735f6ce 100644
> --- a/tools/binman/control.py
> +++ b/tools/binman/control.py
> @@ -677,6 +677,9 @@ def PrepareImagesAndDtbs(dtb_fname, select_images, update_fdt, use_expanded, ind
>           dtb_item.Sync(auto_resize=True)
>           dtb_item.Pack()
>           dtb_item.Flush()
> +
> +    # Copy the intermediary dtb ('u-boot.dtb.out') to the dtb supplied to binman
> +    tools.write_file(dtb_fname, dtb.GetContents())

The write happens after AddMissingProperties() has run, so source.dtb 
/u-boot.dtb ends up with zero-valued offset/size/image-pos placeholders 
for every binman entry node - properties that only get their real values 
later in SetCalculatedProperties(), which only ever writes to 
u-boot.dtb.out.

For the bootph use case this is harmless since nothing reads those 
layout properties from u-boot.dtb. I think a cleaner placement is right 
after the scan_and_prop_bootph block, before AddMissingProperties() is 
called:

       if scan_and_prop_bootph(dtb.GetRoot()):
           dtb.Sync(True)

   +   dtb.Sync(True)
   +   dtb.Pack()
   +   tools.write_file(dtb_fname, dtb.GetContents())

       images = _ReadImageDesc(node, use_expanded)

>       return images
>   
>   def CheckForProblems(image):
> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> index bf98b268ac15..d02ab3a87a5f 100644
> --- a/tools/binman/ftest.py
> +++ b/tools/binman/ftest.py
> @@ -8532,25 +8532,28 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
>           """Test that bootph-* properties are propagated correctly to supernodes"""
>           _, _, _, out_dtb_fname = self._DoReadFileDtb(
>                   'fdt/bootph_prop.dts', use_real_dtb=True, update_dtb=True)
> -        dtb = fdt.Fdt(out_dtb_fname)
> -        dtb.Scan()
> -        root = dtb.GetRoot()
> -        parent_node = root.FindNode('dummy-parent')
> -        subnode1 = parent_node.FindNode('subnode-1')
> -        subnode2 = subnode1.FindNode('subnode-2')
> -        subnode3 = subnode1.FindNode('subnode-3')
> -        subnode4 = subnode3.FindNode('subnode-4')
> -
> -        self.assertIn('bootph-some-ram', subnode1.props,
> -                      "Child node is missing 'bootph-some-ram' property")
> -        self.assertIn('bootph-all', subnode1.props,
> -                      "Child node is missing 'bootph-all' property")
> -        self.assertIn('bootph-some-ram', parent_node.props,
> -                      "Parent node is missing 'bootph-some-ram' property")
> -        self.assertIn('bootph-all', parent_node.props,
> -                      "Parent node is missing 'bootph-all' property")
> -        self.assertEqual(len(subnode4.props), 0,
> -                        "subnode shouldn't have any properties")
> +        def assert_eq(fname: str):
> +            dtb = fdt.Fdt(fname)
> +            dtb.Scan()
> +            root = dtb.GetRoot()
> +            parent_node = root.FindNode('dummy-parent')
> +            subnode1 = parent_node.FindNode('subnode-1')
> +            subnode2 = subnode1.FindNode('subnode-2')
> +            subnode3 = subnode1.FindNode('subnode-3')
> +            subnode4 = subnode3.FindNode('subnode-4')

Nit: I think subnode 2 is not being used anywhere.

Regards,
Moteen
> +
> +            self.assertIn('bootph-some-ram', subnode1.props,
> +                          "Child node is missing 'bootph-some-ram' property")
> +            self.assertIn('bootph-all', subnode1.props,
> +                          "Child node is missing 'bootph-all' property")
> +            self.assertIn('bootph-some-ram', parent_node.props,
> +                          "Parent node is missing 'bootph-some-ram' property")
> +            self.assertIn('bootph-all', parent_node.props,
> +                          "Parent node is missing 'bootph-all' property")
> +            self.assertEqual(len(subnode4.props), 0,
> +                            "subnode shouldn't have any properties")
> +        assert_eq(out_dtb_fname)
> +        assert_eq(tools.get_output_filename('source.dtb'))
>   
>   if __name__ == "__main__":
>       unittest.main()
>
> ---
> base-commit: a18265f1ccb7a272721ed4286ed3b5a6182ff424
> change-id: 20260707-binman_bootph_fix-16a618090934
>
> Best regards,
> --
> Anshul Dalal <anshuld@ti.com>
>
