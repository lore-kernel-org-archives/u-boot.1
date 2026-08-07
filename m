Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61FDFC2A09B
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 13:20:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A8E8060A71;
	Fri,  7 Aug 2026 13:20:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mGEsMkfKUOCa; Fri,  7 Aug 2026 13:20:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9717760A39
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786108806;
	bh=ca4XozP1ttFKwEMx9RJDVRcaQaTJWcOWB/W3qYazqsQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OjFARnjRR+jdZKtdU8WxlINPQ3MptrAaWU1qhcbPobYlJUDzRgPHZGlSO7b+HR/cz
	 ddOz0thV16He5fRLGufwn/zAlSxQXclt5NeJs4MoxvPQDeKOty9OL+6Lys487neLyL
	 r7+KwlunyhLxEgcvrXLrc16MIyC+C9QIbMrtMx9hyGIhHqUKIzO8mpAu3Paog6v5Bu
	 5c5cD/P/C+CKJmrXZExF/KnPl5c7k8hftwXDG6X7yaOFI1u7PgXBTLn/BR48o8Qf/e
	 Vlv3zYiXnUmA44EnEbUXyCfBQb1o5nnW5HGAF5y219tp1fZHOpK9vAOFpuf1WpmDWP
	 aXT0k4k7U3PYw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9717760A39;
	Fri,  7 Aug 2026 13:20:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id AB53FD3
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 13:20:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9D2F040207
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 13:20:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Tu567gXAbitK for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 13:20:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org B6E6B40074
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B6E6B40074
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B6E6B40074
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 13:20:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n1Cc6Gv6VcaTPI4iaAlIWjKFcH3PV5i50Jdur1h6c9jBMzP+xW/ecxQBPUqSJZwcHauYbglmPiFNtr2ZYsj+tyJBlDPu6i2UbqL9WRRxWy5OY4cG7U9snDnXag0kgxlL752BvmJQhrMS9bB5SG6kE1HT6DKQjqju7+QjXv5aGb43M1J6uVmHzQH1p91QIiHLTyoYssphKe/3GIi6GCRFDj51sF5e/k0OuZYi3C82+cm6eL1eVY4ofExDH8q1UUvj8Sny8r6Y8cWKewn52RDS8Oibka3LKbPgVxMLbBMOreCyljJW4nVplXinooKmIXeDygl8U2CPJNw3UJvu0S3rRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ca4XozP1ttFKwEMx9RJDVRcaQaTJWcOWB/W3qYazqsQ=;
 b=O8ikd4/Q21jzoO5KGhVE9Tw6y6+mZGd1fRQrckDqGQi7/9lv70fEyY9w8S7um2dm13URJ35pTbK0B8skyA+3Px8fQnzTqpoYdvTGqgcLQJputT9XPb9eKF4o7KJjAxS9svTvgyx5eDW2U678kffhjF7hOgwUDLlzKkFOkWbBJeVEwzWOBNSDFYSH0yPiufcPm36puwZNZ0R4wB9E7xQzr/VptnGRzL6zHR1twbxT/zHHC31MZ5h6hEZV75ulD+YXIBSobT+gZkLi/6GYapU8YXf/SFMHW9jxjnpWAib3iD5ZSxJOzRuXRyF7YkOTiWZYKchwyChvNqrVMSQHOI34HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com (2603:10a6:102:b8::20)
 by AS8PR04MB8628.eurprd04.prod.outlook.com (2603:10a6:20b:42b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 13:19:58 +0000
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7]) by PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7%6]) with mapi id 15.21.0292.019; Fri, 7 Aug 2026
 13:19:57 +0000
Message-ID: <2ea33062-459d-4d72-b85b-46c7b1fedde7@cherry.de>
Date: Fri, 7 Aug 2026 15:19:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/15] clk: rockchip: pll: Fix double use of postdiv1
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Lukasz Majewski <lukma@denx.de>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org
References: <20260730141308.1218014-1-jonas@kwiboo.se>
 <20260730141308.1218014-2-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260730141308.1218014-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR10CA0100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::29) To PA4PR04MB7743.eurprd04.prod.outlook.com
 (2603:10a6:102:b8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7743:EE_|AS8PR04MB8628:EE_
X-MS-Office365-Filtering-Correlation-Id: ae5ca653-30cd-4d31-5f4a-08def48693b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|10070799003|376014|23010399003|18002099003|22082099003|4143699003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: RXTf70ERXqhVIwGywU5iM17by2BXD0ixxpFCdJXdV/SJMGnIFDb7zFYJQ+GfElmE8IOsKjWcU75DZXEnVbiw0m6+EotGgEXmVzV+GOAUETQI2mf6ZB8lCQ2qK/0taSIAXKhFBpBREqNEaIhmCBAkxR38a8WnLQMqMoOlLXgnYfIiZ1zyLA7JIKj+SmkMulp86hK3o1+F9C2bN1eTpXiegBa8JHsv3bxUUCWz52yxJaP2YtiJEHCajBXm1Di2dTPaVm2q7kb3wtcnh+p9tzu9ghojH+0KFn9D6rvY3mx7n24Wn663DxTxAICLoesJRyEZjzRKDnj91Q8thaAS6zAmntbWsu6X/V7YemtLQTzRBavyTHU9J+V+j76Uqug5NqtzhpGmh/9r/4JTkpL3NfRCvXSmqH+OgQypT8nirtM436NDuevZrRCXJdr6Kdc37ej3jaivYVbpEsr0Qwb29ThNgSY4Z1WbAm/wndHZpLwcf1WAXcOamJBntP26egDND3UANJ+++dtTvfmbgAoaScANVhaWJanWAyf6CxEKPDFROyS8ZRG6RBKv/pk2zjN/ljLl1CIpRddjtYjJnnxRVATPx3DS3H7GMXANay3tLU/7OuUkps4U9iN2PKeUpKnSVnvjplIKIEvIn8eCcoG9sPL+ZSJPkxEUUCtFdS3m2VPCB9k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7743.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(23010399003)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlhwWkt6M05WT0pObzdsZkM0ek9MVTV6eFg3S0Y5WjZsWC9XWm04WktScGNV?=
 =?utf-8?B?UGYrYy9WN0ErNGgyZHZ0U0JBNEZJN1RaR1NkRjBrOUJ4d1hQL2h6SVJ5eE8v?=
 =?utf-8?B?by8vTS9YTW80TndEVFRFNUt6ZWZUTmhNVjNlNmtaOXhaV294RjVFSHV6aUxJ?=
 =?utf-8?B?NlBrWVZyZjhFaDVFdW5SNE5jWG5yeFJtTnUxcTU5eUIyTzAwSlhzcGs2cDZR?=
 =?utf-8?B?eERSYkpGWVlvbW9uTXpaTGdxS0dYNGVnNndJODlzNXBUQURYYzd4QkMrQXVK?=
 =?utf-8?B?WktwYWNyY1d4N1JOQUp5Y1c1alIzLzRua1dYM3BCbDEvaHpMU0MvTjlCckpJ?=
 =?utf-8?B?TUZJSll0dEhHWFlRM1RkZFUwQUdjbW96d1lyWGRmVHlVR3pBcWNGcW9ZT1ln?=
 =?utf-8?B?V2lFREVtK1NDbDBIbWR4bnFadk5aajFRcng4NGlVZE92ME9TME1hcmMyKzQy?=
 =?utf-8?B?L21WbzBJUkxkeFZxMWtLV1Y1QWxFVUJjdTAzNlJNZytMaVlNOXp0KzB2d05D?=
 =?utf-8?B?blY1WUQ4ekd5L0V5bVh5cVJLYzVtVU15WGJuRVExakZSeXRNMDZNVkoyK1RG?=
 =?utf-8?B?MjhyVFF6RnE0bXdyNEE3R0FkYlp3YS83eFBNUnpDbFdEVEN5eGhKWFFiUjBv?=
 =?utf-8?B?N1pUMHg1aS93MGlZYmdvb21vS1pHdXhFWW5zbnFtZ1pJWW5lSm5QVWNsZnJk?=
 =?utf-8?B?eWc4U0hXQStLSkUyNjcxd0JTVWZTYzRocE9ZZnRVSDFpYUppRDQ4ck9jQmtL?=
 =?utf-8?B?cU5xZTUxOUxVMTBUYTg4L0pBV2IrK2hvTzhQREI2Rk5zajZrTStVL29HVFlr?=
 =?utf-8?B?ZFc3YjYwUzJQKzdmYzg3UGRlcVFzSWRrMllmZE1KdmJpcmE5K1BGSTQ4U05E?=
 =?utf-8?B?VDBaL2EzZkZZSnZVdTVYdU9ONndVcXF4Mk9NN3RwU2NQUE94TzV1M044Yldy?=
 =?utf-8?B?TW9DM0YzOWMzV2JiL2RyOVdZaUlHSFJ6WWpuMU5jQ004bWMxMitFTVM3clg0?=
 =?utf-8?B?cFdCWmVDcTF5TEVPMUNRR0JoazQ3YnZ0SmF6TTZFWXdCVThZTEpGTG96RnZL?=
 =?utf-8?B?RFJ1eTNzR3JqQVFxZkNRdm1jQTloVzNDRWZGZDU0cUpFU216dFg0bjZ5UmI1?=
 =?utf-8?B?K251TGxuc3hMVjhMRkRuQ29ERlJCWXpBaTU2YkZWaklQcUVnQmZRODBWdVdK?=
 =?utf-8?B?dlJ0YlNrTzJBWTRGdzNldWNCOHdrVFVPeFFYbzM3cER5RHNmVUZmbVUvb0Yz?=
 =?utf-8?B?RVVzTkd0NjNYUVAxbTJ5b2ZYbVJPZ0NRQ213VDJFSVkrUTc1MlgwQVVsZUdQ?=
 =?utf-8?B?dWFGcnRJNkgwa2U2UWVnenFOMGtSbytSRTF6UHlPL0ZIbGFETFVVSjRkL2hM?=
 =?utf-8?B?b0JXMzVSNCtEV1JzZkx3Z1NEUDBaNGRHUEZYbURZMkpBWHFnUlpEVmdFNHBL?=
 =?utf-8?B?SjVWR2JSYkxqRUxXV0RGOTFqamV0TThPb1ZLV2Vob2NUQklKOERhTHBVQnB5?=
 =?utf-8?B?NE00MDhSK0Z3eitHcXFBQ0twN3VxOHkxYTh1YWwvYnFZcnZLNG4zN0VqNUF5?=
 =?utf-8?B?OGo3QjdJZlpQUXNDN1FEaG1NVTlseDhxVjV1RDRHb2M3L2tod0pRZjN2aEN1?=
 =?utf-8?B?dFErK1NPbUlLN21YNFN4ZWFkSFRkajFBKyt4Zk5lWXI4bzBxWGZ1TVhOTVVV?=
 =?utf-8?B?ODdoZW5SSzhEaFVMa1V2L1JzSmFPOHgvSDU1ZEozMzRncGhaMTJkRnl2b3Rh?=
 =?utf-8?B?elhyMXY2S0I2NDVvTENmbHEyOEtlaENqK2kwWXUwVWdpT0pkOHN6UDNkKy9S?=
 =?utf-8?B?dXNIK3lVUm9aMUF5K1UybkhSa2pZV3ljVTBTeVROY2xHRHFpRGNBeEIyN28x?=
 =?utf-8?B?UWdCTzl1TnZ3Zkk1MkJ2N0hDdUxTU0VlQ1V1dU1QSERRMHlkZnZGd29OeFNG?=
 =?utf-8?B?SS9NM1R0eXppQTNMSXM0VFRlQnI2UE1EcHM2aStpdjVOYk5BTklPM2pKRTRP?=
 =?utf-8?B?VlRQZHFVWmtmNVdSQXVlTVhHYzB3Skc2TEhWdkViU2dpNWRRNjI0MXhKdHVH?=
 =?utf-8?B?VEJpUytuVUdialBlVW5UTGdpMGl0UDBpZmhJTzcxMG1pWFVLQUNDc0JkUVFw?=
 =?utf-8?B?MTFxY3pURWRTNFpyMG1tdlpoOVNyVHZVQ2UzbDF3U3NhWnA4YndCNHVvNVBX?=
 =?utf-8?B?OTBTK3l1WGZLbjZRNHVMYlA3TEh5MEhxdFdDc2lOL0RWZ3VvMlY1RWJoUEZM?=
 =?utf-8?B?WGxRenhOK0J2MGgrRmpsaUxYNVFnRUF3ZmhHZXFaM2g2SHhORlpERWMvMEJs?=
 =?utf-8?B?QWF0NzR6ZkttQWJyT1FzY1N6QU1kdjFua2JTTWNXMFlaUGNaczVVZ2d1MHRz?=
 =?utf-8?Q?KioYfXIQrwOGZkWthDbs5Z/LxAxAPQXh/Tnf984xZVckE?=
X-MS-Exchange-AntiSpam-MessageData-1: UFp3PVlCFR9WFA==
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ae5ca653-30cd-4d31-5f4a-08def48693b4
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7743.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 13:19:57.8922 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dhBhQXjO1QzdHv6tznzysbid+bvSpiwVpxnS2oiwZfX9YrgXazHjIlkfGJRi5I7vmN+/HeCLloevraMI//UtNvGDoa7BQWUrqauqP6EAU2U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8628
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ca4XozP1ttFKwEMx9RJDVRcaQaTJWcOWB/W3qYazqsQ=;
 b=KMLdD75/N/dlXCJWuGl3VfGk5ebfYlFX3va+OyEARb+iW/T2Uhev+e3x405TIE67nYQKNU1Wy2+0Zj0+JZYwj1hqaSW4an6O2FopUGo5l+IQbHzQOROVvHbQWIISI7H7r+yYxQsXDna6TLHt6AA7cLfzn1hw5QdLWJOUEA20ngM=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=KMLdD75/
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
> The possible frac_rate part of rk3036_pll plls is divided two times by
> postdiv1 instead of both postdiv1 and postdiv2 as the integer part. Fix
> this by using postdiv2 in the second do_div() call.
> 

Fixes: bbda2ed5840c ("rockchip: clk: pll: add common pll setting funcs")
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

I've checked RK3308, RK3506, RK3568 and RV1126 TRMs, they all have this 
formula (well, RK3308 divides FRAC by 224 instead of 2^24 but I'm 
assuming this is a typo in the TRM). I couldn't find a TRM for RK3528 
yet but I'm assuming it's going to follow the same formula.

Cheers,
Quentin
