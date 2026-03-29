Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA208FF4927
	for <u-boot@archiver.kernel.org>; Sun, 29 Mar 2026 23:16:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FE7383B48;
	Mon, 30 Mar 2026 01:16:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="s5nImmZ6";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="B187rY/Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AAEA83DBF; Mon, 30 Mar 2026 01:16:05 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E9968063E
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 01:16:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4fkVcK6vqpz9tVm;
 Mon, 30 Mar 2026 01:16:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1774826162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=03yW9S31NxeTkjLCWz5yaiqaGHkgCsZspqzavDjUPQQ=;
 b=s5nImmZ6DkiDJgFOEJEhZSMRE//sLd20O03AU8uOk+r5F3XyvoRYnJ17D3fLEQaPoSAxyS
 hKQ4532zrltbABfIZAIS2RW3phZcobiiY2UJ+r97is/T7KS6bSbsUByAFxnTONdek/S18R
 zLayU1qUQC7pIpXJKIyl2MakwMDHcxkRETcfoN68GZiPnMkgu7MOOge17D1lkwWBUWg2bv
 Bno/AVmzf1qjJZOiRicD8BT2EcrpHPU5fXJzvPPMNvn7VdcnHtstVyupWGizfaUMz4w3QD
 Coh41JSyV7KZVXFtjfW3Ut31gsrMtx0FozT18rhyKNMx83x5OVCe+9/AyKApgQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1774826160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=03yW9S31NxeTkjLCWz5yaiqaGHkgCsZspqzavDjUPQQ=;
 b=B187rY/QkXazB5GKREqjfUoDzMIpm8fFGKRkAK64GVxoLKINLuOxq8AhNTmghymQB32Mjp
 6+jeKJvoVc8ONKupVqcJdKs1F5YpYJk+ZdHrqOfM0RXLMC18FRmsm+zM1kqBdGmp/oan7N
 YDd+IrynN4ux92/vmjS039pPqf8dSbwLDlLLmnCnaY/vRo34qTMBF/+gHQOnC6FiV8lp/E
 YxuV4zzEeIGdcwb6bYCP3U/J/EylG0lsYpImweCivLCO4P7lK+z6YFyKHw2+B+SLX/fyYb
 aVBxw7ln3CRNZAm35fonqip9vGCSEdp1pr/9wFELwXK3fGSrcGeqAPuKM0Zw4w==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Anshul Dalal <anshuld@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jesse Taube <mr.bossman075@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH] arm: relocate: Make data-only relocation mode
 non-user-configurable
Date: Mon, 30 Mar 2026 01:15:16 +0200
Message-ID: <20260329231557.332469-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 595sbq8i77gwpfz8xfaxiktccz7ygc48
X-MBO-RS-ID: 2e8093bd29230a7f609
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

The data only relocation mode should be selected on per-SoC or per-core
basis, make these options non-user-configurable. The SoC or cores which
require this have to select this option using "default" keyword.

Fixes: d9eee3d17882 ("arm: relocate: Introduce data-only relocation mode")
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
See e.g. arm64: renesas: Add Cortex-M33 build option to R-Car Gen5
for the enablement example.
---
Cc: Anshul Dalal <anshuld@ti.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Jesse Taube <mr.bossman075@gmail.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Tien Fong Chee <tien.fong.chee@altera.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Udit Kumar <u-kumar1@ti.com>
Cc: u-boot@lists.denx.de
---
 Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Kconfig b/Kconfig
index 1679bba5d75..0bbdc0cbea6 100644
--- a/Kconfig
+++ b/Kconfig
@@ -475,7 +475,7 @@ config SKIP_RELOCATE
 	  limited RAM to run U-Boot.
 
 config SKIP_RELOCATE_CODE
-	bool "Skips relocation of U-Boot code to end of RAM"
+	bool
 	help
 	  Skips relocation of U-Boot code to the end of RAM, but still does
 	  relocate data to the end of RAM. This is mainly meant to relocate
@@ -484,7 +484,7 @@ config SKIP_RELOCATE_CODE
 	  This split configuration is present on various secure cores.
 
 config SKIP_RELOCATE_CODE_DATA_OFFSET
-	hex "Offset of read-write data memory from read-only text memory"
+	hex
 	default 0x0
 	depends on SKIP_RELOCATE_CODE
 	help
-- 
2.53.0

