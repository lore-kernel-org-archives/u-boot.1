Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 757CBC27C79
	for <u-boot@archiver.kernel.org>; Wed, 19 Jun 2024 15:43:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D35FA83334;
	Wed, 19 Jun 2024 17:43:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="JJFsClQb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31AA486784; Wed, 19 Jun 2024 17:43:35 +0200 (CEST)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04on2071f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2611::71f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5A79831A1
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 17:43:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZGj4rfnnA7JWgGl9LJDi3o0FY3lGQgbYzPN7zDAo+Wm+xGvamXyHpNOwA+/XwZEAK6t+R6AjqVVExXm+lT4txFifJxD5jMS6+q+uXssE/1E9FSK+axqZBpGsdBoTHtd38sKDuk9yVy3GZsB49k8/Lq9dxaWnPSlP4e03YucS4EhM2+QEPqXCLwRENozCKZdgU7ddIw0HeMSITCVtJ0DdiNvbYVrYuVL/w+3xYFdFcxDWy94pFCyja33eVC69oCiBYRTlBAE0aqaLUOPXJ5vkwSsFc3OClsUyChSboJjzHsflcKVY3moTfwNwoK+mcb9Y7YL18OTd9jmtes8gBGX+lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BvJoGabUUOeK34vSP3jYtzfQ+kuD6pu4ML/FOIDZI54=;
 b=IgN5Kmme/9qT4UXC9+R5dYiN8RMhOaOO2VzLkL9tUaaF17fPYuFwynq3GkQPDoHklkHeJk5uuZ91QMREMAkg7EonQebPyPETeyiU/Ulluo73ALMeSJkodbH4AjKonNxr8gGXlAi8+LDI+hCYzHtfIWSCnmaKuYg65cSKk5iLRKZhAXnynezdtUN7eyyagfHHMX3tfKrRfzzQwQq1uaJPF0TV5HEa+FYdR7/ODa+ElPbu0/jQXI92lu8j9SEuc4brEFpFqoRN2Q8yZAvAdFwI3cEdOf0sZZPrp4ISS5FfXO0dKEmlhXEvO9XW5bAX9ZGTCG5dZ81Zj+bVE5UhaRD76g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BvJoGabUUOeK34vSP3jYtzfQ+kuD6pu4ML/FOIDZI54=;
 b=JJFsClQbqED8/SL3burLT+L/oDzqXqO4urm5Lif5SkHzB1mYczl71q/xCG8MdbivlWwXdwlfeKoN45rjfQo2Umomw17EhICcddINa9PD205J+udfYhJkjxKGnuMc2sg00XQR7TDL3qwOER9vklePlADRfWpa8tSCAcTlfAC2/Jk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by AS8PR04MB8692.eurprd04.prod.outlook.com (2603:10a6:20b:42b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Wed, 19 Jun
 2024 15:43:30 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7677.030; Wed, 19 Jun 2024
 15:43:30 +0000
Message-ID: <47cc860d-46c7-4258-b1fa-307c2ba1f54e@cherry.de>
Date: Wed, 19 Jun 2024 17:43:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: puma-rk3399: increase Ethernet PHY timeout to
 30s
To: Tom Rini <trini@konsulko.com>, Quentin Schulz <foss+uboot@0leil.net>
Cc: Klaus Goger <klaus.goger@cherry.de>, u-boot@lists.denx.de,
 Michal Simek <michal.simek@amd.com>
References: <20240619-puma-eth-timeout-v1-1-db5c17153f82@cherry.de>
 <20240619152208.GC68077@bill-the-cat>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240619152208.GC68077@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0010.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::16) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|AS8PR04MB8692:EE_
X-MS-Office365-Filtering-Correlation-Id: ef5774d9-b2a4-4b1f-db6c-08dc907691a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|366013|1800799021;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dVFnUlFHbkpER0pBVWdNa2paalNkdnVtTmNySUxpUnI0Yk5yaHQ3Qkc4Mmhs?=
 =?utf-8?B?djVaYithREZBbHdRdnF5N3FxY3NWUElOczRKN3hYL01NOTJyZ1d6UHQ1dGJH?=
 =?utf-8?B?ZGNPNFJMYVEzejlOT2VHUUdHcC8xV2E1NUVYa0dyQlllQ2MwcCswZVdUOG51?=
 =?utf-8?B?OGdWcENyK2djeThSc0dTZmxlRlU2dW1VZTF1Z1dyeWZ0YThwS2N2aU13VzZj?=
 =?utf-8?B?aEVUV2svOTJvS04vSVVhamVnM1ZWNGxRTkErdmJ4dDNNRFRjSkpvaVliMXdV?=
 =?utf-8?B?U1ZzM3BDcys4MGdsR1FXYW0xSGw1WkpObXl0STNjLzNlMnVhVGpvMWlGeitz?=
 =?utf-8?B?c2JMWTBxWmtKUncyZitwYXlwekkvWm9jbU5jN1NqUFBYSXErdnVwNktkdW5z?=
 =?utf-8?B?UllxZ0l3bzVidThwNEZNTVVjM2ZzSVArWnpDVGQzaGpzK0hUSmlKSW4rR0o5?=
 =?utf-8?B?OGRac2g1VWJBUjFKQ2ZPcFo1Y2l3eXU2TFpZaDFrMHBwZmFXN2N2cFYwbDNm?=
 =?utf-8?B?TkhPeXpud05EWTNFZTRSWkJtNWtTaWxrL0xSQUpwMmxUTFZrTVJhT2ZtUVpQ?=
 =?utf-8?B?ZmwwQ3BlQjF6Qm5mdnJ1VnF5dWlWYkp2cXdWcWh4TWxFcGNkeTRnQllhNHhh?=
 =?utf-8?B?ZFpOQmpaSzFjY2UzeVNvakI4L2J5aDZ5cDFlR1J4eU1wVjNkQytreCtnamlX?=
 =?utf-8?B?ZmlxaHY5YlJ2TENQUXhWZlA1aWZVRFRTb0daWWtEdFAxeTloYUtXUFl5aGQ2?=
 =?utf-8?B?TjZJc1crMmUvTlJSSVpuNjgzUEVUNEE5STJJRjErTVFPSktNK21WR2RaQ3pp?=
 =?utf-8?B?dG5mMk95NUlkT05mMCt0TE1oTDdRUUN2Z0VHaUtSaEV4N0NDRXN5MCs1OWhF?=
 =?utf-8?B?QnFBeFNWUFRUZWJ4Q3ExTE91TGp2N2hSQjhhOFBFNlBQL2lwRDZzTXY5aFQw?=
 =?utf-8?B?U25UY25MYzB2OG9sM0lBazlucnNtSGZma3k2b2QwQ1ZnbFYrR0NkK3UvV1g3?=
 =?utf-8?B?cHdhZkJIVmVDdWRMakRXcHVSMVgzWDExOWtmcUpDdk02clRzTnZRY2VNbUNP?=
 =?utf-8?B?c1lIV0hHa3dxNmtjK1BtUCtoYU4vZng1dEYwMkJDN21hd1dUNlRURjNNeTQw?=
 =?utf-8?B?SWhHVk9EaXpiSDBFS3FsMDVmMXJrVi9SZWxZemFsbnlwL056K1d1KzRub1Yw?=
 =?utf-8?B?S3d3TnFCa2txdG1kSjcrWkZxMUJVeU1kOXFZLzJNeU5zT04vNDh4OUJiNTZQ?=
 =?utf-8?B?UUJvajBYdzdJSkFmd3FiUHkvMWs3ckRsUFJwOENmS1k5VzVucGJ3a1lVQ3pk?=
 =?utf-8?B?YmFJaVpYNG1BR01pa1lGbVFKa096MjY0QXE3UUNpekt6WkJIM2gwNGpFaFg2?=
 =?utf-8?B?aGhmQThTR0pzVFF0MGNmZldZZmdGeG0wMGpjdGxkbUE2VlU1ZDVBZkhoeXVq?=
 =?utf-8?B?c3c1VXltUURkNC9GNUNlTVRHNUhqbkNnaFZXaVRkdkNkSUIzTXE5azZaamxP?=
 =?utf-8?B?emtCaTBPc3Y2dDc4STR1bnh3ZVdnazl0ZzErY0xObERFbW5SM0hUM2J4cWFH?=
 =?utf-8?B?UElQcC9hdnFmT2ZOeWhFNk5vNFd0T3djY3pxdHkzL3hmSWV5TFdXMk9ZVXcy?=
 =?utf-8?B?RDdRL1JkaUlvdUg4WHVvSEM0bHM4T0JwQlFYcEY5QVZBUG03UUNwOVNqWGNS?=
 =?utf-8?Q?n40R57YTct78b5UK5fx1?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7982.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(376011)(366013)(1800799021); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHF5dDhtQzNsY3lWSDF1OGpYYlY5Q1BRSkVyTzZlai80d2lVQnRJVHp2OWxD?=
 =?utf-8?B?NzdVQ08rK254K0JjL2l6M1lMcjlTM1duZmhLaWlpQVBwaDVGaVkyZGpSTnZJ?=
 =?utf-8?B?UjVzVEtYSEZwRXVMaHpqalBPekh1eS9rMlJLS0RJc3BSb21VcUl3UGVVdzdm?=
 =?utf-8?B?OU96cC8xZlNvcVZKQ09McFhOeTdnVy9xcmVkbzBjcDF3eitxWjVRU1NONmov?=
 =?utf-8?B?TmN4MjZSNmRMS1pURFU4MUYxaHNWeTZtNGh1N0lwOE9YMVpGdHYzSnpzRFY2?=
 =?utf-8?B?Ym1mTGNXV0xZQzJnT1ZVd2w5Yk1SQzZGOUIwajBzQVRmT2drMEo0MFBRWGky?=
 =?utf-8?B?VnM3cnNmNHJ0aDB1L1lNZ09KOUYwZzFONERGazc2QVFKdzZuTEY2T0FHY1pC?=
 =?utf-8?B?dGh1ZEgxaDVuN2xBUThoZGc2byswYXdONXgyeThUT1dRcHhhblE5VXlSd0Uz?=
 =?utf-8?B?NWlSQVVOVXUwUi9hKzJHUFUrRVJqSU16TVRjQjdna1ByYkkxaWZDNHlkS0Vi?=
 =?utf-8?B?Q21idGt0MGVna096cmtMNFpULzdyNUZWOVRSK01XaXVKbHo1OWlDZkI0cGp3?=
 =?utf-8?B?THhPdlVGVW1STzRlTHZ2Sjl0enFRd2ExNW1nRkpnNlcvTUs3Tkk1NWwrOUxI?=
 =?utf-8?B?TWJpbUErd2V2dXBhSzdkbzlkcWV2Z0x3OStGOE5UV3F6eVV4Mm9rSVlUQUg2?=
 =?utf-8?B?R3cwUjYrVWN3aW5YYmVHYXJhTy94Zi9NaFlJYW5LNnhBRWFVb2VnbThLZTg0?=
 =?utf-8?B?TDAraFViK0RFUVZXc2kvSW54TlJLbXM2alloY2dva2s4OUJiemR4TzFoL0Y2?=
 =?utf-8?B?MzBuVVlUZEtHdGR1YnJqQVhkeWZrMi9XM2ZwaEFUVTA1MnQ3dFpScVk1cDVp?=
 =?utf-8?B?QjhINS8vTCtKbUw2d2puMC9mOHlDU2lyNW1nV3JkWFJWVEZXREx2dHJDWGdw?=
 =?utf-8?B?RnUwR2NsNmV2WXo0V2M3SDFzd2JNMjc3dnYyUVpIaXNCZDMrLzZiSWFwa1RH?=
 =?utf-8?B?RHBwaVBTTEVDMVIySzQ2U3R0WldQSlNDWlJ5WVZacFhrdmdIaTJVMm5FV0hx?=
 =?utf-8?B?b2o2MmkwWktKTFJuejBCb0ozUi8zUjJxUWNlNVZteVdxVFcvUElwY1UvZ3A0?=
 =?utf-8?B?USsveFRMLzJSMGp4SFpCUlNNREpIaUZkbENTUHhFWHovMi85ZDFMdXR4VWZR?=
 =?utf-8?B?TEx4clhyeUlGcGV6cjB5ZGc2U0szME5IVko5RXZGV0J2VHl1L2xUZlg1Zkxm?=
 =?utf-8?B?TW9sOVl2YVF3WWRGZERhTlVVMWd5Zi9OMDhMMDVrVHdqVEhoQTNRUng4MU8z?=
 =?utf-8?B?amlRQ1BVanBEeHkzTWxwSTh3bk9LMUovcHVxV3M4NDZCWVBDd3dHcGNDTEVh?=
 =?utf-8?B?bWdydUVsbDBLeHBrS2NOYU5wbXloWU01cG1wanRJRXgxY2ZKakRIcTVxeksy?=
 =?utf-8?B?WFllNitFZ09NeXRYcVgyNDdrRStLMnRjUWdKN3FrSWhPc2JwNHpicVFnbHA4?=
 =?utf-8?B?YmJITzFoUlJORSttMUpWTkpzVloxNGZqK3FqMmE4dU0rZlhJVXczWGJBWUJM?=
 =?utf-8?B?QjhiMENIdmRxTkVBMFE4VWxHVmpyd3VzT1IwSWVjckRETUw4STNzQXZtY0tD?=
 =?utf-8?B?eW0yU01KNFRxaHkyNkcva0xkZStyWW9LTndLdHI3dnVHei9vMXFzOWMxYWQ1?=
 =?utf-8?B?eWtLSDhBVkkwSldVaTl3ZU9MbWtZYnp2L0VjRERxTTR0d3huUGhaNFhIVjdk?=
 =?utf-8?B?RFZPR0lsWXBmdGQwY1N5SHExMVBtenlySEpHMG9nR1Y1WVgwMWNmUGpReFZ2?=
 =?utf-8?B?eERiWTBaOFdmd2xXM1YrWFFqTUFmbmt5emZBemhHQmxjNlhGYlNZdzFzS1ly?=
 =?utf-8?B?ZEdBaHFNL083UkRnNUovUWtJblNCZzJrbFVsVHc4MGk3dmRmZzVUU0xWRFIv?=
 =?utf-8?B?SDVlVmo2NldNL2lORXZVeVRxY1JCM2hJcE1GSnRsZ1Zycy90WnZEWS9SM29V?=
 =?utf-8?B?NG05czNPNlhyTDFLaTY1djN4ZVY1QnU0Nk9Zc05TaHNXcWlZVG5XM3VOTTZq?=
 =?utf-8?B?KzBlOWhvYkxhVUVwdlNLaS9kS09sSWg2aCt1T3hGcjQ4YnV4REwvRFl6ckEv?=
 =?utf-8?B?ZFBSZlBzTzdqdFFheWwwaFhHZmMrYktHZjNSQXFVWTN6ZXRJa3p3RC9ZWCts?=
 =?utf-8?Q?pg0OET+r7eCAgtP2QQpElYU=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ef5774d9-b2a4-4b1f-db6c-08dc907691a9
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 15:43:30.5279 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 925MZ+3gPnqI4FxYHO2B+0x7SsRCgGUPHGKhT+6zOSr1+6rODpkfQH2n4j3NhjhGlfmBZE0jbrkh8Y6hAsVWD9/0kP9YbmevJydKocEapIA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8692
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

Hi Tom,

On 6/19/24 5:22 PM, Tom Rini wrote:
> On Wed, Jun 19, 2024 at 11:55:52AM +0200, Quentin Schulz wrote:
> 
>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>
>> On Puma v2.1 with a KSZ9031, the Ethernet PHY often doesn't detect the
>> link in the 4-second default timeout.
>>
>> After some boot-loop test for about a thousand boots, 70% were below
>> 10s, 90% below 15s and 100% below 30s. Let's play it safe and make it
>> 30s so that hopefully all links that should be detected are.
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>> ---
>>   include/configs/puma_rk3399.h | 3 +++
>>   1 file changed, 3 insertions(+)
> 
> Please rebase on -next where this is now in Kconfig.
> 

It's technically a bug fix, but well... we've had it forever so one more 
release is probably not gonna hurt us :) Thanks for the heads up.

BTW, I believe 
https://source.denx.de/u-boot/u-boot/-/commit/40f5046c221a7b2719c49b51acefe12914b213e5?page=2 
made it through this net and should be migrated to defconfig as well in 
next? SO adding Michal in Cc here to trigger something if required :)

Cheers,
Quentin
