Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52B1DC02196
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 16:33:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD16C800B3;
	Mon,  3 Feb 2025 17:33:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=freemail.hu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=freemail.hu header.i=@freemail.hu header.b="QYu0X7sl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FE91801A0; Mon,  3 Feb 2025 17:33:10 +0100 (CET)
Received: from smtp-out.freemail.hu (fmfe39.freemail.hu [46.107.16.244])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38BF380079
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 17:33:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=freemail.hu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=egyszeregy@freemail.hu
Received: from localhost.localdomain (catv-178-48-208-49.catv.fixed.one.hu
 [178.48.208.49])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp.freemail.hu (Postfix) with ESMTPSA id 4YmsVq04KlzLd;
 Mon, 03 Feb 2025 17:33:06 +0100 (CET)
From: egyszeregy@freemail.hu
To: u-boot@lists.denx.de
Cc: michal.simek@amd.com, love.kumar@amd.com,
 =?UTF-8?q?Benjamin=20Sz=C5=91ke?= <egyszeregy@freemail.hu>
Subject: [PATCH] zynqmp: Save "bootseq" environment variable in dec format
Date: Mon,  3 Feb 2025 17:32:50 +0100
Message-ID: <20250203163250.1618-1-egyszeregy@freemail.hu>
X-Mailer: git-send-email 2.47.1.windows.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/relaxed; t=1738600387; 
 s=20181004; d=freemail.hu;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 l=733; bh=y1QUR1u15C/QwKJAkePJeWk2HSMBoKGxLhbG2MJwmsw=;
 b=QYu0X7slOjjZsOY5W9npp71sNASjw+hEyAfK8ySnJZYF/vzw7r9gfoEWcKmMF1wp
 PKo5c2tCC6GG64hlbkK2Gyf7vb8fTMVGwYzjekAfiVahGWp+oBbtR9BgzJpzFm7rfZV
 uSNx/WWA4PuxDkSLGuO+1nUOZBnGSAOg12K1S4TR/O9e9HpD21NV+0eWCvROxZMgJ0B
 WYkAStu7URV+NV1SamINinEHOoRXAv06n8cSkcssDaVjwGDBeoIs9EpUcpfkluptmxu
 bf0DQy1XatUV8b8UjKFySw9cZv3UM2iMufZROZy7X82X5F62LJGM3fqmOZZ/SgDPMgB
 PX0QmQ3rdQ==
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

Save "bootseq" environment variable in decimal format.

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

