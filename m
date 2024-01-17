Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90978C47DA2
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 15:31:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEDDE87969;
	Wed, 17 Jan 2024 16:31:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=jens-maus.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=jens-maus.de header.i=@jens-maus.de header.b="qXPRPNtt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0320876D3; Wed, 17 Jan 2024 16:30:59 +0100 (CET)
Received: from mail.light-speed.de (mail.light-speed.de
 [IPv6:2a01:238:43f2:8900:dd04:e3a0:ee11:a73d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99FDC86E88
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 16:30:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=jens-maus.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mail@jens-maus.de
Received: from smtpclient.apple (unknown
 [IPv6:2a01:599:814:62ed:f99b:5676:22ca:725f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.light-speed.de (Postfix) with ESMTPSA id 4D4983D48651;
 Wed, 17 Jan 2024 16:30:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jens-maus.de;
 s=mail; t=1705505457;
 bh=QVgwzAjK2DsBato6QiD4U1hhEtl5X5+YZ4wtSng5Scc=;
 h=Subject:From:In-Reply-To:Date:Cc:References:To;
 b=qXPRPNttQQZHE/WUGQGss1P8unFLKpPJT+0gqgpfuwn98JpV/+MClLgZr4c7AzIoa
 M//4sNd/HN3WqA9uBkpA2+25KoHSmqhVPDF4O/7r4UBN7+6WzWbE4Cc5ZTHYYEjCMi
 +55mlZSlejQvOEt/8aj65i+S1iMKBEThzHtOPmDk=
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: [PATCH v4 0/6] rpi5: initial support
From: Jens Maus <mail@jens-maus.de>
In-Reply-To: <2303FFA8-E2FA-4AA4-AE67-FF5E904D21DD@suse.de>
Date: Wed, 17 Jan 2024 16:30:46 +0100
Cc: u-boot@lists.denx.de
Content-Transfer-Encoding: quoted-printable
Message-Id: <A796E025-0F6E-4FF7-BA4D-2F52CD763B4B@jens-maus.de>
References: <BD4D4B77-9C54-4FD7-8EEF-A65E674E0747@jens-maus.de>
 <sfo77vzvmblyv5g5ek6uc6oxrf5n7dcp3vsw2g2lvfnnrlyaft@kc6s7vvspwvz>
 <4DCC64E0-F0E4-4AF6-8E81-62B156E81554@jens-maus.de>
 <2303FFA8-E2FA-4AA4-AE67-FF5E904D21DD@suse.de>
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

> Am 17.01.2024 um 16:23 schrieb Ivan T. Ivanov <iivanov@suse.de>:
>=20
>> That=E2=80=99s in fact exactly what I was also trying in addition to =
get u-boot running with your patches in my own buildroot-based =
environment. So I was also exactly using this Tumbleweed rpi4 image and =
simply replaced the u-boot.bin file with my own build version which I =
built with your patches applied and using the rpi_arm64_defconfig as the =
build config. However, there is still no output on any of the HDMI =
ports. Haven=E2=80=99t tried to see if there is any serial output on the =
special UART debug port of the rpi5. Should there be any output at all?
>=20
> Unfortunately on RPi5 they moved UART debug port to
> separate connector [1], [2].

I know. In fact, I already have such a rpi debug probe [1] at my desk. =
Nevertheless, haven=E2=80=99t tried to fire up the rpi5 with your =
u-boot.bin to see if anything sensible comes up at that special UART =
debug port which could explain the stalling and no HDMI output I saw =
here last time I checked.

> Let me update my Tumbleweed image and check again.

Thx. Can you perhaps also elaborate on your build environment for that =
particular u-boot.bin build? Or perhaps put a binary of it somewhere so =
that I could check if it works with your u-boot.bin build.

> Just to reiterate that if not properly syncing
> content to uSD card could have strange side effects.=20

I am aware of these kind of issues. But in fact, I am quite sure I =
synced all content properly to the microSD card.

Best Regards,

Jens

[1] =
https://www.raspberrypi.com/documentation/microcontrollers/debug-probe.htm=
l
--=20
Jens Maus, Dresden/Germany
http://jens-maus.de/

