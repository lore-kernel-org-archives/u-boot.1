Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65017C0219D
	for <u-boot@archiver.kernel.org>; Thu, 13 Feb 2025 13:12:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9086180F3F;
	Thu, 13 Feb 2025 14:11:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 955B9806FE; Thu, 13 Feb 2025 14:11:47 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 7C7FE806FE
 for <u-boot@lists.denx.de>; Thu, 13 Feb 2025 14:11:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A11DD16F3;
 Thu, 13 Feb 2025 05:12:05 -0800 (PST)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4FF9A3F58B;
 Thu, 13 Feb 2025 05:11:42 -0800 (PST)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Udit Kumar <u-kumar1@ti.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH 4/4] lmb: build lmb_map_update_notify() only with EFI_LOADER
Date: Thu, 13 Feb 2025 18:41:04 +0530
Message-Id: <20250213131104.186663-5-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250213131104.186663-1-sughosh.ganu@linaro.org>
References: <20250213131104.186663-1-sughosh.ganu@linaro.org>
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

The lmb_map_update_notify() function is used to update the EFI memory
map based on corresponding changes in the LMB map. This is causing
build failure with a certain old architecture(armv5) toolchain, when
building with CONFIG_CC_OPTIMIZE_FOR_DEBUG symbol on platforms which
do not enable the EFI_LOADER code. Build the code in
lmb_map_update_notify() only when the EFI_LOADER config is enabled to
get around this issue.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
Suggested-by: Tom Rini <trini@konsulko.com>
---
 lib/lmb.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/lmb.c b/lib/lmb.c
index a55bfe289db..7f4b2315b15 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -428,7 +428,7 @@ long io_lmb_free(struct lmb *io_lmb, phys_addr_t base, phys_size_t size)
 
 static struct lmb lmb;
 
-static bool lmb_should_notify(u32 flags)
+static bool __maybe_unused lmb_should_notify(u32 flags)
 {
 	return !lmb.test && !(flags & LMB_NONOTIFY) &&
 		CONFIG_IS_ENABLED(EFI_LOADER);
@@ -437,6 +437,7 @@ static bool lmb_should_notify(u32 flags)
 static int lmb_map_update_notify(phys_addr_t addr, phys_size_t size, u8 op,
 				 u32 flags)
 {
+#if CONFIG_IS_ENABLED(EFI_LOADER)
 	u64 efi_addr;
 	u64 pages;
 	efi_status_t status;
@@ -464,7 +465,7 @@ static int lmb_map_update_notify(phys_addr_t addr, phys_size_t size, u8 op,
 		return -1;
 	}
 	unmap_sysmem((void *)(uintptr_t)efi_addr);
-
+#endif
 	return 0;
 }
 
-- 
2.34.1

