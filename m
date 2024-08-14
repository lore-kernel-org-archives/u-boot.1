Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB9ADC52D7B
	for <u-boot@archiver.kernel.org>; Wed, 14 Aug 2024 11:03:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98B9788A37;
	Wed, 14 Aug 2024 13:02:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E64A88A35; Wed, 14 Aug 2024 13:02:16 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id AB56588A37
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 13:02:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 12DC8DA7;
 Wed, 14 Aug 2024 04:02:34 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 93CC73F58B;
 Wed, 14 Aug 2024 04:02:03 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Mark Kettenis <mark.kettenis@xs4all.nl>,
 Michal Simek <michal.simek@amd.com>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 Patrice CHOTARD <patrice.chotard@foss.st.com>,
 Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v2 19/32] sandbox: move the TCG event log to the start of ram
 memory
Date: Wed, 14 Aug 2024 16:29:56 +0530
Message-Id: <20240814110009.45310-20-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240814110009.45310-1-sughosh.ganu@linaro.org>
References: <20240814110009.45310-1-sughosh.ganu@linaro.org>
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

The TCG event log buffer is being set at the end of ram memory. This
region of memory is to be reserved as LMB_NOMAP memory in the LMB
memory map. The current location of this buffer overlaps with the
memory region reserved for the U-Boot image, which is at the top of
the usable memory. This worked earlier as the LMB memory map was not
global but caller specific, but fails now because of the overlap.

Move the TCG event log buffer to the start of the ram memory region
instead. Move the location of the bloblist address up by 8KB to
accomodate the event log buffer, and update the sandbox memory map
specified in the documentation accordingly.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
Changes since V1:
* Rejig the memory map to have the event log at 0xb000 and bloblist at
  0xd000.
* Update the memory map in the document accordingly.


 arch/sandbox/dts/test.dts    | 2 +-
 common/Kconfig               | 2 +-
 doc/arch/sandbox/sandbox.rst | 3 ++-
 test/lib/kconfig.c           | 4 ++--
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index 5fb5eac862..76a9bc3b01 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -78,7 +78,7 @@
 
 		event_log: tcg_event_log {
 			no-map;
-			reg = <(CFG_SYS_SDRAM_SIZE - 0x2000) 0x2000>;
+			reg = <(CFG_SYS_SDRAM_BASE + 0xb000) 0x2000>;
 		};
 	};
 
diff --git a/common/Kconfig b/common/Kconfig
index 83c81edac2..7762dd216b 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -1054,7 +1054,7 @@ endchoice
 
 config BLOBLIST_ADDR
 	hex "Address of bloblist"
-	default 0xb000 if SANDBOX
+	default 0xd000 if SANDBOX
 	depends on BLOBLIST_FIXED
 	help
 	  Sets the address of the bloblist, set up by the first part of U-Boot
diff --git a/doc/arch/sandbox/sandbox.rst b/doc/arch/sandbox/sandbox.rst
index 5f8db12665..698634a65f 100644
--- a/doc/arch/sandbox/sandbox.rst
+++ b/doc/arch/sandbox/sandbox.rst
@@ -659,7 +659,8 @@ that are mapped into that memory:
 Addr      Config                     Usage
 =======   ========================   ===============================
     100   CONFIG_SYS_FDT_LOAD_ADDR   Device tree
-   b000   CONFIG_BLOBLIST_ADDR       Blob list
+   b000   TCG Event log              TCG Event Log
+   d000   CONFIG_BLOBLIST_ADDR       Blob list
   10000   CFG_MALLOC_F_ADDR          Early memory allocation
   f0000   CONFIG_PRE_CON_BUF_ADDR    Pre-console buffer
  100000   CONFIG_TRACE_EARLY_ADDR    Early trace buffer (if enabled). Also used
diff --git a/test/lib/kconfig.c b/test/lib/kconfig.c
index 0c463bb794..a3fc56a9ec 100644
--- a/test/lib/kconfig.c
+++ b/test/lib/kconfig.c
@@ -21,9 +21,9 @@ static int lib_test_is_enabled(struct unit_test_state *uts)
 	ut_asserteq(0, CONFIG_IS_ENABLED(OF_PLATDATA));
 	ut_asserteq(0, CONFIG_IS_ENABLED(_UNDEFINED));
 
-	ut_asserteq(0xb000,
+	ut_asserteq(0xd000,
 		    IF_ENABLED_INT(CONFIG_BLOBLIST_FIXED, CONFIG_BLOBLIST_ADDR));
-	ut_asserteq(0xb000,
+	ut_asserteq(0xd000,
 		    CONFIG_IF_ENABLED_INT(BLOBLIST_FIXED, BLOBLIST_ADDR));
 
 	/*
-- 
2.34.1

