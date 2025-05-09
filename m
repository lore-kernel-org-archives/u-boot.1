Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EDF4C3ABC3
	for <u-boot@archiver.kernel.org>; Fri,  9 May 2025 15:01:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 682D48283E;
	Fri,  9 May 2025 17:01:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FVSE96s4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63F4482162; Fri,  9 May 2025 17:01:34 +0200 (CEST)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 306C58283E
 for <u-boot@lists.denx.de>; Fri,  9 May 2025 17:01:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-6049acb776bso1155129eaf.3
 for <u-boot@lists.denx.de>; Fri, 09 May 2025 08:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746802891; x=1747407691; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QhXfcysshkfiZUNibw0F/BC0vifrmCMxJc7G5d1jdgM=;
 b=FVSE96s4ONhS3LZqkMBKYIjp5mvo3WXbVWPLs7VfgITnJWPK2FArPZNiedfhAcXg9X
 byN537Yzp6W6DuiPfwGxXnvtgzQJtp/S/bMBru9CKPpLhfJyjlrK5NjZT74ENci/bQx8
 4zaJ8cEzyd9x9dCIdESS9cvUCQWecInZ8Sd98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746802891; x=1747407691;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QhXfcysshkfiZUNibw0F/BC0vifrmCMxJc7G5d1jdgM=;
 b=maZaMP51UxHTS190YbMp06RB+Sc0e2V92E1bUgmV44Q6VTZryl8ZrvLoS309Ed4IMy
 n7ecgBh4VbwTiVLPd8mm2jvqyGB5My/ID9/AErxV56bXPuflNQdzSY9w7jPivyhylqQX
 G3R7CQ9LDenykgo1QA7OlTIEii+S8ezlaYKd2yl/64YgGCzDX/Qzog0t5Jpf1YoSS8p4
 SA+dn6LeA3+KbhVioBNaK18GX/7N4snDBxBi4vpRRLZjoHeoAvYsFVTuea3ZllacHYvz
 YvIFkWOe88y0VvPQi6ObMyGcdiwVwf6KswOObXrBN/80Sd0JYJyH/Uwa8AEkvkJ1vZKB
 sr1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEPDf7pi7eaqCWfD2am6Zq8ymtHIH50h5bYpCzUkwAtzKTGD4hw/+AsFw02cYEb96BwsQjJrM=@lists.denx.de
X-Gm-Message-State: AOJu0YzDfczhD16QLLEkQISfUfnhFrZI3IyUa1/YwvXx50pKox/yaBIz
 GQYiOXMs41GS4PDzDpjrDkczK8EZb4C0ggqoqlkSmEycwgy3dv55xjvuuh2WZ54=
X-Gm-Gg: ASbGncuxAqMzPixammNW3lcAa+EpD5vJfg+lIh4/adFwCSaVxtPsAzKpaNK1CZDkqNc
 ZnPrdnClvU/N+o8/Mys4xEJWaym9JooyVvSEHRN/Sz0+ioU/TynGCG0/cWd6BqF7d6R4heS/kO8
 6AAcD/FgfhkQGT16p3YKccPEfAa0z8enk+2YnxrLU/T2KPPLk//d0b4HboMAUJ5WGYWtOp9PZL4
 taHXNamruqTOVnBSs7qasTTrSiebTuuIirrDGdhAHHV7KTuWg9sSTMpaZpaUP1QaoBKGmtGRmYh
 /+NvJyFBb15g0YIiKxoPeJwryAJuwuhfnPs+eJWNUt9M9TRCvlQBojjtKf+1/WfYhfix+mhHTIA
 yXA==
X-Google-Smtp-Source: AGHT+IFu0sOKxdQwijOXjZ9nWfzdfuGL6MuzRWor+JucilxSoVUooFl/hHWfCz5WGsRJ74q96kC+Ig==
X-Received: by 2002:a05:6820:2004:b0:603:f2f6:fd41 with SMTP id
 006d021491bc7-6084b647b48mr2280000eaf.3.1746802890658; 
 Fri, 09 May 2025 08:01:30 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6083fe0392fsm482481eaf.2.2025.05.09.08.01.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 May 2025 08:01:29 -0700 (PDT)
Date: Fri, 9 May 2025 09:01:26 -0600
From: Tom Rini <trini@konsulko.com>
To: "Baehring, Olaf" <Olaf.Baehring@draeger.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Gaurav Jain <gaurav.jain@nxp.com>, Marek Vasut <marex@denx.de>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: arm:, imx:, caam: [PATCH] bugfix CAAM error on startup
Message-ID: <20250509150126.GI603748@bill-the-cat>
References: <BE1P281MB229278535DE4B55BD7240B14E18D2@BE1P281MB2292.DEUP281.PROD.OUTLOOK.COM>
 <a0971d75-fb68-476a-9d65-025584231859@gmx.de>
 <BE1P281MB22929674BBA49DDCF59D404CE18AA@BE1P281MB2292.DEUP281.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fn/+f8gvSFPTlTEs"
Content-Disposition: inline
In-Reply-To: <BE1P281MB22929674BBA49DDCF59D404CE18AA@BE1P281MB2292.DEUP281.PROD.OUTLOOK.COM>
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


--fn/+f8gvSFPTlTEs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 09, 2025 at 09:40:44AM +0000, Baehring, Olaf wrote:

> Internal
>=20
> In rare cases U-Boot returns an error message when intantiating the RNG
> of the CAAM device:
> =E2=80=9CSEC0:  RNG4 SH0 instantiation failed with error 0xffffffff=E2=80=
=9D
> This  means, that even when the CAAM device reports a finished
> descriptor, none is found in the output ring.
> This might be caused by a missing cache invalidation before
> reading the memory of the output ring
> This patch moves the cache invalidation of the output ring from start of
> the job to immediately after the notification from hardware where the
> output ring will be read.
>=20
> Signed-off-by: Baehring, Olaf <olaf.baehring@draeger.com>
> ---
>=20
>  drivers/crypto/fsl/jr.c | 30 +++++++++++++++++-------------
>  drivers/crypto/fsl/jr.h |  4 ----
>  2 files changed, 17 insertions(+), 17 deletions(-)

You're starting the email by saying "Internal" and then there's:
[snip]
> ---
> This communication contains confidential information. If you are not the =
intended recipient please return this email to the sender and delete it fro=
m your records.
>=20
> Diese Nachricht enthaelt vertrauliche Informationen. Sollten Sie nicht de=
r beabsichtigte Empfaenger dieser E-mail sein, senden Sie bitte diese an de=
n Absender zurueck und loeschen Sie die E-mail aus Ihrem System.

So please confirm if you are intending to publish this fix to the open
source community, or not. Thanks.

--=20
Tom

--fn/+f8gvSFPTlTEs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgeGMIACgkQFHw5/5Y0
tyxKrQwAh4OFg5P1fQ5HxNichAjYXCEclioQpVCnOvBAvytxGa+6HWKBjZr9LH3K
5IN1Q28u9uisrbTFImidITzmu1iobcQujYehTa6c13C6IbRFWkSFw19gcX7M8ivi
wD8gtfBM4KBCDxpNDbk7BsoBnbw4F9omju5K8S0I7kgPU+zO1RhwgyoyzU2TVLpD
+Uz4kvIy17Y6JmjNwN/1zC51dfpCtWjmOBz6ZwS+xVdgcFqLcHqHNXEOPC75Bfdv
3mJeTICZFfRflnt7nGGQ3Itv1zYcBz39aKpQIs58IKZDoee5FCkzvrPFsKPY8dNX
lNkRsbZxcW9lg8rDpNFtwwEmiklO3BmuOPfoczm0dihEJoEZfgVGe0DdyQjyBxeN
e+JfCmxjL+vPwxbMzjMedX1gQrQiV9fXWrYJ9v2K/wG4MDh7cJSlT9zuu86cqBt+
DzqP8BjgMR3nb6cFrK19l2hQ8q7pDeeqR+kqtog9ByCXTqvyjpaw6jlcyr+tFut3
sFj3x7RY
=1ryN
-----END PGP SIGNATURE-----

--fn/+f8gvSFPTlTEs--
