Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ACDDC001DF
	for <u-boot@archiver.kernel.org>; Fri, 20 Oct 2023 18:43:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A955874FB;
	Fri, 20 Oct 2023 20:43:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="W1VxGsW2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B08BD874FC; Fri, 20 Oct 2023 20:43:01 +0200 (CEST)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71AE4874F8
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 20:42:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-1ea48ef2cbfso893350fac.2
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 11:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697827375; x=1698432175; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=not3VwtTGNgVrUR+v7u8KRKbikWl5f0cWiC/jB+WwGc=;
 b=W1VxGsW2+EnZnOimOU9f9QVUM2ZpNAVHvi7XE4eTDYXSOHqXUgOuDw5bZay/P4j1QW
 RG95p0N+dtW73DczUcKzzbXjeXhRe2iu1Q/tQIkJ3uQn8uYmQ3lPlmjvVart+meUFAvX
 jnmxE511JTOWIXTG19f2I+LNMbGumZisnKuvCEEZ9MuSeY05d6t2D0f4IiyVIHhUXtYn
 91SSnb3TE1MGjkUb/pSHknYra8L22nYEL6yJJKdCeppq4nJS2XCh0Zxj7EOyiVtE7x/d
 M/dQ+oRuBxSKa8n+NsE64tvdYaQm4TR273V20C/JAe0oFpYHoAm1O8G+IW78EOKt9k6c
 no5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697827375; x=1698432175;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=not3VwtTGNgVrUR+v7u8KRKbikWl5f0cWiC/jB+WwGc=;
 b=IIM8DVClhEesEbtgOTpGo/M03SiC9aBCfR6ybpNJjAz9a1KeznY1JRxtD7wevT8lgt
 dFp/+V6cqjBmvYfEZTS/XoCUJ90jOW+1y/vOidm/RvvN5CYINMYvwOUDwE7UVdpnQ/p2
 XtjnUISjiOhT6qq4mrcBMELXP4GI7+rXOfQDuBZU3a6s7WnArK+DUZ08+Kx5PGD/VxKy
 Dw7IzMSKKe+EhI7bmzjZU1ArHTc0ruPfkYuNEAWQ0dalbJ0O4mqpGzmQ9dRDuE9A9Qk1
 vliNoM72BE710BUJGGRhKH5gdIsAoSk8/kBBZylYnCZX7fp6ZewbK7MBKhwNoIrBhzbF
 unjw==
X-Gm-Message-State: AOJu0YyPnO7I8roaBSTtEKNRYG6ny1HITa/mPl/HsoxkSTr878LVEr5n
 3ZDoCL7tVno40RKovTwW38c6Wg==
X-Google-Smtp-Source: AGHT+IFc0uBNEpdb+olsUnH8kswtQByrqGfgg38dNqw372+/DhVSDbW/4fyAx4i7+ABl3e0DzJHcqQ==
X-Received: by 2002:a05:6871:821:b0:1d6:4b84:c7ed with SMTP id
 q33-20020a056871082100b001d64b84c7edmr3180553oap.23.1697827374964; 
 Fri, 20 Oct 2023 11:42:54 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 m7-20020a056870194700b001cc9bc7b569sm460048oak.27.2023.10.20.11.42.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 11:42:54 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>,
	Dzmitry Sankouski <dsankouski@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH] board: samsung: Remove incorrect SYS_CONFIG_NAME in axy17lte
 Kconfig
Date: Fri, 20 Oct 2023 13:42:53 -0500
Message-Id: <20231020184253.21915-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
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

The global SYS_CONFIG_NAME in axy17lte Kconfig overrides SYS_CONFIG_NAME
for all boards specified after this line in
arch/arm/mach-exynos/Kconfig:

    source "board/samsung/axy17lte/Kconfig"

Right now it's the last 'source' line there, so the issue is not
reproducible. But once some board is moved or added after this line the
next build error will happen:

      GEN     include/autoconf.mk.dep
    In file included from ./include/common.h:16:
    include/config.h:3:10: fatal error: configs/exynos78x0-common.h.h:
                           No such file or directory
        3 | #include <configs/exynos78x0-common.h.h>
          |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    compilation terminated.

That's happening because axy17lte Kconfig defines SYS_CONFIG_NAME option
in global namespace (not guarded with any "if TARGET_..."), so it
basically rewrites the correct SYS_CONFIG_NAME defined in the
hypothetical boards which might appear after axy17lte in mach-exynos
Kconfig.

Another side of the issue is that SYS_CONFIG_NAME is defined
incorrectly in axy17lte Kconfig:

    config SYS_CONFIG_NAME
        default "exynos78x0-common.h"

The .h extension should not have been specified there. It's leading to
the build error, as the generated include file has double '.h' extension.

Fix the issue by simply removing the SYS_CONFIG_NAME definition in
axy17lte Kconfig, as all related defconfigs already declare internal
values for SYS_CONFIG_NAME:

  - a5y17lte_defconfig
  - a7y17lte_defconfig
  - a3y17lte_defconfig

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
Fixes: 3e2095e960b4 ("board: samsung: add support for Galaxy A series of 2017 (a5y17lte)")
---
 board/samsung/axy17lte/Kconfig | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/board/samsung/axy17lte/Kconfig b/board/samsung/axy17lte/Kconfig
index a018547ff5d4..209394a8a5a8 100644
--- a/board/samsung/axy17lte/Kconfig
+++ b/board/samsung/axy17lte/Kconfig
@@ -1,11 +1,3 @@
-config SYS_CONFIG_NAME
-	string "Board configuration name"
-	default "exynos78x0-common.h"
-	help
-	  This option contains information about board configuration name.
-	  Based on this option include/configs/<CONFIG_SYS_CONFIG_NAME>.h header
-	  will be used for board configuration.
-
 if TARGET_A5Y17LTE
 config SYS_BOARD
 	default "axy17lte"
-- 
2.39.2

