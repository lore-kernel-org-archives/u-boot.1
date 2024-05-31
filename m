Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7208EC25B75
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 15:36:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0E0988607;
	Fri, 31 May 2024 17:36:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C077887CA; Fri, 31 May 2024 17:36:42 +0200 (CEST)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1192288281
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 17:36:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139]
 helo=tharvey.pdc.gateworks.com)
 by finn.localdomain with esmtp (Exim 4.95)
 (envelope-from <tharvey@gateworks.com>) id 1sD4J3-005Ytl-2N;
 Fri, 31 May 2024 15:36:37 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Fabio Estevam <festevam@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Dragan Simic <dsimic@manjaro.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Avri Altman <avri.altman@wdc.com>, Tim Harvey <tharvey@gateworks.com>
Subject: [RESEND PATCH v4 0/3] provide names for emmc hardware partitions
Date: Fri, 31 May 2024 08:36:32 -0700
Message-Id: <20240531153635.246154-1-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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

Modern eMMC v4+ devices have multiple hardware partitions per the JEDEC
specification described as:
 Boot Area Partition 1
 Boot Area Partition 2
 RPMB Partition
 General Purpose Partition 1
 General Purpose Partition 2
 General Purpose Partition 3
 General Purpose Partition 4
 User Data Area

These are referenced by fields in the PARTITION_CONFIG register
(Extended CSD Register 179) which is defined as:
bit 7: reserved
bit 6: BOOT_ACK
  0x0: No boot acknowledge sent (default
  0x1: Boot acknowledge sent during boot operation Bit
bit 5:3: BOOT_PARTITION_ENABLE
  0x0: Device not boot enabled (default)
  0x1: Boot Area partition 1 enabled for boot
  0x2: Boot Area partition 2 enabled for boot
  0x3-0x6: Reserved
  0x7: User area enabled for boot
bit 2:0 PARTITION_ACCESS
  0x0: No access to boot partition (default)
  0x1: Boot Area partition 1
  0x2: Boot Area partition 2
  0x3: Replay Protected Memory Block (RPMB)
  0x4: Access to General Purpose partition 1
  0x5: Access to General Purpose partition 2
  0x6: Access to General Purpose partition 3
  0x7: Access to General Purpose partition 4

Note that setting PARTITION_ACCESS to 0x0 results in selecting the User
Data Area partition.

You can see above that the two fields BOOT_PARTITION_ENABLE and
PARTITION_ACCESS do not use the same enumerated values.

U-Boot uses a set of macros to access fields of the PARTITION_CONFIG
register:
EXT_CSD_BOOT_ACK_ENABLE                 (1 << 6)
EXT_CSD_BOOT_PARTITION_ENABLE           (1 << 3)
EXT_CSD_PARTITION_ACCESS_ENABLE         (1 << 0)
EXT_CSD_PARTITION_ACCESS_DISABLE        (0 << 0)

EXT_CSD_BOOT_ACK(x)             (x << 6)
EXT_CSD_BOOT_PART_NUM(x)        (x << 3)
EXT_CSD_PARTITION_ACCESS(x)     (x << 0)

EXT_CSD_EXTRACT_BOOT_ACK(x) (((x) >> 6) & 0x1)
EXT_CSD_EXTRACT_BOOT_PART(x) (((x) >> 3) & 0x7)
EXT_CSD_EXTRACT_PARTITION_ACCESS(x) ((x) & 0x7)

There are various places in U-Boot where the BOOT_PARTITION_ENABLE field
is accessed via EXT_CSD_EXTRACT_PARTITION_ACCESS and converted to a
hardware partition consistent with the definition of the
PARTITION_ACCESS field used by the various mmc_switch incarnations.

To add some sanity to the distinction between BOOT_PARTITION_ENABLE
(used to specify the active device on power-cycle) and PARTITION_ACCESS
(used to switch between hardware partitions) create two enumerated types
and use them wherever struct mmc * part_config is used or the above
macros are used.

Additionally provide arrays of the field names and allow those to be
used in the 'mmc partconf' command and in board support files.

The first patch adds enumerated types and makes use of them which
represents no compiled code change.

The 2nd patch adds the array of names and uses them in the 'mmc
partconf' command.

The 3rd patch uses the array of hardware partition names in a board
support file to show what emmc hardware partition U-Boot is being loaded
from.

I'm sending this as a series this time around as previously it was
repsented as two different patches.

Tim Harvey (3):
  mmc: use an enumerated type to represent PARTITION_CONFIG fields
  mmc: allow use of hardware partition names for mmc partconf
  venice: show emmc boot hardware partition

 arch/arm/mach-imx/image-container.c | 10 ++++-----
 arch/arm/mach-sunxi/board.c         |  2 +-
 board/gateworks/venice/spl.c        | 20 ++++++++++++-----
 board/gateworks/venice/venice.c     | 22 +++++++++---------
 board/purism/librem5/librem5.c      |  4 ++--
 board/storopack/smegw01/smegw01.c   |  4 ++--
 cmd/mmc.c                           | 27 ++++++++++++++++++----
 cmd/mvebu/bubt.c                    |  4 ++--
 common/spl/spl_mmc.c                |  4 ++--
 drivers/mmc/mmc.c                   | 35 +++++++++++++++++++++++++++++
 include/mmc.h                       | 26 +++++++++++++++++++++
 11 files changed, 123 insertions(+), 35 deletions(-)

-- 
2.25.1

