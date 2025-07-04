Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC82EC83F03
	for <u-boot@archiver.kernel.org>; Fri,  4 Jul 2025 15:56:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11E3182F6A;
	Fri,  4 Jul 2025 17:56:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=philipmolloy.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=philipmolloy.com header.i=@philipmolloy.com header.b="lwpgfQwK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5595C8206E; Fri,  4 Jul 2025 17:16:17 +0200 (CEST)
Received: from mail-10625.protonmail.ch (mail-10625.protonmail.ch
 [79.135.106.25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B7C3803DF
 for <u-boot@lists.denx.de>; Fri,  4 Jul 2025 17:16:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=philipmolloy.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=analog@philipmolloy.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=philipmolloy.com;
 s=protonmail2; t=1751642174; x=1751901374;
 bh=24s7UCBBFDvrYdYcybwWnqrqSitboBLzChzXd4pJZA4=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=lwpgfQwK0GpngKLP0QLT+MJuzv5WYVl0GR8UNcIecw9ElO1dI/wvcptykFxXjR7Ym
 JOIOuFg8FSFR3pK1sJBXrMTxY+wCAJkYsC6/WNxDq3z8wOABgkdVW9Vmvo73i516VE
 HKHiz6LfJtsBu+zwlPrhSQTLsK6UnjyUlGYz/DAXe7kKcGGdIyGDNQOkkpDNfQ9EGP
 Xb3jBR3CCsDQE3mAw75rGnWiWC+c8qVGF1Ebgn65yCijCTaYbfq8YNzllQgVP4Egum
 q2vcFANECkzN0GCPByIs/UZIP1iIrT6/HICwuZ6ezz7iKva0nzGPZrrojKLYmC2iP8
 +ufAtDKhNZkXw==
Date: Fri, 04 Jul 2025 15:16:06 +0000
To: Greg Malysa <malysagreg@gmail.com>, u-boot@lists.denx.de
From: Philip Molloy <analog@philipmolloy.com>
Cc: adsp-linux@analog.com, Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>, Tom Rini <trini@konsulko.com>,
 Trevor Woerner <twoerner@gmail.com>, Philip Molloy <philip.molloy@analog.com>
Subject: Re: [PATCH 06/10] board: adi: Add support for SC589 boards
Message-ID: <4a5912804f0682836fd6697a051e6ab3f13219d3.camel@philipmolloy.com>
Feedback-ID: 149422483:user:proton
X-Pm-Message-ID: cc69e0ca9022b6a7823b0abb5cc362f056f731f2
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 04 Jul 2025 17:56:42 +0200
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

T24gTW9uLCAyMDI1LTA2LTAyIGF0IDE1OjQ0IC0wNDAwLCBHcmVnIE1hbHlzYSB3cm90ZToKCj4+
IGRpZmYgLS1naXQgYS9jb25maWdzL3NjNTg5LWV6a2l0X2RlZmNvbmZpZwo+PiBiL2NvbmZpZ3Mv
c2M1ODktZXpraXRfZGVmY29uZmlnCj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0Cj4+IGluZGV4IDAw
MDAwMDAwMDAwLi5lYjM2NDcyZDQ2NQo+PiAtLS0gL2Rldi9udWxsCj4+ICsrKyBiL2NvbmZpZ3Mv
c2M1ODktZXpraXRfZGVmY29uZmlnCj4+IEBAIC0wLDAgKzEsMTEzIEBACj4+Cj4+ICtDT05GSUdf
VVNFX0hPU1ROQU1FPXkKPj4gK0NPTkZJR19IT1NUTkFNRT0ic2M1OHgiCgpTaW5jZSB0aGUgZGVm
Y29uZmlnIGlzIGZvciB0aGUgU0M1ODkgaXQgd291bGQgYmUgbmljZSB0byBoYXZlIGEgbW9yZSBz
cGVjaWZpYyBob3N0bmFtZS4KCj4+ICtDT05GSUdfR0FURVdBWUlQPSIxOTIuMTY4LjAuMSIKPj4g
K0NPTkZJR19VU0VfSVBBRERSPXkKPj4gK0NPTkZJR19JUEFERFI9IjE5Mi4xNjguMC4xNSIKPj4g
K0NPTkZJR19VU0VfTkVUTUFTSz15Cj4+ICtDT05GSUdfTkVUTUFTSz0iMjU1LjI1NS4yNTUuMCIK
Pj4gK0NPTkZJR19VU0VfUk9PVFBBVEg9eQo+PiArQ09ORklHX1JPT1RQQVRIPSIvcm9tZnMiCj4+
ICtDT05GSUdfVVNFX1NFUlZFUklQPXkKPj4gK0NPTkZJR19TRVJWRVJJUD0iMTkyLjE2OC4wLjIi
CgpUaGUgc3RhdGljIG5ldHdvcmsgY29uZmlndXJhdGlvbiBzaG91bGQgYmUgcmVtb3ZlZC4=
