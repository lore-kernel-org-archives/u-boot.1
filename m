Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53450C02193
	for <u-boot@archiver.kernel.org>; Tue,  4 Feb 2025 20:56:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4338F801BE;
	Tue,  4 Feb 2025 21:56:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=freemail.hu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=freemail.hu header.i=@freemail.hu header.b="TyjXBGMI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02112801DE; Tue,  4 Feb 2025 21:56:38 +0100 (CET)
Received: from smtp-out.freemail.hu (fmfe15.freemail.hu [46.107.16.208])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF5CA800B3
 for <u-boot@lists.denx.de>; Tue,  4 Feb 2025 21:56:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=freemail.hu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=egyszeregy@freemail.hu
Received: from localhost.localdomain (catv-178-48-208-49.catv.fixed.one.hu
 [178.48.208.49])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp.freemail.hu (Postfix) with ESMTPSA id 4YnbJL6V8Zz2rP;
 Tue, 04 Feb 2025 21:56:34 +0100 (CET)
From: egyszeregy@freemail.hu
To: u-boot@lists.denx.de
Cc: michal.simek@amd.com, love.kumar@amd.com,
 =?UTF-8?q?Benjamin=20Sz=C5=91ke?= <egyszeregy@freemail.hu>
Subject: [PATCH v2] zynqmp: Save "bootseq" environment variable in decimal
 format
Date: Tue,  4 Feb 2025 21:56:17 +0100
Message-ID: <20250204205617.1238-1-egyszeregy@freemail.hu>
X-Mailer: git-send-email 2.47.1.windows.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/relaxed; t=1738702595; 
 s=20181004; d=freemail.hu;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 l=944; bh=Rpru7JteBKBQDpODRj+jYQpjJ/Asap49ImIsYWjINEE=;
 b=TyjXBGMIcSKr8IWsxANhwxLm/01JWJNooa4K6dxMN8FDBZ2JZBTTPkJK9mA9o/zU
 XDRwgfMGJ8vY4vdYMqqF7ESaiWm6UofllUOuNO0AZEZqE9b8BIS/AW9XT7X0Rkc5pAO
 i54y0hUjlJMk5nTUXevWVounN43ahXfec1+8qzGl7npNrwCw60abewa1KfK6D7I/jYO
 pAWyH5QIHNMpud36xSxnSgNnW8yS4s4D4EdiF8jDzSGyv9IXRIsFwYu5Sy0dFJuJ3WB
 LJoN9/My7xUEGcfRD28tiwAr935ZCd8cYsezolhDLcw4Q9KS1RZIJXtjlSTIAWxLuqC
 ZHPHhPtMYA==
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

From: Benjamin Szőke <egyszeregy@freemail.hu>

In U-Boot, most of mmc releated commands uses decimal value in arguments, like
"mmc dev ${bootseq}" or "bootargs=root=/dev/mmcblk${bootseq}p2". In order to
improve compatibilities, export "bootseq" number to environment variable in
decimal format instead of hex.

Signed-off-by: Benjamin Szőke <egyszeregy@freemail.hu>
---
 board/xilinx/zynqmp/zynqmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/xilinx/zynqmp/zynqmp.c b/board/xilinx/zynqmp/zynqmp.c
index 8cdd9d8600..820fb252a3 100644
--- a/board/xilinx/zynqmp/zynqmp.c
+++ b/board/xilinx/zynqmp/zynqmp.c
@@ -488,7 +488,7 @@ static int boot_targets_setup(void)
 		if (bootseq >= 0) {
 			bootseq_len = snprintf(NULL, 0, "%i", bootseq);
 			debug("Bootseq len: %x\n", bootseq_len);
-			env_set_hex("bootseq", bootseq);
+			env_set_ulong("bootseq", (unsigned long)bootseq);
 		}
 
 		/*
-- 
2.47.1.windows.2

