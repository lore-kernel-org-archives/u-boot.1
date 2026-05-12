Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02616CD484E
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 06:26:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 741A680F0E;
	Tue, 12 May 2026 08:26:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="SRSmuI60";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4992D80F0E; Tue, 12 May 2026 08:26:35 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B909801A9
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 08:26:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=upVbn0mVQOMsDfAJQHFrOfndM5pGGxmhwAMccId7NtaM0g+SSNl1vX0ZfhoL5baaQhOpfRictN8i4ZkKKqezpBovYVtu0Xx82BxTxVQderaKyacK6+TXhOTHEOt5XwnTRBJ0IBf2lHXmjQLHLgyXgq+jSYWQdz54ydHdil5C6ydgBbB+m5CQ3vr6p3vzL8mkl3Dg/+2v8faR2Lr8LB1KjvWNis6AL2svfcG+YYg3bt7a/4VNQUeg/Zxz7+tV9gwYDAKPmSOEepVA8YBRq/2xBx70xaiCPZJgRpbuWxr9idXk39LEak16NYNOZQ9PsSMI+yfqu8I5ZsOdo2b+ntA+wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LjtAwLhDz15kZywBQS7iV8YlK95Kc6IXGKoKVKoVi9c=;
 b=D6GLomL9ktq91ID8br3PM96xxPntor2Uy6ZUolpkVm2sBnqdtlrWlbyG1mnBXCf7PJbDZ2TzQqSAa646tpizmLRLY0SlUzy2LONGyjtcF+RjkqfhwXqYirn1gVVaHyomkrqKB2dwyRQWHMhwI7ZvjkWMq9PU/gmtda2Xj9hSXc3BN3KwIWto80BGbVdMiWTzhKR5xxMFguoWPLlw/GWPxeK1ldIE5SzrU3fwm8AnFogRHev4scfVSOC98FXQT40GHVMhIQz+4K2CfqSklun84Gz7+OvRq7kHshBAgaYEwpmOcn8WWzpPL57B+5Ly6p6QTa1Tz/AxEcF5hLs0BnoLHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LjtAwLhDz15kZywBQS7iV8YlK95Kc6IXGKoKVKoVi9c=;
 b=SRSmuI609BmwNsEc/C6z9swEiH+EiJEnDRTx4YqYOq9o+uGqGpNEB0qyARabOLTFC1dj27GipS5F3I4iz4r/9xfmK+03XVddmboMoVDzXf64kwWOAxEcyr4wdKi+M6rhwqqmRfx7EMnC9WGIte4s9fGMUMt/OdkumXjyr0/oBSSQCF5nR+6XpRE4GcFKpWQAUAS0zPM7lVR9Ua+9dAYiRX97DvNpXrM11heYWyCQU2GFPlqDtkYeP9dm/sw6EW3ZHS09G6cONNq1j9sEIlJArbKcFQ0l2iPEthGYdGXTtEJRq/YUffaLckhzY8ASvZLm2vzCgoNXAil63edRN0NPJA==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by DU0PR10MB6132.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3e7::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 06:26:30 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f%6]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 06:26:30 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "anshuld@ti.com" <anshuld@ti.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH 3/4] common: Make TI K3 get_reset_reason() a weak global
Thread-Topic: [PATCH 3/4] common: Make TI K3 get_reset_reason() a weak global
Thread-Index: AQHc4YKb9MZBveXSf0am7V8AnD+6L7YJ5EuAgAAJOIA=
Date: Tue, 12 May 2026 06:26:30 +0000
Message-ID: <020438edd510622b84a23bbea23ab2c48cd9a4ab.camel@siemens.com>
References: <20260511201235.1066697-1-alexander.sverdlin@siemens.com>
 <20260511201235.1066697-4-alexander.sverdlin@siemens.com>
 <177856520968.106112.14841185343946056117.b4-review@b4>
In-Reply-To: <177856520968.106112.14841185343946056117.b4-review@b4>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.54.3 (3.54.3-2.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|DU0PR10MB6132:EE_
x-ms-office365-filtering-correlation-id: a084aa0a-a42b-4fbe-cccf-08deafef677a
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|22082099003|56012099003|11063799003|38070700021|55112099003|18002099003;
x-microsoft-antispam-message-info: gg5WLuZFNlDQqjGbrY9LUufNtiB847HESbf8nn7bVC514Y1s7+xcXsse0Kull0YiFPbPcZID53jHrFSWkwqRM1qZGhUtAgvfs4St+VaQYEkknS/wt6JE+h3GnxyDd4v9VLpzbtYq9JsR4yn6fimUGzdVX/0wmC+BuGKNcqPsFjhmekLeJupmQGxC4xUyKV7PnTMUUQNU29BH/P8YF3e64Sl92oVKwSKo5kqexOdyRNhYCX539MsjTEZPo1TIKtyWdFFJwWQqUv1RStuWCLj/KNbOAUe5agWUYkfVhJ/tKP6myVu4jKy+B7akec8hSl/TkGqTtAuflcNQllIb4+3xPFe1kmxTsOu46hTLCB48yoM4yHp2AA+XR9almwl3yoJdh9q/Sm+FjfPIuaSfGxgf0teJy1LVh3qxvj4vTVCQCvBAw77DLmRjfCN4Pg9ow5Cm6PT1g4vB2ihzu+ttJCf01RjMFwkBgh2Vn6Bma8feLeL8Gk8+Z+6UikerxS221JMw89CGcdWZ9ZST1MlGeCRoaoIiTFqPgf25veqp5l/6iYzVNk87wXgGGeX5OXehTmQCF6+2DwCUYAETKzNTK5rAm9TiNKOXICt3g52/d2PHt8HP16MwCLn79XiSxTtm8xcsof79iqEH59vQmf83TIzE9GVqqMnpmb6AO77ef6RM9nj3UZOEzmobaG5Te95uZ2Vq2C1lUqHYH7IzJtKEQIAf+A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(56012099003)(11063799003)(38070700021)(55112099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RmJzTk9SN2pzUDN4WlZTL1U3K0ROMHFaYUxOeDU3L3BWbFQyOFlHdmJXVWRk?=
 =?utf-8?B?NnVOaDR5bjFXQzVKM1UxNCs0UUdCQVl3QTNKRjNxT0s0bUN3N0k2Zlp5cmlW?=
 =?utf-8?B?SW40WjYvME1zQWt3UUkwWkFYTGg0RzlVYTVQVlZ4NnFuOC9IZzdYcDFpU2NZ?=
 =?utf-8?B?L2V1V2tIQ0FWL3pTcjZEd3BCWFZnSmNxLzA2b1F1bHBBNk1WTmdIYjdzQ2JU?=
 =?utf-8?B?VFpXSXR5Z1lraHlRcTlNeVo5OWJNa001NWs2c3FlVnF6WXhpbVFvQUJVL1l3?=
 =?utf-8?B?Wlk5V0RmZ2NLOXpaQXlNYjg1dzU1ZDQ0NGdaSC9SdHFlSGw3d0JZWGl5RVkx?=
 =?utf-8?B?b1czSkZINk5ydWlyWldkVStybDBiWmxxRXV5NW9sTnJsRE5FRFRnRlFyblNV?=
 =?utf-8?B?Smo5R3g3NFpFVEhLSnZXMzY4SEFKbWh4TXVsek42RjhuZXQveHViWXFQQ21D?=
 =?utf-8?B?VzJFRG50SXYrcmhLaVgzMGZPVFZZdzRndGdqL1FETjJ4TUYzY3laWXl4R3FZ?=
 =?utf-8?B?NGs3QXF3bnVGc0ZoSEMxdVBDS0p3RldLbG5odHQxbUhpbjZpNldLSDg1ZVY1?=
 =?utf-8?B?Zi9POEVBMzZIMjRvaWlRTGhtTkc0WDE2UmNldUNMRVpkTllCWDVqNThJY0cy?=
 =?utf-8?B?N2xLVk5HNzN6TW1Ca1locHVkUEZ3bDN0Z0p6bHpvZmN1OTBSZndTS1E3U0My?=
 =?utf-8?B?WmJzUjBXU2svaUxtYW0xY294QkFvM0UwZjRKOVNId3pIc0xwdExUNk1SVHNE?=
 =?utf-8?B?TVhxWGZIaFBCdVMzMlpkQUNSc1g4Y1Iyd3FoVmhIT3J2THZIb2pNVXc5UDZM?=
 =?utf-8?B?Rml4OFI4VWFSOFpxMUtDNFM4cmhkMHpqNnJzOHNtUms0YXl0YnNvTnZhTGNS?=
 =?utf-8?B?M3A3UEVybWdQVFlKRE1odnMzZXBzemk3aFNST2RXaUJjMFBuNzg1b0dITCsw?=
 =?utf-8?B?SlVNNVgxOE5HTk9xaDF2eXIzVkwycnZndmZiWFZkSGc4ZnN2bEZWdjBtWUFU?=
 =?utf-8?B?aXNyaUdsNVhyVkcvRGV4Z0lqby94U0tJY1B6R0kxSkRNclZxV0prc3RjbCtn?=
 =?utf-8?B?dm4vOS8rd2Nja091OTI4Mk1FbU5kT2ZxRHlSN095STliNGcwM1ZhT1RRVkJR?=
 =?utf-8?B?UThncExkc1p2aGsrdDNLZC9TUkVSYytscjI1T1dOdFpjRS9GMzM1WXVYcnda?=
 =?utf-8?B?ejRGcVdmL2gyQzBBcTNEWjBMeVZhbFhER3JWU0JyMlpOcXBhcGlYNFpVbHRM?=
 =?utf-8?B?SC9xNWxoZU9hK3krYTg2eE5CUFQrdXkwbytSc0hSdjZYY09SUE1sYUZrMGJD?=
 =?utf-8?B?K05ibTZocmp6TjNKcUZQa2VCVXBrMU5jMlRhOG8vVERpN0tmaDR3WkFFamIx?=
 =?utf-8?B?VjhydlUwVDI0eEdmaXplWS9SaFFjR3dLWXFwVEJtaW51cTk0a2IxRmZxbm4x?=
 =?utf-8?B?M1ZKdHRNN0FOeERwWWszUlRrQThoMTdPZWxEdUdmVks4OXkrRVBIWlcyWFVr?=
 =?utf-8?B?cEt3ZEdWYWFqWFFCR09HZ0UrdUFhK2l2TFBqaU8zakZJdU1PUWp5NHFkbEtB?=
 =?utf-8?B?bEF2b01ldldZTzYyaGtlaFhBc2NxUmZZT0d5VzhnSEdWU2xlNU5pZFNLYnR1?=
 =?utf-8?B?NVZJeHh3em1scS82bEpYY1d1UUNJd0IzWEM0ajdPWW9yUWV3cVRUZlBNa3FW?=
 =?utf-8?B?TlM5UVp5UlNSNVB6bEdKSlVlanBCMWh5MGRORFo1eENmbUpLa1FCV050ajRK?=
 =?utf-8?B?TVpacTArQklzbE5zQmRSVlkyY1JPRXZ2ZEFwSzFWTWFDREJzYU5KaXMrNkk3?=
 =?utf-8?B?M2pUR3NLU0tONTVpM2t5cFFPOWp2eXlIL0FXalRPL09uQjR6M3BYOHBZTk90?=
 =?utf-8?B?VVlHemNET3ZEYmQ3a3RnRHZWWEJoYVRTbFlGWkdyWXl6ZjA1ZEtEOE80WTI2?=
 =?utf-8?B?SndRbWFaanpZWjM2TURJZVR0N2djckZvdkFCT0t3QkQyTlE4UWZWOVlQMmxi?=
 =?utf-8?B?c3dzSmNWSTkxekpVclliWjl0N2pMUWcxdTZsR0RpOGl0WUMvaFpjUkRWQzFx?=
 =?utf-8?B?RE92YVBTMXk0RE41eTkrNURVYWdTUitVczk4VytWdVB5MDQ1MVlRaUlCQkll?=
 =?utf-8?B?Q01IUGdxK1pJVGtmbTZ1bTlPODRuTElWbFVoYlFXUmJ3bVMrWXRYK2ZveHRL?=
 =?utf-8?B?WTRmY0QrcHdLK2wwQXRmZWpKejF3SUhiSDZLR3ZTZUdFR1QyWWdRSXBpQ25G?=
 =?utf-8?B?WEJSWWZYVjliUkhwQ2ppQndSSHhOcjJ2clFPdmhla3V2RXQrU2tHRStrQTBO?=
 =?utf-8?B?U3FwM0xHd3k0SGpFd2kyazBFTDhKQWkyUlB5RGRwKzlYUmFxbEdCeGpiS25Y?=
 =?utf-8?Q?DU74XP7GNA0ihDt8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8592DF38E5A12A45B959697800F0E410@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a084aa0a-a42b-4fbe-cccf-08deafef677a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2026 06:26:30.1152 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iT3CPL+7SG66KohwHfnTyri/lmo7KmiIsmwd6VYBA0FoFNQLHhNEd9QmooFyZxylyBZRxpEHtLxDHXYG+AggtY2EcFNOt0g/SH5dhryhzDY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6132
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

SGkgQW5zaHVsLA0KDQpPbiBUdWUsIDIwMjYtMDUtMTIgYXQgMTE6MjMgKzA1MzAsIEFuc2h1bCBE
YWxhbCB3cm90ZToNCj4gT24gTW9uLCAxMSBNYXkgMjAyNiAyMjoxMjozMiArMDIwMCwgQS4gU3Zl
cmRsaW4gPGFsZXhhbmRlci5zdmVyZGxpbkBzaWVtZW5zLmNvbT4gd3JvdGU6DQo+ID4gZGlmZiAt
LWdpdCBhL2FyY2gvYXJtL21hY2gtazMvYW02MngvYm9vdC5jIGIvYXJjaC9hcm0vbWFjaC1rMy9h
bTYyeC9ib290LmMNCj4gPiBpbmRleCBiYWU1M2YxZTQ1OS4uOGM0NjUzMjExM2EgMTAwNjQ0DQo+
ID4gLS0tIGEvYXJjaC9hcm0vbWFjaC1rMy9hbTYyeC9ib290LmMNCj4gPiArKysgYi9hcmNoL2Fy
bS9tYWNoLWszL2FtNjJ4L2Jvb3QuYw0KPiA+IEBAIC0xLDQgKzEsNSBAQA0KPiA+IMKgIC8vIFNQ
RFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wKw0KPiA+ICsjaW5jbHVkZSA8aW5pdC5oPg0K
PiANCj4gQXJlIHRoZXNlIGluY2x1ZGVzIG5lY2Vzc2FyeSBoZXJlPw0KDQp5ZXMsIGZvciB0aGUg
Z2V0X3Jlc2V0X3JlYXNvbigpIGRlY2xhcmF0aW9uIHdoaWNoIGlzIGJlaW5nIHJlbW92ZWQgZnJv
bQ0KYXJjaC9hcm0vbWFjaC1rMy9pbmNsdWRlL21hY2gvaGFyZHdhcmUuaC4NCg0KLS0gDQpBbGV4
YW5kZXIgU3ZlcmRsaW4NClNpZW1lbnMgQUcNCnd3dy5zaWVtZW5zLmNvbQ0K
