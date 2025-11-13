Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC154CD8CB0
	for <u-boot@archiver.kernel.org>; Thu, 13 Nov 2025 17:44:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E466830A0;
	Thu, 13 Nov 2025 18:44:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="hZgm9HPh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF0AC83FAF; Thu, 13 Nov 2025 18:44:44 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4C748309A
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 18:44:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=3412314e69=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5ADH4uJk088595; Thu, 13 Nov 2025 18:44:40 +0100
Received: from osppr02cu001.outbound.protection.outlook.com
 (mail-norwayeastazon11013032.outbound.protection.outlook.com [40.107.159.32])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4acrete9xs-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 13 Nov 2025 18:44:40 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ld0VHreKw0OKn/lVVlu+XFaITK+dN9aVr6LPC62cFcaMnElLpSzYjNlE28n+VVcPTIEoc/n0AmSbGKmBfMsYof94Xl/LHYMq5o8K30+wku152dVMDjfujfAUywfWrHAvojFGLc6Z6cwO5VTvxo6g9BoDUtJiMfHMAiKOkkFF2xvUjmLInFSLtWOkhqHPj3peuzxf69sRmpalZmUFfdUmLaUsyd+BsKMnClkZk7rOm4e9iFudJi7E4NCS8Op/9bSqo4xU2GH9mB1bqH4WOHHQ6JB+MyRKfZH62HomMUj8yh5qIsnP8RBBoDL6GCFBINXWjmXdUmKlrDtN3/Nz08aYgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hu6U5f8YQuVqYGLHDQO7560m+a4PIfXPdqHVL79CaMc=;
 b=lsBdqywWQe0OfqSjc8WRdDMtKQT4Y3LJiP138wU/P0VTgUMgqitaSYX5ySSIUdbhk9KnIQyTlvGlUNuJtFrAqHMmNCqdyMwYjP3s8XNonQ0eLEX7GSsD7xLeUlaxDlAt52Fdd+0sxfq24E6sLiqJa8z9AP7dID01mOB1L42j9/3Jh+6Fr8j+pAlJNqhGfgLVgORgrcSEPgked0g9eHJ00zNRhXhU/ax7DXqGVA5q08UC1fWveI4SwvWS6noO3kWqiWpHtx91e2e/9u/v7eDhhpSSDPkB48+gqBlryVT+pnB9e+j2ApBh64aFZPbDWlIqxdIQ885I2a+N/1L6XvqK1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hu6U5f8YQuVqYGLHDQO7560m+a4PIfXPdqHVL79CaMc=;
 b=hZgm9HPhSkU9aRI4TTgGh38r2qFnXO5z6gaWyHn1KuhBMvlHFgzhcTPck8epUhUP1uKw4eZ7DkJ6MTQDKgQ+7xxIpD6vOGyHKWLgFmIRD0xouMdqtoZFLRLVf1hRcP9HYbU9jPpnSgWF3EStVrGfm/qG0RUnfSOeHyzladMIvLBPZ+axSEi9ACYG1ZWVdaS3E3C6adxtTRZdi2HDSoh9KENRinwXYz0BUI9BM/t8qgvmMIlH3tcR8eUQ+H5mY2bmKh8QR9RC+yDySokiLbEgPRWIbnETJUM1CmTGvdWEOMAVkLGTaQ89jGsqMIzmyONApsKBTMbdROopIp3uaybC4g==
Received: from AS4PR10CA0006.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5dc::6)
 by PA1PR10MB8671.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:444::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Thu, 13 Nov
 2025 17:44:37 +0000
Received: from AMS0EPF000001AF.eurprd05.prod.outlook.com
 (2603:10a6:20b:5dc:cafe::64) by AS4PR10CA0006.outlook.office365.com
 (2603:10a6:20b:5dc::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Thu,
 13 Nov 2025 17:44:32 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AMS0EPF000001AF.mail.protection.outlook.com (10.167.16.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Thu, 13 Nov 2025 17:44:36 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 13 Nov
 2025 18:44:48 +0100
Received: from [10.48.87.108] (10.48.87.108) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 13 Nov
 2025 18:44:36 +0100
Message-ID: <e89a5acf-6b8a-4c19-99cc-634db006c236@foss.st.com>
Date: Thu, 13 Nov 2025 18:44:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] ARM: dts: Add txbyteclk clock in
 stm32mp235f-dk-u-boot.dtsi
To: Patrice Chotard <patrice.chotard@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Tom Rini
 <trini@konsulko.com>
References: <20251017121852.109561-1-patrice.chotard@foss.st.com>
 <20251017121852.109561-5-patrice.chotard@foss.st.com>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20251017121852.109561-5-patrice.chotard@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.108]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001AF:EE_|PA1PR10MB8671:EE_
X-MS-Office365-Filtering-Correlation-Id: 275d299f-a813-4bf6-d0c7-08de22dc5055
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NWJJQmFjd21sV2xDNHl2STVzb1NKNDdRZlRJWHdlT0xtUVhqZVh4T2pmRWts?=
 =?utf-8?B?dmtlb2ZwZGRveXErd0p4eUJoNHRqRHlQTXcyeU9LQjhPMjFyb05BTEJ6MGZW?=
 =?utf-8?B?N3lZaWVZbzlYZFNwMEk1UHhvUHpwS1owdUhjVHU1U3RnVGJ4TW1XZTJNWm5F?=
 =?utf-8?B?TnZhV1dJUHlCTVVDRDBVVUFQU01EUy9taGRsYUIxZmdGaUlJMlpwNHpRS0o2?=
 =?utf-8?B?cklrRFJKd0FqcWdIcnBteTE4T2UwT2VHSXdoVkZERWdMYzJhbHRCbVBvbUtw?=
 =?utf-8?B?NjlEM1BPOEdtMTZramZvdE1OTUhUenhqMC9nRTdyWFNHWnRJOUJ2OTlJZjFB?=
 =?utf-8?B?elZ6Szk3ZW8vYTVnYTFtd05YeW9FclMrVkdrL2dQNTY2dUZxMHBYakxQWlBF?=
 =?utf-8?B?ZGUxVWFLem9wSU9vK0ZRcWVsVC9pUGdBSEZCa1RJZE4vUWR4MC81Tkp1VUxJ?=
 =?utf-8?B?eDRodlIrWTRUWEFPb3IzZ3B2d29BS0JpaVRNR3FhdExZd3VDM1lNOXlrbXV4?=
 =?utf-8?B?K0dkR3ZUek9SdFVSS01ycEFtWGxFQitWNE9vQzUwcnRrR3RuOGpDOWlpL1dj?=
 =?utf-8?B?WjJqS0s0dHN5MldmNmZLMWhUWWRSQ2JBTnpqTjhpWW5IWVJONDZDWmFndVFD?=
 =?utf-8?B?ZjN0ZFhRclFHNmx0N0dtUkp4aEVHUytveEpaNThaT3dDd2NZMGR3RDlHZnhv?=
 =?utf-8?B?YmUycTVvZVE5SHhCUDlqY2JpcWthQkI4WUNybUhLM3hKejkzYmtqTkFScTBQ?=
 =?utf-8?B?UGdqVUpzMUduMHpHSjlKSjVrUXZ5cXNCb3BIbW5zSDE4RTdlSzlBeXZxU0pY?=
 =?utf-8?B?d2pmUjNERnVHMURlQi9xcXNLbHFZZ3plSThMQmFWZEkyV2dzYUl4dkZGcUJG?=
 =?utf-8?B?VTFsSjlzbGd6L1VaK3VkMFVLcnoybmlad2RZa3F6dGRDeS9xa0IzSGtwenJM?=
 =?utf-8?B?eEJUWlRVWXJtT0RDUHdya2dEVmRCRi9yS2NpakRWbDNOTldaUFJ3YWdZV2RF?=
 =?utf-8?B?TWVBSEFKOTkwSHFtK2tXeVIrNlFrTHpycU5lWTdxSnZHU2p2VTVTK0RhN0lC?=
 =?utf-8?B?bWVUTE1TU1M0RmFRbktKbnhDZEdIclZSMWJ0d2R0Q0JjbmpwdjRFdDBrZjlB?=
 =?utf-8?B?bUZuaEZQZGxYZDFoMlUwWndWWXQwWUFGVkF4aHVVMUhPVDh4a3BSYjJ4OEVy?=
 =?utf-8?B?c0ZJd1FqdU5yRXNjc1FrTkJlaXR1b0VzU3cremI5bGJpQnIxL1VDempnVDkx?=
 =?utf-8?B?T1JZd3dkSkw3L1BUQk9NTU1SQ2VuRHBjcHdONXY3UDUya1JmT29pTFVWa2RN?=
 =?utf-8?B?aFZKd2V2eXRHY1pPd2VBemJPR1YwZmlKSFRPN1d2TGpvaUZMWFR3aTUreDdj?=
 =?utf-8?B?cTRXT0UyOWYzQ2o0Ny91cnMyKzJjQXBpYW9ZK0llY0NaMWRYS1pLUEY3QzVM?=
 =?utf-8?B?RFJSeEQ2dzZQcktjUVR3SGs3WGxNeDB5UVd4Uk0vRm5seUFSKzg4ZlRZeVcx?=
 =?utf-8?B?a015bk5LaTF6SHd1eUFkNVk5c3VCbnYrbTNRNkNPbGdxbkxxdnVEZDc3Z1Ri?=
 =?utf-8?B?cFZZQmNxbU5VMlVnQXlLcHJGbkV4Sm56QXhXTEZKVEJoMjh1WHNMRHJGemRz?=
 =?utf-8?B?V1FHcVpSbW56SHB2UWNwYWROR2NqOXN1UGs0YnE3bllqMmNmRFNrNmtMWGxz?=
 =?utf-8?B?TzE0dS94S0dwUjN5djYzTGZPMGZSMDNyWVhrTitPaFoxZFFCNGVidXlRRzZr?=
 =?utf-8?B?V3g0REIvam9kdjNJQkwxL0x6bk41ckd6U3dFVU9HQ3lxSXI1US9qQiticGVi?=
 =?utf-8?B?a0pQK3JvbDZGaGpoVll4dHRoeWpXNWpqN3dJS1VOYzVoWU8wZnBEcnFSYVo2?=
 =?utf-8?B?cENoNHBEZDZkU2orYUk5ZEJhSS9VUEsyRWV3bG05RjBwd3YzYlR3TnZFdUNV?=
 =?utf-8?B?eXYrQ09KUExrUHdZQVkyZmFlMkVZUjU5WmQ1OUh6QjMrclRndzZjZUFmY0hq?=
 =?utf-8?B?bkd5dHVzNzVvbm4xTUdDbkFHVWFMZDZHMWtEdXFTclBEL2o4MnNudjZzRkd0?=
 =?utf-8?B?UVBpNTlodjRIRXVYMjVWTHdrdmtVbnQ4cHRMbUJUWUpoTFFXeWFlclkvbXZj?=
 =?utf-8?Q?sx9k=3D?=
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 17:44:36.8276 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 275d299f-a813-4bf6-d0c7-08de22dc5055
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001AF.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8671
X-Proofpoint-GUID: g96D_pTZ2thqs7et1C7liZSkFBDo-jco
X-Proofpoint-ORIG-GUID: g96D_pTZ2thqs7et1C7liZSkFBDo-jco
X-Authority-Analysis: v=2.4 cv=SMNPlevH c=1 sm=1 tr=0 ts=69161908 cx=c_pps
 a=vu/0ZHfOB/YTnIb421Q6pg==:117 a=uCuRqK4WZKO1kjFMGfU4lQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=q6CKDgr7omsA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=yxtLLDYZWVqh0PiOXdsA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=T3LWEMljR5ZiDmsYVIUa:22
 a=HhbK4dLum7pmb74im6QT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDEzOCBTYWx0ZWRfX2RROZaTzFAFq
 6BGtlksOYp0oHMYtcvb3TqT3wgK4HgMUGMuGjw93bF6s+/6tPAYSdbHIpLc8n6yCijLwbpV9fO1
 wjHtyHwV22oklwQQo1nnTwcCr8OQ69WCSICC7h/mlLxulOY7ZeoBfUrBa1KoLDMSIjXqVoK7W4y
 GG2NDUKtaFOjgln6vsXSLSjMVVHNTrX+nqrj6ETPpYNTONbmjWaiGnTySTgumCBfHgFHmzV40d7
 17gOuLKYZBYO1hvRjd4ov8wzbdCbtftG5tLGTaA206aibYo11ZxTowKtG1hykIss6hGPlP3zERL
 tntagiEBYvoY68gemqD4eFQcyQdQ4dnto2CYh5nLiSIEVbX5u+QXg7P3DOpZGEo7t1AjcXF/6i+
 yc+tCD0ka4eegLm6ihRroUOUBomdqw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_03,2025-11-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511130138
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

Hi,

On 10/17/25 14:18, Patrice Chotard wrote:
> Add txbyteclk to avoid error during clock registration.
>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>
>   arch/arm/dts/stm32mp235f-dk-u-boot.dtsi | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm/dts/stm32mp235f-dk-u-boot.dtsi b/arch/arm/dts/stm32mp235f-dk-u-boot.dtsi
> index 1bc77874050..84279c4712a 100644
> --- a/arch/arm/dts/stm32mp235f-dk-u-boot.dtsi
> +++ b/arch/arm/dts/stm32mp235f-dk-u-boot.dtsi
> @@ -10,6 +10,14 @@
>   		u-boot,boot-led = "led-blue";
>   		u-boot,mmc-env-partition = "u-boot-env";
>   	};
> +
> +	clocks {
> +		txbyteclk {
> +			#clock-cells = <0>;
> +			compatible = "fixed-clock";
> +			clock-frequency = <0>;
> +		};
> +	};
>   };
>   
>   &usart2 {

Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

Thanks
Patrick

