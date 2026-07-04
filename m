Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D98FC43458
	for <u-boot@archiver.kernel.org>; Sat,  4 Jul 2026 15:53:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DCC683FEE;
	Sat,  4 Jul 2026 17:53:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="O8uXog5H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C90F841F2; Sat,  4 Jul 2026 17:53:30 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53D098341A
 for <u-boot@lists.denx.de>; Sat,  4 Jul 2026 17:53:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 7efb63cc-77c0-11f1-9e8e-005056999439
Received: from smtp.kpnmail.nl (unknown [10.31.155.6])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 7efb63cc-77c0-11f1-9e8e-005056999439;
 Sat, 04 Jul 2026 17:53:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=PTlYq6Hjmw8aNZyvfo0lc+fr9Q5qZdKjOAQMnTtyHzo=;
 b=O8uXog5HRaLZDvcs0TqnLr+qFWaacl5b8QiR0Py+FZHhZUNOpIMtu5knZAQru4b85tvvPM9qakb/q
 5eCwEI9gVMQBonw5GhHmbVahbE3aVLvV1wb+5LsquoKt4Gbr9YT3DdBB6/+xcbP+TWT1ku6XddlSIP
 y/i1feKtDGMfVdFiK1K3JFvs1j/jOd2EPmkkwWzY1akWTsnCGtIHZwFyySqCriykbaMnEQ/MLW6Q61
 xyhRduJHYm0t36FzymtWN9rwfR9LSkJgQwCgh0BWc/ZXRo9uqL+QvP5XZMOkVJAQ5kALZB1HwEFbWY
 U8iwAFVoAwzgrdHXqgVRHe/cfjuaAFA==
X-KPN-MID: 33|6RxPjrsBFXITfFnlxdujUjD8EhHIAOqrhf9pr6oh3BhTLm9dqsf8dlWHuRuXUia
 ed1/3nI9H4/WiGBrsjpOqnfdiQEHjSe3ElGo8jgqnjp0=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|kx/h5d+mZaPyOoKirbUhM2S6SoWA3DZ57+7GINboNma5jd59xReT4CQ1N06xULl
 +E9zxw0M5vqj+Rc7qFnTZeQ==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 7e8d4bc8-77c0-11f1-a77e-00505699772e;
 Sat, 04 Jul 2026 17:53:27 +0200 (CEST)
Date: Sat, 04 Jul 2026 17:53:26 +0200
Message-Id: <87h5mevjih.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Carlo Caione <ccaione@baylibre.com>
Cc: trini@konsulko.com, u-boot@lists.denx.de, xypron.glpk@gmx.de,
 ilias.apalodimas@linaro.org
In-Reply-To: <590BC3A7-BA5D-4346-8757-5379EFFFEFBE@baylibre.com> (message from
 Carlo Caione on Sat, 4 Jul 2026 17:21:25 +0200)
Subject: Re: [PATCH] efi_loader: stop watchdog devices in ExitBootServices()
References: <20260704135258.68543-1-ccaione@baylibre.com>
 <20260704143251.GK749385@bill-the-cat>
 <590BC3A7-BA5D-4346-8757-5379EFFFEFBE@baylibre.com>
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

> From: Carlo Caione <ccaione@baylibre.com>
> Date: Sat, 4 Jul 2026 17:21:25 +0200
> 
> > On 4 Jul 2026, at 16:32, Tom Rini <trini@konsulko.com> wrote:
> > 
> > On Sat, Jul 04, 2026 at 03:52:29PM +0200, Carlo Caione wrote:
> > 
> >> U-Boot can autonomously start a hardware watchdog
> >> (CONFIG_WATCHDOG_AUTOSTART, default y) and service it from its main
> >> loop, but the EFI boot path never stops it: efi_exit_boot_services()
> >> tears the devices down without calling wdt_stop_all(), and a watchdog
> >> driver without a .remove hook leaves the hardware ticking across the
> >> firmware-to-OS handoff.
> >> 
> >> An EFI-booted OS that does not take over the SoC watchdog within the
> >> remaining timeout is reset mid-boot at a wall-clock-dependent point.
> >> 
> >> The UEFI specification (v2.11, section 7.5 "Miscellaneous Boot
> >> Services", EFI_BOOT_SERVICES.SetWatchdogTimer()) is explicit about the
> >> one watchdog it allows across the handoff:
> >> 
> >>  "The watchdog timer is only used during boot services. On
> >>   successful completion of EFI_BOOT_SERVICES.ExitBootServices() the
> >>   watchdog timer is disabled."
> >> 
> >> U-Boot's UEFI watchdog (an EFI timer event) complies by construction. A
> >> platform watchdog silently surviving the handoff defeats the purpose of
> >> that rule: the OS has no generic way to know it is running, let alone to
> >> service it.
> >> 
> >> Stop all watchdog devices in efi_exit_boot_services(), before the device
> >> teardown.
> >> 
> >> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
> > 
> > NAK. We have had this come up before, and in short, the UEFI
> > specification needs to be fixed here, as generally speaking a watchdog
> > should never be stopped, as that leaves a gap where the system can hang
> > and thus defeat the point of having enabled a watchdog.
> 
> 
> Fair enough.
> 
> For the record, the failure that motivated this: a pristine Ubuntu
> 26.04 arm64 image on a MediaTek Genio 700 EVK dies silently about 60
> seconds after ExitBootServices(), 100% reproducible, at a wall-clock
> dependent point. The generic kernel ships the watchdog driver as a
> module, so nothing services the watchdog in time, and nothing tells
> the OS that it is running.

The OS should probably assume that the watchdog timer is running.  So
the watchdog timer drivers should probably be built in.  Or at least
they should be present on initrd.  If 60 seconds isn't good enough,
you could look into extending the watchdog timeout (but the hardware
might no support that).

> In the meantime, is the accepted pattern hooking up a wdt_stop_all()
> in the EFI path via board_quiesce_devices()? That keeps the watchdog
> armed for the whole firmware lifetime and makes the handoff
> behaviour the board maintainer's call.

But it would make it impossible for users that want the watchdog
enabled across the handover to use the EFI boot path.

If you really can't fix the OS, the more-or-less accepted pattern
would be to disable CONFIG_WATCHDOG_AUTOSTART.  That at least allows
users that want the watchdog to remain active to enable the watchdog
through a u-boot script.
