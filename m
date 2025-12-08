Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F73DD3B7E2
	for <u-boot@archiver.kernel.org>; Mon,  8 Dec 2025 12:44:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6204383AB0;
	Mon,  8 Dec 2025 13:44:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="ZPttyqkN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38B2483956; Mon,  8 Dec 2025 13:10:36 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B89D883935
 for <u-boot@lists.denx.de>; Mon,  8 Dec 2025 13:10:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jamie.Gibbons@microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gUP8zivFlLpHJ0d/eznS2fSdDBBC6BLkKs7KejStknJTgQnxBVQs8Yqt3y3RhFsYC8xXvvjihrYG86pE2Jv3E9GHKX29erzbX+WOWc6aB7hzZA8OU0QtmaYpcOKxCN/5KGZFdv5ukgxAQLQsMI8fztycj3LItpXhrQWjD2N2KpJ4dH6ofeWXtpRYq5jeF/73FCl7B/VC+OnCZ++SAUYPc8WOPlsnJeV2nPWVE6acQKH5ItPRH+6ORxvYHUCA58FGLMC5g5YxmhQ5ma4Bg0lg7e53Lm2XVxI+IZ8G3sia0iVIZZTZaRbmpD3/KItVm/e9APyVD75JLrZy2KmmNxJ72w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kquUkGoaMD+u1Gdg84/7nrQ9kbuCp8H7cnbZZ2NDJ3k=;
 b=yd3weqizi/oSn6icaIO41HknEvl0GLGVcSMgLPzYVsGFsHOZ29Jzj7rmmPDpLrrP92HsAUWnC1ZnKZLlel7gEHPBPiaHAr92ZcC8O39NmuZYJ2jBSKfMPYaOnKtfri/C/U+2HgfvFJKOHRF6XK/SQY97GpsYcXHNFyyLUBEUhXCcwpyvsO+BpxcLUtfv89pkAwrba6gWfp6cCvGTn9//k3bEu8me/HB9X4sChzAbFNlOhcCBaw5rOvSHv1xxBlbQ7rQ7LkPhrXLsMLarLlgUoaJiHc/zwfvFy5fjJsplvj0SH1ktbjFcwjWG3Ay4bu8m7OUBuLsssY8yROcDHR1MnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kquUkGoaMD+u1Gdg84/7nrQ9kbuCp8H7cnbZZ2NDJ3k=;
 b=ZPttyqkNQUc4+Vzbn/FpLI9EAy1phmTIh3hOkIl/uAmFG1SBHC6d0GZPCnZTLkvTnEKCGft+BV2a0YUDZoNYzYAxvL5YJ2Kjud2QCcnmrGpd73BSGxm/qxS+w3LpxdDKRLxjtVFu/WlVpHqVg5HaUP0Qu4Hs2ftjSvewpXlf4Vyq4jE0+L0b8yKW5SMKxTtObpFiiwUzbN4kkgqxCDZTJ/qYewvXqorXdZxsobgchJGCuuGszaXa6Y1R1PJj4RBx/ry0u+fqegyTQW6MHtJ4IOAf6b+I0F/DoWd9S+6GhuqGW0vAvqY2dwk6SqIlcvYJAuG1rf7lmsRu7jDFjnmC5Q==
Received: from DM4PR11MB6335.namprd11.prod.outlook.com (2603:10b6:8:b7::10) by
 DM4PR11MB6141.namprd11.prod.outlook.com (2603:10b6:8:b3::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.14; Mon, 8 Dec 2025 12:10:28 +0000
Received: from DM4PR11MB6335.namprd11.prod.outlook.com
 ([fe80::3adb:8c97:94da:80]) by DM4PR11MB6335.namprd11.prod.outlook.com
 ([fe80::3adb:8c97:94da:80%3]) with mapi id 15.20.9388.013; Mon, 8 Dec 2025
 12:10:28 +0000
From: <Jamie.Gibbons@microchip.com>
To: <ycliang@andestech.com>
CC: <ziyao@disroot.org>, <u-boot@lists.denx.de>, <trini@konsulko.com>,
 <Conor.Dooley@microchip.com>, <Valentina.FernandezAlanis@microchip.com>,
 <junhui.liu@pigmoral.tech>, <rick@andestech.com>
Subject: Re: [PATCH 1/2] riscv: create a custom CPU implementation for
 PolarFire SoC
Thread-Topic: [PATCH 1/2] riscv: create a custom CPU implementation for
 PolarFire SoC
Thread-Index: AQHcWVD/RnPTorg1nEi5sGwPSPgnhbURMTMAgAaTcAA=
Date: Mon, 8 Dec 2025 12:10:28 +0000
Message-ID: <471395da081e977a4db8795e7cfd5022ebd058e6.camel@microchip.com>
References: <20251119123843.4171699-1-jamie.gibbons@microchip.com>
 <20251119123843.4171699-2-jamie.gibbons@microchip.com>
 <aTE8Bi9kmTqaUgpy@swlinux02>
In-Reply-To: <aTE8Bi9kmTqaUgpy@swlinux02>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6335:EE_|DM4PR11MB6141:EE_
x-ms-office365-filtering-correlation-id: 60c2270b-7e6b-4ff4-77ee-08de3652c6b7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?WkdEVjFPdTBmd2FGOGpEMjF0dHp5Q1duL1pOem4xRHVjMkpLcGx5YWVXTERa?=
 =?utf-8?B?UEdHUGhSc0hIMUdzUHpraENRcHNjWVN0ZnhLVVYyUCt2alhuRFZNaEFOVGtC?=
 =?utf-8?B?TGhHRTczczlhVGZ2dFlWcjUzOXFqb25PTDQ1Vjh4cDJMRVpNVUw4TTlzMElq?=
 =?utf-8?B?ZjJaQnRFMmxxZGVpTVhrRENWYmwzTW1SS1ozZUQ4eW5KVXgyUis2S3ZoUHJa?=
 =?utf-8?B?ZWNFOFRyeGI3NFR1SDlRb1Joak1odCtleHZCZGhxRVBnc3lmNkJRdFJ6ZHRp?=
 =?utf-8?B?Q2d2SFRTeDlZSmJ1WmNlZmV6R2pOSFFHTnlHaGMvZ3NOL3VGQ015TDd1cGZD?=
 =?utf-8?B?bjdtcUF2VW9HT2puVDZlU0dRcVdNeUkvMi9MM3Q5SWE4elNYRFV1L1hXZHJF?=
 =?utf-8?B?NUdJbTNtZFdML1hrcjhEdGVZdUtZazM1N1ovdzhOTjUwd1VyME1wVnBVZDF6?=
 =?utf-8?B?T3FyMzByQk0wSzZKZGFSbWJLNVhyMk5UeU5MMkZ4TldHKysxaXQveVNETmQy?=
 =?utf-8?B?NEVubFJHSDZaQnRuVEtMZzl2eWVhL3FqR25pMHkvVzk4T2dGcXJKZ3VBaDdO?=
 =?utf-8?B?VjRJeUdva3FQZUdjaDllamhOSDZLYUpaSjdvbE13VldzVGpUaTBxcW0zRkd1?=
 =?utf-8?B?bjNsUTlEUXQ0bDRld2pWZFFWemJRa2FSZFJXRnZMbUtCTWlPUlJOZVU5NTF4?=
 =?utf-8?B?OVo5ellzZTYrdHg0cy9qcjk1K3hLbHVCSk5oS3RxeWt2Qis1K05YWU1IYStM?=
 =?utf-8?B?akoxWXlZVTJ6UTYvNS9icU1NSWs0cmw1NzFuTmw5UTZhNWI3N01oK3JEQU9Z?=
 =?utf-8?B?L3ZOQjJLeU9weEtHOXNMTW9PZjRPcmFiaURyR1JUcU53bnltY1pMMlkvakNC?=
 =?utf-8?B?c1M5Wlo0cllSdEJpVWhURTlqc1VGdnVvcmlCQUpBUmNXVFdVSjFiYXVPRGlo?=
 =?utf-8?B?V0x2dGh0eVpiMG9lY2wvNU9zN2grWHB6OG5zMFE5UndZbFQyY1ZzOFErbUV3?=
 =?utf-8?B?d0ZJck4xM1Z0VHNKbDJlaVk2UFVreEtEVWZ3WEVZcStxQ3hkcW5RVWd1LzRZ?=
 =?utf-8?B?QmZneG8rOFFzMXZMU0tXWTBpeVJZRnB1TmNkUmo5Ull3ajUzVzBWdHhJTElr?=
 =?utf-8?B?NmlLQ3p1VERZd0RidVNNN2ZxY2hCWWVzU3JpUzdLYkNKdnlFNGtheG0yY2JW?=
 =?utf-8?B?RWEzNlhYTTluN0lHUlMxY2cxeW5xRy9xaGtTbloyUzhVTXpKVWZneVRpQjVR?=
 =?utf-8?B?ekpWQWk1SkFjMU9ZeEJ5NXJlZEdkbDhLNzNvNjlmemN0WkVHc0RrM0tvSFdq?=
 =?utf-8?B?TmFCWG1GM1FtamVBUzUxT1dUeXdrdTFlckhPOUZSYVZKUFhOcjFOM3NkbmVo?=
 =?utf-8?B?S20rOS95UnFRTlA4Y09SN3FFOTNiTS9vQWN5SDBjS2pQQi9vUjBFaVhCMngv?=
 =?utf-8?B?YVF2Uzg3ZmFHRzMvUGpJVEFZUlhSczZtV2ZrWnRQcEl6bzBWMGR5ZndBQ0FG?=
 =?utf-8?B?NXJodHlHSFJkV3BZMzFsRDVnWmh0bWszU3ZoL2Rvc3ZsSUpuczRFc3ovdnpV?=
 =?utf-8?B?Ukg3a09TcFdEMW8xeENGTzNWVWJVMGhYcHVXazlTS0xiWjZWNTVobXVPc09j?=
 =?utf-8?B?MG4rNUhPellIY3BxYThVNXV3RmFGZXU5TldRU3JYWTBGT3laMi9PSFA1aXgr?=
 =?utf-8?B?VHZFZFE1OFlkMEUxOUdjMGRaUUwySGlJdWx5VFRUY2FhdzZlaGEvMmROMmUw?=
 =?utf-8?B?RVhIS0NyRnJtVzVobGk1MUN3dXFObUJjTFNkdVVJb2kweEtEazZibnpoWjE2?=
 =?utf-8?B?dytPQzJzMEJXendpQzc1eVA5a3N1NHFxZ1lXSERyYWpFd3lHZitIdTk3ZDBN?=
 =?utf-8?B?WSt0UmNBU0kyVzc0aXJmU01IekhqMCtac3c2bHNtc3NQSkFNVXJMc1FVdWlT?=
 =?utf-8?B?N0NaUnZNSDNyeFFPTWtVMmo3SHozeCtFbmNsMUw4ZFpyWVV0UHBzZXdYV3ZV?=
 =?utf-8?B?emI2WHlGcEJMcGNYU3U1SENzRnVHRmdnMUZ5TGtpZEF1TCsxbnAvMXhMK21D?=
 =?utf-8?Q?zmrZt/?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6335.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VFBNaHNSNmpJTEJ1Y09UMHpEeTdFTWg3bkhHNU9QWm94N2ZkN0oyb1RUaGFX?=
 =?utf-8?B?dUMreDE4aUsvVVU5RU5JeUF5QjdObEh6RE1Ia21DNWpjOXJSVU5qcWtGSFVK?=
 =?utf-8?B?VlBFMnBLbCtBOStvTXA2SDVielhsRWhINmhNUTY5Z0RZOWYyOXdtY3NmY0Q4?=
 =?utf-8?B?LzFSVXVqaWp6RE92MHZSbGE5aThWUHhHeTcrRjV4dldYQUhwcjE0Zi9SYUM2?=
 =?utf-8?B?REN2RG1qdjRVbDZyMlR1SW1TaFVZM1l0YTZIRkFaenJrOVNXY2NZTzA1SkJS?=
 =?utf-8?B?dWdkYkMzbVdTS3E2ZHNUU25XaUNDVG1FeERDN1FNNkIvY2FNUmcwNGZ1MlZF?=
 =?utf-8?B?bmlpZGJpMlV4aG8relNLaVFRSG9EbDRFMlBxN3ZKbitpR2c4N1RMOVpFcjBR?=
 =?utf-8?B?VnFrbjZyVDlkc3FWZU01R1NkWllNbjlIWTRNVjNucTRxZkEvcndBNHVhYmZK?=
 =?utf-8?B?WHlBR3hxYWhRSXRQSTczcXI3bG11ZUE3UEpwaVg1N3lwRWRuVHN1elF6MmZx?=
 =?utf-8?B?YlowVWpESm9BR1AyRlUzSlpZbTZzdVc0TmE4QmZXOHdkSnFCOFNnTUl4djMz?=
 =?utf-8?B?dHFWZ0FHcURFdlpDN0UzUXJENnpnclBVTHNzOWVyQXR1eE81MWJUQ2xBRXp0?=
 =?utf-8?B?TkQvSTVpYThhUld2NUozMU1IYUs4MXVJci94YmJpMXRldUFyNDc3WmV2ZVg4?=
 =?utf-8?B?TkUrVW9QWHg5VFV2YjdrbzlKZVh0d0k5dS9oa2RoRzVkTEIyWk5hcURSYSsw?=
 =?utf-8?B?SmdoYS85VEdqenJVVkdwVkNYbVJJbWJjNkRLYUd0U0xUQXlhUWtXR2thaDUv?=
 =?utf-8?B?UUd3QWdKMW9ub2ZUcTBTQk5IcGl0VUpTWCsrQTZuWHgxN2xRQkZFY281MFdN?=
 =?utf-8?B?TDlMc3JIVWkwUDhaTHAvZUk1ZUo2YkJIOENTRWVST1hzV0lva3dLVTlVMGpS?=
 =?utf-8?B?dFcreXRlcnNKTnhlYVBLUWFIRzJXN09IR2hNOWI2VGt3bWExUnJUWDNOSzFO?=
 =?utf-8?B?Uk1MdmQrSk44WiswZEpucStSMW4rQ0MwOGNwSUh0QWszejJOOUh6cFlLUjl2?=
 =?utf-8?B?dDRJV3JKMU9ka2ZCQnk0VUR6UVViTVVlcXExVFUzS05vVFJOSUFId084M2Nh?=
 =?utf-8?B?YnlWdW5Bb0ozVDdwMm1GZzlYaVpPSERQYWZTNWV4UHhZTC9vYTV1NmkzTXdV?=
 =?utf-8?B?RXpSYzNxVlo4L0crdW94cWRnOGhxZFM1L0VZdysvRTNBQ2IxM2Y4cUpUeEw2?=
 =?utf-8?B?MngwYS9TN00xYUpjcWVtN2Z1NUtlZHdHblppaVRWSjNrbW83U0hQaU1mMENW?=
 =?utf-8?B?OWIzM01uazRieUpKYklJWVFhSjJibk5vNVpEVGNjVXc3eE1RS1o3OUZGZ3dM?=
 =?utf-8?B?RktrdEZLSE9RUzRxbHN3eUR1N3JDNmdnaitHV09Hek4yd09SVEdTS25MQXo1?=
 =?utf-8?B?YzFqdlR6OGVsTGhPcGhlZXVacFI3OG94akFUSmRHS25ZNmpJQnk2NXVMR2xx?=
 =?utf-8?B?ZklrM0JpaU9sVjNNWW9rSVdQNWpvaWZ4cXR1ckYyakNrMnJjTXd4bHdSRFNJ?=
 =?utf-8?B?K3kzbDJ1ZDFPSiswSXFoY21ubG5nU1RocjcvSG9tbVBCMmZNRzJXRExaZStK?=
 =?utf-8?B?YmVTRmFHTnlMdXlWVHRBMVBnM3p3cXhmYjlXOTlwb3FIM2dyRzk1S2pPcVd0?=
 =?utf-8?B?UjVIUmFLUjc4Zk9hc004bVRZR2lxeGd4bUVjMTNJT3dvU0ZzRFNIalBwR0w2?=
 =?utf-8?B?aDdneVlPYzF0eU9OSVJRejB6K291NndyZWZnbk1GY3llc216QmxaYS81Tm1a?=
 =?utf-8?B?NS9yVEI4aTRDTHBCRlRQRDBid253eTUvT1BnNTdSWHc5NVBWaXp2cVpDc2pR?=
 =?utf-8?B?bm52UFp6cU5PT3hFb082aWNscDU5SEIzczFSRU5BYmgrVTVBKys3YzJiOVJq?=
 =?utf-8?B?cGtFVFJ1SllwS2UxbndNMkhGTlhqbUV0eklNckJPNUx4SjhpVytwZFV1TC9I?=
 =?utf-8?B?bWhINU5rMjljVWsvSGcycWViZ2l3cmZURTlPZEVjR1FhQmVFbHNTdk1LdGYy?=
 =?utf-8?B?djRjRVE5bFU1aWFnaHJvSXNKZEpDU0VtVFdxYnovbFBtOXlPNm1ZWU5DQUda?=
 =?utf-8?B?Y2FJQTlSbngyK0V3K0RZaWNXWXdwSVlRb1AwL1BkNjlZUmRGMUV2aVpmb3FS?=
 =?utf-8?B?dkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EBF260FB8A43E84BAC729B5BFEDA863A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6335.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60c2270b-7e6b-4ff4-77ee-08de3652c6b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2025 12:10:28.2240 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KS1CQfSFzhBPr64NnxerUcMO8E3XgJTNU8SPyLFPdFaZAMVGvBcidlAMTRqndM0qvhrydXRNstbDyOn2Ki26QpgKeVUZaWll2ljYcFYzRMs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6141
X-Mailman-Approved-At: Mon, 08 Dec 2025 13:44:18 +0100
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

SGkgTGVvLA0KDQpPbiBUaHUsIDIwMjUtMTItMDQgYXQgMTU6NDUgKzA4MDAsIExlbyBMaWFuZyB3
cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFj
aG1lbnRzIHVubGVzcyB5b3Uga25vdw0KPiB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBIaSBK
YW1pZSwNCj4gDQo+IE9uIFdlZCwgTm92IDE5LCAyMDI1IGF0IDEyOjM4OjQyUE0gKzAwMDAsIEph
bWllIEdpYmJvbnMgd3JvdGU6DQo+ID4gW0VYVEVSTkFMIE1BSUxdDQo+ID4gDQo+ID4gRnJvbTog
Q29ub3IgRG9vbGV5IDxjb25vci5kb29sZXlAbWljcm9jaGlwLmNvbT4NCj4gPiANCj4gPiBQb2xh
ckZpcmUgU29DIG5lZWRzIGEgY3VzdG9tIGltcGxlbWVudGF0aW9uIG9mIHRvcF9vZl9yYW0oKSwg
c28gc3RvcA0KPiA+IHVzaW5nIHRoZSBnZW5lcmljIENQVSAmIGNyZWF0ZSBhIGN1c3RvbSBDUFUg
aW5zdGVhZC4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBDb25vciBEb29sZXkgPGNvbm9yLmRv
b2xleUBtaWNyb2NoaXAuY29tPg0KPiA+IC0tLQ0KPiA+IMKgYXJjaC9yaXNjdi9LY29uZmlnwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMSArDQo+ID4gwqBhcmNo
L3Jpc2N2L2NwdS9tcGZzL0tjb25maWfCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMTYgKysrKysr
KysrKysNCj4gPiDCoGFyY2gvcmlzY3YvY3B1L21wZnMvTWFrZWZpbGXCoMKgwqDCoMKgwqDCoMKg
wqDCoCB8wqAgNiArKysrDQo+ID4gwqBhcmNoL3Jpc2N2L2NwdS9tcGZzL2NwdS5jwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgfCAyMiArKysrKysrKysrKysrKysNCj4gPiDCoGFyY2gvcmlzY3Yv
Y3B1L21wZnMvZHJhbS5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMzgNCj4gPiArKysrKysr
KysrKysrKysrKysrKysrKysrKw0KPiA+IMKgYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9hcmNoLW1w
ZnMvY2xrLmggfMKgIDggKysrKysrDQo+ID4gwqBib2FyZC9taWNyb2NoaXAvbXBmc19nZW5lcmlj
L0tjb25maWfCoMKgIHzCoCA0ICstLQ0KPiA+IMKgNyBmaWxlcyBjaGFuZ2VkLCA5MyBpbnNlcnRp
b25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+IMKgY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvcmlz
Y3YvY3B1L21wZnMvS2NvbmZpZw0KPiA+IMKgY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvcmlzY3Yv
Y3B1L21wZnMvTWFrZWZpbGUNCj4gPiDCoGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL3Jpc2N2L2Nw
dS9tcGZzL2NwdS5jDQo+IA0KPiBUaGUgY3B1LmMgZmlsZSBvbmx5IGNvbnRhaW5zICJjbGVhbnVw
X2JlZm9yZV9saW51eCIgYW5kIHNlZW1zDQo+IGlkZW50aWNhbA0KPiB3aXRoIHRoZSBvbmUgcHJv
dmlkZWQgaW4gYXJjaC9yaXNjdi9jcHUvZ2VuZXJpYy9jcHUuYy4NCj4gDQo+IE90aGVyIHRoYW4g
dGhhdCwgTEdUTS4NCj4gDQo+IElmIHlvdSBkb24ndCBtaW5kLCBJIGNvdWxkIGZpeCB0aGlzIG9u
IG15IHNpZGUgdGhhdCB5b3UgZG9uJ3QgbmVlZCB0bw0KPiByZXNlbmQgdGhlIHBhdGNoc2V0IGFn
YWluLg0KPiANCj4gUmV2aWV3ZWQtYnk6IExlbyBZdS1DaGkgTGlhbmcgPHljbGlhbmdAYW5kZXN0
ZWNoLmNvbT4NCg0KVGhhbmsgeW91IGZvciB5b3VyIHJlc3BvbnNlLCByZXZpZXcgYW5kIGZlZWRi
YWNrLg0KDQpSZWdhcmRpbmcgJ21wZnMvY3B1LmMnLCB5b3UncmUgY29yZWN0IHRoYXQgaXQgaXMg
Y3VycmVudGx5IGlkZW50aWNhbCB0bw0KdGhlIGdlbmVyaWMgaW1wbGVtZW50YXRpb24uIE91ciBp
bnRlbnQgd2FzIHRvIHByb3ZpZGUgYSBwbGFjZWhvbGRlciBmb3INCmFueSBmdXR1cmUgUG9sYXJm
aXJlLXNwZWNpZmljIGxvZ2ljIGFuZCBhbHNvIGFzc3VtZWQgaXQgd2FzIG1hbmRpdG9yeSwNCmJ1
dCBpZiBkdXBsaWNhdGlvbiBpcyB1bm5lY2Nlc3NhcnksIEknbSBoYXBweSBmb3IgeW91IHRvIGFk
anVzdCBhcyB5b3UNCnNlZSBmaXQuDQoNCkluIG90aGVyIHdvcmRzLCBpZiBVLUJvb3QgcHJlZmVy
cyB0byBhdm9pZCBkdXBsaWNhdGlvbiBhbmQgdGhpcyBmaWxlIGlzDQpub3QgbWFuZGF0b3J5IGZv
ciBidWlsZCBvciBhcmNoaXRleHR1cmFsIHJlYXNvbnMgcGVyIENQVSBpbXBsZW1lbnRhdGlvbiwN
CnRoYW4gcGxlYXNlIGdvIGFoZWFkIGFuZCB1c2UgdGhlIGdlbmVyaWMgdmVyc2lvbi4NCg0KVGhh
bmtzLA0KSmFtaWUuDQoNCg==
