Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47C62C54798
	for <u-boot@archiver.kernel.org>; Tue,  5 Mar 2024 10:35:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B33508800F;
	Tue,  5 Mar 2024 11:35:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1709634936;
	bh=04DyevRf+SAWdVpk7fyvF8ooPNHjytty0tKortLkgXs=;
	h=Date:To:From:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=K1rVntGr2QwhHqacwSM23Qh41s2yidxdl7rgldBHdN/hzFY6ShlUbutTjIw8wcbOz
	 /e4Wi3GiLoKBdBEho7qJ3ASrSganCR6sD1i8OdupJGD2J7lC9HpryHDqIZr0ZuREi4
	 ZPd2A6W6wLRDUvBcFjiB/WqAxx9Qxk+zaSeaKQh3VPtNsg8y34XNy7dm1LG/bfL43B
	 GWOuaSNQPDB2ExnmF1JijYkO03lRKSB4yadODwH3NfSfNxL2Vvs4SzjDEPHL+vg/XA
	 vN3wB8kFX14VrrS+RySqSwXRgPOyCNC1i3m/FR3wl/va5OyLazzHRyPHKwJfOVwJDv
	 wN3G8uFmUTfBQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 071A688016; Tue,  5 Mar 2024 11:35:35 +0100 (CET)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org
 [IPv6:2001:67c:2050:101:465::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E19D286BDB
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 11:35:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4TpsQp5XFwz9sSd;
 Tue,  5 Mar 2024 11:35:30 +0100 (CET)
Message-ID: <6a3008a0-d918-4ec4-92db-f1762bdb02b4@denx.de>
Date: Tue, 5 Mar 2024 11:35:30 +0100
MIME-Version: 1.0
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
From: Stefan Roese <sr@denx.de>
Subject: Please pull u-boot-marvell/master
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi Tom,

please pull this next batch of mostly Marvell related patches:

----------------------------------------------------------------
- net: mv88e6xxx: fix missing SMI address initialization (Marek)
- mvebu: turris_omnia: Enable networking via ethernet switch (Marek)
- mvebu: helios-4: add config fragment for spi booting et al (Josua)
- rng: Add Turris Mox rTWM RNG driver (Max)
----------------------------------------------------------------

Here the Azure build, without any issues:

https://dev.azure.com/sr0718/u-boot/_build/results?buildId=341&view=results

Thanks,
Stefan

The following changes since commit 773cb2bca7743406e34ab4f441fc0a8a0d200a19:

   Merge tag 'u-boot-imx-master-20240304' of 
https://gitlab.denx.de/u-boot/custodians/u-boot-imx (2024-03-04 15:41:38 
-0500)

are available in the Git repository at:

   git@source.denx.de:u-boot/custodians/u-boot-marvell.git

for you to fetch changes up to d61b485dbd766970816ae9da09004dc4b30f8395:

   rng: Add Turris Mox rTWM RNG driver (2024-03-05 08:27:59 +0100)

----------------------------------------------------------------
Josua Mayer (3):
       arm: dts: armada-38x-solidrun-microsom: configure i2c0 bus
       arm: mvebu: helios4_defconfig: enable setexpr command
       board: helios-4: add config fragment for spi booting

Marek Mojík (2):
       net: mv88e6xxx: fix missing SMI address initialization
       arm: mvebu: turris_omnia: Enable networking via ethernet switch

Max Resch (1):
       rng: Add Turris Mox rTWM RNG driver

  arch/arm/dts/armada-385-turris-omnia-u-boot.dtsi |  51 ++++++++++
  arch/arm/dts/armada-38x-solidrun-microsom.dtsi   |   5 +
  board/kobol/helios4/spiboot.config               |   4 +
  configs/helios4_defconfig                        |   1 -
  configs/turris_omnia_defconfig                   |   2 +
  drivers/net/mv88e6xxx.c                          |   8 ++
  drivers/rng/Kconfig                              |   8 ++
  drivers/rng/Makefile                             |   1 +
  drivers/rng/turris_rwtm_rng.c                    | 123 
+++++++++++++++++++++++
  9 files changed, 202 insertions(+), 1 deletion(-)
  create mode 100644 board/kobol/helios4/spiboot.config
  create mode 100644 drivers/rng/turris_rwtm_rng.c
