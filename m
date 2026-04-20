Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39612F55806
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 10:16:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 760D483B99;
	Mon, 20 Apr 2026 12:16:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="VLSRv0lL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B414F83E16; Mon, 20 Apr 2026 12:16:44 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BD1C839D5
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 12:16:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yt2oiZZ7ltb4K00rrSvF5KAaMdNlyDLqvi/e3cD1Q5ucwiKvPTEiDdChtcfOWSaifVANOM+EzyGLJZ8PuLYv5IRlf4Y2zX8cPmPQbDl8NfiBofzo3m4wABcZB+UJ1UVGUZb3TrNxvGViIvHc+jYvhMQcl+7zrHcWmXhaGA7VZTgy6cyb0JzW/U/Bo/212nfnPIv2xjJb6E80ffysNxe+YTfCB8SesBI8I5oqZMMPxPptExGB/79Bf0ydk6FH7rlQ6IIWDNTPP50KMLpK4mnSh/ylpUnzG5omgTCo8hthNBneLadMkLYzBV+VyRU1sh/EgmG2+4OOvBELnSwAojac2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1dl2J7w6NxMgTXq6pBjoN/02jltB/aqECKxEQhaMTn4=;
 b=JNm3b0OU9cKwDUqNBB7j7nGJAgVDRIYOhJXp0KrDwf1H+img38OG1M0EFHgiF+dhy224W4yKvqRZpXlMiWkwg+6AbXWl+KUxMPQHWavhJkHyiaFfl1p4LzQ8sFw/D8HPxJpqMvWigbSpMMuf5img/ORECJWC87Ayptd/cyJtawfJImLQTfkWLDoDH0e12R3O9heSJ7buMLz8upF6j/0fpW4oCTnuLqlQlLnqt0ul9zXAVWSsfG9keJPk1OTFwuU5yCbWO/qIVnUywZJdGEPxn5y5mYqqaW72vVx6aF/ocW49LdEQCNn+6xLbfcqty9/j3YjmvOj6ryfhF88qPwwVeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1dl2J7w6NxMgTXq6pBjoN/02jltB/aqECKxEQhaMTn4=;
 b=VLSRv0lLtXrhFBf6nkWcrG2KkKgBIDpAZG7HGU/d7YjQtwOq4HZPfuNhcLuw1LO/60bF7kdvmjrDKLEFv7xkH6wJAp9yFUoiwyM+xqBlbaIh7IWIp6CsKdNMPbuZSR/8iJc6OpSn1SCmQF7q0xdU1QoqmkGm96XP01GZqik7kec=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by DBBPR04MB7801.eurprd04.prod.outlook.com (2603:10a6:10:1eb::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Mon, 20 Apr
 2026 10:16:40 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%4]) with mapi id 15.20.9818.032; Mon, 20 Apr 2026
 10:16:40 +0000
Message-ID: <d31d5dd6-6d43-4e61-8963-6474197675ca@cherry.de>
Date: Mon, 20 Apr 2026 12:16:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tools: mkeficapsule: Add disable pkcs11 menu option
To: Wojciech Dubowik <Wojciech.Dubowik@mt.com>, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Franz Schnyder <fra.schnyder@gmail.com>,
 trini@konsulko.com, "openembedded-core @ lists . openembedded . org"
 <openembedded-core@lists.openembedded.org>,
 Francesco Dolcini <francesco@dolcini.it>
References: <20260420083850.8504-1-Wojciech.Dubowik@mt.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260420083850.8504-1-Wojciech.Dubowik@mt.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0251.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::17) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|DBBPR04MB7801:EE_
X-MS-Office365-Filtering-Correlation-Id: e08e8d85-cab1-4e1e-223c-08de9ec5e9a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|10070799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Bdcsn2/pWesn4TOk1yPiTG0Df05COyEQ5+Liq4LkgGCXI79mMkZeyt9FItE6pR5ndUYyMrz8S1r5L2xHMM03gG6WT6MW7VpKZ39i3wycA2DPd8I1bvkXPvjb7D8u5KKrt7o/rjT+GzJs1KqM1MwB/b9o20xifFQ/05Cpuov57YWU0UTYpMTXHjh5ObRi0y77DMTPT2EBaQvANfwaCzDK3tQUSyE4t2b09JldIGAG5Y4tMLIcyp74RpMupWsr7lHImR7dOhqY/6kIQVF0ABcdShO6v3aV3snuKkt8cV2TgZm4gyydJgtpCfkon59XKioWzNnO2v9CYyrQWUe92JzTkrZnrKSjMajYvN87sfx8poYAWNTirG0ZS4BnCHwhQO01PSq01hGivet8USE7J4X9eAJtN+CQ9CwuvKQSwU1vw0ZKUvhReDVyyPiS2iTKikouuF5KltwPuiAXRX13W/Yp5S6r6TeMqhR1It0YrCYoQWNnfIa4ZFsg2knYrs+oQlACO1X7KjEhluq9ppR9h+ADmEv929azrhVWKUDRZ010F2eBfkXI5h6X/do7fqc0P/8on6cFYLIhnMpSCti1sE//dNeQz2rZe+5vtICSFGfENob+Z86qzDq1uqDKoH0rg8Lqd+CzahRfI3xiCARR9l2C0WwUrjDFS0W/G1ju1WJOaT3482E+OWE5ih2TJgL8Q7+FiT7EbLban3z/hCa0ZFWS9iRR0GjBUoBGyNizRkgfX0Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3VlVnN2ZitJcnh3d3dncWZ2L1FnUmdSQzlKcVBhUDN2VnRGcmtkK0JsZTcy?=
 =?utf-8?B?aVRXYSsxbWVYTExYelIvdzk3Y1VsdFZsbGQ5L0VIUjN6QkRBYUhYRWlPSlFU?=
 =?utf-8?B?enlEdVhjS2VGRG13eUg4OHhkbENMOXVtcHJSYkw5NXNuaFRqeU5INWRVNGdw?=
 =?utf-8?B?RU8rd3h4N3BBbTJyV3J3b1dlU3dsd01EMGo5ekJXM293RVl4T0JDT0d4R0o3?=
 =?utf-8?B?VU9ScFV1NFUyOEZxcGFVQjd6RllNTTRkVVVReVZpa0FDZmtRc0l2ay94QkJE?=
 =?utf-8?B?WVBXWSt1UVV4QWllcEF4cUZQMEVhbkUxUGRCVHgyNWIrSE8vbXpER1VXMXRl?=
 =?utf-8?B?WlJjSU5PTWFrdmRXVTFMbW9ubXBmeTB0QlcyN3EzaHB5UmhLUzRUTzN3bXl2?=
 =?utf-8?B?ZExMaXJmN0luZTd4N3dHOUROaEkvN3U1cDhwdWovK01TMnhkSTVOM2RwU2Yy?=
 =?utf-8?B?RzhreFJTZmxGOGlNNURYdTgwS0dnbTJmWDhGVUZtQVpCQmdGYXhzbnRjekh0?=
 =?utf-8?B?TFpGU0YzWndLK0o2TlNIRTMvVHlQMmttUE1uYmNIQ3BKdThjN2hWdDI3R3p3?=
 =?utf-8?B?b0QvTklQRVlwdE5yK3h3NHl0WWJrYVhnV2t6SjdHb0VhNFRvYS95YTRFa0pa?=
 =?utf-8?B?SURHdmlmZnYxK1UyVDFFQS9aUXVCUXVnOGRLMWl6dUltem5VdjQzVXh4M0Fs?=
 =?utf-8?B?VmswQTBqem84b08yMEhDWDJ4OEMvODhHQ3RZYVZZSWpPN2IzSG9jRGFxOXdT?=
 =?utf-8?B?TTZ5S1U2azJONzZZblRZK0lZTE1Lak1BSFc4L2t0c05YaEp5TUI4MzU3TWVU?=
 =?utf-8?B?ZHMzTHVXRGVkUllGQlB0bFdRVkZtZHp1U1hRUW82NmlQanlGcmJ6dWF5WE1h?=
 =?utf-8?B?SUF5OXJ2WjVRYWJRLzh6UFc3dmhNbnFzS1FVem5vOE9USXI4WTM1MExVMVQ2?=
 =?utf-8?B?N1JQNHNTR3Rwb2IyaEpINE80WWRNZEFncjVHeFlibDlSQXNhb3RGTHZCOFRj?=
 =?utf-8?B?bFZCa2VNeHNwb0VsMEYraWlGTlZJdHhEdEFUcWFNYUR5a0o4aHFJU0F5Q0tY?=
 =?utf-8?B?Y2VFRGpJUHhqRUF2Z0d2V2FzZEw3OFRsQ0VqdFA5a3gwTGJaL09LZkh3MVJL?=
 =?utf-8?B?ZmQvOFBHaTMvTDZCMnlJUWwvNWJZNWtoaEpYZGVpcHhicm9nakFWQjUzdmtr?=
 =?utf-8?B?M2FDa3lLUzhLOGwwcTM4TUhubXZDRjBRdzErZTVINGdHU2thYjVFNTRHYlZZ?=
 =?utf-8?B?aUIxUVBkcjh5b3NtZWdCd2xkaGNxUGowUitVeTlocWJSNng4Y01wOXpsOGMr?=
 =?utf-8?B?c05PNFlpSlQ1LzljcnExZElZT2dFTThmV3VjdEdUUWlveGR3bGJOSWNXR0lG?=
 =?utf-8?B?Qy9iNGRZaTYvVjNoRWFwL2t1RDdkYmRjY3hyWUdQQm9lcXZmOWU2Tm5oN1V4?=
 =?utf-8?B?Qm0zWi9WM29MYkRieUxKOXBjb2hlbkFIMEtMKzlCWjdxRFErdjVSREJSZ3FJ?=
 =?utf-8?B?WEFGUXdZTzkrREUvQTNpaVdmR2VaUzQwLy9DTTJSS2xxUW5WbUxFTmpXMnNQ?=
 =?utf-8?B?aGtuaWJJSWpCVE9KYms5WisreDRzbVk3SnY1dXdQZjNyeG5UR3NKbmNBbjR1?=
 =?utf-8?B?M2xaSlY5ZGVEd2FXNFZEUEZ1OVBDRUVjZXB1bzlhK1RnME1aNnRualRZQ2dx?=
 =?utf-8?B?ZlJFMTNyRmpXeWh4K3RKSDIxOWExdUdMdTZrUkJuLzVZcjNQRmk0T2svd243?=
 =?utf-8?B?RTd0NmIvUUlxazl6NG9HYkE5N2g0VXExbE00OWxnbTN6OHR2N3J5MER3cVNG?=
 =?utf-8?B?Qm42Ukl2cHN3UVdhWmZZajlpYWsxei9CQ0NIV1JBTnZnbkJnL3R6N2NIMjNX?=
 =?utf-8?B?WDV5bUIrdkJSeDAvcEZHaFVsekFZOWdnZGVMMTVEUkd2VDRxYmtiWUEzTTNv?=
 =?utf-8?B?R2FMRTFhSE1qVjBIaVEvb2JENExoOUl4OHVDb2xML05LeXdMUUJ3Q2FOWktX?=
 =?utf-8?B?MWZ6T3B0NG1VbU1iMzV5N2ovUVBuWVE5eGhDT3RIcVREVCtDSmhUSHZtc2t1?=
 =?utf-8?B?aWZPNnVra1pmNVdYdTl1TlhTbjBKVkZSVThqLzhQelFYVEpvTlJDQUVEbVBv?=
 =?utf-8?B?YndWRzQ4cXp2T1hLSUhGRXMrYzJKckhJczdydGh5TTJwQzNHT25paFFoMU1M?=
 =?utf-8?B?Qml3UFhTNjZFS29HSHliMWpYT1VTTlpNTkVVK2JXTkQ1T0JQVDNwTlRMZWxY?=
 =?utf-8?B?d1pyWkZTQWtXVitTUnIvRFdvUlkzYkFmeHFJUS9CdFFhTUdPcUUyNkE2b3Ev?=
 =?utf-8?B?Qmt1V3FHdXJzTlA5MzV5eHV5Z3o0RnBlVElrMnU1NWJZdzd3bnhRcEg2dlFm?=
 =?utf-8?Q?STSVVHSp9yc30/2NOzDs6mScBfVySh+s/IYuS?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e08e8d85-cab1-4e1e-223c-08de9ec5e9a4
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 10:16:40.0271 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UkiPVuEvRAAyYEho2MP1qg5Ay8S+sJZg8fXQDkebVio+hw8oEBl73oH1qiJb2ThbVrBVkqasVwmwfCs8IVrmD9PfFjBOkAODx0SsUe4jeF8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7801
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

Hi Wojciech,

On 4/20/26 10:38 AM, Wojciech Dubowik wrote:
> Some distros are using gnutls library without pkcs11 support
> and linking of mkeficapsule will fail. Add disable pkcs11
> option with default set to no so distros can control this
> feature with config option.
> 
> Suggested-by: Tom Rini <trini@konsulko.com>
> Cc: Franz Schnyder <fra.schnyder@gmail.com>
> Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
> ---
> Changes in v2:
> - make use of stderr more consistent
> - add missing ifndef around pkcs11 deinit functions
> ---
>   tools/Kconfig        |  8 ++++++++
>   tools/Makefile       |  3 +++
>   tools/mkeficapsule.c | 17 ++++++++++++++++-
>   3 files changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/Kconfig b/tools/Kconfig
> index ef33295b8ecd..ccc878595d3b 100644
> --- a/tools/Kconfig
> +++ b/tools/Kconfig
> @@ -114,6 +114,14 @@ config TOOLS_MKEFICAPSULE
>   	  optionally sign that file. If you want to enable UEFI capsule
>   	  update feature on your target, you certainly need this.
>   
> +config MKEFICAPSULE_DISABLE_PKCS11
> +	bool "Disable pkcs11 support"
> +	depends on TOOLS_MKEFICAPSULE
> +	default n

n is the default, so please don't specify it.

> +	help
> +	  Disable pkcs11 support. Can be used in cases when host GnuTLS
> +	  library doesn't support it.
> +
>   menuconfig FSPI_CONF_HEADER
>   	bool "FlexSPI Header Configuration"
>   	help
> diff --git a/tools/Makefile b/tools/Makefile
> index 1a5f425ecdaa..60e84bfbf20d 100644
> --- a/tools/Makefile
> +++ b/tools/Makefile
> @@ -271,6 +271,9 @@ mkeficapsule-objs := generated/lib/uuid.o \
>   	$(LIBFDT_OBJS) \
>   	mkeficapsule.o
>   hostprogs-always-$(CONFIG_TOOLS_MKEFICAPSULE) += mkeficapsule
> +ifeq ($(CONFIG_MKEFICAPSULE_DISABLE_PKCS11),y)
> +HOSTCFLAGS_mkeficapsule.o += -DCONFIG_MKEFICAPSULE_DISABLE_PKCS11
> +endif
>   

Is this really needed?

Have

config TOOLS_MKEFICAPSULE_DISABLE_PKCS11

in the Kconfig. Then in the code simply use

#if !CONFIG_IS_ENABLED(MKEFICAPSULE_DISABLE_PKCS11)

and it'll be fine.

>   include tools/fwumdata_src/fwumdata.mk
>   
> diff --git a/tools/mkeficapsule.c b/tools/mkeficapsule.c
> index ec640c57e8a5..2f6e22626c51 100644
> --- a/tools/mkeficapsule.c
> +++ b/tools/mkeficapsule.c
> @@ -229,9 +229,11 @@ static int create_auth_data(struct auth_context *ctx)
>   	gnutls_pkcs7_t pkcs7;
>   	gnutls_datum_t data;
>   	gnutls_datum_t signature;
> +#ifndef CONFIG_MKEFICAPSULE_DISABLE_PKCS11
>   	gnutls_pkcs11_obj_t *obj_list;
>   	unsigned int obj_list_size = 0;
>   	const char *lib;

Reduce the scope of those variables so we don't have to have an ifdef here.

> +#endif
>   	int ret;
>   	bool pkcs11_cert = false;
>   	bool pkcs11_key = false;
> @@ -242,6 +244,7 @@ static int create_auth_data(struct auth_context *ctx)
>   	if (!strncmp(ctx->key_file, "pkcs11:", strlen("pkcs11:")))
>   		pkcs11_key = true;
>   
> +#ifndef CONFIG_MKEFICAPSULE_DISABLE_PKCS11
>   	if (pkcs11_cert || pkcs11_key) {
>   		lib = getenv("PKCS11_MODULE_PATH");
>   		if (!lib) {
> @@ -259,6 +262,7 @@ static int create_auth_data(struct auth_context *ctx)
>   			return -1;
>   		}
>   	}
> +#endif
>   

This is getting kinda ugly. I'm wondering if it wouldn't be more 
readable to move the pkcs11-specific code into specific functions. You 
call the function from create_auth_data() and you have two definitions 
of the function, one when CONFIG_MKEFICAPSULE_DISABLE_PKCS11 is enabled, 
one for when it's not.

Something like

#if CONFIG_IS_ENABLED(MKEFICAPSULE_DISABLE_PKCS11)
static int mkeficapsule_import_pkcs11_crt(...)
{
     fprintf(stdout, "Pkcs11 support is disabled\n");
     return -1;
}
#else
static int mkeficapsule_import_pkcs11_crt(...)
{
[...]
}
#endif

[...]

static int create_auth_data(struct auth_context *ctx)
{
[...]

     if (pkcs11_cert) {
         ret = mkeficapsule_import_pkcs11_crt(...);
         if (ret < 0) {
             fprintf(stdout, "Failed to import crt: %d\n", ret);
             return ret;
         }
     }
[...]
}

Also, I think there's a missing free() after the data.data malloc if 
there's a fail (or maybe in the event of a success, I haven't followed 
if it gets freed later on). I see a comment of a few lines saying 
"better cleanups" and I'm wondering why we don't do them? Any idea why?

Cheers,
Quentin
