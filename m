Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D80BCD13D2
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 22:31:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 874F7839D5;
	Fri,  1 May 2026 00:31:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jannau.net header.i=@jannau.net header.b="auSy0Mny";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="NtWreJGr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44D1D83A91; Fri,  1 May 2026 00:31:24 +0200 (CEST)
Received: from fout-b5-smtp.messagingengine.com
 (fout-b5-smtp.messagingengine.com [202.12.124.148])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0654803C6
 for <u-boot@lists.denx.de>; Fri,  1 May 2026 00:31:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=j@jannau.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.stl.internal (Postfix) with ESMTP id 703911D000B6;
 Thu, 30 Apr 2026 18:31:20 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Thu, 30 Apr 2026 18:31:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:message-id:mime-version:reply-to
 :subject:subject:to:to; s=fm1; t=1777588280; x=1777674680; bh=oJ
 JPTL6T82iJ/f+zsLsOH4BUzeIVYWT4D5jf1/ybFbY=; b=auSy0Mnymbc900+4L4
 OVMwbaY8OypgGW29UCXwBIYbjGRkVszxfgqs7xfqgvh/kfMX7PtoQ2NR8jrE9Hr/
 AqwWJiic9Kq6lFUg+rJhAapY199Sy8HKFzKfycGJBoRcF4yg/XcAzMTqfab4Xg7x
 K8/+nkO2gmLPmU0KJdGpfE4T2q/HeTkZf71OX4ROR5EnvYkTdwu8tDjYf4zfjPUo
 d5b8yt8Be+8Ng304lvsRDFQ7b3NzC0M0qE+XY5vpGhU6roTXJWXZxkbsegfBxMsh
 2tBsx69MeGtr6bVX0sqe4XCprsMModMNvPaXBqaPN4iXTNcXwdza0I1t+oHlfuJT
 HCcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1777588280; x=1777674680; bh=oJJPTL6T82iJ/f+zsLsOH4BUzeIV
 YWT4D5jf1/ybFbY=; b=NtWreJGrb0GfYkDdYNatSKANmDRIGEwE4NFI+46HYloP
 +Mk5O4ManAuLeAnWPHgVlyxlJXcVYxbDfu8xEB1lFfjuGX+z18tFpK+CaDIYVfeP
 QTyRImFzS5aPA6w+KEGnS565/V8X36NxiaM6+onzL+32HsTN373AF6F6NgLBVng/
 K+cdRxRGQxvejzGolyYzkhVCPTaTAyhofUzJ8lN9gbyMgONrqUMgOeAm8Egkqbxe
 s9VY8xdAmxt9OS/QLpjCH3+GfCSB7QoGeapI8YR4Et5HBHIudov78YhJ/nXDF0Qz
 1MOxLI4OE8xLOOQ3CF+1TFo85RHgc3dghuYPH8AqHw==
X-ME-Sender: <xms:N9jzaYRpQj_Y-2Hvn9ekvRZETQWxJy_kBGhxjslbtDfAO-4esJR7AA>
 <xme:N9jzacxF8rqRZeT5HOqQaG5-Nm_vxnK-3VDCUTi2sIStKxn37g0gCgPlw6x6KaRWU
 PBXe89HZeXqOHyioYYB7QvEeMBuaXbIBQf8JIpaRmNRyvm7hWQiV8o>
X-ME-Received: <xmr:N9jzaa0N1_FkkoemX6_8PQnW1gU1lpvYNusSWGGWQXMPD2WQkAKq9f0oYqpKaxtEuCLmGdhEA2R_vSJyqvMwdZlRo7IFhjnFsRWm_A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekkeehfecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhfffugggtgffkvfevofesthejredtredtjeenucfhrhhomheplfgrnhhnvgcuifhr
 uhhnrghuuceojhesjhgrnhhnrghurdhnvghtqeenucggtffrrghtthgvrhhnpefgffeiff
 etueffteeugfeghffghedthfekgfdtjeeuuedvveekteevvedvffekheenucevlhhushht
 vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjsehjrghnnhgruhdrnh
 gvthdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
 thhrihhniheskhhonhhsuhhlkhhordgtohhmpdhrtghpthhtohepkhgvthhtvghnihhsse
 hophgvnhgsshgurdhorhhgpdhrtghpthhtohepuhdqsghoohhtsehlihhsthhsrdguvghn
 gidruggvpdhrtghpthhtohepjhesjhgrnhhnrghurdhnvght
X-ME-Proxy: <xmx:N9jzaa5Odqn1s1_Ez4b3Qq_z64wFjJ2qSXzQAoy3rdRwBGgHhPUw9A>
 <xmx:N9jzadUJuYtAzvzCB_VFrQaKbQZJZ-FdpMMUgO1s3mC3fUWxc7A3Xw>
 <xmx:N9jzaZDbkNEVWl4bFW2UYv107MrTEO1wyszGnXzQWSJWmW9zBvWQAA>
 <xmx:N9jzac7vmzCt22DzVrf_j99XTDtCpxgrdAqdHiEUG-aoh_MFkDlH1w>
 <xmx:ONjzaYwBf15938u4v5kAPFGXCWN3NgUROxiE8RC4jN5Xo_c2H8RR0I46>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Apr 2026 18:31:19 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Fri, 01 May 2026 00:31:16 +0200
Subject: [PATCH] arm: apple: Switch to board based text env
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260501-apple-board-env-text-v1-1-ea3730cb4037@jannau.net>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MXQqAIBAGrxL73ILZD9JVogfLr1oIE40IorsnP
 Q7DzEMJUZCoLx6KuCTJ4TNUZUHzZv0KFpeZtNKdalXFNoQdPB02Ooa/+MR9skGWjdWuNoZyGiI
 Wuf/tML7vB82xpnVmAAAA
X-Change-ID: 20260501-apple-board-env-text-8e6054a2d388
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Mark Kettenis <kettenis@openbsd.org>, 
 Janne Grunau <j@jannau.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4679; i=j@jannau.net;
 s=yk2025; h=from:subject:message-id;
 bh=zVDrKWt4QOZ5iat/hVkQ7qsNiNEQzdQPdWaQP/rsB/s=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhszPN8yebeBdq/jr7bHjFza3rDr182Gqj/7MS6zTo/U9D
 tqarAzm6yhlYRDjYpAVU2RJ0n7ZwbC6RjGm9kEYzBxWJpAhDFycAjARlgeMDKdML4az9GQKHXn3
 Su/ri+OFP1KOejctNpkYtl2RW8NnawIjw4Grn04s/fdl96qSci2OXt6lf2y6OySD+w/XLf4cdTO
 unBkA
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
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

The main use case for u-boot on Apple silicon based devices is to
provide an EFI based bootloader for operating systems. This uses a
generic u-boot image with DTBs passed from an earlier boot loader
(m1n1). Use the generic board name "mac" for this purpose.

Signed-off-by: Janne Grunau <j@jannau.net>
---
While investigating env related changes I did convert the env for Apple
M1 devices to board based text file. It turned out that no changes to
the env were necessary but the text based env is much nicer than the
C preprocessor SYS_CONFIG header. Since u-boot is used in generic way a
single generic board "mac" is enough.
---
 MAINTAINERS                        |  1 +
 arch/arm/mach-apple/Kconfig        | 16 +++++++++++++---
 arch/arm/mach-apple/rtkit_helper.c |  1 +
 board/apple/mac/mac.env            |  4 ++++
 configs/apple_m1_defconfig         |  2 ++
 drivers/iommu/apple_dart.c         |  1 +
 drivers/nvme/nvme_apple.c          |  1 +
 include/configs/apple.h            | 18 ------------------
 8 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d4b527560aa..ca1aae896d7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -131,6 +131,7 @@ M:	Mark Kettenis <kettenis@openbsd.org>
 S:	Maintained
 F:	arch/arm/include/asm/arch-apple/
 F:	arch/arm/mach-apple/
+F:	board/apple/
 F:	configs/apple_m1_defconfig
 F:	drivers/iommu/apple_dart.c
 F:	drivers/nvme/nvme_apple.c
diff --git a/arch/arm/mach-apple/Kconfig b/arch/arm/mach-apple/Kconfig
index 294690ec0e8..fdc8c32152f 100644
--- a/arch/arm/mach-apple/Kconfig
+++ b/arch/arm/mach-apple/Kconfig
@@ -3,12 +3,22 @@ if ARCH_APPLE
 config TEXT_BASE
 	default 0x00000000
 
-config SYS_CONFIG_NAME
-	default "apple"
-
 config SYS_SOC
 	default "apple"
 
+config SYS_VENDOR
+	default "apple"
+
+config SYS_BOARD
+	string "Board name"
+	default "mac"
+	help
+	  This option contains information about board name.
+	  Based on this option board/<CONFIG_SYS_VENDOR>/<CONFIG_SYS_BOARD> will
+	  be used.
+	  Apple silicon based devices are expected to use the generic board name
+	  "mac".
+
 config SYS_MALLOC_LEN
 	default 0x4000000
 
diff --git a/arch/arm/mach-apple/rtkit_helper.c b/arch/arm/mach-apple/rtkit_helper.c
index b7d60e15700..cbdc204f141 100644
--- a/arch/arm/mach-apple/rtkit_helper.c
+++ b/arch/arm/mach-apple/rtkit_helper.c
@@ -11,6 +11,7 @@
 #include <asm/io.h>
 #include <asm/arch/rtkit.h>
 #include <linux/iopoll.h>
+#include <linux/sizes.h>
 
 /* ASC registers */
 #define REG_CPU_CTRL		0x0044
diff --git a/board/apple/mac/mac.env b/board/apple/mac/mac.env
new file mode 100644
index 00000000000..109379c8c67
--- /dev/null
+++ b/board/apple/mac/mac.env
@@ -0,0 +1,4 @@
+stdin=serial,usbkbd,spikbd
+stdout=vidconsole,serial
+stderr=vidconsole,serial
+boot_targets=nvme usb
diff --git a/configs/apple_m1_defconfig b/configs/apple_m1_defconfig
index 1ce69f2882a..6020cd3f215 100644
--- a/configs/apple_m1_defconfig
+++ b/configs/apple_m1_defconfig
@@ -29,3 +29,5 @@ CONFIG_SYS_WHITE_ON_BLACK=y
 CONFIG_NO_FB_CLEAR=y
 CONFIG_VIDEO_SIMPLE=y
 CONFIG_GENERATE_SMBIOS_TABLE_VERBOSE=y
+CONFIG_SYS_VENDOR=apple
+CONFIG_SYS_BOARD=mac
diff --git a/drivers/iommu/apple_dart.c b/drivers/iommu/apple_dart.c
index bfd4ad20105..ebef28d0b9d 100644
--- a/drivers/iommu/apple_dart.c
+++ b/drivers/iommu/apple_dart.c
@@ -6,6 +6,7 @@
 #include <cpu_func.h>
 #include <dm.h>
 #include <iommu.h>
+#include <linux/sizes.h>
 #include <lmb.h>
 #include <memalign.h>
 #include <asm/io.h>
diff --git a/drivers/nvme/nvme_apple.c b/drivers/nvme/nvme_apple.c
index 7e7538553e3..94c1cf6e761 100644
--- a/drivers/nvme/nvme_apple.c
+++ b/drivers/nvme/nvme_apple.c
@@ -13,6 +13,7 @@
 #include <asm/arch/rtkit.h>
 #include <asm/arch/sart.h>
 #include <linux/iopoll.h>
+#include <linux/sizes.h>
 
 /* ASC registers */
 #define REG_CPU_CTRL		0x0044
diff --git a/include/configs/apple.h b/include/configs/apple.h
deleted file mode 100644
index 1e08b114480..00000000000
--- a/include/configs/apple.h
+++ /dev/null
@@ -1,18 +0,0 @@
-#ifndef __CONFIG_H
-#define __CONFIG_H
-
-#include <linux/sizes.h>
-
-/* Environment */
-#define ENV_DEVICE_SETTINGS \
-	"stdin=serial,usbkbd,spikbd\0" \
-	"stdout=vidconsole,serial\0" \
-	"stderr=vidconsole,serial\0"
-
-#define BOOT_TARGETS	"nvme usb"
-
-#define CFG_EXTRA_ENV_SETTINGS \
-	ENV_DEVICE_SETTINGS \
-	"boot_targets=" BOOT_TARGETS "\0"
-
-#endif

---
base-commit: 88dc2788777babfd6322fa655df549a019aa1e69
change-id: 20260501-apple-board-env-text-8e6054a2d388

Best regards,
-- 
Janne Grunau <j@jannau.net>

