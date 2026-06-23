Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6A83CDB46F
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 09:33:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07DB4849C5;
	Tue, 23 Jun 2026 11:33:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="OO2huqCy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1993B849D2; Tue, 23 Jun 2026 11:33:41 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D042C849BF
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 11:33:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UATbWQvq0gkpuulHVWp0PVbTWi1CyjaAq2KNA9yBQ75H0BROlUHkH2DhkozyztPPkwnSbtzAmbQm+8i4BDm69RuNAV1/TeYW+3VlfUgERJ9jmPR/h11OmwMZHiF6Ev1JZbfT1KefFoJH5f2A3oGuUR+Vhynw+kLJx7oFFT8i4fe3Z+kLwH8Dr1IDT69dDkIKZ7tbjOR1SH3tE9WM/ttt6hPCLgIhpsX+NoercR8k6JwD64aUc/SA6qrdQniS/gXNCJRgGZQJ5N2iuWXcRDv9+sbbFiJ0mmrtnPAv0/FtP0NRAJPAQzBErLBAvS1XPU8uloLwT2OdMpOO5PIVBVylug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zXpkHQ6sA3VM1rQjsJSTSUH0BXuglISo/w9l9w3nTe4=;
 b=X7rcwK4cyL2Ca4a2KL76Eaq0gVxgcrd/voargS2mnajmgEQjdSuxHYAqQtyZcBBghYQjDzDPVPoU4A8nn7Fv2laMAC4ajL9nINYPfo96GZWA8DQQVBZDkEVp7wpbHa5OSd7NE1aFqIKVCj3u+5O23smaJ6F9KneyhOXnuOgYepvRZcbfxuronVMJfouUUDq9DMGTlFlcVz+nnRscQLAPE8wGtgcYPzrmty/pvY3oH304FPuHzTQrt6oLUbaYeqrlvGgIqU3i6NRLLeRnPVLpjQVHlkxMZCJzg7mYa9D2R8mWkGr/P8ea07g8QgGSN/jYpYiOgPofTJYH4wAerfTYQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zXpkHQ6sA3VM1rQjsJSTSUH0BXuglISo/w9l9w3nTe4=;
 b=OO2huqCyCpnzCf/3d73XoBwcINfyAdyMgQOoWnC1TUyt5inZQcpHj7NFW14LGpNyk0XkODjELvWXGtXdiqklTRodgXw1DiTiDP3n9X5t/dDOoLINz4hCLk2UG+DObLVZHhQUfRYc+HjiAYSOeTM13ylqoycxzZdhIzpfolTbkH8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by DU4PR04MB10885.eurprd04.prod.outlook.com (2603:10a6:10:587::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Tue, 23 Jun
 2026 09:33:36 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 09:33:36 +0000
Message-ID: <e3fc0fe2-dbde-42e0-9512-6e7696625667@cherry.de>
Date: Tue, 23 Jun 2026 11:33:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] rockchip: odroid-m1s: enable watchdog support
To: Andreas Zdziarstek <andreas.zdziarstek@gmail.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>
References: <20260619220820.301787-1-andreas.zdziarstek@gmail.com>
 <20260619220820.301787-3-andreas.zdziarstek@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260619220820.301787-3-andreas.zdziarstek@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0016.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::26) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|DU4PR04MB10885:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d33ad1c-4573-4924-18e1-08ded10a7ffd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|18002099003|22082099003|4143699003|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: v2J9oyqCUWa3oPKWaEGgYlNTUdRx79cGqxuXz/HWQH5xhMCOm/4QmXUCns6IHs3UkGS8P1ki/utwwQBR79wimbKT5MrwjGaq0VTflDjTMptGQ10Y14m761xDvIM0uv5HysjWqnJA/e36D+u+bn1pAAKm2E93gIm2+vycv55W+bJpUvalJRpXyNZFRBsbQacOC/99jBJSIt4yfVSFAPmS3FgLv/0pAIhNmJ4CSJU0RmZVWQKDHAPlDWNqFm1l0BPyoQLYKy6iHKpw/bYGXb1ebyW5wt33dnyKofirVDCnxGZlZ+lm+MeHYBmHab65I2ksziUNyS6ZJ5qYnpJvnDF4VfbaVLifjqF9zAECQNEWgDFKGts6zLF6OnUftSW3ZyFoVYQjeVcqNzqp00bk/TVnL9ggRfYcRb2s4qxWkPd9aMdsLEOxz1coHZ0WZ5pcirRCrdRhRLK1UK0F8c6X04NjnEJ4+SpptqkhYGtd7/1+gbNQOYu4ZCi7ZpQMTnm8/LFApp/W4OKyewX2JMLDdulTEao74oMWIuVeWH4UYg4UHNVwGM/Rjjcl13cRD0m4Qw2ZxvGB90zB1l7BkfxGNdyiM6YqJC2iKpFK1SxyrwQxA9ene8i7V84We0yml20UGPegs3i76mdonZouEGQl0W9yUpk7Ozd0kbqNVj7u6AeF+us=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(18002099003)(22082099003)(4143699003)(11063799006)(6133799003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UTI0dVpVQkIvLzdQbXZWU0Vsdkx3QUNEZWNnRFF6Z1dLbEhXRE5VOVo1MS94?=
 =?utf-8?B?alVkYXh5MS9yTkFJekVDVC83RERQZzJFd3NuYlcwOFV4N0hQNkRxd1NxSXNu?=
 =?utf-8?B?U0Rlc0ZYRCtUbFNRb0ZWRjhHMHFZMkJEa0FPajliL1lFOVNuL3FhQlRKWFNG?=
 =?utf-8?B?RFNFUjFYR1pWeVhJVCtLdjc1OVlOSGhxV25HUlFDN2xMcXVmQXk1WDZGVGNl?=
 =?utf-8?B?NlFjN2o1aUxxMmRxa3I0V1MxbTlwdjdkZWZMdEtkaDliUXJxN0h3M1FQcUUw?=
 =?utf-8?B?TVE3cFdWMGVLM2lGNnVEcGpsYWdkZjNBV3NSNm9DOWh1RnZBWFA3eVZoN2tS?=
 =?utf-8?B?cnlieGdDaFZ4WXk4RFZKZEttNmZEQnNMbVlHWi9GOHBVU2Iwb0ZVQ0t0Q2F3?=
 =?utf-8?B?cXFGcnBlYmZDVGovNmMxVmhuYk4zNkZuT0ZWanZJU0lYT2NUTVBjU3ZmdWN0?=
 =?utf-8?B?bm5ack9QUW1WTlBKWnF1RE82QjZsNzI0V3RxalZXR1VyMy9tNFhrM0ZVTkdW?=
 =?utf-8?B?TnBDTVJCODllOEoxQngwb01TNlUyVFFHMGpVa3ZBS3ZNMU1OOStCdmVpKzBp?=
 =?utf-8?B?N0RNWEJ6alI5MGMyMFl6MndhVngvSUtmRWs4Yy9VVnBuRWp6SHVDLy9MWDlJ?=
 =?utf-8?B?cVhXRng4WXFwMXc1bVNwVkUzeEFTeGNMdXB0ZkM4WFdZQlo4MkNzUUVidTMy?=
 =?utf-8?B?NkNFZnM5TGQ3cXpUcHB4bnJLRlUzK2hXd0c2SlJpNHBHMVBiR0pXTUg4aVU2?=
 =?utf-8?B?Um5TWSszNmxaNE9QQkFuSXBhbFg5NXkvVStxQ3BSN0x6bFozSng4RnlvU20v?=
 =?utf-8?B?b1FQeEdaZ1hwRWtqOVUzWlFZMHNQcmp3ajlnWS9pNnQrZlBUVFpZU3M0V2ZF?=
 =?utf-8?B?T2tQc09kZlpZM2Z0TW1EYjNpV0xUbTlVdytEZ29ucFZuQ1ZLRmwrMVE4NDFB?=
 =?utf-8?B?ZXJIbUxPOHpYL1FzUlJia0JIc2lYUlZqOTlSQ1VlenliZFVzZlJRdlhodU9y?=
 =?utf-8?B?YnJCSjE3VW53TEpvdXB2UjltaW9mT2YzSjlSeFk4dVloVTAvZHVWUytUaVpC?=
 =?utf-8?B?TnlNUkhvd1pGTFJmcXZTNFYwemw5Y2cxOU9mS2VWVi9FUWd5a1FRZkxiejlw?=
 =?utf-8?B?eDBoaXVGOE5qUWRCdGdwcDJ6WlFZNTNzaVBVVXV1bEIwdCtHcFp4VlJRYlpL?=
 =?utf-8?B?eW90QkxkeU9rc3RzUXEvNGlKS3dhUEhvN1N6QUJyaEM5MHVyNTlQNEZObzFY?=
 =?utf-8?B?WEY4MmtwM2dZOU8yVFB0aGw2Wno3Y1djY3pxNmxKOWhpRzV4ZWVLcTFSRnZm?=
 =?utf-8?B?M0NnNUpwVjFvVkJWbG13djRTRmk4bUozYXdBWGhtWnVSY24vRzdNRjg2a3c5?=
 =?utf-8?B?U2VYUWNtay9yNGR2b3dDb2FXN3lJRTNGemVxR0NiMk5QS1hiUjU3cDBlQlBt?=
 =?utf-8?B?Nzh5c20rS1JvakpaNkFvSDJUbHhINGVDVjc3L1hBdmFOTUtUeVhEZXRscG90?=
 =?utf-8?B?YnV3MHFHeWVldWR5OUE1ZDkwb2srN01FVE1KWWJRQnJTTlEzblVUcUVaeHB4?=
 =?utf-8?B?WjFsbm5lU0h4OFhCTGNHeFlCaTFNMDdIWEFsOTFKdXNjWGRBNTdFM3ViWFVF?=
 =?utf-8?B?VC9DVVhncFVSbFMrREIraXBObWMyVVZJcVJycDVFMEZySlJiQXR0NTYzMDZn?=
 =?utf-8?B?OEt3MkVpZzQ2OTZGRjhKWUNGV1lOZTJGZEg4V1F3dFVDcTV2a04rZDc0WWJp?=
 =?utf-8?B?WWRiclkwVCtkT2RHek40dHNkZWtoSy9nREJTTlVJWW5sa2ZrclBScGcvM2dy?=
 =?utf-8?B?OHJpMmdKeTFKbFlsZ3RuYkR1eWFuLzNSTDNldjBPRFVvazRUMGJNRXFwSmNV?=
 =?utf-8?B?eUR5bmc4TCtRSDFIWWVtSUUyVzRYYlRFL0ErU0xzWkJWZDRUbkZLVXZDWEJi?=
 =?utf-8?B?cWl6TGRtbzJQNVhRTTUwVTU3WThvZzM2K3NvT3B6Z0oxRGoyaVgvc2JwSjFi?=
 =?utf-8?B?OHZHV3lvZm9DaGJ3cUxwbVhWZU1iYkNCWjFic282OHVqMGtUNGdRTWNBRmRT?=
 =?utf-8?B?VG5QSFArVG5MMHUrQ0huN0V6eEw5UGw5NmM0NnJtQ01qWVRUSkh3Q3VQVThJ?=
 =?utf-8?B?ZHBLMGdITUhaSTlMaVhVTFhTWW5IMGZNM1VFOTAwTUkvbWhqZ2ZSK1NjVGV1?=
 =?utf-8?B?TXBJMUVqTXh3akNPZDJ5dkViMnFZSHpKN0ZqeDVVa1AzdkxPakFVeDVGR3hi?=
 =?utf-8?B?STFuNk8wMzVmVlk5N0NxbnFQRGRYd3ZCR0FlMG1JRTlVN2pGVUp5b3lKeFpB?=
 =?utf-8?B?VzdOT3pCUUVSU3MrcVpjNFRWbXJwQ25XdkJKZVhPZm1zeEpUQ0VKUT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d33ad1c-4573-4924-18e1-08ded10a7ffd
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 09:33:36.1335 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nY+DBn9V621/UdydlrNNtqQvmHTqcZOWlJWx+LH1mIBcmUEe9TnIiKjGNQFc1crVSl2PqTXUlz7HOV4zmsjx7m2PgNl0EM8UjFpD1bBJ8TM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10885
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

Hi Andreas,

On 6/20/26 12:08 AM, Andreas Zdziarstek wrote:
> [You don't often get email from andreas.zdziarstek@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> The rk3566 ODROID-M1S has a DesignWare watchdog. Enable CONFIG_WDT,
> CONFIG_DESIGNWARE_WATCHDOG and CONFIG_CMD_WDT so it can be driven via
> the wdt command.
> 
> CONFIG_WATCHDOG and CONFIG_WATCHDOG_AUTOSTART are left explicitly unset
> to not cause any breaking changes on existing systems.
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Please note that an SoC watchdog may not be enough to be able to 
properly restart a board. When IO domains are in play (they are for the 
overwhelming majority of Rockchip SoCs), the SoC with the default IO 
domain configuration may expect a different voltage than provided by the 
PMIC, since the PMIC won't (necessarily) be reset along with the SoC. 
This is an issue on our PX30 Ringneck for example where you cannot use a 
watchdog reset if you're booting from SD card otherwise the BootROM 
won't be able to interact with the device after a watchdog reset (due to 
the power rails being stuck at 1.8V while 3+V is expected by default). 
Unfortunately, the Rockchip PMIC on our PX30 Ringneck (and on your 
Odroid M1S) does not have a watchdog so that's not an option.

Cheers,
Quentin
