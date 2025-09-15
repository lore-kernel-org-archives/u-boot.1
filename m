Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F918CAC592
	for <u-boot@archiver.kernel.org>; Mon, 15 Sep 2025 14:22:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86F4482AE1;
	Mon, 15 Sep 2025 16:22:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="IChSznGz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 530B583071; Mon, 15 Sep 2025 16:22:33 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::701])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03BE880B9B
 for <u-boot@lists.denx.de>; Mon, 15 Sep 2025 16:22:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y5Ii5F7btUcl5B6zwA2JccyyUUpP8uXtfE6TvdW6WpbwwM1o4f4VMUHZTb0Wku2wixzwoWKdtfyfnvTxYcl38dBeCLgmwIug6Ma182z//TsT8nPoAg7m59pwkzapp1dYwCVCZPnmPKkiw6+l1RA+M5ckzhIqXVMFcWAP8OOtAAhmEkoKxa4izo+JpeWCMNkE1tzTbUUzG7dfDS/biPe0E8yKOF1Zhy2PEoaBZjcUQXwDtFMH7TBK9oGALGqWXjwB2yP9PAOfTHizjRmpSN7R/ozvFtZqSzmKEGV8rWJZS7l5j+Cd8gGIpIp0SG9zD/dgbOSCbO+9wAUoV3FkIf7VgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8bX24Kob2bWyV0fXHKmUAKgivcv9QmgUtis1QF/bX9U=;
 b=l3Nay0Pq8TAlGqe9vrTACfIxXPU4wbukV2f1Og9SQtcRoaMrv6BDfip7l3eQp4E5nNfj9mQZx12KMufqloOkiWKw9QCFFvq3jWx/CoVEtDvAnYYlZkBtgMZTtW4d0y+Eq8gZqiZPJtWBeqASKl50nOmgpbx0r/7x7nXJO7hF0Mnr9vFJqoUOTgCdWOlcxfuMRI2qW3heX+c+8qOJ/qFtFnvhgwCesKhPPVu1EU/N1eZZ4z7V9IWO7rXqeLdkHg8xF0pyPfoaM/VSWSz3X0ZOtGoK9RKeiJEe8yf83pDDaHJBCrFyYc2KJXPwC55cRyjQx91y7DLiPSySoZmw6s9BJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8bX24Kob2bWyV0fXHKmUAKgivcv9QmgUtis1QF/bX9U=;
 b=IChSznGzLBhfe/X87FtIFV2zYcPcAERwTdPboGY9bTCcF6MPqn2rwuQ1/FRqaHt4S5xZiCUehZd5l47B1/YIKToQBy7HwnQaksY2ZCKMTvA2ng1t27Muc7t2FHbfaPraphx0b0tTr6Xt5DkYz3y7XpX7Zf9y9qFfFkKTAm+rkhWwziXBuxOYe84y8+OicCn+GpeREC6/iGxV5wkYeFDsFToZf7dLpLBo8CgNX8C65MjZIuGri7oXyWCgwKRbiBZ1DbnWU4HdSvmLTBtVXIDOqcygxJ+upSBFfG/+z4BDGxiqRQxj/s2eBRt/+luMicyEr5jH3vvQMZAARBwdeNVudA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4b3::21)
 by AMBP195MB2856.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:6a5::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.18; Mon, 15 Sep
 2025 14:22:29 +0000
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a]) by AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a%7]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 14:22:29 +0000
Message-ID: <b48c05f5-c8ae-4353-aabc-7217dad18d4a@phytec.de>
Date: Mon, 15 Sep 2025 17:22:24 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] arm: mach-k3: Fix MMC macros
To: Judith Mendez <jm@ti.com>, Tom Rini <trini@konsulko.com>
Cc: Manorit Chawdhry <m-chawdhry@ti.com>, Apurva Nandan <a-nandan@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>,
 Vaishnav Achath <vaishnav.a@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>,
 Moteen Shah <m-shah@ti.com>, Andrew Davis <afd@ti.com>,
 Udit Kumar <u-kumar1@ti.com>, u-boot@lists.denx.de
References: <20250910214514.1848847-1-jm@ti.com>
 <20250910214514.1848847-2-jm@ti.com>
From: Wadim Egorov <w.egorov@phytec.de>
Content-Language: en-US
In-Reply-To: <20250910214514.1848847-2-jm@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0098.eurprd09.prod.outlook.com
 (2603:10a6:803:78::21) To AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:4b3::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4P195MB1456:EE_|AMBP195MB2856:EE_
X-MS-Office365-Filtering-Correlation-Id: c355f602-46bc-450a-4373-08ddf4634d68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NWM3SzcwM3V4YlNCeGQvcVJQemZQOENoMS85NlFSU29jSHM0V2VBdjFKTnFX?=
 =?utf-8?B?dEd3eUVPZ1U5KzZaRll2cTRYWHVNMUQyMGM1NFlnT0NIa3N3eEpIUWlmbFJx?=
 =?utf-8?B?WlZwMGE1citVb25wV05OY1B0Q2lKeGpLWUpaK05EeXI3KzFrNkFNUFFKUGdz?=
 =?utf-8?B?OXozUFd6WUQ1KzUrNVE2ZlRMRm9PTXRpbzJ4NVl6SXpkTll5WVlmM01KcXFh?=
 =?utf-8?B?Rm5NZkVaY0l5WkZCNGI3Mk5KM0FTdzVybHFObTB4Q0VSZ2R2MFBiWVAvMU0z?=
 =?utf-8?B?OEtmK1VQckNWbElqeDkzOHdqSDU0aUY4TEpXU2F4R3JlVWgvcmd1VDEwYzlT?=
 =?utf-8?B?dUkrSmZFZTcxcm9YNjF3U2tzZUUvQ043RUk1Z0JhbTNUak1zeWduSWNWVUFj?=
 =?utf-8?B?a2hRbk12OXhYOFNucHVqd3l3Wi8xVDJ4YkNsZXZHK3JGcTNRUGJFNjZLaXVC?=
 =?utf-8?B?dCs0YzRHV0R1VjdVWkNlZ1hQOVFkVEZvSVpUeGJRRlFaditYRk5nQTVtTTNP?=
 =?utf-8?B?SkphSlBnWDFRbHZLc1M4OUQrNzlaVnZSTmk4TnB5UTA3R0FsN0V3Mzl0dysx?=
 =?utf-8?B?Zk1tK3JFU05xZHc2M3dVeUxMS2ZZN1VPMnZzQTdTbnduQk9lb3QxcG9zd3ZQ?=
 =?utf-8?B?WXNJdUtEUlIyR0xpRDZVRWl0VFk1R055UVdSSDFNNERYN2ZwcmFVekNxUVFq?=
 =?utf-8?B?Mk5wdC9hRVlSZzV5NmpyT2dQZXNsM1hsT0ROL2tSV0lWRlIwQkxOZitCeDNy?=
 =?utf-8?B?L2NXU3FYQmlMOXQxcFJOeVMrRnhIN3g4NXV3Q1pGRHpKYjdHelIrZ3BXNkdj?=
 =?utf-8?B?bVpWUVZwSE1GanN2MmwzZXJvYVNMK2J1Nlk1Mi94UEZyQkN3cDZtcWQrNzJx?=
 =?utf-8?B?Uk1IM0U3dTBuWHJMWjdTQVNuZlJMalFTNE93b0o5TGNud1NOWDlkdE1XQmdC?=
 =?utf-8?B?elNuR3phSHBncjlqZlRrNXVDRFVPb2FtWTNRTHlMNHpBaXpHbnpnMkZQVENa?=
 =?utf-8?B?SmhWbUVKSU9GV1dTRE5YYndGZFloK2VsWHpUVS9KRjM2SWxwcFJ0Y2tYOFZz?=
 =?utf-8?B?VlphTVdUUm5obVkwZTFvY1paK0UyN1pzTHQ3andFYzZJN0JKVE5uaWRaRmxx?=
 =?utf-8?B?Q0RtNjZnTkJ4ak1KUlp1bHdYWkxxSWtlWnByL0dBUUExLzZ5SC8vN3A1cU01?=
 =?utf-8?B?RWRaazVGOGlvQVAxQXFDYm02UzNubW4yZ0pNRDg5aVBoU0wrRUFlWWR5R1J3?=
 =?utf-8?B?VklySTQ1Rk9Hc1VMdXRTOGp0OVdESFloM1NTSFhLbUhjUDhTVlBXWm5SbTZU?=
 =?utf-8?B?WVh0V2xXY3poVUpLK1U2TGYxVGExakpmMUNvb0hzemswdnE4MVd0SGJqRXo3?=
 =?utf-8?B?bjByV1FqQUlicENveU9FVGEwUFVhS2FpWDNYblRMcTF6TENCUlhjeEIvNDVk?=
 =?utf-8?B?dmRpY3Q0ZDk4QVVLR3dQWkhJU29iUDF2azM2b3FmNDllWndJSW1nZlp1UXBp?=
 =?utf-8?B?UGhQa08veldpMTdmTjV0T2RTaW1VdS9yLzk0cTlkSk1qdDNaMkxGN3FBU0Zu?=
 =?utf-8?B?MWNGdnZoTUFvdi8zdTU1TjY3OHNsa1VlTjF4VzNKaW91NXlZYW55UG4zVzBa?=
 =?utf-8?B?amJ0Q0lreWJValBENHlLdHdUVXlPY1R1Y0hNanZHOFBhdXFNdlY0U2U1ZSt5?=
 =?utf-8?B?V0g3dUtqRFVQQi83UVh5RnFHVmlZTDNHejBZcTN5UEV1aERLbEtWRWVqSzF5?=
 =?utf-8?B?ejRUblZjMTExVWU0OGMySEhmdjloRjZodlBBRkJwd0ZFdFdSdmZBbUFWTThp?=
 =?utf-8?B?Tjh1dnM0d25wK0MvWERYWmZGdW1Jc0prakdzQUdBelN1TFZoNlc4ZC94MnVD?=
 =?utf-8?B?dUt2UWtoeUg0SU5YY0Joa1dzY2x2c1dOZjVPcFBNMHJsVDF2cEZmYXpyeGFU?=
 =?utf-8?Q?vhp1dFagPtM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4P195MB1456.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anZ6WlM2LzEwbFN3cVAwZnFwMmZnQ2xDU0x5UkhGZE9qcFF0bFdNS2RqNFIy?=
 =?utf-8?B?YkNLRGduWUpNWkx5M0JDWlkrdmJRWU1sakpNdkVub09IdHQ3ZDhFTm41NjFG?=
 =?utf-8?B?VW0wcXkzOXhZaGlzZ3pxcjlKMjBSdHNYN1F0QloraVJ3Q253SlBDMDZXczha?=
 =?utf-8?B?QUZJZkZZd01FVHVYQTZqa3J0K2daQkwxM2FaODNqcmxsclhZZG42NkcwS0Qy?=
 =?utf-8?B?d0dnY1o0a3gwcm5ZSWllb2dmR3QzQndneUNSYkxKclUvSWtzTHdPalRSWnpO?=
 =?utf-8?B?ZGdKS1FUS3RzN3pxN1dGVXBEam55Z1RJcTBkZEZXNzQ5WFUzT3N3RVVvUUxz?=
 =?utf-8?B?M2Y0bU1ucDVBSGluZEYwL0dZckJrdWIzVFBkRjd0ZDdOMnp1c3NKbFhHQzJa?=
 =?utf-8?B?eEFHZGhKU1RqMGV1VVpSVGdNRFVQdVZraWFZSjRNUVpac1M0RTIreFY3d0dn?=
 =?utf-8?B?M3pGazhmRW9BaUx4SFRlR2RXWVRjM0xWZG55M2t5d3Mvb2NRTTdhSjU1YTJ6?=
 =?utf-8?B?OTFidXlhRXkwM0VnQkZsaDB2MjF5V0RDNjhoYXFjY3pGdWlyMXRSbjdJQUpK?=
 =?utf-8?B?SXZTY0FLSGV4SEFVT3Mvcm5Wb2gwYy9nYlBmeks0V2hPMi85ckNiSENSVGJD?=
 =?utf-8?B?Y3VVZEdHME8wcnJDeVlZbGRRS2hMY0pESlRJSkMwWDU0YTBIMWNub2JxcFJB?=
 =?utf-8?B?RWpXTXNCRDYvTjc1ZVpzOXVCbFNoNk50TWt5R1BTdTh0aloyb244Ym83N2NY?=
 =?utf-8?B?VXN4ZG5FSzhJWS93b1B6Zkx5ZWxmU0JjZGhFQXBnSTNSKzhsdktjZndDYkk2?=
 =?utf-8?B?NXppc290aytvR1dIbzhROG4xdTA4R2JGbXdCRVFkQ0ZiY3pqYldFcTBCWTBz?=
 =?utf-8?B?bk96ZkFqR2J5M0l1eFRnVllsNmF2OXJiK2lPQm9WdVRRcWFXcW4rR3dzNVo0?=
 =?utf-8?B?NnRvSXduWXZNZ3piZmR4U3EySTJ1Z3AzV3Q4YU1TRjNFY0U3cmI1ZjVmQVpY?=
 =?utf-8?B?dmpoeWkwaTVPMkVSZ2RONlFqb1ZGUzRDaHVOVDNyRUwxTE5EZnViNmdHQjFl?=
 =?utf-8?B?M0VMSG94NC92NGtUVHZjS1BNeS9ldEpjWkp2cFFkVkVYbTluZGFwdDVKTU9r?=
 =?utf-8?B?YjNBNExRT2YxbXpEYk5VbUNaRmpoSi9wRFNlRVUya2RKdm10ak9Talp6NGlk?=
 =?utf-8?B?RHZMK2Y1eHhhRE9yeGgydE5idVZOQmZFQTR2TkpOWHlha1UyRVdLUzRYRFk3?=
 =?utf-8?B?WnFwNzZjNENqNktuUVVDc1FWaE9adHplNUI2UWYzamxYZnFOdUZxTnlpSWdj?=
 =?utf-8?B?bnl1cXpEamVuaHRnREdFWDhrQkREUUppWnlpazJZbHZzc2ZVVk4vSnozeEgz?=
 =?utf-8?B?bldCdWdLbWVJVU9ncXBXd0lHWFcyZDFIRDc2dHBMTVpUZXFiUkwvc0c5eHZ2?=
 =?utf-8?B?OEF2VlRUWUwvdlR1N2Y2MjVUaU9kYkhLUTJUZ3NhMTBtVEFkTjc0eDU4Vldi?=
 =?utf-8?B?OW1TT1VSWWVQY05ldnpvcFRocHFDczc2OVg4bVZLaGpOVUJiSGpUUU9JaUNV?=
 =?utf-8?B?NXZrZ2V3Rkh5ZzIwalhUUGc4azVPcGJ0aXMxS3B2WjRPZTlSOHJLMk41bU9T?=
 =?utf-8?B?VDNuYU9oV1U1d0ZPSHpJRnY2QzBScy94czVoK2Fra1FDNDBqVVBSVUM1VWJa?=
 =?utf-8?B?eVhxelNnaFZTMXdxTXJteW5oRUNhTFZKdCtJVEI5dHZtRm5kWWw0N3Bhem95?=
 =?utf-8?B?b0NqSFZVN2EzS1pROWFPQVdwbFRDSW1Uc1AzWGZJOUFPRlhYOWNRTkZST01C?=
 =?utf-8?B?czdiWWgrR3E0aktOVk9VUS9sa0NUSkhNd0dvaGFNRng2S1pjekF1ZGFDVHVa?=
 =?utf-8?B?NVdPTXBHajliSzVlM1VCRitQY2hMditWWklrQUtKQk1ETjF4S0tDK24xRzND?=
 =?utf-8?B?TUxKVzJKREtIeEwra1RwNTdKRjVJWFI4SkQzdi9NVmFaelNna2ljb1krRHpL?=
 =?utf-8?B?OWgvT1pYTnRQY2JJOXhRQ0g5LzFlR0llVFJmTmgxWGZuSGpOMVVpdGgyUGN2?=
 =?utf-8?B?UEY3T0NVRzlXd1czNlFONi9GNWM5TEdCZzF5KzFuMkdnYnQwMUEzOUVxS0Q3?=
 =?utf-8?Q?s7kkJT1/iLJcPqHVssq8ubU79?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c355f602-46bc-450a-4373-08ddf4634d68
X-MS-Exchange-CrossTenant-AuthSource: AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 14:22:29.6385 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z7xJXXuFtVTSoD2iRr5WgnAMwYwJjzhE4pwKTtWjD48MhnV4w5ENrbhUXWPrWVpYOdNb/LzJG/4pf64J+9xxIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBP195MB2856
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

Hi Judith,

On 9/11/25 12:45 AM, Judith Mendez wrote:
> For all K3 SoC's eMMC boot and MMCSD boot modes are supported. The macros
> however, mix MMC device with the two bootmodes. Decouple the two types
> of macros so that bootmodes can be identified with:
> - BOOT_DEVICE_MMCSD
> - BOOT_DEVICE_EMMC
> according to devstat parsed boot mode values and on-board devices can be
> identified with:
> - BOOT_DEVICE_MMC1
> - BOOT_DEVICE_MMC2
> - BOOT_DEVICE_MMC2_2
> according to arbitrary numbers mainly used to differentiate between eMMC
> and SD card.
> 
> Signed-off-by: Judith Mendez <jm@ti.com>
> ---

<snip>

> +++ b/arch/arm/mach-k3/include/mach/am62_spl.h
> @@ -17,7 +17,7 @@
>   #define BOOT_DEVICE_ETHERNET_RMII	0x05
>   #define BOOT_DEVICE_I2C			0x06
>   #define BOOT_DEVICE_UART		0x07
> -#define BOOT_DEVICE_MMC			0x08
> +#define BOOT_DEVICE_MMCSD			0x08
>   #define BOOT_DEVICE_EMMC		0x09
>   
>   #define BOOT_DEVICE_USB			0x2A
> @@ -29,16 +29,16 @@
>   
>   /* U-Boot used aliases */
>   #define BOOT_DEVICE_ETHERNET		0x04
> -#define BOOT_DEVICE_MMC2		0x08
> -#define BOOT_DEVICE_MMC1		0x09
> +#define BOOT_DEVICE_MMC1		0xFF0
> +#define BOOT_DEVICE_MMC2		0xFF1

How did you end up using 0xFF0? Is it simply to make the difference 
between modes more clear? It probably does not matter because it is a 
u-boot-only representation.

Regards,
Wadim

