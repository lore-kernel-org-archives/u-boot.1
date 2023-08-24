Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 024C3C27C40
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 20:03:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 231FE86A76;
	Thu, 24 Aug 2023 21:59:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OJfngguB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B80286AA9; Thu, 24 Aug 2023 21:59:49 +0200 (CEST)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D7FC86900
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 21:59:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-792399277bcso7903739f.3
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 12:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692907185; x=1693511985;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jYnx+dXPZppZwM8+1cNnewMY4vdHXf92uyZ3vky8PuE=;
 b=OJfngguBUcU3e3IusZ2ZspFoaJsIE1YbYXwTT233W6GPYwy70ZNXNY1jhZs4HDMsk0
 m57EjW2A1TF0gUcKMP8bCaoLxcwNBvOWk8mD5D8J7bkbpUOLjxvNTmRFQWrtt95jN7kA
 iyYEQW0yrny/0F+6ttO9m17lxxv5R/pQQ628U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692907185; x=1693511985;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jYnx+dXPZppZwM8+1cNnewMY4vdHXf92uyZ3vky8PuE=;
 b=cfGKJyLfTVpx2vkmWgSKRnvzwrgsZkOgUXKEww4tdsxU7ZCyD7BbX8vRpOotmQuPku
 bIY2SWPrA4tLSQr0+5/ejeZ63aZVrBjVki8JxmDIAKnhaciNnKzhQ82LIRKtUCE4+fzl
 8w5uGgy60q6Keo4z0KR3jlzWJeBJPYIak7Iti4jokIeIgs9d4RUKAsEEbjEDgZ2N6Kd2
 MBlSXeSyxlV0EftTocMxMJr/g4dQhGjf63HNCyUJAZjLl1SIIo+SYRrfa6mP1Pi2Y8Cc
 zawqzS+a35KOaeMsGvNnxFwe1hBWdvaWOqO5mElF3m6vlUUnHolqg3hPitVPMCNIMal8
 07ow==
X-Gm-Message-State: AOJu0YwlLUhUUmflOIqZsmmwYMMZ0iUbsqZSem5f/G4EqsyRnAPGUd7m
 5HGahkycOTo0IcinMsWzEgANGZwAINIOW9+MHP4=
X-Google-Smtp-Source: AGHT+IF/PuFsrukDH8SJzWk0oWwS3Ek4++V2dZeIz8NHWF4hLZUaT4zCPC7wmNVAPjjlLp6SzGzILQ==
X-Received: by 2002:a5d:9d43:0:b0:790:c259:4ee5 with SMTP id
 k3-20020a5d9d43000000b00790c2594ee5mr7154213iok.8.1692907185040; 
 Thu, 24 Aug 2023 12:59:45 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 c11-20020a5e8f0b000000b00786fe5039b8sm9744iok.46.2023.08.24.12.59.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 12:59:44 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Brandon Maier <brandon.maier@collins.com>,
 Kautuk Consul <kconsul@ventanamicro.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Subject: [PATCH 18/19] boot: Join FDT_FIXUP_PARTITIONS with related options
Date: Thu, 24 Aug 2023 13:59:09 -0600
Message-ID: <20230824195917.1687886-19-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230824195917.1687886-1-sjg@chromium.org>
References: <20230824195917.1687886-1-sjg@chromium.org>
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

Move this to be with the other devicetree-fixup options.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/Kconfig | 8 ++++++++
 lib/Kconfig  | 9 ---------
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 4742ee2027bd..32d3a7306139 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -1473,6 +1473,14 @@ config OF_STDOUT_VIA_ALIAS
 	  incorrect when used with device tree as this option does not
 	  exist / should not be used.
 
+config FDT_FIXUP_PARTITIONS
+	bool "overwrite MTD partitions in DTS through defined in 'mtdparts'"
+	depends on CMD_MTDPARTS
+	help
+	  Allow overwriting defined partitions in the device tree blob
+	  using partition info defined in the 'mtdparts' environment
+	  variable.
+
 config FDT_SIMPLEFB
 	bool "FDT tools for simplefb support"
 	help
diff --git a/lib/Kconfig b/lib/Kconfig
index bfab2f3165a7..eb2b10161824 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -953,15 +953,6 @@ config VPL_OF_LIBFDT_ASSUME_MASK
 	  0xff means all assumptions are made and any invalid data may cause
 	  unsafe execution. See FDT_ASSUME_PERFECT, etc. in libfdt_internal.h
 
-config FDT_FIXUP_PARTITIONS
-	bool "overwrite MTD partitions in DTS through defined in 'mtdparts'"
-	depends on OF_LIBFDT
-	depends on CMD_MTDPARTS
-	help
-	  Allow overwriting defined partitions in the device tree blob
-	  using partition info defined in the 'mtdparts' environment
-	  variable.
-
 menu "System tables"
 	depends on (!EFI && !SYS_COREBOOT) || (ARM && EFI_LOADER)
 
-- 
2.42.0.rc1.204.g551eb34607-goog

