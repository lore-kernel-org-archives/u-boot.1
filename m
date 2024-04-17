Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5497AC4345F
	for <u-boot@archiver.kernel.org>; Wed, 17 Apr 2024 00:08:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC4A088431;
	Wed, 17 Apr 2024 02:08:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="e01Mrs9K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEDEA8842B; Wed, 17 Apr 2024 02:08:04 +0200 (CEST)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 932868842A
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 02:08:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-6157c30fbc9so49863787b3.0
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 17:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1713312480; x=1713917280; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XmDNjL8NuCN9n5xd8Qok+emkMfJ41c7IlpLjMefp1b8=;
 b=e01Mrs9Kwylg4JppSdGUqc0pr3CrGafp7dcfWjKcGXhCurU+i0Tzox0SQLqoAvPqhs
 lK9NIOadey0l69/f3Fg4gB6zTW0p3QdO3cqDxCH+cu0aem9l9swWSyk61RmQYfAbIs8a
 2eBSytEe0zW6Tp/WYsK0WEGe2HNBVwaeTjuZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713312480; x=1713917280;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XmDNjL8NuCN9n5xd8Qok+emkMfJ41c7IlpLjMefp1b8=;
 b=Hl+JOK5YUVFyfOSXsYxLBowqqX+V+OM4AxA1hmY2kTL6zk2cxc+jwXEg9gaP1y0OKG
 XIDUlEhT55FVyz70PYKZAsCdKA8Q4eq9MmVhnYvWcngyCBw9upcI2FkUWVFX1vTcykaS
 DSMYi2+v3aqJzMqg+fGB/Qpm72Kr8EUG3mpCr4ViTOtzjRlEIr1UztSGUkQQ+XuUUX5A
 M1Izslhv+JIuMCL2w0MoTLdke9eld5rMmrgDRWOBODlm8WbMAWzf0N3cuRaVEPiSaeuT
 EXF6YUARhLPMMkYQJCW/kN3ibM9Wbf8NoDAt7Cu+no3v8YiNu78J+LSR1Wt2pIhjrbbM
 JZWw==
X-Gm-Message-State: AOJu0YyrcFNqiqLasL3m6VwApA93eCRDP2OX2Tge5TIIN6LZ1SQTvtlj
 5RKCep02bIh4l6Pwky8FZC7Q7kpprD1kd3s/xZFdBg5nh3Bo09dpq4V+qn5+Rm8=
X-Google-Smtp-Source: AGHT+IFyHRbtkALgLhbo8xc0zWDWYBJYYIxefXXQccNKwtzzWG3ZdMqFR+WF9Mei7nb7rBkCOCYZQg==
X-Received: by 2002:a05:690c:6011:b0:61a:cde6:6542 with SMTP id
 hf17-20020a05690c601100b0061acde66542mr8633559ywb.16.1713312480333; 
 Tue, 16 Apr 2024 17:08:00 -0700 (PDT)
Received: from bill-the-cat ([187.144.73.35]) by smtp.gmail.com with ESMTPSA id
 u8-20020a05620a022800b0078ec71866f7sm7177498qkm.58.2024.04.16.17.07.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Apr 2024 17:07:59 -0700 (PDT)
Date: Tue, 16 Apr 2024 18:07:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, xypron.glpk@gmx.de
Subject: Re: [PATCH 00/23] [RFC] Integrate MbedTLS v3.6 LTS with U-Boot
Message-ID: <20240417000756.GC1054907@bill-the-cat>
References: <20240416190019.81016-1-raymond.mao@linaro.org>
 <20240416230133.GZ1054907@bill-the-cat>
 <CAEfUkUKFG4pVR3nHw-GM1Ub2SShnSDgA+zhwTNHY+pSkuaHvXg@mail.gmail.com>
 <20240416235020.GB1054907@bill-the-cat>
 <CAEfUkU+PJN6e1JEcnpkYZtBraw6KUxr9Dq2v08EDCk9O3STkdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="eYA4BpoP0SuxJ+Vu"
Content-Disposition: inline
In-Reply-To: <CAEfUkU+PJN6e1JEcnpkYZtBraw6KUxr9Dq2v08EDCk9O3STkdw@mail.gmail.com>
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


--eYA4BpoP0SuxJ+Vu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 08:03:34PM -0400, Raymond Mao wrote:
> Hi Tom,
>=20
> On Tue, 16 Apr 2024 at 19:50, Tom Rini <trini@konsulko.com> wrote:
>=20
> > On Tue, Apr 16, 2024 at 07:47:44PM -0400, Raymond Mao wrote:
> > > Hi Tom,
> > >
> > > On Tue, 16 Apr 2024 at 19:12, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > > On Tue, Apr 16, 2024 at 11:59:56AM -0700, Raymond Mao wrote:
> > > >
> > > > [snip]
> > > > > [1]: bloat-o-meter output between disabling/enabling MbedTLS
> > > > > ```
> > > > > add/remove: 231/69 grow/shrink: 12/5 up/down: 60196/-11166 (49030)
> > > >
> > > > I don't know if this is qemu_arm64 or sandbox.  With buildman's size
> > > > comparison functions we see:
> > > >             qemu_arm64     : all +75537 bss -88 data +24 rodata +63=
49
> > text
> > > > +69252
> > > >                u-boot: add: 274/-12, grow: 12/-4 bytes: 72002/-3800
> > (68202)
> > > > ...
> > > >             sandbox        : all +57008 bss +32 data +1632 rodata +=
352
> > > > text +54992
> > > >                u-boot: add: 143/-75, grow: 21/-18 bytes: 64058/-165=
23
> > > > (47535)
> > > >
> > > > So please look in to using buildman to get more details about what's
> > > > changing, size-wise. Also, my goodness, that's far too much growth,=
 and
> > > > we aren't removing anything? This needs to be a whole switch, not j=
ust
> > > > an addition. And then look in to what we can tweak / remove. Are we
> > > > perhaps not getting our usual link time garbage collection done?
> > > >
> > > As stated in the cover letter, with this patch set, we still build the
> > > original libs
> > > (lib/rsa, lib/asn1_decoder.c, lib/crypto/rsa_helper.c, lib/md5.c,
> > > lib/sha1.c,
> > > lib/sha256.c, lib/sha512.c) for the components outside of EFI loader.
> > > Eventually all these will be completely switched and removed.
> > > But I think we should do this in a sparated patch set - It is too big=
 for
> > > one
> > > patch set.
> > > So, as the first patch set, this one will introduce MbedTLS and enabl=
e it
> > > with
> > > EFI loader, after they are merged, the next patch set will switch oth=
er
> > > components
> > > to use MbedTLS and remove the original libs.
> > > What are your thoughts?
> >
> > My thoughts are that we need to implement this as the optional
> > replacement for the existing libraries. We already have abstractions for
> > most if not all of the algorithms I believe. And we need to be able to
> > see how much size growth we get from this change because long term we
> > don't really want to have two sets of libraries for this functionality
> > (as a SW rather than HW implementation).
> >
> > I see. With this version most of the lib/crypto that are used by EFI lo=
ader
> (pkcs7, x509, public_key, mscode_parser, etc) are sharing the same
> abstractions except the ones for hash.
> I can replace them in v2, so that we can compare the final growth by
> switching
> on/off the MbedTLS build options.

If there's abstractions we need first, lets get that done as a prereq
series and then see what things are before/after. Thanks.

--=20
Tom

--eYA4BpoP0SuxJ+Vu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYfEtYACgkQFHw5/5Y0
tyz1uQwAm7IR70ZFFiUtnYTEdpUAsitroXyPhOUhqsxo/1aCoQeAJw6BguLvgh4O
2BKBDXQPf1d8ZhOt3pcHlEsFHrSPe/fKb9jn7aKm3k+/dlsBXgBcoCD/SGco7eR5
duYtVtf1wJsqbmdAvHBZWabmHlE7fL2y/rXwsFxBQFLnwyDBpUwPRMsGbEz5CZda
dWIbJsNzpvB3JrTKWIwvqqCEmk6gqEGdkco3u3MjvwXTavPpsB3vjRl/sIJnypSC
QkqWJlvIgrzoqSR6Cx07d7KTs6kwmaA6pRE25qgDHx3t9WTeDguuMuKRhwTmmLno
6u6/q7XYveWTRjsF7VrNm1BmKsMpwh6NRVzJLBbTeMRUiQWZ+GXpZosO915vjGYp
+GE+0IdUqnb0qH64WOdf0yBCndk1AEsltIj0x2NnXoPOCB9cZsuf/GobyEucPj2B
t2RtKREuH9WKKQmOy7D7lgs5F8Wl/D/13MvoU9Ns1/PDq0hMYpGFT6UIhC8oCAHm
ud5/zjTX
=/9yg
-----END PGP SIGNATURE-----

--eYA4BpoP0SuxJ+Vu--
