Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5182FD9E14
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 21:46:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5C4483AA9;
	Thu, 26 Feb 2026 22:46:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="UFKtQcyJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 102EE83D1A; Thu, 26 Feb 2026 22:46:42 +0100 (CET)
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz
 [IPv6:2001:df5:b000:5::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41F1883642
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 22:46:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=alliedtelesis.co.nz
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Ronan.Dalton@alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 56ADE2C0304;
 Fri, 27 Feb 2026 10:46:33 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
 s=mail181024; t=1772142393;
 bh=+sCnGGuvn5U//P0isOY73kXO1Zn8CjP4GVRUSLlxs8Y=;
 h=From:To:Subject:Date:References:In-Reply-To:From;
 b=UFKtQcyJK9MxCeIbI9YWHRm64TzmpG+KoPMzhiID2opAjd2NaTczz5QTY+m66GVtS
 9nZNt9fgG7oOSkJRb1IFeRSjbstW2ylCx9VyWvKNU7ZZDY5Sn5OCammeSUwcZn3vYL
 LKzdz0BgqEiqe09cN12X5wnlxfkxZwdolkmSsLyn8pXLxiKVPAwErvNGhlfkxERMnX
 3fCqG/muXbqlw0AodoL2Q3HSf9EYClb6HihUqm+D4qh30Wal6rD4RIYi+H2UsiZ293
 iLiqESS3NbQdFNjLUAFsk6jBpcu0MVELMS+R3f1oH3N6JzWQe21G+362Ju5FHxrGYo
 M2WVEC1+sQfWw==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by
 svr-chch-seg1.atlnz.lc with Trustwave SEG (v8, 2, 6, 11305)
 id <B69a0bf390000>; Fri, 27 Feb 2026 10:46:33 +1300
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Fri, 27 Feb 2026 10:46:33 +1300
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1748.039; Fri, 27 Feb 2026 10:46:33 +1300
From: Ronan Dalton <Ronan.Dalton@alliedtelesis.co.nz>
To: "marek.vasut@mailbox.org" <marek.vasut@mailbox.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH] usb: Fix USB read configuration error on some devices
Thread-Topic: [PATCH] usb: Fix USB read configuration error on some devices
Thread-Index: AQHcoiQSuGyGCqWzE0ybxFJ4VBL9WbWLSLyAgAMqE4CABkG4AA==
Date: Thu, 26 Feb 2026 21:46:33 +0000
Message-ID: <853b645b96d05c8e1a193e1ab10458b7e8228a9f.camel@alliedtelesis.co.nz>
References: <20260220044709.1065540-1-ronan.dalton@alliedtelesis.co.nz>
 <c9179461-cc40-49b6-ab10-086f4e5c1eda@mailbox.org>
 <4550f320c271db50ff8af455244eadad0f435099.camel@alliedtelesis.co.nz>
In-Reply-To: <4550f320c271db50ff8af455244eadad0f435099.camel@alliedtelesis.co.nz>
Accept-Language: en-US, en-NZ
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.33.12.18]
Content-Type: text/plain; charset="utf-8"
Content-ID: <ECE008D01B294C4E9E23D9829BEF713A@alliedtelesis.co.nz>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=d/NWygjE c=1 sm=1 tr=0 ts=69a0bf39
 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=BhaoXNk7gXQA:10
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=hCYQpMK8XeWRj9S7-g8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
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

SGkgTWFyZWssDQoNCk9uIFN1biwgMjAyNi0wMi0yMiBhdCAyMjoxMyArMDAwMCwgUm9uYW4gRGFs
dG9uIHdyb3RlOg0KPiBPbiBGcmksIDIwMjYtMDItMjAgYXQgMjI6NTQgKzAxMDAsIE1hcmVrIFZh
c3V0IHdyb3RlOg0KPiA+IA0KPiA+IERvZXMgdGhlIGZvbGxvd2luZyBhbHNvIG1ha2UgdGhlIFVT
QiBzdGljayB3b3JrID8NCj4gPiANCj4gPiA9PiBzZXRlbnYgdXNiX3Bnb29kX2RlbGF5IDIwMDAN
Cj4gPiA9PiB1c2IgcmVzZXQNCj4gPiANCj4gPiA/DQo+IA0KPiBJdCBkb2VzIG5vdC4NCg0KSSBq
dXN0IHdhbnRlZCB0byBmb2xsb3ctdXAgdG8gY2hlY2sgdGhlIHN0YXR1cyBvZiB0aGlzIHBhdGNo
LiBHaXZlbg0KdGhhdCB5b3VyIHN1Z2dlc3RlZCB3b3JrYXJvdW5kIGRvZXMgbm90IGZpeCB0aGUg
aXNzdWUsIGRvIHlvdSBoYXZlIGFueQ0KZnVydGhlciBjb21tZW50cyBvbiB0aGUgcGF0Y2g/DQoN
ClRoYW5rcywNClJvbmFuLg0K
