Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AA1AD374A0
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 14:25:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0F498900B;
	Thu, 17 Oct 2024 16:25:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qqDXS/lz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5A6C88FEA; Thu, 17 Oct 2024 16:25:49 +0200 (CEST)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 710028900B
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:25:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-460a4f36e76so3926611cf.3
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 07:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729175144; x=1729779944; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=eAZ78N9F0LAKxv4d7ViEmF2g8vLM/b+P0VttYXACAHU=;
 b=qqDXS/lzTEDjV7S5OwMPX+owpVadcCNyr9K7VXso29Y+uthpKcfog8wp09A0ENV1tY
 7SAtek4IOf61JBU9xTSI24vm+Az5NkBNXv3kNtAA8uclaX5/o078aT00N67B6q8fJJCn
 jUNiXqp/8xZJCKpqxX2vnHSnE1j4SLwgnmbKY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729175144; x=1729779944;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eAZ78N9F0LAKxv4d7ViEmF2g8vLM/b+P0VttYXACAHU=;
 b=Zx1cVKYJh3V+IEZJcrhmSpXOrH4CQnRF61OYZddYSOOjnZtKIM1XX5sqj0G1fxc8o2
 VHBtougP4paSi1n0k1LHUc+vTi5XGaQdhrZTJi5wQilxm3u5F8DvdC3OPzS8u4wj9qHd
 so/QuQjLYZtB+pgDu+aHvh1IlxmXTsfwVD3mSE9FSpb6U9lgHjIuctC8lWMfzX8RM7aj
 XcImWqBwKHzeLq3VwoFR11a1r2N4HyQ8nNfR7r/3j9bFRw6EVerHnB02XZ+4OZPZ4gId
 SKHCHCcF1Fc28Qd0CWPACkCwywPauG6m7sbmpiWMljTrDedOupaZINHvB9Qd6vrAXLYI
 x+yg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVg0dOOGb+9DyKoBpTO4RO8+xUvB+5Nvp1gWJhtgVdjZ45voEgU+/q0VVYvtsrbGwGu3qUFyQY=@lists.denx.de
X-Gm-Message-State: AOJu0YxWPaG27wqbA3rhsgekJq977jCTgkfHtrkuULOHKO+5IFtalRja
 Wd4yzNTppTb1rceQ59suYSxdUxBacbvSHRvG0OsOJRgAuF6WrDqNkr547fnsEk8=
X-Google-Smtp-Source: AGHT+IG8flh3pnYdWifsLjEJbIiAC2DoHyvIlwlSvDSHXqJadWATU0pul3PGarNaPBO5/HeBr9NezQ==
X-Received: by 2002:a05:6214:451d:b0:6cc:458:8128 with SMTP id
 6a1803df08f44-6cc045884b4mr252573106d6.53.1729175144169; 
 Thu, 17 Oct 2024 07:25:44 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cc229620b6sm28248366d6.109.2024.10.17.07.25.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 07:25:43 -0700 (PDT)
Date: Thu, 17 Oct 2024 08:25:40 -0600
From: Tom Rini <trini@konsulko.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, uboot-imx@nxp.com,
 Peng Fan <peng.fan@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>, sbabic@denx.de,
	u-boot@lists.denx.de
Subject: Re: [PATCH V2] cpu: imx8_cpu: Avoid revision to corrupt device tree
Message-ID: <20241017142540.GK4959@bill-the-cat>
References: <20241017081236.26742-1-peng.fan@oss.nxp.com>
 <CAOMZO5Aikd3f5-Cnbtcn74qBAkLOs5hv_42FeZk2nxz94vksBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xNAAb4NerOhNWKMc"
Content-Disposition: inline
In-Reply-To: <CAOMZO5Aikd3f5-Cnbtcn74qBAkLOs5hv_42FeZk2nxz94vksBg@mail.gmail.com>
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


--xNAAb4NerOhNWKMc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 09:50:22AM -0300, Fabio Estevam wrote:
> On Thu, Oct 17, 2024 at 4:08=E2=80=AFAM Peng Fan (OSS) <peng.fan@oss.nxp.=
com> wrote:
> >
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > U-Boot device tree is padded just after U-Boot proper.
> > After the whole stuff loaded to DRAM space, the device tree
> > area is conflict with BSS region before U-Boot relocation.
> >
> > So any write to BSS area before reloc_fdt will corrupt the
> > device tree. Without the fix, there is issue that =E2=80=9Cbinman_init
> > failed:-2=E2=80=9D on i.MX8MP-EVK board.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >
> > V2:
> >  move the rev to malloc area in cpu_imx_plat
> >  tested on i.MX8MP EVK
>=20
> Please adapt the commit log to include this information.
>=20
> This patch breaks CI. Make sure to run all your patches through CI:
>=20
> https://source.denx.de/u-boot/custodians/u-boot-imx/-/jobs/920875
>=20
> aarch64: + imx8qm_rom7720_a1_4G
> 321+WARNING 'mx8qm-ahab-container.img' not found, resulting binary is
> not-functional
> 322+drivers/cpu/imx8_cpu.c: In function 'get_imx_rev_str':
> 323+drivers/cpu/imx8_cpu.c:78:17: error: 'rev' is used uninitialized
> [-Werror=3Duninitialized]
> 324+ 78 | switch (rev) {
> 325+ | ^~~~~~
> 326+drivers/cpu/imx8_cpu.c:76:22: note: 'rev' was declared here
> 327+ 76 | char rev;
> 328+ | ^~~
> 329+cc1: all warnings being treated as errors
>=20
> I am getting too much extra work to process the patches from NXP folks
> and I am not happy with it.

Azure can be slow, yes, but I would expect NXP to be able to setup their
own internal GitLab instance and runners, or paid Azure setup, or even
just use your own GitHub account and then own Azure account and not be
using the shared free pool of runners.

--=20
Tom

--xNAAb4NerOhNWKMc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcRHl0ACgkQFHw5/5Y0
tyzSzwv+JP0uXxAYKkWKy769NdJOIhBSE0L5RvjhXtwzD+Zt0KOjESZyEbQJKhI2
wO6coaDeliqqMiQ/HsM4l8FhqxiGJDIfHGPHtHVFuXB9AP+81bMprgtQMbmgAYdK
W2IbtVUSuT68ZVwRPkbL3GxtDlzjO/kXwbKAfxLOvcGb99d7u7exoCin9qrGsE6U
KCNl03IxBTIFkfA84GxkaX6UgOWXL/xgw/HYKVXHlVfPpNoK3P/1c7Nj1MOixMEx
eXo3JVF1LUGR7ZaZiVKwyOivIvVU8qF0wVGxM0AyxqBndM61kjSUkFFINZGvd+3n
X6Z9DM6Q7xlYfKq/LnkveStpn+x3hyjmFRvt3qjzFheZ2CZE/kr+3RyogViDYnpt
7w87anq0LgiXnEgNYb9CkuNH04mmDT6FMQ776/U1lsXFPgO17uH8Nf6Eei/3+nN4
VyTgS4lmHBEk79RaXOJEvziVsw2L8z5Rwi2qAKSDb2WAWp+5vpj1kOGoNwMP9u9j
ZgpBTKac
=P2k1
-----END PGP SIGNATURE-----

--xNAAb4NerOhNWKMc--
