Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4E65C25B47
	for <u-boot@archiver.kernel.org>; Fri, 27 Oct 2023 06:51:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22A7087569;
	Fri, 27 Oct 2023 08:51:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1698389493;
	bh=IJksIeGNzz1stAK4G9akfbBwWlokfRbMjItKJFtGmRc=;
	h=Date:To:From:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=NjBF2uZr3WVFem7FR63uAEo2k7DKsDrqCDu7bBdfXZ8ZjosXj+sUbqalsALBVLZC0
	 ApAmzIPR0fx/yXhgWt6NJU6zuxH8hqRXZnPp3D7wRo//1OV58H9B+KSyrXjyiu4GgA
	 UTZlC+KS+gfbwwcGMtc4nUQTOg3sq67vFL9o6ktTG38pCJ0YinSFYKjK+bkRvGHOHm
	 vclXv4C1YIJcpfQvUL+dG6NyNWHFt7bykRepFpRYIJTWTU3G2W1o1mEVQkuV2GVcqC
	 jlHuf1UP+AGjq7cdL9BDo+jO/E5+0xlLRwreOBxEXEsOmJYj8JTaYziyXKVmWP8lg2
	 h7I4ef2o1stiQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72A9C875DB; Fri, 27 Oct 2023 08:51:31 +0200 (CEST)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org [80.241.59.204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A10B87468
 for <u-boot@lists.denx.de>; Fri, 27 Oct 2023 08:51:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4SGtcH0KJcz9sQc;
 Fri, 27 Oct 2023 08:51:27 +0200 (CEST)
Message-ID: <2b17b19e-b6e4-4a38-b569-36a72b05ad59@denx.de>
Date: Fri, 27 Oct 2023 08:51:26 +0200
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

please pull this next batch of Marvell related patches:

----------------------------------------------------------------
- kirkwood: Enable bootstd on some boards (Tony)
- mvebu: turris_mox: Extend to support RIPE Atlas Probe (Marek)
- mvebu/bubt: Support eMMC data partition booting (Josua)
----------------------------------------------------------------

Here the Azure build, without any issues:

https://dev.azure.com/sr0718/u-boot/_build/results?buildId=324&view=results

Thanks,
Stefan


The following changes since commit fb428b61819444b9337075f49c72f326f5d12085:

   Merge branch '2023-10-24-assorted-general-fixes-and-updates' 
(2023-10-24 19:12:21 -0400)

are available in the Git repository at:

   git@source.denx.de:u-boot/custodians/u-boot-marvell.git

for you to fetch changes up to b6014f209f15bd49dd4ceb987d3a52e99b0305d4:

   arm: kirkwood: Enable bootstd for Zyxel NSA310S board (2023-10-26 
14:49:36 +0200)

----------------------------------------------------------------
Josua Mayer (2):
       arm: mvebu: allow additional 4096 offset for bootable mmc image
       cmd: mvebu/bubt: move eMMC data-partition uboot from LBA-0 to 4096

Marek Behún (1):
       arm: mvebu: turris_mox: Extend to support RIPE Atlas Probe

Tony Dinh (2):
       arm: kirkwood: Enable bootstd for Pogo V4 board
       arm: kirkwood: Enable bootstd for Zyxel NSA310S board

  arch/arm/dts/Makefile                   |  1 +
  arch/arm/dts/armada-3720-ripe-atlas.dts | 91 
+++++++++++++++++++++++++++++++++
  arch/arm/mach-mvebu/Kconfig             |  6 ++-
  arch/arm/mach-mvebu/spl.c               |  5 +-
  board/CZ.NIC/turris_mox/mox_sp.c        | 12 +++--
  board/CZ.NIC/turris_mox/mox_sp.h        |  8 ++-
  board/CZ.NIC/turris_mox/turris_mox.c    | 72 +++++++++++++++++++++++---
  cmd/mvebu/bubt.c                        | 11 +++-
  configs/nsa310s_defconfig               |  3 +-
  configs/pogo_v4_defconfig               |  3 +-
  configs/turris_mox_defconfig            |  3 +-
  include/configs/nsa310s.h               | 17 +-----
  include/configs/pogo_v4.h               | 35 +------------
  13 files changed, 200 insertions(+), 67 deletions(-)
  create mode 100644 arch/arm/dts/armada-3720-ripe-atlas.dts
