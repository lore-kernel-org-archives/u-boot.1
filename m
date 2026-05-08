Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D90DCD342F
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 19:30:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37CAF84D2F;
	Fri,  8 May 2026 21:30:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="o/uSFEK2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C952B84D42; Fri,  8 May 2026 21:29:59 +0200 (CEST)
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com
 [IPv6:2607:f8b0:4864:20::241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55B1E84A6F
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 21:29:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x241.google.com with SMTP id
 5614622812f47-479ef2b7979so1873630b6e.3
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 12:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1778268596; x=1778873396; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ciJVLqJlfbE4RBM2SF8VLRzs3LgT6ke/Fjjhy8bpCd8=;
 b=o/uSFEK2aJrALa1lOmQIlkM0stcniNoBVWxVNXQvlO5CRmLPZ02I3Z6W93OPzwJ4iO
 bR1LhzHvy0b8DTkBlx/o7GXPrqQMwGywpIgXejfJKmzWT+uIqRC+ozBbB/8V1gaNshc0
 J8irWNZXRTln7gYt0/pDKdHzulEoYRHJsrwi0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778268596; x=1778873396;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ciJVLqJlfbE4RBM2SF8VLRzs3LgT6ke/Fjjhy8bpCd8=;
 b=XxNFq5AQW8gPSmk08DkTsYVEAd3/W0oIXhhNBWERvEl4K0sHXRpFKNNPk0Oz4lFvuo
 5IJtElHb2ky5oEuR6NlHLH8mvgWrlGCGAjvcwugTca5rb/8kgoBo1KlSeQVeZrUIs4kt
 VwbPJZ3sS7PaSY6KRfe7LbX4ZoqTZ9QBqNOeKR/edpv8LsZvhYQz/MHxgbtkuA7Avnol
 xA7QEXT2j5F/WENVcj1HpL8qvKn+aKNKaCJ4rbRfvElCL3iVGiJz/jzNdGXZMnnk+NYk
 qYSbQPsGTpT5vhmIWxdKzScsX/0FZv7AIZhDUVfWppHC6b6KYiqP9iKXz/POvf1rB3q0
 aS9Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ8isbI/6CCXpYvTCkU79FdLVqSTsUD3jFBf+oGkGURWeS5uQJdDTEUJyhBKRaHby8yeKcxSKzA=@lists.denx.de
X-Gm-Message-State: AOJu0YxWoj96xoG4oFY84HUWCTKsS1vzBsb6L4JJ8MASPyH5JsWmabao
 n8jxcJWI704WNTm/p8EMvBD47AfnAA9XO9OTmdzYoHO9stlyrlAb6wc3+UCDUv/X7Kc=
X-Gm-Gg: AeBDiev8fw/7ZYPJlTa4ASKO2p1zJ735wTbNLcAUwU5AAqvdvP/sNHPw7jHg/0DhWuF
 BHN4DM7nNwCI5IippDL4Cri65Acs4IXCCjMyvDm/HGcykoF2cFuLVFY3xeQzo7usU+m30LMbaxQ
 6BYdK47kgmQ6rNaj2aV/4RsIZnFYPngjcmpn8yxcgUCfhILU6HZgRpIOusWgKTEF7nP7qG7XTGR
 kLU3/lWkmNMc3caN+HEpag9/mjn55VUSRb2VeH0TUxWq9LA4VQbbk6UtBGACjWIgL8G+g0XuSdm
 DMAOhxIQn32PqNqIjAJt+6cezSNGlPOAsNKk5uSJtZqbAqk4naZ5agO2DOit54BSJKRy33qp/5W
 GE+ixRrs+yzE5bMWsdE4meMyoI87yfvB/lBo8cP+ols0ITiXjrzgQNb4hsbqDBPPxCsimt67JGF
 7Hg6BAjGCh3drBms2ZeV3A8xdGGRHvxQN8mrLd8ZoEwP/bTRx6NLjGZon1zM103tz89vM2M9ACy
 6bZV5vtmNCNXKM4XVNU2p6+cyUItoooMe69ToLUkWCIiYlmkGWTieMcKi93Gw==
X-Received: by 2002:a05:6808:c16c:b0:467:133f:ec2d with SMTP id
 5614622812f47-480424ccf30mr8554570b6e.42.1778268595976; 
 Fri, 08 May 2026 12:29:55 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-48061e6eb84sm3939867b6e.0.2026.05.08.12.29.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 12:29:55 -0700 (PDT)
Date: Fri, 8 May 2026 13:29:52 -0600
From: Tom Rini <trini@konsulko.com>
To: Daniel Palmer <daniel@thingy.jp>
Cc: visitorckw@gmail.com, angelo@kernel-space.org, bmeng.cn@gmail.com,
 sjg@chromium.org, u-boot@lists.denx.de
Subject: Re: [PATCH v6 0/8] Add virtio-mmio support to m68k virt machine
Message-ID: <20260508192952.GA1948090@bill-the-cat>
References: <20260505074948.2603870-1-daniel@thingy.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jOQIdhukY63zEr//"
Content-Disposition: inline
In-Reply-To: <20260505074948.2603870-1-daniel@thingy.jp>
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


--jOQIdhukY63zEr//
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 05, 2026 at 04:49:33PM +0900, Daniel Palmer wrote:

> Lets start making the m68k virt machine support useful.
>=20
> First we need to fix some m68k endian issues.
>=20
> Then allow virtio mmio driver instances to be created with
> platform data and fix a minor endian issue.
>=20
> Finally, add the code for the board to create the instances.
>=20
> v6:
>   - Remove an extra signed-of-by that go added by b4 or me somehow.
>   - Fix the warning about a phys_addr_t being cast to a pointer of differ=
ent
>     size if phys_addr_t is 32bits but the target cpu is 64bits.
>=20
>   CC      drivers/virtio/virtio_mmio.o
> drivers/virtio/virtio_mmio.c: In function =E2=80=98virtio_mmio_probe=E2=
=80=99:
> drivers/virtio/virtio_mmio.c:359:22: warning: cast to pointer from intege=
r of different size [-Wint-to-pointer-cast]
>   359 |         priv->base =3D (void __iomem *)plat->base;
>       |

We hit another error in CI now, with "allyesconfig":
drivers/sysreset/sysreset_qemu_virt_ctrl.c: In function 'qemu_virt_ctrl_req=
uest':
drivers/sysreset/sysreset_qemu_virt_ctrl.c:41:37: error: passing argument 2=
 of '__raw_writel' makes pointer from integer without a cast [-Werror=3Dint=
-conversion]
   41 |         __raw_writel(val, plat->reg + VIRT_CTRL_REG_CMD);
      |                                     ^
      |                                     |
      |                                     phys_addr_t {aka long long unsi=
gned int}
In file included from ./arch/sandbox/include/asm/io.h:257,
                 from drivers/sysreset/sysreset_qemu_virt_ctrl.c:11:
include/asm-generic/io.h:168:67: note: expected 'volatile void *' but argum=
ent is of type 'phys_addr_t' {aka 'long long unsigned int'}
  168 | static inline void __raw_writel(u32 value, volatile void __iomem *a=
ddr)
      |

Please see https://docs.u-boot.org/en/latest/develop/ci_testing.html for
v7, thanks.

--=20
Tom

--jOQIdhukY63zEr//
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaf45rQAKCRAr4qD1Cr/k
CtC/AQDXFkbR+o0Z1jQxrEq1NnUFk9aTmq08lQZ6eMGOQvxFvQEAtPKWWlM4faK4
okd5eM6OKznEYl8aLp0CvKvjyUWtxQo=
=KtMz
-----END PGP SIGNATURE-----

--jOQIdhukY63zEr//--
