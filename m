Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B4DDD116F5
	for <u-boot@archiver.kernel.org>; Tue,  2 Dec 2025 21:21:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3F4A83F56;
	Tue,  2 Dec 2025 22:21:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="E7FtTbUp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EB3383F4C; Tue,  2 Dec 2025 22:21:26 +0100 (CET)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E0A583F36
 for <u-boot@lists.denx.de>; Tue,  2 Dec 2025 22:21:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7c6cc366884so1849827a34.1
 for <u-boot@lists.denx.de>; Tue, 02 Dec 2025 13:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764710482; x=1765315282; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vIpWSbJ0h0RJtjdX56++J7Z9hwv2TW9Uk0Q1WW/lNJQ=;
 b=E7FtTbUpdu1trZmze9+RBfK7k2m9RCWLjOtnVrvD62bJ8g0ifop/lAC/wyDBz6W6CV
 0tf6YH/43+6QmqJqIfFBrS+86HWYad9sDgElDeToAp6EIULrSbtdfzqq85QqziKeIHF6
 OAtk2VlUr3Fv9aF4y0W9WsR336nEEmivQbNaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764710482; x=1765315282;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=vIpWSbJ0h0RJtjdX56++J7Z9hwv2TW9Uk0Q1WW/lNJQ=;
 b=GUyVSTHFC+ZCNiAmXKvd/ICCUiHBZDypzZKMZEbyM69oQHXkSqPzvewhQ+VNpqZece
 OyUDbSFRHz/QYRfSj+oA30Kl3F5VihPACpJVhcUmx7wWDV5/vk3b0v1P0fcwziPQ1S55
 jsllT6MBJBpQakYzOyEhPguRlQipfH9mQY5tobgFAEQdjB6IATPjlPgCtoew5n0jw4x2
 TI+MItkhVFbFd+B3f3LWIF8TCDx0zYXJgDZmPllMuVzfOZSNANmXBvy8iojs0uEqQMJq
 8NvPRf5NmKxlx0Zu8ILXK0s4stz1ury0F3gpm8NEEE8juwWZe4xp9yDJ+rTzZ89yBfB3
 DABw==
X-Gm-Message-State: AOJu0YwJf+ZhdyfKHLxJ53BObmhhy9h2sOU0xUYE4pkWU/BFBjctadM8
 MgeROzVjHzAtshTy9NgRbMB4btX50RpdlwiUX7Gw57vWad5DRo5iOFGJ3CPncDIgDP5ZDHeBtjk
 xiCPIQJw=
X-Gm-Gg: ASbGncuOiGPFPjPG//gY13cda6LjkNQmLhYnSLWrJ/eXhJKpp34b2nQ7kNnShW7NqZs
 P1XftjfozTXRuXDF3yMYJreVMHPdzNiiPx+aOOgPl+wQNZ4kBpnO3mkiZSNVtLYfvWqP+ERpSJA
 7HyQ3op1/A7ymfLqZZa2KQAJfyklzKy+iWpwkJ6F+D5kJRcApKfFYRdlSgWZSM/9rWpDW95Shtz
 09vaLuCBa4hdkbX5N/lmT+zSYoShBdsu9xVnHTTmeUiXmP6er6nhXf5iU2PubCrmmKKtsBXc9yv
 BsTP1fatWVEoBrXWmqxnEOtY5qVxiYk0iZPd7VsIcip+mBnNysv7E2eQM2+qDK+zC6kkAZvh9vK
 4i3rlxU3XPVYt42dY93bF6weSnya4oZPb0jQqBpX4KkCqT7hOhDETr2zXpyC4t20LnPkjh8ISCE
 jpVSQJegpUPje5eGo//KaSl5ppalMdxkidLEJSNFC5+BnWGjIJOw==
X-Google-Smtp-Source: AGHT+IGP2s3fSMqleoPD37s/dr/u8reRmSA22ewlLRa+xZSfCbk1Hex8v9QPdo8FzSlmOt/ck0H0rg==
X-Received: by 2002:a05:6830:44ac:b0:7c7:53bc:54ac with SMTP id
 46e09a7af769-7c94db40339mr54020a34.13.1764710482202; 
 Tue, 02 Dec 2025 13:21:22 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c90fe0f650sm7332456a34.23.2025.12.02.13.21.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Dec 2025 13:21:21 -0800 (PST)
Date: Tue, 2 Dec 2025 15:21:19 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, u-boot-custodians@lists.denx.de,
 u-boot-board-maintainers@lists.denx.de
Subject: Re: Dropping macOS and Windows host tool builds and support in U-Boot
Message-ID: <20251202212119.GM303283@bill-the-cat>
References: <20251202182403.GF303283@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZF2BQWRZfXDNHt8Y"
Content-Disposition: inline
In-Reply-To: <20251202182403.GF303283@bill-the-cat>
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


--ZF2BQWRZfXDNHt8Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 02, 2025 at 12:24:03PM -0600, Tom Rini wrote:

> Hey all,
>=20
> I am wondering if at this point in time, anyone still builds our host
> tools (fw_printenv / fw_getenv, a few others) to run on macOS or
> Windows, natively.
>=20
> I ask for two reasons. The first of which is that a reason we still have
> to support Azure (despite its slowness) for CI is it's where we have
> macOS and Windows hosts. But at this point in time there's so many ways
> to have Linux userspace running on Windows or macOS that I don't know
> that there's any value to these builds.
>=20
> The second reason is more macOS specific and is that with:
>=20
> commit 8fbcc0e0e839a8e25f636c76e59311033d3817b5
> Author: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Date:   Thu Nov 13 12:54:51 2025 +0100
>=20
>     boot: Assure FDT is always at 8-byte aligned address
>    =20
>     The fitImage may contain FDT at 4-byte aligned address, because align=
ment
>     of DT tags is 4 bytes. However, libfdt and also Linux expects DT to b=
e at
>     8-byte aligned address. Make sure that the DTs embedded in fitImages =
are
>     always used from 8-byte aligned addresses. In case the DT is decompre=
ssed,
>     make sure the target buffer is 8-byte aligned. In case the DT is only
>     loaded, make sure the target buffer is 8-byte aligned too.
>    =20
>     Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>=20
> Which does things we must do, we now don't build on macOS. Why? As best
> I can tell (and for a general purpose OS, is a good call), memalign(..)
> doesn't exist and you need to use posix_memalign, a not drop-in
> replacement. We could spend some time reworking the code here for that,
> but for now I've instead gone with this workaround so that CI can
> continue:
> https://lore.kernel.org/u-boot/20251202162250.2613085-1-trini@konsulko.co=
m/
>=20
> But longer term, unless people say they need and use these tools, I'm
> inclined to remove them from CI and remove this workaround, for the
> v2026.04 release.

We have solved this specific problem without a large work-around.
However, the more general question remains. Does anyone use these tools
on Windows / macOS?

--=20
Tom

--ZF2BQWRZfXDNHt8Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaS9YSwAKCRAr4qD1Cr/k
CmcuAP9num76Ea9gQVlzePxItLQlVqSm3dleikonVf1FYMbonAEAg8FMtEf2pZhi
Bna7npHZc8EPCfwb+SR4oCirvzGwZQA=
=a1sj
-----END PGP SIGNATURE-----

--ZF2BQWRZfXDNHt8Y--
