Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B1DCC5AD05
	for <u-boot@archiver.kernel.org>; Fri, 20 Feb 2026 16:48:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83EAF83A5E;
	Fri, 20 Feb 2026 17:48:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hotmail.com header.i=@hotmail.com header.b="mfxOSg6F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A6C783AC5; Fri, 20 Feb 2026 17:23:49 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazolkn190100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d000::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A746083A41
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 17:23:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macromorgan@hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LSO0wkZH6LnknWFuWQEdZI8knyVQWQexlWHcMnQiQVoMMPkM55BcPRS3vTt6R20X+3n8Ck6ZBdenBKt2aBU92dZ1NM133kSISgavSi6vweNOldgsPyR46KpVEymLXAgWDQSDQZIznXFXTHiuXSVbtzLSKD7pjI/sWNWUP0wjGxnAWYbeD+UANPSSAWxDuFL2zrI80LkJ7wJsYq5fl5kVMcZkxFcx4AEJH16AsLrQWQ3xOVRs79vkJCGv1Zp4e7vDK6DfXuimZ1O7kbTQkx2xGwAH+vPqEX/0Bb150WJKLTx86SvA33QvYU17Upfd1M5d4Ac5vb6gP/Ps/vxixDDVLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eayPFX8REHNzsvOWxCN6Bec3azIW0RbeujQ2YKEqz2c=;
 b=MWImC07FV6AuvN9ttj72pPu5rhgVJc8N0tUXbnLdyn3S7by9z+2gPYJTkyTTvFdvRYRWJNwwkat0Oeoo8j0eiVAbLa3wc6wSeqRSahHLD6+/cZbe+rxRFiwXY/R98s0QZxWjfaVhe7yFkT8tiMY6XBdfFYeXOt+Rk/ZNnbEvT2p07mMJlzmNEnO5XTAi5uLMGbbIQriBlIuqnajgxCsEg3ZolNUNiqTGvzL9sOQlmxx8my4xQh2B7VxustYHHKziN1AtDR5E3Mi5UstLLIjWSygtEKZQ11QlLfHViKb/TgsTDJGk8GSM44ybxkgBvgCcfxR6fJC/s8ddmWMy3mu9Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eayPFX8REHNzsvOWxCN6Bec3azIW0RbeujQ2YKEqz2c=;
 b=mfxOSg6FeqeYSk9I7p2t65K+2Wo63gEeddnTpGYQDeZs0WtgVW8ky80bCpqey7NyUbK1QGCstGoh4cSgm5YYs93QzFgZVnfnXx/fQzgzBVvYHsKv2ctoHWBEW8cHs0erENI3Umfsvov1PtI3Ndl52iFcUc9kSQFsNv4acpL0x0NAEy6cp/pSaa0PtCojZ1udZQh9+z6DRow6wDisfL7eGn4kameDcRe4g1xRV1lmFUpowODrRPYjgX2MJOSpBy5oeJ2fWDCEBzshk2d6qT8Wb8bFp55wbOuGdJ5E3WdcYuhOsh2EV+/E3RZJw5NIBlyDPefkjLQ8YD8mN8IopIHydA==
Received: from SN6PR1901MB4654.namprd19.prod.outlook.com (2603:10b6:805:b::18)
 by SJ1PR19MB6210.namprd19.prod.outlook.com (2603:10b6:a03:45f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Fri, 20 Feb
 2026 16:23:40 +0000
Received: from SN6PR1901MB4654.namprd19.prod.outlook.com
 ([fe80::57b1:b92:26fc:c937]) by SN6PR1901MB4654.namprd19.prod.outlook.com
 ([fe80::57b1:b92:26fc:c937%5]) with mapi id 15.20.9632.010; Fri, 20 Feb 2026
 16:23:40 +0000
Date: Fri, 20 Feb 2026 10:23:37 -0600
From: Chris Morgan <macromorgan@hotmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: Re: Fwd: New Defects reported by Coverity Scan for Das U-Boot
Message-ID: <SN6PR1901MB46547577B09BFAA89055E1A5A568A@SN6PR1901MB4654.namprd19.prod.outlook.com>
References: <20260213220927.GN2747538@bill-the-cat>
 <SN6PR1901MB4654C67BCBEA987213F1922DA56AA@SN6PR1901MB4654.namprd19.prod.outlook.com>
 <20260220161156.GW3233182@bill-the-cat>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260220161156.GW3233182@bill-the-cat>
X-ClientProxiedBy: SN6PR2101CA0016.namprd21.prod.outlook.com
 (2603:10b6:805:106::26) To SN6PR1901MB4654.namprd19.prod.outlook.com
 (2603:10b6:805:b::18)
X-Microsoft-Original-Message-ID: <aZiKibBRZg8H2YjH@wintermute.localhost.fail>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1901MB4654:EE_|SJ1PR19MB6210:EE_
X-MS-Office365-Filtering-Correlation-Id: ff3a9d89-b5da-43c3-d20f-08de709c6829
X-MS-Exchange-SLBlob-MailProps: Mga27o8vReFWf9RzH6tnqJClNbiui38JZkvxjtfvNzddEXBZ7Dg+K6bk2bbUenqgzKAYf2GiASgQyVOFvL+xEMuzLnluai8M6uQ0n5XogSxIktauA7fxBkca7Igv/DXd2wyi9ck/FZIlVQplUhSSrqffqFn79+SbVE7VbjPetri9tGDgrNc55sxn7NA3NKeiBtEvzctRS71823LdGRMgYfpUTqOFeADJ9gETWaEept7ShziCffexWHbCT7oEYXPmaaxK7z8aj5/QdjCOWbqtrFhJNE5yDe8xrxiDboySFISwN9Q1wJMv+SDXYMkDLbKHTO2hfDvxhOHFL53EozFKdbPeRj4jZw6Wtb4QHXWTgE4TCs2AC0uBBFuJG0DYqOXyXLIjS4eG5/DMMuXcXESMCq+L9Q7rg7LS2GMf3eoLeEjSTKwHb+l6S21Lmk1gEs1TLrfzIDI/0ly9pXJ3/FxdNkV/8z5gQj8XTNO0y1spLZfqbsgGewY638er3f6uszteBKZE6jlAHtLYpm5d50Xdajefh6fw30IJXWXQZ9KUD83GWGvXeT0KvElcZAogNFo5GIAkaz21eESjiMAaUmoTJOzQ6g1FOYxdkRoRAXf5GJA87bBMUimfLQNAIqFDioC9/Ki19Ze6j6/c/LLfD8IwCOSRZNyi5s9xJMfyuIfV/2zRY8RwXrW4Q7eKdNZOd6VwcwxLSx/OvTmnfAxqBirqgRbAmBAqGD+W3muOcvT4K8BmGIRGviwZOU7oRohkW8O9t+XlQN/O19npkMsTG39FktuBeZBJnK2Ss45p4KAOz2diiHDUUPvvCg==
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|6090799003|15080799012|23021999003|41001999006|5072599009|461199028|19110799012|8060799015|440099028|3412199025|10035399007|52005399003|40105399003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cVRteHVSa1hEajBHN203bEJzMmcyb2RoTHdLd3RQUHdOc1QzQVdXVFR2Unk0?=
 =?utf-8?B?R244amF1bVZrWlZNL3ZVUTdmVEgzYitwb1FjUTVqUjZEaGtzZFh4bE9hM3Zv?=
 =?utf-8?B?L29KV0NWT1o4WVM4cUlhZU01NGptczg4VkhMU0JXYUl3eTdxdHRQb0tFbGVh?=
 =?utf-8?B?enVHd0NDUjNHN3BEaFpaaDJpNzc5NDljck42akVzbXNMR3VrSVdUNXROMTVi?=
 =?utf-8?B?bzNBNDl2VmxYVVRxL0xxQUZYbU9ZSHMxZGZyWFkxRFZnMHQ5c2l4UlN4MFZo?=
 =?utf-8?B?Y1BqRnpGdDkrV0lhcm8zS1RCb3lhQTRMZTVIaHR0TmJxYjYxNVYzTUZJMWtr?=
 =?utf-8?B?VnFxOW4yZlBhVzRTbllxS0NOVnlzRUVRUVRvRlRBcmNGZ3JzNldLTW9EK201?=
 =?utf-8?B?UUVhSlNmRnZLZ1B2dHpZRVFxdVdkWGdHRllORWUybEhmZ2dBK2RyMWlPaFpG?=
 =?utf-8?B?UlJOL2NBMVNIUmhUUjV0ekhHN2RUUGF5MmJ6d2FPTWpSaVJkY09abDNBdTZo?=
 =?utf-8?B?QjZZQUhuWlpJQUt2UEo3TVR5R1hsN2xOQlJaVGtzNU5tQUFKOGUrNHBLK3dV?=
 =?utf-8?B?SDFVYmY2VGpVbUsyREdBMXNQVDJ0YXZzTnFORVNsY3QvOE4yVFQvWFJXM3BH?=
 =?utf-8?B?ek1oTlVYUjE5VC9STmtpRXNnbEh2Qk9LTDQ4V2F5eDZ6a0lEalRsV2Y3UDFX?=
 =?utf-8?B?ZCs3a1FpTmtiajNvdGFEMmxGVEFTWXRBLzlWVkNzeHluUU5aYWdqUWlCdE9j?=
 =?utf-8?B?d3pLZXNOdGdGNDQrNGtOZWFReGdLZDNkUlpHSVdETENYTDdVLzBYVXBveTNG?=
 =?utf-8?B?MjJVRDc2Qk96QnVHclk5TEhHNEMwRG9rY3hCdEpqaGd0SWh6VGp1di9MdGww?=
 =?utf-8?B?VWI4NVR6L0YyMldqekMrVEdkcGFNaUxYQlVYelc0cmlObUtWYkc5ZmVDd3lS?=
 =?utf-8?B?LzdRdWNhUDRsajFFZi9DNk5lWXNEZExqMWFXWU5DMUhnNzhBUzhGUXVZOUFi?=
 =?utf-8?B?L0hMSThkWEVWOEdMb085eTE5WmtaeXUrcE81OHdIMElENnNVY0JpYVY1eE5a?=
 =?utf-8?B?LzdhL25RUml6d2NWTTBPbVc2K0lmNmFzNFVvS2pZYS9Yb2JiMWFEL1dhdWZB?=
 =?utf-8?B?a3pGSmtMRVdFVk1QMXFiakxHN3JMak9OSVFhMlkxU0cxNkliWEgwS0pjK1ZF?=
 =?utf-8?B?ODRCVTllcFFtTWZFWDMvT0FEUDEzZE9hZitYclhTc2NHUXJlMkYvTlNBejVV?=
 =?utf-8?B?QXg4NXgxQitIUmtyWGxHb3ZXSTBoaG9VMGNGZFFSSElIaEFSaGtGVXpROHZz?=
 =?utf-8?B?TUIrZXFnS2xma1dvWldOVXUxRXZjTm1DUmNHUk1FdHZvWjF1OG9nZXJYMVJW?=
 =?utf-8?B?Q3d1OERvdlVaS0tBaW9BdVpjcGFKcjBSeE9BaktCa1lyVEpJc3p0VzAyVmlz?=
 =?utf-8?B?TmJXYy9QUGkzalhEZVBIUFV4QUt5VFdJbGhqTHB6MmdHc1NsVnF5ME9CTmhz?=
 =?utf-8?B?ZGNMVGdFVDZXdWRrNUdmRlg2YlhNYnZLVXd2YTlVemFqNmpDWmd5VTRoeEhG?=
 =?utf-8?B?bnJFUjJnd0lNcEdzS3poekRXL2pyNWJlc3N1RStJQlhxM0lrck5xWjZBNkZk?=
 =?utf-8?B?SFNLM2Fxek1mQVlLby9kUmtXZC9YUStpdURTTURYK3ZsZHA3SVRWaUIzMm96?=
 =?utf-8?B?L3hobi9UYlpLLzJYQmFtYXFld0tQVWxaaUZtMXVkbXk4N0Y5VU5TK2hpd2tl?=
 =?utf-8?Q?AxNC0lwwUwgQH5+XRHKBTLCehxOC4qeivRIdDoc?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2ZUVWZZSnB6d0U2eUFCK3Q0L2Y4SDZSd1hDRmhiSC9NaXE5dWt4b2hNMkV1?=
 =?utf-8?B?MlZpL3h3TDBFRFR6VDhidmpmbU50WG5zUjBibjZWbTk2eW0zN2lnMXQ3a3RS?=
 =?utf-8?B?dmNLRGk0L284bG9DVCtBUUhGWlhMVklHRWlua2MzTU1raUVlZVlERUFneTVW?=
 =?utf-8?B?VzRlYnlKVW4xZVIyNTNSYzVsbmNVSFVJeDZjdnMrcTFOTmQwNTAxNFBMeVM5?=
 =?utf-8?B?RWVTMjJDVEZhK1Q3QTdPN01HaGhOd0xlNjFpc3ZnMzNGcWJHc1I0TW9xMW92?=
 =?utf-8?B?NXJER0kxZEVVYk9KYnFTYlBTT3M5VmpBc1I2Y3ROSXhlcHBLbkl2ODZtWUFU?=
 =?utf-8?B?M09HbjdGWkFBSWdwbCttM0x3S0RBUkUweTdURkFkdTF2SmJjSkFuQzRQV1R3?=
 =?utf-8?B?eWFiM1BSVlRDOGVpc1NsZXRLUnp0a203Z0lIRGF5NTd6N3RlcS9sL2cwZEZP?=
 =?utf-8?B?NmZlKzNRbWk3VDV6VnR1cmZ2bU5Hc1ZPYVZzS1B0ckROall1ODlCSXpaRjRa?=
 =?utf-8?B?TGhBMlRMZFFJbDRUWHhVNGVpOUNpd3dnK3lzUGEwQlIvaG9hNHRnd3dXcXRJ?=
 =?utf-8?B?VDZGblFTVkFNMGRsWi9rNy9jRW9pVmtZNVl3Q1ZzZy9KQzhMd2NGcytJTlc1?=
 =?utf-8?B?dHRsZGtkdHkyRzNIekFaaFJ3RENkQVpOVW1uaC96ZWEycUdTZVY1Ui8rUU16?=
 =?utf-8?B?Ritrcnp4dWtnNjV3aEREVTFwVVY5Y3ZEL1V3eDJHNXhDa0JHVHdtN21BM0JC?=
 =?utf-8?B?Y0pPSmpLanRzK085ZkRJQ3NVQnJpb2VOZVlTMDZDY3JPSW5ad21YRitENW1x?=
 =?utf-8?B?Y0g0VnNtUFhzcjh4STZBTHZJTFlCWjQvTkFvMG01WGVmNGpkb2l3S1A0R1dZ?=
 =?utf-8?B?c250czcybXZ1WUZIYWdDeVplV0VvNFFpMHdObFZ5YmdiYjM1VWlISWh2T2Z3?=
 =?utf-8?B?cmx2MEFNQllnTlhUcE9JSXFER0c2ZDhPbm8rNE43eTRjeVdWRUxpbXZBbWU4?=
 =?utf-8?B?bHRrUVJFa21QQisxak5hRzJNNXBzM0t6cFBsMDRaU202MlYvQ1RhNytsaExR?=
 =?utf-8?B?RllBZS8rcmdlK2w0b0dvYzR1MmVkQW1qaTE2T2Q3MG5IdUR3bkNkOSt4MVFN?=
 =?utf-8?B?OWxqbHpHRGFERkxHZFg4TEZDWTRVb2JlNmdCeTlQbUZyNWhhWHVKTjBmVU5v?=
 =?utf-8?B?VitCR0RiRDd5V09mbUJqRGhBNGdBY05Rd05DTjg3SGd1RXpyMjZjV2FUK0t2?=
 =?utf-8?B?anVWT0haV2tKam9ITEF2ZXpFZUJ5Ky9zZ0hpV3o4MjN5cHBBNEdMU0tVN0ln?=
 =?utf-8?B?SWVYOGs0eFZTVVVKRWxHTmRXbyszYXRDR2NicVVGUnFVbUhrQlA4aTdXNTZw?=
 =?utf-8?B?d0c1WWo5N2VRcERuS0JaN3pjUjl1VDd6OUpQRjRRY1dJUjBKb05PY1ZrR0dz?=
 =?utf-8?B?K0ExN1VKWTFXL3RpN0duRGtkY1JkT2ppQ1NZTkNYVytobjVuT3pqRy8vYk5N?=
 =?utf-8?B?WTN3ekhDVjVlNHJwZEY4Vk4yc0xLMVNySWxZczA4Ti9YdFVOam82eXRwSnBQ?=
 =?utf-8?B?cm0vVTlmMHZKNmw4emFTSWlTSG5pc0I3dE00dUdwNTVFTTJwNncyc285VE1y?=
 =?utf-8?B?anRDTVJCaVRIYjJRZmxVSHowQTFRcFlOdVVIa2o5L0hZWm9kUGI5QXFjOTFZ?=
 =?utf-8?B?elFZTnBjV2JPOVNvalo0T2d5R3lqK0ZtQVNERmIvcGtqTHdKcEFFclBkSXRl?=
 =?utf-8?B?VkM3RHVNTFRGWFIwLzRmNWpNNTB4cGFQU3NmL1lvTTFwc0ltbVZ1UStrLy9Q?=
 =?utf-8?B?VnN2NUVuVC96bGoydUdnZllHekxYaU1sZE02WDZmQUpaQmxRVWloMHlqOVBV?=
 =?utf-8?B?eFlrcTFwSXFJTVpuaEh3Vmpya0VoSjJmUFJmOEpITllxR0E9PQ==?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-6f20a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: ff3a9d89-b5da-43c3-d20f-08de709c6829
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1901MB4654.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 16:23:40.3089 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR19MB6210
X-Mailman-Approved-At: Fri, 20 Feb 2026 17:48:00 +0100
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

On Fri, Feb 20, 2026 at 10:11:56AM -0600, Tom Rini wrote:
> On Wed, Feb 18, 2026 at 05:02:27PM -0600, Chris Morgan wrote:
> > On Fri, Feb 13, 2026 at 04:09:27PM -0600, Tom Rini wrote:
> > > Latest Coverity Scan report, now that it's back up and so a little out
> > > of sync with the usual schedule.
> > > 
> > > ---------- Forwarded message ---------
> > > From: <scan-admin@coverity.com>
> > > Date: Fri, Feb 13, 2026 at 4:03 PM
> > > Subject: New Defects reported by Coverity Scan for Das U-Boot
> > > To: <tom.rini@gmail.com>
> > > 
> > > 
> > > Hi,
> > > 
> > > Please find the latest report on new defect(s) introduced to *Das U-Boot*
> > > found with Coverity Scan.
> > > 
> > >    - *New Defects Found:* 1
> > >    - 2 defect(s), reported by Coverity Scan earlier, were marked fixed in
> > >    the recent build analyzed by Coverity Scan.
> > >    - *Defects Shown:* Showing 1 of 1 defect(s)
> > > 
> > > Defect Details
> > > 
> > > ** CID 328330:       Integer handling issues  (NO_EFFECT)
> > > /drivers/usb/dwc3/core.c: 106           in dwc3_core_soft_reset()
> > > 
> > > 
> > > _____________________________________________________________________________________________
> > > *** CID 328330:         Integer handling issues  (NO_EFFECT)
> > > /drivers/usb/dwc3/core.c: 106             in dwc3_core_soft_reset()
> > > 100     done:
> > > 101     	/*
> > > 102     	 * For DWC_usb31 controller 1.80a and prior, once DCTL.CSFRST bit
> > > 103     	 * is cleared, we must wait at least 50ms before accessing the PHY
> > > 104     	 * domain (synchronization delay).
> > > 105     	 */
> > > >>>     CID 328330:         Integer handling issues  (NO_EFFECT)
> > > >>>     This greater-than-or-equal-to-zero comparison of an unsigned value is always true. "dwc->revision >= 0U".
> > > 106     	if (DWC3_VER_IS_WITHIN(DWC31, ANY, 180A))
> > > 107     		mdelay(50);
> > > 108
> > > 109     	return 0;
> > > 110     }
> > > 111
> > > 
> > > 
> > > View Defects in Coverity Scan
> > > <https://scan.coverity.com/projects/das-u-boot?tab=overview>
> > > 
> > > Best regards,
> > > 
> > > The Coverity Scan Admin Team
> > > 
> > > ----- End forwarded message -----
> > > 
> > > -- 
> > > Tom
> > 
> > I'm not *entirely* sure what to do to fix this issue, but it looks
> > like maybe the issue is that all we're trying to do here is make sure
> > that the version is DWC31_REVISION_180A or earlier, and this is done in
> > mainline by checking between revisions _ANY and revisions _180A
> > (instead of creating a new macro). Since the DWC31_REVISION_ANY is set
> > as 0 this means that condition will always evaluate as true. In this
> > case though that's fine, because all we really care about is if the
> > second condition of the macro is true (whether or not we are equal to
> > or less than revision _180A).
> > 
> > I copied this stuff directly out of the mainline Linux driver so as to
> > maintain some semblance of parity (and because I needed the stuff that
> > used this specific macro for gadget mode), however it looks like to stop
> > this Coverity error I need to create a new macro, possibly a
> > DWC3_VER_IS_AFTER() macro. Or is it simply fine to say that I
> > acknowledge the issue, but given the context don't think it's an issue
> > if the comparison to zero always returns true because it's just a reused
> > macro with two conditions and we only care about the second condition?
> 
> So, looking at the Coverity Scan dashboard for the kernel, there's just
> nothing on drivers/usb/dwc3/core.c (at all, even closed), which I think
> is odd, but I also think I've updated the filter correctly. I'll put
> your comments in the dashboard here for the issue and mark as
> intentional, thanks!
> 
> -- 
> Tom

Perfect, thank you.
