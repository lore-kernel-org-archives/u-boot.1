Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F131C35274
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 14:51:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A39E387C1D;
	Fri, 15 Dec 2023 15:51:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=toradex.com header.i=@toradex.com header.b="YXNtnDSV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E79A487BC7; Fri, 15 Dec 2023 15:51:29 +0100 (CET)
Received: from de-smtp-delivery-113.mimecast.com
 (de-smtp-delivery-113.mimecast.com [194.104.109.113])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88B6987C1D
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 15:51:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=toradex.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marcel.ziswiler@toradex.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=toradex-com; t=1702651887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PTz/hq9qdDOizDRrJiNMpH+nyrVqIkawtk1x0+tAnZw=;
 b=YXNtnDSVpihoqBqJ7sk4+QYAlAD+E9IvDHcEhCif/K1lcVZ43qEITD3jD9qrHmIJytVlbc
 bnSLbrFTsQEOdCO4Ygtgl3VLiiWwVwRQyV56sqUn7tbRVUIPnBKa61v4zTn8y5LkU9bpfU
 bi0pQAJDRBQWsH6E/am41u9bIolsnT4=
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2040.outbound.protection.outlook.com [104.47.22.40]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-3-PDvf-mY6Noa34uYBdUQbkg-1; Fri, 15 Dec 2023 15:51:24 +0100
X-MC-Unique: PDvf-mY6Noa34uYBdUQbkg-1
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 ZR2P278MB0987.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:61::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.31; Fri, 15 Dec 2023 14:51:22 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::cdd5:e0c0:e3f7:dd1]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::cdd5:e0c0:e3f7:dd1%5]) with mapi id 15.20.7091.032; Fri, 15 Dec 2023
 14:51:22 +0000
From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
To: "nm@ti.com" <nm@ti.com>
CC: "jh80.chung@samsung.com" <jh80.chung@samsung.com>, "rogerq@kernel.org"
 <rogerq@kernel.org>, "sabiya.d@ti.com" <sabiya.d@ti.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "n-francis@ti.com"
 <n-francis@ti.com>, "kamlesh@ti.com" <kamlesh@ti.com>, "afd@ti.com"
 <afd@ti.com>, "a-nandan@ti.com" <a-nandan@ti.com>, "j-choudhary@ti.com"
 <j-choudhary@ti.com>, "lukma@denx.de" <lukma@denx.de>,
 "sinthu.raja@mistralsolutions.com" <sinthu.raja@mistralsolutions.com>,
 "a-bhatia1@ti.com" <a-bhatia1@ti.com>, "m-chawdhry@ti.com"
 <m-chawdhry@ti.com>, "hnagalla@ti.com" <hnagalla@ti.com>,
 "rasmus.villemoes@prevas.dk" <rasmus.villemoes@prevas.dk>,
 "christian.gmeiner@gmail.com" <christian.gmeiner@gmail.com>,
 "seanga2@gmail.com" <seanga2@gmail.com>, "sjg@chromium.org"
 <sjg@chromium.org>, "ralph.siemsen@linaro.org" <ralph.siemsen@linaro.org>,
 "marek.vasut+renesas@mailbox.org" <marek.vasut+renesas@mailbox.org>,
 "bb@ti.com" <bb@ti.com>, "u-kumar1@ti.com" <u-kumar1@ti.com>,
 "xypron.glpk@gmx.de" <xypron.glpk@gmx.de>
Subject: Re: [PATCH v6 00/17] Introduce initial TI's J784S4 and AM69 support
Thread-Topic: [PATCH v6 00/17] Introduce initial TI's J784S4 and AM69 support
Thread-Index: AQHaKEErqILJ/BT++EqH7SwUhV8EjbCpGYyAgAApEICAANQZgIAAXTsAgAAH44A=
Date: Fri, 15 Dec 2023 14:51:22 +0000
Message-ID: <6098b6c45f0e2c59a85d1a8671f8724bf2372dda.camel@toradex.com>
References: <20231206123753.1486031-1-a-nandan@ti.com>
 <51eeab25314144926eaefaa2e83353ffec9309fe.camel@toradex.com>
 <20231214201019.5bjxb5ki67yjn4ku@bryanbrattlof.com>
 <946574dc39d1cfb5bd08950a61eae06f3fbdc06c.camel@toradex.com>
 <20231215142308.2vbeicrlkbgr2pui@rebound>
In-Reply-To: <20231215142308.2vbeicrlkbgr2pui@rebound>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR0P278MB0683:EE_|ZR2P278MB0987:EE_
x-ms-office365-filtering-correlation-id: 9e229072-8971-44cb-3dea-08dbfd7d4ddb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: OnjZ6Yqi9ziBJ2XoVkUVFAPyv3g5agudabu2ZImPd/s/LCqBxOWI5AzNoLWHfanEuuigyFb7BObhFqFv3W6y8p8ToVwJF2a5W9T0eYKNPzQtY6G990X8348BMCH1SVUR4UAKkARoOqUyakRK+fPLxwSEj0FGaHgNKAsWGmiajGd9QA3jxRZr11cuvjU0zUcdCVsF00+pRw6OC9xMw5XruCtWSgoFtFX9Srh8BDQOrn8tdPj9mdGaDMfQHu2jZ07+8+0Uuaoht1/e8HDwi8sUcPFa9g+qOjFFUbS8UY8W+GW/Rn24qtDaXWCJefQtKeddYo54DLOwjZv/F32KmF5RCc5SEHJ3RvdQ1ruGgSiskmjrnnuhex5R9rGVt2g5Jk5KsxAxNFaFKHqpiPM9kPf+UJlSAVrga/lXxPK5iX8TMY0bjGem+210glMlQWY2CG8UZPflTL5Eoaytrpvwh8ZgJYDg1Xm147bkOQPde90sD//9UuXNduszK8fxqKyd67QZ5O7CG24rVho6PRXuj2KRbjEPBBhbwDmwOYtqqNWRnIozxaGdPo+9V/3qN8AN/WIQ6Je2W9mvT6hCBQictetVPjNVqYbLX1Ntv7Pkb3K4Y1c=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(39850400004)(396003)(366004)(346002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(316002)(54906003)(66476007)(66446008)(64756008)(66556008)(6916009)(66946007)(8676002)(76116006)(6506007)(8936002)(6486002)(7416002)(5660300002)(4326008)(44832011)(478600001)(86362001)(41300700001)(83380400001)(71200400001)(2906002)(966005)(6512007)(2616005)(36756003)(4001150100001)(122000001)(38100700002)(38070700009);
 DIR:OUT; SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a2ErK3RCd2dMM08ySEdOSVpVYTJBMGpHMHFmU1dPTVIrUVFDSFd5VWs1Z3hO?=
 =?utf-8?B?dWhNZVl3ZGhPWXhWVTZWZTdKUVZKQ3lyYk1kMEFVanlIVzlKMmRSUVdqaFZC?=
 =?utf-8?B?aFRrcW00NkFtYW5nSUQ1eHRpdDlBSTFxTWtBd01KdWxGWlZkc3MyNXA2SlZQ?=
 =?utf-8?B?L1AzVmFnSUtmd0c5dDM4ZlJBNTVpd0RaZXpyWW5zNXFDQlUwbjZsaWRHT3lP?=
 =?utf-8?B?aTBaQnhpVXR1V2V5d0g5aU9YVVQwVjFPRkZsSDlERW5SaEtDaUhzVE4ydUtU?=
 =?utf-8?B?OFZERzhjbWc2RGtGS2E5VkJQOVNyc2VuZ1R5clh1MzdWb2ZiUU9CWGRaZytT?=
 =?utf-8?B?bkd5Sy9ESklYWXZ5d1lvS2s1aVFmRGFFV3pVaUxFdHNyaUxrakJvMEhrV0ph?=
 =?utf-8?B?M2JDUllsdnU2QjNzNmFiR1ZaQnMzWnNwSUoyM3ZRS0JpMnQ4ZVBtUUw3N3ZR?=
 =?utf-8?B?bXd1c3hQSjNZOUIzYUozdDEyci80NHZ3Wk1FQ3Z4TW1SQWF6ZDlJZnNpS1M5?=
 =?utf-8?B?OGhQYWJHajZGMTJXL09kVmRPN2hNMGxpajdWOTJLRXc4bE5EaFJJdFZuR0Zw?=
 =?utf-8?B?Zm5LeVBYNno2bWVMcnV6cHp0OHp6dmFLKzcrZEZnZGJBQVJOeFpUODRXdHdz?=
 =?utf-8?B?eDZhNVdkQTZYTkhCY1p0UVlLa08zajNMMFQrejVKbVROK3RHUjdOWVo1ZWlJ?=
 =?utf-8?B?VTRXY2lLakNBUzVvaWVaWmhUSGdaeXpEb0R6bE91ZWhWSVA3NWpDait4Yk1p?=
 =?utf-8?B?VE44dHZKdnJFWmE1bzRlaHluWHZuTWxDa2lNM0xoRzhQaUpYem5LeThkQVlI?=
 =?utf-8?B?NTZTRURwZFhTV2p3MUt1amFSVWVMOHdjWmE3SnhSWjRIc0NEZEJiRzlGUXlJ?=
 =?utf-8?B?Z0wycU96MERzd2lFS3BWUmpKQldUVFVQQzFtdHV4TS93R09uRi8rNUlHQUxN?=
 =?utf-8?B?cjNOYm4reWZqeDZ1S0gvY0FhaHZnc2RIMlBxeGc0T3lJSVRGWWRFKzVZdFov?=
 =?utf-8?B?Vkh4L0dNU1NDZlkwWTFaeUIvQzVnL0lGaE9NK1BMVks5SW93RWt2SkZhNUxQ?=
 =?utf-8?B?dUR3aFU1a3F2YW9uNHkwbkt4QUJPcE56bkRIcHppNVRYQ1hJdm1OcVZ5VVQ1?=
 =?utf-8?B?R3NNd3ZrSUR4byttTTdFbHJFd2NDZUF5aGFGaWlrRFNrL0xhcno3T0svaFFP?=
 =?utf-8?B?Q2tUMm1NdU5ZWjFHdXE1SFkxelBNYzVrd1h2SU1BajdLOU5Ldis3OFRBSDZw?=
 =?utf-8?B?bktBV1d4L2NMK2Z2MVN1TWJObXoxakt0U1F3WGh4Zngzcm4xMkl6L2ZkSllZ?=
 =?utf-8?B?bWtlVldsWWFweUdHV21QNXpxT2dBNGE0UXI2cTRraEM2dFhDVE4wYVFLR3cr?=
 =?utf-8?B?NmtvdHd0eVpLSDlGUnFlVUxYYi9ZVHhmNEFOc0Q5bmtnNE1YNE5rL0NINUhh?=
 =?utf-8?B?dkVlekROMG02ZGF6cE5tWjQyYll3Yy91RkJ0eHVsSEZMU0dWeHFmaEVyTXpr?=
 =?utf-8?B?WG8vVGw0TG9qSDZKd0NIQVdmdEVsc0VVRkt5RnB3UjRyM2o0cGxLU0pNTWVY?=
 =?utf-8?B?aUpvd1ZSeDNKa2ZmelNOeTJpN1JEVXhFc0NXS3Z1UE9CMFhwVUIwUFExOUtx?=
 =?utf-8?B?cGxGUkJJSEo5OVROeG5sd0RZeFBxaURVN0pmV2ZZSUsyWk5kYkV5T051blFJ?=
 =?utf-8?B?TGk4S3JRekdDVDFiN0lVK1A5NnpMd21pUllSN01tVnBmbk5RZDZrSk5TbUc5?=
 =?utf-8?B?OUtkcFlWZWxYQVVBM2g4cWxLY1VLam9WUWtTTE5FeUpMamZRUHJDYlRuSUhJ?=
 =?utf-8?B?SVlqOHoyNmVQenZFUW04dkhCdHlzTXNPWWkvVElTN3JuNG9UU0tsNjQwUXlL?=
 =?utf-8?B?eXJOckJxV3FObkVXQjhER2o1V1pQc3BZemRzWWxKemZQREM4bmozNmR4Um11?=
 =?utf-8?B?T2wwQ3J5RGx3ZzAyREVxZnROMDJYeWR3ZHg1WW04OVdFOG9wUzgwc0lSc3hJ?=
 =?utf-8?B?em9Gd29HMmJPeDZIV3B1NUhUbmx6VUVPeC8vZTdFUWEwZnN4bFVQZ1QxUmN5?=
 =?utf-8?B?S1B2UHNZRFNZMlNzTWgvZmJ6ZE0vdGtWSEE5OCsvNS9rUlNoQ2lzTGdvcFI3?=
 =?utf-8?B?a3AyR0YrZTR3ckRjZUl1UTU1YXUzVjBkdVFqK21jLzlKWnZuT1lOWHlDVmQ1?=
 =?utf-8?B?YlJBcWdZOURyK091VVhZSGxFTTllbDF6a0RsYXVnUGVIOWVBZ1NoS1NROGtP?=
 =?utf-8?B?TGhISTJmTElTeEUrRnhEZ3ZsdjhRPT0=?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e229072-8971-44cb-3dea-08dbfd7d4ddb
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2023 14:51:22.1659 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o6zehyMJ4qCDu0kycUzvgywrqmT3P35xMrUp5zWrcFcKffQTwYFOLf+0pGepEwNmYZvMUhkaRCESQLw5IDrIkEyKyeGPGY/wt/4IXnE6X3Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR2P278MB0987
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <6E6451EF8AB0334E9AFBC44859B2D2BE@CHEP278.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
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

T24gRnJpLCAyMDIzLTEyLTE1IGF0IDA4OjIzIC0wNjAwLCBOaXNoYW50aCBNZW5vbiB3cm90ZToN
Cg0KW3NuaXBdDQoNCj4gPiA+IFdoYXQgdmVyc2lvbiBvZiBUSUZTIGFyZSB5b3UgcnVubmluZz8g
Tm90IGdldHRpbmcgYSByZXNwb25zZSB1c3VhbGx5IA0KPiA+ID4gbWVhbnMgZmlybXdhcmUgaXMg
ZGVhZCBvciB3ZSdyZSBub3QgdXNpbmcgdGhlIHJpZ2h0IHRocmVhZCB0byB0YWxrLg0KPiA+IA0K
PiA+IFllYWgsIHNvcnJ5LiBJIHdhcyBhbHdheXMgcnVubmluZyB0aGUgbGF0ZXN0IGZyb20gdGhl
IHRpLWxpbnV4LWZpcm13YXJlIGJyYW5jaDoNCj4gPiANCj4gPiBTWVNGVyBBQkk6IDMuMSAoZmly
bXdhcmUgcmV2IDB4MDAwOSAnOS4xLjItLXYwOS4wMS4wMiAoS29vbCBLb2FsYSknKQ0KPiA+IA0K
PiA+IFNvLCBpdCBpcyByZWFsbHkgVEYtQSB3aGljaCBzZWVtcyB0byBjYXVzZSB0aGUgaXNzdWUu
DQo+IA0KPiBBY3R1YWxseSBub3QgVEZBIGVpdGhlciAoVEZBIGNvbXBsYWlucyBjb3JyZWN0bHkp
LiB3ZSBoYXZlIGFuIGludGVybmFsDQo+IHRpY2tldCB0aGF0IGlzIGluIHRoZSBtaWRkbGUgb2Yg
Z2V0dGluZyBmaXhlZCBmb3IgVElGUyBhbmQgUERLIHRvDQo+IGVuYWJsZSB0aGlzLiBhIGJpdCBv
ZiBoaXN0b3J5OiBBIG5ldyBhcGkgVElTQ0lfTVNHX1FVRVJZX0ZXX0NBUFNbMV0NCj4gd2FzIGlu
dHJvZHVjZWQgdG8gaGVscCBkZXRlcm1pbmUgd2hpY2ggdmVyc2lvbiBvZiBmaXJtd2FyZSBjb21i
aW5hdGlvbg0KPiBzdXBwb3J0cyB3aGF0IGZlYXR1cmVzIChzdWNoIGFzIExvdyBwb3dlciwgZXRj
KS4gVGhpcyBhbGxvd3MgZm9yDQo+IGNvbnNpc3RlbnQgVEZBL0tlcm5lbCBpbXBsZW1lbnRhdGlv
biB0aGF0IGNhbiBkeW5hbWljYWxseSBkZXRlY3QNCj4gcGxhdGZvcm1zIChzaW5jZSBMUE0gYWxz
byBpbnZvbHZlZCBhIGJpdCBvZiBmaXJtd2FyZSBoYW5kc2hha2luZyBmb3INCj4gYm9hcmQgc3Bl
Y2lmaWMgZGV0YWlscyAtIFBNSUMgY29udHJvbCBhbmQgdGhlIGxpa2UpLiBUaGlzIEFQSSBpcyBh
cw0KPiBmdW5kYW1lbnRhbCBhcyB2ZXJzaW9uIG1lc3NhZ2UgQVBJIHRoYXQgYWxsIGZpcm13YXJl
IGFyZSBzdXBwb3NlZCB0bw0KPiBpbXBsZW1lbnQuIHVuZm9ydHVuYXRlbHkgdGhlIGRlZmNvbmZp
ZyBvcHRpb24gZm9yIHRoYXQgQVBJIHdhc24ndA0KPiBwcm9wZXJseSBpbXBsZW1lbnRlZCBmb3Ig
dmFyaW91cyBmaXJtd2FyZSBjb21wb25lbnRzIGNvcnJlY3RseS4gLQ0KPiBpbXBhY3RlZCBjaGlw
cyBhcmU6IGo3MjFlLCBqNzIwMCwgajcyMXMyL2FtNjgsIGo3ODRzNC9hbTY5LiBPdGhlcg0KPiBL
MyBwcm9jZXNzb3IgZmlybXdhcmUgaGF2ZSBpdCBpbXBsZW1lbnRlZCBjb3JyZWN0bHkuIFRoZSBs
YXRlc3QNCj4gOS4xLjgtLXYwOS4wMS4wOCBoYXMgdGhlIGJ1ZyBhcyB3ZWxsIC0gYnV0IGhvcGVm
dWxseSBzaG91bGQgYmUgZml4ZWQNCj4gYW5kIHJlbGVhc2VkIHNvb24taXNoLg0KDQpUaGFua3Ms
IE5pc2hhbnRoLiBHbGFkIHlvdSBndXlzIGFyZSBhd2FyZSBvZiB0aGlzIGFuZCBJIGFtIG5vdCBq
dXN0IHNlZWluZyB0aGluZ3MgKDstcCkuDQoNCj4gWzFdIGh0dHBzOi8vc29mdHdhcmUtZGwudGku
Y29tL3Rpc2NpL2VzZC9sYXRlc3QvMl90aXNjaV9tc2dzL2dlbmVyYWwvY29yZS5odG1sI3Rpc2Np
LW1zZy1xdWVyeS1mdy1jYXBzDQo+IC0tDQo+IFJlZ2FyZHMsDQo+IE5pc2hhbnRoIE1lbm9uDQo+
IEtleSAoMHhEREI1ODQ5RDE3MzYyNDlEKSAvIEZpbmdlcnByaW50OiBGOEEyIDg2OTMgNTRFQiA4
MjMyIDE3QTPCoCAxQTM0IEREQjUgODQ5RCAxNzM2IDI0OUQNCg0KQ2hlZXJzDQoNCk1hcmNlbA0K

