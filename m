Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EB0FC83F1A
	for <u-boot@archiver.kernel.org>; Thu, 17 Jul 2025 07:09:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85CB383381;
	Thu, 17 Jul 2025 09:09:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="o3ijKr96";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC7D4833DB; Thu, 17 Jul 2025 09:04:00 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::615])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 764B8833C7
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 09:03:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nk1ufYGPLpatIUN3ouQjYd7j4WZdRmG18RGr3AlIpROdtch8S9VYK+k5tiff5su9znEq+LVMuGOxfwaRb5l61t1nAbaz/aca1AwiB2wh1+FGLpicr9cHQs/Ba87FZuy1wRjTi0ORJhE1vsmTiPBPu2lkcylhqbFF04M5OinNQmqWmY2tSIcfiKTOBukZeJRXw5QtwQSWfJmFpLrQRxfSUIefX5XvzvMSrPekbJFjB++wQwx+KsgrF5DDjipgdr6sEiJ526cdfsYYPV0Z+TeNTuTrMdGwpuTo8iup/nRKdkFZPSflPvDLLMeI5fDJC5h9ub5jmtNgS6qRAutuSBXgag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZNQSeUkGwcbxSKpxy8gBdX34WLHZoAnLVF2NUk3iNyM=;
 b=N9P5ZVec87xflS51uxFC3Q1MR1w5V68GFxxDG7k9n8GuaZfu4j2T3b+HTqG8bq+07hDgJNwRz/8EpXp+C3sraR8X1zIV5NRXRbkgHjyGkM/hSuF7PJqQ3EvbtHSet4JCot4+Aty2sK9FFk13ikhLBcYU1sdT4STBupzCanj8xB6VbJx1oSg3x9EXSFuLlxGT4s0i0fCKdH2hi9bQY2XCv9zo3JIWc9NAO8c8+yiGBNFLS7DNYKuKa7e3rF/0LymKBk18GXzTkS+zk8PNYavEMLIW6KwB0QGj+WOPFoA4Vmu7bgOmQnK7Qfu+ygMPWf/KZhL+0Klnf5zjyoOopxRqKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZNQSeUkGwcbxSKpxy8gBdX34WLHZoAnLVF2NUk3iNyM=;
 b=o3ijKr96P4pz8vrMwOFYkTENtxPq8nr8OxoH2cMcZ4+LQLew88W0Q/BNGelGRnlmgypxv0hCDogAG8UNd5BxVRlfyHntFOd4Aw0K2kuFpy/5s+Xd+Y/kEBNv6l9grMT/FcYJpyqOmK2sVp4M0UBezgCqKhtDC8f5fh2n6DeAk8O9N0S+uk9rUJi6m1ztROM0IoIF/WFW/vqZIHSqvaQ3rfo+EEg18x6EY6sABbW95y0/YGpuI3LaBz3LogYbvfadAvVn7rXF5FkS/lrtTO4WZNduMAPRSfy5aKaV9ckUATzzsZDuC9ovSO0hP7jjfXf6EHQu8v+2+0rPXMtyRlrxog==
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by SJ0PR03MB5662.namprd03.prod.outlook.com (2603:10b6:a03:285::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 07:03:52 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd%5]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 07:03:52 +0000
From: "Maniyam, Dinesh" <dinesh.maniyam@altera.com>
To: "hs@denx.de" <hs@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>, Simon
 Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Dario Binacchi
 <dario.binacchi@amarulasolutions.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>, Dmitry Rokosov
 <ddrokosov@salutedevices.com>, Jonas Karlman <jonas@kwiboo.se>, Sebastian
 Reichel <sebastian.reichel@collabora.com>, "Chee, Tien Fong"
 <tien.fong.chee@altera.com>, "Hea, Kok Kiang" <kok.kiang.hea@altera.com>,
 "Ng, Boon Khai" <boon.khai.ng@altera.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@altera.com>, "Lim, Jit Loon" <jit.loon.lim@altera.com>, 
 Dinesh Maniyam <dinesh.maniyam@intel.com>
Subject: RE: [PATCH v6 00/12] Add Synopsys MIPI I3C Driver support
Thread-Topic: [PATCH v6 00/12] Add Synopsys MIPI I3C Driver support
Thread-Index: AQHb9iBuqOT6woZ46kWSi1O2duDIObQ11JsAgAAQ1ZA=
Date: Thu, 17 Jul 2025 07:03:52 +0000
Message-ID: <PH7PR03MB6942807E9381070084171471F751A@PH7PR03MB6942.namprd03.prod.outlook.com>
References: <20250716070810.8030-1-dinesh.maniyam@altera.com>
 <cb2f5aec-0650-a84b-b173-b6fed4818fa2@denx.de>
In-Reply-To: <cb2f5aec-0650-a84b-b173-b6fed4818fa2@denx.de>
Accept-Language: en-MW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR03MB6942:EE_|SJ0PR03MB5662:EE_
x-ms-office365-filtering-correlation-id: e29e0ea7-6c8e-48d8-845a-08ddc500166f
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?WXdqVzMxZlRqYWpKZU9FVG9mWE5Oanh6NTBrNllGSjF5NWN1ZkYyZ2hBRnNh?=
 =?utf-8?B?YVM3SFNKcXRTQTFYMTFDdWlKWTlOb293ZFBpcUNoN1lVbVBIMFZOZE55UGlK?=
 =?utf-8?B?MHNGZkcvTVNLTDEySEQ5R0crc0xJdUxmREMwcGhKcWcxTEpNU25jVHpZbHVK?=
 =?utf-8?B?aGVMVEltN2daME9ydXcyT1NXdmlVdVA5d3liTk5CeGNYTDZoN1BOWnNzM2hQ?=
 =?utf-8?B?aDRKU2NBOExqVXBKc3J4dXUvemNOdlZhbzJwMHIyRkJmb1IrbTloVDFtODZM?=
 =?utf-8?B?R2YrcFloVTBKRUtUak1nY3JYN2M1YStMRzArRWNYTVFYV2F6eVlFeGY1NGJi?=
 =?utf-8?B?eVZDREtqVjM3a0JVM1EycjZqZTB6SnY5OXdDMEllTW81ckcrZTdPSWVBdDR4?=
 =?utf-8?B?MjlxQU1mbVFZZ2NqaWREVUZwWkE0M1RWOFNSMHFDbDZWOHNaM0FZd1cxdUdN?=
 =?utf-8?B?ZXpqK0NKdjd0QUlac0NqMU5hMUVqZm94WGR1eGNvSTdMZFdxTzlmWVpabTlI?=
 =?utf-8?B?QTdvUXlMSjNFdjI5cG9oMlVxblFubzF2UVJSUWJCTzVLSnowQS9sbWU2Rmxt?=
 =?utf-8?B?SmI2WjFSYXlrQlBmbjFBZks3NDVxZ0ZTbVYwblcrYzJ0YzFKMm8xL1VQVnB6?=
 =?utf-8?B?UDB4U0Z4YysvWTJCMEdPZHp4SFpsSmpZMGFUd0FnakRmaFpTVG0yVGRxclhU?=
 =?utf-8?B?bmNwUmlOazFQSTQzQzlCZ0RGWVZSVlZiRTU1N25iTWhSTEU2TmZyR1pxZllI?=
 =?utf-8?B?RlR6bGQ4WlhxbVYrNzRtSEJIVU1RLzYwZWgrd1lTeWxIMFYyMDYrWE1zNmxy?=
 =?utf-8?B?UGF6WjlkdUF4VmxHTmdEbC92NlI4dzBXNU1UUWRyZDUxQTZQRUo1emNnbFZU?=
 =?utf-8?B?d2kvQkFocE9wbmtQL2xkUk1QOUs2bG83UjBCY212U2JTRjdwN3ZvVzJWWjVn?=
 =?utf-8?B?bEFxNm1DWGZsUFRSWVlQcHowTDhpUHpLTE5KMDNJb2tGYjhwZHd1Z2ZBaUVY?=
 =?utf-8?B?YXFaN2tHT0FSdE5pMFI2RWxnZHdKYXhtalgvTEhzWVRIRUgvejViT0JsemVP?=
 =?utf-8?B?Z0RCeDdjMUZVWVh2VU5IVWtndjE3N2xmdkNRSEFDRWFOVUo4RGI1QjZxbGN1?=
 =?utf-8?B?YzBIUlZyM3ljYkl0T0RHTHFuRUNuTkpHQ3Y2WlpwZGxjb1k1ZEZ5ZkZCQlp3?=
 =?utf-8?B?YS96dHlGRkwvN0lTL0l0ZCtSWHFXSUg5OUpBMmtlaDkxUGR3WmZNL09CdEZq?=
 =?utf-8?B?VTMvemgybTBZTkV3TXRQL3hTYS9wa1VEUXlocXBMQnNiRnZUOVhuUDM1MDcx?=
 =?utf-8?B?SVRWU2NQNDByUEhrcUNaQW9WZ2h5L0NOWitFKzJNdWpCaE56bHQxMHBpNi9F?=
 =?utf-8?B?L2JaTHhndGkySUZUMDljWmNqNEUyUzhsdXdya2NGUkNKUmZJS0lXaXFXV09m?=
 =?utf-8?B?cU9wUmFoTXFWNlh5NHdlcHQ1ditaRjZ4MEMwL0VpdDJHQmU4a2J3OXp3TUs0?=
 =?utf-8?B?b0lYd0htTy9MTjhjcEFNQXR2RkwrRXQ5aVpGeG4wN3ZkRVgyMVBMdGdCZUpI?=
 =?utf-8?B?VitkeDI3Y0plY21YU3NOdHhOWnhsL1phUDR2dWkzaHZvWmx0V2hSazI0dVNw?=
 =?utf-8?B?cU1JWGJYR3l3bE4yNjc3ODZ5VU4yU053bzdOa0E1RWJSdWR2ejBhN2ZET0pq?=
 =?utf-8?B?MUtwaklCYTVFc3QrWElrNEF5V2JiTkJXck9NRHhLV250NjUvQ1h4WlU2NUVJ?=
 =?utf-8?B?aWtnaWdtaUM4UkR3L2dQSVlNa25IT3B0ZFFaNUk3UkxkUFBEeFJGSFdpUko3?=
 =?utf-8?B?RVdyWUdpcGxMVE5xUnNlYXJpb1ZvbDdnTTRsV1dqS0h5NEluRjV5Z1lrTGVO?=
 =?utf-8?B?WkMvZTBidkpSK2pCaE1pNENwZFVrdjBDK1N3U2dSYWgvYmxNSXpNOCt5K2Z3?=
 =?utf-8?B?SnU4bmFvYStkejVwSithdXpSQitlVUhPa0xrWk9rNU1leG8zbkZ3V0NuRlRk?=
 =?utf-8?B?MTMrV0xzQlFBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TmVITEdxTjdSZGZTQ2tvUE5DL0psVDljMVJwSE5rWmVBaFljWU0xZDhIZ1dT?=
 =?utf-8?B?ai9USDNGOUlzN1NUSTdIVlUrRklNazR5VHJEdU14a2s5cVgzeUVHYVQzMW00?=
 =?utf-8?B?dWw3ZVZsTU5nK0pYT09iTVNIV3VkbVBuMmdkYUNROGI1S2hrTGNwU1JMUTNR?=
 =?utf-8?B?dEZqazZwK00wbDg2L3dhWFFQeWpONkRVRldUSEwwWmpMMm84TU9IZVlTamQw?=
 =?utf-8?B?c1ZKUExZYXEyTXFGRHM2MlgydkZod3l0d1Y1a2J4WFNFWmVTeG1qOGFoVWJB?=
 =?utf-8?B?bU5TUkFJWWNLMklydElDUUs2Wk5DcTlzVjFJYVhFZmNqQ2VUaVZkODB0MFMw?=
 =?utf-8?B?VDkyOHdhYmtGcU5CY1RoZ3JLYXpiTHRSeHN1NzZJSWFOMUh0T0NjRmFXMk5y?=
 =?utf-8?B?OVRUVEVZdVdZWnJzMU9PRVFhTjBJQ1pFN2pxcDJWem1GMHRnQ2NRVE5XbUNI?=
 =?utf-8?B?RC9WWWhmaytsV3d5dGt6YzZWREFvQncyMDB2aEhYa1AzTU5QdlFtT0hFVWhV?=
 =?utf-8?B?L2NvRW9FeUZnZnpEbUlwWTlwU2tNZ3g4SkpIMlAxeGpSSXppMmZ3c1JwN0lh?=
 =?utf-8?B?R2IxempzWHFScE8zRlppWERBRzYxNUhqaFdMNDdqdHp1TjQ1WGNsU29QRVpF?=
 =?utf-8?B?ak1OMTE3RlBzT1JBYzRsY3djRWlqZTFwditwU1RzUjNjZFJ2ZDlObWVoUUFY?=
 =?utf-8?B?anRzclQraVZoTjhkdDNobmRudDlMZjBTREplY1FZV2lFRlN1KzZvb2VFNVV6?=
 =?utf-8?B?QXpjbU1pU1VGUFFuTmUxT05Uc2dLeXFrMFBwYXZFRzFTRmhrMlFiRUNtSUJs?=
 =?utf-8?B?U0k4U2JCRld3bExSckczUm5PTXI2bTJrVmNsck9xd1l5R2JPYnNuakNTZWg4?=
 =?utf-8?B?b2thSVArVjNNd0pwRFF0YzNOYTdhVkJSTWZENlNneHlnNkpTYlB5UUs5b3ZJ?=
 =?utf-8?B?S0FSN0xXL1Z6SWJpQndwVzhad0k5ZmE3RmdDR2xaZ3hCTUV1WU50YW1hYUJo?=
 =?utf-8?B?OXl5K1hUVnpVb1FtanhSWW1PV3k3SDI5UytidjJGK0psSjBobzlYbXZ3TzJS?=
 =?utf-8?B?L25lNC92emd3R1ZLZnFwT1huUUw3UGZlTzIzaGFaQ2tVYkNqVTdidWVCT1gz?=
 =?utf-8?B?dU8yV1NNNDVBeWJ1Tjd6cEtpcHNPeHNOTHhDRlZqMHZISjhGbVM0dmZHUDNP?=
 =?utf-8?B?cUg3UzZMcGs2R0hjdURPdVkwRjZnUkRsaGZJeE5qTStJcVVzTnFiUzNVT2dC?=
 =?utf-8?B?WVdsQzZKOHZ1TjFxYlBCMHFJT3lJNjVUTWxlcmJqbHVLSGpsa2FsYnhyZngx?=
 =?utf-8?B?bU1YL28vNDB3dVdNb3dielhhUXB0cTJsdWgrT0pyWDY0SVE5TEU3a1BtaUFW?=
 =?utf-8?B?Ymt4TFpWaHpIZ3d6bUh5Znh5SFpIUTNFNVF3SzVsUUFvVllqWnZ4Mnc3ZzU3?=
 =?utf-8?B?dnI5ZTc1Q0d1ejgreWJmZGhSQ1EyekdtaHRWN2hMN0xjSS9YL24ydEVmNGlh?=
 =?utf-8?B?SkFnOUdidjFab2VDYld2L3FNVUwzdGdzRGNiejVWZXRNaUQ3dlgzdG91alk4?=
 =?utf-8?B?NGRTU0dnZzlOd3ZuMWhQZHBGc1BpdjFZUXptQ05ab1hhckhKQXJtbTVaRmxp?=
 =?utf-8?B?N09NSURiVlJFOVVCUU5XK2NEREYxc2tmNkh0UHN2UytoUTlueUNHSnFlaWx5?=
 =?utf-8?B?MXRSZDlSOXZUL01zeUtFbUVMZkFleDUwdkdvblhuK2xCNUtuVW5GdE9Gcnll?=
 =?utf-8?B?cGxYbXpTeUVoZko1UThmM1JOQ21ZTDV1TWJVV0JncHhXRVRjYjE3a3Y0djNW?=
 =?utf-8?B?NTJkaXgyODc0VU1IOXVlMTlVYXRHbFdIQ01QVE1oNE1XdW4vN2NjM25oVHZ2?=
 =?utf-8?B?SlRqRXlLSmM4cnNGQUNVb1RzbXlhQitaVisySXJDRmdjaS9qV0ZQYkNkZ2Yv?=
 =?utf-8?B?VVhSNURYZEFNSXd6eXFHYXFWS2VhbnduWUFWNmQ2NUZ4aDY4Wk5XbmlHK094?=
 =?utf-8?B?YkpmcFcyTFRTL016bzkvOW1ST3NHNEcvaGxscGJtR3VQM1hlK0h3UGsyQmJz?=
 =?utf-8?B?RGJDT2JJNHBWZDNMdEdKN2ZkTlBTVk5rdXQwcHBLUlNZSXZRd1BYR29CNmRy?=
 =?utf-8?Q?ZS173xJyzEd8gk3l9S3v8sXn/?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e29e0ea7-6c8e-48d8-845a-08ddc500166f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2025 07:03:52.3415 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1zoA4nlXBMV50sakaWphBhWub+ojpPgVn1iHGrtk6konaTNoT45MpGjQXbnbxZ42JA5Gkl90zozSAZ68Dh0uzuww3H0mOB3bQ6o0lCMytFo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5662
X-Mailman-Approved-At: Thu, 17 Jul 2025 09:09:13 +0200
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSGVpa28gU2Nob2NoZXIg
PGhzQGRlbnguZGU+DQo+IFNlbnQ6IFRodXJzZGF5LCAxNyBKdWx5IDIwMjUgMjowMyBwbQ0KPiBU
bzogTWFuaXlhbSwgRGluZXNoIDxkaW5lc2gubWFuaXlhbUBhbHRlcmEuY29tPjsgdS1ib290QGxp
c3RzLmRlbnguZGUNCj4gQ2M6IE1hcmVrIDxtYXJleEBkZW54LmRlPjsgU2ltb24gPHNpbW9uLmsu
ci5nb2xkc2NobWlkdEBnbWFpbC5jb20+Ow0KPiBTaW1vbiBHbGFzcyA8c2pnQGNocm9taXVtLm9y
Zz47IFRvbSBSaW5pIDx0cmluaUBrb25zdWxrby5jb20+OyBEYXJpbw0KPiBCaW5hY2NoaSA8ZGFy
aW8uYmluYWNjaGlAYW1hcnVsYXNvbHV0aW9ucy5jb20+OyBJbGlhcyBBcGFsb2RpbWFzDQo+IDxp
bGlhcy5hcGFsb2RpbWFzQGxpbmFyby5vcmc+OyBIZWlucmljaCBTY2h1Y2hhcmR0IDx4eXByb24u
Z2xwa0BnbXguZGU+Ow0KPiBKZXJvbWUgRm9yaXNzaWVyIDxqZXJvbWUuZm9yaXNzaWVyQGxpbmFy
by5vcmc+OyBNYXR0aWpzIEtvcnBlcnNob2VrDQo+IDxta29ycGVyc2hvZWtAYmF5bGlicmUuY29t
PjsgSWJhaSBFcmtpYWdhIDxpYmFpLmVya2lhZ2EtZWxvcnphQGFtZC5jb20+Ow0KPiBNaWNoYWwg
U2ltZWsgPG1pY2hhbC5zaW1la0BhbWQuY29tPjsgRG1pdHJ5IFJva29zb3YNCj4gPGRkcm9rb3Nv
dkBzYWx1dGVkZXZpY2VzLmNvbT47IEpvbmFzIEthcmxtYW4gPGpvbmFzQGt3aWJvby5zZT47IFNl
YmFzdGlhbg0KPiBSZWljaGVsIDxzZWJhc3RpYW4ucmVpY2hlbEBjb2xsYWJvcmEuY29tPjsgQ2hl
ZSwgVGllbiBGb25nDQo+IDx0aWVuLmZvbmcuY2hlZUBhbHRlcmEuY29tPjsgSGVhLCBLb2sgS2lh
bmcgPGtvay5raWFuZy5oZWFAYWx0ZXJhLmNvbT47IE5nLA0KPiBCb29uIEtoYWkgPGJvb24ua2hh
aS5uZ0BhbHRlcmEuY29tPjsgWXVzbGFpbWksIEFsaWYgWmFrdWFuDQo+IDxhbGlmLnpha3Vhbi55
dXNsYWltaUBhbHRlcmEuY29tPjsgTGltLCBKaXQgTG9vbiA8aml0Lmxvb24ubGltQGFsdGVyYS5j
b20+Ow0KPiBEaW5lc2ggTWFuaXlhbSA8ZGluZXNoLm1hbml5YW1AaW50ZWwuY29tPg0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIIHY2IDAwLzEyXSBBZGQgU3lub3BzeXMgTUlQSSBJM0MgRHJpdmVyIHN1
cHBvcnQNCj4gDQo+IFtDQVVUSU9OOiBUaGlzIGVtYWlsIGlzIGZyb20gb3V0c2lkZSB5b3VyIG9y
Z2FuaXphdGlvbi4gVW5sZXNzIHlvdSB0cnVzdCB0aGUNCj4gc2VuZGVyLCBkbyBub3QgY2xpY2sg
b24gbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyBhcyBpdCBtYXkgYmUgYSBmcmF1ZHVsZW50IGVt
YWlsDQo+IGF0dGVtcHRpbmcgdG8gc3RlYWwgeW91ciBpbmZvcm1hdGlvbiBhbmQvb3IgY29tcHJv
bWlzZSB5b3VyIGNvbXB1dGVyLl0NCj4gDQo+IEhlbGxvDQo+IA0KPiBPbiAxNi4wNy4yNSAwOTow
NywgZGluZXNoLm1hbml5YW1AYWx0ZXJhLmNvbSB3cm90ZToNCj4gPiBGcm9tOiBEaW5lc2ggTWFu
aXlhbSA8ZGluZXNoLm1hbml5YW1AaW50ZWwuY29tPg0KPiA+DQo+ID4gVGhpcyBwYXRjaHNldCBh
ZGQgU3lub3BzeXMgTUlQSSBJM0MgRHJpdmVyIHN1cHBvcnQgZm9yIEludGVsIEFnaWxleDUNCj4g
PiBkZXZpY2VzLg0KPiA+DQo+ID4gVGhlIGkzYyBkcml2ZXIgaXMgbGV2ZXJhZ2VkIGZyb20gdGhl
IG1hc3Rlci9kdy1pM2MtbWFzdGVyLmMsDQo+ID4gaTNjL2RldmljZS5jIGFuZCBpM2MvbWFzdGVy
LmMgTGludXggdmVyc2lvbiA2LjYuMzcgTFRTIEFuZCBmZXcgaGVhZGVyDQo+ID4gZmlsZXMgaW5j
bHVkZWQgdG8gYmUgcGFydCBvZiB0aGUgbWlncmF0aW9uOyBpM2MvaW50ZXJuYWxzLmgsDQo+ID4g
aW5jbHVkZS9saW51eC9pM2MvY2NjLmgsIGluY2x1ZGUvbGludXgvaTNjL2RldmljZS5oIGFuZA0K
PiA+IGluY2x1ZGUvbGludXgvaTNjL21hc3Rlci5oLg0KPiA+IEFkZGl0aW9uYWwgaTNjIHVjbGFz
cyBkcml2ZXIgYW5kIGNvbW1hbmQgZmlsZXMgYWRkZWQgdG8gc3VwcG9ydCBpM2MNCj4gPiByZWFk
IGFuZCB3cml0ZSBpbiBVLUJvb3QuDQo+ID4NCj4gPiBQYXRjaCBzdGF0dXM6DQo+ID4NCj4gPiBE
ZXRhaWwgY2hhbmdlbG9nIGNhbiBmaW5kIGluIGNvbW1pdCBtZXNzYWdlLg0KPiA+DQo+ID4gdjYt
PnY1Og0KPiA+IC0tLS0tLS0tDQo+ID4gLSBSZXNvbHZlZCBkb2N1bWVudGF0aW9uIHdhcm5pbmcg
aW4gaW5jbHVkZS9pM2MuaA0KPiA+IC0gTW92ZSBkZWNsYXJhdGlvbnMgdG8gdGhlIHRvcCBpbiBj
bWQvaTNjLmMgZnVuY3Rpb25zDQo+ID4NCj4gPiB2NS0+djQ6DQo+ID4gLS0tLS0tLS0NCj4gPiAt
IEFkZCBoZWFkZXIgZmlsZSB0byBkb2MvYXBpL2kzYw0KPiA+IC0gUmVwaHJhc2UgZnVuY3Rpb24g
ZGVzY3JpcHRpb24gZm9yIGkzYy5oDQo+ID4gLSBTZXBhcmF0ZWQgc3ViY29tbWFuZCBhcyBhIGZ1
bmN0aW9uIGZvciBjbWQvaTNjLmMNCj4gPiAtIFVzZWQgbWVtb3J5IGFkZHJlc3MgdG8gdHJhbnNm
ZXIgbXNncyBmcm9tIGkzYw0KPiA+IC0gUmVwaHJhc2UgZGVzY3JpcHRpb24gaW4gY21kL2kzYy5y
c3QgZmlsZQ0KPiA+IC0gUmVwbGFjZWQgaW50IHdpdGggdW5zaWduZWQgZm9yIHBvc2l0aXZlIHZh
cmlhYmxlcy4NCj4gPg0KPiA+IHY0LT52MzoNCj4gPiAtLS0tLS0tLQ0KPiA+IFJlc29sdmUgY2kg
dGVzdDoNCj4gPiAtIEFkZCBpM2Mgbm9kZSBpbiBpbmRleC5yc3QNCj4gPiAtIEZvcm1hdGluZyBl
cnJvciBpbiBpM2MucnN0DQo+ID4gLSBSZXNvbHZlIGNwdV9yZWxheCB1bmRlZmluZWQgZm9yIHNh
bmRib3gNCj4gPg0KPiA+IHYzLT52MjoNCj4gPiAtLS0tLS0tLQ0KPiA+IC0gU3F1YXNoIGNvbW1p
dCAxMCB0byBjb21taXQgOQ0KPiA+IC0gUmVzb2x2ZSBpbmRleCBmb3IgbmV3IGZpbGVzIHRvIHBh
c3MgdGhlIGNoZWNrcGF0Y2gNCj4gPg0KPiA+IENvbW1pdDogc2FuZGJveF9kZWZjb25maWc6IEVu
YWJsZSBjb25maWdzIGZvciBzYW5kYm94IGkzYw0KPiA+IENvbW1pdDogYWdpbGV4NV9kZWZjb25m
aWc6IEVuYWJsZSBpM2MgY29uZmlncyBmb3IgYWdpbGV4NQ0KPiA+IC0gdXNlIHNhdmVkZWZjb25m
aWcNCj4gPg0KPiA+IGRyaXZlcnM6IEVuYWJsZWQgS2NvbmZpZyBhbmQgTWFrZWZpbGUgZm9yIGkz
YyBzdXBwb3J0DQo+ID4gLSBBZGQgbWFpbnRhaW5lciBmb3IgaTNjDQo+ID4NCj4gPiBkcml2ZXJz
OiBpM2M6IEVuYWJsZWQgS2NvbmZpZyBhbmQgTWFrZWZpbGUgZm9yIERXSTNDDQo+ID4gLSBBZGQg
ZW1wdHkgbGluZXMgZm9yIGlmL2VuZGlmDQo+ID4NCj4gPiBkcml2ZXJzOiBpM2M6IEFkZCBpM2Mg
c2FuZGJveCBzaW1wbGUgdGVzdC4NCj4gPiAtIFJlbW92ZWQgREVDTEFSRV9HTE9CQUxfREFUQV9Q
VFINCj4gPg0KPiA+IHYxLT52MjoNCj4gPiAtLS0tLS0tLQ0KPiA+IFJlb3JkZXIgY29tbWl0cy4N
Cj4gPg0KPiA+IEFkZGVkIGNvbW1pdHM6DQo+ID4gLSBkcml2ZXJzOiBpM2M6IEFkZCBpM2Mgc2Fu
ZGJveCBzaW1wbGUgdGVzdC4NCj4gPiAtIHRlc3Q6IGNtZDogQWRkIHNpbXBsZSB0ZXN0IGZvciBp
M2MNCj4gPiAtIGNvbmZpZ3M6IHNhbmRib3hfZGVmY29uZmlnOiBFbmFibGUgY29uZmlncyBmb3Ig
c2FuZGJveCBpM2MNCj4gPiAtIGNvbmZpZ3M6IGFnaWxleDVfZGVmY29uZmlnOiBFbmFibGUgaTNj
IGNvbmZpZ3MgZm9yIGFnaWxleDUNCj4gPg0KPiA+IEhpc3Rvcnk6DQo+ID4gLS0tLS0tLS0NCj4g
PiBbdjFdOg0KPiA+IGh0dHBzOi8vcGF0Y2h3b3JrLm96bGFicy5vcmcvcHJvamVjdC91Ym9vdC9j
b3Zlci8yMDI1MDIxODAyNTcwNS41MDA1MS0NCj4gPiAxLWRpbmVzaC5tYW5peWFtQGludGVsLmNv
bS8NCj4gPiBbdjJdOg0KPiA+IGh0dHBzOi8vcGF0Y2h3b3JrLm96bGFicy5vcmcvcHJvamVjdC91
Ym9vdC9jb3Zlci8yMDI1MDMxNDA0MDkwMi40MzYyMS0NCj4gPiAxLWRpbmVzaC5tYW5peWFtQGFs
dGVyYS5jb20vDQo+ID4gW3YzXToNCj4gPiBodHRwczovL3BhdGNod29yay5vemxhYnMub3JnL3By
b2plY3QvdWJvb3QvY292ZXIvMjAyNTAzMjQwODM3MDQuMjYyNTktDQo+ID4gMS1kaW5lc2gubWFu
aXlhbUBhbHRlcmEuY29tLw0KPiA+IFt2NF06DQo+ID4gaHR0cHM6Ly9wYXRjaHdvcmsub3psYWJz
Lm9yZy9wcm9qZWN0L3Vib290L2NvdmVyLzIwMjUwNDE3MDIxODQwLjYyMTItMQ0KPiA+IC1kaW5l
c2gubWFuaXlhbUBhbHRlcmEuY29tLw0KPiA+IFt2NV06DQo+ID4gaHR0cHM6Ly9wYXRjaHdvcmsu
b3psYWJzLm9yZy9wcm9qZWN0L3Vib290L2NvdmVyLzIwMjUwNTEzMTAxOTEzLjMwODgwLQ0KPiA+
IDEtZGluZXNoLm1hbml5YW1AYWx0ZXJhLmNvbS8NCj4gPg0KPiA+IERpbmVzaCBNYW5peWFtICgx
Mik6DQo+ID4gICAgZHJpdmVyczogaTNjOiBBZGQgbmV3IGkzYyB1Y2xhc3MgaWQNCj4gPiAgICBk
cml2ZXJzOiBpM2M6IEFkZCBkcml2ZXIgZm9yIE1JUEkgRFdJM0MNCj4gPiAgICBkcml2ZXJzOiBp
M2M6IEFkZCBpM2MgdWNsYXNzIGRyaXZlci4NCj4gPiAgICBkcml2ZXJzOiBFbmFibGVkIEtjb25m
aWcgYW5kIE1ha2VmaWxlIGZvciBpM2Mgc3VwcG9ydA0KPiA+ICAgIGRyaXZlcnM6IGkzYzogRW5h
YmxlZCBLY29uZmlnIGFuZCBNYWtlZmlsZSBmb3IgRFdJM0MNCj4gPiAgICBkcml2ZXJzOiBpM2M6
IEFkZCBpM2Mgc2FuZGJveCBzaW1wbGUgdGVzdC4NCj4gPiAgICBkcml2ZXJzOiBpM2M6IG1hc3Rl
cjogRW5hYmxlIHByb2JlIGkzYyB3aXRob3V0IHNsYXZlIGRldmljZQ0KPiA+ICAgIGkzYzogbWFz
dGVyOiBkdy1pM2MtbWFzdGVyOiBGaXggT0RfVElNSU5HIGZvciBzcGlrZSBmaWx0ZXINCj4gPiAg
ICBjbWQ6IEFkZCBpM2MgY29tbWFuZCBzdXBwb3J0Lg0KPiA+ICAgIHRlc3Q6IGNtZDogQWRkIHNp
bXBsZSB0ZXN0IGZvciBpM2MNCj4gPiAgICBjb25maWdzOiBzYW5kYm94X2RlZmNvbmZpZzogRW5h
YmxlIGNvbmZpZ3MgZm9yIHNhbmRib3ggaTNjDQo+ID4gICAgY29uZmlnczogYWdpbGV4NV9kZWZj
b25maWc6IEVuYWJsZSBpM2MgY29uZmlncyBmb3IgYWdpbGV4NQ0KPiA+DQo+ID4gICBNQUlOVEFJ
TkVSUyAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgNyArDQo+ID4gICBhcmNoL3NhbmRib3gv
ZHRzL3Rlc3QuZHRzICAgICAgICAgIHwgICAgOCArDQo+ID4gICBjbWQvS2NvbmZpZyAgICAgICAg
ICAgICAgICAgICAgICAgIHwgICAgNiArDQo+ID4gICBjbWQvTWFrZWZpbGUgICAgICAgICAgICAg
ICAgICAgICAgIHwgICAgMSArDQo+ID4gICBjbWQvaTNjLmMgICAgICAgICAgICAgICAgICAgICAg
ICAgIHwgIDI3MSArKysrDQo+ID4gICBjb25maWdzL3NhbmRib3hfZGVmY29uZmlnICAgICAgICAg
IHwgICAgNCArDQo+ID4gICBjb25maWdzL3NvY2ZwZ2FfYWdpbGV4NV9kZWZjb25maWcgIHwgICAg
MyArDQo+ID4gICBkb2MvYXBpL2kzYy5yc3QgICAgICAgICAgICAgICAgICAgIHwgICAgOCArDQo+
ID4gICBkb2MvYXBpL2luZGV4LnJzdCAgICAgICAgICAgICAgICAgIHwgICAgMSArDQo+ID4gICBk
b2MvdXNhZ2UvY21kL2kzYy5yc3QgICAgICAgICAgICAgIHwgIDE0NiArKw0KPiA+ICAgZG9jL3Vz
YWdlL2luZGV4LnJzdCAgICAgICAgICAgICAgICB8ICAgIDEgKw0KPiA+ICAgZHJpdmVycy9LY29u
ZmlnICAgICAgICAgICAgICAgICAgICB8ICAgIDIgKw0KPiA+ICAgZHJpdmVycy9NYWtlZmlsZSAg
ICAgICAgICAgICAgICAgICB8ICAgIDEgKw0KPiA+ICAgZHJpdmVycy9pM2MvS2NvbmZpZyAgICAg
ICAgICAgICAgICB8ICAgMjcgKw0KPiA+ICAgZHJpdmVycy9pM2MvTWFrZWZpbGUgICAgICAgICAg
ICAgICB8ICAgIDUgKw0KPiA+ICAgZHJpdmVycy9pM2MvZGV2aWNlLmMgICAgICAgICAgICAgICB8
ICAyNjIgKysrKw0KPiA+ICAgZHJpdmVycy9pM2MvaTNjLXVjbGFzcy5jICAgICAgICAgICB8ICAg
MzggKw0KPiA+ICAgZHJpdmVycy9pM2MvaW50ZXJuYWxzLmggICAgICAgICAgICB8ICAgMjYgKw0K
PiA+ICAgZHJpdmVycy9pM2MvbWFzdGVyLmMgICAgICAgICAgICAgICB8IDIwNzAgKysrKysrKysr
KysrKysrKysrKysrKysrKysrKw0KPiA+ICAgZHJpdmVycy9pM2MvbWFzdGVyL0tjb25maWcgICAg
ICAgICB8ICAgMTEgKw0KPiA+ICAgZHJpdmVycy9pM2MvbWFzdGVyL01ha2VmaWxlICAgICAgICB8
ICAgIDMgKw0KPiA+ICAgZHJpdmVycy9pM2MvbWFzdGVyL2R3LWkzYy1tYXN0ZXIuYyB8IDEwNjIg
KysrKysrKysrKysrKysNCj4gPiAgIGRyaXZlcnMvaTNjL3NhbmRib3hfaTNjLmMgICAgICAgICAg
fCAgIDU2ICsNCj4gPiAgIGluY2x1ZGUvZG0vZGV2aWNlLmggICAgICAgICAgICAgICAgfCAgICAy
ICsNCj4gPiAgIGluY2x1ZGUvZG0vdWNsYXNzLWlkLmggICAgICAgICAgICAgfCAgICAxICsNCj4g
PiAgIGluY2x1ZGUvZHctaTNjLmggICAgICAgICAgICAgICAgICAgfCAgMjUyICsrKysNCj4gPiAg
IGluY2x1ZGUvaTNjLmggICAgICAgICAgICAgICAgICAgICAgfCAgIDkzICsrDQo+ID4gICBpbmNs
dWRlL2xpbnV4L2kzYy9jY2MuaCAgICAgICAgICAgIHwgIDM4NSArKysrKysNCj4gPiAgIGluY2x1
ZGUvbGludXgvaTNjL2RldmljZS5oICAgICAgICAgfCAgMjg2ICsrKysNCj4gPiAgIGluY2x1ZGUv
bGludXgvaTNjL21hc3Rlci5oICAgICAgICAgfCAgNjk4ICsrKysrKysrKysNCj4gPiAgIHRlc3Qv
Y21kL01ha2VmaWxlICAgICAgICAgICAgICAgICAgfCAgICAxICsNCj4gPiAgIHRlc3QvY21kL2kz
Yy5jICAgICAgICAgICAgICAgICAgICAgfCAgIDUwICsNCj4gPiAgIHRlc3QvZG0vTWFrZWZpbGUg
ICAgICAgICAgICAgICAgICAgfCAgICAxICsNCj4gPiAgIHRlc3QvZG0vaTNjLmMgICAgICAgICAg
ICAgICAgICAgICAgfCAgIDM0ICsNCj4gPiAgIDM0IGZpbGVzIGNoYW5nZWQsIDU4MjIgaW5zZXJ0
aW9ucygrKQ0KPiA+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGNtZC9pM2MuYw0KPiA+ICAgY3JlYXRl
IG1vZGUgMTAwNjQ0IGRvYy9hcGkvaTNjLnJzdA0KPiA+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRv
Yy91c2FnZS9jbWQvaTNjLnJzdA0KPiA+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvaTNj
L0tjb25maWcNCj4gPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2kzYy9NYWtlZmlsZQ0K
PiA+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvaTNjL2RldmljZS5jDQo+ID4gICBjcmVh
dGUgbW9kZSAxMDA2NDQgZHJpdmVycy9pM2MvaTNjLXVjbGFzcy5jDQo+ID4gICBjcmVhdGUgbW9k
ZSAxMDA2NDQgZHJpdmVycy9pM2MvaW50ZXJuYWxzLmgNCj4gPiAgIGNyZWF0ZSBtb2RlIDEwMDY0
NCBkcml2ZXJzL2kzYy9tYXN0ZXIuYw0KPiA+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMv
aTNjL21hc3Rlci9LY29uZmlnDQo+ID4gICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9pM2Mv
bWFzdGVyL01ha2VmaWxlDQo+ID4gICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9pM2MvbWFz
dGVyL2R3LWkzYy1tYXN0ZXIuYw0KPiA+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvaTNj
L3NhbmRib3hfaTNjLmMNCj4gPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2R3LWkzYy5o
DQo+ID4gICBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9pM2MuaA0KPiA+ICAgY3JlYXRlIG1v
ZGUgMTAwNjQ0IGluY2x1ZGUvbGludXgvaTNjL2NjYy5oDQo+ID4gICBjcmVhdGUgbW9kZSAxMDA2
NDQgaW5jbHVkZS9saW51eC9pM2MvZGV2aWNlLmgNCj4gPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBp
bmNsdWRlL2xpbnV4L2kzYy9tYXN0ZXIuaA0KPiA+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3Qv
Y21kL2kzYy5jDQo+ID4gICBjcmVhdGUgbW9kZSAxMDA2NDQgdGVzdC9kbS9pM2MuYw0KPiA+DQo+
IA0KPiANCj4gYXBwbGllZCB0aGUgd2hvbGUgcGF0Y2hzZXJpZXMgdG8gdS1ib290LWkyYy5naXQg
bWFzdGVyLCB0aGFua3MhDQo+IA0KPiBieWUsDQo+IEhlaWtvDQo+IC0tDQoNCk5vdGVkLCBUaGFu
a3MhDQoNCkRpbmVzaA0KDQo+IERFTlggU29mdHdhcmUgRW5naW5lZXJpbmcgR21iSCwgTWFuYWdp
bmcgRGlyZWN0b3I6IEpvaGFubmEgRGVuaywgVGFiZWEgTHV0eg0KPiBIUkIgMTY1MjM1IE11bmlj
aCwgT2ZmaWNlOiBLaXJjaGVuc3RyLjUsIEQtODIxOTQgR3JvZWJlbnplbGwsIEdlcm1hbnkNCj4g
UGhvbmU6ICs0OS04MTQyLTY2OTg5LTUyICAgRmF4OiArNDktODE0Mi02Njk4OS04MCAgIEVtYWls
OiBoc0BkZW54LmRlDQo=
