Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45168FB3CE8
	for <u-boot@archiver.kernel.org>; Mon, 30 Mar 2026 09:26:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8860A83D17;
	Mon, 30 Mar 2026 11:26:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="EdTDZHiq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A760C83E7A; Mon, 30 Mar 2026 11:26:05 +0200 (CEST)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78B6A83C5E
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 11:26:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=realsil.com.cn
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=javen_xu@realsil.com.cn
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62U9PmE42899236,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
 s=dkim; t=1774862749;
 bh=fxHomKwqkvtc2rXjpj/uP/tA0w5hiuRNTcQbTGU99G0=;
 h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:MIME-Version;
 b=EdTDZHiqf5Z1VQFyYgX5SObL7RgpiL2eUbuGupPOYGJNo6SPT9g6qevvqcShRocVj
 LS+Xy3/4SwiOt87KgUhKfFkL+eX49dp++44kEC19qqjotqNctnOQicuN9G1zuukGDD
 dHOL9x8dw/N5kvBl1CAg5oepotLQ/m2+8aiIIUOH/lC4gPw4m1yZPXIV72XZO27FLa
 XpbWVuFPaKANKFEBwgOHRG6RnEP2YuwdjbMBWp1ecCIn8hu6R3zPqICUlT0gioD+7H
 BXM0eL/L408KAXWPaelWDqA3YqhXTvCgoh4pHiSQ6UOHj5ods/wmQ9jrUr61Su5ksm
 s/aJmCwz/JPKQ==
Received: from RS-EX-MBS4.realsil.com.cn ([172.29.17.104])
 by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 62U9PmE42899236
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 30 Mar 2026 17:25:49 +0800
Received: from RS-EX-MBS3.realsil.com.cn (172.29.17.103) by
 RS-EX-MBS4.realsil.com.cn (172.29.17.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 30 Mar 2026 17:25:49 +0800
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) by
 RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) with mapi id 15.02.2562.017; Mon,
 30 Mar 2026 17:25:49 +0800
From: Javen <javen_xu@realsil.com.cn>
To: Javen <javen_xu@realsil.com.cn>, "jerome.forissier@arm.com"
 <jerome.forissier@arm.com>, "trini@konsulko.com" <trini@konsulko.com>,
 "joe.hershberger@ni.com" <joe.hershberger@ni.com>, "rfried.dev@gmail.com"
 <rfried.dev@gmail.com>, "trini@konsulko.com" <trini@konsulko.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: [PATCH] rtl8169: add support for RTL8125d
Thread-Topic: [PATCH] rtl8169: add support for RTL8125d
Thread-Index: AQHctd8qxNXY9KHatU+uvn/V2fOoAbXG4D7A
Date: Mon, 30 Mar 2026 09:25:48 +0000
Message-ID: <c4a8714b4b294fae884ab2bfd2580b5f@realsil.com.cn>
References: <20260317072456.1781-1-javen_xu@realsil.com.cn>
In-Reply-To: <20260317072456.1781-1-javen_xu@realsil.com.cn>
Accept-Language: zh-CN, en-US
Content-Language: en-US
x-originating-ip: [172.29.17.210]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
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

DQo+VGhpcyBwYXRjaCBhZGRzIHN1cHBvcnQgZm9yIFJUTDgxMjVkLiBJdHMgY2hpcCB2ZXJzaW9u
IGlzIDB4NmEuDQo+DQo+U2lnbmVkLW9mZi1ieTogSmF2ZW4gWHUgPGphdmVuX3h1QHJlYWxzaWwu
Y29tLmNuPg0KPi0tLQ0KPiBkcml2ZXJzL25ldC9ydGw4MTY5LmMgfCAxICsNCj4gMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+DQo+ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3J0bDgx
NjkuYyBiL2RyaXZlcnMvbmV0L3J0bDgxNjkuYyBpbmRleA0KPmVkY2FlODhhM2ZjLi5hNjc5YTY0
ZmVhMyAxMDA2NDQNCj4tLS0gYS9kcml2ZXJzL25ldC9ydGw4MTY5LmMNCj4rKysgYi9kcml2ZXJz
L25ldC9ydGw4MTY5LmMNCj5AQCAtMjcwLDYgKzI3MCw3IEBAIHN0YXRpYyBzdHJ1Y3Qgew0KPiAJ
eyJSVEwtODEwMGUiLAkJMHgzMiwgMHhmZjdlMTg4MCx9LA0KPiAJeyJSVEwtODE2OGgvODExMWgi
LAkweDU0LCAweGZmN2UxODgwLH0sDQo+IAl7IlJUTC04MTI1QiIsCQkweDY0LCAweGZmN2UxODgw
LH0sDQo+Kwl7IlJUTC04MTI1ZCIJCTB4NmEsIDB4ZmY3ZTU4ODAsfSwNCj4gfTsNCj4NCj4gZW51
bSBfRGVzY1N0YXR1c0JpdCB7DQo+LS0NCj4yLjQzLjANCg0KSGksIGFsbA0KSSBhbSByZWFjaGlu
ZyBvdXQgdG8gc2VlIGlmIGFueSBoYWQgYSBjaGFuY2UgdG8gcmV2aWV3IHRoaXMgcGF0Y2guIEkg
d29uZGVyIGlmIHRoZXJlIGlzIGFueXRoaW5nIA0KSSBuZWVkIHRvIG1vZGlmeSwgY2xhcmlmeSwg
b3IgaWYgSSBtaXNzZWQgYW55IHN1Ym1pc3Npb24gZ3VpZGVsaW5lcy4NCkp1c3QgYXNrLCBubyBw
cmVzc3VyZS4NCg0KVGhhbmtzIGZvciB5b3VyIHRpbWUsDQpCUnMsDQpKYXZlbiBYdQ0KDQo=
