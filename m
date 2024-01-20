Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C84FBC47258
	for <u-boot@archiver.kernel.org>; Sat, 20 Jan 2024 09:49:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D229687D95;
	Sat, 20 Jan 2024 10:48:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=jens-maus.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=jens-maus.de header.i=@jens-maus.de header.b="XRhEBlOp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 756A987D98; Sat, 20 Jan 2024 10:48:57 +0100 (CET)
Received: from mail.light-speed.de (mail.light-speed.de [85.214.38.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C31987D25
 for <u-boot@lists.denx.de>; Sat, 20 Jan 2024 10:48:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=jens-maus.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mail@jens-maus.de
Received: from smtpclient.apple (unknown
 [IPv6:2a02:810a:8280:47aa:e1ca:9c29:360a:5e29])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.light-speed.de (Postfix) with ESMTPSA id 995433D48651;
 Sat, 20 Jan 2024 10:48:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jens-maus.de;
 s=mail; t=1705744135;
 bh=pCXvSrYq/uZCY6Ir0LnXdKkf+43vC0aHekeMBM8t58g=;
 h=Subject:From:In-Reply-To:Date:Cc:References:To;
 b=XRhEBlOpvRe0rHnpm+hWXc99cp5T6XSmltMvUMdM+dKKjjp1HfvKm3G6FFA0l2fYD
 QMuB3sKxsV8q0W0yIzgm8V/5ro2dGzvZplBJIzcQxYwmRgPq0VjTq1INCSuc6+kPBz
 BR1AOMoh3gfTtqB4wC6WgaQAMaZLvISBJMFod4Pc=
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: [PATCH v4 0/6] rpi5: initial support
From: Jens Maus <mail@jens-maus.de>
In-Reply-To: <246035ba-0090-4cc3-982e-1de837ec7340@gmx.net>
Date: Sat, 20 Jan 2024 10:48:42 +0100
Cc: "Ivan T. Ivanov" <iivanov@suse.de>,
 u-boot@lists.denx.de
Content-Transfer-Encoding: quoted-printable
Message-Id: <6E2D7E91-E869-48C6-8CE8-0B410A2B67B9@jens-maus.de>
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
 <A0746263-646C-40C6-A2A6-659C39385E8B@jens-maus.de>
 <246035ba-0090-4cc3-982e-1de837ec7340@gmx.net>
To: Stefan Wahren <wahrenst@gmx.net>
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

> Am 20.01.2024 um 10:22 schrieb Stefan Wahren <wahrenst@gmx.net>:
>=20
> Am 19.01.24 um 22:26 schrieb Jens Maus:
>> I actually do have some good and bad news:
>>=20
>> 1. Good news: I got u-boot finally showing up with my RaspberryPi5 =
8GB both on the HDMI and on the serial debug UART like you reported.
>>=20
>> 2. Bad news: I actually got it working by downgrading the rpi-eeprom =
to the same 2023/10/30 (VERSION:30de0ba5) version like you have.
>>=20
>> So the issue I saw/reported seems to be somehow related/limited to =
newer rpi-eeprom versions. Looking at my previous diff on the rpi =
bootloader log output differences, the potentially relevant piece might =
be the "M.2 PCIe HAT not detected.=E2=80=9C line that is only present in =
newer rpi-eeprom version outputs.
>>=20
>> So hopefully you can reproduce that issue yourself when upgrading =
your rpi-eeprom version to newer or also the latest version from =
2024/01/15 available [1] and potentially find the actual piece that =
prevent your patchset from working on newer eeprom versions.
> thanks for your work, but i think you are wasting your time. The
> rpi-eeprom release 2024/01/15 seems to be broken [1]
>=20
> :-(

Thanks for that info. However, I also tested older eeprom versions to =
identify when the issue that u-boot cannot boot a rpi5 started to =
appear. And I am afraid, it already starts with version 2023-11-20 right =
after the 2023-10-30 which currently seems to work fine with Ivan=E2=80=99=
s patches. Looking at the release notes of rpi-eeprom [1] one can see =
the following entries:

=E2=80=94 cut here =E2=80=94
2023-11-20: Auto-detect support for PCIe expansion HAT (default + =
latest)

    =E2=80=A2 Add autodetect support for PCIe expansion HATs
    =E2=80=A2 Add PCIE_PROBE=3D1 to the EEPROM config for custom PCIe =
exapansion designs that do not support the upcoming HAT spec. This gives =
similar behaviour to CM4 where PCIe x1 is enumerated to discover NVMe =
devices.
    =E2=80=A2 Fix loading of multiple initramfs images that are not =
32-bit aligned sizes raspberrypi/firmware#1843
    =E2=80=A2 Kernel load performance improvement - remove a memcpy
=E2=80=94 cut here =E2=80=94=20

So as I stated earlier, one probable catch for the u-boot patches here =
might be the mentioned PCIe changes with the rpi-eeprom 2023-11-20 =
version. Or it might be related to the =E2=80=9Ekernel load performance =
improvements=E2=80=9C mentioned?!?

For now I am of course using the 2023-10-30 rpi-eeprom version and so =
far it works flawlessly with Ivan=E2=80=99s u-boot patches. Still I hope =
Ivan or someone else can have a closer look why with the 2023-11-20 =
version of rpi-eeprom u-boot immediately stops working at all.

best regards,
jens

[1] =
https://github.com/raspberrypi/rpi-eeprom/blob/master/firmware-2712/releas=
e-notes.md
--=20
Jens Maus, Dresden/Germany
http://jens-maus.de/

