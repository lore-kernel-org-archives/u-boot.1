Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89D98C3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 21:24:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C449A87A08;
	Thu, 28 Dec 2023 22:24:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="G5+T2nmV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A771587A39; Thu, 28 Dec 2023 22:24:37 +0100 (CET)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C999987A28
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 22:24:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-5e86fc3f1e2so44150707b3.0
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 13:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703798672; x=1704403472; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0TT+WqyqhN/B9rMZk/iNRXfUp5vXa9a6RJpciPZaqSs=;
 b=G5+T2nmVt2jkOq/f/15tBjW6yBAjLs4hQox4SzT9w1HTjF0ZsMZ11kgdT6f0Li/n1v
 Lh/ySaSxWLKREnUuOfb2wOI2QMefYhOS1aZEdiBpn0jQ94xulWw6U4LSPRtsDQDn04w9
 S7dhj1c5F0QsyBvzmQK/SzraqAJk5AA4qvNQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703798672; x=1704403472;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0TT+WqyqhN/B9rMZk/iNRXfUp5vXa9a6RJpciPZaqSs=;
 b=ET+NCTQdKwSNKcyhEXoN7dh0Db/tW1GOY96wb4iF4tWU5hzxYgAcEcsOeINShEXsqh
 6qtjfE2L4e2cd9QwQA4HMM6vmlD1eh6UZIXYqtaq9YtbC7pXulCfi3IfBJIp+3FXl14K
 KrswcDUJzrGDtsj2L1WqSNOMOhVOv+RWsYMLnkFG9A4tuk5N4IDEc5DQ77wbR1UT0iJR
 1HJbKFUrKWg4qOeiCeNjk+2kGsfPJcPwjFOb6Lj1mTmCuuu1qganoV0RwTJX/n/+LvKx
 e/VLwcvMVl5fyTQgVJMZQCdGuWGoppt1zYsXLmVnOtK/v58Tl55usdqW3gfoYHx2RxLW
 4PMA==
X-Gm-Message-State: AOJu0YyrBmSKyt8l7jcxPUCSbRfhmT+BwBNErroYNt7JxctZiAsz6KBV
 Bjs2Wi0BMIjeYWyihcZ/JVqYDb+09Tmbug==
X-Google-Smtp-Source: AGHT+IFSSxLH7frBLzoJXHLp9lqywwevNR8ESuYJYZgeFSskN907efXvZJUPDyMuHFuLcXF9setC3w==
X-Received: by 2002:a81:5b05:0:b0:5e7:6b24:4a38 with SMTP id
 p5-20020a815b05000000b005e76b244a38mr7487834ywb.56.1703798672516; 
 Thu, 28 Dec 2023 13:24:32 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 c67-20020a814e46000000b005e4d89b4520sm7797295ywb.47.2023.12.28.13.24.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Dec 2023 13:24:31 -0800 (PST)
Date: Thu, 28 Dec 2023 16:24:29 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Raymond Mao <raymond.mao@linaro.org>, Marek Vasut <marex@denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Baruch Siach <baruch@tkos.co.il>, Bin Meng <bmeng.cn@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerry Van Baren <vanbaren@cideas.com>, Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Nikhil M Jain <n-jain1@ti.com>, Qu Wenruo <wqu@suse.com>,
 Sean Anderson <seanga2@gmail.com>, Stefan Roese <sr@denx.de>
Subject: Re: [PATCH v6] fdt: Allow the devicetree to come from a bloblist
Message-ID: <20231228212429.GR2652760@bill-the-cat>
References: <20231228194725.2482268-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="F2Ms8lg+30CX4lih"
Content-Disposition: inline
In-Reply-To: <20231228194725.2482268-1-sjg@chromium.org>
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


--F2Ms8lg+30CX4lih
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 28, 2023 at 07:47:25PM +0000, Simon Glass wrote:

> Standard passage provides for a bloblist to be passed from one firmware
> phase to the next. That can be used to pass the devicetree along as well.
> Add an option to support this.
>=20
> Tests for this will be added as part of the Universal Payload work.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
[snip]
> diff --git a/dts/Kconfig b/dts/Kconfig
> index 00c0aeff893..ae451b9caf7 100644
> --- a/dts/Kconfig
> +++ b/dts/Kconfig
> @@ -105,6 +105,19 @@ config OF_EMBED
> =20
>  endchoice
> =20
> +config OF_BLOBLIST
> +	bool "Provided by a bloblist at runtime"
> +	depends on BLOBLIST && OF_SEPARATE

This is now even more confusing, frankly. The help for OF_SEPARATE says:
If this option is enabled, the device tree will be built and placed as a
separate u-boot.dtb file alongside the U-Boot image.

So why would you enable that to then have a device tree passed via
bloblist instead?

We should probably start by fixing all of this confusing naming / logic
and then correct things such that:
- OF_EMBED wins if set. This is the override-has-been-set we-must-use-it
  switch. First choice, not last choice. If binman needs tweaks so that
  it will still generate images for platforms in this case, that needs
  to happen.
- If we have a bloblist, we scan the bloblist for DT and if found, use
  it.
- If it looks like we've been booted as a fake Linux kernel, and we can
  start with just aarch64 and let riscv come in as a follow up, so
  what's documented within
  https://www.kernel.org/doc/html/latest/arch/arm64/booting.html#call-the-k=
ernel-image
  then we use that device tree.
  - This _may_ just end up having to be "Does x0 (or similar) point to a
    valid DT?" as I don't know how correct everything using this method
    today is too what the spec above lists.
- If we have a dtb appended to use by what we call today OF_SEPARATE but
  should really stop calling it that we use that.

At that point, we can probably have zero "totally board specific kludge
for device tree location", and kill off OF_HAS_PRIOR_STAGE too (since
that's really just bloblist or fake-linux-kernel). We'll also be able to
support migration from fake-linux-kernel to bloblist

--=20
Tom

--F2Ms8lg+30CX4lih
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWN54IACgkQFHw5/5Y0
tyyznwv/dPia540TCvR8ML0ygLemtiZ+ztj19CNSFM96YC5ieKzcZioNYc3XCE8m
tn/GJ4Fl6jG+F8swvJBYOclmXd2Yxy25JTLss8IRNfiSVNtyczUp6Yam/GDEqcQc
tVZPQWkiQm0IElfYD52zv5GukcZjZrrKdkCHlve8FyLZGrunPfN3X+beUhwT9VNi
25/ih72GswJYH/UYI5xzsZb4S7ru534HcC+ML66KgsLyH1dKLGXQ8eyVOlKEPUWl
XeRFupRLwXjkWJFlAFJ9HvWnbTRRr0fQBABHfzcnaddlD9aU9KdSaKVi8pqw4dYp
ujbWrCPEE+MCaa9UOwcjpNbXzcbYO4H8Hz8+iU+WW2TXYj7EGoTuDY3vQJWCdbo2
lfvL0A31L2vcEH7yUenPp7VE3+4uuoyAtat8OCvyETESypJgEQxU6jijR5XHDiiH
3JyzzPvTsaXVXFXkUB1IKrlQJt7UZZ5oK+s5UiUAu/xi7iPZOMiVntkKyFh0cWPM
Prj9AKB9
=P6WX
-----END PGP SIGNATURE-----

--F2Ms8lg+30CX4lih--
