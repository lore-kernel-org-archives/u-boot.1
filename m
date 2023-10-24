Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB701C00A8F
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 10:03:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 474208714D;
	Tue, 24 Oct 2023 12:03:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=toradex.com header.i=@toradex.com header.b="irEdnzpG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 762AB87142; Tue, 24 Oct 2023 12:03:26 +0200 (CEST)
Received: from de-smtp-delivery-113.mimecast.com
 (de-smtp-delivery-113.mimecast.com [194.104.109.113])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 115468716D
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 12:03:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=toradex.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marcel.ziswiler@toradex.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=toradex-com; t=1698141800;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wTQuIXA7qBWiyTKTkuw4zygyVS8fhcfYO5ERIQaBpJE=;
 b=irEdnzpGZcgiSTE406CsSNK+Ve8c0ft+k7hpM8LWycWcqTPbniOzUv/K4zctBNiCaVaz4t
 Mf+4ynRY1osbeq8IfCSNNM+iupiHdhtPsCUC4bwhk7pBqRFzY/Ln7oCve7bwqir9+fS2AD
 KVYofNkUQDXXfMMpkunf806fuakp6bY=
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2040.outbound.protection.outlook.com [104.47.22.40]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-53-bBUorZU9Ov-LqPTDO2l2bA-1; Tue, 24 Oct 2023 12:03:17 +0200
X-MC-Unique: bBUorZU9Ov-LqPTDO2l2bA-1
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 ZR0P278MB0870.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:4d::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.33; Tue, 24 Oct 2023 10:03:16 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::a3b:50bf:57a:b96b]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::a3b:50bf:57a:b96b%2]) with mapi id 15.20.6907.032; Tue, 24 Oct 2023
 10:03:15 +0000
From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
To: "rasmus.villemoes@prevas.dk" <rasmus.villemoes@prevas.dk>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "festevam@denx.de" <festevam@denx.de>, "uboot-imx@nxp.com"
 <uboot-imx@nxp.com>, "sbabic@denx.de" <sbabic@denx.de>
Subject: Re: [REGRESSION] imx: spl_imx_romapi: boot loops
Thread-Topic: [REGRESSION] imx: spl_imx_romapi: boot loops
Thread-Index: AQHaBk0pzkBxey4AX0CR0vSGBaUJ0LBYqXaAgAAMigA=
Date: Tue, 24 Oct 2023 10:03:15 +0000
Message-ID: <1f86cfc30009f2a04c131ddc06a1d8300dcb1453.camel@toradex.com>
References: <6de4ef437445c78317e7d8f4f07e47502caed029.camel@toradex.com>
 <cb3e2ea6-b417-4736-9639-b51a04815f7a@prevas.dk>
In-Reply-To: <cb3e2ea6-b417-4736-9639-b51a04815f7a@prevas.dk>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR0P278MB0683:EE_|ZR0P278MB0870:EE_
x-ms-office365-filtering-correlation-id: 54feb412-18f5-4af1-8dc5-08dbd47870f9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: TKqvHqVHaxM1CP73eAu+Y/MO0iz8VcMSBT4ZFIsNJMPii+ufkgcN8HCh7uFYlIIx2uQ9RIA52ohnwpXdA2JoPFuEJFDGHiKIGQuW9i2v0KNzkrm1dLUoiW/KTO6TOqE4ojY7UEARuFDQ3DTiJ6BNLyHif1gCcH16EfivxZ2tjh6tNe9LAJagmk6dR8xsiTEvP774JXGY6q0HKSZ5EP/abJLb2DQC8J7Jsu5DuCiIji5u/rEKut/dGWcCjcvoBGworbTmCiQY2OJ8Qtq5d5mahYmZGTP54FqN5AV1qwLXSs+QVcYO+GmKuIMWyNzZ6H8vb8IPk2scXNKZwA8FEFQSTRqLMmtSoov3+T/yfD5lqbXRisaMSkglJnOrfF5AFnb//PcU0gR1SKLJVOdKDRIhhD3REFu1he/tAjg23WaGVanHtIUy3LzIJktGgxctvFFvWfkJIya+FO8NKmMwv2rtAWma7ZLAt/JX7Cq93cGsrxvtICJ9XC+gTBgVA2XiYeDqwnidnhNk2DO9gR1IHADbWk9pQlerYqdyDukVYVGxRAGpzXy5uTPgkG6+4KEX5lwdwoSVDx5PThW81zawZE2BJUrfj0MeE++5yvLJl1yOs3IQ0HLT+bwLWNKLDKdgrTbq
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(366004)(396003)(376002)(136003)(39840400004)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(2906002)(44832011)(38100700002)(41300700001)(66476007)(66556008)(66446008)(122000001)(64756008)(54906003)(316002)(76116006)(71200400001)(2616005)(66946007)(110136005)(478600001)(6506007)(6512007)(6486002)(83380400001)(91956017)(86362001)(5660300002)(36756003)(4326008)(8936002)(8676002)(38070700009)(26005)(4001150100001);
 DIR:OUT; SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZXdjOVo4RVIwTzdwRlZqNXZ2TXRxcWtBUHA4Z0RIQkpjRVRCcGRnVEU3OFk0?=
 =?utf-8?B?ZEg3WVhMLzBpTnhtWUh2RFhwNEc1RWdtZVBuSHZqeE04ZjlxMjVQYkp0TGpE?=
 =?utf-8?B?ZzA5djJlQlJiazNCZlh3WFg4UVVHclI1ZWVCWEU1VVd0L3lXc2h5ak9IbS9n?=
 =?utf-8?B?YWZqaXlOSk82SUpPS1VWK3VHbTlKV0wyeEZiRm95ZWIzWVlZUGZ4UEQxTUhU?=
 =?utf-8?B?MVg3QWJ0TWliSWZGcWVydkJEd0FkaDBRM2dOdy8rQ25KRTFreE80WU0zcE1H?=
 =?utf-8?B?aTVmcUt6WFBrbzZQWGp2N2oyK2dXTzVKZUticC9XOGVmNnhpL0RwNVRXSmFq?=
 =?utf-8?B?WDkwelFnTnM5QkRWSWJLS2VNWG1NQkhnbDFGYkt4QStOU0UraWVvdHBGSm5p?=
 =?utf-8?B?Z0hYc2VlNGJpS3pEUHFjRXFvKzhhUEtOeFlicURrd3MzRUZTRnpzbXRJV04y?=
 =?utf-8?B?OFRPVjRONC9vYkRrdVJnNUZNUHNsVTdsb2lxcUE0TERYdVlObms1bWZDeXJW?=
 =?utf-8?B?RHl2WG5qdXgvbHRhaTYxejBRemlwV091bmhTZCtTa0txOFZmS1l2UGhRK1k4?=
 =?utf-8?B?aVZwWkRsOEZReEpCb1JnOGpURVBTQXcwbHBTb3FtTUlraUoyczBUcXJzSFVy?=
 =?utf-8?B?bTNsd3lCdUdOQkJYWGRiWm91Ry9IU0RHNFNuRlM1eWlzb2VLL3VzZGZMWWQw?=
 =?utf-8?B?YllEcnphRVVSc1RtbFFiYXREMWZjS05UVFR4ekFmRjZ2d1c0dkoyM2UxZmtZ?=
 =?utf-8?B?aGp0aWNLNmcwOEdjT21LTjdINGtGNTZvbythT0FoTWdIQUo3Y3NuZlpzS21r?=
 =?utf-8?B?S1VYU3ZFb0dzNmFlQ0NMUTdvRTBCRTV1TS9aWUd6OUluV2swc3d6QW84ek5M?=
 =?utf-8?B?Vm9RQ01oMU9KczMrQWZGY0dWM3F6NjUxcmxpdHBRaHhka0lYYTdQcXN6dVRN?=
 =?utf-8?B?V0tHZG1xQTBkSUZqWEpZSjdVOUttNXREWUxHRzFsVVc5Nkx3Z2RWVFFxZDdt?=
 =?utf-8?B?eWJiZy9JMEJDaDZZSXBweDhJMnVpSmNKWFhyaUx5a0JkQXRSaUpOU1l5KzEz?=
 =?utf-8?B?NTRYeHRQRjNKWDRNd1BSL3g5ekUxVzg1L2wrY2tTNnA4Y0F2dmUxeVRHcko4?=
 =?utf-8?B?TnBUUU5IVk02VFJQQml1VTFuMDVNSkxuSUsrU05vZjhUOGJHZWJrb0lBRmRX?=
 =?utf-8?B?OGFiSnlQR0k1MDRMT0NMRW1GZlZLbmJCcG44M003Z3ZsM0dxN090amtBalZx?=
 =?utf-8?B?VFVUbld3T0FXNEt2RHdNekh3VXNyck9mSU9GMlQvZUYvT0VCLzNOUUhFcndF?=
 =?utf-8?B?T2FxZkdRM0o1c1U5bHlqRFlqNzJqajFVa1c3cDdUa1JGaHZsQmp3enlLT3lo?=
 =?utf-8?B?Zy9JZjg2SlEybTBtc1IvT0VobzdhZXB6cmJZdWpmYitTTWtqcy9LQTYyZnJv?=
 =?utf-8?B?Tk9rZnU5dHFzTUpURW4wWFNMQlJvSGNMSUJFeWZFaXRJWHUwSUNxcXB5L2oy?=
 =?utf-8?B?RFVUQ2pVOUVtY1M0Q20wcDJBNjI3OUdjRk5ORTh5R2Jnd3NrckdTSTdkMlFX?=
 =?utf-8?B?TStSNWRURHY2WFJ3MnJyS0tETE9KL29DSjRwL21SNnVabVZHRXF2TTVaUWk4?=
 =?utf-8?B?TTdHOHFZWDFEQ240ZFB3Ykg3V05Fa3ZycGVhSzRFdUVVa3JSU3NHTWtCNWs4?=
 =?utf-8?B?Z3hJa3JLMThjbXhMSkZEaFBtVzVuMzVBdzUyeWFIcjhSODlkaWVyN2xvZGRw?=
 =?utf-8?B?S0dzQjFZdmROUXVhM0FLK0RKbjROUFBCdjRoTGhoZ1RScXA5YzFNdVJuWUFU?=
 =?utf-8?B?NTlJWG5nb1E4MHZsaEZuVVhYUWl2TERMQ3Q2eTVEVkgydlM4ak9DSE5veGxL?=
 =?utf-8?B?Qm5aYXJvSHdkTThWMllndjI4RWlaRmt3STJvdFRNOVFma3BEYmJlaGgvL0hK?=
 =?utf-8?B?MVBTVjJtRHpUSkQvNXNBS1M1TklDVlVKNWU0R3MxNHBNM2RFbTE4cTRhMDMx?=
 =?utf-8?B?cE42SDh4MFJSK1RlSi9pYjFxOGRYdmVTVGxVdEdTR3EwN21uL2JVVnh2S3Bs?=
 =?utf-8?B?dFpPTU9FQnU2blFQN2JxRmFXc0tXaERpU3VHSlluLzRaWWx4U2ZISjZJK2RN?=
 =?utf-8?B?WHc4QWFMMTBGODlDYzc0VFhFUHlSREx2R0hjSjA3TWJjaWJVdHkrTWQ3T0xl?=
 =?utf-8?B?MXc9PQ==?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 54feb412-18f5-4af1-8dc5-08dbd47870f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2023 10:03:15.9092 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c4Zs8ZA8VeBm8+ej82gkRnxdsqMWQcJ2rHQwSgG/Lvtublqm9thOKZuGEGc8gU/NGBc2swSyvXG9VRDz3TY28LiBHZsFbDFuV7VIdN6gZbU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0870
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <444BD8D8B958A24D81780C45194A1A9C@CHEP278.PROD.OUTLOOK.COM>
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

SGkgUmFzbXVzDQoNClRoYW5rcyBmb3IgeW91ciBoZWxwLg0KDQpPbiBUdWUsIDIwMjMtMTAtMjQg
YXQgMTE6MTggKzAyMDAsIFJhc211cyBWaWxsZW1vZXMgd3JvdGU6DQoNCg0KW3NuaXBdDQoNCj4g
SG0uIENhbiB5b3Ugc2hvdyB0aGUgcmVzdWx0IG9mICdmZHRkdW1wIHUtYm9vdC5pdGIgfCBoZWFk
Jw0KDQrirKJbemltQHRvb2xib3ggdS1ib290LmdpdF0kIGZkdGR1bXAgdS1ib290Lml0YiB8IGhl
YWQNCg0KKioqKiBmZHRkdW1wIGlzIGEgbG93LWxldmVsIGRlYnVnZ2luZyB0b29sLCBub3QgbWVh
bnQgZm9yIGdlbmVyYWwgdXNlLg0KKioqKiBJZiB5b3Ugd2FudCB0byBkZWNvbXBpbGUgYSBkdGIs
IHlvdSBwcm9iYWJseSB3YW50DQoqKioqICAgICBkdGMgLUkgZHRiIC1PIGR0cyA8ZmlsZW5hbWU+
DQoNCi9kdHMtdjEvOw0KLy8gbWFnaWM6CQkweGQwMGRmZWVkDQovLyB0b3RhbHNpemU6CQkweDQx
NCAoMTA0NCkNCi8vIG9mZl9kdF9zdHJ1Y3Q6CTB4MzgNCi8vIG9mZl9kdF9zdHJpbmdzOgkweDM3
MA0KLy8gb2ZmX21lbV9yc3ZtYXA6CTB4MjgNCi8vIHZlcnNpb246CQkxNw0KLy8gbGFzdF9jb21w
X3ZlcnNpb246CTINCi8vIGJvb3RfY3B1aWRfcGh5czoJMHgwDQovLyBzaXplX2R0X3N0cmluZ3M6
CTB4YTENCg0KPiAgYXMgd2VsbCBhcw0KPiBqdXN0IHRoZSBhY3R1YWwgZmlsZSBzaXplcyBvZiB1
LWJvb3QuaXRiIGFuZCBmbGFzaC5iaW4uDQoNCuKsolt6aW1AdG9vbGJveCB1LWJvb3QuZ2l0XSQg
bHMgLWwgdS1ib290Lml0YiB1LWJvb3QuYmluDQotcnctci0tci0tLiAxIHppbSB6aW0gODgyOTg0
IE9jdCAyNCAxMTo0MiB1LWJvb3QuYmluDQotcnctci0tci0tLiAxIHppbSB6aW0gOTM0NTA0IE9j
dCAyNCAxMTo0MiB1LWJvb3QuaXRiDQoNCj4gQWxzbywgaW4gc3BsX3JvbWFwaV9yZWFkX3N0cmVh
bSgpLCBjYW4geW91IGFkZCBhIHByaW50IG91dCB3aGF0DQo+IHNzLT5wYWdlc2l6ZSBpcywgYW5k
IGFsc28gYW4gdW5jb25kaXRpb25hbCBwcmludGYoKSBhZnRlciB0aGUNCj4gcm9tX2FwaV9kb3du
bG9hZF9pbWFnZSgpIC0gd2UgYXBwYXJlbnRseSBkb24ndCBoaXQgdGhlICJGYWlsdXJlIGRvd25s
b2FkDQo+ICVkIiwgYnV0IEknZCBzdGlsbCBsaWtlIHRvIHNlZSBpZiB3ZSBldmVuIHJldHVybiBm
cm9tIHRoYXQNCj4gcm9tX2FwaV9kb3dubG9hZF9pbWFnZSgpIGNhbGwuDQoNClUtQm9vdCBTUEwg
MjAyNC4wMS1yYzEtZGlydHkgKE9jdCAyNCAyMDIzIC0gMTE6NTY6NDEgKzAyMDApDQpUcmFpbmlu
ZyBGQUlMRUQNCkREUiBjb25maWd1cmVkIGFzIHNpbmdsZSByYW5rDQpTRUMwOiAgUk5HIGluc3Rh
bnRpYXRlZA0KTm9ybWFsIEJvb3QNCldEVDogICBTdGFydGVkIHdhdGNoZG9nQDMwMjgwMDAwIHdp
dGggc2VydmljaW5nIGV2ZXJ5IDEwMDBtcyAoNjBzIHRpbWVvdXQpDQpUcnlpbmcgdG8gYm9vdCBm
cm9tIEJPT1RST00NCkJvb3QgU3RhZ2U6IFByaW1hcnkgYm9vdA0KRmluZCBpbWcgaW5mbyAweDQ4
MDJiMDAwLCBzaXplIDEwNDQNCk5lZWQgY29udGludWUgZG93bmxvYWQgMTAyNA0Kc3BsX3JvbWFw
aV9yZWFkX3N0cmVhbSBzcy0+cGFnZXNpemUgMHgyMDANCnNwbF9yb21hcGlfcmVhZF9zdHJlYW0g
c3MtPnBhZ2VzaXplIDB4MjAwDQpkb3dubG9hZGluZyBhbm90aGVyIDB4YzkwMDAgYnl0ZXMNCnJv
bV9hcGlfZG93bmxvYWRfaW1hZ2UoKT0yNDANCnNwbF9yb21hcGlfcmVhZF9zdHJlYW0gc3MtPnBh
Z2VzaXplIDB4MjAwDQpkb3dubG9hZGluZyBhbm90aGVyIDB4MWFlMDAgYnl0ZXMNCnJvbV9hcGlf
ZG93bmxvYWRfaW1hZ2UoKT0yNDANCnNwbF9yb21hcGlfcmVhZF9zdHJlYW3vv70NCg0KPiBSYXNt
dXMNCg0KQ2hlZXJzDQoNCk1hcmNlbA0K

