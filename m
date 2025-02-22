Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC54FC021B3
	for <u-boot@archiver.kernel.org>; Sat, 22 Feb 2025 01:04:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7610806FE;
	Sat, 22 Feb 2025 02:04:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PFvAp6kP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F5D980EC0; Sat, 22 Feb 2025 02:04:41 +0100 (CET)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9BF880017
 for <u-boot@lists.denx.de>; Sat, 22 Feb 2025 02:04:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-220c2a87378so47751295ad.1
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 17:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740186277; x=1740791077; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mJ5gSplvucY0jJ4jw4sP8PKIuDLqROhxNi61rpRtsz4=;
 b=PFvAp6kPWIgteFP+y4YmGBAftKaHhTZUgAb4yTZ7eJm5+DH3B/kpAb+No8pw+sxcIS
 Qsshk/ddkrgwcTjGAVnX72XyXUI55GwqBhtWAd9ZZJmdP/3AzO5u3iYcX/afwVm8/ui9
 eYtKE4Yv3ck46mj2PBniAALHT9GIytMNcMOjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740186277; x=1740791077;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mJ5gSplvucY0jJ4jw4sP8PKIuDLqROhxNi61rpRtsz4=;
 b=bIOdV3YvJwWilIdN704ZhkG+mFnoKGzqQt298JnRphEClH/CO52mfxWEevyPfxP5/y
 6qNoZacdMgIdzWnaTe0Vra20oPxR8Ckiy0BI91IiywDt18As28F8MGAuA3varYF8Qf4T
 ChIEqEDSY0RT74xztWs80uEeaTlwscLQhHNlB4RtSr7tBLkEVQfPi3DOGJPVjeFdMKF1
 AKEjbKVioFCD++x92kDn4J0Yiia4lx+ue7d2gxm0D9Eivmb1N7FDp+3+1e+WYq3Z9bZa
 xqQc6AiXX7gkaubQBxQ3gVAd9D8acT85MkAkre4Wo9epAp1pyT8NMoEe+rwIcCWd8hcG
 zXtA==
X-Gm-Message-State: AOJu0Yzwm/B3s/JNQPDlWS3/VOKFjxCXxAx8cajE/jCqiV5rB2DMqBhI
 8esaWQyQd3pBBfimx04X/zFbunOOHuqEWpVtlXIwCJrb+UgAbB21X8Fw0s/f294=
X-Gm-Gg: ASbGncscBc5xkHtnBgi5jChF748QfirIFupKDxohHs7HnPJnwJWIYK5tLghFpK6fTwS
 pyUQsEhfj0+GDiFxFlqy+2SeKVW8iW4l5nPMV6JlUStK16u7pJvlGZyCxfCEOn5bKDNjZRWWnwz
 HW2HGMzI5zZ3sXQDB6BLKr8QRsIb/JZk9xXJpona4fLHqdM6yoGi2O3Wceb5UJb2DfAgbtIWZA2
 e6nhErRBIEH7sEeszJbR3HJtGE+40jqw71RXbufjQA9ivtIWxNWMts6/zhLKylC8jP7OyMio+xK
 tOL6nd4cQmlMLfZNou3wgYar
X-Google-Smtp-Source: AGHT+IGqDXqNazohlog3zQmJleieVBIrdyh/iEpdD8WrFvVGXiExdJCR1xu7Mc/tA6JLzTYpb3v4Zg==
X-Received: by 2002:a17:902:ccc2:b0:220:c113:714e with SMTP id
 d9443c01a7336-221a10ea4fbmr75689965ad.21.1740186277104; 
 Fri, 21 Feb 2025 17:04:37 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d556f967sm142413335ad.162.2025.02.21.17.04.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 17:04:36 -0800 (PST)
Date: Fri, 21 Feb 2025 19:04:33 -0600
From: Tom Rini <trini@konsulko.com>
To: Stephen Boyd <swboyd@chromium.org>
Cc: u-boot@lists.denx.de,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
Subject: Re: [PATCH 05/12] arm: Support running U-Boot as a coreboot payload
 on ARM64
Message-ID: <20250222010433.GZ1233568@bill-the-cat>
References: <20250220205900.3127680-1-swboyd@chromium.org>
 <20250220205900.3127680-6-swboyd@chromium.org>
 <20250221010711.GE1233568@bill-the-cat>
 <CAE-0n53x0NdhoF=w0kEzcgjsgPF7a8R0-sVndemsT3e45PJkCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0OmwPH1Lxf+sEtKn"
Content-Disposition: inline
In-Reply-To: <CAE-0n53x0NdhoF=w0kEzcgjsgPF7a8R0-sVndemsT3e45PJkCw@mail.gmail.com>
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


--0OmwPH1Lxf+sEtKn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 05:03:52PM -0800, Stephen Boyd wrote:
> Quoting Tom Rini (2025-02-20 17:07:11)
> > On Thu, Feb 20, 2025 at 12:58:47PM -0800, Stephen Boyd wrote:
> >
> > > Add a 'coreboot' cpu to armv8 that looks for the coreboot table near =
the
> > > top of the 4G address space.
> > >
> > > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > > ---
> > >  arch/arm/Kconfig                     |  2 ++
> >
> > We can't really ask SYS_COREBOOT in two places, as unlike the kernel
> > everyone always parses arch/*/Kconfig, so we should move
> > arch/x86/cpu/coreboot/Kconfig to say arch/Kconfig.coreboot and do
> > something like:
> > config SYS_COREBOOT
> >         bool "Support for booting u-boot as a coreboot payload" if ARM64
> >         depends on ARM64 || VENDOR_COREBOOT
> >         default y if VENDOR_COREBOOT
>=20
> Ok, thanks. I'll do that.
>=20
> >
> > And then any of the sub-options that are imply'd by the existing stanza
> > in the x86 file aren't applicable to ARM64 they can be "... if X86".
> >
> > As similar to the work to make EFI payload be a more generic option
> > rather than x86 only, this too needs some thought to be easily
> > expandable to cover the ARM case today and I'll assume RISC-V at some
> > point in the future.
> >
>=20
> Do you have a pointer to that EFI work?

No because it's still very much in progress over in Simon's personal
tree.

--=20
Tom

--0OmwPH1Lxf+sEtKn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAme5Ip0ACgkQFHw5/5Y0
tyy7bwv/fVimTgmtQ8n+0CyP+SmgMQb43CwVUKOVfSQ2W5dQUkBMw4GP/y28NbEO
3URptz3/bKcTLmhrXgx6L9Nv5nuUaAzB29npWaRLBoSr4BIoSyzFa2uMKq2V96Hy
KCSrm3NnkicGOX+HGQkT/BqGZ2ktG9x9F/ol1vCSfxfJWtnygjnTGotztLV4FwgA
ALzFN0aY1P0iTagush/8C3nVKQ93Xbvn6qrUauE6aH/45hqKulSQY9Z5hv5haBPY
pz579n9qgClVtOXvtrqi1X8D5jPiAz1Im2LY9ssa5aExUFT1LkYFjC0xvoBGJCDQ
7lf+e27c2Gyk1HNxpmhPLs5cwAy68LkWO9fPNboD3ezSRSsMl6LmoZYOeGJ2/agm
vY5SQbyaGjrzZaqVaQJUZnmTR6jZHneFyTyvshOQWk6q7Fc3AwHEoCF2wv0VADlF
x9XsdAeKQGq8Tbnd1JjTzs+BY/Vd4LPAYt6felaHjWN633cCFeZcqBaKSpegT8xl
QXD3/AgJ
=NIxM
-----END PGP SIGNATURE-----

--0OmwPH1Lxf+sEtKn--
