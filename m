Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BFE8C369D1
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 08:29:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D3338209F;
	Thu, 24 Apr 2025 10:29:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kuChUAm7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF1D081E14; Thu, 24 Apr 2025 10:29:20 +0200 (CEST)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAF7180F9C
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 10:29:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-30effbfaf61so8759621fa.0
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 01:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745483358; x=1746088158; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xAf6v3ma3C2JcXHCxotmrm+VVxXSC/Oq/rX+EFNQu3w=;
 b=kuChUAm7ayOHWSC7bdGTiFap5/jTlkx+ZAERH7j9eYsccubiIvz9qOkIJfQqNi80VW
 les2AJmCosfCpbp8s1FiVxT0CzRV6DSd9XtBJItb/XVFzX1Oe3WzAQvXSsFfFuWMbYAe
 tRR3R8ILXOYIosiJ+xbbHmnpD/ndlQstYtsm2VRllWYNPTX5oA+boFZyV5TkMSXoNjBl
 G6Q9Xn2MBH52eImbZ9Z+lhEPgiH5vustbL6nyt7CRl+STzyY7U13Dv+byqFLRQJDvSyU
 d6duTkB+3LieW8VYKAZALGnCCdwT9NU6jxAe3hn0yHva9nbx3aN5ukd8JhXqP5aha5QC
 gI5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745483358; x=1746088158;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xAf6v3ma3C2JcXHCxotmrm+VVxXSC/Oq/rX+EFNQu3w=;
 b=N/KjnuLco+unomDk55YWaZdy5uz0dJHqJrkgqCgTGbiZiqB8zteWBROXUoMDX1ZdfE
 FFUQDHBOcIcRbh9qTuMFUSisHYipIrgWQ0pacKMOVVtaMkZBi3DV1y0NFSsoZ/K34T1i
 ji4cDXRke5xCZtElM2FVRS1UhKRTVXWZRerdyX0Vj+LelPVfxjbjL0uLDSyDlqRyy5Ng
 s+VF/VSrsJG0bXBeAimBRyTPM/Oe/TboAPcIyyFEmmgxqqBcvLBNArfDOP5szZETna3L
 VEgAzHv4oCkIwXX98jJq5TLzXgHCaLKupnwTf2Mr+afDfMWEUfb9ozXI0mLnw9tHUbj8
 DtHw==
X-Gm-Message-State: AOJu0YyF4ehxjTw5ADG9HHxzEtMIqBj6JjlEvZA4LEqIqk456zYy69Ue
 i/eJsv2zWe26OgLkgkCfT91oPx2Er8EJMcF0Y9VdeBU+WEZNqML/
X-Gm-Gg: ASbGncslKnewPu8m41sdl7r5v05ozRnKRpNjSTn+hzmsLtkZjvSrmj7ESx8r1NGrPcY
 VaLzWZK985oFJJB9lkLvIAKJJLeiifQbUDFmy7hsZ3oeApR+W7V02TgO02J+690rA2YgMFYF1SU
 0NjqYXtBzsCi9iNJgyaTt7srYN1oAwbIhJ3ZxsY8A/X8ZaCgVivBOqldXEEPdub+Um5Tas0sEY9
 Z1YVhZZ89uX9b2E9rLAE1qdvglVulHZo/vyMMyyXqTs4T1wOVJd9cgzr87SK9SQVvFDrk7tcQzz
 yx8nsIDq9r9xY+Zmg+8doZYOAinwV0iRWdIrEqBwR6U=
X-Google-Smtp-Source: AGHT+IGMYfNCPovnKyaddZYcXhHWJHq6H/dD/y2werDt8LFa3RCJUwOCUcldutoZTN+139ZzyxPWRw==
X-Received: by 2002:a05:651c:12c8:b0:30b:fc16:d482 with SMTP id
 38308e7fff4ca-317cc3b4babmr4368881fa.3.1745483357803; 
 Thu, 24 Apr 2025 01:29:17 -0700 (PDT)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-317d16a832csm1627581fa.67.2025.04.24.01.29.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Apr 2025 01:29:17 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Allen Martin <amartin@nvidia.com>, Peter Geis <pgwipeout@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 1/4] ARM: tegra: add PRAM Kconfig option
Date: Thu, 24 Apr 2025 11:28:30 +0300
Message-ID: <20250424082834.17538-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424082834.17538-1-clamor95@gmail.com>
References: <20250424082834.17538-1-clamor95@gmail.com>
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

Wrap CFG_PRAM with Kconfig option.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/mach-tegra/Kconfig | 14 ++++++++++++++
 include/configs/tegra.h     |  4 ++++
 2 files changed, 18 insertions(+)

diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
index 4690dcb3ea6..67bd2398bfd 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -198,6 +198,20 @@ source "arch/arm/mach-tegra/tegra124/Kconfig"
 source "arch/arm/mach-tegra/tegra210/Kconfig"
 source "arch/arm/mach-tegra/tegra186/Kconfig"
 
+config TEGRA_PRAM
+	select TEGRA_SUPPORT_NON_SECURE if TEGRA114 || TEGRA124
+	bool "Support reservation of the protected RAM"
+	help
+	  This option indicates the presence of a region of protected RAM.
+
+config TEGRA_PRAM_SIZE
+	hex "Size of pRAM region"
+	depends on TEGRA_PRAM
+	default 0x1000
+	help
+	  Size in kB of carevout which will be reserved as protected RAM starting
+	  from the top of the RAM.
+
 config TEGRA_SPI
 	def_bool y
 	depends on TEGRA20_SFLASH || TEGRA20_SLINK || TEGRA114_SPI
diff --git a/include/configs/tegra.h b/include/configs/tegra.h
index 77bc38930d2..5db3129fade 100644
--- a/include/configs/tegra.h
+++ b/include/configs/tegra.h
@@ -29,6 +29,10 @@
 #include "tegra210-common.h"
 #endif
 
+#ifdef CONFIG_TEGRA_PRAM
+  #define CFG_PRAM CONFIG_TEGRA_PRAM_SIZE
+#endif
+
 #include "tegra-common-post.h"
 
 #endif /* __CONFIG_H */
-- 
2.43.0

