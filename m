Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4E55C4452A
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 14:32:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77D68838D7;
	Mon, 20 Jul 2026 16:32:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EuMOTDyd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBF1C838D7; Mon, 20 Jul 2026 16:32:03 +0200 (CEST)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90A9180517
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 16:32:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-6a374c190beso3525633eaf.2
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 07:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1784557920; x=1785162720; darn=lists.denx.de;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Exlhzss4KEl214jaXPOmEM2aNxvZ5ZCb8cw06zCiv/I=;
 b=EuMOTDyd+GNcEQ5UQVDPrx2tj1xpsTK0ItByeobqdPDnqXz1Q47R/bZk2Tydhw4JA2
 GRJMUku4NdmAOBXT7eA//jauHe5iPQ7mPpuZREFz/RgbM2gP92rgcX6DcVclkBaTl/rT
 U+bzNjQSfIfS0WMRYmc+PVi6DvKqvwvw2rIU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784557920; x=1785162720;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Exlhzss4KEl214jaXPOmEM2aNxvZ5ZCb8cw06zCiv/I=;
 b=EkC6d8bRSvdIBmNoWQ9YXrXoqEsuYMzzSIwOzFa2GhoZtHoatI/T8mZ40nfl3BDIN/
 mdtlKrCd7B2+cg0httPECZDRiG9/7IjS72JO/zIisrqGcGmNuAzzF63OIPY/9kozP/Ih
 hvokwrd1sjVGGrxpbVhAHIA1qBYkntuFUSa6m3wgIz19DvTZ0/OeactDHulVuTYcxq40
 SL36FmtiIqdYutka3zqdmrXPd9LNt0C9QUp+8FpKkMyxE8T1YYIGVIO1S70VeV5qslWW
 RS1JzksCArSJ6Gv/PmlG4XU/D5Ddc34eNv0NrPrnARVDJME6WJ1QXVlhw7GBPS6fL/Pa
 qGWw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpK13kHGrInU+SL3ZanAoZtbN/2J1hTPG22YflsmJnWYREvbD4q0JFtnVBjTZ4BImQEd+IaOSw=@lists.denx.de
X-Gm-Message-State: AOJu0Yw5yiIQuzf5bFwOtxiHSn78IyWv+dl0BM+Oyeaxn8xjUbE/58ME
 QDPFLOydQr/xhomkyetMc9fKS4tmuOQ+q7n+H8N2wY31PkcfYAsEzcKt90SbuevK9Tg=
X-Gm-Gg: AfdE7cnbEnuSVMfsK8QKiT58YEIIqXimOaj6JEtq/VOkN12XrccYe8OxQAzruhW2DZm
 rfLfoM6xshPYJpxNFOv2sKisdiZToYMG0oJ8U1j0EPpi9wSUAOVvcPnuCVfKN75u1DWAnCb2LiI
 Yq61EhQA72n8Dh7Vrv/dGeSJN/wO0E6oDlGk7nt4pMRZXuWdjNaKmWqtL3iYO4quxm8/ERD6M5B
 4VPzPZTZE0weAkBt+0MtO/OUfTqc80t0FPv8aatwzBlS8rIqqgMACnd7CYyfQpPOJLJlLcgaLl5
 zzimmVnVuHnLNVt+l7Vm9R9zleTqIB9a04b5OL4mtT4X6+HQDxJ1RxISkvizP3mo665v0mx6YcP
 6F90evCD8QAsRHQIYP//zlmBF1dMtINz0iednMEb8nOgtI5Eluemw2yRFKqkUo5xtIGRijw9BG/
 tjAritPIZ4rTycIId/q3J+K0AVWJlXarxW1VLbyZqNrjeJDLaTDeDhQPanvc76QZ4v0do8tpZja
 GPLl7oqSlwx8k4oExKkwH1ZNoU=
X-Received: by 2002:a05:6820:216:b0:6a3:5bd6:d9fc with SMTP id
 006d021491bc7-6a5368936bdmr7440057eaf.62.1784557919968; 
 Mon, 20 Jul 2026 07:31:59 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4568e14afbcsm7867720fac.7.2026.07.20.07.31.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 07:31:58 -0700 (PDT)
Date: Mon, 20 Jul 2026 08:31:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>, Raymond Mao <raymondmaoca@gmail.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] CI: install python-cryptography for world build
Message-ID: <20260720143156.GZ749385@bill-the-cat>
References: <20260720131325.37436-1-casey.connolly@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BMpQicDrT/Uo/cOD"
Content-Disposition: inline
In-Reply-To: <20260720131325.37436-1-casey.connolly@linaro.org>
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


--BMpQicDrT/Uo/cOD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2026 at 02:13:22PM +0100, Casey Connolly wrote:

> The mkmbn Python tool used for some Qualcomm platforms needs the
> cryptography module, make sure it's installed so the world build can
> succeed.
>=20
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---
>  .azure-pipelines.yml | 2 +-
>  .gitlab-ci.yml       | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
> index 4417ef4e5a50..562c5747c9d3 100644
> --- a/.azure-pipelines.yml
> +++ b/.azure-pipelines.yml
> @@ -733,9 +733,9 @@ stages:
>            python3 -m venv /tmp/venv
>            . /tmp/venv/bin/activate
>            pip install -r tools/binman/requirements.txt \
>              -r tools/buildman/requirements.txt \
> -            setuptools
> +            setuptools cryptography
>            if [[ "${BUILDMAN}" !=3D "" ]]; then
>                ret=3D0;
>                tools/buildman/buildman -o /tmp -PEWM ${BUILDMAN} ${OVERRI=
DE} || ret=3D$?;
>                if [[ $ret -ne 0 ]]; then
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 245e422d72fa..eb13fde82b86 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -153,9 +153,9 @@ build all platforms in a single job:
>      - python3 -m venv /tmp/venv;
>        . /tmp/venv/bin/activate;
>        pip install -r tools/binman/requirements.txt
>          -r tools/buildman/requirements.txt
> -        setuptools
> +        setuptools cryptography
>      - ret=3D0;
>        git config --global --add safe.directory "${CI_PROJECT_DIR}";
>        ./tools/buildman/buildman -o /tmp -PEWM -x xtensa || ret=3D$?;
>        if [[ $ret -ne 0 ]]; then

Ugh. This shows (a) the CI pipelines had another place that should have
been installing scripts/dtc/pylibfdt/requirements.txt and (b) I don't
know if we should make either boards/qualcomm/requirements.txt or try
again with a top-level requirements.txt file. I believe before Heinrich
disliked that I was including other requirements.txt files in it. I
thought I had said something in reply, but it was a while ago.

--=20
Tom

--BMpQicDrT/Uo/cOD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCal4xWAAKCRAr4qD1Cr/k
CnOPAQD4HP1EPOx88v1Bb/VQQVjzh3n82KZ2Z7/FBfOZlso5/QD/bvsFGHgXpeMy
lvGF0575EyjTowT72t7UdN+e8fkHkgg=
=RmOd
-----END PGP SIGNATURE-----

--BMpQicDrT/Uo/cOD--
