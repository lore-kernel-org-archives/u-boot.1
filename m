Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86726C7115A
	for <u-boot@archiver.kernel.org>; Sun, 22 Jun 2025 16:40:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FE9B82CBC;
	Sun, 22 Jun 2025 18:40:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="B7PdhZn2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7E918210D; Sun, 22 Jun 2025 18:40:23 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A57A8210D
 for <u-boot@lists.denx.de>; Sun, 22 Jun 2025 18:40:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-73884ccffcbso2823643a34.1
 for <u-boot@lists.denx.de>; Sun, 22 Jun 2025 09:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750610420; x=1751215220; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6OmGZXXykTJnMfye+a0euIxSu8Iwbhb21zPMLmR/kLM=;
 b=B7PdhZn2V2QVnHJMx43ftDHj+JPM3nirpjON0NYOzMQfVP96gpzjwdbxAvvGQBXn3O
 Sl023w5N4LKtucwIIUB2kTgbE4Yfov4NW6EvMtubzjYHcv79rn/DqLQWS+zrRhowLpQ/
 NUY2J0d8h6MFhK9oX98gZEzQLfN6+FiaVjTZc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750610420; x=1751215220;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6OmGZXXykTJnMfye+a0euIxSu8Iwbhb21zPMLmR/kLM=;
 b=TQaVrnE2kfOTLS35DDUEjPLhsB9s2TMo/6oQpP1rsbSNvjeVGg3ft07wF37NzVrSfa
 oxN95Y0R+DtY+WGjixTD6Pz5ImfdBpDn7+I7EK9l+fFpB3YuD34SY+s43no+4OI+BNj2
 WwobKZRxmNdaXrOfmsRxo//abs7OccWDE2xSxQBPEGtqcNTBROXhYbiDbFJwaNDEDD3a
 FV4h/GR98d3mWerOush8mPGOTOtGXD4kIuur5U0auPo40/BLDUSxwE08FZvA6sHA7vNq
 cchVxWqwIjm03sPK/EBdbms2JM2LBYGLgRUqFxmi95BWGW7NakdPK92bII7ry06Kvm5r
 r7WA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5tlC10v09zNUOrwXTDXCcQdmTdBualn8Jw5TwCGdQ/WKzdIJdJy7RuJDMTe4J2tNDLHnt4Hc=@lists.denx.de
X-Gm-Message-State: AOJu0Yw73uOwTQLXE3UtzJr6IaCxi5dgbHV3cNageMWxFk9VmgrluwCy
 3TtTDvUJyxSQQbj0/eIY9gIfEr3A31Yz46nRL2eZuvwYonU9Rk+7cUPP2wci9QhGZVI=
X-Gm-Gg: ASbGncuqGqpj0I6jqimlOsxjzL1+lBALSIajkny9t5wmZhFbcCh6GUh83R7Cr0TOJBg
 4HuPxihrYCyLEV2GUF2KAWlzHhJ419DOjak+MmIWsT/XZn7apHRte3fNN/d61ruD4kCs4Urxvvu
 YjlAbQbcsUIAJFjPIUtNafPz7AHSh1fMbjjs+PcGBx9UoOTwdTvATEsGsN7h8sJ4jR1RaftVw1L
 EYQTLAryVEeSO6FsDy1Lwkvae110nRcIfK/xToKJDi9tCdebkj77eBdcbKpD24RHT8MU3fAWZcc
 FeE31h9o31pkc9TCYjmeqye6pc6kvQE70UDV3vCMVHb8gXiwIVyBA0vn9GLlejTiCIV4zPOHYes
 az+/+Wf5ZGVktR0FVU1NDdKf2trgM34U0Fw==
X-Google-Smtp-Source: AGHT+IGlvvnUy1mPybXVKRWOXJ5awUFl7RzjQ18HhFqtbNp7KhhPN6R15CkzMIQRzs8UtmrBsPucqw==
X-Received: by 2002:a05:6871:4410:b0:2d5:ba2d:80ed with SMTP id
 586e51a60fabf-2eeee55c6f9mr7356928fac.25.1750610419839; 
 Sun, 22 Jun 2025 09:40:19 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2ee8a8e5ee6sm1291247fac.31.2025.06.22.09.40.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Jun 2025 09:40:18 -0700 (PDT)
Date: Sun, 22 Jun 2025 10:40:16 -0600
From: Tom Rini <trini@konsulko.com>
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Minkyu Kang <promsoft@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 u-boot@lists.denx.de, Minkyu Kang <mk7.kang@samsung.com>
Subject: Re: [PATCH v2] board: samsung: e850-96: Load LDFW in board_late_init()
Message-ID: <20250622164016.GQ216500@bill-the-cat>
References: <20250620185010.11400-1-semen.protsenko@linaro.org>
 <CAPLW+4ksWWvGtV-u_CuxOv_FJjMR980Fs1jxasv0AM9sQjtHxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="a0sG4BfK/2W8YDNc"
Content-Disposition: inline
In-Reply-To: <CAPLW+4ksWWvGtV-u_CuxOv_FJjMR980Fs1jxasv0AM9sQjtHxA@mail.gmail.com>
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


--a0sG4BfK/2W8YDNc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 20, 2025 at 02:42:54PM -0500, Sam Protsenko wrote:
> On Fri, Jun 20, 2025 at 1:50=E2=80=AFPM Sam Protsenko
> <semen.protsenko@linaro.org> wrote:
>=20
> [snip]
>=20
> >  int board_init(void)
> > +{
> > +       return 0;
> > +}
>=20
> CONFIG_BOARD_INIT only appears to be present in -next, but I'd like to
> target this patch for v2025.07. *If* it's possible, and it can be
> applied to both mainline and -next, I'll then submit a separate
> cleanup patch for reworking all empty board_init() calls w.r.t. new
> CONFIG_BOARD_INIT option.

Yes, we can do the cleanup in -next once the next -rc is merged, thanks.

--=20
Tom

--a0sG4BfK/2W8YDNc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhYMewACgkQFHw5/5Y0
tyxZZgv/eH+aScbkVAQnAtZVi6he/S7H63g2eGukATDKZ+MSZGnlhv7Qn7KMaMOb
9AE3fQfjuhn9z07KxnnAhAcz56+T4YtNqmoGGpeimwGMllzJJbeY6mhMULZEUa4X
6h3Kfc8/BlmhgWYdphOBmttnVymoy278W3dCZbHpD1lcIHSuPmNwqUUsRf7vXghW
1LmglGxNEAeAbP1R7GI7Vw798dIYi3VaDYQbBqOy1UfsXqiYnHIEG8bdDvFDLkW4
lTMfFEveWq6IQR6AX9NXvM6tM+KyrUa8lsMupr7xMzswMio1zWHaebmkKc8Xz89k
OVDepCM0p1GiGU7MC6lchCQZ0WwmPZmlPNDvogSUpJRVsG3zk0HXOfLgkRkDN+v9
p0KKtc1+J8M0pUMjUyxhn0GKauNuyQM4K8bdFx85BSYS8Eyh6DPi+ZywWJOhh9FP
Xgzl71I0jAQwZPTeLi1dvUtcpFQ8XToxkgusUF0sNWivGwn5oCjKjs5YwEQWCvCO
3XnuJH2j
=1II8
-----END PGP SIGNATURE-----

--a0sG4BfK/2W8YDNc--
