Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD9CCCA0FED
	for <u-boot@archiver.kernel.org>; Sat,  6 Sep 2025 23:00:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 100A783447;
	Sun,  7 Sep 2025 01:00:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="FrJGCXdP";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="THs6Eejj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94DDC83885; Sun,  7 Sep 2025 01:00:40 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EEA183327
 for <u-boot@lists.denx.de>; Sun,  7 Sep 2025 01:00:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cK7wk1lp2z9tH5;
 Sun,  7 Sep 2025 01:00:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1757199638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=DwwUfYI6YryrpkT0AoFQqO53S9ymw2mfw4dALZH3OdM=;
 b=FrJGCXdPN9yMR5GkfZevyAWlXXget3JZZWntrPIpbLc53gZgCUtIOPy/6tMz19S4dVMMmz
 jDtk5kAp5lwUJyCbU860tahblAgnkkW0P8YsHj9jJ5ZdC44J89/zWYknN+KtBkjbAgbksA
 E/7U84ijlPkEXiknxI428xE4kGs+E2J6erQHfcmxQdo1r5gBMseeT87yevxGCtngfTxSIN
 1qUDAFPf6N/QsMXTN+UsXpQcP4b1vUgmEZluxGfrQXXSBIUt5G7bO71oHTos0NwEtk+0SL
 mtNq/oqJHuxbOvXUNGspesilF1Tqe18PIj6ptGmt9yg3WeuvHNB7pWEEpv7qiw==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=THs6Eejj;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
From: Marek Vasut <marek.vasut@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1757199636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=DwwUfYI6YryrpkT0AoFQqO53S9ymw2mfw4dALZH3OdM=;
 b=THs6Eejjk1eZ4LIvh+kl46QfEib6Tlx9Pty18jek54INjKYUj/vdadjQyeubnmPD11oOa7
 WR0Ce/Iv+sYkywEBaJgsJNGWMP0ZEkYZnfQG/N8UI4tluvQUM+rHoMfgq2IEOgtqLdaBZs
 ZMjrcUY4Iv4K6NuhTqeW6/ZkADfutAfuLcrGRaxw97DQET8//0QNoBbgvLfb9Emf0IUQV7
 9/gGmCq29Wz0e0zXl7vzwdN+0s1yq/SuruFFKLhN6CmMyez3dkNjoZ4Z41AQkRsnaU/Gsx
 kYGuc4tdKmxtlxDW1uTDOtJhbs0tZEgm4HUrioMGXx6rRPnU6hXkT6VI0VOYjw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH] clk: stm32: Pass udevice pointer to clk_register_composite()
Date: Sun,  7 Sep 2025 01:00:01 +0200
Message-ID: <20250906230016.582577-1-marek.vasut@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 86b09d4c094d02b3955
X-MBO-RS-META: 9duyijuqttiogg89he47yp4nt88rbzyk
X-Rspamd-Queue-Id: 4cK7wk1lp2z9tH5
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

The clk_register_composite() does clk_resolve_parent_clk() look up,
which requires valid udevice pointer. Do not pass NULL, pass a valid
device pointer to prevent hang on registering ck_usbo_48m clock on
STM32MP13xx.

Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
---
Cc: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
 drivers/clk/stm32/clk-stm32-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/stm32/clk-stm32-core.c b/drivers/clk/stm32/clk-stm32-core.c
index a0ae89d0912..858f122db1a 100644
--- a/drivers/clk/stm32/clk-stm32-core.c
+++ b/drivers/clk/stm32/clk-stm32-core.c
@@ -309,7 +309,7 @@ clk_stm32_register_composite(struct udevice *dev,
 		gate_ops = &clk_stm32_gate_ops;
 	}
 
-	clk = clk_register_composite(NULL, cfg->name,
+	clk = clk_register_composite(dev, cfg->name,
 				     parent_names, num_parents,
 				     mux_clk, mux_ops,
 				     div_clk, div_ops,
-- 
2.50.1

