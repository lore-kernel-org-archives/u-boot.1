Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D00CCC47258
	for <u-boot@archiver.kernel.org>; Wed, 24 Jan 2024 01:34:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29A1387B58;
	Wed, 24 Jan 2024 02:34:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=supermicro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=supermicro.com header.i=@supermicro.com header.b="wI3QqQ3t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE5488795B; Wed, 24 Jan 2024 02:18:09 +0100 (CET)
Received: from MGB.supermicro.com (mgb.supermicro.com [207.212.57.85])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C32BE8786C
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 02:18:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=supermicro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=liuw@supermicro.com
Received: from pps.filterd (MGB.supermicro.com [127.0.0.1])
 by MGB.supermicro.com (8.17.1.19/8.17.1.19) with ESMTP id 40NCeDYK019358;
 Tue, 23 Jan 2024 17:18:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=supermicro.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=DKIM;
 bh=+cgGQLQVBXSnWtUg1kpeHYMq03vwLjlbmH55jY3FUKw=;
 b=wI3QqQ3tZcd7/xoL3q9pIWCusZ5GyJTYeIf8JQTjH72yNgnB/JRQDyqHh+5v3kwBTRt2
 kxJV2WXYcC+4D5Fn/+Fb3HurkHIbxwv1MH8r/4Ou3lf9wVS49w0hZltpKjF9R+8qQG5H
 ye4G/s4gRUbRaJWo/HIAqSQEUY6BZTvlufrCtKQRRePv6NI3zefI1yYzpGkFiv/tz1Zz
 jDSBWVllAHhYQAtE/6kQuSxqB4dHFAdMLuCtvPqswSTFCLPIYXmRVL28uK01gX0E8N8y
 YLaVk7vG2GhNTZw0lIL+PGnrghIGhvRuxz7aGCewmr0jlS706pm3W7wBebpadRMcQ4lZ 8g== 
Received: from ex2013-mbx3.supermicro.com (EX2013-MBX3.supermicro.com
 [10.2.1.46]) by MGB.supermicro.com (PPS) with ESMTPS id 3vrenwmefx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Tue, 23 Jan 2024 17:18:03 -0800
Received: from us-ex2019-mbx5.supermicro.com (10.2.6.161) by
 EX2013-MBX3.supermicro.com (10.2.1.46) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Tue, 23 Jan 2024 17:18:03 -0800
Received: from us-ex2019-mbx1.supermicro.com (10.2.6.157) by
 us-ex2019-mbx5.supermicro.com (10.2.6.161) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Tue, 23 Jan 2024 17:18:02 -0800
Received: from us-ex2019-mbx1.supermicro.com ([fe80::37c2:47e5:2f5d:450f]) by
 us-ex2019-mbx1.supermicro.com ([fe80::37c2:47e5:2f5d:450f%16]) with
 mapi id 15.02.1118.037; Tue, 23 Jan 2024 17:18:02 -0800
From: Liu Wang <liuw@supermicro.com>
To: Fabio Estevam <festevam@gmail.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: Could you please help me in resolving the "
 /reset.c:42:(.text.do_reset+0x20): undefined reference to `reset_cpu'?"
Thread-Topic: Could you please help me in resolving the "
 /reset.c:42:(.text.do_reset+0x20): undefined reference to `reset_cpu'?"
Thread-Index: AQHaTZ8+mgOmQY3mrU+FK1vlIrAoDrDnNtEAgACLaRCAAOWPgP//g1I0
Date: Wed, 24 Jan 2024 01:18:02 +0000
Message-ID: <C7AF176D-62E5-4ABD-B7ED-8E81851013D1@supermicro.com>
References: <2dba1330181940c78b5ad47f18ee43fa@supermicro.com>
 <CAOMZO5DTw2uU+uEmVLR9nbFkR4QPgmhuY9VUAz-sgg+GppMG9g@mail.gmail.com>
 <0934648988c9444aaf85f2e3163c0f4b@supermicro.com>
 <CAOMZO5Cy8as7b_cup6J+PYbN-stkj4Vz2wsLB_1=NN3vx5SVWQ@mail.gmail.com>
 <728CCDD9-CEA4-4ED1-9143-189C3F257097@supermicro.com>
 <9c2e7790f0c94b0ebf0e840100eae2c0@supermicro.com>
 <be10a49d2381407fb955958fbc87ecd4@supermicro.com>
 <CAOMZO5D5g6izBC=aCumX_H1tbo5uXTfuhQekSuH_XDqUAN91Kg@mail.gmail.com>
 <8ACC66AF-9761-44E2-A36E-62C8EAADA09C@supermicro.com>
 <509c10723aed4965aceabbd28d36b847@supermicro.com>
 <CAOMZO5DUrxpRAt6Fn7xofHGH7B3ngrkdPm9c0YUd4r-19CB+ng@mail.gmail.com>
 <169de53f8b31460db561e775657492a3@supermicro.com>,
 <CAOMZO5AmtqSE9OiYnAvSBP6D5HH8aG2K8HZ=c-LBTR=uvpN=Wg@mail.gmail.com>
In-Reply-To: <CAOMZO5AmtqSE9OiYnAvSBP6D5HH8aG2K8HZ=c-LBTR=uvpN=Wg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_15,2024-01-23_02,2023-05-22_02
X-Mailman-Approved-At: Wed, 24 Jan 2024 02:34:25 +0100
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

SGkgRmFiaW8sDQoNClRoYW5rIHlvdSB5b3UgcmV2aWV3Lg0KDQpTaW5jZXJlbHksDQpMaXUgIFdh
bmcNCg0KPiBPbiBKYW4gMjMsIDIwMjQsIGF0IDQ6NDQgUE0sIEZhYmlvIEVzdGV2YW0gPGZlc3Rl
dmFtQGdtYWlsLmNvbT4gd3JvdGU6DQo+IA0KPiDvu79bQ0FVVElPTjogRXh0ZXJuYWwgTWFpbF0N
Cj4gDQo+PiBPbiBUdWUsIEphbiAyMywgMjAyNCBhdCA0OjIw4oCvUE0gTGl1IFdhbmcgPGxpdXdA
c3VwZXJtaWNyby5jb20+IHdyb3RlOg0KPj4gDQo+PiBIaSBGYWJpbywNCj4+IA0KPj4gVGhhbmsg
eW91IGZvciB5b3VyIGhlbHAuDQo+PiANCj4+IEF0dGFjaGVkIGlzIHRoZSAnZ2l0IHN0YXR1cycg
YW5kICdnaXQgbG9nJyBpbiBteSBwb3J0aW5nIHUtYm9vdCB0byBteSBjc2VfcHRqb2JfY2IzX3Ix
MDIgY29udHJvbCBib2FyZCBieSBmb2xsb3dpbmcgUkVBRE1FIGluIHUtYm9vdCBhbmQgYmVpbmcg
YmxvY2tlZCB3aXRoIHRoZSBodXJkbGUgb2YgICJ1bmRlZmluZWQgcmVmZXJlbmNlIHRvIGByZXNl
dF9jcHUnIiBpbiBob3BlIHlvdSBzcG90IHNvbWV0aGluZyBmYW1pbGlhciBhbmQgc2hlZCBhIGxp
Z2h0IGluIG15IGJ1aWxkaW5nIGVmZm9ydC4NCj4gDQo+IEkgZG9uJ3QgaGF2ZSBhbnkgaW5zaWdo
dCBpbnRvIHRoZSBwcm9ibGVtLCB1bmZvcnR1bmF0ZWx5Lg0KPiANCj4gQWxzbywgdjIwMjAuMTAg
aXMgdG9vIG9sZC4NCj4gDQo+IFlvdSBzaG91bGQgdXNlIG1haW5saW5lIFUtQm9vdCBhbmQgdXBz
dHJlYW0geW91ciBib2FyZCAob3IgaGlyZQ0KPiBzb21lb25lIHRvIGRvIGl0IGZvciB5b3UpLg0K
