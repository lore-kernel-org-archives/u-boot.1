Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E889ECAC5B8
	for <u-boot@archiver.kernel.org>; Mon,  6 Oct 2025 15:47:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7648183DDD;
	Mon,  6 Oct 2025 17:47:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XEAaIT+D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E613283DF0; Mon,  6 Oct 2025 17:47:05 +0200 (CEST)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9A2F83C46
 for <u-boot@lists.denx.de>; Mon,  6 Oct 2025 17:47:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-911520e43edso203444839f.0
 for <u-boot@lists.denx.de>; Mon, 06 Oct 2025 08:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759765622; x=1760370422; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=11TguryrwmxdZBKPxTpw/HemMXxV2X5HriZ5dkKmCuI=;
 b=XEAaIT+DFojRFblX+4BFOrwc0QoGhHOypXBicgVunBsYno92d0Fx5/rvXjmqqwevRq
 cMIhgVuVa0OzbxKKvDPyof0qu6B4QO25VgVvsJhcKjNptC6SIXgY43Y480IQoBS/5jHT
 9K5hFyEOQf8g1Cgx6cm1iteoS1sGiK2w0sO/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759765622; x=1760370422;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=11TguryrwmxdZBKPxTpw/HemMXxV2X5HriZ5dkKmCuI=;
 b=r4XTpPqshZvF1TzmsN1TEkSXFp+3a/MvfHaEIk3jdS6mZAUP5oBihlTdEoyQhU6Qo3
 QG2oRd+pBU4YXbbzjA+uGP54jlEF+4nXA9ypERQJEWNGg0y3C06Dx0MqbeMlso3ZqDx1
 h/lSk0QO6GNQlJPs2gw1fDU83VJ7ur0I4lpVRK13OxHO+Qze4Vmy0sTeBH1Xc6dMcuIM
 vl14zgR1XhmldlCxAqOFmwAShLnADHsdNyNACIzlYc4TS/Rd86z0qRht/g/qxMIOgIpX
 KDF8FdwBi6PDQ9Do/VT0frEeysZlXTILhKpvoRLG4z24sAd9LcMnKI0t4LR9PtfDTFjf
 Kodw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLaY+6VtkgWbk4WjXxdEj6bTSKLdvSPoDqu85FRvJ2IU2jIPG42wX3davsypSZQa5L2lBBlV4=@lists.denx.de
X-Gm-Message-State: AOJu0YyLcWr9dDo76IBTWDqIsVeYMJCNcd1hmE2AedE1fsj5wtYAcMcV
 qHHUOHYhFZ6VzTjCkYvKnmHZs82DpBKuCjD1hN6DXxzvLN3XQaNjkwla4AVEerfK4i4=
X-Gm-Gg: ASbGncsg73A/Nm6fpzWBWyd65p5zzg0N2bmBlHgtAhyvyYKU9fZHmQNEpASv/yylHNF
 b/hoFZ/Ieyw7eWRzCiOpXq0skAHJ77MraD8bbhs//caM6hleKJ3CoFy31/57F1z656V6pwVijdG
 LCkVUVGAXYXFjB9VCFhc0iEpgzyeDTURsuX15Ac+PgV8MunSgIEMYOhV+Eh92V/LrHaiM77xk57
 pDJnUxXRY7+AUPuS5UlXpIN6HVzl21xJqGPtAdCMNZsSuJHHrKF+yZ0MIIQLG9a4tYMLsDF+qDi
 Yjub0GqcBA+2/e+4d3VDW50yHMQgXcFTO1BUQerxIQd6/BOuTKxJ6M/yDaLKNEuHSzZjoe0kijs
 EtzdoAeQpLIrarTgrx/1fXQXaBYZU9m7V6Lp6cVoX2SJfLBcX151ARN9Gfi6/CBR/1ZMb27K52Y
 eZR3nQjFJ5Qg==
X-Google-Smtp-Source: AGHT+IEQrwA92GstfjbIktJeA5ZgwHaqzJLRfeb3+/RdkkYdk/JrIkwHuAAOsUEVkkWup0+LdZZiIQ==
X-Received: by 2002:a05:6e02:3e8e:b0:42d:86cc:1bcd with SMTP id
 e9e14a558f8ab-42e7aced1a6mr172155545ab.3.1759765622212; 
 Mon, 06 Oct 2025 08:47:02 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-42e7b10610bsm43703935ab.23.2025.10.06.08.46.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Oct 2025 08:47:01 -0700 (PDT)
Date: Mon, 6 Oct 2025 09:46:58 -0600
From: Tom Rini <trini@konsulko.com>
To: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
Cc: Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Apurva Nandan <a-nandan@ti.com>, Simon Glass <sjg@chromium.org>,
 Andrew Davis <afd@ti.com>, Bryan Brattlof <bb@ti.com>,
 Udit Kumar <u-kumar1@ti.com>, Peter Robinson <pbrobinson@gmail.com>,
 Dhruva Gole <d-gole@ti.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Anshul Dalal <anshuld@ti.com>, Chintan Vankar <c-vankar@ti.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Garrett Giordano <ggiordano@phytec.com>,
 Parth Pancholi <parth.pancholi@toradex.com>, E Shattow <e@freeshell.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 open list <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 1/7] doc: make pdfdocs: Specify texlive-xetex as a
 prerequisite
Message-ID: <20251006154658.GC6303@bill-the-cat>
References: <20251005221057.255029-1-adrianocarvalho.pt@gmail.com>
 <20251005221057.255029-2-adrianocarvalho.pt@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Gojsjh6JPMqSvnb6"
Content-Disposition: inline
In-Reply-To: <20251005221057.255029-2-adrianocarvalho.pt@gmail.com>
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


--Gojsjh6JPMqSvnb6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 05, 2025 at 11:10:08PM +0100, Adriano Carvalho wrote:

> Dockerfile updated as well.
>=20
> If I don't apt install texlive-xetex, this is what I get with
> docker.io/trini/u-boot-gitlab-ci-runner:jammy-20250714-25Jul2025:
>=20
> uboot@35c89b9ab70e:~/u-boot$ make pdfdocs
>   HOSTCC  scripts/basic/fixdep
> doc/Makefile:89: The 'xelatex' command was not found. Make sure you have =
it installed and in PATH to produce PDF output.
>   SKIP    Sphinx pdfdocs target.
>=20
> NOTE: This won't completely fix the pdfdocs target. See next commit(s).
>=20
> Signed-off-by: Adriano Carvalho <adrianocarvalho.pt@gmail.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--Gojsjh6JPMqSvnb6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaOPkagAKCRAr4qD1Cr/k
ClRFAQCqvzkobtEmVxMVl3hC3qRAKirMVMJqo8LzBPZjDAvZHwEAjpmLQ9JFQEJB
e7XF8iER0b5VCVfYiXT41djVM2xNkw8=
=HP2V
-----END PGP SIGNATURE-----

--Gojsjh6JPMqSvnb6--
