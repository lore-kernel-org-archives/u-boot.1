Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2B0EC27C5E
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 08:08:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2936F884C9;
	Tue, 11 Jun 2024 10:08:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="ejvqpcSF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11BAD883D3; Tue, 11 Jun 2024 10:08:41 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15F8B885CC
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 10:08:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=T.Remmet@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1718093318; x=1720685318;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gOnkiVEmuzuvnq3sGPICQFZXiCpkLFu0LoXQ1S/MRzs=;
 b=ejvqpcSFXQct73fGO/CP5sJKWlqJbgiCCmdtOIvbSZcA6WNB+b0B2nIe22zB9zUo
 ypQriX+uQtYNKSr+KFiYJTAuU1FEVoXieIBHHf+tG1sZg6I6GhVmSB5gTshoHvpj
 WtZayoiZMlOUjDVjBMtayJRgbHysiyFnegOSwaT8t2k=;
X-AuditID: ac14000a-03e52700000021bc-da-666806062afe
Received: from florix.phytec.de (Unknown_Domain [172.25.0.13])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 2E.B1.08636.60608666;
 Tue, 11 Jun 2024 10:08:38 +0200 (CEST)
Received: from Berlix.phytec.de (172.25.0.12) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 11 Jun
 2024 10:08:38 +0200
Received: from Berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4]) by
 berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4%4]) with mapi id 15.01.2507.006;
 Tue, 11 Jun 2024 10:08:38 +0200
From: Teresa Remmet <T.Remmet@phytec.de>
To: "u-boot@lists.phytec.de" <u-boot@lists.phytec.de>, Wadim Egorov
 <W.Egorov@phytec.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "upstream@lists.phytec.de" <upstream@lists.phytec.de>
CC: "trini@konsulko.com" <trini@konsulko.com>
Subject: Re: [U-boot] [PATCH 01/13] arch: arm: dts: k3-am625-phyboard-lyra:
 Add fixed partitions
Thread-Topic: [U-boot] [PATCH 01/13] arch: arm: dts: k3-am625-phyboard-lyra:
 Add fixed partitions
Thread-Index: AQHau9aQrfpaBAxVbEiLV9qQh3UhPQ==
Date: Tue, 11 Jun 2024 08:08:38 +0000
Message-ID: <1d1aa06eafb110b96fa5a46ccc7ab5d226946f3d.camel@phytec.de>
References: <20240610133352.2473414-1-w.egorov@phytec.de>
 <20240610133352.2473414-2-w.egorov@phytec.de>
In-Reply-To: <20240610133352.2473414-2-w.egorov@phytec.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.0.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <02D139CE82DE8042A7F0738C5531D0B6@phytec.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsWyRpKBV5eNLSPN4M47Y4upkzazW7zd28lu
 8a5vP5NF9zt1BxaPVwdWsXucvbOD0aO/u4U1gDmKyyYlNSezLLVI3y6BK2POx2UsBZMUKk5P
 2cfcwLhCvouRk0NCwETi5exf7F2MXBxCAkuYJGZPW8MI4dxnlLg29TUrhLOBUWLF1ZXMIC1s
 AhoSL090M4EkRAQOMUq0nZ4ElmAW0JXYOvMXUDsHh7BAksSxLTwgYRGBZIlL916wQ9h6Eg/P
 rWcHKWERUJV4Ny0cJMwr4CYx9cx5VhBbSCBL4lbzViaQEk4BK4mdd/xBwowCshIbNpyHWiQu
 senZd1aIBwQkluyBiEsIiEq8fPwPKi4vceLWNLAxzAKaEut36UO0WkisetPFCmErSkzpfsgO
 cYGgxMmZT1gmMIrPQrJhFkL3LCTds5B0z0LSvYCRdRWjUG5mcnZqUWa2XkFGZUlqsl5K6iZG
 UASKMHDtYOyb43GIkYmDERhuHMxKIrxnYtLThHhTEiurUovy44tKc1KLDzFKc7AoifOu7ghO
 FRJITyxJzU5NLUgtgskycXBKNTCqzX7mxtOZlVe+ulYtJ0vi9/3i2tLen9VP5GfXv2PcVbv0
 6yWlpyEpAuHJbFkH1zKvUj/v9Opx36fLRze+Ouz3+qMT8/vKjSls0/KaOv99fjmvf5OZhphh
 E/97r7seHpIvJkXuf7XdLohHV3L5aWPWc2s2dsguMstYVibRpGmZKCQvefu4s5MSS3FGoqEW
 c1FxIgCl/aLdrgIAAA==
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

SGVsbG8gV2FkaW0sCgpBbSBNb250YWcsIGRlbSAxMC4wNi4yMDI0IHVtIDE1OjMzICswMjAwIHNj
aHJpZWIgV2FkaW0gRWdvcm92OgoKPiBGcm9tOiBOYXRoYW4gTW9ycmlzc29uIDxubW9ycmlzc29u
QHBoeXRlYy5jb20+Cj4gCj4gQWRkIGEgZml4ZWQgcGFydGl0aW9ucyBub2RlIHRvIHRoZSBBTTYy
eCBkZXZpY2UgdHJlZSBzbyB0aGF0IGl0IGNhbgo+IGJlIHVzZWQgdG8gZml4dXAgdGhlIExpbnV4
IGRldmljZSB0cmVlLgoKZm9yIHdoaWNoIGJyYW5jaCBpcyB0aGlzIHNlcmllcz8KClJlZ2FyZHMs
ClRlcmVzYQoKPiAKPiBTaWduZWQtb2ZmLWJ5OiBOYXRoYW4gTW9ycmlzc29uIDxubW9ycmlzc29u
QHBoeXRlYy5jb20+Cj4gU2lnbmVkLW9mZi1ieTogV2FkaW0gRWdvcm92IDx3LmVnb3JvdkBwaHl0
ZWMuZGU+Cj4gLS0tCj4gwqAuLi4vazMtYW02MjUtcGh5Ym9hcmQtbHlyYS1yZGstdS1ib290LmR0
c2nCoMKgwqAgfCAyNgo+ICsrKysrKysrKysrKysrKysrKysKPiDCoDEgZmlsZSBjaGFuZ2VkLCAy
NiBpbnNlcnRpb25zKCspCj4gCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2R0cy9rMy1hbTYyNS1w
aHlib2FyZC1seXJhLXJkay11LWJvb3QuZHRzaQo+IGIvYXJjaC9hcm0vZHRzL2szLWFtNjI1LXBo
eWJvYXJkLWx5cmEtcmRrLXUtYm9vdC5kdHNpCj4gaW5kZXggOTQxNjIyODIwNjguLjdjNzZhY2Mw
ZDU5IDEwMDY0NAo+IC0tLSBhL2FyY2gvYXJtL2R0cy9rMy1hbTYyNS1waHlib2FyZC1seXJhLXJk
ay11LWJvb3QuZHRzaQo+ICsrKyBiL2FyY2gvYXJtL2R0cy9rMy1hbTYyNS1waHlib2FyZC1seXJh
LXJkay11LWJvb3QuZHRzaQo+IEBAIC0xMjcsNiArMTI3LDMyIEBACj4gwqAKPiDCoMKgwqDCoMKg
wqDCoMKgZmxhc2hAMCB7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBib290cGgt
YWxsOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBwYXJ0aXRpb25zIHsKPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNvbXBhdGlibGUgPSAi
Zml4ZWQtcGFydGl0aW9ucyI7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAjYWRkcmVzcy1jZWxscyA9IDwxPjsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCNzaXplLWNlbGxzID0gPDE+Owo+ICsKPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHBhcnRpdGlvbkAwIHsKPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBsYWJlbCA9ICJvc3BpLnRpYm9vdDMiOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJlZyA9IDwweDAwMDAwIDB4ODAw
MDA+Owo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfTsK
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHBhcnRpdGlv
bkA4MDAwMCB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgbGFiZWwgPSAib3NwaS50aXNwbCI7Cj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmVnID0gPDB4
MDgwMDAwIDB4MjAwMDAwPjsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoH07Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBwYXJ0aXRpb25AMjgwMDAwIHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBsYWJlbCA9ICJvc3BpLnUtYm9vdCI7Cj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgcmVnID0gPDB4MjgwMDAwIDB4NDAwMDAwPjsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoH07Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBwYXJ0aXRpb25ANjgwMDAwIHsKPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBsYWJlbCA9ICJv
c3BpLmVudiI7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgcmVnID0gPDB4NjgwMDAwIDB4NDAwMDA+Owo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfTsKPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHBhcnRpdGlvbkA2YzAwMDAgewo+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oGxhYmVsID0gIm9zcGkuZW52LmJhY2t1cCI7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmVnID0gPDB4NmMwMDAwIDB4NDAw
MDA+Owo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfTsK
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfTsKPiDCoMKgwqDCoMKgwqDCoMKgfTsK
PiDCoH07Cj4gwqAKCi0tIApQSFlURUMgTWVzc3RlY2huaWsgR21iSCB8IEJhcmNlbG9uYS1BbGxl
ZSAxIHwgNTUxMjkgTWFpbnosIEdlcm1hbnkKCkdlc2Now6RmdHNmw7xocmVyOiBEaXBsLi1Jbmcu
IE1pY2hhZWwgTWl0ZXpraSwgRGlwbC4tSW5nLiBCb2RvIEh1YmVyLApEaXBsLi1JbmcuIChGSCkg
TWFya3VzIExpY2tlcyB8IEhhbmRlbHNyZWdpc3RlciBNYWlueiBIUkIgNDY1NiB8CkZpbmFuemFt
dCBNYWlueiB8IFN0Lk5yLiAyNjY1MDA2MDgsIERFIDE0OTA1OTg1NQo=
