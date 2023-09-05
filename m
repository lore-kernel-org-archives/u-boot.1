Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9071FC83F33
	for <u-boot@archiver.kernel.org>; Tue,  5 Sep 2023 02:27:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CD90864EA;
	Tue,  5 Sep 2023 04:27:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WVhBoe7F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CAE98652F; Tue,  5 Sep 2023 04:27:08 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9D1E864D4
 for <u-boot@lists.denx.de>; Tue,  5 Sep 2023 04:27:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-58dce1f42d6so38565377b3.0
 for <u-boot@lists.denx.de>; Mon, 04 Sep 2023 19:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693880824; x=1694485624; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=H1rEo9q/91MOnBYGxFklR7HwtGwPuCqSs9jKqq13c+w=;
 b=WVhBoe7FOKuye77SyViZbNL7n7+vLFXt430QhENQvN/MPfb6VDiUuU+kXkyibqWan9
 5qJQN/Hp3kL7KaVBqH2wTGNmeNXQ/X5NZU+WE9RZ3ANs6OVHwlAiJy7A9EiU9NpBJlG+
 JApCYwqi237ZZFwQLfDhDzoiqNtxWOi48cAsM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693880824; x=1694485624;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H1rEo9q/91MOnBYGxFklR7HwtGwPuCqSs9jKqq13c+w=;
 b=Gdcbg9nDiwh/7QkTm7b8CW/ffPUfPzP1btEWOVm7zz77ney8I/tbtPWyH40gfWgniI
 Zd17XDEKVfRPtJjV6iJXHurg8VtuGExO1IMptFmqDIUriapAjRrRtuxvxa14zTCOKMIx
 TiVlEBoLgrZJPFC0M7A54OIg4Aci8sNZytGLWw/02s1kigqoFDzCapFtXsrT/9/1gs8Y
 ujEgwBa5ue8mo8jykPco9fGZrB0kekRGiJt1BQVH5Vfw4m4lJ8A5qM5pQSTaXVHYqWSl
 2nNmuO6qULD5hXBNAXDyUaFz7bscI3Nu8rW94E17/YphD224pCeEtc3FfHyJm+myoSWE
 IzfQ==
X-Gm-Message-State: AOJu0YzHj8+Nv/ft2hOdlkO28qe+zBOkM0oXL6GxZ+hH/gabJ891LVSN
 llembwdj91LnB50gUlkrPtzOHSrAvGwZdAqYuf5yqw==
X-Google-Smtp-Source: AGHT+IHTG2oPKwFf23rUeYuPP02BB1TkhEcIGa+fYXYwYd2uNpm1OnFyvk+VuK+j+EUvvnhNO0p34g==
X-Received: by 2002:a0d:ca0a:0:b0:57a:3942:bb74 with SMTP id
 m10-20020a0dca0a000000b0057a3942bb74mr15043763ywd.17.1693880824031; 
 Mon, 04 Sep 2023 19:27:04 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-51ef-a95e-1d1c-c7f8.res6.spectrum.com.
 [2603:6081:7b00:6400:51ef:a95e:1d1c:c7f8])
 by smtp.gmail.com with ESMTPSA id
 x75-20020a0dd54e000000b0059565f338b2sm2972343ywd.98.2023.09.04.19.27.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Sep 2023 19:27:03 -0700 (PDT)
Date: Mon, 4 Sep 2023 22:27:01 -0400
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Subject: Re: [PATCH 1/2] =?iso-8859-1?Q?MAINTAINERS?=
 =?iso-8859-1?Q?=3A_Drop_Pali_Roh=E1r?=
Message-ID: <20230905022701.GI3101304@bill-the-cat>
References: <20230905011228.4006020-1-trini@konsulko.com>
 <20230905011228.4006020-2-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2yEOGXD8JP1Yyn3a"
Content-Disposition: inline
In-Reply-To: <20230905011228.4006020-2-trini@konsulko.com>
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


--2yEOGXD8JP1Yyn3a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 04, 2023 at 09:12:27PM -0400, Tom Rini wrote:

> Remove Pali from his listed maintainer entries due to his publicly
> visible actions on the mailing list.
>=20
> Signed-off-by: Tom Rini <trini@konsulko.com>

Applied to u-boot/next, thanks!

--=20
Tom

--2yEOGXD8JP1Yyn3a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmT2kfIACgkQFHw5/5Y0
tyynOQwApEBK0cB9+Pg+RR50U1GnIvyk6MQw5HZ2ahDLMaCiwYgCoGg/Hk4+1Oj8
Cto+DDV/ubVSvYpzfAiTqiwL6q95lMS2JKeWncaY8QzIbbyrI2dkPZsV715jaHag
qRyez3TI/1zPYUVVbProP+Deh7WP8XeIxR7qVlXhTyhLPU9Yw77K+DGDZsatrPYS
OdwwQLFNJEJFNEYLQLJFhHVUTZtX98yZ+M4ARnqDF+dytiGOPpdzhKnNy4ScyA0/
MRODa8wQNKuBF+YSiNV4G/5kVw6P8zKQucjSCu0JQdAgZ/n21jSVeBa1YYc/O/gq
RsonbwxpD4l2YaKkppfyYqPaBxD80jWE5jKhBqOBZy6/v52TYEcdxnnNvMXBJIt0
jNKAxfLVzcnOvOLdiNxVvMYwNMp415F1+vBodHDP9wG6qBRJ4zL7ZcdQE6ws3/LR
Fsp7LJKI5U6/i+2X8D64toACZ1f6NUF9UvAgRYJC4qWfCWaOlJkcC2IQ0nJ+RtDA
cUhQnxRu
=haB8
-----END PGP SIGNATURE-----

--2yEOGXD8JP1Yyn3a--
