Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9886C4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 08:33:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C411870DE;
	Wed,  6 Dec 2023 09:33:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="TV2cQSQJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F12E28768F; Wed,  6 Dec 2023 09:33:32 +0100 (CET)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0605.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe02::605])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C613C807A8
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 09:33:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=stefan.herbrechtsmeier-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OfHSeBZ+WPzNWNtMERLULEWCmHlfh9aSIdZwmq+Nr+PEPcT90jAyCs+q117pFJ0I6ZREl/7bE+lFxQmV0a/GfB5pS6Zg34lMrE4nKGu6T7WKHxpgrdhsHcTTEJlRgR7qTaVouybZ2A05IBds/WdkqpzhB7h5MJhqYlozmlky+47vZ8JETGuSzAS7WnXkeEYku2HzryDu4iVbkUPUXDQ0fPu/HyYKgoHC2mWTwnSokN5qfcZrCyHlwm0K+EAbf51LA7Y9UH7ftbiJsLD+eqPgYifPHWBnuekMCEu5TyAm6fmbVSkG9V6bvzN2hqeFJmg+jKSslcSH+KoWeXWvI3n+KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BOs6Vj//SMA79Y4bb8I+ed9D0ds6eC7W7fYXeEv24ks=;
 b=P99Vo3dyR5tsapdxK9y07WbFN6+IJOEFanh/Q5pHfUQ+vzM/SgmNQJrjLZLYVXzpFILO5swStaFgbbWuGsvX/0Qu+nbYr3rWwyJxoMO/iMw1qLqPZgcuDyIAkXBjD53VCtrZBtpOjjj0Qr7Rohn3SZHbk1vqQssyU1wkngij3nz5jWvdzW0SBIf7f+7whpyr6RXbKfc0W+bz7OhT06cnTKCF6sh+VdCrwv1DC/BtSY9PAzWnqIilGySWGDjjm+Dc93Za0CIZJBlSz6xwMlr7P9sJf5x48cF7ejTqpqsUzh/04ZEApWp1lWgoegqitvyhjKIxnH05WI1Rq+Yz+qjNYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BOs6Vj//SMA79Y4bb8I+ed9D0ds6eC7W7fYXeEv24ks=;
 b=TV2cQSQJhUhT2an2KQl1mnT5J7dgzEWbDsX/RJY9bVM2kMZfpX+C7gii51bm7KgxXAwfNy1eejRatFEFZ7CUAZPJ/3pW5r+y6z0PBMj2JvNf3UsfPpvapnVupkkePsQP4o2vS+LNFucrrRfrKCq2y3L1N2yA94VfkQagGZEFkDY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com (2603:10a6:102:1d8::23)
 by DU2PR08MB10088.eurprd08.prod.outlook.com (2603:10a6:10:49b::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 08:33:29 +0000
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::170a:86f7:52ad:28e7]) by PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::170a:86f7:52ad:28e7%7]) with mapi id 15.20.7046.034; Wed, 6 Dec 2023
 08:33:29 +0000
Message-ID: <edf38e3c-2172-40c3-9331-3cf663bf5514@weidmueller.com>
Date: Wed, 6 Dec 2023 09:33:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/30] mtd: spi-nor-core: Set dummy buswidth equal to data
 buswidth
To: u-boot@lists.denx.de
References: <20231206053024.3744447-1-tejas.arvind.bhumkar@amd.com>
Content-Language: en-US
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
In-Reply-To: <20231206053024.3744447-1-tejas.arvind.bhumkar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0145.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::8) To PAXPR08MB6969.eurprd08.prod.outlook.com
 (2603:10a6:102:1d8::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6969:EE_|DU2PR08MB10088:EE_
X-MS-Office365-Filtering-Correlation-Id: 4556bd08-3b79-4478-c494-08dbf63605dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P9hT01iQljknQLmiXuty7V/u8EMr9jaeEdaDaFKjWqnGEY/bcHQsZZBRiquFyF0rPqKLcu3+5ZaV8FZfHg9ivk9xuakWpPZ9fXn9EylARarIuMVucfPrTydtZQREregSMhVWofRswqZQfg0XtqbX5wRjgRPmr9Q8n7yZj6Hn+6grZ0HyQwied7Vu+Bho6Uz0B/2VbVMyKQnoBx8oaohaMjYoG0q2AjhWOml9NQXbpURkZ6l31m3RIePgpkqMRvvgtB/m5BwyJqd+sGxd4f77N0v7p1rAH+PvDuFIlFA1JmUv2kNo0A9cXxh7EZJcLKHpkqVJ5vc0+1rXJS5kh7jpUue+7Xka/k+nBvNl9EyJX79Eg+7p/8VDd0SLwd3we8SQl3eQGwTCmV/nu5VXLt/UZHC7XthoKpkYNLvzys63her4Sieom4KbTzZYb+AOYWXrexXG6vivK6SXdjR+a0u0Ef7sYfCIFvf5gFXKXnQDlzBpzkiyxVsrXLpNwgRL4mnqeJVdI1qsT1e8vZbzxJvOGHjkfC1RJ80v2EMRNOZ7pO+YTloVJk0MCLTpcJ2gWuOvGQYeVZIDOhsLBQiPHhRF3cpoKK0evu2fQL5uexRQpNxjJCgSi8LP4SGa0uYNp7coGS5Rh5QnEFcz1DEL5TxZ5Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6969.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(39850400004)(136003)(376002)(396003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(31686004)(26005)(2616005)(36756003)(38100700002)(31696002)(86362001)(83380400001)(5660300002)(66946007)(6512007)(6506007)(66556008)(8936002)(66476007)(8676002)(6486002)(6916009)(316002)(41300700001)(2906002)(478600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXVnMFFMSVFqUTN2czA0dzN3cHVkK2FjRXhlUFhGb1NMQ3d0SVdXNGV6WmND?=
 =?utf-8?B?STJFbnAwQ2EvOVlWdW5BYzZxQzAyR0ZSVFBmeGQ0NFg4aXBKQjhLTzVXN3BB?=
 =?utf-8?B?b01LdTJ1eDQ0NXRnVXNpTFhVa2trTlovS2pUYjgwb3dkWlhRU1VyQlVUTXdm?=
 =?utf-8?B?TFMxR2pqZjdYSzVtL1Njb3RIc20zbWExVE5WazJyUHBMQ0Zna1RXV01rbzN4?=
 =?utf-8?B?NjlJMUp4QklPRmx1Sndjb3BoOWs0ZFdpSkVIVUUweE1MTGF3MjZnZXZSaTJ1?=
 =?utf-8?B?UHZ0ZzJqcXcrelNSNWdYNDdxb1MzOEJiNG1IanNVSlpnTGZ2TktLdS9iSkNS?=
 =?utf-8?B?NmdWWFBpQU9qcWc4bjl4VU83SHlaeE1qdWRBcm9CYWNCbUwva0JsWjEyaVdq?=
 =?utf-8?B?YmQreWlHSUozYzdCVVA5YWZBSllJekhNWThjY1NnT215ZzNSbVU1RllJdEZD?=
 =?utf-8?B?VVZoYzNCUGtqZ21YUlRpU202cVhoNndGUzRXd1BkQWNOanZkUW9mcjNyTmw0?=
 =?utf-8?B?Q3lGMnJxUGV2cm1MLzhMellWdk5mOXd5OU1mb1Jnd1BqWndVanlXdXVqV1Nv?=
 =?utf-8?B?Uy9NRzV5YjlObGp3RTk1OEVLWU5vQmxCWjBIdjRVOWxxdkI0aFRoL0xiVjhU?=
 =?utf-8?B?Tm1GaHJiTWRPbEZUcWh3RXNzZXVpUURIdnhvMmlFZUNJNTVXVUNVd2pUM256?=
 =?utf-8?B?ano5Ym0wSHVCTHF6WXVQUGg1YUoyUkN6QzZZQVNTcHcxK3hrdHdwelk0QVNC?=
 =?utf-8?B?UzZGdDUzZkUyU1RrbEM0T0tRVDdLczdOQlNtZURreTUzdDhEekwzb2QxaFNr?=
 =?utf-8?B?a1BDVlFsZnFxWjRhWitTOHFHOERYSU5vYmNlMUdyOGptUUlIeEF0VTk1WU9z?=
 =?utf-8?B?ZGFkWmEzN1hTNWZLb1hBWURHV0Z3c1orOTJFdkVoOGRVZmJ5UTFhQ3V0SEdr?=
 =?utf-8?B?SE5ySlFPKzlPM2s1b0twSmtsei9oNGV0RlZUOUhmMkRwTWo2YURRdElhbko1?=
 =?utf-8?B?bTU1WitWcm5Fd0VRVGtVcHBhRXpBMGxtSktDbWJveXo4RXRORjZuamwvMTFm?=
 =?utf-8?B?dkNmV1VnMkZDbDJJQ1g0bUtvUnhWemdRTEo5NitSUG9ySDBuOE42bnlpTWJC?=
 =?utf-8?B?eFBJaFJQOHNZVjlwREI5K08vdlA4OTl0b2x4dSsya2MwWGFoTmpDUzBhL3lJ?=
 =?utf-8?B?c3g2UEZ2Tm5iQnpDRmhlZDVzeklQdXU1SjA3bE9nYmd5UE1NaUtZM3lpdGNz?=
 =?utf-8?B?ancrSFZiNHl6enQ5QjI0Q0x3RkJJOFB5TFBrcFlDK0VWc0hhbEthVG9YSEJC?=
 =?utf-8?B?ZXNLb2pFWFFsR29ZckgyL1NENjZVSWYwQWh5elVaNXZlNkhXdmU5TDIyWHRJ?=
 =?utf-8?B?UWl3VHRZUjl1RllhTjQrSzJSbEVjVTRrRFNvaXlNa3Z3VTk4RmhWR2lPR0d5?=
 =?utf-8?B?VTNkYW9MWkdHSmtSOUpEcW9MVDhpUllMNFlWZG1YZmsvdUhQRjhlSVpRLzZJ?=
 =?utf-8?B?OGNwWjY5WXpscUZGQ0dHY0dkazFPb21RMFFxVy90NTlQTjVudUltcUtEZGZa?=
 =?utf-8?B?clAxZ0lHK3V0UFVkYmdyQVdidytoNW5XeXZoVVllcC9NS0NyNnhKZU0wMGIx?=
 =?utf-8?B?K0hvblNHcy9Cd25DNVlVZ1dTa2srVndHWks0RXp1bUVSMnI5SXR6WkZYUUdW?=
 =?utf-8?B?NWs0QVo4Ukd0ZGRlbklKWHdGZDR3QUY2amFRVEVGZUV5UU4zTFcvWXRLOXZV?=
 =?utf-8?B?QjRxY051czdMMXdPUG9SajgyK0FMdWVhMFowSTJLVFFPbUxLcHpqTENJWWYz?=
 =?utf-8?B?amZ2ekFZYVc2K0h1T2QvN2Rwb1QwN2lDbStwVHpOQnFJQUpnaDZkSHpGZ2p4?=
 =?utf-8?B?WTVJZjFXU1p3Q3F6c0VrMnhRbkNtVTh6elJKaU4xdStvOGhOQVBRZVlGTlBK?=
 =?utf-8?B?YTJXd2ltVEtlOVBqcERhQnNjNGhvTVQ3WW8xdEZmeXdyeVJrQ0pNaXZKVmE1?=
 =?utf-8?B?L1JtZndBaXlhZ2pLQ0s5bUVJMFpkK2IvL3NCK1o1TjdXaWY3dG1aWE9vNlp0?=
 =?utf-8?B?N3NlYkdaaldFMFRxSHlrVFBNTGlUc0QwNGtQOEw0TGw0N3huUjREd3Z3SGF2?=
 =?utf-8?B?MzJwZWt3SElFVmVNcTNldWZlY3dGZ2k3Yk9hQXVrMUJqV3kvYUh1ZmJ2WThP?=
 =?utf-8?B?SWc9PQ==?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4556bd08-3b79-4478-c494-08dbf63605dc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6969.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 08:33:29.1124 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SA9bJUs3O83DpmhrpfKZJWmOt4eyjdGNNIotuVBAj4N43lW7e7jEBfRhU2KSVuCxXcCnhCUgZx2et9PJu6LtSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB10088
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

Hi Tejas Bhumkar,

Am 06.12.2023 um 06:30 schrieb Tejas Bhumkar:
> From: T Karthik Reddy <t.karthik.reddy@xilinx.com>
>
> In current implementation dummy buswidth is set equal to address
> buswidth. In case of quad spi (mode 1-1-4), where address width is 1
> the dummy bytes will be calculated to 1(8 dummy cycles) and dummy
> buswidth is set to 1. Due to this, the controller driver will introduce
> 8 dummy cycles on data line(D0) during read operation.
>
> But since we are using 4 data lines in case of qspi, we need to change
> this dummy bus width to 4. This will make dummy bytes to 4 inplace of 1.
> This will be taken care in controller driver by dividing with dummy
> buswidth again as in below code, which makes dummy cycles to 8 as
> earlier.

Do you have any specification that states that the dummy lines use the 
data and not the address width?

Both u-boot and the Linux kernel use the address width for the 
calculation of the dummy bytes until now.


> dummy_cycles = op->dummy.nbytes * 8 / op->dummy.buswidth;
>
> So with this change dummy cycles will be on all data lines(D0-D3) and it
> is taken care for all the configurations(single, dual, quad and octal).
>
> Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@xilinx.com>
> Signed-off-by: T Karthik Reddy <t.karthik.reddy@xilinx.com>
> Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
> ---
>   drivers/mtd/spi/spi-nor-core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
> index 473d9f41f3..8949dab548 100644
> --- a/drivers/mtd/spi/spi-nor-core.c
> +++ b/drivers/mtd/spi/spi-nor-core.c
> @@ -260,7 +260,7 @@ void spi_nor_setup_op(const struct spi_nor *nor,
>   		op->addr.buswidth = spi_nor_get_protocol_addr_nbits(proto);
>   
>   	if (op->dummy.nbytes)
> -		op->dummy.buswidth = spi_nor_get_protocol_addr_nbits(proto);
> +		op->dummy.buswidth = spi_nor_get_protocol_data_nbits(proto);
>   
>   	if (op->data.nbytes)
>   		op->data.buswidth = spi_nor_get_protocol_data_nbits(proto);
