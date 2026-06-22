Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA036CD98F0
	for <u-boot@archiver.kernel.org>; Mon, 22 Jun 2026 00:05:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 220358467F;
	Mon, 22 Jun 2026 02:05:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="djZevJXy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F9CF84832; Mon, 22 Jun 2026 02:05:42 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83309842FC
 for <u-boot@lists.denx.de>; Mon, 22 Jun 2026 02:05:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7F781116C96; Mon, 22 Jun 2026 02:05:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1782086738; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=zHCjd4f1wTw6D73Cjj8T7Z5FkN1UrWRWKSH6X7t31RA=;
 b=djZevJXyp/ES+zFsKkxWpvP8AU5G9za/QKZM347JEIvlydiyZRB6+sO5bkEBs/tYRrYf0w
 BGHi2oZX4uLH95/ks8K735yVNEZ3zHTla4xlAAlH6MXzEPlmJ+dDdIjjYG27WuEk9od4cj
 jo7hEY/cqNQW/GVucC0QEJfbH8d1rsElYe3BHStrSUgM9Z+d/vboLSyGXFwgQMDeycYQrv
 V6xnUhHoRddqX5japKI4GeW9V3WxNllgLzgwNFB5FVFgtK+f58ZQfvWh1frm8fqqAzrn0X
 nQZuCbSpGmqoOLQHWRJes2LOin8VCdH3LuRR5p/W1HREbsT4/eciVKddfnQThw==
From: Marek Vasut <marex@nabladev.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@nabladev.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH] treewide: Fix STMicroelectronics spelling
Date: Mon, 22 Jun 2026 02:05:10 +0200
Message-ID: <20260622000535.226234-1-marex@nabladev.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Fix STMicroelectronics spelling in comments.

Signed-off-by: Marek Vasut <marex@nabladev.com>
---
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@dh-electronics.com
Cc: u-boot@lists.denx.de
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
 include/configs/stm32mp21_st_common.h | 2 +-
 include/configs/stm32mp23_st_common.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/configs/stm32mp21_st_common.h b/include/configs/stm32mp21_st_common.h
index c601f2d7fb6..bca4c4b5337 100644
--- a/include/configs/stm32mp21_st_common.h
+++ b/include/configs/stm32mp21_st_common.h
@@ -2,7 +2,7 @@
 /*
  * Copyright (C) 2026, STMicroelectronics - All Rights Reserved
  *
- * Configuration settings for the STMicroelectonics STM32MP21x boards
+ * Configuration settings for the STMicroelectronics STM32MP21x boards
  */
 
 #ifndef __CONFIG_STM32MP21_ST_COMMON_H__
diff --git a/include/configs/stm32mp23_st_common.h b/include/configs/stm32mp23_st_common.h
index 0c5c2fbef87..547c230ae90 100644
--- a/include/configs/stm32mp23_st_common.h
+++ b/include/configs/stm32mp23_st_common.h
@@ -2,7 +2,7 @@
 /*
  * Copyright (C) 2025, STMicroelectronics - All Rights Reserved
  *
- * Configuration settings for the STMicroelectonics STM32MP23x boards
+ * Configuration settings for the STMicroelectronics STM32MP23x boards
  */
 
 #ifndef __CONFIG_STM32MP23_ST_COMMON_H__
-- 
2.53.0

