Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 921ACC43602
	for <u-boot@archiver.kernel.org>; Sat,  4 Jul 2026 17:16:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A88483FEE;
	Sat,  4 Jul 2026 19:15:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UhFbaUb/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 640A18341A; Sat,  4 Jul 2026 19:15:58 +0200 (CEST)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 297A484671
 for <u-boot@lists.denx.de>; Sat,  4 Jul 2026 19:15:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-48d6c621a67so712201b6e.3
 for <u-boot@lists.denx.de>; Sat, 04 Jul 2026 10:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783185355; x=1783790155; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/zK8oyb/+lALcp6nSJwBhWl0uOnxmhLRP0wsPDChe4A=;
 b=UhFbaUb/ontwwZQ4ARkBiRzyohvsmlsrqHoYNv4D8tzcwYQfRck/xX9vEwVo9YMOJL
 zYXfpM1SHQtIaYMWcW27QcO08EDzjS3EiYbVyv6Smx2Fm7Oko+8R/WZY5TIDbEP1hz5C
 tdsAT6/o7tX9ICmVo820DsrbgIbjI7TczmCjY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783185355; x=1783790155;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/zK8oyb/+lALcp6nSJwBhWl0uOnxmhLRP0wsPDChe4A=;
 b=QHYWsDoBYpFXBNHC/gfa0Z7y6gL3QWKyuYBT/5JLjqtcQ9qZbJf1yQ2icMHAKduFmZ
 EvN+i+rLRcsh9aZb7YeSM8batwIJRbpkV0obh3fcSrM2Y2ope6q7UiwEjKtnBFfV6BeT
 SrZM+1ZyrZun3ULqins7NvGqkmn7HTlfYdQhbNzWFVmkfQlrA9AUdZxQCEwZE16rQa6K
 ZPV/sBHj/TdVkrKSA6Rs27tT4hwy/hsjeeDhuFTLfT7pWlJ9l99ctYwlWXaPx7U+CVjr
 LmbX0vm0/3weDlGdjRQ2yFd7Q15kl8Q7Bc4+rvT8JyuS6azY9NjXKLTTXoSOavWLiX9/
 50vg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9GH6wrJ8jCEye3bmcnqUa5Z4ytDzgB44lMygUnZkaMbdio5fyVzoBWjMMfMKILmOtDm9laKt0=@lists.denx.de
X-Gm-Message-State: AOJu0YxFNTjiPjDBnGLNgJCLPWXxqjhlT4OdC2bXl/hmkItsk/n+CsOR
 iHeH0TABoj49HtEJlAL3/jtmnmXPPUhn+xPaL4dStd62j49TLrmBV+yj/Ei6hS32Pw4=
X-Gm-Gg: AfdE7ck3B1M1cTzJ/OEBP34DX1FQwTgwSp2SOK2O2DgNXD8KqNrWN8DsHUTFGG28nUG
 VK9hfeuiAdbSlzX5IM5mN+CsXQkpUZeQFcYHTLP2FRLoejG5GLmnq+BtTULCtfLkHGm5jiJsMd4
 2dXnIxojnI9iz9saTA2NGdE5szzNO/tCDIXqiDlWY8dsClWzTEJ1iPGHuYg8EHrqTrrrBTVyLTi
 CHu6f0v5+NOOcd4RRhHXqcBA9ZVWbzP/Gl3ngumPA8gC7ybErC7BMA2lKqTWW57rxI1DbV2Uhe3
 anG9fh7z96edRcJyrSLY5sIDZHSrNMRQpxDUMyg2vRvXboo7XAZuuMoRymm+siTvoT7ObvJ/xyP
 FKiMubV0TpWhWv2tU/E/OzM8F3uKmnMp2OSLSxzlLsCuURCCU8ohn/VNFF9U25jKGrKUYsSlR8C
 neVjmfWDnCpqNSkNz4IlJSObX5jVX9B0dkguxbH0lKxCZ6UP66SY0+5VI/W80drJjM0VDn6wty0
 f8E99/e8ja9dPF6DiUyrBVj/275pNFu3hOydA==
X-Received: by 2002:a05:6808:1208:b0:489:f088:5f70 with SMTP id
 5614622812f47-499b6b48c6emr1929448b6e.12.1783185354799; 
 Sat, 04 Jul 2026 10:15:54 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-497d17d328bsm6568047b6e.4.2026.07.04.10.15.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2026 10:15:53 -0700 (PDT)
Date: Sat, 4 Jul 2026 11:15:51 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Carlo Caione <ccaione@baylibre.com>, u-boot@lists.denx.de,
 ilias.apalodimas@linaro.org
Subject: Re: [PATCH] efi_loader: stop watchdog devices in ExitBootServices()
Message-ID: <20260704171551.GO749385@bill-the-cat>
References: <20260704135258.68543-1-ccaione@baylibre.com>
 <20260704143251.GK749385@bill-the-cat>
 <590BC3A7-BA5D-4346-8757-5379EFFFEFBE@baylibre.com>
 <20260704161707.GL749385@bill-the-cat>
 <B60962BD-B25D-40CA-B06D-43A09EF076CC@gmx.de>
 <20260704171513.GN749385@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4NzM1I62iTm/tEwr"
Content-Disposition: inline
In-Reply-To: <20260704171513.GN749385@bill-the-cat>
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


--4NzM1I62iTm/tEwr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 04, 2026 at 11:15:13AM -0600, Tom Rini wrote:
> On Sat, Jul 04, 2026 at 06:59:08PM +0200, Heinrich Schuchardt wrote:
> > Am 4. Juli 2026 18:17:07 MESZ schrieb Tom Rini <trini@konsulko.com>:
> > >On Sat, Jul 04, 2026 at 05:21:25PM +0200, Carlo Caione wrote:
> > >>=20
> > >>=20
> > >> > On 4 Jul 2026, at 16:32, Tom Rini <trini@konsulko.com> wrote:
> > >> >=20
> > >> > On Sat, Jul 04, 2026 at 03:52:29PM +0200, Carlo Caione wrote:
> > >> >=20
> > >> >> U-Boot can autonomously start a hardware watchdog
> > >> >> (CONFIG_WATCHDOG_AUTOSTART, default y) and service it from its ma=
in
> > >> >> loop, but the EFI boot path never stops it: efi_exit_boot_service=
s()
> > >> >> tears the devices down without calling wdt_stop_all(), and a watc=
hdog
> > >> >> driver without a .remove hook leaves the hardware ticking across =
the
> > >> >> firmware-to-OS handoff.
> > >> >>=20
> > >> >> An EFI-booted OS that does not take over the SoC watchdog within =
the
> > >> >> remaining timeout is reset mid-boot at a wall-clock-dependent poi=
nt.
> > >> >>=20
> > >> >> The UEFI specification (v2.11, section 7.5 "Miscellaneous Boot
> > >> >> Services", EFI_BOOT_SERVICES.SetWatchdogTimer()) is explicit abou=
t the
> > >> >> one watchdog it allows across the handoff:
> > >> >>=20
> > >> >>  "The watchdog timer is only used during boot services. On
> > >> >>   successful completion of EFI_BOOT_SERVICES.ExitBootServices() t=
he
> > >> >>   watchdog timer is disabled."
> > >> >>=20
> > >> >> U-Boot's UEFI watchdog (an EFI timer event) complies by construct=
ion. A
> > >> >> platform watchdog silently surviving the handoff defeats the purp=
ose of
> > >> >> that rule: the OS has no generic way to know it is running, let a=
lone to
> > >> >> service it.
> > >> >>=20
> > >> >> Stop all watchdog devices in efi_exit_boot_services(), before the=
 device
> > >> >> teardown.
> > >> >>=20
> > >> >> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
> > >> >=20
> > >> > NAK. We have had this come up before, and in short, the UEFI
> > >> > specification needs to be fixed here, as generally speaking a watc=
hdog
> > >> > should never be stopped, as that leaves a gap where the system can=
 hang
> > >> > and thus defeat the point of having enabled a watchdog.
> > >>=20
> > >>=20
> > >> Fair enough.
> > >>=20
> > >> For the record, the failure that motivated this: a pristine Ubuntu 2=
6.04 arm64 image on a MediaTek Genio 700 EVK dies silently about 60 seconds=
 after ExitBootServices(), 100% reproducible, at a wall-clock dependent poi=
nt. The generic kernel ships the watchdog driver as a module, so nothing se=
rvices the watchdog in time, and nothing tells the OS that it is running. F=
rom the user's side this is indistinguishable from broken firmware.
> > >>=20
> > >> In the meantime, is the accepted pattern hooking up a wdt_stop_all()=
 in the EFI path via board_quiesce_devices()? That keeps the watchdog armed=
 for the whole firmware lifetime and makes the handoff behaviour the board =
maintainer's call.
> > >
> > >No, Ubuntu needs to fix their kernel image to have the watchdog
> > >available early. I hate to be difficult on this, but it's been a known
> > >issue for years at this point that the spec needs to be updated. The
> > >workaround here is for the watchdog to not be started until the OS is
> > >ready to maintain it.
> > >
> >=20
> > Best open a Launchpad bug explaining why this watchdog driver needs to =
be built in and not a module.
>=20
> I'll leave that to Carlos, and I would suggest digging out the mailing

=2E.. to Carlo, my apologies.

--=20
Tom

--4NzM1I62iTm/tEwr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCakk/xwAKCRAr4qD1Cr/k
CpxEAQCV6JqqQCjWSup5EM6m+e5pwz6qYi2PVIEqSI+494vXSgEArYx9C4JmBVvZ
U3vM70HjR4WUrfS+DGw92HWJcdgtnQY=
=GcgD
-----END PGP SIGNATURE-----

--4NzM1I62iTm/tEwr--
