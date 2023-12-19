Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90AF2C41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 17:45:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E745F8709C;
	Tue, 19 Dec 2023 18:45:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hGZxFMeF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B32C86D33; Tue, 19 Dec 2023 18:45:46 +0100 (CET)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F16E8709C
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 18:45:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-dbcd67d4c29so2994372276.3
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 09:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703007943; x=1703612743; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KGoPaiwrHxxnk7rz69aVeppKNOtfgiG1CZDnxtzGuJs=;
 b=hGZxFMeFzYO5TfUmTU1BiW9Ke7ya4P5ktd7tzsqGdDLainqYCZrY2xqUNB+9Qy5S5c
 TVLOx5kUNZhE4TY6oiJd494gAl+R6LdXbzkLP7Yk3tPxryHDAnWc0hPfRbn5M7arNvvc
 9XQF+cRGBKqxrrRQqkeWvQzl2d0mWmuDjj6co=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703007943; x=1703612743;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KGoPaiwrHxxnk7rz69aVeppKNOtfgiG1CZDnxtzGuJs=;
 b=i46TjJVp8/X9bdsdi2qGbRbmklySiCDA60oNPslNu72oNO3l8wPKIeEGgDZ4sJq19J
 qUzN3WSu7JCLB4xDCTMiY/pCRMP8cl3mlySU383Z47qqtxBWQax7u5cVF+h9rR3wRXvY
 wrUjQpRehyF0uGoJ55PAsDR/0GqtuQ4++xhUpUoyB4tpposLgBOfXlSUQ2chKWlTtb7j
 wYAu7iBXE1KcRhJbXi1tRdt3U6oclK/zDT2eo6U2St3liHzbrNfjpYzpZiTG29gKWkyD
 kNeaH9emKRou7mAyifApsLoIR4w04J0w0iW+aIbaiR6nkEMwKTTyY0UliKOhBjzB9U1Z
 ZAEQ==
X-Gm-Message-State: AOJu0YxTECmgq6MFJapboGzFkMNOlNyqJhbwfY8JN8qZYnagnQs4eh95
 0dl8Eao7LGWizqln6SVpXn89sw==
X-Google-Smtp-Source: AGHT+IGzPnt4gQtuSMKHWVDT7tca7X0IOkPcwj2g7TSvzZH3DoB65ZxgjHV4tvdbUguTZgD2K66r5Q==
X-Received: by 2002:a5b:52:0:b0:dbd:56c7:da80 with SMTP id
 e18-20020a5b0052000000b00dbd56c7da80mr759227ybp.31.1703007942889; 
 Tue, 19 Dec 2023 09:45:42 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-923c-ac63-6854-a688.res6.spectrum.com.
 [2603:6081:7b00:6400:923c:ac63:6854:a688])
 by smtp.gmail.com with ESMTPSA id
 w142-20020a25c794000000b00dbd48c5adb0sm1068794ybe.63.2023.12.19.09.45.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 09:45:41 -0800 (PST)
Date: Tue, 19 Dec 2023 12:45:38 -0500
From: Tom Rini <trini@konsulko.com>
To: Apurva Nandan <a-nandan@ti.com>
Cc: Hari Nagalla <hnagalla@ti.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Simon Glass <sjg@chromium.org>, Andrew Davis <afd@ti.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, Dasnavis Sabiya <sabiya.d@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Aradhya Bhatia <a-bhatia1@ti.com>, Bryan Brattlof <bb@ti.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Nishanth Menon <nm@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Roger Quadros <rogerq@kernel.org>, Jayesh Choudhary <j-choudhary@ti.com>,
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, u-boot@lists.denx.de,
 Sinthu Raja M <sinthu.raja@mistralsolutions.com>,
 Udit Kumar <u-kumar1@ti.com>
Subject: Re: [PATCH v6 00/17] Introduce initial TI's J784S4 and AM69 support
Message-ID: <20231219174538.GX2513409@bill-the-cat>
References: <20231206123753.1486031-1-a-nandan@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="U/g9ql4kMuZy/0le"
Content-Disposition: inline
In-Reply-To: <20231206123753.1486031-1-a-nandan@ti.com>
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


--U/g9ql4kMuZy/0le
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 06, 2023 at 06:07:36PM +0530, Apurva Nandan wrote:

> Hello Everyone!
>=20
> This series will introduce basic support (SD and UART) support for Texas
> Instruments J784S4 EVM.
>=20
> The J784S4 SoC device tree patches are taken from kernel patch submissions
> and will be updated as they are accepted and merged to the kernel tree.
> All other patches are specific to SPL and u-boot and do not have
> dependency on other trees. Appreciate a review for acceptance to u-boot
> tree.

Please rebase this on top of current -next as it doesn't apply / build,
thanks.

--=20
Tom

--U/g9ql4kMuZy/0le
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWB1sIACgkQFHw5/5Y0
tyxNNQv+JhPmcLvnJYFSPP4yM2tHlWFVaZbqAqpSVOfwFqxGYYqJuZapQ9kbcdJD
XVgDXYdnw5jlSZ9+0Gc0WALB0wP7bdgvqM5GeIJXdky9K+aLX6wec+sO8/h/sZDK
3LYiXvV7fZRHkhCdX4FSpxWw7t4YS1b1zX5bX4uUo1Dy6OK82t2DJMLcIm09wkhf
EY6+E3orlh/2ixxLW+ql2aXc4YyOvnhvoq1PcCstXXkry4KHzXwz6YfIvgVJ0XCQ
rOV9e6KDaZufCqZyd3T1BtjNUzipzsP9OyZ1fVCwaFHRRfIWKTKrt4LK5Y0oQyul
IhHlO8/863/fQbqWwtvAzySh90Cxp5IH+KLr6kaVE06IuP+5NwygCjbqeXf8tb0j
z4TYJyZ+ZoeFq1oOcMoZ2EwqF9asdPR9f/K8pjTB/jFCHn/Z1v2aXuurmjhdXkyj
ekbFbe41r5hYJilBcaKAv4zgpABll1kAH1a3SKuzPLnSH+puetCwJSYby4LaeaGi
uJswOlNv
=O41H
-----END PGP SIGNATURE-----

--U/g9ql4kMuZy/0le--
