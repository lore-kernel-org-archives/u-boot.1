Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 440A8C4725D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 06:49:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D19D87AEC;
	Fri, 19 Jan 2024 07:49:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="mG7PA0cF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1ED287B8E; Fri, 19 Jan 2024 07:49:25 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B5FE87AEC
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 07:49:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1705646963; x=1708238963;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QdQxi/oiXQw921y+fXhoVoTh01r0wFrCKDA0QYrL2zk=;
 b=mG7PA0cFmJNPVISs4SmQ58DGvgLv+DIvhcp38xv4QYnM6zTkxOS40ItrVHUXyHgY
 1bnI9tlv51nXq0xzdH1f/JtyWOId3058ZNV1G8Z9AF/g84EjAHec2UMS/HbNrBsm
 whqnn5Mrgi1R0tziR8lZhtTmCd9SvxmmO3sd4T5NHEc=;
X-AuditID: ac14000a-fadff7000000290d-0a-65aa1b7264f0
Received: from florix.phytec.de (Unknown_Domain [172.25.0.13])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 12.F8.10509.37B1AA56;
 Fri, 19 Jan 2024 07:49:23 +0100 (CET)
Received: from Berlix.phytec.de (172.25.0.12) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Fri, 19 Jan
 2024 07:49:22 +0100
Received: from Berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4]) by
 berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4%4]) with mapi id 15.01.2507.006;
 Fri, 19 Jan 2024 07:49:22 +0100
From: Yannic Moog <Y.Moog@phytec.de>
To: "primoz.fiser@norik.com" <primoz.fiser@norik.com>, "m.othacehe@gmail.com"
 <m.othacehe@gmail.com>
CC: "peng.fan@nxp.com" <peng.fan@nxp.com>, "trini@konsulko.com"
 <trini@konsulko.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "upstream@lists.phytec.de" <upstream@lists.phytec.de>, "sbabic@denx.de"
 <sbabic@denx.de>, "uboot-imx@nxp.com" <uboot-imx@nxp.com>,
 "festevam@gmail.com" <festevam@gmail.com>
Subject: Re: [Upstream] [PATCH] Add Phytec i.MX93 support
Thread-Topic: [Upstream] [PATCH] Add Phytec i.MX93 support
Thread-Index: AQHaSRot8kpDN1J+g0iVJFysGsaNDrDfVJoAgAAVb7yAATpDAA==
Date: Fri, 19 Jan 2024 06:49:22 +0000
Message-ID: <010a36a7d295152e5f78650904ec2df17ff36618.camel@phytec.de>
References: <20240117075254.8520-1-othacehe@gnu.org>
 <9add814d-540b-4ddb-8cfc-261e62049d7e@norik.com> <87ttnavr5u.fsf@gmail.com>
In-Reply-To: <87ttnavr5u.fsf@gmail.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.0.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <BCC79E4D83C82A438E03731F44E93DEF@phytec.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBIsWRmVeSWpSXmKPExsWyRpKBV7dYelWqwZmXjBYPr/pbzLg5jc3i
 x6ovrBYnuh6yWrSf8rGYOmkzu8XbvZ3sFlMer2e36H6n7sDpMW/WCRaPnbPusnu8OrCK3ePs
 nR2MHv3dLawe379uYPXY+G4HUwB7FJdNSmpOZllqkb5dAlfG8rOP2ArOCVVsnfGLqYFxglAX
 IyeHhICJxOHu6yxdjFwcQgKLmSQ+tDaxgSSEBO4zSjxe6g2R2MAo8X7neSaQBJuAisTJGZcY
 QWwRgTSJ3X1zwbqZBXYyScx50wlUxMEhLGApcXhxAkSNlcTiBx+g6p0k5u+YygpiswioSuy6
 /4sdxOYVcJOY1LeWEWJZM6PEz4kXmUESnALqErsWd7KA2IwCshIbNpwHizMLiEtsevadFeIF
 AYkleyDiEgKiEi8f/4OKy0ucuDUN7B5mAU2J9bv0IVotJCbf2cYIYStKTOl+CHWDoMTJmU9Y
 JjCKz0KyYRZC9ywk3bOQdM9C0r2AkXUVo1BuZnJ2alFmtl5BRmVJarJeSuomRlBsizBw7WDs
 m+NxiJGJg/EQowQHs5IIr7/BslQh3pTEyqrUovz4otKc1OJDjNIcLErivKs7glOFBNITS1Kz
 U1MLUotgskwcnFINjKqB80z3fc88GnO5Jatht675TN89/8TYO+IfG02UvTmn/MH01HnxAkp3
 3l75vMP859XSsLkMrhJf7H78X/T11YqNyjLGf+ZO2iMsv8f46EnZZZ+//RFqtF7wrPHXlmUs
 AjLPFuRct6w7c1t9h2mhZtCZ5VvPTD8ZdsEtZXILv/XZVbs9n7xYPVFRiaU4I9FQi7moOBEA
 Rwvz9dsCAAA=
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

SGkgTWF0aGlldQ0KDQpPbiBUaHUsIDIwMjQtMDEtMTggYXQgMTI6MDQgKzAxMDAsIE1hdGhpZXUg
T3RoYWNlaGUgd3JvdGU6DQo+IA0KPiBIaSwNCj4gDQo+IFRoYW5rcyBmb3IgdGhlIHJldmlldyEN
Cj4gDQo+ID4gcy9pbXg5M19waHljb3JlL3BoeWNvcmVfaW14OTMNCj4gPiANCj4gPiBUbyBmaXQg
aW50byBleGlzdGluZyBQSFlURUMgYm9hcmRzIGFscmVhZHkgaW4gdHJlZS4NCj4gDQo+IEkgZGVs
aWJlcmF0ZWx5IHBpY2tlZCB0aGF0IG9yZGVyIHNvIHRoYXQgaXQgaXMgYWxpZ25lZCB3aXRoIG1v
c3QgaW14DQo+IGJvYXJkcyBhbHJlYWR5IHN1cHBvcnRlZCBieSB1LWJvb3QuDQo+IA0KPiBUaGUg
c3VwcG9ydGVkIGlteDkzIGJvYXJkcyBmb2xsb3cgdGhhdCBwYXR0ZXJuOg0KPiANCj4gLSBpbXg5
M192YXJfc29tDQo+IC0gaW14OTNfZXZrDQo+IA0KPiBTbyBpdCBmZWx0IG5hdHVyYWwgdG8gaGF2
ZToNCj4gDQo+IC0gaW14OTNfcGh5Y29yZQ0KPiANCj4gUGx1cyB0aGUga2VybmVsIGRldmljZS10
cmVlcyBhcmUgYWxzbyBmb2xsb3dpbmcgdGhhdCBvcmRlcjoNCj4gDQo+IC0gaW14OTMtcGh5Y29y
ZS14eHgNCj4gDQo+IE9uIHRoZSBvdGhlciBoYW5kLCBpdCBpcyB0cnVlIHRoYXQgdGhlIGV4aXN0
aW5nIHBoeWNvcmUgYm9hcmRzIHVzZSB0aGUNCj4gcGh5dGVjXyogcGF0dGVybjoNCj4gDQo+IC0g
cGh5Y29yZV9hbTMzNXhfcjINCj4gLSBwaHljb3JlX2lteDhtbQ0KPiAtIHBoeWNvcmVfaW14OG1w
DQo+IC0gcGh5Y29yZV9yazMyODgvDQo+IA0KPiBTbyB0aGF0IHdpbGwgYmUgY29uZnVzaW5nIG5v
IG1hdHRlciB0aGUgb3B0aW9uIHRoYXQgd2UgY2hvb3NlLg0KPiANCj4gSSB3aWxsIGNvbWUgdXAg
d2l0aCBhIHYyIGZpeGluZyB5b3VyIG90aGVyIHJlbWFya3MsIGJ1dCBJIHRoaW5rIHRoYXQNCj4g
dGhpcyBzaG91bGQgYmUgYWRkcmVzc2VkIGJlZm9yZWhhbmQuDQoNCldlIGRlY2lkZWQgbm90IHRv
IGFsdGVyIHRoZSBuYW1lcyBhZnRlciB0aGUgZmFjdCwgYnV0IGZvciBpbXg4IHByb2R1Y3QgZmFt
aWx5IHdlIG5vdGljZWQgdGhlIHNhbWUNCnByb2JsZW0uDQpBbnl3YXksIHRvIGF2b2lkIHRoaXMg
d2hvbGUgaXNzdWUsIHBsZWFzZSBuYW1lIHRoZSBkZWZjb25maWcgYW5kIHRoZSBkZXZpY2UgdHJl
ZSB0byBpbXg5My1waHlib2FyZC0NCnNlZ2luLiBUaGlzIGF2b2lkcyB0aGUgY2hhbGxlbmdlIG9m
IG5hbWluZyBjb25maWdzIHdoZW4geW91IGhhdmUgbXVsdGlwbGUgY2FycmllciBib2FyZHMgc3Vw
cG9ydGVkDQpmb3IgdGhlIHNhbWUgU29NLiBGdXJ0aGVyLCBmb3IgdGhlIGJvYXJkL3BoeXRlYy8g
ZGlyLCBvbmx5IHBoeXRlYyBib2FyZCBjb2RlIGlzIGluIHRoZXJlLCBzbyB5b3UgbWF5DQpzdGlj
ayB0byB0aGUgcGh5dGVjIG5hbWluZyBjb252ZW50aW9uIChpLmUuIHBoeWNvcmVfaW14OTMgYXMg
UHJpbW96IHN1Z2dlc3RlZCkuIFRoaXMgYWxzbyBhbGxvd3MgdG8NCnJldXNlIHRoZSBwaHljb3Jl
IGNvZGUgKHNlZSBpbXg4bW0tcGh5Z2F0ZS10YXVyaS1sIGZvciByZWZlcmVuY2UpLg0KDQpZYW5u
aWMNCj4gDQo+IFRoYW5rcywNCj4gDQo+IE1hdGhpZXUNCj4gX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18NCj4gdXBzdHJlYW0gbWFpbGluZyBsaXN0DQo+IHVw
c3RyZWFtQGxpc3RzLnBoeXRlYy5kZQ0KPiBodHRwOi8vbGlzdHMucGh5dGVjLmRlL2NnaS1iaW4v
bWFpbG1hbi9saXN0aW5mby91cHN0cmVhbQ0KDQo=
