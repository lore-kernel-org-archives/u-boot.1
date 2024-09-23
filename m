Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7776DCF9C70
	for <u-boot@archiver.kernel.org>; Mon, 23 Sep 2024 14:10:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F5F288BCF;
	Mon, 23 Sep 2024 16:10:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jbhrNf3f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDDCA88C4A; Mon, 23 Sep 2024 16:10:21 +0200 (CEST)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 988CF88A0D
 for <u-boot@lists.denx.de>; Mon, 23 Sep 2024 16:10:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6c3f12d3930so34798946d6.3
 for <u-boot@lists.denx.de>; Mon, 23 Sep 2024 07:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1727100616; x=1727705416; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=aWNeEXVOGMO+ej430n3x1NZZXZPWXAlMyUvoy16wkWQ=;
 b=jbhrNf3fi81M3n8ijZX+dwLnghfeePleAy5vexyFdxAVcC7hABWP3/hNjphm1D1vTU
 aCpCE0mGloDS4wqgn9DZI7PCGDpzr08OXc5DlegNm2WkT/3PggjCUCNeK+x/qPnhF36U
 HHdPRmel+vR9BX055QPvTZFEIB4mOlNr9A7j8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727100616; x=1727705416;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aWNeEXVOGMO+ej430n3x1NZZXZPWXAlMyUvoy16wkWQ=;
 b=XQxxPtgvCXrxqvAohNxF3aowzqqXe48XPzv8+ys8mjsBUxXQUhMmdWsatT/j3JS1G3
 J4cdVyZqfYcu0+1yr4ZY8y5sBvo1gwWC3rw7fnRmeWIQSFRl5HSWzzQZt3RdoCwVHJrc
 Y6OKFiUcqT+FRlxaqLBeES1m8p4sU3rJPxIkOWDTKgfARCaBxgVEMW46dupP3AZYF13O
 F67eRwCv0k6WyDah04GM9q4OcnqLZoMozxogcNfpc1Ja6sryQnBm8qwHxdrYj0cBQbTT
 S7TRTN+3gOYFd9jjI7Nwjtp6T2i1dtTi5uU8SaElm5OOKCQAUeZfWQCyACY4zDHdoMdb
 FttA==
X-Gm-Message-State: AOJu0YwDIHpwTnB+2sP6EjviwLU3KkoU0Bn0JMMVGsHu3U1gXEBRqWgh
 DVrooliy1fDWNc345B+0jq59LtDihTKiTy0NGrNq6MSv8ElFBFgd3ehndaZsccA=
X-Google-Smtp-Source: AGHT+IFM1tGrB732RdUYs6tfGrVxzZA3cgFm5/90Wk2l3o84tfco6jegCekA6jnHcqK0swOhIW2++Q==
X-Received: by 2002:a05:6214:4886:b0:6c5:aaca:a48d with SMTP id
 6a1803df08f44-6c7bc71c0ecmr204076226d6.13.1727100616394; 
 Mon, 23 Sep 2024 07:10:16 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c75e44bff3sm47784416d6.7.2024.09.23.07.10.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Sep 2024 07:10:15 -0700 (PDT)
Date: Mon, 23 Sep 2024 08:10:13 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Stefan Roese <sr@denx.de>
Subject: Re: [PATCH v6] mmc: Poll CD in case cyclic framework is enabled
Message-ID: <20240923141013.GN4252@bill-the-cat>
References: <20240906171110.91195-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jWXB8Qe1QONg2JeA"
Content-Disposition: inline
In-Reply-To: <20240906171110.91195-1-marek.vasut+renesas@mailbox.org>
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


--jWXB8Qe1QONg2JeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 06, 2024 at 07:10:42PM +0200, Marek Vasut wrote:

> In case the cyclic framework is enabled, poll the card detect of already
> initialized cards and deinitialize them in case they are removed. Since
> the card initialization is a longer process and card initialization is
> done on first access to an uninitialized card anyway, avoid initializing
> newly detected uninitialized cards in the cyclic callback.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Simon Glass <sjg@chromium.org>
> ---
> V2: Move the cyclic registration/unregistration into mmc init/deinit
> V3: Replace if (CONFIG_IS_ENABLED(CYCLIC)...) with #if as the former
>     does not work with structure members
> V4: Stuff the code with CONFIG_IS_ENABLED() variants to avoid #ifdefs
> V5: Rebase on u-boot/next
> V6: Rebase on u-boot/next

To summarize my thoughts on the thread, I've applied this patch because
it moves things forward while fixing usability problems on hardware. But
there's certainly room to clean up the framework, which can be done on
top of this patch as well rather than further delay fixing the problem
here. Thank all.

--=20
Tom

--jWXB8Qe1QONg2JeA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbxdsEACgkQFHw5/5Y0
tyxONQv/aTtR24E30UhES+c/TaKCtcrnnUMH5U1aLm6/LLUoeVk1oUt0pon+rGyV
nLBiAXxuiUSDQBZWDAwUUTbIz020Niy2UTQMbJ2iLbc9dFcWlJXEuhsXQ4kORfic
qjZvyY29nD8ZbG/9ZLxi3uY5JHSGoUsA8nPXFAWuuMTC9kpwUU2dKEbiRAvGh+eS
N+qbDsx26zaOTnitGG5ARdyMv+NUMHJVH7CA35/Y+B0EN52V24tFGHOqhBuvJjJX
5FbORX3n7PhhSHAroXYs8D6AsMgq0cujbj51Dxy6oCvdq8QNJPzTeP738Vv/Amri
qgkGmaWZPsqlVPBlSixvW29CSstM/c/MswWVfE8MJMuBJ659xYFBeB1T5rPZXYq1
7GrmpfHNYBjD3R3lk8TqvCJofiN+lvwWz6X5pjv68CIVW3uNzMbKt1WBPiB+dNOU
8gORQlREmlGBTGTsp+WiHfRUd6OODbfzI1u8H/6/7HfjfWbU4QWgDlei3HftqTga
4Xa7f8FI
=RbW4
-----END PGP SIGNATURE-----

--jWXB8Qe1QONg2JeA--
