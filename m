Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 933DBE7716C
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 13:08:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5916D894E8;
	Thu,  5 Dec 2024 14:07:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58283893F6; Thu,  5 Dec 2024 07:08:30 +0100 (CET)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on2072c.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::72c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 165FB89335
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 07:08:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H1oohLRpw1H/lfXoh06mGItNynlKpjQy2X4zMWGgXqPvRMKhxfGpFPU0yCmPwDnZjoAFWBD90Vkpr8ttq0IKgNSfW3WCWGh0gV2xwx2qV8nTZcb4IqE9rnw9nie6lNv9c6PbHLCotRrkn4WFOQDVPJxpkbr92D4PfaSEE5vJ8noY1AyOKFY6PF78lhId6pGsqGPw/KhplK6u8+DHHgp1PzDYv0RILaim/OGymduFHo/8PxeRfgp84q+K8pOZpIiux42NpLTotEK6YreBtpv8JPYskbBDsfmMqgXGmeWG04664qcfloyWORJ2/SrpGPz/TQb3pJ/70zHPCOci/VtS2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cZst9Yc3bSteWev+PbNvy1/egK3VrWAI6r+u86C2cIE=;
 b=msb87lZp4ozQj/u13beGhgfS+JiEM0EEvKjpmFrQ7lfd2dXjjXkt779FVCzXRQ6CG7ry8W/yKMxI0SIFNLX/dZh1yYaqzwV3zbobjrIva9XUdVR//jL2HHU7IVHkblC8qN0o/t/qpugUQKoN9z1YqUsE52kzHZOXEnTt1TjDOjqt3kbcVZngp6yNnM9HIbQ+USRuhrSfUYNCM1m3Gk0y0jwljL+hrbgPy5DIxBRdOOnhnQBVYsckNxo7co99qTVB+OZxaDucKfqG5H7DL0Vt00habh7k1MbItrTVQ5QC/vznEi0ldWS2Txe/F3f+cmmkbFkx4uziBVLzIQ/UEcrs+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1323.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.6; Thu, 5 Dec
 2024 06:08:45 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%7]) with mapi id 15.20.8230.000; Thu, 5 Dec 2024
 06:08:44 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: E Shattow <lucent@gmail.com>
CC: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>, Sumit Garg
 <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>, Conor Dooley
 <conor.dooley@microchip.com>, Nam Cao <namcao@linutronix.de>, Bo Gan
 <ganboing@gmail.com>, Emil Renner Berthing
 <emil.renner.berthing@canonical.com>, Minda Chen
 <minda.chen@starfivetech.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: [PATCH v7 05/12] riscv: dts: jh7110: Move common code to the new
 jh7110-common-u-boot.dtsi
Thread-Topic: [PATCH v7 05/12] riscv: dts: jh7110: Move common code to the new
 jh7110-common-u-boot.dtsi
Thread-Index: AQHbRTBVBp8x/g2v+0a9gvciG4M9SLLU5SyAgACFsiCAAID6gIABFm1A
Date: Thu, 5 Dec 2024 06:08:44 +0000
Message-ID: <ZQ2PR01MB13077B9BD02DBF2BFA8014CCE630A@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
References: <20241203030430.26089-1-hal.feng@starfivetech.com>
 <20241203030430.26089-6-hal.feng@starfivetech.com>
 <CANV2PTOxKz33x4vNioD0rqkTCGTKhdbNHo6eJFrCxn5yq6SX0Q@mail.gmail.com>
 <ZQ2PR01MB13072E932737DD9D65E3A250E637A@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
 <CANV2PTOCZ9OmAf4LJeGTazJjP6weghhhkmGtJAyFOSukAGdPPA@mail.gmail.com>
In-Reply-To: <CANV2PTOCZ9OmAf4LJeGTazJjP6weghhhkmGtJAyFOSukAGdPPA@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1323:EE_
x-ms-office365-filtering-correlation-id: d24cafe6-3aff-40be-0421-08dd14f34682
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|41320700013|366016|7416014|38070700018; 
x-microsoft-antispam-message-info: 8Mn2TJwYXRk2sbftyMTTHro1XslKhl1t91DuKDJ408BfrHZdeywwpWx1oy3rlU6kRqJvCUtl+foCAjQKiYSh2zbF1kfK4c16FyOBmNBbzV1Cs7SpBLQHDO1oEZkeUBf0cP6C1+aHimgPGJ9i6PAJIq4gNZfZTpq/5DMBbKkQXKxg5oL/wCTXoVnTC77ggfE1qjhbIIFt3OT+u8DCv0MReeeFhWhXAbvCSN4O/w/+BGB+Hplcl3wt+XKRD3rKzB46AWQa/VC6iRXuC+7tmWhwEKDAzBMLILT/9L8nmRK8ertuU5P8dfANGUgfTQvqgECmLUQ2aSpTVccxzmMaQ5nGAeVsOBPciRFLi11/Dpueff7mWlA0ADJ5zdGYqsAa+5D38vXCpDslZct0s36DpTdjGI5pY0myuPCXjOqm3OcQga//VOEwPtPFgIhAi1uSCfFOdfAep0OzqERq2AwKH5iMd3PSq+XwQotUowmnJVNhI73nYXgsKssylk1rHHWc8PoF8QW9Cvz3mR18M92m0HkjisaVgnnQnv2hGjuvfb7zakdv06GoA0GmmFGLmKqLt3WToCRauNBLrGjUsmE3SbRmDeqXckEzfwFYRlArS/P5vPMIA/bJdAeKoEMwQWIJ+uaA
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(41320700013)(366016)(7416014)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RnVTdStRZmZGdnJzaEJmaUFzUHJUdy9uTnZSRWdWODNFaUdSaFVlWGxvUGlX?=
 =?utf-8?B?YU5YM01HQUxlZlFZaWdsZE1EWUYwbHc1d3ovak5NVlRZK3hJSVhMZVBmTkJM?=
 =?utf-8?B?UTZwQVNBTTFCaTBUS3Rva0Zldmt2ZFJSOVRsL3lzT3l3ank4c2lDbFArbFV1?=
 =?utf-8?B?akR2NGh6U3lxMlBIdHFzcDZBazFQcmp4b2RQY1orVjZOTlRSaTIrdEltL0N2?=
 =?utf-8?B?WG9VK1VSL001QmQvSm5uaWxZUWpzSVViUEd0WkwyVHR3dVVYMURRR2V6YVZ0?=
 =?utf-8?B?STNyN3N1ampOcHlrZzdqeEtITmlnenNEL0pnaFh1MjhUdmRyb1RWZ2Y4UGFB?=
 =?utf-8?B?Rm5hUWlDakRaV3RHT05yNGdvQm1xc0dxV1MzeUlyNlEyNnBvS200TTVnTk8r?=
 =?utf-8?B?THNKRndlV0g2ZkRRd21aUG9RSU56bDFIdjNtemNQMzVrbXN0d2RSV2J0cFJm?=
 =?utf-8?B?Ny85YWcyejQxK1R4OVpONGp0Qzc1dWRMZmVHTVZpc1ZEZWt1SFhBd0tZM1NE?=
 =?utf-8?B?ZFViZDY0bFc1SjJreXg4M0l4RVBTTFdZRTZua0xPRlB0UlZTN3V3a2gzdzMy?=
 =?utf-8?B?OWFPZmNDU1VYUEJob25CRGpVWmVoaHVnWktEQWZBdThhY1NvUnQ2VE5zZGpB?=
 =?utf-8?B?WnZqQUI0dFJiVFZ6Yjc2YWdnOE5TY3RVbXhNMkl1Q29rd2h0Vm5id0MwUnR6?=
 =?utf-8?B?SXhoVGJWdzhBVXhST2ZsRldKQmRHUngxamg4VGoySmRzNEd6ZHlsUnNDcmhp?=
 =?utf-8?B?WmRNWmZGS1F4NFlvR0JqZDVXVnJsdnVuSktFOENLb3k2RWlkNFpONE03R3Bn?=
 =?utf-8?B?WTN0Wnl0VmRpc2ZpTTBGMWlhSWVjenBCTHU0MDVuenQ5c2YyUUVCRXFOaE9P?=
 =?utf-8?B?Z0huZFNGS2dzOWhtS3F4eTZjajFpeTFGY0o3eWFobFd4YXkvY3RPejFuL3dz?=
 =?utf-8?B?dDU3M3M2SllTQ25nNkoxeTI4WnRHWUJNQVQ5dVljSys1KzVXVDRYMlFpdyt6?=
 =?utf-8?B?THZ3cm0wVElHOVA1RWtxN1cxMUcrUUtrSnU3amNXaWVtYUpLZWhzSVZ3b2ZV?=
 =?utf-8?B?TjBha1FtVCt2QmZreHZPTWpGRVA5RzdZbmtFYnpNcFFFQnN0dUJpbWpUeXZE?=
 =?utf-8?B?UmorYmNxNjlsY2dqRnhKSy9qMFFPRzZRMEFpUEt6UTlVbDBiL1hnOEMzVUlW?=
 =?utf-8?B?TllZRi9TNjZGVmk5cjNGbWRhYlFlTzhHY2YvNklGcmJNUUdlbWdySHJqOFNC?=
 =?utf-8?B?T01lblRmYVAzOEdCbHJkdHlzTzZDcGZ5d2tQN1ZYVkNDQWJuRFFKd1h4NDAy?=
 =?utf-8?B?M1U5VTZKb3dldEUzSTBBd0hEOFArYXp0Tkl3QTREZUQ0NnR3MFQzb1dUbXZ6?=
 =?utf-8?B?R0pjY3Y1dDhmSVo4NE5saEpjK2tPSHQ3QWtyTlVubXdUVUdHVlJ5T2g2ZW1m?=
 =?utf-8?B?b05pOGk0OEYzeHkvK2xXK2FjTnp4SDVXQ0ZtNEJqK255bzNWNEVZellpajZW?=
 =?utf-8?B?eHdwWmJKMHNzSkpnOC9DM3Zkcy95aVduYXBITmRma0hZNXlESFQvUGw0anJH?=
 =?utf-8?B?aWx3elpod0p0cnR5RWV6UWUrM0YwTm1HelkxOW1Ddms4ZWNrSHNIbm00RXQ0?=
 =?utf-8?B?Y3pOcE5ENG1XdzhXRU44c29Ic2NIL2R5K1dCa29iRDU3bllWaXFLZDh3S3M3?=
 =?utf-8?B?czcrWnhWWE9EVC8ybElLMmgyUnVDYmdVZUpKM0JobFRaM3JmM0RrcTMxY2hz?=
 =?utf-8?B?elFPQlVNdlBITlZDbzlldUFmMUliUHl4YTJXRW5WMjVNNWkxaWwvVytVcWxX?=
 =?utf-8?B?U3pQQTd3RG9wQXoxNUQvQnZXU2gyNEJvajVPUnlCenJ6akd4QnJDNGFmckRw?=
 =?utf-8?B?TnczMFJKVnlGZUhobGVsdk9TaE96dXlTS0RUbjlOU0FUUUlxZUlJbDFRYXY4?=
 =?utf-8?B?eWllM0lkSFVvdzU0YkRDTS9VS2xJZGN6UVhiQ1J5amJvVlRndUdkdXQ1RXRF?=
 =?utf-8?B?b1FVWi92NGE3TXI3QlVpTDZHR05lRHhwZnZiQmJaREViSkNxUFJMZGVjYk5S?=
 =?utf-8?B?dDBLejdDTFJlTnhmQlBNSUZMa1FqVmhZTVZFNXdtZ3lRWWIraExhNEZveW5y?=
 =?utf-8?Q?6XWaU82WhsCH24DEwzH5VNyw2?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: d24cafe6-3aff-40be-0421-08dd14f34682
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2024 06:08:44.8875 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G00EuajDJifGJrVxoLo+vVWPC6j9XdEIV5K002CLJWSXGico8I5FuYEAl5+hwy88yYAmtbXw5ru3PtdiaHJV7KI2318+CigfPQj9O22KgFE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1323
X-Mailman-Approved-At: Thu, 05 Dec 2024 14:07:50 +0100
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

PiBPbiAwNC4xMi4yNCAxODo1NiwgRSBTaGF0dG93IHdyb3RlOg0KPiBPbiBUdWUsIERlYyAzLCAy
MDI0IGF0IDEwOjUy4oCvUE0gSGFsIEZlbmcgPGhhbC5mZW5nQHN0YXJmaXZldGVjaC5jb20+DQo+
IHdyb3RlOg0KPiA+DQo+ID4gPiBPbiAwNC4xMi4yNCAwMzoxNiwgRSBTaGF0dG93IHdyb3RlOg0K
PiA+ID4gT24gTW9uLCBEZWMgMiwgMjAyNCBhdCA3OjA24oCvUE0gSGFsIEZlbmcgPGhhbC5mZW5n
QHN0YXJmaXZldGVjaC5jb20+DQo+ID4gPiB3cm90ZToNCj4gPiA+ID4NCj4gPiA+ID4gVG8gc3Vw
cG9ydCBKSDcxMTAgYmFzZWQgYm9hcmRzIGJlc2lkZXMgdjEuM0IsIGFkZCBhIGNvbW1vbiBkdHNp
DQo+ID4gPiA+IGFuZCBhZGQgY29tbW9uIGNvZGUgdG8gaXQuDQo+ID4gPiA+DQo+ID4gPiA+IFRl
c3RlZC1ieTogQW5hbmQgTW9vbiA8bGludXguYW1vb25AZ21haWwuY29tPg0KPiA+ID4gPiBUZXN0
ZWQtYnk6IEUgU2hhdHRvdyA8bHVjZW50QGdtYWlsLmNvbT4NCj4gPiA+ID4gUmV2aWV3ZWQtYnk6
IEUgU2hhdHRvdyA8bHVjZW50QGdtYWlsLmNvbT4NCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogSGFs
IEZlbmcgPGhhbC5mZW5nQHN0YXJmaXZldGVjaC5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiAg
YXJjaC9yaXNjdi9kdHMvamg3MTEwLWNvbW1vbi11LWJvb3QuZHRzaSAgICAgIHwgMTQyDQo+ID4g
PiArKysrKysrKysrKysrKysrKysNCj4gPiA+ID4gIC4uLjEwLXN0YXJmaXZlLXZpc2lvbmZpdmUt
Mi12MS4zYi11LWJvb3QuZHRzaSB8IDEzOA0KPiA+ID4gPiArLS0tLS0tLS0tLS0tLS0tLQ0KPiA+
ID4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAxNDMgaW5zZXJ0aW9ucygrKSwgMTM3IGRlbGV0aW9ucygt
KSAgY3JlYXRlIG1vZGUNCj4gPiA+ID4gMTAwNjQ0IGFyY2gvcmlzY3YvZHRzL2poNzExMC1jb21t
b24tdS1ib290LmR0c2kNCj4gPiA+ID4NCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3Yv
ZHRzL2poNzExMC1jb21tb24tdS1ib290LmR0c2kNCj4gPiA+ID4gYi9hcmNoL3Jpc2N2L2R0cy9q
aDcxMTAtY29tbW9uLXUtYm9vdC5kdHNpDQo+ID4gPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+
ID4gPiA+IGluZGV4IDAwMDAwMDAwMDAuLjc5NTM0NTllNjcNCj4gPiA+ID4gLS0tIC9kZXYvbnVs
bA0KPiA+ID4gPiArKysgYi9hcmNoL3Jpc2N2L2R0cy9qaDcxMTAtY29tbW9uLXUtYm9vdC5kdHNp
DQo+ID4gPiA+IEBAIC0wLDAgKzEsMTQyIEBADQo+ID4gPiA+ICsvLyBTUERYLUxpY2Vuc2UtSWRl
bnRpZmllcjogR1BMLTIuMCBPUiBNSVQNCj4gPiA+ID4gKy8qDQo+ID4gPiA+ICsgKiBDb3B5cmln
aHQgKEMpIDIwMjMgU3RhckZpdmUgVGVjaG5vbG9neSBDby4sIEx0ZC4NCj4gPiA+ID4gKyAqLw0K
PiA+ID4gPiArDQo+ID4gPiA+ICsjaW5jbHVkZSAiYmlubWFuLmR0c2kiDQo+ID4gPiA+ICsjaW5j
bHVkZSAiamg3MTEwLXUtYm9vdC5kdHNpIg0KPiA+ID4gPiArLyB7DQo+ID4gPiA+ICsgICAgICAg
YWxpYXNlcyB7DQo+ID4gPiA+ICsgICAgICAgICAgICAgICBzcGkwID0gJnFzcGk7DQo+ID4gPiA+
ICsgICAgICAgfTsNCj4gPiA+ID4gKw0KPiA+ID4gPiArICAgICAgIGNob3NlbiB7DQo+ID4gPiA+
ICsgICAgICAgICAgICAgICBib290cGgtcHJlLXJhbTsNCj4gPiA+ID4gKyAgICAgICB9Ow0KPiA+
ID4gPiArDQo+ID4gPiA+ICsgICAgICAgZmlybXdhcmUgew0KPiA+ID4gPiArICAgICAgICAgICAg
ICAgc3BpMCA9ICZxc3BpOw0KPiA+ID4gPiArICAgICAgICAgICAgICAgYm9vdHBoLXByZS1yYW07
DQo+ID4gPiA+ICsgICAgICAgfTsNCj4gPiA+ID4gKw0KPiA+ID4gPiArICAgICAgIGNvbmZpZyB7
DQo+ID4gPiA+ICsgICAgICAgICAgICAgICBib290cGgtcHJlLXJhbTsNCj4gPiA+ID4gKyAgICAg
ICAgICAgICAgIHUtYm9vdCxzcGwtcGF5bG9hZC1vZmZzZXQgPSA8MHgxMDAwMDA+Ow0KPiA+ID4g
PiArICAgICAgIH07DQo+ID4gPiA+ICsNCj4gPiA+ID4gKyAgICAgICBtZW1vcnlANDAwMDAwMDAg
ew0KPiA+ID4gPiArICAgICAgICAgICAgICAgYm9vdHBoLXByZS1yYW07DQo+ID4gPiA+ICsgICAg
ICAgfTsNCj4gPiA+ID4gK307DQo+ID4gPiA+ICsNCj4gPiA+ID4gKyZ1YXJ0MCB7DQo+ID4gPiA+
ICsgICAgICAgYm9vdHBoLXByZS1yYW07DQo+ID4gPiA+ICsgICAgICAgcmVnLW9mZnNldCA9IDww
PjsNCj4gPiA+ID4gKyAgICAgICBjdXJyZW50LXNwZWVkID0gPDExNTIwMD47DQo+ID4gPiA+ICsg
ICAgICAgY2xvY2stZnJlcXVlbmN5ID0gPDI0MDAwMDAwPjsgfTsNCj4gPiA+ID4gKw0KPiA+ID4g
PiArJm1tYzAgew0KPiA+ID4gPiArICAgICAgIGJvb3RwaC1wcmUtcmFtOw0KPiA+ID4gPiArfTsN
Cj4gPiA+ID4gKw0KPiA+ID4gPiArJm1tYzEgew0KPiA+ID4gPiArICAgICAgIGJvb3RwaC1wcmUt
cmFtOw0KPiA+ID4gPiArfTsNCj4gPiA+ID4gKw0KPiA+ID4gPiArJnFzcGkgew0KPiA+ID4gPiAr
ICAgICAgIGJvb3RwaC1wcmUtcmFtOw0KPiA+ID4NCj4gPiA+ID4gKyAgICAgICBzcGktbWF4LWZy
ZXF1ZW5jeSA9IDwyNTAwMDAwMDA+Ow0KPiA+ID4NCj4gPiA+IERyb3AgdGhpcyBsaW5lIHNwaS1t
YXgtZnJlcXVlbmN5IDI1ME1oei4gVGhlIGRyaXZlciBleHBlY3RzIHNwaS1tYXgtDQo+ID4gPiBm
cmVxdWVuY3kgaW4gYW55IHN1Yi1ub2RlLCBhbmQgbm90IGhlcmU/DQo+ID4NCj4gPiBZZXMsIHRo
aXMgcHJvcGVydHkgaXMgdXNlZCBpbiBzdWItbm9kZSwgd2UgY2FuIGRyb3AgdGhpcyBsYXRlci4N
Cj4gPg0KPiA+ID4NCj4gPiA+ID4gKw0KPiA+ID4gPiArICAgICAgIGZsYXNoQDAgew0KPiA+ID4g
PiArICAgICAgICAgICAgICAgYm9vdHBoLXByZS1yYW07DQo+ID4gPg0KPiA+ID4gPiArICAgICAg
ICAgICAgICAgL2RlbGV0ZS1wcm9wZXJ0eS8gY2RucyxyZWFkLWRlbGF5Ow0KPiA+ID4NCj4gPiA+
IERyb3AgdGhpcyBsaW5lIC9kZWxldGUtcHJvcGVydHkvIGJlY2F1c2UgaXQgaXMgYSBwcm9ibGVt
IGZvciB0aGUNCj4gPiA+IHBhcnNlciBpZiB3ZSBuZWVkIHRvIHJlLWRlZmluZSAnY2RucyxyZWFk
LWRlbGF5JyBsYXRlciBpbiBkdHMgZmlsZXMNCj4gPiA+IGRvd25zdHJlYW0gb2Ygamg3MTEwLSBj
b21tb24tdS1ib290LmR0c2kNCj4gPiA+DQo+ID4gPiBJZiB5b3Ugd2FudCBkcml2ZXJzL3NwaS9j
YWRlbmNlX3FzcGkuYzpzcGlfY2FsaWJyYXRpb24oKSB0byBkbyB0aGlzDQo+ID4gPiB3b3JrIHRo
ZW4gaXQgbmVlZHMgdG8gYmUgdGhlIHNhbWUgdXBzdHJlYW0uIEluIG15IHRlc3Rpbmcgb24gNEdC
DQo+ID4gPiBTdGFyNjQgdGhlIGNhbGlicmF0aW9uICh2aWEgL2RlbGV0ZS1wcm9wZXJ0eS8gY2Ru
cyxyZWFkLWRlbGF5KQ0KPiA+ID4gbWV0aG9kIHdpdGggc3BpLW1heC1mcmVxdWVuY3kgbGVzcyB0
aGFuIGV4YWN0bHkgNDkuOE1IeiByZXN1bHRzIGluIGENCj4gPiA+IGZhaWx1cmUgdG8gd3JpdGUg
U1BJLSBOT1IgY29ycmVjdGx5LiBXaGVuIHNwaS1tYXgtZnJlcXVlbmN5IGlzDQo+ID4gPiBhcHBy
b3hpbWF0ZWx5IDI1TUh6IHVwIHRvIDQ5Ljc5OTk5OU1IeiBhbmQgd3JpdHRlbiB3aXRoIGEga25v
d24NCj4gZ29vZA0KPiA+ID4gdG9vbCB0aGVuIHRoZSBib290IG1heSBiZSBzdWNjZXNzZnVsIGJ1
dCAiTWFpbiBzZWN0aW9uIGJvb3QgZmFpbCx1c2UNCj4gYmFja3VwIHNlY3Rpb24iDQo+ID4gPiBv
ciBvdGhlciBlcnJvcnMgb24gYm9vdCBhZnRlciB1c2luZyB0aGF0IHVuc3RhYmxlIGNvbmZpZ3Vy
YXRpb24gb2YNCj4gPiA+IFUtQm9vdCB0byB3cml0ZSBVLUJvb3QgaW1hZ2UgdG8gdGhlIFNQSS1O
T1IuIE5vIHByb2JsZW1zIHdyaXRpbmcgYW5kDQo+ID4gPiBib290IGR1cmluZyB0ZXN0aW5nIHdp
dGggc3BpLW1heC1mcmVxdWVuY3kgNDkuOE1IeiB1cCB0byAxMDBNSHogKG5vdA0KPiA+ID4gdGVz
dGVkIGFib3ZlIDEwME1IeikuDQo+ID4gPg0KPiA+ID4gVGhlIHVwc3RyZWFtIGR0cyBoYXMgc3Bp
LW1heC1mcmVxdWVuY3kgMTJNSHogd2hpY2ggaXMgbm90IHN1Y2Nlc3NmdWwNCj4gPiA+IHdpdGgg
YW55IG9mIHRoZSByZWFkLWRlbGF5IHZhbHVlcyBJIHRlc3RlZDogMCAxIDIgMyA0IDUNCj4gPiA+
DQo+ID4gPiA+ICsgICAgICAgICAgICAgICBzcGktbWF4LWZyZXF1ZW5jeSA9IDwxMDAwMDAwMDA+
Ow0KPiA+ID4NCj4gPiA+IFdoeSAxMk1IeiB1cHN0cmVhbSBhbmQgMTAwTUh6IGhlcmU/IFNvbWV0
aGluZyBpcyB3cm9uZyBidXQgSSBkbyBub3QNCj4gPiA+IGtub3cgaXMgaXQgVS1Cb290IG9yIExp
bnV4Pw0KPiA+ID4NCj4gPiA+IFN1Y2Nlc3M6DQo+ID4gPiArICAgICAgICAgICAgIC9kZWxldGUt
cHJvcGVydHkvIGNkbnMscmVhZC1kZWxheTsNCj4gPiA+ICsgICAgICAgICAgICAgc3BpLW1heC1m
cmVxdWVuY3kgPSA8MTAwMDAwMDAwPjsNCj4gPiA+DQo+ID4gPiBTdWNjZXNzOg0KPiA+ID4gKyAg
ICAgICAgICAgICBjZG5zLHJlYWQtZGVsYXkgPSA8Mj47DQo+ID4gPiAtICAgICAgICAgICAgIC9k
ZWxldGUtcHJvcGVydHkvIGNkbnMscmVhZC1kZWxheTsNCj4gPiA+ICsgICAgICAgICAgICAgc3Bp
LW1heC1mcmVxdWVuY3kgPSA8MTAwMDAwMDAwPjsNCj4gPiA+DQo+ID4gPiBGYWlsdXJlOg0KPiA+
ID4gKyAgICAgICAgICAgICBjZG5zLHJlYWQtZGVsYXkgPSA8Mj47DQo+ID4gPiArICAgICAgICAg
ICAgIHNwaS1tYXgtZnJlcXVlbmN5ID0gPDUwMDAwMDAwPjsNCj4gPiA+DQo+ID4gPiBUaGUgYWN0
dWFsIGZpeCBpcyBnb2luZyB0byBuZWVkIHRlc3RpbmcgTGludXggYW5kIFUtQm9vdCBvbiBhbGwg
dGhlDQo+ID4gPiBib2FyZHMgSSBkbyBub3QgaGF2ZSBhY2Nlc3MgdG8uDQo+ID4gPg0KPiA+ID4g
Rm9yIHRoZSBtb21lbnQgd2UgY2FuOg0KPiA+ID4gLSAgICAgICAgICAgICAvZGVsZXRlLXByb3Bl
cnR5LyBjZG5zLHJlYWQtZGVsYXk7DQo+ID4gPiArICAgICAgICAgICAgIGNkbnMscmVhZC1kZWxh
eSA9IDwyPjsNCj4gPiA+ICsgICAgICAgICAgICAgc3BpLW1heC1mcmVxdWVuY3kgPSA8MTAwMDAw
MDAwPjsNCj4gPiA+DQo+ID4gPiBvciBkbyBub3RoaW5nIChidXQgeWVzIHBsZWFzZSBkcm9wIHRo
YXQgMjUwTWh6IGxpbmUgaXQgaXMgbm9uLW9wIEkgdGhpbmspLg0KPiA+ID4NCj4gPiA+IFdoYXQg
ZG8geW91IHRoaW5rPyAgT3IgZWxzZSB3ZSBkaXNjdXNzIGhlcmUgYW5kIGZvbGxvdyB3aXRoIHBh
dGNoZXMNCj4gPiA+IGluIGZ1dHVyZSB0byBmaXggdGhlIG1lc3MuIEkgcmVhbGx5IGRvIG5vdCB3
YW50IGFueQ0KPiA+ID4gL2RlbGV0ZS1wcm9wZXJ0eS8gdG8gYmUgaW4gZHRzaSBidXQgSSBkb24n
dCBrbm93IHdoeSBpdCBpcyBzbw0KPiA+ID4gZGlmZmVyZW50IGJldHdlZW4gVS1Cb290IGFuZCBM
aW51eCBhbmQgY2Fubm90IHBlcnNvbmFsbHkgdGVzdCBhbGwgdGhlDQo+IHBvc3NpYmxlIGJvYXJk
cyB0byB2ZXJpZnkgYSBjaGFuZ2UuDQo+ID4NCj4gPiBJIGRvbid0IGtub3cgdGhlIGNhdXNlIG9m
IHRoaXMgcHJvYmxlbSBlaXRoZXIuIEJ1dCBhbGwgcHJvcGVydGllcw0KPiA+IGFkZGVkIGluIHRo
aXMgcGF0Y2ggYWxyZWFkeSBleGlzdGVkIGluIFUtQm9vdCBEVCBiZWZvcmUuIEkgdHJpZWQgbXkN
Cj4gPiBiZXN0IHRvIGtlZXAgdGhlIFUtQm9vdCBEVCB0aGUgc2FtZSBhcyB0aGUgb25lIGJlZm9y
ZSBPRl9VUFNUUkVBTQ0KPiBhcHBsaWVkLg0KPiA+DQo+ID4gSSB0ZXN0ZWQgYW5kIGZvdW5kIHRo
YXQgdGhlIHFzcGkgZmxhc2ggY2FuIHdvcmsgc3VjY2Vzc2Z1bGx5IGluIExpbnV4DQo+ID4gYW5k
IFUtQm9vdCB3aXRoIHRoZSBzZXR0aW5ncyB5b3Ugc3VnZ2VzdGVkIGFib3ZlLg0KPiA+DQo+ID4g
Y2RucyxyZWFkLWRlbGF5ID0gPDI+Ow0KPiA+IHNwaS1tYXgtZnJlcXVlbmN5ID0gPDEwMDAwMDAw
MD47DQo+IA0KPiBHb29kIHJlcG9ydCBvbiB0ZXN0aW5nIExpbnV4IGFuZCBVLUJvb3QsIHRoYW5r
IHlvdSBIYWwuDQo+IA0KPiA+DQo+ID4gSWYgL2RlbGV0ZS1wcm9wZXJ0eS8gaXMgcmVhbGx5IG5v
dCBzdWl0YWJsZSB0byBleGlzdCBpbiB0aGlzIGR0c2ksIHdlDQo+ID4gY2FuIG1vZGlmeSBhcyBh
Ym92ZSBpbiBVLUJvb3QgYW5kIHVwc3RyZWFtIHRoaXMgY2hhbmdlIHRvIExpdW54LiBBZnRlcg0K
PiA+IHRoaXMgY2hhbmdlIGlzIGFjY2VwdGVkIGJ5IExpbnV4LCBJIHdpbGwgZHJvcCB0aGVzZSB0
d28gcHJvcGVydGllcyBpbiBVLUJvb3QuDQo+ID4NCj4gPiBCZXN0IHJlZ2FyZHMsDQo+ID4gSGFs
DQo+IA0KPiBZZXMgbGV0J3MgZG8gdGhhdC4gU28gbG9uZyBhcyBpdCBhbGwgd29ya3Mgb24gVkYy
IDEuMmEsIFZGIDEuM2IsIE1hcnMsIGFuZA0KPiBTdGFyNjQuIEkgaGF2ZSB0ZXN0ZWQgU3RhcjY0
LiBZb3UgaGF2ZSB0ZXN0ZWQgSSBndWVzcyBWRjIgMS4zYj8NCj4gQW5kIGlmIHdlIG1pc3Mgc29t
ZSwgaXQncyBva2F5IGV2ZW4gaWYgdGhlcmUgaXMgYSBwcm9ibGVtIGZvciBzb21lIGJvYXJkIHdl
DQo+IGRpZCBub3QgdGVzdCwgdGhlIHdvcmthcm91bmQgaXMgZWFzeSBpbiB1LWJvb3Qgc3BlY2lm
aWMgZHRzaSBwZXItYm9hcmQgYmVjYXVzZQ0KPiB3ZSBoYXZlIGF2b2lkZWQgJy9kZWxldGUtcHJv
cGVydHkvJyBpbiB0aGUgY29tbW9uIGR0c2kuDQoNCk9LLiBZZWFoLCBJIHRlc3RlZCBvbiBWRjIg
MS4zYiBhbmQgVkYyIDEuMmEgaXMgdmVyeSBzaW1pbGFyIHRvIFZGMiAxLjNiLg0KDQpCZXN0IHJl
Z2FyZHMsDQpIYWwNCg==
