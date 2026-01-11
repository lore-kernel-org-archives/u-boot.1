Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 545D7D2502E
	for <u-boot@archiver.kernel.org>; Sun, 11 Jan 2026 12:46:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95B7383AAE;
	Sun, 11 Jan 2026 13:46:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="V0K7NlxW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B12483AB7; Sun, 11 Jan 2026 13:46:26 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE33D83A5A
 for <u-boot@lists.denx.de>; Sun, 11 Jan 2026 13:46:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p4LPvdfRkGuN3U5v5Vm0+SU9pQNDSyfpSVC8Y8YimaHO/B2vOIv+kGkVwFId+ApTmWrVJaQrvlhyeiAJXvOfMxGHSEQSdNhrMMmX/vuRLNaDAXtPLCKJN+O+gr8rr0g3i4VWT4Lm64N/51JzdgbkBl+fh3gO2TO3UCJeQRm7HNIjXm+pJi4281ybB5tKqe0SWJFlmKwBZ18211D4Ike2+LO2qYjo2dQl2NywoKDS4suE3lz0E/WoVZhkLIC2+JHtGyrgZHrf1tQaIMVg8oOWlZWsJ5555WFcVDfttcx7OrbOcBT+UCeZybGCU2H80t2v4shyywnu4zgwnFjX8zi5Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZN1n2buhSu3OK5b3ozVnkTtEP5385txIceeAAqzLqA8=;
 b=JIVtbF8EQiF2cvAnx1csv5Rqe6mDniRwOclOR72pRYsXymT3B2AUDI+flgPH00MLIQkZMTd2WjGl4R3g82h4/EipLhorqxNNsBcL7Q/8sPULsklShp58adAxlHY+f/pHuZF00McJjL/t2VcfsMuUrqoIdbmZTP7e6BWp3R7GUEDdmks1sMQDv/bcbRtBat65AbSadLPrJFmk6SxvD7xV+PiOK9U5pmb9aYBjQT9S+E7jeQR1YFN2DFMzrMVYBSYXmeIlxQYAB5oRJu8lXe1jMohsvogd975BvsdeOwtZhjxzdvjQ81iUviiOwUwg6BYmFb7ByCs7tPJlSGekn1bumw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZN1n2buhSu3OK5b3ozVnkTtEP5385txIceeAAqzLqA8=;
 b=V0K7NlxWZ2LEnMFc7ASdhizYbXPt80cnP0SLp7dGJ2JSTUA84FlvIYNUmUm5eF6fFKsoj5Ru8Sj3AVskPIZ5cFwQZe65+mtlRUyQyg30Wx4cM72+bDfcNg26lZd6MDi/G1Iw00OshxDxL4Vo/Y4bj7ItAEHrigRJGjcVjH+08Wt8yATrtjpHmdql9+WJh32LE/bzwCICjSlyQZJ1bvjRzb83BaunA2UBljP/vJ0zkzmDqXWfb/8Gb386HiY1r8LzHw60uGbJ0yFGvDppR/DcY6or0AN3AJN913N/Snynjc4uW2qjaehDSa+oAaSxVPQpfdGaC3CXHfYRgoa/5xCMbg==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV2PR04MB11682.eurprd04.prod.outlook.com (2603:10a6:150:2ca::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Sun, 11 Jan
 2026 12:46:19 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9499.005; Sun, 11 Jan 2026
 12:46:19 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Primoz Fiser <primoz.fiser@norik.com>, "Peng Fan (OSS)"
 <peng.fan@oss.nxp.com>, dl-uboot-imx <uboot-imx@nxp.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Stefano Babic
 <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
CC: Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Alice Guo <alice.guo@nxp.com>
Subject: RE: [PATCH 11/13] misc: ele_api: Add Voltage change start and finish
 APIs
Thread-Topic: [PATCH 11/13] misc: ele_api: Add Voltage change start and finish
 APIs
Thread-Index: AQHcgISePedi1m5nuEGzt7846KPZybVJt6SAgAM1+KA=
Date: Sun, 11 Jan 2026 12:46:19 +0000
Message-ID: <PAXPR04MB845921DC05E8D27ACFFDADCC8880A@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20260108-imx-update-v1-0-0d5921c575bb@nxp.com>
 <20260108-imx-update-v1-11-0d5921c575bb@nxp.com>
 <efb435fe-3d6e-49de-a903-678051c0f9a6@norik.com>
In-Reply-To: <efb435fe-3d6e-49de-a903-678051c0f9a6@norik.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|GV2PR04MB11682:EE_
x-ms-office365-filtering-correlation-id: af8a7aa9-cacf-4b87-821d-08de510f6aef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|376014|366016|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?NHVzaGxIaDBhREEvVG1jUnlYVkhlanU4Nm5mQnIreEg1NlFCK3p2eGdsV1RT?=
 =?utf-8?B?bGpTeUVobloxZ3FRdmsrWEhDb0NaZGZoUDdFVnplMTVNbWlvczZ5T1FRYXhK?=
 =?utf-8?B?dlFucWdvTU92bGl3VGc1TUdIVTRQQytDa2JHdElrS29yOFlndjFqeTdta3B0?=
 =?utf-8?B?VWhjWDBSczVTMHQ1MTRJTGxaclM3OVUxU3lyNG10TWIzUzdRTzhwVTdJczkw?=
 =?utf-8?B?RTRrY2FueTErU1dDR3lkMkwzZElORmRIZHV2Rk5Fc3dLOGFLVncwQzNvUDZU?=
 =?utf-8?B?VmpxVUVZU3ZERjBMWndiR2N4YnAzVUkvd2d3c2RKaFBxU2JvL0FxN3RKZk1s?=
 =?utf-8?B?SkUwbHdPckd3Z0ZITnFzc2o0eFZYWXo5akhiT2FtN0dVZ00vYW1jSXJ6Zi9L?=
 =?utf-8?B?ZGQvS3Nqb1R0bko0K2szNlVVZTNIeXVISnJKWmVaRXlPWUl1eDJtYjlXZ1VR?=
 =?utf-8?B?eXArUTQ1NjFLM0l5dThEMThqZmQ5SkVzZmZmTHlQR0QwWTl5b2Y0YU9YS0hJ?=
 =?utf-8?B?di9FVjVBdTVDL01WcnpCQUJYa3BlYUtRcGVLZzZqTGtjOGprcitlVmJLOWU4?=
 =?utf-8?B?Wmxtdkd5cXgwTjV6Zm1Ka2NjN3RRNGRWYU9OM0FiSzlLeVUwNHcxMEVJd01P?=
 =?utf-8?B?Lys4T0xWZnVWU01RZ3Y3eGxWbG53OHJ3T2lESTIyRHRRM0NwdmhkbnVvSHJU?=
 =?utf-8?B?R2tIWHo0TlB5eUZLV2t0Y1NxVHBxZGVSMEZ1SFN4bmxLclVObVB3ZytrMnVM?=
 =?utf-8?B?NzhYaFhyVldsalhlcm8ybVVpTEZkTXR0RW5pY2xTSzluQmNSUWd3L3dvUmYw?=
 =?utf-8?B?QnhldDVaUFd2K2xvanlaandFSzUydHUwSGphL1hOdFNROHFobytIVGlNNjNz?=
 =?utf-8?B?L3duNG85VUdCRmZ3TlVzL1RoYUJIRmE1cXpBaTVmWVFZUElaUm9mUW4ycCta?=
 =?utf-8?B?bWQ1azRoSThacCtQRTVwYU5YYjNTSlFPMUtiRXFWSldSMnBBUU1qMFU3MFZB?=
 =?utf-8?B?eVZCQVVJUnVhSE1ZL2d3VTBjc1owTlBVOG4yMi93bU1CcWhmSDNmaVRyMllU?=
 =?utf-8?B?dGJ2QXJrS3Jwd3ovb2xra1A0OEFpZDVKWHZoUFNYQkN2d2hrMThTZEQ3dkJa?=
 =?utf-8?B?dFlINVRxL0p5aWFKZWZXOGd1RkMwTWY3ekttTUROQVI5N0ZtaVZaSU5rbFhm?=
 =?utf-8?B?MzFOZ2kwOWJrbHZjc05lamgxcUxCQVp1cnlBdEFXTzRmSU5FNmFvc1RHRFF2?=
 =?utf-8?B?bmMyMjlpWTgwY3JHMG5VQUw3dURRNnozS0JXR3NQQXhyekRZbGpHK3Z2YW1M?=
 =?utf-8?B?aGpJMU9ISWU5ei9DeUFmZDc5N29jeVgreElsejZ1OElOUVRYU00zMTF2WkUy?=
 =?utf-8?B?aVh4WVcxdjFmQmZoK1djOFJiK3dLdTdKekhVVlFOdHpxT1RRb3ZSSUM1M08r?=
 =?utf-8?B?Y3ZTb3lmM1E1eXZxUk45Q0FBK2QyYVpaaGZrSXFRUWNHZWdCVm5zNHZwdHFk?=
 =?utf-8?B?eGhlc0NWSzI2Ykt5cTc2MUtpUjB6SUt3TG9CM2NPZmR6SnRvVlc5bUluN0hR?=
 =?utf-8?B?WWQxWFNZN1BDTUQ3b2IxelVlcTRFK0RrVHNGNlM4b0xFZk9vcTdPOWVoNGRE?=
 =?utf-8?B?bzJyTnVSVVRSWGhzYmx2WXU5QkNMcERRbWlCU2FwdzgrN2hNTitiRE5WOS9S?=
 =?utf-8?B?Q2R4UEwwZExmd200TWZTQ3FUTm1BbDNoMDByRzBBRTRxM2RRNDdabU94T1JK?=
 =?utf-8?B?S0lxdmYrcEJIcWRmUEV4OUlONSszY2pQdnlwamxPa0U0dGdyZVltQlNEbmd0?=
 =?utf-8?B?d0tTQ0NwUUF1ZGthdmpyUWk4enBGalBsOTk2WmRpTlVtcWJQUFppdGw5cGJ3?=
 =?utf-8?B?UGZsOVp3MXk5N0haY2NMaFpsRkZrRXBrWnhZY2Q4OHF0Ym90TXNxWDVGV09L?=
 =?utf-8?B?YmFQTnFqd3JxNFVqdEtHOWRGWEsvRUNRU0VJOGlKQW1mR1JtNHRDaTNIdVdZ?=
 =?utf-8?B?aFVZWXREZ1NiRkVDSncxNDBWMW5nOUFFaVNESXNoQTZKZjJsWlBGSVBxbGo5?=
 =?utf-8?Q?slQ7+6?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(376014)(366016)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b2w3RStxWVYxeHZXSUJ2WS9LYlIvSVZLU0R6WThEUjl6bTZ5eXpFRHRqU2kx?=
 =?utf-8?B?ZEs3Um5YNG9EREJiQlVhMlRVUTBnNWxmUWhEcUozcU9ESFBPckR5bHZYU212?=
 =?utf-8?B?WGxBY2tHVFRaYWhHQWNBKytzWkRYTS91aVI1aVpjZEJpNUxjR0RFa0F5OEFv?=
 =?utf-8?B?dVQvcnNOaDJzNmE0OFo5L3JSaHVjMkNQVUcvNi94VkZWeXFiSjk2UWRWUTli?=
 =?utf-8?B?ZGxoSUdBZndRZlJLRnFhWjN4bWtlZ3MvN252eTJGTi80M3VSejU5dGV0STZv?=
 =?utf-8?B?T1VyNzRiaEY5OTlQN1p3QTA1VHFkN3BtNWkxS2xjWDlnNGpxOTdxcGQ4TjVr?=
 =?utf-8?B?VkJTM2lEUktmZEV6THlmbXlxQmlST2RKdm5QVlk0SFFETXVyRVZLYXZYREdt?=
 =?utf-8?B?cXdQcUoxTFQzYXZMNTRaTG9XTDhyR0FNUTlHa1JoNGkzQ0d4WkRYMWI5MnNi?=
 =?utf-8?B?TWl1V2dQK0dOQ25uTGhLUkVjeGpsQm5VM2l2bXAxQ0RMU3Q0N25DUVdUeTFY?=
 =?utf-8?B?YUhSSWZvYXBGM05QcXlDaTJiREZXL1JxR29LMlBqMzh6L20zeVRuVlpCMFAy?=
 =?utf-8?B?ZmpxVm5wd3BqUVdXTzFET0xudCtBdXY2N3JqV1JDZms3UmRSQW02VUx1MVFG?=
 =?utf-8?B?QUd5S0loR3R0OGE5QTRDaUZrNWJtVHMwTVFyQ3FVM2hCbHdsWXJldHVpQ3JZ?=
 =?utf-8?B?Z3RpQ096VEpKY3VQdHBlczduaW84Ujc1UHlmenkzc2t5RTZMUHhnR1NDclFM?=
 =?utf-8?B?Q3J4N0RKZTh2SzJQTGcwVUZYVGZXVUI2UzB3SlMrQ0NYemx4YXd4WjMvR0ZO?=
 =?utf-8?B?RDFiRDllMkxEenlobmxuNGl1UkdpMHhrcVo5Z1pOTEVaWUoyUUVkQkRMcE5G?=
 =?utf-8?B?OUtvZStCMmVoU1ZQUjh6anFpeThKZGdLb1ZCQkRCdnJKYXFxN1lWRGJSNktn?=
 =?utf-8?B?OUxBYm1YcFBuQ2lyWjBVZGRRM2NFb2ZxUkVhOXhibkk4RjNVUDhoM3M3clox?=
 =?utf-8?B?MWg0TWpKV1pNZ2lxQ25ZK0JBUnJwLzBvdFpLMlVNOGVqMm85Y1Eyd0NYVEVY?=
 =?utf-8?B?elNsSVFCTXpPRXVTdDEwYVByRWY1NVBpcHRpaUZkbWd5MWtSRUdzTmdKNkhT?=
 =?utf-8?B?eU1QMnFCcjVUbFdtOUdkUkRIdGM4SXN5WUR6YUlLcy9YVkQ3aXZONFB0UkJ2?=
 =?utf-8?B?RnNGK1ZtMUR3Q0ErVTJhTmJHM1JLRVJ1TFZEQmp0RUF6b2MwVUo1ZnJuT3o3?=
 =?utf-8?B?eC9PaDlyZTRJSHkvekJzR1NWcGx6SFpLZUV6TS9yenJ5TGV2Y3NFaVpJN0hO?=
 =?utf-8?B?RW5LNFJyUERqSFlrOEJqMmhSVEIvRFlrNFFlV0x1RjljRkwyN25kRkJDelNW?=
 =?utf-8?B?cDVEYkp6OExTTzl3YS82TjV4SlBmRnc5ampyTURqT2Vac0Q3RzFGdnRNZVNh?=
 =?utf-8?B?QlVuaVNFeEVSNm9nWEl6eEgzQTlmcHV5bHJmbE9sclNSSVZaNFZWaCsrVzYw?=
 =?utf-8?B?K1VZWHgrVUFDVkZTZE1yVFg0cUZFZzkvMFgwVE1wRnRMMm5WZE1zRlgzRk5x?=
 =?utf-8?B?dUwvSHVSWDVJZ2E2VGNYanFQN2dOSlFCaWhuYVRuL3FXSUdzSXlRNTI5SFFr?=
 =?utf-8?B?T3FlOW5IU3JpamowZ2p0UGNmYWFYbVRZa2IzTEtUQlVPSUZjWG5DNE1ydzNl?=
 =?utf-8?B?RUFFeXkrMnB6TnBnZFhaRjlqbHJuVHlXWDJBVDEzZVFIYVZRQnFESUNBYmhD?=
 =?utf-8?B?MU05Zy91ZlM4SThNeFVKRE55bk1aVUp1a0lCaHVya2pDYm10UEliS3BHV2NY?=
 =?utf-8?B?aDk2cnZMZlJ3cFBJSmFOeFlVMWpvRmM4dnc4UUljUm41Wis4UlRGTXhBaWds?=
 =?utf-8?B?TVlXWWEzWW8rTVV2Qlhaa3ErOERtVkdUa01oVThhT0pFNG43ZHpLdjg2S1Rz?=
 =?utf-8?B?T290SFJDbkNHZk9KWm9GVWZ0d1lGNWRVK2J4MjdDNWV1RGg4NExHdnBmSitx?=
 =?utf-8?B?cjFER09mZS83V21qTnJJSkc5enRpVmNDSGJsd2RHRzMrRmZLNTdyaEpwRmxn?=
 =?utf-8?B?VHdWS0prRjVyR3BqbU84eFUyU2tEKzF2UllUcDdFRHYzTmlIN1BIanVrS2pk?=
 =?utf-8?B?K3Nmc1hWemZhWlVoWkxEZzMreEFTbUtWOXpLb1NITDh1dXQ5YUZLNDF3RDlt?=
 =?utf-8?B?U3dhZmxEM282UXpMa2xCcE1jVytwSjJCRzZaRnBMK2g5YStwbHppODZWYXdQ?=
 =?utf-8?B?bUh1cmpJbTVDWGFmY0xsZ0dDM3FCUVJqOWpFamhuZjBiOVR3Nk9uR0pjNWFK?=
 =?utf-8?Q?Ds7R4hOk9AZFxz/DX9?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af8a7aa9-cacf-4b87-821d-08de510f6aef
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2026 12:46:19.3398 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yFCgC1WppnppI3YmGuI1Go2B5ad1t/h9CaI6zDTUnw9lcyvof9kb/gwGhwweAsYreSAmoyaHKbInV16WV98UEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11682
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

SGkgUHJpbW96LA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMTEvMTNdIG1pc2M6IGVsZV9hcGk6
IEFkZCBWb2x0YWdlIGNoYW5nZSBzdGFydA0KPiBhbmQgZmluaXNoIEFQSXMNCj4gDQo+IEhpIFBl
bmcsDQo+IA0KPiBPbiA4LiAwMS4gMjYgMTI6MDYsIFBlbmcgRmFuIChPU1MpIHdyb3RlOg0KPiA+
IEZyb206IFllIExpIDx5ZS5saUBueHAuY29tPg0KPiA+DQo+ID4gT24gR0RFVCBlbmFibGVkIHBh
cnQsIG5lZWQgdG8gY2FsbCB2b2x0YWdlIGNoYW5nZSBzdGFydCBhbmQgZmluaXNoDQo+IA0KPiBK
dXN0IGEgcXVlc3Rpb24sIGlzIHRoaXMgc29tZSBzcGVjaWFsIHBhcnQgb3IgYSByZWd1bGFyIGku
TVg5Mz8NCg0KSXQgaXMgYSBzcGVjaWFsIHBhcnQuICBGaWd1cmUgMS4gUGFydCBudW1iZXIgbm9t
ZW5jbGF0dXJlIGluIFsxXSwNCnRoZXJlIGlzIGEgc3BlY2lhbCBmdXNlIGNoYXIuICJGdWxsIGZl
YXR1cmVkIHdpdGggR0RFVCBlbmFibGVkIiwgDQoNClsxXSBodHRwczovL3d3dy5ueHAuY29tLmNu
L2RvY3MvZW4vZGF0YS1zaGVldC9JTVg5M0FFQy5wZGYNCg0KUmVnYXJkcw0KUGVuZy4NCg0KPiAN
Cj4gSG93IG9yIHdoZXJlIGRvIHlvdSBlbmFibGUgR2xpdGNoIGRldGVjdGlvbj8NCg0KVGhlIGRl
dGVjdGlvbiBpcyBkb25lIGJ5IFNlY3VyZSBFbmNsYXZlLCBpdCBpcyBjb25maWRlbnRpYWwuDQoN
ClRoYW5rcywNClBlbmcuDQoNCj4gDQo+IFRoYW5rcywNCj4gQlIsDQo+IFByaW1veg0KPiANCj4g
DQo+ID4gQVBJcyB3aGVuIGFkanVzdCB0aGUgdm9sdGFnZSBtb3JlIHRoYW4gMTAwbXYuIE90aGVy
d2lzZSBHREVUIHdpbGwNCj4gYmUNCj4gPiB0cmlnZ2VyZWQgYW5kIHN5c3RlbSBpcyByZXNldA0K
PiA+DQo+ID4gUmV2aWV3ZWQtYnk6IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IFllIExpIDx5ZS5saUBueHAuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFBl
bmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBhcmNoL2FybS9pbmNsdWRl
L2FzbS9tYWNoLWlteC9lbGVfYXBpLmggfCAgNCArKysNCj4gPiAgZHJpdmVycy9taXNjL2lteF9l
bGUvZWxlX2FwaS5jICAgICAgICAgIHwgNTANCj4gKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgNTQgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4g
ZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2luY2x1ZGUvYXNtL21hY2gtaW14L2VsZV9hcGkuaA0KPiA+
IGIvYXJjaC9hcm0vaW5jbHVkZS9hc20vbWFjaC1pbXgvZWxlX2FwaS5oDQo+ID4gaW5kZXggNjRi
MjQzZGNhYWEuLjRlMWFmYzQyYmQ4IDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvYXJtL2luY2x1ZGUv
YXNtL21hY2gtaW14L2VsZV9hcGkuaA0KPiA+ICsrKyBiL2FyY2gvYXJtL2luY2x1ZGUvYXNtL21h
Y2gtaW14L2VsZV9hcGkuaA0KPiA+IEBAIC0xNCw2ICsxNCw4IEBADQo+ID4gICNkZWZpbmUgRUxF
X1BJTkdfUkVRICgweDAxKQ0KPiA+ICAjZGVmaW5lIEVMRV9GV19BVVRIX1JFUSAoMHgwMikNCj4g
PiAgI2RlZmluZSBFTEVfUkVTVEFSVF9SU1RfVElNRVJfUkVRICgweDA0KQ0KPiA+ICsjZGVmaW5l
IEVMRV9WT0xUX0NIQU5HRV9TVEFSVF9SRVEgKDB4MTIpICNkZWZpbmUNCj4gPiArRUxFX1ZPTFRf
Q0hBTkdFX0ZJTklTSF9SRVEgKDB4MTMpDQo+ID4gICNkZWZpbmUgRUxFX0RVTVBfREVCVUdfQlVG
RkVSX1JFUSAoMHgyMSkgICNkZWZpbmUNCj4gPiBFTEVfT0VNX0NOVE5fQVVUSF9SRVEgKDB4ODcp
ICAjZGVmaW5lIEVMRV9WRVJJRllfSU1BR0VfUkVRDQo+ICgweDg4KSBAQA0KPiA+IC0xNjAsNCAr
MTYyLDYgQEAgaW50IGVsZV9yZXR1cm5fbGlmZWN5Y2xlX3VwZGF0ZSh1bG9uZw0KPiBzaWduZWRf
bXNnX2JsaywNCj4gPiB1MzIgKnJlc3BvbnNlKTsgIGludCBlbGVfc3RhcnRfcm5nKHZvaWQpOyAg
aW50DQo+ID4gZWxlX3dyaXRlX3NoYWRvd19mdXNlKHUzMiBmdXNlX2lkLCB1MzIgZnVzZV92YWws
IHUzMiAqcmVzcG9uc2UpOw0KPiBpbnQNCj4gPiBlbGVfcmVhZF9zaGFkb3dfZnVzZSh1MzIgZnVz
ZV9pZCwgdTMyICpmdXNlX3ZhbCwgdTMyICpyZXNwb25zZSk7DQo+ID4gK2ludCBlbGVfdm9sdF9j
aGFuZ2Vfc3RhcnRfcmVxKHZvaWQpOw0KPiA+ICtpbnQgZWxlX3ZvbHRfY2hhbmdlX2ZpbmlzaF9y
ZXEodm9pZCk7DQo+ID4gICNlbmRpZg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21pc2MvaW14
X2VsZS9lbGVfYXBpLmMNCj4gPiBiL2RyaXZlcnMvbWlzYy9pbXhfZWxlL2VsZV9hcGkuYyBpbmRl
eCA2NjFmNzBjZjg3MC4uZTdhZWUwZmNlZjENCj4gMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9t
aXNjL2lteF9lbGUvZWxlX2FwaS5jDQo+ID4gKysrIGIvZHJpdmVycy9taXNjL2lteF9lbGUvZWxl
X2FwaS5jDQo+ID4gQEAgLTc5NCwzICs3OTQsNTMgQEAgaW50IGVsZV9nZW5lcmF0ZV9kZWtfYmxv
Yih1MzIga2V5X2lkLCB1MzINCj4gPiBzcmNfcGFkZHIsIHUzMiBkc3RfcGFkZHIsIHUzMiBtYXhf
b3V0cA0KPiA+DQo+ID4gIAlyZXR1cm4gcmV0Ow0KPiA+ICB9DQo+ID4gKw0KPiA+ICtpbnQgZWxl
X3ZvbHRfY2hhbmdlX3N0YXJ0X3JlcSh2b2lkKQ0KPiA+ICt7DQo+ID4gKwlzdHJ1Y3QgdWRldmlj
ZSAqZGV2ID0gZ2QtPmFyY2guZWxlX2RldjsNCj4gPiArCWludCBzaXplID0gc2l6ZW9mKHN0cnVj
dCBlbGVfbXNnKTsNCj4gPiArCXN0cnVjdCBlbGVfbXNnIG1zZyA9IHt9Ow0KPiA+ICsJaW50IHJl
dDsNCj4gPiArDQo+ID4gKwlpZiAoIWRldikgew0KPiA+ICsJCXByaW50ZigiZWxlIGRldiBpcyBu
b3QgaW5pdGlhbGl6ZWRcbiIpOw0KPiA+ICsJCXJldHVybiAtRU5PREVWOw0KPiA+ICsJfQ0KPiA+
ICsNCj4gPiArCW1zZy52ZXJzaW9uID0gRUxFX1ZFUlNJT047DQo+ID4gKwltc2cudGFnID0gRUxF
X0NNRF9UQUc7DQo+ID4gKwltc2cuc2l6ZSA9IDE7DQo+ID4gKwltc2cuY29tbWFuZCA9IEVMRV9W
T0xUX0NIQU5HRV9TVEFSVF9SRVE7DQo+ID4gKw0KPiA+ICsJcmV0ID0gbWlzY19jYWxsKGRldiwg
ZmFsc2UsICZtc2csIHNpemUsICZtc2csIHNpemUpOw0KPiA+ICsJaWYgKHJldCkNCj4gPiArCQlw
cmludGYoIkVycm9yOiAlczogcmV0ICVkLCByZXNwb25zZSAweCV4XG4iLA0KPiA+ICsJCSAgICAg
ICBfX2Z1bmNfXywgcmV0LCBtc2cuZGF0YVswXSk7DQo+ID4gKw0KPiA+ICsJcmV0dXJuIHJldDsN
Cj4gPiArfQ0KPiA+ICsNCj4gPiAraW50IGVsZV92b2x0X2NoYW5nZV9maW5pc2hfcmVxKHZvaWQp
DQo+ID4gK3sNCj4gPiArCXN0cnVjdCB1ZGV2aWNlICpkZXYgPSBnZC0+YXJjaC5lbGVfZGV2Ow0K
PiA+ICsJaW50IHNpemUgPSBzaXplb2Yoc3RydWN0IGVsZV9tc2cpOw0KPiA+ICsJc3RydWN0IGVs
ZV9tc2cgbXNnID0ge307DQo+ID4gKwlpbnQgcmV0Ow0KPiA+ICsNCj4gPiArCWlmICghZGV2KSB7
DQo+ID4gKwkJcHJpbnRmKCJlbGUgZGV2IGlzIG5vdCBpbml0aWFsaXplZFxuIik7DQo+ID4gKwkJ
cmV0dXJuIC1FTk9ERVY7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJbXNnLnZlcnNpb24gPSBFTEVf
VkVSU0lPTjsNCj4gPiArCW1zZy50YWcgPSBFTEVfQ01EX1RBRzsNCj4gPiArCW1zZy5zaXplID0g
MTsNCj4gPiArCW1zZy5jb21tYW5kID0gRUxFX1ZPTFRfQ0hBTkdFX0ZJTklTSF9SRVE7DQo+ID4g
Kw0KPiA+ICsJcmV0ID0gbWlzY19jYWxsKGRldiwgZmFsc2UsICZtc2csIHNpemUsICZtc2csIHNp
emUpOw0KPiA+ICsJaWYgKHJldCkNCj4gPiArCQlwcmludGYoIkVycm9yOiAlczogcmV0ICVkLCBy
ZXNwb25zZSAweCV4XG4iLA0KPiA+ICsJCSAgICAgICBfX2Z1bmNfXywgcmV0LCBtc2cuZGF0YVsw
XSk7DQo+ID4gKw0KPiA+ICsJcmV0dXJuIHJldDsNCj4gPiArfQ0KPiA+DQo+IA0KPiAtLQ0KPiBQ
cmltb3ogRmlzZXINCj4gcGhvbmU6ICszODYtNDEtMzkwLTU0NQ0KPiBlbWFpbDogcHJpbW96LmZp
c2VyQG5vcmlrLmNvbQ0KPiAtLQ0KPiBOb3JpayBzeXN0ZW1zIGQuby5vLg0KPiBZb3VyIGVtYmVk
ZGVkIHNvZnR3YXJlIHBhcnRuZXINCj4gU2xvdmVuaWEsIEVVDQo+IHBob25lOiArMzg2LTQxLTU0
MC01NDUNCj4gZW1haWw6IGluZm9Abm9yaWsuY29tDQoNCg==
