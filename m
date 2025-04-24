Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3925C369AB
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 18:49:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB65881FDE;
	Thu, 24 Apr 2025 20:49:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gpk/UtI4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 796A181E14; Thu, 24 Apr 2025 20:49:35 +0200 (CEST)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D575819FC
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 20:49:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-604f0d27c24so700380eaf.2
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 11:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745520572; x=1746125372; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Q4ctwyIFHwC+ZvJp40IJD0nCZQca27rfWGmii47NElk=;
 b=gpk/UtI4ivbJT8cMXXXKFL9BNvzVNrhbC2JF5pCZDoR6Fxz/EpWpzwV9fVNg4Rk+Fa
 AVQ9SJgwAOSHcz5U51PNnwjLscL0P8LogbV5MIUBOF7Mhn+re+uuUNuJam9fVH7uCSso
 l1e0st0U0OsI6l0mNeZXq7CqV1qckxbomJvaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745520572; x=1746125372;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q4ctwyIFHwC+ZvJp40IJD0nCZQca27rfWGmii47NElk=;
 b=pMuD2Tjfb8Q3OYxGNZXfi0nXADtQcQqNa8nO2bIFukV36DuZxkNeuSiveNKNREu6Z0
 D1MVRUIUotimvf9SZOQPACa4YB+OnWxYvKWFzjYl4rKzOnMicV3HaG0xWrT8Hkl8EuiB
 XsuFqY1xDFlznX1yH4vn20zdpHMfSHcXFwHpK0D/ugzZlrRmDi0O7OcmhAW0GYq+QgJz
 UB+CqneQO3gqQ7decoNSiWJdgLmu/8nSE9tQNwaeLznqOmCMU4BZHPOnfi7/zj3VINm+
 WI6CDuOcsSIfLnyGkgHifcav7KENcmsT8RNTUKUKKDDLn9XNYKKwHmXkb0n0o1l5hEM2
 G+zg==
X-Gm-Message-State: AOJu0YxTJk9/yEygdjDp0rELVLfSkWL8FWgBtNKNwpqxsnf8FqB33k5j
 deEoAuOjkb1UalAYPZNtkSYpBRNey8NxN4OHz7XD3sT9uq2/LKStftk5jHf8r9w=
X-Gm-Gg: ASbGncuvnERDGRk/gX0PSXDljvp0Ok54cZKYfTlw38X5ZM8FImDDwj204bbaY61bRDQ
 MXMWdTil+ZDSj+2PSzYP2S+9JXrc9RguASZh9C6kPBpHSQmkACVOXGmAKJ7TDL4NZASre4GzA/1
 4TqMLRKQV69TO2tHL8RAfGvEJ1e0QYHHGmrm7PjxKoZ4g8GWpu5ObBTUlhhztIDJQjztL4C6mNF
 RtT4mF+o7S5umWJxVkoT+m5anBPcUVSpUP80u+OtK5G/tb5jArpF5rKv+L2DDYfJqijaSjT2DPl
 /T8vHWvJ9hnVwy2cmCT62zDAAclHj1pBjWIMTBzg3no0TZox2PtMBGbajm2RgiJMOqhkQk4CyOV
 FgA==
X-Google-Smtp-Source: AGHT+IFzxofwhfQ4M3Rg+Dx6K2Aehg7ha4rHu1KPtMleOKhzzLvkPCG8spTLO5QERGlVYH+OqB9e5Q==
X-Received: by 2002:a05:6820:c90:b0:604:6e6c:7229 with SMTP id
 006d021491bc7-6064fad5f28mr479519eaf.0.1745520572083; 
 Thu, 24 Apr 2025 11:49:32 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6064690dd14sm366017eaf.27.2025.04.24.11.49.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Apr 2025 11:49:31 -0700 (PDT)
Date: Thu, 24 Apr 2025 12:49:29 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] bootstd: Rework BLK dependency
Message-ID: <20250424184929.GN5495@bill-the-cat>
References: <20250423144913.3918472-1-trini@konsulko.com>
 <CAFLszTh9vzZS1m3xbQt7Ws06myLU2WUjA6U_3yRvfKQsj9ejrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="y9GhCctNCdfQaCkU"
Content-Disposition: inline
In-Reply-To: <CAFLszTh9vzZS1m3xbQt7Ws06myLU2WUjA6U_3yRvfKQsj9ejrg@mail.gmail.com>
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


--y9GhCctNCdfQaCkU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 12:30:50PM -0600, Simon Glass wrote:
> On Wed, 23 Apr 2025 at 08:49, Tom Rini <trini@konsulko.com> wrote:
> >
> > The bootstd code itself does not have any dependency on BLK in order to
> > build. However, in order to minimize size growth of non-migrated
> > platforms, change this from being "default y" to "default y if BLK".
> > This will make it easier to begin migration of platforms which do not
> > have any BLK-class device but do want to use bootstd.
> >
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> > Cc: Simon Glass <sjg@chromium.org>
> > ---
> >  boot/Kconfig | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> Thank you for letting this happen.

It's what I was asking you to do, FWIW. As I was unsure what part of my
message was unclear, I just went and did it.

--=20
Tom

--y9GhCctNCdfQaCkU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgKh7kACgkQFHw5/5Y0
tyxbRgwAmVQ0zh4FKjt1oCT8k4IqztvCCTBxirnHuysnxTSH2Pfgup2JAl0YtQf+
OaoYzcl8nNULRoKxueTgOc6uRW+qI9L/V2sQWYvfaPMT9sxd5q+fuppasnqpiyd9
1qq+4QZ2htE/7pfDd2LFh3YfqLYkvHKqPEjZuvAAa1wOpTXzwsdgjPnOgURYxy0A
QPLNXQDvLLKjXINNlzwW6T+/wToApgXSK0YJjmXfcY8rM4H7sdLmGuQ5ddVayvnM
fUYzEifU3+nmmJp1E9/3wppIkryyZ1DTi0oztdZCYNcP5Zz5qY+GHs3cKMV2GsPL
livfWF4A6lx9Nmg7swKL+fvgg10yUInzKZBgUFlX3kHpuTKRvXYyZQdv+3QPkg6j
zrze+o3y2DDxnSFfICuQ9dn+pPO36fuY5hAXuXQ8u98pO7Gzi4A/8q6TOoKiyJNP
+e/YJaL1A8I8zuFakExp/6OjDls4uUbBtz1CEPFmZ/mHx9DkeqshhkIPFG9hWLzJ
p1XodD7s
=0K/l
-----END PGP SIGNATURE-----

--y9GhCctNCdfQaCkU--
