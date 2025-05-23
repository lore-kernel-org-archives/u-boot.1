Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DD45C54ED0
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 23:02:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0784983595;
	Sat, 24 May 2025 01:00:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lB6oNCfI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BF488338C; Sat, 24 May 2025 00:59:12 +0200 (CEST)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 072518333D
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 00:59:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=swboyd@chromium.org
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-b27015122c4so197880a12.3
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 15:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748041147; x=1748645947; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p6ZGLNfrm2E44Awrp1tQSTiBNj+s+vejgx0gvQ+/lDA=;
 b=lB6oNCfI7pPK9D2muC6ZLd75ugNpjfcRkiSsi/WN8s8HetVdEptlUo6T7iyq174KrF
 hHeVjNmWvY4QzFQWQzh4Fia0Zk3p2vACScxGL9xllwE8PuAaYihCusJs0Ia6DWbHZP61
 DuorPhvBS5PRjB0/OznjOY44ucayULC3HVDI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748041147; x=1748645947;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p6ZGLNfrm2E44Awrp1tQSTiBNj+s+vejgx0gvQ+/lDA=;
 b=GaNfZZAxb4vjTmfJqEZVj77v2rUWb0AVu77SuxRrV7KRS+gcu2ykH7StRoOkNHAVfa
 2sk7/eSSyaYZzUlrStE5lLf5nqRJJMtVhmajskRJqjzwRGjRrqO+B1kVGG7rhVFiDMxx
 1f1m1cIDOxpdrvda1+3maCfatgxEMouHp1QvqXpxZedkqnCSxGuhT+IgHaF62DO2t03Y
 AdWRRDyWMtCOkLGUTjOjq+4TYGB5UNadEz8oTuJFXhgl2/ZP0ka1m+pPjz50KFacoUiA
 72uH4dPBAalV4Q0gaY1Esjyo0CzM9WmCuy5JcwBFnklZnzXaohtQstZipEP2E3IGNpF6
 o6Hw==
X-Gm-Message-State: AOJu0YycE6CBfw71hpJ+24nT6RZTwN4KJvu2jxoz7hwXS2BuqD2wt0sx
 WA8ja3rJwgXTkGdmpHMuEM7BkxNy9NuCHB5Aw7IJ7ngA9y9K7zr5wmMlpYY2XZCmRcNxKRrZloI
 FOHc=
X-Gm-Gg: ASbGncvSEtJWkflZ7AG6h7xzALy4apm2+djY+T7Bj3uBYtRJ2aq422hZ0xcZISkomgQ
 uk5LUHzVlQ55Y8EGV76qHSEKh+FxSeB7cLvy4lWwjzBErWxAWuMzVbPHTsbatqlJxje7U/agJOv
 DO5Xwhu2uGPw1mDqUtWjyiw6FWc8Z88YjlfYEVmmF46WyH8NCc1Vg/HJMIstfSbxRzajJd4Vg9k
 fd0AurnSYJOboH3bkkxUfQFHLHSliG7+mQwQkaztdYJtRURIJA/puthyJ9J0oZ+P4R0GQKO3aeF
 +5CNr+y/2s2hVlNj3oSazQbJpJOxFT3xJscOFj5TmFiNfEBgzEU99UgOt1yCKk2QTe8eszPSZ4A
 gDOwqC+0Lq5fftn4=
X-Google-Smtp-Source: AGHT+IHPn4qOvrQ3AI5AoduDA+g9v2qw7gET7hpAL3nGV5ZLJ22SayiHf2cd2b3vHuJRUCPdSbDAVA==
X-Received: by 2002:a17:902:da47:b0:21f:988d:5758 with SMTP id
 d9443c01a7336-23414fb1a60mr19758225ad.35.1748041147410; 
 Fri, 23 May 2025 15:59:07 -0700 (PDT)
Received: from localhost (188.139.125.34.bc.googleusercontent.com.
 [34.125.139.188]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-233f8b2dcf1sm13768335ad.124.2025.05.23.15.59.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 May 2025 15:59:07 -0700 (PDT)
From: Stephen Boyd <swboyd@chromium.org>
To: u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
Subject: [PATCH v4 13/28] cmd/cbsysinfo: Allow on ARM as well
Date: Fri, 23 May 2025 15:58:28 -0700
Message-ID: <20250523225845.2311989-14-swboyd@chromium.org>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
In-Reply-To: <20250523225845.2311989-1-swboyd@chromium.org>
References: <20250523225845.2311989-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 24 May 2025 01:00:29 +0200
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

This command isn't x86 specific. Move it up one level so that it can be
used on a platform that can find the coreboot table, i.e. x86 or ARM.

Reviewed-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 cmd/Kconfig               | 4 ++--
 cmd/Makefile              | 1 +
 cmd/{x86 => }/cbsysinfo.c | 0
 cmd/x86/Makefile          | 1 -
 4 files changed, 3 insertions(+), 3 deletions(-)
 rename cmd/{x86 => }/cbsysinfo.c (100%)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 2d31abcef730..5a35dba8681a 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2929,8 +2929,8 @@ menu "Debug commands"
 
 config CMD_CBSYSINFO
 	bool "cbsysinfo"
-	depends on X86
-	default y if SYS_COREBOOT
+	depends on SYS_COREBOOT
+	default y
 	help
 	  This provides information about the coreboot sysinfo table stored in
 	  memory by coreboot before jumping to U-Boot. It can be useful for
diff --git a/cmd/Makefile b/cmd/Makefile
index 80cf70b7fe8c..7587b258409c 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -44,6 +44,7 @@ obj-$(CONFIG_CMD_BUTTON) += button.o
 obj-$(CONFIG_CMD_CAT) += cat.o
 obj-$(CONFIG_CMD_CACHE) += cache.o
 obj-$(CONFIG_CMD_CBFS) += cbfs.o
+obj-$(CONFIG_CMD_CBSYSINFO) += cbsysinfo.o
 obj-$(CONFIG_CMD_CEDIT) += cedit.o
 obj-$(CONFIG_CMD_CLK) += clk.o
 obj-$(CONFIG_CMD_CLS) += cls.o
diff --git a/cmd/x86/cbsysinfo.c b/cmd/cbsysinfo.c
similarity index 100%
rename from cmd/x86/cbsysinfo.c
rename to cmd/cbsysinfo.c
diff --git a/cmd/x86/Makefile b/cmd/x86/Makefile
index 5f3f5be2882f..870e941dcf00 100644
--- a/cmd/x86/Makefile
+++ b/cmd/x86/Makefile
@@ -1,6 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0+
 
-obj-$(CONFIG_CMD_CBSYSINFO) += cbsysinfo.o
 obj-y += cpuid.o msr.o mtrr.o
 obj-$(CONFIG_CMD_CBCMOS) += cbcmos.o
 obj-$(CONFIG_CMD_EXCEPTION) += exception.o
-- 
Sent by a computer, using git, on the internet

