Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EDF2C2A09B
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 14:18:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EBE5060A78;
	Fri,  7 Aug 2026 14:18:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ss_p8jMKzEuc; Fri,  7 Aug 2026 14:18:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 03AB760A71
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786112291;
	bh=10TPXtybucFJzE9dFJETAk0rGAlFMyO7pg8Z5pDfeTU=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TRJqUsoiBdUP6DPZUzQjcjNs66NWhfmVUfwpHqTa7euVK06oYRq0WpM3kLkonb1J+
	 ZIGchIbratJmpgLZuC3sNEQbNvbjleHLfpyPJTa0atAMmO1dYCM3UlPyRb2KZv5G9U
	 b8qxbSFo3369KQTDW6aVJgOg6D4VRBF1dKKpnY+w60QKi5CbLw8b1wOmLrzVAVXpbl
	 zofuRrDBnoQNr+93URAOXo1SilZ0jDvX2fUpAmRlacoARmmeKxd8DpTiwTeiLCNB+h
	 D/NSrQCLByNkYhG/ugMeUSveVFcxhnQIp6jtOb9Oac3IFeu3uNRUnfXx0VIaf4J3i0
	 548HdxUk3O05A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 03AB760A71;
	Fri,  7 Aug 2026 14:18:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8245428C
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 06:24:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 67E6F60608
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 06:24:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OZfACeoJb5he for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 06:24:51 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:18f0:1e00:4::4;
 helo=smtp2.infineon.com; envelope-from=takahiro.kuwano@infineon.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org F0685605FD
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F0685605FD
Received: from smtp2.infineon.com (smtp2.infineon.com
 [IPv6:2a00:18f0:1e00:4::4])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F0685605FD
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 06:24:50 +0000 (UTC)
X-CSE-ConnectionGUID: KW6JZw1fSoi5CzyWxijwlA==
X-CSE-MsgGUID: NTPjvtFYQyqMLwqhkSKm1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="171460448"
X-IronPort-AV: E=Sophos;i="6.25,209,1779141600"; d="scan'208";a="171460448"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE803.infineon.com) ([172.23.29.29])
 by smtp2.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2026 08:24:46 +0200
Received: from MUCSE818.infineon.com (172.23.29.44) by MUCSE803.infineon.com
 (172.23.29.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 7 Aug
 2026 08:24:45 +0200
Received: from MUCSE815.infineon.com (172.23.29.41) by MUCSE818.infineon.com
 (172.23.29.44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 7 Aug
 2026 08:24:45 +0200
Received: from MUCSE815.infineon.com ([fe80::ed10:a720:3031:ca14]) by
 MUCSE815.infineon.com ([fe80::ed10:a720:3031:ca14%12]) with mapi id
 15.02.2562.045; Fri, 7 Aug 2026 08:24:45 +0200
From: <Takahiro.Kuwano@infineon.com>
To: <asrinivasan@oss.tenstorrent.com>, <u-boot@lists.u-boot-project.org>
CC: <vigneshr@ti.com>, <trini@konsulko.com>, <ssunkkan@gmail.com>,
 <jeyu@issi.com>, <yangshiji66@outlook.com>, <boon.khai.ng@altera.com>,
 <flaviu.nistor@gmail.com>
Subject: RE: [PATCH 1/2] mtd: spi-nor-ids: Add variant of mt25qu256a chip
Thread-Topic: [PATCH 1/2] mtd: spi-nor-ids: Add variant of mt25qu256a chip
Thread-Index: AQHdI3p4HD0P9CoVX0OhEWqgMEnx9LaSIyKw
Date: Fri, 7 Aug 2026 06:24:44 +0000
Message-ID: <bfbea789e33f48b6894a2a3ea7a1308a@infineon.com>
References: <20260803-spi_fixes-v1-0-33f36e764104@oss.tenstorrent.com>
 <20260803-spi_fixes-v1-1-33f36e764104@oss.tenstorrent.com>
In-Reply-To: <20260803-spi_fixes-v1-1-33f36e764104@oss.tenstorrent.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.161.6.196]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 07 Aug 2026 14:18:10 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
 t=1786083891; x=1817619891;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=10TPXtybucFJzE9dFJETAk0rGAlFMyO7pg8Z5pDfeTU=;
 b=fuDHbGEKWraCBbs0ijzS9HHxLVpP+Q5itQGzdJja0KzF/NoniV4EKw28
 jKvFrKHG42dnTCIgZxSCP0CI1V9Hflt87SA2re7zhrVBVAIjLsMDseQtY
 f8YCbSN1EPG0U/u0MZE6BDPBoOjP87Zp1kJhE9klfEAEBqCvtQEWyhM4I
 A=;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=infineon.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=infineon.com header.i=@infineon.com header.a=rsa-sha256
 header.s=IFXMAIL header.b=fuDHbGEK
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

SGksDQoNCj4gVGhlIGN1cnJlbnQgbXQyNXF1MjU2YSBlbnRyeSBoYXMgYSBKRURFQyBJRCB3aXRo
IGFuIGV4dGVuZGVkIGRldmljZSBJRA0KPiBieXRlIG9mIDB4NDQuIEEgdmFyaWFudCBvZiB0aGlz
IGNoaXAgdGhpcyAobW9kZWwgbXQyNXF1MjU2YWJhMWV3OSksIGhhcw0KPiBhbiBleHRlbmRlZCBk
ZXZpY2UgSUQgYnl0ZSBvZiAweDQwLiBUaGUgY3VycmVudCBKRURFQyBJRCBwYXJzaW5nIGNvZGUN
Cj4gaW5jb3JyZWN0bHkgZGV0ZWN0cyB0aGlzIGFzIGFuIG4yNXEyNTZheDEsIHdoaWNoIHJlc3Vs
dHMgaW4gNCBieXRlDQo+IHJlYWQvd3JpdGUgb3Bjb2RlcyBub3QgYmVpbmcgdXNlZCBmb3IgdGhp
cyBjaGlwIGV2ZW4gdGhvdWdoIGl0IHN1cHBvcnRzDQo+IGl0Lg0KPiANCj4gQWNjb3JkaW5nIHRv
IFBhZ2UgMzQgaW4gdGhlIGRhdGFzaGVldCBbMV0sIHRoZSBkaWZmZXJlbmNlcyBpbiB0aGUgSkVE
RUMNCj4gSUQgKEJpdCAzIGluIHRoZSBFeHRlbmRlZCBEZXZpY2UgSUQgRGF0YSkgY29ycmVzcG9u
ZCB0byB3aGV0aGVyIFBpbiAxDQo+IGZ1bmN0aW9ucyBhcyBhIEhvbGQgb3IgUmVzZXQgcGluLiBU
aGlzIHNob3VsZG4ndCBhZmZlY3QgYW55DQo+IGZ1bmN0aW9uYWxpdHkgaW4gVS1Cb290J3MgY29t
bXVuaWNhdGlvbiB3aXRoIHRoZSBjaGlwLg0KPiANCj4gRG9jdW1lbnQgdGhpcyBjaGlwIGFuZCBp
dCdzIEpFREVDIElEIHNvIHRoYXQgVS1Cb290IHVzZXMgNCBieXRlIG9wY29kZXMNCj4gZm9yIHRo
aXMgY2hpcC4NCj4gDQo+IFsxXSBodHRwczovL3d3dy5tb3VzZXIuY29tL2NhdGFsb2cvc3BlY3No
ZWV0cy9taWNyb24lMjB0ZWNobm9sb2d5X21pY3Qtcy1hMDAwMTQwMDU4OC0xLnBkZg0KDQpJIHdv
dWxkIHByZWZlciB0byB1c2UgTGluazogdGFnLg0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbmly
dWRoIFNyaW5pdmFzYW4gPGFzcmluaXZhc2FuQG9zcy50ZW5zdG9ycmVudC5jb20+DQo+IA0KPiAt
LS0NCj4gVGhlIGRpZmZlcmVuY2VzIGluIHRoZSBmdW5jdGlvbmFsaXR5IG9mIFBpbiAxIChIb2xk
L1Jlc2V0KSBhbHNvIHJlZmxlY3QNCj4gaW4gdGhlIG1vZGVsIG51bWJlciBvZiB0aGUgZmxhc2gg
Y2hpcCwgYXMgcGVyIFBhZ2UgMiBvZiB0aGUgZGF0YXNoZWV0Lg0KPiBUaGUgZXhpc3RpbmcgZW50
cnkgaW4gVS1Cb290ICgweDQ0LCBQaW4gMSByZXNldCksIHNob3VsZCBoYXZlIGEgbW9kZWwNCj4g
bnVtYmVyIG10MjVxdTI1NmFiYTN4eHgsIHdoZXJlYXMgdGhlIGNoaXAgSSdtIHRyeWluZyB0byBk
b2N1bWVudCAoMHg0MCwNCj4gUGluIDEgaG9sZCkgc2hvdWxkIGhhdmUgYSBtb2RlbCBudW1iZXIg
bXQyNXF1MjU2YWJhMXh4eC4gSSBkaWRuJ3Qgd2FudA0KPiB0byBjaGFuZ2UgdGhlIG5hbWUgb2Yg
dGhlIGV4aXN0aW5nIGVudHJ5IGluIFUtQm9vdCwgc28gSSd2ZSBsZWZ0IGl0IGFzDQo+IGlzLg0K
PiAtLS0NCg0KVGhhbmtzIGZvciB0aGUgZGV0YWlsZWQgZXhwbGFuYXRpb24hDQoNClJldmlld2Vk
LWJ5OiBUYWthaGlybyBLdXdhbm8gPHRha2FoaXJvLmt1d2Fub0BpbmZpbmVvbi5jb20+DQoNCj4g
IGRyaXZlcnMvbXRkL3NwaS9zcGktbm9yLWlkcy5jIHwgMiArKw0KPiAgMSBmaWxlIGNoYW5nZWQs
IDIgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL3NwaS9zcGkt
bm9yLWlkcy5jIGIvZHJpdmVycy9tdGQvc3BpL3NwaS1ub3ItaWRzLmMNCj4gaW5kZXggMzFhMmJh
NDlhODcuLmVkNDMxMDRiZjUzIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL210ZC9zcGkvc3BpLW5v
ci1pZHMuYw0KPiArKysgYi9kcml2ZXJzL210ZC9zcGkvc3BpLW5vci1pZHMuYw0KPiBAQCAtNDE2
LDYgKzQxNiw4IEBAIGNvbnN0IHN0cnVjdCBmbGFzaF9pbmZvIHNwaV9ub3JfaWRzW10gPSB7DQo+
ICAgICAgICAgeyBJTkZPNigibXQyNXFsMjU2YSIsICAgIDB4MjBiYTE5LCAweDEwNDQwMCwgNjQg
KiAxMDI0LCAgNTEyLCBTRUNUXzRLIHwgU1BJX05PUl9EVUFMX1JFQUQgfA0KPiBTUElfTk9SX1FV
QURfUkVBRCB8IFNQSV9OT1JfNEJfT1BDT0RFUyB8IFVTRV9GU1IpIH0sDQo+ICAgICAgICAgeyBJ
TkZPKCJuMjVxMjU2YSIsICAgIDB4MjBiYTE5LCAwLCA2NCAqIDEwMjQsICA1MTIsIFNFQ1RfNEsg
fCBTUElfTk9SX0RVQUxfUkVBRCB8IFNQSV9OT1JfUVVBRF9SRUFEIHwNCj4gVVNFX0ZTUikgfSwN
Cj4gICAgICAgICB7IElORk82KCJtdDI1cXUyNTZhIiwgIDB4MjBiYjE5LCAweDEwNDQwMCwgNjQg
KiAxMDI0LCAgNTEyLCBTRUNUXzRLIHwgU1BJX05PUl9RVUFEX1JFQUQgfA0KPiBTUElfTk9SXzRC
X09QQ09ERVMgfCBVU0VfRlNSKSB9LA0KPiArICAgICAgIHsgSU5GTzYoIm10MjVxdTI1NmFiYTEi
LCAgMHgyMGJiMTksIDB4MTA0MDAwLCA2NCAqIDEwMjQsICA1MTIsDQo+ICsgICAgICAgICBTRUNU
XzRLIHwgU1BJX05PUl9RVUFEX1JFQUQgfCBTUElfTk9SXzRCX09QQ09ERVMgfCBVU0VfRlNSKSB9
LA0KPiAgICAgICAgIHsgSU5GTygibjI1cTI1NmF4MSIsICAweDIwYmIxOSwgMCwgNjQgKiAxMDI0
LCAgNTEyLCBTRUNUXzRLIHwgU1BJX05PUl9RVUFEX1JFQUQgfCBVU0VfRlNSKSB9LA0KPiAgICAg
ICAgIHsgSU5GTygibXQyNXF1MTI4YWIiLCAweDIwYmIxOCwgMCwgNjQgKiAxMDI0LCAgMjU2LCBT
RUNUXzRLIHwgVVNFX0ZTUiB8IFNQSV9OT1JfUVVBRF9SRUFEKSB9LA0KPiAgICAgICAgIHsgSU5G
TzYoIm10MjVxdTUxMmEiLCAgMHgyMGJiMjAsIDB4MTA0NDAwLCA2NCAqIDEwMjQsIDEwMjQsDQo+
IA0KPiAtLQ0KPiAyLjQzLjANCg0K
