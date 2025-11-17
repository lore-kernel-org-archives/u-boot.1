Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C15CCEACEF
	for <u-boot@archiver.kernel.org>; Mon, 17 Nov 2025 06:53:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76DD8835FD;
	Mon, 17 Nov 2025 07:53:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="Pcvy43ID";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6254B83980; Mon, 17 Nov 2025 07:53:50 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3ED7F835FD
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 07:53:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=3416482c8e=patrice.chotard@foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AH6PcGr571065; Mon, 17 Nov 2025 07:53:43 +0100
Received: from osppr02cu001.outbound.protection.outlook.com
 (mail-norwayeastazon11013046.outbound.protection.outlook.com [40.107.159.46])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4aejghn7k5-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 17 Nov 2025 07:53:43 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W0Z1DtORx0nUOAUYizD7PjJARI6IsNVZh4DYtZiBHTjFgaGA7+sgbmWt4t5I9L1lZaPicbMCgocnFKRfkxr2GW9c10/sPrGvAAe126G/dy+aYrs5GjNEnooKIB9c/q1C0fQZkx0csD85XVOJ1KpHoVYatM+22jlqtjKWq/6/QxC5NwDh6oBP205KLJPCDHViGqLu4z4dJ6iLIvQIcfDHdfZdgfoH48gzwrEaxUMg5eEqTmulEuz2vjoOAw7zxlsEwFbhT6n20PnWjtINzQhUZ1PGUTGZ8sykYH/9KHVDv2VEpNdZbvdWZeHdAmztlgknn7pNM5QUajy4BVhjIWU7gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6COHSxbIXis4K/ejlT04TucCNEo/fzYcy6iGDUzPkHQ=;
 b=Fgy2ucLV538IACMOV/YgDOCld2uvW7W47+KOo6phO67U45cw8kz5TzhR0lLnp0pDmw35AJQhED5tPnJKOAyW78dkFIaNfDnyr/4XlDMSFTqqgTNI3O8z/Vnv8YjoaFk5+OZxYFxqkaYh98p0r73QPi+aHXOf/SqXOZ3vVV7jjEuechuCUCE3B9jQbO+OfLcI7YEW/1zAREJCtO9qmZbTFiXpVMXZEtEmMdjCa6dJDod3Vv/MYsvMg22uSoSPIBUAB43LVw86H1YHT4HzEteUL5hMICA+0ty/3tnT9c5dkDFFzVbeAFU1v96+Ij8AWIecceDohZCH9xDKbQNThaVNcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=eds-india.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6COHSxbIXis4K/ejlT04TucCNEo/fzYcy6iGDUzPkHQ=;
 b=Pcvy43IDUr6LTEG07/wtgIffGLR0nGiIWEXXSnRHpDcK6DomKPxcR65JvSqlcJ8jcsRDJFrn8oiWqYxAvDxmYiMg0gUCmnIVaKaG4fEgCHkQKQ7CArgnOmgWn0spulq6rsKoTsZRT9NNfpdBnaYahmHaechMBysbUdEyga6m63PE/iMGXBAxORiMAxw07nj62xWJpajLi1aqZPB2sQ/vKa1rxpJAvT3CiKhusqyuQ62HpSGjhXbwKwTZyJjSyI3pS8uQhcHy4cV/hFJDZslgkjGY7znLxCJqOkwSAx+OMLJ/qR2X9CwpXLryjFsKYUo8oWky8VgOrlqtEJnyLVIv9g==
Received: from DUZP191CA0065.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4fa::6) by
 VI1PR10MB3216.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:131::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 06:53:40 +0000
Received: from DB5PEPF00014B9B.eurprd02.prod.outlook.com
 (2603:10a6:10:4fa:cafe::ed) by DUZP191CA0065.outlook.office365.com
 (2603:10a6:10:4fa::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.22 via Frontend Transport; Mon,
 17 Nov 2025 06:53:42 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DB5PEPF00014B9B.mail.protection.outlook.com (10.167.8.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Mon, 17 Nov 2025 06:53:39 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 17 Nov
 2025 07:54:03 +0100
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 17 Nov
 2025 07:53:38 +0100
Message-ID: <a9396330-f975-47f8-8be1-79e4efeef72a@foss.st.com>
Date: Mon, 17 Nov 2025 07:53:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: stm32mp25: add ethernet support for stm32mp255 series
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
To: Asadeds <md.asadullah@eds-india.com>, <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <patrick.delaunay@foss.st.com>
References: <94b5922b-6f8b-4138-9d97-178c88bebad2@foss.st.com>
 <20251028053926.654835-1-md.asadullah@eds-india.com>
 <3dd82a3f-9c36-4fdd-a087-8eb71eca64c2@foss.st.com>
Content-Language: en-US
In-Reply-To: <3dd82a3f-9c36-4fdd-a087-8eb71eca64c2@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B9B:EE_|VI1PR10MB3216:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a2fa42f-7f9b-4965-30da-08de25a60a24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NUZ4ZzdBN1k1SHVGcG1JR1lzUmsvQmhSRTNXOTN5SHNTeDV2OFMzWDBvSXZN?=
 =?utf-8?B?RUJCVS91NThtZDluKzVKMGhUdlJRNFQrS3ltQWFGYUFRcU0vY0Q0RTRWZUhC?=
 =?utf-8?B?SldNQnZjYWxvTGVrQWZSYm1vQ0YvdmxOSW5yOTNLaE5EUzZSczFkN0tsOURK?=
 =?utf-8?B?WGtLOXhGMXFxQlZOcjAyQnpCWHRWWmNTb0VCZm9idE1HTzZFY2trbnhJODhi?=
 =?utf-8?B?NzdoOWN6cC9rQ0VtdmIyVGNDL21BcHdMcnZLU1dBRFEzNVA5a0Z3bWtlWGsz?=
 =?utf-8?B?eE9nRE51cVViWGZ2eXhqeUJwQ2prRmJzcUJYV1BVa29Vcm5JblFHWFFIVy9v?=
 =?utf-8?B?c2FIaGtOL1RnUUt4SHBaeUZBck5vUWZnbFRTSFpZblErYytzRnRGWlZ3OVBU?=
 =?utf-8?B?VUtJMnNkQmRZWm9lYi96RmdlMnN1ZjBvWnF1WUJmcGFKSUpCMWV2ZklvZEVh?=
 =?utf-8?B?SWUrUHg3bU9qOW9IRC82c21RN2lzeDNBVnVDbGEzVUttdUtHZWpwUENFeFNG?=
 =?utf-8?B?ZmZ2aFEzZElDcTduMnRpbjVncG5ja3cwV2o4YjU1bnM3THFoSmx6VHhWcWg0?=
 =?utf-8?B?d3Baa0xhK3VYMzNvY0tNbmxUYjFqeDNReFhBN1NiMG1VRUVEcE9oaDVUczJn?=
 =?utf-8?B?dFJLS3FBcWdBaEttTW8xRmJxYzc4cnhWQnFtTXR2Znk1cCt3Nm5KamhCRFZE?=
 =?utf-8?B?M255Y2prUUJVeTJrQWFlVFMxNmVHOVdhUFg1N2NNM0tYeHArUFZWRWUwTksv?=
 =?utf-8?B?YkdRMW16TEZNc1F0a3h3QklWTDgxeUtNTGgrbFlzTHlUZGV4WGZDVmFDTmc4?=
 =?utf-8?B?d0JucEl1dWtta29qWElITEF4TGdNQk51OURTd0pmY1hEcURzUGxVdE9kUU8w?=
 =?utf-8?B?SUVyQnJkZWdGQWRmdHBrdU9EOHgxM3k4THN5aUtMdDBPemdlcUw2eDVwUGZY?=
 =?utf-8?B?NXR2K1lEYkhrME9PSENlMHlJcFpKZ2RaSTRLVUtvbDRZc0dmOHEvVnhwUFdh?=
 =?utf-8?B?VW54MGJ2eGd0MXBIL2FQdXFDSURiU21tU0Jyck9VdHZmQ2pXVGdXVzdtdHBV?=
 =?utf-8?B?QmNIWjZnWkErOHhPUXcxb1oveDhCWVA5Z1dZYnZTNGlCSkt4M2VHMTBlalZt?=
 =?utf-8?B?MSsycW53RFl4VVp3RDh5L2JFc2l3a2F5ei9IM0VjeEtqQ3R4MzBzdG9pOEpV?=
 =?utf-8?B?SWpQVVVPdUZ3TFNRbVIvRFRybHlWT3Rab25wNlp4cWpqT3h5ZXE2cm9ES1Rv?=
 =?utf-8?B?SlFGMDkvdklScWJrWW9wY2RXMFFmb3Q0OWozcTlpUDZ5QkpHOHBKc25YaFB4?=
 =?utf-8?B?dlBtaUlYZWlSdDhqN1BGbE1uK09hSzBsS3RiZWo0QkF2L2VJNUhON2Zad3lK?=
 =?utf-8?B?ejBoM0p3K1Vuaks5VlBscUxHWktGUEZjbjRjZkE2cHNVQUlnbVg5T1dKTDRP?=
 =?utf-8?B?R3RCSW1yT0JhajU1M3FTTG5XaWNhb2xrdFVEaVE4UFZTbmFwMVVGU0RnN2RM?=
 =?utf-8?B?UFdSYStWcTQ0ZGxla0dUYmh3U0VoWnFydUFKK0hkU0xTZjVTbGp4RjBCcGo3?=
 =?utf-8?B?U1o3S2JWTzFnc25NTlQyTGZnNkF6cGpLR3VBZlhJQWhBYWpyWmxGUmIrN20z?=
 =?utf-8?B?ZXRLcHVURmMwRUJMOUU5S3BFSTVmektEL056ZUpHN0FLSGMzbmM0UnpWOUdy?=
 =?utf-8?B?ODkrSUNjdSs0K01jSklQc1k2T29jNHcwTW1ySGxuSFRUUzVlYlkvQlRhWVc5?=
 =?utf-8?B?R2ZMYzlZTkpMWU5vdGpmS1kzajFhVEx4VVkxQzM1ZzU3bTZtUGo0NlVxSUpv?=
 =?utf-8?B?eHVtSzNvZ2xJeWtLeUdDcE5aYmgyc3k3bnUySGpyZ2M1Q3VRd0Q0VUFrMUVm?=
 =?utf-8?B?Mk5YT1g4c0dSelU4RkNkb2xVWTR4Q2ZCVDFaSWVRdVNKa0hpWTJqVmxibHZE?=
 =?utf-8?B?cStzTDNhcWNSOWhoWEVuSnY5ZjF5SmFXLzZUcU1hN01ZM3g0RlE5S1BBbzlo?=
 =?utf-8?B?d1Q3dHR1S2JpS0RwZzViN25SeTU3VC9Lb0dyVkwyQTVVZFI3am5vZDQ0R2Vo?=
 =?utf-8?B?cUJhU0kzQURtRHZBRStPOTNqd2ZzbVJpaWdtYkVMRDhHblVmV0luZDBiWXh4?=
 =?utf-8?Q?EiPA=3D?=
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 06:53:39.7058 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a2fa42f-7f9b-4965-30da-08de25a60a24
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B9B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3216
X-Authority-Analysis: v=2.4 cv=G+cR0tk5 c=1 sm=1 tr=0 ts=691ac677 cx=c_pps
 a=7E8kR0TPtiWwzUzoHzRCyA==:117 a=uCuRqK4WZKO1kjFMGfU4lQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=XWp4PHTOCikA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=2w8NBIiDAAAA:8 a=8b9GpE9nAAAA:8
 a=tN42jBBFePafRGzt_20A:9 a=QEXdDO2ut3YA:10 a=FR9XvEe225z0xfbndyrf:22
 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-GUID: kpDT5wJyppDybzBnsHinHhUUiiRBBbFf
X-Proofpoint-ORIG-GUID: kpDT5wJyppDybzBnsHinHhUUiiRBBbFf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE3MDA1NyBTYWx0ZWRfXzXRBjmqb68he
 /hYnrOLgEkxV6GZtRGC4CTLsTx5fY8y5JBeBW4sI08BC+wyEiePZ9f79CUKcjWpTSd1ZRPeRLKl
 AzbKuzqeWh94WAl3A6Tvwc/ms57BfcY0ASFdAIc/d6n0Gt4ETYj4eO7+o6gvt9S+QCi1cKhJgbN
 g6KddiWwhfkF7KJ3ru1hmfX5JnTRvL72gOnYW/S3+I8HXvmvMZyaosd/KcDGqIvPEOF9ZSgk1cD
 ViM85MXcRln2GgNt3a2Wbe3vTteIA8pAk7I42tgXOEtmAVtsSMcMuQTngUmcxNtKo4AapVVOVk6
 R9EJwx6Xk9pviEysr06xVCbKy2h/Ruk/zC4sw2PoXiCRJbrJAYgXgkhVt1Mgj0VKCndxvlmjdQ9
 A78yde/AKgGCTh0QQKFJ2qVX2ZUqeg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_02,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511170057
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



On 10/28/25 08:32, Patrice CHOTARD wrote:
> 
> 
> On 10/28/25 06:39, Asadeds wrote:
>> Add missing CPU_STM32MP255* cases in get_eth_nb() so that U-Boot
>> correctly reports 2 Ethernet interfaces on stm32mp255 devices.
>> This fixes the "ethernet not found" error during boot.
>>
>> Signed-off-by: Md Asadullah <md.asadullah@eds-india.com>
>> ---
>>  arch/arm/mach-stm32mp/stm32mp2/stm32mp25x.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/arch/arm/mach-stm32mp/stm32mp2/stm32mp25x.c b/arch/arm/mach-stm32mp/stm32mp2/stm32mp25x.c
>> index 0d199f6f903..112af61e9b9 100644
>> --- a/arch/arm/mach-stm32mp/stm32mp2/stm32mp25x.c
>> +++ b/arch/arm/mach-stm32mp/stm32mp2/stm32mp25x.c
>> @@ -78,6 +78,14 @@ int get_eth_nb(void)
>>  	case CPU_STM32MP257Axx:
>>  		nb_eth = 5; /* dual ETH with TSN support */
>>  		break;
>> +	case CPU_STM32MP255Fxx:
>> +		fallthrough;
>> +	case CPU_STM32MP255Dxx:
>> +		fallthrough;
>> +	case CPU_STM32MP255Cxx:
>> +		fallthrough;
>> +	case CPU_STM32MP255Axx:
>> +		fallthrough;
>>  	case CPU_STM32MP253Fxx:
>>  		fallthrough;
>>  	case CPU_STM32MP253Dxx:
> 
> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
> 
> Thanks
> Patrice
> 
Applied to u-boot-stm32/master

Thanks
Patrice

