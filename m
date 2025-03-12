Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4B23C28B28
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 08:54:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C7E2807D7;
	Wed, 12 Mar 2025 09:54:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0657807D7; Wed, 12 Mar 2025 09:54:50 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 2BA6B805D7
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 09:54:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3FA6A152B;
 Wed, 12 Mar 2025 01:54:57 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 255973F5A1;
 Wed, 12 Mar 2025 01:54:43 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Tobias Waldekranz <tobias@waldekranz.com>
Subject: [PATCH v8 0/8] Add pmem node for preserving distro ISO's
Date: Wed, 12 Mar 2025 14:24:16 +0530
Message-Id: <20250312085424.1201148-1-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
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

When installing a distro via EFI HTTP boot some OS installers expect
the .iso image to be preserved and treat it as a "CDROM" to install
packages.

This is problematic in EFI, since U-Boot mounts the image, starts the
installer, and eventually calls ExitBootServices. At that point the
image U-Boot mounted disappears. Some distros don't care and download
the missing packages from a web archive, while others halt the
installation complaining they can't find certain packages.

If the firmware uses ACPI, this is supported by using NFIT which
provides NVDIMM ramdisks to the OS and preserves the image.
We don't have anything in place for Device Trees though. Since DT
supports persistent memory nodes (pmem) use those and preserve the
.iso for installers.

The issue can be reproduced by attempting an EFI HTTP boot with Ubuntu
live server ISO, or a Rocky Linux ISO. The installation would fail
with the failure to locate certain packages.

The patches are adding support for adding the pmem node to the DT that
is being passed to the OS, along with removing the memory region
containing the ISO image from the EFI memory map. This is being done
through a helper function in the blkmap driver which scans for all
blkmap mappings and does the above configurations for the relevant
mappings.

This version of the patchset is adding two patches to the front of the
series, which re-install a device-tree(DT) on the EFI configuration
table afresh on every invocation of efi_install_fdt(). This fixes the
issue of a stale DT being passed on to a OS in the scenario where the
DT was already installed on the configuration table.

Changes since V7:
* Change the type of fdt_pages to efi_uintn_t (patch 2)
* Remove the check for either of fdt_pages or new_fdt_addr being 0
  (patch 2)
* Change the format specifier for fdt_pages in the debug messages for
  size_t (patch 2)
* Put the assignment of new_fdt_addr and fdt_pages on separate lines
  to avoid checkpatch error (patch 2)
* Fix repeated word in the commit message (patch 7)
* Fix checkpatch errors in blkmap.c and efi_helper.c (patch 8)




Ilias Apalodimas (2):
  efi_loader: add a function to remove memory from the EFI map
  efi_loader: preserve installer images in pmem

Masahisa Kojima (1):
  fdt: add support for adding pmem nodes

Sughosh Ganu (5):
  efi_loader: remove unused code from copy_fdt()
  efi_loader: install device-tree on configuration table on every
    invocation
  blkmap: store type of blkmap slice in corresponding structure
  blkmap: add an attribute to preserve the mem mapping
  blkmap: pass information on ISO image to the OS

 boot/fdt_support.c            | 41 +++++++++++++++++-
 boot/image-fdt.c              |  7 +++
 cmd/blkmap.c                  |  9 +++-
 drivers/block/blkmap.c        | 64 +++++++++++++++++++++++++--
 drivers/block/blkmap_helper.c |  2 +-
 include/blkmap.h              | 21 ++++++++-
 include/efi.h                 | 13 ++++++
 include/efi_loader.h          | 18 ++++++++
 include/fdt_support.h         | 14 ++++++
 lib/efi_loader/efi_bootmgr.c  | 22 +++++++---
 lib/efi_loader/efi_helper.c   | 81 ++++++++++++++++++++++++++---------
 lib/efi_loader/efi_memory.c   | 56 +++++++++++++++++-------
 12 files changed, 297 insertions(+), 51 deletions(-)

-- 
2.34.1


