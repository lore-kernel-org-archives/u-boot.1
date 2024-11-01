Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAF13E6F061
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 14:21:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FB4B891DD;
	Fri,  1 Nov 2024 15:20:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F31E892E1; Fri,  1 Nov 2024 15:20:40 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id D3CAF892FB
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 15:20:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=abdellatif.elkhlifi@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D3F51007;
 Fri,  1 Nov 2024 07:21:07 -0700 (PDT)
Received: from e130802.cambridge.arm.com (e130802.arm.com [10.1.26.20])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9BE2C3F528;
 Fri,  1 Nov 2024 07:20:36 -0700 (PDT)
From: abdellatif.elkhlifi@arm.com
To: u-boot@lists.denx.de
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Subject: [PATCH 4/8] arm_ffa: sandbox: Replace the emulator error log with
 debug log
Date: Fri,  1 Nov 2024 14:20:13 +0000
Message-Id: <20241101142017.79311-5-abdellatif.elkhlifi@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241101142017.79311-1-abdellatif.elkhlifi@arm.com>
References: <20241101142017.79311-1-abdellatif.elkhlifi@arm.com>
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

Set the log to a debug log and reformulate the message

The message is about showing what the emulated FF-A ABI decided
based on the user arguments. The log is just for information purposes
and helpful when debugging.

Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
---
 drivers/firmware/arm-ffa/ffa-emul-uclass.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/arm-ffa/ffa-emul-uclass.c b/drivers/firmware/arm-ffa/ffa-emul-uclass.c
index 1521d9b66ac..3e8b5288d3b 100644
--- a/drivers/firmware/arm-ffa/ffa-emul-uclass.c
+++ b/drivers/firmware/arm-ffa/ffa-emul-uclass.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright 2022-2023 Arm Limited and/or its affiliates <open-source-office@arm.com>
+ * Copyright 2022-2024 Arm Limited and/or its affiliates <open-source-office@arm.com>
  *
  * Authors:
  *   Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
@@ -658,8 +658,7 @@ void sandbox_arm_ffa_smccc_smc(ffa_value_t *args, ffa_value_t *res)
 			args->a0);
 	}
 
-	if (ret != 0)
-		log_err("FF-A ABI internal failure (%d)\n", ret);
+	log_debug("Emulated FF-A ABI feedback (%d)\n", ret);
 }
 
 /**
-- 
2.25.1

