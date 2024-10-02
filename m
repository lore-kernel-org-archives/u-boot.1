Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A5ADCEACF3
	for <u-boot@archiver.kernel.org>; Wed,  2 Oct 2024 19:53:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A941C88DF1;
	Wed,  2 Oct 2024 21:53:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727898795;
	bh=TOGrNiMWJJQ/pLI0P2SyDQSiq3H8BgbzMsMjmuK1FuQ=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=itVaPW1bNPexIR9h2zi1H51hTiyC2Z4pbDlZs24uVry9xkniKzDsqncQWFWb8CQiP
	 I92K++ldjIDa40bM0vvVr0qUubmOWSJgkj94VctnLzBfmwnc3pOAoo8toh20mFjfRn
	 Qps9q24virlUgX9Yv7PLjP2Hkn3BiHw0G4xSUvTmmZdjNqeykrpkNQAtIUmmedAWup
	 1d7WjPTk3x6wWp4QXmtuFs8GaEKe6RlsXbut88c91R+dr6neoLStOYekmgrnxqJouJ
	 DUR1S3PAJ7Hl7iRwasjD8H75OtMQa9iL8NUPXe0J8LXmNEyuzMCT14fhbXtCVpomxe
	 4PeMbqUn2hPXA==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 434CB88DA0;
 Wed,  2 Oct 2024 21:53:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1727898794;
 bh=TOGrNiMWJJQ/pLI0P2SyDQSiq3H8BgbzMsMjmuK1FuQ=;
 h=From:To:Cc:Subject:Date:From;
 b=KVlStnyghnFbWuma24oYsG+PGTQJ12jorlSCGqb3MHsGuq0TqkqNX7TFk4byyazXF
 7BxPZcVTY6p60J/yshzEBxSVqD1lYXXWm9XlPUyqj1PZaFdSVTaJJBlD6KbN/0f8QK
 cOTfSn/PMzIv++9aqD4mA7Na4C0XtNkgehntsfzWjyFn6G9jLSnz4hmJbv1bRwhgDz
 uPN5YKw7ZIpWroWKxgjLC5hqt/P9E0s9JCWuyo3XRvPruOnrGS9DVGq/M0ONLYjDYJ
 wp2Yqt92liaUzNDDqFGBetadz6L7wQ8M5FWiMgSEk0M1e2rcgfmbAa+v+8EnreaH/y
 IGWnzuHFf3zvg==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@denx.de>
Subject: [PATCH] ARM: imx: Drop bogus newline
Date: Wed,  2 Oct 2024 21:52:43 +0200
Message-ID: <20241002195304.21973-1-marex@denx.de>
X-Mailer: git-send-email 2.45.2
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

This shows up in 'help' output and introdues bogus gap:
"
mfgprot   - Manufacturing Protection

mii       - MII utility commands
"
Drop the newline to fix this.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Stefano Babic <sbabic@denx.de>
---
 arch/arm/mach-imx/cmd_mfgprot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/cmd_mfgprot.c b/arch/arm/mach-imx/cmd_mfgprot.c
index 9f37e611a1e..8f66de699c5 100644
--- a/arch/arm/mach-imx/cmd_mfgprot.c
+++ b/arch/arm/mach-imx/cmd_mfgprot.c
@@ -143,6 +143,6 @@ U_BOOT_LONGHELP(mfgprot,
 
 U_BOOT_CMD(
 	mfgprot, 4, 1, do_mfgprot,
-	"Manufacturing Protection\n",
+	"Manufacturing Protection",
 	mfgprot_help_text
 );
-- 
2.45.2

