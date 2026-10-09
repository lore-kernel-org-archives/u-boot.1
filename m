Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77D31CA6012
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 09:16:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 133238146E;
	Fri,  9 Oct 2026 09:16:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id av_NECMIFkWl; Fri,  9 Oct 2026 09:16:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F3983812AB
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791537399;
	b=X+N9/NxjKJin/aThSd5TcoEmAX/h2jzpoZmKgFh78VDsOjtGPC/LIcaOuc33tKMBUkzi
	 MKkMNKsVrptWX6Y8hRG55OqW/9mHzFJlAacj9LR2illCwsa2MwfcsDr0F+VGyPMrNozq7
	 +BBZIIdfz+jqZk+GREFsCABqwET/Q1JR0zBci5DYOZEP16sZXYpJuUqsHnFtCYqB7XfbO
	 xWdAIqLDQOz/yhTa5ST3w2zJpaentlnTH1d3vcoR+BR3AvVsf0cTLtfekuxyMnRZzR/8A
	 RsbHb02+rVVNliUFOrlwJvppK2Z/SuO3ny1aeQ//DJrSvoHgAS6Gd990xoHtLhGMkEQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791537399;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:From:To:CC:
	 Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
	 In-Reply-To:Accept-Language:Content-Language:X-MS-Has-Attach:
	 X-MS-TNEF-Correlator:x-originating-ip:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=zn9eD8FIh2/BBImUL5eF4RO8Ut/hvF/mIAuGtKztAXY=;
	b=NaOfPJ1EvQbOkU3SG8DbLzNBt1wIlZcJOIYRCMiQ63mHxw+8BO7ulCNDVvZWFqxjdaWH
	 g3EVbjhNDrXxtshAgFJgqaG5HQobPjcg2KNIE1GRlesHCnPtXSz9hXtyhW3k0BH3Zi3Ca
	 c0uHgMl0j9rkTYNfv7IcEppI8Rx7tDOIGokS19vkf0taGSg8v9pb0Sq4AUaI71dN0iXEF
	 7+x9I6dqSDo7bk0mq7Zi34cRpC1b/1UErjmTTk4vt4gCj2cHyGTWFjmWzucBZfrrC1s4/
	 Azdy2ihZ5MGlvFWCfnh+HdhViKPrZtDjhzuvngfXIho+8/xmv+LhRkM75sl+m7l1qnA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791537399;
	bh=zn9eD8FIh2/BBImUL5eF4RO8Ut/hvF/mIAuGtKztAXY=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=meeTJkLzsZdHQZGtCdx5IDV4gqYd4Vnuoh2EimjO6X7fjCvAfI/eFTq9nL/C/rNwd
	 OszkeyiZIo/ZE9dVkdtATOT8LCGahzETmB8H6EDzGlydM4qbU156NjXXun79vvZnYP
	 WvJHwInqsaXL8HeqpbL8t7tG003UMEmYPe5zFHNJnGxKZPijOilROGtEeBnhZbm9oA
	 V9X0ONf8TBfA3FZPWNIAwpJWVVxj+xcvmwaQUIGcQpxSIL2F6iWGceFMm4GFGeD9Jf
	 BJK9Lk1MC2mBgTlYB2p+7XL5Gwh5JSYn2rl5xpzIOdN9eu/HvlA1MuGBXanM6YMlXL
	 c44zgXbkvkTQw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F3983812AB;
	Fri,  9 Oct 2026 09:16:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 463FC2E0
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 08:29:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2B79B408FB
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 08:29:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ADqGv4sDfASK for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 08:29:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3D9F2408F9
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:18f0:1e00:4::6"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791534557;
 b=R7ikGo7cET8EBy1+RN9EwdNI+L5k2GX6DhKKwbQJEBMmOiH6lJCA5RSKIExyBkP+acoq
 v2YaGHmTm6RkdEjLYoMn2KZiSRYTVT3RjKHTFWlfoG2JJ9s5QPeGGRJ3Qd0i2GYsPrIYl
 Ou3e39iTwIdc08q3KZbG1sgXhHqxNUe+rQzCmXAUTom9Wj0UQ9qKQZww245f+3zBDdZ4a
 B7YPy/wTFH5GU1/wPsQdfoCrKcLv9teHnbzVR/FrFLnzvGJTC0I/dIzwSSCBrxzEJwYV/
 +N/5Ctrny0RiHyB0OsdIQGZCCxpSSW7gYtc/A3d0x8hryfHPBND6KduOSKkSsED4WHQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791534557;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:X-Amp-Result:Received:Received:Received:
 From:To:CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:
 References:In-Reply-To:Accept-Language:Content-Language:
 X-MS-Has-Attach:X-MS-TNEF-Correlator:x-originating-ip:Content-Type:
 Content-Transfer-Encoding:MIME-Version;
 bh=zn9eD8FIh2/BBImUL5eF4RO8Ut/hvF/mIAuGtKztAXY=;
 b=YyAjDn0DZktu0B9Iu8RbwVf9EaWcYup//X93ODNcasjG5ri7AnBtfIe82xcB6cR1gk1s
 7dzMr4WCy4gfVRllK9ATYTa+fzRdBx26HcPMQ+xNTqUI58PfG5jqiz10Ryo2aYdfXGhba
 I+CPQpWfw4ojh7fKjc5y8aGTyOuYAqfoLADgVHkBUTj5vuBegydRuDwLA4lAtLfbLbFhb
 Tb7QAvI8QiApf7AF0UiFTnQxES8bRmr4lMRQF9na+9EyZlzj+z2aHYNh1+20EP/6WGoJm
 m9VD5HTMd4gJrKfTbqmVPjunE/7ynVAaV7L5kz3vXw+4Tc/O9tMSuhoftoq23z9u2Gw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=infineon.com;
 dkim=pass header.d=infineon.com header.i=@infineon.com header.a=rsa-sha256
 header.s=IFXMAIL header.b=UhHfpKRF; 
 arc=none smtp.remote-ip="2a00:18f0:1e00:4::6"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:18f0:1e00:4::6;
 helo=smtp14.infineon.com; envelope-from=takahiro.kuwano@infineon.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=infineon.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=infineon.com header.i=@infineon.com header.a=rsa-sha256
 header.s=IFXMAIL header.b=UhHfpKRF
Received: from smtp14.infineon.com (smtp14.infineon.com
 [IPv6:2a00:18f0:1e00:4::6])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3D9F2408F9
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 08:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
 t=1791534557; x=1823070557;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=zn9eD8FIh2/BBImUL5eF4RO8Ut/hvF/mIAuGtKztAXY=;
 b=UhHfpKRFKSYnXa1hQrV7jfDDeHi2V+Cbit2u6AjLaVYKGpHo/OBS3VOI
 VqvLHJk9NQiJD8wKtcakjweW7xdl+17wtX9mjq/m0oYVRDI9Oaw0Ostgj
 WZoIm42MlY5QUUICDBKeGghfxPVJH6FCD6OAIulayARxBHtFUfCEWbLYs A=;
X-CSE-ConnectionGUID: 3DylqZ7ETJed6PpGkl4Ndw==
X-CSE-MsgGUID: M7XHRBtjTh6ZlFzqfT7wew==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="150424395"
X-IronPort-AV: E=Sophos;i="6.27,147,1787004000"; d="scan'208";a="150424395"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE812.infineon.com) ([172.23.29.38])
 by smtp14.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2026 10:29:13 +0200
Received: from MUCSE815.infineon.com (172.23.29.41) by MUCSE812.infineon.com
 (172.23.29.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 9 Oct
 2026 10:29:11 +0200
Received: from MUCSE815.infineon.com ([fe80::ed10:a720:3031:ca14]) by
 MUCSE815.infineon.com ([fe80::ed10:a720:3031:ca14%12]) with mapi id
 15.02.2562.049; Fri, 9 Oct 2026 10:29:11 +0200
From: <Takahiro.Kuwano@infineon.com>
To: <sjg@chromium.org>, <hs@nabladev.com>
CC: <u-boot@lists.u-boot-project.org>, <marek.vasut+renesas@mailbox.org>,
 <vigneshr@ti.com>, <jbx6244@gmail.com>, <stefan.bigler@securiton.ch>,
 <quentin.schulz@cherry.de>, <trini@konsulko.com>, <vjardin@free.fr>
Subject: RE: [PATCH v2 3/5] mtd: add driver for the Microchip 23LCV1024 SPI
 SRAM
Thread-Topic: [PATCH v2 3/5] mtd: add driver for the Microchip 23LCV1024 SPI
 SRAM
Thread-Index: AQHdU7XVNeLYzJhL60yx5+hOYpVsKLb0sI0AgAAyPFA=
Date: Fri, 9 Oct 2026 08:29:11 +0000
Message-ID: <e66df57a82424e6d9b1fe8e2e5b7041f@infineon.com>
References: <20261004040657.3156402-1-hs@nabladev.com>
 <20261004040657.3156402-4-hs@nabladev.com>
 <CAFLszThGYtvGYmYi1iOjRiqBANzbNSOt00n1HHzOWX8GXw3P0A@mail.gmail.com>
In-Reply-To: <CAFLszThGYtvGYmYi1iOjRiqBANzbNSOt00n1HHzOWX8GXw3P0A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.161.6.196]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 09 Oct 2026 09:16:37 +0000
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

SGkgSGVpa28gYW5kIFNpbW9uLA0KDQo+IEhpIEhlaWtvLA0KPiANCj4gT24gMjAyNi0xMC0wNFQw
NDowNjo0NCwgSGVpa28gU2Nob2NoZXIgPGhzQG5hYmxhZGV2LmNvbT4gd3JvdGU6DQo+ID4gbXRk
OiBhZGQgZHJpdmVyIGZvciB0aGUgTWljcm9jaGlwIDIzTENWMTAyNCBTUEkgU1JBTQ0KPiA+DQo+
ID4gVGhlIDIzTENWMTAyNCBpcyBhIDEgTWJpdCBzZXJpYWwgU1JBTSB3aXRoIGJhdHRlcnkgYmFj
a3VwLCBzaXR0aW5nIG9uDQo+ID4gYW4gU1BJIGJ1cyBhbmQgdXNlZCBhcyBub24gdm9sYXRpbGUg
c2NyYXRjaCBzdG9yYWdlLiBSZWdpc3RlciBpdCBhcyBhbg0KPiA+IE1URCBkZXZpY2Ugb2YgdHlw
ZSBNVERfUkFNLCBzbyB0aGUgbXRkIGNvbW1hbmQgcmVhY2hlcyBpdC4NCj4gPg0KPiA+IFRoZSBk
ZXZpY2UgcG93ZXJzIHVwIGluIGJ5dGUgb3BlcmF0aW9uLCB3aGVyZSBldmVyeSBjb21tYW5kIGNh
cnJpZXMNCj4gPiBleGFjdGx5IG9uZSBkYXRhIGJ5dGUuIFNlbGVjdCBzZXF1ZW50aWFsIG9wZXJh
dGlvbiBvbmNlIGR1cmluZyBwcm9iZSwNCj4gDQo+IEp1c3QgdG8gY2hlY2ssIGlzIHRoaXMgcmln
aHQ/IE15IHVuZGVyc3RhbmRpbmcgaXMgdGhhdCB0aGUNCj4gMjNMQzEwMjQvMjNMQ1YxMDI0IGRh
dGEgc2hlZXQgZ2l2ZXMgc2VxdWVudGlhbCBtb2RlICgwMSkgYXMgdGhlIE1PREUNCj4gcmVnaXN0
ZXIgZGVmYXVsdDsgYnl0ZSBtb2RlIGlzIHRoZSBkZWZhdWx0IG9ubHkgb24gdGhlIG9sZGVyIDIz
SzI1Ni4NCj4gVGhlIExpbnV4IG1jaHAyM2syNTYgZHJpdmVyIG5ldmVyIHdyaXRlcyB0aGUgTU9E
RSByZWdpc3Rlci4gU2V0dGluZyBpdA0KPiBleHBsaWNpdGx5IGlzIHN0aWxsIGEgZmluZSBkZWZl
bnNpdmUgc3RlcCwgc2luY2Ugc29tZXRoaW5nIGVsc2UgY291bGQNCj4gaGF2ZSBjaGFuZ2VkIHRo
ZSBtb2RlIGFuZCB0aGUgcGFydCBrZWVwcyBpdCB3aGlsZSBvbiBiYXR0ZXJ5LiBQbGVhc2UNCj4g
Y2FuIHlvdSByZXdvcmQgdGhlIGNvbW1pdCBtZXNzYWdlIGFuZCB0aGUgY29tbWVudCBpbiBzcGlf
cmFtX3Byb2JlKCkNCj4gdG8gbWF0Y2g/DQo+IA0KPiA+IHNvIHRoYXQgYSByZWFkIG9yIGEgd3Jp
dGUgb2YgYW55IGxlbmd0aCBpcyBzZXJ2ZWQgYnkgYSBzaW5nbGUgY29tbWFuZA0KPiA+IGFuZCB0
aGUgYnVzIGlzIGNsYWltZWQgb25jZSBwZXIgdHJhbnNmZXIuDQo+ID4NCj4gPiBXcml0aW5nIG5l
ZWRzIG5vIGVyYXNlLiBUaGUgZHJpdmVyIHRoZXJlZm9yZSBpbXBsZW1lbnRzIG5vIGVyYXNlDQo+
ID4gb3BlcmF0aW9uIGFuZCBzYXlzIE1URF9OT19FUkFTRSBpbiB0aGUgTVREIGZsYWdzLg0KPiA+
DQo+ID4gU2lnbmVkLW9mZi1ieTogU3RlZmFuIEJpZ2xlciA8c3RlZmFuLmJpZ2xlckBzZWN1cml0
b24uY2g+DQo+ID4gU2lnbmVkLW9mZi1ieTogSGVpa28gU2Nob2NoZXIgPGhzQG5hYmxhZGV2LmNv
bT4NCj4gPg0KPiA+IE1BSU5UQUlORVJTICAgICAgICAgICAgICAgfCAgIDUgKysNCj4gPiAgY29u
Zmlncy9zYW5kYm94X2RlZmNvbmZpZyB8ICAgMSArDQo+ID4gIGRyaXZlcnMvbXRkL0tjb25maWcg
ICAgICAgfCAgMTQgKysrDQo+ID4gIGRyaXZlcnMvbXRkL01ha2VmaWxlICAgICAgfCAgIDEgKw0K
PiA+ICBkcml2ZXJzL210ZC9zcGlfcmFtLmMgICAgIHwgMjIyICsrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgNSBmaWxlcyBjaGFuZ2VkLCAyNDMgaW5z
ZXJ0aW9ucygrKQ0KPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQvS2NvbmZpZyBiL2Ry
aXZlcnMvbXRkL0tjb25maWcNCj4gPiBAQCAtMTk0LDYgKzE5NCwyMCBAQCBjb25maWcgQUxURVJB
X1FTUEkNCj4gPiArY29uZmlnIFNQSV9SQU0NCj4gPiArICAgICBib29sICJNaWNyb2NoaXAgMjNM
Q1YxMDI0IFNQSSBTUkFNIg0KPiA+ICsgICAgIGRlcGVuZHMgb24gRE1fU1BJICYmIERNX01URA0K
PiANCj4gU1BJX1JBTSwgc3BpX3JhbS5jIGFuZCB0aGUgc3BpX3JhbSBkcml2ZXIgbmFtZSBhcmUg
dmVyeSBnZW5lcmljIGZvciBhDQo+IGRyaXZlciB0aGF0IGhhbmRsZXMgb25lIE1pY3JvY2hpcCBw
YXJ0LiBMaW51eCBhbHJlYWR5IHN1cHBvcnRzIHRoaXMNCj4gY2hpcCBpbiBkcml2ZXJzL210ZC9k
ZXZpY2VzL21jaHAyM2syNTYuYyAoQ09ORklHX01URF9NQ0hQMjNLMjU2KSwgYW5kDQo+IHRoZSBi
aW5kaW5nIGluIGR0cy91cHN0cmVhbS9CaW5kaW5ncy9tdGQvbWljcm9jaGlwLG1jaHAyM2syNTYu
eWFtbA0KPiBsaXN0cyBib3RoIG1pY3JvY2hpcCxtY2hwMjNrMjU2IGFuZCBtaWNyb2NoaXAsbWNo
cDIzbGN2MTAyNC4gSG93IGFib3V0DQo+IHVzaW5nIHRoZSBMaW51eCBuYW1lcywgaGVyZSBhbmQg
aW4gTUFJTlRBSU5FUlM/DQo+IA0KDQpJIHdvdWxkIHJhdGhlciBoYXZlIGEgZ2VuZXJpYyBTUEkt
UkFNIGRyaXZlciB0aGF0IGFsc28gc3VwcG9ydHMgTVJBTSBbMV0NCmFuZCBGUkFNIGRldmljZXMg
dXNpbmcgdGhlIGNvbW1vbiBvcGNvZGUgc2V0IHdpdGhvdXQgZXJhc2UuDQoNCkN1cnJlbnRseSwg
c29tZSBGUkFNIGNoaXBzIGFyZSBoYW5kbGVkIGJ5IFNQSS1OT1IsIGJ1dCBuZXcgZGV2aWNlcyBz
aG91bGQNCmJlIGFkZGVkIHRvIHRoZSBTUEktUkFNIGRyaXZlciBpZiBpdCBleGlzdHMuDQoNCldo
YXQgYXJlIHlvdXIgdGhvdWdodHMgb24gdGhpcz8NCg0KVGhhbmtzLA0KVGFrYWhpcm8NCg0KPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9zcGlfcmFtLmMgYi9kcml2ZXJzL210ZC9zcGlfcmFt
LmMNCj4gPiBAQCAtMCwwICsxLDIyMiBAQA0KPiA+ICtzdGF0aWMgaW50IHNwaV9yYW1feGZlcihz
dHJ1Y3Qgc3BpX3NsYXZlICpzcGksIGNvbnN0IHU4ICpjbWQsIHNpemVfdCBjbWRfbGVuLA0KPiA+
ICsgICAgICAgICAgICAgICAgICAgICBjb25zdCB2b2lkICpkYXRhX291dCwgdm9pZCAqZGF0YV9p
biwgc2l6ZV90IGRhdGFfbGVuKQ0KPiA+ICt7DQo+ID4gKyAgICAgdW5zaWduZWQgbG9uZyBmbGFn
cyA9IFNQSV9YRkVSX0JFR0lOOw0KPiA+ICsgICAgIGludCByZXQ7DQo+ID4gKw0KPiA+ICsgICAg
IGlmICghZGF0YV9sZW4pDQo+ID4gKyAgICAgICAgICAgICBmbGFncyB8PSBTUElfWEZFUl9FTkQ7
DQo+IA0KPiBUaGlzIGR1cGxpY2F0ZXMgc3BpX3dyaXRlX3RoZW5fcmVhZCgpIGluIGRyaXZlcnMv
c3BpL3NwaS11Y2xhc3MuYywNCj4gd2hpY2ggaGFzIHRoZSBzYW1lIGZsYWcgaGFuZGxpbmcgYW5k
IGRlYnVnIG1lc3NhZ2VzLiBZb3UgY291bGQgZHJvcA0KPiB0aGlzIGZ1bmN0aW9uIGFuZCB1c2Ug
dGhhdCBvbmUgaW5zdGVhZD8NCj4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL3NwaV9y
YW0uYyBiL2RyaXZlcnMvbXRkL3NwaV9yYW0uYw0KPiA+IEBAIC0wLDAgKzEsMjIyIEBADQo+ID4g
KyAgICAgcmV0ID0gc3BpX2NsYWltX2J1cyhzcGkpOw0KPiA+ICsgICAgIGlmIChyZXQpIHsNCj4g
PiArICAgICAgICAgICAgIGRldl9kYmcoZGV2LCAiZmFpbGVkIHRvIGNsYWltIFNQSSBidXM6ICVk
XG4iLCByZXQpOw0KPiA+ICsgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4gPiArICAgICB9DQo+
ID4gKw0KPiA+ICsgICAgIHJldCA9IHNwaV9yYW1feGZlcihzcGksIGNtZCwgc2l6ZW9mKGNtZCks
IGRhdGFfb3V0LCBkYXRhX2luLCBsZW4pOw0KPiANCj4gQSByZWFkIG9yIHdyaXRlIG9mIHRoZSB3
aG9sZSAxMjhLQiBnb2VzIG91dCBhcyBhIHNpbmdsZSBzcGlfeGZlcigpLg0KPiBUaGlzIGZhaWxz
IG9uIGNvbnRyb2xsZXJzIHRoYXQgb25seSBpbXBsZW1lbnQgc3BpLW1lbSBvcHMgb3IgdGhhdA0K
PiBsaW1pdCB0aGUgdHJhbnNmZXIgc2l6ZSwgd2hlcmUgdGhlIFNQSSBOQU5EIGRyaXZlciB5b3Ug
YXJlIG1vZGVsbGluZw0KPiB0aGlzIG9uIHdvdWxkIHdvcmsuIFVzaW5nIHNwaV9tZW1fZXhlY19v
cCgpIHdpdGgNCj4gc3BpX21lbV9hZGp1c3Rfb3Bfc2l6ZSgpIGluIGEgbG9vcCB3b3VsZCBjb3Zl
ciBib3RoIGNhc2VzLiBJJ20gbm90DQo+IHN1cmUgaG93IG11Y2ggdGhhdCBtYXR0ZXJzIGZvciB5
b3VyIGJvYXJkcywgc28gSSdtIGp1c3QgbWVudGlvbmluZyBpdC4NCj4gDQo+IEluIGFueSBjYXNl
Og0KPiBSZXZpZXdlZC1ieTogU2ltb24gR2xhc3MgPHNqZ0BjaHJvbWl1bS5vcmc+DQo+IA0KPiBS
ZWdhcmRzLA0KPiBTaW1vbg0KDQpbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvdS1ib290LzIw
MjYxMDA4LWV2ZXJzcGluX21yMjRoNDBfbXJhbV9zdXBwb3J0LXYxLTAtZDhmMTRkYTFhOTk3QGdt
YWlsLmNvbS8NCg0K
