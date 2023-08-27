Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66F96C83F10
	for <u-boot@archiver.kernel.org>; Sun, 27 Aug 2023 23:13:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C24C8620C;
	Mon, 28 Aug 2023 01:13:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gWihPqU6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EEAD846D2; Mon, 28 Aug 2023 01:13:27 +0200 (CEST)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E7FF863B2
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 01:13:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-58fc4d319d2so30885157b3.1
 for <u-boot@lists.denx.de>; Sun, 27 Aug 2023 16:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693178003; x=1693782803;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=iQ+KnN10gDdh/vsllDvm1QCZduPjELW3m0vowFBM4K8=;
 b=gWihPqU6aXkz+veri9Z8pDQn5LF+JoE8xrEnYQkwO9v3b4G/fjSsre7WnNQ/uUJYj0
 MzxaBifEPsVdcVTetHx4ok4IVhKZ8bqrlDF+OcKDeiRnHZdEhd8VNyMWWzvIiN98NOsL
 FuHjTAwwJbuqXiWEju9CdOuKf/DGrme7BNwes=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693178003; x=1693782803;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iQ+KnN10gDdh/vsllDvm1QCZduPjELW3m0vowFBM4K8=;
 b=D3SK1W/TkHXx2pxwNpkYti+2/NRkYVi/5/yXh2YKc8A/YJFjb2r8bAOVw9Q6FPE3Bg
 tPMjyOMNnpnHxij62XkdGNczi/hoMh1rUhcdwCpydrnROYHruiJebFh0kHbL1Qih+2P1
 2lmSAiHwG7AuoY/rQnxu4d/V3O1O7GpYDAAl/yddyUxC5KBHjtYpm4gnrx532vRmD4kz
 16aKFa4KbHu2C/D7hZgAfwf1l5jhBNobjaWzujsL/J8wlvnzPRUAsYNhGpM+no9Syp3H
 W3Kfrlqa6gQJnNYh/Wd9ZXTXb5234m85Dm5F3WccfpXzj2MpalY/KUJeFeiGlyg111IY
 F6hQ==
X-Gm-Message-State: AOJu0YzGvsCs+JrvrMQr87cO2tL1TPqswt27+YJn2j8/x3oOLRsfV4a+
 0apKpKU172cCQHd/5G1JxUUMnw==
X-Google-Smtp-Source: AGHT+IEd5yOiXBYM83CzOMKoQxsegW6LJagLtGQ6iJDTDT6E+byjvkhMsLdrjVElmxbJMgNN8/wRvA==
X-Received: by 2002:a81:a1d5:0:b0:592:1bab:52bd with SMTP id
 y204-20020a81a1d5000000b005921bab52bdmr21902708ywg.39.1693178002697; 
 Sun, 27 Aug 2023 16:13:22 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-c01a-9a8d-1e42-2ea4.res6.spectrum.com.
 [2603:6081:7b00:6400:c01a:9a8d:1e42:2ea4])
 by smtp.gmail.com with ESMTPSA id
 u22-20020a81b616000000b00594e355aa78sm1296531ywh.143.2023.08.27.16.13.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Aug 2023 16:13:20 -0700 (PDT)
Date: Sun, 27 Aug 2023 19:13:18 -0400
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nishanth Menon <nm@ti.com>, Sumit Garg <sumit.garg@linaro.org>
Subject: Re: Pull request efi-2023-10-rc4
Message-ID: <20230827231318.GY3953269@bill-the-cat>
References: <808615a4-ae31-d15d-4d90-b58c5bf86c3c@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5fIVW5sDQOLMSkJb"
Content-Disposition: inline
In-Reply-To: <808615a4-ae31-d15d-4d90-b58c5bf86c3c@gmx.de>
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


--5fIVW5sDQOLMSkJb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 27, 2023 at 09:55:17AM +0200, Heinrich Schuchardt wrote:

> Dear Tom,
>=20
> The following changes since commit e508b930021168c788f14977fc101ccc1151b3=
c8:
>=20
>   Merge https://source.denx.de/u-boot/custodians/u-boot-usb (2023-08-25
> 10:52:39 -0400)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/efi-2023-10-rc4
>=20
> for you to fetch changes up to cc889bd0754e50a3cd50e8ed3094388480fbec86:
>=20
>   efi_loader: delete handle from events when a protocol is uninstalled
> (2023-08-27 08:21:08 +0200)
>=20
> Gitlab CI showed no issues:
> https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/17537
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--5fIVW5sDQOLMSkJb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTr2IsACgkQFHw5/5Y0
tyyQcQwAtDiDeUVbwIE2L9BFc/k5Ozd7VcR1FRUwgzZB/KwzkTW0TQxxJQzpOdPi
mAfebGLdH1YiraknatPwCeRNF/k9toWxnSbVQZjdH14J5KvzdASveXDw9DlJdQT+
IqocuIkE0iPRHQcfvs4Bd0zD9ZsS7/ZS8SG0qAdVLCYYjiGMaZd8+FOp11G07zyi
ysLpaIUxDgKWfhYDdtml6PxY0hbsQRQEclsXiko3SJ0K/Gr/nD6err8hWYGjxr+x
918uD5mEC86uaX7F2cj0T+KdBz73/pEzPHLjS8G1jpzeb8NBOBLber835/DTK8Fs
tsnMi3UMFCTkdNJFsVaEw3kwk1F7Pq/OhZgCucNDdzSgS2q5ku2dEDAvgVSeVfPk
4CN06+6skeEcdgnbQSwKkkY+gGHp2KZOrmsBFIAJ4jyPzy1P2UlxXSwIdvkzCg46
UbiGq5FiMFTdwXFNjJ2XggDuqg75HdTGR0P1GqPxLQaF0Tz7SPrxYH/FSeabfyWQ
8GYy4Jpi
=PLKQ
-----END PGP SIGNATURE-----

--5fIVW5sDQOLMSkJb--
