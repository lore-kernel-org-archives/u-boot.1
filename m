Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28085C072A2
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 22:36:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78A228704F;
	Wed, 15 Nov 2023 23:36:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Zs2m/v+F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25AFA871B4; Wed, 15 Nov 2023 23:36:20 +0100 (CET)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22B97869F7
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 23:36:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-778a47bc09aso6234685a.3
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 14:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700087777; x=1700692577; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3DP7dRah7KbuRNMYY9W2wvlgez+5siIY52XIbpxVSXE=;
 b=Zs2m/v+FqCUrkwdhN9CBiL8KLnnZYjtKNxyqG9v1r1VM/P7W20xDA9v6epfg7ePSs2
 RzBJoa/AY0x9S/5DpOW7JMlDmnb3XdjclWGvQchgCQvAzlbQ3YYVIfoYiBgDZDZDAXYv
 7D/lYtCHACglHVtLpSsgYEEIS5+2qSk5jCTX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700087777; x=1700692577;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3DP7dRah7KbuRNMYY9W2wvlgez+5siIY52XIbpxVSXE=;
 b=O0vsjCZqKQaxU7XvW6RjS7EyXTPw1y1LnhCBNVL/VVU9SeYdOolsbS0Fjn0i7LjPOu
 4BlqdMR2b00QqO7eJqXDOLIrfMseaFcWvRJ92C/+jm2ID0x+IFiv/DOtFhg8EOUt+QjE
 AgqjJhJehWJmy5qI85SGqUQ75OWiebPH7pE0lOi0XrL+udzOFprqNb5d0etAsjc9JQM0
 bkWFanrzhHYFOCT05YytU3DXm4tpoeaf4ImWsVO3CalBpjbaZQ6vYHsFrwDzjj+UmUZ6
 Tw5Q4bZVh/YVzVuu1mJSGDS+Zyb7V88ETiy0qnnIPTpdJe8TC591D01jCuk7lg5q+2n1
 GUnQ==
X-Gm-Message-State: AOJu0Yxs5YHfSWmbJv5AF8hivYC1x0FPGAyhcR/m8XChpiBKBkrewogG
 n8wSicVw+PnLW4vr6fWZIXDLPQ==
X-Google-Smtp-Source: AGHT+IG7887FGyq29Km1kyfornQbX6yJSm+1jyKzUYUHbYi43PzDXIZZgi3MIbG/Vqs3QHTDLsoQEw==
X-Received: by 2002:ad4:504e:0:b0:66d:a1f8:38da with SMTP id
 m14-20020ad4504e000000b0066da1f838damr6926845qvq.33.1700087776849; 
 Wed, 15 Nov 2023 14:36:16 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-6602-bbee-fb68-4a56.res6.spectrum.com.
 [2603:6081:7b00:6400:6602:bbee:fb68:4a56])
 by smtp.gmail.com with ESMTPSA id
 q2-20020a05620a0c8200b007743671a41fsm3781006qki.72.2023.11.15.14.36.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Nov 2023 14:36:16 -0800 (PST)
Date: Wed, 15 Nov 2023 17:36:14 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: Re: [PATCH 07/29] bootm: Simplify arguments for bootm_pre_load()
Message-ID: <20231115223614.GN6601@bill-the-cat>
References: <20231112000923.73568-1-sjg@chromium.org>
 <20231112000923.73568-8-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RaCtDiy2+0Dx+jm0"
Content-Disposition: inline
In-Reply-To: <20231112000923.73568-8-sjg@chromium.org>
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


--RaCtDiy2+0Dx+jm0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 11, 2023 at 05:08:52PM -0700, Simon Glass wrote:

> Move the argument decoding to the caller, to avoid needing to pass the
> command-line arguments.
>=20
> Add a function comment while we are here.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--RaCtDiy2+0Dx+jm0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVVR9MACgkQFHw5/5Y0
tyxOnAv/RGk0HgLyOBRdr8xfz166fL9fTklsuOGUHf/wmetJFzSS6F9SarWJCLQM
fj6aSp3mPOmdlhP+keL1V5dujtUzuD9+dxv9SqbKkr/UfsrGxR72zA8xCSlQlDI1
j8rkK27Jfmgo6Ngr5OLygsGAWA66xcn6mRuxr1cSSwJgbSNK73odOZZXLUCWvcTX
UTp0yeVUZeRR7a4/aSGD+g8eyfrftZ2tdFnZiS9JExVUrRCB+ryXf1JoIU/ijH2y
Gdr270ClgJCsa2uEk/aLQZix1O0KZoNCAg5iIJNd8TA8ONpK+op1xpfEqAkFn16X
gtkkcg3n44CxTGsRDijSJBb5ax9PAWhkCsQ3GMfR61zsMnCifX/G4Dfz2ipV73XE
5RLw5EmX5UPTNTBwADxJRvPUfY9G882qYOuSLfIzTBs/kAJmuefhJh3ugUvK56vg
+/BqGQFsAkipneYs+gQlIXXwcDECx4l5QcR1xFtr7/R23BLmqsX5z7sIBYZKnVh8
8HjJ+BpZ
=mVZX
-----END PGP SIGNATURE-----

--RaCtDiy2+0Dx+jm0--
