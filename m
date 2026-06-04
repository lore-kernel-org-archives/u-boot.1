Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44C1BCD6E75
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 17:33:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74AB08486D;
	Thu,  4 Jun 2026 19:33:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="MkcntmGz";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="cZIFuwNv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F372384940; Thu,  4 Jun 2026 19:33:39 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D95AB800AE
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 19:33:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gWWrK3SSdz9tsQ;
 Thu,  4 Jun 2026 19:33:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1780594417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=eyl+cUwhTS3S0Mw4WirSCcj9fz5ktZUaAa4Erf6Jdi0=;
 b=MkcntmGzv+NU3B70GQR5w1Ipr4uXM7yrJWwfPZngrFWn3EqmaK5zxeizB/2/iIFHGjquK7
 RO2axn9nNzLb5CblQQmdQOtRi7pZDY/mEZmrkQbCobfEib+vwQW300JU6v4LyVAIDQEZOV
 W1b6q5TLuAIMf93CjsENG4/5m7gFDQjSZXuVqZYjfZcLBWyw/Z2HLtk+RQXCb/ooVwtCLF
 fS/qWtgzzs9WXSS5vZixZRYJqTNpP61XxkQhJliFZKN175DA/XU/qRb3sg71FSFUh//QyB
 2Z6LFuFLC9WTKDagEZB+Sv/5cQRTJr8Fe0uJpYDO9PiGl5CZjS395BAW3MuzKQ==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=cZIFuwNv;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1780594415;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=eyl+cUwhTS3S0Mw4WirSCcj9fz5ktZUaAa4Erf6Jdi0=;
 b=cZIFuwNvCUIwUiNYPD8dNqLu4bjL9YinpixGa1GKtP3lypzTBdjN2nsJTqxrndOcJEal95
 ErBSx16FsJrA4RorhIQOGWgmFTfmldMt9AfHWbtMdmvy15Q6Kw5fmU+JZx172a8rRgjVfN
 sx0R6+B4+W0IWE0slTi+sO1S8FoEmnaSEar0u8CpW0FdJaKIw0VhOj0YLACg6AmWtR3pzW
 fMALIk0DvkPBhgbkNo5xlx4zukzcy2iBMy3kp6BKR5hzwuYm5iZMzukqGzMiAh6a+ErcZ7
 vXkghkixZ1sl4IyeKLl9SlP2QXBKcA2Nz9LmVc2kaJXk5a3BUDFpv1u6hrOUjw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 David Lechner <dlechner@baylibre.com>, Heiko Schocher <hs@nabladev.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] lmb: Rename LMB_LIMIT_DMA_BELOW_4G to
 LMB_LIMIT_DMA_BELOW_RAM_TOP
Date: Thu,  4 Jun 2026 19:33:15 +0200
Message-ID: <20260604173330.8586-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: da7675233facda63726
X-MBO-RS-META: 9dc5wwgrid6hzfz6suy7cxznyg37xnwm
X-Rspamd-Queue-Id: 4gWWrK3SSdz9tsQ
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

Rename LMB_LIMIT_DMA_BELOW_4G to LMB_LIMIT_DMA_BELOW_RAM_TOP
to make the Kconfig option more descriptive. No functional
change.

Suggested-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: David Lechner <dlechner@baylibre.com>
Cc: Heiko Schocher <hs@nabladev.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Holger Brunck <holger.brunck@hitachienergy.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Peter Robinson <pbrobinson@gmail.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Simon Glass <sjg@chromium.org>
Cc: Sughosh Ganu <sughosh.ganu@arm.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 lib/Kconfig | 7 ++++---
 lib/lmb.c   | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/lib/Kconfig b/lib/Kconfig
index 29911068a69..cf13ac1bdad 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -1295,13 +1295,14 @@ config SPL_LMB_ARCH_MEM_MAP
 	  memory map. Enable this config in such scenarios which allow
 	  architectures and boards to define their own memory map.
 
-config LMB_LIMIT_DMA_BELOW_4G
+config LMB_LIMIT_DMA_BELOW_RAM_TOP
 	bool
 	depends on LMB
 	default y if ARCH_BCM283X
 	help
-	  Some architectures can not DMA above 4 GiB boundary,
-	  limit available memory to memory below 4 GiB boundary.
+	  Some architectures can not DMA above ram_top boundary,
+	  which is after 4 GiB or 32-bit boundary too. Limit the
+	  available memory to memory below ram_top boundary.
 
 config PHANDLE_CHECK_SEQ
 	bool "Enable phandle check while getting sequence number"
diff --git a/lib/lmb.c b/lib/lmb.c
index a2aeb526e29..275d105c5aa 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -628,7 +628,7 @@ static void lmb_add_memory(void)
 
 		if (size) {
 			lmb_add(bd->bi_dram[i].start, size);
-			if (!IS_ENABLED(CONFIG_LMB_LIMIT_DMA_BELOW_4G))
+			if (!IS_ENABLED(CONFIG_LMB_LIMIT_DMA_BELOW_RAM_TOP))
 				continue;
 
 			bank_end = bd->bi_dram[i].start + size;
-- 
2.53.0

