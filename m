Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32DB3E95A67
	for <u-boot@archiver.kernel.org>; Sun,  8 Oct 2023 01:55:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55ED2863CF;
	Sun,  8 Oct 2023 03:48:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Lk1jIriz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73E8A8477A; Sun,  8 Oct 2023 03:48:16 +0200 (CEST)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB12E833DE
 for <u-boot@lists.denx.de>; Sun,  8 Oct 2023 03:48:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-65b051a28b3so20662786d6.2
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 18:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696729671; x=1697334471; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=aOjwDeIdY2xVEeQrHr2RZ8rHsIIJwkgYKyWrSVM3y9k=;
 b=Lk1jIriznmKiS6gduakb0Js3Jw7tOQVlhbG8H1TvJ8g6PvPgnt6yQblpn7nglOEoRb
 Zg/9QtOvwNF1ht2ehbbqXnSQY7dY3nIpYqKMMumw1i7RWM2ndpW5uaD+y11M54L1bxxs
 mYiDYpGzS+6M2Gmog4KvFlpQS150bnc+YqquxNTrsZSriIW1ieu0BAICRWXCsSAuWdLj
 lO5v5TVIlpUgsHYy5MmiLoc7no0ZAHdp1aMVuGKJTSu9K2Rvcpc22jAzXwL9N3du7IrS
 ShqfZajVM2PLJBY2x5oh+5/HG7C8gNZBsqSVYbeplTuv9yLFttPXBqF4ayPulS1d3UnJ
 dgNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696729671; x=1697334471;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aOjwDeIdY2xVEeQrHr2RZ8rHsIIJwkgYKyWrSVM3y9k=;
 b=MFqsoMe9RFI5dHgsVz9nHQ8IvamULlCnt9qvGwIDtIEwXyPg0Kx0u91GyEOykXNvq0
 NQ6hwobiPC6/l8CyPRIuih0MiGDwilvXhK2jEGIg5BsqfLkdL81xTcCx5yui/C1kMRRa
 iZ8XEm2dHjU7EqqahU442j6EpN7F4l/LeQjHMhbJMWduYPHvjXJJdrP+bB+t1zYFNWd0
 uDRJdFoxShZM+jpdVvMwBFP/2weEvDitkNN/Iefq/qdDWbrVfs9jtoE59sznRAwOLwTu
 XaFrE7Pbeb8W6HVSx8GrvplgyjOLHL/muta2jFV0fiRzIUql5lxtHsP7iBcF+pIDOtIb
 K8SQ==
X-Gm-Message-State: AOJu0YzInGBonxu4EcV6dbSY+UltZGosOApXmsxnoac7+mwICy0BiKop
 5aaW7+bk/u1ozk0gM9oNVveBJ3vEfg+YVA==
X-Google-Smtp-Source: AGHT+IGys/bblQUR1CjLvwxN/8FYYgULVIW3IyqNy1SRxJZWeygSdbUzu9uZYDf8bbgeXIk/OpwJLA==
X-Received: by 2002:a0c:ea22:0:b0:65a:fc6a:1423 with SMTP id
 t2-20020a0cea22000000b0065afc6a1423mr11500701qvp.17.1696729671295; 
 Sat, 07 Oct 2023 18:47:51 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 d4-20020a0cdb04000000b0065b260eafd9sm2657317qvk.87.2023.10.07.18.47.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 07 Oct 2023 18:47:50 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: Harald Seiler <hws@denx.de>,
	Sean Anderson <seanga2@gmail.com>
Subject: [PATCH] spl: mmc: Fix subsequent calls to spl_mmc_load with CONFIG_BLK
Date: Sat,  7 Oct 2023 21:47:48 -0400
Message-Id: <20231008014748.1987840-1-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
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

MMC devices do not have uclass platdata containing blk_descs, only their
child block devices do. Fortunately, we have a function just for this
purpose. This fixes subsequent calls to spl_mmc_load.

Fixes: bf28d9a6599 ("spl: mmc: Use correct MMC device when loading image")
Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

 common/spl/spl_mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/spl/spl_mmc.c b/common/spl/spl_mmc.c
index a665091b00f..2be991d5890 100644
--- a/common/spl/spl_mmc.c
+++ b/common/spl/spl_mmc.c
@@ -396,7 +396,7 @@ static int spl_mmc_get_mmc_devnum(struct mmc *mmc)
 #if !CONFIG_IS_ENABLED(BLK)
 	block_dev = &mmc->block_dev;
 #else
-	block_dev = dev_get_uclass_plat(mmc->dev);
+	block_dev = mmc_get_blk_desc(mmc);
 #endif
 	return block_dev->devnum;
 }
-- 
2.37.1

