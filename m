Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63CD4C46CA3
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 04:25:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98A358798F;
	Thu, 14 Dec 2023 05:25:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="aIVrpeZR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D77138718A; Thu, 14 Dec 2023 02:53:58 +0100 (CET)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on0631.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0d::631])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 845B58798E
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 02:53:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=joy.zou@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jO0p/TEAwVgxfjZYKkqOsIaUMn5jhgNj9lrUJMBJNieNfzkwomVNT8FX+H1w0iVip+Q1fSuwkr3z/+dIGmggZyUkumHcM/22eZ/As6VZzu58dUr+BKg/Mjb4YgaV4VwqaLF7NCuxvY3zTufJ4B3oJ3pzeOnSQ8uLFYx/nPVKHiqmRBuwYLBkjSqTsTgSD8xfRMuGz/YzigqJLbQOumlz/JSFrHRVoyQI69BeqzbH9SFcxaFjkd/3YtKb5ZPDZ9DcEYq63w8bAlkgpt0TDAJw2Rix8ZaLK4nqRaUlwIUisdWGP/chhq7ejLQJ2gEyZq4beoe7L1nf1qNTdUQDNLdPFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RjvpLO4qdG0JaCxTWZcq+/RxLG7cUoGYZN8CTT31cvw=;
 b=FNYISYFL8KEpcjtwDp7aijzr+boHyj+s6/M3re55vjyFq3yH8tuPD10Zhq3lj0ZZzv2QA7nnDPiAEKMMQwWh1lXvCFv4N9JqShqNVbMymwU7+ltaghl3wQ/zCQ+V1ZFsfqRa0niv08VekpFbjiIWodAeGlJQQsd1Ko7ul2boc7OB4Cc6B6VIGZ+SJl8oJBF0NH9eymB9SfcKEp0qCWRj5E9NnKfguxLesUaUjM98sVRVNLLAvB40XuIjQSGRhV4OajT6eIjeLkjhGG62QRoVICzBhdzsWE9/2USs9IlU142PHvHyADt16SKzNXRcYqXzC0zRHP05OPSQ37zLklNuEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RjvpLO4qdG0JaCxTWZcq+/RxLG7cUoGYZN8CTT31cvw=;
 b=aIVrpeZRCKR7UfbvH+NC+UpUZCRMviWMcomj4MBGQq5co86lDVWuQA89+1AcmFtPvUxSpy2lpb7UgVr3cfAtX9zdTlDUXa/kVLFk4G/hUZQ3E221hBwIuHDLF6rkIYV94aPOSNnX3p7f6E/55d8iaoiB4b32SowzsDwh4EouHOU=
Received: from VI1PR04MB5936.eurprd04.prod.outlook.com (2603:10a6:803:e1::18)
 by AM9PR04MB8586.eurprd04.prod.outlook.com (2603:10a6:20b:439::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 01:53:53 +0000
Received: from VI1PR04MB5936.eurprd04.prod.outlook.com
 ([fe80::b5d7:b27a:eb5f:69e0]) by VI1PR04MB5936.eurprd04.prod.outlook.com
 ([fe80::b5d7:b27a:eb5f:69e0%5]) with mapi id 15.20.7091.022; Thu, 14 Dec 2023
 01:53:53 +0000
From: Joy Zou <joy.zou@nxp.com>
To: Fabio Estevam <festevam@gmail.com>
CC: Chris Packham <judge.packham@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 "saproj@gmail.com" <saproj@gmail.com>, Stefano Babic <sbabic@denx.de>, Simon
 Glass <sjg@chromium.org>, U-Boot-Denx <u-boot@lists.denx.de>, dl-uboot-imx
 <uboot-imx@nxp.com>, Ye Li <ye.li@nxp.com>
Subject: RE: [EXT] Re: [PATCH v2 1/3] drivers: rtc: add pcf2131 rtc driver
Thread-Topic: [EXT] Re: [PATCH v2 1/3] drivers: rtc: add pcf2131 rtc driver
Thread-Index: AQHaLgAB8svUesRA1EKyMK4GcKaVe7CoBBMQ
Date: Thu, 14 Dec 2023 01:53:53 +0000
Message-ID: <VI1PR04MB5936F89E871F2F3C73C0039AE18CA@VI1PR04MB5936.eurprd04.prod.outlook.com>
References: <CAOMZO5BwEDh9NvQB8ht4bPq0G1EkYxaKXJPgFk7xpe6cjD4V7A@mail.gmail.com>
In-Reply-To: <CAOMZO5BwEDh9NvQB8ht4bPq0G1EkYxaKXJPgFk7xpe6cjD4V7A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR04MB5936:EE_|AM9PR04MB8586:EE_
x-ms-office365-filtering-correlation-id: afea1f0a-6bc9-4bee-e69c-08dbfc47867d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u97zQ+O5v36ShIYins5V+6XirkEHLljagINRdpPAscfPeQGqcMGkKi/yI6r3BIhM7fzT87QNl7o1sAMkaLiucyEjdgEKP7/7Gz7BlXujPqIcJag3iF2XUR1kXQI8iaZWH/BtQXhTE/ahHJ2VDUgFL4hbS4hf5PPWpe92YrNXNDGvDji3+xtKFybr73ewGUhBaWDrM0J5g+R/e/E800lZo7rHIC8dbaMLWZaxP7olqEf8srQiHQmSx3JgkwN9e10FIXpd3oSkl9YjhR42rXBzPKqfQT4Xi6xgeW86UTI4WxO0UBVtYXeKwEJjjJZ5zuU+hx76XkLITZLK0CsKUPFMCCX9UcH8uaYDr6/dAf6x+dwAk6Inpf3wc+AukFXgMbjRe2jkrEYEPq+A+4JU6loi8rk4/00z6luo4G8hQpE7gAG1SkZ8wYWTR4pPGaufKjGRW5W6IoIwhDFuAs8UfCqjRfzSdWJfsASHwEuEIvJwpsXQWW13rZ0ItOu1YXgBa+zbTzpq7HF6AkXfqXxRaOwugTvuRBETMyQxYJC/RPZGC3r57+IeK8UpHK2vGXqskhcn09fl5FijRlVbJmMTaMuGNbxjS2dA2GxzG6Y575e+sNbrOJ7uD2lCcquNYvLtgEyW9hTw0/C1cHdT2RpursZc7N5imCHLG5mHgO1/xhHV2M8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB5936.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(366004)(376002)(396003)(346002)(230273577357003)(230922051799003)(230173577357003)(1800799012)(186009)(64100799003)(451199024)(53546011)(7696005)(9686003)(6506007)(478600001)(83380400001)(71200400001)(26005)(2906002)(4744005)(5660300002)(41300700001)(316002)(64756008)(66446008)(54906003)(6916009)(76116006)(66556008)(66946007)(66476007)(4326008)(44832011)(52536014)(8936002)(8676002)(55016003)(33656002)(38070700009)(86362001)(122000001)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cWlIVWZBQ1pWdHQrWUZjT2EyTzZXazZjUkhLREhsKzIwSzZwWnMvblNlY3pv?=
 =?utf-8?B?SW01ZU1aYUlWVTFpT3d2cVI0cGRDNUpEeHp0Q290RjlncGJnZUZISldZQXV4?=
 =?utf-8?B?UHR6R0dSTVVXQ1VwZ0VZUUlGUkM5bkoya2pUVVJMci9QOFdSMGhmWUdWbzlP?=
 =?utf-8?B?S0c3SFc3OHgzd0pLb3hkUXZ5TDZYRys2a2J4WjBnUjkrcXJzOEdLRzA3YWpZ?=
 =?utf-8?B?K283Tmp0MmhYbVJrd2ErY0NGaUNhOFN5Wm5jUWd3cE9EeEZ4Sy9NN3Z1N1ov?=
 =?utf-8?B?bUVaR1ZkRkxzeTdrTzNoazZYRVJWeU5IbEtuUzBrcWNLQ3VYaWxiNEsvT0tM?=
 =?utf-8?B?MEduSUlHSGZBd1RoVXdWQlhzVFNZMDlXQTB0K25RNCtzY2MyaGFZclNqTnV6?=
 =?utf-8?B?TytPODI4MG5DTGd3eGpPV2tOdFhvYUI0SlNYUDdaeEVwVmx6TUhFS0oxR0ll?=
 =?utf-8?B?WUp5Yy8yR3FOWUxMOGY0ckVFenc4VVFJSmNEdlFFdjRUTVhIYlBwdnYycm42?=
 =?utf-8?B?eXZ0cmFaK29aUjBBc1RHMktaRENvTnJSK2FhamhRUFVURTJ5ejdsV2QrbC9H?=
 =?utf-8?B?d2M0OGdUT2R2SWhiWmZQV2RmdjhFOVQ4NmVSV3pBcElYLzBzNnUwcXorT0tY?=
 =?utf-8?B?c2duZVRDcExCeXNHREpzQjhNS0gxSlExMzF6RkdCclVOT1FEY00veStiZE56?=
 =?utf-8?B?Y0tkR0x0OU5HZWVJV25WcmE1OVpWbHAzeHdCK0FtN2RESFZ1VkwvdmxBYWl3?=
 =?utf-8?B?a2NrSXdmT25jMmo1ZThmVU5hTTJWVEszL2RNT0xIK2dXMzZ0OG10WURtUEFX?=
 =?utf-8?B?UEdQMGZ2K0lwNG8zZjRWTHB2cnh2UXJ5dENYVWtHRHZlWlFTcUpMSklYQ0pj?=
 =?utf-8?B?VmdSeVVjbDQyR1RWUTltcXRqZnB5YWNIa2R1N1FWU0xUckVzS2I0Si9FYkpF?=
 =?utf-8?B?eWdZRmF6UHVTTkpkbmNCZFUvRURSdjBDaWNLR1Yvb211ajdmbnQ0RStoVkFU?=
 =?utf-8?B?ZlNSV2xwQWkrZHRMa2JKSW01MmxPQmNBNnJzby9SQU9HSVZHRE0vUGd2UW5L?=
 =?utf-8?B?VVdSbEJsd0t5c0tFbEtSTWRtSURHUVhZMTBrQ2VabWY2N04vRFJydHpjTktw?=
 =?utf-8?B?Vmg2UithZjZKa0xXODB4Y1QvUmJ6QTdsQ3I1K2tpK1MrenJKbjQ3MWpaY0hn?=
 =?utf-8?B?dml0VWFScVJyR0VWZzNRbE55U3lIRDQySG51VWY1UDYySWl0U1RnUkswU05O?=
 =?utf-8?B?QWp3TkdvbjM2NDlSY2MzTGtSZGhGV2QzVWZwckpGSnBXbG5Sd1NiRW5tUVdI?=
 =?utf-8?B?Uk4xQnhEYzNnM3NBZFhIQ3R0Y0dka1RwbFRaczNndEVmeWhNTHBpdXFKdnhU?=
 =?utf-8?B?Vmd3b1F2TFVWMGhXNTRGeFRVN09SWm9OMWlQSnl1Q1JjUGoxYkJnaE5CTFNW?=
 =?utf-8?B?ckkxaU1BNVZVMHZzeTJlUDJHeEdteForQnpyWmFBTko3WWxOWDJreDVlUEpH?=
 =?utf-8?B?RjBpWTlUNWhoampPTDl1ZFNscVpkZ1FmVEVrd2wxU1cwNDliMmprQzZnSjZ6?=
 =?utf-8?B?ZVcyQ1NNbDZDRUQra2hrWkY1Z3hwajZKNEk0OEZqdVF5alN6bTdCeUNXNi9R?=
 =?utf-8?B?akt4WnJtMXJkSzRUNlduZHRhY0hkbFlGQlNxR0hBdFRjMUFEUE43MzNQNjR1?=
 =?utf-8?B?VUxQRmZPMjRxblU4UVRtNyt3ZURHUUxDN1JGMG9vWEVZd0JzNjg2VXYvdG1E?=
 =?utf-8?B?MTZRcnJEOGVJR3poTXhHQjlIamduUUZ3SmFzRmRjbitOQmxYZGxsM0Jhd1Uw?=
 =?utf-8?B?ZHFwblRjS0tGbHlqNmM4RWoydGVMeWYvUkpiRE5Lc3RmYmtqdEhpeCtEb1Js?=
 =?utf-8?B?NWF1T1pZeHphdEh4VXU3ejRKSjhxTEVWd05pb1liNXg3dXp5ZVlMY0hXMDI4?=
 =?utf-8?B?UHFKQ01DMW1lZEw3b00vV0N4RzhnWnNjSm1CMEVCelRleUlWNDVLQ1k4OWtV?=
 =?utf-8?B?M1pPWUdxZUhpSU10dTB2UjJzeStST1ZZbDdTbFdLSStURjdRRzB2OFlCNklH?=
 =?utf-8?B?QmRMdHNMWjQ2R00rZTFqSDJEK0huY3EyUWVUb295RVJkNjNXQTB3M2VtZVZU?=
 =?utf-8?Q?bhcs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5936.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afea1f0a-6bc9-4bee-e69c-08dbfc47867d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2023 01:53:53.2172 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DfXYA7brx6aCN8dPs7u4Mw2z12kcV+MLrpoRk6XtQt9mxBMNFEUN3JKvHjLzPq39
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8586
X-Mailman-Approved-At: Thu, 14 Dec 2023 05:25:17 +0100
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

T2thee+8jFRoYW5rcyB5b3VyIGtpbmQgcmVtaW5kZXIhDQoNCkJSDQpKb3kgWm91DQoNCj4gLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRmFiaW8gRXN0ZXZhbSA8ZmVzdGV2YW1A
Z21haWwuY29tPg0KPiBTZW50OiAyMDIz5bm0MTLmnIgxNOaXpSA0OjA3DQo+IFRvOiBKb3kgWm91
IDxqb3kuem91QG54cC5jb20+DQo+IENjOiBGYWJpbyBFc3RldmFtIDxmZXN0ZXZhbUBnbWFpbC5j
b20+OyBDaHJpcyBQYWNraGFtDQo+IDxqdWRnZS5wYWNraGFtQGdtYWlsLmNvbT47IFBlbmcgRmFu
IDxwZW5nLmZhbkBueHAuY29tPjsNCj4gc2Fwcm9qQGdtYWlsLmNvbTsgU3RlZmFubyBCYWJpYyA8
c2JhYmljQGRlbnguZGU+OyBTaW1vbiBHbGFzcw0KPiA8c2pnQGNocm9taXVtLm9yZz47IFUtQm9v
dC1EZW54IDx1LWJvb3RAbGlzdHMuZGVueC5kZT47IGRsLXVib290LWlteA0KPiA8dWJvb3QtaW14
QG54cC5jb20+OyBZZSBMaSA8eWUubGlAbnhwLmNvbT4NCj4gU3ViamVjdDogW0VYVF0gUmU6IFtQ
QVRDSCB2MiAxLzNdIGRyaXZlcnM6IHJ0YzogYWRkIHBjZjIxMzEgcnRjIGRyaXZlcg0KPiANCj4g
Q2F1dGlvbjogVGhpcyBpcyBhbiBleHRlcm5hbCBlbWFpbC4gUGxlYXNlIHRha2UgY2FyZSB3aGVu
IGNsaWNraW5nIGxpbmtzIG9yDQo+IG9wZW5pbmcgYXR0YWNobWVudHMuIFdoZW4gaW4gZG91YnQs
IHJlcG9ydCB0aGUgbWVzc2FnZSB1c2luZyB0aGUgJ1JlcG9ydA0KPiB0aGlzIGVtYWlsJyBidXR0
b24NCj4gDQo+IA0KPiBIaSBKb3ksDQo+IA0KPiBJbiBMaW51eCwgdGhlIHBjZjIxMzEgcnRjIGlz
IGhhbmRsZWQgYnkgdGhlIHBjZjIxMjcgZHJpdmVyLg0KPiANCj4gSSBzdWdnZXN0IHdlIGRvIHRo
ZSBzYW1lIGluIFUtQm9vdC4gVGhhbmtzDQo=
