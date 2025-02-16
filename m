Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0C40C02198
	for <u-boot@archiver.kernel.org>; Sun, 16 Feb 2025 15:04:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AD03801B0;
	Sun, 16 Feb 2025 16:04:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MVAKEE21";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25693808B6; Sun, 16 Feb 2025 16:04:05 +0100 (CET)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7A0580104
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 16:04:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-220c8eb195aso74075515ad.0
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 07:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739718241; x=1740323041; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XxEuIgte5M4M1HSvcghSYJxdio8ulKzx6kFZ1ZAaUXY=;
 b=MVAKEE21q74+WcHT/RZuceF0sES9dVSYYeLBJEw4KAJvbS2wIotpRUEnBVt1FDn2aX
 X0tZCpSDKWAMWAGqt7bnNoZCC99ETTpRhvxJbthJzg5wqz2WIUfnzXlBXlUAlity8fEo
 zcrqMRTDkI7M60ptGCLfjJW82lrWJKL2rgMjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739718241; x=1740323041;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XxEuIgte5M4M1HSvcghSYJxdio8ulKzx6kFZ1ZAaUXY=;
 b=lJ28gzGpA17zKs0asZwieNyYi5E6Wr3WEawvfvBDKFaOpckF0R3nfM6hXbBw6vB/3d
 XoG3Z/OGjAQ37X7j9WZEHTokA+uv6Y50JUjWB6OugJPBSyubWTVvyKi1LkZu4RXblQ30
 X7++SJNR6+qEY/+YwZl0MueA+w0mb4JZl2xQjEZiu0XPhbNxiXLbvere+q84Jucabwsf
 BLmgENcZh0tPu2TjAbZF586msOB9hIUQKSSkNcCKN1wXMjykI6yGYMNCSKdPSCDBlmga
 B4PSJO6Oe4QQ4DuWrj56RtO+HN7akeXT0TMHoclYRtEhGvdQmaQmoO3AIz+ABjWW8ncG
 lM9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUc7M9Z2xec1N1veyogUckmAgPlI5wWGpx35eCOu/U9cmjzOJfFGVXkgdCxdYH85XJxPK5ztgc=@lists.denx.de
X-Gm-Message-State: AOJu0YwX7/H31xr3P859TeiY9f9CSetODaypX/BlHjYBitr+rClwsljE
 l+M/CGE2eCK2whBp/Oq0ltzNavSY42JYuaAu4bwY2a0YiUJYbwSk+CbK0skjfBA=
X-Gm-Gg: ASbGncsFz+nH45akK5nFFTUwb0IHmXHy2rj8fgPGB3BP9eoTTzS1MjlnRkdE/eKTudD
 jdPqCIvbGWMrtX28PWYpdz1CJ/L0M3fO8oP2rZ5CqaX5o2QRVtZlbfHTGQktE+kWJhZ0KdtV3DN
 Q+4baMCfbSldZu3JJUbYkYvOQvoHWYm8grcvmQgFGj2skUKuXM0BQorPXwPwB0ZfcpuuAcpn3r9
 nMn4NiDjNzshdbwlX1veHGibAD8PcbAviCil/b8045UMBhRxY8kDzgEA7xp0RijmyQso4qWP0Xr
 tLPN/2rF9NHiJA==
X-Google-Smtp-Source: AGHT+IFpCuivxkdjbbBCuaOqHp6na6o58ea3e5ZrBbM8sWL8dpTqThxWvEnY15KqO4AC0wo/BPE42A==
X-Received: by 2002:a17:902:e5ca:b0:220:e5be:29c7 with SMTP id
 d9443c01a7336-221040bc327mr104959325ad.39.1739718241300; 
 Sun, 16 Feb 2025 07:04:01 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d559614dsm57285285ad.256.2025.02.16.07.03.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 07:04:00 -0800 (PST)
Date: Sun, 16 Feb 2025 09:03:58 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH] Revert "efi_memory: do not add U-Boot memory to the
 memory map"
Message-ID: <20250216150358.GY1233568@bill-the-cat>
References: <20241112131830.576864-1-sjg@chromium.org>
 <CADg8p96cKqSEmZWLaOV1-onUwT4uwBp11=t4K7tmmPwZ-6UvXw@mail.gmail.com>
 <CAFLszTjw8ihHESoDk0RE6+00idN4Y-7=72NbUp+yOqpyCYqexQ@mail.gmail.com>
 <CADg8p97KQskghmGR+mv-AUVSAyCJ02DRzCbfHsZjGfEYbb+skQ@mail.gmail.com>
 <CAFLszTj+sxM+RrCvqq5i9_pOqjajm1V2U=egEfGS9nAfo76BSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="h4saG32hcQxhA8/1"
Content-Disposition: inline
In-Reply-To: <CAFLszTj+sxM+RrCvqq5i9_pOqjajm1V2U=egEfGS9nAfo76BSA@mail.gmail.com>
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


--h4saG32hcQxhA8/1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 16, 2025 at 07:50:48AM -0700, Simon Glass wrote:
> Hi Sughosh,
>=20
> On Wed, 27 Nov 2024 at 04:48, Sughosh Ganu <sughosh.ganu@linaro.org> wrot=
e:
> >
> > On Tue, 26 Nov 2024 at 21:09, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Sughosh,
> > >
> > > On Thu, 21 Nov 2024 at 00:53, Sughosh Ganu <sughosh.ganu@linaro.org> =
wrote:
> > > >
> > > > On Tue, 12 Nov 2024 at 18:48, Simon Glass <sjg@chromium.org> wrote:
> > > > >
> > > > > A bisect of Ubuntu 2022.04 boot-failure on qemu-x86_64 resulted i=
n this
> > > > > patch. I am not sure how to investigate it.
> > > > >
> > > > > The boot hangs at some point during booting of the install image,=
 before
> > > > > the Ubuntu logo appears.
> > > > >
> > > > > I will sent a series with a script showing how it is run.
> > > > >
> > > > > This reverts commit a68c9ac5d8afc51c619c5d3e865fcf147bea90cb.
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > ---
> > > >
> > > > I did some digging into this issue, and it turns out that the revert
> > > > is only masking the real issue. What this revert does is mark the
> > > > memory region occupied by U-Boot as EFI_BOOT_SERVICES_CODE. The x86
> > > > kernel seems to mark memory regions other than
> > > > EFI_{BOOT,RUNTIME}_SERVICES_CODE as not executable -- and this is
> > > > precisely why this crash shows up only on x86. The actual cause of
> > > > this issue is in the efi runtime functionality of U-Boot. The kernel
> > > > is calling the SetVirtualAddressMap() runtime service function, and
> > > > that seems to be calling some of the boot service code of U-Boot,
> > > > which it shouldn't. We do not get the crash after disabling the
> > > > ConvertPointer() and SetVirtualAddressMap() runtime functions.
> > >
> > > OK, so what is the solution here? Did you send a patch?
> >
> > I am trying to check if the installation can be done by disabling the
> > ConvertPointer() and SetVirtualAddressMap() runtime service calls. If
> > so, then I will send a patch which disables them temporarily till the
> > actual issue is triaged and fixed. If the installation does not work
> > without these runtime calls, I would say putting this change in with
> > an explanation of what is happening (similar to the above
> > explanation). Please give me some more days, and I will let you know.
> > Thanks.
>=20
> I forgot what happened with this. Could you update this thread, please?

After much further investigation to understand why the revert worked,
the revert was applied with a different commit message.

--=20
Tom

--h4saG32hcQxhA8/1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmex/l4ACgkQFHw5/5Y0
tyyIAAwAsx0dW61+CHD5oqPz1imsaUW2XMpmogtwBGOPPPS6dBzfGV+pqUfCjHpk
UG2Rr7CkyTgtMhSNpCejkNEGIm6aHvNHdDQZ7y7+nhYhlfo/i55nIeRNClT2d2tR
ArdnxGOyGY0i65GjCql5s0Hlqye/RdDcocb2HCCIl5lUr/CxAaVxyYY2Pw3khmIX
jArd64J2nnxjpVBSGpRDctfQQ6ItGXab0ZUHOzygsObw6BRdfoVr9cd3QUXLVTG7
fz4GxQzZ9+3g6GG466sV0mMLmyI95VNjNkWW9ZmCQgrMphdPWGw96bAiwGai7WhX
DSsWH0ZHfqz7cnUeKhFFDDDsJVIvim96J2BZpYLAfprFj+jXmfqaeKipHOxLt9MC
QbOIAq4aUcthFahykrGcdlPLgS9nyQVYKu0NpRCLw9VXb/6vD+l8MeE07xAD6eL0
1xFhAUQW7lGwyz+dJJ3lJg5tionQ7J9YB6uLI7AE/9Uye8BDaDTNyqzeRjuS0aHH
Vy1E52iV
=V7Y1
-----END PGP SIGNATURE-----

--h4saG32hcQxhA8/1--
