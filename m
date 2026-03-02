Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0365EA4E09
	for <u-boot@archiver.kernel.org>; Mon,  2 Mar 2026 14:14:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA01983F2A;
	Mon,  2 Mar 2026 15:14:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="jVzxjkqn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C45B983F2D; Mon,  2 Mar 2026 15:13:58 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 905EF83F0A
 for <u-boot@lists.denx.de>; Mon,  2 Mar 2026 15:13:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PxOwggwjdhxKoIv6scI71M1xHpuNJcnGxOv3wVChIN+Snbwt8P03Hsx4HM7/bqcLVPakCvtos7ZL6+9W+iv4QMe2cyH7xBRZidYoKHXYawGdAz/9MqGz4SQuuGaOf4PvtPDRgBj5E0bJNP/es/Cy/Y2eRp0LZ7L7DPRzUw0SXvjpQrjBiNJ5FX8lnsiQw+XQ00cJDnZZn8TcByA9q4vUB4S2z6N/IyjAIQ6Lq2pFGxDYs4cBrMaHPgQtLMLp4rviXflWC4q+q4D45NmzaLYUy3F5ya0YnFjS+phClKmSdC2Sv+XI0cb3YI0G6vN1XdaH5LStLTDDoPBhrkqrptZuVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M1BfGiXAH87prjOIMpCt2jqEVPVwlQ0pjgl7SPT4f7s=;
 b=xzWNGDP8S6bxuM+pGcmzxasKS6xVfpB6IZMykBmaZGGwMQH98kpG7nY96GijqLGbGrpsFM2OQw8r63rC50l4e4SC3r2+xg8R17QCAOjbOn9O293xIOeEGoqIGYRMvI8UQbAEPUF5hUiYDnuI0SHDH4TTc7HecTALkhC/VeC35wQoIaYSsuyIL4uNBZIZQpSHTyliVsfrgJu1UOcH8HdAMZJF2l9LX55eF3dRArieHV2vuq7PNw3z7ApSO5oPRbr6trhaKr85wSlnBuIrPd5OLITuT6b2PDkkDE6sQxxCAJR9NmTjW4/jbQCII1LEFjhIL72o5wiKtYxtumCyiBQtFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M1BfGiXAH87prjOIMpCt2jqEVPVwlQ0pjgl7SPT4f7s=;
 b=jVzxjkqndAY7yAWUY9ZWaB0+ESNO29bBXGursU3OZ4MU6ILfLInw+ZkXrF/nYcHW2CblC7SkRfxFbFb3mnYuz5XEU9aiotqRloq46J/PRIlVJFMaNoT86VjVt7DzqkXRmCuCT59Myh9NnaVaq3g9ehfmyhhpRmwB8cu9IEEbj5c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by AM9PR04MB8764.eurprd04.prod.outlook.com (2603:10a6:20b:40b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 14:13:53 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%5]) with mapi id 15.20.9654.015; Mon, 2 Mar 2026
 14:13:52 +0000
Message-ID: <564aefbb-f2cc-4409-a9ed-a599f517fe51@cherry.de>
Date: Mon, 2 Mar 2026 15:13:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] power: pmic: enable sysreset function with device
 tree property
To: Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: u-boot@lists.denx.de, Andy Yan <andyshrk@163.com>,
 Jonas Karlman <jonas@kwiboo.se>, Neil Armstrong <neil.armstrong@linaro.org>,
 Chris Morgan <macromorgan@hotmail.com>,
 Christian Hewitt <christianshewitt@gmail.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>
References: <20260209183948.34807-1-clamor95@gmail.com>
 <20260209183948.34807-2-clamor95@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260209183948.34807-2-clamor95@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0066.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:26::17) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|AM9PR04MB8764:EE_
X-MS-Office365-Filtering-Correlation-Id: a26165d3-1ece-496d-f682-08de7865eebe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|7416014|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: ksjSSzR2Uu474zzoPYSwqxbAPMuHo/18Z1TPVsbW9wUlD3lSvUWJPaKnjhvbt3EuV3ZuSAu/U7CZ1zq/qgNZEeiPRJbquhmdbjkLY2EColNSMot5jDVB6LCiTuJK1M28gTNQsLg3SqL7aQr6AnNKi5p80KDcGvYIzGicf7aLCuEGax9TH4MLIRILM0a1HkfvbFg11ZGRqIpuBbP5kBMsmUH0I9mBez4/a4Fc0NtdgTZpqV0suNM4XTynUoVyhLj6QRNGAcYRdialMqwYl5B0SaGEUhgkgHbnPqVZJMg1/phe11ZTODuPCYZhzH8p9AS0yx1GpjKjChD/OMNpCCIi6h34jPOlR0o6lkvzjYM26a1tYRchBEsOYL6qyU0Az5DchoLFwclOd1/o55u09M90KFSFYNiH6ZzZX39iRuRpevmCwH3BBuPY4kDIfHVY4CPnSpFeg/QUU7JmbC2h/j2rt2M0eiBEl+h0A4GHTNqulVVaz8/0/+oDPMk0hVWppHkKIK/FbuG51Z/7/WaXzOoKagik+t91AiXPOwIxOR05Zg6P9f6BVr2OliXYD9kCEaAozUU8pPdOp8GL6bbe+crjZ9PyibIdWgsJfE6sTbR15GTqQg9IUH8tmDd25RqjSxP8JcCeVg4UhMauJbbwEGVlnh2Mi+s1Gfub6BFIts0SaFIDIUloM9niAsqYckFpec0Sl74unumyIXYPaBw7DoWpbyN1pORrp2PIkwxBD4NegLQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFZKKzJXZkJmMVlYZE9ZUEhvY2hweGZ6NnF3alhpNmkrYkwrR2krbTJjUDNL?=
 =?utf-8?B?Yml0OTBKK25ySWZKNEhiRFhjTGd5TjMrSmVMZ2F4RG9qWWN4cXM0UTV2WWhx?=
 =?utf-8?B?YUFId2w3Uks3STNXSFdzVjR1bDg5R3lHQXcrUEZoa0I3UTFZUVQ2ZjZBUHU1?=
 =?utf-8?B?MzdzS243UGhyeEdHVkVUWGR3MGl0TU4wSVV3dlRGVVRyekh6eDAxUEo1Y3hJ?=
 =?utf-8?B?SFJaSVg3Z3hlVzdkbFYrQyt4UjVNeXlqYjdlcFpGYWJEOE1UMmFxVmZoYi95?=
 =?utf-8?B?MWc0cGkzOXMweE0zcmFGOWtFYkhZTjg2TWdDOHVLb1AvWHdQSkEyV2RlSC9U?=
 =?utf-8?B?T1RjNGxkZXVuOUhZYXdlcnN0RTliODUxWkZoV2s4ZHdxMHFhM2dmNjZ1MFZo?=
 =?utf-8?B?TDF6c0kyYlBYYndiRXRyTHFQN1BXZ3dRMllOemVqY1B6dE1qNkh3Y2RuNDRv?=
 =?utf-8?B?MTlRNVEwMVJOeHRWOWVpWnVpU25LMEFOTmdXZWZXZk1wcVlMM1Jjc3ZlanFN?=
 =?utf-8?B?Y2NlT0NrN1dIKzQ0WWhJNk9wU0pidU5qRUZOSFBEeExXSVk1M1B4K3dmekJw?=
 =?utf-8?B?bGt1Rm5aTXZMSjJmMERtVDUwTWQyaXFnWC9PUktVK1NtS2lTcmFpQ0o3alJZ?=
 =?utf-8?B?aGc0YXVBNmxoa2RXSFdCQUdodHJnRFlSRUZOcXo3UnNOZlo4UFlHOXZDNjZL?=
 =?utf-8?B?eGNFS2I5U3J2Ym1Eem5ra2J4S1pYUHhWVmdySnFncHVCUGFOaGNXQ1FlQjlp?=
 =?utf-8?B?T0VjRnF2dHBqOEpML1RKdGtPODJXMFVlTTJaY1FKN1VVLytRMVBKd2ovZ29k?=
 =?utf-8?B?RVJEYkxwL0lWY2FjakR1YU5KVFV2WkhtaUJHWVZnSTUvUmUvclFtRjdvSHZu?=
 =?utf-8?B?S3BsSW1uYmdQKzZncXdUaTlQcVJKUWJBMVF6OTI1VXZ6bHkxTEdnbVl6WUhG?=
 =?utf-8?B?TlNiMTZTN1plTmJheXBkMVNzemxDQUxGMHpMT011VS9xYitPZzVHVVo2M2kx?=
 =?utf-8?B?Q3FPN0x3WEpkcTNIbWx6clF6U0ZHdVRNcTRiTVQyNmpNeUtSVzhoTlZuV2oy?=
 =?utf-8?B?V3FMQnJ5akZDQmVwN3hDOUQ1YjBTR2Jxa2x2dy9NOFJSaEFRMU8vZVFpaGNF?=
 =?utf-8?B?VlozMksyQjlYVTNKYVh6WVJBTUlHQmVZcndzMGNLUVJMT1NqaklCVzZ4akUv?=
 =?utf-8?B?SkRRTHNoRlM5dENoazhjK244ZG4zbUJTd3RhQTdCYmFJSDhFa1JBVmVhRXlM?=
 =?utf-8?B?MFN3T0dCY3oxdWFhQ2FBMWptVCtZQkZlOU5IbysyK0szNVc1dzlVUVdjSmho?=
 =?utf-8?B?ZUZWT1JNMkFVNU0vN1FjUFhWQ3p6UEVFV2FTUHhlOU5UWmhHRThqL3Vkc0o2?=
 =?utf-8?B?Tno1VWJoTng2cjEybklrZG5qdWZyc3YyZ1Z5UDFCbGpheFNrdEhsSUprREkw?=
 =?utf-8?B?blBjM2RwSFpnb2hVUkowcmpLN2lGRGw4SStoUGh3MXRpK1dKNkpxcU5GSzJj?=
 =?utf-8?B?Wloxb00rL2I3NEhnMVNFdmVQbGFpY2haQ2M5SEZFY2JGYzF0UjN5c1FleHVC?=
 =?utf-8?B?eXNGZkpERXExbEhYaTlncGtVcWtzZ0hZSlc0RHpHdGZ5UXduSUZHbzUyZ1R2?=
 =?utf-8?B?RUEzOHZ3UnZvZVNldzUzUUI4eFZ0Q01RVW9zVGo2ZlVTNnprOWNZSitJMHZH?=
 =?utf-8?B?cEEreDd6Z3FHR3RRdkRqcExoY1IvNk9hRFRKdlM5YkFRL3RaSHZzc2pGTi9x?=
 =?utf-8?B?bWZrSENCTk5TTG40Zk1zT2o5V2JaaGFJQmE2bDR6OVVuZFFqbG1teDhObVBj?=
 =?utf-8?B?d0F4dE56RHF2UGlnbjBhcURjU2htcUZXeXNvZWt1UzRzM2FKQlhPd3VVUlVj?=
 =?utf-8?B?TDU5ZnVQN0t4NHJaSFQybXI3TUxlMTVWbE5JQXJGcnk4N0JhNk1sTlhaT2dE?=
 =?utf-8?B?WlVQRzBIZTJ1ekFIb1pCZnhNaE0rTldSRis4NU1Hc1RidkRSbXg4Rnk3Sk5L?=
 =?utf-8?B?MEdpRTRGY0FvYnJ4cUJMMGFvZUxyaWtmSFc3SjZHMVFOeUdBelZBVjFVbUVI?=
 =?utf-8?B?NHl5N0prem1QWnVjcnNRRXVkRVdwY2M5QzN1UlB3OGtUQXk5U1l4a0Z0THhJ?=
 =?utf-8?B?S2VKS1pXVkFBcVBNUjBOd0pvSlgva0RUZzVnZnRId3RqSzgvZW1TaGd0dWZL?=
 =?utf-8?B?aDkvSlhwbHNGQWZTK09xcm16cytRYytDUVNrNW56UWlXTDNuYjA3cWNOejlh?=
 =?utf-8?B?QlVValRGNE5wZmlrSG4vSzB0M0g2UDM0TDZlVnNZOTdLTkNKM3NLQWVrZWVV?=
 =?utf-8?B?NkJiZ3VOTHlzZ3BwekpLbHlZWk4wdFVlUW0vSmRkVyt4TjJDK2dhQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a26165d3-1ece-496d-f682-08de7865eebe
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 14:13:52.7098 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v6vGrfLWetbL8wUB+yJj6L+M8hvzZCVqbbs02/iMTo0qTlBfhrAV86ReB/C7rsTwoLOZu0nkM9T7JPv/jPZf27rzyQ3rNcZP4fkdSXZOnFQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8764
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

Hi Svyatoslav,

On 2/9/26 7:39 PM, Svyatoslav Ryhel wrote:
> Add a condition to enable the PMIC sysreset function via the
> system-power-controller device tree property in addition to the existing
> Kconfig dependency, provided the PMIC supports it.
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de> # RK8xx

I've added in Cc people who have contributed to devices that will lose 
support for sysreset once this gets merged.

Because they are missing a system-power-controller property in the RK8xx 
PMIC Device Tree node, the following device trees will be impacted:

dts/upstream/src/arm64/amlogic/meson-g12b-odroid-go-ultra.dts
dts/upstream/src/arm64/rockchip/rk3326-anbernic-rg351m.dtsi
dts/upstream/src/arm64/rockchip/rk3326-odroid-go.dtsi
dts/upstream/src/arm64/rockchip/rk3399-evb-ind.dts
dts/upstream/src/arm64/rockchip/rk3566-anbernic-rgxx3.dtsi
dts/upstream/src/arm64/rockchip/rk3566-powkiddy-rk2023.dtsi
dts/upstream/src/arm64/rockchip/rk3566-powkiddy-x55.dts
dts/upstream/src/arm64/rockchip/rk3588-coolpi-cm5.dtsi
dts/upstream/src/arm64/rockchip/rk3588s-coolpi-4b.dts
dts/upstream/src/arm64/rockchip/rk3588s-indiedroid-nova.dts

If it's an oversight, you may want to add the property in a -u-boot.dtsi 
and upstream the property to the kernel DTS to avoid carrying it 
forever. From my side, this patch does what's expected based on the 
(lack of) presence of the property so this is a green light for me 
regardless if the above Device Trees are actually wrong.

As far as I could tell, the sysreset driver only implements the poweroff 
functionality which can be called by either the poweroff CLI command or 
the efi_reset_system_boottime function (no clue when/where this is 
called, some EFI thing I guess).

Thanks!
Quentin

> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>   drivers/power/pmic/max77663.c         | 4 +++-
>   drivers/power/pmic/max8907.c          | 3 ++-
>   drivers/power/pmic/palmas.c           | 4 +++-
>   drivers/power/pmic/pmic_tps65910_dm.c | 4 +++-
>   drivers/power/pmic/rk8xx.c            | 4 +++-
>   drivers/power/pmic/tps80031.c         | 4 +++-
>   6 files changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/power/pmic/max77663.c b/drivers/power/pmic/max77663.c
> index c2a7cbf7e40..a06042e2918 100644
> --- a/drivers/power/pmic/max77663.c
> +++ b/drivers/power/pmic/max77663.c
> @@ -46,7 +46,9 @@ static int max77663_bind(struct udevice *dev)
>   	ofnode regulators_node;
>   	int children, ret;
>   
> -	if (IS_ENABLED(CONFIG_SYSRESET_MAX77663)) {
> +	if (IS_ENABLED(CONFIG_SYSRESET_MAX77663) &&
> +	    (dev_read_bool(dev, "maxim,system-power-controller") ||
> +	     dev_read_bool(dev, "system-power-controller"))) {
>   		ret = device_bind_driver_to_node(dev, MAX77663_RST_DRIVER,
>   						 "sysreset", dev_ofnode(dev),
>   						 NULL);
> diff --git a/drivers/power/pmic/max8907.c b/drivers/power/pmic/max8907.c
> index a7ef70177de..34bef0c8cd6 100644
> --- a/drivers/power/pmic/max8907.c
> +++ b/drivers/power/pmic/max8907.c
> @@ -48,7 +48,8 @@ static int max8907_bind(struct udevice *dev)
>   	int children, ret;
>   
>   	if (IS_ENABLED(CONFIG_SYSRESET_MAX8907) &&
> -	    dev_read_bool(dev, "maxim,system-power-controller")) {
> +	    (dev_read_bool(dev, "maxim,system-power-controller") ||
> +	     dev_read_bool(dev, "system-power-controller"))) {
>   		ret = device_bind_driver_to_node(dev, MAX8907_RST_DRIVER,
>   						 "sysreset", dev_ofnode(dev),
>   						 NULL);
> diff --git a/drivers/power/pmic/palmas.c b/drivers/power/pmic/palmas.c
> index 37d4190fabe..e5b497dfc39 100644
> --- a/drivers/power/pmic/palmas.c
> +++ b/drivers/power/pmic/palmas.c
> @@ -48,7 +48,9 @@ static int palmas_bind(struct udevice *dev)
>   	ofnode subnode, gpio_node;
>   	int children, ret;
>   
> -	if (IS_ENABLED(CONFIG_SYSRESET_PALMAS)) {
> +	if (IS_ENABLED(CONFIG_SYSRESET_PALMAS) &&
> +	    (dev_read_bool(dev, "ti,system-power-controller") ||
> +	     dev_read_bool(dev, "system-power-controller"))) {
>   		ret = device_bind_driver_to_node(dev, PALMAS_RST_DRIVER,
>   						 "sysreset", dev_ofnode(dev),
>   						 NULL);
> diff --git a/drivers/power/pmic/pmic_tps65910_dm.c b/drivers/power/pmic/pmic_tps65910_dm.c
> index de8d805566a..bce35603275 100644
> --- a/drivers/power/pmic/pmic_tps65910_dm.c
> +++ b/drivers/power/pmic/pmic_tps65910_dm.c
> @@ -61,7 +61,9 @@ static int pmic_tps65910_bind(struct udevice *dev)
>   	ofnode regulators_node;
>   	int children, ret;
>   
> -	if (IS_ENABLED(CONFIG_SYSRESET_TPS65910)) {
> +	if (IS_ENABLED(CONFIG_SYSRESET_TPS65910) &&
> +	    (dev_read_bool(dev, "ti,system-power-controller") ||
> +	     dev_read_bool(dev, "system-power-controller"))) {
>   		ret = device_bind_driver(dev, TPS65910_RST_DRIVER,
>   					 "sysreset", NULL);
>   		if (ret) {
> diff --git a/drivers/power/pmic/rk8xx.c b/drivers/power/pmic/rk8xx.c
> index d11f7a7886e..95b71d2fe49 100644
> --- a/drivers/power/pmic/rk8xx.c
> +++ b/drivers/power/pmic/rk8xx.c
> @@ -220,7 +220,9 @@ static int rk8xx_bind(struct udevice *dev)
>   
>   	debug("%s: '%s' - found regulators subnode\n", __func__, dev->name);
>   
> -	if (CONFIG_IS_ENABLED(SYSRESET)) {
> +	if (CONFIG_IS_ENABLED(SYSRESET) &&
> +	    (dev_read_bool(dev, "rockchip,system-power-controller") ||
> +	     dev_read_bool(dev, "system-power-controller"))) {
>   		ret = device_bind_driver_to_node(dev, "rk8xx_sysreset",
>   						 "rk8xx_sysreset",
>   						 dev_ofnode(dev), NULL);
> diff --git a/drivers/power/pmic/tps80031.c b/drivers/power/pmic/tps80031.c
> index a2f935b0c6d..6004a14cd6c 100644
> --- a/drivers/power/pmic/tps80031.c
> +++ b/drivers/power/pmic/tps80031.c
> @@ -46,7 +46,9 @@ static int tps80031_bind(struct udevice *dev)
>   	ofnode regulators_node;
>   	int children, ret;
>   
> -	if (IS_ENABLED(CONFIG_SYSRESET_TPS80031)) {
> +	if (IS_ENABLED(CONFIG_SYSRESET_TPS80031) &&
> +	    (dev_read_bool(dev, "ti,system-power-controller") ||
> +	     dev_read_bool(dev, "system-power-controller"))) {
>   		ret = device_bind_driver(dev, TPS80031_RST_DRIVER,
>   					 "sysreset", NULL);
>   		if (ret) {

