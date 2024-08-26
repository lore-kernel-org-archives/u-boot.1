Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D071AC5321E
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 12:03:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1395188A35;
	Mon, 26 Aug 2024 14:01:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E6FF88B93; Mon, 26 Aug 2024 14:01:29 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 6D66988B6A
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 14:01:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 10706DA7;
 Mon, 26 Aug 2024 05:01:53 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2D3DE3F762;
 Mon, 26 Aug 2024 05:01:22 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>,
 Michal Simek <michal.simek@amd.com>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 Patrice CHOTARD <patrice.chotard@foss.st.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v4 19/27] sandbox: move the TCG event log to the start of ram
 memory
Date: Mon, 26 Aug 2024 17:29:32 +0530
Message-Id: <20240826115940.3233167-20-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240826115940.3233167-1-sughosh.ganu@linaro.org>
References: <20240826115940.3233167-1-sughosh.ganu@linaro.org>
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
instead. Move the location of the early trace buffer and the load
buffer for U-Boot(spl boot) accordingly.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
Changes since V3: None

 arch/sandbox/dts/test.dts     | 2 +-
 configs/sandbox_spl_defconfig | 2 +-
 doc/arch/sandbox/sandbox.rst  | 5 +++--
 lib/Kconfig                   | 2 +-
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index 5fb5eac862..8412506c17 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -78,7 +78,7 @@
 
 		event_log: tcg_event_log {
 			no-map;
-			reg = <(CFG_SYS_SDRAM_SIZE - 0x2000) 0x2000>;
+			reg = <(CFG_SYS_SDRAM_BASE + 0x100000) 0x2000>;
 		};
 	};
 
diff --git a/configs/sandbox_spl_defconfig b/configs/sandbox_spl_defconfig
index f7b92dc844..826a82d092 100644
--- a/configs/sandbox_spl_defconfig
+++ b/configs/sandbox_spl_defconfig
@@ -1,4 +1,4 @@
-CONFIG_TEXT_BASE=0x200000
+CONFIG_TEXT_BASE=0x400000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
diff --git a/doc/arch/sandbox/sandbox.rst b/doc/arch/sandbox/sandbox.rst
index 5f8db12665..4967551724 100644
--- a/doc/arch/sandbox/sandbox.rst
+++ b/doc/arch/sandbox/sandbox.rst
@@ -662,7 +662,8 @@ Addr      Config                     Usage
    b000   CONFIG_BLOBLIST_ADDR       Blob list
   10000   CFG_MALLOC_F_ADDR          Early memory allocation
   f0000   CONFIG_PRE_CON_BUF_ADDR    Pre-console buffer
- 100000   CONFIG_TRACE_EARLY_ADDR    Early trace buffer (if enabled). Also used
+ 100000   TCG Event log              TCG Event Log
+ 200000   CONFIG_TRACE_EARLY_ADDR    Early trace buffer (if enabled). Also used
                                      as the SPL load buffer in spl_test_load().
- 200000   CONFIG_TEXT_BASE           Load buffer for U-Boot (sandbox_spl only)
+ 400000   CONFIG_TEXT_BASE           Load buffer for U-Boot (sandbox_spl only)
 =======   ========================   ===============================
diff --git a/lib/Kconfig b/lib/Kconfig
index e352b5550a..5f282ecb54 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -403,7 +403,7 @@ config TRACE_EARLY_CALL_DEPTH_LIMIT
 config TRACE_EARLY_ADDR
 	hex "Address of early trace buffer in U-Boot"
 	depends on TRACE_EARLY
-	default 0x00100000
+	default 0x00200000
 	help
 	  Sets the address of the early trace buffer in U-Boot. This memory
 	  must be accessible before relocation.
-- 
2.34.1

