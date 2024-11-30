Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80D07D73606
	for <u-boot@archiver.kernel.org>; Sat, 30 Nov 2024 17:25:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F22F89765;
	Sat, 30 Nov 2024 18:25:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QRjerP0E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C0D68975E; Sat, 30 Nov 2024 18:25:08 +0100 (CET)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4549C88E00
 for <u-boot@lists.denx.de>; Sat, 30 Nov 2024 18:25:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-466879f84ccso21378111cf.1
 for <u-boot@lists.denx.de>; Sat, 30 Nov 2024 09:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732987503; x=1733592303; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Y9rLggFQUMc/TIrBNsBjT/nyMSM8c+cEVkQGAF3C76M=;
 b=QRjerP0EJIsyyQmACTvNZd08pPXCXDsQkFKUhV8FcSztN/vkvv9FdcfL7opVf8DGr8
 ixk+O5Qly4Ss07/3TEAFXmnduiyJZhuY3z/PSH/ehhaxF1AohbbfiDwhcOIkv7w45DG8
 XEC9uFnJ1mSIcn7Nj3d8nI+rT6MZKlLW4tPV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732987503; x=1733592303;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y9rLggFQUMc/TIrBNsBjT/nyMSM8c+cEVkQGAF3C76M=;
 b=fjnwJNSQS961oJ7I7K8mMP9Y8pqiiWoGfR4tAFB3xCV74GNILtQ4xrRYATP1mNet1z
 K8wshPVIiHgP66hvAq2rObqGVgPkUf+TqJSACd7AKA1igLYq6h8XrihYmjR3ucFGmQEh
 /tZ+h0DOTa1q0r8o01y9f4i06f4sJDHfUnX6dtWaIqMCFEAvd7hovzE0xYyJZ0GNwIs4
 1vj7ORlZjmtIx0XjjAEWxdB7zhkuSzfGZViK4zAX/lxuNd5PaQ++Y+dB/bzAo/azy5cy
 jFbQB2f2T/rpZtWg5MdaEoFBt2QYoO4ynTy1Wc3bM8gUPCelVQtdCWgr8QksrOO8TkL1
 CfvA==
X-Gm-Message-State: AOJu0YxTKI7XzvOiJ8lgG97t9vpOs0c7GfHZZxlxxohUA7dcami+FxzS
 3EXokNFh9kZp+otMr+8hKkSAJ1256DoksIUlykTjg3SFHVPOjzXBhsTUly3C1rKuvQfqwu/71Ze
 eLJs=
X-Gm-Gg: ASbGnculoa3dtLVlz8RznDCcVrzs0N244y89IbCz82vU7xfuVOzEMd43v9vPpHA4dTB
 MOkJcCUIgkfyoMpNAE73qJIziwP7KQ2soGkkrhMk46Md3xC1lkgMJdpyp3zeF8sgZcMlCPBcFTO
 BzlVg8PSoja2LBxZlvB5lY23cKSUt+ZNnKiX1NVpv3nbJLiDglZO+sSWyXUhluMrTugDUJcsuaq
 rSr3seYcwNRHqor4lpfSfWc+jLsV/8Jf1l4uDScQApC1Dv4cg==
X-Google-Smtp-Source: AGHT+IEXFa80qcxo9C805cn/R/BbueBr/InJ6weMsZgaIAiUp4pZaBLCto0q7oXsw5q5ZSI/I9jVPw==
X-Received: by 2002:ac8:7dd1:0:b0:463:648d:5c with SMTP id
 d75a77b69052e-466b34dc580mr279275651cf.10.1732987503074; 
 Sat, 30 Nov 2024 09:25:03 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-466c42319aasm29217341cf.72.2024.11.30.09.25.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 Nov 2024 09:25:02 -0800 (PST)
Date: Sat, 30 Nov 2024 11:24:59 -0600
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [GIT PULL] Please pull u-boot-imx-master-20241130
Message-ID: <20241130172459.GQ3600562@bill-the-cat>
References: <20241130110143.318222-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ATj0AeLK3PIVLDWD"
Content-Disposition: inline
In-Reply-To: <20241130110143.318222-1-festevam@gmail.com>
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


--ATj0AeLK3PIVLDWD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 30, 2024 at 08:01:43AM -0300, Fabio Estevam wrote:

> Hi Tom,
>=20
> Please pull from u-boot-imx/master, thanks.
>=20
> The following changes since commit b51b97e9be1c0674345497a173e7b693866985=
f3:
>=20
>   Merge https://source.denx.de/u-boot/custodians/u-boot-riscv (2024-11-27=
 07:34:17 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx=
-master-20241130
>=20
> for you to fetch changes up to 4835efca7a004fab62853f3e6bbd2854d1df503b:
>=20
>   ARM: dts: imx: Enable PCIe and NVMe on Data Modul i.MX8M Mini eDM SBC (=
2024-11-29 09:20:47 -0300)
>=20
> u-boot-imx-master-20241130

Applied to u-boot/master, thanks!

--=20
Tom

--ATj0AeLK3PIVLDWD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdLSmcACgkQFHw5/5Y0
tyymPgv/R90yjkEwekJtjRSH0bpsTia+uRejeJ2psdT+syz5zYBHjUuwfmwxOiGE
Q7EifmZ7tyGp3OOhmunCTqBu6C+gcCnzJGFhm133wDwOhrrUXkElTkiU0ePCcQXz
k87QARpE5L9kRqwmVREtL1/llBqcBwZwddC+aoKmcgvVtVb0JnExPUAF6qC6f888
7sKW2XLe1fc3I2Y3VuyICCh1zVlw1hMzXzV0mcO9V5eoX58jhBTdbxnJCzI/DP+s
ft8GwFDXRaxosw5Z3Zw0wX5KG4wc7uXFxKWsubx6rEMO2nXibDm+IoaGJ0V/VvhN
zXNutlNA73AdH8n0lQJXs17zSYImkQr7hcBXkpYsjr5+NPdx3mL1zaEBaXk0VvRo
wkTDOcIYgAhz5Z491WXW2GgaSeGIV52X/jci23OmqeFegaa9J0U9NLd3BHkQb95z
F3BcOztrc1g6Uz0QMWOi+YLIFw32b5l+36lX5FG7j0tmilqX5NuhNoZxzIXrDtse
XMz/NIax
=oq2A
-----END PGP SIGNATURE-----

--ATj0AeLK3PIVLDWD--
