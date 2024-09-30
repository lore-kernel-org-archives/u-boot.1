Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56B7FCEB2CC
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 22:52:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8803589042;
	Tue,  1 Oct 2024 00:52:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gLw3tTvE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEEE989042; Tue,  1 Oct 2024 00:52:55 +0200 (CEST)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A755C88936
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 00:52:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-7a99d23e036so524012885a.1
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 15:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1727736772; x=1728341572; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DeusqkNfSVLO80IJzNWCglOG/dCjDQbTl/EksPyEBSY=;
 b=gLw3tTvEs9rgF+3ZjsmEzQj2dE+cxY3ijkH+79CpZf6RsXfi30DyTPMPhlpZlXIrvU
 qd+WEIJ1esEx70n6WM4wK4f5SxlWyob6Jpa7eJhNPzhDXvRPVxwzFs58BhqExW/9s3Qp
 VkHmSq/djpQtYCXenu0u2ofoQfN/9vYPXiIQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727736772; x=1728341572;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DeusqkNfSVLO80IJzNWCglOG/dCjDQbTl/EksPyEBSY=;
 b=rKx9+faRqqoMParzyn/b+gSt2iQPHJDJfO4Bq0/+CVR/xetUmr4TFCL44hP9iekuV4
 wFxqc48Tet7LjvXEeYhL7ox/7hTEmRPwy7NmVVV3Jnt4fDtmmw8TaVxxXErhGiIyt3UI
 7enzrwSBp/wjy6Yg5spNve1OdKtlxTN8b+lVUjZ1uXHCkM8iKtg23EycqU+BL1feIkRN
 RYeEme0FQYxueqb3pzSRkhRBj2CyMnhwCtmWK/ICTM3nBeyQbnXFp3sZOSO2VnQ4tziG
 f+VeJm8kKT3yMeoGx7NQRSAiHOLoYtnFdf2R7HDEAbxeO17BJHgI9wt9OBBj28KBsvlD
 +zIg==
X-Gm-Message-State: AOJu0YxoC5T8f+TKbCDviAmKUwbChB5Lg5xbrt3Qxs8xKwk6iEpTd0BM
 VhhTLxFgcn/dmHT1EFcEUSj8OF9e7X+2iQikqRqtxrp3BawqGTLuezcKJ29dX26O5YlyJMZKB91
 L
X-Google-Smtp-Source: AGHT+IF2h+lJxvbzfshh8uhvMlJ6rMniiJDE1aVwfxRjKXGNlmKBas38aTrMIk6/PdAbfjNBgQAZZg==
X-Received: by 2002:a05:620a:3954:b0:7a3:78ac:827c with SMTP id
 af79cd13be357-7ae3782224dmr1865584585a.10.1727736772517; 
 Mon, 30 Sep 2024 15:52:52 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cb3b60fcefsm44064466d6.38.2024.09.30.15.52.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Sep 2024 15:52:51 -0700 (PDT)
Date: Mon, 30 Sep 2024 16:52:48 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: [ANN] U-Boot v2024.10-rc6 released
Message-ID: <20240930225248.GB4737@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vnJH2lyRY4AZ0EvW"
Content-Disposition: inline
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


--vnJH2lyRY4AZ0EvW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

It's release day and the final rc is here. There's been a number of last
minute bug fixes getting posted, but I'm still overall confident in the
state of things that we'll be releasing on schedule.

In terms of a changelog,=20
git log --merges v2024.10-rc5..v2024.10-rc6
contains what I've pulled but as always, better PR messages and tags
will provide better results here.

As a reminder, I'll release v2024.10 on Monday, October 7th, 2024.
Thanks all!

--=20
Tom

--vnJH2lyRY4AZ0EvW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmb7K8AACgkQFHw5/5Y0
tyzMAgv/SPMkfYVL2hCZuPmniksTn+SdS6xYYuBqScCsUGFoIla/5199df/oNeqR
jLxL7BhP0+7Ye/LTA4xekCS8UAWTuomjgtpzDqKzwQPfM3ogud9858MfALzNdhRv
de+eOAiIjBr+igXeiiCrwj00/dkICScioK8DYY6G+AcD173V5pFup4Cq7Il9qzP7
7jWFb1Vgu5rilyI6tyGjnnYx/MuanG+cEG3cwmv6zTUFh8CJiFHCHhhszQJUzetx
CdER+JgEbfSNNp1Nh0rbX+ikDJaZj1PvMXN4SZNWBHhqmpPapjHEWGOx6ZiNgLen
JZ5wU/OWnnUHIg2Oy5yGxaa3AtqThPgOgtdOlSCWx74fIONL+DVg5XDUKAS4Yvz1
ANmBq6kFGVHveSO2wT75gcGdrmJXgGrjWX9s/TJvwiAs1LqSmShrYFOB8Kg0ZPLY
x6rrKDFkGCOysTnnRyIcD+RVM7kx1BJS0baxUyUC54fDlcgdrRvTcbFqNJfkgHak
rljewRGh
=uzGX
-----END PGP SIGNATURE-----

--vnJH2lyRY4AZ0EvW--
