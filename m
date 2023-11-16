Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFC79C54FB9
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 15:44:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44B8987483;
	Thu, 16 Nov 2023 16:44:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DFYeGE3Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80382874C4; Thu, 16 Nov 2023 16:44:24 +0100 (CET)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D35D874C3
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 16:44:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-67572f4b17cso5292706d6.2
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 07:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700149453; x=1700754253; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xwLtAe7bNhzMwcWue/Ui5i2woSJSF0ZiMJqvzYh6L8M=;
 b=DFYeGE3Z2B5Vy5b3vDbfXRO+XMTfspqYSO/3P9WZH3kK8haXHvcg0TIRusQg8gkGJ+
 n8jUA8/cLBx+lFD+pIQSdXPF6PN3mcahVTh+yYOjBXVW+UrtTuJWvxD/87fQ1A+ejxF1
 ZsLRZGsWj9eZcZbbeY+HJUanWC9bkdCtFo1oI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700149453; x=1700754253;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xwLtAe7bNhzMwcWue/Ui5i2woSJSF0ZiMJqvzYh6L8M=;
 b=L/2+e5kPfKFXWdsuK35dBDL1kokF/upL8yGup72VFFHJ5qk595aikI8lSD8Yrx+sxq
 eVpEgNmWGzdz2neUQN6TAei5yvL43AwM4fN+yml3Jo1oL2fQuWGY6j05sfd/cLoRI8+F
 i1oZ+ZtDZUqwUCLaCC1UHHxpWP6wiOMDG7MZRdrg3KfCuEhnY35AjzSxiHdFRYvhtFdh
 uOEpxioXuHZuwE6U97rnUkgZr6dAeUw9JlvPrw0O4gLj1V2KbLxEalPLXJRSRaUj2LWa
 hfAznP0/idlBVNHQcLUXI03x54dnqQ6PQKZWekHmyUCtvlfcbnkayoXPNjVpQG0Be5Eu
 wZ+g==
X-Gm-Message-State: AOJu0Yz7lclejPwafDbbiq4lCafvUdnt0J4mc1hCS98wJwwBkSSQP2Nc
 DeJW9oNjodbZZJq7ABYgC1vxjA==
X-Google-Smtp-Source: AGHT+IEUQDywbPKGEjb6fkVaui8qju0KpCK8wJXL9gYLVgMKy6Sc4BDCqNn1ZwTDj1s1TDaLSIWNBg==
X-Received: by 2002:a05:6214:509e:b0:671:678f:b3db with SMTP id
 kk30-20020a056214509e00b00671678fb3dbmr10470654qvb.63.1700149452714; 
 Thu, 16 Nov 2023 07:44:12 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-6602-bbee-fb68-4a56.res6.spectrum.com.
 [2603:6081:7b00:6400:6602:bbee:fb68:4a56])
 by smtp.gmail.com with ESMTPSA id
 k5-20020a0cd685000000b0066d11743b3esm1450613qvi.34.2023.11.16.07.44.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Nov 2023 07:44:12 -0800 (PST)
Date: Thu, 16 Nov 2023 10:44:09 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: Re: [PATCH v2 11/32] bootm: Reduce arguments to boot_get_kernel()
Message-ID: <20231116154409.GM6601@bill-the-cat>
References: <20231116041043.362055-1-sjg@chromium.org>
 <20231116041043.362055-12-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ezxgSk5MQ9PIfd13"
Content-Disposition: inline
In-Reply-To: <20231116041043.362055-12-sjg@chromium.org>
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


--ezxgSk5MQ9PIfd13
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 09:10:11PM -0700, Simon Glass wrote:

> This function only uses one argument and just needs to know the name of
> the command which called it. Adjust the function to use only what it
> needs. This will make it easier to call from a non-command context.
>=20
> Tidy up the function comment while we are here.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--ezxgSk5MQ9PIfd13
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVWOMkACgkQFHw5/5Y0
tywTlwv9HTk5y2FU1wKiORNpqi/Els4bJ45EcSh868hCdFP3l7nRwnTQXSQuJOg3
3ml8w1+GCRV5cGqRzVKoj1+OxroceRuTeCuQA12NuX3Nts4bmK8dIK/NWIwR73AG
6nQCvTy0zDe8PCv8R9onv3rdHQTU4ooqHjD106aqurJo0QiVJ9TBs6w5ontAYBEA
wydJ6PMH3EwPDH5tqwc5JqzoJia6Qv5lT3N0KD0c8h1l6ktIL74zJvZrfcfSvQAl
PNeek+7eh+w658W53wDpXwjJOCxqsRe7n2mC2tE9bvQgqcFMRLSTKEhd+6tjsOrU
uy60C64kMMuUQvL8LUFwGF8yzKxeYIQ1uhSXicjW98xZqcrGTLHkCeE0hiGSy8vX
eLkF4tgG/+bipyZHxDGgoKgkCWBzdSDblwCV/QrGoLFhBOdfNZT69zB4V3Im3F6D
0Swx40edZAyMKuY19dI2fQbYd4bfhfYFs6eMdns5Zl4BSg7qkbIzIcg4szMgYC4B
YHkgv28l
=HbPS
-----END PGP SIGNATURE-----

--ezxgSk5MQ9PIfd13--
