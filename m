Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFDE8C3ABBE
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 19:48:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B1668056A;
	Tue,  6 May 2025 21:48:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GiORUdCV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 873B381F66; Tue,  6 May 2025 21:48:24 +0200 (CEST)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E6868007D
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 21:48:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-606668f8d51so152414eaf.0
 for <u-boot@lists.denx.de>; Tue, 06 May 2025 12:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746560901; x=1747165701; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dPMT3b2mU51uVoVaHWdhx4pZrMMl5PU+dGWgQrpoiik=;
 b=GiORUdCVT1dX4jOYrzEShsAGfcwg3JP3Bz7qkPGrg5NcVcccfD+O1mEfXG1R5NoDJm
 3t0QUJ0XE49AcnVbKUACeFPo7cMiEUacT+Cj4lk6N/+1KY+SsbCxoVwbzOEvQTqi4r3c
 ec3BvQXtRlYvmRhnwaXd3tYR/a7dSDMDcmTKk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746560901; x=1747165701;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dPMT3b2mU51uVoVaHWdhx4pZrMMl5PU+dGWgQrpoiik=;
 b=MsvNRq9uSgPP/DzePN/rib0AuwJHVjjFaoCHOZsc6eko3OjSMBYAgaK4x0u03acWYC
 9zdf/bfimT0oaFqcB5sNQcDmlgoGVt4/i/cV608Q+ebnkt9w19a6zlWoIodjGJacu4hD
 j6E0+uHK7n3aJYmQjArIx7tglX4e+GLmIoKRz1TGp1E1o+D1fT4hDGheL2sPT8uE/jAb
 S5hkLiEk/EUyyWDMK4eigUaTvGWhu5MXGEM3mqwWGPPb1rfTz0HvKKdlByL2NLxG+fqe
 Vlq30xUpwyvm7ieBAtE3Uxu79nMMpScGkOGxsG6DjxT2i1h7NjXeMD41RlFkdKs1BoSk
 8Z4Q==
X-Gm-Message-State: AOJu0YyZ/vbIv+zm9242G1mGhclmmLHosPuR7wYdNDg6oZemR/Noc/6j
 qMQGnGGPALZiODN3cG7+3GpUQiACM95eZp9GppXyDS3SnNz7Ipf2ZwPTpCUmeMk/VCVY2BkdC/f
 H
X-Gm-Gg: ASbGncvVOV1D+2DIhGWvDNyfWql4DaXTn2BQt3dikrJUL/3w7DbUNSbvJ7LX1EbtFxD
 VYNTwaV5/PUogXfd5vjupeK0zZHDrgtBleU+gLtdIKItwIVn5H8vuibF5pCjaQ/eWXIiWwRVePX
 IGa91D9YRGplXosz2ifxQzgJuOSKz6CZ1BN0hmVQas0EWG5loFa21bQWm4d2wDeMlqSlarkW9e3
 Pz8qAMrQ3ulEzwd5qXUJYvDLvfoNhtmHjw9npuOMF+JBFqbJlCm9cxwfYKnLGimdRHxpxsLENiI
 MqMviQ1Kuo3qB6omNuQvBLwI53VaY2gGxw19YaceC7gjfASphJsDuDzRJbn7aJLsIR7skiQx+E5
 RKQ==
X-Google-Smtp-Source: AGHT+IF6M9jnvJjbMPsng8W/24HHLKTgnABd8gjonoio7qG/VfMyNghJUrYkRbdZnF+UA/5WuwA0TQ==
X-Received: by 2002:a05:6820:448b:b0:604:99a6:4e90 with SMTP id
 006d021491bc7-608294a773amr241267eaf.0.1746560900754; 
 Tue, 06 May 2025 12:48:20 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-608226548f7sm412155eaf.21.2025.05.06.12.48.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 12:48:19 -0700 (PDT)
Date: Tue, 6 May 2025 13:48:17 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Rasmus Villemoes <ravi@prevas.dk>, Stefan Roese <sr@denx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH v2 01/18] abuf: Add a helper for initing and allocating a
 buffer
Message-ID: <20250506194817.GH5430@bill-the-cat>
References: <20250501133726.2627373-1-sjg@chromium.org>
 <20250501133726.2627373-2-sjg@chromium.org>
 <20250505203810.GM5430@bill-the-cat>
 <CAFLszTgw6pP7SgRp=C-skUeA_cOhEfoVXD+YNKE9jP8vj0UPXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XdhePgrX3yWjxagU"
Content-Disposition: inline
In-Reply-To: <CAFLszTgw6pP7SgRp=C-skUeA_cOhEfoVXD+YNKE9jP8vj0UPXw@mail.gmail.com>
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


--XdhePgrX3yWjxagU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 06, 2025 at 03:23:39PM +0200, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 5 May 2025 at 22:38, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, May 01, 2025 at 07:37:01AM -0600, Simon Glass wrote:
> >
> > > This construct appears in various places. Reduce code size by adding a
> > > function for it.
> > >
> > > It inits the abuf, then allocates it to the requested size.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > > Changes in v2:
> > > - Add new patch with a helper for initing and allocating a buffer
> > >
> > >  boot/cedit.c          |  3 +--
> > >  boot/scene.c          |  3 +--
> > >  boot/scene_textline.c |  3 +--
> > >  include/abuf.h        | 11 +++++++++++
> > >  lib/abuf.c            |  9 +++++++++
> > >  lib/of_live.c         |  3 +--
> > >  test/lib/abuf.c       | 22 ++++++++++++++++++++++
> > >  7 files changed, 46 insertions(+), 8 deletions(-)
> >
> > This just made me look again at the abuf implementation itself and
> > become filled with regret I didn't reject it back in 2021. We're
> > introducing wrappers around standard functions and calling conventions /
> > patterns with something homegrown (and so not intuitive to others) that
> > mainly hides the "sysmem" challenge we also have  and I wish you were
> > interested in revisiting how that part of sandbox works instead. And
> > even if this is a better design, for the sake of argument, it's not
> > something everyone else is used to. And that's important.
> >
> > If we *really* need something different / new here, I'd rather see us go
> > and wrap common/dlmalloc.c with kmalloc/kfree/etc and so give people
> > something even more familiar-looking.
>=20
> The purpose of abuf is actually not about hiding sysmem - you can see
> that if you look at lib/abuf.c and the tests. It provides an easy way
> to manage buffers, which we do a lot in U-Boot, particularly with
> standard boot. It deals with whether the buffer is allocated or not,
> so freeing is easy. With expo I want to be able to manage a buffer
> containing an autoboot string in high-level code, say, without
> worrying whether it has to be realloced.

It's a wrapper around free/malloc/et al, which then also includes the
sandbox-specific requirement of *sysmap* stuff. This is best shown by
the next two patches which convert from standard malloc/free patterns
(which both humans and analysis checkers are fond of) to a home grown
invention.

> For sysmem, I don't see a viable alternative, which keeps can reliably
> keep addresses consistent across multiple phases (e.g. sandbox_vpl).
> Also, I don't believe addresses like 0x7ffff7fbc000 are
> human-friendly, yet that is what we would see in tests if we dropped
> the mapping. The point of sandbox is to test U-Boot, not expose the
> system internals. But we could discuss it if you like?

I'm not sure how this is relevant to the general high level point of
"sandbox should be able to, in 2025, be designed so that special macros
do not need to be everywhere for the sanity checking it can do to
happen". If my web browser is going to suck up 11GiB of memory all the
time I can live with sandbox using 1/2/4/whatever GiB of memory when it
runs. The "this is not a pointer" problem sandbox can solve could be
done differently these days.

> In general I am sensing that there are a lot of things which bug you
> about the direction of U-Boot. and that you feel very differently
> about some things than you did in 2021. I have quite a few concerns
> too. So how about we make time to discuss these and see if we can get
> on the same page, at least somewhat?

Yes, we've had numerous long threads, and a few calls. You are then
unhappy with what I say I want to see done, want me to just take your
changes instead and "Say Yes" more. I wonder if I had said No, or gather
more feedback from potential users, or just slow down, more back in 2021
if we would not be in a different position here.

> Coming back to this patch though, this is really about a code-side
> win, rather than anything else.

No, it's about how similar to the "log a message and return" convention
change you wanted to make and then dropped, how I do not see good value
in changing from standard convention of malloc/free to abuf being a win.
Maybe this is a case where borrowing the kernel's mempool logic would be
a win instead? Because another part of this is that we want to avoid
making up our own APIs for things if we can instead borrow something
=66rom the kernel, where most of the rest of the community will already be
familiar.

--=20
Tom

--XdhePgrX3yWjxagU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgaZ30ACgkQFHw5/5Y0
tyzQ9AwAtrzKlWDLcKOqk/2FtafH3I/vxkAr5N25jhuZftsITxxBDt2j30VO9ZHR
/SZBkQMs/uxv+9+QyrPmVwNNbBO7d+T1Z1zllK/RvUutxMD3T4OTQYFJ17bWO911
oZCtxYVU/p5ZkuE0zJeZ67d33snMw+AwiVbD4vvVDTp35zrKOlfuVWXucGEqLIJt
Jq2Cyc60l1NdTz9QXqnvfDDttSEgNSSxuvLI3gkSxYGpQENLaa3BbSVvgeHFwMkm
IiivKw9DhD7sXSCI2izmygkCiX9K/xEimIB5sFD8Fye7Y8Z1INptTe8R66oHa+RA
/cpFeLuoM+46pv2CoYIQgId/nJXJ5ceuPpo7qeX/uAlls3ZP9OE54FEPQERJPN7g
sELOUGcBdMSSYj8HIzRPFHWqHTwOXwG9RiLJBIiLEP5NicY0YgdkOMECRlMFDBTW
5keRj2b6qJr0tPBU8YOQBiSyG5AoNOYX7femRzkNRNJaHEY1xfYggOoJMlLorJVF
ff35Ne/X
=o3Xa
-----END PGP SIGNATURE-----

--XdhePgrX3yWjxagU--
