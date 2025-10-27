Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDEBDCCF9EB
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 16:55:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B83C83935;
	Mon, 27 Oct 2025 17:55:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="IW78dvqE";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="oaPaauKp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 643358391E; Mon, 27 Oct 2025 17:55:14 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 702BA836B4
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 17:55:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cwKPX1wzHz9ssB;
 Mon, 27 Oct 2025 17:55:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761584112;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=KnacebtZcgAtGPSdrGoAMxnK2KtXinmuMvqOqQ/dUSU=;
 b=IW78dvqE2X83UKHsWMHeuJfC+fGxTXZkXUP/GJMvn04I8HgocxQaUcY0YElsRGp8gQlT8m
 dVjWrVduK+tJ718qKUgX6rwRnSCqFudwxa3fb9Rj43xYh6tnglFqP5gcyu+Jin/0HSPDfX
 oZ8uNc05v6SVSscUd8jd+k5vGivunoXy/IYkdG58qFOfT+P75lqTOhpzHQL3eB7kIduDCf
 7ZLVVRUGABzvh47ED9l2wjelFdaoD5X1jtkFH/hIBrTqy5hIQvf5mv0EQuG1dX7gLw74vZ
 sOaCZgUchpCzLHKZYkoRCvZk/+Wr+93AFGb7+20SDxAWuFfjbjKDDj5WuTgxAA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761584110;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=KnacebtZcgAtGPSdrGoAMxnK2KtXinmuMvqOqQ/dUSU=;
 b=oaPaauKpK4m9CKfoHLPAioio0jb8LFCFcHbpEyjksCpsFdzpaFjfpmgEhN+cswi8qwQ79A
 E4nKPGGnzSb9yHmVzQrFrSUH3mFTT3waRyqroR0mvCXnWC9SkJcaYuh5sPAIBADFsKCRZM
 i2e8UTw6PtLZX4rsi3GaigYWbmRzUJPNwv/Lfi/QfETI+I/zmTi9d1z+OlZh0l/lFk/vyV
 sbCuhbiPTFVGxGt/MWVlO/304wPoHqBD4vZucExf4Z5p4Y3JtzHWUJi3MXo/eZmC+Ph5mH
 bwqFKSbPZGqMi03l0EnX+eGkCuvjdWFmK5F9U6/Yjq6ZW4i/gFy2aKZhMgZacg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hai Pham <hai.pham.ud@renesas.com>, Huy Bui <huy.bui.wm@renesas.com>,
 Khanh Le <khanh.le.xr@renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Tam Nguyen <tam.nguyen.xa@renesas.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/4] pinctrl: renesas: Align Kconfig entry indent
Date: Mon, 27 Oct 2025 17:53:51 +0100
Message-ID: <20251027165505.20579-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 6jqengza8trwu1hqnwsxhxoparrxfpqa
X-MBO-RS-ID: f4cc2bce759d6ecbc86
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

Fix Kconfig entry indent to be always consistently indented with
leading tabs, never with leading spaces. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Hai Pham <hai.pham.ud@renesas.com>
Cc: Huy Bui <huy.bui.wm@renesas.com>
Cc: Khanh Le <khanh.le.xr@renesas.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tam Nguyen <tam.nguyen.xa@renesas.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/pinctrl/renesas/Kconfig | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/pinctrl/renesas/Kconfig b/drivers/pinctrl/renesas/Kconfig
index 560f7275454..e4a4c91304a 100644
--- a/drivers/pinctrl/renesas/Kconfig
+++ b/drivers/pinctrl/renesas/Kconfig
@@ -53,28 +53,28 @@ config PINCTRL_PFC_R8A7794
 	  Support pin multiplexing control on Renesas R-Car Gen2 R8A7794 SoCs.
 
 config PINCTRL_PFC_R8A774A1
-        bool "Renesas RZ/G2 R8A774A1 pin control driver"
-        depends on PINCTRL_PFC
-        help
-          Support pin multiplexing control on Renesas RZ/G2M R8A774A1 SoCs.
+	bool "Renesas RZ/G2 R8A774A1 pin control driver"
+	depends on PINCTRL_PFC
+	help
+	  Support pin multiplexing control on Renesas RZ/G2M R8A774A1 SoCs.
 
 config PINCTRL_PFC_R8A774B1
-        bool "Renesas RZ/G2 R8A774B1 pin control driver"
-        depends on PINCTRL_PFC
-        help
-          Support pin multiplexing control on Renesas RZ/G2N R8A774B1 SoCs.
+	bool "Renesas RZ/G2 R8A774B1 pin control driver"
+	depends on PINCTRL_PFC
+	help
+	  Support pin multiplexing control on Renesas RZ/G2N R8A774B1 SoCs.
 
 config PINCTRL_PFC_R8A774C0
-        bool "Renesas RZ/G2 R8A774C0 pin control driver"
-        depends on PINCTRL_PFC
-        help
-          Support pin multiplexing control on Renesas RZ/G2E R8A774C0 SoCs.
+	bool "Renesas RZ/G2 R8A774C0 pin control driver"
+	depends on PINCTRL_PFC
+	help
+	  Support pin multiplexing control on Renesas RZ/G2E R8A774C0 SoCs.
 
 config PINCTRL_PFC_R8A774E1
-        bool "Renesas RZ/G2 R8A774E1 pin control driver"
-        depends on PINCTRL_PFC
-        help
-          Support pin multiplexing control on Renesas RZ/G2H R8A774E1 SoCs.
+	bool "Renesas RZ/G2 R8A774E1 pin control driver"
+	depends on PINCTRL_PFC
+	help
+	  Support pin multiplexing control on Renesas RZ/G2H R8A774E1 SoCs.
 
 config PINCTRL_PFC_R8A77951
 	bool "Renesas R-Car Gen3 R8A7795 pin control driver"
-- 
2.51.0

