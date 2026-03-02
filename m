Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4692EB362B
	for <u-boot@archiver.kernel.org>; Mon,  2 Mar 2026 18:38:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1993F83F0A;
	Mon,  2 Mar 2026 19:38:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gAM0FQ06";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47A5E83F2A; Mon,  2 Mar 2026 19:38:47 +0100 (CET)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29ED283EC6
 for <u-boot@lists.denx.de>; Mon,  2 Mar 2026 19:38:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-46413b2c3d8so1991198b6e.2
 for <u-boot@lists.denx.de>; Mon, 02 Mar 2026 10:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772476724; x=1773081524; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9UWugXr6/qhadyLD4G+gfln9gg5rngxsb0fUGjadNLM=;
 b=gAM0FQ06Ji8iQa3sa6HvqR5caKs8sS/7MdDVCgVcWQBWUu6X+fGF4n3ESY9KNUjqas
 P6pDqns/Es6H5cpygcJ4Ua6IT5BirxBsHaUebudlnkM8APzt2GKVpB/GtLWowzcqZ/Cg
 WyxApNzzu4SmI8b3v9AtIX9qHGgQgDDVa9nIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772476724; x=1773081524;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9UWugXr6/qhadyLD4G+gfln9gg5rngxsb0fUGjadNLM=;
 b=I+ORgvPhGH7rb0sB/X8fQtrzbz3nq48GGJc1ED1gAHhLmeH5tDYYwWlkF1EvnDSOCa
 rndCS90tG8zIQMlFGN8nuKW5DM+gYMB11fXANSq1dchA1FJmETEnG46T39iMZsUrkYlo
 52uzXbNEVgKI/16JdSpHRRP6CS9oWE7ykkER/284vREBR7C7XRYMZcXrk1SsaiUVLjae
 bS1dj+ej80iRSlPd0km8CczkoucjZNYB11ji/iZInThZwtWJ+636cUxoW8jBqsElhXxY
 iakIUqPeo95D9UQJklkB96BxNcD9I8BshYUtgOY8ZgSVSrKjrbzB7JLWGjLEzTvvzPZu
 QFFw==
X-Gm-Message-State: AOJu0YxSNh7UHmMRMp0UOo9YXScECumIPbItc9P8LIcHWUuBNjSbHy++
 EgXq9NjIEx0UMLZvllflLzztsGlR/ar1eB8PjEKaIC5TCZOJwb7ZZaznY/5sfnK6azY=
X-Gm-Gg: ATEYQzwyT1F/qNP9pLpbvuddD3hhB0ZL82ysLEjV+KwpO9Zyfs3e3Xxs+HV4UfgawLs
 EJETxAs7drSrouV2d4plbkudfdCXsDbtK9NagOKxyLbyZC1Zba27FHz/Y21yV972J9GU+/rz3YH
 Yyiq25JqulnigTDHL9aVwcBichc64lnFnfidbuwOmEym9SONtgn4nhtedOaAIMWiTAPlK4pOgPz
 itG7PlM7V+OH2EkCTeG+QICd+4xPi1UnF2kqJrxXCEtxsuv7rs7PXCvuWh9RGWsvEnp/PQ0y5yR
 EQCt4alCAkm35zcQNurAvoo6lZlbZScbmxJPpGiPgC6O/qF9efG3oMhfmADxSN0PpjzigkXeEQj
 wD5QvVRkbC6wZjFI4UxhdMsz62euJLE4TEPJDF7S+QqYW0hfLxU9D4xsBAk2H07B1U0EeTM0bE8
 7QAwNa/KmT0BmaxT7N4hevmE6A/NFxJ2y8gWJ5UfLpMk5LSSFIOYm4A6H9J431dqttYSjfkdcx6
 WwMauNFtPGwRbJ1LUM7vbeJBv3u1x9gO951jESOpMwB28sCt7E=
X-Received: by 2002:a05:6820:1614:b0:67a:1bd9:1a17 with SMTP id
 006d021491bc7-67a1bd92ab1mr204295eaf.55.1772476723786; 
 Mon, 02 Mar 2026 10:38:43 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-679f2d856d2sm9032580eaf.10.2026.03.02.10.38.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 10:38:43 -0800 (PST)
Date: Mon, 2 Mar 2026 12:38:40 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Simon Glass <simon.glass@canonical.com>,
 Aristo Chen <jj251510319013@gmail.com>, Benjamin ROBIN <dev@benjarobin.fr>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 =?utf-8?B?54mbIOW/l+Wujw==?= <Zone.Niuzh@hotmail.com>
Subject: Re: [PATCH v3 07/17] bootm: Stash bootstage data in bootm_final()
Message-ID: <20260302183840.GH1388590@bill-the-cat>
References: <20260228202011.1834493-1-sjg@chromium.org>
 <20260228202011.1834493-8-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5rUVg3YuoNmF9TQM"
Content-Disposition: inline
In-Reply-To: <20260228202011.1834493-8-sjg@chromium.org>
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


--5rUVg3YuoNmF9TQM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 28, 2026 at 01:19:55PM -0700, Simon Glass wrote:

> From: Simon Glass <simon.glass@canonical.com>
>=20
> ARM stashes bootstage data to a known memory location before booting,
> so the kernel can pick it up. Add this to bootm_final() so all
> architectures benefit from it.
>=20
> The bootstage_stash_default() function is a no-op when bootstage or
> stashing is disabled.
>=20
> Signed-off-by: Simon Glass <simon.glass@canonical.com>
>=20

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--5rUVg3YuoNmF9TQM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaaXZLQAKCRAr4qD1Cr/k
CtNrAQC02nvYuXOMm0Tx49FstvEhde8HcrVFIwZheqewx0I2YQEAk7xvhhiJXX6s
+EAQytwEgHEZOY3sYvanq9D/NpHbhg0=
=79WK
-----END PGP SIGNATURE-----

--5rUVg3YuoNmF9TQM--
