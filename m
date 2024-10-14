Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8933CD18135
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 17:23:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E141F88D51;
	Mon, 14 Oct 2024 19:23:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="ejbYIbjy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0391688F5E; Mon, 14 Oct 2024 19:23:14 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E78F788C63
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 19:23:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PfvelIzwHCwCGlhkJurS3yceS5miFTgTa4MTEInkvAJybIv8bUlRL66Ll/ra75Z4doPVA29b41tLL6NSO6tEeOmEHK27zwzoD2t5fUCKUcyljpp5pRzemvcB+uymSXnCY21gak2MkJFzIs/U1/eqpucEl8gBx5nzwGfbIDrrCaW5XGQBcpjNVTBQBBNAbi2vEJGmWgxyUvj+welJ9NYWJ75oO4NUsymLuIl4rlmJKctzNSz+7QpljmlTfE2N9bd2PLSzh7UsI3IbH+eVs04fC4yX9SX99yXNZXIeAn6myO4tjdPVdfrLODzBIC3AMjQNcm1NzACuE5APJfUuQQdv/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bk0g5pA0vYmVHPxgjeFuL+8q0XUnV0XoqAfMVmkRBM0=;
 b=VrWmVsH7yAqPtN26DKQpZh+prJYVTeCXX86aGnm19M+NKXVbwamilD7qaJZec0t8G5x/YIT/wmU8Rv4Sp1unYzFOwmR9WF+5MCDmvj7v3bdmKsRULDFmYWXlp7gXUVrzuX9hq3QhzMV43gU84vzGPl4bKuHk1T8716RzXAgJpn771Aq2v5OuGX7yIaqTqEIkp3TZZXGmE23Y1/op1XfVFhDq9k/YW9hkGD3+eEPWw/g/sijxiGQnUyHGhyqn36UXXApYC26BwKnpzz77dwpi0ncjOn4cgiyMVO3aav4PKZ7ND5+Lpl0b4RXEq4NpsRT6r8810LaMAc+69iSWPuywTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bk0g5pA0vYmVHPxgjeFuL+8q0XUnV0XoqAfMVmkRBM0=;
 b=ejbYIbjyJ7mTr6YH3fwDm05yq+KJHYSe/Axw10PhN5E4cgeAyhNrxOEdZiJg8UXsmS2SBLCiH9ptT6VnUZMLxDt/hq3gNswbXgeCx3n62OFJ6Wp+Z26lQpC0E6APPnhQsxyVTGW00FSzdRf4rFRPVw8i9FqAKkigSGftCEVgXuI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by GVXPR04MB10945.eurprd04.prod.outlook.com (2603:10a6:150:21e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 17:23:10 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 17:23:10 +0000
Message-ID: <4e3c3044-2601-4093-a422-898b183a173a@cherry.de>
Date: Mon, 14 Oct 2024 19:23:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] boardf: Modify DRAM message
To: Tom Rini <trini@konsulko.com>, Devarsh Thakkar <devarsht@ti.com>
Cc: Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>,
 Simon Glass <sjg@chromium.org>, jonas@kwiboo.se, richard@nod.at,
 raymond.mao@linaro.org, u-kumar1@ti.com, u-boot@lists.denx.de
References: <20241010070909.288313-1-n-francis@ti.com>
 <CAFLszTjJ1GJNd5Fn8U2O5WSnKMn99XW_pGLmejkYy_PBfxSEGg@mail.gmail.com>
 <f194f14a-c7c3-4aed-b4b8-f093f64c7b69@ti.com>
 <31aeb96d-55b1-4587-b212-2632ae4cc124@ti.com>
 <20241014142717.GJ53053@bill-the-cat>
 <eef0f5e5-1a54-015b-259c-c8eea4a54d6a@ti.com>
 <20241014153510.GN53053@bill-the-cat>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20241014153510.GN53053@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0135.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::20) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|GVXPR04MB10945:EE_
X-MS-Office365-Filtering-Correlation-Id: e583e6ad-a52e-4d5f-06b0-08dcec74e025
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VDBYc2gvdTcyYkkvT0JQTnpSRHcrK0hzT3FvaTlTZnJWU0g2UFlTeWlGQzFX?=
 =?utf-8?B?L1l5MlF5dHRGUUVzQ3pBZ0RueGt3UDIxQnRFQUZPSHZTcTRTTE4zQUpaVUxj?=
 =?utf-8?B?MHIvNlJBczk5RW5iMngzS1ROU3JnSk5MbFVKMGw3dlVEbGZVdC9QMmU3OU9C?=
 =?utf-8?B?REtWZ3dQMHhXV3BwQzNUeUtLaWg4VEJlMTVWZU1TTnpWaFRMTjUxaHFSakhZ?=
 =?utf-8?B?bjJwZlVFdmE3b0tQYWt3ejBRT2xycTlnQzNtYkROcEpmOVpGZ21wR211QzZR?=
 =?utf-8?B?SGtOeUh3Nm13Q2xMeUVQOE4rNmtvbmIxTVdwdWRwNG1kNXlmY3ZvLy92Wi9T?=
 =?utf-8?B?aXJqL1I3TklqeTRrbUNWeXhHUGl4R3RaOHFHaC9TR0FMcVZWdTRBZFU4UGd3?=
 =?utf-8?B?UXBDQ2pQRjBFalVXK01DNnBUbUhmRTgzQ3k3TVpLVXJpZHB2dkhxNnJEUmFy?=
 =?utf-8?B?L2xJWU9DakswOXk3ZHZnOHQ3ZVl2RS85M0E1Zmx5cjJTMlhaM2tHRCs2V2FC?=
 =?utf-8?B?R1FMN251aEtZNG9vZmVoR1RKRFJnekhwWStwbFErWEVCY3dER2tkL1N2Tm9t?=
 =?utf-8?B?ZWU4SVJQUXRwYWhqc0RoMk5mMDB4eGUrdFdrem0vUlkrM05mTFNWQ0w1SXE3?=
 =?utf-8?B?MkdSakdQWjVnRG5VcEpuUnJQV2VtVkFsYzFwdE1odFBUZkladjYvb3hYLyt2?=
 =?utf-8?B?TUphcjBIeXk5YWYxYlZ0U0hNNytvdlNCT2tsMGdHekxRNVNLNnQrdE5GRHZy?=
 =?utf-8?B?S3hNRzFMa1czcEcxSVM4RVhmZk5ER05iZ1F2Y1pYampGQ0x5VnBySHRrNnZl?=
 =?utf-8?B?bWdSMGhjNnFscWlHSVRrM3VVVGRsVTk2bXJXcVlLQ1pzSUJnOU85OEJqTzQ0?=
 =?utf-8?B?aHRsY2UwOTlhK3NqQWN1WVAwZzl2RiszV1dNYkY4SVRzOXlLaHRiTHdhOTJ0?=
 =?utf-8?B?OFdCNlcrMEFpeForTTBrUk1NSTM2SEpnd2I3V2YrL1htSUZlbXhkN2VGcUtQ?=
 =?utf-8?B?Ukg4ekNvT2NmZHA3YnU1b1c3Rk1nQU10WHc5WnZ6a1hudXo5R1FaRURpNGxa?=
 =?utf-8?B?MDk1Q2gwZG9Yb0dlTWMvTGhqYVNnZHY1TXBrall4VnhGRnZCNDgvaUFXSjc4?=
 =?utf-8?B?N1VrcGl3dDZnU05Nb0F0RVBEd3J2Qis1cWZLYXp0S0ZQUGVlTWtqSlpUV1Nt?=
 =?utf-8?B?VDB0dk0yZW1tUmlTUUZzeFBwS1cyWDVwMFlGdkw5WUtXQU11b2s5a01tNWpY?=
 =?utf-8?B?eHRJMzJleVd6SFZicURCM2NWY2xVbytudjhRUUx2a2dxV1ZiblcrTFVSamxU?=
 =?utf-8?B?SDhwTHBRaEl4SmFjUTc4YWlSNENNODhJalB0Q1FRMXlkWmVCTE9IazIxeDNn?=
 =?utf-8?B?R204bUM4YkxnTWRpM25kVm53MThrL3ZhT29wS2N0bDNzK0ZKdEZQYjJFRDF4?=
 =?utf-8?B?VjVOU0d4clpwenZET0xxb3RkUUxHRSsydWZQZGZ5RzZreVNiTUxPS2c2Z1pH?=
 =?utf-8?B?Z0xDZE1vdVFjdyszanhwZzJRNTN1SEtYaGtNamlNQ0NLUFRrK3VZUHhvMFhs?=
 =?utf-8?B?emVpM0QzRVA0c3IyeHgzb1lscnQ2OU5HbTEzVTM1N3lrSmpqaUZjZmhzVlUv?=
 =?utf-8?B?OGJCUkJDM3RITit5eWwvSmhwU1BGWFp1OFQ3bURwemZxYzZiMFQwbjZ3KzVW?=
 =?utf-8?B?R0liNUNVL04yQnl3MW9vZ3hnTnlqQlhWRThKRjg2VENJalBMa1hSZm1RPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXk0Z08vUHdBMFZib1Z1YWVPVGZxYkxDOWhtZ09DcmpCeHd4dWF2eVhGV0ha?=
 =?utf-8?B?bVFlTU1sMFZwa0U0MlhiVFY0ZnU1bUFTS1NuZU9FT0QyejUxVm5qb0NHKzUw?=
 =?utf-8?B?OGg5amhWRU4wRHprU1N0SlpZOFFabjBXZWszQm5HcnlURC9oWWxaUDV3Q0JQ?=
 =?utf-8?B?UytkYUp6TWlOSFM3a3pUa2dyaVBOc2kreG5WYTkvU21nTXd2aFFRbDFPZGdC?=
 =?utf-8?B?YWV5VW5rUWNPQ2tnSlR2R0ZYWmVJanJXVmYvcEVtRnplOEtwQzZNcUViZzZM?=
 =?utf-8?B?Ri9Hb3BaSG5uZEsvZXc1V0o4ZGYrQzZWQ0grcENlMHBFTWE4ZEdkOE5OeUE1?=
 =?utf-8?B?YmxaU2VzZVJicno4QXF0SGZMQ3pYaFZtOERLcCt1M1N0OCtOWEtIQ0hIazJi?=
 =?utf-8?B?NEhQc09DeURlcjN4VXBpR0hDU3o4aGdUT2JaQTd0RVg3ZzdSWDFFbzlBeEwr?=
 =?utf-8?B?NjRYcW5ZU3FJdjltMnF6QUROS0FSS0tqN0FEYzhHR2srOTlkZ2VZblVmWDR6?=
 =?utf-8?B?eUl3VzY2K3ltQ0tQSSt1NWNRM09odDlvRmJOWGM4eXloSU9vUHVVVWNDc2pi?=
 =?utf-8?B?RHkyWFBlN2RNVWdnYTBWSVdySVdlb2hKWlpCRGd3SHVhMWx3MGpuM0xDbUpS?=
 =?utf-8?B?RUZCVk9zVHE4aytQa20yRWJNcFBhRElEUjAxcUxzMlk0dXR2aU1EZzVnWGtH?=
 =?utf-8?B?TTk1dTRHVVhBajlzZWUvOHJsYUsyNkZHZnZSSFlrUmdMQjB6Uy80ODFncTQ0?=
 =?utf-8?B?czkwK2RhZ1V3MExCK0NjdGZ6MENza0pSZXdVZjNEWnJIbGJUL1kreUE3Wm1i?=
 =?utf-8?B?dDQ4bjJXMk54bFFTWEJJODZHcnJOa253SGJLWTllemh4bUo5K1VmMmRNYWM3?=
 =?utf-8?B?UEdNdDd2ME5mc1NHQXIxaTl4QTlHQ0QzQzIwOXhzQlY5RUNaUGVlYjZ1Y2tK?=
 =?utf-8?B?SjR6Z1dJajBGbCtmMmFGQVFZTDNBWEpuZlNnNnQxdzF4dUFsSTRuc2lSSnU1?=
 =?utf-8?B?K0pDMUFNblRPMXlWSFBQb0hyM1ZEK1lXcUEvenZHOStNc0JGdmtBbEdia1Vx?=
 =?utf-8?B?dE9tVDR2WDdmZFVOa3RQQVk5eDRJYnZmNy92Q2I4RFZvTzZLWFNhRmRQTHdx?=
 =?utf-8?B?eGdIVU9sY0FhSDk0dEdvcEpqNWxzbkNFa1A0Sml4YTJqSFVXalZ4blFTcVNV?=
 =?utf-8?B?MnNldzN3ZU1qMFZ6cVpsMGY4OG9XRVZadlRFKy9SOXRBdzR3NUc1TE9vczhl?=
 =?utf-8?B?VUZDT1RFWEhrcFZtekxCL2U5NWxLSzB3ZGNsK2FmYUVaWFdCUi9mU05hZkEy?=
 =?utf-8?B?WEsrRlB6L2lHclVVMmNoeTB0K0hLZnk0ZS9nV255WVVEbVYreVNtNjdtWXpM?=
 =?utf-8?B?M0xML2szRFhQWDRUSXppKzlnSkNiTGRaN09xUW1JUmtXeXpISnRWQWpxdTBQ?=
 =?utf-8?B?NWppenlqV1RvV3hZZFFqTTdwM1J4WFNlWU9WTUxONjlHeFRVT1lYY2NOaFZq?=
 =?utf-8?B?M3oxWllwRmZMVzlCbWRVNHdsZFRTUEpzS0dEanUxZ3ZycVJUOFloK0tzQm04?=
 =?utf-8?B?cjkwOEVwblgwZ1dxcFQ4eTFvQkZyNytTaHRDUUdPVmlKdEhSd3JYZ0dEK2RK?=
 =?utf-8?B?SGJjY3FxMnZHZ3hWYnQ4dmlXbEpyOWFJZk1nbVlNaDZTdlBXKzdlU2ZYODFk?=
 =?utf-8?B?YnJjR2hERlBvYnlwSkM4SmJJT3lLNnlMb29QdElwUlRienRsbXF1UDNMVTdL?=
 =?utf-8?B?dmxFdXNFSlBXYjhQN0x6WjIrd05xK0thVHBZblFjaGhDK0xud051M3lWeW1v?=
 =?utf-8?B?a3l0MUw4bDJMZXQ3a1FUZ3ByT1hZTVRxazVLaHE0OGVmS1BITlFHdjhTTHQr?=
 =?utf-8?B?WUk3aGhUWnROd3Q3VFc3R0o4eXdhM2xaZlJZc3lXMHpEbnZWNkVKNG5YMjFP?=
 =?utf-8?B?L2JnMmJ1TnBtamc3OG81djQ2RTRhR3U2NDI0d0M0OEQwYkJDcDVGc3g2UnVU?=
 =?utf-8?B?Y2c1bUljQ0FjL2dOQVNPK2Q4ZVBrblhHSzhkemUzZlIrK0FvV2VabDNzMGF1?=
 =?utf-8?B?cDRyTG85c3QzN1NpZUxGVGRPYWRlTCtuNHpzazQzR0FBOE94djlqQ3BBNW9C?=
 =?utf-8?B?SmlPaEZ2dW1CdklVeURVU3V6NHd1dGc4N3huQ3dXQjhNVjU4MFVtUXRKOW44?=
 =?utf-8?B?ZUE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e583e6ad-a52e-4d5f-06b0-08dcec74e025
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 17:23:10.1705 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0f3gyg5UmwBoFESSQQ9Aw2TLLnpQQeM2DBSSqnx0rfcNZP+h7JqrqDc2WdlzIIITLdl6OXz8IVHw2PuNQtLlSsQzJxFBrYXqZuTIEhXMzNY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10945
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

Hi all,

On 10/14/24 5:35 PM, Tom Rini wrote:
> On Mon, Oct 14, 2024 at 08:59:39PM +0530, Devarsh Thakkar wrote:
>> Hi,
>>
>> On 14/10/24 19:57, Tom Rini wrote:
>>> On Mon, Oct 14, 2024 at 10:10:43AM +0530, Neha Malcom Francis wrote:
>>>> Hi Andrew
>>>>
>>>> On 11/10/24 01:59, Andrew Davis wrote:
>>>>> On 10/10/24 1:50 PM, Simon Glass wrote:
>>>>>> Hi Neha,
>>>>>>
>>>>>> On Thu, 10 Oct 2024 at 01:09, Neha Malcom Francis <n-francis@ti.com> wrote:
>>>>>>>
>>>>>>> The message "DRAM:  2 GiB (effective 32 GiB)" can be a little confusing,
>>>>>>> modify the message to show exactly what is meant:
>>>>>>>
>>>>>>> "DRAM:  2 GiB (available for U-Boot out of total 32 GiB)"
>>>>>>>
>>>>>>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
>>>>>>> ---
>>>>>>>    common/board_f.c | 2 +-
>>>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/common/board_f.c b/common/board_f.c
>>>>>>> index 154675d0e40..b7add8f7d3d 100644
>>>>>>> --- a/common/board_f.c
>>>>>>> +++ b/common/board_f.c
>>>>>>> @@ -254,7 +254,7 @@ static int show_dram_config(void)
>>>>>>>
>>>>>>>           print_size(gd->ram_size, "");
>>>>>>>           if (!sizes_near(gd->ram_size, size)) {
>>>>>>> -               printf(" (effective ");
>>>>>>> +               printf(" (available for U-Boot out of total ");
>>>>>>>                   print_size(size, ")");
>>>>>>>           }
>>>>>>>           board_add_ram_info(0);
>>>>>>> -- 
>>>>>>> 2.34.1
>>>>>>>
>>>>>>
>>>>>> I've forgotten why the first number can be so much lower than the
>>>>>> second. What is causing that?
>>>>>>
>>>>>> This is quite a long string...could we say "(total 32 GiB)" ? Then
>>>>>> perhaps add something to doc/ to talk about the banner that U-Boot
>>>>>> prints?
>>>>>>
>>>>>
>>>>> Why not just only print the total number? The amount available to
>>>>> U-Boot seems like an internal detail, I'd guess most folks just what
>>>>> to see at a glance how much DDR was detected on their system.
>>>>>
>>>>
>> Knowing how much u-boot is using might help someone who is working on some
>> memory map related stuff or if they want to stop at u-boot prompt and tweak
>> environment variables related to memory map (e.g. load address for kernel,
>> dtb, load bitmap to DDR etc). Overall I personally don't see much harm on
>> keeping both the information (DDR available to u-boot and total available
>> DDR). If the word effective is confusing than the print can be made more
>> verbose as being intended in this patch-set or by following the suggestions
>> given by Simon and Udit.
> 
> U-Boot isn't "using" 2GiB however. And in fact the command Simon is
> working on to dump the memory table and what's where, as far as U-Boot
> knows, would be helpful in that case.
> 

"Available" and "Total" would be matching the terms used by "free" in 
Linux for example.

I still think both are valuable pieces of information (what's populated 
and what is usable by U-Boot AFAIR).

Cheers,
Quentin
