Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C824CC27C4F
	for <u-boot@archiver.kernel.org>; Thu, 13 Jun 2024 13:17:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24848888F8;
	Thu, 13 Jun 2024 15:17:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=opensuse.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60668888FA; Thu, 13 Jun 2024 15:17:02 +0200 (CEST)
Received: from eclipse.jkvinge.net (eclipse.jkvinge.net [217.170.205.109])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE082888F2
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 15:16:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=opensuse.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=jonaski@opensuse.org
Received: from ni227.in.jkvinge.net (ti0116a430-0342.bb.online.no
 [85.165.32.90]) (authenticated bits=0)
 by eclipse.jkvinge.net (8.15.2/8.15.2/SuSE Linux 0.8) with ESMTPSA id
 45DDGwaR007296
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 15:16:59 +0200
Message-ID: <6fc28b7090833e94d47ee3abfce1b1f5a75d349f.camel@opensuse.org>
Subject: silent u-boot not working
From: Jonas Kvinge <jonaski@opensuse.org>
To: u-boot@lists.denx.de
Date: Thu, 13 Jun 2024 15:16:58 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
MIME-Version: 1.0
Received-SPF: pass (eclipse.jkvinge.net: authenticated connection)
 receiver=eclipse.jkvinge.net; client-ip=85.165.32.90;
 helo=ni227.in.jkvinge.net; envelope-from=jonaski@opensuse.org;
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

I'm running openSUSE Tumbleweed on an RPI CM4, I'm trying to silence u-
boot boot messages, with the default configuration there is an u-boot
logo on the top right corner and boot text, I'd like to get rid of the
logo and all text if possible.
The keyboard is not working before the Linux kernel is loaded, so I can
not interrupt u-boot and enter any commands, so where should I put "set
env silent 1"?

I've followed the guide on
https://github.com/ARM-software/u-boot/blob/master/doc/README.silent

I have built u-boot from source using `make rpi_4_defconfig`
configuration modified the configuration with make menuconfig, and
verified this in .config before builing.
CONFIG_SILENT_CONSOLE=3Dy
CONFIG_SILENT_U_BOOT_ONLY=3Dy
CONFIG_SILENT_CONSOLE_UPDATE_ON_SET=3Dy
CONFIG_SILENT_CONSOLE_UPDATE_ON_RELOC=3Dy
CONFIG_SILENT_CONSOLE_UNTIL_ENV=3Dy

Copied the binary to /boot/efi/u-boot.bin and /boot/vc/u-boot.bin

I've also tried to define CONFIG_EXTRA_ENV_SETTINGS in
include/configs/rpi.h according to:
https://stackoverflow.com/questions/34356844/how-to-disable-serial-consolen=
on-kernel-in-u-boot/64583919#64583919?newreg=3D0df51e20b39a448094cbb70fe356=
e4ec
 and rebuilt and copied to binary again, still not working.

The text and logo is still present during boot, what am I doing wrong
here?

Jonas

