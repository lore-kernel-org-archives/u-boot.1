Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14AE7D70DE3
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 17:01:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 956D989D16;
	Thu, 28 Nov 2024 18:01:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aQDwx9NN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34E3189D25; Thu, 28 Nov 2024 18:01:56 +0100 (CET)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94FDB8934C
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 18:01:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-4668f208f5fso7330561cf.0
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 09:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732813312; x=1733418112; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Ss1MReMNS31DkNbnzqNClcFVVIfsKhvdU67/8zDr1Vs=;
 b=aQDwx9NNoa8ySTZ1EsjNZFNvNhQrhX59dHQBnZAoVo39dZ2uBUJRpKfbdZRV8hSxJV
 Av7DiBqJ1j3WDHp6UzmRdp0g/vP+GyReD02MojtV4hPhsBPadrm8cPsXjE2eBxxejq6f
 Sj/Xo19cviIRUA0UoK4qk1UtnZKn3TcfEPn9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732813312; x=1733418112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ss1MReMNS31DkNbnzqNClcFVVIfsKhvdU67/8zDr1Vs=;
 b=EMmdsWq2ZJgjFEEAN+JmTfnkJJcASNEO45iUFu+fVsOFxe8H52x66+fcOt95qLAGps
 psohovIobr/D22O2MxC5s6ztKQVoUQ171T6SqEf290BTZwmbkz1LK/HbZMPIg1WCbEY3
 KqVTce/Cu6C5Jaf3iaL5jDhxIPkVnKg/ybZ/Jb89Q8+9u9UfC71rtuZhYsOAksPmg70g
 Gl5YN+x8kPVNesbAK/iZh6IF4SxXJ+k/vp7MpMmM/3Ep8vuADUn/IUXTXG3dRItGFURj
 peXgaQahfexMENtNTOR0ylBlKamH2/WvDEo0ZM4yf8jzRAlHTq/5WgGEbax2iUv+WVLT
 v+7A==
X-Gm-Message-State: AOJu0YzU88RCdGe6p+pVlJB3X9U/10baZ0l1O8zN2tv3FSWXT/SxoegT
 3v1MD4aj3Y9d0kXMnNGLIVyd84CzC4/O7iacdFeV4DCDt9EHaZ7lRmrwxrHAS+k=
X-Gm-Gg: ASbGncu5t3hmF8WuNMGE93Ul1PfvyYnYBEXJ6zWpv4H0LqN5hK+BHT8vjbTrj1Z/8tz
 smrOH0J3A5UmuZhXdVz/gdUWdA3Uw0piiJB2PGcVUzHbSGAaUZl7YDfCl5qvZsmRyHTJJrx2ULb
 zNy8vLGmLiEVHoSpAG/SksWFhdZcNpTr6BLSK1BZwDB/L7uw8oqm05I3ozEnCsGHt9ZOViejefc
 efrUuCZVLyXpbQsSajHrx/Ra9uUtO/OTmo+XfZIzKktVlnflg==
X-Google-Smtp-Source: AGHT+IEzpvqUXFgLvRNuF5xx1giTYJXfQ/OOrYxtr5f+/0OUhy3KPt7/ggaUjvRGjvzeNaawPQcfoA==
X-Received: by 2002:a05:622a:14cd:b0:466:886f:3774 with SMTP id
 d75a77b69052e-466b3499d29mr111661761cf.8.1732813312357; 
 Thu, 28 Nov 2024 09:01:52 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-466c4241d2esm8275591cf.79.2024.11.28.09.01.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 09:01:51 -0800 (PST)
Date: Thu, 28 Nov 2024 11:01:48 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>, Sumit Garg <sumit.garg@linaro.org>
Subject: Re: [PATCH] CI: Add gitlab tags to builds which can use all CPUs
Message-ID: <20241128170148.GF3600562@bill-the-cat>
References: <20241128160011.780550-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="q+rpwuhOluhcx8hX"
Content-Disposition: inline
In-Reply-To: <20241128160011.780550-1-sjg@chromium.org>
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


--q+rpwuhOluhcx8hX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 28, 2024 at 09:00:10AM -0700, Simon Glass wrote:

> Most gitlab runners are mostly idle at present and could happily run
> several jobs at once.
>=20
> There are a few exceptions, such as the world builds.
>=20
> Add a 'single' tag for the exceptions so that they are dealt with
> separately, with no concurrency. This is not quite perfect, since it
> means that a 'single' job can be combined with a number of normal jobs,
> but in practice this doesn't seem to matter.
>=20
> To use this, for each existing machine, add a new, separate runner, with
> the tag 'single'. Set 'limit =3D 1' in its config.toml file and set
> 'concurrent =3D 10' (for example) in the global section. The machine will
> then pick up one 'single' job and up to 9 other jobs at once.
>=20
> In my testing this reduces the time to complete a CI pipeline.
>=20
> My choice of which jobs to mark as single is mostly down to how much CPU
> they need. For the 'docs' job, it runs for a short time, so doesn't seem
> worth marking it as a 'single' job.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

This is an interesting approach. What will work better long term is
adding more runners with the "all" tag because as part of the rework of
the Gitlab job I've done and you can see here:
https://source.denx.de/u-boot/u-boot/-/pipelines/23588
(but isn't ready to post as Ilias wants to look in to the sandbox+arm64
issue) means that every runner needs some tags and for runners which can
handle multiple "small" jobs at once (as the first two stages are
building a board and then testing, or similar) we can make use of that,
and then restrict the world builds to the fastest nodes only.
This also means that things like the Oracle "always free" tier cloud
instances could be used for example as an "all" jobs node, I suspect.
And the same for any other cloud provider with an equivalent tier.

--=20
Tom

--q+rpwuhOluhcx8hX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdIofMACgkQFHw5/5Y0
tywkMgv8DCU68jQaKD8l+Mq5zSsngN82FYCSs640ObBfl22sEU0uK4AzOhsg2hRk
e8Oajx+1I3Plq3NIjMYekFqKx6BvdvwJKMoWhrfWOQ9SA2K+EZ2uTIkCkbH4+X/j
RSxfRrVh+oyT4NoZD9wNGbIXl1MStIkGxAnUZIgPkfv2uI7bR5fD2DDBj0LdJ5zZ
8keBdMRhH6tenRcNW8AE2joo5FRAzFCCdHGfQAql2qmne2l5ixom5VuJB8PQreR3
s1v1/ob3rTcR+ZJ73M7Ipsy2d/jcSQuFVEIdj09KD+VPYvfhDzvzHTvIG5PS2TNB
5BnXX4W/xOgzOt2mY9tgK/K6D8YZD3jv4Y94Iy5MjR+6I1gwkDZe6MHCdzgD+nyP
MJFRBmko7NV+nzPhEYpParO6viZW2cocuoZkEw9tqR4r26JaxYGS20T+t/YQ/9dP
g4upYDPaQO83sR2GuBEvxoAeo9Ql5cCNXYgw4bsEPfrJA+odNUfIXYHw0jlySvm5
ipBc8YoX
=G6jP
-----END PGP SIGNATURE-----

--q+rpwuhOluhcx8hX--
