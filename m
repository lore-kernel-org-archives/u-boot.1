Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11DD9CA0ED3
	for <u-boot@archiver.kernel.org>; Mon,  2 Sep 2024 10:31:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88BD388785;
	Mon,  2 Sep 2024 12:30:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="jD2PQlXr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D4FE88906; Mon,  2 Sep 2024 12:30:58 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::61d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E998A886E5
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 12:30:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FFyrY/AER8/4jAg8X8pV+znHjt9PTsgmZrVW2yPtZ1eoM39gOkC00eoGjKw6FFccxMh67W2pb+NQkNZvszwSOZLBShA+B69kRYtUpbpwUbk8Mek/0jFsodpbQBRxW1OVAWdq3AH698IvFXG/F2gNUDmcTdsZ9m1H0JOWT2dhrGyGpfanYO0wsx6VSe0ZhKKKpRTlzNaKmqWv8nUC/Th0KZyyPPkdfS1L9MtrKxJfAOPHfM5XVNUpHbG42CqPu/QtzgoM206W0KI7Bourk1yPFEhb56DeqlSLjrKgyK76LAifvh0ErQIZuazYErfRiBK6Rtzho1cE+13N0QOMrMQv6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fa95/HEdtwZ5wRzFsrLID8x+Pm3GPe+ajmDLhTGucrE=;
 b=rMEae01WI8IAazIoBm35GF0HoFMeRZqO6UkTu4CToQGDXU0/KVg/z0nE64gPRBOxv/GBNDI0uAq89yLgnEexgPdHn5vKBRcLsLqbxPS3fccKMoI/948Qc4D1sP4UZV5n00ZrJ6J3nt0dulUXmbB2oaP41JDr/S1/94V6IOLM26NvJr9BR4rhsnUU3YGkK3uSv9AmCW3u0/qekF24eQTYNKNSpv6c4rbgfeFf6YMET7asfB5WSN83ks7tTob4EDVM7T1rMgUfV8Njg8cSPluPffmyRv7g1g1+WyacK/WZxxL2ZgrKT5P+tVeLBC/889Fot4/GzsM9Mmadz0u0aMo0pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fa95/HEdtwZ5wRzFsrLID8x+Pm3GPe+ajmDLhTGucrE=;
 b=jD2PQlXr5KCY+70RB75hWf7Y/Xm70PRJlK0svXtkCjt/0qaJGSfWapM+RPBJzFzeJNlosP/FtYyxOBtJ9XqA6+a84wE4D9QUBc10tX67PTxLshZDILWpcv2m24V2p9cNo93VegN43tw3RGa64b0NuQUGMw1LChgsFCimHGbVhL0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DB9PR04MB9915.eurprd04.prod.outlook.com (2603:10a6:10:4ec::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Mon, 2 Sep
 2024 10:30:53 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.7918.024; Mon, 2 Sep 2024
 10:30:53 +0000
Message-ID: <f8357ca4-e23f-4748-969c-f07f5776feb5@cherry.de>
Date: Mon, 2 Sep 2024 12:30:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd: mmc: Allow using partition name in mmc erase command
To: Tomas Paukrt <tomaspaukrt@email.cz>, u-boot@lists.denx.de
Cc: trini@konsulko.com
References: <2p9.Zbg}.7NiPNKVgoiP.1cr7Cm@seznam.cz>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <2p9.Zbg}.7NiPNKVgoiP.1cr7Cm@seznam.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0168.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:66::16) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DB9PR04MB9915:EE_
X-MS-Office365-Filtering-Correlation-Id: 191781ce-8429-4d87-8436-08dccb3a5246
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dmtRQnp3eEtWOTJrZ3JaVnAwR042dURnSkIwSzVPN3FXcHZlc1VJZXpWVE5p?=
 =?utf-8?B?M01wVEgxcExHQnNzdnJucUhhNDdWS2hOZWJzNGJwMmxMREtYR3gwMk03L2NP?=
 =?utf-8?B?bGlLMGpqZm95ZkFrZVI3TkpITDVkdE9VdUpPVlU2MXhhWHRBS2FQMGE0dFJO?=
 =?utf-8?B?ZDFyQVU4aEJJYWQxdXM4K3BCRDhOREV6QVhzSlB3cHJHMlFPNjdoT0l1Ukc2?=
 =?utf-8?B?S0N3bFd4ek53dWhGaitoS2lUbzFpV2swUkVmbUVSU3hMRWRuZERVR211QnQz?=
 =?utf-8?B?bGpPVWl4TzNaeHBWMmQzVkUwTGtHN05JNVM1Y1hoRFNXdy9TUHdTeW9kMzQv?=
 =?utf-8?B?TkJhZEx2M0tzTUs3R1V0QjZONUVsK0FxaTk1N0wzMGMrVFFzV0RsVCtoOG5Q?=
 =?utf-8?B?UFpMRW9aYUlPbjRTUWpXdUJGaUxkWGQzZ1FoUjE4bUM3ZUMyVGFQNy9Ebmts?=
 =?utf-8?B?RDZSRjRPMzBPUEh0bFVidHFHR2RVZC9LcDZaajd1UGtjRzJWZE9SZEFraVk0?=
 =?utf-8?B?aW1sT0JoSGFya3orTFU0bjRBRlVOVEVoZ05VbmpCR2RnbkFzVUVNUWIvaXVs?=
 =?utf-8?B?Sm13UFZTbVMxMEFCRnQrQTdiNXkvTlczaHlqL1ppZGlnVTk2S3VvZ1F6azRw?=
 =?utf-8?B?aU5VWC9UN2pvYit2MjI3VDJEN2tpT2FWK3lMZHJxYlN6dCtxbnA3TWJPWEUz?=
 =?utf-8?B?WXFSOEtEcllyREw2RERhTmtyMXNGYVVFYlhKRlF2UGtwWW1GVk40Sk4rU2JM?=
 =?utf-8?B?dzUzMENwZjUyM3ZqNnBuaWhrSi81NSs1aEF6c0FtWng2bUNVcThtd2VkeGI5?=
 =?utf-8?B?aTBsSXJJQWR3WnVXZWZEM21FYzFOLzVYY2pwV3lYakdOb1pqenRRc1hvS2x2?=
 =?utf-8?B?QW16Uit5cmxIOEdYTTFCZVYyUnRqVHRuNUsyWDZyQjYvTmtsOUVjc3cxTlEx?=
 =?utf-8?B?OUdZVDFOTHQxNGUwajVNMVhYR3JBbHYyVmxvVUdhVDJ4ei9PSGdYcmZWK2li?=
 =?utf-8?B?VGtGOHJpK2RiL2x2b3daOFM1V1RNUmdlZ01oWGcvUUF5OFVMOWxoMXo0TU4v?=
 =?utf-8?B?bFhhUkNRd0Q0czlVaTFmT1dCZWtoWnJ4VjI2c2F6QWIrOVFTNHhWd1c1eEtn?=
 =?utf-8?B?ajBYam42TWdFbnVFdzV6MkRleURCNUgzQ0pVTFNtQmxNSVNVZTlIeEVjNDFK?=
 =?utf-8?B?MldZZHdUTjFlY3M5QzBldDhIVTJ2Y3VKeG5jd1ZZN28raG5rM2VBbDgvdSs4?=
 =?utf-8?B?OWlqRFo3aEZIODhYVGV4V0pLZ1pvWEVxMTdmc3N0TUVpenlmYnRRZURlaTBR?=
 =?utf-8?B?dXpLenBJNUZmam9SQ040Y2JwcC9FK0labTZBSWNzQmlHS3BldFdLeHRYbnQx?=
 =?utf-8?B?djE4bWRaUTU2dXRySGRES09oYkpPeXhZcFZoWmQ2aFBwWkx5Y2lGdWRqTlFp?=
 =?utf-8?B?eFJ1Sk5vZllwc2pUTHh6SFNjc3k3cHJNbDJmQzc3bTlDWEhwRnhvQkUzeHlT?=
 =?utf-8?B?Y0ZVZnJjeFBqUHZ3M1BmYmVmWWhMNkg1a1ZQMXJPVGZhbzBjd2VTWFM1ZUlp?=
 =?utf-8?B?NWpLKzQ4a3ZsTWZ1dVUxSkVDN0NRdVQ1VmUvK2JJbDBvckhlNjFNalFMcUtY?=
 =?utf-8?B?ZVZHYTZxekdqeUJlbkwvVVpLM3MvUmNOa1F3TVMzYU5DVzI2TkJFdFppUDJ5?=
 =?utf-8?B?VDdEb1MxQ05DcUx3ZnF4ZzFDTy9CUHFOcVl3c2dLbHVxZEhKcDRNN3dCdjIy?=
 =?utf-8?B?eTVBS0RmMWFqMkREcmlXWlc3UDlOQ1kyNDJUblJpdGswY3FzeVpvc0UyTDFp?=
 =?utf-8?B?VTQwNjU1L3hpTmdkWk9FZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXR2TXlrNEdCZXYxRnc1ZzJMNVNHeUU0WS91RmFSWnFwTVFRaW1hNVlwM0hL?=
 =?utf-8?B?a1l1U2gwWWVXTHpPM2pZSEhvOUo0Qk9oUGhPNGIvcnNVUng4SjJTSGFCZEtN?=
 =?utf-8?B?SW5KL0k3VnFYZGZWNytqK04rTGZqaTFyMWhGMkFweXA4dkRpRndSRGhqSFcy?=
 =?utf-8?B?TmVZdml4ejZrMlJGTXVtUDBsOGFBbGFzMXRwazF1S1lIa2hIcXU4SzFOVFhx?=
 =?utf-8?B?MDJxcnNDR3M4aGthNkpKK2d2Z25FNzVsYXB4cFcvSllpTWozV1NoTG5uVWkx?=
 =?utf-8?B?bjE5K29VRzFHSkZybGwvSno4alFVdHhiS1kzdEh5RGY3VGhaOVZnVjZuQlZN?=
 =?utf-8?B?VGFzTkhTYUV1NUZpa2Z4TnpodUdPN1YzMHlvanZDUm42Q25LbjBrM0w4enMv?=
 =?utf-8?B?S1YyYzFmTTJUdU5yaE02b2FkU2VBTmY1VEtIQ2YwSGFUeE9nekc1NXovcU5H?=
 =?utf-8?B?WE5tZ0FKNUtXMDVzNTgwbWJyMEJOeVBuclIrbXlJYkhITlhWVlZKaFMzSG9Y?=
 =?utf-8?B?YnNFalN5RFJTVlQ3UEIyUEFPb3UvZ0NaU1JiampwWmZQZ05LSmJCQ281b3h1?=
 =?utf-8?B?Y2VtOFRPNEthUzhicDN4MUdwSUp6NEdlMlBQR1AxTk9PdFZQbkF2QU50ejMr?=
 =?utf-8?B?VmdIY3paeGlEd2dxdVVaaEd1cVMvUzRrTnR1czlMTGREOW5IOGNzUHMwdytF?=
 =?utf-8?B?Sy8zY0lGUW1FSXMwV3pyNFpWcmZteVdERjlzanNxUkNFS3poYUhXalA4ZU5o?=
 =?utf-8?B?MlRBenhZZmphbHlFMGxmRWJJb1drZFNnTnBPYWU4dER4S2crbHQ3WnhWbitD?=
 =?utf-8?B?RGVSZlYyWmxMa3lNSzI0ZHlYeHkxbkIxck9ONlNlZG9iNDB5QldyUWwxV2Jv?=
 =?utf-8?B?SlRuMkJ3ZlNuK3JPZXowdGZFb0VtcU1ubkE5Sy9tbnNYUUllUytkbGhncEZF?=
 =?utf-8?B?REY1WEtvNlJWQnRoQTdaRjdOZnVxTi9MdHgwSGtKRENuemd3UWpiRko4UERs?=
 =?utf-8?B?WEczQ3hyQmwxY0ZmK29MMW00VjZOdTY0YXRQRDBFcVR4aDdkenRJTGZVUW5i?=
 =?utf-8?B?NWVsb3U1VUEzY1Z2K1pRNjlxLzVXczVQOXphVW1uelkwMHNnZEtySEZqRUg4?=
 =?utf-8?B?dkMrUXlzQVg4NDdXbUh0d0Yrc0tETmlheGozYTdtbVF5a1BLYVE5NWpwT3dS?=
 =?utf-8?B?NkZmMDFFSnpaYkE2WnNaUncrZVJRL0JtcjZCTG5jVCtNMW1sZFVwa0Y5bVQ4?=
 =?utf-8?B?cCthSEJwbkFIdzJaRWdIcTVsUjNDNmQ4Mzc3NFdnUHJGRUpWcWI3cGk0byt6?=
 =?utf-8?B?cFdyNUF5aFM5WGZyL3h5VjZPaFowN3VjQUExdnphZFpIMExYVUxwL0NlZXdI?=
 =?utf-8?B?QmlDT3dQTVJWMlZxS3JpR3p2K2VMcEpGQXVWMEYreUM4WEtGM29aMWo4UU1C?=
 =?utf-8?B?Q0Q1WTloT1h5b2lJZVJGdmp3dGJCOU5VQjhEY1dPeXN2cDdqTGp4RHV3ajRN?=
 =?utf-8?B?Z2Q3OFBtc3dLTUdzdlpnS3N3Z0sxUVdvTFY5YkphYVYrUmIreDdTZDVTdy9i?=
 =?utf-8?B?UE5kWHNVYjFTT0lRdTF3ZDdaajB2ci9kc0pZNlJCRk1GdmpMMG40VHlMTG1Z?=
 =?utf-8?B?dW5KeFpBT2xRdG1MTEExaDdCMXFHTHlPK2ZrYW5IRXBjOVNaQVJnWk9yVWNI?=
 =?utf-8?B?T3BHcHppNkwrc3NsRjZqR2ZEMGhYZU5jUG9iSjBwbjBQTTNUZU9GTHZZK1ly?=
 =?utf-8?B?OEFWaGl4YVZLaWluQndudXlvMWFyWENGdlhMU0wzSE1pN2dWNFdjVmhzOWxD?=
 =?utf-8?B?Y0hXQjYyZFdUbGZsa3NTczYrUlIrVXBHMTQ4dGFEUlFnQmppOExPT1llNExF?=
 =?utf-8?B?TTZsTWpvQndXTkN5Z1VJem8rK2RLVGVFcThwUkpocFRhUnFTdWJ1a0lHVEdI?=
 =?utf-8?B?SThVN1J2ZmtDTDVkODNWa1F5cDBaTkZ0ays0QzI1RGFRNmREZ1VOcUordC9I?=
 =?utf-8?B?Q0VFZjJ2czhhc2F2VlNJTlZzdlo4UzVQbUtjck81aVB0REtNL1lULzd5SFFa?=
 =?utf-8?B?aHB5YThjV1lMY0U3aS8xZFpaM1NaeFpKaWtXYTQ2aTRuNHlZZnRBSkRoNm9u?=
 =?utf-8?B?LytyU0dlam9oR0duWThoY3hza1QyOWtNb2R2TTdzVTBJWmhEOEdNWFBSZ2Zt?=
 =?utf-8?B?eGc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 191781ce-8429-4d87-8436-08dccb3a5246
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 10:30:52.9877 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6/HAfNAjdFUTbA9ClRuoInbCJJ+SFjI869+EWM09dKrQv2CHdjrXGGKebJPY/N+O8G53x704qhvdZNmxqLw0E2hPH/2Il1SQgO8L5EtQdiQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9915
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

Hi Tomas,

On 9/1/24 3:59 PM, Tomas Paukrt wrote:
> The mmc erase command currently requires blk# and cnt parameters
> which can be obtained using the part command if the entire partition
> needs to be deleted.
> 
> Simplify the use of the mmc erase command by allowing the partition
> name to be specified directly.
> 
> Signed-off-by: Tomas Paukrt <tomaspaukrt@email.cz>
> ---
>   cmd/mmc.c             | 21 ++++++++++++++-------
>   doc/usage/cmd/mmc.rst |  4 +++-
>   2 files changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/cmd/mmc.c b/cmd/mmc.c
> index 7244a90..ba2f506 100644
> --- a/cmd/mmc.c
> +++ b/cmd/mmc.c
> @@ -472,18 +472,25 @@ static int do_mmc_erase(struct cmd_tbl *cmdtp, int flag,
>   			int argc, char *const argv[])
>   {
>   	struct mmc *mmc;
> +	struct disk_partition info;
>   	u32 blk, cnt, n;
>   
> -	if (argc != 3)
> -		return CMD_RET_USAGE;
> -
> -	blk = hextoul(argv[1], NULL);
> -	cnt = hextoul(argv[2], NULL);
> -
>   	mmc = init_mmc_device(curr_device, false);
>   	if (!mmc)
>   		return CMD_RET_FAILURE;
>   

I assume we do not want to to init the mmc device if we know the command 
is wrong (based on the number of arguments)?

So keep the first if condition, but check also if it's different from 2 ?

> +	if (argc == 2) {
> +		if (part_get_info_by_name(mmc_get_blk_desc(mmc), argv[1], &info) < 0)
> +			return CMD_RET_FAILURE;
> +		blk = info.start;
> +		cnt = info.size & ~(mmc->erase_grp_size - 1);

Is this basically a way to round down info.size to a multiple of 
erase_grp_size? If I read that correctly, please add a comment to make 
this explicit.

I'm not too familiar with MMC, but do all MMCs have the same block size 
by standard? I know it's 512B for eMMC, but don't know for other MMCs. 
The same question for the disk partition? The fact that there's a 
blksize member in struct disk_partition seems to indicate the opposite.

I'm wondering if we shouldn't be using mmc_berase() instead?

> +	} else if (argc == 3) {
> +		blk = hextoul(argv[1], NULL);
> +		cnt = hextoul(argv[2], NULL);
> +	} else {
> +		return CMD_RET_USAGE;
> +	}
> +
>   	printf("\nMMC erase: dev # %d, block # %d, count %d ... ",
>   	       curr_device, blk, cnt);
>   
> @@ -1270,7 +1277,7 @@ U_BOOT_CMD(
>   #if CONFIG_IS_ENABLED(CMD_MMC_SWRITE)
>   	"mmc swrite addr blk#\n"
>   #endif
> -	"mmc erase blk# cnt\n"
> +	"mmc erase blk# cnt | partname\n"

It's not entirely clear to me if "partname" replaces "blk# cnt" or just 
"cnt" by just reading this line.

Maybe have another line:

mmc erase partname

or is there a better way to show this I don't know about?

Cheers,
Quentin
