Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31D14CD4840
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 12:33:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB56D8341A;
	Mon, 11 May 2026 14:33:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="lOhTKQnw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 513DF838BB; Mon, 11 May 2026 14:33:09 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A04381E18
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 14:33:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ivL73e3m6lJKW2Zrs0qBA3jDu9VPC3cjdVNM2dns3xiw8W1GQreoMjqo1gf8yuE5zYfltSC4vumrhJHSiThAvudhLxMnX1+jfH6dlDjkRJAa5rDwAzLyxNUBZjj6/hAdaoM18ks00Q2wlazekLqXVLzMhvggUbebIHrkBMlEiE8V8NSianmksURNWpNy4l5Wt1QrWJpsuDPrrxp+dGPkg4CSUjR/RYjGBptMsxO7Uiq8Osg3N6oclygHIzX351Jp2KNRGMgkHYAhu7vfa2olszaZYnZ9cwkeH9YrvQ+44LycdofrLTpmVNfcxbOzIoIOhr+Guq8WIWsCIGx3B8J9rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fSCQj7oENtJXePza2h/nMFYKHdCffMnl1rThJhYSl8A=;
 b=IYyoJaQlffWwj/vyBGtAhR4sAIXaSa6xNU6fEFz5vai/zV3xSMb0RJUyNeaYKcXraWbU+ghnDdyEt1SqCGuhiktPutSflhSP6LNjY1SZQL0Ioou/P74DBwMt7TZzkzGb97DSKltQlCykLiS0Wp0+ITCr1EOaZqCwBD7ftoz+vYSGIQTCdtBZB1T1ZXxgItJqVZwTZ61PW3ayXnkXcHiSDI4CfaJ8GoaVAHd+/NDOpm3BqYc2lJtqvnlPHy1CH+mwEBKm1+/0ze9Ob+0qyE/x1F59GvihQZvKnD+3/McWFR3f+jndSYn7e2CYlP6Qxi9UQ0dlnZP7NtC1khRA5b2JOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fSCQj7oENtJXePza2h/nMFYKHdCffMnl1rThJhYSl8A=;
 b=lOhTKQnwhGXhSwK/v0DimNtzCyfkfAbfCaSfD9m7DwC23upgPmoNTcEEtVYXG3nDdARtp4m6tpx63vupai6kLLJs8rAgb1VGI5oW0k/xed6gJrxaASmPS6jFjiUf+ASzc91BrDhNRSNcX31Ffvby1+a0ZGGswCUcJ2wq8XcbOs4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by PA4PR04MB7520.eurprd04.prod.outlook.com (2603:10a6:102:e9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 12:33:03 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%3]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 12:33:03 +0000
Message-ID: <5633d251-07f8-4d12-a531-ae293662efc1@cherry.de>
Date: Mon, 11 May 2026 14:33:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] env: add Kconfig option for static flags list
To: James Hilliard <james.hilliard1@gmail.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Heiko Schocher <hs@nabladev.com>,
 Walter Schweizer <walter.schweizer@siemens.com>,
 Sumit Garg <sumit.garg@kernel.org>,
 Matthias Winker <matthias.winker@de.bosch.com>,
 Philip Oberfichtner <pro@denx.de>, Le Jin <le.jin@siemens.com>,
 Jan Kiszka <jan.kiszka@siemens.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Daniel Golle <daniel@makrotopia.org>,
 Philip Molloy <philip.molloy@analog.com>,
 David Lechner <dlechner@baylibre.com>, Michael Walle <mwalle@kernel.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>, Peng Fan
 <peng.fan@nxp.com>, Adrian Freihofer <adrian.freihofer@siemens.com>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>,
 Benjamin ROBIN <dev@benjarobin.fr>
References: <20260509230147.1308308-1-james.hilliard1@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260509230147.1308308-1-james.hilliard1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI4PEPF00000131.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::8b0) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|PA4PR04MB7520:EE_
X-MS-Office365-Filtering-Correlation-Id: e7430748-5b1f-4bc7-84de-08deaf5971ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|22082099003|56012099003|11063799003|18002099003;
X-Microsoft-Antispam-Message-Info: SiFCD1+fpttHEsoRi05AKNFeA/jCeNkdDHtAAlV1Ujsst/D7mgJevkp0nCPfFrigP5OVK24GsBUz7bw2xX37yDfambwwzHQG1PTOz/bU/S/d6PP9skNU65DKblVOODE2ysx6f9vT+kTQtVp2ofirgsWOIUcuXs/v45JaE0xHrN5zKUULhZl8RnjwjFX86gPLzhGkWH27hCqKhV+/OcRLSeED96lqIDGeG71u+sehLHGIz/h5qChCoZrzHgE5obHaCdNz7h/nYgaairW8uR3Zhn0sf9HmiuKc+a0OiFr3nXApBBY+GnMS4bCye0MyYLcp1ENsb+nWLwGlX+r+wPWB6sBfP7DpDbHkOCHqc52lihoRFgHDr6MZqKnxuBdUEwc1sGXR4D5b4XSkyjTO0vmc4mlM9AWcOXWeXrLGoYQ9LWPoMOxuD0Nh9V5Sh5uEx3OPaWaJZBt6BOiya+crCGxiVu5F6fC/55V6pr0vX7waJwsoeXf88SF3qkGFlGiSush9sGVzGyqTpqJzBHiv7kJFV5Jv9NPhk71zzygnOe22WBaxengT++xP3LRzcHS5OwUScaSwcAoJHPA8MTNpan9DjZ2WMLxtuDZmvu6qA3GkSXMtZlL7cyymonkq5+7/Qt5B7sV2q2LdH4hlEQ+zZ3QwGfsOYxkQAa/BXKb+/+rzjoEgymcUmjRJ3tNC/4UhEQDD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(22082099003)(56012099003)(11063799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXBYSDd1aWV2OVRPRC9uYTBCMjhWK0NIUERIcjZNTzBBbit3Uy8wOHRLWnkv?=
 =?utf-8?B?UXRnQVY3SWpEa1NRSFR2RElJYUdDbHMxMnFpMVV2VUhlcVBpSGhtUGdHaDZy?=
 =?utf-8?B?Z1ZaWkw4SCtoS2VTbTRpRmtVOTZqSUgxbXhoV2Nhck82MUZxQTVxMmdRVTFs?=
 =?utf-8?B?b1dIc2VFMlhGUGVZMk9WOVgyVmNsQ1V2WnFhZzVFMGVjTEZLWVkzS29uR2Ev?=
 =?utf-8?B?L1B0ZmIzb09ZK1Z1czRTVzNDRjVkLzVMNmdTMlZlelp6MW0vSThRemZiSDJz?=
 =?utf-8?B?YThNQTlOWTdtRjc5dktNSURTTGQ3M3g4R1JSdmdJemtTUUExdmh0b25uYStC?=
 =?utf-8?B?eDEyN0htOUhzTW1jandUNDBRc2grUEw5ZWtxVkJmU3N5cnlnMGROTytUOTZJ?=
 =?utf-8?B?TEV5bmI0ZTI0MWdqKzJVNTRheFAvQVc5d09VL3VsanU1MzVTeTdWSTFXNUUx?=
 =?utf-8?B?SmpKQ21NOXRFYms4NzZPM3hLTk5ZT1NoeHovMXhQcXI5a0RvdG5XMWdXRXRP?=
 =?utf-8?B?eHNuRUl4U2RMbVF3VUQ2MjdvbjUvZFB1dWtCdHlPOE1SelNSL2tOMS9ta2lV?=
 =?utf-8?B?TjFOQTlZWHp1bHgzeENkQXR2eXMvVkV3cHdKdkZzeFlrbDZoaHR2aWpLNlZS?=
 =?utf-8?B?VzFJRE1uYVlDbmw5dXNSaGhyT2xFRE1ic0FZcSt4ejJtM2YxaHhzSTVvaTFT?=
 =?utf-8?B?SDk2d0dXRU5URHJpR0FneGxFSFRvZ2cwTU9qSHowTFBtRjlqY1BvVUdHaTdu?=
 =?utf-8?B?STVCU0hYQmg2NDhVY3ZBMWlkWndad1NpaHB6UTd4ejJmWjV4eGhZVTJYZVkr?=
 =?utf-8?B?cm1WR2M2a2lxcC9OcXBWN01jWE84SzFXem9zV3ZWaXdKU0hOZzBCTUZPVFBy?=
 =?utf-8?B?Mlp6REljNi9QMHgwMUNPZms1RFV3OHU5blhLODdnaWtYNjBLcnJHZmdjdzVX?=
 =?utf-8?B?dFI1Z0NTRldhbGEvMzlSdzRUbllsZGMyOWZUakhCY1hTUXhjcFJ0QWt2RWw0?=
 =?utf-8?B?NG5jWmxvYWV0UHFTVkZXSWdtZGdGQnFRd2ZYWDRCcUtkQ3g5bzUrckdKTVRs?=
 =?utf-8?B?Z01vbjRxVGllbDBtY2RpMi9seWtyTVAvcFIyQjBndTJiOGRtNTdwcllmWWpx?=
 =?utf-8?B?b1dmcUkwcGQva0s5RisrbkVpd0ppZGQycEwxa3JHN3ErR0E1cHowNmwvSGNF?=
 =?utf-8?B?ZnJnRU5EcnA0ZXBydU9Zakp3cG9YZkNvRjNDTno5eEE4eUh4SnVJeHFVRW5T?=
 =?utf-8?B?STYvc2ZrSjFpM0dldmpWeHJiclZ3aTdWcFNpQmI1c1NjWlFTYkRtU1lMVTdL?=
 =?utf-8?B?MkMyWVRZSmtLTmpQS01OdDJBenJBTEk3VEt1WG9KU0JpT2xRbG5ScC9PWjhP?=
 =?utf-8?B?V0J6bWNuV2pDSENlRkJmdGNWc01XZXhIbUxXdzlXcXhNRjNEMXhEendOdThR?=
 =?utf-8?B?SFlZSWlxajFxR1lYS3NIeUdLZk93TVFONnpia1FDSXkwbWJwSU1WM0hjT3d3?=
 =?utf-8?B?VlJCZytnVlM4S3RYbzJrRElpSkJVN2dmM0JQL0VCa2lsTzZPZ01mYjRpSjQr?=
 =?utf-8?B?MzdHRXdPWkF1YVhIQmh2aWhhbS90LzVNS2pkT2g0YlhIS1oyQit5b3h6L3ZP?=
 =?utf-8?B?K0l2T0ErT252K0FFMnR5aVJVY0pueVZTSjJUMlRmN3F5K3BJOERCVW4yVHRr?=
 =?utf-8?B?YStwbGNrUVpUcGNDeDZIMGJKQWtKMFNkRjZWb01HK00yOCtIZ1B2ZTBHOWtx?=
 =?utf-8?B?UmpLL2FETkNqM0lVeHVnL3dWTERYVkxkUkdMTlpwcm95d2NUcms5VVBlUW02?=
 =?utf-8?B?YjBRL2dSWFNxNVJlSlM0UzBJaCsxZmdSMnBqME5FN1VjbWxvSUZ6aFVVbkt5?=
 =?utf-8?B?bDh4eElkNTROWGpGRjRJVEtycEk5K3JpbHdPMUU5b3lVMnpCK293bitERmVj?=
 =?utf-8?B?VGFkcDc5bXRReUpSODdkTS9aUG02Z2FIZkE3eWlJQkRjVG9lL3gvZ1kwM1Za?=
 =?utf-8?B?dzQ1dkhhRlpwcVM5eDBXVVNEWnR0NG1jNmVKRmNMd0ZTbDFzSy9BbHhjdXlS?=
 =?utf-8?B?YTBZdXgwWVBSRlAvV09kbDdoL2x5TTlpYXhSWHFYakV0aThiTm1McXg4Ti84?=
 =?utf-8?B?RXlrTjJTNVdZMDdqbTl5dzViMmE5bmZ4YXpmQ0ZWQnFEZkwzZ2QzSVBleDl2?=
 =?utf-8?B?NGhieWEzSGVlblJiTkhET3BQS0dvUGUvZGUxT3JLYjZCTW9JVFlnUWw3KzR3?=
 =?utf-8?B?bHVqL1hUUUlsVVZMYzMvNTZHQ2o1MlZLNkF2VURZK2xidjNJSVZGcktwWU5z?=
 =?utf-8?B?QmZDRCtOMnJsaElqaEs3NmM1VkxxT0x0QVpubXJGd243TXJKZUxDUT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e7430748-5b1f-4bc7-84de-08deaf5971ea
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 12:33:03.2638 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 96FBVphVFr4qBNNOlseYg5HRqIPK8ThDWL4lgqsYikPLpAbIR0F+m/GAFex359g3tOvJHdGhiNB/2e++rU33mkMwu6w4he3ISXqQcB/WXlA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7520
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

Hi James,

On 5/10/26 1:01 AM, James Hilliard wrote:
> Environment callbacks can already be configured from Kconfig with
> CONFIG_ENV_CALLBACK_LIST_STATIC, but static environment flags still
> require board headers to define CFG_ENV_FLAGS_LIST_STATIC.
> 
> Add CONFIG_ENV_FLAGS_LIST_STATIC and append it to ENV_FLAGS_LIST_STATIC
> after the legacy CFG_ENV_FLAGS_LIST_STATIC value. Normalize existing
> CFG_ENV_FLAGS_LIST_STATIC definitions to end with a comma so the Kconfig
> list can be concatenated directly.
> 
> This lets boards configure writeable-list policy and type validation
> from defconfig without adding a config header solely for env flags.
> 
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
>   README                             |  6 ++++++
>   env/Kconfig                        | 13 +++++++++++++
>   include/configs/capricorn-common.h |  2 +-
>   include/configs/hmibsc.h           |  2 +-
>   include/configs/imx6q-bosch-acc.h  |  2 +-
>   include/configs/iot2050.h          |  2 +-
>   include/configs/socrates.h         |  2 +-
>   include/env_flags.h                |  3 ++-
>   8 files changed, 26 insertions(+), 6 deletions(-)
> 
> diff --git a/README b/README
> index 6836a917c79..b963ce23078 100644
> --- a/README
> +++ b/README
> @@ -1107,6 +1107,7 @@ Configuration Settings:
>   		Use buffered writes to flash.
>   
>   - CONFIG_ENV_FLAGS_LIST_DEFAULT
> +- CONFIG_ENV_FLAGS_LIST_STATIC
>   - CFG_ENV_FLAGS_LIST_STATIC

Do we *really* need both? What about migrating CFG_ENV_FLAGS_LIST_STATIC 
into a Kconfig symbol entirely? We've done this to a lot of CFG_ 
constants in the past so it's like there's no precedent.

>   	Enable validation of the values given to environment variables when
>   	calling env set.  Variables can be restricted to only decimal,
> @@ -1133,11 +1134,16 @@ Configuration Settings:
>   		r - Read-only
>   		o - Write-once
>   		c - Change-default
> +		w - Writeable if CONFIG_ENV_WRITEABLE_LIST is enabled
>   
>   	- CONFIG_ENV_FLAGS_LIST_DEFAULT
>   		Define this to a list (string) to define the ".flags"
>   		environment variable in the default or embedded environment.
>   
> +	- CONFIG_ENV_FLAGS_LIST_STATIC
> +		Define this to a list (string) to add to the static flags
> +		list.
> +
>   	- CFG_ENV_FLAGS_LIST_STATIC
>   		Define this to a list (string) to define validation that
>   		should be done if an entry is not found in the ".flags"
> diff --git a/env/Kconfig b/env/Kconfig
> index 7abd82ab6f3..ca8f9aff19e 100644
> --- a/env/Kconfig
> +++ b/env/Kconfig
> @@ -34,6 +34,19 @@ config ENV_CALLBACK_LIST_STATIC
>   	  If the callback name is not specified, then the callback is deleted.
>   	  Spaces are also allowed anywhere in the list.
>   
> +config ENV_FLAGS_LIST_STATIC
> +	string "Static flags list"
> +	default ""
> +	help
> +	  The environment flags are associated with variables in a static
> +	  list. Define this list in the same format as
> +	  CFG_ENV_FLAGS_LIST_STATIC.
> +

I don't want to be looking for where this is explained, can you at the 
very least point at where this information is available or even maybe 
integrate it here?

Cheers,
Quentin
