Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 245E2D1CDA1
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 06:04:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8608888E02;
	Tue, 22 Oct 2024 08:04:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="ORdwe9+2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F277388F28; Tue, 22 Oct 2024 08:04:35 +0200 (CEST)
Received: from mta-64-228.siemens.flowmailer.net
 (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98A0088F47
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 08:04:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id
 20241022060432ed3b1df2f80b1e8690 for <u-boot@lists.denx.de>;
 Tue, 22 Oct 2024 08:04:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Lv0ut2tY6XlI1jFjodmFd39h11wE5epFQMypq6ar62Q=;
 b=ORdwe9+29Fp4GgDLkT0Go5SDlZQwK0Pw4Zic2+aLHrLZBVCGBAX89xobImgJUuRuwNGr4U
 R658SNsWV/wewcQycjxkxK/U3EP97xSk88FyfEhdclJBLImZszI6RNCF8GQhRvZYMGOGtFN8
 gqWIip32OLTzxTR5uO3FNBncSahaBTvJWlYThAmqMXbb2nZlR+89xxfxWd2qBpPhgn8gG6H9
 tfqIt1US6HxAHAw7fXFw9g9rXsSEOHJyCKlbeiiSfGLc5AOaTdTO7ADUPswYekFYuB9SRUuu
 kEvpu1SzpFEY8MicTgpVAWDDOsns+aVW2l/G6ZxEaNTz4S8KK/E1K96Q==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bryan Brattlof <bb@ti.com>,
	Nishanth Menon <nm@ti.com>
Subject: [PATCH v2 03/13] board: siemens: iot2050: Control pcie power for all
 variants
Date: Tue, 22 Oct 2024 08:04:20 +0200
Message-ID: <91c60e8db41f6709d37889a2a7af56f930a703b9.1729577070.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1729577070.git.jan.kiszka@siemens.com>
References: <cover.1729577070.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
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

From: Baocheng Su <baocheng.su@siemens.com>

The power control pin of pcie interface not only works for M.2 interface
but also for miniPCIE, so promote this logic to all variants to
workaround the module hang issue.

Signed-off-by: Baocheng Su <baocheng.su@siemens.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 board/siemens/iot2050/board.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/board/siemens/iot2050/board.c b/board/siemens/iot2050/board.c
index e5c7ce58b06..85cb999f17f 100644
--- a/board/siemens/iot2050/board.c
+++ b/board/siemens/iot2050/board.c
@@ -185,6 +185,12 @@ static void remove_mmc1_target(void)
 	free(boot_targets);
 }
 
+static void enable_pcie_connector_power(void)
+{
+	set_pinvalue("gpio@601000_17", "P3V3_PCIE_CON_EN", 1);
+	udelay(4 * 100);
+}
+
 void set_board_info_env(void)
 {
 	struct iot2050_info *info = IOT2050_INFO_DATA;
@@ -288,10 +294,6 @@ static void m2_connector_setup(void)
 	struct m2_config_pins config_pins;
 	unsigned int n;
 
-	/* enable M.2 connector power */
-	set_pinvalue("gpio@601000_17", "P3V3_M2_EN", 1);
-	udelay(4 * 100);
-
 	if (m2_manual_config < CONNECTOR_MODE_INVALID) {
 		mode_info = " [manual mode]";
 		connector_mode = m2_manual_config;
@@ -429,6 +431,8 @@ int board_late_init(void)
 	/* change CTRL_MMR register to let serdes0 not output USB3.0 signals. */
 	writel(0x3, SERDES0_LANE_SELECT);
 
+	enable_pcie_connector_power();
+
 	if (board_is_m2())
 		m2_connector_setup();
 
-- 
2.43.0

