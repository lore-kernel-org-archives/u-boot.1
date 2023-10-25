Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62F9FC0032E
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 13:37:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFC3687A9E;
	Wed, 25 Oct 2023 15:37:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="U2yzchAs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E07E087A9E; Wed, 25 Oct 2023 15:37:18 +0200 (CEST)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC57C86D05
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 15:37:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-41ccd38eaa5so7356441cf.0
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 06:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698241029; x=1698845829; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9LLxyIpgzMIQN69sBMMrsIgvx856fRJLwXtx3gIx+ow=;
 b=U2yzchAs/V5DK8N6yz2zBftuW+ekyj5vYzzaobe3h8h5wiWDKvQlgI+6yuTEQ/5u8N
 p2NLCVG5a8T86RucveM6dkpPoPkIOekI5DXYk3HRB3/B6RUv5PGztDeUugFRWrHbb63F
 KqRq9ynntCr2xJeV5jJOPHF3vq1+EuB7eTwlk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698241029; x=1698845829;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9LLxyIpgzMIQN69sBMMrsIgvx856fRJLwXtx3gIx+ow=;
 b=LZWrcLfCqmjwL9n38OP1Pz++atUvmcXZdDX7frZACTsJCqRTORR2HVFDqzOBMLYlkl
 9XudQE6yS2NgQkgrgb8tfmvjtbvXl4eWniOk2yKCvdFSchYFy0U4RgGuboOfYKwlvdBE
 B3PTt3eoDmLlWZRIMHJl2t7L3+nzHUleO2+p0+l59s8ZPacQA8ZvMbOz2ToxPhONTOKi
 6mcBS21TF0TsEagWMUkhuMs078Y3ir6/HU/uvagRc4PyQxVV0rndSV28x4iWr+UHmMe5
 SOJ4OLjwU3cW9JELxWUBQBnxU+DFcJzV7TRILuh8CVCzqsfLkLiPv7orCFZGiebza3T2
 OnsA==
X-Gm-Message-State: AOJu0Yx1TCQ49jQu0foaOLnh8VYGhm4ImXmRkyTH1c5DWdCsCNuwtnuX
 +rZpHwFTezFpDAqF4O6VNftVLw==
X-Google-Smtp-Source: AGHT+IFkkWqw89rwIsQiRH7EHIC7IL45zXgNG34VRkl+eIaMGmUGYl0IXwS/O58z9dYPx5y1EDSZRw==
X-Received: by 2002:ac8:66c5:0:b0:418:11c9:ddb5 with SMTP id
 m5-20020ac866c5000000b0041811c9ddb5mr17998405qtp.25.1698241029262; 
 Wed, 25 Oct 2023 06:37:09 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-89e7-8c52-372d-17ee.res6.spectrum.com.
 [2603:6081:7b00:6400:89e7:8c52:372d:17ee])
 by smtp.gmail.com with ESMTPSA id
 g22-20020ac84696000000b0041b7f007546sm4249739qto.82.2023.10.25.06.37.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 06:37:08 -0700 (PDT)
Date: Wed, 25 Oct 2023 09:37:06 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, caleb.connolly@linaro.org,
 u-boot@lists.denx.de, ilias.apalodimas@linaro.org,
 bmeng.cn@gmail.com, brandon.maier@collins.com,
 kconsul@ventanamicro.com, oleksandr.suvorov@foundries.io,
 patrick.delaunay@foss.st.com, sughosh.ganu@linaro.org
Subject: Re: [PATCH] smbios: arm64: Allow table to be written at a fixed addr
Message-ID: <20231025133706.GK496310@bill-the-cat>
References: <20231021004522.53311-1-sjg@chromium.org>
 <c4212389-6d0e-405d-bbc7-10c8278ba1de@linaro.org>
 <CAPnjgZ1Q4y1SvwMa3gRX6Xa=5gP7gTSiQfe83jQ=KQC2K=EG7g@mail.gmail.com>
 <87il6xqrso.fsf@bloch.sibelius.xs4all.nl>
 <20231024223405.GM496310@bill-the-cat>
 <CAPnjgZ1h2GUWKupVJcNEQmQd1JJf1h9X+xkc3P=+qxmfCwAcOA@mail.gmail.com>
 <5F047C34-685E-41E9-A726-6003B8FCFB56@gmx.de>
 <20231025004415.GJ496310@bill-the-cat>
 <CAPnjgZ3Pbwt+Sq5rVky5JOYpgGQngteZ3Z_zL2oX-_2PQFi_Gw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9mw30M51+opA91D6"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ3Pbwt+Sq5rVky5JOYpgGQngteZ3Z_zL2oX-_2PQFi_Gw@mail.gmail.com>
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


--9mw30M51+opA91D6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 07:47:44PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 24 Oct 2023 at 17:44, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Oct 25, 2023 at 02:19:59AM +0200, Heinrich Schuchardt wrote:
> > >
> > >
> > > Am 25. Oktober 2023 01:28:10 MESZ schrieb Simon Glass <sjg@chromium.o=
rg>:
> > > >Hi Tom,
> > > >
> > > >On Tue, 24 Oct 2023 at 15:34, Tom Rini <trini@konsulko.com> wrote:
> > > >>
> > > >> On Mon, Oct 23, 2023 at 05:31:19PM +0200, Mark Kettenis wrote:
> > > >> > > From: Simon Glass <sjg@chromium.org>
> > > >> > > Date: Mon, 23 Oct 2023 00:04:14 -0700
> > > >> > >
> > > >> > > Hi Caleb,
> > > >> > >
> > > >> > > On Sat, 21 Oct 2023 at 01:43, Caleb Connolly <caleb.connolly@l=
inaro.org> wrote:
> > > >> > > >
> > > >> > > > Hi Simon,
> > > >> > > >
> > > >> > > > On 21/10/2023 01:45, Simon Glass wrote:
> > > >> > > > > U-Boot typically sets up its malloc() pool near the top of=
 memory. On
> > > >> > > > > ARM64 systems this can result in an SMBIOS table above 4GB=
 which is
> > > >> > > > > not supported by SMBIOSv2.
> > > >> [snip]
> > > >> > There is absolutely no guarantee that arm64 machines have memory=
 below
> > > >> > 4GB.  Examples of SoCs that have no memory below 4GB are AMD's O=
pteron
> > > >> > A1100 SoC and all the recent Apple SoCs.
> > > >>
> > > >> So one thing to resolve here is where does that requirement about =
the
> > > >> SMBIOS table needing to be below 4GB come from (standards wise), a=
nd in
> > > >> turn is that obeyed by consumers like say Linux or OpenBSD? Answer=
ing my
> > > >> own question, maybe in part, https://www.dmtf.org/standards/smbios=
 reads
> > > >> to me like there's a v3 and maybe we should be doing what we need =
to
> > > >> support / identify as that, if it doesn't have that restriction?
> > > >
> > > >Yes that was my previous patch. However 1) we apparently don't want =
to
> > > >use SMBIOS3 and 2) my patch had some sort of bug so that it wasn't
> > > >read correctly.
> > > >
> > > >So my next version is going to be along the lines of what was discus=
sed here.
> > > >
> > > >Of course, we cannot solve Mark's problem with SMBIOS2, but I suppose
> > > >that is obvious. Anyway, those platforms probably don't need SMBIOS.
> > >
> > > You are heading in the wrong direction. We need SMBIOS 3. SMBIOS 2 is
> > > only a fallback for outdated tools.
> > >
> > > Upcoming mainline RISC-V platforms will also have memory starting abo=
ve 4GiB.
> >
> > I want to echo this because yes, SMBIOS if I'm recalling things right is
> > one of those tools used to provide user friendly information about the
> > system, so "everyone" wants it, or at least platforms like ones Mark is
> > concerned about that have more human users than embedded system users,
> > would like to show the information.  Maybe part of the answer moving
> > forward is to allow being specific about SMBIOS2 or SMBIOS3 (or none) so
> > that the issue you had to fix can also be addressed minimally?
>=20
> OK, so perhaps fixing up this patch would work? [1]
>=20
> I got the impression that we wanted to continue to use SMBIOS2 unless
> we couldn't. So this patch provides for that. It is conceptually
> similar to the way things worked before, so provides the smallest
> possible change. The move to SMBIOS3 is really a separate issue, isn't
> it?
>=20
> In fact, how can writing SMBIOS2 have ever worked on machines without
> memory below 4GB? That seems like a 'feature request' rather than a
> bug fix...and the merge window is closed.
>=20
> So...?
>=20
> Regards,
> Simon
>=20
> [1] https://patchwork.ozlabs.org/project/uboot/patch/20231015024511.39955=
80-4-sjg@chromium.org/

This keeps bringing up more questions, sigh. Can we really, as we
seemingly do today, declare the table we're passing to be major_ver=3D3,
minor_ver=3D0 and not be using the struct [1] defines as the smbios3 table
format? anchor has a different size to start with.

I'm not familiar with where we decided we wanted to use SMBIOS2 unless
we couldn't, but maybe we need to re-evaluate that decision all the
same.

And in my mind, especially once we know the answer to my first question
here about struct vs version number, I see your patch in [1] is fixing a
problem, and adding whatever further information SMBIOS3 would let us
pass as future work for post-v2024.01.

--=20
Tom

--9mw30M51+opA91D6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU5Gf8ACgkQFHw5/5Y0
tyxh4Av/UGaM1wD8UvU452hEX+BzRhTw6N8ULMlrms3jN62ueQqCfKxVRHBFp+8O
FKDNzU5rm2uHVpeEEjA5kEpWBRS2yg3tFogxlgd/RDLUkBnGt3uPMtdBYe+q8HS+
UVOt4puaBGN2zMW5yY1ctJJ55LfiOmYOpJKe7It4K9cz3Q51APqFFrE+Ywva9O6i
mw1vaCpG3NdhoWmgdFeybSJUCGTWB0nu+E5KrsQnTznVnSCqaK7UKbf5wO0Ur/KX
YlOSoa3f9EgUWHnisvssNtyFqwoAAWZYxFQl7/27COyBXyqZX8EDE5nwLp/PGvTk
oUj5kXaqjF4yYAziAflfcgEK9E6qBMuMvH7LsJRR4Q++H1dE1zMxbIsfeMAx42cC
N1U0rOWL03FCvkr9vZ1fDdB5ax6Qybyz6XALrCuR8uDueMnP7q4plQ0JI9ApiaNW
oPyPiy0c5LbAFpKuU4yJ4RnXcHhWfsDs4TeA/Jw5PN8Ls0PNlRi2lPaCMSdm/sPi
m6BgV2yk
=UyTF
-----END PGP SIGNATURE-----

--9mw30M51+opA91D6--
