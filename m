Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 591DCFF885C
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 16:23:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D851E842FD;
	Sat, 25 Apr 2026 18:23:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="hagC51Gw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CFFF83FB0; Sat, 25 Apr 2026 18:23:24 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D16D84307
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 18:23:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
Received: from AM8PR04MB7428.eurprd04.prod.outlook.com (2603:10a6:20b:1d5::13)
 by PR3PR04MB7418.eurprd04.prod.outlook.com (2603:10a6:102:8b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.24; Sat, 25 Apr
 2026 13:44:38 +0000
Received: from BESPR04MB12587.eurprd04.prod.outlook.com (2603:10a6:b10:ff::15)
 by AM8PR04MB7428.eurprd04.prod.outlook.com (2603:10a6:20b:1d5::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.23; Sat, 25 Apr
 2026 06:57:26 +0000
Received: from VI0PR04MB10493.eurprd04.prod.outlook.com
 (2603:10a6:800:21c::14) by BESPR04MB12587.eurprd04.prod.outlook.com
 (2603:10a6:b10:ff::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.18; Fri, 24 Apr
 2026 19:56:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bRZlgDFwZgFYg4hu0nPzUp0dabVUfo3gcdq5zgcd4U/risKBGOz8QGGEbH6RTxMe2gpZWs9p91axPtMG0pTEuuzUy9UatfsLimo9YjOkF7oDB5LJ9UAiyhxG711KrZY0Qxr0K69pD1fzErP5a8RBIQkNh/7XOsuCSKMO273/mn+o85TXlAfyR1aOWZ8lQcMh4j8BgpR80fEgSTA8DWdvYeC9yyhk4a4ViZ5M0Nbfey47wx9iTiTMUAMlEYF4NbwjaLknQDuucqNB+pKG4lQVLA8UeB7PL0tHcnMUsqgp7Y+XFc7M9f5C0vYN3+NRSFRxirQlq6DzCRxOg/+RHjuu8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tjzBmdzQIIiHOYdYFvY0+bz8LXYWOKH4ysNJKVSHe8c=;
 b=S2tX3Y0iJbYY5lDgBHjggJlAb6+L3DaZt7IZhsZQk67ElHkj+n4Frx9DtboG6VH/XyILfv9GVPsi3MWSfJ7ZAn1tLqK5E4tBm7+LZcKIXROuvkFEQybop1l9X6PK3nNnamAvumfP/RrkIgUzLzQVoj9QgENRIH1MDEEMwa5Aadi/VkOuJWvx1ViwbTqTkKw03eF5tUpTUG6RdHtYDjds0Sq9r5+bT0JKCHvTSJZyGE2fk8WlweNp2NkaLKvANPlKNOVATlUEdrEFtqv4rZXPSY8gq6ronRFq6moEepokrUYeR9jZIxlN1Tn0pWWKpMiJNC1MGO1uKYy52G+usA5e5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tjzBmdzQIIiHOYdYFvY0+bz8LXYWOKH4ysNJKVSHe8c=;
 b=hagC51Gw9egvRzgGMYEjpoziEk6jbBYaceksh/OLOEo1w6x0Cxg6E3UbM7raJIbeD7YoGR46AZpFSGN0Gv0Z7VfmvAyyplXQxGpJrAW46LteMCaUH0J0VKoNnRLO2H6DFfCwHQhyOfuT4ls2QQNt5WQNb3twuSelN7X8ctP2aM4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by VI0PR04MB10493.eurprd04.prod.outlook.com (2603:10a6:800:21c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 17:50:34 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%4]) with mapi id 15.20.9846.017; Fri, 24 Apr 2026
 17:50:34 +0000
Message-ID: <22dacc9a-103f-4b54-8f65-ba1227be2114@cherry.de>
Date: Fri, 24 Apr 2026 19:50:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] binman: Flesh out the softhsm2-util bintool docstring
To: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tom Rini <trini@konsulko.com>
References: <20260421231126.597390-1-sjg@chromium.org>
 <20260421231126.597390-4-sjg@chromium.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260421231126.597390-4-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI4PEPF00000157.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::878) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|VI0PR04MB10493:EE_|BESPR04MB12587:EE_|AM8PR04MB7428:EE_|PR3PR04MB7418:EE_
X-MS-Office365-Filtering-Correlation-Id: af6a4134-cd23-4391-9223-08dea229fc5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|10070799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: CyTcTv8Z4Bve3LXYPSLxWWO8YzGE2WqVi5L0iMDVIQEgN/hRrUrLt/UxUoicjx+AWFhbrWJA7MKAVlpwZ5rsFNXT1WK9TOxSEVg3/tRxK0qJXxQmUHNBi2PjAg+XcHMuDORifhKHJCD0R1N8cQ3uPcjTVirKo9Tp7ETzl7N9Vck4s1QFrZaf+XCRao+PXJGPMqHOVDAQKPDhNRhdYELBs9dlZy25eH2eogZsK/MTS3MocY5Ei6mxhvw9R4Ay7ACsF+8z2xKCjo3fI4WlOWUSMH9hBm+7AOE2jyIwIH4Q3ppuV1jhDxP53otz8pVxuZqH3N2d4hg0Q15z7lktVaEgh4j7vYUORlripQ5AMtcyN6Y446maXUGNOS770ObhtTQTDTj6vCM7RRJQGDgsvXESeViFwfn/eAiDIB4LZmHxV1Q70Qn+xRn5/skLKJaE7A1jcR94KKKjWF+3IPOjqNfUmDW5ag3RAJVG9EZ6rY/2afyfdw457Tdq2a091N/z5Hqbg0JigEYdgQR/EI75W1mR/85nqSWasT6Pf8IX43Uuyrl1Li74nuORs13uIbnHVp7wzAuc9O4GTXV7UhrpN+MF1MytYC6fqN6lDyJ/n+6ZZtLHi1W1IgrKtZt5iKla4/JYgTDn9PHOkDVNlXOImL0hQbtd0tSexOdZ2UR1dv7T/HV4jqxGTRTaOyARxXFut4+rjFUjMZ+ZtO4+fpVTyVraM3EKs/KMLtECXCxDUEmBDbc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NU1GYmlHMHlYcFRIS0xBcGJMUDJCTlFPMFBHREVzSGRsNU1DQnkxTlhIMHRX?=
 =?utf-8?B?c1RYY0dGWGRLRG1uWmovaWNmdE9KSm9aV3lrK3pCOXY4clo0Ri9qZ0hpSzZ2?=
 =?utf-8?B?RnoxbFQyQldnOGI3dGJXM3doblNyamdZMFRXZzlMVEozYm11RnFWbE5iMXI4?=
 =?utf-8?B?WXpqNURBZG9NSlhYTTI4VFh1eDBpdUJqUm1BZGhuSXdkZjRYWGVaU0lUYVFH?=
 =?utf-8?B?VFhvQ0N1cjc2VDU5UHpSckRYcDkwV0pjVWd1SVo1ZzV5UnJ1Zm1lY0tKVzFi?=
 =?utf-8?B?cUFST3N4ZEhVOHZBZkN6cXA4WnZobUhPbUlJUXBTcnNtb2xsRUw3bUx4empS?=
 =?utf-8?B?Y2VUdms3MnVvb1BZNVNrbFdja09GWkdmcmp5ckQwd05Qc2dodEJqUTJxNVJJ?=
 =?utf-8?B?TjUwWm1aNHF4Qmk2WnNEMm1zbkJIWjFtNHJhayszVFRLNUJIa1dKbVI1NHR1?=
 =?utf-8?B?dDEzYjJWOUxRZXFWY0VNTEw4ejhKMnVyN0svTWM5Q0lwdGg0NHdRanIvdU9E?=
 =?utf-8?B?Y01ZSzNYQVpiaVRNdDhHSEVucExlRUVMNHNlc3VNV2NsVy90c0xhME5pMkFj?=
 =?utf-8?B?dW05RzJoTWtxOHBZeTFsLytldGhJNFQwNC84bkQ5b2dkMG9sRzlPeTNKRFdP?=
 =?utf-8?B?MGl3ZEhGTytIMlNUa1JVSzVrVWM5Q21lNGlsSUdUc0tqVnZjTDE0OU40cU9R?=
 =?utf-8?B?QnA4eGc1clNkSzAwQ1poRWN5MXZSS1ZjenZFRkdzSXZETGlRODNBbmNiZ0tQ?=
 =?utf-8?B?aDV3L1ZEYUo1MHBqZC9NTHdZclZnQ25tbnZnYjRRcWdpWG9pd0lxTWFhU1RN?=
 =?utf-8?B?RUEwUVRYMVdMemVkTWhUWWI2d1pIWVVwYVlEUnZ1cjlZUXppWTJoMEtHRERY?=
 =?utf-8?B?OEJUdEFNOCs3S2c3MktMWVVjOStNYlVDZmNXQi9OeVlXZmc5aXJzTm9oNUhZ?=
 =?utf-8?B?dHN2TnIzNlV3TzV0Sy9wYW4rdTBXbWdud0JQR0owb1YrWjFucnE2RndDVDdz?=
 =?utf-8?B?OW1zTmFZQ2pKYkpOYXRJTjczUGF2RExYdVprVGdaakxYNUdhdjcwZDJxZy81?=
 =?utf-8?B?aSt3b3BIR3pCalBBdStNbXJiQ1J4eEJDU0h2dGxydzZYbjljK2NWV2FGeWdQ?=
 =?utf-8?B?bnhYMnJIamdWbUxMK3dHTUEyTHRmRFRWUVkxdHNNRmJuaEViRlFxZ09nSnZh?=
 =?utf-8?B?MlFKbzB1bmFmNmhMeVNSaEw1YU5EWTBDbyszVk1NcC9RZXZSaUdGWWxvN094?=
 =?utf-8?B?eU5KTzFWVHZPWEpJSWJudGpGWmZ3aEZqSCtnY24xQnFyNEZJRTlsaUFUUzkw?=
 =?utf-8?B?b1Z5Z2RhWCsrTEg4dDAxNEF6WE5kMDd5NFdNek9tdXFxMHpWaXMvaWVubmZH?=
 =?utf-8?B?a1hOaThBcURSb3FEbGZQUkRYZ05CeGMyWFJvNHVSbFNCVk80SDNDNXBmQ055?=
 =?utf-8?B?TUkyOFVXUGNtbm9FaEk5ZkVGa3BFalI1WVY4WXQ5aHIxNkF1SnAxZDJvVysx?=
 =?utf-8?B?WG1aN2pjWW02SWVBRmZQZHdSVnBLaWVUeUp1T0NnWjg1V0Z0M1psM3lzckQw?=
 =?utf-8?B?dGRFRTdMRVpzVERPNWRXN0huVUh3bzIzd2x2eFVBd1RxbWUyMW5nK3E5bGJ3?=
 =?utf-8?B?MlpPazg5YU5qeGYyTmkyT3pDb2ZwNXlkMG1STFlXS2J0cUZXb3lKRDhRVE1U?=
 =?utf-8?B?aEFXR3FkR01rK3FPRUJ0TFk5TnN6QklQSFV4YlpkK1dEcEduZ2s0YXZqYjFM?=
 =?utf-8?B?YW12SkJSR0NnNVNxMkgzeVZ0U1NzMUk0bmJkT2VRbFFrMnI0TDUyUXhmaVZv?=
 =?utf-8?B?cHVVK09BdEpadXBKZ1JjNEpPK04yWjRETjB1OXR0aHF2L0dHQVZOVmNCYjMw?=
 =?utf-8?B?dmZva3BDMlZBdkgvMGdMdGMzVnFRZEVBaW83emF0NTMzZU9iZ0RQRWt6dzY4?=
 =?utf-8?B?ZzI2QnQvT2hYd1hBZHBmZmdkYytuVFo2OTBKTmViLzA5SGt2U25ONXZPRiti?=
 =?utf-8?B?NmdBalg3VG1GWWJrSzM0b29WMlRuMUNmK01xdlhIUnIvM29sb05aZzNoOFlE?=
 =?utf-8?B?SXl6RFV1R3lWZmcraHRHR1ZPbVY5TStweWUxV2tVM0lOQUFNZm00UEFmbTN2?=
 =?utf-8?B?bHR1SkhlRTNERkhSTTNjZ0tkcGt2K0xIaE9RMnlGMDFCSUlHT2dqL09FWm5p?=
 =?utf-8?B?eHJJcXJHK2lLNWMyb0VuUVF5MXErYjMxZ2pOY0NMcXpoQ3V5N3hwc2I3bVV6?=
 =?utf-8?B?VFFXRzRPMmNmc1JIbjBJWXZTM2FYbTh0ZDJGQ1RWdnc0am1vNHErVG80ckFw?=
 =?utf-8?B?bmowZFNhUTZNajBvRmNyYXBUSHhZQUduanJnekhFZTFqczNrci9yaXZNQ1R3?=
 =?utf-8?Q?S3T979Acch37bacs8J0cpUEExJP4c88yER9K1?=
X-MS-Exchange-CrossTenant-Network-Message-Id: af6a4134-cd23-4391-9223-08dea229fc5a
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 17:50:34.6410 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: prfanjN3o7Y2HFqrppdaG9/d3p4mb1JDKYkNb4pYuUpW5IN5rPB7ABEjUXuA8a3u+gJYebVwFgrwWTfMvhZagRo/hMp3+cxWFt5lBSdMZFI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10493
X-OriginatorOrg: cherry.de
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

On 4/22/26 1:11 AM, Simon Glass wrote:
> The Sphinx-generated bintools.rst currently produces an empty section
> for this bintool, since its class docstring is only a single line and
> so the body under the heading is blank.
> 
> Extend the docstring with a short description of what softhsm2-util
> does and how binman uses it, so the generated documentation has useful
> content.
> 

Welllllllll... Binman currently doesn't use it for anything but checking 
if the tool is installed on the system and if not downloads it. I've 
basically abused this to check that softhsm2-util is available on the 
system, but I'm not using the bintool to run commands.

I'm now wondering why, because I guess we could replace 
tools.run('softhsm2-util', args) with softhsm2_util.run(args)...

And the same for pkcs11-tool I guess?

> Suggested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
>   tools/binman/btool/softhsm2_util.py | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/binman/btool/softhsm2_util.py b/tools/binman/btool/softhsm2_util.py
> index 869221d841d..e79584da11d 100644
> --- a/tools/binman/btool/softhsm2_util.py
> +++ b/tools/binman/btool/softhsm2_util.py
> @@ -7,7 +7,16 @@ from binman import bintool
>   
>   
>   class Bintoolsofthsm2_util(bintool.Bintool):
> -    """SoftHSMv2 -- support tool for libsofthsm2"""
> +    """SoftHSMv2 -- support tool for libsofthsm2
> +
> +    This bintool supports running `softhsm2-util`, the command-line utility
> +    shipped with SoftHSMv2 (a software implementation of a PKCS#11 token).
> +    Binman uses it to initialise a token so that keys can be imported and used
> +    to sign FIT images or capsules via the PKCS#11 interface, without requiring
> +    real hardware.
> +

Yeah I don't know, this is all transparent to binman really. You 
configure the FIT via DT to use pkcs11 and binman will simply call 
mkimage with that which in turn will call openssl which in turn will 
call softhsm2 engine (see tools/binman/test/fit/openssl.conf). So it can 
be used for anything, and binman really doesn't care about this bintool 
except for its own unit tests signing FIT images with a pkcs11 engine.

I would remove the last sentence. Maybe we should tell the user to use 
this bintool only to check whether the package is installed but that the 
actual signature/token setup is expected to be done outside of binman?

Cheers,
Quentin
