Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C81A6C021A1
	for <u-boot@archiver.kernel.org>; Wed, 12 Feb 2025 11:39:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD44B80BAE;
	Wed, 12 Feb 2025 12:39:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="ug6rXkFY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE21380842; Wed, 12 Feb 2025 12:39:25 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0BD080842
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 12:39:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fiona.klute@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1739360363; x=1739965163; i=fiona.klute@gmx.de;
 bh=2Y8K6c6oxV29cjt3ylhv3MyfNic9s6/pp78+1Jtcj44=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=ug6rXkFY5b9hT/k/Kg8OXxeO00dMtHH9ImaxoGGO5RThdUu9VJweh/4b5kKynSGa
 BRa+bK5S08+2jHRdtMVvcVJqUzJmIPbdz//Rj1gAzWa1rJzPgjhCHv86rZ73P5DbP
 1GKns01VVcEYu/tILI4DT82UPlV5PEBPb8ID8u731iLiVy5wXOd1DHrlryO85dzr1
 2j+RSmSVhX7e92m4k9Gqow8Rylqin5yEYWYdXOg4Y7CYz+awuIANoDNQHQgCMUZGX
 oJvVpq2J+A9mM9yOxAA1YCattIa8OIxmXleYvskEUhaD5H2s+lKOvDk+LvCWHVawU
 4936MU+oeNN/fNhBfQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from haruka.lan ([85.22.102.52]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mg6Zq-1tAVYz0Wo2-00ojsY; Wed, 12
 Feb 2025 12:39:23 +0100
From: Fiona Klute <fiona.klute@gmx.de>
To: u-boot@lists.denx.de
Cc: Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>,
 Fiona Klute <fiona.klute@gmx.de>
Subject: [PATCH 2/2] Raspberry Pi: Copy Bluetooth device address in DT
Date: Wed, 12 Feb 2025 12:39:02 +0100
Message-ID: <20250212113902.1495183-2-fiona.klute@gmx.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250212113902.1495183-1-fiona.klute@gmx.de>
References: <20250212113902.1495183-1-fiona.klute@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:ZvbSc5AC8510kGDQyEG0dsRsGkxvI4Z8cM2T0UrbAuCAzTYF3lD
 kI671dCGEC2KJD4LKDpyNOn8vXyDLfC+GDokFGN1oxqWlhn4/XUkhFUwTG95Rx96CboxroH
 MHyXmsmAeVrxTd9Ba/cm5q93ErH/nNPSR5ZzBr2M64J56LKRZSjXKAogWlxOzxBPu9I157O
 HP3IL6Z/aeXj0O2sVkB3w==
UI-OutboundReport: notjunk:1;M01:P0:g7oTxo49mr4=;oQANsYOwwPL0+25lpFRjn1FlFNn
 wLXKfo/6DdpwqjMxH4BQusZYxzD5DET0My9U4t4Ded7nj15/oyDOnttDMI3/CPNv2TPmyt54o
 iND8YjZ7w0XksX23oZo7urAtRKBeW7zFVvBwB8gKycmjcDspw7BO9A2tr0sgY5c1qkEtIrW0M
 D/sKgVHdkRNA0or7M6xnHC/UCRKYP/5NSuSnEWLBTDICmaYly+b4GtqUeNqNWXquAI5frf/FH
 EphI4IxRkzEvTZbdjyXIiedTDu0N0qnxDqLKp+8K5AikFjU5tIy1b3Sm7IVud5IsMrIl1CLHw
 F4rcEf/encJN6iUnIgnNoP7flW/80aMby3h48nSuAHFoEP3qxbGLzIB2sp3yKL8K5DZ71NWKf
 QhEaDw974Nr9yjvvKBZkJzURvbdJ/Wa1118rcQ7S9i08AANINXVseehFt6loCeWHYnDPu2P81
 8MNvfSKB3fFUAqlmURndrGYabrun/xjcTTapaOF/9Jko+e1xOqQMNVt3TRaRwQkR6AdhindWr
 NlFOXCKbBjKn12ipLgKOzFqv//T+88TZgI56nn7q+lKVE0zQcgsaDbBsjaIPDFup7E95Wijar
 vXyy7alIQunkmjspJpTWXVAQM69T9Ju7usnJOLKm6skr4QjUkdM1gSByUJEwm49wMqUTaGnGz
 I50IKKdmABv3XfkM/bnC6alGRndHAPgEYp0ntccyZ/L5yhWxz4oBg+ZGLh0tdJtG8WDC8SaSq
 gYRizxLymqVYkGiwMVROBgzpmfNYc3K6K+ktATp//KqYD4/b7veZzKsxPL408CLtBTehDHtbq
 gJtGhRoKbWF0zlbYa2neQhfk0YsSp9/laR0geHzVV1Liz76R3n+ZzGJZrAKfOiAfSyAiSBj9j
 pZBIxrkRTWcPE3jnaZ5RfHNyrtOgQWRrql7bXHJTlf9bb4lUHmzJKlDHGWE5wWP1Fu5DgRTmG
 EDXMhv77xdNzziUDvLJR2P968UJ/Ae/Hs1uh+fk5uBLk3sS4UIZvpUvXeuOBPQhFa0qCSRKfW
 12GrdeWTBo2wFiMyHYM30CuZTwuhUTZeJwWXxjYX7yLt68J4xxag4nUzVzQRGTNQ8i0F2zLMr
 wHG6Qss/EVHb8Z5vY+lMGdBHZjDIdItZGHEDNn2Xy2gcfS8/hPukPWeYTsApUKw0kUqP5qpiW
 A+9kqAQ+DKJ8+OlmFBb3kwtrGb516Ym0nngTU5YLfp73WPJTDQa2b03hfwLMZ4DC+382dTWzO
 HT1eQjXpnWwEl++HvseoD6MfcuZEEWypMH5anlTe3x4x08DL/KgIljlDSFjmciJXV357kh95y
 wGpwAkoTBSFGY0NHEyH3Q+JrTGJyqzXXcbuFrFpsdrTuyI4zBukRTaPNkFbI8Z5odidUJpOsL
 paRl+9F2X97Wl83AQpYTez+Wfvmh8bJgFRMYUxGoPmuQ8Qp87PcGw3hIJe
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

VGhlIGZpcm13YXJlIHNldHMgbG9jYWwtYmQtYWRkcmVzcywgY29weSBpdCB3aGVuIGxvYWRpbmcg
YSBuZXcgRFQuCgpTaWduZWQtb2ZmLWJ5OiBGaW9uYSBLbHV0ZSA8ZmlvbmEua2x1dGVAZ214LmRl
PgotLS0KVGhpcyBzaW1wbGUgY29weSB3b3JrcyB3aXRoIHVwc3RyZWFtIExpbnV4IERULCBhbmQg
d2l0aCB0aGUgZG93bnN0cmVhbQpSUGkgb25lIGFzIGxvbmcgYXMgQlQgaGFzIG5vdCBiZWVuIG1v
dmVkIHRvIG1pbmktVUFSVC4gVGhlIGRvd25zdHJlYW0KRFQgYWRkaXRpb25hbGx5IGRlZmluZXMg
L2FsaWFzZXMvYmx1ZXRvb3RoLCB3aGljaCBpcyB1cGRhdGVkIGJ5IHRoZQptYXRjaGluZyBvdmVy
bGF5cy4gQSBtb3JlIGdlbmVyaWMgKGJ1dCBhbHNvIG1vcmUgY29tcGxleCkgYXBwcm9hY2gKd291
bGQgYmUgdG8gKnRyeSogdXNpbmcgL2FsaWFzZXMvYmx1ZXRvb3RoLCBhbmQgZmFsbCBiYWNrIHRv
IHRoZSBmaXhlZApwYXRoIGlmIGl0J3MgdW5kZWZpbmVkLiBJZiB0aGF0J3MgcHJlZmVycmVkIEkn
bSBoYXBweSB0byB1cGRhdGUgdGhlCnBhdGNoLgoKIGJvYXJkL3Jhc3BiZXJyeXBpL3JwaS9ycGku
YyB8IDMgKysrCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEv
Ym9hcmQvcmFzcGJlcnJ5cGkvcnBpL3JwaS5jIGIvYm9hcmQvcmFzcGJlcnJ5cGkvcnBpL3JwaS5j
CmluZGV4IDZjYTdjZDc0ZWZmLi40NzY3NGIyM2JlMiAxMDA2NDQKLS0tIGEvYm9hcmQvcmFzcGJl
cnJ5cGkvcnBpL3JwaS5jCisrKyBiL2JvYXJkL3Jhc3BiZXJyeXBpL3JwaS9ycGkuYwpAQCAtNjIx
LDYgKzYyMSw5IEBAIHZvaWQgIHVwZGF0ZV9mZHRfZnJvbV9mdyh2b2lkICpmZHQsIHZvaWQgKmZ3
X2ZkdCkKIAogCS8qIGFkZHJlc3Mgb2YgdGhlIFBIWSBkZXZpY2UgYXMgcHJvdmlkZWQgYnkgdGhl
IGZpcm13YXJlICAqLwogCWNvcHlfcHJvcGVydHkoZmR0LCBmd19mZHQsICJldGhlcm5ldDAvbWRp
b0BlMTQvZXRoZXJuZXQtcGh5QDEiLCAicmVnIik7CisKKwkvKiBCbHVldG9vdGggZGV2aWNlIGFk
ZHJlc3MgYXMgcHJvdmlkZWQgYnkgdGhlIGZpcm13YXJlICovCisJY29weV9wcm9wZXJ0eShmZHQs
IGZ3X2ZkdCwgIi9zb2Mvc2VyaWFsQDdlMjAxMDAwL2JsdWV0b290aCIsICJsb2NhbC1iZC1hZGRy
ZXNzIik7CiB9CiAKIGludCBmdF9ib2FyZF9zZXR1cCh2b2lkICpibG9iLCBzdHJ1Y3QgYmRfaW5m
byAqYmQpCi0tIAoyLjQ3LjIKCg==
