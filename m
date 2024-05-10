Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAC95C25B10
	for <u-boot@archiver.kernel.org>; Fri, 10 May 2024 13:08:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3303A884C7;
	Fri, 10 May 2024 15:08:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="a6Ql34jR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9607F884C7; Fri, 10 May 2024 15:08:37 +0200 (CEST)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EFCC88167
 for <u-boot@lists.denx.de>; Fri, 10 May 2024 15:08:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-23d477a1a4fso1268414fac.3
 for <u-boot@lists.denx.de>; Fri, 10 May 2024 06:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715346514; x=1715951314; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=37389sJM/LFhFXlaf3OUXwn/SYkpVR5Vab6Gxd/eL+0=;
 b=a6Ql34jR+4znUN3F5jsDpvvbG7anobC/1Q9bvCN6ZWIXbkoY+m+TvEPKYqsKTT/3IP
 2zpQWWNbCBiHqFWcpvOXfvzVbwxD59y3zmBIgvmSGZeqclzQ0WysBw+ZOyudU89Y+R/A
 GQaCUjmQV7RAOucTw0/WJyeuy8XiwMGS6JVlo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715346514; x=1715951314;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=37389sJM/LFhFXlaf3OUXwn/SYkpVR5Vab6Gxd/eL+0=;
 b=Go1zKQpU5RMz23h7SMTnBga4kwQzVSDjs4GcX58lmQdxVKNnDS+lX4Z8GAd2Vlym/U
 ze2c1j2TG0nG8JQpl2/hq91jZnp2EhFRQwAgAc10tbMk3f4myXmhiUPtT3XySqr7Y5xW
 MUOzjPh7D2rb6l7TBdVlcVSPkQkMf9i8rcOckIR0WRJ1IDn/0IneajTazVI8fW0j9zVB
 vWqGq/TeNPmCcigMyINIK2/mh90GTyVuMa2g+frZqJHa9q+1U68c4gIBAKpDT8tEkC5l
 fDXt2/EziXinEiMBVHFVM+YeqCBRCZ8wGEYc7pkX1OcnqzoROzhM7E0ElOm/PG/UL1y0
 XNbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvxlX6nokkuXCNk73fNebR/eoZEtkhmfVouINa1Fdnoik2jEOWKFLVW1YEmYx6Tg4R7Y9R/z7YqL5CbCW5enJjXBNIpw==
X-Gm-Message-State: AOJu0YzL6ttJXPexePKuw6fNrxy9JbgVlAi5YFi4enKMLSjvN7RepPNR
 MWAjSRYLieahQq8cGf+EtCxXShgIz2uI2OhMfPhz8TwhWjGqiS7t+yLBhsZ1LHw=
X-Google-Smtp-Source: AGHT+IET7pUS0EeCahmm2n8isuu0uKbzYJMJZIaxWnDPz26qw5rd8iBOeuV6wE2y2M3gTsPhKxd+qQ==
X-Received: by 2002:a05:6870:1b19:b0:23f:9c2e:8ca2 with SMTP id
 586e51a60fabf-24172fd286dmr3244912fac.55.1715346513995; 
 Fri, 10 May 2024 06:08:33 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6a1680b8840sm8510056d6.42.2024.05.10.06.08.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 May 2024 06:08:33 -0700 (PDT)
Date: Fri, 10 May 2024 07:08:30 -0600
From: Tom Rini <trini@konsulko.com>
To: Roger Quadros <rogerq@kernel.org>
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Nishanth Menon <nm@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Wadim Egorov <w.egorov@phytec.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Simon Glass <sjg@chromium.org>, srk@ti.com, s-vadapalli@ti.com,
 vigneshr@ti.com, r-gunasekaran@ti.com, danishanwar@ti.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH 0/3] arm: dts: am62-beagleplay: Fix Beagleplay Ethernet
Message-ID: <20240510130830.GT2568172@bill-the-cat>
References: <20240425-for-2024-07-beagleplay-eth-v1-0-6c985de1c316@kernel.org>
 <9baa5ac5-8ce9-4aea-9a3d-ec1d68ea5505@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="m4dghqOsQVvbtx4J"
Content-Disposition: inline
In-Reply-To: <9baa5ac5-8ce9-4aea-9a3d-ec1d68ea5505@kernel.org>
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


--m4dghqOsQVvbtx4J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 12:55:15PM +0300, Roger Quadros wrote:
> Tom,
>=20
> On 25/04/2024 15:20, Roger Quadros wrote:
> > Sync AM62 device tree files with Linux v6.9-rc5 and
> > add in the missing bits in -u-boot.dtsi to get CPSW
> > Ethernet working.
> >=20
> > The last patch is marked [not-for-merge] as it is not yet
> > applied to Linux device tree.
> >=20
> > CI testing
> > https://github.com/u-boot/u-boot/pull/527
>=20
> While the checks have passed, there are some recent conflicts introduced
>=20
> Conflicting files
> arch/arm/dts/k3-am62-phycore-som.dtsi
> arch/arm/dts/k3-am625-phyboard-lyra-rdk.dts=20
>=20
> Those files have been removed.
>=20
> Do you want me to rebase and resend this series?

Since part 3 was a do not merge I wasn't sure what the end goal of this
series was.

--=20
Tom

--m4dghqOsQVvbtx4J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmY+HE4ACgkQFHw5/5Y0
tyxgpQv/UoeCdvZoSXdxetuog/Z6g79BTN4nZm3MRERwFeT7RItmuwQikDhZqIbF
TCUXDKnTkuGwwMI66yktdE0B+4vUVddyqtJE49Rubb0nqBG3BwlzC4KXMhjv12jj
UHYC+Wz6hfCyOGc5PIqiEp8TuqRFlQW/gmO+J+tpimV7tBvo4fDN8PxtIqwAU+DQ
dBnH3kKNhEpS9qcB9U+3pIMXInknCj7OoYFlAGATF+GBpkx4l55qEb3RToeZ0bi2
u+18nIR+QRpIchlkA55xWW98EOhTpJK0NYTovt1KyrYCjg7ucHkSx3lsRmzXiEtY
C3eRjq80xMVLJwRYUjk1wV416SYwpgh25wOv7Pcarw2ZedkpjgPyF6snEgGcu+0p
hjs80l9Howo8KYXV/LzXnYruA//vQ8/qpgjb2OPf57rSEC8f+Dn9tyuum/Ajn+v6
u+KvTM/2lvTMqclSfNISxwMp4213JjCs1D4d8Ub/DTBrQyMnI2Emf68evS7GOiB0
egQa3/JC
=Qpkg
-----END PGP SIGNATURE-----

--m4dghqOsQVvbtx4J--
