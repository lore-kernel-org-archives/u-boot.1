Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBFB2C67861
	for <u-boot@archiver.kernel.org>; Tue,  9 Apr 2024 15:45:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E7F587E06;
	Tue,  9 Apr 2024 17:45:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="Nk/KO7xh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEA4988172; Tue,  9 Apr 2024 17:45:56 +0200 (CEST)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2611::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 997E787073
 for <u-boot@lists.denx.de>; Tue,  9 Apr 2024 17:45:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XcmlcpvlTM+lQ+WKula5UtkoDi9dS/vLVf+jAhTqwsXXt1HuUvnZOBIw2cRFZqO75FoSuHxSbWzkjsz2aKRTwVb5/cNJmdzaDzaRf+ndgQRqBcoRSS9C0OE64WR5+anYFOee0or0AZ9eJVBwXDtjkuDquabwTq9OT9rfM0rmdZlw1f7O8ycTO7jKzfuPWkKDPymimSC+5jVvSSSfH8wbHXtYyvSP+17dO8wQ9gDi/4lZ5XvymEh4CIColJFGiieS1TL7d8tklJvlg9DYnVaWmSsArXV1arz0c3pdC8HHxYVplDZDRXzJqTSbqvyjoj5+x3sC3LvCUKnDqUCWbwjB0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BENPVa8nSsYhq7shMbH4MuENbvhmE/duO3TQKGkXCmw=;
 b=m4VFTcIWuZxnyOK/5BLEAf7WWXu/5c+S+tT+46uMjoDLUXYf4qfk8ygrGozSZX+Mc02zkhypT1ZtA+JAUMF3VJ7eepwF2bzB9Zjcf/QgIvn6iUTYOuEddYNjNeubj63QmSsJZwJY7wVBLNEeaU50aadQNJ9D1193m2LPYJIYLIdkIHPZbFHQJ/Nl71IvE4veRACJQoFYAVtP6fEMlUlLYvXSjzjlrg2YMJYabATyf9g5cgycv6PfH9H7waLtlnvJunQUY9Jzzc7S2iHkTu5BSVzLvLtjItH0yzDQPBhZ04uWwOQDcEL7d5X22on1pfy6Au5qbWQFNvz8nyRsNKln1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BENPVa8nSsYhq7shMbH4MuENbvhmE/duO3TQKGkXCmw=;
 b=Nk/KO7xh2A3fJhDvSMhpqpTqG3v3xa3quvk5inIEamscVo4tEe3WvtlZ4P2KJV07RKKNCrK6xqdlVtvJjDoqmwYp9GECW7wGR785uhx89U0kiA7KM8ghg4Yte8BetNwDWObvsAzOsHeg0BJlGZ9iQ6zbdLSHHwoTyna2CA/Df50mEDSCicakEbUa0Rlb8Oc+TpWPAUuvYERiXnZMpBvl/PoiqjcQBAbPDgTWFIkGGkWIxCk8nNkhTxnZWOZEV186Kir34hTgpk3aO25AVW+wrPODRemmqRPAlLTcywxHiX/BJJeqADLxumSKiN950pGhcDWh0iqMCKOGYh24AjveQQ==
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by AM9PR04MB8842.eurprd04.prod.outlook.com (2603:10a6:20b:409::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Tue, 9 Apr
 2024 15:45:52 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::3e70:7029:faf2:7779]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::3e70:7029:faf2:7779%3]) with mapi id 15.20.7409.042; Tue, 9 Apr 2024
 15:45:52 +0000
Message-ID: <3fb8bdca-042a-4153-ae0f-114bbafcb82f@theobroma-systems.com>
Date: Tue, 9 Apr 2024 17:45:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/14] rockchip: rk3308: Enable random generator
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: Andy Yan <andy.yan@rock-chips.com>, Akash Gajjar
 <gajjar04akash@gmail.com>, u-boot@lists.denx.de
References: <20240408181429.3676856-1-jonas@kwiboo.se>
 <20240408181429.3676856-6-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20240408181429.3676856-6-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0033.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::13) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|AM9PR04MB8842:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: weQMxLApA/OCIrEqnISJpaQOKXRwjFXFSL0rOPD+vHuB/BFDraJdgu0ij661H11Eh3YOpFSL5OtPm4ps87+BHf5OLaMYc+3/DJVJ5y3PUP0cLIsgNQ5BcoSUjhkv1sKPXTs6F74qx2KHndH79/i+XFoWPTsLbVNz6qXFK7olMP8O+90qey8/2cNQsv6Zw44C/pqbk6JPzenNunNhAocw/221JIvXfy9SHkVP7RDxr1MB6IphaQXvHDYlHhQSiD/i9JT3IJl4Ci6rPaYg0/g9onAoI9NhcUAbhOfWszLQsjsQGOx/lC6RZPle1H/ED1CLf5Dm1toaAdLEywGw6Ogyx/zzoooh5JU1yUUZJA1TGHs/LnT5gBdetOhl69qd3A0PBolEvJ8BQy0So7oyeUpzqQzpLYYgjmP2prbGd8km81k+U3LpsxQXzl53opSHrMBx5sz8kJaNk1q2CJ0TPRZRYuvUUXqEIhRRsqxaSFM2EAP0MjQAZ6+irc8WvjPXaDu9epapUu+IvWP/H3ap0QkAzWDgZHIT2ozUItyZxMTs8Dk9ZTm3w9dyUJ8Iomsouat4xLkHs3IN3SROyu6up1sw9uZkEt0g9O0ZSylqCaxi0fQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVBXNFUzLy8rSjVaWExnbEd6a0dqSk4ySmNobG81OXhpRk5SSXhaUkpmaWMv?=
 =?utf-8?B?UUFZV0FRM0R0TTBIaW1MQmJtZnV1YzZaY2xCMkdCNFRVdTFncElrMEFRamti?=
 =?utf-8?B?QVkxbVUzcUJWdHluN2t6YVZaWTh4SUZjeWNFUjhUK0RMMW1oOEtMNUw2OHl6?=
 =?utf-8?B?Yy9CMnpKNHVSNmVLRjE4bDEvWW8wbnIxN2pxeXdPcmNBMVZFTzJmT0hMVWF4?=
 =?utf-8?B?cGxzaE5TNHFXb0tIZEY2L2RyRXYrT2h1NEtldFJiVFlLaldBYmJIdDRRSzBL?=
 =?utf-8?B?ME5DSE5LdDJWRXovdlFqMzVKMDZuM0kxTkFMa2EvT2tWV2dmcXdnN21OaHNo?=
 =?utf-8?B?MnB0eTdtUHhLQzVROGpkTWNYN3kvU3lZandBTHpDcUpKNjFRbGthajExMndF?=
 =?utf-8?B?emd2eHhFMmQweC82djREdXQ2cDRyZGVjVUdQdzZRV29WLzlhajJUaGhSbEc5?=
 =?utf-8?B?aUtGQzhKMG5CSFNSaytJOElDNGR0NmloeWhlNTl5eHdxNXlScVlNWVdqeDFJ?=
 =?utf-8?B?Q2NmR1Q1c24yVXY3NmlUbitCV1FRT2NLd3JjbXRKeVI2WDZMN1JlV295N3l3?=
 =?utf-8?B?K3hWVzdnNGY3RHFYL1dydjBxYzV3OEZpQm5XbEU0em9aajU5L0RxNDFHSjls?=
 =?utf-8?B?MC9GNkcwTmVudXQ5TVRzczQ1eldGVkYwU1I2OGkvREVJK1VUQ3EwcFhBSUJR?=
 =?utf-8?B?T2pSOXgvSjh4VExMYVNpeGNBRFlFb3BsRlgwakgrdlhBcU5CK0hVaDU4MXZ6?=
 =?utf-8?B?clRFTE1OYXN0QTVncWhRaHZyNldSMVlCV3hmYlhtQmZSTk9VOWFueitpa1Vw?=
 =?utf-8?B?OXAxbklhUVoyeDJmOThSdUxnRWFkSC9XSlYvZ2RVZU85OSt6dnU3WWVaSlpG?=
 =?utf-8?B?TXc5bWxMMDFjOEdCKy9HbDBpYTNBNVJqeEU3YVF6MUkyUkRkQ3ZuSUFJMkZn?=
 =?utf-8?B?eWVPQnNidlZZclM5TGxPUUs2TUIzNkVmYmpaSkpFQTkrdDFJYzF1MDh3aFE1?=
 =?utf-8?B?MHAvUEttQ1ZIaW1mVkdFdDBPbnNCMVIvWXRhZGdLVGRrUzV2dHpzM01Oei8r?=
 =?utf-8?B?ajBBN2p3dysvcW11VGtXZkhoTGZKbkE1TFdBa3NrN1VncnFaWlE1NmgrWUEw?=
 =?utf-8?B?eHlyWFVBaDNFc1I3emRRRzV3SUFCU0cvdkZBNXlKdXlFMDFDRzJ1UWhSTjE3?=
 =?utf-8?B?Q3RjbHBNQm1xYTFod1k2dENHMG1saDBiVDBQU281TWMwYU95V2lQbW8zRFJY?=
 =?utf-8?B?a0RoSksrYXhyNTBiV2RJazYyY21xSTBZY0xaL2ZvR0ZaenRURGRpUDRZWCtm?=
 =?utf-8?B?YktkTTVRS2RGUXBYOEkreFF6bG5IbkFNSjhZdmxxTmN6RWd4bVk4Tkx2Zis4?=
 =?utf-8?B?TERHdHQzcXlHZEtXbmdxSStwYkJQZm5VTFdwQ1hHa2FWR0gyNUkvenRzZVRm?=
 =?utf-8?B?OVFHTEdHVEZwQXZKOU5mTTVLK1BlbldqVUY0eXlqdlBVMjVEcWY5dW5yM2M3?=
 =?utf-8?B?b1Y5THFwaHBMWURFTm43SzRIRlJjb0V0VEcvb3hzb1JHTWFhWGc1VDlLanBW?=
 =?utf-8?B?VFJ1WWxyaGhvajR4T2xMRGE2Tlp1RUFqOE12UldmcXRHZy8zM2Y2c1hEdmht?=
 =?utf-8?B?aEtOMVFrZ3RYUnJHUzQ5RTVWVktYZnQvcFl3ZWFTdEVkeWpPZCtFcGtXa3Vj?=
 =?utf-8?B?eDNEemt0UTBHZkszRGNBZGpYYWdrMCt4ZXQwSEdJdDZjaVBSRTVqUmpsUFZF?=
 =?utf-8?B?L0xGYU5HUkFndDFPQ2ZmM0xEeXZTTUtERVBVZWZLa2tVbjkxVWVDMnNJNW5m?=
 =?utf-8?B?Rm5aL3orTitjbXRwV3VCOXU0a1VEc1RVVHBKR21TRWNGamQyajlQTEh1Z2lr?=
 =?utf-8?B?OUdPL3dsUDg5ek9VRE9sUWk2b1dYdDVLOFpMeXdyQmczcnhxMnVmSVdXTE90?=
 =?utf-8?B?Vy9ySzFUYURSZ24yb1BYaU9jc2JXN2pobzVlMlNPZ2NYTW5lT003WFNJNkZH?=
 =?utf-8?B?ZnR2dGFXU3hPYWxVTy9odC9IaUZPakxZcUxCUGNoOVRRUHR3a3MwdHFqWkRZ?=
 =?utf-8?B?VE5US1pvdG5yNGxLK0JGQ2xVQ3grZ3hoMUsxclN0RTR5UXF2aEV6VzEzL3F6?=
 =?utf-8?B?TUJEUjJDOGg4WlcyMnpkTm92dWhWT05hdlk2T2ZFbW5yT2pra0F6S3AzQWp6?=
 =?utf-8?Q?ueanbbro1iK6a0TgGzJDYVg=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64b73a27-9b43-446e-a075-08dc58ac22ec
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 15:45:52.4822 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KJVccdgIiPIKzwzfGC0X2zVpKDAl6DkWCOoFT/AUTiFBtvaJKppu+UVucdDLjGqF0naYAtOCcxY5h5yXjY7qjW7w6SpZ/abPFqfIDN5nohDvD/sdgsBRbStcQ5c7sxBw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8842
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
> The RK3308 SoC contain a crypto engine block that can generate random
> numbers.
> 
> Add rng node to soc u-boot.dtsi and enable Kconfig options to take
> advantage of the random generator.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> v2: No change
> ---
>   arch/arm/dts/rk3308-u-boot.dtsi | 5 +++++
>   arch/arm/mach-rockchip/Kconfig  | 2 ++
>   2 files changed, 7 insertions(+)
> 
> diff --git a/arch/arm/dts/rk3308-u-boot.dtsi b/arch/arm/dts/rk3308-u-boot.dtsi
> index 436f66d1b87d..fa31c838d34d 100644
> --- a/arch/arm/dts/rk3308-u-boot.dtsi
> +++ b/arch/arm/dts/rk3308-u-boot.dtsi
> @@ -26,6 +26,11 @@
>   			reg = <0x07 0x10>;
>   		};
>   	};
> +
> +	rng: rng@ff2f0000 {
> +		compatible = "rockchip,cryptov2-rng";
> +		reg = <0x0 0xff2f0000 0x0 0x4000>;

Downstream says something different:

https://github.com/rockchip-linux/kernel/blob/develop-5.10/arch/arm64/boot/dts/rockchip/rk3308.dtsi#L1007-L1020

I couldn't quickly find the TRM for the RK3308 so cannot check myself :/

Also seems to be missing clocks and resets?

Cheers,
Quentin
