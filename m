Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EA29C52D71
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 17:25:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3CFF871C9;
	Thu,  8 Aug 2024 19:25:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ACmdNouQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32EA68785E; Thu,  8 Aug 2024 19:25:02 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72BB580805
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 19:24:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3db1956643bso903046b6e.3
 for <u-boot@lists.denx.de>; Thu, 08 Aug 2024 10:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1723137898; x=1723742698; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=W+VE7Y51mt0hgfNWaekmgkPkHahDqRaxvBIdI4oAQCo=;
 b=ACmdNouQdm88klRez+FqF4Uy1teJqXHcofAisSYh4UYJTNLkqzP4xmKoPZYWpcwAqG
 Y/aerZSNG4S9nJui7B1NWFzptdHMLhoJKuh2v2hJKGBcZzEJsOy1/UFTIukZXnsGPMlW
 TPbPnRHc64NIV4gEqIEZSFHxt2RB95hge0WEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723137898; x=1723742698;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W+VE7Y51mt0hgfNWaekmgkPkHahDqRaxvBIdI4oAQCo=;
 b=NG3CdG44jlAZtE+bGXod9ME96s24Et1rMj2TwNNlN4a8WKQQa44EPrlhrPOxpnTlO/
 J3EE35dDehcCcSN+jfThtmwrZ69t4X0ApTK2SqsXq36rjySQiKUgAj63VOpDkkqLh1p3
 A8wBc8v5Po4i2yytsLk/V79a+BRo3BUSa8941MNhruJXRsGrQoyqtI3kelHnjqXaJpbz
 5CDBasNiLejqd7EmPCTeuKy8nFrbxiY4ejeMKRvPVHdlBY8NT5PW0Odh1523UfRaIM/u
 uhnICRgSRwjGaVcvRd0UZgy5MHbUWe4YPqrNqcFRReHMEWjgNWV/hLec6By3SZaJvjyW
 aeFw==
X-Gm-Message-State: AOJu0YxuKZqskDP51EMUILwMog28zqSiZsL9PBif+EQPCVvE/knEefLL
 jsEnNTuM/NC4YgkMpJ9zHK22oQeTSEyeheXjDw/mOvhA9qfyORahJQZru2K3XWo=
X-Google-Smtp-Source: AGHT+IFVcg+MrNbZ56F8m8rUHdGByWuQiOXYsg5OE9bP/Y5rZNsCvFnSxg4lW3k7z8moNtYj/WXDNw==
X-Received: by 2002:a05:6808:201e:b0:3da:b3b3:17f with SMTP id
 5614622812f47-3dc3b426f43mr2957054b6e.25.1723137898123; 
 Thu, 08 Aug 2024 10:24:58 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-236.totalplay.net.
 [187.191.8.236]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3db5637117csm5039537b6e.23.2024.08.08.10.24.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Aug 2024 10:24:57 -0700 (PDT)
Date: Thu, 8 Aug 2024 11:24:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>
Subject: Re: [PATCH v8 00/23] Introduce the lwIP network stack
Message-ID: <20240808172454.GQ1626301@bill-the-cat>
References: <cover.1723050310.git.jerome.forissier@linaro.org>
 <20240807204400.GJ1626301@bill-the-cat>
 <2a23d370-82a0-446e-8ab5-00fa9005fdbf@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="edUHPa6RFMze/0RM"
Content-Disposition: inline
In-Reply-To: <2a23d370-82a0-446e-8ab5-00fa9005fdbf@linaro.org>
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


--edUHPa6RFMze/0RM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 08, 2024 at 06:41:02PM +0200, Jerome Forissier wrote:
>=20
>=20
> On 8/7/24 22:44, Tom Rini wrote:
> > On Wed, Aug 07, 2024 at 07:11:44PM +0200, Jerome Forissier wrote:
> >=20
> >> This is a rework of a patch series by Maxim Uvarov: "net/lwip: add lwip
> >> library for the network stack" [1]. The goal is to introduce the lwIP =
TCP/IP
> >> stack [2] [3] as an alternative to the current implementation in net/,
> >> selectable with Kconfig, and ultimately keep only lwIP if possible. So=
me
> >> reasons for doing so are:
> >> - Make the support of HTTPS in the wget command easier. Javier T. and
> >> Raymond M. (CC'd) have some additional lwIP and Mbed TLS patches to do
> >> so. With that it becomes possible to fetch and launch a distro install=
er
> >> such as Debian etc. using a secure, authenticated connection directly
> >> from the U-Boot shell. Several use cases:
> >>   * Authentication: prevent MITM attack (third party replacing the
> >> binary with a different one)
> >>   * Confidentiality: prevent third parties from grabbing a copy of the
> >> image as it is being downloaded
> >>   * Allow connection to servers that do not support plain HTTP anymore
> >> (this is becoming more and more common on the Internet these days)
> >> - Possibly benefit from additional features implemented in lwIP
> >> - Less code to maintain in U-Boot
> >>
> >> Prior to applying this series, the lwIP stack needs to be added as a
> >> Git subtree with the following command:
> >>
> >>  $  git subtree add --squash --prefix lib/lwip/lwip https://git.savann=
ah.gnu.org/git/lwip.git STABLE-2_2_0_RELEASE
> >=20
> > For v9, I think it would be good to do a CI run with NET_LWIP default
> > and seeing what fails from that too. There's a few problems still
> > leading to a lot of failures, in that case. Thanks.
>=20
> I pushed my branch to GitHub [1] and there's a failure in the
> tools_only_macOS job [2]. Any idea what is going on? I tried twice and
> it failed twice :-/
> Om my Linux machine, "make tools-only_config tools-only" works
> fine.
>=20
> [1] https://github.com/u-boot/u-boot/pull/635
> [2] https://dev.azure.com/u-boot/u-boot/_build/results?buildId=3D9105&vie=
w=3Dresults

Alright so from [2] going to the job and then downloading the raw log (it's
huge, firefox gets mad for me), scrolling down until it's not the git clone=
 we
see:
2024-08-08T14:36:30.0865130Z   HOSTCC  scripts/basic/fixdep
2024-08-08T14:36:30.8641660Z   HOSTCC  scripts/kconfig/conf.o
2024-08-08T14:36:30.9645180Z   LEX     scripts/kconfig/zconf.lex.c
2024-08-08T14:36:31.0545650Z   YACC    scripts/kconfig/zconf.tab.c
2024-08-08T14:36:33.2374910Z   HOSTCC  scripts/kconfig/zconf.tab.o
2024-08-08T14:36:34.9997050Z   HOSTLD  scripts/kconfig/conf
2024-08-08T14:36:36.5552790Z generated_defconfig:7:warning: unexpected data=
:  # CONFIG_SANDBOX_
SDL is not set
2024-08-08T14:36:36.5666380Z generated_defconfig:12:warning: unexpected dat=
a:  # CONFIG_BOOTSTD
_FULL is not set
2024-08-08T14:36:36.5724560Z generated_defconfig:13:warning: unexpected dat=
a:  # CONFIG_BOOTMET
H_CROS is not set
2024-08-08T14:36:36.5742720Z generated_defconfig:14:warning: unexpected dat=
a:  # CONFIG_BOOTMET
H_VBE is not set
2024-08-08T14:36:36.5752700Z generated_defconfig:17:warning: unexpected dat=
a:  # CONFIG_CMD_BOO
TD is not set
2024-08-08T14:36:36.5772400Z generated_defconfig:18:warning: unexpected dat=
a:  # CONFIG_CMD_BOO
TM is not set
2024-08-08T14:36:36.5788060Z generated_defconfig:19:warning: unexpected dat=
a:  # CONFIG_CMD_BOO
TI is not set
2024-08-08T14:36:36.5792360Z generated_defconfig:20:warning: unexpected dat=
a:  # CONFIG_CMD_ELF
 is not set
2024-08-08T14:36:36.5828400Z generated_defconfig:21:warning: unexpected dat=
a:  # CONFIG_CMD_EXTENSION is not set
2024-08-08T14:36:36.5840470Z generated_defconfig:22:warning: unexpected dat=
a:  # CONFIG_CMD_DAT
E is not set
2024-08-08T14:36:36.5938540Z generated_defconfig:26:warning: unexpected dat=
a:  # CONFIG_ACPIGEN
 is not set
2024-08-08T14:36:36.5974000Z generated_defconfig:35:warning: unexpected dat=
a:  # CONFIG_VIRTIO_MMIO is not set
2024-08-08T14:36:36.5985430Z generated_defconfig:36:warning: unexpected dat=
a:  # CONFIG_VIRTIO_PCI is not set
2024-08-08T14:36:36.6045140Z generated_defconfig:37:warning: unexpected dat=
a:  # CONFIG_VIRTIO_SANDBOX is not set
2024-08-08T14:36:36.6053060Z generated_defconfig:38:warning: unexpected dat=
a:  # CONFIG_GENERATE_ACPI_TABLE is not set
2024-08-08T14:36:36.6068760Z generated_defconfig:39:warning: unexpected dat=
a:  # CONFIG_EFI_LOADER is not set
2024-08-08T14:36:36.6088140Z #
2024-08-08T14:36:36.6121560Z # configuration written to .config
2024-08-08T14:36:36.6130190Z #
2024-08-08T14:36:42.5830900Z scripts/kconfig/conf  --syncconfig Kconfig
2024-08-08T14:36:43.9105630Z .config:284:warning: symbol value '' invalid f=
or AVB_BUF_ADDR
2024-08-08T14:36:43.9121120Z .config:285:warning: symbol value '' invalid f=
or AVB_BUF_SIZE
2024-08-08T14:36:43.9142940Z *
2024-08-08T14:36:43.9172380Z * Restart config...
2024-08-08T14:36:43.9257450Z *
2024-08-08T14:36:43.9288610Z *
2024-08-08T14:36:43.9332910Z * Security support
2024-08-08T14:36:43.9366750Z *
2024-08-08T14:36:43.9399770Z Build Android Verified Boot operations (AVB_VE=
RIFY) [Y/n/?] y
2024-08-08T15:35:07.9280210Z ##[error]The Operation will be canceled. The n=
ext steps may not contain expected logs.

And indeed, most of that is "normal" if we look at a current build for
tools-only on macOS. We're being hit by the fact that the host CC isn't
gcc and is llvm and https://github.com/llvm/llvm-project/issues/78778
applies, I believe. Now how do we work around this? Hum...

If you go an change "# CONFIG_FOO is not set" to CONFIG_FOO=3Dn in
configs/tools-only_defconfig, I assume your build moves on? This is
valid syntax and fixing a more generic issue we have on macOS today.

--=20
Tom

--edUHPa6RFMze/0RM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAma0/2MACgkQFHw5/5Y0
tyyI8Qv8D0JuziJ1Fj0Y2xO+aeyBaOTlwjomO974Jzm7jRUfz+62xqrRqtoOe3CK
2fHWpUK0L5zj25StNUBYmQdu3EWEOTNQAx6lBcTPGX0/D6G/j0/CvDxpaL+Ac9fa
EAiXNnjnopH3NJYhRVqoXMPpdKCjJJD2D82R1JVbnvW9Dt0v6DyIkuI4MTPboLkf
FMiWSGmyDMisJKrcqs7EqHqn4pvsLqk1KqzhuHzq34cGpGKh1oWC72nLYC6aHsNd
qGTEhTLergZP+Bw2hQlrMhastztWzZhE09xbKiMJQBtiXkPV9aMAGhoxgF0Htsb7
EePfdXLxKHOnIH+i1XuBc2lEngGAd4LHH6pgoq6f/4cTNzxKCqMY0iHJwhOP5qLl
fstg+EO9gsX1SO+nEjt821jPcdJsQigehs1eqAKWkICL9MKXyeQMKAKps8EZoLbT
r6aPVdg5XdCK5TevBNwYb+tJ6zrdkulVyjeqKkGL3wyanFWutH1LqbjmzpaJzPgD
eOaebQf8
=wdt4
-----END PGP SIGNATURE-----

--edUHPa6RFMze/0RM--
