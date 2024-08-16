Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06EDCC52D7D
	for <u-boot@archiver.kernel.org>; Fri, 16 Aug 2024 12:33:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F3F888B11;
	Fri, 16 Aug 2024 14:33:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="TilcrsAD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 088F188AFF; Fri, 16 Aug 2024 14:33:46 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::62f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2B8488B06
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 14:33:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VJlFcwUeYvs9DbD5V0MVNev8994E6J8f0kmH+XFMQR0pMkMJWWSAL7wEZu9A4sG+lOTyfueQEvpPR7aKc4WVAIrw5jw0CDrHx3pdURkbXz8x8p5w/dKmg6aZimt+Ayg9gC8rmwWt7muYVljVUXBTMDPwl0t0tmIzSnQppG2vLPaG3faArr5io8Ef2cQ7w//FN3BLXXKd/5fyj3PFTJtwx5SgkV/lCm4ZZzw+JJPnmG2wzx2+anvRVc5toc/rq253vrf0YERHGFu5Vcu5X04I1cJc1WAEeJGzGOYa/xZSWMRdLZbbzsa6r28Ad2NQunozEVzJqotUf+1JdTV04zn57Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WcbrauvUiWfF5CEC9DbDWc7btzXZaOZ/kGAwE5SyS40=;
 b=fHOW8l7YCi5vAxv31qobRoIFlSiQDCBovVMgnqXrtQzGcdYxvpTH6ttaWM07hrUdAD8NgNEh8Rbx0gHspYYiyZPFsnvqVaqJWBP6UEhrx+hJkk9RY8poSCfXL/Jc8mqFo4cL5D7vxG2CPBa3u4IlQyLFEVVJx+pe1UNHTnY/pKtgjYlLmlIbEyBD7q82Ybf5QsqMZ/20Vvw6rzmwKg+9AL1iInmpvMdjC0qv17AmwM02TwzWGLaHQA0+oCWO6ouTHchhbKFILixis+hxtliglodT8IsIqHk+/U1C52027Wy2xr2pnMciL0HwLOXc2pOw998w27wLriIzNtAYRTD7ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WcbrauvUiWfF5CEC9DbDWc7btzXZaOZ/kGAwE5SyS40=;
 b=TilcrsADlxpU6NmEgOHLsFPvKauTOvREnu/hFKA8wTtosf4kP2IChqqRNPBkkjCATC8SZhEJ9oV0q59ns1Tc2VYyYgQM/qfJa2RVbn+sahxF6ZZVhFrEoQUVd9FhN3TwgIYWldhkKd+nU8uaFpRNMemttOiAq1sP0g8LDJhQXwn91+mFoLco25BtNfwLNt9bKzjq7Wh6z3XUOmOdC83SmB90MTmrtRRgroL925Zpys6cjuS003iSWU7aYzKL89lHT9VBTQoGK0Ev5n+WjQC3M6H7eQXgdR1+5BHGSzwdKBoaOmiI3DBLIn+WlKTXCpZ9yy2vM3F1Q4zgYypNLg9/tQ==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by PAXPR10MB7630.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:283::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.25; Fri, 16 Aug
 2024 12:33:35 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%3]) with mapi id 15.20.7849.021; Fri, 16 Aug 2024
 12:33:34 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "bb@ti.com" <bb@ti.com>, "joao.goncalves@toradex.com"
 <joao.goncalves@toradex.com>, "c-vankar@ti.com" <c-vankar@ti.com>,
 "rogerq@kernel.org" <rogerq@kernel.org>, "nm@ti.com" <nm@ti.com>,
 "dannenberg@ti.com" <dannenberg@ti.com>, "n-jain1@ti.com" <n-jain1@ti.com>,
 "n-francis@ti.com" <n-francis@ti.com>, "mripard@kernel.org"
 <mripard@kernel.org>, "afd@ti.com" <afd@ti.com>, "trini@konsulko.com"
 <trini@konsulko.com>, "seanga2@gmail.com" <seanga2@gmail.com>,
 "s-vadapalli@ti.com" <s-vadapalli@ti.com>, "michal.simek@amd.com"
 <michal.simek@amd.com>, "d-gole@ti.com" <d-gole@ti.com>, "danishanwar@ti.com"
 <danishanwar@ti.com>, "devarsht@ti.com" <devarsht@ti.com>,
 "w.egorov@phytec.de" <w.egorov@phytec.de>, "mkorpershoek@baylibre.com"
 <mkorpershoek@baylibre.com>, "jonas@kwiboo.se" <jonas@kwiboo.se>,
 "kishon@ti.com" <kishon@ti.com>, "sjoerd@collabora.com"
 <sjoerd@collabora.com>, "sjg@chromium.org" <sjg@chromium.org>,
 "u-kumar1@ti.com" <u-kumar1@ti.com>, "matthias.schiffer@ew.tq-group.com"
 <matthias.schiffer@ew.tq-group.com>, "vigneshr@ti.com" <vigneshr@ti.com>,
 "kabel@kernel.org" <kabel@kernel.org>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "srk@ti.com" <srk@ti.com>
Subject: Re: [PATCH v3 03/10] soc: ti: k3-navss-ringacc: Initialize base
 address of ring cfg registers
Thread-Topic: [PATCH v3 03/10] soc: ti: k3-navss-ringacc: Initialize base
 address of ring cfg registers
Thread-Index: AQHazpbx25aPxdXhGkWgHpVB11E0V7IqE9QA
Date: Fri, 16 Aug 2024 12:33:34 +0000
Message-ID: <e50f49dcdc113e562801768f0a79f2c1f489eace.camel@siemens.com>
References: <20240705045030.1141934-1-c-vankar@ti.com>
 <20240705045030.1141934-4-c-vankar@ti.com>
In-Reply-To: <20240705045030.1141934-4-c-vankar@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|PAXPR10MB7630:EE_
x-ms-office365-filtering-correlation-id: 40e286dc-8e83-4fb7-26e8-08dcbdefa4fb
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|921020|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?N1pxRU5IUGFraHkwQ3ZwU0I1MldTUW80YTlHREtWZzhVZy9IY0FldnFXWHZE?=
 =?utf-8?B?cGdFOHRzbXlZZGtWQm1IczFKNTY5Smx3cDIrbHM3b2NISjlkM1VoMWJXUEdn?=
 =?utf-8?B?ZzFpZk1KWTBLNzhiZjNNODdlZDBEaGdKYUlIa1VVUkRkOXRobnNxNjRUbHBK?=
 =?utf-8?B?RFYrQmVUSng0UXhlNFJudkxtejJPUU1EUmZKQ2ZxNXpRSlVoWThNbDVQV0RV?=
 =?utf-8?B?aUJWWlZXaHBJUEpMTUZVaHRpS1Q2dFNNUk10cVBTVW5xajk1WlBxb1ZKS2ox?=
 =?utf-8?B?bFdqRXZaTnBOUDN3elFjMS85THI5RHN4WjZZcWUrZWxFN1BDeHpsU3VTd3lL?=
 =?utf-8?B?R1ArSDlnNnd6dmI0alB1VFVpQWZKRUtERkRMYlRkVWc5ajhXOXpyekZDRVRj?=
 =?utf-8?B?UWgvb3dWV3BHM2JWbjBzNU1DR2N2WGFoN0Q1OTBxR3dPM3BQd2R4Q3Rzd3hR?=
 =?utf-8?B?UGhYNW16aXNJbmY1M0dJMDlTaUNlV2M3dm41T3h1bmpFT2pEQVNIM3dLMHR6?=
 =?utf-8?B?UFhZSElvTmFQU1NhTEVmbDFieWJBdjBYK3JoYlFTVGx1NFVVT1BGWmR4bDJi?=
 =?utf-8?B?elJmK1hFaW16TCt4Y2ZMTUNzdlg4YVl6NUNvY29SdWZHTEcwc1d0aGlzbDRp?=
 =?utf-8?B?SWtrWDVpSm4ySzhCaUUxZTV6dll1RENzcmxIb1J4bjAxeHQ5YVphQWx6OFlG?=
 =?utf-8?B?UHVkeUtTekxhdlNGbUswbUpPUmoya3RVQ3JxQjQ5aUNMbUF3SU4yME5NYjY4?=
 =?utf-8?B?R0laZmkvWVFXUjN0YUlLbnY3QXBIWnBZK09zTTVyR2tSUWJ1MURmVGhucHBz?=
 =?utf-8?B?NXJ4aEJQQ0duODJFdnFMczFHM3BEWkRCTm9kQjhQWjNkSU5kYWhZQTl1QVVP?=
 =?utf-8?B?eXloU0w0dzNEOUE3Y3VvK2p4L1RTWWw3YXZQbVpmY1ZZQVdHeURDNjJRMWNT?=
 =?utf-8?B?YWdXZk5NQjJJbjRSTE0wdGFyYjhmazhXMFZ0WC8raFdndDVGZzRKVzhuQm5W?=
 =?utf-8?B?Mm84Y1NiS1BJME82Q3RVcVdZcGk5RUVpRUF1NitrSUh0WUxIWkVKNjFLS1FV?=
 =?utf-8?B?NnVObEU2eDRkSTZaYUt0YUdIZzJQWXNGZkFPNGhtVmd6dHdzajNxM0pXZ1BN?=
 =?utf-8?B?MkhVTGk0bEwzWVpUcE0xSkk3LzB5UFhLdmNkRmJqc2VzREZRTjZQTmZYZVV2?=
 =?utf-8?B?UExBbk13VGdHUDJPV1J0UmtiK2FlNkMyakpLM2kzVVdabmN6YWVQNVlibG1F?=
 =?utf-8?B?bDMvcG81VzB3UFJFVkw1R0YrblFHcXByQTBrN1ovWmhmbzNNaEtVdHZyUnhS?=
 =?utf-8?B?eVY2a3NRZTByNW9GVDlnVGxHQWV0UGxxUlZGMVRFU2xod3RhWHdTYUx5YklJ?=
 =?utf-8?B?ZE85TE9scFlRTEpjYWdCcXkwRnVFZTN0NlVGczlGVmJvdzVvNmUyeDBPV2JJ?=
 =?utf-8?B?ZDd5YjRjSmh2c04xRUJqUHJYZGdEM3l1aFg4dFdwdHRTalBTYUxCVkZIc00y?=
 =?utf-8?B?THlPNHljWmhxL09ObWtac1FucmtkT1M2NFcwNHpJVklnK1ZoOHlnUW5jQkRE?=
 =?utf-8?B?L0VCVmFoazR3Rnh0aG9pY1oyWjNRTE9rUnM4eUYrcERvWUo5cERpUG5DcWtY?=
 =?utf-8?B?Z1c5c1JJSjg4ZFkvQnNrOHAyWmIyR0FVSmJiUlpsOWRmaG9RaEEvVGFjTUh3?=
 =?utf-8?B?Tk9lQWRxUWhyN05CaUdkR0pxL2Y3WVdwTDZTS1ptWHNRSkpDVFJQMnlpV0sr?=
 =?utf-8?B?QXR3ZDVDbjlRTGdqZ3JwL3FNdS9DV1I4TFo3OFlVWUd3b2pVWlpCWGw3Y2Vu?=
 =?utf-8?B?cHdiYVJpRmJqMXdiOEErSE9VYjhjY3FwaGU5U2pRNDRUTXA5bWpBYUNaRExJ?=
 =?utf-8?Q?y1kvx7bBy0Yqc?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WWROVCtaUmtudjBUSWd5L0dZTlB0UE1rQWZiVVprbm5xRXArRHJOWFdSNlJZ?=
 =?utf-8?B?WlJmRkZKS0NGbnE1NWxlb2pPV1F1M0RCTmVPN0lzajdYQ01BVDk4MnVmNm1H?=
 =?utf-8?B?a01YcVpVN2pJME9pUEIxK3RTVmg3My9YSlgzR3I1Zk5jOXlsdUJTMzRkb0Vt?=
 =?utf-8?B?Q1F6Sm5KUlJLRkRocDc2U0hhNWQ1NklVUnpRdi93Z2xMQ2pSZVAwck1IYUhK?=
 =?utf-8?B?V0dwUENaNzZaa0g0MndTZnZ3Yk1kTkJ5V1dESklQanJlVDAzR3hXNnhDSERP?=
 =?utf-8?B?Q0NWZXNnOENaaTluZUl0NnJkb2R4MVVjYi95aGRSQVY5VGdDQUJ2TVJWdEdT?=
 =?utf-8?B?YldKek9PWXYyVndHQjlIQmE5NE1NQ0E1VFJNTCtrTXpWV3ovRVJMZ3VseEdR?=
 =?utf-8?B?MFY1TzZseWFJc1BTb2JKZzNWNE5LUFdxK2ozWS9yRnM5TkY3cnljVkdXVCs0?=
 =?utf-8?B?bytSdTRndTh1T0ZnZlVHVjhzbGVoSjNTR0JqeDBIeWZnTjlvOGRYRElTL3FM?=
 =?utf-8?B?RVpvK3kxdk5kU3dTcGU3WkovVmNyTUZyQUx0cDQvYWhpQ2hWZ3gwTDQvODht?=
 =?utf-8?B?YjVsdHdGZmVubmk0aGlqamJ5SkFWL2R3R2xKVm1xemxoMzByMmdRSjRoTU43?=
 =?utf-8?B?NUlCUXlJL3pnN0RPT29ySmwwcXA3MUQzU0lUeVI2WGp4YUs1RnlpRWVXTG1N?=
 =?utf-8?B?ZlZ0QVBvaHJlRGFuR2ZhWGp0d2tMeGdUQi9xUmFMZnFxbmQ5YVZFUHZCQ3hI?=
 =?utf-8?B?UzRhekRmM1o0V3RISm1FcUpyOEtsU0U2VEFvMDljQUJ2VXVUbUNaTVdlV1dm?=
 =?utf-8?B?bi9xRGdkRlFjZnV0TTFUVEpaaXkxTFpxVGRYVmpBNFlJdENZbnU3T1kxRUMx?=
 =?utf-8?B?Z05Bcy9CR1pjcjNQTjFBdXRJejhLYk5XZVEwTk1zbklMNCtaTGpFVDAraFB3?=
 =?utf-8?B?ZDdUUkE0REYzS0R6d0JvdkJmZWFiK1hJdUtrTVVqUTIrUjNLYkdlc3g5NGc0?=
 =?utf-8?B?bVd0bS9wZG4rRmlWZjBzekh4aGZjSDA4S3gvUEF2YWlFbDhCckx0a1BqS1U2?=
 =?utf-8?B?U3QvdWxyQjJWSE9UZnM0R0xhd1dTQVZqMXo5RWF6QmFTNW56M0hLbW5ZQzJ1?=
 =?utf-8?B?ZkVJZkJqaVE0WDFaVDhpVkZQNEkxajBxZ0dCNVlzZW04bFZvQ2U2NklDM0tX?=
 =?utf-8?B?dG5rdGxicituU05uOEMrYWNqQmtEQmFXYnNLVHpkc2x4VXQra0laeTQ1Wk5M?=
 =?utf-8?B?UWhZM2JMcEh1ekVzOHAyR0NSY0FJamFqSUtZdmgwcnVGVHFINlF1L1Z2MXNR?=
 =?utf-8?B?aEpjY2kvV2paUTZsSHBTMlE5WERsZEd6dCtmUHNFcjhPYUlEdExYM2VVV25x?=
 =?utf-8?B?TXBvZmpQRW9KVGl1ZE1xVGJTTzVMQ1NKb0VpRndKUHdNN2d3eUpaa2NwQ09C?=
 =?utf-8?B?UGNvZjhXOU84TDdNc010ME9ZOXV2U21xcFZPdHFMcnBvYWcxcTAxSTFhdG8y?=
 =?utf-8?B?UlN3Um1pNEcxRDdsb1hOeFdkck91U3JqU0FIMTRiMHcyUFdpWmw5T09USEFS?=
 =?utf-8?B?OVhCQlZCbXpRUTVJUEFITnk0QWdwcndVS2xqZWVJTkRyeTFxZm1HUi9UY0N6?=
 =?utf-8?B?cVY1VXRsRWtYOWR0TXVtVG5GN2oyaWIyNUdNRGZxSkV2SGI0K0ZCRGRKcE8x?=
 =?utf-8?B?L2czY3FQdGFvajJ3WG9IZ3BuMXN6Y1R0aDRod3BzbGFxdE1ybGNFOWRkNk9j?=
 =?utf-8?B?Y2l2RzUwdW5vaHd3cElrMDk4Rk1va1dPa1lFYUpnc05QWlVWUEswU3ZzUEdi?=
 =?utf-8?B?Smg4bSswNFNIWHRPSXJFZmpleTFNUzZvOGN4cmxaSHhTcFVLSTBQalJoYm8v?=
 =?utf-8?B?NmR5cGNkVTI5RE5EakF3d0M5RjZ3UGZORVJFOThIWHM0KzNNejd2bzl2d2pM?=
 =?utf-8?B?TEZ2Rm43QTc2V01tUG4yMEViMVlxSkpaZEdTTEJJalZVOTZyQTlFblNIVXBx?=
 =?utf-8?B?VFFzVWZNNHlqSS9UKzFCVUdIOSt2MmtrR3NDNmdNbVpsOWVJSzhHRWN0VEpR?=
 =?utf-8?B?eVM5Uis5SUJoOW0yZDA2ck5EbU1wVE9sdElFNnk0a25CZkJoYVJOb0hGTmVI?=
 =?utf-8?B?TWdhbkdjOXlDS1FKbUVaWCtKMmliaE1ibnN3UjFBUVZnNFFKMXpZQWFCclow?=
 =?utf-8?B?Qmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BFE04E5CB905904EAD21D9D47C52DA1C@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 40e286dc-8e83-4fb7-26e8-08dcbdefa4fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2024 12:33:34.2435 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pJMVM7JYNl0y/S2yaL924iuVSPdyck8v/NfsUwplqVyq7j1s1LzrAF5Dgb9jHIdkvcTOx1HN5jGAIzL3K6TElAGaXrKlBqfH7D5Uj1bS654=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB7630
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

T24gRnJpLCAyMDI0LTA3LTA1IGF0IDEwOjIwICswNTMwLCBDaGludGFuIFZhbmthciB3cm90ZToN
Cj4gRnJvbTogS2lzaG9uIFZpamF5IEFicmFoYW0gSSA8a2lzaG9uQHRpLmNvbT4NCj4gDQo+IElu
aXRpYWxpemUgYmFzZSBhZGRyZXNzIG9mIHJpbmcgY29uZmlnIHJlZ2lzdGVycyByZXF1aXJlZCB0
byBuYXRpdmVseQ0KPiBzZXR1cCByaW5nIGNmZyByZWdpc3RlcnMgaW4gdGhlIGFic2VuY2Ugb2Yg
RGV2aWNlIE1hbmFnZXIgKERNKSBzZXJ2aWNlcw0KPiBhdCBSNSBTUEwgc3RhZ2UuIFNpbmNlIHJl
Z2lzdGVyIHByb3BlcnR5IGlzIGRlZmluZWQgYXMgInJpbmciIGZvciBQS1RETUENCj4gYW5kICJj
ZmciIGZvciBVRE1BLCBjb25maWd1cmUgYmFzZSBhZGRyZXNzIG9mIHJpbmcgY29uZmlndXJhdGlv
biByZWdpc3Rlcg0KPiBhY2NvcmRpbmdseS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEtpc2hvbiBW
aWpheSBBYnJhaGFtIEkgPGtpc2hvbkB0aS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFNpZGRoYXJ0
aCBWYWRhcGFsbGkgPHMtdmFkYXBhbGxpQHRpLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogQ2hpbnRh
biBWYW5rYXIgPGMtdmFua2FyQHRpLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IEFsZXhhbmRlciBTdmVy
ZGxpbiA8YWxleGFuZGVyLnN2ZXJkbGluQHNpZW1lbnMuY29tPg0KDQo+IC0tLQ0KPiANCj4gTGlu
ayB0byB2MjoNCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI0MDQyNTEyMDgyMi4yMDQ4
MDEyLTQtYy12YW5rYXJAdGkuY29tLw0KPiANCj4gQ2hhbmdlcyBmcm9tIHYyIHRvIHYzOg0KPiAt
IFNpbmNlIHJlZ2lzdGVyIHByb3BlcnR5IGlzIGRlZmluZWQgYXMgInJpbmciIGZvciBQS1RETUEg
YW5kICJjZmciDQo+IMKgIGZvciBVRE1BLCBjaGFuZ2UgY29uZGl0b24gdG8gY29uZmlndXJlIHRo
ZSBiYXNlIGFkZHJlc3Mgb2YgcmluZw0KPiDCoCBjb25maWd1cmF0aW9uIHJlZ2lzdGVyIGFjY29y
ZGluZ2x5Lg0KPiANCj4gwqBkcml2ZXJzL3NvYy90aS9rMy1uYXZzcy1yaW5nYWNjLmMgfCAxNyAr
KysrKysrKysrKysrKysrLQ0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspLCAx
IGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zb2MvdGkvazMtbmF2c3Mt
cmluZ2FjYy5jIGIvZHJpdmVycy9zb2MvdGkvazMtbmF2c3MtcmluZ2FjYy5jDQo+IGluZGV4IGQz
ZjNkNDc2MWMuLjhmZmI2MTM3ZGYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvc29jL3RpL2szLW5h
dnNzLXJpbmdhY2MuYw0KPiArKysgYi9kcml2ZXJzL3NvYy90aS9rMy1uYXZzcy1yaW5nYWNjLmMN
Cj4gQEAgLTEwMjksOCArMTAyOSw4IEBAIHN0YXRpYyBpbnQgazNfbmF2X3JpbmdhY2NfaW5pdChz
dHJ1Y3QgdWRldmljZSAqZGV2LCBzdHJ1Y3QgazNfbmF2X3JpbmdhY2MgKnJpbmdhDQo+IMKgc3Ry
dWN0IGszX25hdl9yaW5nYWNjICprM19yaW5nYWNjX2RtYXJpbmdzX2luaXQoc3RydWN0IHVkZXZp
Y2UgKmRldiwNCj4gwqAJCQkJCQlzdHJ1Y3QgazNfcmluZ2FjY19pbml0X2RhdGEgKmRhdGEpDQo+
IMKgew0KPiArCXZvaWQgX19pb21lbSAqYmFzZV9ydCwgKmJhc2VfY2ZnOw0KPiDCoAlzdHJ1Y3Qg
azNfbmF2X3JpbmdhY2MgKnJpbmdhY2M7DQo+IC0Jdm9pZCBfX2lvbWVtICpiYXNlX3J0Ow0KPiDC
oAlpbnQgaTsNCj4gwqANCj4gwqAJcmluZ2FjYyA9IGRldm1fa3phbGxvYyhkZXYsIHNpemVvZigq
cmluZ2FjYyksIEdGUF9LRVJORUwpOw0KPiBAQCAtMTA0OCw2ICsxMDQ4LDIwIEBAIHN0cnVjdCBr
M19uYXZfcmluZ2FjYyAqazNfcmluZ2FjY19kbWFyaW5nc19pbml0KHN0cnVjdCB1ZGV2aWNlICpk
ZXYsDQo+IMKgCWlmICghYmFzZV9ydCkNCj4gwqAJCXJldHVybiBFUlJfUFRSKC1FSU5WQUwpOw0K
PiDCoA0KPiArCS8qDQo+ICsJICogU2luY2UgcmVnaXN0ZXIgcHJvcGVydHkgaXMgZGVmaW5lZCBh
cyAicmluZyIgZm9yIFBLVERNQSBhbmQNCj4gKwkgKiAiY2ZnIiBmb3IgVURNQSwgY29uZmlndXJl
IGJhc2UgYWRkcmVzcyBvZiByaW5nIGNvbmZpZ3VyYXRpb24NCj4gKwkgKiByZWdpc3RlciBhY2Nv
cmRpbmdseS4NCj4gKwkgKi8NCj4gKwliYXNlX2NmZyA9IGRldl9yZW1hcF9hZGRyX25hbWUoZGV2
LCAicmluZyIpOw0KPiArCXByX2RlYnVnKCJyaW5nICVwXG4iLCBiYXNlX2NmZyk7DQo+ICsJaWYg
KCFiYXNlX2NmZykgew0KPiArCQliYXNlX2NmZyA9IGRldl9yZW1hcF9hZGRyX25hbWUoZGV2LCAi
Y2ZnIik7DQo+ICsJCXByX2RlYnVnKCJjZmcgJXBcbiIsIGJhc2VfY2ZnKTsNCj4gKwkJaWYgKCFi
YXNlX2NmZykNCj4gKwkJCXJldHVybiBFUlJfUFRSKC1FSU5WQUwpOw0KPiArCX0NCj4gKw0KPiDC
oAlyaW5nYWNjLT5yaW5ncyA9IGRldm1fa3phbGxvYyhkZXYsDQo+IMKgCQkJCcKgwqDCoMKgwqAg
c2l6ZW9mKCpyaW5nYWNjLT5yaW5ncykgKg0KPiDCoAkJCQnCoMKgwqDCoMKgIHJpbmdhY2MtPm51
bV9yaW5ncyAqIDIsDQo+IEBAIC0xMDYyLDYgKzEwNzYsNyBAQCBzdHJ1Y3QgazNfbmF2X3Jpbmdh
Y2MgKmszX3JpbmdhY2NfZG1hcmluZ3NfaW5pdChzdHJ1Y3QgdWRldmljZSAqZGV2LA0KPiDCoAlm
b3IgKGkgPSAwOyBpIDwgcmluZ2FjYy0+bnVtX3JpbmdzOyBpKyspIHsNCj4gwqAJCXN0cnVjdCBr
M19uYXZfcmluZyAqcmluZyA9ICZyaW5nYWNjLT5yaW5nc1tpXTsNCj4gwqANCj4gKwkJcmluZy0+
Y2ZnID0gYmFzZV9jZmcgKyBLTkFWX1JJTkdBQ0NfQ0ZHX1JFR1NfU1RFUCAqIGk7DQo+IMKgCQly
aW5nLT5ydCA9IGJhc2VfcnQgKyBLM19ETUFSSU5HX1JJTkdfUlRfUkVHU19TVEVQICogaTsNCj4g
wqAJCXJpbmctPnBhcmVudCA9IHJpbmdhY2M7DQo+IMKgCQlyaW5nLT5yaW5nX2lkID0gaTsNCg0K
LS0gDQpBbGV4YW5kZXIgU3ZlcmRsaW4NClNpZW1lbnMgQUcNCnd3dy5zaWVtZW5zLmNvbQ0K
