Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C887CF2576
	for <u-boot@archiver.kernel.org>; Sun, 13 Oct 2024 10:56:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C443888EDA;
	Sun, 13 Oct 2024 12:55:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CE2688E12; Sun, 13 Oct 2024 12:55:56 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 7967688EF9
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 12:55:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 849FD1063;
 Sun, 13 Oct 2024 03:56:23 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5D8593F71E;
 Sun, 13 Oct 2024 03:55:51 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v3 04/15] lib: Kconfig: add a config symbol for getting lmb
 memory map updates
Date: Sun, 13 Oct 2024 16:25:11 +0530
Message-Id: <20241013105522.391414-5-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241013105522.391414-1-sughosh.ganu@linaro.org>
References: <20241013105522.391414-1-sughosh.ganu@linaro.org>
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

Add a Kconfig symbol to enable getting updates on any memory map
changes that might be done by the LMB module. This notification
mechanism can then be used to have a synchronous view of allocated and
free memory.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
Changes since V2: None

 lib/Kconfig | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/lib/Kconfig b/lib/Kconfig
index 1dd4f27159..61452f7ac9 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -75,6 +75,23 @@ config LIB_UUID
 	bool
 	select SHA1
 
+config MEM_MAP_UPDATE_NOTIFY
+	bool "Get notified of any changes to the LMB memory map"
+	default y if EFI_LOADER
+	help
+	  Enable this option to get notification on any changes to the
+	  memory that is allocated or freed by the LMB module. This will
+	  allow different modules that allocate memory or maintain a memory
+	  map to have a synchronous view of available and allocated memory.
+
+config SPL_MEM_MAP_UPDATE_NOTIFY
+	bool "Get notified of any changes to the LMB memory map in SPL"
+	help
+	  Enable this option to get notification on any changes to the
+	  memory that is allocated or freed by the LMB module. This will
+	  allow different modules that allocate memory or maintain a memory
+	  map to have a synchronous view of available and allocated memory.
+
 config RANDOM_UUID
 	bool "GPT Random UUID generation"
 	select LIB_UUID
-- 
2.34.1

