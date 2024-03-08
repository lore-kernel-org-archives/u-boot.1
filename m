Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94884C5475B
	for <u-boot@archiver.kernel.org>; Fri,  8 Mar 2024 17:55:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E287187B30;
	Fri,  8 Mar 2024 18:55:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="KVTY5zJy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B093386D73; Fri,  8 Mar 2024 18:55:20 +0100 (CET)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260f::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DFA387B30
 for <u-boot@lists.denx.de>; Fri,  8 Mar 2024 18:55:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kdlYUYCod12VjZ9fUaIGX6cUeaRyUyzNfwWlTMSWQOdCr+LkI8Lpf553786j7B7hJYxK7V/NjTg0ZXCNlpR11s0jXDgN3jNETEMm1wmnORhOineFG4xZDaJBa/cH4IPCphbODcu1/WM0T3k56ZFKMQgvehDvvcDn0zdeMQEEDriu5sXnCv+5F2cZXgbaLcYbxynWtZgLge0SamQv6MLl2Z0mj7MlkGiYEg7bCZIol09nmjn7J+etDUEyoia6+42T5IrqiByT9R4eK6ucBxo2I0Ze0MYEY+jtxneTrt+vtFNLKeH+yomIGBP4FT3JfqNOvKSZljk2UU944+abfFtcdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hGWL4ao+buqFa9UfNd2Wtgcyt1KcI5kMNEwRRp6rkW4=;
 b=Gpr1OieiTPrdVaG3GpIe40LoQchaA1er5EYhM21bQdCiDAPghdhRfcDAdO3wFEUU6hOBey1EjqlLJc7aOHzd1WHTzrGOzpak/Oec08d23OYZBTHpiGc+YVH1/fqfxsQZEQNg84GUIR79KebiqXJn1wEqp9GMd5sHkdEPuQhMXMziesXHaA86NsIcytJzdwy7KrQZNxO/c+2+HH5FMr+E3daPoGQZaRZZVN1zOABTKzOh7trtSDQ0Dx1lWSx9CxrIYSAcF7bFtU7uTaftC5j9+133jroYiW48n4Hr7+hlRwO7c6ChU1EttzSrKuy8Z4aJ07/RS2VKGmXNvWCwLUeTRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hGWL4ao+buqFa9UfNd2Wtgcyt1KcI5kMNEwRRp6rkW4=;
 b=KVTY5zJyDRIaL57vIyWKBXaDrYeRwkTdwnjVTxLKe2gPfpBj8nIwUWmPl2F/mS7we/kAhwD1clyqMAAxl5ETZ7PtBudHVSUjRiWwbjxUPAgjKFlLh+qspgadReyIejNRItfFAMSaqs9t+sJ89u0sBqbuTT9QZ4p//FHsR9kfVBZvxab9oiBydMqNneT4B8tVRW/qcCt9fHQkAHS8vPmnepxZTLI2ibkNANX5FY9zQOO298PLn0xk7JhTxc04xjmT1dqfKzSjsv7CFg5d01N3r6BCY3W3EIaoGLiU5OBk1Qe450BwgENknFduipuVf6JXSuOeVUDsYHVsDrmttHIXSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by DB9PR04MB9792.eurprd04.prod.outlook.com (2603:10a6:10:4c2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.28; Fri, 8 Mar
 2024 17:55:16 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::23:4118:ae4a:8dda]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::23:4118:ae4a:8dda%5]) with mapi id 15.20.7339.033; Fri, 8 Mar 2024
 17:55:16 +0000
Message-ID: <5336cf3b-96a8-4b89-a914-9bcb7e489f9c@theobroma-systems.com>
Date: Fri, 8 Mar 2024 18:55:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/20] rockchip: rk3588: fix non-working SD controller
 if booting from other media
Content-Language: en-US
To: Kever Yang <kever.yang@rock-chips.com>,
 Quentin Schulz <foss+uboot@0leil.net>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>,
 Otavio Salvador <otavio@ossystems.com.br>, Andy Yan
 <andy.yan@rock-chips.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Anatolij Gustschin <agust@denx.de>
Cc: Dragan Simic <dsimic@manjaro.org>, u-boot@lists.denx.de
References: <20240221-jaguar-v3-0-1f256a82201b@theobroma-systems.com>
 <20240221-jaguar-v3-11-1f256a82201b@theobroma-systems.com>
 <343de261-41af-47e1-8434-ae0841757280@rock-chips.com>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <343de261-41af-47e1-8434-ae0841757280@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR04CA0134.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::32) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|DB9PR04MB9792:EE_
X-MS-Office365-Filtering-Correlation-Id: d796d968-38af-4877-cc4a-08dc3f98e96c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MxlgNMQlGOVMHwqRFUI9g3rbP4tlUFJZh9ySfL85hK4qRKkp3KToMaNt0wUIbcyBueDym2TBscuqcVSKai4JE+aQyPLkxea5UAP8iCJn24DMLYa7X8cF2Fi4XPLgZkWO2v5Nz235jcw6hTozDIsY1fPwdyRGx9uDg+brRQSHyb7dkWNjaZf3wnjho/x3oFdFdQ/1Lznh1pMrgGlR3c+tV+EH0rimg8gqCzRs5+YxOjJgSqwYPtTudZ6/JVWfcY2rhM6y5c7dP4xSVFij6xG8ar5aRsFlR5qdMhtgr+EIWk/zlid3OD+YZfkemeCjZO5IFb2JIbqAAn9MvKn/5y+Aimd9wioUoG6OE7U48iRuWG0sHwonI+mmjPNSZR4ZNLPYDf8gfGhQQocyENmJ0giMPz2jUjKzuWE23tlYcfv5XfCpNZg8U0cQUc26kqIZNgS58HeNOJc54bFLavWi1XqfhXQ+yIOVeOcCFE65WbiF6dan9BWsUCWX6DLFF0zLsV9Ts56BNHlM7cNBdDM3tS+nWiJXs/E64rysMPdY0P6vuCbSH78oBXi4GgZdFS7bToE440Y62hiN5+kHDWTXpv3AYFU5aOC623rRYeqo5QFt7/zWPpQJk4FPz+73X2NzPdBz+fF9hxfj52RZ722KHbANDPQePt96wIhYylHni4EMUPgTuyuhsYWFkufqb0QiMbrQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7416005)(1800799015)(376005)(921011); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHNEd0dLK3ZORnd3STdtVm5FVTRCL1J6SjZ3ZnF1b3d1dUhZWlBJQW9kRGVO?=
 =?utf-8?B?bFRzS0h1L0hLTUJ3c1FjK1lQeDUrWVBFRnR6MEJ6bEtrbitoVUQvYkhESUxi?=
 =?utf-8?B?d2xrdWlCU1J2dWprQlNwa3BOM1UrL1JBOE41U3VPTzVsVWlPZUplNFJwRHpR?=
 =?utf-8?B?YWQrTFNYMUpxamZLQTNEZlZIQnRIbEdhazkra3ZwOEtuUm1UdjlPaVFJajR2?=
 =?utf-8?B?b3ZvWC9yaldWZGVER1o1eVNOL0Z6OWp5NXdoa3I1TXRhY2daNlNZUWR6alNw?=
 =?utf-8?B?K0RYamV4TEhzVlJyVHA3SU1DL0NId0UrOVZxcGR2c0o1c0NkSGxuSFQyTGdn?=
 =?utf-8?B?Mmcyc3hsdHp2d0pzN2xkUHJjOEw2R3Vyb3dGYmJQTjk0cDU4SWVQdjNmeUdO?=
 =?utf-8?B?Vkh0bWpicHhFclF1dHg4UnlwN1ROaGJNOWxNTUh1RWFmNFZxVFhJV1J6eGcw?=
 =?utf-8?B?Szhid3NyNjU3YjJpRlFVUVViSzJuV2hUMHN0c2JZTC9KTGlnYnZrMXlRUlhS?=
 =?utf-8?B?dEZpVW0xSVRTcjdhRytjN3lCZ0hFZ2QrcEZnYk9KRzNRMC9KQ09kSnlNQmgy?=
 =?utf-8?B?VUwrZGEzY1AwelNEcFBXdmwydi9UWG5lTWd5eG9kZDVhQVBmdXgxOUdIalhh?=
 =?utf-8?B?K1lTRDdTM0FYQ2ZoTXFWRGc3dG9YRGM5Z0JFY3hvejZ3citHeW10REpteHRP?=
 =?utf-8?B?MTVaVWZDTUpObVlYZHJVUnhRZGpqSUNMNHJ3ZHdDNFBlWjB4K29mcHNneFp4?=
 =?utf-8?B?UVI5ZnlGT0l4d3p0UVlFOE8vMzlsaEJiZmlkYlQwRVhkU0RyYmJwWTdhN1My?=
 =?utf-8?B?ekViRXd4TlhodTcrcVhRMVZXVDVxRkxMYTAybUVaSHlPaER1OWZvM0pQVGEw?=
 =?utf-8?B?a1V3NUJmeHNoaE5KWHJ2MFpjN2hsZ05reFRsR2VpaU1XUmNpTllLeUF1aDMv?=
 =?utf-8?B?SzBRY3pZRWVNZG5ZMVZGdVAxS3ZxUlIwY1B1RVM0NTE1ZnlOOVI1blRlQTd5?=
 =?utf-8?B?aVVNczZERnZtdHJ0N2hIOHJBS2hVZTluWjJLU0xzdmt1WlRKZDBna2xncVlS?=
 =?utf-8?B?M0NaN3VYYWJMRFZqWXBMcXgwVytFV3RFNE5YNGhYMXhTVmJ5NDdMd2ZvUUVa?=
 =?utf-8?B?OTl4T25EYStzeVZoYXlVSHZiVktJNzhZQlZIOG4vVnEyVDFpY09wcHpZcnZs?=
 =?utf-8?B?K290SkkwanQrTVdBV3doaExzblhqbHNRVit5RG9FbkxzWTRiM1Q3TXBhdTdy?=
 =?utf-8?B?N2hVZlNMQjlXbmlIQmVoRWxHN296UkxmN01sdTBIdDYyekFSOVd0WGdKVmo0?=
 =?utf-8?B?Nmp4L2tpdVZzbUJvVTE3eTg5SkUranR2SW1SZDNZenJIaGxzWk9uUURPUytN?=
 =?utf-8?B?cXVTS1dGa2hpWW9zYm9hUjQ5YXlSbmZnYi9QT2RaanRiaE1NZ04zYzJZeExx?=
 =?utf-8?B?SkRQWVNaNnpHZXYwdGVPVkROOWlXbVR4NENwbUwzMzFPdk9JQ2FjY0hpTUtq?=
 =?utf-8?B?Slo0S2dLdkhYbVk3L1VNdnFMdzVSWjF6TGw4ODhYVHpneUVoZG1qdy9yYzh0?=
 =?utf-8?B?ZUo0TlNTSEhPRjRMeTlQWGNMK2NOV2FEcHZvc3YyemdIWCtwWTg2WUoyT2k2?=
 =?utf-8?B?NUVHTE5yY0FnVEFaZTd0VXRFNG82b2tWc1pMVzhPQVRDN1lKaWtRZzVWWmo2?=
 =?utf-8?B?NHp3UE14aGFtaTRuWlRXZzNuYUM1MkZ0d0pHLzVzMlNmcEJlUi9PejQ3RE1Q?=
 =?utf-8?B?WHF5WWk4MVdpRmRUOHZZQ2kvcTNYZ2VPemljUi9XWUY5RnV3eUl1WHpmZFJi?=
 =?utf-8?B?dVoxamc2RDdURHZNMTgzcEFKVUJLQjRxQmVkQkp4akhzUVFNVmNKSzRDRTFv?=
 =?utf-8?B?KzJpRldCeDVDSTh5Z0R6YzZOdFl5Wkt4VUJnaHVNNjR4bHVPaTZJdjA2bTI0?=
 =?utf-8?B?djNMU2tHYTFDL0RLWCtpLzcrYzhtUURkRWlqMngwUW9vVStjZXorZ0FiWmRr?=
 =?utf-8?B?aW1yZTU0ZG5hR3RpbGhuclMvc1JwNlVJalBUdTlxMjdiS1ZKS0JoWXE5OXpw?=
 =?utf-8?B?QjMyREVYUjR0WEVzQktQc0JjN1d2Z21tMk00dUlldDR1VFF4dHRKcm9QaGUz?=
 =?utf-8?B?d3FDZUtJS2ltMDNQejVRcGR1WURsazlzMXZhYUFmYktDS3Zib2tBT1MycXF2?=
 =?utf-8?Q?8DLgKgeO/PI+zoWV+9U1gzs=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d796d968-38af-4877-cc4a-08dc3f98e96c
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 17:55:16.5317 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q9iaZNpyTB2f3f6/zJXNYXDqohZw0e6mOO2JIa0X86taTxZUV2bqnY48bsEv/UFqUhUgnLbPKQCekILfh+fbl6GjyB5Ahxvq1Qyl7v0o45kfkbS/99QwW90Qapd+kGHQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9792
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

Hi Kever,

On 3/8/24 11:05, Kever Yang wrote:
> Hi Quentin,
> 
> On 2024/2/21 18:37, Quentin Schulz wrote:
>> From: Quentin Schulz<quentin.schulz@theobroma-systems.com>
>>
>> Rockchip SoCs have some jtag/sdmmc autoswitching that simply doesn't
>> work really well.[00] The Linux kernel disables it for all SoCs[01], so
>> U-Boot needs to do the same in order to fix issues related to SD card on
>> RK3588. This autoswitching is enabled (by default) via the force_jtag
>> bitfield in SYS_GRF_SOC_CON6 in the TRM part1.
>>
>> The conditions to enter forced JTAG mode are the following:
>> - force_jtag is 1
>> - GPIO4_D2 is muxed for SDMMC function
>> - GPIO3_D3 is muxed for SDMMC function
>> - SDMMC_DET is inactive
> 
> I have explain the reason and send fix for other boards  in kernel for 
> why the force jtag
> 
> function not working correctly, see patch [1] and I copy the commit 
> message here:
> 
> RK3588 has force_jtage feature which is enable JTAG function via sdmmc
> pins automatically when there is no SD card insert, this feature will
> need the GPIO0A4 works in sdmmc_det function like other mmc signal instead
> of GPIO function, or else the force_jtag can not auto be disabled when
> SD card insert.
> 
> For the rk3588 boards available on mainline kernel, 10 boards enable SD 
> card function
> and 9 of then use GPIO0A4 as sdmmc_det, they should all able to use the 
> force_jtag after
> my patch apply.
> The jaguar-rk3588 still have the issue because there is no sdmmc_det used.
> The condition of force JTAG mode work correctly is :
> - force_jtag in grf is 1;
> - all the SDMMC signal including SDMMC_DET set as SDMMC function in GRF 
> IOC/IOMUX reg;
> 
> So please update the commit message and it would be better to move this 
> setting in jaguar-rk3588 board

Thanks, it's a tiny bit clearer to me now. We never exit this JTAG mode 
on Jaguar because we have GPIO0A4 floating (with internal pull-down). On 
Tiger (patches coming this month I hope), it's hardwired to ground but 
we use a different GPIO as card detect, so we'll have a similar issue. 
In any case, thanks for the explanation.

Though, I do not understand why you absolutely want this force_jtag to 
be always enabled. It is a debug feature.

Even more so, this is a security issue. I don't think anyone wants to 
have the JTAG enabled if the user plays with the card detect pin or boot 
without an SD card connected. I really insist this should be enabled on 
the SoC level, the same way that the Linux kernel does it.

We could compromise on a Kconfig symbol to enable force_jtag for people 
who want it but still default to disabled on the SoC level, but I'm not 
really seeing a reason for it.

> so that other board can enable force_jtag with only modify kernel but 
> not both kernel and U-Boot.
> 
If you want JTAG support in U-Boot, you would patch U-Boot. If you want 
JTAG support in the kernel, you would patch the kernel. If you want it 
in both, you'd patch both. I'm not sure to understand what disabling 
force_jtag in U-Boot has to do with force_jtag enabled from the Linux 
kernel, what am I missing here?

Cheers,
Quentin
