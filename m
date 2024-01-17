Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D75D0C47258
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 20:27:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2946887729;
	Wed, 17 Jan 2024 21:27:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=supermicro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=supermicro.com header.i=@supermicro.com header.b="A1pqK613";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7454E8791E; Wed, 17 Jan 2024 19:26:07 +0100 (CET)
Received: from MGA.supermicro.com (mga.supermicro.com [207.212.57.84])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 619E9876FA
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 19:26:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=supermicro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=liuw@supermicro.com
Received: from pps.filterd (MGA.supermicro.com [127.0.0.1])
 by MGA.supermicro.com (8.17.1.19/8.17.1.19) with ESMTP id 40HDX0bs027439;
 Wed, 17 Jan 2024 10:25:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=supermicro.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=DKIM;
 bh=L4xH+Ku+DvF4jp26rces2Xqqls1ghpST3dtGpnDJgvc=;
 b=A1pqK613wBuQxBNc2ruaqfVnaZqIROaQvISh59fUmvHhVchuYoZmNBh5Wd7XnQYWHy7t
 R0yNjETCNIbMl9fWsCaYpZoFuqWbg4WFUYd+y8g6VS1CCb6p3+lbueNiHD+F1d/NURVY
 Ap4QMD27x27jfQh6HaknG0tFWJ/peRJfdEP/FsdNqUdjPk4jYbpnuZ2k+TDc58xeDrY7
 TOTM3oxrz1ruykgVZYKiyQRiXd5vQt7L86ieQA7iabO6ZcBUI1/UsOuKRTzBAtNgDAkk
 +192fF2A7mYwe7k2dcmMASFs5iY5xc9+795x1rl3vN1vSAU0yQlu6gbWrZHbpaqgCbGs MQ== 
Received: from ex2013-mbx5.supermicro.com (EX2013-MBX5.supermicro.com
 [10.2.1.182]) by MGA.supermicro.com (PPS) with ESMTPS id 3vku0wn8rg-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Wed, 17 Jan 2024 10:25:58 -0800
Received: from us-ex2019-mbx5.supermicro.com (10.2.6.161) by
 EX2013-MBX5.supermicro.com (10.2.1.182) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Wed, 17 Jan 2024 10:25:58 -0800
Received: from us-ex2019-mbx1.supermicro.com (10.2.6.157) by
 us-ex2019-mbx5.supermicro.com (10.2.6.161) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Wed, 17 Jan 2024 10:25:57 -0800
Received: from us-ex2019-mbx1.supermicro.com ([fe80::37c2:47e5:2f5d:450f]) by
 us-ex2019-mbx1.supermicro.com ([fe80::37c2:47e5:2f5d:450f%16]) with
 mapi id 15.02.1118.037; Wed, 17 Jan 2024 10:25:57 -0800
From: Liu Wang <liuw@supermicro.com>
To: Fabio Estevam <festevam@gmail.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: Could you please help me in resolving the
 "arch/arm/lib/vectors.S:87: Error: no such instruction: `b reset' ?"
Thread-Topic: Could you please help me in resolving the
 "arch/arm/lib/vectors.S:87: Error: no such instruction: `b reset' ?"
Thread-Index: AdpI24I3kjWF6EnATLOPMIhQOQ7T3gAtdOcAAAg2JaA=
Date: Wed, 17 Jan 2024 18:25:57 +0000
Message-ID: <0934648988c9444aaf85f2e3163c0f4b@supermicro.com>
References: <2dba1330181940c78b5ad47f18ee43fa@supermicro.com>
 <CAOMZO5DTw2uU+uEmVLR9nbFkR4QPgmhuY9VUAz-sgg+GppMG9g@mail.gmail.com>
In-Reply-To: <CAOMZO5DTw2uU+uEmVLR9nbFkR4QPgmhuY9VUAz-sgg+GppMG9g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.2.8.23]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_11,2024-01-17_01,2023-05-22_02
X-Mailman-Approved-At: Wed, 17 Jan 2024 21:27:40 +0100
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

SGkgRmFiaW8sDQoNClRoYW5rIHlvdSBmb3IgeW91ciBoZWxwLg0KDQoxLiBZb3UgYXJlIHJpZ2h0
LiBJdCBpcyBub3QgYW4gVS1ib290IG1haW5saW5lIGNvbmZpZ3VyYXRpb24uDQoNCkkgYW0gcG9y
dGluZyBVLWJvb3QgdG8gb3VyIGNvbXBhbnkncyBoYXJkd2FyZSBwbGF0Zm9ybSBodHRwczovL3d3
dy5zdXBlcm1pY3JvLmNvbS9tYW51YWxzL290aGVyL0NTRS1QVEpCT0QtQ0IzLnBkZiB3aXRoIFNv
QyBBU1QyNDAwIGZyb20gQXNwZWVkIGVtYmVkZGVkIHdpdGggYW4gQVJNIGNvcmUgQVJNOTI2RUog
MzItYml0IFJJU0MgQ1BVLg0KDQoyLiBZb3UgYXJlIHJpZ2h0LiBJIGhhdmUgbm90IGV4cG9ydGVk
IHRoZSB0b29sIGNoYWluLg0KQ291bGQgeW91IHBsZWFzZSBzaGFyZSBtZSBhIGxpbmsgdG8gYSBy
ZWFkbWUgaW4gc2V0dGluZyB1cCB0aGUgdG9vbCBjaGFpbiBmb3IgVWJ1bnR1IGNyb3NzIGJ1aWxk
IGVudmlyb25tZW50ID8NCg0KU2luY2VyZWx5LA0KTGl1IFdhbmcNCg0KLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCkZyb206IEZhYmlvIEVzdGV2YW0gPGZlc3RldmFtQGdtYWlsLmNvbT4gDQpT
ZW50OiBXZWRuZXNkYXksIEphbnVhcnkgMTcsIDIwMjQgNjowNiBBTQ0KVG86IExpdSBXYW5nIChI
VykgPGxpdXdAc3VwZXJtaWNyby5jb20+DQpDYzogdS1ib290QGxpc3RzLmRlbnguZGUNClN1Ympl
Y3Q6IFJlOiBDb3VsZCB5b3UgcGxlYXNlIGhlbHAgbWUgaW4gcmVzb2x2aW5nIHRoZSAiYXJjaC9h
cm0vbGliL3ZlY3RvcnMuUzo4NzogRXJyb3I6IG5vIHN1Y2ggaW5zdHJ1Y3Rpb246IGBiIHJlc2V0
JyA/Ig0KDQpbQ0FVVElPTjogRXh0ZXJuYWwgTWFpbF0NCg0KT24gV2VkLCBKYW4gMTcsIDIwMjQg
YXQgOToyN+KAr0FNIExpdSBXYW5nIDxsaXV3QHN1cGVybWljcm8uY29tPiB3cm90ZToNCj4NCj4g
U2lyL01hZGFtLA0KPg0KPiBDb3VsZCB5b3UgcGxlYXNlIGhlbHAgbWUgaW4gcmVzb2x2aW5nIHRo
ZSAiYXJjaC9hcm0vbGliL3ZlY3RvcnMuUzo4NzogRXJyb3I6IG5vIHN1Y2ggaW5zdHJ1Y3Rpb246
IGBiIHJlc2V0JyA/Ig0KPg0KPiBTaW5jZXJlbHksDQo+IExpdSBXYW5nDQo+IGxpdXdAbGl1dy1T
WVMtRTEwMC0xMlQtSDp+L0Rvd25sb2Fkcy91LWJvb3QkIG1ha2UgY3NlX3B0am9iX2NiM19yMTAy
X2RlZmNvbmZpZw0KDQpUaGlzIGlzIG5vdCBhIGNvbmZpZ3VyYXRpb24gc3VwcG9ydGVkIGJ5IFUt
Qm9vdCBtYWlubGluZS4NCg0KPiAjDQo+ICMgY29uZmlndXJhdGlvbiB3cml0dGVuIHRvIC5jb25m
aWcNCj4gIw0KPiBsaXV3QGxpdXctU1lTLUUxMDAtMTJULUg6fi9Eb3dubG9hZHMvdS1ib290JCBt
YWtlIGFsbA0KPiBzY3JpcHRzL2tjb25maWcvY29uZiAgLS1zeW5jY29uZmlnIEtjb25maWcNCj4g
ICBDRkcgICAgIHUtYm9vdC5jZmcNCj4gICBHRU4gICAgIGluY2x1ZGUvYXV0b2NvbmYubWsNCj4g
ICBHRU4gICAgIGluY2x1ZGUvYXV0b2NvbmYubWsuZGVwDQo+ICAgVVBEICAgICBpbmNsdWRlL2dl
bmVyYXRlZC90aW1lc3RhbXBfYXV0b2dlbmVyYXRlZC5oDQo+ICAgSE9TVENDICB0b29scy9ta2Vu
dmltYWdlLm8NCj4gICBIT1NUTEQgIHRvb2xzL21rZW52aW1hZ2UNCj4gICBIT1NUQ0MgIHRvb2xz
L2R1bXBpbWFnZS5vDQo+ICAgSE9TVExEICB0b29scy9kdW1waW1hZ2UNCj4gICBIT1NUQ0MgIHRv
b2xzL21raW1hZ2Uubw0KPiAgIEhPU1RMRCAgdG9vbHMvbWtpbWFnZQ0KPiAgIExEICAgICAgYXJj
aC9hcm0vY3B1L2J1aWx0LWluLm8NCj4gICBMRCAgICAgIGFyY2gvYXJtL2NwdS8vYnVpbHQtaW4u
bw0KPiAgIEFTICAgICAgYXJjaC9hcm0vbGliL3ZlY3RvcnMubw0KPiBhcmNoL2FybS9saWIvdmVj
dG9ycy5TOiBBc3NlbWJsZXIgbWVzc2FnZXM6DQo+IGFyY2gvYXJtL2xpYi92ZWN0b3JzLlM6ODc6
IEVycm9yOiBubyBzdWNoIGluc3RydWN0aW9uOiBgYiByZXNldCcNCg0KSGF2ZSB5b3UgZXhwb3J0
ZWQgdGhlIHRvb2xjaGFpbj8NCg==
