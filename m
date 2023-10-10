Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A649CD8C89
	for <u-boot@archiver.kernel.org>; Tue, 10 Oct 2023 14:20:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D43F486B84;
	Tue, 10 Oct 2023 16:19:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="smu0WJJg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4855786459; Tue, 10 Oct 2023 16:19:35 +0200 (CEST)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5D6486C65
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 16:19:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-59f82ad1e09so71690537b3.0
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 07:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1696947550; x=1697552350; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1jWwCd7LmqaMU1w2olihnS0gt7GvzpsdOm6+zFe3xtk=;
 b=smu0WJJgh4P/DqXLDOIxDrWO8KcL9aMrztKjWADX6VstL82NFeIl39Q/w26jjQdt1M
 mwAuDefTc4/RF7LU4u5hJ2LuBhgDZx2oU9b0Pr/tEGKNH4L2104G/hmXWwaPYx3sUdhJ
 KNospFLUy3OJNfWBBiofZtPWEoRMKgU8lEhgo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696947550; x=1697552350;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1jWwCd7LmqaMU1w2olihnS0gt7GvzpsdOm6+zFe3xtk=;
 b=HcR8UQ2xJT42KoTdPT2haU254NXG3OhcDhYIX/EYayK4YePS1icNyUJPMkfRYyXMRs
 lt9xmtNVv2fboIGCB5fcXybKRG1hfqUdiWT+QMeJzAZ3c/98BSQT8oqLXnbtI+CQvkpq
 Ip7ceLfyq34QMiCPfNyG/uj/lelm/3mj1TkT4ULXXIksdo7XmdUiIuBwnx/Xp32FdfRt
 UfTf9gGkYtmCGkuwusH95mbk/LZNhhmxsB/UOaB3vJ8sEbJyx5h97Shn5yq7HkfCxtgG
 /PFzKIfDMk1LuPwbEcccbeJ6nbauZqgX2jr0lXvJaeqMG3hiCv5sdx7E5PcMyElAsKGz
 GLdg==
X-Gm-Message-State: AOJu0YwHOLzaFYxW1Rxwc2pxkgbTt4OuZcMg6uWPpVvGKTtqd5uNmcYC
 66BfXm3e8pAoJDhIpn9Hzu5/fw==
X-Google-Smtp-Source: AGHT+IGmEdq2JXzq1BJLE1KGgrhKUO4XZQPXJf2ADjhS3vPDbHnXYtG4tUr/z+N5KXZ4Oje5769y6w==
X-Received: by 2002:a25:2d24:0:b0:d9a:58aa:5807 with SMTP id
 t36-20020a252d24000000b00d9a58aa5807mr1991387ybt.30.1696947550359; 
 Tue, 10 Oct 2023 07:19:10 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-6c43-4eba-c113-e8cd.res6.spectrum.com.
 [2603:6081:7b00:6400:6c43:4eba:c113:e8cd])
 by smtp.gmail.com with ESMTPSA id
 n2-20020a25d602000000b00d5d4bae6fdfsm3782802ybg.30.2023.10.10.07.19.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Oct 2023 07:19:08 -0700 (PDT)
Date: Tue, 10 Oct 2023 10:19:06 -0400
From: Tom Rini <trini@konsulko.com>
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: sjg@chromium.org, etienne.carriere@st.com, u-boot@lists.denx.de,
 Etienne Carriere <etienne.carriere@foss.st.com>
Subject: Re: [PATCH v5 15/16] doc: cmd: add documentation for scmi
Message-ID: <20231010141906.GA3119521@bill-the-cat>
References: <20230926065750.734440-1-takahiro.akashi@linaro.org>
 <20230926065750.734440-16-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qylMrnz/ZuyjJjhk"
Content-Disposition: inline
In-Reply-To: <20230926065750.734440-16-takahiro.akashi@linaro.org>
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


--qylMrnz/ZuyjJjhk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 26, 2023 at 03:57:49PM +0900, AKASHI Takahiro wrote:

> This is a help text for scmi command.
>=20
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Etienne Carriere <etienne.carriere@foss.st.com>
> ---
> v4
> * s/tranport/transport/
> v2
> * add more descriptions about SCMI
> ---
>  doc/usage/cmd/scmi.rst | 126 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 126 insertions(+)
>  create mode 100644 doc/usage/cmd/scmi.rst

This needs to be included in doc/usage/index.rst in alphabetical order,
so that "make htmldocs" passes.  Normally I'd fix this up, but given the
other problem I'm reporting this along.

--=20
Tom

--qylMrnz/ZuyjJjhk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUlXVYACgkQFHw5/5Y0
tyxhhQwAmsqT8jXrjfYzeF/sETN8ySUQUTsqi9xMCrwG4KjEpVIUnvUBICpiFout
xKKye3tfUbFWPve816rZ2LcFHM1HtHukz4C1QxjE3ZIyvWLL9lUKwQDEc4Pvvc2U
/+aZ+JZyeDQXXe6QNjlrMIeoxlHchcdq82ySbRdqbE/QyFGaPjceugbRQ6hV5hm7
CaNuhk1RDWyBEHmohaNY5lftcBhgI1h9ItR790/gUDweh67Ub3qUnstPJ1QlMot/
i/QC4N/abZKYlquAXAr3uOJyqw4ISxOJNmTVUUbKync9qTXnhnYowgKrBJT243tC
DrdLjnBQvAZgvwi5/QL4QOZMl814nMT0v2ot+7iw/zVDajNIIKmpw28sVqIcIVvi
zVqGeCgsjEqi+qHwuoQrplB6Am6FnXPw1vhODeuJk/gGnG0x4rr9/WcS2/0h4KsE
T8l/WfmCFSuPE6e1axDb6QMhnDo1sSnPRo2nYoZFXERrI9JNzDli3yEt3GwvhjI2
Rd141PE3
=nIQr
-----END PGP SIGNATURE-----

--qylMrnz/ZuyjJjhk--
