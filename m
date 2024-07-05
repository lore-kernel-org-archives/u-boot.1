Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60926C3271E
	for <u-boot@archiver.kernel.org>; Fri,  5 Jul 2024 15:38:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 631CD889A4;
	Fri,  5 Jul 2024 17:38:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="m9MM6oix";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59402889AD; Fri,  5 Jul 2024 17:38:03 +0200 (CEST)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A1EA889C0
 for <u-boot@lists.denx.de>; Fri,  5 Jul 2024 17:38:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-5c46dcf9f0eso973624eaf.1
 for <u-boot@lists.denx.de>; Fri, 05 Jul 2024 08:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1720193880; x=1720798680; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+Yx771Ft5VX7PtkgeD7bdmHbncsp4sgikLzHrRvtXKo=;
 b=m9MM6oixQiJPoUBnJnZjjbRBPD22Lbaa6ql6TBUVYOvFsrUD6G4+NfgOFXBsQCJt11
 Psu/AhmXUbEbIucDUNGu48McK3sl+moe2PoXpZJzTxqDGuG01rJLk4a+8Nm2+fevSWVJ
 HERaKh48oRvAwM7PCBpVnMJSMR0BxAFrMsdJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720193880; x=1720798680;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+Yx771Ft5VX7PtkgeD7bdmHbncsp4sgikLzHrRvtXKo=;
 b=qftoGnBtEvjKzwrpHo+tAoPN7UbWpuHCuKulrquau5pgvaztSjWWln0lUw4KHO6ufE
 pGNEs0D5F1A+0XMuQb5f0JRkc+UOZpXv/eDW4REXsCf1n1KvVAqjqM0kO8pHXF7BUEqr
 RPrvjdfMxyKmJ3luoAEmvXo/yhK31xcE0euF1TZnMWs0vCdcCcli3l6/DLkaupYuwx16
 VbdiuR+YcZAforUXphmPM5EMHSIVvx2ikODmV4aguzGlbstNUP3o5y3Pnym9yS3A32Sg
 W7GdAMlYBldCXrZBD0L6VW0sgHXlcIf1fU4bydVCCiiO9iKxV30TfWTBv9zIAbfTqKnX
 VTmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2ao7Vn3+i3KgZ4arRd/3kg48G1ax6kTZsaBJagdn+jnJn7ywEL3U58SmOVaxnSOrc8hYufIX6OYilSLonw3/V3paeEw==
X-Gm-Message-State: AOJu0YyeCzowwMr5llaEaSenhaZm/770Ky9qBN06YSdBXD87SfrauCR/
 JvsBopfbOiJnWq6xKkkwWmdxlp2J1/kILSnXgi6mocbwgtCHqKDvPR2l0OFoRq4=
X-Google-Smtp-Source: AGHT+IF7zHJZAO3X64yxRH8cuE3MzsD3GEto58e0heIU/6tRRoBxEXtMu02aYAVX9mknIi63dd235Q==
X-Received: by 2002:a4a:5a83:0:b0:5c4:2eef:262a with SMTP id
 006d021491bc7-5c646f46dbcmr1458293eaf.4.1720193878988; 
 Fri, 05 Jul 2024 08:37:58 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-45.totalplay.net.
 [189.203.97.45]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5c4543b9aeesm1222365eaf.19.2024.07.05.08.37.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 08:37:58 -0700 (PDT)
Date: Fri, 5 Jul 2024 09:37:55 -0600
From: Tom Rini <trini@konsulko.com>
To: Chintan Vankar <c-vankar@ti.com>
Cc: Michal Simek <michal.simek@amd.com>, Bryan Brattlof <bb@ti.com>,
 Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
 Vignesh Raghavendra <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
 MD Danish Anwar <danishanwar@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Andreas Dannenberg <dannenberg@ti.com>,
 Jonas Karlman <jonas@kwiboo.se>, Devarsh Thakkar <devarsht@ti.com>,
 Sean Anderson <seanga2@gmail.com>, Kishon Vijay Abraham I <kishon@ti.com>,
 Nikhil M Jain <n-jain1@ti.com>,
 Joao Paulo Goncalves <joao.goncalves@toradex.com>,
 Wadim Egorov <w.egorov@phytec.de>, Sjoerd Simons <sjoerd@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Dhruva Gole <d-gole@ti.com>,
 Simon Glass <sjg@chromium.org>, Roger Quadros <rogerq@kernel.org>,
 Maxime Ripard <mripard@kernel.org>, Nishanth Menon <nm@ti.com>,
 srk@ti.com, u-boot@lists.denx.de
Subject: Re: [PATCH v3 01/10] common: spl: spl: Init DRAM size in R5/A53 SPL
Message-ID: <20240705153755.GH38804@bill-the-cat>
References: <20240705045030.1141934-1-c-vankar@ti.com>
 <20240705045030.1141934-2-c-vankar@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="L3ypCD+4CbOcgOx0"
Content-Disposition: inline
In-Reply-To: <20240705045030.1141934-2-c-vankar@ti.com>
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


--L3ypCD+4CbOcgOx0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 05, 2024 at 10:20:21AM +0530, Chintan Vankar wrote:

> Initialize DRAM size in SPL stage since networking requires DDR
> to be initialized.
>=20
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Signed-off-by: Chintan Vankar <c-vankar@ti.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--L3ypCD+4CbOcgOx0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaIE1MACgkQFHw5/5Y0
tywB3Av+MDHlFR6NiSrsrTLgR4oQaFfAC6WFQJ1/qyVXdcdwHYESeSoB/f5MnydB
Qa4TswWsYNE0KPJGF8J3L02WjCzbDQuI0f6vhr9aZg7h9aUfEdeHHyqi2608P/5Z
uLoZgZzEzAJngFUQvYriNBQz1QYbnYFgvdLcyhHK6nypcks1PGRY9slgD52a1P1I
fLAixUT63TeQqIVhxcSfzUeYlLt+O5ZLqLx4erF77GrZgYKoaFgNhuatpSj3H456
a3RN+Q9eaNIxOXGfit72ObniP+bY6BOTbfdOWZCb+zeGUjydyChPfj2T7sRW4Sus
cCH9zpxZxSAKqyatFL9Jtkh4uRUVZaadI6wASpUCt2ZqFPHZNPshjy5wmVlcZbx3
joE4ezkjR746rJhpHU/wVlicS16Iggt4tD+vD2NY8LdGyKNWGMMdO+wr7yssTF48
CyWcE4rNJmhmPlPxBlwUKd+uIRDeKHV1lUfxiPEkDLXCVLsWmZqdGOL6PkdMOWnu
tTl8hs8Y
=68bB
-----END PGP SIGNATURE-----

--L3ypCD+4CbOcgOx0--
