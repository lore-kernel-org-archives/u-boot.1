Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A462C43458
	for <u-boot@archiver.kernel.org>; Sat,  4 Jul 2026 17:15:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5F5183FEE;
	Sat,  4 Jul 2026 19:15:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CiDBfZjv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CF1584119; Sat,  4 Jul 2026 19:15:20 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD4A58341A
 for <u-boot@lists.denx.de>; Sat,  4 Jul 2026 19:15:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7e9dc546f40so1542723a34.1
 for <u-boot@lists.denx.de>; Sat, 04 Jul 2026 10:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783185316; x=1783790116; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=koOQqeoj+ZTAuTJibEu8Q632sgjp2jTqYAFK5Nnbe5g=;
 b=CiDBfZjvjFJFueRUqb0cDE7hFebS0hISMgSR8bk36bYk3zwhAPB7kXExlxbKfB4Y66
 6mY56+H7HQqCPfs3fMF2aSilHGNeEgaVun1qhPCso5w6sW3G6ptPHup2Qg4q2BQtMpW8
 2do+oqgEOVUfTWiQRGgHKbjTNGMMo/cWDeqAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783185316; x=1783790116;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=koOQqeoj+ZTAuTJibEu8Q632sgjp2jTqYAFK5Nnbe5g=;
 b=OxHdRmiRKOmPTBnEqkSuagq9h6URsyP5DeSa1T320wERNmBcPwVD+txa7wm9ZpGFsV
 ufpOqPayjY78HXVzqJvvcYeyEMUaDDs/EUXwmh3PhkZg2qB1JZw/ynAWS48DuoynekKk
 8reNP8Ih2OCnDdYQbU8X0dg15a86neHeZEeFtktJiO5JIyCupTNs2yHhmxlBST3MK0SA
 vjNSuRP554bC7If1VjBenhagHBs9PF6OGtHnY89jtKupSvCDSDiTazFjxc5SsMgU14rr
 WuhU2ywQAD2FIeNlK8Gt2/dPLLQljiHGy5juywCQqzkpND4em7Q/h0dAEp5fXaTEJDIl
 W6oA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/cmA6iGk9Tv0j5LiE0BCkC/PzO5bcFpVJRNFK+VGEw8JEszkbASXcPkgOcXqRS7F0pbP8AWtM=@lists.denx.de
X-Gm-Message-State: AOJu0Yw1JJvEvjH/S44bPNHynZbISBVfwnUJa4hanQJ3qlk+FYLGEHyz
 88I9gpmPsJjRiQpPnHk6BmCCK5Ud1af2kU8gLgqNVz+ko8AV9soYP6/hKoi/BDriQN8=
X-Gm-Gg: AfdE7cnG5fJLMq0dyfcfCEHkhkGq2E2o+cGgsj6IZvr5pXVEJD7x02u6zJNRVujCnTf
 sW3TeW/aSMpCaIlWMX0dGYnrhLETeK2jRczwNEPC9kkqAuoKfcmUcrjEfkYr+ip56GOsua0ucaM
 sqUuu7STH5ta/YlpQMAxCo5oX9imtldMUCs981DERGIKGTUIUPsErfa8OudTuOfXvQt4i1xE+6o
 Nh89tNa4gFuW6DpWIybLSkOI0gRBz7ZrNm6ZkdKBqUGhbjNRvgpawc7kTE5huNGfapy3HkfRfw8
 kja/4aTqLxZ6UTiJV1i/uyz3h2I2kkpO33hHkDgV9i6EM4GBMeMwRder/PJqUZj3hcDfEzmsFzM
 XSnCwdEeUBMXDs0LGRIcUkNY0LnTIv61+Br4WmB+iCKr8VLN2pVk2T61R8OR7qUfci5SZGMpQ4K
 8h9kCIgaLHziSaaK/ekjrk7zihiUAwcRP786jEJvO2R/Irm/wWMi29MCISMSqHX10dYs9yI/+Nq
 /1e96Y0sjGPkpIHEQcE2ERwRNG4siUbVVKw/A==
X-Received: by 2002:a05:6820:2089:b0:6a1:999b:a025 with SMTP id
 006d021491bc7-6a31d4e3405mr3882867eaf.30.1783185316475; 
 Sat, 04 Jul 2026 10:15:16 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44cfb559559sm5761044fac.9.2026.07.04.10.15.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2026 10:15:15 -0700 (PDT)
Date: Sat, 4 Jul 2026 11:15:13 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Carlo Caione <ccaione@baylibre.com>, u-boot@lists.denx.de,
 ilias.apalodimas@linaro.org
Subject: Re: [PATCH] efi_loader: stop watchdog devices in ExitBootServices()
Message-ID: <20260704171513.GN749385@bill-the-cat>
References: <20260704135258.68543-1-ccaione@baylibre.com>
 <20260704143251.GK749385@bill-the-cat>
 <590BC3A7-BA5D-4346-8757-5379EFFFEFBE@baylibre.com>
 <20260704161707.GL749385@bill-the-cat>
 <B60962BD-B25D-40CA-B06D-43A09EF076CC@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XUmEUljzZfrphmeO"
Content-Disposition: inline
In-Reply-To: <B60962BD-B25D-40CA-B06D-43A09EF076CC@gmx.de>
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


--XUmEUljzZfrphmeO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 04, 2026 at 06:59:08PM +0200, Heinrich Schuchardt wrote:
> Am 4. Juli 2026 18:17:07 MESZ schrieb Tom Rini <trini@konsulko.com>:
> >On Sat, Jul 04, 2026 at 05:21:25PM +0200, Carlo Caione wrote:
> >>=20
> >>=20
> >> > On 4 Jul 2026, at 16:32, Tom Rini <trini@konsulko.com> wrote:
> >> >=20
> >> > On Sat, Jul 04, 2026 at 03:52:29PM +0200, Carlo Caione wrote:
> >> >=20
> >> >> U-Boot can autonomously start a hardware watchdog
> >> >> (CONFIG_WATCHDOG_AUTOSTART, default y) and service it from its main
> >> >> loop, but the EFI boot path never stops it: efi_exit_boot_services()
> >> >> tears the devices down without calling wdt_stop_all(), and a watchd=
og
> >> >> driver without a .remove hook leaves the hardware ticking across the
> >> >> firmware-to-OS handoff.
> >> >>=20
> >> >> An EFI-booted OS that does not take over the SoC watchdog within the
> >> >> remaining timeout is reset mid-boot at a wall-clock-dependent point.
> >> >>=20
> >> >> The UEFI specification (v2.11, section 7.5 "Miscellaneous Boot
> >> >> Services", EFI_BOOT_SERVICES.SetWatchdogTimer()) is explicit about =
the
> >> >> one watchdog it allows across the handoff:
> >> >>=20
> >> >>  "The watchdog timer is only used during boot services. On
> >> >>   successful completion of EFI_BOOT_SERVICES.ExitBootServices() the
> >> >>   watchdog timer is disabled."
> >> >>=20
> >> >> U-Boot's UEFI watchdog (an EFI timer event) complies by constructio=
n. A
> >> >> platform watchdog silently surviving the handoff defeats the purpos=
e of
> >> >> that rule: the OS has no generic way to know it is running, let alo=
ne to
> >> >> service it.
> >> >>=20
> >> >> Stop all watchdog devices in efi_exit_boot_services(), before the d=
evice
> >> >> teardown.
> >> >>=20
> >> >> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
> >> >=20
> >> > NAK. We have had this come up before, and in short, the UEFI
> >> > specification needs to be fixed here, as generally speaking a watchd=
og
> >> > should never be stopped, as that leaves a gap where the system can h=
ang
> >> > and thus defeat the point of having enabled a watchdog.
> >>=20
> >>=20
> >> Fair enough.
> >>=20
> >> For the record, the failure that motivated this: a pristine Ubuntu 26.=
04 arm64 image on a MediaTek Genio 700 EVK dies silently about 60 seconds a=
fter ExitBootServices(), 100% reproducible, at a wall-clock dependent point=
=2E The generic kernel ships the watchdog driver as a module, so nothing se=
rvices the watchdog in time, and nothing tells the OS that it is running. F=
rom the user's side this is indistinguishable from broken firmware.
> >>=20
> >> In the meantime, is the accepted pattern hooking up a wdt_stop_all() i=
n the EFI path via board_quiesce_devices()? That keeps the watchdog armed f=
or the whole firmware lifetime and makes the handoff behaviour the board ma=
intainer's call.
> >
> >No, Ubuntu needs to fix their kernel image to have the watchdog
> >available early. I hate to be difficult on this, but it's been a known
> >issue for years at this point that the spec needs to be updated. The
> >workaround here is for the watchdog to not be started until the OS is
> >ready to maintain it.
> >
>=20
> Best open a Launchpad bug explaining why this watchdog driver needs to be=
 built in and not a module.

I'll leave that to Carlos, and I would suggest digging out the mailing
list threads from a year or two (or three?) ago when this had come up
before, and the problem was explained and it was spelled out that U-Boot
will not be spec compliant here, and I thought someone even volunteered
to take this to the spec to get updated.

--=20
Tom

--XUmEUljzZfrphmeO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCakk/nQAKCRAr4qD1Cr/k
CnWDAP4xZIdLeOz3f8XU+G44PI6W/ya1y6BN/23OcV9UC9i9JAEA07Yh29HHuXg9
4xx1us2WDtrHw2/O4zVYUc74CHkAngU=
=QOKL
-----END PGP SIGNATURE-----

--XUmEUljzZfrphmeO--
