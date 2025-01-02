Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0775E7718B
	for <u-boot@archiver.kernel.org>; Thu,  2 Jan 2025 16:27:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F792803C6;
	Thu,  2 Jan 2025 17:27:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=protonmail.com header.i=@protonmail.com header.b="TuRYvJhw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E060380196; Thu,  2 Jan 2025 14:28:29 +0100 (CET)
Received: from mail-43166.protonmail.ch (mail-43166.protonmail.ch
 [185.70.43.166])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F1C880040
 for <u-boot@lists.denx.de>; Thu,  2 Jan 2025 14:28:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=waldoalvarez@protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1735824506; x=1736083706;
 bh=0cUIoakJ7YvjxaoXrq2YFFVWA7VeA34n0X5o7On0Nsk=;
 h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
 List-Unsubscribe:List-Unsubscribe-Post;
 b=TuRYvJhwmjGOqw0obQPAkOEw6JNLmMoo+evfYZ53YZ11PXbm8Y+D6WjbJlcSK39ac
 bB/F8d+Ua0eQ0GkOjZdIchHLqx0eaYQDKJ1tpE9iVeTUHxw/ESLPadM6+2HQy0oglh
 mRKnMBUmZbGodv6QWMqhC7QYvfJ7i7O7B4kZ8s4sdOZL1pJJ3PdeRWpwnB3zbboofc
 y8a5M9QGP3j0B8MreEVkSDzWBGY9DQ9eJqFcT1AN5CCjmzZDuTERpjWEEsgWlpXxxl
 x9SNHsiXpq+MGZdrYaNBz6BNgE6HxPSHpUVqjx+8mdsQlbR3hOElFRCfSS5MhXqnj6
 C3g4Duo+UKZuA==
Date: Thu, 02 Jan 2025 13:28:22 +0000
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
From: Waldo Alvarez <waldoalvarez@protonmail.com>
Subject: Secure boot on Milk V duo 256
Message-ID: <9gGp0Bj5BodfZFh9cs_TfmuEpCjka0pg9zw_0jHrGSgVaMRQWbjoI7rDHQ4tYsa3IIzqC3gYozVRk5s_wdiCTp5IuAb7A1wccavJbQxuLAI=@protonmail.com>
Feedback-ID: 1984973:user:proton
X-Pm-Message-ID: daa8d179a4a3495f63ce2aee0645d1c8ae31a167
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 02 Jan 2025 17:27:20 +0100
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

SGVsbG86CgpJIGFtIGZpZ3VyaW5nIG91dCBob3cgdG8gcHJvY2VlZCBvbiBzZWN1cmUgYm9vdGlu
ZyB0aGUgTWlsayBWIERVTyAyNTYuIExpa2VseSBpbiB0aGlzIGxpc3QgSSBjYW4gZ2V0IHNvbWUg
aGVscC4gSXQgaXMgQVJNL1Jpc2MtViBib2FyZCB3aXRoIGFuIFNHMjAwMiBTT0MuIFRoZSBTT0Mg
aGFzIE9UUCBtZW1vcnkgYW5kIHNvbWUgYm9vdHJvbS4KClRoZSBjdXJyZW50IGRpc3RyaWJ1dGlv
biB1c2VzIHUtYm9vdCBhbmQgbGludXggYnVpbGRyb290IGJ1dCBkb2Vzbid0IGRvIHNlY3VyZSBi
b290LgoKVGhlcmVmb3JlIEkgYW0gdHJ5aW5nIHRvIHN0YXJ0IGF0IHRoZSBmaXJzdCBwYXJ0LiBW
ZXJpZnkgZGlnaXRhbCBkaWduYXR1cmUgb2YgdS1ib290IGFuZCBoYXZlIHUtYm9vdCB2ZXJpZnkg
ZGlnaXRhbCBzaWduYXR1cmUgb2YgdGhlIGtlcm5lbC4KCkNhbiBzb21lb25lIHBvaW50IG1lIGhl
cmUgaW4gdGhlIHJpZ2h0IGRpcmVjdGlvbiBubyBob3cgdG8gcHJvY2VlZC4KClJlZ2FyZHMKCldh
bGRvIEFsdmFyZXoKRGVzYXJyb2xsbyBkZSBTb2Z0d2FyZSAvIFNvZnR3YXJlIERldmVsb3BtZW50
Cmh0dHBzOi8vcGlwZmxvdy5jb20KaHR0cHM6Ly90cmFkaW5nZnV0dXJvLmNvbQoKU2VudCB3aXRo
IFtQcm90b24gTWFpbF0oaHR0cHM6Ly9wcm90b24ubWUvbWFpbC9ob21lKSBzZWN1cmUgZW1haWwu
