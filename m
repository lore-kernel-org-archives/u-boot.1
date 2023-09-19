Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20B4DCD548C
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 07:45:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7586F869D8;
	Tue, 19 Sep 2023 09:45:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="xzEfX9tP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA0F586A90; Tue, 19 Sep 2023 09:45:46 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CE138603A
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 09:45:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38J7jXE7094831;
 Tue, 19 Sep 2023 02:45:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1695109533;
 bh=q518SE46p0scSlUWV+Hr/LdHWdTvu78BZ8TaMHlV6O0=;
 h=From:To:Subject:Date:References:In-Reply-To;
 b=xzEfX9tPzaq4rExUfy2CWnkKvDzbjt5Ay8MlaI05v97slGcMSPnvp2ZXx/2Jix4VK
 PQAstv566WJN9oEHTXJUJo3qh90KsLf+rPn91XC0QAWECuaaE2n2ZbU5JOfpnD0uTa
 0d9su/juIXb8vrmjRrUdg+WCjCrB3XsDaaMmnkWY=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38J7jXZa081026
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 19 Sep 2023 02:45:33 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 19
 Sep 2023 02:45:32 -0500
Received: from DLEE107.ent.ti.com ([fe80::1c91:43d:d71:d7b6]) by
 DLEE107.ent.ti.com ([fe80::1c91:43d:d71:d7b6%17]) with mapi id
 15.01.2507.023; Tue, 19 Sep 2023 02:45:32 -0500
From: "Kumar, Udit" <u-kumar1@ti.com>
To: Roger Quadros <rogerq@kernel.org>, "Nandan, Apurva" <a-nandan@ti.com>,
 "Nagalla, Hari" <hnagalla@ti.com>, Lukasz Majewski <lukma@denx.de>, "Sean
 Anderson" <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 "Francis, Neha" <n-francis@ti.com>, Simon Glass <sjg@chromium.org>, "Davis,
 Andrew" <afd@ti.com>, "Gurudasani, Kamlesh" <kamlesh@ti.com>, "Dasnavis,
 Sabiya" <sabiya.d@ti.com>, "Chawdhry, Manorit" <m-chawdhry@ti.com>,
 "Bhatia, Aradhya" <a-bhatia1@ti.com>, "Brattlof, Bryan" <bb@ti.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 "Menon, Nishanth" <nm@ti.com>, "Heinrich Schuchardt" <xypron.glpk@gmx.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 "Kacines, Jason" <j-kacines@ti.com>,
 "Choudhary, Jayesh" <j-choudhary@ti.com>, Ralph Siemsen
 <ralph.siemsen@linaro.org>, Yanhong Wang <yanhong.wang@starfivetech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "Kumar, Udit" <u-kumar1@ti.com>
Subject: RE: [PATCH v3 06/16] remoteproc: k3-r5: Extend support for R5F
 clusters on J784S4 SoCs
Thread-Topic: [PATCH v3 06/16] remoteproc: k3-r5: Extend support for R5F
 clusters on J784S4 SoCs
Thread-Index: AQHZ4l09lsi5UqWGBEO1gMyZjCs/sbASp5GAgA8swoA=
Date: Tue, 19 Sep 2023 07:44:41 +0000
Message-ID: <136176fb443045a8a90dde4b727b6ffb@ti.com>
References: <20230908110551.861575-1-a-nandan@ti.com>
 <20230908110551.861575-7-a-nandan@ti.com>
 <0b68fd7f-eb71-a5af-996b-898b8f8145c8@kernel.org>
In-Reply-To: <0b68fd7f-eb71-a5af-996b-898b8f8145c8@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.24.20.156]
x-exclaimer-md-config: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

SGkgUm9nZXINCg0KPg0KPg0KPk9uIDA4LzA5LzIwMjMgMTQ6MDUsIEFwdXJ2YSBOYW5kYW4gd3Jv
dGU6DQo+PiBGcm9tOiBIYXJpIE5hZ2FsbGEgPGhuYWdhbGxhQHRpLmNvbT4NCj4+DQo+PiBUaGUg
SzMgSjc4NFM0IFNvQ3MgaGF2ZSBmb3VyIGR1YWwtY29yZSBSNUYgc3Vic3lzdGVtcywgb25lIGlu
IE1DVQ0KPj4gdm9sdGFnZSBkb21haW4gYW5kIHRoZSBvdGhlciB0aHJlZSBpbiBNQUlOIHZvbHRh
Z2UgZG9tYWluLiBUaGVzZSBSNUYNCj4+IGNsdXN0ZXJzIGFyZSBzaW1pbGFyIHRvIHRoZSBSNUYg
Y2x1c3RlcnMgaW4gSjcyMDAgYW5kIEo3MjFTMiBTb0NzLg0KPj4NCj4+IEV4dGVuZCBzdXBwb3J0
IHRvIHRoZSBSNUYgY2x1c3RlcnMgZm9yIEo3ODRTNCB3aXRoIEo3MjFTMiBjb21wYXRpYmxlDQo+
PiBzdHJpbmcuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogSGFyaSBOYWdhbGxhIDxobmFnYWxsYUB0
aS5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBBcHVydmEgTmFuZGFuIDxhLW5hbmRhbkB0aS5jb20+
DQo+PiAtLS0NCj4+ICBkcml2ZXJzL3JlbW90ZXByb2MvdGlfazNfcjVmX3Jwcm9jLmMgfCA2ICsr
KystLQ0KPj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0p
DQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcmVtb3RlcHJvYy90aV9rM19yNWZfcnByb2Mu
Yw0KPj4gYi9kcml2ZXJzL3JlbW90ZXByb2MvdGlfazNfcjVmX3Jwcm9jLmMNCj4+IGluZGV4IDZm
M2UxMmQ5MTUuLjYzMWU1NDhkY2MgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL3JlbW90ZXByb2Mv
dGlfazNfcjVmX3Jwcm9jLmMNCj4+ICsrKyBiL2RyaXZlcnMvcmVtb3RlcHJvYy90aV9rM19yNWZf
cnByb2MuYw0KPj4gQEAgLTg1NSw3ICs4NTUsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGszX3I1
Zl9pcF9kYXRhIGszX2RhdGEgPSB7DQo+PiAgCS50Y21fZWNjX2F1dG9pbml0ID0gZmFsc2UsDQo+
PiAgfTsNCj4+DQo+PiAtc3RhdGljIGNvbnN0IHN0cnVjdCBrM19yNWZfaXBfZGF0YSBqNzIwMF9k
YXRhID0gew0KPj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgazNfcjVmX2lwX2RhdGEgajcyMDBfajcy
MXMyX2RhdGEgPSB7DQo+DQo+Tm8gbmVlZCB0byByZW5hbWUgdGhpcy4NCj4NCj4+ICAJLnRjbV9p
c19kb3VibGUgPSB0cnVlLA0KPj4gIAkudGNtX2VjY19hdXRvaW5pdCA9IHRydWUsDQo+PiAgfTsN
Cj4+IEBAIC04NjMsNyArODYzLDggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBrM19yNWZfaXBfZGF0
YSBqNzIwMF9kYXRhID0gew0KPj4gc3RhdGljIGNvbnN0IHN0cnVjdCB1ZGV2aWNlX2lkIGszX3I1
Zl9ycHJvY19pZHNbXSA9IHsNCj4+ICAJeyAuY29tcGF0aWJsZSA9ICJ0aSxhbTY1NC1yNWYiLCAu
ZGF0YSA9ICh1bG9uZykmazNfZGF0YSwgfSwNCj4+ICAJeyAuY29tcGF0aWJsZSA9ICJ0aSxqNzIx
ZS1yNWYiLCAuZGF0YSA9ICh1bG9uZykmazNfZGF0YSwgfSwNCj4+IC0JeyAuY29tcGF0aWJsZSA9
ICJ0aSxqNzIwMC1yNWYiLCAuZGF0YSA9ICh1bG9uZykmajcyMDBfZGF0YSwgfSwNCj4+ICsJeyAu
Y29tcGF0aWJsZSA9ICJ0aSxqNzIwMC1yNWYiLCAuZGF0YSA9ICh1bG9uZykmajcyMDBfajcyMXMy
X2RhdGEsIH0sDQo+PiArCXsgLmNvbXBhdGlibGUgPSAidGksajcyMXMyLXI1ZiIsIC5kYXRhID0g
KHVsb25nKSZqNzIwMF9qNzIxczJfZGF0YSwNCj4+ICt9LA0KPg0KPldoZXJlIGlzIERUIGJpbmRp
bmcgZG9jdW1lbnRhdGlvbiBmb3IgdGhpcz8NCg0KDQpQbGVhc2Ugc2VlIGh0dHBzOi8vZWxpeGly
LmJvb3RsaW4uY29tL2xpbnV4L2xhdGVzdC9zb3VyY2UvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3JlbW90ZXByb2MvdGksazMtcjVmLXJwcm9jLnlhbWwjTDQ1IA0KDQo+RG9uJ3Qg
eW91IG5lZWQgY29tcGF0aWJsZSBmb3IgdGksajcyOHM0LXI1Zj8NCg0KSWYgSVAgaXMgc2FtZSB0
aGVuIHdlIHNob3VsZCB1c2UgYXZhaWxhYmxlIGNvbXBhdGlibGUsDQoNCkluIGxvbmcgdGVybSwg
d2Ugc2hvdWxkIGRpcy1hc3NvY2lhdGUgbmFtZSBvZiBJUCB3aXRoIG5hbWUgb2Ygc2lsaWNvbiAN
Cg0KVGhhbmtzIA0KDQo+PiAgCXt9DQo+PiAgfTsNCj4+DQo+PiBAQCAtOTAxLDYgKzkwMiw3IEBA
IHN0YXRpYyBjb25zdCBzdHJ1Y3QgdWRldmljZV9pZCBrM19yNWZzc19pZHNbXSA9IHsNCj4+ICAJ
eyAuY29tcGF0aWJsZSA9ICJ0aSxhbTY1NC1yNWZzcyJ9LA0KPj4gIAl7IC5jb21wYXRpYmxlID0g
InRpLGo3MjFlLXI1ZnNzIn0sDQo+PiAgCXsgLmNvbXBhdGlibGUgPSAidGksajcyMDAtcjVmc3Mi
fSwNCj4+ICsJeyAuY29tcGF0aWJsZSA9ICJ0aSxqNzIxczItcjVmc3MifSwNCj4+ICAJe30NCj4+
ICB9Ow0KPj4NCj4NCj4tLQ0KPmNoZWVycywNCj4tcm9nZXINCg==
