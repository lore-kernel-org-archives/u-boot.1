Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6F17C4332F
	for <u-boot@archiver.kernel.org>; Sun, 29 Oct 2023 03:50:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AC0887C79;
	Sun, 29 Oct 2023 04:49:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="V1oNKCOX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F50387C6A; Sun, 29 Oct 2023 04:49:02 +0100 (CET)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38157877AD
 for <u-boot@lists.denx.de>; Sun, 29 Oct 2023 04:49:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-41b7ec4cceeso23158511cf.1
 for <u-boot@lists.denx.de>; Sat, 28 Oct 2023 20:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698551339; x=1699156139; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JB8VL7GLUQCxOnEls2C1K85BIbDpDPAfM3VIOaKb3ok=;
 b=V1oNKCOXuDJ4qzrDeJHurnZTZ3MsILfUDOkDMfkNOed4h7QZbZcUwxBA6h9tmo73kA
 FecxFANrAtcEJSGSVaNq+SWOSaT+n7Te0z4jaoWclqfHMhNG2GYhf06/vN12RvtOW+35
 R/nLDE4h8igTz0s47Pk3N9uyEVj/c//x7DLumKUUTkJfiBqT37vUABwd0fvGPq3MFwZc
 G4idv0u/IAuiVOHQfPRIxl5+ggbyx3AQe0dReyS63s07dQzuwvqC2aE9WFyVi+APN8qw
 MjHVQKQqUepzCXb1E4HnJd8U8ZpaKIMyaAkD03+kQCOGtbEPT65FzI0cbamuxsRVSLjX
 q9EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698551339; x=1699156139;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JB8VL7GLUQCxOnEls2C1K85BIbDpDPAfM3VIOaKb3ok=;
 b=lnzN9MMMfKOBdwsj1jzDtPXTHID9w30a4SbZHkFNWwHjMYTi97tzcbti6Lgd4mSX53
 2NATrX133aRHl6JbSg3fPz21TIjf3dwafBfNJKFSXke8MsHTQHr8BLD6SeO/AvLP+RCn
 yUDxMRhPlm08ZAV/KGosVuZB0ouCt+zLfFT7Vn5QXRI2Q02xMcg4AfTAClRzoiSJm7/s
 8k9wdSl8MpKncX3ZgTlHMopSsprkP6GSuZjQN3yLuBa+uDF3l5xEHtwQDQVcNIIOztJn
 fXvKFjZ6xKlEH8+VDR+KtgukP7AETHfOeHojv6RRjTRM4oi2/isKTKVyoldP88KNnoQ9
 xULg==
X-Gm-Message-State: AOJu0YwGm1HoQ7BkLKdrL/5BlCD6PxWrQYOuhPg2zoJpL5OjIdbw7Dc9
 Pu4Ju6Bk+6OlVBaZCaxGTmEUyaCZLV/1yA==
X-Google-Smtp-Source: AGHT+IH1tvbMKyK48dD+VMJB2KRzLoH2n4NojhyO2m3jW8Lp+OxfubNxm1UssB64aI26hjZG8knw+Q==
X-Received: by 2002:ac8:5882:0:b0:41c:d916:75d9 with SMTP id
 t2-20020ac85882000000b0041cd91675d9mr7427547qta.32.1698551338747; 
 Sat, 28 Oct 2023 20:48:58 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 c11-20020a0ce14b000000b0065823d20381sm2177915qvl.8.2023.10.28.20.48.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 28 Oct 2023 20:48:58 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Cc: Tom Rini <trini@konsulko.com>,
	Sean Anderson <seanga2@gmail.com>
Subject: [PATCH 08/15] spl: nand: Map memory before accessing it
Date: Sat, 28 Oct 2023 23:48:38 -0400
Message-Id: <20231029034845.1169614-9-seanga2@gmail.com>
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

In sandbox we must map memory before accessing it. Do so for the NAND load
method.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

 common/spl/spl_nand.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/common/spl/spl_nand.c b/common/spl/spl_nand.c
index 509e6047999..ff47767fe72 100644
--- a/common/spl/spl_nand.c
+++ b/common/spl/spl_nand.c
@@ -11,6 +11,7 @@
 #include <log.h>
 #include <spl.h>
 #include <asm/io.h>
+#include <mapmem.h>
 #include <nand.h>
 #include <linux/libfdt_env.h>
 #include <fdt.h>
@@ -32,7 +33,8 @@ static int spl_nand_load_image(struct spl_image_info *spl_image,
 
 	nand_spl_load_image(spl_nand_get_uboot_raw_page(),
 			    CFG_SYS_NAND_U_BOOT_SIZE,
-			    (void *)CFG_SYS_NAND_U_BOOT_DST);
+			    map_sysmem(CFG_SYS_NAND_U_BOOT_DST,
+				       CFG_SYS_NAND_U_BOOT_SIZE));
 	spl_set_header_raw_uboot(spl_image);
 	nand_deselect();
 
@@ -122,7 +124,8 @@ static int spl_nand_load_element(struct spl_image_info *spl_image,
 		if (err)
 			return err;
 		return nand_spl_load_image(offset, spl_image->size,
-					   (void *)(ulong)spl_image->load_addr);
+					   map_sysmem(spl_image->load_addr,
+						      spl_image->size));
 	}
 }
 
-- 
2.37.1

