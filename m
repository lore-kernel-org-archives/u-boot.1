Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A976CA5FFF
	for <u-boot@archiver.kernel.org>; Wed,  7 Oct 2026 21:16:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7184B8127A;
	Wed,  7 Oct 2026 21:16:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3YVDLHBKcz-u; Wed,  7 Oct 2026 21:16:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B00ED81274
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791407801;
	b=HwY2bEvEYSKVzkdxaw4aRv6Ip2rNdhndoTqwYWDrIZxFgX01+xA51Cf01pMD0VJ/awK5
	 S/N3vIyUPGNEZdVFou5NjXF2Lk2QF7WnWiU+rJlgf4GMiln71b3Ru0sg9kTU8udNjxAZ2
	 sce5k7XQT3GivBd5RwF5DThLEGA7cZFzj6tgwHvAO3R3mESetsOqYJLjWHzywWjiSJ6d6
	 5QmIFpf1AXPZ8ETE4qXPYsOuLnNBrfvNdaI22sVsd4ihO36qA1BlhXEE1Lu0ZmOWVlOtP
	 g18Zir4z5BNAq+/6nTqqA6L2zz23e85ZwYHdZQhkikXVfBHNt+lx+xveGnowvHouzUA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791407801;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Ogl6B12WXj6SAX7NC/LFQ4jcPfKpuuidG1HJVpNErPY=;
	b=TOZxcSMgyUHP81rUs9D5nyEGfdSIijh/oDMfRUbg9iGM75tdu1EfcO16DGxFbifINH8P
	 H+X4b/cnSGRuHgYpr3EkteeeijK7gKL4KqtsZ5fz7DiAmzQ6u4/RNjjpzSEqsbfbuar5l
	 dzt7NFyog/iNU384tkX6wJ43qvws8Y7RE0zGTXN2VmI6nU/LnGem4pCw1eXCYnF4QIzNe
	 pWlVFy2tOkF167Vi7OFl0ejjJqSjdnvPmlJ4hcirlh978elQusT+GylYhTChgLYuu0LZI
	 v1VU7qQCyMvNoeYyM2xeFhRrZaxDBw+Wt4X+yz3z5gARkP58m43Tt4aHPaBDQtyXipA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791407801;
	bh=Ogl6B12WXj6SAX7NC/LFQ4jcPfKpuuidG1HJVpNErPY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0/ryp53oJHAtrO9c1AQ1fampm62wVg7hR4lORzJtZQbVi38luZhmx3RpAB90azHAl
	 cyiJ4Un4TTJoG1Le1JSx7MIvSgNMlUl5eYWLFRqhATfJIYqkBGQjWKP/+zAz50hA5f
	 1DR4YPwGxqUSndqhygWGk0WQ3NlKE+ukUNfPS+B4cRs+tJ0sJTOIMz9DeZjtjKqgbP
	 MOcbuoQcoVDZ6KEeWtuZ4nM26IgCpcMmLV3PGrRh4yn+DjJFKSjqU1QjyNrbbtKev6
	 VFdCJ2IUxiagytWiKereIRrrTuCe822iRNUKlaf5nO077EI8v1jTAwqZ//y2SHj7t3
	 cJTbkOFf61Ztg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B00ED81274;
	Wed,  7 Oct 2026 21:16:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id AF14675
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 19:59:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A0ADC60887
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 19:59:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KnpKBvHNGU56 for <u-boot@lists.u-boot-project.org>;
 Wed,  7 Oct 2026 19:59:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 885196087F
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c29"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791403195;
 b=WX/IcmxrHNV7BNaVUsCgzIH4w+T0eCqqyoOIvat43nNAKVBGYuO8OUMgkCP6VTTLvX58
 zwkqzsujoiF6vzOlrGrlOnyZIXI1Ze+j3PcNU4P+2oDgQNUCzf192+Ht6uruW3kf4CRyK
 YPOek288b3YCBMPkPWt/BoOhSBxWP5gTGkv7dF4Yu4oWgNMW7exRkc9tHaVY1BKMCqhm9
 NIOOoAYQyiPbhCa1ylCz8TUipPohwtv3duzFzjNVPVV5uipKdVwfSxft4B0UgKZEv/xqC
 2sT1MhanWe3Nk28dIaqEBVwlOEObLEMBe44fVtjM003SOYjhsJvSIDs0ilxryGTb2ig==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791403195;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=Ogl6B12WXj6SAX7NC/LFQ4jcPfKpuuidG1HJVpNErPY=;
 b=aKIFtyFbBQjSMonwIihdGZVGOULN+OrwIWnw2oQRLrO2EbGoPxApqlQxow+Y9Et7/QdM
 WdlEVyijlf8QxOTk7cYF6Ng2iin3VBkGUzgxPugSTvLBWH+Tqjo7qF+GA+r3R4VOfOR5H
 1PiKiiWxnzytjTTgqzYC/MVgL2NkZvGp7aNrGMWPECXh82oW+wKBpGkCeuYMlfMIm2GSs
 23qEP2KVRkQxtngHv4bbyVGDe4eD1zdZyaZoElF/uTx4NNnhZbWgD1fPDhXim2p6nWO08
 f+VMC/Rhi1v+D2ANZVp7GViigb4EkHngpRv19hiFrBoZ4btN1RxGmQI/xvx3ROJDxaA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=HRZFf2DX; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c29"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c29; helo=mail-oo1-xc29.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=HRZFf2DX
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 885196087F
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 19:59:55 +0000 (UTC)
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-6de1ca1b05aso1518904eaf.0
 for <u-boot@lists.u-boot-project.org>; Wed, 07 Oct 2026 12:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1791403194; x=1792007994;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ogl6B12WXj6SAX7NC/LFQ4jcPfKpuuidG1HJVpNErPY=;
 b=HRZFf2DX7PnSZAv1H9ZM49IRdipy+wfZCZQvBukIROcdf8HK4vdUx75CnD2DJS78W5
 yGMdlo0BQurSz9Q1BuFYlwyYvJoUR9ts3orBwbn0vdyll2Vy9ZeN4NXw4O4UaOP3+kUM
 6KTynckaHNAA4OLkU/NlOJlYwUAkRBKTRTlao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791403194; x=1792007994;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ogl6B12WXj6SAX7NC/LFQ4jcPfKpuuidG1HJVpNErPY=;
 b=iEOUKfdwQcgf0+OE2A63vSZmbLXbIQjGd8Vow75leUKLca6DQgjNjOFe1ql97Q8OPZ
 1qjlQL28WNkYp430k6AqVVa+wLaV1KnBd4uHD6boXAd28PwfaAs4T3eOgoun8Ak3hofE
 VEIiY0MvIo13g4crDxq5WrueDxtp/zVXdzSrmjH1sAbt7LPEC7vbOmsQsnBgFFWDJrkq
 3qeEEWF9DYNJEA9l+48EEa/EfUONN4bgqvFHsbr++5zV9RqCP4xI6isbiFz6M7OQbSr9
 WCsP2FquiYNkkiTlwETJtQsk23Pf/7lH9UN276/wZmXKttYCXXEBQs/jbV4gFM9M8AnB
 XEFA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwAwbqYXtnCvYDg5o7PKZfpr+Gn/A3anGTcsAR1j4rP7DCUipHs5dhMYmJY3azNgHzGhzdnweA=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lbDItKN4HQKFlmK6y/snXan2MMQrSq+KejMLT7ofcJo+mTRMXt
 8WmUhyn+hHDuzj2pPl+SV6HuyVN6BIpQkiOw1OPGxnsa2QSzFi44pyo7mK5QqRTdrQGbdbv0sAM
 va4j11MWlyz0K
X-Gm-Gg: AYBFou1v9/7+cbDu4xK6SvcmJsG1AMieE+XO7keNuWJwd5PvxURzzz/8lCKHYicDqYV
 tEIFK28tYdtltKumGEvaVQOPco1mj47+e8D4/Gqs++6WsZf1yIC+qQav41grt9Ud/7o9l8+lU7P
 WhFBDAUhsBXobvAeIfyRHaNYxkzZddbYvcFzXELfNlaf9ta/Y5w6nPGzFA+9oNAxkbrg0iDxxKd
 R1XNhLeM0L7VLWhv1Vq0hKgVJrj5rMFH4rFzAuL3x0jFG3uto3802s6iIQCyLFfl6sis/p/0hrJ
 Dprr8bnQUma/OYfKpTf0Z1RSDLBBYg91O2OtItFT1cypQmnyKj1AiG2D+z/Q4jYc3S8DgAUlLzK
 B6J3ye9+MFrPMPTsIzrrhIH1Ydl4Ize5kjRy13Qszx8uP+KVa0zwHVCtxS49B/Sy7dRoPaEYmZG
 qZZRfw0GwxlEK1aFsdtKjEft+ek8tbPp5adFFZ4cLfkJU5Tztcjc8FxbN1RdCvHuEt/vUr6w9H9
 IwAaJ041xVu66QQRhKgFI+NlIRcJwk2hoKUtoSQNQ8Ki7bLc3GUw6og3Tbo1ehBKAnCAb58236v
 0PossgowuNbR3BE2sa8=
X-Received: by 2002:a05:6820:c8e:b0:6c1:a5a7:ab0b with SMTP id
 006d021491bc7-6e7a4c25b8amr3192903eaf.10.1791403194145; 
 Wed, 07 Oct 2026 12:59:54 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-82ad9eeb5eesm3684297a34.2.2026.10.07.12.59.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 12:59:53 -0700 (PDT)
Date: Wed, 7 Oct 2026 13:59:51 -0600
From: Tom Rini <trini@konsulko.com>
To: tuomas.tynkkynen@iki.fi, bmeng.cn@gmail.com, sjg@chromium.org,
 jerome.forissier@arm.com, Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, marscheng@google.com,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v3 0/6] fs: Add 9P filesystem support over virtio
Message-ID: <20261007195951.GE3079290@bill-the-cat>
References: <20260923213002.1070404-1-visitorckw@gmail.com>
 <179139852309.3398671.7231524378185570223.b4-ty@konsulko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pR9O9RIrz0iBJxhv"
Content-Disposition: inline
In-Reply-To: <179139852309.3398671.7231524378185570223.b4-ty@konsulko.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--pR9O9RIrz0iBJxhv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 07, 2026 at 12:42:03PM -0600, Tom Rini wrote:
> On Wed, 23 Sep 2026 21:29:56 +0000, Kuan-Wei Chiu wrote:
>=20
> > Add 9P network filesystem support to U-Boot.
> >=20
> > It allows U-Boot to directly mount host directories in virtualization
> > environments via virtio. This is useful for loading kernel and
> > initramfs images directly from the host into the VM during development
> > and testing without having to rebuild disk images or set up a TFTP
> > server.
> >=20
> > [...]
>=20
> Applied to u-boot/main, thanks!
>=20
> [1/6] net: 9p: Add 9P2000.L protocol support
>       commit: 48bb83195682d189273bdba813fa67f7f2760d59
> [2/6] fs: 9p: Add 9P filesystem support
>       commit: 9e14f904f8f12cd9df07e99a679453c8782e523b
> [3/6] virtio: 9p: Add 9P transport driver
>       commit: 09e668e32b4c14ce5c929d6cebfac75d2aefb90d
> [4/6] doc: 9p: Add 9P filesystem documentation
>       commit: 7d963df1bc38f5ae070ea8b96e03afc1ef7e23ed
> [5/6] test: 9p: Add test for 9P filesystem
>       commit: d446ef40b87d53ef7ac59ac9b1d79a16f0a065b0
> [6/6] MAINTAINERS: Add entry for 9PFS
>       commit: f6002d5e8018714ca80dcf1835c230c99c5090b3

Are there special permissions required for 9p to run? This works in
Gitlab, but in Azure:
test/py/tests/test_9p.py:46: in test_fs_9p
    assert test_file_name in output
E   assert '9p_test_small.txt' in "9P Error: No matching 9P transport devic=
e found for '-'"

--=20
Tom

--pR9O9RIrz0iBJxhv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCasakswAKCRAr4qD1Cr/k
Cu6qAP0T++bIoVdeWee7suNHCfMTpxPebpEEatGs/iww838srwEAuqauLFQrk0vT
74JUjEba49N6jXZA3/kjEJAb/c6CQAM=
=ZNbC
-----END PGP SIGNATURE-----

--pR9O9RIrz0iBJxhv--
