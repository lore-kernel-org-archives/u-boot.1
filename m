Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED89FC71136
	for <u-boot@archiver.kernel.org>; Tue, 17 Jun 2025 10:45:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5B0B82D57;
	Tue, 17 Jun 2025 12:44:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A3FC82BA1; Tue, 17 Jun 2025 12:44:34 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id A504B82D57
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 12:44:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0EBF91596;
 Tue, 17 Jun 2025 03:44:10 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.164.21.38])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D83DF3F58B;
 Tue, 17 Jun 2025 03:44:27 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mark Kettenis <kettenis@openbsd.org>, Weijie Gao <weijie.gao@mediatek.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v5 7/7] doc: add lmb documentation
Date: Tue, 17 Jun 2025 16:13:46 +0530
Message-Id: <20250617104346.1379981-8-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250617104346.1379981-1-sughosh.ganu@linaro.org>
References: <20250617104346.1379981-1-sughosh.ganu@linaro.org>
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

The LMB module has undergone significant changes in the recent
past. Add a document which briefly describes what the LMB module does,
and the changes that have been made to it's design since the 2025.01
release.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
Changes since V4: None

 doc/api/index.rst     |   1 -
 doc/api/lmb.rst       |   7 --
 doc/develop/index.rst |   1 +
 doc/develop/lmb.rst   | 166 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 167 insertions(+), 8 deletions(-)
 delete mode 100644 doc/api/lmb.rst
 create mode 100644 doc/develop/lmb.rst

diff --git a/doc/api/index.rst b/doc/api/index.rst
index 506843ed74a..cf9d21e4c1c 100644
--- a/doc/api/index.rst
+++ b/doc/api/index.rst
@@ -17,7 +17,6 @@ U-Boot API documentation
    interrupt
    led
    linker_lists
-   lmb
    logging
    nvmem
    part
diff --git a/doc/api/lmb.rst b/doc/api/lmb.rst
deleted file mode 100644
index 2095bfa1618..00000000000
--- a/doc/api/lmb.rst
+++ /dev/null
@@ -1,7 +0,0 @@
-.. SPDX-License-Identifier: GPL-2.0+
-
-Logical memory blocks
-=====================
-
-.. kernel-doc:: include/lmb.h
-   :internal:
diff --git a/doc/develop/index.rst b/doc/develop/index.rst
index 0c83ef109ab..3c044e67927 100644
--- a/doc/develop/index.rst
+++ b/doc/develop/index.rst
@@ -46,6 +46,7 @@ Implementation
    cedit
    event
    global_data
+   lmb
    logging
    makefiles
    menus
diff --git a/doc/develop/lmb.rst b/doc/develop/lmb.rst
new file mode 100644
index 00000000000..b9d0f09c2bb
--- /dev/null
+++ b/doc/develop/lmb.rst
@@ -0,0 +1,166 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Logical Memory Blocks (LMB)
+===========================
+
+U-Boot has support for reserving chunks of memory which is primarily
+used for loading images to the DRAM memory, before these are booted,
+or written to non-volatile storage medium. This functionality is
+provided through the Logical Memory Blocks (LMB) module.
+
+Introduction
+------------
+
+The LMB module manages allocation requests for memory region not
+occupied by the U-Boot image. Allocation requests that are made
+through malloc() and similar functions result in memory getting
+allocated from the heap region, which is part of the U-Boot
+image. Typically, the heap memory is a few MiB in size. Loading an
+image like the linux kernel might require lot more memory than what
+the heap can provide. Such allocations are usually handled through the
+LMB module.
+
+The U-Boot image typically gets relocated to the top of the usable
+DRAM memory region. A typical memory layout looks as follows::
+
+
+
+
+
+                      |              |
+                      |              |
+                      |              |
+                      |              |
+                      |              |
+       ---            +--------------+  <--- U-Boot ram top
+        |             |              |
+        |             |    Text      |
+        |             +--------------+
+        |             |              |
+        |             |    Data      |
+        |             +--------------+
+        |             |              |
+        |             |    BSS       |
+  U-Boot Image        +--------------+
+        |             |              |
+        |             |    Heap      |
+        |             |              |
+        |             +--------------+
+        |             |              |
+        |             |              |
+        |             |    Stack     |
+        |             |              |
+        |             |              |
+       ---            +--------------+
+                      |              |
+                      |              |
+                      |              |
+                      |              |
+                      |              |
+                      |              |
+                      |              |
+                      |              |
+                      |              |
+                      |              |
+                      |              |
+                      |              |
+                      |              |
+                      |              |
+                      +--------------+  <--- ram start
+
+
+
+The region of memory below the U-Boot image is the one controlled by
+the LMB module.
+
+
+Types of LMB Allocations
+------------------------
+
+There are two classes of allocation requests that get made to the LMB
+module. One type of allocation requests are requesting memory of a
+particular number of bytes. This type of allocation is similar to that
+done using the malloc type of function calls. The other type of
+allocations, are requests made for a specific memory address. The
+second type of allocations are usually made for loading images to a
+particular memory address.
+
+
+LMB design Pre 2025.01
+----------------------
+
+The earlier versions of U-Boot (pre 2025.01 release)
+had a local memory map based LMB implementation whereby it was
+possible to declare the LMB map inside a function or a C file. This
+design resulted in temporary, non-global LMB maps, which also allowed
+for re-use of memory. This meant that it was possible to use a region
+of memory to load some image, and subsequently the same region of
+memory could be used for loading a different image. A typical example
+of this usage would be loading an image to a memory address, followed
+by writing that image to some non-volatile storage medium. Once this
+is done, the same address can be used for loading a different image
+and then writing it to it's non-volatile storage
+destination. Typically, environment variables like `loadaddr`,
+`kernel_addr_r`, `ramdisk_addr_r` are used for loading images to
+memory regions.
+
+
+Current LMB implementation
+--------------------------
+
+Changes were made in the 2025.01 release to make the LMB memory map
+global and persistent. With this, the LMB memory map is the same
+across all of U-Boot, and also persists as long as U-Boot is
+active. Even with this change, there has been consistency as far as
+re-use of memory is concerned to maintain backward compatibility. It
+is allowed for re-requesting the same region of memory if the memory
+region has a particular attribute (LMB_NONE).
+
+As part of the platform boot, DRAM memory available for use in U-Boot
+gets added to the LMB memory map. Any allocation requests made
+subsequently will be made from this memory added as part of the board
+init.
+
+
+Allocation API
+--------------
+
+Any request for non-heap memory can be made through the LMB allocation
+API.
+
+.. code-block:: c
+
+	int lmb_alloc_mem(enum lmb_mem_type type, u64 align,
+			  phys_addr_t *addr, phys_size_t size,
+			  u32 flags);
+
+Correspondingly, the allocated memory can be free'd
+
+.. code-block:: c
+
+	long lmb_free(phys_addr_t base, phys_size_t size, u32 flags);
+
+For a detailed API description, please refer to the header file.
+
+
+UEFI allocations with LMB as the backend
+----------------------------------------
+
+The UEFI specification describes boot-time API's for allocation of
+memory. These API's use the same memory that is being used by the LMB
+module. Pre 2025.01 release, there wasn't any synchronisation between
+the EFI sub-system and the LMB module about the memory that was
+getting allocated by each of these modules. This was the primary
+reason for making the LMB memory map global and persistent. With this
+change, the EFI memory allocation API's have also been changed to use
+the LMB module as the backend for the allocation requests. Any other
+sub-system which might wish to use the same memory region for it's use
+can then use the LMB as the backend for the memory allocations and
+it's associated book-keeping.
+
+
+API documentation
+-----------------
+
+.. kernel-doc:: include/lmb.h
+
-- 
2.34.1

