Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62B9ACCFA04
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 09:58:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B85D3836D1;
	Mon,  3 Nov 2025 10:58:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="H9mlqu1R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1ED4C838AE; Mon,  3 Nov 2025 10:58:09 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B037C83642
 for <u-boot@lists.denx.de>; Mon,  3 Nov 2025 10:58:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n+tmDyILi6MjS78WMCr0nwE9yDCLHVJEKoaPt3gt4aynnGQeDSn11xYTXGwkNiT7Kp81lk53ITX2bgQsb2uadV/A85vniknrKKBRzCHMAQoFb8zC7saLW98G8KVRCZ6zbooxqHuAhgKT/eGlbBaugqXnDNriwda/OXWpDnAL7bESFK1flRr2X4mYpeJNcG2yHQlPl5JvSk9c4noqApzdETdgWBy3bBwaXh0QbPFvOkp7GaiNgV4wDLBVbI9IPe6q7hTTmy0OirYhGwYugmC1R1Y6cRnfl2iWXjtqdlQa+7LQdi2kH9bDlJvm8fM0PdHuKVdHQFrbqk3Jjj38nx8uCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GV+n6Z4QqnuKO7lgeqIbnQRfDK84do/gmglkFoq/WaQ=;
 b=T18dFiai44fyRAg6Ue8dkihVelqRemotEpshXLd8FcHzhPm9N6nHM8Fz7BqwcnnG34gWvWX/6d+IWCuaepJ+9or+QehtBjw6iKf0Acun8RXcJ26kT/aR7pRHdoDBygLuJevI98RAULTtPL4zOORqj3HGd7WHgLanoApdIkGoobxkDP3NxHsNh0urBlDubiItpEkqorJdUsYL249EPChJli8UQJNrgNHvykLoEgk7YmxD492WvRIxTqpr+A+o1FXh5dUU8EU/cF9NWZuLlhhfTqQXvOpybvKog12qjOu8ygv4/r2f8tj5h+kLO5l+A3e1AdXa92cOet+DgVW3nvaYAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GV+n6Z4QqnuKO7lgeqIbnQRfDK84do/gmglkFoq/WaQ=;
 b=H9mlqu1R5gNlmnW8/C2J0R+h6uGR/vBYCKrZih93DXFcn1RhP22c3Oc+f3oLPQDPQra3RZxgkSSBtE0eWeGPB49PI8LQ0CbqSjIiwKVfpU53dP91e2v8wc4dxkbEUFf0O3FnH9nr8dmjTScE7pJ4HFzvOswDjKFdI3QQf3BghjM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PAXPR04MB8368.eurprd04.prod.outlook.com (2603:10a6:102:1bf::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 09:58:04 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9275.013; Mon, 3 Nov 2025
 09:58:03 +0000
Message-ID: <0f8fa8d4-3cab-4555-af1e-03feaef81ca5@cherry.de>
Date: Mon, 3 Nov 2025 10:58:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [DEBUG] rk3399-nanopi-neo4: SPL SD init may report -5 due to SD
 power-on timing
To: Sune Brian <briansune@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <CAN7C2SArdbhag_56MwOMGoaEYSLiHbHHo3KFhUS5U03ntEJbGA@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAN7C2SArdbhag_56MwOMGoaEYSLiHbHHo3KFhUS5U03ntEJbGA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE1P281CA0213.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:88::18) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PAXPR04MB8368:EE_
X-MS-Office365-Filtering-Correlation-Id: 29831209-271c-4d0c-841e-08de1abf7ade
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RG12bDU3b2pQTk5UbTN6ajg1YktzSS9yUjI0bWdXS25ZcmR2Z2dsYlcvdzNE?=
 =?utf-8?B?QU9XYjRSME1IdWk0ZmdUU0RYZjU5elRTTlZkaytuM3g0OS83aEUyNSt5SXVo?=
 =?utf-8?B?MHJSQ3kxQk50SDBQQnJHdjJSaGNrcy9VRSt0U1RxNXN6SnlrT25ZdkRFZUxy?=
 =?utf-8?B?N245ZUw1NUJhK2ZRVkwrendqa1ZPeHh2VnA4VFl4dTdpbHFteDdNdlpzaG9S?=
 =?utf-8?B?cmRLR0JONTdTbG5RQmczalNscGxqbStvUy94WVBGVkJUbEZCTG9ZcWtmcWRW?=
 =?utf-8?B?Y1liWS9pQW10ZDNVRkV5UmtOUHIramcrNit0NkN0eWRBSUZwMXdzMWtZblI2?=
 =?utf-8?B?ZXFLTWN5M0h3Y3ZhRllzZDRXKzhuZExGQmpCNC9FUnV6TU5nUlFaeW5yaWFm?=
 =?utf-8?B?QnlsejdYaXZJSE0zdzVkdEh5TWVidFN5S1FuYjZQSDhkWi9nTGFqMHlXM3dz?=
 =?utf-8?B?b3dlZmJ4SEEzc21XNHRwZGlLaUlsSWk1UlpRR0FEeHNBQlJkWWZHMm5ZSXpI?=
 =?utf-8?B?UHB5VS9ZZFRoV1dQcWkrZlF3bTFHeUt6ZEhNcy90TnZGZVN3L1dtQk9JSGsr?=
 =?utf-8?B?czVrZERaa3B4UzB3ZWZOcHh1YnRoZzEwUytlK1ZiOWI3akFOVEM1enVFTkRt?=
 =?utf-8?B?dG92RlRMVEo0Q1R5N3RONW1TaUN3N3JBV2l2bVpMTWM0NEhhMW5ia05GL1Uv?=
 =?utf-8?B?MHI0M0pXc2tDMFhUMVFGMU5JQXhmbk5hVU1DclRYc2dNNEpaVFc3bCs3b0RI?=
 =?utf-8?B?QjZlOTFFR3g0OVRvdmUvaHdpb0E4U3A0T1k5L0ZpTURSK1VHNDBKTmhRSXg0?=
 =?utf-8?B?Njg3cmg5OEJVYTRQSmhEbmxLVzlZYmRBenlhRksyMTlkRWtKWmNjU25OeEcr?=
 =?utf-8?B?TGdtcElGLzVZTlVZSmQvTFpKcXhSb09FcWtZUUw2NmdZM1BCZnNocmM4bmFQ?=
 =?utf-8?B?Mm5wSkRwS0RFUmthODJ0UHV2T0tRaTF6VnFVZ3A3Z2hSZ2JNZlZPZVB5OEtS?=
 =?utf-8?B?a25zUHUzaFhUZGVtMUY5MEtIYjYyN3ZTYkNtWWhrN2UzZ2JNQ2tveWkyMGVL?=
 =?utf-8?B?SmdnYVdRNHMzWm54VUFTYUFrVFJBSGFpdGdXZEdaT0g4eTJ0d1NQOFdidFNW?=
 =?utf-8?B?N2ZXMEovZStYdHBqaE01eXN0NTZ2VjNMbksxMEVlQ1FUT2ZZckNHM3A0S2Ro?=
 =?utf-8?B?aEZ1eWZyYXJibDl5dFNFRzRiNFJVODBZUzZyZ2pOU1BWNFg2STFhZWt5aWFz?=
 =?utf-8?B?dGZaMHhnbGxFM3ltbHZOWHdYTUNBSk1BZDMxRlF1Tm1SSFQzclFEKzB6UG5p?=
 =?utf-8?B?NjdrbkV0djFicnRzanROTEErNjR4V2ZFa3c4N2NQa0xtSzhFMjVNRlhxdzVK?=
 =?utf-8?B?N1hMVzBaL0Q5dXVtc0ROVWV5M3hxSFY1cnlPbVhSbGtSWEY5dmMvUEpxNGFh?=
 =?utf-8?B?N0htTjZ1aWlsd2hXQmpUdW5YbFJubzRDcnNYR280ZldNRWtjejZkdzNicUts?=
 =?utf-8?B?SUVNTlMzQ3NvRWZudnoxMHFxNmRYK3Roa0Vjd2FnSnI3VVJTbll1a2hmS2kv?=
 =?utf-8?B?dlQ5bGNqVGhSZlVJVTlJejY0NGVmZzZkNHRqMk5jZG9TRW0xM1VsOFlEUExi?=
 =?utf-8?B?QWhXR2o0b0ZjN3VKT0pkLzJuS1IrcU5zc2lkeTkzMmI4L0QyYmNLN2l6UGtn?=
 =?utf-8?B?NU5kUkRKYm5GbjJLNFZDQUxqbTh5QXRObTdBaUcyRGFTN2phekVMUnAvRXZS?=
 =?utf-8?B?ZXk2RVA1V3NSTHNUWHFENmpTRWMyWncxRzl2ZC82RUVleEFtUmFxMGROWTh2?=
 =?utf-8?B?U0hieTYvdkVUeDk4OFZzc2syOTJCRlRkdElpNnYzcWJtMXdodkVkR0JHS1Rs?=
 =?utf-8?B?WmNoZ3g1NCthd21VbjAyZEl3Y29KRWZhQldEall2eFZ5UGY3Q0l3QUpNUkF1?=
 =?utf-8?B?Z2d1TXg0SXJaaTNCQWxzQkU4ZXVCM0kwLzdxSXlrUlhHUW5Nb2g4S1oyQXI2?=
 =?utf-8?B?MDRzRzJYZ3BRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UEs2NCtuY3FKSGpWaXRlMUlpYUxhMm9IdUpCM0NOSy9ubFlKT0EyZ1QyZzE0?=
 =?utf-8?B?cTBRVTVBS2NDb0dvWVFtY1NxRXd0WXlpVUVNbXgzWW5PTWFHdnlQTFdnZEcx?=
 =?utf-8?B?SVhBbnRRSUthM1FiUnBFa0d4NngrdkRKc0hMT1J2VWJ5OUFTR2E1aTdMMzBE?=
 =?utf-8?B?OUczT2xOcVBydEU5R1Jxam1vTGt1bEhJdEJwY2diYVB1TUY3bEY2WjUyd2dw?=
 =?utf-8?B?dGV0TG5VZlBRdTROcmN3bDZBR1pDSDNFaWh6TGlVaHZoUTRFTjU1R0ZKZVZp?=
 =?utf-8?B?MWlyMTlJN1o2V29kRk9STHFuUVVEK3QwYlp3Q3BUWFFLRldtcytQeGxOdUxi?=
 =?utf-8?B?M1F4U2QwemhNTEVtVk9GSXZTajJxb2sydEFHNWlOcndOMTdsa1VHTXRwVllC?=
 =?utf-8?B?S1o3V25qbWg4c0lGM3NGc3Vmd09tTXFCeTJycnJSZXkrWmFRNW1wYU1ESkJm?=
 =?utf-8?B?eHJ3SGlMckN6MEtYTXBFakZaUkVaN2doSGhzK0gvZDB4NVpKbHJ4cHpCNHVh?=
 =?utf-8?B?RDdZT0o4YWNveU0xcWYwTVNOZ2x6bUhhRVk0V3RtcmgyK0VPRjhYNDBISk85?=
 =?utf-8?B?cmlLV2ZLVWhUUXRPdExzejJZbEMwYmp4SlVpbUlNOTZsUW1lTjhucU5uaUdl?=
 =?utf-8?B?RDk5Y0dWTjgwYlBtZUQ0ZWJZamdpRFQ1V2pYVFZUb0hoZlA2SjNKMnlIQ2VY?=
 =?utf-8?B?cUpoSGZxZkc2RWRidEtkOVBSaC8yMC9rbGZ3WDVKVng5eFBiT3hPRy9mRG9D?=
 =?utf-8?B?am1KY0dSZmlmdldNMDJZbVE1eDRnbzlJdmNtZVhOcGRBcWhQVTY5M0tLdEho?=
 =?utf-8?B?RFNGU2tmcE9zOElnVWozd09kcFVMZjBGTHlhaWg0U0k1ZXpqenJVNHhOcE5u?=
 =?utf-8?B?SVFaN2tTRzljR1JzSjBOZmJBOXVTQm5ud04rOFVzTWNzQnFud2Y4T2FraUhL?=
 =?utf-8?B?VXFtcnlVWnJ2ZnR3UW9NV243eE1QTTVtS1hzbnVaM3VlYlhOWE10VmszQ3NP?=
 =?utf-8?B?WHdiQXgzUXhSWmJ5M094RnpqMHdUZnJqazFqL1NvSzRsVTlrWWdBK25aRCsw?=
 =?utf-8?B?alp0S0ZWQ29JallpUU9DWlU0OXdsL05GSHM0RnpPdjNmcE1qRS9KTHRPaUk4?=
 =?utf-8?B?Z1F1VHB5bnYxNW53YjE1d3hVRUtKQlU0SWJ6b0lDbHhDMUIyTTVuWk92SUha?=
 =?utf-8?B?WFBPMitEU0JMeTl3dmdXeHpiWk41bDNlR0gwblAyWWJ0L2UrMXBqdzBoM3dT?=
 =?utf-8?B?RTB4SktmR3BoNlJDczZjZUtsRlY5VFRmQk1EanhQRUxhN21yK1FqRlhFQVNs?=
 =?utf-8?B?dURqaUVOdkM4Q0E5bWhOc0c3RkloMys3cjFNWnlPR1QzNFQ3QW1PTlpEbGFP?=
 =?utf-8?B?MWd0YXNKS2NDd1NnT3R4Y2JmMXdrNHVRc25vZU1OTENKdmdDNm0rRWFEQjBi?=
 =?utf-8?B?VHprbjZ5T0o2NXp2a0VlM2NSbEhuTVFWa2VpOXJXZWFNcE9US2t5NEhIUU5J?=
 =?utf-8?B?bG1ZK0o2STZIendTYWQ0Y1czK2YyaHpWMi9Mb0ZKVjZTWVJONStGRm5WOGhR?=
 =?utf-8?B?dXlvZG54cWNNdHR3Z013NE03Nm5xRzFMbllEZFB5VVJNQ0hMOVRCalB5N0ZB?=
 =?utf-8?B?QUxvVWx2RktSaTV2cVpxeCtJTGNnaXBqMUFHR2FYSTgvaXRmYnU5RkkxcVN4?=
 =?utf-8?B?SXdwdndXbXNybGFXUnYvNWgvK1phWENnOVExYkJ4NEhwY2Qzd1RwRmVDQ2g4?=
 =?utf-8?B?b2lpbXhhQ201eHNnaE1YaDQzbm8vZU1tY0s0NDA2WjNRSnNySGEwVm15RjFj?=
 =?utf-8?B?cDdkK2l1b0V5dlE5dWlWYndvQXR4UjA2R2QrSytMbE9uMjFDRk4rdlZ5UHpY?=
 =?utf-8?B?d2d2Z1NJeUxrajlTQ3lTMVZKbGlkQlRIc1Y4ejNvQm9CSW80STA0ZlVhQUlJ?=
 =?utf-8?B?ckRVOEFYMktuTFhVUlhnOWE1ZnNKZW53SXo0c3IxUFYwZzAyT0dBR1dEcUR4?=
 =?utf-8?B?UFlYTGp4YUJCM2FZRTZNNmZaZ3JPdEQ5aTJuaStvbU0rRms1QVhuV1BTTnJG?=
 =?utf-8?B?U1laRGc3TTB3Nlozd2FTOTFXc0RabS81bEVXMnpVQzFhemxoT0VYcHZMVUhz?=
 =?utf-8?Q?s+AEzImqZFSh83jnAlqDB1sDe?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 29831209-271c-4d0c-841e-08de1abf7ade
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 09:58:03.7364 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tRwp3mY22InlIPnEYzhPo+jaCf0HwMP0AXKGosOUdZKlRatdfzoKNdC3IXY2/teSNSHalAv8ocwX2RLlyl/KxYtg5zGZ7v8188OaJt1Rtjk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8368
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

Hi Sune,

On 10/31/25 5:10 AM, Sune Brian wrote:
> Hello U-Boot maintainers,
> 
> While testing mainline U-Boot (v2026.01-rc1-00070-ge34d01d23e45) on the
> FriendlyARM NanoPi NEO4 (RK3399), I observed that SPL sometimes fails to
> initialize the SD card with the following message:
> 
>      spl: mmc init failed with error: -5
>      SPL: failed to boot from all boot devices
> 
> After investigation, the root cause appears to be related to the **SD card
> power rail (`vcc3v0_sd`) timing during SPL startup**. On the NanoPi NEO4,
> the SD slot is powered via GPIO0_A1 to a fixed 3.0 V supply. SPL may attempt
> MMC initialization **before this supply has fully stabilized**, resulting in
> a generic I/O error (`-5`). The SD card itself and the controller are
> functioning correctly once the supply is stable.
> 
> **Workarounds / fixes observed:**
> - Add a small delay after enabling `vcc3v0_sd` before SPL starts MMC init.
> - Ensure the regulator is fully powered and stable at SPL start.
> 
> This appears to be a **hardware/platform-specific power-on timing issue**
> rather than a device tree or software bug, but documenting it would help
> users encountering similar errors on the NanoPi NEO4.
> 
> **Hardware:** FriendlyARM NanoPi NEO4
> **SoC:** Rockchip RK3399
> **U-Boot version:** v2026.01-rc1-00070-ge34d01d23e45
> **Reproducibility:** 100% with SD boot
> 

Can you try to apply 
https://lore.kernel.org/u-boot/20251031145951.535376-1-c.stoidner@phytec.de/ 
and see if it helps? It seems like the implem in U-Boot doesn't exactly 
follow the MMC spec and this supposedly fixes it. My RK3399 board has 
the vmmc-supply always on (not configurable by software) so I cannot be 
impacted by any change.

If this isn't enough, you need to specify in the regulator node how long 
it takes for the regulator to be stable. We don't want an average, we 
want the worst case scenario so that all boards work, if you only have 
one NanoPi NEO4, then so be it use the delay necessary for yours, people 
can increase the delay later on so it unbreaks their unit as well. This 
is what Jonas recommended already.

Cheers,
Quentin
