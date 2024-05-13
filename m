Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07743C25B10
	for <u-boot@archiver.kernel.org>; Mon, 13 May 2024 17:48:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3203B88303;
	Mon, 13 May 2024 19:48:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CBJNSbcS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5E3687C75; Mon, 13 May 2024 19:48:20 +0200 (CEST)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A1B387C69
 for <u-boot@lists.denx.de>; Mon, 13 May 2024 19:48:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-792c031ffdeso356471185a.2
 for <u-boot@lists.denx.de>; Mon, 13 May 2024 10:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715622497; x=1716227297; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=c7lUMJNyyG1zXZK4/N4JA0W3AXk9bFwUZrlJ2cvt5eI=;
 b=CBJNSbcSq5/wDdabydwSPdDPd62coNcmbMdBr30rSGHcdYscx5wX80t2W9xmaF5wzI
 PoP9txQjtS9IE54DJsgE9h+RGEwS1wYOkqx25zyqXvv5ZwHN4+H7uXYu1URjiM/1z3tX
 P1WUfn1aHcDK08ONCKj+e7JOABhOOQwlMQkTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715622497; x=1716227297;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c7lUMJNyyG1zXZK4/N4JA0W3AXk9bFwUZrlJ2cvt5eI=;
 b=Q0KmkHowm2f91K17OLex190Xw4S3rXtJU/mAHCtjd9zJw28/o2zg+amMNuH90auVO1
 W6obt/Yfg5gZbTgucgXz9MD6BH0jQ5NNwn8pUKqmF1GWdhaRw24TgSA/Pylh5BTIumVV
 aGPU/mXBSzEsJ+CDlFPQBZLJle5hweZ1FEafWIPdcU2O3kn+d3qGuDzU+HjxpLfqVl6l
 dDoeQhZ7Hvl35BeExq2zSX9ya6af5N8z7K3d2RgX7liTwsQZfx9HmGAwFLWtYR3W4/JA
 m9UowODUZMgoAxFgLJ1AJ8qSG6ZQbigxIf64CuTa2OB1GtJ1B6t8sgh/0whdRZMGqRzj
 P6rw==
X-Gm-Message-State: AOJu0Yyn7kYx++lmXfFPU0JQPov06Fa7UKdT3WBoKJ+YOnWYa9yTTQbd
 wpGyGXRH3NDr65wJfvwK/KeZAYs9zT8+BMX14qIuEV6ZBddWNwrvuG13LvMvI4E=
X-Google-Smtp-Source: AGHT+IGrmI3ikpjfmj7yUAWl1WsPdEzT51PlrGT04nc6e/9t+WjS2AiFfzLpXSMNiW/8awUFENfGCg==
X-Received: by 2002:a05:6214:4343:b0:6a0:cd28:ffaa with SMTP id
 6a1803df08f44-6a16816031amr160338826d6.25.1715622496851; 
 Mon, 13 May 2024 10:48:16 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6a15f179664sm45374276d6.2.2024.05.13.10.48.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 May 2024 10:48:16 -0700 (PDT)
Date: Mon, 13 May 2024 11:48:13 -0600
From: Tom Rini <trini@konsulko.com>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: Pull request: rpi-2024.07 rc3
Message-ID: <20240513174813.GF2568172@bill-the-cat>
References: <CALeDE9OF_4eTtiPJ+bwsRphD6cGNhTdm_XW1XRyGpgNX1QY=GA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="b28hENS0hW2h6yDY"
Content-Disposition: inline
In-Reply-To: <CALeDE9OF_4eTtiPJ+bwsRphD6cGNhTdm_XW1XRyGpgNX1QY=GA@mail.gmail.com>
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


--b28hENS0hW2h6yDY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 08:48:00AM +0100, Peter Robinson wrote:

> Hi Tom,
>=20
> Please pull the updates for the Raspberry Pi:
>=20
> Updates for RPi for 2024.07:
> - Switch to OF_HAS_PRIOR_STAGE by default
>=20
> The following changes since commit 52835266d3e933656a217233eaf672dd9ccd73=
52:
>=20
>   Prepare v2024.07-rc2 (2024-05-06 13:54:17 -0600)
>=20
> are available in the Git repository at:
>=20
> https://source.denx.de/u-boot/custodians/u-boot-raspberrypi.git
> tags/rpi-2024.07-rc3

Applied to u-boot/master, thanks!

--=20
Tom

--b28hENS0hW2h6yDY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZCUloACgkQFHw5/5Y0
tyxSigv/Tl3jZliQ21fBEPA/BLdl4TcKFcfiqkY10nMnQvScDMhXKE/yhFN+bmlh
iORolRSovSPV8O9nK6xydnOILNPGGyZn1RNLwXaTvT6TopWe6raCWR5eKOONd6Tj
vDkNAkrcKXRnP/iLD4Pb+j1C3y6LRE8exCmuyvqQJOhMvuv7fBectAFhc2M6UW4c
5+zdPGKWEglK0f+3JvocvuaE2h1I+1pKwOVspuvxWuXHVpxjqKMpeOWO0gqF1SJ9
tRFAyDAUfzwkDtq7UU/4TIYheVNxEegVJuUWyj1AJhUQaRV5q55ohryrAtRuaaFN
8CVOuu3NGrD0JRR7UEbtFSpx1l3pd5lIb2QbU01C5xCEg/lKUBYJwzgEWDXPxdDD
zB4QzUi02cWpSqKSWIXwXztB7SoSyyP02VNH2NID76Qb9N6EJnxltxrDCb9k1jYH
StABY8MrghsUSk/ooWOezhLPre8xuxOU1LV5Ru4PT/X2Go9zbH+2rVh7tK+DCC1X
Xi+h9hve
=DI93
-----END PGP SIGNATURE-----

--b28hENS0hW2h6yDY--
