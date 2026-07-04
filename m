Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07778C43458
	for <u-boot@archiver.kernel.org>; Sat,  4 Jul 2026 14:33:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 294FD83FEE;
	Sat,  4 Jul 2026 16:32:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Sxq4uUKM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2EB0841F2; Sat,  4 Jul 2026 16:32:57 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6C1F8341A
 for <u-boot@lists.denx.de>; Sat,  4 Jul 2026 16:32:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7eb29ed2bbdso380287a34.2
 for <u-boot@lists.denx.de>; Sat, 04 Jul 2026 07:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783175574; x=1783780374; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=i9Ucu9fE9HjWhyusrjtxZccP5+EdOcAcd6pilCOC5ys=;
 b=Sxq4uUKMU9BbakWVx5uEhTmDmuDsvKCkBHSXuFdrNAycbEUHTprpxnnU+QcAOK8oXf
 uT4KMqQ8tjM/JxQAbHfy25sZU2Hv+TlVXQCAfXQFkNNdOGb0c+SNJn/d8Se9UY7yUbL2
 PwPI6517atR0eZB8DGQfM8f/mmoEVV8mFQaJ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783175574; x=1783780374;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i9Ucu9fE9HjWhyusrjtxZccP5+EdOcAcd6pilCOC5ys=;
 b=HKP2nfejBF/VoZD3bzvcFBfwFRGnhyEKAv/oSerxdZE5/ylIFRmS3fp19/sn25KNKR
 UQfPLzPFjNHZBjdTT4J/c7rViuWSI9nkLwnU4wqmBY4xHHaNHhsy6MHApE7jiByTTAy4
 Z1xumm+yoyye7bTr0jgoNVib5V5Y6nFVMYij+iytZgGOKI1u7MdmHWnP1LWSxVzhcMO5
 5ofbnfZLNMM4J5TtoVaybucPsE1fLrprs1W4M1T3J588NSb/9oOXDwOhN4YdMtBeEY/y
 bhm0lz/DfMt6zg3le+jMcaJtpZnoq2sW/bty4zae4r0yX9ebHJpJbtiSuqYbMDOxf2Qf
 alDw==
X-Gm-Message-State: AOJu0Ywldu05O1Vef3WANep/GG/dIi2S+2kV6mXl+f2WOETNnZOPUMvk
 PIUXjwglCsxIEC3sbCNdeOmLLfSXE4SORO7exlknZqocBUYXQF3iDybfCQU0LAOLytA=
X-Gm-Gg: AfdE7cnJLfBvKGpBDoMx3KKqmunh1ASyJPqyYo/QUdrVJrJ80TEwypXtQNWTSwp0AnI
 PQk21huQQ6jpgwnLMJvPEvfgCUTHIgVlDGcf0/sRx6fbxPmkc+gYsu2U4KyXKgrPqMofW95e1E6
 uyVDNNec921vd6RzHhlXRVEpADHMyf/WJisEWvoaE6a2czbwFazYdVnehBFet0St5I8JuD+EUcx
 DsvdLfosjck/EDEGcS+gyv6zB+dU+u3xUaGc4macjWwk0Yvujuww7/cceS7Zn7ozRowwBsql2wb
 vDN9QTUS8tPLGSwWVVN6+pI7jSdiiINY3CRVu3NKzGlCHNo6uDtwU2ETsrK+lfTcBHys1Y5hBt9
 +ZoVzMAAnrKZA9mFmmmMBoVY2lOGlnh5VA8i4RCymlukSNIlpIFF9qFIp+66jUp9CHNdx8aXESC
 YKnq5BI1b7Wv1I612hG94ekdg/23bwoteADaARdAXSzhsoMiB7kn+rnQ1jxuOvbqPO8cz7QU6Ey
 kLA0o42K+AxXavzP9ojrawjdCf1owH2lLJLMQ==
X-Received: by 2002:a05:6830:2907:b0:7e9:c556:7bec with SMTP id
 46e09a7af769-7eb7fd8daf6mr1853296a34.10.1783175574407; 
 Sat, 04 Jul 2026 07:32:54 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7eb54500193sm7335079a34.24.2026.07.04.07.32.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2026 07:32:53 -0700 (PDT)
Date: Sat, 4 Jul 2026 08:32:51 -0600
From: Tom Rini <trini@konsulko.com>
To: Carlo Caione <ccaione@baylibre.com>
Cc: u-boot@lists.denx.de, xypron.glpk@gmx.de, ilias.apalodimas@linaro.org
Subject: Re: [PATCH] efi_loader: stop watchdog devices in ExitBootServices()
Message-ID: <20260704143251.GK749385@bill-the-cat>
References: <20260704135258.68543-1-ccaione@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mtvHuH55AWCBClM5"
Content-Disposition: inline
In-Reply-To: <20260704135258.68543-1-ccaione@baylibre.com>
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


--mtvHuH55AWCBClM5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 04, 2026 at 03:52:29PM +0200, Carlo Caione wrote:

> U-Boot can autonomously start a hardware watchdog
> (CONFIG_WATCHDOG_AUTOSTART, default y) and service it from its main
> loop, but the EFI boot path never stops it: efi_exit_boot_services()
> tears the devices down without calling wdt_stop_all(), and a watchdog
> driver without a .remove hook leaves the hardware ticking across the
> firmware-to-OS handoff.
>=20
> An EFI-booted OS that does not take over the SoC watchdog within the
> remaining timeout is reset mid-boot at a wall-clock-dependent point.
>=20
> The UEFI specification (v2.11, section 7.5 "Miscellaneous Boot
> Services", EFI_BOOT_SERVICES.SetWatchdogTimer()) is explicit about the
> one watchdog it allows across the handoff:
>=20
>   "The watchdog timer is only used during boot services. On
>    successful completion of EFI_BOOT_SERVICES.ExitBootServices() the
>    watchdog timer is disabled."
>=20
> U-Boot's UEFI watchdog (an EFI timer event) complies by construction. A
> platform watchdog silently surviving the handoff defeats the purpose of
> that rule: the OS has no generic way to know it is running, let alone to
> service it.
>=20
> Stop all watchdog devices in efi_exit_boot_services(), before the device
> teardown.
>=20
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>

NAK. We have had this come up before, and in short, the UEFI
specification needs to be fixed here, as generally speaking a watchdog
should never be stopped, as that leaves a gap where the system can hang
and thus defeat the point of having enabled a watchdog.

--=20
Tom

--mtvHuH55AWCBClM5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCakkZjwAKCRAr4qD1Cr/k
Cl40AQD0NG7kPP1mCZ9eGOX2JmRzvteZeVBZYBCc8wvSQU20kQEA1N/fJlWrV2v3
mqe4eWx9BJbhPoM1y+Sf1YQywq+ubQI=
=YkHR
-----END PGP SIGNATURE-----

--mtvHuH55AWCBClM5--
