Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32737CDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 21:34:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0F6A86EDB;
	Mon, 16 Oct 2023 23:33:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BhMp4lHp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DC0386DEB; Mon, 16 Oct 2023 23:32:53 +0200 (CEST)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D717586D65
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 23:32:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-59e88a28b98so43145987b3.1
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 14:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697491961; x=1698096761; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xqdsXGcre2Rxwr7AU0AsureFqVM00A/sqxRZOHsi6C0=;
 b=BhMp4lHpGm7WCw3Mj4R94PMrREyzSn3t2CAA1nRZp3I0pqyTgM/GI8LsxOcWmz1VZg
 pedUuJoafep6/eJb1gw9YMWiTuS2ruVnGgH3hOeyJC82su28Qt9e39vq1Uv3KdXVocxF
 2HlRjEl3LTrGlHEU611eZnPRf8kVJG7PjMyWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697491961; x=1698096761;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xqdsXGcre2Rxwr7AU0AsureFqVM00A/sqxRZOHsi6C0=;
 b=vhoF4rS6rj1/JBxzBw3L/bz/zt5gbNVNzhfKcn0wu99wifaFqsTRb7z0arLfTw+KnU
 GFVtln2t+lvOpG1oUCausIhLfET9iI5apXx15W0v3WHGEXYjL+mmZXU+s/XD16b65KHl
 8wL3fC9mDM4qzaYY7mCt4R6KjLwtbO9MRuVRF13yXPwEpLClfzwEQ69kap94oVNrDKhn
 Ili9PwcSXVshruGnt+2HmRylRKZojJ9f3f4Vo5AZZXelX7VkTBMETFyyMf/JSTf4/qGq
 PDphRb8/8I7LeYrnGY6O+u8j5twzF3e2XM1bvU9x2kKV7Y4rWUatjwSFiWkgn/e846Od
 asfw==
X-Gm-Message-State: AOJu0Yyp7k3astsuebivtdCGBkw1OrJBmkMM6rLns2kfW3Dmltu45DQC
 eIIAqAbvasefOKfgjOg89yfnvLGuuPk/hgMZgu95/Q==
X-Google-Smtp-Source: AGHT+IFgBNhRtzrMU+8QoNxTZZjDHTiUVCmzKnSf05YCEmtYkNx2hHjCSxfFcTrQkCdMY96CqGBEqw==
X-Received: by 2002:a81:6c05:0:b0:5a7:b3d0:82c2 with SMTP id
 h5-20020a816c05000000b005a7b3d082c2mr450399ywc.12.1697491961427; 
 Mon, 16 Oct 2023 14:32:41 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 n62-20020a0de441000000b005a23a62a25csm35249ywe.9.2023.10.16.14.32.40
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 14:32:41 -0700 (PDT)
Date: Mon, 16 Oct 2023 17:32:39 -0400
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: Re: [PATCH] cmd/ti: Update Kconfig logic and Makefile recursion logic
Message-ID: <20231016213239.GP3119521@bill-the-cat>
References: <20231007193658.2617151-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="h6MOUzPbkdjMMt9o"
Content-Disposition: inline
In-Reply-To: <20231007193658.2617151-1-trini@konsulko.com>
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


--h6MOUzPbkdjMMt9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 07, 2023 at 03:36:58PM -0400, Tom Rini wrote:

> - Add some dependencies to CMD_DDR3 as this is only valid on some
>   platforms (which tend to select it as well).
> - The proper gate for going in to cmd/ti is not
>   CONFIG_TI_COMMON_CMD_OPTIONS as nothing under there is controlled by
>   that symbol but the general TI architecture options.
>=20
> Signed-off-by: Tom Rini <trini@konsulko.com>

Applied to u-boot/master, thanks!

--=20
Tom

--h6MOUzPbkdjMMt9o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUtq/cACgkQFHw5/5Y0
tywCHgv+JNbNun9M60T57fCtGRJwoZ2a5acSLh7YQd6DQYufiBudQezPjLs+gwJx
I6fJXXcoG5Wlpi/gPNPUfb62Epm8CQe76uAgEZZgTUlZR3ZvlIq7c3Xn6wP+XoJ7
gfahUOEZxSvFw5Ybqk9pBGDujd2YWlhR50gm2i2rLyyR2haFvZupLd1N4iA0ytnb
l6EhDhJxsX7sK25ZELzSOpq8x4YEyO6R68X8pQGDIqBdVxam44hXGzq6+WTrKac8
eq5fIsd+UaXa4h2y+S3yjB/ZOiBjGE/NwUWVz90r5mr0nOv92IKmo2QcKsXdhc7L
fe4VtLS83hxcvBES5ALQdSKt72kksRe4XlY/KX3gXUc12wzTSE9B/e/2o7Q2sbZH
i/CLZwvqq7ykkdjvlQOitES+Mktm62AvOjXHF5oaz6p99mPfBKt8bDWVkjRfrTbM
ePZ+w7/Ek4ILLVBEdrF27Ge35CeSTx66HvdrmPFgxGCulg49zMVo3K0FwrjhfDKk
9lCxgDXO
=gZBi
-----END PGP SIGNATURE-----

--h6MOUzPbkdjMMt9o--
