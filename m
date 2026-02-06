Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ECFFEE20A6
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 14:01:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8274E83AA7;
	Fri,  6 Feb 2026 15:01:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JBuh05kH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42646836D3; Fri,  6 Feb 2026 15:01:17 +0100 (CET)
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com
 [IPv6:2607:f8b0:4864:20::242])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0D4483B5E
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 15:01:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x242.google.com with SMTP id
 5614622812f47-460f3f9fdb1so1525916b6e.0
 for <u-boot@lists.denx.de>; Fri, 06 Feb 2026 06:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770386473; x=1770991273; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=oB2uyayv2DJECqbT/T8LQ0c2BgJ7zpw8YdGrpnEg9pw=;
 b=JBuh05kHt29Wx+mWmpAiaBEeSjPF3Dx70iwLTVMO/hR85ad2yji3EKEeDFJh+Ag1D2
 Jp4wxY9qKVnEDum9ao7b+ZiEFfpQVzEc9asE6Bura2S8bIor9qPR1AMCKco134dV5MjR
 elX/c0OUbvjfx5I6ss9bUjE3NBkMCgSGzLB0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770386473; x=1770991273;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oB2uyayv2DJECqbT/T8LQ0c2BgJ7zpw8YdGrpnEg9pw=;
 b=MUmoajscc32I9itAAlri2RGXSYNZLTvX9w97Ho/i3iNCZ9S6jXfQ2oCdlJW9/WRLDu
 SBRcVXAgaxM1XWrg8BdrbhDZYMj7PHOKrJBlTLpNGDZ082h5HMp9+0W77Rl0UKHERwhT
 /FxvGvX2s5qwmsTi8m+OlNZEAVghz/1fBZRYfZUcazQioC9PCf5WC7wEbM9XVXmSfOQr
 9Q+4mggNUXxO8zS3sRZBd+jMK8wdKhJvHzASe2SS8BXlMIJnYk5NPgo2gVoSssU327x9
 L3XCnZ75hO2YbHL762kTZu5RXIdOsc2pEkdXsJPMiBwJL/7V70n8ADGiV29Dp7oCjvGc
 9QAA==
X-Gm-Message-State: AOJu0YxPXbyTBiLnRoxnsmWZ7dsnZNSogf+1CS/wYNZlUoQ14uUGZIsn
 plYoBRHOSoepbcDeF4rVoGrS0J/BjBbc5Q+cFiM1a8t4tHUXhxvO0flykwzIB9LxvQY=
X-Gm-Gg: AZuq6aJQiQjC4l0cEhrapcWyyeRX68OhH3IhZGKBQEFPJqKo01m251xsX0vNtq6d1eT
 uTUS3gLwZWgfD4w62NtFy5Bgf3DV93kS+Q+EQSDNbEWkpGb9auz7y4yeqEGWHJiYzS2Meh0AZ53
 LksWy6tC9kvnuBJLoq3zD8Z3/Ay1+RfyrnEFui7P1la8pHWUHJXvWSxUw8hu9PVDJ6QBnIoxmq8
 hTERy4sR4T1n3R3eb6RRORi2Abxy83iAq9Oy4XMPoeU4OgfBy9Va/iV35KJgWUVLUW0n/fE/ONI
 wEUqJ10GqQ2hGVU3Z4d1XCLYmPUKzbJFJtJMRAfl0MFa/Jyd0UUkFHTZeeMZknBEvG5Xj4stfee
 1v1R1hF2BiWRnQBrhYbFnF/VVx5Ef33K0+g+9zAe2iQm0UTnYyBG0KY+19gR1gfP+CvMhCtsYTu
 xVlFIqEqIVVYLSI9y7Ljzz1sjk80odmx3f4cbqksxIMFddL9enS/O8vhBpoJM+c8ibDEV3t666s
 0wixSsA1+U80PGuFEdWMSgOZzQ9deuKDQEuktg=
X-Received: by 2002:a05:6808:6f85:b0:455:eba2:9efa with SMTP id
 5614622812f47-462fca7ab26mr1377336b6e.4.1770386472973; 
 Fri, 06 Feb 2026 06:01:12 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-462feb4e4a1sm1324426b6e.16.2026.02.06.06.01.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Feb 2026 06:01:11 -0800 (PST)
Date: Fri, 6 Feb 2026 08:01:08 -0600
From: Tom Rini <trini@konsulko.com>
To: Julien Stephan <jstephan@baylibre.com>
Cc: u-boot@lists.denx.de,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Macpaul Lin <Macpaul.Lin@mediatek.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Julien Masson <jmasson@baylibre.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Peng Fan <peng.fan@nxp.com>, David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH v2] board: mediatek: add MT8370 EVK board support
Message-ID: <20260206140108.GR2603314@bill-the-cat>
References: <20260206-add-mt8370-evk-board-v2-1-105c606f80dc@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="17kaR6JAdhtcXFC/"
Content-Disposition: inline
In-Reply-To: <20260206-add-mt8370-evk-board-v2-1-105c606f80dc@baylibre.com>
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


--17kaR6JAdhtcXFC/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 06, 2026 at 01:50:31PM +0100, Julien Stephan wrote:
> This adds support for the MT8370 EVK board with the following
> features enabled/tested: Boot, UART, Watchdog and MMC.
>=20
> MT8370 is based on MT8188.
>=20
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
> This series depends on [1] for several cleanups such as memory map.
>=20
> The new defconfig file added here is not yet part of any MAINTAINERS
> file, waiting for comment on [1] to be addressed.
> ---
> Changes in v2:
> - Add defconfig file, missing on v1
> - Add dependency to [1], for memory map cleanup
> - Remove board/mediatek/mt8370_evk
> - Link to v1: https://lore.kernel.org/r/20260204-add-mt8370-evk-board-v1-=
1-3132f953d845@baylibre.com
>=20
> [1]: https://lore.kernel.org/all/20260205-mtk-mach-clean-up-duplicates-v1=
-0-b7d4a43c18eb@baylibre.com/
> ---
>  configs/mt8370_evk_defconfig | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)

To be clear over here too, defconfig without MAINTAINERS fails CI. This
will need to be added to the new MAINTAINERS file I just suggested.

--=20
Tom

--17kaR6JAdhtcXFC/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaYX0JAAKCRAr4qD1Cr/k
CsTHAP9uk7OQYXukJ+aPbGHPBXZKuL7SYYt8LU1b+ffJEcRE/AD+M8YDw1dtlmr6
4RhqIRw3M/CMCWlqys2gkK3QiqDBKQo=
=hOmz
-----END PGP SIGNATURE-----

--17kaR6JAdhtcXFC/--
