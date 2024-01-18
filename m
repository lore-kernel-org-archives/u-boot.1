Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6A21C4707B
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 12:45:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B8B2879E5;
	Thu, 18 Jan 2024 13:45:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=supermicro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=supermicro.com header.i=@supermicro.com header.b="YQthO8ik";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27DA687947; Thu, 18 Jan 2024 03:01:06 +0100 (CET)
Received: from MGA.supermicro.com (mga.supermicro.com [207.212.57.84])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B69D878B3
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 03:01:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=supermicro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=liuw@supermicro.com
Received: from pps.filterd (MGA.supermicro.com [127.0.0.1])
 by MGA.supermicro.com (8.17.1.19/8.17.1.19) with ESMTP id 40HCwARa000531;
 Wed, 17 Jan 2024 18:00:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=supermicro.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=DKIM;
 bh=FR9RLjbexVQPCiWYB0GnytFFDqQ1vVwQ263k+zi//Oo=;
 b=YQthO8ikNDk1fYkytQ6qa+gNXj0V4Jw4SSqef+g3sgAEPo2EYEGhiZpooYDyjpiK4IQn
 m/gnQLfKPD9S08uhgPSLQorKCpdp/mn78d+vCr9LB92CE5RsoDe3mXRVqjKBYykGi80R
 ioYIe/zJpsKyxe/iCwPMHP8GjSva73GvxWkVe5hpSzWjaCd7KEUxTUTgdivphnx15KFX
 0FnRRBihAPHxTtUVUi2Y4gfGpb6iXpiPP5n6ED0rcb1CewZNIFy/kwOkqFVRFGAKpkqN
 rmrp3eNasguGOIVTDWxViRq/fDgna3kqMpi8hLGyky+s0/D5hWoCzhygsDXCw9NEOavU ig== 
Received: from ex2013-mbx5.supermicro.com (EX2013-MBX5.supermicro.com
 [10.2.1.182]) by MGA.supermicro.com (PPS) with ESMTPS id 3vku0wnwe1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Wed, 17 Jan 2024 18:00:58 -0800
Received: from us-ex2019-mbx2.supermicro.com (10.2.6.158) by
 EX2013-MBX5.supermicro.com (10.2.1.182) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Wed, 17 Jan 2024 18:00:58 -0800
Received: from us-ex2019-mbx1.supermicro.com (10.2.6.157) by
 us-ex2019-mbx2.supermicro.com (10.2.6.158) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Wed, 17 Jan 2024 18:00:57 -0800
Received: from us-ex2019-mbx1.supermicro.com ([fe80::37c2:47e5:2f5d:450f]) by
 us-ex2019-mbx1.supermicro.com ([fe80::37c2:47e5:2f5d:450f%16]) with
 mapi id 15.02.1118.037; Wed, 17 Jan 2024 18:00:57 -0800
From: Liu Wang <liuw@supermicro.com>
To: Fabio Estevam <festevam@gmail.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: Could you please help me in resolving the
 "arch/arm/lib/vectors.S:87: Error: no such instruction: `b reset' ?"
Thread-Topic: Could you please help me in resolving the
 "arch/arm/lib/vectors.S:87: Error: no such instruction: `b reset' ?"
Thread-Index: AdpI24I3kjWF6EnATLOPMIhQOQ7T3gAtdOcAAAg2JaAAAa1qgP//j+hE//+/RCD//2g18IABuW8A//+BwpQ=
Date: Thu, 18 Jan 2024 02:00:57 +0000
Message-ID: <8ACC66AF-9761-44E2-A36E-62C8EAADA09C@supermicro.com>
References: <2dba1330181940c78b5ad47f18ee43fa@supermicro.com>
 <CAOMZO5DTw2uU+uEmVLR9nbFkR4QPgmhuY9VUAz-sgg+GppMG9g@mail.gmail.com>
 <0934648988c9444aaf85f2e3163c0f4b@supermicro.com>
 <CAOMZO5Cy8as7b_cup6J+PYbN-stkj4Vz2wsLB_1=NN3vx5SVWQ@mail.gmail.com>
 <728CCDD9-CEA4-4ED1-9143-189C3F257097@supermicro.com>
 <9c2e7790f0c94b0ebf0e840100eae2c0@supermicro.com>
 <be10a49d2381407fb955958fbc87ecd4@supermicro.com>,
 <CAOMZO5D5g6izBC=aCumX_H1tbo5uXTfuhQekSuH_XDqUAN91Kg@mail.gmail.com>
In-Reply-To: <CAOMZO5D5g6izBC=aCumX_H1tbo5uXTfuhQekSuH_XDqUAN91Kg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_14,2024-01-17_01,2023-05-22_02
X-Mailman-Approved-At: Thu, 18 Jan 2024 13:45:03 +0100
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

SGkgRmFiaW8sDQoNClRoYW5rIHlvdS4gDQpXaWxsIGRvLg0KDQpTaW5jZXJlbHksDQpMaXUgIFdh
bmcNCg0KPiBPbiBKYW4gMTcsIDIwMjQsIGF0IDU6MzMgUE0sIEZhYmlvIEVzdGV2YW0gPGZlc3Rl
dmFtQGdtYWlsLmNvbT4gd3JvdGU6DQo+IA0KPiDvu79bQ0FVVElPTjogRXh0ZXJuYWwgTWFpbF0N
Cj4gDQo+PiBPbiBXZWQsIEphbiAxNywgMjAyNCBhdCAxMDoyNuKAr1BNIExpdSBXYW5nIDxsaXV3
QHN1cGVybWljcm8uY29tPiB3cm90ZToNCj4+IA0KPj4gSGkgRmFiaW8sDQo+PiANCj4+IFRoYW5r
IHlvdSBmb3IgeW91ciBoZWxwLg0KPj4gDQo+PiBTd2l0Y2hpbmcgdG8gImFybS1nbnUtdG9vbGNo
YWluLTEzLjIuUmVsMS14ODYtNjQtYXJtLW5vbmUtZWFiaSIgc2VlbXMgYSBmaXggZm9yIDoNCj4+
IC4uLmdudWVhYmloZi1nY2M6IGNhbm5vdCBleGVjdXRlIGJpbmFyeSBmaWxlOiBFeGVjIGZvcm1h
dCBlcnJvci4uLg0KPiANCj4gSSB3b3VsZCBzdWdnZXN0IGluc3RhbGxpbmcgdGhlIGRlZmF1bHQg
YXJtIHRvb2xjaGFpbiBmcm9tIFVidW50dS4NCj4gDQo+IEFzIGZvciB0aGUgYnVpbGQgZXJyb3Is
IHlvdSB3b3VsZCBuZWVkIHRvIGFzayB0byB3aG9ldmVyIHByb3ZpZGVkIHlvdQ0KPiB3aXRoIHRo
ZSBjb2RlLg0KPiANCj4gU2luY2UgdGhpcyBpcyBub3QgYSBtYWlubGluZSBVLUJvb3QsIHdlIGNh
bm5vdCBoZWxwLg0K
