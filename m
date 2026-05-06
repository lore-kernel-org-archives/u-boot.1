Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9AD1FF8855
	for <u-boot@archiver.kernel.org>; Wed,  6 May 2026 13:25:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0554B8490D;
	Wed,  6 May 2026 15:25:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="X4oXfuev";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E87C84915; Wed,  6 May 2026 15:25:30 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F52284903
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 15:25:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k/L2rowEVEkJyIAQcuidYzDFYoKwEVmz7gUd2e4EPKp5iuAPs5mxMgXwxydiDcCGMDWwifqvbulen94+MTcU7q+MXuEWpefvXdt6GdhxAc4cJnrwKx1ei7m5Hk74Yuv4PGlpdPLFPlPGymftx0/zWKlzF/Qr4MknY83cH6NUa93hzlZoTkQpCoQorwKGlC8bNB8DGjZKoztjnhFnqD3P/NAczBDjk8c28c6H6KFhD0NsWTuU6pg1mOoZOoIwQ6+8JnDAlLCjvc8BMBPbIYPxhLSCAlVuBku5P9oszTB0+biXUD6KRsbhjUP29HVJyAbK8OneMcFEjClJ8LJuhFj9JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/gqWpuJVLBp2XQ0Nvy4yAY0NSnUY0lnBVUWn/WKhrts=;
 b=ie4EeyvwGVEnyB8TIJLRuuSindCe5d1Y2CHDXRnCE7kK44MRXO1zRWxWPmG3dNvtVcXm9yrP3/n+2nSbikQGsUy1wH7VAuAjYkUcCeFlCY+vs3OLVoKFATwtJLxe9Qz7HfcFaSfDiE6SFGY0BWDFSgaDN6OKKIcY7ArnLX7fSr86Er8GLa3iV19rC4/lIfCjevzl9sywoKtCQqAFwubBVc73kQWGbhws4/E9m0s+TOQDnRwHdj5mpKwjc8QphLyZnvHkGE50sX8lml7p4KlX//ulIfdonL9TUVVK77j4L3jjOL6JJTM+Xt87M7eVSUo9XETFSnlbWqeU7YGbXScpZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/gqWpuJVLBp2XQ0Nvy4yAY0NSnUY0lnBVUWn/WKhrts=;
 b=X4oXfuevjSWXOmp7VqKR8xh0jCpR0hcSyTwxHsS/Nbt+t7OmWZr6dGWVCSI+kymIBwRzs152YmJtS/lFD5eV78ZdH6NRzLqfsTPJ8CVwhE/IFQB9Sb6kFQ6jA/pv5+lzMDqAaWtM5XVMNAAmodBUY10uoutoiNzv4xudRmJkBQI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com (2603:10a6:102:b8::20)
 by DU0PR04MB9660.eurprd04.prod.outlook.com (2603:10a6:10:31b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 13:25:25 +0000
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7]) by PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7%6]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 13:25:24 +0000
Message-ID: <7a1b8c26-5eae-4624-95ec-4a1bc00b865c@cherry.de>
Date: Wed, 6 May 2026 15:25:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] rockchip: Switch rk3368 boards to upstream
 devicetree
To: Johan Jonker <jbx6244@gmail.com>, andy.yan@rock-chips.com
Cc: philipp.tomsich@vrull.eu, sjg@chromium.org, trini@konsulko.com,
 afaerber@suse.de, u-boot@lists.denx.de
References: <0ca86716-5e46-4f16-a579-d04dbeaa15d3@gmail.com>
 <fa6b8c14-4c22-4b0d-a8d8-ec3fe2996cf3@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <fa6b8c14-4c22-4b0d-a8d8-ec3fe2996cf3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0114.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::6) To PA4PR04MB7743.eurprd04.prod.outlook.com
 (2603:10a6:102:b8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7743:EE_|DU0PR04MB9660:EE_
X-MS-Office365-Filtering-Correlation-Id: fdc53add-fee9-47f3-0d86-08deab72ee52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|10070799003|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 5KOrhL0oIAoy9P0BqKGGzYOQ31p0F4LqM/qC2AR6kkUN7f+fnl7yXGekS6SQ8V9/YFO0EqAmmfcHdkDvdtX7ahwMzvzyer6zNKid0Xq0lPDln9uHSQxhA3TjV2j5B3V7B2+yJ9C/Xxa1p6tpezwvCl5X8/eI+w4gmuzCmZntKgJIb1dRQ3UbvRSZR+Z6A5nAGVnO7+483W0LZgkuZL3d/2VzmpN1QW9oU21PWaaIZcDKpm47t3F2oMzX2n+A3FhM1haVMWqxbHIrHDZ7FJtzML4PApjfOwSsWwS167RpnsDNc6UnbJ1AuwI7CaSSL3K5gFjtAe4z10NFmgwnYKxV+ttEt+GGL9MJLCkCtRYSw8asLsD0wxEI/hLw7QkOMhSnGqgattCcanp2RvCumzV46HtYw84nTDCh7DuE9D2ni1gFs4nY/d7/k5V5r0sHfMJHZhcK8dfcwZTNYoWAvIWvfNOJZRCcqU7/F99fpFS4YZvHLavw2R3vvwz21tU9fJIHbzPo6tPlh4zYFLlU5W99bRobP2ZtHoHn470oySSX0jbTxSkeBVAPQK0/8/HA6FRAuvOAer6tSWTJFPREWV4+ta0k4AaldnXggEGo5GMCVfPiyrIpOy1z8OIuZaiebZ0Dkm2vhg31aO1VS5EtB1KDK1Lxz4CNMziXvYkbX3tDXWv4FBfCGUBqg/aubFpmMtf/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7743.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mk5yeUsrTFludXc3TWxFbUhTQm1qaUxTelRFMlVUa3BsWUVNaU56b0dHUk05?=
 =?utf-8?B?NXZsa1FCRC83YmUxWWpQUVgxbVFPL3NlcnM5MzNyTWtaYUJjY05Nc0ZoZnVI?=
 =?utf-8?B?OUZEWjRBckM1aXl6c2JzVTJUa0Fjc3JnM0FZZ1VneXBWVmJySDJkTG5DL3Fm?=
 =?utf-8?B?bFN4dXhJcENGeWZrZ21ka254clQ4ZS9kTnIrRms3eFBnL1VzQlJWZENLcDR1?=
 =?utf-8?B?ajExbk9OWWtvaDlqNVBhODg5MVhVY282TmQ4RXNVVUh5bTh0ME9nWms1RHJM?=
 =?utf-8?B?emxBSlZhWUN2TkJEVHR6MGdkVm1pdWJvVklobzFxa3JGd3hIV1lrdmVWRzF1?=
 =?utf-8?B?MWxvdkFNU25CNXRnM21FeUE4d1lKZmJHeUtrWm93ak92R1JRbHVwaXJuWWJ3?=
 =?utf-8?B?RENGTVJlWVJjVzBrSlRCNjdtVFRNSFdnV2doeDkyS0NJcjR3c0JOd0tpcHNu?=
 =?utf-8?B?L1dOV2p1NGJjeVF5V0J4Nm9tR1hyemhzYVpnd3JPQUdHWkVrb3FSL1JHTUMr?=
 =?utf-8?B?bVhnYXJyc1Bxd2hMK3VMcTZDZkJxVFUwVHh4RXVMTlRpRDNhdkhTMk1NZVBX?=
 =?utf-8?B?cElZcGkxMXJjV1A5NXBXK0w0bXREbEg1TjVyWnhWeVdaUjVmelEvUVNKc0ZT?=
 =?utf-8?B?NHpGOGVYcm1tNXRJQ2VhamQyQVBHNnNDNnhoVmN4cUh0UGx1aFJQQ0ZtQ1Nl?=
 =?utf-8?B?NUN3cGRNSTdJQ3J0d0dzWDJUUUYvc0p2dG9RY2pDMmhmMlBsN1RlZTJ3bE82?=
 =?utf-8?B?c1NHMk1vZGpOVVNNalRoL2dReG9mYmVka2pOMm5COU05bUdaWlZCTWhQOXNv?=
 =?utf-8?B?OFlYVFl4U2MyYm5WUkZQRTJHZjRPbUFsTlF1NzdqSUZBMEdvMUNGSEUwTmx1?=
 =?utf-8?B?aXV1UTFubGt1aWtDcEF6a0VpcFlZMTUwNHFtbGl5STZCWVdIRHV1YzVHVjFW?=
 =?utf-8?B?QktpWHhYZTlVSFFweGhuN0dzWndtRlo4YzJkSm11SUY5NVp2emNSTUFHQVVu?=
 =?utf-8?B?NUJCZFhLV0JGSVB1RnYvS3kyb1lxcTFPMWt6cXNMUmV1NWRZc0gvZnBXV1Rx?=
 =?utf-8?B?bWVOWGpDbExPeVNaaERLbzZhR0ZSM2dZaUw0S2FTdHpKS0JzTGF4L3VXcVlN?=
 =?utf-8?B?SFdyMnh1VU8zanlIZVRhc0dJK0t2ZHlJRWZnbWhremFMcXFrRVgwNGpMa0wx?=
 =?utf-8?B?TmdtUVJBNklVbjFQenFxN25sSGJqUG1mZkZCMzU4QUJ6cFkvYVV6Ky9aYjNN?=
 =?utf-8?B?ODZmVnVlbVVhbUlaZzVQRkIyalV5RXc0clZSVTJzOFBKYnJHTkM4MUlqRkl0?=
 =?utf-8?B?OWtUd0hSVGxzY28xMTRadnhrOEQrRHpoMDhUSjV2WDBGcVJpVE9YdERNUXFp?=
 =?utf-8?B?elUwUEM2b21LMlVzQnN0OGc2U1FuWCtyK0FEWlFQTWdiUHJvckQ5SnlUemx1?=
 =?utf-8?B?QmxpN2JNZloyRk8veXdmdlZjSm9EK0FJa3F2TFk0K0dZeFBCNGM1cGt3NVNv?=
 =?utf-8?B?VHJLZ3p4VUtvYi9jZDhhMG9YTGxxSFlJWFJRb1JmMUVlbUVQRlpPUTdJcHhx?=
 =?utf-8?B?ZWNwMnVQSWp6QXlEdzZ5N1RjVlh4SEpUTXpqanRpREVTRzR5YmNQZFdHNFNt?=
 =?utf-8?B?WExRdFhXYkMzU00xb09raVEwTG8ycHk0NWxKYXdDYTdoekpjRE1GUFhlSXM2?=
 =?utf-8?B?WHhPQnVzbXovbDJmYVlBQjJHSm92djVERE9ydU1ybXlWQVJqRjRTcE9tWWxR?=
 =?utf-8?B?cm9EYUVoa3BXTjJwNmg5SlBEQmUxL1N5elVpT1pvK1FEVmRrZHo2S0VWVUJy?=
 =?utf-8?B?Nkxrc0dlR0UvSndycHhqbTlUV0grRnFFUmgzcVNVTG12WGYwSFdjS2NBOU5k?=
 =?utf-8?B?L2pvYWtKU1JuK3VOaHhOWDNGQ0wyelMzT1VMOGdZcFlmSjN2SEJrUm1DaFFZ?=
 =?utf-8?B?MEsyZHU4MlZRUDBsN3UwZ2hVZDVIZUVkYXJsVXdqOHRVc0FpSVMybGh2QzMz?=
 =?utf-8?B?RVdKZVQ5Rno2N1QyMmxzM2ZMSzRkWUpYMm5yNVhqbmFydERneUdjVXdTR0VT?=
 =?utf-8?B?N2hCU01JV1VqazdhZGZGOTA1aXAwcEM1Qk9MSWlLaHNyMjN2akxEN3ZlL2t3?=
 =?utf-8?B?SThlbjJPdXdteE9mMXFzUXBvK0ttWHNXbkFGZ0EydDJnNkdNT2VHNG5RaFJ4?=
 =?utf-8?B?eUp6VjdXUHNQS2RaUTNvMHVvY3MxcmNIK1NmV1Rac29ycXR6MGN4KytUalpF?=
 =?utf-8?B?UWxveXgvcm00NWo4cjNsZm5vR3laUXNFaG4xT0pRSFVyVGo5b0xOaXgzSGZr?=
 =?utf-8?B?OUFDSThDb3kyTC9DOWNiTTZJZ2xOVjZiVFZ4anZOcDd2UjkwN2pVRXFmZUMw?=
 =?utf-8?Q?56oY6XnbeCz9/9F0szIbL7B3/ZMf5EXymGLPVCFJtHPhK?=
X-MS-Exchange-AntiSpam-MessageData-1: KZRFBzb7GcFjss3wIvdM5Vkc4878E5D8Orw=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: fdc53add-fee9-47f3-0d86-08deab72ee52
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7743.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 13:25:24.8791 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CkfBM6vOVWJRj5BB2NTItDNBwkczqShGy0DnOApNLI+aJgDD/18tpNFSHmbq6EAvxLWn30SwBaHLSK+t9VYiEvSPomzRP5JBmzeiOF72VBI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9660
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

Hi Johan,

Thanks for looking into this, I'm quite happy to see work being done to 
remove the last (Rockchip) defconfigs without OF_UPSTREAM enabled. 
Ideally, we should only be left with generic-rk* defconfigs which are 
useful for bringing up new boards. Almost there :)

On 3/20/26 3:37 PM, Johan Jonker wrote:
> Switch rk3368 boards to upstream devicetree.
> Remove rk3368-sheep board due lack of upstream support.
> 

Please have the removal in a separate patch, so that it's not hidden in 
a mail titled "I'm just migrating boards to use upstream DTS".

For all three patches here, how did you migrate the device tree? Did you 
check that we have parity upstream with what used to be before this 
patch? Did you check that the paths in SoC-specific boot_devices arrays 
still match the correct paths? Did you check we still bring in enough 
device tree nodes in xPL phases (maybe there are new inter-node links 
like -supply or -reset or -gpio properties but we don't enable those in 
xPL phases yet with bootph- properties? Did you test this on one or more 
devices?

Cheers,
Quentin
