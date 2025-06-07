Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F254C5B543
	for <u-boot@archiver.kernel.org>; Sat,  7 Jun 2025 10:26:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7560E82A65;
	Sat,  7 Jun 2025 12:26:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=opensuse.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60C9882A9E; Sat,  7 Jun 2025 12:26:29 +0200 (CEST)
Received: from eclipse.jkvinge.net (eclipse.jkvinge.net [217.170.205.109])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFBC2807B1
 for <u-boot@lists.denx.de>; Sat,  7 Jun 2025 12:26:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=opensuse.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=jonaski@opensuse.org
Received: from jonas.in.jkvinge.net (ti0116a430-0645.bb.online.no
 [85.165.33.137]) (authenticated bits=0)
 by eclipse.jkvinge.net (8.15.2/8.15.2/SuSE Linux 0.8) with ESMTPSA id
 557AQPNG012451
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
 Sat, 7 Jun 2025 12:26:25 +0200
Message-ID: <da35020455a4a086617a0588ba913b5ad3d2dcd9.camel@opensuse.org>
Subject: Re: Raspberry Pi Compute Module 5 support
From: Jonas Kvinge <jonaski@opensuse.org>
To: Jojan <jjvazha@yahoo.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Date: Sat, 07 Jun 2025 12:26:25 +0200
In-Reply-To: <851157797.299472.1749160367219@mail.yahoo.com>
References: <294e9037fe8b9502b41a06e9ac9363f2d5204b07.camel@opensuse.org>
 <851157797.299472.1749160367219@mail.yahoo.com>
User-Agent: Evolution 3.56.1 
MIME-Version: 1.0
Received-SPF: pass (eclipse.jkvinge.net: authenticated connection)
 receiver=eclipse.jkvinge.net; client-ip=85.165.33.137;
 helo=jonas.in.jkvinge.net; envelope-from=jonaski@opensuse.org;
 x-software=spfmilter 2.001 http://www.acme.com/software/spfmilter/ with
 libspf2-1.2.10; 
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Which branch? The master branch is 1 year old.

On Thu, 2025-06-05 at 21:52 +0000, Jojan wrote:
> You need to take raspberry=C2=A0 ( custodian version)
>=20
>=20
> Making sure you're not a bot! [1]
>=20
> Making sure you're not a bot!
> [1]
> =C2=A0
> But it is still missing the device tree fro bcm7712 ( RPI 5 is
> bcm7712)
> But you can Dow load the dtb file from the pre built dtb file from
> raspberry pi images
>=20
> and=C2=A0 use those=C2=A0 device tree sources ( using a dtc )
>=20
>=20
>=20
> =20
> =20
> =20
> On Thursday, June 5, 2025 at 02:13:24 PM PDT, Jonas Kvinge
> <jonaski@opensuse.org> wrote:=20
> =20
>=20
> =20
>=20
> =20
> Hi,
> I'm trying to boot openSUSE Linux on an CM5 using a sourcekit io
> board
> (https://sourcekit.cc/#/).
> u-boot seem to be stuck with the logo on the upper right corner, no
> text.
> I re-built u-boot using the latest source from git from the next
> branch
> and also set CONFIG_LOG in make menuconfig, but still no text.
>=20
> Is the CM5 supported by u-boot?
>=20
> Jonas
> =20
> =20


[1] Making sure you're not a bot!
    https://source.denx.de/u-boot/custodians/u-boot-raspberrypi
