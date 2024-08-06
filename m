Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB2A3C49EA1
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 04:39:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40563889D5;
	Tue,  6 Aug 2024 06:39:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QZw6jFFH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA5A8889BB; Tue,  6 Aug 2024 06:39:14 +0200 (CEST)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B51FD889BE
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 06:39:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1fc56fd4de1so3175895ad.0
 for <u-boot@lists.denx.de>; Mon, 05 Aug 2024 21:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722919149; x=1723523949; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2Ic1wNzajHlb6CXgByYsvFXAVospEWVfRvCEd078WWE=;
 b=QZw6jFFHHnnbndowYYbmfR7lx1cLqAZ4cmkAVcK6+O8zWS6bPHlyEjWclf7tYQ6s57
 3493As78zPB6KayQ0Trj62FGY/d+nka45uP81bktTkC3GTsHyqePynXdhlels7TllqN6
 w5rLPXhGqdEWIOV2nDgOkjsbcql6R5ZzWgKo+SO+3SlfWcgWuQmYzW6DvpTNBVUbY1W7
 xMtplBpugd7h3bRH1HFoT8xSd2l4rPxquisHmuzU81LA2T4YszCpoVzuaP+wN87dFYh9
 GL/vYmwIzod6apVynYQ0ikXWbGztTi3yrEbYNpHG7SekFf6rd9plQPUmnxKvIY30Ftp7
 EJaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722919149; x=1723523949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2Ic1wNzajHlb6CXgByYsvFXAVospEWVfRvCEd078WWE=;
 b=tj7uo1yAcJKVLiMJEcUfmoB6dMojEZIJSKxtohJF8/KpWV1aRbLkdjpgrEbrFVNVX+
 PDM86qFbOY0cfXDHtOUOju3Z9/Kvtmfgr6B0E6g0cZ7Z0R71vSpbIaO73u0S/FsmMJvN
 tp5JnY46nlYH/Fs5Jv783pe3/aTWlsLYIG/TlWT6CC6N60QgxcN96PZZEQDr2ahbt99X
 34iK65XHUl9ljnA0Gfur8wHlpHPjcGgw+ZcYuJmk/uY+vhVqExLsEQf094labdB1dCqu
 WHD9iTxgwOvFq0rAnXGeYwrK/5sXjJWWNinCWwCUQ1e9yfqZlgFM3YPlumtFcB+JPOse
 JulQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKFRgP8ePFfifT5OjJDrta5YTySPQukhfUn7dJRbNZ/uvVjklK7utO1L+zCWpLdpq7nPNaqXQeDLrXDz9CfvVNZiP/ZA==
X-Gm-Message-State: AOJu0YydxcWii3h3PjwtgwqilQ2RAAIEy4Q4nXUZjVtjRM0VaNkHjqu+
 Y7Eh2L4MTKMi/7ZywnL0DEM2j9EpHv8bkSjhkE+OleBlt2AdLeokkjJSKg==
X-Google-Smtp-Source: AGHT+IFiXfnmesckqq8T/+uYxglQTY1PQyEYC0xbXjnF3u00QgvxNCUTwfUiaqgy6WPq33A7de2kGw==
X-Received: by 2002:a17:902:f650:b0:1fb:d07c:64cd with SMTP id
 d9443c01a7336-1ff52492003mr240811565ad.21.1722919148895; 
 Mon, 05 Aug 2024 21:39:08 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20077164e0esm5823485ad.185.2024.08.05.21.39.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Aug 2024 21:39:08 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v1 02/12] arch: rockchip: rv1126: Update syscon driver binding
 method
Date: Tue,  6 Aug 2024 04:38:39 +0000
Message-ID: <20240806043849.3607-3-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240806043849.3607-1-linux.amoon@gmail.com>
References: <20240806043849.3607-1-linux.amoon@gmail.com>
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

Updated the binding method to use `dm_scan_fdt_dev` when
`OF_REAL` is enabled.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm/mach-rockchip/rv1126/syscon_rv1126.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-rockchip/rv1126/syscon_rv1126.c b/arch/arm/mach-rockchip/rv1126/syscon_rv1126.c
index 67d2f18a8d0..d66d84c836d 100644
--- a/arch/arm/mach-rockchip/rv1126/syscon_rv1126.c
+++ b/arch/arm/mach-rockchip/rv1126/syscon_rv1126.c
@@ -18,6 +18,9 @@ static const struct udevice_id rv1126_syscon_ids[] = {
 U_BOOT_DRIVER(syscon_rv1126) = {
 	.name = "rv1126_syscon",
 	.id = UCLASS_SYSCON,
+#if CONFIG_IS_ENABLED(OF_REAL)
+	.bind = dm_scan_fdt_dev,
+#endif
 	.of_match = rv1126_syscon_ids,
 };
 
-- 
2.46.0

