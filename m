Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 927D1CC6B1A
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 09:20:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3C10E6081A;
	Wed, 14 Oct 2026 09:20:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DXk-LrsHhs20; Wed, 14 Oct 2026 09:20:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 39875607ED
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791969606;
	b=c/sLDRFt+OLX3gWMjNgyGUFBxojzHRar3Vl8lpB4vtCbe+MOaXZqjUP42hHPg4fSYQ7d
	 ySo9QClHl5Gy1T0oFSDmMaEtEIIVG1gyGrQdo+ms5zg4+qyxJd6jx0h5Q0s4Lhh0j9vGk
	 O/YciOu8JUDRXA/YfblmuZPo8BVzzymRkPJuGTt8mRvxQ9AWWNbTr/kfNE5XFES6kZv/O
	 tZqK1QPfhXBx++kn7R8Ouej61+J4kQMUm165Xx2TSe2onBGcKwU4AY9hRj6WX5Mt0R33Y
	 SzqgiDxlrTrdR8XbW3gqu+O7z2BNyBPtxQRTR6M82LCaEQW8yKL0W3pFaAdPKoxByZw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791969606;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:Received:From:
	 To:CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
	 In-Reply-To:Accept-Language:Content-Language:X-MS-Has-Attach:
	 X-MS-TNEF-Correlator:x-originating-ip:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=baX1y8h+cSytWBK8aqBzx2+4F9X4RLCs5vDMi5XH7aw=;
	b=qerGAshwTrJlCeRcEOUDhYK1k9/D+Ssqo3cjRO8LdO99roeEpZmyKHPCPA1QJZZLWKFg
	 aMqD70FzZzrCzXZvcve5YwHnPoEmCQnqDMGoYCYgQocNPCfm6wmNP287puWAgXyYITFVr
	 AFUqXuCLDGiTZSXnvC7tHanp9D8TNHHtOGvB2XocYIb0zXVu9phI04/BCGNa9cYNl1F6A
	 f/lKpKlkAlXbmI2/qP2X+MkgQkPiYWBuHfAb+GILW9mAY/IEmwRxjlj7NzhfG75Ve06Gf
	 dZPUN7AFuyPljSIU5LgszYPSFYOwF8kc82smX9OpeEgMxEw0bghp6V1HIR6vjTQJvEg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=infineon.com;
	dkim=pass header.d=infineon.com header.i=@infineon.com header.a=rsa-sha256 header.s=IFXMAIL header.b=AC39jx0q;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791969606;
	bh=baX1y8h+cSytWBK8aqBzx2+4F9X4RLCs5vDMi5XH7aw=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WZ9JVfbYu5oEP5Vwbp12xV2yabRUu1tWfshkNKafmBDeGSz4wBt9Qz3MhjvTqUWDa
	 QCtAFjqFa5I3ibMDUWOdX8NMjFkHNbqaaHYJMOWBjR4w123SV4I6c0JjGCDidBCRrF
	 kQeX0vX+jXenA8EspwJv+y1wlhjpvKcB4ZXDoLWJJtvrgX9NLjTtToYhXCZHXYkj0J
	 8IsZxAdIjjhMin/9nxOP0nz4/Gcus0fzfrH+lL+0fHWhl3QwAuIiBY9sZoAzkatSA3
	 On4uXLwHVCixCWHzcxwFn5KQUHwlX9XJLRHwmoxWqltyVIrHlRbspMdL6MRVdGJmTL
	 AYDCMBvQJNFyw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 39875607ED;
	Wed, 14 Oct 2026 09:20:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 21C581DE
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 06:54:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 07E6360818
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 06:54:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v78Uc-tn7sj0 for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 06:54:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AE2EC60816
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:18f0:1e00:4::5"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791960874;
 b=YIrUw6kDvNKuezgmU2FVl4On41JcpW2gvghPM3f48E6BkVcRtFSxAqJQV/4T50KP9Ou1
 dGU5nIVph44HUVFY0Q/4YlY29w7WjlUKToyaKzKvwUftUb/SjHeKT9vJfLNgcrHO2x2og
 DMrOvw53xKr1C/In/BfovK+Sz6GOuyXBG4elzmbFFCQBYQ9h1gD34iEuzG1QVTysFMcu2
 vI2VXVYAiI/essCUDamLLYtDFI9xQWI3LqK8jWuAYXNrP/0OVifenW/5s+IJwYn13jfjs
 G8HUgmksbg1Z077975HvIyJE2kHkFQ7b9p27tnensjS4sWGtPoPh6BZkxfqvI9H2LYg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791960874;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:X-Amp-Result:Received:Received:Received:
 Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:
 References:In-Reply-To:Accept-Language:Content-Language:
 X-MS-Has-Attach:X-MS-TNEF-Correlator:x-originating-ip:Content-Type:
 Content-Transfer-Encoding:MIME-Version;
 bh=baX1y8h+cSytWBK8aqBzx2+4F9X4RLCs5vDMi5XH7aw=;
 b=ckjVvSy5QgruEmtCcvB6oMUmVfql1HPOBSsji8Bw/ivwfk0FydfT5rpzVirt58yYVDea
 d0xfH2MOpwos1/PwFwQT8TniUc4kpyxgmcPXXy0IbnSLpWld9GcyK8vPG+8ZDZq2YYIW3
 XWHD7cXWXZRbLVFXPk9nOJhJwMIwpiresuNyBqOJSb4XomauP57SMtZABla2j5aYVn8Oc
 CqPOUSMC867P+nVEQ8pJm3YbQ095oMBxmGWc583VPUvMHXzgdFSDhRD5tXuRne5WoEDUi
 STY99KHfbBTwM9eDBDrrEgFvvQqmmI0btYvCmpMd6mvBisbPiq9uz/noAFXFlPHPuRg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=infineon.com;
 dkim=pass header.d=infineon.com header.i=@infineon.com header.a=rsa-sha256
 header.s=IFXMAIL header.b=AC39jx0q; 
 arc=none smtp.remote-ip="2a00:18f0:1e00:4::5"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:18f0:1e00:4::5;
 helo=smtp11.infineon.com; envelope-from=takahiro.kuwano@infineon.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=infineon.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=infineon.com header.i=@infineon.com header.a=rsa-sha256
 header.s=IFXMAIL header.b=AC39jx0q
Received: from smtp11.infineon.com (smtp11.infineon.com
 [IPv6:2a00:18f0:1e00:4::5])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AE2EC60816
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 06:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
 t=1791960875; x=1823496875;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=baX1y8h+cSytWBK8aqBzx2+4F9X4RLCs5vDMi5XH7aw=;
 b=AC39jx0qGXj1vxxcqMIFq6qJbdPF6cNcXuN3X2KiAhLrSkpSlSfl31tT
 /B4sKS1dqLc0z/W0svWW/NJOQ991u1ImmQQJeLCeB+cxzqEz1wITe8j3F
 f7WPqw0O75pFnWqMtwHgqPcSMteC6Vv/1RrG24LODzeb4pIxVmcPDqrC3 I=;
X-CSE-ConnectionGUID: 7Z+Q7xc8S2KtN/OcEvv4Iw==
X-CSE-MsgGUID: AGBwMpUkSuevHoVVRaBwpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="165245742"
X-IronPort-AV: E=Sophos;i="6.27,157,1787004000"; d="scan'208";a="165245742"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE822.infineon.com) ([172.23.29.53])
 by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 08:54:29 +0200
Received: from MUCSE820.infineon.com (172.23.29.46) by MUCSE822.infineon.com
 (172.23.29.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 14 Oct
 2026 08:54:28 +0200
Received: from MUCSE815.infineon.com (172.23.29.41) by MUCSE820.infineon.com
 (172.23.29.46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 14 Oct
 2026 08:54:28 +0200
Received: from MUCSE815.infineon.com ([fe80::b54c:c0bd:546c:c9be]) by
 MUCSE815.infineon.com ([fe80::b54c:c0bd:546c:c9be%12]) with mapi id
 15.02.2562.053; Wed, 14 Oct 2026 08:54:27 +0200
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
Thread-Index: AQHdU7XVNeLYzJhL60yx5+hOYpVsKLb0sI0AgAAyPFD///VzAIAFsXIAgAAqLWD///vngIABpNLAgAAFnACAAEq1cA==
Date: Wed, 14 Oct 2026 06:54:27 +0000
Message-ID: <f169ffa5580840d6aa69a3e6ec8fc304@infineon.com>
References: <20261004040657.3156402-1-hs@nabladev.com>
 <20261004040657.3156402-4-hs@nabladev.com>
 <CAFLszThGYtvGYmYi1iOjRiqBANzbNSOt00n1HHzOWX8GXw3P0A@mail.gmail.com>
 <e66df57a82424e6d9b1fe8e2e5b7041f@infineon.com>
 <d19b3b84-86fe-4f46-a9f3-95bb18b20d13@nabladev.com>
 <702923f8-7957-c8e1-0c02-1663240740b5@nabladev.com>
 <18b0ae1aac0f4539b94b0a5b914c3329@infineon.com>
 <e5436f07-cd26-ec6b-87d2-1b9a5f999a90@nabladev.com>
 <6b8e24a3c7774d48940411b43217f7ee@infineon.com>
 <9722ba30-e91a-30e7-28c0-b5ac6db43ea6@nabladev.com>
In-Reply-To: <9722ba30-e91a-30e7-28c0-b5ac6db43ea6@nabladev.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.161.6.196]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 14 Oct 2026 09:20:05 +0000
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

PiBIZWxsbyBUYWthaGlybywNCj4gDQo+IE9uIDE0LjEwLjI2IDA0OjU0LCBUYWthaGlyby5LdXdh
bm9AaW5maW5lb24uY29tIHdyb3RlOg0KPiA+IEhpIEhlaWtvLA0KPiA+DQo+ID4+IEhpIFRha2Fo
aXJvLkt1d2FubywNCj4gPj4NCj4gPj4gT24gMTMuMTAuMjYgMDM6MjAsIFRha2FoaXJvLkt1d2Fu
b0BpbmZpbmVvbi5jb20gd3JvdGU6DQo+ID4+PiBIaSBIZWlrbywNCj4gPj4+DQo+ID4+Pj4gSGkg
VGFrYWhpcm8uS3V3YW5vLA0KPiA+Pj4+DQo+ID4+Pj4gT24gMDkuMTAuMjYgMTE6MjgsIEhlaWtv
IFNjaG9jaGVyIHdyb3RlOg0KPiA+Pj4+PiBIZWxsbyBUYWthaGlyby5LdXdhbm8sDQo+ID4+Pj4+
DQo+ID4+Pj4+IGp1c3QgYW5zd2VyIGhlcmUsIGJlZm9yZSBJIGxvb2tlZCBpbnRvIHRoZSBjb21t
ZW50cyBmcm9tIFNpbW9uLi4uDQo+ID4+Pj4+DQo+ID4+Pj4+IE9uIDA5LjEwLjI2IDEwOjI5LCBU
YWthaGlyby5LdXdhbm9AaW5maW5lb24uY29tIHdyb3RlOg0KPiA+Pj4+Pj4gSGkgSGVpa28gYW5k
IFNpbW9uLA0KPiA+Pj4+Pj4NCj4gPj4+Pj4+PiBIaSBIZWlrbywNCj4gPj4+Pj4+Pg0KPiA+Pj4+
Pj4+IE9uIDIwMjYtMTAtMDRUMDQ6MDY6NDQsIEhlaWtvIFNjaG9jaGVyIDxoc0BuYWJsYWRldi5j
b20+IHdyb3RlOg0KPiA+Pj4+Pj4+PiBtdGQ6IGFkZCBkcml2ZXIgZm9yIHRoZSBNaWNyb2NoaXAg
MjNMQ1YxMDI0IFNQSSBTUkFNDQo+ID4+Pj4+Pj4+DQo+ID4+Pj4+Pj4+IFRoZSAyM0xDVjEwMjQg
aXMgYSAxIE1iaXQgc2VyaWFsIFNSQU0gd2l0aCBiYXR0ZXJ5IGJhY2t1cCwgc2l0dGluZyBvbg0K
PiA+Pj4+Pj4+PiBhbiBTUEkgYnVzIGFuZCB1c2VkIGFzIG5vbiB2b2xhdGlsZSBzY3JhdGNoIHN0
b3JhZ2UuIFJlZ2lzdGVyIGl0IGFzIGFuDQo+ID4+Pj4+Pj4+IE1URCBkZXZpY2Ugb2YgdHlwZSBN
VERfUkFNLCBzbyB0aGUgbXRkIGNvbW1hbmQgcmVhY2hlcyBpdC4NCj4gPj4+Pj4+Pj4NCj4gPj4+
Pj4+Pj4gVGhlIGRldmljZSBwb3dlcnMgdXAgaW4gYnl0ZSBvcGVyYXRpb24sIHdoZXJlIGV2ZXJ5
IGNvbW1hbmQgY2Fycmllcw0KPiA+Pj4+Pj4+PiBleGFjdGx5IG9uZSBkYXRhIGJ5dGUuIFNlbGVj
dCBzZXF1ZW50aWFsIG9wZXJhdGlvbiBvbmNlIGR1cmluZyBwcm9iZSwNCj4gPj4+Pj4+Pg0KPiA+
Pj4+Pj4+IEp1c3QgdG8gY2hlY2ssIGlzIHRoaXMgcmlnaHQ/IE15IHVuZGVyc3RhbmRpbmcgaXMg
dGhhdCB0aGUNCj4gPj4+Pj4+PiAyM0xDMTAyNC8yM0xDVjEwMjQgZGF0YSBzaGVldCBnaXZlcyBz
ZXF1ZW50aWFsIG1vZGUgKDAxKSBhcyB0aGUgTU9ERQ0KPiA+Pj4+Pj4+IHJlZ2lzdGVyIGRlZmF1
bHQ7IGJ5dGUgbW9kZSBpcyB0aGUgZGVmYXVsdCBvbmx5IG9uIHRoZSBvbGRlciAyM0syNTYuDQo+
ID4+Pj4+Pj4gVGhlIExpbnV4IG1jaHAyM2syNTYgZHJpdmVyIG5ldmVyIHdyaXRlcyB0aGUgTU9E
RSByZWdpc3Rlci4gU2V0dGluZyBpdA0KPiA+Pj4+Pj4+IGV4cGxpY2l0bHkgaXMgc3RpbGwgYSBm
aW5lIGRlZmVuc2l2ZSBzdGVwLCBzaW5jZSBzb21ldGhpbmcgZWxzZSBjb3VsZA0KPiA+Pj4+Pj4+
IGhhdmUgY2hhbmdlZCB0aGUgbW9kZSBhbmQgdGhlIHBhcnQga2VlcHMgaXQgd2hpbGUgb24gYmF0
dGVyeS4gUGxlYXNlDQo+ID4+Pj4+Pj4gY2FuIHlvdSByZXdvcmQgdGhlIGNvbW1pdCBtZXNzYWdl
IGFuZCB0aGUgY29tbWVudCBpbiBzcGlfcmFtX3Byb2JlKCkNCj4gPj4+Pj4+PiB0byBtYXRjaD8N
Cj4gPj4+Pj4+Pg0KPiA+Pj4+Pj4+PiBzbyB0aGF0IGEgcmVhZCBvciBhIHdyaXRlIG9mIGFueSBs
ZW5ndGggaXMgc2VydmVkIGJ5IGEgc2luZ2xlIGNvbW1hbmQNCj4gPj4+Pj4+Pj4gYW5kIHRoZSBi
dXMgaXMgY2xhaW1lZCBvbmNlIHBlciB0cmFuc2Zlci4NCj4gPj4+Pj4+Pj4NCj4gPj4+Pj4+Pj4g
V3JpdGluZyBuZWVkcyBubyBlcmFzZS4gVGhlIGRyaXZlciB0aGVyZWZvcmUgaW1wbGVtZW50cyBu
byBlcmFzZQ0KPiA+Pj4+Pj4+PiBvcGVyYXRpb24gYW5kIHNheXMgTVREX05PX0VSQVNFIGluIHRo
ZSBNVEQgZmxhZ3MuDQo+ID4+Pj4+Pj4+DQo+ID4+Pj4+Pj4+IFNpZ25lZC1vZmYtYnk6IFN0ZWZh
biBCaWdsZXIgPHN0ZWZhbi5iaWdsZXJAc2VjdXJpdG9uLmNoPg0KPiA+Pj4+Pj4+PiBTaWduZWQt
b2ZmLWJ5OiBIZWlrbyBTY2hvY2hlciA8aHNAbmFibGFkZXYuY29tPg0KPiA+Pj4+Pj4+Pg0KPiA+
Pj4+Pj4+PiBNQUlOVEFJTkVSUyAgICAgICAgICAgICAgIHzCoMKgIDUgKysNCj4gPj4+Pj4+Pj4g
ICAgIGNvbmZpZ3Mvc2FuZGJveF9kZWZjb25maWcgfMKgwqAgMSArDQo+ID4+Pj4+Pj4+ICAgICBk
cml2ZXJzL210ZC9LY29uZmlnICAgICAgIHzCoCAxNCArKysNCj4gPj4+Pj4+Pj4gICAgIGRyaXZl
cnMvbXRkL01ha2VmaWxlICAgICAgfMKgwqAgMSArDQo+ID4+Pj4+Pj4+ICAgICBkcml2ZXJzL210
ZC9zcGlfcmFtLmMgICAgIHwgMjIyICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysNCj4gPj4+Pj4+Pj4gICAgIDUgZmlsZXMgY2hhbmdlZCwgMjQzIGluc2VydGlv
bnMoKykNCj4gPj4+Pj4+Pg0KPiA+Pj4+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQvS2Nv
bmZpZyBiL2RyaXZlcnMvbXRkL0tjb25maWcNCj4gPj4+Pj4+Pj4gQEAgLTE5NCw2ICsxOTQsMjAg
QEAgY29uZmlnIEFMVEVSQV9RU1BJDQo+ID4+Pj4+Pj4+ICtjb25maWcgU1BJX1JBTQ0KPiA+Pj4+
Pj4+PiArICAgICBib29sICJNaWNyb2NoaXAgMjNMQ1YxMDI0IFNQSSBTUkFNIg0KPiA+Pj4+Pj4+
PiArICAgICBkZXBlbmRzIG9uIERNX1NQSSAmJiBETV9NVEQNCj4gPj4+Pj4+Pg0KPiA+Pj4+Pj4+
IFNQSV9SQU0sIHNwaV9yYW0uYyBhbmQgdGhlIHNwaV9yYW0gZHJpdmVyIG5hbWUgYXJlIHZlcnkg
Z2VuZXJpYyBmb3IgYQ0KPiA+Pj4+Pj4+IGRyaXZlciB0aGF0IGhhbmRsZXMgb25lIE1pY3JvY2hp
cCBwYXJ0LiBMaW51eCBhbHJlYWR5IHN1cHBvcnRzIHRoaXMNCj4gPj4+Pj4+PiBjaGlwIGluIGRy
aXZlcnMvbXRkL2RldmljZXMvbWNocDIzazI1Ni5jIChDT05GSUdfTVREX01DSFAyM0syNTYpLCBh
bmQNCj4gPj4+Pj4+PiB0aGUgYmluZGluZyBpbiBkdHMvdXBzdHJlYW0vQmluZGluZ3MvbXRkL21p
Y3JvY2hpcCxtY2hwMjNrMjU2LnlhbWwNCj4gPj4+Pj4+PiBsaXN0cyBib3RoIG1pY3JvY2hpcCxt
Y2hwMjNrMjU2IGFuZCBtaWNyb2NoaXAsbWNocDIzbGN2MTAyNC4gSG93IGFib3V0DQo+ID4+Pj4+
Pj4gdXNpbmcgdGhlIExpbnV4IG5hbWVzLCBoZXJlIGFuZCBpbiBNQUlOVEFJTkVSUz8NCj4gPj4+
Pj4+Pg0KPiA+Pj4+Pj4NCj4gPj4+Pj4+IEkgd291bGQgcmF0aGVyIGhhdmUgYSBnZW5lcmljIFNQ
SS1SQU0gZHJpdmVyIHRoYXQgYWxzbyBzdXBwb3J0cyBNUkFNIFsxXQ0KPiA+Pj4+Pj4gYW5kIEZS
QU0gZGV2aWNlcyB1c2luZyB0aGUgY29tbW9uIG9wY29kZSBzZXQgd2l0aG91dCBlcmFzZS4NCj4g
Pj4+Pj4+DQo+ID4+Pj4+PiBDdXJyZW50bHksIHNvbWUgRlJBTSBjaGlwcyBhcmUgaGFuZGxlZCBi
eSBTUEktTk9SLCBidXQgbmV3IGRldmljZXMgc2hvdWxkDQo+ID4+Pj4+PiBiZSBhZGRlZCB0byB0
aGUgU1BJLVJBTSBkcml2ZXIgaWYgaXQgZXhpc3RzLg0KPiA+Pj4+Pj4NCj4gPj4+Pj4+IFdoYXQg
YXJlIHlvdXIgdGhvdWdodHMgb24gdGhpcz8NCj4gPj4+Pj4NCj4gPj4+Pj4gU2VlbXMgbGlrZSBh
IHZhbGlkIGFyZ3VtZW50IHRvIG1lLiBTaW1vbj8gV2hhdCBkbyB5b3UgdGhpbms/DQo+ID4+Pj4N
Cj4gPj4+PiBBZnRlciBsb29raW5nIGludG8gcGF0Y2hlcyBmcm9tIFlhc2lyIChhZGRlZCB0byBj
YykuIHRoZSBGUkFNDQo+ID4+Pj4gY2FzZSBpcyBkaWZmZXJlbnQuIFRoZSBGUkFNIChhdCBsZWFz
dCB0aGUgb25lIFlhc2lyIGFkZHMpIGhhcyBhIEpFREVDDQo+ID4+Pj4gaW50ZXJmYWNlLCB0aGUg
MjNMQ1YxMDI0IGhhcyBub3QhIFNvIDIzTENWMTAyNCBpcyByZWFsbHkgc3BlY2lhbCwgYW5kIEkN
Cj4gPj4+PiBjdXJyZW50bHkgdGVuZCB0byBzYXksIHRoYXQgU2ltb24gaXMgY29ycmVjdCwgdGhh
dCB3ZSBzaG91bGQgbmFtZQ0KPiA+Pj4+IHRoZSAyM0xDVjEwMjQgZHJpdmVyIGRyaXZlcnMvbXRk
L2RldmljZXMvbWNocDIzazI1Ni5jLg0KPiA+Pj4NCj4gPj4+IFRoZSBNUkFNIChub3QgRlJBTSkg
cGFydCBkb2Vzbid0IHN1cHBvcnQgUmVhZCBJRCAoSkVERUMgSUQpIGNvbW1hbmQuIFlhc2lyDQo+
ID4+PiBtZW50aW9ucyB0aGF0IGluIHRoZSBjb21taXQgZGVzY3JpcHRpb24gYW5kIEkgY2hlY2tl
ZCBkYXRhc2hlZXQgWzFdLg0KPiA+Pj4gV2h5IGRpZCB5b3UgZ2V0IGl0IGhhcyBhIEpFREVDIGlu
dGVyZmFjZT8NCj4gPj4NCj4gPj4gU2VlbXMgSSBsb29rZWQgaW50byB0aGUgd3JvbmcgZGF0YXNo
ZWV0ISBNYXliZSBpdCBpcyB0b28gZWFybHkgZm9yIG1lIGhlcmUuLi4NCj4gPj4gSSBuZWVkIGEg
Y29mZmVlIG5vdy4NCj4gPj4NCj4gPj4gVGhhbmtzIQ0KPiA+Pg0KPiA+PiBJbiBsaW51eCB0aGUg
TVJBTSBZYXNpciBhZGRzLCBpcyBhbHNvIGhhbmRsZWQgaW4gc3BpIG5vciBkcml2ZXIuDQo+ID4+
DQo+ID4gWWVzLCBpdCB3YXMgYWRkZWQgcXVpdGUgc29tZSB0aW1lIGFnby4gV2Ugbm8gbG9uZ2Vy
IGFkZCBuZXcgeFJBTSAobm9uLWVyYXNlKQ0KPiA+IGRldmljZXMgdG8gc3BpLW5vci4NCj4gDQo+
IEFoIQ0KPiANCj4gRm9yIHRoZSBvbmVzIHdobyAic2hhcmUiIHNwaSBub3IgaW50ZXJmYWNlLCB3
ZSBtYXkgc2hvdWxkIGV4dHJhY3QNCj4gdGhhdCBwYXJ0IGZyb20gc3BpIG5vciB0byBzaGFyZSB0
aGUgY29kZS4uLiBidXQgYXMgc2FpZCwgSSBhbSBub3QNCj4gdG8gZGVlcCBpbiB0aGUgY29kZS4u
Lg0KPiANCj4gPj4gdGhlIHJlZ2lzdGVyIDUvMSAocmVhZC93cml0ZSBzdGF0dXMgcmVnaXN0ZXIp
IGFuZCAzLzIgKHJlYWQvd3JpdGUgZGF0YSkNCj4gPj4gc2VlbXMgdGhlIHNhbWUgZm9yIGJvdGgg
Y2hpcHMgYW5kIGZvciBzcGktbm9yIHN1YnN5c3RlbS4NCj4gPj4NCj4gPj4gQnV0LCBzcGktbm9y
IGFuZCBNUkFNIGV4cGVjdCBhICJzdGF0dXMgcmVnaXN0ZXIiIGFuZCB0aGUgMjNMQ1YxMDI0IFsy
XQ0KPiA+PiBoYXMgdGhlcmUgYSBtb2RlIHJlZ2lzdGVyLCB3aXRoIGRpZmZlcmVudCBiaXQgbWVh
bmluZ3MhDQo+ID4+DQo+ID4gSSBzdGlsbCB0aGluayB3ZSBjYW4gaGFuZGxlIHRoaXMgZGlmZmVy
ZW5jZSB1c2luZyBjb21wYXRpYmxlcyBhbmQgZGV2aWNlDQo+ID4gc3BlY2lmaWMgZml4dXAgaG9v
a3MsIGJ1dC4uLg0KPiANCj4gSXQgaXMgbm90IG9ubHkgdGhlIHN0YXR1cyByZWdpc3RlciwgMjNM
Q1YxMDI0IGhhcyBubyBXUkVOICh3cml0ZSBlbmFibGUpLA0KPiBub3IgcG9sbGwgYSBzdGF0dXMg
cmVnaXN0ZXIuLi4gSXQgaXMgbXVjaCBtb3JlIHNpbXBsZXIuLi4gYnV0IHllcyBkb2FibGUuDQo+
IA0KPiA+DQo+ID4+IFNlZW1zIHRvIG1lLCB0aGF0IGlzIHdoeSB0aGUgMjNMQ1YxMDI0IGdvdCBo
aXMgb3duIGRyaXZlciBpbiBsaW51eC4uLg0KPiA+PiBldmVuIGlmIHRoaXMgaXMgdGhlIG9ubHkg
b2J2aW91cyBkaWZmZXJlbmNlIChub3QgY2hlY2tlZCBkZWVwZXIgbm93KS4NCj4gPj4NCj4gPj4g
SSB0ZW5kIHRvIGJlIGluIHN5bmMgd2l0aCBsaW51eCBoZXJlLCBhbmQgc3RpbGwgYWRkIHRoZSBN
UkFNIFlhc2lyIGFkZHMgdG8NCj4gPj4gdGhlIHNwaS1ub3IgZHJpdmVyLCBhbmQgaGF2ZSBhbiBv
d24gZHJpdmVyIGZvciB0aGUgMjNMQ1YxMDI0IGluIGRyaXZlcnMvbXRkL2RldmljZXMuDQo+ID4+
DQo+ID4ga2VlcGluZyBpbiBzeW5jIHdpdGggTGludXggaXMgZ2VuZXJhbGx5IHJpZ2h0IHRoaW5n
IHRvIGRv8J+Yig0KPiANCj4gOi1EDQo+IA0KPiA+DQo+ID4+IElmIG5vdCBJIHNlZSAyIG9wdGlv
bnM6DQo+ID4+DQo+ID4+IGEpIFlhc2lyIGFkZHMgdGhlIE1SMjVINDAgdG8gdGhlICJzcGktcmFt
IiBkcml2ZXIgaW4gdGhpcyB0aHJlYWQNCj4gPj4gICAgICBpbiBhIGZvbGxvdyB1cCBzZXJpZXMu
IEkgdGVuZCB0byBzYXksIEkgZmlyc3QgZ28gd2l0aCBkcml2ZXIgcGxhY2UNCj4gPj4gICAgICBh
bmQgbmFtZSBTaW1vbiBwcm9wb3NlZC4NCj4gPj4gYikgYWRkIDIzTENWMTAyNCB0byBzcGktbm9y
IHN1YnN5c3RlbSBhbmQgZmluZCBhIHdheSB0byB3b3JrIG91dCBtb2RlL3N0YXR1cw0KPiA+PiAg
ICAgIHJlZ2lzdGVyIGRpZmZlcmVuY2VzDQo+ID4+DQo+ID4+IG90aGVyIG9wdGlvbnM/DQo+ID4+
DQo+ID4+IGIpIHNlZW1zIHVnbHksIGEpIGRvYWJsZS4uLiBidXQgYWxsIG9wdGlvbnMgZGlmZmVy
IHRvIGxpbnV4IGFwcHJvYWNoLg0KPiA+Pg0KPiA+IEF0IHNvbWUgcG9pbnQsIEkgcGxhbiB0byBw
cm9wb3NlIGdlbmVyaWMgc3BpLXJhbSBkcml2ZXIuIEkgaGF2ZSBhIGZldyBJbmZpbmVvbg0KPiA+
IEZSQU0gZGV2aWNlcyB0aGF0IHdvdWxkIGJlbmVmaXQgZnJvbSBpdC4NCj4gDQo+IEdvb2QgdG8g
aGVhci4uLiBmb3IgbGludXggYW5kL29yIHUtYm9vdD8NCj4gDQpGb3IgdS1ib290LiBJbiBMaW51
eCwgRlJBTSBpcyBoYW5kbGVkIGJ5IGRyaXZlcnMvbnZtZW0vYXQyNS5jIGFzIFNQSSBFRVBST00N
CmNvbXBhdGlibGUgZGV2aWNlcy4gSWYgd2UgYWxzbyB3YW50IHRvIGNvdmVyIEVFUFJPTSBpbiB1
LWJvb3QsIHRoZW4gc3BpLXJhbQ0KbWF5IG5vdCBiZSB0aGUgcmlnaHQgbmFtZS4uLg0KDQo+IHNv
IGZvciB0aGUgc2VyaWVzLi4uIHNob3VsZCBJIHRyeSBhIG1vcmUgY29tbW9uIHNwaS1yYW0NCj4g
YXBwcm9hY2gsIG9yIGdvIHdpdGggbGludXggbGlrZSBkcml2ZXJzL210ZC9kZXZpY2VzL21jaHAy
M2syNTYuYyA/DQo+IA0KU28sIHBsZWFzZSBnbyB3aXRoIGxpbnV4IGxpa2Ugb25lLg0KDQpUaGFu
a3MgYWdhaW4sDQpUYWthaGlybw0KDQo=
