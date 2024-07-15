Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77F1FC3DA59
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 14:15:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFF1E887F3;
	Mon, 15 Jul 2024 16:15:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="j8LzE8aB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69CF08891C; Mon, 15 Jul 2024 16:15:13 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (unknown
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C0F888889
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 16:15:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LcLPRmAkEZJZ/K3AmhIShruhXRqyV20iRspqnDAMv2tWIFrDd9nLzINtP5Wn2sgl9aT6PS6wFw1WqyaFlIuOs5C/Y5r+KgemByeg2DQ+NFu3tgJSQ3mwDnEyN5yazD2fumi4FNceGDaSg4SeKG0J6Hr5DErdUR8+C6++Ied8NSIQU8j7/qp27Xr4WNIbewYhsXbSLPxcwqZk+3VzP8brBuzzHkxFVTZqNVE1wUglE9GZ1NJ8L8igsEcWs9Z3K3pMlhjmuxBbl11sUkPppm2idXH+k8mXoqmBPSP0C5EQTTU/W3HWpSWQXw7cGYkl8IrYxoOlyLrb05p2EmwU2q6ETQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xs7XQZqHRbtA/8nlceY73OG/oTD9f94DY5BiLDJde5E=;
 b=Kqul8pwtbHBF5Vjlre+Y5p+9v3VlK9WM6sAoVLU4Ns/0NWuqApp3+F5xrobeXCO7NK2yhaI3+MiYC1mh9Kqf3QUJZesUXCydF/5WW0Zo2NRLRRrG15yGGPFS8seLO5dnlFbydh1IHI5Nx1MfjsxUwAMR/EQpDOBD2aA1G2TPQLLby6rGP8dyu2lhgEKHEObsgcp/LRGrKg/48BzY1r4ht3kZ+8ttcR2mkVLd2HfkHhJY3g7Aokvs4qgmztM1Qy363vyJ/yqA8QVJo2Zv/Qd9F/FiHIGum1IT+dAS1xHS0VwCXX7jOvBD+0k4cosqBxZ03AOBgueGCTVmcvypiwKzLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xs7XQZqHRbtA/8nlceY73OG/oTD9f94DY5BiLDJde5E=;
 b=j8LzE8aBWMv0gOKgyShfE7b3nMbbCed+2hWDkIsG1zmh7lTSCgTQtHYuX9bJiIoO1Awvj9/d66Yh0OWGe7iI3wvNDLUxXm/CD50lL5XcYjSCG2JzXvjpC/l1qptYLWqKTZtEtq0FHTfkGFOrJJ/7vOGvro0KgLpTsav2Hv5bvjg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DB8PR04MB6938.eurprd04.prod.outlook.com (2603:10a6:10:117::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 14:15:10 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%4]) with mapi id 15.20.7762.020; Mon, 15 Jul 2024
 14:15:10 +0000
Message-ID: <5696c1fe-e6f5-4f6a-bf74-2006cbf3a155@cherry.de>
Date: Mon, 15 Jul 2024 16:15:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/13] doc: Describe the bootstd settings
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Nam Cao <namcao@linutronix.de>
References: <20240715101354.97895-1-sjg@chromium.org>
 <20240715101354.97895-14-sjg@chromium.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240715101354.97895-14-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0031.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::12) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DB8PR04MB6938:EE_
X-MS-Office365-Filtering-Correlation-Id: fe8e8f9b-3fa2-4692-4b88-08dca4d8890e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z2w3VzhNM1ZxYUFKUHVicy9ndGViaHVHTFdLYlZ0aVVxZlVwWS9xQ0lKSWVo?=
 =?utf-8?B?WXBIM3R6NDFYMXVKaklHL3pja2NmdU5BV3B2WVd2RGpHQTB0ODVmdkVTL1ky?=
 =?utf-8?B?eDZCZE5IQUtHMjVVc0lwQ0dPZzhJajRUbUFpcU5ZMUhlSFlMRE0xL05pQi9C?=
 =?utf-8?B?aElpSExQME16NVBBdjJDc0xVUDN5NUVtNHFkeDVLeHAyZ1ZuTjNrbUhwSWV2?=
 =?utf-8?B?bFRGdStTMm1udWxhejJLb3AxYS8vWTRPOVdrVVpLQU5LZ1ovSXcxZDlHSFdt?=
 =?utf-8?B?Z1VDYWhUNzNpdkxvVUdFRkN5bE16TEgyNWxmVnAxdHl3RUJRejFaajBWZEdE?=
 =?utf-8?B?NFhxUno3T2MyV3F5bndIcEhEMzE2UjZUMXJnK2dUY1kvZ2w2Vnh0NDlvNmlm?=
 =?utf-8?B?YkZWL204VURvWHhaQkNOdUhsS2paQWp5b1pTbnVUbEdCZkdLS1ZMaEVVL2Mz?=
 =?utf-8?B?cEEwYk0zekIwMnNKQVdkdzlTSkdnSWYrQTVUQ2I2NUtHb1hBdWlvVUpNUGg0?=
 =?utf-8?B?NFUybDc0M0NnbHZhVEcvR0xLc09zMFIwSEJRNGtYcUZFWVpxTXZKVTloMi9F?=
 =?utf-8?B?K1hHSm80Nk42b25RbUNINTNqSFJxdVNMZEhHaDVoTWpZT1pkVHJnTUZRSm8y?=
 =?utf-8?B?YUY0aGFCSWR6L3REeDQydnpVaGVZWTY2aE8remFkcmRWU0lnUHZaczNJQnpQ?=
 =?utf-8?B?ckJEMlpSbFN6MG9xV09IR1BXYVdBakN1MjZtY1ZjUGFhWWZnSlVSUkpGMU1G?=
 =?utf-8?B?dEMvdTJtM084VEJmN2t0VUhHVEU0VHZjUDZUYWc0T3RscWFLT0hDRDJPbUha?=
 =?utf-8?B?NGpCaXM4bmxqekJCUGJBS2JYQkxKRDArcnU1ZktSUkJISjMwUlc5OTVtVkwv?=
 =?utf-8?B?UjFSN3YvSDg1UXY2WFNzQjdsVEFWalE5Zld5TGNOYWFQb1VNbVYzM0EzanRY?=
 =?utf-8?B?Y1FVVXRVM0doQ0VHZkNMVVJxT2R4bWt0eWk4Z0lMSG90ck0rWjg4WDVZMUJj?=
 =?utf-8?B?bjJUVVdGdWd3OWtHTDJrNUhQRUluM2ptYkFwOGc2cjJCY0w5SEI2ekE2ckNz?=
 =?utf-8?B?ckV2RnBLWlFWQmVXdGpoZk9XYVpRais1NHZ4V29pZ24yaDN2YmlVMkJUOGpl?=
 =?utf-8?B?R2kvNnZBd2xuaWdTYUxXaHVvRVR3bGxtTW5BUUQ0aVJuam9SVDRWNWE0QTNm?=
 =?utf-8?B?NFJGV0tTNFJkL3J5QytSaEVXMFJsT2wwVkM5S1FuSDVtZkoyVmdjUWUxazNO?=
 =?utf-8?B?ckxTaXNicEJFNFJFZlp1NzFucEdzWlZMRytZV3pYcTBOaldsdWFnbHJ6OWZ3?=
 =?utf-8?B?QlNiNVkwWkorOEl5dHNQWWhQRTB3QzB2WGJiVHU2aFFrU3VUNmI0VjZrWSti?=
 =?utf-8?B?KzBqVEdpL1R1aWc3OFJSZVVMWUtJeXBJOXFQbWlFT1VuNFFKNTBIcFk2bzNl?=
 =?utf-8?B?ZlFCOVN4eE1FcS9nTDdhNGp1bHVzQm1lUGdLKzJ4R2FYTzIrY3hjVHp5a1Ax?=
 =?utf-8?B?RHozQzhwNldiWERISERqdHQybGcwbjJIZjB3eGo1U294bUFQdXV3Q1VjT3Iv?=
 =?utf-8?B?OGI2Q3lKa2dvZlY3QmNjVGEvMy9KZWJqM3gzZ0JORnVja2RCZ3BWQ2J5Nmhm?=
 =?utf-8?B?Z0tjUUVxdEtOQ3pHSk1QMkFiYnZmbXJOV01yYUtvYkhZWDNHNDI0aU94bGox?=
 =?utf-8?B?QThhdjhBcDFDOWVIRUIrWXhvanJjZlF2K0ZHc2gxVmQvSHBDRXdveWZQOXRD?=
 =?utf-8?B?NHlYRisyRGlRSGlXNUlZYXRPb2RsZFUxMC9CcXM4SDJ0RVFSZjRtQ005eEcz?=
 =?utf-8?B?UmN3dFBDMUlNRVJQOGpFQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1p0OS9PdmlxcFcyVnZ5Z1Z5dU1PS1UyQS96citLV3d4VS9xbnFuVEJCKzMy?=
 =?utf-8?B?WUZZSDJxL1FDREg3M3lhZzZKSEFMSDVYS3VXVGFQcTR6NDNDeHJmNDc1emJR?=
 =?utf-8?B?UnowR1YwYWRZc2dKMEJCNlFib3JKYnV2Qnp0bjc2eGUxZEdrMnlpWWU4S0Rv?=
 =?utf-8?B?R1JGU2g0Ymt3R0hYSjFzRkNlWUlSMDFCNm4rUWZRL3hyR0VmUE85RFdSb3Bo?=
 =?utf-8?B?ZnB5TlgwcDJyOHAzSkxVZDltdFlkT1REUGNjaDd5cXdMVE1LaE9udzMvOStM?=
 =?utf-8?B?ek13SHlEQ000VlkrdU9iUTlucTRQNG13U29yOE5NYzk1b21aTnQ3a2ZpUGl6?=
 =?utf-8?B?MHFZbnI2OCtWNG4raWtDaEVBR2YvWU94eVVjNFBQaVU1cXdFMzRhQ3VMV2FF?=
 =?utf-8?B?QkZZZkpwMyt0cTgwTGlBQjIzSWZtL0lSbm5rTnZZOWRkTWRSbGtrU0w3UU1X?=
 =?utf-8?B?Z1JMS3pxM3NIRVJES3dUMFpTU1ZGQ1czaUcyRjZORm4rM1l5eElCbms2UzRX?=
 =?utf-8?B?b0FFSjduMXN5MjJ6OWdwcWhrT2pXV1ZNQ1hoZjdFUUpYaDJiQlJxd0FmeHNY?=
 =?utf-8?B?aTZFclUxK2F2RFhjaURONE9LQjg5VGl6QU9GbWx2S2tKcFpIZm8veGxJTnpE?=
 =?utf-8?B?TGpwb0NHY1BMR280OG1WUjZoYXJ6cGVvVjN6MHptdWhPRXlxZXp5Unh5a3VI?=
 =?utf-8?B?ak45TTNDcGw3SUZQQ1BrRk1ad3ZuejcwdkJjSlBaclFmSEg1RXRzQjF2K1cr?=
 =?utf-8?B?ZThQZG1obE9DUTZRTzRzbGUxT3FNV3FqS2o1Qm9CQ1pESkl1NXNEaGszbFoy?=
 =?utf-8?B?WU9udVRNak1ST2tqNmNaZFV3SEtnMkhRaUY3ZmYxeHNydC9JWDJpUWk1Y0FF?=
 =?utf-8?B?Qk54eS84ekVyOFNmSjlJaGhLY0xHdk1sSElXZTN5alBOUFFscnFZUTN0NXNX?=
 =?utf-8?B?eHpKZlBTOTI3TVJxL2d3QmhNZUpVd0xTdmY2R3lJQnpaaCtNbjZwVnNHMVdE?=
 =?utf-8?B?NGhOSHJCZGNaaWFiN2FoSjJnUXpjN3FZajVlWFhrTC85Lzc2bTlxU2hjTkV2?=
 =?utf-8?B?SnlYVG5ISmlCZFF1RUp6QXd1UlQydndGUThIK0h1ZkVGYlp3R1NkQy92OWtu?=
 =?utf-8?B?NU9iZEYwdXh0ek1ONDNxNzc4ZUZsa25EazBTeEJJK1o3bjhDeTVIWHJTOWJ4?=
 =?utf-8?B?dlE0NGxadkxRQ1RTREI4TlA2ZndiNlR2REpnMXdhb3JKQWU3ZFF5MW9ZdHRJ?=
 =?utf-8?B?N3dBNVFrZ1RhcWVZYmI3WTA2RFhzdW1TZ0duSm8weFBFUmRPc1Yva2JPbFFs?=
 =?utf-8?B?bjJyTnNuNVpTcEdqbDBpaGRpVkdJNkRUUS9QcVlNSUhBd2pWNEpzL1J4U01p?=
 =?utf-8?B?VGxhenljMHdMdFRWUS8yV29qVkM5ckw0dXdadnJrcHg1YVFUa3JzVVlpMEhN?=
 =?utf-8?B?SGVVOExMU1piRmRYc2VjaUZ2UFIwNm5nUGlwKzJZVzlhbEtjMHVCanVkRnI4?=
 =?utf-8?B?SjVFbG0weUt0YXJzNzFGU01RcDNGNXhOZGpWTi9ORjhuNnNMMm1zZW1NTXVG?=
 =?utf-8?B?ckltNUVncW9ZM3FlVnFQeFVXb3hJOWM0Qi9uendubUk0aUI4YXJJZTk4ZFUr?=
 =?utf-8?B?UTc2RXNmY0ZtWGlJUHJXc0oyRnNIckQvdHNKaFpVMzBQOS84SzBXeHdoL0JH?=
 =?utf-8?B?TjJFQlZFSnpoYm9pVzJHRG9jMUFZMVJuZFNsczVNcVNQcEdDSi84V1pCUkJS?=
 =?utf-8?B?SDBnNDJlaW15WEhvRkU4VTNOU3pwcVJrcHNGSDRGNzl3eEgyUTNEeWVXc0ZS?=
 =?utf-8?B?cG1ZKzlQNDN5TXpBdDlRdkhTYkxIaVM5eHNPQ0tnRnM5MEszNmJoc1pYYmZX?=
 =?utf-8?B?Y1dvN1R6cmJhUUtZWjNLbU9aL21GVmk4Tk9GdERYYWJHL2VQV3RyNVR0MHNy?=
 =?utf-8?B?emFGdENnZEFJRUIxRUpWMnd4N2hBRGE4dG1LakRlaWdOZjBSaU1nSVRUVnda?=
 =?utf-8?B?Q01nNERlS29nT0NYZk5lRGlXSm9CckdKalBHay9kd3VLdXJEbTlJZG92SlNP?=
 =?utf-8?B?S3AvU3E1NTRwNzlHd052MzZ1dnlCQXRkM1BDQmZmNDErWFhhTndwK0hYMHF2?=
 =?utf-8?B?dU9vNkRubDVNNUdua25pdkhvK1ZnS2YzRGdEYmVyNnJGVlIzRXRvN3BxRVdy?=
 =?utf-8?B?NFE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: fe8e8f9b-3fa2-4692-4b88-08dca4d8890e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 14:15:10.0763 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rAgrcBV0twnOa3gQWlDCXJhcsez/IYN8OJVCSjITAqD3GRiZB+TEHi1kRWHPSo7YXYl6fS2E4APcyIcTHuTJA8ABv2jRd4boS+CqJXGVMQo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6938
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

Hi Simon,

On 7/15/24 12:13 PM, Simon Glass wrote:
> The bootstd node provides some configuration properties. Add these to
> the documentation.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
