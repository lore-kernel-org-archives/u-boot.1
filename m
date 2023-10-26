Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9030C25B6E
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 12:51:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E94787613;
	Thu, 26 Oct 2023 14:51:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33C1B87B65; Thu, 26 Oct 2023 14:51:09 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 474BF87617
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 14:51:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=abdellatif.elkhlifi@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F8B01424;
 Thu, 26 Oct 2023 05:51:47 -0700 (PDT)
Received: from e130802.arm.com (unknown [10.57.2.111])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8764E3F64C;
 Thu, 26 Oct 2023 05:51:04 -0700 (PDT)
From: abdellatif.elkhlifi@arm.com
To: u-boot@lists.denx.de
Cc: nd@arm.com, trini@konsulko.com,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Rui Miguel Silva <rui.silva@linaro.org>
Subject: [PATCH 2/3] corstone1000: enable distro booting command
Date: Thu, 26 Oct 2023 13:50:50 +0100
Message-Id: <20231026125051.321493-3-abdellatif.elkhlifi@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231026125051.321493-1-abdellatif.elkhlifi@arm.com>
References: <20231026125051.321493-1-abdellatif.elkhlifi@arm.com>
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

From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>

enable distro_bootcmd

Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Signed-off-by: Rui Miguel Silva <rui.silva@linaro.org>
---
 include/configs/corstone1000.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/configs/corstone1000.h b/include/configs/corstone1000.h
index 3347c11792..3ada21cbba 100644
--- a/include/configs/corstone1000.h
+++ b/include/configs/corstone1000.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * (C) Copyright 2022 ARM Limited
+ * Copyright 2022-2023 Arm Limited and/or its affiliates <open-source-office@arm.com>
  * (C) Copyright 2022 Linaro
  * Rui Miguel Silva <rui.silva@linaro.org>
  * Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
@@ -29,5 +29,6 @@
 
 #include <config_distro_bootcmd.h>
 
+#define CFG_EXTRA_ENV_SETTINGS BOOTENV
 
 #endif
-- 
2.25.1

