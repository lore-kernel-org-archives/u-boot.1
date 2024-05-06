Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E054AC10F16
	for <u-boot@archiver.kernel.org>; Mon,  6 May 2024 10:52:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EE4188052;
	Mon,  6 May 2024 12:52:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="d/5wKnES";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B33087ED3; Mon,  6 May 2024 12:52:22 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 698C987ED3
 for <u-boot@lists.denx.de>; Mon,  6 May 2024 12:52:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=B.Hahn@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1714992740; x=1717584740;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8GqLW/DINun/wbmAPVikcHX5N3RENyiFvKRe9BpHLT8=;
 b=d/5wKnESDim9aq2JyZXQ6yQndasE3yJKYrsTyfN/g4N44CmSpe5/ptwA2Lf2UExw
 3bjVBerLUN2hB6JmEFEhQoQ6KOEfn/OQGr07xDRZZV8TBJ+//xPSSOBJYvXUkLiF
 OxxQUnMudsgjIyD8xCKizk7kZGi+UmQTQSgx5HbJPEc=;
X-AuditID: ac14000a-fadff7000000290d-98-6638b663cf7e
Received: from florix.phytec.de (Unknown_Domain [172.25.0.13])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id EC.22.10509.366B8366;
 Mon,  6 May 2024 12:52:19 +0200 (CEST)
Received: from Berlix.phytec.de (172.25.0.12) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 6 May 2024
 12:52:19 +0200
Received: from Berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4]) by
 berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4%4]) with mapi id 15.01.2507.006;
 Mon, 6 May 2024 12:52:19 +0200
From: Benjamin Hahn <B.Hahn@phytec.de>
To: Fabio Estevam <festevam@gmail.com>
CC: Teresa Remmet <T.Remmet@phytec.de>, Yannic Moog <Y.Moog@phytec.de>, "Tom
 Rini" <trini@konsulko.com>, Wadim Egorov <W.Egorov@phytec.de>, Martyn Welch
 <martyn.welch@collabora.com>, Parthiban Nallathambi <parthitce@gmail.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "upstream@lists.phytec.de"
 <upstream@lists.phytec.de>
Subject: Re: [PATCH] configs: Make USB_GADGET_MANUFACTURER consistent over all
 PHYTEC boards
Thread-Topic: [PATCH] configs: Make USB_GADGET_MANUFACTURER consistent over
 all PHYTEC boards
Thread-Index: AQHanSeq7kZAln2bwk2JGFwh6kmZqrGFU3sAgASXnYA=
Date: Mon, 6 May 2024 10:52:19 +0000
Message-ID: <a4808081-9ae8-4556-ba5e-651e5b035c6c@phytec.de>
References: <20240503-wip-bhahn-bspimx8m-3196-v1-1-855c7242151f@phytec.de>
 <CAOMZO5DgBF7ULn4Cp7VA0c29A5TKiJrxwoBEXSbYPu-9M4nzJw@mail.gmail.com>
In-Reply-To: <CAOMZO5DgBF7ULn4Cp7VA0c29A5TKiJrxwoBEXSbYPu-9M4nzJw@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.0.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <D5DD1FDB0E508E4A963DAEA2736DD449@phytec.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLIsWRmVeSWpSXmKPExsWyRpKBVzd5m0WawdwNJhYPr/pbPLjYxWJx
 Zu0pFoupkzazW7zd28lu0f1O3YHNY8fdJYweO2fdZfd4dWAVu8fZOzsYPfq7W1gDWKO4bFJS
 czLLUov07RK4Mibu9Cn4xVHR8vsdWwPjHY4uRg4OCQETiQXPs7sYuTiEBJYwSRxsu8MC4dxj
 lDgzpZsVwlnPKLH7RSNQhpODTUBNYteb16wg3SJA9ul5+iBhZoELTBKv1guC2MICcRJnm9vZ
 QGwRgXiJx72nmCDKrSQWvXcCCbMIqEgsuPafGcTmFbCR2PBlPhPEqomMEr8nrQJLcAoEAo28
 B2YzCshKbNhwnhlil7jEpmffWUFsCQEBiSV7IOISAqISLx//g4rLS5y4NQ1sL7OApsT6XVBn
 WkisvniREcJWlJjS/ZAd4gZBiZMzn7BMYBSfhWTDLITuWUi6ZyHpnoWkewEj6ypGodzM5OzU
 osxsvYKMypLUZL2U1E2MoCgVYeDawdg3x+MQIxMH4yFGCQ5mJRHeo+3maUK8KYmVValF+fFF
 pTmpxYcYpTlYlMR5V3cEpwoJpCeWpGanphakFsFkmTg4pRoYNzl88k7/XXTiPP/NSVYqoiek
 Atd8M+baU1Z4/SP/gxJ539ex30q2W974tOnRjLMXHuzR/7VwruyeWv/D95IWrV5omXLxZ0yy
 gAwnu/pu6XDrt5qFbn7TTKJdV3Q/kZmX8Cd/piULf4LNf3s+jsXzNc9Oqi697lVopDmZo7dO
 0aJ3/bP5i3Z3KLEUZyQaajEXFScCAFm6JTbAAgAA
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

SGkgRmFiaW8sDQoNCk9uIDAzLjA1LjI0IDE0OjQ0LCBGYWJpbyBFc3RldmFtIHdyb3RlOg0KPiBI
aSBCZW5qYW1pbiwNCj4NCj4gT24gRnJpLCBNYXkgMywgMjAyNCBhdCA0OjAx4oCvQU0gQmVuamFt
aW4gSGFobiA8Qi5IYWhuQHBoeXRlYy5kZT4gd3JvdGU6DQo+DQo+PiAtQ09ORklHX1VTQl9HQURH
RVRfTUFOVUZBQ1RVUkVSPSJGU0wiDQo+PiArQ09ORklHX1VTQl9HQURHRVRfTUFOVUZBQ1RVUkVS
PSJQSFlURUMiDQo+PiAgIENPTkZJR19VU0JfR0FER0VUX1ZFTkRPUl9OVU09MHgwNTI1DQo+PiAg
IENPTkZJR19VU0JfR0FER0VUX1BST0RVQ1RfTlVNPTB4YTRhNQ0KPiAuLi4NCj4+IC1DT05GSUdf
VVNCX0dBREdFVF9NQU5VRkFDVFVSRVI9IlRleGFzIEluc3RydW1lbnRzIg0KPj4gK0NPTkZJR19V
U0JfR0FER0VUX01BTlVGQUNUVVJFUj0iUEhZVEVDIg0KPj4gICBDT05GSUdfVVNCX0dBREdFVF9W
RU5ET1JfTlVNPTB4MDQ1MQ0KPj4gICBDT05GSUdfVVNCX0dBREdFVF9QUk9EVUNUX05VTT0weDYx
NjUNCj4gV2hhdCBhYm91dCBtYWtpbmcgVkVORE9SX05VTS9QUk9EVUNUX05VTSBjb25zaXN0ZW50
IGFzIHdlbGw/DQoNCldlIGFyZSBub3QgcmVnaXN0ZXJlZCBhdCBVU0ItSUYgYW5kIHRoZXJlZm9y
ZSBkb24ndCBoYXZlIGEgdmFsaWQgDQpWRU5ET1JfTlVNIGFuZCBQUk9EVUNUX05VTSwgc28gd2Ug
cmVseSBvbiB0aGUgVkVORE9SX05VTSBhbmQgUFJPRFVDVF9OVU0gDQpvZiB0aGUgU29DIFZlbmRv
ciwgc28gdGhlIGNvcnJlY3QgZmVhdHVyZXMgZ2V0IGVuYWJsZWQgYnkgdGhlIGRyaXZlci4NCg0K
V2l0aCBraW5kIHJlZ2FyZHMsDQoNCkJlbmphbWluIEhhaG4NCg0K
