Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04D33C0032E
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 14:23:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74AEF879D6;
	Wed, 25 Oct 2023 16:23:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="D/Ekn2Qm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6985A87145; Wed, 25 Oct 2023 16:22:41 +0200 (CEST)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A31AD87AE4
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 16:22:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-57e40f0189aso3028114eaf.1
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 07:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698243757; x=1698848557; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Yb0sNMbsO3l5FcxQpC4zizZI302xvncfHI8QAYfg8Os=;
 b=D/Ekn2Qm8g8DeOOyFQOG/P7NMT7KEHlowqWXMV8Mzu7XFOq/T2W3ybqOgLthvFgjNq
 xcIAgTXRuTtd4W8jBfGn5mnTCH53f7yZXR4n1PWf0Qp4OslMfdTK+HcJFJj+9pnEv40D
 QXio/zvwKjSXDWzjuzQQtYSPGxDxUruK3I4x0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698243757; x=1698848557;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yb0sNMbsO3l5FcxQpC4zizZI302xvncfHI8QAYfg8Os=;
 b=vbG3LluUXMWkJ85P1/wom5Gc0Hl8MX0HJJdBtAsPhhkV4W0Js0dSKkDDyzr74gQ5N9
 b1pF0jGA7YvrELdVg/eRqdWVLR8uRnRPhAWOgQAYw1HIvlOLq0fX2xcShMS/FoqocHKG
 D94U9lvhtYbwDrVjyemrONxJ5wTpL2kUSdz7TnFxWgcyI2wiRzqOdSEez1DM02l+Q4ko
 wwD2a8NvNhsZo9bS7jVhNra+VZPyqNeTYWJ8kk1ctMEE9OgswTHPj0uWUFM9NnhNZhjB
 iw+UG+xL6akGTb2OLKIihaNmdpxv+FmcJI03eYpHFNJsoxMs50tIyBYcCxZnlrCulkfY
 bNWQ==
X-Gm-Message-State: AOJu0Yxc6u4mJq5nRHSjWECstox1+riFHHE74ZkuRSK34AAGadJQD75u
 BLODqvpPSaI840lsMbf0ZXxCzQ==
X-Google-Smtp-Source: AGHT+IGGV3Zzkz3yZ+v1kXzJn2y/DObKeBLDi/JHYdGE/uiFeIz7vmVMI9lU2fq3ZZnCbu4wznTb0g==
X-Received: by 2002:a05:6870:120b:b0:1d5:91d6:65f3 with SMTP id
 11-20020a056870120b00b001d591d665f3mr14765324oan.7.1698243757277; 
 Wed, 25 Oct 2023 07:22:37 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-89e7-8c52-372d-17ee.res6.spectrum.com.
 [2603:6081:7b00:6400:89e7:8c52:372d:17ee])
 by smtp.gmail.com with ESMTPSA id
 bt12-20020ad455cc000000b00655e428604esm4428323qvb.137.2023.10.25.07.22.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 07:22:36 -0700 (PDT)
Date: Wed, 25 Oct 2023 10:22:33 -0400
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com, takahiro.akashi@linaro.org,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexey Romanov <avromanov@sberdevices.ru>,
 Andre Przywara <andre.przywara@arm.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>,
 Bin Meng <bmeng.cn@gmail.com>, Chris Packham <judge.packham@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Fabio Estevam <festevam@gmail.com>, Gaurav Jain <gaurav.jain@nxp.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Huan Wang <alison.wang@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Jean-Marie Lemetayer <j.lemetayer@kerlink.fr>,
 Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>, Leo <ycliang@andestech.com>,
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Qu Wenruo <wqu@suse.com>, Ramon Fried <rfried.dev@gmail.com>,
 Rick Chen <rick@andestech.com>, Roger Knecht <rknecht@pm.me>,
 Roger Quadros <rogerq@kernel.org>, Samuel Holland <samuel@sholland.org>,
 Sean Edmond <seanedmond@microsoft.com>,
 Simon Glass <sjg@chromium.org>, Stefan Roese <sr@denx.de>,
 Stefano Babic <sbabic@denx.de>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tobias Waldekranz <tobias@waldekranz.com>,
 Tom Warren <twarren@nvidia.com>, Vignesh R <vigneshr@ti.com>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Subject: Re: [PATCH] Kconfig: Remove all default n/no options
Message-ID: <20231025142233.GP496310@bill-the-cat>
References: <e3bb5522913c8a917feb7d6309a693f7ee5dbe25.1698218728.git.michal.simek@amd.com>
 <20231025134002.GM496310@bill-the-cat>
 <80c55729-649c-422a-a52d-c0e2397442dc@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="eg2VxpRIDXG15qQG"
Content-Disposition: inline
In-Reply-To: <80c55729-649c-422a-a52d-c0e2397442dc@amd.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Wed, 25 Oct 2023 16:23:04 +0200
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


--eg2VxpRIDXG15qQG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2023 at 03:44:11PM +0200, Michal Simek wrote:
>=20
>=20
> On 10/25/23 15:40, Tom Rini wrote:
> > :n Wed, Oct 25, 2023 at 09:25:37AM +0200, Michal Simek wrote:
> > > Similar change was done by commit b4c2c151b14b ("Kconfig: Remove all
> >=20
> > > default n/no options") and again sync is required.
> > >=20
> > > default n/no doesn't need to be specified. It is default option anywa=
y.
> > >=20
> > > Signed-off-by: Michal Simek <michal.simek@amd.com>
> >=20
> > Thanks.  It would be good to add something to checkpatch.pl for this,
> > and it would be appropriate to do it outside of the u-boot specific
> > checks I think.  A similar patch could be done for the kernel as I see
> > 519 instances there currently.
>=20
> yes that would be good.
>=20
> >=20
> > Reviewed-by: Tom Rini <trini@konsulko.com>
>=20
> Tom: Are you using qconfig.py for defconfig syncup?

Yes, qconfig.py -sC, just like before the rename. And aside, I'm pretty
sure I remembered to run it prior to tagging -rc1 this time.

--=20
Tom

--eg2VxpRIDXG15qQG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU5JKkACgkQFHw5/5Y0
tyxdoQwAlS+UIco+zSgsxvPIz7Yq8MiCu8iQtjk1NnYZeYtz8VfN9/dWJ7CmGCCx
luF/lUc2uzL00xn0WPWJcH7KQkp2PqtgJNl4ek3IslY+8mHKKaenzYDLR0HxNJGA
OCJUbHhQitofMkD2E3WtOtrjvQ0u2qnphM3EuhL339gYg6JZQWsimUKI6Os8baXo
CFGuBAwQNjS0VEm3svqS8w10wa50BMBZn2uxqZRrVHmzpaIJH3yqH3PJX37DrHOd
M7ZBF95Mts6ifXQmhCH/NT+uHD53NPkqhJtH9nz2c1XrGlq9ZD7H6nvklc6dFdUX
y64PiJFVHPHy8htNCwSMMSGGGtZSRl28eT65l6rAvKiklxZwJKMf4QjS2AP0kKmc
EcUWj0rmQoSeU9GgHt5EGTI0AXAijv5SJvRjnJneIGIKho3vO7PhWPS0X7fmPq1e
BJ4CXR2S3eEtA+SCyr10739VjRv92wG0yHJZO+VOfxWdQg2CFfTUqJfU9Hza+RvC
fsYvk2Dn
=WpY+
-----END PGP SIGNATURE-----

--eg2VxpRIDXG15qQG--
