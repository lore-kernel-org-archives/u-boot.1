Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E1C7C3065C
	for <u-boot@archiver.kernel.org>; Thu,  4 Jul 2024 06:41:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC80D88886;
	Thu,  4 Jul 2024 08:40:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="nHipltOL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A4F788895; Thu,  4 Jul 2024 08:40:58 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0364D88886
 for <u-boot@lists.denx.de>; Thu,  4 Jul 2024 08:40:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=T.Remmet@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1720075255; x=1722667255;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YSejrT6dnb8ejF3pqr+yVWn2sTCQ9Pd0h5So7q3QeVs=;
 b=nHipltOL2l7cd2pHAuAx2i5vtI6KpjKFqOIzl9vAUn7h5BLHMCv8gJZjF+1xFXSI
 +9ignFLojzU8QnGseOyBJE7GOfcS8ZjAKqPnSgO3Z8t27wHskFOLrTNR55utWwpO
 0YI/HVRMyt4d0Pst09fiJVOKp4PWXWUz6N5ekMCFmQc=;
X-AuditID: ac14000a-03e52700000021bc-68-668643f77b71
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 21.B4.08636.7F346866;
 Thu,  4 Jul 2024 08:40:55 +0200 (CEST)
Received: from Berlix.phytec.de (172.25.0.12) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 4 Jul 2024
 08:40:55 +0200
Received: from Berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4]) by
 berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4%4]) with mapi id 15.01.2507.006;
 Thu, 4 Jul 2024 08:40:55 +0200
From: Teresa Remmet <T.Remmet@phytec.de>
To: PHYTEC Upstream <upstream@lists.phytec.de>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, Daniel Schultz <D.Schultz@phytec.de>,
 "joe.hershberger@ni.com" <joe.hershberger@ni.com>, "trini@konsulko.com"
 <trini@konsulko.com>, "m.othacehe@gmail.com" <m.othacehe@gmail.com>, "Wadim
 Egorov" <W.Egorov@phytec.de>
CC: "d-gole@ti.com" <d-gole@ti.com>, "festevam@gmail.com"
 <festevam@gmail.com>, "sjg@chromium.org" <sjg@chromium.org>, Benjamin Hahn
 <B.Hahn@phytec.de>, "mkorpershoek@baylibre.com" <mkorpershoek@baylibre.com>
Subject: Re: [PATCH 2/9] phycore-imx8mp: Add overlay and bootenv.txt support
Thread-Topic: [PATCH 2/9] phycore-imx8mp: Add overlay and bootenv.txt support
Thread-Index: AQHazQvMeTD7D8Vw3E2BuuSEG7UCKLHl/p0A
Date: Thu, 4 Jul 2024 06:40:55 +0000
Message-ID: <ff53319cd7c520ead4169759544f3ab4f2d0e52a.camel@phytec.de>
References: <20240703054202.2812540-1-d.schultz@phytec.de>
 <20240703054202.2812540-3-d.schultz@phytec.de>
In-Reply-To: <20240703054202.2812540-3-d.schultz@phytec.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.0.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <43D3BB47141F244CAA89960677DE9EE3@phytec.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHIsWRmVeSWpSXmKPExsWyRpKBR/e7c1uawa6PKhYtaz0sHl71t/i0
 8zGrxYyb09gsXhyby27xbcs2RoupkzazW7zd28lu0f1O3YHT4/2NVnaP2Q0XWTx2zrrL7vHq
 wCp2j7N3djB69He3sHpcP7OdyeP4je1MARxRXDYpqTmZZalF+nYJXBkvGw+zFHwzqHi06yN7
 A+MV/S5GTg4JAROJDW8bmboYuTiEBJYwScx6uYoNwrnHKPHn8DpGCGc9o8Tmji8sIC1sAhoS
 L090g7WICOxlkrjdtAKsilngCqPE36ZPTCBVwgI+EjM+XGMGsUUEfCX6njxngrCNJI7uWAA2
 iUVAReLz05NsIDavgJvE2e0PgWo4gNblSGzvSAMJcwpYS/xp+ABWziggK7Fhw3mwkcwC4hKb
 nn1nhfhBQGLJHoi4hICoxMvH/6Di8hInbk0DG8ksoCmxfpc+RKuFxJqua0wQtqLElO6H7BAX
 CEqcnPmEZQKj+CwkG2YhdM9C0j0LSfcsJN0LGFlXMQrlZiZnpxZlZusVZFSWpCbrpaRuYgTF
 uQgD1w7GvjkehxiZOBgPMUpwMCuJ8Eq9b04T4k1JrKxKLcqPLyrNSS0+xCjNwaIkzru6IzhV
 SCA9sSQ1OzW1ILUIJsvEwSnVwBhygPvi+8Am57RbeeHN/4vm/t+aPUuy0jYzqZTTc2F56xLh
 BfubH/p9an7EFr6oYJ1x5m/OdW1VP7ym3FytKvdE//H2c14P2NevDVsikdq07V/8STdNqY/T
 FIOcfRZoHby39IxqfNledXnhhgKpYC/3ZasaevlTZyd4zPt6rO+PWbT13p9f/ZRYijMSDbWY
 i4oTAToH/5fhAgAA
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

QW0gRGllbnN0YWcsIGRlbSAwMi4wNy4yMDI0IHVtIDIyOjQxIC0wNzAwIHNjaHJpZWIgRGFuaWVs
IFNjaHVsdHo6Cj4gRnJvbTogQmVuamFtaW4gSGFobiA8Qi5IYWhuQHBoeXRlYy5kZT4KPiAKPiBB
ZGQgc3VwcG9ydCBmb3IgbG9hZGluZyBib290ZW52LnR4dCBhcyB3ZWxsIGFzIGxvYWRpbmcgYW5k
IGFwcGx5aW5nCj4gb3ZlcmxheXMgZHVyaW5nIGJvb3QgZnJvbSBtbWMgYW5kIG5ldC4KPiAKPiAk
e25vX2Jvb3RlbnZ9OiBQcmV2ZW50IGxvYWRpbmcgZXh0ZXJuYWwgYm9vdGVudi50eHQgZW52aXJv
bm1lbnQuIFVzZQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJHtvdmVybGF5c30gdmFy
aWFibGUgZGlyZWN0bHkgZnJvbSB1LWJvb3QgZW52aXJvbm1lbnQuCj4gJHtub19vdmVybGF5fTog
RG8gbm90IGxvYWQgb3ZlcmxheXMgZGVmaW5lZCBpbiAke292ZXJsYXlzfSB2YXJpYWJsZS4KPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIE92ZXJsYXlzIGxvYWRlZCBvdmVyIHRoZSBleHRl
bnNpb24gY29tbWFuZCBhcmUgc3RpbGwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJl
aW5nIGFwcGxpZWQuCj4gCj4gU2lnbmVkLW9mZi1ieTogQmVuamFtaW4gSGFobiA8Qi5IYWhuQHBo
eXRlYy5kZT4KPiBTaWduZWQtb2ZmLWJ5OiBEYW5pZWwgU2NodWx0eiA8ZC5zY2h1bHR6QHBoeXRl
Yy5kZT4KClJldmlld2VkLWJ5OiBUZXJlc2EgUmVtbWV0IDx0LnJlbW1ldEBwaHl0ZWMuZGU+Cgo+
IC0tLQo+IMKgYm9hcmQvcGh5dGVjL3BoeWNvcmVfaW14OG1wL3BoeWNvcmVfaW14OG1wLmVudiB8
IDE1ICsrKysrKysrKysrKysrKwo+IMKgY29uZmlncy9waHljb3JlLWlteDhtcF9kZWZjb25maWfC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCA2ICsrKy0tLQo+IMKgMiBmaWxlcyBjaGFu
Z2VkLCAxOCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9i
b2FyZC9waHl0ZWMvcGh5Y29yZV9pbXg4bXAvcGh5Y29yZV9pbXg4bXAuZW52Cj4gYi9ib2FyZC9w
aHl0ZWMvcGh5Y29yZV9pbXg4bXAvcGh5Y29yZV9pbXg4bXAuZW52Cj4gaW5kZXggN2Y2YzVmZDJj
NzYuLjRlZDVkYzdlMjcyIDEwMDY0NAo+IC0tLSBhL2JvYXJkL3BoeXRlYy9waHljb3JlX2lteDht
cC9waHljb3JlX2lteDhtcC5lbnYKPiArKysgYi9ib2FyZC9waHl0ZWMvcGh5Y29yZV9pbXg4bXAv
cGh5Y29yZV9pbXg4bXAuZW52Cj4gQEAgLTEsNCArMSw1IEBACj4gwqAjaW5jbHVkZSA8ZW52L3Bo
eXRlYy9yYXVjLmVudj4KPiArI2luY2x1ZGUgPGVudi9waHl0ZWMvb3ZlcmxheXMuZW52Pgo+IMKg
Cj4gwqBib290Y21kPQo+IMKgwqDCoMKgwqDCoMKgwqBpZiB0ZXN0ICR7ZG9mYXN0Ym9vdH0gPSAx
OyB0aGVuCj4gQEAgLTE2LDYgKzE3LDggQEAgYm9vdGNtZD0KPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoGZpOwo+IMKgwqDCoMKgwqDCoMKgwqBmaTsKPiDCoGNvbnNvbGU9dHR5bXhj
MCwxMTUyMDAKPiArYm9vdGVudl9hZGRyPTB4NDkxMDAwMDAKPiArZmR0b19hZGRyPTB4NDkwMDAw
MDAKPiDCoGRvZmFzdGJvb3Q9MAo+IMKgZW1tY19kZXY9Mgo+IMKgZmFzdGJvb3RfcmF3X3BhcnRp
dGlvbl9hbGw9MCA0MTk0MzA0Cj4gQEAgLTMyLDggKzM1LDE0IEBAIG1tY2FyZ3M9Cj4gwqBtbWNh
dXRvZGV0ZWN0PXllcwo+IMKgbW1jYm9vdD0KPiDCoMKgwqDCoMKgwqDCoMKgZWNobyBCb290aW5n
IGZyb20gbW1jIC4uLjsKPiArwqDCoMKgwqDCoMKgwqBpZiB0ZXN0ICR7bm9fYm9vdGVudn0gPSAw
OyB0aGVuCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIHJ1biBtbWNfbG9hZF9i
b290ZW52OyB0aGVuCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBlbnYgaW1wb3J0IC10ICR7Ym9vdGVudl9hZGRyfSAke2ZpbGVzaXplfTsKPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZmk7Cj4gK8KgwqDCoMKgwqDCoMKgZmk7Cj4gwqDCoMKg
wqDCoMKgwqDCoHJ1biBtbWNhcmdzOwo+IMKgwqDCoMKgwqDCoMKgwqBpZiBydW4gbG9hZGZkdDsg
dGhlbgo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBydW4gbW1jX2FwcGx5X292ZXJs
YXlzOwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYm9vdGkgJHtsb2FkYWRkcn0g
LSAke2ZkdF9hZGRyfTsKPiDCoMKgwqDCoMKgwqDCoMKgZWxzZQo+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgZWNobyBXQVJOOiBDYW5ub3QgbG9hZCB0aGUgRFQ7Cj4gQEAgLTUxLDkg
KzYwLDE1IEBAIG5ldGJvb3Q9Cj4gwqDCoMKgwqDCoMKgwqDCoGVsc2UKPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoHNldGVudiBnZXRfY21kIHRmdHA7Cj4gwqDCoMKgwqDCoMKgwqDC
oGZpOwo+ICvCoMKgwqDCoMKgwqDCoGlmIHRlc3QgJHtub19ib290ZW52fSA9IDA7IHRoZW4KPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgcnVuIG5ldF9sb2FkX2Jvb3RlbnY7IHRo
ZW4KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGVudiBp
bXBvcnQgLXQgJHtib290ZW52X2FkZHJ9ICR7ZmlsZXNpemV9Owo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBmaTsKPiArwqDCoMKgwqDCoMKgwqBmaTsKPiDCoMKgwqDCoMKgwqDCoMKg
JHtnZXRfY21kfSAke2xvYWRhZGRyfSAke2ltYWdlfTsKPiDCoMKgwqDCoMKgwqDCoMKgcnVuIG5l
dGFyZ3M7Cj4gwqDCoMKgwqDCoMKgwqDCoGlmICR7Z2V0X2NtZH0gJHtmZHRfYWRkcn0gJHtmZHRf
ZmlsZX07IHRoZW4KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcnVuIG5ldF9hcHBs
eV9vdmVybGF5czsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGJvb3RpICR7bG9h
ZGFkZHJ9IC0gJHtmZHRfYWRkcn07Cj4gwqDCoMKgwqDCoMKgwqDCoGVsc2UKPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoGVjaG8gV0FSTjogQ2Fubm90IGxvYWQgdGhlIERUOwo+IGRp
ZmYgLS1naXQgYS9jb25maWdzL3BoeWNvcmUtaW14OG1wX2RlZmNvbmZpZyBiL2NvbmZpZ3MvcGh5
Y29yZS0KPiBpbXg4bXBfZGVmY29uZmlnCj4gaW5kZXggN2IxNmU4ZWY1OGUuLmUyMGE0M2UyNjc0
IDEwMDY0NAo+IC0tLSBhL2NvbmZpZ3MvcGh5Y29yZS1pbXg4bXBfZGVmY29uZmlnCj4gKysrIGIv
Y29uZmlncy9waHljb3JlLWlteDhtcF9kZWZjb25maWcKPiBAQCAtNSw2ICs1LDcgQEAgQ09ORklH
X1NZU19NQUxMT0NfTEVOPTB4MjAwMDAwMAo+IMKgQ09ORklHX1NQTF9HUElPPXkKPiDCoENPTkZJ
R19TUExfTElCQ09NTU9OX1NVUFBPUlQ9eQo+IMKgQ09ORklHX1NQTF9MSUJHRU5FUklDX1NVUFBP
UlQ9eQo+ICtDT05GSUdfUEhZVEVDX1NPTV9ERVRFQ1RJT049eQo+IMKgQ09ORklHX0VOVl9TSVpF
PTB4MTAwMDAKPiDCoENPTkZJR19FTlZfT0ZGU0VUPTB4M0MwMDAwCj4gwqBDT05GSUdfU1lTX0ky
Q19NWENfSTJDMT15Cj4gQEAgLTEyLDcgKzEzLDcgQEAgQ09ORklHX0RNX0dQSU89eQo+IMKgQ09O
RklHX0RFRkFVTFRfREVWSUNFX1RSRUU9ImZyZWVzY2FsZS9pbXg4bXAtcGh5Ym9hcmQtcG9sbHV4
LXJkayIKPiDCoENPTkZJR19TUExfVEVYVF9CQVNFPTB4OTIwMDAwCj4gwqBDT05GSUdfVEFSR0VU
X1BIWUNPUkVfSU1YOE1QPXkKPiAtQ09ORklHX1BIWVRFQ19TT01fREVURUNUSU9OPXkKPiArQ09O
RklHX09GX0xJQkZEVF9PVkVSTEFZPXkKPiDCoENPTkZJR19TWVNfTU9OSVRPUl9MRU49NTI0Mjg4
Cj4gwqBDT05GSUdfU1BMX01NQz15Cj4gwqBDT05GSUdfU1BMX1NFUklBTD15Cj4gQEAgLTQ5LDgg
KzUwLDYgQEAgQ09ORklHX1NQTF9QT1dFUj15Cj4gwqBDT05GSUdfU1BMX1dBVENIRE9HPXkKPiDC
oENPTkZJR19IVVNIX1BBUlNFUj15Cj4gwqBDT05GSUdfU1lTX1BST01QVD0idS1ib290PT4gIgo+
IC0jIENPTkZJR19DTURfRVhQT1JURU5WIGlzIG5vdCBzZXQKPiAtIyBDT05GSUdfQ01EX0lNUE9S
VEVOViBpcyBub3Qgc2V0Cj4gwqAjIENPTkZJR19DTURfQ1JDMzIgaXMgbm90IHNldAo+IMKgQ09O
RklHX0NNRF9FRVBST009eQo+IMKgQ09ORklHX1NZU19JMkNfRUVQUk9NX0FERFJfTEVOPTIKPiBA
QCAtNzQsNiArNzMsNyBAQCBDT05GSUdfQ01EX0VYVDI9eQo+IMKgQ09ORklHX0NNRF9FWFQ0PXkK
PiDCoENPTkZJR19DTURfRVhUNF9XUklURT15Cj4gwqBDT05GSUdfQ01EX0ZBVD15Cj4gK0NPTkZJ
R19DTURfRlNfR0VORVJJQz15Cj4gwqBDT05GSUdfT0ZfQ09OVFJPTD15Cj4gwqBDT05GSUdfU1BM
X09GX0NPTlRST0w9eQo+IMKgQ09ORklHX0VOVl9PVkVSV1JJVEU9eQoKLS0gClBIWVRFQyBNZXNz
dGVjaG5payBHbWJIIHwgQmFyY2Vsb25hLUFsbGVlIDEgfCA1NTEyOSBNYWlueiwgR2VybWFueQoK
R2VzY2jDpGZ0c2bDvGhyZXI6IERpcGwuLUluZy4gTWljaGFlbCBNaXRlemtpLCBEaXBsLi1Jbmcu
IEJvZG8gSHViZXIsCkRpcGwuLUluZy4gKEZIKSBNYXJrdXMgTGlja2VzIHwgSGFuZGVsc3JlZ2lz
dGVyIE1haW56IEhSQiA0NjU2IHwKRmluYW56YW10IE1haW56IHwgU3QuTnIuIDI2NjUwMDYwOCwg
REUgMTQ5MDU5ODU1Cg==
