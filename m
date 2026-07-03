Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 877B9C43458
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 14:49:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD35384942;
	Fri,  3 Jul 2026 16:49:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="ciUd421f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4AFC1849D2; Fri,  3 Jul 2026 16:49:51 +0200 (CEST)
Received: from mx2.securetransport.de (mx2.securetransport.de [188.68.39.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6A6584857
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 16:49:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=dh-electronics.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cniedermaier@dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
 s=dhelectronicscom; t=1783090156;
 bh=X2xYWOrsIOMI3h4JilU7W5XudHP0TwaFqQzdDiuwwjU=;
 h=From:To:CC:Subject:Date:References:In-Reply-To:From;
 b=ciUd421fqeXEL3DvRQfhMTByzeYcsTjVz7G+1JqISMlrrUb/DbL/SoYhONxBp2z79
 0liYpf5a6FRGeBTXV+QuuQP5z20qyr+7hy6jslUiAX7FAmZoDH1o2O7cVRjPhfyDTR
 FDQg1GWH0IWGZ2wbXjhpQR2kZq16ASvEotJf3IO9m5yc+so5/fHEI0JF/7xZw2+N2i
 jUN7RQD8qG1JBDtv2roFJCovrpGV1bSgFebWIjO9k5ljfRvQmAlNpq0YnslJcXLg+a
 FlX3noyw49jQWEY6HnHDweApZVnTaX44XO3Pl8/00DH0zKsjJPhmZsJ7/ANv2bBleO
 +J8Q+fRnPP1Bg==
X-secureTransport-forwarded: yes
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Complaints-To: abuse@cubewerk.de
To: Marek Vasut <marex@nabladev.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: NXP i.MX U-Boot Team <uboot-imx@nxp.com>, Adam Ford <aford173@gmail.com>, 
 Alice Guo <alice.guo@nxp.com>, Fabio Estevam <festevam@gmail.com>,
 "Francesco Dolcini" <francesco.dolcini@toradex.com>, Frieder Schrempf
 <frieder.schrempf@kontron.de>, Heiko Schocher <hs@nabladev.com>, "Markus
 Niebel" <Markus.Niebel@ew.tq-group.com>, Michael Walle <mwalle@kernel.org>,
 Peng Fan <peng.fan@nxp.com>, Stefano Babic <sbabic@nabladev.com>, Tim Harvey
 <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>, u-boot
 <u-boot@dh-electronics.com>
Subject: RE: [PATCH] mx6: ddr: Subtract half a cycle instead of three quarters
 of a cycle after DQS gating calibration
Thread-Topic: [PATCH] mx6: ddr: Subtract half a cycle instead of three
 quarters of a cycle after DQS gating calibration
Thread-Index: AQHdBK1tNR+uvYx+wUWvuDZJ/GW3hLZaTCeg
Date: Fri, 3 Jul 2026 14:49:13 +0000
Message-ID: <cb2b7b7f20a1456c85cc99791b302305@dh-electronics.com>
References: <20260625141755.16568-1-marex@nabladev.com>
In-Reply-To: <20260625141755.16568-1-marex@nabladev.com>
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

RnJvbTogTWFyZWsgVmFzdXQgPG1hcmV4QG5hYmxhZGV2LmNvbT4NClNlbnQ6IFRodXJzZGF5LCBK
dW5lIDI1LCAyMDI2IDQ6MTcgUE0NCj4gVGhlIGN1cnJlbnQgRFJBTSBjYWxpYnJhdGlvbiBzZXF1
ZW5jZSBpcyBpbXBsZW1lbnRlZCBiYXNlZCBvbiBOWFANCj4gQU40NDY3IFJldi4yIDAzLzIwMTUs
IHdoaWNoIGluIGNoYXB0ZXIgIjEyLjMuMiBDYWxpYnJhdGlvbiBTZXF1ZW5jZQ0KPiBTZXR1cCB3
aXRoIFByZWRlZmluZWQgRGF0YSBDb250ZW50IiBzdGF0ZXM6DQo+IA0KPiAiDQo+IDkuIEZvciBl
YWNoIG9mIHRoZSBEUVN4Og0KPiAtIFJlYWQgdGhlIEhXX0RHX1VQeCB2YWx1ZSBmcm9tIHRoZSBN
TURDMC8xX01QREdIV1NUeCwgc3VidHJhY3QgdGhlDQo+ICAgdmFsdWUgb2YgMHhjMCAoMy80IGN5
Y2xlKS4NCj4gIg0KPiANCj4gSG93ZXZlciwgdGhlIGkuTVggNlNvbG8vNkR1YWxMaXRlIEFwcGxp
Y2F0aW9ucyBQcm9jZXNzb3IgUmVmZXJlbmNlDQo+IE1hbnVhbCwgUmV2LiA1LCAwNS8yMDIwLCBj
aGFwdGVyICI0NS4xMS4zLjEuMiBIYXJkd2FyZSBEUVMgQ2FsaWJyYXRpb24NCj4gd2l0aCBwcmUt
ZGVmaW5lZCB2YWx1ZSIgc3RhdGVzOg0KPiANCj4gIg0KPiAzNS4gU2V0IChNUERHSFdTVG5bSFdf
REdfVVBuXVsxMDo3XSAtIDEpIHRvIE1QREdDVFJMbltER19IQ19ERUxuXS4NCj4gICAgIChXZSBz
ZXQgdGhlIERRUyBnYXRpbmcgdmFsdWUgdG8gYmUgdGhlIHVwcGVyIGxpbWl0IHZhbHVlIG1pbnVz
DQo+ICAgICAgMSBoYWxmIGN5Y2xlKQ0KPiAiDQo+IA0KPiBUaGUgaS5NWCA2RHVhbC82UXVhZCBB
cHBsaWNhdGlvbnMgUHJvY2Vzc29yIFJlZmVyZW5jZSBNYW51YWwsIFJldi4gNiwNCj4gMDUvMjAy
MCwgY2hhcHRlciA0NC4xMS4zLjEuMiBIYXJkd2FyZSBEUVMgQ2FsaWJyYXRpb24gd2l0aCBwcmUt
ZGVmaW5lZA0KPiB2YWx1ZSBsaXN0cyB0aGUgc2FtZSBpbmZvcm1hdGlvbi4gU28gZG8gdGhlIGZv
bGxvd2luZyBtYW51YWxzOg0KPiANCj4gLSBpLk1YIDZEdWFsUGx1cy82UXVhZFBsdXMgQXBwbGlj
YXRpb25zIFByb2Nlc3NvciBSZWZlcmVuY2UgTWFudWFsLCBSZXYuIDMsIDA1LzIwMjANCj4gICBj
aGFwdGVyIDQ2LjExLjMuMS4yIEhhcmR3YXJlIERRUyBDYWxpYnJhdGlvbiB3aXRoIHByZS1kZWZp
bmVkIHZhbHVlDQo+IC0gaS5NWCA2U29sb1ggQXBwbGljYXRpb25zIFByb2Nlc3NvciBSZWZlcmVu
Y2UgTWFudWFsLCBSZXYuIDQsIDA1LzIwMjANCj4gICBjaGFwdGVyIDQwLjExLjMuMS4yIEhhcmR3
YXJlIERRUyBDYWxpYnJhdGlvbiB3aXRoIHByZS1kZWZpbmVkIHZhbHVlDQo+IC0gaS5NWCA2VWx0
cmFMaXRlIEFwcGxpY2F0aW9ucyBQcm9jZXNzb3IgUmVmZXJlbmNlIE1hbnVhbCwgUmV2LiAyLCAw
My8yMDE3DQo+ICAgY2hhcHRlciAzMy4xMS4zLjEuMiBIYXJkd2FyZSBEUVMgQ2FsaWJyYXRpb24g
d2l0aCBwcmUtZGVmaW5lZCB2YWx1ZQ0KPiAtIGkuTVggNlVMTCBBcHBsaWNhdGlvbnMgUHJvY2Vz
c29yIFJlZmVyZW5jZSBNYW51YWwsIFJldi4gMSwgMTEvMjAxNw0KPiAgIGNoYXB0ZXIgMzUuMTEu
My4xLjIgSGFyZHdhcmUgRFFTIENhbGlicmF0aW9uIHdpdGggcHJlLWRlZmluZWQgdmFsdWUNCj4g
LSBpLk1YIDZVTFogQXBwbGljYXRpb25zIFByb2Nlc3NvciBSZWZlcmVuY2UgTWFudWFsLCBSZXYu
IDAsIDEwLzIwMTgNCj4gICBjaGFwdGVyIDI5LjExLjMuMS4yIEhhcmR3YXJlIERRUyBDYWxpYnJh
dGlvbiB3aXRoIHByZS1kZWZpbmVkIHZhbHVlDQo+IA0KPiBUaGUgTlhQIE1NREMgRERSIFN0cmVz
cyBUZXN0ICgzLjAuMCkgdG9vbCBzZWVtcyB0byBiZSBoYXZlIHRoZSBzYW1lDQo+IHdheSBhcyB0
aGUgbGF0ZXIgZG9jdW1lbnQgcmF0aGVyIHRoYW4gdGhlIEFONDQ2NyBhcHBsaWNhdGlvbiBub3Rl
LA0KPiBhbmQgcHJvZHVjZXMgdmFsdWVzIHNpbWlsYXIgdG8gdGhlIHZhbHVlcyB3aXRoIHN1YnRy
YWN0ZWQgMS8yIGN5Y2xlLg0KPiANCj4gQWRqdXN0IHRoZSBiZWhhdmlvciB0byBtYXRjaCB0aGUg
bW9yZSByZWNlbnQgUmVmZXJlbmNlIE1hbnVhbCBhbmQNCj4gdGhlIE1NREMgY2FsaWJyYXRpb24g
dG9vbC4NCj4gDQo+IFdpbmJvbmQgVzYzNEdVNlJCIGRvZXMgc2hvdyBzcG9yYWRpYyBzaWducyBv
ZiBpbnN0YWJpbGl0eSB3aXRob3V0DQo+IHRoaXMgY29ycmVjdGlvbi4NCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IE1hcmVrIFZhc3V0IDxtYXJleEBuYWJsYWRldi5jb20+DQo+IC0tLQ0KPiBDYzogIk5Y
UCBpLk1YIFUtQm9vdCBUZWFtIiA8dWJvb3QtaW14QG54cC5jb20+DQo+IENjOiBBZGFtIEZvcmQg
PGFmb3JkMTczQGdtYWlsLmNvbT4NCj4gQ2M6IEFsaWNlIEd1byA8YWxpY2UuZ3VvQG54cC5jb20+
DQo+IENjOiBGYWJpbyBFc3RldmFtIDxmZXN0ZXZhbUBnbWFpbC5jb20+DQo+IENjOiBGcmFuY2Vz
Y28gRG9sY2luaSA8ZnJhbmNlc2NvLmRvbGNpbmlAdG9yYWRleC5jb20+DQo+IENjOiBGcmllZGVy
IFNjaHJlbXBmIDxmcmllZGVyLnNjaHJlbXBmQGtvbnRyb24uZGU+DQo+IENjOiBIZWlrbyBTY2hv
Y2hlciA8aHNAbmFibGFkZXYuY29tPg0KPiBDYzogTWFya3VzIE5pZWJlbCA8TWFya3VzLk5pZWJl
bEBldy50cS1ncm91cC5jb20+DQo+IENjOiBNaWNoYWVsIFdhbGxlIDxtd2FsbGVAa2VybmVsLm9y
Zz4NCj4gQ2M6IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiBDYzogU3RlZmFubyBCYWJp
YyA8c2JhYmljQG5hYmxhZGV2LmNvbT4NCj4gQ2M6IFRpbSBIYXJ2ZXkgPHRoYXJ2ZXlAZ2F0ZXdv
cmtzLmNvbT4NCj4gQ2M6IFRvbSBSaW5pIDx0cmluaUBrb25zdWxrby5jb20+DQo+IENjOiB1LWJv
b3RAZGgtZWxlY3Ryb25pY3MuY29tDQo+IENjOiB1LWJvb3RAbGlzdHMuZGVueC5kZQ0KPiAtLS0N
Cj4gIGFyY2gvYXJtL21hY2gtaW14L214Ni9kZHIuYyB8IDQgKystLQ0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9h
cmNoL2FybS9tYWNoLWlteC9teDYvZGRyLmMgYi9hcmNoL2FybS9tYWNoLWlteC9teDYvZGRyLmMN
Cj4gaW5kZXggNWExMjU4ZTAwMmQuLjI0NDc2OThjZmU0IDEwMDY0NA0KPiAtLS0gYS9hcmNoL2Fy
bS9tYWNoLWlteC9teDYvZGRyLmMNCj4gKysrIGIvYXJjaC9hcm0vbWFjaC1pbXgvbXg2L2Rkci5j
DQo+IEBAIC03MSwxMyArNzEsMTMgQEAgc3RhdGljIHZvaWQgbW9kaWZ5X2RnX3Jlc3VsdCh1MzIg
KnJlZ19zdDAsIHUzMiAqcmVnX3N0MSwgdTMyDQo+ICpyZWdfY3RybCkNCj4gICAgICAgICB2YWxf
Y3RybCA9IHJlYWRsKHJlZ19jdHJsKTsNCj4gICAgICAgICB2YWxfY3RybCAmPSAweGYwMDAwMDAw
Ow0KPiANCj4gLSAgICAgICBkZ190bXBfdmFsID0gKChyZWFkbChyZWdfc3QwKSAmIDB4MDdmZjAw
MDApID4+IDE2KSAtIDB4YzA7DQo+ICsgICAgICAgZGdfdG1wX3ZhbCA9ICgocmVhZGwocmVnX3N0
MCkgJiAweDA3ZmYwMDAwKSA+PiAxNikgLSAweDgwOw0KPiAgICAgICAgIGRnX2RsX2Fic19vZmZz
ZXQgPSBkZ190bXBfdmFsICYgMHg3ZjsNCj4gICAgICAgICBkZ19oY19kZWwgPSAoZGdfdG1wX3Zh
bCAmIDB4NzgwKSA8PCAxOw0KPiANCj4gICAgICAgICB2YWxfY3RybCB8PSBkZ19kbF9hYnNfb2Zm
c2V0ICsgZGdfaGNfZGVsOw0KPiANCj4gLSAgICAgICBkZ190bXBfdmFsID0gKChyZWFkbChyZWdf
c3QxKSAmIDB4MDdmZjAwMDApID4+IDE2KSAtIDB4YzA7DQo+ICsgICAgICAgZGdfdG1wX3ZhbCA9
ICgocmVhZGwocmVnX3N0MSkgJiAweDA3ZmYwMDAwKSA+PiAxNikgLSAweDgwOw0KPiAgICAgICAg
IGRnX2RsX2Fic19vZmZzZXQgPSBkZ190bXBfdmFsICYgMHg3ZjsNCj4gICAgICAgICBkZ19oY19k
ZWwgPSAoZGdfdG1wX3ZhbCAmIDB4NzgwKSA8PCAxOw0KDQpXZSB0ZXN0ZWQgaXQgd2l0aCBhIERI
IGVsZWN0cm9uaWNzIGkuTVg2U29sbyBTb00gaW4gdGhlIGNsaW1hdGUgY2hhbWJlci4NCldpdGgg
V2luYm9uZCBXNjM0R1U2UkIgYW5kIHRoaXMgcGF0Y2ggaW5zdGFiaWxpdHkgaXNzdWVzIHdpdGgg
c29tZSBTb01zDQp3ZXJlIGdvbmUuDQoNCkluIGFkZGl0aW9uLCB3ZSB0ZXN0ZWQgdGhlIGZvbGxv
d2luZyBtZW1vcnkgdHlwZXMgKGFsc28gd2l0aCBhIERIIGVsZWN0cm9uaWNzDQppLk1YNlNvbG8g
U29NKSBpbiB0aGUgY2xpbWF0ZSBjaGFtYmVyIHdpdGggdGhpcyBwYXRjaCB0byBydWxlIG91dCBh
bnkNCmZ1bmRhbWVudGFsIGlzc3VlcyB3aXRoIGl0Og0KLSBJbnRlbGxpZ2VudCBNZW1vcnkgSU00
RzE2RDNGQUJHLTEyNUkNCi0gU2Ftc3VuZyBLNEI0RzE2NDZFLUJNTUENCi0gRXRyb24gRU02SEUx
NkVXQUtHLTEwSUgNCg0KVGVzdGVkLWJ5OiBDaHJpc3RvcGggTmllZGVybWFpZXIgPGNuaWVkZXJt
YWllckBkaC1lbGVjdHJvbmljcy5jb20+DQoNClJlZ2FyZHMNCkNocmlzdG9waA0K
