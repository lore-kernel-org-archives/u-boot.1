Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08488D18153
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 21:30:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F6FF891B3;
	Mon, 14 Oct 2024 23:29:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MjaI7kEU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 866A4891C1; Mon, 14 Oct 2024 23:29:57 +0200 (CEST)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EA9188D1C
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 23:29:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7b1141a3a2aso451969585a.2
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 14:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728941394; x=1729546194; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Mtx4dVz9u2k95wuf9mkg+2mpNYfuj0dq8bxpPJ5lngw=;
 b=MjaI7kEUcZGaLq7mpDz465DteXo5tcreTKki/zE7zeAJ78REpInMHutqgevwBCIMqg
 EMfoFQqobrUNO2VGuQ7Hi3Mj5wPbEt6/aGMulxObo4993wj1fWBP7T3Q1Am3Q6jJ70uX
 4S84tCKhJSydvDKmOuFU2tX5LLxtpzZ2eo0cw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728941394; x=1729546194;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mtx4dVz9u2k95wuf9mkg+2mpNYfuj0dq8bxpPJ5lngw=;
 b=QOGwADKaVoifGUusnlF+iGwMFzr9TzuM7WckW5sPmpAmKMDTQuYG8/Q6IYU1ozEalr
 PnZa+KcuMStAHZflnc8SvdIeiGqt2z8mSK2KJ6eKco2nsves6+h8mHuzkLQfl/otrsUK
 0lKZujgoD6xusETiCkawIDIi3W9jvNsk+yS8vesVI6BYj2B5bskv/xW765GfOQLdw//8
 ZxdTQ2rXAhMr8wfwniQR2SjV+RqDqVp7WROMUQHfte/DCHBOVa97ROhfV2Xa+f3MO1Mp
 Y0eLEpTF9LP7RBUj+3m26VRq61kK7IAk+L/+1BEutECTlHYx0NH8pBSm1+prhe2qhx7H
 Ecog==
X-Gm-Message-State: AOJu0Yxr31JujPR/FS7BfQtuFbgTIwh37t+8EWAkOHA8Xaq313pGVx9O
 lvDKiavQZEAAnES2D3rKb0b780tWnoAE+u5CgKiVIMVbkToO4K3onMTNi3x+/wo=
X-Google-Smtp-Source: AGHT+IHemwCvyEdNkMKTdheWSS5uQmuBIoRCxpUTNGXhXPU8lfSK6DhUC7bT4coT1VhAY7tgQnt4dw==
X-Received: by 2002:a05:6214:4588:b0:6cc:813:13d5 with SMTP id
 6a1803df08f44-6cc081314bdmr91495066d6.17.1728941394189; 
 Mon, 14 Oct 2024 14:29:54 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cbe8609811sm50110146d6.78.2024.10.14.14.29.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 14:29:53 -0700 (PDT)
Date: Mon, 14 Oct 2024 15:29:49 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@arm.com>
Subject: Re: [PATCH v4 1/5] efi: Drop the memset() from efi_alloc()
Message-ID: <20241014212949.GA53053@bill-the-cat>
References: <20241011212126.747741-1-sjg@chromium.org>
 <20241011212126.747741-2-sjg@chromium.org>
 <20241012012004.GD14210@bill-the-cat>
 <CAFLszThqX2T0uGmAYvacpPhM_O_JNG9A+wtd0jxmn4ynAuHUzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pcoEn743ytVH4366"
Content-Disposition: inline
In-Reply-To: <CAFLszThqX2T0uGmAYvacpPhM_O_JNG9A+wtd0jxmn4ynAuHUzg@mail.gmail.com>
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


--pcoEn743ytVH4366
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 02:20:42PM -0600, Simon Glass wrote:

[snip]
> I certainly don't want to be implementation-compatible with EDKII.
> Where did that come from?

It came from Ilias pointing out that EDKII does this too, and so we
shouldn't deviate from that, and then you re-posted the patch with a
reworded commit message, rather than dropping it. So I'm just
emphasizing goals for the public record.

--=20
Tom

--pcoEn743ytVH4366
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcNjU0ACgkQFHw5/5Y0
tywTJgv/cgON7wXtLqrDA5dAYNb6YBjeI5CjX1mYdn/J0S+OonYewyeYh7UGWgz8
vgxnSxO6oHw3hAbItXHe3jZjy0ryCweBB+Y4Yiez1iRKtqwbYPyYX3Q3hZqpevC7
LFTHNs+Gt4XAAZIsQ3WJMEmqJT4RTwFW0ZBBjQJW/oMo3K717p5xTXfZaDLzeiDS
ynXdTdAa8Psq9TXiO17VE/q0Q9MUEhN9bguSl4GdRUOzF1PhbJa9phZfkMQSq5Zs
OqcplnJcnQ/OTjtN29Vdm3n6mUD53YwENjt5ZSWZ8Eg4C51bYsdv6PbhDT9qTtI2
xyHz4/PX/TN5kS9WrDHtUn2iiM+qGME1C8tORLmVhCjGAVxdUR8wZ+buFY/m8BWD
rK/PyJ7xYoWo80VjTOqWxo9iL8OGLRkDNONGSJmQvmjGrd3KSae3KhYrQT6nKJuO
0P+o8a2pwfd76RLGG2n2iniiVTMYxXB5925sD7PmvAAMRMJ/ziuF07gQEBA8+soY
z1Ik2r+M
=Bcph
-----END PGP SIGNATURE-----

--pcoEn743ytVH4366--
