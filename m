Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7955ECA0FED
	for <u-boot@archiver.kernel.org>; Fri,  5 Sep 2025 13:12:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C666183390;
	Fri,  5 Sep 2025 15:12:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="L5IYFjTc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5A4583622; Fri,  5 Sep 2025 15:12:18 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20728.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::728])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA17B83335
 for <u-boot@lists.denx.de>; Fri,  5 Sep 2025 15:12:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=t.remmet@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=maTL6XtNJiGDkIWhGQnrSB4TNzu6CTp1na1uJMD7jWFT2ANI0vTRFfqZZljXpGSt0w3tVKeV0c/QuPJCcSl5VmGQ6hwgmeDNytFmmvK1sbFcLafbW2psUL8sxZKXrEfZLW+kNIsYL5jTCYtEDbQeYxfR2NGbr6BKwnhnQejFx7zjeaNxZyFpOHa1dMHILY5C4u4Xz8g4i6zfNoK/Vl3thYtBQAa/MGfHMhIqE1mXOWgJL2J2KHUP5lY0X3ZpSge9l5sItvQQyoT4BwDwYI7HXmAVyz1JXsvpRu8BLN8pRNXK01vx5zxF0bpTs12jUksWzLU+EHvrgEbg0HnUsCUOMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=emKIk8zEK7f8NELwYINV4Q0jRZrh36WCDWdR8HNILEM=;
 b=x+pm33R4UQ2lhNQU3LtrXdmCq7xGEn+XM8yd04aBYGN2D+q2V+GYFK6mtf9zeS/TEGRj8R4Lp8uA+EXy+cZ/3jxlDUTlqTpwzmVLsCqmG9D04MjcBDMPUQhrx4cHMVjjjjoTEfWj3aCsh5k/o+mzeXAfAFWxSAT3W4+x+rNdvtYllw3YlRmVWMWfi6xg6FHspims1sr55lqbLsl/bEAZn5lz9VOtDUYXsj/7vZJ7hVwEj1g0nB077FW9tdepiLVo0jYp6iZ9H+eatJhAQFEULNFH35ssWK9M17JfgQ4Oh0CvTNHZaAQIyu6Hy5gD5Nro6Do3iv+9MbGM6jOCVYk5/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=emKIk8zEK7f8NELwYINV4Q0jRZrh36WCDWdR8HNILEM=;
 b=L5IYFjTc3f/DWTYwObpTsnFA0MJIGvDgN/Kh0fu2xq68zxVyXYsvMSqw9fFsR3/qEr7LmR0hHr3TGB72cjbjMHrDcZtxhWnXse1+u/1+WkD3sRkFDTAGLK6WnDGPYuKrX+JybO/chyf4h5dLgwYt/ILzwO/nosd4LXY8qVkjtdr7Bcyul317CibZD1jFzvY2xQsH9e+8Xzw4oSU0MluUEV+rj2mpWILVSzPpL6JIH1qItceXAptEBEis6X+h2iJB6CVum4UuwsznGK8KW01t0VrNkXbqFlHWTvoRyNTPGKcRlt7RY/4FesTZy+GnQhZxSwj0zM1BcXckbyqhoBUSzQ==
Received: from DB9P195MB1228.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:297::14)
 by AS1P195MB1448.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4a6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Fri, 5 Sep
 2025 13:12:14 +0000
Received: from DB9P195MB1228.EURP195.PROD.OUTLOOK.COM
 ([fe80::389e:cc69:1eab:3c56]) by DB9P195MB1228.EURP195.PROD.OUTLOOK.COM
 ([fe80::389e:cc69:1eab:3c56%7]) with mapi id 15.20.9094.017; Fri, 5 Sep 2025
 13:12:14 +0000
From: Teresa Remmet <t.remmet@phytec.de>
To: "festevam@gmail.com" <festevam@gmail.com>
CC: "upstream@lists.phytec.de" <upstream@lists.phytec.de>,
 "trini@konsulko.com" <trini@konsulko.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, Yannic Moog <Y.Moog@phytec.de>, Benjamin Hahn
 <B.Hahn@phytec.de>, Yashwanth Varakala <Y.Varakala@phytec.de>, Jan Remmet
 <J.Remmet@phytec.de>
Subject: Re: [PATCH v2 1/2] phytec-imx8m boards: enable OP-TEE for KASLR
Thread-Topic: [PATCH v2 1/2] phytec-imx8m boards: enable OP-TEE for KASLR
Thread-Index: AQHcDRQvTLEg4+C37kmFUapgfWcrl7R/mOMAgAMemoCAAfHogIAAAaGAgAAINIA=
Date: Fri, 5 Sep 2025 13:12:14 +0000
Message-ID: <edaefa01a6a871f7e43d806883a61b63a3370a1c.camel@phytec.de>
References: <20250814-imx8m-optee-enable-v2-0-c489d795ae07@phytec.de>
 <20250814-imx8m-optee-enable-v2-1-c489d795ae07@phytec.de>
 <7e21749ea852683f04ad4656fbdd8e60d26d93b9.camel@phytec.de>
 <d7985ba438722fea1c921372b42a3fe0bd073d06.camel@phytec.de>
 <773f80902471cf12d4f2247b4b468b1024817a93.camel@phytec.de>
 <CAOMZO5Au4Qh1Q-5nkqfoPpGy2hs1=XX2xQ_chVHOcWxxSdTPrA@mail.gmail.com>
In-Reply-To: <CAOMZO5Au4Qh1Q-5nkqfoPpGy2hs1=XX2xQ_chVHOcWxxSdTPrA@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9P195MB1228:EE_|AS1P195MB1448:EE_
x-ms-office365-filtering-correlation-id: 2bb9e6a2-5b94-49a6-99c6-08ddec7dd4f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?S2V1dlBsYnp4L1dObXJTbVlQa1FVWEFxZFpnUGRaQkFDRmxHSS93TDZzb0kv?=
 =?utf-8?B?MTA2QmFaNzRKbDd4K1gwdkdqMTJCRmR1NkU0VTZVeVlhdVhGLzZtRUpYeUVV?=
 =?utf-8?B?YXozRThQWTU4VzJlamNTaEMrcjY1MDFDMUJjSzZ1eDJqd1hWbXdDcWlvWStr?=
 =?utf-8?B?RmFiWHZyd3JsRC9NSklKMVBKem12ZWh1aVB1N2VBam53ejVMSWc5WXFjTnhq?=
 =?utf-8?B?MHRkYXROSUdrcHRvZUdGN1NwZ242UmZtdHZOQkNad05FamYvTk55SVk2OGJB?=
 =?utf-8?B?N2ZiOG9oY1NXSWVWWFZnRHVaUnkxdHVOQXhQby9SVUtuSEhuYzIwb3FUdUsr?=
 =?utf-8?B?YkVHeFhhNTlrejZVeTNRb09ueTNQQWcwUnF1NS8rSlNmODRZdDhoYlFodVhG?=
 =?utf-8?B?bkpFczBJVGlRK3dTZ08xLzdRdTRtRXVJZmd5VDllTHZscUtUOFhsd1drQXdV?=
 =?utf-8?B?VDU2VWdEdjU0RTVHaDJDZGw5VVFEamtCaVdwcm1UaVFPODRlaCtWNVpETUpV?=
 =?utf-8?B?ZWZnTGFoWW5Dd1d4TGJYLzZEeEpWb1V2Z0NNcUtTMzVtQ1loYzFlemduS1hs?=
 =?utf-8?B?NUlnUEpIMmNLdWwxaDdpNW1xaGFEZmk4ZXQzODMxN0pJZmJLMGVTN0NzRmdl?=
 =?utf-8?B?OWFCbzhvN3d6eEF3TyswS2FMeWwzTEFoVlorVU9ub0NneVJtUXVVNGdudFo4?=
 =?utf-8?B?Ym04RDJSd25Kc3FvZGpGaGVGZ2Uvd0F0OHdJc2RZOEJGTzNLWVV6V0puNkt1?=
 =?utf-8?B?elVKMzdIYVBQOEdXM2ZTQ0pwYWFTOExmMzd5RVdpeVhPQzBwdnJ1ZFFJN2Fq?=
 =?utf-8?B?WG5BWU5ycUlYMDVYZ2J6RkVuTnFWSk1NVUxRMWJuaWh0UHZ1SGYrczFSeEgz?=
 =?utf-8?B?ckc3RXpmcXR4aEdLaC9abTB6OHYrc2p6SzhsL28wbVc4NDlHTHR0bFVqbmpQ?=
 =?utf-8?B?L2xKdXM4Q0tsSmZMVksyQTdhUTlWb0k3cktvb2R1cU9VZnhFd1lIZ0VjT1Ax?=
 =?utf-8?B?aEZQYmFJUnFXa09CcXJ4dWxJeHM2Q3ZpUUU2TnVTN3hpOHJCQVkyTHdndGlK?=
 =?utf-8?B?WVJlWE1RbW1pWnBBWFJpY3ZwN3F4ekRCbHdTQUJrSVZLWjJLYVpRSEJMR2Zj?=
 =?utf-8?B?YVNxT0tnbzNEbGgzTXdXTERzQ0F1aWtCVzU0WEpuNWZSamNhWG5nUzZBSGQ3?=
 =?utf-8?B?aVlyZ1I5cFFwdC8vVVZrVDYycjR4OG5sZmsxM2xsRU5jbmxGV0JhU3VVZlZD?=
 =?utf-8?B?ZndKbHJNZmtpR29xSHhiUFJhVVI5ajc0eFlRYmhUZG5TZ0JFS3A4d3FFc3c3?=
 =?utf-8?B?VGJyN1I5K1lLTjFxRGJNOEV3TjZPb3BxZXVDa0d6bjRmSnQzWUdPbVhLMTR6?=
 =?utf-8?B?TGxEKzlBcy9STEtDa0tHN2JFSUJGQ0laQ2g2bDQ1TEhOMTIwMG55S2VqS0Ew?=
 =?utf-8?B?QSttZ0thOEI0aGJhWktYWFVadnVTaUhHMCsxall0MWg4V1VFQWFZTzZGN2xT?=
 =?utf-8?B?N29TN0VPWVVMUGVRN003S3cwZkR5Zyt1TGRuSURqdHFtdmhOMC8yRk04UGN6?=
 =?utf-8?B?aWxrdXZwNm9JN1ZvY05RMUx3aGZCZW95NDNWMnlxUER0ZU9SN1J2dUJYUXUz?=
 =?utf-8?B?eFdoQ2ZpVlRsbEdqQ3E2akNpTjBzNkRpVmxzdlhxZTltT1c4aXlxcVh1ckpR?=
 =?utf-8?B?NEsweG13bDYrNi85TkhOV0VkaTlMTFNzWTB2VlYzTHJFQjdobXoxM3NnbXNi?=
 =?utf-8?B?Vy9RQU1TVVZyN1A5S2tRbWVsVEZaZm5tV3l1eXpPdXd2WXhOcDliQ0FKaHlO?=
 =?utf-8?B?cS9zYzhIdlc4c2hVN3N3cFIydkU4b3V6d0FZdW9hTGU5VXVVY0F1dXJNNk02?=
 =?utf-8?B?eG14L2RudVg1ak9EajJnVlpsQkZTa0FXb0RxaU52YWViSldxc09wRHlOL1Fw?=
 =?utf-8?B?OVBzYjQ4Mi9EeEs4WGlRSjdKU1RrUnpwcytIQlRjbkQvUWN0YXlTV0U1QW5u?=
 =?utf-8?B?YUxMTndNbkZRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9P195MB1228.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bURCckVGWjB5ODZXaVN2K1c2Y09teWpaNDUycnIxQTRYanEwTDdGZXFqQkhF?=
 =?utf-8?B?c0U1dkRQMm1JRDNRLzVENWMyQlByNUtsTVc0ampkRmZENk52SDFYMitPZUQ2?=
 =?utf-8?B?UVAvYTYrY0lKTlZFZ1h1WEJROHNROUZpVzZ3bzhQaTh0TDFINE9qUkxtazUy?=
 =?utf-8?B?cS81OVl4NXZwdGdFbDVZNHoxSHBXOTBtajlqbjJwTnRRend5YVhFYXY2NnZR?=
 =?utf-8?B?KzBOZWtTUlpTbHVxZFlqWkVGOFkzTjkyREFtMjBHemw5b2tlSWsxcXR0UjZL?=
 =?utf-8?B?cTBhcFZ1RVRhNXd5bFkzNXR4NlFjZTlVNTZzd25KTGtwWmdmamtBQlBYZnVx?=
 =?utf-8?B?eHRWYVF6aGJ4ZFA0MWhBa0JNdnA2Zyt3QmE4NDFaRDBIbk1MN2Izd0RWWERl?=
 =?utf-8?B?aGp1amViT2IwL1M4L0ZmMzJKVUVnWWUxdGZyTW1XaW1Dd0puN0x2VE5kbXFa?=
 =?utf-8?B?STFqOWErQUZFQk91QXhqWHpqWW5aSDgwU2xITml6YU85TjZvbHR4UnM1QXNW?=
 =?utf-8?B?OW92eGxRLy96d1BhcVVrRW5TT3d4L2hJWnZjZUNnL1R0VytmbmNRQTVkL0dO?=
 =?utf-8?B?bTArMXRVdlBLQUZrWUd4VCtra0taaUUzRnp3eEVRQ1VvYnBJcVFScHNscGh2?=
 =?utf-8?B?dFBQQ0VUMmF3L0xBSzN0Slk2WDByZkFNSGlBbVRzZjdZcC84bWxsdDhIZE5G?=
 =?utf-8?B?enNQM3lmRnJDUk0wZHFtTHVQcU9XcWVMQmVhaG00a3JuczFONlZGbnhPaDYy?=
 =?utf-8?B?aXYvaFQrNks0ZWZqVFVFVzh4d0R4MkRkZEEvYXl5VFRlR3hBNGhNQnQ1b3Bn?=
 =?utf-8?B?UHExWlRCOWxjUExDWVlnT0k3eVFPQ1RCMVpwRHRzc0hta2s0OW94QndiWS8v?=
 =?utf-8?B?cEVwZ1R6MGZndkNXZFBjWXpFU0FlMU9JL3FEYjVkMWd6NENOMVRRSDQwczha?=
 =?utf-8?B?WGsxYlJ6R2Z1Q2FmbE92OWxTRWUvY0tsa1I5Um1aNFJtbFVncnZnaGxiNnZs?=
 =?utf-8?B?TDA1bEF1RjE0MFVkbXBpVWdOcVUxUWJENFVjclN5aWI0NjZhcnJwVGE0ak1D?=
 =?utf-8?B?NmVKTzNILzRVSHZBSjZESzFCOVhDTHJ4azgxeUtaOUlTOCtNWDY4b1R4SkFt?=
 =?utf-8?B?VXpmQk1YUXNzVnRrV1hFYmVJRThqWm1NN1M4OGF2ZU8zbnVYakN3d00xcmti?=
 =?utf-8?B?SkVKYzVYU0paN05KM2p4TXlxUVVBV3VwbHBxbWtKK1N1ajJsTGZRUlZHdE5R?=
 =?utf-8?B?Y0R5Sys1NEZ6R21uT2xwYXJaSWJvaXlaMGxtK0dwQ1B1NXVvSUpkMXg5VW5V?=
 =?utf-8?B?QVpYWndHeldLZnZhaTFWQW1xUnFCcW16LzVSaTYrRnhwQzE5QXpwMGdkZC9t?=
 =?utf-8?B?aVRKNXpRTmMrL2ZBTzg0SWMzOTNkQkVEcjMzRGZMbnhJMFhqV01LZVJ3ZTUz?=
 =?utf-8?B?MTZmKys3SFh4ZmVUak5MUEJkcjNic2J2NTR0SU1HelM3TVFrWFNhcE5CZXhT?=
 =?utf-8?B?bC9oQVFTREFaU2IzV0dpK2dOaGFGT1pISThJdDdocXZYZ3VHK2FySENWME5r?=
 =?utf-8?B?anlVaDFrZHFwZS84VTNRL2F2Y3Q4ZmpkcWRJMjRSNHZHTWY5WGdNVXlHVlc0?=
 =?utf-8?B?b1M5Z0hHdG9JbVk3TXMyUi9WZGR3VEVUVTdMeTM2WVRia3lPcVd0R3lSWjk2?=
 =?utf-8?B?cjJXS050S3c5WlVSWDhWbmFSSHdxRnRRU3F4dEVYa29EVVgyVUorVTlEbGwv?=
 =?utf-8?B?eHIrVlZObGdTeXBvalhrMlRPVENQWVhqcHl4bFhhMW56VGV2QnJ0YjVvSW83?=
 =?utf-8?B?V3BLdmtydXJobnVwd1dXMTFhZ0dSZHo1T2JRb1ZiWktWUjJVUTBtSXE0L3U5?=
 =?utf-8?B?WW9MY3FQekdMQkh5T1d1K0VBRDhBekVzYUg2b0hUSXllaWZLdnVpaUpITFBy?=
 =?utf-8?B?ckJUcXpjTlkrWDV0WG9kM1Rnazl1K1VGWGJLWkNQMjhBMWUzaG1WdDdsbEpr?=
 =?utf-8?B?V3BsRDIvdDhVMHdWR0VnWEZCdFhld3lxUHhpY25SVHBUS1V2K0NTUnNmSTQr?=
 =?utf-8?B?VCtKU1hhQ1gzamhkVC9MQTI1ZkNMZWRlTSt6c2ttRVF4Q0xJMlVMdWdrNFFO?=
 =?utf-8?Q?U9Fm49WoBb2YGVwX+YIvfWFCc?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <48EAB22777F21340BFB3C9C34B24D573@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9P195MB1228.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bb9e6a2-5b94-49a6-99c6-08ddec7dd4f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2025 13:12:14.4516 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6Y07lVkyMC8tM5NhLM4W1eJTJDhiDqD1nF/oLaDlXBry0wDr7YEn/UDHznm6WGF/Fu+K3HB3ShBfUxoEKRrQvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1P195MB1448
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

QW0gRnJlaXRhZywgZGVtIDA1LjA5LjIwMjUgdW0gMDk6NDIgLTAzMDAgc2NocmllYiBGYWJpbyBF
c3RldmFtOg0KPiBIaSBUZXJlc2EgYW5kIFlhbm5pYywNCj4gDQo+IE9uIEZyaSwgU2VwIDUsIDIw
MjUgYXQgOTozN+KAr0FNIFRlcmVzYSBSZW1tZXQgPHQucmVtbWV0QHBoeXRlYy5kZT4NCj4gd3Jv
dGU6DQo+IA0KPiA+IEkgYW0gc3RpbGwgbm90IHN1cmUgaWYgdGhlIGVuZCBvZiAxR0IgaXMgdGhl
IGJlc3Qgc29sdXRpb24gYnV0DQo+ID4gcGxlYXNlDQo+ID4gdXNlIHRoYXQgZm9yIHBoeUNPUkUt
aS5NWDhNIE1pbmkuIEkgcGxhbiB0byBzZW5kIHN1cHBvcnQgZm9yIHRoZQ0KPiA+IG90aGVyDQo+
ID4gUkFNIHNpemVzIHNvb24sIHRvby4gSW5jbHVkaW5nIDFHQiBSQU0uIDJHQiB3aWxsIG5vdCB3
b3JrIHRoZW4NCj4gPiBhbnltb3JlLg0KPiANCj4gU2hvdWxkIHYyIGJlIGFwcGxpZWQsIG9yIHNo
b3VsZCBJIHdhaXQgZm9yIHYzPw0KDQpIZSBuZWVkcyB0byB1cGRhdGUgdGhlIGNvbW1pdCBtZXNz
YWdlLiBTbyBwbGVhc2Ugd2FpdCBmb3IgdjMuDQoNClRoYW5rIHlvdSENClRlcmVzYQ0KDQotLSAN
ClBIWVRFQyBNZXNzdGVjaG5payBHbWJIIHwgQmFyY2Vsb25hLUFsbGVlIDEgfCA1NTEyOSBNYWlu
eiwgR2VybWFueQ0KDQpHZXNjaMOkZnRzZsO8aHJlcjogRGlwbC4tSW5nLiBNaWNoYWVsIE1pdGV6
a2ksIERpcGwuLUluZy4gQm9kbyBIdWJlciwNCkRpcGwuLUluZy4gKEZIKSBNYXJrdXMgTGlja2Vz
IHwgSGFuZGVsc3JlZ2lzdGVyIE1haW56IEhSQiA0NjU2IHwNCkZpbmFuemFtdCBNYWlueiB8IFN0
Lk5yLiAyNi82NjUvMDA2MDgsIERFIDE0OTA1OTg1NQ0K
