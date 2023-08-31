Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 988F6C83F10
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 16:27:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C80C8675B;
	Thu, 31 Aug 2023 18:26:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KMgN0zZm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3264B866EC; Thu, 31 Aug 2023 18:26:51 +0200 (CEST)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FE528671C
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 18:26:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-5920efd91c7so11820557b3.2
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 09:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693499207; x=1694104007; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=joqlpq6ztffNX+3B3VyL9W0wr7Y9gwENKAXDg37lYmw=;
 b=KMgN0zZm7A4fE3Dhdi8iNA2zEdHG6oBgSFv3+147j4GhFfMBe8oM9AoPnTnFIxlnmR
 8RlBuUQ5aKU1tDV9+sPAIWalwS94cRaWsp1sC2M4DcPxwrnejfxFDpHvfFu6WltR3271
 pTXilHVeMIK5wTz0YfF/Vz9rAWvfbvesvos0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693499207; x=1694104007;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=joqlpq6ztffNX+3B3VyL9W0wr7Y9gwENKAXDg37lYmw=;
 b=g3Qtf+W5vSuHwP3RAdcPckwm9FM2WlIzwpTmjquU1RqmlRDk6CIaokwTzOSWJlq+cb
 f3NpSfIT5u8aoLppO7kTdoAWEeGqVGXjXspmxYHsXnKtGpeXYC5ZhZB6TLe1u0GT6gnS
 kqyvh0qpoin8oEnk43rolKnsrB23duRZ5XDpJpvRQECLTQnYLTasodt0td8BiQIUm6mq
 tpdocJrl4Ai3+XuJlQqnvGDYiO0j1HKyAQgbevGUbbxlewTePSXS+4IcL/nWpy3icG36
 nKrl2mvZLmi0O7FIoxxr+W/HN8fKaqfJy9+/7SOx/Excf0sYvds7zO4iDLcjti1mB1CJ
 7ZTA==
X-Gm-Message-State: AOJu0Yy5k93UXXn7djldvPUraAMap10FT+5tuJrdRg59FL1y/pNGIfgC
 KU51JeNcZUCoFgqYe8Ns5GKVJA==
X-Google-Smtp-Source: AGHT+IGilm750k4iP9OZhEE6mqpOkge0bMwPbttV2ltBS1lBqeXqyz5hF4dNNMUr6gKbPfK/biQWNw==
X-Received: by 2002:a81:4849:0:b0:58e:fa3c:9401 with SMTP id
 v70-20020a814849000000b0058efa3c9401mr6200688ywa.12.1693499207355; 
 Thu, 31 Aug 2023 09:26:47 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-1cd4-1a46-fd5d-6cab.res6.spectrum.com.
 [2603:6081:7b00:6400:1cd4:1a46:fd5d:6cab])
 by smtp.gmail.com with ESMTPSA id
 m64-20020a0dca43000000b0057a57a9a932sm500492ywd.107.2023.08.31.09.26.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 09:26:46 -0700 (PDT)
Date: Thu, 31 Aug 2023 12:26:45 -0400
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v2 4/5] drivers/mtd/nvmxip: Move
 sandbox_set_enable_memio() to test
Message-ID: <20230831162645.GH3101304@bill-the-cat>
References: <20230823001821.266578-1-marek.vasut+renesas@mailbox.org>
 <20230823001821.266578-4-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="w50URKfMvHQIoIsM"
Content-Disposition: inline
In-Reply-To: <20230823001821.266578-4-marek.vasut+renesas@mailbox.org>
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


--w50URKfMvHQIoIsM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2023 at 02:18:20AM +0200, Marek Vasut wrote:

> The sandbox_set_enable_memio() should only ever be set during
> sandbox testing, not within driver itself, move it back to test/ .
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Applied to u-boot/next, thanks!

--=20
Tom

--w50URKfMvHQIoIsM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTwv0UACgkQFHw5/5Y0
tyyHQwwApxNxbQOoVXy8j9EsZx5OKMvLFMoinoU2w8uzYWMFFHjqfWgUGBWsuAwR
5um5vmmmGNdVqaKq0hoi+xg/PIbFu67W/hZ3f022Iyms8xco6U+kfSnTyHofPW5X
xXo9PSN9woPLlSOGcHVggf81xIvErJ7NXcixNGrsMjEwxhXx83hdBPTKALcz34FM
u/nJl1+C79yWyFcqvbdFFNGAGiz+dS8oafPJ/+Nbq+QuVSgY/I1v9Qznn9zeHOTh
avnu6GL1mBSWhFCSKuQKPpAscbLTUtvIXqvZGpKPK/ekMZyyBnoeUTdHbaMlsNtx
pePuzwgdH91JZb2oDuq31K93PddYAAtNRb8gzn4FN0LD5ilIdStqCSRzAG/f3tF4
vOwmf5/kZnjRbQF6s08jBhZzK6pwbNWYdqXmpb07VgLpqIw2iMTLP98soOSwJD2b
ydPGmWpifDxzCTS2npOv4U/0ZWnPLYAfZ79mymNeC5t3fO4Gp3XgwJNB2+C/xbOR
+UqsZJf8
=OCIL
-----END PGP SIGNATURE-----

--w50URKfMvHQIoIsM--
