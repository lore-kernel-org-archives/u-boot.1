Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1809AC27C53
	for <u-boot@archiver.kernel.org>; Fri,  7 Jun 2024 18:55:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08319884D0;
	Fri,  7 Jun 2024 20:54:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C44BE88473; Fri,  7 Jun 2024 20:54:10 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id B2A46884AA
 for <u-boot@lists.denx.de>; Fri,  7 Jun 2024 20:54:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 964D01480;
 Fri,  7 Jun 2024 11:54:32 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 77E4D3F792;
 Fri,  7 Jun 2024 11:54:05 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>,
 Fabio Estevam <festevam@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [RFC PATCH 11/31] lib: Kconfig: add a config symbol for getting
 memory map updates
Date: Sat,  8 Jun 2024 00:22:20 +0530
Message-Id: <20240607185240.1892031-12-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
References: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
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
changes that might be done by some other module. This notification
mechanism can then be used to have a synchronous view of allocated and
free memory.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
 lib/Kconfig | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/lib/Kconfig b/lib/Kconfig
index 189e6eb31a..9ea02ae006 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -74,6 +74,15 @@ config HAVE_PRIVATE_LIBGCC
 config LIB_UUID
 	bool
 
+config MEM_MAP_UPDATE_NOTIFY
+	bool "Get notified of any changes to the memory map"
+	default y if EVENT && LMB && EFI_LOADER
+	help
+	  Enable this option to get notification on any changes to the
+	  memory that is allocated or freed. This will allow different
+	  modules that allocate memory to have a synchronous view of available
+	  and allocated memory.
+
 config RANDOM_UUID
 	bool "GPT Random UUID generation"
 	select LIB_UUID
-- 
2.34.1

