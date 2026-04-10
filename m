Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74C0DF44857
	for <u-boot@archiver.kernel.org>; Fri, 10 Apr 2026 12:54:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96F0984099;
	Fri, 10 Apr 2026 14:54:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=infineon.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=infineon.com header.i=@infineon.com header.b="osL1KUCS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5340284105; Fri, 10 Apr 2026 10:42:56 +0200 (CEST)
Received: from smtp11.infineon.com (smtp11.infineon.com
 [IPv6:2a00:18f0:1e00:4::5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F023D83DC9
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 10:42:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=infineon.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Takahiro.Kuwano@infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
 t=1775810574; x=1807346574;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=K89Z0Pm86SFkjqoBJvPnxdRtVyhxgg6IAxfirdpgKvY=;
 b=osL1KUCSrr0cAQ/3rKWQgFOjN1Srj9+lppFTslOjShEjSjDPwlUqNZvk
 +X+RCXk8MbGTUo4KNckf175AG1amYF32AEcyAFb8wexHy2S6YQ5hr9xj1
 ML0pTgYNQugMKbt1CYIeNqEFjW/7nNs2cuL5gvqhkKm7VDGeteGJf6YvA Q=;
X-CSE-ConnectionGUID: KshV9RJBRI6723Of8eVaPg==
X-CSE-MsgGUID: SUC6tqCtQPu/frsno/LiOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="138631018"
X-IronPort-AV: E=Sophos;i="6.23,171,1770591600"; d="scan'208";a="138631018"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE812.infineon.com) ([172.23.29.38])
 by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Apr 2026 10:42:54 +0200
Received: from MUCSE815.infineon.com (172.23.29.41) by MUCSE812.infineon.com
 (172.23.29.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 10 Apr
 2026 10:42:53 +0200
Received: from MUCSE815.infineon.com ([fe80::b54c:c0bd:546c:c9be]) by
 MUCSE815.infineon.com ([fe80::b54c:c0bd:546c:c9be%12]) with mapi id
 15.02.2562.037; Fri, 10 Apr 2026 10:42:53 +0200
From: <Takahiro.Kuwano@infineon.com>
To: <dlechner@baylibre.com>, <vigneshr@ti.com>, <trini@konsulko.com>
CC: <jstephan@baylibre.com>, <u-boot@lists.denx.de>
Subject: RE: [PATCH] mtd: spi-nor-ids: add flags for mx25u12835f
Thread-Topic: [PATCH] mtd: spi-nor-ids: add flags for mx25u12835f
Thread-Index: AQHcw6jVKqOO/kp+JkiV3123XGpyb7XX/Wtg
Date: Fri, 10 Apr 2026 08:42:53 +0000
Message-ID: <683be5a32ef345229d54a68ea67fe64c@infineon.com>
References: <20260403-spi-nor-mx25u12835f-v1-1-c9ffdae25d8d@baylibre.com>
In-Reply-To: <20260403-spi-nor-mx25u12835f-v1-1-c9ffdae25d8d@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.161.6.196]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 10 Apr 2026 14:54:22 +0200
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

SGksDQoNCj4gDQo+IEFkZCBzb21lIGNhcGFiaWxpdHkgZmxhZ3MgZm9yIG14MjV1MTI4MzVmLg0K
PiANCj4gSW4gcGFydGljdWxhciwgd2UgYXJlIGludGVyZXN0ZWQgaW4gdXNpbmcgdGhlIGxvY2sg
ZmVhdHVyZS4gQWNjb3JkaW5nIHRvDQo+IHRoZSBkYXRhc2hlZXQsIGR1YWwvcXVhZCByZWFkIGlz
IGFsc28gc3VwcG9ydGVkLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRGF2aWQgTGVjaG5lciA8ZGxl
Y2huZXJAYmF5bGlicmUuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvbXRkL3NwaS9zcGktbm9yLWlk
cy5jIHwgMyArKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRp
b24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9zcGkvc3BpLW5vci1pZHMuYyBi
L2RyaXZlcnMvbXRkL3NwaS9zcGktbm9yLWlkcy5jDQo+IGluZGV4IGU3ZmVhMzc1NzA2Li40OTMw
ZmE4NDY4NSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9tdGQvc3BpL3NwaS1ub3ItaWRzLmMNCj4g
KysrIGIvZHJpdmVycy9tdGQvc3BpL3NwaS1ub3ItaWRzLmMNCj4gQEAgLTI3Miw3ICsyNzIsOCBA
QCBjb25zdCBzdHJ1Y3QgZmxhc2hfaW5mbyBzcGlfbm9yX2lkc1tdID0gew0KPiAgICAgICAgIHsg
SU5GTygibXgyNXUzMjM1ZiIsICAweGMyMjUzNiwgMCwgNCAqIDEwMjQsICAxMDI0LCBTRUNUXzRL
KSB9LA0KPiAgICAgICAgIHsgSU5GTygibXgyNXU2NDM1ZiIsICAweGMyMjUzNywgMCwgNjQgKiAx
MDI0LCAxMjgsIFNFQ1RfNEspIH0sDQo+ICAgICAgICAgeyBJTkZPKCJteDI1bDEyODA1ZCIsIDB4
YzIyMDE4LCAwLCA2NCAqIDEwMjQsIDI1NiwgU0VDVF80SykgfSwNCj4gLSAgICAgICB7IElORk8o
Im14MjV1MTI4MzVmIiwgMHhjMjI1MzgsIDAsIDY0ICogMTAyNCwgMjU2LCBTRUNUXzRLKSB9LA0K
PiArICAgICAgIHsgSU5GTygibXgyNXUxMjgzNWYiLCAweGMyMjUzOCwgMCwgNjQgKiAxMDI0LCAy
NTYsIFNFQ1RfNEsgfA0KPiArICAgICAgICAgICAgICBTUElfTk9SX0hBU19MT0NLIHwgU1BJX05P
Ul9IQVNfVEIgfCBTUElfTk9SX0RVQUxfUkVBRCB8IFNQSV9OT1JfUVVBRF9SRUFEKSB9LA0KDQpE
aWQgeW91IHRlc3Qgd2l0aCBjb250cm9sbGVyIHRoYXQgc3VwcG9ydHMgcXVhZCBvcHM/DQoNCklu
IHNwaS1ub3ItY29yZS5jOiBzcGlfbm9yX2luaXRfcGFyYW1zKCk6DQouLi4NCglpZiAoaW5mby0+
ZmxhZ3MgJiBTUElfTk9SX1FVQURfUkVBRCkgew0KCQlwYXJhbXMtPmh3Y2Fwcy5tYXNrIHw9IFNO
T1JfSFdDQVBTX1BQXzFfMV80Ow0KCQlzcGlfbm9yX3NldF9wcF9zZXR0aW5ncygmcGFyYW1zLT5w
YWdlX3Byb2dyYW1zW1NOT1JfQ01EX1BQXzFfMV80XSwNCgkJCQkJU1BJTk9SX09QX1BQXzFfMV80
LCBTTk9SX1BST1RPXzFfMV80KTsNCgl9DQouLi4NClNQSU5PUl9PUF9QUF8xXzFfNCAoMHgzMikg
aXMgc2V0IGFzIGNhbmRpZGF0ZSBvZiBwYWdlIHByb2dyYW0gb3Bjb2RlLCBidXQNCmFjY29yZGlu
ZyB0byBteDI1dTEyODM1ZiBkYXRhc2hlZXQsIHRoYXQgb3Bjb2RlIGlzIG5vdCBzdXBwb3J0ZWQu
DQoNClRoaXMgaXMgYSBwcm9ibGVtIGluIGNvcmUgc2lkZSBhbmQgd2UgbmVlZCB0byBmaXggaXQu
DQpJbiBMaW51eCwgYSBkZWRpY2F0ZWQgZmxhZyBuYW1lZCBTUElfTk9SX1FVQURfUFAgaXMgY2hl
Y2tlZC4NCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDIyMDkyMDE4NDgwOC40NDg3Ni0y
LXN1ZGlwLm11a2hlcmplZUBzaWZpdmUuY29tLw0KDQpUaGFua3MsDQpUYWthaGlybw0KDQo+ICAg
ICAgICAgeyBJTkZPKCJteDI1dTUxMjQ1ZyIsIDB4YzIyNTNhLCAwLCA2NCAqIDEwMjQsIDEwMjQs
IFNFQ1RfNEsgfA0KPiAgICAgICAgICAgICAgICBTUElfTk9SX0RVQUxfUkVBRCB8IFNQSV9OT1Jf
UVVBRF9SRUFEIHwgU1BJX05PUl80Ql9PUENPREVTKSB9LA0KPiAgICAgICAgIHsgSU5GTygibXgy
NWwxMjg1NWUiLCAweGMyMjYxOCwgMCwgNjQgKiAxMDI0LCAyNTYsIDApIH0sDQo+IA0KPiAtLS0N
Cj4gYmFzZS1jb21taXQ6IDFjMWJmYjFjZjM0YmJiMmE1NzE3ZWI2OTk1YzU1MDkzMjc5ZjkzNDEN
Cj4gY2hhbmdlLWlkOiAyMDI2MDQwMy1zcGktbm9yLW14MjV1MTI4MzVmLWY3MzI4YTYzMTQzNg0K
PiANCj4gQmVzdCByZWdhcmRzLA0KPiAtLQ0KPiBEYXZpZCBMZWNobmVyIDxkbGVjaG5lckBiYXls
aWJyZS5jb20+DQoNCg==
