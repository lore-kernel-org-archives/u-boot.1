Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 192ACD5E15A
	for <u-boot@archiver.kernel.org>; Tue, 16 Dec 2025 14:07:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BBBC83A2F;
	Tue, 16 Dec 2025 15:07:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oQqdtrXv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0E8983A2D; Tue, 16 Dec 2025 15:07:28 +0100 (CET)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F045C83623
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 15:07:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7c750b10e14so1977914a34.2
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 06:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765894042; x=1766498842; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jkiqabiFwYexp2Dzo4m2WAxI/1KsP8YewthOVnrEQwo=;
 b=oQqdtrXvcHWAefxol8Nt0Wlm706maeocbWncsQXir+xQ+11fO1U/U5JUo7piT3S3k4
 9G9ueQXfTrL/wmAscCeVXuNU6LVBWhJfmXIxWM9ADSS+oO5N1eB6S5vVPSkeKjsfYqPW
 pFogT+g15uKAto+0QaUiwkARQfL91PLtWslw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765894042; x=1766498842;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jkiqabiFwYexp2Dzo4m2WAxI/1KsP8YewthOVnrEQwo=;
 b=njmjBAAh9YCoF5i6VgL89aT9fypTDWH96vZmWID6mYg7MMC/uJWR00tUGPk8JVjcQq
 AREn+F/1S9l8nlvWYxHUE/0fa5+Ue2KLYDlcGJEkqIE1bgxi7Xi0be5XegHdO9OUv6fx
 o4xnDoDIpLWM+cg0P2qWlg640uOVQfmEOOm2gfYl7fxycajG4ZNYByJF2j2R7rzGyo+s
 1x8GkgWVQNR6gQHxrbvpPr0kngDpNiFoRYMw+pIqGFEX1H6srsTleCSAmQkopyBjUn9X
 QtcV1LM7A22bAL1n8XzrnTKD2Ur3vLLijXyCOSwJowr5jx4Aq35s1ZN1TRoMM2LEQ6KG
 06Gg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0dLZqOXujeRZSrEhHTa3oT6OsE2KuSFHMgmyc4xYrBFJq5eAw9kdGa4eJ9f4HZ6W4cC+LtNI=@lists.denx.de
X-Gm-Message-State: AOJu0YxwTLdNujcw2vPI2kqlwV1yDRl5fgVzAFWTlvQ9gSRtz74trtS2
 jsnTSywp+fO71vpMKLfcfwagFQsq/u+T96l1/cFzl45oQeDCPyk5oamn8WqjDpYKiDQ=
X-Gm-Gg: AY/fxX7XD2bG8WT9xHWxdJLCjVFJDUETTBrCQddaXHlLGpgYLm+nTGS9W80bXyS03yb
 2b33MUJ33MoB+XWxaOJ+oDQw5OlKMPdvTJk96bxUyUyBJ55ZDMyxy8ybTLq2m9W+TgncRAk1Jo3
 kLWRyHTQS2+o5cGoW8+8OWBaAKb6BQ3IlnOManLfB1yqaULIzqHnqUqUfwI95cESxiUcnHlw9hK
 nzLutEeQUgzYD+2p4Bb8pw2lhMiVfqTvqVDfC9HvQ5nclALs3D/BaUsFq3zyQnhtGwT00ZqZKn3
 k5JuLox02dokawUUN7YUIG40ZHWT6L5Yycrimf8Omtdez5kRjcmCjMpUvsX8biPIa6NIoC8dplP
 x69TleKvU0p2xo5A2osMZ+NDrmPotI2IIUmlV2zZ+ckMu7mZRCPZMABplZxkun9aEdkPgfFC1HW
 clIhrL5nYLGInXse6THvYSz3CmtdfOxlcV5LSQk9tmjUvcsloH5tDxPHKjyF7Y
X-Google-Smtp-Source: AGHT+IHdpk4XmvEnAcDh5pGVnXd9bzfIVSBgFigKLmqkm42rph94+rzLjh26Yiq0Hkq9s3ZXPteJ2Q==
X-Received: by 2002:a05:6830:44aa:b0:7c7:6d15:6ac2 with SMTP id
 46e09a7af769-7cae82d4a09mr7783645a34.3.1765894041683; 
 Tue, 16 Dec 2025 06:07:21 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cadb3246a8sm11439449a34.22.2025.12.16.06.07.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Dec 2025 06:07:21 -0800 (PST)
Date: Tue, 16 Dec 2025 08:07:18 -0600
From: Tom Rini <trini@konsulko.com>
To: alice.guo@oss.nxp.com
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Marek Vasut <marex@denx.de>,
 Marek Vasut <marek.vasut@mailbox.org>, Ye Li <ye.li@nxp.com>,
 Tim Harvey <tharvey@gateworks.com>, Peng Fan <peng.fan@nxp.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Lukasz Majewski <lukma@denx.de>, Sherry Sun <sherry.sun@nxp.com>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 George Chan <gchan9527@gmail.com>, Simon Glass <sjg@chromium.org>,
 David Zang <davidzangcs@gmail.com>, Alice Guo <alice.guo@nxp.com>
Subject: Re: [PATCH v1 4/7] usb: ci_udc: Convert driver to DM_USB_GADGET
Message-ID: <20251216140718.GV303283@bill-the-cat>
References: <20251216-imx8ulp-v1-0-504115a53020@nxp.com>
 <20251216-imx8ulp-v1-4-504115a53020@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TKDO7xYYzwYK4zn2"
Content-Disposition: inline
In-Reply-To: <20251216-imx8ulp-v1-4-504115a53020@nxp.com>
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


--TKDO7xYYzwYK4zn2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 16, 2025 at 02:38:36PM +0800, alice.guo@oss.nxp.com wrote:

> From: Sherry Sun <sherry.sun@nxp.com>
>=20
> Convert the ci_udc driver to driver model by using the uclass
> UCLASS_USB_GADGET_GENERIC. The clk and power of USB controller and USB
> PHY both are initialized by parsing the device tree nodes.
>=20
> If CONFIG_DM_USB_GADGET is defined, we use the ci_udc driver in DM way,
> if it does not defined, we can use ci_udc driver in its original Non-DM
> way.
>=20
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> Reviewed-by: Ye Li <ye.li@nxp.com>
> ---
>  drivers/usb/gadget/ci_udc.c | 352 ++++++++++++++++++++++++++++++++++++++=
+++++-
>  1 file changed, 348 insertions(+), 4 deletions(-)

Good to get this converted. However, and this addresses some of the
questions in the Kconfig patch (which should be part of this patch too),
the end result should be supporting:
- Full U-Boot is DM only.
- SPL works with SPL_DM and (SPL_CI_UDC && SPL_DM).
- SPL works with SPL_CI_UDC and !SPL_DM.

This does mean adding a new symbol, for SPL, and migrating existing
configs to SPL_CI_UDC. It would also be real nice to know if all of the
imx6 and imx7 platforms that don't use SPL_DM could use SPL_DM, so we
could drop that last case I mentioned above.

--=20
Tom

--TKDO7xYYzwYK4zn2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaUFnlgAKCRAr4qD1Cr/k
CmU9AQCh8JV0qvd+mZYro1PVL859BPXErJLk0YDta72Ac6hzSAEA4uLVlxskoIEO
3/ttNTr0N7WRtwCtbiK09uyx6vAO2g8=
=KQqG
-----END PGP SIGNATURE-----

--TKDO7xYYzwYK4zn2--
