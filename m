Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 058ECD16271
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 14:02:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5577288FC8;
	Mon, 14 Oct 2024 16:02:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mklhRQPg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4C2B89063; Mon, 14 Oct 2024 16:01:58 +0200 (CEST)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4042D88970
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 16:01:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-460371bfda4so36136271cf.2
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 07:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728914515; x=1729519315; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lCo7waPttqAA5QgwICKrZZc3YKLjD6E/v2X70dp+QZU=;
 b=mklhRQPgwlFP/I+ums5ZhX7d5FoXNzj9kJ076mrWNtqmt002EDw+fyLvl/muMNWQOJ
 +ssMH1mxGvGEynOoJLdyglp2vPDLP3Ik/t+KivuO7gvTbPdFIW0YP7U2a8SQN224WdiW
 SikYYs+xb/8A9+EGfq6nS6TLmuqO758ioDz40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728914515; x=1729519315;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lCo7waPttqAA5QgwICKrZZc3YKLjD6E/v2X70dp+QZU=;
 b=Yl0xQhTa2VKK4Mx6gc5xy9R6xtKHVPMG1qtUHkXDsjCsdbONlb/Z5ZsH+CE6+nZpD9
 GWdAmVTgTkD88Ld+KUZGecLPaqW1UbysbXwz4fwaICMex8o5cE7MvNFz528wo25mwyEl
 xc5laGGMoppFEXwT3bwJT1tM0nq4BrHB4Hrf1KM1QM88BQMm4nWDQOYKkxuS40DlQ6lw
 ApM1Bxzq6r+NaqbaoOtrErrYmLS0qfK57PFDFESfb0tQhJ89L2fjs9nF0QRJjBexJ0bW
 kCRBYH9Etckw9jtXIKdUjCfr+3eX+77eRBPpMgLLUXefNVzoTFPsGGLvNW61Yu5KvrVh
 c13w==
X-Gm-Message-State: AOJu0YyPsrbvak4i/SIEpupZsHYFZa+zw/5swMXI5Nt93fFuvnFHn9XL
 uVaB5QlsUymrdmq6vChK8psh1CwaxLEkEaLJbyoP+8eDYIwc2z97+JlUKxP7Qn4=
X-Google-Smtp-Source: AGHT+IH8h1TC+0lmm6hZim51WXLedGpoYMYQUjMNMmff2JeRvp5RRgLOBlKMwjG7lvnjR1+DCtNVZA==
X-Received: by 2002:a05:6214:5b0d:b0:6cb:6059:92a with SMTP id
 6a1803df08f44-6cbefffe61cmr179705856d6.10.1728914514997; 
 Mon, 14 Oct 2024 07:01:54 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cbe8679a66sm45307596d6.141.2024.10.14.07.01.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 07:01:54 -0700 (PDT)
Date: Mon, 14 Oct 2024 08:01:51 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PULL] u-boot-sh/master
Message-ID: <20241014140151.GF53053@bill-the-cat>
References: <20241013225123.427552-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/BDhUs9mBwmISYBC"
Content-Disposition: inline
In-Reply-To: <20241013225123.427552-1-marek.vasut+renesas@mailbox.org>
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


--/BDhUs9mBwmISYBC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 12:51:07AM +0200, Marek Vasut wrote:

> The following changes since commit 47e544f576699ca4630e20448db6a051789606=
97:
>=20
>   Merge patch series "Tidy up use of 'SPL' and CONFIG_SPL_BUILD" (2024-10=
-11 12:23:25 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-sh.git master
>=20
> for you to fetch changes up to edcb15c583bf259bc27db1e7073fc79784be8bf7:
>=20
>   clk: renesas: Synchronize R-Car R8A779H0 V4M clock tables with Linux 6.=
10.9 (2024-10-13 23:21:26 +0200)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--/BDhUs9mBwmISYBC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcNJEgACgkQFHw5/5Y0
tyyhowv9HJzO9FT0vPw0CVYWzcLq7Uebcg26otEqscYE9PTORH7QfJHrj5yawoSX
C9F2C6iHbAXV2tl6tNft9nuxme3/kZTWdlUIQA8VKzXsZxGDKOnZShJu2Kxpm29t
bvRYqtBBkCjzfl+vnydJI3/ZvmkdcPRv78+cgbuNz8HRIARDztVNuY8xxZ9i6gqu
F2egVQvahsBalevXNSw+dxsr5R0/8JOm9x0F93JQjfDoSUAilcvL7ik+HO9fAY5r
jAPjBsoVvX/RqR6Xce9/GQBMnvOVfn8BgxbIw9BR1Wtynzje0oMwy1lLV7pLVLSV
TlVQEsKfN8dyVNH/68tdJWm+x5ge4HTwe5pbEGSSnwEC2stzfGRuys+s3WQZYA1g
M4K1x/t9k/ya9vFl+a7nnIdUozr7EJfcWD8EMwfAyq3fbA+8iprCzB3TYjB2CtqY
la02Nwmr5Zm66/YLt0BqIY6KYjtHRlymnMplA7UfMfz1NGXMsjeZFnwj1Mdt6GzF
b18UtJJQ
=AcSR
-----END PGP SIGNATURE-----

--/BDhUs9mBwmISYBC--
