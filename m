Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9379DC25B6B
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 23:06:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1862086FA6;
	Thu, 26 Oct 2023 01:06:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="M9JIPi+v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4480E86FA6; Thu, 26 Oct 2023 01:06:06 +0200 (CEST)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE33686F70
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 01:06:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3b52360cdf0so144998b6e.2
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 16:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698275162; x=1698879962; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zqLlKmUs9p8PF3NWjAp+cPkCYHEpBR5RlfAuIZ7F+hI=;
 b=M9JIPi+v3iytuJhxo6aPqnJqDQ7vpyc7l8qEoVCt+/i2POL8i9Oxy08TzedRIRF7RE
 PuXoaT+kmJTIk3fF4bqeliS4YorPNEgZab8Fu9Lj31ROwM0i7WrorBpHNMwHMjp7l6Th
 0eJG9CdwgdAP/XlBZb2rdCZahYScWX7uT/7Lk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698275162; x=1698879962;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zqLlKmUs9p8PF3NWjAp+cPkCYHEpBR5RlfAuIZ7F+hI=;
 b=PzkTbeb3mtAtBzn+u/OluD5VvM/Rdha8Ys3ze2BJDdndfV7CNo89hzHt8I3VozAuZZ
 dChTAioahr4EF/JRzJhIcg2ikymLIVKvFx9F4zJJCtwSulgsHscdkyWWMMQPpnb+ZwmN
 BHSp21HbX742YYLWLptKb+DX/mTuqp+WfsNFOi0GyVcBpRp+nRgKuB0PQMITQV3TMY1m
 xa52+2zEdF+/gI9aUEOw8lMCvg8+FTB8n4OB1/5n2D5zYCfVc0K62mjWNcc5fgdyfk89
 4rtRFBYNY9QBPuK/+iBT+cY3Unh2FO/4nFbLE+mxPCFBR7uFfSOYQdA3MyLUTZiRyiok
 WAPw==
X-Gm-Message-State: AOJu0YxqVBaDbp4d4hqN1vvUq16RRtL7mDyF0bp6RgaXT8qmd0Dvyzw3
 6jrhplg+JStAwSCzeBeiPrf94A==
X-Google-Smtp-Source: AGHT+IFOHJPpms2JOBUz/GvPnraRNIS5eF47cNJLQhisyhpfEw/hLRiBskK2VvQV4Y+6r5JFh1faYg==
X-Received: by 2002:a05:6870:7994:b0:1e9:bda0:775 with SMTP id
 he20-20020a056870799400b001e9bda00775mr19587134oab.42.1698275162219; 
 Wed, 25 Oct 2023 16:06:02 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-7a1b-75c0-d849-e3ce.res6.spectrum.com.
 [2603:6081:7b00:6400:7a1b:75c0:d849:e3ce])
 by smtp.gmail.com with ESMTPSA id
 es17-20020a056214193100b0066cfe6b078csm4758562qvb.15.2023.10.25.16.06.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 16:06:01 -0700 (PDT)
Date: Wed, 25 Oct 2023 19:05:59 -0400
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: sjg@chromium.org, caleb.connolly@linaro.org, u-boot@lists.denx.de,
 ilias.apalodimas@linaro.org, bmeng.cn@gmail.com,
 brandon.maier@collins.com, kconsul@ventanamicro.com,
 oleksandr.suvorov@foundries.io, patrick.delaunay@foss.st.com,
 sughosh.ganu@linaro.org, Mark Kettenis <mark.kettenis@xs4all.nl>
Subject: Re: [PATCH] smbios: arm64: Allow table to be written at a fixed addr
Message-ID: <20231025230559.GB496310@bill-the-cat>
References: <CAPnjgZ1Q4y1SvwMa3gRX6Xa=5gP7gTSiQfe83jQ=KQC2K=EG7g@mail.gmail.com>
 <87il6xqrso.fsf@bloch.sibelius.xs4all.nl>
 <20231024223405.GM496310@bill-the-cat>
 <87bkcmrdjn.fsf@bloch.sibelius.xs4all.nl>
 <20231025142842.GQ496310@bill-the-cat>
 <ab2be1cb-f185-4f4e-83dc-d318fd2ab30e@gmx.de>
 <20231025170956.GU496310@bill-the-cat>
 <e05c870f-5522-4194-92d5-82e5c9808169@gmx.de>
 <20231025210913.GY496310@bill-the-cat>
 <cce41111-3870-420f-9ca2-0a1ba51b3eb7@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oZ9D8QEbTtJ7Z6LN"
Content-Disposition: inline
In-Reply-To: <cce41111-3870-420f-9ca2-0a1ba51b3eb7@gmx.de>
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


--oZ9D8QEbTtJ7Z6LN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 26, 2023 at 01:02:40AM +0200, Heinrich Schuchardt wrote:
> On 10/25/23 23:09, Tom Rini wrote:
> > On Wed, Oct 25, 2023 at 10:52:48PM +0200, Heinrich Schuchardt wrote:
> > > On 10/25/23 19:09, Tom Rini wrote:
> > > > On Wed, Oct 25, 2023 at 05:28:10PM +0200, Heinrich Schuchardt wrote:
> > > > > On 25.10.23 16:28, Tom Rini wrote:
> > > > > > On Wed, Oct 25, 2023 at 04:18:20PM +0200, Mark Kettenis wrote:
> > > > > > > > Date: Tue, 24 Oct 2023 18:34:05 -0400
> > > > > > > > From: Tom Rini <trini@konsulko.com>
> > > > > > > >=20
> > > > > > > > On Mon, Oct 23, 2023 at 05:31:19PM +0200, Mark Kettenis wro=
te:
> > > > > > > > > > From: Simon Glass <sjg@chromium.org>
> > > > > > > > > > Date: Mon, 23 Oct 2023 00:04:14 -0700
> > > > > > > > > >=20
> > > > > > > > > > Hi Caleb,
> > > > > > > > > >=20
> > > > > > > > > > On Sat, 21 Oct 2023 at 01:43, Caleb Connolly <caleb.con=
nolly@linaro.org> wrote:
> > > > > > > > > > >=20
> > > > > > > > > > > Hi Simon,
> > > > > > > > > > >=20
> > > > > > > > > > > On 21/10/2023 01:45, Simon Glass wrote:
> > > > > > > > > > > > U-Boot typically sets up its malloc() pool near the=
 top of memory. On
> > > > > > > > > > > > ARM64 systems this can result in an SMBIOS table ab=
ove 4GB which is
> > > > > > > > > > > > not supported by SMBIOSv2.
> > > > > > > > [snip]
> > > > > > > > > There is absolutely no guarantee that arm64 machines have=
 memory below
> > > > > > > > > 4GB.  Examples of SoCs that have no memory below 4GB are =
AMD's Opteron
> > > > > > > > > A1100 SoC and all the recent Apple SoCs.
> > > > > > > >=20
> > > > > > > > So one thing to resolve here is where does that requirement=
 about the
> > > > > > > > SMBIOS table needing to be below 4GB come from (standards w=
ise), and in
> > > > > > > > turn is that obeyed by consumers like say Linux or OpenBSD?=
 Answering my
> > > > > > > > own question, maybe in part, https://www.dmtf.org/standards=
/smbios reads
> > > > > > > > to me like there's a v3 and maybe we should be doing what w=
e need to
> > > > > > > > support / identify as that, if it doesn't have that restric=
tion?
> > > > > > >=20
> > > > > > > Right.  U-Boot implements SMBIOS 2.x which is pretty much obs=
olete and
> > > > > > > uses 32-bit addresses.  SMBIOS 3.x allows for 64-bit addresse=
s.  So to
> > > > > > > fix this U-Boot needs support for SMBIOS 3.x.
> > > > > >=20
> > > > > > OK, thanks.  And for clarity / repeating my confusion, at least=
 right
> > > > > > now we also set the major/minor in the struct to 3.0.
> > > > > >=20
> > > > > > > Personally I don't see why we'd need SMBIOS support on non-x86
> > > > > > > platforms, which is why implementing this isn't a high priori=
ty for
> > > > > > > me.  I simply disabled SMBIOS support for M1 for now.
> > > > > >=20
> > > > > > This I think in turn (based on Heinrich's emails in v2 of this =
patch)
> > > > > > EFI_LOADER wants to pass SMBIOS (probably 3) information along =
so that
> > > > > > human user facing tools can see the kind of info that table pro=
vides.
> > > > > >=20
> > > > >=20
> > > > > If you have to manage a fleet of devices, be it Apple laptops, sm=
all
> > > > > servers or IoT devices, you want to be able to retrieve informati=
on
> > > > > about these devices like installed firmware, serial numbers, etc.=
 This
> > > > > information should be presented by our SMBIOS implementation.
> > > > >=20
> > > > > Other EFI architectures (ARM and RISC-V) target the same markets =
as x86.
> > > > > The customers expect that they can use the same tools irrespectiv=
e of
> > > > > architecture.
> > > >=20
> > > > Ah, we do have serial# being passed along that way (as well as other
> > > > methods which is why I didn't think about them for SMBIOS). But this
> > > > also doesn't answer my bigger concern which is that we're setting o=
ur
> > > > version major to 3, our minor to 0 and then filling in a struct tha=
t's
> > > > not the "smbios3" one that Simon's patch from another thread added.=
 Is
> > > > what we're filling out today semantically valid? I'm hoping someone=
 who
> > > > has already read over the spec / is familiar and I don't need to go=
 do
> > > > that right now.
> > > >=20
> > >=20
> > > First of all there is a field "Anchor String". For a 32bit structure =
it
> > > contains the value '_SM_', for a 64bit structure it contains the value
> > > '_SM3_'. The different EFI GUIDs relate to these two different
> > > structures. In our mails we simply referred to them as SMBIOS2 and
> > > SMBIOS3 structures.
> > >=20
> > > Next there are the fields 'SMBIOS Major Version' and 'SMBIOS Minor
> > > Version'. These should refer to the standard version 3.7 if U-Boot
> > > adheres to the current version.
> > >=20
> > > As RISC-V was only fully added in SMBIOS version 3.4 we should not use
> > > any older version of the specification.
> > >=20
> > > See
> > > https://www.dmtf.org/content/dmtf-releases-smbios-37
> >=20
> > That's helpful.  Can we use an SMBIOS2 structure with 'SMBIOS Major
> > Version' =3D 3 and be valid?
> >=20
>=20
> The SMBIOS specification 3.7 says:
>=20
> "If an implementation provides both a 32-bit and a 64-bit entry point,
> they must both report the same SMBIOS major.minor specification version"
>=20
> This implies that SMBIOS Major Version =3D 3 is valid both in the 32- and
> in the 64-bit structure.

OK, so tooling isn't going to, or at least shouldn't, blow up because we
have Major Version 3 in a SMBIOS2 structure in 32bit address space,
thanks.

--=20
Tom

--oZ9D8QEbTtJ7Z6LN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU5n1QACgkQFHw5/5Y0
tyz3zgwAsPC3PCp+iWj35adRusZsk18RvXB+tCS9J9fdskXKTEJpZQB1FvuY+ViO
rXDP3r6NjL2b87oAehfbAzOHfBj32cBDV9WkJmaF+R4CL+sBTCwkTmkVXRhvWnFQ
c2o8dS21hPQnmtYUzrdoc7PLMALZwiQPUgge0zG1WWdj1ST+QYbp1eU2S3Mp2T1X
rZ02qhjmc0PqIB9aY+6jMiKraQPmWc92fUZ+8bSTRX5ZanDeypeccYESwx9bFp5k
99hZ2fsEBDvZx5NrsQCnlBPTlZ60bqCheJvg30AP+l6OOEpYTIeHUElGpF4FMDrV
oWAgTiY0EA4JMUtlTjItk3uJs83flZ84Ig13oS+PtEpi5bZGBwsP7d2LTWEtNe9H
KMpjWleABNj9Y/UKivnCM1HpC8jROs8r/SAGL7fyzdmlSm4aw5gHiFWmUYQdHIHU
83quFql8ZKrpdPTqiZtKnXPlUYREBy7HLXsdZBX98uuEJ3crwiBDWARpO4VjfzDV
g9V0yol4
=XHI3
-----END PGP SIGNATURE-----

--oZ9D8QEbTtJ7Z6LN--
