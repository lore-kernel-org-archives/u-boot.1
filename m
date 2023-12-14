Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59EA5C4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 16:19:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE93387A9D;
	Thu, 14 Dec 2023 17:19:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JNgH7sIi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3854187AA3; Thu, 14 Dec 2023 17:19:55 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4CE287A7E
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 17:19:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=neal.frager@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S9H8hJMBbzhg5ytN4RMTM2ycgFtOCA3bgB8Mun/ROj17hP7udWvivhfYRk7VjcRUW6X9W6lEgAV9Tmg6C8ZQNVJL2WQ8PTnrp52B1IxcMyb5ZwM0M1E3YmwkGXieL0hqPnZYmayvh0smUL8Tl364e3TJQ96qRTC2pPTcqm0c/W94mULWOMGPxNa/iR77HYffjigOc9p6IQkBDobpa3EAj1P3FMioRpfGVv714+ygr69lITZjXf2oTVWFkc5+4Vy13m2FWnSFDJWWKKGDz8I0LW+uM8DT7jExfltKZgIuuKd24K8sdrZZSNzPaap76bVmsli/bbwKLYPLyOa9xVN71g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nbRz8aVq9GjV3ROo18iLm7WJ2dNPdblCOLRrXtwkxoA=;
 b=NGqJPRepEo6+Akyr1LlUQ/kN3NMLlhJlpkXUENv0WmzS+cT1SKIdbHakXd+AbsRBCbDNlUqkCRmK/0BMjZsWLi/Qy8EcwWYqOo/gxOeXjQc25kFHa1EIzOmdwBN+O90eEGNSd+ZodJ9J7qlO1BeW+4zFaEs9FBZmSnyXicRzvNDoCgkB8ejYss51R5OIOq7jWT/rANTALc2aJW4XjXy4PiprQUp04X9YnWFEsk+cBiK14nXGBgva+7G4AO3mVJg4WfQqv+4FACm2rkOw+rz0rSs+Eemtp9Q3W0AOdZql6cQrLij3e+ygmJqbeSk60vObU2KNpss10y/+Cdw4PvRIVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nbRz8aVq9GjV3ROo18iLm7WJ2dNPdblCOLRrXtwkxoA=;
 b=JNgH7sIi4vqQYQWqJEjBnDjDUbv1Lzm8gVPbKDWgaSVGz9joImI0Q0sqm/Vq+oDFyql12ovt9xk+Ux8SPsOgzFzUVSNSIXrMHDfYFrZxuHJflgMDI7nmnEDD1OsWN6MSNkdX7KCuvdLz9yclJ5kpT+4QtGK7gsR2OgwlSSfheuA=
Received: from CH2PR12MB5004.namprd12.prod.outlook.com (2603:10b6:610:62::16)
 by BY5PR12MB4180.namprd12.prod.outlook.com (2603:10b6:a03:213::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 16:19:45 +0000
Received: from CH2PR12MB5004.namprd12.prod.outlook.com
 ([fe80::cd8a:4814:157c:bbe]) by CH2PR12MB5004.namprd12.prod.outlook.com
 ([fe80::cd8a:4814:157c:bbe%7]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 16:19:45 +0000
From: "Frager, Neal" <neal.frager@amd.com>
To: "Simek, Michal" <michal.simek@amd.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: "luca.ceresoli@bootlin.com" <luca.ceresoli@bootlin.com>
Subject: RE: [PATCH v2 1/1] arm64: zynqmp: Add output-enable pins to SOMs
Thread-Topic: [PATCH v2 1/1] arm64: zynqmp: Add output-enable pins to SOMs
Thread-Index: AQHaLcoChnw0wdxJ4Ee7PlfTRTXfPbCnX3cAgAGWzzA=
Date: Thu, 14 Dec 2023 16:19:45 +0000
Message-ID: <CH2PR12MB5004B461ECCA0936843E7CFEF08CA@CH2PR12MB5004.namprd12.prod.outlook.com>
References: <20231213134052.2818879-1-neal.frager@amd.com>
 <00a14e3c-8fad-427f-a41a-ced59e863b27@amd.com>
In-Reply-To: <00a14e3c-8fad-427f-a41a-ced59e863b27@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB5004:EE_|BY5PR12MB4180:EE_
x-ms-office365-filtering-correlation-id: e0c59122-93f8-4d06-350c-08dbfcc07c9b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c5UnGwwePQ8f8GgXweG2FoFbMUBjktybgviiVU46uesDZGh5xYj/Kz+RbfnJWkHa5W0BJGkRgysMr4MfgC83zLOJs8e6baDFZwAZ+mldNSVZtFTnEvg6WLiqZVU57zFaaRcP3tgJRu8+prqM75NxJLY0EBMHrJyJuNxvpx4p2gAtDy6f9PI1j3Oo6MQUs6Bt0pfGB6RHa1bBbXZPJfRUY3DcLEPWoziaiYR9BX2jF2XiKIa8cLIVJJUuWXOyzGXQIX1QYf1dzToo+g7RIyeb3od6aIurC0syFrNyXOhUWbY7dJCEWnszIytxeYtuP9EqHQzSSX2kUpj8QV+TUd7Nz1989NDiEdAIYw2lxfZ8Mdb4nK8jhuDsbhGleWnkE3SwNMXxB8NC8Mdcf3AdIWoEdt3TdZlKuyu8e1K8ySOL31qT9eiJLllB89HqR05tZxwOM1WHxTL0zaD3ylICXE6OFZhUXP7huhdJRTD7S0JIa3TNMbMNRcAvG7NEzI4SSkf6Va1OMvmn8EzZkL+DEsHZjuc29MvBLr4P5qoJCqS1SjXSGtdf1zPmRZ1rvyLbX6WXYJxe9Tt4O6rn4p4bz0oiT/d6vye9X4gR3TmGhgPzKC4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB5004.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(376002)(39860400002)(136003)(396003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(478600001)(9686003)(966005)(122000001)(66476007)(66446008)(64756008)(66556008)(66946007)(110136005)(38100700002)(76116006)(71200400001)(55016003)(7696005)(6506007)(52536014)(316002)(86362001)(4326008)(8936002)(8676002)(2906002)(33656002)(41300700001)(5660300002)(38070700009);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eDdmQmw3VjlieTZpWGxYa0ZUa3h5cmQxMDZHUHVEbm8vOCtVLytlTGFsK2dl?=
 =?utf-8?B?dVpYRzhzOWc1ZllJOWo2Z21zUS8xNStrM2JkYzZLU3Uxd3RRbUhQNnBlYVcx?=
 =?utf-8?B?bW93VzVwR09IdEVRZitQcm1hZWFrMTUzRXlvb09ITGowNXJ2YTBMZ2I3alhK?=
 =?utf-8?B?QTFEb0xZcHRHLy9Ra2pEN0pSdnloZDRDVmxZZHJvSGcxNTlScEZVQmpTVjhW?=
 =?utf-8?B?aVVJV041UmRkOTh5bXlzOFpiektZdzNuTC93OGFkcHJUa051V3I3U3lWb3po?=
 =?utf-8?B?NmFkZ3NQV21tbDRQWk4xa0xKN3JpM0V3RFRGWmp6SFVWZHpjdHc2WTRZU2lp?=
 =?utf-8?B?L3dBQzI1NXJXSWhxR1BFUGN4YWRwR25US2JGam93cTJ6MEtHRWdRdXdKcTcz?=
 =?utf-8?B?djdPVWZma2VRdVdnbUdobGFJTVZkRDRlc3RlMFFqV2dwSnZVS2U2UlV0S2ZR?=
 =?utf-8?B?NFUrVFhXVHNoOG84SnVnQVd5Y0NJSlEzT0x6Ymg5NVRYK25vUkc4T05EOWIy?=
 =?utf-8?B?cE5xMmE0UjF4Sjg1eGsxM0lCejRaTWhxZGRBaEJCemhxY3dPcmFwOVlJVUMv?=
 =?utf-8?B?SDBQczNsOStJb0ZCSlVUenNqZDdWR3JZTlEyQlU5U0F5VitRU3RDem1rM0VS?=
 =?utf-8?B?U2JNYnE1OW14Qk5ob09Tb2hzSmlBOXFDcHN2bE5WQVRSdmR1c3ZucFVyTVRr?=
 =?utf-8?B?cFg1NFRBV293SzlEaEsvR25XUWFGc1BmaFpKSzIvUTRObmVxVWJTN0h1b0w3?=
 =?utf-8?B?R05BZkNUQnJWR0QrSHdyeVN1SnhrczNFQzMyVUFGczZnUS9xM3B6S1dTS0hq?=
 =?utf-8?B?TEJmNmhVQUdJajMydVZKRTJEUThpUmZiMnBPV0Nnb2dMSVdNZWlnaFBpZjln?=
 =?utf-8?B?cnVkeStmZTN2aXpPT2pUc2Z6YUlqVkhDbWNsM24vcmh4dGtyQ1lkQ1dMWFNY?=
 =?utf-8?B?RFFERTM0dkV1UDJxeHFXcFM0OWVWNW43ZGhNaGhld3VrOHBJVnhvR0RROHJP?=
 =?utf-8?B?Qi9sSnZQRTlVWjJCV3FQSGE3UTV3Vk5SbFRReDBDWWRmWFluaTJSU1pxcVVa?=
 =?utf-8?B?WnhRQnR0NEh2eFpmdUNKK1lCT0t2dExCR00zQ2Y0ME5mOXI0Qldmczdhdm8y?=
 =?utf-8?B?K2tpdHc2VmRIL3VNN2l0YXJNN1JDRnBNbGI2akZDd01rdDIwZE9YSDdtcGFP?=
 =?utf-8?B?Y0hCOExWbFdySHphbDFKTmV0VGlFKzBOaXJ0V05GalQ5cmZYbWM1K3ZTSDVx?=
 =?utf-8?B?SzlpT2ZtSjF1MlQ5d2JaV3BqRlhsMWdKUUkwTExzUFdlRnlBajNzZkhNU1Fm?=
 =?utf-8?B?UlM4K1dHZlAxZDlvVERodGVJa0JNRTRGMVpHRmNLT3lPWG45TUJxeFJKUi9O?=
 =?utf-8?B?S2NHNTUxVFpLWFFvTFh5NW43WW53c1NTQUdHODJOU090Uk9CWWhTQkUrWFJJ?=
 =?utf-8?B?T3FkY1BSeFo0QXo1V3R2czhtNHN1VGdMUFUzOFZZUGJQcCtPb1RQTWFnWE9o?=
 =?utf-8?B?OWZJVC9sSG9qWXNzZEdVRmMvbWlDeXdzeWJQelQrdXh0aHdKNXA0K1dqMjZH?=
 =?utf-8?B?OVdrMHlodXlIOGdjMHBMTlgwbWFpNjA4UkdkZEJvTitXZHlCSDNyY2V2a2xK?=
 =?utf-8?B?c3grakRCekk3UHpSbGpLMXhxeE96Myt4S3JBZE96NEpwSmNvcVhKZVp4bW4r?=
 =?utf-8?B?MXQzZVF2WHoyYnF0WnBLVXFMRXJUU1hEOW1QcmoxRDZVWUxKK0ZFQVcycGUz?=
 =?utf-8?B?YTFUYkpBdDYyYzBTZUJjNjFnMklOYmZ0WHZob1ZkV0habjViOElpMVJFOVF5?=
 =?utf-8?B?eGt4Njg0NTM4cncyN3l6OXV2VDRzQ1VPZWVJUWp6R3IxQWFVcG94M05XTE9L?=
 =?utf-8?B?aVBPYTI1aklVWkNPcEVFNWN2UWw5NGxOS0hZREw5TmtzejJqaEMxa09GRkxl?=
 =?utf-8?B?YkFJOGRUcXowQ1VnQU14UG5UQlR0UjZtbWZjNXZKcjF2cHF4S0cydVJWUzVk?=
 =?utf-8?B?NElKLy8wWFB0ZUhtdlNqSGVYTXhMbXQ1d2gzS1VrMllOMTVoWkEyMnR1UCtN?=
 =?utf-8?B?dmpVbFlFNytkUDI0TEFNYTdONUR5S3RWTTBPQlBhcEQ0cUMvZUVwODA5ZVRk?=
 =?utf-8?B?ay9SbFd5NEJtNDlsVHJzU1JIZWNaZm5ySzJqRkN6UWxEcURQTHVRK0o3NUxM?=
 =?utf-8?Q?1/r2lXn097OpIFiOm7WGjB0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB5004.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0c59122-93f8-4d06-350c-08dbfcc07c9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2023 16:19:45.6899 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hKnvHdhbSN012NyU/CPui8BJN9GfaEXF69OUMAKX20+v1527RZ4AEhTgHwDnhhjL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4180
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

SGkgTWljaGFsLA0KDQo+IE5vdyB0aGF0IHRoZSB6eW5xbXAgcGluY3RybCBkcml2ZXIgc3VwcG9y
dHMgdGhlIHRyaS1zdGF0ZSByZWdpc3RlcnMsIG1ha2UNCj4gc3VyZSB0aGF0IHRoZSBwaW5zIHJl
cXVpcmluZyBvdXRwdXQtZW5hYmxlIGFyZSBjb25maWd1cmVkIGFwcHJvcHJpYXRlbHkgZm9yDQo+
IFNPTXMuDQo+IA0KPiBXaXRob3V0IGl0LCBhbGwgdHJpc3RhdGUgc2V0dGluZyBmb3IgTUlPcywg
d2hpY2ggYXJlIG5vdCByZWxhdGVkIHRvIFNPTQ0KPiBpdHNlbGYsIGFyZSB1c2luZyBkZWZhdWx0
IGNvbmZpZ3VyYXRpb24gd2hpY2ggaXMgbm90IGNvcnJlY3Qgc2V0dGluZy4NCj4gSXQgbWVhbnMg
U0RzLCBVU0JzLCBldGhlcm5ldCwgZXRjLiBhcmUgbm90IHdvcmtpbmcgcHJvcGVybHkuDQo+IA0K
PiBJbiBwYXN0IGl0IHdhcyBmaXhlZCB0aHJvdWdoIGNhbGxpbmcgdHJpc3RhdGUgY29uZmlndXJh
dGlvbiB2aWEgYm9vdGNtZDoNCj4gdXNiX2luaXQ9bXcgMHhGRjE4MDIwOCAyMDIwDQo+IGt2MjYw
X2dlbTM9bXcgMHhGRjE4MDIwQyAweEZDMCAmJiBncGlvIHRvZ2dsZSBncGlvQGZmMGEwMDAwMzgg
JiYgXA0KPiAgICBncGlvIHRvZ2dsZSBncGlvQGZmMGEwMDAwMzgNCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IE5lYWwgRnJhZ2VyIDxuZWFsLmZyYWdlckBhbWQuY29tPg0KPiAtLS0NCj4gVjEtPlYyOg0K
PiAgIC0gcmVtb3ZlIG91dHB1dC1lbmFibGUgZnJvbSBnZW0xIGNvbmYtcnggcGlucw0KPiAtLS0N
Cj4gICBhcmNoL2FybS9kdHMvenlucW1wLXNjay1rZC1nLXJldkEuZHRzIHwgNiArKysrKysNCj4g
ICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJj
aC9hcm0vZHRzL3p5bnFtcC1zY2sta2QtZy1yZXZBLmR0cyBiL2FyY2gvYXJtL2R0cy96eW5xbXAt
c2NrLWtkLWctcmV2QS5kdHMNCj4gaW5kZXggNTZmMzEyODUyOC4uMTI4NjUzOTJhMyAxMDA2NDQN
Cj4gLS0tIGEvYXJjaC9hcm0vZHRzL3p5bnFtcC1zY2sta2QtZy1yZXZBLmR0cw0KPiArKysgYi9h
cmNoL2FybS9kdHMvenlucW1wLXNjay1rZC1nLXJldkEuZHRzDQoNCj4gVGhpcyBmaWxlIG5ldmVy
IGdldHMgdG8gdXBzdHJlYW0gYmVjYXVzZSBpdCB3YXMgbWVyZ2VkIGFzIGR0c28uDQo+IFRoYXQn
cyB3aHkgSSB0aGluayB5b3UgYXJlIG5vdCB1c2luZyB0aGUgbGF0ZXN0IHRyZWUgZm9yIHRoaXMg
cGF0Y2guDQo+IENhbiB5b3UgcGxlYXNlIHJlYmFzZSBhbmQgc2VuZCBhZ2Fpbj8NCg0KVGhhbmsg
eW91IGZvciBwb2ludGluZyB0aGlzIG91dC4NCg0KWW91IGFyZSBjb3JyZWN0IGFzIEkgd2FzIGFj
dHVhbGx5IHdvcmtpbmcgZnJvbSB0aGUNCmh0dHBzOi8vZ2l0aHViLmNvbS9YaWxpbngvdS1ib290
LXhsbngvIG1hc3RlciBicmFuY2gNCndoaWNoLCBhcyB5b3Uga25vdywgaXMgc3RpbGwgYmFzZWQg
b24gdS1ib290IDIwMjMuMDEuDQoNCkxvb2tpbmcgYXQgdGhlIHVwc3RyZWFtIHp5bnFtcC1zY2st
a2QtZy1yZXZBLmR0c28sDQp0aGUgb3V0cHV0LWVuYWJsZSBkZWZpbmVzIGFyZSBhbHJlYWR5IGlu
Y2x1ZGVkLCBzbyB0aGlzDQpwYXRjaCBpcyB1bm5lY2Vzc2FyeS4NCg0KUGxlYXNlIGRpc3JlZ2Fy
ZCB0aGlzIHBhdGNoLiAgSSB3aWxsIG1hcmsgaXQgYXMgaGFuZGxlZA0KZWxzZXdoZXJlLg0KDQpC
ZXN0IHJlZ2FyZHMsDQpOZWFsIEZyYWdlcg0KQU1EDQo=
