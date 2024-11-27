Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77F41D6ACDC
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 14:15:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED36A8907B;
	Wed, 27 Nov 2024 15:15:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jgK5iW7K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02F2D893E7; Wed, 27 Nov 2024 15:15:40 +0100 (CET)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81595887D1
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 15:15:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-4668f208f10so28500421cf.3
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 06:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732716936; x=1733321736; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IXQROYn9qY+tk68VbX0pF3F2bN8jqnIlSrrkqYnoEbE=;
 b=jgK5iW7Kmu6+AcVFdmBCNUDeZywWsAjLgecDP6uEpQB3tvgnla6vaU2oQOSNOWQHts
 c40bE6LtEbBVYxuAKp32N1QC3xHS/kgW6Z8XNvFkH3VUlQDwLt4ZKEPomNFb2PCYMs6Y
 eAjD5TZl3plYs8SIXNqnNlMcA73cE3kfoclPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732716936; x=1733321736;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IXQROYn9qY+tk68VbX0pF3F2bN8jqnIlSrrkqYnoEbE=;
 b=PrD+Ab5wshL3egtpqIS7PlDmTMLIBNBmZGT6YFrOkQBOOL4CYei6f6TOOGrjf5xLtq
 8VzMNKb8/Xav8Q8UA4wBqviZcS1DirAVvxN2iIP4gL0TUmEljBn/IUSjWFIoPbu3+R9I
 msmwnHJny+gt85xm7dW11g7DqgtLk5rnWhEB7Ft+7TdmM65rrWoL7dBkF7H9cwAg//CB
 wCnVF+n0+RFwLaJAKvt5igGdmdSNCAgyyszoLU9I4qhqz5XdPx/1zmq/wLUhNb1SDYso
 PPMUJJxAw3q/GThqJhGLUWy/sOcYYxhP7NFiVB33EmAGDfBMDdfKEw81VYs4jejMELLs
 g8MQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVT+dq7eClYtu3Es3BN94oFkOEaLPyDtlgxkyQsqwV2QqoiIrico68gLA8GZImzuQkwYtmL2K8=@lists.denx.de
X-Gm-Message-State: AOJu0YwPIvcBxuY/QbISQNqKapaJW6X2HUbEkGQI82T5X82K6VtUn6nP
 4yH52FqC0GOvlozK2+vg5rCxjmsADaBwAtU69cpBC5mlXHU0GmND1bNA02FBHBk=
X-Gm-Gg: ASbGnctDwXyM3AQ/N5of+zupfZIWZdudgpEjgbYq+IQrt/m1+8Gv8pRS2Y+ppTCvC0E
 fyy+gm9e5k8YoT2IAsI25EEN5ewL9unzBDZuNzaf/DlMuuEawytiArnWUovpmccCq3tQSpljehd
 wu7EDmZD9jmLlK2NV8aiG40QWaRxztiS+sNDma2y5uuQqc5uH4EEBstG4lj8Qk6cpLtu2mQfTf5
 +q8UnjcnRBYFt3lR5QOiBkIeqN8gQZ9sFwwuYipObHqAcXbPw==
X-Google-Smtp-Source: AGHT+IEfITcYKVc99YO06nAf4y1zXhRgGiGfcqc5U2R4tF1e+eFBSoGl99LUDDkGiYsW+g9ZiIqE3Q==
X-Received: by 2002:ad4:5cc7:0:b0:6d4:85f:ccac with SMTP id
 6a1803df08f44-6d864d3eae0mr39666336d6.13.1732716936212; 
 Wed, 27 Nov 2024 06:15:36 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d451b23eccsm66460766d6.94.2024.11.27.06.15.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Nov 2024 06:15:35 -0800 (PST)
Date: Wed, 27 Nov 2024 08:15:32 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@arm.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 05/13] efi_loader: Move some memory-function comments to
 header
Message-ID: <20241127141532.GZ3600562@bill-the-cat>
References: <20241125204456.1525752-1-sjg@chromium.org>
 <20241125204456.1525752-6-sjg@chromium.org>
 <d415c887-bb0c-47e8-bfd4-d0049f596367@gmx.de>
 <CAFLszTiOp56JkV1u5qOdJUYH2vJ5YHWwpBUmhb8WWiNs2S0B+w@mail.gmail.com>
 <20241126155508.GR3600562@bill-the-cat>
 <CAFLszThjgZtYrc707w8D+PZULJQB8qpNxgDYnAV+UoNebaPm8g@mail.gmail.com>
 <20241126223332.GV3600562@bill-the-cat>
 <aa7134ee-97dc-4fcc-b739-0f97e57817fd@gmx.de>
 <20241126233218.GW3600562@bill-the-cat>
 <CAFLszTi1A_672F68q5DYJW2g0T+LGZJcBwSVysXJD7+xG=Shbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TF5XHdfn4VAuhIgV"
Content-Disposition: inline
In-Reply-To: <CAFLszTi1A_672F68q5DYJW2g0T+LGZJcBwSVysXJD7+xG=Shbw@mail.gmail.com>
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


--TF5XHdfn4VAuhIgV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2024 at 06:07:58AM -0700, Simon Glass wrote:
> Hi,
>=20
> On Tue, 26 Nov 2024 at 16:32, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Nov 26, 2024 at 11:50:40PM +0100, Heinrich Schuchardt wrote:
> > > On 11/26/24 23:33, Tom Rini wrote:
> > > > On Tue, Nov 26, 2024 at 01:04:25PM -0700, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Tue, 26 Nov 2024 at 08:55, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Tue, Nov 26, 2024 at 08:37:33AM -0700, Simon Glass wrote:
> > > > > > > Hi Heinrich,
> > > > > > >
> > > > > > > On Tue, 26 Nov 2024 at 02:35, Heinrich Schuchardt <xypron.glp=
k@gmx.de> wrote:
> > > > > > > >
> > > > > > > > On 25.11.24 21:44, Simon Glass wrote:
> > > > > > > > > Exported functions should be documented in the header fil=
e, not the
> > > > > > > > > implementation. We tend to make such updates on a pieceme=
al basis to
> > > > > > > > > avoid a 'flag day'. Move some comments related to memory =
allocation to
> > > > > > > > > follow the convention.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > >
> > > > > > > > Please, have a look at this line in doc/
> > > > > > > >
> > > > > > > > doc/api/efi.rst:78:
> > > > > > > > .. kernel-doc:: lib/efi_loader/efi_memory.c
> > > > > > >
> > > > > > > Hmm, we should not add C files as then we end up with all sor=
ts of
> > > > > > > internal functions, like checksum(). The help is a bit of a m=
ess on
> > > > > > > that page IMO and it could use an index at the top or side.
> > > > > >
> > > > > > Why? Looking at the linux kernel (where we borrow this framewor=
k from
> > > > > > and lots of developers expect to follow that style) it's extrem=
ely
> > > > > > common to kernel-doc C files. I don't see why documenting inter=
nal
> > > > > > functions (which should be clear as being internal) is a proble=
m.
> > > > >
> > > > > It depends what you mean by docs. U-Boot puts the documentation f=
or
> > > > > exported functions in header files.
> > > >
> > > > I'm sorry, that's a circular definition. And no, there is not a har=
d and
> > > > fast rule that we only put kernel-doc style comments in header files
> > > > (which are consumed by other files and tooling to generate
> > > > documentation).
> > > >
> > > > > Putting docs in C files clutters the docs with internal
> > > > > implementations, when most people just want to see the API. The w=
ay
> > > > > U-Boot does things, it is easy to see the internal (implementatio=
n)
> > > > > docs by looking at the C code and the external functions by looki=
ng at
> > > > > the header files.
> > > >
> > > > Or it makes things harder to understand because the human readable
> > > > documentation for a given function is separate from the file the
> > > > implements the function. This is possibly why in the linux kernel, =
where
> > > > we borrow "kernel-doc" from, documentation is frequently in the C f=
ile
> > > > which is then included in Documentation files (the type you objecte=
d to
> > > > in the start of this patch) which include additional human-readable
> > > > explanation of the intention and usage of the API in question.
> > > >
> > >
> > > For static functions we will continue to have function documentation =
in
> > > the C files and not in the headers. I personally never looked up the =
API
> > > documentation in the HTML docs but always in the source.
>=20
> Same here.
>=20
> > >
> > > I am not opposed against moving the EFI function documentation into t=
he
> > > header files. But we should update doc/develop/efi.rst accordingly in
> > > the same patch series. This is missing here.
>=20
> OK
>=20
> >
> > My point is that the linux kernel is about 60% C files and 40% header
> > files being kernel-doc'd in to documentation files and so "U-Boot
> > doesn't put documentation in to C files" seems like the wrong approach.
>=20
> U-Boot tries to document functions in header files. At the risk of
> making a blanket statement with thousands of counter-examples, that is
> not so much the case in Linux.
>=20
> To a large extent, people developing features in U-Boot rely on the
> header files to see what functions they can call. With the
> documentation there, they often don't need to look at the source. I
> certainly don't, unless the header-file comment is inadequate.

I think this is a case of what you do, rather than what everyone else
does. We want to be more like the linux kernel here, rather than less
like the linux kernel, given the number of kernel people also working
here. If Heinrich is fine with re-arranging everything, OK. But I think
documentation with the code makes it less likely to get out of date,
both in terms of intentional changes and bug fixes.

--=20
Tom

--TF5XHdfn4VAuhIgV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdHKXwACgkQFHw5/5Y0
tyx7AQv9E0xab5z700DymYnCuR3prR7eZYHJNJMiWQSswBxsLNhH5BMAz7+PQuAg
tt286nBUDlZbB6jAFdj0AjpCtfSQ60HNaAxZge3X4I2PsOuzg/R6v1jVt6dJZ2/o
H1gsNLfh4v9v9+TwhBbLAI8jnUuIGXwcgmWikZ3kw7jI7hEYQVidqFLxEtQHzudP
RbuaX/fvU/Y+zmVmjWvwNmxbANYi4ewJdtk4DN/7abuqoIctPBkps2bO9TYcOIUZ
JjhdnB//kjhwRzqp9IqxCtIKFFFOCWyCRfci3lidaPUat8zoLdN6CsXx65AVxDPo
MQ4rd9x2zE89jJNpRmmi3YkNXNeaT6tKSb1OYXf6+EorSHaA/R2Pb7n7cWmdqwqL
GUPcjlO6uLuCReBm2l4bVPfrvn3NW1KUp2djWqoDNNJS7TyfyR3Z4tEZOjDnYQoT
QnjvIfgJrXfA+59qL+aDx55Ds/Dv1JeZmI/AShHHoZ5cre7vlA60ODo5ZuxK2sos
j6wwC6nA
=4bOh
-----END PGP SIGNATURE-----

--TF5XHdfn4VAuhIgV--
