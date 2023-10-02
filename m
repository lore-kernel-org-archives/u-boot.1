Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E1E2E784BE
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 15:52:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13EBB86D93;
	Mon,  2 Oct 2023 17:52:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1696261978;
	bh=SLXmvksH1Na1s2XQNb3A3scqduaxIH3hK8lzOSFh+gM=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=T1EY1RvRCSZYPof7sGubXeLtVFDszq8eDJyFUob3EsifwcM8IOMPCLwU3jvh9wEFO
	 BrtS8DO6oEU/T7R5gkgLQ/08AaVwRUX7jKWOUUw3RHQPnbZDa7S5J9oaDZdCoKgnqC
	 +rpIwIgS1lG5fi/Uynl5X9eZGPQBC8NKLGgj4/U/D2qH4SCiFUpey/al1MZ9bvwCs3
	 EHssiUkmzeE+oTldZdM8wfD8bDPKyG9g45+dRa+t63kECikgTTKASKz8Z7EjKaZv/Q
	 lTbpNl6kJKaZAMCMZ444IX/KOkc/3++7NkvGYPbZJj/TWtVqJJw3D2/S2524119JIA
	 8a0DIwxPTnzEg==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 94A4186459;
 Mon,  2 Oct 2023 17:52:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1696261976;
 bh=SLXmvksH1Na1s2XQNb3A3scqduaxIH3hK8lzOSFh+gM=;
 h=From:To:Cc:Subject:Date:From;
 b=rgJ0pKOyWJXFJFXwyxaGLHzjozoHyu7GIVAW+DKcpCzrJRHLywPGfccDZqjff13Nv
 N5A8FfPnkTGwZA33UFxbX2KT85V69oCjOG4TPPwF531HdO811u5Vp1JvBvlKgimtkk
 0IyUC1ihurlfwhbcwjNvM5J3+omyIInV956r8T3/jy9RBtktvsK4z2CTQ0A+eXURGs
 Owl1uHWiKvtu6dqYBqqq0CZqeDu8EfzZ5UwF4vVYOLdVNrfC0Sd7oo+KoHrYJDx/MH
 lRq4k+ZjPtbHSd4ykVVCOklhPlMOZJYp7Rg19NPAr162AI43jZzRewzI84CVQjvLF6
 AD7ulvk1ZJSbg==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 1/2] ARM: stm32: Rename update_sf to dh_update_sd_to_sf on
 STM32MP15xx DHCOR
Date: Mon,  2 Oct 2023 17:52:33 +0200
Message-Id: <20231002155234.138630-1-marex@denx.de>
X-Mailer: git-send-email 2.40.1
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

Align the script name with DH i.MX8MP DHCOM script name. Add
backward compatibility script to avoid breaking user scripts.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: u-boot@dh-electronics.com
Cc: u-boot@lists.denx.de
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
 include/configs/stm32mp15_dh_dhsom.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/configs/stm32mp15_dh_dhsom.h b/include/configs/stm32mp15_dh_dhsom.h
index 91921690624..c7ebf5cd180 100644
--- a/include/configs/stm32mp15_dh_dhsom.h
+++ b/include/configs/stm32mp15_dh_dhsom.h
@@ -20,7 +20,7 @@
 
 #define STM32MP_BOARD_EXTRA_ENV \
 	"usb_pgood_delay=1000\0" \
-	"update_sf=" /* Erase SPI NOR and install U-Boot from SD */	\
+	"dh_update_sd_to_sf=" /* Erase SPI NOR and install U-Boot from SD */ \
 		"setexpr loadaddr1 ${loadaddr} + 0x1000000 && "		\
 		"load mmc 0:4 ${loadaddr1} /boot/u-boot-spl.stm32 && "	\
 		"env set filesize1 ${filesize} && "			\
@@ -29,7 +29,9 @@
 		"sf update ${loadaddr1} 0 ${filesize1} && "		\
 		"sf update ${loadaddr1} 0x40000 ${filesize1} && "	\
 		"sf update ${loadaddr} 0x80000 ${filesize} && "		\
-		"env set filesize1 && env set loadaddr1\0"
+		"env set filesize1 && env set loadaddr1\0"		\
+	"update_sf=run dh_update_sd_to_sf\0"
+
 
 #include <configs/stm32mp15_common.h>
 
-- 
2.40.1

