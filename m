Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70C77C54798
	for <u-boot@archiver.kernel.org>; Tue, 27 Feb 2024 20:42:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B72B8805B;
	Tue, 27 Feb 2024 21:41:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3890A8800F; Tue, 27 Feb 2024 21:41:05 +0100 (CET)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
 by phobos.denx.de (Postfix) with ESMTP id 3B66E87E92
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 21:41:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.06,188,1705330800"; d="scan'208";a="195553921"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
 by relmlie5.idc.renesas.com with ESMTP; 28 Feb 2024 05:41:00 +0900
Received: from renesas-deb12.mshome.net (unknown [10.226.92.31])
 by relmlir5.idc.renesas.com (Postfix) with ESMTP id 15DC6400C4EC;
 Wed, 28 Feb 2024 05:40:58 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
	u-boot@lists.denx.de
Subject: [PATCH v3 8/8] board: rzg2l: Support reset via Renesas RAA215300 PMIC
Date: Tue, 27 Feb 2024 20:40:35 +0000
Message-Id: <20240227204035.3761-9-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240227204035.3761-1-paul.barker.ct@bp.renesas.com>
References: <20240227204035.3761-1-paul.barker.ct@bp.renesas.com>
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

With the SYSRESET subsystem enabled we do not need to implement
reset_cpu() in the board directory.

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 board/renesas/rzg2l/rzg2l.c           | 8 --------
 configs/renesas_rzg2l_smarc_defconfig | 2 ++
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/board/renesas/rzg2l/rzg2l.c b/board/renesas/rzg2l/rzg2l.c
index 73201a8c69e5..0f6d6e7f514f 100644
--- a/board/renesas/rzg2l/rzg2l.c
+++ b/board/renesas/rzg2l/rzg2l.c
@@ -56,11 +56,3 @@ int board_init(void)
 {
 	return 0;
 }
-
-void reset_cpu(void)
-{
-	/*
-	 * TODO: Implement reset support once TrustedFirmware supports
-	 * the appropriate call.
-	 */
-}
diff --git a/configs/renesas_rzg2l_smarc_defconfig b/configs/renesas_rzg2l_smarc_defconfig
index 2cab79329db4..21365a21fe8c 100644
--- a/configs/renesas_rzg2l_smarc_defconfig
+++ b/configs/renesas_rzg2l_smarc_defconfig
@@ -55,3 +55,5 @@ CONFIG_PMIC_RAA215300=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_SYSRESET=y
+CONFIG_SYSRESET_RAA215300=y
-- 
2.44.0

