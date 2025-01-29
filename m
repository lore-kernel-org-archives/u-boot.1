Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 746A8C0218D
	for <u-boot@archiver.kernel.org>; Wed, 29 Jan 2025 17:10:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE3618081E;
	Wed, 29 Jan 2025 18:10:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="WQ4/yCBG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB74780A37; Wed, 29 Jan 2025 18:10:28 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170130004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40E9180077
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 18:10:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JXuQBIMOCB7kFBTv1RFz6T/jRqIbBYwm2MYgNIv5AXJhTRaw/n8Y/QfhrcSYwG2NvMJP8lDqHctJALHGvbl0ttCZClMdDYjAt9/tMQDxSbK8u/Qv1adfiLKYY3LkjcK4xCBs6NxJ0KH1eTbuB+Xfq8ibdZ4Ey1PqclQs2V/6bkcF5y8rGzDKqiSj/pFpjN9q43UYio17Vnv0fc2SNgcmVn1zDuQUoA09lSzbYynadHjuV86BqoXuxaMiWZXX5aaBqePEC6Nmg4R2YcU/uTM8LLH0D5etsOU9yOqAd/YEIPLChjuDAKa1+GMShnFCNGl8UJMVidV/y44HVY/hvHGS9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i2hrbp9s37tRGWs9HknXSJOInlE+pISYUxxhSw/DgrA=;
 b=k3oVCX1AlTC5cvDQ8fl6Ayimjnn9mT7kpb/0hNJQ0OwJjJXu/4TJd07K+w0C3MAjVWmFwZJhwaYP/190+dCpdBB+wCMk3Hyo1LBY0qucR/w80XP14A7duUZ1cwc1nZXjaBAL9EV4pQUvXNIs9jUO3Eo0tu4UO6ios8TH5b3s0NB/kgVOH3vmUgEbv6HJAHX50CkEfPZ6BMjeZpkQSB3NaCPnfTfRcAenZll67apBOScLNNBgP7Z/W9C8xPystojPxFsHiM94VZnXj1kyYl5m3Oj0OaMPvukpkfn66kWqFFQNP4cAyr1Osj/KNosCad864mPs/XjvkLXAxxfxrrZXHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i2hrbp9s37tRGWs9HknXSJOInlE+pISYUxxhSw/DgrA=;
 b=WQ4/yCBGTBQ6XDMxDSku073J2PhkJ+ZSIpH0+wdY8riJxMlXpZ9bwLtFZxUsgRXUACV9zyFvU0ky6CF8XUYJv7P093bhm9DvN3gixYSSHTHbcBEMM/Dp7q07sENqxZOr9N1QJTAvZzjmbRNP3W502z56wIualMgjd7wD/F2cnfE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AS1PR04MB9501.eurprd04.prod.outlook.com (2603:10a6:20b:4d2::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Wed, 29 Jan
 2025 17:10:24 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8377.021; Wed, 29 Jan 2025
 17:10:23 +0000
Message-ID: <4097bdb7-8c8e-42af-8538-41338d49b328@cherry.de>
Date: Wed, 29 Jan 2025 18:10:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] image: Add support for starting TFA BL31 as fitImage
 loadables
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Andre Przywara <andre.przywara@arm.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>, Michael Walle <mwalle@kernel.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Paul-Erwan Rio <paulerwan.rio@gmail.com>, Peter Hoyes <Peter.Hoyes@arm.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20250112223755.179959-1-marek.vasut+renesas@mailbox.org>
 <20250112223755.179959-2-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250112223755.179959-2-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0202CA0012.eurprd02.prod.outlook.com
 (2603:10a6:803:14::25) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AS1PR04MB9501:EE_
X-MS-Office365-Filtering-Correlation-Id: 279ee45e-6b4a-4e8d-1415-08dd4087d199
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|10070799003|7416014|366016; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V0dXd1Q1WHo5T0ZIRFlqR0VwOUREazhnV1dHVzgvbWRMZXRucnNLVktLSHE0?=
 =?utf-8?B?NFV4NlVBM1BLQUdxUTBUN1lXdU9SSmtCRHhYbUtQd1k2V2dRYjZVK1E2VnhT?=
 =?utf-8?B?SWw2QnN4R0MyMUNnSzRPQVA0ZnhSQlNXUUcwZXppWGhzL2ZLVkpNd0MzZkds?=
 =?utf-8?B?VDRUdVZaMGYwcXArUE1XV1pzSGY3RnJ4TTl1SkdUbzM5a3NkVDF4aXl5Q3Nn?=
 =?utf-8?B?eExqVXRGd2ppUXUrTWZHNjFldGpHOUM1Rk1iK3FLdVY1MVBDaExuaE9mclZv?=
 =?utf-8?B?VC8vbk5mNWVzUXRuYVg5dnpQWWowbTFFcVQ1a3luVGgrS2hwcGRSbUw4ejdw?=
 =?utf-8?B?REpoNWxPTHRDUjNaczVSSHBPc2lzeDlPQS8xQzJ1U0FjZjJBckFCTUFnSTdw?=
 =?utf-8?B?ZDZJbi9mUFQzMTZOb1hCUHdNVHdsMkZ3dE01b2pGdGVmU0tsblhQRmc5QThD?=
 =?utf-8?B?a08wRUZ2NHNMQ3YxNnJaTUdMMUlaV3owcHY0VFd2L1lqaTVpQmRsbDZOUm12?=
 =?utf-8?B?a24yZG9kMU54OTZzOWVqcEdNNFREMnU3NGZzSHNtRnhRZUVITnVMRTBEcnY1?=
 =?utf-8?B?NzJ0K3FjUUNya2ZXc0xlT3FCZ2tFeE9xWjJuMGFqSVVud2tEZGdRREV2ei9x?=
 =?utf-8?B?dGp1UmhOS3FqWmc2SkZyNFFyQmtWUGJuNmxtdGk4T1JrYlVEdU1raXIvcUdo?=
 =?utf-8?B?RWN3R21HRnBCN0FmM3JEcDc0bUwwT3FNckZHTjB6RUUxc2syalJEWG9kZU1X?=
 =?utf-8?B?T2RLV2ZnbWxzWTJxTkEvMlZyRWJPSmlNU2REdU1SMXpXSTVBOVYvYk96Smw2?=
 =?utf-8?B?ckVOdEdMRnQrSmRyL1RzS2FEMURQZTExcFk5dC9ySnlVUVJjWW5lemx0SDNU?=
 =?utf-8?B?SDhnS29jZmVxUlRTa3BUUDkzT1NCNUh3NGRMSzlRblJ5cnBCMW1vZVdja0Zu?=
 =?utf-8?B?b1NIdjk1SmF3K1BxQnBhNHJhNTJjNm91dHFqRDVqcnpXTjNTTllkbmZCOXpE?=
 =?utf-8?B?aFZzV2k1T2llWUc3bEJnV0JGU2l0TFd5WHRtYjFNWmU0WVYwcTNwYnZQaXJz?=
 =?utf-8?B?UEV6OHQwZG0wTUtlbGtvN29CZ1QrelZLdGdHdGloY2IrZVRjTHNBV0ZKWXJD?=
 =?utf-8?B?aE4rY2tEM0JobXJjOXV3RTBFYldMU1FvM3dNakpaYWhnQkJDaTk3Y3pHYUVV?=
 =?utf-8?B?ZVRML3AzTDNZWDluRnlYS2I5dWJvNythREIzNFlaMUJoK0N6TWl0ZE1mU1hQ?=
 =?utf-8?B?RGMyOTRiSmd5eDhwSjRBL25OYUI3eUozZnBpeXlYL3pKWHBMT1hIQVkyR0M2?=
 =?utf-8?B?eGRjUFpwbGZ3WlhkKyswemx2aklJeHFnYmN1NXRZeG5HSUF6ODlQOEhuTEM0?=
 =?utf-8?B?a0J2bC94UVpmNUlkckRRU3BybzFrcmF2WUlyOTY1ek9tSGl2U2QvVkUzZTZp?=
 =?utf-8?B?OGJmTkhuVVdVOU9SbmVGL0djbyszWnlGQlVIaHozR3VrVmMvL0lpdmVzVk91?=
 =?utf-8?B?OStKbklVSWl5Vjk3WGpjZW9Jd1ZIK1dZL3lJamROS1dCZXBsSVEwYWV4cXl4?=
 =?utf-8?B?ZnVYcFVnOEJOUWhLdTVJblhObnFFR0FCZk4zbWtLaUNuZFhTbzBvWVRZUmdJ?=
 =?utf-8?B?NkZvdGsyK3Y5YWtJV3EvWkxnQmZ4ckZtM1d5NkhwZVJIMGdrak9kNjZlUU9s?=
 =?utf-8?B?RWlTZXJBbmw4eHhlM29IVEFoS0E5YTMzdkxRbnovZ0thVlJBcTNac0Q1YzNC?=
 =?utf-8?Q?ksIVxc/y+2IkGE0z/3us9mm6N7lcKOTBjVWlICP?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(10070799003)(7416014)(366016); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVVvaCtqQTZyNXNKbnI4TVV1cWFJaG9FamY5ODUrZDk5QzZKNytsTks2K3p2?=
 =?utf-8?B?Tk5qZFFJeitEUVN4dnlsQTZrSWo2ZDNZS3ZZTGJEVEhRU0pLSlIraDRIZ0hW?=
 =?utf-8?B?MGp2aWRsdnBRdXFzVkFvTkwzOTVoNmdHd2kwTXpuZVhpNzR2VFVjL29ibG9m?=
 =?utf-8?B?RkJVNVBtT3Q3QWxWekY3bXlRWXA4eXRHUG9kVzN5Rlhxc09HZm1uUkRMUnY0?=
 =?utf-8?B?OVBmSzBsay8xWmMySkVtaWFiK2VOLzNzRXpyUDV6Zkw4b0tyYVVRbGluUlV2?=
 =?utf-8?B?bE5Zc09lNHY2dmV0WVB3Nzl0YXFTY250QmpPR2hCd2NQN0lodFBoZGdRdkE0?=
 =?utf-8?B?TnVHRnZUeU4zb2xGY1JxYndaWHV6UWVNL1ptOXdFWFVLZGROK3AwUElJNFNl?=
 =?utf-8?B?bUFHTVpqSXA2VkEyRGZ1WmVsaXpHSjJvVXVtb3dENm1GMDFIemR1VVJ1SnJs?=
 =?utf-8?B?V3IzZXUyVTRaNTA3eThxeldVWlZCQW5FQkk4djR3UVVGNFlhdFZVbEtpQjFB?=
 =?utf-8?B?S0c1RGtnbzhUODRkSHdqTXlQZE1UNGcyTHFtS3FUbWlzVnphbUY4K2JJUzZ6?=
 =?utf-8?B?SkVMMXJmYTlyY0puLzBSckdyOTlzTXhMWUhBV0pGTUk0WEt0WHd6RHYwYThN?=
 =?utf-8?B?TC91QVRwMGFleUxDRk9QcUZvb21hUEZTbldpNGhjek1Malc0QnlzUlY4TEF0?=
 =?utf-8?B?ZEZFRWplNHJLL0tjdmM2UHZVNldZVXRtWlJ4UU5ObEVXU1ErUFMyUm0xSnRC?=
 =?utf-8?B?VUtJTS9lUDdoYmx4YU1kb3Vac0hqQk92ei9zZnM1QmNvTWlpU2pJOFBWc3A4?=
 =?utf-8?B?RldzZlZSMXdIK3ZNTVM2SzNLMFZkVjhhdFNJYkRlaklzOWg3YnpNZ3AxVTdH?=
 =?utf-8?B?MS9UTG9yajVFOTVvbFBVRmVGWW02b0NZa0JLMFVvR2N2RTVYTVpiek1CTjdN?=
 =?utf-8?B?MDVBRTQxdXA3OFh2R2JVbUxqR0hDYzZ3Wkpxbk1FM29VZ3ZyYXJXWUJUa1cv?=
 =?utf-8?B?VGpSR0MxbFhkaEkzK3ZqSVJNODdDTUdMVmVLdWo5RzF5M3FHTkd3aDZjWkkr?=
 =?utf-8?B?M2NuVWUzSTNhQlgrSU1iZ1hxVGkvM2RsNXo1bENWRkpCcDM2ZnZsZjFGWVBJ?=
 =?utf-8?B?emQ2eWVVWm9lNTFlbDF0TWdpUGV4cU16TVBXcFlla1Z1UmFYM2E0d0EvTHhs?=
 =?utf-8?B?VGdtQitQdENGWU9nNnhCTFd3RzlzRUIzWWhaOUpkQS8xUXpzUUVHNDd0V0px?=
 =?utf-8?B?dUlwRjhPcnM0UlU5RGFpTVN6UTRzdWNKbElDYVpaYWcwUFQyVmthUDlkOTlQ?=
 =?utf-8?B?emROM3A4ZFBsL3crcW1jY0tiTVNtZVdNejRoUHgweGlFTCtGOElHMlF4RzFO?=
 =?utf-8?B?STB5Z0Q4MnZNWHAvdWVyVG5YVXpQeWk3czhCOWhMM1JOWEFjdFNpd0RhWjNj?=
 =?utf-8?B?K2ROaDhFVk1QOUM2VUNlUWMrODFEL0V0ckZKWG04eEJYL3JiUHZ2cjNYWndN?=
 =?utf-8?B?M1lHdkxGM2lOd1FOU1BST3ZRUEVHRWM4Ukp6em9RVUs1SEhUbmwxTXlMVjI0?=
 =?utf-8?B?YmxmVzBMczV1U2U0T3NnUS9KM0JXZzNuOEFXVGo2L1lvMHZxYzVaSjI1S2dZ?=
 =?utf-8?B?SXFIa3pMaTF3Z2cxOFJhSjgyKzJCZkhFV0djanM3dk45Y2U2RXdENldJdXNK?=
 =?utf-8?B?eHVVYkUyQ1dKMEdzb3hTcFZDMzlGTXBiSkNvRzBuZHcrYWcrQkkwdi9MdmZK?=
 =?utf-8?B?aTdBUFV1cXJWTExnNDZWMVN0NWhyYkZFeE9QRzU1dm1qMFZmNGV0N3Qyd2dz?=
 =?utf-8?B?cFhhZ1BoS0cxRVdEemdRTis1MjRIcXJ6eWFHZTRZaEVpUE83UzN2OThZZUVh?=
 =?utf-8?B?NDBoSkNNWkZ0aTRBK3FvMFp4SVFUYjhwOUZZOEIyOUFkaGZKRUdqUlEwU0h6?=
 =?utf-8?B?enRPRXhJbkFxbjJoUmFoRGtHUnJ5djJBWWZSM0IwVlpBdFp1MU81ekNrMUZs?=
 =?utf-8?B?S2pDd0IwTzB5ZGp4MzVRcE90NzF5MUg4eEdibUpqT1psY2doeW9scmN1bWk2?=
 =?utf-8?B?cWdxUUYrdVhidEdhMXl5eG9mQ2tvZURtemVmZWkxbWRBNjZvVmhpUXVtdS9D?=
 =?utf-8?B?NTdPUzd3V3R2N3BEN0owUHk0VDRTMHFxQzlCQkVuQWdUTTM4dFUyS3loSWx3?=
 =?utf-8?Q?f7W8pKGGagwbHjieLCJvkwk=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 279ee45e-6b4a-4e8d-1415-08dd4087d199
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 17:10:23.8984 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ASrPgsXDGgDTUGHQD9hbZri5kxw3tPtzhQwfaZQTB+fbMrdC5YyuyOc2V+kYbNvrOh9At3cdJvw0wZoOYbiIIIUVE9sjbFf7KdQxKv4MJA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9501
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

On 1/12/25 11:36 PM, Marek Vasut wrote:
> Add support for starting TFA from U-Boot running in EL3 as part of
> fitImage boot, so the user can start U-Boot in the highest privilege
> level on the platform, bundle TFA, Linux, DT into a single fitImage
> and boot such a bundle as a whole.
> 
> There are two main benefits of this approach. First is the ability
> to run U-Boot in EL3, where it has unrestricted access to the entire
> system and can act as a useful debug tool, as it was always intended
> to be used. Second is the ability to easily and safely update of any
> component in the fitImage, be it TFA, Linux or DT.
> 
> The boot process is similar to regular Linux with DT fitImage boot
> process, except the TFA has to be bundled into the fitImage. For the
> bundling instructions, see below. The TFA is started as a 'loadables'
> with custom U_BOOT_FIT_LOADABLE_HANDLER and armv8_switch_to_el2_prep()
> handling implemented in board code, and performing the handoff and
> boot in case the TFA was loaded.
> 
> The loadables handler is optional and meant to set up any sort of
> handoff structures used by the TFA BL31 or perform any other setup
> that is needed by the blob. The custom armv8_switch_to_el2_prep()
> has to implement the jump to TFA BL31 with return to U-Boot just
> before booting the Linux kernel.
> 
> Example fitImage image and configuration section:
> 
> /dts-v1/;
> 
> / {
>      description = "Linux kernel with FDT blob and TFA BL31";
> 
>      images {
>          kernel-1 { ... };
>          fdt-1 { ... };
>          atf-1 {                  /* This is the TFA BL31 image */
>              description = "TFA BL31";
>              data = /incbin/("../build/plat/release/bl31.bin");
>              type = "tfa-bl31";

This would need to be added to the ITS spec, c.f. 
https://fitspec.osfw.foundation/

>              arch = "arm64";
>              os = "arm-trusted-firmware";
>              compression = "none";
>              load = <0x46400000>;
>              entry = <0x46400000>;
>          };
>      };
> 
>      configurations {
>          default = "conf-1";
>          conf-1 {
>              description = "Boot Linux";
>              kernel = "kernel-1";
>              fdt = "fdt-1";
>              loadables = "atf-1"; /* This is the TFA BL31 loadable */

We have some special stuff around TF-A (and TEE for that matter IIRC) on 
Rockchip. The ELF is split into multiple binaries to load at different 
addresses:

rk3399:
  Image 1 (atf-1)
   Description:  ARM Trusted Firmware
   Created:      Wed Jan 29 16:24:16 2025
   Type:         Firmware
   Compression:  uncompressed
   Data Size:    143438 Bytes = 140.08 KiB = 0.14 MiB
   Architecture: AArch64
   OS:           ARM Trusted Firmware
   Load Address: 0x00040000
   Hash algo:    sha256
   Hash value: 
44285ea3a629cceee42a5fbfe838b6193e7c9a2f6643b0496dae617e2f7e2e8a
  Image 2 (atf-2)
   Description:  ARM Trusted Firmware
   Created:      Wed Jan 29 16:24:16 2025
   Type:         Firmware
   Compression:  uncompressed
   Data Size:    8024 Bytes = 7.84 KiB = 0.01 MiB
   Architecture: AArch64
   OS:           ARM Trusted Firmware
   Load Address: 0xff3b0000
   Hash algo:    sha256
   Hash value: 
7da49d2642204ded0a8eff093ae5c0e7300cfb18427d7a3e2f4e4cb227e4c2e9
  Image 3 (atf-3)
   Description:  ARM Trusted Firmware
   Created:      Wed Jan 29 16:24:16 2025
   Type:         Firmware
   Compression:  uncompressed
   Data Size:    4096 Bytes = 4.00 KiB = 0.00 MiB
   Architecture: AArch64
   OS:           ARM Trusted Firmware
   Load Address: 0xff8c0000
   Hash algo:    sha256
   Hash value: 
52c626d345ceeab61d8ede858a191834843f234cb4c2d2145546fd824e09c815
  Image 4 (atf-4)
   Description:  ARM Trusted Firmware
   Created:      Wed Jan 29 16:24:16 2025
   Type:         Firmware
   Compression:  uncompressed
   Data Size:    4096 Bytes = 4.00 KiB = 0.00 MiB
   Architecture: AArch64
   OS:           ARM Trusted Firmware
   Load Address: 0xff8c1000
   Hash algo:    sha256
   Hash value: 
50a7da66c26f838220d3befe84dd070988d238fa8abb34d1342815dae1083ec6
  Image 5 (atf-5)
   Description:  ARM Trusted Firmware
   Created:      Wed Jan 29 16:24:16 2025
   Type:         Firmware
   Compression:  uncompressed
   Data Size:    0 Bytes = 0.00 KiB = 0.00 MiB
   Architecture: AArch64
   OS:           ARM Trusted Firmware
   Load Address: 0xff8c2000
   Hash algo:    sha256
   Hash value: 
e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855
  Image 6 (fdt-1)
   Description:  fdt-rockchip/rk3399-puma-haikou
   Created:      Wed Jan 29 16:24:16 2025
   Type:         Flat Device Tree
   Compression:  uncompressed
   Data Size:    93264 Bytes = 91.08 KiB = 0.09 MiB
   Architecture: Unknown Architecture
   Hash algo:    sha256
   Hash value: 
9bcaaba8ea986042273421510acb76d5043bde550e463e80c2ee306239864f4c
  Default Configuration: 'config-1'
  Configuration 0 (config-1)
   Description:  rockchip/rk3399-puma-haikou.dtb
   Kernel:       unavailable
   Firmware:     atf-1
   FDT:          fdt-1
   Loadables:    u-boot
                 atf-2
                 atf-3
                 atf-4
                 atf-5

px30:
Image 1 (atf-1)
   Description:  ARM Trusted Firmware
   Created:      Wed Jan 29 17:06:59 2025
   Type:         Firmware
   Compression:  uncompressed
   Data Size:    102526 Bytes = 100.12 KiB = 0.10 MiB
   Architecture: AArch64
   OS:           ARM Trusted Firmware
   Load Address: 0x00040000
   Hash algo:    sha256
   Hash value: 
d3eb0776f5e1628eaaa38355992bc8a4cc8b12de565ebd6098897269e70345b3
  Image 2 (atf-2)
   Description:  ARM Trusted Firmware
   Created:      Wed Jan 29 17:06:59 2025
   Type:         Firmware
   Compression:  uncompressed
   Data Size:    112 Bytes = 0.11 KiB = 0.00 MiB
   Architecture: AArch64
   OS:           ARM Trusted Firmware
   Load Address: 0xff020000
   Hash algo:    sha256
   Hash value: 
19968b2d18472c485c02be72c609c2e9cc5dc4ea7993b86f462a788d109977d6
  Image 3 (fdt-1)
   Description:  fdt-rockchip/px30-ringneck-haikou
   Created:      Wed Jan 29 17:06:59 2025
   Type:         Flat Device Tree
   Compression:  uncompressed
   Data Size:    50032 Bytes = 48.86 KiB = 0.05 MiB
   Architecture: Unknown Architecture
   Hash algo:    sha256
   Hash value: 
f8416b75b2c0a16fd4599f47a4b24d763eb1e2dc0fdaac597510f5b907575c4d
  Default Configuration: 'config-1'
  Configuration 0 (config-1)
   Description:  rockchip/px30-ringneck-haikou.dtb
   Kernel:       unavailable
   Firmware:     atf-1
   FDT:          fdt-1
   Loadables:    u-boot
                 atf-2

rk3588:
  Image 1 (atf-1)
   Description:  ARM Trusted Firmware
   Created:      Wed Jan 29 17:08:54 2025
   Type:         Firmware
   Compression:  uncompressed
   Data Size:    204860 Bytes = 200.06 KiB = 0.20 MiB
   Architecture: AArch64
   OS:           ARM Trusted Firmware
   Load Address: 0x00040000
   Hash algo:    sha256
   Hash value: 
7612223b82b911a56f044a2be63befd1e0d47f9579c50e5b59ca62f12361912d
  Image 2 (atf-2)
   Description:  ARM Trusted Firmware
   Created:      Wed Jan 29 17:08:54 2025
   Type:         Firmware
   Compression:  uncompressed
   Data Size:    24576 Bytes = 24.00 KiB = 0.02 MiB
   Architecture: AArch64
   OS:           ARM Trusted Firmware
   Load Address: 0x000f0000
   Hash algo:    sha256
   Hash value: 
b2af21b50499777f862cc9d8d6ca9707248694b739badbe875e3b6834ae77e0d
  Image 3 (atf-3)
   Description:  ARM Trusted Firmware
   Created:      Wed Jan 29 17:08:54 2025
   Type:         Firmware
   Compression:  uncompressed
   Data Size:    36864 Bytes = 36.00 KiB = 0.04 MiB
   Architecture: AArch64
   OS:           ARM Trusted Firmware
   Load Address: 0xff100000
   Hash algo:    sha256
   Hash value: 
70505bb764db81a665c8bba4953d804ed9eab580d5428888a4436121eff11c50
  Image 4 (fdt-1)
   Description:  fdt-rockchip/rk3588-tiger-haikou
   Created:      Wed Jan 29 17:08:54 2025
   Type:         Flat Device Tree
   Compression:  uncompressed
   Data Size:    115080 Bytes = 112.38 KiB = 0.11 MiB
   Architecture: Unknown Architecture
   Hash algo:    sha256
   Hash value: 
c78f6f09dacfaf504d95d8f7d65ab8e0150b9014f033c5aaca85e45448fe177d
  Default Configuration: 'config-1'
  Configuration 0 (config-1)
   Description:  rockchip/rk3588-tiger-haikou.dtb
   Kernel:       unavailable
   Firmware:     atf-1
   FDT:          fdt-1
   Loadables:    u-boot
                 atf-2
                 atf-3

I assume this would be supported as well and we would "just" need some 
sort of SoC-specific implementation of what was added in patch 1 of this 
series? Is this what you're recommending? We would then identify which 
part of the binary it is based on the hardcoded load address instead of 
reading the load address from the ITS. Or should we think of a way of 
identifying them directly inside the ITS with some property for example?

Otherwise a global remark on that feature is I believe it may increase 
exposure to exploits. This means U-Boot will happily run anything 
provided in EL3. E.g. imagine I provide a script in the ITS which U-Boot 
loads and executes before loading the kernel, fdt and loadables. Let's 
imagine this is sideloading (we even have some wget support now in 
U-Boot so not too far fetched) some app to keep running in EL3 after the 
kernel has booted. Or modify registers only accessible from EL3. Now you 
better be even more careful about what you're booting from your 
linux.itb. Is this a correct interpretation of the situation?

Cheers,
Quentin
