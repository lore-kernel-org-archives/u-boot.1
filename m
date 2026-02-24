Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55A00E9B266
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 13:57:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15EE283EA6;
	Tue, 24 Feb 2026 14:56:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=infineon.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=infineon.com header.i=@infineon.com header.b="flnMGPwD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B32083981; Tue, 24 Feb 2026 09:39:23 +0100 (CET)
Received: from smtp14.infineon.com (smtp14.infineon.com
 [IPv6:2a00:18f0:1e00:4::6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F83B82BF2
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 09:39:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Takahiro.Kuwano@infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
 t=1771922362; x=1803458362;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=qrD5PemlPtGP0dT4v71ZRWGsI+nRjnB013EDGGbAIFA=;
 b=flnMGPwDhCMkAupazTPUP/2tCgwDcJgZKCudaW6QxAFgPtdstXKNwC4N
 9YkX++G5qJ2QauOYVDkxAs564XvsuyDV2AvllELSIeK5sX0TavvupRzwU
 LBUWwCVoEI0jQ4EoFaTjkH4ovXeujoxBWxNjXvthB1B+q6D4tDIyJmIX2 I=;
X-CSE-ConnectionGUID: vyI1DOO5Rl2XjiA9LeiY/A==
X-CSE-MsgGUID: 67S0/rb9So2lDzACBoqE4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="118970429"
X-IronPort-AV: E=Sophos;i="6.21,308,1763420400"; d="scan'208";a="118970429"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE803.infineon.com) ([172.23.29.29])
 by smtp14.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2026 09:39:21 +0100
Received: from MUCSE821.infineon.com (172.23.29.47) by MUCSE803.infineon.com
 (172.23.29.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Tue, 24 Feb
 2026 09:39:20 +0100
Received: from MUCSE815.infineon.com (172.23.29.41) by MUCSE821.infineon.com
 (172.23.29.47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Tue, 24 Feb
 2026 09:39:20 +0100
Received: from MUCSE815.infineon.com ([fe80::ed10:a720:3031:ca14]) by
 MUCSE815.infineon.com ([fe80::ed10:a720:3031:ca14%12]) with mapi id
 15.02.2562.035; Tue, 24 Feb 2026 09:39:20 +0100
From: <Takahiro.Kuwano@infineon.com>
To: <tudor.ambarus@linaro.org>, <miquel.raynal@bootlin.com>,
 <trini@konsulko.com>
CC: <mwalle@kernel.org>, <conor@kernel.org>, <u-boot@lists.denx.de>,
 <Hiroyuki.Saito2@infineon.com>, <venkatesh.abbarapu@amd.com>,
 <p-mantena@ti.com>, <vaishnav.a@ti.com>, <prasad.kummari@amd.com>,
 <pratyush@kernel.org>, <vigneshr@ti.com>, <marek.vasut+renesas@mailbox.org>
Subject: RE: [RFH] SPI and SPI-NOR patch help
Thread-Topic: [RFH] SPI and SPI-NOR patch help
Thread-Index: AQHcnQhEN0OnuPO1TkSOUzMgc1lF8bWCfR+AgAJyq4CAAHfvAIACzrcjgAGxBgCAB6r8sA==
Date: Tue, 24 Feb 2026 08:39:19 +0000
Message-ID: <90d5d396d2ec4888a4359ca4b2392b8d@infineon.com>
References: <20260213164607.GI2747538@bill-the-cat>
 <20260214-sternness-cling-4259916a8f73@spud>
 <DGG8OA1O1UEL.12RR559TX4XX6@kernel.org>
 <20260216153110.GV2747538@bill-the-cat> <87bjhmv20f.fsf@bootlin.com>
 <46b5a69c-f589-4c4e-99e8-6bf0c41be573@linaro.org>
In-Reply-To: <46b5a69c-f589-4c4e-99e8-6bf0c41be573@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.161.6.196]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 24 Feb 2026 14:56:44 +0100
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

SGksDQoNCj4gSGksDQo+IA0KPiArIFByYXR1c2gsDQo+ICsgVmlnbmVzaCwNCj4gKyBNYXJlaywN
Cj4gDQo+IE9uIDIvMTgvMjYgMTE6MjMgQU0sIE1pcXVlbCBSYXluYWwgd3JvdGU6DQo+ID4gSGVs
bG8gVG9tLA0KPiA+DQo+ID4gT24gMTYvMDIvMjAyNiBhdCAwOTozMToxMCAtMDYsIFRvbSBSaW5p
IDx0cmluaUBrb25zdWxrby5jb20+IHdyb3RlOg0KPiA+DQo+ID4+IE9uIE1vbiwgRmViIDE2LCAy
MDI2IGF0IDA5OjIxOjU1QU0gKzAxMDAsIE1pY2hhZWwgV2FsbGUgd3JvdGU6DQo+ID4+PiBPbiBT
YXQgRmViIDE0LCAyMDI2IGF0IDc6NTggUE0gQ0VULCBDb25vciBEb29sZXkgd3JvdGU6DQo+ID4+
Pj4gT24gRnJpLCBGZWIgMTMsIDIwMjYgYXQgMTA6NDY6MDdBTSAtMDYwMCwgVG9tIFJpbmkgd3Jv
dGU6DQo+ID4+Pj4+IEhleSBhbGwsDQo+ID4+Pj4+DQo+ID4+Pj4+IFRvIGJlIGJsdW50LCBVLUJv
b3QgbmVlZHMgaGVscCB3aXRoIHJldmlld2luZyBhbmQgbWFpbnRhaW5pbmcgdGhlIFNQSQ0KPiA+
Pj4+PiBhbmQgU1BJLU5PUiBzdWJzeXN0ZW1zLiBXZSBoYXZlbid0IGhhZCBzb21lb25lIHdpdGgg
dGltZSB0byBhY3RpdmVseQ0KPiA+Pj4+PiB3b3JrIGluIHRoaXMgYXJlYSBmb3Igc29tZSB0aW1l
LiBJJ20gZ29pbmcgdGhyb3VnaCB0aGUgb3V0c3RhbmRpbmcNCj4gPj4+Pj4gY2hhbmdlcyBub3cs
IGJ1dCBpdCBhbHNvIHNlZW1zIGEgY29tbW9uIHByb2JsZW0gaXMgdGhhdCB3aXRoIHJlc3BlY3Qg
dG8NCj4gPj4+Pj4gZGV2aWNlIElEcywgbW9zdCBvZiB0aGUgbmV3IG9uZXMgYWxzbyBhcmVuJ3Qg
aW4gdGhlIHVwc3RyZWFtIExpbnV4DQo+ID4+Pj4+IEtlcm5lbC4gSXMgdGhlcmUgc29tZSBiZXR0
ZXIgYW5kIGdlbmVyaWMgc29sdXRpb24gd2UncmUgbWlzc2luZyBzbyB0aGF0DQo+ID4+Pj4+IHdl
IGRvbid0IGhhdmUgbGFyZ2UgYW5kIG9mdGVuIGdyb3dpbmcgZGV2aWNlIElEIHRhYmxlcz8gSSdk
IHJhdGhlciBub3QNCj4gPj4+Pj4gbWFrZSB0aGF0IHByb2JsZW0gd29yc2UsIHNvIEkndmUgcmVq
ZWN0ZWQgdHdvIG9mIHRob3NlIHR5cGVzIG9mIHVwZGF0ZXMNCj4gPj4+Pj4gdG9kYXkgYW5kIEkn
bSBqdXN0IHNldHRpbmcgYXNpZGUgYSBsYXJnZSBudW1iZXIgb2Ygb3RoZXJzLg0KPiA+Pj4+DQo+
ID4+Pj4gRHVubm8gaWYgeW91ciB0aW1pbmcgd2FzIGN1cnNlZCBvbiBzZW5kaW5nIHRoaXMsIGJ1
dCBUdWRvciBzdWJtaXR0ZWQgaGlzDQo+ID4+Pj4gcmVzaWduYXRpb24gZnJvbSBzcGktbm9yIG1h
aW50YWluZXJzaGlwIGluIHRoZSBrZXJuZWwgYWJvdXQgMTAgbWlucw0KPiA+Pj4+IGFmdGVyLg0K
PiA+Pj4+IEkgdGhpbmsgTWljaGFlbCBXYWxsZSBtaWdodCBiZSByZXNwb25zaWJsZSBmb3Igd2hh
dCB5b3UncmUgdGFsa2luZyBhYm91dA0KPiA+Pj4+IGhlcmUsIHdpdGggaGlzIDc3M2JiZTEwNDQ5
NzMgKCJtdGQ6IHNwaS1ub3I6IGFkZCBnZW5lcmljIGZsYXNoIGRyaXZlciIpLA0KPiA+Pj4+IGJ1
dCBpZGsgamFjayBhYm91dCBzcGktbm9yIHN0dWZmLg0KPiA+Pj4NCj4gPj4+IFllYWguIE5vd2Fk
YXlzIFNQSS1OT1IgZmxhc2hlcyBjb21lIHdpdGggc2VsZiBkZXNjcmliaW5nIHRhYmxlcywNCj4g
Pj4+IHdoaWNoIGFyZSBhbHJlYWR5IHN1cHBvcnRlZCBieSB1LWJvb3QsIEkgdGhpbmsuIFRoZSBv
bmx5IGNoYW5nZSB0aGF0DQo+ID4+PiBzZWVtcyB0byBiZSBtaXNzaW5nIGlzIHRoZSBmYWxsYmFj
ayB0byBpdCBpZiBhbiBpZCBpc24ndCBmb3VuZCBpbg0KPiA+Pj4gdGhlIGZsYXNoZGIuIE9ubHkg
dGhpbmcgaXMsIHRoZSBTRkRQIGRvZXNuJ3QgZGVzY3JpYmUgYWxsIGZlYXR1cmVzLA0KPiA+Pj4g
bW9zdCBwcm9taW5lbnQgZXhhbXBsZSBiZWluZyBsb2NraW5nLiBTbyBpZiB5b3UgbmVlZCB0aGF0
LCB5b3UnbGwNCj4gPj4+IHN0aWxsIG5lZWQgdG8gaGF2ZSBhbiBlbnRyeSBwZXIgZmxhc2guDQo+
ID4+Pg0KPiA+Pj4gSW4gZmFjdCwgaW4gbGludXggSSdtIHBsYW5uaW5nIHRvIGNoYW5nZSB0byBt
YWtlIGl0IHByb2JlIFNGRFAgZmlyc3QNCj4gPj4+IGFuZCB0aGVuIGFtZW5kIGl0IHdpdGggdGhl
IGZsYXNoZGIgaW5mb3JtYXRpb24gKGlmIHRoZXJlIGlzIGFuDQo+ID4+PiBlbnRyeSkuDQo+ID4+
DQo+ID4+IFRoYW5rcyBmb3IgZXhwbGFpbmluZy4gU28gaW4gdGhhdCBVLUJvb3QgZG9lcyBoYXZl
IFNGRFAgc3VwcG9ydCwgdGhlDQo+ID4+IGZpcnN0IHRoaW5nIGlzIHBsYXRmb3JtcyBzaG91bGQg
bGlrZWx5IGJlIGVuYWJsaW5nIHRoYXQgaW5zdGVhZCBvZiBqdXN0DQo+ID4+IGFkZGluZyBJRHMs
IGF0IGxlYXN0IGZvciBiYXNpYyBzdXBwb3J0Lg0KPiANCj4gUmlnaHQuDQo+IA0KPiBTRkRQIGlz
IGJlaGluZCBhIGNvbmZpZywgYmVjYXVzZSBvZiBzaXplIGNvbnN0cmFpbnRzIEkgYXNzdW1lLiBB
bmQgdGhlbiB3ZQ0KPiBhbHNvIGhhdmUgYSB0aW55IGR1cGxpY2F0ZSB2ZXJzaW9uIG9mIHRoZSBk
cml2ZXIgZm9yIHN0cmljdGVyIHNpemUNCj4gY29uc3RyYWludHMuIEFyZSB0aGVzZSBzaXplIGNv
bnN0cmFpbnRzIGRlZmluZWQgc29tZXdoZXJlPyBXZSBuZWVkIHRvIGtub3cNCj4gdGhlbSBpbiBv
cmRlciB0byBjaG9vc2UgYSBkaXJlY3Rpb24uDQo+IA0KPiBBbHNvLCBJJ2QgYXJndWUgdGhhdCBo
YXZpbmcgdGhlIHRpbnkgdmVyc2lvbiBvZiB0aGUgZHJpdmVyIHdhcyBpZGVhbC4NCj4gSW5zdGVh
ZCB3ZSBzaG91bGQgaGF2ZSB0cmllZCB0byBtb2R1bGFyaXplIFNQSSBOT1IsIGJ5IFNGRFAsIHN0
YXRpYw0KPiBpbml0aWFsaXphdGlvbiBvZiBmbGFzaGVzLCBtYW51ZmFjdHVyZXIgZHJpdmVycy4N
Cj4gDQo+ID4NCj4gPiBZZXMuIFRoZXJlIHdpbGwgYmUgdGhlIG5lZWQgZm9yIElEcyBhbnl3YXlz
LCBmb3IgdGhvc2UgImV4dHJhIiAibm9uDQo+ID4gc2ZkcCIgZmVhdHVyZXMsIGJ1dCB0aGF0IHNo
b3VsZCByZWR1Y2UgdGhlIGxvYWQuIEZvciBleGFtcGxlLCBzaGFsbCB3ZQ0KPiA+IGNvbnNpZGVy
IGJsb2NrIHByb3RlY3Rpb24gaW4gVS1Cb290IG9yIG5vdD8gVGhpcyBpcyBhIHVzZWZ1bCBmZWF0
dXJlLA0KPiA+IGJ1dCBhdCB0aGUgc2FtZSB0aW1lLCBkbyB3ZSByZWFsbHkgbmVlZCBpdCBpbiBh
IEJvb3Rsb2FkZXI/IFRoaXMgaXMgb3Blbg0KPiA+IHRvIGRpc2N1c3Npb24uDQo+IA0KPiBJZiB5
b3UgaGF2ZSB3cml0ZSBjYXBhYmlsaXR5IGluIHUtYm9vdCwgaGF2aW5nIGJsb2NrIHByb3RlY3Rp
b24gaXMgdXNlZnVsDQo+IHRvIGF2b2lkIGluYWR2ZXJ0ZW50IHdyaXRlcy4NCj4gDQo+ID4NCj4g
Pj4gSXQgc3RpbGwgbGVhdmVzIHVzIGluIGEgYmFkIHNwb3QNCj4gPj4gYWJvdXQgaGF2aW5nIFNQ
SSBhbmQgU1BJLU5PUiBzdHVmZiByZXZpZXdlZCBhbmQgbWFpbnRhaW5lZCwgYnV0IGF0IGxlYXN0
DQo+ID4+IGl0J3MgY2xlYXJlciBpbiBwdWJsaWMgbm93IHdoZXJlIGl0IHN0YW5kcy4NCj4gDQo+
IFRha2FoaXJvIHJlY2VudGx5IGFjY2VwdGVkIGJlY29taW5nIGEgZGVzaWduYXRlZCByZXZpZXdl
ciBmb3IgU1BJIE5PUg0KPiBpbiBMaW51eCwgYW5kIEkgdGhpbmsgaGlzIGV4cGVydGlzZSB3b3Vs
ZCBiZSBoaWdobHkgdmFsdWFibGUgaW4gVS1Cb290DQo+IGFzIHdlbGwuIFRha2FoaXJvLCBpZiB5
b3UgaGF2ZSB0aGUgYmFuZHdpZHRoLCB3b3VsZCB5b3UgYmUgb3BlbiB0bw0KPiBiZWNvbWluZyBh
IGRlc2lnbmF0ZWQgcmV2aWV3ZXIgaGVyZSB0b28/IE9yIG1heWJlIHNlZSBob3cgdGhpbmdzIGFy
ZQ0KPiBnb2luZyBpbiBMaW51eCBmaXJzdD8gTm8gcHJlc3N1cmUuDQo+IA0KWWVzLCBJJ20gb3Bl
biB0byBkbyB0aGF0Lg0KDQpUbyBzeW5jIHdpdGggTGludXgsIHdlIG5lZWQgdG8gaXNvbGF0ZSBz
dGFja2VkL3BhcmFsbGVsIHN1cHBvcnQgZnJvbSBjb3JlIGZpcnN0Lg0KaHR0cHM6Ly9wYXRjaHdv
cmsub3psYWJzLm9yZy9wcm9qZWN0L3Vib290L2NvdmVyLzIwMjUxMTE5LWFtZC1jbGVhbnVwLXYx
LTAtYzU1NWJkODVlNmU0QGluZmluZW9uLmNvbS8NCg0KPiBDaGVlcnMsDQo+IHRhDQo+IA0KPiA+
DQo+ID4gSSBndWVzcyBzcGktbWVtIGFuZCBTUEkgTkFORCBpcyBhbHNvIGluIHRoaXMga2luZCBv
ZiBzaXR1YXRpb24sIGV2ZW4NCj4gPiB3aXRoIHRoZSBBbWFydWxhIGNyZXcgZG9pbmcgd2hhdCB0
aGV5IGNhbiB0byBpbXByb3ZlIHRoZSBzaXR1YXRpb24uDQo+ID4NCj4gPiBUaGFua3MsDQo+ID4g
TWlxdcOobA0KDQpUaGFua3MsDQpUYWthaGlybw0KDQo=
