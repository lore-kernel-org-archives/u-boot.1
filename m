Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F39BFC28B30
	for <u-boot@archiver.kernel.org>; Thu, 20 Mar 2025 18:05:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 291218070C;
	Thu, 20 Mar 2025 19:05:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="ZoV9lbfU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D597807AE; Thu, 20 Mar 2025 19:05:25 +0100 (CET)
Received: from mx3.securetransport.de (mx3.securetransport.de [116.203.31.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 453A0806FC
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 19:05:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=dh-electronics.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cniedermaier@dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
 s=dhelectronicscom; t=1742493907;
 bh=FoAl6NLOp2pvzXtiInmWH4wwpjFl9qngFzDkFTqRDm8=;
 h=From:To:CC:Subject:Date:References:In-Reply-To:From;
 b=ZoV9lbfUxz97dsrDcxpb124nprMpZjlDPeomXGjr1QuiORDNgU6FW/QlpWax9dmrA
 OsM6Fc9AwvRPSzbfRork+kKFx/OZ4qf2E5QtLyUUblLpXe4gOjaU8MyDT6TAw8jxQ7
 zchG+qYYrxLjeEgTOj+ZrhnLA5pU1kCgeWoFzwEYRwNFiow5O9i1c3ma+99uAi0fe7
 552yDdwY351IXY3h5J3GI7WIrYSZJj4oyXetlHyxKKln8ZCFb2fUQ/i/gnhlSeoqvn
 tTefWrNgp7EsZOVF4zIK6zAmaI+9zQnU92Kt2xoeAxT/m9ucs+QzyEHlMReLkC+Yme
 X4vKryi1sdBQQ==
X-secureTransport-forwarded: yes
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Complaints-To: abuse@cubewerk.de
To: Marek Vasut <marex@denx.de>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Joe Hershberger <joe.hershberger@ni.com>,
 "Tom Rini" <trini@konsulko.com>
Subject: RE: [PATCH] cmd: env: select: Add output for available evironment
 targets
Thread-Topic: [PATCH] cmd: env: select: Add output for available evironment
 targets
Thread-Index: AQHbmYOgUteFRiNdr0WFwtqlSfo9prN72jMAgAB2bBA=
Date: Thu, 20 Mar 2025 18:05:05 +0000
Message-ID: <13a5e258ec0d4460ad81f3a301621a5d@dh-electronics.com>
References: <20250320103257.14185-1-cniedermaier@dh-electronics.com>
 <c990d260-e4cc-41e5-991b-56dc35791f1e@denx.de>
In-Reply-To: <c990d260-e4cc-41e5-991b-56dc35791f1e@denx.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
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

RnJvbTogTWFyZWsgVmFzdXQgPG1hcmV4QGRlbnguZGU+DQpTZW50OiBUaHVyc2RheSwgTWFyY2gg
MjAsIDIwMjUgMTI6NTYgUE0NCj4gT24gMy8yMC8yNSAxMTozMiBBTSwgQ2hyaXN0b3BoIE5pZWRl
cm1haWVyIHdyb3RlOg0KPj4gSWYgImVudiBzZWxlY3QiIGlzIGNhbGxlZCB3aXRob3V0IGEgdGFy
Z2V0IHBhcmFtZXRlciB0aGUgcmVzdWx0IGlzDQo+PiAiU2VsZWN0IEVudmlyb25tZW50IG9uIDxO
VUxMPjogZHJpdmVyIG5vdCBmb3VuZCIuDQo+IA0KPiBXaHkgaXMgdGhpcyBub3QgdGhlIGNvcnJl
Y3Qgb3V0cHV0ID8NCg0KSSB0aGluayBpdCB3b3VsZCBiZSBiZXR0ZXIgdG8gcHJpbnQgYW4gdXNh
Z2UgbWVzc2FnZSBoZXJlLg0KDQo+PiBJbXByb3ZlIHRoZSBvdXRwdXQNCj4+IGJ5IHNob3dpbmcg
YSBsaXN0IG9mIGF2YWlsYWJsZSBldmlyb25tZW50IHRhcmdldHMsIHdoZXJlIHRoZSBhY3RpdmUN
Cj4+IHRhcmdldCBpcyBtYXJrZWQgd2l0aCBhbiBhc3Rlcmlzay4NCj4gDQo+IElmIHRoZSBnb2Fs
IGlzIHRvIGFkZCBzdXBwb3J0IGZvciBsaXN0aW5nIGF2YWlsYWJsZSBlbnYgb3B0aW9ucyBmb3Ig
J2Vudg0KPiBzZWxlY3QnICwgdGhlbiBiZXR0ZXIgbW9kaWZ5IGNtZC9udmVkaXQuYyBkb19lbnZf
c2VsZWN0KCkgYW5kIGltcGxlbWVudA0KPiBzb21lICdlbnYgc2VsZWN0IC1sJyAuDQoNCkkgY291
bGQgZG8gdGhpcyBpbiB2Mi4NCg0KDQpSZWdhcmRzDQpDaHJpc3RvcGgNCg==
