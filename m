Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB209F55805
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 05:38:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7069083E36;
	Tue, 21 Apr 2026 07:38:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="XSODdQSH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5450983FFA; Tue, 21 Apr 2026 07:38:18 +0200 (CEST)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E654B83C51
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 07:38:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BJ6PD3YqobjQBda8QzdqkqYa3tBWFGSuAmLciW6ZCZU/mqu0sPQRwdWoEciiYkWZnBIp8H+h+Cb+4li5mMCuPABhXs/C47HhWK/MSXYe1Qp37p6pqkzz1911qfmGvQoj65Gkx+mDDYZxMLHy8ZfTEXqQpscQRW1niZX47GmJC4v7r121rjoZ6QEiwxGUP+BgqDbDnTDnQCoUJ4DTiqp0IotTlMA1UmLLvmhndh+6bgvGRf1r8umxZrnyMZ/ECkVKm9anvL0N2PVS+GcIYSLzgGW+uupN1JFXHJasSzLsmQnkT3WSVKe5EgTlVvt1dwS+WN99J7iT6sOWWY7g/UepWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wkz/R4ELRgaBggvVb3Ckyn8pzlNsoqqilLigwmEOxHw=;
 b=cE5k9YKh3UEq54OIH1/N++48S0wot5SZlB7mMExSs9yu/trK8RsFUkSpqnjq4BlFYXtS5McUOOiAVoq2XaXjLe/4pBUV2uo3guB7pZFS3nrtbKXeYayKoPO/mYRqEAuCDgVu0NMIsb3Ja0lgQDVFzAA6y3McZaBNWWWUzg2nxyl9c8GLwKJgEQIZIUyCvDB6G2xYjWiDCNakRCdYcY2YWJdY0V2qSUNK/DMphImJWRFnQc9V2ctjucO2v3cb3Ipw9nkO/oZyuNOuXyVcoBZq5ktr0/uffqAgUJb1IkDHu4qAQcOiTs40afOHPw4tpsEhETMAJdoc8EFJ4oiES5J0sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wkz/R4ELRgaBggvVb3Ckyn8pzlNsoqqilLigwmEOxHw=;
 b=XSODdQSHqyohHwXaQThD65JczWRsRUVSf/kg28iukErlCVxN0ahLgYLpi3hQdVqqfPPYvSfDfj1eO4TQ7/6HkgmAaEOoYHKFQcjeIdSc3iSmGiPN5UcC/uCOwDAAvuCp5jL0VxF3/eUuqOBZppv+SGNnZcr5xRDUU04DMSslj++ZhJ9mnbTTEDvYTWFlqomu7Qs5lbfOcDnVg/1yxB/aCuTo6ZiFIF/P20XN4Pf3nPLeTgE1HVapo7QQRzl/NaSSX6cnGpTJcBQEuq76iRS3zTAMvBZKeHW0MDBCtFNSSvVOI2F2Wv+zgg7RZySfsG8UhUGAtDfNovgMxxZd1TN+sA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by DM4PR03MB6143.namprd03.prod.outlook.com (2603:10b6:5:396::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 05:38:00 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235%6]) with mapi id 15.20.9818.032; Tue, 21 Apr 2026
 05:37:59 +0000
Message-ID: <4c6f0a8a-1cdd-4321-a2cc-e6c27736d3e3@altera.com>
Date: Tue, 21 Apr 2026 13:37:52 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/9] arch: arm: dts: stratix10: Switch to using
 upstream Linux DT config
To: alif.zakuan.yuslaimi@altera.com, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
References: <20260403022513.9446-1-alif.zakuan.yuslaimi@altera.com>
 <20260403022513.9446-2-alif.zakuan.yuslaimi@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20260403022513.9446-2-alif.zakuan.yuslaimi@altera.com>
X-ClientProxiedBy: SI1PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::15) To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|DM4PR03MB6143:EE_
X-MS-Office365-Filtering-Correlation-Id: be8e05db-3ff3-438f-56ad-08de9f68260d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|8096899003|55112099003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: iixoxG2WxUjjzTyshqS8I2i+tASMZD1S8zu6a9Y97K+33wEtun7w5wyqNkgrIbtGM2r96v9d7MGIdVjljowunTYoHxt0QYTi7wTn+OLcXwJYm3/OvQsVPSDQal+rMe67yoEE4wc9HrubcVx8241MiGXhrNfjY6DimJSvYSBO+AxMDTI8rCLgh0c41JGHAZ9LvqEvOMVKNzQ7Tmg+aIBxkGfuxSXUiimErTh5hlpQd+JrwujeQeAjR7w+rROlM2nNVjL/0CWhsKdg6gcVDp66a5v8SOH3wvg3h2ClBz7DfXqi54EIBI+GNrVetOZooTk4gH4bTnRm8qvH0B+kV+BQI7G3u0ELoUU1qrjBlyszGBnNTYiGbhB+IUJcLu15ZTNyw59I8+kfiISLwcodKDRXekqwybIoXDB7cQY+PMByZ8dYJfVSolBscSchjMTbAMh8KCtAbRPTobHZp7yJq9Ti+LBg/Igdunqwf905x0A2YrKl/nv+sdUKFCRXSQzpF3Rsi+vWiUt8JtURH5L96zd5SIdAW5eLinYW/6y6zr8QXNP6tXsq3dYLIFO1zGUkz56FMWzpe0Phk9oMUA4+cSeqASIVbHLyEOdVO17B634qwBHoGcM9XXy1yuEi2Ku0+Vhkn5TcRASU12YMFH/+/BIDl0t8RK/VMRfh0E+pJ82F1CkV2S6QFTQY5OIdbH00il7pyqBzAqIVGNIXO4mPt9yQPUiMk8UE2AaCkZ4dijPXm1o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(8096899003)(55112099003)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFIxK1dUSmVDb2IzK1RHVUJKN2J1WURxVEh0V0tlUEZDS2pNVnFDSXl3cUxh?=
 =?utf-8?B?RmtKUWI3dGh5OUp2RndMU053NkY1eElVZWR1bVVBYXlaakREdXRYV2Z0enlL?=
 =?utf-8?B?ZlpxWGp2QmdXamJjQzZjbVp1dmpUV1ZXNmZFaTlkWHY4OWVnRXAreUQ1Skg5?=
 =?utf-8?B?MFd1L1lmeHlobHFNTnk0cXV1MUtwU2NUNVlMM3VSMWxHWXZNMHNoeHlYZDVF?=
 =?utf-8?B?dG9sWkNEeGJuWWUrVWVNQ2VLcktrUXR5NzVGNVFYMm90THNod2xJSHV3Unp4?=
 =?utf-8?B?K3pXbXZUQU9wc3U0TTVhTUNkUXZLczUyMnBWZVdGRUZ5MGFqVVhtU2dkQXlL?=
 =?utf-8?B?YXEyQUNDcUU2ZTF4TkJJMVNkc3hkTHJNZFlMRlRUbDVXZG15Y3liVTdsREhN?=
 =?utf-8?B?K1ppY3FoZyt4aHlzd2VpN0d6ZmQxcFltb1kwaDI4K0dTVWdyU2gwb0tBKzli?=
 =?utf-8?B?WXczM0E0SFFzT2tWcktiazRTcmczamtvV0lFcm4wVG5mODJNL3pwWVhLM0pv?=
 =?utf-8?B?clNVRHdrMjcwTURqdC9ZYTNEV253UGhDQm8wTXVjUGd1bjZkbE5XRVBwbmk2?=
 =?utf-8?B?WXE2TEp6Tm5qQzgvZ3c2NnpHOG9Zb0lvYm1xcTNZRVhnTlVZaTB6K3hmTm1S?=
 =?utf-8?B?ajZIVFpOeXdrc0R3cW5jRWxneEExcFZaNzdsTkpLK3RNNnFFUE1VQi9EMi9T?=
 =?utf-8?B?RVI3NFhTbHdEQmNXaytJTk5xY0ZlN3RoWUlteHl4ZForY0xoQklxbkxnTUEw?=
 =?utf-8?B?b0pCVEpJdVc0MVZBRlBteWR3TmhiNVEwY3R5Mkx6RVB4aytWMEhWZy9YdU1k?=
 =?utf-8?B?M1U5bG5iRHFtQkZUUkpMN3I3Y1daeGd3YnJNNkRtbnFoRHNUUWVvWTEvT0d1?=
 =?utf-8?B?SUNCS0NFVGRERms4a3JYendxNW1GbzZHMEFzL0RlNG1qV0dWV2FTVXJ6ZERM?=
 =?utf-8?B?QmtqZ05Fc1hQcGdQQWZjSXRkRkhkUnZBTGttLzY5ZmpBcG9yVXR3ck1XWlBn?=
 =?utf-8?B?N2lleVNaV3dWVTdMdGNqbUNuSGJwbnl6SmtTQXE5enpVSEc4VjVTM25DNlVY?=
 =?utf-8?B?Y3JDUDljU09OdW9WTjlOODRrcEdHbkpoVkNyZm90OSszSDZRR1ZoUUJwejhI?=
 =?utf-8?B?ZnVQTStkZWpaSi84bHJZR2RjWjYzTUpJR2NDczF4S1FSa1pYaDlpclI2Q3RS?=
 =?utf-8?B?cERiOTc0NTZ2L2pZYlBBcVlmeU9jZ0NKZ1hmV015VGVvNTdnRFRNazFmcndw?=
 =?utf-8?B?WXoxejNldzZLNHJkbDhSdXFSZ2dvUkNUbjdrbWVQVDNjTm14d082U1lkbit4?=
 =?utf-8?B?UHNqWWJpcXdHYUFKRzRGd25qWlhvZ09VZDVENm0zWGNDd2VpQ3U4SU1XRFlm?=
 =?utf-8?B?Z2tkVzJSaGdmcUtpU3VDU3p3amxueDVrOFNzYTV3c2NQc21oaDFCQUxDTVBq?=
 =?utf-8?B?bzFRUVZqaHVNbHNwREpFcUFUdUxCc3pWWTlGMjdaNGNDK204L1NyeFJxdGFm?=
 =?utf-8?B?SXpJZnpiaFU2Z09wdFhXWmc3UjEzN1htdERSbXR1eXlRMTFYOVMzNFpFTEF4?=
 =?utf-8?B?U3JrNHRLak5IQVNOQk5UZUtaVWZKaVl4bVgzdUZXTEo5R3BHUERsUmtlUVhh?=
 =?utf-8?B?anVaTU93QzV1WW1aUUdaeXZjMm1PVnVpNS93TTJmaExsSktHNjRzcmJxR3dN?=
 =?utf-8?B?Titxd3lrZXdSTTI1b0tMWXlnYlpZTjIyY2RGRzJQbTd0SjdjZmgyTTBSSkZi?=
 =?utf-8?B?UC9rK0EvVkE0QTY1bWFhTDZnRzNoOTAycHljMjk3R0NoZjdua2xuVGRINjZN?=
 =?utf-8?B?WmFzdEhWS1RwdCt6d25MYURoVmFQeEgrdWZiN28wbmFYM0RUamNMekpwTHYx?=
 =?utf-8?B?NFNtcUtTRkcvK25LTkM3ckhhdUNhZGtZYU16MmFrc3FWeGVhZnhLOVFuemR5?=
 =?utf-8?B?aGk5bkNuSVd6SWFockJmWko5a1hpcXhOZGFQcTVhak9BbVhwVkR3RHJyZzUx?=
 =?utf-8?B?NlkyL3d4ZkRJK3VLTVdtR1NDMGp1eURER2xBZmxnNDdtVUF5ZnlQT2hvODFX?=
 =?utf-8?B?QUUxaS9ENE5BajVzazJQcXJJbk8zZ29rbXNib3diRW1NV3Qyd0hES3hsOXh4?=
 =?utf-8?B?aTZYV2pRMUs2ZnRCMmU3dWFRY01YR25MRk9UdWZja0o3RkVjTnBlNHF6cThq?=
 =?utf-8?B?QnpldG9FR2VSRG1rUm5ObStDbVJidytJTWtmRUVGbnVxbEZJRFZPcXVFb1ls?=
 =?utf-8?B?djRvZE5OU3M5VEExMW5VSUFjQklXRUdXelFKWEFrU2syUFVEalVFM3dtY1Ro?=
 =?utf-8?B?azYxbzc5ZGRqNFBxM1ArczFCaXNPWVJ2VU51VnExK251cUN4WmlOY3ZSV3dO?=
 =?utf-8?Q?405HJJNwQRAgqPfc=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be8e05db-3ff3-438f-56ad-08de9f68260d
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 05:37:59.9059 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6VsKceYQThFN2kkPnxhPXYepwiIcG137uYqFKSfWRbP6tAB2NmQyiifE5LGAR8ToLPpGdGeWSAnLj6qTsAhE4itOHRnp4nUAe7wVUlUyNms=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB6143
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Alif

On 3/4/2026 10:25 am, alif.zakuan.yuslaimi@altera.com wrote:
> From: Alif Zakuan Yuslaimi<alif.zakuan.yuslaimi@altera.com>
>
> Migrate the legacy Stratix10 platform to use the upstream Linux device tree
> configuration. This helps reduce maintenance overhead and aligns U-Boot
> with the Linux kernel's DTS hierarchy and naming conventions.
>
> This change improves consistency between U-Boot and Linux by removing
> custom/legacy DTS handling and instead relying on the standardized
> definitions provided by the upstream Linux DTS.
>
> Signed-off-by: Alif Zakuan Yuslaimi<alif.zakuan.yuslaimi@altera.com>
>
> # Conflicts:
> #	configs/socfpga_stratix10_defconfig


This is a git merge artifact and must be removed before upstream submission

[...]


>   &flash0 {
> -	compatible = "jedec,spi-nor";
> -	spi-max-frequency = <100000000>;
> +	reg = <0>;
>   	spi-tx-bus-width = <4>;
>   	spi-rx-bus-width = <4>;
> +	spi-max-frequency = <50000000>;
>   	bootph-all;
> +
> +	m25p,fast-read;
> +	cdns,page-size = <256>;
> +	cdns,block-size = <16>;
> +	cdns,read-delay = <1>;
> +	cdns,tshsl-ns = <50>;
> +	cdns,tsd2d-ns = <50>;
> +	cdns,tchsh-ns = <4>;
> +	cdns,tslch-ns = <4>;
> +	/delete-property/ cdns,read-delay;


Self-cancelling cdns,read-delay = <1> followed immediately by 
/delete-property/ cdns,read-delay

Keep one or the other depending on whether the upstream DTS already sets 
this property.


Best regards,

Tien Fong
