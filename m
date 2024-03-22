Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D03E8C54E71
	for <u-boot@archiver.kernel.org>; Fri, 22 Mar 2024 10:58:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 518EF88178;
	Fri, 22 Mar 2024 11:58:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2948388137; Fri, 22 Mar 2024 11:58:11 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 62E5C87F6A
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 11:58:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B77611007;
 Fri, 22 Mar 2024 03:58:41 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D7C003F64C;
 Fri, 22 Mar 2024 03:58:04 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Yann GAUTIER <yann.gautier@st.com>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Patrick DELAUNAY - foss <patrick.delaunay@foss.st.com>,
 Michal Simek <michal.simek@amd.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Michal Simek <monstr@monstr.eu>
Subject: [PATCH v3 00/20] FWU: Add support for FWU metadata version 2
Date: Fri, 22 Mar 2024 16:27:13 +0530
Message-Id: <20240322105733.203888-1-sughosh.ganu@linaro.org>
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



The following patch series adds support for version 2 of the FWU
metadata. The version 2 metadata structure is defined in the latest
revision of the FWU specification [1].

The earlier versions of these patches were migrating to a version 2
only support in U-Boot, similar to TF-A. However, based on feedback
from ST [2], this series has been updated to support both versions. A
platform would still be needed to enable one of the two versions of
metadata through a config symbol.

TF-A has code which reads the FWU metadata and boots the platform from
the active partition. TF-A has decided to migrate the FWU code to a
version 2 only support. These changes have been merged in upstream
TF-A.

These changes have been tested on the ST DK2 board, which uses the GPT
based partitioning scheme. Both V1 and V2 metadata versions have been
tested on the DK2 board.

These changes need to be tested on platforms with MTD partitioned
storage devices.

@Michal and @Kojima-san, please help in this testing.

Note: The CI is breaking on some sandbox py tests, but the errors look
unrelated. I will look into those issues, but the code review can
proceed.

[1] - https://developer.arm.com/documentation/den0118/latest/
[2] - https://lists.denx.de/pipermail/u-boot/2024-February/546277.html

Changes since V2:
* New patch which retains support for V1 of metadata
* Earlier patch was catering to v2 only support. These changes support
  both versions of metadata.
* Earlier patch was migrating to v2 only support. These changes
  support both versions.
* Support both metadata versions instead of only v2.
* Added documentation changes.
* Make changes to have the test work with v1 metadata.
* Make changes to have the test work with updated logic in fwu code.
* Changes to indicate support for both v1 and v2 instead of only v2.
* Add config symbol for selecting either of the two metadata versions.


Sughosh Ganu (20):
  configs: fwu: remove FWU configs for metadata V2 support
  tools: mkfwumdata: fix the size parameter to the fwrite call
  drivers: fwu: add the size parameter to the metadata access API's
  drivers: fwu: mtd: allocate buffer for image info dynamically
  fwu: metadata: add support for version 2 of the structure
  fwu: metadata: add a version agnostic structure
  fwu: metadata: add functions for handling version specific metadata
    fields
  fwu: make changes to access version agnostic structure fields
  capsule: fwu: transition the platform state on a successful update
  fwu: add config symbols for enabling FWU metadata versions
  fwu: mtd: remove unused argument from function call
  fwu: mtd: get MTD partition specific info from driver
  fwu: mtd: obtain image information from version agnostic structure
  cmd: fwu: make changes for supporting FWU metadata version 2
  tools: mkfwumdata: add support for metadata version 2
  tools: mkfwumdata: add logic to append vendor data to the FWU metadata
  test: fwu: make changes to the FWU metadata access test
  doc: fwu: make changes to reflect support for FWU metadata v2
  MAINTAINERS: add entry for FWU multi bank update feature
  configs: fwu: re-enable FWU configs

 MAINTAINERS                              |   8 +
 cmd/fwu_mdata.c                          |  39 ++--
 configs/corstone1000_defconfig           |   1 +
 configs/sandbox64_defconfig              |   1 +
 configs/synquacer_developerbox_defconfig |   2 +-
 doc/board/socionext/developerbox.rst     |   7 +-
 doc/develop/uefi/fwu_updates.rst         |  20 +-
 doc/mkfwumdata.1                         |  16 +-
 drivers/fwu-mdata/fwu-mdata-uclass.c     |  10 +-
 drivers/fwu-mdata/gpt_blk.c              |  23 +-
 drivers/fwu-mdata/raw_mtd.c              |  78 ++++---
 include/fwu.h                            | 147 ++++++++++++-
 include/fwu_mdata.h                      |  71 ++++++-
 lib/efi_loader/efi_capsule.c             |  14 +-
 lib/fwu_updates/Kconfig                  |  14 ++
 lib/fwu_updates/Makefile                 |   2 +
 lib/fwu_updates/fwu.c                    | 204 ++++++++++++------
 lib/fwu_updates/fwu_mtd.c                |  34 +--
 lib/fwu_updates/fwu_v1.c                 | 167 +++++++++++++++
 lib/fwu_updates/fwu_v2.c                 | 260 +++++++++++++++++++++++
 test/dm/fwu_mdata.c                      |  16 +-
 tools/mkfwumdata.c                       | 235 ++++++++++++++++----
 22 files changed, 1153 insertions(+), 216 deletions(-)
 create mode 100644 lib/fwu_updates/fwu_v1.c
 create mode 100644 lib/fwu_updates/fwu_v2.c

-- 
2.34.1


