Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 401F5C36002
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 15:26:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88515836EE;
	Wed,  9 Apr 2025 17:26:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="oGlz0uP6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 605AB83886; Wed,  9 Apr 2025 17:26:30 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3D4581FAB
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 17:26:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AfqI1Je/VK2VoJyezF2lIBeSCtTKpq0XJ4MxDLRl4jmRkmiGetwq23WrPKd0tXNNKEYX97yaY1mBtdOlEtRRQEo7mNz0ujAeBB6SAVxrwANeI/Jt5DdRpscrCtfIioU/+gMUherWMwSGaApY7O7jXQSUn27uLQox5b3y3HaslzgXmsUBCd9sZnzO6tYc7JCR10EquP8+Kz0wI6hkrau3TaQfvA8b6Z4kNx4OCoHUuEwEARbHNwhYEzGTohOGkQc2Q5GyJAd8+q0+D3O0YGs8ScXJG2ArX2wqQQ7pk5MuDdatfAUKkdPiGQgKz53+q+zkurMlYGX8emZbm02vWxTrJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gWzLzuFHJxBe70jxXIqBBlGVfD03Ic9IKvC+bHTf7VE=;
 b=GzkXTvyGLPJ0RoButZ6mRgBc5LbfAD3fX5ZofEE9nZM6FguJ7Up4FTKpS00uclGBkREE/Sgn3WlFFR3HHWD0TKLm5INguGfBeizVx2Fyd5/pcmMdEPgd5m/+b7xzx2zh3En3vzsFo2TEWyeM3Z1hP0NW02Mt2a2QzEpqDSvo4hZDtMacVQSdpfsMLwhrNe2gF5DOfI3TzGWISXGNhU9nGe49aSzVym/xj7NkZIYb6Vk8FF0xHRP9JAe6H3STAd6uTLngcqsaeTZgEQsZ78D5L2bd7BQxo4Rs7oGl7Drc68ehoy/3tnU5imIQlq8Gu5QCzqhio02+PJCDGpokv+k+lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gWzLzuFHJxBe70jxXIqBBlGVfD03Ic9IKvC+bHTf7VE=;
 b=oGlz0uP62umIVu3bYdKe9egUBdIp7aN4tHhUheq87xCp0+4Qt8naabPx/RGXtvjO/k1DAKeWQ5WApnfOW75wU6EISwtERV9AN61dRTysoIlnyYdm+J69hS/mxPtwvd6LtIq4v4uRoeCihBG3u70ywiXtUVBvkrz8VGjYT6j4eKM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM8PR04MB7442.eurprd04.prod.outlook.com (2603:10a6:20b:1d8::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.35; Wed, 9 Apr
 2025 15:26:24 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8606.033; Wed, 9 Apr 2025
 15:26:24 +0000
Message-ID: <1fd723f6-5031-4951-80ff-b5d66ae0fdcd@cherry.de>
Date: Wed, 9 Apr 2025 17:26:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/10] rockchip: binman: Include a compatible string in
 each configuration
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>
Cc: Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
References: <20250329150626.2879942-1-jonas@kwiboo.se>
 <20250329150626.2879942-8-jonas@kwiboo.se>
 <6b940128-c5aa-4499-b62b-1a63613d91e7@cherry.de>
 <6fe987ef-39cb-45ce-8c84-bd74a5e3e48c@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <6fe987ef-39cb-45ce-8c84-bd74a5e3e48c@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: FR2P281CA0093.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::18) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM8PR04MB7442:EE_
X-MS-Office365-Filtering-Correlation-Id: 679ecae4-3535-4ad0-411d-08dd777ae394
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eTFaK1RmMDh3SzN3UHZ4bmU3VjF2VjRyTHJraktWeVBhSjMxbXUrOGxRaXFX?=
 =?utf-8?B?cERQZFdPMVF6cXVmTHpQd2srRk1CcndJeXB5ZG1FeldkMkdTQ0lpazVTZWIr?=
 =?utf-8?B?ajVQWHBTeU1nWUdmTFFpWEZKVUd5d1ZhWGpWTWVwVlJiVWNqZjdPYzdYMGtR?=
 =?utf-8?B?WW9TWkU1S3JVQlNoM2tWbmQ0bG5wVFRXU1RxK0hBdmVwV3pKM2xHYldXK21p?=
 =?utf-8?B?enFBMmY3QXU3cWN6MmdYOUVzY1RSbXRibU9EbkFUS040VFBCYnRDMndQTGdp?=
 =?utf-8?B?VnVtMWQvR1ZIcXZjUHQ4U3c2aFFLYkdCRVNMZE0rU0JxRlkvSXZybnNidEJ4?=
 =?utf-8?B?ak5ZeFFqamtHWThsNktkRy94Ym9CbzQyQ0kycjg3Tm1GZ2lhUzc2UjEzZVVZ?=
 =?utf-8?B?a0cvOWowYWROTjQ3V0lmL0phYWR0QXRKRnVQNjF3ZTVUSytGNTBxeVRCaEQw?=
 =?utf-8?B?dDNoKy95OWFqbk9hS1ozUkRjaW9HdW9MS0JOVHV1aTJMYWJSSmRFdE5hTDVJ?=
 =?utf-8?B?RDV0RnpWd0R4N29ndVFLS1dzLzdaRzdIbmtSME5qRHZLYjBwNGVyMzF1K25E?=
 =?utf-8?B?UU1IWTFoTkpraTJsVlFvNEJJeC9JbmJwTkZRWFdsRFpZUTc3QjY5YVkxY0p1?=
 =?utf-8?B?YTJiRTNhRFB6WEg5V0Q5QnQwaUdVZUFsUGg5SVUzS3Q4UzgwR0dBcm5YcUdI?=
 =?utf-8?B?ektSaG5uQTRrVW5Cc2JkaTAzSjBLT0cwSUljQ1BtNmpwczBWRGNIaXBROFNG?=
 =?utf-8?B?NGtkZjFlZHdtNllocGpZNjNEelNnS0NySmE0YnJYa2NwSEhuSHRCNVFGWWdW?=
 =?utf-8?B?dnNYVW9ZSU8xRytmaE9IWmR6M25pcEJmTVFFVEhWZDhqUkdYSXMxZzVqZ21J?=
 =?utf-8?B?amI4NXN5Q0RFbThndXRtU3pmTG41dXlGZGdWdTNVbGZ0SmNkR2dsQWUvdkgv?=
 =?utf-8?B?VHJiL21XWFI3bXBQTm5IQTJLMW9weWJGbG5taU14K0NvT1J2a0FkSjdtZmNM?=
 =?utf-8?B?QXFNNm1CTXh3aS9LUVUwcS81MmFnbGhYM011N2pJakFjbFQzcC9rV0M2VDJo?=
 =?utf-8?B?WnZmckdWNUdRbjdUVklGN2hYUS9VcE9kS3g5Wm5zQmVSMDdUbWo5U1FVbUdi?=
 =?utf-8?B?OGs2NzMvc3dZU3lDMTZzRVFIeGIzYTR1WGQ4U2ZoMzM1WDMzQUtWaHdFUjR1?=
 =?utf-8?B?emJwUnJYZmVKYllFa29lN3dIQ0p6YzdDbDNiQ282UmNPcExpNTlSL2RZSExU?=
 =?utf-8?B?SExtMVQwT3JXcXJmeUhDbWdWWWgxU2EwVjFjTmg3RmNxMGV4eHBRL0F1TSsv?=
 =?utf-8?B?VThPRDZGL2Q1UFFIT3hMbDgyOTJlS2t3VlZxTm40dXlpVllZU0xydkoycGFY?=
 =?utf-8?B?ZHJLcmZCSk1zWXlmSTNZWGduMjZidCtNNnc2T01XZ3g5ZTF2Qzlzb2VZbE9C?=
 =?utf-8?B?bThPMGY3QW1rVm5BdjBEalpPUENTVmJYSU5Wb3NjdlhPaGFpVnI3bFkyd3Bp?=
 =?utf-8?B?bi9ONHgzMlllNEZEVjF0OFFFOE1IekxxUWlVUUhyODFrV08vMnRPclF3N1Zs?=
 =?utf-8?B?TmhuSUs2NVE1MTNPQjZPVmI5RXlVM002L0VWN0svanRYV2VHRFlxR1NLUFFi?=
 =?utf-8?B?YUFkek9MdWhCcVNnWUpCUk5oankxb3RBMTkva1E3MFpYMkZHd2p6bDhpMnB2?=
 =?utf-8?B?SStjRlRqS1g2UGJzVmZBN01xb1hyQisvVVgxdVBTRTlCRU5LQWdNN0Y2Y3VX?=
 =?utf-8?B?ZDJtRUV3ZUJYVjJFcEF5aFEyTm1LVmZMdXo2eVEyOGphbzl3Zk9vditFY0hk?=
 =?utf-8?Q?XyzIrekfWNgjzjt+3LM/m07cN7uTP8O31DAkI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0tnTmRucTBSVCtmQ2dvUjhXRzllTERMQlBlQUdGOGdld2xqTWNKRktiRXNV?=
 =?utf-8?B?cm10dm9wR1FlQmhJdTJxQ05YS0NOUmpHVE1XZWpKZU5LeEhFTGw5M1BXblpa?=
 =?utf-8?B?cFVHQmtMVmt5Y3FBVDdkN1UwMFlqNkhQMlNJUGVBaFl3SURtYlBBUmFrTGlJ?=
 =?utf-8?B?eW1jM3pHNEx0VFd0TzYxZEthWG8rYnpvTnltaWg4TExwTXlhS2xIMk1TeHp3?=
 =?utf-8?B?SzNYY1FSbG4vSFM0dnVYeFNKalF1cUdaSWxraTczbVlSdXZUeXFiZjNhVTFP?=
 =?utf-8?B?d0s0bzVkRGY5NEVJUCtnQjZaQ1FBeXFpTnk0MFRoR0JZQUpVYjNZMERlZWVS?=
 =?utf-8?B?R3ZLdElQdkY0akFyZzZ5SUdqTEQyQzJDQ0VoUDBibzlDTjQ3eENyOWtQeWFC?=
 =?utf-8?B?dC9GOVM2Wk9VTEYySXc3d1k1ZUU2cmhGZUV2TTNXSGQ5S1BIUEpzRWhsZkZx?=
 =?utf-8?B?STQzb29lT2lQakptKy8yRkxUT2o2ZXVvd1ZIUTFjYXFXMHVFalZSNDJHY2dB?=
 =?utf-8?B?cHRYSjI0SWxDRHFFaG5aS0N1aFhDRTdmbFZsZzJEeW5MaGdrTExxdFlHLzRl?=
 =?utf-8?B?MmtDLzBhck5nZUJPTGdTblZqTWpBQzRuVk1vdGdMOVU3M0ZXYVhOV05MRWZr?=
 =?utf-8?B?c3RCUkV2T080eThnYVNQV0Myd0Jybjk3OGJjWTFOUnBPSE9xZFpxbEw5aDJw?=
 =?utf-8?B?eDlUR3NQYXZLbUVzOTBOYXBnMXVFS09lT3E2b3Y4QmVpV2p0UWtNRStjYks2?=
 =?utf-8?B?OWhwd2pFdXdtY3RxQUloSFZZVlBsUy9pZ29iUlo4TGRHMXp1YVMrSmxRbFhR?=
 =?utf-8?B?OTNnemM2aFo0THlHeDduZmh2M2tCTkRXM2l4K1krUFZlVnVoTXhCRGRQTnYy?=
 =?utf-8?B?L1NvK1Rja3RjdEtUSTg2NWd2T2FaTjN4QTVMVUdkUTJxUU5jL2N4a2dzRGNB?=
 =?utf-8?B?STdENmc5bGJtenVlNEg0d013NDhXc2syRndNUkNzZHhGb0tsWXV2bmkzN3Qw?=
 =?utf-8?B?Wm51bjgrU2pPKzN0djA0a1B1bnhMeFJlYUVQaUZGVGhkY0pVc0ovNnRYTnJx?=
 =?utf-8?B?Znh6aXRmQm5KQjNPWmR6MVNtNE1ucnR4ZXlHLzNnMC9DbHBGaFc1MTFEWFVw?=
 =?utf-8?B?L2ZrMGlnWWZJNWdKMXhPUmpzOFpoOXRBZXgwWmhZRjd2QW9nNHZwb2c3cEJx?=
 =?utf-8?B?bW1BQi9YMG9KOEJNalhES3IxbGFNUXpzbjE3OHB6aWptM3FKRFdsOXJHa0xJ?=
 =?utf-8?B?U3NPNCtCaGdSdFZYYVVqNXRWRHRZRjVaVUduRnl2TkJHU3FLdnZlTWE2ejdh?=
 =?utf-8?B?ajh3OUJ1QWkxaSt3ZER2ajFGZzRpcFpvR3BOcEZ6Q3JreUxUVTRBVWpic1hj?=
 =?utf-8?B?RjYwY3RMMERrd3EyUU9PNS9HVkQrWW11Q1pHOTNTWkJ1YzFGL2gzT1F4NmRM?=
 =?utf-8?B?c0pYS0pKYnZ5ZWtmWXIxbzd5K1JUSWRrVStJRVlVcmUzL0hlVnR2eGdzeVdR?=
 =?utf-8?B?TDBPaGtHajE4K0FpNk5vYVU5N1RtZVZwMUtreUM3T0pBSXh1K0g4L2xyVGdD?=
 =?utf-8?B?Y3c5MFh4TnlBdnhPcGhvWks1NU9hdFd1aHFCNHNsVTVCcWxqS1JzcjgzR3NT?=
 =?utf-8?B?NGNVQW8wSkpZS2lyZjl2RzM4L2d6RGdFSnVQRGtRVmdVQVlISU5uR0tadXNl?=
 =?utf-8?B?QzNZeStpTWxMQUd6VDcvdVNmZ1J1T05abGhxUWYrT3NsTTU4anh0MXlvSzJF?=
 =?utf-8?B?dW45TTlJK2IycEd4d01SZ3R5TTlINXVjQkZOVEk4NUk0cU92WE42ZkQ2SkNK?=
 =?utf-8?B?dUFySGtoN2thdGE3bVNYazZQclZQTzRuTDlOV3c5ajB0eUZORWgyK1Z3QWJo?=
 =?utf-8?B?SlZkVzh0MzZIei9nWkt4QjEreGF1R3dsenJIeWtmZ3VRTDhRWnJJaWQyRWp5?=
 =?utf-8?B?SXlsaElXUlBjNDFkbFRsclR2NEZVeVMxN1NGQ253a1BXTml3STM4dy9kV2t5?=
 =?utf-8?B?VXJKWnF4Y1F0MzNlUWZmY3VYbkcrWERpQ0ZvN2NKaE1ldFk2MWVSQ2pzK0NK?=
 =?utf-8?B?SXoyamFUaHJBK2pCa0FkdmNPYXFGZ3JJNVFINGJ5YktsUkNqMXk3djloMzlh?=
 =?utf-8?B?cnF2RGVTYnJZbEVPNzhoRGErQmRuNVRrN250MWU5cm42Vzhvd2VjUWxxWWwy?=
 =?utf-8?B?bkE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 679ecae4-3535-4ad0-411d-08dd777ae394
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 15:26:24.5526 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LJXIou+2Jzfrk4jbhfdb/s/qvFf2RZvicdAlrtEohrcS+Y0vqFvOS8gXBdsRdqE7+udr56tgPmtF8waVaWL1qXCqdavesnWp3i9JYYBddC0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7442
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

Hi Jonas, Simon,

On 4/9/25 5:05 PM, Jonas Karlman wrote:
> Hi Quentin,
> 
> On 2025-04-09 12:02, Quentin Schulz wrote:
>> Hi Jonas, Simon,
>>
>> On 3/29/25 4:06 PM, Jonas Karlman wrote:
>>> From: Simon Glass <sjg@chromium.org>
>>>
>>> Provide a compatible string in the config nodes that U-Boot can use to
>>> help decide which configuration to use.
>>>
>>
>> Can you tell us more about this?
> 
> I think the VBE can use this to determine what config/fdt would be used
> in a multi-dtb FIT image.
> 
> This also sparked an idea to use this compatible for board selection in SPL
> instead of the description (fdtfile) field. I have started to play around
> with a board_fit_config_compatible_match() a few patches in at [1], e.g.:
> 
> - WIP: boot: fit: add board_fit_config_compatible_match()
> - WIP: rockchip: implement fit config compatible match for boards
> 
> [1] https://source.denx.de/u-boot/contributors/kwiboo/u-boot/-/commits/for-next
> 
> That could also be used for having board specific TPL+SPL and use a
> single multi-dtb FIT with U-Boot proper and multiple fdt/config nodes,
> one for each board.
> 
>>
>> I don't think mkimage -l/dumpimage -l actually provide that information
>> and the docs are sparse as to what "so that things work correctly with
>> FIT's configuration-matching algortihm." means.
>>
>> Looking a bit into tools/binman/ftest.py it seems like it's a way to
>> expose the DT compatible property from within the first entry in `fdt`
>> array property (a DTB) into the configuration node in the fit image.
>>

Seems like it's a bit more involved than that, c.f. 
https://fitspec.osfw.foundation/#select-a-configuration-to-boot

Thanks both of you for the pointers.

>> I think it'd make sense to update dumpimage/mkimage/etc... to dump that
>> information as well?
> 
> I think so too, I know there are a few load/entry addresses for some
> image type that is also not shown by dumpimage. This is something that
> can be improved in a different series.
> 

I've sent something for this compatible conf node property: 
https://lore.kernel.org/u-boot/20250409-fit-compat-v1-0-56df89ef486a@cherry.de/T/#t

But indeed, seems like we're missing printing the "script" property and 
many others related to signing for example. There's also a few image 
properties that are only printed based on the type, e.g. "Architecture" 
only for kernel, standalone, ramdisk, firmware and fdt types, "OS" onylk 
for kernel, ramdisk and firmware. Not sure what the reasoning is.

Cheers,
Quentin
