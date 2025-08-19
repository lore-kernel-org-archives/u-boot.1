Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A128CA0EEB
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 17:44:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23B3680FA1;
	Tue, 19 Aug 2025 19:44:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cAuaoRJK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFCC582E34; Tue, 19 Aug 2025 19:44:21 +0200 (CEST)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91085802C1
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 19:44:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-30cceb07f45so3659353fac.2
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 10:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755625458; x=1756230258; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=H2wYChsGNM7lcLkouaN9VDhhiP7QDzja+N7uHwLAkhg=;
 b=cAuaoRJKdDAL4c/i4WSkcv9oZo5QPmCNHvfBdKjjueDh3hySULQq1g3qK+4cFxXXie
 I/nxGamMY5KOYFdg3WnnUkTu0CYSHRiQyFxbqM+Vp8vJbIF7kt7N5RgcOlmM9u92bsQW
 7aRQAxvaknYuiEslXMxoZiF5MmAf+kHgSuYVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755625458; x=1756230258;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H2wYChsGNM7lcLkouaN9VDhhiP7QDzja+N7uHwLAkhg=;
 b=KlqOgLOYgf08Mx853oFuygwu3yNjQNxMSu9RFEhzs7BM5lB2yDFyqtC439DUjXBb9h
 ZMNJLgpdD4EUB4Jwx2p7R43rqW0wIaEvpBQM+d3PC6LZvAnm+1ZuIeZ3advuAg5BXlbu
 /j/z5WoW6qZQpc447UdA5UlylISNHpVNhVnkkNrTiKHGZ88LwFTFhuNVu74iNzk87BdM
 TJx6AG7r7x09PaZt6tvn2GGElVEbPuc9YSc2yBG59N0gy7uj9XacE7irBzISrQuj+mCL
 qcfrC0wFyGd0iBTGyEhfkQpk+yf6JZuBVhhqC8SwKCDnAoLmsBVu3F8ZzUCh07iofkQx
 9iKw==
X-Gm-Message-State: AOJu0YwFqqq5HT6cKETxxNjvgbSTRKaeCKAYXXQ1qsLumFvQYx3ATLHt
 W3q6toJmY3rplCd1Qogfo9vmuKXSM+YTug0sATQFmNicQFv+/4m1WC/hdkObG+qQmEjNfXjuTCh
 6NE+o8J8=
X-Gm-Gg: ASbGncvyS2uGiPK+fDFTDaNMrUuVB4FQ74B3DOWbgIylRjeHaRBm6CXUbdPARnmr1gG
 XcmHx+nLDP54dvw3PGhPkGorHuL3MrMnZFz/uZ4Whj8rCUo7wVvrQleWSlF6eUwSoDZhy5Yrz3J
 2TWL9Iqb+F9EMzI+HFhFxRKpoxIL6Tf9P42xjqksYgG/y3PPNv2WbswPaFkRfEyrFGRvhm9/0Ld
 sqc4gZ3hAhHvXvrYo350gPW5+y/8xZUPnq1wab6rRHrWR77CM2ZaVthB4g5KgAmGkawrv7Vr+tx
 V5S0UObXPXoCYUJhZSSCNHrMCaUi/MgJhFfv6NaeR9WxZIJGZb+KKPPtChH2n+IzjC9pZnRUvnG
 wYUDBHh1msM9t7j06omNK8KegXlv236uRjgiAQAJEySkUDHeSYq1neoWt
X-Google-Smtp-Source: AGHT+IE8kJH7JVM7kCsKT6hGozsmuBDHEfSLuuSYVR//q996E11t9sGg9byTu5vgziMRTQNJrg4dJA==
X-Received: by 2002:a05:6871:609:b0:2ff:9224:b1c8 with SMTP id
 586e51a60fabf-3110c46feacmr2719068fac.36.1755625458175; 
 Tue, 19 Aug 2025 10:44:18 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-310ab88051asm3596626fac.2.2025.08.19.10.44.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Aug 2025 10:44:17 -0700 (PDT)
Date: Tue, 19 Aug 2025 11:44:15 -0600
From: Tom Rini <trini@konsulko.com>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de, Sascha Silbe <sascha-pgp@silbe.org>
Subject: Re: [PATCH] boot: Add LEGACY_IMAGE_FORMAT to DISTRO_DEFAULTS
Message-ID: <20250819174415.GG124814@bill-the-cat>
References: <20250818165119.3193853-1-trini@konsulko.com>
 <CALeDE9PqJBA9gS+YaNjM605fH011wL1SyT8Odk_k2Lm_V9EHLQ@mail.gmail.com>
 <20250819145737.GB124814@bill-the-cat>
 <CALeDE9PXjSh9kySvOEc-4KDVp7dT+DUUQVYh7JUk2pS+vohe7w@mail.gmail.com>
 <20250819153522.GE124814@bill-the-cat>
 <CALeDE9Nt9j7Hq-C1Etxh5EpdD-r09+XYeafL=U4O5cV1rvejHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="486oMzOCa9sYrN6k"
Content-Disposition: inline
In-Reply-To: <CALeDE9Nt9j7Hq-C1Etxh5EpdD-r09+XYeafL=U4O5cV1rvejHw@mail.gmail.com>
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


--486oMzOCa9sYrN6k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 06:38:46PM +0100, Peter Robinson wrote:
> On Tue, 19 Aug 2025 at 16:35, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Aug 19, 2025 at 04:33:07PM +0100, Peter Robinson wrote:
> > > On Tue, 19 Aug 2025 at 15:57, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Tue, Aug 19, 2025 at 12:13:31PM +0100, Peter Robinson wrote:
> > > > > On Mon, 18 Aug 2025 at 17:51, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > At this time there are still major Linux distributions which by=
 default
> > > > > > boot using LEGACY_IMAGE_FORMAT type scripts. Add this option to
> > > > > > DISTRO_DEFAULTS to ensure these platforms can still boot.
> > > > >
> > > > > What is the legacy image format exactly? Does select make it non
> > > > > optional, can we use imply or similar here?
> > > >
> > > > In this case "legacy image format" is uImage-style images, rather t=
han
> > > > FIT images. And no, we can't imply it because then we'd break Debian
> > > > (which doesn't boot on a handful of platforms now which do have
> > > > DISTRO_DEFAULTS but don't have this).
> > >
> > > The distro boot stuff, which if my memory servers, is what the
> > > DISTRO_DEFAULTS is used for, never used the uImage style kernels.
> >
> > The same uImage-style header is what's on top of a "boot.scr" type file.
>=20
> The distro default scripts never used that either, the whole point of
> them was to move away from manually crafted scripts and custom formats
> to boot a device.

Maybe we're talking past each other now. If distro_bootcmd never would
have found /boot/boot.scr, erm, OK. But the resulting U-Boot image could
still be used by Debian (and I think others, perhaps armbian) that would
still rather write their own logic and set the bootcmd, and relied on a
set of standard features being enabled in any board.

--=20
Tom

--486oMzOCa9sYrN6k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaKS36wAKCRAr4qD1Cr/k
Cs8SAQC+j0M8p+TuDAD7BHh1U4BMLFngnvy+8i2eVteG0JxuDAD/TixCGY6vBd6c
7CQ52OV8xvY+X5tshYbdFPJZZhKz3w8=
=Ib1Y
-----END PGP SIGNATURE-----

--486oMzOCa9sYrN6k--
