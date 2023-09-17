Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48390CD37B3
	for <u-boot@archiver.kernel.org>; Sun, 17 Sep 2023 14:10:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A8A28658D;
	Sun, 17 Sep 2023 16:09:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="eeFjoceo";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ZJfBD8EB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B983867EF; Sun, 17 Sep 2023 16:09:15 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 882AB86611
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:09:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4RpVCr3KcJz9sWt
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:09:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694959752;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4aNIOkbhsEEOXRqQS9KBPN5mNdQUU4rNcDxjbtV7ou0=;
 b=eeFjoceoTEbgktgAZY8S9EzqAkKhqyVzszLigUrAgQId5v6itPP/VPfOKoNDjeK92o6mMU
 fVB4zW8IRTMHvBIZwVn7/3V8jG0dV9Use4zjsJauMON9cp0nlYJEjZvECM0hweEdxv1P8v
 hGnw/1SPQRlF46qf4U5CKFCf/vqqnnhIf08tLzw8mcmKMuVpuf4EAY44WdFrw2kbn0wt1Q
 8Scq7HjWKrHerx/hl6vE2KB8Shf9JdIPX9gSAQB7XSg3NAp1BGx58mKDyKo79iU2ALM6RG
 7ON/NI+AhfUS5sNiYcKwLqiIASSb09yqD2+ePigpjSSFec2Qw0szj1U2VvIHaQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694959750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4aNIOkbhsEEOXRqQS9KBPN5mNdQUU4rNcDxjbtV7ou0=;
 b=ZJfBD8EBTfdvAjL7vhnZVV58PIW17wp5dlmhhYMmpcG/Xs+3G7YA9w8JywspNtlt9af8uJ
 zgee4uAPwyBQ/r42HcwpUqcwbGVaFJKdW17TtBTKhifbOXyCypkDK23ftT8+sB5Y4hSP9J
 vHN3C3/vb76u1aUpvuZU41hZKkzIwPk+KJN4z/MwFSQIKhF48pSwqhVQbb0kugr+vtWPmg
 yKGDx50wbsSKFvRjEWBqtY1WEwZ6oRiry4Oa9OFStV8bgNRkx4vphCctvpxuvYXvHnMwOF
 OTQkishKLPSVeEl/Yn2QN94cB/2TJ5ICHw79CNpmHnFgd/TCvkpbKU+KYApjkQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 06/18] pinctrl: renesas: Synchronize R8A7791 M2-W and R8A7793
 M2-N PFC tables with Linux 6.5.3
Date: Sun, 17 Sep 2023 16:08:37 +0200
Message-Id: <20230917140849.379711-6-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230917140849.379711-1-marek.vasut+renesas@mailbox.org>
References: <20230917140849.379711-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 52bc846d17f78d6c760
X-MBO-RS-META: sh3sz93mnrshrgiexiwffmusw6zzxkkp
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

Synchronize R-Car R8A7791 M2-W and R8A7793 M2-N PFC tables with Linux 6.5.3,
commit 238589d0f7b421aae18c5704dc931595019fa6c7 .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/pinctrl/renesas/pfc-r8a7791.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/renesas/pfc-r8a7791.c b/drivers/pinctrl/renesas/pfc-r8a7791.c
index 219333106fc..b25453ed285 100644
--- a/drivers/pinctrl/renesas/pfc-r8a7791.c
+++ b/drivers/pinctrl/renesas/pfc-r8a7791.c
@@ -25,7 +25,7 @@
 	PORT_GP_CFG_32(3, fn, sfx, SH_PFC_PIN_CFG_PULL_UP),		\
 	PORT_GP_CFG_32(4, fn, sfx, SH_PFC_PIN_CFG_PULL_UP),		\
 	PORT_GP_CFG_32(5, fn, sfx, SH_PFC_PIN_CFG_PULL_UP),		\
-	PORT_GP_CFG_24(6, fn, sfx, SH_PFC_PIN_CFG_IO_VOLTAGE | SH_PFC_PIN_CFG_PULL_UP),	\
+	PORT_GP_CFG_24(6, fn, sfx, SH_PFC_PIN_CFG_IO_VOLTAGE_18_33 | SH_PFC_PIN_CFG_PULL_UP),	\
 	PORT_GP_CFG_1(6, 24, fn, sfx, SH_PFC_PIN_CFG_PULL_UP),		\
 	PORT_GP_CFG_1(6, 25, fn, sfx, SH_PFC_PIN_CFG_PULL_UP),		\
 	PORT_GP_CFG_1(6, 26, fn, sfx, SH_PFC_PIN_CFG_PULL_UP),		\
@@ -6555,7 +6555,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		FN_SEL_SSP_0, FN_SEL_SSP_1, FN_SEL_SSP_2, 0,
 		/* RESERVED [6] */ ))
 	},
-	{ },
+	{ /* sentinel */ }
 };
 
 static int r8a7791_pin_to_pocctrl(unsigned int pin, u32 *pocctrl)
@@ -6877,7 +6877,7 @@ static const struct pinmux_bias_reg pinmux_bias_regs[] = {
 		[30] = SH_PFC_PIN_NONE,
 		[31] = SH_PFC_PIN_NONE,
 	} },
-	{ /* sentinel */ },
+	{ /* sentinel */ }
 };
 
 static const struct sh_pfc_soc_operations r8a7791_pfc_ops = {
-- 
2.40.1

