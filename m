Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 840C6C54E67
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 23:50:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04FFF88096;
	Thu, 28 Mar 2024 00:50:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="nw9hSKYm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED32F8809B; Thu, 28 Mar 2024 00:50:17 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::631])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE7298801A
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 00:50:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iGg/+sgsYOTNmzJNuWPL+usGJIlEVYM6138xL1vrHYZL1dxwTpJgKZbfqtFQKCfuT89cIEHJ87uGi6YzAC/4W+yxIFRx4l0K26iBeSwKwuTb+qVvnvizZzRqSYioOGVLC8R2mP3qXzag5shdAsHZ1xFVEIv99VGDMgAJJOJk4htcoK/ztySA1Ltitjxxw9Ilv71XFQjXCbH984SfktQcflMBST48Fp6VmcUDRLlMZa3/4iV6ykiwT9ySADXwa0WzhrdOfGVj6MEbdU2sNLJbLeEsce1K/VxOG26WFKoiHienX/RiIAMfZEXjph+MHXla30yE1m8kBQxQUoYVHBaLJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8JDa0YdVN5rUz6Xdjoa9UkCBjFz2VLUz2ieGB9jqZJs=;
 b=HtxiG2HWSv3UdSTdcd/6KIKdPNlUXsc1fwIztOg49iz6XCIsV9B362KdHNKKnk70EF5XOUmhgnDeaG7xGgMDWWhhYbBFtURcNnMauK9spEQuF9Hh37YpaMRfyiMjO2cEZm9xFzJccz/e1ENQzTBmrJDh7dl/RTPn1I5iTF5lnZo4IyhISra9tG38o4+JCOgFfb7lBAHAxDDtuPRH+kwsZ5osJswXECIwgoW5iQmaiGReAJ/fwECTEbzUJI4s3eeZ7w9DYF1Ct0X2FxG2DxeCMZydrb11Je5MdUGlyHBks40qMDhRma+f2ttG3Oq89zDAzJrs3i4bxjZKRnI4rN1qhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8JDa0YdVN5rUz6Xdjoa9UkCBjFz2VLUz2ieGB9jqZJs=;
 b=nw9hSKYm6xnJ6wOp80HIJAHbH2Qezzr7bjp0KxBDdakKA8G7HmxEgfYYWQbIAqaaLaicfrxxJ45SnIrs5jL8isD1mL8TEzFBcJplgWQjJ/px2NQ33zcC026wTeoeEnz0zD50Gw7OG7sJlTE6bQyfZv5+eOxevqs362JWUbtyUYE=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DUZPR04MB10064.eurprd04.prod.outlook.com (2603:10a6:10:4d3::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Wed, 27 Mar
 2024 23:50:14 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Wed, 27 Mar 2024
 23:50:14 +0000
From: Peng Fan <peng.fan@nxp.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>, dl-uboot-imx <uboot-imx@nxp.com>
CC: Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: [PATCH v2 0/6] imx93-11x11-evk: convert to OF_UPSTREAM
Thread-Topic: [PATCH v2 0/6] imx93-11x11-evk: convert to OF_UPSTREAM
Thread-Index: AQHagKEXQoOZYjIDkEqERj0WDF8tZLFMQcJg
Date: Wed, 27 Mar 2024 23:50:14 +0000
Message-ID: <DU0PR04MB9417FC9A183EDC218B5472DF88342@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240328-imx93-of-v2-0-909f5d37da87@nxp.com>
In-Reply-To: <20240328-imx93-of-v2-0-909f5d37da87@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DUZPR04MB10064:EE_
x-ms-office365-filtering-correlation-id: 01d3ac4c-340f-4d4d-f5b3-08dc4eb8a60a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NjhF0d/fWNGkmDpYj7RwFb+XJ4lvnB34iXTA9/OX3JQTpWdXhnXpBVIUlxEufg43IlAHE6oiCmvtOhnnOjATph7/T3PIx3YtySmK2VtJnUh8bTjCONAr3+HEEPHtpyO8O8fJGB77BCimz8NEG/dYog10tWf5gEQTAJbsw/doASBi7qBJddbpRWLhFJK6b2nNuTrkmTBuuVXUQVUpFgjkLt3fhX6NCwBox6wNWje39UiSZuG7jv77T7N8Vg2sIP940Qu3BHIBYCVO6iEe92H7u9yW/06jCmb5bVJigWVMVKyR4CGk6a8/4LuqaIjAQtVTgbasVl2PJbIf8gxGbeh99et1Q3VkYdU3JKt1zkjjqtzE++YkB92ZiQCQSje1Zb9SRScnE/52UgfBxx45H/dC+kWFu88Bp0Vq6eVKMR7zylObqe8O6jSuFJiUXYVRZ7UGNyUgwF/WrpEV/ihJq3aHlKYUf1ZckcoAPpAgiee9hkC6/8iHeYfAPbBJ2yQHxrMWqp0hY3oEQkOObdop02NJXH/6f/X1UxeOyty//IYFQD5dGRaK/j9pgJ61tDcnP6pDjAmIvFXEzJvXYWPBogonQS8tuOfLsGLjDzRD3rZOMYR4+PRop7xkeeOyJDB8hYWvIBaPRESR3KsEumpaEc18UlmDd0Z1S797ZEojo3efh1I=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9417.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L2g3dGVmU3VzMkxoQkRibnVYM2xzK0l6OTRkaU5SSW9SQ3FYV0RvWkJrbTRl?=
 =?utf-8?B?R3ZvdFc2cEZqOHFvc2xWSTE5MjFWa21nR0VERDlYQ0poWmEyaFBXZU5KWUV4?=
 =?utf-8?B?NlJWZlE4Tkhqa3EwUDlZbVVTVDZjVk1MaXpzc3Z0eTRVR1ZEK2JTYXlqZUk2?=
 =?utf-8?B?bzg2WmtESUFNQUczeXFDUC9tYk1KRjhyN1NHSXdrRkMxQzltK2krRm5RTTdv?=
 =?utf-8?B?Y1RMU0w4TlkvMy9DOEE0alkxTFo1YTh5OEVHQTkvcmluN3EzRzNSV3pZaGFi?=
 =?utf-8?B?VTFQelFwaUhWZHZ6ZC9yN016U20yRGx0VzF0c2x1NkVSNXdLUzZqeTc5ZnZw?=
 =?utf-8?B?bUQ4YXo3b0RidWYxY1FRY3JvQ2RQaFhTMS9YYzVEWFJjK3JGdXZ2YkFvMnZ4?=
 =?utf-8?B?eWJWQ1A1ZmZoQVhvT0d0T1R2b0RGNEJ0ck1aSHJSYVpqMnhpd1J4TjJaWjNw?=
 =?utf-8?B?MXBBRjFWWVNuS0RWaWVLSXhyL1NybVBHU2llSUtoTlNhZEp5MnZjdThQZHRN?=
 =?utf-8?B?UDFaalNud1BXN0wxaEc0RERwWk9EVXJSR0pNbk1LUkxqeHpOTW1XcWEwRXM1?=
 =?utf-8?B?bGxrY29DS3FQRkhBMDBhanlGMm53dlJNYnJGTFlYT1F1dzFycHRCU1htcGVN?=
 =?utf-8?B?WmRYaHNFRlJvTHBUeHF1bmlIaWpYMkN1OTJzMnJGYlBCNVpoa0pLcWYrRG41?=
 =?utf-8?B?UTMxTVd2RG5zWjVzQk5YUlZMK0JnNmxtQzdwVW42VStoNnhGaWQycHdZN3Nu?=
 =?utf-8?B?RHllbGxlaEVkeUtoYXFJM1FvWDZacWZWSjQyN3BiSlNhb0Q3TzROUlRYT0hj?=
 =?utf-8?B?WG02S0g3SGhlK2NoUWpMRGtJUHFDM0NCMFlBZlZvd3MvR0t4blZNcUFjb1dS?=
 =?utf-8?B?TFBKbC8vSVBETTB0b0swMWpIdm9LV2dTeDU1NzZjQ1pCdkUxVHdrV3Y3cUFC?=
 =?utf-8?B?T2NtRzE3cS9vU3NUaG5XYktiZHA4TmZQMk1FcEFGN2UxaVYvbFBxVXJtVHk1?=
 =?utf-8?B?dTlsOTJzSklJclJoaHk0RXJoaGREeUc5bEtVZDBHS2dCdmMwSlVDMTdLTUUv?=
 =?utf-8?B?VlgyWnpHMXcvNisxeWZYMG1TVjFJOUNta1RocnQyNkFsNHpoZmE5SDNXcHUv?=
 =?utf-8?B?REFuTHFhaGdlTEQ1TXVuOUNDUzZtMDZQTnlrOURvV1pNWGc1dE5ZM0crdUN3?=
 =?utf-8?B?UmlyWWp1dnZoOUFvTWhadWM2QTIrZGE2L3gwVmZLSDJiQ2QyZWUyaEpkRjA4?=
 =?utf-8?B?Mk1vdms4QUtaNGZVM3B0VTIrckszbVR6SDh2cUs0aGNtL0lqYm9XVTdMNWpG?=
 =?utf-8?B?MEQxeDhzempYUmNtQTZieTJaVGkzc3ZwaHM0d2cvaWtnZUJ0N0JpRlRJS1k0?=
 =?utf-8?B?OHo4QXQ2d0JzWWtFZ1NFc2hPT3BpZnFPRTVrd0dvbzQ0MWs1cjBRazZuU25v?=
 =?utf-8?B?ejhwSVdzUDJudHpQbVcyZ0lPK2xkeU1wWUswdzFZWmMzNmpYWDN4V2NkMVhw?=
 =?utf-8?B?Qytud3JIa25xbnJhWmt4TnphdHNQVSs2WGlURnQ4YnVWK2xqN3RZdXBKMmRV?=
 =?utf-8?B?OTNpaFZHYUFnc0Y3M2tiaUZ6dkk0SjdwT2NCeWtzRGhNcjdkTXRYRW80S2s3?=
 =?utf-8?B?OUFrS0Z6L1dqUTNlVjl0eXY4WUxFcWd5aDF5MWlTUG5GTS9BZUFzNHVpTHBL?=
 =?utf-8?B?Z1J6OHBqSWNrNmhwWlBWRmxpU2ZQRm9JK3k5eUZQWStqQlc1dUwxaVVMVjRD?=
 =?utf-8?B?dlpJU29DVEd0WEszZkRKd2RoMHZDYTFwN0RKRUtlT3A5Rk8xOFY5WFN5OE9D?=
 =?utf-8?B?ZkdqdGdHUzJMZ0RUNVNJcy9GNkNsNENaZmZQVTVoMUcveTdtdlB1clc3OW1i?=
 =?utf-8?B?Vk5iZmRpK1J2WEZHcFQ1R3lwMDJ0ZDFLckZhM0tuM1BXTUk3Z0NHN0Y3bXho?=
 =?utf-8?B?MmJHUXROa25BdDBRWExDNDJya2M0ZjhSdzN0VTI3cjlpQUxKT0pQQVhSYTRa?=
 =?utf-8?B?K1h5Q2Q0TkRIWmVkWEhOb0ZTN0I2NXdTMkFQdk1MdS9kTEptNHNIeGRlV2s5?=
 =?utf-8?B?NkpEM2libGExU3JuZGhRMEZycFpHR0lQQmQ3a2dHZUR2ZEtkMnFEbCtwTFV4?=
 =?utf-8?Q?zbfk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01d3ac4c-340f-4d4d-f5b3-08dc4eb8a60a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2024 23:50:14.6336 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o+Fta651/VYXD1rD1INBiU8U+tV+eKX8Oplj3GxU5Wc+bt1x+WD77yXXBhgXUfO6GW61FaLH3/Fr03v8rOq9iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB10064
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

UGxlYXNlIGlnbm9yZSB0aGlzIHBhdGNoc2V0LiBJIG5lZWQgcmVzZW5kLg0KDQpUaGFua3MuDQoN
Cj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGVuZyBGYW4gKE9TUykgPHBl
bmcuZmFuQG9zcy5ueHAuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgTWFyY2ggMjgsIDIwMjQgODo0
NyBBTQ0KPiBUbzogU3RlZmFubyBCYWJpYyA8c2JhYmljQGRlbnguZGU+OyBGYWJpbyBFc3RldmFt
IDxmZXN0ZXZhbUBnbWFpbC5jb20+Ow0KPiBkbC11Ym9vdC1pbXggPHVib290LWlteEBueHAuY29t
Pg0KPiBDYzogU3VtaXQgR2FyZyA8c3VtaXQuZ2FyZ0BsaW5hcm8ub3JnPjsgVG9tIFJpbmkgPHRy
aW5pQGtvbnN1bGtvLmNvbT47IHUtDQo+IGJvb3RAbGlzdHMuZGVueC5kZTsgUGVuZyBGYW4gPHBl
bmcuZmFuQG54cC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCB2MiAwLzZdIGlteDkzLTExeDExLWV2
azogY29udmVydCB0byBPRl9VUFNUUkVBTQ0KPiANCj4gVG8gc3VwcG9ydCBPRl9VUFNUUkVBTSwg
YSBmZXcgZHJpdmVyIGNoYW5nZXMgYXJlIGluY2x1ZGVkLg0KPiBGb3IgVE1VLCBzdGlsbCB1c2Ug
VS1Cb290IG5vZGUsIEkgd2lsbCBwcmVwYXJlIGEga2VybmVsIHVwZGF0ZSwgdGhlbiBiYWNrIHRv
IFUtDQo+IEJvb3Qgc3VwcG9ydC4NCj4gQWRkIHRoZSBwbWljIG5vZGVzIHRvIHgtdS1ib290LmR0
c2ksIHNpbmNlIHVwc3RyZWFtIHN0aWxsIG5vdCBoYXMgaXQuDQo+IGlteDkzLmR0c2kgc3RpbGwg
a2VwdCBiZWNhdXNlIG90aGVyIGJvYXJkcyBzdGlsbCB1c2UgaXQgYXMgb2Ygbm93Lg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+IC0tLQ0KPiBDaGFu
Z2VzIGluIHYyOg0KPiAtIEFkZCBhIG5ldyBwYXRjaCB0byBzeW5jIGNsb2NrIGhlYWRlciB0byBh
dm9pZCBicmVha2luZw0KPiAtIERyb3AgdGhlIE1ha2VmaWxlIGNoYW5nZSB3aGljaCBjaGFuZ2Ug
aW5jbHVkaW5nIG9yZGVyDQo+IC0gTGluayB0byB2MTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
ci8yMDI0MDMyNy1pbXg5My1vZi12MS0wLQ0KPiBhZmFiNmIzMTQyMmFAbnhwLmNvbQ0KPiANCj4g
LS0tDQo+IFBlbmcgRmFuICg2KToNCj4gICAgICAgZ3BpbzogaW14X3JncGlvMnA6IHN1cHBvcnQg
b25lIGFkZHJlc3MNCj4gICAgICAgc2VyaWFsOiBscHVhcnQ6IHVzZSBpcGcgY2xrIGZvciBpLk1Y
N1VMUA0KPiAgICAgICBjcHU6IGRyb3AgaW14OV9jcHUNCj4gICAgICAgY2xrOiBpbXg5MzogZml4
IGFuYXRvcCBiYXNlDQo+ICAgICAgIGR0LWJpbmRpbmdzOiBpbXg5Mzogc3luYyBjbG9jayBoZWFk
ZXINCj4gICAgICAgaW14OiBpbXg5My0xMXgxMS1ldms6IGNvbnZlcnQgdG8gT0ZfVVBTVFJFQU0N
Cj4gDQo+ICBhcmNoL2FybS9kdHMvTWFrZWZpbGUgICAgICAgICAgICAgICAgICAgIHwgICAxIC0N
Cj4gIGFyY2gvYXJtL2R0cy9pbXg4bXAtZXZrLmR0cyAgICAgICAgICAgICAgfCA2ODQgLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgYXJjaC9hcm0vZHRzL2lteDkzLTExeDExLWV2
ay11LWJvb3QuZHRzaSB8IDExOCArKysrKysNCj4gIGFyY2gvYXJtL2R0cy9pbXg5My0xMXgxMS1l
dmsuZHRzICAgICAgICAgfCAzMjIgLS0tLS0tLS0tLS0tLS0tDQo+ICBhcmNoL2FybS9kdHMvaW14
OTMtdS1ib290LmR0c2kgICAgICAgICAgIHwgIDE1ICsNCj4gIGFyY2gvYXJtL21hY2gtaW14L2lt
eDkvS2NvbmZpZyAgICAgICAgICAgfCAgIDEgKw0KPiAgY29uZmlncy9pbXg5M18xMXgxMV9ldmtf
ZGVmY29uZmlnICAgICAgICB8ICAgMiArLQ0KPiAgY29uZmlncy9pbXg5M18xMXgxMV9ldmtfbGRf
ZGVmY29uZmlnICAgICB8ICAgMiArLQ0KPiAgZHJpdmVycy9jbGsvaW14L2Nsay1pbXg5My5jICAg
ICAgICAgICAgICB8ICAgMiArLQ0KPiAgZHJpdmVycy9jcHUvaW14OV9jcHUuYyAgICAgICAgICAg
ICAgICAgICB8IDIyNCAtLS0tLS0tLS0tDQo+ICBkcml2ZXJzL2dwaW8vaW14X3JncGlvMnAuYyAg
ICAgICAgICAgICAgIHwgIDQyICstDQo+ICBkcml2ZXJzL3NlcmlhbC9zZXJpYWxfbHB1YXJ0LmMg
ICAgICAgICAgIHwgICA5ICstDQo+ICBpbmNsdWRlL2R0LWJpbmRpbmdzL2Nsb2NrL2lteDkzLWNs
b2NrLmggIHwgICAzICstDQo+ICAxMyBmaWxlcyBjaGFuZ2VkLCAxODUgaW5zZXJ0aW9ucygrKSwg
MTI0MCBkZWxldGlvbnMoLSkNCj4gLS0tDQo+IGJhc2UtY29tbWl0OiBhYjhkOWNhMzA0NGFjZjUx
ZDhmZjNiZjNjNDcxOGM0OGYzMGFkNjA2DQo+IGNoYW5nZS1pZDogMjAyNDAzMjctaW14OTMtb2Yt
NTZlZjJiOTZmMmUyDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IC0tDQo+IFBlbmcgRmFuIDxwZW5n
LmZhbkBueHAuY29tPg0KDQo=
