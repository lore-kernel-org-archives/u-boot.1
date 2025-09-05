Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E58D6CA1013
	for <u-boot@archiver.kernel.org>; Fri,  5 Sep 2025 23:20:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59410839AD;
	Sat,  6 Sep 2025 01:20:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=opensuse.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83102839B5; Sat,  6 Sep 2025 01:20:14 +0200 (CEST)
Received: from eclipse.jkvinge.net (eclipse.jkvinge.net [217.170.205.109])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F5778399B
 for <u-boot@lists.denx.de>; Sat,  6 Sep 2025 01:20:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=opensuse.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=jonaski@opensuse.org
Received: from ni217.in.jkvinge.net (ti0116a430-0444.bb.online.no
 [85.165.32.192]) (authenticated bits=0)
 by eclipse.jkvinge.net (8.15.2/8.15.2/SuSE Linux 0.8) with ESMTPSA id
 585NKAvo010915
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
 Sat, 6 Sep 2025 01:20:10 +0200
Message-ID: <c0daca70b93929d62a90b2e51a935d4b3e91456b.camel@opensuse.org>
Subject: Re: No console output on Raspberry Pi Compute Module 5
From: Jonas Kvinge <jonaski@opensuse.org>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
Date: Sat, 06 Sep 2025 01:20:10 +0200
In-Reply-To: <CALeDE9NwpDJ4_to1Z6L+N1WqL4L_UgegyHqShDvTYTc7Cc8tnw@mail.gmail.com>
References: <a09a51134c3d66a9644d2aadb15c99558ce5e7e7.camel@opensuse.org>
 <CALeDE9NwpDJ4_to1Z6L+N1WqL4L_UgegyHqShDvTYTc7Cc8tnw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
MIME-Version: 1.0
Received-SPF: pass (eclipse.jkvinge.net: authenticated connection)
 receiver=eclipse.jkvinge.net; client-ip=85.165.32.192;
 helo=ni217.in.jkvinge.net; envelope-from=jonaski@opensuse.org;
 x-software=spfmilter 2.001 http://www.acme.com/software/spfmilter/ with
 libspf2-1.2.10; 
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

On Thu, 2025-08-28 at 12:05 +0100, Peter Robinson wrote:
> Hi,
>=20
> > I'm using a Raspberry Pi 5 Compute Module with a sourcekit.io
> > board.
> > I'm not getting any output from u-boot to the console, I get this
> > with
> > CM4 with the same setup.
> > Do I need to change anything to get console output on RPI5?
>=20
> Well at least on the RPi5 the console has moved to ttyAMA10 from
> ttyS0
> so you'll likely have to update something, it will depend on how that
> carrier board pins out the UART, but it works fine for me on the RPi5
> so I suspect it's something config based.
>=20
> > I've added the following patch for RPI5 which I found on the list:
> > https://github.com/jonaski/u-boot/commit/2f60b5d80b3a08d480074e8230ada5=
43bfa42401
>=20
> The rpi5 is supported with the rpi_arm64_defconfig so that's not
> needed.
>=20
> You also don't report what version of U-Boot you're using. There was
> an issue with the serial console on rpi5 producing gunk on the output
> but that was fixed with 2025.07 release.
>=20
> > My config is here:
> > https://raw.githubusercontent.com/jonaski/u-boot/refs/heads/rpi5/.confi=
g
> >=20
> > Jonas

The series of patches for Raspberry Pi 5 support
from=C2=A0https://lists.denx.de/pipermail/u-boot/2025-February/579540.html
aren't in the master branch, are you saying RPI5 is supported without
them? Does the GPIO and console work for you without any patches?

I used the latest version of u-boot from git master at the time of
testing.

Jonas
