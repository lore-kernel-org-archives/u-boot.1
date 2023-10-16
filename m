Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E7C7CDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 14:17:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CEEB86E7C;
	Mon, 16 Oct 2023 16:16:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="F2b1b4hD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C679A86335; Mon, 16 Oct 2023 16:14:41 +0200 (CEST)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net
 [217.70.183.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92B0F86BD7
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 16:14:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thomas.richard@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A10CC2000B;
 Mon, 16 Oct 2023 14:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1697465673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IIGcbfM9cWDCBx53qjPcCxYqgnJscFJdSuWQvvQY8SU=;
 b=F2b1b4hDjnS9IukkQDnhk93kjakoETKiEB92yfm7ZYqebRbpqXNCoRLtQG8mYCUtSn/F+X
 a+KcE79VyDDFP+GaVafCevUIP7+6JTXvDCzqVC1fJSju0XZT2x9X4IFBKjdZTg1NIm4qZ1
 bb/R1ImCCx37X80TGiZlvIYpd0zrKLeUzRUpO3QhUDX0A12mjHzyBHIWp+s8UY17lySTcS
 qplubcitlz8GBI2eEb8/foJHGQScECbLdn76QsVYkal2e0vA5ZgFnZANeHNXIc0wReK1/s
 dNahkb3YWuhv9JQM7CXm60X5AwaX/NdCqxgqKWuqYIhXO0hUO2NLkISEGwwQvw==
From: Thomas Richard <thomas.richard@bootlin.com>
To: u-boot@lists.denx.de
Cc: nm@ti.com, thomas.petazzoni@bootlin.com, thomas.richard@bootlin.com,
 gregory.clement@bootlin.com, u-kumar1@ti.com, Tom Rini <trini@konsulko.com>
Subject: [PATCH 6/9] board: ti: j721e: Add the missing part of exit retention
 for k3-ddrss (J7200)
Date: Mon, 16 Oct 2023 16:11:32 +0200
Message-Id: <20231016141135.325698-7-thomas.richard@bootlin.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231016141135.325698-1-thomas.richard@bootlin.com>
References: <20231016141135.325698-1-thomas.richard@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: thomas.richard@bootlin.com
X-Mailman-Approved-At: Mon, 16 Oct 2023 16:15:29 +0200
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

Add the board specific part of the exit retention sequence for k3-ddrss

Based on the work of Gregory CLEMENT <gregory.clement@bootlin.com>

Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---

 board/ti/j721e/evm.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/board/ti/j721e/evm.c b/board/ti/j721e/evm.c
index b4b94c8c69..e6f46f911a 100644
--- a/board/ti/j721e/evm.c
+++ b/board/ti/j721e/evm.c
@@ -533,15 +533,22 @@ err_free_gpio:
 
 #if (IS_ENABLED(CONFIG_SPL_BUILD) && IS_ENABLED(CONFIG_TARGET_J7200_R5_EVM))
 
+static struct udevice *pmica;
+static struct udevice *pmicb;
+
+#define GPIO_OUT_1        0x3D
+
 #define SCRATCH_PAD_REG_3 0xCB
 
 #define MAGIC_SUSPEND 0xBA
 
+#define DDR_RET_VAL BIT(1)
+#define DDR_RET_CLK BIT(2)
+
 static int resuming = -1;
 
 int board_is_resuming(void)
 {
-	struct udevice *pmica, *pmicb;
 	int ret;
 
 	if (resuming >= 0)
@@ -580,6 +587,24 @@ end:
 	return resuming;
 }
 
+void board_k3_ddrss_lpddr4_release_retention(void)
+{
+	int regval;
+
+	/* Set DDR_RET Signal Low on PMIC B */
+	regval = pmic_reg_read(pmicb, GPIO_OUT_1) & ~DDR_RET_VAL;
+
+	pmic_reg_write(pmicb, GPIO_OUT_1, regval);
+
+	/* Now toggle the CLK of the latch for DDR ret */
+	pmic_reg_write(pmicb, GPIO_OUT_1, regval | DDR_RET_CLK);
+	pmic_reg_write(pmicb, GPIO_OUT_1, regval & ~(DDR_RET_CLK));
+	pmic_reg_write(pmicb, GPIO_OUT_1, regval | DDR_RET_CLK);
+	pmic_reg_write(pmicb, GPIO_OUT_1, regval & ~(DDR_RET_CLK));
+
+	pmic_reg_write(pmica, 0x86, 0x3);
+}
+
 #endif /* CONFIG_SPL_BUILD && CONFIG_TARGET_J7200_R5_EVM */
 
 void spl_board_init(void)
-- 
2.39.2

