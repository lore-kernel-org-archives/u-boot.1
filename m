Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CD2CCD128A
	for <u-boot@archiver.kernel.org>; Tue,  9 Apr 2024 15:41:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BE5B87A4B;
	Tue,  9 Apr 2024 17:41:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="ceaD14fo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9DBF87C7E; Tue,  9 Apr 2024 17:41:23 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD94F87916
 for <u-boot@lists.denx.de>; Tue,  9 Apr 2024 17:41:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EvWeNRJyLMlb1aeDKGU8zL8ObwhvwWazCmTkUmZUjc7s7XzTi/8nEVnlWZlmRKwwgiSc43pg0aq32Ins/W1EKXz5Uj7ogQCm9vFKIXNGQClyuZ+Ma1mC3F5qKq0p6BEl2W4x+rM99nyPXQMOlECjCO6bd6gIgDsPboAKOpgs15L42xRDJ95tlnZGKTx1gZWfMLis2RD0Yp+etCNHkL9P2RL6zwIZwoHiunQOoJ+W05PPMgKM4OJedXLxiqiR3Deb8KO93fQz0CRRuw9J0cKU85QWiCEgWM3kCJx8lNlu39bC2Xfj/P64Hl6jkIBizY5EavhCKKUqYRlVl2lbqpsibQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ktkOVFBT053BvwyBTfqiNsE9tLcRQe4WstMYHqJDJI=;
 b=MhrKgC4UeH4eiFYHG34mZ+qdtjq1KnP2mkDiEFQXPT3hqhshx7IS97+iD/3U7U5wzdAGoC2EQN1lp1MiYOY4PyQXvvK3uyJrQ6cmQe9v07rZY/VSuhvgjW7bUoigikNu4ubk0sPz9zXJ8auDM2OTdLMdNf6WRoISSheFgjcPaLp4bq/S/o5QPTKfzTdB7HVjdmzHl419b0x2zDHh6uzkeFojFFIA1bF7JShvNBtUHsO2UiEIqZwzIFcplzjnFtrV8JImTkRuk4HjrEAvSUWIRV8l057/zZ0jPrn0lBdYvAgPZIlXvqovpH+fnBZrJSDucbtSxGKKLuVG6gcMLpA7iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ktkOVFBT053BvwyBTfqiNsE9tLcRQe4WstMYHqJDJI=;
 b=ceaD14foAuent+4M8NkogA32UzH5ncMN2xk2/QJG5uTwqIJg6tiBTrmnF/8DdETPJ96ECuSWp9tIT8pXUhMoF8LR5bej/g5xd3aPXaAXNbfSjzX0e9uv6T/5c+RnT52i4jE0abQWpseUoIj8UndHmb9G7F5UR4PfjUbhnwB/5tJ1J9ofTDdBaZSb/d8wu81XJiRIIjnd/YFQE+FpvNAg/2YACcXlI43QIGDg+wClIs7c+1l4bfe7c6cMj46FszefUPViBIruc0nHkTzrlzlW/L/fIZKjf4gckgVMwm3GLvk/Pv1DGFFyzjbGjs1+MhoSGrlG3tBSZO0TfflLKHUzPQ==
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by AM8PR04MB7378.eurprd04.prod.outlook.com (2603:10a6:20b:1d8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Tue, 9 Apr
 2024 15:41:16 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::3e70:7029:faf2:7779]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::3e70:7029:faf2:7779%3]) with mapi id 15.20.7409.042; Tue, 9 Apr 2024
 15:41:16 +0000
Message-ID: <b568b461-4a21-452f-b91e-92b888941dd9@theobroma-systems.com>
Date: Tue, 9 Apr 2024 17:41:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/14] rockchip: rk3308: Generate ethaddr based on cpu
 id
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: Andy Yan <andy.yan@rock-chips.com>, Akash Gajjar
 <gajjar04akash@gmail.com>, u-boot@lists.denx.de
References: <20240408181429.3676856-1-jonas@kwiboo.se>
 <20240408181429.3676856-5-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20240408181429.3676856-5-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0036.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::9) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|AM8PR04MB7378:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V/9gmHTSzQ9zpn1d+4squQ6dIhxQD29GGzLszZXugi7h+I0p1TLoh3z98ZUA4bG4XZ3lnhxsZ5SYlG4Ql+lwc+UcSgpvkxzCZ11FCkIqbiNp4xLvFga2dZ4Pc+cKvGztFpBbVssFtfoO7CPfJtoWXqIXATrVpJurkm8StwIkTwFY60+mRfQUQ23XLtHHaxeR78B5UVI8UbKCzDe/B82fsUUSs5PwTy0vKMOpxrlof/zKPKByTfbQuWpS/nX+opEEjYJgYEm+rSexnrBQXFpEmJN0CaeEf/KHlTOFfK9qogv3DGBdRLxuZD31wUF0J2uQZWQ9zFXPnLhZW7tvXRs1rGhbt7Kq7yLOzRgMwTBM3kslCMDfODypGOu0YbidxNmx3XCaVW7kqgBQCjSbxVINy/7rMSNAZi5V5RLcNW2N3g7dCnWMogl2ICU1RUhf3LPg/XtQpzqVwhZiJOBB2PCqSXA1wtiZT8hdomwnaHS661Nqg1CN36GxeBkGaw9dWgQPwEkJAsCagq51sMY5lVmI9MIizADFl64HnUM6b9BtZPfkaEr5yvlpp95Ht3wkfHod95PfYpXPKId6Qhc70o6vzJr8ijgNmHm7Z50mdpEsfTeCi0AEFlHkw/BaOWS/p3Hd9mNHh9GOcBnMcnWNkCrHTDaprWh92Yv4SE//4LFt0GI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWFScWRSa1NQZHRyTng2eHhXaFhaZDlzT2Z6Q290amkyRjkyREl6OTRScTdH?=
 =?utf-8?B?dFMxL01ZNEFlbVlIQ05GTGxmMHhoQnI0QURqS2xGMHhtZEhZMW1ORk9ncm56?=
 =?utf-8?B?OFlCNnkrZHR4YUJpYVNnZkFLRDByQlVtU0lpbzA0NUtQUEx5RjJtbE5yelVJ?=
 =?utf-8?B?NXhxemxsWjc5Q05tWFp1WFZISEF4SWRDMjJRZ1c4dEI0ak9HdlVrN09EYUU4?=
 =?utf-8?B?N3F5SmFqMldMRUlMbVNNRmtKVE05R0ZKTk1YVnI0TW5WSlFORU9nVVp6SHRi?=
 =?utf-8?B?ZGhLWmJJYVVDVE1mS2VzeVZ0SXJ4eUloRHhoQXpDRlFyQlNEMi9GL3hSYmxn?=
 =?utf-8?B?dk5OaFNmdGorMGZSbDlZSHFnbWJDbDlaeUY3Vk5mQUw3QnhIWEY4L3I5d2pY?=
 =?utf-8?B?akRVQmlQR0VTYURITENwWktNVERnZUg3SVRISG5PVHlvTkFuN2p5M0JxMHd0?=
 =?utf-8?B?MzM5WTNkcHFHdWQzNWxoa09RNUxRRGpjYnMxTTRUdWJjcGk5RG5oeHpXZmhR?=
 =?utf-8?B?bTcxckxLOVpyUWg2Ukc5U1VhNUs0dVhEMFh4SkRsT3lnR0pZRkJoZzBKT3ZY?=
 =?utf-8?B?K2N4U2hiVGM3UzlZekp3ODlkbDVzV2I2ekxwRDZRdW5hd0V0eVkrQmFDTnJv?=
 =?utf-8?B?aHVsMVBQUUxDakgwRk02VThvWHZCOGlnd3hGTGJlM01TNmlxL3FQZ3BHR2lx?=
 =?utf-8?B?bGxxMjd3R0tZOGVGRkFJRG1TbWVreUZpSDhoUWFpVTZkeFlBZmNBSzljK2R6?=
 =?utf-8?B?ZE9KKytUZkF6NGN2MUhWVEgzalNYblZVdFdBTTlDVHNjUEU0WmpzZGVDZldH?=
 =?utf-8?B?UFZYa2RhQ0psUjFKY2Q4SDg3d3pudTBzYi9mWEc5RENJN1E5SmMxcjRFdUFG?=
 =?utf-8?B?ZGc5UHUzSERlaEM4Q0tyYk9YM2FqWkFQVDZscjhTRW16dWc1dHo2TUYrYlJC?=
 =?utf-8?B?Ym90K3dvSUc1emlHM2hMT1loM1pDeStDSHlUeGFIL3NmQnhKcGlwMjkwM3V0?=
 =?utf-8?B?eE1QN2kyVUFiOTlVUXYrWC9XMHZHYVRsREpTQmJSRXc1dlc2NThESVdFa2Ni?=
 =?utf-8?B?RURxMjRyOFNxdDJ1T1ZIQnM2Tll4YWtPWjhUWFg2d3NkVDBRSUVjeUFHeUZZ?=
 =?utf-8?B?SVpZRjNnbXJTdkFzNkNZaGNJRWcwV2c2SWwvWStsT0VaWGlqQStVRHdLOFF5?=
 =?utf-8?B?Z1BNR1BsWWMxNThwUDJTOHpYUFFiYjNVVlh1WFoxd3V6NXNOSXVaNWpZK2Fi?=
 =?utf-8?B?ZEtRQ2tNanRTd1hmQ1pPUy9GbkZ6RHdycXY2SWdqVEk1VGtuWlFaa0l0UFlS?=
 =?utf-8?B?UjdQcHlvRnN6bWxJbVZhUnBUMUpwWDR3M2pjZTNaVldsbWlqSHlnRmpWSlUx?=
 =?utf-8?B?WU1xQjZyVGRtd3ZHRFh1RnZMVGpoN2FOWGxlSFFIUGRTWnlsWk5GeUlad05E?=
 =?utf-8?B?aHNTaU1hMHlybXUwV0NTZ1RMTmptTDBKaUVoMEh1UVRXL0RoUXJEY1h3b04z?=
 =?utf-8?B?ZHdJWUNFYis5WEQ1a1kzOEtraGcycGhUSUxzOHVvdWkvZ3U5aGp4VXVaVDJ3?=
 =?utf-8?B?MDljeWVzazBwZWNkNVRlblJHbmVvSHA3bkZPZWd3UnFMS0tmK3hYUm1CZ2hU?=
 =?utf-8?B?aDhmdlNBV2MvK3FURHdEaGhPejdVak5hOGZKYklXZ1BncXpua0lHYXJFa09j?=
 =?utf-8?B?d3ZLVFFDcGRkUmFSNUJUYkFmNW1BdzVqcU50ZUlrZkZKU0pKMHp5bnF5QW01?=
 =?utf-8?B?TERMT3hLbkhkVHMvcnJNN2dUZ0lzKzVQRE5uVTV6R1NyTzE4T2tVUStaRlNN?=
 =?utf-8?B?WkJrc3pIOUNIQkg5amZPdEk3TjU5RjBJd0NWalVlUzFzb21nMHVWZW16NW1E?=
 =?utf-8?B?QWNHckFqNHZkV0VuLzZZdExMN2lrNjEvUU9oRXVRQ2Z4SmVPbE0ycmJFYnRk?=
 =?utf-8?B?bDd6bmU0S1J4RUlGYVBhejNxTnFLWFArNlU1b1IyTXhaai9tWGJPSkdGWmVn?=
 =?utf-8?B?MWhndGdTRC9SRVMxektWNks4UVhRTEpuNnNXZ09oTjNQWUpRNWNGYWl3WS9v?=
 =?utf-8?B?bExjbU90NHZBMU9kVEZsZXVYR0QyYzRlRGY5dW1jYkxLbE9WN1dxM3UwdmdW?=
 =?utf-8?B?Q0c2MG9RVW93TnM5R0NqSG4wTlJtWXdTRGpzNVRxNnA1Vjl4MTNQWUFNQ01N?=
 =?utf-8?Q?/cwWvExUstWtEDDGHlv58YU=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcf4dbb0-81f0-4140-f05e-08dc58ab7e62
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 15:41:16.3895 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O8x5HKopIQFowXDRAFQKMCRkK8eab8Fskq9t4LpEPrbi/ZkPam3w+6GpBjVLUzdQa5FtWtmJSwtqs+KajKzJvKIJbpAieLdsykvW8ZwJAlB6eAuVHRo7Brcech/xvsw4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7378
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

Hi Jonas,

On 4/8/24 20:14, Jonas Karlman wrote:
> Like other Rockchip SoCs the RK3308 has cpu id programmed into OTP
> memory. The rockchip_otp driver already support the RK3308 variant.
> However, the device tree is missing a node to enable use of OTP.
> 
> Add the missing otp node to soc u-boot.dtsi, enable the rockchip_otp
> driver and enable use of misc_init_r() to set ethaddr based on cpu id.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> v2: Add clocks and resets props
> ---
>   arch/arm/dts/rk3308-u-boot.dtsi | 16 ++++++++++++++++
>   arch/arm/mach-rockchip/Kconfig  |  3 +++
>   2 files changed, 19 insertions(+)
> 
> diff --git a/arch/arm/dts/rk3308-u-boot.dtsi b/arch/arm/dts/rk3308-u-boot.dtsi
> index db2c20a7055e..436f66d1b87d 100644
> --- a/arch/arm/dts/rk3308-u-boot.dtsi
> +++ b/arch/arm/dts/rk3308-u-boot.dtsi
> @@ -10,6 +10,22 @@
>   		mmc0 = &emmc;
>   		mmc1 = &sdmmc;
>   	};
> +
> +	otp: nvmem@ff210000 {
> +		compatible = "rockchip,rk3308-otp";
> +		reg = <0x0 0xff210000 0x0 0x4000>;
> +		clocks = <&cru SCLK_OTP_USR>, <&cru PCLK_OTP_NS>,
> +			 <&cru PCLK_OTP_PHY>;
> +		clock-names = "otp", "apb_pclk", "phy";
> +		resets = <&cru SRST_OTP_PHY>;
> +		reset-names = "phy";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +
> +		cpu_id: id@7 {
> +			reg = <0x07 0x10>;
> +		};
> +	};

Any plan upstreaming this to the Linux kernel so we can avoid 
maintaining it in U-Boot?

It seems supported (the compatible is matched by a driver and there's a 
DT binding already).

Reviewed-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>

Cheers,
Quentin
