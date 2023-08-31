Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2057C83F22
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 02:50:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FEAB8655E;
	Thu, 31 Aug 2023 04:50:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eAtlrAOp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9BDD86575; Thu, 31 Aug 2023 04:50:01 +0200 (CEST)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1ED3386546
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 04:49:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=twoerner@gmail.com
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-65166804282so7291096d6.0
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 19:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693450197; x=1694054997; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wNclMBUAGpOZcEtLDu+pgkLB1KmNKupAnfxCG5b9+bU=;
 b=eAtlrAOp3g8i7+MbGV+8FyUfL59EW6A3astmxiknhNE4XBje9XwYLV6TiujICymsNn
 mvfeCfqXSWqPDKj7eUwlGRdkAy1ODLywcX48dwNBXgsHS/fEIM/OnV7CS09tmTCLyUl1
 7EAd3GSTTfrCAqNrLEdfqTqYdcUY/HC6pOIij17X8baE0LXDtsGFM8gCdKmaxrrQH1Pr
 1KVvG1njVMXklt9J2W5+1tBAXToZQv+VAuVeiXjFGsgEITyVC6Kc9xjcu2RBQCR3o5Tv
 jFjud6yAXbN4I/Tmcn5HInppZGhaQvIJzyD1JWTdnu3C6QYohTgosyMYdBoOgiCrGme0
 Gu8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693450197; x=1694054997;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wNclMBUAGpOZcEtLDu+pgkLB1KmNKupAnfxCG5b9+bU=;
 b=FXjOSGtiqw2ypFl8HDz12U5Si9ykwg3gpHmm1mCfDuYXj7sq4IGUPIdllHNBHN6qt+
 xR6O+1kgCarWpnxgAoCI3VA/ZEje/PTs7P4hwWsXXJjx25g3Lu2/8It63qB+V6EVo0VB
 iQuwsLy1001AytZoQ3iKt7yG6pmAQ1bL3t75n6YaLdCl4Y2DIWSFj5328dXrho8eyTUp
 /Hamfu1FuxdzQdDeuf+Y+hWmBmBzohFZydlj8DZ5lE2NA1aWM1DjAKy0BIkM+JK8dKI2
 HVgr0tIeU1nNbgJTFBzzAHHTh3a/AGJCEpPhRyJT2doi6+Upn5dFX0lDZvMMkk6gaqTg
 ZQYQ==
X-Gm-Message-State: AOJu0Yyefn9/bLdOPcqUpiqHWKuwvJrJhQK1UtlvynhLnkhxNXBNZMo1
 nqMlUOjruL5oZadu7oDjFBnE3xd/P+4=
X-Google-Smtp-Source: AGHT+IETvRR5h6OHb4KI/Kc1Msq8ZkpP+ivLiBvy3Btl3dK6pH1StRSe92k0dVwVgiqLyhcVvXbqHg==
X-Received: by 2002:a0c:aa9b:0:b0:647:18f8:36eb with SMTP id
 f27-20020a0caa9b000000b0064718f836ebmr2021198qvb.27.1693450197192; 
 Wed, 30 Aug 2023 19:49:57 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca.
 [209.91.167.254]) by smtp.gmail.com with ESMTPSA id
 m15-20020ae9e00f000000b0076f124abe4dsm213160qkk.77.2023.08.30.19.49.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 19:49:56 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Michal Suchanek <msuchanek@suse.de>
Subject: [PATCH] am33xx: ignore return value from usb_ether_init()
Date: Wed, 30 Aug 2023 22:49:50 -0400
Message-ID: <20230831024951.22599-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.41.0.327.gaa9166bcc0ba
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

In 2cb43ef1c223 ("usb: ether: Fix error handling in usb_ether_init") the error
handling of usb_ether_init() was changed. Not a single other call site of this
function checks its return value, therefore follow suit in the am33xx code.

Do not cause the boot to halt if the usb gadget ethernet initialization fails:

	initcall sequence 9ffdbd84 failed at call 808024b9 (err=-19)
	### ERROR ### Please RESET the board ###

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 arch/arm/mach-omap2/am33xx/board.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/am33xx/board.c b/arch/arm/mach-omap2/am33xx/board.c
index ecc0a592e993..8f772310a1a7 100644
--- a/arch/arm/mach-omap2/am33xx/board.c
+++ b/arch/arm/mach-omap2/am33xx/board.c
@@ -270,11 +270,7 @@ int arch_misc_init(void)
 		return ret;
 
 #if defined(CONFIG_DM_ETH) && defined(CONFIG_USB_ETHER)
-	ret = usb_ether_init();
-	if (ret) {
-		pr_err("USB ether init failed\n");
-		return ret;
-	}
+	usb_ether_init();
 #endif
 
 	return 0;
-- 
2.41.0.327.gaa9166bcc0ba

