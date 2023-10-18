Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DAF4CDB47E
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 11:31:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B83586F60;
	Wed, 18 Oct 2023 13:30:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7984286D82; Wed, 18 Oct 2023 08:28:07 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id DA94786BB8
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 08:28:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=qi.feng@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11A672F4;
 Tue, 17 Oct 2023 23:28:45 -0700 (PDT)
Received: from a015967.shanghai.arm.com (a015967.shanghai.arm.com
 [10.169.190.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 51E033F64C;
 Tue, 17 Oct 2023 23:28:01 -0700 (PDT)
From: Qi Feng <qi.feng@arm.com>
To: u-boot@lists.denx.de
Cc: liviu.dudau@foss.arm.com, fenghua@phytium.com.cn, linus.walleij@linaro.org,
 Peter.Hoyes@arm.com, wei.chen@arm.com, Robbie.Cao@arm.com, qi.feng@arm.com
Subject: [PATCH 2/2] vexpress64: Add MMC card to the BOOT_TARGET_DEVICES of FVP
Date: Wed, 18 Oct 2023 14:27:45 +0800
Message-Id: <20231018062745.3153436-3-qi.feng@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231018062745.3153436-1-qi.feng@arm.com>
References: <20231018062745.3153436-1-qi.feng@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 18 Oct 2023 13:30:29 +0200
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

From: Wei Chen <wei.chen@arm.com>

Add MMC disk to FVP's BOOT_TARGET_DEVICES. This allows the user to boot
from MMC devices.

Signed-off-by: Wei Chen <wei.chen@arm.com>
Signed-off-by: Qi Feng <qi.feng@arm.com>
---
 include/configs/vexpress_aemv8.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/configs/vexpress_aemv8.h b/include/configs/vexpress_aemv8.h
index 43f7e454d81..24d8ca08665 100644
--- a/include/configs/vexpress_aemv8.h
+++ b/include/configs/vexpress_aemv8.h
@@ -148,6 +148,12 @@
 #define FUNC_VIRTIO(func)
 #endif
 
+#ifdef CONFIG_CMD_MMC
+#define FUNC_MMC(func)	func(MMC, mmc, 0)
+#else
+#define FUNC_MMC(func)
+#endif
+
 /*
  * Boot by loading an Android image, or kernel, initrd and FDT through
  * semihosting into DRAM.
@@ -204,6 +210,7 @@
 	func(SMH, smh, na)		\
 	func(MEM, mem, na)		\
 	FUNC_VIRTIO(func)		\
+	FUNC_MMC(func)			\
 	func(PXE, pxe, na)		\
 	func(DHCP, dhcp, na)
 
-- 
2.25.1

