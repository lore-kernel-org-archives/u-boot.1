Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6E0FCE8D4F
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 16:45:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2149B84230;
	Fri, 14 Nov 2025 17:45:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="Tcn08kCD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61F9A8422F; Fri, 14 Nov 2025 17:45:37 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E29D84198
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 17:45:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=3413684226=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AEGW1Qd3023571; Fri, 14 Nov 2025 17:45:34 +0100
Received: from as8pr04cu009.outbound.protection.outlook.com
 (mail-westeuropeazon11011008.outbound.protection.outlook.com [52.101.70.8])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4adr7kktkv-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 14 Nov 2025 17:45:34 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S50dhgMMbQp5B+7fG9obJbVqotgTnjLQx3BI9HWETHDaE1bskq1H5efmBjTcBrg2xsnbjywEBVhAuOz2941UscF/sFThBM/UoqdBWTQUM2IfocMx5Ai5PCYDwTS9a2vV7EGP6dlGc+XnDzJsFwtmrl6+Vfv5C988lNa2CsEDsikl97zDfLOF90B5RuwtsgT5lK5LaY5LCKQog/mZY5JUht1g/keVilzqOQaQ6v/XxMxsL9Rr0TYrjX6Y25FkfWe5+lz/xVpSpDa7hz8RaMJHjyuYddK9hVzxRXTrsu7a07SYkSV/E7LWys1BzkGN2ie/V3JxiR4hRId4Jjb1h4Ss7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MUoZIMJABq/Op6jvINnRuJIRWv9TyeLXM6m4Eg1IVU4=;
 b=ccNvORirOBNhFd59xjHMe74f1bABc6Y6OjCGWp5NmMaJfonbTrx6RuYtN1LzI+isH3r2V4zVGBO1AP3dv8UPF1cYdPQkko0tMpwNG/feS3UoxHyX4YiD0zCzrjJs5KMjPcXLlhNdoGUnjAYj47UDXsf34r03x6TSsf4mgxNH8L/hg8xYoRokc/CmAOc8wafMrfga68OsY8oPCmbHMEOKf9TkDIBXsKtptujsmscPUgQIWLM/CABR+ONrEahQRYtXnSIThK3e/taPS2L3r484iI2H4KSFZT+WsRBpuKiYBLBM+KOqlVVi7APgcMINIgsknjTEBYoM4iFnyBUx+LgrXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MUoZIMJABq/Op6jvINnRuJIRWv9TyeLXM6m4Eg1IVU4=;
 b=Tcn08kCDVF2ftOs9gDEWCDeave0dH986+uSbj7cnpptkHy7LBmvwfBakB1f8dcXlgKbVFeNlYH5nBjt0AntvxmNfcLCkdLR2RZsxGeugEoJSTkdHEkNE91dgXxkBDHkgPQwUzbUnw5K0IeiALGCZFAdRby4l+BC3EVtvl1enKLAt6BrYO26+FjDN8eaD8/IXP2E/bmLG93PCuBzp0toYiA8SPZzZPUZN5Zo9PL5VT7N7iwVTKyOTOQPQMbZwuLGyc3ILMwfLSx0ibFDzKU9QyNR1z1tMF5AqPhKlk9Y+UxsXIA4jkGlea6qm/MtJWG/hAYw9fKQ8c/pRRW1PYxu4VQ==
Received: from DU2PR04CA0316.eurprd04.prod.outlook.com (2603:10a6:10:2b5::21)
 by AS4PR10MB6206.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:58a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Fri, 14 Nov
 2025 16:45:30 +0000
Received: from DB1PEPF00050A01.eurprd03.prod.outlook.com
 (2603:10a6:10:2b5:cafe::3b) by DU2PR04CA0316.outlook.office365.com
 (2603:10a6:10:2b5::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Fri,
 14 Nov 2025 16:45:14 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB1PEPF00050A01.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Fri, 14 Nov 2025 16:45:30 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 14 Nov
 2025 17:45:40 +0100
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 14 Nov
 2025 17:45:29 +0100
Message-ID: <bb14672a-2f8d-41d0-a5dc-285c33b1c7d8@foss.st.com>
Date: Fri, 14 Nov 2025 17:45:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] ARM: dts: Add txbyteclk clock in
 stm32mp235f-dk-u-boot.dtsi
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Tom Rini
 <trini@konsulko.com>
References: <20251017121852.109561-1-patrice.chotard@foss.st.com>
 <20251017121852.109561-5-patrice.chotard@foss.st.com>
 <e89a5acf-6b8a-4c19-99cc-634db006c236@foss.st.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <e89a5acf-6b8a-4c19-99cc-634db006c236@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF00050A01:EE_|AS4PR10MB6206:EE_
X-MS-Office365-Filtering-Correlation-Id: c7e14529-e4f7-4427-0a28-08de239d38fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UVRib3VjaXVnMDQ5U1FyRUVJMHJnQVZ3blFCTmZzQUdtelVsdTg1d0R0VTlM?=
 =?utf-8?B?MzZtZlNuclJWOHIyQTNRQjdRc2ZaR1hRL3EwVTJKQytIWWl5bVJoTkJvSm80?=
 =?utf-8?B?U1RMNjhLV1p2S292ZWhiRFdvRWsvYjdvZlE2aURZWitZdmhpWEZhdzlwemZw?=
 =?utf-8?B?Q3NUTzRLZy94VFloa1IwK2p0a29ySTQ2Z0hUcG0xY3ZZZU5FeklJbXh5OEx2?=
 =?utf-8?B?RzNMeHJCMU1PamIyVVJQRHRZRE9USzlxTHo5RVhhT0FmMHFKZS9GNytrSWx5?=
 =?utf-8?B?Ri9XbEtic2hVYU55YXBFYkRFVnc5M0NmN1I5ZXVHcldJTlFTZzZYbWE0eFA3?=
 =?utf-8?B?L0JDZkxPazZHZ2dNekhqZzhHd1R0bDlxb3NvdjlXUlFBdDNiM1VzWEZpUzEr?=
 =?utf-8?B?THJ4b0sxM0wrR3RlazkvZXRmSjl1Q29WY2Vwc1NmVXduSkIwVHdWOTU0SWV2?=
 =?utf-8?B?VXA1NTRaVllTaEV2RzFWS1FNSytzS3dIbU5aSExsdWJ5eERhTWpBeTl5MkVm?=
 =?utf-8?B?c0pvbTJYajJnM1Z4cUxTSldWVzFKVk1nTEV1eVBldlI3MjkxVGhIaW9LVHBI?=
 =?utf-8?B?RW8rU3NiazZXQjRTc25Gei8wcVltd2c4S21neFFPRXB4Mnkwb1IzcEg0Nm1F?=
 =?utf-8?B?QzlpU29tUHlpNlJyR05BU1l0QTl3dUswWENBUkNiakVTcXpsb3NkY0RWTjRD?=
 =?utf-8?B?dk1EVUJPQjFkb3RuMEx4ekh0R0JvWldJZlRZd0pIR1BrbmdpVXBZbjdtbnBo?=
 =?utf-8?B?MDg0SmJ3NmJWcE9CS3h6TnJKZEI1TDVOajZLMGxRTXRaejlYWmJIVjVtTDJK?=
 =?utf-8?B?bW52Tkl4c2xXTVJ0d3NqSmM2THlVSzA3WXFwNDQ0dDFSL1Y4cUxsY1ltR3Fh?=
 =?utf-8?B?Mm1DVXI1b3dFRm1jSUE1S204b2NSdXJBaVdLSUZTQTJEZEFZRm9BWVV3aDZE?=
 =?utf-8?B?eFE0NlhGd0NHQmxkazllS3k2M0FmTGpvaUFGaDFsK201L1lvNnlXRVM4ellK?=
 =?utf-8?B?b2pPQlo3S0hxU3FqRXhMckVZRVI0dm1TNXgzWlJ4Snc2WDBCNGtDajI4QXJa?=
 =?utf-8?B?NnhzczlWQ0hoSDI1U05kOTl2OVd4WUZBU3VOVE5HaXJJaTlveEF3djBvRU8z?=
 =?utf-8?B?VWpOcVBEaFZGc0RLWHRTOURQQ2U1NVUvSE0vNkVjQlZObEU5MEd2enpvN3NX?=
 =?utf-8?B?dWlyMzM3b1kwemtyWm1DVGlVMEpTTCtCeE5lR000ZGZycXFDWWJGelkzRXF0?=
 =?utf-8?B?eGRDUGxad2J1cm5RbjVhVjdGWitNT1YxeWk1WTVOVDl3TnBBRGJyaVcwcVZO?=
 =?utf-8?B?SXVWMCs0VnZ3Y1E5WUFWNUZwdERMT05aREhndXZxT3Q1RnpwRGoveVIvS3Z6?=
 =?utf-8?B?anlwVzVxUjJZMHZRNlYwQzY4MmtRTUxnTEY2elFWeUJIL1VKNVlrOTZJK0pC?=
 =?utf-8?B?SVdVbHZDWVRiREpkNlhaY0hiOHNWOG9DV2FvTTJwd0F2TnVMbUtOVzlKa2dZ?=
 =?utf-8?B?TzgxbUVaSFdVRWZRQmswNUQ5SDRyMFFUSTU1ZFREaVRuYjhsUnJBUjJjSVpY?=
 =?utf-8?B?WHZKRDVEdHFxTktkOTM4U3Z6cE9EVnRiVTE1RzJ6N3oxYW9TYlRxM0wrQ1Rp?=
 =?utf-8?B?YnR6OENrR2czWndwbGYrM0gzeDlkdDJ6cGg2N3JCM2tUelNpTVlZeVlyTEpB?=
 =?utf-8?B?TnZIakRjWk85OXdsYlpXTmFjdHA4dVQzeEMyZG1jUVdneXJTcFIrWXhPbnR0?=
 =?utf-8?B?a2NaT1BFdnhkRFNFMi9iVU5oQzFXb3RaaFhpcFdqWDFTN0FlbFVuNnU4OXpt?=
 =?utf-8?B?NFhBb3pkU2dvZzQ1M21mdmtNeFZPTVVXQk5jdWFaTUUwM29mTTN1enJPN0xG?=
 =?utf-8?B?MWg0K3ZwT2V5M1BOcmJNR0dLRUg1U0JuS2JEbitUOWpvTzVrc05rYVhnL3Y0?=
 =?utf-8?B?NEdBQjBlM29ra1dxWklnZUh6Q081ei9zYjNUNjhBMXFHRkRocStnd0gyZ01F?=
 =?utf-8?B?WkZEdnk4MnNSWms4US9BSkxVRFA5NVNtSm9VSnczeUdka2pKbTBhQWFXTVRR?=
 =?utf-8?B?WGFvWncvQWRyOFh0YnRSTmxwSHlFNmd5ZG5rdWZnU0JhWmczejVJUkl3S0Jo?=
 =?utf-8?Q?D8DI=3D?=
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 16:45:30.4818 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7e14529-e4f7-4427-0a28-08de239d38fb
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF00050A01.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6206
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE0MDEzNCBTYWx0ZWRfX1Y5hiky+5RD+
 IUCtZDj8ByapCyQCjAVMZ3jcJt6QqBPDMlYKuZ9WmYRccLwNnJ0TbY6Sxe/36TRitIcFlO9Sfks
 h2mmcmGzUu6blbnroyTYlUOanCJX7EEc6NCxqQTWrEwN7cPnMTFG+2FD8ODEpTQgeA2Mb+2j4ij
 s2Lua0hHomruPE+YGWx+5jqJ8SXQRmbmdDnlMrtRVsPJx8FxMGQ/WYvVsb+raG3c0taq5B8uT/w
 23ub6DKThVj6UacWNNivYktw/6xfYqyeLGYIGjcBRXF6CpqmEb5hOVWPcOKWXDa2L3y+a/mDIm0
 LTgKLg3D7FTdMLHti5y6SBNPmXj1I7tLFi+S5CqaxPyOJjI/do//I0mdmC51OhRc5LhL71oT5Zl
 dYyOh0he3buyP+x6owAsMv54Yr9qFw==
X-Authority-Analysis: v=2.4 cv=Xsf3+FF9 c=1 sm=1 tr=0 ts=69175cae cx=c_pps
 a=NTleJMBLGjSDdH8hSBVCOw==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=XWp4PHTOCikA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=HWWMazb9q0HI6D13h1kA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
 a=HhbK4dLum7pmb74im6QT:22
X-Proofpoint-ORIG-GUID: n-Jdi97TbFDguyA-W5Cjts6nyRKxrqaG
X-Proofpoint-GUID: n-Jdi97TbFDguyA-W5Cjts6nyRKxrqaG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-14_05,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 bulkscore=0 phishscore=0
 impostorscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511140134
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



On 11/13/25 18:44, Patrick DELAUNAY wrote:
> Hi,
> 
> On 10/17/25 14:18, Patrice Chotard wrote:
>> Add txbyteclk to avoid error during clock registration.
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>
>>   arch/arm/dts/stm32mp235f-dk-u-boot.dtsi | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/arch/arm/dts/stm32mp235f-dk-u-boot.dtsi b/arch/arm/dts/stm32mp235f-dk-u-boot.dtsi
>> index 1bc77874050..84279c4712a 100644
>> --- a/arch/arm/dts/stm32mp235f-dk-u-boot.dtsi
>> +++ b/arch/arm/dts/stm32mp235f-dk-u-boot.dtsi
>> @@ -10,6 +10,14 @@
>>           u-boot,boot-led = "led-blue";
>>           u-boot,mmc-env-partition = "u-boot-env";
>>       };
>> +
>> +    clocks {
>> +        txbyteclk {
>> +            #clock-cells = <0>;
>> +            compatible = "fixed-clock";
>> +            clock-frequency = <0>;
>> +        };
>> +    };
>>   };
>>     &usart2 {
> 
> Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> 
> Thanks
> Patrick
> 
Applied to u-boot-stm32/master

Thanks
Patrice
