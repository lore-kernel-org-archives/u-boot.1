Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A170EC3DA6D
	for <u-boot@archiver.kernel.org>; Tue, 20 May 2025 12:06:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7C8B82B00;
	Tue, 20 May 2025 14:06:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BDD582BB4; Tue, 20 May 2025 14:06:21 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 00D6582A8D
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 14:06:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF7091516;
 Tue, 20 May 2025 05:06:04 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.164.21.38])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 814953F5A1;
 Tue, 20 May 2025 05:06:15 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mark Kettenis <kettenis@openbsd.org>, Weijie Gao <weijie.gao@mediatek.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 0/5] lmb: use a single API for all allocations
Date: Tue, 20 May 2025 17:36:01 +0530
Message-Id: <20250520120606.173228-1-sughosh.ganu@linaro.org>
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
with a single one, lmb_allocate_mem(). The type of allocation to be
made is specified through one of the parameters to the function.

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


Changes since V1:
* Check the return value of the lmb API in some of the common,
  non-arch code that got missed out in the earlier version. Done where
  applicable. (patch 1)
* Declare a local variable of type phys_addr_t and use that while
  calling the API, instead of casting the parameter to a void *. Done
  where applicable. (patch 1)
* Keep the value of of_start as a pointer instead of an user-address
  in boot_relocate_fdt(). (patch 1)
* Made changes to the documentation for the lmb_allocate_mem() API to
  highlight function parameters and other important constants. (patch
  1)
* Check the return value of the lmb API in some of the common,
  non-arch code that got missed out in the earlier version. Done where
  applicable. (patch 2)
* Declare a local variable of type phys_addr_t and use that while
  calling the API, instead of casting the parameter to a void *. Done
  where applicable. (patch 2)
* Optimize the use of the lmb API in boot_ramdisk_high(). (patch 2)
* s/desired_addr/high_addr in boot_relocate_fdt(). (patch 2)
* Fallthrough the LMB_MEM_ALLOC_ANY case in lmb_allocate_mem() as
  suggested by Ilias. (patch 2)



Sughosh Ganu (5):
  lmb: replace lmb_reserve() and lmb_alloc_addr() API's
  lmb: replace the lmb_alloc() and lmb_alloc_base() API's
  lmb: staticise lmb_add_memory()
  lmb: use a single function to free up memory
  doc: add lmb documentation

 arch/arm/mach-apple/board.c      |  27 +++--
 arch/arm/mach-mediatek/tzcfg.c   |   8 +-
 arch/arm/mach-snapdragon/board.c |  13 ++-
 arch/powerpc/cpu/mpc85xx/mp.c    |   4 +-
 arch/powerpc/lib/misc.c          |   5 +-
 boot/bootm.c                     |  27 +++--
 boot/image-board.c               |  56 ++++++----
 boot/image-fdt.c                 |  70 +++++++++----
 cmd/booti.c                      |  10 +-
 cmd/bootz.c                      |  10 +-
 cmd/load.c                       |   7 +-
 doc/api/index.rst                |   1 -
 doc/api/lmb.rst                  |   7 --
 doc/develop/index.rst            |   1 +
 doc/develop/lmb.rst              | 166 ++++++++++++++++++++++++++++++
 fs/fs.c                          |   5 +-
 include/lmb.h                    | 105 +++++++++----------
 lib/efi_loader/efi_memory.c      |  22 ++--
 lib/lmb.c                        | 169 +++++++++++++++++--------------
 test/lib/lmb.c                   | 102 +++++++++++++------
 20 files changed, 559 insertions(+), 256 deletions(-)
 delete mode 100644 doc/api/lmb.rst
 create mode 100644 doc/develop/lmb.rst

-- 
2.34.1


