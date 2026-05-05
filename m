Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DD92CD3427
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 16:32:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D92C68497A;
	Tue,  5 May 2026 18:32:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="G8QTUEbs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 763BF84986; Tue,  5 May 2026 18:32:13 +0200 (CEST)
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com
 [IPv6:2607:f8b0:4864:20::344])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E88784974
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 18:32:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x344.google.com with SMTP id
 46e09a7af769-7dea20cf21aso5084469a34.1
 for <u-boot@lists.denx.de>; Tue, 05 May 2026 09:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1777998730; x=1778603530; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+oJZlqj6DADU50ig/zCM9gQpx65632XKo27agRAki/c=;
 b=G8QTUEbsEAOztQdknZgYHE+lOi4l46k5jZ70wqankchLyE21dscNZK0f5XYj0GoUQV
 n0mxj0h8AANm5lrxYnUdU4QJWIAKh6wVe9SuTxz7ngxeDyLQCI896iaKZuSSjHDU4Bis
 4RiRO9qQZc26CafL2wQaq8lSv6/7a2rEMC7MM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777998730; x=1778603530;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+oJZlqj6DADU50ig/zCM9gQpx65632XKo27agRAki/c=;
 b=Zxe+mzLmhseBKZsOLzUW+x72V+oqi1Wm0CopDpTG1a9ElpTSEvm9p7ZnK90bE33Mwv
 GvJ4qcwZfnIu4Db4xApD0vff4tSima3UcBIWbvpSPUrXBTXT2r+EPPbEwaPnCnAeCjtU
 gZcN1qTcUftetF0sK4Ka4dmEs4tnhGuREYVBjwDIqvQxGfd3FkpL2gqfZJO0LHQxEGFu
 SfQWoV2J8Zy2RKD7Nylw8V2h2O/5YLyVPAT/XJeUorwJKorp4+L616qTAdtTLwxh3Spx
 L7GP/OPI/MY+I0zKnqSMLMGek3OfnQ8NyhOcYKe5drplEJdwNTGWIjXxGMHNQcj5B7s8
 oatA==
X-Gm-Message-State: AOJu0YzThzLF+WC50cx9HBAg8bVmUPQLG6ynfYpf54WV/x11ZE+MHpsv
 5CbtMuOoL3gICGKKJVQHqkFIyoDqHeQzj3YgWIV32P65OI7wlzbxqqbluFiLtnqtNZI=
X-Gm-Gg: AeBDieumHnYn9oeEduksIUf5dz0co7sys3SkpQZebbnkKeBDS+iBZqiCmk45vglUe6g
 C8p6jdeGYuCP6Npe41nqkfnJGn0c5+VIUcS55rPJqNjArSKr/R0VYQzByx2jdSX/ZDTpvMfTHPm
 m7KrNDn1GSURM53c0x7B37QckBPiWYb09dArk/oJ7jg0c5ynppAubPMObKgF8k7LBCOn5JQRiP0
 UpQapJPYksWllInbkyvn48aDEVlDovBgKSHpWkYZ1GEQp9hHlj6OPdfO4v3oWmrKIV+csSSHczD
 0TJ6wwo8g5cH+VkMlMmfoOi6EYtSTuHIZT31iqYSLhEg3DTTrlzOPISCp3subJWidhCZRkEpSac
 INIPjEoYnT6LNLZQXjZrW6DBXk0bNkx7TCvzmf0xM6H6UC/SvGD5wQhfgZE50/6orWfSEoQ3ePy
 sW8jqP7YlcEVlWcVCQa98P5mSEmw9NbzKTFRbejPoHmywQ78+f3LAVEoDfnWVFauLdrPZZt9PQw
 KjtBeebfp6LJBcm2/yJboTAOmWDBiz7Az4kX2GFFhVIODBpqyJm1aVfOEK3KGsUcTr5ySYg
X-Received: by 2002:a05:6830:8289:b0:7d7:4002:1f21 with SMTP id
 46e09a7af769-7e17df16a0dmr2127128a34.20.1777998729853; 
 Tue, 05 May 2026 09:32:09 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7deca7a5e75sm10262357a34.2.2026.05.05.09.32.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 09:32:09 -0700 (PDT)
Date: Tue, 5 May 2026 10:32:06 -0600
From: Tom Rini <trini@konsulko.com>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, Neil Armstrong <neil.armstrong@linaro.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH v6 1/6] config.mk: support vendor generic includes
Message-ID: <20260505163206.GS1614990@bill-the-cat>
References: <20260505-b4-qcom-tooling-improvements-v6-0-a5fb673f4af6@linaro.org>
 <20260505-b4-qcom-tooling-improvements-v6-1-a5fb673f4af6@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JPwOHapoKThE27qe"
Content-Disposition: inline
In-Reply-To: <20260505-b4-qcom-tooling-improvements-v6-1-a5fb673f4af6@linaro.org>
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


--JPwOHapoKThE27qe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 05, 2026 at 05:48:41PM +0200, Casey Connolly wrote:

> Currently only board/vendor/$(BOARD)/config.mk is supported, add the
> additional usecase of having a vendor generic config.mk which will be
> used to add a Qualcomm specific make target.
>=20
> Additionally, fix the ifdef to correctly check for $(BOARDDIR) rather
> than $(BOARD) since that's what is actually used in the fragment path.
>=20
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---
>  config.mk | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

A common pattern is to have board/VENDOR/common and I think qualcomm
would benefit from that, and it would make this easier to use elsewhere.

>=20
> diff --git a/config.mk b/config.mk
> index abed9cb65c6f..28a4228b8fa5 100644
> --- a/config.mk
> +++ b/config.mk
> @@ -53,10 +53,14 @@ ENVDIR=3D${vendor}/env
>  else
>  BOARDDIR =3D $(BOARD)
>  ENVDIR=3D${board}/env
>  endif
> +else
> +ifdef VENDOR
> +BOARDDIR =3D $(VENDOR)
>  endif
> -ifdef	BOARD
> +endif
> +ifdef	BOARDDIR
>  sinclude $(srctree)/board/$(BOARDDIR)/config.mk	# include board specific=
 rules
>  endif
> =20
>  ifdef FTRACE

But BOARDDIR is used in some other places, so might this become a
problem overloading it this way? Does this end up working because
there's no "board/" code being used on these platforms?

--=20
Tom

--JPwOHapoKThE27qe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCafobgwAKCRAr4qD1Cr/k
CpWJAP4j2XA840LYADuZ1RFxT51+vTLohx4GRPPVPkFYnv0hpQEA0cGh57jZ8uVA
KRFp/ZGyzH/wSlvQtqzJ0jXLDY4msw0=
=xURt
-----END PGP SIGNATURE-----

--JPwOHapoKThE27qe--
