Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEE18C02194
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 23:32:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 302A480F32;
	Fri,  7 Feb 2025 00:32:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iItiIwxr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF72D80F4A; Fri,  7 Feb 2025 00:32:49 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5483380F30
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 00:32:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2166360285dso27780775ad.1
 for <u-boot@lists.denx.de>; Thu, 06 Feb 2025 15:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738884766; x=1739489566; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=H6WDK0XGgVz9laQdIn3ZI0oICVBXEwjCuOH+pPfFXUI=;
 b=iItiIwxr15tEUrC8/fHfB/6tu2nN1kPrDMlJ9BjHtCe0p2lw+CEfWA8RRUJdO173sp
 oC4bcR5zkZn3Dm+Ct7Lz5wJvjE9w8Cy6I/HJVMXeNPB7ftzZeaGE3kpJCuD/TCByF1LE
 JTsUq7UdiskjhBr9DiYKBY4qKX6Y6O5ukdOKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738884766; x=1739489566;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H6WDK0XGgVz9laQdIn3ZI0oICVBXEwjCuOH+pPfFXUI=;
 b=V0+iSGrsuwfSsRuvzclQ15EvoF6eiceI+oa8+EcaiO1Ogp//DxGWScbLUB35KQWEzB
 FjiojkfJEjEaNCAhF9+G9wixCB9BgL9ZY24zfyAdmy2x+FGBypaEudxag8E6O/9y7ebT
 clMNcbbvXZGdt771vfGHakYKYQtVZe6CzG8aNYmttS7EUW6m7h1B3S+Ub5Pryb9ZlrtL
 XiKpChTnjrMx0/ZC2vmtJeuwmcUccgurj0gSSeq7bPpi3YNggHA2jizDmqpCnJuLkc8A
 kmIOMQvcwN1UZgFy2MuaUrkbmTLbjv4vzHMu0epzt32O9Gji6LgkabQDjf/hQhKUhofU
 MSXQ==
X-Gm-Message-State: AOJu0YwYWiptzG8pU10+8P+s1q64y8jOjJtOv1E5DV0isAfC2zJV19GE
 +5eDgfriHJgDJtyZ5xGUa27X6HdpGCEIxrs3bAHrBcFX9NrZZRd9l5ethj1dVxvq8LLW5ljfm9G
 k9Qw=
X-Gm-Gg: ASbGncuC8nHEsiyJZzFki0tV+6bffNAEuwE62IYXeArD/DnA8JGWel+cGR/ws5CUCdH
 H42FrlE6sN70Q6e/ELXtYkEyet1wkWmrSRLb9L6gApEiTT5/sWPN+3ASGvStdPg3g8BpUqYaeOj
 Wxc9oCDH5hAvXvcIO9C3Wj0cYcgCYfhAw5hg1RLHTvKPDfkS17eCuI7s32TPaIiD/wwMgvdh/u+
 mtH9xmAQ47w/58VVVD7pw7WV7AOniSwBSxx1rFYQGlkNkq/IeUe5tJMPPjzt4fAqdztRh3VYgZo
 +IHjZDSGxP6Wy6w=
X-Google-Smtp-Source: AGHT+IH7HnY5RsR6zffw2IsZfWHjs++g2ae/xzv2mUtF0gvcfmgZ7nr7GAY/pveleGoBo+WMqz6oTQ==
X-Received: by 2002:a17:902:c94c:b0:21f:4c65:6290 with SMTP id
 d9443c01a7336-21f4e6a0641mr19721265ad.1.1738884765832; 
 Thu, 06 Feb 2025 15:32:45 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f368cf52asm18134805ad.247.2025.02.06.15.32.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 15:32:45 -0800 (PST)
Date: Thu, 6 Feb 2025 17:32:42 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Caleb Connolly <caleb.connolly@linaro.org>
Subject: Re: [PATCH 31/32] efi: arm: Simplify the crt0 file and update link
 script
Message-ID: <20250206233242.GR1233568@bill-the-cat>
References: <20250203174245.1331464-1-sjg@chromium.org>
 <20250203174245.1331464-32-sjg@chromium.org>
 <20250203201036.GT1233568@bill-the-cat>
 <CAFLszTizPJX0pQs9UG7trXXfUbU9CnMzjWOQPMPLx_aeiaqsDg@mail.gmail.com>
 <20250204021411.GE1233568@bill-the-cat>
 <CAFLszTiEZnqckUuRW1OvtEv2D_6cL0hQyf9SVMvZNd6EcMFFnw@mail.gmail.com>
 <20250206170807.GI1233568@bill-the-cat>
 <CAFLszThRD3d-mSOauJ7W2qwsVUoa=ppYBvUbY88wsugFFjtRdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="39BfcZZ0jCGcp+CU"
Content-Disposition: inline
In-Reply-To: <CAFLszThRD3d-mSOauJ7W2qwsVUoa=ppYBvUbY88wsugFFjtRdQ@mail.gmail.com>
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


--39BfcZZ0jCGcp+CU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 06, 2025 at 02:31:59PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 6 Feb 2025 at 10:08, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Feb 06, 2025 at 05:33:30AM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Mon, 3 Feb 2025 at 19:14, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Mon, Feb 03, 2025 at 05:38:16PM -0700, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Mon, 3 Feb 2025 at 13:10, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Mon, Feb 03, 2025 at 10:42:24AM -0700, Simon Glass wrote:
> > > > > > > We don't need to manually add the PE header, since binutils h=
as support
> > > > > > > for this now. Remove it to simplify the file.
> > > > > > >
> > > > > > > Set the link-target to efi-app-aarch64 so that binutils knows=
 what to
> > > > > > > do. Add rules to pick up the arm64 files.
> > > > > > >
> > > > > > > Make some updates to the link-script for arm64, so this all w=
orks:
> > > > > > >
> > > > > > > - Pass  .hash .eh_frame and .reloc sections through to objcopy
> > > > > > > - Put RELA pieces into a single section
> > > > > > > - Put linker lists into .data
> > > > > > > - Embed the dtb
> > > > > > >
> > > > > > > Note that it does not seem to be possible to use this approac=
h with arm,
> > > > > > > so this is left alone.
> > > > >
> > > > > Thanks for looking at all this stuff.
> > > >
> > > > You're welcome.
> > > >
> > > > > > Did you mean x86 in this last comment? I'm not sure about the r=
est,
> > > > > > either way, so I'll leave it to others to comment on that.
> > > > >
> > > > > No, I mean 32-bit ARM. For reasons I don't understand, it seems t=
he
> > > > > toolchain doesn't support PE on 32-bit ARM.
> > > >
> > > > Ah, OK. Were other parts of this series really laying the groundwor=
k for
> > > > EFI_APP with 32bit arm?
> > >
> > > Not intentionally, since I was trying to get the series as small as
> > > possible and still actually get something that boots.
> > >
> > > I'm not sure that anyone will want a 32-bit ARM EFI-app. I would much
> > > rather that we had it for completeness, but it seems that the binutils
> > > people were not that interested in it. What do you think?
> >
> > I would ignore arm32 entirely and make things depend on ARM64 rather
> > than ARM within the series here.
>=20
> So are you saying I should remove the last part of the commit message
> ("Note that it does not seem to be possible to use this approach with
> arm,
> so this is left alone"), or something else?

You should make sure that Kconfig entries depend on ARM64 not ARM and
then commit messages should talk about arm64 or AArch64.

--=20
Tom

--39BfcZZ0jCGcp+CU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmelRpoACgkQFHw5/5Y0
tyyzjgv9GOZ+Vhg6bAoB5gFyA9X8M7xp22vIMJYfRn2AO/0LTRxXu6MvqduPK4h5
Ui4xHtCjeSq6YFb06i5OGAsc/e4Doa9Dmosx3Z/H1Ohu+qcI5UXxvRnZk83HUDHq
dPXdyTrEW4WIMXaOsG0INHvRL53zPjpUf19+PSsV1cVyTLcj1hrCQOCbpKrWDYAy
2i/tCL5SMN14unaHgY8qZXkA3m5CeUcO7yHmIVO7HVJB/xQGW0st3SgM7Db1dYj9
qVP1RbvIZl1IoDiAvS9Io07QPhzEq1G6y0HpE4PSn6VJBYb2TVMvVqn13vVPnpin
1YREVhO7akP7qBjPzGe3JpIMQfM2sdMVG7DjhN1CRHPJc6wrEU8FToagZTnK5OO0
XB/5aphFGKF/kq/jDk46+obmlVBXLE6dlR6tar0fcFs8vZajkjCF6LKFnYwchh8T
7DitRsu1LoOhogiLgszjXBWmMWOSFg1WWLAsZMCgN7ynF2/LtKrQDSRlXJ5/bpie
UUjxAdUf
=XE8I
-----END PGP SIGNATURE-----

--39BfcZZ0jCGcp+CU--
