Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F2EFCD5BD5
	for <u-boot@archiver.kernel.org>; Thu, 28 May 2026 08:34:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A0E48404D;
	Thu, 28 May 2026 10:34:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="IFXctJqY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B545484659; Thu, 28 May 2026 10:34:10 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8863580087
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 10:34:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bwZUY00wOz6jRwkYeb/gLaFMC7mQKhVAaLHAwPSxmvOx3u8gtFe0i82EON0mCo1wbl0dfFLxVE66Ety0Hh5fj38zt0lsMoEUb5LxGI4Q3N2XQwb9A4umz5ZT3exgNWcVPqnsstK6E50qcX8rlqx3lzrLqUnDTfGG1dzLe5BazaixBRbqh9uOlGIBj63vdYHZUz2grKwqgODY7tFclg25pwndZcZKj9W7+2thQIyL7o6a5gXMFGLJXqSSgBEF4K4TzfgH6JKTfSwnOWJIVGw8V8dhRHpKmPYRmEEiZRsWouq4Z545yGwibpMSmg/EiAVAEeGpWrM9WN8ZKtoGrQ/nuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mo54ZdI2D65MZW9bRTjkpCmKzvHCEr/Cbocbu1kA8rU=;
 b=j9M1lC7Hg2tHuV9IhHA0qxM64ZrR1NZrRDEFncIysmlg+nHVt2odXn8rqFjVqLUFzDzvVLVEpa3fub/roquraSOdUkOPmJoFWUQrjEfvSzxuPpTnxJXpe89ZSQ25f8yQm4zC26wkKwSyPY2vg26RC6V3TkMNkKRdF236Uo/Ktnsc/ooFQop5xgFKvqlU+k3FVGpl3UqpLEzkIbzDWF7wU0aDitc7QuaunnoYhG4jDZO1xGOCu9GLGHnSVOlGR+zHcvVYilkoBZCq+B4GWFf5vHDIVlZ0lSColTczwMXnkwjc8qJBWvI+O52l8ebj3Qa+Q05G4gEPr52mIERuN1fCqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mo54ZdI2D65MZW9bRTjkpCmKzvHCEr/Cbocbu1kA8rU=;
 b=IFXctJqYrWjWTijzkyz7SCO9rYHisxU5cV4SgtZ/3rgzYL3uidAoniRDZrrxayHNQZsSrF92U5C8b3hxYVY6X1LDDr5KYdAy2F8A6GtizbxjGSkYqSsgM1vx3MiTdAodHuPzMvpheXbVjwQWSz4ksSoebEB2Um7T+8ogauCFwbg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com (2603:10a6:102:b8::20)
 by AM0PR04MB12049.eurprd04.prod.outlook.com (2603:10a6:20b:740::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Thu, 28 May
 2026 08:34:06 +0000
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7]) by PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7%6]) with mapi id 15.21.0071.010; Thu, 28 May 2026
 08:34:05 +0000
Message-ID: <7189291c-4aa6-4ad4-9382-1683f81de534@cherry.de>
Date: Thu, 28 May 2026 10:34:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] tools: mkeficapsule: Rework pkcs11 support
To: Wojciech Dubowik <Wojciech.Dubowik@mt.com>, u-boot@lists.denx.de
Cc: Franz Schnyder <fra.schnyder@gmail.com>, trini@konsulko.com,
 "openembedded-core @ lists . openembedded . org"
 <openembedded-core@lists.openembedded.org>,
 Francesco Dolcini <francesco@dolcini.it>, Simon Glass <sjg@chromium.org>,
 David Lechner <dlechner@baylibre.com>
References: <20260528080356.399082-1-Wojciech.Dubowik@mt.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260528080356.399082-1-Wojciech.Dubowik@mt.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI6PEPF00000229.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::8f3) To PA4PR04MB7743.eurprd04.prod.outlook.com
 (2603:10a6:102:b8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7743:EE_|AM0PR04MB12049:EE_
X-MS-Office365-Filtering-Correlation-Id: 904b7d34-8e84-445d-da74-08debc93e0e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|22082099003|18002099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: R0Rf7AMk+lkxwFqze4Eg/0QlNPaUrHtjeVJLOisKX2+ftLhkSvn2bsNDoJwEXNKC1uU3UF3CuifPugHsoY5zmRGzntAn9fqaJh7OKS359fMFAFE+IxGLDL0PCKKXCgX76WHNCb0J5FpGna5nza4mkicJ3Migr3hQt+QwUwLCxQ9cmhqOKNI7A6w7UweDutoQsh0AHz5KQDE5ri92qsI3tKXaxtugCd6U6fWOCedFVXa1u2NE6v3/NScfoKwjQ3eyZokqXAMXnjN3a/DGLC8C7gApKvg+CcF/KuvYVDviIO87QZpEobdkQn1CbmF8WUBsIAgzNjvJEPQfE0flVzrXnUrZNyj4dXC7HFV9Dhzr1tfejiKFYai3vTujUO5/jFzAd+KmUGttVnPj9nm3vvjpTFhBujhOsbbkQ7mMsQBN0cpuLq4GNcnN0afXzx7rP7WXOg0q1NxCPW4036Qo5KIh5Dc9rmkqZAEVnIF3mXX7NbHv1he9RmUt3VXV2BcnuZt1iL/dQyDE2fYskbrNoqm5UqRv2Ic659Lk+UDdXwvgsyb7Xykzw+YYhLFj17GqIYS1vSrTdW9iZldcvzLCuUvG1SIvvwMPFv++ATgX5aLDgINz5w3vJdrhnUNgjOIrPtUzG1JlNMT6QxU/nvgDTwoWb7EE98xsj4N2H2/fcZFJnDWfOVpnCG8tWDa5buibSJGQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7743.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(18002099003)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkxReFpYQVB6SlZ5TG5OQWd4elZrL1MycVRyc0N1Z2dFbThOME1RdlZmZU00?=
 =?utf-8?B?U1VTcDZlbjBNY0U2NzdVRmpZL3FZZ2Q3WWU5UDBjT0ZBdXU3d0JVZjVsQjgy?=
 =?utf-8?B?TktsNzJjR1hrd3IraVYvV0gwdElLRTdMVXVmYnNKSVBiZC9IWDgzSXc4NFkw?=
 =?utf-8?B?Sm1nZ2RwQisvdkdiVXRJSk5kSXJGdzZpY09WeEdEYWNhbGJZQ3d1M3hyRDFq?=
 =?utf-8?B?SkQwMms5YVc3elI5QXRkbTdVdy8wVG5mNVhmZDN1ekVnMm40cXN6MnpiZm9E?=
 =?utf-8?B?V2ZqRzNBcGZyUEEzSjB6Njk1N25maGlSWjQ4YXdITFdRdjlCb0x6M2ZtMlBD?=
 =?utf-8?B?a0NLakJGcjVISHBJdWduR3pESEZSRGs3VXRjQm5ZUU9RV2JwTHhxRnB4bWVP?=
 =?utf-8?B?UmlUc0NCbzVweVdGM0tWbnpua2RFa3lGY0liRzNpZDdDQzNHWXl2VXJ4QXhR?=
 =?utf-8?B?OXR5djRXUHhWRWlBS3NrNnVIazBMelg3NGJDdG04d0txbWFpR3VMajBIU1JY?=
 =?utf-8?B?ZXNpZXBjVFIzbm9KeEE5WTg3ZDFaMitBSEtmdkZuTDVCRm1vOVBKY2lCNzBU?=
 =?utf-8?B?d05jTjNCaFAyNnRVaU56Y05oL0pKNFlyQVA4NDlhZWI0ZXlBaENKTjZSNHRV?=
 =?utf-8?B?YVVzSUZyN1RReWoyL1pLSkZWMXZIRWxQRVhCSndia2hqaVQrK2g0cEUvNGJ0?=
 =?utf-8?B?VUNPZTkrbjQwcm1SVkhSWTR0azFwMDNRUlhXaHhMbUx4eWZvMWZvdE5PcXdk?=
 =?utf-8?B?ZGM1QzAvY2pzaGVibG5uakJONzlUTGFHMXFBZVhMMWZUSGhSYzdxMzd2Y245?=
 =?utf-8?B?MGY1SVJoeUR3em8xSDV4S09LWjk1U3lBb1BaeUFSRzF4V2lGNWt2cnpSajdO?=
 =?utf-8?B?NndPeU02WG90bXk4VElBZ09BeVdGc1pmVGVhMlVvdi9zR2oyRWQwR2lMOHpP?=
 =?utf-8?B?eTdQTUo4aEx5aExQcHZ0Q3BIOStqSkhXVEgzUW5iTjR5VHBqdUJIWmkrR2J2?=
 =?utf-8?B?M3VkcXpFMHhSVUhPZURqOUZmNDRQT1JwS1N5dXdjRXBWWG9ibHZrZlhQdFBB?=
 =?utf-8?B?OE52dExJNUZsVjRuZE9BSTBEQ1NxbU9Paml6Z1BBTng1bmJQcDdBWFQyeFBs?=
 =?utf-8?B?c1drMGsrMXdVc2dzd0NuMThlRjZlaHZVYnBqLzhyUWhCcklvdGthbk5qcU93?=
 =?utf-8?B?SjVUbjMzeXJTOWdnVUM2czNoNjNaaE91T2lVMmErdFFpV3FrVDJxK2YzR0N4?=
 =?utf-8?B?SUNjeXZmazNJcU1vTkFZcW9NVmVHMFM4Z2ZkT24wdTcxTVd4YlJZcVhwY3Iy?=
 =?utf-8?B?a1RtSDcwVHNWOXBYaTQveGgvWW5lbGMxU2xNV1dpTnlGdW1aVVZuaFhjNW5v?=
 =?utf-8?B?bHpDSzduZHhGVWIvb1ZqbWNyZERNVEtPdzVHMFFLTEN6WU9hdjQwWmdCVGJh?=
 =?utf-8?B?dUhPdEJ4bWd2YkJyeEJQNGJRZXNJRzF6WWpxT082ZWpER0dwcmVKejJIb04x?=
 =?utf-8?B?d3MrejRGQ2dtbFlhb24yLzM2SzJaZ3Rzc2FwTmxZbmoxYjBNcVV6a2RHZ1ps?=
 =?utf-8?B?NnBZUzMyL3lLNWZCL0NPOFJTR21LanVNbmdjSTZ1ZHlNZEVWQzFJSGxLUnlj?=
 =?utf-8?B?NEVqelBlWmsrZkxlcC82Q2JKQk9kMUdlanFXMWI0aWZ1UUtZV0J0VVNjc0Ry?=
 =?utf-8?B?cEM5MWFtVTJlT1ZoeHY2empxaml6VXBhN0FvVzlSV1YxZHBYVFlGY3dvVHlW?=
 =?utf-8?B?ZXhZY09aSGdOR2hOSlBjNmoxZ2MvMldFNTJZRThxNmhFdkNza3RLNWlBZUhh?=
 =?utf-8?B?akhJRTlXV3NjL3ZlQ05DMTdkTGU3Szk0bytKZ2tUQzVWaHZhRHliT2h6SlhP?=
 =?utf-8?B?M3NrWWhLeE01NjRaVTJ4R242dFlYZnRFbGJMeHFxRVo2d3JzWXAyWkJ5bGYz?=
 =?utf-8?B?L04wTDNaMDBBZ1lKazBhUGo1aGVrR1RYaDNFMFdLM2tUaXZTcFNMY3lEN0JX?=
 =?utf-8?B?TlhZQzc3aHVpTlBwNkdTc25ob2FwNzFGL0l3QnNQWXl4bURqbHExU05wbXBR?=
 =?utf-8?B?QVhyRGdpVnhyWVZPYUswM21nYUhyS3ZkeVdGVWVLUHY1UTZ6TkY0OFN2a0Nk?=
 =?utf-8?B?TnpvWnN5ZGV0bk9CbG90emU2YVpxZ2tFUHFqTnRhYTlPazVmUGhrc2E2TWlq?=
 =?utf-8?B?d1JUanNacy9oUW5WYlpEL1hjNlNjNDF5a2FObnJzVE9XV1g1aG5wOHdPY0NF?=
 =?utf-8?B?bTdWbGhnYjlhUVBIbWwwZmRrcVMrdk9OaVdzS2Rna3RBLzlaVk5zSzJ2K1RM?=
 =?utf-8?B?M0E1anIyZDVUTnhScnc1VEdSd0l3L2NJcUtSdTZFbThhWkNFdmoxQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 904b7d34-8e84-445d-da74-08debc93e0e8
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7743.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 08:34:05.7747 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P0a3JQMVte67x4RlQEUibnNU+FLGcC4+dzcfs3LYR5KQmGKTBaq6RJG+6SQuqp25/vv9hoxoXY3TF8/RzYLxQmFDJz6UuEVRB2OzrIuckls=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB12049
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

On 5/28/26 10:03 AM, Wojciech Dubowik wrote:
> Some distros like OpenEmbedded are using gnutls library
> without pkcs11 support and linking of mkeficapsule will fail.
> It would make maintenance of default configs a hurdle.
> Add detection of pkcs11 support in gnutls so it's enabled
> when available and doesn't need to be set explicitly.
> 
> Suggested-by: Tom Rini <trini@konsulko.com>
> Cc: Franz Schnyder <fra.schnyder@gmail.com>
> Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
> ---
> Changes in v5:
> - removed more unrelated cleanup improvements spotted by
>    Quentin, to be sent in another patch later
> Changes in v4:
> - abstract pkcs11 init function
> - removed unrelated cleanup improvements, to be sent in
>    another patch later
> Changes in v3:
> - remove config option for pkcs11 support and add auto
>    detection in Makefile
> - reduce amount of ifdefs by abstracting import pkcs11
>    functions
> - add missing free and deinit functions
> Changes in v2:
> - make use of stderr more consistent
> - add missing ifndef around pkcs11 deinit functions
> ---
>   tools/Makefile       |  5 +++
>   tools/mkeficapsule.c | 95 +++++++++++++++++++++++++++++++++-----------
>   2 files changed, 77 insertions(+), 23 deletions(-)
> 
> diff --git a/tools/Makefile b/tools/Makefile
> index 1a5f425ecdaa..e85f5a354b81 100644
> --- a/tools/Makefile
> +++ b/tools/Makefile
> @@ -271,6 +271,11 @@ mkeficapsule-objs := generated/lib/uuid.o \
>   	$(LIBFDT_OBJS) \
>   	mkeficapsule.o
>   hostprogs-always-$(CONFIG_TOOLS_MKEFICAPSULE) += mkeficapsule
> +GNUTLS_SUPPORTS_P11KIT = $(shell pkg-config --libs gnutls --print-requires-private \
> +			 2> /dev/null | grep p11-kit-1)
> +ifeq ($(GNUTLS_SUPPORTS_P11KIT),p11-kit-1)
> +HOSTCFLAGS_mkeficapsule.o += -DMKEFICAPSULE_PKCS11
> +endif
>   
>   include tools/fwumdata_src/fwumdata.mk
>   
> diff --git a/tools/mkeficapsule.c b/tools/mkeficapsule.c
> index ec640c57e8a5..a36332567e0c 100644
> --- a/tools/mkeficapsule.c
> +++ b/tools/mkeficapsule.c
> @@ -207,6 +207,71 @@ static int write_capsule_file(FILE *f, void *data, size_t size, const char *msg)
>   	return 0;
>   }
>   
> +#ifdef MKEFICAPSULE_PKCS11
> +static int pkcs11_init(void)
> +{
> +	const char *lib;
> +	int ret;
> +
> +	lib = getenv("PKCS11_MODULE_PATH");
> +	if (!lib) {
> +		fprintf(stdout,
> +			"PKCS11_MODULE_PATH not set in the environment\n");
> +		return -1;
> +	}
> +
> +	gnutls_pkcs11_init(GNUTLS_PKCS11_FLAG_MANUAL, NULL);
> +	gnutls_global_init();
> +
> +	ret = gnutls_pkcs11_add_provider(lib, "trusted");
> +	if (ret < 0) {
> +		fprintf(stdout, "Failed to add pkcs11 provider\n");
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> +
> +static int import_pkcs11_crt(gnutls_x509_crt_t *x509, struct auth_context *ctx)
> +{
> +	gnutls_pkcs11_obj_t *obj_list;
> +	unsigned int obj_list_size = 0;
> +	int ret;
> +
> +	ret = gnutls_pkcs11_obj_list_import_url4(&obj_list, &obj_list_size,
> +						 ctx->cert_file, 0);
> +	if (ret < 0 || obj_list_size == 0)
> +		return ret;
> +
> +	ret = gnutls_x509_crt_import_pkcs11(*x509, obj_list[0]);
> +
> +	return ret;

This is still doing something we currently do not do, that is, checking 
the return code of gnutls_x509_crt_import_pkcs11(). I'm not saying we 
shouldn't (I haven't checked), but this now does more than just 
ifdef'ing pkcs11 support.

With that done, feel free to add my

Acked-by: Quentin Schulz <quentin.schulz@cherry.de>

on the next version.

Thanks!
Quentin
