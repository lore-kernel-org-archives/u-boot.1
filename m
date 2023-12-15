Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A651C4332F
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 08:51:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2BAE87AE6;
	Fri, 15 Dec 2023 09:51:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=toradex.com header.i=@toradex.com header.b="TRKDjffa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1234687AE6; Fri, 15 Dec 2023 09:51:39 +0100 (CET)
Received: from de-smtp-delivery-113.mimecast.com
 (de-smtp-delivery-113.mimecast.com [194.104.109.113])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E1E687B57
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 09:51:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=toradex.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marcel.ziswiler@toradex.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=toradex-com; t=1702630296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IAYEZuHx6LRokBHTvFitJUskW3Bnh7riLea8gCHL29s=;
 b=TRKDjffaBiXkLz5n1Q3BFh+TdIV1oFRbxS55k1/f4EXQYUTyFBO6/pqN50RnNTF9K+4x45
 od2kR+4CiJ97A2243lg0k9pECm6irD6TO7QuvxFy7pc2hQv5nPsk8HUZPltUFrxGeAGuwH
 I6bG1pfQLsKzJSF5GQi8GQzpvk8J+Z0=
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com
 (mail-zr0che01lp2104.outbound.protection.outlook.com [104.47.22.104]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-7-E44i-g-DOLe1rKPMDD3ONA-1; Fri, 15 Dec 2023 09:51:35 +0100
X-MC-Unique: E44i-g-DOLe1rKPMDD3ONA-1
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 ZRAP278MB0142.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:13::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.31; Fri, 15 Dec 2023 08:51:33 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::cdd5:e0c0:e3f7:dd1]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::cdd5:e0c0:e3f7:dd1%5]) with mapi id 15.20.7091.032; Fri, 15 Dec 2023
 08:51:33 +0000
From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
To: "bb@ti.com" <bb@ti.com>, "afd@ti.com" <afd@ti.com>
CC: "jh80.chung@samsung.com" <jh80.chung@samsung.com>, "sjg@chromium.org"
 <sjg@chromium.org>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "n-francis@ti.com" <n-francis@ti.com>, "kamlesh@ti.com" <kamlesh@ti.com>,
 "marek.vasut+renesas@mailbox.org" <marek.vasut+renesas@mailbox.org>,
 "a-nandan@ti.com" <a-nandan@ti.com>, "j-choudhary@ti.com"
 <j-choudhary@ti.com>, "lukma@denx.de" <lukma@denx.de>, "hnagalla@ti.com"
 <hnagalla@ti.com>, "a-bhatia1@ti.com" <a-bhatia1@ti.com>, "m-chawdhry@ti.com"
 <m-chawdhry@ti.com>, "seanga2@gmail.com" <seanga2@gmail.com>,
 "rasmus.villemoes@prevas.dk" <rasmus.villemoes@prevas.dk>,
 "christian.gmeiner@gmail.com" <christian.gmeiner@gmail.com>,
 "sinthu.raja@mistralsolutions.com" <sinthu.raja@mistralsolutions.com>,
 "nm@ti.com" <nm@ti.com>, "ralph.siemsen@linaro.org"
 <ralph.siemsen@linaro.org>, "u-kumar1@ti.com" <u-kumar1@ti.com>,
 "sabiya.d@ti.com" <sabiya.d@ti.com>, "rogerq@kernel.org" <rogerq@kernel.org>, 
 "xypron.glpk@gmx.de" <xypron.glpk@gmx.de>
Subject: Re: [PATCH v6 00/17] Introduce initial TI's J784S4 and AM69 support
Thread-Topic: [PATCH v6 00/17] Introduce initial TI's J784S4 and AM69 support
Thread-Index: AQHaKEErqILJ/BT++EqH7SwUhV8EjbCpGYyAgAApEICAAAUWgIAAz5gA
Date: Fri, 15 Dec 2023 08:51:33 +0000
Message-ID: <b8777dbd0fae3ce00f41e00601cc8ad62b171b87.camel@toradex.com>
References: <20231206123753.1486031-1-a-nandan@ti.com>
 <51eeab25314144926eaefaa2e83353ffec9309fe.camel@toradex.com>
 <20231214201019.5bjxb5ki67yjn4ku@bryanbrattlof.com>
 <1a97e28b-34ad-44e5-8fbd-ced7a5a69d68@ti.com>
In-Reply-To: <1a97e28b-34ad-44e5-8fbd-ced7a5a69d68@ti.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR0P278MB0683:EE_|ZRAP278MB0142:EE_
x-ms-office365-filtering-correlation-id: 522dd118-b911-4859-2878-08dbfd4b09e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: Fpr9WYcXcM6L6yak6dYm16Q2eHBnPIEV90DR6ic5TjCCiUbSzkUOtJiA1LwgqXd9dKDkYGedEkkGJhTwgsQHfIIuQxGQLIBydY5rjZfx2ngbKGVJcpjKe1IKnjL8f75kzZfOfmfquPRYBRtIj4tyJssb44dYR3K9O+Owg0ItFFw48GF5DXKHu9l+WMQSG5VJ3/QTCZjAHNxWcXs1EWb61dZgMw2pVk2m+yIG2GEGXRMa3Sw9ELIMy+pfF1eyN2qBBjfvzU+3vlxcVlqr3PrN+xpsyXjYBEO4WyfZd5ZIyJ+7JrJvovnZAMs0vHnEiLZ7vV8aaITxo3TddAkrXR1KY1SAbRGj+xaHlLMcIKbYmSSXyuQVyd11dNSc1S7iQZ7Ef+X8sSEjlvrBg2Kb8OG7kXUX4rVHQ3GlmKgDeBTh49qSuwnCAWBBmMZHc7LI/8Dsjy0PvcPnsxWJpt0SUykANWV1Ks42pH+gJjfamEkD/e5+DI28YKS0ZSfW/Fe1WzC9g8h7yZ126aPhldDNjj9O+mBzl3guF4dEGMH/CEIpWZmg0CBa+k409H/6se8sEM2XThLI5nL3b1vLCGNF/qawvgtAFVdp83ZTf8N81QET/ZNQsjvq3Uslb3/cTig7kRp2
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(376002)(396003)(39850400004)(136003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(2906002)(4001150100001)(4326008)(8676002)(8936002)(44832011)(86362001)(5660300002)(7416002)(38070700009)(41300700001)(36756003)(53546011)(2616005)(6512007)(83380400001)(478600001)(6486002)(6506007)(71200400001)(38100700002)(122000001)(110136005)(76116006)(66446008)(54906003)(66476007)(64756008)(66946007)(66556008)(316002);
 DIR:OUT; SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N0I1UWtVRWtjNkI1YXM3UHBKVXdsQ01FMHRLMnNzd3JYVzFvLzBQVkYxRnU0?=
 =?utf-8?B?TGxUNEpsczhHWUFnNU14T2c1WUZheXBaVWpwbkx0U3h5b0haZHdVQ3VSVWhZ?=
 =?utf-8?B?bVA2KzBWbVlSWHRxRkVZYTVIRTVraUZPY1NiOSs0TXlYalVBYVVoVTR3OUI3?=
 =?utf-8?B?MXhpQm95RTNEbG5UdjVxOFY3MnExL3IrU3J5bTF1Y3RyMlkvV1VCakNoK3Ny?=
 =?utf-8?B?RTV5Ujg3RTRJRTJ1UUt1blVxZVJvUXlQb2dmUnc4czJLbXNHQmZ3cVBCVWVm?=
 =?utf-8?B?NnlGV0tUME52YXJZTjArWHgyb29tR05zVGFnY3RFQ3NLKzZDdjBjTnIvTVBt?=
 =?utf-8?B?U3J5SjAvRDRSeS8xSHhySU05NzBjY3FSUk4wM1l2S09ZMnRWSjFWL0ovMG4w?=
 =?utf-8?B?UVV2ZHRzdVNDcm5zSVp0eG9QU1Q0NGUxVUpNbmxRNmNNczRVbXpKOUQxSkta?=
 =?utf-8?B?RlNIdWtEaFNpQ1Vybzk1a01XUXhvZkx3TmIxSHkydTE3SUxZRjJzNXhpREpk?=
 =?utf-8?B?aFdGZ0o5QWlqb2huei95bS9HRWpPYkI2bEtzNzJzTlhIbTJ0RS81YU1kblNn?=
 =?utf-8?B?NmVuR3dTYzBlSURENDQ0R2lTTms4MTVJUm5wZnAxVkJkcTV1a0NnbXYvR1Bt?=
 =?utf-8?B?MWpQQy9EZXVPUmRSZ0pxcTRWcnpXNzIrRkV3dGx0MUFjZEJXNmZSZmwwUG4w?=
 =?utf-8?B?bldTR0pUUDVzblZQbXMyenhwTFFPRnV0MWEzVEpXYkZKM3RxQmdCdUVublU5?=
 =?utf-8?B?c1I5bVE0TGJza2t0K0V1c3BaLzVGK3RtVW1xTFBnWFZKbVdoUU55MjJaS3Bw?=
 =?utf-8?B?QVhFVVNZMzVKNTc4NWhzMmNHQmdsb0JITVV3SEMwdTRhMWtBVGg1djd3WnVx?=
 =?utf-8?B?SG51NWdMSDlGd2M5RzNYUms5U0N3Zk1mazVBcFducW1wK0VEZlVDSFpIVUgz?=
 =?utf-8?B?c0ZmNUJVZXFLTE5XbHN0K2dPdVo5aWZKLzB1bXBZYWVJSXFsd2pMZlZzbWtH?=
 =?utf-8?B?YmZqRVA3MEc2Uld0SU9xYng5WS9MdDJjRCtlVTVQS1FGd1dJVUJ2Y01YN1lP?=
 =?utf-8?B?S0tsMjJwOERnd29pelJsUUZteFRhYVV6TEtaam9mTzJtZlFEa203Y3ZRTlhr?=
 =?utf-8?B?YmN4SDBUQ1VJZ3hZZGFDWjlNemRSWU5RZXJOOVZ6QkFPaGhnQmx2L0tSc2tw?=
 =?utf-8?B?RlpGdGwxWER1R1FJc2t3cmdZem9YZ3ZaRWJmTVp5V2xJMkxFOUlIL0xRUU9O?=
 =?utf-8?B?N2VCOVJhVVA0c01WekFjOTkzZ1BOdlVMZFUxTW1YQUNXbERuUjM1dW8zOStr?=
 =?utf-8?B?K0lDYWp5anJVdXMwU3FVOVJlOTVQbzZxVG11TnA1UUphTGVJMWxoMmo3c0RH?=
 =?utf-8?B?YVE5c1UxdkNoN2NQZ08rOFd4RWdlNHBPOWV3S25xSno3cVU0WXAxNjQrT3Fi?=
 =?utf-8?B?emNEd1RBVCtZVTdKajFkVXV3MmlEUlIxS2hmTUhsYlJWYjRJaHVmTk5QbkFn?=
 =?utf-8?B?MENpdGNVR2xXMnhpUEhKRUtQMFNyc2JFVldFa2pGeDUrV0FKR3RrYzlqRmpx?=
 =?utf-8?B?dWg2QUplVWh2d24zVU8rc3QrNVFhSWFJWng3TnlmNE9DbXIyRkJkVlp2RDZ6?=
 =?utf-8?B?Qmp4cHhIZ2w4QjJ4OWgzZDQ2dGhjOTRHay9mRVVwcUttMXVmTmtGc1J6Q1hZ?=
 =?utf-8?B?K0M0emIxcGp3K1lQczFxRzhpaDFrUWtpVnlJMEsyYnhvb2ZlaExXbXRMTHk4?=
 =?utf-8?B?ZmRmSDdQaDk5RXI4bUlLQnV1SU1FeG0vRGN0L21CYTVpcllKNXpQSXZjQ3kz?=
 =?utf-8?B?cGNybTZvU1prTm1YUVpFZWRFc3N6RlUvSGE5OU1DNVJMUkhpeWhoRzNUd1pI?=
 =?utf-8?B?OXkvaEN5WktQbERQb2pQbHVjdy9wTDZyVUVveVZjbVJIM3d2YlZkeGJvaTlQ?=
 =?utf-8?B?cEtpWXN2aXJlcUp4Z3puVEs4LzBVQmg0VnNTZFFpNU9JT0I3Q0l4T0dkNEdC?=
 =?utf-8?B?WHFnQzFvZ0hlODB4Y3R1akpZRG5JQzVxcWxJWDZOeUpHYkVOd0RjZllZck1B?=
 =?utf-8?B?NEJFRlZ4Zy9pdjRsclFyc0Q2Uk41VnFucCs5SitvUzNaUVZ3T0FreFUvNXRn?=
 =?utf-8?B?OGk5WFJVeVZKTDlabVJRY3BIei9JakgwbWwrTy9yMy9HaWV3STlXaXNRcmgv?=
 =?utf-8?B?MlRROGIrOUFhMGFDVFFBME9ZaFZmdlFZK2orSXl4MXhLZFcyWXdXbm1DQzha?=
 =?utf-8?B?VStwYnJsVkpIM1lTRW04MCt3R2RnPT0=?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 522dd118-b911-4859-2878-08dbfd4b09e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2023 08:51:33.3134 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mpGpWuKWZatbVKkmOj5o/y796oA8y1OW/SFLIJcWsZ3do7kxE3pKksYzB1Gv7JBV8dDMvwXQAKZnYDh5XyYgxIFGmXwxJDjGd7KJ6KmwsRI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0142
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <552B8151DEC4E744971612819F1FE2F7@CHEP278.PROD.OUTLOOK.COM>
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

T24gVGh1LCAyMDIzLTEyLTE0IGF0IDE0OjI4IC0wNjAwLCBBbmRyZXcgRGF2aXMgd3JvdGU6DQo+
IE9uIDEyLzE0LzIzIDI6MTAgUE0sIGJiQHRpLmNvbcKgd3JvdGU6DQo+ID4gT24gRGVjZW1iZXIg
MTQsIDIwMjMgdGh1cyBzYXlldGggTWFyY2VsIFppc3dpbGVyOg0KPiA+ID4gSGkgQXB1cnZhDQo+
ID4gPiANCj4gPiA+IFRoYW5rcyENCj4gPiA+IA0KPiA+ID4gT24gV2VkLCAyMDIzLTEyLTA2IGF0
IDE4OjA3ICswNTMwLCBBcHVydmEgTmFuZGFuIHdyb3RlOg0KPiA+ID4gPiBIZWxsbyBFdmVyeW9u
ZSENCj4gPiA+ID4gDQo+ID4gPiA+IFRoaXMgc2VyaWVzIHdpbGwgaW50cm9kdWNlIGJhc2ljIHN1
cHBvcnQgKFNEIGFuZCBVQVJUKSBzdXBwb3J0IGZvciBUZXhhcw0KPiA+ID4gPiBJbnN0cnVtZW50
cyBKNzg0UzQgRVZNLg0KPiA+ID4gDQo+ID4gPiBGb3IgdGhlIHdob2xlIHNlcmllczoNCj4gPiA+
IA0KPiA+ID4gVGVzdGVkLWJ5OiBNYXJjZWwgWmlzd2lsZXIgPG1hcmNlbC56aXN3aWxlckB0b3Jh
ZGV4LmNvbT4NCj4gPiA+IA0KPiA+ID4gSG93ZXZlciwgb25lIHRoaW5nIEkgbm90aWNlZCBpcyB0
aGF0IHdpdGggdXBzdHJlYW0gVEYtQSBJIGRvIGdldCB0aGUgZm9sbG93aW5nIGVycm9yczoNCj4g
PiA+IA0KPiA+ID4gTk9USUNFOsKgIEJMMzE6IHYyLjEwLjDCoCAocmVsZWFzZSk6djIuMTAuMC03
Ni1nMDIwOTE1NDFkDQo+ID4gPiBOT1RJQ0U6wqAgQkwzMTogQnVpbHQgOiAxODoxMzowOCwgRGVj
IDE0IDIwMjMNCj4gPiA+IEVSUk9SOsKgwqAgRmFpbGVkIHRvIGdldCByZXNwb25zZSAoLTE5KQ0K
PiA+ID4gRVJST1I6wqDCoCBUcmFuc2ZlciBzZW5kIGZhaWxlZCAoLTE5KQ0KPiA+ID4gRVJST1I6
wqDCoCBVbmFibGUgdG8gcXVlcnkgZmlybXdhcmUgY2FwYWJpbGl0aWVzICgtMTkpDQo+ID4gPiAN
Cj4gPiA+IFdoaWxlIHdpdGggbGF0ZXN0IFRGLUEgZnJvbSBkb3duc3RyZWFtIFRJIEJTUCAoYm90
aCA5LjAgYW5kIDkuMSB1c2UgdGhlIHNhbWUgdmVyc2luKSBJIGRvIG5vdCBnZXQgYW55DQo+ID4g
PiBlcnJvcnM6DQo+ID4gPiANCj4gPiA+IE5PVElDRTrCoCBCTDMxOiB2Mi45KHJlbGVhc2UpOnYy
LjkuMC02MTQtZ2Q3YTcxMzVkMw0KPiA+ID4gTk9USUNFOsKgIEJMMzE6IEJ1aWx0IDogMTg6NDA6
MzgsIERlYyAxNCAyMDIzDQo+ID4gPiANCj4gPiANCj4gPiBXaGF0IHZlcnNpb24gb2YgVElGUyBh
cmUgeW91IHJ1bm5pbmc/IE5vdCBnZXR0aW5nIGEgcmVzcG9uc2UgdXN1YWxseQ0KPiA+IG1lYW5z
IGZpcm13YXJlIGlzIGRlYWQgb3Igd2UncmUgbm90IHVzaW5nIHRoZSByaWdodCB0aHJlYWQgdG8g
dGFsay4NCj4gPiANCj4gDQo+IEluIHRoaXMgY2FzZSB0aGUgZWFybHkgdmVyc2lvbnMgb2YgVElG
Uy9ETSBmb3IgSjc4NFM0L0FNNjkgaGFkDQo+IGEgYnVnIHdoZXJlIHRoZSAicXVlcnkgZmlybXdh
cmUgY2FwYWJpbGl0aWVzIiBBUEkgd2FzIGxlZnQgZGlzYWJsZWQuDQo+IFRoaXMgaXMgZml4ZWQg
aW4gdGhlIG5leHQgdmVyc2lvbiBvZiBmaXJtd2FyZSwgdGhpcyBlcnJvciBtZXNzYWdlDQo+IGlz
IGhhcm1sZXNzIHRvZGF5IGFueXdheSAobm8gTFBNIHlldCkuDQoNCk5vLCBJIHdhcyBhbHdheXMg
cnVubmluZyB0aGUgbGF0ZXN0IGZyb20gdGhlIHRpLWxpbnV4LWZpcm13YXJlIGJyYW5jaDoNCg0K
U1lTRlcgQUJJOiAzLjEgKGZpcm13YXJlIHJldiAweDAwMDkgJzkuMS4yLS12MDkuMDEuMDIgKEtv
b2wgS29hbGEpJykNCg0KU28sIGl0IGlzIHJlYWxseSBURi1BIHdoaWNoIHNlZW1zIHRvIGNhdXNl
IHRoZSBpc3N1ZSBoZXJlLg0KDQo+IEFuZHJldw0KDQpDaGVlcnMNCg0KTWFyY2VsDQo=

