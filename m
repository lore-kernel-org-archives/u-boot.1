Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A64E4C4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 16:30:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EC9387ACD;
	Thu, 14 Dec 2023 17:30:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="N4UpSTGY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9050D87AC4; Thu, 14 Dec 2023 17:30:47 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::627])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C23387ACF
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 17:30:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=neal.frager@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ai5F5KH1OfPwl5sg3Lx+Eq11EPBLW4q1EnWIBgqahiiEho53mSMGPob2FL6Z3HP5TAO+SmUvb4ZpfoBhuiI4BgqyeT2QC4ECYulXVTePDphzkWNUW3f3roLwhJEcyhurKP7Ajb00wCgsDvGACt+hk2iSoiLVWPgk+JvfHsN5poVA30s830xZH+sedEgN1HJfGOAJ4DaQUyRNbjQP7nnxxeQO6MLrOICJlQgdmyj03HxEl+5qnMC7cJXgrLYhhpYZ3K4HHj8Dq0hHDMdq6cWzn0IWrCkdCHDkuT8urcyE8W7ztSK3HB4iWHS1yFAOyWELIaZqlRCeWG61QAJS69xamg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AOUD+bnTdrGlmKTIMVy+8zF7VmWbfnro1/VN60bOD6w=;
 b=lkoGuc/KUGAcoId+F0BWGRZod4B83GnMxWwr5ebA9BHDT7t8rkiNMdb/mbC5PVSRLeSJuAQxABBumzfwL/huO3MmMXc4/UATAZ5T/pymcURpRR9/WpYd+bCVau/wor0sNUna28OWCHi0NMRXr1EhQ3WalRAlKbUbnO3byRTN3D5lIuTyljzRDKjozSaraKY1TSyWLTjce4H0d/1DCF6nrX7UEzQkgZxrQaQsRpzqdzS0hn4tnG54mOt2coy51WSCP0vFlcO1AdGYtunQE5Dlffsd/KM7ow82jSjvKWjUgkI6lffOAGZnOoh1OZWBeNYsEggJj/Yqa3YoEIy/JPBvrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AOUD+bnTdrGlmKTIMVy+8zF7VmWbfnro1/VN60bOD6w=;
 b=N4UpSTGY0uxgQ9P2x9Zrd/Q+HnnJBHS8OfgtplV/zP2bkCw6Cuc705M0/WM4IkWl6L6sLOL2EsugYMPaHC3oWTYnty02iIpiJLdf6xtKEOxdwuGeDIO5qCGvpxGVRM1cqRs5De+hrofnhvsaGEM2CzxvJQh56UwPehy9zOsQX5U=
Received: from CH2PR12MB5004.namprd12.prod.outlook.com (2603:10b6:610:62::16)
 by CH3PR12MB7524.namprd12.prod.outlook.com (2603:10b6:610:146::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 16:30:41 +0000
Received: from CH2PR12MB5004.namprd12.prod.outlook.com
 ([fe80::cd8a:4814:157c:bbe]) by CH2PR12MB5004.namprd12.prod.outlook.com
 ([fe80::cd8a:4814:157c:bbe%7]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 16:30:41 +0000
From: "Frager, Neal" <neal.frager@amd.com>
To: "Simek, Michal" <michal.simek@amd.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: "luca.ceresoli@bootlin.com" <luca.ceresoli@bootlin.com>
Subject: RE: [PATCH v1 1/1] arm64: zynqmp: Fix k24 psu_init_gpl.c clocking
Thread-Topic: [PATCH v1 1/1] arm64: zynqmp: Fix k24 psu_init_gpl.c clocking
Thread-Index: AQHaLcnrcXLqWFrP7kCnupYBvmLgQ7CnYXKAgAGWz9A=
Date: Thu, 14 Dec 2023 16:30:41 +0000
Message-ID: <CH2PR12MB50043CB2CCF03CFF39ED5768F08CA@CH2PR12MB5004.namprd12.prod.outlook.com>
References: <20231213134007.2818069-1-neal.frager@amd.com>
 <c2e4c147-9dab-4f11-8721-8f6aa52e3af4@amd.com>
In-Reply-To: <c2e4c147-9dab-4f11-8721-8f6aa52e3af4@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB5004:EE_|CH3PR12MB7524:EE_
x-ms-office365-filtering-correlation-id: c7909d3f-2f4b-432a-372f-08dbfcc20358
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WFIqgMr/mK5Ml/8D5skVySgs0nLokS6xhpKkwniCsgRMjoOsGb2E3HgULmIQOqiVbS7hgQdmWHmCOOXYHisDmRxoXE2CuZ0FsQKBLSBB/cbvj4VDkR9H6yelo95d29l6XI33GUuytoeuCm0nuCCy+bwI/8c4LxOboMMNn7b7yMxNWZtadhF+Q4NiqU35btjkPXrhMyUMVF4kIef5ueNDuEs1rLIoWtYbyCcL+TpKOjHE5USAnWZywQkqY006hgcOhW/ciGu8pJM9f6gl3jf+tuL9VLTunDC1o6hNM9Mt9iIwmlQ/iw0cTFXkMtyMvRNVoqD1EkAV4CJiOUiFnGJV2wxnVbrPDvdJblI8U3jY/Wix3TnPzp/Gct4PFMIOQG9zoBXDcRblrdYn9BNd/mT41jI+Rj+9jawklC6wx24KvFr9Jl2Dr3+8kpH5C9RSZnRp1DxRz7WbNqidacAFQwOuAACrE9Y0W/qOlIJEETqCWggxuU59ibkNf0jOfRYyk/ETd4mvFPs7uLqEO90phgl1O5pBTs/Hw0aIYcCbB5nPl2Zv1sJn6RgG00xuwA7qARcBa0griqUvwPNKDiZ/612ADZif46VIpgLSff+GuFnm35PzTz+WdK8Iw/BpZnWcEtNU
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB5004.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(366004)(136003)(39860400002)(396003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(55016003)(478600001)(122000001)(38100700002)(2906002)(33656002)(71200400001)(110136005)(4326008)(9686003)(6506007)(86362001)(5660300002)(7696005)(52536014)(8676002)(8936002)(66556008)(66476007)(66446008)(76116006)(316002)(66946007)(41300700001)(64756008)(38070700009)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VjViVUZSMzVpMkF3QmNJbERqK21KRzlaaGpzN2RaYWhQQzlCTVlFbHhKSDl0?=
 =?utf-8?B?YUJXM01Md041YmUwOXg5Y1ZuMlJLa2Z1MytIU25ZTFBhSFNaRWkrY3dQMzZq?=
 =?utf-8?B?OWVDa0kyRzVWbHFUbnhQWGNxaEwwZ2s1MDNBcVh4eWlySWx0bGR4clJNRlBG?=
 =?utf-8?B?WkJFclVDcjgvUGkwaXpBLzhvQ050bThvaHh2c0dPVGNUQ3U2TzdVeUpEWDJv?=
 =?utf-8?B?WVBqMTlQeHZUNDlvYTl5NmN0WFFiMVpqMHVMVjB1UmZsdDdWS0toZFloRHRE?=
 =?utf-8?B?M2ptd0hyVzJDN3owaSt4andQRnoyempWRCs4d0drZzJJbVlEbldqT00xYUhV?=
 =?utf-8?B?S3RTcUh6cnphc2Zndks2TVVOczNXaDlJSHE3R1poeWpJMkxmRk9OdS9nQjZI?=
 =?utf-8?B?Z281cUwxcytBcnkvK01LNHdnZXQxUGQ0SDNCVGxIZzVicyt0QXhleXdsbW92?=
 =?utf-8?B?UjgwMlBZWUhaZWIxQ1o2dmxYdkdONmhhYjJEN3phNThkSGI2VjJoVkNITytU?=
 =?utf-8?B?N1NNQmEzdUVZUkxsYU40clZjV3c3QXRRSnVmODBmZzVjRmhYWmxqTll2R2JH?=
 =?utf-8?B?eUZBNGJyeE02WmFoZURRcVlsejZJL3dCREtwYnRuaFZERVRIdS84MStsWGNZ?=
 =?utf-8?B?ZEdQNTFETmk3V1BTZzgyTkM3TkRpbi96cjZFcnFhMk5ieVZFbld5UDFnVXZU?=
 =?utf-8?B?cllVN3duL09FdnUwVzBsZ2Y3RUw0STBJbDRsQkVaM0VQY1Vob3YxR2pUUHJi?=
 =?utf-8?B?dm1EcENkdDB4NmZvSEd4VDZpeDRzYTdhWlQ3NEhFb1JpVVg4cUZTSE9WbU5l?=
 =?utf-8?B?Q21XTk11ZUpiME5pajZvYWhubnp1Tll5VE1rOUdNOWdiY0hWclM1Sk42cXc3?=
 =?utf-8?B?SlFpUE4yZXZGTnU5QUFReEQyNGNpam01REd5WjRUN1dWRGhHQ3dPa1FyYUdh?=
 =?utf-8?B?N2xVczNCU0hHQTFKQndock8vQ1RUVlBYZG44UnRIM0kxK3gxRWpOb1FUMVVl?=
 =?utf-8?B?OGhnK0xBNmdGRHREaktGZE9PT3lUZFVoSmJkcjkxaE1Ibms3SUtwdWVabjFF?=
 =?utf-8?B?ZG5lbWVKZ2lhUHJjQjdjelFZVUZIRnZXSTIyVFVtbExQUks2QnQ4bndHd3Vk?=
 =?utf-8?B?Mlo4aHdCRWc4WkVPcFhTMFhrVHNRbGdnYUVuZDROV25PdE4yeUxncWVCVkVl?=
 =?utf-8?B?aDFTNGk5MWcwT29GbFg4TzluTm5MR3dZTlluZmtHb3VpbnVWZ3llWmlHUyt2?=
 =?utf-8?B?MDdNNkZraE5aRm1TdFN2RFNyZzVSc0QrMnlKNHpaYUpucDFYbkNRZFRGMEYv?=
 =?utf-8?B?d2tNQ3RZbzhUdGlHZjNiTkczR2UyWEhDSE5PanEyOVh3S05xUFg3b0FYYXp0?=
 =?utf-8?B?Qm9JQ0xVQ1NSN1NMcWFSOU54Y0d3czBjN2w4bmhpdWR2Y0V4S0dVeHNpMllU?=
 =?utf-8?B?dVdVNUxMNmhBSnkvYmNaOGMzU3JCNG0yUjNwM01JL0h6Q2VNZThsb1AvL3ps?=
 =?utf-8?B?bjFxczVUaGh0c0FWYUdwKzA3dmlZK09malBhcTZ4RTNENWJYdnlwdkJrRXBF?=
 =?utf-8?B?SkhNR1JsVnBuWE9KdEVvckJHbk9MY1NqZ21UYldXdjE4NGtpcEJSS0ZmeVFE?=
 =?utf-8?B?eklTZjNDU0lhdDBPY1d5SFNzU3JQR3YxRFlSSzg2MUtXcUJKVG9LTFlHWE5u?=
 =?utf-8?B?MWdZbWE3L2kwN1NwdzlCaksvdFFOWEZ0SFl6a2pIZXl1Q3M4ZUsrODlJV3VL?=
 =?utf-8?B?WTlNQytnbjJBSkkyQ1ZBTTJoM2hGd2RZRXlHb255elpTeHVONGtHTG9oSitZ?=
 =?utf-8?B?QmphQSt6STBER2x4Q0YxY1JjNkVyN0Vhb3JpTnJPK3FZT2ROQ203SWNJUU5k?=
 =?utf-8?B?Vzl5ODdQNnp3eFd4UUpUQ0k2dXZ5QlFZSGhDL21BS1FJUktNcUlXZWtlSUEy?=
 =?utf-8?B?am9mWjdETjFZcCtXRlZSeGt0eGxiUHJTMFk0MVB5YlRHY09xTU1ZUHFwWlNi?=
 =?utf-8?B?S21GMDl5WkFBdWtacnRFU0lkViswNGZFSHNFb21ITDVoMVVncEIwd2hSOEwx?=
 =?utf-8?B?ODNJc0pYYkJQSkFyK09iUU9vQkFNWUVQamRVYVFCUURxZVZQRVg1eExBTVk0?=
 =?utf-8?B?Z0Nyc3hMZVV2cG92MWNmeStmL1dKWnQxRUdCSDRhZlVDKzgyTXJ3TFVaVisw?=
 =?utf-8?Q?ODp7fMEQ8of3D2T2/SFxfdg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB5004.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7909d3f-2f4b-432a-372f-08dbfcc20358
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2023 16:30:41.2797 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zKfZy4wOfr44t8hO0TmAHLMoRbiJCZDYwFfHQIr9BIWjKbVpor3D19E8gf9BuIpU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7524
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

SGkgTWljaGFsLA0KDQo+IFRoaXMgcGF0Y2ggY29ycmVjdHMgdGhlIGsyNCBzb20gY2xvY2tpbmcg
Y29uZmlndXJhdGlvbiBzdWNoIHRoYXQgdGhlIHNlcmRlcw0KDQo+IENvcnJlY3RzIHRoZSAuLi4N
Cg0KT2suDQoNCj4gY2xvY2tzIGFyZSBjb3JyZWN0bHkgZW5hYmxlZCBhbmQgdGhlIHVzYjAgaXMg
Y29uZmlndXJlZCB0byB1c2UgdGhlIHBzZ3RyDQo+IHJlZmNsazIgZm9yIHVzYjMgbW9kZS4NCg0K
PiBJIHNvcnQgb2YgaGF2ZSBubyBwcm9ibGVtIHdpdGggdGhpcyBwYXRjaCBidXQgaXQgc2hvdWxk
IGJlIGJldHRlciBkZXNjcmliZWQuDQo+IFByZXR0eSBtdWNoIHNlcmRlcyBjb25maWd1cmF0aW9u
IHNob3VsZCBiZSBjYWxsZWQgZnJvbSB1LWJvb3QgYmVjYXVzZSB3ZSBhbHJlYWR5IA0KPiBoYXZl
IHBzZ3RyIGRyaXZlciBhbmQgdXNiMy4wIGNhbiBiZSBjb25maWd1cmVkIG91dCBvZiBpdC4NCj4g
QnV0IHdlIGNhbid0IHRvdWNoIGR3YzMgZHJpdmVyIG5vdyB0aGF0J3Mgd2h5IHRoZSBvbmx5IHdh
eSB0byBkbyBpdCBpcyB0byANCj4gY29uZmlndXJlIHZpYSBwc3VfaW5pdC4NCj4gQnV0IGl0IHNo
b3VsZCBiZSBjbGVhciBmcm9tIGNvbW1pdCBtZXNzYWdlIHRoYXQgaXQgaXMgd29ya2Fyb3VuZCBu
b3QgcmVhbGx5IA0KPiBzb21ldGhpbmcgd2hhdCBzaG91bGQgYmUgaGVyZS4NCg0KSSB3aWxsIHJl
LXRlc3QgdGhpcyB3aXRob3V0IHRoZSBzZXJkZXMgYWRkaXRpb25zIHRvIHNlZSBpZiB0aGV5IGFy
ZQ0KcmVhbGx5IG5lY2Vzc2FyeS4NCg0KPiBUaGlzIHBhdGNoIGFsc28gY29ycmVjdHMgdGhlIGNv
bmZpZ3VyYXRpb24gb2YgbWlvIHBpbnMgbWlvNzYgYW5kIG1pbzc3DQo+IHdoaWNoIHNob3VsZCBi
ZSBjb25maWd1cmVkIGFzIGdwaW8gcGlucy4NCg0KPiBUaGlzIGlzIGRlZmluaXRlbHkgZmluZS4N
Cg0KR29vZC4NCg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTmVhbCBGcmFnZXIgPG5lYWwuZnJhZ2Vy
QGFtZC5jb20+DQoNCj4gWW91IG1lbnRpb25lZCB0aGF0IFNQTCBkaWRuJ3Qgd29yayBiZWZvcmUu
IElzIGl0IGJlY2F1c2Ugb2YgaW5jb3JyZWN0IHNlcmRlcyANCj4gY29uZmlndXJhdGlvbj8gQmVj
YXVzZSB0aGF0J3Mgc291bmRzIHdlaXJkIGJlY2F1c2UgeW91IGRvbid0IG5lZWQgc2VyZGVzIA0K
PiBpbml0aWFsaXphdGlvbiBmb3IgYm9vdGluZyBvdXQgb2YgcXNwaS4gVGhhdCdzIHdoeSBsb29r
aW5nIGZvciB3aGljaCBpcyB0aGF0IGJpdCANCj4gd2hpY2ggbWFrZSBTUEwgd29yayBvbiBLRDI0
MC4NCg0KVGhlIFNQTCB3b3Jrcy4gIFRoZSBpc3N1ZSBpcyB0aGUgc2FtZSBhcyBJIGhhZCB3aXRo
IHRoZSBrcjI2MA0KYm9hcmQuICBUaGUgc2QgY2FyZCBpbnRlcmZhY2UgaXMgb3ZlciB1c2IsIHNv
IHVubGVzcyB0aGUgdXNiMw0Kd29ya3MgY29ycmVjdGx5LCB1LWJvb3QgaGFzIG5vIHNkIGNhcmQg
aW50ZXJmYWNlIGFuZCBjYW5ub3QNCmZpbmQgdGhlIExpbnV4IGtlcm5lbCBhbmQgZmlsZSBzeXN0
ZW0uDQoNClNvIHdoYXQgSSBtZWFudCB3YXMgdGhhdCBJIGNhbm5vdCBib290IHVwIHByb3Blcmx5
DQp3aGVuIHN0YXJ0aW5nIGZyb20gdGhlIFNQTC4gIFRoaXMgaXMgd2hhdCB0aGlzIHBhdGNoIGlz
DQptZWFudCB0byBmaXguDQoNCj4gLS0tDQo+ICAgLi4uL3p5bnFtcC96eW5xbXAtc20tazI0LXJl
dkEvcHN1X2luaXRfZ3BsLmMgIHwgMjY2ICsrKysrKysrKysrKystLS0tLQ0KPiAgIDEgZmlsZSBj
aGFuZ2VkLCAyMDAgaW5zZXJ0aW9ucygrKSwgNjYgZGVsZXRpb25zKC0pDQoNCj4gVGhpcyBwYXRj
aCBpcyBub3QgYmFzZWQgb24gdGhlIGxhdGVzdCB0cmVlLg0KPiBUaGVyZSBpcyAwYTk2NWIxMGUy
NDEzOTg5ZTM1MWI1YTViNDk3MzdiYWJkZjViNzUxIGluIHRoZSBtaWRkbGUgdGhhdCdzIHdoeSAN
Cj4gcGxlYXNlIHJlYmFzZS4NCg0KWWVzLCBJIHdpbGwgc3dpdGNoIG92ZXIsIGFzIEkgZGlkIG5v
dCByZWFsaXplIHRoYXQgdGhpcyBmaWxlIHdhcyBub3QNCnRoZSBzYW1lIGluIHRoZSB1LWJvb3Qt
eGxueCBhbmQgdXBzdHJlYW0gdHJlZXMuDQoNCkJlc3QgcmVnYXJkcywNCk5lYWwgRnJhZ2VyDQpB
TUQNCg==
