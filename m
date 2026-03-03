Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74265EC1451
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 14:20:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AADED839DF;
	Tue,  3 Mar 2026 15:20:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Fi84LYHc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05B4183E7F; Tue,  3 Mar 2026 15:20:27 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B50C2838BB
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 15:20:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fq9i/3I/f9OjcEYIDRyoZc7YAYM3Dxd7UB6qdpZHPfSDkbNrt6BjNlglL+v7Edwv4dNB9YgBIR0ghy87wV0wEyfBoV2FulWg1gBwbHkVet+OXVUngQCnKlq0oZV1/PQHCIHv3hTR7Gmy/qrw25ZTUlM3mQapOl+Awn2vafWUiLCMJ4306j57OWRVTVIFzxhpqRiC/vr2zBnvjETProilnUUAUeKMp/aTmeUTf/Z9fsTOXp1RHuO0LhBiE5+Qd7K/4BW/CumNKn5aN36TcfJNTtcWfuEdrODk8srT6pvPuHPwtREyvlNxziqJFY7oNqh8jMN9u1yky4yLpxLbcW1iHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sHwcML2+Hif1pO8Gm329aC/uI1iEiBT/BT38RmSEsbU=;
 b=nPQi1KT85m38IOEmp76NTPW4ItDEzshiGbpsBzbJ2BHuNXLwH/775auFuYNdkq9I8x0qqqyk9A6ke4WX+m1qt/bUOi8JhxLcGsviHsLoR51MkqL/e0KrTUjPjmF3BbTAkEnCxaSYnVa7wQaWnyiPH8mMX9+6lQlUDQi1zyEvKrf2XZ0p/NSBB7Pv5xp5HOiureyOs10z/pAUykenjHSOgTtTBO/mSQe26lfI6nqy5XPeR4oD9u713sxkheqJpKaWp6l0NrJY+krLFzFV9nisk9uW3aTFm3bweSQfrT0vKtrNcp5kXvfENMO/Qx5pTzv1V1knN5HMIjxm8V1kNeB+sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sHwcML2+Hif1pO8Gm329aC/uI1iEiBT/BT38RmSEsbU=;
 b=Fi84LYHcJ1qLgG8IcqmXH2Rq6PBDwIPa4QBYXkI/xnAo82A4CIuqYM+khwk/cFEmaXpWXYw6QAjL7Uei+g+31VhQYOY0tDaelMGLCrtzkJoHpkEoinbQk/+usViHstsG7Ighx3OXv7qLerQ+sWwj8x7DUqx/fcMmSVoR1YwQkTo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by AM9PR04MB8382.eurprd04.prod.outlook.com (2603:10a6:20b:3ea::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 14:20:19 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 14:20:19 +0000
Message-ID: <e047fe90-4266-40af-8e27-58ec5476886d@cherry.de>
Date: Tue, 3 Mar 2026 15:20:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 07/16] binman: test: Move security test files to
 test/security/
To: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bryan Brattlof <bb@ti.com>,
 Michal Simek <michal.simek@amd.com>, Neha Malcom Francis <n-francis@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Philippe Reynes
 <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Yannic Moog <y.moog@phytec.de>
References: <20260226234802.345968-1-sjg@chromium.org>
 <20260226234802.345968-8-sjg@chromium.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260226234802.345968-8-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0057.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::17) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|AM9PR04MB8382:EE_
X-MS-Office365-Filtering-Correlation-Id: e974821f-82f8-4ea3-2fdf-08de792fffe5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|7142099003; 
X-Microsoft-Antispam-Message-Info: 6Yiy5L7AkjSl3Bv1J49tsOOT2JDbO9erFOHuPamuYuDj9o6xd4b5HkMrib7xL1Axyd4TMZM2KbzeVJ3bJFdxdELYr7dMfeJ+RNehJwYVYE4Hn5ik1g4xpvP5YIe0pxcz09KLCxzL6BWKXQII7YsJaPVwB3SE599q/rwyyuS6e+lEqJAEH/fB38wDtt4kES4ks89NIokpvtDR5VXhUyWylKv60xiMZMwbeozGWfCJfOgatgybWpkUEYKHe67PIdUAZiBt2gFKx+dzamOTpyHnez6Vi5tt4vldCcZM8dVS+AFj6FfMhHL7a9vO6VqHXBfzes4HRlJv9cPP1VkCY3JnqJTfcIsFgPxcGcgvqBpJHmfJfLiRvxV9zfCYjb3XHXQoBczUXvZcnoh5XVfYgQpYIS09H0JbbIHtMkb6QUrzN9bkY/7amMDgEvEzPMYcuNiaTITbMJ2mehsv+SnoA8Uh3AN3cOwJrwdUozyqk4vWjx+LRiHzjp3NxXu3ZuRzvGo9G2KaUfRy/enFM5CIUFbeIJo4bzl0aVhHBxeSm+pK9rzNTyjpfj1XoORd7bXxCt++zm/dyayY3AYJRgT+6CX3ptc36+B/QuNEoHRus//1rbAACPoI7cWHFXYMRLro4lu0Z2XicQBq6OE+e3htO2/VIlvgRv1b13ygRx6TcaXORIAe441vrpsKdc7wuug/5/HCDrjWNqzG4rYBIR1acAKsgiYwhgdLwh8LpvFR9FvyWJw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7142099003); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVVwYVZ2c0wwcUF1cnBuSEtzNmJiUFlVSGU1MGZjNStyVTdhQ1hGc0tlWWRS?=
 =?utf-8?B?T2tHWmVCS1EwTTdkKzFtM3doaUdQdGE2L09adU44eWlncDlPRnlsZ0ozSHFx?=
 =?utf-8?B?M21seXRhQ21mVzBEaVh6VmkxY1V5ZWxqV3ZEdnkzQjRBRVNCdjd6ejZ2N2pa?=
 =?utf-8?B?V1pVWTlsU0QrQzdtTGZPUTFkVGV5TjJpK0N1TmhyNFYyYVpDdWVzZVJGempF?=
 =?utf-8?B?VkVST2VnK2JsQ2xZREpBVjM3UXp4NXhvWEkyK2Zhb0R5UzRPMjh2S0Y4NWFQ?=
 =?utf-8?B?VEVkUGRFaG5CSVBGc3NocS9WcDJrb0Z2V2xJMlRWTjZMTWNmaFh0ajQyRUVP?=
 =?utf-8?B?K2JhL2pTcG5QTkMvSjFlN1ZkcWFFamc3SUhOektxc3kwbG9oMVRneWJKMzRU?=
 =?utf-8?B?UjRDOUNqL2l4cUhPMnNJTlUrU2svWUFaYTV3K0pTdWVuUDlrdmtOY2lZU2R0?=
 =?utf-8?B?ZXdFVmNwbEtScmdqMFF4NDlTN3pUdHBkOWtPU3F0RUJNTER3TzVoeENoVUtY?=
 =?utf-8?B?WTNBdUNjaW0rYkprbkFpNXFUS1lYY0NvcmFSclhxdDFkVHZaZHlNakNmZlhV?=
 =?utf-8?B?cDBoK24xcWdVWnNlSTNzOElxVGtPRll3Q3c2aW0zUHAyUktoMXZXQUpOekRk?=
 =?utf-8?B?STRMeENKcnVCTTAxWm9CMUszcW13cTlTRFZXR2kvYjlpRDVNOW9ucmZCbStu?=
 =?utf-8?B?c2RpZk1OVzljaXQ4YXRNZVJQZCtjWVgzUlFnMTdzQjVFVE53YnpSYWMzMGN2?=
 =?utf-8?B?S2FLeThYeVg5cGxZUmpTSEQ2cmgvNWFOM1dUNEczb0VwQ2Rrc3VIMi80VFNa?=
 =?utf-8?B?T2Q5aE1acHdlODBrckQrbEYvVEZEaDIyVzQ1LzBKNTFlUTFEeVV5UDJscEZS?=
 =?utf-8?B?Nk1naUFqRENuVjc2clB0bW5VL050emtvb2MyL1Z0Z2MyRG84cU1jSGZ2RUox?=
 =?utf-8?B?SDNaakJ5RUJhN1VKdGptOEJzN1RzZTV3RFNzWE44SHRtMmkvREVybjJNZTRZ?=
 =?utf-8?B?dUF3VFltSW9EYW5CdCtZTVdsLzVPTlFaMEt0TlJnZFR6M2VYcVdKMEhBeE9w?=
 =?utf-8?B?V21aMUFMVkEzbFV1Zi8xVG56VXNJVDJGeXJ4blo2K3ZGQ2lIM2ppUFpnVGtJ?=
 =?utf-8?B?OXp2UGszN2prMXJJRnVha1owUmZ4cEh2TkNlTXlxMGsrV1lVNURLUmhrMUpo?=
 =?utf-8?B?b2p6aGg5M1VhS0RwWTNIRzhHQ3RhQklGN1puVW1pZUpXOGs2RUNXTDRiWk9N?=
 =?utf-8?B?d2FUejU0UzBPcUd5SGttTk13WUw2VFJzdnFlb28xUTg4S01xbndrN0VDcUhM?=
 =?utf-8?B?OGxYaDNyUmFVY21RZkZSOHhWNE5ybjdKWGlBMG91U3g3cDBKR0RXekl0TEZ1?=
 =?utf-8?B?NXJ4Q3FGS1JTNEc0Qkt3OUI0S1FLZFNoZDY3YSttMHAwVEE5KzU0dEVvYm1T?=
 =?utf-8?B?a2FLbmEzYkNmYlVZQzc4VDdkcHRyUTdiekp1bk5mNWRhbjdUNXRZdy9OT2Z0?=
 =?utf-8?B?LzFPVGlxdHRhanNQSTcyRjR6K2Y3Z2JkZW9jZW9VTnBSc2xad215TUtwOVpu?=
 =?utf-8?B?THlESm1JZ01wd21wcEhCSGJGUHVjRjZxdXVkN1Y3YjZNeHFzemowdlFVK1RW?=
 =?utf-8?B?VkhUaXlnS1hyS21ZdzBMWk54M2Q1bXMrU2kwbUhJdGgxQVRpR0IwUDRZc0M2?=
 =?utf-8?B?bjU0VzY1aTRFS1MzeVlEU1J4VzREQnBVb29NdmRUODVvVmJiTStCbHhNR1E1?=
 =?utf-8?B?Q0NJRWpMa0VpOUV0QS8zeFE2NFJpbGtGSkxxb3ZnNWdkQ3hBQkhLUDd4dk1Y?=
 =?utf-8?B?VWNsYWhhYlovbVl4eE1WVEdPV0hJMWFUQkdvVFE5Qkx4L1ZDM0ZCdFdaRnJN?=
 =?utf-8?B?cjJlZ0xreldjL2xwNHZ5VUtnS2w2SGVsOEM3UWptRG5HeTJiMmVHZGNXelVP?=
 =?utf-8?B?ekZxaithRE5BeTZPNW9QK3RhUE5GRkVVTTlTRk11RzQxQlRNUGlBTXpnL01j?=
 =?utf-8?B?c2htdEMrTDRSRDNYOC84QXh6QmdNaW1XRjIzU1dUcEloSkIzZklacGZybkRh?=
 =?utf-8?B?aExmbXBkMnY5b3ptdFhndWdHRU9PeGliM0lnOEVtOFMyY09melAxMUhJTlBP?=
 =?utf-8?B?NWN0cUpRTTJrUUtZVU00K1JHMlVYb2dzUEN4Yk4vN0grOHF2b1JnRHJweW93?=
 =?utf-8?B?M3lmWFF6N3Z3VHFNSk8zZ3gxUjN2dThwSmd0TVU2RTBsY1V3dzk3dW9CZmNq?=
 =?utf-8?B?ZHlySkJvNmhZeklWMDZtVW9pOVFSd3F4bjZKQ2FBdHpTREc4WmZMVjFXcCs3?=
 =?utf-8?B?MUlmSTA3Q3ZaNVNCVDZIQkZGNWxKNkozVE1Qcm5MOEI5Q1RoMGdNdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e974821f-82f8-4ea3-2fdf-08de792fffe5
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 14:20:19.7818 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JwRz7M0X0S70chp5xH6ZpDOldi4SmERNAQhdtHEtSb7QVLy3aBInpJIwRdsrS+DERWjlMRXcxIlmMYbmI9b1PJaPpjwPSs0brsdcfxJJ+AU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8382
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

Hi Simon,

On 2/27/26 12:47 AM, Simon Glass wrote:
> From: Simon Glass <simon.glass@canonical.com>
> 
> Move about 20 test files for signing, encryption, hash, pre-load,
> x509, and Xilinx bootgen entries into a security/ subdirectory. Drop
> the numeric prefixes and update all references.
> 

What about key.key, key.pem, dev.key (seems shared with tests in fit/ 
but duplication/symlink should be fine I guess?)?

In a separate commit though.

> Signed-off-by: Simon Glass <simon.glass@canonical.com>
> ---
> 
>   tools/binman/ftest.py                         | 52 +++++++++----------
>   .../encrypted_invalid_iv_file.dts}            |  0
>   .../encrypted_key_file.dts}                   |  0
>   .../encrypted_key_source.dts}                 |  0
>   .../encrypted_missing_key.dts}                |  0
>   .../encrypted_no_algo.dts}                    |  0
>   .../test/{090_hash.dts => security/hash.dts}  |  0
>   .../hash_bad_algo.dts}                        |  0
>   .../hash_no_algo.dts}                         |  0
>   .../hash_section.dts}                         |  0
>   .../key_name_hint_dir_spl_pubkey_dtb.dts}     |  0
>   .../pre_load.dts}                             |  0
>   .../pre_load_invalid_algo.dts}                |  0
>   .../pre_load_invalid_key.dts}                 |  0
>   .../pre_load_invalid_padding.dts}             |  0
>   .../pre_load_invalid_sha.dts}                 |  0
>   .../pre_load_pkcs.dts}                        |  0
>   .../pre_load_pss.dts}                         |  0
>   .../section_ignore_hash_signature.dts}        |  0
>   .../sign_non_fit.dts}                         |  0
>   .../spl_pubkey_dtb.dts}                       |  0
>   .../x509_cert.dts}                            |  0
>   .../xilinx_bootgen_sign.dts}                  |  0
>   .../xilinx_bootgen_sign_enc.dts}              |  0
>   24 files changed, 26 insertions(+), 26 deletions(-)
>   rename tools/binman/test/{302_encrypted_invalid_iv_file.dts => security/encrypted_invalid_iv_file.dts} (100%)
>   rename tools/binman/test/{305_encrypted_key_file.dts => security/encrypted_key_file.dts} (100%)
>   rename tools/binman/test/{304_encrypted_key_source.dts => security/encrypted_key_source.dts} (100%)
>   rename tools/binman/test/{303_encrypted_missing_key.dts => security/encrypted_missing_key.dts} (100%)
>   rename tools/binman/test/{301_encrypted_no_algo.dts => security/encrypted_no_algo.dts} (100%)
>   rename tools/binman/test/{090_hash.dts => security/hash.dts} (100%)
>   rename tools/binman/test/{092_hash_bad_algo.dts => security/hash_bad_algo.dts} (100%)
>   rename tools/binman/test/{091_hash_no_algo.dts => security/hash_no_algo.dts} (100%)
>   rename tools/binman/test/{099_hash_section.dts => security/hash_section.dts} (100%)
>   rename tools/binman/test/{356_key_name_hint_dir_spl_pubkey_dtb.dts => security/key_name_hint_dir_spl_pubkey_dtb.dts} (100%)

This also depends on 
https://lore.kernel.org/u-boot/20260225225040.2568118-1-sjg@chromium.org/.

Cheers,
Quentin
