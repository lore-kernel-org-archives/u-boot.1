Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAFC8E77188
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 14:31:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DA5480241;
	Wed, 18 Dec 2024 15:31:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pxWX5zLZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B50A880269; Wed, 18 Dec 2024 15:31:45 +0100 (CET)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 979ED8022B
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 15:31:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-468f6b3a439so22515601cf.1
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 06:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734532302; x=1735137102; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3K4Rxclzvhds1TttzDQsjLltkj6oLufbUDCTc304nZ8=;
 b=pxWX5zLZumc8fRdfCerPbSTij6mI7Q+lG60oIZx9be3R3sWPbKl7DXUMJMjmULIIcT
 enSMPXF9o2WojYI6atGee0qoeTWwqZxsCFIsMQ0eOrZXzhxzdZAF7p32xRBobu7TG8Mr
 pGJOQkYOA4lYRLeNs36nQk2SHgMCYRhCcKRNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734532302; x=1735137102;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3K4Rxclzvhds1TttzDQsjLltkj6oLufbUDCTc304nZ8=;
 b=iFK3pzI9eu1Sjpi+ZVMRWjnZqGl3aMNSMTEKafChFO7HETY7wWDxW5o+cvcCKETgwS
 aBuGxBPudU8L5zm2TzFEAd7qvXtB+vZsd2Djk32plQQ+soN4ocIgskSNcxYzf9upKPzI
 U4Mc86A+3kqGH7QAvwGNo0BAnE2NCGlNG4TDVo2khpZ460cEwdKoTVycDkY1BeA38Dbr
 01iF21j/n9cchE2RGLTSKk+PqLpOdyPSQj+i18i5MwhxUyME4tyjBn5WEZ2TtJQhFj2x
 lm5oNIaainLAvhO1PdYF/Ks8zwGWskUv6RnIyKwje7JRmZdTbuQaLXgw3iLqgttTTqcn
 E4QA==
X-Gm-Message-State: AOJu0YyDoMkM2Vq1aD+a48tYtZRkMof1CRdAZE8EdKgKL5Tp5KCMXlB6
 lsYuKfxY4Yni+2EZ1KWO2UQYi7sZDkiswjCion6xjHR4O4f698TZolZxltifU2g=
X-Gm-Gg: ASbGncvP01Rqpptn3OX1D86A7+hs81BDOvcoBg7CuE45qdbi3cUS4RcOeC8CZzQZ4iZ
 hOMVumfMMHGA4eK6OdgLDyL1gdN6Hsdzw//5al9mtg41LLixl0r7B3snkdLXOcCxh7ARgsj5aci
 P/mqL+Q2IEmmyCmvZmYTceHUhnJFDygBtOC2DbDXTlAEMKLd5qNlOi/fseb4cyPMG53rvH5K13M
 1FJz8i31arVGIjpMPsdePHEwygah0xKzPSoj3I0n6Z1RrMffde9Js8I
X-Google-Smtp-Source: AGHT+IG6MeMNWk6jf0QHrWADFqvtkFOy1ZqM43aDsxzQ4jxizuzNnmYeb6PQOb3+osRJK9+3KHVGuA==
X-Received: by 2002:a05:622a:18a7:b0:466:9f89:3d72 with SMTP id
 d75a77b69052e-46908e7ca4fmr51084581cf.36.1734532302446; 
 Wed, 18 Dec 2024 06:31:42 -0800 (PST)
Received: from bill-the-cat ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-467b2cbb69asm51418111cf.39.2024.12.18.06.31.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 06:31:41 -0800 (PST)
Date: Wed, 18 Dec 2024 08:31:37 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH 2/3] gitlab: Resurrect the Beaglebone Black in the sjg lab
Message-ID: <20241218143137.GY1505244@bill-the-cat>
References: <20241218025540.3025522-1-sjg@chromium.org>
 <20241218025540.3025522-2-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pru7bYRj8SPXil2u"
Content-Disposition: inline
In-Reply-To: <20241218025540.3025522-2-sjg@chromium.org>
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


--pru7bYRj8SPXil2u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 07:55:39PM -0700, Simon Glass wrote:

> This is working again, so add it back.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
>  .gitlab-ci.yml | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)

FWIW, this has always worked, but I don't know if you changed something
on your labgrid side of things.

--=20
Tom

--pru7bYRj8SPXil2u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdi3MkACgkQFHw5/5Y0
tyxxawv/Xmn3D6g0DugsWd7UefnmlAmJfCw8eXD4zWFyYFRN6IeosAKdN/6tuwk8
Rx8hmIZYseftRxnjZUn4uUgy80OUDnX9LnZsv35X+zbk0QKTx/wrf15u4faLm+k4
iDrKmijiL6tx2SLoPeRRfDWMWdeYHRn5kOFEjpPyqsYcrsHaqKE8yFDfV9/AW925
UPZPIDM62KgD9XS3I7tD/U7DshmJe1vX3Z+J0sL41rlzs7ppGssathTTPeCQ9arP
VL9UgtvR91tXtB6gTEdq80oV9aJRkfnZUyn4NNY4E09w5dp7ylMHpcvzSuM1mS8y
ZtsuABAl1JhGQgSWMdoVj2/H0jlRCGsEpCqLrlT/Q4IjI4nEi4QQWhh0ACCijzTw
NyTv53CD/tZJmAYkfkOSkiHoOZUd6VD7kwjhtCokCbEX9SSg9RmqkazqMj9x36VH
IfZvB6CW2vsMgq9zjUvDQks8Frx5mQiUril0ph26rIk1ssPfxw9tQUyTDNkvPNRs
f3hJEpUw
=Q8tf
-----END PGP SIGNATURE-----

--pru7bYRj8SPXil2u--
