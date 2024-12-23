Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F17BE7718B
	for <u-boot@archiver.kernel.org>; Mon, 23 Dec 2024 13:35:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D42680708;
	Mon, 23 Dec 2024 14:35:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="WLJwMe9w";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="FWppalkA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8537380704; Mon, 23 Dec 2024 14:35:28 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AE0A806D3
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 14:35:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4YGzY960FFz9slj;
 Mon, 23 Dec 2024 14:35:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734960925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=t90ofNZUOkqUSDx4ZjxCIMEUk4P+O+ff72j0VLQpZGI=;
 b=WLJwMe9wkPZnv/nP2kvkxC4HBRFEd62uGzejKDqe3nq3M8YPVj3sU3XGY0D6+l9SU6ccqu
 D9rd2qMKIsv5IuP59mrTuVGSdFgQqX1NDGofgiQqc8dSan+DNQ2O4FImVT1DXohe5mnZyB
 dsj0AaQ+rqsS2UgrgYaYF1cP0oaG6Lhj+fXOoXgEis7qUSQSmQmkqP45NE4tmQlwZFO+Ek
 eF+giTVPv6zjBhR3TSmlgU/UZrL/LHMCPtjCT6Yuuayg+EUHC3haKpuJwJzTinU9Oy+Q69
 UwOOyvdwH/907cMQWrDoV3cKo3f/dmpMCt2CnwWTTv/IHSdRzYZqy7LsEFfl5A==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734960923;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=t90ofNZUOkqUSDx4ZjxCIMEUk4P+O+ff72j0VLQpZGI=;
 b=FWppalkAR+yUVqIB4JoxYlxsG2msgtk6XD6Q/nryOoV980is4Il8Er6YE6DwBdjHkKPe0N
 vP+IBPwCDOGuzoAkcYO2dHna9rD96B2bTCto0qqhYVQtZLWzfCkNd242X7dQPRS5G9QMzK
 Onubr7MRySGfTwjn3/w0yRuO1w8DZ/AGV0dSM6pAoCADEcYeTv6rEHs8zZnNzNMuLm1ZpG
 dYWuaTupesihD1hAg70qjTOvX+ssnuqFgbD0k2TT6+8qMNymSDBE5puRv5/4W81S3wzQvh
 FtijhMQcnYdccqe73/D8rekGYE/cXsC88NFVEEqGB1fAfHvInlx37adiWW0NYg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hai Pham <hai.pham.ud@renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 01/16] pinctrl: renesas: Add Kconfig symbol for conditional
 build of full PFC tables
Date: Mon, 23 Dec 2024 14:34:05 +0100
Message-ID: <20241223133459.15748-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: be6ebea60667183a521
X-MBO-RS-META: dceimbj6breu17hocfobaf9qf678948i
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

By default the pin multiplexing tables used by U-Boot are reduced
to keep the size of the bootloader low. This option allows build of
full pin multiplexing tables the same way they are included in the
Linux kernel. This includes pin multiplexing options for Audio, CAN,
CANFD, DU, INTC, INTC-EX, MSIOF, PWM, SSI, for which there is no
U-Boot driver. This option is disabled by default.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Hai Pham <hai.pham.ud@renesas.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
V2: Drop default n from the Kconfig option, this is the default
---
 drivers/pinctrl/renesas/Kconfig | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/pinctrl/renesas/Kconfig b/drivers/pinctrl/renesas/Kconfig
index 57e88604aa2..7ced7d784b3 100644
--- a/drivers/pinctrl/renesas/Kconfig
+++ b/drivers/pinctrl/renesas/Kconfig
@@ -11,6 +11,17 @@ config PINCTRL_PFC
 	  both the GPIO definitions and pin control functions for each
 	  available multiplex function.
 
+config PINCTRL_PFC_FULL
+	bool "Renesas pin control drivers (full size)"
+	depends on PINCTRL_PFC
+	help
+	  By default the pin multiplexing tables used by U-Boot are reduced
+	  to keep the size of the bootloader low. Enable this option to use
+	  full pin multiplexing tables the same way they are included in the
+	  Linux kernel. This includes pin multiplexing options for Audio, CAN,
+	  CANFD, DU, INTC, INTC-EX, MSIOF, PWM, SSI, for which there is no
+	  U-Boot driver.
+
 config PINCTRL_PFC_R8A7790
 	bool "Renesas RCar Gen2 R8A7790 pin control driver"
 	depends on PINCTRL_PFC
-- 
2.45.2

