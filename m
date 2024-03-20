Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42A5CC6FD1F
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 15:33:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67C6287E47;
	Wed, 20 Mar 2024 16:33:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JPIZcz4Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E913988063; Wed, 20 Mar 2024 16:33:22 +0100 (CET)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5CA587E2C
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 16:33:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-dc25e12cc63so1025659276.0
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 08:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1710948799; x=1711553599; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CuNTN76GhzyWPw1NOMANAzZqFxKhAS556Isa9yM2CEY=;
 b=JPIZcz4YpbdavFxHzal3DXA0TRqZWdLHNzieZiXRvYh1bq/vpdIWxIvsqICRvmXqqq
 l/Vqkq94llBOfwzryY4YNXAwzPVAtyyn0Myfe+ly8H9huRqzPz2FCiteHKo+TTG2XH8D
 glFkQ3B8dDs++Z3N0Ko2GxPldEoeDjgXy6jPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710948799; x=1711553599;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CuNTN76GhzyWPw1NOMANAzZqFxKhAS556Isa9yM2CEY=;
 b=hbNvhdQZ2eDDJFT0T9GET4Ddttlvo2RfuYdL/b08E0uHOYZp0kLhbCoiUVHZHPIGQM
 doMSanlq7aa6CeI2BnK4w1hVZ/HRBDZfRrKBLLZQMuRUBZumkl1a3JqZk/bTd4luYYLn
 Xi+AGd9frMgkLx5fPT/FDz8hLreCBQwrlYmSN6aKA/Lo9rRyZWXaOtWMJKBrBeGL4PuW
 sm+N25jprpiTv370qzqTMDVvSaZq5mW1p8lpgu/oZQvkbmolOiKNzVCJL5+K3rleEEpk
 +I9+vi7xU39oZh7A9Edwuk1hNUZLgmHA32GAkbw1CXCK2Vr7kQqadCpQoNxCaL0hspY3
 yedg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfdIUuZkP/0LbQJsI49CakyqBqm/KAg/GVjWUsS8DmWy6GjNgtlmYOYYI+bm8vt7nBWU1+UqICfkceb1N4Ui7J3roZ+g==
X-Gm-Message-State: AOJu0YxPWxpgxmx8sVa7QOGPM1tjKoyljfeAFTudBBFRkDBUIDzfDzCa
 5ZA8JHN5sRKYsl42NWEU0v5oufW6aU2yNBkOqFyWf7FiK/ETj+e5UaH2SDrQ424=
X-Google-Smtp-Source: AGHT+IGog2e1xFfWLM7Xm8KKd9il7s5SRMCEyju9oJS+5o/J3fqSDk8orR3NmpaQzGynzpDCnL3Bew==
X-Received: by 2002:a25:7ec7:0:b0:dd0:d40d:1c98 with SMTP id
 z190-20020a257ec7000000b00dd0d40d1c98mr164307ybc.17.1710948799603; 
 Wed, 20 Mar 2024 08:33:19 -0700 (PDT)
Received: from bill-the-cat (065-184-193-066.res.spectrum.com. [65.184.193.66])
 by smtp.gmail.com with ESMTPSA id
 u13-20020a252e0d000000b00dbf52d2844bsm2556915ybu.11.2024.03.20.08.33.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Mar 2024 08:33:19 -0700 (PDT)
Date: Wed, 20 Mar 2024 11:33:16 -0400
From: Tom Rini <trini@konsulko.com>
To: Devarsh Thakkar <devarsht@ti.com>
Cc: lukas.funke-oss@weidmueller.com, u-boot@lists.denx.de,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Andre Przywara <andre.przywara@arm.com>, Bin Meng <bmeng@tinylab.org>,
 Chanho Park <chanho61.park@samsung.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Marek Vasut <marex@denx.de>, Mayuresh Chitale <mchitale@ventanamicro.com>,
 Nikhil M Jain <n-jain1@ti.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Samuel Holland <samuel@sholland.org>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 1/2] spl: Introduce architecture specific init function
Message-ID: <20240320153316.GW3442575@bill-the-cat>
References: <20240320131928.1836386-1-lukas.funke-oss@weidmueller.com>
 <20240320131928.1836386-2-lukas.funke-oss@weidmueller.com>
 <20240320143048.GU3442575@bill-the-cat>
 <3866627e-de73-dbc7-fd8c-bb2b0d11b5cc@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="VQo2fpciTQT9tdOk"
Content-Disposition: inline
In-Reply-To: <3866627e-de73-dbc7-fd8c-bb2b0d11b5cc@ti.com>
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


--VQo2fpciTQT9tdOk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 08:52:30PM +0530, Devarsh Thakkar wrote:
> Hi Tom, Lukas,
>=20
> Thanks for the patch Lukas.
>=20
> On 20/03/24 20:00, Tom Rini wrote:
> > On Wed, Mar 20, 2024 at 02:19:26PM +0100, lukas.funke-oss@weidmueller.c=
om wrote:
> >=20
> >> From: Lukas Funke <lukas.funke@weidmueller.com>
> >>
> >> Some architectures use spl_board_init() in their architecture specific
> >> implementation. Board developers should be able to add board specific
> >> implementation via spl_board_init(). Hence, introduce a spl_arch_init()
> >> method which is called right before spl_board_init() for architecture
> >> specific implementation.
> >>
> >> Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
> >=20
> > I think this could allow for other SoCs to clean up their existing
>=20
> Does it make more sense to make this SoC specific then instead of arch
> specific to allow broader range of code?

"soc" and "arch" are somewhat interchangeable at times, so I think we
can go one step at a time here and bring in this abstraction and see
where everyone else is able to clean their code up to.

--=20
Tom

--VQo2fpciTQT9tdOk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmX7AbgACgkQFHw5/5Y0
tyztpQwAip3Hf04Obetc9wZdFdwmr96Hb396hdODDsfU60GnfvWVgCUrzXJW26jo
RjTcXT8rz/sE/yerq5scdsLpo9MGi7wfhL9jiqxtG+eJEgdFu8EGZc/zuOb4SF0D
v/baofLBAT/4rjjEGV3Z+L+c5PzCU4BupsPppKuK0nCHGoOqTKCuhx9MOgQ+VyLI
KRR1QsTKj81FGZpwuOdZhOj0sCSRDeAfXDhl/BtnAB34M21cGvTxytmFXvAeg+JN
AD2HtW4L4JBAAV550t9Zh2TwS452k5fjemfk+sVZVoMMRooI3kdQJyvELp7Lc13S
B9K0kuMwdxSbOm6ZqjWWyTqQC00YO8t6sT0cisy2ExsQBDLeV8s1wKuSF7pX2yGa
ACRUh2JZIC3FughfK4ERmfz1rNPCktGdKReGu+GeW2pMm3j3GXUWvOaEH5AkUBNJ
qD2d1x3NWTvK8TVWFaFjR1yxtAAK1SruL4b6n3EQ44wxE9gSgpyerkrg9f4F0rd4
zvwu7gu3
=Oejt
-----END PGP SIGNATURE-----

--VQo2fpciTQT9tdOk--
