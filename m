Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23D7EC52D72
	for <u-boot@archiver.kernel.org>; Mon,  5 Aug 2024 21:25:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D69B188908;
	Mon,  5 Aug 2024 23:25:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SU4MJASl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D8B28885D; Mon,  5 Aug 2024 23:25:24 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3A6B884CA
 for <u-boot@lists.denx.de>; Mon,  5 Aug 2024 23:25:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bisson.gary@gmail.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4280bbdad3dso74521415e9.0
 for <u-boot@lists.denx.de>; Mon, 05 Aug 2024 14:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722893121; x=1723497921; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yCbqfSknH5/E3RVXjATWs/UQSguPN/52ESJ9Pfb6yCc=;
 b=SU4MJASlt7osnv4gReb0Ur2po7ML9GRYpvAMsmqs0pjwCPbYQqqCcnre7PBI35LH0q
 goJ3TAy2B79xg5JqhKKe9FQYQy55aTFWrkq0Fcd93gkANWgwkNBeXRR9kq1YiecQvVNz
 b+mvU+Y6HgyxtT6tXV/KlbVn4VZoNeVxj9xzC1/t2oH0DwwWuDg5kCMuwQsBSXiaBA9R
 6bnxa9OQ9uCGjBl2fNaEyrbs70T6AAgTOGNjuYJL7npXXm3EZsk4wsyaAVARdsVWzT5C
 gSU2Ja8wny/GSAmLk+h7k5+7Eq49lHxUq9i1hF/2bpv/N7vs9ZGbtMc/dNmdDjbb+Uu6
 Kt9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722893121; x=1723497921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yCbqfSknH5/E3RVXjATWs/UQSguPN/52ESJ9Pfb6yCc=;
 b=J76ear7fWDmMsVD88nSItSNwlTW7BoOa3y+L3m6t7xKwfKgUWIeJZydAGzwkbmyhhE
 GPVn0YzimexB621mVzhVuA/adZw+1GKhn1yN0XeWWnENFDqdDyHxYtwPo1q/cEOzMIRH
 ZEoIXPTHDohizK/HFCHuLwP6L/K7PzzQJZZZ5zRJNHEP+7MaNPsI9nSwqyMJnSBmtien
 e5GnBXWrCgfZzX4q6VBAHda/54ciyIyxbcDWMkIb/0K6T+IgOqppdIiqY/c/7ddEw+nO
 8UhPvC2TFE1fjTLmbEnJvD4DefZnNOc3HFdryFe2thFUnKPgyy41Ur/80hb6U+cFoVNy
 /GHg==
X-Gm-Message-State: AOJu0YxPsW2yxNdipkGC1yKVzj6EkSJH0c+hO1WF8k96N/8qgeycCbHg
 GqMuZLO14TnbaM00zw8qIVYCnt2cMGdu1LVeSAbPyhi7zSCKPEJZq49kwg==
X-Google-Smtp-Source: AGHT+IHu3JmkXHefJCETBn3PpbJ/e6XVVwI1i/kmoXVmk9D9oaYKaQ3cNJDA6uPjddSD/zyXUF+euw==
X-Received: by 2002:a5d:490c:0:b0:368:6596:c60c with SMTP id
 ffacd0b85a97d-36bbc0fc73cmr6458621f8f.30.1722893121317; 
 Mon, 05 Aug 2024 14:25:21 -0700 (PDT)
Received: from p1g2.lan ([2001:861:3201:3d10:ab7b:e9dd:27f4:647d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbcf0c33bsm11018351f8f.22.2024.08.05.14.25.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Aug 2024 14:25:20 -0700 (PDT)
From: Gary Bisson <bisson.gary@gmail.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, festevam@gmail.com, peng.fan@nxp.com,
 uboot-imx@nxp.com, Gary Bisson <bisson.gary@gmail.com>
Subject: [PATCH v2 3/5] spl: binman: Disable u_boot_any symbols for i.MX 8ULP
 boards
Date: Mon,  5 Aug 2024 23:25:09 +0200
Message-ID: <20240805212511.653667-4-bisson.gary@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240805212511.653667-1-bisson.gary@gmail.com>
References: <20240805124326.544310-1-bisson.gary@gmail.com>
 <20240805212511.653667-1-bisson.gary@gmail.com>
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

This is extending commit da96f93cda9 ("spl: binman: Disable u_boot_any
symbols for i.MX93 boards") to i.MX 8ULP boards.

Signed-off-by: Gary Bisson <bisson.gary@gmail.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 common/spl/Kconfig     | 2 +-
 common/spl/Kconfig.tpl | 2 +-
 common/spl/Kconfig.vpl | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 6f56ca911c1..c08ff064493 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -206,7 +206,7 @@ config SPL_BINMAN_SYMBOLS
 config SPL_BINMAN_UBOOT_SYMBOLS
 	bool "Declare binman symbols for U-Boot phases in SPL"
 	depends on SPL_BINMAN_SYMBOLS
-	default n if ARCH_IMX8M || ARCH_IMX9
+	default n if ARCH_IMX8M || ARCH_IMX8ULP || ARCH_IMX9
 	default y
 	help
 	  This enables use of symbols in SPL which refer to U-Boot phases,
diff --git a/common/spl/Kconfig.tpl b/common/spl/Kconfig.tpl
index 4ee3b9b826d..92d4d43ec87 100644
--- a/common/spl/Kconfig.tpl
+++ b/common/spl/Kconfig.tpl
@@ -23,7 +23,7 @@ config TPL_BINMAN_SYMBOLS
 config TPL_BINMAN_UBOOT_SYMBOLS
 	bool "Declare binman symbols for U-Boot phases in TPL"
 	depends on TPL_BINMAN_SYMBOLS
-	default n if ARCH_IMX8M || ARCH_IMX9
+	default n if ARCH_IMX8M || ARCH_IMX8ULP || ARCH_IMX9
 	default y
 	help
 	  This enables use of symbols in TPL which refer to U-Boot phases,
diff --git a/common/spl/Kconfig.vpl b/common/spl/Kconfig.vpl
index f1993026bba..d06f36d4ee4 100644
--- a/common/spl/Kconfig.vpl
+++ b/common/spl/Kconfig.vpl
@@ -243,7 +243,7 @@ config VPL_BINMAN_SYMBOLS
 config VPL_BINMAN_UBOOT_SYMBOLS
 	bool "Declare binman symbols for U-Boot phases in VPL"
 	depends on VPL_BINMAN_SYMBOLS
-	default n if ARCH_IMX8M || ARCH_IMX9
+	default n if ARCH_IMX8M || ARCH_IMX8ULP || ARCH_IMX9
 	default y
 	help
 	  This enables use of symbols in VPL which refer to U-Boot phases,
-- 
2.43.0

