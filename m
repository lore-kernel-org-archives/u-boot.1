Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19E5BCD4F26
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 07:45:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 065BB80398;
	Tue, 12 May 2026 09:45:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="f1ugMtDc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD684803C6; Tue, 12 May 2026 09:45:40 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63386801A9
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 09:45:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vBP0BmtoWG9iH6PaRm3HX3qrx2q4VjOsCvYYQL8IfU25pB7KlXslO6DVNhcbo0K9c5goDkyu2mPHGOe8jUGDGv71oNRdNihjLsghfcTGbJ2wsPGogg9NV0vPXqLJxXPpQdYdRqooV7pbRzd85xcTDvXCIvHFYtSNOF1JRAx8tItgZudAxatCQW2Y/dHuupyhhkNYuurG3r0p5qfyQA2Z383q+UUgkfnZAzJ/LNqhzk1UeekesNq46hoG0WZJ8wflF+aLCEUU6tSmOv65Ie4O9rguoFT3upfO6OCXWuLUUsl8qSFbagyOIkNw7UmH5MT8PQ7Q+MqxTvpSLw9Lt47EkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7AtLibktVeg5hn4Iz5I+P8ab5aY23xY3LW1MVsFoKw0=;
 b=IEkwBfJw8lIR17eNAKwq4UDxnag6zvDu9/a6LuhUiC501iDuIkihUwthXP4/WyfYa1Wtpv1Hs/7TBbJEiJcyPZTesPLNLzVKwy/l9wVFUh1diFdLSP80dkzcHkuw5KS9595bfdMgl5/QVGc7csYcNhY11lRqSqX9ltyvIs6WtGYDOINofefRojzQvYkOL5En59402O/dSDL53p8/qka4J3Q7TT4ts0xXxWAUnd1GDH5TOQXF+vSVYTziiN09JGxLePbUjFDaYaZyPRBXoR5ZI/BXi+6hBxvIjhqQ6FeEHXc3eQofhiiyNaKF5o9K7+IKAwBn5VEnvp37TGR/zU6nVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7AtLibktVeg5hn4Iz5I+P8ab5aY23xY3LW1MVsFoKw0=;
 b=f1ugMtDcAUPHDsyE2tx+miWLU73fHI5eo+wRpm0AiwS1nYtUIGsjJnVb+lIkQocyxrSZZyRm+CiFs5sfbBL/bo64znKXNtzIKMiiL9q/giYYZkPunZXLGML9xEZsYa/h8NSiwN6tlXEfVevc8QT1SvB2YHhdDvyE9/Uc6aUEbfK58UB9LMYc1+UYQwGAyFUTGVSJKJs8JaFPbxX5O3cvTgVGNGXuqtCG3LhdApLc1tlAXEeXCotocXhP7sSX5T0z3kryMLANV5gR7r8bqtC3po4I10j1jniMpd9jwcC8jbwK6WOZopdnsoAqdfEoRS/cEM0a1ehWnZN+CrvUSR0fgw==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by VI0PR10MB8791.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:234::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 07:45:33 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f%6]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 07:45:33 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "Alexander.Feilke@ew.tq-group.com" <Alexander.Feilke@ew.tq-group.com>
CC: "trini@konsulko.com" <trini@konsulko.com>, "u-boot@ew.tq-group.com"
 <u-boot@ew.tq-group.com>, "Markus.Niebel@ew.tq-group.com"
 <Markus.Niebel@ew.tq-group.com>
Subject: Re: [PATCH v2 1/8] cmd: date: validate date using rtc_month_days()
Thread-Topic: [PATCH v2 1/8] cmd: date: validate date using rtc_month_days()
Thread-Index: AQHc4T8UAUFNocC4yk6nlZZLGAmfHLYKBCAA
Date: Tue, 12 May 2026 07:45:33 +0000
Message-ID: <262dc8c1144609af8b7495edd1d0d6c1d37426f3.camel@siemens.com>
References: <20260511120917.1017866-1-Alexander.Feilke@ew.tq-group.com>
 <20260511120917.1017866-2-Alexander.Feilke@ew.tq-group.com>
In-Reply-To: <20260511120917.1017866-2-Alexander.Feilke@ew.tq-group.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.54.3 (3.54.3-2.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|VI0PR10MB8791:EE_
x-ms-office365-filtering-correlation-id: 456f29b7-d5a6-4f9f-459d-08deaffa72a3
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|18002099003|22082099003|11063799003|55112099003|38070700021|56012099003;
x-microsoft-antispam-message-info: F3DIA02xE5+oy7lyx3nJNN7x1Cq1bKcndwxasM6BoUwO+GhFQbNIBr3GChWVT6W41vbX2UCB2RYZKX1hDqp8QPAwk5buTeT1V7uJ1sm54jOdNhsViEavhcu1qqmRiZQFXreXRipBHeCKaJWZG7W3+Pv7sWFml7j1W4h000jrvuL1LRruKftE84ioxGx58dimEwLydy7AgAHcY11dCr5E8otOqo0ODNMYj+zs8BFsWM8i2yIP/q6gVd7sEr/1c7OhJlLWpzjmObntB01Rn5XJT4WJgfa5w3eauKXapf5nDI15k+v5ei8DhRxB7x8RgS3jBnAECe8UcQxDNBBzIWcMcULPteUKcoe2VrBj84OQE0WUKM0/iPpjS5KkXJ2HZVHtjWJo7X4PiK32VCxHGLAWIGOTZIhf8f17XNptcB5tbMUj+VWVAD7VOXmMd6nD3tX6GH0ckE6+fgElZ1U6IPi7zyIHCjYLj0qDE/iz+fxHbQ5EMNHTJmbT7DHxxKSuEerXdHj3ymFKvWOywcXUvpXAM112e9BYAEXITUg5aaeQKzHoUnVZzRuXj7XVEhaMCVr1E5mVOrGhicTTwxxOssJqMtYKU3v4kJzUcTzxq+zJ3/Nd0RC/cMI/MLL2l3scTXravvjGpE7CKGcweuU2aoTq8y1zMcRoD1QPpRQkJyGwyiFZv1vBxLiZ0aQOyX8tMcVPbGaxUNrublSqu6jJS0e+9g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(22082099003)(11063799003)(55112099003)(38070700021)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZHhPNXJWajUzMUdKazNmOFNxZ08wRjNBMm16VXIyOU83K0lERnRYaDEzNHJ0?=
 =?utf-8?B?ZVhpU1V0blhqa1FMOG54cmV3aHJzd0ZwVDl0TVFraVhGdklEdXpuWExsT016?=
 =?utf-8?B?eVAwdzdJTkVGMnhDNnVBc0MvUi80ZjZoNjdOc2w5KzBXMk42dmdsaE80dHo4?=
 =?utf-8?B?TnN5VHJsWENjSUZ6YXMzRmpIUVNjRUFTWEVyT0VacDlxRm1WL1VxcWNiNnFM?=
 =?utf-8?B?WjVBamFPMmNvVVoycmlRWEZmTGtkdDRPZko1TXdFb1NkSXhMbU9TVDFzUlZa?=
 =?utf-8?B?cWt1Y29ESVkwNkpiTzlmRGFTRnBMeFBXUTZBOHVVblg0L2VoMTZaRUtxM0pH?=
 =?utf-8?B?alg4akNHQXNiQS9JUXJoR2VNYkU5RXRVajY0MHQzSThOUlBqSTJiK2F0Tmht?=
 =?utf-8?B?Mi9CaG5IU0NrSHc1WTR3Ky9pbklRVFlLL0tnRDJhZmV6MHk1WjY2RVFLSWFG?=
 =?utf-8?B?MlV5T1FWY2NEY1Zha3gzS1hjMElmWGdNR3JoRnVUcW45Rzl3Ny9PclZvb0pw?=
 =?utf-8?B?a2U3TW9GQitTMG1NOHRTdGlvYjRwS2REbGt0cVA1ZDhBVnUxNUVlNFZEeXRx?=
 =?utf-8?B?ZVBqSmg0YmZtdk1ZamRweG5WN2VpSStLc2pKOVV6YzlnYjJlbXB0Wkg4RlBV?=
 =?utf-8?B?Q1BPY1V1M0h6STc2ZU5Bb2swQzd0dzNiSHBMM1U3SHorR1l3MmEwTVpmNVV1?=
 =?utf-8?B?YXVjWVpUVEhXdWZkbHZwMHkvWkYvb2pTWVArRVgrbFhUSWxrbmtWUTJBNFJC?=
 =?utf-8?B?b1NmVVFpcjQxalVSdnYzVGRzcUpsTk9vaGRyWEtwWDdFZFBtYkh5U1hmVytw?=
 =?utf-8?B?UVJ1WjNFZjg0cXJaY0NBZ2dReVlXS29LaVhWR2UvaXN3OUNZSG93YnZMdDlZ?=
 =?utf-8?B?S1Z3NTE5M1RWRUJ1TWhTUzE0RGFHNUUzbTVYWGNjY0JkMDVUSnJpeWN1VC8x?=
 =?utf-8?B?Zis3OFQrWXlMZU9EdndmYUdZSlBEcUVZTkZReWlKYWtXNDNhaVl3NlFxS1U1?=
 =?utf-8?B?bzJnQzFNdHNjcjIwNk01Wkh5RjRqY3hsaHAwUXBFN2JlRGxTSDFocW5LR21o?=
 =?utf-8?B?MnBPL0NyKzkxZkJRVWgwalcvTHlhOXJqTXVsTTROZUZJeWJVbVBCTHNIN3VC?=
 =?utf-8?B?N0dEYXpiVnJXanFxVWxVTDN6eEJPcVZsdm04L3ZIU1dxazNIS2NaM3RiQUNq?=
 =?utf-8?B?Q2FlVERYbUxSVi9GdU9VRkFRU3VMdi94ZTRoOGU5ZS9LcXVYOXA4WjlYN1Iz?=
 =?utf-8?B?VERxUExzejVwNUlzYmxYZTY2UjRCTURnd3NoUnlJaG9QbHQveWxacEJGTlBX?=
 =?utf-8?B?K2pYdFE1NWJPUXp4MkVtS0RqcmRXL2Y3L1ZyNmM0KzVqeFJDTk51czhydWVQ?=
 =?utf-8?B?TDRmaUluUHgxSDJsb1l2NGU2eFBRQnRBSEhMMlVJaFVNZGRZZXorTjFYTTZ6?=
 =?utf-8?B?ZVJ4T0dST0JIQy9SM2ZsOGp3L0tWSmxaUlR2RXppdmlLemtzdUkxVDZ6Vncv?=
 =?utf-8?B?NTZRdGJJa1IwNmdMNEtMcG9WcHhZU21SVFltNm4yU0RYRGZCczBUNTdrZ0pi?=
 =?utf-8?B?YWNIZDdoUTdiKys1MXZlWnZTczdTN0Zwb2RrN2NVRnRmUkliRVNCWFpWemJY?=
 =?utf-8?B?eTRPZmt1Ni9KdXVROHdTQm9uQ1RQZjFSMnkycXBuQWRJK1BzOGdmVnBMV01P?=
 =?utf-8?B?MG1najlyMnFSUXdPUFd2bTY5STdIRmswcUFhNnFENVBtWEFzQVJwVkZEYk1u?=
 =?utf-8?B?bnIrbVdSMFZCT2VsS3JBRWlFS25SS3lqQWdtWWtvZ3lDUFpudTVEN3Faa25N?=
 =?utf-8?B?RHZ1Wi9uSEluYU5qdmJFTVR6Z0hDL1dlYmE4Uk5wYUtRVGsvU0VtcDhRSm9V?=
 =?utf-8?B?bGE4SEVFWDFJekE0YXNINDBDRTIvdjNLR2lKS0xySnZHZFh3eGxEQ09acnAy?=
 =?utf-8?B?N1BSYXh1ZkUxcCs4NXFtNk0rTFY2ZnZMQ3g3c0RIcllIR1FZN2daUGxqRUor?=
 =?utf-8?B?K2hGR0ZsNmloQ0RNT0xPdFhBTmwzZ2hhWExXKytVcG5FMWdmWlV6NGZVdVg2?=
 =?utf-8?B?NDBIelBtVDdJVm8zT2pmc0ZqMXAxNUFPdVVFa2ppNDRxcmhWUGFadjNuanYv?=
 =?utf-8?B?T2NDOEo0VWF3MU1ETWo0MEFkby94Y0R4Yzl0TEo5N0tvdlRrb3dZb1VEbXhC?=
 =?utf-8?B?Ync3dnNYeTlmZCthdE1oL2p4S0xGMjJ3VHBwcml5MmhzUzZteThjblNKNWxV?=
 =?utf-8?B?OFAxWmhoS3dCTjNQc2V2TnN5YVc4elhWN3dKZm1nbG5NNXhpTGNLY245MDQ0?=
 =?utf-8?B?b0FFVVFKOFNacDB5ZWFFTzRQenhTdjhwdFQ1dVoxQzNselh2c0pHOFdSc01r?=
 =?utf-8?Q?9MdfDtngqVvBm064=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DAAA081354827A44B1650458344956A2@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 456f29b7-d5a6-4f9f-459d-08deaffa72a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2026 07:45:33.3152 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9WMpn6YtzbdcacONNR7ZgjT918+kmdjyqWLRSyT6bHOAYdHl4G33p3zLnx7CVm98XwLL8EVLzvab3wrFD2JxA4SyL4E8qGfJ/2eJbYFP8N0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8791
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

T24gTW9uLCAyMDI2LTA1LTExIGF0IDE0OjA5ICswMjAwLCBBbGV4YW5kZXIgRmVpbGtlIHdyb3Rl
Og0KPiBGcm9tOiBNYXJrdXMgTmllYmVsIDxNYXJrdXMuTmllYmVsQGV3LnRxLWdyb3VwLmNvbT4N
Cj4gDQo+IFRoZSBvbGQgY2hlY2sgYWNjZXB0ZWQgZGF5IDAgYXMgd2VsbCBhcyBGZWIgMjl0aCBp
biBub24tbGVhcCB5ZWFycy4NCj4gV2l0aCB0aGlzIGNoYW5nZSwgYm90aCBkYXkgYW5kIG1vbnRo
IDAgYXJlIHJlamVjdGVkLCBhbmQgdGhlIGxvY2FsIGRheSBsaW1pdA0KPiBsb2dpYyBpcyBub3cg
aGFuZGxlZCBieSBydGNfbW9udGhfZGF5cygpLCB3aGljaCBjb3JyZWN0bHkgYWNjb3VudHMgZm9y
IG1vbnRoDQo+IGxlbmd0aCBhbmQgbGVhcCB5ZWFycy4NCj4gDQo+IEJlY2F1c2Ugb2YgdGhpcywg
c3BlY2lhbCBhdHRlbnRpb24gbXVzdCBiZSB0YWtlbiBpbiB0aGUgJ01NRERoaG1tJyBmb3JtYXQg
Y2FzZSwNCj4gYXMgdG1feWVhciBpcyBub3QgaW5pdGlhbGl6ZWQuIFRoZSBsZWFwLXllYXIgY2Fs
Y3VsYXRpb24gaW4gcnRjX21vbnRoX2RheXMoKQ0KPiB0aGVyZWZvcmUgZGVwZW5kcyBvbiB0aGUg
dmFsdWUgcHJvdmlkZWQgYnkgdGhlIGNhbGxlci4gVGhpcyBpcyBwcmUtZXhpc3RpbmcNCj4gYmVo
YXZpb3VyLCBidXQgaXMgbm93IG1hZGUgbW9yZSBleHBsaWNpdC4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IE1hcmt1cyBOaWViZWwgPE1hcmt1cy5OaWViZWxAZXcudHEtZ3JvdXAuY29tPg0KPiBTaWdu
ZWQtb2ZmLWJ5OiBBbGV4YW5kZXIgRmVpbGtlIDxhbGV4YW5kZXIuZmVpbGtlQGV3LnRxLWdyb3Vw
LmNvbT4NCg0KUmV2aWV3ZWQtYnk6IEFsZXhhbmRlciBTdmVyZGxpbiA8YWxleGFuZGVyLnN2ZXJk
bGluQHNpZW1lbnMuY29tPg0KDQo+IC0tLQ0KPiDCoGNtZC9kYXRlLmMgfCA3ICsrKystLS0NCj4g
wqAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2NtZC9kYXRlLmMgYi9jbWQvZGF0ZS5jDQo+IGluZGV4IGQwNDc4NzIyODlj
Li5iMGRhMGNiZDY5YyAxMDA2NDQNCj4gLS0tIGEvY21kL2RhdGUuYw0KPiArKysgYi9jbWQvZGF0
ZS5jDQo+IEBAIC0xNjcsMTIgKzE2NywxMyBAQCBpbnQgbWtfZGF0ZSAoY29uc3QgY2hhciAqZGF0
ZXN0ciwgc3RydWN0IHJ0Y190aW1lICp0bXApDQo+IMKgCQkvKiBmYWxsIHRocnUgKi8NCj4gwqAJ
Y2FzZSAxMjoJCS8qIE1NRERoaG1tQ0NZWQkqLw0KPiDCoAkJaWYgKGNudnJ0MiAoZGF0ZXN0cisw
LCAmdmFsKSB8fA0KPiAtCQnCoMKgwqAgdmFsID4gMTIpIHsNCj4gKwkJwqDCoMKgIHZhbCA+IDEy
IHx8IHZhbCA8IDEpIHsNCj4gwqAJCQlicmVhazsNCj4gwqAJCX0NCj4gwqAJCXRtcC0+dG1fbW9u
wqAgPSB2YWw7DQo+IC0JCWlmIChjbnZydDIgKGRhdGVzdHIrMiwgJnZhbCkgfHwNCj4gLQkJwqDC
oMKgIHZhbCA+ICgodG1wLT50bV9tb249PTIpID8gMjkgOiAzMSkpIHsNCj4gKwkJaWYgKGNudnJ0
MihkYXRlc3RyKzIsICZ2YWwpIHx8DQo+ICsJCcKgwqDCoCB2YWwgPCAxIHx8DQo+ICsJCcKgwqDC
oCB2YWwgPiBydGNfbW9udGhfZGF5cyh0bXAtPnRtX21vbiAtIDEsIHRtcC0+dG1feWVhcikpIHsN
Cj4gwqAJCQlicmVhazsNCj4gwqAJCX0NCj4gwqAJCXRtcC0+dG1fbWRheSA9IHZhbDsNCg0KLS0g
DQpBbGV4YW5kZXIgU3ZlcmRsaW4NClNpZW1lbnMgQUcNCnd3dy5zaWVtZW5zLmNvbQ0K
