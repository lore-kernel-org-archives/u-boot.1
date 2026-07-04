Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC6EAC43458
	for <u-boot@archiver.kernel.org>; Sat,  4 Jul 2026 15:21:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F409283FEE;
	Sat,  4 Jul 2026 17:21:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="B8xZ0wxB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDFF8841F2; Sat,  4 Jul 2026 17:21:41 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D2D48341A
 for <u-boot@lists.denx.de>; Sat,  4 Jul 2026 17:21:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ccaione@baylibre.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-8f0079614b2so16009566d6.1
 for <u-boot@lists.denx.de>; Sat, 04 Jul 2026 08:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783178498; x=1783783298; darn=lists.denx.de;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7MLTduXqKI0X4OVCK8FwCP3r/UqZUs8RWHfCbQ699OE=;
 b=B8xZ0wxByOQqTFNCh0FYUla9jrbuslp/eeddMO2UvXzDK0dD9N9S8tZj3y4bB1MLQL
 iegOIY/m+qDxqTWvqB4A4iiXfsHbmPhuYKFPJ3IxFYqLRXaHjLvvgY/qEoADGBQOaH2z
 w8R+F/dnS8MU41HVHL5DYBCm45muCPrMU+gpifIzt49W/1QlnJhFm/lU0Wzmn2lgmGHm
 i4P9FpmiUkUSgwkjOVJpCHfaSJtqIKS5NDgtevs/4wanJr68F6+xA0xkc9213UVpI06T
 k15bxHrSCdimrbnQBTO2Tj2y6M+KTLco1YMn1wMcvf2tVKudY+IxNhCEvFvYV0yrhzUG
 ygrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783178498; x=1783783298;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7MLTduXqKI0X4OVCK8FwCP3r/UqZUs8RWHfCbQ699OE=;
 b=nsQMpMZKshV0dcWLMDSfArWtXp8nZvmAtkQAeLieJi5qPwZSr/6fQ5J17uNCTGIWrs
 7l4ohcZlt+UvAAhSf+oyeY/YxlGZv0rJXOFdctGYoNEEQYgQ/RqyMi9uaxrvXAgCenOz
 1L7EWlzxryoLcUtvoDBUEM9bxewDJkZxK8K8Tc5MKUVUzh1Z2hdJx5PpCXIZE+Ni8cuT
 43o0epjoZtLAfF0bXGtH93XMlzxQp7sIwg4dSHAfFOgAi1eIuCJhGkxCefc0CVucVPsW
 8EDfLAbOAvopwHyAjUvYWnNelyZZSNTEDfJJSAa6/IQ9PPVx/TU+qI6Bo21yRKsh9FZW
 6jLA==
X-Gm-Message-State: AOJu0YzR+fZA4222gjOqDXP5b/91SrXdBerb5Yo+hEuUWYy15zTZ5vsd
 r0iY7f8nVGwybO9+LjCoSwuWknL4FKMJ1L9cfbFXqE1eqPEyLrGUbinjYxgSO0XSacXhZKL7fOv
 NQqv6sbu8F1DR
X-Gm-Gg: AfdE7cm25RmQa9fHoli+VtRE2jzLBbfK2afqExq1RzRAQNjdOToyjfCK7E3OVicdLee
 e+c6OsOGgYRCuK/mg7pNfqaUhcLclr69Mf7YFjAaCxfXR10JYrsgzpKMFyMvUrs1nHU3iH6ybIQ
 amEUzBjwvVOuPl0MKaP1C68FVrUBMtibNKU/FMMA1kKFCEr0rc8iIoVNy8EAWFwzfP72LTRSTsY
 tiRCCxiqW4tlshTkCHyaIxGNkSHmaYZ7A1rI1IC7c+9ga3iG27y611E+sCnOLYgoBCunw/DlSyP
 0P2J/YVYbDd+/W+E3MdKcrScH+tsVMqPuTWuBQJs7dZPbSv+HuooNwVNDO6/aozVHGVs9wBHkKG
 rfdhyUOB8pNLUfss1UiUXx8D6JC7UeTEZ/+uD1N2XX5+35TLZVA3vFN4coWXJi465CIHltxTQDO
 G1/1m9dELZM+UOtbT0a0SJOkp/vVyIXXtNH3s=
X-Received: by 2002:ad4:5baf:0:b0:8ea:1b3:ff5f with SMTP id
 6a1803df08f44-8f74a519157mr56890926d6.21.1783178498283; 
 Sat, 04 Jul 2026 08:21:38 -0700 (PDT)
Received: from smtpclient.apple ([45.144.113.217])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8f46f20f565sm85666116d6.19.2026.07.04.08.21.36
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 04 Jul 2026 08:21:37 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH] efi_loader: stop watchdog devices in ExitBootServices()
From: Carlo Caione <ccaione@baylibre.com>
In-Reply-To: <20260704143251.GK749385@bill-the-cat>
Date: Sat, 4 Jul 2026 17:21:25 +0200
Cc: u-boot@lists.denx.de,
 xypron.glpk@gmx.de,
 ilias.apalodimas@linaro.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <590BC3A7-BA5D-4346-8757-5379EFFFEFBE@baylibre.com>
References: <20260704135258.68543-1-ccaione@baylibre.com>
 <20260704143251.GK749385@bill-the-cat>
To: Tom Rini <trini@konsulko.com>
X-Mailer: Apple Mail (2.3864.600.51.1.1)
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



> On 4 Jul 2026, at 16:32, Tom Rini <trini@konsulko.com> wrote:
>=20
> On Sat, Jul 04, 2026 at 03:52:29PM +0200, Carlo Caione wrote:
>=20
>> U-Boot can autonomously start a hardware watchdog
>> (CONFIG_WATCHDOG_AUTOSTART, default y) and service it from its main
>> loop, but the EFI boot path never stops it: efi_exit_boot_services()
>> tears the devices down without calling wdt_stop_all(), and a watchdog
>> driver without a .remove hook leaves the hardware ticking across the
>> firmware-to-OS handoff.
>>=20
>> An EFI-booted OS that does not take over the SoC watchdog within the
>> remaining timeout is reset mid-boot at a wall-clock-dependent point.
>>=20
>> The UEFI specification (v2.11, section 7.5 "Miscellaneous Boot
>> Services", EFI_BOOT_SERVICES.SetWatchdogTimer()) is explicit about =
the
>> one watchdog it allows across the handoff:
>>=20
>>  "The watchdog timer is only used during boot services. On
>>   successful completion of EFI_BOOT_SERVICES.ExitBootServices() the
>>   watchdog timer is disabled."
>>=20
>> U-Boot's UEFI watchdog (an EFI timer event) complies by construction. =
A
>> platform watchdog silently surviving the handoff defeats the purpose =
of
>> that rule: the OS has no generic way to know it is running, let alone =
to
>> service it.
>>=20
>> Stop all watchdog devices in efi_exit_boot_services(), before the =
device
>> teardown.
>>=20
>> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
>=20
> NAK. We have had this come up before, and in short, the UEFI
> specification needs to be fixed here, as generally speaking a watchdog
> should never be stopped, as that leaves a gap where the system can =
hang
> and thus defeat the point of having enabled a watchdog.


Fair enough.

For the record, the failure that motivated this: a pristine Ubuntu 26.04 =
arm64 image on a MediaTek Genio 700 EVK dies silently about 60 seconds =
after ExitBootServices(), 100% reproducible, at a wall-clock dependent =
point. The generic kernel ships the watchdog driver as a module, so =
nothing services the watchdog in time, and nothing tells the OS that it =
is running. =46rom the user's side this is indistinguishable from broken =
firmware.

In the meantime, is the accepted pattern hooking up a wdt_stop_all() in =
the EFI path via board_quiesce_devices()? That keeps the watchdog armed =
for the whole firmware lifetime and makes the handoff behaviour the =
board maintainer's call.

Cheers,

=E2=80=94
Carlo Caione

