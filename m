Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22207C3DA6F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 21:58:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3ED3686926;
	Thu, 24 Aug 2023 23:58:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CL8Ro5/n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8DA386977; Thu, 24 Aug 2023 23:58:31 +0200 (CEST)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21B94865FB
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 23:58:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-d77f869dccfso313251276.3
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 14:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692914308; x=1693519108;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DD7J6PEne+EPp0f410wSo8Ac9sd+io0a+hYK6tAFOVY=;
 b=CL8Ro5/nCtQrqHGc4nCIzxAAzgBtGHkoTftgdjQGUTvJW/gJaEBBBIam8OWTKj1suH
 5AWuiu73p9x4eMnR2LuDY98H2jOBQ5excpKAC+ZzEhiJh63svH0q94OkNnu8cer2qLJV
 cRCoxT7u+9aw19TmLdzbzCdu7VkrpibPLklog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692914308; x=1693519108;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DD7J6PEne+EPp0f410wSo8Ac9sd+io0a+hYK6tAFOVY=;
 b=FuFu4quQ2lUeZiVbwx3h17KYviJE/TANCjnvLUMo08xY7d86fwus/qZQNHo1HgNDoV
 Oyxo0wVrki4WkIdMPmBSQTEfGZAGSJDEmku1nBVdTEY91r+4CDPvfZrJ+XpCL/iwFvNv
 TMTkdCyz0LK7K4G1nj/Ay0mqRIdy2tSJuAGPeyHhd/433D6fIq0Bd2k4vLzxUlIHOHzH
 zmcBBjO/XVoPLaEDZHrARvc6KG49lXXQPnuyuGIjktvNc+hJo+v7U75UKILEbPQfkYAV
 IBwN7SMcrr52B1q8mH0H//lMZj32mntCvUhlklRW5boTsSymw5YPbuTN2gHyp+/CL8qG
 l1rg==
X-Gm-Message-State: AOJu0YzeU0LQltt2gXobzTse3ySnalVU0FakCYyuS2BDZEf/ywkyooEm
 Gb711JHMrNI8BXkn8UKwZLlsvw==
X-Google-Smtp-Source: AGHT+IHiK90oaRw82ULlNyegE+Lwii5SEELGPBt2IkWTtn3Km/km2EaFIuugaao23FRU1VtJvxFpTQ==
X-Received: by 2002:a25:bf90:0:b0:d78:23ee:8a4f with SMTP id
 l16-20020a25bf90000000b00d7823ee8a4fmr1500014ybk.34.1692914307823; 
 Thu, 24 Aug 2023 14:58:27 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-37ed-1199-bcc5-406f.res6.spectrum.com.
 [2603:6081:7b00:6400:37ed:1199:bcc5:406f])
 by smtp.gmail.com with ESMTPSA id
 v3-20020a25fc03000000b00d728a2738f1sm77720ybd.61.2023.08.24.14.58.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 14:58:27 -0700 (PDT)
Date: Thu, 24 Aug 2023 17:58:25 -0400
From: Tom Rini <trini@konsulko.com>
To: Jan Kiszka <jan.kiszka@web.de>
Cc: Nishanth Menon <nm@ti.com>, Neha Francis <n-francis@ti.com>,
 Simon Glass <sjg@google.com>, Bryan <bb@ti.com>,
 Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: Re: [PATCH] board: ti: am62x: beagleplay: Disable semi-functional
 PSCI reset support
Message-ID: <20230824215825.GF3953269@bill-the-cat>
References: <20230824031101.3460411-1-nm@ti.com>
 <20230824031101.3460411-17-nm@ti.com>
 <c93b19ed-43fe-44a2-9726-371fb9d2f825@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="j5oxwbn85g/To6w5"
Content-Disposition: inline
In-Reply-To: <c93b19ed-43fe-44a2-9726-371fb9d2f825@web.de>
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


--j5oxwbn85g/To6w5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 24, 2023 at 11:53:17PM +0200, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
>=20
> At this point, system shutdown is not supported by the DM firmware that
> TF-A calls. As we can't de-select only this feature, declare complete
> PSCI reset support as non-functional so that we don't signal incomplete
> support to the OS via EFI runtime services. This makes power-off under
> Linux work again when booting via EFI.
>=20
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  board/ti/am62x/beagleplay_a53.config | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/board/ti/am62x/beagleplay_a53.config b/board/ti/am62x/beagle=
play_a53.config
> index 967f794446d..8b0f671bc9e 100644
> --- a/board/ti/am62x/beagleplay_a53.config
> +++ b/board/ti/am62x/beagleplay_a53.config
> @@ -53,3 +53,5 @@ CONFIG_SPI=3Dn
>  CONFIG_SPI_FLASH=3Dn
>  CONFIG_SPL_DM_SPI_FLASH=3Dn
>  CONFIG_SPL_SPI_FLASH_SUPPORT=3Dn
> +# DM firmware lacks support for shutdown
> +# CONFIG_PSCI_RESET is not set

Is this lack of feature for just the beagleplay part of the firmware
stack or more generically to the TI am62x platforms?

--=20
Tom

--j5oxwbn85g/To6w5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTn0n0ACgkQFHw5/5Y0
tywHrAv+MAYg4drAAE3yAwK7UayarLVcO7bJPXHqQTxYLukZyOWYdmFL6Bu6RbeP
jxZUtq8ttCN3HpwWTGOxQRyeMuPCoG0041vPBjWQlhZj4e9FwUM1ecwW5NW+FN4f
5lLTg3ynbKl0fKelaMibIaaDU4biL5umjKhuKNygtQWuAnDjSa89sIhuDd1yGb9r
0NrXVVCdv7FIi/EIo73ZiQ6Yk0LOs3G/SH5DklKuG6+iwyyHABMmnUkQWkL75NPF
TRpugaLZOzv/TPQMZrFcxOU9kTaTVJ5tTPupIfbuUnAJSy+REGBE1abaUGDNS6+z
Rh5NT4lXt+oBaGLOvYiqCSBmpDpSiAvynexmqqa/Af/NYZF6+DVhnj62H36htm+7
RssvgNUfgHdIyGipgmvRzVnDld5pNzgoBX3CU5x9aU0xbu7WzJTQQZL9SRtfjDgW
Wm29q/SmyozE1uoM9foNOE5o7yqUGKGcb/Q+AQy9FSukmVp5tmXJGYAycDTW03cd
xpt3G0Gu
=81qH
-----END PGP SIGNATURE-----

--j5oxwbn85g/To6w5--
