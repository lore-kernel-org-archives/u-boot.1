Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E406FC27C79
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 14:30:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1AE1E88541;
	Thu, 20 Jun 2024 16:30:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ic6PoTcv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D42C8854A; Thu, 20 Jun 2024 16:30:08 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02AFE8840F
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 16:30:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-6fa0d077694so421618a34.0
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 07:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718893805; x=1719498605; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=McOjGFcVP0T2RoTklLUZLcBL9bjpkcpsvgLxurpNY8o=;
 b=Ic6PoTcv3v2/bxnABdrVBK6V+bMQFjH6cZMxG55o/uX8DQb4LJYN6FMy1dl7c4nBFT
 nJCdiBIwJFaf9dL1sdsb1P3N1EoU17NrCXV1WnYnypzGg0v5pL2uPERNOkZYo0Q8mqAH
 kMEChQ4CK3E1KvX0qjNull3ye7n8X8Xe7eUlU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718893805; x=1719498605;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=McOjGFcVP0T2RoTklLUZLcBL9bjpkcpsvgLxurpNY8o=;
 b=J8iO58nkMlWJ70t/3wbWX4JxCo2rXiH7PBhSk4ThR0bo3ghLicWUFkpDf/aKN4IefN
 Ycc1dEuIK4kHEbp87lHjJd7AIp43646xVPz666tEdKINBNWG1LAjIUG5cxiYpUY1A4aP
 drjCuFfKNBzd9/6PUmD8hZKFnboI8wl/2z8EMsMX4fXmRp6l7QPmAZSeEvUJ4fCZABPC
 QgkpCSoqccodJOEktldIeKLk2Dob3Jr1mXLUQsz21YHmiFNQLrlVaP5epLYOJwmW9YVa
 IDRKzy2NEjuoV3axHtmjLqkXTFxMkHgeoDVM4oW2g1D7GsGf+FXQCitnHNNcHS9yZ+3l
 UXHg==
X-Gm-Message-State: AOJu0YzMVkZhU/U/F03qA6pjSfNBhy5LJ2tLl0P3j+F3Zsr8PzcyBaoU
 IKUgmRv43Mei10R2DbvqkpwZU0uCccTd8E87rx6KrexS+iLkOzJ4Mmgs56hR+OY=
X-Google-Smtp-Source: AGHT+IHrTyfRw+yS/59b8RcmgiqirrgW+vww+M1P5iACpOC8n87Meti6VAQcG7cEdwfFmtkoUaAt2g==
X-Received: by 2002:a05:6830:923:b0:700:88b8:c548 with SMTP id
 46e09a7af769-70088b8c980mr6717173a34.13.1718893804525; 
 Thu, 20 Jun 2024 07:30:04 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-45.totalplay.net.
 [187.190.205.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-6fb5afa9f04sm2545384a34.4.2024.06.20.07.30.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 07:30:02 -0700 (PDT)
Date: Thu, 20 Jun 2024 08:30:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH 1/5] Dockerfile: Add python3-coverage
Message-ID: <20240620143000.GL68077@bill-the-cat>
References: <20240620131937.1130446-1-sjg@chromium.org>
 <20240620131937.1130446-2-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="AOR9fOntVM5w5mYJ"
Content-Disposition: inline
In-Reply-To: <20240620131937.1130446-2-sjg@chromium.org>
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


--AOR9fOntVM5w5mYJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 07:19:33AM -0600, Simon Glass wrote:

> Add this package so we can run code-coverage tests for Binman.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

This (and same for patch 2) should be in tools/buildman/requirements.txt

--=20
Tom

--AOR9fOntVM5w5mYJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZ0POgACgkQFHw5/5Y0
tyxDkwv/ftZp9RQewXWogxiP49dsFnPbzRm3mdQPctIFFQ3OFIGSKK6KpEOKbjpM
fH6E+Ude0/1+7IOksxu2P3l2P2ded7eDjSqgXHX6ssI0U+3y5W4wqL2ZTqbghdfB
k77tCFjwQFMOeJFvG3UzE9GXjfgEKXUWMXM14w4PqoMXk+cpFGeLw6ciBnYd+qPy
Nl2mbvbBuxSfBJXe231HMG4JXRTPRMpulEgE0RFLtKpVnLjL3e6Knf+k0vz/yY7q
sgzcT+VJZwFrpVx2gcwLO1fCXIt9rOPHaBzKyWvaMTf5KBHhZjKmaw4KuT3QT7gA
8Hs89EvN6k+0ZoRECXUA4NYuDt/KqCx9ChsHsOJBcATgX0frGdmouSdEgY7cy1wd
H1+dBZaQUlrGGE4bjxsIKv09rvKLF7jotI8GUx0KuyD92QNnp4F5rRG9+IjL2/fI
o8hqoDC44PZ/i37ZuMtepXxxF1x0+inppGuF89DOBJ7/G2Ziry51YNlIATzSZENw
hDve0e0h
=Bs00
-----END PGP SIGNATURE-----

--AOR9fOntVM5w5mYJ--
