Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B522DC0032E
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 14:29:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CC2887B09;
	Wed, 25 Oct 2023 16:28:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZQTgYzr/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3FD587B09; Wed, 25 Oct 2023 16:28:57 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF45587AFE
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 16:28:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-66d13ac2796so35411046d6.2
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 07:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698244124; x=1698848924; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pRomQ78ERDoo5vQJ0j92RJQYGgi1fsbf1u6YwnxqeVM=;
 b=ZQTgYzr/IG3ufQt0IkjrWJ9eDM4NRrCe4Jb7v6vbsjOzmYtWpj1AI9qAQ1oJCI1gtV
 TmhFT2VCv/b0v7PJ/GnAma14XNcGT3zOPR5RMhXyz3TQRn/j0K3XsVyhIB4bP1IUszCA
 zATgo1IlVGWxe/KOiWu7imu9RH8skMDkbqX+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698244124; x=1698848924;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pRomQ78ERDoo5vQJ0j92RJQYGgi1fsbf1u6YwnxqeVM=;
 b=RFV8dahpyGK8C1C+aFCN8dLqAxOjs/Yg7NKfrks0ZYMsWy2POCDMp/XU/9tsEv8ZCq
 KWFuLEmjli1nfEEubpa8CYYkmyjqnvXPZ3yBO2xNR2I4mz6rfUzIB11lD4b6x5scbFLB
 oWcspcBlGyOV5d6W7Oj58igfxorwEnCmI0vTcMgFAIOI6M3i2hJcrf5TF9iKtEYstALq
 5Bs4FZn5LaMm0f8YSIiP+Ne4S8TVrIHmTpz4y/gEOl/VaD9TnoQgIfD9w6MtFYXv81LA
 Y+7FSdQvyKVP3DC9fsmsiO78t68llRyDOZ5eSLmMPAx9V+TioPPE2l9ZXBepYEKjbeTl
 eMWg==
X-Gm-Message-State: AOJu0YwVIdOgzTteYIDnR579etoKcbfhT+jpfYM1f9NtOPO0GMw6vMDI
 ObKwMJJSgcRnZUd0+nHDoF6E6w==
X-Google-Smtp-Source: AGHT+IFllyknTdiA3Ihw/l95JwCy2/mygUy7Z4RT+fmLzwUE4znI3uck+mZ1w5wjY03+jsL3yZMRiA==
X-Received: by 2002:a05:6214:d8a:b0:65b:216f:2d65 with SMTP id
 e10-20020a0562140d8a00b0065b216f2d65mr18678445qve.5.1698244124496; 
 Wed, 25 Oct 2023 07:28:44 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-89e7-8c52-372d-17ee.res6.spectrum.com.
 [2603:6081:7b00:6400:89e7:8c52:372d:17ee])
 by smtp.gmail.com with ESMTPSA id
 cr14-20020ad456ee000000b0065aff6b49afsm4443808qvb.110.2023.10.25.07.28.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 07:28:44 -0700 (PDT)
Date: Wed, 25 Oct 2023 10:28:42 -0400
From: Tom Rini <trini@konsulko.com>
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: sjg@chromium.org, caleb.connolly@linaro.org, u-boot@lists.denx.de,
 ilias.apalodimas@linaro.org, xypron.glpk@gmx.de, bmeng.cn@gmail.com,
 brandon.maier@collins.com, kconsul@ventanamicro.com,
 oleksandr.suvorov@foundries.io, patrick.delaunay@foss.st.com,
 sughosh.ganu@linaro.org
Subject: Re: [PATCH] smbios: arm64: Allow table to be written at a fixed addr
Message-ID: <20231025142842.GQ496310@bill-the-cat>
References: <20231021004522.53311-1-sjg@chromium.org>
 <c4212389-6d0e-405d-bbc7-10c8278ba1de@linaro.org>
 <CAPnjgZ1Q4y1SvwMa3gRX6Xa=5gP7gTSiQfe83jQ=KQC2K=EG7g@mail.gmail.com>
 <87il6xqrso.fsf@bloch.sibelius.xs4all.nl>
 <20231024223405.GM496310@bill-the-cat>
 <87bkcmrdjn.fsf@bloch.sibelius.xs4all.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rIFGrRBvK+EkfcAf"
Content-Disposition: inline
In-Reply-To: <87bkcmrdjn.fsf@bloch.sibelius.xs4all.nl>
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


--rIFGrRBvK+EkfcAf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2023 at 04:18:20PM +0200, Mark Kettenis wrote:
> > Date: Tue, 24 Oct 2023 18:34:05 -0400
> > From: Tom Rini <trini@konsulko.com>
> >=20
> > On Mon, Oct 23, 2023 at 05:31:19PM +0200, Mark Kettenis wrote:
> > > > From: Simon Glass <sjg@chromium.org>
> > > > Date: Mon, 23 Oct 2023 00:04:14 -0700
> > > >=20
> > > > Hi Caleb,
> > > >=20
> > > > On Sat, 21 Oct 2023 at 01:43, Caleb Connolly <caleb.connolly@linaro=
=2Eorg> wrote:
> > > > >
> > > > > Hi Simon,
> > > > >
> > > > > On 21/10/2023 01:45, Simon Glass wrote:
> > > > > > U-Boot typically sets up its malloc() pool near the top of memo=
ry. On
> > > > > > ARM64 systems this can result in an SMBIOS table above 4GB whic=
h is
> > > > > > not supported by SMBIOSv2.
> > [snip]
> > > There is absolutely no guarantee that arm64 machines have memory below
> > > 4GB.  Examples of SoCs that have no memory below 4GB are AMD's Opteron
> > > A1100 SoC and all the recent Apple SoCs.
> >=20
> > So one thing to resolve here is where does that requirement about the
> > SMBIOS table needing to be below 4GB come from (standards wise), and in
> > turn is that obeyed by consumers like say Linux or OpenBSD? Answering my
> > own question, maybe in part, https://www.dmtf.org/standards/smbios reads
> > to me like there's a v3 and maybe we should be doing what we need to
> > support / identify as that, if it doesn't have that restriction?
>=20
> Right.  U-Boot implements SMBIOS 2.x which is pretty much obsolete and
> uses 32-bit addresses.  SMBIOS 3.x allows for 64-bit addresses.  So to
> fix this U-Boot needs support for SMBIOS 3.x.

OK, thanks.  And for clarity / repeating my confusion, at least right
now we also set the major/minor in the struct to 3.0.

> Personally I don't see why we'd need SMBIOS support on non-x86
> platforms, which is why implementing this isn't a high priority for
> me.  I simply disabled SMBIOS support for M1 for now.

This I think in turn (based on Heinrich's emails in v2 of this patch)
EFI_LOADER wants to pass SMBIOS (probably 3) information along so that
human user facing tools can see the kind of info that table provides.

--=20
Tom

--rIFGrRBvK+EkfcAf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU5JhkACgkQFHw5/5Y0
tyxKgAv/TSop7RyxSp8B3VuQ2hgOPA8XyvpYnCXwg+FK+Dr1lkckYcNSNZX/IPYq
QMFus+JK+lHt7EGy1oUqlDpH0JAEMXwFU/D3zTQDzvzVRGcKGF1jhetqwm/BKYfb
uz8hndSyIw2/qv4o1T7BidIM2LxI/mzAhlLO8N62tpRqCWgYyvKeY1/LnCNf4rNX
YyKguSqXQFrCuS51eps+2Qqf6bgH4gGe8H6Cil2sGDRqksC5JxgXUjg5puQ0Twj/
GxMwwJv5nrUzogrrwh07UBnMpiGiGsgAxyM+JQFp6tZ0xnRVTykI/URozcSrOmwW
ysU0mTIXOD6R1bnfujk8YIH8aTL4L2O7znxpwfHuhB9lbEfdSS+WUIGnM6t/neiH
23k4yQqXn5a6RzQ4xzB8udTu4eTHDIfok3XnbrS6iWBug+yGk5lSNiAeAMKo5MUS
VGpPshX+vmCkaHz/qE64DqknPihRc/8d0hOr39qYFp0sEey5xGT7XRYlswYwG1xA
C+P5mBf5
=5w6g
-----END PGP SIGNATURE-----

--rIFGrRBvK+EkfcAf--
