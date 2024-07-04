Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C03FBC3065C
	for <u-boot@archiver.kernel.org>; Thu,  4 Jul 2024 07:32:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F4E5885D7;
	Thu,  4 Jul 2024 09:32:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="aE2+VrJZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF03F8888F; Thu,  4 Jul 2024 09:32:43 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9144C885B3
 for <u-boot@lists.denx.de>; Thu,  4 Jul 2024 09:32:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=B.Hahn@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1720078361; x=1722670361;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jR22rzxyEPAkw66mVEfhOsTYXqSkq+1KIjUJRRT/JQs=;
 b=aE2+VrJZ8q8fMqPHR/mWUby6+5qmSwyFOWoyo4iiVIYXr9DsYwHSKuA9ZW6KMYNV
 IoogtWTHGKMHrgmPQL4LEHvOiRATXwMIt7Y1omnCxfcciW9kZM+JFER9AuNGSi6w
 wCpu0uWCORIMX4KC0sktbXLWtDhbTMRNSFNEESlR6/c=;
X-AuditID: ac14000a-03e52700000021bc-4e-66865019eca6
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id C3.E4.08636.91056866;
 Thu,  4 Jul 2024 09:32:41 +0200 (CEST)
Received: from Berlix.phytec.de (172.25.0.12) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 4 Jul 2024
 09:32:41 +0200
Received: from Berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4]) by
 berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4%4]) with mapi id 15.01.2507.006;
 Thu, 4 Jul 2024 09:32:41 +0200
From: Benjamin Hahn <B.Hahn@phytec.de>
To: Teresa Remmet <T.Remmet@phytec.de>, Fabio Estevam <festevam@gmail.com>,
 Tom Rini <trini@konsulko.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, PHYTEC Upstream
 <upstream@lists.phytec.de>
Subject: Re: [PATCH] configs: phycore-imx8mp: Disable CONFIG_ANDROID_BOOT_IMAGE
Thread-Topic: [PATCH] configs: phycore-imx8mp: Disable
 CONFIG_ANDROID_BOOT_IMAGE
Thread-Index: AQHazU7kRIunJVduVE62lZLYIEeo+7HmDI4A
Date: Thu, 4 Jul 2024 07:32:40 +0000
Message-ID: <3b6155ce-6ce8-4563-8282-905c827a3560@phytec.de>
References: <20240703-wip-bhahn-disable_config_android_boot_image-v1-1-d584437da4ff@phytec.de>
In-Reply-To: <20240703-wip-bhahn-disable_config_android_boot_image-v1-1-d584437da4ff@phytec.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.0.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <08A32164512B8147B452C2D63AA90E71@phytec.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDIsWRmVeSWpSXmKPExsWyRpKBR1cyoC3NoHeukMXDq/4WUydtZrd4
 u7eT3aL7nboDi8fOWXfZPV4dWMXucfbODkaP/u4W1gCWKC6blNSczLLUIn27BK6Me4/uMRb0
 cVdM2vqQvYHxBVcXIyeHhICJxJPpu5m7GLk4hASWMEms7V7NDJIQErjHKPFjLh+EvZ5RomUb
 L4jNJqAmsevNa1YQW0QgW+LEoy0sIDazQLzE5G2vGUFsYYFAiabuBhaImiCJHZcusXcxcgDZ
 RhIP/4qBhFkEVCRm3DzDBGLzCthIdN75yAKxKk5i7YpzYOM5gUYunNPLBmIzCshKbNhwnhli
 lbjEpmffWSHuF5BYsgciLiEgKvHy8T+ouLzEiVvTmEDWMgtoSqzfpQ9hWkis+eMAMUVRYkr3
 Q3aICwQlTs58wjKBUXwWkgWzEJpnITTPQtI8C0nzAkbWVYxCuZnJ2alFmdl6BRmVJanJeimp
 mxhBMSjCwLWDsW+OxyFGJg7GQ4wSHMxKIrxS75vThHhTEiurUovy44tKc1KLDzFKc7AoifOu
 7ghOFRJITyxJzU5NLUgtgskycXBKNTDyaxpZ82f+e9d1YX8106vksl+b/n3PPXGTn0nLYo1K
 mUGoqo67S/ecSUtXTDaNO/7tJt+9mVuUnt/nnC0ZyMf8lmlHnfhWrqV3jfcncfPLyAW3f52z
 zbVeLbdq49oGs/WF7w56PX7oI8p2Wojtc+ChpW+qAzcsWn6/cM0Uw1Mydrvc/V8fuzVPiaU4
 I9FQi7moOBEADzyvgK8CAAA=
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

SGVsbG8sDQpQbGVhc2UgZG8gbm90IGFwcGx5LiBXZSB3aWxsIGxlYXZlIHRoaXMgZmVhdHVyZSBl
bmFibGVkIGZvciBub3cuDQoNCkJlbmphbWluDQpPbiAwMy4wNy4yNCAxNTo0MiwgQmVuamFtaW4g
SGFobiB3cm90ZToNCj4gQ09ORklHX0FORFJPSURfQk9PVF9JTUFHRSBnZXRzIGVuYWJsZWQgaW1w
bGljaXRseSBieSBGQVNUQk9PVCwgYnV0IHdlDQo+IGRvbid0IG5lZWQgdGhhdCBmZWF0dXJlLg0K
Pg0KPiBTaWduZWQtb2ZmLWJ5OiBCZW5qYW1pbiBIYWhuIDxCLkhhaG5AcGh5dGVjLmRlPg0KPiAt
LS0NCj4gICBjb25maWdzL3BoeWNvcmUtaW14OG1wX2RlZmNvbmZpZyB8IDEgKw0KPiAgIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvY29uZmlncy9waHlj
b3JlLWlteDhtcF9kZWZjb25maWcgYi9jb25maWdzL3BoeWNvcmUtaW14OG1wX2RlZmNvbmZpZw0K
PiBpbmRleCA1N2UzMjBhZjYwMzAuLjI4MGViYzkyMzdlZSAxMDA2NDQNCj4gLS0tIGEvY29uZmln
cy9waHljb3JlLWlteDhtcF9kZWZjb25maWcNCj4gKysrIGIvY29uZmlncy9waHljb3JlLWlteDht
cF9kZWZjb25maWcNCj4gQEAgLTI1LDYgKzI1LDcgQEAgQ09ORklHX1NQTD15DQo+ICAgQ09ORklH
X0VOVl9PRkZTRVRfUkVEVU5EPTB4M2UwMDAwDQo+ICAgQ09ORklHX1NQTF9JTVhfUk9NQVBJX0xP
QURBRERSPTB4NDgwMDAwMDANCj4gICBDT05GSUdfU1lTX0xPQURfQUREUj0weDQwNDgwMDAwDQo+
ICsjIENPTkZJR19BTkRST0lEX0JPT1RfSU1BR0UgaXMgbm90IHNldA0KPiAgIENPTkZJR19GSVQ9
eQ0KPiAgIENPTkZJR19GSVRfRVhURVJOQUxfT0ZGU0VUPTB4MzAwMA0KPiAgIENPTkZJR19TUExf
TE9BRF9GSVQ9eQ0KPg0KPiAtLS0NCj4gYmFzZS1jb21taXQ6IDY1ZmJkYWIyNzIyNGVlMzk0M2E4
OTQ5NmIyMTg2MmRiODNjMzRkYTINCj4gY2hhbmdlLWlkOiAyMDI0MDcwMy13aXAtYmhhaG4tZGlz
YWJsZV9jb25maWdfYW5kcm9pZF9ib290X2ltYWdlLTMyNmVhMDkyMWEwMw0KPg0KPiBCZXN0IHJl
Z2FyZHMsDQoNCg0K
