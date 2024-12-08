Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8803AE7717F
	for <u-boot@archiver.kernel.org>; Sun,  8 Dec 2024 22:08:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78B76895F1;
	Sun,  8 Dec 2024 23:06:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="oqLe+lNb";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="RvB8Ozkc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 327FE893AE; Sun,  8 Dec 2024 23:06:30 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5BCC8958B
 for <u-boot@lists.denx.de>; Sun,  8 Dec 2024 23:06:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Y5zbl46zgz9sdQ;
 Sun,  8 Dec 2024 23:06:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1733695587;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5xOI4fUL0Z8ePV8zl1LD/n+UV73EcyH4luxrXKf1OPA=;
 b=oqLe+lNbVJ6YWDDD8hEym3xigqQS1RizK9mqNVZW67KgBla7u3Ps0RlytXwH0koVe9ww9C
 mYGEC2/GipfeewG4jVXb6bNZQ2a42G/LczI6iyUpNUQmNBf4C6fVDyIzztq9jBPJ8g/U1f
 LfQMF+4iMQh3yKmCO2vv1czZbsYFVUzvzoHsMcGRlEQxs0Z0N6jS6wXQNmohu386vrsbYX
 cMYHcRYZDHg0P1oyQabkvmYLDj5vjdOxlEoRnm0LRPxsAyhYZq9dn7IiAySuAQbxfBrshS
 5yDOBg/946r0y41SXq8Qrht1CQA29JVXbNPtJibe9likADZZLp/oZMM6BQBQ4Q==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1733695585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5xOI4fUL0Z8ePV8zl1LD/n+UV73EcyH4luxrXKf1OPA=;
 b=RvB8OzkcItNvIsiWwziLGAgq/6IAvHNhc9hoUzzBX0aHsy5AyWMs0YSXHvegXlDR6ijRfg
 Ge31DLfSi4Lg7hC8TgLVqhDAM4d73j14kxsGE1Lx5RaepXCXvnsmGOGWBWE9ta99Cdt9Kt
 M+BZGMxSGoJy1OQMt8GZzbvwRum2r6AtKmuF+CLhYMI20KAtohp7O8ey/NVrmhWfIX0Fv9
 xO0WiLlvSy2+nhMR/HWLbDuDrZypkjFvne0BnynZfE64IMdOlWYovkk/XlRNJI8I1j+N7Z
 9hlgGryqGHjha2CxH2JtA2H5Kl6lajjhb3bcdScV8nhPyp5Fm9hP7BPJEgGByg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 11/13] serial: renesas: Fix R-Car spelling
Date: Sun,  8 Dec 2024 23:04:04 +0100
Message-ID: <20241208220551.204743-11-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20241208220551.204743-1-marek.vasut+renesas@mailbox.org>
References: <20241208220551.204743-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: goiibem88jqerjycdemjjfizfyb8c9au
X-MBO-RS-ID: 1af4b4972f4b8033c23
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

The correct spelling is R-Car, including the dash, update the usage.
Kconfig strings and comment changes only, no functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/serial/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index 8b27ad9a77e..c4f4a8d78df 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -920,7 +920,7 @@ config SCIF_CONSOLE
 	depends on SH || ARCH_RENESAS
 	help
 	  Select this to enable Renesas SCIF UART. To operate serial ports
-	  on systems with RCar or SH SoCs, say Y to this option. If unsure,
+	  on systems with R-Car or SH SoCs, say Y to this option. If unsure,
 	  say N.
 
 choice
-- 
2.45.2

