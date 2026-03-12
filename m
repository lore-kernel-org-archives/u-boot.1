Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C9F4FED2F9
	for <u-boot@archiver.kernel.org>; Thu, 12 Mar 2026 10:10:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE9A7841A2;
	Thu, 12 Mar 2026 11:10:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="VRg26VTO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74D7D841B9; Thu, 12 Mar 2026 11:10:22 +0100 (CET)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A381384198
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 11:10:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Max.Merchel@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=0P2MBe1ttlivl5dSqOcsDjQsad3KeQ2djgLbrkwNoMk=; b=VRg26VTOq0HnAKQ6x20ZR4CqVH
 5pGgk+S4TCjwyoWfStbRgsvv5l7E0/RgX55uzJ/BsFsNX5DgmaTLczYrL3+SmybjKMglM3j05HsGj
 RLGMPx3WLokbgEnsKN+q+9zLmtOEtVLY77Dre+zFSDso/SQMxwcVra0VDJ/tlNsLvwOgG/aDKtubV
 cjl5Jt2TlsnZe1YsWOTVDLvatvG49HG8oPla2uROKL3mn4rUtA3PXDwSCrt3qmeA/jiR8Yi5yjL3K
 zT1oMuvxWUdJ4hKVC8a3EoO51kg2oKye1ogMDm6pVlHATMLcjgDFuE26yZynKbwYsnFIqCzaWbLFP
 SDuaihYA==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1w0czj-000AeB-2t; Thu, 12 Mar 2026 11:10:19 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy07.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1w0cnS-000Fyo-27; Thu, 12 Mar 2026 10:57:38 +0100
From: Max Merchel <Max.Merchel@ew.tq-group.com>
To: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: Max Merchel <Max.Merchel@ew.tq-group.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com
Subject: [PATCH 11/13] board: tqma6: use common TQ mmc function
Date: Thu, 12 Mar 2026 10:57:07 +0100
Message-ID: <20260312095711.3219756-12-Max.Merchel@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260312095711.3219756-1-Max.Merchel@ew.tq-group.com>
References: <20260312095711.3219756-1-Max.Merchel@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

use function from common TQ mmc
select TQ_SDMMC option for MBa6

Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
---
 board/tq/tqma6/Kconfig      | 1 +
 board/tq/tqma6/tqma6_mba6.c | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/board/tq/tqma6/Kconfig b/board/tq/tqma6/Kconfig
index 1ef9f6732aa..21bcb8e0cb3 100644
--- a/board/tq/tqma6/Kconfig
+++ b/board/tq/tqma6/Kconfig
@@ -73,6 +73,7 @@ choice
 config MBA6
 	bool "TQMa6 on MBa6 Starterkit"
 	select TQ_COMMON_BB
+	select TQ_COMMON_SDMMC
 	select USB
 	select CMD_USB
 	select USB_STORAGE
diff --git a/board/tq/tqma6/tqma6_mba6.c b/board/tq/tqma6/tqma6_mba6.c
index d604d6d4f0a..32aeb1b07c8 100644
--- a/board/tq/tqma6/tqma6_mba6.c
+++ b/board/tq/tqma6/tqma6_mba6.c
@@ -137,3 +137,9 @@ const char *tq_bb_get_boardname(void)
 {
 	return "MBa6x";
 }
+
+int tq_bb_board_late_init(void)
+{
+	board_late_mmc_env_init();
+	return 0;
+}
-- 
2.43.0

