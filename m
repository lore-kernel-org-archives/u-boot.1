Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40BBCC4725D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 21:27:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48E20879B5;
	Fri, 19 Jan 2024 22:27:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=jens-maus.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=jens-maus.de header.i=@jens-maus.de header.b="NA5Ex6mX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BAB0587B30; Fri, 19 Jan 2024 22:27:06 +0100 (CET)
Received: from mail.light-speed.de (mail.light-speed.de [85.214.38.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93D0A879B2
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 22:27:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=jens-maus.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mail@jens-maus.de
Received: from smtpclient.apple (unknown
 [IPv6:2a02:810a:8280:47aa:e1ca:9c29:360a:5e29])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.light-speed.de (Postfix) with ESMTPSA id E83AE3D48651;
 Fri, 19 Jan 2024 22:27:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jens-maus.de;
 s=mail; t=1705699624;
 bh=IJz19PLSXXfNbvnswVW35PJnEMNDFshQasol5eCqiLc=;
 h=Subject:From:In-Reply-To:Date:Cc:References:To;
 b=NA5Ex6mXcJ4MdZFKqNlEgn8GaTrN5Fj3Vf85YUSV6TT9gM70Bt9bZ1sp9efMjmYXB
 3642Xh6L46AgOGJlRnM+l9cqCCxfIwmIIzEFvWQov3qoSkL9DU5p6QkrixxUJklPAX
 4ufJ9ySXvBM+Hn1SowpwNVU57LvqiIDixQHyOflE=
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: [PATCH v4 0/6] rpi5: initial support
From: Jens Maus <mail@jens-maus.de>
In-Reply-To: <489FBAE5-501A-49F6-894D-58BE5C5429CC@jens-maus.de>
Date: Fri, 19 Jan 2024 22:26:52 +0100
Cc: Stefan Wahren <wahrenst@gmx.net>,
 u-boot@lists.denx.de
Content-Transfer-Encoding: quoted-printable
Message-Id: <A0746263-646C-40C6-A2A6-659C39385E8B@jens-maus.de>
References: <03bbe9ad-7cc6-491d-8bd9-631f1cf04f39@gmx.net>
 <418F8AAE-136A-44A0-80C3-D01FFE00EC2E@jens-maus.de>
 <sjmi6dftbgx56isfyjtaryehzq2iollwxm2etlspiygehh3n6v@k4ws56nsbgfn>
 <6C9E5E0C-9C27-45A4-886F-8B8C641EF7A3@jens-maus.de>
 <ejituxf7ggiu2ciswrwoeqqjytb7mj2vn6gkxllywtnlm4aefi@br4zq7rfytlo>
 <3FB75D28-9BF9-4518-8BF1-519C884516F7@jens-maus.de>
 <fa7j66z5r7pul6zp5ljcntrb7xbazqxesz6wysrslrpxxhpafc@krztduo6pjm6>
 <25AB43C7-829F-4F62-AC8E-3284B22ACB03@jens-maus.de>
 <E7BFDAEE-00A9-463A-AF73-75101AFF2BC6@suse.de>
 <FB66DFF3-03B0-4DA5-8916-AB80CA6C6EB5@jens-maus.de>
 <dvpwizpui6a52dfmy57ghv4zmplvgqvow6oec7x5opwzh63zzl@jehyglofr6yh>
 <489FBAE5-501A-49F6-894D-58BE5C5429CC@jens-maus.de>
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

> Am 19.01.2024 um 17:53 schrieb Jens Maus <mail@jens-maus.de>:
>=20
>> Am 19.01.2024 um 17:29 schrieb Ivan T. Ivanov <iivanov@suse.de>:
>>=20
>>> So you say with your own u-boot.bin you see serial U-Boot output =
after that =E2=80=9ENOTICE: BL31: =E2=80=A6=E2=80=9C lines? On that =
special UART port on the rpi5 or on the UART on the GPIO header?
>>>=20
>>=20
>> Yes :-) See attached log file.
>=20
> Really strange that in your case U-Boot seems to come up nicely and =
outputs something on the debug UART. Here definitely not. And the only =
difference in the rpi boot loader log outputs I could spot between yours =
and mine is:

Replying to myself after having analysed this a bit further this =
evening...

> [=E2=80=A6]
>=20
> So lets see if after you updated to a more recent rpi eeprom U-boot is =
still able to boot=E2=80=A6

I actually do have some good and bad news:

1. Good news: I got u-boot finally showing up with my RaspberryPi5 8GB =
both on the HDMI and on the serial debug UART like you reported.

2. Bad news: I actually got it working by downgrading the rpi-eeprom to =
the same 2023/10/30 (VERSION:30de0ba5) version like you have.

So the issue I saw/reported seems to be somehow related/limited to newer =
rpi-eeprom versions. Looking at my previous diff on the rpi bootloader =
log output differences, the potentially relevant piece might be the "M.2 =
PCIe HAT not detected.=E2=80=9C line that is only present in newer =
rpi-eeprom version outputs.

So hopefully you can reproduce that issue yourself when upgrading your =
rpi-eeprom version to newer or also the latest version from 2024/01/15 =
available [1] and potentially find the actual piece that prevent your =
patchset from working on newer eeprom versions.

Best regards,
jens

[1] =
https://github.com/raspberrypi/rpi-eeprom/tree/master/firmware-2712/latest=

--=20
Jens Maus, Dresden/Germany
http://jens-maus.de/

