Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05252CD37B4
	for <u-boot@archiver.kernel.org>; Sun, 17 Sep 2023 14:09:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67595868D0;
	Sun, 17 Sep 2023 16:09:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="hbkEl2ZG";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="E8efVVcr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25C088658D; Sun, 17 Sep 2023 16:09:14 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 558E2864D9
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:09:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4RpVCr0blZz9sWt
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:09:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694959752;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Se8j9af/3TzdtMs3vyO5lUUHuLLukoKLRgY6kZ+KbHg=;
 b=hbkEl2ZGg6Rgt1eCNrOMNcb4oo6M40+RjthShjbqsvxodg9aVnU2gzFr9oesV2SwHks+Jr
 WFON4oUZNEcJDhMHguMcT1kvzCqfX8IL5hchBoEm1saa+rsRU+DPOW0i74UmlO1Szn0T8a
 LU/WCYO6mxlpI7qp/NrDr/j8R9w9nkKx8+UyBRWMCLOWdWgnQ6QKnBVXQFHLDk6Mn7aqZR
 UBAnCVlHrW1Q/SSJs8CVwKowk6TAgJiqE6FaEt1tYUag+u5Xh5xMxH+GKfoBB255382KpG
 rl49qXswdkWfOVlX68h25el4fJrGTIPVbgjxyX2rW/xcsadXiSvXW4ckfgHeIQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694959750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Se8j9af/3TzdtMs3vyO5lUUHuLLukoKLRgY6kZ+KbHg=;
 b=E8efVVcr3O8rGhYCoRs/z+J5+9IrjsWCtgGtZf8v9qOf6fPN7p/luXpvU2CfbC7b89/gk6
 vqijbSIWlaIPy0ZC8j80PQw6NKCS/+P1HRAfEaGyAoAllsAHMmWSJypxeZRWhuySDbBvax
 OFkAEIKxh+6ZuybGmSyHgEOaiWOMMrOs0cfvMBBxbKiW1LZUubWkbJdB6Rw3qnDHSxxmeb
 xOYkFawK21+IQO4xK1rG1SNFwOOKZcfPJYHpC14OVpaXmYcvhGdnhq5f7ojMzW773nZzqp
 oenpxoHDuV99SipzYDgvVdIH9Z+LfCX3uZSIiifSir70JhybHyL/kUrv3dXZ1w==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 05/18] pinctrl: renesas: Synchronize R8A7790 H2 PFC tables
 with Linux 6.5.3
Date: Sun, 17 Sep 2023 16:08:36 +0200
Message-Id: <20230917140849.379711-5-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230917140849.379711-1-marek.vasut+renesas@mailbox.org>
References: <20230917140849.379711-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 5165bd18a17b860da3b
X-MBO-RS-META: 375rdxrdyj3g5ofdodb1bcdw4myk9or6
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

Synchronize R-Car R8A7790 H2 PFC tables with Linux 6.5.3,
commit 238589d0f7b421aae18c5704dc931595019fa6c7 .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/pinctrl/renesas/pfc-r8a7790.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/renesas/pfc-r8a7790.c b/drivers/pinctrl/renesas/pfc-r8a7790.c
index 432895ac55c..7203648bbc8 100644
--- a/drivers/pinctrl/renesas/pfc-r8a7790.c
+++ b/drivers/pinctrl/renesas/pfc-r8a7790.c
@@ -24,7 +24,7 @@
 	PORT_GP_CFG_32(0, fn, sfx, SH_PFC_PIN_CFG_PULL_UP),		\
 	PORT_GP_CFG_30(1, fn, sfx, SH_PFC_PIN_CFG_PULL_UP),		\
 	PORT_GP_CFG_30(2, fn, sfx, SH_PFC_PIN_CFG_PULL_UP),		\
-	PORT_GP_CFG_32(3, fn, sfx, SH_PFC_PIN_CFG_IO_VOLTAGE | SH_PFC_PIN_CFG_PULL_UP),	\
+	PORT_GP_CFG_32(3, fn, sfx, SH_PFC_PIN_CFG_IO_VOLTAGE_18_33 | SH_PFC_PIN_CFG_PULL_UP),	\
 	PORT_GP_CFG_32(4, fn, sfx, SH_PFC_PIN_CFG_PULL_UP),		\
 	PORT_GP_CFG_32(5, fn, sfx, SH_PFC_PIN_CFG_PULL_UP)
 
@@ -5824,7 +5824,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		/* SEL_I2C1 [2] */
 		FN_SEL_I2C1_0, FN_SEL_I2C1_1, FN_SEL_I2C1_2, 0, ))
 	},
-	{ },
+	{ /* sentinel */ }
 };
 
 static int r8a7790_pin_to_pocctrl(unsigned int pin, u32 *pocctrl)
-- 
2.40.1

