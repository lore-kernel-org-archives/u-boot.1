Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BF08FD2D74
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 13:19:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B608A83FDE;
	Tue, 10 Mar 2026 14:19:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="aoG0X00n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1033183FE1; Tue, 10 Mar 2026 14:18:59 +0100 (CET)
Received: from mta-64-225.siemens.flowmailer.net
 (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B53783981
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 14:18:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id
 20260310131855e359704e8500020763 for <u-boot@lists.denx.de>;
 Tue, 10 Mar 2026 14:18:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=uZ1RBzFPe2+AeM47Yzsyw3Kv6iu3FBMp2FpsZOdvVKs=;
 b=aoG0X00nWAWVdsdrXKDfdNavmzCEqMHin+AfPVSBsMPHWPOaA5pzA5LiDvx0nzQnKO62+i
 FPx0zNmIvVAFUjVZCpk6bqAbz66K/rLQhntszWBi1o/YGXpmCyXkTv9qvd8E5017STUddFGc
 St8QbT4Z4BT73/E/kRzNzoviwSLaQKiH8M8d3r1vZ23mxMnyBvXBOKX5yTfuKyoDGSZuVJLj
 bob24jTPHhTHPwdswPeEL0izogbX25I9kZV1770WQkOt8wv8bL2Rc9Yd0aEFxXYwmCiU596J
 IQz1q3APKF0Qqt0A6aXA1zr7LuQUdnzIWBkS25btLjzrcUM/+zY9KAfA==;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: u-boot@lists.denx.de
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] fdt: Prefer %pap over %llx
Date: Tue, 10 Mar 2026 14:18:40 +0100
Message-ID: <20260310131846.2141759-1-alexander.sverdlin@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer
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

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

In cases where phys_addr_t/phys_size_t is being printed, it's possible to
use tiny-printf-friendly %pap instead of %llx. For instance, in SPL, with
tiny-printf:

Before the patch:
fdtdec_setup_memory_banksize: DRAM Bank #0: start = 0xx, size = 0xx

After the patch:
fdtdec_setup_memory_banksize: DRAM Bank #0: start = 80000000, size = 40000000

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
 lib/fdtdec.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/lib/fdtdec.c b/lib/fdtdec.c
index 3779076377f..fb3375ea157 100644
--- a/lib/fdtdec.c
+++ b/lib/fdtdec.c
@@ -1077,8 +1077,7 @@ int fdtdec_setup_mem_size_base(void)
 
 	gd->ram_size = (phys_size_t)(res.end - res.start + 1);
 	gd->ram_base = (unsigned long)res.start;
-	debug("%s: Initial DRAM size %llx\n", __func__,
-	      (unsigned long long)gd->ram_size);
+	debug("%s: Initial DRAM size %pap\n", __func__, &gd->ram_size);
 
 	return 0;
 }
@@ -1129,10 +1128,10 @@ int fdtdec_setup_memory_banksize(void)
 		gd->bd->bi_dram[bank].size =
 			(phys_size_t)(res.end - res.start + 1);
 
-		debug("%s: DRAM Bank #%d: start = 0x%llx, size = 0x%llx\n",
+		debug("%s: DRAM Bank #%d: start = %pap, size = %pap\n",
 		      __func__, bank,
-		      (unsigned long long)gd->bd->bi_dram[bank].start,
-		      (unsigned long long)gd->bd->bi_dram[bank].size);
+		      &gd->bd->bi_dram[bank].start,
+		      &gd->bd->bi_dram[bank].size);
 	}
 
 	return 0;
-- 
2.52.0

