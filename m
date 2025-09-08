Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF499CA1013
	for <u-boot@archiver.kernel.org>; Mon,  8 Sep 2025 03:40:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B58D81E13;
	Mon,  8 Sep 2025 05:40:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="s3++rd1P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3422A82A9E; Mon,  8 Sep 2025 05:40:39 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8472C800B6
 for <u-boot@lists.denx.de>; Mon,  8 Sep 2025 05:40:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l2se8W2VGUNbVwtAtO6u03NoF1/p5gKMlNqIZlZIj7hFAGm9FiTPiMizOCw7sIYnVPENq3v+PRdZDMNPIf6aygevWhc0Cs4FzYIpQVDWRQIYLzOgWZtlkv7WOlW9pwGSw3PjY0pW37Mxsz+hhxI52sLFYRc70nAakntkBoJvAhXDthk18rK/EmmkJ+q+MI0yPFDkBmIa/TaEbLugUnkFBVXsz/I8029OWHts2VTj/VYzcUlo8zubbTB9occJbM3zxMeZUrhJXaC+dS5U/oBR9YQ+dyvlf7snICCq8qvRGudWYDYlTF1Ght6MtlVLJlANxLLgxX7vMzOU0aoCVIvZnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g/0G7fu31J2hmv0V7/BQB3LQ4fOi1bDPkHZOBwkLVDo=;
 b=wqZMJo3iOrfTSjPGLcROvuji3ZqJzyDozIumt9tWYHNWB5jYJJV/qVN6kPmSb4E7ElEFwQsDxVHI8F35WWaVU6ZOsJiKOKfWcHn4UtJW87B3u8Nc2Mfu+8Q0wk3Pi05hR/pRLTjQ/hSvestZteUmLseYJUBMtF3D7FgKpGM4wZpti2mfMoCba0uzS7SokeILo8zRacyKliafWEhTut5+t1jtC5R/GqDYNa1O9WyN/vH/3tiaz+9FBrCqqe0Zt8AyAwu817Lxm/FUALMewjm2JTdLggEdGaHkBcoEDlj9xtPqU7YjHGvQk5G9kpu8RiBWKkL83LBV5J6CjFUEzVBG6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g/0G7fu31J2hmv0V7/BQB3LQ4fOi1bDPkHZOBwkLVDo=;
 b=s3++rd1PpEzX1QGTN9YPIyNThjkfxwR1uMUCb5ygQguAmXF7hMNtP6qv2oQwEeWeORHGnxvUmZFQ5Sah2itt2WQnJFnHNUQ/S855+8r1aj8nA+voy8I1Pva6qPJTPMHw5cBi6eJTgx0bWFhD6JhwdAMRPXlFmXfCXJprOR/LA86exLcggdKekuQFMv3NRnCUeFoWQoX6hxNks9MxDS3by9n+i/9vGT+ynI7lbTOUiWAL7N5rr/NqNoZR/rRPH3SE4c1xHL+x8mMlpScSfqDKmGqXwkrA8eL9t3p0qdQpOHoKL7/FEghHOulF1GBePfF2Lp0y0dgljzazwL0tEntJPA==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by GV4PR04MB11403.eurprd04.prod.outlook.com (2603:10a6:150:29a::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.13; Mon, 8 Sep
 2025 03:40:33 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9115.010; Mon, 8 Sep 2025
 03:40:33 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: Fabio Estevam <festevam@gmail.com>, "Alice Guo (OSS)"
 <alice.guo@oss.nxp.com>
CC: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Alper Nebi
 Yasak <alpernebiyasak@gmail.com>, Stefano Babic <sbabic@nabladev.com>,
 dl-uboot-imx <uboot-imx@nxp.com>, Alice Guo <alice.guo@nxp.com>, Marek Vasut
 <marek.vasut@mailbox.org>, "tharvey@gateworks.com" <tharvey@gateworks.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjQgMS8yXSBiaW5tYW46IGFkZCBhIG5ldyBlbnRy?=
 =?utf-8?B?eSB0eXBlIHRvIHN1cHBvcnQgLmJpbiBmaWxlIGdlbmVyYXRpb24gZm9yIHRo?=
 =?utf-8?Q?e_i.MX95_platform?=
Thread-Topic: [PATCH v4 1/2] binman: add a new entry type to support .bin file
 generation for the i.MX95 platform
Thread-Index: AQHcFyEnGuGLh3dJd0CButZ5siesGLSFMLUAgAOASYA=
Date: Mon, 8 Sep 2025 03:40:32 +0000
Message-ID: <PAXPR04MB964427E6CFEFCC51D44D046AE20CA@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20250818-imx95-v1-0-f68a19fe30b6@oss.nxp.com>
 <20250818-imx95-v1-1-f68a19fe30b6@oss.nxp.com>
 <CAOMZO5C=ROcrsS256shQNP4Dfz9ca_55tT1hQNHUM=kOrxnVUg@mail.gmail.com>
In-Reply-To: <CAOMZO5C=ROcrsS256shQNP4Dfz9ca_55tT1hQNHUM=kOrxnVUg@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|GV4PR04MB11403:EE_
x-ms-office365-filtering-correlation-id: 105bf4e6-480d-4aa0-4f14-08ddee8976f8
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|376014|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?ZzgwMnNMelhkQzNpOXVITUpRaVBpdmYxaWJXYllyMWFrVi9Kbmh6b3lJVURZ?=
 =?utf-8?B?ZkNIaTZISXhmaVZPM2tpcVhxWk1VdUN1Zm45MnBjcUt4c2dldEZ1M3NOYXh5?=
 =?utf-8?B?ZW9KeU0vTXJzWXJLVk55am9oNGFkR3pJRjd5dG9LMWxGMGFzelF3MDYzQXpo?=
 =?utf-8?B?c2Z2OTlFNG1pM2k3YWdKU3ppQTFaYkJFTTBzVjY1UW5hdk15TGxVRHdxbzBq?=
 =?utf-8?B?bzY5dkRoOVdZdWNib1BPSEN3YUJSdEQrT0R4VkVrd0kwZ0Iyd2dMYXpKVWVX?=
 =?utf-8?B?SWlJNFVYcjc0YzM2RGF5Q1R3V1FYaUI2dGRZTCswanhoeWhjV3hPNzdvR3Fs?=
 =?utf-8?B?cVVZMzBBM0FCSDZyL1lIWVA2aVhzamRyK1lLdk5PV1pvVXd3MTlwUEllYUpj?=
 =?utf-8?B?Q2ZxSjRGOHh0ZW9JMDRSNnNNT2FERVhDVmFNeXE1aGdwdE1kK0RibFVXSnYx?=
 =?utf-8?B?b1J2SmRrUUU5RUZJNklIUEppVExYTE5qNUVEcVJlRmdHNEFvQUVjdWdNaFJy?=
 =?utf-8?B?MWV0ZFJaOGZOcEZwQlVTOWNoRGZrWXcrd1o3YVFsdjVFOVVNZXVKY0hBcXBo?=
 =?utf-8?B?Y2VBSnJaY0FXSS9PMHZBd2FZWEYyZzhTdVFlblNwN3dxWEJ2T3dhM3UySmtv?=
 =?utf-8?B?eS96MkFOOVRIL01mSkRpQUtPUGQ2QlFkWDFJbHppWkVzWGtPV0JTKzJvSW1U?=
 =?utf-8?B?QjZUQTFLa1NycUh2QkpFa2xzNXRFcUpuNFZHcC84eUV0azgwcFpuNWVpUTJT?=
 =?utf-8?B?OHhwT2Z5emQxejBKcTNCZFlncGo3QXhZbE00UTM3bWgyM0JyOFYrYnE5RXRj?=
 =?utf-8?B?ODhZbXg5bzRBcUo1bmpMcXNkL2ZsRGt5b1FOQ29LRFRVVTR2bEZ6UGJtaFBh?=
 =?utf-8?B?RllyaWtnMUFlTjZ4bXpSUUVMc0NFWjY2SFB5K1BSNzJ3ZmpFQjVkY0hJZ0N6?=
 =?utf-8?B?aUpuSHg3RWgrRm1yS0drZVBKQ05ySG1FekxYTGhRUm8reDg2eGRobDB5Znoy?=
 =?utf-8?B?NU9SNEkwMVRNc3VVN0NzMFRxY21ZVXpHUlU5aVVHeVNUWFBXbldKdlQwdDE3?=
 =?utf-8?B?eC9DcUtYVytGZ05qYkEvUlpPbHZRVHdDTGZaeE5TVDhBV05rOE1FaVNTRWxr?=
 =?utf-8?B?ZHRCbGlOcnJxbitHbXh5T283cE9oL3JIZzdpc1R5dkYwWTBtSTVwRzBiblIw?=
 =?utf-8?B?VVF3NnpGVkY0c3VOcktoamYvZXgxSjFhQkxEbXZET1pNdk9IL0NHald4bzV2?=
 =?utf-8?B?UGttK3VnRFdjNFRsSFlhL0JrL0VVd3dIRW1EV2Y1akdrekt3OXpZRUlZL2RU?=
 =?utf-8?B?UHpiM3lNVVlQZWVpM2ZRbDVOQVl3emo5ZmJlY3V1c0srRExwQ3dqK3B5MTJ0?=
 =?utf-8?B?bzJSc2Y0UW9Ga0ZtZS8wR3RNNXcyMnJOeGVrVzYyRlF5QzQzTGNLTXliY21X?=
 =?utf-8?B?U3pKNjVaZ2ltWENsVVN1YmVucUo2WS9IWHQvMXJjR1AyQjdJZGtCckN5TjRo?=
 =?utf-8?B?RVRxN0FFdHpvbXRjT2tZYWZBb3R4M1FJQklmR2VzVHF5VnF5ZjBYSzhlUk9i?=
 =?utf-8?B?WGVxYlpOYTAxUUNPVXlYaXRPbHhqM2N0MzkvSjhjNUo0YnRmQ2N3WjYyd01k?=
 =?utf-8?B?enIyeE8zeGk5c3lHMnFOdWNIRm1sb3J5ZGhwb0ljajlWQktlbmZJV2hCS04v?=
 =?utf-8?B?dUZoMWhMSWlwcUdWeUlHTVpKVnNHZkEyYnc3S0lzRXZzblZVWGtuN1dhaVpP?=
 =?utf-8?B?eSt2MHpMYkZSb2c1UTNHdVJqZFUzeTFtekx2RVBSamxaS3lmUGZMVzU2a2tk?=
 =?utf-8?B?U0pnWEJTSFM0S1J3eS9iRk5najhOS0F5WHBNYXZkUHUvdjlTYngrMEpWdjI0?=
 =?utf-8?B?QXR4cGExSEptSXNLZTNXYURyTExscmxMMFRMQ00rSVlPVFlXNW00L2ZzYjZ5?=
 =?utf-8?Q?ph3CKGGFWE4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(19092799006)(376014)(366016)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SUNoQXppRG1wc05iSUtkLzFGbWZ5YzFrVUhBcU1CRG1lU1BpN2cwZlZNV1p1?=
 =?utf-8?B?dEk1ZjZaclp0OGtzU2NkWjNCM1M4dGNJNU9NSE1GTFVUcFVaeWVMMGxva1NG?=
 =?utf-8?B?ZHBIelBVUDAvRXpJNWNGRW5qWXhncWs3Y1hUbFlPUXhhZEpTa256ekJEeVNt?=
 =?utf-8?B?RnZTUlJUSzhBWGt4RDNCRnk4eHk5cU14Rkx5QXhBcVowWmlrMUVCQXRiSkNs?=
 =?utf-8?B?OGtUUDcvc0dxREt6K3djcWNwdG95NmhDSFpSUmZuZGtwbWtSU3JXZHRzOGNC?=
 =?utf-8?B?WUFsN3pPa0h6ZHgzaEFSMmJIMXNJczM2UENPc3NrdmM4T0lkRUplY3BOUUVH?=
 =?utf-8?B?cmJtSlVVR3NHU1ZaaTRKNFhCMFdqeC91d1Nob0ZTUkYvYTMrT1lxcFFwUWlR?=
 =?utf-8?B?a2pVdVI4N1NhQnJ3ZXYyMGJtclpGOERlU1drZUlTUlhtWXdndUZVUUFtYVU3?=
 =?utf-8?B?TXlaRlpwanFTY20rKytzc0t0OFFvSmtVcGlyS3ZoQUtoOWpvTGlMNDU3RW1T?=
 =?utf-8?B?UWlZMGIyZGNETjhuYUZlclVkME4xdWYyTHFWanBMalo0djkvT2FnbHdCLzN4?=
 =?utf-8?B?dFlkSDJYajRScGkyLzhaTmp4bkxlUWZTV3BMUnZib3l5T1l2UnEwZDJPaWZC?=
 =?utf-8?B?UE1rMnY2bjVYaGVydXA0eEpqU0lzMXUrRnZvSnBJcjF0aW1IVi9NUHArTm1h?=
 =?utf-8?B?cGZ0TnJMbkdMdDRDYk85STFUb3I3OWNLVlkrR0ZNNVJxUE9UZ2xNbHZRT1BX?=
 =?utf-8?B?K0VqSmQ5SDBjSjZGOGdzcHVhZmNPeWZMWmFZYVM1QkpKRWo5d3Uzc1JGZ2ta?=
 =?utf-8?B?THZUUlZqTDhTT0ZHanFPY0l1aG9qcGx6R2tWdWhENWprS1RLWjVjalRWQkRu?=
 =?utf-8?B?SFkzaCtzc2pJeDN6KzZ0RDN5L3VEQ040b09JS1ZTOGQ2WWcvcXhzQVJzZlJZ?=
 =?utf-8?B?VmdRSGw3MWp0RmV1aDBxTlhHNzJIMEhla1FWaFFCMG9ydkwxMUJUQUw3QmxC?=
 =?utf-8?B?eks5a3MvK3FmT01mWUhLVUNHdVJnYVlVQXFMWUYxVWpQZ21adE9URFV4cFNz?=
 =?utf-8?B?WEJKUWdyTENMMWZMUm03b1hrd2ZFcVJmU0szd1Y2eFhCdWJlSUMwekV6L2ox?=
 =?utf-8?B?dkF3blR3dGxLbFRKbmllcWp1Q1hPeXd2TzcyVUNVaWpGZWRCamZNNVZJMk1S?=
 =?utf-8?B?ZzVMemZwRkpUUlhIWVQ0SFJPY1B2bzZHVHBTLzVKcGY4SlN2Q01BUzRjLzd2?=
 =?utf-8?B?clhBdlRqRGtWV2l6aVNldEZRbkd4NXNvZXdIT1d4Vm9LOUlkN2JQSW9QVWZo?=
 =?utf-8?B?OGx3V0NvVzVUT0pKTzQ4MWpwY1M5amN2TGRkZE9COEVpaDVhSHdYN3doeXhr?=
 =?utf-8?B?SXAyYUFJemExTzM2bUkvY0piTzN6N0l6Q2pWbUJsYnlsRHJQSUtzYk50dm9o?=
 =?utf-8?B?UmJ5Sm4vQ3B6SkFwL0RHajc0U2lvWU0xSjJ3RHNSakZaWlBkSUNJY0drVnFN?=
 =?utf-8?B?S2JxTURzTDBMbzdtSFMyRHVGZ3RPMEw3VnAwREZNblBHbXBkWEZtSFpsSkph?=
 =?utf-8?B?R3Byam4xYldWK1ZZT0kwNHBET0lNQ0ZRbTQ3cTkzY3ROL2RYZStrcG5kZlE5?=
 =?utf-8?B?dU5FTWNFdFJiZmFPYU1qL0lITlNtNmhRdzhIYjBTNk9ydGdoWVZJdVhlRURY?=
 =?utf-8?B?N2tRakoweWhhZ0wxZWxxN2tXOEMzWEl1WXc4TEhKV1NWZHBybUg2UTdJOXVm?=
 =?utf-8?B?WW5sc3ZYbDNuSmZRUk9pTEVFNVFGMy9tN2pLTE8wVEF3NW50bG1qaDZKSUxW?=
 =?utf-8?B?UkRuRFg2RC9LU0VQQlZSc2JUQ2ZPZWplVXZPbEFWY2QvckVucmYvdmgxdWdp?=
 =?utf-8?B?R3ppVXQ0aDRiendoSlpVamR4cmgxMERJNkRkZmN3eU9lajlPVkdRQllKZWRS?=
 =?utf-8?B?V1N6OWluKzZvenBLUCtyaHJJVHR1N21xK0poK3hPL0Y5R3BGTjhUd2JHQzcx?=
 =?utf-8?B?NFN2TTV5VDJPbm5TZUU5VFFjRHFaNDFzc2hvVFVuRTNDSng5Q0cvbFZnWFE1?=
 =?utf-8?B?eEhRbkNWSEZPNGZUbGpRa25kSUM5QlJLdEttMnM1bTZ0d3ZZZnZKT0kxUjNi?=
 =?utf-8?Q?dwWhjsVca+kBjq0xpYRa/48ZK?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 105bf4e6-480d-4aa0-4f14-08ddee8976f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2025 03:40:33.0104 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZIDsBgPimjT3r4kuJYnhH/vDL4jchNC2kHxXkmMVknTZuS5jzpx7MQC7OzQNvl2b4LAn3VOrf/8cwb/sT022Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11403
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

PiAtLS0tLemCruS7tuWOn+S7ti0tLS0tDQo+IOWPkeS7tuS6ujogRmFiaW8gRXN0ZXZhbSA8ZmVz
dGV2YW1AZ21haWwuY29tPg0KPiDlj5HpgIHml7bpl7Q6IDIwMjXlubQ55pyINuaXpSA1OjUzDQo+
IOaUtuS7tuS6ujogQWxpY2UgR3VvIChPU1MpIDxhbGljZS5ndW9Ab3NzLm54cC5jb20+DQo+IOaK
hOmAgTogVG9tIFJpbmkgPHRyaW5pQGtvbnN1bGtvLmNvbT47IFNpbW9uIEdsYXNzIDxzamdAY2hy
b21pdW0ub3JnPjsgQWxwZXINCj4gTmViaSBZYXNhayA8YWxwZXJuZWJpeWFzYWtAZ21haWwuY29t
PjsgU3RlZmFubyBCYWJpYw0KPiA8c2JhYmljQG5hYmxhZGV2LmNvbT47IGRsLXVib290LWlteCA8
dWJvb3QtaW14QG54cC5jb20+OyBBbGljZSBHdW8NCj4gPGFsaWNlLmd1b0BueHAuY29tPjsgTWFy
ZWsgVmFzdXQgPG1hcmVrLnZhc3V0QG1haWxib3gub3JnPjsNCj4gdGhhcnZleUBnYXRld29ya3Mu
Y29tOyB1LWJvb3RAbGlzdHMuZGVueC5kZQ0KPiDkuLvpopg6IFJlOiBbUEFUQ0ggdjQgMS8yXSBi
aW5tYW46IGFkZCBhIG5ldyBlbnRyeSB0eXBlIHRvIHN1cHBvcnQgLmJpbiBmaWxlDQo+IGdlbmVy
YXRpb24gZm9yIHRoZSBpLk1YOTUgcGxhdGZvcm0NCj4gDQo+IE9uIFdlZCwgQXVnIDI3LCAyMDI1
IGF0IDQ6MDbigK9BTSBBbGljZSBHdW8gKE9TUykgPGFsaWNlLmd1b0Bvc3MubnhwLmNvbT4NCj4g
d3JvdGU6DQo+ID4NCj4gPiBGcm9tOiBBbGljZSBHdW8gPGFsaWNlLmd1b0BueHAuY29tPg0KPiA+
DQo+ID4gVG8gc3VwcG9ydCBwYXNzaW5nIHNwZWNpZmljIGNvbW1hbmRzIGRlZmluZWQgaW4gZW51
bSBpbXg4aW1hZ2VfY21kIHRvDQo+ID4gdGhlIGlteDhpbWFnZV9jb3B5X2ltYWdlKCkgZnVuY3Rp
b24sIHRoaXMgcGF0Y2ggaW50cm9kdWNlcyBhIG5ldyBlbnRyeQ0KPiA+IHR5cGUgbnhwLWlteDlp
bWFnZS4gVGhpcyBlbnRyeSBnZW5lcmF0ZXMgYSBwbGFpbiB0ZXh0IGRhdGEgZmlsZQ0KPiA+IGNv
bnRhaW5pbmcgdGhlIHJlbGV2YW50IGNvbW1hbmRzLCBlbmFibGluZyBmbGV4aWJsZSBjb25maWd1
cmF0aW9uDQo+ID4gZHVyaW5nIGltYWdlIGNyZWF0aW9uLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1i
eTogQWxpY2UgR3VvIDxhbGljZS5ndW9AbnhwLmNvbT4NCj4gDQo+IEknbSBnZXR0aW5nIENJIGZh
aWx1cmVzOg0KPiANCj4gKy9iaW5tYW4vbTMzLW9laS1kZHJmdy9vZWktbTMzLWRkciAob2VpLW0z
My1kZHIuYmluKToNCj4gKy9iaW5tYW4vbTMzLW9laS1kZHJmdy9pbXgtbHBkZHIvaW14LWxwZGRy
LWltZW0NCj4gKGxwZGRyNV9pbWVtX3YyMDI0MDkuYmluKToNCj4gKy9iaW5tYW4vbTMzLW9laS1k
ZHJmdy9pbXgtbHBkZHIvaW14LWxwZGRyLWRtZW0NCj4gKGxwZGRyNV9kbWVtX3YyMDI0MDkuYmlu
KToNCj4gKy9iaW5tYW4vbTMzLW9laS1kZHJmdy9pbXgtbHBkZHItcWIvaW14LWxwZGRyLWltZW0t
cWINCj4gKGxwZGRyNV9pbWVtX3FiX3YyMDI0MDkuYmluKToNCj4gKy9iaW5tYW4vbTMzLW9laS1k
ZHJmdy9pbXgtbHBkZHItcWIvaW14LWxwZGRyLWRtZW0tcWINCj4gKGxwZGRyNV9kbWVtX3FiX3Yy
MDI0MDkuYmluKToNCj4gK0ltYWdlICdtMzMtb2VpLWRkcmZ3JyBoYXMgZmFrZWQgZXh0ZXJuYWwg
YmxvYnMgYW5kIGlzIG5vbi1mdW5jdGlvbmFsOg0KPiBvZWktbTMzLWRkci5iaW4gbHBkZHI1X2lt
ZW1fdjIwMjQwOS5iaW4gbHBkZHI1X2RtZW1fdjIwMjQwOS5iaW4NCj4gbHBkZHI1X2ltZW1fcWJf
djIwMjQwOS5iaW4gbHBkZHI1X2RtZW1fcWJfdjIwMjQwOS5iaW4NCj4gK2Jpbm1hbjogRXJyb3Ig
MSBydW5uaW5nICdta2ltYWdlIC1kIC4vaW14OWltYWdlLmlteC1ib290LnNwbCAtbg0KPiAuL3Nw
bC91LWJvb3Qtc3BsLmNmZ291dCAtVCBpbXg4aW1hZ2UgLi9pbXg5aW1hZ2Utb3V0LmlteC1ib290
LnNwbCc6DQo+IEZhaWwgb3BlbiBmaXJzdCBjb250YWluZXIgZmlsZSBteDk1YjAtYWhhYi1jb250
YWluZXIuaW1nDQo+ICttYWtlWzFdOiAqKiogW01ha2VmaWxlOjEzMzk6IC5iaW5tYW5fc3RhbXBd
IEVycm9yIDENCj4gK21ha2U6ICoqKiBbTWFrZWZpbGU6MTk4OiBzdWItbWFrZV0gRXJyb3IgMg0K
PiArYmlubWFuOiBFcnJvciAxIHJ1bm5pbmcgJ21raW1hZ2UgLWQgLi9pbXg5aW1hZ2UuaW14LWJv
b3Quc3BsIC1uDQo+IC4vc3BsL3UtYm9vdC1zcGwuY2Znb3V0IC1UIGlteDhpbWFnZSAuL2lteDlp
bWFnZS1vdXQuaW14LWJvb3Quc3BsJzoNCj4gRmFpbCBvcGVuIGZpcnN0IGNvbnRhaW5lciBmaWxl
IG14OTVhMC1haGFiLWNvbnRhaW5lci5pbWcNCj4gDQo+IGh0dHBzOi8vc291cmNlLmRlbnguZGUv
dS1ib290L2N1c3RvZGlhbnMvdS1ib290LWlteC8tL2pvYnMvMTIzODk2NQ0KPiANCj4gVG8gcmVp
bmZvcmNlIHdoYXQgSSBhc2tlZCB5b3UgYmVmb3JlOiBmb3IgdjUsIHBsZWFzZSBtYWtlIHN1cmUg
dGhhdCB5b3Ugc2VuZCBtZQ0KPiBhIGxpbmsgc2hvd2luZyB0aGF0IENJIGhhcyBwYXNzZWQuDQoN
CkhpIEZhYmlvLA0KDQpUaGFuayB5b3UgZm9yIHlvdXIgbWVzc2FnZS4gSSBhbSBjdXJyZW50bHkg
dXNpbmcgQXp1cmUgUGlwZWxpbmVzIChmcmVlIHZlcnNpb24pLCBidXQgcmVjZW50bHkgdGhlIHdv
cmxkX2J1aWxkIHN0YWdlIGhhcyBmYWlsZWQgdG8gcnVuIHByb3Blcmx5LiBJIHdpbGwgdHJ5IGFs
dGVybmF0aXZlIHdheSB0byBydW4gdGhlIENJIHBpcGVsaW5lIHRvIGVuc3VyZSBldmVyeXRoaW5n
IGlzIHByb3Blcmx5IGNoZWNrZWQgYmVmb3JlIHBvc3RpbmcuDQoNCkJlc3QgUmVnYXJkcywNCkFs
aWNlIEd1bw0KDQo=
