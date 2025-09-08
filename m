Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F66BCAC582
	for <u-boot@archiver.kernel.org>; Mon,  8 Sep 2025 07:57:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56260809A5;
	Mon,  8 Sep 2025 09:57:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="myVVczFv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C48A82A9E; Mon,  8 Sep 2025 09:57:08 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20713.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::713])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F075800B6
 for <u-boot@lists.denx.de>; Mon,  8 Sep 2025 09:57:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=t.remmet@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wiaI3ddWYVozh5NzW1DWS4/lsOeWyoGCNWrua2WrvUuGpVWUPhbhfr3n1+TI+tHLpuu7QkUdWrGhMdMQJ6oIv3MhimI+fUygSUVz7MW3zUVXJumlV2v3eNmi3gwYzPVTH25afEzV3PPLPL48AMV0JpEUxb534nL5YSwaqavMjN1VkSJC06pNe0rqaiYJD/PENv7zgd5eYnckNfhPkGTFW4IO9Jd7+vmCY76Oox2vxFVliPQ8UmyPN3r25Xjinv5bW5n6ugBgXbr8KV0KcP1QIGNeUhJMsDor4SYP3qmX3L+zSnPAmK7FksjIzGCTpQIL8leXbvukM0fQ9G+Rjmo5lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fJxHexnauAfRk64Dwa3+oDnYyp8pO7rzEjC8V4pO6dM=;
 b=poWHdr/P8kuo59GKspR9uy5hdZ+8xtvp8oG2gFNHTcFusuSFMKK6MENEEPksmrC0uSUAN3r49ce2PlGX3J4FkXXAMS1U9k9IOMRAaVawQIO82+lA6Myx1O8AWABoGPwTFF1AeV3sowhFAGvab8H85YJNAwOw7azjtiVVZOF6wVnWZd98hpkmeUWAQB/2+HtZKsOrGKGE/5yLBGGTwbeqWnxvTLmn3kd1bL3QDIksE8oLPUwjgFBF+NoeCQTPwFdlnPSAAGAIsO/s+Zaz2rqyckJoszFhABJHar+BS+B6vqb5WUKs1KDaRNECcnMnV7ycePycDkDizxuBFV51vgMuFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fJxHexnauAfRk64Dwa3+oDnYyp8pO7rzEjC8V4pO6dM=;
 b=myVVczFvLWMR0UVXVu2YnIJdgGAxVLPT1dg0Q/pxK+D+9brCoT2/W5UB6SELJL1FwSzPOt35t41+tW8UUdGwAD34q9LhB9872i+W7n5t8aNF0gfFIBxjIhZhUCpG+/vg+BxZW/8/sUx1ppq0CRjqJ2HP1D85BX6H/u4dcMC0Z9ea832Vi94O1yzsJb9E0SAm1Oy18hlAHl6OuAfbVDXPUJqnCI5ujTIntgBDGbOcxnwsaX27N6JvLW4zzD9QImca2C54zKq4P9ieUuFFl7PEJrv/TgX/P+m0zCf2hz0gSUcyOcwkNAVTGQbuJ7A0U+o8k+QLNRyIp82DwVrDeUxn/Q==
Received: from DB9P195MB1228.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:297::14)
 by PAXP195MB1416.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:287::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Mon, 8 Sep
 2025 07:57:04 +0000
Received: from DB9P195MB1228.EURP195.PROD.OUTLOOK.COM
 ([fe80::389e:cc69:1eab:3c56]) by DB9P195MB1228.EURP195.PROD.OUTLOOK.COM
 ([fe80::389e:cc69:1eab:3c56%7]) with mapi id 15.20.9094.018; Mon, 8 Sep 2025
 07:57:04 +0000
From: Teresa Remmet <t.remmet@phytec.de>
To: "festevam@gmail.com" <festevam@gmail.com>, "trini@konsulko.com"
 <trini@konsulko.com>, Yannic Moog <y.moog@phytec.de>
CC: "upstream@lists.phytec.de" <upstream@lists.phytec.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Jan Remmet
 <j.remmet@phytec.de>, Benjamin Hahn <b.hahn@phytec.de>, Yashwanth Varakala
 <y.varakala@phytec.de>
Subject: Re: [PATCH v3 1/3] phytec-imx8m boards: enable OP-TEE for KASLR
Thread-Topic: [PATCH v3 1/3] phytec-imx8m boards: enable OP-TEE for KASLR
Thread-Index: AQHcIIqb7pCuum/86EKhdPdK6lZZj7SI6z6A
Date: Mon, 8 Sep 2025 07:57:04 +0000
Message-ID: <45c5e4e6da7a193ba464d471a9af5b79e78adb39.camel@phytec.de>
References: <20250908-imx8m-optee-enable-v3-0-14bfe249b3c6@phytec.de>
 <20250908-imx8m-optee-enable-v3-1-14bfe249b3c6@phytec.de>
In-Reply-To: <20250908-imx8m-optee-enable-v3-1-14bfe249b3c6@phytec.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9P195MB1228:EE_|PAXP195MB1416:EE_
x-ms-office365-filtering-correlation-id: 0008948a-3cc1-47c0-8260-08ddeead4cd1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UlM5NzFsOEFtekpNR3NoQ0w3dlhMcFNHU3BGeGt6UDcwanpFYXZZNUtrd1hR?=
 =?utf-8?B?TE5sbVNXenFEQ1A4ZjJ5aHM0WjBCSFZVUlJBcmplWVpjamFtNHk0QUtzd1dY?=
 =?utf-8?B?bGsyUDNzZ0pCRjJTVHJLVDhZS0JtYUJIUnR6a2szbElaS1JJL1BKWlVuejJK?=
 =?utf-8?B?dW1adVI4dEFqLzNxR01LUjJ3SHRXWkJTNTF1ODZTUTJwajVZZE5FY1R6RU9s?=
 =?utf-8?B?RGp0bnZyaFBtdkc0S25NbVM2SW9JSUlNdXhraXB4QXhCR0dQYzVnMkh5TS9z?=
 =?utf-8?B?c3EycU9IQktuYjZXMFdwVmZqTjhQS1duNU9HWW51SjRQWGVGZ0Y4WlovRm1Q?=
 =?utf-8?B?OE5NekdRZTJ2dDN0emlQWEhGbC9OQ2NLQzYyWkt0bzJQYzBhUWdVMVpzbmtU?=
 =?utf-8?B?K3NCcjFHb1Z6Ykw5bDR1OXFWaWtHSnJqQThORmZXL2NDYmREYjdDRG5IWmV4?=
 =?utf-8?B?Ukl6YU85N2lCTFo3MVRMYmJlUXZBRjU1RWR1S0JoRThUL2xZaGYvelg4bjJy?=
 =?utf-8?B?VVZFSmVzc2ptd2tpellnQ0I2SXNWdHpZVlBjZmV3UDZSNjFmcW5rYThWeDJB?=
 =?utf-8?B?cUNNTVE5T29ZbUpzREk2K3UrV2RyVjJ4V0dkbks4ckdrVitMeEd4UDZQeEJB?=
 =?utf-8?B?TVMrbk40UU9rSEFYTnJmSFluVkJwWjQ0ZG1EWm5vSXpkTHVLZitZUEltTEx5?=
 =?utf-8?B?SGwrUnlwcFhqM2Q3azBWaFRFeWtUVGEzWjAvV1NtSDYrUldWQzBobkMwKzhZ?=
 =?utf-8?B?UUc1L2swNjdaTGk3SlIyMm5DTGlJTjhCR0xpeml2aCtZSHVOekhjMEpiREI5?=
 =?utf-8?B?UkpzZDc2QXUvbndyNDljeDNUeDg2WUI2d0RVSFFPdlo3SUk1RHhRYVZ1eWpH?=
 =?utf-8?B?UzFSWHJldEpuRHhLK0ZjaFBQbFd1aURkVHJtU2dxYmZyQS9JTkpFMXdNMmxx?=
 =?utf-8?B?dHlZamhSYTNNRzFhZTZocmh6YWRkOVo2VGtpaDNuU3JiRVA3OURKUVlzSXBK?=
 =?utf-8?B?cWRibXJTSkV1SGNqVmhaa3l2SzNSVkgzM1VyeGd0YllFT3NkQkpqNVdRR05G?=
 =?utf-8?B?VTRMaEJmY2poOHEvZkEyV1FQOEhqNmR3VUVqSDBJclloV050WTIyR3VyVGh5?=
 =?utf-8?B?bVpYODBvRVYvNnVLQ3VWanJTUExtcW84REwxcWluRzhjejlGR3NTSHRwTGk0?=
 =?utf-8?B?cUUzYU5idm9JWFB0SDRzSFFIOTJFR3NNa29qVHRsN0UvRGY3eXpIQXo4bXV5?=
 =?utf-8?B?SHo5dEJ3Wi9RVUtYYXFjMm11ZTRLM3RNcDVCWk56L1JDQTJSQnNzalhNbFJz?=
 =?utf-8?B?ekJQaUVrcTNwM3gxRUZGdzFwdnJzeUVtK3plei96a2loV3RUdWtKdzFXSzQx?=
 =?utf-8?B?bGZhMkgxdStIcWticVROWFBCWGZLTHY3aTZOQU42L21ZdW1KV0hvWWYzNXRM?=
 =?utf-8?B?Mk1JdjROV29jZll5Yy8yQ3lyTWpCY1pyWHkzTDBGaVJYa29qWm5aTlJYb2xy?=
 =?utf-8?B?K3lyRml5czFrTnE0NDlDNjl3VlJ2dEVRTGphNlk5c1F5L01JNE4wcmVEN0Yw?=
 =?utf-8?B?dkJNUjJaN3QyZmJnZ1dKSVFxcFQ5bURadWNuclNMQXNQcTY2L01PdzlZVm1L?=
 =?utf-8?B?MWhsTW5zM1lpM2VpT08zS0ZNU2k4NFlFZ2hyNWh4YmgycmphbDdCVFRBVG1p?=
 =?utf-8?B?ckQrcUVNSStTdEFjekJMOUVRMXZ4cmg4aWllMTkyK1NxdEg3b3FZMlB0Tyt0?=
 =?utf-8?B?bVBXZTRRQWF2YUhkTUt1RjhRRGs3SUJOcnZzdy9TTm0zdTlsOTZ2aHNNZWUx?=
 =?utf-8?B?OGJKZ2RKRStCbVpvb3djVGhPVDRibzJlY1d6T2NoMlI1QnlWRUllUmo5TmZ1?=
 =?utf-8?B?Z0kybWE5U0lMOHpQVXo4TWVDUE9rdW4wLzhUSkpDN1pNTFFJL2JvY3JwalMr?=
 =?utf-8?B?eGVXYU5iYkZKMGNZbVJBdzJjVmhDVFBYaEJxMDYyVUVGcWQ4LzFVcEZMQXpq?=
 =?utf-8?B?QVkyc2dZSXBRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9P195MB1228.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZzhoN1RHcmVzcXlLNWk2bER4TmpzS1haTGFWWjRTM3dOS2ZLSFFuekZQMkpk?=
 =?utf-8?B?NFRWL0VmaW5vREtZVUdadUxWZlRHQnNKNDUrUlBRWkdJanlCeU9icUFsbUJr?=
 =?utf-8?B?YVpDQzhZSnE0T3UwcjZ0ZytsQ1hON3g4bGpVS3RCR0hlb0V2OHFvZGo1OVpH?=
 =?utf-8?B?YVRQUmo1Tk9HbGhieXZMbFQwME9zNGZObXRFMXRrTE5yK2pmak5ndDBGdGRk?=
 =?utf-8?B?OXZZSFY0aVg0Y0k2U0p5Z2tVbFN6ZzZCWkpsQ2FqeTUzekpMakNmbytsR21s?=
 =?utf-8?B?ZmJMT2ptR3MxeG9WeGFxYzZ0cEJEcFIyQjVxTTIwNGtnUjF4eHBLRlNwM0or?=
 =?utf-8?B?aHVYbjlXaVRycUowZ2s5eXREeE9YVWZvK0E4d3RmM0dVcTNlSEkrNFFiNXZS?=
 =?utf-8?B?SXdlKzR2TUNtb3Q1VEk4elRXUjZnUGtTYklWcitpZXJTZElTZ2wreE5aczBl?=
 =?utf-8?B?MFhRNWVBV0lkQndhV0ZnekxFTWcra2F4Wi95WXpkeFp0NVEydU1vQTgySDBl?=
 =?utf-8?B?NVFwTWhxODJTWElrNVhUK3lBa3hGZzVjNFFmMmtFMUxmWXFiV1BaZnZJb20x?=
 =?utf-8?B?aTV1TGNPdGxTWXdlR1FKdzExdnczZmkxTmpFMGpoU2hkWW5aUFVqa2Y4UE94?=
 =?utf-8?B?cmdkOGdjc1RuNk84STB0eU1JL3VidVF5V0FlYysxOGZ6dytoWmJ6d2YwMWlL?=
 =?utf-8?B?SEp4LzVTN0RpV1VGd2ZrZnRBeG15YVduM1VTbHpxeWhiUnhzVXpBOFA2L2ZV?=
 =?utf-8?B?YUo1V1RHTXAvREFxZkRwMnAzVmJuYURjNHBpOGx3TUZUais2a3FHTWpaeHIv?=
 =?utf-8?B?SlJXSTJwTGx3R2NuMy8vdVVqcWN5ZU5Cam9vSkdZYk1STmJHZWs3VmExOThV?=
 =?utf-8?B?RDFEWG9QUjNHWUhiNERROHU2SXRaRHp6VWd1OUcreXRncnNCNFdmSGFYUjk2?=
 =?utf-8?B?WHQzalZITWJFd1ZXODZsN0p0ZjlsbmZodFZ2dDN5eXpUTVV2eXU0U21PbWZN?=
 =?utf-8?B?R3ZvTzRXeWJjZ3J5Z0lxSlRDNTY5UzgvenF1VTE3NitFclRJMElsYjBORENj?=
 =?utf-8?B?akxodHMxNDdYbVF0RFB2dWhNczRMZjNxdXZFeldEWWs3L0REL2UzYSt6Z2o1?=
 =?utf-8?B?ak02TitzbWFJK21KMkxLakpDOGw0V240NkhkYjBaUVBIS3BieTRvbnpQU29K?=
 =?utf-8?B?dSs3Z0x2aUV1azgwMlZSS3NDNGNHWk4yRnpyQ01qbXlZU2ZnWTRPdUxYUHRE?=
 =?utf-8?B?dUNkdmlweVNMaVZNditYVE5lUDJqUk9tK0szMlFnNGZMWG1TT1NLdEFIQ09L?=
 =?utf-8?B?TDM2SThWbVFteWRYYWcxOGd6YzhOSmhJa0JuaXZ1b2E5aHVuVDUycjRneUND?=
 =?utf-8?B?QTN3TGs0UGxKcGdIT0hCVTlnZmtwZ3ZaUUxDaHdVckZiTkx3TFZFeE1uSjAw?=
 =?utf-8?B?RmZtajh6dnVYRDNvWUI0T2k4V3hNSkJMTVBjSDFpTkhqQm0vWERaRVdVRG9X?=
 =?utf-8?B?dVhoaEl4dENtQkxHZGFwNWdHeXhqVTExQi9RMnduemFGdmF2Nzl0NXFmTzVy?=
 =?utf-8?B?L1V2ZXI3bGhxTzdUa3o4bXNMS1RiUk9kTVVOd2pTTHJHanhpaVBxaEhJWG1v?=
 =?utf-8?B?bVZzam14b2hScmN3TzFrdGxuMFhjVzY4MHNtdDhqOFc4S0xiV1FqNDlzaWxZ?=
 =?utf-8?B?NWdQYUF2UjV1N1dxUStWaElmd1FBYWQ1VjJzQVg2aFJQZnFhM2lnbDFwNzdu?=
 =?utf-8?B?aVM2YzdQRlcrNDlQcmxvWGQrZUdLdnZ6WGVhREZOVUZaTXY5L0pUOVFQOXhO?=
 =?utf-8?B?ckVOR1VDUjQ4S3gxNVVvUXJyUGJYS0xKWUI3YXlNU21wRGpGRk9EVGF3dHkz?=
 =?utf-8?B?cmg0dytCQ2lmSDd1cFJkNnpYUDZuZll4b3pPQnlyTmJLQVBxbW43a2graW9V?=
 =?utf-8?B?NW14cHlYbEdPdC8vTThNOFJOcHFzY2haS3hGMjhsMzBVQ2VyTFB3dHY0RUZF?=
 =?utf-8?B?cEFFOU9oOFEzV1pFNHlMZWVBNzgzQzdhZHRTQ0MvYnlJcjJaRzFpdDdia0tC?=
 =?utf-8?B?WENGVDEybnJVWjM1ZUpMYnJna3c1R0FkZWd5bnh0VVF2LzZyZjI0N2tvUDd3?=
 =?utf-8?Q?uf2rOA3dVTSsteD5RclBNaO93?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <57F0772A0A01294CA063BCDA9FB7221A@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9P195MB1228.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0008948a-3cc1-47c0-8260-08ddeead4cd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2025 07:57:04.1992 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YlVgIa1otyxVfMBlK9VSyhdnrtsSxxTuDQIGunAvaoW8sxBzMDzSzfxQmAfZo9JAwgYfqFcvclgzAxuMqC930w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP195MB1416
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

QW0gTW9udGFnLCBkZW0gMDguMDkuMjAyNSB1bSAwODozMyArMDIwMCBzY2hyaWViIFlhbm5pYyBN
b29nOg0KPiBFbmFibGUgT1AtVEVFIGNvbmZpZyBhbmQgUk5HIGJ5IGRlZmF1bHQuDQo+IFNldCBP
UC1URUUgbG9hZCBhZGRyZXNzIHRvIGVuZCBvZiAxR2lCIFJBTSBmb3IgcGh5Y29yZS1pbXg4bXAg
YW5kDQo+IHBoeWNvcmUtaW14OG1tIGFzIHRoZSBib2FyZHMgc3VwcG9ydCBhIDFHaUIgUkFNIHZh
cmlhbnQgKGFsdGhvdWdoIG5vdA0KPiB5ZXQgdXBzdHJlYW1lZCBmb3IgcGh5Y29yZS1pbXg4bW0p
Lg0KPiBUaGUgaW14OG1tLXBoeWdhdGUtdGF1cmktbCBib2FyZCBvbmx5IHN1cHBvcnRzIDJHaUIs
IHNvIHRoZSBkZWZhdWx0DQo+IGF0DQo+IHRoZSBlbmQgb2YgMkdpQiBpcyBzdWZmaWNpZW50Lg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogWWFubmljIE1vb2cgPHkubW9vZ0BwaHl0ZWMuZGU+DQpSZXZp
ZXdlZC1ieTogVGVyZXNhIFJlbW1ldCA8dC5yZW1tZXRAcGh5dGVjLmRlPg0KDQo+IC0tLQ0KPiDC
oGNvbmZpZ3MvaW14OG1tLXBoeWdhdGUtdGF1cmktbF9kZWZjb25maWcgfCA1ICsrKystDQo+IMKg
Y29uZmlncy9waHljb3JlLWlteDhtbV9kZWZjb25maWfCoMKgwqDCoMKgwqDCoMKgIHwgNSArKysr
LQ0KPiDCoGNvbmZpZ3MvcGh5Y29yZS1pbXg4bXBfZGVmY29uZmlnwqDCoMKgwqDCoMKgwqDCoCB8
IDQgKysrKw0KPiDCoDMgZmlsZXMgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlv
bnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9jb25maWdzL2lteDhtbS1waHlnYXRlLXRhdXJpLWxf
ZGVmY29uZmlnDQo+IGIvY29uZmlncy9pbXg4bW0tcGh5Z2F0ZS10YXVyaS1sX2RlZmNvbmZpZw0K
PiBpbmRleA0KPiA3MzY5YzBhMDVhYzk4MzE1NjgyMTI3ZjBlOTZhZjdkMzZjNDc2M2QyLi42ZGM5
NWQ2ZDNlZGJjMGI0ZWQyNWE2NmQyM2YNCj4gMWI2NTQzNWUwMTY5NyAxMDA2NDQNCj4gLS0tIGEv
Y29uZmlncy9pbXg4bW0tcGh5Z2F0ZS10YXVyaS1sX2RlZmNvbmZpZw0KPiArKysgYi9jb25maWdz
L2lteDhtbS1waHlnYXRlLXRhdXJpLWxfZGVmY29uZmlnDQo+IEBAIC03Myw5ICs3Myw5IEBAIENP
TkZJR19TUExfQ0xLX0NPTVBPU0lURV9DQ0Y9eQ0KPiDCoENPTkZJR19DTEtfQ09NUE9TSVRFX0ND
Rj15DQo+IMKgQ09ORklHX1NQTF9DTEtfSU1YOE1NPXkNCj4gwqBDT05GSUdfQ0xLX0lNWDhNTT15
DQo+ICtDT05GSUdfRlNMX0NBQU09eQ0KPiDCoENPTkZJR19NWENfR1BJTz15DQo+IMKgQ09ORklH
X0RNX0kyQz15DQo+IC1DT05GSUdfTUlTQz15DQo+IMKgQ09ORklHX0kyQ19FRVBST009eQ0KPiDC
oENPTkZJR19TWVNfSTJDX0VFUFJPTV9BRERSPTB4NTENCj4gwqBDT05GSUdfU1VQUE9SVF9FTU1D
X0JPT1Q9eQ0KPiBAQCAtOTcsMTEgKzk3LDE0IEBAIENPTkZJR19JTVg4TV9QT1dFUl9ET01BSU49
eQ0KPiDCoENPTkZJR19ETV9SRUdVTEFUT1I9eQ0KPiDCoENPTkZJR19ETV9SRUdVTEFUT1JfRklY
RUQ9eQ0KPiDCoENPTkZJR19ETV9SRUdVTEFUT1JfR1BJTz15DQo+ICtDT05GSUdfRE1fUk5HPXkN
Cj4gwqBDT05GSUdfRE1fU0VSSUFMPXkNCj4gwqBDT05GSUdfTVhDX1VBUlQ9eQ0KPiDCoENPTkZJ
R19TWVNSRVNFVD15DQo+IMKgQ09ORklHX1NQTF9TWVNSRVNFVD15DQo+IMKgQ09ORklHX1NZU1JF
U0VUX1BTQ0k9eQ0KPiDCoENPTkZJR19TWVNSRVNFVF9XQVRDSERPRz15DQo+ICtDT05GSUdfVEVF
PXkNCj4gK0NPTkZJR19PUFRFRT15DQo+IMKgQ09ORklHX0RNX1RIRVJNQUw9eQ0KPiDCoENPTkZJ
R19JTVhfV0FUQ0hET0c9eQ0KPiBkaWZmIC0tZ2l0IGEvY29uZmlncy9waHljb3JlLWlteDhtbV9k
ZWZjb25maWcgYi9jb25maWdzL3BoeWNvcmUtDQo+IGlteDhtbV9kZWZjb25maWcNCj4gaW5kZXgN
Cj4gNGQ2YmNlMjZmMDdmN2I5MGU3YzM2NzRmNGI5ZGRjYWM4ZDc3NWUxZC4uNGNmNGQzOTcyNTY3
YmNmNzdkOWVlN2UyZmRhDQo+IDcwNzA3MGE3NzhjNzIgMTAwNjQ0DQo+IC0tLSBhL2NvbmZpZ3Mv
cGh5Y29yZS1pbXg4bW1fZGVmY29uZmlnDQo+ICsrKyBiL2NvbmZpZ3MvcGh5Y29yZS1pbXg4bW1f
ZGVmY29uZmlnDQo+IEBAIC04Miw5ICs4Miw5IEBAIENPTkZJR19TUExfQ0xLX0NPTVBPU0lURV9D
Q0Y9eQ0KPiDCoENPTkZJR19DTEtfQ09NUE9TSVRFX0NDRj15DQo+IMKgQ09ORklHX1NQTF9DTEtf
SU1YOE1NPXkNCj4gwqBDT05GSUdfQ0xLX0lNWDhNTT15DQo+ICtDT05GSUdfRlNMX0NBQU09eQ0K
PiDCoENPTkZJR19NWENfR1BJTz15DQo+IMKgQ09ORklHX0RNX0kyQz15DQo+IC1DT05GSUdfTUlT
Qz15DQo+IMKgQ09ORklHX0kyQ19FRVBST009eQ0KPiDCoENPTkZJR19TWVNfSTJDX0VFUFJPTV9B
RERSPTB4NTENCj4gwqBDT05GSUdfU1VQUE9SVF9FTU1DX0JPT1Q9eQ0KPiBAQCAtMTIwLDYgKzEy
MCw3IEBAIENPTkZJR19QT1dFUl9ET01BSU49eQ0KPiDCoENPTkZJR19JTVg4TV9QT1dFUl9ET01B
SU49eQ0KPiDCoENPTkZJR19ETV9SRUdVTEFUT1JfRklYRUQ9eQ0KPiDCoENPTkZJR19ETV9SRUdV
TEFUT1JfR1BJTz15DQo+ICtDT05GSUdfRE1fUk5HPXkNCj4gwqBDT05GSUdfRE1fU0VSSUFMPXkN
Cj4gwqBDT05GSUdfTVhDX1VBUlQ9eQ0KPiDCoENPTkZJR19TUEk9eQ0KPiBAQCAtMTI5LDUgKzEz
MCw3IEBAIENPTkZJR19TWVNSRVNFVD15DQo+IMKgQ09ORklHX1NQTF9TWVNSRVNFVD15DQo+IMKg
Q09ORklHX1NZU1JFU0VUX1BTQ0k9eQ0KPiDCoENPTkZJR19TWVNSRVNFVF9XQVRDSERPRz15DQo+
ICtDT05GSUdfVEVFPXkNCj4gK0NPTkZJR19PUFRFRT15DQo+IMKgQ09ORklHX0RNX1RIRVJNQUw9
eQ0KPiDCoENPTkZJR19JTVhfV0FUQ0hET0c9eQ0KPiBkaWZmIC0tZ2l0IGEvY29uZmlncy9waHlj
b3JlLWlteDhtcF9kZWZjb25maWcgYi9jb25maWdzL3BoeWNvcmUtDQo+IGlteDhtcF9kZWZjb25m
aWcNCj4gaW5kZXgNCj4gNmJkOGJjZjE1ZGFhOTU5NjZhYTk3M2Q4YTQ5M2ViYzFmMDViMTRlOS4u
YzQ5N2YwYmNkOTEzMWFiYWIwYjc1MWVjOWNjDQo+IDgxMTk0NDA1YjFmMTkgMTAwNjQ0DQo+IC0t
LSBhL2NvbmZpZ3MvcGh5Y29yZS1pbXg4bXBfZGVmY29uZmlnDQo+ICsrKyBiL2NvbmZpZ3MvcGh5
Y29yZS1pbXg4bXBfZGVmY29uZmlnDQo+IEBAIC0xMyw2ICsxMyw3IEBAIENPTkZJR19FTlZfU0VD
VF9TSVpFPTB4MTAwMDANCj4gwqBDT05GSUdfU1lTX0kyQ19NWENfSTJDMT15DQo+IMKgQ09ORklH
X0RNX0dQSU89eQ0KPiDCoENPTkZJR19ERUZBVUxUX0RFVklDRV9UUkVFPSJmcmVlc2NhbGUvaW14
OG1wLXBoeWJvYXJkLXBvbGx1eC1yZGsiDQo+ICtDT05GSUdfSU1YOE1fT1BURUVfTE9BRF9BRERS
PTB4N2UwMDAwMDANCj4gwqBDT05GSUdfVEFSR0VUX1BIWUNPUkVfSU1YOE1QPXkNCj4gwqBDT05G
SUdfT0ZfTElCRkRUX09WRVJMQVk9eQ0KPiDCoENPTkZJR19TWVNfTU9OSVRPUl9MRU49NTI0Mjg4
DQo+IEBAIC0xNTMsNiArMTU0LDcgQEAgQ09ORklHX0RNX1JFR1VMQVRPUj15DQo+IMKgQ09ORklH
X0RNX1JFR1VMQVRPUl9GSVhFRD15DQo+IMKgQ09ORklHX0RNX1JFR1VMQVRPUl9HUElPPXkNCj4g
wqBDT05GSUdfU1BMX1BPV0VSX0kyQz15DQo+ICtDT05GSUdfRE1fUk5HPXkNCj4gwqBDT05GSUdf
RE1fU0VSSUFMPXkNCj4gwqBDT05GSUdfTVhDX1VBUlQ9eQ0KPiDCoENPTkZJR19TUEk9eQ0KPiBA
QCAtMTYyLDYgKzE2NCw4IEBAIENPTkZJR19TWVNSRVNFVD15DQo+IMKgQ09ORklHX1NQTF9TWVNS
RVNFVD15DQo+IMKgQ09ORklHX1NZU1JFU0VUX1BTQ0k9eQ0KPiDCoENPTkZJR19TWVNSRVNFVF9X
QVRDSERPRz15DQo+ICtDT05GSUdfVEVFPXkNCj4gK0NPTkZJR19PUFRFRT15DQo+IMKgQ09ORklH
X0RNX1RIRVJNQUw9eQ0KPiDCoENPTkZJR19VU0I9eQ0KPiDCoENPTkZJR19ETV9VU0JfR0FER0VU
PXkNCj4gDQoNCi0tIA0KUEhZVEVDIE1lc3N0ZWNobmlrIEdtYkggfCBCYXJjZWxvbmEtQWxsZWUg
MSB8IDU1MTI5IE1haW56LCBHZXJtYW55DQoNCkdlc2Now6RmdHNmw7xocmVyOiBEaXBsLi1Jbmcu
IE1pY2hhZWwgTWl0ZXpraSwgRGlwbC4tSW5nLiBCb2RvIEh1YmVyLA0KRGlwbC4tSW5nLiAoRkgp
IE1hcmt1cyBMaWNrZXMgfCBIYW5kZWxzcmVnaXN0ZXIgTWFpbnogSFJCIDQ2NTYgfA0KRmluYW56
YW10IE1haW56IHwgU3QuTnIuIDI2LzY2NS8wMDYwOCwgREUgMTQ5MDU5ODU1DQo=
