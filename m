Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A49F6D12D6E
	for <u-boot@archiver.kernel.org>; Wed,  3 Dec 2025 14:35:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31F7383FC0;
	Wed,  3 Dec 2025 15:35:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="CmWbsuaF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A537C83FD4; Wed,  3 Dec 2025 15:35:21 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69FC083FBE
 for <u-boot@lists.denx.de>; Wed,  3 Dec 2025 15:35:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vm8WHdtExlMERQ6vDcl9GEyMN0v134Gbtq+BDT90gULxV2k//sPeZJ7cg5Qgsk5kveIbdRfVSMmU0EN3J6lVk8MEorMDwoo3yLdKX5qtIX0vpRSr3ae63LSrwH1bsPvNKe3F6iHAegn6voWMVaZ3GY8Tww9C8MM+Jl9ACmM0SkOlLdBK/tcYwEW13SyRngdYyalCZGqjo4AhGPh3O8oc4GjCz2hO6toYXA2G5kRIwnL315aT8qW6j1WHqOguMMNMEE9u0ZDKBjQNs/YOpbX5jXRRw8ybUqq+tPmVDiJ4eN4X2TtxwTIBnTgqdVvw2+EXI7Jx/gsweOXZHJNf9CA67A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h7G2cIMjhVuZIcStmTzxvUeT/USXeeu8xzwjFpHaKD4=;
 b=IsEBMF5fJKFABIrsQZIkUqZGcNEHDPRG67pUjDSkrYdBh98B7VOnV+NCbGYmq2Pp4SxhA9j+045Pjjmc9jNLp4CnoTNIQfhMyWZXKomiVDJE45o6y5R+pnKjm3D00oJE6GGeJUNhPTfSEmBNSdj4PpY+0nkNw3W5wAArmGonp9kptElDJHj2Dze/7OjdLM82fELuCrNBclYs+A4I38WXCeHmmWODA+qh1xiyrIF5Ok3liyDuuV304tojmkSOr8APFokQv7rkSLoyRTrslfOwCIWHzc/dNzp4qGaB9FIAJn6u22mN5i67y8h9LYmbcgStwPFFNlnDX3BlOyjSipPd8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h7G2cIMjhVuZIcStmTzxvUeT/USXeeu8xzwjFpHaKD4=;
 b=CmWbsuaFaIYnYIZmCQVUNXS2QClNltfLZVQ+alj3l1k3+oh0weu5QDAD12tRDiHcMBFKqGdOA1H7RgNR4XSju9LKvKxMTKWYoPxLehCYw+2cPnijff21KAT4FzNUOscQkKru8BCUrAGzY87zVXVfdesh4SVJ+cwgr3W1Bm6a/SY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DU4PR04MB12026.eurprd04.prod.outlook.com (2603:10a6:10:643::14)
 by AMDPR04MB11677.eurprd04.prod.outlook.com (2603:10a6:20b:718::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Wed, 3 Dec
 2025 14:35:18 +0000
Received: from DU4PR04MB12026.eurprd04.prod.outlook.com
 ([fe80::2c21:dc0b:a3c5:531b]) by DU4PR04MB12026.eurprd04.prod.outlook.com
 ([fe80::2c21:dc0b:a3c5:531b%5]) with mapi id 15.20.9366.012; Wed, 3 Dec 2025
 14:35:18 +0000
Message-ID: <a3315c71-b1e2-4c68-8ee1-2385a2ad6e1f@cherry.de>
Date: Wed, 3 Dec 2025 15:35:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] binman: fallback to importlib_resources on Python 3.8
To: Chukun Pan <amadeus@jmu.edu.cn>, Simon Glass <sjg@chromium.org>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini
 <trini@konsulko.com>, Bryan Brattlof <bb@ti.com>, u-boot@lists.denx.de
References: <20251202100000.372409-1-amadeus@jmu.edu.cn>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251202100000.372409-1-amadeus@jmu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0022.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::29) To DU4PR04MB12026.eurprd04.prod.outlook.com
 (2603:10a6:10:643::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU4PR04MB12026:EE_|AMDPR04MB11677:EE_
X-MS-Office365-Filtering-Correlation-Id: 5518943a-f168-4eda-c60e-08de32792e0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|366016|10070799003|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eHV0ZE94Q0RLa284MHQwZmtsZ1YvODRwaWNQWFVoRjA4UVRuL1ZQZ28zenQx?=
 =?utf-8?B?dTFFaURYWUVnUncrMkh5UExFeHh1aTFKakVpMVpTN0p5bU15NGtHSjBIcGlh?=
 =?utf-8?B?aS80YnhBaUNlbXJuWnBPL1FpMnBDSWRTVGtsNGY0cm02Vk50TzJVTmpVRVpV?=
 =?utf-8?B?MXlIQ0pkMlVnWjFDS0pxOVZNZEZsNnh4STNUa0JMYjRqOFNkbkVNNHRVWitI?=
 =?utf-8?B?Z1FBM2dDV0lIamI5MEp6elZpekx4SVI0YXdsTkwxRUpXbm4yU0tkR3hjZmVj?=
 =?utf-8?B?ZEdXclRIWkY4djdCWFVFaHdzdi9tUlhhM0xodTk1K1Z2NktaUFluQUkrY21F?=
 =?utf-8?B?WGFDZ0RQNis1ZGl5dVNYZHp5ZE04aW55S1JMQytnc0kvWjlMZzBNRTZZMFU2?=
 =?utf-8?B?d1VKMHJtRHlrQXFTNnpBN0pOaFY1NGgrdlN4VXo3NDlBQ255YS8xRmt1eEhN?=
 =?utf-8?B?aHllZlVJQ2x1M0twTVBzUDZISjRoZE51RnV0cTV2M2U2S2RENkdyRmVibWI2?=
 =?utf-8?B?WVBMdGhKcjh3ejRGWHdrem1JejNiYko5cWZsR0xQd3Q3eGlsejdDQ3lORk1Q?=
 =?utf-8?B?TldEV2FnaHRrVmNkSjBmc1hCR1hwSDFRcFVjclBUWTZPb2U4M051TklXMWNr?=
 =?utf-8?B?THZkYlV1Uzg0czdMbklWK3BrTWNVZ0JvNjFTMnA4ZkxvWVl1M29TY01ZVjUz?=
 =?utf-8?B?Y1BEKzFyd1VRTkc3RE8vcHlZdmpLa2lac0JtOVJMaGNPK1BvbER6YXNNbXJw?=
 =?utf-8?B?cFJaa0I4RTFwMlY4RWtGcnUxVmxQUmd2a0d4ZGUycCsxUjNPeEVlTHlEWjRJ?=
 =?utf-8?B?NTdZTVRVQUlXTXNTNmVjeUwzbWIzaHRXditEblFscllHMFlWZ3NCRjhEbEMx?=
 =?utf-8?B?MW4reSs2YTRZVXZSNlBBaW1MMmltUU03YmduZDdKc3JjR0xxZ3B6R2ZLR0p5?=
 =?utf-8?B?c0xRVGdkQnVacXFVa1ZNUjdPRzNhYnluZEZJSUNOZUw1aHp3VEFMTjBnbzBZ?=
 =?utf-8?B?SlZXZlV0TE9OME00MmxGbThqd2V1MXIvMERwZVFWODlVTEg0aWtIMWZRUEdl?=
 =?utf-8?B?MmxBbzZLb2xkdjBiZTNXME84Zkg0NCs2M2duOHU4Y21nTWZQQnVvTnFPdDln?=
 =?utf-8?B?Slh5OW8xTFk0alZlc0lZU29YZnp4ZGwvc0p6blkzcTJUdTR0My82MVRSU0ty?=
 =?utf-8?B?MFZlbW9DaWJ1VlI2VGhEZXFTNDltc1hIVThJRXI1cFM4aXU1UHFQK291TWRk?=
 =?utf-8?B?bVVPVExaUndDSE9sK3JlTXRKNEZIblhxSUJsdk9PcFZuejJkWndzTDJYS2w4?=
 =?utf-8?B?WHpxcHhsbitLSHNkRjNVMU1VUmdiSHU0dkxzUHIrWmlUSklwRWdzeHptWUtM?=
 =?utf-8?B?Q05kdUtlUGVZWmFodU02RVAwWGJXUG1iTmVxU09pQS9lYXFJajdSbWJ5NEQy?=
 =?utf-8?B?dW9OWVp6dFR1S2VldUJqVkpuazZmdDZ4M05OYm11YVZTR1hXNmtaNlpGVnRD?=
 =?utf-8?B?ZzdYd3Q4UlpKNmNKbGJBZHlzNHpkb3RiTWRhV2xmSDhZTHZQR0Z1SUxSdzIr?=
 =?utf-8?B?VWFQT2trSzY2OFhxNzRnbW4wUEp2VUlsMGJRS1VHN2JFMkNaY3hRUm05T0gx?=
 =?utf-8?B?MHBRNDlFVXowayt2VmlYQkxQblNXRjRwei9YSEUxb0x0dW9sUStVU0ZONHM0?=
 =?utf-8?B?ZkRQVzJsb1o3TzBteVNneGVud2JTOHlReTZTSFJnV2FlSTZHVzFIMG9IT05r?=
 =?utf-8?B?U3VvNlR1aXBRRzZxR3NTaW9IcTNqY3o3eHZZa2JMN1htakVpWFVNUTJDQTRa?=
 =?utf-8?B?cTBXaTNPcXNhcDRxakFHUUkrZUxpN1hsWVZ1T1hhd1hXTmJEcTE5SGFTZHI2?=
 =?utf-8?B?YXZuSEZaTjlDMWVTdHljZTRoUE90aUhuVVRMVVRNbHdrYlduNGxTaFJMWTNI?=
 =?utf-8?Q?CAEvTKGqsAxpMzDLvu+/CXVzynnrBzKR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU4PR04MB12026.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(10070799003)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkM1RS9HN09EemlFRWYvWnFxa2Fub2tnTkVRT3ZhbDBqT2g0YzRrZDIweTJO?=
 =?utf-8?B?bUdQK3ZXSHNkQmo5djV4d0RoODZKa285em1ITGt6RFIrWWtyY2hkdFRIaFY4?=
 =?utf-8?B?QnRNSC9ucW5pUHZsOHY3cUxuM3Y3RWRaOHJQWDBCckxJQU1USGFMM0FkbG5P?=
 =?utf-8?B?ODFURXphN1NWNHR0Z0o1blZ6N3RseGlRb25kby9YRC9qS3JaeGk1WGQ5NVd6?=
 =?utf-8?B?aVVPVGRETHV0cHZKemRRZ29nNjZraEtPWERrS1Z2T3NPNkZONTE2TFV3Y0xK?=
 =?utf-8?B?bm9udmQyQ3RUTktzK2w3RXc2czVuNENIV2ZtWGVJQWQ2blpzN1VFT0MyY2hQ?=
 =?utf-8?B?VnhkUGx5QjdtaG5Kc3dzcVphN2lSYVBZOUtIZmVCUjlHa3RBVWxYUk1OTFhN?=
 =?utf-8?B?QXJPbitKOWxJQnlUbG5ycjlCKzUzOE9mR3p0bDkzNXRCcVEwU3QyRGFNM2Yr?=
 =?utf-8?B?ZmVQMWg4R282Y2E5U3FTOXpHb09OSk8xdDVaWVdFcWpVM3RyUVZrRUNMbDFy?=
 =?utf-8?B?emNGZmxxNXZra05jZWdPU0k4cnlicUNzeG5IMDFKV3JNaDZwUzVwRTFVa0FH?=
 =?utf-8?B?S0NJY0RqeXZjY2RscG0zU05JUjRUcFUzM3F3Tm5JVFQvK1hIeXVibkU3VExF?=
 =?utf-8?B?WENPTmFkMzRzWEhPc2V4NEZDRkRMRFFXbFM3SHJzYWpHbUUzNmw1V3lmWjJt?=
 =?utf-8?B?RjNQQUpqN3RHNWpjM2ZHaWpmdFprMytia3lxMUVXanloSTRjbE5uOFFteVdI?=
 =?utf-8?B?b3c0MkFQd2NnakU1QmRBbXRIeFFhQ2JqMFRZYWJpVWRFR0RLMUNaYUhqTjA5?=
 =?utf-8?B?NkdVUDVsRzgwTUxQQTFCaDdOV0NpY1J1RS91UGV5Z3dZR0dQZGJsRjYrRGZm?=
 =?utf-8?B?R3pNbW5KbitNTnNhSUkwQzIxeVRnOGxQUlNlRy96MHdnV0MvQVVjRERSRnhN?=
 =?utf-8?B?Q0dFNDR3TEdSZVZtU01XY01SampkRlpEUUliMFpTM1BPZXBRWVY4UUxvc01q?=
 =?utf-8?B?bXhNanNwakJYV012UEx6ZndTM3A5MkNObGkxQ2FnY2MxZlZRUmtDdHVQRmRs?=
 =?utf-8?B?WHRmTWtPNXVKMVFjU0pXUUhJRFlkbldabHpVbXdYWVdrdGVMcThLUUJWUWxX?=
 =?utf-8?B?bmxaNWxrZ1BNVFRlbCtqaTh4MmkyYXdjKzRKaUpjVFNBUDVTVjRVYXhKMmJI?=
 =?utf-8?B?ZDRmVmdEclV4bm1xNTBhUTVFU1F2RFdtUHpQM3VUVkZwd3BGQzhpOWlieTVS?=
 =?utf-8?B?b2N4V1pZOGtEM3NYR1NHYnlqUGJHcnBYdTlGMHlpVWhZcHVwZXZpQklHUnl1?=
 =?utf-8?B?Z0J6akZoN2tsMG1IQkRIYkdIelBucG4zTFlwYUc2Y0hJOGxTY3dIbUkrNStn?=
 =?utf-8?B?ZEQyaUVBK3M1NXl6VzNKcEpaWEJsbEt3Njg4Z1VGbmwrdmRrOFNuN3d6SXVW?=
 =?utf-8?B?VVhiQVBZRXdUODYxQ0dOOGFMTWhLdUZtNTM1dWNoVjVtZmVrWTNjVnVBYVhl?=
 =?utf-8?B?azRuL0dKZHdpRlBTVklFamVKZGUyajhwdWFpRjJLdSs3WisyRFZhTm92aU44?=
 =?utf-8?B?THNSYlh6UjF3aDFEM0ZidHBnRjdTaEdXS1pzWDVDTndHdzlieDBMY0k0MU00?=
 =?utf-8?B?RCtvMGZKTCtuM0lpbllFNXBtWmhqZHBEZ1owRW4rUTFLNVQrS3oyMFRuZGoy?=
 =?utf-8?B?WUdpeHVCb0FGalFVNFM2a1BIYkp1RDltVi9ZcHhJdHpyNzFXYnhaaEViVDFm?=
 =?utf-8?B?YW45MmF3QnFqYjhMUThHUWpkTGhuUVNERElxbVNmcU84RVdhdCswWXJFbUdr?=
 =?utf-8?B?WVhidHEweE5tMUt4b3V6RWdYZmRmVGI0RjVkM1NndlMwbW9GOTRlQldFQVNI?=
 =?utf-8?B?UFlCNTAxVUkyMTBLK2xucVNiNHZHalRzMHBYMDMreVVSdVNRR2RHUnpycCsr?=
 =?utf-8?B?VDJMQUcyZGJ2U3NBRThHUWI1ZmdDa2dJMGY5U0J3YTZmNGhtR01jc0hYVjRq?=
 =?utf-8?B?djZLYlBpU01wb0VuZHo1UTVQT0JkMXVQVEFtejVUTEZzbGh0YUlNc0ZldFow?=
 =?utf-8?B?OHJLUkU1UlV0T0pRQXJlVlhybk8zSEV0ME1mZWpoakdBMVZMVFpUeVNTT1gy?=
 =?utf-8?B?WWlDN2VxL3NSZm5KbXF6UndXajJnT1phV00vS0taZFpyYVFQc09xZmR2R0lY?=
 =?utf-8?Q?zTJivlLNS9ZZQ75gV9+DPXc=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5518943a-f168-4eda-c60e-08de32792e0a
X-MS-Exchange-CrossTenant-AuthSource: DU4PR04MB12026.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 14:35:17.9665 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GLm4cN063mTGO0T6FgvsfrC+w8a0G9ybwwRtQbly+OJL9CLl+ZplDcVdyqQNsR5aFgBropjm6utmmeEEUxWrHkLNb5fgCuZXE0txByFQSlg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR04MB11677
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

Hi Chukun Pan,

On 12/2/25 11:00 AM, Chukun Pan wrote:
> Python 3.7 and 3.8 lack the files attribute in importlib.resources.
> Use importlib_resources to fix build errors with Python 3.8:
> binman: module 'importlib.resources' has no attribute 'files'
> 

Source: 
https://docs.python.org/3/library/importlib.resources.html#importlib.resources.files

which mentions this is added in version 3.9.

Acked-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
