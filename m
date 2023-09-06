Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D31EFEE14C0
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 17:50:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12BB0868D7;
	Wed,  6 Sep 2023 19:50:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ut1ulfFS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B5A4868BC; Wed,  6 Sep 2023 19:50:15 +0200 (CEST)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 520F9865A8
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 19:50:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-58fae4a5285so987097b3.0
 for <u-boot@lists.denx.de>; Wed, 06 Sep 2023 10:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1694022611; x=1694627411; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mldUyRsnPsRMKhPGAHRIiRup433BT4YvOlRC/X0rHiY=;
 b=Ut1ulfFSQK+Vkyt4kAkBsGv/kAlVA+EBofwcNnA3i766D+YCxdIajzGkJcE/G+mHYh
 hmMN6ucUQqIQwhgsY7gNegst2dDQFMXaU4uBo1+ofm2Vr5zE6OoX3qpSOg1D1JRTetHW
 BfPSKIiG7dq8/dD8wxBBsHYPfeYZ8/JMitS5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694022611; x=1694627411;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mldUyRsnPsRMKhPGAHRIiRup433BT4YvOlRC/X0rHiY=;
 b=jEjL/Wb0v+oHBLTePPC92h6V+s8W0KsbJBQ7u/L/JSo4ydXfERpaZQgoJBGY0B7RTQ
 HkFxX1XmOLx0Ed6FqMm1v36rmKWe1cPeRm7bJyDz1d7lUQCtN/NUqljWoXdL+TiAx0PC
 d9fa1t7WdRmAAW8sdcv2wqU+qucpnTWFzXJW1TyzegC/K9ouWoJpVR3SlLU31cIMYM5S
 XNRY7QYM+jsHPwyG6v1CCY7PQFk6rLOGLpO8rwoF2tjEvH+6nhDjoj7fjf/qlAzZVeIs
 RiwiKbIAs8ppAL0rnXteYaRW28z5axf8eRzPNig038hvO35+PqrLaPHF1tXeH96W1+Em
 liWA==
X-Gm-Message-State: AOJu0Yz45nX1brhZTTLTkhFeX+b1N2my3Glmps24ftGdj5b6jchi1u2m
 cAne4d8SC5Q+esi0uiLnqRBpcDsByW629AyAsPJhng==
X-Google-Smtp-Source: AGHT+IFqj/Bf7WNuRxjnSaR80Jc0Qr7qALFWYN6xY186tkc+hf7zvHqBjOLdQAduQB4YpTs1Fl+W3Q==
X-Received: by 2002:a0d:cc13:0:b0:57a:5039:aa01 with SMTP id
 o19-20020a0dcc13000000b0057a5039aa01mr18243351ywd.22.1694022610818; 
 Wed, 06 Sep 2023 10:50:10 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-06dc-de6d-386e-5d48.res6.spectrum.com.
 [2603:6081:7b00:6400:6dc:de6d:386e:5d48])
 by smtp.gmail.com with ESMTPSA id
 h129-20020a0dc587000000b00589a999038asm3896389ywd.77.2023.09.06.10.50.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Sep 2023 10:50:10 -0700 (PDT)
Date: Wed, 6 Sep 2023 13:50:08 -0400
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de
Subject: Re: [PULL] u-boot-usb/next
Message-ID: <20230906175008.GF305624@bill-the-cat>
References: <20230905135011.15535-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1obUBnO1xZ0jw6A2"
Content-Disposition: inline
In-Reply-To: <20230905135011.15535-1-marex@denx.de>
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


--1obUBnO1xZ0jw6A2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 05, 2023 at 03:50:11PM +0200, Marek Vasut wrote:

> The following changes since commit f2bb6d9ffd9ba0d0d89c00445a70cf81327a7a=
f2:
>=20
>   Merge tag 'doc-next' of https://source.denx.de/u-boot/custodians/u-boot=
-efi into next (2023-09-02 09:08:34 -0400)
>=20
> are available in the Git repository at:
>=20
>   git://source.denx.de/u-boot-usb.git next
>=20
> for you to fetch changes up to adee3ba577a6d5902b5af6c2368faf5f509003c6:
>=20
>   usb: host: ohci-generic: Make usage of clock/reset bulk() API (2023-09-=
04 18:25:20 +0200)
>=20

Applied to u-boot/next, thanks!

--=20
Tom

--1obUBnO1xZ0jw6A2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmT4u80ACgkQFHw5/5Y0
tyzzDQwAlB+ZYcMszyCxY3TyWg4Yherz6/pmK9wQl3pOb867701Q6s0E5/pIisVf
8hY8W0dmHrXkAjB2Ozvyh8OeDfXCQ/c1R4Uiaf0LY5WEWvQ0jqoLYycRA7OtGfb/
RhvHVgMPQVCWBPEumfhoblapmdoTlhuqUNj0Cl6gXe08sdO6csylXm2Vgq+CiR8J
TDKOJfjSrkwxzaDWtAtqvik/RqIGPxqWKVT6zi+dICpuE2ksdQYNwgvDvfrjzVmn
vZtPxqfNX3p32X8HHbhHgmtXAbi4g/lyzaIHdY0+RzGhSiqNxkch7wCD6UHp5FZ9
jE4fqeGyWJ4TbWWUbbanYjOmd557cLyB3bnEFjrkQLSQiE/kJZC1uo6KD1a0PZto
skGlzb8TCHjBoyMtmdHhDflh0D+6u4pBpUgMjm/x5QsezWHGNzdb0xiYxWnDm8P+
C+nnzOR5WbGNcyAVUaisuwzMMV6G8B6Z2cZkR+8+LnqUg6DwSxm+18i0MUXsYRBh
KHniQVbw
=5gDb
-----END PGP SIGNATURE-----

--1obUBnO1xZ0jw6A2--
