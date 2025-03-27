Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76CC6C3600B
	for <u-boot@archiver.kernel.org>; Thu, 27 Mar 2025 23:11:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9C4F8070C;
	Fri, 28 Mar 2025 00:11:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="g5eJnwcd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB47680ECC; Fri, 28 Mar 2025 00:11:05 +0100 (CET)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92554806FC
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 00:11:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-4774193fdffso25189311cf.1
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 16:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743117062; x=1743721862; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hDzb9whWsMdirGjAblYQNgcajGbGiw5tM1i9o2Ws+/w=;
 b=g5eJnwcdXwtRmRlYKJJeltyKH9mCKz9N0yCdtH/gI5hBPAeYG4ld5YUDN+0hFyALI6
 PgAT3QqU/Y3L10Q4FioYAcPhIJXLzXRF5/Zy48JLfWPzEqd3dMxWKxm+v2jNNvPL9SbM
 dAHLktcgKr1w2vfGKM+VU6CB5NxooJNJk11+RO+ElNroRA48Y1W77QfFneR0m+3Dxj/n
 5PR/BXL+dNhPkvGME3oi+XeplvshCpTvf7av5jNOV9IH8bn4uPQfdVNBsAzlLOO9TjRB
 5DEsLFGZUz0Y9b23iqq330nNKTuu9FPE3b56YIl3DZ+xVHXU/OH4398+ZxGLAkRVPcD8
 6s2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743117062; x=1743721862;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hDzb9whWsMdirGjAblYQNgcajGbGiw5tM1i9o2Ws+/w=;
 b=hacyZkMEtQNWN3rrICNsIRgCSUaS0j60hHC2mig8IaXQxXH3NbFmo9vnmLTU0DfTEM
 AyXNipQHBoBFXAjy+u2GjHXCBcm5ln7SvcfCawkCs37FnqhNHpo5zjiym7CmKDY2Qez1
 lyrXebaJQvjLLwapH9D0N5C/bwBH4qhdet78eFHso8oJFM8UMKCpKDwYTDLbKTj1dgDR
 ZsoG1C3aVQj/P2pQwjYcW3cX+69qsdu59KWHlhb2VQ9gcaXUPgCihNUvMLQyFt2JdX4g
 HP1tdlpIozjavSOvliWPppacqq4d8pxYlTtTsoqX0IWd1U0OKuleApvk8gA5aFOkp6gy
 YCMw==
X-Gm-Message-State: AOJu0YwQYXdRKNmID45E3P10xP5cKk3SZ46tYhdKGakXvIqyuXKq8Ox0
 xDEeP88c5Q5DCa7gq47Hwoa1QxFFe7uAkv5I/ODmtlrI976B7xGTZ5Orc3VYJjTp1B72ntsizsx
 g
X-Gm-Gg: ASbGncuy0MC5Ma4PEX3qwjlYTZ+Ykp9+OOG5NaezPe/Zr8EKll+kL8kOV97SJTeeBMu
 giJH4mN19U4lLRc/yMNARNmlkF8Pgiy0I6E6/iL0eDa7A5FSnYq3oCZHi0zjWmUby5dTMhVHM1U
 rGQeEJuc12pv/XW7jxvJ8lnXiuHXvBV+lhpPhUSMUgGABSDOZf94P/U4eOPicDmHGlBJt5Ph0VN
 i0ufzW/boFo39+nCsN059rxBTujhoM7zY1AtGLPJ4kKICsHw6NrbeKvT8OYNVoFu6Uu7CiUh4uP
 uI8ttePCohI5y3yGUI3zEt4LZ45Z5OKOeWBNNwfsx9RhMVBknZQ75OXISCcE9SGRAsvM8Q==
X-Google-Smtp-Source: AGHT+IFt1d3bK8pSL+xO72Vpo+24AYDvI3YGzHO9FDWdK4B0PZmfxAUOa0a/NGSXw6o9j57gpYo/CQ==
X-Received: by 2002:a05:622a:4a8d:b0:476:a6bc:a94d with SMTP id
 d75a77b69052e-4776e0df177mr97270411cf.19.1743117061849; 
 Thu, 27 Mar 2025 16:11:01 -0700 (PDT)
Received: from ubuntu.localdomain ([209.227.153.148])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4778317b7dasm3102271cf.64.2025.03.27.16.11.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Mar 2025 16:11:01 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ravi Minnikanti <rminnikanti@marvell.com>,
 Matthias Brugger <mbrugger@suse.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH] tools: add pkg-config for preload_check_sign
Date: Thu, 27 Mar 2025 16:10:44 -0700
Message-Id: <20250327231045.2713024-1-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
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

The cflags and ldflags of preload_check_sign depend on the openssl
package thus pkg-config is needed to get the location where openssl
is installed.
This fix a potential build failure when openssl is not from the
distro and installed in a varied place.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 tools/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/Makefile b/tools/Makefile
index 53b87d22a80..d0e4d2d16c3 100644
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -169,6 +169,8 @@ fit_check_sign-objs   := $(dumpimage-mkimage-objs) fit_check_sign.o
 fdt_add_pubkey-objs   := $(dumpimage-mkimage-objs) fdt_add_pubkey.o
 file2include-objs := file2include.o
 preload_check_sign-objs := $(dumpimage-mkimage-objs) $(PRELOAD_OBJS-y) preload_check_sign.o
+HOSTCFLAGS_preload_check_sign.o += \
+	$(shell pkg-config --cflags libssl libcrypto 2> /dev/null || echo "")
 
 ifneq ($(CONFIG_MX23)$(CONFIG_MX28)$(CONFIG_TOOLS_LIBCRYPTO),)
 # Add CFG_MXS into host CFLAGS, so we can check whether or not register
@@ -207,6 +209,8 @@ HOSTLDLIBS_fit_info := $(HOSTLDLIBS_mkimage)
 HOSTLDLIBS_fit_check_sign := $(HOSTLDLIBS_mkimage)
 HOSTLDLIBS_fdt_add_pubkey := $(HOSTLDLIBS_mkimage)
 HOSTLDLIBS_preload_check_sign := $(HOSTLDLIBS_mkimage)
+HOSTLDLIBS_preload_check_sign += \
+	$(shell pkg-config --libs libssl libcrypto 2> /dev/null || echo "-lssl -lcrypto")
 
 hostprogs-$(CONFIG_EXYNOS5250) += mkexynosspl
 hostprogs-$(CONFIG_EXYNOS5420) += mkexynosspl
-- 
2.25.1

