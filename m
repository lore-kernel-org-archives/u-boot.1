Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EAEECD98F2
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 16:51:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE77380287;
	Thu, 18 Jun 2026 18:51:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="bOL8JCEV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 499538056B; Thu, 18 Jun 2026 18:51:08 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FEFB8005D
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 18:51:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N3py0troYIHpqqAqxi4PT2BfrBXVPEp0+zLetuDNjGSYn7q4HaWamyONVA4Yx27OI8BEpPz4vKkWqWehGNgyZt/L1IvisasnvWFcagC3tYH3LL2Rg23zEiKLFfYfnKQAUs42MufsraY3nLb51eJKBzS3U3v/jzEPBUHBQDO+EnENkJutrpXuwXv5Z0RqEKPzZdGCZucOWJDLihVw4TFgYFYibppTWEyl4P9VwFIwghM/TKSOieQdb/apAIMwPIQDrqSXqozRqj7Q5jXvd94rL+TbnADDbEs8832laLf5oKkJ+RlBCwdeBzQCeyzirAIJRptswoXVYht0ZSCyvx8iYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ORDYzvaqg3zQca2ONFMhXpmVX1cqLgzF53ogxu2PlaY=;
 b=TAbi/s3jGdyzj5m5ybE7rpJpqlWleZK0SyeWsH+y75MSWKcYQJqAWw02N3FyQrsRhMx0cQ8KcQZqjZPYk4AUphUDquhtX+Jc/E1sJoe+8Xx9oXK4J3l/R3riEE4IhznMf7uvL0QWviVL71ZFeHOHDYMULbe8kIAyCrp1Ufx9q6EKX1aphhw43NygMWOuwv6D0CvpUjcwMpC26u1LI2ptI2tyW4pM2ilIzWmByb+1RL7JJcG/nT09bjv/qgHIPIovsn4vC7PVGwF01DVuNibAE/5T9oIIgS6iOucfELln8xZXbuskA/11ujClUzg6ft1Je3bFO4NoNLr0CgI/A+q62Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ORDYzvaqg3zQca2ONFMhXpmVX1cqLgzF53ogxu2PlaY=;
 b=bOL8JCEVw5VMR73RHJek4LVwAc/XBHaCxRSCsS4lp6MF599KeF82NX3wFu8nXHYfEn7E/+Sn2RfoXIcWcLEjZFPcutWWFx3habvzu69uYxWIsOHxkBmuNrqJCTT3eMQolZMJGXU0A5xnMQbo33TSLUzYeDr+30HN8+fhqJb6bLw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com (2603:10a6:102:b8::20)
 by PAXPR04MB8096.eurprd04.prod.outlook.com (2603:10a6:102:1c7::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.13; Thu, 18 Jun
 2026 16:51:03 +0000
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7]) by PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7%6]) with mapi id 15.21.0071.010; Thu, 18 Jun 2026
 16:51:03 +0000
Message-ID: <09c695c9-1786-4232-889a-6696e4a0aa86@cherry.de>
Date: Thu, 18 Jun 2026 18:51:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] binman: x509_cert: document Entry_x509_cert
 properties
To: Sergio Prado <sergio.prado@e-labworks.com>, u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, alpernebiyasak@gmail.com,
 ilias.apalodimas@linaro.org, marek.vasut+renesas@mailbox.org,
 sughosh.ganu@arm.com, wolfgang.wallner@at.abb.com, bb@ti.com,
 xypron.glpk@gmx.de, y.moog@phytec.de, afd@ti.com, Wojciech.Dubowik@mt.com
References: <20260525132828.3348679-1-sergio.prado@e-labworks.com>
 <20260525132828.3348679-2-sergio.prado@e-labworks.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260525132828.3348679-2-sergio.prado@e-labworks.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0012.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::22) To PA4PR04MB7743.eurprd04.prod.outlook.com
 (2603:10a6:102:b8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7743:EE_|PAXPR04MB8096:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dddfd9f-8d5a-4c48-8449-08decd59c88c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|7416014|56012099006|5023799004|11063799006|6133799003|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info: xH427aNJIpGWVBQ46/9ZJSURLyH4JdQzdqVao7lAx0QuuaaiUHuhtJNtrYIh82nqgvfJxUTRrfc3MevKSfyAy65wFWGltV7RI9tUo2tUdat5f+C0xxvPBKg5LVrK1fOs6yz3PmKwYUjCdMhL6+ulyVrOM9TzzSkc/wWgMxMTDy7at4fcAnEp+dQQoo5GP2KTl9E0Q1idT2T0LGH6CimUDivWVWfojRHyg0fEWeAGyacw+eFOkXRtzfwhVX+T1h4yevao59iuZ8ACmuxGYWiEWZxe29h4yhbGp4TOidwRwESILNN6/ipsaCURG5pFUfPqrsm+GyNGZyfRTmZK+OB952j3LVtBJozmZ5GThgzH4lezJr2Na/oLDgqriwgjaaBMgKtTvUTrmHcBp9TXZUpEyO4M7MqQEBcah8kyKzvJSiZJuqDWgvXLX9bAPH6r1udn0RgP5egzMOT+WigmSeiGZySfjlAAATvuv1a2XCWt5YSV6G/0fUS9GrbjoFlE/2MDXT+s+OK5sCeB9x7oMKdOobXrEdAI+r5eG2J5ySIDcVxobk2GMyh+ESrEEMjZCahfUbNLtDa+tC9tqO4R06pIUDtZ2+/4XLpzbkLOaf3zR/x3fRlzfFEBbWaMAIbrHYQRlvpfrGkhk4uTNGqeOW+DbcB2SiU1+o4bByby9P1hX1bOPu1fB8nwh2KTdf/LejY4
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7743.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(56012099006)(5023799004)(11063799006)(6133799003)(18002099003)(22082099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUxsZzQzRlNvbEdPb2RLbXVUMmRxcHdHOHcvUXRwZk5RR3RibUpVWG5JdFB3?=
 =?utf-8?B?Y3pUQjFFc01qcjJiQzVMYWcwS0piNFpFUUVhK2lYb0RTUDlmWjNVKytERHJO?=
 =?utf-8?B?NzNlWXBrdVp2TGkwN3JFVldGZElMdzVWb2NxSkFqaEpyakpybWxoRFVhK2Iy?=
 =?utf-8?B?cVE5Z3dTRDJTRDhMR0JiZW9zc1h5UUlyOUxzbU5URXoycGtNVUdpM0YwU2Jm?=
 =?utf-8?B?RUgvZ202OE1CZ3ZCalpjV08vZ3VrVGwwNnhWOUdIZjJaSUpYdkcwN0JEM3I1?=
 =?utf-8?B?Wjg2OVlMUGVmUGtwd0VVaGRwLzI3TmExK1A2Uk0wZFgvK1lPRXlrRlkvRW8w?=
 =?utf-8?B?MllQZm1BSlJHc1doeXZIYUxvb1RQVmZwYjl2UjN3SDg3RitNZkVGdnRuU1Fi?=
 =?utf-8?B?dERxdlNwWitsNFJiYWVrQWxZY2llUWY1UlRsY0d6cW1sVHdReGRya0xqVFJw?=
 =?utf-8?B?UFF2YmduNElqYmhLZXZBTGVBTmFsWThySCtTT0ZQK2FoWWJPa25mUFdKNXIz?=
 =?utf-8?B?c25lNXRnMEFMUnY4UktaUklhS0M2KzhLVWJGQmZsRFpUVGdpOTc5akdNcVV1?=
 =?utf-8?B?OXpkdWwyb0NHczBqRWVCK3Q4d3Y5UmRyOXJwaUhpMENhelNIblh0cHVpL3Vs?=
 =?utf-8?B?Nmd1NlhxcVlpcERKemFucDFWOExiTzdBYjNWWDFpNit0RS9WcGdCdVFCcVUx?=
 =?utf-8?B?dGtnZU5XRHkzVGJOOS95RnB6dEtGbmx1U3o1WGZaVHFXaGs2SUdKNmpBOFVW?=
 =?utf-8?B?ZVI5TmhpQ2pxNWtBS3dZT3AvTlVtYWZlMForY1F0RjM0cW5zU1BPVkJaU0Z2?=
 =?utf-8?B?N1g1RkFjNnljUmp4Q0lmYUdNaHEvSFVlQVo1MkgxSW0wUzRyc0UybjdSQWR2?=
 =?utf-8?B?MGYzc2NmVE5kZkR3cS8wV0NtTjF1ZjM1cTcwb2VHZGF0QmhlZVhUWFpaOUc2?=
 =?utf-8?B?VklrYzFyTm1pUjF5R0hrWFBNNVBMZklzV0Z0U1JESkFHK211eFZJcHRndndK?=
 =?utf-8?B?RDJUYjQvWU5VMlcydXdpVzBud2Q4alU1NDM4TklmZmhJQXBmRjBsMlpuS0Nx?=
 =?utf-8?B?eGU4c2ZkaHhMWGZWRHFVYXZ2MUVFcnhsaU5ubFU4YWRnbC92ZG1uVXhyREVR?=
 =?utf-8?B?alZwclg3dHFNN3dUOElsSk5ERUNTdGIzRTEyWGtBZjBoTDVDS3VSNm1IbVVu?=
 =?utf-8?B?aGZvcHFKdWtRY0hyTTFmWkpZeWVWcXJrWUZHRVNBdFdYWjBOTzVudllacDFo?=
 =?utf-8?B?NSs3S05DTVQzUjBJeDFLdmFZNnlJSFM0RTNQeWNxNCsxaEsrckRXNFU5Z2xO?=
 =?utf-8?B?TnNPc1NLbjdIYittR0I0eDU2dkhLb2hlVkllQ2VZcUQzYzQ0Z2NNZFJLNzZS?=
 =?utf-8?B?WFNoNHpWTzhzRFhxTXorRWZYa0RvcFdoTWp1QUw5c1ZFM2s0MFp2V0s4OUZh?=
 =?utf-8?B?TlFBZ2I2a2NycENqcml4bytBd1c1ZmdmWnlFL01zZlFrS2FqYVZ6MlNzTmFT?=
 =?utf-8?B?NVFrUFc2d0NSYXluWTUrQWRENU1hek1ab2tqWWM4R1RTQ0lXL0lnNUg4Q1k3?=
 =?utf-8?B?cjFSbkhSSWlCVWRUaXhvYXNzR0RmV2JiTnU0YlB0N2VtYlBvZStLMExZb0Ru?=
 =?utf-8?B?NXh5Q3FuV01LTDZJelhjaFBCTFBZZE1KYVl0QTZ6b25ZVkV0dklyRWkyaE1u?=
 =?utf-8?B?WVZpaENGMVJiRFZVWjM1T1FXb0l4ZlByRjNrZVlmQS94NlE1d0MrZWZwSkxR?=
 =?utf-8?B?U0gzUHIrK3Q2cTVjVCtVQXJNcURCT0tFWXFVUkFZZHMxa0d6ZXIwRDFCVUxL?=
 =?utf-8?B?TTZReTBWTjBXYzh5RGF5TUUvaEFXK2dzK2NYS3J5VWI1Nlh4VUdVV2QrK2ht?=
 =?utf-8?B?eUYrYXRnalFWNXc5WVRORUl5a0ppSy9MRS9TbTNRTWxESmxPSWxjLzhCSGNR?=
 =?utf-8?B?SFd5MHVQL3ZDSlA0dWhNbUUvZnp4YVdvRGkxOUNJK0Y4R1VIVzVBSm5QNGh0?=
 =?utf-8?B?YzZQbnpzR1IvNlZldHJpOEptT0tCUWllU1BIZW1GMkVqYUJmR0Q5bDIrWHFY?=
 =?utf-8?B?djVmRjZpYUZkWDVFN1RQbHQvUFlzQ3Z3OEd3UE5QOGpNODZrVFBCd25uZ2lN?=
 =?utf-8?B?NkZkMkJKNk5EZ0tBS2dyczViMG5DbDFPSHNJYUd2a2JCZm94Rmk4SXhwdlha?=
 =?utf-8?B?aGppV1BTVm9SV2NJWldKQitPZWIvNzVyMVJrczM2b29QdXBnUk9XM1BhL0JT?=
 =?utf-8?B?ais5UFpPbnlOcFMveWVOQlRhd1E4bkxYRlRKMHJJNXlmRVVjdk5rVXRpelF2?=
 =?utf-8?B?Rk5ZYm9kd2E0TEhCNlNseGYyak5xTWI2SFIvTTZ3M2JGT2M5RWVFQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dddfd9f-8d5a-4c48-8449-08decd59c88c
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7743.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 16:51:03.4760 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j2zkZqQ45kaN6HLgItEaekfySnRzlXjw48BeutpVWdKDFBPrFv/drOK20bRaiXEhIxPcI65Hq6x7il3M4WxYNdUkplzcmMeKsk9yNnE3wSs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8096
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

Hi Sergio,

On 5/25/26 3:28 PM, Sergio Prado wrote:
> The Entry_x509_cert class only listed 'content' in its
> 'Properties / Entry arguments' section, even though 'keyfile',
> 'cert-ca', 'cert-revision-int' and 'sw-rev' are also read from the
> entry node and passed through to openssl.
> 
> Expand the docstring so the binman documentation generated from it
> matches the actual behavior of the entry.
> 
> No functional change.
> 
> Signed-off-by: Sergio Prado <sergio.prado@e-labworks.com>
> ---
>   tools/binman/etype/x509_cert.py | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/binman/etype/x509_cert.py b/tools/binman/etype/x509_cert.py
> index b6e8b0b4fb09..efa85f9553e7 100644
> --- a/tools/binman/etype/x509_cert.py
> +++ b/tools/binman/etype/x509_cert.py
> @@ -18,7 +18,15 @@ class Entry_x509_cert(Entry_collection):
>       """An entry which contains an X509 certificate
>   
>       Properties / Entry arguments:
> -        - content: List of phandles to entries to sign
> +        - content: List of phandles to entries to sign.
> +        - keyfile: Filename of the PEM key file used to sign the binary.
> +        - cert-ca: Common Name (CN) embedded in the certificate. Used when
> +            generating a generic x509 certificate.

You know what's funny? This isn't used at all. Parsed and passed to the 
openssl bintool, and it does nothing with it. I bet

CN                     = {cert_fname}

should actually be

CN                     = {cn}

and we probably should add a test to whatever's using 
tools/binman/test/security/x509_cert.dts to actually test the CN is the 
expected one.

> +        - cert-revision-int: Integer certificate revision number. Used when
> +            generating a generic x509 certificate. Defaults to 0.
> +        - sw-rev: Software revision number embedded in the certificate by
> +            the sysfw/rom variants used by the TI K3 secure boot subclasses.
> +            Defaults to 1.
>   

Sigh.. It seems like cert-revision-int and sw-rev are actually used for 
the same thing, just with a different default value.

It'd be nice to send a follow-up commit either fixing the non-use of 
cert-ca, or remove it entirely. Not necessary for this patch series though.

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
