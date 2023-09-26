Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4965E7D263
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 08:44:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC4B086BEE;
	Tue, 26 Sep 2023 10:44:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=tinylab.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5D0E86C13; Tue, 26 Sep 2023 10:44:34 +0200 (CEST)
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39C1686BCE
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 10:44:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=tinylab.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng@tinylab.org
X-QQ-mid: bizesmtp83t1695717829th6acu7d
Received: from pek-vx-bsp2.wrs.com ( [60.247.85.88])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 26 Sep 2023 16:43:46 +0800 (CST)
X-QQ-SSF: 01200000000000F0I000000A0000000
X-QQ-FEAT: g7P3sHHcFzYm+N2+AfOwJvWWL/xNigJf8YoeBxvJ1G2YlTGSl7tTOk7hbdsVp
 1XBbTgWr1a59wtiqPFI4DvvuxIeSkC9JYlbewZKV7BAPNtS4cDispZCLq1x0GWkVna/NMQz
 eu/izYHOoFjzzXfGNz8woDQ6oBURZFu9OSyNiyHGqJ49ogeaqRRvu/3iqbLJgHiwhu9X8le
 GwHU7NLAkOfRfMWINVY8Yp+XU22luKBjH9v57Gxl5PqwlUjYmZniXA7t2zC/Tv3AZixG7vq
 sueC86NDAFgT0Fg4lLFcER0B5129YelIFdw27fMO2lmKNXoug3x+/nMtlHlT7rm3SjJR9rz
 6Kp5tm0z7wE1BxrVbTTu2mlcyRJiQ==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9552474271002647573
From: Bin Meng <bmeng@tinylab.org>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Bin Meng <bmeng.cn@gmail.com>, Heiko Schocher <hs@denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>, Johan Jonker <jbx6244@gmail.com>,
 Joshua Watt <jpewhacker@gmail.com>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Suchanek <msuchanek@suse.de>, Peng Fan <peng.fan@nxp.com>,
 Tobias Waldekranz <tobias@waldekranz.com>
Subject: [PATCH 00/15] blk: sandbox: Support binding a device with a given
 logical block size
Date: Tue, 26 Sep 2023 16:43:30 +0800
Message-Id: <20230926084346.2237483-1-bmeng@tinylab.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz7a-0
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

At present on Sandbox when binding to a host backing file, the host
block device is created with a hard-coded 512 bytes block size.

Such assumption works for most cases, but for situation that with a raw
image file dump from a pre-formatted GPT partitioned disk image from a
4KiB block size device, when binding this file to a host device and mapping
this device to a blkmap, "blkmap" command like "blkmap part" won't work
correctly, due to block size mismatch during parsing the partition table.

This series updates Sandbox block driver, as well as the blkmap driver,
to get rid of the hard-coded 512 bytes block size assumption.

This series is available at u-boot-x86/blk for testing.

Test log (512 block size):

  => host bind 0 test.img
  => host info
  dev       blocks  blksz label           path
    0       262144    512 0               test.img
  => blkmap create 0
  Created "0"
  => blkmap map 0 0 40000 linear host 0 0
  Block 0x0+0x40000 mapped to block 0x0 of "host 0"
  => blkmap info
  Device 0: Vendor: U-Boot Rev: 1.0 Prod: blkmap
              Type: Hard Disk
              Capacity: 128.0 MB = 0.1 GB (262144 x 512)
  => blkmap part

  Partition Map for BLKMAP device 0  --   Partition Type: EFI

  Part    Start LBA       End LBA         Name
          Attributes
          Type GUID
          Partition GUID
    1     0x00000022      0x000000bd      "u-boot-spl"
          attrs:  0x0000000000000000
          type:   5b193300-fc78-40cd-8002-e86c45580b47
                  (5b193300-fc78-40cd-8002-e86c45580b47)
          guid:   0bb6bb6e-4aac-4c27-be03-016b01e7b941
    2     0x00000822      0x00000c84      "u-boot"
          attrs:  0x0000000000000000
          type:   2e54b353-1271-4842-806f-e436d6af6985
                  (2e54b353-1271-4842-806f-e436d6af6985)
          guid:   91d50814-8e31-4cc0-97dc-779e1dc59056
    3     0x00000c85      0x0000cc84      "rootfs"
          attrs:  0x0000000000000004
          type:   0fc63daf-8483-4772-8e79-3d69d8477de4
                  (linux)
          guid:   42799722-6e55-46e6-afa9-529e7af3f03b

Test log (4096 block size):

  => host bind 0 test.img 4096
  => host info
  dev       blocks  blksz label           path
    0        32768   4096 0               test.img
  => blkmap create 0
  Created "0"
  => blkmap map 0 0 8000 linear host 0 0
  Block 0x0+0x8000 mapped to block 0x0 of "host 0"
  => blkmap info
  Device 0: Vendor: U-Boot Rev: 1.0 Prod: blkmap
              Type: Hard Disk
              Capacity: 128.0 MB = 0.1 GB (32768 x 4096)
  => blkmap part

  Partition Map for BLKMAP device 0  --   Partition Type: EFI

  Part    Start LBA       End LBA         Name
          Attributes
          Type GUID
          Partition GUID
    1     0x00000100      0x00001fff      "primary"
          attrs:  0x0000000000000000
          type:   0fc63daf-8483-4772-8e79-3d69d8477de4
                  (linux)
          guid:   eba904d7-72c1-4dbd-bb4e-36be49cba5e3
    2     0x00002000      0x00007ffa      "primary"
          attrs:  0x0000000000000000
          type:   0fc63daf-8483-4772-8e79-3d69d8477de4
                  (linux)
          guid:   c48c360e-db47-46da-ab87-26416fad3cd3


Bin Meng (15):
  blk: Use a macro for the typical block size
  cmd: host: Mandate the filename parameter in the 'bind' command
  blk: sandbox: Support binding a device with a given logical block size
  blk: host_dev: Make host_sb_detach_file() and host_sb_ops static
  blk: host_dev: Sanity check on the size of host backing file
  cmd: host: Print out the block size of the host device
  blk: blkmap: Make bind/unbind routines static
  cmd: blkmap: Make map_handlers[] and its .fn static
  blk: blkmap: Support mapping to device of any block size
  cmd: blk_common: Use macros for the return values
  dm: blk: Rename get_desc() and make it externally visible
  cmd: blk_common: Stop using hard-coded block size for Sandbox
    operations
  dm: blk: Drop blk_{read,write}_devnum()
  disk: part: Print out the unknown device uclass id
  disk: part: Handle blkmap device in print_part_header()

 cmd/blk_common.c            | 34 +++++++++++++++----------
 cmd/blkmap.c                |  7 ++---
 cmd/host.c                  | 25 +++++++++++++-----
 common/usb_storage.c        |  4 +--
 disk/part.c                 |  5 +++-
 drivers/ata/dwc_ahsata.c    |  3 ++-
 drivers/ata/fsl_sata.c      |  3 ++-
 drivers/ata/sata_mv.c       |  3 ++-
 drivers/ata/sata_sil.c      |  3 ++-
 drivers/block/blk-uclass.c  | 51 +++++--------------------------------
 drivers/block/blkmap.c      | 16 ++++++------
 drivers/block/host-uclass.c | 15 ++++++++---
 drivers/block/host_dev.c    | 11 +++++---
 drivers/mmc/mmc-uclass.c    |  2 +-
 drivers/nvme/nvme.c         |  2 +-
 include/blk.h               | 40 ++++++++++-------------------
 include/sandbox_host.h      |  7 +++--
 test/dm/blk.c               |  7 ++---
 test/dm/host.c              | 26 +++++++++----------
 19 files changed, 129 insertions(+), 135 deletions(-)

-- 
2.25.1

