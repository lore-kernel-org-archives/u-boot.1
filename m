Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F27A9C0219B
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 16:39:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C5DD80842;
	Tue, 11 Feb 2025 17:39:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Fs77Rzli";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0EAF80A55; Tue, 11 Feb 2025 17:39:11 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1483806FE
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 17:39:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DxUhxR/Lu851Xbo0CO9PO5w7tJc2oTaWc0dzpuOVsdEyqky+eeL/CAz7UdVWRmwKZYmZ9zD6cwBWnEGrruxBm5YGNc03U3nOSQmTv4sL6k1tPwCPdW+NaEszz0upyLgpY85+1Ei2p8qwG9GnCz8JjFY0V7v/onL5leWtJa3OCW/zXinlhB4ItZrttAeqx2ardqSKP65vnznuH/ozKYWleohxW5b3QE6wSA4y59y1uNb5NfOtDz1cv3WbBZ9vllK3Zw0W0q7mJQ6JvBIdvr/vg/HKojD+hjonYq5euL23+zhop9HQCwhaHNNhnHEIdSQFGAvgoZO2ZIVzwEBMVeysRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C5RkuGBuu+DWa6Z/WoYQYFpfaOY+XOlx2oylNKZ0ob4=;
 b=ZQDdC1TmzcgSpiCNHD5uoGZ2eSWo2AtW3A2SmA7YCc9ixVhW8jtzxf/bG7MSwmemY1L/0j7pfiVGIPf97FSKe/1yU3te/lPMQe+FqkmIverTZ5KkI2O+4p5WlYWm2Km8An5oFVcWisV2C0BLXq5vB3PXRLSRP2ba2+AXAV83M0NQXGVujL9ZFl7+LnMA+q5nkD3SmST3aMJvXDx2pZNph38Djxk0hhp1bdiy8d5f6aOgaXwZbi9Cf1OVkJiM9BjOsrYX2Hlmcsa68TZ7He4WIHUihj13TPKracEB5O5gNMFrKOywZfRmxW3kdt60IqGV2+Dx4Crcmjf3k9GK4mQlHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C5RkuGBuu+DWa6Z/WoYQYFpfaOY+XOlx2oylNKZ0ob4=;
 b=Fs77Rzlie3/3HAboePgBBoLz5FWR+SktnTL0zBrqbh8RuDLw7be7sjYcQse+Z2O3VQqrRvTBbYiWyxuDvOABzLWioBhU2MyIfEKpUtGNnJIz5gUGSZ/jHwqshxFS7x0mS1GGiv8BWDhC7Gr54w/AfooYLqnO2mf6nqoxV/GVzYU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AS5PR04MB9943.eurprd04.prod.outlook.com (2603:10a6:20b:67f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Tue, 11 Feb
 2025 16:39:07 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.8422.012; Tue, 11 Feb 2025
 16:39:06 +0000
Message-ID: <a84495fa-c4dc-4404-9bba-fb83c228a3a5@cherry.de>
Date: Tue, 11 Feb 2025 17:39:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] env: mmc: Make redundant env in both eMMC boot
 partitions consider DT properties
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
Cc: Dragan Simic <dsimic@manjaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <20250211133116.28833-1-marex@denx.de>
 <ec7c85b2-9275-497b-abcb-3daeb39f796e@cherry.de>
 <6d6d0241-9be7-4b1c-bd45-98fa50cf5d65@denx.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <6d6d0241-9be7-4b1c-bd45-98fa50cf5d65@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P190CA0050.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:1bb::15) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AS5PR04MB9943:EE_
X-MS-Office365-Filtering-Correlation-Id: adf6d901-4b8e-4717-448b-08dd4aba99e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|10070799003|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TE9JR2NEb05aMHFBRWxNY2J0eTVyeldmNDBiQkF5WTZhdFlwcEtrU05TZ3FS?=
 =?utf-8?B?R3R0c1grcFV5MFJOMlFUUllCaE50T1hsSkVTbmt2OGo2QUY0dUVvRE56cUJu?=
 =?utf-8?B?R09xS0R4endUdTZ1MVJ2RzA3Wko5K1JmNkk0MXFCQlBPVFlTNThJVmhSRkpJ?=
 =?utf-8?B?NFZlNmxMdmt1elZ1emxaUDNPU3AvVGU3Nk9CYzd4eE81TkZoUXRybU1HcE5w?=
 =?utf-8?B?NzFxUlBSaThWME95MnM4L1VEUUlpbFJCdTduZ1VBWnAvK0hqYVNHcXlLQnJu?=
 =?utf-8?B?ZzNubkZmVU93LzhMNzJOc3ZkeEtPL0U1cVFibWJkWjdUWG9BMHM5UFFucldH?=
 =?utf-8?B?NmJPRk5xK1laWEdWZFRYKytyZHBGTlZOWXV1OFo3cmdOUHpFLzlNZ2dqK1RX?=
 =?utf-8?B?aEJrZkdXU3dwdFErcm1ubjAyNEliTW10UUl4bFIvdlUyRWhnRklRSG5tZExo?=
 =?utf-8?B?eml4L1NBOUFlTk1aaUxVWUdsc3lCRHN4WVZoTE5PUkw2ZW9Va0w5Wm5maW0w?=
 =?utf-8?B?MkljZDlyeUdVbHF1Y2hOZnhtUWl1VXdEWDQ2NytRQkRScVU1M1M3alpUdkV0?=
 =?utf-8?B?aHNsbjkxYmZSbHJ5aE1OZUJZZlI5M055OUVYQkp2UzU0QkVFZUhsMWZibHdM?=
 =?utf-8?B?NmNPby8vUkFvVGo0bHVnZFZFQTVqemJkeXVINjg1bHlUS3VhZUJ2S1NMZXNI?=
 =?utf-8?B?SkJmYkg1cjlsTUY2akFITE1UbHVuOTh2RVo2U1RqcDJDNVF1UjltSEtmVEgz?=
 =?utf-8?B?Y2VmRzBWS3JtNnZ3TzA1c3RCcU1zclo2cTJnaU5Fa1c0ZFJ5M2RLdUpWdHRh?=
 =?utf-8?B?N2kxMVNiUzFSQUs3MzU5OWdwY0VaQm9zaFBicFBKODlSUSsvZUMzOUhwbWNQ?=
 =?utf-8?B?OXU4cGZ5b2VtVHJUSnBHa0JDNU5odGRraVRQMlpPQjI2R1hLRVVPVzVnVFRy?=
 =?utf-8?B?KzdPVy9JMWhNMnF1SXpQSGUwR1VXSFBQb0N1eUdYMnNnYU52OVdTaFNpMlc5?=
 =?utf-8?B?c3RLRCtveGU4N1Q3cUlTV1E4Qzg2ZGdIeU1LY0Z1a2E1QTY2U0FuOEUzcXBG?=
 =?utf-8?B?bzFlWjByOVFlQVRpZFUxeTdFS1YrM3hSTWxUWGhZSnZHcTh3bWxLVnNuK1BG?=
 =?utf-8?B?UTRqU2hsRmwzTHAyeVBxTWNONlY4eDZzYWJLQXl5a0wzWkZ6bFBJeXBtQ3Zh?=
 =?utf-8?B?dkV2K1RPLzE0RUtaTy9kUGtjNWNpbHRXMVFOUkZZOExaTGRJZHBVSmhkQVhM?=
 =?utf-8?B?SHRhNk9Rb3dMdzNuYkNoM284R21OWUpldHFtdmJPRFVjSVA2cTB4Nld0MUlu?=
 =?utf-8?B?U2JOTVRGNGxBQy9OVEFkNUkwdktySlZNWGt6bG5oa1M5MDJiZW5zYkdjOUg2?=
 =?utf-8?B?VWhDWk1LZHpGbTNWQi9qMU5wN3NIVzBRN2F1dTY3NG5KRWFNNTJMams4anha?=
 =?utf-8?B?UWNpU2lQUUlvemZhREtTK29OMXRncGNNbk1IaW85YmtucDkrMWtXNjhIZmlr?=
 =?utf-8?B?UnY1QUZIbGxNRk9BbGVJdWQ1TUtvdXVkM3VZR3JwcUhuVng1RnFTVE5DdkEx?=
 =?utf-8?B?cHNhNVBOK1F6Zk1wVjZOOGpEZlZGNXpPRjY1WEtOSEk3QzNmS3BybmhmTnVk?=
 =?utf-8?B?OUM4VnhNU0kwaTc5cEd4OE40b1RSYkRyYTFKN241dWViMnlFeFU2LzVza1Vz?=
 =?utf-8?B?aERsaGxSVURDTWVjQyttYnlsWk1tbWhyWWVtdlowT2hURHh1MFNnTGt5OFRM?=
 =?utf-8?B?b3dJVEFwQStlNTVjT1M1VndpYWFlcXhWbExJYUJCaCs3MUFhZmtkcnRUam1h?=
 =?utf-8?B?TWJZU3J4RU8xTFl4dGhNdDIvV01qMWtjMjV5T3dNTVBJL1hsSDJUMUUycEoz?=
 =?utf-8?Q?wTUXmph6BLXzu?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVhsN3Q0M1hqOXF6NzAxdndNY2F0MXlpSHFxalFMRUJtdmZBSUtHajZTRzhs?=
 =?utf-8?B?VWd3TitZZHhqZlZUdjh4S3U1b2NsQmo0MkxVNW03QTI5QlIydDYwYUZHeUhM?=
 =?utf-8?B?OWdjZ2JWUFNSMjlWMk1vekFXK1BZOWNiVWpuNGE0YjhWejBaeEZXMm51WFdQ?=
 =?utf-8?B?Kzd1NkI5aUNUQTNpeDYxV3NIUy9QZEttaDJ2a0Z4V0pmbzVVQVMrN1J4ditU?=
 =?utf-8?B?VGUveWFCbzZ5WW53djVQc3hjL2dHZGVYOFdHOUxvTGtvaUtwVkVwSXpqb0NR?=
 =?utf-8?B?R1VYZEFLTk1SUVdrcldSaHB5cUhLM2dyMS9vSk1IYXQ2L2RFUkRGazhSTzEr?=
 =?utf-8?B?azFpYzV4YjJUYVJDMC9JSHpRalQ4L2lPY1NxUjFWRXVPRXJtd01JMDkwRVM1?=
 =?utf-8?B?dWQ3NUxrSzhhTll0cXFJSnVLUjVsdTk1NWlSb3RKSnRUTXh0UGVyTjJkeU5k?=
 =?utf-8?B?N2M3cDNWSUM1OFFydnB6S1UzZFNKbGNicjhnTUdWdjgrYnUvK0VzQWpieTFr?=
 =?utf-8?B?bWN4bVlINmJKdHVQKzJzNmJQNXBTZ3I5dCtrZU4vdFRQRnY4YTgyN0JONmJa?=
 =?utf-8?B?Q1V3L3RaN3ZmREJzaHdnWXptbWlERklNS0k2VjFKUEhZUGFxNUlQUGJOcUV2?=
 =?utf-8?B?SWpIN0RhcVJTQUh4WExqREYyS0ZUT3I4cEJ5MmxGcXNvRnJ0bjJjb2o3QTdk?=
 =?utf-8?B?NkVVR3pJNzIvLzMrZGpna1FaVERWQkllM0hZT2R1djJ5aER5eW00NkF1YURr?=
 =?utf-8?B?T2sydHJzd0ZqRHR1M21lMGlPNUtkRnZPaFhsL1JIZjlLR0V4cWtjMGpuekVq?=
 =?utf-8?B?dy9GSU55cU43K1hTWnZhanZOR0JCREt2Zy92d0xGSzR2RGl2ODUrZEJMbEtn?=
 =?utf-8?B?VUFwSnRhdGJ5eWZjYTY4Y2Y1L3VNZnRCbWEzSW9sVTF2azNSR1UyRXFCOGtV?=
 =?utf-8?B?K2wyTEhJZkFmQXd0NG9KY0RqZmcvOHMrVEI0cUxUU0hGVjR4VFNremIxeUZu?=
 =?utf-8?B?Sm13dHBTNU5IdTc5cmM0YStmRk1KeUVtYmU1REdwQ3oxazVKamFJQWh2cmlF?=
 =?utf-8?B?RzRUZGhRMGh2ZVF2Si9aZzhNNHpDM3krdWtpQ244OUZqcUVRN0loaEFpeEV5?=
 =?utf-8?B?bnN0SmNyeFdLTzZtdzNUYUl4QXlJU0ViUXV0T0s0clNqbGZiMXNCbGhKZXFw?=
 =?utf-8?B?WXR2c2ljMTB3UVRqb0h2WnBLYklVVWlRMWh5dGV5Tm1QNnVFTDBvWTMwaE8z?=
 =?utf-8?B?VUo1RjhzTlZ2UnBFRTdEcjhwN3o3SWUzd0VYdG14NEs5T1RkMGY0ZTl1UDNP?=
 =?utf-8?B?Zk5LK20yN2pqeXEzYkZla043RnRNdGhiajNwamFyWWJwYTBQaUM5RUxkL0hm?=
 =?utf-8?B?L3lhTC9VWGpPMHMrdjFTaGJ1UllIMVlhS2l3WjdIK3ZFbi9KQlZ6Y0JWc1pV?=
 =?utf-8?B?VTJzd0dLSHNrekFUUjA2VGhmb2hKb0h2UzR2N0NjUmtRaEVtRU85dFJOSjhH?=
 =?utf-8?B?d2JGMGNGMnZjT3RSQWxrbUFEdEJOakF5YUVKeHhidUZoMCtNU2VZVVorNE1P?=
 =?utf-8?B?TENiTjRhZ21aWS9qaFRBVmtqRXh1RlVLUXdiRjNCVEJIT3dkVmhiZFJTdjF2?=
 =?utf-8?B?MkxOYmFqemx1ckdQTUpPWEFjVmt2NlEzcEtaSzNzL1Z3UFM3Tm91VzhtSGZr?=
 =?utf-8?B?VGRRUHZoNndTbXBKOTlLZXBRVTZQWUdZcXJua3ZsR3JUTHg2VTYyYThyelV1?=
 =?utf-8?B?aFo5YWo5M2FEQWEzZmRzeEp1NGdsR05sVWluZ0NNLzBjbXgzR0lUaDFPMXlG?=
 =?utf-8?B?OXFldm5pN2h0aVJRT0M1UnJocllsclBEaWN2QVpuVkVDQ3VIRWNXSGR1K1JE?=
 =?utf-8?B?RS9WK2dyZ1BldHM5WFNvS1NzaDR6NGFFSG12dmQ3dWwvbG4xendHZWNlRE8x?=
 =?utf-8?B?bWxycW9UWlhHSHg3WWpYTkE0b1pXeTJsRDA4ZVBmejRIOVRQZUNDYTJ4MzVW?=
 =?utf-8?B?dG80eGlwUUh4N21UcXhTcHhwZHR6Q3pmaDZYWlhWOUFnOUowWlJLand1Wnhv?=
 =?utf-8?B?VHNuRGdwQVNoaGwzc1hSVCs4VlllVU5YVGpiSjAycWFvMlJOOWZCSVhzdkVt?=
 =?utf-8?B?REs3SWNqOE4yUjhVM01kL3ZhU0FCUEhKeTNpeVhXRitrN3R2YXRlMDhyZVBp?=
 =?utf-8?Q?YTdxogyDF3yNEDXF4V5aCpU=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: adf6d901-4b8e-4717-448b-08dd4aba99e5
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 16:39:06.4201 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pNXdj2cCmeoZqVghAf6ga0sKMw9a5k8zrBehSIuuGXPZbLp9e9oJsVrtm47MHTQEtqktzdKWIfAR6fppxUu/VvGChLu6MWHwdmtqIgrigys=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9943
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

Hi Marek,

On 2/11/25 5:06 PM, Marek Vasut wrote:
> On 2/11/25 2:47 PM, Quentin Schulz wrote:
> 
> Hi,
> 
>>> +    if (CONFIG_SYS_MMC_ENV_PART != 1)
>>
>> Oof what a terrible name for the actual meaning :/
>>
>>            MMC hardware partition device number on the platform where the
>>            environment is stored.  Note that this is not related to 
>> any software
>>            defined partition table but instead if we are in the user 
>> area, which is
>>            partition 0 or the first boot partition, which is 1 or some 
>> other defined
>>            partition.
>>
>> Would benefit from a small comment making this less confusing in the 
>> code.
> 
> Maybe CONFIG_SYS_MMC_ENV_PART should be renamed instead ... to some 
> CONFIG_ENV_MMC_HW_PART
> 

config ENV_MMC_IN_BOOT_PART
         bool "env in eMMC boot partition"
         help
           Store the environment in eMMC boot partition (y) or in user 
partition (n).

Maybe?

Out of scope for this patch though :)

Cheers,
Quentin
