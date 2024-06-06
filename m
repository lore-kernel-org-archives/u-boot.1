Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B741AC27C52
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 23:55:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 073C98845E;
	Fri,  7 Jun 2024 01:55:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UO75mKlP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1780088453; Fri,  7 Jun 2024 01:55:13 +0200 (CEST)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B22B78843A
 for <u-boot@lists.denx.de>; Fri,  7 Jun 2024 01:55:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3d1bc6e5f01so847743b6e.0
 for <u-boot@lists.denx.de>; Thu, 06 Jun 2024 16:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1717718109; x=1718322909; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gTpNf2g4SpkPXj0sQNE4byZz9/nDBMapBdIX+nQg1Q0=;
 b=UO75mKlP5FbCdhgcK2mJskHKklpoGMJtnzaMBZOok/8v0E3tnHxuy65SUGgrAm2nyc
 jljtEGr0zFRnd9eWeJFKJoXw7vnhhN4naRmellwLLFiJJWRmvOG0XsrXgWPDYQA2YgAU
 8v+2zOppC2Y291Jkqpem5X09+37nUBSROC7Cw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717718109; x=1718322909;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gTpNf2g4SpkPXj0sQNE4byZz9/nDBMapBdIX+nQg1Q0=;
 b=Gokv8nUH7QKHgij/uinmlndQU+86Gh8pzIbqrtCwEmQY0C1v32QE87/SegTCMPq+AR
 DBpxetoAcrGzQ4sjHvJ1U3P/MHbj+Kw7w1eTmeaFwHuafmuTN19jkXKSn/VhDTiLkqGt
 J73f2MbcCJ+ZPNB+YsmiYSpYuAclb65dSgaw2ns6wHxEm8SLv6IxBY81I9fz7jq9iuKR
 6gQhN6bj/QfKmait6kTTVBfwkVx8XG+AoyGfwH9KcKWbrupiAmrNoG//1odb7pD2xR7J
 iRn66GawPBTc7blGX6BT6Q/In9TBjpN7mwu3RmgYiKi7Q/FLZfrNPZDdhcXaf8PhsdH7
 kQlg==
X-Gm-Message-State: AOJu0Yxf/ULjujoRhx8TVkyg2q/p+4342UAACPtY4LVUDkrlNQREcK6P
 elipG4TO0Y8Fhf41kzG03ccZcOzVKQzJFmRAunZ4vh5+WHZYCTJ0ElYr5+QBM2c=
X-Google-Smtp-Source: AGHT+IHH7Fjbb8BSKN6Adc0NBdC+7qNT98Izyx6G7lNVR2qZjtCGcZMm5QEBmASxcnno+9HVyiQA9Q==
X-Received: by 2002:aca:2801:0:b0:3d1:fd63:a0f with SMTP id
 5614622812f47-3d210d6a03cmr861407b6e.20.1717718109244; 
 Thu, 06 Jun 2024 16:55:09 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3d20b66ca3dsm456641b6e.9.2024.06.06.16.55.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 16:55:08 -0700 (PDT)
Date: Thu, 6 Jun 2024 17:55:06 -0600
From: Tom Rini <trini@konsulko.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [GIT PULL] Please pull u-boot-dfu-20240606
Message-ID: <20240606235506.GG68077@bill-the-cat>
References: <87le3i1j2j.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rCkwXlXFyQ1Y04B3"
Content-Disposition: inline
In-Reply-To: <87le3i1j2j.fsf@baylibre.com>
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


--rCkwXlXFyQ1Y04B3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 06, 2024 at 12:06:44PM +0200, Mattijs Korpershoek wrote:

> Hi Tom,
>=20
> Please find some fixes for master:
>=20
> - dwc3 fix crash when ep0 stalls or gadget is stopped
> - Kconfig build fix for DFU_SF (SPI flash DFU driver)
>=20
> The CI job is at https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pi=
pelines/20990
>=20
> Thanks,
> Mattijs
>=20
> The following changes since commit c0ea27bccfb7d2d37fd36806ac2a2f73890994=
20:
>=20
>   Prepare v2024.07-rc4 (2024-06-03 18:34:59 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-dfu.git tags/u-boot-dfu=
-20240606
>=20
> for you to fetch changes up to 4339138a2086f8449b9356130cb6e97a81aa8679:
>=20
>   dfu: add missing dependency for SPI flash DFU driver (2024-06-06 09:11:=
21 +0200)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--rCkwXlXFyQ1Y04B3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZiTFoACgkQFHw5/5Y0
tyyoJAv+JJd8SLROkrq8wepUw+ps6q/PvxHBp7AW0iE6MVML+3vV1hfdDSFe3TxJ
gET6K/y2SvE4KDvKm2TLLJZtv55RvN+3Xi4pjeOWIXWiaiFCA7q0lWOQF4Tb71PI
HPTEeCD6sVIn1/6xPVcaemxzujh0dOwgA1RXcPa1OQSunQIR+EZmDrwHClZV1AjY
nbVTI0yYGMn9DZauQF73sZjQAAqW9qGDohW0Up7g8GIG/8JZzNCtm73EaUcH+t8t
xBq3Dmt2d3GjL/MIp5UuteWQfx521/sGWvyS/SXvRZCwPp6vrpepjMGVxvxgxYHE
EDu54HLG6KPBUE4E1mgrtvvcDep/UesTTZb0YcdHaUlsIFCL7EWYRGcgKAmorgYY
UgfuqK8be1/tEIeFsVY2w+MFEtPKteylSRX5z5XOCUvXXCw34JK4kl/kb+aQ1Wt7
buGbcb7J9pHFN2ltZY3pTpasuyVgJSlzF0juzEV6tDESpnf3MIwaOCFaBncT/WXp
877Swjgh
=LoWA
-----END PGP SIGNATURE-----

--rCkwXlXFyQ1Y04B3--
