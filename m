Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A132CC47258
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 23:06:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B08E987937;
	Thu, 18 Jan 2024 00:06:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=jens-maus.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=jens-maus.de header.i=@jens-maus.de header.b="SK0LUzwH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 761B287947; Thu, 18 Jan 2024 00:06:45 +0100 (CET)
Received: from mail.light-speed.de (mail.light-speed.de [85.214.38.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 540BD878B3
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 00:06:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=jens-maus.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mail@jens-maus.de
Received: from smtpclient.apple (unknown
 [IPv6:2a02:810a:8280:47aa:e899:36d0:b4e2:62cb])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.light-speed.de (Postfix) with ESMTPSA id EC3443D4865F;
 Thu, 18 Jan 2024 00:06:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jens-maus.de;
 s=mail; t=1705532803;
 bh=gkHagb+fchUb7xZVVojypHQLAnYNT8W/cDO22pFJ7bM=;
 h=Subject:From:In-Reply-To:Date:Cc:References:To;
 b=SK0LUzwH85xAEEgnKiXZlgD91zPsBuKvj1mfJX6VmgsWYkzhdYR70VTLp0hFNyZFw
 SwdIbuc9dZ/GrOsz/akzsOFwLR2uLOP3f/47sDjCAmmdJfd+wHgHDDs0DlXV3R678K
 yHtR3ZgEmsXunMNiUyJ/hDGxuk86wDACiixFzK+s=
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: [PATCH v4 0/6] rpi5: initial support
From: Jens Maus <mail@jens-maus.de>
In-Reply-To: <9AFD4C3E-E1B7-4EA7-8589-7060A2747732@suse.de>
Date: Thu, 18 Jan 2024 00:06:32 +0100
Cc: u-boot@lists.denx.de
Content-Transfer-Encoding: quoted-printable
Message-Id: <5C0A3CD4-2591-4266-B9CC-7EC38C6A88C3@jens-maus.de>
References: <BD4D4B77-9C54-4FD7-8EEF-A65E674E0747@jens-maus.de>
 <sfo77vzvmblyv5g5ek6uc6oxrf5n7dcp3vsw2g2lvfnnrlyaft@kc6s7vvspwvz>
 <4DCC64E0-F0E4-4AF6-8E81-62B156E81554@jens-maus.de>
 <2303FFA8-E2FA-4AA4-AE67-FF5E904D21DD@suse.de>
 <A796E025-0F6E-4FF7-BA4D-2F52CD763B4B@jens-maus.de>
 <9AFD4C3E-E1B7-4EA7-8589-7060A2747732@suse.de>
To: "Ivan T. Ivanov" <iivanov@suse.de>
X-Mailer: Apple Mail (2.3774.300.61.1.2)
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

Hi,

> Am 17.01.2024 um 17:45 schrieb Ivan T. Ivanov <iivanov@suse.de>:
>=20
> I have aarch64 based machine at hand running openSUSE,
> thus I am building U-boot =E2=80=9Cnatively=E2=80=9D, no =
cross-compiling.
>=20
> $ make rpi_arm64_defconfig
> $ make

> I just dumped latest Tumbleweed[1] to uSD card and copied
> u-boot.bin to EFI. I can see the HDMI output.

I actually just did that. Installed a fresh Tumbleweed on a microSD =
card, booted it up with a rpi4 and after installing all necessary build =
tools I applied your patches to u-boot 2024.01 sources, and then =
executed these two commands to let it compile a u-boot.bin file which I =
then put in /boot/efi to replace the u-boot.bin which is/was already =
there. Then I pulled the SD card and moved it over to the RaspberryPi5 =
in trying to get it booted up. However, again no HDMI output at all and =
unfortunately also the serial output on the debug probe does not show =
U-boot popping up at all. Interestingly, using the patched u-boot.bin =
with a RaspberryPi4 still works and it boots up perfectly fine, but not =
with the RaspberryPi5 I have here.=20

Any idea why this might be the case here while you report that the above =
mentioned procedure works for you? In fact, the RaspberryPi5 I have here =
is a 8GB model and with the rpi-eeprom version from 2024/01/05 [1] in =
case this might be relevant.

Best Regards,

Jens

[1] =
https://github.com/raspberrypi/rpi-eeprom/tree/master/firmware-2712/latest=

--=20
Jens Maus, Dresden/Germany
http://jens-maus.de/

