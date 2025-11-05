Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E569FCCFA04
	for <u-boot@archiver.kernel.org>; Wed,  5 Nov 2025 00:21:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CB1583981;
	Wed,  5 Nov 2025 01:21:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="qo5T9Bcy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DFE1839B1; Wed,  5 Nov 2025 01:21:49 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D30F83957
 for <u-boot@lists.denx.de>; Wed,  5 Nov 2025 01:21:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03 (unknown [93.94.208.154])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id BF298405D7; 
 Wed,  5 Nov 2025 00:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1762302107;
 bh=pLfHJlUsg5zZc8MDysk63y0n6epZ4YkiAtx396ULmWY=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=qo5T9Bcy/kMur3lezyoCbvzEIScziRG7kUpKuIvNInrfSteYWLzAoc0DKXvjpAadP
 vrM23A3DddazyycMksDRBBjluGqRoKpozFbT099N7MszKjnGjxu4jqV/xQM4jhmnpc
 widwC248jl2dhofRFzpqAQfho/Hy4jBeKGdVrvBUIgnWHyre4ax27jqO4Vt1MDV672
 8/do63HUy6qi4fFYjchbzLqSaSn2hNfLRbGW9IPIQ81oSbfh12kIgsc2ITAh0lnTbq
 xDnKmT5B/uBNXm26wNZYxI1/ygc0mFNiYlRFfhFs3CJuiuOt6KwMIucV/Mt30FqmJ8
 Ft0tinpKIqStygCz92tygmAJ+3FGRbqk8osTmEvJR2nkisw3MU3qRGsqqlHuo+7z1a
 zZqat+WNOddJ+gbsfcKcXAA+H8kpiNk7HKak0JQGRySXa1oplgzWm02PlFDmJVO5Lj
 LZWSuxKxWv9wsLMgRVU0nN+XzueY7VpiqLIH8VH9i2AcZQw2xC/KVSNk49zu9JnAwg
 h9/juKFztVMXQvGLwXSpPS3owZ6Zw4bK5hH2JJ/LYkCK054aim0HoDBGeoGqX3L0Wh
 ED4cPVhkO5rUn4LeSEuZ6pxFhFvSImISyEoGMu5qKed+D9SUsXujQZM/yQcVOev9U5
 27+SYo37doV2iDhtrhS9C02U=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Anshul Dalal <anshuld@ti.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] spl: nand: typo 'destintion'
Date: Wed,  5 Nov 2025 01:21:44 +0100
Message-ID: <20251105002144.93283-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
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

%s/destintion/destination/

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 common/spl/spl_nand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/spl/spl_nand.c b/common/spl/spl_nand.c
index 032f2466278..f449b31f594 100644
--- a/common/spl/spl_nand.c
+++ b/common/spl/spl_nand.c
@@ -111,7 +111,7 @@ static int spl_nand_load_image_os(struct spl_image_info *spl_image,
 	int *src, *dst;
 	nand_spl_load_image(CONFIG_CMD_SPL_NAND_OFS, CONFIG_CMD_SPL_WRITE_SIZE,
 			    (void *)CONFIG_TEXT_BASE);
-	/* copy to destintion */
+	/* copy to destination */
 	for (dst = (int *)CONFIG_SPL_PAYLOAD_ARGS_ADDR,
 	    src = (int *)CONFIG_TEXT_BASE;
 	     src < (int *)(CONFIG_TEXT_BASE + CONFIG_CMD_SPL_WRITE_SIZE);
-- 
2.51.0

