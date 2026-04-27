Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60B4DFF8860
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 16:19:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EEA683BC4;
	Mon, 27 Apr 2026 18:19:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="UXHMUJ/9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E2EC84178; Mon, 27 Apr 2026 18:19:31 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29DE283AA9
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 18:19:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ikUubd0FCmrg6eJ3aBxxBGqXgGAZCkprwE2SH+ACRgRAg8F1nQQ+9sS+5PGuWbNs085LmZxCtv/RX6k68ihJmTvh/GY/04QURxMuZykNJQjn4Ns78OJbGk1MsuhpCqPlwkiBQba32LzGkvevGbs2IvFM93cDe2WkSyHktBITUweLtNu542qFeh4M0XG1EM4ThLza8HIUHkCJ73S3PoSAoIHmlZLG4lpnTRROUeGKlzf1wSeQe0/Q6VC+6NZYZUOfllQ++qpZ4J7lALt3b2eZbyTq4T2WXIDaknNJCgF1/wCZWrNjVxy9DAuAIRCejxDiVR8BGzZf+A1yV2uLlbTsZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ghoZW5VJ7TC/1craH5wzDvGz6uESjnxjbsE+u0Bc+VY=;
 b=hfIP1/Ql5+DtTqwCqwDH06WLBElSVTCrhJ7ZyVu2L6Y8me82KN5OumEeE9kNKDNmRIEnvvO+kmLfgw31geuXuKhKRlCbLcNLG+Ppc7zoBo5joSjPCY5ItXs/BY5zT9yFThhQRIqSmByGPJ/tJ+9Jq6TCesPtyWnHUZQS64Mc8frabcXSLbNwe642R1hgChZcIB17hBCrKZktueQUGTHttkFQ+JV7AcLi9fCq+sV3+ujN0+A3cGAvLXQp1YhUyWyqDylhFlzbHoxZZcRAZpTs2fSr7P2kTZlDQgsbQwBXxesJY5V9UfPUEKFpprnpf8wbpJmj91dyyl29YajLqMFbWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ghoZW5VJ7TC/1craH5wzDvGz6uESjnxjbsE+u0Bc+VY=;
 b=UXHMUJ/9VY6zVnc7SjBEj4y8Q3KDFeYJE0ErQeOZ0T5TDVLkGFRIYeYVHhPSiVBtoYl21LvWaErHl671d2lR6HBBj0NsIBbipDYW6yo0hwVj7weTrfQ6EfhWFOKVJdAUbB9HK5uSQ9xFYtUvZXC0sI0btWMnYkUn42vXplXTkmQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com (2603:10a6:102:b8::20)
 by AMCPR04MB12672.eurprd04.prod.outlook.com (2603:10a6:20b:76e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 16:19:26 +0000
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7]) by PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7%6]) with mapi id 15.20.9846.016; Mon, 27 Apr 2026
 16:19:26 +0000
Message-ID: <8dc3d041-cafb-4022-833b-64ee9c950d7e@cherry.de>
Date: Mon, 27 Apr 2026 18:19:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] iminfo: also verify signatures
To: Ludwig Nussel <ludwig.nussel@siemens.com>, u-boot@lists.denx.de
Cc: Frank Wunderlich <frank-w@public-files.de>,
 James Hilliard <james.hilliard1@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Julien Stephan <jstephan@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Osama Abdelkader <osama.abdelkader@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Shiji Yang <yangshiji66@outlook.com>, Tom Rini <trini@konsulko.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, Yao Zi <me@ziyao.cc>
References: <20260427150409.400914-1-ludwig.nussel@siemens.com>
 <20260427150409.400914-2-ludwig.nussel@siemens.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260427150409.400914-2-ludwig.nussel@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0049.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::13) To PA4PR04MB7743.eurprd04.prod.outlook.com
 (2603:10a6:102:b8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7743:EE_|AMCPR04MB12672:EE_
X-MS-Office365-Filtering-Correlation-Id: b6b4542d-5b86-4004-6a12-08dea478c04b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|376014|10070799003|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: f2vwW1kFMK/Fb8ewtcK3u7C2TmaZjN/0Sj2UFVWNdkNTngVzAprnRT3tUy3vsGPapmqN57Mg25Jwh/is1CsNVgkIHQ1Od3IXjp2PrY1tcUU4rq2nddmK0XXJb8r8or4HrAGHPRTSOFcBYL5U+FyEvZjC3bsKE/Ajiaf7M5xgQG4EJzscAfX90xvmUiG0eHkwsKeXnCM7gUetFWq6h9CyX9t/k9BBCy0+aO3ck/Fmkms/Wwxgk+lxpI+c1mP7Bi9Xc/zyKzuBfmUX3pf21N161MmZr5+Z9GeNzzqM1l0aQdxlA4uJ+pbwuUHbmrrs1yVfe4ruiBhCco77yinZC/dewy6yvuMcWemUlv2RnnJ5LOOP8CIbSxY7JruGQASkw90GohOB5vkWXAXAFNut8wgcfQqHDrvTV1sjcb5jPaBRo4lT2eE39DSNdJis6l+ZFKDOSRakAkb/syHM+42bJ7xqQ7ZrCfjHDPV06zYrexPJpUejO4h4Uqal4pxh9RQXt3e8/Q4gHjiVGLUjx7UUuJnl0MJs5n/7uHpMQYtagWjjb9DmADXXEdmfcjb/9GOw4i8WMxOnp3kvQDhjIniSlf/FAjzHP0lgcvLuUDPGopgYP+92U7B8rhS9z0Wp+h55fTlciMF5kvXLKLbkI9NIujrjiSH7WKzTfRmLkKJhqYxptCYIHIHD0voUMbamWaKJLcz48fuyLQc9CwA+mGIbIUK989HgS2jQeKXQTS7QwKymVZk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7743.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(10070799003)(366016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjMva0dKQVBYZTdXT0xuNXVxVjhKOGRvR3daRFlOQTBzL0NNbXZEQzVueW5s?=
 =?utf-8?B?QXVMdWQ1Y3J2bGJHV0phZVU5QkNxMWtNem1wYUgzdW1FM0xwKys2d2VyeE5t?=
 =?utf-8?B?SDc1NUZET3N0UnpUcnFBTVM5d1h3RTluQ2M4bVd6UWFDRUk5L0kzZTQvZVA2?=
 =?utf-8?B?MVQrbEg5eGpXNExTTVhOTjNNSmsvekFtTHcyNEYzQ2JlOU5CdXNZblJlSVVN?=
 =?utf-8?B?eFVmVW9NWnh5cEliMURscUpJbyswUTBmNVJHRndaVndCUCtYWFhnTm5PY1Uz?=
 =?utf-8?B?Y095OExWTTlldUd0MzBhVHJPMHF0ZlhzQnZtU2owdHZqSUYxdnRVOHo4ZXh1?=
 =?utf-8?B?TzR0QXEwSFhUaG5KWTNLUjNmd2Z2M0VNSXNJMDJLMDUyd3B6M0NRVXNFOVZJ?=
 =?utf-8?B?K3ZMRmwwRXkxU1c3cFBBWDVDcmNKQllGdEJRaXJWQ1duQk9aSDJ0SjR5cUFH?=
 =?utf-8?B?VUZxMm0rY2ptbXd5dFg5c3BaR3RNU0R0ZmM0TjdwU2UxeGhpQVNldHBoUjhx?=
 =?utf-8?B?LzFCYXhKVFRRazh4YmwycFpOV0tON1RIRVdZaDh4MDVSQi9TQUlqaWp1NUR3?=
 =?utf-8?B?N3BBZGNYb0tLL1Z2Rmp3Yi83QWhOSVdkNHdJSHo3TjlnTGl5MkNER0YxclVv?=
 =?utf-8?B?Zlk3UUNpT3J0WnVuL0xuenFQT3Bmd3hpSG9KQ1VYMVhzZFc4RVpUeXFRRFpy?=
 =?utf-8?B?V1ZvWFE4bFJ0WE9HZGNYL3MyZjl3SjhRSWp5aXRPVGFNMHRNUTJ3d1dMWDJv?=
 =?utf-8?B?clgrNmQyL3JzcURsN3B0K0RQZFFPaDZJVGljdVk5NXlENkFldXVZR0ZFZ3p3?=
 =?utf-8?B?NUVESTJ4L1JuaTNhYWszeFUycDFSWkZ5WUpkZEdRNzJucnJvUTF2Q1ByeXJD?=
 =?utf-8?B?L0VjcFJncEcvQmdodlZQUHUvaE5WWTd5WUlpdHV3UEhXYWwwSitCTFI5Sjl5?=
 =?utf-8?B?WHc5NXJrQ3lRSzViQXpqKzFVNXhGU09YSFVQVFZZdWtSeHpFR3VldW9Qb0ph?=
 =?utf-8?B?RUl4eHQ5aFo0MFc5bmxtcXlneEJGcHAranQ3U05uYU1jZFpEMjhLNWY4VVRy?=
 =?utf-8?B?SWFlWXJmQVZPOHhvV1dLMEhBMkRsR0FoVmxhM3lidGV6aE8weUNpcmpOTCtF?=
 =?utf-8?B?R1dKV3Z0bFdPWUJGMFh0cjMxcU9VYnNsNUpDTWwxb1crUUFIRXpwQUpydUZK?=
 =?utf-8?B?cDJQVlJTZS9FTUFMYkNZVVJKSG5MS0xnanFMUDZ1NjFpTFVFMGhsUmMvN1NY?=
 =?utf-8?B?a0czWHFPWm1jYXB4clZnNkZ5ems2R1RlVHM1cjFLK1VZUGllVDcxQ3QxcWZX?=
 =?utf-8?B?MytMNGcySVJyZlF6RjJJeEJXMUxKL3Y0dXo4OVpDZ2Z1Q0xOMVk4QTYrTXRm?=
 =?utf-8?B?aEFENCtwc3hITDlzbk0vR1BadzA1UkdidmR4S2h2M1YxRVkwMXJ5TGpMRmJZ?=
 =?utf-8?B?a3NHWmRvSWdDQ2FqcG5CeDBQdE1FN3FqSDFBRE0vLy84SVF5S3A5NVBmLzNJ?=
 =?utf-8?B?amJDVHZRVXpMUE1uaEpSSHVzSVM5QU16N3hPQkxkNTJzSlRaSjMzMElQOEFw?=
 =?utf-8?B?ZUs2Sm5NaUp0N2twcWN6bnRyMGNBN0dnY3B0T2VTbUtoZGlWOEFXVHZ0VExp?=
 =?utf-8?B?MVJpK0lRQmpqQjJtL3M0bTdUZ0V4ano4WGdwNEZuVWJHaGN4NFVTRkVBdWFu?=
 =?utf-8?B?ZjAzaDlZazgzRVZPTkptd0tWbXg4YTE2Mk1rZlBhbWFPR3RkV0RVcnphZWVw?=
 =?utf-8?B?ci9yYnRpRWtiRnRTWnBvK0lsSzYvbVcrcmVkY3ZobnQxVWZCaGlLbnU4Wksz?=
 =?utf-8?B?WmxLTUdBcU5hY2FjN2wyWk5EQ0JGQml6aW5xbWovMXZmVHBubzdKazFKWFc4?=
 =?utf-8?B?Q2JrUVozOGFISjRDVHBncldydnJhSXNBUzFTckcydG5PaHFkRm5aZjk1MXN3?=
 =?utf-8?B?T2pPNFBmc0kyb3BNcTVQMnhHdlp5bFJ2SDljOXEzZlUxSzZIRlI4K2dFSDIx?=
 =?utf-8?B?RlVqblhFMXVCejJVeTNzWnB2RVlRZ3JabXEyczc5R0V1UHU2d3JRN0huc3ZJ?=
 =?utf-8?B?Q09JRjBxWDF2OFlWc20rZVF5aE5KS1Zqdy9YK083NUZzM3p0WFhqa2JhaFFr?=
 =?utf-8?B?empNY1A3MUYwbHA0MUY1b05yQnZXK2ZLeHNBRUx3SHhoZmhSZnlORlpIQWhG?=
 =?utf-8?B?dURna3Z4TGNtUzRsNEdQNDF1M1Bab01XYVdkMHJ1dmZQdW5VbWk4TC9WUUV5?=
 =?utf-8?B?YzJlRk9XUGpuUlZGUjQwRnJGOXU1MVQvU0tQNEF0enA4RHQvUkdmV2JCK0kw?=
 =?utf-8?B?OUtJZnppakgwUDJJYWNoR2lINEZRRWZVNnVrYVc1VXpsTGkySytVdjdhUFJZ?=
 =?utf-8?Q?hvWN29sRt9LYtcIfw6dsnLm1ToGckrAcunzuG?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b6b4542d-5b86-4004-6a12-08dea478c04b
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7743.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 16:19:26.3723 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Y1tJLD1gYp2LgqsB67sdy7iPomxPhrdXG4LFCf8rUAvQl9glKI9QVDG+WNvgYglKWnY8gi6hQVjij0OfQVB/fytkJpVJxvA/UY2BDsDSn8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMCPR04MB12672
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

Hi Ludwig,

On 4/27/26 5:03 PM, Ludwig Nussel wrote:
> The iminfo command already verifies hashes of images. This change also
> verifies signatures of configurations if enabled.
> 
> Signed-off-by: Ludwig Nussel <ludwig.nussel@siemens.com>
> ---
> 
>   boot/image-fit.c | 36 ++++++++++++++++++++++++++++++++++++
>   cmd/bootm.c      |  7 +++++++
>   include/image.h  |  1 +
>   3 files changed, 44 insertions(+)
> 
> diff --git a/boot/image-fit.c b/boot/image-fit.c
> index 2d2709aa5b1..b2c6db79edb 100644
> --- a/boot/image-fit.c
> +++ b/boot/image-fit.c
> @@ -1512,6 +1512,42 @@ int fit_all_image_verify(const void *fit)
>   	return 1;
>   }
>   
> +int fit_all_configurations_verify(const void *fit)
> +{

Please document this function. It's clearly surprising to me that the 
function successfully return if at least one conf node could be verified.

> +	int confs_noffset;
> +	int noffset;
> +	int r = -ENOENT;
> +
> +	/* Find images parent node offset */
> +	confs_noffset = fdt_path_offset(fit, FIT_CONFS_PATH);
> +	if (confs_noffset < 0) {
> +		printf("Can't find configurations parent node '%s' (%s)\n",
> +		       FIT_IMAGES_PATH, fdt_strerror(confs_noffset));
> +		return confs_noffset;
> +	}
> +
> +	/* Process all config subnodes, check hashes for each */
> +	printf("## Checking signatures for FIT Image at %08lx ...\n",
> +	       (ulong)fit);
> +

Please mention in the log output that we are checking conf signatures 
and not image signatures.

> +	fdt_for_each_subnode(noffset, fit, confs_noffset) {
> +		int ret;
> +
> +		printf("%s ... ", fit_get_name(fit, noffset, NULL));

Please indent like we have for fit image node verification, with 3 
leading spaces.

> +		ret = fit_config_verify(fit, noffset);
> +		if (ret) {
> +			r = ret;
> +			continue;
> +		}
> +		/* at least one correct config */
> +		if (r == -ENOENT)

Where is this ENOENT originating from, it's not obvious to me.

> +			r = 0;

This will be overwritten if the last checked config is a fail, so it 
isn't "at least one correct config".

> +		puts("OK\n");
> +	}
> +
> +	return r;

Please stay consistent with fit_all_image_verify which returns 0 if not 
all images are valid, otherwise 1. Here the logic is inverted and allow 
for partial verification. The former is an issue, the latter *could* be 
fine if we document it well.

> +}
> +
>   static int fit_image_uncipher(const void *fit, int image_noffset,
>   			      void **data, size_t *size)
>   {
> diff --git a/cmd/bootm.c b/cmd/bootm.c
> index ca7cec91fad..2faa9648c46 100644
> --- a/cmd/bootm.c
> +++ b/cmd/bootm.c
> @@ -335,6 +335,13 @@ static int image_info(ulong addr)
>   			return 1;
>   		}
>   
> +		if (CONFIG_IS_ENABLED(FIT_SIGNATURE) &&
> +		    fit_all_configurations_verify(hdr) != 0) {
> +			puts("Signature verification failed!\n");
> +			unmap_sysmem(hdr);
> +			return 1;
> +		}
> +

After patch 4/4, I believe this will now fail if you have a FIT image 
with only image signatures and no conf signatures (which is valid!).

Also need tests to make sure this doesn't regress.

Cheers,
Quentin
