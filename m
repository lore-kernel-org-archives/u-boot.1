Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5DE0C25B75
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 14:21:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E29188274;
	Thu,  6 Jun 2024 16:21:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="i5QvOGq7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C084181F9A; Thu,  6 Jun 2024 16:21:43 +0200 (CEST)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F1EE88274
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 16:21:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-24c9f297524so528473fac.0
 for <u-boot@lists.denx.de>; Thu, 06 Jun 2024 07:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1717683700; x=1718288500; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=aN57YVQ+CGASsDUpVDyhzc2H39QjCCRaa+Mo/rL8C6M=;
 b=i5QvOGq7iOZht5F8jFPGSZ+IQo1qbKaiWb8aEKPcMH116pKreFhNhaOsObZOv7W0Ys
 yP8bQxHlcou8wPj7K7jdGF2/o4aI+ffwPPNwvm03LWeeAQXvqxVyU0juST594bOv6Uys
 Mm/U0fs3qvH7YuNeuJ5hMRHJ0XydNcYZv4LI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717683700; x=1718288500;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aN57YVQ+CGASsDUpVDyhzc2H39QjCCRaa+Mo/rL8C6M=;
 b=XlI0FmnUKO7AYhWIiPlTBkqdb+NAw5h0bBC7Zz+Hjrd6ywAkJ+xrxNdrzQ2c/3lLjc
 pT/CLXj01gTHEvysiBja9cWoSTFCA8ebOLjKFDVEgb6ZRqm4Dh5pfGvg73qGaq1sPrTb
 9505mowajEoWPEswIorlc9SCERljzHWn8UmH2V5WVm2dMfbU9W7fN4hzQtqaiQTOZQ3f
 eTzUreOCXSmU/dSL/iLWCBgkgiN7OdMsAdfTsGbJSVJ0DRyB9PYOzUs3s4V+ZO9/ZEgX
 7+g30HSZfETb7AjHjgrdXp+gqb2Vj2UVzIMyIT46hX2eoAoT8mwKfGfYMwaRye3fDWYp
 Zh2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGyKPqGO3OuHfpI26wjpe1n6BERM10/XIc8G2OGOUCjKPc/jflieSSKdueK8s6Zot+bbdvDsAQS9JoOr6gNSkSxbrRCw==
X-Gm-Message-State: AOJu0YyttfPz3o6+LKeUt7QvSfrM653YLvr3pJk4InMws1DAYUbhBgdT
 BlKVjwsgFPrRS1QLLkvbcmfinjCo4lPpgWAZDD38w50qrrzW2lkdxpc6YncHO28=
X-Google-Smtp-Source: AGHT+IHiEi3jgAIXt51EzYj1Ah+1Hp/gXN8N9YrubLgyg2VspCZUOTHSaK/vKTJwXXQOWm4W6mplAw==
X-Received: by 2002:a05:6870:7026:b0:250:6a57:e1d3 with SMTP id
 586e51a60fabf-251228de5d0mr6314293fac.38.1717683700059; 
 Thu, 06 Jun 2024 07:21:40 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-25447d794cfsm383835fac.1.2024.06.06.07.21.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 07:21:39 -0700 (PDT)
Date: Thu, 6 Jun 2024 08:21:36 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Maxim Moskalets <maximmosk4@gmail.com>, Maxim.Moskalets@kaspersky.com,
 quentin.schulz@theobroma-systems.com, sjg@chromium.org,
 u-boot@lists.denx.de
Subject: Re: [PATCH v5] cmd: move ELF load and boot to lib/elf.c
Message-ID: <20240606142136.GY68077@bill-the-cat>
References: <20240605184334.13973-1-Maxim.Moskalets@kaspersky.com>
 <b95386ab-ec35-4912-934d-c3b611953b55@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="anMuW3CO9yBBn61r"
Content-Disposition: inline
In-Reply-To: <b95386ab-ec35-4912-934d-c3b611953b55@gmx.de>
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


--anMuW3CO9yBBn61r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 06, 2024 at 09:02:43AM +0200, Heinrich Schuchardt wrote:
> On 6/5/24 20:43, Maxim Moskalets wrote:
> > From: Maxim Moskalets <maximmosk4@gmail.com>
> >=20
> > Loading and running the ELF image is the responsibility of the
> > library and should not be associated with the command line interface.
> >=20
> > It is also required to run ELF images from FIT with the bootm command
> > so as not to depend on the command line interface.
> >=20
> > Signed-off-by: Maxim Moskalets <maximmosk4@gmail.com>
>=20
> In future versions please, include a change log separated from the
> commit message by ---, e.g.
>=20
> ---
> v6:
> 	foo changed to bar
> v5:
> 	xxx removed
> ---
>=20
> Best regards
>=20
> Heinrich

Do you have any other feedback, Heinrich?

--=20
Tom

--anMuW3CO9yBBn61r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZhxeYACgkQFHw5/5Y0
tywOSwwAnTTRBi9EDcxggItsNIAmpPSYL1aLxbTlLL3+drRa0XdwZwYByb6oiy0z
z/u3/zbrVBIgNHFbTuOXJ8L99hCHEk8tb4rwDTqdVOs2/7iMNHTnpCd6vpyl5R3f
4k+5/i8oGxMUw4OAPwRZ5sENtrhRdVQ5zArcRYdpdGi/jQCC3NEYbtbNcpX2jeh9
DNLUhJ0qpScOh+pUxc+7DAqiVDh9IQNUpbvD/venOah52nllklN32+sR/9SOgvsV
LnBr7M0878foJhfP1VfT7NrWnABRcKYhpd8KKgbx5vkYFCFz5/zeZpp8JejuoMZd
UZZwpQgPo7QVXod785ThGp/TgdrKrIA0HMwXrl/7V9F9wMynsl7MPeDTvKcb7jQk
I8fBkiEJ1yclEu+X0bYqfMuGy2LFikXdMSppgAbU0V9IuYs5VfKqIIiOhwazIkaM
UNTgrNMa4euh7LF0q8eqi5ywIdb0ylAc1U1BFpFBvFpaABnTx5F+N57t5LGc3GaF
AP0/5Jcd
=zW94
-----END PGP SIGNATURE-----

--anMuW3CO9yBBn61r--
