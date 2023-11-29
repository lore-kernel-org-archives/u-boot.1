Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DB7EC4167B
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 11:02:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72A4A874D0;
	Wed, 29 Nov 2023 12:01:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vO+gFSt3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFE8787467; Wed, 29 Nov 2023 12:01:58 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::62f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EBAB87619
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 12:01:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=love.kumar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TlSTNMyg49r4IHNSL85XNl5TdNBTBNjlp1SaOmVyIhW0I5YBJ2VnzjpM4KL2TG/sf4I08ZZG8wL2iBYve0P00roBp26Th+g0Gi9e7VvFbayCMSbVpreb3Ql32Bx/dw93SkwyJZYlQx1NahcL2MCFjXy4VxzY9Au9r7+VOys61/vWp+PttC0TWVjNLib0Q6eVpI1em7s1iiogAchf9LMPfmgtT1Smdr9iV1kwjIeZnVTEsUOc8k4poL4Bf2i7/OHe44hBnziJmFGQX6MjwVH7h2QPbfdkL5WsZjY1RN44UUP0WNKXQKES461V0tTjpKtANtQz4goEOgUtYWOmbVClSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fDDlS5VBhgx/kmU6vq8wvEPjZehU+o3FKtPUyhIAgxc=;
 b=O40877KsKd5BgRgqn5iVoWytbXh2vC601k+V6lOFvcGjVDF5/D8cLPpbcNGJGI8NnKcbDfepujbKFfu9zImG9MuO9aJ5b+kmVE/nYNKEPqEakKbxmg9LeQGxSDEP1W1afnK4BiNu3LjYpSA91nd8qhksHSHzySn5/5kmNsPD3h+Zk46uwNwvJivlGfimIAzTmbWTJ+WJWP5FfoXUt5LHen324A3Z4hpLqXBz01dDHYpfkomf5Ml2VQLV8v+Alg3imaCjyhs6hmoOJF47yWGYG85cYU8X9QH0ACj5MEIdEeIoQejf90ioGNvR0/UipghLUt0GEVsjPKb9hGQFasU18g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fDDlS5VBhgx/kmU6vq8wvEPjZehU+o3FKtPUyhIAgxc=;
 b=vO+gFSt3JUfuKlM69Ltnuj8ES258lUws0DMWPaIF9th5SsMUFf3UbEIFzSyFpKCk4r55MBHmb0Er+bkk/X4Me8443ZTNle56ZGcZ/Z7GTFFaJt2N3viihU6klUmb27YtdU7LJA6epHD/kF1fXIBVLoO1N6Nxr5brhbg07mA+fl8=
Received: from SA0PR12MB4461.namprd12.prod.outlook.com (2603:10b6:806:9c::22)
 by IA1PR12MB7685.namprd12.prod.outlook.com (2603:10b6:208:423::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23; Wed, 29 Nov
 2023 11:01:50 +0000
Received: from SA0PR12MB4461.namprd12.prod.outlook.com
 ([fe80::b0e8:702a:bb63:c606]) by SA0PR12MB4461.namprd12.prod.outlook.com
 ([fe80::b0e8:702a:bb63:c606%7]) with mapi id 15.20.7046.015; Wed, 29 Nov 2023
 11:01:50 +0000
From: "Kumar, Love" <love.kumar@amd.com>
To: "Simek, Michal" <michal.simek@amd.com>, Mayuresh Chitale
 <mchitale@ventanamicro.com>, Jagan Teki <jagan@amarulasolutions.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: RE: [PATCH v2 0/3] Xilinx SPI driver enhancements
Thread-Topic: [PATCH v2 0/3] Xilinx SPI driver enhancements
Thread-Index: AQHaIp2Cj57m5uCcPEyqZIzf64U8VrCRIZTg
Date: Wed, 29 Nov 2023 11:01:49 +0000
Message-ID: <SA0PR12MB446146960798ECB16ECD5B698383A@SA0PR12MB4461.namprd12.prod.outlook.com>
References: <20231116164336.140171-1-mchitale@ventanamicro.com>
 <3a926efa-2246-43d1-bb3d-e7d028f8d529@amd.com>
In-Reply-To: <3a926efa-2246-43d1-bb3d-e7d028f8d529@amd.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR12MB4461:EE_|IA1PR12MB7685:EE_
x-ms-office365-filtering-correlation-id: 6aa3b586-4f19-40ba-5ced-08dbf0ca9660
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jKeMOl9gWn0oyO/Wlytze7QR8H7Gu0GcH4KpdhGCvzRH8UZ0LKxftj+b2HJrW5tczTnGt8mduLEqWULxsnRgypIutukwyWuxnDHZU/lDbSWOZU2z7DtHRWWElbABn2LyGaBs1m1T+uOAJXWF2fvtaUfSH5XnnlfU5Th9ckLdN77W4FUXPjlrJm9rjpID2VJaEZMp1O4Ts3mPNcqyV/21+Va0aKDZ6ublKRbSi8D+vDzoCwvvy1l7av9KNKCr2e5yOMzO+17uz9pqBYW2lTjeLdL0NZCTyJJm3hv5AHMKQYXFTJOapI68rpgv9pWVF7xcfRogsUGPj1fxAiAzH5yIKbvZrSDrFnq//7EMAr17OKCTW6kegyH3eqVaLwaqpN47L5vC9xHh2SXFPRo+HRf6pXnZXq9qKE0QRHBaZnuXFF+P/kmWbR6FNLWM0WA129hqFHyKeKZvU2Vc9EuQ1sdCJgwpnkFXRX06+qzY1otOIFDgS7fzP+VchdZyzfq5hsF6obFnlDvVuamD+90JXmV/0nM3bLZMoJ8Iyij1kNoxwQRtn/6+JN/6DdgG60gninUF3Xm7UMzwDlmWzLt4j+NT0MkXBbgAdgIAK9vMpdcRZ3I=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4461.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(346002)(396003)(136003)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(83380400001)(38070700009)(26005)(54906003)(66446008)(66476007)(66946007)(66556008)(316002)(76116006)(64756008)(4744005)(110136005)(2906002)(4326008)(8676002)(52536014)(8936002)(5660300002)(86362001)(7696005)(41300700001)(6506007)(71200400001)(9686003)(53546011)(33656002)(478600001)(122000001)(55016003)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NXNRWDBOYUhuRFZUTzJTTWJHMXRPZHdibXg5UXRubFdxVmNsYXdSbzVrZDJV?=
 =?utf-8?B?ZEtKUmFLdEdrL2lsbVBXMG0xSGVTSlFONndSeDVwVXN3THhpNGsxUnY3NkF2?=
 =?utf-8?B?VnllVFNRb3hwa1Awa0FVMWxzVXU3aGxnWXdkakp6OCs2L1ZUbGtseWxLdlUw?=
 =?utf-8?B?aTdNbnpJdVZ5OEFlQ3FJeVRFR0dWRmE2NzloTFV0N3dZYkUyN3doNkxTaVJy?=
 =?utf-8?B?S253Nnd3eXVFZGdBN1VMRnlUWEdYTTlaUFIyUkNoK2RTVjNTbkRpanF5WlMy?=
 =?utf-8?B?a1I1bE9NOGpqamVvK1QrdTVRdDUyZFFxeDdjOXVQNmMxR2U5eTZOZkprMk9H?=
 =?utf-8?B?VFlMcGR1TUN3U0wwbkk4UC9DdFYvVmlyejNRVDFEOTBVcCtURHVGUDJaVHps?=
 =?utf-8?B?VTZrdlFvWG96UWw3OFc5WWdnMitsOHM2VGpYZ1dyNjhYUWF0OFF2SzBIeXY3?=
 =?utf-8?B?Q0pwQ2NlQmttMkM3QkU0dTE5cXRLL3ZmZEVaWm13SHUvdTRDOElHSTlvaXd6?=
 =?utf-8?B?a3hpaEVVRDNKbzVqQWsrcHNIS0ZDTlhFMXl0aE9TbldqVlh4UjhoRmdrNng2?=
 =?utf-8?B?ZmlBMEVtRkJYc0N6TDFLa0hmdVRiN0JMS0MzVU5UM1FadFVZclNuMUxJS2N0?=
 =?utf-8?B?ZjlkMHoxTUZvK20yRkVCR2VxSGhKK1JYZ3RLODcreGhpRTdrWlB4MDVCY0dU?=
 =?utf-8?B?Q0ZUdytJaWJpUnczU2FQQXlZb2N2cU9taVBiY21MSjlTeFhuK3R4WE1lMXNF?=
 =?utf-8?B?TXBVRTZnZkdUMFJrc1k4K01VQ2tSaVhQYnh1N3FlQzRSeUw1Y0M5R1c2QlpT?=
 =?utf-8?B?Tm9FZTFpWDhHOFh2NlQrRG9sV2NzME9tVHlJQlN1YmEzWUw5Rm5MbVhVekF2?=
 =?utf-8?B?WUJPWkx6a2tMbXIyM29zZWJpRzVUd0U3VjUweFN0UTRSUWlLSlNNM0h6YVZR?=
 =?utf-8?B?SUhneGNzcFgzK3VxSHp2THdsQTBuU1dpTDFLeWFDU1ZOQnR5YStMbUE1c1Rx?=
 =?utf-8?B?TkNIb1VQR2VPNS82UERVSDBNckV6WC9wVUtKc2NrN2s4WkxFZGVQbG1OTVl4?=
 =?utf-8?B?THdJZlRSVktVbmR0QUZySHV6WkhZU0pzeUhBTC9RMDh1VDY3czg0RkpKYnZy?=
 =?utf-8?B?RUlIbnhvVnJjTXpRMWlRV0pSWmticjAyKzZCRUpsZE80b3gwZGIzRVRTWGt2?=
 =?utf-8?B?U3l1bmJyR01jNnUxbXN2TzN5bkZyaGlRV0g4Vk4rOWhhUll4dm5SQVZ1YnRp?=
 =?utf-8?B?TVhoVjIwN3FxSk5vcWZuaHFndTZtT0F1R2Y0TjFsTmlsVTNtODlXdTlqcE4v?=
 =?utf-8?B?YkF6dHFMT0Rta2xaZHU4Y3J0OGNIUkJtVlE1b2FsalJPQjMvMDYzYldJcUFk?=
 =?utf-8?B?L250LzM4SldTWnhLb0RRUkhlZG9qcUkxY3VJT1hKVE9lY1JRWkw5QzcxSktH?=
 =?utf-8?B?Z3BSTkZOM283M2xYeGFzNU1ZU1RBOVROcEJaazI2U1gyTFRaZkVsNXFUUFFa?=
 =?utf-8?B?blBidHgzN1ppVVZnV0FOb1hlNS9wWmhVaXNhaVV2SHRRVFR2ZHZVY0dweWNh?=
 =?utf-8?B?RHpmc1k2cVhiOHpySlRqVkhsd1d1Q1VqSGN4SGQzRU5ITG0ySkdzajVyUU95?=
 =?utf-8?B?eVpwbEwvSFdRUjRONFFna3dwenRvK1pCZWxZZ2xJS08zb21hR052T0tiMmtx?=
 =?utf-8?B?Y3RYZkFBWlVvMzZpQjFpTmJsZXNtK2VqeVZSWCtKUlpBVGVYTnFsYzhOdTdF?=
 =?utf-8?B?NU9BMU5jSHNLMmlobzlncDJ0SHdMTnZ5LzY5WHUxNjR5dStWTnhYczl0QnhN?=
 =?utf-8?B?S2lDbGpEcmRkZGpPcHJCanRTR2ZkNzllSlRRVklINGxOYVlSSHNmZzlvYU5j?=
 =?utf-8?B?bERmYm00UC9QL2EvdGUwMFY5NGtGUm84UTdJN3pkbW1KaVFCZ21jNjVEQno1?=
 =?utf-8?B?UHA3Qkp5WDZoM3J4d1lWcUZvWmcrTjhSdGhxczBQMTVQZzF0bXJ4eVdtUGd0?=
 =?utf-8?B?S2U4TklBRElib3NaSUFNZXhEb1pZY1FQaStMMDFNWHAwa3k5R1dkY3dpcU5C?=
 =?utf-8?B?YW4zK25FS0wrYmFJMjlJQ3YwUUE0eXp2aWdnNGxST0RRdE9RNlhSdmgydDcy?=
 =?utf-8?Q?Kops=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4461.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aa3b586-4f19-40ba-5ced-08dbf0ca9660
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2023 11:01:49.9770 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /aTsasWK51nc0wYj/nOGcLoKF4zOcrt67y/DWqvgMKViA5qgrHSlNgok4KaCD+f6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7685
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2ltZWssIE1pY2hhbCA8
bWljaGFsLnNpbWVrQGFtZC5jb20+DQo+IFNlbnQ6IDI5IE5vdmVtYmVyIDIwMjMgMTM6NTUNCj4g
VG86IE1heXVyZXNoIENoaXRhbGUgPG1jaGl0YWxlQHZlbnRhbmFtaWNyby5jb20+OyBKYWdhbiBU
ZWtpDQo+IDxqYWdhbkBhbWFydWxhc29sdXRpb25zLmNvbT47IEt1bWFyLCBMb3ZlIDxsb3ZlLmt1
bWFyQGFtZC5jb20+DQo+IENjOiB1LWJvb3RAbGlzdHMuZGVueC5kZTsgU2ltb24gR2xhc3MgPHNq
Z0BjaHJvbWl1bS5vcmc+OyBUb20gUmluaQ0KPiA8dHJpbmlAa29uc3Vsa28uY29tPg0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIIHYyIDAvM10gWGlsaW54IFNQSSBkcml2ZXIgZW5oYW5jZW1lbnRzDQo+
IA0KPiArTG92ZQ0KPiANCj4gT24gMTEvMTYvMjMgMTc6NDMsIE1heXVyZXNoIENoaXRhbGUgd3Jv
dGU6DQo+ID4gVGhpcyBzZXJpZXMgbWFrZXMgdGhlIFhpbGlueCBYUFMgU1BJIGRyaXZlciBjb21w
YXRpYmxlIHdpdGggdGhlIE1NQ19TUEkNCj4gPiBkcml2ZXIgYW5kIGFsc28gaW5jbHVkZXMgYW4g
ZW5oYWNlbWVudCBmcm9tIHRoZSBjb3JyZXNwb25kaW5nIExpbnV4DQo+IGRyaXZlci4NCj4gPg0K
PiA+IENoYW5nZXMgaW4gdjI6DQo+ID4gLSBJbXByb3ZlIGNvbW1lbnQgYW5kIGFkZCByZXZpZXdl
ZC1ieSB0YWcgaW4gcGF0Y2ggMw0KPiA+DQo+ID4gTWF5dXJlc2ggQ2hpdGFsZSAoMyk6DQo+ID4g
ICAgZHJpdmVyczogeGlsaW54X3NwaTogVXNlIHVkZXZpY2UgaW4gc3RhcnRfdHJhbmZlcg0KPiA+
ICAgIGRyaXZlcnM6IHhpbGlueF9zcGk6IEFkZCB4ZmVyIGNhbGxiYWNrDQo+ID4gICAgZHJpdmVy
czogeGlsaW54X3NwaTogUHJvYmUgZmlmb19kZXB0aCBhdCBydW50aW1lDQo+ID4NCj4gPiAgIGRy
aXZlcnMvc3BpL3hpbGlueF9zcGkuYyB8IDY4ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysr
Ky0tLS0tLS0tLQ0KPiAtDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgNTIgaW5zZXJ0aW9ucygrKSwg
MTYgZGVsZXRpb25zKC0pDQo+ID4NCg0KVGVzdGVkLWJ5OiBMb3ZlIEt1bWFyIDxsb3ZlLmt1bWFy
QGFtZC5jb20+DQoNCg==
