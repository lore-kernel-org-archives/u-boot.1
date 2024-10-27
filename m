Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC654D1356F
	for <u-boot@archiver.kernel.org>; Sun, 27 Oct 2024 16:07:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0A6888E78;
	Sun, 27 Oct 2024 17:07:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SKGShNll";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7782F88EBA; Sun, 27 Oct 2024 17:06:59 +0100 (CET)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FBF0881A5
 for <u-boot@lists.denx.de>; Sun, 27 Oct 2024 17:06:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-4611abb6bd5so22829471cf.1
 for <u-boot@lists.denx.de>; Sun, 27 Oct 2024 09:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730045213; x=1730650013; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YN0Vz4emxmiwL6b2jBPdqPluLFBmzNl8bCfGCMRnoNQ=;
 b=SKGShNllEiqKPfgVcAkzYlNb0RD4uzMvYCtYMk20D8sRuu1PFYH4mOt73dKwB0ZlPI
 gN/DLbSvAkwcTPMlOFYBihxDvmZedy1Y8+6NFnY9O31WQRMmTCL+bnd0i+9fsOYsgh5A
 u5iVZRKrXn0VVrZD0zwn2uluQDQAujGNefkWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730045213; x=1730650013;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YN0Vz4emxmiwL6b2jBPdqPluLFBmzNl8bCfGCMRnoNQ=;
 b=jh8PMHezRw+XlzC7gd/FjW/jJaewzuNsAtqGKLRJjDZvrBnCetvxS0QuhwyfHR/oFL
 5DtUzdN/18128xrj09f5aQvDKnRmY/wc46XEXayh4fAVGaHz0kjrUa6Xy8+YN70q5/ZX
 vEqeScmaRNI7LRFX1/Iu10t2iHG+E/E0yGLkuANjDmprqVkodovP8Owvka8qLc0xMnsf
 mqPUwDBzvCKcr8LunPm6mAikgp5rlmTicR8DxT3Bd6rrHjU2GFFFmmGQJ5ArxFhH/ZSR
 Wmkvj7MXhjnTF/hbwpN6R18J7utfngCxqWdL/ehL4pwsIp8EcLcb5I416jWny+PKzYVs
 BRpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSCc+euPEGaVmnrJ6ypmp7QR7UtYwnQVJS1l1ZHeEunSzvdQ6TDcnE18AVfffWMTC0tvNszs4=@lists.denx.de
X-Gm-Message-State: AOJu0YzCZCEKn5PMSBuKhbKP+NmosLt70eeYaxjW6sleoibdbJvdRdOm
 we3kU58Gh1CnnYO1SB0J6QFrxvo8RftPjvyHPGZiZEaPlhHW3z5USu9jcaTfXCU=
X-Google-Smtp-Source: AGHT+IGR2my8v8VppODvW2XVoHjEwLueMucPq/X42SNt9Kz28SKlHG+R9VEML+06DPT+6/0MTjgkrg==
X-Received: by 2002:a05:622a:189b:b0:460:90e3:249c with SMTP id
 d75a77b69052e-4613bfcfc24mr89360781cf.9.1730045213179; 
 Sun, 27 Oct 2024 09:06:53 -0700 (PDT)
Received: from bill-the-cat ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4613211a109sm26524381cf.8.2024.10.27.09.06.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Oct 2024 09:06:52 -0700 (PDT)
Date: Sun, 27 Oct 2024 10:06:47 -0600
From: Tom Rini <trini@konsulko.com>
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Simon Glass <sjg@chromium.org>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, Anand Moon <linux.amoon@gmail.com>,
 Baruch Siach <baruch@tkos.co.il>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v11 00/13] net: tcp: improve tcp support
Message-ID: <20241027160647.GA1956477@bill-the-cat>
References: <20241009105054.1879054-1-mikhail.kshevetskiy@iopsys.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="M9Ko2/bbbjtfZ+2t"
Content-Disposition: inline
In-Reply-To: <20241009105054.1879054-1-mikhail.kshevetskiy@iopsys.eu>
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


--M9Ko2/bbbjtfZ+2t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 09, 2024 at 01:50:41PM +0300, Mikhail Kshevetskiy wrote:

> U-Boot support of LWIP is not ready for a moment, but we already have
> some kind of tcp support. Unfortunately this support is really bad.
>=20
> Some of the known issues:
>  * tcp packet from other connection can break a current one
>  * tcp send sequence always starts from zero
>  * bad tcp options processing
>  * strange assumptions on packet size for selective acknowledge
>  * tcp interface assumes one of the two scenarios:
>      - data downloading from remote host to a board
>      - request-response exchange with a small packets
>    so it's not possible to upload large amount of data from the
>    board to remote host.
>  * wget test generate bad tcp stream, test should fail but it passes inst=
ead
>=20
> This series of patches fixes all of the above issues.

Please rebase this as it no longer applies now that lwIP has been
merged.

--=20
Tom

--M9Ko2/bbbjtfZ+2t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmceZRAACgkQFHw5/5Y0
tyyCqQwAo/Xlp1y/1AFcUD/WwM4R9EqMMseMsr+YgU1LwyzBSkZIZYcagnxSEfpX
q+gfBXgRcR7VbMLYGW98Qv4iOHG2FMtOZBXZ/6s/7EGLIyaQI86rsRLLmUjdivRh
tAAJ5n1Zv++zYCFK6OV6JqIJLHrBYsmuYLOOFKQ+ooZ8jCOIkc66dnpBlW+F88Lm
ZH+Dx2H/I7aN5j5cw6ZBOcc5EtQ+Knd07s92MvCLkxN8YVsJrbU0piZd1VLk+DyM
RhW0lrme612sv8AhCWAL0AimlmO0qu79Ly+n5BDOJ6zshlgH3SWAIUygQO5Eh0XV
RKxjr1plBmKV4nQNcUceYSR+qeQScwOoLDHKUT1B2eE455KJBV/JMR3s7VHyNqu6
wklm3T7UkYlhraA9Q3EzlzRkPJFzfSWFjB/an5ANhuVMphTjQ7ArNtjk+G7SbTDN
mVfUuCiyCDnqTJjRUbfXVd070Vsam9ZDV6Qf9U5to8QiFfOH+VK4K5nz14+YxchZ
/3H1eKt0
=hqeo
-----END PGP SIGNATURE-----

--M9Ko2/bbbjtfZ+2t--
