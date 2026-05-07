Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB672CD37A7
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 22:56:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D4EA84A75;
	Fri,  8 May 2026 00:56:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="htFpTjN0";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="MSH+sZLv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0647D84AA5; Fri,  8 May 2026 00:56:56 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE3C684A57
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 00:56:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gBSLF26Y8z9tyK;
 Fri,  8 May 2026 00:56:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778194613;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZIJoRDhw538DAHMjV6UflbTiwFjJuAO0cQowvLVZ7Mc=;
 b=htFpTjN0lG9YOWpiGGLg6QuHNvGYHnPZ5rDi4K1l3h/GSz9eeAPmzwXsJeRYQzbMlvKLkb
 N7N0LOQmkd78KYIyMixKgK4c+Gm3trHCz52hgK8+zfGeYGB0Bv03hhycG3gQAyvMtPX+xf
 F0w/+VhCNv+IOt4QelEPObqgR7PH1qBzn6gvrzQShfpNFvo0yEF/0IYQFLsQedKeKUeNeK
 Mne7Yl0+T+KVnaCCvU+pnqYQ1b1rBsGSDMI0vrzdWn+XVSkp4CEJg4aFE+ZXsBp4/UPDIj
 L+XgXyywIzHHde20J0ou1IEZhtldVo9QRA40SD9ZN35FU4Yl516F8F03nQNitA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=MSH+sZLv;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778194611;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZIJoRDhw538DAHMjV6UflbTiwFjJuAO0cQowvLVZ7Mc=;
 b=MSH+sZLvDPkNeo7rNFpZcXGSoprrmf6mQXg0R3FfAIgm4qdcNv7JeoHkXiJD133pBBOwDo
 xAQ4GPl4U38k3QoF+Zff+tnH0WPhv+wR6Nhvuvi2oqbjxBYEufyHThIrOvfUVXJNrNIphU
 o3lz5aXzsHefJiuSR6/lxtUQSq7xWkyZiYYVDwwhQRC+9p/asTmH3OszZcbr5+Xf+h3/5y
 aNbXCLLqk8ODK/Ren1CixHeroIIFTKlXGg1trDE5Wcrh5UIXRoKoRn6NDkkOrh3nW+TJRE
 l8rLOB8Y8LVtGeU7Z7rwqu3Gfg/cpoNVAuxWhwTlz5tEiHC0sym/AQae3VGpgA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hai Pham <hai.pham.ud@renesas.com>, Khanh Le <khanh.le.xr@renesas.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm64: renesas: Select HSCIF for DEBUG UART on R-Car Gen5
 R8A78000 X5H
Date: Fri,  8 May 2026 00:56:29 +0200
Message-ID: <20260507225646.235921-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: j8wpb4u4h8spiea3cczdpm1dbbj9sfdi
X-MBO-RS-ID: 164beaed08d9a0199ba
X-Rspamd-Queue-Id: 4gBSLF26Y8z9tyK
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

The R-Car Gen5 R8A78000 X5H uses HSCIF as default serial console
interface. Select CFG_HSCIF to make debug UART code also configure
serial console interface as HSCIF instead of SCIF in case the
CONFIG_DEBUG_UART would be enabled.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Hai Pham <hai.pham.ud@renesas.com>
Cc: Khanh Le <khanh.le.xr@renesas.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 include/configs/rcar-gen5-common.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/configs/rcar-gen5-common.h b/include/configs/rcar-gen5-common.h
index 9edc37cba8b..4fbe8994f62 100644
--- a/include/configs/rcar-gen5-common.h
+++ b/include/configs/rcar-gen5-common.h
@@ -10,6 +10,7 @@
 
 /* Console */
 #define CFG_SYS_BAUDRATE_TABLE		{ 38400, 115200, 921600, 1843200, 3250000 }
+#define CFG_HSCIF
 
 /* Memory */
 #define DRAM_RSV_SIZE			0x20600000
-- 
2.53.0

