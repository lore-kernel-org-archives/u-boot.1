Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12BC3C47258
	for <u-boot@archiver.kernel.org>; Mon, 15 Jan 2024 08:28:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4526E86FB2;
	Mon, 15 Jan 2024 09:28:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="hFb6gwaB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A691886F1F; Mon, 15 Jan 2024 09:28:21 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EF4B86590
 for <u-boot@lists.denx.de>; Mon, 15 Jan 2024 09:28:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1705307299; x=1707899299;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gLuvuKujKiE1RrnsCBgu0a4u2aeAH5PJjtH6UngOe8E=;
 b=hFb6gwaBcCANZZGgnkgmn8p0EY7z+ArjZg7jdwq02jEv8NVz5+tFi1sI6ZWknwGT
 wosYX8mtELkO5l/MWqkp5krQfakWa5Tip1Uqt0E9vc06Ja5olIdIRi/Xmx15bghM
 qBlygAE+duLqrPx8XVT5SsOyO3qrEDcwpqKB9z/4HMI=;
X-AuditID: ac14000a-fbefe7000000290d-bb-65a4eca3fba3
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id AE.04.10509.3ACE4A56;
 Mon, 15 Jan 2024 09:28:19 +0100 (CET)
Received: from Berlix.phytec.de (172.25.0.12) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 15 Jan
 2024 09:28:19 +0100
Received: from Berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4]) by
 berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4%4]) with mapi id 15.01.2507.006;
 Mon, 15 Jan 2024 09:28:19 +0100
From: Yannic Moog <Y.Moog@phytec.de>
To: "festevam@gmail.com" <festevam@gmail.com>
CC: "upstream@lists.phytec.de" <upstream@lists.phytec.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Teresa Remmet
 <T.Remmet@phytec.de>
Subject: Re: [PATCH] board: phytec: fix link error when disabling
 PHYTEC_SOM_DETECTION
Thread-Topic: [PATCH] board: phytec: fix link error when disabling
 PHYTEC_SOM_DETECTION
Thread-Index: AQHaRGgEqGvhB4M9TE6VzSzQqwIX/7DWZ5EAgAQYcAA=
Date: Mon, 15 Jan 2024 08:28:18 +0000
Message-ID: <cfa8d0a081f41af59b71b5da6dd41e01c1b340b0.camel@phytec.de>
References: <20240111-wip-y-moog-phytec-de-som-detection-fixup-v1-1-7c1a63e7eee8@phytec.de>
 <CAOMZO5BBhS9qQFNkftiNN-6odxe_MN+ONGKwTsbCdMWwX1vtKg@mail.gmail.com>
In-Reply-To: <CAOMZO5BBhS9qQFNkftiNN-6odxe_MN+ONGKwTsbCdMWwX1vtKg@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.0.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <6B96F3B38FD18F42A1865E7FED5DB96E@phytec.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOIsWRmVeSWpSXmKPExsWyRpKBR3fxmyWpBj0HeC0eXvW3eLu3k92i
 +526A7PHzll32T3O3tnB6NHf3cIawBzFZZOSmpNZllqkb5fAlbFq52Smgm/sFY0LzjI2MN5h
 72Lk5JAQMJGYcuYoI4gtJLCYSWLRPpYuRi4g+z6jxOanDWwQzgZGibaDf1lBqtgEVCROzrgE
 1iEioCux4kQXI0gRs8AERonvK78zgySEBSIk3vc8YIEoipTY8fARVIOVREfbXSCbg4NFQFXi
 9XcukDCvgJvExnP9UJsXM0ps718AtoxTIFDi6vTTYKcyCshKbNhwHmw+s4C4xKZn31khXhCQ
 WLIHIi4hICrx8vE/qLi8xIlb05hAdjELaEqs36UP0Woh8XLpfHYIW1FiSvdDdogbBCVOznzC
 MoFRfBaSDbMQumch6Z6FpHsWku4FjKyrGIVyM5OzU4sys/UKMipLUpP1UlI3MYIiT4SBawdj
 3xyPQ4xMHIyHGCU4mJVEeKvvLEkV4k1JrKxKLcqPLyrNSS0+xCjNwaIkzru6IzhVSCA9sSQ1
 OzW1ILUIJsvEwSnVwCjxPs0v3PX19OmLJ6oH960N5trEazm1Rsu4LyGe66pkS1hYaVD8ppPM
 +nktMQWtd0Le7O3auk/u7aovTBp7KpVbBLvbsy4YHjNe+vNC+pKOK1XXRJ+X2H/+YedlLZaw
 L+X/JN4DupvmZRjGaRQxfN9fOafwzBTNie1tq9iVo0v0b2U3hbxTU2Ipzkg01GIuKk4EABoa
 9zaqAgAA
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

SGkgRmFiaW8NCg0KT24gRnJpLCAyMDI0LTAxLTEyIGF0IDE0OjU1IC0wMzAwLCBGYWJpbyBFc3Rl
dmFtIHdyb3RlOg0KPiBIaSBZYW5uaWMsDQo+IA0KPiBPbiBUaHUsIEphbiAxMSwgMjAyNCBhdCA1
OjI34oCvQU0gWWFubmljIE1vb2cgPHkubW9vZ0BwaHl0ZWMuZGU+IHdyb3RlOg0KPiA+IA0KPiA+
IENvbW1pdCBhYTc4NThmZTVlMmUgKCJib2FyZDogcGh5dGVjOiBzb21fZGV0ZWN0aW9uOiBtb3Zl
IGRlZmluaXRpb25zIHRvDQo+ID4gc291cmNlIGZpbGUiKSBtb3ZlZCBmdW5jdGlvbiBkZWZpbml0
aW9ucyBmcm9tIGhlYWRlciB0byBzb3VyY2UgZmlsZS4NCj4gPiBNYWtlZmlsZSBob3dldmVyIHdh
cyBub3QgdXBkYXRlZCB0byB1bmNvbmRpdGlvbmFsbHkgYnVpbGQgdGhlIGlteDggYW5kDQo+ID4g
cGh5dGVjIHNvbSBkZXRlY3Rpb24gdW5pdHMuIEZpeCB0aGlzLg0KPiA+IA0KPiA+IEZpeGVzOiBh
YTc4NThmZTVlMmUgKCJib2FyZDogcGh5dGVjOiBzb21fZGV0ZWN0aW9uOiBtb3ZlIGRlZmluaXRp
b25zIHRvIHNvdXJjZSBmaWxlIikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBZYW5uaWMgTW9vZyA8eS5t
b29nQHBoeXRlYy5kZT4NCj4gDQo+IFRoaXMgY2F1c2VzIGJ1aWxkIGZhaWx1cmU6DQo+IA0KPiBo
dHRwczovL3NvdXJjZS5kZW54LmRlL3UtYm9vdC9jdXN0b2RpYW5zL3UtYm9vdC1pbXgvLS9qb2Jz
Lzc2OTQyMQ0KDQpUaGFuayB5b3UsIEkgd2lsbCBzZW5kIGFuIHVwZGF0ZWQgdmVyc2lvbi4NCg==
