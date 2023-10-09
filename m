Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8BBAE95A91
	for <u-boot@archiver.kernel.org>; Mon,  9 Oct 2023 14:36:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3828C86B7E;
	Mon,  9 Oct 2023 16:36:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="r2Q5YXwR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27E5E86C00; Mon,  9 Oct 2023 16:36:08 +0200 (CEST)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 210E586B7E
 for <u-boot@lists.denx.de>; Mon,  9 Oct 2023 16:36:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-5a7af52ee31so2812317b3.2
 for <u-boot@lists.denx.de>; Mon, 09 Oct 2023 07:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1696862165; x=1697466965; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NFTSvH6G0LQDbntNDGFbdj+gfXm55XUf3Vpw5MwnQZw=;
 b=r2Q5YXwRQRFFpeyLRT8QVYw0EV0DnDCTiBJXr3JoX43KH6fOU7LkbLn522XPylTXjB
 U8D/uDl84yKYvqhKrOqH2WItD3Y9WY8f0vZvIjwADVC/RqdzuFtNNue4CziZhNU3Cr9D
 UpDnvQeMPEpl9/I8QwZ5Z9hfNmX3HBuHOkXgQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696862165; x=1697466965;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NFTSvH6G0LQDbntNDGFbdj+gfXm55XUf3Vpw5MwnQZw=;
 b=fXPzFHRfC6Vji0fju7WkkYQazpBNrFkM5chzZWuIA/gdXnBy0i/+rqy4MWXU283W4G
 9yXi9ALR9xc2jIyvMQ3aDG56cKIMU+PO7s27e1szNaITw+EBqfaAC3x9D3Nz0Xik0uP3
 Jg+nr0Ak7GzIL1jkhyu+/Yfo2za4OhPYnTQk6VobU4iqSQXntC4Qr9X3z2SPoFQ13wtQ
 c0XzR90dM3HqD9oFQXJtaZ3mVrD3r8YaP5esQFS8FvKWhGf0g1m3/b/sEz3mKZFE2CXU
 HHw38b2eFQCTwS1WH4lwPTE+fdttFkzBronqOLW9qZsQTrjbGFv8EJkp40v+T/zyC5CN
 Q/uw==
X-Gm-Message-State: AOJu0YyKEQkAF+/o98yoHaO1JAoathJ8VH0emvmnsL2mpI2bYsZRKzec
 ofVjtEMQNmobEVfeLQpNhmkh4FNn5uIProaULKyl1g==
X-Google-Smtp-Source: AGHT+IFKUev4idX+w0hlJjBhAcTdgEQcOzMeuyvZ+AvMzPLgfk08xA5nrZa8giDgfyRS8c3lxYAJjQ==
X-Received: by 2002:a81:65d6:0:b0:59b:dbb7:5c74 with SMTP id
 z205-20020a8165d6000000b0059bdbb75c74mr15410230ywb.32.1696862164757; 
 Mon, 09 Oct 2023 07:36:04 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-fae2-bb7a-3833-e7d0.res6.spectrum.com.
 [2603:6081:7b00:6400:fae2:bb7a:3833:e7d0])
 by smtp.gmail.com with ESMTPSA id
 q65-20020a0de744000000b0059bdac3fd08sm3744805ywe.48.2023.10.09.07.36.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Oct 2023 07:36:04 -0700 (PDT)
Date: Mon, 9 Oct 2023 10:36:02 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 06/27] cmd: Add a few more dependencies on CMDLINE
Message-ID: <20231009143602.GL2227687@bill-the-cat>
References: <20231007231255.277623-1-sjg@chromium.org>
 <20231007231255.277623-7-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wPjn6dnbZupznlpb"
Content-Disposition: inline
In-Reply-To: <20231007231255.277623-7-sjg@chromium.org>
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


--wPjn6dnbZupznlpb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 07, 2023 at 05:12:25PM -0600, Simon Glass wrote:
> Add this to some more commands to avoid build errors with sandbox.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
> (no changes since v1)
>=20
>  cmd/Kconfig | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 6470b138d2f8..f914da6fe1ac 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -224,6 +224,7 @@ menu "Boot commands"
> =20
>  config CMD_BOOTD
>  	bool "bootd"
> +	depends on CMDLINE
>  	default y
>  	help
>  	  Run the command stored in the environment "bootcmd", i.e.

This is the wrong direction.  cmd/Kconfig needs to be re-organized to
have a menu for the hush options, and then all of the commands should
bee under a main commands menu that depends on CMDLINE.

--=20
Tom

--wPjn6dnbZupznlpb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUkD9IACgkQFHw5/5Y0
tywr2Qv/U0panUW43aF/njnCBKcIthKnQtbETQA43uyyRrIfl6AczKOqKOJ/l2Y3
TvP/T9nA3T3GepuNEGt2Uxev2TG5Y93LDwY4cSoCEeUKiGs9aic25Y0atOnZfDft
8W+/KhgW2EQmkNjPMIHzW6/CquOFRojLxZgSYHHHPcqGp94FhPm3KXdsHvtGnZuj
jIAp2VYmqiM3blm19FNCBxw35pQbN7dM9f6sqVQylSfwM1mPOQIif9cYz8Gmt/Y0
xXQsO7tUU/vlk64QV2ZTJZjlFY6vzj+pXmM7UzDfIZ14oijkrkLP7NwmgFEVDK1+
HoHo8/DK+6BTk+k8fRyRhnf6wmJ0hkGx1W5KRgiwHQOTIW07x51Mp9MPrtH6h7Tb
AOvNvZVgEhVuIGM0MhU4/Ias4TtNgZx6MX78bpTrk5x8QVgjn25nsTM8t+ZZ9sPg
2bzAJ675YCl/8XrscigD09IKGrVKwyH9Qsph7tmZLHGuCbco35ro5WEndjoCN4d3
lmcX3YVW
=zwPX
-----END PGP SIGNATURE-----

--wPjn6dnbZupznlpb--
