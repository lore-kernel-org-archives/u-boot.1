Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C91F1CA0EFC
	for <u-boot@archiver.kernel.org>; Fri, 22 Aug 2025 12:52:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 075C2829E7;
	Fri, 22 Aug 2025 14:52:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id DED1D81D5D; Fri, 22 Aug 2025 11:48:48 +0200 (CEST)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on2070a.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::70a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C3E68006D
 for <u-boot@lists.denx.de>; Fri, 22 Aug 2025 11:48:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EqPLT4I3jVXIME0qPH03kxl4nfAs/dOFaY2ulAobdyLsI4tBF7wNMViXePtdTtQocy5uxb7KLf0e9AYfL9O5nhkUV5EnIvGGQQ5ZQ03ifCE3irndQoecbMKPRX7vJiJ5At8jGwQEwxcR8V6nwGe3cfcwXiiXDnIsU2kdk9UBlp7RIlzmymfxXSHMRtcheQXroFSJQlqs5Z3B8dz2fMQxHHKWU4gsphhNtDZ4PbFseo5/kcmdV85Dll7B708Bp+ICMP27aG/8CmxCV0QUdiS8/0qIE0JXlOiQxzDTUTjdP5OsiAF4lsQukhJKrQlFjnMvnZAUlsiMDe1kxPxxNf+Onw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o0NsxYZ7o71sdd8cGmngMY87k2nrqmdC9Yh7ehS0wjc=;
 b=M9FrialSF5EIGw5cejjrSmQwVHN491j/2eLyeg/Dsk+NY2PNq7c/6nh8O2xRRd+/iJACsqHmC80ARxwVLl5vnPBP9cUI0peNunAeCaL5fS9hFkSVcc4totreNhq95MemKb+Tk/fggplt3fYAXDQuJYsRrUb12x0o7brftbd6WLpN20U8uPCpPychhV3t8FuTbN2QZHB8WnLUPss+Xqymkls0LeaeDmBF1WeSecnjE7b6QmRpsWWbUa9PX/mJoZW3hH7wYwAer0IVTRpKrQGQPp+gkQGvgvFuYC1FEL7CXhGf4A37Kg5o3H8oHEgDjRGFcZ7mXoX0YnMVOb1kihVdRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1290.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:11::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.29; Fri, 22 Aug
 2025 09:48:39 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%6]) with mapi id 15.20.9031.026; Fri, 22 Aug 2025
 09:48:39 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: E Shattow <e@freeshell.de>, Rick Chen <rick@andestech.com>, Leo
 <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: [PATCH v1] riscv: dts: starfive: prune redundant jh7110-common
 overrides
Thread-Topic: [PATCH v1] riscv: dts: starfive: prune redundant jh7110-common
 overrides
Thread-Index: AQHcDaLFVxz64PwVM0K3XGZt6+8+hbRn+flggALjlACAA5ev0A==
Date: Fri, 22 Aug 2025 09:48:39 +0000
Message-ID: <ZQ2PR01MB1307C88B33C6124017A502D0E63D2@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
References: <20250815050315.62956-1-e@freeshell.de>
 <ZQ2PR01MB1307043F4B7527EA41FF1754E6312@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
 <84cd3c89-5f82-468c-a63f-9815909ad110@freeshell.de>
In-Reply-To: <84cd3c89-5f82-468c-a63f-9815909ad110@freeshell.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1290:EE_
x-ms-office365-filtering-correlation-id: 82825566-1a00-4072-228f-08dde16112aa
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
 ARA:13230040|41320700013|366016|1800799024|38070700018; 
x-microsoft-antispam-message-info: q6X6um/0uuwh/iNZYt0SRQNebk4S2RbV97bcQEUG1+TQIlrRucNqaqZCS92CY3paja1walwiujXw2fq+4wbj+3IA5F3obNBMXMX5Fyj+Sdj9riGIu0O5FXyMxXf4FflSmFyYqm0nBb9NREshTvd4U2y08ZN/2OMVIskmF+1YQXR6ofSmzvLp4A3QnxVmgGBtdcQQi6Z0o9FDFNIarQOO3NCzgAoMZLUZZuC/Fo7vFzZmBNcuZeHsWfErnmGM64t0PCN2MAnfKYTzlJR6yVENO4dFLoffmsnDWgAq2TTUP+FIxS5UihfPSkar86289AnhY8FCfzQDzbZVIuPOaQN/Tev5bVbGI7JF4EbchLkpxMrfjgaw7YqjU7HliAJA6tuHLO2CokE2aExBRn5+7mawKzd6cSIGChE0K6+qJ6XmMSYVXLn9pLG7BbNQzhXiSUm6iKRywib2q1AlpxJQFhCXokbzUYJM7aAy6D/HbcqobiACGYsBEEk1x2nNVf3WaaraaIQQ77UVdK1TMPzGTB6tpnt8GY4UsGi7xv4PFdpvZokrG8DGJJ5UAJ2oRnaWvzDfeSl401NGv42hZy6IeOvW56ubkxEUOEuRuybcNC5xE5M=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE; SFS:(13230040)(41320700013)(366016)(1800799024)(38070700018);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RHAwY1hJcENub0ExSGNGMXdSV3d4YllDdWloaDlOVDRxYUtjaWpsVCtTUTZS?=
 =?utf-8?B?N24wMXpvWUlJVkRwdzIyM2RNV0J0ekQxQzlTb0lHTFFmU3IxdTM0N0F5Q3Qx?=
 =?utf-8?B?Tm5Lb0I4b1g3ZmVFUjVEMng4cVY5T0oxNVl3VWFRcTZoMWpaTzR0bDBaaGE4?=
 =?utf-8?B?Z3k1bFdkSU41WkhURnhMQlMvTEMzL2ZETmpuU05pZjB3QVBEQXZRR0FnVXhr?=
 =?utf-8?B?MmU0aW5LbXlYNVQ5cnpVQTlhMy9HQWxFVCtFVUZTaVRlcVkwalBsQzBFcXlK?=
 =?utf-8?B?eEtJVEl0N2FHNWdlWUVyczNYdVlUMnBPUFRsanZROGNhSHd6UVN0N2w3M0xn?=
 =?utf-8?B?NHN1QldZUzl5ckJzVEtwQzZsOU1NZThMaFJtVU5PMjM3RlQwQ2kzK2JKMDJi?=
 =?utf-8?B?RVBTZTBOd0JlTzBmTlhMSHRiaU8wZmx6SzRDWW11b2krY3FDTitmbEVrTnZY?=
 =?utf-8?B?Si9zRzBSNEFKcm90VXZOWWFTNWJOS1oxSi81KzRHenF5cjlKSGM1SFNrM1hP?=
 =?utf-8?B?MStoZXBhdWhoTzY1OFVGSFBXSlFwQy9Qa1RBMVEvYXBYZFg3eEoyb3VBNyt3?=
 =?utf-8?B?dTJUSlVmUHdEa2tHNTd5Y09vdVA5azNKUllIZ0hvd0JRdHZFT0NxWGY2SUdW?=
 =?utf-8?B?S3JhUDJHKzBLbXR6SUdKbGtPNDVnMlhaaWpkMTlKTEFEZ0ZGenZLNitySUEz?=
 =?utf-8?B?OHl6M1RSMU5uaTBNNTI1b3orMmovRHF0VDNvd0YxWUJZTXNUYTRjaWxsak5E?=
 =?utf-8?B?eTJZaVRDMlp1dytzRzE0dUlVT3pjSGduUGlVQ3pYN0VmUFIvWHZYSnVzUHRv?=
 =?utf-8?B?WVFNMG1iSXdETDNlNEtuT1hHb1NHdS94UmJ3a25MMGFNOEVQbjE3R1NLQVln?=
 =?utf-8?B?THpnbjJZeE4wRkE3OUF5Zzl4K3lSS3lzUjl4YWI5T2FLUFRHVzZSdmlJdk1t?=
 =?utf-8?B?bnNRMWViaUdRbmFMa3VELzZyRnE3emlLeWZISHlvU2Nkc1prT1l3dnU4c3BH?=
 =?utf-8?B?WDV6U3dxNEl3RE1lWXRYS2RkcHUwZ2ZmYndTNUNqRDNpQndSNlhSY2xQcHhS?=
 =?utf-8?B?MEw1b0VNQUF5eUJMdldneWVCQXd4R0MzNHRPaCtkVnhtVlo4UW94OHp0MTlh?=
 =?utf-8?B?U1o5ZjArcFVaeHNLd2VGVlcrRXVwOGtpVFhZOFJJMmRVNlZjWW4wZlJUclk2?=
 =?utf-8?B?aFJwWVZ3czVqbjJCWUNYNzVCK1M0QWZLNDBCSzhLSkpmQnM2UWNDdXZkUjYy?=
 =?utf-8?B?K2N4OERlc1N0bHlVTU9ockdpcXExSFp3M3Vsbmt4UllSSE5WcS9hZTluM1VB?=
 =?utf-8?B?b1l5a2M5Tm9hbkV1czZsSjlJZWtWcWY3UkhiazEyVWRpOWZrYWJWaUg4Y01n?=
 =?utf-8?B?ck5VZ3BRaDUzMDhOSWNVYlROMmRSRk9XQ2x5aDdRSXVJbVlxS1FZREhIMUNO?=
 =?utf-8?B?WW9kYWVuWmkxT0JQWndyL2U5WGRCT3pWRVdzZ3BBdHp6ekltc01TS2lSc0lI?=
 =?utf-8?B?YjlXUUJTc1ZKdm1EaDh4eU5kT1NRVEZmdjNiTHAyYTNBM2dZblFLdHNzZkox?=
 =?utf-8?B?R2JRdDFpU3hXU2tYSW0yQWMzem45ZENHQzh0RWY2cFdQMlhlL3k2TkZuZFJY?=
 =?utf-8?B?VUc4REZDNTVVaFJBRnpRSTl0TEJzcml3S3VjQjF1K3JpRTFVL3BCK1ZqdHR3?=
 =?utf-8?B?ck9xcXNRcW52ZHBaQUJNZFpRTGN4emdxLy9RM1JlSnJPRW9ha0pqajVnQUJi?=
 =?utf-8?B?V3hlM25ISzJOK3I3eEFOb2dULzhDZTE5WlpMUkZPNXZlSHdyTXNPbkNwRHRa?=
 =?utf-8?B?V1hyWEF3WmppMnRSc2oyaTZ2NkhERHlzZHNjZHF3enV1ZFh6Z3VBMTdOMVBR?=
 =?utf-8?B?U1BFYllUdG5yNzQrKzVKVS9GNjdaSFNRU0xwOXlYQmdvR3BNZWd0SXVHR1Rs?=
 =?utf-8?B?QXRPSTl3eUlzMGZ2VStNTEpJWURTcHhjVDVsSkh3djBIdzkyaWlob3dSOEVh?=
 =?utf-8?B?NS9qYUNMR0gwa2VWZENteFJyZ3ZxanJDd1ljWEdldUF5TG1yQTcxZTNNYXcy?=
 =?utf-8?B?eVE2ZDRERnlZblRHbWxTRDBUbThoN1J6UWpvN1NWZENDcGNoT3pQaFVrWGhE?=
 =?utf-8?B?bmFrOEVKZGlSbkRUenMzYmpJY1gzenlLTHhhVm9GWGROSVNDNWIrakR2U1Zp?=
 =?utf-8?B?b1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 82825566-1a00-4072-228f-08dde16112aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2025 09:48:39.7307 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BNpO+3Qjkg+ZNw80a7rvTehFz7PO2ZunkIYxeu/nTE7L1C3yDp/gmkaeJyuRm7nP2RBLIrSAUhlDVW5g2Z7KeKK/TwcSdtKXb2bHs/ssaKs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1290
X-Mailman-Approved-At: Fri, 22 Aug 2025 14:52:02 +0200
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

PiBPbiAyMC4wOC4yNSAxMDo0NSBFIFNoYXR0b3cgd3JvdGU6DQo+IE9uIDgvMTcvMjUgMjM6NDUs
IEhhbCBGZW5nIHdyb3RlOg0KPiA+PiBPbiAxNS4wOC4yNSAxMzowMywgRSBTaGF0dG93IHdyb3Rl
Og0KPiA+PiBQcnVuZSBqaDcxMTAtY29tbW9uLXUtYm9vdC5kdHNpIChjbG9ja3MsIHFzcGkgZmxh
c2gsIGVlcHJvbSwgYW5kDQo+ID4+IGJvb3RwaC0gcHJlLXJhbSBoaW50cyBub3cgdXBzdHJlYW0g
c2luY2UgZGV2aWNldHJlZS1yZWJhc2luZyB2Ni4xNikNCj4gPj4gYW5kIHJlcGxhY2UgYnkgcmVt
YWluaW5nIGRlcGVuZGVuY3kgamg3MTEwLXUtYm9vdC5kdHNpIChub3QgeWV0DQo+IHVwc3RyZWFt
KS4NCj4gPj4NCj4gPj4gU2lnbmVkLW9mZi1ieTogRSBTaGF0dG93IDxlQGZyZWVzaGVsbC5kZT4N
Cj4gPj4gLS0tDQo+ID4+ICBhcmNoL3Jpc2N2L2R0cy9qaDcxMTAtY29tbW9uLXUtYm9vdC5kdHNp
ICAgICAgfCA5OSAtLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4+ICAuLi4vamg3MTEwLWRlZXBjb21w
dXRpbmctZm1sMTN2MDEtdS1ib290LmR0c2kgfCAgMiArLQ0KPiA+PiBhcmNoL3Jpc2N2L2R0cy9q
aDcxMTAtbWlsa3YtbWFycy11LWJvb3QuZHRzaSAgfCAgMiArLQ0KPiA+PiAgLi4uL2R0cy9qaDcx
MTAtcGluZTY0LXN0YXI2NC11LWJvb3QuZHRzaSAgICAgIHwgIDIgKy0NCj4gPj4gIC4uLjEwLXN0
YXJmaXZlLXZpc2lvbmZpdmUtMi12MS4yYS11LWJvb3QuZHRzaSB8ICAyICstDQo+ID4+IC4uLjEw
LXN0YXJmaXZlLXZpc2lvbmZpdmUtIDItdjEuM2ItdS1ib290LmR0c2kgfCAgMiArLQ0KPiA+PiAg
NiBmaWxlcyBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDEwNCBkZWxldGlvbnMoLSkgIGRlbGV0
ZSBtb2RlDQo+ID4+IDEwMDY0NCBhcmNoL3Jpc2N2L2R0cy9qaDcxMTAtY29tbW9uLXUtYm9vdC5k
dHNpDQo+ID4+DQo+ID4+IGRpZmYgLS1naXQgYS9hcmNoL3Jpc2N2L2R0cy9qaDcxMTAtY29tbW9u
LXUtYm9vdC5kdHNpDQo+ID4+IGIvYXJjaC9yaXNjdi9kdHMvamg3MTEwLWNvbW1vbi11LWJvb3Qu
ZHRzaQ0KPiA+PiBkZWxldGVkIGZpbGUgbW9kZSAxMDA2NDQNCj4gPj4gaW5kZXggMDQ5YjBhN2Nl
MjguLjAwMDAwMDAwMDAwDQo+ID4+IC0tLSBhL2FyY2gvcmlzY3YvZHRzL2poNzExMC1jb21tb24t
dS1ib290LmR0c2kNCj4gPj4gKysrIC9kZXYvbnVsbA0KPiA+PiBAQCAtMSw5OSArMCwwIEBADQo+
ID4+IC0vLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMCBPUiBNSVQNCj4gPj4gLS8q
DQo+ID4+IC0gKiBDb3B5cmlnaHQgKEMpIDIwMjMgU3RhckZpdmUgVGVjaG5vbG9neSBDby4sIEx0
ZC4NCj4gPj4gLSAqLw0KPiA+PiAtDQo+ID4+IC0jaW5jbHVkZSAiamg3MTEwLXUtYm9vdC5kdHNp
Ig0KPiA+PiAtLyB7DQo+ID4+IC0JYWxpYXNlcyB7DQo+ID4+IC0JCXNwaTAgPSAmcXNwaTsNCj4g
Pj4gLQl9Ow0KPiA+PiAtDQo+ID4+IC0JY2hvc2VuIHsNCj4gPj4gLQkJYm9vdHBoLXByZS1yYW07
DQo+ID4+IC0JfTsNCj4gPj4gLQ0KPiA+PiAtCWZpcm13YXJlIHsNCj4gPj4gLQkJc3BpMCA9ICZx
c3BpOw0KPiA+PiAtCQlib290cGgtcHJlLXJhbTsNCj4gPj4gLQl9Ow0KPiA+PiAtDQo+ID4+IC0J
bWVtb3J5QDQwMDAwMDAwIHsNCj4gPj4gLQkJYm9vdHBoLXByZS1yYW07DQo+ID4+IC0JfTsNCj4g
Pj4gLX07DQo+ID4+IC0NCj4gPj4gLSZ1YXJ0MCB7DQo+ID4+IC0JYm9vdHBoLXByZS1yYW07DQo+
ID4+IC0JcmVnLW9mZnNldCA9IDwwPjsNCj4gPj4gLQljdXJyZW50LXNwZWVkID0gPDExNTIwMD47
DQo+ID4+IC19Ow0KPiA+PiAtDQo+ID4+IC0mbW1jMCB7DQo+ID4+IC0JYm9vdHBoLXByZS1yYW07
DQo+ID4+IC19Ow0KPiA+PiAtDQo+ID4+IC0mbW1jMSB7DQo+ID4+IC0JYm9vdHBoLXByZS1yYW07
DQo+ID4+IC19Ow0KPiA+PiAtDQo+ID4+IC0mcXNwaSB7DQo+ID4+IC0JYm9vdHBoLXByZS1yYW07
DQo+ID4+IC0NCj4gPj4gLQlmbGFzaEAwIHsNCj4gPj4gLQkJYm9vdHBoLXByZS1yYW07DQo+ID4+
IC0JCWNkbnMscmVhZC1kZWxheSA9IDwyPjsNCj4gPj4gLQkJc3BpLW1heC1mcmVxdWVuY3kgPSA8
MTAwMDAwMDAwPjsNCj4gPj4gLQl9Ow0KPiA+PiAtfTsNCj4gPj4gLQ0KPiA+PiAtJnN5c2NyZyB7
DQo+ID4+IC0JYXNzaWduZWQtY2xvY2tzID0gPCZzeXNjcmcgSkg3MTEwX1NZU0NMS19DUFVfUk9P
VD4sDQo+ID4+IC0JCQkgIDwmc3lzY3JnIEpINzExMF9TWVNDTEtfQlVTX1JPT1Q+LA0KPiA+PiAt
CQkJICA8JnN5c2NyZyBKSDcxMTBfU1lTQ0xLX1BFUkhfUk9PVD4sDQo+ID4+IC0JCQkgIDwmc3lz
Y3JnIEpINzExMF9TWVNDTEtfUVNQSV9SRUY+Ow0KPiA+PiAtCWFzc2lnbmVkLWNsb2NrLXBhcmVu
dHMgPSA8JnBsbGNsayBKSDcxMTBfUExMQ0xLX1BMTDBfT1VUPiwNCj4gPj4gLQkJCQkgPCZwbGxj
bGsgSkg3MTEwX1BMTENMS19QTEwyX09VVD4sDQo+ID4+IC0JCQkJIDwmcGxsY2xrIEpINzExMF9Q
TExDTEtfUExMMl9PVVQ+LA0KPiA+PiAtCQkJCSA8JnN5c2NyZyBKSDcxMTBfU1lTQ0xLX1FTUElf
UkVGX1NSQz47DQo+ID4+IC0JYXNzaWduZWQtY2xvY2stcmF0ZXMgPSA8MD4sIDwwPiwgPDA+LCA8
MD47DQo+ID4+IC19Ow0KPiA+PiAtDQo+ID4+IC0mc3lzZ3BpbyB7DQo+ID4+IC0JYm9vdHBoLXBy
ZS1yYW07DQo+ID4+IC19Ow0KPiA+PiAtDQo+ID4+IC0mbW1jMF9waW5zIHsNCj4gPj4gLQlib290
cGgtcHJlLXJhbTsNCj4gPj4gLQlyc3QtcGlucyB7DQo+ID4+IC0JCWJvb3RwaC1wcmUtcmFtOw0K
PiA+PiAtCX07DQo+ID4+IC19Ow0KPiA+PiAtDQo+ID4+IC0mbW1jMV9waW5zIHsNCj4gPj4gLQli
b290cGgtcHJlLXJhbTsNCj4gPj4gLQljbGstcGlucyB7DQo+ID4+IC0JCWJvb3RwaC1wcmUtcmFt
Ow0KPiA+PiAtCX07DQo+ID4+IC0NCj4gPj4gLQltbWMtcGlucyB7DQo+ID4+IC0JCWJvb3RwaC1w
cmUtcmFtOw0KPiA+PiAtCX07DQo+ID4+IC19Ow0KPiA+PiAtDQo+ID4+IC0maTJjNV9waW5zIHsN
Cj4gPj4gLQlib290cGgtcHJlLXJhbTsNCj4gPj4gLQlpMmMtcGlucyB7DQo+ID4+IC0JCWJvb3Rw
aC1wcmUtcmFtOw0KPiA+PiAtCX07DQo+ID4+IC19Ow0KPiA+PiAtDQo+ID4+IC0maTJjNSB7DQo+
ID4+IC0JYm9vdHBoLXByZS1yYW07DQo+ID4+IC0JZWVwcm9tQDUwIHsNCj4gPj4gLQkJYm9vdHBo
LXByZS1yYW07DQo+ID4+IC0JCWNvbXBhdGlibGUgPSAiYXRtZWwsMjRjMDQiOw0KPiA+PiAtCQly
ZWcgPSA8MHg1MD47DQo+ID4+IC0JCXBhZ2VzaXplID0gPDE2PjsNCj4gPj4gLQl9Ow0KPiA+PiAt
fTsNCj4gPj4gZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3YvZHRzL2poNzExMC1kZWVwY29tcHV0aW5n
LWZtbDEzdjAxLXUtYm9vdC5kdHNpDQo+ID4+IGIvYXJjaC9yaXNjdi9kdHMvamg3MTEwLWRlZXBj
b21wdXRpbmctZm1sMTN2MDEtdS1ib290LmR0c2kNCj4gPj4gaW5kZXggYWI4ODJkMDdmNmYuLmI5
MjAyZjJhY2NlIDEwMDY0NA0KPiA+PiAtLS0gYS9hcmNoL3Jpc2N2L2R0cy9qaDcxMTAtZGVlcGNv
bXB1dGluZy1mbWwxM3YwMS11LWJvb3QuZHRzaQ0KPiA+PiArKysgYi9hcmNoL3Jpc2N2L2R0cy9q
aDcxMTAtZGVlcGNvbXB1dGluZy1mbWwxM3YwMS11LWJvb3QuZHRzaQ0KPiA+PiBAQCAtMyw1ICsz
LDUgQEANCj4gPj4gICAqIENvcHlyaWdodCAoQykgMjAyNCBTdGFyRml2ZSBUZWNobm9sb2d5IENv
LiwgTHRkLg0KPiA+PiAgICovDQo+ID4+DQo+ID4+IC0jaW5jbHVkZSAiamg3MTEwLWNvbW1vbi11
LWJvb3QuZHRzaSINCj4gPj4gKyNpbmNsdWRlICJqaDcxMTAtdS1ib290LmR0c2kiDQo+ID4+ICAj
aW5jbHVkZSAic3RhcmZpdmUtdmlzaW9uZml2ZTItYmlubWFuLmR0c2kiDQo+ID4+IGRpZmYgLS1n
aXQgYS9hcmNoL3Jpc2N2L2R0cy9qaDcxMTAtbWlsa3YtbWFycy11LWJvb3QuZHRzaQ0KPiA+PiBi
L2FyY2gvcmlzY3YvZHRzL2poNzExMC1taWxrdi1tYXJzLXUtYm9vdC5kdHNpDQo+ID4+IGluZGV4
IGFiODgyZDA3ZjZmLi5iOTIwMmYyYWNjZSAxMDA2NDQNCj4gPj4gLS0tIGEvYXJjaC9yaXNjdi9k
dHMvamg3MTEwLW1pbGt2LW1hcnMtdS1ib290LmR0c2kNCj4gPj4gKysrIGIvYXJjaC9yaXNjdi9k
dHMvamg3MTEwLW1pbGt2LW1hcnMtdS1ib290LmR0c2kNCj4gPj4gQEAgLTMsNSArMyw1IEBADQo+
ID4+ICAgKiBDb3B5cmlnaHQgKEMpIDIwMjQgU3RhckZpdmUgVGVjaG5vbG9neSBDby4sIEx0ZC4N
Cj4gPj4gICAqLw0KPiA+Pg0KPiA+PiAtI2luY2x1ZGUgImpoNzExMC1jb21tb24tdS1ib290LmR0
c2kiDQo+ID4+ICsjaW5jbHVkZSAiamg3MTEwLXUtYm9vdC5kdHNpIg0KPiA+PiAgI2luY2x1ZGUg
InN0YXJmaXZlLXZpc2lvbmZpdmUyLWJpbm1hbi5kdHNpIg0KPiA+PiBkaWZmIC0tZ2l0IGEvYXJj
aC9yaXNjdi9kdHMvamg3MTEwLXBpbmU2NC1zdGFyNjQtdS1ib290LmR0c2kNCj4gPj4gYi9hcmNo
L3Jpc2N2L2R0cy9qaDcxMTAtcGluZTY0LXN0YXI2NC11LWJvb3QuZHRzaQ0KPiA+PiBpbmRleCBh
Yjg4MmQwN2Y2Zi4uYjkyMDJmMmFjY2UgMTAwNjQ0DQo+ID4+IC0tLSBhL2FyY2gvcmlzY3YvZHRz
L2poNzExMC1waW5lNjQtc3RhcjY0LXUtYm9vdC5kdHNpDQo+ID4+ICsrKyBiL2FyY2gvcmlzY3Yv
ZHRzL2poNzExMC1waW5lNjQtc3RhcjY0LXUtYm9vdC5kdHNpDQo+ID4+IEBAIC0zLDUgKzMsNSBA
QA0KPiA+PiAgICogQ29weXJpZ2h0IChDKSAyMDI0IFN0YXJGaXZlIFRlY2hub2xvZ3kgQ28uLCBM
dGQuDQo+ID4+ICAgKi8NCj4gPj4NCj4gPj4gLSNpbmNsdWRlICJqaDcxMTAtY29tbW9uLXUtYm9v
dC5kdHNpIg0KPiA+PiArI2luY2x1ZGUgImpoNzExMC11LWJvb3QuZHRzaSINCj4gPj4gICNpbmNs
dWRlICJzdGFyZml2ZS12aXNpb25maXZlMi1iaW5tYW4uZHRzaSINCj4gPj4gZGlmZiAtLWdpdA0K
PiA+PiBhL2FyY2gvcmlzY3YvZHRzL2poNzExMC1zdGFyZml2ZS12aXNpb25maXZlLTItdjEuMmEt
dS1ib290LmR0c2kNCj4gPj4gYi9hcmNoL3Jpc2N2L2R0cy9qaDcxMTAtc3RhcmZpdmUtdmlzaW9u
Zml2ZS0yLXYxLjJhLXUtYm9vdC5kdHNpDQo+ID4+IGluZGV4IGFiODgyZDA3ZjZmLi5iOTIwMmYy
YWNjZSAxMDA2NDQNCj4gPj4gLS0tIGEvYXJjaC9yaXNjdi9kdHMvamg3MTEwLXN0YXJmaXZlLXZp
c2lvbmZpdmUtMi12MS4yYS11LWJvb3QuZHRzaQ0KPiA+PiArKysgYi9hcmNoL3Jpc2N2L2R0cy9q
aDcxMTAtc3RhcmZpdmUtdmlzaW9uZml2ZS0yLXYxLjJhLXUtYm9vdC5kdHNpDQo+ID4+IEBAIC0z
LDUgKzMsNSBAQA0KPiA+PiAgICogQ29weXJpZ2h0IChDKSAyMDI0IFN0YXJGaXZlIFRlY2hub2xv
Z3kgQ28uLCBMdGQuDQo+ID4+ICAgKi8NCj4gPj4NCj4gPj4gLSNpbmNsdWRlICJqaDcxMTAtY29t
bW9uLXUtYm9vdC5kdHNpIg0KPiA+PiArI2luY2x1ZGUgImpoNzExMC11LWJvb3QuZHRzaSINCj4g
Pj4gICNpbmNsdWRlICJzdGFyZml2ZS12aXNpb25maXZlMi1iaW5tYW4uZHRzaSINCj4gPj4gZGlm
ZiAtLWdpdA0KPiA+PiBhL2FyY2gvcmlzY3YvZHRzL2poNzExMC1zdGFyZml2ZS12aXNpb25maXZl
LTItdjEuM2ItdS1ib290LmR0c2kNCj4gPj4gYi9hcmNoL3Jpc2N2L2R0cy9qaDcxMTAtc3RhcmZp
dmUtdmlzaW9uZml2ZS0yLXYxLjNiLXUtYm9vdC5kdHNpDQo+ID4+IGluZGV4IDg3NDA3NDE3NGZm
Li44NDhlZDgyMjVhYyAxMDA2NDQNCj4gPj4gLS0tIGEvYXJjaC9yaXNjdi9kdHMvamg3MTEwLXN0
YXJmaXZlLXZpc2lvbmZpdmUtMi12MS4zYi11LWJvb3QuZHRzaQ0KPiA+PiArKysgYi9hcmNoL3Jp
c2N2L2R0cy9qaDcxMTAtc3RhcmZpdmUtdmlzaW9uZml2ZS0yLXYxLjNiLXUtYm9vdC5kdHNpDQo+
ID4+IEBAIC0zLDUgKzMsNSBAQA0KPiA+PiAgICogQ29weXJpZ2h0IChDKSAyMDIzIFN0YXJGaXZl
IFRlY2hub2xvZ3kgQ28uLCBMdGQuDQo+ID4+ICAgKi8NCj4gPj4NCj4gPj4gLSNpbmNsdWRlICJq
aDcxMTAtY29tbW9uLXUtYm9vdC5kdHNpIg0KPiA+PiArI2luY2x1ZGUgImpoNzExMC11LWJvb3Qu
ZHRzaSINCj4gPj4gICNpbmNsdWRlICJzdGFyZml2ZS12aXNpb25maXZlMi1iaW5tYW4uZHRzaSIN
Cj4gPj4NCj4gPj4gYmFzZS1jb21taXQ6IDBjNTU4YmJhZDllNzU4MTgwOGIzNTgwOTFkMWZkOTc5
Zjg2MGU4YWMNCj4gPg0KPiA+IEkgZmluZCB0aGF0IHRoZXJlIGFyZSBubyAnJ2Jvb3RwaC1wcmUt
cmFtJycgaW4gbW1jMF9waW5zIGFuZCBtbWMxX3BpbnMNCj4gPiBpbiBkdHMvdXBzdHJlYW0vc3Jj
L3Jpc2N2L3N0YXJmaXZlL2poNzExMC1jb21tb24uZHRzaS4NCj4gPg0KPiA+IElzIGl0IHJlYWR5
IG5vdyB0byBkcm9wIGpoNzExMC1jb21tb24tdS1ib290LmR0c2k/DQo+ID4NCj4gPiBCZXN0IHJl
Z2FyZHMsDQo+ID4gSGFsDQo+IA0KPiBZZXMsIHRoYW5rIHlvdSBmb3IgeW91ciByZXZpZXcuDQo+
IA0KPiBDdXJyZW50bHkgdGhlIFUtQm9vdCBTUEwgY29kZSBwYXRoIHRoYXQgcmVxdWlyZXMgZU1N
QyBhbmQgU0QgQ2FyZA0KPiBmdW5jdGlvbmFsaXR5IGlzIHdpdGggdGhlc2UgZGVwcmVjYXRlZCBK
SDcxMTAgbG9hZGVyIG1vZGVzLCBvciBzb21lIHVubGlrZWx5DQo+IHJ1bnRpbWUgY2hhbmdlIGlu
IFJHUElPMCAvIFJHUElPMSBzdGF0ZSBiZWZvcmUgVS1Cb290IFNQTCBmb2xsb3dpbmcgdGhlDQo+
IEpINzExMCBsb2FkZXIuDQo+IA0KPiBJIHdpbGwgY29uc2lkZXIgc2VyaW91c2x5IHRvIHN1cHBv
cnQgdGhlIGRlcHJlY2F0ZWQgZnVuY3Rpb25hbGl0eSBpZiB0aGVyZSBpcw0KPiBzdWZmaWNpZW50
IGRvY3VtZW50YXRpb24gaW4gdGhlIGZvcm0gb2YgYSBmdWxsIHNvdXJjZSBjb2RlIGxpc3Rpbmcg
Zm9yIHRoZQ0KPiBKSDcxMTAgbWFzayBST00gbG9hZGVyLiBPdGhlcndpc2UgSSBkbyBub3QgaGF2
ZSB0aW1lIG9yIGludGVyZXN0IHRvIHJldmVyc2UtDQo+IGVuZ2luZWVyIHRoZXNlIHRoaW5ncyBs
YWNraW5nIGluIGRvY3VtZW50YXRpb24gZnJvbSBTdGFyRml2ZS4NCg0KWW91IGFyZSByaWdodC4g
SXQncyBzdWdnZXN0ZWQgdG8gb25seSBib290IGZyb20gZmxhc2ggb24gVkYyIGJvYXJkLiANCg0K
QnV0IGl0IGlzIHdlaXJkIHRoYXQgaW4gZHRzL3Vwc3RyZWFtL3NyYy9yaXNjdi9zdGFyZml2ZS9q
aDcxMTAtY29tbW9uLmR0c2ksDQp0aGVyZSBhcmUgImJvb3RwaC1wcmUtcmFtIiBpbiBtbWMwLzEg
bm9kZXMgYW5kIG5vICJib290cGgtcHJlLXJhbSINCmluIG1tYzAvMV9waW5zIG5vZGVzLg0KDQpC
ZXN0IHJlZ2FyZHMsDQpIYWwNCg==
