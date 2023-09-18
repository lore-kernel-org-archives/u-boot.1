Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53067C46CA1
	for <u-boot@archiver.kernel.org>; Mon, 18 Sep 2023 14:12:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2A1F86986;
	Mon, 18 Sep 2023 16:12:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Pcu5xG/0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 549BE86936; Mon, 18 Sep 2023 16:12:48 +0200 (CEST)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E21686993
 for <u-boot@lists.denx.de>; Mon, 18 Sep 2023 16:12:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-59bc956b029so43694837b3.2
 for <u-boot@lists.denx.de>; Mon, 18 Sep 2023 07:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1695046362; x=1695651162; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Z9+y6VCeIc08eDbS1nK8rqPzVFXlXOLNn+enfW7Sfso=;
 b=Pcu5xG/03v4gI53xUoj0TYYwAcqfUhVSScRGyEoy2/ITMhzRxtzxk3w6aGpO6ZiO9u
 Znqz+Cps1PBzOSDfqnQUg1e6wnBWl04DaS/C142j9F8GGI0alyV+NltbYheVCg4SzXQk
 8E1Qd98UnH1eW/VnaGh++5HV37kjcrRKdmKTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695046362; x=1695651162;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z9+y6VCeIc08eDbS1nK8rqPzVFXlXOLNn+enfW7Sfso=;
 b=VOIThWFZXGsvu9IPI9LbbdTE+qQsMyYBCDTVZxY+o8rUkQgGYvAgR/0mEfAJVL2awz
 f+SLZnmRAGqiuN97Ky0PE8vEdF5S4j3qh2JsLbJr/WLA4YB6nES0pWiSoV6GvMbH6fwo
 OI46eW1uFbpLxeBeANbxRD9CmtdH6hfkYm/L2c0hMS7JG+f1WEd6BlNkEKnzpnb0F3Su
 NpHzWRf5lQ2JEJwcYkexYoWI9xVGqZblNxqt3WaH8lMPlGzDpe2NklgodQhN57lJT24F
 O1FXAM5sTAPHw7jg8JUvEQ5CcbqLulHs2LkjNfFqtoTmYRVoKe+6Ig7D/GKShAwdAlIO
 IQug==
X-Gm-Message-State: AOJu0Yx0Rul2E7ldmeUr38qlHc3KaYdXJ8lvK7dE/n580JkW3vcuw28C
 kAa+FjcPDl4MumHWsMSheFHIfQ==
X-Google-Smtp-Source: AGHT+IFttu8Srn+Kmo+rDg6r7Gaic3sgUJqzPVJoJbukggvaYB/FYCSB4jnDt2xe4nX5P9+Z90+fwQ==
X-Received: by 2002:a0d:ea45:0:b0:584:6239:8f36 with SMTP id
 t66-20020a0dea45000000b0058462398f36mr9211782ywe.14.1695046362376; 
 Mon, 18 Sep 2023 07:12:42 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-fccb-cc62-ada8-13e0.res6.spectrum.com.
 [2603:6081:7b00:6400:fccb:cc62:ada8:13e0])
 by smtp.gmail.com with ESMTPSA id
 m17-20020a819c11000000b005707fb5110bsm2561606ywa.58.2023.09.18.07.12.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Sep 2023 07:12:41 -0700 (PDT)
Date: Mon, 18 Sep 2023 10:12:39 -0400
From: Tom Rini <trini@konsulko.com>
To: Jesse Taube <mr.bossman075@gmail.com>
Cc: u-boot@lists.denx.de,
 Giulio Benetti <giulio.benetti@benettiengineering.com>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v1] configs: imxrt1050-evk: enable distro bootcmd
Message-ID: <20230918141239.GK305624@bill-the-cat>
References: <20230918034734.322676-1-Mr.Bossman075@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XYm7oh0HTwS0VyVc"
Content-Disposition: inline
In-Reply-To: <20230918034734.322676-1-Mr.Bossman075@gmail.com>
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


--XYm7oh0HTwS0VyVc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 17, 2023 at 11:47:34PM -0400, Jesse Taube wrote:

> Add support to boot from script.scr from mmc.
>=20
> imxrt1050-evk was not able to boot from script.scr because we did not
> include config_distro_bootcmd.h and set the device to mmc.
>=20
> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>

A few things.  In general, we should be switching to standard boot
instead of the script-based distro_bootcmd.  Second:

> +/* Config distro_bootcmd */
> +#ifndef CONFIG_SPL_BUILD
> +#define BOOT_TARGET_DEVICES(func) \
> +	func(MMC, mmc, 0)
> +#include <config_distro_bootcmd.h>
> +#endif

It's not allowed to use checks for CONFIG_SPL_BUILD like this.

--=20
Tom

--XYm7oh0HTwS0VyVc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUIWtEACgkQFHw5/5Y0
tywWIAv+OmziJ/GQ8wXxtz6ut/FxVn6wQwcE1asKU2+TxBSSvUGPzLAvBUX5t3YQ
Wls9yMDVgO4gvQVW8BH1sYKvG+deOgEdIvXiTr8mdsDkXwUZcyUM8kB9laao6DdD
5wrHlV4jEF5dIbUpTiR/cR18u8wnWl2E7G7pwjuAMf2uyQW71kpV/iGK/kQdzT6q
dfI0eptGVXGEujVfr+pCCeL5Qf9XMXoTRbzaL3GYmv6HsEQfHS4FJFFB7cUHijBh
oSJAwaQBNBWpcPdlabjqE0YIWff45kFrKoyqSYBhIY4cYlI6hMgSLsdPqyVIyF6y
szz7XK68jzs8F65MuecafQyTDZ6BycRSJH8Y9US7U2vDsAKd6Ei1kJ78JwJ2h66x
93oUuSLibB3zLvDjC6ZfMVSOBHh8z0snU9ZCMsI+HQKed0pfRoLWatqO8eDNCMKj
LBTHmUbDfkHBUun0eH/yGp16AvfE/ruDiZktscsEgBNhbZZgFpMOuLIMHSsKmiYx
G0vBOWGb
=AFek
-----END PGP SIGNATURE-----

--XYm7oh0HTwS0VyVc--
