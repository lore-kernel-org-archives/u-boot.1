Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20990D0C5FB
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 11:14:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3138188DFE;
	Fri, 25 Oct 2024 13:14:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F9D988F95; Fri, 25 Oct 2024 13:14:53 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id AAC3988BEF
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 13:14:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9EF8B339;
 Fri, 25 Oct 2024 04:15:16 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 50CA33F73B;
 Fri, 25 Oct 2024 04:14:45 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 0/4] Add pmem node for preserving distro ISO's
Date: Fri, 25 Oct 2024 16:44:07 +0530
Message-Id: <20241025111411.165904-1-sughosh.ganu@linaro.org>
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



Ilias Apalodimas (2):
  efi_loader: add a function to remove memory from the EFI map
  efi_loader: preserve installer images in pmem

Masahisa Kojima (1):
  fdt: add support for adding pmem nodes

Sughosh Ganu (1):
  efi: add helper functions to insert pmem node for DT fixup

 boot/fdt_support.c           | 41 +++++++++++++++++++++++++++--
 boot/image-fdt.c             |  9 +++++++
 include/efi_loader.h         | 28 +++++++++++++++++---
 include/fdt_support.h        | 13 +++++++++
 lib/efi_loader/efi_bootmgr.c | 43 ++++++++++++++++++++++++++----
 lib/efi_loader/efi_helper.c  | 12 +++++++++
 lib/efi_loader/efi_memory.c  | 51 +++++++++++++++++++++++++++---------
 lib/lmb.c                    |  4 +--
 8 files changed, 175 insertions(+), 26 deletions(-)

-- 
2.34.1


