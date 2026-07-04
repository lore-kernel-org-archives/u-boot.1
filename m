Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCFEEC43458
	for <u-boot@archiver.kernel.org>; Sat,  4 Jul 2026 16:53:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17AA183FEE;
	Sat,  4 Jul 2026 18:53:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hf1OV6Zx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4852483FEE; Sat,  4 Jul 2026 18:53:52 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F08218341A
 for <u-boot@lists.denx.de>; Sat,  4 Jul 2026 18:53:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7e9f6b94a49so803200a34.3
 for <u-boot@lists.denx.de>; Sat, 04 Jul 2026 09:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783184028; x=1783788828; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vdw0v/w0+YUd23YyWimsKmIZxnSdYx2MSJqnE1xFNIY=;
 b=hf1OV6ZxII+t1OKKL0p6OsbZHF0RI94KbDOlWYBTTu8nV1gCdh0+gqDPRGjmn4tU01
 wftgZBcjL8DiNDflbYZ4d8zbyTGyL1eRwbdw3fXjroQ/0c7dEYXy+b5xCsJBv3GYu+4Y
 Xd8ZGPf4Jsu5R824ot99h25kd2NM/sakJPa5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783184028; x=1783788828;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vdw0v/w0+YUd23YyWimsKmIZxnSdYx2MSJqnE1xFNIY=;
 b=C1IU9iV/dlbOeAiMoWD5jzgxeAKxfYXwq0CtNOGpKs7CRZ4qUAigqsBADSnkYxaGAg
 ZWlcmwh8w76ijmcRIwAWocS7pUljMiQs50fwysG2prO5qS3AQCrS+muFPHzyDZBW819e
 38KuzTrb5SbgVSjaOO1KoazUzDJRPHTAWiKOO2RysCm32HKWX5m+8xe3yXgkMlBKn82M
 kLwp/gYl6khAO1ag/q3rA60RAXX5B7HyxArk4rFaXJ97nkWvfCiWOSlCNfdLhenMxB9t
 tUgSN9t4GEVwuoEIQBpduHwPB8swvI7A1oOXninPL6PpTaxHsk6AWq1Y9kaevIJRTDmV
 2uUw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+eENqET+DBqU6KZeR6ybWW00tttcUV9BTb8vC74ooPmh3Z65gYnJAYKW/umEaGesGroZngzVk=@lists.denx.de
X-Gm-Message-State: AOJu0Yz2EvuCF3MS7xZXe42gZcV3ekg7sRTE2HGs3Eo2OF1HRmw/Aonl
 1rWOW10s27KIDB0wOGaAy2LT7amcPtosBLF0TpyDf38YxNiv74kLa1moAo7g2PgN12s=
X-Gm-Gg: AfdE7cl4/5AiBoTRmoYQydnsEQ9eJVqcYG6qChDWEt6JAW8U1Vu9MP+Dq6KYq36pkdZ
 tqPr0zfADaXG3IAwBWiLHRH9AllbrLBSPf0j9HeTrbF852iGjt5NUJzAfTUNk29GaG+tYazGLby
 IXy234iUGyltWTSfxGv5oqIeKqvo1cCtWQyxVk+1+YqzE/POlAD1U+zeR7yLFPDXyr5M681/aQr
 zqQFZC+Sb26E1nkQ9ip1trvepcpUtSxyEUiJohiL3oHq8Q7G8IUzhfvP1rM+rOpo12JSyxTM+kY
 TV23OmHt08eZ6/rdoIh9wuGb5/ESTbuircJglQFtadJ7uZq6OmOvEsDDQ+c8w5Nt2a68Hxey6fX
 eN3u1KonVkH8K0e5Vr6KEX2JOJkLXZ2qhSZ3Z6XX5fhCYf35pU/eLfKkJPx0zYPO6rEfKs4Vv3y
 rhkRaP1V2cktRtdasiOFdsS5bmzlbqhyZaS1SEbt2nAmbVgxmAGnrcLRGdBhOW4MEvLuRDSuM3h
 9Nm5+/os2MMA53K/HPcgkAFxLGGuGIQcNadYQ==
X-Received: by 2002:a05:6830:710c:b0:7e1:cbe3:bb1b with SMTP id
 46e09a7af769-7eb7f9ab812mr2714882a34.0.1783184028641; 
 Sat, 04 Jul 2026 09:53:48 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7eb54292d77sm7208732a34.1.2026.07.04.09.53.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2026 09:53:47 -0700 (PDT)
Date: Sat, 4 Jul 2026 10:53:45 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Carlo Caione <ccaione@baylibre.com>, u-boot@lists.denx.de,
 ilias.apalodimas@linaro.org
Subject: Re: [PATCH] efi_loader: stop watchdog devices in ExitBootServices()
Message-ID: <20260704165345.GM749385@bill-the-cat>
References: <20260704135258.68543-1-ccaione@baylibre.com>
 <20260704143251.GK749385@bill-the-cat>
 <590BC3A7-BA5D-4346-8757-5379EFFFEFBE@baylibre.com>
 <20260704161707.GL749385@bill-the-cat>
 <3167C65C-B0F5-42F1-BB51-3CD64F3CFE83@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="E9Zag/bnP32izOk8"
Content-Disposition: inline
In-Reply-To: <3167C65C-B0F5-42F1-BB51-3CD64F3CFE83@gmx.de>
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


--E9Zag/bnP32izOk8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 04, 2026 at 06:46:50PM +0200, Heinrich Schuchardt wrote:
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
> Nothing wrong with the spec. Some hardware engineers simply don't read it=
 and create watchdog timers that cannot be set to a 5 min timeout.

Maybe 5 minutes is acceptable in some use cases. It's certainly not in
others. The spec needs to be updated to reflect the reality of
industries that people are pushing to use UEFI in. And then operating
systems need to reflect that a watchdog is not some niche device for
arm64 but something virtually every platform has and that it must be
serviced ASAP.

--=20
Tom

--E9Zag/bnP32izOk8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCakk6lQAKCRAr4qD1Cr/k
CibtAQCq8s308xgcRweYIJfh5hgPYHJKG4oWMyljGSP8ubiPDQEAs7YnFUnI8LPb
q5Ull4psequIXHgUifYqKnbjcKBDcwg=
=tVPP
-----END PGP SIGNATURE-----

--E9Zag/bnP32izOk8--
