Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 443C1C43458
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 21:58:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B997784119;
	Fri, 26 Jun 2026 23:58:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eNOrei3+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC86184844; Fri, 26 Jun 2026 23:58:10 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C511584105
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 23:58:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7e93f93ed01so954906a34.3
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 14:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1782511087; x=1783115887; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zZe6Cmm+tCEMFDlBBCjuXWZtCNArauXRSr/6Qyyl0nw=;
 b=eNOrei3+z/V4uLafxr9vVQ6AvSEtJ8MykApoREhkA9D4AsawL8Rh823y5wUN5oo/Ep
 7WiPZ8UHji7ZWwzAonu8TX6bdvWvRXeGM+IyJCKsMt23z/NKg3ME3LogsENKSQcMGHnI
 dtgor0ga+zmsf/YtMPKKnYopiJBfiZ+Vby5Co=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782511087; x=1783115887;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zZe6Cmm+tCEMFDlBBCjuXWZtCNArauXRSr/6Qyyl0nw=;
 b=JAzTHITz8wFeKWLY2tUimszveCvYX6J46Cen4gR6WXNSUbEmeWD2w47/JbrO9qHNXk
 2J/vzhCAZicyKtG87ESHfy2ApWUCIAoqex7g1GGwUssKPvP4R9nUUp9Xix1Zd+42NJHy
 l9nCF9rI2vQn+rgpUJNz4YR0wBUcr2+WFVMp2CxZiDUoN9YfrTxjsBl3S5Z6WkLw/cfw
 F6NTruNeMfaa1ClHb7M5HBShtl3X/+zWjaVKsCQ+Oft0QfqJBBRJciKjCEzBvcsbokgh
 U+UnP1boF8srztbUeK47mZXyBNX/xGPNuj87vhEA9fvDO9Fue2lWEV77xKALrzD+AMk6
 l8pA==
X-Gm-Message-State: AOJu0YzqZsN7ADcfoVugaxRVEqUfVlB0k5ms3e215XMVVvStvOi5yxL6
 2qaESTh8wW7jWIF5N0AcJdQ/8ziAR+1RDwvYofzXYdS/hHK75F6IeAXzBy3pAXmfnVo=
X-Gm-Gg: AfdE7ck5EJvJtPOro5TDBQnebTkXKkVSfMNgeSKNX6YJpfJbYWGoUn7uzq2XP1F+Ic6
 rR8nzM66/QWz4bXjb/1gkyCGip6cMWaJiWSBk21eFra4siKUMBdMd3XV0VaHvLA3OOXqaIjHn3z
 ssRrEa+1Vf+76wUFuRUaIaXbRQVuAOpVmQ1otrkQ32PH8vPUFIXcpEu89nMrWlD1Megcnmd1AC6
 +nWmSwBsbwE3aH6hVhJ/5AxfrcjBQB0zja6y9jNaOWQ0roapVxF9hnAKeTSYW00kP8xdwhd7yjm
 GOGM0p+craVHJ2bfCBM0Aa5ZGX2cQm2p+Ozn7RvE/wjMlqOqV81JqzMlEUoHNB7DRR7NAqqasi8
 8Fuve8ID3AjhAQrnJ9dRL6lDjGbz/RazaT2saRCunSvVbIoihht0hAK8kOJa90TvnN2Ytm/IJmb
 2+JtG0droteAxzeKO3QvFFbTyEMMnvoNEbNSdk9GwRHVhJ2DJNWa3aWpMIoyASmG17Dv7C25nlN
 fnbzIdCit+PY9zS+P/FqPAiJI7rFm1WKQYhBioYNR50NWvYsFI=
X-Received: by 2002:a05:6830:2e10:b0:7e6:ef2e:28a5 with SMTP id
 46e09a7af769-7e9b4f39da4mr1606816a34.15.1782511087472; 
 Fri, 26 Jun 2026 14:58:07 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-245.totalplay.net.
 [189.203.103.245]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e9bd4be179sm167578a34.7.2026.06.26.14.58.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 14:58:06 -0700 (PDT)
Date: Fri, 26 Jun 2026 15:58:04 -0600
From: Tom Rini <trini@konsulko.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH] test: cmd: part: fix integer handling in
 setup_gpt_partitions()
Message-ID: <20260626215804.GB382693@bill-the-cat>
References: <20260626183353.1666667-1-dario.binacchi@amarulasolutions.com>
 <3dfd02eb-fcc1-49d1-aea2-6bd20f052692@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kEz8wzx9yRoVyfuc"
Content-Disposition: inline
In-Reply-To: <3dfd02eb-fcc1-49d1-aea2-6bd20f052692@cherry.de>
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


--kEz8wzx9yRoVyfuc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2026 at 08:40:36PM +0200, Quentin Schulz wrote:
> Hi Dario,
>=20
> On 6/26/26 8:33 PM, Dario Binacchi wrote:
> > Coverity reports an INTEGER_OVERFLOW issue because ut_asserteq() compar=
es
> > an unsigned int (mmc_dev_num) with ret, which can hold a negative error
> > code.
> >=20
>=20
> The trick here is that ut_asserteq() takes two arguments and casts both as
> unsigned int, hence why it complains.
>=20
> If Coverity is happy, I'm happy :)
>=20
> This looks fine to me, so:
>=20
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Yes, were you able to push this through coverity on your own?

--=20
Tom

--kEz8wzx9yRoVyfuc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaj717AAKCRAr4qD1Cr/k
CmdyAP9cq4Vi3NeK2M8B/X2iOSSo/siwinspOl5/t05kb36ZvAD8CQo8l7kmVPE+
8CkBacAEvookMZJLBFiAC+w3dMI4DQA=
=AMe/
-----END PGP SIGNATURE-----

--kEz8wzx9yRoVyfuc--
