Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEAB3C2A09B
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 11:43:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B51583CBD;
	Mon,  5 Jan 2026 12:43:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sttls.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sttls.nl header.i=@sttls.nl header.b="Z800txF8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDC9283D17; Mon,  5 Jan 2026 12:43:47 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD1D0839DD
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 12:43:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sttls.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Maarten.Brock@sttls.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k0dw5H6d1T+j/WUp61h8/69k66VfnW2T3fOgmophb+9PSzsu9MmbmrG+tGBw/hvFs8D29aSy60Kleyb9yXuqMHknxHX6RBwJgxpd19RUBghRxcalLIYCir6vqbIDKyYgfAlDLWJuc6xjZG1lgmX+66Mw/iJqpLeIiHTzcpfLgpydxCrZ8WIkgp4DgCFkOSuw+USyD5mpI7oiSPmxj5JSagUs/I5gqdeYzgTWg2vw2olb9tlPSVilHpCAFguXnsf36Ymne0uXkRZkGGaaOSXBRPIYJtrtBr2XSOUZ1t1jGk2GLsIc2A02EL3cL9tiqEeO3bJFkoZoYpidYqY7UwZtIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8S19TOslLZKKuX0jK0oZUt+g0OPlBXnZMtrTPtsdCts=;
 b=FX0ac5mwR5AIDCsYufiXkvPUFrHRoBS2xJdJNf0SYmGKRV2j0oECBHc869J2S+psD07w9f62OxxIGVWlsA1H2f74NJp60p7zo34vgelKQVRdAyMap51hi9i2ipk7vymbFejV2Cks7yd1adNYZywHxx65SdGCWk9uX5D9MdW5JCpOz4K283oMtO+qCRQGN6CZKO//kDK0NzueHY6S5yqe+Po9wkOeofHBK77/AilmgNYhj0gqbRRydFxFQbrg1MWy0geteDvEmRU3/jGOtz+jC+BNqHORRPt3PjsSkUIK6hi5kLDBUVEW+pXF1WorC5f9L0jOUOvhw7S/fHeF3wzCPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=nxp.com smtp.mailfrom=sttls.nl; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=sttls.nl; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sttls.nl; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8S19TOslLZKKuX0jK0oZUt+g0OPlBXnZMtrTPtsdCts=;
 b=Z800txF8Ap40C8KCZz5v4NS885bvLYVMo0nOYUkB5o5GENuGtfxXILPTJrpsL5GOzoXDSoMvudupFlZ6A9r5rkLBwC3XpnDa+iPuvj7Jq265ZEMRzlr6BEQVo0MM/PIdV8a6jmZpKIWZlj/EozCSX/JtUhBvoA40BsQwNGW1k1mD5bBP0vaDVqRSwlXqsDa4QXvIlxLPiMlnrrdKYJW+RtooBlyskH8+2BZh62vMx5JaZLC3j5YRuq9WLVwW1G6mGG0hu1cB4gxJItVkoI6X2UUIBe4V6SqScpYZpOWTvSCLpUEWcE/uum0XSkgG+nQgAPy/Ww8FwvrYPmK1USJyVg==
Received: from DUZPR01CA0062.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c2::15) by DU4PR05MB12197.eurprd05.prod.outlook.com
 (2603:10a6:10:616::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 11:43:36 +0000
Received: from DU6PEPF0000B61E.eurprd02.prod.outlook.com
 (2603:10a6:10:3c2:cafe::22) by DUZPR01CA0062.outlook.office365.com
 (2603:10a6:10:3c2::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Mon, 5
 Jan 2026 11:44:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.93.157.195)
 smtp.mailfrom=sttls.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=sttls.nl;
Received-SPF: Pass (protection.outlook.com: domain of sttls.nl designates
 20.93.157.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.93.157.195; helo=westeu11-emailsignatures-cloud.codetwo.com;
 pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 DU6PEPF0000B61E.mail.protection.outlook.com (10.167.8.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Mon, 5 Jan 2026 11:43:36 +0000
Received: from DUZPR08CU001.outbound.protection.outlook.com (40.93.64.67) by
 westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12)
 via SMTP; Mon, 05 Jan 2026 11:43:35 +0000
Received: from GV2PR05MB11941.eurprd05.prod.outlook.com
 (2603:10a6:150:2cf::21) by AM0PR05MB12335.eurprd05.prod.outlook.com
 (2603:10a6:20b:73e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 11:43:34 +0000
Received: from GV2PR05MB11941.eurprd05.prod.outlook.com
 ([fe80::8532:a1ae:4fc1:3b89]) by GV2PR05MB11941.eurprd05.prod.outlook.com
 ([fe80::8532:a1ae:4fc1:3b89%3]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 11:43:33 +0000
From: Maarten Brock <Maarten.Brock@sttls.nl>
To: Peng Fan <peng.fan@nxp.com>, U-Boot Mailing List <u-boot@lists.denx.de>
CC: David Zang <davidzangcs@gmail.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mathieu Othacehe <othacehe@gnu.org>, Quentin Schulz
 <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: RE: [PATCH] omap_hsmmc: Support CONFIG_MMC_BROKEN_CD
Thread-Topic: [PATCH] omap_hsmmc: Support CONFIG_MMC_BROKEN_CD
Thread-Index: Adx0FCd9b/X98XjTSguLZ16auIS7yAAZ7TGgABD4UQA=
Date: Mon, 5 Jan 2026 11:43:33 +0000
Message-ID: <GV2PR05MB119418B930F7ECB982F03602D8386A@GV2PR05MB11941.eurprd05.prod.outlook.com>
References: <GV2PR05MB1194100C3AFD5CDBCA957E91083B5A@GV2PR05MB11941.eurprd05.prod.outlook.com>
 <PAXPR04MB8459DED744093008D9F2570688B2A@PAXPR04MB8459.eurprd04.prod.outlook.com>
In-Reply-To: <PAXPR04MB8459DED744093008D9F2570688B2A@PAXPR04MB8459.eurprd04.prod.outlook.com>
Accept-Language: en-US, nl-NL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sttls.nl;
x-ms-traffictypediagnostic: GV2PR05MB11941:EE_|AM0PR05MB12335:EE_|DU6PEPF0000B61E:EE_|DU4PR05MB12197:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d1c5fb0-5c65-4caa-108e-08de4c4fa992
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021; 
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?NHJJY0FpQ1FRT2Q1dUtxMDBkaUlCZDBLUE95T1AwS3ExSmV6SzU4Z214c3l5?=
 =?utf-8?B?SUF5L3pRRnA1aHArR29paEh4cDJORzAyNkFMbkora0ZkUXluTDlVcU1TNlVv?=
 =?utf-8?B?Slc4em5UemRqZTZyTkNTQkVUZFhSRm5XNWRnUVdGeFoxK205RDIyQkVQRUNG?=
 =?utf-8?B?a3F4anNvdllEQU9vSG9KUm0rQlZZS0hDdnNPZXMvUEdFNGI1bmFSZHJjbjhr?=
 =?utf-8?B?M1lZcDdVVTBmMHk0cTZxQXpPWHpuUWFrQkxxamJvUVpzQ1pKZDExb0VMNDIx?=
 =?utf-8?B?UmRlc1ZmdDZHTmdhM0FTVWZsL0FCU1l5azZOQjgxUjNQYVNMZmRmL1FLa2x1?=
 =?utf-8?B?UEo3L012dW10azlCN1BuMGVCZk0zRVFkNEg4MkE2clJvRmg3ei91amlWRDY0?=
 =?utf-8?B?aXhjTVo0TWhvekhuVk56RmVZQXI5aHdtc0djcm5jcFBleWZzVEhjcGovVzNY?=
 =?utf-8?B?OUlEUDcySTJvcis0OXBDRkZGVnZvd1R0cnRndVZsVThoRjJncnhHL240aXk4?=
 =?utf-8?B?MzIzYlNaMUFoM1k3SVpPL3dmdUp2RXRxMkk3aEhzYkZ5bWRrUXVXMjF0Wmhk?=
 =?utf-8?B?TU14eXRITkVOa0lrSEJYc093ZjdhZTlqZ2NabmhBeHpXVGhKeW16U0VycFdz?=
 =?utf-8?B?YWFaVjNDUVVRNzlLVHZ4VXdrQ0l2M29ZanJKQmh2SmtDQVVyTUU1NnZONU43?=
 =?utf-8?B?VHBTcEwxUmo1QkNRRGlneG02NVRLclRScUxEZk9ZMWJDeUdWRjlyTVBKZVRT?=
 =?utf-8?B?a0FUbjkwRm5xNmU5VWRSRTIxazdxZlpLYmc5ZGpSOEc2QUpvdDFUamR4QUtn?=
 =?utf-8?B?aTBQbkFGYjQrcW50T2lGZHgwYnhzVmJFeEYrcjVNLy84c2lscFVuYW9CaXRC?=
 =?utf-8?B?OXh3MHZGMjZWTnRkTkV3ZHlIMTlTN012M3ArYlZxSDhSeDBwamY0RnZ5d2Qr?=
 =?utf-8?B?QXFKRGNwZiszNU9IZktCUGIxblJUY3RDelBBQzQ4cFBBVlQ5NjI4WkxBWFRW?=
 =?utf-8?B?MHFMVEtUVGRQRFFXMzFxOStHRkF6VUc1ZDVxcWJ6eWhQeE1wTEdLTjB0ODht?=
 =?utf-8?B?b082SU91M2NjRzdKWnF1bFBObDBTaEluRkJKRk4rYWV5OWY3cmFPQmV2QVdJ?=
 =?utf-8?B?ZUxjZEVrazVObFdDY2U2d3lPV1MrY2FUdzR1b1dWOTA3OTVvREFPRUU4Q0ZF?=
 =?utf-8?B?Y051TTNiVDFtcW0wWWl2NURMdnhJMkk5VFhCZVMzNXNPdEh6MUlma2JyMWZJ?=
 =?utf-8?B?Q2tRdEtXekxrbHkveGpvQ0RWeHdKZ28wRHE3NkNQdnZNbDRFd0Z6cUI3WEYy?=
 =?utf-8?B?RmdkS1h1ellFME1vcmI0OTB3WmQyMXlpWFFEdUtGeTF0bzg3ektneXR6Tmx5?=
 =?utf-8?B?OTMwRVJUYnJEM3RJYW81aEdxV0Z5NWVDSFN1dHJtZHkwcjcrYVFpTXZUZFlV?=
 =?utf-8?B?Zmk1azQ2ckVkcmFPbWc3Q25saTRndFRuUndScXBQV3NEWjlRbTZOWnZZSEFW?=
 =?utf-8?B?MlhndU1rZ3FYUWFsU3pHTzdDaDBVVEdpUmhRMTY1ZlJ3REE1YVlzUDIrMmcx?=
 =?utf-8?B?WXlaSk4yUHIvTG9Mdlk1WUtaQVBvUTd5VnloaTBITklzeFErWVIyV0JaeExn?=
 =?utf-8?B?eHdqVDZzc09MTm51YmV4WUhTY1d2dHo1aUI5MmQvOTNzR2pYdk5uSEZTcExP?=
 =?utf-8?B?SXM5M1NZaGg4SmtjcXJqN0tCazh1eW9xZzZ4UWtpZ3ZnaUZkVEtVcW55UmtR?=
 =?utf-8?B?d2ZJRmNlNE9jbWdGcXNJQ0JCRjhjdFlSbVhhVFgzcHh1dzNWckRyRFRKZlJa?=
 =?utf-8?B?NWNJRTdjT3EreXZUQzIxdmJIRkNucGRnMzNGMVZOa2ZyM2Vjb2ViYWUzTVVK?=
 =?utf-8?B?SmtlelpXSEpyWkZBVitra05XMm1KTTJnQmswTENtc05zVzZkUlc0RVBwV3R6?=
 =?utf-8?B?QkQ1Tno3cXVwRVNoM1FJQXl5RWUwd3MweXlzeDkyZlBOQ3V3Z3I0N2hrbTZF?=
 =?utf-8?B?TjRYUllhSVVDTEpLbmJsWDZsZnZYQ0hsUU5yaGd2SFlNUVhFZHd0NXdycitJ?=
 =?utf-8?Q?LMFRdV?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:GV2PR05MB11941.eurprd05.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(376014)(1800799024)(366016)(38070700021);
 DIR:OUT; SFP:1102; 
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB12335
X-CodeTwo-MessageID: d9d6e796-dfa4-477d-b22c-e53788e6bed2.20260105114335@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU6PEPF0000B61E.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 6d61d682-5b81-4ee9-4672-08de4c4fa804
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024|35042699022|14060799003|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UUJoTG1HRHhCaHV1N2MwWG9LY2wwcWR0WGRWbXAxSEprbnNGNkVnejVhM0lC?=
 =?utf-8?B?T3B0VzNEK0ZVenU2NTdmYThUMWg0R2xZdjlGaFRmTnVTaFluQTAxWjlGa0dZ?=
 =?utf-8?B?RTB2VjFUdTg5endyMUtRcTBieFFiYTI5S09MT3RjNVBRbDFxT0JWZEF2UkNZ?=
 =?utf-8?B?VVZpVFNCN3RLWnMxT3hmblF6T1hoeGsxM1ltS0JkU3QvZjNoN09oY1hPSFd0?=
 =?utf-8?B?R0ZjTXdZVktnMmVtRjJJN3NOZlNiZlhTRTRZcFRvV3g3enFldTBWMFo5OG4y?=
 =?utf-8?B?K096SEdnOEl3ZmRyQjd6NVZHTmZMcERjclBYQTErWmlMakYwL3lobmlLaEFW?=
 =?utf-8?B?Uk5jYTUyUnVrQXlEbTEyREdJVEJscU5DaHVKNnRyeHZxcU94dmpVZDBFYzRU?=
 =?utf-8?B?akxEM3lvMWM1VHV5RzNDWmp6SHFJQklldGpBV0FtNjdoWVlJYzNiUU9WTjZ5?=
 =?utf-8?B?TENKc05ucDZSN3F5bGVDb2ZTWXBjVVE3WE9RNmd6ZERPOHNwOGNIODJONkM5?=
 =?utf-8?B?QTNhczVJNktFZXFmcjJBNytBelZ6RCtvVDFpbE90UlVLR21QVTl1SnduT1lq?=
 =?utf-8?B?NG5YcEo0V095eEU2UzJsNHpwREZJRlNzTkE2QTQ2Q3F0Y0h4MnMxSHBGU0NU?=
 =?utf-8?B?MlBhVHpJUE15TStsb3REbmJNckxMQzljblc4VHVyL29mYXQyeFFuSitUTWNt?=
 =?utf-8?B?c3gxVlcrOGwyY3l0WXRzY2haZlFMK1JIRkRUb1dOK1hWVCtzSS9WVEtGU1VZ?=
 =?utf-8?B?UnRyNVRmN1ZVZkJQbmFONWFIWW0wTVJVQUNlb25oMjNOV0h5ZEVNSWt0QjRz?=
 =?utf-8?B?RDk0U2dxN1BMcjJpeWtpd3phRTMrc0pOTlo5ZDFxRGRJWlozU2EvQlI5blY1?=
 =?utf-8?B?WnFOVHZEMXQ1RElPMUhaOUNzQ1NIWmV5WTBLTGMvR2YyZm1tb2F3U3BxSUNM?=
 =?utf-8?B?ZDFWN1JEaUgrbExvSjkxdmoxN2psZUN5ME5RMUtOYWVPTUk5U2FDaXFGdEhz?=
 =?utf-8?B?S3p2OWt1WWJ2V1ZxTGlXU1cxdGJWVmpLVkg5RXZsSXJtei9TZW5DWDQzZmlM?=
 =?utf-8?B?WVRZVGpaSnBZQVdhcmhjNlNVeENWVzQ0RllDRkpjQ1hOa0tvbjhmYjc1a1JB?=
 =?utf-8?B?bHhlZlMveENQbEQ3c1c2USs2ZHo0Y3o4eTlacHcwV0VtY2t2R09PNXRIZ2ZU?=
 =?utf-8?B?d0QwZ1pJbzhDcXdrVHEzYUF1VVo5R0lnM1Q5KytHWWpkZUkwTVE4UHMyTk45?=
 =?utf-8?B?QnRVcHA2NjZkeVV6d3FYNlVnNFF5UmlLR0hXRUVUOHVzbUhaMGs5RW0rSHNq?=
 =?utf-8?B?VkszeFR2MzI2MnFIcmcxc08vOFE3ejlSYURPck5HRDIvNGo4eStxUDR3N2s4?=
 =?utf-8?B?WnErVWxhRk5YUVVGNlU4Y1o4MlhxOWNIbDBNQ0RVVUhCSFpiT3JZRk5oV1I5?=
 =?utf-8?B?eE5ZbGNqYThMQWYzOTZzRUwvQVdSOEFGM1FnbWpKUm96TDZPWThDd1ZZYXdr?=
 =?utf-8?B?R3VDQ1BBQ3pkRW9FVzFGYjJycW4rNCtlQjZGRWtaVFlIajE5S0Q2VVlYUW41?=
 =?utf-8?B?WjZNdmRabFRDczF2R1I2aXNydmQ5YVZycllUTkZaK2RrSFZRbkk3MEVlZG9Q?=
 =?utf-8?B?eG5ZTTBkbDVJd0FSL1BNNXRaYWZsdEJDVDdTVlY4V2hra2xLeEtTMXNkMk5E?=
 =?utf-8?B?VmZBejNpTTc5WkxDSkxRMFZpVU5qOHhOMEs5TFZRdk96Y3l4eFlqWGlSeHNH?=
 =?utf-8?B?a1hITm1xT2doUE1PT1YrcnFoVWlpdTdUaExRRUZhMkVMV1dPM2tMZWlWNHhK?=
 =?utf-8?B?OUNUOS9kbnRTb2twNDVGdFAxN01hbDZicWRZWXNqYU5IY1NqbEUremFjN2hj?=
 =?utf-8?B?RjM4cXdRKzdZM282TURNVjNqNEhOK2hXTU5qSG1Ra0M3Y3VJWW8rQ3VsWTl3?=
 =?utf-8?B?S2xCVWRieCtQK3phMmRpa3NQUmN5SU5veWxTMkNVeGppeUIyR1pRSVlBemRW?=
 =?utf-8?B?TWFmWERyUTNna1k4ZUp6SW01bEp1a28zaysySVZFbUlvcTZnajVQazBIaTcy?=
 =?utf-8?B?ZFh1Ky9pYU4xNmtkUk4zOVZZWlI3ZG5SNmhhcW5XKzc0b1Z3eFNPNFRvV0Nr?=
 =?utf-8?Q?8a34=3D?=
X-Forefront-Antispam-Report: CIP:20.93.157.195; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:westeu11-emailsignatures-cloud.codetwo.com;
 PTR:westeu11-emailsignatures-cloud.codetwo.com; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024)(35042699022)(14060799003)(7053199007);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: sttls.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 11:43:36.2759 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d1c5fb0-5c65-4caa-108e-08de4c4fa992
X-MS-Exchange-CrossTenant-Id: 86583a9a-af49-4f90-b51f-a573c9641d6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=86583a9a-af49-4f90-b51f-a573c9641d6a; Ip=[20.93.157.195];
 Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000B61E.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR05MB12197
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

SGVsbG8gUGVuZywNCg0KPiBGcm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gU2Vu
dDogV2VkbmVzZGF5LCAyNCBEZWNlbWJlciAyMDI1IDAzOjIyDQo+IA0KPiA+IFN1YmplY3Q6IFtQ
QVRDSF0gb21hcF9oc21tYzogU3VwcG9ydCBDT05GSUdfTU1DX0JST0tFTl9DRA0KPiA+DQo+ID4g
QWRkIHN1cHBvcnQgZm9yIHRoZSBDT05GSUdfTU1DX0JST0tFTl9DRCBvcHRpb24gdG8NCj4gPiBv
bWFwX2hzbW1jLmMgVGhpcyBzaG91bGQgYmUgc2VsZWN0ZWQgd2hlbiB0aGVyZSBpcyBubyBDYXJk
IERldGVjdA0KPiA+IGNvbm5lY3Rpb24gb24gYSBib2FyZC4NCj4gDQo+IFRoZXJlIGlzIGJyb2tl
bi1jZCBwcm9wZXJ0eSBpbiBjb21tb24gbW1jIGNvbnRyb2xsZXIgeWFtbCwNCj4gY291bGQgdGhp
cyBiZSB1c2VkIGZvciB5b3VyIGNhc2UgYnkgcGFyc2luZyBicm9rZW4tY2QgcHJvcGVydHk/DQoN
CkFyZSB5b3UgaW1wbHlpbmcgdGhhdCB0aGUgY3VycmVudGx5IGV4aXN0aW5nIENPTkZJR19NTUNf
QlJPS0VOX0NEDQpvcHRpb24gdXNlZCBpbiBkcml2ZXJzL21tYy9tbWMuYyBpcy9zaG91bGQgYmUg
ZGVwcmVjYXRlZCBhbmQNCndpbGwvc2hvdWxkIGJlIHJlbW92ZWQgaW4gdGhlIGZvcnNlZWFibGUg
ZnV0dXJlPw0KDQo+IFJlZ2FyZHMNCj4gUGVuZy4NCg0KS2luZCByZWdhcmRzLA0KTWFhcnRlbiBC
cm9jaw0K
