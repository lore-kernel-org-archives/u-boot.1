Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6E59C4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 20:39:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EBA3871ED;
	Sat,  4 Nov 2023 21:38:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GSjl5G9G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4263086F99; Sat,  4 Nov 2023 21:38:13 +0100 (CET)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B210A8704D
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 21:38:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-66d11fec9a5so18287156d6.1
 for <u-boot@lists.denx.de>; Sat, 04 Nov 2023 13:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699130286; x=1699735086; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p4Uf0IUAPLXc9kn+UF6xy0QaUKykhXEvaKP/JJwTkGE=;
 b=GSjl5G9GxiXbCY2LTRgfWzgQEOhVWvuY1ArVHGMgissVnktV8MYCqi+L8Xbq4qnaJB
 LH5F6VK6vs688FSlr3IYshCB8Ewdl+iFMRq5XYU/F8oSW/eJr4dor0JZjf+OdETqUY6c
 SgGLRq9D8ZtX6jELzm1UtjNy17K8ouOVEs1CxChmua4TN94wAgMh+I5lAH7l3IYCouYD
 Y1Ij3r2DbzjaWKBigjFD2SvnCCMtp/RTvfX3HYiH79RU/3qCodl6dnxVbchSLYoM01AI
 wAkaICJkrIH2/pVEe+0V9ofBIMWdbpya1n7lyTI32vPK7rCCzR+v67k2BF5WfRZNR2JT
 1I7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699130286; x=1699735086;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p4Uf0IUAPLXc9kn+UF6xy0QaUKykhXEvaKP/JJwTkGE=;
 b=RDe1aocVvrlgm99FPYWYXPNM3bFJbDWIIs/snBUbtrKB08OD8ZBFyNk8QJC5z3ThId
 f5B3twRqx/pNRzXkrSO7luGYB6ea6LVR0vB/3wYbTnRqFsgsrmznd7yNTYCoupbvbkCS
 chCkh5l1m7aE5NX5lkG+tjPcRPkM8IBJrzChG+izsnnxx3q7GrE+K/GkdioL9DFie+4F
 yQWhmQgcIQrFNQPxYg1sWEhyUGzk2GiSLtZcQhfzMPFkEGIfBuT4CuNFtnMdtg8TQwjG
 xHwRBvycT26E/gMCc/SDIxuTPbqflckTnmVtYfbsVnMlYZO1pLeb0TvGhcXmvh4X2Ud7
 /NzQ==
X-Gm-Message-State: AOJu0YxIPjfOSM0zQjom2NJ0iM8f08I/+vG+fDWw3V9UK+87DkdvpfdL
 zjbklyHaX+4g/iLuQ9mbSv7YRbpGCnpibw==
X-Google-Smtp-Source: AGHT+IGxE2V0wxQbZZtWJV+0ojzwfG8iHq+kMyWT2MIT4f7gsM6Qhsbok4eiHPfkO3RohAB4GxXdKg==
X-Received: by 2002:a05:6214:4115:b0:66d:a22a:464f with SMTP id
 kc21-20020a056214411500b0066da22a464fmr23270053qvb.16.1699130285806; 
 Sat, 04 Nov 2023 13:38:05 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 i18-20020a0cedd2000000b006575372c845sm1921003qvr.119.2023.11.04.13.38.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Nov 2023 13:38:05 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Cc: Tom Rini <trini@konsulko.com>,
	Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v2 08/15] spl: nand: Map memory before accessing it
Date: Sat,  4 Nov 2023 16:37:46 -0400
Message-Id: <20231104203753.1579217-9-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231104203753.1579217-1-seanga2@gmail.com>
References: <20231104203753.1579217-1-seanga2@gmail.com>
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

(no changes since v1)

 common/spl/spl_nand.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/common/spl/spl_nand.c b/common/spl/spl_nand.c
index 57a7a1a73b9..b8cd6403ba4 100644
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

