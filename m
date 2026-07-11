Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68D73C43458
	for <u-boot@archiver.kernel.org>; Sat, 11 Jul 2026 19:13:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8F668498B;
	Sat, 11 Jul 2026 21:13:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=grrlz.net header.i=@grrlz.net header.b="NzucdNqv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BB368498C; Sat, 11 Jul 2026 17:15:04 +0200 (CEST)
Received: from confino.investici.org (confino.investici.org [93.190.126.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84C9A847AF
 for <u-boot@lists.denx.de>; Sat, 11 Jul 2026 17:15:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=include@grrlz.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
 s=stigmate; t=1783782901;
 bh=TuffT+ZLkLh0fwb89+cvrimCZXt/0fpp7qTbeKKBbTA=;
 h=From:To:Cc:Subject:Date:From;
 b=NzucdNqv6Rk7iOYq4zis3V8rMy0cVqtsOwK5Sufqca3ZxGUa6BO+0DhTtBuSgSLpu
 drrkmbszHiPSTuI2ZgCt9KsngiGXqGxCteeO2GKOpRjqAjElCDBE/wVtppJV7agkJe
 tEEyv0zU6iHIbEuiJERkSc/gYtCjeE9GYscYbanE=
Received: from mx1.investici.org (unknown [127.0.0.1])
 by confino.investici.org (Postfix) with ESMTP id 4gyC1K6Bpcz112M;
 Sat, 11 Jul 2026 15:15:01 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4gyC1K32Cnz112H;
 Sat, 11 Jul 2026 15:15:01 +0000 (UTC)
From: Bradley Morgan <include@grrlz.net>
To: kauschluss@disroot.org
Cc: mk7.kang@samsung.com, trini@konsulko.com, u-boot@lists.denx.de,
 Bradley Morgan <include@grrlz.net>
Subject: [PATCH] board: samsung: exynos-mobile: select largest userdata
 partition by size
Date: Sat, 11 Jul 2026 15:15:01 +0000
Message-ID: <20260711151501.19853-1-include@grrlz.net>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 11 Jul 2026 21:13:38 +0200
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

The blkmap heuristic picks a partition to map for booting combined
images, which live in the userdata partition as it is the largest.
Compare info.size against largest_part_size rather than info.start,
which previously selected the partition with the highest start LBA.

Signed-off-by: Bradley Morgan <include@grrlz.net>
---
 board/samsung/exynos-mobile/exynos-mobile.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/samsung/exynos-mobile/exynos-mobile.c b/board/samsung/exynos-mobile/exynos-mobile.c
index d91e2e7d3f2..67f46831df2 100644
--- a/board/samsung/exynos-mobile/exynos-mobile.c
+++ b/board/samsung/exynos-mobile/exynos-mobile.c
@@ -228,7 +228,7 @@ static int exynos_blk_env_setup(void)
 			update_info.dfu_string = dfu_string;
 		}
 
-		if (info.start > largest_part_size) {
+		if (info.size > largest_part_size) {
 			largest_part_start = info.start;
 			largest_part_size = info.size;
 		}
-- 
2.53.0

