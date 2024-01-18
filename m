Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEA98C47422
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 13:15:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 664D78798D;
	Thu, 18 Jan 2024 14:15:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kontron.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="POhgcqc8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F272879E5; Thu, 18 Jan 2024 14:15:53 +0100 (CET)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01on0713.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1e::713])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54F3C879F7
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 14:15:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=kontron.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Thomas.Schaefer@kontron.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fd/llB5IDhib2MjO/3rw9bDvtj6zYRtnLSYEteT60tn6ALT0rtFT2B7gL2M3htOyd1Gb6NDFQAq6JZkyqnnl1ONh7TWesNhb9QSkh2KCrkLpBtpCSKY8PxAzkPj7lpWYTTrBJ9DQnH+pmEjdgLweg1kGRqChYCfOutuSmQKCq1clmmeYtWuyKyM9oPN05aFOuPmOWMFg6XNbVaElDx5NmT8vwJE3I7jbebOGsJVEZreHDz8KrLQvNgkMxFl6RWxXKpT90tqO94MKYRoIMlKlgy6fFjCIw+UGvMKZpw07rVcgbuTxw83iAIqVzTCE3CvdBuIm4VwFkW2Sb9i0v4TjGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uW1tWviW5eJNpPSFItVuoWYdJmoP2BNGiuEWNY7MwcU=;
 b=HzK/Dh2E06DWB0jK3yyu9PzS3Fhu5NYkEMk0HChKQH+hsBxaD4SNyepD2pRYpWgj8ia/IbspF4rQwQpp5Ny3cvjGKnPa97H78pI38szK6giIOg7LJKFMgu9NKQrdHFUJugsAjRhdNGrAHP00qNyVdK04ZK2GX/rAHdkVj3jlXmYCTluyg74LV2fldKlXjizBmpJoxTF+MItkklTRB2KmCY9xTkUpLBBU0I1nJ1g7EE7fnDrK22Txwni1QVsExkqSXQmm1hJ3zLk3I798HT0XutTQs0MrH45Sr5icI9Iq3t7QFJky07i33BzZSUhZFCAtsZkCAdQqPfjMmSJXfL37Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.com; dmarc=pass action=none header.from=kontron.com;
 dkim=pass header.d=kontron.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com; 
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uW1tWviW5eJNpPSFItVuoWYdJmoP2BNGiuEWNY7MwcU=;
 b=POhgcqc8wToR2Hi+RkHrMnBoETjUm8wN2Zufw/mIWoFmk3x678eqAedmV2cC3xyjrhzUlE/iCo4PzpF5mJV/r3H7jYBs2LCH0h9iz2ry06G/AGEF6admWfKMWOBwWgoZUWhBW4xYyoz+WMXU/SNqD6KZmekDuOUqMFe5BI98K+4=
Received: from GV2PR10MB6453.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:c3::10)
 by GV1PR10MB6268.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:90::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Thu, 18 Jan
 2024 13:15:47 +0000
Received: from GV2PR10MB6453.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a281:d0b5:188f:5ff8]) by GV2PR10MB6453.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a281:d0b5:188f:5ff8%4]) with mapi id 15.20.7202.024; Thu, 18 Jan 2024
 13:15:47 +0000
From: Thomas Schaefer <Thomas.Schaefer@kontron.com>
To: Fabio Estevam <festevam@gmail.com>, Ye Li <ye.li@nxp.com>
CC: "sbabic@denx.de" <sbabic@denx.de>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "peng.fan@nxp.com" <peng.fan@nxp.com>,
 "uboot-imx@nxp.com" <uboot-imx@nxp.com>
Subject: AW: [PATCH] arm: imx: imx8m: Enable the SError exception
Thread-Topic: [PATCH] arm: imx: imx8m: Enable the SError exception
Thread-Index: AQHaRSYHi7UfSi53jEWRf+4xbGSN97DWeDaAgAkd3PA=
Date: Thu, 18 Jan 2024 13:15:46 +0000
Message-ID: <GV2PR10MB6453684413B98675A9BB0EC5F7712@GV2PR10MB6453.EURPRD10.PROD.OUTLOOK.COM>
References: <1705043234-39185-1-git-send-email-ye.li@nxp.com>
 <CAOMZO5BpA7Mx4Pogz4vMJaBy2GeoroKAELRg7wftUNdxuePtyg@mail.gmail.com>
In-Reply-To: <CAOMZO5BpA7Mx4Pogz4vMJaBy2GeoroKAELRg7wftUNdxuePtyg@mail.gmail.com>
Accept-Language: en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR10MB6453:EE_|GV1PR10MB6268:EE_
x-ms-office365-filtering-correlation-id: 58f05e76-c199-4f93-1ac1-08dc18279556
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vJslkKo0VHykrF0u+sZzcuUyuVc7F6oMR/K83nm8BBCv118ZaHu0SPGogEveQ6rxd0h3Lzhxp2l1dInCs0U4ZOLFBBRwcNnzRje2U989T90BjMz5OqtU7frn3uLmkScTxm4B0T641CQMaYVV6l+BejBxAOGmhiIrbrmsMMch9yV3pmnQQgR0No3gMYnCtULoVq67ffBRJWnyRxOnyp2z51I00Fg3c3RGrGuXRewawP/zu2LC7CfMfC2DwNR+Of+Lx88nAwQpNqdHdPItInZUT/q4FVIErRCpigXr+75tHipeWaNTkHOlAK6rvycm8DfvFUcwbRy6NKx9M4Vtge4SU59fe60cPrYOL9cm/hdkuCqnO7jojAAy06v4j8X4C50D3i3y5wwMZdFMqgDXkUmUyh0/wsVgyEcf+Ko8PteXaLMZvFRzxQxXFdfSkifrOGeL6V37M9lFuvUF18ZDBfDQkmgmGyM6CI3Q7zsxAu+vGJFP/YKSbxNGkYWzlRn4BIrAyLXewvnnmxQNKd6NZy3XH//wPBxNqR3HWOUUiOVLugb1BwZZNjBkNOrG+nZPa9wH1HF3aPDpsUSagZNBqX7cGTNKuTO23BC1Ok6DveBhFOsjE0hWiSbdb1JBL6mqoM75
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR10MB6453.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(366004)(39860400002)(396003)(136003)(376002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(41300700001)(5660300002)(8936002)(2906002)(55016003)(66946007)(66476007)(66556008)(54906003)(64756008)(66446008)(110136005)(76116006)(316002)(478600001)(966005)(45080400002)(8676002)(66574015)(38070700009)(53546011)(9686003)(26005)(6506007)(7696005)(71200400001)(4326008)(52536014)(33656002)(38100700002)(83380400001)(86362001)(122000001)(32563001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OC9MRWpDWFlFYzhtT3EwOHpDOGY1anlpYkUyUWRwRmwrVnNCZmk0cm5KVkNx?=
 =?utf-8?B?Z09IYW8vVk1wUFRYZ2s3U2xaWDNqWlhPaE5aYVBQMXBzalRyVlpHaEpUenh0?=
 =?utf-8?B?b2l4bW1YY3BLQ2tEMnpwTlVhbXFMaG42QzVESklxTFFRK2tQOVJocDlFRnE4?=
 =?utf-8?B?Q0FTVElPUy9QVllDUFRpdTNzK0lMV2dUc1hXNUNnWXo4TEdFK1RrTHp3Q1BZ?=
 =?utf-8?B?SlNCL2ZrYmxFcEVUakxmaDVmeVBiZVJLR2swdkg0R1Vxd1NuZGZQWTV1ZzVM?=
 =?utf-8?B?VWxRck0vcm4zZ1p5K0QwaUhpUDlkQlk4Tm5NNEppR3VwbW9tcjFwUEsyeVY5?=
 =?utf-8?B?SVVwaE95bkwyVE5aak4zN08zbUM2K3lVLzRHd2ZMbi9JbW5Qd0RJVkxKOHBy?=
 =?utf-8?B?aUtGOXVqWDBUd01yMHpaSGh6YWNBRFZEKzJ6NTZ0SnVoSk5JRFgrdHNUemxK?=
 =?utf-8?B?NFpPOUQzQnI5cklkbVZQTis1cTBGMGcyd2dGekUxTHJuMHZlbWIxdkVENks1?=
 =?utf-8?B?S2Z1bFJNU3c5aXJoa2pGemNMUGJYVHJrVmw0bFhBTmpUVzBUSm5QWWwyVlBv?=
 =?utf-8?B?N3FwL1c5Y3J2VDdXMExmeVorZlMwdTU1OEN3UUV4VWkrWCtjam02Nkg5YVNQ?=
 =?utf-8?B?WTh6S084NUQrWTI2dnFrNllDQnBSWmMrQlR1T0U1ZnArK3BGTm90UkozMmp6?=
 =?utf-8?B?UUhaeG85WlFYNmE5M1ZSSU1vRXVLV2hlTHZhNjJiUTl0VS9YRjJqcGx6RUZN?=
 =?utf-8?B?N1ZBV0cxQWM2Z01CNEkyU3Y1V1ViMnc3Zno2cEF6d1U0akdQRFFXYUF1ODM2?=
 =?utf-8?B?MEc5d3pISklobGozRlM4SkNjRFhQL0dmRDl6Um5WQzRwdlUxd3FKYys2TW9z?=
 =?utf-8?B?TGlYZUJUYjJqUFZkaE1vZC9GbmhvdGRkYlU4M2FIL1hRVmpxbks3RmoxOFJv?=
 =?utf-8?B?UENVam5JOGsrZnhiOVBEdVVoNS9SS1JqejhQOE9NcVA4MmNOanNnd29HZmJD?=
 =?utf-8?B?NjZIejBmY2N3MUxUcWJ0eVZ3UEFWWWRxQ29iU2p3dEYyMVJ4bHA5Yjh1Tjdw?=
 =?utf-8?B?MXVZUUpjdzMvNTliVHlsRS9jOUZ2QzBXTVBhQVFPTllTRS9PWVVGdFBjbmNB?=
 =?utf-8?B?Q0hCaWNFQXZoalUrQW9ETk5TS1NSSEg3eXNxMTNmZjdERnFzTHVSUElxeVV6?=
 =?utf-8?B?MTd6YThvcXZtRzQ5MHVCUUJjS25uTG12bjloSFA5bWZMQU9iV3ZmQzBxR1hx?=
 =?utf-8?B?OWRCUkc5YVM5UG16RnZDd0MwczZya2Y5RzJ0ODVCcDZuUUs2ZjZPMDZtRXpH?=
 =?utf-8?B?anVhSmtWb0ZnK20wNDhZSVFOaER1bzNINFdUalh0Y2htLzVUb2ZNTTMvdmRi?=
 =?utf-8?B?NGpaZGU0elA5UGdhZXdpOW1XTERxK2tkYmhCQkxES2o3OXluUGlPOWhreFZF?=
 =?utf-8?B?d2swTHdRM2N1UjgxaVJNQ3J0NndJVG9jSkJqZytBOU11bG85QzY0d01kTVFy?=
 =?utf-8?B?cHQ5WlBpbXpFVVZSaUpkTWhsMzdYMGhWNG5KVVZvL2ZTblVMTVZBbFlMWXRC?=
 =?utf-8?B?TlRWbFJsaFdvS1pDMDljY0lBN1FYbTE1a3ZYMFlOTy82bHJkeVlGRXlsTnV2?=
 =?utf-8?B?VzRKcHNGYWJITTFPdmo1NHRQNlg3b3k3TnJ4NngxcjllcStzdnRsZ2VVVXA2?=
 =?utf-8?B?SDNvdTdoUjJOeThQYVRmTno4OFBwV0x1bVNWRmJFRVgxRnNONUQ1RUZIYnNK?=
 =?utf-8?B?bkxsTDc3MllrSXRVVUJ5aVo5amtHTEt6NnVTQzJaQjhwdkNjOCs0UkdxRHcv?=
 =?utf-8?B?RUd5RDVKcTRXT3VBNVNHZ2dCL3JPZER0bXJaSnhQaVlqNDRFbG1yUmE5V2tF?=
 =?utf-8?B?aG1idGlKZlNRYUdCdW9QQzlyK1VjMk95VUgwZHJTWUpvcllTTUNpanFma21B?=
 =?utf-8?B?NjNIait3SGN4VEZ2TThSREI0QXlpdnlYZ3FSZ01uc1YvaDhpd3pDTG53YVEy?=
 =?utf-8?B?T3hlb1pQSzdCM09mamdmTjh3WkNtOGhwY1pUNmtGa0d5Y2RITHU3S3hUbzBI?=
 =?utf-8?B?Y25iQ04wdS9nSldFcGFxWWsxclIwcU5hb0U2L1VPUVVySEV5dWdZNTBpSlMy?=
 =?utf-8?B?WG43TDhWSTkyYWlIWWY5QlM5KzZXY1hNSVNuS0xSd3Q1cWo5eW5oWkwwQUJp?=
 =?utf-8?B?SlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: kontron.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6453.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 58f05e76-c199-4f93-1ac1-08dc18279556
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2024 13:15:46.7745 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3/UILPJRt7s53C2ok8EoHr+K5qHng2VgQdTNJ619uMBlGQQnAnQN8Vq5EI3BjkUNo9Cq/+eR9NGHHUN78rPg/wLpwdw5ubYSEeBiv3SzzZs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6268
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

SGkgWWUgTGksDQoNCkkgY2FuIGNvbmZpcm0gdGhhdCBvdXIgaS5NWDhNTmFubyBMUEQ0IEVWSyB3
aXRoIGZpZWxkIHJldHVybiBmdXNlIGJsb3duIGNhbiBib290IHRvIHUtYm9vdCBwcm9tcHQgYWZ0
ZXIgYXBwbHlpbmcgeW91ciBwYXRjaC4NCg0KVGhhbmsgeW91IGZvciB5b3VyIHN1cHBvcnQuDQoN
CkJlc3QgcmVnYXJkcywNClRob21hcw0KDQotLS0tLVVyc3Byw7xuZ2xpY2hlIE5hY2hyaWNodC0t
LS0tDQpWb246IEZhYmlvIEVzdGV2YW0gPGZlc3RldmFtQGdtYWlsLmNvbT4NCkdlc2VuZGV0OiBG
cmVpdGFnLCAxMi4gSmFudWFyIDIwMjQgMTk6MDENCkFuOiBZZSBMaSA8eWUubGlAbnhwLmNvbT4N
CkNjOiBzYmFiaWNAZGVueC5kZTsgdS1ib290QGxpc3RzLmRlbnguZGU7IHBlbmcuZmFuQG54cC5j
b207IHVib290LWlteEBueHAuY29tOyBUaG9tYXMgU2NoYWVmZXIgPHRob21hcy5zY2hhZWZlckBr
b250cm9uLmNvbT4NCkJldHJlZmY6IFJlOiBbUEFUQ0hdIGFybTogaW14OiBpbXg4bTogRW5hYmxl
IHRoZSBTRXJyb3IgZXhjZXB0aW9uDQoNCkhpIFllIExpLA0KDQpPbiBGcmksIEphbiAxMiwgMjAy
NCBhdCA0OjA34oCvQU0gWWUgTGkgPHllLmxpQG54cC5jb20+IHdyb3RlOg0KPg0KPiBUbyB3b3Jr
IHdpdGggY29tbWl0IDJmM2M5MjAoaW14OG06IHdvcmthcm91bmQgUk9NIHNlcnJvciksIHdlIG5l
ZWQgdG8NCj4gZW5hYmxlIHRoZSBTRXJyb3IgZXhjZXB0aW9uIGFuZCBpbnN0YWxsIHZlY3RvciBp
biBTUEwuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IFllIExpIDx5ZS5saUBueHAuY29tPg0KPiBSZXZp
ZXdlZC1ieTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQoNClRoaXMgY2F1c2VzIGFuIGlt
YWdlIGluY3JlYXNlIHRoYXQgbWFrZXMgU1BMIHRvIG5vdCBmaXQgaW50byB0aGUgaW50ZXJuYWwg
U1JBTSBvbiBzb21lIGJvYXJkczoNCg0KaHR0cHM6Ly9zb3VyY2UuZGVueC5kZS91LWJvb3QvY3Vz
dG9kaWFucy91LWJvb3QtaW14Ly0vam9icy83Njk0MjINCg==
