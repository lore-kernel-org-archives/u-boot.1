Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66F7FC47DA2
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 15:13:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F45586E88;
	Wed, 17 Jan 2024 16:13:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=jens-maus.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=jens-maus.de header.i=@jens-maus.de header.b="VgIw5+wk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5DE586BFA; Wed, 17 Jan 2024 16:13:50 +0100 (CET)
Received: from mail.light-speed.de (mail.light-speed.de [85.214.38.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC1FC87B4F
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 16:13:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=jens-maus.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mail@jens-maus.de
Received: from smtpclient.apple (unknown
 [IPv6:2a01:599:814:62ed:f99b:5676:22ca:725f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.light-speed.de (Postfix) with ESMTPSA id 5F0503D48651;
 Wed, 17 Jan 2024 16:13:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jens-maus.de;
 s=mail; t=1705504428;
 bh=g8XiM3ONAm04mfTYJ9KW81Lci+2/YoPoxRAb1YyfEF0=;
 h=Subject:From:In-Reply-To:Date:Cc:References:To;
 b=VgIw5+wkBZO7F22Ed8DZZIJFssWoDrD6c9WsfqQCSRJtzMd7M5YaFCE/A5DiV4PnH
 Ji+D/2YjsYg4b9iwK5qhJr+K718w1alZPDb7ItE7lqjF2eM/YqA0e5ZJjYcAEiBNlX
 RNVtBQX+/5GuJrmBajOfYcCHx4tNxDb6zfgmlIGs=
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: [PATCH v4 0/6] rpi5: initial support
From: Jens Maus <mail@jens-maus.de>
In-Reply-To: <sfo77vzvmblyv5g5ek6uc6oxrf5n7dcp3vsw2g2lvfnnrlyaft@kc6s7vvspwvz>
Date: Wed, 17 Jan 2024 16:13:37 +0100
Cc: u-boot@lists.denx.de
Content-Transfer-Encoding: quoted-printable
Message-Id: <4DCC64E0-F0E4-4AF6-8E81-62B156E81554@jens-maus.de>
References: <BD4D4B77-9C54-4FD7-8EEF-A65E674E0747@jens-maus.de>
 <sfo77vzvmblyv5g5ek6uc6oxrf5n7dcp3vsw2g2lvfnnrlyaft@kc6s7vvspwvz>
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

> Am 17.01.2024 um 16:07 schrieb Ivan T. Ivanov <iivanov@suse.de>:
>=20
> On 01-12 14:10, Jens Maus wrote:
>>=20
>> Hi Ivan,
>>=20
>> first of all, thanks for the updated rpi5 patchset. However, I am =
unable to reproduce that it is actually working as you suggest. Could =
you please quickly elaborate on your test environment and the test =
config.txt for the RaspberryPi5? Here I have compiled U-Boot 2024.01 =
with your patches applied and using the =E2=80=9Erpi_arm64_defconfig=E2=80=
=9C, put the u-boot.bin file on the sd card and then added =
=E2=80=9Ekernel=3Du-boot.bin=E2=80=9C to the config.txt file. The =
environment I am using is a buildroot-based system which boots nicely =
with the default RaspberryPi boot loader and a RaspberryPi5. However, as =
soon as I replace the =E2=80=9Ekernel=3DImage=E2=80=9C line with =
=E2=80=9Ekernel=3Du-boot.bin=E2=80=9C the system stalls and there is no =
HDMI output (nor any console output) with the u-boot 2024.01 version and =
your patches applied.
>>=20
>=20
> Yes, I am using rpi_arm64_defconfig for building the U-Boot.
> And as I wrote in the cover letter I am using openSUSE Tumbleweed
> image[1], [2]. Once you copy image to uSD card mount EFI uSD
> partition and copy new u-boot.bin over existing one. That
> it is. Just make sure you clearly sync, unmount the card.
> You can find config.txt file in the EFI partition.

That=E2=80=99s in fact exactly what I was also trying in addition to get =
u-boot running with your patches in my own buildroot-based environment. =
So I was also exactly using this Tumbleweed rpi4 image and simply =
replaced the u-boot.bin file with my own build version which I built =
with your patches applied and using the rpi_arm64_defconfig as the build =
config. However, there is still no output on any of the HDMI ports. =
Haven=E2=80=99t tried to see if there is any serial output on the =
special UART debug port of the rpi5. Should there be any output at all?

Best Regards,

Jens
--=20
Jens Maus, Dresden/Germany
http://jens-maus.de/

