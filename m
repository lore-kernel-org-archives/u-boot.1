Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 784F9C4332F
	for <u-boot@archiver.kernel.org>; Tue, 12 Dec 2023 16:04:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E72E78780C;
	Tue, 12 Dec 2023 17:04:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="lcI1BxHP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD47587800; Tue, 12 Dec 2023 17:04:42 +0100 (CET)
Received: from mail.thorsis.com (mail.thorsis.com [92.198.35.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD720871CE
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 17:04:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from adahl by ada.ifak-system.com with local (Exim 4.94.2)
 (envelope-from <ada@thorsis.com>)
 id 1rD5FA-000BXm-QD; Tue, 12 Dec 2023 17:04:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=default;
 t=1702397079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/ktixV9t/4mjP8e9v6PJROCiBJC28mf8mTY2LEw4H64=;
 b=lcI1BxHPg79sWgj4WdzkNWrnZ6uEXEgrLhRArTUiK0jpukFYFcHkOo5hS6OMonkqwoPPjA
 FTt4SwNwRWVkBI3Zkz1GAQCk+fHXULOGsfc7k1HHkjxzcZdF+we5DgigifOWYJ84HboArG
 bRXCmViC4z+zsxU43e0Pegbg/JM/2CGc6ynd6QfD4lQi+n621kf4A+Z7ViP9NF10eDVjV0
 uh01nNSzgsK4gGt23z0So49uKm0A9vCoFTORXOgUJDDuPbSskc+e2ic09oCW0ydvPq+Qye
 UOoZ2kXhZb9WrgccWWZvZ37zOM+8hREzycglRriSuQeF00OBIdH1WZYKBuiqvQ==
From: Alexander Dahl <ada@thorsis.com>
To: u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>
Subject: [PATCH 4/4] mtd: nand: raw: atmel: Remove duplicate definitions
Date: Tue, 12 Dec 2023 17:04:23 +0100
Message-Id: <20231212160423.44290-5-ada@thorsis.com>
In-Reply-To: <20231212160423.44290-1-ada@thorsis.com>
References: <20231212160423.44290-1-ada@thorsis.com>
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

These removed definitions were specific to some sam9 SoCs, but not
generic over all at91 SoCs.  The correct SoC specific definitions for
ATMEL_BASE_PMECC are spread over different header files in
arch/arm/mach-at91/include/mach directory.

Fixes a build error on a custon board based on SAMA5D2:

    Building current source for 73 boards (16 threads, 1 job per thread)
           arm:  +   vera2
    +drivers/mtd/nand/raw/atmel/pmecc.c:819: warning: "ATMEL_BASE_PMECC" redefined
    +  819 | #define ATMEL_BASE_PMECC        0xffffe000
    +      |
    +In file included from include/configs/vera2.h:11,
    +                 from include/config.h:3,
    +                 from include/linux/mtd/rawnand.h:16,
    +                 from drivers/mtd/nand/raw/atmel/pmecc.c:44:
    +include/asm/arch/sama5d2.h:171: note: this is the location of the previous definition
    +  171 | #define ATMEL_BASE_PMECC        (ATMEL_BASE_HSMC + 0x70)
    +drivers/mtd/nand/raw/atmel/pmecc.c:820: warning: "ATMEL_BASE_PMERRLOC" redefined
    +  820 | #define ATMEL_BASE_PMERRLOC     0xffffe600
    +include/asm/arch/sama5d2.h:172: note: this is the location of the previous definition
    +  172 | #define ATMEL_BASE_PMERRLOC     (ATMEL_BASE_HSMC + 0x500)

Fixes: a490e1b7c017 ("nand: atmel: Add pmecc driver")
Signed-off-by: Alexander Dahl <ada@thorsis.com>
---
 drivers/mtd/nand/raw/atmel/pmecc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/atmel/pmecc.c b/drivers/mtd/nand/raw/atmel/pmecc.c
index e2e3f1ee6b5..51f6bd2e65b 100644
--- a/drivers/mtd/nand/raw/atmel/pmecc.c
+++ b/drivers/mtd/nand/raw/atmel/pmecc.c
@@ -816,9 +816,6 @@ int atmel_pmecc_wait_rdy(struct atmel_pmecc_user *user)
 }
 EXPORT_SYMBOL_GPL(atmel_pmecc_wait_rdy);
 
-#define ATMEL_BASE_PMECC	0xffffe000
-#define ATMEL_BASE_PMERRLOC	0xffffe600
-
 static struct atmel_pmecc *
 atmel_pmecc_create(struct udevice *dev,
 		   const struct atmel_pmecc_caps *caps,
-- 
2.39.2

