Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87AC2CA0FE7
	for <u-boot@archiver.kernel.org>; Mon, 25 Aug 2025 22:56:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22AF1828A2;
	Tue, 26 Aug 2025 00:56:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kyZ3Srv8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 844708309D; Tue, 26 Aug 2025 00:56:34 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 678CE80819
 for <u-boot@lists.denx.de>; Tue, 26 Aug 2025 00:56:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-74381f217e7so3327873a34.1
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 15:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1756162591; x=1756767391; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1FS5YxfWOBySMkPk2eg7vHW5uwtP1zajl9z7/KwudnI=;
 b=kyZ3Srv8jybeyXCmu1rvVJj/vasMnzfwz3X3SG/Fl3yoaGNoxuTGn8pGnUhRNewhgw
 UWnxa5h5TgnAOSsRnXQJ+SqYl6118MP/32zfLTYFLTqtbNtSpUYmbevZmRaT8US+4b3u
 hsUObWLXDiNYT3zNzN3uXgF/0tX1QHwENzyVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756162591; x=1756767391;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1FS5YxfWOBySMkPk2eg7vHW5uwtP1zajl9z7/KwudnI=;
 b=rQTSZ85xQlav8iiqYcRgD/F792FoHE00D9rMLpjHqam40AKHisskXHRg9E/4TXRH2U
 UIowsUOw8AqToPNh7Jb0VObLdWT+VBXeNQ9x1YKg9e3EwwE9wyVq1EcbO4AvGvhuQhtY
 JXRwRvs8VSBEKJav9xU2CcZCDSjkUTXOF2fclu3Y8Y7uX3Ja4AANvZ2jqz2s1R78WEiB
 OQKCgupehYYTw7EVM3iw3kmnjDGdgOdop3RMyUDMtl/8mRMn8ItN8KCkyfw0iziregGC
 3euEH5yum1y5e2Y4nBjiK2LNe6rSzbV4gQs8hQlj4lZvge0fyFltsYafjLSaXR914wMo
 YJ9g==
X-Gm-Message-State: AOJu0Yx183J3pYLoWFDszAxYL6eSXbynNbL5Kp7VOLR+kkLgbBmimKRn
 XspDpXxBR8XCurEuPWaLFFKWPPSjeu6hxRKHUHWAH5fulV6BkSb2rJa+ArhIoHkOYpLy5IFr7H5
 83SVd5Ho=
X-Gm-Gg: ASbGnctMLSaIxiYhih551U2q+jBCn2tpd04QgBO/3W0EbtMAjp2DqjD+DrmMvFAW3L2
 LhWg4XyTeXRwyboL9esuhHJcy8pqlwbftiX4l7721tcB0gHgfV5M92jRqUwjwRVA4mQkNs9NtVk
 IA7L2hOeeghbQwceSesXKOtfAmsYzu8WhXYHRLphGesx04mzo2/VLbf7v6MtD5q3Z87QtfJaCzj
 4gz8QZg8OY+bmC5MKwzKjq1cPEfTFQnKjodKbWuMd02IEdiCaDHJfm3lTZ7QqeWcmscSnSmrvuo
 HlmlAbBuJZpgFhWPIKssff7KTfsBOoclSS6CReo0ysnRB7jeoNui7q1s6AM5VH8WsQCvQSRTuEQ
 FaivCiP9VYKM5IjOOolK6ogxHbuetP+pXuf0iAZuPZdhyz6m2nUjwg+NBlwM8PJrhU0g=
X-Google-Smtp-Source: AGHT+IH+rzaSlcoXkCMte9Bix/c4d9RiMIkhCeUR2JMmflIKdYiot6kobucM/6CzZwohJuMAKXOaxw==
X-Received: by 2002:a05:6830:4874:b0:745:26c5:e4d3 with SMTP id
 46e09a7af769-74526c5e92amr1699876a34.11.1756162591163; 
 Mon, 25 Aug 2025 15:56:31 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7450e4bcecbsm1992882a34.45.2025.08.25.15.56.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Aug 2025 15:56:30 -0700 (PDT)
Date: Mon, 25 Aug 2025 16:56:27 -0600
From: Tom Rini <trini@konsulko.com>
To: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Neha Malcom Francis <n-francis@ti.com>
Subject: Re: [PATCH 2/7] doc: make pdfdocs: Update the description with the
 needed steps
Message-ID: <20250825225627.GY124814@bill-the-cat>
References: <20250825224459.682403-1-adrianocarvalho.pt@gmail.com>
 <20250825224459.682403-3-adrianocarvalho.pt@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="p+SddYXWCtYf25Jf"
Content-Disposition: inline
In-Reply-To: <20250825224459.682403-3-adrianocarvalho.pt@gmail.com>
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


--p+SddYXWCtYf25Jf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 11:44:45PM +0100, Adriano Carvalho wrote:

> It is not clear that before "make pdfdocs" it is also necessary to instal=
l "doc/sphinx/requirements.txt".
> If I don't install "doc/sphinx/requirements.txt", this is what I get with=
 docker.io/trini/u-boot-gitlab-ci-runner:jammy-20250714-25Jul2025:
>=20
> uboot@35c89b9ab70e:~/u-boot$ make pdfdocs
>   SPHINX  latexdocs --> file:///home/uboot/u-boot/doc/output/latex
>   PARSE   include/linker_lists.h
> Running Sphinx v4.3.2
> Warning: The Sphinx 'sphinx_rtd_theme' HTML theme was not found. Make sur=
e you have the theme installed to produce pretty HTML output. Falling back =
to the default theme.
> loading translations [en]... done
>=20
> Extension error:
> Could not import extension sphinx-prompt (exception: No module named 'sph=
inx-prompt')
> make[1]: *** [doc/Makefile:84: latexdocs] Error 2
> make: *** [Makefile:2686: pdfdocs] Error 2
>=20
> A "t" was also missing in "documenation". This commit fixes that also.
> NOTE: This won't completely fix the pdfdocs target. See next commit(s).

We should make it clear in the documentation on building the docs that
you need to do this for any build target.

--=20
Tom

--p+SddYXWCtYf25Jf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaKzqGwAKCRAr4qD1Cr/k
CvrjAP9bwQHvlKlMg5ih6HuSnoiwAtg7f5g/SIn8YO/nnw5sXQD/VZq54iT5dEN8
Z6QJjqbQ70vAQBD1KLN2VWTiVIvGtQ0=
=Jiod
-----END PGP SIGNATURE-----

--p+SddYXWCtYf25Jf--
