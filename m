Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B41D2C87FCB
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 09:08:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C842483DC9;
	Mon,  4 Aug 2025 11:08:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="sJUTKftU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DDE483DDF; Mon,  4 Aug 2025 11:08:26 +0200 (CEST)
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81E1983DBF
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 11:08:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 89DF01482EE2; Mon,  4 Aug 2025 11:08:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1754298502; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=VRmFnAmSwIpwjyCppoV11/Cw8oiH8J97BvyR1d/lWFg=;
 b=sJUTKftUAJ6BUYaUwrlAx8/9/8PBCe+6uI+PuO6Gqdt2PxFDSQFdAYGjVbr7uhI+pPXAYC
 rvMWedQPqJH8fj2ly3O8edoXtqsLqf3kUPBbm7cax8LnCwWiZTUyUMoTlHcEkwkAl0Qd8O
 DflIC2+oyPWJ68iHugGh3UifTewOFRKTW302SGpfSkAcsLn0hldyuzUi8NulS33i9BN9tk
 LLBZlDZJEK08owiaTr0gFDrEV5H7uDpBQWvBbY1m/MIY4J6KiBBydpS/l4mveEfCCuDTL0
 kGzBGAnkuXmrCJMMILBfD/k47M070Ovccpr2ewiBkAZlczycBMPPnEOwkd4S+Q==
From: Alexander Dahl <ada@thorsis.com>
To: u-boot@lists.denx.de
Cc: Heiko Schocher <hs@denx.de>, Michal Simek <michal.simek@amd.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] fpga: cyclon2: Remove message never printed
Date: Mon,  4 Aug 2025 11:08:16 +0200
Message-Id: <20250804090816.42603-1-ada@thorsis.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

else branch is never reached.  Print "Done." anyways to keep behaviour.

Addresses-Coverity-ID: 583148
Link: https://lore.kernel.org/u-boot/20250725132645.GA1807455@bill-the-cat/
Fixes: f0ff4692ff33 ("Add FPGA Altera Cyclone 2 support Patch by Heiko Schocher, 15 Aug 2006")
Signed-off-by: Alexander Dahl <ada@thorsis.com>
---
 drivers/fpga/cyclon2.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/fpga/cyclon2.c b/drivers/fpga/cyclon2.c
index 7e78d6e2d6c..1c464c1e912 100644
--- a/drivers/fpga/cyclon2.c
+++ b/drivers/fpga/cyclon2.c
@@ -174,10 +174,7 @@ static int CYC2_ps_load(Altera_desc *desc, const void *buf, size_t bsize)
 		ret_val = FPGA_SUCCESS;
 
 #ifdef CONFIG_SYS_FPGA_PROG_FEEDBACK
-		if (ret_val == FPGA_SUCCESS)
-			puts("Done.\n");
-		else
-			puts("Fail.\n");
+		puts("Done.\n");
 #endif
 
 		/*

base-commit: ae5711f881100f856ead1e76832c32b92dba93c7
-- 
2.39.5

