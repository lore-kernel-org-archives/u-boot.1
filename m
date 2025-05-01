Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 233E4C369DC
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 12:03:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DD0A8081A;
	Thu,  1 May 2025 14:03:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8C508081A; Thu,  1 May 2025 14:03:00 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id A72098056A
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 14:02:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 490EC106F;
 Thu,  1 May 2025 05:02:50 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4043B3F673;
 Thu,  1 May 2025 05:02:55 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mark Kettenis <kettenis@openbsd.org>, Weijie Gao <weijie.gao@mediatek.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH 0/5] lmb: use a single API for all allocations
Date: Thu,  1 May 2025 17:32:34 +0530
Message-Id: <20250501120239.199829-1-sughosh.ganu@linaro.org>
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
 boot/bootm.c                     |  11 +-
 boot/image-board.c               |  49 +++++----
 boot/image-fdt.c                 |  67 +++++++++---
 cmd/booti.c                      |   8 +-
 cmd/bootz.c                      |   8 +-
 cmd/load.c                       |   6 +-
 doc/api/index.rst                |   1 -
 doc/api/lmb.rst                  |   7 --
 doc/develop/index.rst            |   1 +
 doc/develop/lmb.rst              | 166 ++++++++++++++++++++++++++++++
 fs/fs.c                          |   3 +-
 include/lmb.h                    | 101 ++++++++----------
 lib/efi_loader/efi_memory.c      |  22 ++--
 lib/lmb.c                        | 171 +++++++++++++++++--------------
 test/lib/lmb.c                   | 102 ++++++++++++------
 20 files changed, 535 insertions(+), 245 deletions(-)
 delete mode 100644 doc/api/lmb.rst
 create mode 100644 doc/develop/lmb.rst

-- 
2.34.1


