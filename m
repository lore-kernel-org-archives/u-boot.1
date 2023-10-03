Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5679BE7542B
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 06:39:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7588987480;
	Tue,  3 Oct 2023 08:37:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NqLfJJFu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBF3787258; Tue,  3 Oct 2023 08:37:14 +0200 (CEST)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E20587442
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 08:37:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2c296e6543fso5930461fa.3
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 23:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696315025; x=1696919825; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bygunJWYl1ElIdCSMdreG1O6wMAtNDcf5g2o+t8Lc9E=;
 b=NqLfJJFu5goTQsYWEkPcVVrecyIMcrnIP5u/5LaW7qJ5GlEYCkc8r9UDSpz/3d0H9i
 qkcbWMdmWjN5O8hoN+YiVEsx8xHJMsDw8uoURT1ki3ntx3DTVJQUWXfB44hFAcWQOQGt
 rgiBeB8ipeaJxpvaeHj0bdIqSBzl0XqHc7b7aHBSVugPylsGCQCRIgnQTX+77gjO8l0x
 JK9ojbfEZR0UIv0brEG+2B7VThCL+EtN9n4qVNVOp+sqgW7fcJyp3u/QWfeDTL/mHzxB
 lgvkSidM55VlZJDta/l/IeBK7vRbdeD0s1E6rZlaouffrpETLjp86/4519i1nYzUOMAK
 U/Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696315025; x=1696919825;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bygunJWYl1ElIdCSMdreG1O6wMAtNDcf5g2o+t8Lc9E=;
 b=jGLxY9NsX5ynB+OZ0JFAyUB3ivZa2TrKcFr9Nl91Lx43QdeDUglmsn0mq92tAM5kpB
 WTtvOLpc3eCAm+PjjgctC0ohW4gf0mumm9ANooKowWMI3tdIljbQ/U5cP/qF9R3xoCTl
 Z5dK1A/jqK1Zl+erpikvC4LREeaxbMHWd0tlaDFjPtwSxGaFO0PUzo/mKlDM+LWr6fAW
 7EgtpjG1Vkz0a/qaynm6d+zn6p+Alg7nmg7lF4v72jOYuSt6JPB/N5MFXPS5ieoQMORl
 SJGz+GydDiLuftFyyxvn2nrNH8xqHfaF8Z0wfSVpflwTfUwjjoi4/VRAnUaqaNEw2nBi
 5WCQ==
X-Gm-Message-State: AOJu0YysfTrwdkWC4v0Qu8UskLuoOBfI3/vFDjRBZENEU1m5JoCmxKgr
 ed2tqM8bgHrbD4Aa00vt8mI=
X-Google-Smtp-Source: AGHT+IEQEnDvj7un/KbPit2cuSy5zcHRgyN38p32mNGkwL7RF0JGv/xxLR4O+G4SJwkectoViYS0eA==
X-Received: by 2002:a05:6512:2037:b0:503:33ab:8126 with SMTP id
 s23-20020a056512203700b0050333ab8126mr11005216lfs.17.1696315024831; 
 Mon, 02 Oct 2023 23:37:04 -0700 (PDT)
Received: from xeon.. ([188.163.112.76]) by smtp.gmail.com with ESMTPSA id
 s1-20020a19ad41000000b00502b04e2722sm79636lfd.3.2023.10.02.23.37.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 23:37:04 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v3 12/16] ARM: tegra114: enable base voltages setup from board
Date: Tue,  3 Oct 2023 09:36:43 +0300
Message-Id: <20231003063647.42770-13-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231003063647.42770-1-clamor95@gmail.com>
References: <20231003063647.42770-1-clamor95@gmail.com>
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

Tegra 4, same as Tegra 3, requires configuration of CPU and CORE
voltages in the SPL stage to boot properly. Expose function to be
able perform this configuration in the SPL section of the device
board.

Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # ASUS TF701T
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/mach-tegra/tegra114/cpu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-tegra/tegra114/cpu.c b/arch/arm/mach-tegra/tegra114/cpu.c
index 62c1053630..7d8f080c31 100644
--- a/arch/arm/mach-tegra/tegra114/cpu.c
+++ b/arch/arm/mach-tegra/tegra114/cpu.c
@@ -13,9 +13,13 @@
 #include <asm/arch/tegra.h>
 #include <asm/arch-tegra/clk_rst.h>
 #include <asm/arch-tegra/pmc.h>
+#include <asm/arch-tegra/tegra_i2c.h>
 #include <linux/delay.h>
 #include "../cpu.h"
 
+/* In case this function is not defined */
+__weak void pmic_enable_cpu_vdd(void) {}
+
 /* Tegra114-specific CPU init code */
 static void enable_cpu_power_rail(void)
 {
@@ -254,6 +258,7 @@ void start_cpu(u32 reset_vector)
 
 	/* Enable VDD_CPU */
 	enable_cpu_power_rail();
+	pmic_enable_cpu_vdd();
 
 	/* Get the CPU(s) running */
 	enable_cpu_clocks();
-- 
2.39.2

