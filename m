Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C8DDC47258
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 20:27:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96A72879F3;
	Wed, 17 Jan 2024 21:27:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=supermicro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=supermicro.com header.i=@supermicro.com header.b="fOXSC2B/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C268878DA; Wed, 17 Jan 2024 21:07:56 +0100 (CET)
Received: from MGA.supermicro.com (mga.supermicro.com [207.212.57.84])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 612EF879F3
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 21:07:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=supermicro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=liuw@supermicro.com
Received: from pps.filterd (MGA.supermicro.com [127.0.0.1])
 by MGA.supermicro.com (8.17.1.19/8.17.1.19) with ESMTP id 40HFhgi7004841;
 Wed, 17 Jan 2024 12:07:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=supermicro.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=DKIM;
 bh=c4/R2ID6jUf5OOxsaY90A5Vuq/4TMutQewpXzpwsB5o=;
 b=fOXSC2B/I7LJWVL6zpssejqeAVujZBW+3T3l7tl0G9iVXWVSppGoF6XJmHh3UuNfNONa
 KHiuKmnrF7LrHDYsXrpN2AwnzOLG788ZpHGQClpCPYvjraI3hwOYtrgyFVDQvWISX5xh
 P5k47/U5/GeVvdqO2YTYWhdY8C+vwlwUUXVPS5WDNbocZN4uRcTjKWkYDU2FVuJIcH3H
 uYN58kRVkdjys34kqMjVzGP0jkK2c7RL9TAykBFa9/pjlrxm3yrMibEW+ZfkwMLRadgv
 xLM1pHAUpVErT2yrDf6zdMNG9uimDH0pdJzLbGy0HKlD23b1PQyTsxoSXJDJYKCiLWB1 bg== 
Received: from ex2013-mbx5.supermicro.com (EX2013-MBX5.supermicro.com
 [10.2.1.182]) by MGA.supermicro.com (PPS) with ESMTPS id 3vku0wnf6p-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Wed, 17 Jan 2024 12:07:50 -0800
Received: from us-ex2019-mbx4.supermicro.com (10.2.6.160) by
 EX2013-MBX5.supermicro.com (10.2.1.182) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Wed, 17 Jan 2024 12:07:49 -0800
Received: from us-ex2019-mbx1.supermicro.com (10.2.6.157) by
 us-ex2019-mbx4.supermicro.com (10.2.6.160) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Wed, 17 Jan 2024 12:07:49 -0800
Received: from us-ex2019-mbx1.supermicro.com ([fe80::37c2:47e5:2f5d:450f]) by
 us-ex2019-mbx1.supermicro.com ([fe80::37c2:47e5:2f5d:450f%16]) with
 mapi id 15.02.1118.037; Wed, 17 Jan 2024 12:07:49 -0800
From: Liu Wang <liuw@supermicro.com>
To: Fabio Estevam <festevam@gmail.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: Could you please help me in resolving the
 "arch/arm/lib/vectors.S:87: Error: no such instruction: `b reset' ?"
Thread-Topic: Could you please help me in resolving the
 "arch/arm/lib/vectors.S:87: Error: no such instruction: `b reset' ?"
Thread-Index: AdpI24I3kjWF6EnATLOPMIhQOQ7T3gAtdOcAAAg2JaAAAa1qgP//j+hE
Date: Wed, 17 Jan 2024 20:07:49 +0000
Message-ID: <728CCDD9-CEA4-4ED1-9143-189C3F257097@supermicro.com>
References: <2dba1330181940c78b5ad47f18ee43fa@supermicro.com>
 <CAOMZO5DTw2uU+uEmVLR9nbFkR4QPgmhuY9VUAz-sgg+GppMG9g@mail.gmail.com>
 <0934648988c9444aaf85f2e3163c0f4b@supermicro.com>,
 <CAOMZO5Cy8as7b_cup6J+PYbN-stkj4Vz2wsLB_1=NN3vx5SVWQ@mail.gmail.com>
In-Reply-To: <CAOMZO5Cy8as7b_cup6J+PYbN-stkj4Vz2wsLB_1=NN3vx5SVWQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_12,2024-01-17_01,2023-05-22_02
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

SGkgRmFiaW8sDQoNCkFwcHJlY2lhdGUhDQoNClNpbmNlcmVseSwNCkxpdSAgV2FuZw0KDQo+IE9u
IEphbiAxNywgMjAyNCwgYXQgMTA6NDkgQU0sIEZhYmlvIEVzdGV2YW0gPGZlc3RldmFtQGdtYWls
LmNvbT4gd3JvdGU6DQo+IA0KPiDvu79bQ0FVVElPTjogRXh0ZXJuYWwgTWFpbF0NCj4gDQo+PiBP
biBXZWQsIEphbiAxNywgMjAyNCBhdCAzOjI14oCvUE0gTGl1IFdhbmcgPGxpdXdAc3VwZXJtaWNy
by5jb20+IHdyb3RlOg0KPj4gDQo+PiAyLiBZb3UgYXJlIHJpZ2h0LiBJIGhhdmUgbm90IGV4cG9y
dGVkIHRoZSB0b29sIGNoYWluLg0KPj4gQ291bGQgeW91IHBsZWFzZSBzaGFyZSBtZSBhIGxpbmsg
dG8gYSByZWFkbWUgaW4gc2V0dGluZyB1cCB0aGUgdG9vbCBjaGFpbiBmb3IgVWJ1bnR1IGNyb3Nz
IGJ1aWxkIGVudmlyb25tZW50ID8NCj4gDQo+IFlvdSBjYW4gZG8gbGlrZSB0aGlzOg0KPiANCj4g
ZXhwb3J0IEFSQ0g9YXJtDQo+IGV4cG9ydCBDUk9TU19DT01QSUxFPS91c3IvYmluL2FybS1saW51
eC1nbnVlYWJpaGYtDQo+IA0KPiBtYWtlIGNzZV9wdGpvYl9jYjNfcjEwMl9kZWZjb25maWcNCj4g
bWFrZQ0K
