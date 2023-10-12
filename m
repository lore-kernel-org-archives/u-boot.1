Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F885CDB474
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 21:56:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC51E86EB9;
	Thu, 12 Oct 2023 23:49:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="niXh9L0E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E7F686E7E; Thu, 12 Oct 2023 23:24:29 +0200 (CEST)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA3C986E4F
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 23:24:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-5a7bbcc099fso18458587b3.3
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 14:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697145615; x=1697750415; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+HSJRj3rSfQmGqAZn6b8P1ngG3XmX/c+wO+yGeEKDoA=;
 b=niXh9L0Ea9Lpw4/A9SnZDgqGjNQ/7q3Yq0FCOyCJ4sqvUCqX15uMPQdXsNz8+w2uui
 MfT3hWGzDGyjps/XpxPtPxdsjPhGWbnT2YuVROOU8MeTl4mZaCd9tKF2oVT7RAZoovdZ
 b/2/JF6ckTG8VBrDp0+uaKFjPiZEyt5RA1RzE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697145615; x=1697750415;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+HSJRj3rSfQmGqAZn6b8P1ngG3XmX/c+wO+yGeEKDoA=;
 b=Ssl4TVVZZXm4NV26TrsXtRqeQoVR4QnZft/1xbCw9NqFcwKVeTRxUICv/FdjbQohwS
 EuZerPhL+4NP5eegPQL3g79eVYY+yS1kknVSWyGJ0Fz8gEhzSnyRJsneHw1/QslSevQR
 iGxkESEYUjoi+mLaDqtYqCMYDILKF3BgwdMAavaKzOqTO7KD61Bg0WHw5NoWtqNTdApR
 w+gpFGUHR53XddC0Jf7xDqSen36svco2ooUtOQgDUrI/GBcl+jsYHKHty1dp+8oBiLJP
 y+c3Cb+bQ5Tf5TGXunhmr43U6Px7lTEmoN+r4AE1Yb6IeQ6uPugYcdm5EvJvdHFiOU5S
 Hcig==
X-Gm-Message-State: AOJu0Yz9t0gh8mqW/UOdHH0QgoroAGgld0TwW1DfpJExhIu1rtZiaJwI
 ITSWkxKWewVrLStZVwKP8fBjI9hdZzd5q7Ja477Y/g==
X-Google-Smtp-Source: AGHT+IEqspgMiUI6O/KjkwNuiRNwP2uyfSrG0sbRRXY7Pac+m0xRzpjmPcX0qOjZYRA+DqT5jvPxnw==
X-Received: by 2002:a81:6902:0:b0:59f:4dcd:227e with SMTP id
 e2-20020a816902000000b0059f4dcd227emr25865340ywc.37.1697144662796; 
 Thu, 12 Oct 2023 14:04:22 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-5647-4a14-f04e-8d8d.res6.spectrum.com.
 [2603:6081:7b00:6400:5647:4a14:f04e:8d8d])
 by smtp.gmail.com with ESMTPSA id
 w4-20020a0ded04000000b005a42740fcd4sm217365ywe.94.2023.10.12.14.04.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Oct 2023 14:04:22 -0700 (PDT)
Date: Thu, 12 Oct 2023 17:04:20 -0400
From: Tom Rini <trini@konsulko.com>
To: Manorit Chawdhry <m-chawdhry@ti.com>
Cc: u-boot@lists.denx.de, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Udit Kumar <u-kumar1@ti.com>, Reid Tonking <reidt@ti.com>,
 Apurva Nandan <a-nandan@ti.com>, Andrew Davis <afd@ti.com>
Subject: Re: [PATCH v7 4/7] arm: dts: k3-j721s2: Sync from Linux tag v6.6-rc1
Message-ID: <20231012210420.GD3119521@bill-the-cat>
References: <20231006-b4-upstream-j721s2-r5-pinmux-v7-0-5d31f765dd2c@ti.com>
 <20231006-b4-upstream-j721s2-r5-pinmux-v7-4-5d31f765dd2c@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/nDFHZRcbCExpEIR"
Content-Disposition: inline
In-Reply-To: <20231006-b4-upstream-j721s2-r5-pinmux-v7-4-5d31f765dd2c@ti.com>
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


--/nDFHZRcbCExpEIR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 06, 2023 at 10:15:58AM +0530, Manorit Chawdhry wrote:

> The following commit syncs the device tree from Linux tag
> v6.6-rc1 to U-boot and fixes the following to be compatible with
> the future syncs -
>=20
> - Include k3-j721s2-common-proc-board.dts file
>=20
>     Remove the duplicated pinmuxes from r5 and -u-boot.dtsi files and
>     include k3-j721s2-common-proc-board.dts for Linux fixes to propagate
>     to U-boot.
>=20
> - Fixing the mcu_timer0
>=20
>     Remove timer0 and use the mcu_timer0 defined in mcu-wakeup.dtsi
>=20
> - Fixing secure proxy nodes
>=20
>     Linux DT now have these nodes defined so remove them and rename to
>     use the Linux DT ones.
>=20
> - Remove cpsw node
>=20
>     The compatible is now fixed and the node is not required in
>     -u-boot specifically
>=20
> - Remove aliases and chosen node
>=20
>     Use these from Linux and don't override when not required.
>=20
> - Remove /delete-property/ from sdhci nodes
>=20
>     We have the necessary clock and dev data so remove these.
>=20
> - Remove dummy_clocks and fs_loader0
>=20
>     These weren't being used anywhere so remove it.
>=20
> - Remove mcu_ringacc override
>=20
> All these have been put in a single commit to not break the
> bisectability.
>=20
> Reviewed-by: Neha Malcom Francis <n-francis@ti.com>
> Reviewed-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>

Applied to u-boot/master, thanks!

--=20
Tom

--/nDFHZRcbCExpEIR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUoX1QACgkQFHw5/5Y0
tywVEQwAolv3haLUGXgpNrE6dpSNgq7zwe83ANhLzZWT4kFK8HxD+Q6ZaZrSy0Qr
yJozeQOwVN05sg/g85ml1Ys1vkPjjEODjxRQ7TXIBCj2pDpivEMM3ly7l+OkFlNe
4/CbsIzJdKNQb60QCR+hyEvYPv6WyD586NHa8xqZjNpYvDUKkOQ5A5FXveg1+7+S
Y/QU4m0rl3n4n052eZQjmZm0IcWZ0hq/2TkobVJP2Ful7qHc4ksDxKXVYuKN1E0n
ampGncq92wdNbVkTYd95Ke99rQJ04XQqRIL5MMc6sNIB3NXgX+4gyd4hEM4wuirv
xkWKEmRua02reu2Q+VbTdr0glmPYEeeSIAaVqw/Rw7YyyqOAV2cKClPX1daYQlTB
WNVG88ynfhFbAtS6RbGF+RUZX4+rTpWeNz7foZ0N9NncPH9bH3Zd7gmgJ8wqfZcY
axlGY8XMCmYGVQGbw5y5CcfwnIdxHWlx/o8F1HBySqf6i848Mfmdr8pJkkrVPpOB
mlGAPjx6
=cnO4
-----END PGP SIGNATURE-----

--/nDFHZRcbCExpEIR--
