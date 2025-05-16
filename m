Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ADB5C3ABC9
	for <u-boot@archiver.kernel.org>; Fri, 16 May 2025 08:18:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01B3D82A59;
	Fri, 16 May 2025 10:17:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MMATCv51";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3173782A8B; Fri, 16 May 2025 10:17:53 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19EE682A59
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 10:17:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-442ccf0e1b3so20974345e9.3
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 01:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747383470; x=1747988270; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K0OFb+UjBro3Fvf74pRx1A80fnQi2BBxr1uH9mqaoPM=;
 b=MMATCv51F7P9gA9hedsc7gkroGK+7RJA+64UvzqPsCyI9MRKuamxd2SXtI6ApjDc6Z
 HYrtl5Qu0ge8FyrPL79TOtU0/7e1DzpAh7ZTfiYwMj52eTzRE9Xemfr+d14W5qPmYNbW
 /ZgyXs8B/PRe6TG9iOZHhj6mpfJMxOLxJq5r1wYibR0d257FxZAcBuc8gYaTaNOp+wMY
 5vdN5MDQ4utYAeLAlQqIZWB2KwRKaFcsnKtL1EMOpNHWEKrOMEys31an813C2M3eq1sp
 rAvuhwFCW16kfRXYMfn12JD6tgV3msKm393Vclb1JArhQrGIf7PAM4B8iZsdlx3XzgFD
 oO8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747383470; x=1747988270;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K0OFb+UjBro3Fvf74pRx1A80fnQi2BBxr1uH9mqaoPM=;
 b=I0qrtPMB/w9BDVaO0rx6fwMtvphfBJtSI1r2YummcirRLwqjqV4MD07lrKfJfc+uB0
 nvx8G3VeybEutS/JllMUSAQocdYzVjdUlXNutc77li4/QiUuiXoXG/KWPnRIst/RV+9C
 Wf9G62Q4WCfWuBEqphWFkzUzQv/FP8V02Z2WrWhZ4sG+gcP7Xsr5cXKA+p4YXAKC6r5f
 4D0HGIx911qs7dJyXRc/8kEiaXwvSSuKR/TRGCB56KK+BImRCFwa1Mzukkbvij+6DNvU
 VqPc5yw8BpMK+mt6gMkTIb3Hk80NA3DBE9al1QIhq8Bp0cAaPjzrNrM/AUjNCjA1JCDn
 XWPA==
X-Gm-Message-State: AOJu0YxlYY8xiq/sD+aL3zeQBK8wdoa+He3Z1azynE0zKSXT+8FOuH29
 6aEz4rvJyLol4yidahRuPjY1c/wWHTLZD121KMSOgVWkoxuy3T9FcPk2VVSxypJjRuQ=
X-Gm-Gg: ASbGncuH/Yv+sx/xFs6/1oXNYcR+BWlnYQB8jhsWrd8ncz4nyFtXRVgLibn4gKDP8Gd
 9hBLG+XVdWKc6aa8k8xiqz3JjRi8b35GkI9DorlIR4qBiZaC+MZm4nMkEVSjU10IIbVxNzMn69d
 941JK1spIkrE8DX6ThKFQ5dpdQbOAN3brA6sBMFMdXpmfkq/tVlcrkC3QQsAwXafihkb1ZVHsfk
 q5UBRT6x3Fx+nKKGFGIcmWSYVxVWWEKihJ1hRE8HlEsTc4cQYPgGDR5/saY6b/VuiKfuJovlNMf
 zhixlzWHiLJov2a+Y8+4hE1FKy1eOqyKbRe16XA1eCmSnYamgvbNix39kVavcA==
X-Google-Smtp-Source: AGHT+IGPhyGwZRWMsJ3ZGUYBt6wzToTgM11DG6QkL7gsWjBmvl1i3PxZrVTTsKzj1XUcRh8C7UTRIg==
X-Received: by 2002:a05:600c:35c8:b0:43c:ea1a:720c with SMTP id
 5b1f17b1804b1-442fd63c69emr25332255e9.18.1747383470401; 
 Fri, 16 May 2025 01:17:50 -0700 (PDT)
Received: from adriano.. ([213.157.19.150]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca8ce9asm2010159f8f.86.2025.05.16.01.17.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 May 2025 01:17:50 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 trini@konsulko.com, jerome.forissier@linaro.org, rfried.dev@gmail.com,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH 3/9] efi_loader/net: Rename efi_ipconfig.c to efi_ip4_config2.c
Date: Fri, 16 May 2025 04:18:33 -0400
Message-ID: <20250516081839.28587-4-adriano.cordova@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250516081839.28587-1-adriano.cordova@canonical.com>
References: <20250516081839.28587-1-adriano.cordova@canonical.com>
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

Rename to keep it consistent with the actial EFI protocol name

Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
---
 lib/efi_loader/net/Makefile                              | 2 +-
 lib/efi_loader/net/{efi_ipconfig.c => efi_ip4_config2.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename lib/efi_loader/net/{efi_ipconfig.c => efi_ip4_config2.c} (100%)

diff --git a/lib/efi_loader/net/Makefile b/lib/efi_loader/net/Makefile
index ab41f358de9..75131877e30 100644
--- a/lib/efi_loader/net/Makefile
+++ b/lib/efi_loader/net/Makefile
@@ -1,3 +1,3 @@
 obj-y += efi_net.o
-obj-$(CONFIG_EFI_IP4_CONFIG2_PROTOCOL) += efi_ipconfig.o
+obj-$(CONFIG_EFI_IP4_CONFIG2_PROTOCOL) += efi_ip4_config2.o
 obj-$(CONFIG_EFI_HTTP_PROTOCOL) += efi_http.o
\ No newline at end of file
diff --git a/lib/efi_loader/net/efi_ipconfig.c b/lib/efi_loader/net/efi_ip4_config2.c
similarity index 100%
rename from lib/efi_loader/net/efi_ipconfig.c
rename to lib/efi_loader/net/efi_ip4_config2.c
-- 
2.48.1

