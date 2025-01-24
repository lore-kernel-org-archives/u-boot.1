Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48777C02181
	for <u-boot@archiver.kernel.org>; Fri, 24 Jan 2025 15:15:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87F8D80A3E;
	Fri, 24 Jan 2025 16:15:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T1e+tJkR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58C3280977; Fri, 24 Jan 2025 16:14:55 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4D6480ADA
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 16:14:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eichest@gmail.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4361815b96cso15290595e9.1
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 07:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737731692; x=1738336492; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PfCA6XrcFE3SI50VS7v7aCAeLoaCQVUNw1sOddRHE74=;
 b=T1e+tJkRGok1YFgDS57Iiu+iS075XYqRuUUbwvxHAU1H2Dq1RYHtRsK3rtwJq3Y6R6
 JnMw61cCU/75dxjUflqc2i1wIa87WRTSC5DcZ9z8qSFsjQKNY3hQ9n2vTSs5IvTGgWzO
 xzIHMbNGeP9O6QsS3p8zsR+kUD8isRdl3KEt5mfABCM3peQTGcE0QxIOgL8FNgpq+quc
 19YrLRSm74aqYZnUP3i+W3jQpFkcMp/WJHtEXa+OnbJHDJ1eL2//TdS6YdNC8YGPKK3l
 wIr8uC80TJJndKBSEr5ZmwWZuMYmZei5sOyR6HB5lP74BLh8c67HGXOCDTHlgypBtVaB
 2q8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737731692; x=1738336492;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PfCA6XrcFE3SI50VS7v7aCAeLoaCQVUNw1sOddRHE74=;
 b=DYDF9WF6Iu6K7+WqGEjw6hIDYXka0OvbZiaax1NYGWoUU1qb0I8JphcpjrT3iDaP1A
 xSRE5N0LNzP2IVYQOww2jlnTcRhACnkMh3n18O8qni8nKuV7fmq54nwI5f+1EtZfDsrB
 0Lc+DqPBqjgaq4k4FyS4EIhNXUm1qWgR7CAq3EmzhnlY2hvp32caIAR+/bFvccT/Y09/
 l1pNbR5BXwnijz8t7qjbKrK6CH2F4pCGx0rMO8oFeG1kFIff6gIpZfLD1/JbWVjKXZie
 6m8gKSnjos6XoiY7Z6ak1POXTwOxH+HwTKE7M0ahg0Ygi/8m1XntfcgAV6DVF3wqn2W5
 LRtw==
X-Gm-Message-State: AOJu0YxRng6MCDtVUfNqg57tIhRFIH1VewMYGKlieZRPSVEwQ/pMzJfn
 Yem00YMZ8vp1onBYriRbPcwBUJgnmr647zwsEPeShZCg1i6hBSHVZ65dVEVs
X-Gm-Gg: ASbGncsaUGQGokT2mRarPP0UZDylCVNEIXhETc7svy3ahs57fez6IHViO87WcmhuqpG
 FK1LGT2AAl4rOPfsU2N78StgZ+3hF2qmArBrOMyAe598B2aYRJB8hE4GiW6uln1zRQaam/RzcWm
 dsA1JoXmy/R0P2Q759XTipNE9Ly30CtawPGmaiTbxVZJXEwVsIE2Tzi3Rr1QDiHlsyr9DjtA8sp
 RNcrSF2fULmSe00Cz7sGoxc1rBBk1YFW/A9riHC7CiqrwSM9IL0oBGg6P5wknfS/Vju19VVx+rc
 xt9e8Iu1
X-Google-Smtp-Source: AGHT+IF1I6NkT3IR6XnLOrzkLDWLU3fv5gMWM5bXAfg+IHN5D8S9HLhYEhfT7tOe8N/r0yVCsC4+Gg==
X-Received: by 2002:a05:6000:4025:b0:38a:36a5:ff81 with SMTP id
 ffacd0b85a97d-38bf59e254bmr29399596f8f.40.1737731690533; 
 Fri, 24 Jan 2025 07:14:50 -0800 (PST)
Received: from eichest-laptop.lan ([2a02:168:af72:0:58db:611:d7b2:c596])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a188915sm2932826f8f.41.2025.01.24.07.14.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 07:14:50 -0800 (PST)
From: Stefan Eichenberger <eichest@gmail.com>
To: francesco.dolcini@toradex.com, trini@konsulko.com,
 stefan.eichenberger@toradex.com, emanuele.ghidoli@toradex.com,
 joao.goncalves@toradex.com, vitor.soares@toradex.com,
 igor.opaniuk@foundries.io, max.krummenacher@toradex.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v1] toradex: tdx-cfg-block: fix switch to user partition
Date: Fri, 24 Jan 2025 16:14:30 +0100
Message-ID: <20250124151443.576075-1-eichest@gmail.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 24 Jan 2025 16:15:19 +0100
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

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

The Toradex configuration block is stored in the first boot partition of
the eMMC. After reading the configuration block, U-Boot switches back to
the user partition. Currently, this operation always targets mmc device
0, even when the configuration block is stored on mmc device 2.

This patch addresses the issue by switching the mmc device set in
CONFIG_TDX_CFG_BLOCK_DEV to the user partition, rather than using the
hardcoded device 0.

Fixes: a2777ecb9d11 ("toradex: config block handling")
Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
---
 board/toradex/common/tdx-cfg-block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/toradex/common/tdx-cfg-block.c b/board/toradex/common/tdx-cfg-block.c
index 3855e15b83b..b2149438b88 100644
--- a/board/toradex/common/tdx-cfg-block.c
+++ b/board/toradex/common/tdx-cfg-block.c
@@ -312,7 +312,7 @@ static int tdx_cfg_block_mmc_storage(u8 *config_block, int write)
 
 out:
 	/* Switch back to regular eMMC user partition */
-	blk_select_hwpart_devnum(UCLASS_MMC, 0, 0);
+	blk_select_hwpart_devnum(UCLASS_MMC, dev, 0);
 
 	return ret;
 }
-- 
2.45.2

