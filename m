Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC786C87FCF
	for <u-boot@archiver.kernel.org>; Wed, 13 Aug 2025 13:33:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20BB682CEA;
	Wed, 13 Aug 2025 15:33:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="t0f/6Y1j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAB0E82D21; Wed, 13 Aug 2025 15:32:59 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20718.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::718])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A74F7829F5
 for <u-boot@lists.denx.de>; Wed, 13 Aug 2025 15:32:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L5JZof2AmjwLmRuw6j7VCXhb3O11q+PDNvkVcTHhY1lAdNjpTkc3j49LYNDjGH6YyCANKHSaxW3R+kqvqhpRn7jhBAH5QksfauEeRIbKi7yXPy9Yb6exnqbcRrulsizU/jDcvVLbcYL4LHH2SIJSnV9jpmVx5DeenbDpEIGR996VS3LlCrlpmDrSU1g+f+m/Ae5zLtxeCMuAdNJxE4nuQkUJq89+aqsE8IyvLC9MGid1S5AYFy6EO+1aWzgePWuPJpsc+JM8GfC5yKU5afZy+jvHi//65FrB66DvW/+9JbNrce1EqhGOw5iXTfmmvjMZGV1ykN7vCnlZh8GO2h7Bxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pdkNVnkONauscE4NeOBA/QhgY4+UA41oqIWtiVu12+U=;
 b=APvuyYsEJyYih+almwOVr0rqH/nm4+gg5cPtCi8yvinpKcvikXEUH01/XJa2wiPe1LOjAGrmtND3Kg9qm6ikplCcdjImcsMOvebTmfEGmxJv3EfHM+xhGZ4VgEI7WJh3JbuE94aajPgCNVKqmj9AsjRpsLGQcnlJ+kdqhSeHfGkeTuNbdI2xzxL3nPf4DWa69osJYM4gvzqjm1TB92JG6W3/jAsBWoYa8uzx5qHKb9XDMKu5RQS9PnwDtcnduNSRmwtWVHwh5O9FVQ5KRf++aXIIQYU4ayuQPtI1oeyAP1QsGQ7rAxFjFD9KS3Rp5ZMbXYUAFhmwYhzqmGbp1sAfbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pdkNVnkONauscE4NeOBA/QhgY4+UA41oqIWtiVu12+U=;
 b=t0f/6Y1j3vdUoin5ZGcLXpXJzqnmlfdIYDCgq+sxpGgm75cwVtXoe3usuN0LuoFVXlgk51a5mq7ifbANvQo63/lnrzbWI8QTXfi+COkdWe+sfoXUTMiCkMPo2aPCk+ZLk4F3K2zhh4ZdHcz0qq7Tddffeahn4TfmoP+b8L3XspiypEKYk0JouSRZGzw1h/0LCfjOTg/Rh1Y2sPDCLkM2JJumIHLmTiFEqID7o3+QCWwSLFZRM+PcQFMyLAADpJtKT0LLgWKbIBXxTy6egXnW4DlaGqO8olIEwnshtUk9uhPGr5209dqJl4dQuJTYZbIw4Vu61gbt+EUo1G1/4/7OAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4b3::21)
 by DB9P195MB1258.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:296::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 13:32:56 +0000
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a]) by AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a%7]) with mapi id 15.20.9031.012; Wed, 13 Aug 2025
 13:32:55 +0000
Message-ID: <175a28f4-b67b-435e-b3c4-53af51cd2bac@phytec.de>
Date: Wed, 13 Aug 2025 16:32:53 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bootstd: rauc: Change global method to check any partition
To: Martin Schwan <m.schwan@phytec.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250812-wip-bootmeth-rauc-flag-any-part-v1-1-9f8546e80928@phytec.de>
From: Wadim Egorov <w.egorov@phytec.de>
Content-Language: en-US
In-Reply-To: <20250812-wip-bootmeth-rauc-flag-any-part-v1-1-9f8546e80928@phytec.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MR1P264CA0086.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:3f::31) To AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:4b3::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4P195MB1456:EE_|DB9P195MB1258:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c9ca54e-8261-4e07-a638-08ddda6de944
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T25rdGdHMzAwM1hVMWsybFNFT1NYVmFIeUd5MDdNRXR6NTBiVGFOTkE2dXZm?=
 =?utf-8?B?UURBVDZXRGF3QVNTaHdYbDZtOHNIYmEyZS9kTU12WEFFb2E4c3lTU0t5c1Vh?=
 =?utf-8?B?SEp0anVDU3F1TkNkajFBQVZ3MVBZdlRPbjdPSm81aHZYcSs0YVNHT2RSK1VH?=
 =?utf-8?B?bFhLSXdnSExyZGtQSEZlSHJ1SkFaVXRQUjZBcCsranU3NGVrcnp4ejhESlFP?=
 =?utf-8?B?a3g2WjdvRk05MTFpM3dOUDBNaWtlY0V2MXZCNVhLMTFGZ0Z0ZXRXTzY1Sm8y?=
 =?utf-8?B?eDIrMFBnRHJXUnZuQWExZHhuZkkwSWRiVU9iQ1doNWo2UThENHJLa2tMajdV?=
 =?utf-8?B?cTBJaE9FRWFWTDVlbUxzbGJ4VEwzcWdJd1VRV1ZQMWY0WElPR3dEYlFZMzBy?=
 =?utf-8?B?OWpBdGFIVHM1dHhvWC8wTGUwRnl3azZKNnBwTWZYdys4RXRMWHlibitBOExF?=
 =?utf-8?B?VzhFNzhYTWc1MHoxNWFlVytFWENFdmNrSW9XMW1OYWtEWTIzZDEraC81Lzg1?=
 =?utf-8?B?QjlmYzAwRThjWVE3TXNYMUtKKzdYQmdCSmUvZ0RXTXc3OGU2QmJ3ZDhFS1p2?=
 =?utf-8?B?NTBzKzlrM092QjlYZU9Bamp5RXgxS0w3ZnVxZm1POFVRVHFYU1pmVnBaTjlQ?=
 =?utf-8?B?ZjlGc0tHY1NNaUhZR2w2LzJOaE1Ecy9hZ3NLZ1ZBd2hZbjY1aTErMExvaW1G?=
 =?utf-8?B?ZzQvWTBxVHFwZDJDVlBCeUdjVitZVEdBL0QyZjVjRnp6L3VpQXI5VXg1YjZi?=
 =?utf-8?B?anVZK2t2Mk85cktWVGNVSEJzZk1UZGxYVXMyU0dNOTJtRnlyQUVFdHhTdTh6?=
 =?utf-8?B?ek1jWG9IWkxXWXRreFpJc2FmSGdPb3hXSHpFU0FIMGdiOThTOGtLd0didDNT?=
 =?utf-8?B?QTl4ajBnT3FZUTI0WmZGQ01KSUJOdkVJbld1TVJEMGI1LzVQMTZnYmpseERt?=
 =?utf-8?B?a0JTWUQ2TVdSR2ZOdG5GOWhNZzZoekVNLzVFZElhbE9uQVdLMXFkRHBTRW1z?=
 =?utf-8?B?aS9aZTV5RHluMERnajFLb0poMW9QeVd0M0NtSXBlbDdjNCtjYTlaNzZNUkZm?=
 =?utf-8?B?VlM3c3BMcExLODRndVo1RlZlcVRZSWJjMlhXbkNnTG1YTmcyLy84enBvNDMy?=
 =?utf-8?B?Qm5WaXk5UWViNlhlc0RvbE9Vb2c3aWI4NzlQK25oR3ZyVVdObXJXQ1MzY1Fn?=
 =?utf-8?B?c2xIbkxtd2N1bTFvamJUK1EweGh4YlorTTdHT1ZEaGNvTVJTQW9xaFJtckMx?=
 =?utf-8?B?STQwMGVKdm1OUVBsTkdFUGgycUdKN1psaVVpOFJHeEd4QlAwRi9RNVhVNVB1?=
 =?utf-8?B?YldJTU54T3VhazVDTTZMU21sTVFDZWhYVWI4VmdEYkxidXJUNWpFRUdMc3Bo?=
 =?utf-8?B?MFRJbjN0bXJOd2hJTW5Md2tpeVY2OW0vbTRnSkExUHJuemtWWmY3WmxoRXZV?=
 =?utf-8?B?ZzZqdElPdldhYWZkUW5KMWE1czFjQWc2V2tEdUdOakszcGZCSmNLMzUwL3Fq?=
 =?utf-8?B?a3M3OW5UMHo0bURlbDVIVENGNW5LMjFmaVhGeGZOTE9KRVJDNGRyckZzOVl5?=
 =?utf-8?B?UmYrc1hpSEsxRUNhU0lIdWNxQmJDdytnenk0ZEFpenlLSlVWMXNlM0Nod2tu?=
 =?utf-8?B?bFMwVDZ6d3dHSVhsTVAxend3RktLS3RJS3pBdzJTc014L2R2YW80aGUxK3Fu?=
 =?utf-8?B?dVAxdUVsNVkrSmJ1Q1JJeFdobW5XcFhxaHltM2pDNFpndVJJMEdweUZjSmFk?=
 =?utf-8?B?dTdmWTJVQVIvSGFiQ1lXZUMxRFQ4Q3lRVG5JemRzaGZSWVQzUW0rc0k5bUJh?=
 =?utf-8?B?Y0N6YXhsV1l4R0J5QmcvRkF3MWxUWVpMZ0E4ZFZoc2trdHYxL1c3VVZWSkNR?=
 =?utf-8?B?NUtuOHRpNHYrMWswSzhyUmEyd1d0Wm9lYXlWd0tPd1lvQ29URFFDT3Zidzda?=
 =?utf-8?Q?Nvkh2Ki7YEk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4P195MB1456.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWpFOVFUYzg3SUY2OHpjWUdnRFZZQ3hMTHZFVHRqaXlZRjRsbjgvaDdFaEM4?=
 =?utf-8?B?VjhmNEpTTVJ1V1JNRW9RZnliZnVnUmpqdTRJd0RtbSswMjBjUWRhaGE2dmY2?=
 =?utf-8?B?SlFCQnhTaGIrR0UyM1F5ak9tM2crejR2ZnhtRENpeEM0b3o2QnRFSFh5dDVW?=
 =?utf-8?B?ekJFc2ZrdTVET244eTJZUlovMUVkMDg3SjB3V0RVYkNvQUFyZUtmU09VWFY1?=
 =?utf-8?B?dnJyTER6UjNXd0ZVWGhMa2pIQ09XbHJ4Vy9JR2hmQ3pUM2NsMGZab0N2OTNt?=
 =?utf-8?B?RWxCUWtjalQ4OUhOelFKRGJuL09sWXZzMGdEY0t0S0hjUGlXZnNEenJYUjBI?=
 =?utf-8?B?MzhaclJsVzFyNmhYNklKa3Jpbmh2VlJTNTNwekQ3MUJYNzU5RUdQWDRzeWc3?=
 =?utf-8?B?ZWgxUWZscEJjNStTMnpPN0loY0twZE1EMTVLMVpzMEY1VW45MlBXYzk2cTF2?=
 =?utf-8?B?TnAvZjNvK252Z2hmS3VxOElJbVVHbDNTenV6SnJoZzBnWWFLbkk3c3JkVG1w?=
 =?utf-8?B?ZmZ4T2pXSXN5bC9IWE5Bb2dEQkdUL0tvLzBUajNoV3FzYXVYUU0rcDVFZGpW?=
 =?utf-8?B?L0E3WHo2Q2NFaThQQTJFaGZOd1hNWUVENDJEZGhGZU1FemNlTEExeENpMUN3?=
 =?utf-8?B?MzlVanZjN2gvZlY4VmwzWFJCU2h5cG5aRmVpbFM1OStDZTg1R2grcWcrellJ?=
 =?utf-8?B?cHBIWEZoMWFhYU1HTFBnbEdyaWlVNXgwM0ZhZnNpenBINkd6NmxhK05Sd0lX?=
 =?utf-8?B?TUlhNnkyV2FWenpyQ01CMzl2WHo3ZzBZYjJ1a1VUeGNWTTgwblJEbWFkTC85?=
 =?utf-8?B?MVoyYjVrMHlpc285amoxV3FveE0zbXJkcHMvSTEwUFI2SGhlMi9xZHJGWEdL?=
 =?utf-8?B?TWhCbHpnR0ZOMTlWcy9YWnJuNXZOcDcwUFgzMDIwYVF3aTlzekhMcU12TVJK?=
 =?utf-8?B?eFRReGxzRzQ0T2hHWFVieGdFL2RITUc5Wmp0VnpjeEREa2ZtMlFRNHdwQjYv?=
 =?utf-8?B?ejA5MGpNdVBNa1B6S20zU0Y4Q3lDdGJmTUNRS2duKzJCTUJHTnJrTVIyb2NB?=
 =?utf-8?B?R1d1Ymtkc2F6YVN4OFJ3RWpNSUxmVm9iQzFyUXE5TG5GaEVUWlN4MExJdEcv?=
 =?utf-8?B?ZVRBOThPUWJUeW85Y2lMNE1HdC9JWlExUytRYUNJVCtySmhweXNuQktNYmsx?=
 =?utf-8?B?WE93d2thWVllc1Y5RCtPTllVbGVUS0JGK0VteFhvTWNUa2hEMnJ4QWVPYUpn?=
 =?utf-8?B?b1VGRytXUTVpMEc2SDZ5ZU5ETkVzYVdZbUpVdTM4LzM4dk05bzQ5WGJiczZT?=
 =?utf-8?B?cGl3MTZNbGpEN29xMU1EM0tSdjF6VVF4OHFXTGZyUWZCNUlLd0ZERG5tdmNC?=
 =?utf-8?B?ZHdjYmJ1T0ZxOE9nK29zZWhmelZTc2YvWWZ0RHdIYmM0a1lUaW0vb1Bqc3pW?=
 =?utf-8?B?VzJMWG9sclpzbkRrdmNzRFJuMlVadTI1Z0k5RkhmUzFpTUJ6Uk10TlBaSnIy?=
 =?utf-8?B?OSs5NFlXUWtCdWFQV0ZhMGgxSWQvUndWQjhIbkNTSDFIN2VKVUdRTEh2bllX?=
 =?utf-8?B?am9MUldzOGxNVEtHWGtqRTRWNVNFSW5yS25HMC9WVlRBNEVSYjVPbC9JSmpo?=
 =?utf-8?B?SHc1RUdzOWtyT1NZMlYyckhrT2lDVEd3WXJMeVU1ZjJIVkd3a3kydlBIdjJz?=
 =?utf-8?B?SDB1WXhxUjJ1L1ZtcHpuSUYvaVdlTUQxc242UDdCSGVnem5McCtaeW04N0RC?=
 =?utf-8?B?TmJDWGZ4NEo3aU1IMUkzZ2pFZWN2L25yYWtSY2NoejBPaityRFpmRzhQRzJ0?=
 =?utf-8?B?T2tCYWlLVmVISUsxVHZiU0xLMmxnWmlBVVl5L3k5RlBUdUN1K0RERW55QjJM?=
 =?utf-8?B?dS9ObUtuUWwvSEZUenJkYkFFYXVvU2hqdyt3VnhLMERtU1NiMWc1d2tvaXZj?=
 =?utf-8?B?bmZpRkFDZEZrRDJrMkZHT0lraURsOHRMc1FHeThUaDJLVmpyYThRZ2NYRS9q?=
 =?utf-8?B?ZHkyd2NSQTlIQlRlR2RrbU5OZUlvak1KcTByb0FQSkYyU3JFbjNVVTRocHEz?=
 =?utf-8?B?Q2ZxRFpuVnVtbkpsVzRWWUxDQjV2aDlaNnBBN002SjZkM1FEVTlMMjYvUnll?=
 =?utf-8?Q?5mY5e4mBADRCJ6A3Ry+wVK6YD?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c9ca54e-8261-4e07-a638-08ddda6de944
X-MS-Exchange-CrossTenant-AuthSource: AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 13:32:55.8462 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LMGd4WJh5UcMjpNDwKhMvJTPEB35lswMWl6KX+ZI2C1hkbRIP2fQGuYi9ucYPGvzn0MvhvATJykrCHZJyTzKqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P195MB1258
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

Hi Martin,

On 8/12/25 3:38 PM, Martin Schwan wrote:
> The bootmeth rauc should scan all partitions, in particular whole
> devices, and not be a global method. There may exist multiple RAUC
> systems on different devices and they should all be detected. This also
> fixes a bug, where both a global bootflow and one using an actual,
> complete device would be detected at the same time, when scanning for
> valid bootflows.
> 
> Signed-off-by: Martin Schwan <m.schwan@phytec.de>

thank you,

Tested-by: Wadim Egorov <w.egorov@phytec.de>


> ---
>   boot/bootmeth_rauc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/boot/bootmeth_rauc.c b/boot/bootmeth_rauc.c
> index cc6180221ed90934801ebd801a7bd1b3fc889aec..7c1a895139e8116054e6c331fc0acd967cfbc7e4 100644
> --- a/boot/bootmeth_rauc.c
> +++ b/boot/bootmeth_rauc.c
> @@ -410,7 +410,7 @@ static int distro_rauc_bootmeth_bind(struct udevice *dev)
>   	struct bootmeth_uc_plat *plat = dev_get_uclass_plat(dev);
>   
>   	plat->desc = "RAUC distro boot from MMC";
> -	plat->flags = BOOTMETHF_GLOBAL;
> +	plat->flags = BOOTMETHF_ANY_PART;
>   
>   	return 0;
>   }
> 
> ---
> base-commit: 123cd77122a13288e1552b5d9b7c22a6f19e2e02
> change-id: 20250808-wip-bootmeth-rauc-flag-any-part-9d5c609291c6
> 
> Best regards,

