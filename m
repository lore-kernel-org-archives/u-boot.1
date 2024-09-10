Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E993EECE582
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 17:22:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89679890DF;
	Tue, 10 Sep 2024 19:22:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dESk8xJz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD57F88F65; Tue, 10 Sep 2024 19:22:25 +0200 (CEST)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83EE5890D2
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 19:22:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-6daf1c4aa86so51733907b3.3
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 10:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1725988942; x=1726593742; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Q0O1RtK6kqsTm5C60EGZzoBXwjL6JLYgKcv1BlZeY6Q=;
 b=dESk8xJzCJctL6GU9/WNpwzBE/DaAhEtAp10rmjDmYF9azO9NFEyyDbO0y9Vq6r+JD
 2YnbXgPzFRvOsJ93DGQkhOpNiy7BMlZbVHcXFZbSjZc2E56jqA4ma1Kuzv7vRo8Mi/of
 AOhklQt8wOOgDw1Vj/GrgY/m88FEtY+uAqJ+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725988942; x=1726593742;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q0O1RtK6kqsTm5C60EGZzoBXwjL6JLYgKcv1BlZeY6Q=;
 b=QD/c6YF33CbieDglvw7zlOdYYOYuRLIRMEEt909WGCMe7EmREUHOvndZQMBhyWfyIo
 EMRVy8r2Uw4d3tq2NXuTeLcCTDQeuzaTM8K/1D5EtZaXBf1pOr4R0Xp1Ha+yB7QDXGs2
 FN5WIHcqhRg+dciCGcWisz5TK2ycvGWLg8o13SMi0bZDKfrwA8onFvBWtQysiDx/6xGZ
 //R+wws9AvTEmSU2cEpSgzAR2CDvq7zpK8hwy9s/FDXSOsBWXn3bbjJmfR2Ea/rOOLW4
 uKKliVbhnDHd5O4moZmqcPVXBOnS+UckhsIfayzPfHshQyKPl++W3TNET2enB/ZUeurz
 QkaA==
X-Gm-Message-State: AOJu0Yzh9g3hYXMdoJL3G4g/cClge80hnevS6BGOl0mNOpiCBQu2ysYV
 A/ejXTUBlbM67VgA+dBOykdjNtEjBtXFtHyO4CByfceauYcvw3SR1JW7WRVqW3M=
X-Google-Smtp-Source: AGHT+IGG8lVMGg+PaEiglmcGdrh358qbQ83gY1m86FogJ+CflYDMO7boWpomKYWsXFBr8co7eyQFeg==
X-Received: by 2002:a05:690c:4782:b0:6d4:d6de:3e0f with SMTP id
 00721157ae682-6db4515494bmr128508407b3.31.1725988942203; 
 Tue, 10 Sep 2024 10:22:22 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a9a7a27300sm325608485a.128.2024.09.10.10.22.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 10:22:21 -0700 (PDT)
Date: Tue, 10 Sep 2024 11:22:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Joshua Watt <jpewhacker@gmail.com>
Subject: Re: [GIT PULL] Please pull u-boot-dfu-20240910
Message-ID: <20240910172218.GJ4252@bill-the-cat>
References: <87seu77pd3.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Z8s+pnt1Esve52wj"
Content-Disposition: inline
In-Reply-To: <87seu77pd3.fsf@baylibre.com>
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


--Z8s+pnt1Esve52wj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 12:52:08PM +0200, Mattijs Korpershoek wrote:

> Hi Tom,
>=20
> Please find some fixes for master:
> - Fix ANDROID_AB_BACKUP_OFFSET unit to bytes
>=20
> CI job:
> - https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/22302
>=20
> Thanks,
> Mattijs
>=20
> The following changes since commit 1312faac5f52d27cfb45dfe1a5a93a2944ca5c=
21:
>=20
>   Prepare v2024.10-rc4 (2024-09-02 14:07:53 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-dfu.git tags/u-boot-dfu=
-20240910
>=20
> for you to fetch changes up to cc2f60c13f6aaf1bd277cf10c8b375c2e4a695b7:
>=20
>   android_ab: Fixes: Fix backup offset calculation (2024-09-05 08:55:04 +=
0200)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--Z8s+pnt1Esve52wj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbggEoACgkQFHw5/5Y0
tyz/sgwAnrjxeaXOLUTqn2nKFdNRbzMGpW54vZ2Sx61qta7Mp4ovNilFWBGhkbxa
r+8hoVfIlXyoQbnrmbfDBkRF9f/5vMMkqEQZbiYHFhybNDHyQ7sdkPnfuNrW0jdV
VQspMd8W1UtuHVdunIUZqpl0cp2Yo+ZqKmGxp4S+GzhjqBVat9116nACR/UiubOl
a5Qa3dyR4PQDZKY0RVSsm3q3EaU2FukmkjTlv6jj1u+rRK6evneELP+mrsh+YQBe
dZsGQ/34PZrY1JbLU+KA7YiqS3sg+l24C1IwzLExUM32DR3smeVixQiGnynDD64k
zRpaFh3RDEFVlqiCiK9qoYYvsRFIk4iyGvVGmdIhpH4YRkyF6cz/nGtMSqVtbp1u
G/wZe2gclXIMKeeTAXNRbM1KnBEuToT9/AIqgHYd9Nh8Hdp4dLYbBPGSisp8UUNp
atX1mDYeM5FJlJTiP7kWDAbXnGal/sPPf+w0K+R0EqMjnwVZ79bfsK3adIDfZza/
HRc6xPxK
=L0wU
-----END PGP SIGNATURE-----

--Z8s+pnt1Esve52wj--
