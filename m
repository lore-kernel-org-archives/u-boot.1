Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3539DC3DA66
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 11:46:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2579C86699;
	Fri, 25 Aug 2023 13:46:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="F5Rv44v+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 032878681D; Fri, 25 Aug 2023 13:46:40 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7078385DE0
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 13:46:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1692963997; x=1695555997;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=U4HtxItdC2/oUWNFm2LLUO23Gc5buFbk7QtLx4lmh7s=;
 b=F5Rv44v++cUyCunWrZuo0bftPr6Fc0rzclnLH6uEtgH5f58zRiPt1LsbPgAdftPe
 Oz4u+ANtGbMZd9xbtRYEtDNjTUeh8imnBXANbFmPuFXdn1mgaA0mu5zxFAbhPufr
 KnelNMX0xmoncU10vANBefazjdQqT4KgcVeUZO3nZTo=;
X-AuditID: ac14000a-923ff70000007ecb-f1-64e8949cfafe
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 85.C5.32459.C9498E46;
 Fri, 25 Aug 2023 13:46:36 +0200 (CEST)
Received: from Berlix.phytec.de (172.25.0.12) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 25 Aug
 2023 13:46:56 +0200
Received: from Berlix.phytec.de ([fe80::61cc:ebf0:7375:8768]) by
 berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4%4]) with mapi id 15.01.2375.018;
 Fri, 25 Aug 2023 13:46:56 +0200
From: Yannic Moog <Y.Moog@phytec.de>
To: "festevam@gmail.com" <festevam@gmail.com>, Teresa Remmet
 <T.Remmet@phytec.de>
CC: "upstream@lists.phytec.de" <upstream@lists.phytec.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "uboot-imx@nxp.com"
 <uboot-imx@nxp.com>, "sbabic@denx.de" <sbabic@denx.de>, Wadim Egorov
 <W.Egorov@phytec.de>, Daniel Schultz <D.Schultz@phytec.de>
Subject: Re: [PATCH v2 0/6] PHYTEC SoM detection for phyCORE-i.MX8MP
Thread-Topic: [PATCH v2 0/6] PHYTEC SoM detection for phyCORE-i.MX8MP
Thread-Index: AQHZ0OjWUmy/xtsBrk2OcZX6FcQ4va/5P6eAgAGQmYA=
Date: Fri, 25 Aug 2023 11:46:56 +0000
Message-ID: <4c96ce5582528161fee84bf10ae626f081bff07e.camel@phytec.de>
References: <20230817085711.45339-1-t.remmet@phytec.de>
 <CAOMZO5AQUPKM7GdLVRM1UZNLw4W2PXQ72L2vtQY7vYr_wmSCMQ@mail.gmail.com>
In-Reply-To: <CAOMZO5AQUPKM7GdLVRM1UZNLw4W2PXQ72L2vtQY7vYr_wmSCMQ@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.0.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <5988A07387449841A3C843A3575503E9@phytec.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFIsWRmVeSWpSXmKPExsWyRpKBR3fulBcpBs/vMVk8vOpv0X7Kx+Lt
 3k52iymP17NbdL9Td2D1mDfrBIvHzll32T3O3tnB6NHf3cLqsfHdDqYA1igum5TUnMyy1CJ9
 uwSujIWti9gKtvBW/G04ztjA2MHbxcjJISFgIrFjyx72LkYuDiGBJUwS89+2MkI4DxglDtw+
 CeVsZJR4tfwxC0gLm4CKxMkZlxhBbBGBYIk1rd+ZQYqYBZqZJB5Mf8kKkhAWcJG4duslVJGr
 xJPP3awQtpXEhKa7bCA2i4CqxKSlq4CGcnDwCrhJnHgkCBIWEqiXeHdyOjOIzSkQKLG3u4MJ
 xGYUkJXYsOE8WJxZQFxi07PvrBAvCEgs2QMRlxAQlXj5+B9UXF7ixK1pTCDjmQU0Jdbv0odo
 tZC4+G4mE4StKDGl+yE7iM0rIChxcuYTlgmM4rOQbJiF0D0LSfcsJN2zkHQvYGRdxSiUm5mc
 nVqUma1XkFFZkpqsl5K6iREUnyIMXDsY++Z4HGJk4mA8xCjBwawkwvvF51mKEG9KYmVValF+
 fFFpTmrxIUZpDhYlcd77PUyJQgLpiSWp2ampBalFMFkmDk6pBkb/+cwhSme1s//UGTAwtwXs
 cFggu/JZ3lZmTab/r3SWBlz+yawnl3mgIs+w8vn2PuaDt+elb7TWaF7pMY/xbpN7ZYDlvreP
 Ps7deSHC1vyc1u1d39gDj0TJrZnptHLO0jzLOxe/r1i8zNPGcuXyk3Hz46tZe3238/0sK3xr
 /IXNpPzFE8nY0ClKLMUZiYZazEXFiQBSucxhvQIAAA==
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

SGkgRmFiaW8NCg0KT24gVGh1LCAyMDIzLTA4LTI0IGF0IDA4OjUyIC0wMzAwLCBGYWJpbyBFc3Rl
dmFtIHdyb3RlOg0KPiBIaSBZYW5uaWMsDQo+IA0KPiBPbiBUaHUsIEF1ZyAxNywgMjAyMyBhdCA1
OjU34oCvQU0gVGVyZXNhIFJlbW1ldCA8dC5yZW1tZXRAcGh5dGVjLmRlPg0KPiB3cm90ZToNCj4g
PiANCj4gPiBzZWNvbmQgdmVyc2lvbiBvZiB0aGUgc2VyaWVzIHRvIGFkZCBzdXBwb3J0IGZvciBF
RVBST00gU29NDQo+ID4gZGV0ZWN0aW9uIHVzZWQNCj4gPiBieSBkaWZmZXJlbnQgUEhZVEVDIFNv
TXMuIFRoZSBFRVBST00gZGF0YSBjb25zaXN0IG9mIDMyIGJ5dGVzDQo+ID4gY29udGFpbmluZw0K
PiA+IGluZm9ybWF0aW9uIGxpa2UgUENCIHJldmlzaW9uLCBSQU0gc2l6ZSBhbmQgb3RoZXIgU29N
IHNwZWNpZmljDQo+ID4gY29uZmlndXJhdGlvbi4NCj4gPiANCj4gPiBGb3IgU29NcyBvZiB0aGUg
aS5NWDhNIGZhbWlseSB0aGUgZGF0YSBpcyB3cml0dGVuIHRvIHR3byBhcmVhcyBvZg0KPiA+IHRo
ZQ0KPiA+IHVzZWQgaTJjIEVFUFJPTS4NCj4gPiANCj4gPiBXZSBpbml0YWxseSBhZGQgdGhlIGRl
dGVjdGlvbiBzdXBwb3J0IGZvciBwaHlDT1JFLWkuTVg4TVAuIER1ZSB0bw0KPiA+IGxheW91dA0K
PiA+IGNvbnN0cmFpbnRzIHBoeUNPUkUtaS5NWDhNUCBTb01zIHdpdGggUENCIHJldmlzaW9uIDIg
YW5kIG9sZGVyIGNhbg0KPiA+IG9ubHkNCj4gPiBtYWtlIHVzZSBvZiBhIGxvd2VyIFJBTSBmcmVx
dWVuY3kuIFRoaXMgY2hhbmdlcyB3aXRoIHRoZSB1c2Ugb2YNCj4gPiBuZXdlciBQQ0INCj4gPiBy
ZXZpc2lvbnMuIFdlIG1ha2UgdXNlIG9mIHRoZSBmYWN0b3J5IGZsYXNoZWQgRUVQUk9NIGRhdGEg
dG8gZGV0ZWN0DQo+ID4gdGhlDQo+ID4gUENCIHJldmlzaW9uIGFuZCBzZWxlY3QgdGhlIGZpdHRp
bmcgUkFNIHNldHRpbmdzLg0KPiA+IA0KPiA+IENoYW5nZXMgaW4gdjI6DQo+ID4gLSBmaXggd3Jv
bmcgUkFNIFRpbWluZyB2YWx1ZXMgYXMgcG9pbnRlZCBvdXQgYnkgWWFubmljDQo+ID4gLSByZW1v
dmVkIHN1cGVyZmx1b3VzIGdvdG8NCj4gPiAtIHJlbW92ZWQgYmxhbmsgbGluZSBhdCBFT0YNCj4g
PiAtIGZpeCBzdHJpbmcgY29udmVyc2lvbiB0byBpbnRlZ2VyDQo+ID4gLSBmaXggdHlwbyBzL3Jl
dnNpb25zL3JldmlzaW9ucw0KPiANCj4gQ291bGQgeW91IHBsZWFzZSBoZWxwIHJldmlldyB2Mj8N
Cg0KWWVzLCBJIHdpbGwgZG8gaXQgZWFybHkgbmV4dCB3ZWVrLg0KDQo+IA0KPiBUaGFua3MNCg0K
