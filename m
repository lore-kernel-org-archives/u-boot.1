Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 156ADC4707B
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 18:46:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FC2B87A97;
	Wed, 10 Jan 2024 19:46:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="h+9emaui";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2406F87A61; Wed, 10 Jan 2024 19:46:17 +0100 (CET)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 113B887A97
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 19:46:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-67fe0264dd2so30542566d6.0
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 10:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1704912373; x=1705517173; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=X7QNKr3b0C6FaHmJgOYwUJhSgRqK4ukt+phsIgZ9Ads=;
 b=h+9emauiWe5Iaq9Tvglx6TjnyW80tiRKJnQYwQxAelK2UJJcsHdSlw3ZLg1hTnDWhS
 +UKOXl6A5ZZ7883NLwF3FATzJ6R98BjP2Ifm+hRsWaGhXVWleaCrR/L99ldpcFZbQTtN
 dx06mEmZ97wBuV723PRLRIMn2chYnFuIW+LvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704912373; x=1705517173;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X7QNKr3b0C6FaHmJgOYwUJhSgRqK4ukt+phsIgZ9Ads=;
 b=DwrzjO/O/gasPdH+QZaZheRBqLLH+4VkPHdwL+SYC2JJaCq+RDGb3kxxORo/KiJN9Z
 iag7itkMm1F/mSuvbRtoFlnPqvuE/iSP8Xy1BoseXYNNaVDPqV9Frd58EFTRW/eQ6Chu
 3Nx6PVrqSV3D8QHt7S3tSnHBtQ6Z+AumjMNcYMFfS97V7tt3zEYYjwzVxwpWIh3YpuMp
 dzkgQdnXAEbn1DYtx4sHhVjKkY4Qt93h6GbatJAQ0Kyr1ibd0ZbYD+/bUbqtNk/K/3uA
 V5Hhdg7AJj7KQ8cCl8z0zm/e9SHwznSj2pES+xRREs7mUM2wAcojPOhkqH0Qn2GDieDf
 a96A==
X-Gm-Message-State: AOJu0Yz4mVMwAlidYXM0qFh2T4Oxc/nJLxBSbmBU0WBZY8Lb5Rwdlzoj
 0OBG3RJ8CSVblws6m8tQKyxPV7sAS3amalf7ZemzSmdse+c=
X-Google-Smtp-Source: AGHT+IE33EsFsRwu5rSJVIUvDn4n55HsTNpOuwsrTFrDz6a1zh4EVtak/Cjvp1bPRJUsBiO7GtzT7Q==
X-Received: by 2002:a05:6214:d4d:b0:67f:9e06:e71e with SMTP id
 13-20020a0562140d4d00b0067f9e06e71emr1869636qvr.47.1704912373725; 
 Wed, 10 Jan 2024 10:46:13 -0800 (PST)
Received: from bill-the-cat..
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 v12-20020a0cc60c000000b0067aab230ed9sm1887979qvi.21.2024.01.10.10.46.13
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 10:46:13 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 4/5] cmd/flash: Make this default y for CFI and NOR only
Date: Wed, 10 Jan 2024 13:46:09 -0500
Message-Id: <20240110184610.3909763-4-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110184610.3909763-1-trini@konsulko.com>
References: <20240110184610.3909763-1-trini@konsulko.com>
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

This command is only useful on CFI and NOR type flashes and not others.
Update the dependency so that it's not enabled by default in other
cases. This will lead to a number of platforms no longer building this
command, where it was not useful.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 cmd/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index d837b0990484..944a03336efc 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1080,7 +1080,7 @@ config CMD_FASTBOOT
 config CMD_FLASH
 	bool "flinfo, erase, protect"
 	default y
-	depends on MTD || FLASH_CFI_DRIVER || MTD_NOR_FLASH
+	depends on FLASH_CFI_DRIVER || MTD_NOR_FLASH
 	help
 	  NOR flash support.
 	    flinfo - print FLASH memory information
-- 
2.34.1

