Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB4A0C71153
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 14:54:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6849786504;
	Thu, 24 Aug 2023 16:54:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UNNjOqiw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A9F78650F; Thu, 24 Aug 2023 16:54:36 +0200 (CEST)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE40D864E9
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 16:54:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-58cd9d9dbf5so14133217b3.0
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 07:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692888872; x=1693493672;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LMLd+cf7viXnKDbOcT7nXRXRrbvIrKNUaVZJU+dI450=;
 b=UNNjOqiwqz+6xPfMZ2YBWH9GwHjOxeLlysYu/TeNnocgcKht+/KTBl23r7pDzmMwt1
 WQTGZNZ14IclQP+As2UkXH9DtMtGK9JpezA/IKTSk5ey6PDWWAUf56CHv9cuHqBYkIkS
 I5oVH8hn+Of5rO8f/ZhxBXZ+4HfibjjAyI4cM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692888872; x=1693493672;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LMLd+cf7viXnKDbOcT7nXRXRrbvIrKNUaVZJU+dI450=;
 b=EHY5/5I+NGemRAzrHNWESDVHIThuA6PtgmXqEip+K/DkGH+prCi3gD2mQE2AEr9Kq1
 mluUNCH7QAZ5V2OkgTTBRSBuol/rRaPj60EngomaD60HUwKnfcHpYNIcTG+GRvpVSiP9
 Ywazssqd7mUUJx/9S2obbYuvARPnqLPiJz1NsHX33cl7XcpUCN2r3Of44ajG9y/bGI+s
 33K9lzChzZHQEgOmoi2ZQXxhE5GsGMD4pB9kQ/4NLBLLOrVG2eAuia9xwrTNHWxUxzOo
 b4A0At/S/loQid1Jog282TjUyDkFQzK05M5EdsUgyqA/ScO9rGa+0Fe0CA4Ihc8Gzipf
 SgaA==
X-Gm-Message-State: AOJu0Yzrl9Wdwo+Ghm57uPFpx/Dmt0tsjYe0RboNqr4DS8neGzgyECAa
 5Wa2QOrXl+XBFSmr+SBG4/LYTA==
X-Google-Smtp-Source: AGHT+IHTiLBMgDR8Zchi+WqYajQQ42zCiBwme80RnSW4PH4H6N936nFTcUHPfLCDH9CA9a7dWc2sPA==
X-Received: by 2002:a81:6dd3:0:b0:56f:fd0a:588d with SMTP id
 i202-20020a816dd3000000b0056ffd0a588dmr16163470ywc.8.1692888872614; 
 Thu, 24 Aug 2023 07:54:32 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-37ed-1199-bcc5-406f.res6.spectrum.com.
 [2603:6081:7b00:6400:37ed:1199:bcc5:406f])
 by smtp.gmail.com with ESMTPSA id
 z74-20020a0dd74d000000b00576e5af0249sm3913016ywd.20.2023.08.24.07.54.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 07:54:32 -0700 (PDT)
Date: Thu, 24 Aug 2023 10:54:30 -0400
From: Tom Rini <trini@konsulko.com>
To: Nishanth Menon <nm@ti.com>
Cc: Neha Francis <n-francis@ti.com>, Simon Glass <sjg@google.com>,
 Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH V5 05/17] configs: am62x_evm_a53_defconfig: Switch to
 bootstd
Message-ID: <20230824145430.GR3953269@bill-the-cat>
References: <20230824031101.3460411-1-nm@ti.com>
 <20230824031101.3460411-6-nm@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rSCQi0OoMOusI4oS"
Content-Disposition: inline
In-Reply-To: <20230824031101.3460411-6-nm@ti.com>
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


--rSCQi0OoMOusI4oS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2023 at 10:10:49PM -0500, Nishanth Menon wrote:

> Switch to using bootstd. Note with this change, we will stop using
> distro_bootcmd and instead depend entirely on bootflow method of
> starting the system up.
>=20
> Suggested-by: Tom Rini <trini@konsulko.com>
> Suggested-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--rSCQi0OoMOusI4oS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTnbyYACgkQFHw5/5Y0
tyzFfAwAjOMrRzmxUZqry453VlNHr3cdj3TP70XngGlKgjjBM+wgmgaNSpdBQI1t
CNc4i8p+Z8Q20ZItgqjg0EbuDMosWFbtIHnMpPc3RUommJNRbwrI9eXAM0XP+fED
fuzZubupknquN1Zkl9k6JAAYu3msrxf3RYzgiigLA3+CxodaYKIEO9pdNclyLwQ8
S9GAdfM4hd/Uwrj8nT+DypYOhT5Wai/5FmJhIHvfu8p4CSXutq69WFcYl9Tj6kQ0
SgnzgewwhsUwrGuO9w3gWlr4nNI4zr5U1zRXKTPyrAy4vUZ5bQGEg771vfjl6kEE
FipKe1CytDwxUDjvYqb0czAPAtAhs5WJ+nV+Ja43kA8xuloO7ru1w33aKR1rw/mR
3/RgdghN3/HMo1T6n2cECA6TKx53xElCBI7PEGfjHAgKt80KmUoPrOOAmRsDE6fB
Oo0FAgEIk1keH5wKbQLM5NZhXT1yRZ4konP4l2kwlZEsY+ZlnS2qjPyF7dERO5DS
pbgYTlsN
=BAjY
-----END PGP SIGNATURE-----

--rSCQi0OoMOusI4oS--
