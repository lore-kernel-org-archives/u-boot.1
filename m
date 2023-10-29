Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F0E1C4332F
	for <u-boot@archiver.kernel.org>; Sun, 29 Oct 2023 03:49:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14B4F87C64;
	Sun, 29 Oct 2023 04:49:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Bil8hP3i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A68F87751; Sun, 29 Oct 2023 04:48:59 +0100 (CET)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDE6E87776
 for <u-boot@lists.denx.de>; Sun, 29 Oct 2023 04:48:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-41cd7a3e8f8so26600221cf.0
 for <u-boot@lists.denx.de>; Sat, 28 Oct 2023 20:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698551331; x=1699156131; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nWBWmqeOkSYAIUr5n1CrmyFBqUfSrcBk98FOc3YU4ck=;
 b=Bil8hP3iVCJE2N39Yd/RcCwzrg8HlVdcTtPeEmyjsZuB0SWB1mxXadbSVZ8NDVE1Yj
 ksJH2llRvmDSq6GY+NI8oIesaTlyf8Q9QegGSVY11swHa7SC8nsGaWEXE9Pz6r6bTb5u
 3FZYk0alI7Ialii4prlEM306FY4foaBnY4Iv8Dn8UvcavX99THf4A+FQ0Ve5NvWv3I1J
 1EXPh8cI6cpVOUKI806MZSNpM1VrYby9Z7SeJ3NO2aMeRMJD2DjX9eJPbaSzojquf+H2
 T6Pz4NfEqBHS8Ay4gIlGvaH1TVSev0KjS9cZNcXFAzPXItwgOlwdxaS8oLRmj/5F1Aj6
 gJVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698551331; x=1699156131;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nWBWmqeOkSYAIUr5n1CrmyFBqUfSrcBk98FOc3YU4ck=;
 b=hH5ljTFtPj6VvKs6Mt4Tf5T8lwZ7EQ1G4Ke+rvKJ1YdDdyQ+ulv81uFjKKD444U7Rb
 laIJcMrFjR/2ZYiTVs5Mw/EyNKC5wkZfTruOn1WogHRyAPwZ9vvQPsIwK1WmiiPMzByO
 5Ohi2wn6JMoCTTvaXrozkJHX0unx2VJwMzhIlKj6fts0IUgD0wjGnLwHnl1hijT/G4i2
 ik7hC6/7FwlJhTEEytweNd/78LbiccIFSi1x8OJ156USp9ThFoHTgWwLWXSCKzmSg8FE
 YHmAe3acL15nQszM0eLUDgooJpVjWAWymp80h8W/HLd30vQgDF7pGSDl8flv8nERL5X2
 /FXA==
X-Gm-Message-State: AOJu0YxCUwR1FFHht2VcEEdKreHy5B+giRbqgIGBiLydyN101gbbYQJp
 slZ1uBJsdyFShokZoxoGCy07dtE8m1i76Q==
X-Google-Smtp-Source: AGHT+IG4k/ePNUPxfXNESfWMDb3WeeahHqtb/Ct8KXh/iybw84QVrY6zsIzkjstuQiTsEw4fIQWPzw==
X-Received: by 2002:a05:622a:64b:b0:40e:6f1:3d38 with SMTP id
 a11-20020a05622a064b00b0040e06f13d38mr9479130qtb.8.1698551331301; 
 Sat, 28 Oct 2023 20:48:51 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 do10-20020a05622a478a00b004181b41e793sm2171775qtb.50.2023.10.28.20.48.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 28 Oct 2023 20:48:50 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Cc: Tom Rini <trini@konsulko.com>, Sean Anderson <seanga2@gmail.com>,
 Heiko Schocher <hs@denx.de>
Subject: [PATCH 02/15] nand: Don't dereference NULL manufacturer_desc
Date: Sat, 28 Oct 2023 23:48:32 -0400
Message-Id: <20231029034845.1169614-3-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231029034845.1169614-1-seanga2@gmail.com>
References: <20231029034845.1169614-1-seanga2@gmail.com>
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

When no manufacturer is matched, manufacturer_desc is NULL. Avoid
dereferencing it in that case.

Fixes: 4e67c571252 ("mtd,ubi,ubifs: sync with linux v3.15")
Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

 drivers/mtd/nand/raw/nand_base.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 6b4adcf6bdc..44b6cb63a01 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -4462,17 +4462,14 @@ ident_done:
 	else if (chip->jedec_version)
 		pr_info("%s %s\n", manufacturer_desc->name,
 			chip->jedec_params.model);
-	else
+	else if (manufacturer_desc)
 		pr_info("%s %s\n", manufacturer_desc->name, type->name);
 #else
 	if (chip->jedec_version)
 		pr_info("%s %s\n", manufacturer_desc->name,
 			chip->jedec_params.model);
-	else
+	else if (manufacturer_desc)
 		pr_info("%s %s\n", manufacturer_desc->name, type->name);
-
-	pr_info("%s %s\n", manufacturer_desc->name,
-		type->name);
 #endif
 
 	pr_info("%d MiB, %s, erase size: %d KiB, page size: %d, OOB size: %d\n",
-- 
2.37.1

