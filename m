Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AE25C02183
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 13:52:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC42B80702;
	Wed, 15 Jan 2025 14:52:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 202978072F; Wed, 15 Jan 2025 14:52:44 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id B791E80702
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 14:52:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=harrison.mutai@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8EE9112FC;
 Wed, 15 Jan 2025 05:53:09 -0800 (PST)
Received: from localhost.localdomain (F4CK67LV29.cambridge.arm.com
 [10.1.37.153])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 249C43F63F;
 Wed, 15 Jan 2025 05:52:40 -0800 (PST)
From: Harrison Mutai <harrison.mutai@arm.com>
To: Liviu Dudau <liviu.dudau@foss.arm.com>,
	Tom Rini <trini@konsulko.com>
Cc: nd@arm.com, andre.przywara@arm.com, manish.pandey2@arm.com,
 Harrison Mutai <harrison.mutai@arm.com>, u-boot@lists.denx.de
Subject: [PATCH v2 2/4] board: vexpress64: default to hardware device tree
Date: Wed, 15 Jan 2025 13:52:05 +0000
Message-ID: <20250115135209.13946-3-harrison.mutai@arm.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20250115135209.13946-1-harrison.mutai@arm.com>
References: <20250115135209.13946-1-harrison.mutai@arm.com>
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

When booting into the Linux kernel with semi-hosting, use the device
tree provided by hardware unless one is provided in the current
directory.

Signed-off-by: Harrison Mutai <harrison.mutai@arm.com>
---
 include/configs/vexpress_aemv8.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/configs/vexpress_aemv8.h b/include/configs/vexpress_aemv8.h
index 8020689e39..2341b3a938 100644
--- a/include/configs/vexpress_aemv8.h
+++ b/include/configs/vexpress_aemv8.h
@@ -169,12 +169,14 @@
 		"  if load hostfs - ${kernel_addr_r} ${kernel_name}; then"	\
 		"    setenv fdt_high 0xffffffffffffffff;"		\
 		"    setenv initrd_high 0xffffffffffffffff;"		\
-		"    load hostfs - ${fdt_addr_r} ${fdtfile};"			\
+		"    if test -n load hostfs - ${fdt_addr_r} ${fdtfile}; then"			\
+		"        fdt move $fdtcontroladdr $fdt_addr_r;"			\
+		"    fi;"			\
 		"    load hostfs - ${ramdisk_addr_r} ${ramdisk_name};" \
 		"    fdt addr ${fdt_addr_r};"				\
 		"    fdt resize;"					\
 		"    fdt chosen ${ramdisk_addr_r} ${filesize};"	\
-		"    booti $kernel_addr_r - $fdt_addr_r;"		\
+		"    booti $kernel_addr_r - ${fdt_addr_r};"		\
 		"  fi;"							\
 		"fi\0"
 #define BOOTENV_DEV_NAME_SMH(devtypeu, devtypel, instance) "smh "
-- 
2.46.2

