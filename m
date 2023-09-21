Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5DAEE7D0A1
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 23:32:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6389863DE;
	Fri, 22 Sep 2023 01:32:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GJz10LuS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8202C86459; Fri, 22 Sep 2023 01:32:54 +0200 (CEST)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 835AA833F5
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 01:32:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-59c0d002081so18586327b3.2
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 16:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1695339171; x=1695943971; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=nhDvkqV+B0Hn5aqGePXRCiYKZ+gOCCanU+L5KdfVCow=;
 b=GJz10LuS7ZcaOxy6zQKcVaGjjsXvwvvIBDTfWQ+lIaZdmFbc7m60+qNlsJMHen56EW
 CXeN+qqCtbsp14pnYwshF7U7BcAaitbB6Nk3+NpAq8YnkO3JWLxIja/1WY8k29Fnmrfp
 TUFeHJJ8wZylvsPzwUXPac9TZ5/yPMMwVsbo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695339171; x=1695943971;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nhDvkqV+B0Hn5aqGePXRCiYKZ+gOCCanU+L5KdfVCow=;
 b=tYRYSoWkG4Xr1W6+BzDw4fEfxLYO9DSpIb8EOFXeBQVMDrC4HfFcYSCtTpktOPDf30
 o0EOgD0N6PkZ1imq/rvs684Jqm607OtvIwIFsfNtb68kOyP+UeMf7ZHGEG7FaFhpqXsM
 qArcXc686FYUbCG7jiwEMqQLtwXikmYJAndWyR4XLD8kQ0XXSvUnzZXpjdmn6jvS04VR
 kWo0SpPxXBD0zHnN7io3dwWXkZKq9zdifx0PdFy2TzuawwUiyGKePfQSoC6VleK47rCz
 R6ZdO72yoq2Spt2eeG+1X1/A82lVlkgV2mLgUJzHtuMj24P+DU9NaZKtWIDkz0lHyRoO
 5Wag==
X-Gm-Message-State: AOJu0Yy+J+wxoFQyZAM3X2Uhr8zI/MsTnPvUYwkG2LV15JIpXv2VpJYS
 udMx3S5pFk0agcNDaWQg7+lzgaCM73GZ6DIZObSVMQ==
X-Google-Smtp-Source: AGHT+IGpzTTUhKvKqB7EijzYScasw/fZq787knbs3Z5i5P1baenxKFFsvE7o89qHoCYVW/pHffJqYg==
X-Received: by 2002:a25:ca81:0:b0:d55:cf49:9144 with SMTP id
 a123-20020a25ca81000000b00d55cf499144mr7643350ybg.15.1695339170714; 
 Thu, 21 Sep 2023 16:32:50 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-b22c-a20b-ddfe-6409.res6.spectrum.com.
 [2603:6081:7b00:6400:b22c:a20b:ddfe:6409])
 by smtp.gmail.com with ESMTPSA id
 n11-20020a25808b000000b00d8168e226e6sm566793ybk.47.2023.09.21.16.32.49
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Sep 2023 16:32:49 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 1/3] Makefile: Allow for board directories to not have a
 Makefile
Date: Thu, 21 Sep 2023 19:32:46 -0400
Message-Id: <20230921233248.159047-1-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
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

It is entirely possible at this point to have platforms in U-Boot that
do not have board-specific C code (just Kconfig or environment) and so
make it optional to have to descend in to and then build in the board
directory.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 Makefile             | 2 +-
 scripts/Makefile.spl | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 9be24c4ec613..5e27bceb8e6c 100644
--- a/Makefile
+++ b/Makefile
@@ -877,7 +877,7 @@ libs-$(CONFIG_UT_ENV) += test/env/
 libs-$(CONFIG_UT_OPTEE) += test/optee/
 libs-$(CONFIG_UT_OVERLAY) += test/overlay/
 
-libs-y += $(if $(BOARDDIR),board/$(BOARDDIR)/)
+libs-y += $(if $(wildcard $(srctree)/board/$(BOARDDIR)/Makefile),board/$(BOARDDIR)/)
 
 libs-y := $(sort $(libs-y))
 
diff --git a/scripts/Makefile.spl b/scripts/Makefile.spl
index 15ac87286d5a..32f4384657b1 100644
--- a/scripts/Makefile.spl
+++ b/scripts/Makefile.spl
@@ -96,7 +96,7 @@ c_flags := $(KBUILD_CFLAGS) $(cpp_flags)
 
 HAVE_VENDOR_COMMON_LIB = $(if $(wildcard $(srctree)/board/$(VENDOR)/common/Makefile),y,n)
 
-libs-y += $(if $(BOARDDIR),board/$(BOARDDIR)/)
+libs-y += $(if $(wildcard $(srctree)/board/$(BOARDDIR)/Makefile),board/$(BOARDDIR)/)
 libs-$(HAVE_VENDOR_COMMON_LIB) += board/$(VENDOR)/common/
 
 ifeq ($(CONFIG_TPL_BUILD),y)
-- 
2.34.1

