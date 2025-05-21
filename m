Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E94F1C54E90
	for <u-boot@archiver.kernel.org>; Wed, 21 May 2025 23:03:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69DF88303E;
	Thu, 22 May 2025 01:01:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EUa6QItJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8729D82FBC; Thu, 22 May 2025 01:01:44 +0200 (CEST)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2168E82E31
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 01:01:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-6063462098eso4493248eaf.0
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 16:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747868500; x=1748473300; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2Nq5UWgHlQ35cA/C6bMTvvGao1hyUDyvd8vxCFcmL9g=;
 b=EUa6QItJSoRu2aDMSwya3CfkGUHbyX7gtawJ2L5M8/V6hT0MoFuTlkm78GUAzs3+WC
 rQFfXS4uG0hcTLW3OLbOwJ0aAk5PHGS5AWiL5LXkh3LNgSef4qbYknVTDWLcV6u8C12g
 6t6jVQLFooMIUeWeBeQgKchDqTnhIiMMWoUpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747868500; x=1748473300;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2Nq5UWgHlQ35cA/C6bMTvvGao1hyUDyvd8vxCFcmL9g=;
 b=XVFT/Xps5VpvVqMh9ZqZBSvRzGeimVZu4U1bDj2mBKfkZN6Nt8U+cRzBbo9/Y2Um5Q
 UfQIx2d05XDk7V1Mtr6zEgCrYT3Kt73YOLCEXruZBqfj6wmahW6MsE/QZ6m50eCXxSwj
 EUmmZEeo2jbRkrtTZI2EQClhP9cIzvgeyJGiEV80SvhsDQumW37jVEdekjMH2hY9Oo1g
 Bjul0PE4MDZbGEf5jtKFV54KZtbFmG51QECSTgMXkehWPbKLs6/GDrTc0xZrv+oWejlB
 57wb9Ud6a/FebQl7tBYXU8Q53JgCeexng7gwoYSfLCo6rCwCwqHzmHRI3WADeTO/SuG3
 qqSA==
X-Gm-Message-State: AOJu0YwHTE4PQ3mq51J8fUFGfwCulF4TJjhU9z/e28XbxNuBtPXLymx6
 QC6oZus7vMzrYyyBhHmRVCQ1PExbek6VsmNOC/pZlG9L9DHglm7sBP5PMhXDjVyhBy3SSAz9E8G
 xsLJ1efM=
X-Gm-Gg: ASbGnctugPIuIuPw0Nj05kpwMS+THR03rrvr5NLCE9SJOBdYGjDk8M4j+TsoAf7jWul
 q/obhk1J413l58xl0k7nZwtB6oNI3+EtB6hBh7nexrl1PzMTPZVXs8kwKh298iVsnd31MehtjCm
 qTZHmZbHnDUnYXpofD0VlaNyFS3DMS3V9pVW9z4lRQ3uFzIhWTl5UDorPjoNswJ9i6zH+dnZisn
 u9Cv9/UHhxLoYMYfXOJHYUV45DjTVVk/HlQZ5E11awyoefgm9mrBRTSqOrXz7ansOu671mhQ2UW
 Svi/bHYHz4kzMwelGKU0viuQIA3SRq8AooJmLqOF/u/AmJB7nmNDdqO1naIzHmVJ+ECHnWyLnbe
 S+jgxJSkQM87i6M9fPxMVkUnLpQ==
X-Google-Smtp-Source: AGHT+IGLBv5T39diutyy2N62ayL06wj6587YCA99/gOrmaHesuCSMYM0JyfBqWl2rKSovnsyyiUBBA==
X-Received: by 2002:a05:6820:1e17:b0:60a:7f9:c897 with SMTP id
 006d021491bc7-60a07f9ca67mr10522470eaf.7.1747868499888; 
 Wed, 21 May 2025 16:01:39 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-60b7e43d07bsm473895eaf.26.2025.05.21.16.01.38
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 16:01:39 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 11/17] include/dwmmc.h: Audit include list
Date: Wed, 21 May 2025 16:51:16 -0600
Message-ID: <20250521230119.2084088-12-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250521230119.2084088-1-trini@konsulko.com>
References: <20250521230119.2084088-1-trini@konsulko.com>
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

This file does not need <asm/cache.h> so remove it.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 include/dwmmc.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/dwmmc.h b/include/dwmmc.h
index 6edb9e1a59c5..87ca127cd6cd 100644
--- a/include/dwmmc.h
+++ b/include/dwmmc.h
@@ -7,7 +7,6 @@
 #ifndef __DWMMC_HW_H
 #define __DWMMC_HW_H
 
-#include <asm/cache.h>
 #include <asm/io.h>
 #include <mmc.h>
 #include <linux/bitops.h>
-- 
2.43.0

