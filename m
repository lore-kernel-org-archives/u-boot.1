Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9C0AC43458
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 13:00:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6B2084AA6;
	Fri,  3 Jul 2026 14:59:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=proton.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=proton.me header.i=@proton.me header.b="jx9QsKhe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC64F84979; Fri,  3 Jul 2026 13:42:54 +0200 (CEST)
Received: from mail-4325.protonmail.ch (mail-4325.protonmail.ch [185.70.43.25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 532858469D
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 13:42:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=r00tnomade@proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1783078971; x=1783338171;
 bh=UtfisIaAd0/Ms9W2AxEJyETtT2wVtYn6FEsu/OhuiDU=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=jx9QsKheg/OoCm1A9lCac95G54/OwFJB50pb5hl3sICyZFzZOqYMppcj6hMu+PJiH
 fpBaTUwU90m9iCDWFRHXOM7JmSz74bGUtu13MSB8FH4iW9LxqU1mTYf6VWPMhwByk6
 vdA7lhgT3uYfagHF96hO5GgT2AUVGDBLjdewyA1mgj3+OTyidMiCmDD8bVBf9Ruvy0
 D3Je4gLnYNieBEjDwMA57Irg2D/Q2PXZE5H1cyGWeuLNHwRF+L9F9FUKTNvELhf6sy
 EPigRucooUE7eJ2lR0CX3XCNJAEPWJStt2uq7SO2zT/mMhft0E73p9Juu0LYKbFksx
 T6pAsi6oshrMQ==
Date: Fri, 03 Jul 2026 11:42:47 +0000
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
From: r00tnomade <r00tnomade@proton.me>
Cc: "trini@konsulko.com" <trini@konsulko.com>,
 "alchark@flipper.net" <alchark@flipper.net>
Subject: [PATCH] spi: handle spi-rx/tx-bus-width = 0 (no RX/TX line)
Message-ID: <mwb-8utqeprHrcyYlJKRzVpdMfI457MmWgwqLdkvc5fFiSE43Y9wiz594Nzt2CRn4jUIZmc6F-KzD2pQuixCwkT2KPkZ_NajlkW8vEsCOrQ=@proton.me>
Feedback-ID: 197191651:user:proton
X-Pm-Message-ID: 25baf18822511a036ecc3c08561561a87a768d79
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 03 Jul 2026 14:59:42 +0200
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

SGV5IHRlYW0sCgpJIGp1c3QgcHV0IHRvZ2V0aGVyIGEgcGF0Y2ggdG8gZml4IHRoYXQgYW5ub3lp
bmcgInNwaS1yeC1idXMtd2lkdGggMCBub3Qgc3VwcG9ydGVkIiB3YXJuaW5nIHdlIGtlZXAgc2Vl
aW5nIG9uIGV2ZXJ5IGJvb3QgZm9yIHRoZSBGbGlwcGVyIE9uZS4KClR1cm5zIG91dCB0aGUgRGV2
aWNlIFRyZWUgYmluZGluZyBleHBsaWNpdGx5IHNheXMgYSB2YWx1ZSBvZiAwIG1lYW5zIHRoZSBs
aW5lIGlzbid0IHdpcmVkIHVwIChsaWtlIGEgd3JpdGUtb25seSBkaXNwbGF5IHdpdGggTUlTTyBs
ZWZ0IGRpc2Nvbm5lY3RlZCkuIEhvd2V2ZXIsIHNwaV9jaGlsZF9wb3N0X2JpbmQoKSB3YXMgb25s
eSBsb29raW5nIGZvciAxLCAyLCA0LCBvciA4LCBzbyBpdCB0aHJldyBhIHdhcm5pbmcgZXZlbiB0
aG91Z2ggb3VyIERUIGlzIGNvbXBsZXRlbHkgY29ycmVjdC4KCldoYXQgSSBjaGFuZ2VkOgoKLQoK
QWRkZWQgdGhlIFNQSV9OT19SWCBhbmQgU1BJX05PX1RYIGZsYWdzIHRvIGluY2x1ZGUvc3BpLmgg
KG1hdGNoaW5nIExpbnV4J3MgbmFtaW5nIGNvbnZlbnRpb24pLgoKLQoKSGFuZGxlZCB0aGUgMCBj
YXNlIGV4cGxpY2l0bHkgaW4gZHJpdmVycy9zcGkvc3BpLXVjbGFzcy5jIHNvIGl0IGFwcGxpZXMg
dGhvc2UgZmxhZ3MgaW5zdGVhZCBvZiB0cmlnZ2VyaW5nIHRoZSB3YXJuaW5nLgoKVGhpcyBzaG91
bGQgZmluYWxseSBjbGVhciB1cCB0aGUgYm9vdCBsb2dzIGFuZCBjbG9zZSBvdXQgaXNzdWUgIzMz
LiBMZXQgbWUga25vdyBpZiBpdCBsb29rcyBnb29kIHRvIG1lcmdlIQoKQmVzdCwKClNhbWk=
