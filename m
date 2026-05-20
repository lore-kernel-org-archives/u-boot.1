Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9E5DCD4F3C
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 10:45:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F187846E6;
	Wed, 20 May 2026 12:45:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="gi2jwET0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F7A6846E7; Wed, 20 May 2026 12:45:44 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA986846BD
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 12:45:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oX9fNPsN3OeyZ146ojqneYPixLHR4URltXWYFHBacYzrbLmB0q5uI26wYLi26DIK0Z2bhZWN5VSgr1vDB85sSW6nw6ugSzDzk9WyF/XydR/YDhbq9gP8uo8s6afJJfsz8T/hzV0A9mlLJA8/rR2bI2KyOjfLj3IH6e/wqiuiO/I4x6sKCIq9r1aiqegXlc6ZLuHkBQWd4XKiNzeCAGRMdtAhXQ8usaMgWx+SoovIdln1HtvkpjPdVDjmdBSFeYlsDYgZLettJyWzVz0DaVIJnYXHDY+d/VlF7OIXG8nnb6U/yZeD/IJ89jHfouXBv8i4Y7AnKX5Ycxyi8Nhr4XY/TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1qM1zxbKAy5Ne2KlMRFQ+zwqoIC1996p07bPQj8chEc=;
 b=IWXn54gE4QPtP21yi086wkB39hqiXuxoPUiDuj4tkNyYJAk/zFUlnb46cZtpbDt4xrzuKmcklYjcjlgRvoBW38+vsuVpWlaa+KnH/izQbYr0VGYqdkC1TpIyEcnq0FqXCXq21BPROZZtkQe+37CmpEHB5iCDKhbGqBV508Gy0D/0BmQaSzIqKC3K5gpCgKCdgupWytvNyqzkejFkCuvBnOJfQlPp7+SpRTOKStH+17yMn1sx1KY/GQP01kI0VKzxlhwxvMJlk8Zr+DkKSk+bIZeyTGN7s9dr+AgUMNosPBDYgq9k8eox7yBHcV1jJvR+9CYESoi/r53oRh7pmdOBYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1qM1zxbKAy5Ne2KlMRFQ+zwqoIC1996p07bPQj8chEc=;
 b=gi2jwET0kN+37VPHrqYtsVtDKbIqieYbmw91KwFWIgtdi4nuSHJQIocdQdW8YK2bJGK0aQW1vndmdzFg8o6Ci/AQ0zb80/cPfceYP5CQ6c6kRCTAS8f354sQu7vaHEhr/XQi7AoPu1bBagUweBPesR+myLveMavim26ootIfsxE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by AM9PR04MB7553.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Wed, 20 May
 2026 10:45:37 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%3]) with mapi id 15.20.9913.009; Wed, 20 May 2026
 10:45:37 +0000
Message-ID: <af2b27f3-71c2-4914-a80a-0ba7d92b2cef@cherry.de>
Date: Wed, 20 May 2026 12:45:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] tools: mkeficapsule: Rework pkcs11 support
To: Wojciech Dubowik <Wojciech.Dubowik@mt.com>, u-boot@lists.denx.de
Cc: Franz Schnyder <fra.schnyder@gmail.com>, trini@konsulko.com,
 "openembedded-core @ lists . openembedded . org"
 <openembedded-core@lists.openembedded.org>,
 Francesco Dolcini <francesco@dolcini.it>, Simon Glass <sjg@chromium.org>,
 David Lechner <dlechner@baylibre.com>
References: <20260513044537.22773-1-Wojciech.Dubowik@mt.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260513044537.22773-1-Wojciech.Dubowik@mt.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR08CA0220.eurprd08.prod.outlook.com
 (2603:10a6:802:15::29) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|AM9PR04MB7553:EE_
X-MS-Office365-Filtering-Correlation-Id: b951d0f4-57e9-4635-4b41-08deb65cedb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|22082099003|56012099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: tiwBnOLbLu3q2fNZsSUha35Ccz36y3QErqkOusHRy7ZsUM7Er6uJ+4Upf+2XFOoNgdgyqbiMwzlcfHKHvFCFQzvl/g4mBcmskh0ZKbJ9pZLsFs7DgRcYucs2lzyyp7qcYKmDIBaxRHtaXx5CSJFPA7U6CipBB4ajlLfCpTlDKV8qOXgl3snf13ItaJRdCAeVVcDY/9gGpOw9EO7pEyiu8N43sRIzxFvfMj7+p8XP8/W6kCJMG0AqlYlw26gV2tzgqH6ly43PGsRDxlYtSdto8LcZUjPNYULwEKM4x/FsGh6vr1flnSLc8y4AkVXf226dgDcsXgm7UJgK88hQrg9mD6QAwoz1z/70oY9NH1jH+qFLZ31Xcvbm/VG2g+GRs6HoCHVedanFL2Z02RHwGpxN/0/kQQgbFE79ASB5zde38LIrovUvpR4Cc2mXaZVpZgJ2BH3nqu+cPv7hZ6q7zFAqsko2C+4yZmXT6c3GThYvLuNWFPxE93zysgbvbPyeP9dJSAh9dZ2+6W9QLL0uKxxLbgghbJdIcZnBmO74f/gPWSChfENdqNU8j0xd+f/MEjMquLN/WtQZAfK8d/3dTx4sUG1LF65d+j55bH+IUCQNvNpp+H9LVVAQBRQCIo1+rY1Jh9UCE9x5IZ0avd8dyS8l8758yX77MxgemA8N3ekpvxHBu2+ohX1JyCu0v4mLJi0b
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(56012099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RnliV0Q1eGhHaHhyZjgzd3M2SEpkVzJ4SWtCQTNibDlaTm1RbzZ2Ym5ZYTNt?=
 =?utf-8?B?WGJ1clpMaVNBeWJuaEg2TG9GenpzbjdMZGdlYUI5b201ZGJ2ZDE1alQwNlFo?=
 =?utf-8?B?c3hMWXNIZGRlSFVvZ1FzdzY5K0lpTms0KzRqL2VRYUVTa2piVGNRYmJveWtU?=
 =?utf-8?B?L3ZaZmkzMHE2WnNFWTBSUnIrVXBOZlozTlFFR0plMXB2eE9ESnFTdVdGVjgz?=
 =?utf-8?B?UjlGeGYwcmdHemllRGtyYU9KVTV2YS9MdmZjTFd4VHN6aTNXZ21VL3FMMjIw?=
 =?utf-8?B?RkZkcTJBUU0zdklkdUplM3hnVWVxTjBmbndsc1F1cDY1ZlUwdlN4cmkzdHRG?=
 =?utf-8?B?blBlVVNXYlhsblRKVkViNnFhSVF2WXd6L0pJYmJTTG5Gd0JkNG9XaXRLelVU?=
 =?utf-8?B?SXFMRmdzc0d1L1hkYmJJalU3MG0wdTI1TzkxUVV1YnRmM0FaaHZXeU8zZVdm?=
 =?utf-8?B?dFRxNVpTZFVubHAvVG42WkJCc3FWTGFVK1ZhQ2JHMmtOc1pHdzA1bnNxdmpT?=
 =?utf-8?B?Q1ZFdW00TklOeDJRYmlmclE4RGFVZ1k0TWNob0dwN2lnQWlVOGVRS0NLdDR5?=
 =?utf-8?B?cm9Kc0hlcnVjMjVxZ1VQMytHbUZ0NlRYaFZ5Wm1oNzZIc3ZFekI0RTBQa1VT?=
 =?utf-8?B?cmlGNGhaYkZDVkRJQzV6Qnk3RVZEK2RUQitqSEc1ZEVkRW5pYVEyYXlyVUVU?=
 =?utf-8?B?YWlRcUM1YVlpYkdwRlowUGhsS0RKUy94Vzc0YmFHNWVMWGdIemFDRHQrS0lF?=
 =?utf-8?B?N0NQMDBFOFRrSG4vMHpJcXdWWi9nZE1LMk4xUnFHSWR3bzFkcjBDWnpxeTA3?=
 =?utf-8?B?UTJiNDBabE9zTzVsMjdHZTk4Z01YdkF4UjlHVDJDSU5ZdThpMFVTOHUzSnFT?=
 =?utf-8?B?bUZ1YW5RcGhCTzhTekx3WllIbWdjbE5EcExiWUVoZERCSXJnTHJxVGEzeHAy?=
 =?utf-8?B?b203L1dmWG9UbkJ2RWRxWWNwdlAwdG00c3pJeWRXdjBOdUs0MDVJS3psSEN1?=
 =?utf-8?B?YmZaQUNsYnBGSjczalpCTTlnQ0JCNUlhQ2ZIK285YUlUb05WWTlpZElLN1Q5?=
 =?utf-8?B?OWg5d2FLby9kZnhacEF4cjU4YWovWTlvRFI3YU9nZ0gvTm91ZnZlR3MvQXpx?=
 =?utf-8?B?VWxpYlFsV1FKdkRHd2pWRHh6OHEyK20vcE9Ca2FpcHQ1OEJka2ZvU0FLZ0Ez?=
 =?utf-8?B?NGRuNzMxMFh2QnM4NXNDeDM0emZra0ZqVmJsVFZteG1mbHVuaFIydTZ2Q2pT?=
 =?utf-8?B?QThTYVIxQ1FmN3NPNmdGUzdTUmlveGlyUnJ0WG5vWWQ2bVMvUk9rSURWaFA4?=
 =?utf-8?B?QVJ0bnBUa3pab0YrU2JmTG91TFVsbHR6Uk04S2syVUNNUVpvSk1SZ2FrK0NG?=
 =?utf-8?B?Ymg0L2tRaDhrczNqUWlMNndpaDlpYzVrUUlGUGdnMWpsdHByZ0srREgraDNT?=
 =?utf-8?B?bVdXSTZDR2twTXdWV3NsRmFyRDNTNFo5RFVoVjBqVkttS1hta1BqZFNvbTMx?=
 =?utf-8?B?ZlFTTnBZaXpGL092WVJQUUEvamNWWkdUTFJsQnlPU0hVUk1yUnphWEkraXpr?=
 =?utf-8?B?d2s0VWJmdWozY2ZUTi9DYmZxa0cwQVdiU2R5RHhCZjkzVmE1OTNRSkgxLzkw?=
 =?utf-8?B?T2JIb2NLRU8vM1hxalFBZFVrS2NPUnFabWpSNG1GdHdTc0FOTERKMVN0OC95?=
 =?utf-8?B?VnlQR3lPbWFHMkpCZ0tvbnM0NVlqdkcrb2h4OEJaRzRkYXNMRWpZSUc5ZnJ2?=
 =?utf-8?B?UXJrS0NZblZ6SElNT0hsaXpUQndITUtsRTVybU9WUzZrak5UcFR5ejNTeFVm?=
 =?utf-8?B?ZzVBWGNEbUZlSkRaUDN3ZUs3UnROak50QW5hWndLb1I4bFNmdmtkcE12TzZV?=
 =?utf-8?B?cWYwcmMrbkw1YWdNdVkvMXMxaDlDSzQyK2gxR2daU0JVMzlMR1RBVlRGUEty?=
 =?utf-8?B?S1J2STEzN0xmZHNZRHVoMTJmYzFXNVlNWWVxZGhqRjc3dm5aZFEvME5nZWIz?=
 =?utf-8?B?OStxNFV0M1JCVzVDV2NrZWgyWURpZ3RxTzgvRytoaVV1U3NTS1ZZQzlLYjlW?=
 =?utf-8?B?ZWVPR3JKbisvVjJBb0g5Mm9tODM0YkJ2MExHSk9LdUtQcStaSXlaRExZYUlI?=
 =?utf-8?B?TkhSZmlzbGNNTkF3L29zdUhZazRhWnB6VGtGVVdKRXhIMUdha1ZuazJqaGU0?=
 =?utf-8?B?REwzM3k4aE9NQkx0QmhRM0lKRW9uakNRODdoT3hQNVBqTjZnSWtFSlBTRnRE?=
 =?utf-8?B?bVJjMDZVbW5WMUxXWVhvK0puODRnT1hFUFNOREs2bS9UVkpjSEhQVmhvTzBM?=
 =?utf-8?B?VVA3TzVRbTAxOHBsNnRlY0tHNFUyM3BXbGxId3pTRFlsYkRxVGZYZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b951d0f4-57e9-4635-4b41-08deb65cedb1
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 10:45:37.5471 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4joMv8Khk0/WKTT0Qub04V1vJ6jy1K1XIZToDpyKDoBzcKH7MERCdW6BcJQE9olHqkd0oV2e6JLlCFzfoe0OmukhWsFkpYdqV4QOcFHj8v0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7553
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

On 5/13/26 6:45 AM, Wojciech Dubowik wrote:
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
> Changes in v4:
> - abstract pkcs11 init function
> - removed unreleted cleanup improvements, to be sent in
>    another patch later
> Changes in v3:
> - remove config option for pkcs11 support and add auto
>     detection in Makefile
> - reduce amount of ifdefs by abstracting import pkcs11
>     functions
> - add missing free and deinit functions
> Changes in v2:
> - make use of stderr more consistent
> - add missing ifndef around pkcs11 deinit functions
> ---
>   tools/Makefile       |  5 +++
>   tools/mkeficapsule.c | 99 ++++++++++++++++++++++++++++++++++----------
>   2 files changed, 81 insertions(+), 23 deletions(-)
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
> index ec640c57e8a5..132bba286e4c 100644
> --- a/tools/mkeficapsule.c
> +++ b/tools/mkeficapsule.c
> @@ -207,6 +207,75 @@ static int write_capsule_file(FILE *f, void *data, size_t size, const char *msg)
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
> +		fprintf(stderr,

We currently use stdout for this. The change is fine, but in a separate 
patch please.

> +			"PKCS11_MODULE_PATH not set in the environment\n");
> +		return -1;
> +	}
> +
> +	gnutls_pkcs11_init(GNUTLS_PKCS11_FLAG_MANUAL, NULL);
> +	gnutls_global_init();
> +
> +	ret = gnutls_pkcs11_add_provider(lib, "trusted");
> +	if (ret < 0) {
> +		fprintf(stderr, "Failed to add pkcs11 provider\n");

Ditto.

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
> +	int i, ret;
> +
> +	ret = gnutls_pkcs11_obj_list_import_url4(&obj_list, &obj_list_size,
> +						 ctx->cert_file, 0);
> +	if (ret < 0 || obj_list_size == 0)
> +		return ret;
> +
> +	ret = gnutls_x509_crt_import_pkcs11(*x509, obj_list[0]);
> +
> +	for (i = 0; i < obj_list_size; i++)
> +                gnutls_pkcs11_obj_deinit(obj_list[i]);
> +	gnutls_free(obj_list);
> +

Those three lines are new, please have them in a separate patch.

> +	return ret;

So far, we've ignored the return value of 
gnutls_x509_crt_import_pkcs11(), so please do the same in this patch. 
Another patch for checking the return value can make sense (haven't 
checked).

Looks good to me otherwise, thanks for working on this!

Cheers,
Quentin
