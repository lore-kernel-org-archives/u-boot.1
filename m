Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E178C3DA5D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 10:56:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9064B88C42;
	Fri, 19 Jul 2024 12:50:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Am+hghfs";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Cgq3MYyO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0A1388C31; Fri, 19 Jul 2024 12:50:51 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E79D688BFC
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 12:50:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4WQRKj4qYsz9sly;
 Fri, 19 Jul 2024 12:50:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721386249;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QKBDWuoXRKmkkpAjKC7WmlOeYyMHDAMp7pOiGoZGh2A=;
 b=Am+hghfs5uo8naDUwWbkBRFgHtHcCYgeCNgLtxQAWOMO3/7LBIVA3UAp1NH/JFdXg6dWmK
 TJ/nH8M8xZE7zviMP7YxxhrPAxZikF+OC+RUmgqG5QDunrpk9yINeyCSG1RtTJ9/d/ccAM
 n1d7fdixr+Z7xw0LBhHX3VIp+1VOobQ+v4mlgMFAF7pYCLj6qrRa+xQgOWrI/1Hy7UZqCV
 wp7JFxmroAfqXrPOeB7cysNVsNJ1D1FoyGEI/vZbzYaXIaq9TyVGBoAAu+QyhA0UUaAuRy
 UZrVbu0Z0GKtby0rcRJtAc8Ob0OcpESg89zxTRjIToTDMEUntEFsPjcgxu6HDw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721386247;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QKBDWuoXRKmkkpAjKC7WmlOeYyMHDAMp7pOiGoZGh2A=;
 b=Cgq3MYyOd6LkUMRThcYPeRVgHmw+rh1xjg1LLLhMyn+w358ZXpwlIXzA+qaV2wx787FJqQ
 v0kPZX5eW08Rvm4qSyExf2zeR0XOz+C0hVGWbjlbDNOvgi4iWex3pd3e+3F+UpPVgjEPzN
 oO1M/YyyOEeSc+TPovuFE3V1hiUz187iUDFBSeKbY2OBqRaA2PffLMPhS814oNulZoD12T
 84Eo1m7O7wI6zf1Y7Aq96QmpCAdZfnsKuUqSXi5fgBL7zm1+zWpnU2YxsCRyl9tEIAqBca
 st1enM0nHziBv6Btik8trXpHHY4apicG6G3DV0CQURsVJdAZ41YSYa7Jm5pk2g==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 32/37] board: terasic: Remove duplicate newlines
Date: Fri, 19 Jul 2024 12:49:09 +0200
Message-ID: <20240719104948.323791-32-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240719104948.323791-1-marek.vasut+renesas@mailbox.org>
References: <20240719104948.323791-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: y9fj5f4cpk7nur9twoqggr7of6tkdqz4
X-MBO-RS-ID: 9408e6eb5408ba54c32
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

Drop all duplicate newlines. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 board/terasic/de1-soc/qts/iocsr_config.h       | 1 -
 board/terasic/de1-soc/qts/pll_config.h         | 1 -
 board/terasic/de10-nano/qts/iocsr_config.h     | 1 -
 board/terasic/de10-nano/qts/pll_config.h       | 1 -
 board/terasic/de10-standard/qts/iocsr_config.h | 1 -
 board/terasic/de10-standard/qts/pll_config.h   | 1 -
 board/terasic/sockit/qts/iocsr_config.h        | 1 -
 board/terasic/sockit/qts/pll_config.h          | 1 -
 8 files changed, 8 deletions(-)

diff --git a/board/terasic/de1-soc/qts/iocsr_config.h b/board/terasic/de1-soc/qts/iocsr_config.h
index 359fd0e4173..46ef8288ed5 100644
--- a/board/terasic/de1-soc/qts/iocsr_config.h
+++ b/board/terasic/de1-soc/qts/iocsr_config.h
@@ -655,5 +655,4 @@ const unsigned long iocsr_scan_chain3_table[] = {
 	0x00004000,
 };
 
-
 #endif /* __SOCFPGA_IOCSR_CONFIG_H__ */
diff --git a/board/terasic/de1-soc/qts/pll_config.h b/board/terasic/de1-soc/qts/pll_config.h
index 2811e04c480..ae3cd316743 100644
--- a/board/terasic/de1-soc/qts/pll_config.h
+++ b/board/terasic/de1-soc/qts/pll_config.h
@@ -86,5 +86,4 @@
 #define CFG_HPS_ALTERAGRP_MAINCLK 3
 #define CFG_HPS_ALTERAGRP_DBGATCLK 3
 
-
 #endif /* __SOCFPGA_PLL_CONFIG_H__ */
diff --git a/board/terasic/de10-nano/qts/iocsr_config.h b/board/terasic/de10-nano/qts/iocsr_config.h
index a889d3da348..155550007a3 100644
--- a/board/terasic/de10-nano/qts/iocsr_config.h
+++ b/board/terasic/de10-nano/qts/iocsr_config.h
@@ -655,5 +655,4 @@ const unsigned long iocsr_scan_chain3_table[] = {
 	0x00004000,
 };
 
-
 #endif /* __SOCFPGA_IOCSR_CONFIG_H__ */
diff --git a/board/terasic/de10-nano/qts/pll_config.h b/board/terasic/de10-nano/qts/pll_config.h
index 192ffb4e27b..794fa203d94 100644
--- a/board/terasic/de10-nano/qts/pll_config.h
+++ b/board/terasic/de10-nano/qts/pll_config.h
@@ -80,5 +80,4 @@
 #define CFG_HPS_ALTERAGRP_MAINCLK 3
 #define CFG_HPS_ALTERAGRP_DBGATCLK 3
 
-
 #endif /* __SOCFPGA_PLL_CONFIG_H__ */
diff --git a/board/terasic/de10-standard/qts/iocsr_config.h b/board/terasic/de10-standard/qts/iocsr_config.h
index 4aed74e8b29..80086b0c293 100644
--- a/board/terasic/de10-standard/qts/iocsr_config.h
+++ b/board/terasic/de10-standard/qts/iocsr_config.h
@@ -655,5 +655,4 @@ const unsigned long iocsr_scan_chain3_table[] = {
 	0x00004000,
 };
 
-
 #endif /* __SOCFPGA_IOCSR_CONFIG_H__ */
diff --git a/board/terasic/de10-standard/qts/pll_config.h b/board/terasic/de10-standard/qts/pll_config.h
index c1ecd4b8208..b09b6adfab0 100644
--- a/board/terasic/de10-standard/qts/pll_config.h
+++ b/board/terasic/de10-standard/qts/pll_config.h
@@ -80,5 +80,4 @@
 #define CFG_HPS_ALTERAGRP_MAINCLK 4
 #define CFG_HPS_ALTERAGRP_DBGATCLK 4
 
-
 #endif /* __SOCFPGA_PLL_CONFIG_H__ */
diff --git a/board/terasic/sockit/qts/iocsr_config.h b/board/terasic/sockit/qts/iocsr_config.h
index 7b72ae9c3c2..8c247c8dfe5 100644
--- a/board/terasic/sockit/qts/iocsr_config.h
+++ b/board/terasic/sockit/qts/iocsr_config.h
@@ -655,5 +655,4 @@ const unsigned long iocsr_scan_chain3_table[] = {
 	0x00004000,
 };
 
-
 #endif /* __SOCFPGA_IOCSR_CONFIG_H__ */
diff --git a/board/terasic/sockit/qts/pll_config.h b/board/terasic/sockit/qts/pll_config.h
index 104e324d8a4..52f1eb0c7b4 100644
--- a/board/terasic/sockit/qts/pll_config.h
+++ b/board/terasic/sockit/qts/pll_config.h
@@ -80,5 +80,4 @@
 #define CFG_HPS_ALTERAGRP_MAINCLK 3
 #define CFG_HPS_ALTERAGRP_DBGATCLK 3
 
-
 #endif /* __SOCFPGA_PLL_CONFIG_H__ */
-- 
2.43.0

