Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F73BC44501
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 16:30:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5DC184A63;
	Fri, 10 Jul 2026 18:30:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="YFcjGrwI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6BAB84A73; Fri, 10 Jul 2026 18:30:18 +0200 (CEST)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82E8F8498C
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 18:30:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jB6KNu5oUJw8PYzVCXVJ1ft5ZiqNlyr9mLtjFpyBinoilmO+pOlGZXZZ2Xl8jXMECjYpaLcmvTnjTPwrIb8mrwmUpJwYaHSoJiL35axbxjS1HtsZESHa9qeaYBjHy/zVPAGMq2++AoHJA4cLtSKUOsoqW+nR3eoI4cuGzWNqLmsfE/afm4mighZrgPDtWyAZWVwj2MmeeaTDDBTazQsZuNKvRdGqXeGGkxhAF9yLE82+dslJROdGee0//zcIoNUHPDybKVfsLZKIt3/Z/hRyhQaEJP5vo1GR0Ul58T2T0jMKYK+/pVDxgYLkva8lf136L14h8pGMhrBB2aukYnuMGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O14XgHrY67lx+6xrmtMX5/Pa4ttBYkfAmzf253WFAig=;
 b=FXZ1LifIC9Y/6YkNLcgmZQ4iSXXdvS04YvSDDTS0tGQ4+zuW7bvsEa/hIloVorT6+irPnkpsPlDwy/TGoPDzUHSOV3crCWdo7SaLWxhYt3A+vCQyQ1SREYCTv0s6Ak9Q097u7zpFd/XG406lcE2Os3dMNJkAmT7vK+mv+7X8NtT1IfcSQhswK8atIbbNeKtaM3u33qoXmCE+vq0efPCEW/l8suTaZ+D5Tdhz1uZyzoZM1S9FmARA3E8yIVyw6OKYvXlKJKPm6KZ1tbN6TC7QV/pNrYALBCyYKmgZW4xjTJakD1j13YF97hZqSf6KMD1H47hvCTROI67uAk7AnEorKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O14XgHrY67lx+6xrmtMX5/Pa4ttBYkfAmzf253WFAig=;
 b=YFcjGrwITFayLBJY0pWMNw8jS7cYUlHUNsWLUDikX6Q8Yjxm4RrhszXh7ZJwRfk1v5uvsU2dZxG7VASNtW3PODzMCJaqHKUrwOUCq+IN08Dcp6y3CG01dqVn+PHoUh0xLKe3iPgL6YALiZ2jngBGrg89gT/j4vKu0f59abu0FFuciDw28SNBE5FV/50SKoQmfAAwJFpAfwISsDc45yDexr2CrUbhzzHhwUIO2Tics0mk8YiiRmf+aL/4RmSwZTDvDh6bH8pYXTGlzGKOakKOEEZn7LqPNfRwyzOI9Qt3yvMjd4u/ghGlEkRRM8idHye9T9WSNRLmvz6v0zhcBojpjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by IA6PR03MB444442.namprd03.prod.outlook.com (2603:10b6:208:5ea::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.18; Fri, 10 Jul
 2026 16:30:12 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235%4]) with mapi id 15.21.0181.017; Fri, 10 Jul 2026
 16:30:12 +0000
Message-ID: <720a1b0e-463e-4c24-ac3d-28b8f39a9fcb@altera.com>
Date: Sat, 11 Jul 2026 00:30:04 +0800
User-Agent: Mozilla Thunderbird
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
Subject: Re: [PATCH] arch: arm: dts: agilex: Disable gmac2 node for Agilex7M
To: alif.zakuan.yuslaimi@altera.com, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>
References: <20260429081529.5713-1-alif.zakuan.yuslaimi@altera.com>
Content-Language: en-US
In-Reply-To: <20260429081529.5713-1-alif.zakuan.yuslaimi@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI3PR03CA0003.apcprd03.prod.outlook.com
 (2603:1096:4:297::13) To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|IA6PR03MB444442:EE_
X-MS-Office365-Filtering-Correlation-Id: a053bf87-72a1-40c9-202c-08dedea08399
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|55112099003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: gfkT7ZOwmt6OEb4EU3VaehaE6GrRZ2uJwJXbbnu69Pc8aCb9eOdOAVyU7PuGcu6pnnIj3WtqE2cJkBmdATnfPEvv9W278/RmPTkkT6scH27NwUnzO/Cp7w2Of+foqRNhgKAZx1dtaFKBmj/KAwYtjyuipzz6Sm1hky2ZtgXu21HiYANM3vJaU2h5NzI7k+DFla091m4+tWH5Sax/HaUocqHNeYniXCOHN65MFiUKi5J5B21ZrRnXCtK8yqjdX05lBVZ2qp+RBJ9CyyxaT2CkZjkSRkj1wyRtYK9QdJkJXCvnZDGAErsr37k9offCRQJuvVf845jwYq/M2wlNK6XVmawxltauVI5Nx8/QbsbZWLeeNoh2VlYdXnMOeZ4wZ45Yxag2uHzwXVuHOlNh3ZTwdC1Y3s0MPNWow2ZC//fY3QwKiYB6f4EtBhBa7ZYFpSdIrTunW/uBz5paHB5yqjWAYtZ3HKCXQTdaJtgC6sW+DMioAr/a87gcGYNDxoOIDrwlSyqK3JDNJoKacq6NruD6DmqWslM+bKFCg9RUBQ07naFMCWrKdZQBsGdfeZ4tD1rSTh+ydg/vW2PgiczkocutOjWvYkdxmePCVWU41X1COodkME1horKiwcltNBrysFlmvHLE+yU0aw0NsbTqudPxCsV7lGbpXU1gzde+C+S5QM0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(55112099003)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3BvRFM1M2FXYTNPMFFJYWhhc3Q2MzVHR2VmVThibjVPNDRDRUpJWjEwOUsz?=
 =?utf-8?B?c3lCMUppQTMyTDZOT3ptdWFwQy9oWCt1QStmTzhTbld2ZzhnTTRjZW4rM0Ju?=
 =?utf-8?B?aEtBNVd6V0l6V2laRHBMQlhmczZmSG1qZUxlUmlwcGN1WTN5QmtIT3IzMWNZ?=
 =?utf-8?B?aEx0YmtrYnFGV0xydncvM214VytURXppUU1YSUV6aVdZTGVXQjNhcThWcVB3?=
 =?utf-8?B?YXBNNHA0Vm9oR1NVenBwMVN1RVZwZnF0RVdJZVEvMFU0THhFYThlN3dqcHhK?=
 =?utf-8?B?Zk4veDNUdGlGRDgzZVlvN0lWd1M0UGN6OGdOTURBUzFMajY5RURtK0dlcHFN?=
 =?utf-8?B?TU0yaHduY2RoTzFuVGRVc3A1dG96bFB5YlVmWnVCNkdUTmZ0SmdWVTNIaWZB?=
 =?utf-8?B?S1dKQ2ZjcytNeHQ1cEMxbXMwUlo0UjdqVUN2enlFMGVqNEpabXZ1Sm10a1FI?=
 =?utf-8?B?bm9NSGZtcnB3d25EZERZWXJjNzRabHZXcGUyWkdHTXVGRENXR3c4Mzk5UHov?=
 =?utf-8?B?bncyY2ZyeGg4aVd6UEM0MW9FSms1OUdlMm5SN05xb0xZSU1leEsvMzJBT05i?=
 =?utf-8?B?OHUrZmhhUW5PU09TYnBuZG1XTjV0OFlJTVFZd1EvSSt2K3diTXJaTjRIc0E1?=
 =?utf-8?B?SlVYalJYRzRldURCWXoxc0dkQ2t2T0FwZEpZM2FtYUUxcFF2MktmMzVmVDJ2?=
 =?utf-8?B?NGt2Ukl2Mnhlc0l5L0VFc2p4VXhDOGFnQnlVUmMyVEUzT1JPeFBJSnZzcGhM?=
 =?utf-8?B?WWoxRHE3RE9wVnV6ZSt6YVhYdE55NFhqL1MxMkh5aHk1YkRjaUlkSlMxNm42?=
 =?utf-8?B?THdQdnpZTWZCaFVpeHFWdnpGQ1ZlaVV3SFp6RzgrTkUwdW9vNEU1emU4UTV1?=
 =?utf-8?B?RUZsb2Z0QnRwY3I3MVJuVnFtWjcwS2JidDJoR3FmWDhyLzU5SkEwMjNiRVYr?=
 =?utf-8?B?Y045NkhYbkRuTklRN1EwVGJaeW9yWU1MdllLbkhpS3phMG5LbzVZQ3FzdVE5?=
 =?utf-8?B?SkpLNVlDYjNqeWIvd0VMKzg0SDdXeXpJdDJHSVRVQ21hVVJkQ01ZL3puQ3p1?=
 =?utf-8?B?SlVVRmcydHZYSW85ZUxZcWt2dFFNMkI3Tm91WmFua0xzaVBrTTJMLzFkM2py?=
 =?utf-8?B?NEVaMDREclc4YUl1UmVWWWdzYzlpLzlLVUVVVXZyanI1Zk51UDhBSUtPZ285?=
 =?utf-8?B?bnRYS2xlOWRFL0tmTFRzYkFLRmZuR2Naa2xTQStRV1ZneXdUT0lLWFNHY1hR?=
 =?utf-8?B?bjhDc01OQXJxTVVYK3hsYnlFRDR0WXU4SXBsblBvSzhHWVg4YTNZVUZJWEZI?=
 =?utf-8?B?d0lIcmptaHovWVlrWFZFQWI4L1M1NXNrWlMwU2NXS2ZPWEhlYUkyMFZRNTBN?=
 =?utf-8?B?Y2Z3TnFCZXpBZmV3T29QZ3VudHhPZ3pnUW1NNW9LTjV3VWwyeURNeVNQbEFr?=
 =?utf-8?B?ekU2OXpQWlh2WWloTnc3VWNkcXg0dEpYY01EZ0p4U1JDa1pFd1NteUlDTjAv?=
 =?utf-8?B?WXZRcHlOMGxoQUVVMmV6Q3J0TzB5L214WlpGL3RoUnFnRjlHN1R5MXVreEFM?=
 =?utf-8?B?M3UxM0p0a2RxdFRXTVJHMGNoSkxham5tdGZxd3VhNXM0S3crY0N3UzBYaGxw?=
 =?utf-8?B?Q0djN0xIeWROdGRCZVE2K2NpRDRGT29mK05yVHo1d3lpeDZwUEhZelNzWkNh?=
 =?utf-8?B?YTZxZm13MjJyWCtpd2U0SDZxcDlHRERrM0J2YlV6Z2xNTmh0ZzAwbkdkYmE4?=
 =?utf-8?B?R3hid2ZLc1pjazRoSHRUNlNMWkRCeFI2dldPLzhsKzgzWXZDY1Z2eDhPb2ow?=
 =?utf-8?B?b0FXYWFJeG41RU52b3JKN0ErQ1dHOHoyZmsrLzBrM05zbUx3QVVZd0hISno3?=
 =?utf-8?B?MERjeGZ2dm11Z0UwRWN0cCt1YWZUaFVFSGs5eUVHbmVoUksxRGtOVXZPMGJl?=
 =?utf-8?B?ZGxuQkNiS05YdC9PUUhRU1NPRm44eGR6a3BkbkdrMzhYVHZ3bmhmNEIzc29i?=
 =?utf-8?B?cVFZRFp4dGNaMGdxTzFBMXlDc3JYMDkxU1FJTmFBbHhqdjhLL2FTbDdxcXJh?=
 =?utf-8?B?SVcveGYvVGgzYU1iN01GWUZqMXgwM1EwNWdUK05EYzQ0aWJ1UHR6ZlVUMzRa?=
 =?utf-8?B?NHJNeThtVXY4RytLRGdUT1hGdUVVS1VZczF6QTZ5TG5vcmphRUxRalEveERV?=
 =?utf-8?B?NEtBRkVRZUlPOWw3QjRTbC9od2IxYmhnc2VVS0V1VHRGK0tvQnZYZnFaNVcx?=
 =?utf-8?B?azhleldHZ1hoMkV5RFBncERKdGh6azNVNnEvUG81eTc2N3g0TDVEL3RmaVdi?=
 =?utf-8?B?SlRMSWlQZzRMQlQ1MGJuS1hXZkt4SitPVUVtRUltSUVacm5hWUVEdy8zWit6?=
 =?utf-8?Q?5NpNYQcoRDAxi1AA=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a053bf87-72a1-40c9-202c-08dedea08399
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 16:30:12.1641 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 65Kr6eLXM/8MD7uuJ82QsNjuataKRfKXalTNBSBzUZc/JrAOZaqRpzc2Da0FfKi1miHxGb2D3LEQLhsTdayzvu1s4M5Ln+xghOMyl5r0QQs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA6PR03MB444442
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

Hi Alif,

On Wed, 29 Apr 2026 01:15:29 -0700, alif.zakuan.yuslaimi@altera.com wrote:
> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>
> Disable gmac2 node with the incorrect settings to only enable gmac0 as
> default for the standard reference Agilex7M devkit.
>
> The gmac2 node can be enabled and configured with the correct
> board-specific settings for other Agilex7M board variants in the Linux
> device tree.
>
> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> ---
>  arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi | 30 -------------------
>  1 file changed, 30 deletions(-)
>
> diff --git a/arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi b/arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi
> index f2150b7eb7b..9dc2c66f6f1 100644
> --- a/arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi
> +++ b/arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi
> @@ -69,36 +69,6 @@
>  	};
>  };
>  
> -&gmac2 {
> -	status = "okay";
> -	phy-mode = "rgmii";
> -	phy-handle = <&phy0>;
> -
> -	max-frame-size = <3800>;
> -
> -	mdio2 {
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		compatible = "snps,dwmac-mdio";
> -		phy2: ethernet-phy@2 {
> -			reg = <4>;
> -
> -			txd0-skew-ps = <0>; /* -420ps */
> -			txd1-skew-ps = <0>; /* -420ps */
> -			txd2-skew-ps = <0>; /* -420ps */
> -			txd3-skew-ps = <0>; /* -420ps */
> -			rxd0-skew-ps = <420>; /* 0ps */
> -			rxd1-skew-ps = <420>; /* 0ps */
> -			rxd2-skew-ps = <420>; /* 0ps */
> -			rxd3-skew-ps = <420>; /* 0ps */
> -			txen-skew-ps = <0>; /* -420ps */
> -			txc-skew-ps = <1860>; /* 960ps */
> -			rxdv-skew-ps = <420>; /* 0ps */
> -			rxc-skew-ps = <1680>; /* 780ps */
> -		};
> -	};
> -};
> -
>  &qspi {
>  	status = "disabled";
>  };

Looks good to me. Thanks.

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong
