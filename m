Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB990C25B78
	for <u-boot@archiver.kernel.org>; Mon, 27 May 2024 15:34:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EAF187B1A;
	Mon, 27 May 2024 17:34:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YhIm0Gz1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF4EE87CDB; Mon, 27 May 2024 17:34:53 +0200 (CEST)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE74A87A09
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 17:34:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-43fc7623afaso7312091cf.3
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 08:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1716824091; x=1717428891; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TBuxWiTzT1DRxtkYdHr5jb/2yIn3c5kDv38NCf4OqQY=;
 b=YhIm0Gz1CPc6/Qph0J+9GJs8mvCTeGGE40q3WYeO5V7YRhjqfgQhXUQFgqYU6H9HqR
 Xz7UnU2nPBxan0oWSpetcSl08JSNe+pta1AdtyrB3As58jAmAk7KxGR8FSmVEwXznQtg
 3gjNBnMTmIFd52k6yeKbZ6baKZ17e/05awo8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716824091; x=1717428891;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TBuxWiTzT1DRxtkYdHr5jb/2yIn3c5kDv38NCf4OqQY=;
 b=bRs1xnp16h9auXz35LmnJGZ9jdvoWTErW6H6PYZLGmitF8/+T053g8X7Vpsv61Sw4U
 VIUd90i1xGYfzlAVx1ootxGfbXXWqaUG3WXB7Sexx4JZ51BBbNTD3Z0OhRkuVJR3hlEB
 4HGQnTXdk41BTpfBrHAZNQAMzY8kM/iRnCfrRWqW7yUrI2UEta9amdOGUSJvrEDj7eBk
 v7Lk6fIeOM8xTzMbROwPZCbV5esu2AhRj7RaISVhu8tL8AJD1ohGviUoDQsqgrxMcWBX
 5kYNy81lzFBim+a+n+t9XoyZ4WOmGWtlwDjdbgSfGxLCcFUgwHykZ3C2tFcXqX/qD32l
 UMyw==
X-Gm-Message-State: AOJu0YzhgqSuYKGLIO+SpByk+cBVHrnOZy2Fg3PzGUOke86HCsfXUNDx
 v0LQwHCDeXpVdlr0n0La3faKDYdUWWwKqqVva7XbuqIMVxRCEUrtKAsbA9qzzYA=
X-Google-Smtp-Source: AGHT+IGQiK59AYhwlAk6g+3hL0EOnRNaIVQRE9ZOzKH4sMcegkx6s8wI36kjZxryg793eEFefH4QGA==
X-Received: by 2002:a05:622a:15d1:b0:437:d9b:cb56 with SMTP id
 d75a77b69052e-43fb0edd53dmr109798611cf.44.1716824090391; 
 Mon, 27 May 2024 08:34:50 -0700 (PDT)
Received: from bill-the-cat ([189.178.170.52])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43fb18c3f46sm34914271cf.85.2024.05.27.08.34.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 08:34:49 -0700 (PDT)
Date: Mon, 27 May 2024 09:34:47 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Maxim Uvarov <muvarov@gmail.com>
Subject: Re: [PATCH v2 00/14] Introduce the lwIP network stack
Message-ID: <20240527153447.GI2568172@bill-the-cat>
References: <cover.1716566960.git.jerome.forissier@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9k7bY6CJz3VKCafk"
Content-Disposition: inline
In-Reply-To: <cover.1716566960.git.jerome.forissier@linaro.org>
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


--9k7bY6CJz3VKCafk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 06:19:54PM +0200, Jerome Forissier wrote:

> This is a rework of a patch series by Maxim Uvarov: "net/lwip: add lwip
> library for the network stack" [1]. The goal is to introduce the lwIP TCP=
/IP
> stack [2] [3] as an alternative to the current implementation in net/,
> selectable with Kconfig, and ultimately keep only lwIP if possible. Some
> reasons for doing so are:
> - Make the support of HTTPS in the wget command easier. Javier T. (CC'd)
> has some additional lwIP and Mbed TLS patches to do so. With that it
> becomes possible to fetch and launch a distro installer such as Debian
> etc. directly from the U-Boot shell.
> - Possibly benefit from additional features implemented in lwIP
> - Less code to maintain in U-Boot
>=20
> The first patch introduces a new Kconfig symbol: NET_LWIP, which selects
> the lwIP implementation instead of the current one (NET). Contrary to the
> approach chosen by Maxim in [1], NET_LWIP and NET cannot be enabled
> simultaneously. The rationale is we want to start from a clean state and
> not pull potentially duplicated functionality from both stacks. Note
> however that a few files are still built in net/, they are the ones
> related to ethernet device management and the ethernet bootflow.
>=20
> The second patch imports the lwIP code as a Git subtree under
> lib/lwip/lwip. Some glue code is added under lib/lwip/u-boot.

For next time, please just make it a pre-req to run the git subtree
command (and note it in the cover letter).

In more specific feedback, I tried this on a Pi 3, and:
U-Boot> tftpboot 200000 EFI/arm64/helloworld.efi
TFTP from server 192.168.1.10; our IP address is 192.168.1.100
Filename 'EFI/arm64/helloworld.efi'.
Load address: 0x200000
Loading:
=2E...
FAILED test/py/tests/test_efi_loader.py::test_efi_helloworld_net - u_boot_s=
pawn.Timeout

So some amount of networking is working (that's a reasonable dhcp
response it got), but tftp'ing a file fails.

--=20
Tom

--9k7bY6CJz3VKCafk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZUqBcACgkQFHw5/5Y0
tyxOLwv7ByRij6fCegHcjbTR+CDpn87uOkSMoJrisHsfa392vCm8NpoxEV3GIbal
3UY8Vcb8d39RCtRir9+e+aGtkrx64F65gp6XhpPrPqaODNS+bFFHtqM+MedZTGsn
CDeE/E1+YBAwTvyZeVtgWd+KD6JTEX1pXYXjhbmI6UwBSIYqjCdR5mhcfHrMhgrS
7ntZDDYKpCZHPvBbyzx6diKZvxv0vKOUy9Xjdha0FIXIAGkXSeO3ubdbJiORtd2Q
Za+TepdHlGVgkZ1jQKKm7CRsnkfb6x02wkldfbpXd1B30vLwG0g9CXV/3ZNPn9xA
pUYtXQ9r1woeIfDpScrFwmx31Ji7davAaw0TrRJa89z+Ef70+KLw7yPE1GbFmvM2
VF3azT0Y4CxFWbBeKjPn3Q95BVNUIDbaSdatvETr6JAtgn22YGQhA34r/ueK0I5Y
yiNLQX+sgrIQeAfjjeOhQXT1FDZnBEFsVPLremfs5+FnbgXQWInyopVSopsRR7nZ
30t8Ei3w
=c0UC
-----END PGP SIGNATURE-----

--9k7bY6CJz3VKCafk--
