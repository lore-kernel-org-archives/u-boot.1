Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22098C35FFC
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 14:56:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6A4981026;
	Tue, 25 Mar 2025 15:56:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="NU+wu2eW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD5CA80F70; Tue, 25 Mar 2025 04:21:01 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::62a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8B6680107
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 04:20:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziniu.wang_1@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ONP6ZZ4+fiHQ5sNCEli4FzDZIvnWfT/NmGwoZgWc2n1q+SlP6kFEAFtWeCx3elel7tiaOjCLOnLex+aongOTT4hne/botgjMw2QvY4G89iezrxIREsHhbatkQvVLjXm8n7GVNjtEF9HJBFJbzuDLI3H+z4Bc8f5a/ess3AyN/CRIy01ZaDxKjtUvedwQ3AEGcbUH2+VALt/MlM3EbCNs6lePTUq6ARm2DIY8W72fRzg7Y7sZInToacz2MFeUKTBOOHDcmP5CC8d97kC2/uG4KwRhQw3JqY5eG49d856ChwXmiFxJyhO3pOSLwGDsy+1rZi00RSpsTWkep1VDLPBpBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9YtvsONlxDCBYD3AaI78pPy+t9W1o1cKFBrzFmPUYHE=;
 b=YjYgVXSDl/575af32NIaZHU90STbZKBRV5mOfM3li4SOgYZCLP/9eI4zWuQxQ+3SCPmB7qoKOeSqRIHii+j76dEUs64EBsB8mndpvpQ9NMEBrA6Aj8Fdfv9VHgXQ7WBYhhFCyQfepAugNZhXIm8uwC423+SHUHHdKEb5UOBhQwnv1QmzlA/Q3PsA2CiXqJjPkBucUqFvUIv8IBiyFWZhaQGvhWC5ffmf6rFzIJa0O9zksx2ogZP29GxVBnZKeSK0HA3YIFS/v5h8tMSP4s4VFoZ/+MizPkiue7mwcFdPVTGtPJTQlvW3LVziGoQ6ips2aSAkjkmKu5vTWAH+ifONDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9YtvsONlxDCBYD3AaI78pPy+t9W1o1cKFBrzFmPUYHE=;
 b=NU+wu2eWz8yD8x+aQmgstxiZg+P9NBrVfKHtr4bUnRqfIJyNcOnH938bORHvM+DIyLrBunx/cWOVWIG5hpirrq+KKcNPaUGOSEkEo8rYe57OTQK/h3vjkeFTRQmvjYn/3rERVptRa/ZDwJ1g3okxe3TT7FkHc9jVDFmXEZ4z6h7rn1lk/NYBQR3fcW1YMhIDYoRjhMoSY/ja1x1dr6JpS4qehd2melakakGBu5dFhiIr7SKZMrEeZykAKwRgsHmKWQJ0Pm6/D4OrntmwlWPBsP+zEibF7FGWLjCJ0KDvmRM8v9woHFg9vZByYsfIpSA2+iNU54d172PK5neLF7p2hQ==
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com (2603:10a6:10:2d6::21)
 by DB8PR04MB7194.eurprd04.prod.outlook.com (2603:10a6:10:127::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 03:20:57 +0000
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::4db:3dc0:c292:493a]) by DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::4db:3dc0:c292:493a%6]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 03:20:57 +0000
From: Luke Wang <ziniu.wang_1@nxp.com>
To: Marek Vasut <marek.vasut@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 "jh80.chung@samsung.com" <jh80.chung@samsung.com>, "trini@konsulko.com"
 <trini@konsulko.com>
CC: "pbrobinson@gmail.com" <pbrobinson@gmail.com>,
 "marek.vasut+renesas@mailbox.org" <marek.vasut+renesas@mailbox.org>,
 "tharvey@gateworks.com" <tharvey@gateworks.com>, "jonas@kwiboo.se"
 <jonas@kwiboo.se>, "sjg@chromium.org" <sjg@chromium.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: [EXT] Re: [PATCH v2] mmc: mmc_boot: support sandisk and micron
 emmc boot/rpmb partition resizing
Thread-Topic: [EXT] Re: [PATCH v2] mmc: mmc_boot: support sandisk and micron
 emmc boot/rpmb partition resizing
Thread-Index: AQHblxkGWQ8V1UTVakaelwZz6VVlGLOCXvgAgADadBA=
Date: Tue, 25 Mar 2025 03:20:57 +0000
Message-ID: <DU2PR04MB8567E74CEFE5C3787A1D3DEAEDA72@DU2PR04MB8567.eurprd04.prod.outlook.com>
References: <20250317084649.1059257-1-ziniu.wang_1@nxp.com>
 <b4044271-2502-4b78-a0df-3ab164e2d196@mailbox.org>
In-Reply-To: <b4044271-2502-4b78-a0df-3ab164e2d196@mailbox.org>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8567:EE_|DB8PR04MB7194:EE_
x-ms-office365-filtering-correlation-id: cc710775-a016-4b5d-7ac4-08dd6b4c0f17
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?N1V4MHcxUVk2SUFFcmhMYUJ2ajVSOTlGc3JUMFJhN3RaZWZMZkNLdTR1Lzk5?=
 =?utf-8?B?NTRiK1Y5ZWR2L01oM2dJWnJWWmIwQVV0U01rK0w4MVYrVzdtODBPOFNha3c5?=
 =?utf-8?B?d0Z0dVhCc2N3aE51SllXR2Zoekg0NTl3L2hKeFFuU3FYMUIvKzE3UnBzTllR?=
 =?utf-8?B?Y0pIbnh4QzVQbXljTHA5djBYMkxxRlArdkFMVzFnem84Y3NTWitEbmROZlRl?=
 =?utf-8?B?Z3Bja2NFMEYyM0pHMVFvQXVEN0dIQmFDR3N3aFBEeVd0UmJ1OHVBSG1FYkgw?=
 =?utf-8?B?WWR5dGNHT3Y3ZlZBUHFzQ2d1bC85anlxNUVNdE11SEc1Y01xRklKWWtTdTVN?=
 =?utf-8?B?U2F5M3N1S1BzQkUyQU5kem16TENSNnh0bXhZRGlmSlVockhqOEROdGFtMVFV?=
 =?utf-8?B?dDN1RXU2Q1JsdWpWSjVZODN1YjUvWWF6bFdVTmFhTjZPV2I2WjJJemYydWJa?=
 =?utf-8?B?UXJKM3F1L1hKR01McG5iRk9ERFZGenBSbWMxWHZxcWUvNTFjMzdyNXNpZnhT?=
 =?utf-8?B?di9QcUtsM2hWOGFRMUppdHdTd09PUS9lNDBDS21hMTVmckhJSGxyMkxLREdt?=
 =?utf-8?B?Q2FjYldaNWlxRmgvZS9YbFpnKzdMZTlYeEN1Z1Q5SzlrcXRkMGVWd0VrRG9G?=
 =?utf-8?B?UGRmeUxHZ0Q3aG9wRzlLeWRtYWJSRGlMK0VrbGZKZkdqTzJkWXloUkhLWVpw?=
 =?utf-8?B?UXQ0WlhHOGpLVlYwbXZGTkZ3QU00bWhGU2phM2JlK1pPOUtkcDhZZEludlZk?=
 =?utf-8?B?WFFGQzZ5emE5dVMvM0tyc3ZHN1RYaCtBTC96UGVKWHM0TU5Uc2lDOXpRU3Aw?=
 =?utf-8?B?OGZndWNIMUF4eDIydnVHb1lZSGJiSDJIemRBUndLSjAxZkdCSjV6eTk3YWhy?=
 =?utf-8?B?ajVDZ2lwa0ZtZ1ZFdFRIbGJwUWlLdFpXenBjMlVLZTdibHlPamZ4SERqV3lH?=
 =?utf-8?B?NUtaZGFuQ0tBZzlHaWN5eExtSUh6aitQSmF6K3ZqRXNNQS85RzhQSHV5eXlL?=
 =?utf-8?B?eS9yVkJoRVhvRmttMmNGaC9ndzhkUkJoY2Njdm1zVVVnYWhtMTd0dm1PTXFw?=
 =?utf-8?B?S3RIeTREY29xY1FjaGVhV0tkbytVOEJYU3Q2d3ErVzhLc096RzE0NGRMc01R?=
 =?utf-8?B?TVVzRFpTWWhNb1hVblNlTGdzS0NOVmw2MTUrSXJINmNpN2hhejFpeUtEY3Bs?=
 =?utf-8?B?M0dTcUhlTExUbjhtTzJ6MzBzNENNT1JuVUdpNVFVRzlqZ010NVVtR2k5akxI?=
 =?utf-8?B?VVIzampxV2JiNTdRTlpsT2VFbktUUUdPdXhqUTBlUmR1V2FIeG1ZU003azBZ?=
 =?utf-8?B?eGp1SUIwblBEcTJvWDJNbjM3M1pzc3dWK0QrZ2UvZWhiaEluV0IyaHdBQlk3?=
 =?utf-8?B?eWVUVXd3Sk11Ky9DTkNUVjlUYThCMlVjdTZQQVdRSDBmUCtNaFVwUkxHN2E2?=
 =?utf-8?B?VU5RZDJucVRFS291eVlURFg5MHhJUlZTMm5sR0l0cjU5eXMveDZueGxGNmxz?=
 =?utf-8?B?eElyUzdrOEU3NE92OTFLbHlxS1Y0ZzE2bjRiUUxFa2djUytvNXphcklKb1Ri?=
 =?utf-8?B?UTBoeGtuT3VnZWhNUkdpY0l0NjRXK0MxeTk0S2FhYWZVVDR5dXRQSHpqbWtO?=
 =?utf-8?B?QnBaWm54akd0NVRBL0hYYk95REtyVzN0bUpBVjQ2aTJwUWNBb1dKR2lsNUFo?=
 =?utf-8?B?STVzenNkaWJ6K2R1K1g4NVZmOGVCQXdrbEp6OFh4cHNBRWZ3SzhPRkxOdVB3?=
 =?utf-8?B?YjFlcmhQVlA1blVwelM2clBBZFF2VUJscVMwSUQvYUN4T2F4ZTAxay9kTEE0?=
 =?utf-8?B?NGl0Zk9pUmNLdWV1OTI0Vk9CVkhjK0JIRFpXL2UvSXRYcmI0dVAydDkyUitl?=
 =?utf-8?B?LzVlTkhmV0xZVURUWEtLNlpaV0NEWXZaR3Rzak8vMWhzM0ZxZFhOTHNPamg2?=
 =?utf-8?Q?ZMiYGmdfaCgduuq0bwMarW71eaHpidv7?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:DU2PR04MB8567.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZXRpeEVTOXdZamlzSnphRkhXWnU4UzllZENHRTNuWVhlbFpTYXNrNGw1Y2Fs?=
 =?utf-8?B?RmJyZ1lPaXl3QlhUaVdtRHZ6bkFPZWVTeFhmaWVYS0FTV3Y2cUVxc0poOTVR?=
 =?utf-8?B?cTl4VjFkL25HMUZmQlF5N2tNZjQydDdqTExjM2JPSWwzY1hhL3BKcVBBMERw?=
 =?utf-8?B?bmVBY0ZLcjZRRm1TanVxQUx6UTEvb2V5aUlrajNnUnQwM3pmTHduaFJYYm9P?=
 =?utf-8?B?eUU0R0pRKzl2L01XMjFieVlNWkJSSUhLVk00WW9xQnNER3lZbU9CSVppZXlv?=
 =?utf-8?B?UnR1eTl5SlFTemVROHliR3hIdzlQbzd3TlNSY3dlSUFZRGVDUG5xOHB6bHM5?=
 =?utf-8?B?MnRLaUZTdFIxUEpGdG1tdWUvZTRhM2lVOGplL1k0Vy8yVi80Qi93MWFheWJK?=
 =?utf-8?B?cHo4WTYvOTd0TnRCNXR6Ty9DdkFFQVpVN0xGTWV1MGpZVzZFQkRZSjloVCtD?=
 =?utf-8?B?RW0rWit2TkRyL0Q1T0F6WUl3eFlwempNZ2oxdFRVZUpiRlJ2VmdhdnBvc0Zm?=
 =?utf-8?B?cXo3VzRwSEw4Q1JWaUJXcFMwRGxXdkZ6OEdlR3g5M3UzRkl6d1hGMFFaT1ht?=
 =?utf-8?B?eWdqVW8wWFdrRmtYUTRjb1JzWkJiR3hDQTZKRE1aMENwc0RnaDQ3VFFtai90?=
 =?utf-8?B?bVYxbEI5RXNkZW13bFBMa1p6REUySGR3bThSbER5Vnp6VnhsRERaUVRESDE0?=
 =?utf-8?B?cjU1OGd3OEVwcGp0L2F4WkUwNmV5K1NiZHhBaWgza2Rnb3dYdml0SFkxbXZi?=
 =?utf-8?B?MzdWaUdCVXJuRUVVcUh3ZlQyUWZDUWJiUk5BRTBKdlFYVmRsQ2kxY29UcXBW?=
 =?utf-8?B?dTZHeGJvb2IyeHJuQ3ljR1cwZ3k3RTZlemYyUkdZRWcrOTNrSmNnWW1rWUlp?=
 =?utf-8?B?a1RWdW04V09QWXQyOGlVbkU1VGhWc2ZXQSs5d3NYT0JqZ0dpWlFodU9tSVB5?=
 =?utf-8?B?UkFmUDhsb1lRSVZpTVJUQ0lmSEl2RHN0eE0ycmUyWkxjNnd0TnAvRzYxWXNa?=
 =?utf-8?B?NzAyR2J4Q2J0NXAxZnlvZGdVdngvdGo1Ry95amwwMXlrUUUrQzNuMHVkb1FK?=
 =?utf-8?B?eU5KQVloTGVwRlFsVFhWb1lPbnlIbUZ4RDJoeXNUVzM1c0ltMFp2UWtXVTVs?=
 =?utf-8?B?ZXlLVm0yTm5PU3Z3TExIaW9JalNlUUpJUzFUY2Ftd3QxOFdoeDRTL0FaejRG?=
 =?utf-8?B?bld0clRWM0haYmR1aDVwT0twekpBTndHeGdIYm11b3A4UjRoMVRIdytvUUFu?=
 =?utf-8?B?OUhka0h3YzFIeW9kWGI4blVMNzdrNUpacDU2a1VtWkV0OHJHZGRreVg5Q1pR?=
 =?utf-8?B?dHEvSzR6a05ERkFtczdXcmNtTjFwYUR1aWNzV1BueDlJUDFnK1BrMTZyVW5x?=
 =?utf-8?B?VWJKemJyMWVLV21sK29tTU14aXVuZzZuQk40YThSckFka0FkdjQ2Ukc1ZHJN?=
 =?utf-8?B?Rkpsclg4MjBjWjVRZUNpTExBdGhJQlU1SlZvUUJFZStCRDRGL3ZmaW1VbjFI?=
 =?utf-8?B?TjNNWmtjQ09US1g0aHpTSmI5cUJoL3J0dDBWamhpTWdwMEdlcTNjcG5QQlpU?=
 =?utf-8?B?VzJNbjYrbHB6bU5nczFmVHBZYlErT2d2RDM3RFhEN3JaKzlKczBhS3JIL1I1?=
 =?utf-8?B?YzdBV1AwQnhsWWVXTlh1MjBYTDc5MWxXeVdta254dU5qS0ZvOStLQm11SERL?=
 =?utf-8?B?d1pMaXR4ZmVoYXFKdDVKTVVDRzZPZjRrZk5nMFkxRzdDZmdMQTRDNU9GQytV?=
 =?utf-8?B?aTZmWG84MGF5WFZuVE82ejMvMUZsOGphbjBFSEV6TFROeTl0SjJsSnBsckxH?=
 =?utf-8?B?MS9tWnRKZEVoS09yeG9ZVTN4Tm5yQkl4ano0dGNUTlZDb3BMNDB2Vi9VeTJv?=
 =?utf-8?B?c29kSlFmTUd3UzRBRnJhWTFaVHR5S3JLNUoxdEdXSmlPSkM4aTZidXVDS09G?=
 =?utf-8?B?aktXMm9mb3JndnlCQ0N2K3ZxUVFnWE91QmcvbEZvZURwMHZKK3JxaHQ2VVdo?=
 =?utf-8?B?MWliMUtnTkR5ckNsd2hZUmNKais4aU9NK2gxTkowWE1KSjlzWVNlbDZnWVJY?=
 =?utf-8?B?KzRsRE9OL0hRMnM1aGY2RkRLODU0KzdTcDB0N1hDK2RWUTRROUZSazJSYXAy?=
 =?utf-8?Q?p47npWDWH2/Ug8SMzsWsgBGuT?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8567.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc710775-a016-4b5d-7ac4-08dd6b4c0f17
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2025 03:20:57.0778 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eTG/gOkTOF2YZpQCpmoXXIFmC/Yb5NrC6RQQDZ3KvKZ7h03UW6MXwSQO+iYz3W0QGltcoRb6E7B3eM5n2I8YVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7194
X-Mailman-Approved-At: Tue, 25 Mar 2025 15:56:16 +0100
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFyZWsgVmFzdXQgPG1h
cmVrLnZhc3V0QG1haWxib3gub3JnPg0KPiBTZW50OiBNb25kYXksIE1hcmNoIDI0LCAyMDI1IDEw
OjExIFBNDQo+IFRvOiBMdWtlIFdhbmcgPHppbml1LndhbmdfMUBueHAuY29tPjsgUGVuZyBGYW4g
PHBlbmcuZmFuQG54cC5jb20+Ow0KPiBqaDgwLmNodW5nQHNhbXN1bmcuY29tOyB0cmluaUBrb25z
dWxrby5jb20NCj4gQ2M6IHBicm9iaW5zb25AZ21haWwuY29tOyBtYXJlay52YXN1dCtyZW5lc2Fz
QG1haWxib3gub3JnOw0KPiB0aGFydmV5QGdhdGV3b3Jrcy5jb207IGpvbmFzQGt3aWJvby5zZTsg
c2pnQGNocm9taXVtLm9yZzsgdS0NCj4gYm9vdEBsaXN0cy5kZW54LmRlDQo+IFN1YmplY3Q6IFtF
WFRdIFJlOiBbUEFUQ0ggdjJdIG1tYzogbW1jX2Jvb3Q6IHN1cHBvcnQgc2FuZGlzayBhbmQgbWlj
cm9uDQo+IGVtbWMgYm9vdC9ycG1iIHBhcnRpdGlvbiByZXNpemluZw0KPiANCj4gQ2F1dGlvbjog
VGhpcyBpcyBhbiBleHRlcm5hbCBlbWFpbC4gUGxlYXNlIHRha2UgY2FyZSB3aGVuIGNsaWNraW5n
IGxpbmtzIG9yDQo+IG9wZW5pbmcgYXR0YWNobWVudHMuIFdoZW4gaW4gZG91YnQsIHJlcG9ydCB0
aGUgbWVzc2FnZSB1c2luZyB0aGUgJ1JlcG9ydA0KPiB0aGlzIGVtYWlsJyBidXR0b24NCj4gDQo+
IA0KPiBPbiAzLzE3LzI1IDk6NDYgQU0sIHppbml1LndhbmdfMUBueHAuY29tIHdyb3RlOg0KPiA+
IEZyb206IEx1a2UgV2FuZyA8emluaXUud2FuZ18xQG54cC5jb20+DQo+ID4NCj4gPiBDdXJyZW50
IG1tYw0KPiANCj4gTU1DDQoNCidtbWMgYm9vdHBhcnQtcmVzaXplJyBpcyBhIHVib290IGNvbW1h
bmQuIEkgdGhpbmsgd2Ugc2hvdWxkIGtlZXAgbG93IGNhc2UuDQo+IA0KPiA+IGJvb3RwYXJ0LXJl
c2l6ZSBjbWQNCj4gDQo+IGNvbW1hbmQNCj4gDQo+ID4gb25seSBzdXBwb3J0IHNhbXN1bmcgZW1t
YyBib290L3JwbWINCj4gDQo+IFNhbXN1bmcgZU1NQyBCT09UL1JQTUIgaGFyZHdhcmUNCg0KT0sN
Cj4gDQo+ID4gcGFydGl0aW9uIHJlc2l6aW5nLiBBZGQgc2FuZGlzayBhbmQgbWljcm9uIGVtbWMg
Ym9vdC9ycG1iDQo+IA0KPiBTYW5kaXNrIGFuZCBNaWNyb24gZU1NQyBCT09UL1JQTUIgaGFyZHdh
cmUNCj4gDQo+IFBsZWFzZSBmaXggY2FwaXRhbCBsZXR0ZXJzIGFuZCB1cHBlciBjYXNlIGFiYnJl
dmlhdGlvbnMgZ2xvYmFsbHkuDQoNClRoYW5rcyBNYXJlay4gSSB3aWxsIGZpeCBpdCBpbiB2My4N
Cg0KUmVnYXJkcywNCkx1a2UNCj4gDQo+ID4gcGFydGl0aW9uDQo+ID4gcmVzaXppbmcgc3VwcG9y
dC4gVGhlIGNvbW1hbmRzIGFuZCBwYXJhbWV0ZXJzIGZvciByZXNpemluZyBwYXJ0aXRpb25zDQo+
ID4gYXJlIGRpZmZlcmVudCBmb3IgZWFjaCBtYW51ZmFjdHVyZXIuIFNlbGVjdCB0aGUgY29ycmVz
cG9uZGluZyBmdW5jdGlvbg0KPiA+IGFjY29yZGluZyB0byBjaWQuDQo+IA0KPiBbLi4uXQ0KPiAN
Cj4gPiArLyoNCj4gPiArICogVGhpcyBmdW5jdGlvbiBjaGFuZ2VzIHRoZSBzaXplIG9mIGJvb3Qg
cGFydGl0aW9uIGFuZCB0aGUgc2l6ZSBvZiBycG1iDQo+ID4gKyAqIHBhcnRpdGlvbiBwcmVzZW50
IG9uIEVNTUMgZGV2aWNlcy4NCj4gDQo+IGVNTUMNCj4gDQo+ID4gKyAqIElucHV0IFBhcmFtZXRl
cnM6DQo+ID4gKyAqIHN0cnVjdCAqbW1jOiBwb2ludGVyIGZvciB0aGUgbW1jIGRldmljZSBzdHJj
dXR1cmUNCj4gPiArICogYm9vdHNpemU6IHNpemUgb2YgYm9vdCBwYXJ0aXRpb24NCj4gPiArICog
cnBtYnNpemU6IHNpemUgb2YgcnBtYiBwYXJ0aXRpb24NCj4gPiArICoNCj4gPiArICogUmV0dXJu
cyAwIG9uIHN1Y2Nlc3MuDQo+ID4gKyAqLw0KPiA+ICsNCj4gVGhhbmtzICENCg==
