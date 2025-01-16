Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D13FC02183
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 23:28:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B01E80717;
	Fri, 17 Jan 2025 00:28:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EQRvyrJ4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9780A8073F; Fri, 17 Jan 2025 00:28:49 +0100 (CET)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7245B80703
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 00:28:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6dd43b08674so15665736d6.3
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 15:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737070126; x=1737674926; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=uYGPigbvHV3y3/SGux3oEoSVecgrmZh11F0XD1zwUgE=;
 b=EQRvyrJ4iHUMViCPzlEduQbBksx6zcqNamwbIhVyJZd0Db+WBG58jvsHrwoo+3pFTw
 Q1SEwBZ/NxqXH7SLtbAIqwz8ayzl/SjkwNzsjDC39NFuDNi2ZOjMLO8Cr4dH1tAZYM3l
 3LsvdoSaYmPm4V+7THGgCRd4K6UpkqxUnaPss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737070126; x=1737674926;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uYGPigbvHV3y3/SGux3oEoSVecgrmZh11F0XD1zwUgE=;
 b=Yf0ozWYYWLi82EA95I4pG1/dNtqRaVLmj3dc0ABGwp8kuzDH2eCrlr7JP2dNMzeBdu
 blMnCLy582jcKzDyP8IBQMfF2u2yEoXG81w1SwBJ9ZdbpY0bvR3i2qgH9rX9NiDyrq5V
 PX4oHfa7sAa4GfOQUSzmZ/F60/w9k9bL2rDHwsexcpG5eU8MAQ96A9VXeLVonqGX4Efm
 MwaIEjYG/yZcesbcadadyFrNGRnihsEK4HVXg+dLrdUgnhLBpOewCX9slDRoQeKWkN4O
 KsqTtsNmIUYt347dSA8Nx0lsgBR1k/o4VPbF15LMmhVl3EO7uN7Tw14SC/qYXhSxsVEr
 BbLg==
X-Gm-Message-State: AOJu0YyR1uJPrfZV2JmxBcxsyHsQiKsawl8dNQpdv6vbpL2LYHhJ/KUA
 IxIaNlovDyu3qHH5DWTsKyeiBtrf+NsQ8Spf1uh/9hc/EYeHDttkT7IVcesAHsI=
X-Gm-Gg: ASbGncu7+TzHcEI2k6K/LHzjaRsuYqMK+P4egMppXa2GMM8zQKyfK2itBhPP4StSFX2
 58PYJA3gAaqmpBZ1qugGaLJQpuSAezgfpckzLmlCKd0DO75MM42Lov/kjoN+fgHiH8V2hSUb486
 Adl6m4FtFLaZe7cwsSj7XghummR9vXGqEByky36Tyo+2T/cfjpkO8PV/fD+Te+hnLK8OlQDpBvC
 aZ7KXxx+Kjr7KsoFNmDDMnPWkWxf08PtB6Ovrsgqo+C0qUs+I1b5A==
X-Google-Smtp-Source: AGHT+IGld09DOqki1m+p+sM2s6o+JM66KCdmnIxp/ciQXLa3YVrdufJoJUXlYYkv8vLh0MCqr9VViA==
X-Received: by 2002:a05:6214:3197:b0:6d8:ab7e:e554 with SMTP id
 6a1803df08f44-6e1b222f1f3mr14165106d6.34.1737070126324; 
 Thu, 16 Jan 2025 15:28:46 -0800 (PST)
Received: from bill-the-cat ([187.144.16.9]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e1afcd3753sm5370266d6.73.2025.01.16.15.28.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 15:28:45 -0800 (PST)
Date: Thu, 16 Jan 2025 17:28:40 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Adriano Cordova <adrianox@gmail.com>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ion Agorria <ion@agorria.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Julien Masson <jmasson@baylibre.com>, Leo <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Michal Simek <michal.simek@amd.com>, Nam Cao <namcao@linutronix.de>,
 Peter Korsgaard <peter@korsgaard.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ramon Fried <rfried.dev@gmail.com>, Rick Chen <rick@andestech.com>,
 Roman Stratiienko <r.stratiienko@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@arm.com>
Subject: Re: [PATCH v3 00/46] pxe: Support read_all() for extlinux and PXE
Message-ID: <20250116232840.GN3476@bill-the-cat>
References: <20241206023626.2456858-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="z0rn8UmduGN2lUFz"
Content-Disposition: inline
In-Reply-To: <20241206023626.2456858-1-sjg@chromium.org>
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


--z0rn8UmduGN2lUFz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 05, 2024 at 07:35:39PM -0700, Simon Glass wrote:

> This series implements read_all() so that it is possible to read all the
> files relating to a bootflow, make adjustments and then boot.
>=20
> Unfortunately quite a few things stand in the way, so this series
> finishes off several pending items: zboot without CONFIG_CMDLINE,
> required support in pxe_utils and the differing code in the extlinux and
> PXE bootmeths. There is very little new code, but quite a lot of
> refactoring.
>=20
> The bootm, booti and bootz commands have all been refactored previously,
> so that they can operate without needing CONFIG_CMDLINE to be enabled.
> At the, time, zboot was left alone, since it is x86-specific and a bit
> more trouble.
>=20
> However it turns out that the booti support doesn't work with compressed
> booti images, so this series resolved that problem too.
>=20
> This series adds a programatic API for zboot and uses the forthcoming
> bootstd 'image list' to collect information from an extlinux file. It is
> therefore possible to parse the file, load the resulting images and then
> examine/adjust the resulting bootflow, before booting.
>=20
> The addition of options to extlinux resulted in the PXE and extlinux
> bootmeth having slightly different features. This is tidied up in this
> series, with common functions for both. This allows the same features
> (loading images as a separate step) to be provided for PXE.

To sync up with what I said on IRC, this breaks
test/py/tests/test_net_boot.py likely due to changes in the output.

--=20
Tom

--z0rn8UmduGN2lUFz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeJligACgkQFHw5/5Y0
tyzUlAwAmBYX0QioEv2Aw37pTf6rk6BDRj5ybtHEityfAife7Q13QNXwlAgfObMR
KEXmGeCvCOgGUugrBepLXf4L89+XDFgESYNpc6BP4bAWQOkNiU+ktj4gKhaG6FD9
je7A4RXfXNUKFaWBapIp04K/EdHZ7wash+l/b8JmjaYaY+ubjiv2PxAMuGSHebkE
hjVYS7lxeBoCWZz+clN3uYq7mkFEsgu868d7Ym86IDNLzI0ZsxlzZabHGcRHLZ9T
tRRXPGIddF0vkr817vszxAIXG8ESYH9vElnKgZa+jS7S5EFCj8dvivtLnZk3bkvY
Dol7Mv+I3u899H6oySA7xvUDHTfscYMcLSRLKjWJz9f0jyQcUXsPMPDgw4tYOS5/
lOfs9jZ2q0rdixDk0XysCe2tCxAYphdwI1/RdHrdTUWfuhiltgz6zX/Np5xVE3QK
AK81YzjJDf/qwnyYIgHjILbVInznCdCCSCpSQVWhdxZpxUKSxnZD6otxrE0kUKcA
zheBjXCt
=3kCS
-----END PGP SIGNATURE-----

--z0rn8UmduGN2lUFz--
