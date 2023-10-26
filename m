Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B464CC25B6B
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 19:54:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D977F87562;
	Thu, 26 Oct 2023 21:54:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=hugovil.com header.i=@hugovil.com header.b="sm3YmaHI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56F308754B; Thu, 26 Oct 2023 21:54:56 +0200 (CEST)
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEF5487B7E
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 21:54:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hugo@hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
 ; s=x;
 h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
 :From:subject:date:message-id:reply-to;
 bh=WpAniTrMSGwdrP5g1KSAXWXR/zN0g1/KcDGOHjXvy/M=; b=sm3YmaHI0bGDJgEDqqE9eCrx5x
 Vb4rq5yR0UNjS3/BgrHZpdO/oYfumutxUxdYTLXqLKccHjErArF6T1C8czFsNt2bKZyjPgNrn7fp+
 iD4wlJqPuigT5/DRssa9vOhvXrTTIve+dWIYupzdms605mXPqxl0ktTWe3LUZFpUjOt4=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:35344
 helo=pettiford.lan) by mail.hugovil.com with esmtpa (Exim 4.92)
 (envelope-from <hugo@hugovil.com>)
 id 1qw6RP-0004bR-7r; Thu, 26 Oct 2023 15:54:51 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: 
Cc: hugo@hugovil.com, Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 u-boot@lists.denx.de
Date: Thu, 26 Oct 2023 15:54:49 -0400
Message-Id: <20231026195449.3922196-1-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
Subject: [PATCH] boot: Fix syntax in fdt_overlay_apply_verbose() error message
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
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

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Remove superfluous "did".

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 boot/fdt_support.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/fdt_support.c b/boot/fdt_support.c
index 5e49078f8c3..b15d07765fe 100644
--- a/boot/fdt_support.c
+++ b/boot/fdt_support.c
@@ -2095,7 +2095,7 @@ int fdt_overlay_apply_verbose(void *fdt, void *fdto)
 		printf("failed on fdt_overlay_apply(): %s\n",
 				fdt_strerror(err));
 		if (!has_symbols) {
-			printf("base fdt does did not have a /__symbols__ node\n");
+			printf("base fdt does not have a /__symbols__ node\n");
 			printf("make sure you've compiled with -@\n");
 		}
 	}

base-commit: fb428b61819444b9337075f49c72f326f5d12085
-- 
2.39.2

