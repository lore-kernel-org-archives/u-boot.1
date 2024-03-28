Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15316C54E67
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 11:44:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F65D88190;
	Thu, 28 Mar 2024 12:43:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Got5Af7j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 227F388124; Thu, 28 Mar 2024 11:06:54 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1ADC88103
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 11:06:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ivitro@gmail.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-41490d05bafso7748875e9.1
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 03:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711620411; x=1712225211; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=N6cWFynWi6h9ekuzcFCecD89N85bbfETptaHot1KCvQ=;
 b=Got5Af7j8jjtfycJMhMghHMeRUHD8CPyXuVMa7wcZQE6sjf5UDTsjCppGprg3dcrtn
 GqSqk4LgFYsahqKZKabXlsHucOtkBny1TIbloVOcb5y8D3ksQGkW9O161kDM8hmNx/dr
 kOnOJV1erQ8jx+is2De83zOZiaZq/1JKE8Pl3VyaEkLNrkzX7T2D8Biooy1B/Q3DAubN
 przKmvspYKgd+ifCaJcuwa2nsm1W78ZQB8agbxTlmXXrHGhTWnw/wGBwPDkMA1yZ2dO+
 QzGbglcSyv5RPeJJZFn2uSSeEefcGcrs9SWUGqaVvKhk3//8yPNBA1i18AP1HBvskh1y
 CjOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711620411; x=1712225211;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N6cWFynWi6h9ekuzcFCecD89N85bbfETptaHot1KCvQ=;
 b=RwHTg7OAlgJseCmDBEFT58BvylijUmSxhw23qnLAsK9hS2MZdoRy9vAf7BEtYTklDY
 0lWxyJlpavi4/GWc7T9fEfVqeNKddKvvQTwm99UQ/gxd4mN8CXYoAXL8okx0QpmY0r2Z
 MHAU9VBQ4p68zkv4po/G9idVGx2dDMfekQkIU/F8K2wtOUkTYH26uq6QdH+Zq9q/UC4m
 cTzjPQ2q4nRrGJtg1ZUpW6HzPHOhp9IyxthZ/ikGV3Hn/lOwXhid3bOkoeL8GeWgI8DQ
 9Oxk+YD3hbT1bS02sHVyBL3p4zWL58sX4Jiyl5f9aE8Gf9H+WhnyUHMhiM53uxFGfTH5
 JoAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTKUwAhv62wheS5Ffg/T3V8MA3NSXGdKJxauNrTt6Ni7hIi/TF3keujLSak+OqTsm3Y5K1oCtcVLCMVa1izeuleyjj+w==
X-Gm-Message-State: AOJu0YxdZaqmSHj71sgLrW10Gk+DpIiZhw732v3RXp4SH5nEhNWSeX/B
 dQvQn6TI+VaTQiB6KnTqRd1cjpI5pAHSokxrigQitaEV5gGY7AJvvQF9s9bC
X-Google-Smtp-Source: AGHT+IHYcGiAInwp4BHCq0Rl+GHMmizcud6xj6NL7vrls6S3WELICUyGPZYfmfGahB6vYyhRzDZoTw==
X-Received: by 2002:a05:600c:281:b0:414:5cec:a9dd with SMTP id
 1-20020a05600c028100b004145ceca9ddmr2529915wmk.38.1711620411148; 
 Thu, 28 Mar 2024 03:06:51 -0700 (PDT)
Received: from vitor-nb.. ([2001:8a0:e622:f700:d17a:a6e4:6bf1:e6ce])
 by smtp.gmail.com with ESMTPSA id
 m28-20020a056000181c00b00341d186a2dbsm1329898wrh.14.2024.03.28.03.06.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Mar 2024 03:06:50 -0700 (PDT)
From: Vitor Soares <ivitro@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: Vitor Soares <vitor.soares@toradex.com>, u-boot@lists.denx.de,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Alexander Graf <agraf@csgraf.de>
Subject: [PATCH v1] arm: mach-k3: common: EFI loader map memory below ram top
Date: Thu, 28 Mar 2024 10:05:48 +0000
Message-Id: <20240328100548.321634-1-ivitro@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 28 Mar 2024 12:43:31 +0100
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

From: Vitor Soares <vitor.soares@toradex.com>

During the boot, the EFI loader maps the memory from ram_top to ram_end
as EFI_BOOT_SERVICES_DATA. When LMB does boot_fdt_add_mem_rsv_regions()
to OPTEE, TFA, R5, and M4F DMA/memory "no-map" for the kernel it produces
the following error message:

ERROR: reserving fdt memory region failed (addr=9cb00000 size=100000 flags=4)
ERROR: reserving fdt memory region failed (addr=9cc00000 size=e00000 flags=4)
ERROR: reserving fdt memory region failed (addr=9da00000 size=100000 flags=4)
ERROR: reserving fdt memory region failed (addr=9db00000 size=c00000 flags=4)
ERROR: reserving fdt memory region failed (addr=9e780000 size=80000 flags=4)
ERROR: reserving fdt memory region failed (addr=9e800000 size=1800000 flags=4)

To avoid this, don't flag with EFI_BOOT_SERVICES_DATA the memory from
ram_top to ram_end by the EFI loader.

Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
---

Similar fix for the same issue can be found at
https://lore.kernel.org/all/20240308101230.2595220-1-patrice.chotard@foss.st.com/

 arch/arm/mach-k3/common.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
index b54f2ddc47..80e89b2a16 100644
--- a/arch/arm/mach-k3/common.c
+++ b/arch/arm/mach-k3/common.c
@@ -24,6 +24,7 @@
 #include <asm/io.h>
 #include <fs_loader.h>
 #include <fs.h>
+#include <efi_loader.h>
 #include <env.h>
 #include <elf.h>
 #include <soc.h>
@@ -607,3 +608,14 @@ void setup_qos(void)
 		writel(qos_data[i].val, (uintptr_t)qos_data[i].reg);
 }
 #endif
+
+void efi_add_known_memory(void)
+{
+	if (IS_ENABLED(CONFIG_EFI_LOADER))
+		/*
+		 * Memory over ram_top can be used by various firmware
+		 * Declare to EFI only memory area below ram_top
+		 */
+		efi_add_memory_map(gd->ram_base, gd->ram_top - gd->ram_base,
+				   EFI_CONVENTIONAL_MEMORY);
+}
-- 
2.34.1

