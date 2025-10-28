Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D22F2CCD1BF
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 07:32:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1F5683980;
	Tue, 28 Oct 2025 08:32:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="ghL1m2pK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BAC783987; Tue, 28 Oct 2025 08:32:36 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF26083976
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 08:32:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=33961dc4a1=patrice.chotard@foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 59S6e4kv3839865; Tue, 28 Oct 2025 08:32:28 +0100
Received: from du2pr03cu002.outbound.protection.outlook.com
 (mail-northeuropeazon11011045.outbound.protection.outlook.com [52.101.65.45])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4a275j3r7r-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 28 Oct 2025 08:32:28 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IFekM40M8c+lbQ399GoL1tcVtRaTrWdKXmBMMiAmvmh3F4WBWVXAxHEaBjMcs+2K7Ns3Of0l5EOnLvugtNb8tXEuaLS2xvvD2sHUeBGemca1qDPGUQ8EEfchNONMNgeaQ9b8Ea+4n3xQYJW8d/jWEYo245WgRVCpnaT2iwY2VOvBr2uqzgs8RuGfWuhVf8IFRZSDgVYGzI8b3uT4Gzmiuxk8Ztnc+06X3iZCRJf6Ee9a6inCDIuU9RyJUSgmfyIxSxHeJJQyMwTARXWkLS8HjqlnXquaFvVMNf2mkIazcEg5mvfmMSeNMpmqOgQUk8oumk0Ap0NdlY6VPTo7bdZSdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FN9yRWAZC8FJS0a5AdX5g9Qxb1nPpE68vIu2fHvuAE4=;
 b=a1ngkGepGeaGMEsM8n6HW28fdY/3iUYGbkBHvDq5wssI2S8JZQIBzIjW1l1XhX5Bs+RPtJ7648HII0l54txrlZbzGf7v1/dnrO3lS3hoSzUVRkNfrkV4B9Yk23PpfwhKpv2RG8o+Ltyw9wfup6SN13fVvRxuhP16PlAm0pnf9H5LB9N5MYI6Q17K2z2uRuF5CAb8YSrqSVgolSCSDIwo6Tphwzu1Um6DquPygXXVOsVu2MHOB63D2170olaT26g5ItLbrpV2Ylus+IyWGZxKjdM9fIS8EuwaiokV51z8n704+mxbwxp50zLgg0qXSYwzc25hGr9Utyy33uhou2q81Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.44) smtp.rcpttodomain=eds-india.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FN9yRWAZC8FJS0a5AdX5g9Qxb1nPpE68vIu2fHvuAE4=;
 b=ghL1m2pKnLF1Ee/zy22HXOm45+Afzl0sJyl4eMY4bYvwu8ZNAT66B6/fsFFRpWQQ1KZ3VsZ3g9HudJcIRBshJuYFTgIjwyWDiUXKnBdW9xhec+nivSVAB3JpD2OYueg+RQVf9pD5Ifg8umSJHbDS8bQyg4G6pROE1C9D/apcCOi84qk7bx9EbfMz7lqSSS/YVpS3tBFiBLzI+AUlfCrCbbniJs40R/m/cRw6LiKhCApc7ThgJbgnwCtnaFa0lJnPbkOwjzsUo5CCJnDgM0/fX6F5/xD+8vN2eWB8MQhWAFPfSuea7M0x15mdwyURwJPbojXf/6Ykg5rnBMrq0cD3MA==
Received: from AS4PR10CA0022.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5d8::6)
 by GV2PR10MB6550.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:b9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 07:32:24 +0000
Received: from AM4PEPF00027A68.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d8:cafe::4a) by AS4PR10CA0022.outlook.office365.com
 (2603:10a6:20b:5d8::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.12 via Frontend Transport; Tue,
 28 Oct 2025 07:32:25 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.44)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.44 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.44; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.44) by
 AM4PEPF00027A68.mail.protection.outlook.com (10.167.16.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Tue, 28 Oct 2025 07:32:23 +0000
Received: from SHFDAG1NODE1.st.com (10.75.129.69) by smtpO365.st.com
 (10.250.44.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Tue, 28 Oct
 2025 08:24:56 +0100
Received: from [10.48.87.93] (10.48.87.93) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Tue, 28 Oct
 2025 08:32:22 +0100
Message-ID: <3dd82a3f-9c36-4fdd-a087-8eb71eca64c2@foss.st.com>
Date: Tue, 28 Oct 2025 08:32:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: stm32mp25: add ethernet support for stm32mp255 series
To: Asadeds <md.asadullah@eds-india.com>, <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <patrick.delaunay@foss.st.com>
References: <94b5922b-6f8b-4138-9d97-178c88bebad2@foss.st.com>
 <20251028053926.654835-1-md.asadullah@eds-india.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20251028053926.654835-1-md.asadullah@eds-india.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A68:EE_|GV2PR10MB6550:EE_
X-MS-Office365-Filtering-Correlation-Id: c3be7e78-7663-4b7e-95d2-08de15f42322
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eDl3QU9JU0Evdmk1NkVzK2RHUlNvUTdkZmJGdnJkdnBwOHplZkhXZ1REbEl3?=
 =?utf-8?B?WGJ6Rll0WERnLyt6U1dtQWdyaTlDK0ticllPOXd1ZXkrVVMrY1hVVDVuNnNw?=
 =?utf-8?B?QS9HcGhGYkdnK1k3OVR4S1FKYUd3K1orRjhRU3dsVWdGT0traDlxcWhpL292?=
 =?utf-8?B?U2pGbXB4YmlKUXhRb0xGTk5SK2RJR2VSeHBIUVAzRW4xdzZGS3R0bFMvVXhp?=
 =?utf-8?B?R21LMlZHN2RWRUtVNnMrNXBxVm8vc2tQTlplTmtQcXZ3bGRPdmlpdlh0Z3pL?=
 =?utf-8?B?a3VtVkhlaFladnpmajJ6c0tIbkVyYzhrRjVzYm5TdWNQVkhjUUQ2NTNmN0tn?=
 =?utf-8?B?NHFMeHRRNlNvdzBLU1Z1V3VRUXdldWpnaDVIVzFXUlFjQ0k2REVtemxLQjNi?=
 =?utf-8?B?QkxLdUlBMUR5WjFmdk5DK0w4RUJubXdRVFAyTWh4Yi8ydFZRdllLaEFvVzl1?=
 =?utf-8?B?OENpRENBdzc2OThLUDliU3htMktGelR2YjhQUldzRXNXQ201dmh5RitJdW5Q?=
 =?utf-8?B?M0IvSnhOcnFtNnhFZlhycUxteXYzdWVrcE85Ykh5SFZkWGhsQkt5S0NJN2kr?=
 =?utf-8?B?dkw1TEZSK2UrY0F4TDFkbzg1VWZOSzIybVp3SVRQTy9CcEVFYXlVbE9VQVQr?=
 =?utf-8?B?TC90S1hPN1JIR1JQbFYwMEZzc1dIdktGZ3lya0pUeS9lTXFZYjV0bFdCOUdQ?=
 =?utf-8?B?ZDJyank3aFRuMm5Ha0Z4WlNIeG9GOHNtQTBvNytJRXFxQm5qdlFIckVESnNk?=
 =?utf-8?B?cFpLQ0hzYzRuZTdCM1g3eitjMWp1dEZYN1BPK0pJUC9MMmdOc3cvNG5OQVYy?=
 =?utf-8?B?K24ydmhEa2JIVFZEbk9KbzJ2S0FpalU2YkxNdEVUcGk2VkxzNTFMU3Iwb3VB?=
 =?utf-8?B?WTFlN3FUN1NHT3VZUTIvMjQzcXNDd3kxVmpwNjg2QWkzWnBlR29LU0pKaWlt?=
 =?utf-8?B?T2oxQURyL2grdCtjUWxJT0hKaDVOR05JYXJ6VFFSUUdzU0h4aCtIZXFNWHRG?=
 =?utf-8?B?TTI2YkZsQlNPY05Ucm1nMnMza3RBa2VlSTZDVlFYWE5XSGhnM283WTltVjVh?=
 =?utf-8?B?UHlLUm1raUYvb0VndTdOK3FNaC9xOHp3T0kvdnZYV3oyRS9iOXp1U3FaaTJ4?=
 =?utf-8?B?Tk9RbGNVSUVpRW5aWFJyRlRhWHRMeGl6RVNHbVV5TldGckVERmovUnE5Yzc2?=
 =?utf-8?B?azFGSmFYZ0dBTHkwSVkyNU9BZjAzb2UvdkxuRzdqN2dyZTNLYlFwdVk4bGFB?=
 =?utf-8?B?ZHhGRU9EMXRvSEdscW9NUHpJN3p1RW9TRE02NGVqTEJRTWs4ZVB6TWlHMUNQ?=
 =?utf-8?B?bVppMDUyWFVBdWx3QUJqQzBtL09zVG55UDVjNGY3cTZhaGJTdjRiQnJDUTk2?=
 =?utf-8?B?YUVtTnhaa3laakE5WnhMaDhQVGY4QzdvTXdCT2lFelRjWHQzdldsUzlOTW1N?=
 =?utf-8?B?Q1M0SS9NWXRBZ2h5OVVGNUFsUHhHS2RUYWx5TnlhTVV2Tk5kRHpEN2Zkb2Z3?=
 =?utf-8?B?dmM0d1VlTHhLbWJHRFluR0xIL3JwcjB6K1dUMWYvbHFCdkxxYU5lRkhSTWhQ?=
 =?utf-8?B?OVdWZ3BnTzZoam85SlovTVJvRGlnZ1JzWDVGa0FHZG10NFpNNEQxS0tMTE8z?=
 =?utf-8?B?UjZKeU91dzJzK3NtTzIwZmNZcFR5emhGSUVLeUJ6bEx2S0NEazQxSmx2UnBV?=
 =?utf-8?B?cnpHZjlpMnV5d3oxazBmYWp6WVRhd3F6UDM2dk1KV1FNd2lCNGxpMnY1MWNl?=
 =?utf-8?B?TFBXU2JWaTVTTUd6Tm1TOTE1Z3h3M2dNU1UzNUYvWmJOYkpVZWwyaXRPVWU5?=
 =?utf-8?B?NTVZeWdKZ0VrN3J0YzY0WkI3eTZrM3ZQNlBtTHg1UWtSSG1qQS82YkIrbG1x?=
 =?utf-8?B?d1RYYjNnRngzWk9JaVFIV3VFSjNTZ0tNcnlEN3crWVZISHZqQXBMZHk0RUhp?=
 =?utf-8?B?WHdZeGZlYmRWVmQyZ1ZXanQwYWRYT2tPZVpHaS9ldE1DdjFpOEZZMS9mY29C?=
 =?utf-8?B?c0JqUGdvKzRGQ0Jja2N3NjBBQjlOZWN1Q2FwZjd4a0xVMFZDTE9RVWtNbVBa?=
 =?utf-8?B?L2xucWoyeFZVUFd6KytIOEJydUJvNDBrc2p6a0hRMEFwQ2NjTGF6MGdQb1BY?=
 =?utf-8?Q?d2y4=3D?=
X-Forefront-Antispam-Report: CIP:164.130.1.44; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 07:32:23.7684 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3be7e78-7663-4b7e-95d2-08de15f42322
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.44];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A68.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6550
X-Proofpoint-ORIG-GUID: 0jJwRozJGAiid8iUE5hWEaLuyFHRx42o
X-Proofpoint-GUID: 0jJwRozJGAiid8iUE5hWEaLuyFHRx42o
X-Authority-Analysis: v=2.4 cv=GKYF0+NK c=1 sm=1 tr=0 ts=6900718c cx=c_pps
 a=RuJ4w8nj+yI1DxvdIJw2Ag==:117 a=Tm9wYGWyy1fMlzdxM1lUeQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=XWp4PHTOCikA:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=2w8NBIiDAAAA:8 a=8b9GpE9nAAAA:8
 a=Z4t0I6lyqSrV-wMQOHMA:9 a=QEXdDO2ut3YA:10 a=FR9XvEe225z0xfbndyrf:22
 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDA2MyBTYWx0ZWRfX7St2Dwxh0JTJ
 1MluLByHpdFBZf3abSKQcAIGBHowyuNPZSIkkeAJWZ1D7oxG5jobYNWRJDUVaKuELVVT1Kwy5Mb
 yCG3W7wcstAr1GT/M74QgIbCRqj+D1ERq4XMiIm5NP96w2GAqLRdy80Bgx2gmbOxdxpFfEOj+7J
 bqN00iM08n1emfAQTy3LRvikv4hRSUyh88dnW77cZnHEdvs3nTTA5CVMk77g7Tkx/i539ISSVuH
 pPPfb5RDCJxtkLeT7cK+r0RR5pYHdBMTnrC7cfslkyG2puJgCNH1Fse8tStFgN0i/HlKaqKwwgt
 H8nLz9SgQYZrjycJq5tx5FpXb/O/x+Cegt8fko/oCEtxaxaj5a1qzP5k1vjdUlf3/t4tlt8bizx
 MaUpwi9mgTjVheIvoKktcKShnSyqvQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 phishscore=0 malwarescore=0 spamscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510280063
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



On 10/28/25 06:39, Asadeds wrote:
> Add missing CPU_STM32MP255* cases in get_eth_nb() so that U-Boot
> correctly reports 2 Ethernet interfaces on stm32mp255 devices.
> This fixes the "ethernet not found" error during boot.
> 
> Signed-off-by: Md Asadullah <md.asadullah@eds-india.com>
> ---
>  arch/arm/mach-stm32mp/stm32mp2/stm32mp25x.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/mach-stm32mp/stm32mp2/stm32mp25x.c b/arch/arm/mach-stm32mp/stm32mp2/stm32mp25x.c
> index 0d199f6f903..112af61e9b9 100644
> --- a/arch/arm/mach-stm32mp/stm32mp2/stm32mp25x.c
> +++ b/arch/arm/mach-stm32mp/stm32mp2/stm32mp25x.c
> @@ -78,6 +78,14 @@ int get_eth_nb(void)
>  	case CPU_STM32MP257Axx:
>  		nb_eth = 5; /* dual ETH with TSN support */
>  		break;
> +	case CPU_STM32MP255Fxx:
> +		fallthrough;
> +	case CPU_STM32MP255Dxx:
> +		fallthrough;
> +	case CPU_STM32MP255Cxx:
> +		fallthrough;
> +	case CPU_STM32MP255Axx:
> +		fallthrough;
>  	case CPU_STM32MP253Fxx:
>  		fallthrough;
>  	case CPU_STM32MP253Dxx:

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice

