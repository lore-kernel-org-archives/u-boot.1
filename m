Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A41CCC6369E
	for <u-boot@archiver.kernel.org>; Sun, 22 Feb 2026 23:26:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6AE383935;
	Mon, 23 Feb 2026 00:26:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="qYQWXiA7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A2C980FA1; Sun, 22 Feb 2026 23:14:05 +0100 (CET)
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz
 [IPv6:2001:df5:b000:5::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3034C80077
 for <u-boot@lists.denx.de>; Sun, 22 Feb 2026 23:13:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=alliedtelesis.co.nz
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Ronan.Dalton@alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id EB37C2C025C;
 Mon, 23 Feb 2026 11:13:49 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
 s=mail181024; t=1771798429;
 bh=QzXr2wjbeI4HUivxgkgAKKvv0rIV9QS00kC9OncNr3o=;
 h=From:To:Subject:Date:References:In-Reply-To:From;
 b=qYQWXiA7eSHAl7wi04184ydi/1Sci0MnK5XymMTH9yUa/vJh3GXM41PjZeNfXoyzf
 o8vyH0us6lmJwaQg4fxuJVPLq/Npglz6BFn3qT4FNSJj+AZFKDl0QatfaFw1xjsdS6
 OFQFywRSGc9TmxOPxgv8q70dmkbp5HlRi1/5lGelQ1vQ9UgQRQNHvAxMsjyFm+C3/9
 Ak63fCpYvSEak5bGSZUGQGcAXzkVSxaJ8fE6oa23/cWqpxF/Rvcqci8WdhdFoBuGId
 /XNydaeKcESChpUjWdkE0QyWByQ1axryycRp6V3x3IqSYxuJXTBuwuMdugRGcZhdsV
 C92KpsaeJHefQ==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by
 svr-chch-seg1.atlnz.lc with Trustwave SEG (v8, 2, 6, 11305)
 id <B699b7f9d0000>; Mon, 23 Feb 2026 11:13:49 +1300
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Mon, 23 Feb 2026 11:13:48 +1300
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1748.039; Mon, 23 Feb 2026 11:13:48 +1300
From: Ronan Dalton <Ronan.Dalton@alliedtelesis.co.nz>
To: "marek.vasut@mailbox.org" <marek.vasut@mailbox.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH] usb: Fix USB read configuration error on some devices
Thread-Topic: [PATCH] usb: Fix USB read configuration error on some devices
Thread-Index: AQHcoiQSuGyGCqWzE0ybxFJ4VBL9WbWLSLyAgAMqE4A=
Date: Sun, 22 Feb 2026 22:13:48 +0000
Message-ID: <4550f320c271db50ff8af455244eadad0f435099.camel@alliedtelesis.co.nz>
References: <20260220044709.1065540-1-ronan.dalton@alliedtelesis.co.nz>
 <c9179461-cc40-49b6-ab10-086f4e5c1eda@mailbox.org>
In-Reply-To: <c9179461-cc40-49b6-ab10-086f4e5c1eda@mailbox.org>
Accept-Language: en-US, en-NZ
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.33.12.18]
Content-Type: text/plain; charset="utf-8"
Content-ID: <9AF706E033F7DE44B88F4C3994C0837E@alliedtelesis.co.nz>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=d/NWygjE c=1 sm=1 tr=0 ts=699b7f9d
 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=BhaoXNk7gXQA:10
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=7M42kAREPRnyh_Ny8zgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
X-Mailman-Approved-At: Mon, 23 Feb 2026 00:26:29 +0100
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

T24gRnJpLCAyMDI2LTAyLTIwIGF0IDIyOjU0ICswMTAwLCBNYXJlayBWYXN1dCB3cm90ZToNCj4g
DQo+IERvZXMgdGhlIGZvbGxvd2luZyBhbHNvIG1ha2UgdGhlIFVTQiBzdGljayB3b3JrID8NCj4g
DQo+ID0+IHNldGVudiB1c2JfcGdvb2RfZGVsYXkgMjAwMA0KPiA9PiB1c2IgcmVzZXQNCj4gDQo+
ID8NCg0KSXQgZG9lcyBub3QuDQo=
