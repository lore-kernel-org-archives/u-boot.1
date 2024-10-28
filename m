Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E944D3399B
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 16:45:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B3F689099;
	Mon, 28 Oct 2024 17:45:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=tkos.co.il header.i=@tkos.co.il header.b="jfVr8JOp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 497B2890A9; Mon, 28 Oct 2024 17:45:00 +0100 (CET)
Received: from mail.tkos.co.il (mail.tkos.co.il [84.110.109.230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5A7188D3A
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 17:44:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=tkos.co.il
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=baruch@tkos.co.il
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.tkos.co.il (Postfix) with ESMTPS id 0FB724402B5;
 Mon, 28 Oct 2024 18:41:46 +0200 (IST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
 s=default; t=1730133706;
 bh=L05jzYGE48SEKd/vK4Yn9JUsxfYB21d9484R+deDVEY=;
 h=From:To:Cc:Subject:Date:From;
 b=jfVr8JOpv2CmOr4noywZY7b0Biu9SEi0wz7cBWiG+i9N1wp61f0/sHMG5tNHskKpV
 33TRIHufQZiLUC7RAw1lw23bPGgKor4Sz8VUXziNO/sEWTHcqL61dX0cMsiGwX4Kfo
 Peu5J3f7d83QWv+S4T8OhY6gBBM5qcpGmWrpEdxAe11VFPxCp7FYfsBqUCSdCbibhv
 KrsTrMW+xgHCfv3wGxj9nFmbLcdbov9bw+6v8J9RiNfwMHsv/cwJh/2zyrqDBSS7f2
 t0UDyuq2WUQobgODrUpiGQ4n1+3yfBbHCT2oiL8WxTs7hhcLVYScd+2PY806yR3rRv
 /onf5WKC/bqbA==
From: Baruch Siach <baruch@tkos.co.il>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH] boot/Kconfig: correct fdt_fixup_memory_banks name typo
Date: Mon, 28 Oct 2024 18:44:35 +0200
Message-ID: <a65bc69d909e18b9cf138f8f97f4b16b4a4d4de7.1730133875.git.baruch@tkos.co.il>
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

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 boot/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index b9287c606856..7dd30a030e39 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -1699,7 +1699,7 @@ config FDT_SIMPLEFB
 	  memory
 
 config ARCH_FIXUP_FDT_MEMORY
-	bool "Enable arch_fixup_memory_banks() call"
+	bool "Enable fdt_fixup_memory_banks() call"
 	default y
 	help
 	  Enable FDT memory map syncup before OS boot. This feature can be
-- 
2.45.2

