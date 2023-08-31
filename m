Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 964A4C83F01
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 13:30:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03BBC8657F;
	Thu, 31 Aug 2023 15:30:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5hKVVg3s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 985EF86597; Thu, 31 Aug 2023 15:30:33 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::62c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCB8E81FA8
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 15:30:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=neal.frager@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lpIbJ/PiAt64g0ax3qHrZcIuxg00k7/hdVvSFBGvEADFLw5tk/Wr3NqV5/0qrm1eLY4RoT0V6qqU5d5ZV76DRCT6I6PKR2YdbyfSCreifOCh5NRBPRJpTqk6IqgbUmTAML1u+vyqNQhK5SAeNrLcIw2hD/lbDW+fhYuSlGC7yXdFgUBYK5bzS3hF8DN79/hFoGZp2Y5KvfFCbZrJc9fdbBFMarwnvuHb2Ab4B8wMUp3fL8UZrhUyUeCaP9FR6fP1SA+R7xoo6VM7oWVWepVAl8MyxPNNX+WsDPyv+s6pEHy4oovfz3w3wpINN335K/BNMqgnZiofFYUMQuz2EFcCcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cte9nX3DijH6gztM6YhJIVJ/g5obD0dM2uV8wp38Vzo=;
 b=EbaXmRM9Ym1SieaJXjwsHJn5NfdpciEn9r0gHiwcPCy+dkt7IbuWlLWKZlOGruqOUa9/w8cHjBt9VLm3aNh5FXi95E+8v2p1wEo2rKi1PIuwXOhTadhdJZOevCocmiCQdXN7kOK/b+Zy76WCgXUQJUc9o6K+NpnNyoM/M2OGLxdWuIhaCh/tKl1+V8YGTjcOAeoxyozJkiqz42mn1FvN0p7d2gvLcFHSIrOIe0LysE7ScXFynhVT+iIuylcPg54ynJQ1LkTFVqf7CmVTgjUTwC1WCSYWw1rEMOSGABnQ20LCGDRmC08WAjHJtHpByZf2KLy0LetRgDle1tVpCf0AxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cte9nX3DijH6gztM6YhJIVJ/g5obD0dM2uV8wp38Vzo=;
 b=5hKVVg3sGO9M9c5XxnIdE1mhIT8fmrvnnTPY4dQDCwhMjIz4Q/PVfamKD3YoyuZo1Q2Zoe1/I+6GLxqJzS9CBOA0+opzW5NoHmtcfWRLOUWotg7qxDGNcsAf4cnJR5LqgtyclbEvQKx6hmiNNjIBufHNxIt2Kmx8xbgr4p0JdIg=
Received: from CH2PR12MB5004.namprd12.prod.outlook.com (2603:10b6:610:62::16)
 by MW3PR12MB4505.namprd12.prod.outlook.com (2603:10b6:303:5a::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.22; Thu, 31 Aug
 2023 13:30:25 +0000
Received: from CH2PR12MB5004.namprd12.prod.outlook.com
 ([fe80::c780:32e8:203:be20]) by CH2PR12MB5004.namprd12.prod.outlook.com
 ([fe80::c780:32e8:203:be20%2]) with mapi id 15.20.6745.015; Thu, 31 Aug 2023
 13:30:25 +0000
From: "Frager, Neal" <neal.frager@amd.com>
To: "Simek, Michal" <michal.simek@amd.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: RE: [PATCH v1 1/1] arch/arm/dts/zynqmp-sck-kr-g-revB.dts: add
 output-enable pins
Thread-Topic: [PATCH v1 1/1] arch/arm/dts/zynqmp-sck-kr-g-revB.dts: add
 output-enable pins
Thread-Index: AQHZ2w9I7XxehwSxGUSGBCxLCkdgYLAEZnEAgAAAc0A=
Date: Thu, 31 Aug 2023 13:30:25 +0000
Message-ID: <CH2PR12MB50048EBB17FDC923993D864FF0E5A@CH2PR12MB5004.namprd12.prod.outlook.com>
References: <20230830065737.4083577-1-neal.frager@amd.com>
 <62d1dadf-6b3c-ed8a-4b50-b90f0d34a17f@amd.com>
In-Reply-To: <62d1dadf-6b3c-ed8a-4b50-b90f0d34a17f@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB5004:EE_|MW3PR12MB4505:EE_
x-ms-office365-filtering-correlation-id: c6698961-2dae-408f-cf31-08dbaa266f66
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R9o0DeBT1UhcdLDgc+k/OapjsUlWufsYDTb7THYYaUZc/CWSI8iBkWiSCSU/GjW3yLoX4qnfGRqq7o5sL9nLKZVtmLS29I9FyR0EPi0j+16trooncGb5PKb8+KC38Dks1ZsLZZWmAqiYzjiQsR32+s9j7gNqTU9zsTznGg06DZxUbj05xCmijYCVk7V2hsPDkAdYplLi0tWVraw/VenBptdGLwZxcIcJE16OORJZDvtnJawHJFsgt1R2skrjcVLsSHsIJGIGQ7shjNoheTEoiaX1oZ9lmVmcWV/e4/vjmCgUv1+vJkTG2VEOOEqoWaoyfl4rWIm0PsnIAHuyTw5aCPvYvQPVC6gryEuEIkJY2a6jvyxPTZFkOHQXIoIAEDR1Ic6lLsSq7kHJWcUDuyeiSfzHexBdl+d97OBIaoV1wbfUF5CqsC4hIp4dGzH9NFO3g6TI1pkn71UoudBBySXnOkI0cv/WdLu+GWsONXbom50X3H6vJItN5y6Kf7+KAEwSd0byQXdVnl5o3qkLWXDICNMZpjv32D5PPkfJTqXXVndMqDGVpVwwKQzLpZlREYbD3/+Tv4Ak3RELRuAWxN8Ei0upRq0/GQXK/1DBpMuhrvYIkkXKFQYbS9Is7rr/vWPy
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB5004.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(346002)(39860400002)(376002)(366004)(396003)(1800799009)(186009)(451199024)(9686003)(66556008)(66476007)(41300700001)(86362001)(66946007)(2906002)(76116006)(64756008)(316002)(66446008)(33656002)(8676002)(8936002)(26005)(52536014)(5660300002)(55016003)(83380400001)(38100700002)(38070700005)(122000001)(71200400001)(478600001)(7696005)(6506007)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q2tTT0NpQ1YvKzJIU0ZCeHowc0d0WU9XcGtYdytxbmttTnhpZ0lLbnFnUmNY?=
 =?utf-8?B?SjZhWHhsblJ3blVPUVpOYUlzNG5wWmhHUDloam1JUG8vNmpGTzZvTUFvYWVa?=
 =?utf-8?B?ZVE2eUEvRVZDWVMxc2FRanU1VDY4QXBuL3NabVVISFZkbVdIRnl3TWNhWXVN?=
 =?utf-8?B?ZTdVZ0VvRUkyS1VFSVBIdTl5Nm1qUEtlZDd6N3hJOUFENWdNcGppREpoM3ZL?=
 =?utf-8?B?bzVTK1ZBU1d3anhwZjQ4bDhLcVVONEtleTJzYURwUjM4UTZTOWtiM1RiQlhB?=
 =?utf-8?B?MkxxMXBaeEJMWkxDNkFuRGNReDFxeG1ERVF3Ny9iTU4vN0pLbS92SFV2aUg1?=
 =?utf-8?B?Z1NETG02aktnZS9jSVpEWDRrdUwrNXBZZlQyc0JzZVkyai9kbVJlbkZoN2Nz?=
 =?utf-8?B?RWZjdWlLbUhHNXBzSmVrRTZTUXdybXp3MzlUZW5sUHk4b3g4akcwbmNVOGRo?=
 =?utf-8?B?Q3ZiTTNXODg5UXlkMXlaQ2FZb1FSNlNJL0VlTm5nbTZlVHE0bVZrTjJTejBs?=
 =?utf-8?B?TGo4VFh0YVl2Nzg1OXo3NEFMeXAvR0pxVE9mS3E3RHhEVVdxT09rS0tCVHNI?=
 =?utf-8?B?NmhBL1NuZnU0SnA2YTBRcDdTZHFweVBZS3JKZVpyR3ZPYVZEd0wrVEhnWTVW?=
 =?utf-8?B?TEFxTDE0eW5uWlUxSzVNU0NxczZVVElKUGtZMDVrczVoK2Y2ai9sb2V4YmVz?=
 =?utf-8?B?Y25KRWkvMVY5Z21vejNyWW00dm0zSkVjNHNRcnIrSVVPN1NPbUVULzJ1ejRD?=
 =?utf-8?B?UzNpTTA3cEp2aUJ6cnBoRUpNUmdleWZQSzB6bXZoaFdFbERkbm91ODZrZFIr?=
 =?utf-8?B?VTVKdHd3aWd2cm1DSC8rR1N5L2FTSXhlWVdBZ1M3TDIvZEFOeTczdk5wem9k?=
 =?utf-8?B?dXkrOWxodDhGZ05kZFU3RktPRlZiazQ3YlZpYzBONWVaNnc4RTRPWWcrelc4?=
 =?utf-8?B?QXNDMFc1SVUxK1QwQ0hTa3lwVTVmTXZ4WHllYkZCdzJvVUtUckxad3U4QW50?=
 =?utf-8?B?dUlTYndSeVZ3RWRzQkdsNU14Y3F5dktTT2hkVnhpOGVxN2l0L0ZkNjJKbits?=
 =?utf-8?B?eFpkcFUxZlpGUm1GdUtOekpjc2Jab08zZGI2c2didTFCbyttZmVwbWRnYUVL?=
 =?utf-8?B?ZUl3Z1dvTDJlUVRTRGpPQXRWaFlKZlNzb0RZWHVRVWRwZE84aVQ1MEIwL0lW?=
 =?utf-8?B?eGVSb3hhSjc4NW4yNjdyaDBXNU5ydWRpbUxVUzNkQk90Q2hlT3dhU0lwcDJ0?=
 =?utf-8?B?VVR0YjVEZ013Yi9ZZlJsK2xPbmFLNnhuL0Vmc3hPb0NqMS85cy9lc1BOWEVl?=
 =?utf-8?B?VXM2ZHRUaGxlNUxjakVRK1RhRzk3M1g3Ly8yM2p0YnRaUmZKdGNQaFNGaTdk?=
 =?utf-8?B?bTd5VEtWWHZyTHgwMWRDL2VNdS9JWjMydkJYNnRTYi82R2dyYjVNRWF4Y2d5?=
 =?utf-8?B?dytqM0xzYzR1MHk2Rmx1aVVrK1ErN1pTOHBSTWJ0S2VQblp4VzNMV0kzOUxY?=
 =?utf-8?B?TFhtZyszMVJaZC9oREpkdXBxVEFmT1ZWZDhwQmtqeDRoQUlLRkZ0ME1xdnpa?=
 =?utf-8?B?eDJ1VllFbks5eTBrQTZ6RjYyK1Z4TkhHTUVUU1ZpQ0lvMjN6Z2dvQXloQXg0?=
 =?utf-8?B?dllZa3FxYkYyR0NOMUxCVEVxTlJxS1grekhsVi9ucSs4R3RMMnFpQkpQWmFO?=
 =?utf-8?B?dytXQk1SNm1MK3F6MUdMY3VEalBKNGFoYUlYNjFwRXc1S0htTGRBOVhiYS9n?=
 =?utf-8?B?aE5LWk8ycytmdHc2czRwcnpJSlVCemtNQkR4dkFYOVVxalh5L2hSNW82N0lW?=
 =?utf-8?B?N1ZzYm91WWhSTS9PYXljMm9lQjYrblBvcUFkK1VTVFNGZUEzVHlvMUF4VUc0?=
 =?utf-8?B?Zk01K2VFOFhDaDJteHAvbjZIOGJsbkFrNU9hdCtPQmNCdmEwNHkyS0xZNEpy?=
 =?utf-8?B?UEY3NzJnNnFudm4rb05qL0pFMTNoczQ3OXE2aktHVVZkVUdVZ2FBRDllUHF4?=
 =?utf-8?B?YTlGMFcxeng2eURGcnd2eUJiRkdsWExpdXZIeU5rWi9IUDBSc1YyalVJYzky?=
 =?utf-8?B?Y3ZsZ0thbUxqL2RQQW1KN3NYZFA0WWlTakNkZldZb0xWZExpQlorNzFIazhv?=
 =?utf-8?Q?44f0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB5004.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6698961-2dae-408f-cf31-08dbaa266f66
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2023 13:30:25.6987 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ERbLgT0N7qbANf2pljuRC3/b8MSe2XiAyXhg2era3O0XYiz9vVAQR3mCyyEUqVx2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4505
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

SGkgTWljaGFsLA0KDQo+IEhpIE5lYWwsDQoNCj4gcmVnYXJkaW5nIHN1YmplY3QuDQoNCj4gYXJt
NjQ6IHp5bnFtcDogQWRkIG91dHB1dC1lbmFibGUgcGlucyBmb3Iga3IyNjAtcmV2Qg0KDQo+IHNo
b3VsZCBiZSBiZXR0ZXIgb3B0aW9uLg0KDQpPaywgbm8gcHJvYmxlbS4NCg0KPiBOb3cgdGhhdCB0
aGUgenlucW1wIHBpbmN0cmwgZHJpdmVyIHN1cHBvcnRzIHRoZSB0cmktc3RhdGUgcmVnaXN0ZXJz
LCANCj4gdGhpcyBwYXRjaA0KDQo+IHJlbW92ZSAidGhpcyBwYXRjaCINCg0KT2sNCg0KPiBtYWtl
cyBzdXJlIHRoYXQgdGhlIHBpbnMgcmVxdWlyaW5nIG91dHB1dC1lbmFibGUgYXJlIGNvbmZpZ3Vy
ZWQgDQo+IGFwcHJvcHJpYXRlbHkgZm9yIHRoZSBLUjI2MCBTdGFydGVyIEtpdC4NCj4gDQo+IFdp
dGhvdXQgdGhpcyBwYXRjaCwgdGhlIFVTQiB0byBTRCBjYXJkIGJyaWRnZSBvbiB0aGUgS1IyNjAg
c3RhcnRlciBraXQgDQo+IGlzIG5vdCBlbmFibGVkIGNvcnJlY3RseSB3aGVuIGJvb3Rpbmcgdmlh
IFNQTC4gIFRoaXMgY2F1c2VzIHUtYm9vdCB0byANCj4gZmFpbCB0byBkZXRlY3QgdGhlIFNEIGNh
cmQgaW50ZXJmYWNlLg0KDQo+IFNQTCBjb25uZWN0aW9uIGlzIG1pc2xlYWRpbmcgYmVjYXVzZSBw
aW5zIGFyZSBjb25maWd1cmVkIGFzIHRoZSBwYXJ0IG9mIHBpbmN0cmwgaW50ZXJmYWNlIHdoaWNo
IFNQTCBpcyBub3QgdXNpbmcgb3IgY2FsbGluZy4NCj4gU1BMIGluIHRoaXMgY29uZmlnIGlzIGp1
c3QgdXNpbmcgUVNQSSB3aGljaCBpcyBhbHJlYWR5IGNvbmZpZ3VyZWQgcHJvcGVybHkuDQo+IE9u
IEtSMjYwIFNEIGNhcmQgaXMgY29ubmVjdGVkIHZpYSBVU0IgdG8gU0QgY29udmVydG9yIHRoYXQn
cyB3aHkgcGluY3RybCBzZXQgdXNiIHBpbnMgdXAuIEJ5IGNvcnJlY3RseSBzZXR0aW5nIHVwIHVz
YiBwaW5zIHlvdSBnZXQgYWxzbyBTRCB3b3JraW5nLg0KDQpZZXMsIHlvdSBhcmUgY29ycmVjdC4g
IEkgaGFkIFNQTCBpbiBtaW5kIGJlY2F1c2UgdGhpcyBpcyBub3QgYW4gaXNzdWUgd2hlbiBydW5u
aW5nIHRoZSBGU0JMIGJlY2F1c2UgdGhlIEZTQkwgY29uZmlndXJlcyB0aGVzZSB0cmktc3RhdGUg
cmVnaXN0ZXJzLg0KDQpZb3UgYXJlIGNvcnJlY3QgdGhhdCB3aXRoIHRoaXMgY29udGV4dCwgbXkg
Y29tbWVudHMgYXJlIG1pc2xlYWRpbmcuDQoNCj4gVGhlIHBhdGNoIGl0c2VsZiBpcyB3b3JraW5n
IGZpbmUuDQo+IEFjdHVhbGx5IHRoZSBzYW1lIGlzc3VlcyBhcmUgdGhlcmUgZm9yIGt2MjYwIGJv
YXJkcyBhbmQgYWxzbyBrcjI2MC1yZXZBLiBJIHRoaW5rIHdlIHNob3VsZCBmaXggYWxsIG9mIHRo
ZW0gYXQgb25jZS4NCj4gSSBkaWQgaXQgZm9yIGt2MjYwIHJldkIuDQo+IERvIHlvdSB3YW50IHRv
IGRvIGl0PyBPciBpcyBpdCBmaW5lIGlmIHdlIGxvb2sgYW5kIHRlc3Qgb3RoZXJzIGFuZCBwcm92
aWRlIHYyIHZlcnNpb24gb2YgeW91ciBwYXRjaD8NCg0KSSBiZWxpZXZlIGl0IHdvdWxkIGJlIGJl
dHRlciB0byBnbyBpbiBhbmQgcGF0Y2ggYWxsIG9mIHRoZSB6eW5xbXAgZHRzIGZpbGVzIGFsbCBh
dCBvbmNlLiAgUGxlYXNlIGdvIGFoZWFkIHdpdGggYSB2MiB0aGF0IGNvdmVycyBhbGwgdGhlIGJv
YXJkcywgaWYgb3RoZXJzIGhhdmUgdGhlIHRpbWUuDQoNCkkgb25seSBwYXRjaGVkIHRoZSBrcjI2
MCBiZWNhdXNlIGl0IGlzIGEgbW9yZSBzZXJpb3VzIGlzc3VlIGZvciB0aGUga3IyNjAgc2luY2Ug
dGhlIGJvYXJkIGNhbm5vdCBib290IGZyb20gU0QgY2FyZCB3aXRob3V0IHRoaXMgcGF0Y2guDQoN
Cj4gVGhhbmtzLA0KPiBNaWNoYWwNCg0KQmVzdCByZWdhcmRzLA0KTmVhbCBGcmFnZXINCkFNRA0K
