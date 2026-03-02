Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 864D1D58E7D
	for <u-boot@archiver.kernel.org>; Mon,  2 Mar 2026 09:04:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD05E83E63;
	Mon,  2 Mar 2026 10:04:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kontron.de header.i=@kontron.de header.b="QSFRm5uG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58BBE83EC9; Mon,  2 Mar 2026 10:04:23 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28B7383CDF
 for <u-boot@lists.denx.de>; Mon,  2 Mar 2026 10:04:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frieder.schrempf@kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TWEfZ2n2Bgno2hiRTRnuDSiH5uuxnG3gwmZfXYaoBVPv3SOux/J93vT31k9VIK27OtX1XD69iKQgLLnb0cYTJ13n+Qunjpkvhll2TYH7AMymIaxYCL1vJmt3Hc9gtsBgK8llC8WDNb9vhQUROhdP5z2pI7Ht8hY1lcpNYcNxE/ZiM/P4HhIINePJ3pgdcjQ27haHdEZ0psjP+S2GBbwdB5WPKB8veDf4zecs7k2h2SA5a8pGbolJx8dWV3DGlMiOYnH3erjJM+HapXcejCWo3V8h8ohfc6jA9cOv1RossRvdk2hn+WrP32cxGfgWU/pMCnKK7n+Kcwvsg3c92hPV8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NV/AHyck+rp6TGsnyJGtbsvmSrlxnLpIn1vKRQlpzkw=;
 b=nauL2/6vNAPvi5+nmzFxdsylOTpWmetVv9tu8FIcW7Z3yRAqPhv1xJTuht3/j/Gflg5MY1ABgavjYvpnHEzBqHLmlYevFUBpqdO92plIyYRs55WJSWSzk94Iyn9cVVQl8ZKi4qfUs8BeKr7jUyVli56e+Npjspq6sPmIBBV1lTe0QEscv97ugddqG3owbb9VwGFbPT2FoFq8z3xCAUhSrwhRYvBc/nUidD+nsUkAyKH4o5yiKQxEwtFL0mIo5oi/Y4fXXpZPXvdH/EMSA1PJceSzHX3YY00mXpdULozpdsVAKMsQD/XRDHoWs9C2ay6WABmI2nOqd+ipNTvF/cYVCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NV/AHyck+rp6TGsnyJGtbsvmSrlxnLpIn1vKRQlpzkw=;
 b=QSFRm5uGeFDOpZyCAyPXg/eU/9DPik12UqgGNQHPTQaUp9Eoow/EPVc8h4KT7HFt0dmFraG9yTY3EGjpw16b3UZTvoUk0NQR4ZkViZx6b0fOHjH4JtUJkeJ/TLsgDcK1lcg4kTL+oFOtL2kQumqUiWznqlg8l40fXy64ZMM3pGxa/JJtI3M//+1xq0d14/aHL7KNn4p68/u1q2fLnZ+XfcdYXELG7Fs2xW6+RTVAF9WPS4dMFa12x2nZ6XKeS4MlYvR4/+BtEdDyZHBjXi9gh4wednMecL2d+Req684hkH8rCirHnKrazQB760Jif++uLcSGOY89TEqLVyCpyhkpfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1fb::23)
 by VI1PR10MB3215.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:12f::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Mon, 2 Mar
 2026 09:04:19 +0000
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22]) by AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22%5]) with mapi id 15.20.9654.014; Mon, 2 Mar 2026
 09:04:18 +0000
Message-ID: <5719d056-acf7-4fc5-9e61-c5ea5d94298c@kontron.de>
Date: Mon, 2 Mar 2026 10:03:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kbuild: fix cross_tools compilation
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, trini@konsulko.com
Cc: u-boot@lists.denx.de
References: <20260302085508.39076-1-ilias.apalodimas@linaro.org>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20260302085508.39076-1-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0048.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:23::20) To AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1fb::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4277:EE_|VI1PR10MB3215:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ba5771c-1a5f-452f-9211-08de783aafe5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: +ZsNab9wh0K5W+NPr3vDHrDdb+vHll3rPcOrksavmLQF7NCMrP7H8XETCBvs/PvuIE/j5tEnNsWSDFmoRXYHdNw4U1hGprjGA5ng72J3y+OUtX5csOYzSuhtiO29YDEPSizOOmtZ3uLhLIVf4gmzNZaXehFVii8zYm/jGE/LsrLZmFTolPRsO28w6W97YR8lzcyy/OtdsboGiuQ8mbBCdi5LDCla8s2g7IPWNhFlQxhF9/xWpqfEMz+QVMkgfLme6GeZTUmSgKIY3/y2vNK2XOF/cW36DJoT1wqTxulN6EmYUSE39rc7t4j6cQQvRqbt8fbVjy0/1nThB6s6jU/qeVvmOjm9R7BJujlQaIAzxnPfHbsuFz1xYSSMY+m+7+lCo3GLbbIbCVktLbivmJk1JC/53MgHCZMHO4Ko7etdCCby1uedE3xOE2wB4xmh3L3WZS2Mju5Q17QUZmaYLv1pPvbfK0Ilqd9NBAoWnUw8B3qVZtRumb4urRpXYrtQI9NajXZi0DQkXnwBXJhmU/QAgxBaZKjJjyqajX1pf05WJ7xvi2mktB7pVAq6dS/3lt/WKjlqFDbx0WJLmCvDsy14nClWCZZSs5wiGEtneXJa57hLx0E7rwrmPB8M6A3kGO0WgzLJIdBS5uyKDTasqmpRCQ5XFFSLuDjtnVb3lhHRRYzB+RM5+0ijcpzuDMfAaW5up8BeNVI9v1l6Maw8qu5x7+mYrSH7mZuac/k19u7Fuow=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zi8vOGFsL1ZpOE5KWFQzemZDNnFHeC9WRTVQZHZ1T0pXckNhU3JIcDNzM2tq?=
 =?utf-8?B?V09nWFR5NUhzL2ZXei8wa3VON2xYb2RUMHl3YmhRMTZEZHRLRFdTSy9yc3hF?=
 =?utf-8?B?WkhkMTZodTdSamhsNGhHVHRRTlZ4Q3JXQytaQVpDVTFyUVJ1UHEyVzRZTWts?=
 =?utf-8?B?bk9sQTh4a2lacXllS3VoQk5VejM5UmJiVkQ1OHh4OVUrSUpFaStuYTZ2YkZo?=
 =?utf-8?B?WjVkRHZGTkpZQkIzWEs4QWs3TU54a3VlYzBVUEdDSVQybS9mTW02d1orMGF2?=
 =?utf-8?B?d3YvZjk3L0E1elBLcjNBY2txaisvakV4ZzZ2WGFFUGV3MzV1MlBhaER2Rlk5?=
 =?utf-8?B?dXZFd0VoRkE4NnhObEkvQzVLcDZUZDdtTUE0RThNNkpVU2dTVUtBVzVxM2dj?=
 =?utf-8?B?N2VSUE0wR1loWVF1WGFsQWtOdkNGRmNvQlBhdzRXT2h0R0U3N3Q5QkJIWFMr?=
 =?utf-8?B?bFFRb1hUUEtkd2RJQ2dUT1hVQkRuTlZBaWhaSGx1MkxvTmJLT1VaK29hWDNN?=
 =?utf-8?B?eDk1WEZXd1lrSHUrNS9mVGJDOTBadkR1V0YvZFFzYWhxbG5OR2Z5ajRJS0Vn?=
 =?utf-8?B?YkJ6eGZrRVBvMEExbHBRMjlXU0JVVmk2SHhWNVFpdm9UcWtzWWVPSFN5NDRK?=
 =?utf-8?B?QUtOdXZPSWNKdUNCd21MVzNjcWpCMVVVSHZIRng4eWhNbTgzK3gzK3JsL0Yw?=
 =?utf-8?B?bThIUHRRdmZZQ21NcGh1MVV6UWl1MVQ5SEgxUzBNQWhQQ3pWYnhrK3hBL2tZ?=
 =?utf-8?B?SmZtLzhycGN2V3hOSTJKdXNvWUVHeCsxeG1qSjR4SXRNaFYxa0hGUFIzRTN2?=
 =?utf-8?B?b3VzdFZXRG8vSVgzTzZNSWw1RG1hKzd0bStBK21DUzV1aE1IOU5WVTR0cS9o?=
 =?utf-8?B?V2h2SFdvajF3UDBWcG1KNGovZ09tS3FWZURlSCtwUXpYQ1BYYzh6eUdIS1JC?=
 =?utf-8?B?SWgvS2w4Q2RWSGFvWTR2OExLazNnNlc2RlI4dzF5VjdjRzBYU29pUXpPN2dR?=
 =?utf-8?B?N0ZqaUdzRGVsM2ZRMVFXWUtTSnAvaDI0d1VFcGc0T0J0ZTFDc013TzJyajdV?=
 =?utf-8?B?SVNRakZVL09adWs0SG9sQUEvbm9HdHRUR2cwR1ZpajdMYnVNcGsyWmUxN1d5?=
 =?utf-8?B?aWNaUDlEcCtiT3JWaWhhaU9tWll4OVFFQ2YwQ1RKYVZ3Wk5LSk9rNXh2ZytE?=
 =?utf-8?B?MTd3bUJUbTF5dlZYSUZLY0U1VEE4RXMwZjh3QWllMVZIT0R1eENaREdXNWhF?=
 =?utf-8?B?TE50TDN5YTZnM0I0b2ZNTDIycU5qUlYrbmNENitDNkhVNGIydGEzOCtUTWJO?=
 =?utf-8?B?dzZvWlJDaGlHN1Z1MnNIMFhrcmVnT3c1S0hLQ3JjUDZFa3htVXFSWlN5ZldE?=
 =?utf-8?B?MHYxVkZDTWV3aFpHYzdESHgvRXhLUkM3RnpvSTJIa1RVSGxOYk5BYm4xSEdD?=
 =?utf-8?B?Ry8zZFlEb0xKOXRYZlZxdWxPdXJUemZOdm41bk8vZjVyQVlxRSthK1l0bzdj?=
 =?utf-8?B?TXM0R1Rha0VmWHI5N2g0UUFnYU9Zb3JNRVBlTjRTRXRBWFFhdk9tSVNEZUtq?=
 =?utf-8?B?bGFHZG1KTVBDVlU0ZGhON3M1ZGt5enc3NEZNeW1qcEVHMG1QcTIzNTY0UmlH?=
 =?utf-8?B?ZDlxZnlqVWtsWmw2YlBlZTFOVHY3U01Kb0tLYXQ1NzlZbnE5YUo3SVF2a0lx?=
 =?utf-8?B?NHlqSWRnVXQzckQ1WHBZWisxbnluVHllNDRsaEIyMy9Fa29NY3dQS3ZMUE9L?=
 =?utf-8?B?WHYvN1NvS3dGdGpGT0FRamxIVzY0YnJpaTBXNm9ScXZHNG9ZRDV3NGpucGpR?=
 =?utf-8?B?VDlXWUoxeCtyWFZiY25YRjVNd3FLbUsweTAvcStvcmh6Q1VIdzVuQTFJQmZZ?=
 =?utf-8?B?OXpwamdCcWp0YTdJMWR4WXljRVRVVGZoSkpUMStqaXdhSllsMERiS1hLWUwv?=
 =?utf-8?B?bjJkUFc4UWpOcCtSQ2ZoUXVGMkcwbU10dWhjYzdaWGFtNG16TDk5b3JFKzRN?=
 =?utf-8?B?MnBLQnBBeUlXSmczcC9tRWVOYWhPN3hCcnphVjZHT3dXazFjWjRFTFZSR2V2?=
 =?utf-8?B?L0ZvaDJpelhzSXdKbGpJZGZLendEUU40UW1GTHZXRi80aHJtQmpyZHMrMHkx?=
 =?utf-8?B?d09nZTZRLzBNMWlyTGQvUWJYd1NoQjhzQS9VdE9uQ1BiN3NveENiSFhGYkVR?=
 =?utf-8?B?eUdjZDh0RFJVbW9zL2pJb3R1ZGRkemZiZVBhWUNoUlQ4REczOUZZUjB6WnhX?=
 =?utf-8?B?dTN6aXhvSlhVMnp1S1lzUDBJNmhqaUxacFN1UHBJRU1XT2NqeEVWaytmYTA0?=
 =?utf-8?B?SnRTdWIrK0kvK1Z0bXJ1bmdxd3NjNHVRbFFQWFFzT3Bad0o0VEdTb3R4MHgz?=
 =?utf-8?Q?kV1755nCgZgoxyxw=3D?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ba5771c-1a5f-452f-9211-08de783aafe5
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 09:04:18.8830 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TbKHUV58zKQ3K5szTCzGRHGpd2XW3DPcmbetOSxz5H3e+/CWTvcFqV9AKJziRNdGZPpn3ypuJe1u4aJPuKPOdAGhafp+cV8b1L8iCIj0PPU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3215
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


On 02.03.26 09:55, Ilias Apalodimas wrote:
> Frieder reports that after the kbuild sync running
> make tools-only_defconfig
> make cross_tools
> fails with
> 
> UPD     include/generated/timestamp_autogenerated.h
> PYMOD   rebuild
> tools/Makefile:359: *** insufficient number of arguments (1) to function
> 'filter'.  Stop.
> make: *** [Makefile:2191: tools] Error 2
> 
> After the sync 'hostprogs-always-y' contains the complete list of
> the tools we need to strip, so the $(filter) command is not needed.
> 
> Fixes: bd3f9ee679b4d ("kbuild: Bump the build system to 6.1")
> Reported-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Thanks for the fix!

Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de>

> ---
>  tools/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/Makefile b/tools/Makefile
> index 0ac683ac3ec7..5d8e8f349e13 100644
> --- a/tools/Makefile
> +++ b/tools/Makefile
> @@ -356,7 +356,7 @@ override HOSTCFLAGS = $(CFLAGS)
> 
>  quiet_cmd_crosstools_strip = STRIP   $^
>        cmd_crosstools_strip = $(STRIP) $^; touch $@
> -$(obj)/.strip: $(call objectify,$(filter $(hostprogs-always-y)))
> +$(obj)/.strip: $(call objectify,$(hostprogs-always-y))
>  	$(call cmd,crosstools_strip)
> 
>  always-y += .strip
> --
> 2.51.0
> 

