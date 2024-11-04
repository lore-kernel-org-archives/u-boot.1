Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 977D0D132CC
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 13:57:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F00C8909B;
	Mon,  4 Nov 2024 14:57:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RbqoG/Kl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7331888F33; Mon,  4 Nov 2024 14:57:04 +0100 (CET)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6935688F41
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 14:57:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-460c0f9c13eso36833421cf.0
 for <u-boot@lists.denx.de>; Mon, 04 Nov 2024 05:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730728621; x=1731333421; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=m1HpB8rMI+z/9vKHGylFMqV+W2JTEIpGcJzavbCA5Iw=;
 b=RbqoG/KlDThNad8J2J/Xe3vrudVTEODiqWOyRZH7+KkXxyiHW9trO0hI4Fj1f212Vx
 0Dg1xCM00m2N//n8QxoljiTi1YfULjAyheM6HK2UOwAMl5R5tAEMqGmgPbQazxENlVfd
 Rqum9TbVFwx8W0Zj/rGMafNUkGJHmnTWjohok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730728621; x=1731333421;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m1HpB8rMI+z/9vKHGylFMqV+W2JTEIpGcJzavbCA5Iw=;
 b=uRz5rROy4YzOErOYViz7azNt/NTALItBEjwedeVrrmhh7C/Hzd5NmSh5Ea/lNbWieZ
 LpwlWhKwF5y6dnYcUHUV0cMTDD4mu+Xc1dpJHePbtT+mfXj01uwBYa53ebd2xClRiI+i
 JZN/ge9ljkM7QYcL1iod3JiObQW90gv3VwE5XiBa1gyIoXWnyaPjdoOx32m/I9e+H+3r
 LXQGVzbvjzQntgc2mKcmopn69t60S9kPMCKcJtKPr0OYIIulkjPBJ324Dg0Ob4kh7uon
 tgADFCxyUKMLHELfbKV1Bdm9oJahCvQ9AFntjLpNSSibV1wFjv1mYIuzKgEZ0h9Sm5AF
 PMyg==
X-Gm-Message-State: AOJu0YzUD7seZQdqcjAUUpk2JG6HCv8VffFdrwlQ3Ro9L+EUNCfBdbgA
 dQsQhVOwDzMelExq9HY7xTXIJNaIW0YlA/QN+XudTE28jSHTKoEDz8yrNjUF3eIgrPs91iEfHyD
 SAc8=
X-Google-Smtp-Source: AGHT+IHXR22SdNTvAY2dALOUlZ3zfCoMXemGAzsek/cyqtAi5UWKK5ETwY0Uk98AtmW8oa1YbI5s/g==
X-Received: by 2002:a05:622a:1888:b0:461:2536:f226 with SMTP id
 d75a77b69052e-462ad2938c3mr231308341cf.12.1730728621223; 
 Mon, 04 Nov 2024 05:57:01 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-462ad0af2b9sm47023801cf.38.2024.11.04.05.56.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 05:57:00 -0800 (PST)
Date: Mon, 4 Nov 2024 07:56:57 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH 8/9] docker: Fix LegacyKeyValueFormat warning with
 PYTHONPATH
Message-ID: <20241104135657.GO3600562@bill-the-cat>
References: <20241104133954.840994-1-sjg@chromium.org>
 <20241104133954.840994-9-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="s0spA8JSuzfzy5pd"
Content-Disposition: inline
In-Reply-To: <20241104133954.840994-9-sjg@chromium.org>
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


--s0spA8JSuzfzy5pd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 04, 2024 at 06:39:52AM -0700, Simon Glass wrote:

> Fix a warning due to the syntax used for PYTHONPATH:
>=20
>    LegacyKeyValueFormat: "ENV key=3Dvalue" should be used instead of
>       legacy "ENV key value" format (line 304)
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--s0spA8JSuzfzy5pd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmco0qkACgkQFHw5/5Y0
tyxRCAwAsb82GNIt+9bWQxsftxvy0UUiK3UvP5+iIq0AGOPchMnUKgTv8614qAYC
abYk3Zxk0yb7bLPAhUPzzjRtZ2vT24CDtNcgJzioeZEa9C756j5EsJMu4ePd/DRz
VJIdt7ZtLkEc7hgTmh8qNkEZMxYs+vfLEXuRK1XhT51bHRHR939FRaWXyTgsWV6j
GxHtpf5i0YQPC90K9nK2CADaLQhCSgjcr5y/ehHefAT/PoyX36XC3Bn9tZMMwD4S
LhbgaC1sk9Qrxmxgclc2KKIrBMTHVVimx5XHAzVlgqBMfHGb9S39cc+4Fg62Qdwk
N4m82Oz2U4sFujz+WzI5aVjuYb2VWklLtpizw5/iQ0YN05w8oVwhXIEcIH1TPrro
1HSNSRSNvHUpIsGoCh5WeOwuJlzkjQBmBiotgVNyXCdkpLrrEba+prG8wDY7uV74
Uu3RRVLQdwwy7ZOlA0BdsCEHpDA0MkHbWBFvjj0SRslgpLsYq3L2cxJxWhVjvwzS
PvTdRehf
=CmgD
-----END PGP SIGNATURE-----

--s0spA8JSuzfzy5pd--
