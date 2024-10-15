Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9A9CCFC27D
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 09:34:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AF7B886FD;
	Tue, 15 Oct 2024 11:34:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="hmjiZ0A2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02F2F88E36; Tue, 15 Oct 2024 11:34:15 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::61b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A83C588387
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 11:34:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FjSGN5LvCFFLRztOxHWmg8LY6hwazJz6yNSLC3Ru2m+VdFFxWlLscQBs/nNfeY4R0AvDoKwib93bJznZcMdgMLvVGFNsBWJelfFv+RszYY3D8InNagi/ELvaTaz95g01sY5O2rz1NmlI2QTLZLesw3vjCmhs0/aKlY5LEQdIwJsjtL7otTPhGdtj8yz2ZABOIpr5u8prvYgfPdLdZ6h1ZLe41VGWTSpeg5u8yTXuguxzpPQJrcOOVCh3FHCJcs7mJd+6gJU7uirm4uoTKU6NvJQn6D6wFQfC2DVnqdEMXVZzfg+lTUxmQKm3nbGJx6hqDyO1aPiKkprfpf9KrViq1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KQHay7NGnG52e53phbUOEggnKZC0F491RbQu3xZDeuU=;
 b=eXcQpBFBBgUc8+5I24+q5nrpIUr57Z7AjDRU0yWQUzGjb337wrAeg0kLDqP14hU3T0xqn4qCq0RMAyY5Sv2jq+gQZZsMeqsdepMLf/sTcN9LkBiQUnVO2uTYZiMqKlnGF0Jtv1waE+NWDNVzUQKoIQOrDlzuf2nfOQWNAHpXyzlXQV2z8HJ52ynbcYXUCB+xViJokRiLY49UxkMOD7fFtvpJ48NV938AT1VZtaoj3+fOF5OiQMx6/VwdaZ0Db3sCcf2QC8UDIvvJtJ4m2WtQsbWtpChwHv4fSkedlaT1fz9kb4I7AcEXC5zSSm5oUxpLYxvWqhZYFUnOtmpNBo+gVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQHay7NGnG52e53phbUOEggnKZC0F491RbQu3xZDeuU=;
 b=hmjiZ0A2JRIBkbgWnCVj/GZrJAl3OE3EqaIJ4zIYL5QuXBDCmfCId9JxI9ii32t+u141BnTGdKVNFOqPiUZTvxE4haWBpKbwfn2HqlDrxGQ9lvOi3dqKY7s0y0pNFAknTZaZ+pcR0VShbjC9hUrqUOPtZWCPIfLcmLsOF3IYc6E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM8PR04MB7811.eurprd04.prod.outlook.com (2603:10a6:20b:236::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 15 Oct
 2024 09:34:09 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 09:34:09 +0000
Message-ID: <22953d33-b660-49ba-9664-845416bbc35b@cherry.de>
Date: Tue, 15 Oct 2024 11:34:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] rockchip: board: Increase rng-seed size to make it
 sufficient for modern Linux
To: Alex Shumsky <alexthreed@gmail.com>, u-boot@lists.denx.de
Cc: Dragan Simic <dsimic@manjaro.org>,
 Ben Wolsieffer <benwolsieffer@gmail.com>,
 Chris Morgan <macromorgan@hotmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>, Marek Vasut <marex@denx.de>,
 Peter Robinson <pbrobinson@gmail.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20241014221523.2912260-1-alexthreed@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20241014221523.2912260-1-alexthreed@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0079.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::9) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM8PR04MB7811:EE_
X-MS-Office365-Filtering-Correlation-Id: 47d8e6e1-3a24-41b8-a926-08dcecfc8550
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QlZmR2ZDYU5EVjBzQlJsamwreHBqQyt0Ym5JZjEvVUVtbW1SeFdRdlM4YTdE?=
 =?utf-8?B?MFN1WGlua1QxV0RMcGZaemJ3eHJab0tVZGdJNkFNT3JON1JEQVBMY3RDY2ll?=
 =?utf-8?B?UndYY1p4QTlIbVU4bmE0dXVsU2IrYkRmSkRYcXRrSTBkRURKZ0NKMTlTQVo4?=
 =?utf-8?B?ajR1V3RQNnN5dVY2dHY0T1lSNW0yVHQ5VzFZSVNFamwyNlFmc2ZualFPeHBT?=
 =?utf-8?B?UHYvK0tjUTN1QWpuWExoQmt4OUpDTlphNnRoTS81RDBWYkNseXNMcldJNzZi?=
 =?utf-8?B?a3E4N3FXRGhRNVBrY1M2RjF6Wm9CNjBQWGdWNVBMZVBIeDVvcDlpK2c4NDN4?=
 =?utf-8?B?NDdFeFZ0NmZsQytwTmJwekppSzFWRXFqY1c2bnpoSUQxYW5qT3A1ckJ4OFJm?=
 =?utf-8?B?Rmt0cGJQVTg0WmFwSkdMbVhiazdGMnFXQ0NaTytRVjhXVW9vQXg4SGFlWWNB?=
 =?utf-8?B?RXNpMm8vMG4vaW5YVUNkazFDblp2c1VRUzhWa3NuN01ZMmQvOHJmc3cvWUpl?=
 =?utf-8?B?VHZ2YnE2VzUyT2dxM05Gbkg4SVFWTGJVcCtoNmRmNzJZYTdPQ29aYTNUbnda?=
 =?utf-8?B?b2lyYWh4cW5OZTlGRkdYNkVZYWQyOGo2S3pjbVc4M1gyWHU0dUloV2hWems3?=
 =?utf-8?B?NzJWMkN1WWJtcnBTckszTHdjUWh0NXk2QTRrc3R3QXAxZ1dteUFXNlc3cWd2?=
 =?utf-8?B?TE9zU2RyOXlhenJyVWlqdi9SYTA4d1RBaEg1TENmWWxiTVhETjFpZXBRUEJT?=
 =?utf-8?B?TkFwUGtRUWpPWDVjcG5HbUlYbmpsQUF1L2IrTTQvcG9IYllEeHlZTy8zSjZo?=
 =?utf-8?B?MU4vT1NhYVVoeUNqL2ZnU2FweUlybW94bDZQU0U5M2tZNW40endBNm5oUXli?=
 =?utf-8?B?eDVpQWhudzRDc3lSU2VjRzVjcnpFbnZhOE84VVdSTVNtVTF6Z21qbDU5RTVq?=
 =?utf-8?B?NERiUkgyNlpzRGh6VkQrT3BVTmo5eGh2T3ZYQTFNN2l4bGd6Rnc0cGZEYlVL?=
 =?utf-8?B?dlpueFJIYTRwei90RHFLbkF5bVpyY3R1WFlQWHQrOFdKVmdTOE5KdC80WEFG?=
 =?utf-8?B?SHJJTXMva1JwcmhIMjVwYXF5UXdCNC9aU1dvNDc2TWNtaTlsbkFMb2NEcnI1?=
 =?utf-8?B?Mk16T3FNTXpZTGtjTUEwRGMwTy9uREwzaTB0S2Nwak1GdnpjQVZxSnU2VU04?=
 =?utf-8?B?c25pNnQvQk93c0ovNXY3M3hOaEFHK2ZTNURIcEJpYmNhUEUvWFZzVkdMZlFF?=
 =?utf-8?B?ZTJtcCtEMmJrc3NFRzJFM2YraGY0VkR1cDdTcnNMQ0YrbmoyOTYrZ01YaXRU?=
 =?utf-8?B?U1cvWjFuRjhub0FPeE4rZEhwWEJYVG9tZkk2YjhmMXlLRmFWZzI1bWFVN292?=
 =?utf-8?B?UTVIQUdXSlBEUTNwem1vTUdCVlF2dHRiM2lzRFlkL1BlNGpGYXlIMjc0RG9C?=
 =?utf-8?B?ekV5NWxNWm5MbUlJMFVTNEZpcmV6U2diU1hiSUYvajhtbWRia3cybE5rR2t2?=
 =?utf-8?B?YmwwTWRDM1hrRzlza05EV2VNWGdsQzd5YmhjYThsYUdsUFFKbDdIaVRGYk9o?=
 =?utf-8?B?aFRUN1RNVVU0aVoreW1IeU1QWWVySXJQQWFoTXFrSDJSWjFHUms1ZlZmNjd0?=
 =?utf-8?B?Q2JhUDh0K0kvV0EwMDF6WnB5SlRoT1E9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1F2QTZPYW5pRXF2U0M4cUhRczNXUHB6NG05OHVmZzhTOUVXZjRibjNrSmgy?=
 =?utf-8?B?bWxpWFIrS1dmVTV1bVNhUlgrWHBJMXNkaTk4Mkxock1QK3RrYXZNMXpyYjVh?=
 =?utf-8?B?eDl0bE92dzhKdkR6T0E3Uml3aTNWMmFkbTYyQVV0TFkrakszeHEwaWxpMnl6?=
 =?utf-8?B?Wkh1aWdidld0WHViRnl0MUV5QkpKSUlSQTVNQ2Q3WGI5ZEdzUWh4dnliTzhZ?=
 =?utf-8?B?Zm5BS2ZSOVB5bC9JQjFnb0ZpSzNmS04vY2JTT2U0eWtlSnJwY0d0VkdsOGg3?=
 =?utf-8?B?RVV2bFFxTDlDUUZFU1JwZzVvL3JQaFlhS0tDNDhzNFZOVXArNVZUeDZEN0FB?=
 =?utf-8?B?U2hzM0JCYnJyalNjUnRCc0RiYlo5cDIwaERXTSs3THRqVUx4aXNld3VPOWk2?=
 =?utf-8?B?M3lnbWJITVA4U1FHUUw1ZWNNSkc0SWdPekRtNEUzTkRXRllJMlJDMG9MeHg2?=
 =?utf-8?B?aUNvUXBpQjNJbXkxV1VqOEVpTGJXTW14T1RKcW8wMEllUWtNZmpXK1NyNTU3?=
 =?utf-8?B?ak9ncW16Y096bWFDaGg0UmgwODl2bTZUTkNHYVhSUFVzTU00cUUwQUExYUpE?=
 =?utf-8?B?OHNiTFB2UytKVjZ2RnVGOHArMWNqM2UwTVZHUWh3aDMrM0RwaWZwUmNBeFpn?=
 =?utf-8?B?RG8wa0MwOG1kMlFpVDNrNGRmSk5PSUQwY0tFYWhOenRnTmxRNG16RG0xVDNP?=
 =?utf-8?B?ZXo1b3I2UXVLNVFjb2lZR0E0TkNwTDRlMmtxODRLZzJBWU5KWmFQM29zRWhQ?=
 =?utf-8?B?UFRQYU9XM1FQRE1rUStnWWhhbjQxdkZ2V05BTW10UnRtYWFPOVoxZXdrTEVx?=
 =?utf-8?B?cHVhOE9QMkhPNFA1YXNVa0ErcTRpbW9VeEl2R2VOdkhKc0xaOUVFN284WkQx?=
 =?utf-8?B?Si9RZ0FVVTZEOEJTV1JWQitvTFgySE5PN3hITnl6ZTRtaXFyQ0hhVTVycXFF?=
 =?utf-8?B?TG1DVDR1TGwwc2tUZW0xTitVRi9iL0ZJdFpOWTh3QmFTNTQ5TEtNQlJMNEo3?=
 =?utf-8?B?RWh3ZFNKMXkvUHRWZFBFUVRFT3NSeDZhZnRRdGJ6OWZTTXIrZW5LVHR3Q2Nr?=
 =?utf-8?B?VHlTSklMUmo5dlFtSTBKZXU0U0phOWQ4amtVTmJRenJ2VWpETUJ4UEYwUVA0?=
 =?utf-8?B?Z1I4YzVaaDBEeUo0Z29XNFdTWGFJSjFYUWYrek5KcjZzOTFyV0VXSExWUEV6?=
 =?utf-8?B?NjE4SHRkTmdQMGl1cjd0UjRmaE9Ib3hpdllWYWQ0Q2I2Z0FpRUIyaGkzcXRT?=
 =?utf-8?B?aURHQXpBY3RmamdwdTBBRVgrUDFYdDlTajI2bVE1Rm1KSEhnTXJzSE5GWW1h?=
 =?utf-8?B?Vzl4bzlqUFRtazdhZGJKeVViTHpHQmJqQWNyV214enIrOHQxYUpWYllrU2d1?=
 =?utf-8?B?K2hqZS80N1crVXEzUklnK0NiMmxMMHhBZ3padFA4QjMrRkoxek03NGFEMFh4?=
 =?utf-8?B?eGloUnE2ZzN6R1NEdzZMaXFIRzRFeTRVUzFYQUlSclJTUzBVRmVWODE2dDk5?=
 =?utf-8?B?ZWRNRG1jWFRiVlNqWTdkSUFUNndYNUFFY09rWUlvZUpCSmc2WEgyMnUzQnZS?=
 =?utf-8?B?WG1YM2xDSCt6MENoQjcvVVo3dEo5c0dSbGtYbVlBYlAyNEluMVdBYzhTdkdp?=
 =?utf-8?B?SmNwS1NacHlCWGVIeDc5OUgrcy9oUXo1citQQUlEN1lpUzNod3lZOVIvVmZy?=
 =?utf-8?B?NXRJMlF3TWRsQzZCcjRCT201K0FlSnJraVkwM09LcEtGNXpKZnRRS3A4cmNC?=
 =?utf-8?B?Z2NKdC9ZVmVtYTltalFpclRKZUVpL2ZwT29XWEkyRi9mQXJ5OGd6ekFLWnBi?=
 =?utf-8?B?bDNEYW9ad0YrNUtHandZbmhabjdDWjlkbnBuYUpnMkFEeWpRRDY2RlY5Q1Nr?=
 =?utf-8?B?REtObXF1MllnQ0hDU2N5b1ErdnJkeUpkV0puYXBweUNlQkFLK2hyaEQvdy9E?=
 =?utf-8?B?MzZCb0xNQzl4SEp6QWw1L0pMSjZ6b0pqTXpPWUlyaEZyUUh4bFZzZmVkK2ZE?=
 =?utf-8?B?SDZnMkFvdGVzMk5Ma0JiNVArYmxEbnpJbjBiVnU4WXFHT25nQUlrWHpMQURk?=
 =?utf-8?B?aTFoNERXOTVjMmViMGNRenZDRGh6U2hvRy9yOU01R0tlUHoyaWNVbkVoeDVL?=
 =?utf-8?B?Wk1zSmxjaFloWFVXS1RXaWZyeUJKMGFFMTBQQ0NNb1p5ZlQyV2VxNEQ4SlVU?=
 =?utf-8?B?anc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 47d8e6e1-3a24-41b8-a926-08dcecfc8550
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 09:34:09.5804 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XqGau2eBGjp25MJkV4hnIYYBRLh4LTjmxto4dgwXcdg8g+e/t+C41q+/EL3R68AuuoK1E3guBq8mSp+MX/nDEqnvd5H52fpAQEssIeBKMgo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7811
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

Hi Alex,

On 10/15/24 12:15 AM, Alex Shumsky wrote:
> Increase rng-seed size to make Linux happy and initialize rng pool instantly.
> Linux 5.19+ requires 32 bytes of entropy to initialize random pool, but u-boot
> currently provides only 8 bytes.
> Linux 5.18 and probably some versions before it used to require 64 bytes.
> Bump min value to 64 bytes to be on a safe side.
> 
> Boot with 8 byte rng-seed (Linux 6.11):
>      # dmesg | grep crng
>      [   12.089286] random: crng init done
> Boot with 32 byte rng-seed (Linux 6.11):
>      # dmesg | grep crng
>      [    0.000000] random: crng init done
> 
> Linux source references:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/char/random.c?h=v5.19#n551
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/char/random.c?h=v5.18#n236
> 
> Signed-off-by: Alex Shumsky <alexthreed@gmail.com>
> Fixes: d2048bafae40 ("rockchip: board: Add board_rng_seed() for all Rockchip devices")
> Reviewed-by: Dragan Simic <dsimic@manjaro.org>
> ---
> 
> Changes in v4:
> - fix typos and code style
> 
> Changes in v3:
> - reword warning
> - increase default rng_seed_size to support older linux as well
> - reword commit message
> 
> Changes in v2:
> - add env config knob rng_seed_size
> - add warning for small rng_seed_size
> - 12-character commit SHA in Fixes
> 
>   arch/arm/mach-rockchip/board.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-rockchip/board.c b/arch/arm/mach-rockchip/board.c
> index 3fadf7e412..ca6404776f 100644
> --- a/arch/arm/mach-rockchip/board.c
> +++ b/arch/arm/mach-rockchip/board.c
> @@ -472,9 +472,18 @@ __weak int misc_init_r(void)
>   __weak int board_rng_seed(struct abuf *buf)
>   {
>   	struct udevice *dev;
> -	size_t len = 0x8;
> +	ulong len = env_get_ulong("rng_seed_size", 10, 64);

I'm wondering if we have somewhere some documentation on the environment 
variables that exist and what they used for because this would be a nice 
addition. At the very least, we can mention this variable in:
- include/fdt_support.h for the function
- common/Kconfig for the symbol

I'm also a bit torn on the base though, I think the assumed base is 
generally hex and not dec, so maybe we should rather have that?

Looking good otherwise :)

Cheers,
Quentin
