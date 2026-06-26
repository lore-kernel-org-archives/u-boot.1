Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C622CD4F26
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 10:32:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7275F8460E;
	Fri, 26 Jun 2026 12:32:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="TNDaPmPJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D5DD84704; Fri, 26 Jun 2026 12:32:24 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C63A18404D
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 12:32:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kD3rNl4Sdb9Xnw/O0i96bCXDTZu9BMWymzkRt8V0FFS9KBIiIJU51mfJIeFuXy/qg0JCFqFLKcD89vs/Q830ZSwVlNs13DqaJG6/6Q8tfpz2tY1/RvWw3awvvfAshUUZM0SRaobjCOIinl4HjMkNmEMKqeQX1GKew1rhKXUHU7usmfmLOgRVcnnpMa6XeWq9DnmZEJ2ycTbppJi8QlIvsCUSBgTAxhc5/BltPDnKXi6htjoMEPDzHCPeAtHCYt33NnCp/cc1ZpRCYpLV/p1A+vpapLy33OrxWeQdHZVCavVyzl5QliQUqwuBJqCa2YkLasEmXbrUsW4e98ckxttLUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oLcl40UG3SnlgWcOpyLj6Jcslv3Yxkhnh8fjm2M+uRo=;
 b=RiUBoqhtAxektkJdYWzjs+HsPN5mp3t1OseIMlLW7Nvolu7kxot97gP7IGkGcvN4xC3K9dPadNCCRHMaLRemdwihZPCC17gdF11P35iYzwuUWxcxQLnACkb2pMk2m1B9SvJ6xv3+Jc1xn3OjgH8xyfBEXiJTCmCBDFPe3pnuc3UGKsp87X4oq/fk14VjO2S+T0PrMt2GOFGO4upiYUHBqWTCKwKkHkYgfPKWcGUa1JCQR8B0eekSOgubOVd2Rtt5eGFR5TNrqY1qLTeKeVLHn7/8/OZuOez3UWU4Xzcjq1b6SMbE9MssQODN2muMbbD0pJUF4n4OHzecgIFoHKQIzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oLcl40UG3SnlgWcOpyLj6Jcslv3Yxkhnh8fjm2M+uRo=;
 b=TNDaPmPJhovSs2nIiSZUCWVM7FAGv/Ei171MU+rB55MbvO0qMAOiQZA12gwTQ4J3+xwWJIGlrUCtg//jXob4o+nKZ45gsfieO7Im2kgKE9rIrQiqwiEkCuFjYL8Mje6XpqhaTxHVaxZbKqQLle0uUZMadUAKCCWYumbLih9eZeE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by AMDPR04MB11651.eurprd04.prod.outlook.com (2603:10a6:20b:71c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Fri, 26 Jun
 2026 10:32:19 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 10:32:19 +0000
Message-ID: <0ed97c95-dc99-4fd1-a0d8-5300085475d3@cherry.de>
Date: Fri, 26 Jun 2026 12:32:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] tools: mkeficapsule: Rework pkcs11 support
To: Wojciech Dubowik <wojciech.dubowik@mt.com>, u-boot@lists.denx.de
Cc: Franz Schnyder <fra.schnyder@gmail.com>, trini@konsulko.com,
 "openembedded-core @ lists . openembedded . org"
 <openembedded-core@lists.openembedded.org>,
 Francesco Dolcini <francesco@dolcini.it>, Simon Glass <sjg@chromium.org>,
 David Lechner <dlechner@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20260609070105.525348-1-wojciech.dubowik@mt.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260609070105.525348-1-wojciech.dubowik@mt.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0116.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::45) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|AMDPR04MB11651:EE_
X-MS-Office365-Filtering-Correlation-Id: 30c686a9-b193-4442-9f11-08ded36e3347
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|1800799024|366016|6133799003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: MuJ88LURdlx9rhZo0skQUXKe+G5cXZuT/cITZSiwVOX+FLfL3QzfX3VGHaF84McLHigSe+iTAb3lMVeN+AJ9XMAyMxz4rvmX/V88a1eFEbU63MGDxyeZoinQOmds08rPqtMZuV4LbkBULp/W09dmvIDWNJG3LmfDZBapTbQa7Hdns/kn8gpCO2uAq8uIxEJR9OLMpcE7zT//pO8fxG/EZB/ZmJIZvhucjMiFxbhAN0FgOvUoSrBADwhoFtlb1f35x8Ncav6T8uNXr42LhufJ8iTHJkmW+DJTqKQFlmfnWh5KO+qmM80BN8XUOw2FbRgdIpzjjGq+U/knX9j8dFQYXRP9HWYRlanbypaJd0uKdkv05gVw+WdIY0Z1IwbnlnZ41gHiUAt9vClYY6nFpIO7F/1MLDkWhkA0ObiYw5olCsKULsM/6j0eDICm31yuwFrWfkcE4/A/r2N4ONUGw/fY/huR+DMrtM2O3pW7NVeejztNVLW2tsursnnU4Accc509BlKXu+Z8XmPVaatdc+DPWhnujjNCUF8kdFZL29V05cIoR5Fnhb7FJGaDAoKFv/q9moKricr47i37wPn55vC/JEw+QrnG14oRajgZW148zQypYK7dOtlwdphPpIGGvS2Id1GoBeDlAHksLIV06BQ+0jbHAvu1pmmyTMk6aZTxdeA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3VXTGJYSUlBK2Uxa3EzM242ZFRPMG9KREtlcHd5VnV6eUJqMWhFOUhad2FP?=
 =?utf-8?B?VHFIOFFFT1RiN0oyUFUwSVFSZGZKZzBsQlljbE5LSTBOMEhVZlNzUTd3QUli?=
 =?utf-8?B?dVA2K2ZzZ0VMOGZEc004WWZocmFmVGZqeVdJSUtXODVGeWtoRmFFSGhzdFRR?=
 =?utf-8?B?d3hFQ0tzR0k5K0xXc004TUVTRi9WTEZ4TENLRzZYS1QvRmMwK0drSmdOZzgz?=
 =?utf-8?B?elFYTDJPajFjZllTTS8zM0VxY3k1ZkkrVmw4ODQ4SmVWUit5aVNFTkI0SVQy?=
 =?utf-8?B?ZzlCNWFUV000RVpGcGhHZnJJS2ZiUWs0cEduNlZoVER5czQxZmc3ck9UdldH?=
 =?utf-8?B?ZEo1eTBQTWtXbzJxODV6ekY3MXkrZXkwaWpuL3JXaWJGVnRwRWF0b3RKV2ZO?=
 =?utf-8?B?dHhjRlpFb29saU1ML1BXMWRxRVFaa3Q2dVNQVndlRkI5UGxYZi9BbjhmRGRq?=
 =?utf-8?B?MnlCOC95QmRuZ0NuTEpTSWxDSmJVN2NqeWJndmpiQnN0RmdxV01KcTRqQWFG?=
 =?utf-8?B?ODAwY2lmaHNzek1ibnBBQWV5WXRncWJkQ01vQml0V01WM0pBY0V6SmFJMVgz?=
 =?utf-8?B?U0dwdlhvREJuQ3k3Q3lJaG9YWGNSU2xLV2tLRk5acjhhMEUvYzdTdWEvQ2N3?=
 =?utf-8?B?Y0pRdHRlZHRFL2laWXBXOFl5NjNkZFFsRTJwOEs4Zm04YTZUTTB1WU9GWUl3?=
 =?utf-8?B?Tm95a0dLV1ZsNXJDQ1RBL1dPM1dNL2xKZzE3ODFDOW43MmE2QTlOejRKOEFy?=
 =?utf-8?B?MDlKaHZsYjZSY1AycExQREtGdC81SDZEMXVPQ3pGaGVVT1VxTEMxZGM2cFB2?=
 =?utf-8?B?emxKbkxjdEhJZUUvN3FnKzI2SFFqczRhMHY5QVlnWmpVU0tDM3pxLzI4Vk5Z?=
 =?utf-8?B?bW1acFZLMm9RQVl1R2E1NzZrRDJMVHFCSWdvQi9VK2ZPbUN5UWhwamduNjhL?=
 =?utf-8?B?VHRNZlpqcmlSWHpMWmVONWlNQVM0NTRWQ29DRFVYZ3Q0TU5MRkpLVjhMeHV3?=
 =?utf-8?B?U2txOVd4bk5EaEl6cllKQmxTMlhaTXpWS2JkU3BpcnhrYVJLdlloT3djMk1J?=
 =?utf-8?B?ZTdGMWh4b1FGcTFJN0RBaS9oRjMzZG5FUkNqYmZhcm1kbytOaUdxVE95YjhX?=
 =?utf-8?B?RXg1anBweHhoKytXTVlHYTNrR1BJM2hXZjJQeWUzdEtrV0JJZXpYYlBxQ1Yw?=
 =?utf-8?B?R1ViRFZWR3d3K1RjYUFvWDBkeFJuMk55TVE0Ym5uT1RsSlRuSmFvMm90Rk9y?=
 =?utf-8?B?ZnExYkFFbFRUaDVoWDM4WDJBSFdFZTUyVjJxbVd1ZjdLdnJDWHViM0R5NlVY?=
 =?utf-8?B?RTZCb2lEQnNMWTUvUWlGZlBiWnhhN1dYL1lTNFBXUUtFYlUwR2l6ZTM1UVMw?=
 =?utf-8?B?NkgraUh3dWYxMldtbmVPZFdVaTVzcm1TRUkvVkNYZmtmQ1JvNEVMRlJXaGhS?=
 =?utf-8?B?Z2JFdTJZRE1jNWFDU1ZPYjAzaUVBNytMVXlRWC9JTGdhU1FRcHQ4QVVRSHVa?=
 =?utf-8?B?NTh5UzZEU0tLN2haemV2SWpyUkxzL0JoUVlwaEljZFBlWWdBREZjS0R6Rm1s?=
 =?utf-8?B?QS9Td3hmeHc5cFRrZDN0SGdMNXhEblpYUzVFT2NRcjdrd1ppWHI1N3E0MCtn?=
 =?utf-8?B?Z3B4Qi9VWU15S2N6V3MxaExmL2ZvdUtmZGJuSFBDS1pDaTRyQitBeWhjRStZ?=
 =?utf-8?B?VUhYQUpLckJ4dEJoeVpWVGhsNndMSnJpOUtGQjg0eitaS0xhOHRiWHF1ckdQ?=
 =?utf-8?B?MjlaZ050c0RKNXpKa3Axa01kbVNXSnFVbU1leEJQVi9qbHNid2NkVXZLSCtV?=
 =?utf-8?B?VlZDbkhXVXV3Zlp1L0Ntbm5LaWQ5ODVUK3pRc2t6eVBZaXBaT2JCakozZ0F2?=
 =?utf-8?B?eU94UDdLSDVTMlJJdHBKdXZjQWY4bFdLb0N0L2VtN0JWSHE0RG1YbzZPOU9j?=
 =?utf-8?B?bHlVMGVCMUVxSmF4bnpIMmh5dGd4RXlxTDgwWUMxNVVCMHYyUzEvUmFWNUlk?=
 =?utf-8?B?VXRFdk55RlpGYmN3aXJYUmRNay94dzRybUxsVGlJUEI1L1Z5VXB5UFMzM1JO?=
 =?utf-8?B?WCtKU3lsVWhpa2NNMUxMWlcwUTNocmJZT0IzNzFzelhnTy8rRGJqSjh3Qjhl?=
 =?utf-8?B?WC9UaGtxalBnb0wvSFByUGd1SVF5dmFwaDRYaFdqWHVJZzRuOG1OaUVISW0y?=
 =?utf-8?B?U2xGdFhYYmR5MzFSTkNVV0oyR2VBckhnTWwxd3A4Rk5FbkhDWTFiVS80RHEz?=
 =?utf-8?B?a2ozbG9ESlkvcDM4bW1qcHZwdXVkaUFaRHlHUWUyQ2dRRGdTNVNzMVZSV0Ur?=
 =?utf-8?B?dEhxVXovVkVBSTdKZE0vNFZiWnF2TE9KbnVJWUtjQys0ajhZTlpPQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 30c686a9-b193-4442-9f11-08ded36e3347
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 10:32:19.4718 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kBfs1rnz+XCRFk1bAy1zYzF6vHO6rDq/OZOC8OuaYHrnY8c2yBoYjeijK8jmk23ptiaybUqdhtaAAeNNdXP+skb7V2ugfXc0T2J0IHLS6kU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR04MB11651
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

+Cc Heinrich and Ilias, maintainers of tools/mkeficapsule.c according to 
./scripts/get_maintainer.pl

On 6/9/26 9:01 AM, Wojciech Dubowik wrote:
> From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
> 
> Some distros like OpenEmbedded are using gnutls library
> without pkcs11 support and linking of mkeficapsule will fail.
> It would make maintenance of default configs a hurdle.
> Add detection of pkcs11 support in gnutls so it's enabled
> when available and doesn't need to be set explicitly.
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Acked-by: Quentin Schulz <quentin.schulz@cherry.de>
> Suggested-by: Tom Rini <trini@konsulko.com>
> Cc: Franz Schnyder <fra.schnyder@gmail.com>
> Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
> ---
> Changes in v7:
> - fixed return code in import_pkcs11_crt to restore the old
>    behaviour, spotted by Simon
> Changes in v6:
> - removed return code check from gnutls_x509_crt_import_pkcs11
>     sugessted by Quentin, to be sent in separate patch later
> Changes in v5:
> - removed more unrelated cleanup improvements spotted by
>     Quentin, to be sent in another patch later
> Changes in v4:
> - abstract pkcs11 init function
> - removed unrelated cleanup improvements, to be sent in
>     another patch later
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
> index ec640c57e8a5..c3cf48f4cc1d 100644
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
> +		return -1;
> +
> +	gnutls_x509_crt_import_pkcs11(*x509, obj_list[0]);
> +
> +	return 0;
> +}
> +
> +static int import_pkcs11_key(gnutls_privkey_t *pkey, struct auth_context *ctx)
> +{
> +	return gnutls_privkey_import_pkcs11_url(*pkey, ctx->key_file);
> +}
> +#else
> +static int pkcs11_init(void)
> +{
> +	fprintf(stderr, "Pkcs11 support is disabled\n");
> +	return -1;
> +}
> +
> +static int import_pkcs11_crt(gnutls_x509_crt_t *x509, struct auth_context *ctx)
> +{
> +	fprintf(stderr, "Pkcs11 support is disabled\n");
> +	return -1;
> +}
> +
> +static int import_pkcs11_key(gnutls_privkey_t *pkey, struct auth_context *ctx)
> +{
> +	fprintf(stderr, "Pkcs11 support is disabled\n");
> +	return -1;
> +}
> +#endif
> +
>   /**
>    * create_auth_data - compose authentication data in capsule
>    * @auth_context:	Pointer to authentication context
> @@ -229,9 +294,6 @@ static int create_auth_data(struct auth_context *ctx)
>   	gnutls_pkcs7_t pkcs7;
>   	gnutls_datum_t data;
>   	gnutls_datum_t signature;
> -	gnutls_pkcs11_obj_t *obj_list;
> -	unsigned int obj_list_size = 0;
> -	const char *lib;
>   	int ret;
>   	bool pkcs11_cert = false;
>   	bool pkcs11_key = false;
> @@ -243,19 +305,8 @@ static int create_auth_data(struct auth_context *ctx)
>   		pkcs11_key = true;
>   
>   	if (pkcs11_cert || pkcs11_key) {
> -		lib = getenv("PKCS11_MODULE_PATH");
> -		if (!lib) {
> -			fprintf(stdout,
> -				"PKCS11_MODULE_PATH not set in the environment\n");
> -			return -1;
> -		}
> -
> -		gnutls_pkcs11_init(GNUTLS_PKCS11_FLAG_MANUAL, NULL);
> -		gnutls_global_init();
> -
> -		ret = gnutls_pkcs11_add_provider(lib, "trusted");
> +		ret = pkcs11_init();
>   		if (ret < 0) {
> -			fprintf(stdout, "Failed to add pkcs11 provider\n");
>   			return -1;
>   		}
>   	}
> @@ -301,14 +352,12 @@ static int create_auth_data(struct auth_context *ctx)
>   
>   	/* load x509 certificate */
>   	if (pkcs11_cert) {
> -		ret = gnutls_pkcs11_obj_list_import_url4(&obj_list, &obj_list_size,
> -							 ctx->cert_file, 0);
> -		if (ret < 0 || obj_list_size == 0) {
> -			fprintf(stdout, "Failed to import crt_file URI objects\n");
> +		ret =  import_pkcs11_crt(&x509, ctx);
> +		if (ret < 0) {
> +			fprintf(stderr, "error in import_pkcs11_crt(): %s\n",
> +				gnutls_strerror(ret));
>   			return -1;
>   		}
> -
> -		gnutls_x509_crt_import_pkcs11(x509, obj_list[0]);
>   	} else {
>   		ret = gnutls_x509_crt_import(x509, &cert, GNUTLS_X509_FMT_PEM);
>   		if (ret < 0) {
> @@ -320,9 +369,9 @@ static int create_auth_data(struct auth_context *ctx)
>   
>   	/* load a private key */
>   	if (pkcs11_key) {
> -		ret = gnutls_privkey_import_pkcs11_url(pkey, ctx->key_file);
> +		ret = import_pkcs11_key(&pkey, ctx);
>   		if (ret < 0) {
> -			fprintf(stderr, "error in %d: %s\n", __LINE__,
> +			fprintf(stderr,	"error in import_pkcs11_key(): %s\n",
>   				gnutls_strerror(ret));
>   			return -1;
>   		}

