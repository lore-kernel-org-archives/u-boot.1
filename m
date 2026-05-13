Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D44EDCD37B6
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 09:56:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67831838BB;
	Wed, 13 May 2026 11:56:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="HLyqDlk+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9260A84099; Wed, 13 May 2026 11:56:21 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BEBE18341A
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 11:56:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HRnocLPrP0alo9L+DkHex/pdSBK6SJukP5qDRfIuSDMLc774HjOK6xHi/oUPJGllrzxBtzfnxREBamnSjUKaKWUjLJsC2u0mVer3Don50kvqDC3UVbBQWWUr/3xTekqGVVoFohYJAzz2fZzqz5/hRLVggrJIlWdQVJw2mFvrjhfqhCdjtGE95e0N2Uz4GSes8obTASyJO0LJmaP1pOXmffLqHTDqLBtkDpDsH/wqsL2g+t2+imp4tWBE1zehZYyRkO24prCzQuTumdJ+E7lBReHX6l5lscCUzcNMJbRohhooIdzc2t9i4hbhyUOUVqJRoIIQkQEfxLyLWtyMf8EYIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R/dsKoi4JKfv8S2MmK16kro/4mtksMo662tF0E23+PM=;
 b=mqhSob0qi57uL4AUKKQ399tTE6GvMDceFFNpbgyQPEJXfjY8m7mSYTz925vZgBRcqSwwl+Nyq5O58GzGVSicn1FD3UEyiRERpVT6OsNnEVkE2Tz7bZToktExLETub3+/AurbwEgPm5UuJZIN9Kc/BIuZTXB9+CTlOqkyOdPc4B2+r8sp8KJat/va/Aa9W+lndsBk1NRq8erwjKGvSonkWc9g4OrcvT/lT6l4oEZCrkEIfUUXnwKgAsG3O5aRtXRPyfhLtQjNxhBHCmRMBA+ofQqkDP68Yto4FwcWLvwTmrR0WSv18UC85w6vBwgEdsRXwVfYk9hK2OzahFp7VhOoyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/dsKoi4JKfv8S2MmK16kro/4mtksMo662tF0E23+PM=;
 b=HLyqDlk+SYIMJV9Q9M8e/AxTogy8/+psz54HLfKV38tmfNb2y0fxbZ73fD+3ssCoJ5ba+Q5wPiyFvZUT5lrgO9FXRpKKPC7w6LH3M3/phez5PxCTtaOjE8b4dB088AVMu2kJNt8y5Z+DMTzDTxXSKS8XVW1xMhikT+uul4Qy1HhksW8BOW1HU6t7maVspUFOhVZujBKu4iymsWOaH21Eq3Xe7+NAitjBEsG3OWX3+f9IcXE/+u4cZGr4DQGcCYIW7+rdCxLA9bWv1nnFA+8MJ7oEpGYREZ1P7RoV1E0KUoVHVU+MDeQVpI+bVKTHtiB/EIBrOEJTjsSBqvzBGJR0aA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by PA2PR04MB10130.eurprd04.prod.outlook.com (2603:10a6:102:408::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Wed, 13 May
 2026 09:56:17 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 09:56:17 +0000
Date: Wed, 13 May 2026 17:59:05 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Vincent Jardin <vjardin@free.fr>
Cc: u-boot@lists.denx.de, Alice Guo <alice.guo@nxp.com>,
 Fabio Estevam <festevam@gmail.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 Wasim Khan <wasim.khan@nxp.com>
Subject: Re: [PATCH v1] board: nxp: common: support CONFIG_FSL_USE_PCA9547_MUX
Message-ID: <agRLae5P3EUV+G8L@shlinux89>
References: <20260510220751.578230-1-vjardin@free.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260510220751.578230-1-vjardin@free.fr>
X-ClientProxiedBy: MA5P287CA0318.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:21a::11) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|PA2PR04MB10130:EE_
X-MS-Office365-Filtering-Correlation-Id: eff50ae0-dfb8-4c43-e203-08deb0d5e069
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|19092799006|366016|11063799003|3023799003|56012099003|18002099003|22082099003|38350700014|41080700001|15866825006;
X-Microsoft-Antispam-Message-Info: KQcsgggpfrbOLfbJf+M8Jf0HG4W/lkww7eLK90oqOEuyV2rc4Y8XC3wsW9IGmTo6978b/6o50W8DkMU3qkGrRRGaqGzSiomNWuSwhNx1FSsiCc+KkGEKZj4rDL/TSWQ0wO+LPU3HfDeS/cdzsh3H5aUw7a5tbHnVCUf6fwITfqTz6YzCyj+9Pw/pMKPwmg/jKndpb2/GSSl6a6tygOdKNKVmbBMfjCUYBC0ZirV40UqOnt0TD/xr0hQ92mB6FyMBxQN1D84v9O6yy6CnmhSwrT3KLz0gleZGL2F/0gl8X26XlyyyDLZhfxi+8gXsjBANARegG7wDJ2pUH+WQveh31ZLv71zaefPS3DkC8RI2KHSsJDMBDqL9xHYhGE3wKgkvRluJCanowtO8iLsrdz4FVjcacC/5lIrYEOSRAm2cN25X89t5ieOVtv+304xL5JI5Qi/oHoY0pSWMEWoUuELWEHldEExN3hIksGYIcsXveJnvenbYQAFRfKQw8sAKvm0ky43P2597LjGIzeCVtLsc6a5grKITanJiEZDMnNLEtI39sa7/ZNegxHy9qbWv8FLYCeiKABmRheniY/bMIovMAiwppKlwmwiLPEeQxPo6Mr3jvDy2j+14gBFCmUWJbRyU9hVgNy/pO6EVmPQczg4RiY8Bp71OA0ou+hcFyWfVh8y7OrzFA+394sg4bN6n3dNf6SEoWHTGKYciUKqG6i2KZQzZT85FN8XWNVXfUbWNw/tiC08ZZPhpMfFQLueMFLAiVI+dYLlflLfq4gKYVbi5Bwq+NGC24a2iT3GNHJQOlAGF1V3Xdo8MLthwyYWNoNGt
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(19092799006)(366016)(11063799003)(3023799003)(56012099003)(18002099003)(22082099003)(38350700014)(41080700001)(15866825006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RdrawXTZXKk/WcZDlMArTcTxN47qMaZc/0ioydo/Z1rik5qT05LcaC/K7uQF?=
 =?us-ascii?Q?jUsFwvIzQxrd3ynyGjEWRrmup3mptBab4kx9tA/3pX9QtlnpM2ccrCgfOBEl?=
 =?us-ascii?Q?S6gHaqrcHPkUOE3URRpieyJ8Ni0dQVh+ZS1Gnma43kfJV8lMQ5VSaeqoarN0?=
 =?us-ascii?Q?E96j9IGgMauIfXjp31N9oXvO+Tm+xDEZu8b1s/btWBhKIEcnS3ndbq30oWYE?=
 =?us-ascii?Q?B+YItxZWVcw/LWG4D2YO5u63QGN7bBYSlCiIyig+omIxA/o7Z8g5boONvklc?=
 =?us-ascii?Q?yESSTj49JLd0C6o2LsNaaLmdgKZiIZGXwCyCNlSGEivVZpEjOvlOOxsFJTYR?=
 =?us-ascii?Q?jcZvPpNTDM0R8fseWrvC0TX411iydCyZMh9sg6cd0hJVNwwVrHW4i1fuhVAs?=
 =?us-ascii?Q?2Ekp1q4II6L/qatlDIpFI748niP4jtg0pECG6ea1Q1NbVgqYrdkUjIRxLkZK?=
 =?us-ascii?Q?A12lc76TmhjNlpEGO0tSuzT2iSaCpOD0DkPfTDeebxTH3hrWLhmLl4os30RZ?=
 =?us-ascii?Q?CqHgqvEa+iB+FxI1X1EumUwEHZpX7dGJCAPdrDVFex5niEiEhCTfUB6YiJ67?=
 =?us-ascii?Q?QJRo0pvLBiNg6keuDAOF2bclIRSaclwqEzKnjFn3xXgE49NL/17j3JdFF44a?=
 =?us-ascii?Q?W7ribgk4xscysvAqG4Ih6fNPrgZH8kqi3UfBI3s/DhTApR65sw9/BeG6G7oI?=
 =?us-ascii?Q?Z/GLLm/hk+Z6yopn4z7muMgJhCssNQrSJ/5CcGDGQUKEM5/UYIT2AVEcRm/F?=
 =?us-ascii?Q?SPDgvmcCmQkJbYCIRmRBcz8eg8s75GmpP0kyaoacmtzRQX19KEISziArUM8f?=
 =?us-ascii?Q?vUCA0VbN1kyrEwUezGtCgXQrsH1ilZwYYllmdvcbyHsf/yegmD2oRc0bM/7/?=
 =?us-ascii?Q?bmheBlX+XIi8bRUB7M2DKuhgkJGW2oy4yLxnZseyAwZfGUr7dTld5IfcJVwk?=
 =?us-ascii?Q?kVpoCInGmNMFESmKJcCrIVB5YUYT4e0V0OYpt8iEJgzT/mD0GErz6I/6H/Cr?=
 =?us-ascii?Q?7Z6amwOwqg15OnlilRIVnn7/dtJuuBigzaH4/uAJpSS4zPGifibrbbDBkej9?=
 =?us-ascii?Q?6PJk0aa0WmRanYugVHQDKVvpzliqi9T4vLzcnaa7EDz/6h7vn4Dzw21F6INr?=
 =?us-ascii?Q?Hd1IXwHyWSODO843pLRJBndLX0e4gC1SKFFvNzljyOzBY2TF3iOOTuFXiu3L?=
 =?us-ascii?Q?tfXCHn53/LM0cERZ1pq3lMjgKIHbyrf8igAQ3Ie598JWqq0OK+iZ25YM2DyK?=
 =?us-ascii?Q?nUsnR1ye3F1PO1nZGr1dlg/p4VZS/qq7y5v1h40JNDip1Mb1bRRSVxbD9EZs?=
 =?us-ascii?Q?b1Cye5esTPr6mmsifie9N2wbFhGDgHxKAeUnVuqP79vkJdJXybuGHcZrhFdp?=
 =?us-ascii?Q?t1bv38WdrfJh/A+I+iU8Yxx7Wtl7pJu+ePcD+YrR97iRBkUzYEZKGWKh7CRy?=
 =?us-ascii?Q?3gD/8kGSaClNYun8ptFKImvusyukPKlFn58w5jqmvRrn0/vcrGaxT9eWMM7x?=
 =?us-ascii?Q?UnfPJjhI3n9QUk67uCXzKW7onXE3kI4634vuWJSnJWxdO/BOyE5uLe0T+ldm?=
 =?us-ascii?Q?oE9TN91JnNq7qfLSd7Z/3dCuXZjLq7MIO88M024uyvcMe/v3eNU9H/1wZNmK?=
 =?us-ascii?Q?9WnuZV9VJDIPEUmMsu1OEwdxQ4wPQIGJW04lrufVJMVQPsJhPBpMsx0dzG02?=
 =?us-ascii?Q?hLr8HgOlBKx1mbjg5rG/np26Cwnb/fKQSdEF1yQapgqgfrtw1NI1/67KQOQh?=
 =?us-ascii?Q?e4TnUcSxsQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eff50ae0-dfb8-4c43-e203-08deb0d5e069
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 09:56:17.5080 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mAIequFRObkL0hkmmnvTSssBnvtEBhRwQeWLRroymDeTHiJ3v5lCroAkfmcvmpOxKNSn5mc3RpQ0dYXybOyEUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10130
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

On Mon, May 11, 2026 at 12:07:30AM +0200, Vincent Jardin wrote:
>Use select_i2c_ch_pca9547() only when CONFIG_FSL_USE_PCA9547_MUX
>is set, but several call in board/nxp/lx2160a/lx2160a.c invoke
>it unconditionally,
>or using unrelated Kconfigs (CONFIG_EMC2305, CONFIG_VID).
>
>Compilation with LX2160A target that omits the mux therefore fails with
>
>  error: implicit declaration of function 'select_i2c_ch_pca9547'
>
>Add a static inline stub with -EOPNOTSUPP for the
>!CONFIG_FSL_USE_PCA9547_MUX case so all cases compile cleanly.
>
>Adapted from the convention used by include/scmi_nxp_protocols.h for
>SCMI subprotocol stubs.
>
>There is no functional change for NXP boards: all eight upstream
>LX2160A defconfigs (lx2160ardb / lx2160aqds / lx2162aqds and their
>secure / stmm / verified_boot variants) already set
>CONFIG_FSL_USE_PCA9547_MUX=y, so the real declaration wins.
>
>The purpose is to support new boards that do not use the PCA9547.
>
>Signed-off-by: Vincent Jardin <vjardin@free.fr>
>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
