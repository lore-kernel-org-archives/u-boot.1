Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32C02C43458
	for <u-boot@archiver.kernel.org>; Sat,  4 Jul 2026 16:17:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5140C83FEE;
	Sat,  4 Jul 2026 18:17:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fBUPpUVQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46142841F2; Sat,  4 Jul 2026 18:17:14 +0200 (CEST)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12BA48341A
 for <u-boot@lists.denx.de>; Sat,  4 Jul 2026 18:17:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-6a166742b44so1102774eaf.2
 for <u-boot@lists.denx.de>; Sat, 04 Jul 2026 09:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783181831; x=1783786631; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0E/62gPWYPheCpQS+DVIe5yIRPX+s1MdqnZdAN5KXZM=;
 b=fBUPpUVQxlEKTmmE2LNGnl7i4LgU+6kX/ykgX0bZTx1zGsvoGqKGwHSlmFYyOLwu5z
 zuSt6HEcEm2n1UQ3kupJoNjwmZ90CuBPYd1t+jMWm4kI1QHwaKbJPFp0tblT3MJ6HvcM
 BKHXl5F/rFM8xQfahqUBY6ZusBX6mhFim67Dg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783181831; x=1783786631;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0E/62gPWYPheCpQS+DVIe5yIRPX+s1MdqnZdAN5KXZM=;
 b=sp/uASb6C+7lHUOvQRjA7QkasAF61lwnq/Zu0zeANjzABPu3U86AdkJl8CpRv95qF+
 b2lTUzQfXT1xSvMSj7yPaWbrCzFDquUHuGZIFKVby298S+KvXbL8HIr3b7iuhRMKjIbv
 w+paaIDCxNKAb5Fqpe60NnENQLoLmVjIvtzjDBtxnwphfh8ImLRxRK4cIzmbjVD0xbSP
 4v3a3tVypj+75yhRwqiW+FCII3GbMGzM+DMEW+ufMxs80iiagU8CjWoFl1vNNT4Uqcrb
 vqkvDc+n7jQp+vZd8Iz/2iwVkvlvFd+ui3kapdF/thibR7knkJi4loHJhnvZdyyp8/8+
 Q8/Q==
X-Gm-Message-State: AOJu0YyOg9DdN6kozOM0SqRLVLEnthUgMqpb+4DY8k/2GlEfwZelWLpY
 0suiOk98qICpJxhtNZtp2I21h4fKWZWNqvVhbjMF5UnYowDu+LBLGP7CTODO1XinCtPHwx9B3j5
 ZyEvJskM=
X-Gm-Gg: AfdE7cnEVbGxRGZZAHncLaQqFHzGu1RkgNQpiBMhHsmhxRSkipCyeygPxlB3WEbyIT7
 Cf2bWyQu3Qd3hkdxBr1LPtxn96b4vHDVxnuZi2c5iOx1oUCaWQaTA3jifp8jQ7Rx003Bb6QlWtb
 /Pe7gFnRFPX1DdyLsA9tRGrFo3PG7xulc/Cc6rCyvDmWbZ+WXcqe+Fn5yiHR7b2usWYZUodvyp7
 xy+uhqwaT3/HGS61qAxe5v6fpOgygZoHEB+0yNkT6OdZNnZz0n2CyA/P1Lyg2YbQNcVg2O4wobO
 hLA9rO5lKkHTkmj2I2YIhC9qcDOQftejqt+rfIT38RUQPGRGlIsVFVygEyvSoPufBxnoEJj+5Dx
 ZGMQkqSJLQuosjhDTI/VPhzuZODzJqY7hQ0HpalVt12KF6lM23O4Gk31zAXlu3Jzltt5UR4TnJl
 P84zui0XpZGBpOGnLOP8OrskVPCaYZ5+9eUJxRXQCIUfO2UV1MlrEU7fEZMpNpLqpB/sJ26etKh
 e2o7dmOVZ1I9Wj5WZtdLNVbD/Odv8yqDN9NoQ==
X-Received: by 2002:a05:6820:1689:b0:6a3:c64:167b with SMTP id
 006d021491bc7-6a32f57fb70mr2023195eaf.57.1783181830723; 
 Sat, 04 Jul 2026 09:17:10 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a310375f67sm5901157eaf.9.2026.07.04.09.17.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2026 09:17:09 -0700 (PDT)
Date: Sat, 4 Jul 2026 10:17:07 -0600
From: Tom Rini <trini@konsulko.com>
To: Carlo Caione <ccaione@baylibre.com>
Cc: u-boot@lists.denx.de, xypron.glpk@gmx.de, ilias.apalodimas@linaro.org
Subject: Re: [PATCH] efi_loader: stop watchdog devices in ExitBootServices()
Message-ID: <20260704161707.GL749385@bill-the-cat>
References: <20260704135258.68543-1-ccaione@baylibre.com>
 <20260704143251.GK749385@bill-the-cat>
 <590BC3A7-BA5D-4346-8757-5379EFFFEFBE@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="cEqyM+WnBan8RKBo"
Content-Disposition: inline
In-Reply-To: <590BC3A7-BA5D-4346-8757-5379EFFFEFBE@baylibre.com>
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


--cEqyM+WnBan8RKBo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 04, 2026 at 05:21:25PM +0200, Carlo Caione wrote:
>=20
>=20
> > On 4 Jul 2026, at 16:32, Tom Rini <trini@konsulko.com> wrote:
> >=20
> > On Sat, Jul 04, 2026 at 03:52:29PM +0200, Carlo Caione wrote:
> >=20
> >> U-Boot can autonomously start a hardware watchdog
> >> (CONFIG_WATCHDOG_AUTOSTART, default y) and service it from its main
> >> loop, but the EFI boot path never stops it: efi_exit_boot_services()
> >> tears the devices down without calling wdt_stop_all(), and a watchdog
> >> driver without a .remove hook leaves the hardware ticking across the
> >> firmware-to-OS handoff.
> >>=20
> >> An EFI-booted OS that does not take over the SoC watchdog within the
> >> remaining timeout is reset mid-boot at a wall-clock-dependent point.
> >>=20
> >> The UEFI specification (v2.11, section 7.5 "Miscellaneous Boot
> >> Services", EFI_BOOT_SERVICES.SetWatchdogTimer()) is explicit about the
> >> one watchdog it allows across the handoff:
> >>=20
> >>  "The watchdog timer is only used during boot services. On
> >>   successful completion of EFI_BOOT_SERVICES.ExitBootServices() the
> >>   watchdog timer is disabled."
> >>=20
> >> U-Boot's UEFI watchdog (an EFI timer event) complies by construction. A
> >> platform watchdog silently surviving the handoff defeats the purpose of
> >> that rule: the OS has no generic way to know it is running, let alone =
to
> >> service it.
> >>=20
> >> Stop all watchdog devices in efi_exit_boot_services(), before the devi=
ce
> >> teardown.
> >>=20
> >> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
> >=20
> > NAK. We have had this come up before, and in short, the UEFI
> > specification needs to be fixed here, as generally speaking a watchdog
> > should never be stopped, as that leaves a gap where the system can hang
> > and thus defeat the point of having enabled a watchdog.
>=20
>=20
> Fair enough.
>=20
> For the record, the failure that motivated this: a pristine Ubuntu 26.04 =
arm64 image on a MediaTek Genio 700 EVK dies silently about 60 seconds afte=
r ExitBootServices(), 100% reproducible, at a wall-clock dependent point. T=
he generic kernel ships the watchdog driver as a module, so nothing service=
s the watchdog in time, and nothing tells the OS that it is running. From t=
he user's side this is indistinguishable from broken firmware.
>=20
> In the meantime, is the accepted pattern hooking up a wdt_stop_all() in t=
he EFI path via board_quiesce_devices()? That keeps the watchdog armed for =
the whole firmware lifetime and makes the handoff behaviour the board maint=
ainer's call.

No, Ubuntu needs to fix their kernel image to have the watchdog
available early. I hate to be difficult on this, but it's been a known
issue for years at this point that the spec needs to be updated. The
workaround here is for the watchdog to not be started until the OS is
ready to maintain it.

--=20
Tom

--cEqyM+WnBan8RKBo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCakkx/wAKCRAr4qD1Cr/k
CsTcAQCt2MBF3FdSFxkES2nzF/mS6uB9UHsOcSU3e1+BI6rW3gD7BliTNT6Xv/jp
75KHVrPJsNyhtVIubUO37031pWrMgwQ=
=dM5J
-----END PGP SIGNATURE-----

--cEqyM+WnBan8RKBo--
