Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 995D0EC8738
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 16:05:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD9FE86ABF;
	Thu,  7 Sep 2023 18:00:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RZSEXpn9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CCED86AA3; Thu,  7 Sep 2023 18:00:02 +0200 (CEST)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4357986B1D
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 17:59:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-34baf19955cso4890945ab.2
 for <u-boot@lists.denx.de>; Thu, 07 Sep 2023 08:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694102396; x=1694707196; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=efssHrt3m6jQQAZkgpRd95UvGnOQq4CVd6+bPCUYoog=;
 b=RZSEXpn9OWb1yuwQIYku58bFj44HMBMw0lRg2uaYqX14j5e6pz0DRbuWqR1CbtXl8x
 reLk/THKqvki7ZModQtGVH0/2NBiLdsXJj8oGEXGBKfbVVuD2uWOh8t4IsjCS/iYot2O
 fugQFNwVemElHJeyDGCZzeJICpiCCkoE1yOQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694102396; x=1694707196;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=efssHrt3m6jQQAZkgpRd95UvGnOQq4CVd6+bPCUYoog=;
 b=KhiVbSRahw9R3GEWSa+jkTqqcnHPPMQGupx+T0Yd1qncD1COazHDUjTjrwD4oBtmq+
 /W6HuYdoXSRV9ueDWbzBLO7f1IeU74HZIGLA+NeJCZtp+jzLcFkT7vLIPCvtnPKutnVg
 TmZy6w3qdx0FrvHrnRM6snIlwlcCyHDO/2SR/VZxTovXNW1j9sg2XO/IyYRbozKx4QS7
 r3JC+5PTHzC2W7y/9GZlk6jEv9i070v0ixUdP+u97Gj60yWbnRclbn9BQyTGGnuJycM/
 jK9Si4fQcgYDM/FBASF5uuIQaEZFHbO7WoR7p3fBhiJv/2gVO8hZauu2gOj03zb6Jom7
 XJwg==
X-Gm-Message-State: AOJu0YyyvdFXNXG3XeTPx+WLnhiLzntnq6rTH9solX6WgXK1UXeLeGhr
 1NNKtT3SCjKQWUdrhcqlCAn0XKs0V/Pmi+a/sho=
X-Google-Smtp-Source: AGHT+IEBsybBrzQYDJaGVXs8V7AIX+nVNUE/KNG4xynr3a/YgrGqtnkBwCzBlds/8KzZVJcnL9oAuw==
X-Received: by 2002:a05:6e02:1151:b0:34d:ec00:2ce8 with SMTP id
 o17-20020a056e02115100b0034dec002ce8mr79901ill.21.1694102395906; 
 Thu, 07 Sep 2023 08:59:55 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 o18-20020a92d4d2000000b0034989674ad7sm5637727ilm.52.2023.09.07.08.59.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 08:59:55 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 20/22] boot: Join FDT_FIXUP_PARTITIONS with related options
Date: Thu,  7 Sep 2023 09:59:25 -0600
Message-ID: <20230907155933.48511-21-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230907155933.48511-1-sjg@chromium.org>
References: <20230907155933.48511-1-sjg@chromium.org>
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

(no changes since v1)

 boot/Kconfig | 8 ++++++++
 lib/Kconfig  | 9 ---------
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 2dd05e2e1661..a1592a74e624 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -1475,6 +1475,14 @@ config OF_STDOUT_VIA_ALIAS
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
2.42.0.283.g2d96d420d3-goog

