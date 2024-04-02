Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13DF8CD1284
	for <u-boot@archiver.kernel.org>; Tue,  2 Apr 2024 15:02:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5059F88103;
	Tue,  2 Apr 2024 17:02:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="Yeyhdr3C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FB64880FE; Tue,  2 Apr 2024 17:02:49 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F69A880FE
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 17:02:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j/BnQ7IHhedJl8cSDbWn78DUo2HqDDGmPR2jhiWLhHWuY2LT5TPe5NYMeW5L4YUEpnkhpA3VF+J2lUqSIVy+o09VcMd8I2dXoLZ1/qEV3z7GyoqqiIMUpkCtT1E0tJbFgHlkoUJsdFxalgvPrRRZAJE2RvWZ8TqX4tT1rDky/+9D8UzIhhXsRvMd7XAV2LDBtLHOJmzX1RCtr79PO6ghYmaXyiHfU7WP8K59awsqB9V8ykJLq3y1ENrLW5Tb8yn8mOa33Mw8FPXd/joclkiVmLkQvI6EF9OMdAqyeUil3Phuzrh7H4ZGsCEvZ14523jbCuKrBsOpw7g4GXB9CGrB+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iYDTXez6pnas6CdfmaHuj9K6NMbhUFpgwTqrIwH/KNI=;
 b=HU0l4qLa2wXmH1EzYlXhF+xTt1ubAtdSVgs3zpib+nGDcLURTKtPVVus7VgrA5zqDCjxR7ukffSuFU3AwyhviE+AELPANjA73/FloMTXrjsYjq8yghYsZm3SCdCj9aw+424TtaSIRIC+Y+DDE2e7zxwfnF45qv4P0BrW/Bj/5AOQ5EKGNkQLKAPeBQoC9pmDBrhwfCDSwtP2IlyZZ7Xpw4X8SdRs5SNIqoMetFg58UQE4UWAKcoDouEm4E57Wo0CRYpSfKJ7ghL0KaWzrrOlVzqs5AL2+NXomArx/iZIw91SSgJ9seor3NRayoM8t5j2bTW+3pSpevRPvI2xElo4Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iYDTXez6pnas6CdfmaHuj9K6NMbhUFpgwTqrIwH/KNI=;
 b=Yeyhdr3CXle8o2PJ3iisRw1WBUD7IBN80c/9EEXSBkYznxOTU3cx4luOw85aynyGZ0JTsmbR5gEy88n91wZ90UyJlYyp6HezSXnitnHVNaeBIf/5ejInAWYGtBdgBBdO+wPVDjG5zVel6tIPMU7pLcif9JlMqE/cnSGWTkhqLuKchM6VcXY9L/+o5/GD0tqJlzsiOtTS3CZz4vNvBTjiOyeFH+JWpFFovOOJFMrZgomkCItA2q/G4k2vt3DFnB0bLq9HzX7P8n5F1rE2uTutbJr46bJQuYw+fU8VLldypy7Dk1PnjVKTeuR8tUbr2zpXzinY5TpJqdkmjDZb/ZS1Mg==
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by PAXPR04MB8512.eurprd04.prod.outlook.com (2603:10a6:102:213::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 15:02:43 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::3e70:7029:faf2:7779]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::3e70:7029:faf2:7779%3]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 15:02:43 +0000
Message-ID: <e146aa22-425a-4aaa-9a64-772ec00d5d7f@theobroma-systems.com>
Date: Tue, 2 Apr 2024 17:02:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/31] rockchip: rk3399: Sync soc device tree from linux
 v6.8
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>, Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
References: <20240331202921.262323-1-jonas@kwiboo.se>
 <20240331202921.262323-16-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20240331202921.262323-16-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0003.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:1::6)
 To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|PAXPR04MB8512:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S0k/Tkdw0TALlDxGE8BkjC1yzQNjsPo5XiTCTwmAjr46AQRZTu/BrjQya8oCOmYk9ZOLunWPM2LmxL8STkcpngF2KAyNw7BfGZpZI+fbDzaVKBF2Ehgvt2LZZhvI/6m+gXrvMbbDvFH+VKzG6Lyr5IjW+SgHSBZmWv8JdOW5G13GXPU/xitbfRrr0L2bdIRGqhgv7xCA7aZCpUeNo85Cuq+OYo0ssauxZpcSn7aF7VhgaESyWm8gJKBo/ope3KhsBM8EFMkjJadr3RcLRFd8lj4Oo/HeNgiMlVy5tS0RoSx7yZtz/RMyBJq2HTB2xLHxJhO+leyViHe9gzi+xlBsdP/sk/ISXnClgmOeWde5LKBQ1EauvxjL2PZ4Wn0+MjOtVq6rOFtzy3vx6ZCG6v/QW6tqNq7p5z4LIudxeASszwVlmzN2/+6rd0pDEhBlUhkALLuehphr/JE3SPzd/w7ZvJ1Y8whih3AojbVT9dWI2UR8a4bSn5fPXQUuJsG5ZJfcvGGzFFRr0AFNOWYD/tXKs4HVCoyFAmxCHjmSh7lHKvhIIt81f0rrn3okSiywT2W9AUiVFTJJXyDu7EWP4bzyIYlxkVTLo354lgHMtj/gvwBj4llJ00elTSGuODCkw1TUnPIRoDAYgbocTKQyNDS5DpPTJsdh1Q5dC1VS1lVYM5A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDRzendrUEVJS1hieVY5ZmhwaWx2b2dsQUlxNVNXR0xqMGM3NDNUR09vdnpK?=
 =?utf-8?B?UzdqNHIxTU9PdS80dTRkaUREL3FkWnZrTzZQbWdMZGFtVmZIbVNQVUh0VXRs?=
 =?utf-8?B?YlRyWmY5eStjNFdMVDl0OElUbk56WHVPeUtONTVobFgrQXpJVGFGbWNwM3ph?=
 =?utf-8?B?OGI2VkxBOVdpNDY3cnVGdC9ITTRPQ2VkWlRnWTRKRit1YU1UV3N4TzFiUVRn?=
 =?utf-8?B?MFYzUHYxbFhsTSs5WUpLY0dMbC9UQnd6YXB6OFFYeE5uUWVtUzNQR3hYWW1G?=
 =?utf-8?B?emtMTE1ScmJHNUs0SmFuOTVXWnZxUjc0aXNvYU1lcDQ0VGtJam5Qd2pCWmJt?=
 =?utf-8?B?dGRkalFkWGIxdEVrNFVCdFIxeE41OERRMmxGaE1FQ1dsTWdGKy9HUUh2Mmpr?=
 =?utf-8?B?MTVsYWZCVVZTYXNCQnF5RmVBMHJDL05ySjgyN21VV0s1Wm1aZHQvNzg0cUVz?=
 =?utf-8?B?akZkYjBtdzVQQ1lyR0JkLzBCQjJIMEZ4N0tka0E5Z1lQNkNYUWhSSmloNk5X?=
 =?utf-8?B?YmZWOVZCNWM3dEY2ZDczb0NhMzlPU0c2Qy85M3ZxTU9GK3ZGSm8rVDVmZ1RZ?=
 =?utf-8?B?WWhoZDVYc3A1OGd1Nm9HL3hIVGY5YmNzZ0xvVzlySkRYR1RjdnpYUk56eGRn?=
 =?utf-8?B?WGFNeDV0U25WMjlzK2t4MnRIUEh3U3J4U3hPR2RraHVLaUk2MGJtRCtpRkp3?=
 =?utf-8?B?bkdOWTdxVHlFUkFNY2hjeFIvZ0VIVVA4Sm9LRmZzR2hPck5nTW5xa0pHOERr?=
 =?utf-8?B?a1dYVjB3eTRWS3Eyakx2UmNpdnM0ZWZNZm50M1lLdUtpZVFYRXlrVmlkQmw1?=
 =?utf-8?B?QUFVSVQwSGdhYzh1dWVIWXZCdXNXS3BsNmZ2QXBsRmNKSzkxeUMrNFpUczZW?=
 =?utf-8?B?NGdVN2R5Sk1jVFFOT0FuZmtZUm15d29ObnQ5enhlanl0Y1hLTHFVR2JXUmRN?=
 =?utf-8?B?NlhhU3VBbHhGZ3l3SU82Y1E0cFRrQys3RkRELzQyTlI4RmxXaUZlcWNHaE1O?=
 =?utf-8?B?Y3VBQnE0cXRPVnRXamZHQ1RkSTZPL0tpa0gwVjBGMDNmdGdteS83eVJSc0pj?=
 =?utf-8?B?aUYyYk9SYjdMSm9aOTBxdXhEdWZYUkpwWGlyWThoazlGL3B5VVNDQStLT0VF?=
 =?utf-8?B?dG8vdGZseFo4ZzM5WUV0OFRsVlFDWHNRNHNNK0t5MW1PS0hTSGVQN01nMldX?=
 =?utf-8?B?ZGFacFpYMWlqQnBlQTRVYTFMUzFlcjFYMXJLKzU2Z0lIU0EyR2g1NnhScW90?=
 =?utf-8?B?YVZmaGhPeVNwRHNRN05EbzU4ZzVGeFUzYkd6Vkt2bFc4Z2NDZVU1c0ZvVGJD?=
 =?utf-8?B?ek1janBBTXdnM1R6bjJqK0pLSHdXNXEvRDN1V3pNUDZCRSszdGo3aW1FaGlK?=
 =?utf-8?B?cU1PaS9ETys4QXpNWlhmUHhrZGZ3OG9tN1pzV3Rob01IcFRlNTkrT3NhNC9w?=
 =?utf-8?B?WnZrbm9sOW80QU1aeDFsV1VwdGFDQUVoL3h4bFlQNjB0QThla2RJNWRyeHdU?=
 =?utf-8?B?VStPRElxUTJEd2lkclQxaWMzTHFiUDFxTjhHQXNzdlNtbEJZekMvSFk3aEF6?=
 =?utf-8?B?M0l0Z0ZHa2Jnc3FJWVBTVEsrVis0bG5rTzN0Y0pwbkhoY1JFajhGcWM4VTVZ?=
 =?utf-8?B?ZlBRbmQyb3U5bFRVQXNCWndaSHhnZGlYYlRtL2thb043MHR4M3Nrb3A4UDEw?=
 =?utf-8?B?QldQOWlmbUp0U3FaQVhKdXdiUmU0M3NSdWlMQ1ZyajBQUEpSeHcrMWRqdVkz?=
 =?utf-8?B?NzZBR2x1cnZoQmpwRWlWWjVHaGhZcTczcUpLalB6bzhudGVWakdGNHUxZkdB?=
 =?utf-8?B?TThDUFlobGhJaDZpUXlTbm54T04yTWlDbzNMaUlTbXlVWkk4YWo0YjQzQ3N0?=
 =?utf-8?B?RGt2WkpvNHZrWlRyM2FiN3ZsSXdkc2dLZ291Y21PNnlVNHAxb1JTK0o0V29U?=
 =?utf-8?B?WXRUMkFWcHdoN2JIeEtJUkRzSUVyTVhSa1NJZVBnSWgzdGJYRWNMUEtNRWd6?=
 =?utf-8?B?bk1zREw2UWVkSGpIc0pTMVNlcXdaU2xIcXhtVTNqU0IyNENYUm1ld1BBb2Vt?=
 =?utf-8?B?aTFKTG5iSWFkbUwrRGdOVUorYUduMysza1VzeHc1UmR6bksvOEhuZEJtSVh2?=
 =?utf-8?B?S1FMMnUyODgyTjMxTzlGbTBOUGRaV3NqUkJUYmQ3N2h1RXdYZUxOMm5MTGsx?=
 =?utf-8?Q?58qKCSpG7at0VBUgl31u6uE=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37dac1a7-746f-485d-bb62-08dc5325f30a
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 15:02:43.7696 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gViemEwKXJxaR0nWFfCk7qD7vMUlfNlT20iKmYJeTZBGPJ9sIhk0zopzzFn0Ow1YJ2dyDmqlnG2D8DSmCObrSoZMPCfkp9OATFphG9eJR+vdMJiBw2ASjyWV5XCj45oZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8512
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

On 3/31/24 22:28, Jonas Karlman wrote:
> Sync RK3399 SoC common .dtsi-files from linux v6.8.
> 
> The ethernet0 alias is removed from rk3399.dtsi in this patch, it will
> be restored in board specific .dts-files. There is no other intended

Please add ethernet0 alias to rk3399-u-boot.dtsi and remove it in the 
patch that moves it to board-specific dts files so that this is not a 
breaking change and we can bisect through this patch if we need to :)

> change with this patch.
> 

Could you please mention that rng node is named crypto1 in Linux DT? The 
diff here was a bit surprising since rng node is entirely removed.

> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>   arch/arm/dts/rk3399-op1-opp.dtsi              |  31 +-
>   arch/arm/dts/rk3399-opp.dtsi                  |   6 +-
>   arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi |   4 -
>   arch/arm/dts/rk3399-u-boot.dtsi               |  52 ++--
>   arch/arm/dts/rk3399.dtsi                      | 289 ++++++++++++++++--
>   5 files changed, 308 insertions(+), 74 deletions(-)
> 
> diff --git a/arch/arm/dts/rk3399-op1-opp.dtsi b/arch/arm/dts/rk3399-op1-opp.dtsi
> index 69cc9b05baa5..783120e9cebe 100644
> --- a/arch/arm/dts/rk3399-op1-opp.dtsi
> +++ b/arch/arm/dts/rk3399-op1-opp.dtsi
> @@ -4,7 +4,7 @@
>    */
>   
>   / {
> -	cluster0_opp: opp-table0 {
> +	cluster0_opp: opp-table-0 {
>   		compatible = "operating-points-v2";
>   		opp-shared;
>   
> @@ -39,7 +39,7 @@
>   		};
>   	};
>   
> -	cluster1_opp: opp-table1 {
> +	cluster1_opp: opp-table-1 {
>   		compatible = "operating-points-v2";
>   		opp-shared;
>   
> @@ -82,7 +82,7 @@
>   		};
>   	};
>   
> -	gpu_opp_table: opp-table2 {
> +	gpu_opp_table: opp-table-2 {
>   		compatible = "operating-points-v2";
>   
>   		opp00 {
> @@ -110,6 +110,27 @@
>   			opp-microvolt = <1075000>;
>   		};
>   	};
> +
> +	dmc_opp_table: opp-table-3 {
> +		compatible = "operating-points-v2";
> +
> +		opp00 {
> +			opp-hz = /bits/ 64 <400000000>;
> +			opp-microvolt = <900000>;
> +		};
> +		opp01 {
> +			opp-hz = /bits/ 64 <666000000>;
> +			opp-microvolt = <900000>;
> +		};
> +		opp02 {
> +			opp-hz = /bits/ 64 <800000000>;
> +			opp-microvolt = <900000>;
> +		};
> +		opp03 {
> +			opp-hz = /bits/ 64 <928000000>;
> +			opp-microvolt = <925000>;
> +		};
> +	};
>   };
>   
>   &cpu_l0 {
> @@ -136,6 +157,10 @@
>   	operating-points-v2 = <&cluster1_opp>;
>   };
>   
> +&dmc {
> +	operating-points-v2 = <&dmc_opp_table>;
> +};
> +
>   &gpu {
>   	operating-points-v2 = <&gpu_opp_table>;
>   };
> diff --git a/arch/arm/dts/rk3399-opp.dtsi b/arch/arm/dts/rk3399-opp.dtsi
> index da41cd81ebb7..fee5e7111279 100644
> --- a/arch/arm/dts/rk3399-opp.dtsi
> +++ b/arch/arm/dts/rk3399-opp.dtsi
> @@ -4,7 +4,7 @@
>    */
>   
>   / {
> -	cluster0_opp: opp-table0 {
> +	cluster0_opp: opp-table-0 {
>   		compatible = "operating-points-v2";
>   		opp-shared;
>   
> @@ -35,7 +35,7 @@
>   		};
>   	};
>   
> -	cluster1_opp: opp-table1 {
> +	cluster1_opp: opp-table-1 {
>   		compatible = "operating-points-v2";
>   		opp-shared;
>   
> @@ -74,7 +74,7 @@
>   		};
>   	};
>   
> -	gpu_opp_table: opp-table2 {
> +	gpu_opp_table: opp-table-2 {
>   		compatible = "operating-points-v2";
>   
>   		opp00 {
> diff --git a/arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi b/arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi
> index b8f95b86d86b..dcfcec4f3072 100644
> --- a/arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi
> @@ -6,10 +6,6 @@
>   #include "rk3399-u-boot.dtsi"
>   #include "rk3399-sdram-lpddr4-100.dtsi"
>   
> -&rng {
> -	status = "okay";
> -};
> -
>   &sdhci {
>   	max-frequency = <25000000>;
>   };
> diff --git a/arch/arm/dts/rk3399-u-boot.dtsi b/arch/arm/dts/rk3399-u-boot.dtsi
> index adb64d17e040..d2648abd0a44 100644
> --- a/arch/arm/dts/rk3399-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-u-boot.dtsi
> @@ -2,8 +2,6 @@
>   /*
>    * Copyright (C) 2019 Jagan Teki <jagan@amarulasolutions.com>
>    */
> -#define USB_CLASS_HUB			9
> -
>   #include "rockchip-u-boot.dtsi"
>   
>   / {
> @@ -24,44 +22,11 @@
>   		reg = <0x0 0xff620000 0x0 0x100>;
>   	};
>   
> -	dfi: dfi@ff630000 {
> -		bootph-all;
> -		reg = <0x00 0xff630000 0x00 0x4000>;
> -		compatible = "rockchip,rk3399-dfi";
> -		rockchip,pmu = <&pmugrf>;
> -		clocks = <&cru PCLK_DDR_MON>;
> -		clock-names = "pclk_ddr_mon";
> -	};
> -
> -	rng: rng@ff8b8000 {
> -		compatible = "rockchip,rk3399-crypto";
> -		reg = <0x0 0xff8b8000 0x0 0x1000>;
> -		status = "okay";
> -	};
> -
> -	dmc: dmc {
> -		bootph-all;
> -		compatible = "rockchip,rk3399-dmc";
> -		devfreq-events = <&dfi>;
> -		interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH 0>;
> -		clocks = <&cru SCLK_DDRC>;
> -		clock-names = "dmc_clk";
> -		reg = <0x0 0xffa80000 0x0 0x0800
> -		       0x0 0xffa80800 0x0 0x1800
> -		       0x0 0xffa82000 0x0 0x2000
> -		       0x0 0xffa84000 0x0 0x1000
> -		       0x0 0xffa88000 0x0 0x0800
> -		       0x0 0xffa88800 0x0 0x1800
> -		       0x0 0xffa8a000 0x0 0x2000
> -		       0x0 0xffa8c000 0x0 0x1000>;
> -	};
> -
>   	pmusgrf: syscon@ff330000 {
>   		bootph-all;

I have my doubts the PMU SGRF is accessible from U-Boot proper if TF-A 
loads it into normal world. Maybe this should rather be 
bootph-pre-sram+bootph-pre-ram?

Nothing to fix in this series though.

>   		compatible = "rockchip,rk3399-pmusgrf", "syscon";
>   		reg = <0x0 0xff330000 0x0 0xe3d4>;
>   	};
> -
>   };
>   
>   #if defined(CONFIG_ROCKCHIP_SPI_IMAGE) && defined(CONFIG_HAS_ROM)
> @@ -93,6 +58,19 @@
>   	bootph-all;
>   };
>   
> +&dmc {
> +	bootph-all;
> +	reg = <0x0 0xffa80000 0x0 0x0800
> +	       0x0 0xffa80800 0x0 0x1800
> +	       0x0 0xffa82000 0x0 0x2000
> +	       0x0 0xffa84000 0x0 0x1000
> +	       0x0 0xffa88000 0x0 0x0800
> +	       0x0 0xffa88800 0x0 0x1800
> +	       0x0 0xffa8a000 0x0 0x2000
> +	       0x0 0xffa8c000 0x0 0x1000>;
> +	status = "okay";
> +};
> +

Missing bootph-all for dfi?

[...]

Cheers,
Quentin
