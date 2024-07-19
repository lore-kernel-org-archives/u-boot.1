Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C48CC3DA59
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 10:55:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 156DF88C20;
	Fri, 19 Jul 2024 12:50:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="imE6RKup";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="jEGMhysn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D128E88C12; Fri, 19 Jul 2024 12:50:47 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06DCE88BFC
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 12:50:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4WQRKd59dPz9spG;
 Fri, 19 Jul 2024 12:50:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721386245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=quXgPSH7M27ZQX6cLnkfno+3CRY9BNqVmokzFfdIUNI=;
 b=imE6RKupDN8u3vfnZmsSrM4vUbKsXH6JCid51Txbj6Hm49otGPZUwlLxFFaDXCT5uDNfai
 kQQk8hct3rXSCbA3VzIuIYWAMYDu+z8VM6UPvYxWVzWQswFhDheLBEGaMHHz75n9C3bmHS
 rKA7jhV4r+Eh9NGMwY3dtuAxBVtYaf/bOPoJchsSkQJ6/9tfdSw+tsohrdOf+p8leAKOl8
 jey0je/ynnwdHvBzVSoseo8Vn6VxZphmQ8KllSVcYZrTZOf2LaYBMZRbbddnwa8AUN0EDN
 Mbp5GPqfcfKH5BdH6IS5sBZULkSJTiX9uLdpbFmLBjlm2Lf9xRNyP4UmxoWiZA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721386243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=quXgPSH7M27ZQX6cLnkfno+3CRY9BNqVmokzFfdIUNI=;
 b=jEGMhysnO1Ejf/mPPpoeKQNgkU7jZEaNnPUedVn9BeYIsbirdSmr6XXvwSJ4XEPvriAaOY
 qNGqMurBj6icOb+PFT4lm7Sbq9W1GzZKFoeRmYRURi5Guj6ICHyeX9H7HPtHdMww7Qmdfe
 wbh50iHybMpOW6ihkHRivmKNKofkw+TjBSrWrQ/ZDQcGzuqOr+lzpsNunISfet/9ToI6ms
 r4JwNv3TXbpcgsqI/kH9t31/vtOToa7sYpSrZs0zB8Ysw/Ls/tF6qGtzBoSyhNfrvN/bCz
 6JkN0v/NRyNNjNZD9azgpFVGnHpy8+SqFCFLYci1BMZldIbVVDf2AQdAwOtVcA==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 28/37] board: softing: Remove duplicate newlines
Date: Fri, 19 Jul 2024 12:49:05 +0200
Message-ID: <20240719104948.323791-28-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240719104948.323791-1-marek.vasut+renesas@mailbox.org>
References: <20240719104948.323791-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 7f3bdozkkb8wutr1i1pr3gz47sxuodi3
X-MBO-RS-ID: b79afc0bbd70cb9daf0
X-Rspamd-Queue-Id: 4WQRKd59dPz9spG
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
 board/softing/vining_fpga/qts/iocsr_config.h | 1 -
 board/softing/vining_fpga/qts/pll_config.h   | 1 -
 2 files changed, 2 deletions(-)

diff --git a/board/softing/vining_fpga/qts/iocsr_config.h b/board/softing/vining_fpga/qts/iocsr_config.h
index 4059ed5ad12..62a25b9942e 100644
--- a/board/softing/vining_fpga/qts/iocsr_config.h
+++ b/board/softing/vining_fpga/qts/iocsr_config.h
@@ -655,5 +655,4 @@ const unsigned long iocsr_scan_chain3_table[] = {
 	0x00004000,
 };
 
-
 #endif /* __SOCFPGA_IOCSR_CONFIG_H__ */
diff --git a/board/softing/vining_fpga/qts/pll_config.h b/board/softing/vining_fpga/qts/pll_config.h
index 40bc8f7f7c1..2b930fa9463 100644
--- a/board/softing/vining_fpga/qts/pll_config.h
+++ b/board/softing/vining_fpga/qts/pll_config.h
@@ -80,5 +80,4 @@
 #define CFG_HPS_ALTERAGRP_MAINCLK 3
 #define CFG_HPS_ALTERAGRP_DBGATCLK 3
 
-
 #endif /* __SOCFPGA_PLL_CONFIG_H__ */
-- 
2.43.0

