Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC7DFCC6B20
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 04:28:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B522780809;
	Wed, 14 Oct 2026 04:28:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YnMhJdmZEckM; Wed, 14 Oct 2026 04:28:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C6A1C80D6A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791952092;
	b=G35YIm8y58lceMdhrzuiLh6iOJWAe1x0zakVIyywPReNQzurTDwRUTeuNyZE4IAos+4O
	 8ufb9GihZrHxkAmEPySZzXcpmAYeT1PpWgXeSELC/Ohz/5SRyI0ev7O3021TIN8QW7M20
	 4Sy/saJ5lZ8tPrrHtdgcpQAOWJw/D8TEEZl8IQJ+1jMZVAlVx89g6QcOIk6obwRmq5Z50
	 NgT6PuhHVhDdwNddZPdRsr/9hJUmqbBZHAPugY5EhE//So6tBQSqjkr9ZplPwBweUW8UY
	 lCpqhlwKLhz8JmEKLfujTK6FwY2gs2RqykyebxGgzkZDyKhHSao7clb7XiHUlE5hO8Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791952092;
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
	bh=67b95olowQ+isYzwydNDN6Radf0JIG1S4CIYb7RgShg=;
	b=OrN5dpv6ydiZu5TLcf9T6S92nRVJykJRRiufecSXzt6Pm1uWFc8fVGLtX3RDzLwd3iOe
	 Y1mAVQCzmLykeMT6jsENJk2cjrTrHrfm8AKPuxNZHmmdudwusyirqU3so+y5tpAcq3GLH
	 zA3INj4JvnDF7tL1jHigzkGwsU03688d2/W21HDfSGT1CbIQeUjwDj2X8vHpY/hMGDBg9
	 uQi1pWT9KLEvpcTqkRfdKUb+7fQv905XjjROnZ+arR9s7DnMWULV+aZVnKTQ4Jn+0tmCf
	 rSlcwQ+YSX/QTEd1AsYfoEq13lNqlPWDtEeEFhAtqubJDLPQjzSvYBWR3SasE0P9XFg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791952091;
	bh=67b95olowQ+isYzwydNDN6Radf0JIG1S4CIYb7RgShg=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KbLBcGoabE2PMci86ire0CxKqg4hcwWn1oAK+TaJkUI9rVXKBy6bjYtnfmZ0F1o3s
	 8Gm4MjJ7mBMbrv1QK8yu5uBIUSIxtsNMLZv8Gxfrz4hAHGn4/2KViIh7EI0OWg97J2
	 LZhqEZsTFFMXOzHNxAUf8e3E3MYar+lRbjVB3npWDNv6FwwMVfgeCfNpvk5MMR74sc
	 prDa+aHb1JQM8L/liSFh0mLauOrBO8Epme0UYykcGiiwJkCk2swxNopTTKfASLH0B9
	 fNWqn3KXxRS7Df1yKQnBKOC/X5qhYGaUBpwKU1DICqbISxPbgG26Kha8QsZ1IJyokb
	 dQsU0QTpGHfBA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C6A1C80D6A;
	Wed, 14 Oct 2026 04:28:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id E02C22AE
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 02:54:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CEDE8406C6
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 02:54:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 23NiiipwwPdX for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 02:54:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 86B93406C5
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:18f0:1e00:4::5"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791946463;
 b=ki+ItpOCLTXuYUZ288Fj36pVp27ZUUxq2rZtlZSc5F3xqRQMRT+MUZ77e4NfBGnADybY
 THXmx8JR/vYPyuq7xP92cMUM4RWw+6cS6TFRa6Wf/dOSNO9Xf8nj7LOscpY+Crds+kR1p
 OqAjnJUg+7VBmMOX7ZNbWY14k3i7uq+MhCIiprGoIGzjQU4cnrdpYEwQIKU27L6mk5sS/
 SLi24zhlGU4CA3UdYVcxxawFymO6+d78D0dC31Mk/cAbVVxidfRypXNKVpKr0zGXWwvlY
 FIeE7B9hl1/2mHPPdK5Olkt/YghiFXYAjrZtbvf70v0+n5wgmXb62lcPzjl9uiSZpIQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791946463;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:X-Amp-Result:Received:Received:Received:
 From:To:CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:
 References:In-Reply-To:Accept-Language:Content-Language:
 X-MS-Has-Attach:X-MS-TNEF-Correlator:x-originating-ip:Content-Type:
 Content-Transfer-Encoding:MIME-Version;
 bh=67b95olowQ+isYzwydNDN6Radf0JIG1S4CIYb7RgShg=;
 b=LYWh5gpp18cl365KzHw2upu1QJYytQ9Mqg1Pq7zTBvE+htuBz/3yWcHdg7HG0eww5VpH
 KohGLIPYrdh0LbfgRHj5JIcw6gwV07gu/8M+W+QqX/1SpK2/NUu6LH8YzyM1MuTSHH0+u
 T6KZe5FWWhyjnv1kLK5ZE0AJhYGTVSf+BBCfldvpP5fCDUsegceaErxkWLDLJmOH7BKXq
 1SJy6+oRQksRLFDXVUyg0XIcbZpGDCeT+aUG9X6wy35SMhqYnPNK6SVhdvHPvxdyHT3BL
 KlpbS2RujYmhyzEgVksv8AjIZ1kQ0HniqSmBEeK474bPczJqEo2s6T8Izy75B/77JhQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=infineon.com;
 dkim=pass header.d=infineon.com header.i=@infineon.com header.a=rsa-sha256
 header.s=IFXMAIL header.b=mwx4jvUQ; 
 arc=none smtp.remote-ip="2a00:18f0:1e00:4::5"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:18f0:1e00:4::5;
 helo=smtp11.infineon.com; envelope-from=takahiro.kuwano@infineon.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=infineon.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=infineon.com header.i=@infineon.com header.a=rsa-sha256
 header.s=IFXMAIL header.b=mwx4jvUQ
Received: from smtp11.infineon.com (smtp11.infineon.com
 [IPv6:2a00:18f0:1e00:4::5])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 86B93406C5
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 02:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
 t=1791946463; x=1823482463;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=67b95olowQ+isYzwydNDN6Radf0JIG1S4CIYb7RgShg=;
 b=mwx4jvUQBPVAOvZA4k/0TX/fM6i2/jjYu037NlAj37F5OE3u37b7HPxa
 dlzFZcwDoUhMXShFI1CDFN6lyog1i/dwPwFt+fSCziG7zPLdNtsMfK8rY
 hIly9y+WIEJ9E1TwFxupakO5T1J6MsuxIy4ih9IZzSzvbxPJVWsN7WQkP w=;
X-CSE-ConnectionGUID: xEBfmbUqRmOvfxqR95Au5w==
X-CSE-MsgGUID: d9/VoKrmQ/qZI4mwmP5zSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="165215832"
X-IronPort-AV: E=Sophos;i="6.27,156,1787004000"; d="scan'208";a="165215832"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE819.infineon.com) ([172.23.29.45])
 by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 04:54:19 +0200
Received: from MUCSE815.infineon.com (172.23.29.41) by MUCSE819.infineon.com
 (172.23.29.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 14 Oct
 2026 04:54:18 +0200
Received: from MUCSE815.infineon.com ([fe80::b54c:c0bd:546c:c9be]) by
 MUCSE815.infineon.com ([fe80::b54c:c0bd:546c:c9be%12]) with mapi id
 15.02.2562.053; Wed, 14 Oct 2026 04:54:18 +0200
From: <Takahiro.Kuwano@infineon.com>
To: <hs@nabladev.com>, <sjg@chromium.org>
CC: <u-boot@lists.u-boot-project.org>, <marek.vasut+renesas@mailbox.org>,
 <vigneshr@ti.com>, <jbx6244@gmail.com>, <stefan.bigler@securiton.ch>,
 <quentin.schulz@cherry.de>, <trini@konsulko.com>, <vjardin@free.fr>,
 <kilicyasirahmet@gmail.com>
Subject: RE: [PATCH v2 3/5] mtd: add driver for the Microchip 23LCV1024 SPI
 SRAM
Thread-Topic: [PATCH v2 3/5] mtd: add driver for the Microchip 23LCV1024 SPI
 SRAM
Thread-Index: AQHdU7XVNeLYzJhL60yx5+hOYpVsKLb0sI0AgAAyPFD///VzAIAFsXIAgAAqLWD///vngIABpNLA
Date: Wed, 14 Oct 2026 02:54:18 +0000
Message-ID: <6b8e24a3c7774d48940411b43217f7ee@infineon.com>
References: <20261004040657.3156402-1-hs@nabladev.com>
 <20261004040657.3156402-4-hs@nabladev.com>
 <CAFLszThGYtvGYmYi1iOjRiqBANzbNSOt00n1HHzOWX8GXw3P0A@mail.gmail.com>
 <e66df57a82424e6d9b1fe8e2e5b7041f@infineon.com>
 <d19b3b84-86fe-4f46-a9f3-95bb18b20d13@nabladev.com>
 <702923f8-7957-c8e1-0c02-1663240740b5@nabladev.com>
 <18b0ae1aac0f4539b94b0a5b914c3329@infineon.com>
 <e5436f07-cd26-ec6b-87d2-1b9a5f999a90@nabladev.com>
In-Reply-To: <e5436f07-cd26-ec6b-87d2-1b9a5f999a90@nabladev.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.161.6.196]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 14 Oct 2026 04:27:54 +0000
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

SGkgSGVpa28sDQoNCj4gSGkgVGFrYWhpcm8uS3V3YW5vLA0KPiANCj4gT24gMTMuMTAuMjYgMDM6
MjAsIFRha2FoaXJvLkt1d2Fub0BpbmZpbmVvbi5jb20gd3JvdGU6DQo+ID4gSGkgSGVpa28sDQo+
ID4NCj4gPj4gSGkgVGFrYWhpcm8uS3V3YW5vLA0KPiA+Pg0KPiA+PiBPbiAwOS4xMC4yNiAxMToy
OCwgSGVpa28gU2Nob2NoZXIgd3JvdGU6DQo+ID4+PiBIZWxsbyBUYWthaGlyby5LdXdhbm8sDQo+
ID4+Pg0KPiA+Pj4ganVzdCBhbnN3ZXIgaGVyZSwgYmVmb3JlIEkgbG9va2VkIGludG8gdGhlIGNv
bW1lbnRzIGZyb20gU2ltb24uLi4NCj4gPj4+DQo+ID4+PiBPbiAwOS4xMC4yNiAxMDoyOSwgVGFr
YWhpcm8uS3V3YW5vQGluZmluZW9uLmNvbSB3cm90ZToNCj4gPj4+PiBIaSBIZWlrbyBhbmQgU2lt
b24sDQo+ID4+Pj4NCj4gPj4+Pj4gSGkgSGVpa28sDQo+ID4+Pj4+DQo+ID4+Pj4+IE9uIDIwMjYt
MTAtMDRUMDQ6MDY6NDQsIEhlaWtvIFNjaG9jaGVyIDxoc0BuYWJsYWRldi5jb20+IHdyb3RlOg0K
PiA+Pj4+Pj4gbXRkOiBhZGQgZHJpdmVyIGZvciB0aGUgTWljcm9jaGlwIDIzTENWMTAyNCBTUEkg
U1JBTQ0KPiA+Pj4+Pj4NCj4gPj4+Pj4+IFRoZSAyM0xDVjEwMjQgaXMgYSAxIE1iaXQgc2VyaWFs
IFNSQU0gd2l0aCBiYXR0ZXJ5IGJhY2t1cCwgc2l0dGluZyBvbg0KPiA+Pj4+Pj4gYW4gU1BJIGJ1
cyBhbmQgdXNlZCBhcyBub24gdm9sYXRpbGUgc2NyYXRjaCBzdG9yYWdlLiBSZWdpc3RlciBpdCBh
cyBhbg0KPiA+Pj4+Pj4gTVREIGRldmljZSBvZiB0eXBlIE1URF9SQU0sIHNvIHRoZSBtdGQgY29t
bWFuZCByZWFjaGVzIGl0Lg0KPiA+Pj4+Pj4NCj4gPj4+Pj4+IFRoZSBkZXZpY2UgcG93ZXJzIHVw
IGluIGJ5dGUgb3BlcmF0aW9uLCB3aGVyZSBldmVyeSBjb21tYW5kIGNhcnJpZXMNCj4gPj4+Pj4+
IGV4YWN0bHkgb25lIGRhdGEgYnl0ZS4gU2VsZWN0IHNlcXVlbnRpYWwgb3BlcmF0aW9uIG9uY2Ug
ZHVyaW5nIHByb2JlLA0KPiA+Pj4+Pg0KPiA+Pj4+PiBKdXN0IHRvIGNoZWNrLCBpcyB0aGlzIHJp
Z2h0PyBNeSB1bmRlcnN0YW5kaW5nIGlzIHRoYXQgdGhlDQo+ID4+Pj4+IDIzTEMxMDI0LzIzTENW
MTAyNCBkYXRhIHNoZWV0IGdpdmVzIHNlcXVlbnRpYWwgbW9kZSAoMDEpIGFzIHRoZSBNT0RFDQo+
ID4+Pj4+IHJlZ2lzdGVyIGRlZmF1bHQ7IGJ5dGUgbW9kZSBpcyB0aGUgZGVmYXVsdCBvbmx5IG9u
IHRoZSBvbGRlciAyM0syNTYuDQo+ID4+Pj4+IFRoZSBMaW51eCBtY2hwMjNrMjU2IGRyaXZlciBu
ZXZlciB3cml0ZXMgdGhlIE1PREUgcmVnaXN0ZXIuIFNldHRpbmcgaXQNCj4gPj4+Pj4gZXhwbGlj
aXRseSBpcyBzdGlsbCBhIGZpbmUgZGVmZW5zaXZlIHN0ZXAsIHNpbmNlIHNvbWV0aGluZyBlbHNl
IGNvdWxkDQo+ID4+Pj4+IGhhdmUgY2hhbmdlZCB0aGUgbW9kZSBhbmQgdGhlIHBhcnQga2VlcHMg
aXQgd2hpbGUgb24gYmF0dGVyeS4gUGxlYXNlDQo+ID4+Pj4+IGNhbiB5b3UgcmV3b3JkIHRoZSBj
b21taXQgbWVzc2FnZSBhbmQgdGhlIGNvbW1lbnQgaW4gc3BpX3JhbV9wcm9iZSgpDQo+ID4+Pj4+
IHRvIG1hdGNoPw0KPiA+Pj4+Pg0KPiA+Pj4+Pj4gc28gdGhhdCBhIHJlYWQgb3IgYSB3cml0ZSBv
ZiBhbnkgbGVuZ3RoIGlzIHNlcnZlZCBieSBhIHNpbmdsZSBjb21tYW5kDQo+ID4+Pj4+PiBhbmQg
dGhlIGJ1cyBpcyBjbGFpbWVkIG9uY2UgcGVyIHRyYW5zZmVyLg0KPiA+Pj4+Pj4NCj4gPj4+Pj4+
IFdyaXRpbmcgbmVlZHMgbm8gZXJhc2UuIFRoZSBkcml2ZXIgdGhlcmVmb3JlIGltcGxlbWVudHMg
bm8gZXJhc2UNCj4gPj4+Pj4+IG9wZXJhdGlvbiBhbmQgc2F5cyBNVERfTk9fRVJBU0UgaW4gdGhl
IE1URCBmbGFncy4NCj4gPj4+Pj4+DQo+ID4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gQmln
bGVyIDxzdGVmYW4uYmlnbGVyQHNlY3VyaXRvbi5jaD4NCj4gPj4+Pj4+IFNpZ25lZC1vZmYtYnk6
IEhlaWtvIFNjaG9jaGVyIDxoc0BuYWJsYWRldi5jb20+DQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gTUFJ
TlRBSU5FUlMgICAgICAgICAgICAgICB8wqDCoCA1ICsrDQo+ID4+Pj4+PiAgICBjb25maWdzL3Nh
bmRib3hfZGVmY29uZmlnIHzCoMKgIDEgKw0KPiA+Pj4+Pj4gICAgZHJpdmVycy9tdGQvS2NvbmZp
ZyAgICAgICB8wqAgMTQgKysrDQo+ID4+Pj4+PiAgICBkcml2ZXJzL210ZC9NYWtlZmlsZSAgICAg
IHzCoMKgIDEgKw0KPiA+Pj4+Pj4gICAgZHJpdmVycy9tdGQvc3BpX3JhbS5jICAgICB8IDIyMiAr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4+Pj4+PiAg
ICA1IGZpbGVzIGNoYW5nZWQsIDI0MyBpbnNlcnRpb25zKCspDQo+ID4+Pj4+DQo+ID4+Pj4+PiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQvS2NvbmZpZyBiL2RyaXZlcnMvbXRkL0tjb25maWcNCj4g
Pj4+Pj4+IEBAIC0xOTQsNiArMTk0LDIwIEBAIGNvbmZpZyBBTFRFUkFfUVNQSQ0KPiA+Pj4+Pj4g
K2NvbmZpZyBTUElfUkFNDQo+ID4+Pj4+PiArICAgICBib29sICJNaWNyb2NoaXAgMjNMQ1YxMDI0
IFNQSSBTUkFNIg0KPiA+Pj4+Pj4gKyAgICAgZGVwZW5kcyBvbiBETV9TUEkgJiYgRE1fTVREDQo+
ID4+Pj4+DQo+ID4+Pj4+IFNQSV9SQU0sIHNwaV9yYW0uYyBhbmQgdGhlIHNwaV9yYW0gZHJpdmVy
IG5hbWUgYXJlIHZlcnkgZ2VuZXJpYyBmb3IgYQ0KPiA+Pj4+PiBkcml2ZXIgdGhhdCBoYW5kbGVz
IG9uZSBNaWNyb2NoaXAgcGFydC4gTGludXggYWxyZWFkeSBzdXBwb3J0cyB0aGlzDQo+ID4+Pj4+
IGNoaXAgaW4gZHJpdmVycy9tdGQvZGV2aWNlcy9tY2hwMjNrMjU2LmMgKENPTkZJR19NVERfTUNI
UDIzSzI1NiksIGFuZA0KPiA+Pj4+PiB0aGUgYmluZGluZyBpbiBkdHMvdXBzdHJlYW0vQmluZGlu
Z3MvbXRkL21pY3JvY2hpcCxtY2hwMjNrMjU2LnlhbWwNCj4gPj4+Pj4gbGlzdHMgYm90aCBtaWNy
b2NoaXAsbWNocDIzazI1NiBhbmQgbWljcm9jaGlwLG1jaHAyM2xjdjEwMjQuIEhvdyBhYm91dA0K
PiA+Pj4+PiB1c2luZyB0aGUgTGludXggbmFtZXMsIGhlcmUgYW5kIGluIE1BSU5UQUlORVJTPw0K
PiA+Pj4+Pg0KPiA+Pj4+DQo+ID4+Pj4gSSB3b3VsZCByYXRoZXIgaGF2ZSBhIGdlbmVyaWMgU1BJ
LVJBTSBkcml2ZXIgdGhhdCBhbHNvIHN1cHBvcnRzIE1SQU0gWzFdDQo+ID4+Pj4gYW5kIEZSQU0g
ZGV2aWNlcyB1c2luZyB0aGUgY29tbW9uIG9wY29kZSBzZXQgd2l0aG91dCBlcmFzZS4NCj4gPj4+
Pg0KPiA+Pj4+IEN1cnJlbnRseSwgc29tZSBGUkFNIGNoaXBzIGFyZSBoYW5kbGVkIGJ5IFNQSS1O
T1IsIGJ1dCBuZXcgZGV2aWNlcyBzaG91bGQNCj4gPj4+PiBiZSBhZGRlZCB0byB0aGUgU1BJLVJB
TSBkcml2ZXIgaWYgaXQgZXhpc3RzLg0KPiA+Pj4+DQo+ID4+Pj4gV2hhdCBhcmUgeW91ciB0aG91
Z2h0cyBvbiB0aGlzPw0KPiA+Pj4NCj4gPj4+IFNlZW1zIGxpa2UgYSB2YWxpZCBhcmd1bWVudCB0
byBtZS4gU2ltb24/IFdoYXQgZG8geW91IHRoaW5rPw0KPiA+Pg0KPiA+PiBBZnRlciBsb29raW5n
IGludG8gcGF0Y2hlcyBmcm9tIFlhc2lyIChhZGRlZCB0byBjYykuIHRoZSBGUkFNDQo+ID4+IGNh
c2UgaXMgZGlmZmVyZW50LiBUaGUgRlJBTSAoYXQgbGVhc3QgdGhlIG9uZSBZYXNpciBhZGRzKSBo
YXMgYSBKRURFQw0KPiA+PiBpbnRlcmZhY2UsIHRoZSAyM0xDVjEwMjQgaGFzIG5vdCEgU28gMjNM
Q1YxMDI0IGlzIHJlYWxseSBzcGVjaWFsLCBhbmQgSQ0KPiA+PiBjdXJyZW50bHkgdGVuZCB0byBz
YXksIHRoYXQgU2ltb24gaXMgY29ycmVjdCwgdGhhdCB3ZSBzaG91bGQgbmFtZQ0KPiA+PiB0aGUg
MjNMQ1YxMDI0IGRyaXZlciBkcml2ZXJzL210ZC9kZXZpY2VzL21jaHAyM2syNTYuYy4NCj4gPg0K
PiA+IFRoZSBNUkFNIChub3QgRlJBTSkgcGFydCBkb2Vzbid0IHN1cHBvcnQgUmVhZCBJRCAoSkVE
RUMgSUQpIGNvbW1hbmQuIFlhc2lyDQo+ID4gbWVudGlvbnMgdGhhdCBpbiB0aGUgY29tbWl0IGRl
c2NyaXB0aW9uIGFuZCBJIGNoZWNrZWQgZGF0YXNoZWV0IFsxXS4NCj4gPiBXaHkgZGlkIHlvdSBn
ZXQgaXQgaGFzIGEgSkVERUMgaW50ZXJmYWNlPw0KPiANCj4gU2VlbXMgSSBsb29rZWQgaW50byB0
aGUgd3JvbmcgZGF0YXNoZWV0ISBNYXliZSBpdCBpcyB0b28gZWFybHkgZm9yIG1lIGhlcmUuLi4N
Cj4gSSBuZWVkIGEgY29mZmVlIG5vdy4NCj4gDQo+IFRoYW5rcyENCj4gDQo+IEluIGxpbnV4IHRo
ZSBNUkFNIFlhc2lyIGFkZHMsIGlzIGFsc28gaGFuZGxlZCBpbiBzcGkgbm9yIGRyaXZlci4NCj4g
DQpZZXMsIGl0IHdhcyBhZGRlZCBxdWl0ZSBzb21lIHRpbWUgYWdvLiBXZSBubyBsb25nZXIgYWRk
IG5ldyB4UkFNIChub24tZXJhc2UpDQpkZXZpY2VzIHRvIHNwaS1ub3IuDQoNCj4gdGhlIHJlZ2lz
dGVyIDUvMSAocmVhZC93cml0ZSBzdGF0dXMgcmVnaXN0ZXIpIGFuZCAzLzIgKHJlYWQvd3JpdGUg
ZGF0YSkNCj4gc2VlbXMgdGhlIHNhbWUgZm9yIGJvdGggY2hpcHMgYW5kIGZvciBzcGktbm9yIHN1
YnN5c3RlbS4NCj4gDQo+IEJ1dCwgc3BpLW5vciBhbmQgTVJBTSBleHBlY3QgYSAic3RhdHVzIHJl
Z2lzdGVyIiBhbmQgdGhlIDIzTENWMTAyNCBbMl0NCj4gaGFzIHRoZXJlIGEgbW9kZSByZWdpc3Rl
ciwgd2l0aCBkaWZmZXJlbnQgYml0IG1lYW5pbmdzIQ0KPiANCkkgc3RpbGwgdGhpbmsgd2UgY2Fu
IGhhbmRsZSB0aGlzIGRpZmZlcmVuY2UgdXNpbmcgY29tcGF0aWJsZXMgYW5kIGRldmljZQ0Kc3Bl
Y2lmaWMgZml4dXAgaG9va3MsIGJ1dC4uLg0KDQo+IFNlZW1zIHRvIG1lLCB0aGF0IGlzIHdoeSB0
aGUgMjNMQ1YxMDI0IGdvdCBoaXMgb3duIGRyaXZlciBpbiBsaW51eC4uLg0KPiBldmVuIGlmIHRo
aXMgaXMgdGhlIG9ubHkgb2J2aW91cyBkaWZmZXJlbmNlIChub3QgY2hlY2tlZCBkZWVwZXIgbm93
KS4NCj4gDQo+IEkgdGVuZCB0byBiZSBpbiBzeW5jIHdpdGggbGludXggaGVyZSwgYW5kIHN0aWxs
IGFkZCB0aGUgTVJBTSBZYXNpciBhZGRzIHRvDQo+IHRoZSBzcGktbm9yIGRyaXZlciwgYW5kIGhh
dmUgYW4gb3duIGRyaXZlciBmb3IgdGhlIDIzTENWMTAyNCBpbiBkcml2ZXJzL210ZC9kZXZpY2Vz
Lg0KPiANCmtlZXBpbmcgaW4gc3luYyB3aXRoIExpbnV4IGlzIGdlbmVyYWxseSByaWdodCB0aGlu
ZyB0byBkb/CfmIoNCg0KPiBJZiBub3QgSSBzZWUgMiBvcHRpb25zOg0KPiANCj4gYSkgWWFzaXIg
YWRkcyB0aGUgTVIyNUg0MCB0byB0aGUgInNwaS1yYW0iIGRyaXZlciBpbiB0aGlzIHRocmVhZA0K
PiAgICAgaW4gYSBmb2xsb3cgdXAgc2VyaWVzLiBJIHRlbmQgdG8gc2F5LCBJIGZpcnN0IGdvIHdp
dGggZHJpdmVyIHBsYWNlDQo+ICAgICBhbmQgbmFtZSBTaW1vbiBwcm9wb3NlZC4NCj4gYikgYWRk
IDIzTENWMTAyNCB0byBzcGktbm9yIHN1YnN5c3RlbSBhbmQgZmluZCBhIHdheSB0byB3b3JrIG91
dCBtb2RlL3N0YXR1cw0KPiAgICAgcmVnaXN0ZXIgZGlmZmVyZW5jZXMNCj4gDQo+IG90aGVyIG9w
dGlvbnM/DQo+IA0KPiBiKSBzZWVtcyB1Z2x5LCBhKSBkb2FibGUuLi4gYnV0IGFsbCBvcHRpb25z
IGRpZmZlciB0byBsaW51eCBhcHByb2FjaC4NCj4gDQpBdCBzb21lIHBvaW50LCBJIHBsYW4gdG8g
cHJvcG9zZSBnZW5lcmljIHNwaS1yYW0gZHJpdmVyLiBJIGhhdmUgYSBmZXcgSW5maW5lb24NCkZS
QU0gZGV2aWNlcyB0aGF0IHdvdWxkIGJlbmVmaXQgZnJvbSBpdC4NCg0KPiBieWUsDQo+IEhlaWtv
DQo+IA0KQW55d2F5LCB0aGFua3MgZm9yIHRha2luZyB0aGUgdGltZSB0byB0aGluayBhYm91dCB0
aGlzIQ0KVGFrYWhpcm8NCg0K
