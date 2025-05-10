Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 156B1C3ABC9
	for <u-boot@archiver.kernel.org>; Sat, 10 May 2025 13:43:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 632A482952;
	Sat, 10 May 2025 15:43:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bqoN11NC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3399A82893; Sat, 10 May 2025 15:43:34 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 288DF82952
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 15:43:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5fc7edf00b2so4034758a12.2
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 06:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746884610; x=1747489410; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x9O6ckfmfKi5Rag/BJWR0fBLpW1UVYrdx9Wp35yw2RQ=;
 b=bqoN11NCtM1HfYG37P+waU/ANQt53sRhoXX09yS0iNd1h9crdGVWwj3e6/tJO2zc2H
 37Sl1ei/hL01OD9IHRQ6Rel1G30JAzGaK9NVKw6zoAOQzchGbe1aAgcCu4uIZ35TwnU+
 GJzClW2Fs88FbfD5bryaWNWemwl18/5IkZokg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746884610; x=1747489410;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x9O6ckfmfKi5Rag/BJWR0fBLpW1UVYrdx9Wp35yw2RQ=;
 b=r+C8QT3zCawjQl48ro6SGs56Smv/mzHKJywEpTog/UG0id6uVilKLPKtvbNJd0fjJ7
 8DGPK+TUWmism4QWHjIQlRtnBEPGBZWXFltWCE1XqkP70Hig3GgyYZ5yBacOxuieWglm
 6/m2ZIQ7kp6ok7VRzjRyTHMoPsSbk0s6ZyZbr6T7O98uID4wLKDlqIsOg71cOaCATNcO
 cunckJPnfOq4Iiw8/EfZs7Q5i7qo7B0AFHCLLNtO1Jx/r3WA79XegbtlaMaBe14zwCbp
 NbqZHyL3ALET9fMbg8LcX7Hr3699haSZvQRs412gb1yIFXr5iy19sSZEjSZuM9KilQXc
 JcBw==
X-Gm-Message-State: AOJu0YwqwUMRa521hUw8rSwkDvM/xHIBLJ2IV0TfYLQNh4jGyPOE6v74
 YtnV2ZW0bYpVAfh2a+Y6XpyeWyOHSkOxMzeS9EBZkE/3dH24x9Jlle4LfdWsTs3hPrs8mJd6hV8
 X4PL6njbOfw==
X-Gm-Gg: ASbGnctUcRX+EYNdYWa0sI27iYCR9bQV3B4PmAMiuMrDyc/dEemfybjniXWzRz8l2h5
 joq7rztNoMDJIARxiE/cEJWciobYJYduzWdGO+joAhlnIkwnBqZusek+KbENhyxXHuMf6Wb/tkf
 zE30tQpimxw+r05ksaZo84WwULgWAxt0Bedjcqu9xj8NVnOLSC330r8u+aFb2s/h5IyeCbSWcLl
 NUgZDOfy6/GFXWkcRlxAKqY56rtaA7fbtTfYXc9uqgQhFH7iJxXD7c3Wwv/x2KcKAxbg2bO9sus
 2swlzmy2RZrklTpic6ZXM6flO+Hz3Ik4LIIIAmTS+pqGkEWto50LGDF2ly+6MgreVXIX
X-Google-Smtp-Source: AGHT+IGqRG/3UJkGL5bIugO0ER3GZ+ghpjMYfiEEL+r+x0vVKco0PxBJ/7xjVB9ZcD2JSIwlNwi98A==
X-Received: by 2002:a17:907:a0ca:b0:ad2:15c4:e251 with SMTP id
 a640c23a62f3a-ad218fe426emr732405166b.24.1746884610473; 
 Sat, 10 May 2025 06:43:30 -0700 (PDT)
Received: from chromium.org (82-132-222-17.dab.02.net. [82.132.222.17])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad219747028sm319763866b.106.2025.05.10.06.43.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 May 2025 06:43:29 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bill Mills <bill.mills@linaro.org>,
 Andrew Phelps <andrew.phelps@canonical.com>,
 =?UTF-8?q?Fran=C3=A7ois=20Ozog?= <francois.ozog@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: [PATCH v4 03/22] x86: Move Intel GNVS file into the common include
 directory
Date: Sat, 10 May 2025 15:42:01 +0200
Message-ID: <20250510134253.1581164-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250510134253.1581164-1-sjg@chromium.org>
References: <20250510134253.1581164-1-sjg@chromium.org>
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

Move this so we can include it from sandbox, needed since it is in a
bloblist and must have a check.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/x86/cpu/apollolake/acpi.c                    | 2 +-
 arch/x86/cpu/intel_common/acpi.c                  | 2 +-
 arch/x86/include/asm/arch-apollolake/global_nvs.h | 2 +-
 board/google/chromebook_coral/coral.c             | 2 +-
 {arch/x86/include/asm => include}/intel_gnvs.h    | 0
 5 files changed, 4 insertions(+), 4 deletions(-)
 rename {arch/x86/include/asm => include}/intel_gnvs.h (100%)

diff --git a/arch/x86/cpu/apollolake/acpi.c b/arch/x86/cpu/apollolake/acpi.c
index 93040e7bb37..f32a10daedd 100644
--- a/arch/x86/cpu/apollolake/acpi.c
+++ b/arch/x86/cpu/apollolake/acpi.c
@@ -12,6 +12,7 @@
 
 #include <cpu.h>
 #include <dm.h>
+#include <intel_gnvs.h>
 #include <log.h>
 #include <p2sb.h>
 #include <pci.h>
@@ -20,7 +21,6 @@
 #include <asm/acpi_table.h>
 #include <asm/cpu_common.h>
 #include <asm/intel_acpi.h>
-#include <asm/intel_gnvs.h>
 #include <asm/intel_pinctrl.h>
 #include <asm/intel_pinctrl_defs.h>
 #include <asm/intel_regs.h>
diff --git a/arch/x86/cpu/intel_common/acpi.c b/arch/x86/cpu/intel_common/acpi.c
index 982149b394e..8688232ec34 100644
--- a/arch/x86/cpu/intel_common/acpi.c
+++ b/arch/x86/cpu/intel_common/acpi.c
@@ -11,6 +11,7 @@
 #include <bloblist.h>
 #include <cpu.h>
 #include <dm.h>
+#include <intel_gnvs.h>
 #include <acpi/acpigen.h>
 #include <asm/acpigen.h>
 #include <asm/acpi_table.h>
@@ -23,7 +24,6 @@
 #include <asm/mpspec.h>
 #include <asm/smm.h>
 #include <asm/turbo.h>
-#include <asm/intel_gnvs.h>
 #include <asm/arch/iomap.h>
 #include <asm/arch/pm.h>
 #include <asm/arch/systemagent.h>
diff --git a/arch/x86/include/asm/arch-apollolake/global_nvs.h b/arch/x86/include/asm/arch-apollolake/global_nvs.h
index ef8eb228dbe..639d8f2de78 100644
--- a/arch/x86/include/asm/arch-apollolake/global_nvs.h
+++ b/arch/x86/include/asm/arch-apollolake/global_nvs.h
@@ -10,6 +10,6 @@
 #ifndef _GLOBAL_NVS_H_
 #define _GLOBAL_NVS_H_
 
-#include <asm/intel_gnvs.h>
+#include <intel_gnvs.h>
 
 #endif /* _GLOBAL_NVS_H_ */
diff --git a/board/google/chromebook_coral/coral.c b/board/google/chromebook_coral/coral.c
index db96534857c..b4053fa097d 100644
--- a/board/google/chromebook_coral/coral.c
+++ b/board/google/chromebook_coral/coral.c
@@ -11,13 +11,13 @@
 #include <dm.h>
 #include <event.h>
 #include <init.h>
+#include <intel_gnvs.h>
 #include <log.h>
 #include <sysinfo.h>
 #include <acpi/acpigen.h>
 #include <asm-generic/gpio.h>
 #include <asm/acpi_nhlt.h>
 #include <asm/cb_sysinfo.h>
-#include <asm/intel_gnvs.h>
 #include <asm/intel_pinctrl.h>
 #include <dm/acpi.h>
 #include <linux/delay.h>
diff --git a/arch/x86/include/asm/intel_gnvs.h b/include/intel_gnvs.h
similarity index 100%
rename from arch/x86/include/asm/intel_gnvs.h
rename to include/intel_gnvs.h
-- 
2.43.0

