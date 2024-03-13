Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B3D1C54791
	for <u-boot@archiver.kernel.org>; Wed, 13 Mar 2024 08:09:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C722F87DAF;
	Wed, 13 Mar 2024 09:09:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=toradex.com header.i=@toradex.com header.b="GAXul9VX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F4B087DED; Wed, 13 Mar 2024 09:09:26 +0100 (CET)
Received: from de-smtp-delivery-113.mimecast.com
 (de-smtp-delivery-113.mimecast.com [194.104.111.113])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EBF0875B9
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 09:09:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=toradex.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marcel.ziswiler@toradex.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=toradex-com; t=1710317362;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KiE66RHROd/4Fa/czNl7iMLLngjKaYX4aLK4McRzAig=;
 b=GAXul9VXl0k7DoXV6WwxWwzjdiTLrF0fT0OkTS443SvYf5AHw33rlvuVEFvNCf9HJN6NZ7
 upUm5spR/ujfYBSNdhVndcWR2ZwzkLx3rNWTS90KUqLPcR/+qAjl1/RmOwg7ZyJqnAfM7m
 uJKqEFHGCpK70l/CEjYiVa0zwxb1lMY=
Received: from ZRAP278CU002.outbound.protection.outlook.com
 (mail-switzerlandnorthazlp17010000.outbound.protection.outlook.com
 [40.93.85.0]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-38-ghT0csiaPKy4N8KSVErtdA-3; Wed, 13 Mar 2024 09:09:21 +0100
X-MC-Unique: ghT0csiaPKy4N8KSVErtdA-3
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 ZR0P278MB0775.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:4f::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.20; Wed, 13 Mar 2024 08:09:17 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::1a2c:bf89:a76e:a6a3]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::1a2c:bf89:a76e:a6a3%3]) with mapi id 15.20.7386.017; Wed, 13 Mar 2024
 08:09:17 +0000
From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
To: "festevam@gmail.com" <festevam@gmail.com>
CC: "peng.fan@nxp.com" <peng.fan@nxp.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, =?utf-8?B?Sm/Do28gUGF1bG8gU2lsdmEgR29uw6dhbHZlcw==?=
 <joao.goncalves@toradex.com>, Francesco Dolcini
 <francesco.dolcini@toradex.com>, Hiago De Franco <hiago.franco@toradex.com>
Subject: Re: [PATCH] colibri-imx8x: Fix sc_misc_otp_fuse_read() error check
Thread-Topic: [PATCH] colibri-imx8x: Fix sc_misc_otp_fuse_read() error check
Thread-Index: AQHadN6QOKSJLXfZck26glBot21dOrE1Ub+A
Date: Wed, 13 Mar 2024 08:09:17 +0000
Message-ID: <22748b1c9a5c563be179342562ec3650760552f2.camel@toradex.com>
References: <20240313003641.2650648-1-festevam@gmail.com>
In-Reply-To: <20240313003641.2650648-1-festevam@gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR0P278MB0683:EE_|ZR0P278MB0775:EE_
x-ms-office365-filtering-correlation-id: 16e9929b-b514-4332-0cd8-08dc4334e142
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: 1K2eleeKUO5KLHBP2BAfAOmfYIK6ncbSyU7GMEWPH+yq9PlWr3p6wSjcFMRa1EPLQeMO9N+rySlOYku3NMzBnO2JFWzmS5TO5vHNxdvJFAftOWB8PDWKwH9fGWX6w/KNZUOJV13jwG/rfcNWTnfh30K5CkXnqPFVqaTyi494Rp3f3q5//A+0xbnMfAOXn33ANamo180epXLsONdic8A83PEpOM8En7fHMqxWNnNdg4QmpcMAw7yuOhyYiamJViiL+qCkrQka7xh2bTOhCXFVZe9aTBL7ONwmYAcnKL8Ut6uPEyYBisv2zY/zP8nEGy5I9UX0FIfx6mYWf7tgeV3KVBTBPNGpXEY+IcKcPcAhIcv2sg3x96byHfPwWY6s0xI98F4FI8slEYo4LMzhWKV9h9RWkcGBvjYXZE1unNZ5SStS5beFOrjfXKUCcfEy2aFKV+oFpEv5lrZOwTGLIoN8rXfrjlOVtwEE/uMHWGIutchhaj4kNODU9gyFE2MK97R1BzIb0xyxOQI2lvGZ9AwGpyTyLrYYZTy1skaPbve1fNe0Auhk5Bu+SNfS5AVuWHSG2k2g0p4OAgPjbCRPcloywf1juufh1k7oCUlq0pT+17WfmXopMFN6uLEVMOX2Uvc3BCmDmQ8PmbPAcg66uFivTr07uz1KniLXGJOXqkgbSwdNK/p8v+JfqCgkhp9CZ2ETaIojBW9lkg/lv2IZ/rEZUfAOU7bWcwCGIoabbnyrVpY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L3JpN3hxTXJoV3FzNTV0YkFpRzF5eVRzUTlPMWx0L3NvckdUN29Ha21qV3Bs?=
 =?utf-8?B?N0h3YnExalJmTWNFREtMOUwwYm05YVpsS1lTcFlPalhhVENHRHU4L0lRdnJo?=
 =?utf-8?B?a0hrYlpLbldmRDJxTUhxQk9OL01LSjdwdlluaHN4R3o2ZlhueU1EMU5meUlG?=
 =?utf-8?B?SWVBRXBQa1Q3RDRMMkVjTG5Kc1A4REV2TVNHSGRQMkdVaHhDNEFTN2RXTUFw?=
 =?utf-8?B?WFBOeUFuMFB1TTQvZi9QeHpsNVozbUtVY2tkUlNmY0NTTkl2VU1uc2tnQ2xq?=
 =?utf-8?B?S0VwbVBwakgvR3JBMCtwME1Pa1NzZnI1WndhRW5VUjBKUXRVNEtGRzR2Vjho?=
 =?utf-8?B?eG9IZDdkYlk1TWl4dlgvUGw0d3AxVnptZysrcjJicHNUT2sxZUw3Mm0xZGEw?=
 =?utf-8?B?UDEvYUhKUjEwM2hZWTJ4dThac1NEaGxzWG9wZ0FnMTh2SThOZW5VQmpKNU9K?=
 =?utf-8?B?SzhGd001VTZKd1A1QTNpSmhOczdrK29iQXZIZ3pLWC9oejhFekFKS1ByeGpa?=
 =?utf-8?B?SmxZTU90TmRhaVljYWxXSE9acGtmVWRyQ1Fka2gxSFlLTnQ1NEtUZThrMVVO?=
 =?utf-8?B?dmpoRkFmVmc4S002M245NjlidWUzOGNSTjN2M201TXI5ZGpUNFVMTlFGL3Jo?=
 =?utf-8?B?ZDBNTXBNSGlLNDVmMXUwWDMxb1JtbFJmbDd5bGg0cy9Cd1ljT3VaeDhHVzF2?=
 =?utf-8?B?VDdKMmZtcDk4WXI5dnRWZWY3ZWMxRTEvbE9nQU1DczdCbjZoam1DU25SOWhh?=
 =?utf-8?B?a1JUOXlPZ0xSOFVWYml5Ym9LMDVrVnZ6K2I0Q1pSZUt6bnJXczMxS0svYm9a?=
 =?utf-8?B?ZGtOTTIrUXJtS2ZsdjdjUmhBY2hKMUlxOENqQkVtdGZYQ3JYNzYvRS96NDNP?=
 =?utf-8?B?RnNTR2JxNG1USm5CRlVRZzBqaHBqUDJRRFhPVFYxWm05clVmZFRHVWVjYWtx?=
 =?utf-8?B?TDhucmRXOFBZTlpRVmlkRHdrV0pwdDFNTk9sdnZCQkdURWM2bnBJTTBJY2RQ?=
 =?utf-8?B?OHRYY1l6STQvWGZBNm1DNm1WM3lOaUE4UmlRNXQwRmpUOG9nVGRGV0VBQzVG?=
 =?utf-8?B?VFNJcWpmMzdSTHdVUzlYb05yb2tQWWVSZXVtU1FSMTc4SnUvY1RXcmV1Y1BN?=
 =?utf-8?B?K25nTVhNWjdrZjBhamY4M1YvbmNjbTZqekx4by8waURQQlkvRnN4UUxFL0hw?=
 =?utf-8?B?QjZkZUZvTVdCWEkzNTQrQU9NSzd3aUpSS0FzMDRvaERQcm1vTjJyVlkydXZN?=
 =?utf-8?B?L2ZycVd1QU5WR3pUaXB0ZEtYWFRuUHJ0YzVHVDd1K0pXT3krNDFWMFBMcWU2?=
 =?utf-8?B?NFRNaER5TkRENENPRkY4MEErdzRXKzIrVGdHQVFVZVViVUtyS2Fkc3pzZ0Rl?=
 =?utf-8?B?bmczSnN6K3F2VmtSeGZodFNXazlqa2RlVEY4MmpZMFRVeXVyWEkyTGhRVzA0?=
 =?utf-8?B?SHQxN2hZNjJzbGE3dU9rNFExaG9oSFhQZHFFY1pIWHVrVWlScmF3cmJJQXFN?=
 =?utf-8?B?ZnZBYTlVZ29Db1ZBZ2dZayswOVhFOHRZS0dZbVJ6SHp2NmVLSjgzeHNWT0Vo?=
 =?utf-8?B?Q3ZTM1FNSFVneVRqQzVxS2dtSWhCcVN0eVY0MzJKb2RuNExzUUFReFFRa3pI?=
 =?utf-8?B?aExwOFg4OHZmOGxrM2JQVVVnL0NCRUc4NzZaUTl0dllMcjJ6MmloTmVmQWZ1?=
 =?utf-8?B?OEZ0ZklJc2RnemtNVTg0YnBPcjd5a2UyTTBBOE5hR2VwUUkxRE5QdHE3bWhw?=
 =?utf-8?B?ZktiaDZWa3FoOEVwaXhQWHdiRERhOUlzNG9MSjNDNDhVbW9mK3VLTWdaYzdv?=
 =?utf-8?B?Q0ZWbUZYT3NYWGI5bVJpWHEvNlpaeHRtcGk5OGpUTTlsSFRyaE0rWFl5WDJp?=
 =?utf-8?B?cStNNURLaTd0RDJYUjNDZC9oVU9OYWFnNFNqUGVRZ3FISXhoSGJkZm14UWZy?=
 =?utf-8?B?Z2FEcW5NTHhmYlFjVERxSzhCbWtXTWhoWDlZTVl5c3RzejhhNS9hRWtsNlZJ?=
 =?utf-8?B?Y0dQNG1xd1NyclRMMVRFTVZ5Nk5SVmdXYUMxK1c1Q0liWVpucUIxVGwyOVV1?=
 =?utf-8?B?RElQcVRrTHdJRlNHazNsQUJOVE1CTUdhdmVtZjIwQm1DWjRwcmhiTHJua2Zo?=
 =?utf-8?B?bUt5RFRMMzdEeEpTREc4V255cTJtRzNMYlVwaU53NStZQkJmMmJWZ1lKYlRS?=
 =?utf-8?B?NVE9PQ==?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 16e9929b-b514-4332-0cd8-08dc4334e142
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2024 08:09:17.5801 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VTc+PJGW9b8WfaZ19Q392bpEDcAxmcz2dr37te/ut3FplV67C2dVvk+g4nWdZccM8A3jkRc/CmrzbNVM+FVIQMAVUgP5fWl1A22yDIKQSc4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0775
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <51FE31FF5D15E046ADB55F41F9A40B33@CHEP278.PROD.OUTLOOK.COM>
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

SGkgRmFiaW8NCg0KVGhhbmtzIQ0KDQpPbiBUdWUsIDIwMjQtMDMtMTIgYXQgMjE6MzYgLTAzMDAs
IEZhYmlvIEVzdGV2YW0gd3JvdGU6DQo+IENvbW1pdCBhYTZlNjk4YTdhY2QgKCJpbXg6IHRvcmFk
ZXgvY29saWJyaS1pbXg4eDogY29ycmVjdCBTQ1UgQVBJIHVzYWdlIikNCj4gbWFkZSBhbiBpbmNv
cnJlY3QgbG9naWMgY2hhbmdlIGluIHRoZSBlcnJvciBjb2RlIGNoZWNrIG9mDQo+IHNjX21pc2Nf
b3RwX2Z1c2VfcmVhZCgpOg0KPiANCj4gLcKgwqDCoMKgwqDCoCBpZiAoc2NfZXJyID09IFNDX0VS
Ul9OT05FKSB7DQo+ICvCoMKgwqDCoMKgwqAgaWYgKHNjX2Vycikgew0KPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgLyogRFggaGFzIHR3byBBMzUgY29yZXMgZGlzYWJsZWQgKi8NCj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAodmFsICYgMHhmKSAhPSAweDA7
DQo+IMKgwqDCoMKgwqDCoMKgIH0NCj4gDQo+IFRoZSBvdGhlciBjaGFuZ2VzIGluIHRoaXMgY29t
bWl0IGFyZSBjb3JyZWN0Lg0KPiANCj4gc2NfbWlzY19vdHBfZnVzZV9yZWFkKCkgcmV0dXJucyAw
IG9uIGEgc3VjY2Vzc2Z1bCBmdXNlIHJlYWQuDQo+IA0KPiBUaGlzIGludmVyc2lvbiBjYXVzZXMg
Ym9hcmRfbWVtX2dldF9sYXlvdXQoKSB0byByZXBvcnQgaW5jb3JyZWN0IFJBTSBzaXplLg0KPiAN
Cj4gR28gYmFjayB0aGUgb3JpZ2luYWwgZXJyb3IgY2hlY2sgbG9naWMgdG8gZml4IHRoZSBwcm9i
bGVtLg0KPiANCj4gRml4ZXM6IGFhNmU2OThhN2FjZCAoImlteDogdG9yYWRleC9jb2xpYnJpLWlt
eDh4OiBjb3JyZWN0IFNDVSBBUEkgdXNhZ2UiKQ0KPiBSZXBvcnRlZC1ieTogSGlhZ28gRGUgRnJh
bmNvIDxoaWFnby5mcmFuY29AdG9yYWRleC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEZhYmlvIEVz
dGV2YW0gPGZlc3RldmFtQGdtYWlsLmNvbT4NCg0KQWNrZWQtYnk6IE1hcmNlbCBaaXN3aWxlciA8
bWFyY2VsLnppc3dpbGVyQHRvcmFkZXguY29tPg0KDQo+IGRpZmYgLS1naXQgYS9ib2FyZC90b3Jh
ZGV4L2NvbGlicmktaW14OHgvY29saWJyaS1pbXg4eC5jIGIvYm9hcmQvdG9yYWRleC9jb2xpYnJp
LWlteDh4L2NvbGlicmktaW14OHguYw0KPiBpbmRleCAyYzY3M2E0YTZiMDYuLjZmYzgwNzYxNjNj
NiAxMDA2NDQNCj4gLS0tIGEvYm9hcmQvdG9yYWRleC9jb2xpYnJpLWlteDh4L2NvbGlicmktaW14
OHguYw0KPiArKysgYi9ib2FyZC90b3JhZGV4L2NvbGlicmktaW14OHgvY29saWJyaS1pbXg4eC5j
DQo+IEBAIC00Niw3ICs0Niw3IEBAIHN0YXRpYyBpbnQgaXNfaW14OGR4KHZvaWQpDQo+IMKgCXUz
MiB2YWwgPSAwOw0KPiDCoAlpbnQgc2NfZXJyID0gc2NfbWlzY19vdHBfZnVzZV9yZWFkKC0xLCA2
LCAmdmFsKTsNCj4gwqANCj4gLQlpZiAoc2NfZXJyKSB7DQo+ICsJaWYgKCFzY19lcnIpIHsNCj4g
wqAJCS8qIERYIGhhcyB0d28gQTM1IGNvcmVzIGRpc2FibGVkICovDQo+IMKgCQlyZXR1cm4gKHZh
bCAmIDB4ZikgIT0gMHgwOw0KPiDCoAl9DQoNCkNoZWVycw0KDQpNYXJjZWwNCg==

