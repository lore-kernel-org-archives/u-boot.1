Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E3A7CDB470
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 08:10:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D4A0849BB;
	Tue, 23 Jun 2026 10:10:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Zqn/sFYo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CC63849BF; Tue, 23 Jun 2026 10:10:06 +0200 (CEST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6A44800AE
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 10:10:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uP1EMsmvwBqdgApmTwoT1HVv3R8UQNO12EEdaHgW0Rim51/MLovUfGPwQKrfdIo2FUpHx+9pmbubca5QPm28OhQzbGx7R6q2Q7SKTV0xejZoVtz/Fb1hnVgiRosb2i2ySU8KxrDse7vTZJQd8+NP5vk3MJLKPPxq7322G5OTg3iojdtfsfcVpCudWe7sV49iAE91MqRjm9CCzS6zk06vYoOS7pVvXHIEeuvcLfdkG+fMkvHT+XmZYCXIrJLczDKM5SSdYqwgkW1QHg3PPQaQVP5jb35UT/QyrsClp8rtNFaEHoh3w9QGIM2ZzDgllAQMmGYFDPqT27PLBiyV7E8okg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UU+XtbNmbiHpDJ4+lM5YjqeJuKEDd5UtH/L3Ap0bWBk=;
 b=w7TUq/wH5roUeAGwh2NHcqaZAa1zkVgvU5NKVGr03F6QSdmmJFEbl+mXoeapqQlWcBoJBqNwd0yre3FnoG7dW65HCC3Zr8Ntet8ObG38Vb1qAghvYBLrsXktmdhhszTSz31jxMMSXNv4KWxiVWOHTasYz0bW6Sjab0c8eg19Cx4MuOeDLKtY35k+UyQgLlHxOBP6cx0rkYwEyyJKw4n8+6Ab7lDcoE47rcjzZjANpbUQqkIUDgDnYNNAl96Iz2sdTbOSS0PA/G1Ug68T04A1Mc1eYoGyoIH55wkcbIo/9ie8/W5rfTRhrZxtsJyy14/bA7uxppJZO0bDryh14+2VDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UU+XtbNmbiHpDJ4+lM5YjqeJuKEDd5UtH/L3Ap0bWBk=;
 b=Zqn/sFYoHoZNr1de8diP7puHJcKh7CbpMLqq/Y9DQxvAPnrUorIo5M9zyGAh8g4mkt5s8xqBaj11lOKTQX4juUQaCbIQgfB1B1ntyelABU2BJGKYulTYEvWjZGaTvkYmf0UEoyIfHiJHTHoxEAdrtsT8P9rATLtLe6dJ3CbXMnY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by SN7PR12MB7833.namprd12.prod.outlook.com (2603:10b6:806:344::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 08:09:58 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 08:09:58 +0000
Message-ID: <f75a835c-d3ee-4c34-92d2-dddcfc028ad6@amd.com>
Date: Tue, 23 Jun 2026 10:09:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Replace Zynq/ZynqMP with N:
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Michal Simek <monstr@monstr.eu>, Tom Rini <trini@konsulko.com>
References: <20260617024902.153555-1-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260617024902.153555-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIVP296CA0047.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:353::9) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|SN7PR12MB7833:EE_
X-MS-Office365-Filtering-Correlation-Id: 31ba40f6-d691-403c-f0be-08ded0fed136
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|13003099007|6133799003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: wRP/lryIGoQYcP2WPUx6yVOida04rvgFjMFspwCpXGUigxLA8rittXYwGLOkb4/VDkvKhr2o33QFHBy1fyJikNSnXH6z/qPhz94tR5R+lR8K8RC+AUUT0fvgvYY4lvn+i1HNl7jdget+GM1wm4YYvQEJ3y3HX+JACtNDKPMTCXd0Tp/hcRyYiHf3H/01XEBFKaTs12W0WRNNPqiW+0g05b2BhVWJcDQWxi3A1QVqAfvIEfiHPLtmksxn4gCvif0rvLESnT1bP9gZObSEPRblZ9FtK56qfpG0qG+dcsSzuZuo8p8/oMj4dh0dhhOlddgakAWlghkJ2+fKv1W+qzRJnmB7G2Y9jf3q0Krw1MbB+b78yy5GdPEEHmbY6TAGyMytwjvNdJnVJkcnklviekSY0wWKqpqik90htjMUKwR6s9nR95ipIF16eCj/buluYyoR9HSWLq1Auwlkxgznl7wqn5jM5MmJczcoE86g3fkE9a7eonCOIomtpHW6Hw3AhtCjQ6Xb99+8OzNoPzHC2I9ISq8jocTOyWcLyQM1CSF8pZpIXJ2EJbrSXCMnSXSGp9SBZ2vaMiWCZSNx9KI5/Hki0vXXeIBSpkob5b2DnFNZdYm/gFysgnwJrtnKbNFfNWHP
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(13003099007)(6133799003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVZrSk1ndjh1cU5jaFNWVHZTN25PMjJVaXhDWWhkN0U3MEY5OEZjNkJqaUlC?=
 =?utf-8?B?OUp6Z3BQRHJWSmZQTU5TeVVjVGVDbkp3aE14ZXZjOGthQmR3SFRrSFhyMW55?=
 =?utf-8?B?cWVBb0pDeHJkKzc3RWovNXFuS1g5YVlVR3Z5M3RMdlJvZ2l3ais5RVVmTUZj?=
 =?utf-8?B?bVVFVlk3aHE0OEZ6ZHR6d3hlb1pRZWtmN051QTdXZ25Xanp0UmNadjFqSnFa?=
 =?utf-8?B?VVpSTHRIMjl3N1RwNHFkYXJxa1VrYVF6OW96WFFEZ0puSWl4dHRVaXBKS1M5?=
 =?utf-8?B?S3RlR00rN0tScjgrUVhpNnBLeWlXN1gzZC8wMHFDUjZSUU1YZXB5ZVN5NjB4?=
 =?utf-8?B?MWcxTjJKZW9kdWwwek9ZVmxrSGsyNDgwOVpydHF4T3dOR0hucTVFVDBLQkNR?=
 =?utf-8?B?VjhNdWJUbmY0MUN5R1V0bWVrQkY3Vld1NUZVWHd2eXdwQVRDbUQxQjFneHda?=
 =?utf-8?B?dlplbXFkcFFKQ1BUTWdkVTRIMzk0c3F2VllDQ2x0MDZxdk1hNHo5dHMzLzlp?=
 =?utf-8?B?UTFHY3dyZitQajlQeUN5STJnUXptM2RDc3R4WEJHNzZFMWs3VzZFcEIzSXdG?=
 =?utf-8?B?K0pHUGtSbmRWNFhFcW5WRGg1dUhYZFA5eUJiTjBtdEZtd2RMWHlRdklIaVpt?=
 =?utf-8?B?THl3N0trUmJmTlE2TkpaQ3BDdjFpZloyeVpCM2xOYlNrclM2KzQzWkx2Z1pL?=
 =?utf-8?B?YXE3bTFqZW9yZnZFVGpyTTFrNStYY1VzU1lDYXRPOWRJOG5EdEJCczFXdVNz?=
 =?utf-8?B?bUZxaFg5TkI1c3B2L0oxN1c0cHdmcFlUUUNKbjA2SU5sQmZpc2trKzlTWVVN?=
 =?utf-8?B?ZkZoTGE2Z1QzY1hqWnUybmJqbyswd0hHTmhqQk5aWnhqUmNjb294ZmRzaFov?=
 =?utf-8?B?b1Y0enY2TXErbVVPSFMyQlhRdHRPRlRtcW9mNXA2VmRKdlVQVGxnUjcxdjdk?=
 =?utf-8?B?dDN6a1BRdm5pd0NlU2NuYVdxdmhGZzg3TlNjQjhsVFJMMlNIMDhzYXVrcjVQ?=
 =?utf-8?B?eEJPQUxXUHl0SFE3Rk9UeUFLSkRZTHBUU2w5cFB0aTNubmhEYjZ2NkZtZWFx?=
 =?utf-8?B?Qkt1c0U1V1loU2RvOWxhQWk4b3dxd1Znak53d1Q1bG1oNzhiMEJ5ZCs2bFJO?=
 =?utf-8?B?TjI0UDFGVHhhUmt0TlBSM21lcTlRRUQ3a0YyOENic3JqMzhhV3YyQ1MyTzBq?=
 =?utf-8?B?MCtJU0MwVGhiTEZ5RFp0dGE1L0pnZ3BGa2tzQUxYaE40azBMT015VkpQdVU4?=
 =?utf-8?B?Q3Z6NWVCUDhBOVJlSlBvMlZhN0ZCSVQ5WngzNGphNENXYkNhOGJqbXRwQUJO?=
 =?utf-8?B?U0NLNUtFSnhtZzIwUzBiSXBsNXlEUmJDblFXUHE2cWpsRlVrSUlvL1M3WWlE?=
 =?utf-8?B?bmVOMDJqL2pjREtob0xvQmcrSXdDMVpEUE9SUXpIQXE3TjluNFJvM3BRdkdu?=
 =?utf-8?B?Nmo4L0NJVFByTU9hNnM1ZVU4cW0zU0tnSVVsN3M3Q1JhWFlHc3pZVnRqMHNY?=
 =?utf-8?B?YTlVK09iWXRIZi9pbXlPeWNPWTR3aERnRGU3TEtTcCtuM0tvL2htMWpwYUFj?=
 =?utf-8?B?TXpTLzhwSzV6VGdIMEMxRmpKV3A3VFpmUHRDMjVtNHZ0TS94SXk3NHhocXpF?=
 =?utf-8?B?dU5DSThDTjBQVGdIVnlTcCtTb3RxMmNyZEY0OElHc0UvOWE0amJCTlJJSm15?=
 =?utf-8?B?ZExEQ2ROdHdod0ZzVTE0Q253L2NOQ0hQQThzTlhtMmlLSnlhTUJTYWErdENt?=
 =?utf-8?B?K09Lc0hFZDNRNnBRN0dsaTN5OGgrUG9FeG54WnBsL0tQRTRWdUpHaW40eDBK?=
 =?utf-8?B?QnhVRHVYUSsrekVTLysyb2lhM0g4b3Q4UE1MeEVhOWJ0UjA1MExRdDVyYWNU?=
 =?utf-8?B?WnVHd3J2cnBtRjJYZW1PalZmTGtFM1BjZ3FoMUFoZXpMczBlMVZCd3hQOW9V?=
 =?utf-8?B?MENMNyt2MmhnVGUvY0dkKzMxVkgxRjZLVGJqQXdSOWMyYktkTENMSWZ3U3Rq?=
 =?utf-8?B?WU1XVFg3bGt1Q0JNbkVUbzBvWVZkQ3BHRFVIUENpR1ZDcnBHUjF6d0FYS2w4?=
 =?utf-8?B?NDlESUVSZklnL2EvMHZZOE04SVB5dDFUZWp0KzAxNEZyUU5aRVk3NDVtbDJo?=
 =?utf-8?B?WXo0cEFPcENpOFJzb0p1aEcxeVl6U1loNmdkZndTN0pOMFBCcElpMmwvRWFT?=
 =?utf-8?B?bUZ4RUZSOFgvUVQyZkRjZ1dLSko4NjFNbnRRdUR0REhzVEFWZzNJMDhNQlZr?=
 =?utf-8?B?R3NKMWFMRkd2bkFwY1NQd0czZURmMzhCT2lCcXcxR1Z3S3QyRzFWMTF4UjVE?=
 =?utf-8?B?WHQrUi9sajU1eDJKVHdQZmwxWXRtSlFJcG03VFVnbHVzZkhFSUE4UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31ba40f6-d691-403c-f0be-08ded0fed136
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 08:09:58.5061 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4AXEF7aEFHvhD6npDCwU7ezrq5lunsOgKJfJXJIp68VfykXAKesgp1PF6JsWgkGE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7833
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



On 6/17/26 04:48, Marek Vasut wrote:
> Use N: to match on all zynq/zynqmp files, drop the large list of
> entries which represent the same set of relevant files and miss a
> few in the process. Combine Zynq and ZynqMP entries into single
> entry to further cut down the duplication.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Michal Simek <monstr@monstr.eu>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
>   MAINTAINERS | 56 ++++-------------------------------------------------
>   1 file changed, 4 insertions(+), 52 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c862b206a85..7eeaeb4583f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -749,72 +749,24 @@ T:	git git://github.com/ARM-software/u-boot.git
>   F:	drivers/misc/vexpress_config.c
>   N:	vexpress
>   
> -ARM ZYNQ
> +ARM ZYNQ and ZYNQMP
>   M:	Michal Simek <monstr@monstr.eu>
> +M:	Michal Simek <michal.simek@amd.com>
>   S:	Maintained
>   T:	git https://source.denx.de/u-boot/custodians/u-boot-microblaze.git
> -F:	arch/arm/mach-zynq/
>   F:	doc/board/xilinx/
>   F:	doc/device-tree-bindings/video/syncoam,seps525.txt
> -F:	drivers/clk/clk_zynq.c
> -F:	drivers/fpga/zynqpl.c
> -F:	drivers/gpio/zynq_gpio.c
> -F:	drivers/i2c/i2c-cdns.c
> -F:	drivers/i2c/muxes/pca954x.c
> -F:	drivers/i2c/zynq_i2c.c
> -F:	drivers/mmc/zynq_sdhci.c
> -F:	drivers/mtd/nand/raw/zynq_nand.c
> -F:	drivers/net/phy/ethernet_id.c
> -F:	drivers/net/phy/xilinx_phy.c
> -F:	drivers/net/zynq_gem.c
> -F:	drivers/pinctrl/pinctrl-zynqmp.c
> -F:	drivers/serial/serial_zynq.c
> -F:	drivers/spi/zynq_qspi.c
> -F:	drivers/spi/zynq_spi.c
> -F:	drivers/usb/host/ehci-zynq.c
> -F:	drivers/watchdog/cdns_wdt.c
> -F:	include/zynqpl.h
> -F:	tools/zynqimage.c
> -N:	zynq
> -
> -ARM ZYNQMP
> -M:	Michal Simek <michal.simek@amd.com>
> -S:	Maintained
> -T:	git https://source.denx.de/u-boot/custodians/u-boot-microblaze.git
> -F:	arch/arm/mach-zynqmp/
> -F:	drivers/bootcount/bootcount_zynqmp.c
> -F:	drivers/clk/clk_zynqmp.c
> -F:	driver/firmware/firmware-zynqmp.c
> -F:	drivers/fpga/zynqpl.c
>   F:	drivers/gpio/gpio_slg7xl45106.c
> -F:	drivers/gpio/zynq_gpio.c
> -F:	drivers/gpio/zynqmp_gpio_modepin.c
>   F:	drivers/i2c/i2c-cdns.c
>   F:	drivers/i2c/muxes/pca954x.c
> -F:	drivers/i2c/zynq_i2c.c
> -F:	drivers/mailbox/zynqmp-ipi.c
> -F:	drivers/mmc/zynq_sdhci.c
> -F:	drivers/mtd/nand/raw/zynq_nand.c
> +F:	drivers/net/phy/ethernet_id.c
>   F:	drivers/net/phy/xilinx_phy.c
> -F:	drivers/net/zynq_gem.c
> -F:	drivers/phy/phy-zynqmp.c
> -F:	drivers/power/domain/zynqmp-power-domain.c
>   F:	drivers/pwm/pwm-cadence-ttc.c
> -F:	drivers/serial/serial_zynq.c
> -F:	drivers/reset/reset-zynqmp.c
> -F:	drivers/rtc/zynqmp_rtc.c
> -F:	drivers/soc/soc_xilinx_zynqmp.c
> -F:	drivers/spi/zynq_qspi.c
> -F:	drivers/spi/zynq_spi.c
>   F:	drivers/timer/cadence-ttc.c
>   F:	drivers/video/seps525.c
> -F:	drivers/video/zynqmp/
>   F:	drivers/watchdog/cdns_wdt.c
> -F:	include/zynqmppl.h
> -F:	include/zynqmp_firmware.h
> -F:	tools/zynqmp*
>   N:	ultra96
> -N:	zynqmp
> +N:	zynq
>   
>   ARM ZYNQMP R5
>   M:	Michal Simek <michal.simek@amd.com>

Applied.

Thanks,
Michal
