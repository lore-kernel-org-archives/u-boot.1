Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 276A3F3C9AC
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 16:07:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC44A83642;
	Tue, 24 Feb 2026 17:07:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WufKHut0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E71B783D8A; Tue, 24 Feb 2026 17:07:29 +0100 (CET)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DAB0682BF2
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 17:07:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7d18c654458so2333467a34.3
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 08:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771949246; x=1772554046; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=AVr160+R2N9w/FEKDOOg9M6GD3SO8xfv3XmJIOOSqaE=;
 b=WufKHut0Pd8uSphQ7ZGzwK2clwzIvOZP9qTFcuBXqlKo8wF2XeQRkkIow4tV8IVxVf
 EZ99p75sUDivTQhepyaEzRVwI2BWGzAJuZAjwnQm0XMYQ+7Zbv9hvKecAMVOrRkLEt40
 IjIry6f8xFxzu0jcfryTjAFxLaTucQBRfUWwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771949246; x=1772554046;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AVr160+R2N9w/FEKDOOg9M6GD3SO8xfv3XmJIOOSqaE=;
 b=bbKq3tbqNXHiSdN0pvzj4LzeFVTEV9DHYXG+jZfly58yqHIY2XhNbcYNZjnehDty5Q
 2oQXvfSE4WdQTHVpyL08GqjHacldOf5ScWeh/utBYGO40WhxrAjJ5CxlobREbJqiINcP
 aCbaoHRvdnTc+cc4cD1VxtBNmbLfudSJxMWZaO0ri7PBQ6CVfpbnsephD9G3vhnbgd3e
 ZPTJHCoyUNImmIq+YNao6zMHrZDTHegd56x8MN0ixg9jCwlMFjNjZvKC9Vdq6WcDBtQe
 qTE2zQJNDXtWTosFbG3PaPig8vAkKqfQUJpSgmSjqmLY/U7RfNNwuK6saovrfrXXkqbd
 ibBw==
X-Gm-Message-State: AOJu0Yx0wAG92vCgqg/bpW46VoZhvj69wm4CEPfgt4MGSHZTmRk/A4rQ
 EG+uFPRjkHECGFtSe44JFIq4KncIPblmjoFJ1ysEU5WBvOu74hDrKDrDHYA575lngU/P5KhrCLe
 5YuVe2g4=
X-Gm-Gg: AZuq6aKmUIqN2TxLx4UkzSwtFgPvCU9LjYQi4Cvv1wOYHQFIrePFLXBvftTbjLcGUMr
 SQBN9MPXfA0Qc57Wo8pIDk0R8RYez33N9t6Hizh1fnly0ZNUdLt45soZkOqcNcWyLcHr7y9dFx4
 OkX/kZgDOtfNnJ1h60+GhgzK6gB57kfvizaD4ZTlwrnpL/9/Ku1PrzkdV3nZ8PA3wYUMekq3x4W
 umCzO/oRj3u2p32cdvp8I0VshA2NxLwZumWruy9Jm5UZGXke0uXLNCy5G0mfsmF4qNhsrJmjj1t
 H2b0JOUNCNr6HA91mDwSpIvXyLThh49BrdTCINKq6lj1OiGBZteJe/rURi1Vg9ajoCiU067kH7+
 EX4PUDULGxdOv6lj9lJvv3rqVSbQOpVrQE/lKiFMlz8OQbIJcOKMnIo3qLXNfZZ0tYdSoTsLZ3Q
 03/eJs4k/9R8Q3yqEGfPMo9r+7msLPL0KpaxPl4swECXEPdNUpTYqABPBGfN0IbFcB84DuihRmA
 lQb1Fqqr5mkz4VbMxoLLdWuQ+3RpNDGnhWnVMhSnBOv84AK9y0=
X-Received: by 2002:a05:6830:7308:b0:7b0:826e:4002 with SMTP id
 46e09a7af769-7d52c2af431mr6963868a34.20.1771949246507; 
 Tue, 24 Feb 2026 08:07:26 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d52d038804sm10147052a34.18.2026.02.24.08.07.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 08:07:25 -0800 (PST)
Date: Tue, 24 Feb 2026 10:07:23 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Simon Glass <simon.glass@canonical.com>,
 Aristo Chen <jj251510319013@gmail.com>
Subject: Re: [PATCH v2 4/9] bootstage: Add some missing dummy functions
Message-ID: <20260224160723.GV3233182@bill-the-cat>
References: <20260224142553.1608883-1-simon.glass@canonical.com>
 <20260224142553.1608883-5-simon.glass@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MdhmSgbWqw4sT831"
Content-Disposition: inline
In-Reply-To: <20260224142553.1608883-5-simon.glass@canonical.com>
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


--MdhmSgbWqw4sT831
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 24, 2026 at 07:25:46AM -0700, Simon Glass wrote:

> Neither bootstage_fdt_add_report() nor bootstage_report() has a dummy
> double for when bootstage is disabled. Add them.
>=20
> Signed-off-by: Simon Glass <simon.glass@canonical.com>

While I am ambivalent about which is more readable, this at least
matches much of the other usage of bootstage functions. It should
however be one of the first patches in the series, so that bootm_final
can be introduced with this too.

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--MdhmSgbWqw4sT831
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZ3MuwAKCRAr4qD1Cr/k
CmmDAP9gv2VOeNnjhmVa2Bst/hr7drlBdL6yHu7LmTi3FRihXwEA4sGgSY2Wd1cx
V86NS4BmMjBj48ZumlFAhGjBTlUQdAE=
=6Czl
-----END PGP SIGNATURE-----

--MdhmSgbWqw4sT831--
