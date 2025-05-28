Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FBC2C5AD49
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 12:33:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E06B838E6;
	Wed, 28 May 2025 14:33:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NNNaA6+/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4290B83A36; Wed, 28 May 2025 14:33:26 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1407A8390C
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 14:33:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3dc7294716cso36817075ab.2
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 05:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748435602; x=1749040402; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x9O6ckfmfKi5Rag/BJWR0fBLpW1UVYrdx9Wp35yw2RQ=;
 b=NNNaA6+/wvnBw5DYADBu7zTumMo6gtfqVbWs7jMdWBB44Q6WZFpSVKTlg+KLWUcEAh
 TFdirDVFtK4eNNjQ5egg4WdqN5g9MxeZhU4DGfnZbaphyRA3QXfsAf+CmCWaVCMnjBkL
 sxxw4lqAsvDQ82kNflnYGXIZ2o53w3E/b/EBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748435602; x=1749040402;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x9O6ckfmfKi5Rag/BJWR0fBLpW1UVYrdx9Wp35yw2RQ=;
 b=NW13LEGyODgBmXhotLUaTW4hWUXyWIcqmIHwgdT+EXnL+6ByOSJTpcXTcCej49HWJM
 VJ7e76THLTrNiQNlqfaz0rKM7f5mxjn0Oh+54ZIp/H7/6LjYi7J6H0B5NjujHLD4A6Je
 cXYNirMV1t+bIZiHNQxfJeo2eQqtCEFGSlTpobBAo/oiqvWBjBxLs3HYuz9rkJTZdKq4
 ya4hPei2pTXrnAwdbxNPHkZELBqrYxOLXW+Aj5PzzsdUANPxvqBXmrJCh/zqAlvoAo8t
 jQvrRt+CrpBQSZffAqJLuMqs8wUww7Bm5eOqkln/usXwupzlQVRkWg0xRlErugoeHFS4
 m7fg==
X-Gm-Message-State: AOJu0Ywq3aPKdigKD53+Cwp2C32NSCN9op1kwSaVcZ7kVuDIQW2ltJ+7
 fee87l0rsuaOuW+Y03JQ9NBuLwb3icJjHROz/Rec74r9P9C+Vn3ZMonWmVFjc5hgZ3i3hZpDJY5
 euXWoZ1Dg
X-Gm-Gg: ASbGnctj2m11foI4UdPxqc7smq3bw0eEIFVuZAdp8OjjFg5k4wHCBSU73E6eCdJQWyR
 vWEuDFlAKyFBPmWaHs5fPmNjn2zNpJhRVYqbyYU8b7amksAiyshgOeMgd8lMHO2ApQeNvXST1Tk
 Pl1LdmxnWQvdvKcVrDtzYn9DcAv/MnXevne0VlVe/x8Vw/Tn4+fCC85yJhdz8UoWY9O4AQOlzc2
 YDy4gWBJSqStJJnEHpuYdDbU/mjzXgb/5M8k80WoSZte6Ay4Lz26f5HFrhn/SbEsqEbYown6I5F
 NDIeaC1mzYYRJ+lHVIZhQdrG81/5V1dEFLNW+72VXNcojM2qA3iFFXDJqeBRK+zkZeSKFk+eJW5
 32cC91y77ezUx
X-Google-Smtp-Source: AGHT+IHtvjaQIAnqQwIQ68wYjyljnDuHqZZtzYG66etr656BmiTaWpGw/8FoVURv1RgItKm96jMAXQ==
X-Received: by 2002:a05:6e02:154e:b0:3dc:875e:ed7e with SMTP id
 e9e14a558f8ab-3dc9b6cc045mr179958585ab.12.1748435602143; 
 Wed, 28 May 2025 05:33:22 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4fdbd4bb408sm205972173.58.2025.05.28.05.33.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 05:33:19 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: =?UTF-8?q?Fran=C3=A7ois=20Ozog?= <francois.ozog@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bill Mills <bill.mills@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andrew Phelps <andrew.phelps@canonical.com>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: [PATCH v5 05/25] x86: Move Intel GNVS file into the common include
 directory
Date: Wed, 28 May 2025 06:32:07 -0600
Message-ID: <20250528123236.1138632-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528123236.1138632-1-sjg@chromium.org>
References: <20250528123236.1138632-1-sjg@chromium.org>
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

