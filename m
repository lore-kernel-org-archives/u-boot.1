Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC09AE8782A
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 13:37:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DA7D8421D;
	Tue,  3 Feb 2026 14:35:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="VYQQaboA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5567E84101; Tue,  3 Feb 2026 14:09:05 +0100 (CET)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0CDE840B1
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 14:09:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id A633D26526;
 Tue,  3 Feb 2026 14:09:01 +0100 (CET)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9ZgMIaqXQGx8; Tue,  3 Feb 2026 14:09:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1770124141; bh=gLNRHFzfGF5WEAvUGW512eFt7jTDHdvbz3VcbWEkEbI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=VYQQaboAuJVUCtBz7tSBe7cZh1lsujrtq6mjiAZC7aERA4cDB6FqXcfUTwc59EKTv
 +imyxcvpom1HlDJj2TFQdaZu878meH1NgCGPOw828t2+tso/qdmTyM71srJF5KMdKC
 XoQnhnHsCgN+AXlQu2YsG4TbgdQbJCdIZ9kQVyifZx53Cdq+zA8OH17xyrQniizzp1
 Pg1IEtuSJ2xtf8pLhllyj3tvoghTc4YqTDSL0YNFw+/zCzCaSk0l+MPZ3Wq5Zf5SfB
 d6e1UfYKf1pD2wshcpX3UIzFrhk0muXKQyrys+Y8fTj6H0rWN7Am3DqZoAYLQhKWQn
 f58ihtpHievDw==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Tue, 03 Feb 2026 18:38:43 +0530
Subject: [PATCH 05/11] configs: exynos-mobile: remove DEFAULT_DEVICE_TREE
 and add OF_UPSTREAM_BUILD_VENDOR
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260203-exynos-mobile-external-dtb-v1-5-a16a0e57991c@disroot.org>
References: <20260203-exynos-mobile-external-dtb-v1-0-a16a0e57991c@disroot.org>
In-Reply-To: <20260203-exynos-mobile-external-dtb-v1-0-a16a0e57991c@disroot.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
X-Mailman-Approved-At: Tue, 03 Feb 2026 14:35:06 +0100
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

Since the build documentation recommends using the DEVICE_TREE= make
flag, and the "board" supports multiple devices, remove the default
device tree option so as to enforce the make flag during build.

OF_UPSTREAM_BUILD_VENDOR is added so as to build all device trees
associated with the vendor with their U-Boot includes.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 configs/exynos-mobile_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/exynos-mobile_defconfig b/configs/exynos-mobile_defconfig
index 846f9e24bd3..c7d206f94ac 100644
--- a/configs/exynos-mobile_defconfig
+++ b/configs/exynos-mobile_defconfig
@@ -7,7 +7,6 @@ CONFIG_SYS_MALLOC_LEN=0x2000000
 CONFIG_SYS_MALLOC_F_LEN=0x16000
 CONFIG_TARGET_EXYNOS_MOBILE=y
 CONFIG_NR_DRAM_BANKS=3
-CONFIG_DEFAULT_DEVICE_TREE="exynos/exynos7870-a2corelte"
 CONFIG_SYS_BOOTM_LEN=0x2000000
 CONFIG_SYS_LOAD_ADDR=0x80000000
 CONFIG_ARMV8_CNTFRQ_BROKEN=y
@@ -26,6 +25,7 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_EFI_PARTITION=y
 CONFIG_OF_UPSTREAM=y
 CONFIG_OF_BOARD=y
+CONFIG_OF_UPSTREAM_BUILD_VENDOR=y
 CONFIG_BUTTON=y
 CONFIG_BUTTON_REMAP_PHONE_KEYS=y
 CONFIG_CLK_EXYNOS7870=y

-- 
2.52.0

