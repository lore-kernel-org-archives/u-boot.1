Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24AA2C021AA
	for <u-boot@archiver.kernel.org>; Mon, 17 Feb 2025 15:36:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76DFC8083C;
	Mon, 17 Feb 2025 16:36:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hFAihikP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 375F480843; Mon, 17 Feb 2025 16:36:25 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F431807F1
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 16:36:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=blemouzy.ml@gmail.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4397e5d5d99so7697545e9.1
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 07:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739806582; x=1740411382; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=T1IbXDBp7KdWMChUzQr6w9aBtVLhFhqsIOqWfW+sBPw=;
 b=hFAihikPDuc7BwC05YqSY/oLSNzPj1hifrNDLP2eGDSbBEDAzwjFMJ0y1k3tpCC0u6
 L6lYsi4af5xA3HFIedycdcVWNIRdwisunzQkBQx/5HYz79FKxhG0wGAc1ic51iBrosYj
 NTeGgv+MaTxWUhmx3vEaPNdaILw/T36yABYqsbo7D2C7UYVpTu58LVoeDWZtx3713/ps
 6b7etVvTjWuLdgubpnfIb5548SfG4q6j0PV/0pm2uAkFYRDp0OMCbgEsdclFtxBBf9X9
 ixFOWGm1LjX+RnIegYOckH61HZ2WjpHtWNU48gaSZieznoXwBjDsLDCiKhNC61OHO+JM
 Aikg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739806582; x=1740411382;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T1IbXDBp7KdWMChUzQr6w9aBtVLhFhqsIOqWfW+sBPw=;
 b=rNLXsI0HpMwts5+mTIjRF6i9uP1mQpyFKc9hUfyDjSIRJR6v/PvhJEpea3faiF+y8p
 K8eh/LxCKqHmlw3PaqhUE//OtWabt6lIEb1Gzf+zPGhY+UFFDSQz0Fk20MkDRpoM2gZx
 vX1tzPD74GRwrMxFPnSgVnkJ/awDWjFLksIC/wS+2QzC+9uTaxiXAgZ4b0yLaRKMx05d
 Zc1DxWhRvoNROXSQVFsX8QZXnA1GAp9bn40H7niw4xLI5Pu+7Usuy3pFa61PsldGxKwT
 dLtwVEEDiGa7qZvGL2+7VuDubtq7Y+nSyN8o2vOcRipNDpmIQULCT4JSvUBfkNVWpHKT
 Pt/g==
X-Gm-Message-State: AOJu0YzD1Bhux5uZBBpZYFDbshQt5KBIdICQeOdrNjpnwg5PKzEFVJm8
 pQgTKzu5fA4Z0gZ9qU1t9pzzehm2VZd8V6b5DrXwmiPZC40uvtDIrL2aKg==
X-Gm-Gg: ASbGnct7DKtG2r/3o4tFVosA+dhgpbcmn+dM0fWzWDMW8pxdgZkUuDFA4d35pXT2ejm
 RZM14kXZMJTeyZy0WTeAHmmL5Q19eZtInpI85apN3HsMgZOyHkPghNwI5uJVRPuO7XVqm0f9KZa
 5uSYfJnXXMCnoEjgMAQe+hzASqGVh//d+wRJq3/8gCkUSWaddmdEHr4hiHxVYASF5eVNlXiti51
 yNxsrGMl1xJ9nCBNzrP7WDoHPZamlavnuZJLcFhNjzO9n8a++lHJvJfhtRzBjaQ9+l+RFc5+0kA
 82ctQaVkjncAgZSpBt7iZLCGlIJTInM=
X-Google-Smtp-Source: AGHT+IHW1+d8tTAyD16k5yj0LigGnsaM4oeTdw3ooQC9YBh339UwoQzs1qD9jqyffCysrgR0KWIf/g==
X-Received: by 2002:a05:600c:3b8c:b0:439:5560:c9a3 with SMTP id
 5b1f17b1804b1-4396e6d4be0mr94657935e9.6.1739806582310; 
 Mon, 17 Feb 2025 07:36:22 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:10a:44e0:12ca:929b:46b5:3c0e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258b432asm12308710f8f.6.2025.02.17.07.36.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 07:36:22 -0800 (PST)
From: blemouzy.ml@gmail.com
X-Google-Original-From: blemouzy@centralp.fr
To: u-boot@lists.denx.de
Cc: alison.wang@nxp.com, sjg@chromium.org, trini@konsulko.com,
 olteanv@gmail.com, Benjamin Lemouzy <blemouzy@centralp.fr>
Subject: [PATCH] board: freescale: fix LS1021a build
Date: Mon, 17 Feb 2025 16:36:03 +0100
Message-ID: <20250217153603.100767-1-blemouzy@centralp.fr>
X-Mailer: git-send-email 2.43.0
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

From: Benjamin Lemouzy <blemouzy@centralp.fr>

Fix build error "undefined reference to `is_warm_boot'" when
ls1021atsn and ls1021atwr boards are built with CONFIG_SPL=y and
CONFIG_DEEP_SLEEP=n.

Signed-off-by: Benjamin Lemouzy <blemouzy@centralp.fr>
---
 board/freescale/ls1021atsn/ls1021atsn.c | 4 ++++
 board/freescale/ls1021atwr/ls1021atwr.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/board/freescale/ls1021atsn/ls1021atsn.c b/board/freescale/ls1021atsn/ls1021atsn.c
index d1acccec11..6d64df7cc4 100644
--- a/board/freescale/ls1021atsn/ls1021atsn.c
+++ b/board/freescale/ls1021atsn/ls1021atsn.c
@@ -159,7 +159,9 @@ int board_early_init_f(void)
 #ifdef CONFIG_XPL_BUILD
 void board_init_f(ulong dummy)
 {
+#if defined(CONFIG_DEEP_SLEEP)
 	void (*second_uboot)(void);
+#endif
 
 	/* Clear the BSS */
 	memset(__bss_start, 0, __bss_end - __bss_start);
@@ -181,6 +183,7 @@ void board_init_f(ulong dummy)
 	enable_layerscape_ns_access();
 #endif
 
+#if defined(CONFIG_DEEP_SLEEP)
 	/*
 	 * if it is woken up from deep sleep, then jump to second
 	 * stage U-Boot and continue executing without recopying
@@ -191,6 +194,7 @@ void board_init_f(ulong dummy)
 		second_uboot = (void (*)(void))CONFIG_TEXT_BASE;
 		second_uboot();
 	}
+#endif
 
 	board_init_r(NULL, 0);
 }
diff --git a/board/freescale/ls1021atwr/ls1021atwr.c b/board/freescale/ls1021atwr/ls1021atwr.c
index cc9665c041..937e766069 100644
--- a/board/freescale/ls1021atwr/ls1021atwr.c
+++ b/board/freescale/ls1021atwr/ls1021atwr.c
@@ -410,7 +410,9 @@ int board_early_init_f(void)
 #ifdef CONFIG_XPL_BUILD
 void board_init_f(ulong dummy)
 {
+#if defined(CONFIG_DEEP_SLEEP)
 	void (*second_uboot)(void);
+#endif
 
 	/* Clear the BSS */
 	memset(__bss_start, 0, __bss_end - __bss_start);
@@ -432,6 +434,7 @@ void board_init_f(ulong dummy)
 	enable_layerscape_ns_access();
 #endif
 
+#if defined(CONFIG_DEEP_SLEEP)
 	/*
 	 * if it is woken up from deep sleep, then jump to second
 	 * stage uboot and continue executing without recopying
@@ -442,6 +445,7 @@ void board_init_f(ulong dummy)
 		second_uboot = (void (*)(void))CONFIG_TEXT_BASE;
 		second_uboot();
 	}
+#endif
 
 	board_init_r(NULL, 0);
 }
-- 
2.43.0

