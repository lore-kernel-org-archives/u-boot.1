Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C40CC41535
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 17:13:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4A138773E;
	Sat, 16 Dec 2023 18:13:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iam2Kn2Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29C8B8773F; Sat, 16 Dec 2023 18:13:29 +0100 (CET)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23FBD8773D
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 18:13:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-67f2d3ebe2eso3521086d6.0
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 09:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702746806; x=1703351606; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=MBgKyJZ3WIQHE9kq8hWbt6spGQw/zanWqq/f3XS4VyY=;
 b=iam2Kn2YTufq0IIxZjRj56UiolKjdMurqE76IkjACCTGu42Oj7rGMzN3t+am3wOlm/
 mjzWlEAEojOVYYF+FEkLjzdUH9+4ctRT1fYGjNKcIiUGxX25DPvMgmilK6F1KezcawAK
 f7jOCej6Kz1s/2pJBMAp/nmJ8mgJ2LkFNaAiw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702746806; x=1703351606;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MBgKyJZ3WIQHE9kq8hWbt6spGQw/zanWqq/f3XS4VyY=;
 b=gtUMkMaTEbjvFInAql5MeEUCIzVQNIAHjd32/UHJE0ftrLDFp8p2HiteVH/qnPoW8x
 bnnLothu0KEccP02A63112u7T7T1FjVgS4fbVEMumgPNBNGRRt9r7yFluQN3oBFRCtfs
 LVLJpLk+K7sxiun/UkY9VGwp3vltY/WtCLH8tlMEjRgXLCa3NS+hNtbZcAQsUELfXpC5
 kdDdxsbz3Z4Uop7QhDhkQF1RDPovFQXt0kHwU9x3+n/jvRnRZHYX+Pwc2z9P+TfyCxEM
 27ixJ/aG5YdV1hdtk2EddFxDoLqnQ2cdEcstKPao+Bqcl3BUKFqeSFWnLUYr899h47EC
 t6Ow==
X-Gm-Message-State: AOJu0YwRXMPFFAileejQFOqivuybOww8xBr1hRMACh+eSWsyrU8Xbwz+
 HxYocmTqaIdCKjuNV5RCfHxjiQ==
X-Google-Smtp-Source: AGHT+IFQ/l4MTkR2tHYzp6CW85bRU0SWeHYZtPAt2ZfWMWTTpU+ws8DvZjmvDTXT65E2jy4ynCnZLg==
X-Received: by 2002:a05:6214:1d04:b0:67f:1f05:af07 with SMTP id
 e4-20020a0562141d0400b0067f1f05af07mr4637193qvd.86.1702746806024; 
 Sat, 16 Dec 2023 09:13:26 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-4efc-63ef-4955-a8ab.res6.spectrum.com.
 [2603:6081:7b00:6400:4efc:63ef:4955:a8ab])
 by smtp.gmail.com with ESMTPSA id
 dl6-20020ad44e06000000b0067f2cf4b8e0sm388167qvb.73.2023.12.16.09.13.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Dec 2023 09:13:25 -0800 (PST)
Date: Sat, 16 Dec 2023 12:13:23 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Eddie James <eajames@linux.ibm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: Re: [PATCH v3 21/22] bootm: Create a function to run through the
 booti states
Message-ID: <20231216171323.GV2513409@bill-the-cat>
References: <20231216031446.2222362-1-sjg@chromium.org>
 <20231215201413.v3.21.I95fe77f4a7f3d6c3dba3ecb3aec30a48739198f9@changeid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FsaTVmHPj7KC3JcA"
Content-Disposition: inline
In-Reply-To: <20231215201413.v3.21.I95fe77f4a7f3d6c3dba3ecb3aec30a48739198f9@changeid>
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


--FsaTVmHPj7KC3JcA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 08:14:25PM -0700, Simon Glass wrote:

> In a few places, the booti command is used to handle a boot. We want
> these to be done without needing CONFIG_CMDLINE, so add a new
> booti_run() function to handle this.
>=20
> So far this is not used.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--FsaTVmHPj7KC3JcA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV92rMACgkQFHw5/5Y0
tyxsegv/b0SjqS1rozaYZvw/7od4bFzRqI6T8kws4yDnqteTpvewXQsXfd3p2ZlS
C2+S+zcrHREce6m6orZMhm2GQw98eReS3l4FTVpjn5hxVQnEsKVXeCc2ytF+N15P
DYrFAr4idGYXHkWUQDY0d02f6Ajp/CTb7Ciy4sAZH2YXmgmWUfiKYLUGAsOVYQUI
NOr4y8zwvWhoLweLu3kpSj/KAVJSvlYAT6Nt15kb6HnVxoVsrELXRsA8LvIui2w6
O7nmKiqtfuc7J1wyOB1cmUg3zFmjCRcLCNM+MYuKE75ASD1sNnB5wbAtWQg4pcua
oUd5OGmCDrjrb5Wilb2EEsd6T7623b5GEFQNR+3HPmOZVsQGhNR2SUIdXv8YWwpN
A7jLIU635nOyCh2aXHuq6yW/mYpWMBHCqAYTuQmryX9qmey+B6SgGKaowk6C13Cm
M/iqqvlcJaw/bJJltWQRECOT92WLD2R8mcZ9SFpc3DzgK1eHV1QgXjanVw2UDwf0
0RSeK6pH
=r4RZ
-----END PGP SIGNATURE-----

--FsaTVmHPj7KC3JcA--
