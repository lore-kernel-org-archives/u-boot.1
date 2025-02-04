Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E08A9C02192
	for <u-boot@archiver.kernel.org>; Tue,  4 Feb 2025 02:14:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20BB8800CF;
	Tue,  4 Feb 2025 03:14:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dlmXaPVt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36D13801FD; Tue,  4 Feb 2025 03:14:18 +0100 (CET)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1041D800C1
 for <u-boot@lists.denx.de>; Tue,  4 Feb 2025 03:14:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6e24859f0c5so44466996d6.3
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 18:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738635255; x=1739240055; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=59dUM9uODEqliAi27F1zF4S0G8uSPm74913P3b3x8qA=;
 b=dlmXaPVtxdzo7oPHz0ZdDIY+tXCF7c8MoIYvAWCfxdhg8yQN4PxPBPdmwpfvq6u5/D
 ilRPfSdJeqAWd/whTUWq08PFByoOlvQXCkPmifep1Pai1NAfECKFEQXM4nRHQ11mMDft
 Cz/enOteTW9eQ07sXQ7DH9oZwgJFkgt/Nf3iw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738635255; x=1739240055;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=59dUM9uODEqliAi27F1zF4S0G8uSPm74913P3b3x8qA=;
 b=RmfFpNhetq1bEa0Cc3mKXph2AZIYdK7QdG9oFcuXGBTbRPgAjhHBkvEYLmLlXmIjv8
 eRIhLiWnmq9MuVPEp1/3iyIDkgPoYEjAAuboD/tJR/y1NI6MaoPpyQO5fnPz6c2ba5DG
 ya2y8NBdZDkfruisynY3zo239sIl3o/V/FqGmc+2L5iz5FArA1/aX/H+7lBroprNSnaj
 9ilUPINvJ1D43aFFEA6FCAW2ob7i8VtNxT+2YIQq0GA4q/dXTmI00S2LEm3C25aMMwEE
 AL1C5ujdNKJTyenrGLrfOCyhQa3uQejHkQnXx3IIh/gHLZ3QLlFhIfJC20mIbevd5csh
 h4VQ==
X-Gm-Message-State: AOJu0Yz/E/DUHwI230OBoPu0CPnJgXp6MB+hb8ZWSkU2OjtKUiLC98qo
 HCRlrNrdxZO2jTRVqwp/AfbEfW2VQSlg8osAgqzFdgI4s7+amUcBWhpGAn7hCXo=
X-Gm-Gg: ASbGncsd56vQT6eGTUo/gZqwXsHQarX/1vJPmlxJ54EaM1wL8yOaYibUPq1gctQw9zb
 M6lF7j7hCwxxUY74iZvXPa/+5sgtC3SGYNI44GTa642l7ISjLvA7otzFI3Shp/PZBo5iR+bnXgg
 JWBJOQtLsmVOqrQ+GKWdR18eMIZX0cABMABN7fWvEN9YnWhn0rK7MhpjOQxaTsNG90NjfM0JulN
 YW/1TIzAO6HRlhG5CIHx9sNyYIDo/w17K/IeRwPH3SNHbgOXBEJwpNPj63cn24trqMVj+CO0mUk
 0W6Pd4LDDs+vocY=
X-Google-Smtp-Source: AGHT+IHMlRvrVXJ34ePj6V6zwOuIZo29RQf7DxypJ76TtzrawYJZnh8G4IrQQlrpNT+ces7TUwq8Eg==
X-Received: by 2002:a05:6214:5004:b0:6d8:7ed4:336a with SMTP id
 6a1803df08f44-6e243ca746amr411807276d6.31.1738635254800; 
 Mon, 03 Feb 2025 18:14:14 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e2548143c4sm56751646d6.35.2025.02.03.18.14.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 18:14:14 -0800 (PST)
Date: Mon, 3 Feb 2025 20:14:11 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Caleb Connolly <caleb.connolly@linaro.org>
Subject: Re: [PATCH 31/32] efi: arm: Simplify the crt0 file and update link
 script
Message-ID: <20250204021411.GE1233568@bill-the-cat>
References: <20250203174245.1331464-1-sjg@chromium.org>
 <20250203174245.1331464-32-sjg@chromium.org>
 <20250203201036.GT1233568@bill-the-cat>
 <CAFLszTizPJX0pQs9UG7trXXfUbU9CnMzjWOQPMPLx_aeiaqsDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ai31BhAGAANGhgFA"
Content-Disposition: inline
In-Reply-To: <CAFLszTizPJX0pQs9UG7trXXfUbU9CnMzjWOQPMPLx_aeiaqsDg@mail.gmail.com>
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


--ai31BhAGAANGhgFA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 03, 2025 at 05:38:16PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 3 Feb 2025 at 13:10, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Feb 03, 2025 at 10:42:24AM -0700, Simon Glass wrote:
> > > We don't need to manually add the PE header, since binutils has suppo=
rt
> > > for this now. Remove it to simplify the file.
> > >
> > > Set the link-target to efi-app-aarch64 so that binutils knows what to
> > > do. Add rules to pick up the arm64 files.
> > >
> > > Make some updates to the link-script for arm64, so this all works:
> > >
> > > - Pass  .hash .eh_frame and .reloc sections through to objcopy
> > > - Put RELA pieces into a single section
> > > - Put linker lists into .data
> > > - Embed the dtb
> > >
> > > Note that it does not seem to be possible to use this approach with a=
rm,
> > > so this is left alone.
>=20
> Thanks for looking at all this stuff.

You're welcome.

> > Did you mean x86 in this last comment? I'm not sure about the rest,
> > either way, so I'll leave it to others to comment on that.
>=20
> No, I mean 32-bit ARM. For reasons I don't understand, it seems the
> toolchain doesn't support PE on 32-bit ARM.

Ah, OK. Were other parts of this series really laying the groundwork for
EFI_APP with 32bit arm?

--=20
Tom

--ai31BhAGAANGhgFA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmehd/MACgkQFHw5/5Y0
tyxZeQv9FoctZOQQS6yzKQmkOPz/yg1scSdhuaKyiq6BkxXHJqxtGH6wN2QgQyy7
tuGgnESbFd9jaslxgngwR9pxwjUzuWFPrGF3CWr5drVwh+mWzVuxczDQa+R/Uxtt
IGZGHxq1Eb49Yx5PRhDjEaUSn5z7csqKDXY9/JiZUmjnTVMvH8sazELmLsLAlCgQ
DptcTT6zw/VZi8QAbRwhNSRuyLgeAvlF94DJVsczl9IVhUlcafxIp+c4CS9ggvcc
GWeyXD/IY0IL6eVtehyDOVotK56uCAvwVnRTCOheen6L3WiQByxJGq+i4SWnbbIg
eNd4pEw6IUgFdXCkuGLcp8BDwrypnKqrd9LAX2E4B604XPvHMRZoh+T5SQtbHDvt
RXcv4D7RicklmiP7osXVw0TnNnQtGFMvE5bUX/Wn5oJ8Qi3oaslHwusaprak56Vs
c9wGLeSIt8862KMJ40FcHREQQyrQpE63tzVIYZrbTI1owLpqrejw2VnsdvgaHLW9
mjSqIINf
=h+Du
-----END PGP SIGNATURE-----

--ai31BhAGAANGhgFA--
