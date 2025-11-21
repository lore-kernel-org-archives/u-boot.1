Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8460CFA747
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 08:14:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C8B78051F;
	Fri, 21 Nov 2025 09:14:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="PjY3Okfp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CB7383015; Fri, 21 Nov 2025 09:14:37 +0100 (CET)
Received: from mx-relay140-hz1.antispameurope.com
 (mx-relay140-hz1.antispameurope.com [94.100.133.186])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4ADD6808AF
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 09:14:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=0413995d28=max.merchel@ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate140-hz1.hornetsecurity.com 1;
 spf=pass reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com
 smtp.helo=hmail-p-smtp01-out04-hz1.hornetsecurity.com; dmarc=pass
 header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=+NBDW5zbwPoK5kgj3eLvtFk3lRxSfQsitKP+Q7oPn54=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1763712874;
 b=Hfd85vZ5/E4DeN1UDeMwryIDOFdXTGmLY6yCgyI9EF5XwkWdBBSIR/pq/ZB6zCnrY/Nig5YV
 mVUMdra+bUJ798N5bbICp0gxgOg22x6sIt0wQgbDH05dXxgoH9eb2YWNVhF4hhsogMDuxqRJYYY
 S/SEzA1MJBtoIOeZEavfGitioADMiDIwXp4HgkheGYxNVoEaVlgtrvSxFC9Rwm3FvDm4llgy6JN
 jtoeFkOmy6XXVtptXbBRs66PuOnu5g3oOKaeHSwJJlVuehQ/pCSshsKfogG/NAcsehBGvtS9R/N
 BOjYEXPb07CZfeU+6G2FZsc7JXjhiSAiH41WTEPQtWP8Q==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1763712874;
 b=lSnReiEznM/xBAQOu86Of6Mnpg/YnSnZacOBApsf2GNfH+JC6ot8L8CuShwvmMG6cKBLmKJG
 RUomHxU/J6eH+3jiYMHhcHFm6Ty7KFI0LNeex2angTTvCMszmK299Wk/xMCyxVvgV0VE2ogS5x4
 JA2/8DWbk6XQxnQUfpsFhHm1mOAMjwuagCZSZ3sfRPRvXL30hQR6xYBVbl3nBKraPmpkbYdoe7f
 V5yB2XC6Cf5t4baGl7YV4awPZkREzjKLWKjyo/xZliP2UDxbkuCdMvvfv3cWUJWo46GAECok5oq
 3CKYUFwlcRgVEyJV/tqC+5FJFNFrjE1AS1PZNkqE8iLtw==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by
 mx-relay140-hz1.antispameurope.com; Fri, 21 Nov 2025 09:14:34 +0100
Received: from merchelm-W2.tq-net.de
 (host-82-135-125-110.customer.m-online.net [82.135.125.110])
 (Authenticated sender: max.merchel@ew.tq-group.com)
 by hmail-p-smtp01-out04-hz1.hornetsecurity.com (Postfix) with ESMTPSA id
 8467A220D79; Fri, 21 Nov 2025 09:14:20 +0100 (CET)
From: Max Merchel <Max.Merchel@ew.tq-group.com>
To: Markus Niebel <Markus.Niebel@ew.tq-group.com>,
 Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@denx.de>
Cc: Max Merchel <Max.Merchel@ew.tq-group.com>, Stefan Roese <sr@denx.de>,
 u-boot@lists.denx.de, u-boot@ew.tq-group.com
Subject: [PATCH 1/4] tqma6: Remove empty function tqma6_iomuxc_spi()
Date: Fri, 21 Nov 2025 09:11:27 +0100
Message-ID: <20251121081138.73285-2-Max.Merchel@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251121081138.73285-1-Max.Merchel@ew.tq-group.com>
References: <20251121081138.73285-1-Max.Merchel@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-cloud-security-sender: max.merchel@ew.tq-group.com
X-cloud-security-recipient: u-boot@lists.denx.de
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: max.merchel@ew.tq-group.com
X-cloud-security-Mailarchivtype: outbound
X-cloud-security-Virusscan: CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on
 mx-relay140-hz1.antispameurope.com with 4dCSg06xpbz1HH0S
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1,
 IP=94.100.132.6
X-cloud-security-Digest: e95634c549db524748f0f16f3254f2c4
X-cloud-security: scantime:2.297
DKIM-Signature: a=rsa-sha256;
 bh=+NBDW5zbwPoK5kgj3eLvtFk3lRxSfQsitKP+Q7oPn54=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1763712873; v=1;
 b=PjY3OkfptT5hshs/PziHguZpLRdL1RBHgY/WjqbYn6ix0nutB4MRUXP92LOyzcMZvA+8l47K
 nPbE3fWMj4eCEyGNtmhXSZDGO94iEUn/yD2/CKCIv+wM11ycr52P9REHe2xger/1OU/70uzS1jt
 AG/XQuxAS6//4tIkxb/4uBSQqeFt/rPglogXKFoqWn4dw21ywnBA2DXQbKAEuKjiWdjeDNPwZMJ
 px6nDJ5mCYhpqDlh3WF+MV+oempSadDgtbIOB2XxC1s38UEAV6QR8g5+mfUSDtSuKrDM3B6vDnY
 1haRK0CmtXcdVvxnN1N8V8DN2rmW/YK7dsoqOkxhNshzg==
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

The function `tqma6_iomuxc_spi()` was removed in the commit
"tqma6: Remove non-DM board code".
The original function was overwritten with an empty function in the
WRU4 baseboard and should also have been removed.
Therefore, the function and its call are being removed.

Fixes: 93552cc442de ("tqma6: Remove non-DM board code")

Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
---
 board/tq/tqma6/tqma6.c      | 3 ---
 board/tq/tqma6/tqma6_wru4.c | 5 -----
 2 files changed, 8 deletions(-)

diff --git a/board/tq/tqma6/tqma6.c b/board/tq/tqma6/tqma6.c
index 40369f03e72..a7317b9e761 100644
--- a/board/tq/tqma6/tqma6.c
+++ b/board/tq/tqma6/tqma6.c
@@ -48,9 +48,6 @@ int board_init(void)
 	/* address of boot parameters */
 	gd->bd->bi_boot_params = PHYS_SDRAM + 0x100;
 
-#ifndef CONFIG_DM_SPI
-	tqma6_iomuxc_spi();
-#endif
 	tqma6_bb_board_init();
 
 	return 0;
diff --git a/board/tq/tqma6/tqma6_wru4.c b/board/tq/tqma6/tqma6_wru4.c
index 21c710188e0..aa53212e0e8 100644
--- a/board/tq/tqma6/tqma6_wru4.c
+++ b/board/tq/tqma6/tqma6_wru4.c
@@ -254,11 +254,6 @@ static void gpio_init(void)
 		gpio_direction_output(GPIO_UART3_PWRON, 0);
 }
 
-void tqma6_iomuxc_spi(void)
-{
-	/* No SPI on this baseboard */
-}
-
 int tqma6_bb_board_early_init_f(void)
 {
 	setup_iomuxc_uart4();
-- 
2.43.0

