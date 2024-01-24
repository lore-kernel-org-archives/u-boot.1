Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 864E8C47258
	for <u-boot@archiver.kernel.org>; Wed, 24 Jan 2024 01:32:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A331D8795B;
	Wed, 24 Jan 2024 02:32:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GTRD5+qN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F309D87946; Wed, 24 Jan 2024 02:32:48 +0100 (CET)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E52E28786C
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 02:32:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-5ff790d41bdso35497487b3.0
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 17:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1706059964; x=1706664764; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=P1QVeY4Htro0iWnhDl0U0R6hoVc+9t+h2wtxZsHL3To=;
 b=GTRD5+qNVw8g125h0laGnI7OwQEmr6K2/9k0Kj/bVab6iZNv6FkYY9vy005ncGO5ro
 ZlBmseCz1laQSi8kmkKLIgeuGKbt51xMBxiiGONIbaqQlihUMO2xhDeR5OLyD13ea2hn
 0zh4GGf09ajH4KJB0FuEHN0SibEl3PmDWjG1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706059964; x=1706664764;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P1QVeY4Htro0iWnhDl0U0R6hoVc+9t+h2wtxZsHL3To=;
 b=WCBOtMH0UPf/a8NuQCIXRD/7hZQfidiiuQw2Iqb/9RLGDqiE+qhyWDaOz6ayjXOh/5
 BvN7yphmkRbmQ750LOL0583XcwW2KsCaP7LHniojwJw2BCT/UISvQjl+LuHz53/RhJ4O
 KIaJb2NbnxTNiw73g8KnuYI6qwMPpqPXKhcjI1/7qvIHUQlYkgzsDpdPqhbuLZovAxsL
 sGhS4LtGYZVj9uxhYx7wPaumvSNKtKAKwRou8RD/6ZcYyuiRCSflATzt8j0f9eCcefoT
 9jHp4akBl/qsEoufpuII25ytD2zhYX9rcTDfHDcYj0LBA0eUvc9QqQ01FY6ZdqyZ2WS9
 kNBQ==
X-Gm-Message-State: AOJu0YwV/W98Y+Ps7/XyvC2HnsDujT2pwQhHiVXECH4eSOdYnLLAv7oX
 DjmsYuS+t9/V2aUGKV/fpYx+OCyqhPzEMeBcIdS5Lil6ccqgu5PKedsaicqnX1s=
X-Google-Smtp-Source: AGHT+IE0u4aTxfme/7w6KhOH7eSX+3sLwt4rsPb4UZfyiCpEarneSwhpvLsCQ0f/B1iE8WFR7NU8vg==
X-Received: by 2002:a81:4f01:0:b0:5f0:cbce:669f with SMTP id
 d1-20020a814f01000000b005f0cbce669fmr100801ywb.22.1706059964590; 
 Tue, 23 Jan 2024 17:32:44 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 r129-20020a819a87000000b005ffbb3031a3sm2553382ywg.74.2024.01.23.17.32.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jan 2024 17:32:44 -0800 (PST)
Date: Tue, 23 Jan 2024 20:32:42 -0500
From: Tom Rini <trini@konsulko.com>
To: Lukas Funke <lukas.funke-oss@weidmueller.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Lukas Funke <lukas.funke@weidmueller.com>, Bin Meng <bmeng.cn@gmail.com>
Subject: Re: [PATCH v3 07/11] lib: vsprintf: enable '%pbl' format specifier
Message-ID: <20240124013242.GY3652023@bill-the-cat>
References: <20240110091037.392520-1-lukas.funke-oss@weidmueller.com>
 <20240110091037.392520-8-lukas.funke-oss@weidmueller.com>
 <20240118202243.GF12635@bill-the-cat>
 <24f06dc6-2cb0-482e-abd7-d6c8196543ff@weidmueller.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7KplSCOI0m4kjRx5"
Content-Disposition: inline
In-Reply-To: <24f06dc6-2cb0-482e-abd7-d6c8196543ff@weidmueller.com>
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


--7KplSCOI0m4kjRx5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 03:48:10PM +0100, Lukas Funke wrote:
> Hi Tom,
>=20
> On 18.01.2024 21:22, Tom Rini wrote:
> > On Wed, Jan 10, 2024 at 10:10:33AM +0100, lukas.funke-oss@weidmueller.c=
om wrote:
> >=20
> > > From: Lukas Funke <lukas.funke@weidmueller.com>
> > >=20
> > > The commit enables vsprintf() to handle the '%pbl' format specifier
> > > in order to print bitmaps and its derivatives such as cpumask and
> > > nodemask [1]. This can be used to derive kernel boot parameters from
> > > bitmaks such as 'isolcpu' or 'nohz_full' [2].
> > >=20
> > > [1] https://www.kernel.org/doc/Documentation/printk-formats.txt
> > > [2] https://www.kernel.org/doc/html/latest/admin-guide/kernel-paramet=
ers.html
> > >=20
> > > Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
> >=20
> > This breaks building ARC platforms, and possibly others.  Note that
> > tools/buildman/buildman is happy to fetch toolchains for you, and in
> > this case it's also just the current kernel.org cross-toolchain. Please
> > see https://docs.u-boot.org/en/latest/develop/ci_testing.html about how
> > to trigger a CI run prior to sending v4, thanks.
> >=20
>=20
> Thanks for the input. I ran the pipeline on github and it failed for risc=
v,
> m86k, x86_64. The reason is the missing 'find_next_zero_bit()'
> implementation (actually it's faulty on x86_64). What is a good way to co=
pe
> with this problem? My suggestions would be:
>=20
> - Add a generic 'find_next_zero_bit()'. This would be the
> 'Linux way' and requires refactoring of the bitops header.

Yes, this way please, thanks.

--=20
Tom

--7KplSCOI0m4kjRx5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWwaLYACgkQFHw5/5Y0
tywMNQv/aP53Hdi0BmSi2QVJ1AuubGEjKkrdoJ8s8+UGhrQQMw7EZDIGg+MAIbIz
YVNU+eQiQrsRGfNRy8NlcC0F3/LHfb+94NA3jL4geNx573Y/fdraxohXABbXVft/
de4WWBDcI0hkiLr2rxjy4Fo+FW191wdkdkImo4q9ySApYOUpWIEZgzOY9dTelank
VbIj2Tco9lrqW3JRN/NU70QtQ+gdQXQgpMYwW1LbiNBZU6erFUrDFOKgyQDBEI72
MEU2meUIKlKCUX5/14UnOLnwSHYaXiKCcKrHIspt20VMVfswMXp2Jx+scMK1jFQX
D/FqqyyZetgm6V27IkiucwQaiP8HwY/P9ZwLEGNzlt1nEBVFRa86j/4DUypySv3i
Oq6DrHzSeAoIGnL9Da2P0WRuyUP5C4hgG97CqJiLdkhzLWvZ4HwZiS6NKd2b8ZQ4
Zp1AWyjJLJJpbx6kn9nYbxxqaZrX3BXY4zIGuH90kc6e5XtD/jqL0LtcEzW9Gt/o
UIYWb5Km
=iVp4
-----END PGP SIGNATURE-----

--7KplSCOI0m4kjRx5--
