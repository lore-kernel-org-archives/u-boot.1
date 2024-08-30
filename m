Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2292CA0FF1
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 13:23:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15A1B88BBC;
	Fri, 30 Aug 2024 15:23:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="Wk2JrFRK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BE3788BF9; Fri, 30 Aug 2024 15:23:45 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C22B88BCF
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 15:23:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=B.Hahn@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1725024223; x=1727616223;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gLAW3adIYANOgBLe2Odrggq9njXh20qcIYxRZqwJwzE=;
 b=Wk2JrFRK8d+mwqdJ4IHnM5Lkn+JB45tQjSSeOnMlKvbGI4ZHmc45beu9iA52of2k
 lPijhQgzWrgnEoeOdqb4oKGwXA9JRp6B3gm5T76D7ztfZL3zy4CCGZTar782bYwa
 znffc+Bh8jQTV8aFI/yyVt4/bh2h6jSrYuMmVk3rx8U=;
X-AuditID: ac14000a-03251700000021bc-b3-66d1c7de31af
Received: from florix.phytec.de (Unknown_Domain [172.25.0.13])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 91.F3.08636.ED7C1D66;
 Fri, 30 Aug 2024 15:23:42 +0200 (CEST)
Received: from Berlix.phytec.de (172.25.0.12) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Fri, 30 Aug
 2024 15:23:42 +0200
Received: from Berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4]) by
 berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4%4]) with mapi id 15.01.2507.006;
 Fri, 30 Aug 2024 15:23:42 +0200
From: Benjamin Hahn <B.Hahn@phytec.de>
To: Lukasz Majewski <lukma@denx.de>, Fabio Estevam <festevam@gmail.com>
CC: Teresa Remmet <T.Remmet@phytec.de>, Stefano Babic <sbabic@denx.de>,
 "uboot-imx@nxp.com" <uboot-imx@nxp.com>, Cem Tenruh <C.Tenruh@phytec.de>,
 "Tom Rini" <trini@konsulko.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, Yannic Moog <Y.Moog@phytec.de>
Subject: Re: [PATCH v2] config: imx: Define CFG_SYS_UBOOT_BASE for Phytec's
 imx8mm SoM QSPI boot
Thread-Topic: [PATCH v2] config: imx: Define CFG_SYS_UBOOT_BASE for Phytec's
 imx8mm SoM QSPI boot
Thread-Index: AQHa8xGkyD16oF/ixkOlEYvHo56qSLI7W+4AgADbqQCAA4BoAA==
Date: Fri, 30 Aug 2024 13:23:42 +0000
Message-ID: <dbf9bf5e-b96b-4e34-816c-215e68289526@phytec.de>
References: <20240820145944.3048128-1-lukma@denx.de>
 <CAOMZO5AAfn7zw1+VEGjdS6UAQLv5kTVT97_dy_oxhauntYeHvQ@mail.gmail.com>
 <20240828095520.76f904bc@wsk>
In-Reply-To: <20240828095520.76f904bc@wsk>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.0.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B3A7CF7C99DF6F408EBDC9DF41372C80@phytec.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPIsWRmVeSWpSXmKPExsWyRpKBV/fe8YtpBkdO2Vg8vOpv8fzdZSaL
 9lM+FlMnbWa3eLu3k91iyuP17A5sHvNmnWDx2DnrLrvHqwOr2D3O3tnB6LHx3Q6mANYoLpuU
 1JzMstQifbsEroy58++wFuwRrtg8ja2B8Y9QFyMnh4SAicTz983MXYxcHEICS5gkrvz8wwbh
 3GeUuL5iNTtIlZDABkaJCRvyQWw2ATWJXW9es4LYIgLuEosOrmYBaWAWaGOS6Nn1AiwhLJAk
 8XzhTmaIomSJtSsfQDU4SRz//Y0FxGYRUJVomNTEBmLzCthILDn9kQVi2WxGiekvOEBsTgEt
 iZZtB8BqGAVkJTZsOA82k1lAXGLTs++sEC8ISCzZAxGXEBCVePn4H1RcXuLErWlMXYwcQPWa
 Eut36UO0WkhMujKREcJWlJjS/ZAd4gRBiZMzn7BMYBSfhWTDLITuWUi6ZyHpnoWkewEj6ypG
 odzM5OzUosxsvYKMypLUZL2U1E2MoEgVYeDawdg3x+MQIxMH4yFGCQ5mJRHepXsupgnxpiRW
 VqUW5ccXleakFh9ilOZgURLnXd0RnCokkJ5YkpqdmlqQWgSTZeLglGpgFM/d+ajt+Wqh2Iys
 68aqe6UuPMvVsT1sl1jx3v1b4HlDxUsPuPk9DFeaJ5fPOG/+do5E09zej3ufRZ8Kvtcce0bI
 QEBY8tBfrvhXWktPBdaxF63R0+/fc2d17Oflv0VS7X973lcvOcromfj9adsZBbvueR+zXFfe
 8TzyoOLpLnudJ6/6m9dsUGIpzkg01GIuKk4EAGE+d7HCAgAA
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

SGkgTHVrYXN6LA0KDQpPbiAyOC4wOC4yNCAwOTo1NSwgTHVrYXN6IE1hamV3c2tpIHdyb3RlOg0K
PiBIaSBGYWJpbywNCj4NCj4+IEhpIEx1a2FzeiwNCj4+DQo+PiBPbiBUdWUsIEF1ZyAyMCwgMjAy
NCBhdCAxMjowMOKAr1BNIEx1a2FzeiBNYWpld3NraSA8bHVrbWFAZGVueC5kZT4NCj4+IHdyb3Rl
Og0KPj4+IFRoZSBpbWFnZSBvZmZzZXQgd2hlbiBib290aW5nIGZyb20gU1BJLU5PUiAoUVNQSSwg
RlNQSSBkcml2ZXIpIGlzDQo+Pj4gZGlmZmVyZW50IHRoYW4gb25lIGZvciBTRCBjYXJkIC8gZU1N
QyBhcyBleHRyYSBzcGFjZSAoMHgxMDAwKSBpcw0KPj4+IGNvbnN1bWVkIGJ5IEZTUEkgY29uZmln
dXJhdGlvbiBoZWFkZXIgKENPTkZJR19GU1BJX0NPTkZfSEVBREVSKS4NCj4+Pg0KPj4+IFNpZ25l
ZC1vZmYtYnk6IEx1a2FzeiBNYWpld3NraSA8bHVrbWFAZGVueC5kZT4NCj4+PiAtLS0NCj4+PiBD
aGFuZ2VzIGZvciB2MjoNCj4+PiAtIEF2b2lkIGxpbmUgYnJlYWtzIHdpdGggZGVmaW5lcw0KPj4g
IEZyb20gdGhlIG90aGVyIHRocmVhZCwgbXkgdW5kZXJzdGFuZGluZyBpcyB0aGF0IFFTUEkgYm9v
dCBpcyBzdGlsbCBub3QNCj4+IHdvcmtpbmcgd2l0aCB0aGlzIHBhdGNoIGFwcGxpZWQuDQo+Pg0K
PiBCdXQgdGhpcyBpcyBhbiBvcnRob2dvbmFsIHByb2JsZW0gLSB0aGUgcHJvYmxlbSBpcyB3aXRo
IGJpbm1hbiBpbWFnZQ0KPiBnZW5lcmF0aW9uLg0KPg0KPiBUaGlzIHBhdGNoIGZvbGxvd3MgdGhl
IGNvZGUgYWxyZWFkeSBwcmVzZW50IGluIGUuZy4gaW14OG1tX2JlYWNvbioNCj4gYm9hcmRzLg0K
Pg0KPj4gUGxlYXNlIHJlc2VuZCB0aGlzIHBhdGNoIHdoZW4gdGhlIFFTUEkgYm9vdCBwcm9ibGVt
IGlzIHJlc29sdmVkLg0KPj4NCj4gQXMgSSd2ZSB3cml0dGVuIGFib3ZlIC0gcHJvYmxlbSBpcyBz
b2xlbHkgd2l0aCBiaW5tYW4gY29kZSBnZW5lcmF0aW9uIC0NCj4gYWZ0ZXIgcmV2ZXJ0aW5nIDMg
bGFzdCBjb21taXRzIGZyb20gaW14OG1tLXUtYm9vdC5kdHNpIHRoZSBpbWFnZSBpcw0KPiBjb3Jy
ZWN0bHkgZ2VuZXJhdGVkLg0KDQpJIGNhbiBhbHNvIHNlZSB0aGlzLiBXaGVuIEkgYXBwbHkgYWxs
IHlvdXIgcGF0Y2hlcyBhbmQgcmV2ZXJ0IHRob3NlIDMgDQpjb21taXRzLCBTRFAgYm9vdCB2aWEg
dXV1IGFuZCBmbGFzaGluZyBTUEkgTk9SIGZsYXNoIHdpdGggdGhlIHFzcGkgSW1hZ2UgDQp3b3Jr
cy4gQW5kIHRoZW4gYWxzbyBTUEkgYm9vdCB3b3Jrcy4NCldoZW4gSSBkb24ndCByZXZlcnQgdGhl
IDMgY29tbWl0LCBpdCBkb2VzIG5vdCB3b3JrLiAoU0RQIGJvb3QgdmlhIHV1dSANCmRvZXMgbm90
IHdvcmsgYW5kIHRoZSBJbWFnZSBkb2VzIG5vdCBib290IHdoZW4gZmxhc2hlZCBpbnRvIFNQSSBO
T1IgZmxhc2gpLg0KDQpJIGhhdmVuJ3QgaW52ZXN0aWdhdGVkIHdoYXQgdGhlIHByb2JsZW0gaXMg
b3IgaG93IGl0IGNhbiBiZSBmaXhlZCANCnRob3VnaC4gU28gSSBndWVzcyBmdXJ0aGVyIGludmVz
dGlnYXRpb24gaXMgbmVlZGVkIGhlcmUuDQoNCkJlbmphbWluDQoNCj4NCj4+IFRoYW5rcw0KPg0K
Pg0KPg0KPiBCZXN0IHJlZ2FyZHMsDQo+DQo+IEx1a2FzeiBNYWpld3NraQ0KPg0KPiAtLQ0KPg0K
PiBERU5YIFNvZnR3YXJlIEVuZ2luZWVyaW5nIEdtYkgsICAgICAgTWFuYWdpbmcgRGlyZWN0b3I6
IEVyaWthIFVudGVyDQo+IEhSQiAxNjUyMzUgTXVuaWNoLCBPZmZpY2U6IEtpcmNoZW5zdHIuNSwg
RC04MjE5NCBHcm9lYmVuemVsbCwgR2VybWFueQ0KPiBQaG9uZTogKCs0OSktODE0Mi02Njk4OS01
OSBGYXg6ICgrNDkpLTgxNDItNjY5ODktODAgRW1haWw6IGx1a21hQGRlbnguZGUNCg0KDQo=
