Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94307C07545
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 00:44:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9ED9E879E8;
	Wed, 25 Oct 2023 02:44:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rdDMrcmS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BB1D879E6; Wed, 25 Oct 2023 02:44:22 +0200 (CEST)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE86186EC9
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 02:44:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-778940531dbso316000085a.0
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 17:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698194658; x=1698799458; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SdkCsYCrTPHQItZeSwlHI7X316E0AOhyZ7tjiwSIzEA=;
 b=rdDMrcmSQS/dNYQlmiMzxw22TCF3EZY55Qs6ovItZo/OAw1IBGXK1baYDIO7VjbZDr
 FsUj2ZNKrh/AZ7Y9xxJYFpiSfVs6LW1h10O/d9S7AdUtucHxKKNcrPFClt5xdD+3eY9E
 rloblTcA3jQaZPE35jeVx6JexDJSbXLd62A/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698194658; x=1698799458;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SdkCsYCrTPHQItZeSwlHI7X316E0AOhyZ7tjiwSIzEA=;
 b=sBQbYgaq61oXw10CEpc6Hb9dcLSjmYlM6QEUDE1+aO+OghDfVDl7msFvUShnkA9dCW
 apEb3CLYkFtZIjDxz4fJZpL3TOham6KJc0viDAN2/fA+7r645RWB6i+GP32bRRgw5gMr
 U9OdARfWo0Q11jH9VKLqZteW/xyCa6bGtDIfoD0ObVVfFqLoA/Yqu3rQMmS6raT+BXd5
 wYy9MHwC7f2bC6ztTWNhhEOkGHlDXA6LbTeLVRMROzONU/liKXUqP/hp67Iw+loHSqdu
 8SQu2xybWZ7TMKRya7c4g32Ocxlcz8hYU8KOE5EZT9uY8QU646NHLVxixjRZy0QTpudV
 TGTA==
X-Gm-Message-State: AOJu0YzbHkDaA2z5tdARDcIanlEFwNaSAWahXCo7aQBtZn/DRqf2tKVF
 Di2n7iHdi/z7qTppvAaLqTGa8w==
X-Google-Smtp-Source: AGHT+IF1WJiWpn83y7xeRgAs8DoJsLFRsypsf1URAgHkRi6AjYP42xysAq/WSEo7Qgm+dPUyVftrXw==
X-Received: by 2002:a05:622a:3d2:b0:41c:b458:e90 with SMTP id
 k18-20020a05622a03d200b0041cb4580e90mr17524442qtx.7.1698194658610; 
 Tue, 24 Oct 2023 17:44:18 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-89e7-8c52-372d-17ee.res6.spectrum.com.
 [2603:6081:7b00:6400:89e7:8c52:372d:17ee])
 by smtp.gmail.com with ESMTPSA id
 l3-20020ac87243000000b0041b7f89ad19sm3896613qtp.53.2023.10.24.17.44.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 17:44:17 -0700 (PDT)
Date: Tue, 24 Oct 2023 20:44:15 -0400
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Simon Glass <sjg@chromium.org>
Cc: Mark Kettenis <mark.kettenis@xs4all.nl>, caleb.connolly@linaro.org,
 u-boot@lists.denx.de, ilias.apalodimas@linaro.org,
 bmeng.cn@gmail.com, brandon.maier@collins.com,
 kconsul@ventanamicro.com, oleksandr.suvorov@foundries.io,
 patrick.delaunay@foss.st.com, sughosh.ganu@linaro.org
Subject: Re: [PATCH] smbios: arm64: Allow table to be written at a fixed addr
Message-ID: <20231025004415.GJ496310@bill-the-cat>
References: <20231021004522.53311-1-sjg@chromium.org>
 <c4212389-6d0e-405d-bbc7-10c8278ba1de@linaro.org>
 <CAPnjgZ1Q4y1SvwMa3gRX6Xa=5gP7gTSiQfe83jQ=KQC2K=EG7g@mail.gmail.com>
 <87il6xqrso.fsf@bloch.sibelius.xs4all.nl>
 <20231024223405.GM496310@bill-the-cat>
 <CAPnjgZ1h2GUWKupVJcNEQmQd1JJf1h9X+xkc3P=+qxmfCwAcOA@mail.gmail.com>
 <5F047C34-685E-41E9-A726-6003B8FCFB56@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GA6wsdtGRRFUYetw"
Content-Disposition: inline
In-Reply-To: <5F047C34-685E-41E9-A726-6003B8FCFB56@gmx.de>
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


--GA6wsdtGRRFUYetw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2023 at 02:19:59AM +0200, Heinrich Schuchardt wrote:
>=20
>=20
> Am 25. Oktober 2023 01:28:10 MESZ schrieb Simon Glass <sjg@chromium.org>:
> >Hi Tom,
> >
> >On Tue, 24 Oct 2023 at 15:34, Tom Rini <trini@konsulko.com> wrote:
> >>
> >> On Mon, Oct 23, 2023 at 05:31:19PM +0200, Mark Kettenis wrote:
> >> > > From: Simon Glass <sjg@chromium.org>
> >> > > Date: Mon, 23 Oct 2023 00:04:14 -0700
> >> > >
> >> > > Hi Caleb,
> >> > >
> >> > > On Sat, 21 Oct 2023 at 01:43, Caleb Connolly <caleb.connolly@linar=
o.org> wrote:
> >> > > >
> >> > > > Hi Simon,
> >> > > >
> >> > > > On 21/10/2023 01:45, Simon Glass wrote:
> >> > > > > U-Boot typically sets up its malloc() pool near the top of mem=
ory. On
> >> > > > > ARM64 systems this can result in an SMBIOS table above 4GB whi=
ch is
> >> > > > > not supported by SMBIOSv2.
> >> [snip]
> >> > There is absolutely no guarantee that arm64 machines have memory bel=
ow
> >> > 4GB.  Examples of SoCs that have no memory below 4GB are AMD's Opter=
on
> >> > A1100 SoC and all the recent Apple SoCs.
> >>
> >> So one thing to resolve here is where does that requirement about the
> >> SMBIOS table needing to be below 4GB come from (standards wise), and in
> >> turn is that obeyed by consumers like say Linux or OpenBSD? Answering =
my
> >> own question, maybe in part, https://www.dmtf.org/standards/smbios rea=
ds
> >> to me like there's a v3 and maybe we should be doing what we need to
> >> support / identify as that, if it doesn't have that restriction?
> >
> >Yes that was my previous patch. However 1) we apparently don't want to
> >use SMBIOS3 and 2) my patch had some sort of bug so that it wasn't
> >read correctly.
> >
> >So my next version is going to be along the lines of what was discussed =
here.
> >
> >Of course, we cannot solve Mark's problem with SMBIOS2, but I suppose
> >that is obvious. Anyway, those platforms probably don't need SMBIOS.
>=20
> You are heading in the wrong direction. We need SMBIOS 3. SMBIOS 2 is
> only a fallback for outdated tools.
>=20
> Upcoming mainline RISC-V platforms will also have memory starting above 4=
GiB.

I want to echo this because yes, SMBIOS if I'm recalling things right is
one of those tools used to provide user friendly information about the
system, so "everyone" wants it, or at least platforms like ones Mark is
concerned about that have more human users than embedded system users,
would like to show the information.  Maybe part of the answer moving
forward is to allow being specific about SMBIOS2 or SMBIOS3 (or none) so
that the issue you had to fix can also be addressed minimally?

--=20
Tom

--GA6wsdtGRRFUYetw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU4ZNwACgkQFHw5/5Y0
tyzLRAv/SwHVAy7KoSnB1YW/qHoVbIjwl1qTe8YnXxfHxT3PlGuTSVSi8JGGoZpJ
Ly4WZQ2m3G2+lbBMhJDvNj1tKrET+CzugSNm9HEjttLdCpet2zbzZF79U+wZrQ/3
vfbrL5JCWbZ6h/qYrIGksvna2GJ/ood+I2WfOKFF8ekNk39RhRfSn9a90jUK56Hu
i03X1fEffnhu07rsEs13aSdQ4C16NF8dtCkwN7uBrKj25UcyYiRIbwRKhWb4PBVH
Kk5NpsL34KexdYUStONxQdW/YRDK8ssIu1yeYxjKBdnV9PYqAiNueMB/HexrNbLn
occc2x4M0R6FFpQZkclTgnfyaEBFgDbfREGBFEzgUGDuJOFoHMUoswopBuMxqqbc
vAg2zlKwE+VURhgWUyhnifGKYGXgds/FEvfzh/wEcoJTT40DId00TAepK381cTmq
Jx1RaA36YS8p/5AOsK+coU0ybg9xu42JBG1VhvUOLVf1F5F+nSfrqX0N90/IcefV
7c4u9evB
=wCUT
-----END PGP SIGNATURE-----

--GA6wsdtGRRFUYetw--
