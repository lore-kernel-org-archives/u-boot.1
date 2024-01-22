Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D0C0C4725D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 11:55:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A77F68799D;
	Mon, 22 Jan 2024 12:55:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D94D38797C; Mon, 22 Jan 2024 12:55:14 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 5E59587950
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 12:55:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C4D3B1FB;
 Mon, 22 Jan 2024 03:55:57 -0800 (PST)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 587633F73F;
 Mon, 22 Jan 2024 03:55:09 -0800 (PST)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Yann Gautier <yann.gautier@st.com>,
 Etienne Carriere <etienne.carriere@foss.st.com>
Subject: [PATCH 00/18] FWU: Migrate FWU metadata to version 2
Date: Mon, 22 Jan 2024 17:24:21 +0530
Message-Id: <20240122115439.653871-1-sughosh.ganu@linaro.org>
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


The following patches migrate the FWU metadata access code to version
2 of the structure. This is based on the structure definition as
defined in the latest rev of the FWU Multi Bank Update specification
[1].

Since the version 1 of the structure has currently been adopted on a
couple of platforms, it was decided to have a clean migration of the
metadata to version 2 only, instead of supporting both the versions of
the structure. Also, based on consultations with the main author of
the specification, it is expected that any further changes in the
structure would be minor tweaks, and not be significant. Hence a
migration to version 2.

Similar migration is also being done in TF-A, including migrating the
ST platform port to support version 2 of the metadata structure [2].

The patches have been tested on STM32MP1 DK2 board and the Synquacer
board from Socionext. This covers testing both the GPT and the MTD
partitioned storage devices for the metadata access.

[1] - https://developer.arm.com/documentation/den0118/latest/
[2] - https://review.trustedfirmware.org/q/topic:%22topics/fwu_metadata_v2_migration%22

Sughosh Ganu (18):
  configs: fwu: Remove FWU configs for metadata V2 migration
  fwu: metadata: Migrate to version 2 of the structure
  drivers: fwu: Add the size parameter to the metadata access API's
  fwu: Add some API's for metadata version 2 access
  lib: fwu: Make changes to support version 2 of FWU metadata
  drivers: fwu: mtd: Allocate buffer for image info dynamically
  drivers: fwu: Allocate memory for metadata copies
  fwu: Add a function to put a bank in Trial State
  capsule: Accept a bank on a successful update
  fwu: mtd: Modify the DFU API's to align with metadata version 2
  efi_firmware: fwu: Do not read FWU metadata on sandbox
  efi_firmware: fwu: Get the number of FWU banks at runtime
  cmd: fwu: Align the command with metadata version 2
  test: fwu: Align the FWU metadata access test with version 2
  fwu: Remove the config symbols for number of banks and images
  tools: mkfwumdata: Migrate to metadata version 2
  configs: fwu: Re-enable FWU configs
  doc: fwu: Make changes for supporting FWU Metadata version 2

 arch/sandbox/Kconfig                     |   6 -
 board/armltd/corstone1000/corstone1000.c |   2 +-
 cmd/fwu_mdata.c                          |  43 +++-
 configs/synquacer_developerbox_defconfig |   1 -
 doc/board/socionext/developerbox.rst     |   9 +-
 doc/develop/uefi/fwu_updates.rst         |  12 +-
 doc/usage/cmd/fwu_mdata.rst              |  12 +-
 drivers/fwu-mdata/fwu-mdata-uclass.c     |  10 +-
 drivers/fwu-mdata/gpt_blk.c              |  27 +-
 drivers/fwu-mdata/raw_mtd.c              |  85 ++++---
 include/fwu.h                            |  94 ++++++-
 include/fwu_mdata.h                      |  56 +++--
 lib/efi_loader/efi_capsule.c             |  12 +-
 lib/efi_loader/efi_firmware.c            |  20 +-
 lib/fwu_updates/Kconfig                  |  11 -
 lib/fwu_updates/fwu.c                    | 308 ++++++++++++++++++-----
 lib/fwu_updates/fwu_mtd.c                |  76 ++++--
 test/dm/fwu_mdata.c                      |  56 +++--
 test/dm/fwu_mdata_disk_image.h           | 124 ++++-----
 tools/mkfwumdata.c                       |  43 +++-
 20 files changed, 705 insertions(+), 302 deletions(-)

-- 
2.34.1


