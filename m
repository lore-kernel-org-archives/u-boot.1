Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00C8AC369CA
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 18:17:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B81B082E08;
	Thu, 17 Apr 2025 20:16:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="npCEH+Jv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AF53830C0; Thu, 17 Apr 2025 20:16:50 +0200 (CEST)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CB1782CFD
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 20:16:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-3d8092656a9so6732915ab.0
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 11:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744913806; x=1745518606; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x9O6ckfmfKi5Rag/BJWR0fBLpW1UVYrdx9Wp35yw2RQ=;
 b=npCEH+JvKU+EvyGJA+ZJiFUfcBhD5QQ9v2DNN2rMrLG++grzXkNTVs/ckWtMwkDSek
 5Q2HkuwI4dKDlz3nNevuWAUAnYisWdgDwGLdPdcKRikpen2jDZ7z5M5PDjCApmkp8KsQ
 tPl+2qCr938oelY7dVnbszGSHWF7xhxi8ZK5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744913806; x=1745518606;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x9O6ckfmfKi5Rag/BJWR0fBLpW1UVYrdx9Wp35yw2RQ=;
 b=olLMOJKn7eHZOdmyBG6P7tE8oIzPoRRV9x6O+H/e8krVo0YQnGpGQo5jOyKA7TGwwI
 7RLdBvhEyKoLASdN20Eyt6uh+eTwZCnIi9rs2R5XcrhZ/8fohU3hizN+Y3S2OzZXADGf
 tP55yT7cyECL3TDrE8oKw5ia2CuxP9HYoZmQJL90AYK5fqC0gc0s9CE1IFvLbyL7hQW/
 mTQw4GyCj7cosadep3YHtbAwgdRes8pGw14JK8/cJL9SPhU+Db+bGb7sQ0JWVyzg9Pz0
 /Lyg7iGUl9CUNbyO687zKevMu16zgyBVtFUCDJVUNStSEO2XwP6cgpbleDqQyJLY7SDp
 L1lA==
X-Gm-Message-State: AOJu0YwsLxuLwgQuv4Q/q2Fy9EuR5dluk5JQXWclUJScgrx6fE4GRs3I
 saj/VDqJrD/ZScTn4G66Hgc+xUwzBDSVEGM0Hc1sGUh7ni/epKE0FvLwyGguaED4R6M6YYxLUcA
 =
X-Gm-Gg: ASbGncv+oX5TeJI782AAcR3RrSjnx83qVf2U8TCxTovSelESRm6MluJl73sNRcFLr4K
 H+AyWkDVuvzLUc81FWMTblLtxKftauQ6KSjbCbTh3vuC3H4TH0l+DJNJXWvpgviTX0Poa6JdYoU
 84H+oxj3m/DtUw+0OMJDnhZDswKFggna0/KdSCaAkE+O/3dh9xUfeTRRpfh1+nKlZ21HPLZrOkh
 sHm/vRytZoPmKTUdObBgRYU26DXDDwJCz62+UYFvZtkSmtpAzGL4VliHhhWQ8OZ/3YW8hKK4NJw
 CAZKyRft45DA34240s8QDM/HjK5GnMraeCa8CZzAwaUU92f4b5gZxRZ3iUtt6ivmbMCt11hAnJk
 /Jg==
X-Google-Smtp-Source: AGHT+IFxVbfu0ArtjlzNsCh7bOfLDiYEDm310zJpGXJAi7vxGyifT9bmmmea+Dhz/H/6J8bZOS+wBQ==
X-Received: by 2002:a05:6e02:df4:b0:3d2:af0b:6e2a with SMTP id
 e9e14a558f8ab-3d821d40fa6mr7871105ab.5.1744913806324; 
 Thu, 17 Apr 2025 11:16:46 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f6a37cb9aesm66673173.28.2025.04.17.11.16.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Apr 2025 11:16:44 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Peter Maydell <peter.maydell@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andrew Phelps <andrew.phelps@canonical.com>,
 =?UTF-8?q?Fran=C3=A7ois=20Ozog?= <francois.ozog@linaro.org>,
 Bill Mills <bill.mills@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: [PATCH v3 04/22] x86: Move Intel GNVS file into the common include
 directory
Date: Thu, 17 Apr 2025 12:15:46 -0600
Message-ID: <20250417181613.1355024-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250417181613.1355024-1-sjg@chromium.org>
References: <20250417181613.1355024-1-sjg@chromium.org>
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

