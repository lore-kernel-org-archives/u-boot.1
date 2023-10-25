Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2879C0032E
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 17:10:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F9F786FCB;
	Wed, 25 Oct 2023 19:10:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PueXLCoi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6940986FCB; Wed, 25 Oct 2023 19:10:07 +0200 (CEST)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82CD786FA6
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 19:10:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-58686e94ad7so829941eaf.3
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 10:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698253799; x=1698858599; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7OLOb01mK8Mh3bgWpj68UuNpFzOxVAygGiCc2M9VkbU=;
 b=PueXLCoiCRkDIVs1q/fAQEvCW+r8csduJncyMbX12CbvHCyOFhkwgt3zIud5dbCu0G
 MEkK6KvEbCgYtV/zTbpYCPFUR6QYpDFDddtKj3V96I0+mFFJZv6iGNT8021LasLTdoZ6
 BHAlEGs7chYKS7iF7K1KR1UeW6SOX20AsFkZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698253799; x=1698858599;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7OLOb01mK8Mh3bgWpj68UuNpFzOxVAygGiCc2M9VkbU=;
 b=FtahWAAuIu6Oo56BiRRt2uQUalGKk7jVy+ooV/PVCRgT2QmnKG39GRcc1shvU94/+2
 r2fHuR6XXH/IKaAI/LoEibuWHt1avI5Wrn3eU4VenjYBT91btqfPl15k4OQzwTdnM11r
 PhK35xqTsfaezf/Nea7ftNVl6cm5JDDFVCkxbrwR0FcZRGKCaq1VYPoUeIV65mi3weRK
 IRa+Le9b6KSrLBQO6CmcjqHt3FWHxQ5a/L7jOO06zOdJLBXkaLXHFHc5vXGYG5YWGvtR
 c83W+WTPcefAVgL9JH1v8ysirmLSvcxIxxJU4JeSzos6UTHvQy705sxDHHINjj+D7Ije
 xb5A==
X-Gm-Message-State: AOJu0Yzn7cuo0gYCxbMdwNFmj3K0tiCTUCkWaL15XcYJum1HlnHQu/E+
 hKkHquQ7zMOoWYZ+yFO04wkGFQ==
X-Google-Smtp-Source: AGHT+IHM4+MtMeROVLJPhEqXclOTqslsV+mcPdf+SFFNaRsbbudFTXH3zKlboWBC0zKZoZ4a8OpfLQ==
X-Received: by 2002:a05:6359:6e8b:b0:168:e887:2646 with SMTP id
 ti11-20020a0563596e8b00b00168e8872646mr6413717rwb.29.1698253799441; 
 Wed, 25 Oct 2023 10:09:59 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-89e7-8c52-372d-17ee.res6.spectrum.com.
 [2603:6081:7b00:6400:89e7:8c52:372d:17ee])
 by smtp.gmail.com with ESMTPSA id
 dn26-20020a05622a471a00b0040331a24f16sm4395176qtb.3.2023.10.25.10.09.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 10:09:58 -0700 (PDT)
Date: Wed, 25 Oct 2023 13:09:56 -0400
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: sjg@chromium.org, caleb.connolly@linaro.org, u-boot@lists.denx.de,
 ilias.apalodimas@linaro.org, bmeng.cn@gmail.com,
 brandon.maier@collins.com, kconsul@ventanamicro.com,
 oleksandr.suvorov@foundries.io, patrick.delaunay@foss.st.com,
 sughosh.ganu@linaro.org, Mark Kettenis <mark.kettenis@xs4all.nl>
Subject: Re: [PATCH] smbios: arm64: Allow table to be written at a fixed addr
Message-ID: <20231025170956.GU496310@bill-the-cat>
References: <20231021004522.53311-1-sjg@chromium.org>
 <c4212389-6d0e-405d-bbc7-10c8278ba1de@linaro.org>
 <CAPnjgZ1Q4y1SvwMa3gRX6Xa=5gP7gTSiQfe83jQ=KQC2K=EG7g@mail.gmail.com>
 <87il6xqrso.fsf@bloch.sibelius.xs4all.nl>
 <20231024223405.GM496310@bill-the-cat>
 <87bkcmrdjn.fsf@bloch.sibelius.xs4all.nl>
 <20231025142842.GQ496310@bill-the-cat>
 <ab2be1cb-f185-4f4e-83dc-d318fd2ab30e@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vyoUZ3aVYRdsybJs"
Content-Disposition: inline
In-Reply-To: <ab2be1cb-f185-4f4e-83dc-d318fd2ab30e@gmx.de>
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


--vyoUZ3aVYRdsybJs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2023 at 05:28:10PM +0200, Heinrich Schuchardt wrote:
> On 25.10.23 16:28, Tom Rini wrote:
> > On Wed, Oct 25, 2023 at 04:18:20PM +0200, Mark Kettenis wrote:
> > > > Date: Tue, 24 Oct 2023 18:34:05 -0400
> > > > From: Tom Rini <trini@konsulko.com>
> > > >=20
> > > > On Mon, Oct 23, 2023 at 05:31:19PM +0200, Mark Kettenis wrote:
> > > > > > From: Simon Glass <sjg@chromium.org>
> > > > > > Date: Mon, 23 Oct 2023 00:04:14 -0700
> > > > > >=20
> > > > > > Hi Caleb,
> > > > > >=20
> > > > > > On Sat, 21 Oct 2023 at 01:43, Caleb Connolly <caleb.connolly@li=
naro.org> wrote:
> > > > > > >=20
> > > > > > > Hi Simon,
> > > > > > >=20
> > > > > > > On 21/10/2023 01:45, Simon Glass wrote:
> > > > > > > > U-Boot typically sets up its malloc() pool near the top of =
memory. On
> > > > > > > > ARM64 systems this can result in an SMBIOS table above 4GB =
which is
> > > > > > > > not supported by SMBIOSv2.
> > > > [snip]
> > > > > There is absolutely no guarantee that arm64 machines have memory =
below
> > > > > 4GB.  Examples of SoCs that have no memory below 4GB are AMD's Op=
teron
> > > > > A1100 SoC and all the recent Apple SoCs.
> > > >=20
> > > > So one thing to resolve here is where does that requirement about t=
he
> > > > SMBIOS table needing to be below 4GB come from (standards wise), an=
d in
> > > > turn is that obeyed by consumers like say Linux or OpenBSD? Answeri=
ng my
> > > > own question, maybe in part, https://www.dmtf.org/standards/smbios =
reads
> > > > to me like there's a v3 and maybe we should be doing what we need to
> > > > support / identify as that, if it doesn't have that restriction?
> > >=20
> > > Right.  U-Boot implements SMBIOS 2.x which is pretty much obsolete and
> > > uses 32-bit addresses.  SMBIOS 3.x allows for 64-bit addresses.  So to
> > > fix this U-Boot needs support for SMBIOS 3.x.
> >=20
> > OK, thanks.  And for clarity / repeating my confusion, at least right
> > now we also set the major/minor in the struct to 3.0.
> >=20
> > > Personally I don't see why we'd need SMBIOS support on non-x86
> > > platforms, which is why implementing this isn't a high priority for
> > > me.  I simply disabled SMBIOS support for M1 for now.
> >=20
> > This I think in turn (based on Heinrich's emails in v2 of this patch)
> > EFI_LOADER wants to pass SMBIOS (probably 3) information along so that
> > human user facing tools can see the kind of info that table provides.
> >=20
>=20
> If you have to manage a fleet of devices, be it Apple laptops, small
> servers or IoT devices, you want to be able to retrieve information
> about these devices like installed firmware, serial numbers, etc. This
> information should be presented by our SMBIOS implementation.
>=20
> Other EFI architectures (ARM and RISC-V) target the same markets as x86.
> The customers expect that they can use the same tools irrespective of
> architecture.

Ah, we do have serial# being passed along that way (as well as other
methods which is why I didn't think about them for SMBIOS). But this
also doesn't answer my bigger concern which is that we're setting our
version major to 3, our minor to 0 and then filling in a struct that's
not the "smbios3" one that Simon's patch from another thread added. Is
what we're filling out today semantically valid? I'm hoping someone who
has already read over the spec / is familiar and I don't need to go do
that right now.

--=20
Tom

--vyoUZ3aVYRdsybJs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU5S9kACgkQFHw5/5Y0
tyx3jAwAhwALWjVir06rSiaPeDdTlJ/4gbhdR6RdhJg95rmcsclSFrnisvssdl77
3KUm51U2CFt06znjdPYhATlhoPjBhzz2Ho+TcznB2zkewOwqWLjQz51HCTwrwsc8
pfIXTk54+L9JshfbXTccd8BKQTpcf+nZ/2ug1frMsFq7l1Z/cHUNeBPPca+UUGOO
ILKFwbJB6zUhrzqCh2g5nv4AqCFFiuPB/qc8eniIVknKNJeBuNjNzkJ30nhbt6el
KoL2NjmblX/qsbVVQffkfb+nYrqFHWZOaG5N4tT0nj2izxq7HCmRv5stlP1RlW94
w0xt2OqvoEcyy1/weX+g0U62aBnIDYJTWKw81mfdzuAc3zldmQbEDPHu1ABocqgc
NXBaBy8R5HeCD2+m2BNen1OEsElBUAZ7csXmv5vEiwCYXYHKkdtc39OJeeayIT1U
i1eNzNsinC3VbiwCX5y6VRM27ZwwDuhXEUBbK+LEoEbtu82LoIX64TS1aMBZxith
IMdxHxax
=JCQT
-----END PGP SIGNATURE-----

--vyoUZ3aVYRdsybJs--
