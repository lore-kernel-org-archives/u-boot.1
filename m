Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F954CD98E3
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 01:22:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADF6786604;
	Wed, 11 Oct 2023 03:22:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="unN+3AUL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 244BB86B43; Wed, 11 Oct 2023 03:22:40 +0200 (CEST)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C38886591
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 03:22:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-690f8e63777so1650000b3a.0
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 18:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696987353; x=1697592153; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Sc7flmRUErTB+HBiy99Sy3dMk797AqwWUTNTQt89Npg=;
 b=unN+3AUL46voENyughsy79jRI+Z0tgo49Cedctusq4t/H33l18D9xPzE9I4ptFJvAq
 KflUa9sYdZrEw6SXDUjFOaK0+5/WbvfgFlAyDy3fE3bwgMwWZJNLMHuLoNLeLEux/g/J
 ZxLfPk/ZJKGyeCQeTkzEHdsK3fItq4+FtOes2lG81zVixaWUe/AIsamFNwmREjdJBoEf
 lbdhCllr59rzgmIcDHWI6s63Obq53u/VpUs9iCAy84X/dhHCbQ6/0kSHzBcnZsI0MDbx
 Fbf/TIvmfKyEM2zoDJAeDvMDzoTccTwxnqWH7Zpka8VKAdk6US2/pbRnAcVQ+4ydoDR7
 MtLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696987353; x=1697592153;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Sc7flmRUErTB+HBiy99Sy3dMk797AqwWUTNTQt89Npg=;
 b=Y8B2lY/RpC5HsxseyhkppxbhK6BDKQSkwGMLmiUovuhdgR1q2y7+UQIYe0ptqnY/z0
 QMdypp2SSvRZDr+lW5q68iEybf2SjJ0Ew6DzVcqB3Np8r8qgm7GfmgR6r2BEJmUStH7/
 xALnS2recfPb3t9WHZdRBv91fDgiSIYjh2csfjsM4kZWtQVyTs2e9xBzmxLbHxiuj5rT
 MMBfoHYPFAhgmUkCfj/Ug/WSv4fXXRbyWT8OGECgk+pKtZ5zvXnNHa+RsaAqMmxMIRc3
 QVAzVsiDltSKpHxYVNRvY+eXqbbqi1U/+2C0utQ0t7tqdiCsc00QosdjDwIQJVy59rsX
 8irw==
X-Gm-Message-State: AOJu0Ywb6Cb5HmgFgVC5d1PV58c4qJ5FDwQFumtN3JXDPqKZzA1SmQXz
 nkyyKP9IiEk1c1+j/8rjw1KZpA==
X-Google-Smtp-Source: AGHT+IGS3m+eYtQ8vgVcAzvvVIeQ9TyOrdAkgy5b8HxW5XfJN4zAS0+GiUc9VZBfh6rLFAdI8UxZhA==
X-Received: by 2002:a17:90b:4d86:b0:27c:fd8d:164a with SMTP id
 oj6-20020a17090b4d8600b0027cfd8d164amr1433285pjb.1.1696987352630; 
 Tue, 10 Oct 2023 18:22:32 -0700 (PDT)
Received: from octopus ([2400:4050:c3e1:100:5c6c:b11a:476c:8ebb])
 by smtp.gmail.com with ESMTPSA id
 7-20020a17090a030700b00260a5ecd273sm11728587pje.1.2023.10.10.18.22.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Oct 2023 18:22:32 -0700 (PDT)
Date: Wed, 11 Oct 2023 10:22:29 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: sjg@chromium.org, etienne.carriere@st.com, u-boot@lists.denx.de,
 Etienne Carriere <etienne.carriere@foss.st.com>
Subject: Re: [PATCH v5 15/16] doc: cmd: add documentation for scmi
Message-ID: <ZSX41Vl0IIJa6MbL@octopus>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Tom Rini <trini@konsulko.com>, sjg@chromium.org,
 etienne.carriere@st.com, u-boot@lists.denx.de,
 Etienne Carriere <etienne.carriere@foss.st.com>
References: <20230926065750.734440-1-takahiro.akashi@linaro.org>
 <20230926065750.734440-16-takahiro.akashi@linaro.org>
 <20231010141906.GA3119521@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9/1Cd118qGe/s9vB"
Content-Disposition: inline
In-Reply-To: <20231010141906.GA3119521@bill-the-cat>
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


--9/1Cd118qGe/s9vB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Tom,

On Tue, Oct 10, 2023 at 10:19:06AM -0400, Tom Rini wrote:
> On Tue, Sep 26, 2023 at 03:57:49PM +0900, AKASHI Takahiro wrote:
>=20
> > This is a help text for scmi command.
> >=20
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> > Reviewed-by: Etienne Carriere <etienne.carriere@foss.st.com>
> > ---
> > v4
> > * s/tranport/transport/
> > v2
> > * add more descriptions about SCMI
> > ---
> >  doc/usage/cmd/scmi.rst | 126 +++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 126 insertions(+)
> >  create mode 100644 doc/usage/cmd/scmi.rst
>=20
> This needs to be included in doc/usage/index.rst in alphabetical order,
> so that "make htmldocs" passes.  Normally I'd fix this up, but given the
> other problem I'm reporting this along.

Okay, thanks. I can fix, but see my comment at patch 00/16.

-Takahiro Akashi

>=20
> --=20
> Tom



--9/1Cd118qGe/s9vB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEjc56F+RxEkavfJvIJ6vpGq1myG0FAmUl+M8ACgkQJ6vpGq1m
yG3ttAf8DlJskWKHRzqFdsi+Bpro+yGCNYIlzDVlepARHjexCrzJdhWRw4i9cLOK
1Yd9qpKWI7pb5o0VclIKuDaRzsvellnSUiQlpMXaVytquWVyzTgF+mQsTto4pt+z
IJPeo07IsUga0QyvMxCuDzG0dkwDmboyslniqPzpzaafJtBl6tmui5DrqaKID7uh
K/GpC5+XQ062dOYbQ9iuBWoOzmmWS5STznWZZpUbyV5Mk2CkVodvcPS3c9qeaHbo
HNVoDJdmWLvOoqIukb9gkSdbSiQP2WAAvDtA1+JS0S/EY/ni+Jo2AtsflpeS9nGR
CIokPCAx8eWTcSaNCV1MErkLxvklaQ==
=mPxc
-----END PGP SIGNATURE-----

--9/1Cd118qGe/s9vB--
