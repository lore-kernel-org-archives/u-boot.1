Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D535EE69E95
	for <u-boot@archiver.kernel.org>; Mon,  2 Dec 2024 22:01:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33A0489492;
	Mon,  2 Dec 2024 23:01:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XVTKN5F3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32E6E894B7; Mon,  2 Dec 2024 23:01:06 +0100 (CET)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B1148937E
 for <u-boot@lists.denx.de>; Mon,  2 Dec 2024 23:01:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6d88d3d1eb6so28155796d6.0
 for <u-boot@lists.denx.de>; Mon, 02 Dec 2024 14:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733176863; x=1733781663; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=A05u+g1PmaXxuAUl95APw9MVdwH9giE8+k0ht5wltp0=;
 b=XVTKN5F3vb/zgZ0LFoyokgjgahFahQR5LRjNlPIHVLqiuYOJYu13M1oWm3XoAtTqzY
 wl7WxINRcrj4ku+YY/J4k1omZXmNPhqX4izBpq3EyBkwY9YpStcjKcnmqC8kwgeSCDfw
 BnzrA9ZE1L2RuthYih9h8Yq70WSoKerzkAHEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733176863; x=1733781663;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A05u+g1PmaXxuAUl95APw9MVdwH9giE8+k0ht5wltp0=;
 b=roPxhfvolAt4jwWYzPrRsuK9DvEGOlGQg6lIAGMX8Q44EQ5wGxEK+V0tODT4qZk0an
 NGg3vMvbZzrr4Bz2ZpdJ5iEZe+i/YS/Ta37tnY39txmTUnsCosskiNuOQahwaZ0WS7Fr
 lKzjXcIbQTVTyxpnDLduuyhgZh2iykxZ2tTCuBQqGXHVy+i+nXUmZ8AAwxbtIyr8HzjO
 vXnF4YdXcdODdPx3hYSuVhHo4KB/9UFVhyNz9lVbTCFbXlfWQOIuM5UQTDvISWeGLaI3
 HniWNWYmstGnSvD6QNYLdbGsDlYAu6RueATJktvDTWdv2RZR+mfQ+16/o9uSf3E/MCHI
 iuJw==
X-Gm-Message-State: AOJu0Yy7+Z32hScJB5h/21t3TXcRKKs83D16+c6thsMmRiDW6ubPGIU6
 k3J7yGmRAF4wS0pjRA970ddT+qwrf0qEAVAp0OW3uk2g7azCMoOST26oTkteECc=
X-Gm-Gg: ASbGncsi5z1BQVxOM0g1qHWJbinU9YaPSvoArRBIRecImu37SgTyozyKBbvLExq07pL
 s/qsSSGBzwszKSe22s4rmFhXyRj2wZIT6cQxY1Acg+5B4ZG1wkdm6F1T2fKLxP5neC+ZA+leQ34
 aG35kEYBnJ8EC7wElSOM0GapzjlBFZH5N4VV4V8Sny/wH5dJ2t5voZSzyIW6wTaiH74NS/VZ00A
 YSOEuLgn4JO8FOfuS+9ITCwmZKAGC9+hGfQ069YKcZm2J5AXA==
X-Google-Smtp-Source: AGHT+IHwPcvjWdZgGFjyuB5h+6wYLnIsYUWdY1K/+pOsTFZKCA+3TynWOy7a6PR7wGPc+ly9h5WJsQ==
X-Received: by 2002:a05:6214:29e8:b0:6cb:fa3b:d6d1 with SMTP id
 6a1803df08f44-6d872957f18mr335152746d6.7.1733176862706; 
 Mon, 02 Dec 2024 14:01:02 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d875221e2csm53562156d6.108.2024.12.02.14.01.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2024 14:01:01 -0800 (PST)
Date: Mon, 2 Dec 2024 16:00:58 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@arm.com>
Subject: Re: [PATCH v5 5/9] efi: Drop the memset() from efi_alloc()
Message-ID: <20241202220058.GJ2457179@bill-the-cat>
References: <20241201152815.1668093-1-sjg@chromium.org>
 <20241201152815.1668093-6-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2V3R99cBmld942lD"
Content-Disposition: inline
In-Reply-To: <20241201152815.1668093-6-sjg@chromium.org>
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


--2V3R99cBmld942lD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 01, 2024 at 08:28:07AM -0700, Simon Glass wrote:

> From my inspection none of the users need the memory to be zeroed. It
> is somewhat unexpected that it does so, since the name gives no clue to
> this.
>=20
> Drop the memset() so that it effectively becomes a wrapper around the
> normal EFI-pool allocator.
>=20
> Another option would be to drop this function and call
> efi_allocate_pool() directly, but that increase code size a little.
>=20
> Move the function comment to the header file like most other exported
> functions in U-Boot.
>=20
> Comments were made in v3 that another project uses memset() when
> allocating memory, but that is not required by the spec. In any case, as
> above, from inspection, none of the users need the memory to be zeroed,
> as they fill the entire region with their own data.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

I thought you agreed to drop this because Heinrich or Ilias was saying
they'd get the spec clarified to say it should be zeroed?

--=20
Tom

--2V3R99cBmld942lD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdOLhoACgkQFHw5/5Y0
tyy9dAv/VjceJfMOfiYOrou/jfs7JtZR7sRNqcSsdvb0aS7pQNKUxGr0sL7NaL/k
acGh1gcwdZxPVvG7zWbnpgyRw8xNQwwP3URtpZzsOIhvMVaOOTaI0LHKZYroiQd3
FM000ntM6NoR+AAlLC++8B/wYgH+CXomR4uoxUFelQdhkRN7KXEU9th4GFl5Ke7o
PVfzVyynlQl8VPjeeb0eFU8Zxa3i4Ab2Ptoz9Mz6dtz4JGiACGswhx4pmvoXc9of
pFWQqZlSLsGYUId8N9JGehaQVhxx85FvPBNSzhlJF3T+VCiFMU++EwSiJrPGF703
3e89sZ2JzaNQL2aaTyu+XQyxSeVU2lIosD85tb0b3Tr5r/wOsny0sO8VPS7oFw66
J8FJByLTpgWEN1mDiGCo0Z4z2twfqn1OtI+0QLEIRl2IcNX7F3lhGDs3DuNQtgMy
MMqCMUVogwYts/u3VAN+oECKrBIo28jbbe4ImNhpOtL+4bvQ8M/VHsCO7zfbO6eJ
Jfld2pnY
=t+kA
-----END PGP SIGNATURE-----

--2V3R99cBmld942lD--
