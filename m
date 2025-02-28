Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92BC4C19776
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 08:45:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE0A7808B6;
	Fri, 28 Feb 2025 09:45:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79107809A5; Fri, 28 Feb 2025 09:45:57 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 03D74807D7
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 09:45:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA04B113E;
 Fri, 28 Feb 2025 00:46:08 -0800 (PST)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE5823F673;
 Fri, 28 Feb 2025 00:45:50 -0800 (PST)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Tobias Waldekranz <tobias@waldekranz.com>, Bin Meng <bmeng@tinylab.org>
Subject: [PATCH v6 0/6] Add pmem node for preserving distro ISO's
Date: Fri, 28 Feb 2025 14:15:23 +0530
Message-Id: <20250228084529.127823-1-sughosh.ganu@linaro.org>
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

Changes since V5:
* Move the failure message to the callback function instead of
  printing it in blkmap_get_preserved_pmem_slice()
* Move the check for the callback function before entering the loop in
  blkmap_get_preserved_pmem_slice()
* Return the error code returned by the callback function in
  blkmap_get_preserved_pmem_slice()


Ilias Apalodimas (2):
  efi_loader: add a function to remove memory from the EFI map
  efi_loader: preserve installer images in pmem

Masahisa Kojima (1):
  fdt: add support for adding pmem nodes

Sughosh Ganu (3):
  blkmap: store type of blkmap slice in corresponding structure
  blkmap: add an attribute to preserve the mem mapping
  blkmap: pass information on ISO image to the OS

 boot/fdt_support.c            | 41 +++++++++++++++++++++-
 boot/image-fdt.c              |  7 ++++
 cmd/blkmap.c                  |  9 +++--
 drivers/block/blkmap.c        | 65 ++++++++++++++++++++++++++++++++---
 drivers/block/blkmap_helper.c |  2 +-
 include/blkmap.h              | 21 ++++++++++-
 include/efi.h                 | 13 +++++++
 include/efi_loader.h          | 18 ++++++++++
 include/fdt_support.h         | 14 ++++++++
 lib/efi_loader/efi_bootmgr.c  | 22 +++++++++---
 lib/efi_loader/efi_helper.c   | 40 +++++++++++++++++++++
 lib/efi_loader/efi_memory.c   | 56 +++++++++++++++++++++---------
 12 files changed, 278 insertions(+), 30 deletions(-)

-- 
2.34.1


