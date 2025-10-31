Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 075BECCFA02
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 19:17:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C87F83AB7;
	Fri, 31 Oct 2025 20:17:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="a5UtJTEF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0394583AB8; Fri, 31 Oct 2025 20:17:35 +0100 (CET)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C04AC83AB4
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 20:17:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7c531445439so880967a34.0
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 12:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761938251; x=1762543051; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=js/HZRzruMss/+0q/vzPIwkTBSTMdfagWEJp2ZM3l+Y=;
 b=a5UtJTEFxAF/hoJy3AbjylJiy0SRp5JuLSZowaIL4kXyWpzPaa4q14Jzrf1ScYifiK
 13DTft+WmNuKUII62pMveJ9QJJlIlaaOT+DKjV1Ckmditf+P0R2jIa24xqCw0tlhvsvB
 8cwkPNBq0JXTpw57+OOHIQmqCUJluNKoy+D7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761938251; x=1762543051;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=js/HZRzruMss/+0q/vzPIwkTBSTMdfagWEJp2ZM3l+Y=;
 b=LE/t+NsWTz7FF/Vi/df//x+N2imzlfGYK0jNqhgw5pNsIA0HLF8CO76cR3nWdfoksV
 rzsYpk/AMCmBEK1Xw5P9++d0j2Dr0nZVh+bkZJb+ARbQR94a8FZNcl08sdeEMUqOcbAM
 /gF206zsyS5oJ1rWjQt6f13zftzayoDqiGvJiKQz2O2md10pz5S4g0TQ3Zon9BmOG4pi
 gdH/+3p42MwLOPs8qfyfrBzluYFRMj2VMyDo4ejbDPwezM3YLlBsWZvc2IVy+xcr0ns1
 L5oFu67bYyr+BnoGFRJejmA3E0ArEDaEgU69zS8i8K/dUaqYzvLl70ETnbVlkFLFKASf
 XyZQ==
X-Gm-Message-State: AOJu0YygHtLWbzvk0iztGcVeMh/xXtdGxcHRW0H49x4nUF0Va97oiedP
 +8xn4YLwdj4wwZbiagbE1uvNubnliM+cPmT7e05ONRobMLjsj5HbcKH68JafdDY1E8U=
X-Gm-Gg: ASbGncsSZ7L0r0ar5+4WfLkvOvy/bfDmKeyfjxew2Yf/95gCadurdjsireD+4olg3nh
 5mhG/t/YAbfQux80jjolAM16DDnH/YrMtHQW8iTP3FidCO3iSoVs7yjGnQALvwcAEBW6CGBXmmE
 dY722NeP+U8e8Jrb5myxFsTK08ZyfKifv+2BdrWcmpKa3AmHmGeRmXSMpJSglT2F4bByf9pVy3o
 2pRVAvsIEnQP67kL6MWpXT599OloGLNWZwQIVFmDyHcZnyPT8GIu5Sre5tMK3Lt4qsk4ru0dbBY
 kL0S0vq8jFSDNProIdzgSdmGhrSFmGVyzvKuQW/E0j2YHcRsf+6DfXtqjVDLmWXwEgph2icaAi6
 l1pKvD68M480AcycOItdISwaajHK0XAIk9VYqn0rYq8ch7IAs4FcaZb4TgKuKr7/rQCmPYSKJly
 T3vRQN5w6uKI4IDAfvRWxiK4yIMuGjoc2Vj3FLn7U=
X-Google-Smtp-Source: AGHT+IF6jqOp7iSJxyFh6raWaOhEVtiU+06U9gbnBgrjOGJv3B0djGKI+jnuQAC/ZnYe+cQ17+SFBQ==
X-Received: by 2002:a05:6830:82da:b0:7c1:1170:8959 with SMTP id
 46e09a7af769-7c6967e21fbmr2727089a34.27.1761938251460; 
 Fri, 31 Oct 2025 12:17:31 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c699c1ea72sm781609a34.8.2025.10.31.12.17.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 12:17:30 -0700 (PDT)
Date: Fri, 31 Oct 2025 13:17:28 -0600
From: Tom Rini <trini@konsulko.com>
To: Sune Brian <briansune@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: u-boot@lists.denx.de
Subject: Re: [DEBUG] rk3399-nanopi-neo4: SPL SD init may report -5 due to SD
 power-on timing
Message-ID: <20251031191728.GG6688@bill-the-cat>
References: <CAN7C2SArdbhag_56MwOMGoaEYSLiHbHHo3KFhUS5U03ntEJbGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0p/sm1RLJLwIDWcZ"
Content-Disposition: inline
In-Reply-To: <CAN7C2SArdbhag_56MwOMGoaEYSLiHbHHo3KFhUS5U03ntEJbGA@mail.gmail.com>
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


--0p/sm1RLJLwIDWcZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 12:10:36PM +0800, Sune Brian wrote:

> Hello U-Boot maintainers,
>=20
> While testing mainline U-Boot (v2026.01-rc1-00070-ge34d01d23e45) on the
> FriendlyARM NanoPi NEO4 (RK3399), I observed that SPL sometimes fails to
> initialize the SD card with the following message:
>=20
>     spl: mmc init failed with error: -5
>     SPL: failed to boot from all boot devices
>=20
> After investigation, the root cause appears to be related to the **SD card
> power rail (`vcc3v0_sd`) timing during SPL startup**. On the NanoPi NEO4,
> the SD slot is powered via GPIO0_A1 to a fixed 3.0=E2=80=AFV supply. SPL =
may attempt
> MMC initialization **before this supply has fully stabilized**, resulting=
 in
> a generic I/O error (`-5`). The SD card itself and the controller are
> functioning correctly once the supply is stable.
>=20
> **Workarounds / fixes observed:**
> - Add a small delay after enabling `vcc3v0_sd` before SPL starts MMC init.
> - Ensure the regulator is fully powered and stable at SPL start.
>=20
> This appears to be a **hardware/platform-specific power-on timing issue**
> rather than a device tree or software bug, but documenting it would help
> users encountering similar errors on the NanoPi NEO4.
>=20
> **Hardware:** FriendlyARM NanoPi NEO4
> **SoC:** Rockchip RK3399
> **U-Boot version:** v2026.01-rc1-00070-ge34d01d23e45
> **Reproducibility:** 100% with SD boot

Adding the board maintainer and come other active rockchip people.

--=20
Tom

--0p/sm1RLJLwIDWcZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaQULRAAKCRAr4qD1Cr/k
Ct4TAP9G8z9q9IHd4429kuTE0QCcvv3H4Mz223df/xTBZZ4EFAEA5f7yK2xLRqUH
JDGnirl3uJvzI157APlAYyxoL4Zp8QQ=
=/yqa
-----END PGP SIGNATURE-----

--0p/sm1RLJLwIDWcZ--
