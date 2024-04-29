Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46AADC4345F
	for <u-boot@archiver.kernel.org>; Mon, 29 Apr 2024 09:02:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9086788952;
	Mon, 29 Apr 2024 11:02:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="OP/ptjoX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF0CA88951; Mon, 29 Apr 2024 11:02:15 +0200 (CEST)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe02::61f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81CED88952
 for <u-boot@lists.denx.de>; Mon, 29 Apr 2024 11:02:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=gaurav.jain@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=czN0Vr3cZ91DYZcKqEeUVNN1pW7POyJ8CynPbiDfXDOOI4Sp3gUokcEXFtCvHiEcs0uw4GeLlaz1k7U6ihSzdurKskpOTpbE265T4PDFveT8180hE2Mq+AfDmu/lhauSw2hapHzvRIl9UH3+PyX87dc1SuqbPnobSGt1G3KAzdgYDgI5OhuNWNr8czJ4BTUDGzKrECRBHo7CzG+s8Om7qOPDlr7tKMPpD9P+MrDIYhw7ssPPUq4ruL8BzEw6DeEJlVzPKBgzLtJaE0wC+kboatrdaXVXo4GeKSCLjHsXQqaGWNpALN2NgZ8zx2Ld9+FSQj3bF7FMAHbKFmR9TZRTkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LFMOsvETb7WUT4kZSrqHhCICpFW1rzanQC5Gaw/4fas=;
 b=KdNJ3Rv7NTvpedKmOf+paRTwJlZxCIPkq2T5bIXIGtDOXRzlUITGC8+7Og1g2bmw8oE6ex02Ujt/V75DOMNuk2w7pTynm/SIPi8rBCzVPMqLVDALTrk4FSjO+lIRJwAoXfp6erwdX+fdUiFhI2QUfi4e61N8J42T7Z+4i444xt82QcnIr1trmcHl/ZpPzzcp2Gz6R1LGmwxHd7tXU3JDMDL1P+1rQyWh1phZKEAjN+LaqAxKS72kmdRDzCpmKC/S/zEkW58b6mjvRi8H+bTmpb5B43mwx/wYvS33b4vud7XAeyTnIpbT/Z/cPyY86PxKxuedjOW9zaete33JT3M+kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LFMOsvETb7WUT4kZSrqHhCICpFW1rzanQC5Gaw/4fas=;
 b=OP/ptjoXcEAxHmrQEX6Ihrr9F26ivl/xETiYMnSTWcp3ipFKVY3rPyC6SyoLCWyc8rd5CbzDVXftT3C2PNQeFoG0/ooilcFmWYjuzKRGsPc5KxSUlv64WCAy5RWSLpECEQxd6ZeqkgPUr+W29TSu89FFzVMScsITzyTEI7ZZJ7M=
Received: from AM0PR04MB6004.eurprd04.prod.outlook.com (2603:10a6:208:11a::11)
 by PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 09:02:10 +0000
Received: from AM0PR04MB6004.eurprd04.prod.outlook.com
 ([fe80::4662:223:b694:bbc7]) by AM0PR04MB6004.eurprd04.prod.outlook.com
 ([fe80::4662:223:b694:bbc7%6]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 09:02:10 +0000
From: Gaurav Jain <gaurav.jain@nxp.com>
To: Marek Vasut <marex@denx.de>, "tharvey@gateworks.com"
 <tharvey@gateworks.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Angelo Dureghello
 <angelo@kernel-space.org>, Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Fabio Estevam <festevam@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>, Stefan
 Roese <sr@denx.de>, Sughosh Ganu <sughosh.ganu@linaro.org>, Svyatoslav Ryhel
 <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>,
 Varun Sethi <V.Sethi@nxp.com>, Kshitiz Varshney <kshitiz.varshney@nxp.com>
Subject: RE: [EXT] Re: [PATCH 2/3] crypto/fsl: Introduce SPL_FSL_CAAM_RNG
Thread-Topic: [EXT] Re: [PATCH 2/3] crypto/fsl: Introduce SPL_FSL_CAAM_RNG
Thread-Index: AQHal28VZH6ihXh3cE2UlryUmqQrybF57oOAgAUH4CA=
Date: Mon, 29 Apr 2024 09:02:10 +0000
Message-ID: <AM0PR04MB600444768BFB0DF8114EFAF5E71B2@AM0PR04MB6004.eurprd04.prod.outlook.com>
References: <20240425230314.497203-1-marex@denx.de>
 <20240425230314.497203-2-marex@denx.de>
 <CAJ+vNU3ndKTXr5XBOd9b2aQF7WmBPARJ70Fsuab1rmnaQsEZiQ@mail.gmail.com>
 <94a75eb9-950c-41f0-b9fc-c7d95ecec6c6@denx.de>
In-Reply-To: <94a75eb9-950c-41f0-b9fc-c7d95ecec6c6@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB6004:EE_|PAXPR04MB8253:EE_
x-ms-office365-filtering-correlation-id: 68f441cd-cf3c-4f68-4b21-08dc682b0df7
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|7416005|376005|366007|1800799015|38070700009; 
x-microsoft-antispam-message-info: =?utf-8?B?UkFsZ0YxRVRRalVvM1dIcHlFd0o4aVUrUEozUXk0S1d2cEVXM2t4VDhuZDAw?=
 =?utf-8?B?UUsrbUNjKytZTHlTRlJjRmJzek8vT2RBblVhc08xMmx5TDNqMGxKWURBcGIz?=
 =?utf-8?B?bDN0S2RWZVVBTzdYTEsrV0h4N2h4WU00ZWN1L2UwSEQyNm1pa2QyMTVxeWNF?=
 =?utf-8?B?UlBHdzNjZktCRXVwRTVDT0JFWDZSTnpuSktuam5TS1Z3V1hDUlNPdE8xeWJn?=
 =?utf-8?B?NWFQY2tkYWk0enQvN0FMZU5lb2txZGJQYmZ0aEhZdkNOQVZ5RXRRdWlrcS9D?=
 =?utf-8?B?RFNXNk5wSm9VelRkM2R1UGxGRFIzWEZQQStzbFVURVdPemVEOU9ENkllRjZu?=
 =?utf-8?B?bXBQSHk5bDVWNmxQRUJjK1ZjbTcyZzJIdmZmSEl4ZjVkSWZtVksxb29EZVlZ?=
 =?utf-8?B?ZTRiUDFPUlhsdy9Tc3hFbTBZU3Z6aW94bGVrSXFqM2ZEZnZtOU05MENkVFcx?=
 =?utf-8?B?N01mUlZaN3hHYTU0NTNsZUlRdzlJbFRjQ0dqRzR3eVhGSG9kQ1VXb1BPLzZC?=
 =?utf-8?B?Z2JlNlpDZ0phZy9rV3FGeC9peDZUaWpwNW9PZTFsMEhYenhuaFhSNmlWcGpQ?=
 =?utf-8?B?cGJnT3BheVQvN2RQRytBcTVuUGRKV0V2Z3luK2tlTnpHcmFtakRPam94NnJW?=
 =?utf-8?B?VWtBZ3BlSStZVkJzWXVDYStFZ1ZhdkIzVWgvbXVodVMyZVJxa1Q0Vm42WGNR?=
 =?utf-8?B?akFRV1RZMTVnZ0JQV3lQYnpUUmtqdnVsb2NWOStBQ2hRem5KQXFBNlZucGUz?=
 =?utf-8?B?YVlKaVNtYmtUY3V4QUlVZU9yYXVHSFZBRndOOUZ1c043czRMQjI2UEduK3A5?=
 =?utf-8?B?c2k3bVRpMXg1TXcxVFpocWpIa2xBbVFBREtxOE92TXNWdC9FdmFDRktxVDJ3?=
 =?utf-8?B?d2ZaSERKa0s2NGZNaHY5VUlwbVFpU1ZVME92SFI3Yks2VHJ1VkRINXRPRVdz?=
 =?utf-8?B?dE9CQlgyTmdQRXdIOXI3K0FCTGFPN2ljdWNsa3hnNU5wUDgwVytyRDFjQmli?=
 =?utf-8?B?WUthc29rSFBOSC9DckdhVmpoR2hWN0ViR3JhK0p6RElUZjNhbitCejAreUxi?=
 =?utf-8?B?aHZPVUdXUXozeUx0ZkRHVFQxN056WG1TOVM3WXlLbGNQd0NUbG1aTytTZElO?=
 =?utf-8?B?cjIvcStQNVJmaVNYQ2MrUC9JZWVFdXQxdGowWmlNZEpXSEE1VnpxcndWMkZU?=
 =?utf-8?B?b2c2WXdzNmdDS0szMlllRU1UejVtV1h5WGZ4RE8zRGVZRlBJV0NZRSs1aFlG?=
 =?utf-8?B?NmpNazA3MmtEa0JwSlFPM0VXRHVGVGpNeERPQ1BjeElwZ1oyMUh3eDFHMkR0?=
 =?utf-8?B?b3dnOVVkN0JmeE91MERsYW1XNmIwcElKVGtFQytrWHJ0dTdmKzlBeVI4Znoy?=
 =?utf-8?B?QjM2RHNScFh2Qi8xdlZMTlpSb2ZBeEphNnFYV25SMFZ1ZzhuWGZRZ2l5T3pX?=
 =?utf-8?B?NVpuOHgyWnFVM3VJU2dFV2JxNGVtOW9vblF3MUpWSHdNMzh0UFJGZXdkQnZL?=
 =?utf-8?B?Tk0xSXUwc3JsdnJXRlp2TWNrdE9yRk4wUWFtSXRMUFJDa3B5bHYxR2NhVFRK?=
 =?utf-8?B?VDJQaXRUendobEwxL0RMOGhUbjNoK0d0NkFWcWlRdEs0K3hzZTU0VFNYMmln?=
 =?utf-8?B?R3V4MHl2VXJYaFErVWkyN2g3Nzh6WWtkZVFoTklCdW9zUVVReWNCdGxzY2Vk?=
 =?utf-8?B?cWhuVW5oeGcxMTlPb2pWU2RaaWFtUnNjWENrR2tyTjVBWlVsbWNUYS9Nc2RI?=
 =?utf-8?B?TDRkVzlCREdUUzQyN2IxUWxaR0J2SXMzV0l3MDA1VzdwVmVKNmp0YS9rZm03?=
 =?utf-8?B?aEZRNUQ1eGd4VFNlditoZz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB6004.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7416005)(376005)(366007)(1800799015)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RHNtMFdNV3ZiSjRveTUzaDhzRHYxYkd0MVAxa1Yrb0VHVjFhWGJLckZWdUxq?=
 =?utf-8?B?V3pJREtNNVA1SThrVWZlVlFYaXFDd2dFbUhwYW5NalAreHdyRWdoa1BlNG05?=
 =?utf-8?B?U2xaazlWNGNseStOay8rQnQ4Ry9DUmdCOUZMQ1I1Z3p4Z2U2RDlpRHZvOVgy?=
 =?utf-8?B?RGhGZWVSSnBqcE5FTDhlTHllYVBjdkZHYlJGdjd3RXZHMDYrNmRTVERGMEJj?=
 =?utf-8?B?eWczMVArY1Fka2NKZzM0K2RNdW13NW1MbzBlM2xhTm5DNWQ3a01XY21pN0RF?=
 =?utf-8?B?K1RWZW9xZ0daTnpWQlErUGhFN0U0ZXNaeUMyamhia2ZKcERUQmhaZ2lvcEVj?=
 =?utf-8?B?c2tYc1V2WUJKR3ZNcWRvcDhjeGpBL1BEc0tNcnVXVHlRZk1RQ3BQZ2dMTjN3?=
 =?utf-8?B?TTZTbnJ5WGdNY1dUeGZiaTMwYUs2N0J6aVVqd0tIV2R4MFN5dzJPTU13Tmtq?=
 =?utf-8?B?NDRPYjdESlFnbFF1bjNta0dBZUxweEVWN01UOU5pdjFwYlRubFFaRUxRQ1Rm?=
 =?utf-8?B?OUk3RDR5bldDVkpRaC85QWJkOTd4TnJoOXBzV1laT3ZudlZkRHQ3Tng5dkky?=
 =?utf-8?B?cXF5WmtTYXd5cjB2RThLbGhidDdiS3FGTCtDOCtJTXhVRnd5K2Radmx5ampw?=
 =?utf-8?B?U3dYZGRWQ05YdUVBOTY3am1tcStGMFpOemtVRFBsanVkazl6dlJRWUxIcGt4?=
 =?utf-8?B?emtDZXBtVjR4T2tiUUxzVW92MDZ3VjNmOXN6WXhiQ2I2bWFiRmdIWjJlanZE?=
 =?utf-8?B?VTdGdVFKVXFnQ3A4cmpiRTlSUGVGQU5VSU9COE5uK0NsVmhTaFRhQTVZdzJY?=
 =?utf-8?B?N2o5UVJsT2hsYzYwaU5zWE0wYlYzNUFNenFiejFXdUZLWVA2S2lnTTZYNnpB?=
 =?utf-8?B?UE00OGRTMGRFSHRMenNNTlczc0xYcUc2RFhGaE50ZDIraGg4ZUkyNzdzbnMz?=
 =?utf-8?B?VHNiZ2RsZ2hmT2NxSUFnWUNXQXVMaGdvNjdhL0ZuWHBORHIxZnBDbEIzZVpa?=
 =?utf-8?B?RjZjMDJMSjI3a1R3WERsRmVCRVJtWklvR3k5RVBqN0J1MGNpNUphMlRCeE11?=
 =?utf-8?B?TlorV3hadkxXaU5NWHNvc2RwMHA0NFhHR3RScEJWc2tiMkNJU2pLVGZzeU92?=
 =?utf-8?B?ZzhUM1kvSUk0UHVJby9MWWxWaW1JeVprWGwraUhjcjdnMll0Z1l6UnZ0cVNO?=
 =?utf-8?B?NXFwUzNKa0Q2Y0NaZmwvYUVNU2NKQXRKRmNVVG84N3FnbVZyV214SS9aODZa?=
 =?utf-8?B?Q2ppMldrQjkwZG1mc2RQMnFRNkJwQXA2bXVSL0pZbk1WcTVJZnU1aWVSM09u?=
 =?utf-8?B?T0dlYUJJOWhXVEk5YlRwQ3VUUHBMem9GdGpiZDM5RHhUSkI4YkRjUCtwYmJS?=
 =?utf-8?B?UDNVQ3g2QWswdDYwSG44ZVU2VzJ2eGtPUzVMOEs5NmxTWDY5c3cwUlZudThB?=
 =?utf-8?B?bWlseVF5MmsxSm5RWkl6N0F1d1hPQ0RjR1JtcXVVSDlJcUI3V29Ec2NkeDNQ?=
 =?utf-8?B?a3Z3UkFXS2RMdWFac096NmV4czcvTUNTbUIwdjVzSGtiZ3dHNE1SZDhNV0xz?=
 =?utf-8?B?ZlgrcGZhRSt2Z3pRTWJ2RVFlTmI1R3hxYitCd00zTFQ1ODBsUFRMYVlPN1Ir?=
 =?utf-8?B?RVVmektZUzF5bHgwdnRuK3RraGpZellUaEFqcWVIMXF2R1gyNWZaVE9CczFk?=
 =?utf-8?B?bmtxczlVZnFaSGxOR09rb3IrODFiTUt1ZjV3dm5NZnVESnhEZ1BpbVEySVVJ?=
 =?utf-8?B?UjdGbUxkS01YVW1TK0t6YjVKV2tGOXZZMlF6Ny8rSldOaWtmOWs0S2JDRFRu?=
 =?utf-8?B?VVRhci9rQkxnZThiRUxENnROOVlHbmFPOHM2S3Y3VW1uWEFoQjBPTnErUFJp?=
 =?utf-8?B?ZzFvWXFJUzlUc0J1dnY5NDlKelhZRTZFRlUvT1lLVTVjZ3Q1OWNIUjQzUTFL?=
 =?utf-8?B?emJPSHBtZWVaQ3NRSUIyb211V1pTait4dE9mamVHZnAwL2ZIQlVsOVFZWDZm?=
 =?utf-8?B?NFdIbk54cGpQZzd4cmNKSTkwRGN0RDdSUEFETWhjLzVZRkF3L2xoK3prRmhp?=
 =?utf-8?B?blpiQWhpKzNHeDhsdWlBUVUzVk5rTkR2eXFSd2FldDljUUc5TFhmV0p2Zjhp?=
 =?utf-8?Q?wV9P9UzpG2Rj019xuOqgUaOky?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6004.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68f441cd-cf3c-4f68-4b21-08dc682b0df7
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2024 09:02:10.6502 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 46egZpsQMx0iYrOyusWzmlQZXn9KX1Q6PXpiksNqfyVRcN8K4CJFfiYChTD0LoqqpQxzBW/5zwqKd/g0Y+UdvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8253
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

SGkgTWFyZWsNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYXJlayBW
YXN1dCA8bWFyZXhAZGVueC5kZT4NCj4gU2VudDogRnJpZGF5LCBBcHJpbCAyNiwgMjAyNCA5OjMz
IEFNDQo+IFRvOiB0aGFydmV5QGdhdGV3b3Jrcy5jb20NCj4gQ2M6IHUtYm9vdEBsaXN0cy5kZW54
LmRlOyBBbmdlbG8gRHVyZWdoZWxsbyA8YW5nZWxvQGtlcm5lbC1zcGFjZS5vcmc+Ow0KPiBFbWFu
dWVsZSBHaGlkb2xpIDxlbWFudWVsZS5naGlkb2xpQHRvcmFkZXguY29tPjsgRmFiaW8gRXN0ZXZh
bQ0KPiA8ZmVzdGV2YW1AZ21haWwuY29tPjsgR2F1cmF2IEphaW4gPGdhdXJhdi5qYWluQG54cC5j
b20+OyBIZWlucmljaA0KPiBTY2h1Y2hhcmR0IDx4eXByb24uZ2xwa0BnbXguZGU+OyBNaWNoYWwg
U2ltZWsgPG1pY2hhbC5zaW1la0BhbWQuY29tPjsNCj4gU2ltb24gR2xhc3MgPHNqZ0BjaHJvbWl1
bS5vcmc+OyBTdGVmYW4gUm9lc2UgPHNyQGRlbnguZGU+OyBTdWdob3NoIEdhbnUNCj4gPHN1Z2hv
c2guZ2FudUBsaW5hcm8ub3JnPjsgU3Z5YXRvc2xhdiBSeWhlbCA8Y2xhbW9yOTVAZ21haWwuY29t
PjsgVG9tIFJpbmkNCj4gPHRyaW5pQGtvbnN1bGtvLmNvbT4NCj4gU3ViamVjdDogW0VYVF0gUmU6
IFtQQVRDSCAyLzNdIGNyeXB0by9mc2w6IEludHJvZHVjZSBTUExfRlNMX0NBQU1fUk5HDQo+IA0K
PiBDYXV0aW9uOiBUaGlzIGlzIGFuIGV4dGVybmFsIGVtYWlsLiBQbGVhc2UgdGFrZSBjYXJlIHdo
ZW4gY2xpY2tpbmcgbGlua3Mgb3Igb3BlbmluZw0KPiBhdHRhY2htZW50cy4gV2hlbiBpbiBkb3Vi
dCwgcmVwb3J0IHRoZSBtZXNzYWdlIHVzaW5nIHRoZSAnUmVwb3J0IHRoaXMgZW1haWwnDQo+IGJ1
dHRvbg0KPiANCj4gDQo+IE9uIDQvMjYvMjQgMjoxNiBBTSwgVGltIEhhcnZleSB3cm90ZToNCj4g
DQo+ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2NyeXB0by9mc2wvTWFrZWZpbGUNCj4gPj4gYi9k
cml2ZXJzL2NyeXB0by9mc2wvTWFrZWZpbGUgaW5kZXggN2EyNTQzZTE2Y2MuLjRmYmNlNTE5YTBi
IDEwMDY0NA0KPiA+PiAtLS0gYS9kcml2ZXJzL2NyeXB0by9mc2wvTWFrZWZpbGUNCj4gPj4gKysr
IGIvZHJpdmVycy9jcnlwdG8vZnNsL01ha2VmaWxlDQo+ID4+IEBAIC02LDYgKzYsNiBAQCBvYmot
eSArPSBzZWMubw0KPiA+PiAgIG9iai0kKENPTkZJR19GU0xfQ0FBTSkgKz0ganIubyBmc2xfaGFz
aC5vIGpvYmRlc2MubyBlcnJvci5vDQo+ID4+ICAgb2JqLSQoQ09ORklHX0NNRF9CTE9CKSQoQ09O
RklHX0lNWF9DQUFNX0RFS19FTkNBUCkgKz0gZnNsX2Jsb2Iubw0KPiA+PiAgIG9iai0kKENPTkZJ
R19SU0FfRlJFRVNDQUxFX0VYUCkgKz0gZnNsX3JzYS5vDQo+ID4+IC1vYmotJChDT05GSUdfRlNM
X0NBQU1fUk5HKSArPSBybmcubw0KPiA+PiArb2JqLSQoQ09ORklHXyQoU1BMX1RQTF8pRlNMX0NB
QU1fUk5HKSArPSBybmcubw0KPiA+PiAgIG9iai0kKENPTkZJR19GU0xfRENQX1JORykgKz0gZGNw
X3JuZy5vDQo+ID4+ICAgb2JqLSQoQ09ORklHX0ZTTF9NRkdQUk9UKSArPSBmc2xfbWZncHJvdC5v
DQo+ID4+IC0tDQo+ID4+IDIuNDMuMA0KPiA+Pg0KPiA+DQo+ID4gTWFyZWssDQo+IA0KPiBIaSwN
Cj4gDQo+ID4gVGhhbmtzIC0gdGhpcyBzZXJpZXMgZG9lcyBzb2x2ZSB0aGUgaXNzdWUgSSBhbSBz
ZWVpbmcgaW4gdGhlIFNQTCB3aGVuDQo+ID4gZW5hYmxpbmcgRE1fUk5HLiBJcyB0aGlzIGdvaW5n
IHRvIGNhdXNlIGFuIGlzc3VlIGZvciBwZW9wbGUgd2hvIGV4cGVjdA0KPiA+IGl0IHRvIGJlIGN1
cnJlbnRseSBlbmFibGVkIGFuZCBub3cgaGF2ZSB0byBtYW51YWxseSBlbmFibGUgaXQ/DQo+IA0K
PiBUaGF0J3MgYSBnb29kIHF1ZXN0aW9uLiBJZiBJIGRvICckIGdpdCBncmVwIEZTTF9DQUFNX1JO
RycgLCB0aGVyZSBzZWVtIHRvIGJlIG5vDQo+IHVzZXJzLCBzbyBJIGRvbid0IHRoaW5rIHdlIG5l
ZWQgdG8gd29ycnkgaGVyZSwgcmlnaHQgPw0KPiANCj4gV2l0aCBTUExfRE1fUk5HIGkuZS4gMS8z
IEkgYW0gYSBiaXQgbW9yZSBjb25jZXJuZWQuIEJ1dCwgbG9va2luZyBhdCB0aGUgdXNlcnMNCj4g
dGhhdCBlbmFibGUgRE1fUk5HLCBJIGFtIG5vdCBzZWVpbmcgYW55IG9idmlvdXMgb25lcyB0aGF0
IHdvdWxkIHJlcXVpcmUNCj4gU1BMX0RNX1JORyB0b28uIFdoYXQgZG8geW91IHRoaW5rID8NCg0K
RlNMX0NBQU1fUk5HIGlzIGVuYWJsZWQgYmFzZWQgb24gRE1fUk5HLiBUaGlzIHBhdGNoIHdpbGwg
ZGlzYWJsZSB0aGUgYnVpbGQgb2YgZHJpdmVycy9jcnlwdG8vZnNsL3JuZy5jIGluIFNQTC4NCg0K
UmVnYXJkcw0KR2F1cmF2IEphaW4NCg==
