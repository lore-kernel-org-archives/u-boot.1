Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12400C4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 18:22:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12CB286C15;
	Sun, 12 Nov 2023 19:22:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aoEY+FBq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE70586C15; Sun, 12 Nov 2023 19:22:54 +0100 (CET)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B99AB86958
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 19:22:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-41b7ec4cceeso22420441cf.1
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 10:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699813371; x=1700418171; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4PDAtm9Q3maGIFi7+6t8nzuycMwypRI2sLE/tzZfLbg=;
 b=aoEY+FBqOOuxkZO1NAdpsfbkwpwAOCdkwYMEwSsaCSYN1BcHoO/wxir2TjYLThW+3O
 XulWOCC+CROiytUWPvCrtPb0W7ZGvzV073TeJV6E6KtM99xX/a1I//rb3zXmC8Zf6Xez
 AqPGBhbff8pEgNPEREcrdObK7SFKR7fY7ApKk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699813371; x=1700418171;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4PDAtm9Q3maGIFi7+6t8nzuycMwypRI2sLE/tzZfLbg=;
 b=TFC2tAsBY7/eJvqk3CyYNzGqTkFNW1eDUCqe44N9gtejcf8iWD3Gkc/BbfscRJVtX4
 8sQk0k26dF/5amNs+EE4rU/KxfrJuBePSWPRWzAye4Fmrg7Rg1wTjVXHzwoxXzHLhUxv
 O/ho4/cHTjvM8Dh5xG4oAB4rkrBE1cgn+Gq498XbQ+pME9sMEBVnaH2WinqpxMu5uYEv
 ga7LjRyYhH8M6SE09ToSIiPxvthcNukJAnAGnoelZb/ywpCLMoxrfSF9e4MJnmAqsoRk
 G/iqAZYepJmmKZzgNnQikj+Lhyui3iQf9Skzjzy2Xo77+QYL1j0icysZa1Q2RkORl3/G
 8kaQ==
X-Gm-Message-State: AOJu0Yz+MN44WfCZ4BfNZyVD06YFxFo6VVlKC/oNdA7l1DUEp9uEgiao
 91xg9n/Nu1dumdTAC7Ss3aY+FQ==
X-Google-Smtp-Source: AGHT+IHFD95rcfyK3JB3J8sA/vlrfDq+yycijwzVUHbVjlMcNfoF09PP4iupb/EiTSe74M+QCWoK3w==
X-Received: by 2002:a05:622a:5a16:b0:421:c3bd:a183 with SMTP id
 fy22-20020a05622a5a1600b00421c3bda183mr6444064qtb.16.1699813371433; 
 Sun, 12 Nov 2023 10:22:51 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-8be2-1560-728c-e0db.res6.spectrum.com.
 [2603:6081:7b00:6400:8be2:1560:728c:e0db])
 by smtp.gmail.com with ESMTPSA id
 p10-20020ac8408a000000b00403cce833eesm1321432qtl.27.2023.11.12.10.22.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Nov 2023 10:22:50 -0800 (PST)
Date: Sun, 12 Nov 2023 13:22:48 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Sean Edmond <seanedmond@microsoft.com>, Andy Fleming <afleming@gmail.com>,
 Jerry Van Baren <vanbaren@cideas.com>, Mario Six <mario.six@gdsys.cc>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Priyanka Jain <priyanka.jain@nxp.com>,
 Safae Ouajih <souajih@baylibre.com>, Stefan Roese <sr@denx.de>,
 Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH 4/7] fdt: ppc: Drop extra size for ramdisk
Message-ID: <20231112182248.GE6601@bill-the-cat>
References: <20231112152754.130399-1-sjg@chromium.org>
 <20231112152754.130399-5-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="if5V87sCd0hdA2/k"
Content-Disposition: inline
In-Reply-To: <20231112152754.130399-5-sjg@chromium.org>
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


--if5V87sCd0hdA2/k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 12, 2023 at 08:27:47AM -0700, Simon Glass wrote:

> This code dates from around 2008:
>=20
>    56844a22b76 powerpc: Fix bootm to boot up again with a Ramdisk
>=20
> Since then we have added FDT relocation which provides enough space
> for expansion. We have also added all sorts of fixups earlier in
> image_setup_libfdt() which require more space, with ramdisk being the
> least of them.
>=20
> Therefore this extra hack for ramdisk seems unnecessary. Drop it.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--if5V87sCd0hdA2/k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVRF/UACgkQFHw5/5Y0
tyzwJgv/a+IDb/qWPUKt4uLsRhWEZIEqsKEIHH93jBFuZJ/XT9jODOe+9DD69keR
L/IF80zfk4n7A24T7jKKkhyLycKa+S4ISfD3Sdz52FN1rChjKIKlem6pgeek4FKc
J5ycKMpqafBe6JlKMw1WLsLt5/KdqXY3FEDmTs2AYMx3LCzrUNoVA5mOQC/cWkQX
kwBS3g6OsEZ+dPbU8U62vkshep+Ep/9+w1vMLDHiYTV+PQNkWKYfYawMqCoAvpNx
AqSEm/cBuKWUWyv3vwxKcQ2MjnUR8WNJJajhFhhneiFA3L2pJps04rVmzM/R/A2N
CIDs7So2nl1/RrBxgbgMjIeOeMFqs1Uu3Ek5Lvds0NuC5HyvcpWWKdbGOiAGstZ1
OicUURdsuXcGzq96PqLtAIUQkoqQMMbD4R/xzGcilCteZxYkU9jDLeUgrlCwUxf2
X9UOKHc4EN012ymuoeXN/01EipIFRdhK8+ssc2l+BEuylH9vYlUFwYIRKZBn8ZOl
DPEh8Fiz
=r14I
-----END PGP SIGNATURE-----

--if5V87sCd0hdA2/k--
