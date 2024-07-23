Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 222C8C3DA5D
	for <u-boot@archiver.kernel.org>; Tue, 23 Jul 2024 01:55:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50D8488440;
	Tue, 23 Jul 2024 03:55:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kl4I/1uF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C441A88204; Tue, 23 Jul 2024 03:55:44 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2459A88657
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 03:55:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7039e4a4a03so2800041a34.3
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 18:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721699729; x=1722304529; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=c/nAygEf593qo9uHPVdLFCtnHeD1zSRzL8ML3MpIuvg=;
 b=kl4I/1uFvKOsmsjHBeZJx7O9cim35j3W6GAtguH8tPW+fTdVzEvxGYEn4AJWMlAQQx
 78IGgC5iJTuimxPdrbOe3evx6kupWqxDwA0iY8Kq+Ogwc6ReEcVmYOwzzrfYuTx/xq9B
 ENhdoSjoh+Zmuqy3q/QPO1AV9rEbpOTTWrIBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721699729; x=1722304529;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c/nAygEf593qo9uHPVdLFCtnHeD1zSRzL8ML3MpIuvg=;
 b=BpiLITDgmltWzGTFODXOTsXeace+FTL741jRINKRtizDhT4qDxVrZtCfFn4aEVYvCt
 pT3tnzaL9XPesxC/y2drfeDnZNMRg6t4HEWoCkCOouur9u4mNCZ9CDlvuO+bg/PR5G1U
 8B/MJM6gRAlsc+0nb5DjfTFk5Di2wvBBbZgvQdu83t9gyLjjlKL1/842EB7ZYgjKQCMP
 z4NrSrqC0TryqDIiAEkoevLLe5N/TCmajtBkplQUNc7UfCrZyS/y6iQ/sOG7oAR0qYzW
 eZZX5FZIx1bvsPjOnYEP+4xaZdAJKTMuMp6NxJxbfKBjQNZJ+XsUYhakqnX5zqJemaU5
 8qQA==
X-Gm-Message-State: AOJu0Yy64S5hCrsh8cTmkVz0RURCzjww2iRyI7CraZU8v4JTiwqnsEgm
 kz8nn0LiqZN5uxF2fS4rY/5B1x2mxnxEzKj+/06U0e5q7JrWhWaTWCqYBLf6DUs=
X-Google-Smtp-Source: AGHT+IEJet6JJ722i5ePK8s2IG2sm2LYp+plF80hFjVl4akZlvd2jltvcPwkf5GX9Ekuid4te8AUEQ==
X-Received: by 2002:a05:6830:6a94:b0:707:e28:58d2 with SMTP id
 46e09a7af769-708fdadf9b2mr15000853a34.2.1721699728826; 
 Mon, 22 Jul 2024 18:55:28 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-708f60c1944sm1853273a34.20.2024.07.22.18.55.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 18:55:28 -0700 (PDT)
Date: Mon, 22 Jul 2024 19:55:25 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, sumit.garg@linaro.org,
 jerome.forissier@linaro.org, Simon Glass <sjg@chromium.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH v2] tools: Add script to update git subtree projects
Message-ID: <20240723015525.GC989285@bill-the-cat>
References: <20240722193052.57592-1-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Q5u0qPw5b44pA0fI"
Content-Disposition: inline
In-Reply-To: <20240722193052.57592-1-raymond.mao@linaro.org>
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


--Q5u0qPw5b44pA0fI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 12:30:50PM -0700, Raymond Mao wrote:

> Recently we are introducing multiple git subtree projects and
> it is the right time to have a universal script to update
> various subtrees and replace the dts/update-dts-subtree.sh.
>=20
> update-subtree.sh is a wrapper of git subtree commands.
>=20
> Usage: From U-Boot top directory,
> run
> $ ./tools/update-subtree.sh pull <subtree-name> <release-tag>
> for pulling a tag from the upstream.
> Or run
> $ ./tools/update-subtree.sh pick <subtree-name> <commit-id>
> for cherry-pick a commit from the upstream.
>=20
> Currently <subtree-name> supports dts, mbedtls and lwip.
>=20
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--Q5u0qPw5b44pA0fI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmafDYoACgkQFHw5/5Y0
tyyRdQwAqhsVI6Jfv5KyakJ7ZhJLDUSAAdA5LSRlBrdtS1AV/NmiV/4bWMpsQMse
C+Eov7tQnrjEnNOBOFQwcAb4oUeILS+NaT/tEgnpYKxo6sv5KsoKHxRX0JYLQQDp
Q407vW3vqTRXJcylMnF5SbYVcVXYbt+/1nkTNbQyEzItPM8cRV4DUanNgr2coKQJ
jaRwhwjNZFuULKmaQLQKZZp8urCudIeyZmfUJLTRl+AiXZMzeRtlaeAEPP2YHNnA
TwphbTHKIx50gjR2OCG/WP0RGJ+7ysTMrtNPpeiMIxRoRq2TFwu//bC4EDMljODI
DYEkArZNwGComF3RXUw5yJstZyR0du3pQ9JjgxYsTg1JBC1Lrv54VwOBGM/75WLK
tItmaBg1EEJGM2Wa6e729Zgch1nwh9vglHAgGq8qOCvyLJ06h/Ig8Qacti115GHJ
0ajklaS3eVjg5L0GgpLcVaebvi+UGg04DUdeqcVIOT7mWiSIWo6CpgyKsg/jEu45
DSY6Ws0q
=LVGo
-----END PGP SIGNATURE-----

--Q5u0qPw5b44pA0fI--
