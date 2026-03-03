Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1433AEDA68D
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 16:04:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED1CB839DF;
	Tue,  3 Mar 2026 17:04:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="hE6Z50jG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCFE783F7D; Tue,  3 Mar 2026 17:04:10 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F9CA838BB
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 17:04:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ffkr3nz4LsznvKsdwJLnCHvYhdzJTdakO6XYI2iwgjzBT3Gx6sOtiZJgteX+j3WURSnFJiHZ1Xtt1xQ3OkSnT9wfR1UnHpIm6Y9iNiGI0gEi+FiWlX9IVztcVX4CZsaH35nrlNyjML+Y4V5joZYO21piwRzDTRg6dHDcvCG4PQbrJqVtm0AjyQErJA5yR60FAt4mRHAeZ6BzmjCqkUJp1q/eka72ohqpMjnSAwrzCeuwoNtL7neHgU2CUwdsS0cMXJbGVqr/rnMKrHzwx76qkwgijrc6pUPzvPk6/sheMrqDwie8NAzztWEPecH6bY8PupVqIdqUTYC5tPf2EPb9Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fWZjPRrg5L2Mg7yuHm0fjPzvM+5TQt48UwQo3M11elc=;
 b=a9PBAR9Fga3fE693CA5UyHQRdJlqOW8x+gmG5m8d4EdSiDhss9drN0EtulQBgMoV1mREQbhUcr40p5zP3LNP6m4a8RO8SkPzjGsdBQcXtagC9VVzzHE4POKrboabniL4HId8+Og5ORx5TzvTaQN/9MqOWRl/1ebPI/REYoAIbtNfWMQVwgrdur6o/7oQyrecL6fD/taGn/WI9OTpR1tQolOmscBnSvq2DCpeCDXgOWQOW35TSjPzOhemRhyY/dxdD/j20T8i6XUbTBNAfcWAAtOxKqHKdVyhRplYWGzTmqjglz5sh32DJoP6/Q8YyW/uEonGkycF/ouuGOFHBjCW3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fWZjPRrg5L2Mg7yuHm0fjPzvM+5TQt48UwQo3M11elc=;
 b=hE6Z50jGJ/Q2/V9q8l+xnD4L/yQDOQ8ojuUjWlmTmSv1Nnbv793jiSWDyufJ8dZwGgTwcqd0giAxOtGskxtw/dTcebyc8vlxw+n5GYJetFxSoeQ7Jl5KzXd7YSBcWff67XhyvfJZFzBzp2S2Am1yU09i2bN/m6t5umLkTy1XMC4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by PAXPR04MB8576.eurprd04.prod.outlook.com (2603:10a6:102:217::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Tue, 3 Mar
 2026 16:04:06 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 16:04:06 +0000
Message-ID: <cd06e974-6efa-48fe-8b18-d776cf9c465d@cherry.de>
Date: Tue, 3 Mar 2026 17:04:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 16/16] binman: doc: Update binman_tests.rst for
 subdirectory layout
To: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bryan Brattlof <bb@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Yannic Moog <y.moog@phytec.de>
References: <20260226234802.345968-1-sjg@chromium.org>
 <20260226234802.345968-17-sjg@chromium.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260226234802.345968-17-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0198.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::19) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|PAXPR04MB8576:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f4cf05a-6260-42f5-2835-08de793e7f4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: lxOqYiOoViSEmeS9yeMgEMVqyOa+hk+yj4dgUtpX3goYvbLsQk9gt2zHb26duombMhAGaSbZkp8Za+0eSUOz5lpWFrh+wacmYin5uqNHUnzjQemi2B9k0Zb4wt5xdNdnclhD1enaVekAV1RSfYwMzikuEBEa1W8ucYq9R+usp0ZP9b5x8kdCxvfAFVRbvT8THk3krFqIA0G0qUlx4Z9T+mzxR4yTjgPiDScKuds9SLIQRe5x1EEbRXxKysldsNxaKKYmOmHP7UxelHCrgvxq+PgrFz6yNpmeTqoEuCsdyVdmQuN4lvg29adIwFYyFmL2qcUjZ79a8RVNaPXFWZlluT2TNdaUwkeclMHJs4BiVoDQtJqLj5op6pAGW3KGPk46u/3hOqbxqv0GbKjgHW1nykjorMAO+ktrC/7P3KGhaYdPmpZUbiiD9nNgBuQ/r1DmS9dBxXrqzSFsg6uxbfmRT6fG6Ln0KI896wqdP3nSFCOnbH+ZdJtjhbNMBSVGfHaUZMJ8iTVUqazq4Qcff1Z9J139g69wRNi7zllB5iCyLpDgj636rDTILPryvnlpcy8+qervpjiV23ApJjtl7FiCIGXqMXAg42iVZKm0G4KIr9n8r3RhqNLfQw/0qcJHy6BM07HCOVFwj6UhoXoMHKtER/S8AjP3+nYRLjTCGoXXrprygw9Zym7b0cnf4hAiu4uqPHLh/w7HxtuF9R6YHopZeJvQvNMs+N+vu9pdWbbyCl4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUxteVpGZmxFd3RXaTN5NW5CdTRpRWwwRlVFZjI5dU1ubno4Y3VHU3gyV0Jw?=
 =?utf-8?B?azJxRDZhZTA5NEVmeWdZNmVDK2lMZGNpbVZvTk1kQit3YlAvZTJSYVA1RUM2?=
 =?utf-8?B?aXNaRTZFZC9FbkNCYTBTejdBaFViQlYvK1oxSmIvQ0U5VS9ybmFyc2ZnWWZU?=
 =?utf-8?B?dkNHQ2VQSE1WLzFhUzE3YjB4b2RZOWE5U1h4T08ydWRvMW5IeXp0ZjZ1REll?=
 =?utf-8?B?OVVSWG5xOUJTQzBJMkhHQjhOWEFXTkg5NzQ1R09MaWhiZDI4cy9xZ3o5Qkth?=
 =?utf-8?B?QWhsYnNuK2licmJUNWpBVWtNc2RyeU5KRzI5WmZaTFp2WWNCK1NhTStaQytN?=
 =?utf-8?B?TjJtUldHUFp0eVl0UG5VcXJ0VklrOTlXc0NjQjkwUE4zV2I4NHZqSlJ3dFV0?=
 =?utf-8?B?WnoxMmkwQ05BVEh4bSt4MjByY1NaNmo1Vk5YQ3hBcGF3d0k4V296Nlg3cmpO?=
 =?utf-8?B?MFU2RDlBOUFmdWpwbHljK0dFVDVGeTlBRWpzVy9XdDVicjFnay92YVcvK24x?=
 =?utf-8?B?T2tCdFB6MmFaaDcxNzVxajRYZkRVbWpSWXNNU1pDNEpnaWMzMkxNUjByeGtK?=
 =?utf-8?B?bXlZeXE1OUc2eFRNMlVMSVZRdzdaRGk2QzA0Z0FiY05OTHZjbm9BSVFjUVp3?=
 =?utf-8?B?WTQyNkNybElwbk1pem9XeGhrN0doMTd0RnRTYjFOd1QyeGxTWngzRDJmWXZk?=
 =?utf-8?B?Ny9sVFpHZDEvbkRWTkt1YUtNNll3TDMwc3g4RVJMWlRSYjRoaTl4cVk3VUsy?=
 =?utf-8?B?RVJaSFZpSkxoeGZoMjFFamREZTlINWxjTGh5eHVtVEdMNm5NbzZPRHdzVFNn?=
 =?utf-8?B?cjc5bGZZb2IrQzdlSVpCS29ITzZ4UDBnaTVyb29EWmFsdGZ2R3BGRS9WSEZG?=
 =?utf-8?B?bVpmNHpWZndOb2hQRWJta21Wc1pEa1AwUSsrUGhmTXhQRXMvcVJkUGswOHd0?=
 =?utf-8?B?OEdOa3dQL2J4Z2duSVhaNHZSTk1nTEZoU2puYWRKaEpBNjhka0hITnhNTHlX?=
 =?utf-8?B?ak9pRStHRFZ1R0MrNUJUb3dtbUVCL28yaHF4VVhNMjRTU0c2MERvNUJRalY1?=
 =?utf-8?B?eUJLZC81NFVlbTJwWFJPZGZqZkVidU5KTmpWRkZOQllaY2VLRUZMaWJVSzlZ?=
 =?utf-8?B?bnJSNTFvcWdyMlEvTi9ja2F0R3ZBM1pzS0VZRU5wWHprR1dENkkxVGdhRkdu?=
 =?utf-8?B?UTE3a3JGS1BpNVh4T2FOYnV4Y0Rlb0l4a2t3QjhHb1RTQXFWTVBYVGE5WmlL?=
 =?utf-8?B?SlJ4OVRLUlpjU05TdHNsbk9oQ09rTG84RkxEbFdSUldodDFJRm1iUkdzOXFt?=
 =?utf-8?B?ZFpnbHRFUnRMeERnZ0U2U1k1VHlzYlQvWkd3M0ZJNUJTLytqbXBjRkozYnow?=
 =?utf-8?B?UlJZRzBHd242bXBYMFVsOERxVkFvSGFheDJFeFg5SWpJQUUzUnBlSjRaM3Iv?=
 =?utf-8?B?RVEzQjZOaTdKc2J1K2NZS2NYSktseXI5cU1jamt2eTZ1emwwSlpDZ2ljclJR?=
 =?utf-8?B?Z2lvdUFTejczeWxlalFOTngwZlFSR29QTjZaN0tnbGthWTgrRUxOZ3FUVVVH?=
 =?utf-8?B?Z25SUDlvUHBob2lNdDdpYmZ1bE9IYUxJQisxcTJ4T2x2MnhyTEtJZVVyOUNS?=
 =?utf-8?B?L1IxTXJSRFYxdzh4Z2ZLSUZ5ZGVqNSt0T1NDWUdlWGFTR2Jlamdxd2Y3aURu?=
 =?utf-8?B?Uy9EbDNDZXdQYlgyOGllM2ppdm0wUVVHbUVIOFlNUmR0dnRocisxVjhUY3JP?=
 =?utf-8?B?b0JWSzl2Y0JIcWM5ZjBXb0FTcHdtTXhuRmFJSHhWMEtGbFBJWHF6Y0haTnNR?=
 =?utf-8?B?bEFraXArYlE5WHgzMDgwTkEzSE5mN2tHSU1oelRLVzVtUXE0K1ZVVkxTZmVu?=
 =?utf-8?B?N0RHU1piZjRiMjVldTJ3NlhialRnUzNqQnV6M3dkRzhSR010dmwvclUvMkw5?=
 =?utf-8?B?NDZwWlR4bDQxbWN6OGRabjhqaDBjaHBsTXFDcG5JVXF1ZTdET0kyZFdsQWtn?=
 =?utf-8?B?bWF1L25HTHJibVcvd0NFbkc4RjhJV1d1TkVQOTY5OHh5d0lhRjVlVlcxNnRT?=
 =?utf-8?B?QTB1RXVtRzBlSTBGM1lhN2oxSDRoZnBNeE5JVnNxckhkMmV4TWQxb3djYTJT?=
 =?utf-8?B?ckVVbjJkdi9wbE5wc2FTbXRVOUxLREUycVY0ZWFldjhrMkV0NUtVUHdhbk8z?=
 =?utf-8?B?OVN2eW8zOUV0ck9XT1p3NlhwVTR4aHBKWHlOS1pSdGswSmpjbkFwdU9MTEFk?=
 =?utf-8?B?TE9ZbXNySDJOdGFPY3RPdVF4US9HZ1BLelcweTJSYVlLRzl3amZzQm42bWxY?=
 =?utf-8?B?cUZkdCs4K0tiS3gwb2pHSHlud0dldFREMmdnemtvUmt2eVROSURiQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f4cf05a-6260-42f5-2835-08de793e7f4c
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 16:04:06.5239 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jiHa5gNFgjScv17+xe40kp+vzPX1zID6kiNc+6y2o6SafXaMbQ5ANnO7apP5Aev9qhyeNlFil1l2tIHZaWixlGXfqQUwYhKsthsJaX5bHjA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8576
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
> Update the documentation to reflect the new test file organisation:
> replace references to numbered test files with their new subdirectory
> paths, and update the guidance for adding new tests to describe the
> subdirectory structure instead of the old numbering scheme. Also fix
> a stale comment in ftest.py.
> 
> Signed-off-by: Simon Glass <simon.glass@canonical.com>
> ---
> 
>   doc/develop/binman_tests.rst | 11 ++++++-----
>   tools/binman/ftest.py        |  2 +-
>   2 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/doc/develop/binman_tests.rst b/doc/develop/binman_tests.rst
> index 78b02e6f435..e0baec05125 100644
> --- a/doc/develop/binman_tests.rst
> +++ b/doc/develop/binman_tests.rst
> @@ -453,9 +453,10 @@ help with this, but your code will be different.
>   
>   Generally you are adding a test because you are adding a new entry type
>   ('etype'). So start by creating the shortest and simplest image-description you
> -can, which contains the new etype. Put it in a numbered file in
> -``tool/binman/test`` so that it comes last. All the numbers are unique and there
> -are no gaps.
> +can, which contains the new etype. Put it in the appropriate subdirectory
> +under ``tools/binman/test`` with a descriptive filename (e.g. ``fit/`` for
> +FIT image tests, ``vendor/`` for vendor-specific tests, ``entry/`` for
> +general entry types).
>   

This is an awkward wording, the content in the parentheses seem to apply 
to "descriptive filename" but it only explains the "appropriate 
subdirectory" part.

What about:

Put it under ``tools/binman/test`` in the appropriate subdirectory (e.g. 
``fit/`` for FIT image tests, ``vendor/`` for vendor-specific tests, 
``entry/`` for general entry types) with a descriptive filename.

?

>   Example from ``tools/binman/test/vendor/nxp_imx8.dts``:
>   
> @@ -610,7 +611,7 @@ In the above example, here are some possible steps:
>   
>           Entry_section.SetImagePos(self, image_pos)
>   
> -   The solution is to add an entry, e.g. in ``340_nxp_imx8_non_empty.dts``:
> +   The solution is to add an entry, e.g. in ``vendor/nxp_imx8_non_empty.dts``:
>   

This should be with the patch changing the filename + path.

>      .. code-block:: devicetree
>   
> @@ -641,7 +642,7 @@ In the above example, here are some possible steps:
>   
>          def testNxpImx8ImageNonEmpty(self):
>              """Test that binman can produce an iMX8 image with something in it"""
> -            data = self._DoReadFile('340_nxp_imx8_non_empty.dts')
> +            data = self._DoReadFile('vendor/nxp_imx8_non_empty.dts')

Ditto.

>               # check data here
>   
>      With that, the second red bit goes away, because the for() loop is now used.
> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> index 0f1a799821d..2434e912d51 100644
> --- a/tools/binman/ftest.py
> +++ b/tools/binman/ftest.py
> @@ -2130,7 +2130,7 @@ class TestFunctional(unittest.TestCase):
>   
>               # Unfortunately, compiling a source file always results in a file
>               # called source.dtb (see fdt_util.EnsureCompiled()). The test
> -            # source file (e.g. test/075_fdt_update_all.dts) thus does not enter
> +            # source file (e.g. test/fdt/fdt_update_all.dts) thus does not enter

Ditto.

Cheers,
Quentin
