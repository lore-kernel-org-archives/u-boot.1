Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13655CF259B
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 02:25:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97E0C88B79;
	Mon, 14 Oct 2024 04:25:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LXOACUkg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E025B88D10; Mon, 14 Oct 2024 04:25:08 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BDC988DF8
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 04:25:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6cbe90c7c95so36638886d6.1
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 19:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728872705; x=1729477505; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/kaVNX4NrYy9EzgaaR6HdDw76bu+dIZNozPUXt7qzvQ=;
 b=LXOACUkgTALRv/an+IarX9izhFNecm2wFtUOg12TIPxemnBH6TVEEfqMVXTKhZuv1F
 eHyYR1jwoWMKl9OOFeEDuVXI+S8Fc8/VDanD2Ngbv2xce9mQRr8XYxPOlVNujeNx5sv7
 dSPG5kTMVM3X6kMBe67KCERpfWxDVS9rKuVmI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728872705; x=1729477505;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/kaVNX4NrYy9EzgaaR6HdDw76bu+dIZNozPUXt7qzvQ=;
 b=bNgZDTz506MXciNLqO+ajq12VrgGamhPXhw0LigzcawY3mz661KMmAHw8Ed8pMe1WN
 NP1vS8CzIpCUh7TasjzLIf3a3Vq1SpU/Y4BaqIA9aohG1sspVyjZOnNRkjAixJ7P3bil
 VLLughpynCQ16fnai6eUJsBZbaDq6wsL6EwLzWZcOmkpL3ByHv09r62iPMtlcnqgYSH1
 tMG58K3NgUrp7gi2PXGi5Dl703Hw06v5PcNcCC3xrhG+9E9x55vwCUh67NJ3koCeTvyo
 fGsAoGHljjDqvhLdKGJkyskqV8m5v+vhhWWvzPoWeRoNfcdTjvd+4lBDQ9aOUuMYd/e2
 oI+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUHR++3dZYxebp6m96F08H6Oom/UJ03LIXATx5vZJupNJr3HAwGGVHCNyjJLd5s0+IPKWQ3eU=@lists.denx.de
X-Gm-Message-State: AOJu0YwgKLkssRfx2+npme3kOiMfcOLGrOXqH7dZNKOsALk6QpIfuo07
 vrwIOoEBgicy8rXRY/JSwyn55ox0cOBc+OzMtEUzuw3SNdRKWGfZimBfBXYR/DA=
X-Google-Smtp-Source: AGHT+IHT/chJrTmayp2e5C5CNPqBbn17UqCMbZB99fWo7oyXgH742FaJVMQlIL+m6QKiky0/7ROHcg==
X-Received: by 2002:a05:6214:3b83:b0:6c5:1fe5:f84c with SMTP id
 6a1803df08f44-6cbf9d08a54mr90067826d6.20.1728872704956; 
 Sun, 13 Oct 2024 19:25:04 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cbe8679f28sm40438326d6.143.2024.10.13.19.25.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Oct 2024 19:25:03 -0700 (PDT)
Date: Sun, 13 Oct 2024 20:25:01 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v6 08/12] efi_loader: Disable ANSI output for tests
Message-ID: <20241014022501.GC53053@bill-the-cat>
References: <20240926215950.1265143-1-sjg@chromium.org>
 <20240926215950.1265143-9-sjg@chromium.org>
 <08596845-c0b1-4557-9993-cde57420560d@gmx.de>
 <20241001002442.GC4737@bill-the-cat>
 <79d98f61-7659-47a3-938f-1eb79f402edf@gmx.de>
 <20241001180235.GH4737@bill-the-cat>
 <e02a9912-7260-4e0a-81d8-c7814907a791@gmx.de>
 <CAFLszTj6Zuj0b3kEA4OKOQY_D5XMWmtbn+HJXik+xSrB7LUjLA@mail.gmail.com>
 <20241011222807.GZ14210@bill-the-cat>
 <CAFLszTiAdR-LTLqMjpyLgXDT99p+_8KZyDPk1ZJ8hTHGaQd+oA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TxKIXZCCSM2e8jEN"
Content-Disposition: inline
In-Reply-To: <CAFLszTiAdR-LTLqMjpyLgXDT99p+_8KZyDPk1ZJ8hTHGaQd+oA@mail.gmail.com>
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


--TxKIXZCCSM2e8jEN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 13, 2024 at 01:33:32PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 11 Oct 2024 at 16:28, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Oct 11, 2024 at 04:16:28PM -0600, Simon Glass wrote:
> >
> > > Hi Heinrich, Tom,
> > >
> > > On Tue, 1 Oct 2024 at 16:18, Heinrich Schuchardt <xypron.glpk@gmx.de>=
 wrote:
> > [snip]
> > > > The relevant error message is:
> > > >
> > > >      E   Exception: Bad pattern found on console: spl_signon
> > > >
> > > > The error occurs because the substring
> > > >
> > > >      U-Boot SPL 2024.10
> > > >
> > > > occurs multiple times during the reboot process. This is not expect=
ed in
> > > > wait_for_boot_prompt().
> > > >
> > > > The EFI test is resetting the board and then calling restart_uboot()
> > > > which by itself does another reset.
> > >
> > > We had this discussion a while back and I was very-much opposed to
> > > restarting U-Boot within a test. It has set a bad precedent and now
> > > several tests do it.
> > >
> > > This is another EFI thing that I would like to resolve at some point.
> > > As previously mentioned, I understand we might be one test to check
> > > that U-Boot does actually kick up a firmware update when started, but
> > > I don't think we should be restarting willy-nilly.
> >
> > We should indeed not be restarting willy-nilly. And we don't. But the
> > test for "can we restart the system" must restart the system. That's the
> > test. It's not changing. Testing if we can restart the system by faking
> > the restart is not testing restarting the system.
>=20
> If it were just one test I would be OK with it...but it has spread,
> unfortunately. When I run under gdb I constantly have to manually
> restart U-Boot.

Then I'm sorry to say you picked a bad example to bring this up on.

--=20
Tom

--TxKIXZCCSM2e8jEN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcMgP0ACgkQFHw5/5Y0
tyyeywwAiTGY9XQOhYXIGVDq8F640MtxO9N9CMFRd92acVhigHo6tzV10vgyay4R
unY4753FjtzwW8ViQlqrKNyTXkidVOPXI2Jbq3W7+EJ0jvDCIUYyxM6U58HqffDw
q2oJN5nJSLhtWoAcd/U6LvnKnMVwyDtEK/EfrEZIqZM/nL2vJ4w3xe+fs6Onm/zO
gj3rDQj5DRqags+lcOf8qSxdQXI1kLFJaS5fEXNMzFlZUPkfeMXdvPGBX4OqsnbH
clmUIfgVXzcVfO//wrV2UHwQmR4nfps45xpk7CiUPh01/GvJvus79rPY7FtWkiKw
KWlm7GAW7McVX2rbA2l4bokuH4ax53BbvIlpt2hxmufTk2HFldfsG8qq02YDJq4K
K9mLpZ/VHhzOBHKsf9y+Eam/7ux0DLEuXB3+Amw8BH9mXzV6TKTb3kcwfgXcH17a
9wi9Tz5jiyUTx/Xr+dQWooa0OCVIlpgOE1t8boXFhWREmCjnuJGA89D1zzyWS5OC
zhw3UICD
=AGPW
-----END PGP SIGNATURE-----

--TxKIXZCCSM2e8jEN--
