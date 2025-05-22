Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE2B9C54E65
	for <u-boot@archiver.kernel.org>; Thu, 22 May 2025 20:51:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 667D68310F;
	Thu, 22 May 2025 22:51:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pPHqNZZ8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33F9D83164; Thu, 22 May 2025 22:51:07 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B62EB83108
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 22:51:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7300069c447so5443340a34.2
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 13:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747947063; x=1748551863; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7FzWYlYGYNyIr42s7qUEL3xFbrqDqmjQmYAUlgqtiE8=;
 b=pPHqNZZ8LTUCEiVTCnTQMjo/DUQCPHJsUk+1r0KoJKnPx0oBdLYb6V/uAGF6r4XHTV
 jBIQOTW0L7GPrz8tE1QHQoG8btEdO8qYe/1EcnbrbcjynekIffBbZ+IFy8/1nQCSmEHZ
 abh+UweBOisYX51tb9X54WABhHKIBs6t42yC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747947063; x=1748551863;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7FzWYlYGYNyIr42s7qUEL3xFbrqDqmjQmYAUlgqtiE8=;
 b=eYgPQKPthoMTZc6TS2+ixq8L0sthfQg3R/qDBm1DnneTlhEz6XlrQw8vPg4GY2U9PK
 hUJ6K10j5c6LDCaGC8sUvGfRmsBqyLxWOvBWhTxNX98wXfjJGJtY28k22nryxpsDATgX
 9NWUP6AvBSI5KZW6yL+3qvBLbCEAKtwKcKzwQf7QqvkjV4uMciDajvsNLlwBHxzeLnVX
 n2WaymQEIiFCSJXncPf8HMO5TsElVDvZIubyQR5+EUOW4+mdloVS7TRVmB4QJJBtZXbe
 wBkyQfN9WB9C0wXzIrTy5HxI5dvCIsZ/UGaf1uxUjdE3JRRtBxHGuBpklDM7SCWHzYAl
 NDiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZ3zFs+7pzNG26lC6ZqQBN6r/aI6zh+vD0lXdnn2GMu71C6CqEY9h8KL8IJi5X96B4usR9Wko=@lists.denx.de
X-Gm-Message-State: AOJu0YzDJ6tBT+FwUAtqIfw/12KP+W+YeYBaMAy9DI8e2EUkh8swf03/
 ry12XFIyQeaFfMCBM2rCBjOQVKlWVNWw46Vkg9FTwbX165tmSAT2Bh06rr29EFNuU9E=
X-Gm-Gg: ASbGnctfsx3WUO/cPzCVR5DP5NrTkr3kJa3ZaRIrjOLqTXTvZFqqa1H3JufFpYk3ey6
 LViuGoDXbOkNVz/D74L9pa46qc8hwHCrbTfMFPVXvK1F6LwZdC6aXs8e8G/UpAvANBcoGLCTKmg
 6j6Y+atBAhdwGUdayGcYW17dI4o8oJ0tPFuRVK/Ky6lSJdPL99+CBFiumnyZ124rB1UGy4yuHV4
 i0L3q8YCcg/wltGx3efZu0XkkvXMZXpoNua5uVXCRWuq1NqahA5CbaTqdqjKyaYEu4EpAiPH0ki
 Mu3mGgIR+h6ghlpgV5QubgbmkO4MrGUjqk1GfystvZFVyy19TqjlaX/oOzLJep/AnbHxeXukYM4
 rleoy5F0niyqt
X-Google-Smtp-Source: AGHT+IHbED7WQ0E40a7qkUrEn56fI2Z8zlRfDDnaMgPzjUCL+3y7CRsk1QohvbPgqbnxs/km0vbrlg==
X-Received: by 2002:a05:6830:6308:b0:72b:a6a9:8465 with SMTP id
 46e09a7af769-7354d5cc8b0mr473294a34.23.1747947063408; 
 Thu, 22 May 2025 13:51:03 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-734f6b5f697sm2608798a34.57.2025.05.22.13.51.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 May 2025 13:51:02 -0700 (PDT)
Date: Thu, 22 May 2025 14:51:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io, Varadarajan Narayanan <quic_varada@quicinc.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Subject: Re: [PATCH 0/5] Qualcomm: teach the build system to emit signed ELF
 images
Message-ID: <20250522205100.GN100073@bill-the-cat>
References: <20250522-b4-qcom-tooling-improvements-v1-0-8141b8955cfb@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Rl6czu1YTgHFRr1j"
Content-Disposition: inline
In-Reply-To: <20250522-b4-qcom-tooling-improvements-v1-0-8141b8955cfb@linaro.org>
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


--Rl6czu1YTgHFRr1j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2025 at 10:39:38PM +0200, Casey Connolly wrote:

> With several new Qualcomm platforms appearing on the mailing list, all
> of which build U-Boot as an ELF, sign it, and then flash it to some
> partition on the board, we're getting a lot of defconfigs which just
> contain a debug UART and a TEXT_BASE address. This leads to needless
> rebuilds in CI of effectively the same image, and needless duplication
> of build instructions.
>=20
> To address this, let's introduce a new tool "mkmbn.py", this is based
> on the existing qtestsign[1] tool but is (currently) hardcoded to
> only handle the Dragonwing and IPQ boards which use MBN header v6.
> Additionally, the tool contains a lookup table that maps from a boards
> DT compatible property to the load address it needs. Since it's highly
> unusual for different boards using the same SoC to have different load
> addresses, generic platform matching is also done (e.g. "qcom,qcm6490").
>=20
> With this tool in place, we introduce a "u-boot.mbn" target in the
> Makefile, this can be invoked to build a Qualcomm signed ELF image for
> supported targets.
>=20
> Finally, the defconfigs are cleaned up by moving the debug UART
> definitions to config fragments (since it doesn't make sense to have
> them enabled by default anyway) and remove CONFIG_REMAKE_ELF. Notably,
> the qcs9100_defconfig is removed entirely since the same binary can
> be created with just make arguments. This platform entirely lacked
> documentation to begin with, which should be addressed by future
> patches.
>=20
> The Qualcomm documentation is also cleaned up, a new "signing" page
> is added to briefly cover the what and why of MBN signing, and board
> specific pages are updated to explain the new build process.
>=20
> These patches have been tested on the RB3 Gen 2, but additionally
> testing for other platforms would be super useful.
>=20
> [1]: https://github.com/msm8916-mainline/qtestsign

How much did you look in to having binman be what invokes a tool to
do the signing? Thanks.

--=20
Tom

--Rl6czu1YTgHFRr1j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgvjjAACgkQFHw5/5Y0
tyy4iAwAhs9Q9srJ2raqZUjltTP3nJVu0sYl2D/Vp3WwQ2/X7dVVmpnhl1DsF5vm
L4O65Hucidm2TNWVDrWurzt3ch92n6aFOlO6cje1JiC1CSQWC2sHh68j1dvxRq9F
mG1yb1s6yD7mRZUtWhX5WVhwYM8lzLOWDwb9n5k1SMzsgG38b7U0flxuOCGj+KrP
0elY0v+Idv1htRHFD5ohkFxjezNqlqVVLw9t3MSq/tjmYW9EbPEGHyDzwyPL3VwP
l8OLEhQ9zTimp3F801RklbtkkHa+CDEnI/WEMKStvLHrLrkY/xzyu4WiIrv4KDCf
884yVBaoyNPtA+x0JKGzcSmdzXPWl63Jx20sLMgjwGxEbh5/1iu1l3VQOV/p9Psk
6rxYYvvp7LLCGEEYOL5y5tnDWGhtWG8i50PfqGb6bel9BImsYczf+AgOQFruTip9
+q2CTEOPnism/lES95yykmE7uu3rB00CwSv/DnYvevYWSFOBbESahfzFTMCMhUm0
fACmuLwS
=jKFE
-----END PGP SIGNATURE-----

--Rl6czu1YTgHFRr1j--
