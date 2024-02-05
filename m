Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C295C48295
	for <u-boot@archiver.kernel.org>; Mon,  5 Feb 2024 13:45:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D21086F8E;
	Mon,  5 Feb 2024 14:45:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="BlzfVH14";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50AF08792D; Mon,  5 Feb 2024 14:45:18 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2072c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::72c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D837886F80
 for <u-boot@lists.denx.de>; Mon,  5 Feb 2024 14:45:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e+ZWylQey/5IhjBwhK6O6VHvxVxTbQNjHPOQ4btzhEdJ9BEWtOVgrLy8FZKSLRJNs+BCBrTvim3mTBdiMY9uJSvFELZjuCN4Jjlda5OjtmWOT2ZAD3+vbcBypZFNzfwIYAuAnCaRqwqKr1tSXkiG/5ffNwsRLbadIP+BU6LvH06yMYtqFtpqa38xPd42dOu4hHkZUXqhITkG/ex8JeBSOA9Odon4b6yGDd8xawJ6+7T9JXA5Ksc26OTM92YaO81RHcbWBE3D2khnNxXU+x9TRDL0a+emMG9K3ASlSANApxmkbWsqMJKRjMvOyRPr7GXmYhwN52SAxXX5DaEFwm2ujQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KXSTvJqEbwRLSt0bgRSJhwSI0I5xE2nzVefHor7vPpY=;
 b=IV4006eW/cEROGbUthkTWZqaGEA3DEEkF01Y10PsfTn94hE828euvWJnhg3EQP29xr+7O4L5J5GGxWAnKWHr75dl90pIMqXmpi1srQ3twTOauU+sdDlb1pIzoCwy0CrLPq9e69bjAuOKrrMtl9uL0sMcUjSu0zPqmNJk0MEMbGDxF/4fE3guvuzKM2BlUjBocNDd2ncsRx4i9Z45dr6pCPIbtANkO5VZlK8nodkr2ZoctJKoTwwuuUCnH9149nDj9Ub/vwLjghud1tOXy8Qk4K1E+apxzAoKtgi5wnePMDJUCTP0VBadbEKM0s7C1vWTEdxw6DrrOzzdbkKF1pn+sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KXSTvJqEbwRLSt0bgRSJhwSI0I5xE2nzVefHor7vPpY=;
 b=BlzfVH14Az5q5YDhx7hvjTeUJE/SxRF+DjLp45mR9ute+JmrfdyPSZjUC2IaTa9E6fIV9XJ2+XrgRWcsqqcKveGs3ZpfNEDeyvpzGtH1vVZBa31+2MXuy9CXWB4AEcPY2Hm8WXC7S0EV2Qbn/MNWbjleFMBacD+I8vuv55QJsf57fpkqRbxku2FjhsYnZu03Na5D+lmTKWarfB0BRkUHAlgoLFaUh022SGF4GTViuWBeP1f6dYbdsl/vaS0ORbfIl1nKT8DyFclzM08TbRfm5wRl4Qm5nF4aYiDrHYCYZRLMEWUv7OfYaytw5+COcTAceyY2FpfUeQsqW23vXrngyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by VI1PR04MB10025.eurprd04.prod.outlook.com (2603:10a6:800:1e0::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 13:45:12 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e%5]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 13:45:12 +0000
Message-ID: <be5b2bd5-f855-4585-b59d-c6d0c1df16d4@theobroma-systems.com>
Date: Mon, 5 Feb 2024 14:45:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] rockchip: rk35xx: Remove use of eMMC DDR52 mode
Content-Language: en-US
To: Dragan Simic <dsimic@manjaro.org>, Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Andy Yan <andyshrk@163.com>, Tianling Shen <cnsztl@gmail.com>,
 Akash Gajjar <gajjar04akash@gmail.com>,
 Eugen Hristev <eugen.hristev@collabora.com>, Joshua Riek
 <jjriek@verizon.net>, Weizhao Ouyang <o451686892@gmail.com>,
 u-boot@lists.denx.de
References: <20240204205312.2342868-1-jonas@kwiboo.se>
 <20240204205312.2342868-2-jonas@kwiboo.se>
 <3ec22d95-ee0d-4a0b-8c0e-90067ba0dc32@theobroma-systems.com>
 <b889d4e3-f507-4520-a02e-212f4ce9c7c7@kwiboo.se>
 <66d3d8ad40cfce744e8b80c9ad0419eb@manjaro.org>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <66d3d8ad40cfce744e8b80c9ad0419eb@manjaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0502CA0035.eurprd05.prod.outlook.com
 (2603:10a6:803:1::48) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|VI1PR04MB10025:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a2c1a9c-2019-4c76-ad9a-08dc2650ad20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VnOrON1Jd2snfuC/2HRlJ3uWXIBi9vSQKC9I8y9Oxj28xILFX4dmczhU2B82BCWkeW4iG/Gn+xDqOZIlYB1iXQtScaa3iAaymd9ffN9YYNgnLBa/yikkWHc8vxKmltUJJ9EONsjVRflEB9VNiSLNfPeL2mI/PaQTDBXWX7C8owFSFr0bRLWFhlZk50xpleFnuBfH+tHQgneqwc5DN68JdY+QSPzOo7oa8F46BcSmvdI3DGDxaK+nFfeylA2blqBJs/p5pZ6n5KX+OYBdetnVYRAqe3HFZ1Ukqa5SKway+Ywb01sBrLl9mNRyH9ymmYGm9rUNSGO6JFnstT45pybk9Ke8hQajMIoftKClWYH/JK5FzFsjBARwTGY2SUTQmFnJBPlEyoLuZ1W1ZjPN7a1X6PRrWvgX5KKLuN09ycJaLnKBYS/jAvLTH0kMEXOMhH4B/6+IvH30wkYtjcAO6e8V8bI7sH8IKh5MqVbWKn+IvRzyOO3tazTaZmvXUPmpj96NZlx8BpyzhDu4ev6CjVYuOzi0TgCIXnlJmIGvepXMzY8U/0dI/001ognANB/GkAFFNLpkHvRpd7iFfvwx52701P3Q7HnyCWOhWvpbSpKJ1Uq7t7kvCCzKyw0vhs0Quk9M+Y3KNTiO5GbMv/QKupu6Wg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(136003)(39840400004)(366004)(376002)(230922051799003)(230473577357003)(230273577357003)(451199024)(1800799012)(186009)(64100799003)(36756003)(83380400001)(26005)(2616005)(478600001)(8936002)(38100700002)(8676002)(4326008)(110136005)(316002)(66556008)(66946007)(6506007)(54906003)(7416002)(5660300002)(2906002)(66476007)(44832011)(6512007)(53546011)(6486002)(966005)(45080400002)(31696002)(86362001)(41300700001)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlc2anJiMDlSbEU3WGhCZDc3TEdDMGk5REdic3lGc2xTK1lyV2xZMnR6cVRX?=
 =?utf-8?B?aExaaDBlTWZBei9rRDQ3SmdBZU5IUExTd1NwNjgyTCtScjBUWmNSUERFMks4?=
 =?utf-8?B?YVMzdkxYeVFoZE83Y1VVZHFLbWl6NGs0WWlQNGhLRHZoMEJkMDF0dUVaMVRj?=
 =?utf-8?B?T0puTXlFMURtRUxacmtBT29TTjRiWk5zZTJCcmc2NlNFcFJ2cHc4cTV1S2Rm?=
 =?utf-8?B?N2FlOXpDd3BQZHJYKzQvOSs5WDRYbzVWcHptbmpIbjRicitGWEhRVDF5Rkds?=
 =?utf-8?B?VVBseC9meUF0Qlhzc0VJN28wZWVmcENONlhsRkdBQlZGQVFvSGRXSjc3a3cy?=
 =?utf-8?B?YVN6N21rbFBLaEM3MXdVR1U4VkczNDBGQy9uRDVUQUI4K0pISUNzU0NzTVJX?=
 =?utf-8?B?NmpCTnNaMVJ2dFNqcEpjeWNnbGFLYXlsY1B2NDlzM3E1VkFJdzBQUU5rSGZP?=
 =?utf-8?B?Yy9ZL0dsVGZtOWFkR1Z2R3RBcWNsM0NyM1loVE95WEJTV3RleG9lMDFkcjlk?=
 =?utf-8?B?bHkrbUlDbDJSeVJLVHIzTkNoQlFNUjdvUStkV0taLzE2QmNIMWVtK0R5TVdy?=
 =?utf-8?B?dFk0NCsvSjQyckNnNGkrMnJ6dCttOUo5T2doeUdUbnRWTklqcWxTMzNlbnNG?=
 =?utf-8?B?UFc4elhha0xRYVRONHAzajhOM1NVUGJocDIyZUU2OG55NUVyM3orc2puQm1Y?=
 =?utf-8?B?TDllYThYbXhjbUh0MVJaRG1mMWMzMDIzWWFXN0Y5T1lKRVRhY1NmRVJmcEpz?=
 =?utf-8?B?OWZ3SUJSVCtyL2Q2bExGUmpMMHJkU1d6bmFFSk4xcDEycndyZjVUb1Q0YVQz?=
 =?utf-8?B?dmpjb2N1WXl0aEN1Y05YYWdQdUpUVlRVZVN3SDB1VzhQS2d1WG9yNjhONERQ?=
 =?utf-8?B?WXhHdUI3T1dBY2FwdTFKQ2RaWkViRXp0V242aVFSMVB2WWlQalRoVTdOczNS?=
 =?utf-8?B?TVNxdDQwRWZtbWNPdW9WWlYvcGt3U0U2ckk5ODFTKzhVU3ZvWnUzYjRoUjFr?=
 =?utf-8?B?d1FibWt3eFNRZjA5NklFek9zbW5NRkRaOHlCbkc5c280SXl4YVpCbkJJNDNP?=
 =?utf-8?B?S2swVTdpMnppUUdCTXV0K2lzRjQ3VHliWlFPZTdDZThBU2Q4VGpCdVQ3NkVo?=
 =?utf-8?B?enBqT08ySnRHWUthVFRaZkNwSGVRVW5GeWdiZVhWcnlGQmFvZTNDbWQ2RUFq?=
 =?utf-8?B?R0VuWE81akVVaHZmVzYzbTBOdUNoQm1HVlAxclhtY3phUVEzQTk2ZDlMWW1D?=
 =?utf-8?B?dXp4YWFRMmgyY3MrVDNVWWJZRWNySUZBb0ZLTWtpQUNiMExISTgvdDBFSDBn?=
 =?utf-8?B?TXRRSmpIenNzTXlkOHhybW96R3JlK2t3UStnZmJSV3VpQW1kbkFvVHJSMkdX?=
 =?utf-8?B?MXJXSEd4VmVna1hCM1ZjdlBvKzBZc0hKVGVFUWIvNDMrWW8waC8yb2xoNXpN?=
 =?utf-8?B?YWJnSzlIY0Iwam5maVVack1mUkozdnUyZnpObzR5NHJZWmxlRTNlNFNaeTlV?=
 =?utf-8?B?V0JDeVVPTkNNblFzNEovSkQ4R2ZPUWh2bGhXUE5FaUVjNzdSQUpEY1dlb29W?=
 =?utf-8?B?bDNNdVF2SEl0dWtVOGNoOGR6Snp3SXBGVUcrNWtNNlptdVR0eW90cTZuQUE4?=
 =?utf-8?B?RGN1SkIrZUNvZ2d0YW52WllDY1B4bEpKSzJtb3d1RGc4WGlFS3lqeVFla0Nr?=
 =?utf-8?B?VDVhYk55OWpsZmZ1cS9nWVFkdis4M3paOU50Zkw1SUpLQjBKVzRHQmIycStQ?=
 =?utf-8?B?TTY2Uml1emZCZXdaaElOUE4weDd0NW1Jd2xCTTE2TUVmTDNmd3hJbXdLUDUv?=
 =?utf-8?B?OGZyRVQxSTJGRGVhLzg3dUFRdlA3YSt3aXlQejJTNXNxK01NL1EwYjIrUngz?=
 =?utf-8?B?cWFYYVYrbTBLbWo4UExJRlh6RE4wOWpLWU5WMTJuOG1pWk10OFRWMm9yQzJW?=
 =?utf-8?B?VUFtdUNSY3pUUTlsYUxiWlBrVm5lVWZyM2NVWGQ5dG5DTWoyYitRU0YxYXRx?=
 =?utf-8?B?YmpYd1c0eUdkM2hISDJ2Y3o1U1d5dFIwbU5JTzlvTk1md0hqMmFBWUNhamh0?=
 =?utf-8?B?SHlSeWNlYUMyMG5EOFpXdk11dTZPcnhxeXdaL2NOWXowMXEzbENoa1Z5ejNo?=
 =?utf-8?B?aTVBTm1haEN5TzBTeTVjQWZCekJYMVNTUXRVYTl5MldHUmI5ZmhIZjFwMWFt?=
 =?utf-8?Q?oPpnLvrL/udO9svgRnkkI2o=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a2c1a9c-2019-4c76-ad9a-08dc2650ad20
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 13:45:12.5791 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BQe1nNZ37QjQujiLJenlCIwrPKQXipj14nYmcNRAA5DYottjneQplFqY91rLBzlZmfifx2fqwBIFwM5L7GscI6T0O17YYiYWraeuACe2VqnLeNqo2pG4fTaBHJiMguG8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10025
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

Hi Dragan,

On 2/5/24 14:40, Dragan Simic wrote:
> [You don't often get email from dsimic@manjaro.org. Learn why this is 
> important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> On 2024-02-05 14:24, Jonas Karlman wrote:
>> On 2024-02-05 10:40, Quentin Schulz wrote:
>>> On 2/4/24 21:53, Jonas Karlman wrote:
>>>> Testing has shown that writing to eMMC using DDR52 mode does not seem
>>>> to
>>>> work on RK356x and RK3588 boards.
>>>>
>>>> A simple test of writing a single block to e.g. sector 0x4000 fails:
>>>>
>>>>    # Rescan using DDR52 mode
>>>>    => mmc rescan 4
>>>>
>>>>    # Write a single block to sector 0x4000 fails with ERROR
>>>>    => mmc write 20000000 4000 1
>>>>
>>>> With the MMC_SPEED_MODE_SET Kconfig option enabled.
>>>>
>>>> Fix this by removing the mmc-ddr-1_8v prop from sdhci nodes in
>>>> affected
>>>> board u-boot.dtsi files.
>>>>
>>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>>> ---
>>>> Changes in v2:
>>>> - Update commit message
>>>>
>>>> Link to v1: 
>>>> https://patchwork.ozlabs.org/patch/1891695/
>>>> ---
>>>>   arch/arm/dts/rk3566-quartz64-a-u-boot.dtsi   | 1 -
>>>>   arch/arm/dts/rk3566-quartz64-b-u-boot.dtsi   | 1 -
>>>>   arch/arm/dts/rk3566-radxa-cm3-io-u-boot.dtsi | 1 -
>>>>   arch/arm/dts/rk3566-soquartz-u-boot.dtsi     | 1 -
>>>>   arch/arm/dts/rk3568-lubancat-2-u-boot.dtsi   | 1 -
>>>>   arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi   | 1 -
>>>>   arch/arm/dts/rk3568-odroid-m1-u-boot.dtsi    | 1 -
>>>>   arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi    | 1 -
>>>>   arch/arm/dts/rk3568-rock-3a-u-boot.dtsi      | 1 -
>>>>   arch/arm/dts/rk3588-rock-5b-u-boot.dtsi      | 1 -
>>>>   arch/arm/dts/rk3588-turing-rk1-u-boot.dtsi   | 1 -
>>>>   arch/arm/dts/rk3588s-rock-5a-u-boot.dtsi     | 1 -
>>>>   12 files changed, 12 deletions(-)
>>>>
>>>> diff --git a/arch/arm/dts/rk3566-quartz64-a-u-boot.dtsi
>>>> b/arch/arm/dts/rk3566-quartz64-a-u-boot.dtsi
>>>> index 11976fd3a6e0..930d660868bb 100644
>>>> --- a/arch/arm/dts/rk3566-quartz64-a-u-boot.dtsi
>>>> +++ b/arch/arm/dts/rk3566-quartz64-a-u-boot.dtsi
>>>> @@ -8,7 +8,6 @@
>>>>
>>>>   &sdhci {
>>>>     cap-mmc-highspeed;
>>>
>>> Shouldn't we also remove cap-mmc-highspeed?
>>>
>>> I assume this is for MMC_HS? Which we discovered doesn't work
>>> reliably?
>>
>> Writing in lower speeds on RK356x does work better then on RK3588,
>> however HS200 still seem to be more reliable overall and give more
>> speed.
>>
>> For RK3588 they could possible be removed, but since reading does work
>> and similar issue also existed in the fallback MMC legacy mode, I did
>> not see that cleanup as important, or maybe more correctly it did not
>> cross my mind to also remove these props :-), the fully broken ddr52
>> felt more important.
>>
>>>
>>> Since it could be in a different patch if you wanted to, for the
>>> changes
>>> in this patch:
>>
>> Agree, a possible cleanup of cap-mmc-highspeed props could be done in a
>> separate patch.
>>
>> Alternatively any missing and appropriate modes currently in
>> u-boot.dtsi
>> should be added to linux DT and they can then be synced back to U-Boot
>> and any override/addition dropped from u-boot.dtsi files.
> 
> How about waiting until I fix the mode selection in the Linux kernel
> drivers?  As I noted already, that's already on my TODO list, and
> perhaps it would be good to test a bit again under Linux with those
> fixes applied, before actually removing the buggy modes from the
> kernel's RK356x and RK3588(s) SoC dtsi files.
> 

While I appreciate there's some work that can be done in the Linux 
kernel for those low-speed modes, the properties in question are removed 
only from U-Boot's DTS and your future patches for the kernel wouldn't 
impact the bootloader anyway.

The issue right now is that U-Boot is currently broken because of those 
properties, which are only in U-Boot's DTS.

Not sure exactly why we should waiting on Linux kernel patches for 
merging work-arounds for U-Boot? What exactly are you suggesting we wait 
for? What can improve the situation?

Cheers,
Quentin
