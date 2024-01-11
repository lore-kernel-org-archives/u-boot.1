Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16ACBC47077
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 13:40:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3EF1F87A9F;
	Thu, 11 Jan 2024 14:40:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kontron.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="l/DA7Szi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54F0487AB7; Thu, 11 Jan 2024 14:40:11 +0100 (CET)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D376987847
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 14:40:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=kontron.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Thomas.Schaefer@kontron.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cNnutqleQLqbBUWkHtdGpXWt8BhejmFpa76YSl1/G0Mx7BemtkshtP2bgfAwvOHjr2avzD2DDpqkI2tdp7xgkags5AcJJZDWwLp/GsYp2mt8D4r+2flS+GotCnaQCh348GtpIrrp1nz2C2JrmfKjY5oS848W4h8Z4UAn2p8KaZ4DJkZwraHuGmzVSDI9+96PZI2o/PZzXr7PJSI7zY83yAWFE0weQ1zeKd537hoeXnbJZQdD1pZEuMStd51Q4RICrXSoV8w8ImZeahmroA2m3uSBAALTR7Ip+fUyaIsLzigCWrs+nVYISCTbISKXHCal/h0MxKCd4nigQ96xG/T6OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OM2v2iAX0MExaJon/YPx3wwTAdrTmNN59rAOW43aAUg=;
 b=AWjfEqZRsC9YbBbDKD0lqNBKVHrb6utMSHLPD0YDfv+2VmaSOdVErbQ/Uq6Kc69gTTMgCOBnWgb3Y6vV1W61XX6VO30YOOoutbVKttdfQviw9u4qeujXSAZmpV49B+5tYbpgxacIBs/9/5fYmHW7+dPFF9KxiYWZdNd5SlA6P5a9XNxIHKZMbOyuiaC8ij0lN/tqqHi3qZlhJEMYOk7zF5KJjdYfXwr2UxoaouS5f0weoWF1dEyATz6UkI5z9vDrLtd6++c3mTHTXKT+nP9IQFlcQKbZb/ChJnRfyZmXK9OOLRnrBegassW+zPCVgjpyvwoNeox/VlCzW21iCFOc2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.com; dmarc=pass action=none header.from=kontron.com;
 dkim=pass header.d=kontron.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com; 
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OM2v2iAX0MExaJon/YPx3wwTAdrTmNN59rAOW43aAUg=;
 b=l/DA7Szii79N+MrToHYLcUyqb9lSDH6qK4IC+xYtDOldRdt6znWd+1p89GX4eE0p2YsWIeS9SpuBBxehonCra/K18sxttJPoL+sImer2DpEkS5iMBzWP5n8E4L78emM3BOmtzZUIWfShKVebwn7oka1VVAEAsG6B+3oxrKcYUvo=
Received: from GV2PR10MB6453.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:c3::10)
 by VI1PR10MB7689.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1c4::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Thu, 11 Jan
 2024 13:40:05 +0000
Received: from GV2PR10MB6453.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5fc:38dc:29f1:e6c0]) by GV2PR10MB6453.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5fc:38dc:29f1:e6c0%5]) with mapi id 15.20.7159.020; Thu, 11 Jan 2024
 13:40:05 +0000
From: Thomas Schaefer <Thomas.Schaefer@kontron.com>
To: Ye Li <ye.li@nxp.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
 "'u-boot@lists.denx.de'" <u-boot@lists.denx.de>
CC: Peng Fan <peng.fan@nxp.com>
Subject: AW: FIELD_RETURN on i.MX8MNANOLPD4 EVK
Thread-Topic: FIELD_RETURN on i.MX8MNANOLPD4 EVK
Thread-Index: AdpC1mPYqerN5KQnRr+yK/uUXVwhRwBawcsAAACjd4AACB7R4A==
Date: Thu, 11 Jan 2024 13:40:05 +0000
Message-ID: <GV2PR10MB6453CB47656E8C01D701D545F7682@GV2PR10MB6453.EURPRD10.PROD.OUTLOOK.COM>
References: <GV2PR10MB6453B5A6CA444FD371798D65F76A2@GV2PR10MB6453.EURPRD10.PROD.OUTLOOK.COM>
 <1dd93112-b593-6d8a-ce56-1ffe7ebdf0db@oss.nxp.com>
 <AM6PR04MB5302071D0CD6F54193CBB8EFE4682@AM6PR04MB5302.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR04MB5302071D0CD6F54193CBB8EFE4682@AM6PR04MB5302.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR10MB6453:EE_|VI1PR10MB7689:EE_
x-ms-office365-filtering-correlation-id: e5ac03fd-4675-4089-9f80-08dc12aad1d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XHD2Q/MLpuNYrElM60FqRzzc+iAxalSxzL5wZUYd7PdsrCiqTZFdxk1EHsT1mp2MFUlyjpYyDN+afwFR8sQNy6InxGWr7Awl32rNjeXrZW30q3RcDwF5zSQcYuSR82zph2EK5x+0TTwx9W5CjTp6OFMiX8Pah6cA2eJ86fDveBJx0qCbRGYumtDwQdraK9yqBBuGSN4NFoKJ/DuIZfe8fmPLNQ6b+vajp8oEVD8nlNDbUhIbQIb6u1eLJp0vSL5NvS0puDtgq8pbxTOSI4SkjLSbIe1U5657TMdqBGV0NLQ7Sdd+/u26FrsJuRhwm5dns/3hyAUlxp01xeclyhNhCSX7c2b+waSSeR6lnDyj4Il02jKzXVku/D3hyJyVNIxFUQZq6xBgTKT1uvl3WP+TNreaTAZ1alvpdCKuW0BzUC8dNuEYbiS5Nb39LY0VO9KZiP1y0ZWyKXpW5p24bQcmRzFEDI4Pq6JYXZBI7tgmDiEq92i+nyS8zjtWqsTkdj/2cVgTAozZyOqRrfQn7DOAYQs9zxG9tYPUbgKQkwWK7dJ/Hhd1xl+yQ+sazpBuCGHZHucl/ILlqYb9VoGjQv3q2Gh10X6QPw78FwImc1vOKpiQy3edtFiIhhrutcPxCEOmM903HYPLiuNEpvuTtpTWusjSAg0SDySbAQW68qH29+MaZ9ofi8RM1V++wzMtMYMw9/9wDCMnqi3k9fhSAJx4aImKqukUBLnvGDSjNavMc3M=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR10MB6453.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(366004)(136003)(346002)(376002)(230273577357003)(230173577357003)(230922051799003)(230373577357003)(230473577357003)(1800799012)(186009)(451199024)(64100799003)(38070700009)(966005)(45080400002)(316002)(8676002)(26005)(4326008)(52536014)(9686003)(478600001)(55016003)(6506007)(71200400001)(7696005)(83380400001)(110136005)(8936002)(66476007)(64756008)(66556008)(66446008)(66946007)(53546011)(66574015)(76116006)(86362001)(5660300002)(2906002)(122000001)(33656002)(41300700001)(38100700002)(491001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b0k2WkZMd2c2SW1qWlJ4ejNaLytUZkl3a1YwK2dwZjE0ZDRGM0ZDb21uaDdv?=
 =?utf-8?B?K2dvbEJudUQwblBsUFRURVRiaGUrZ0Mwa1hra1pXUzAwMTV2NUpoOExSWldK?=
 =?utf-8?B?MkMrU3dCWDVKYmg2WElsc2lOWS83dTA1cEFWYWtXbXREaHRjeGxQZnFPaGg4?=
 =?utf-8?B?SG0vblhCZUF5aVM5MXQzUnZBRlpQZzhmRzlYRTVyc1BXYXI5dHozU0VLb2dq?=
 =?utf-8?B?ekVmOW9WS2EwZjUwVTI3elpkUXlTZ3czaUhsNnFQYTI4M1k0Wm00Z0p2QThO?=
 =?utf-8?B?SjV5MTJtSXlYaEFDK3ArUXNwcDR5dlY2em12aWFYLy9Fa013RjV1ZitaSVZI?=
 =?utf-8?B?cjRFb20yS1RJVXJ2cEZpSVIyb2RzOUd2azdoQjhzcXdtODNFS2Y5UzdTeERF?=
 =?utf-8?B?cHN2em8wU1ptWEliTHFEZTd0Q3I1UzVLaU93MjI1eWJJOWpFZXFWcnI0cEV2?=
 =?utf-8?B?a2xteU1lK1RxTENZQThSN3BTb3MxVGttWmhGNFhPMW80QzExR2NPVVdrODNQ?=
 =?utf-8?B?V2djT3dYNlJ6aXJSc0FGN0hhMlFnNGphNWhOVHN5eEdvUHB2OHdlZWFUOVls?=
 =?utf-8?B?L1B4MEpGTENRakJiSW9ja1ZOY3g2Q3pQb3orak8rSlpMK09YYzNIVVFFZnJa?=
 =?utf-8?B?WXBCaTJhYklqYllRUjh4cHN0dTlOTUxsTHVpQ3ZDVllZM1VxSU1tK3FBMjBl?=
 =?utf-8?B?eE1EeVVERjZLdU5Fcjlmam1iTTBFUGNNTHVLQXJPdzRldTRvR2RNdGl2amNY?=
 =?utf-8?B?NzZmcng3QlpzTW0xb1NUZzdPcVJPZ0hzeVo4ZGk5M0g2QUhkM3ZpbGtaZWo3?=
 =?utf-8?B?czdLN1cwemd4TDk2K2VlMzlWY3Q5anpsNTB2dHF4RllMSkxXT1MxUVpHTGYy?=
 =?utf-8?B?ZStmbEhzblgzOVJ0Skk0dGRKS0VtYVd1dzZlMFJwVjkybnFNVWxQSWgwUGw3?=
 =?utf-8?B?WHMzYUZwVTVOa2swSzFEdlAyWUF4K2R3Z0JOSXRCcU9wa3QwSStkdXArb0Yx?=
 =?utf-8?B?bG9ORHdvcmZqcTVRL1ZYeFF5OHN6NU9DL05HT0sxeGdJUGl3dnZOQkk0K0Zk?=
 =?utf-8?B?NUpMbDZMOHVXSjRtWVM1Vkp2cHZEcmZiRDlYNS92Y2lPUGRVSFY0M0VXdyt0?=
 =?utf-8?B?NGN4dHhQSDZaSUswOFdtRHVjOVVnQUtBZnFxWTZobmU2eVlSL1N4Q0taM0Ra?=
 =?utf-8?B?OVUvOWZiNEcyVlE1NVRvSytKUnV4ekduMUdpNmllajhVakdyTWdmNHNuWWg5?=
 =?utf-8?B?UUcyRm5sSUxROThvNGlmbCtYbEJoSUZreDZtTithaWd4TEc5Zi82aHBNRWNW?=
 =?utf-8?B?QUVjeG5jU200V20xV3BiNklnUHFJTnp5WnpxNVJ0bytLYkg4U0MvYWRlT2pH?=
 =?utf-8?B?QmpoU04yNUdySTB4M0RiVzJCSGF0K09RVndsNzZEbXNFODZ2K1ZudXN5K2NE?=
 =?utf-8?B?bkk2TTJ3L2tGQ2JLbDl3TjBHMXlzWHhIeTdjbU9KU0tXdUxreHdOZXJVRWkw?=
 =?utf-8?B?NnZIS1g0ZVM0blR6N2VReW1iV2l4dUI3VHlINXNiclRETVpxQTk3MWUyZW5O?=
 =?utf-8?B?eDRMUDRBeWRjZE1Za3ZtRHp3T0xwYlhkUjR0Y2JiSEUvRU5sRXlIUVZGQVZT?=
 =?utf-8?B?YTdPVzBLc3RPMjFWSHZEL21LaVdRSU1jbXZNUzNjRktYT3lmQURuSjVzMEV6?=
 =?utf-8?B?YXR1dkpHMnJaWk1ZL2tDWHEzWnpjejIydFdtOHpEeHBVOG1XOFhyTExQeUZ0?=
 =?utf-8?B?SEQ1S3hCZWg3N1B6Ry9ockdkTlJta01pZGFoc0NUMnlvbG93dXh3UkRkWm5Z?=
 =?utf-8?B?Mkk0TU05eldtTTJqQkQzemF1WEthcE1pblg2QXQ5emZRMk1NNGxoNFMzaUgv?=
 =?utf-8?B?WVFSK1U5ZTBBRmI0ak9ZWU1hd1dEczBNcVExMkIxVjZkQlhoT00weFpNTjhk?=
 =?utf-8?B?Y3VxdTIwdkVKSno2ODBnaTlNU1d4ZTA1a2dxakxyaFRsakpzK05LTlFKL2c0?=
 =?utf-8?B?dHNVY0pRY1llWmdvMFBlcjd0RnRFSyswK2FnZlQrRDRvak9sUkp2alp3UTRJ?=
 =?utf-8?B?TlcyL0F6bE4yNFgvRmtMWG9WZ3pydzB0UmdUcHZzRHdva0xRbVdJamU2Nzla?=
 =?utf-8?B?RGdmd05BdnBZSmtjMy9QL2xUc2NvZ2tpcThhRjdqM09oTVAxV0lwUTRGajcx?=
 =?utf-8?B?T0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: kontron.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6453.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e5ac03fd-4675-4089-9f80-08dc12aad1d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2024 13:40:05.3571 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wz0lx2jRWrj2mq9OKEcX/99LWLcp/Rz6KEjj98BsInZfLKIEH7AQYbHHfRSx1+mOrMDp+sptWp+R7D+3PsKCKriMVO9untZilzS540K1FhE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB7689
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

SGkgWWUsDQoNClllcywgSSBjYW4gYm9vdCBTUEwgd2l0aG91dCBzaWduYXR1cmUuIEkgYWxzbyBh
ZGRlZCBzb21lIGRlYnVnIG1lc3NhZ2VzIHRvIG15IGJ1aWxkIGFuZCBJIGNhbiBzZWUgdGhhdCBT
UEwgY2FuIGxvYWQgdS1ib290IHByb3BlciB2aWEgVVNCIHVudGlsICdKdW1waW5nIHRvIFUtQm9v
dCcgbWVzc2FnZSBpbiBib2FyZF9pbml0X3IgZnVuY3Rpb24gKGNvbW1vbi9zcGwvc3BsLmMpDQoN
CkFjdHVhbGx5IHRoaXMgbG9va3MgbGlrZSB0aGUgU0Vycm9yIHByb2JsZW0gY2F1c2VkIGJ5IGVy
cmF0YSBFUlIwNTAzNTAgd2hpY2ggaGFzIGJlZW4gd29ya2VkIGFyb3VuZCBpbiBwYXRjaCAyZjNj
OTIwNjBkY2QuIEJ1dCB0aGF0IHBhdGNoIGlzIGN1cnJlbnRseSBhY3RpdmUgaW4gdS1ib290IGFu
ZCBzbyBJIGRvbid0IHVuZGVyc3RhbmQgd2hhdCB0aGUgcHJvYmxlbSBpcyBoZXJlIGluIHRoaXMg
Y2FzZS4NCg0KQmVzdCByZWdhcmRzLA0KVGhvbWFzDQoNCi0tLS0tVXJzcHLDvG5nbGljaGUgTmFj
aHJpY2h0LS0tLS0NClZvbjogWWUgTGkgPHllLmxpQG54cC5jb20+IA0KR2VzZW5kZXQ6IERvbm5l
cnN0YWcsIDExLiBKYW51YXIgMjAyNCAwNTowOQ0KQW46IFBlbmcgRmFuIChPU1MpIDxwZW5nLmZh
bkBvc3MubnhwLmNvbT47IFRob21hcyBTY2hhZWZlciA8dGhvbWFzLnNjaGFlZmVyQGtvbnRyb24u
Y29tPjsgJ3UtYm9vdEBsaXN0cy5kZW54LmRlJyA8dS1ib290QGxpc3RzLmRlbnguZGU+DQpDYzog
UGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQpCZXRyZWZmOiBSRTogRklFTERfUkVUVVJOIG9u
IGkuTVg4TU5BTk9MUEQ0IEVWSw0KDQpbWW91IGRvbid0IG9mdGVuIGdldCBlbWFpbCBmcm9tIHll
LmxpQG54cC5jb20uIExlYXJuIHdoeSB0aGlzIGlzIGltcG9ydGFudCBhdCBodHRwczovL2FrYS5t
cy9MZWFybkFib3V0U2VuZGVySWRlbnRpZmljYXRpb24gXQ0KDQpJIHRoaW5rIHRoZXJlIGlzIG5v
IHBhcnRpY3VsYXIgU1cgc3VwcG9ydCBuZWVkZWQgZm9yIEZJRUxEX1JFVFVSTiBvbiA4TU4uDQpG
cm9tIHdoYXQgeW91IGRlc2NyaWJlZCwgeW91IGhhdmUgbW92ZWQgdGhlIHBhcnQgZnJvbSBjbG9z
ZWQgdG8gRklFTERfUkVUVVJOLiBTbyBhcmUgeW91IGFibGUgdG8gYm9vdCBpbnRvIFNQTCB3aXRo
b3V0IHNpZ25hdHVyZT8NCg0KQmVzdCByZWdhcmRzLA0KWWUgTGkNCj4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gRnJvbTogUGVuZyBGYW4gKE9TUykgPHBlbmcuZmFuQG9zcy5ueHAuY29t
Pg0KPiBTZW50OiBUaHVyc2RheSwgSmFudWFyeSAxMSwgMjAyNCAxMTo1MSBBTQ0KPiBUbzogVGhv
bWFzIFNjaMOkZmVyIDx0aG9tYXMuc2NoYWVmZXJAa29udHJvbi5jb20+OyAndS1ib290QGxpc3Rz
LmRlbnguZGUnDQo+IDx1LWJvb3RAbGlzdHMuZGVueC5kZT47IFllIExpIDx5ZS5saUBueHAuY29t
Pg0KPiBDYzogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBGSUVM
RF9SRVRVUk4gb24gaS5NWDhNTkFOT0xQRDQgRVZLDQo+DQo+ICtZZQ0KPg0KPiDlnKggMS85LzIw
MjQgNDo1MiBQTSwgVGhvbWFzIFNjaGFlZmVyIOWGmemBkzoNCj4gPiBIaSBhbGwsDQo+ID4NCj4g
PiBXZSBhcmUgdHJ5aW5nIHRvIGVuYWJsZSBGSUVMRCBSRVRVUk4gb24gdGhlIE5YUCBpLk1YOE1O
YW5vIExQRDQgRVZLDQo+IGJvYXJkLg0KPiA+DQo+ID4gV2UgZW5hYmxlZCBTZWN1cmUgQm9vdCBp
biB1LWJvb3QgaW4gdGhlIGZpcnN0IHN0ZXAuIEFmdGVyIGNoZWNraW5nIA0KPiA+IHByb3Blcg0K
PiBleGVjdXRpb24gb2YgYSBzaWduZWQgYm9vdGxvYWRlciBpbWFnZSB3ZSBjbG9zZWQgdGhlIGJv
YXJkIGJsb3dpbmcgdGhlIA0KPiBTRUNfQ09ORklHIGZ1c2UuDQo+ID4NCj4gPiBJbiB0aGUgbmV4
dCBzdGVwIHdlIGNyZWF0ZWQgdGhlIGJvYXJkIHNwZWNpZmljIHNpZ25hdHVyZSB3aXRoIFVJRCBv
ZiANCj4gPiB0aGUgQ1BVDQo+IGluY2x1ZGVkIHRvIHJlbW92ZSB0aGUgRklFTEQgUkVUVVJOIGxv
Y2suIEFmdGVyIHRoYXQgd2Ugd2VyZSBhYmxlIHRvIA0KPiBibG93IHRoZSBGSUVMRF9SRVRVUk4g
ZnVzZSB3aXRoICdmdXNlIHByb2cgOCAzIDB4MScgY29tbWFuZC4gQnV0IG5vdywgDQo+IHRoZSBi
b2FyZCBjYW5ub3QgYm9vdCBhbnkgbW9yZSwgaXQgd2lsbCBoYW5nIGFmdGVyIGV4ZWN1dGlvbiBv
ZiB0aGUgU1BMIGJvb3Rsb2FkZXIgcGFydC4NCj4gPg0KPiA+IFdlIGNhbiBvYnNlcnZlIHRoaXMg
YmVoYXZpb3Igd2l0aCBib3RoIHNpZ25lZCBhbmQgdW5zaWduZWQgDQo+ID4gYm9vdGxvYWRlcg0K
PiBpbWFnZXMuDQo+ID4NCj4gPiBJcyB0aGUgRklFTERfUkVUVVJOIGZlYXR1cmUgZm9yIHRoZSBp
Lk1YOE1OYW5vIHN1cHBvcnRlZCB3aXRoIHUtYm9vdA0KPiB2MjAyNC4wMT8NCj4gPg0KPiA+IEJl
c3QgcmVnYXJkcywNCj4gPiBUaG9tYXMNCj4gPg0KPiA+DQo+ID4gVGhvbWFzIFNjaMOkZmVyDQo+
ID4gU1cgRGVzaWduIEVuZ2luZWVyDQo+ID4NCj4gPiB0aG9tYXMuc2NoYWVmZXJAa29udHJvbi5j
b20NCj4gPiBodHRwczovL2V1cjA0LnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91
cmw9aHR0cCUzQSUyRiUyRnd3dw0KPiA+IC5rb250cm9uLmNvbSUyRiZkYXRhPTA1JTdDMDIlN0N0
aG9tYXMuc2NoYWVmZXIlNDBrb250cm9uLmNvbSU3QzdlYjM4DQo+ID4gZjU3YTAzMDRmMDMwZjJm
MDhkYzEyNWIxYzc0JTdDOGM5ZDNjOTczZmQ5NDFjOGEyYjE2NDZmMzk0MmRhZjElN0MwJTcNCj4g
PiBDMCU3QzYzODQwNTQyOTczMzQ5MjA5NSU3Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhleUpXSWpv
aU1DNHdMakF3TURBaQ0KPiA+IExDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhhV3dpTENKWFZD
STZNbjAlM0QlN0MzMDAwJTdDJTdDJTdDJnNkYXRhDQo+ID4gPW5PdVdiMk5TcFBCUmw1RmFWOHhh
NU1pUVolMkZ6RTd6OEYlMkZDMlJmdiUyRjd5em8lM0QmcmVzZXJ2ZWQ9MA0KPiA+DQo+ID4NCj4g
Pg0KPiA+DQo+ID4gS29udHJvbiBFdXJvcGUgR21iSA0KPiA+IEhlaW5yaWNoLUJhcnRoLVN0cmHD
n2UgMS0xYSB8IDY2MTE1IFNhYXJicsO8Y2tlbiB8IEdlcm1hbnkNCg==
