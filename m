Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFA43EE645A
	for <u-boot@archiver.kernel.org>; Fri, 15 Sep 2023 11:26:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2306D86679;
	Fri, 15 Sep 2023 13:26:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NEpecPqM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F20908669D; Fri, 15 Sep 2023 04:52:44 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::60a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D70508654B
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 04:52:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JHufIzK37a3Q17gAiZ6eDBpCHFTfz/5YOspRSl+lyEZNM4yK5J896cISIeajAB75qmN0KRrikyMvQ+6NNs89/cbW9doCJlOANqmdEtwypHbSQqrz0yQSm7Y6nuPWMHBgPg0mMdax2vTCojB/u9wtIYXBdwsxavQABijTizxEC8XhYzMt7T/yifBFY6YOo5F2kSVo/vYyDIQA95ZGFVPFs+DOhL2VhOImQnVjBXTsPYaytHXBIK5NVJVLHz+ec9tF/io3OJ2PjQ1eFI8yPmMw53+mf1BqK32iTkHIPA+I9J29ROkiCii2Bw8B0qwKsUNv0LFu+gEm/zFXp1A9mSeJ/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NBGkZfFufQbbGO6LRyL2TLvkVw470Ey1n64pJAX8nPo=;
 b=PHm3om3p54M7oIZ273Sgh8eUQFqVhGngrHeUTpuhONl47PvbEVdK+G5XGpZg1hbBgQ79iqyYttVmMzmwp1FkMBbZcs06WoSe2KKe4X42LOQ46gsyDZsNsczS6I9CZJyHGOOIk5QnNHCYlkU2QbWWWwN1lGiMOqP0TdMhS5jU68B78tAxN+0y7Cha+dVppzdKwQHvzC31EOEIprBeTchzL0ddoVimTkFwLNx7+Km+sFzIZA2CaHY5DhO1RkHib3vrbcDlx4T7L7j/9bTgPgpBACRE9LbHCh7edpF9lFl7698u+V5Ux2sQJ4M0LAjUPIuNMM1O0tLQIHm8bJgr/1jM1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NBGkZfFufQbbGO6LRyL2TLvkVw470Ey1n64pJAX8nPo=;
 b=NEpecPqM/2GuW9RXBC4KubD9JAWrwE8EuOcGC75gbLY2KQQipudUwrGayRuSy+/jIS5IbCSz5TGRVlfUn7TlazhRVyofMX5rX5gastpumj54+E+jMfDlwrqxspWi3iIZm1tRmsE7b8dPM5Gea7ShDKzeftLpseB+41GD1w1PZ7o=
Received: from DM6PR12MB3738.namprd12.prod.outlook.com (2603:10b6:5:1c7::17)
 by LV3PR12MB9257.namprd12.prod.outlook.com (2603:10b6:408:1b7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Fri, 15 Sep
 2023 02:52:39 +0000
Received: from DM6PR12MB3738.namprd12.prod.outlook.com
 ([fe80::b338:9dec:e414:9024]) by DM6PR12MB3738.namprd12.prod.outlook.com
 ([fe80::b338:9dec:e414:9024%7]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 02:52:38 +0000
From: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>
To: "Simek, Michal" <michal.simek@amd.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
 "git@xilinx.com" <git@xilinx.com>, Ashok Reddy Soma
 <ashok.reddy.soma@amd.com>
Subject: RE: [PATCH] spi: zynqmp_qspi: Workaround for small data cache issue
Thread-Topic: [PATCH] spi: zynqmp_qspi: Workaround for small data cache issue
Thread-Index: AQHZ5vj90f6aCL25gU2mzaUykDfSNLAaWsQAgADWfgA=
Date: Fri, 15 Sep 2023 02:52:38 +0000
Message-ID: <DM6PR12MB37389B189E87930F31001A6B98F6A@DM6PR12MB3738.namprd12.prod.outlook.com>
References: <20230914104826.30153-1-venkatesh.abbarapu@amd.com>
 <372b339a-1a55-4a7a-8891-2b3f8798420c@amd.com>
In-Reply-To: <372b339a-1a55-4a7a-8891-2b3f8798420c@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB3738:EE_|LV3PR12MB9257:EE_
x-ms-office365-filtering-correlation-id: 2edc3419-632b-4374-4335-08dbb596d273
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x7mwiUFSedqLv7TGFng1FJHcxDljknAN+oHPBnj5So4ULBThMkzFq8Ssae2DVC8GvUNAB8yw8mouMMFeRs4V2fIfuSs01AgDmAwGlKLWU+vgDRq6FD8syUm0horXmP/C5V5p9rhmeL1yHmBIBj0e6h2HKsxVLsJSCfPwbcFWRcG2KAuPPsjve4AMvyPc2CxFRI9LzkhWEMuEvEDjG1T0dZWS9iT4hfRUS/mQfsuc1PN2U+dfkLFEsr7gZLqIg5MOz15KP704EMwiOXlHWie0rzmDCZWOT05c9b0QnyC3yazT5/JuYu03FCdb2gxh2KI61X61qDn5zVSmUZyTjMGJvtrWHFEWCNyZTCDO3dCz/lPtreRoNDiDwj8geJXf+j1mdd0wOKXCERA0l2J2ch83aJOrw393wYupjfOBMcOmBPhWzPODfLqGPcI1Rwy4hf+K77B8vX3aXuttpF2b5zO22Yevj46QtfEcWidPwdtCpxhp16sU8ywOEp3n+cLioMwsmZo7R268IALKxA42f6BkvtbCs2xXd2FgePskpuB3t7aFgvcmYwlRkGuOsnLDs9eKZtoqYCTKUIp/QX8d80tWHFZqzCixkB1Q6bTChoVv44jboWJJ6FrW1Y6btdELbLsH
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3738.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(366004)(346002)(376002)(39860400002)(451199024)(1800799009)(186009)(478600001)(53546011)(71200400001)(7696005)(6506007)(9686003)(26005)(2906002)(83380400001)(66476007)(54906003)(316002)(66946007)(64756008)(110136005)(4326008)(52536014)(5660300002)(66556008)(66446008)(41300700001)(8936002)(8676002)(76116006)(33656002)(38070700005)(86362001)(38100700002)(55016003)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?azU1NmdsTXptS3k4bzYyV2pyNnYyOWVweDAzQS9LM2VaQ0dnZWtwSnRpU01V?=
 =?utf-8?B?bTQwdEJhYkU3YkY0YTNBMk80dHVCRVRtK2Jia2tBeGNLVUVNcnMzK3pNTXZw?=
 =?utf-8?B?RW1BVm9rcUJ4KytUNDFxK1gyMFA5K0pzd3pVZzBoMmZTZElFb1lESDNuUzVI?=
 =?utf-8?B?cDZRNm1xTThCRGlQUVVVaEljaDB5NmZsSVd4cnVIRUw2blJWUTVaQkhWdzhG?=
 =?utf-8?B?YVVUenNCTFR2RWMxc1ZIT1R4bjBiL2sxc2ZXSHFZN3JlbXBjWTVabkpDd0ZQ?=
 =?utf-8?B?S29SMnpxc2NZL09ScnNMU3lwMzdQUkV4M1MvczluUXNyQThudFkvQzEwZzFs?=
 =?utf-8?B?SC8zbTZqRjkydnVtdktOSmFEdEFWeEJSUndpYnBCRE9La1Ryd3o0WFQwZHZz?=
 =?utf-8?B?N3p3Uk5VYzBHL1B0WW1Fei9OYTZKYkN5aWw5TFlnbk52NEcySmJaWnBDZGJT?=
 =?utf-8?B?TTNvSXV0QUZxQUVEOGZVMXh6c2hOOTVWaEc1VjVZNGdkT1pGNkxKUFQrZnR2?=
 =?utf-8?B?Wmx1SVE4Mjh2djBiUERlclFXbHMrR0k4b2RtUVJCd1NYSCswRlRVajI3bWc5?=
 =?utf-8?B?UDZoZkt6aXZWaStUT0RsZWZGYXExSXp5d2o2Q29XRFZVWnlJb3JGbjJhSGJo?=
 =?utf-8?B?aVJYQjE2Wnh4WTJxZ1dZT0lJU3A4cGxwNEx1cXpodEppajJQak5YV1ROb0x4?=
 =?utf-8?B?YWtOa21CR0Y5TWVFTFNXOS9PZXNnNHBqT0lQOHY3cFNucE1hV3Jndkhwb1hP?=
 =?utf-8?B?MEFZS3Q5MURMS0FLNEdlcDY4NXBYYWE1V3NjbGoxWG9sOWl5WXA2Q2cwSHFx?=
 =?utf-8?B?eEd1blVOejQ1QWNOR1h2RXc4TXNUWlpsUm1TeUhzYzJ2ek0yeWFiRkZpQzRX?=
 =?utf-8?B?bHozblJQREZFYWhpbzdDcU5vbUdnY1hYYW9leTZyTDQ4SFExb0lBYk5zdmFK?=
 =?utf-8?B?QTRTTmZMbFIya0hYWXd2L1lCWlRXMExHeVd4WHN0a0h6MEdwRGE0N0hqcEY4?=
 =?utf-8?B?L0pSSmY0b3VEOHpJTFhwb3FyZmx3eXA3VWwvbjNsWldrZmw5NjJnREJvTXNC?=
 =?utf-8?B?TUJuLy9GbncxcGFZY0RBM0dzVGtuNkR2Q1poRHhHWFlHMS9ORTBrMkNBVjdO?=
 =?utf-8?B?b2dSK2E3N0ozTDcyV2QzbWhmRW9FbGlBR2pldnhoYWtrQVMzU01wdTZFV2Jy?=
 =?utf-8?B?aG56cDhwcjJZU2Q2SUN2cHRvK0dCU3pYTkdjRzVGM0w2N1V0VGliWXBYKzBT?=
 =?utf-8?B?dkc0RENvb1RmeXBNVStvSXI1WG9QUzR6d1EzOFFRZGRUSTFTNW5RTlpxSnla?=
 =?utf-8?B?bUZvZXB5U2RLanRVa21ZYmV2SnZUcUVYcFZDYlJjdDNsZ1JaKzRWeGVTY2Rz?=
 =?utf-8?B?S2dEM1g1a2xKb25PZ2ZvRnFpcHRGa2lOSUF3UTJpMzI3TTdTMVE3M3FuNkl4?=
 =?utf-8?B?VnFPNzVYdHAxM2Q5eHgwWXo3NnRXY2tJS2lKdE9FM1hkWTk5Y3JWSU54dFRC?=
 =?utf-8?B?TDgyYUxHSEl1YUk0VjJUZVdDNi9xMXVpRG5jaXFITnY1K0JPNjdWUm1PRzl3?=
 =?utf-8?B?SVF1OFNLa0JGTi9IZENRdUY0NjRmcGdhTnNGL1YycytaTkRrTlpTeVV4NUdo?=
 =?utf-8?B?TkNZNXVpMmQzZzUvOHRKekNsRThaQVBwejJWV01PdWhVM0FuNHBleEFsYlJG?=
 =?utf-8?B?Q3NBNkY3SU5mU3BNeWduM3FoZzNwMVhwWkRPTFl4T0tjSFd1VTRJRnZpWGF5?=
 =?utf-8?B?KzZzdk9KbUNmQ2tDS3BCQW00c1pNbkl4MDhTT1ZnNzd6UElrN3NMUGZUbkx0?=
 =?utf-8?B?ZXl6QjNmYS9vMUJHK2h2WmludVp5RVVzWEJkSlQ1VFNTeHBobHcyS0ttODhh?=
 =?utf-8?B?SHlheG5ISUxqWVFtWU1VUGtWN2Z5TWcrRW1jcXdHalJwQXdZL0x0ZDJhMkp5?=
 =?utf-8?B?T1JOUndydDVqTGs5ZEVLNEhxTHc5RE1kU3dCRU9NRFdjdlZnT0t1OENKbVV4?=
 =?utf-8?B?eUJ5dnN4S3BBbWdnTlBvdzFVUmw5alNBZkZ2WmIwK080S2tIaWZ1ak1HU3F5?=
 =?utf-8?B?K0UwOERQUWdtcTRndzM3RGQ0Z1dHWlBmaVNCck9sa1RhR2lWUWViZ3lncWtD?=
 =?utf-8?Q?dHBg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3738.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2edc3419-632b-4374-4335-08dbb596d273
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2023 02:52:38.3471 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o7AwzlsDgWh0DdvQLEURXzrO179lfLNsQFBmIDrdT08Qk6rjlR/4wSb3daY1RQ1b4EgY8F5ebB7z7vXRTaS9qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9257
X-Mailman-Approved-At: Fri, 15 Sep 2023 13:26:40 +0200
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

SGkgTWljaGFsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFNpbWVr
LCBNaWNoYWwgPG1pY2hhbC5zaW1la0BhbWQuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgU2VwdGVt
YmVyIDE0LCAyMDIzIDc6MzQgUE0NCj4gVG86IEFiYmFyYXB1LCBWZW5rYXRlc2ggPHZlbmthdGVz
aC5hYmJhcmFwdUBhbWQuY29tPjsgdS0NCj4gYm9vdEBsaXN0cy5kZW54LmRlDQo+IENjOiBqYWdh
bkBhbWFydWxhc29sdXRpb25zLmNvbTsgZ2l0QHhpbGlueC5jb207IEFzaG9rIFJlZGR5IFNvbWEN
Cj4gPGFzaG9rLnJlZGR5LnNvbWFAYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gc3Bp
OiB6eW5xbXBfcXNwaTogV29ya2Fyb3VuZCBmb3Igc21hbGwgZGF0YSBjYWNoZQ0KPiBpc3N1ZQ0K
PiANCj4gDQo+IA0KPiBPbiA5LzE0LzIzIDEyOjQ4LCBWZW5rYXRlc2ggWWFkYXYgQWJiYXJhcHUg
d3JvdGU6DQo+ID4gQ2FjaGUgcmVsYXRlZCBpc3N1ZXMgYXJlIHNlZW4gd2l0aCBzbWFsbCBzaXpl
ZCBkYXRhIHJlYWRzLg0KPiA+IER1ZSB0byB0aGlzLCBwcm9wZXIgZGF0YSBpcyBub3QgcmVhZC4g
QWxzbyBzb21lIHRpbWVzIHNmIHByb2JlIGZhaWxzDQo+ID4gcmFuZG9tbHkuIFRvIHdvcmthcm91
bmQgdGhpcyBpc3N1ZSwgaW52YWxpZGF0ZSBkY2FjaGUgYWZ0ZXIgcmVhZCBETUENCj4gPiBpcyB0
cmlnZ2VyZWQuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBBc2hvayBSZWRkeSBTb21hIDxhc2hv
ay5yZWRkeS5zb21hQGFtZC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogVmVua2F0ZXNoIFlhZGF2
IEFiYmFyYXB1DQo+IDx2ZW5rYXRlc2guYWJiYXJhcHVAYW1kLmNvbT4NCj4gPiAtLS0NCj4gPiAg
IGRyaXZlcnMvc3BpL3p5bnFtcF9ncXNwaS5jIHwgMiArKw0KPiA+ICAgMSBmaWxlIGNoYW5nZWQs
IDIgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc3BpL3p5bnFt
cF9ncXNwaS5jIGIvZHJpdmVycy9zcGkvenlucW1wX2dxc3BpLmMNCj4gPiBpbmRleCBhNTA2ZDE1
MjI3Li5lYzU5ZWY1ODA0IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvc3BpL3p5bnFtcF9ncXNw
aS5jDQo+ID4gKysrIGIvZHJpdmVycy9zcGkvenlucW1wX2dxc3BpLmMNCj4gPiBAQCAtNzA3LDYg
KzcwNyw4IEBAIHN0YXRpYyBpbnQgenlucW1wX3FzcGlfc3RhcnRfZG1hKHN0cnVjdA0KPiB6eW5x
bXBfcXNwaV9wcml2ICpwcml2LA0KPiA+ICAgCQkJcmV0dXJuIC1FVElNRURPVVQ7DQo+ID4gICAJ
CX0NCj4gPg0KPiA+ICsJCWludmFsaWRhdGVfZGNhY2hlX3JhbmdlKGFkZHIsIGFkZHIgKyBzaXpl
KTsNCj4gPiArDQo+ID4gICAJCXdyaXRlbChHUVNQSV9ETUFfRFNUX0lfU1RTX0RPTkUsICZkbWFf
cmVncy0+ZG1haXNyKTsNCj4gPg0KPiA+ICAgCQlkZWJ1ZygiYnVmOjB4JWx4LCByeGJ1ZjoweCVs
eCwgKmJ1ZjoweCV4IGxlbjogMHgleFxuIiwNCj4gDQo+IEkgZ290IHR3byBwYXRjaGVzLiBXaGlj
aCBvbmUgaXMgY29ycmVjdD8NCj4gQ2FuIHlvdSBwbGVhc2Ugc2VuZCB2Mj8NCg0KVGhlcmUgYXJl
IHR3byBwYXRjaGVzLiBXaWxsIHNlbmQgdjIgYXMgc2VyaWVzLg0KDQpUaGFua3MNClZlbmthdGVz
aA0KPiANCj4gTQ0K
