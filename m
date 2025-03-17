Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6A9FC282EC
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 08:34:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C7D980FEC;
	Mon, 17 Mar 2025 09:34:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2F1980F70; Mon, 17 Mar 2025 09:34:29 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 69CFA80107
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 09:34:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6018A13D5;
 Mon, 17 Mar 2025 01:34:35 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3705D3F673;
 Mon, 17 Mar 2025 01:34:23 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Tobias Waldekranz <tobias@waldekranz.com>
Subject: [PATCH v9 0/8] Add pmem node for preserving distro ISO's
Date: Mon, 17 Mar 2025 14:03:54 +0530
Message-Id: <20250317083402.412310-1-sughosh.ganu@linaro.org>
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

Changes since V8:
* Re-word the commit message to indicate DT being installed as EFI
  configuration table (patch 2)
* Remove the existing EFI config table in copy_fdt() (patch 2)
* Move assignment of new_fdt_addr and fdt_pages variables to the block
  freeing up the existing config table memory (patch 2)
* Re-word the commit message to indicate that the ramdisk information
  is being passed to the OS through pmem node (patch 3)
* Change the type of addr and size parameters to the
  fdt_fixup_pmem_region() as u64 (patch 3)
* Rename the first parameter of fdt_fixup_pmem_region() as fdt instead
  of blob (patch 3)
* Modify the format specifier of snprintf() call in
  fdt_fixup_pmem_region() accordingly (patch 3)
* Remove pmem_start and pmem_size array variables in
  fdt_fixup_pmem_region() (patch 3)
* s/pmem_node/node_name/g (patch 3)
* Do not initialise node_name variable (patch 3)
* Re-word the commit message to indicate using efi_update_memory_map()
  for removal of memory from the EFI memory map (patch 4)
* Use efi_update_memory_map() for removing memory from the EFI memory
  map instead of adding a new function efi_remove_memory_map() (patch
  4)
* Re-word the commit message to indicate that the ramdisk region is
  being removed from the EFI memory map (patch 5)
* Fix the comment in prepare_loaded_image() on similar lines as above
  (patch 5)
* s/pmem memory area/pmem memory areas/ (patch 5)
* s/MB/MiB/g (patch 5)
* s/blkmap slice/blkmap slices/ in the commit message (patch 6)
* Add comments to the macros added in the patch (patch 6)
* Add comments to the macro added in the patch (patch 7)
* s/blkmap_get_preserved_pmem_slice/blkmap_get_preserved_pmem_slices/g
  to highlight that more than one slice is being looked for (patch 8)
* Add information on the parameters being passed to the callback
  function in blkmap_get_preserved_pmem_slices() description (patch 8)
* Highlight the fact that the callback gets called for every slice
  found in blkmap_get_preserved_pmem_slices() description (patch 8)
* Highlight the fact that invoking the callback stops when an error is
  returned by the callback in blkmap_get_preserved_pmem_slices()
  description (patch 8)
* Put some description of a typical use-case of the callback function
  in blkmap_get_preserved_pmem_slices() description (patch 8)


Ilias Apalodimas (2):
  efi_loader: allow for removal of memory from the EFI map
  efi_loader: remove memory occupied by a ramdisk from EFI memory map

Masahisa Kojima (1):
  fdt: add support for adding pmem nodes

Sughosh Ganu (5):
  efi_loader: remove unused code from copy_fdt()
  efi_loader: install device-tree on configuration table on every
    invocation
  blkmap: store type of blkmap slice in corresponding structure
  blkmap: add an attribute to preserve the mem mapping
  blkmap: pass information on ISO image to the OS

 boot/fdt_support.c            | 39 +++++++++++++++-
 boot/image-fdt.c              |  7 +++
 cmd/blkmap.c                  |  9 +++-
 drivers/block/blkmap.c        | 82 +++++++++++++++++++++++++++++++--
 drivers/block/blkmap_helper.c |  2 +-
 include/blkmap.h              | 33 +++++++++++++-
 include/efi.h                 | 13 ++++++
 include/efi_loader.h          | 15 +++++++
 include/fdt_support.h         | 14 ++++++
 lib/efi_loader/efi_bootmgr.c  | 25 ++++++++---
 lib/efi_loader/efi_helper.c   | 85 +++++++++++++++++++++++++++--------
 lib/efi_loader/efi_memory.c   | 34 +++++++-------
 12 files changed, 310 insertions(+), 48 deletions(-)

-- 
2.34.1


