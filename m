Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7684C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 15:46:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1686E876FF;
	Wed, 20 Dec 2023 16:46:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qCCTUHgJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8609F876D5; Wed, 20 Dec 2023 16:46:44 +0100 (CET)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A5B887032
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 16:46:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-6da682e0a20so2913792a34.0
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 07:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703087200; x=1703692000; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Vpukr1F9TFvvBzM7YY+Z96AFZtR1VHvSwx8fcnR3Jmk=;
 b=qCCTUHgJ2axQkQkcaonpIdPWPOjGNmhYZcJdvSewkEa9Ej1WK6qledGbQTv5Q4gF25
 BHgQ2Q5id1BvnKVKucoSCWfKDJ/cGxtDzufMWWwFkdyQ+Qv3/ouXjMpwfjTdaKGAIz6W
 9cgOSTFIPUROBkb7soi+A9B6WrPfa0RNY42g8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703087200; x=1703692000;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vpukr1F9TFvvBzM7YY+Z96AFZtR1VHvSwx8fcnR3Jmk=;
 b=TdeYCSQA+eeTn51ZYn0PXNcqlAAwbm3h98a4QzsETec9SfB6GkOurxtXXLISABG6XP
 qEMPL+fwlEhv6FSGnumjhKxdhuAr/lNPrr1rfC294fgS/NslIaN2UaFqisS7lKnxfYgI
 YlY95E+C6S9e9COJWiCaU9HOjwY6kvukKiTOutfl0u0c4bUvP6R4v8AK7t0LEFVLN1er
 UJIx96fHPidggyCc/3jhBVSSnQIHogOssMYirI81HytT+8WLgD0MTvNRMTEZuXtkJoQ3
 btbTH42uSJ3u1mavQZtsrWJ2rOplQgtUyY76Y0dXQezYICvtVJzbdoiObvHubcSHvEu1
 gpJg==
X-Gm-Message-State: AOJu0YzSqgTmc3ZEgIodhk7oNHXnE5P1klCm512EtfI4IurKsi32Z/CO
 VfjUJPrurTdq0bNqiUt/r79NAg==
X-Google-Smtp-Source: AGHT+IHA+12GPu5N2buKqEBCcl7dtvV/v5DYTwf6DWyB92gm2OZ19y0pOWCGIka7jjJkAuVyiZRQeA==
X-Received: by 2002:a9d:784d:0:b0:6d9:f4c1:2003 with SMTP id
 c13-20020a9d784d000000b006d9f4c12003mr19729776otm.15.1703087200767; 
 Wed, 20 Dec 2023 07:46:40 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-ae12-866a-2c78-8ee6.res6.spectrum.com.
 [2603:6081:7b00:6400:ae12:866a:2c78:8ee6])
 by smtp.gmail.com with ESMTPSA id
 g6-20020a0df606000000b005d317074440sm10742127ywf.79.2023.12.20.07.46.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 07:46:39 -0800 (PST)
Date: Wed, 20 Dec 2023 10:46:37 -0500
From: Tom Rini <trini@konsulko.com>
To: Love Kumar <love.kumar@amd.com>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, git@xilinx.com
Subject: Re: [PATCH v2] test/py: i2c: Add tests for i2c command
Message-ID: <20231220154637.GA4032343@bill-the-cat>
References: <0d8e994ea619d3942ee215a8f5635627e89c3512.1700567875.git.love.kumar@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="cOg/app94CYA2Iit"
Content-Disposition: inline
In-Reply-To: <0d8e994ea619d3942ee215a8f5635627e89c3512.1700567875.git.love.kumar@amd.com>
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


--cOg/app94CYA2Iit
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 05:28:43PM +0530, Love Kumar wrote:

> Add below test cases for i2c commands:
> i2c_bus - To show i2c bus info,
> i2c_dev - To set or show the current bus,
> i2c_probe - To probe the i2c device,
> i2c_eeprom - To test i2c eeprom device,
> i2c_probe_all_buses - To list down all the buses and probes it
>=20
> Signed-off-by: Love Kumar <love.kumar@amd.com>
> Reviewed-by: Tom Rini <trini@konsulko.com>
> ---
> Changes in v2:
> - Take the configured eeprom value from env to read back and compare
> ---
>  test/py/tests/test_i2c.py | 108 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 108 insertions(+)
>  create mode 100644 test/py/tests/test_i2c.py

So this leads to failures in CI on other platforms.  Please put this and
the other tests through CI:
https://docs.u-boot.org/en/latest/develop/ci_testing.html
Thanks!

--=20
Tom

--cOg/app94CYA2Iit
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWDDFoACgkQFHw5/5Y0
tyzNMAwAsWpoItCT/8XdATR1R/4ypQAvcmkPyHUGtgxFSo1cG1qHRd3xuVbxEY3H
Yes0R29LlvwxszccMq8Ffj/IEZDaLS99tBIVHwvtdM5vIkL+7u3p6I8NBNrjb0qY
5JS5LvewB1CVQV+JD5ccUG9CurhoM3WFUEu2Y3BMu4P6xV8qRazxtGNq25foLUFH
2JhJEyDiSeGY8MauCWo8nRzs/y2ev6Aw8ZdABbdda4rQNjjwycGb15Vij0pDOsns
28GrIVnaV1aQUGVDBP2u6bm1SkIiYbRj00Gfr/Ixwr92OOJig5PhmpmnyRVVXFVX
9b+m51Yxo7STY71wsnESU/uQduumUGu/dhDynHSV4UeX2y2PvouRuWrorAlBdSwG
uspedPSDkto6W1YyTRC/OvRhc2CQpcejiYqJVK4hWpKC/fKtwhht8C42yS0D6c0i
i+RFrU5YWRYmp2HvU640q5KDCcohudT4trJjmAoUqspNKpgY3ooCk4ghFBjiU5dU
07HF/Z9u
=hAw4
-----END PGP SIGNATURE-----

--cOg/app94CYA2Iit--
