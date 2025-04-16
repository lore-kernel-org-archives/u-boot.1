Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22073C369BD
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 14:19:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA67882CA2;
	Wed, 16 Apr 2025 16:19:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="UpzaNgOv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B096782D17; Wed, 16 Apr 2025 16:19:10 +0200 (CEST)
Received: from mx3.securetransport.de (mx3.securetransport.de [116.203.31.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7ECFA82C49
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 16:19:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=dh-electronics.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cniedermaier@dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
 s=dhelectronicscom; t=1744813132;
 bh=dLfdCO006wXjrtcv55bykM736lr7YXhv+gZQ4nsRuPw=;
 h=From:To:CC:Subject:Date:References:In-Reply-To:From;
 b=UpzaNgOvNn3eamO6YoPW7z5eIxOpMaZNxBoC+XdQqQ8+tyDZvPmYpkRnXWQPWaXXx
 IO2tnq77MBcMv8qciekV0gQuhQQ3c0mBNyTlJBjcsdfmCqtVJTuMUv1Kk65/2dunIU
 48QW+DUVKKieJbaj745CK0N58MRc82BjAjF5lI0VjG/rULALB1cp0nofE0sARV5zJW
 hrgDZrmEdH9uIJ8k6zb/r4ng8pl/ODdDeXq6k6oUyBCnxzbjJey14ZwXS0KEe5uzb+
 dWTXb/R7OLcKeltSd9TMy0tU3kT4bBUa6D8aYCGiXZQv4t4KsbosOMbeQVMC3Yf5l1
 0SdGQqUobg1Kg==
X-secureTransport-forwarded: yes
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Complaints-To: abuse@cubewerk.de
To: Francesco Dolcini <francesco@dolcini.it>, Fabio Estevam
 <festevam@gmail.com>, Marek Vasut <marex@denx.de>
CC: Adam Ford <aford173@gmail.com>, Fabio Estevam <festevam@denx.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Dong Aisheng
 <aisheng.dong@nxp.com>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, "Michael
 Trimarchi" <michael@amarulasolutions.com>, Peng Fan <peng.fan@nxp.com>, "Tim
 Harvey" <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>,
 "uboot-imx@nxp.com" <uboot-imx@nxp.com>
Subject: RE: [REGRESSION] Re: [PATCH v2 16/24] clk: imx: Convert clock-osc-*
 back to osc_*
Thread-Topic: [REGRESSION] Re: [PATCH v2 16/24] clk: imx: Convert clock-osc-*
 back to osc_*
Thread-Index: AQHbnAzzKFZoYLb2WkSk0GZ1M4LS8LOky8MAgAAECACAAAW9AIAAHeuAgAAGVwCAAQ/lgIAAcEcg
Date: Wed, 16 Apr 2025 14:18:49 +0000
Message-ID: <db2d623afd944df2bca6d1e4657d4031@dh-electronics.com>
References: <20250323160107.145749-1-marex@denx.de>
 <20250323160107.145749-17-marex@denx.de>
 <20250415142846.GA244333@francesco-nb>
 <CAHCN7xLa5W-AtRso6RUZwZG_sfDm9CHierfzt_WfOqFjSGJZoA@mail.gmail.com>
 <20250415150344.GA246483@francesco-nb>
 <b396cb96-ff95-4822-ad24-ddff2e3b6545@denx.de>
 <CAOMZO5B=j=k8U6to2TDzohS11j4hPWQOho9bdrYCPe0WXtrQjw@mail.gmail.com>
 <20250416092639.GA24345@francesco-nb>
In-Reply-To: <20250416092639.GA24345@francesco-nb>
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

RnJvbTogRnJhbmNlc2NvIERvbGNpbmkgPGZyYW5jZXNjb0Bkb2xjaW5pLml0Pg0KU2VudDogV2Vk
bmVzZGF5LCBBcHJpbCAxNiwgMjAyNSAxMToyNyBBTQ0KPiBPbiBUdWUsIEFwciAxNSwgMjAyNSBh
dCAwMjoxMzozMFBNIC0wMzAwLCBGYWJpbyBFc3RldmFtIHdyb3RlOg0KPj4gT24gVHVlLCBBcHIg
MTUsIDIwMjUgYXQgMTo1NeKAr1BNIE1hcmVrIFZhc3V0IDxtYXJleEBkZW54LmRlPiB3cm90ZToN
Cj4+PiBEbyB5b3UgaGF2ZSBhZjljZGQxY2NkMmQgKCJSZXZlcnQgImFybTY0OiBkdHM6IGlteDht
bjogSW5jbHVkZSAzMmtIeg0KPj4+IG9zY2lsbGF0b3IgY2xvY2sgaW4gU1BMIERUcyIiKSBpbiBw
bGFjZSA/IElmIHNvLCB0cnkgYW5kIHJldmVydCBpdCwgZG9lcw0KPj4+IGl0IGhlbHAgPw0KPj4N
Cj4+IEl0IHNlZW1zIEkgaGF2ZSBub3QgcHVzaGVkIHRoZSAiUmV2ZXJ0ICJhcm02NDogZHRzOiBp
bXg4bW46IEluY2x1ZGUgMzJrSHoNCj4+IG9zY2lsbGF0b3IgY2xvY2sgaW4gU1BMIERUcyIgZml4
LiBTb3JyeSBhYm91dCB0aGF0Lg0KPj4NCj4+IEFzIEZyYW5jZXNjbyBpcyB1c2luZyBpbXg4bXAs
IHRoZW4gSSBndWVzcyB3ZSBhbHNvIG5lZWQgdG8gZG8gdGhlIHNhbWUNCj4+IGZvciBpbXg4bXA6
DQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2R0cy9pbXg4bXAtdS1ib290LmR0c2kgYi9h
cmNoL2FybS9kdHMvaW14OG1wLXUtYm9vdC5kdHNpDQo+PiBpbmRleCA2ZGU5YWI1ZDM3Y2YuLjM1
YWY0MTJmMDFiMCAxMDA2NDQNCj4+IC0tLSBhL2FyY2gvYXJtL2R0cy9pbXg4bXAtdS1ib290LmR0
c2kNCj4+ICsrKyBiL2FyY2gvYXJtL2R0cy9pbXg4bXAtdS1ib290LmR0c2kNCj4+IEBAIC0zNywx
MSArMzcsNiBAQA0KPj4gICAgICAgICAvZGVsZXRlLXByb3BlcnR5LyBhc3NpZ25lZC1jbG9jay1y
YXRlczsNCj4+ICB9Ow0KPj4NCj4+IC0mb3NjXzMyayB7DQo+PiAtICAgICAgIGJvb3RwaC1wcmUt
cmFtOw0KPj4gLSAgICAgICBib290cGgtYWxsOw0KPj4gLX07DQo+PiAtDQo+PiAgJm9zY18yNG0g
ew0KPj4gICAgICAgICBib290cGgtcHJlLXJhbTsNCj4+ICAgICAgICAgYm9vdHBoLWFsbDsNCj4+
DQo+PiBEb2VzIHRoaXMgZml4IHRoZSBib290IHByb2JsZW0/DQo+IA0KPiBNeSBpc3N1ZSBpcyBu
b3QgdGhlIGJvb3QuIFRoZSBpc3N1ZSBpcyB0aGF0IFVTQiBpcyBub3Qgd29ya2luZy4NCj4gDQo+
IFdpdGggdGhpcyBwYXRjaCBhcHBsaWVkIG5vdGhpbmcgY2hhbmdlcywgdGhlIGlzc3VlIGlzIG5v
dCBzb2x2ZWQuDQo+IA0KPiBGcmFuY2VzY28NCg0KSGVsbG8sDQoNCkkgZG9uJ3Qga25vdyBpZiBp
dCBpcyByZWxhdGVkIG9yIG5vdCwgSSBub3RpY2VkIHRoYXQgQWRhbSBGb3JkJ3MgcGF0Y2hlcw0K
Y29tbWl0IDZkMzNjYTM2ZTNiICgiY2xrOiBpbXg4bW06IHJlZ2lzdGVyIFVBUlQgY2xvY2tzIikg
YW5kDQpjb21taXQgODk5OWI3NmYyMzggKCJjbGs6IGlteDhtbjogcmVnaXN0ZXIgVUFSVCBjbG9j
a3MiKQ0KdXNlIHRoZSBmb3JtZXIgbmFtZSAiY2xvY2stb3NjLTI0bSIuIEJ1dCBNYXJlaydzIHBh
dGNoDQpjb21taXQgYjQ3MzRjOWMzMzMgKCJjbGs6IGlteDogQ29udmVydCBjbG9jay1vc2MtKiBi
YWNrIHRvIG9zY18qIikNCmNvbnZlcnRlZCBjbG9jay1vc2MtKiB0byBvc2NfKi4gU28gSSB0aGlu
ayB0aGUgVUFSVCBjbG9ja3Mgc2hvdWxkIGFsc28NCnVzZSB0aGUgY3VycmVudCBuYW1lIG9zY18q
Lg0KDQpSZWdhcmRzDQpDaHJpc3RvcGgNCg==
