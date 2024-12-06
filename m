Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91942E77179
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 14:13:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE1008960D;
	Fri,  6 Dec 2024 15:13:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="l0BJ+uFe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2293389613; Fri,  6 Dec 2024 15:13:19 +0100 (CET)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8482689619
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 15:13:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-4667931f14bso31862801cf.2
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 06:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733494394; x=1734099194; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LmBwjKGQN0GLxhJIIzNGc0VDYXCkS06nFpGFfUCxjQo=;
 b=l0BJ+uFe4NAJzqvNBicK8G30ZOad+H7Ugc9e1HWNQMhB2G/5larAMRf+5I9c9vj59d
 hZxQIwsB/o+i2shHiPR4RP8WAi821BpqkTF6ATo/OTi81A6SnsYoW1hOjfrSrCSwZDpE
 JP8D+CCQ0/Kg3Qun/JrLISIS+RLVJ0gF5FWJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733494394; x=1734099194;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LmBwjKGQN0GLxhJIIzNGc0VDYXCkS06nFpGFfUCxjQo=;
 b=RVnlgvaNZX0SRNPo0TVG5NA2K4RxjDqTJeRNl5XgId6rpVshzPbmg8v+YrC+cqMGOm
 RJr+Zrx6tGVYyKXmYt5rJTsJj8DM3A0fUg0IQYrmHQFyFyvq91f4eqq0I04aPKzZk3CF
 DPuvrtXkZX8AQcRYTzkVjV45brN5ccbUO4o+4jgUfV9ZZf5j51QkVkY2jFCiRNu9Bc3k
 fZKy/dxaQkHPVhCTaP3/oyTmBEJZ4dHZ0FDnpABpK8Vb5IRoAMz0s516n+VkyjX3+n+m
 ETohQqaCbcikasVnLS4cICvj4uPmQmvFL2/HqIAy2qm6pfYL+AqTOepSdsVt4Yl8lHMi
 qiVg==
X-Gm-Message-State: AOJu0YxrDUxN85xRaOcR+P/BypkZmbuGEr5xajQh6GEI164w2K9Toz1m
 UcsAUGXNcesyNkFIbzsSvebAJPtiKdk6Qkjdu6Ay5a+xmNLFzeUh6SfAvEytUCo=
X-Gm-Gg: ASbGncs0Cu1RxdKqVWxRCMso0oZhXesnK0aNFdxf3YmtGvH8vRnUIgW08z0shooeYUi
 +yAjhmHBahmCZfJh0vo0BZDqju9qlN04LBCQ3VYm0kz6nDivRLuAZJJsbB4IYfflfDhR5AaQvOa
 ueE0DPBY1mF7E/MRxf74e8J0LUvDSGUNCVL50qtxpThgM+COVDhgpS/6ZuoW747gwCc0+4uNlhg
 W3EmtI4gM7LeE5yqKYuP1yT+IeQ579c1PnMsxmcsIpctX+qLA==
X-Google-Smtp-Source: AGHT+IHWxtwXVqx8YjYqrmffrYJjTOFqcSAUG19kTEnXdkXBl7XZzlZjfFxEFMbY6/s6rrM0Crhtug==
X-Received: by 2002:a05:6214:d4e:b0:6d8:8a01:64dc with SMTP id
 6a1803df08f44-6d8e71bf26cmr60029246d6.45.1733494394390; 
 Fri, 06 Dec 2024 06:13:14 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8da6b7854sm19336066d6.68.2024.12.06.06.13.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 06:13:13 -0800 (PST)
Date: Fri, 6 Dec 2024 08:13:10 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Devarsh Thakkar <devarsht@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jan Kiszka <jan.kiszka@siemens.com>, Jerry Van Baren <vanbaren@cideas.com>,
 Jonas Karlman <jonas@kwiboo.se>, Marek Vasut <marex@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, Richard Weinberger <richard@nod.at>,
 Sumit Garg <sumit.garg@linaro.org>,
 This contributor prefers not to receive mails <noreply@example.com>
Subject: Re: [PATCH 2/3] fdt: Allow expanding the devicetree during relocation
Message-ID: <20241206141310.GP2457179@bill-the-cat>
References: <20241206131113.2865416-1-sjg@chromium.org>
 <20241206131113.2865416-3-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dinoL6Rd05AT3dHA"
Content-Disposition: inline
In-Reply-To: <20241206131113.2865416-3-sjg@chromium.org>
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


--dinoL6Rd05AT3dHA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 06, 2024 at 06:11:12AM -0700, Simon Glass wrote:

[snip]
> A comment in that function says that we assume there is space after the
> existing fdt to use for padding, with the padding size set to
> CONFIG_SYS_FDT_PAD
>=20
> However, there is no guarantee that this space is available. If using
> the control FDT, then global_data is immediately above it, so expanding
> the FDT and adding FDT properties will cause U-Boot to fail.

This sounds like a generic issue and should be fixed outside of a "Pi"
series.

> diff --git a/dts/Kconfig b/dts/Kconfig
> index 41a758e83a6..360611edd01 100644
> --- a/dts/Kconfig
> +++ b/dts/Kconfig
> @@ -219,6 +219,17 @@ config OF_OMIT_DTB
>  	  This is used for boards which normally provide a devicetree via a
>  	  runtime mechanism (such as OF_BOARD), to avoid confusion.
> =20
> +config OF_EXPAND
> +	hex # "Amount to allow the control FDT to expand"

No "# ..." because the help explains what to do here, if needed.

> +	default SYS_FDT_PAD if OF_LIBFDT
> +	default 0

A "default 0" is almost always wrong.

> +	help
> +	  Some boards make use of the control FDT to boot an OS, thus when
> +	  image_setup_libfdt() adds extra things to the end of the FDT, there
> +	  needs to be enough space.
> +
> +	  Set this to the number of bytes of extra space required for the FDT.

We should just use SYS_FDT_PAD directly and not add a new option.

--=20
Tom

--dinoL6Rd05AT3dHA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdTBnYACgkQFHw5/5Y0
tyy+/gv/VNhCP+eOKBBfqLkeGXuKxtjZirNwSx+Jt6YuJ1ZDTRFz3FzdFrUo44tO
EEwy2rXkB9c14v11FfeguviBZDIZSiz/q8Qtu1h4Cku2w0g/DiS5Bc3En0VRgdJ+
8nxJmF/oz02Dyb39KnRe5v4p3QemMZOWz5iVwP3sYPLpAP+sdQx8iHqgRxfEVgt4
p/20QOLW5nnOXZZOqcLWv4RXMheXqKANfV8N8rI+9FzGh/Qpos7CuY4eSEvpe1Ax
ynPPvB0iwyQBOnAdy2lnE2LN559vAy3x6BWj5wO7ATJOjbjGBi8xidZBxfsNpxUb
vwx0SREJQFOpU/CRrzwaUPsU1pf6lXFtOu3fICpao2knGtKUPeH4LkUTFFnPMIUw
Y9LuId0etdCJY9jV05rYy5YgmKvYCIxOTrcmiQ4A7GNQ4tYqlvKXVcQAT9dRcj4V
tcd9u424YD3Ou7KF9gmQpIBItDMFXTLj6IzP8YLHYpidN0qCCMu1ct+NuRduOZXd
FU/c/3e+
=adcd
-----END PGP SIGNATURE-----

--dinoL6Rd05AT3dHA--
