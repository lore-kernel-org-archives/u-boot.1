Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1251ED0EE1C
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 23:44:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8575D89427;
	Sat, 12 Oct 2024 01:44:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cesnet.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=cesnet.cz header.i=@cesnet.cz header.b="GadiwOx4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C47A89426; Sat, 12 Oct 2024 01:44:10 +0200 (CEST)
Received: from office2.cesnet.cz (office2.cesnet.cz
 [IPv6:2001:718:ff05:10b::237])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2091289426
 for <u-boot@lists.denx.de>; Sat, 12 Oct 2024 01:44:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cesnet.cz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kundrat@cesnet.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
 s=office2-2020; t=1728690246;
 bh=VApffIwEvVFQ1k6ZCoHhG8XDMv707919Sp+zLet5z8c=;
 h=From:To:Subject:Date;
 b=GadiwOx4xHI5+t5WI7I3oorDKwYAKodyCEltRoJi1ihq2jxs2oc8WTB9MyXLRMCWO
 RN7ePNOUe2jIrvRenJE5PZEZ3FL7Pbr/0HoUgEtBzyk6dHdLE0t7edltr7sFf2/q6x
 0KpQFDWvJXEw1m0eTawt4J+NxrMqKft4uOFtFCsULhk6CTgbYouvMgXByZ4dq5hpBN
 sDhu+aFexw4exed2wh5/UU1wxu3FskLcAuzaNmO6MoyhGrYOE+6S1ZfqIjTAOmOY8l
 EgAdK/1D0icnvJfJRRUKiAoWCZ74jhEie/HPIoZEL0cZoXX5xF7v7Y3vXIIfBjMbdP
 Zzpxx9PHCeNHQ==
Received: from localhost (unknown [IPv6:2001:718:1:5::ffff:31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by office2.cesnet.cz (Postfix) with ESMTPSA id A2C821180078
 for <u-boot@lists.denx.de>; Sat, 12 Oct 2024 01:44:06 +0200 (CEST)
From: =?iso-8859-1?Q?Jan_Kundr=E1t?= <jan.kundrat@cesnet.cz>
To: <u-boot@lists.denx.de>
Subject: mvebu: ClearFog Base: eMMC boot takes ages on v2024.10
Date: Sat, 12 Oct 2024 01:44:05 +0200
MIME-Version: 1.0
Message-ID: <8637e973-f609-49c7-b96f-760f0aaecfd7@cesnet.cz>
Organization: CESNET
User-Agent: Trojita/unstable-2022-08-22; Qt/5.15.14; wayland; Linux; 
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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

Hi there,
when I ugprade U-Boot from 2021-ish version (WIP/28Jan2021) to v2024.10=20
(with some trivial patches [1] [2]), my SolidRun Clearfog Base takes "ages"=20=

to boot. It looks like this is the same issue as Pali reported last year=20
[3]. Apparently, the BootROM loads the SPL, which performs some work and=20
passes control back to BootROM, at which time it hangs for about five=20
minutes:

BootROM - 1.73

Booting from MMC

U-Boot SPL 2024.10-2-ga2db423a26a (Jan 01 1980 - 00:00:00 +0000)
High speed PHY - Version: 2.0
EEPROM TLV detection failed: Using static config for Clearfog Base.
Detected Device ID 6828
board SerDes lanes topology details:
 | Lane # | Speed |  Type       |
 --------------------------------
 |   0    |   3   | SATA0       |
 |   1    |   0   | SGMII1      |
 |   2    |   5   | PCIe1       |
 |   3    |   5   | USB3 HOST1  |
 |   4    |   5   | USB3 HOST0  |
 |   5    |   0   | SGMII2      |
 --------------------------------
High speed PHY - Ended Successfully
mv_ddr: 14.0.0=20
DDR3 Training Sequence - Switching XBAR Window to FastPath Window
mv_ddr: completed successfully
Trying to boot from MMC1
ERROR: Invalid kwbimage v1
mmc_load_image_raw_sector: mmc block read error
spl: mmc: wrong boot mode
Trying to boot from BOOTROM
Returning to BootROM (return address 0xffff05c4)...

*********************************************************
***** this is where it hangs for about five minutes *****
*****    and after that time it continues happily:  *****
*********************************************************

Timeout waiting card ready
BootROM: Image checksum verification PASSED


U-Boot 2024.10-2-ga2db423a26a (Jan 01 1980 - 00:00:00 +0000)

SoC:   MV88F6828-A0 at 1600 MHz
DRAM:  1 GiB (800 MHz, 32-bit, ECC not enabled)
Core:  45 devices, 26 uclasses, devicetree: separate
WDT:   Started watchdog@20300 with servicing every 1000ms (120s timeout)
MMC:   mv_sdh: 0
Loading Environment from MMC... Reading from MMC(0)... OK
Model: SolidRun Clearfog A1
Board: SolidRun Clearfog Base
Net:   eth1: ethernet@70000, eth2: ethernet@30000, eth3: ethernet@34000
Hit any key to stop autoboot:  0=20


-> Can I do something to fix this?

Cheers,
Jan

[1]=20
https://gerrit.cesnet.cz/plugins/gitiles/github/trini/u-boot/+/082f86a75b25a3=
c1bdafd3c5aca407d7622dec65%5E%21/
[2]=20
https://gerrit.cesnet.cz/plugins/gitiles/github/trini/u-boot/+/a2db423a26a899=
0e7f223a55d196f576de6c720c%5E%21/=20
[3] https://lore.kernel.org/u-boot/20230401164345.iwfu7nd5jgbjtpzl@pali/
