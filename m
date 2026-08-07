Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B849C5AC7A
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 14:09:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8429360A78;
	Fri,  7 Aug 2026 14:09:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vYwszgU_J6Mo; Fri,  7 Aug 2026 14:09:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B3FE460A44
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786111758;
	bh=AfmOdSjr2wHfWxOXnSp10FlTWGudyqPFk7XTbvq/gFs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SnVFqbg16EqG++qmmdMRbr1H/YKGKk07kuAjSrITSOMCUBmZF6Ss+K7WOsM4cSezs
	 qjYTLa5IzLIHByoQA2suZQ5usIbHcOwPYPElebpJVaAMpE1gGsyWhIDspocmRA8HvL
	 jU2GAgqwpSWQneQsCUyohSp/xojplhdajIC/Q6N+9N1E0rWQ1oEAY7RKg1RP8OI/rY
	 +xdWEspWvF0ALTYHDCkUzstQt8aC8E3GuuefApTToGusFFkUIDFF87wa8sZQ/PvsNt
	 JqrKT3sNqapPOjgRUQQTLYVugJJXUL8CtaU4BGRHzxScxkQR9wsCXK54JhTZtcPNBX
	 A9PUksEk/qpDA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B3FE460A44;
	Fri,  7 Aug 2026 14:09:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id E28AC198
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 14:09:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C90EB60A71
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 14:09:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2nrXd9-eJEvB for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 14:09:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org ECE2F60A44
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org ECE2F60A44
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id ECE2F60A44
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 14:09:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fm0pXbZl8o3VTQssnqBqZgounTbBebflTrUBOZjbEYIkKP31Xl+UhYqu7RnkgBjZPRz93boaVq1C30LlEPji4ai4kfBsGCWHdp4VDDOnjZq7MxEuLNPOdIjMQRCXx5gay8pAc90uri1DJ/jjDfVuJUf5ucEk7dTvOM/JOMo5E069/PDP93QkLvtUexlaHGMoLwuUfDX4z6DbcvHM1QX9h13S30EdbF6zZzxQs/aVQ/gyLGgBy38T5cAC5QND1T21xF3dD3Nj1YIIDMEmGSK3yyHoHKGFipT3+Njwc36eylgd0QF6cy8lxrQZkD8sEQ+IXEdzlyWnohILBW4/WIhUNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AfmOdSjr2wHfWxOXnSp10FlTWGudyqPFk7XTbvq/gFs=;
 b=HIMGGw9a8kwP21J6TsqkyJmSwN0cvHfTFEUZMA9jpfNDvSgMngsI7azX2Kjt7/gt0V37NYXyNMgBaFhDBcnEVguqaBjr9g+yHOC6LC+F0cpxEazTbNEkNSHuI/+KsiQkCXVsh3jfelzyLZuTI2RhWWRwEdFKvR2eIsy0pkXAMEj6Eh8IYBhYD21fXA0ga967OCqF21Ztyvh0CbjW9rJJxJp7CGDjMnuPEmXC3bYdm1T3TMMwWMpgkhMtRilKNxOXRPGJCqc/r67c1etIa8SSslWxAb4a8EHkoT65fraiQAA8NAlU0L5rb8oakyJDMqYQsuIUOzPiDAIttD3n0wHSVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com (2603:10a6:102:b8::20)
 by ZR6PR04MB721958.eurprd04.prod.outlook.com (2603:10a6:910:e0::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 14:09:10 +0000
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7]) by PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7%6]) with mapi id 15.21.0292.019; Fri, 7 Aug 2026
 14:09:10 +0000
Message-ID: <e2f32f58-3b20-40d2-8c8f-77ab68e90f76@cherry.de>
Date: Fri, 7 Aug 2026 16:09:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/15] clk: rockchip: pll: Use PLL_FIXED_MODE flag on
 rk3588/rk3576 plls
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Lukasz Majewski <lukma@denx.de>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org
References: <20260730141308.1218014-1-jonas@kwiboo.se>
 <20260730141308.1218014-5-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260730141308.1218014-5-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIUP296CA0037.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:34d::11) To PA4PR04MB7743.eurprd04.prod.outlook.com
 (2603:10a6:102:b8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7743:EE_|ZR6PR04MB721958:EE_
X-MS-Office365-Filtering-Correlation-Id: 30fd6733-db64-468b-0433-08def48d739d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|10070799003|23010399003|376014|11063799006|4143699003|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: p8iqs6/XV/2ZiZgGbjpCS58+UQFWfZ34VlFK58MF8f+Zw40KBysOWCJT+yAz0mHcOGGzTomlZz/Q+ELtPfHuBYbV5yZSLOfT6s+jFz4yxVwMUCC546xbT85P0udDZ3N8HHJRKV45tdKlMg3CJ4mV1KHUbl5cTEsMSnyT4DgMp9HQk14rO7tFyLV+1Go4zYAHv25ETixJv7QUmpkbSmvzKBvlY8oJAYCRdnZQMaS5NS7k2VqnlS9Rqi81KvPYwRh38kqAl2E3f5zTqgNyaW0ikzkNIrAEI/Y1sMGkBBTyZFP4ZcsLMXVjHuvAy3bvTiy6v/8EdUsXSafXzHvWFYitExtYgLJq61/W/05m24PxRLADzwhXJ3zPz38E4/xm8vPfBADX0YAu/1fsFpwjwdQZD5CB+WhhQ3mTk4igYpPKupYkoqYqe9o4KO3qmuTaiToQE7JTyto8yEiHwplZCVGdHKJgbpwSiPGAIB1k077a03Q12y13BpIa2vVD7NwVROCdIuLy3u1XK9x5utsNLNd5AJANQnKAkm7WYL8+VwhWeFDOSk3HQVLjfF/htuqcCPCdmM2U48gd7eIzjghlYdstTGI8KS+idwwMD005sxcx7cYv5OYLLC8nyGAVdtU2nQpDy0dXAMRXpTX/d+hAayJ/ljmTKIVlVeasyCmBJl1EAS8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7743.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(10070799003)(23010399003)(376014)(11063799006)(4143699003)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEFXbWF1ZU9hMDdWVm1GTXFDQTFOKzM1TGhOaFNKQzFpVk5MZUE4dDJhd3NW?=
 =?utf-8?B?T2FSL2NBd3M3QktSZVJBejJLNktoa2VvZWd1M3pWd284V01adG9zSVBVRTJ2?=
 =?utf-8?B?OXpsZ1VneUFRNFYrcEtycnJWRUhHdytBbG1lTW11dHRwTUVpWDAzeXdHMWpQ?=
 =?utf-8?B?eFduMjFUUHZMelh0RnhOSXo5ZHBkVXVvKzRacEFwTEF0Z3VTNnZ2Mm0xZEpB?=
 =?utf-8?B?eEpRMndJUWZxdWxMM252dnZza2dKR3dxUGlsVEFHNXFsTW9PMm5ONis3eDdG?=
 =?utf-8?B?djlZKzNPSWU4U3FWVVVEVGZibHNuN3FSeHNqS2ljU01nbWVja1VpQTZmM2p0?=
 =?utf-8?B?NnZxVHJCemhlZk9xVVhJanlOT2EyQk0wS1BvSnB0akRkZUFnMkNvbDdKTm1u?=
 =?utf-8?B?dk1rWjkwSHRBUkJGL2kyd1U2UVlIMkxYK1lZQ29WMy8wMmxkYzduTU9NbXM3?=
 =?utf-8?B?eU51MzZaZlllcmxaZGlMVi9PalRLcmw4b0gzRWN2dy9DQno4NUZmRms2MkJh?=
 =?utf-8?B?NHhxaTB4ODhLRWZxWWNFYlRMNXRXTHJob2FmY1E4b1hOMGFoeXJOQkdGbU01?=
 =?utf-8?B?QURLZ2JYQWZLSisyWjltRk80b09FQTlhUTlKYlJ5bDJoSnRmU1pRUFJtT3RU?=
 =?utf-8?B?UXo4Mnh6UTNJVWdVTzQyQ0FBc2xvSnNDTVVHWWZMWWZiVEx2MjBBUERDZ0x6?=
 =?utf-8?B?WkJKaFpMQ3lYdWZZR2JTZ0grYWEzTDJ1Wll3Uk1pQ3pJbHpOR3YzZmk3WlA5?=
 =?utf-8?B?UWxjTDZ3L09GQzV4YlVHb2lST1NPNk5oVENDdVFBTlFxWmJ2NENWVjlQVnNT?=
 =?utf-8?B?ZEVsVGtPcHJtZ0tXK1Q0TzB2bVV5S2p5U25JTHNNcXJzcVJvRmRGb3dna3VC?=
 =?utf-8?B?a1dubUVhc3dxMU9acm1MeS9TMjNEbmlSaTA0bDd4ZS9LQ1pjUW05SnZud2lI?=
 =?utf-8?B?YWhGNmtKSHo1ZkV6QXQ2Y3RWb2dWSXIzeE5JeEk0Q2Eva1pVaHhZTDcrdjZO?=
 =?utf-8?B?aGlCbFVXdDBFSnM2VUZ6dXNITEVncVViOTdOcUNhcFpJNys1YWRKbzZ1bUpQ?=
 =?utf-8?B?R3NoM2x6dktZS285RjlJaHRkVC9VcU16WU9oUFFMZXRtY0I2SWJUaEllU1Fq?=
 =?utf-8?B?ZXRUOFlMZldHTU5taDhuRWV5MHRpTnM1L2xqUzNoeUlqMXpTVklhMmg3YmZm?=
 =?utf-8?B?UmNLZEppSVdnVUZwU0czbHNodWRtUkFMUWttNE0wdkp2YWR2WTJMMERhSk5a?=
 =?utf-8?B?U3JwdmxTaStOQjJHOVZodUVFZ25GTWFwVERwYUk2aFNMbUhMdDJlLytrTEtR?=
 =?utf-8?B?a2NVWkdnU0F0ZnF5Vy9WZTZsREN1MVZqWEI3VTZ5eHMzUk52emd0eHNKZ2Zv?=
 =?utf-8?B?NWpOdWI5clZjRW5zNHF6Rnc4bFdobnpZYWllYUllbG1obmUxZitkcUdrR1Fs?=
 =?utf-8?B?VkpZaG96RmdCRmNIWWRCbmpTempWUzFQbDM0VGNUZXVWbnFxUHMrazd4VThK?=
 =?utf-8?B?WTViSy9JQVRnQ1RVK2tkRm5pNXBrTG1zdlpuaGxLN0lzN2ZyOUdpWThyK1J5?=
 =?utf-8?B?dEpMendsUEhwYzFhbjFpNGlUL0FwWHFacGV5K1N2alVLdTRqSWlPbVU4aE43?=
 =?utf-8?B?eGlJUFJVVVU2RndNYlN5VjB6L3lSN1NFa0lvZDZ2cEc4QzRSTnJrNUNER0dM?=
 =?utf-8?B?ZXRwS3FXQXZrMERmelUzWmYwYnFnNXBaUkROZDh6ZjBNNll3cStNT0NQM3ph?=
 =?utf-8?B?RHk4THNubURXdThtZG1TYk5RUUFSNDhVY1MwbGVGU2tSbFo1Wm1CVFBSREZp?=
 =?utf-8?B?bTl2SlVJd09nQWpPWk9JWlVJV3ZHcjNQVFRJNTkyZm1FVGc2UDRKdmV2Tjdq?=
 =?utf-8?B?ODRVMHF1VnlJMi9FdXo4azZWMWVSdUNOSWhkUC9KUGFhdDR4dkF5SzhEa0Rp?=
 =?utf-8?B?REVaaytKa3BRekN2YWhhT1JpTm4yRDQ4d0JIM3dDeVljZW1BR0JpRmJYbGlt?=
 =?utf-8?B?bkl0MVRVQjAvZGRsYWhBUE1EQzhWc3JZdGJIZUlaS2RRSzFLZmFveVpPUGcv?=
 =?utf-8?B?aU90a0phbFpwby9IeWNTVlRoRXNaMEk2R2hiVDViL1cxT3hrK252K25wYVEz?=
 =?utf-8?B?ZURVZ0t5SVV0NEFVcnAvOGhvMFArOStjSGxibnV2YytKZ0ErRGgzWk1qVU82?=
 =?utf-8?B?bHI3ejQyd0pYTzlyVSt0cnRScE1jdTd6YmxYQWEvM0VWQlc0c3lGNkdyUDZV?=
 =?utf-8?B?bXVlUGpaejZyWmV1VVh5MEZTNDgyQ2FjUUFCUldkd3FiZ1A4WTR0NUNJaUpw?=
 =?utf-8?B?OWxXQzdiQ2dZL202SkRyRGN3blR0RlVZUXcxY0ZYMzF1eDVMdzJZTCtHTGND?=
 =?utf-8?Q?EJDeq+5gcRP4LOZhBiUnh2E4LLb6+zyE3/slk77xDhrj8?=
X-MS-Exchange-AntiSpam-MessageData-1: dm0fOATAPQbJnQ==
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 30fd6733-db64-468b-0433-08def48d739d
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7743.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 14:09:10.1913 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wdio3gBqBrOESrRoD/g49tyZ+KQmRYIopFIE7Qo556pzFYcDidVQoTGCBnS9xycxtW5r/sl0lCau/owlWH48bnlmDiiNTDsQZ1pfSpx2AbU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR6PR04MB721958
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AfmOdSjr2wHfWxOXnSp10FlTWGudyqPFk7XTbvq/gFs=;
 b=PolJtMNy6pioadQ+PreL8Uh4PzzQct8fgfYlbwR+WnQje4fGtjpiz4KkzcJpIRqyu16NjFxHBHcjpNboYj3l2VfZYkQ0R2ZtNoCrhjFINe4eIzQERHT0REEARAfr5MrQavolUiV9/ZOra8Rs6rDi49CN7MRI9gMevxHJAZiGvxw=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=PolJtMNy
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Jonas,

On 7/30/26 4:12 PM, Jonas Karlman wrote:
> The PPLL of RK3588 and RK3576 does not have a pll mode reg to switch
> between slow, deep slow or normal mode.
> 
> Extend support for use of the PLL_FIXED_MODE flag to the rk3588_pll type
> and update the PPLL to use this flag to signal that it does not need to
> switch to slow mode before the rate is changed.
> 

At a glance, it seems the Linux kernel is doing something different. 
Instead, it checks whether the current mode is normal (0x1) if not, then 
it sets it to slow while changing the rate (and then revert back to 
normal mode). I'm assuming they rely on undocumented registers (the PLL 
that don't have a slow mode for example) returning zeroes (i.e., slow 
mode) so they don't do this dance for when slow mode (or undocumented 
registers) is set. Did you send patches to the Linux kernel for this, 
are you planning to maybe?

This change here seems fine to me but we continue diverging from design 
decisions made in the Linux kernel (which aren't necessarily correct). 
Anyway:

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
