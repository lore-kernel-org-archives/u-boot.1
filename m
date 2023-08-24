Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 030B6C27C40
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 20:00:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62E51869B7;
	Thu, 24 Aug 2023 21:59:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mnDmcbJz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD17B86A61; Thu, 24 Aug 2023 21:59:31 +0200 (CEST)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFD428694A
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 21:59:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-7923d27b9f3so7299639f.3
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 12:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692907167; x=1693511967;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rnbkiG9agnDcYBbc28YlIujrKZZzuZuOwRBIFh41sx4=;
 b=mnDmcbJzEMfwE2ycte+Ovr+/xpi1nMT6Ea03nnKpeXgTzZ0T/RmwCivp22Nhz+l2y2
 H19HudPx+l4wT4CqFXOBzwvBVtD98FSt9v5QJzO2upDr2lZyxDTOxvZyVnRv4JAK4qMK
 HHYF20RAsPfbAcvu0l2SyN9JU4iniTImbKzlY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692907167; x=1693511967;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rnbkiG9agnDcYBbc28YlIujrKZZzuZuOwRBIFh41sx4=;
 b=OL0K8VwT5NIEu4LuFSx4clmJDBJk1Xfox8wjD9HwFzkE+xEc7x7cSG9R2UDG1XvyRc
 bRI+rU2YXUAI9ZqieWhzAWy3cFtotUN5aFHvAlIpzlymz3z76mJXxW+yTUK60LroELOP
 zkfrnXnVKkwatu4BPerhBQ168wOP6y8eCSqRod3IU3GIfC8YI2+G/xhENWbqlwCTUO30
 nP0u8q3vEQ2c0L6Cx7AAACwpm5X26/4ZSryeOkmdXEBeJuj+SCEJTpN6yz4Vre4HScoU
 6OdZ97II1rnMCRYNAZ1JzT5l3TWZvImdmHPNGr+nVQXNdkf5AYfITjwjGcSGOeivGfvS
 1jAA==
X-Gm-Message-State: AOJu0YwiamlyamkmxCqoyDX35CgYndTVVzisTBn1UGVF2NelgMQj9Akq
 C4cykvu07OPbqqBA2L6BqN09oppd2qJUnChOjVw=
X-Google-Smtp-Source: AGHT+IGaXEAHAhqpSsAUIh0d/hKkLyyoCyrAQdw4JDGXN+6eZ4XcvnEMP16evcYjzyzT6MAxfYb1kw==
X-Received: by 2002:a6b:d003:0:b0:787:1d0a:ce81 with SMTP id
 x3-20020a6bd003000000b007871d0ace81mr6990483ioa.13.1692907167627; 
 Thu, 24 Aug 2023 12:59:27 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 c11-20020a5e8f0b000000b00786fe5039b8sm9744iok.46.2023.08.24.12.59.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 12:59:27 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Brandon Maier <brandon.maier@collins.com>,
 Kautuk Consul <kconsul@ventanamicro.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 01/19] lib: rational: Move the Kconfigs into the correct place
Date: Thu, 24 Aug 2023 13:58:52 -0600
Message-ID: <20230824195917.1687886-2-sjg@chromium.org>
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

These should not be part of the 'system tables' menu. Move them outside
on their own.

Signed-off-by: Simon Glass <sjg@chromium.org>
Fixes: 7d0f3fbb93c ("lib: rational: copy the rational fraction lib...")
---

 lib/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/Kconfig b/lib/Kconfig
index 42e559ad0b51..9addcfab3734 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -989,6 +989,8 @@ config GENERATE_SMBIOS_TABLE
 	  See also SMBIOS_SYSINFO which allows SMBIOS values to be provided in
 	  the devicetree.
 
+endmenu
+
 config LIB_RATIONAL
 	bool "enable continued fraction calculation routines"
 
@@ -996,8 +998,6 @@ config SPL_LIB_RATIONAL
 	bool "enable continued fraction calculation routines for SPL"
 	depends on SPL
 
-endmenu
-
 config ASN1_COMPILER
 	bool
 	help
-- 
2.42.0.rc1.204.g551eb34607-goog

