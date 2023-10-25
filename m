Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AB08C25B6B
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 21:09:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E11A87AA2;
	Wed, 25 Oct 2023 23:09:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bZsikh83";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C68F87AA2; Wed, 25 Oct 2023 23:09:26 +0200 (CEST)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 778E587A95
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 23:09:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-41cd6e1d4fbso1649881cf.1
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 14:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698268156; x=1698872956; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vrViyQ3PJBFaf921Wane03QKIlI1/h0Z7PqBEmFO4JA=;
 b=bZsikh83cuwubyV/BZC7w+HSFdaZoqKJoi6JXkz3NAZpQLie9a/L6p8fFtgWCqDiD2
 o9IUmscMTZMM+g4ZT2H3Zu1y1PyvkZuTPHh8S3A47LVla7QMecELMz+PLBUJWVaVAGcF
 SjU6ng2ii0oucHh4R7o19lycBI/EVey9CJO+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698268156; x=1698872956;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vrViyQ3PJBFaf921Wane03QKIlI1/h0Z7PqBEmFO4JA=;
 b=DBkRCNjF/uRcU4z5fNg+GRdrS+FImy+pwJ7g98y/Pfik7OX+/ZFyBygOsCSOgyyCmz
 P7gh8FUsDF4AW8xcxSpwn9Wwoc+2lGU+xNQejr4nqIrvg43a5SfTY+LTOtUdG+XYrQKz
 2Qh4Ud3YCtUt+K7gtO2g2esD08HNAjCP5jLU2wvVwccrXMgMeMCURZv+Dro5JJ6GEyx1
 H27i9nAqBPuyx/iCw27xBT8YkOmlg8LFxhWFjODYJNythsWuYNcdnHETsc5pD9ypEf0a
 FlI2Wh5FCg8mt7xx68uSXzRbToRfDUtSb/8X2yrtn5o6lOoK//D7RSxakqEb6Ig0gEI1
 L1cQ==
X-Gm-Message-State: AOJu0YxtAc7LzkqnPiQTQxYiIXssn+H77GP6wHrkp5iYqiJlkNH3Trdd
 AsUxIrfoxH9OZICzPwMdvFOZPw==
X-Google-Smtp-Source: AGHT+IES+s4tYyhr5QHdqQLiAC5IR0EQpFQeET8DvGhYfqxHBlAcuvliEcxoeVCoCrddcFUxojPBAQ==
X-Received: by 2002:a05:622a:256:b0:401:e2b1:d28d with SMTP id
 c22-20020a05622a025600b00401e2b1d28dmr19042016qtx.20.1698268156233; 
 Wed, 25 Oct 2023 14:09:16 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-7a1b-75c0-d849-e3ce.res6.spectrum.com.
 [2603:6081:7b00:6400:7a1b:75c0:d849:e3ce])
 by smtp.gmail.com with ESMTPSA id
 q4-20020ac87344000000b0041b12d5fd91sm4524458qtp.55.2023.10.25.14.09.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 14:09:15 -0700 (PDT)
Date: Wed, 25 Oct 2023 17:09:13 -0400
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: sjg@chromium.org, caleb.connolly@linaro.org, u-boot@lists.denx.de,
 ilias.apalodimas@linaro.org, bmeng.cn@gmail.com,
 brandon.maier@collins.com, kconsul@ventanamicro.com,
 oleksandr.suvorov@foundries.io, patrick.delaunay@foss.st.com,
 sughosh.ganu@linaro.org, Mark Kettenis <mark.kettenis@xs4all.nl>
Subject: Re: [PATCH] smbios: arm64: Allow table to be written at a fixed addr
Message-ID: <20231025210913.GY496310@bill-the-cat>
References: <20231021004522.53311-1-sjg@chromium.org>
 <c4212389-6d0e-405d-bbc7-10c8278ba1de@linaro.org>
 <CAPnjgZ1Q4y1SvwMa3gRX6Xa=5gP7gTSiQfe83jQ=KQC2K=EG7g@mail.gmail.com>
 <87il6xqrso.fsf@bloch.sibelius.xs4all.nl>
 <20231024223405.GM496310@bill-the-cat>
 <87bkcmrdjn.fsf@bloch.sibelius.xs4all.nl>
 <20231025142842.GQ496310@bill-the-cat>
 <ab2be1cb-f185-4f4e-83dc-d318fd2ab30e@gmx.de>
 <20231025170956.GU496310@bill-the-cat>
 <e05c870f-5522-4194-92d5-82e5c9808169@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2i4Lvgzg6NKebXZy"
Content-Disposition: inline
In-Reply-To: <e05c870f-5522-4194-92d5-82e5c9808169@gmx.de>
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


--2i4Lvgzg6NKebXZy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2023 at 10:52:48PM +0200, Heinrich Schuchardt wrote:
> On 10/25/23 19:09, Tom Rini wrote:
> > On Wed, Oct 25, 2023 at 05:28:10PM +0200, Heinrich Schuchardt wrote:
> > > On 25.10.23 16:28, Tom Rini wrote:
> > > > On Wed, Oct 25, 2023 at 04:18:20PM +0200, Mark Kettenis wrote:
> > > > > > Date: Tue, 24 Oct 2023 18:34:05 -0400
> > > > > > From: Tom Rini <trini@konsulko.com>
> > > > > >=20
> > > > > > On Mon, Oct 23, 2023 at 05:31:19PM +0200, Mark Kettenis wrote:
> > > > > > > > From: Simon Glass <sjg@chromium.org>
> > > > > > > > Date: Mon, 23 Oct 2023 00:04:14 -0700
> > > > > > > >=20
> > > > > > > > Hi Caleb,
> > > > > > > >=20
> > > > > > > > On Sat, 21 Oct 2023 at 01:43, Caleb Connolly <caleb.connoll=
y@linaro.org> wrote:
> > > > > > > > >=20
> > > > > > > > > Hi Simon,
> > > > > > > > >=20
> > > > > > > > > On 21/10/2023 01:45, Simon Glass wrote:
> > > > > > > > > > U-Boot typically sets up its malloc() pool near the top=
 of memory. On
> > > > > > > > > > ARM64 systems this can result in an SMBIOS table above =
4GB which is
> > > > > > > > > > not supported by SMBIOSv2.
> > > > > > [snip]
> > > > > > > There is absolutely no guarantee that arm64 machines have mem=
ory below
> > > > > > > 4GB.  Examples of SoCs that have no memory below 4GB are AMD'=
s Opteron
> > > > > > > A1100 SoC and all the recent Apple SoCs.
> > > > > >=20
> > > > > > So one thing to resolve here is where does that requirement abo=
ut the
> > > > > > SMBIOS table needing to be below 4GB come from (standards wise)=
, and in
> > > > > > turn is that obeyed by consumers like say Linux or OpenBSD? Ans=
wering my
> > > > > > own question, maybe in part, https://www.dmtf.org/standards/smb=
ios reads
> > > > > > to me like there's a v3 and maybe we should be doing what we ne=
ed to
> > > > > > support / identify as that, if it doesn't have that restriction?
> > > > >=20
> > > > > Right.  U-Boot implements SMBIOS 2.x which is pretty much obsolet=
e and
> > > > > uses 32-bit addresses.  SMBIOS 3.x allows for 64-bit addresses.  =
So to
> > > > > fix this U-Boot needs support for SMBIOS 3.x.
> > > >=20
> > > > OK, thanks.  And for clarity / repeating my confusion, at least rig=
ht
> > > > now we also set the major/minor in the struct to 3.0.
> > > >=20
> > > > > Personally I don't see why we'd need SMBIOS support on non-x86
> > > > > platforms, which is why implementing this isn't a high priority f=
or
> > > > > me.  I simply disabled SMBIOS support for M1 for now.
> > > >=20
> > > > This I think in turn (based on Heinrich's emails in v2 of this patc=
h)
> > > > EFI_LOADER wants to pass SMBIOS (probably 3) information along so t=
hat
> > > > human user facing tools can see the kind of info that table provide=
s.
> > > >=20
> > >=20
> > > If you have to manage a fleet of devices, be it Apple laptops, small
> > > servers or IoT devices, you want to be able to retrieve information
> > > about these devices like installed firmware, serial numbers, etc. This
> > > information should be presented by our SMBIOS implementation.
> > >=20
> > > Other EFI architectures (ARM and RISC-V) target the same markets as x=
86.
> > > The customers expect that they can use the same tools irrespective of
> > > architecture.
> >=20
> > Ah, we do have serial# being passed along that way (as well as other
> > methods which is why I didn't think about them for SMBIOS). But this
> > also doesn't answer my bigger concern which is that we're setting our
> > version major to 3, our minor to 0 and then filling in a struct that's
> > not the "smbios3" one that Simon's patch from another thread added. Is
> > what we're filling out today semantically valid? I'm hoping someone who
> > has already read over the spec / is familiar and I don't need to go do
> > that right now.
> >=20
>=20
> First of all there is a field "Anchor String". For a 32bit structure it
> contains the value '_SM_', for a 64bit structure it contains the value
> '_SM3_'. The different EFI GUIDs relate to these two different
> structures. In our mails we simply referred to them as SMBIOS2 and
> SMBIOS3 structures.
>=20
> Next there are the fields 'SMBIOS Major Version' and 'SMBIOS Minor
> Version'. These should refer to the standard version 3.7 if U-Boot
> adheres to the current version.
>=20
> As RISC-V was only fully added in SMBIOS version 3.4 we should not use
> any older version of the specification.
>=20
> See
> https://www.dmtf.org/content/dmtf-releases-smbios-37

That's helpful.  Can we use an SMBIOS2 structure with 'SMBIOS Major
Version' =3D 3 and be valid?

--=20
Tom

--2i4Lvgzg6NKebXZy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU5g/UACgkQFHw5/5Y0
tyxwPAv9GU6V28WMgwtlflJpGMTHhHnQbvJ2CuChxW+k7rYVT5yCj4iI5Ryq/3O8
CmaSHtzGkHbAUJwo5Gj/lxuDkFL6KsHOCtTbBaJpTU+xMYynugVeIIIm5O5o5frL
NeEExkAFf0GQfXOZkZnk9mLwgB+hlKE27A8xFK78s/EB0XCdbg7+xQPAOn2D6kQp
QXOFQ4y++h8O89jZrrcnlaljIVb9PoPtftVIcXV1yICxLpt9C+uRZEOB6AOzqkKc
dZSbP3O1+dpkulhZ0B+e5mJKGnGlH9GscO9oSJpdTmn9VfVzXb6T4DfQ7/uF3yPX
zBmYJmryetRAyk0Akg26N38lxsOYrvaD50MnLOwPufpc8dn/LAr2+/J3JUffnK3l
gaeZXakIPWIrrmQ+1LlTqBBiLaibJ0k2bHlQ7HMPMg4R4wUhaeHcLcQURdCyWQ/B
tau4JZCFi+lSkRO1+zRjJaRC2djqUnryRA0yrh4nFAa3dqDMncYgd4VZOto/lODI
ezVBykmM
=ywKN
-----END PGP SIGNATURE-----

--2i4Lvgzg6NKebXZy--
