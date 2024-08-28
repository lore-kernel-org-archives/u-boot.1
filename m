Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25EDDC54FB3
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 13:26:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7286888C6;
	Wed, 28 Aug 2024 15:26:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZB4JlGhw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D877E8884F; Wed, 28 Aug 2024 15:26:07 +0200 (CEST)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3AF1888A3
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 15:26:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2d679b094ffso2869222a91.1
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 06:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724851564; x=1725456364; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U17/mas3jfUpdY9eMvQwnGt0xFtamNZ4WJ8QXK5VdBw=;
 b=ZB4JlGhwh43iEhu3A5JxDrrLCOuWbWOxjltBsFWNlWXaTmTXQj0Np8/NJ5+T93njNF
 BC2bA8yAJv7WNmy3TF2oepha6o67kN82mpGhVcd7QmArV3oLFmxOudTlRZ2D5lp5rFUB
 OK3Jxd+5Ns4LcnaiTQFoyaYxJLLJ7t7UV/+sUSjNFGRaZG6Nb//LtKljHRuKX8Vs+elO
 Ne7KjPdt/0/AIq4+RbvsPmervCjX3G9R5c9l12uhclkigxa6r1UKZNFZ2HkRycntxd0j
 KxtDmhV6GI8Gwo2hbwsLnr2E+6kCLxHP/B1h7JGiG2Ryvw4WC+nhj1CHEO5TUKZlf19t
 VMPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724851564; x=1725456364;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U17/mas3jfUpdY9eMvQwnGt0xFtamNZ4WJ8QXK5VdBw=;
 b=SoYuRrq6gWvOysRD7onxjS3kgCYtHDnCSLgLlSqoDndLtRcKTKRkLtGCQf4xLQFTFa
 7AdxofHh2uHgXFeu1CxPE05rLenTHy+yc5nEbpxrIr9ylfBe4WV7Wf7ydwRKXLJ59UPA
 V91Wv3TTtVqqQKR8IbmelUGl35VIheZRLiE3KK2PoCtMQMdEcI3RcWI+G4VQfdIVrGH/
 xIIz2qgG8OjCpRSPscZk7bugI7U7tD3FVabg/5YgGA1DDuiRxKFZTX/J2ZnLgQpi4v7s
 TutaqC+Bh1qitZdV50KN/Lh9YI75c/YvBI6MEVXL3JK6N0FCf92KAN6VIaIKLrg4IVN8
 4b0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYnFQOpRCES90SuLepD7XjFrNVY32DOLF6dLCFYYVr1gqq4HChPf9ZpLjtStMnZiV1Lj3ez+A=@lists.denx.de
X-Gm-Message-State: AOJu0YyWN29oIwcVh3SgT5S/n3psY5t4N/OOw8sCXdYMdfDc0wLf5aBJ
 1MGlvIf7VdI263Xn1uoxCuV8CnOUitHqo+f4A2X3hEL1MokqK6n+
X-Google-Smtp-Source: AGHT+IFG1UJODljDyIv8+bSa2KchiKW1hJxhaq/UBnfYZhubPX+09vdwmnifed/P31LExl8vYY5mtA==
X-Received: by 2002:a17:90b:33d1:b0:2d3:d063:bdb6 with SMTP id
 98e67ed59e1d1-2d646b8f89cmr15618181a91.4.1724851564084; 
 Wed, 28 Aug 2024 06:26:04 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:4b3a:557e:6b5b:dbdc])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d844617777sm1788660a91.24.2024.08.28.06.26.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 06:26:03 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: peng.fan@nxp.com
Cc: marex@denx.de, u-boot@lists.denx.de, tharvey@gateworks.com, smoch@web.de,
 Fabio Estevam <festevam@denx.de>
Subject: [PATCH v3 3/4] mx5: Remove CFG_MXC_USB_PORT
Date: Wed, 28 Aug 2024 10:25:28 -0300
Message-Id: <20240828132529.3098961-3-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828132529.3098961-1-festevam@gmail.com>
References: <20240828132529.3098961-1-festevam@gmail.com>
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

From: Fabio Estevam <festevam@denx.de>

CFG_MXC_USB_PORT is not used anywhere, so remove this unused symbol.

Suggested-by: Tim Harvey <tharvey@gateworks.com>
Signed-off-by: Fabio Estevam <festevam@denx.de>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
Changes since v2:
- None.

 include/configs/m53menlo.h   | 1 -
 include/configs/mx51evk.h    | 1 -
 include/configs/mx53cx9020.h | 1 -
 include/configs/mx53loco.h   | 1 -
 include/configs/mx53ppd.h    | 1 -
 include/configs/usbarmory.h  | 1 -
 6 files changed, 6 deletions(-)

diff --git a/include/configs/m53menlo.h b/include/configs/m53menlo.h
index 1491c509820..51ce030d831 100644
--- a/include/configs/m53menlo.h
+++ b/include/configs/m53menlo.h
@@ -70,7 +70,6 @@
  * USB
  */
 #ifdef CONFIG_CMD_USB
-#define CFG_MXC_USB_PORT		1
 #define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
 #endif
 
diff --git a/include/configs/mx51evk.h b/include/configs/mx51evk.h
index dff54d04a67..6c8cb78274b 100644
--- a/include/configs/mx51evk.h
+++ b/include/configs/mx51evk.h
@@ -33,7 +33,6 @@
 #define CFG_SYS_FSL_ESDHC_ADDR	MMC_SDHC1_BASE_ADDR
 
 /* USB Configs */
-#define CFG_MXC_USB_PORT	1
 #define CFG_MXC_USB_PORTSC	PORT_PTS_ULPI
 #define CFG_MXC_USB_FLAGS	MXC_EHCI_POWER_PINS_ENABLED
 
diff --git a/include/configs/mx53cx9020.h b/include/configs/mx53cx9020.h
index ab6b0b65556..38bafc5156d 100644
--- a/include/configs/mx53cx9020.h
+++ b/include/configs/mx53cx9020.h
@@ -22,7 +22,6 @@
 /* bootz: zImage/initrd.img support */
 
 /* USB Configs */
-#define CFG_MXC_USB_PORT	1
 #define CFG_MXC_USB_PORTSC	(PORT_PTS_UTMI | PORT_PTS_PTW)
 
 /* Command definition */
diff --git a/include/configs/mx53loco.h b/include/configs/mx53loco.h
index 04f4b723209..e9340c59ae1 100644
--- a/include/configs/mx53loco.h
+++ b/include/configs/mx53loco.h
@@ -17,7 +17,6 @@
 #define CFG_SYS_FSL_ESDHC_ADDR	0
 
 /* USB Configs */
-#define CFG_MXC_USB_PORT	1
 #define CFG_MXC_USB_PORTSC	(PORT_PTS_UTMI | PORT_PTS_PTW)
 
 /* PMIC Controller */
diff --git a/include/configs/mx53ppd.h b/include/configs/mx53ppd.h
index 3c9a9fb045b..e0bfbbb459c 100644
--- a/include/configs/mx53ppd.h
+++ b/include/configs/mx53ppd.h
@@ -12,7 +12,6 @@
 #include <asm/arch/imx-regs.h>
 
 /* USB Configs */
-#define CFG_MXC_USB_PORT	1
 #define CFG_MXC_USB_PORTSC	(PORT_PTS_UTMI | PORT_PTS_PTW)
 
 /* Command definition */
diff --git a/include/configs/usbarmory.h b/include/configs/usbarmory.h
index 28d86a26362..1d7caaa1448 100644
--- a/include/configs/usbarmory.h
+++ b/include/configs/usbarmory.h
@@ -23,7 +23,6 @@
 #define CFG_SYS_FSL_ESDHC_ADDR	0
 
 /* USB */
-#define CFG_MXC_USB_PORT	1
 #define CFG_MXC_USB_PORTSC	(PORT_PTS_UTMI | PORT_PTS_PTW)
 
 /* Linux boot */
-- 
2.34.1

