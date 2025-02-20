Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BE7FC021B2
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 21:05:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9145C810FC;
	Thu, 20 Feb 2025 22:02:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fMn/55bd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 699298006D; Thu, 20 Feb 2025 21:59:23 +0100 (CET)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BE608001F
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 21:59:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=swboyd@chromium.org
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2fc1843495eso2165949a91.1
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 12:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740085159; x=1740689959; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZHi7wzFqzVPh+xTmAPh7UC1OhjxgKhJ7+DqrbbrpfRQ=;
 b=fMn/55bdxFmlSpOpJARQcg9co4HAoMlKc519zVb77l1jH0Kwnr1LpZdPngvdel5Fly
 U2VstLPI+b75LzSeGDW1qbTrr1OuOmKj3PdtvAT/HEQi8fse7outSz2Ifmc21iaC8Z8v
 OIMS2S9VYaOJYpIeNEuZu/Vs1O78mAyZHDgB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740085159; x=1740689959;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZHi7wzFqzVPh+xTmAPh7UC1OhjxgKhJ7+DqrbbrpfRQ=;
 b=kxefJYqjkXa26/SQ89VD5H0fz4GV299IgHpFCygOrPlEfBf4LsP0sGCUzGkHpCGuGt
 YkaEUnewQs8P/vHYr9x34JCqMqHLARXpWaikdniFcAhoaesrrisWFGvMj7clWJGU5h3a
 IWwEMSQtCLPxwGdUpbQnvCIbJ0myPEx7KRvCh0TANbZzDJ5tZbHz8f2ZZizDAGuHKhgt
 +lgi8QDku/Pet0O2uC/LGvAix+Fmwop4i2m+oDuMpKbWVX/vu8JhlLdrxWUUFkZ2HO+j
 tazdC4A7hbWx4l9fEZdSYnzgz/Hjh2REsjJbP6VEyoVmSU9UU1fhV9HbkxCnYk1JCUsk
 OskA==
X-Gm-Message-State: AOJu0Yxh43zy5OY93eBDfTJKHhK5o2hPdsX/ZAMky5XhmpRl662KjYy7
 3O78E/VhnIJU0rSSK+enBdC21t4D4C+TJhFUsFXDR07Pef4F+V5vumHsRu/Em7psahiQrftNJL0
 =
X-Gm-Gg: ASbGncvKzRiH4SBuLpT8H8fmFHLFdMcWklQOwGLPwsFlA20AWjXA/5gnpbi+HGO5P7t
 pa4qLfTcNlHQG9zlTjrVyup8SjA3O5dSSaBA42yJV+iY45LfoaVSJB/v/DMGA+ROPTSb5NbyjsZ
 3usDzT0ylQIHtFGKXrTd6grY+bGezQmwg9gdk3lP0os4tc6kOL/yZz3JwvN5eFrpNlvVdyu9A6j
 +HFcrGDjW3NHmX8QntaiFcBcidraRAR4TTJqjcGaJ3qWRHsWHo8Mn8iwquGi1X/4+f0A8qUNLjm
 AGKAV75dDUf0DuJiaIVGS/haIA+TmOUwRbZmqG6U9D/YxJOi+gwsHkk=
X-Google-Smtp-Source: AGHT+IFl+DRCHnq/ZljICv/QQ7IOS1S+n0B9EPMa/0M88SkqhILvoWCZYvBZ+alm/tb17q9hL2Cyyw==
X-Received: by 2002:a17:90b:37c7:b0:2fa:157e:c78e with SMTP id
 98e67ed59e1d1-2fce76a26cfmr1036083a91.7.1740085159446; 
 Thu, 20 Feb 2025 12:59:19 -0800 (PST)
Received: from localhost (222.246.125.34.bc.googleusercontent.com.
 [34.125.246.222]) by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-2fc13ab103dsm14410815a91.6.2025.02.20.12.59.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Feb 2025 12:59:19 -0800 (PST)
From: Stephen Boyd <swboyd@chromium.org>
To: u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
Subject: [PATCH 12/12] mach-snapdragon: Support booting as a coreboot payload
Date: Thu, 20 Feb 2025 12:58:54 -0800
Message-ID: <20250220205900.3127680-13-swboyd@chromium.org>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
In-Reply-To: <20250220205900.3127680-1-swboyd@chromium.org>
References: <20250220205900.3127680-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 20 Feb 2025 22:02:17 +0100
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

Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 arch/arm/mach-snapdragon/board.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index f1319df43147..b410c2972fbd 100644
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
+		return dram_init_from_coreboot();
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
+		return board_get_usable_ram_top_from_coreboot(total_size);
+#endif
+	return gd->ram_top;
+}
+
 int dram_init_banksize(void)
 {
+#ifdef CONFIG_SYS_COREBOOT
+	if (gd->arch.coreboot_table)
+		return dram_init_banksize_from_coreboot();
+#endif
 	qcom_configure_bi_dram();
 
 	return 0;
-- 
Sent by a computer, using git, on the internet

