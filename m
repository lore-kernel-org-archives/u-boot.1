Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12EB3D3B7FF
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 10:45:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 709AA89A30;
	Mon, 25 Nov 2024 11:45:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.net header.i=wahrenst@gmx.net header.b="O5xVNF56";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDBC289A34; Mon, 25 Nov 2024 11:45:44 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C051F89A2F
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 11:45:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=wahrenst@gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
 s=s31663417; t=1732531534; x=1733136334; i=wahrenst@gmx.net;
 bh=9W7+BT77vV1Bx0QW07yl5ekRmE28teMmNxLdGuG7rMI=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=O5xVNF567G8AXljzRB7NRfwlq5nO5yVdM4ti6pvIRA66/r0ApdhSrM3YkN1QOleE
 OXiYi+l84P2TawYq7eknGlQv7jbAe391e8sC8GfAOxpltTkzi02YRJ5FxdqecevP8
 bN7RJT4a/pMBR4LlrYHXS6ECWbWYQUTs0eFi6ZcsSQUioRR1ecAL4B8sZSV5S4XWr
 rR5dvTLAFXXCnpAYanNDpoI7lP3BibsTv6+QDFka0rePSi6TtIWo0acUhHOBlkq+g
 KY1NUDqVqzzlwwoAX6IzhIxlPAoZ/2J0zJxxgv2n9IyRnajYG5s3E6XmDrW7QtyDx
 39FDAju7ZJCGtDs9hA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.105] ([37.4.251.153]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MZCb5-1tBLax0Jbl-00Iggt; Mon, 25
 Nov 2024 11:45:34 +0100
Message-ID: <54bc32b3-4cfc-4b78-a2e0-b3bbca669747@gmx.net>
Date: Mon, 25 Nov 2024 11:45:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] board: phytec: imx93: Add eeprom-based hardware
 introspection
To: Christoph Stoidner <C.Stoidner@phytec.de>,
 PHYTEC Upstream <upstream@lists.phytec.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Yannic Moog <Y.Moog@phytec.de>, Wadim Egorov <W.Egorov@phytec.de>,
 "trini@konsulko.com" <trini@konsulko.com>,
 "festevam@gmail.com" <festevam@gmail.com>,
 Andrej Picej <andrej.picej@norik.com>, "sbabic@denx.de" <sbabic@denx.de>,
 "uboot-imx@nxp.com" <uboot-imx@nxp.com>,
 Primoz Fiser <primoz.fiser@norik.com>,
 "m.othacehe@gmail.com" <m.othacehe@gmail.com>
References: <20241120163143.127862-1-c.stoidner@phytec.de>
 <20241120163143.127862-3-c.stoidner@phytec.de>
 <371c6302-438b-45b6-944b-d513f74f38a5@gmx.net>
 <05db2b94c4eb28aefc33a13c6fb2fa324eb62ee7.camel@phytec.de>
 <8c8607a0-f8b0-438e-886e-a637a561366c@gmx.net>
 <09138aea8ba35d7bb8d4d8d7912f4cc54a96862b.camel@phytec.de>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <09138aea8ba35d7bb8d4d8d7912f4cc54a96862b.camel@phytec.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:VPoJ6asLmnQ7Jr+f+cOnwqhk3/8ywaJjKLvcG98AicBw20pxBod
 jzzSmQosXOncH2zlg8q5cqRxUTC0OUG5RjGterVk1Gy7CGDb2uHdqpWS/eBcnOj9FALMeCb
 3CZuJ+9Xg6/Y1M+hw9c8O1Q0J4vppJB6N5O9C6RHyWOB1BlK8wwKbwWNhl0ndpCAR39e+/b
 xghDWnq2sNGiCV+FknEmQ==
UI-OutboundReport: notjunk:1;M01:P0:gEJxt+sZVfc=;7nk5TGELdxpkTkPI6KQIhJlcbUK
 gx5Uk96bfWqPcaAIWZWhlt9y91uPa3GRlloHsovfwXOjB/IKa7F6+4VlyBM+ugdG1v2uD4w4C
 B3pYvVrhBOA0TVt2T0E0TGxY5cnbQ5wDSN+YghQnIdN4MGJBAdVSZ4UiAbNLj7G+luKQEYbdK
 TPXM+Xi4TUUqEMXQWsALWSlaHLPCOsnZcMBLb9oLZsN9m+VA/bjiVwpJDyWAOPfOrWOnQnbpG
 kUDaHbYe2vyLmS4zUzn5pHFJlVfCHDxZDVoo46LsIrFRoKzVdZaDX4UxcbRom6dCgA1dF87X+
 XJjnj7VgYPmiIhYJpq/YTlrhStpS2VeF/flpmJ9bSd39VZ6ETWY2zRtBkfylcmD1JI1T5hArp
 8j7gZUmRRtTrosfQE89IwB6rjEHrP2K93zibQlY8I/pJmtiN7Ij9f5alJ9kfo30uXsZFiz2pQ
 t05X/xPP8LNIkBG2WCM40p+y6SBLBHCnGASOL6SfSTn11or/m/Ae2M0Ie0sNQz014K9aKbI4N
 JjY3wz0EZmmCSTVBoqNuv9I2f/yKKnaAV4lN76LckI92VjWuRtUeXMhEM88s7+/c/byEtCVFL
 cf/XQ/LPCIZ7sqM/0BaERkjErI4pa/ntzcQonjAalF37oQUu3yc3LpnUfsMygZgxfYB3BKP2E
 btEkJM2roMzRuvAs872RZNs3nADwlifSY61v1Gmcdn3ZbH6gJVTflDZx9CSrlbkHxWPVlFzPg
 wDQOZ37cwjkIqRuvaXxLTulJOxymGprKPipMD39Nf7aIG1fXhr2fS9D2HOw1khprDNA8iSkBF
 rOIWmq/YKup7CFKRW4H1Gef8Y8umAf2fb6lsuf15IH1r4N/UoIyWY2Fhyn8M7q29GzL9v9JnO
 SEmycx28BnUH4ZBnJ0OOw9rTusbsSzlvp5diTOuSLjvckRA6Hegfa4Ox+gCNaasYjkacYiPNE
 8P0IaIlhaZwA+SKQByThTKbLUopSn/xxiOnv+IreD+TvKmrSL9Ws11lcwLBNyzEvqtUQqnCNl
 lQbBhNrryMsh8yKv0nuB1d73E/mj6ns05/pBXtps3GysssTpoXe5CZx+VNR5DSn6T7ea+kwDb
 1r0SEpidqG0QXl9NAQWsA7wkFJqsI5
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

QW0gMjUuMTEuMjQgdW0gMTE6MDMgc2NocmllYiBDaHJpc3RvcGggU3RvaWRuZXI6DQo+IEhpIFN0
ZWZhbiwNCj4NCj4gT24gTW8sIDIwMjQtMTEtMjUgYXQgMTA6MzkgKzAxMDAsIFN0ZWZhbiBXYWhy
ZW4gd3JvdGU6DQo+PiBIaSBDaHJpc3RvcGgsDQo+Pg0KPj4gQW0gMjUuMTEuMjQgdW0gMDk6Mjgg
c2NocmllYiBDaHJpc3RvcGggU3RvaWRuZXI6DQo+Pj4gSGkgU3RlZmFuLA0KPj4+DQo+Pj4gT24g
RG8sIDIwMjQtMTEtMjEgYXQgMTE6MTIgKzAxMDAsIFN0ZWZhbiBXYWhyZW4gd3JvdGU6DQo+Pj4+
IEhpIENocmlzdG9waCwNCj4+Pj4NCj4+Pj4gQW0gMjAuMTEuMjQgdW0gMTc6MzEgc2NocmllYiBD
aHJpc3RvcGggU3RvaWRuZXI6DQo+Pj4+DQo+Pj4gWy4uLl0NCj4+Pg0KPj4+Pj4gZGlmZiAtLWdp
dCBhL2FyY2gvYXJtL2R0cy9pbXg5My1waHlib2FyZC1zZWdpbi11LWJvb3QuZHRzaQ0KPj4+Pj4g
Yi9hcmNoL2FybS9kdHMvaW14OTMtcGh5Ym9hcmQtc2VnaW4tdS1ib290LmR0c2kNCj4+Pj4+IGlu
ZGV4IDY4OTdjOTFmNGQuLjcwMmQ4NmY0ZTAgMTAwNjQ0DQo+Pj4+PiAtLS0gYS9hcmNoL2FybS9k
dHMvaW14OTMtcGh5Ym9hcmQtc2VnaW4tdS1ib290LmR0c2kNCj4+Pj4+ICsrKyBiL2FyY2gvYXJt
L2R0cy9pbXg5My1waHlib2FyZC1zZWdpbi11LWJvb3QuZHRzaQ0KPj4+Pj4gQEAgLTEzOSw2ICsx
MzksMTMgQEANCj4+Pj4+ICDCoMKgICZ1c2RoYzEgew0KPj4+Pj4gIMKgwqDCoMKgwqDCoMKgwqDC
oGJvb3RwaC1wcmUtcmFtOw0KPj4+Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoGJvb3RwaC1zb21lLXJh
bTsNCj4+Pj4+ICvCoMKgwqDCoMKgwqDCoC8qDQo+Pj4+PiArwqDCoMKgwqDCoMKgwqAgKiBSZW1v
dmUgcGluY3RybCBhc3NpZ25tZW50cyBvbmNlIHRoZXkgYXJlIGFkZGVkIHRvDQo+Pj4+PiBpbXg5
My0NCj4+Pj4+IHBoeWNvcmUtc29tLmR0c2kNCj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCAqLw0KPj4+
Pj4gK8KgwqDCoMKgwqDCoMKgcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IiwgInN0YXRlXzEwMG1o
eiIsDQo+Pj4+PiAic3RhdGVfMjAwbWh6IjsNCj4+Pj4+ICvCoMKgwqDCoMKgwqDCoHBpbmN0cmwt
MCA9IDwmcGluY3RybF91c2RoYzE+Ow0KPj4+Pj4gK8KgwqDCoMKgwqDCoMKgcGluY3RybC0xID0g
PCZwaW5jdHJsX3VzZGhjMV8xMDBtaHo+Ow0KPj4+Pj4gK8KgwqDCoMKgwqDCoMKgcGluY3RybC0y
ID0gPCZwaW5jdHJsX3VzZGhjMV8yMDBtaHo+Ow0KPj4+Pj4gIMKgwqAgfTsNCj4+Pj4+DQo+Pj4+
PiAgwqDCoCAmdXNkaGMyIHsNCj4+Pj4+IEBAIC0yMTUsNiArMjIyLDQ4IEBADQo+Pj4+PiAgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBNWDkzX1BBRF9F
TkVUMl9SRDNfX0dQSU80X0lPMjcNCj4+Pj4+ICDCoMKgwqDCoMKgwqAweDMxZQ0KPj4+Pj4gIMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqA+Ow0KPj4+Pj4gIMKgwqDCoMKgwqDCoMKg
wqDCoH07DQo+Pj4+PiArDQo+Pj4+PiArwqDCoMKgwqDCoMKgwqAvKg0KPj4+Pj4gK8KgwqDCoMKg
wqDCoMKgICogUmVtb3ZlIHBpbmN0cmxfdXNkaGMxXzEwMG1oeiBhbmQNCj4+Pj4+IHBpbmN0cmxf
dXNkaGMxXzIwMG1oeg0KPj4+Pj4gb25jZSB0aGV5DQo+Pj4+PiArwqDCoMKgwqDCoMKgwqAgKiBh
cmUgYWRkZWQgdG8gaW14OTMtcGh5Y29yZS1zb20uZHRzaQ0KPj4+Pj4gK8KgwqDCoMKgwqDCoMKg
ICovDQo+Pj4+PiArwqDCoMKgwqDCoMKgwqAvKiBuZWVkIHRvIGNvbmZpZyB0aGUgU0lPTiBmb3Ig
ZGF0YSBhbmQgY21kIHBhZCwgcmVmZXINCj4+Pj4+IHRvDQo+Pj4+PiBFUlIwNTIwMjEgKi8NCj4+
Pj4+ICvCoMKgwqDCoMKgwqDCoHBpbmN0cmxfdXNkaGMxXzEwMG1oejogdXNkaGMxLTEwMG1oemdy
cCB7DQo+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYm9vdHBoLXByZS1yYW07
DQo+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYm9vdHBoLXNvbWUtcmFtOw0K
Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGZzbCxwaW5zID0gPA0KPj4+Pj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBNWDkzX1BBRF9T
RDFfQ0xLX19VU0RIQzFfQ0xLDQo+Pj4+PiAgwqAweDENCj4+Pj4+IDdiZQ0KPj4+Pj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBNWDkzX1BBRF9TRDFfQ01E
X19VU0RIQzFfQ01EDQo+Pj4+PiAgwqAweDQNCj4+Pj4+IDAwMDEzOWUNCj4+Pj4+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgTVg5M19QQURfU0QxX0RBVEEw
X19VU0RIQzFfREFUQTANCj4+Pj4+ICDCoDB4NA0KPj4+Pj4gMDAwMTM4ZQ0KPj4+Pj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBNWDkzX1BBRF9TRDFfREFU
QTFfX1VTREhDMV9EQVRBMQ0KPj4+Pj4gIMKgMHg0DQo+Pj4+PiAwMDAxMzllDQo+Pj4+PiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoE1YOTNfUEFEX1NEMV9E
QVRBMl9fVVNESEMxX0RBVEEyDQo+Pj4+PiAgwqAweDQNCj4+Pj4+IDAwMDEzYmUNCj4+Pj4gQ291
bGQgeW91IHBsZWFzZSBleHBsYWluIHdoeSB0aGUgcGluIGNvbmZpZ3VyYXRpb24gZm9yIDEwMCBN
SHogb2YNCj4+Pj4gREFUQTANCj4+Pj4gJiBEQVRBMiBpcyBkaWZmZXJlbnQgZnJvbSB0aGUgb3Ro
ZXIgZGF0YSBwaW5zPw0KPj4+IFRoZSBkaWZmZXJlbmNlIGluIHRoZSB2YWx1ZXMgaXMgZHVlIHRv
IGRpZmZlcmVudCBkcml2ZS1zdHJlbmd0aA0KPj4+IHNldHRpbmdzIHBlciBwaW4uIFRoZSB2YWx1
ZXMgYXJlIHRoZSByZXN1bHQgb2YgbWVhc3VyZW1lbnRzIHdlDQo+Pj4gZGlkIGZvciB0aGUgZU1N
QyBpbnRlcmZhY2UuIFRoZXJlLCB3ZSBhZGp1c3RlZCBlYWNoIHBpbidzDQo+Pj4gZHJpdmUtc3Ry
ZW5ndGggdG8gZ2V0IGl0J3MgYmVzdCBzaWduYWwgcXVhbGl0eS4NCj4+IFRoYW5rcyBmb3IgdGhl
IGV4cGxhbmF0aW9uLiBTbyB5b3UgbWVhc3VyZWQgYWxzbyB0aGUgMjAwIE1IeiBjYXNlPw0KPj4g
QmVjYXVzZSB0aGVyZSBhcmUgbm8gZGlmZmVyZW5jZXMgYmV0d2VlbiB0aGUgZGF0YSBwaW5zLg0K
PiBZZXMsIHdlIG1lYXN1cmVkIGFsc28gZm9yIDIwMCBNSHouIFRoZXJlIHRoZSBzYW1lIHZhbHVl
IHdhcyBwZXJmZWN0DQo+IGZvciBhbGwgcGlucy4NCkdyZWF0LCBJJ20gZmluZSB3aXRoIHRoZSB3
aG9sZSBzZXJpZXMuDQo=
