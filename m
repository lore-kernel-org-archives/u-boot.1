Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD8DFC47DDB
	for <u-boot@archiver.kernel.org>; Tue, 23 Jan 2024 18:04:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A2DC87D73;
	Tue, 23 Jan 2024 19:04:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="i/16TkvH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F9BC87E58; Tue, 23 Jan 2024 19:04:39 +0100 (CET)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0612.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1f::612])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B4EF87D86
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 19:04:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UYDBkcgJiUjuOkL24XVs9TWb5lj1I9tv7eVpWq68i3MLA2QGE+gs/PldCU9Oxb1Expbar6llE/+zTNxw+9ZdYLf72NZU2AYrdCYLh9rHAmionAjyRWqY6RaK+hg3wxIbguJECrh9ObOAxFiCCkG5IyYBcWbmRAhHzZYWZ7mW1lqlF46y5U5mK60GTkz58NLDyCw/NIWmo2sGIdtN7kzUFBE2+HvId74VO+UzSb3EBBiC9bDKKInO8Jku5vtPHt08TgR/AuF2PCbl0/ZpS2H//RNZ7M/9ISKB0/NHhj2cW0MGUMyRVVOXaUP+4i1eVr2WjM3rHUMQICKS7AGfUIVN3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6hXTbOsXhEGVyuWXwBeOOovHv/8a13DhsPXyIpe0iOg=;
 b=jhq6zA62iowQ7GOdAaZVN+vLGMuUH2c4Jl9M5B2BcR8Mslrh86rBYDyd83U6/Fw54Zi+B37HtYTmBZdRnv5dngQFoT1Q6uKl0cB+/gq5/8DsPf72Omr++CqznhXJZd83H2qDbh5NHPqTviExQqP4BX/Q+chQxDpN9Ii7XjrFsHbTVeUOpqrCGL/RBHcuAOBu/d6P3qvYxxhiJkJD+00XTmYtaEbtTinQteJuDhn3hFDPfuY3vjxMKed3gUbQDNZuxw1wSM2I6c0yk2wqzaAn8jigDV+tY4czGsRziVgpsLXK9mcuGWILf39ZK7owYz7+wI5mD9gRj4U1rjC3Cn7pVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6hXTbOsXhEGVyuWXwBeOOovHv/8a13DhsPXyIpe0iOg=;
 b=i/16TkvHSe6jlL2tbuIgBP3kAvRcoYz6Nc334Y38mHNnBExT/8HlgcVN8SvGRJH+TZwsh1XR2Ol3oa/TtbsFKtwuikToH6JhM3KnVQ9agJ/ECWF8zLJiuflZcmGpm9Y1y1sUTgklKib0mQu/weZBrrKVF/Tm6r0cpzZFwgePh5ga1K9rRKhS3dO3qKelBaHnWwvWdU5mrCFtq7WK1kG3BnjyHp2z0rxFm+d+XkE2zwRsySTKZp8zIW8AcUI1J0qHb4TcAw+8SgpZTHHUU0T3HEVzQVDX1ygBRujS8kMt5/8eLFb6uypCaOv9CsW7PlgEiOwOj/psI6E3kvYk5ZD3pw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by AM8PR04MB7267.eurprd04.prod.outlook.com (2603:10a6:20b:1df::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Tue, 23 Jan
 2024 18:04:35 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::9ee0:71d6:cd29:289a]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::9ee0:71d6:cd29:289a%7]) with mapi id 15.20.7202.035; Tue, 23 Jan 2024
 18:04:35 +0000
Message-ID: <36fde038-b008-4084-84d0-484b20762afa@theobroma-systems.com>
Date: Tue, 23 Jan 2024 19:04:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/18] board: rockchip: add Theobroma-Systems RK3588
 Jaguar SBC
Content-Language: en-US
To: Quentin Schulz <foss+uboot@0leil.net>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
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
Cc: heiko@sntech.de, u-boot@lists.denx.de
References: <20240123-jaguar-v1-0-1eec1c34953c@theobroma-systems.com>
 <20240123-jaguar-v1-18-1eec1c34953c@theobroma-systems.com>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20240123-jaguar-v1-18-1eec1c34953c@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0111.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::8) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|AM8PR04MB7267:EE_
X-MS-Office365-Filtering-Correlation-Id: ae514ca3-1460-4c00-70b9-08dc1c3dc19c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fyOC37AuKgpJWhSYcqZKb2xVfT0lx4SbloYbaWSqfksRyaSctEl1qOAN+k07cfdh/Ms5ln9y03Ja4ZhjJ7Ym3pmFT/9Opa8fBKRh8e/en8SmLvNZwXRrC5+TaaQJt5ZDItgH48EOnIiMspvUsfRJYD34Epolz4O0dSZrQRR9IVJpbXMybCtVOXEZa2skmouwHSy+itCK2BlOd3rdZvr2AoumAUa6FMwwyRq2e0isom8L9uFlAClELv1mCzd936XS5jkOHmEXp7RoeKRiNFzAneWSGlSrW0HzhNxSJ/UnXazII00ZuHsASlQqh9OHo1kKHKsVjCMHkUzdLXlB/VUqm/g4pg26BzKnWLFx9BsfvT9sRVqMkt7HE1WlbJRhQiY7xhZB/hs89Ol4o2pFu7e/VOc5t6m6rLTpJIEklCdGl6F1mJYjiQ6xPf6LEUFmN/mplBuWu4588fNqx3WSZiwARvIh+VAaoXOPuNd0Hcs2rJJfYHqYhcAyIivvfSJ2sHezl5ksrH+HNg7FW2/A3bsYWmhC9GzQgAiiMT7M0oNv5A+4ah2lojA7gN/86lLWrh7DYosAOu04Ggony+JT9qo9fA/syAZZ368ySqAYPXt7cWMmi9u42lE87Q72FGtrOGWCvzCvRINJA1h/NwfHA/tpwaGs5D3OYcXagqHHIp8NxLc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(39850400004)(346002)(136003)(376002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(31686004)(36756003)(2616005)(86362001)(31696002)(4326008)(44832011)(8936002)(8676002)(5660300002)(38100700002)(66946007)(7416002)(66476007)(316002)(921011)(110136005)(2906002)(53546011)(66556008)(6666004)(41300700001)(6512007)(6506007)(6486002)(478600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dndMYjZTVERJTFpXb2RTVk1vTGwrSTYxbHJSSURIWTNWeHcyOVAwZlp3VGJh?=
 =?utf-8?B?dWp1M2FMY01IekU5SnBhbjJac2EwSzB5TzF5WUlaWFl1dWFHQlkzZUpzTlBq?=
 =?utf-8?B?eHVTOEJrSFE4Qi9uTXVnaExKTE5FWXhMVEhSWW1EdTdvdWE4WFJUU3liRFoz?=
 =?utf-8?B?ZjA5ZERyR2ZrR2xCSHNMMG52YTFUU2dpdUJ0ekZWSWhPbkhaRDF0UGt0VnZh?=
 =?utf-8?B?M21VL0ZFZ3o4SE5aU040b1BVZGQ3NHQwZ1FCcW8vK1BBY0xZYmRVc0VhU3JN?=
 =?utf-8?B?ZG5TeUgwYTZnVnpDRzR3SW5zaDBvWG1NWnBSVmdkVFBiU1RobEx2UmhqUEE3?=
 =?utf-8?B?ZFkwYjlUdlZZYTljbm1NWVZwT2U0ZkQ4RFdhUENjV3g3NVlFeGRaSDJlRHov?=
 =?utf-8?B?ckd6cTZYOEE4Q2h5UkhzVzY4eHA2M2x3bDZnekE1WDdndXlqTk5EMzdxcGlz?=
 =?utf-8?B?U3Z6MmVhcHg5S29vUk8vRVR5ei9JdGdlanZXcHMwdWhlRHpQWXJvUnB2cUlJ?=
 =?utf-8?B?Qy83bWxpSG9oZGxOYVMzRHRyOWpyRTlQcUhickpXL01zSEp5R1M3WndzQS9J?=
 =?utf-8?B?cWxUdzduRE1uNElhZjlmeHZkZzF2djFKME5PdkEyUXBCVStYdzhwYUVPQmNG?=
 =?utf-8?B?eGN1anZzMUs0MGp4SWhyWXBERFFsSWpLZnNXbStVQ1hZUkdEeEVheHl0aHZ5?=
 =?utf-8?B?RGN6L1FkUVg2RFI4eDhXOG5XNnZjdkV1b1VYcVRZMVRNdjkvWXJWS2NwejBx?=
 =?utf-8?B?Y1hXbkdnRGRmdUJQbW1TUnlsVTl5N3Q3YzFvSXJsSWZOSEk0b3g5R3JTVnhO?=
 =?utf-8?B?OTN4U1JmOXhYblFxUW45S3NaTVIzdjJiM24zbHJkeS9LTTJBNlMvdmtJQkdp?=
 =?utf-8?B?Tkc2N1lFbzNHbkl1QnpvdnUyS1o4QUYwQmZXVzA1TkRZWHpiUHNwOHRic2Uv?=
 =?utf-8?B?eDFxK1hsbU1vVFZ1KzkrZDJnTW9NY3l0TktWcURZdmYrTzg4Q2Jqakdxblcx?=
 =?utf-8?B?WVlJdHloRlFmeVR2TjBRNFVPL1ZYZUROQkVlNHRvVGZ1U2o3RzhGVFZGVjJv?=
 =?utf-8?B?SXZPSDFydjQ1MVFuajhaalpvY09jMzhCQzMxYUxQUXdHcTdtbDdqSlVPOTBq?=
 =?utf-8?B?RVBnZHNIdkdiTXJJdW1KcldzUGc5ZmFYWTVUL2l5bDVaakJhRWxvbnVvY0Fq?=
 =?utf-8?B?Q1ovT3JmcGlpSjlKNVFUbXg1bW52SStyNWI2em83TjcxK0VtcUlyd1pVdmVk?=
 =?utf-8?B?aUhzNEdCQWx2dVYrWDMzdHgvczBvOUkyQjdXTHErNmJFQXZYWlpQWlYxaWJv?=
 =?utf-8?B?UXRGTkRVcHdWVFdpN1ZGSmFSSnNjQ1lraTF0Tmd4TXR5UnlhVmZBd1B5bHdr?=
 =?utf-8?B?RzF1QUpZSGhqa2U1aWt3ZnkwTm93eXJtaEVXbnFMME11dGg3RUhxRHJyOEh2?=
 =?utf-8?B?cUVrZXE5Ukl3YVZ1dWwwVWhaM3FFamhpUmxaMnhZNkJwdUEyNFk1M3Fka1J5?=
 =?utf-8?B?cWppNXlwNmtYakhBMGlUQWxWNlJwN1d5WllpWDZSRGxPRVZrM3lTTzRPYU1C?=
 =?utf-8?B?dEZkUlB6alh1bEJpaUNMeTRvdzEwQ285SU02bUtyUkIvclZyVGN5SWNSMVl1?=
 =?utf-8?B?YmlkRmVUbUZ6eTlZZUlGV0I3Wi9tVXl0RFVwZHowMW53dDNnc3V1emRpeTVN?=
 =?utf-8?B?TFVoUER1Ulk2TmRCM2lMalNieVBsVFk2UVlGZ1ozR2xWUzRBR3ptbm1uNWtm?=
 =?utf-8?B?emV1cHdzZEV6bjAzNTlzeWF4ZFVybVJBMjJxdktNYThIeHZFR1lKaUVjcmFF?=
 =?utf-8?B?STRheS80bTFLS1RSdVhBbS94Umovd2NMQUZ3TWN0UWNDcWpwYVdjRE9nQW1s?=
 =?utf-8?B?NDhWZ1hOcDJ3SSs5ZWxQUmZ5YkpNaEdHM3NtMUQ0TTVIRk51L2JLRHM0QXpW?=
 =?utf-8?B?V2dKUXNLTDltU25GQ3hUcVc1RVo3eXVaN3ZIN2ozN0JSdHUxUEtCRkRvMlFy?=
 =?utf-8?B?dWZ2WTdPdnEzd253SXUrVmI3cDQwd1lLUkRoUW9udDlFa3ZPUk90U1NKdkE1?=
 =?utf-8?B?dGNQSHV1OHFaemJhbzh6MS9oTlpWU3NzZVJuUXNpamEzaW9ubEJ1aDVyRWhp?=
 =?utf-8?B?Y015eGRTbVFYcVRIS0tPTXFwVmZKWTVIb3JhRGN0WTQzd2tMa3VvZC9UQlNs?=
 =?utf-8?B?Q2RhL3RyOERBTEIwQ1dreGJVZlRLcDdVYWM0WUYyQU9HdTNXbnZEOTRVV244?=
 =?utf-8?B?WEE2dUFkSnErc3QzcDZCa3YyNzVRPT0=?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae514ca3-1460-4c00-70b9-08dc1c3dc19c
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 18:04:35.1092 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pWyPThyoYZgibp5qoWz/ld6lqK2upHKY/S7DNRHCnwgVIe75Kspe5Ldh0nyg9GyhB09dlO0ieMilo17a/h16aGwOI7c4MDJOPt+gLYeuS+ctPEXynBszlXx6D/fj+Svx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7267
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

Hi all,

On 1/23/24 15:49, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> 
> JAGUAR is a Single-Board Computer (SBC) based around the rk3588 SoC and
> is targeting Autonomous Mobile Robots (AMR).
> 
> It features:
>   * LPDDR4X (up to 16GB)
>   * 1Gbps Ethernet on RJ45 connector (KSZ9031 or KSZ9131)
>   * PCIe 3.0 4-lane on M.2 M-key connector
>   * PCIe 2.1 1-lane on M.2 E-key
>   * USB 2.0 on M.2 E-key
>   * 2x USB3 OTG type-c ports with DP Alt-Mode
>   * USB2 host port
>   * HDMI output
>   * 2x camera connectors, each exposing:
>     * 2-lane MIPI-CSI
>     * 1v2, 1v8, 2v8 power rails
>     * I2C bus
>     * GPIOs
>   * PPS input
>   * CAN
>   * RS485 UART
>   * FAN connector
>   * SD card slot
>   * eMMC (up to 256GB)
>   * RTC backup battery
>   * Companion microcontroller
>     * ISL1208 RTC emulation
>     * AMC6821 PWM emulation
>     * On/off buzzer control
>   * Secure Element
>   * 80-pin Mezzanine connector for daughterboards:
>     * GPIOs
>     * 1Gbps Ethernet
>     * PCIe 2.1 1-lane
>     * 2x 2-lane MIPI-CSI
>     * ADC channel
>     * I2C bus
>     * PWM
>     * UART
>     * SPI
>     * SDIO
>     * CAN
>     * I2S
>     * 1v8, 3v3, 5v0, dc-in (12-24V) power rails
> 
> The Device Tree comes from next-20240110 Linux kernel.
> 
> Cc: Quentin Schulz <foss+uboot@0leil.net>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> ---

I forgot to add the dtb rule to arch/arm/dts/Makefile but it still 
compiles somehow... Will give a few days to people to review the rest 
before sending a v2 to avoid too much unnecessary noise on the list.

Cheers,
Quentin
