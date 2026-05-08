Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1B02CD342F
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 04:18:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6355F8490D;
	Fri,  8 May 2026 06:18:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="s2cVaVeg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5417684BC7; Fri,  8 May 2026 06:18:18 +0200 (CEST)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92043846D5
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 06:18:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NO5GB9hDCKfYrssZvVtIzHRoJhG0TPYf6UUheuAHH610TUiqDPfSsHdEiuTsebIi87YG2uydwqKMC+CrZ/AfABqaU2ZIEni8J/Wb58iszJKnDIm2wKdQ1aBK9S0SRbQ7Hxh/lfGplTg+IVxCRmAhl3K3tpZeHGzSwF0Vr3voxU2nuqT14xH9XNvYTMnmHNHrG3blFs9ohCV/uu5tK+L26PwZlYdxSCdDbRbx87pjcnXCJBDImGD7YzDFn2sU5T3pyXu2dRtX1Cim7G0cvip8pI6mijoZVBeOo3/N5ZP7BubfV3pKQdyGBVgGr3tUH4zHzSvFlGYbgOKpkzxRSS0P/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+6/mXe37eNq+OixwwGxkW3QzYQO6Dsb59LtfdGx6Zl4=;
 b=eabSmMLpQ+9RuocQkUgIn+7QyycVMh7agLCBMH8TYFtoZew8hflEFhKQK9kaD6B4segprlvek43dtxE8gROP/aKkPMFmgfh3uHgdPV6TESvdJfnobAVKWS2M9Fqp2thQmXXR/6Q18hyrxKmO0LT9nZbjreC30uAzShzuEnDVhr8+P+w8Gxm4p9OL4kNbSxnqTYDSzqAcmwnlApQe7J1y/d4MGIpk7EX2DrFBQOQ0dSGm8UHkLawXTj249/uiYaRGeEOOnn8JtUxh+xzz2rZcu6IndnN7fUiqvn1E2IsDfX2i2ymlrAP0RqIRGyhE0B3km62Qc4GUSmkPW12vz+d3pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+6/mXe37eNq+OixwwGxkW3QzYQO6Dsb59LtfdGx6Zl4=;
 b=s2cVaVegmTXNAPkhkIgza3yirxxIJtxc8jWUXW9Rg5NXQP3QwNx34hIjaZwh2/vWdYtzPZIDDrbkK6rMgAhP/Lq+PqgKjg1NkGazgiZI+b65IYDlIN2ITwLLsibfN45YDxyKSgoqcsjjLiDKQEJp6pIdVCVCtWIAkf2Pl0kj0ysV6M50VYlXG478m+GtjC6bd3zgF2n9l2mbep9otl+qtQM/tEexhkSmQvpZMih+MxN9xrgtJVC7nZFpEFSuBDHTqK2IRcB8Rp4lmHW/f9Cr/XtAruI6IKfE8yMFbR/rFzNOiDjmbCKKck/8mwalMabp9csjg2SGGK8E+4I+JLX0VA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by DSSPR03MB989212.namprd03.prod.outlook.com (2603:10b6:8:377::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 04:18:12 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235%4]) with mapi id 15.20.9891.019; Fri, 8 May 2026
 04:18:12 +0000
Message-ID: <3f9e5302-2a58-4840-b304-41ee43926b34@altera.com>
Date: Fri, 8 May 2026 12:18:03 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/9] arm: socfpga: s10: Enable system manager driver
 for Stratix10
To: alif.zakuan.yuslaimi@altera.com, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>, Yao Zi <me@ziyao.cc>
References: <20260428034822.23756-1-alif.zakuan.yuslaimi@altera.com>
 <20260428034822.23756-6-alif.zakuan.yuslaimi@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20260428034822.23756-6-alif.zakuan.yuslaimi@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::19) To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|DSSPR03MB989212:EE_
X-MS-Office365-Filtering-Correlation-Id: bb87e4ef-01df-4c54-5586-08deacb8d11c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|55112099003|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: YgFrjXIKiJQ6oK1zyPFVWo9Q3OS2d1grU96BLegir58CC+yark9lXUHgOCsZlgxHMUPT4KaC8cIWPJFUCSIbAOyXOYf0uEmFL9MLpyGhy7Xt4shFwXH9zQEReGYlX1cbpk7kfxOVpDptIHT3zKntpbSRUsK/VzUQltBy0PBbzuzZyZz8y4BDNka3TajNwTtS74RDzDMGBqfE7tyvCgwKytPTNJBO0ygRBXC5+1l3+9Xqq4pl0cn3k8cOsHXHjdWiMBnCOStio4Rq3n/MMy5tI7JDWJcX9ypG6djt0fEc+sJiIlBJDnM033z9C9VnjF7gpFXdeGINULaU+iYA7XLzV5igYmPrpS/VxhCHTwEz3AUnBxD8RP+r7TQY7R4mh5yGg+G59OHBnF9Ok8AFqiZqmBoOaF5mzcRfPyp3EQXAthzGBE/mfxotiOYhhndUCO/reFOLcLvpFoQpb9kLv2HIx2LN7J9ipb7uW9qTY4PDoP3Am60GWiDBE5M1LXpFTD+DYGue5/DJ4BkXEhwofKafzZuypO0hfnv0D5s0WvrNnfSzZqcWatPgu+RsBxqkr5N4Enw8LaseD9b2l1965BI0iIUBwDVb1vE17qWALxH7Z71MHZjji1hU5VZX6/mc+D3m6OjFF1RQCrePkNQbjH5EAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(55112099003)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0I4cmNRNnVjYnZLMnhGRkVhc0dqaUwvaGVyVFQvT2o0eldFU3NHc3FvR01v?=
 =?utf-8?B?RmRtY054SGlRVzREdVV3K0lnSHVLWEc4UTI1RXZwOGtxUzZBTmVlM04rM1RN?=
 =?utf-8?B?eWw4eDN4VFNJUWRhSk5jZnR4V3BiWWk0bkZBK2FFcG1tVEIxTDVLYkNLOUl6?=
 =?utf-8?B?a0xGWGo2MGtIZUtyL0RadzZFYlI4MzdvK2ZpQTMrTW5KQWhuQ1JzYU9TVUJv?=
 =?utf-8?B?TTRrcW5DVFR4U1N0Um5hOXJVNVN0LzQ5aVpBWmIzbnI0RVAvZFZQR2llWEwr?=
 =?utf-8?B?YjEvV25zNjFIck1jYzUycWtPb0RGMWxmdk14YnJPVjd2SW9pOHFtbEVsWUtB?=
 =?utf-8?B?aDFhSExJYWYyKzJ4U0JnWGVwS3ZWZW5SaWhoTXA0elJDdU9kVXhMNTJGbXRS?=
 =?utf-8?B?ZnZ2ampnLzFENHdsL3FRbEtpdWNmNGtJM1BrenZmVWVodG0zUXk2UGh3Tm5a?=
 =?utf-8?B?WDd5VndOaUFwbG40SllZWU9aUWVZRWdDWlZKRVJEczlOVitwekhiRXR2dUV5?=
 =?utf-8?B?ZjhDVEVsREkvOU83dTE3NmxSSW96ZE13dEpxYVJrUkVaeHo1VmdMc2hOakoy?=
 =?utf-8?B?SitFbTYxRUhMV3FDZUcyaEh4MWkxaEI5bjc2THY1NStvY0ZRQWFKbnlqMzV1?=
 =?utf-8?B?STh2NVQ2a2FncVVFTS9NQkJMbXJEU1RwM3FXMHgvNFNpOHluVjQvNS9TZExS?=
 =?utf-8?B?MXZONmVkc0lEWERkN3RoTWgwRWhZdmRSQldOWjVoNXBBd2grajRZb3EvNVhx?=
 =?utf-8?B?dksyM2pwUkVJT1dIWitBUit0T3RWZUFxSzF5Um1obzdUVVRpU09wOVZTQlp6?=
 =?utf-8?B?Zml1Q3JicEkramRYVnR3eEhNZmUvVXhMTk9jRmpCYTk1OVBOTEdyaXhUbEFZ?=
 =?utf-8?B?dFhiL1dVMFo2SnJ3WlN4MHI2NW1rKzR1bmhFSGpNc2VUaGZXSEdxNmJxOUhR?=
 =?utf-8?B?NURFT24zaUc0SnVpRmlyaVRhNFExa2laaUk3ckRwanNvdkxENlpKOUJXdnlM?=
 =?utf-8?B?RUh3UnJTSmpNbXhYVVFoR1N4UWkxMnkwaXplTWZsSVZhaDJvZGRLeFRGVGh5?=
 =?utf-8?B?Z0hyUUtoMVRkaDFHSVJQODVEN2IvS1FrK3dVREZDTTE1bFY0RHNpVjg4NW9q?=
 =?utf-8?B?ZEtJZVFReFhkbUVVd2wwcXFvc2tFTXFMKytJWXRGMVRBV2l1VDY1LytSZits?=
 =?utf-8?B?TnBETkpoODg0UFpDNGcraS9zT1EyMjZnV3o5aC9OUlpzUHhTWUJYTm5BbWov?=
 =?utf-8?B?YkYxMUFNRGhFR3FvRzluU2xGa3U5ZEZuZ2MrdlJzekozc0d2Q3hCZXZFSnll?=
 =?utf-8?B?LzZ0TDZnRjRRRXlRNTd0azBRQUVyNTR1dEE4NmVMSXl3ZDJvMGhjM3dvL01z?=
 =?utf-8?B?Q2dpb2NXQ2p6Y3ZxQ2toR2JhU0dlSjY1djJDU0VlZnZQdFNaUmlva1BmLzZV?=
 =?utf-8?B?ckFBdmxjTUxuSzFJNWYzejlsaWFJTFdROVlVbUNEdDJNQVNTNTVUdG9Yd0ZR?=
 =?utf-8?B?OXBjL1d6N2dhbDBjalVDWDhkcGFSTnpjaTBVNFBPR1J0cVVPNHEyU29ZdUN4?=
 =?utf-8?B?TERjK21XNGp1ODZhVUpOQUdPV3NtYzcxMVJ3OCtySE9WU3lwTnFpc0hSa05X?=
 =?utf-8?B?cFF6eFdMS3UrSTRTYVBvWFZKSGtMNzQ3MUpxcTFPL1NYamoxY1A5QTZJM2pi?=
 =?utf-8?B?QjZoa0ZoNkV6SXQ3NFQyZXpONFUxeFhYODE0Y1FsZDNla3VZZ2dSeFZlb01B?=
 =?utf-8?B?SW1qc01ncDZPNTNTTHJaUDZNcEV1M0pRQlE0NndtaFRnenppYXhRb1lwbTBv?=
 =?utf-8?B?ZnQ5RnhMZ1ZGK3FJdHoxUnJxM2dLNWsveUNveitzZkZiQ2F2Yi9GR2M5eE1x?=
 =?utf-8?B?SzZ2QTNiZ2orU282d1Z4RGgyOWI4Q011QXZ3dTY4UFh2ZlZsS2NFQWF1VTBJ?=
 =?utf-8?B?elhBeXIvL3QwOXlTRGpXWjU4Sm1CbjFqSTg4eVc0VHNtc0JPRytsT2FrY0Ny?=
 =?utf-8?B?dFU4dklTUmpzK1hIYzNoeW9SS1hoa0NHWjBRZDQzMzFqbjlMR1gzbnpwWElN?=
 =?utf-8?B?S1ZsOWtidm9RUFp0SVZZOFU2MHhWR0xBeDFwRVRxQkNVL1Vld05mRTcyZWp2?=
 =?utf-8?B?ZkJnaUhmWk0zVTBPSVRDaW41bG94eTlyNG1SbnNHb0NPR3ZrNnlvaDVJQWF3?=
 =?utf-8?B?U09QTUNjSlRsQWJZbk1yZGVYb0Y4elZWdXpKMVNrTUx3cW1tbTZwRldtTDVG?=
 =?utf-8?B?NFlMSzFTRittV0JjRU5jT3FNR0dYZWwxdHdFQTFPMjd6elBpejMxNWJudWhh?=
 =?utf-8?B?dUFxVHh0cXdFd0FCTHVmcTd0M0RwYlBHeEorem9qNnJhVlg5VkN5bmZwVHBQ?=
 =?utf-8?Q?vedFKY7Mjb9ujpd8=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb87e4ef-01df-4c54-5586-08deacb8d11c
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 04:18:12.0442 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RVdWI05Qxddrzu3DFraSOk8/ecIvGO60ZnVRk/4hpWx2zgs+DUdcpB7jxF6OzVvE5k7M5mBPkitUDHO6HSIZEI4pSL8KBhFnVSUukCuSEYc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSSPR03MB989212
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


On 28/4/2026 11:48 am, alif.zakuan.yuslaimi@altera.com wrote:
> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>
> The base address of system manager can be retrieved
> using DT framework through the system manager driver.
>
> Enable system manager support for Stratix10 by probing the
> system manager driver to initialize during SPL boot up.
>
> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> ---
>   MAINTAINERS                                |  1 +
>   arch/arm/dts/socfpga_stratix10-u-boot.dtsi |  6 ++++++
>   arch/arm/mach-socfpga/Makefile             |  1 +
>   arch/arm/mach-socfpga/misc.c               |  3 ++-
>   arch/arm/mach-socfpga/spl_s10.c            |  1 +
>   board/altera/stratix10-socdk/Makefile      |  7 +++++++
>   board/altera/stratix10-socdk/socfpga.c     | 12 ++++++++++++
>   configs/socfpga_stratix10_defconfig        |  1 +
>   8 files changed, 31 insertions(+), 1 deletion(-)
>   create mode 100644 board/altera/stratix10-socdk/Makefile
>   create mode 100644 board/altera/stratix10-socdk/socfpga.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 056902f6ef2..d1173126fc6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -156,6 +156,7 @@ S:	Maintained
>   T:	git https://source.denx.de/u-boot/custodians/u-boot-socfpga.git
>   F:	arch/arm/dts/socfpga_*
>   F:	arch/arm/mach-socfpga/
> +F:	board/altera/stratix10-socdk/
>   F:	board/intel/agilex-socdk/
>   F:	configs/socfpga_*
>   F:	drivers/ddr/altera/
> diff --git a/arch/arm/dts/socfpga_stratix10-u-boot.dtsi b/arch/arm/dts/socfpga_stratix10-u-boot.dtsi
> index ad4b383f704..89fa0e829f6 100644
> --- a/arch/arm/dts/socfpga_stratix10-u-boot.dtsi
> +++ b/arch/arm/dts/socfpga_stratix10-u-boot.dtsi
> @@ -13,6 +13,7 @@
>   	aliases {
>   		spi0 = &qspi;
>   		i2c0 = &i2c1;
> +		sysmgr = &sysmgr;
>   		freeze_br0 = &freeze_controller;
>   	};
>   
> @@ -283,6 +284,11 @@
>   	};
>   };
>   
> +&sysmgr {
> +	compatible = "altr,sys-mgr", "syscon";
> +	bootph-all;
> +};
> +
>   &uart0 {
>   	bootph-all;
>   	clock-frequency = <100000000>;
> diff --git a/arch/arm/mach-socfpga/Makefile b/arch/arm/mach-socfpga/Makefile
> index b6f35ddacc4..962dce67c64 100644
> --- a/arch/arm/mach-socfpga/Makefile
> +++ b/arch/arm/mach-socfpga/Makefile
> @@ -39,6 +39,7 @@ obj-y	+= system_manager_soc64.o
>   obj-y	+= timer_s10.o
>   obj-y	+= wrap_handoff_soc64.o
>   obj-y	+= wrap_pll_config_soc64.o
> +obj-y	+= altera-sysmgr.o
>   endif
>   
>   ifdef CONFIG_ARCH_SOCFPGA_AGILEX
> diff --git a/arch/arm/mach-socfpga/misc.c b/arch/arm/mach-socfpga/misc.c
> index 1eef7893e54..418d7dfb572 100644
> --- a/arch/arm/mach-socfpga/misc.c
> +++ b/arch/arm/mach-socfpga/misc.c
> @@ -263,7 +263,8 @@ void socfpga_get_managers_addr(void)
>   
>   	if (!IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX) &&
>   	    !IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX7M) &&
> -	    !IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX5)) {
> +	    !IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX5) &&
> +	    !IS_ENABLED(CONFIG_ARCH_SOCFPGA_STRATIX10)) {
>   		ret = socfpga_get_base_addr("altr,sys-mgr",
>   					    &socfpga_sysmgr_base);
>   		if (ret)
> diff --git a/arch/arm/mach-socfpga/spl_s10.c b/arch/arm/mach-socfpga/spl_s10.c
> index ce1d5d4c8ff..b05bec2cbc1 100644
> --- a/arch/arm/mach-socfpga/spl_s10.c
> +++ b/arch/arm/mach-socfpga/spl_s10.c
> @@ -48,6 +48,7 @@ void board_init_f(ulong dummy)
>   	if (ret)
>   		hang();
>   
> +	socfpga_get_sys_mgr_addr();
>   	socfpga_get_managers_addr();
>   
>   	/* Ensure watchdog is paused when debugging is happening */
> diff --git a/board/altera/stratix10-socdk/Makefile b/board/altera/stratix10-socdk/Makefile
> new file mode 100644
> index 00000000000..416c121406a
> --- /dev/null
> +++ b/board/altera/stratix10-socdk/Makefile
> @@ -0,0 +1,7 @@
> +#
> +# Copyright (C) 2026 Altera Corporation <www.altera.com>
> +#
> +# SPDX-License-Identifier:	GPL-2.0


SPDX-License-Identifier appears on line 4, not line 1


Best regards,

Tien Fong

