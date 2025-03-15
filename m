Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81828C282EC
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 01:30:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D7A282155;
	Sat, 15 Mar 2025 02:29:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pK8R2AUq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BDA08215B; Sat, 15 Mar 2025 02:29:40 +0100 (CET)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77EB182116
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 02:29:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-7c0a159ded2so335824585a.0
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 18:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742002176; x=1742606976; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=2/M9kUcK6I2xl78zyRMP9rEp/M4WNLI3G7HqcEZBHV0=;
 b=pK8R2AUqF2ozCVzJy/qgTJjaKxAVeSUWTXo2ZZPC+Ds78p/cb+KL8oiKgovX6lHBLe
 i+eduNUitJNllYI2dTpCA3CUORpKfsWVTE5qZty4n4Kz9eNGrTBnhYi1ZMJZ8sShE75i
 OtwIphYFyP+7UC32TsTrpCILcCYq/eEmZbW/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742002176; x=1742606976;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2/M9kUcK6I2xl78zyRMP9rEp/M4WNLI3G7HqcEZBHV0=;
 b=j3rqsHVJPdP5ZvKdtFHPI4R5/sFOfFHb+JkxDICsvJg0mPVP7HcIan2X8dh53cgVXN
 xZ3XetbfdJvx/EoaoCQLyccpV+p0WXxL+JhlxfHhXbkzL6RdF9NuYZSQsTWLtiNZ1dOy
 t9BYtmJ2jzIQH9kTQk+XM2GzflQ1gmbiGlSwoioZQzDb/zSIw1QaLaJWpY7v7VmTmaVC
 eopj48bZ9FG43Ex7LEVaAu65wjpieGhSVnHySsIvZTXLFrtMykUOGpRaHg8rTSXAUeXt
 5ejN7uPbEDwUFvATZqrmvTH2Sm6poE+Gn4fWjO0FUpHl/h7qGKSJVijLoVCwOiPy5VBP
 46ow==
X-Gm-Message-State: AOJu0YyRlz24pxkpn/9pLVeUavSES5YAeUkbg4vxD4rk/HnsLfQvQAoG
 aUhfY4sdRHikkATEFVLuEdBSMv+tFNZiGzRKLyFK4Db2ZGf+fevqCzWDHABXdlubVpFPoXBIiNY
 Z
X-Gm-Gg: ASbGncv1sJsKf46fn6rI6010sl6G5CHa0cfvmv5QrHYwONIMVFwCkeoqwjfVLfeqNO3
 6VnCPxZsuZyQU/tWUuga946YyMfwLTSimWDceFqc8IIVzxXVsHVb0fGXOyAgVLBxN1eBBSqOaSP
 +vOj5Esq8tWu3UeDaeTpQ5h1Ir4WK4qKd9K8go7ushXkesiubD+pcAwK1TIL0jm0o4RbkAi1sd6
 i5H72S0myc73mrTyszJ98Qk5zjwR+etXy9BVfTqYsQo5RZmrIlROLBmDp1IJ12tbsyRgw0WH48C
 35lYxv0Bk1RgKVDay1BFF4CEHrXMsngxeFv1yqpyIjOydFzxpfXxQGNjHzk=
X-Google-Smtp-Source: AGHT+IHPMJRxad7s/nwy68o5s0C/7zk4d/JrtsoDcJod9y2AI/nmIAm6aGbH6A42cHcqL26lx6vVgg==
X-Received: by 2002:a05:620a:2488:b0:7c5:5670:bd75 with SMTP id
 af79cd13be357-7c57c90c63amr648932985a.46.1742002176384; 
 Fri, 14 Mar 2025 18:29:36 -0700 (PDT)
Received: from bill-the-cat.. ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c573c6fafcsm323767285a.25.2025.03.14.18.29.34
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 18:29:35 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] Kconfig: Fix "warning: style: quotes recommended" warnings
Date: Fri, 14 Mar 2025 19:29:33 -0600
Message-ID: <20250315012933.399487-1-trini@konsulko.com>
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

We have three warnings about needing to use quotes around some strings
in Kconfig files today. In two of these cases we can just add the
missing strings. In the case of INTEL_PINCTRL_PADCFG_PADTOL the symbol
is never referenced and should be dropped.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 Kconfig                       | 2 +-
 drivers/pinctrl/intel/Kconfig | 3 ---
 lib/Kconfig                   | 4 +++-
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/Kconfig b/Kconfig
index 70dc385dd2f2..a508c5430f0d 100644
--- a/Kconfig
+++ b/Kconfig
@@ -748,7 +748,7 @@ source "dts/Kconfig"
 
 source "env/Kconfig"
 
-menu Networking
+menu "Networking"
 
 choice
 	prompt "Networking stack"
diff --git a/drivers/pinctrl/intel/Kconfig b/drivers/pinctrl/intel/Kconfig
index 316a8fe27fda..0d8bfc53c114 100644
--- a/drivers/pinctrl/intel/Kconfig
+++ b/drivers/pinctrl/intel/Kconfig
@@ -8,9 +8,6 @@ config INTEL_PINCTRL_DUAL_ROUTE_SUPPORT
 	bool
 	default y
 
-config INTEL_PINCTRL_PADCFG_PADTOL
-	bool n
-
 config INTEL_PINCTRL_IOSTANDBY
 	bool
 	default y
diff --git a/lib/Kconfig b/lib/Kconfig
index a21b3378fa74..179544611148 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -445,7 +445,9 @@ config CIRCBUF
 source "lib/dhry/Kconfig"
 
 menu "Alternative crypto libraries"
-source lib/mbedtls/Kconfig
+
+source "lib/mbedtls/Kconfig"
+
 endmenu
 
 menu "Security support"
-- 
2.43.0

