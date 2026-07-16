Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6964FC44512
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 17:03:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77B9784D02;
	Thu, 16 Jul 2026 19:03:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="SB+neB0k";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="q46HRpl1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CEBB84D32; Thu, 16 Jul 2026 19:03:53 +0200 (CEST)
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10ABB84BD8
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 19:03:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GGWpU6111506
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 12:03:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=l0Eq8kZ/20+8mzoIEWdpjWmGMheDYuvgVs1BOFb5x
 UI=; b=SB+neB0kNPD5Nj8hsvDduEnYM43nwa74kqyzlD9vVIOg2cPlPg44QBOPr
 bj3oEPkqeJorV2NxJJWnCWhne3synF+iCefqCtPT2JQSEflW+ba3mf6ZvygsYEJy
 zsdTophyLTBSlZQURnM5pfaecGe/PAktG1ZdnQ3xRnuy7l6+BnaklPcXUcslcOJf
 ipr1Z25zivgTgrCHeZKxXXD/XqiNwZ+hVK1A8NXbC/p21tlghQpEGw0lbvpCGGPP
 B9DGQGPSmVNTUQJx181Vs99D5gi73IrSvQy9erB/Qs6y8uLqM1nJ/y435JfdGRry
 WGQ7UwiTI53p53pykACjpnmxtKExA==
Received: from ch1pr05cu001.outbound.protection.outlook.com
 (mail-northcentralusazon11010012.outbound.protection.outlook.com
 [52.101.193.12])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4ff2ccrc7t-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 12:03:48 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pmiomKt9dGi6OsanB9jCMnk+vyrFUUbmjLNTAQPCxjfKV1K3kThpZ8xIDQ+OflepRa+OI+sMLIhkVemHx/ICtqJ1BzJBAVhCbnwaOrKSa1uDMopA9QWlQq7ktsbOkQOsrmGU5K0BuQ8dziDABbUPpnOlIJCejCkccsfzViremTpkAAX7jrOXUEy2FmA6vxvoEJBHTjQ4uXFTR34bNSlFIc2kGodJEQixkQho+hS7i2MVfJqVbfcyA4kT1eAC1RbGTc7MTV5JaJCKI47csSQMEridSqCoTZFJ9sdH+6UZ/HU/4fOWin/aYcoc+N3EWu4MI+BneQR1TjPLWJWqLKTqdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l0Eq8kZ/20+8mzoIEWdpjWmGMheDYuvgVs1BOFb5xUI=;
 b=JO/z4/P1W+/Vs8qIlM87Gm+DbMb+hlvnGvTj71SWSboBItqPqWAfbAzU//hTMJUKYKzlt1O4H/xhZxqSXH7eI+h+30A23QazLER0KWIIcfFhu8DQ386NqircrBUn7PsYKYH0kLk2q4ni5xRAFjAnMXnyInjSD8O7xy/bIhN3+dPw6YboVt8bux9SdeUkTJjGWT2Jr+kU0Ej88wp9asXdsV9ReJRMd/XfvtenZ8yVOPjg/Ufop0M5/pUNdE2VOqRlRlg1RZgUw7Yx6u0eTBps5Wi4abXAqdfMUe9fK4BhTsdPxO3AD3GYcpVk7X3Q4AknRNOqNWpdUK+sAoR/d02ECg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l0Eq8kZ/20+8mzoIEWdpjWmGMheDYuvgVs1BOFb5xUI=;
 b=q46HRpl1/lkvy8pt4WbLc5a/1y87WHedQZZSZVpwKOnwQ8vwKStbKj4xb3Ygx2H7Rwyd/S0gYe2uxgtEaUFK+lkUsfdWCOoNw2wTf5SNcUKrz1lK9QGLLlHPCiAxu0eIa34MzMcKBl71LrogdPibX1pOyDXKg31jHvO+8jNdgeA=
Received: from PH7PR17CA0063.namprd17.prod.outlook.com (2603:10b6:510:325::27)
 by SA2PR10MB4586.namprd10.prod.outlook.com (2603:10b6:806:113::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Thu, 16 Jul
 2026 17:03:45 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:510:325:cafe::4c) by PH7PR17CA0063.outlook.office365.com
 (2603:10b6:510:325::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Thu,
 16 Jul 2026 17:03:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Thu, 16 Jul 2026 17:03:42 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 16 Jul
 2026 12:03:21 -0500
Received: from DFLE209.ent.ti.com (10.64.6.67) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 16 Jul
 2026 12:03:21 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 16 Jul 2026 12:03:21 -0500
Received: from [10.249.135.178] ([10.249.135.178])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66GH3JwA1224514;
 Thu, 16 Jul 2026 12:03:19 -0500
Message-ID: <10f85710-2818-4342-99dd-a1d25ed6f5ec@ti.com>
Date: Thu, 16 Jul 2026 22:33:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Kconfig: ram: select FDT_64BIT for K3_INLINE_ECC
To: Bin Liu <b-liu@ti.com>, <u-boot@lists.denx.de>
CC: Neha Malcom Francis <n-francis@ti.com>, <u-kumar1@ti.com>
References: <20260716143751.1680929-1-b-liu@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20260716143751.1680929-1-b-liu@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|SA2PR10MB4586:EE_
X-MS-Office365-Filtering-Correlation-Id: 812bc03d-ecc4-40f8-eeae-08dee35c30ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|36860700016|1800799024|10067099003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: zIenxLdDCQ/Pk8ltP72PxXiCLCa8o+r/NnxB+jx/Sad9vbT0e0LlNqq161UiNIUA7Lv0jOsMPdxs4H4TeELqZSF9Gt6lI/qZv2DjItdhVqPOYbGwVBO9Oj5pPIMlfNvS456HWEretN3+H5+iOgxG/oWcZg5ML8Ipc7Qnb1m64o9lPmmV+K4TAvqexrpKlvAWRmEIau9EjruQfavMEw6oYos/2Nnw6FLtYVwkhRu+Wf5B2MT/RQnjATgrSIHNqTNX1mm6BsxTTh5GCf8RdXV8Ljwb7aeh91FRXaOuvGuXGnn8WCLdeT/Yohn/SkVecK75LRazwKs30LZTCO/txAZfm+VZ4J1nIHmgG8ZvwpRZF43eqdP8szQ3E2G1eZD8JOm+Yo1C9JEfgjWXK1EHugOAoYYdkRt0PvfUAj+Z2YKDepjYglIxaAtDpmNjmuLQirr652pKyVd2nnYrEj6xK86AJ8Iev80QD5MX4d+r8fxrlI6QTXDcHk06r3lKkOi8wDdoK9teAT+Uw0Hw9Z819eF2XruifAF2XLNv9MnJb7y15klObndzmqcvEWtBTZ19/1ac/VFXvv8MN9sk2IwEDIXbOkKq8CtThOAlI7mjX4R5c1vKJ21zgRFlRaczf28z31ZJh65czGDuAQhXhADdmF9bElCQUmgBYZRQBzhyEyJcQDs5Dm4SvGAylSjApq9QW29tz1iwEE9Gfi843mrz+0kIYA==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(36860700016)(1800799024)(10067099003)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Mxp2IJX/ktgvESFEq+6Kwy66OlTBDm4w+FYoO+TwvRSVzMjQaSxFx3+c/pn9t+ey37P+JlLcXNHAoelwn6dYa3FEwsvBS2vZqyR09q/eADgjFCEUGJGloiZCBaCobdurH1NbgItYnNneWx7uMeP+em88iBEMTpkMhBXW5Y7RtLfPjpTuf7A51qmga08fNTtqCsW4mwpOp8eF2TjS8+lJfJt8AFnFn4xRSTUF4zu4scwow1aqdlLF8lkNxBuIFZsCzJIN7I92Fd3Avy6MQsDSyc/PcQ/AKN6kqi0GFEmoj95kwODTKLKRGtD96fY5V/ugAu/wzClc/ka2SforlVT1VDH+8D6PtvxXRJ+RykOsV5Hd3jQYjkTyZgomo1bR/CGfAL6CKE6D1CYc7n/7kZSAYHJrWgc92xSwLaTJ3Ejm9jLvpaDw6Da/bcmL69UT8Dgw
X-Exchange-RoutingPolicyChecked: B7kFoX1R/RrTlYt+U1YDBWfTcsqtZUpHirqMZ83CGhxfoMXbuCpbLD2FT4BnmKFs6tvxNLaahXGL4bQS1ewWk9Kj5lp09Hc5FpsMvuvlgaco51wPOl2d6mjR23W+bfLCbfXKE0F0nzpGyXGjJUIZcdaPyz/t7W5YQD68HXa1Fr9qcesNA2vcpPmsmu790hnE4Y2FV3cOTSvy0d3D1GhiPygkgKz7gzLYRbqCNLwKB+rSqeq0CXEuMMwAhRHf4vkRReNlQQ9EzBDEXJfk+Ega+yDUy0XYaNc9EiEdjkHanRAdw+UvQt/GzcxuEqEpQ+t1o0YdByWumaRVCGyOkmkGJg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 17:03:42.9566 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 812bc03d-ecc4-40f8-eeae-08dee35c30ea
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4586
X-Authority-Analysis: v=2.4 cv=NtvhtcdJ c=1 sm=1 tr=0 ts=6a590ef4 cx=c_pps
 a=G0fLBfPV4gnnEhzimi2a/Q==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8 a=UNYRAcYtGsOt4YyCwhIA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 4D2PVMmlU2EIl-mIBpmDV8HWjizYggdG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE3NCBTYWx0ZWRfX1QKnVYcQ1ij5
 6oSRjFtvkgWWVcLC6s+kZ2mRbxESGZ4otQR1XXriMo32RSFts8gIaA1TQy4vM5pe5Xq7v/DVXCr
 /bXgP169Tw6AYX6fo33xdCw1gDVpbIv9wr17Yr9tKa8Ds5t+4kUTIEys+j25s+w8Y8hxGDJm9h/
 XzFaFJoPN26/BdAVq1pe35yTT8PL1Mh/60xRBGRpvx6b2dahxz8IVMeG1ItPI9qX0idKqMTgGfK
 sD6WH1vhobN6CxxciWnOIDS5UAzf9SX4QRZ+1/p2OfPfUBxNB2i2TS7Z0ts+TIxesKFs15k0M8r
 o5+MJ2kjSrNyVt38I+aMbAJF5j24XLlMhRdrd5s4E4Iiy8tKZKRSZxMkalT/45ZNXOkTfygmqva
 DJ0kw8qqy1r7nWl521FogUeDt/kuDoc+5lfNfQAgDKFexSOT9bIrv0JPS7CmQvDTUtab1iTswlR
 6s1rQjA/yqvaLTdHidA==
X-Proofpoint-GUID: 4D2PVMmlU2EIl-mIBpmDV8HWjizYggdG
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE3NCBTYWx0ZWRfX5LHZmacUHK8u
 tkYPX3h8Mpwn2wP2SImSJJZM/QEfBohGDwW7fmIeTYgKnidPleNP0eDWvFipo2FrdqO5hzoI/w3
 r9L6Bq/II/XkRwht89k3PnGvu6KeaGI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_06,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1011 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160174
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



On 7/16/2026 8:07 PM, Bin Liu wrote:
> Commit f43f71012254 ("ram: k3-ddrss: Add support for a partial inline
> ECC region") uses ofnode_get_addr_size() to read memory address and
> size from devicetree using type fdt_addr_t and fdt_size_t.  However
> these data types are 32bit if CONFIG_FDT_64BIT is not defined on ARMv7
> build.
> 
> So enable CONFIG_FDT_64BIT to retrieve correct 64bit memory address and
> size from devicetree.
> 
> Signed-off-by: Bin Liu <b-liu@ti.com>
> ---
>  drivers/ram/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/ram/Kconfig b/drivers/ram/Kconfig
> index cfbfa1252d0e..acd6d9cfd6a9 100644
> --- a/drivers/ram/Kconfig
> +++ b/drivers/ram/Kconfig
> @@ -121,6 +121,7 @@ config IMXRT_SDRAM
>  config K3_INLINE_ECC
>  	bool "Enable TI Inline ECC support"
>  	depends on K3_DDRSS
> +	select FDT_64BIT


Good catch
Reviewed-by: Udit Kumar <u-kumar1@ti.com>


>  	help
>  	  Enable Inline ECC support on K3 platforms. 1/9th of the SDRAM space
>  	  is used for ECC storage and the rest 8/9th is available for system

