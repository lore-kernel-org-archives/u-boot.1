Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F1E2C369AB
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 18:55:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3367803CC;
	Thu, 24 Apr 2025 20:55:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="svsbXz/L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1280181D5D; Thu, 24 Apr 2025 20:55:22 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C118803CC
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 20:55:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7300069c447so937236a34.2
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 11:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745520918; x=1746125718; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ryxF/vNjFr5swHD6ONj1LxZqY7ltcJxHgAZfzZb1K1I=;
 b=svsbXz/LReYqop1nzfGe8E5384q0aD3cxHhfqa09ieH/YbQWFn4JwUux4bnyKxpGfd
 jJx+2Seswy+QcBxbyfmip556GAKwd5xWGwLh9gix2iupCuMWLDwpMynWPkwhRt3woc4L
 exrXyPWCoLzFcrSpgwcHKpDo49kX7dOWT0HAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745520918; x=1746125718;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ryxF/vNjFr5swHD6ONj1LxZqY7ltcJxHgAZfzZb1K1I=;
 b=tGZ16GFJBmrYltk5uaNQFQq+IDsDYZCJHewBBgYUDEQKlI7lNdK86WsUaf7hffvnch
 57yWXMtErW/c6wDc+E7mlLMOE20Wn9satKVU0KK6INNvbHsgm2c/3ZBPj9Q/NXWLFEdm
 Sq06Yg04RsO8SgdVUFUMksVmUyM31Vot9ZIo+bJ/YkDAIjF9RyLbtM91cz72KFb5oimp
 m5dbgEcuYTGTm7CPlKk5o5y1V8MPchB3StfiqXEdPv5UZkpQFV+mo6HrMJmjBAYfp1Gk
 HjH9RuQYw+Y+RRhKNRbTuF5bM28CIveGukZ8dIyxmeUSE1WZXQhAn+7gAc58lq3bLt5l
 GQQg==
X-Gm-Message-State: AOJu0YxnpFtBjO2nSQiLAwtP/Ge9Y9yGEkJxwwPPC07/eW7hYTYKlnVm
 WqRgb55JAKUolQNzyoK/q2sQN0QSXEV6ekZ+7QgTNgzUP689I9G5GbruvkF45KQ=
X-Gm-Gg: ASbGncvtuigosuYqkbMxPF4AO0PwhfF7BKJoqQBRr5Rl9Nv7xgV+TAu+7U7aYHc57wr
 TICjmHF/EO6ltEioNoKAfFADqW3yCdKrGv8L778uy4CZcdlBt8twxJak/STecgJxCYudVeYWMgx
 Y/Rkuji28h9dcbWp/9HCcXBGdxLAHXGgpiicJDWMFaPqw+6+ChnirmuMQ7qslB6gSiAFGAeZK4o
 n0f6KKj4eKu1jf6O0jJKC6f0J+kcYgFZxnApQ39xFWPMpWCG1IFoxzCSbWqkc0sZFe7WcL9zuvG
 mD+bq81YKjMXdUY4nebWo5FFmkB/DlXLby09mcMIkSWF+Go+iB5ePBqT3rgY2Vhb+feJjLKhZ5y
 Irg==
X-Google-Smtp-Source: AGHT+IG6SrU3OjCO9zkr0wpPqOn51RQbDRl+I6L01/whmvnTz+o0G5BEHOE9/kKztvL0tiLfO14m4Q==
X-Received: by 2002:a05:6830:6684:b0:72a:18a6:d431 with SMTP id
 46e09a7af769-73059c3b742mr697104a34.14.1745520918164; 
 Thu, 24 Apr 2025 11:55:18 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7304f188052sm342261a34.8.2025.04.24.11.55.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Apr 2025 11:55:17 -0700 (PDT)
Date: Thu, 24 Apr 2025 12:55:15 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 U-Boot Custodians <u-boot-custodians@lists.denx.de>
Subject: Re: Maintenance of Python tools
Message-ID: <20250424185515.GP5495@bill-the-cat>
References: <CAFLszTjnXQu3bwWt3Do7S_Vu0UO5si4HRUeW9bv0981WbUn_7Q@mail.gmail.com>
 <20250423140850.GE5495@bill-the-cat>
 <CAFLszTgBbh8F93peSC6JO+02BLGNYnRv8fgQTSW-E3xmhsY9ZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/rGfDRN1txHxqNVl"
Content-Disposition: inline
In-Reply-To: <CAFLszTgBbh8F93peSC6JO+02BLGNYnRv8fgQTSW-E3xmhsY9ZQ@mail.gmail.com>
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


--/rGfDRN1txHxqNVl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 12:34:23PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 23 Apr 2025 at 08:08, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Apr 22, 2025 at 05:39:30PM -0600, Simon Glass wrote:
> >
> > > Hi,
> > >
> > > Tom has indicated that he would like Patman to move out of his tree. I
> > > suggested on another thread[1] that I maintain it in my 'sjg' tree, so
> > > here is a new thread to discuss this.
> > >
> > > I have already done this for the qemu/efi/coreboot scripts as Tom has
> > > NAK'ed patches for those.
> > >
> > > For the other tools there is going to be quite a bit of churn, as I
> > > would like to resolve most of the many Python warnings.
> > >
> > > Given the shared source between the tools, it would be easier for me
> > > to do the same for buildman, binman and qconfig. I am thinking that I
> > > might try a move to allow Gitlab pull-requests for reviews on these as
> > > well as the mailing list, if that is useful.
> > >
> > > For tools which need to sync back to Tom's tree (i.e. not patman), I
> > > or Tom could do a pull request every now and then, omitting any
> > > changes that relate to pylint.
> > >
> > > Please let me know your thoughts. The timing is good as I am going to
> > > be sending out a new Patman feature in the next few weeks and it is a
> > > few thousand more lines of code.
> >
> > My biggest objection to all of this is that you should NOT use
> > sjg.u-boot.org as that perpetuates your abusing owning u-boot.org. As I
> > said in the thread, it should be under https://source.denx.de/u-boot/
> > somewhere and you should be the one to own it there.
>=20
> I wish you would stop bringing this up. Until things change, that is
> unfortunately what I have to do, to avoid being blocked.

I really wish you would stop holding the project domain hostage. I will
not stop bringing up that you are holding the project domain hostage
because you are holding the project domain hostage.

I am in fact getting close to my breaking point of you and your holding
of the project domain hostage.

--=20
Tom

--/rGfDRN1txHxqNVl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgKiRMACgkQFHw5/5Y0
tywQsQv+NP2U9krl7NZTZgFQSY+PvevWsMQjEppD2eBgCbH1GygOK1B9i6T+k5mg
2e/9/6US/QAahAl7vShKiU1gJfwSDjYzpPagHO1rnZPWoRpddqwzyR1iJsrjjEmZ
vONyOn+IAz3/zNnRhOeqzrrjLou5rA2fnZK2Y5lJsz+V3Ozt/PcaQhvUXYM2phe1
AxdRcmwdw81L0KqO0JhmVGCM1PTFegkRXiNCu/lEwXbaCmzc0VZqbhVnYUKPyOCj
6QswYyRJazBWexfRpSHITjXhQTX5dTTztSVwt6kwoIE7kuaxaA6wyQl0dYFQhtnX
hBX+H4Bd4pe8pAPO+KDS+z3DxikyUzgkzAm2n/8/F8uLM7X96UrTQz4NohdVmu05
wlF0xoIItkAEG0Jf047i80iSOf0yMvKzLut4ISQZa8hm9p9TzhbH/KkglBcofmNX
5NYWGuPo4/wtK2YCAFxHkMFfgA6b9Uv0tmoYGtOZzCApaYxHlVVD548bedlhdAxa
trmx9xDP
=iL4t
-----END PGP SIGNATURE-----

--/rGfDRN1txHxqNVl--
