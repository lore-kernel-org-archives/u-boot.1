Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1790EC43458
	for <u-boot@archiver.kernel.org>; Sat,  4 Jul 2026 16:59:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 608A183FEE;
	Sat,  4 Jul 2026 18:59:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="WdcEJEh/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E74F384119; Sat,  4 Jul 2026 18:59:13 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF8A48341A
 for <u-boot@lists.denx.de>; Sat,  4 Jul 2026 18:59:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1783184351; x=1783789151; i=xypron.glpk@gmx.de;
 bh=3g6c4J+3qsID/P9i/5m0Y5+tQovvjoXSeOMoc5DvpVY=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=WdcEJEh/EdBAVEUHCL+a+RV8PghTenufy8g01BGkdVPD8XIFexuuNy5nZD0jCTQH
 I1Ei5d221iJzhBA36jGS+RLxJa+4mAqnmh9X5RrLOFjoeUxVIrhhgmfD/GqJuJU48
 boFxYP+B/LD5W3gngnHBCiOPEakxKB12kc5hN1tMqQCC15pmfzhjJGQfBMb6Lqpjv
 5vdL1cXc2AXKdw3RlBXnX3tyQPRSG6T6+rlCv9WHwwtINOwuOmKVkzPqJ/8yhXmmP
 eq6KDX3IDb1SnzQM1lTuw8RvlNrJwEDnPBVJYt/SsJ1OdgkNR/C0vNIxYnbll87h2
 SQcoFcdZQNgUyVuqxg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MfHAB-1xHq5t2XH9-00dxWX; Sat, 04
 Jul 2026 18:59:10 +0200
Date: Sat, 04 Jul 2026 18:59:08 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Tom Rini <trini@konsulko.com>, Carlo Caione <ccaione@baylibre.com>
CC: u-boot@lists.denx.de, ilias.apalodimas@linaro.org
Subject: Re: [PATCH] efi_loader: stop watchdog devices in ExitBootServices()
User-Agent: Thunderbird for Android
In-Reply-To: <20260704161707.GL749385@bill-the-cat>
References: <20260704135258.68543-1-ccaione@baylibre.com>
 <20260704143251.GK749385@bill-the-cat>
 <590BC3A7-BA5D-4346-8757-5379EFFFEFBE@baylibre.com>
 <20260704161707.GL749385@bill-the-cat>
Message-ID: <B60962BD-B25D-40CA-B06D-43A09EF076CC@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:c/FEZki8o3PxPWIod3WoIH/+rB9u+QSyVAEtvhT58fAlzvsqYjT
 4nbXK6odGo8hbYjK8xEC1Nb4k5nEJMNbr/0nV8Y+vug5kkNuoC2WIBYjp3g1j21Nlx4n5U6
 kpE5daftICo8X0hgQ8vVlOHr3baG6Q0sPrDFeTLBhpN8ebzxT8U2hFWt7bHKatuNecjviKf
 S3ENqT8d3e0KdwVMSFrkA==
UI-OutboundReport: notjunk:1;M01:P0:WpXZ9en9k1s=;xhvB3hctGxzzjUEbMg8QZYkULnZ
 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
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

Am 4=2E Juli 2026 18:17:07 MESZ schrieb Tom Rini <trini@konsulko=2Ecom>:
>On Sat, Jul 04, 2026 at 05:21:25PM +0200, Carlo Caione wrote:
>>=20
>>=20
>> > On 4 Jul 2026, at 16:32, Tom Rini <trini@konsulko=2Ecom> wrote:
>> >=20
>> > On Sat, Jul 04, 2026 at 03:52:29PM +0200, Carlo Caione wrote:
>> >=20
>> >> U-Boot can autonomously start a hardware watchdog
>> >> (CONFIG_WATCHDOG_AUTOSTART, default y) and service it from its main
>> >> loop, but the EFI boot path never stops it: efi_exit_boot_services()
>> >> tears the devices down without calling wdt_stop_all(), and a watchdo=
g
>> >> driver without a =2Eremove hook leaves the hardware ticking across t=
he
>> >> firmware-to-OS handoff=2E
>> >>=20
>> >> An EFI-booted OS that does not take over the SoC watchdog within the
>> >> remaining timeout is reset mid-boot at a wall-clock-dependent point=
=2E
>> >>=20
>> >> The UEFI specification (v2=2E11, section 7=2E5 "Miscellaneous Boot
>> >> Services", EFI_BOOT_SERVICES=2ESetWatchdogTimer()) is explicit about=
 the
>> >> one watchdog it allows across the handoff:
>> >>=20
>> >>  "The watchdog timer is only used during boot services=2E On
>> >>   successful completion of EFI_BOOT_SERVICES=2EExitBootServices() th=
e
>> >>   watchdog timer is disabled=2E"
>> >>=20
>> >> U-Boot's UEFI watchdog (an EFI timer event) complies by construction=
=2E A
>> >> platform watchdog silently surviving the handoff defeats the purpose=
 of
>> >> that rule: the OS has no generic way to know it is running, let alon=
e to
>> >> service it=2E
>> >>=20
>> >> Stop all watchdog devices in efi_exit_boot_services(), before the de=
vice
>> >> teardown=2E
>> >>=20
>> >> Signed-off-by: Carlo Caione <ccaione@baylibre=2Ecom>
>> >=20
>> > NAK=2E We have had this come up before, and in short, the UEFI
>> > specification needs to be fixed here, as generally speaking a watchdo=
g
>> > should never be stopped, as that leaves a gap where the system can ha=
ng
>> > and thus defeat the point of having enabled a watchdog=2E
>>=20
>>=20
>> Fair enough=2E
>>=20
>> For the record, the failure that motivated this: a pristine Ubuntu 26=
=2E04 arm64 image on a MediaTek Genio 700 EVK dies silently about 60 second=
s after ExitBootServices(), 100% reproducible, at a wall-clock dependent po=
int=2E The generic kernel ships the watchdog driver as a module, so nothing=
 services the watchdog in time, and nothing tells the OS that it is running=
=2E From the user's side this is indistinguishable from broken firmware=2E
>>=20
>> In the meantime, is the accepted pattern hooking up a wdt_stop_all() in=
 the EFI path via board_quiesce_devices()? That keeps the watchdog armed fo=
r the whole firmware lifetime and makes the handoff behaviour the board mai=
ntainer's call=2E
>
>No, Ubuntu needs to fix their kernel image to have the watchdog
>available early=2E I hate to be difficult on this, but it's been a known
>issue for years at this point that the spec needs to be updated=2E The
>workaround here is for the watchdog to not be started until the OS is
>ready to maintain it=2E
>

Best open a Launchpad bug explaining why this watchdog driver needs to be =
built in and not a module=2E

Best regards

Heinrich

