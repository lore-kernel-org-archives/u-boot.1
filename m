Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A78DC369D5
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 19:27:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53C9B82918;
	Mon, 28 Apr 2025 21:26:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JGB6kSmq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33D258210D; Mon, 28 Apr 2025 21:24:45 +0200 (CEST)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC05D820FE
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 21:24:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=swboyd@chromium.org
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-22d95f0dda4so77601535ad.2
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 12:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1745868281; x=1746473081; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IiWapCmp00l3ec2RBkD7eMml6UDtFXkBKYOfIf4h0KM=;
 b=JGB6kSmqWBpD2bmodF+/J6DuMJ7X+Ao8o9W2C/17jGjNau9CUpa0+YDKqv7vE2ZAek
 peYAHfxPHS6Dc1E+IAqoktcdUoy8Z8HD7bkZ7vvGES5NlwO2UFtr5zB4tWorPs2LntyZ
 r2H6KYIOFePI2K8Qno85aSsHVGzYS6vLT0cD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745868281; x=1746473081;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IiWapCmp00l3ec2RBkD7eMml6UDtFXkBKYOfIf4h0KM=;
 b=RwSaOplhgvuNsOXg6NnT+cxom+9Gp8/LgqxIeBQFBlKeCRt1B/9vC8ppiqFyoblMYq
 DY1hVYNXp4Au41yUoqkGJGbRw4H/WEKZAVf3jn16Bejq/Z7EC4HvIFc2mx3aY9b3pgBH
 pTyTvnH61rp2ZljUQnSlPR+ZMLDGLk3B0v6UxuB7MTYArGyp7FGKDY8IIGAA9aa9YgkC
 Dsz9OVxfH9HMuNrI2gR2fnWDtwrcAxLnBgCrSIGKDJ4skYN4rLPFVeEcn7nCugsuuUQN
 WDzYoai3dHOP1OClRGo9THK8bnCKdoKNJDg+gYPZtzktn0Q+jXCzCyhm2K4IIf7hCGgn
 OS/Q==
X-Gm-Message-State: AOJu0Yw/gA/dKHqqTBdztaMrkYJFXya5Ek2CgCi8jz/RdfDDtSEWJMoS
 rMlOdj/d/KttjmDhvSg6DB6pyX76w/TwpDdCUKt6b8MTawZf9uLXauGleWdk86dzU171sZo6Ufw
 =
X-Gm-Gg: ASbGncsYcvAW4tTy65bwljeZx/Vy3KB7F9BQTa3Hivl8nRfvnMs0LGZ9EIAGIkhikKP
 R2i5/5jX02ltPYMJv5d3WJPnLkv5DZI+v44gkNwqIqN1qL4PO/xeOR6LsCEPwbglw+s8aQRHtlk
 waBx9ev98DaHG5//M6HpWZOmCDjakkXFhwk8FeTbt6xTk5kRPisX0xElGe7XAYjd/mXPFoSDMQd
 4st1ndTtGHyPBOHytPQu7tcVBbzNeXhpt3RHDZzKebqdhVm4z5sieo5XwM71nPO8eJzHAASB5tr
 pcRP3NlPfLNi4bxIqVd1eSBIrJuw+99WpgSDDM2Q9op9DYVOQ7uyVBlELMUpzw6Al5MLH+ViOAo
 m5w==
X-Google-Smtp-Source: AGHT+IH1ZyIeU+cznBvnq7Qt2VW74jXxSl8Kxcgteaa9phGkD413sJMZL+2bA78B0GzkjxQKW7+meg==
X-Received: by 2002:a17:903:22c3:b0:223:517a:d2a3 with SMTP id
 d9443c01a7336-22de6f9902cmr3858765ad.17.1745868281178; 
 Mon, 28 Apr 2025 12:24:41 -0700 (PDT)
Received: from localhost (199.24.125.34.bc.googleusercontent.com.
 [34.125.24.199]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-22db5216adbsm86813245ad.234.2025.04.28.12.24.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Apr 2025 12:24:40 -0700 (PDT)
From: Stephen Boyd <swboyd@chromium.org>
To: u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
Subject: [PATCH v3 07/17] coreboot: Locate table earlier than arch_cpu_init()
Date: Mon, 28 Apr 2025 12:24:14 -0700
Message-ID: <20250428192427.3877612-8-swboyd@chromium.org>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
In-Reply-To: <20250428192427.3877612-1-swboyd@chromium.org>
References: <20250428192427.3877612-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 28 Apr 2025 21:26:55 +0200
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

