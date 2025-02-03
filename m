Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A77D4C02192
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 17:44:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB6CA801BE;
	Mon,  3 Feb 2025 18:43:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="btlkGWAp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B1F680763; Mon,  3 Feb 2025 18:43:35 +0100 (CET)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4AD9807B9
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 18:43:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3f314ff6ffdso2672321b6e.0
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 09:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738604610; x=1739209410; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=duGxgP9z1X/SYMoh2RGLqHzI8N6B1zypyevJlQeYpVQ=;
 b=btlkGWApHb5Slkd0B2AuvZIUv4UesRA7s+DmfYtk7xD7wEjWF7QnyWqpCw4SyM+PYr
 LfZGlWyOGC0JPBXacRbtkRsI4VPr4zIVqJcCv0cl3qhPSuRp005+UHLeiPhpNeP8VHgf
 MqiAZLKtkbVP31dd1AT/pmdTw8cfx4LGpsz/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738604610; x=1739209410;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=duGxgP9z1X/SYMoh2RGLqHzI8N6B1zypyevJlQeYpVQ=;
 b=LnR/F/Htmtg9FQWNINPlYyrV5RYdeOKD+WoqoXT5LKow+LfySjt5aUUBT/hqyPUTJi
 Y/41q1e0e1YBq663dpNVtvjKzSYGqlzIV4ZlZOKyvDzy8SQe+gJJzbDjyj2BNMdeHUHO
 IxvVOG2GurFerGJmQNh0uqeWlzKkVrSc6d1vs7luP3PFYuwHeAUmyEovyABuCypOHGht
 w3FF3eAtFChwP5sT9iyJo8O2e6JvYWLBtmRhBjsIP8+061coW1vNskTPZymfqOf4O5px
 KS5vtReoXaN92dVn4ztmlpffqTVIS/H6P52lN2ccupWvVdMSAvW6ge7t2ORq77ANMZbQ
 rb6g==
X-Gm-Message-State: AOJu0Yz8QmtnyP9lgbXd14PM5oTCYW5zr2VeaMWJ+htFtlCCanBOXeCN
 5K1yBPjwEl/Dny13A/Ut/Gf6vVIu6ezopzfRAT97XUDwyBhgAMEWDKAuR13srXouvLMZQBAAuDw
 =
X-Gm-Gg: ASbGncv/oY3Kz7ZywEl3+lSqvfjazj8ZYQMvNKxY4sQOeZaDPvN0CXjg9zqku0DzRyg
 rY4+dNHeoe1Qzjed0hu94KCFSvibHK1PjzIiHFDsWkmtuhn7/ACaH9hYZEXJkUufq0Ztiwk8uB2
 UVBWQw+LolmGUbpsdduChNQSfmuPXpAqSGX5YMwvTHWX5vF6p3AwZSv2pixKhDHI58kjLY3BZiX
 EyWz0yRJ6g+v5aKHFPBDOcMF+j9v18b3mJJixYuZuPSyDnZfnF10w5OBIivDYkPoUx+Greo14gJ
 Sy4UVEm6rg6mjtpWKhbsyu+ZnEuIIk3g5XVa0Ok/DiquQYjwhWDM
X-Google-Smtp-Source: AGHT+IHjupAgS+RXzjTWZ+WMsv+FWf6XUAWvWlIFXRPKTVXxUkqCX8j8iOQxJSfqmI4N8DWvSEHQsg==
X-Received: by 2002:a05:6808:2f09:b0:3eb:7675:3495 with SMTP id
 5614622812f47-3f3239fb695mr17106949b6e.1.1738604610572; 
 Mon, 03 Feb 2025 09:43:30 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3f333558c89sm2564203b6e.24.2025.02.03.09.43.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 09:43:28 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 09/32] efi: Allow board/efi Kconfig to be used outside x86
Date: Mon,  3 Feb 2025 10:42:02 -0700
Message-ID: <20250203174245.1331464-10-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250203174245.1331464-1-sjg@chromium.org>
References: <20250203174245.1331464-1-sjg@chromium.org>
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

So far only x86 supports the EFI app. Sadly ARM is going the same way,
so allow these options to be enabled for ARM too.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/Kconfig      | 2 ++
 arch/x86/Kconfig  | 1 -
 board/efi/Kconfig | 4 ++--
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 6258788f53f..493c827d74d 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -544,6 +544,8 @@ source "arch/Kconfig.nxp"
 
 endif
 
+source "board/efi/Kconfig"
+
 source "board/keymile/Kconfig"
 
 choice
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 23a1e21b29e..80396a3a2d5 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -100,7 +100,6 @@ source "board/advantech/Kconfig"
 source "board/congatec/Kconfig"
 source "board/coreboot/Kconfig"
 source "board/dfi/Kconfig"
-source "board/efi/Kconfig"
 source "board/emulation/Kconfig"
 source "board/google/Kconfig"
 source "board/intel/Kconfig"
diff --git a/board/efi/Kconfig b/board/efi/Kconfig
index 9027ca8482c..7545f808585 100644
--- a/board/efi/Kconfig
+++ b/board/efi/Kconfig
@@ -1,5 +1,7 @@
 if VENDOR_EFI
 
+if X86
+
 choice
 	prompt "Mainboard model"
 	optional
@@ -33,8 +35,6 @@ config TARGET_EFI_X86_PAYLOAD
 
 endchoice
 
-if X86
-
 source "board/efi/efi-x86_app/Kconfig"
 source "board/efi/efi-x86_payload/Kconfig"
 
-- 
2.43.0

