Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF40FC021B2
	for <u-boot@archiver.kernel.org>; Tue, 25 Feb 2025 14:23:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15C2880805;
	Tue, 25 Feb 2025 15:23:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Fa3fngkY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95EB08081A; Tue, 25 Feb 2025 15:23:12 +0100 (CET)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61600807EE
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 15:23:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-471f9d11176so63879981cf.0
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 06:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740493389; x=1741098189; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jpccQP1wQ2uWfx/9mxAJB7qiyDiRd7hyp9S3OR+v1Ko=;
 b=Fa3fngkYHesP0sNYDZHHNRoDbVCuaPcunWgMleYWGy5Xn+YCbKGWMxLTpHUdshMfEa
 DrH/o2fJNyN5Sb8jTsjwTPx8coTSiNRZ5fkGQ/nHWB5JdzeyJ4btoinFVpkClVKIAHnX
 qMTkwPDlKOp0J0SsTPIiXMm5fn3RIDRyGdL78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740493389; x=1741098189;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jpccQP1wQ2uWfx/9mxAJB7qiyDiRd7hyp9S3OR+v1Ko=;
 b=vjTTscwaJP57uBijjif4evBqi6bxFpYYLNocyiULjYMyaoeRtEavDckdhKzquE7A4k
 AYtbziU8x1KmwozdrFlgiYyBwK5rHE0yHPuWiD3KVkagESQBK95aSNCecipckvPJ8JLn
 /qAFrxJruM5Efmu9sR9ZMn5B+YfEjsgXGFWkn92n/eerXv4lY1LYmXSpucUxW123ABCD
 DJMIhEL2AFIC2HaGRJ2zYRb4WU/t7u6Kpq9jU4htGw2VYI00M5YqgBMZGffwm3MzzOTI
 ibjlGkrorzrUZPh6GjWwojm40nas3ffTTrl6SacwBRONtrNrJMbF/AEgrtlR14/mU4sd
 SMtg==
X-Gm-Message-State: AOJu0YyaLcX6JfFH1EK/nqiJm9r0fiDx2OGJIcqvRzEIwbxUAYcVZ+JC
 J6RuhJ744vXC04kdyD/5RReplbypBc/28VLKKSnf3r1VqBDj53PvW/oCoVjb03s=
X-Gm-Gg: ASbGncvfn8ftwkqip3yvv3y8wTjV/waEgI3iLSqCyl/nPV1S2A+xDVubVNtdsdUCXpl
 noWTL4qaJRLikeZoM0+ObwqEtxilxktPucqQQb3XH+MqVOTICo9qQFAg1ecy+zKJoZQf4Os79YA
 hwLFrZv+X6gTYXDVcHbjaROJ4b+OCManCzTSgWp6pYBkQ0KE66MhYbmxas7liig+lZo/rxlSPIf
 qMVxHoH+rLmwqL3iaqLNfLdlx8guAAHRBpOZaPoufkHx74XAcnIE/E4c+z+D/UcoymghXs9a9n8
 C7s13fJRD85nrzmmd++uOt/3
X-Google-Smtp-Source: AGHT+IH+5R6JtDqjCKb2vMgDHuKjl4XFEc9mMxH1uUsgxuoUGvaEvrENyuKtNtfLsM7cRh5+0menYw==
X-Received: by 2002:ac8:574e:0:b0:472:133f:93b3 with SMTP id
 d75a77b69052e-47224923383mr257532731cf.47.1740493389194; 
 Tue, 25 Feb 2025 06:23:09 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-473780867a5sm10256801cf.78.2025.02.25.06.23.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 06:23:08 -0800 (PST)
Date: Tue, 25 Feb 2025 08:23:03 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Julien Masson <jmasson@baylibre.com>,
 Julius Lehmann <lehmanju@devpi.de>, Love Kumar <love.kumar@amd.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Moritz Fischer <moritzf@google.com>, Nam Cao <namcao@linutronix.de>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Philip Oberfichtner <pro@denx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Richard Weinberger <richard@nod.at>, Stephen Warren <swarren@nvidia.com>,
 Stephen Warren <swarren@wwwdotorg.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v3 00/44] x86: Improve operation under QEMU
Message-ID: <20250225142303.GN1233568@bill-the-cat>
References: <20250224230640.2665206-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lOSbmaG6ytFQr+Z6"
Content-Disposition: inline
In-Reply-To: <20250224230640.2665206-1-sjg@chromium.org>
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


--lOSbmaG6ytFQr+Z6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 04:05:49PM -0700, Simon Glass wrote:

> U-Boot can start and boot an OS in both qemu-x86 and qemu-x86_64 but it
> is not perfect.
>=20
> With both builds, executing the VESA ROM causes an intermittent hang, at
> least on some AMD CPUs.
>=20
> With qemu-x86_64 kvm cannot be used since the move to long mode (64-bit)
> is done in a way that works on real hardware but not with QEMU. This
> means that performance is 4-5x slower than it could be, at least on my
> CPU.
>=20
> We can work around the first problem by using Bochs, which is anyway a
> better choice than VESA for QEMU. The second can be addressed by using
> the same descriptor across the jump to long mode.
>=20
> With an MTRR fix this allows booting into Ubuntu on qemu-x86_64
>=20
> In v3 some e820 patches are included to make booting reliable and avoid
> ACPI tables being dropped. Also, several MTTR problems are addressed, to
> support memory sizes above 4GB reliably.

This is based on your tree I guess and not next, because you've not
rebased at least the prerequisite test/py series and I didn't try
farther than that with applying this.

--=20
Tom

--lOSbmaG6ytFQr+Z6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAme90kQACgkQFHw5/5Y0
tyxFFAv+KbHXXRIpTQt16JR1R16uoMRcOCJ0kA40qF+mXcsUeLH1aG2ZYaN3od5c
xgn2cWXsOd/QThi1XLi+96A1NQZzwbopmx3+lx+EJG3BBkvnpvMFQ/PHn9fFQiuz
3Iqznvh38OLSG1J1Wgb0mEBRoauT8lBWXaI7dx4OhBYALvgiZ2aY0cwW+mK/TJkN
w4gqQeg4TmcK1viwtFWeXwSJAQtBu/WX7WshsxMuE3+9POtIBhmNbd1TZcnW07/D
Tf8HwGEsNh7NI13/sLw8xfe3VUrjX2Iu5atcHKGFPlmjnPYYE4ug+d+H6vB3+NdK
k3Gj5tnOm8cDCRnSOJMrbi4gnp2HwxO0tOFBcQ2lT00G4FVzWCN3yhRbtSFsQCdc
Gwe4lpaK9GNIeT64uuo76O5x+s+xxjYUicOm/PCUjIfUA00/D/UgZPLoYZuHyN/O
vhU6GoVRfGvNFfcxfwSwMl6mkFJjSZ2X5Eg8K7HtQICgFyxzggDVMF4R9D9FOs0I
+MU1pRjV
=4CzA
-----END PGP SIGNATURE-----

--lOSbmaG6ytFQr+Z6--
