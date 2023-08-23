Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCDEFEE49A0
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 14:43:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F14D864EC;
	Wed, 23 Aug 2023 16:42:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LqdKRDye";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FF0B86403; Wed, 23 Aug 2023 16:42:33 +0200 (CEST)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11643864EC
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 16:42:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-58c92a2c52dso61891807b3.2
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 07:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692801749; x=1693406549;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Hy5AVuxdepK9Bsv1QNe3R7i6loOMAyBJyPjvnR6O3gE=;
 b=LqdKRDyeCPbzE/PQ5e3jWb1rau03omOjq2rX1t0TOYJZP+KbQXgOProQ+CY/D1nn/u
 gC9p2xDgkVy2ZGbBMKjln5MiixQIDyfeG5nStJG59RSrDF1GKoCaQv+GoZDGIh5HAYwW
 veZuuMXUynEIxtEkd2ZJgFJRpC/uW5uUANiSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692801749; x=1693406549;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hy5AVuxdepK9Bsv1QNe3R7i6loOMAyBJyPjvnR6O3gE=;
 b=D3y+Q/JdwW8Pn2UAEiLyZZPWZEL73fTsre9hC/3gCEPeNWxxHZapgW+KAsLF9XZQnt
 xNpOFS9tj/NHUEF5LaSkHCmo3Zchepy6iMZrjMEpDd8a+kkdn6dtszxdgtII+GI3T852
 EleZJotNonLtyiQ1gLPZRZvD7zESYt/w9zhefAnFhx1I1l7NJQrfn3lrK5CJJgrFiUGa
 kdk+xD4WziX8MEWVm+JlNXBsdXnbMiomd6u7hhKlPB+FFR47SQdA/bpIgk9/w6tENKjB
 klzQRfkBxGnANjl75+sc5iWT00j1Q3zdydiJRXGzmXW+Te5z4wDe7frg7zuIM9w4gDs0
 eYJQ==
X-Gm-Message-State: AOJu0Yyil+oZaM1kWQtz1exKm+YEz80AO9kcM2dQcHgeExnzkvtr3lD2
 Yn8b13Mkwp941Upso0mHxI6Zcg==
X-Google-Smtp-Source: AGHT+IG6wENj6eRmsCBt1BcCqDO19hzh52X7eWPP4/GaTinuc5i+PnI2YDE0FOr9Nqk9GDuVYbPpWQ==
X-Received: by 2002:a81:52cf:0:b0:584:33c:31f2 with SMTP id
 g198-20020a8152cf000000b00584033c31f2mr14197950ywb.17.1692801748752; 
 Wed, 23 Aug 2023 07:42:28 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-5ca1-6af2-305a-b62a.res6.spectrum.com.
 [2603:6081:7b00:6400:5ca1:6af2:305a:b62a])
 by smtp.gmail.com with ESMTPSA id
 z1-20020a818901000000b005869d9535dcsm3384066ywf.55.2023.08.23.07.42.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 07:42:28 -0700 (PDT)
Date: Wed, 23 Aug 2023 10:42:26 -0400
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glplk@gmx.de>,
 Joshua Watt <jpewhacker@gmail.com>,
 Michal Suchanek <msuchanek@suse.de>, Simon Glass <sjg@chromium.org>,
 Tobias Waldekranz <tobias@waldekranz.com>
Subject: Re: [PATCH 7/8] disk: Move part_create_block_devices() to blk uclass
Message-ID: <20230823144226.GY3953269@bill-the-cat>
References: <20230813234648.591083-1-marek.vasut+renesas@mailbox.org>
 <20230813234648.591083-7-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BDWeHwGPp9gflCrv"
Content-Disposition: inline
In-Reply-To: <20230813234648.591083-7-marek.vasut+renesas@mailbox.org>
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


--BDWeHwGPp9gflCrv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 14, 2023 at 01:46:47AM +0200, Marek Vasut wrote:

> Move part_create_block_devices() to blk uclass and unexpose
> the function. This can now be internal to the block uclass.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Applied to u-boot/next, thanks!

--=20
Tom

--BDWeHwGPp9gflCrv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTmGtIACgkQFHw5/5Y0
tywVcgv8CrZ3uPSAO0N3ZgQJ1NoCgm7uFV0jn65Js6Pj5LX3+XfnNGlWA69kirm6
QxsZYSGonsbO5CwnvqUbWoir5sHHcxTKbmAplcmlUua0Dx4SYFl9DSymJNxsktrc
aaw5CEqKqUEVQsm+/gYrWEbifQAeJZOaXRBcmzA9q8nCXngBA8S3i6IXPunnL/TZ
2CK8pUkSVKn5MGvMMAg/fOYVjGm50PE1GYYPwa49Lxlr5Kbk/MzdgVt0hdK8nKs8
J8F9YpB+9cGBCT28wW5lX/Pdg+YvzCdwUxfjIyMeG83q5epHGo2c9OxAaJLMDgmS
+VyDb+WI7HKph2TApF4NnD5HjJRJjD2pQ89eFzUvKuvD2xXGcQ6cTqFVFDUB+xm9
TZs7xfFMeVwlba9TifvFC58zueJAxss1UTTaHy5C8ylyBcf4xBl0qc9OTxp+whKc
dCzw9zhG2I0zgdUEkKIyYSuMtX+pKGsHTzed88A+dLt+zfJRytnlUCe+WZ+9QXMy
bLNr1YiS
=VbkR
-----END PGP SIGNATURE-----

--BDWeHwGPp9gflCrv--
