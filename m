Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D1E9CD5BB1
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 15:23:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 026A5848DC;
	Mon, 25 May 2026 17:23:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VsQ+Ggcr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C78A6848DC; Mon, 25 May 2026 17:23:01 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4EF8848D2
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 17:22:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7e582b3bcaaso8276270a34.3
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 08:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779722577; x=1780327377; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Fhjfakf377FVQRlxUFm6yuCMI2w5F5dPakWrMnv2hXs=;
 b=VsQ+GgcrV7K97W6kIcliLxbmWkUy4NCgc4XT/495v+3qYVKRFROH3nerepB00QU3Xr
 q3RarB8JsNf440FFck0+5KEVgPuK9I4XMb8JPn3F4TS0XTYv9CfaTfOcRult2JVw63Rw
 6FdRO4FkaZVGjY7KVKj3/ckdKUl0rqjhOK6hQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779722577; x=1780327377;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fhjfakf377FVQRlxUFm6yuCMI2w5F5dPakWrMnv2hXs=;
 b=jCTCe7BLa05fpBA9TJb/OGGTtMfhQ765L/C73j0XuwXoPFbScs7K7T3P10flhMO6Kn
 xO+P5XFkztl4viHgq03GhYP55gAu77ThxtHytPGVuGtGhuM2OHKlxg0qs97qqG3P8iEj
 SydWKh8j7BJ6+4ExVql1aONDslQmz9na+S5o3BjcgTYaWVEFM82HI6e6wKAVEq6c5ANh
 iDnhid2Htc4H8E/CtG3bVgoOa/FH9W1MnmNU08o2b7qSJtaedV92RfIMYabKTIq6C8p/
 9NsKhyg9JoFERpHlkoAJCqhY9M0CwbxwaZK9kBvaIE5tF1+dGm47xXOhqTEKfbXAiGUr
 Mw2w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/xfo5BMOckVpTu+qJ43UYckPzbMuoThR4HCyUqby7CmDxjHMOb63XmAADvo5TXTnHjZ+3Ohzk=@lists.denx.de
X-Gm-Message-State: AOJu0YyQR9u3SKkE/0Ia9CRlHpA49Udjen75qaiJKyfAmuKVA4/mOg8b
 zz6PRQ3RSxFSfn51XC2npw5MMzpYdvtpYWrjwgrUverAfvFZ4m70LXT4N7p5EJ7m0oHEjGHzGSW
 q6kXIjgo=
X-Gm-Gg: Acq92OESXp+m3suoaS1nabAn1bkz/HnRmUcnMKwMcbrNgRngJAQNx0621xYaZ/GSws2
 gVQ9sWzO20Hk0trY5jXgCNpA3VreKvaP7oYiSCGOsyiTppbpTKGMbxenIT4QMknW2AcY4TUcJGK
 hdjM4J7isCzuMuSpR4yVchV3ADV5B3cP0DAZl0wlxmMltquITUSv9/lnwhv6KBslfi8lISUfnuB
 sgpkZDm/qp6dpWY+/SMl6G8QS0MVRWoIjSU1JDcasA0ex9+GrCHsf4Ic747udc+4kPcf5TlOwgb
 zPaFm8j8jyKECjvnn2L13u2JPSf/wlgNLk5ptZuEG0gUxxa2gU6kEc/A6G4DhESVi40b4Vbov95
 Pufm8hQp00GjILq/9CQ+BfQ9kFvu5EsMPRoAs2hfEpj9R0js0Xf0qlmCpwq0W7XNLGRC/a/FiRj
 /5yla83+Cfd7fnk6LEQuJerie4m3Ij+jg3eXVveD8Wo+Owz607Vn3bxuYYkhhh4PCy3M++cjgHP
 VnmGs8llceG0RGpfxnExN6uvp0i3A6TTM3EY/5eQi7KKF4kNvm2HK7/
X-Received: by 2002:a05:6830:909:b0:7d7:b841:c6dd with SMTP id
 46e09a7af769-7e5fedc5f5bmr9972619a34.11.1779722577497; 
 Mon, 25 May 2026 08:22:57 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-235.totalplay.net.
 [187.191.8.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e60645a84dsm7223775a34.2.2026.05.25.08.22.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 08:22:56 -0700 (PDT)
Date: Mon, 25 May 2026 09:22:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: ravi@prevas.dk, u-boot@lists.denx.de
Subject: Re: [RFC PATCH 2/9] linker_lists: Do not set "unused" attribute
Message-ID: <20260525152254.GM1858239@bill-the-cat>
References: <20260522212756.3169222-1-ravi@prevas.dk>
 <20260522212756.3169222-3-ravi@prevas.dk>
 <CAFLszTgmEKG7+8RJnXbdfy67pJ3U8u15-NcmT2Y1K2L5uSt+8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kZy7KLggZyWQCyp7"
Content-Disposition: inline
In-Reply-To: <CAFLszTgmEKG7+8RJnXbdfy67pJ3U8u15-NcmT2Y1K2L5uSt+8g@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--kZy7KLggZyWQCyp7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 25, 2026 at 09:02:02AM -0600, Simon Glass wrote:
> Hi,
>=20
> On 2026-05-22T21:27:48, Rasmus Villemoes <ravi@prevas.dk> wrote:
> > linker_lists: Do not set 'unused' attribute
> >
> > Whenever we declare something to be in a linker list, we want it to be
> > included. This is why all of our linker scripts have a line similar to:
> >         KEEP(*(SORT(__u_boot_list*)));
> > to ensure that any linker list found in any of the archives we are
> > linking together makes it to the final object. Remove the places where
> > we set an attribute saying that it is unused, or maybe_unused.
> >
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
> >
> > include/linker_lists.h | 9 +++------
> >  1 file changed, 3 insertions(+), 6 deletions(-)
>=20
> > diff --git a/include/linker_lists.h b/include/linker_lists.h
> > @@ -69,7 +69,6 @@
> >  */
> >  #define ll_entry_declare(_type, _name, _list)                         =
       \
> >       _type _u_boot_list_2_##_list##_2_##_name __aligned(4)           \
> > -                     __attribute__((unused))                         \
> >                       __section('__u_boot_list_2_'#_list'_2_'#_name)
>=20
> The commit message conflates two unrelated things:
> __attribute__((unused)) and __maybe_unused are purely warning
> suppressions; they do not affect whether the symbol is emitted, kept
> by the linker, or seen by LTO. The thing that prevents removal is
> __used (and at the linker stage, KEEP()).
>=20
> The real reason removal is safe is that none of these declarations
> would have warned anyway - ll_entry_declare()/ll_entry_declare_list()
> produce non-static externals (no -Wunused-variable for those),
> ll_entry_start()/ll_entry_end() take the address of start[]/end[]
> inside the same statement expression, and the symbols from
> ll_start_decl()/ll_end_decl() are referenced by the caller (cmd_ut.c
> is currently the only one). Please reword the commit message along
> those lines; the KEEP() stuff belongs more naturally with patch 3.

I don't think your analysis is correct. They are not unrelated things,
they're very much related and were really incorrect at introduction a
decade+ ago (and pre LTO) but I don't think it was worth adding a Fixes
tag.

--=20
Tom

--kZy7KLggZyWQCyp7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCahRpSgAKCRAr4qD1Cr/k
Cg0iAPoDCtRJKXaoBO2E0T5g2cHseOc3V4DRZEhAONSiiSACFgEAnYLT0Wk4Rt2N
VT2Wgn0+I8x1ml1I3ACUH5DVrUR5YQY=
=TaGx
-----END PGP SIGNATURE-----

--kZy7KLggZyWQCyp7--
