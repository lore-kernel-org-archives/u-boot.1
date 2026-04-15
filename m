Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A070BF428C0
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 18:36:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29DC884178;
	Wed, 15 Apr 2026 20:36:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Eucp8hB1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 637D3841B9; Wed, 15 Apr 2026 20:36:51 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A4758407D
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 20:36:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-488a14c31eeso57472155e9.0
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 11:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1776278209; x=1776883009;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RP1Fw95pNnQdx/Xy/sJ+OGaBiaj5ZhYIWtzbF+0J4Oc=;
 b=Eucp8hB1ek/Y26QtxshSohlRHQz3DoCvQ0pBrRQqsWJG9G+rYjUYK+H3EPmJAC9Qpp
 y+r5n5dgPf5lSnYDu3Ynu+nL0kRVNcapwCRXM2FC1+AstS36UPPe5/t6DYy+pRGUgkeK
 tadp1PY3qvqvm5wCanPCo3MbC8pZTAeYevYK0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776278209; x=1776883009;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RP1Fw95pNnQdx/Xy/sJ+OGaBiaj5ZhYIWtzbF+0J4Oc=;
 b=lnmQBk60JBIwmS939PFGhjAEuYJzcNTyrCe1pU8B7PSM2LVl0VMuQlFvyQKx6Bpbzk
 KWTpnjdboiCJeKbA22PsaPH23xb/VemN5Vo7UfbrQJAHdMqc34KDIPEOFvZ3WbwrVVoM
 1J2aqkHleBK7wuOie34EGarJ/QAvANTR/Weq7Z1HiP1e4Sb9IIhsT39ZAuoOhgYqGUs5
 civ/J5rGgA7p0rnWzJPeAyyGZSUKeSwhcDx6gPO+FFJ0ZLjumY6SKMbYjc3jWipTt0jm
 7YSt5XxAJXRe1Fe5QV0UqcVs2AJYQ/oSISgUQCAXlAyOv3a8YLnw/fFYQVulcZyopm1N
 HKEg==
X-Gm-Message-State: AOJu0Yz/dletfi13sXMbPxadbiNY7KzfTLGXkw4R3cn6BPNDM4DP+pQJ
 LtVk7GPA57o9J3r4xguUp/T1sCrnic3dD+XsBLz3y/rVdQn9LkY21ooU62nV8gyRKjY/yGhQT4c
 eecnP
X-Gm-Gg: AeBDieub30oR0J5yH68lll8GVRowX4EZDOpriYEQo+ZWTglPdpRXZru/7JUQIH2VZsm
 cqn+I6oP6YZ1clikdex2+3TyLLqhAfRJuxII/P7p/y/8xPPyJ6NfZOWLg30mnMMPIq++fPJEQ/V
 NbqYxXtNZhtl5oLiB6/FEhif5Hs1tMVjBKQwDldmYkUapCDCW7Z+8iJPNhpI3aWQIC4A2M0bALa
 c8QKYNlzo3+wlY3SrbGK1wyh0E9rsAHeaWYB9xgvWn4KLloqVW06F/VnE/LADib2RC9Hp37qUaF
 Nj42CTbERTlI+4ysCuX53INbnknHpsnVr2SFIhR9X7uo87ajqp4uyDQZq4pPWr8dKlCUeMgYe+O
 U8PO6ZqSiVStdMTj9N51AU/ZtmRiulo7yxHicIIqhI1AsEmG2+7YAwZQfiWC3WEElvtnAcCKrka
 tH7lnNAm+pRb97X30ZyOW5oa0t6RbA/toFh8sEX7i+vz0Blt8tOYULbiHclYAe4rDMmSwT1W/q6
 UJmfucp4ZeGUdXi+1XYdBGFBUvBcl3WiDyDtSr72WBADtvqxNel4+ReCw==
X-Received: by 2002:a05:600c:8207:b0:488:7a24:9ddf with SMTP id
 5b1f17b1804b1-488d688dd31mr309000835e9.28.1776278208701; 
 Wed, 15 Apr 2026 11:36:48 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.amarulasolutions.com ([2.196.40.93])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f1deec6bsm70471315e9.8.2026.04.15.11.36.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 11:36:48 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Alexander Graf <agraf@csgraf.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Ion Agorria <ion@agorria.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Simon Glass <simon.glass@canonical.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [RESEND PATCH] video: Kconfig: fix indentation of help text
Date: Wed, 15 Apr 2026 20:36:35 +0200
Message-ID: <20260415183643.3031984-1-dario.binacchi@amarulasolutions.com>
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

Fix the indentation of the help text for VIDEO_LCD_NOVATEK_NT35510 and
VIDEO_LCD_ORISETECH_OTM8009A to align with the standard Kconfig format.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

 drivers/video/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 08c9b0207884..8ce660804072 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -566,15 +566,15 @@ config VIDEO_LCD_NOVATEK_NT35510
 	bool "Novatek NT35510 DSI LCD panel support"
 	select VIDEO_MIPI_DSI
 	help
-	Say Y here if you want to enable support for Novatek nt35510
-	dsi panel.
+	  Say Y here if you want to enable support for Novatek nt35510
+	  dsi panel.
 
 config VIDEO_LCD_ORISETECH_OTM8009A
 	bool "OTM8009A DSI LCD panel support"
 	select VIDEO_MIPI_DSI
 	help
-	Say Y here if you want to enable support for Orise Technology
-	otm8009a 480x800 dsi 2dl panel.
+	  Say Y here if you want to enable support for Orise Technology
+	  otm8009a 480x800 dsi 2dl panel.
 
 config VIDEO_LCD_LG_LD070WX3
 	bool "LD070WX3 DSI LCD panel support"
-- 
2.43.0

base-commit: 70fd0c3bb7c26d42f24d10145dd5f3168ac92eac
branch: video-kconfig-help-text
