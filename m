Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A95BC4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 08:55:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0189588153;
	Mon, 15 Apr 2024 10:55:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="Lj/78otr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C1F588153; Mon, 15 Apr 2024 10:55:18 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6081F8701E
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 10:55:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hXRL2ucyYn0WBgKOzo9+9eXCkWfsKtw9csSIabpwQ0xFFOlWmqM2FQkXV/vpiPDxBFq7BL70fUz0wbtDySnebuiNSV5fQAcnbQe/b4e/e7loSYoXga6bmcMeTLi6B/QKiCLcGpxJLHuac8IU5fAyYmUqLEPuXU7l2KcXurPl8UQhbwKpTn+5kw70gBJBZuBH/uUctTNIN3C0fq4PsSWEK6tAMFB26V3cRnTVicxf6pbo06oyHxmwzfPDtr4Vd1PiKjAKAWayBiaVsBu8euDkNK3WnEDo7j3zr2jnYWYZ+NbMynAzGPfTLHjhjRCKxyZ9NIwoQeEeEvGlaFzCEEUy/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T9zPljMha2Gpmh8c3H/glXt0afpew1k7WPzJ57TWI/g=;
 b=G2Vm1yB65uSKm8u/Px6kMRECzqYq1BT2JhdVXASHTWlU7JQ0qz83HUor9/DS2v5mT8pwDXazte9fzAq6nPilh/5b/Nhhy9GJbZ+DApdepfJWKlsWuSpP146XnhMLcKYbdb2KJ+T39KKT/jzr4+d6M2iZEDiL7jCJzTTmEzWILiZ/UZ21J7UJv2WDCyIHaGu6FOPQJh3VsbKkEmn6x/XJbtza55yv0jHgh9236/lTj12DDSqyvgkubMc9ZeV9j33n5kJnwRiYdDeogfqEf0uAfJfJkeI5/XsAUyEM6PWAaMAbDLZCikVS/vhp+GwUdwMk3Uxnh7HYwCacnbRi35MedA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T9zPljMha2Gpmh8c3H/glXt0afpew1k7WPzJ57TWI/g=;
 b=Lj/78otrRq5kmqAX1ozbrewCVrfr1dt4QOl5p2Zu7jj1aZffs5cNq1HnMEI6LsKk1n2O/AxlgSgsm73Xa1wrEjIEIxVc8ierYrSYNTd0wQAdH1AFT+3RCjbmgcojQiCkKmVarFWvpSbWzcC85my44NTg85f0IRIW3NoYn8vrU+2JoQa4lpJHgSJjDiUlYbDk2+7N9dD1eLnAeJnt/xwta2ekYgwKmjwtpXraBdxXTN2al+tNkFNWzO9vWDRS5YuDdZV39qGFmB5kBk0tKcznVFM6Rx0/tqOTVqhMcOVzbWWSXEDewAfz898LPoGY7H6O+ryQ+TqSGXrLFHHMglnspA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DB7PR04MB4842.eurprd04.prod.outlook.com (2603:10a6:10:1b::13)
 by DBBPR04MB8025.eurprd04.prod.outlook.com (2603:10a6:10:1e4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 08:55:14 +0000
Received: from DB7PR04MB4842.eurprd04.prod.outlook.com
 ([fe80::bdc7:4b2c:e74e:1504]) by DB7PR04MB4842.eurprd04.prod.outlook.com
 ([fe80::bdc7:4b2c:e74e:1504%7]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 08:55:14 +0000
Message-ID: <7a662cf8-a75f-4202-8cbc-851afe22d093@theobroma-systems.com>
Date: Mon, 15 Apr 2024 10:55:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/23] rockchip: rk3588: Update bootph props
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Andy Yan <andyshrk@163.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 John Clark <inindev@gmail.com>, Eugen Hristev <eugen.hristev@collabora.com>,
 Joshua Riek <jjriek@verizon.net>
Cc: u-boot@lists.denx.de
References: <20240413181425.1384357-1-jonas@kwiboo.se>
 <20240413181425.1384357-13-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20240413181425.1384357-13-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0007.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::11) To DB7PR04MB4842.eurprd04.prod.outlook.com
 (2603:10a6:10:1b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4842:EE_|DBBPR04MB8025:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fbce965-ae54-4213-1971-08dc5d29c3b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4nTWrq1kqAcF44aSLvai4RkmPkfTquiWf6+Sm7xwkWdy2AslWgkxA2KwMS3YiD/P24UqQtlXddVnR1ALNL7vBN15f4pPmhC9Ztzovk82FW7Q+bmrmH6O1QxELcMydge7ORHH3SbGIsJzQ9eYAQaVfcdlZXd8ThqbvubdoSRQNRuUvFboU79hDxvB/Z1aJbccwWNnF/SeSsIz5wKR2wWPUjBA6A14b/1dlYuitPmwZNvaisNP3AweW5ZTD83pPnrR3I20+4M4IE1AuCcyh9PgTjtTKxKHO4/CK+K1Z81F9RLovaq4YEmQLYvYoZqkaPMqQeJNPx/AMzKQ5AZSrhIf9+rC0rfojcc23MEUtm/xHHxzRRnsH0gb3m0pKQTQSWB6FlBfCNdG2E1VQtEYa6ZbH3nQJ85MX502tJM7ZUCHE3AISFHlianPqQtNyGoZdKNQSA6sofPJulyCu4Qn/a8mUzSSKg02rbUkPQtnQa/Iod3FhnUqdDORGxTjPV7o/8yc/nwNNAMtAV2AfR1y+p7+lu2pR64roi9N74SqCjlzRyI4atF4uD37lJgceWwGX/v51KhcgSYz2cuwNci88QM18iA3levE1XbcDtB0o7x2OmtHA8wzhDbPSTNDMPlHaSQm2XrweWNvpouwHNzVW2IhR3KvXYiXaRg9w5pfMhhG+34=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB7PR04MB4842.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(7416005)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWJDUXNPRGJmWWFlQWZDY1pRbm9TVzZvUHY0V3Z5RUprRVB4WFNSemNRWUt6?=
 =?utf-8?B?b1cvWG1NcEo3dHFzS2NqdkhqcER5SWNLYy9nQjloR3JpTzFYWGNkalJzYnZ3?=
 =?utf-8?B?MFVkaGtxeGhQbWF3bUw3WGlVTTVucGg5bUhFK2ZQY0Q0SStJUFF4aTdlTndC?=
 =?utf-8?B?MjhCTjU3U1BSQUpybXA4VDZvaGRHSHVUMkZtanVlN1ZJRldXWVByMDNLSEQr?=
 =?utf-8?B?cDhUb2pOa0hjNXpYbVQwVzA4SHdib01DNDRRdjIzQk9mOGcvZnBrQVhIYW54?=
 =?utf-8?B?YjZFYWhrT0sxRVZpYVpzUjJ5NER6WHUyaTFuSG10MkdvY01tZ0RrQ01DbHdS?=
 =?utf-8?B?dnB1WHVFc29kdFM1VW1IVjdTYThoL1BzZ1VTY2FqazZVTS93dmtoZWN6RG9R?=
 =?utf-8?B?NkRwQUh6c095K1lxQmIzRURlMmszSCtGSFVRSTdGOWI0ckMvUUtLcmJWVitS?=
 =?utf-8?B?ODVaOWFJQVA3UFE1M2E5dzBnOEdsRnQ0NS9yY2t0MXo2cUdIWnI3VHYzMWp1?=
 =?utf-8?B?ODV5N2pWWnhTQUhwQ2FmUmxCczJabC9QcmdUcFh5K1UwL01MaEpxYzNrOFhY?=
 =?utf-8?B?NEZ4NmRtSzRrakUrRVkvOXduQ1pzQjJ3c0pnMlovTG9iQ1pmQjJwZEErdzJu?=
 =?utf-8?B?eWtjdVNmbEd3ai9TUjc0Q2Rab1lsQy9FUk9TdnBMdS8xbzQyamZCa0VhRUEx?=
 =?utf-8?B?OFF3Q0xJOGcrTlEyNWtGbW9RU1V5b2F0S3hCcGU0UFNiZXdwYmY1dkpUR3dR?=
 =?utf-8?B?WDlhZmhPMHUzd3A3MStVd2s3TzBJSlJLd1BrNjYzeTZiZU1ZMkF2Ky96cHFW?=
 =?utf-8?B?cmRWRDYwbHhuaGtNb29yR3lpVmNyNEs2aWJkRFRWd3pCQkVTT1NIS3JuRVlX?=
 =?utf-8?B?Q2xJbTJ2aWhsczVYa3RkNTNNZmY1eUZmSEpwQ3dvcWNFc0NaSFkrN00xaVNy?=
 =?utf-8?B?VTE3OS9ZMytqZ01USGovNUZxYmU5UlBZK1pMSGIrTGg0Z1hwbWxSTHB4VW95?=
 =?utf-8?B?d1RKNi9UMjBpaFlVb1cxNHkwUlZDeHJDd2Jjd0wxN05peFN1cHA2U041ZFZZ?=
 =?utf-8?B?MjNGQm9CUmJlT0dJcTJpY2FncHl3OWpjNFQwaTB1WHI1N25yak4yMTFHMzZK?=
 =?utf-8?B?UlpoZ3plS1B3dTQySVRDZjlBQUhBTzIyc0cxQXl6M0hJQnRvekt3ZEZRWE44?=
 =?utf-8?B?YzF6Q0FYdHI4TENsdFZvSEJNMUdGZTlaajgvYk9UY2Jxc0FzZlBrTnF1a0x4?=
 =?utf-8?B?clBGcUdWNjV0cW9KanFrSDhwOUdWN2RJV1hCMHUzMXBSV0tzRzZqeERLcjZm?=
 =?utf-8?B?akpmYmFnMGxjT1BlVkY1eG5HV2wrRk51Z0Y3eGJkNzBlRUR2VnVvOFNMd3ho?=
 =?utf-8?B?d1l0WnZyLzFiWGRvL1ZxQTBRaHV0K0xuN3BiNHhsWHM2UTl3aVB3bTdwTGx6?=
 =?utf-8?B?cjFLSmNFSUZtOEV4cHBvbVNLM2dxOWZPRlBhQ1o0djV4MWlyWDlCN1BKY1c5?=
 =?utf-8?B?Z3ZKSVI5cHM3S2tTM3lTMkxoQXd5OWpRSlpzWGZxQTdGNVlMWURxeEoyT3NL?=
 =?utf-8?B?cVJHRFAzcmlUOFFuaTdzTTIvNEhrN0FTOU53alk2eXluZFplNjJZb2c5bnN2?=
 =?utf-8?B?UHkxa1B1L2VUMGJVOUUxeHNzNWNVOHUvUWcyVHJLTmJJeHd2eXRlczlXOGZu?=
 =?utf-8?B?NzFQcnhuYm0yaFRtczg5bUUvWVhjL2xQNmhzYi9FU0ZVTWlIL2g2YlpQZ0ZT?=
 =?utf-8?B?YmNaNlUwTkxsd0FHN3hRb1hkWTBoaWdrV1FSYTJWdTBacVNSOE1JUWhZcnRj?=
 =?utf-8?B?OHRRc0lnd2hGZkEySWxvSFZRZGQ5QWJ1NEkwM2hIdG5TTzVQeVpQU1ErS29N?=
 =?utf-8?B?RjZhWWxRY2UxY1FpNTFPS25JWXV3RGRwUmQvdVZBSXNjZnBlcE5Wc2VsK0I1?=
 =?utf-8?B?bW1XOVRvS1FXeFNFMjRQdlJHVGNxRW5uU2pMN2tXdGJMTjBnRDJXbHRGbFVI?=
 =?utf-8?B?TDVudlFuc0pwNVpGck9ucHNZeTJyZENIc09BaTV6SVQvRDdLRnk1K1l2eisy?=
 =?utf-8?B?Z0VOckFlNTZQVjBxb3RjMDl1S2JYUXNYZDNsZzNuUkU1ZFQ2Wmp6SFhORDd0?=
 =?utf-8?B?cEdHeHhiS21CenpwTU96ZFNtQ3VQWHdUTU1oS3BlSFUxemdaRTVTOEJnRlcy?=
 =?utf-8?Q?jatIkj8uW5olS9WLhWHSiNw=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fbce965-ae54-4213-1971-08dc5d29c3b5
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4842.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 08:55:13.9701 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ceA0JtRuTWwmLGGm12U0ETuKeEAIXCnV4XvMIHZEabtDa0ARvfrnRs2jRAk06FFSKC1s7SDC7xW3thkg5Iinn2CPLwsL3ImgFRmuUU7OR2SHGU5wKOxnWEsDvDbgWaaF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8025
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

On 4/13/24 20:13, Jonas Karlman wrote:
> After the commit aca95282c1b7 ("Makefile: Use the fdtgrep -u flag")
> bootph props is propagating to parent nodes.
> 
> Update bootph props to ensure eMMC, SD-card and SPI flash is available
> in SPL and U-Boot proper pre-reloc phase also remove unneeded bootph
> props that automatically is propagated to parent nodes.
> 
> Also adjust pinctrl nodes to only be included in boot phases where they
> are needed and add any missing pinctrl node needed in SPL.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> v2: Add bootph-some-ram props and follow kernel sort order
> 
> Following bootph props have been applied:
> 
> CRU, GRF and UART nodes:
> - bootph-all - needed at all or most stages
> 
> SD-card regulator related nodes:
> - bootph-pre-ram (SPL) - regulator pinctrl may be needed to read FIT
>    from SD-card on some boards
> 
> eMMC/SD-card/SPI flash related nodes:
> - bootph-pre-ram (SPL)
> - bootph-some-ram (U-Boot proper pre-reloc)
> ---
>   .../arm/dts/rk3588-coolpi-cm5-evb-u-boot.dtsi |  8 +--
>   arch/arm/dts/rk3588-generic.dts               |  1 +
>   arch/arm/dts/rk3588-nanopc-t6-u-boot.dtsi     | 12 ++---
>   .../dts/rk3588-orangepi-5-plus-u-boot.dtsi    |  7 ++-
>   arch/arm/dts/rk3588-rock-5b-u-boot.dtsi       |  8 +--
>   arch/arm/dts/rk3588-turing-rk1-u-boot.dtsi    |  6 ++-
>   arch/arm/dts/rk3588s-coolpi-4b-u-boot.dtsi    |  8 +--
>   arch/arm/dts/rk3588s-orangepi-5-u-boot.dtsi   |  9 ++--
>   arch/arm/dts/rk3588s-u-boot.dtsi              | 50 ++++++++++++++-----
>   configs/evb-rk3588_defconfig                  |  4 +-
>   10 files changed, 71 insertions(+), 42 deletions(-)
> 
> diff --git a/arch/arm/dts/rk3588-coolpi-cm5-evb-u-boot.dtsi b/arch/arm/dts/rk3588-coolpi-cm5-evb-u-boot.dtsi
> index ed15b14ea0ee..f0ef0164664e 100644
> --- a/arch/arm/dts/rk3588-coolpi-cm5-evb-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588-coolpi-cm5-evb-u-boot.dtsi
> @@ -3,7 +3,8 @@
>   #include "rk3588-u-boot.dtsi"
>   
>   &fspim2_pins {
> -	bootph-all;
> +	bootph-pre-ram;
> +	bootph-some-ram;
>   };
>   
>   &sdhci {
> @@ -12,16 +13,15 @@
>   };
>   
>   &sfc {
> -	bootph-pre-ram;
> -	u-boot,spl-sfc-no-dma;
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&fspim2_pins>;
>   	status = "okay";
>   
>   	flash@0 {
> -		bootph-pre-ram;
>   		compatible = "jedec,spi-nor";
>   		reg = <0>;
> +		bootph-pre-ram;
> +		bootph-some-ram;
>   		spi-max-frequency = <24000000>;
>   		spi-rx-bus-width = <4>;
>   		spi-tx-bus-width = <1>;
> diff --git a/arch/arm/dts/rk3588-generic.dts b/arch/arm/dts/rk3588-generic.dts
> index e4721d97a87d..baafe7463f1b 100644
> --- a/arch/arm/dts/rk3588-generic.dts
> +++ b/arch/arm/dts/rk3588-generic.dts
> @@ -40,5 +40,6 @@
>   };
>   
>   &uart2 {
> +	pinctrl-0 = <&uart2m0_xfer>;

I think this should be its own patch.

[...]
> diff --git a/configs/evb-rk3588_defconfig b/configs/evb-rk3588_defconfig
> index 68ecbc54b807..610a8d740fbb 100644
> --- a/configs/evb-rk3588_defconfig
> +++ b/configs/evb-rk3588_defconfig
> @@ -33,7 +33,8 @@ CONFIG_CMD_REGULATOR=y
>   # CONFIG_SPL_DOS_PARTITION is not set
>   CONFIG_SPL_OF_CONTROL=y
>   CONFIG_OF_LIVE=y
> -CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
> +CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
> +CONFIG_SPL_DM_SEQ_ALIAS=y
>   CONFIG_SPL_REGMAP=y
>   CONFIG_SPL_SYSCON=y
>   CONFIG_SPL_CLK=y
> @@ -52,6 +53,7 @@ CONFIG_DWC_ETH_QOS_ROCKCHIP=y
>   CONFIG_PHY_ROCKCHIP_INNO_USB2=y
>   CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
>   CONFIG_PHY_ROCKCHIP_USBDP=y
> +CONFIG_SPL_PINCTRL=y

I have a feeling the changes to the defconfig aren't entirely related to 
this patch? Specifically, I think at least CONFIG_SPL_DM_SEQ_ALIAS isn't 
related?

Otherwise,

Reviewed-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>

Thanks,
Quentin
