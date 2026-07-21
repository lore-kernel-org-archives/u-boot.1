Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5982FC4451C
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 12:20:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 899C44094A;
	Tue, 21 Jul 2026 12:20:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id THhGbIU89egq; Tue, 21 Jul 2026 12:20:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9AD1340902
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784636431;
	bh=TJ11+TfthnObayJ5sqVY370w/1SEuwJ0BHxLL/hwSnA=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=phru7KY5VG2Bo/t74BqJdoDNnpNoU8HkNAavkNj8QJ4B9K5yG6WjRju6VDfv9EnPP
	 3fVOke1W+HnqsAAyoEuxAjIK8Aii0XOTB0NGT1LDU6rMSgYvG1chqtpruKUtMvMS7/
	 Ck5c5hv30DXFHXiPanjCd+kZm7ZTdm4BkCIpV3zi4oBXbCMCCFRbtWfzGMjyisWF0D
	 uDlQZGa+91saD9Myqxc4JCzaYr+QuhYg/0myq3lgKkMEjr72fhTPEkAk36f8BgPTg2
	 d/Spwh/BQ/b9IsiSpumdSSG9DJepSCk/TyTVidsnzsTda06Y8+GD6iFiXT1nKVRG2D
	 EQB7Q2H7mpnfA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9AD1340902;
	Tue, 21 Jul 2026 12:20:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B9EEA224
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 12:20:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9F73580DE8
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 12:20:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0M9z1zeoDQlJ for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 12:20:28 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 7069980DE4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7069980DE4
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7069980DE4
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 12:20:28 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id C003384659; Tue, 21 Jul 2026 14:20:26 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDC53803F6
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 14:20:24 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eiWGaR3fAWBQLxE3lzgRu/cLlzCcG5ezKHyS2PZzP7Wq+8sIJx4zjCiJUSmkjRZ+CW42b64KKqb12QqgohTTTt+ibgkGPzT+a+zGN0mE3ld84B8UFI/6/GZCut1cLIf6wi2yzDWb36/fZAM/kAJi9QAtEvX4VsoJGr5A8ejaXc5T+SOFiKPeIn+C4quton1/bo/Y8T9AsY1jy7sDli+K039hlDV87ajO1PZfFxYxO39QvxPvG9owXvrG5O255v5hw52BRvT1SeWMglD1L7QYIunaml7b3no2kDEV4YSiSktR/dsFsdxo31Nxa61q7X86jDYIpdEiBCubcOsyoQkQLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TJ11+TfthnObayJ5sqVY370w/1SEuwJ0BHxLL/hwSnA=;
 b=p9hr7LOivbpB9mbopwIPdb4Z0wkIE5AalxbiqUSsykd+U9KxCDF1FHsRpx1zTicU/tmkfmqTKkBk55POCx1BYVjvZhC+f/6FmomApdk8C1QfS/zrVvHh3hDDx2nSvsJuFw63BSxq8NlFzr75XmAsFgU/laxgE1Jdr5e0tcWincFHbe4mBhR/kCSGNlMPtDvrOL2oQnumAGmzXRrOWYb4TrJkrZ9v801WBS4bOkWpYSyDHS4pQHgyhPaF1yZHOvzKfYcHzBfQHgemPVBeIdcYREg4DiK3kZN3YKoStj4fsYKz1mV05pf5u1lg3Horeo7XLTJKJ792d8ZVe000+6OWXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by VI0PR04MB11022.eurprd04.prod.outlook.com (2603:10a6:800:25e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 12:20:21 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0223.012; Tue, 21 Jul 2026
 12:20:21 +0000
Message-ID: <153cd45a-b62c-4d3a-93dd-0dc94d74ddcc@cherry.de>
Date: Tue, 21 Jul 2026 14:20:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] clk: rockchip: pll: fractional PLL coefficient is
 two's complement
To: Alexey Charkov <alchark@flipper.net>, u-boot@lists.denx.de,
 Elaine Zhang <zhangqing@rock-chips.com>, Jagan Teki <jagan@edgeble.ai>
Cc: Lukasz Majewski <lukma@denx.de>, Simon Glass <sjg@chromium.org>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Finley Xiao <finley.xiao@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>
References: <20260713-rk3588-fracpll-v1-0-cdf47f2ca0b8@flipper.net>
 <20260713-rk3588-fracpll-v1-5-cdf47f2ca0b8@flipper.net>
Content-Language: en-US
In-Reply-To: <20260713-rk3588-fracpll-v1-5-cdf47f2ca0b8@flipper.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P194CA0047.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::36) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|VI0PR04MB11022:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ce16a53-3a72-4ed7-7ecf-08dee7226f1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|1800799024|366016|56012099006|4143699003|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: JZy0mF96PC9tWSJ03sJs/J/RM4Dgl9qK2m6QUGSv1eZ5X0Fraldue4qLULdma0fSua3s6gaqluk95GWEzwj8o9cDg0z32A/EWmd+IUJXOhosPOnf6Ot1j6TXw+VUh7lIsRN6V980dlF3aqhXoneUiSePzPKsfhxpm5Nry23sv2P/ZintuwFm2mV7lE1zEdybNq6arkWOC9g63GMZTDZsSB2/VssrKBfTBb3NT/hy9FX134hG3d7jU1tQB5Yh3ZzDWNVTnxJxh41/3Q/8jamMPNza4lg4IEyiTeGF6Drx1GsU+yRywXfkbjPza1CbnL58mVG7Q2lm4AxMGhG2VQHyEPnlGf3sFjQY9wlWNymGXnXdrc0SuRVCWE9qRtA/B65hR5RNleKbGVHPDZfV1eLuhXx4FUhzwPNXoA6LwYUWhENFK7tAFU8UpwhUbcWF4gOTDrYgZ62A58x4y1V/ypkBM44+x5rTDKja0lAt/iYEiAt74D6wpTYdFuuDTVA/lTsA7IFipEot+/kOBM07QZQvuHidM0N6q8UYOcsoWZZsgyJMpBVRNn9GBJ7OA7AqgerxnkfnXVMRj3yVy46DohyJ7rdPRdEg27cjLPnOO6kCiKKC4U5op9JVpkXYQUswtSt1517soJFvBzt4ifvf60PfbE12HQmtvIz5fQXSZXKfLW8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(56012099006)(4143699003)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGY0Q0k3ay9LUG5aUExRdG94cVlveGtnajd2REVxM2dBaDRmT0xEQW5uRFda?=
 =?utf-8?B?bm14QkpsYk1ZZDBOQ2Fyc0R5YnQ2L0tOOXdvZDJ6aDJzR1BRMWRPUktESThI?=
 =?utf-8?B?QlMvaUFSK2toclRXaE1zZGd6SFB1Z3hlRkgwbERiOXBPOGoyQmRwV2xzdExp?=
 =?utf-8?B?ZzdCUVZDN1J2Y3NEOVpyY3VWQzllV1Jwbkl3dndRQldlNlNNQ2Z1ZnhPcjhn?=
 =?utf-8?B?N3Q0RkRXa253TWxFU2pNSTFNNmpDR3NQa3JuSXRFNllwS0ZqM2pUaHhjUjRS?=
 =?utf-8?B?RFVRV3FVM1k2RWJRMEpDUzdkdmdtWW9nUVMvcEhWVitVajZEQnQzaTY2c2Ro?=
 =?utf-8?B?alZLRHRqQmtyUFRCWUtwRVZkRCtRazdjazQ5SFRtY0YrMHVFYjBJemRLWW1N?=
 =?utf-8?B?WUxoR2duMXhJMURVRGFtNVdNNSs1aVd3bG1LR2twVmF5d3YraDFTU0lFMUNj?=
 =?utf-8?B?OHFXSDY0S25rY3UrSmZPMjFMQncwOGRhSmZqYWt3ZkFyWVlLUmduUlBCakVj?=
 =?utf-8?B?ZndrbFhKREZwaVNCYlNCbUI1NVNoYUlMTkJnbEQwMWEzRWF1S3NhZkpYTUQv?=
 =?utf-8?B?eVlzSmVBbW9ZMlFxZndtNnNTcXhtSWlDYkwvL3l1RU9zdHZSUC8vVnRWL0RD?=
 =?utf-8?B?SGowWXVjeE1ySGtHQXNKUi9RQ2lFSGxhbGU0SVVXcDBJd1pHeCsvQWVpbnlz?=
 =?utf-8?B?c1RpZUY3dWNGd0VhRmxUOFJxZEJuTVM5ZVBNdWJDSi9BUGlKUzcwb0grVllU?=
 =?utf-8?B?QlhlUFgwQlh3WHpibXd4UTlJVjI0OHRhZ2s3aFpsRFYwbGxHMy9wWGxGTlh2?=
 =?utf-8?B?ZGhkUlhyMzhJMFZubnRsTHB2ZDB3SVIwN0JGWFEwSnpLWXAxS3NHc1VCb09j?=
 =?utf-8?B?ZkU4L25LWXVNZnJDVnE0dnIyODNSMUs1NE9KSTdweHQ2elFqQWJoK0RyMnM3?=
 =?utf-8?B?WUNDZUg3a3JzYVN0YXdaclJtV29hVm9MQi9Cb0hOT09ZYk9LN2wwTjVKZ1kr?=
 =?utf-8?B?SVdsbGo3bWlDZm1VajZ3YW5zOHdCVG5iRTUvZWVzc0F3QVVSa0JqVDVYZmlH?=
 =?utf-8?B?NzRKTlJydzkzSTFJamN3clNpeHlocXJYSWFuWGE5ekdYR0QxUnFoeXIvTHJl?=
 =?utf-8?B?WGp1NzVDcXpVSlc3Y1RuNDhxMWV5QXFUVkFFQjJpMU9WRUp2Q1pxbjhlNXRW?=
 =?utf-8?B?TnZtTlRSS2JTTUc0bGFtT2pOcDFpMzJibHVFQUhtMlpPRnhuV20wby9nanlm?=
 =?utf-8?B?VDJxdjdnUjhuTWpjTlFIUk9UVEVVc3EwYk9qSGlFMnA1NkRWb09tb3VjTyt0?=
 =?utf-8?B?c1Z4WEY3TXRGNDFMVm5HcDN4U0N4RFpTcndxWmtxYllZMHVPdGtvWnBxMElm?=
 =?utf-8?B?cE1qVXBpQVNTMEhGbklROXZ3WkVwUG03ZGtiTFdRQ3VnbjR5UWhLYjRPaE1C?=
 =?utf-8?B?cUFxUUtTMFBIRU04NDlNZGh4MHdJZHNLa0hkaWtjcWNJQmFPQjlSQ09jYTRG?=
 =?utf-8?B?d1hTY2F5UjVYVVoxNWZPREhqKzJBSUJORnhyc00vK1FZaVY1MlhEOHpoWlYy?=
 =?utf-8?B?TThSRnJxYXJlalM3YUczbnpCVUhMWkJjYWFlTTgvTzRNQzNtWEFEendKR1VS?=
 =?utf-8?B?UWlPZmxhUE96VFdHZEpoS0JqRy8xOFdkSzhkaGo5Tk15V29rYW5lbjJralJL?=
 =?utf-8?B?R21WZVdCK05xODVSRzJ1b2JEam5EbUlobVcwYU1kdWhaZkRQUWlLM3RTNW5I?=
 =?utf-8?B?WUJscGk0S2w5WjJVaXFNSy9UMDljdVAyZXBza0ZBRk5sZ0lkb1Z2enRrMStK?=
 =?utf-8?B?WUUyL3hDYjlOQ0RwZE1pa3lzZVVhVjBYTitSWlFuOEZBSmlrUkdZd0tFemQr?=
 =?utf-8?B?dEJZNHdZY0w0azg1bDlGYmVKczExRlJnNVhuYVdiMjZNd1FlY3cxbllQOG1r?=
 =?utf-8?B?VkNuaCtFdk5wMGYwMXBPQWcyak0xYkFreWhKL2s0WXRoaGZOSkhRRDlmRHpR?=
 =?utf-8?B?aktwYUZHVzE5L1J6WFV4dVFLdzlOL2xXc1lxbndQUW10SW5JSW91VmlpK25u?=
 =?utf-8?B?L2JITkhZNU56cVlNVXUxUVZBVjl0eUpaaHU0THg1KzRsamFuMlUxRnRYSG1p?=
 =?utf-8?B?Q1hvcVEzSlM0UFdSbDFya3ZuM1Q1ODlXRDlnZTV3N1BycCtaSjR5UFFteENk?=
 =?utf-8?B?Q2VFTjl3USt4QzcrY2ZTSW1IQVhRQlR5OFJHRWIzK05wU09xcTFOaVBjMmVx?=
 =?utf-8?B?MlpDdzE1YU9nYWhEZTlZb2hjU0FyWGQxMjQzN0VCa3RsV0hwdHc5NkU4OWFQ?=
 =?utf-8?B?MGRQZWNmbGZpZGQrb1B1U2dySVpzYVRKdExtQVpvdC9TR2tvS1I0UT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ce16a53-3a72-4ed7-7ecf-08dee7226f1b
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 12:20:21.2970 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k49t2yFcfps2W4m0w6lUiOahy8mc8zuWN3Z78v1tzwe2krvJ797Q8fTa5hRunHJlK784t5NDvbahUhIwY6Ar7RlGzNBN2DuvZosdSiAPjh8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11022
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TJ11+TfthnObayJ5sqVY370w/1SEuwJ0BHxLL/hwSnA=;
 b=CMd6Y7ob16b1Jf7d622q8RHigGh/SPskAVs1yNOR8qnX0du9E2h65Z9nTxImiWCHhrV6JwDKwhUScypCe9Ygo5fAtAjhG0zqfG8qermJm431BNxH+KXQotUp+/UHDpe65EeFUTB9Sr1u+qTGHCdMXGLCbj/sxpCXdiV8ESmTVl4=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=CMd6Y7ob
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@cherry.de
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=cherry.de header.i=@cherry.de header.b="CMd6Y7ob"; 
 dkim-atps=neutral
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
From: Quentin Schulz via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Quentin Schulz <quentin.schulz@cherry.de>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Alexey,

On 7/13/26 8:35 PM, Alexey Charkov wrote:
> The TRM defines the fractional PLL adjustment coefficient as a signed
> two's complement number, 16 bits wide, so store it as such to avoid
> confusion.
> 

Yet...

> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---
>   arch/arm/include/asm/arch-rockchip/clock.h | 2 +-
>   drivers/clk/rockchip/clk_pll.c             | 3 ++-
>   2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/include/asm/arch-rockchip/clock.h b/arch/arm/include/asm/arch-rockchip/clock.h
> index 95b08bfd046f..f9bfdfb8a6a3 100644
> --- a/arch/arm/include/asm/arch-rockchip/clock.h
> +++ b/arch/arm/include/asm/arch-rockchip/clock.h
> @@ -104,7 +104,7 @@ struct rockchip_pll_rate_table {
>   	unsigned int m;
>   	unsigned int p;
>   	unsigned int s;
> -	unsigned int k;
> +	int k;

... you use int here instead of s16, any specific reason?

Cheers,
Quentin
