Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C4AAC54ED1
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 23:02:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E69248353A;
	Sat, 24 May 2025 01:00:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZzQ3hhdB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E55CA83340; Sat, 24 May 2025 00:59:06 +0200 (CEST)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A58DC8334D
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 00:59:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=swboyd@chromium.org
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-233b1e4376fso3761085ad.0
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 15:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748041143; x=1748645943; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0lumZ1dxSw/t93pM430eLmqS4AlixwfOCV3AdNWk3QQ=;
 b=ZzQ3hhdBPAhUfPSmLys+yEUkcH+Qfor1oGyeo38rIVt/fHDSqUO4v88yLLvfvQ4hM9
 23xxnzcSx/eit7g+Kb7foq0ItCABcEDgeA5regRrmIY5QbvtjbjGdddgMHSpfJecdSqd
 +nDjLBKf8BH/rzWZn0478T4nnUYStOMwPLRcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748041143; x=1748645943;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0lumZ1dxSw/t93pM430eLmqS4AlixwfOCV3AdNWk3QQ=;
 b=FQWKIZ7PvP+2QHT4wOHifPJZodQ6G2THeEEg5oVKD46jtoproesDUBEDxW53ZB8uyx
 LhunH6cp6BmF50+dvN4hGBDJK0g7ZRYbe1TBWzW1xqVibeTYc7KwmkVKt1gMAt0ULXS6
 490WVRWMzEMey1qfMKNp/1NUYc/C10kMeCpAHgr96WK+wkWEoNBt+L3lsth3v5C6BO6J
 ZAVVGT69ibJxtS40z5pMe04r+aaLT9zfYo1a6Lw2fhWIlkH14+e7q4HpLdksrTDFc+Rp
 8jM3fsTCtO+ksdelKtz0QOXB6WU6dvN0BH+n0MImaTtdsC9+hhmtTRaJeEx/tCHqouYk
 XfYw==
X-Gm-Message-State: AOJu0Yyb4JrP2n1l98PDn1qE0FEVniLvFjpPe38deuVQxRJG0kIxDzKj
 2kwFyiGHl1+sg87hQL9MBabz2ryhTxgRrsE3xkZwt8dfykejph+pXZXWtonVmHryle7uViU0psU
 QdE0=
X-Gm-Gg: ASbGnctywKqZjzjklB5PZ1f/l4ulOMIFpUPLDlPBHcY5oi/NfTtCB6XLwYVlt8N5KK0
 qkTE0kqHz7HtMlQvYzJw5HUk98+SC+FhQqULpbDMDDOMq6yZI7a2E5uMAo1cwkbvz/hUjhO3J5a
 Bh+RE01UsP1XTdBgAFmEHyx8497kTISD7NaNpSnqUFHn7RfeaJIlhxUWiRb0T+4hA1LYp1YcWUj
 jHp+MCrRh9PuIot5rkjo959U6Swhq65zfzYjj79Xk/XIHaXdzpcL/vzFa530/pSf148CVOcm+vX
 1xgzZWXJ/3AjBSIHT0uSaSQLpneXPMUPCw2Wu7MG8TNPf9zJd+1SbTdfcA9WrJrVFdsVrEudB8v
 UvO3yLYAWukqMehQ=
X-Google-Smtp-Source: AGHT+IHPaZZGGntiyDd+TotITAXGDRJJHcp61k7VUmhogENfmMFGbe0W8eoHsv3SKKAV+EFJ56KNXg==
X-Received: by 2002:a17:903:3c2b:b0:22e:3c2:d477 with SMTP id
 d9443c01a7336-23414f9127dmr19096395ad.25.1748041142930; 
 Fri, 23 May 2025 15:59:02 -0700 (PDT)
Received: from localhost (188.139.125.34.bc.googleusercontent.com.
 [34.125.139.188]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-231d4ade028sm129547235ad.82.2025.05.23.15.59.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 May 2025 15:59:02 -0700 (PDT)
From: Stephen Boyd <swboyd@chromium.org>
To: u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
Subject: [PATCH v4 10/28] coreboot: Locate table earlier than arch_cpu_init()
Date: Fri, 23 May 2025 15:58:25 -0700
Message-ID: <20250523225845.2311989-11-swboyd@chromium.org>
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

Currently we locate the coreboot table in arch_cpu_init(). One of the
first things that happens in initcall_run_f() initialization is
fdtdec_setup() is called which could inspect the DTB for memory
information (see mach-snapdragon's board_fdt_blob_setup() code).
Introduce an initcall specifically to locate the coreboot table early on
in the boot process so that board_fdt_blob_setup() can know that the
memory is described in the coreboot tables instead of the DTB that's
either embedded in the ELF file or provided by the earlier stage
bootloader. This will also help in the future when we want to pick the
DTB from a FIT image based on the board and revision ID bits in the
coreboot tables.

Reviewed-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 arch/x86/cpu/coreboot/coreboot.c |  8 ++++----
 common/board_f.c                 |  4 ++++
 include/cb_sysinfo.h             |  7 +++++++
 lib/coreboot/cb_sysinfo.c        | 11 +++++++++++
 4 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/arch/x86/cpu/coreboot/coreboot.c b/arch/x86/cpu/coreboot/coreboot.c
index cd9ad22b3db3..e1dbce4f0b29 100644
--- a/arch/x86/cpu/coreboot/coreboot.c
+++ b/arch/x86/cpu/coreboot/coreboot.c
@@ -27,11 +27,11 @@ int arch_cpu_init(void)
 	if (ret)
 		return ret;
 
-	ret = get_coreboot_info(&lib_sysinfo);
-	if (ret != 0) {
-		printf("Failed to parse coreboot tables.\n");
-		return ret;
+	if (!gd->arch.coreboot_table)
+		printf("Failed to locate coreboot tables.\n");
+		return -ENOENT;
 	}
+
 	gd_set_acpi_start(map_to_sysmem(lib_sysinfo.rsdp));
 	gd_set_smbios_start(lib_sysinfo.smbios_start);
 
diff --git a/common/board_f.c b/common/board_f.c
index bff465d9cb2f..7e314b20c60e 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -12,6 +12,7 @@
 #include <config.h>
 #include <bloblist.h>
 #include <bootstage.h>
+#include <cb_sysinfo.h>
 #include <clock_legacy.h>
 #include <console.h>
 #include <cpu.h>
@@ -896,6 +897,9 @@ static void initcall_run_f(void)
 	 * For simplicity it should remain an ordered list of function calls.
 	 */
 	INITCALL(setup_mon_len);
+#if CONFIG_IS_ENABLED(SYS_COREBOOT)
+	INITCALL(coreboot_early_init);
+#endif
 #if CONFIG_IS_ENABLED(OF_CONTROL)
 	INITCALL(fdtdec_setup);
 #endif
diff --git a/include/cb_sysinfo.h b/include/cb_sysinfo.h
index 62a483e10cef..40d8030dbb8b 100644
--- a/include/cb_sysinfo.h
+++ b/include/cb_sysinfo.h
@@ -239,6 +239,13 @@ extern struct sysinfo_t lib_sysinfo;
  */
 int get_coreboot_info(struct sysinfo_t *info);
 
+/**
+ * coreboot_early_init() - locate the coreboot tables during early init
+ *
+ * Return: 0
+ */
+int coreboot_early_init(void);
+
 /**
  * cb_get_sysinfo() - get a pointer to the parsed coreboot sysinfo
  *
diff --git a/lib/coreboot/cb_sysinfo.c b/lib/coreboot/cb_sysinfo.c
index f8f2002d46f0..1ea4ec4a0487 100644
--- a/lib/coreboot/cb_sysinfo.c
+++ b/lib/coreboot/cb_sysinfo.c
@@ -465,6 +465,17 @@ int get_coreboot_info(struct sysinfo_t *info)
 	return 0;
 }
 
+int coreboot_early_init(void)
+{
+	int ret;
+
+	ret = get_coreboot_info(&lib_sysinfo);
+	if (ret != 0)
+		debug("Failed to parse coreboot tables.\n");
+
+	return 0;
+}
+
 const struct sysinfo_t *cb_get_sysinfo(void)
 {
 	if (!ll_boot_init())
-- 
Sent by a computer, using git, on the internet

