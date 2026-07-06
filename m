Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC2CDC43458
	for <u-boot@archiver.kernel.org>; Mon,  6 Jul 2026 08:51:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC922807C4;
	Mon,  6 Jul 2026 10:51:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="FzLZCZx6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C435846F8; Mon,  6 Jul 2026 10:51:15 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3691A80398
 for <u-boot@lists.denx.de>; Mon,  6 Jul 2026 10:51:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kaeSyre8Ks+sGgepmCkmqxlkfU33gPUpHV/Ai6/CYBYgR8DDL/Th6KfGajHIS/3UzYLr1xQcFJ1poclVhHuHg4TsB2C9mfrFUWSY9TUFNeAaWyIamdffwpNvB+Di5z0Xl3OcV71Bg7JUy0HN+1+3SynYroAGKcpm7UCw1fOMKkfTVOi9EFnla7W2EDokHrgLw5Nf+LjHN9O4woAQfKSTgb3gbQAeMqyMtMUDMdECl8wuERwL+miAzxTuJP+4LBfxhz6735U6N3QASH3I2lEr6dtkLN5+p8/bs+P6wCpv9og7mZuttmL3UvOP44B0+QSaYztyP0njZ0zvq1kXN7BjYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iK5gRbjZz/aLGTx8Gb9DXX2JvojFPaB46lQbrJmH6Ko=;
 b=BWy40qSbmKbYmqQKEVnRWMKK7oKjnaaJAFSe0+u2iyvSxeZLj6XWWWie3MP4XW2RZBeGxJ2Kgl+a+ArRaUiJZeUTwU7LpvU1GO5d+lLj1ton1J5zryQUuk/+Lh0ohBNlHEUmMy87qo3AGkBZ/t4z1dQhjoT1Folnmd2h0LUxCD4TykiBTGDQO+8/YmUOp1i5G3ypIA7krhS1SehMwttKhDv8HYDaQUvYZsAqCbISUmqxaou7dtB+u6/QgTl0JCfrnpjiVcXUiHgFs0HgkzA/9DKSn/WoU41jJMtJJTlNRZmuebiJY6f+nDbXc3w+IivTFNwTsP+lxxhzK93Xq3+0aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iK5gRbjZz/aLGTx8Gb9DXX2JvojFPaB46lQbrJmH6Ko=;
 b=FzLZCZx6+ylfvHZIT/aIctxJ2l8PAQ3Ceh1HpHyTC/Z6RbZ7LhNII3kk3spV5nbZDZaaTpog7bOg/yCUByJgnwHds21o39ADPvSjkwJ8JwUiLpvcP7iQ7w3IC3rEk/rWPQ+AkfiOLI2sXzZVpXHhfTw2uPBTQRGrV58f+AZNeeI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by DB8PR04MB7100.eurprd04.prod.outlook.com (2603:10a6:10:127::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.12; Mon, 6 Jul
 2026 08:51:11 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0181.012; Mon, 6 Jul 2026
 08:51:10 +0000
Message-ID: <f9a77b79-d47c-4853-93f4-4e346a489d72@cherry.de>
Date: Mon, 6 Jul 2026 10:51:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools: binman: add build key directory option
To: James Hilliard <james.hilliard1@gmail.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Bryan Brattlof <bb@ti.com>,
 Chukun Pan <amadeus@jmu.edu.cn>, Yannic Moog <y.moog@phytec.de>,
 Aristo Chen <jj251510319013@gmail.com>,
 Wojciech Dubowik <Wojciech.Dubowik@mt.com>
References: <20260703213308.3804461-1-james.hilliard1@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260703213308.3804461-1-james.hilliard1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIXP296CA0024.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:36c::12) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|DB8PR04MB7100:EE_
X-MS-Office365-Filtering-Correlation-Id: 4886428d-6507-4f00-0551-08dedb3bba20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|1800799024|366016|3023799007|17092099009|6133799003|18002099003|22082099003|8142099006|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: GQCKvngiBLrBV6WySrL0zUAn7TC4LlcHNd46Dtm1ekwhnHVHszaWAfW9y56aWBjTw4waGlDoc80/PMmiib4GdeJmFZzXiugiXH/zuM9PtnvUWyy9teHS3NyzadkWyLD9i9ikWKbDxaDe5c9dToqS8+7YwIVJ+ZQdlEtN7LuEF69En/PbgC/ACgo7VCw0HdoZwoTfel1MMp4iIf8inpD7W56hLafBwhROzZmY0fWHirCFsE+nfoJdLo+VOJi9+W4LDrnufL4Bon7/Fuz9lPcwObY6NXN8S9HVO1OlP8sVqfJTvlhPqOkSAz8kpk79LDUxjt71dizuBfGZ0TfddmBvfEVFvYGBbmB1hnidfnBFCuapWfzrQD7cADM3QOvypQfDcF4MFkWkaWrdcBQG7eEOtW4ToeQq3LZV098+zyrQ3+mr1xtjE9PpU0Ot9mNZI8bDNUSyV/MQGK3gSwTFL8b7TFhqUYfZOBdjZ75Cxa8GLCQmSuX0XDbq/77bhz2KJBBVwJ4QmI92YoWOCpVNUACtDm7afHjl7YFLb93HATiUCCovIJLNA35vl9MslrTyBSBXNw5wsPpOpcPUxWCfP7SgomhJ+fbfPjeZWfVwezlI0Wxdz1flingBs46BBtLuyI0RfEM38Ci08yrLAfcDBED7Agyxa0i7xUuNZUv2N1mIi0w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(3023799007)(17092099009)(6133799003)(18002099003)(22082099003)(8142099006)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2F5ZXR4M2dJREFMY0ZxNDdkUldLMUxWRmVYVFF0cmFpWXpnWFE2RVNkeGht?=
 =?utf-8?B?dWJsaVFjNGx2RGJaUG1vZjJ3YlRkNXFieXl3KzRVT2ZBZ3l3NVVSL0xtOCt5?=
 =?utf-8?B?bE90WVllcGNIaHhsNTVqOUV0UnljSkkrK2h0STk5YXRCMWpSWDEvQjdnL3Iv?=
 =?utf-8?B?MHBLcVBoRnNTejB1VkJScUZ5NFJTcmtFcGhETE13WXg0cjZZRGlYTG1mQmFy?=
 =?utf-8?B?Z1Y2ZDB3MXB4SlhncmxrMVpkTkRzdnhEN3o1cW5SV2toLzV3bStvWFZPK1hz?=
 =?utf-8?B?cVI3YW5VWi9tWEpZUU5wZWxjSVBSVzhqOEhaWk5XR3NXUXY0TjhBUUFDN28v?=
 =?utf-8?B?Mmltclg2Z0RDYlNqcG5BcEdsVWZoMFRwVVhOeTlieTdYa3JpcXRvTDBVTXZs?=
 =?utf-8?B?dU1pVG51dk1NRTlObjEwc2syVGNEMzQ1dkdIaGthei94MGUzdHRTenkwT3Qw?=
 =?utf-8?B?WXhhVGdNQk9ualRnSUd3elRyenNQYlU5Qy9PU0Y1SWVSQnF1d3hHajZyMytr?=
 =?utf-8?B?VDFOdTRkaVljUXRtZzZ3L1g5WkpEUzJmdEI5NEdwbjBuQlZXTVJWMXp6Q1l6?=
 =?utf-8?B?NVdCSDVDRU5ob0tKL2o4N0NmV0RHanNKTTY0ZnRnaDFpUG5tZjNMK0YrN3ZG?=
 =?utf-8?B?KzkzYmRsOTF5ZEhiNGw5UUxZRmxrQlRSNkhzM21neVU0bitjOHdlYzlnWWc2?=
 =?utf-8?B?RUVxODFLN0RvbXZSanpMbjBsRE11QXRnUC9FaHNmOGlhbW84ZEpScyt1b1I1?=
 =?utf-8?B?MUZicGtieVhvMEsxRFB0SFpwbFNxalJHZVZCaWJPbVhoTTBvOVFIeFJxdHBN?=
 =?utf-8?B?SlQySkk1SnA5KzZEV2dRa3FjUk02ODE0ZFFJSU83clovSW9Bcmk2ZHNaYlpp?=
 =?utf-8?B?MDl3UHBQeTFwcnYyN0dvNHM5Rjl1VTVkNFRjRTg2S05MRXNNempGbENza1BH?=
 =?utf-8?B?UDhlUEN6enQxTkhGSFh6ZTUxaEtPNUlGZG9VTEcwcElHaXlESU5DQUFlc2tJ?=
 =?utf-8?B?UWFIQ2VuNjJ4dFFMYUZaOFFUTnMvWnRyd0VaUHN4REtlMmpJRDByWDB4Q0Iw?=
 =?utf-8?B?MnpZYWVSUzJXTTlESTFURGY4b2ovU0x1M3BWV2tlVzZaMms3Z0ZicVBEQWNr?=
 =?utf-8?B?NGlvQjI2R3hvKys4UDBFVi9qSnphbFgxRTk2dThoaGtocFlON0xyRkZQMTlo?=
 =?utf-8?B?VTVFR01acGI3Y1JZdU5PVW43bkZtL1hDajRiKzV6a2Y5UUk2ZG5iMmg3dXl5?=
 =?utf-8?B?ZFhFMFVvRnlBb0tacHBTSEZLNjhZUVZPK1hSbFIyRktwVlArVG9NWU9uOEds?=
 =?utf-8?B?VTJRSW9DaWpFMWdmWlBmNFhMVjdtRVFZMGprZVA1MHcvM2ZCamF1cE16aGZz?=
 =?utf-8?B?UHEzOXB0WCtnMmwxUWNUMlA4Wk1tYmE3OE9yNDhkSjYrdDBpOE9VSnFFYzdP?=
 =?utf-8?B?QUl1My9KaTBrQmJuN0JFWS9hV3ZlQW1yK1QrLzhvWFlBZ1VtZlBZSUF5MGJo?=
 =?utf-8?B?YVk2dXlkVmlOMm9lQ2d1K3IyYlZXbzU3MGkvdHNhaVRYaEpVSmVjcnlYYUY4?=
 =?utf-8?B?SzNJZ2x6SlZ1dEtqdUI3SGdBQjUzZmhlNlhtNXdwR1hFMW1YZG5paFc3Nkc3?=
 =?utf-8?B?ZGN0bGk5OGxodk5za0VycC96L3VIRnRBME5tc2Jkd1ZWZThDODR3NHBMUEs0?=
 =?utf-8?B?WDFmVnJBUVVweDRTTDlldkwzNTRzclA5S2ZSYWlKdTBlYlNCc2llTXR2YjFB?=
 =?utf-8?B?YXp3OEZlWkZTa3R1VEJEc2gwUCtmOVBWQ2t2UXBHL1Rxb3FRTWYxUytuRHZL?=
 =?utf-8?B?MEFoWThNZUNJbWQ2V01kZmRWOEJXcnFDbGhlUjhwRzdqZHl0Y0lzWGhrVVRC?=
 =?utf-8?B?Vm1ENk0wd2F4Mm5lSTAxWStsMGc2QzNnZlV4NWhKdGFORm1sbUl3UDIyWHpT?=
 =?utf-8?B?WEx6aUZvYWFtVkhJN2NQQ3FJdk9MekdzT04zZ3dFeXpHOVVFT3hxblpkMlk5?=
 =?utf-8?B?eEhodjNxOWZkVlBhL2ZtYlJIWmtDbldlMTFJK2lySmR5V1pMb2hQczFMWkk1?=
 =?utf-8?B?b0ZsRDkxQ2lwQ2V3NThwdllkdWQxYmV1WERnekoySlEraUtNSXYvZm84cWE1?=
 =?utf-8?B?UGdPR0w0TG5KVVhCdVJJc1oxNFRjTFh4ZGZ5cmYrYUE5bFdyS2dCOEtYZEF3?=
 =?utf-8?B?MkpPYXJyVERtL2QxaDV2OWdIWURZZUY1NFduakkrQjR5Z3VETjVyM09kcVo5?=
 =?utf-8?B?NUZhaG5lR2ZKSXEwblg0UHg2aTlwWXJRY3ppNC8xMTNxSjc3bGlLQ0tHSkQ4?=
 =?utf-8?B?SE9iVlhjN3F4emxwSnZTTlk5S1lyY0srMDFXNE9Uc0NDSjlZWXZkQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 4886428d-6507-4f00-0551-08dedb3bba20
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 08:51:10.8263 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: afdXag/Mo1yGo/Md4m4I6Q5madSwjLraqqH63j4vT5pe4utnBShLF8AZjpAivtkYtXvwGGSkdbmhcPILTbusBrPKtnzeZ5ajlf8vSG0iSGE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7100
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

On 7/3/26 11:33 PM, James Hilliard wrote:
> U-Boot's Makefile passes KEYDIR to direct mkimage invocations, but
> internal binman builds only received the generic BINMAN_INDIRS search
> path. FIT entries with fit,sign or fit,encrypt therefore had to infer
> the key directory from include directories before invoking mkimage -k.
> 

You don't explain why that is an issue? Simply add KEYDIR to BINMAN_INDIRS?

> Add a binman build -k/--keydir option and pass KEYDIR through with
> that option from the top-level Makefile. FIT entries prefer this key
> directory over include-dir discovery and then pass it to mkimage -k.
> 
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
>   Makefile                  |  1 +
>   tools/binman/binman.rst   | 10 +++++++-
>   tools/binman/cmdline.py   |  2 ++
>   tools/binman/control.py   |  1 +
>   tools/binman/etype/fit.py | 24 +++++++++++-------
>   tools/binman/ftest.py     | 51 ++++++++++++++++++++++++++++++++++++---
>   tools/binman/state.py     | 21 ++++++++++++++++
>   7 files changed, 97 insertions(+), 13 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index d8287323c43..27be2a81e83 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1689,6 +1689,7 @@ cmd_binman = $(srctree)/tools/binman/binman $(if $(BINMAN_DEBUG),-D) \
>   		-I . -I $(srctree)/board/$(BOARDDIR) -I $(srctree) \
>   		$(foreach f,$(of_list_dirs),-I $(f)) -a of-list=$(of_list) \
>   		$(foreach f,$(BINMAN_INDIRS),-I $(f)) \
> +		$(if $(KEYDIR),-k $(KEYDIR)) \
>   		-a atf-bl1-path=${BL1} \
>   		-a atf-bl31-path=${BL31} \
>   		-a tee-os-path=${TEE} \
> diff --git a/tools/binman/binman.rst b/tools/binman/binman.rst
> index 366491089ad..8770b279ff8 100644
> --- a/tools/binman/binman.rst
> +++ b/tools/binman/binman.rst
> @@ -1711,7 +1711,7 @@ Usage::
>   
>       binman build [-h] [-a ENTRY_ARG] [-b BOARD] [-d DT] [--fake-dtb]
>           [--fake-ext-blobs] [--force-missing-bintools FORCE_MISSING_BINTOOLS]
> -        [-i IMAGE] [-I INDIR] [-m] [-M] [-n] [-O OUTDIR] [-p] [-u]
> +        [-i IMAGE] [-I INDIR] [-k KEYDIR] [-m] [-M] [-n] [-O OUTDIR] [-p] [-u]
>           [--update-fdt-in-elf UPDATE_FDT_IN_ELF] [-W]
>   
>   Options:
> @@ -1738,6 +1738,9 @@ Options:
>       Add a path to the list of directories to use for input files. This can be
>       specified multiple times to add more than one path.
>   
> +-k KEYDIR, --keydir KEYDIR
> +    Directory containing keys for signing/encryption.
> +
>   -m, --map
>       Output a map file for each image. See `Map files`_.
>   
> @@ -2161,6 +2164,11 @@ BINMAN_INDIRS
>       Sets the search path for input files used by binman by adding one or more
>       `-I` arguments. See :ref:`External blobs`.
>   
> +KEYDIR
> +    Sets the key directory passed to FIT entries by adding a `-k` argument.
> +    FIT entries use this directory for mkimage's `-k` argument when `fit,sign`
> +    or `fit,encrypt` is enabled.
> +
>   BINMAN_TOOLPATHS
>       Sets the search path for external tool used by binman by adding one or more
>       `--toolpath` arguments. See :ref:`External tools`.
> diff --git a/tools/binman/cmdline.py b/tools/binman/cmdline.py
> index 9632ec115e5..cd4d05dfb69 100644
> --- a/tools/binman/cmdline.py
> +++ b/tools/binman/cmdline.py
> @@ -128,6 +128,8 @@ controlled by a description in the board device tree.'''
>               help='Image filename to build (if not specified, build all)')
>       build_parser.add_argument('-I', '--indir', action='append',
>               help='Add a path to the list of directories to use for input files')
> +    build_parser.add_argument('-k', '--keydir', type=str,
> +            help='Directory containing keys for signing/encryption')
>       build_parser.add_argument('-m', '--map', action='store_true',
>           default=False, help='Output a map file for each image')
>       build_parser.add_argument('-M', '--allow-missing', action='store_true',
> diff --git a/tools/binman/control.py b/tools/binman/control.py
> index 816f7c1eba2..84586d1baf1 100644
> --- a/tools/binman/control.py
> +++ b/tools/binman/control.py
> @@ -923,6 +923,7 @@ def Binman(args):
>               tools.set_input_dirs(args.indir)
>               tools.prepare_output_dir(args.outdir, args.preserve)
>               state.SetEntryArgs(args.entry_arg)
> +            state.SetKeydir(args.keydir)
>               state.SetThreads(args.threads)
>   
>               images = PrepareImagesAndDtbs(dtb_fname, args.image,
> diff --git a/tools/binman/etype/fit.py b/tools/binman/etype/fit.py
> index f28b1e6b4cb..404e33d3022 100644
> --- a/tools/binman/etype/fit.py
> +++ b/tools/binman/etype/fit.py
> @@ -14,6 +14,7 @@ import os
>   from binman.entry import Entry, EntryArg
>   from binman.etype.section import Entry_section
>   from binman import elf
> +from binman import state
>   from dtoc import fdt_util
>   from dtoc.fdt import Fdt
>   from u_boot_pylib import tools
> @@ -105,18 +106,20 @@ class Entry_fit(Entry_section):
>           fit,sign
>               Enable signing FIT images via mkimage as described in
>               verified-boot.rst.
> -            If the property is found and fit,engine is not set, the private
> -            keys path is detected among binman include directories and passed to
> -            mkimage via -k flag. All the keys required for signing FIT must be
> -            available at time of signing and must be located in single include
> -            directory.
> +            If the property is found and fit,engine is not set, the key
> +            directory passed with binman build -k is passed to mkimage via the
> +            -k flag. If no key directory is provided, the private keys path is
> +            detected among binman include directories. All the keys required for
> +            signing FIT must be available at time of signing and must be
> +            located in a single directory.
>   
>           fit,encrypt
>               Enable data encryption in FIT images via mkimage. If the property
> -            is found, the keys path is detected among binman include
> -            directories and passed to mkimage via  -k flag. All the keys
> +            is found, the key directory passed with binman build -k is passed
> +            to mkimage via the -k flag. If no key directory is provided, the
> +            keys path is detected among binman include directories. All the keys
>               required for encrypting the FIT must be available at the time of
> -            encrypting and must be located in a single include directory.
> +            encrypting and must be located in a single directory.
>   
>               Incompatible with fit,engine.
>   
> @@ -485,6 +488,8 @@ class Entry_fit(Entry_section):
>                   includes 'generator' entries which are used to create the FIT,
>                   but should not be processed as real entries. This is set up once
>                   we have the entries
> +            _keydir (str): Key directory from the binman build -k option, if
> +                provided
>               _loadables (list of str): List of generated split-elf nodes, each
>                   a node name
>               _remove_props (list of str): Value of of-spl-remove-props EntryArg,
> @@ -500,6 +505,7 @@ class Entry_fit(Entry_section):
>           self._fit_list_prop = None
>           self._fit_default_dt = None
>           self._priv_entries = {}
> +        self._keydir = state.GetKeydir()
>           self._loadables = []
>           self._remove_props = []
>           props = self.GetEntryArgsOrProps(
> @@ -701,7 +707,7 @@ class Entry_fit(Entry_section):
>               args.update({'engine': engine})
>               # If no engine, keys must exist locally, find them
>               if engine is None:
> -                keydir = self._get_keys_dir(data)
> +                keydir = self._keydir or self._get_keys_dir(data)

Then we don't even check if the keys exist in _keydir anymore.

Cheers,
Quentin
