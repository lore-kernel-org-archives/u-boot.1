Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24B1EC83F10
	for <u-boot@archiver.kernel.org>; Sat, 12 Jul 2025 17:25:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC9DB8006D;
	Sat, 12 Jul 2025 19:25:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=opensuse.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6916803DF; Sat, 12 Jul 2025 19:25:00 +0200 (CEST)
Received: from eclipse.jkvinge.net (eclipse.jkvinge.net [217.170.205.109])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38D3480050
 for <u-boot@lists.denx.de>; Sat, 12 Jul 2025 19:24:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=opensuse.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=jonaski@opensuse.org
Received: from ni217.in.jkvinge.net (ti0116a430-0645.bb.online.no
 [85.165.33.137]) (authenticated bits=0)
 by eclipse.jkvinge.net (8.15.2/8.15.2/SuSE Linux 0.8) with ESMTPSA id
 56CHOud4004887
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
 for <u-boot@lists.denx.de>; Sat, 12 Jul 2025 19:24:57 +0200
Message-ID: <7c447cc15eafab93f91ac3f9d14b12045d2a66f2.camel@opensuse.org>
Subject: CM5 and LetsTrust TPM with u-boot and Linux
From: Jonas Kvinge <jonaski@opensuse.org>
To: u-boot@lists.denx.de
Date: Sat, 12 Jul 2025 19:24:56 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
MIME-Version: 1.0
Received-SPF: pass (eclipse.jkvinge.net: authenticated connection)
 receiver=eclipse.jkvinge.net; client-ip=85.165.33.137;
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

Hi,

I'm working on getting Raspberry Pi CM5 with a source kit io board and
LetsTrust TPM with u-boot and Linux working.
I'm building a custom u-boot similar to the description
here:=C2=A0https://github.com/joholl/rpi4-uboot-tpm/blob/ad31306ce2f2d52f05=
72385bfc8bac33cb1f1f68/README.md#setting-up-and-configuring

I've got this successfully working on the CM4 where the PCR's are
extended on boot.

I'm now trying a similar setup on the CM5.
I use openSUSE Tumbleweed with a custom built u-boot and linux kernel.
I use kernel 6.12.35 with all the Raspberry Pi modifications
from=C2=A0https://github.com/raspberrypi/linux

The TPM is detected, but the PCR's are not extended, showing zeros for
all PCRs (tpm2_pcrread).

In addition to the=C2=A0tpm-slb9670.dtbo from the latest firmware files for
the Raspberry Pi
(https://raw.githubusercontent.com/raspberrypi/linux/refs/heads/rpi-6.12.y/=
arch/arm/boot/dts/overlays/tpm-slb9670-overlay.dts
), I use the=C2=A0tpm-soft-spi.dts
from=C2=A0https://raw.githubusercontent.com/joholl/rpi4-uboot-tpm/ad31306ce=
2f2d52f0572385bfc8bac33cb1f1f68/Raspberry_Pi_OS_64bit/tpm-soft-spi.dts

Do these needs to be modified for Raspberry Pi Compute Module 5, or
could it be something in u-boot that needs to be changed?

Jonas
