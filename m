Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96B28CF9C71
	for <u-boot@archiver.kernel.org>; Mon, 23 Sep 2024 20:35:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8D1488BCF;
	Mon, 23 Sep 2024 22:35:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lYwH7RFk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91A0D88B86; Mon, 23 Sep 2024 22:35:18 +0200 (CEST)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8584588BCF
 for <u-boot@lists.denx.de>; Mon, 23 Sep 2024 22:35:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-458362e898aso40274371cf.0
 for <u-boot@lists.denx.de>; Mon, 23 Sep 2024 13:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1727123715; x=1727728515; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Ua7u+c00IR8WWbSiTuVceFP/KqhvPiE6x2qQv0x1HrI=;
 b=lYwH7RFkajvorZZ5Qd+9TmrVvr1yJobOt/hVMf3I/lsd4rA8K83Nvp3DYGJzfCwGIu
 lPhqClCY0EoEGxbVb+FMLPA0LVDp0UEPqthJ0ey5dh1ueSNdYIyVJ+yP8GbCog0Cek5m
 zKkqwz+qLyIhcS/0+Zgov+LUjIaoULhdqCviU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727123715; x=1727728515;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ua7u+c00IR8WWbSiTuVceFP/KqhvPiE6x2qQv0x1HrI=;
 b=jDVe7bw162CgNpjYyTIgIEUf33Un4paHvW9PXkSbMYCjIk1XObz10JKMRbB9tlgAIg
 QvgXbpMhl1PkHUXbGmDjUyj2hYPMugoUshG/D9xIf0PtIuAiOzC4XT8ivYiQVM6+eXaI
 L00/m1eYSugQBNFsFgTn0F35+K3hEqgtMISFlsRx+hRB3Nd/KWzMFG53kJzPtHN1DZOY
 IA6raT1f38yfKo0VFQkMudmOy0vQQ9+o3CyMEX6j+erww0ZXHT4GaaQSxOsgZ0/wD5YF
 xXK9DcLyuw6DFygqMkV814OlwCTcySuRGngKDlYRhWL8UY8eWsxNWX9c1Es0WXQzh28q
 atCw==
X-Gm-Message-State: AOJu0YyWtw1S2cDHt1Whlu5R7QCauLzgqHAeCzzV3gEEgDg3ScDsHq5a
 oJ0ogGduy0cJQFJbdBpIZ+5lGatehN0Tmeb5lt6eRVNPhu/pX/AUgUhDJrmuXR0=
X-Google-Smtp-Source: AGHT+IHpm1esveNGSt7DXz806Rz90jh3tgPU9c57i8gLqdIVCb5Hs8opnFhPR19XOdUFmgRrU/3zGA==
X-Received: by 2002:a05:622a:1992:b0:458:611b:ad0d with SMTP id
 d75a77b69052e-45b204eb5femr228489241cf.15.1727123715422; 
 Mon, 23 Sep 2024 13:35:15 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45b5253ad3fsm99901cf.8.2024.09.23.13.35.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Sep 2024 13:35:14 -0700 (PDT)
Date: Mon, 23 Sep 2024 14:35:12 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v6 01/19] test: Allow signaling that U-Boot is ready
Message-ID: <20240923203512.GQ4252@bill-the-cat>
References: <20240920060158.106612-1-sjg@chromium.org>
 <20240920060158.106612-2-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZZ92sU2uVl6uQOef"
Content-Disposition: inline
In-Reply-To: <20240920060158.106612-2-sjg@chromium.org>
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


--ZZ92sU2uVl6uQOef
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 20, 2024 at 08:01:36AM +0200, Simon Glass wrote:


> When Labgrid is used, it can get U-Boot ready for running tests. It
> prints a message when it has done so.
>=20
> Add logic to detect this message and accept it.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
> (no changes since v1)
>=20
>  test/py/u_boot_console_base.py | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

What happens is that labgrid can also be told to look for and then
interrupt autoboot, just like our pytests can do, and the system is at
the prompt. But this is also what it's like for a system with autoboot
disabled. Do we actually need this patch to achieve the functionality
you want? Doesn't that already just happen?

--=20
Tom

--ZZ92sU2uVl6uQOef
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbx0QAACgkQFHw5/5Y0
tywySgwAp0mQPBA+DbT28kAPXFn81dsPKQx7gNye+FHjvLeprNwZwfKFoTj/bycv
/TwnwCZgE/Qu/XfUz9ArvDlf/etraqcsa0iy5SbAlBwo77B4SuT9PX/2DIMo2fMc
uu8D9CEAntqe6SudJ6DITR2xyj0vnRUp7sBJt9J2cJ3OVswpS47bozThVL5EEVm1
1VHzQwOEDXFoYNu8jfyVaZLnpN/qfNJqaql/3HTHfQPAFYZlNh73ZKqcvq+PzDAc
lGKykzRzix2FPMaVJOBMRGbokFr3qjAZx+SnlrfGsE/7yXdYm61Bq9VWTjIxCmDb
/EzV4Pvabb/1dxzveQyViTao7494P/Qu0yyUl0jQKgqtTVU0a6+wu1OysMWTbZ0v
xe2y9hh1WoaEXeekNjNExAm5SxTgLOozHlo0RmJ69QJfYhh7qVNh4RsDVS1o8V4k
Om9QXerPk5Ew8vsDStjM/+Qn5E/8E1XHyz6kfifOVYAqDIvdvQp7QwJ0kvTkf20Z
tvftfAd3
=/7Is
-----END PGP SIGNATURE-----

--ZZ92sU2uVl6uQOef--
