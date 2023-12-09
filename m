Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 225A3C4167B
	for <u-boot@archiver.kernel.org>; Sat,  9 Dec 2023 15:59:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9406C8765B;
	Sat,  9 Dec 2023 16:59:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kJFNgkL5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1877587645; Sat,  9 Dec 2023 16:59:34 +0100 (CET)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0061A8765B
 for <u-boot@lists.denx.de>; Sat,  9 Dec 2023 16:59:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-5d05ff42db0so28370087b3.2
 for <u-boot@lists.denx.de>; Sat, 09 Dec 2023 07:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702137570; x=1702742370; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RVWVNYK+BRHjWvvRHmYZQVca/dbStEtEIC4V6bQ4F3U=;
 b=kJFNgkL5S2YZymLLxUfATVXQ4j+2P5WhjsCampVb93c/cyHHea3jYnbp14nzhWisI5
 KcimOlo6tv8FW/RnzcnKafXnsHJ44LIBdoRdu7kR1AAIdLRHzw3epM1qBp+pDFvnebo+
 AqGKfuz3nJYFEneX5nZbCa1gsdKesbYNGBUjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702137570; x=1702742370;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RVWVNYK+BRHjWvvRHmYZQVca/dbStEtEIC4V6bQ4F3U=;
 b=Qi+z94L+/vnM0TjDbKnh2CZCM50D24egqyNPRPbLWhEA3H723oypnXNABNNvraR5+d
 1wsISf+9zeduPx0Gxdfe27qWVnalJAvrh0g1jWRSLRhFlbMBDkCO5mzmnfdiopLS+uh5
 SjYC3+GW5HUjcKmkX5e+qK3mpDM7IrHIDxXhBQLYliBFQSkhXM98uO0ynH4zgn5HuyJm
 IKyfTZBUMefI5kVli7G3rxYby94M5VwdE0zdnragE9/hfMJM2UmdO4spMGTz3R5wBSUU
 XqxjBAmKO7m0pl9Re7AwkJMotAMqHMacD8rszVRhmGx3+HSEUw8niM+eNboavNOjzHW5
 gukQ==
X-Gm-Message-State: AOJu0YwWDAHKW3gMs4WeLWedtT3isJG+jwLWRvRqozwaatdu0+3JLBKw
 qs4lAHkPFy0VTWNl9050/ntbCg==
X-Google-Smtp-Source: AGHT+IHEA1b2uVjf/Cxyqra9mcCvyN8AX8TMb8e+ieGj3IiPbluQUOyAyhe4kSZ2V3DVwnPdakI2SA==
X-Received: by 2002:a81:650a:0:b0:5d0:9a2f:26e7 with SMTP id
 z10-20020a81650a000000b005d09a2f26e7mr1295298ywb.19.1702137569787; 
 Sat, 09 Dec 2023 07:59:29 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-b2bd-da43-c83a-80e1.res6.spectrum.com.
 [2603:6081:7b00:6400:b2bd:da43:c83a:80e1])
 by smtp.gmail.com with ESMTPSA id
 y188-20020a0dd6c5000000b005d6da42e443sm1558619ywd.59.2023.12.09.07.59.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Dec 2023 07:59:29 -0800 (PST)
Date: Sat, 9 Dec 2023 10:59:27 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Marek Vasut <marex@denx.de>
Subject: Re: [PATCH 07/18] mips: Add a reset_cpu() function
Message-ID: <20231209155927.GP2513409@bill-the-cat>
References: <20231204002642.895926-1-sjg@chromium.org>
 <20231203172622.7.I2c0bbce52ecf7ce9458c481fbd12b6029e5ebd27@changeid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XsJQRfQqmNJGgE+r"
Content-Disposition: inline
In-Reply-To: <20231203172622.7.I2c0bbce52ecf7ce9458c481fbd12b6029e5ebd27@changeid>
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


--XsJQRfQqmNJGgE+r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 03, 2023 at 05:26:23PM -0700, Simon Glass wrote:

> The current do_reset() is called from a command context. Add a function
> which can be used from anywhere, as is done on ARM.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---

A consistent API here for all architectures is good, thanks for doing
this cleanup.

--=20
Tom

--XsJQRfQqmNJGgE+r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV0jt8ACgkQFHw5/5Y0
tyzPrAwAqYRZFucbl1cGKeD/JlS708jvSSQwdQW15fj0krRx064QunCyQkmnv9am
BC5uZYqpAcvtkcas0TztdAWVoRZAhcb7g4V00zDvpa4HduNbFSnNbaecoY9m9oC2
IqQfRrPX7uP53lqeS5eZ9N2CnrNeYo1KJ+sOTxJijLXyqaNh149XC6zI2vFBtVbv
ReFvWmAtMqRjqLrSWmKXYF8w8peL5BD6IctGL90CjkZo5NjlgPfUal7REeSqweDB
qpZyvbmTNswhfIe6H8xgIniflshRqKdbUxvxss6jnYqQiDw5fY1c6mmCUexl4qdm
sHXXFU9MKQjQGHj65HuPVVAP7g2rgE9Dp9d+MnX6VYY8E3sn0/rqYZNmtbkyRuO5
kOgBpK9Ybh54tazD6D/COuRjFnSm+xORaP9BfdGHNAMDxrHUkHd4GOnqp1rR7JtY
kSLbwJpxl/FXZZrTtcIZY0mFhfJ/JvKyMfQlgeRUo1lDOWI+L8evX9ugt4b+0c9x
0nP+dCzB
=Tj2B
-----END PGP SIGNATURE-----

--XsJQRfQqmNJGgE+r--
