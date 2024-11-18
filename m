Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50EC0D10F40
	for <u-boot@archiver.kernel.org>; Mon, 18 Nov 2024 02:13:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 434C088E78;
	Mon, 18 Nov 2024 03:13:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="l3mDJFPJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69BEE893CD; Mon, 18 Nov 2024 03:13:17 +0100 (CET)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A28A288E5C
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 03:13:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=joel.stan@gmail.com
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-71e681bc315so2511089b3a.0
 for <u-boot@lists.denx.de>; Sun, 17 Nov 2024 18:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731895993; x=1732500793; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=FEbicabmU5UOw4HijVnBVlKQlcx09Y2EErBVr4zYXlE=;
 b=l3mDJFPJXOQ5ydNk4L7vcJDA0B1fz/mYgks0WSlfor2zIj90LxeQj2wiOoHjqypdTI
 erVdlTrpGaRMvKB/ymf1a5rxF1ZG9Qz/BbAQdeFzZKmXrCwPdO9mzhEq5wILh3xoHFxk
 68vSurBZAQegJlcopjFVQpM8QY+j1h4khOK8rT4VVy9saT4yZS5N0fzBsJHz6PWY3dLr
 HfTsHIFdgRu9RafTZhl+BT95WMKafetAuhDnJNxNn0oP2k9qU5U9nNahuNFw6/I9PNAb
 t7zoRQ7rQfAqQo9edTca6PifgmFPE+XDC7yFhDu5gy4QEY6d1CY850cg4B+8+b+1iNcV
 THPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731895993; x=1732500793;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FEbicabmU5UOw4HijVnBVlKQlcx09Y2EErBVr4zYXlE=;
 b=wpEErbmF+Ibi6frUOxqAkcvwjLaKOssdNxZ/Llg61wDxw/QfRpKfkbCtKstx77ymzB
 nvA5HhUs5g0q/kHRz95iI7ORUbXqX+CrnJkEUuR4Itq055hQjoXZOL8NATJ0HWX9ir50
 utRPDu3JPxWYHJ30Uf2jVPk/8ouhPXA3R3X2y4kutqYZdJx5d38Mu+rS86NcbpNUyoh+
 ufYf2mFMIB40sc0c2ccMZZhbfwtjTHChO2AM9beq5raki8DFCi86z1Zkxu9WTHX8weo5
 oCR+XOai3TUYjQwe+oULOuj5NFCKPaLJSMF6jbkQl6fznNW5NU+inbhDxHm4DsUPSpFE
 8MAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqKFWEZz/RPCoD2Hb54oRz1CtUzr7qZz1J3bXxiR2aj9sySBqPhH7zQj4L1RYUV3RIyXZJ9wI=@lists.denx.de
X-Gm-Message-State: AOJu0Yw3uaYkd9H+vR3K3PDsErDOflliVlBdy1X+ncepDnLDCN+Nt/Th
 sVS72c+JuCrWXq2FaXT/RxMhkBSfJ1Cbst5lRQSx8dE3h4q0/uU58tpJng==
X-Google-Smtp-Source: AGHT+IFvExST4P00gtSff1Ol81M8xWh24gJpCDVi0XBXZn0sAqYrlMCNc3O8TFZCZXEOxQ9rE5awLQ==
X-Received: by 2002:aa7:888e:0:b0:71e:71ba:9056 with SMTP id
 d2e1a72fcca58-724760cafafmr15688991b3a.10.1731895992807; 
 Sun, 17 Nov 2024 18:13:12 -0800 (PST)
Received: from prometheus.lan ([45.124.203.18])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7247720044asm5086549b3a.179.2024.11.17.18.13.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Nov 2024 18:13:12 -0800 (PST)
From: Joel Stanley <joel@jms.id.au>
To: Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Cc: BMC-SW@aspeedtech.com,
	u-boot@lists.denx.de
Subject: [PATCH] ast2600: spl: Use readl for reading mmio
Date: Mon, 18 Nov 2024 12:42:56 +1030
Message-ID: <20241118021257.4615-1-joel@jms.id.au>
X-Mailer: git-send-email 2.45.2
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

u-boot was crashing in qemu as the modeled hardware enforced overly
strict memory reads.

While this code will work on existing hardware, fix to avoid future issues.

Fixes: 12770d0df0e8 ("ast2600: spl: Add boot mode detection")
Link: https://gitlab.com/qemu-project/qemu/-/issues/2636
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
GCC 14 was using this sequence to read the value, leading to the
crash:

 ldrbpl.w	r0, [r0, #1280]	@ 0x500

 arch/arm/mach-aspeed/ast2600/spl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-aspeed/ast2600/spl.c b/arch/arm/mach-aspeed/ast2600/spl.c
index 05390c16f3af..0c5a82ed0947 100644
--- a/arch/arm/mach-aspeed/ast2600/spl.c
+++ b/arch/arm/mach-aspeed/ast2600/spl.c
@@ -45,10 +45,10 @@ u32 spl_boot_device(void)
 	}
 
 	/* boot from UART has higher priority */
-	if (scu->hwstrap2 & SCU_HWSTRAP2_BOOT_UART)
+	if (readl(&scu->hwstrap2) & SCU_HWSTRAP2_BOOT_UART)
 		return BOOT_DEVICE_UART;
 
-	if (scu->hwstrap1 & SCU_HWSTRAP1_BOOT_EMMC)
+	if (readl(&scu->hwstrap1) & SCU_HWSTRAP1_BOOT_EMMC)
 		return BOOT_DEVICE_MMC1;
 
 out:
-- 
2.45.2

