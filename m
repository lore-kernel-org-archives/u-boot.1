Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26257C369DC
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 19:28:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A7C982757;
	Mon, 28 Apr 2025 21:27:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YnTGUNEL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BC9D82132; Mon, 28 Apr 2025 21:24:57 +0200 (CEST)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 493CF80EFB
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 21:24:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=swboyd@chromium.org
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2295d78b433so56071695ad.2
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 12:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1745868293; x=1746473093; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q7vM9eXVVetOU2RTYxoukHh7g5LF1YG76H+8sBBj5Hc=;
 b=YnTGUNELZ1ULOOTg+P9wVQk6i03BhzX/VuDneU+f31CSthL+YvS/pWf6mmaFWndrIC
 4B3HPw3RkQy06uRyu1lRgSFjkhbA18ZAWCEb45bS5nHcUqqUzNHomGZVwczxG3XD3bgl
 B5/Y93pGe/X5hDfBTFSxtapjtK7lE7OjFbA+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745868293; x=1746473093;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q7vM9eXVVetOU2RTYxoukHh7g5LF1YG76H+8sBBj5Hc=;
 b=Tve8Dn4C0fGQeJo6uTfzgCoBL1UtClTEYRV+eGiRHlEvOh8Bm3e/s8JHUaiPwQzDCi
 zGrD2LP9OVdK2lSDlWF92wExfsqlaUTcYx3mHV1OqkZ28YiJR902EvoC7vE6YCjJGmKZ
 x8huW6Gg1WXrV2CcX9bmrsxdlNfuMaq7VFymWlOqryfoTzmm6XXjnrGaECHIm8CrWyGw
 MZse6QWEFHzdWAA4/lAWs3X6sN6xhjrJbnmpx3AOE3ZPgJ6oB/BJUaQbGVJMN2j5PeD7
 DLF8E1nG+66U0MvmTHpw/vx3pKDd/JRKOFV/TTUzAwUtmbs+HYEmjrd8dRk4eyJd5LhO
 NsqQ==
X-Gm-Message-State: AOJu0YzdwAIe0Detf+ZXtLmk6bnyVpjSuNYvgg4cpBPRWQyoSUVRwieG
 Ntv1SPx1x190Ql41IGZiLKQt0EA6jk77cBD9ParDSfyaI4i0p8T7po86TBzqOUwRIPiuyZL8kIM
 =
X-Gm-Gg: ASbGncvFIEYgr062hfeHZhhl5fJKSJJzq10U57C3yaPVALAQTP+W58GORk72O1PNgTS
 nh1sBjtTQtJFt4SbC5ljjDRW1hHVNeUApYwrZbDDDek6SSWQOBdKgAgPI4dQUamS0U3sRwhc2C5
 oRg67sQd0FLiKHURRtmIkwhNzCt0MM5e86VMhjCO17kUKnrw2lQjXRqtgWpUYXHXaLsYGPzpYcQ
 IpKXq2CqLypjTtIDJFvypHcCMT/O0xN9bBqkmvC5gTSKpeNdTodjOnaxHC4qpkApitFJq7NOhUd
 BTOeOtMrqRLPHw6u/PGS6EbQf622x6mySudyzeLAyulZ/m36udWU4afo/RrYEVr8nirE+L13zD1
 k9w==
X-Google-Smtp-Source: AGHT+IEI9I1T2XbCVIvvPtUauq2eIXR0k2ybNuH+ozWVk6lxSAwWAy+l2R28hR2dOBOWN0VZdVjPvw==
X-Received: by 2002:a17:902:e54b:b0:21f:2a2:3c8b with SMTP id
 d9443c01a7336-22dc69efc1amr150345955ad.11.1745868293637; 
 Mon, 28 Apr 2025 12:24:53 -0700 (PDT)
Received: from localhost (199.24.125.34.bc.googleusercontent.com.
 [34.125.24.199]) by smtp.gmail.com with UTF8SMTPSA id
 41be03b00d2f7-b15f7ec22cfsm7604541a12.23.2025.04.28.12.24.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Apr 2025 12:24:53 -0700 (PDT)
From: Stephen Boyd <swboyd@chromium.org>
To: u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
Subject: [PATCH v3 15/17] mach-snapdragon: Support booting as a coreboot
 payload
Date: Mon, 28 Apr 2025 12:24:22 -0700
Message-ID: <20250428192427.3877612-16-swboyd@chromium.org>
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

Coreboot sets up the DRAM, CPU, and devices before booting a payload,
meaning we can parse the coreboot tables at boot for memory info when
running as a payload. Use the memory descriptors from coreboot if the
tables are present so that Snapdragon SoCs can run U-boot as a coreboot
payload.

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 arch/arm/mach-snapdragon/board.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index deae4d323789..6850f226f8eb 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -14,6 +14,7 @@
 #include <asm/io.h>
 #include <asm/psci.h>
 #include <asm/system.h>
+#include <cb_sysinfo.h>
 #include <dm/device.h>
 #include <dm/pinctrl.h>
 #include <dm/uclass-internal.h>
@@ -48,6 +49,10 @@ static struct {
 
 int dram_init(void)
 {
+#ifdef CONFIG_SYS_COREBOOT
+	if (gd->arch.coreboot_table)
+		return coreboot_dram_init();
+#endif
 	/*
 	 * gd->ram_base / ram_size have been setup already
 	 * in qcom_parse_memory().
@@ -81,8 +86,21 @@ static void qcom_configure_bi_dram(void)
 	}
 }
 
+phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
+{
+#ifdef CONFIG_SYS_COREBOOT
+	if (gd->arch.coreboot_table)
+		return coreboot_board_get_usable_ram_top(total_size);
+#endif
+	return gd->ram_top;
+}
+
 int dram_init_banksize(void)
 {
+#ifdef CONFIG_SYS_COREBOOT
+	if (gd->arch.coreboot_table)
+		return coreboot_dram_init_banksize();
+#endif
 	qcom_configure_bi_dram();
 
 	return 0;
@@ -235,6 +253,11 @@ int board_fdt_blob_setup(void **fdtp)
 		ret = qcom_parse_memory(external_fdt);
 	}
 
+#ifdef CONFIG_SYS_COREBOOT
+	if (gd->arch.coreboot_table)
+		debug("Using coreboot tables for memory ranges\n");
+	else
+#endif
 	if (ret < 0)
 		panic("No valid memory ranges found!\n");
 
-- 
Sent by a computer, using git, on the internet

