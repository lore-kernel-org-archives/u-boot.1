Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1835DD5E15E
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 11:52:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95BFA88FE8;
	Fri,  8 Nov 2024 12:52:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="dgGf2VlY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42BD58902D; Fri,  8 Nov 2024 12:52:22 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2049.outbound.protection.outlook.com [40.107.21.49])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 609D6881E7
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 12:52:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=igSF/KMJVui+sdjvoZWhey3+K0itC8GkswERAA0gEnaeZxyvxic3R+3OTeLnsmKLTKDRfxuB5ZqYFZsGvt25ra7KVNjVl6P5pqdkOZxrSpF7gQnDlIwrGLS8BRZ2jXiTCnaYJke711P7TOOXuOopvRVn13ALNOpsj3+hu9hhLOAlnjoelmNPbXVoxc5c07bYcR9Bcvn2BQt/6IRnZQsbV5idEYzagH85+TieBFau7oU65QJUvA5XfhSFYO5D3Yo0nII0xwJyzuttwRiH/LGkC9O6RV+b4MMnQfjLy2tnI9/XIQCwag/2F1BNoEXcJXkKwArm/QGd4LU79AUe42QIlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3jSzH+Fdb4JPxIR2npCjYtfuz9awt0w9VftGYFEejgo=;
 b=VJkpAONQCa7zkcHTV3XiU/jNw45u6mqF4CymuNiswScPgj9uUtid+d4Hcs2V8/XGw/gQT9UMjvSow5uMpohNujWMZ14wCqwTYza2QfdjFKDKFECx8Ti/x/kwSalXQsNdGdcvy1aaKo6yK4c5HrX4gz0Bd90FBtVlXFry8+h63O/YVHFrlYLkW5xO87NcH/rjawLF8ZGuLg6E8TTECm8K1xlWyHP8YdeCJ1otYu7DDYMqVLXWHHcKWjFqv2njwspWfamnIqsrMmYe0tdSUUr0Nlj3KV6etakHruh4hdCCnp3sXUAAyV9/daTgGTLOSz2JZZ00SmTZdipntYNgpNYfQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3jSzH+Fdb4JPxIR2npCjYtfuz9awt0w9VftGYFEejgo=;
 b=dgGf2VlYp24slzaopgI9h1G2IL6h8asreZlt1qahJzLPqKmgdrsP0R+Sq+qAnEDawrxXPwkxg6yGLqWnHX5glHBWZxJrXOoXaOpiLuUzw8ydy1vwsbB/vmT6+ycW+3YXYZGNnv/9SoYFr0synA4+yT9mEmsZisafgO5DDJCCuzKR+o+Gfc/tcOw/Cd0B7t9am+W64zUxh1/edkir/WyKratosjpKCJOuA3s2PU/eHXk/VxK+vmTLQGn97hoe+jSDq0XfmorizYxDJa2Rr/tsOKJWrliJgBZIU19BPAAiGe2s+YkMDcv4ouHftIxuZCQoKRvpsDsqU7nZgITnuHe7Vg==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by PAWPR10MB7913.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:35b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Fri, 8 Nov
 2024 11:51:36 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%7]) with mapi id 15.20.8114.015; Fri, 8 Nov 2024
 11:51:35 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "hs@denx.de" <hs@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "agust@denx.de" <agust@denx.de>, "trini@konsulko.com"
 <trini@konsulko.com>, "Schweizer, Walter" <walter.schweizer@siemens.com>,
 "Leto, Enrico" <enrico.leto@siemens.com>
Subject: Re: [PATCH v1 22/22] siemens: capricorn: update maintainers
Thread-Topic: [PATCH v1 22/22] siemens: capricorn: update maintainers
Thread-Index: AQHbMZ4s5OAo8H07IkWfWzI2y/WAWLKtReEA
Date: Fri, 8 Nov 2024 11:51:35 +0000
Message-ID: <56ce5c2027e06723fb54011731c7108b8a0f466b.camel@siemens.com>
References: <20241108052143.26874-1-hs@denx.de>
 <20241108052143.26874-23-hs@denx.de>
In-Reply-To: <20241108052143.26874-23-hs@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|PAWPR10MB7913:EE_
x-ms-office365-filtering-correlation-id: 0f6e1929-df6e-453f-6a50-08dcffebb2a6
x-ld-processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?U2Y5R0FkQ3Z5Y0hVKzhySWlkTGE2YTUrQXIrUmJCajI3NGd3TWFmWlVXbHVG?=
 =?utf-8?B?U2FnY2NBMU5KeHltTGo0amRlMkpUKzR5TWhsU1llaWY5YldNM3lRM29vQzdE?=
 =?utf-8?B?MFloamVsOGJyRjk3aDkwd2FjaWtDTWJwbXB4ZzRTR2JWcUpldWVVenJiZERv?=
 =?utf-8?B?cDhXbjZRNXI5STdNcjh2UW0zQ1FBdWUrMVBzc2l6QjB4WVNiT2paUzBpcmlZ?=
 =?utf-8?B?ZnYreGkzaWU4dzB6VDRBR1ZTQmJWSDJhUXpnd3BVcXdNVXJ4WGlwalhEejYv?=
 =?utf-8?B?K1lSRzVSTlZZbmE1WlVQa1JKcVRJYXFTQklEWmhGelZRd0JZclNKZTB3d1dC?=
 =?utf-8?B?Sjh6aEU5K0JwTHNMZitzU2ViL3FCcHJiWG0wcEY5TU1pd2Y1N1cxbGE4YWQ0?=
 =?utf-8?B?MUFKRWZ0dndJUU1ST0NVbXhRTi9ud0NIdko4R3pCSS9CSXRhYzZlaS95WkZK?=
 =?utf-8?B?REhrQzhNUWlnTlRaSmlIQWF5VW1hU2dOVUhucFF0MVI1amwyeFFZdmRZTWR0?=
 =?utf-8?B?TnhWZlowYzg4RWpUL0JOcStkTHFCOG5BV3hPelIzOEtYZzQ3U05ZOFhrQWtn?=
 =?utf-8?B?ZkF6NldZTjQyM1dLM1BQN0NmbjNXd3hkUGNKRE9rM1lmN2ZudFkvZUJadUt6?=
 =?utf-8?B?UGNFYVZ0M0hpbytjM21QT3FpRVFyZkZ0bHE5SEh4dTBCY01yOWtDak1IcEFs?=
 =?utf-8?B?SHlhSkhtQUlHdUsxUjZrWmpuRGNiZlJnZ2Q4QytsY2MxN1VjR1JSemRjUEFN?=
 =?utf-8?B?U2hkUmEvOFdsNlUwOVZpRWZDZGVHUCtBTHVOT1IrQjIwcUR3QlRLRFl5N1F2?=
 =?utf-8?B?b1JnRlhEcmRaTktxaDgyVklPdHJTK2JyNFR1NXM1dXlncElFUE9TRTlTa1hX?=
 =?utf-8?B?dU9qQXpPc3pEL0ZtUDh2YzRVaklQa1ZZRzlBemNEZS8xMTZyanhZYUV3Tmow?=
 =?utf-8?B?TXRhTGs3QW5xMDhPSzFVK3hidGl6c2FXUHpLY3pSY1RCOERRUkNoQ1BaRzFQ?=
 =?utf-8?B?YWtqcXVxSWFyS3B6U0xOY2pzYUdIUnRrM3FuNm1OemNWOGhiQ2Z4VVNsc1Jr?=
 =?utf-8?B?Z282L0V5VVQrUmVaVlZJVlN2YXVPWHBablZTU1h5MG4waFVyUU9kc1VMZWRs?=
 =?utf-8?B?dUZieFBWUGNDK01kVDBqd3N0bS9xYmdkenpIb3hUZENsTlFSVUFCbm5VR0wx?=
 =?utf-8?B?WTlxRng5QUZFaTVIcWphY1FmOWExcVRSMGtHaWZyM1VIM0lhWDNQNXo1SXVZ?=
 =?utf-8?B?T0FLQmlPQ3hGNjNWMW1YbzJWQkNtVzBRelNqWFBtQlRzN1AzRVU4Y2hlQVNJ?=
 =?utf-8?B?YWwwWE43R1VDQ3F0T09HMmMySjRQMWZ1U2ZnLzJERk1iTHExOXFmL09nQWtr?=
 =?utf-8?B?bVZyLzg2QU4xODZiZDRyL0dHVjMxVVBJYlcxbC91K0VYd2VYSVIvYWpldjlW?=
 =?utf-8?B?K0NDcmt2Y29yN1RNUVNzckYvVUZnRDB2WW9FS2tnNEs2U3BubUtVSkNZSnY4?=
 =?utf-8?B?di81ZFZsZVpIYlcwWmtoamZCeG1tVTUyWmZodExWY2V2OVFVaE12aTB0OWhO?=
 =?utf-8?B?UjYvbTlKbFhYU2E1a2Y4YnhvNW4vc1VCTUVVdUxNcVdSQTdxYjJjNnFsU2o4?=
 =?utf-8?B?dUxhOUcyaHhFaG81YjFPb20vN2oyTU52enp5dnlySjBuV3IvUW0zeXBRQlNQ?=
 =?utf-8?B?cGlIcFFKR3FOT1EwM1BhRzNGbzdOdUlzWUhZQTBETXI3amdqZEMvU0x5Y2RE?=
 =?utf-8?Q?1UvT++ZugUWeXrV6ax3iipRitC4RsRhxdx6v3AC?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eVcwMGp4SlFNcGZkQWJkYXI3aitkZmFvVGZIbmhLcUdsNkR5Mjc4K2gvU3ZP?=
 =?utf-8?B?Z2tTaTFuV0ladXI0Ui9MRWpRSGlZWjl3bW4zUGtyOVkrdXB6VWVFM3kwcGt4?=
 =?utf-8?B?TzA1Ri8rczFRR1poc28xZXV3NjNNL1VWN1BueUVoUXRtaHhsN2ExTVk5ZkZq?=
 =?utf-8?B?Rm1vUEFIRE5zWlRabWdaci9aYVVwVjJ0VDYzRXpDSU9JU0lFMDJHVm9IdFBh?=
 =?utf-8?B?YTRjV3YvaG10K2tESzN6UUNkZ2VvTytNMVA5NXMzQzBrenJWT3BuOFQyYzBC?=
 =?utf-8?B?aDFoRzVaYm9oNEErOHY3ZWlFOTl0R05IUnVyTVFoemlNZVBvQzJ4MWNKMUp5?=
 =?utf-8?B?TFhHTHpDQjJXWXRnaktUNlNxK0cwM0RuM2U0QlNtUDFJajBzREtUTW81QlFZ?=
 =?utf-8?B?NW5mS0IrZVFlOGJVRjJhc3BRUnpmenQ3Zzl3RThZWDRybFladXc3V2tXdms3?=
 =?utf-8?B?eUhBekVBZWxieDQxMTdDYmFWc0kybkQxSHBPQmRCUG1uZWxzQWVqQ0lqUkRm?=
 =?utf-8?B?TXZNWWZGbThlRGtDbyt2MlZIRm5tdllQWFNPenQ4QmJJZUwrUEdtVHozOU9r?=
 =?utf-8?B?YnRiSzU2NVdvTnBXRzBqT292YW9IMjV0SHMzNTVuN092UHRKdy9iN1VOZUdF?=
 =?utf-8?B?ZHdiYzFvRjhyWHltcXVQYzlLRTJyU3RJTmFucXhhNUhBUXY5R3NmSVZYSlda?=
 =?utf-8?B?Qlh2ZkhrQzBWR2pyUHBDc0Q5YllPaEpkUERGVGNPa3d5OUhtVDQyNlRJSkxG?=
 =?utf-8?B?c1A1UnFYK1M5cDM2b3VpN3VQNUw0VTF0MVJyaFZYV0tMZzRSTjlaclVuN1hH?=
 =?utf-8?B?c25RSEpQVVdUNmx4TDNNSURURHI1RkR2K1MzTEViTVNWUEEvWE9XUWMrckdp?=
 =?utf-8?B?MUhMTW1sQXRBbHEwTzB3NHp3WnlmL1VITk13Z0o3Qk81eElGeXoydGJVS1Zo?=
 =?utf-8?B?YmZVNnlwVDBZL2g1YjJ2eUFCNndkWHNTNFBTVHJvUXF1b1JCOGo2U3FweW5i?=
 =?utf-8?B?ZHN0WGpSRW42Qy9NbGVZdzhqaTJacW00cWx6Q2o1SlE1bFAzVUZRMW5hR0hX?=
 =?utf-8?B?VW1WT1d2MDRLY0tPQVJ2akJVTVg1S1R2ZXMvQzJkVE96cmJ5aHptVzVlaUdN?=
 =?utf-8?B?aWhFY200OTBBY2MreTdiZ0tyV3FTRlJLZHYwTGJ3cnByUThnL2trWTJ3V04v?=
 =?utf-8?B?My9BdDVwRWpGWnJRVGRvN3JrRCtrT3hIOFpmQjA4T3N1N0ZveFFyQW8zK2xZ?=
 =?utf-8?B?bXJPdElLSFhRWnhNamR5MVJRMTBhYlhsT254ZndETWYvS2h6NkN2RFVnOVFw?=
 =?utf-8?B?YS9FdjE3K21IT1drNHFwRjN4eUpHM0d6YTV1NmQ2WklWVGJGN2x2RkFLWjdp?=
 =?utf-8?B?ZzdWVVloZys4QmlXck1HRkFLM2JpWVh2ZWM5WG4wSEU5MXU2RkI3cWNRZEk0?=
 =?utf-8?B?UDBxUndGdUJUTVl6c0U3TGI5ZDZUK2NTNDFYWFBQcUN5aXhVcHNNbC9QYlZC?=
 =?utf-8?B?bUFyKzJhTWVEdWdSNzNaUGtpMnVjMnBwQTFDUkRDakpRWjE4MzE2WXdwd2Iz?=
 =?utf-8?B?LzZacEJENEZvUllramttV3RTeWhBVWV6cjAxdU0rSDJ1WlBNM280TWhRcTZI?=
 =?utf-8?B?QlVnT21ReUVmbW5zOFZyNk9VcEFzcHNpbWEvQit6aGh4M3hxYzg1bTduTDFn?=
 =?utf-8?B?akZVazRqaEo5aHhPT044eFFZT3RYR0FXMGp0RzNuSVB1RDc0UldDbm5yT2No?=
 =?utf-8?B?VWJlUXIxV0c1Mi90TmovS05NaHJ1M2Y5YUFJSkZpVFI4Y3owOUd0djM3QXJP?=
 =?utf-8?B?VkNoeE5BVFh6T3FtSEJyUEc3ZG1Vc2FTRC9pZ0FkaXh6b29tSVZIaWJpSDRk?=
 =?utf-8?B?YVlFbEU2LzV3S0lNRCtaMFdPUll4TEV1dHlCUFkzcTRCYUNUa1U3cTNrT29t?=
 =?utf-8?B?R1lseVBJeUVtbXd5eXJ2WDdiaGRlaWJPN2ZIQ2sxWm1vRmo4Yk5Sek11TXdl?=
 =?utf-8?B?SnovYTRUVnFGOUZTNDNXSmNtSE53Q0xjNEp4RnJPQkFWVDV0eGpTdzBtQVZY?=
 =?utf-8?B?UnZPNkExZkFTZHBoVEZaNlkraXdocGtUQXIvc2x6R2k4clYxS0RvS0RzaVMy?=
 =?utf-8?B?Z0pmVkMvNGpzSGFlejRUWWlZTkUvanFzdERWZ2YzZFpVa3Z1ckxveHp5TUYz?=
 =?utf-8?Q?Z45FbX/Kd1v/xBIB7FqCovc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9B728DF56BA7E44A8677A9CBCB9E3BE5@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f6e1929-df6e-453f-6a50-08dcffebb2a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2024 11:51:35.8933 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QJMatb14h/6Ot3dCjeBFUz5lQ4vpadMYcENUTm0zhyUye9FgIlGLKEPzNECamRmwx1P9UiqX4GMpCU2tfSo1KsfXwDJVuGhVhlUUUiWkv98=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7913
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

T24gRnJpLCAyMDI0LTExLTA4IGF0IDA2OjIxICswMTAwLCBIZWlrbyBTY2hvY2hlciB3cm90ZToN
Cj4gRnJvbTogRW5yaWNvIExldG8gPGVucmljby5sZXRvQHNpZW1lbnMuY29tPg0KPiANCj4gdXBk
YXRlIE1BSU5UQUlORVJTIGZpbGUsIGFkZCBzb21lIG1vcmUgYm9hcmQgbWFpbnRhaW5lcnMuDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBFbnJpY28gTGV0byA8ZW5yaWNvLmxldG9Ac2llbWVucy5jb20+
DQo+IFNpZ25lZC1vZmYtYnk6IEhlaWtvIFNjaG9jaGVyIDxoc0BkZW54LmRlPg0KDQpSZXZpZXdl
ZC1ieTogQWxleGFuZGVyIFN2ZXJkbGluIDxhbGV4YW5kZXIuc3ZlcmRsaW5Ac2llbWVucy5jb20+
DQoNCj4gLS0tDQo+IA0KPiDCoGJvYXJkL3NpZW1lbnMvY2Fwcmljb3JuL01BSU5UQUlORVJTIHwg
MTIgKysrKysrKy0tLS0tDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgNSBk
ZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9ib2FyZC9zaWVtZW5zL2NhcHJpY29ybi9N
QUlOVEFJTkVSUyBiL2JvYXJkL3NpZW1lbnMvY2Fwcmljb3JuL01BSU5UQUlORVJTDQo+IGluZGV4
IGI0YzUyMDMyY2M5Li41ZjQ2N2FhOWI2ZSAxMDA2NDQNCj4gLS0tIGEvYm9hcmQvc2llbWVucy9j
YXByaWNvcm4vTUFJTlRBSU5FUlMNCj4gKysrIGIvYm9hcmQvc2llbWVucy9jYXByaWNvcm4vTUFJ
TlRBSU5FUlMNCj4gQEAgLTEsMTAgKzEsMTIgQEANCj4gwqBDQVBSSUNPUk4gQk9BUkQNCj4gK006
CUFsZXhhbmRlciBTdmVyZGxpbiA8YWxleGFuZGVyLnN2ZXJkbGluQHNpZW1lbnMuY29tPg0KPiDC
oE06CUFuYXRvbGlqIEd1c3RzY2hpbiA8YWd1c3RAZGVueC5kZT4NCj4gK006CUhlaWtvIFNjaG9j
aGVyIDxoc0BkZW54LmRlPg0KPiArTToJV2FsdGVyIFNjaHdlaXplciA8d2FsdGVyLnNjaHdlaXpl
ckBzaWVtZW5zLmNvbT4NCj4gwqBTOglNYWludGFpbmVkDQo+ICtGOglhcmNoL2FybS9kdHMvaW14
OC1jYXByaWNvcm4tY3hnMy5kdHMNCj4gK0Y6CWFyY2gvYXJtL2R0cy9pbXg4LWNhcHJpY29ybi11
LWJvb3QuZHRzaQ0KPiArRjoJYXJjaC9hcm0vZHRzL2lteDgtY2Fwcmljb3JuLmR0c2kNCj4gwqBG
Oglib2FyZC9zaWVtZW5zL2NhcHJpY29ybi8NCj4gK0Y6CWNvbmZpZ3MvY2Fwcmljb3JuX2N4ZzNf
ZGVmY29uZmlnDQo+IMKgRjoJaW5jbHVkZS9jb25maWdzL2NhcHJpY29ybi1jb21tb24uaA0KPiAt
RjoJaW5jbHVkZS9jb25maWdzL2RlbmViLmgNCj4gLUY6CWluY2x1ZGUvY29uZmlncy9naWVkaS5o
DQo+IC1GOglpbmNsdWRlL2NvbmZpZ3Mvc2llbWVucy1lbnYtY29tbW9uLmgNCj4gLUY6CWNvbmZp
Z3MvZGVuZWJfZGVmY29uZmlnDQo+IC1GOgljb25maWdzL2dpZWRpX2RlZmNvbmZpZw0KDQotLSAN
CkFsZXhhbmRlciBTdmVyZGxpbg0KU2llbWVucyBBRw0Kd3d3LnNpZW1lbnMuY29tDQo=
