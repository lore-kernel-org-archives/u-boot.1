Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DBCAC4345F
	for <u-boot@archiver.kernel.org>; Tue, 23 Apr 2024 07:26:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B84BF881EA;
	Tue, 23 Apr 2024 09:26:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="aLmIhI/F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E23E88322; Tue, 23 Apr 2024 09:26:05 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86A4D87E53
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 09:26:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=T.Remmet@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1713857163; x=1716449163;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BHxVVCOxbebqFAjQ43QuwvY7SSIsi/Wbf0eBr1gGES4=;
 b=aLmIhI/FfpZD8kzaCuCW/DC4BPHxkGK6AirvTBiDrcstOaMgLEnIbdxKn7qKC7AG
 3z7Be6Ka5bgJLuXoxLPeMU/T9rVAeAQaPCW+D41t8jhp4FtBnt0wKV+axwQqiM4G
 BEyyu7SOk5XWtwH/9uYlP95SBo+kBeKHJ808+2oZZ/M=;
X-AuditID: ac14000a-fadff7000000290d-38-6627628beb31
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id EB.91.10509.B8267266;
 Tue, 23 Apr 2024 09:26:03 +0200 (CEST)
Received: from Berlix.phytec.de (172.25.0.12) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 23 Apr
 2024 09:26:02 +0200
Received: from Berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4]) by
 berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4%4]) with mapi id 15.01.2507.006;
 Tue, 23 Apr 2024 09:26:02 +0200
From: Teresa Remmet <T.Remmet@phytec.de>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Daniel Schultz
 <D.Schultz@phytec.de>
CC: "upstream@lists.phytec.de" <upstream@lists.phytec.de>
Subject: Re: [PATCH 4/5] board: phytec: common: Fix eepom is empty check
Thread-Topic: [PATCH 4/5] board: phytec: common: Fix eepom is empty check
Thread-Index: AQHaknXcJ+2xCR1K+UKIzKsbRSaa+LF1WIoA
Date: Tue, 23 Apr 2024 07:26:02 +0000
Message-ID: <5a0ac6ab7256cdca7eaf70939ef570b523e23837.camel@phytec.de>
References: <20240419155540.2447006-1-d.schultz@phytec.de>
 <20240419155540.2447006-5-d.schultz@phytec.de>
In-Reply-To: <20240419155540.2447006-5-d.schultz@phytec.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.0.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <CA0D392D1E1E334FBF09AC2C675E16EF@phytec.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupikeLIzCtJLcpLzFFi42JZI8nAo9udpJ5msHedgMXbvZ3sFt3v1B2Y
 PM7e2cHo0d/dwhrAFMVlk5Kak1mWWqRvl8CVsb/vF1tBn1jF/RmeDYxHRLsYOTkkBEwk9mz+
 yN7FyMUhJLCESeLs3G+sEM59Rok1t1YzQTgbGCWO7J3FCNLCJqAh8fJENxOILSIQKbHo1nsW
 EJtZwFKidecRsBphAQ+J35NuMEPUeErcmj6dEcI2kti5rxUsziKgKvHp0BF2EJtXwE1iyenp
 bCC2kECOxKJXHUBxDg5OAWuJ/W/9QMKMArISGzacZ4ZYJS6x6dl3VogPBCSW7IGISwiISrx8
 /A8qLi9x4tY0JpAxzAKaEut36UOYFhK9s3ggpihKTOl+CHWAoMTJmU9YJjCKz0KyYBZC8yyE
 5llImmchaV7AyLqKUSg3Mzk7tSgzW68go7IkNVkvJXUTIyi+RBi4djD2zfE4xMjEwXiIUYKD
 WUmE99cflTQh3pTEyqrUovz4otKc1OJDjNIcLErivKs7glOFBNITS1KzU1MLUotgskwcnFIN
 jIsutrzz2bDJaIN3dEVDbvkJ0YAuFqXif55t0zpyzXaw14fpqs+ZJ1L8ayGz77yV/ySKPnr7
 2IrZHXPlXjy1a/e08PAXr3cYTmkvu6v/Nr7GbPnsnf/dlrNrBkYLHPgS95P1tTP3vu1m4m36
 0XEc4k6zHp4w/n4zd83xwKsh72Lub0rkOR+Yq8RSnJFoqMVcVJwIAKZhw8+dAgAA
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

QW0gRnJlaXRhZywgZGVtIDE5LjA0LjIwMjQgdW0gMDg6NTUgLTA3MDAgc2NocmllYiBEYW5pZWwg
U2NodWx0ejoNCj4gVGhlIHB0ciB2YXJpYWJsZSBpcyBjdXJyZW50bHkgZGVmaW5lZCBhcyBpbnQg
YW5kIHNpemVvZg0KPiByZXR1cm5zIHRoZSBzaXplIG9mIHRoZSBlZXByb20gZGF0YSBzdHJ1Y3Qg
YXMgQnl0ZSAoMzIgaW4gdG90YWwpLg0KPiANCj4gSW4gY2FzZSB0aGUgZWVwcm9tIGlzIGVtcHR5
LCB0aGUgY2hlY2ssIGlmIHRoZSBlZXByb20gaXMgZW1wdHksDQo+IHdpbGwgbW9zdCBsaWtlbHkg
c3RvcCBhZnRlciA4IGl0ZXJhdGlvbnMgYmVjYXVzZSBpdCB3aWxsIGNvbnRpbnVlDQo+IHdpdGgg
dGhlIHN0YWNrIHdoaWNoIHNob3VsZCBjb250YWluIHNvbWUgZGF0YS4gVGhlcmVmb3JlLCB0aGUN
Cj4gaW5pdCBmdW5jdGlvbiB3aWxsIGRldGVjdCBhbiBlbXB0eSBFRVBST00gYXMgQVBJMCBhbmQg
cmV0dXJuIHdpdGgNCj4gdGhlIHZhbGlkIGZsYWcgc2V0IHRvIFRydWUuDQo+IA0KPiBGaXhlczog
ZGMyMjE4OGNkYzggKCJib2FyZDogcGh5dGVjOiBBZGQgY29tbW9uIFBIWVRFQyBTb00gZGV0ZWN0
aW9uIikNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IERhbmllbCBTY2h1bHR6IDxkLnNjaHVsdHpAcGh5
dGVjLmRlPg0KDQpSZXZpZXdlZC1ieTogVGVyZXNhIFJlbW1ldCA8dC5yZW1tZXRAcGh5dGVjLmRl
Pg0KDQo+IC0tLQ0KPiDCoGJvYXJkL3BoeXRlYy9jb21tb24vcGh5dGVjX3NvbV9kZXRlY3Rpb24u
YyB8IDQgKystLQ0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRp
b25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYm9hcmQvcGh5dGVjL2NvbW1vbi9waHl0ZWNfc29t
X2RldGVjdGlvbi5jDQo+IGIvYm9hcmQvcGh5dGVjL2NvbW1vbi9waHl0ZWNfc29tX2RldGVjdGlv
bi5jDQo+IGluZGV4IDVhNGNjOWU4YjAyLi43OGMxNzNkZjIwZCAxMDA2NDQNCj4gLS0tIGEvYm9h
cmQvcGh5dGVjL2NvbW1vbi9waHl0ZWNfc29tX2RldGVjdGlvbi5jDQo+ICsrKyBiL2JvYXJkL3Bo
eXRlYy9jb21tb24vcGh5dGVjX3NvbV9kZXRlY3Rpb24uYw0KPiBAQCAtNTMsNyArNTMsNyBAQCBp
bnQgcGh5dGVjX2VlcHJvbV9kYXRhX2luaXQoc3RydWN0DQo+IHBoeXRlY19lZXByb21fZGF0YSAq
ZGF0YSwNCj4gwqB7DQo+IMKgwqDCoMKgwqDCoMKgwqBpbnQgcmV0LCBpOw0KPiDCoMKgwqDCoMKg
wqDCoMKgdW5zaWduZWQgaW50IGNyYzsNCj4gLcKgwqDCoMKgwqDCoMKgaW50ICpwdHI7DQo+ICvC
oMKgwqDCoMKgwqDCoHU4ICpwdHI7DQo+IMKgwqDCoMKgwqDCoMKgwqBjb25zdCB1bnNpZ25lZCBp
bnQgcGF5bG9hZF9zaXplID0gc2l6ZW9mKHN0cnVjdA0KPiBwaHl0ZWNfZWVwcm9tX3BheWxvYWQp
Ow0KPiDCoA0KPiDCoMKgwqDCoMKgwqDCoMKgaWYgKCFkYXRhKQ0KPiBAQCAtODUsNyArODUsNyBA
QCBpbnQgcGh5dGVjX2VlcHJvbV9kYXRhX2luaXQoc3RydWN0DQo+IHBoeXRlY19lZXByb21fZGF0
YSAqZGF0YSwNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnb3RvIGVycjsNCj4g
wqDCoMKgwqDCoMKgwqDCoH0NCj4gwqANCj4gLcKgwqDCoMKgwqDCoMKgcHRyID0gKGludCAqKWRh
dGE7DQo+ICvCoMKgwqDCoMKgwqDCoHB0ciA9ICh1OCAqKWRhdGE7DQo+IMKgwqDCoMKgwqDCoMKg
wqBmb3IgKGkgPSAwOyBpIDwgcGF5bG9hZF9zaXplOyArK2kpDQo+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgaWYgKHB0cltpXSAhPSAweDApDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGJyZWFrOw0KDQotLSANClBIWVRFQyBNZXNzdGVj
aG5payBHbWJIIHwgQmFyY2Vsb25hLUFsbGVlIDEgfCA1NTEyOSBNYWlueiwgR2VybWFueQ0KDQpH
ZXNjaMOkZnRzZsO8aHJlcjogRGlwbC4tSW5nLiBNaWNoYWVsIE1pdGV6a2ksIERpcGwuLUluZy4g
Qm9kbyBIdWJlciwNCkRpcGwuLUluZy4gKEZIKSBNYXJrdXMgTGlja2VzIHwgSGFuZGVsc3JlZ2lz
dGVyIE1haW56IEhSQiA0NjU2IHwNCkZpbmFuemFtdCBNYWlueiB8IFN0Lk5yLiAyNjY1MDA2MDgs
IERFIDE0OTA1OTg1NQ0K
