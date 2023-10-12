Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1558FCDB46E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 12:30:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31D1386E7A;
	Thu, 12 Oct 2023 14:27:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=sysproconsulting.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=sysproconsulting.onmicrosoft.com header.i=@sysproconsulting.onmicrosoft.com header.b="WxoDqqaC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88E4686DED; Thu, 12 Oct 2023 06:04:00 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20706.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::706])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88CB186DED
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 06:03:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=sysproconsulting.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=JayTalbott@sysproconsulting.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WNwL6CdjSBhUKvbL7pezv4y1l9LqJwOSm5jOMXwV0GGYQH9VHIuF2e824ifsST8ewbJ+iHv2QjO4iGNpIBf4KWlwdm8G/5K58K4FEuaB8lLI9rDSXP9STNbyqDXCqr2XH8GROgA2mqW1f5t2Y+R8AsoWBAa3PM8YDRrNOHPDZi55dkfg094sY31eYsDLEnZ4lqPBTrttUQZ0N8LUZdRPRUxjwmieWQetKQ1smLA4/57HOb5zG/WLk8XNyq5Ezw9EYBgPXLR8z4AJ9NjYzV279Uhz/FFjkd9bAb15FXxAjPprQNHtUWA2+mGIF5/mm+eXNnnP2cJQqUaq1BUAvzYQ2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rFkzo+yRIll7lBIgIHIQVPkRbKj1akvN0EcH5ujLC1A=;
 b=NUL8cXjFNvU1ot0Dh7WUyUcHtDBYtW8ZlSBJHwy88pe4EoBvRrtmK5Cdxs3BrEmSq4v0pT3jzi6NrmhXWc0BhjHRUxpTMDCjMfzlDmgnYiU+OmMtnchCNzQrkqULWrXhiWTPNOaXACzadHix2abi1z8MdbY8cXG9nFbmC8prSBUKlMcBIXvRBtf5LOB4fxYjBdJ9zXylebtm12cxHAMF4Y8q1dCUhzh+/BBBCnbIxOWOCzGgy+xf3Kd3psNYwM22lb1BkcJjhZdd3fYNRIOtKeLl04DiqB/W5Uyr6gVRGP0Jin39U8BfEZHir0LZc7OxfJlXiczu4ng2j0L+QCvHJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sysproconsulting.com; dmarc=pass action=none
 header.from=sysproconsulting.com; dkim=pass header.d=sysproconsulting.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sysproconsulting.onmicrosoft.com;
 s=selector2-sysproconsulting-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rFkzo+yRIll7lBIgIHIQVPkRbKj1akvN0EcH5ujLC1A=;
 b=WxoDqqaC0gmRbnPxooeLjbQUJoo7yJTHfVW4x7vUeRPnYsDS4zlF0S9pAs6ejOv9o7Po4l++CCNNQBq2XBHQerdmUavCZeypZzg+MShnhl7BS/YoGJfBb2b+1CnZRB2onWb0sau+rv/OFRQ4Rjbky/IpDCAY1yrRpptSDByjkVY=
Received: from DM6PR22MB2262.namprd22.prod.outlook.com (2603:10b6:5:2b0::15)
 by CH2PR22MB2006.namprd22.prod.outlook.com (2603:10b6:610:83::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 04:03:50 +0000
Received: from DM6PR22MB2262.namprd22.prod.outlook.com
 ([fe80::c7dc:236c:28ca:3aaf]) by DM6PR22MB2262.namprd22.prod.outlook.com
 ([fe80::c7dc:236c:28ca:3aaf%3]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 04:03:50 +0000
From: Jay Talbott <JayTalbott@sysproconsulting.com>
To: Simon Glass <sjg@chromium.org>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: coreboot 4.11 + U-boot master
Thread-Topic: coreboot 4.11 + U-boot master
Thread-Index: Adn8rpZLilu83j91QQKlflGMUcs7ZgAD+6+AAABqnnA=
Date: Thu, 12 Oct 2023 04:03:49 +0000
Message-ID: <DM6PR22MB226237E796813B4981D73827BBD3A@DM6PR22MB2262.namprd22.prod.outlook.com>
References: <DM6PR22MB22626D184E4A7038A3648C97BBD3A@DM6PR22MB2262.namprd22.prod.outlook.com>
 <CAPnjgZ28JE+8Tb4ft-B73fey_TOiWuJ1tyrxgOSwAMEud==iEQ@mail.gmail.com>
In-Reply-To: <CAPnjgZ28JE+8Tb4ft-B73fey_TOiWuJ1tyrxgOSwAMEud==iEQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sysproconsulting.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR22MB2262:EE_|CH2PR22MB2006:EE_
x-ms-office365-filtering-correlation-id: a298d734-9bc1-457f-2250-08dbcad83d90
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: siIDr0Qo72DLeuRj0DpNGICY7uCNBrDgZhVC/06fTD8NecKMMA6sOVSeUXB+5UI5y9WJIepBPcIfYfoRX2ZXJhXNsb5rq/lmrbGnhpgAdReGlBjZ84lRe65Mb8LMIQsrZV2p6cc/PzSkZ+Xf+vlPuUUnO3IHtZqQrzIoWBU+JGNDgzy8lFR2yTvYasH63wmXGbAN+lWG1ULA6M8IAClFQ/e8Mi6qS+2ohZ8ev7xImJ+uyEwfCMTRwjRwvLzSN7GShee99zRsB7+SgETQ/FgCtEDJfjBsFA+r4/J4YhboJIXftHubQ2OSIihkir3glRLkRMX0OG/uNWzWmsjHB/YhdOjVPaGpMU4Vh8B8uLqnQ+oKbEavE1VSiGp5MnsqelnWfxmyqFVZzhasqhWuxm10IGnTzxGlQuwjbdZX4EcnZWrXCWCGvS0ojZeyeVBt8vsRCUG8SIUnAaJ8GnikuD6FKENHPMk3wFxqw6G6dIVjSwKb9lvWdV8qIu2uM52A1pHPTo4A5Coz6N8jxLu80kEJGxBCbKTKLFqq7fqgmDlncUiTEf6RjtHIIzze8u1FJCkSByZ13tdCfI2YWHZcpdtYIVBpm6aHK7l0YlRIMFFsHvo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR22MB2262.namprd22.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(42606007)(39830400003)(136003)(396003)(366004)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(71200400001)(2906002)(966005)(478600001)(41300700001)(4326008)(8676002)(8936002)(52536014)(5660300002)(55016003)(66556008)(66946007)(76116006)(64756008)(66446008)(66476007)(316002)(6916009)(7696005)(83380400001)(33656002)(26005)(6506007)(40140700001)(9686003)(122000001)(53546011)(86362001)(38070700005)(38100700002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OVk4Y0U3TFQrTXR2MVV2cnJOQzJWUHN3WEpnQ2gvV3ZkZWkxMjhjL0kwanZU?=
 =?utf-8?B?YzZiWGRXV2ROV3FqalhGVGVlSnJOam53YjlUL05xcW5nYytWcmpYczZacHlL?=
 =?utf-8?B?NWZmbSthYzdnVTlVK1RtSHV5K3dLRm9TOGdlTEJzcGl2eXlHSk9EVmtkZ0Vq?=
 =?utf-8?B?c3VrNERDWVMzOXgzT1J3MmwrZWJjL3haZmhzU1FmVEhIejVvcWtHN0VDTVlZ?=
 =?utf-8?B?TjJXRTZhTG9BUnZSTS96TzhZOXFEVTU2bzd2TG55R29hd29Ud3IycjNyTWY2?=
 =?utf-8?B?c1RHUyt1bytTelBHRUFPcGI3bk10ZDZEb3FCTm1pZDNUS1ZQRFNCSlVjN0xU?=
 =?utf-8?B?WmVpUllZVkVLNC9WdjdxalY5TXdVYW16N0JKVkd6MndYV1ZPeThkemZMNmVT?=
 =?utf-8?B?d1plTzdiZ3lENVVKQTRuQUkxb3FXdkxhUElDNWtGd25yTFQvU3NPclROWE9h?=
 =?utf-8?B?QW1ic1F4OGlxU0VEZU5Bc0cvK0xBYkRzQWFpd2kxZ3haTDdHNE9DT3FYRHBC?=
 =?utf-8?B?UUliNTE0bVU2Rnp4a1RXbXFCTUlha2M3L3YwTGcxbUFXUExLT0tuRlEzd3FW?=
 =?utf-8?B?MGJiOEZFY3R5MnAwc0hzZjhFcmpVc20va0xmdGhONnliZ0xQWDJpblFBQTJY?=
 =?utf-8?B?K0Irb0tKWmVkOVZlOVRBMTFaUmE0ekJtQnFIeGpqWU9yNHV4MEhTbE1HWmZ0?=
 =?utf-8?B?ZDE5dUFnek0yNzlXaUlsN0RKTW1TcHA0Vzdmb0VuQnY2aGhKaXBQWVp4Kzcz?=
 =?utf-8?B?dmttSVE5bFAvdnduMmZSeUZrTU44Uk5WWmZxK3hQQjV5YjJralUrNHpzalBr?=
 =?utf-8?B?QTR0ZVhxVjU2SUlKN1FGbXQrWnBqTEtreEs1TXJINjdxM3hIYmNSWUtKNDh3?=
 =?utf-8?B?MEdkcW5SbVNRMVlWOTBrWmFCakZFaXhkNTgxVjBvZVZwZDk0VVoxdjlWSjVl?=
 =?utf-8?B?NGJ2VUNtR1RKSytXOTE1Q01keHhNL09QU0lHNGt6Yml3bk1oL3JFTmdKVGdO?=
 =?utf-8?B?czdyS3lpcUducG1uWHRGMHUrYmEyZjlxSis5TWdRcTlEY2h6TE4wa05TQURo?=
 =?utf-8?B?Y09saUd3cDZQbWV4V1VlZXZuNWk2Rld3ZEk3bis2M0ZIb2FpYkoxSWJFOXZw?=
 =?utf-8?B?aFdmRUYvSEVxYU5jVUhsRDlOeEZ0MGZLRXB0WFdaYWhkWXB5azV4Y09YUmp6?=
 =?utf-8?B?OGVXekl2aWwrd093NEhlaTVPbGtaRDRjbDJYU2dSWVFzQWN0aW1XalowMHRv?=
 =?utf-8?B?UnEybkVFRHg3MVdhNHcxRnF6RnNnaS9UQmxGb2dyeDNTQ3F2SWlhSWdnY2Ew?=
 =?utf-8?B?UXhvaVZDUXhDL0ZVdWtwcFhYUGY2OUJYUEZDSDFMM1A1VlhIRW56bzk5dU5B?=
 =?utf-8?B?WnNyMzh3TFV0RTlVaEpady90YitLcEYrNkI4YlJSZzU4cXVnZW5xejByU1hy?=
 =?utf-8?B?WitVWkw0Zll1UitkWW9aNmI4L3ljWGlwS3FoUm1nVUk2cnZuajNNeXplRjI2?=
 =?utf-8?B?aDJFSDJzUTU0RStOTHdMUUpsdTNSa05Rc1RiUjRrN0pIVWFxSVNnL3pFdlRD?=
 =?utf-8?B?MFhGMmo3K05UbXYzNUJIc0Y1N3owMWtKcnZ0NUMxQUljdmUrZ0N1bitzYkFy?=
 =?utf-8?B?RStvSUNYdzJBc2NvUzFTdVFpVDk3UjhXNEZlMS9PNGdEVDJySzFNTkRtamtj?=
 =?utf-8?B?bzllZjRWSWM0R2RGY0hOU05WTDlWNElURjJlVzJoZWxFd29yaEZ1dW10aWc5?=
 =?utf-8?B?NWZTRHNLQzU5RTg2K0wrdWxDeXdsMkpaSzlzOXhFSUo4VWxJRFFYakJBWUh2?=
 =?utf-8?B?eXYvUitWam94dWxMV2xObmIxaU5YTzdZanVUd3BtUERQMEpWUWlQaklHRnc2?=
 =?utf-8?B?QjZKTEVJNktWKzFoZ0pqOWtGck8rOVhjcFJsYzJVbTdQazRvRDB2ejNBU29l?=
 =?utf-8?B?NElUTVJrM2R5NzU5MUlkTTNDZFBVTFFheE9NdTVoMFYrS2tYZWpkWVhnQjB1?=
 =?utf-8?B?UHl4R09ZcmRQS0VscUEvMHQ5ekdzaHVRNnpncjFXNWFCVzNiTUFtaXZRUStN?=
 =?utf-8?B?Ly9xdFM4UE9udzBnQm1EUnYyMy8zN3ZNSTZiKzNDWjY0aXAwSDJvaUYzWGxL?=
 =?utf-8?B?eUxsTE9KVCs2Kyt4YXlSSldBM0o3V3dycDY2R25xc3JacTQxc3Z6WE5FUHBh?=
 =?utf-8?Q?LTkVrpFByOAEHjsBUD1muyXFUen1y0awuhAchRwYs+Mu?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sysproconsulting.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR22MB2262.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a298d734-9bc1-457f-2250-08dbcad83d90
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2023 04:03:49.7173 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 654c0bc4-2c8d-4f52-9ae4-b268875b4e10
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: knYuHg2uLkVeJSM/a7SjqBZqze6Se4mk9BhXjsWnYa155kQt7i9seUzUbcAqUdMZQlITnkgE+Z1bl89E/GArERtwwkZcUn3RDh1J82dnD7fzx0TNno9VadNA8Zyf5snPZhxI1Aa2VIqDKYeld6LL5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR22MB2006
X-Mailman-Approved-At: Thu, 12 Oct 2023 14:26:41 +0200
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

SGkgU2ltb24sDQoNCkkgaGFkIG9wZW5zc2wgaW5zdGFsbGVkLCBidXQgYXBwYXJlbnRseSBub3Qg
bGlic3NsLWRldi4gQnV0IHdoZW4gSSBhZGRlZCB0aGF0LCBpdCBzdGlsbCBmYWlsZWQgaW4gdGhl
IHNhbWUgc3BvdC4gU28gdGhlbiBJIGp1c3QgaW5zdGFsbGVkIGFsbCB0aGUgcHJlcmVxdWlzaXRl
cyAoY3V0L3Bhc3RlIGZyb20gWzFdKSwgZXZlbiB0aG91Z2ggbWFueSBvZiB0aGVtIHdlcmUgYWxy
ZWFkeSBpbnN0YWxsZWQsIGFuZCB0aGVuIGl0IGZpbmFsbHkgYnVpbHQuIFNvIGF0IGxlYXN0IEkg
aGF2ZSBzb21ldGhpbmcgYnVpbGRpbmcgYXQgdGhpcyBwb2ludC4NCg0KV2Ugd2lsbCBuZWVkIHRo
ZSA2NC1iaXQgYnVpbGQuIE5vdCBzdXJlIGlmIGl0IHdhcyB0aGUgcmlnaHQgdGhpbmcgdG8gZG8s
IGJ1dCBJIGRpZCBwdXQgY29yZWJvb3Q2NF9kZWZjb25maWcgaW4gbWFrZSBtZW51Y29uZmlnIGZv
ciB0aGUgVS1ib290IGNvbmZpZyBmaWxlLg0KDQpJZiB5b3UgaGF2ZSBhIHBhdGNoIGZvciBtYWtp
bmcgdGhlIDY0LWJpdCBidWlsZCBhbiBvcHRpb24sIEknbGwgbmVlZCB0byBhcHBseSB0aGF0IHRv
IHRoZSA0LjExIGJyYW5jaCBmb3IgdGhpcyBidWlsZC4NCg0KVGhhbmtzIGZvciB5b3VyIGhlbHAh
DQoNCi0gSmF5DQoNCkpheSBUYWxib3R0DQpQcmluY2lwYWwgQ29uc3VsdGluZyBFbmdpbmVlcg0K
U3lzUHJvIENvbnN1bHRpbmcsIExMQw0KMzA1NyBFLiBNdWlyZmllbGQgU3QuDQpHaWxiZXJ0LCBB
WiA4NTI5OA0KKDQ4MCkgNzA0LTgwNDUNCig0ODApIDQ0NS05ODk1IChGQVgpDQpKYXlUYWxib3R0
QHN5c3Byb2NvbnN1bHRpbmcuY29tIA0KaHR0cDovL3d3dy5zeXNwcm9jb25zdWx0aW5nLmNvbSAN
Cg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFNpbW9uIEdsYXNzIDxz
amdAY2hyb21pdW0ub3JnPg0KPiBTZW50OiBXZWRuZXNkYXksIE9jdG9iZXIgMTEsIDIwMjMgODo0
NSBQTQ0KPiBUbzogSmF5IFRhbGJvdHQgPEpheVRhbGJvdHRAc3lzcHJvY29uc3VsdGluZy5jb20+
DQo+IENjOiB1LWJvb3RAbGlzdHMuZGVueC5kZQ0KPiBTdWJqZWN0OiBSZTogY29yZWJvb3QgNC4x
MSArIFUtYm9vdCBtYXN0ZXINCj4gDQo+IEhpIEpheSwNCj4gDQo+IE9uIFdlZCwgMTEgT2N0IDIw
MjMgYXQgMTk6MDMsIEpheSBUYWxib3R0DQo+IDxKYXlUYWxib3R0QHN5c3Byb2NvbnN1bHRpbmcu
Y29tPiB3cm90ZToNCj4gPg0KPiA+IEhpIFNpbW9uLA0KPiA+DQo+ID4NCj4gPg0KPiA+IFNvIEkg
Z2F2ZSBpdCBhIHdoaXJsIHRvIGRvIGEgYnVpbGQgb2YgY29yZWJvb3QgKG9uIHRoZSA0LjExIGJy
YW5jaCkgd2l0aCB0aGUgVS0NCj4gYm9vdCBwYXlsb2FkLCBzcGVjaWZ5aW5nIFUtYm9vdCBtYXN0
ZXIgdG8gZ2V0IHRoZSBsYXRlc3QgdmVyc2lvbiBvZiBVLWJvb3QuDQo+ID4NCj4gPg0KPiA+DQo+
ID4gVW5mb3J0dW5hdGVseSwgaXQgZmFpbGVkIHRvIGJ1aWxkIHRoZSBwYXlsb2FkOg0KPiA+DQo+
ID4NCj4gPg0KPiA+ICAgICBDbG9uaW5nIFUtQm9vdCBmcm9tIEdpdA0KPiA+DQo+ID4gQ2xvbmlu
ZyBpbnRvICd1LWJvb3QnLi4uDQo+ID4NCj4gPiB3YXJuaW5nOiByZWRpcmVjdGluZyB0byBodHRw
czovL3NvdXJjZS5kZW54LmRlL3UtYm9vdC91LWJvb3QuZ2l0Lw0KPiA+DQo+ID4gcmVtb3RlOiBF
bnVtZXJhdGluZyBvYmplY3RzOiA5NDU5MjcsIGRvbmUuDQo+ID4NCj4gPiByZW1vdGU6IENvdW50
aW5nIG9iamVjdHM6IDEwMCUgKDY2MjIvNjYyMiksIGRvbmUuDQo+ID4NCj4gPiByZW1vdGU6IENv
bXByZXNzaW5nIG9iamVjdHM6IDEwMCUgKDI0MTgvMjQxOCksIGRvbmUuDQo+ID4NCj4gPiByZW1v
dGU6IFRvdGFsIDk0NTkyNyAoZGVsdGEgNDIzMiksIHJldXNlZCA2NDk2IChkZWx0YSA0MTU5KSwg
cGFjay1yZXVzZWQNCj4gOTM5MzA1DQo+ID4NCj4gPiBSZWNlaXZpbmcgb2JqZWN0czogMTAwJSAo
OTQ1OTI3Lzk0NTkyNyksIDE5MC4yOSBNaUIgfCA2LjAxIE1pQi9zLCBkb25lLg0KPiA+DQo+ID4g
UmVzb2x2aW5nIGRlbHRhczogMTAwJSAoNzkzNzIwLzc5MzcyMCksIGRvbmUuDQo+ID4NCj4gPiBV
cGRhdGluZyBmaWxlczogMTAwJSAoMjAxMzYvMjAxMzYpLCBkb25lLg0KPiA+DQo+ID4gICAgIEZl
dGNoaW5nIG5ldyBjb21taXRzIGZyb20gdGhlIFUtQm9vdCBnaXQgcmVwbw0KPiA+DQo+ID4gICAg
IENoZWNraW5nIG91dCBVLUJvb3QgcmV2aXNpb24gb3JpZ2luL21hc3Rlcg0KPiA+DQo+ID4gQWxy
ZWFkeSBvbiAnbWFzdGVyJw0KPiA+DQo+ID4gWW91ciBicmFuY2ggaXMgdXAgdG8gZGF0ZSB3aXRo
ICdvcmlnaW4vbWFzdGVyJy4NCj4gPg0KPiA+IEJyYW5jaCAnY29yZWJvb3QnIHNldCB1cCB0byB0
cmFjayByZW1vdGUgYnJhbmNoICdtYXN0ZXInIGZyb20gJ29yaWdpbicuDQo+ID4NCj4gPiBTd2l0
Y2hlZCB0byBhIG5ldyBicmFuY2ggJ2NvcmVib290Jw0KPiA+DQo+ID4gICAgIE1BS0UgICAgICAg
VS1Cb290IG9yaWdpbi9tYXN0ZXINCj4gPg0KPiA+IEluIGZpbGUgaW5jbHVkZWQgZnJvbSB0b29s
cy9pbWFnZXRvb2wuaDoyNCwNCj4gPg0KPiA+ICAgICAgICAgICAgICAgICAgZnJvbSB0b29scy9h
aXNpbWFnZS5jOjc6DQo+ID4NCj4gPiBpbmNsdWRlL2ltYWdlLmg6MTM5NjoxMjogZmF0YWwgZXJy
b3I6IG9wZW5zc2wvZXZwLmg6IE5vIHN1Y2ggZmlsZSBvcg0KPiBkaXJlY3RvcnkNCj4gPg0KPiA+
IDEzOTYgfCAjICBpbmNsdWRlIDxvcGVuc3NsL2V2cC5oPg0KPiA+DQo+ID4gICAgICAgfCAgICAg
ICAgICAgIF5+fn5+fn5+fn5+fn5+fg0KPiA+DQo+ID4gY29tcGlsYXRpb24gdGVybWluYXRlZC4N
Cj4gPg0KPiA+IG1ha2VbM106ICoqKiBbc2NyaXB0cy9NYWtlZmlsZS5ob3N0OjExMjogdG9vbHMv
YWlzaW1hZ2Uub10gRXJyb3IgMQ0KPiA+DQo+ID4gbWFrZVsyXTogKioqIFtNYWtlZmlsZToxODU4
OiB0b29sc10gRXJyb3IgMg0KPiA+DQo+ID4gbWFrZVsxXTogKioqIFtNYWtlZmlsZTo3NTogYnVp
bGRdIEVycm9yIDINCj4gPg0KPiA+IG1ha2U6ICoqKiBbcGF5bG9hZHMvZXh0ZXJuYWwvTWFrZWZp
bGUuaW5jOjE4NzogcGF5bG9hZHMvZXh0ZXJuYWwvVS0NCj4gQm9vdC91LWJvb3QvdS1ib290LWR0
Yi5iaW5dIEVycm9yIDINCj4gPg0KPiA+DQo+ID4NCj4gPiBMb29rcyBsaWtlIGl0IG5lZWRzIG9w
ZW5zc2wgdG8gZ2V0IHB1bGxlZCBpbiBhcyBwYXJ0IG9mIHRoZSBidWlsZC4gSXMgdGhlcmUNCj4g
c29tZXRoaW5nIEnigJltIG1pc3NpbmcgdGhhdCBJIG5lZWQgdG8gZG8gdG8gZ2V0IHRoYXQgdG8g
aGFwcGVuIGF1dG9tYXRpY2FsbHk/DQo+IE9yIGlzIHRoZXJlIGEgbWFudWFsIHN0ZXAgSSBuZWVk
IHRvIGRvIHRvIGdldCBpdCBwdWxsZWQgaW4/DQo+IA0KPiBGb3IgRGViaWFuIHRoaXMgaXM6DQo+
IA0KPiBzdWRvIGFwdCBpbnN0YWxsIGxpYnNzbC1kZXYNCj4gDQo+IFlvdSBjYW4gc2VlIGFsbCB0
aGUgcHJlLXJlcXMgYXQgWzFdDQo+IA0KPiANCj4gPg0KPiA+DQo+ID4NCj4gPiBBbHNvLCBpbiBj
b3JlYm9vdOKAmXMgbWFrZSBtZW51Y29uZmlnLCB0aGVyZeKAmXMgYSBwbGFjZSBmb3Igc3BlY2lm
eWluZyBhIFUtYm9vdA0KPiBjb25maWcgZmlsZS4gRm9yIHRoZSBmaXJzdCBnbyBhdCBpdCBJIGRp
ZG7igJl0IHNwZWNpZnkgb25lLCBidXQgSeKAmW0gZ3Vlc3NpbmcgdGhhdA0KPiBtYXliZSBJIG5l
ZWQgdG8gYXQgc29tZSBwb2ludC4gSWYgc28sIGNhbiB5b3UgcG9pbnQgbWUgdG8gd2hhdCBJ4oCZ
bGwgbmVlZCB0byBwdXQNCj4gaW4gdGhlcmU/DQo+IA0KPiBOb3RoaW5nIGluIHBhcnRpY3VsYXIu
IEF0IHNvbWUgcG9pbnQgaWYgeW91IHdhbnQgdG8gYnVpbGQgYSBwYXJ0aWN1bGFyDQo+IFUtQm9v
dCB2ZXJzaW9uIGZyb20gYSBzZXBhcmF0ZSBjaGVja291dCwgeW91IGNhbiBtYW51YWxseSByZXBs
YWNlDQo+IFUtQm9vdCBpbiBjb3JlYm9vdC5yb206DQo+IA0KPiAjIHVwZGF0ZSB1LWJvb3QNCj4g
Y2Jmc3Rvb2wgJEJVSUxEX0RJUi9jb3JlYm9vdC5yb20gcmVtb3ZlIC1uIGZhbGxiYWNrL3BheWxv
YWQgfHwgdHJ1ZQ0KPiBjYmZzdG9vbCAkQlVJTERfRElSL2NvcmVib290LnJvbSBhZGQtZmxhdC1i
aW5hcnkgXA0KPiAgICAtZiB1LWJvb3QuYmluIFwNCj4gICAgIC1uIGZhbGxiYWNrL3BheWxvYWQg
LWMgTFpNQSAtbCAweDExMTAwMDAgLWUgMHgxMTEwMDAwDQo+IA0KPiBJZiB5b3Ugd2FudCB0aGUg
NjQtYml0IFUtQm9vdCB0aGVuIGluc3RlYWQgb2YgdS1ib290LmJpbiB5b3UgbmVlZA0KPiB1LWJv
b3QteDg2LXdpdGgtc3BsLmJpbiAoYW5kIHlvdSBtdXN0IHVzZSAnbWFrZSBjb3JlYm9vdDY0X2Rl
ZmNvbmZpZycNCj4gdG8gY29uZmlndXJlIFUtQm9vdCkuIEluIGZhY3QsIHRoYXQgb3B0aW9uIGlz
IG5vdCBhdmFpbGFibGUgaW4NCj4gY29yZWJvb3QgeWV0LCBzbyBJIHNob3VsZCBzZW5kIGEgcGF0
Y2ghDQo+IA0KPiANCj4gWzFdIGh0dHBzOi8vdS1ib290LnJlYWR0aGVkb2NzLmlvL2VuL2xhdGVz
dC9idWlsZC9nY2MuaHRtbA0K
