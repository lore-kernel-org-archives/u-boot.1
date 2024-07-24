Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FC30C3DA63
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 06:07:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26883888EC;
	Wed, 24 Jul 2024 08:04:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3797888D5; Wed, 24 Jul 2024 08:04:08 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 21B3D888C6
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 08:04:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 15A701476;
 Tue, 23 Jul 2024 23:04:26 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 02BA03F766;
 Tue, 23 Jul 2024 23:03:55 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>,
 Michal Simek <michal.simek@amd.com>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 Patrice CHOTARD <patrice.chotard@foss.st.com>,
 Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH 15/40] lmb: config: add lmb config symbols for SPL
Date: Wed, 24 Jul 2024 11:31:59 +0530
Message-Id: <20240724060224.3071065-16-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
References: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
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

Add separate config symbols for enabling the LMB module for the SPL
phase. The LMB module implementation now relies on alloced list data
structure which requires heap area to be present. Add specific config
symbol for the SPL phase of U-Boot so that this can be enabled on
platforms which support a heap in SPL.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
Changes since rfc: None

 lib/Kconfig | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/lib/Kconfig b/lib/Kconfig
index f8ac8daad3..6a9338390a 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -1103,7 +1103,17 @@ config LMB
 	default y if ARC || ARM || M68K || MICROBLAZE || MIPS || \
 		     NIOS2 || PPC || RISCV || SANDBOX || SH || X86 || XTENSA
 	help
-	  Support the library logical memory blocks.
+	  Support the library logical memory blocks. This will require
+	  a malloc() implementation for defining the data structures
+	  needed for maintaining the LMB memory map.
+
+config SPL_LMB
+	bool "Enable LMB module for SPL"
+	depends on SPL && SPL_FRAMEWORK && SPL_SYS_MALLOC
+	help
+	  Enable support for Logical Memory Block library routines in
+	  SPL. This will require a malloc() implementation for defining
+	  the data structures needed for maintaining the LMB memory map.
 
 config PHANDLE_CHECK_SEQ
 	bool "Enable phandle check while getting sequence number"
-- 
2.34.1

