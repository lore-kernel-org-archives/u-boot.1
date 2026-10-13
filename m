Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 457D2CA9ED0
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 05:47:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 68C0760745;
	Tue, 13 Oct 2026 05:47:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f0t6gPnuhnsu; Tue, 13 Oct 2026 05:47:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 53E7E60629
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791870461;
	b=Al6z5DP5OYIxYivFgCj1jQwjcht7S7T4XJifJqxYZMe9ZggGTPOOgy7uo0T3BP6yf2Xr
	 8+aOzosf/QYGGnBpeaMERhg82pS+XZ5WC1iFO92bbwkMemthkNOFFal94bvFnZSqxHjHY
	 i1aqNZoz0cXOXJKfKuPVsQdtuS4RYkq8sabpFd8PbuA2sF7xfN9AowRMxOsXvLjjzp6yS
	 kOz+Ha/MIsK1IqWgSqK+k8daTHBxLk+1x6ydSOZPpbX8mhh9/4VnSyZDmd//qyhPYSM0j
	 ITocB1X1qTNpcuFJGDbuaOREhkKpXTM0LdxGaNv6ThTPnIeVmBD0UcV2rox1ijhYi2g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791870461;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:From:To:CC:
	 Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
	 In-Reply-To:Accept-Language:Content-Language:X-MS-Has-Attach:
	 X-MS-TNEF-Correlator:x-originating-ip:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=BvOnH47IjQR3HEwIQnqyx0mA5DXt/akkyfWqofD04H0=;
	b=chr48RRxTcfVFba1mU+T8diu1ALroOTmyLuq8eFjUfi/+3OgIikH6XBzbScwu/4K2TZ8
	 pBN0g5AYDkqH8KrfHJXL/sGSSsKnl/NpycpHPD8dskSbRQuoQt1ozN8U3ZbYsloolxq/F
	 0wxkGc6FCGjbdLVGee16b8KaGjQQJEFEEw7FU1SxasvzpmWf3ZoDtTnn839GtEw6LU0jz
	 SWVWPI8dkzYcFuzGVwg6K1VnRCVZ8ZzGHapLIt+GjJ2xaSHtKXTRNpn7/GHMPSF/F8dWa
	 AclySKC1Q3izGo+nnoLK0WYid1xn/DKSZlMot5kcfxM998diVMiswZ0UzaZJRX/S78Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=infineon.com;
	dkim=pass header.d=infineon.com header.i=@infineon.com header.a=rsa-sha256 header.s=IFXMAIL header.b=mGYU09ro;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791870461;
	bh=BvOnH47IjQR3HEwIQnqyx0mA5DXt/akkyfWqofD04H0=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VB16jiMipd5ZHIYmYqJfPSx2EKpNF/24GMFVLh9gNajCXbp3w3ai1NzXz85RH0lau
	 xIL/jtRXSrlFoUIlEaGSG/qVJGUK2aSPwNZDTpvQsbM2qr/yh/KriSbouI2UbV9VkG
	 yJJP1RJzHlSd+lJFK0gKkozl/gEIA9XzoeeyQlKd5ioEZ+f5npbE4ucPlVuJ2+6jUR
	 ue3vup+15w5+jFi+KCbSD6qsTtMldF+WD57oSTOkD3kW71TQa0QMcQKdqyhmNN5clf
	 v4U8wXaAXPLLr7/5uZk2cdXD01WcdjcpQkQjc+1KhiZcR0kna+6ejpwXg3xc+frkdH
	 gL2R4mIfIuO+w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 53E7E60629;
	Tue, 13 Oct 2026 05:47:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 24361362
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 01:20:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 20CBE605E8
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 01:20:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KSjakfxQH3Eo for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 01:20:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B737F600C4
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:18f0:1e00:4::4"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791854412;
 b=pjeJXfnizxOiKUrqGy6wXNfW3eDkH4a5Untf7HuViLU3dKhoyUusa0Cpe4O2tB1TVRTB
 JpB2/JiMOaNUOeylR9JMwOMs6tDJQt0ipvkcOHR7DRkRhRkWMQhvrgEArUNriWaQIFbYO
 GQ8rYCEjMw2cYp2u+vqnvxGupar4o0L4WO03xDBf8bKIZvNPZqBu06DSEiLV0snexlYkH
 VHkm+q3rMhKGKBIQxbV/KyRXmleQVq42xmuqUlbOX4V1akZdDReemhPzni5CF3zhKONKp
 wa+DS2e99FMdvCOy6lkDjtiXaeWWT+kLoRs4WXD3py87nesvhq70NlNuOZ+zKt+fWOg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791854412;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:X-Amp-Result:Received:Received:Received:
 From:To:CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:
 References:In-Reply-To:Accept-Language:Content-Language:
 X-MS-Has-Attach:X-MS-TNEF-Correlator:x-originating-ip:Content-Type:
 Content-Transfer-Encoding:MIME-Version;
 bh=BvOnH47IjQR3HEwIQnqyx0mA5DXt/akkyfWqofD04H0=;
 b=UzmkOEpxfPOHDLj3/5BWrPq8B78589R2+LkfSENMQDZ8yZYV1ntSJ4tg1mnQO7k795ck
 +cejyySyikMZk47tKzzhHCPJC7UF0f1hXGa/jXwz0NBc/SNSE/8XDn7ljuKx4kYC1l/Ca
 5j1e7GKx1cEpVpk7+Nqmvu6GQD2PLIA6OAEIbuhd9nsoNNFRrlg5Cgqjad81Q6eJhXkjQ
 l8BkSOK/K+shq7XTxRbWy07R0C0AuSQPhFowbml7R8h8TvQbTsdHmD5VFmVD6HiO3/aay
 +6eg+ckbV3jL3tzD9GoQ0ckPEjIOgEnuHo+kSzuhp5bN7NInLDNosmRon0UMXx9M6Jw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=infineon.com;
 dkim=pass header.d=infineon.com header.i=@infineon.com header.a=rsa-sha256
 header.s=IFXMAIL header.b=mGYU09ro; 
 arc=none smtp.remote-ip="2a00:18f0:1e00:4::4"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:18f0:1e00:4::4;
 helo=smtp2.infineon.com; envelope-from=takahiro.kuwano@infineon.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=infineon.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=infineon.com header.i=@infineon.com header.a=rsa-sha256
 header.s=IFXMAIL header.b=mGYU09ro
Received: from smtp2.infineon.com (smtp2.infineon.com
 [IPv6:2a00:18f0:1e00:4::4])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B737F600C4
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 01:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
 t=1791854412; x=1823390412;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=BvOnH47IjQR3HEwIQnqyx0mA5DXt/akkyfWqofD04H0=;
 b=mGYU09ro9xuuR9FPqYmGULkZmo6kcSvGKUps9FXm7aQwDf66QnR/D2iv
 Z39sJ7M3GJ8MmmMJGtz2yl2G0gLb0/FnQ0juNtcZS1ZzSiMIteUO0e8IB
 x0y2d/6ccnkQVTRAlp0HPSKBqwAjerMtzCH/XrS878Q5yLhQGiu24W9bA 8=;
X-CSE-ConnectionGUID: E+H6Mw7ITKiNTfqbc6Kpfg==
X-CSE-MsgGUID: R16wPj9jQ52INXe+7RIPOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="183510723"
X-IronPort-AV: E=Sophos;i="6.27,154,1787004000"; d="scan'208";a="183510723"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE814.infineon.com) ([172.23.29.40])
 by smtp2.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2026 03:20:08 +0200
Received: from MUCSE815.infineon.com (172.23.29.41) by MUCSE814.infineon.com
 (172.23.29.40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 03:20:07 +0200
Received: from MUCSE815.infineon.com ([fe80::b54c:c0bd:546c:c9be]) by
 MUCSE815.infineon.com ([fe80::b54c:c0bd:546c:c9be%12]) with mapi id
 15.02.2562.053; Tue, 13 Oct 2026 03:20:07 +0200
From: <Takahiro.Kuwano@infineon.com>
To: <hs@nabladev.com>, <sjg@chromium.org>
CC: <u-boot@lists.u-boot-project.org>, <marek.vasut+renesas@mailbox.org>,
 <vigneshr@ti.com>, <jbx6244@gmail.com>, <stefan.bigler@securiton.ch>,
 <quentin.schulz@cherry.de>, <trini@konsulko.com>, <vjardin@free.fr>,
 <kilicyasirahmet@gmail.com>
Subject: RE: [PATCH v2 3/5] mtd: add driver for the Microchip 23LCV1024 SPI
 SRAM
Thread-Topic: [PATCH v2 3/5] mtd: add driver for the Microchip 23LCV1024 SPI
 SRAM
Thread-Index: AQHdU7XVNeLYzJhL60yx5+hOYpVsKLb0sI0AgAAyPFD///VzAIAFsXIAgAAqLWA=
Date: Tue, 13 Oct 2026 01:20:07 +0000
Message-ID: <18b0ae1aac0f4539b94b0a5b914c3329@infineon.com>
References: <20261004040657.3156402-1-hs@nabladev.com>
 <20261004040657.3156402-4-hs@nabladev.com>
 <CAFLszThGYtvGYmYi1iOjRiqBANzbNSOt00n1HHzOWX8GXw3P0A@mail.gmail.com>
 <e66df57a82424e6d9b1fe8e2e5b7041f@infineon.com>
 <d19b3b84-86fe-4f46-a9f3-95bb18b20d13@nabladev.com>
 <702923f8-7957-c8e1-0c02-1663240740b5@nabladev.com>
In-Reply-To: <702923f8-7957-c8e1-0c02-1663240740b5@nabladev.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.161.6.196]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 13 Oct 2026 05:47:40 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

SGkgSGVpa28sDQoNCj4gSGkgVGFrYWhpcm8uS3V3YW5vLA0KPiANCj4gT24gMDkuMTAuMjYgMTE6
MjgsIEhlaWtvIFNjaG9jaGVyIHdyb3RlOg0KPiA+IEhlbGxvIFRha2FoaXJvLkt1d2FubywNCj4g
Pg0KPiA+IGp1c3QgYW5zd2VyIGhlcmUsIGJlZm9yZSBJIGxvb2tlZCBpbnRvIHRoZSBjb21tZW50
cyBmcm9tIFNpbW9uLi4uDQo+ID4NCj4gPiBPbiAwOS4xMC4yNiAxMDoyOSwgVGFrYWhpcm8uS3V3
YW5vQGluZmluZW9uLmNvbSB3cm90ZToNCj4gPj4gSGkgSGVpa28gYW5kIFNpbW9uLA0KPiA+Pg0K
PiA+Pj4gSGkgSGVpa28sDQo+ID4+Pg0KPiA+Pj4gT24gMjAyNi0xMC0wNFQwNDowNjo0NCwgSGVp
a28gU2Nob2NoZXIgPGhzQG5hYmxhZGV2LmNvbT4gd3JvdGU6DQo+ID4+Pj4gbXRkOiBhZGQgZHJp
dmVyIGZvciB0aGUgTWljcm9jaGlwIDIzTENWMTAyNCBTUEkgU1JBTQ0KPiA+Pj4+DQo+ID4+Pj4g
VGhlIDIzTENWMTAyNCBpcyBhIDEgTWJpdCBzZXJpYWwgU1JBTSB3aXRoIGJhdHRlcnkgYmFja3Vw
LCBzaXR0aW5nIG9uDQo+ID4+Pj4gYW4gU1BJIGJ1cyBhbmQgdXNlZCBhcyBub24gdm9sYXRpbGUg
c2NyYXRjaCBzdG9yYWdlLiBSZWdpc3RlciBpdCBhcyBhbg0KPiA+Pj4+IE1URCBkZXZpY2Ugb2Yg
dHlwZSBNVERfUkFNLCBzbyB0aGUgbXRkIGNvbW1hbmQgcmVhY2hlcyBpdC4NCj4gPj4+Pg0KPiA+
Pj4+IFRoZSBkZXZpY2UgcG93ZXJzIHVwIGluIGJ5dGUgb3BlcmF0aW9uLCB3aGVyZSBldmVyeSBj
b21tYW5kIGNhcnJpZXMNCj4gPj4+PiBleGFjdGx5IG9uZSBkYXRhIGJ5dGUuIFNlbGVjdCBzZXF1
ZW50aWFsIG9wZXJhdGlvbiBvbmNlIGR1cmluZyBwcm9iZSwNCj4gPj4+DQo+ID4+PiBKdXN0IHRv
IGNoZWNrLCBpcyB0aGlzIHJpZ2h0PyBNeSB1bmRlcnN0YW5kaW5nIGlzIHRoYXQgdGhlDQo+ID4+
PiAyM0xDMTAyNC8yM0xDVjEwMjQgZGF0YSBzaGVldCBnaXZlcyBzZXF1ZW50aWFsIG1vZGUgKDAx
KSBhcyB0aGUgTU9ERQ0KPiA+Pj4gcmVnaXN0ZXIgZGVmYXVsdDsgYnl0ZSBtb2RlIGlzIHRoZSBk
ZWZhdWx0IG9ubHkgb24gdGhlIG9sZGVyIDIzSzI1Ni4NCj4gPj4+IFRoZSBMaW51eCBtY2hwMjNr
MjU2IGRyaXZlciBuZXZlciB3cml0ZXMgdGhlIE1PREUgcmVnaXN0ZXIuIFNldHRpbmcgaXQNCj4g
Pj4+IGV4cGxpY2l0bHkgaXMgc3RpbGwgYSBmaW5lIGRlZmVuc2l2ZSBzdGVwLCBzaW5jZSBzb21l
dGhpbmcgZWxzZSBjb3VsZA0KPiA+Pj4gaGF2ZSBjaGFuZ2VkIHRoZSBtb2RlIGFuZCB0aGUgcGFy
dCBrZWVwcyBpdCB3aGlsZSBvbiBiYXR0ZXJ5LiBQbGVhc2UNCj4gPj4+IGNhbiB5b3UgcmV3b3Jk
IHRoZSBjb21taXQgbWVzc2FnZSBhbmQgdGhlIGNvbW1lbnQgaW4gc3BpX3JhbV9wcm9iZSgpDQo+
ID4+PiB0byBtYXRjaD8NCj4gPj4+DQo+ID4+Pj4gc28gdGhhdCBhIHJlYWQgb3IgYSB3cml0ZSBv
ZiBhbnkgbGVuZ3RoIGlzIHNlcnZlZCBieSBhIHNpbmdsZSBjb21tYW5kDQo+ID4+Pj4gYW5kIHRo
ZSBidXMgaXMgY2xhaW1lZCBvbmNlIHBlciB0cmFuc2Zlci4NCj4gPj4+Pg0KPiA+Pj4+IFdyaXRp
bmcgbmVlZHMgbm8gZXJhc2UuIFRoZSBkcml2ZXIgdGhlcmVmb3JlIGltcGxlbWVudHMgbm8gZXJh
c2UNCj4gPj4+PiBvcGVyYXRpb24gYW5kIHNheXMgTVREX05PX0VSQVNFIGluIHRoZSBNVEQgZmxh
Z3MuDQo+ID4+Pj4NCj4gPj4+PiBTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gQmlnbGVyIDxzdGVmYW4u
YmlnbGVyQHNlY3VyaXRvbi5jaD4NCj4gPj4+PiBTaWduZWQtb2ZmLWJ5OiBIZWlrbyBTY2hvY2hl
ciA8aHNAbmFibGFkZXYuY29tPg0KPiA+Pj4+DQo+ID4+Pj4gTUFJTlRBSU5FUlMgICAgICAgICAg
ICAgICB8wqDCoCA1ICsrDQo+ID4+Pj4gICBjb25maWdzL3NhbmRib3hfZGVmY29uZmlnIHzCoMKg
IDEgKw0KPiA+Pj4+ICAgZHJpdmVycy9tdGQvS2NvbmZpZyAgICAgICB8wqAgMTQgKysrDQo+ID4+
Pj4gICBkcml2ZXJzL210ZC9NYWtlZmlsZSAgICAgIHzCoMKgIDEgKw0KPiA+Pj4+ICAgZHJpdmVy
cy9tdGQvc3BpX3JhbS5jICAgICB8IDIyMiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrDQo+ID4+Pj4gICA1IGZpbGVzIGNoYW5nZWQsIDI0MyBpbnNlcnRpb25z
KCspDQo+ID4+Pg0KPiA+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9LY29uZmlnIGIvZHJp
dmVycy9tdGQvS2NvbmZpZw0KPiA+Pj4+IEBAIC0xOTQsNiArMTk0LDIwIEBAIGNvbmZpZyBBTFRF
UkFfUVNQSQ0KPiA+Pj4+ICtjb25maWcgU1BJX1JBTQ0KPiA+Pj4+ICsgICAgIGJvb2wgIk1pY3Jv
Y2hpcCAyM0xDVjEwMjQgU1BJIFNSQU0iDQo+ID4+Pj4gKyAgICAgZGVwZW5kcyBvbiBETV9TUEkg
JiYgRE1fTVREDQo+ID4+Pg0KPiA+Pj4gU1BJX1JBTSwgc3BpX3JhbS5jIGFuZCB0aGUgc3BpX3Jh
bSBkcml2ZXIgbmFtZSBhcmUgdmVyeSBnZW5lcmljIGZvciBhDQo+ID4+PiBkcml2ZXIgdGhhdCBo
YW5kbGVzIG9uZSBNaWNyb2NoaXAgcGFydC4gTGludXggYWxyZWFkeSBzdXBwb3J0cyB0aGlzDQo+
ID4+PiBjaGlwIGluIGRyaXZlcnMvbXRkL2RldmljZXMvbWNocDIzazI1Ni5jIChDT05GSUdfTVRE
X01DSFAyM0syNTYpLCBhbmQNCj4gPj4+IHRoZSBiaW5kaW5nIGluIGR0cy91cHN0cmVhbS9CaW5k
aW5ncy9tdGQvbWljcm9jaGlwLG1jaHAyM2syNTYueWFtbA0KPiA+Pj4gbGlzdHMgYm90aCBtaWNy
b2NoaXAsbWNocDIzazI1NiBhbmQgbWljcm9jaGlwLG1jaHAyM2xjdjEwMjQuIEhvdyBhYm91dA0K
PiA+Pj4gdXNpbmcgdGhlIExpbnV4IG5hbWVzLCBoZXJlIGFuZCBpbiBNQUlOVEFJTkVSUz8NCj4g
Pj4+DQo+ID4+DQo+ID4+IEkgd291bGQgcmF0aGVyIGhhdmUgYSBnZW5lcmljIFNQSS1SQU0gZHJp
dmVyIHRoYXQgYWxzbyBzdXBwb3J0cyBNUkFNIFsxXQ0KPiA+PiBhbmQgRlJBTSBkZXZpY2VzIHVz
aW5nIHRoZSBjb21tb24gb3Bjb2RlIHNldCB3aXRob3V0IGVyYXNlLg0KPiA+Pg0KPiA+PiBDdXJy
ZW50bHksIHNvbWUgRlJBTSBjaGlwcyBhcmUgaGFuZGxlZCBieSBTUEktTk9SLCBidXQgbmV3IGRl
dmljZXMgc2hvdWxkDQo+ID4+IGJlIGFkZGVkIHRvIHRoZSBTUEktUkFNIGRyaXZlciBpZiBpdCBl
eGlzdHMuDQo+ID4+DQo+ID4+IFdoYXQgYXJlIHlvdXIgdGhvdWdodHMgb24gdGhpcz8NCj4gPg0K
PiA+IFNlZW1zIGxpa2UgYSB2YWxpZCBhcmd1bWVudCB0byBtZS4gU2ltb24/IFdoYXQgZG8geW91
IHRoaW5rPw0KPiANCj4gQWZ0ZXIgbG9va2luZyBpbnRvIHBhdGNoZXMgZnJvbSBZYXNpciAoYWRk
ZWQgdG8gY2MpLiB0aGUgRlJBTQ0KPiBjYXNlIGlzIGRpZmZlcmVudC4gVGhlIEZSQU0gKGF0IGxl
YXN0IHRoZSBvbmUgWWFzaXIgYWRkcykgaGFzIGEgSkVERUMNCj4gaW50ZXJmYWNlLCB0aGUgMjNM
Q1YxMDI0IGhhcyBub3QhIFNvIDIzTENWMTAyNCBpcyByZWFsbHkgc3BlY2lhbCwgYW5kIEkNCj4g
Y3VycmVudGx5IHRlbmQgdG8gc2F5LCB0aGF0IFNpbW9uIGlzIGNvcnJlY3QsIHRoYXQgd2Ugc2hv
dWxkIG5hbWUNCj4gdGhlIDIzTENWMTAyNCBkcml2ZXIgZHJpdmVycy9tdGQvZGV2aWNlcy9tY2hw
MjNrMjU2LmMuDQoNClRoZSBNUkFNIChub3QgRlJBTSkgcGFydCBkb2Vzbid0IHN1cHBvcnQgUmVh
ZCBJRCAoSkVERUMgSUQpIGNvbW1hbmQuIFlhc2lyDQptZW50aW9ucyB0aGF0IGluIHRoZSBjb21t
aXQgZGVzY3JpcHRpb24gYW5kIEkgY2hlY2tlZCBkYXRhc2hlZXQgWzFdLg0KV2h5IGRpZCB5b3Ug
Z2V0IGl0IGhhcyBhIEpFREVDIGludGVyZmFjZT8NCg0KVGhhbmtzLA0KVGFrYWhpcm8NCg0KWzFd
IGh0dHBzOi8vd3d3Lm1vdXNlci5jb20vZGF0YXNoZWV0LzIvMTQ0L0VTVF9NUjI1SDQwX3Byb2Qt
MjU3OC5wZGY/c3JzbHRpZD1BVTdndzRYRjhIb251TlpvQzc4ZVdLRmJNb2FOTGxXSDF2TmdFR0E2
TkgtWUZRcklwV1ZGdWxwdg0KDQo=
