Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 938E4CD1292
	for <u-boot@archiver.kernel.org>; Mon,  8 Apr 2024 18:37:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3644788145;
	Mon,  8 Apr 2024 20:36:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=aeronix.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=aeronix.com header.i=@aeronix.com header.b="Ku+0v95u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEA02880A5; Mon,  8 Apr 2024 16:14:13 +0200 (CEST)
Received: from USG02-CY1-obe.outbound.protection.office365.us
 (mail-cy1usg02on0729.outbound.protection.office365.us
 [IPv6:2001:489a:2202:d::729])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6715B88074
 for <u-boot@lists.denx.de>; Mon,  8 Apr 2024 16:14:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=aeronix.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mrainey@aeronix.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector5401; d=microsoft.com; cv=none;
 b=UfbCcqfBRTxN7iFS8gnsg/vdxhp0xvVwPHrxbiEGZgIsjn6VG9lSIlSvJHYEMa6hJtj5lMSquo7Jro9VwRriTy2xh6MrqIbys256/BrwRighFeepN26Nr9r6AzTIsCDIeBfPugupm6nKmw+bHwp+QOi6+sn64L22zOc7jNq3d9vNL6dPKofmrDzRXqfMbPon2vU3TxzYniL0QKIGyPaH5tDQmar63lxGGNjuSGeyWaIly0kHfyCHDFUP9fwWK+FjiYMN12hoTYX0XKaUCks7I1KeiIso8AL2b4CB22Qql62E3ijAUV+ozISaAsvnZIIfvFAwI3DIWtyGrHpJLsAt4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector5401;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L48mGcJ54x6fTgUkdEduZnpTbwvT8Fk1LWHmV33V0iI=;
 b=qMRWTmWS4EFWNCy6vMzW2rYuqPfFxotIhqRII601ZuQpxoxYV2eQx4RcJYLzR4LKkwxnCt5xi2tOvTWKaCLcLZgCJvP69pwG3UiPvIA7G8r5/iCl1qpgtSH1XPjhEtsQKUNcKcQVNrjayHWItNLjJgL5k8jx0KkHibzbI8exHEpEtbCI6PGWMwV4Obl36RcitLmhrHVqWODbn7fKDM8dRl1PVU+b2oyfsyfsml/x0PcGrieCK0MUZ8EXseE3kcqpelnO3pmioUjS5QiycE9YwzcNTma5wNoSouEeZ7W5hIn7+hcj91VrGCG9/9NNj+eT66fLU+CGXsaRx+k42nFe+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aeronix.com; dmarc=pass action=none header.from=aeronix.com;
 dkim=pass header.d=aeronix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aeronix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L48mGcJ54x6fTgUkdEduZnpTbwvT8Fk1LWHmV33V0iI=;
 b=Ku+0v95uoAxRBMG/ARDdITDrJirmVZR+KG2YE+0vZC9W3jIxOtwMTfAcrq4J8vvytld3Tt6LyKagDscV1Ddr7knTTLfA/DBF2rj6Z+so51m8rMloUrEg3FSK2OQkn1mwRwfT694QEo/gJ9nGPdErhm32jzogcO4xoYzkQY9SgKn7zY5ZTZDlBByqtNoUVjzmYnscWtQjOkfBnFpxfFrBmQgRAbM6AQIh1Z+Zhxu3TMdw26ueejTOVl3PlBQrXmcnogAjeys7BBQlYEmdT0jAcNfOexH2f1vUqki5pgRc2O+4pqEcp2IYGEery8jhZOdaDuKs0TSBATSV1+NYSmfMqw==
Received: from CY1P110MB0920.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:14a::21)
 by CY1P110MB0726.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:14c::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Mon, 8 Apr
 2024 14:14:05 +0000
Received: from CY1P110MB0920.NAMP110.PROD.OUTLOOK.COM
 ([fe80::ed26:2260:8a79:d86]) by CY1P110MB0920.NAMP110.PROD.OUTLOOK.COM
 ([fe80::ed26:2260:8a79:d86%5]) with mapi id 15.20.7409.053; Mon, 8 Apr 2024
 14:14:05 +0000
From: Matthew Rainey <mrainey@aeronix.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Issues reading large files from nand ubifs ARM64
Thread-Topic: Issues reading large files from nand ubifs ARM64
Thread-Index: AdqJvnmeB3VXHsR2Qz+2l51IoDFtGQ==
Date: Mon, 8 Apr 2024 14:14:05 +0000
Message-ID: <CY1P110MB0920FE308300F8F69313B119B600A@CY1P110MB0920.NAMP110.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_02736c20-5498-4b4f-a78c-11e6c0248834_ActionId=073580ca-52ff-4824-b7fc-a74c1a943f08;
 MSIP_Label_02736c20-5498-4b4f-a78c-11e6c0248834_ContentBits=0;
 MSIP_Label_02736c20-5498-4b4f-a78c-11e6c0248834_Enabled=true;
 MSIP_Label_02736c20-5498-4b4f-a78c-11e6c0248834_Method=Standard;
 MSIP_Label_02736c20-5498-4b4f-a78c-11e6c0248834_Name=Public
 - No Sensitive Content;
 MSIP_Label_02736c20-5498-4b4f-a78c-11e6c0248834_SetDate=2024-04-08T11:14:55Z;
 MSIP_Label_02736c20-5498-4b4f-a78c-11e6c0248834_SiteId=825eadac-5e35-4ca7-a5df-7aae43ed5741;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aeronix.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY1P110MB0920:EE_|CY1P110MB0726:EE_
x-ms-office365-filtering-correlation-id: c21c8886-50ee-49a3-5b50-08dc57d625f2
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UJLgo0sjDzQ2YAE2+6yw+sWRxfCa+X2JquA5ZUtFXy56KIbk8wGGpNaa5pX5400GcHMPzw/HRwEHhfydPDc3znjq59QkKBUY19yLWQMZZwJeYqBoscq26MCoLE4bFprw6+fXU5K6ffMyuNvBLplJipwP8viMHSP8hxKeMB2E+olSSq7x9eI3P8gyXruryJVVtcXPnuhLxpsT64P+hRmzZ0JqghGWVF1TN0bckMNE7GFAYDVUZokK5WldcMI641z77gwc3WWj1o5UgT48bgAnFcpMMM54UG8t2lQk5oTnaVCnt6nYoUQMzV1Wwo8Aht4bF0w3mJxRb1uO1PhDIZN/r7PTrew1ykNc1i/QOt3K0BdIozt/parSZI6/Z3j9v5z7kuGEWWGIOEmsRiIke2iPV7HkHYJAG8ZNFT3fH9gnOAmpnyHnburQACrlp1hFVaMz8QTH5OKZyL2Q//WQrOsGv7lUUbe/ZKQUsexUQEl6xMXdJ01kVBDLJEKhGwPOyxnOuHCUuemP+A0CFY/QQjb65z3l2DL1R9R8JoXpsBJ4PznnHd33zQB2kh0u+GNjs87NXkwSHFgDrrzrO+PctM/oPmHI6pN80YWfy+I4iE/b9V8oNBNE25WJxtw+nl4iNqqmrm2mEvQTTNJiTH6jCZXYSycytnPAuZ/vReGvIj/2HpE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY1P110MB0920.NAMP110.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(41320700004)(366007)(1800799015)(38070700009); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YzNaMFA5a0ZKVk5NWU9MMzNQN3hOZ1UwWHd1aVVBYzJHWFZEZERXRmpTS0JQ?=
 =?utf-8?B?bitKRmNyOXViei9GRktWWkxMd2lPU3MyRjNVakZXQ2x3NGtMZ0xNOFBkUlZX?=
 =?utf-8?B?aUlncHBzZGJhTjFFU0NFZVp3Q3JCQTJjbzdqS0ZVdmp2WEFNRENMbmtESGti?=
 =?utf-8?B?dkhXZG9HcXMwL0NHNklxZHBhUFlCS3NRUFRqelc4M0V3ZWVBaWw3bzFnMzNC?=
 =?utf-8?B?RWNuZFV2cndNYlUzTHNKT3FPQUJOVGw3TkxjTHpFNU51T1pmSzBCK1lNVy9B?=
 =?utf-8?B?eWZ5aVVTeUw3MVVueFJFaGFIU1NVcTZxb09HUXZqQm5aWUZ1SkEwY1lBMjJq?=
 =?utf-8?B?QjluSFQrZ0pQNm5kZEVjRjdjN1NSSlZQM21pOUJQQ0tHYmxnNHJDUHhEajI2?=
 =?utf-8?B?Mlp1dzZSb2tIaHFoYWJ6WCsvZ2VKei9CSXVtK1BHNmx5NjErTjR3NjVKYW1F?=
 =?utf-8?B?M0l0Ym1RTHhZWkJwRDd3dGMzNlBRTmtYbHg1cmpuQ3h2Zm9PWnlsbUlnVTNq?=
 =?utf-8?B?eWhWSUd1VS9mS3NUR1czdGVoRFVvOUZ4SXRmUXFMQml6ZjBqaDgrTTZ1ZWZv?=
 =?utf-8?B?NHV0NnBVQk5QbVloYS8rbnEzeEhPcnl0RFlLSnhOb1ZNQk5PNFUwUDNUdEl6?=
 =?utf-8?B?Sklsd2wreUZBWjIrN1Q4VkcwUGJ6aEQ4ZWoxd3p2TXFFaGVPTXl2VTU4OFZJ?=
 =?utf-8?B?dGNodUlZMkFWK0JqK1NrdEUzY0RBdEY0d281MENPUktTZW1CeG9hYlVOUW5E?=
 =?utf-8?B?dk5KVDBuUkJvZFVOVllFZm9DYTZnZDVMQ0IyWTRleEVJSlZPaHVMKzhCM3RK?=
 =?utf-8?B?enZreUVMVEQ3R3JvQ05oVVpiN2NNNFl6Tk1pSGNUeXkzSHcyWkVYemQ2RHNN?=
 =?utf-8?B?QnU3RFA1ajJjZmpGMHo2NjYyR0VCMXFlREl5VzVlNzNLc0NOUnlOcHZabDds?=
 =?utf-8?B?cnZvMHhiRkJjMVQyS2tPVDdhTzd2Z3ZRUjkvZ2haR3JuWjNXSDZuUStwT0Ni?=
 =?utf-8?B?MXpiaHMwaHR5R3FBdWgxWjRjSUZWRGYrVHNSWUJOdEV2dWUrY3pYa2hueWp0?=
 =?utf-8?B?OHhETkhhM21EWEJNTUlaYjF0ZHR3cVJLTUxKeDRMT1VXVVI1NjZjMFRudkk5?=
 =?utf-8?B?MVIrMEdSTW5razI2MUl5RXNrS2NKNTN0ZmZlekRLWWxlV1RmNFJTN1Y2NFRF?=
 =?utf-8?B?akZZVFhLK05PczdzWW5YK1YwWU9KM1hoQ0psRERudVRTOXJFTzhCcnVVbGcr?=
 =?utf-8?B?SEEwK3NiZWg2VUNoWWk4ZHUrOUtKK3ozRE1HZ01WUUtuVUhoa2ZuYkdDcVJ1?=
 =?utf-8?B?Y0YwaUNXdjhQRVlCMGhSMzBiNUFOdTM3N2NyUzF1THhkTC95SGx0RndBcmY1?=
 =?utf-8?B?bEFJaThtUjE0ZTA4NnplVDd5bWN4emh0b2FLY1hRM09IUmk0Vnh1WStpaHI5?=
 =?utf-8?B?WUdqNTFCcjJuczFVRkZuYlp2cXNMYVBCM25nYlZEZEtSbVAzQVNJRGw3NGFw?=
 =?utf-8?B?Nm01YUZxSDIxbFREeXlJYzhUSE9yUEpWRW9mWHpIeUE3ZEdGMWJNTlhwU2Rz?=
 =?utf-8?B?bXNKYW1yaXJtZW9vK1RpdjB0cUJ2Rzd3UDU2L1FNYXdPczlHS08wMWZ2Yk1x?=
 =?utf-8?B?SUY2dEVVam5yT1hCNFlNQUNTemorcmxEczgxSllzbjFVdndQbUx2c1d6c0Mx?=
 =?utf-8?B?eWhMT2loYThIb1k2bWwzT0JvZlJCcFpUL0Nvd01Mb0tJK2lNZGx5NmgzZ2dO?=
 =?utf-8?B?MDhJUXlVRGtCOHRHMERtSjNXb01PNHpxeXdFcDhDeUR3MFg5NHQ2MUdOV0xB?=
 =?utf-8?B?aTR2Q2t6MjNNaEFucllZaWc4ZEZZSnVqOUllVEpIRW5aOEN4cTVpWTFmT3lZ?=
 =?utf-8?B?Y0NoOTNRZHB6REhFdkozT2tPTm9XUGRoNm9uUGxOellaTnZKd0o3UUlTMlJ5?=
 =?utf-8?B?MnVWSjZ6NXRjTExaSzArSDhSMlVzQ3V5ekxaVlF4dXZHMWN0L0E3OG9UVGVl?=
 =?utf-8?Q?NRfibm+o/II9hp8LxGiYM1wYRCGa/g=3D?=
MIME-Version: 1.0
X-OriginatorOrg: aeronix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY1P110MB0920.NAMP110.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c21c8886-50ee-49a3-5b50-08dc57d625f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2024 14:14:05.0641 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 825eadac-5e35-4ca7-a5df-7aae43ed5741
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1P110MB0726
X-Mailman-Approved-At: Mon, 08 Apr 2024 20:36:16 +0200
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

SGVsbG8gVS1Cb290IGNvbW11bml0eSwNCg0KSSBhbSBoYXZpbmcgaXNzdWVzIHJlYWRpbmcgbGFy
Z2UgZmlsZXMgKH4yMCBNaUIgYW5kIGxhcmdlcikgZnJvbSBuYW5kIGZsYXNoIG9uIGFuIGFybTY0
IGRldmVsb3BtZW50IGJvYXJkLiBTbWFsbGVyIGZpbGVzIGxvYWQgYW5kIHdvcmsgYXMgaW50ZW5k
ZWQuIEkgaGF2ZSB0ZXN0ZWQgdGhpcyBpbiBsaW51eCwgd2hpY2ggYWxzbyB3b3JrcyBhcyBpbnRl
bmRlZC4gSG93ZXZlciwgaW4gVS1Cb290LCBpdCBnaXZlcyB0aGUgZm9sbG93aW5nIGVycm9yOg0K
DQp1Ymlmc2xvYWQgMHg5MDAwMDAwMCAiY29yZS1pbWFnZS1taW5pbWFsLWxzMTA0NmFmcnd5LmNw
aW8uZ3oudS1ib290Ig0KTG9hZGluZyBmaWxlICdjb3JlLWltYWdlLW1pbmltYWwtbHMxMDQ2YWZy
d3kuY3Bpby5nei51LWJvb3QnIHRvIGFkZHIgMHg5MDAwMDAwMC4uLg0KVUJJRlMgZXJyb3IgKHVi
aTA6MCBwaWQgMCk6IGRvX3JlYWRwYWdlOiBjYW5ub3QgcmVhZCBwYWdlIDU1NTMgb2YgaW5vZGUg
NjYsIGVycm9yIC0xMg0KRXJyb3IgcmVhZGluZyBmaWxlICdjb3JlLWltYWdlLW1pbmltYWwtbHMx
MDQ2YWZyd3kuY3Bpby5nei51LWJvb3QnDQoqKiBGaWxlIG5vdCBmb3VuZCBjb3JlLWltYWdlLW1p
bmltYWwtbHMxMDQ2YWZyd3kuY3Bpby5nei51LWJvb3QgKioNCg0KSXQgc2VlbXMgdG8gZmFpbCBv
biBhIHJhbmRvbSBwYWdlIGJldHdlZW4gMzAwIGFuZCA2MDAwLiBOYW5kIHJlYWRzIGFmdGVyIHRo
aXMgZXJyb3IgY2F1c2UgVS1Cb290IHRvIHBhbmljLg0KDQpEaWdnaW5nIGEgYml0IGRlZXBlciwg
ZXJyb3IgLTEyICgtRU5PTUVNKSBzZWVtcyB0byBjb21lIGZyb20gbGluZSAyNzQgYW5kIDQxMyBp
biB0bmNfbWlzYy5jLiBJdCBzZWVtcyB0byBhbHRlcm5hdGUgYmV0d2VlbiB0aGUgdHdvLg0KaHR0
cHM6Ly9naXRodWIuY29tL3UtYm9vdC91LWJvb3QvYmxvYi9tYXN0ZXIvZnMvdWJpZnMvdG5jX21p
c2MuYw0KDQpJIGxvb2tlZCBhcm91bmQgYW5kIGRvbuKAmXQgc2VlIGFuIG9idmlvdXMgbWVtb3J5
IGxlYWsuIEkgaGF2ZSA0IEdpQiBvZiByYW0sIHdoaWNoIHNob3VsZCBiZSBwbGVudHkuIFRoaXMg
aXNzdWUgYWxzbyBkb2VzbuKAmXQgZXhpc3QgdXNpbmcganVzdCBVQkkgKG5vdCB1YmlmcykgdG8g
dGhlIHNhbWUgbG9jYXRpb24sIHNvIEl0IGZlZWxzIGxpa2UgdGhlIHViaWZzIGRyaXZlciBpcyBt
ZXNzaW5nIHVwLiBJIGhhdmUgdHJpZWQgVS1Cb290IDIwMTkuMTAgYW5kIDIwMjIuMDQsIGFuZCB0
aGV5IGJvdGggcHJlc2VudCB0aGUgc2FtZSBpc3N1ZS4NCg0KSeKAmW0gdXNpbmcgdGhpcyB0byBs
b2FkIGEgcm9vdGZzIHJhbWRpc2sgKH4xNDEgTWlCKSBpbnRvIHJhbS4gQXMgYW4gYWJzb2x1dGUg
bGFzdCByZXNvcnQsIEkgY291bGQgc3BsaXQgdGhlIHJvb3RmcyBpbnRvIDE2IE1pQiBmaWxlcywg
YW5kIHN0aXRjaCB0aGVtIHRvZ2V0aGVyIGluIHUtYm9vdC4gSG9wZWZ1bGx5IEkgd29u4oCZdCBo
YXZlIHRvIGRvIHRoYXQg8J+Yig0KDQpJZiB5b3UgbmVlZCBhZGRpdGlvbmFsIGluZm9ybWF0aW9u
LCBwbGVhc2UgZG8gbm90IGhlc2l0YXRlIHRvIGNvbnRhY3QgbWUuDQpUaGFuayB5b3UsDQpNYXR0
DQo=
