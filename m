Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65D55C54FB3
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 09:13:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E073582CED;
	Mon, 26 May 2025 11:13:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 874F582CF8; Mon, 26 May 2025 11:13:14 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 4139C82C57
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 11:13:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A8EC153B;
 Mon, 26 May 2025 02:12:56 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.164.21.38])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A64533F673;
 Mon, 26 May 2025 02:13:08 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mark Kettenis <kettenis@openbsd.org>, Weijie Gao <weijie.gao@mediatek.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 0/6] lmb: use a single API for all allocations
Date: Mon, 26 May 2025 14:42:47 +0530
Message-Id: <20250526091253.400802-1-sughosh.ganu@linaro.org>
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


The LMB module has a bunch for API's which are used for allocating
memory. There are a couple of API's for requesting memory, and two
more for reserving regions of memory. Replace these different API's
with a single one, lmb_alloc_mem(). The type of allocation to be made
is specified through one of the parameters to the function.

Additionally, the two API's for reserving regions of memory,
lmb_reserve() and lmb_alloc_addr() are the same with one
difference. One can reserve any memory region with lmb_reserve(),
while lmb_alloc_addr() actually checks that the memory region being
requested is part of the LMB memory map. Reserving memory that is not
part of the LMB memory map is pretty futile -- the allocation
functions do not allocate memory which has not been added to the LMB
memory map.

This series also removes the functionality allowing for reserving
memory regions outside the LMB memory map. Any request for reserving a
region of memory outside the LMB memory map now returns an -EINVAL
error.

Certain places in the common code using the LMB API's were not
checking the return value of the functions. Checks have been added for
them. There are some calls being made from the architecture/platform
specific code which too do not check the return value. Those have been
kept the same, as I do not have the platform with me to check if it
causes any issues on those platforms.

Finally, this version has a new patch which combines the functionality
of the earlier lmb_overlaps_region() and lmb_can_reserve_region() into
a single function. The first was used for allocation checks, while the
second function was used to check if a reservation request could be
satisfied. A new function, lmb_overlap_checks() has been added, which
caters to both these scenarios.

Changes since V2:
* Changed the API name to lmb_alloc_mem() based on suggestion from
  Ilias - patch 1
* Changed the API name to lmb_alloc_mem() based on suggestion from
  Ilias - patch 2
* New patch based on suggestion from Ilias - patch 5
* Reflect the changed name of the API (lmb_alloc_mem) - patch 6


Sughosh Ganu (6):
  lmb: replace lmb_reserve() and lmb_alloc_addr() API's
  lmb: replace the lmb_alloc() and lmb_alloc_base() API's
  lmb: staticise lmb_add_memory()
  lmb: use a single function to free up memory
  lmb: use a single function to check for allocation and reservation
    requests
  doc: add lmb documentation

 arch/arm/mach-apple/board.c      |  27 +++--
 arch/arm/mach-mediatek/tzcfg.c   |   8 +-
 arch/arm/mach-snapdragon/board.c |  13 ++-
 arch/powerpc/cpu/mpc85xx/mp.c    |   4 +-
 arch/powerpc/lib/misc.c          |   5 +-
 boot/bootm.c                     |  27 +++--
 boot/image-board.c               |  56 ++++++----
 boot/image-fdt.c                 |  69 ++++++++----
 cmd/booti.c                      |  10 +-
 cmd/bootz.c                      |  10 +-
 cmd/load.c                       |   7 +-
 doc/api/index.rst                |   1 -
 doc/api/lmb.rst                  |   7 --
 doc/develop/index.rst            |   1 +
 doc/develop/lmb.rst              | 166 +++++++++++++++++++++++++++
 fs/fs.c                          |   5 +-
 include/lmb.h                    | 105 ++++++++----------
 lib/efi_loader/efi_memory.c      |  22 ++--
 lib/lmb.c                        | 185 +++++++++++++++++--------------
 test/lib/lmb.c                   | 102 +++++++++++------
 20 files changed, 566 insertions(+), 264 deletions(-)
 delete mode 100644 doc/api/lmb.rst
 create mode 100644 doc/develop/lmb.rst

-- 
2.34.1


