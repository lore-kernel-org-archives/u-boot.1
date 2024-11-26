Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A25BD3B98A
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 12:24:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 164BE8973D;
	Tue, 26 Nov 2024 13:24:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1732623860;
	bh=HE3WM27Qhknxj8rWw9zWHYGbB0yAtMGqmXTF7qNxFzI=;
	h=Date:To:From:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=IdIDCupF8X5WkdTiT/jkdSqdBtfbMy+dqjVZfSReOj7tKpWTTtwoIUCOT/xahVKGU
	 1mu5YCSAD7gs/+37DF9+LNLsnqbzXC+u6QBq1h6w82I7fhMq2B6ooGam61tH9yDMJy
	 EH5BBhBLH8coE2WxCfgVQ5qeUv3xmbCPvUqdL0DYmc73IwIe8LmFBAVLJoBzELnhoE
	 apxLZhngPJEMDqPWIl6rwN1NqFJdEbBCC5FbWUpNlYCcYlQ1bvUKCT0VA0tMS3prjW
	 2Yez5a9w+594tETuM4wRCCfUCylg0BuZSZEFIbkUhPxntZGLKJbpfUBJZMRNU/RPnp
	 SLNKEZ8rxi55g==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16B388969D; Tue, 26 Nov 2024 13:24:19 +0100 (CET)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org
 [IPv6:2001:67c:2050:101:465::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B92418973F
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 13:24:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4XyMFV30lcz9slY;
 Tue, 26 Nov 2024 13:24:14 +0100 (CET)
Message-ID: <6166e3ab-d808-4505-b0d7-0cf32841f0d5@denx.de>
Date: Tue, 26 Nov 2024 13:24:13 +0100
MIME-Version: 1.0
Content-Language: en-US
To: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
From: Stefan Roese <sr@denx.de>
Subject: Please pull u-boot-marvell/master
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4XyMFV30lcz9slY
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

please pull the next batch of Marvell Marvell related patches:

----------------------------------------------------------------
- mvebu: Disable JFFS2 support for Kirkwood and Armada XP boards (Tony)
- kirkwood: Enable bootstd for Sheevaplug board (Tony)
- mvebu: Add Allied Telesis x250 board (Chris)
- mvebu: Updates for Allied Telesis boards (Chris)
----------------------------------------------------------------

Here the Azure build, without any issues:

https://dev.azure.com/sr0718/u-boot/_build/results?buildId=379&view=results

Thanks,
Stefan

The following changes since commit 3073246d1be682071d8b3d07d06c2484907aed60:

   Prepare v2025.01-rc3 (2024-11-25 16:59:13 -0600)

are available in the Git repository at:

   git@source.denx.de:u-boot/custodians/u-boot-marvell.git

for you to fetch changes up to 7446e29db54818324859126739c3477a15d25c36:

   arm: mvebu: Add Allied Telesis x250 board (2024-11-26 13:20:03 +0100)

----------------------------------------------------------------
Chris Packham (8):
       arm: mvebu: x240: Use default baudrate table
       arm: mvebu: x240: Switch to standard boot
       arm: mvebu: x240: Don't build mkeficapsule
       arm: mvebu: x240: Enable IPV6 support
       arm: mvebu: x530: Remove dead comments
       arm: mvebu: x530: Don't build mkeficapsule
       arm: mvebu: x530: Enable IPV6 support
       arm: mvebu: Add Allied Telesis x250 board

Tony Dinh (2):
       arm: mvebu: Disable JFFS2 support for Kirkwood and Armada XP boards
       arm: kirkwood: Enable bootstd for Sheevaplug board

  arch/arm/dts/Makefile                   |   3 +-
  arch/arm/dts/cn9130-atl-x250.dts        | 274 
++++++++++++++++++++++++++++++++
  arch/arm/mach-mvebu/Kconfig             |  10 ++
  board/Marvell/sheevaplug/sheevaplug.env |  20 +++
  board/alliedtelesis/x250/MAINTAINERS    |   7 +
  board/alliedtelesis/x250/Makefile       |   6 +
  board/alliedtelesis/x250/x250.c         |  19 +++
  configs/dns325_defconfig                |   1 -
  configs/dockstar_defconfig              |   1 -
  configs/ds414_defconfig                 |   1 -
  configs/goflexhome_defconfig            |   1 -
  configs/guruplug_defconfig              |   1 -
  configs/iconnect_defconfig              |   1 -
  configs/nas220_defconfig                |   3 -
  configs/nsa310s_defconfig               |   1 -
  configs/nsa325_defconfig                |   3 -
  configs/pogo_e02_defconfig              |   1 -
  configs/pogo_v4_defconfig               |   3 -
  configs/sheevaplug_defconfig            |  16 +-
  configs/x240_defconfig                  |   8 +-
  configs/x250_defconfig                  | 104 ++++++++++++
  configs/x530_defconfig                  |   2 +
  include/configs/sheevaplug.h            |   9 --
  include/configs/x240.h                  |  12 +-
  include/configs/x250.h                  |  28 ++++
  include/configs/x530.h                  |  16 --
  26 files changed, 478 insertions(+), 73 deletions(-)
  create mode 100644 arch/arm/dts/cn9130-atl-x250.dts
  create mode 100644 board/Marvell/sheevaplug/sheevaplug.env
  create mode 100644 board/alliedtelesis/x250/MAINTAINERS
  create mode 100644 board/alliedtelesis/x250/Makefile
  create mode 100644 board/alliedtelesis/x250/x250.c
  create mode 100644 configs/x250_defconfig
  create mode 100644 include/configs/x250.h

