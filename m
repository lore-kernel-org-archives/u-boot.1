Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 950C2CAC598
	for <u-boot@archiver.kernel.org>; Wed, 17 Sep 2025 06:44:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB22783314;
	Wed, 17 Sep 2025 08:44:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="MTEufc74";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6BC183327; Wed, 17 Sep 2025 08:44:23 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92A57832F9
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 08:44:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=13552feb49=patrice.chotard@foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58H6elUL015760;
 Wed, 17 Sep 2025 08:44:15 +0200
Received: from duzpr83cu001.outbound.protection.outlook.com
 (mail-northeuropeazon11012066.outbound.protection.outlook.com [52.101.66.66])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 497fxusurc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Sep 2025 08:44:15 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WVJr3FPX7gVBANYInz0gPHFLfDXmwZioWEz7bEPhdz2E7CCk/dB3SeXq1OkAJD9HENdS0/qPYwk4c3KGSVw8SzJx4H9T4R2DffFgujAzjrx9ug5builZ4olAlgRhzc8Mcf3I78WtmQzMhPLnpIBqZ0v4ZdMW3r2bQsy2quygVpSHisQKABm3tb0z1ijLElnezKg/3EKt5bmB06jMxwjRZ8Uub6KppzBwgcEEwjO378W/3D72XwirJ6N6aCrH1BAzrYh8+hD1NMr9YdHBzOdSeWqa+ymQB6wkDE+K1C8R/fIHkI9MS3dCP6/lHeo6nPF0UqyOZxs4eNPKcX1NQJHV/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gefQq54T3IaYIbbV0jDVfib44MyekN9gYmD0h+32zls=;
 b=vYkw5fVjxcWkLJRdCv8FBOcL7SPf+aF4cFYqvNuCfjFMus5iOIzsAy4CtZy3lDlwxT5xnBDzFMPRLDshNBYIEzBlC5qe/6IwoDgfkM+0NUTyv/S3VsNh3mZlC3IpsiWoSxV4rB8/csu5zff6labP6LOsCbOhrGTPOuVxyB6NFYKeeug5sDF/Ul3+1FdBvr/x6fiC8qJ/irBIHw+UrR9Uy/v9blEw7LK7O+RO0pj8vJdDChknKvAeP47JznEw3CLU4qQITVRGrKFONwov2XEBDR5ik1Ik8PDq+4YD3C0Qmr7GXZwC9oneyXfgNKaWr7J6qOIFATqFr0IzZsSwEJVA8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.43) smtp.rcpttodomain=ti.com smtp.mailfrom=foss.st.com; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=foss.st.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gefQq54T3IaYIbbV0jDVfib44MyekN9gYmD0h+32zls=;
 b=MTEufc74ccpAlxGTRuLF75c12oaxNaFWlaY0RA7wvImabjx9t1WoI0jqrgK0kEp7pOczScP12xm+ukfld0la3olnVvqVh4s2mmdVW0l71dC++x6ZqBqOntsBubX1USMfP+7kmFiE1FvO1EnmnGr9kQZGktedefw3RQGGQpR7IAhPycsskIdOu1GQlXxEGrv4UBDWrBaZhJ6Wwz1dMtIgTOLi21lTPuKH00purz8pF52Kd+M4stQVD6jRu0hOYq2nsjhoOdD8dBxnuaUDF3VrMulPVPnC7P7r5tKl1UPZxn9IqA7h6LEupVkyYFbkFFaDjvBfMyps30Kk79wKIQEmeg==
Received: from AS8P251CA0016.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:2f2::11)
 by AM9PR10MB4006.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f2::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 06:44:05 +0000
Received: from AM4PEPF00025F96.EURPRD83.prod.outlook.com
 (2603:10a6:20b:2f2:cafe::cb) by AS8P251CA0016.outlook.office365.com
 (2603:10a6:20b:2f2::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Wed,
 17 Sep 2025 06:44:05 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.43)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.43 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.43; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.43) by
 AM4PEPF00025F96.mail.protection.outlook.com (10.167.16.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.0 via Frontend Transport; Wed, 17 Sep 2025 06:44:05 +0000
Received: from SHFDAG1NODE1.st.com (10.75.129.69) by smtpO365.st.com
 (10.250.44.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 17 Sep
 2025 08:41:41 +0200
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 17 Sep
 2025 08:44:04 +0200
Message-ID: <ab29b068-59e6-4981-b23b-d5e90dadc705@foss.st.com>
Date: Wed, 17 Sep 2025 08:44:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v1] arm: armv8: remove redundant definition of
 mmu_status
To: Anshul Dalal <anshuld@ti.com>, <u-boot@lists.denx.de>
CC: <d-gole@ti.com>, <b-padhi@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <nm@ti.com>, <robertcnelson@gmail.com>, <w.egorov@phytec.de>,
 <francesco.dolcini@toradex.com>, <ggiordano@phytec.com>,
 <m-chawdhry@ti.com>, <afd@ti.com>, <bb@ti.com>, <u-kumar1@ti.com>,
 <devarsht@ti.com>, <ilias.apalodimas@linaro.org>,
 <patrick.delaunay@foss.st.com>
References: <20250916112205.238811-1-anshuld@ti.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20250916112205.238811-1-anshuld@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F96:EE_|AM9PR10MB4006:EE_
X-MS-Office365-Filtering-Correlation-Id: d3c8f666-c269-40da-2997-08ddf5b598b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|7416014|376014|36860700013|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZmVHU05wVTlPbXJVb2cwcTBPUzFkaXllWk9ISytZZjdvNERncDBIaEFaRHhr?=
 =?utf-8?B?OXFwNXZJdnE0V09RUmlzOHRNZmNzdmVQMzFGS0dEOWNUaFp2ZTRVU1dhYnZO?=
 =?utf-8?B?YUkrYnlTeWdmem1KRi9JS3dEUDZmdkJ3dzNkVkUvSlBOWGN4UUhWdWZBN250?=
 =?utf-8?B?T1dzb2E5TERlRjhqWDVXN3Q0T21HbXE2RWthMzN1Rzh6dUxTUkp1RlA2SXh4?=
 =?utf-8?B?Y1BxSXBtRWdMcE5Ta09VejRzYVhkdGVaclZoTkZ3ZzQ0dmRKVWNrYmdHZC9L?=
 =?utf-8?B?RTZuU0JZaHA5ek5maHlLWjA1eVhpVkVRZFpKdFMzeVRNMGRVN0lxTjAzRG40?=
 =?utf-8?B?OURsUjZzTkFPQmg5ZE9EZkFrek5saUVsOUcrRmQ5MVJaZWlnczNhS1B3dUYz?=
 =?utf-8?B?b2prUVk4dzVxTjlENWRXK1NSWm5KR21LMWdZU1QyNytJd0VhVmhiRlhoODBx?=
 =?utf-8?B?cWZqaVdHbXJBSDVaUWhPUmNZckFhTU5oQmZYWDJBZWVrLzF0eUVHWjR2TFRh?=
 =?utf-8?B?L2dtSlh6UTBNaUFhaUJETkozVlY2bUhmcDZMVE13Ly9XVStZMFppL2FJcHdw?=
 =?utf-8?B?TTJ1dGdzaTRtcXNYMXN6ZHZ0elRvdjl1N01DUGFWR2NvK3VPTXJtV3dHZzNP?=
 =?utf-8?B?bkRWQkZhQnB2RjhkOXY2NndJeWhPL1VQc1UrM013SVJLUzF2bktZR0VIdllI?=
 =?utf-8?B?eC9heHJqbHZYTlMrYks1REsrcCtSNHNsbUF1Y1gwSGlWZ3hpUkNZVXlQTHdD?=
 =?utf-8?B?K0J5UjhiU0hXR0dZM29kd0sxZGhMdDJRMlJrVGtrQXdPb1hGM2EvV1RYT085?=
 =?utf-8?B?TGIzYU9HL1ZuR0s4ZW1oSGxKN3Izb3V3MUQ3RTRMZ1NwWjROdjJKRFpoaUpS?=
 =?utf-8?B?dDE2SmRXVFY3Zlg1VVJ5MnBjdERreWUxcGpQbjVBNmZKUm1FZHF2THd1Yi9q?=
 =?utf-8?B?eDlMSjNIemhlR1VXZHJ5Rks4UkhDVVdmMG1GeFJGVW83aS8wSEFIRGhPQlZ4?=
 =?utf-8?B?NEhzWVRneEJhK0lUMUdtWWxhNXVkZTdBQ2ZvZDBvRE14YW9FM2dQNEtlZjRJ?=
 =?utf-8?B?dDNOSTFFK3FPZ056MHRUOFJHNmhSRlFqQ2haV2hrcEdXRzNHcVVoajRZdlJS?=
 =?utf-8?B?MFVEaVBzQ216MVR0Uy9tcHZEU0d3bFhjQ1F1bDRxeEhDMTdsenI2T0ZPYjB2?=
 =?utf-8?B?YWRCZlpMeCs1a054ZTJ1cEgvdEpOUjhoYWppWHlnMWpZT3hNU1BsWDJCODJC?=
 =?utf-8?B?blozRWJXdnNLNEdpdlcwWXVaOVZFNk1vRUpGcUJvdVlmRTRiRzNEelNIVzBG?=
 =?utf-8?B?ZzBWUGRxdWJSRmxTNHpHc3RKZnZzdE9kWE5WU2w4UnRXT1JCTHJRbEVIdXdy?=
 =?utf-8?B?QnViM3NvM1QvQmR0UnhKRG9SUkdsbzY4SDc5ZnVWU2gveDM5OWVvUkdKSEI0?=
 =?utf-8?B?eWdYdVZvUDZQa2dLZzY0WUtVZ3g2d2Z5WWZ0S1pVN3h6RStPMkhobzZnZEs1?=
 =?utf-8?B?QlJwOFJBMjk5d2ZMV2RPTHkvUVlKTFFFUWZ4Rk1EaW5SQkU1YTZUaUY3RFhy?=
 =?utf-8?B?V1Q1ZXlwcnd2LzVoOEc1RlhpN0pxYm5MdFRkQVpRemRIT0UxRFNnUGMvTmdU?=
 =?utf-8?B?YUVTSU1aMVpjZDY2NGNaK3hHdmNiYUpqa2lWc25VVU9xenlwdTVSSURBMG82?=
 =?utf-8?B?UkIvZkIrU3pyYTIwZVRkcDhMRUVXL0Voblhnd3VaV29kaTNZTFNhRkp2dURO?=
 =?utf-8?B?VTBXUGNlQlY5U3krL0xUVzBIbE44TFBqQWdoekZlcDJwbml0V3ZlMk9mRjB2?=
 =?utf-8?B?TEp3WDZkNXhrbEdGL2kyc0dtTmdicVowQnF0N0dGVHpObXVXSDFZeTMxYkVa?=
 =?utf-8?B?Y3NKeldhNE9qVXFrc3VkKzIyUnpLWDluNW9HV1Q5NkQ1RkRNM0NJRnk4V2Mv?=
 =?utf-8?B?QzlZZHAyQkFYVnBidGVqT3k2QnZqUGJZcnJiWmlLWlI2QnRtaUtuZnNlcDk3?=
 =?utf-8?B?QVlLcVh4dVJ5NHpLcktDMjU2VUQ0dkhUSDZ0RTBFTkJVSHV2ck5kcDZrb1lq?=
 =?utf-8?Q?om8V5p?=
X-Forefront-Antispam-Report: CIP:164.130.1.43; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 06:44:05.5534 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3c8f666-c269-40da-2997-08ddf5b598b5
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.43];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00025F96.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4006
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfXx2UGXyARjs5X
 rts1XOuBmg5uxcrTZJs+Z62ua+LPEXET69z5/xKEZtYCZk77+xPfxrP8WsstJ/te95G5/YslQiB
 QLZtsgdF/C2cblrVDLI63nlDyzndFQlwbiSCtFcAEYsmtK+r3NWFKg9R0XJaM8I3256uNi3oBCO
 xp3y/FvQa/iX9pNI2bRJbfwF9BGM8LZ8CMruoGW1BhscaYUtBcSMfS1gGz/g9fen7wXoBsFxGE+
 6/RQ79eD0hyvFAyBpihHo2LlZAB00dQD7Up3zN0gedAu/nU+bo9uL/4PrJtEJn41VL/8tqLDVXs
 uVeOb/7xSBPYK607OfzYjgTnN9Tn8wH2TIWSyk2WGVQqkVfC58yNEdrpNlyfoLWI3nE42P87/GE
 su+KYdZp
X-Authority-Analysis: v=2.4 cv=TtLmhCXh c=1 sm=1 tr=0 ts=68ca58bf cx=c_pps
 a=aENNojP290uMZkO2s5RJcg==:117 a=peP7VJn1Wk7OJvVWh4ABVQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=SAHXIHsbQyQA:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10 a=sozttTNsAAAA:8
 a=8b9GpE9nAAAA:8 a=2nK57JP7Lo_346AVEbcA:9 a=QEXdDO2ut3YA:10
 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-ORIG-GUID: CeY1Nbkp78uUr13bl3ER_hi1bZBuOv6D
X-Proofpoint-GUID: CeY1Nbkp78uUr13bl3ER_hi1bZBuOv6D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-16_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 impostorscore=0
 malwarescore=0 spamscore=0 clxscore=1011 adultscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160202
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



On 9/16/25 13:22, Anshul Dalal wrote:
> mmu_status is used in io memcpy functions to prevent accesses to non
> 8-byte aligned addresses when the mmu is disabled. Though there is a
> redundant definition enabled when icaches is turned off by setting
> SYS_ICACHE_OFF.
> 
> This patch removes the redundant definition, allowing mmu_status to
> properly report the status regardless of config settings. This shouldn't
> be a problem since access to non 8-byte aligned data can be done
> irrespective of icache state.
> 
> Fixes: 268f6ac1f95c ("arm64: Update memcpy_{from, to}io() helpers")
> 
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> ---
>  arch/arm/cpu/armv8/cache_v8.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
> index 1dcb6007475..74814601483 100644
> --- a/arch/arm/cpu/armv8/cache_v8.c
> +++ b/arch/arm/cpu/armv8/cache_v8.c
> @@ -1184,11 +1184,6 @@ int icache_status(void)
>  	return (get_sctlr() & CR_I) != 0;
>  }
>  
> -int mmu_status(void)
> -{
> -	return (get_sctlr() & CR_M) != 0;
> -}
> -
>  void invalidate_icache_all(void)
>  {
>  	__asm_invalidate_icache_all();
> @@ -1210,17 +1205,17 @@ int icache_status(void)
>  	return 0;
>  }
>  
> -int mmu_status(void)
> -{
> -	return 0;
> -}
> -
>  void invalidate_icache_all(void)
>  {
>  }
>  
>  #endif	/* !CONFIG_IS_ENABLED(SYS_ICACHE_OFF) */
>  
> +int mmu_status(void)
> +{
> +	return (get_sctlr() & CR_M) != 0;
> +}
> +
>  /*
>   * Enable dCache & iCache, whether cache is actually enabled
>   * depend on CONFIG_SYS_DCACHE_OFF and CONFIG_SYS_ICACHE_OFF

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
