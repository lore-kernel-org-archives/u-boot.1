Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85A2DCD37B4
	for <u-boot@archiver.kernel.org>; Sun, 17 Sep 2023 14:10:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA17C86960;
	Sun, 17 Sep 2023 16:09:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="I9bBNxm8";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="DXkc/WZT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEA6A866DC; Sun, 17 Sep 2023 16:09:15 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B40F786552
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:09:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4RpVCs3Q38z9sWt
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:09:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694959753;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VR1i0Sk1uLFIGJWZEjynjf53kOcl9XlqiR/TLJDXAXo=;
 b=I9bBNxm8KLnKqBefUDlF1z2dpGijQdRfLNDGRxpo+ID1Z9bAsvUnzoItR0Rt751gBN0KlA
 EnZsNrUk2+ZiL/B8r9w61MNsJSPMKUv9s9Q4mGlQO2qGOoQSpLUYZ8TiKKBrvWx6eou6bP
 9y87R6HU0LF8w/FwmYlGOXNqwJEtSee1D/LpTQ6s1H55MjdV6rQEvbULLBAmj59Q86aVHb
 2pWYe9N8TMf/CPpIzTWaYYVqL/DV/kkRIV7HK4FUdfB4riNCwxq8qZ95F5cOqfAYz/Gpgx
 dWe8qYs3GxRPxmhbH07TWoSaFNiHIbnlI0eu6vZoSXCjXgcgHF2QbWLF2bE9MA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694959751;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VR1i0Sk1uLFIGJWZEjynjf53kOcl9XlqiR/TLJDXAXo=;
 b=DXkc/WZTwsm5JEamqcrqB3WqrCNkJB2eIyLCrRARVsOq5NXRlQEIIYcYNKaJjwtwFvTefs
 EC3TeF/gEIZ2fIBEMe6z6Bd0a0dpM5VtwKyLpjFdBS4XC/HciHAaP1VBy1x52oyooOznXp
 YbDvbTaHb/EBdc2q/QltunCYHCILVKc41PtzRKw/8DOSXfIrSnhYrfmBMralV45aai+Ceg
 C1V3BqP7/XP9p1WvxECUqfRXYdEwH22v9KAf3+pt07+L2ait+zYDoYZj/aA/B4Z3ZyWyWj
 gM9DkGpbXowjGFDovHYMRvVgN53Qm49J2ByhkE9n7zUF+ugB46V6T4X205OBZw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 08/18] pinctrl: renesas: Synchronize R8A7794 E2 PFC tables
 with Linux 6.5.3
Date: Sun, 17 Sep 2023 16:08:39 +0200
Message-Id: <20230917140849.379711-8-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230917140849.379711-1-marek.vasut+renesas@mailbox.org>
References: <20230917140849.379711-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: y9fd5t6owdbujkgszshohzyimg1h9sij
X-MBO-RS-ID: fe3dc82e41495b63548
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

Synchronize R-Car R8A7794 E2 PFC tables with Linux 6.5.3,
commit 238589d0f7b421aae18c5704dc931595019fa6c7 .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/pinctrl/renesas/pfc-r8a7794.c | 50 +++++++++++++--------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/pinctrl/renesas/pfc-r8a7794.c b/drivers/pinctrl/renesas/pfc-r8a7794.c
index 7ed54f0cfff..e5d125ceca0 100644
--- a/drivers/pinctrl/renesas/pfc-r8a7794.c
+++ b/drivers/pinctrl/renesas/pfc-r8a7794.c
@@ -43,30 +43,30 @@
 	PORT_GP_1(5, 25, fn, sfx),					\
 	PORT_GP_1(5, 26, fn, sfx),					\
 	PORT_GP_1(5, 27, fn, sfx),					\
-	PORT_GP_CFG_1(6, 0, fn, sfx, SH_PFC_PIN_CFG_IO_VOLTAGE),	\
-	PORT_GP_CFG_1(6, 1, fn, sfx, SH_PFC_PIN_CFG_IO_VOLTAGE | SH_PFC_PIN_CFG_PULL_UP),	\
-	PORT_GP_CFG_1(6, 2, fn, sfx, SH_PFC_PIN_CFG_IO_VOLTAGE | SH_PFC_PIN_CFG_PULL_UP),	\
-	PORT_GP_CFG_1(6, 3, fn, sfx, SH_PFC_PIN_CFG_IO_VOLTAGE | SH_PFC_PIN_CFG_PULL_UP),	\
-	PORT_GP_CFG_1(6, 4, fn, sfx, SH_PFC_PIN_CFG_IO_VOLTAGE | SH_PFC_PIN_CFG_PULL_UP),	\
-	PORT_GP_CFG_1(6, 5, fn, sfx, SH_PFC_PIN_CFG_IO_VOLTAGE | SH_PFC_PIN_CFG_PULL_UP),	\
-	PORT_GP_CFG_1(6, 6, fn, sfx, SH_PFC_PIN_CFG_IO_VOLTAGE | SH_PFC_PIN_CFG_PULL_UP),	\
-	PORT_GP_CFG_1(6, 7, fn, sfx, SH_PFC_PIN_CFG_IO_VOLTAGE | SH_PFC_PIN_CFG_PULL_UP),	\
-	PORT_GP_CFG_1(6, 8, fn, sfx, SH_PFC_PIN_CFG_IO_VOLTAGE),	\
-	PORT_GP_CFG_1(6, 9, fn, sfx, SH_PFC_PIN_CFG_IO_VOLTAGE | SH_PFC_PIN_CFG_PULL_UP),	\
-	PORT_GP_CFG_1(6, 10, fn, sfx, SH_PFC_PIN_CFG_IO_VOLTAGE | SH_PFC_PIN_CFG_PULL_UP),	\
-	PORT_GP_CFG_1(6, 11, fn, sfx, SH_PFC_PIN_CFG_IO_VOLTAGE | SH_PFC_PIN_CFG_PULL_UP),	\
-	PORT_GP_CFG_1(6, 12, fn, sfx, SH_PFC_PIN_CFG_IO_VOLTAGE | SH_PFC_PIN_CFG_PULL_UP),	\
-	PORT_GP_CFG_1(6, 13, fn, sfx, SH_PFC_PIN_CFG_IO_VOLTAGE | SH_PFC_PIN_CFG_PULL_UP),	\
-	PORT_GP_CFG_1(6, 14, fn, sfx, SH_PFC_PIN_CFG_IO_VOLTAGE | SH_PFC_PIN_CFG_PULL_UP),	\
-	PORT_GP_CFG_1(6, 15, fn, sfx, SH_PFC_PIN_CFG_IO_VOLTAGE | SH_PFC_PIN_CFG_PULL_UP),	\
-	PORT_GP_CFG_1(6, 16, fn, sfx, SH_PFC_PIN_CFG_IO_VOLTAGE),	\
-	PORT_GP_CFG_1(6, 17, fn, sfx, SH_PFC_PIN_CFG_IO_VOLTAGE | SH_PFC_PIN_CFG_PULL_UP),	\
-	PORT_GP_CFG_1(6, 18, fn, sfx, SH_PFC_PIN_CFG_IO_VOLTAGE | SH_PFC_PIN_CFG_PULL_UP),	\
-	PORT_GP_CFG_1(6, 19, fn, sfx, SH_PFC_PIN_CFG_IO_VOLTAGE | SH_PFC_PIN_CFG_PULL_UP),	\
-	PORT_GP_CFG_1(6, 20, fn, sfx, SH_PFC_PIN_CFG_IO_VOLTAGE | SH_PFC_PIN_CFG_PULL_UP),	\
-	PORT_GP_CFG_1(6, 21, fn, sfx, SH_PFC_PIN_CFG_IO_VOLTAGE | SH_PFC_PIN_CFG_PULL_UP),	\
-	PORT_GP_CFG_1(6, 22, fn, sfx, SH_PFC_PIN_CFG_IO_VOLTAGE | SH_PFC_PIN_CFG_PULL_UP),	\
-	PORT_GP_CFG_1(6, 23, fn, sfx, SH_PFC_PIN_CFG_IO_VOLTAGE | SH_PFC_PIN_CFG_PULL_UP),	\
+	PORT_GP_CFG_1(6, 0, fn, sfx, SH_PFC_PIN_CFG_IO_VOLTAGE_18_33),	\
+	PORT_GP_CFG_1(6, 1, fn, sfx, SH_PFC_PIN_CFG_IO_VOLTAGE_18_33 | SH_PFC_PIN_CFG_PULL_UP),	\
+	PORT_GP_CFG_1(6, 2, fn, sfx, SH_PFC_PIN_CFG_IO_VOLTAGE_18_33 | SH_PFC_PIN_CFG_PULL_UP),	\
+	PORT_GP_CFG_1(6, 3, fn, sfx, SH_PFC_PIN_CFG_IO_VOLTAGE_18_33 | SH_PFC_PIN_CFG_PULL_UP),	\
+	PORT_GP_CFG_1(6, 4, fn, sfx, SH_PFC_PIN_CFG_IO_VOLTAGE_18_33 | SH_PFC_PIN_CFG_PULL_UP),	\
+	PORT_GP_CFG_1(6, 5, fn, sfx, SH_PFC_PIN_CFG_IO_VOLTAGE_18_33 | SH_PFC_PIN_CFG_PULL_UP),	\
+	PORT_GP_CFG_1(6, 6, fn, sfx, SH_PFC_PIN_CFG_IO_VOLTAGE_18_33 | SH_PFC_PIN_CFG_PULL_UP),	\
+	PORT_GP_CFG_1(6, 7, fn, sfx, SH_PFC_PIN_CFG_IO_VOLTAGE_18_33 | SH_PFC_PIN_CFG_PULL_UP),	\
+	PORT_GP_CFG_1(6, 8, fn, sfx, SH_PFC_PIN_CFG_IO_VOLTAGE_18_33),	\
+	PORT_GP_CFG_1(6, 9, fn, sfx, SH_PFC_PIN_CFG_IO_VOLTAGE_18_33 | SH_PFC_PIN_CFG_PULL_UP),	\
+	PORT_GP_CFG_1(6, 10, fn, sfx, SH_PFC_PIN_CFG_IO_VOLTAGE_18_33 | SH_PFC_PIN_CFG_PULL_UP),	\
+	PORT_GP_CFG_1(6, 11, fn, sfx, SH_PFC_PIN_CFG_IO_VOLTAGE_18_33 | SH_PFC_PIN_CFG_PULL_UP),	\
+	PORT_GP_CFG_1(6, 12, fn, sfx, SH_PFC_PIN_CFG_IO_VOLTAGE_18_33 | SH_PFC_PIN_CFG_PULL_UP),	\
+	PORT_GP_CFG_1(6, 13, fn, sfx, SH_PFC_PIN_CFG_IO_VOLTAGE_18_33 | SH_PFC_PIN_CFG_PULL_UP),	\
+	PORT_GP_CFG_1(6, 14, fn, sfx, SH_PFC_PIN_CFG_IO_VOLTAGE_18_33 | SH_PFC_PIN_CFG_PULL_UP),	\
+	PORT_GP_CFG_1(6, 15, fn, sfx, SH_PFC_PIN_CFG_IO_VOLTAGE_18_33 | SH_PFC_PIN_CFG_PULL_UP),	\
+	PORT_GP_CFG_1(6, 16, fn, sfx, SH_PFC_PIN_CFG_IO_VOLTAGE_18_33),	\
+	PORT_GP_CFG_1(6, 17, fn, sfx, SH_PFC_PIN_CFG_IO_VOLTAGE_18_33 | SH_PFC_PIN_CFG_PULL_UP),	\
+	PORT_GP_CFG_1(6, 18, fn, sfx, SH_PFC_PIN_CFG_IO_VOLTAGE_18_33 | SH_PFC_PIN_CFG_PULL_UP),	\
+	PORT_GP_CFG_1(6, 19, fn, sfx, SH_PFC_PIN_CFG_IO_VOLTAGE_18_33 | SH_PFC_PIN_CFG_PULL_UP),	\
+	PORT_GP_CFG_1(6, 20, fn, sfx, SH_PFC_PIN_CFG_IO_VOLTAGE_18_33 | SH_PFC_PIN_CFG_PULL_UP),	\
+	PORT_GP_CFG_1(6, 21, fn, sfx, SH_PFC_PIN_CFG_IO_VOLTAGE_18_33 | SH_PFC_PIN_CFG_PULL_UP),	\
+	PORT_GP_CFG_1(6, 22, fn, sfx, SH_PFC_PIN_CFG_IO_VOLTAGE_18_33 | SH_PFC_PIN_CFG_PULL_UP),	\
+	PORT_GP_CFG_1(6, 23, fn, sfx, SH_PFC_PIN_CFG_IO_VOLTAGE_18_33 | SH_PFC_PIN_CFG_PULL_UP),	\
 	PORT_GP_CFG_1(6, 24, fn, sfx, SH_PFC_PIN_CFG_PULL_UP),		\
 	PORT_GP_CFG_1(6, 25, fn, sfx, SH_PFC_PIN_CFG_PULL_UP)
 
@@ -5513,7 +5513,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		FN_SEL_SSI9_0, FN_SEL_SSI9_1,
 		/* RESERVED [12] */ ))
 	},
-	{ },
+	{ /* sentinel */ }
 };
 
 static int r8a7794_pin_to_pocctrl(unsigned int pin, u32 *pocctrl)
-- 
2.40.1

