Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB3CAD78337
	for <u-boot@archiver.kernel.org>; Mon,  2 Dec 2024 17:19:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4134688DB1;
	Mon,  2 Dec 2024 18:19:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="Dd030B/J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A55288DB1; Mon,  2 Dec 2024 18:19:35 +0100 (CET)
Received: from mx3.securetransport.de (mx3.securetransport.de
 [IPv6:2a01:4f8:c0c:92be::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A63788A1B
 for <u-boot@lists.denx.de>; Mon,  2 Dec 2024 18:19:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=dh-electronics.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cniedermaier@dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
 s=dhelectronicscom; t=1733159967;
 bh=n/2I7/jYotE9tiQTV9B4PMBKLXyNWT+SiNMNsR+cHn0=;
 h=From:To:CC:Subject:Date:References:In-Reply-To:From;
 b=Dd030B/JbWNmRFtcFkLfmrcZpMBiuw2w8gYGZK7JmukpHQIFW2Dm5S1RMAb3B1U9M
 9c6yVlcHr2vQ+ky8xtF4y++sVGY1VTM1S1Refj15WAiB5K9k3k/FlkwSKIlfl0rjzb
 mc/dqVYeWV7/z7XngTHH+PpOROsBSJgie8c7z5U3m/NbI9CPITuHmrCBAIWQsHEuS7
 H/L8g9WsyyLNLBy3P7fDmcysZ6bl0fOY2N7A3JZiQK3P/NkejUurQ3bt87nnyPZWgI
 bS5NOh3CNxw9aqVU/xV7POVNtJTcaDOVypdCcKSSKZ8n/9v0jqCagicnyAOs46WsjP
 7pV22rlVKyPRg==
X-secureTransport-forwarded: yes
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Complaints-To: abuse@cubewerk.de
To: Marek Vasut <marex@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: NXP i.MX U-Boot Team <uboot-imx@nxp.com>, Fabio Estevam
 <festevam@gmail.com>, Stefano Babic <sbabic@denx.de>, Tom Rini
 <trini@konsulko.com>, u-boot <u-boot@dh-electronics.com>
Subject: RE: [PATCH V4 3/4] board: dhelectronics: Sync env variable
 dh_som_serial_number with SN
Thread-Topic: [PATCH V4 3/4] board: dhelectronics: Sync env variable
 dh_som_serial_number with SN
Thread-Index: AQHbQaDkeFNffmy/BUi/IRWuK4THKLLRp2OAgAGRmmA=
Date: Mon, 2 Dec 2024 17:19:25 +0000
Message-ID: <98eb09cde471483a9096e211c34f1f02@dh-electronics.com>
References: <20241128142020.35386-1-cniedermaier@dh-electronics.com>
 <20241128142020.35386-4-cniedermaier@dh-electronics.com>
 <3b1359d9-2be2-452f-be56-b7ac2c4b50d7@denx.de>
In-Reply-To: <3b1359d9-2be2-452f-be56-b7ac2c4b50d7@denx.de>
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

RnJvbTogTWFyZWsgVmFzdXQgPG1hcmV4QGRlbnguZGU+DQpTZW50OiBTdW5kYXksIERlY2VtYmVy
IDEsIDIwMjQgNzoyMSBQTQ0KPiBPbiAxMS8yOC8yNCAzOjIwIFBNLCBDaHJpc3RvcGggTmllZGVy
bWFpZXIgd3JvdGU6DQo+PiBUaGUgZW52IHZhcmlhYmxlICJTTiIgaXMgdXNlZCB0byBzdG9yZSB0
aGUgc2VyaWFsIG51bWJlciBvbiBESCBlbGVjdHJvbmljcw0KPj4gU29Ncy4gTmV3IFNvTXMgd2ls
bCB1c2UgdGhlIHZhcmlhYmxlICJkaF9zb21fc2VyaWFsX251bWJlciIuIFRvIGVuc3VyZQ0KPj4g
Y29tcGF0aWJpbGl0eSwgdGhlc2UgZW52IHZhcmlhYmxlcyBhcmUgc3luY2hyb25pemVkLiBUaGlz
IGlzIGFjaGlldmVkDQo+PiB1c2luZyBjYWxsYmFjayBmdW5jdGlvbnMuDQo+Pg0KPj4gU2lnbmVk
LW9mZi1ieTogQ2hyaXN0b3BoIE5pZWRlcm1haWVyIDxjbmllZGVybWFpZXJAZGgtZWxlY3Ryb25p
Y3MuY29tPg0KPj4gLS0tDQo+PiBDYzogIk5YUCBpLk1YIFUtQm9vdCBUZWFtIiA8dWJvb3QtaW14
QG54cC5jb20+DQo+PiBDYzogTWFyZWsgVmFzdXQgPG1hcmV4QGRlbnguZGU+DQo+PiBDYzogRmFi
aW8gRXN0ZXZhbSA8ZmVzdGV2YW1AZ21haWwuY29tPg0KPj4gQ2M6IFN0ZWZhbm8gQmFiaWMgPHNi
YWJpY0BkZW54LmRlPg0KPj4gQ2M6IFRvbSBSaW5pIDx0cmluaUBrb25zdWxrby5jb20+DQo+PiBD
YzogdS1ib290QGRoLWVsZWN0cm9uaWNzLmNvbQ0KPj4gLS0tDQo+PiBWMzogLSBBZGQgdGhpcyBw
YXRjaCB0byB0aGUgc2VyaWVzDQo+PiBWNDogLSBSZW1vdmUgdGhlIHJlY3Vyc2lvbiBwcmV2ZW50
aW9uIGZyb20gdGhlIGNhbGxiYWNrIGZ1bmN0aW9ucw0KPj4gICAgICAgID0+IFRoZSByZWN1cnNp
b24gcHJldmVudGlvbiB3aWxsIGJlIGdlbmVyYWxseSBzb2x2ZWQgaW4gdGhlDQo+PiAgICAgICAg
ICAgY2FsbGJhY2sgZnVuY3Rpb24gY2FsbCBpbiBhIHNlcGFyYXRlIHBhdGNoDQo+IFRoaXMgaGFz
IHRvIGJlIHRoZSBsYXN0IHBhdGNoIGJlY2F1c2UgaXQgb25seSB3b3JrcyBjb3JyZWN0bHkgd2l0
aCB0aGUNCj4gbGFzdCBwYXRjaCBhcHBsaWVkLiBJZiB0aGUgb3JkZXJpbmcgaXMgbm90IGNvcnJl
Y3QsIGdpdCBiaXNlY3Qgd2lsbCBub3QNCj4gd29yayBjb3JyZWN0bHkgZWl0aGVyLg0KDQpPSywg
SSB3aWxsIGNoYW5nZSB0aGUgb3JkZXIgb2YgdGhlIGxhc3QgdHdvIHBhdGNoZXMgaW4gVjUuDQoN
ClRoYW5rcyBhbmQgcmVnYXJkcw0KQ2hyaXN0b3BoDQo=
