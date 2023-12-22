Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA07BC4706F
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 21:32:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A22298784E;
	Fri, 22 Dec 2023 22:32:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LFXmuzkm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74F56874D5; Fri, 22 Dec 2023 22:32:10 +0100 (CET)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58B398784E
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 22:32:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3bb8977162aso863532b6e.2
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 13:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703280726; x=1703885526; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MhINwHp3iYV305XDyq272N0fwqaB+75Ty9O+gTlw/pI=;
 b=LFXmuzkmR8ByQW0MAiO6AdUeBZVzrQgn8YK9iQ8puXszVJmlXPG8SRpvrZ8otp1Hxn
 pFOspiRBY+amKer2V2YpIBkJJwr5k/CuScgzVTnNw4/HueTV8CGWXHmYJuvU8Ib2TW5N
 DCHLXAGjVl29iMHYeCQm7zdqnHRr48Ns5uEqzxLn7QGUew21sjrHdN/6ljr3aVSuS5l4
 mjNBf0inul6EE17WBP2t7Nj8AgikdyVhHcIuYZJVJS51AHrhF2KoAc9GZ0+3m8m6lZSR
 +UMtHnjmys/Pi0Sbios9M9gMaj6QqAcLes/LMm13jMuYU5i60lXqPFF47y3oxLQuOWUP
 CgMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703280726; x=1703885526;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MhINwHp3iYV305XDyq272N0fwqaB+75Ty9O+gTlw/pI=;
 b=NV10wu5yK5TFZZiYK2vr3USob/7CSKaZz6RoW32ceVNRKcqdMLp+aNEZ/SAN6amFNU
 iiGBrlwmWpcAAjOfg/8bTeQZMCLwT+MxAv7hAzQlvYAbN7csdWPI+bi2i7PmlXA30yGk
 F9gLvDHaUJ+hO8mwPQ6qyDxrvzKjHISEzEz1pRVPadSmRk/oOnOlJZWeqNsecppWVKZu
 h5AiPQX0k96W9xmJImr1NILj8OFlD4sIXSFeH/ZsU27wJ0oDV2pwS8gRK16OQOQJLusS
 Fv7SApT/90ULsF1U+j2qMFpD1MxuiYlYtQNxAKoANHDVYYe4gJS/doC9raOlb+zUqax2
 GoMw==
X-Gm-Message-State: AOJu0Yzh2/sqeTBxvNlL44wU3hh2wucg2+y2qY6d1j/p7XKJfjxjM7K6
 8Gjg+x1OtiE2+k1ty1yAnL6hIDnFq9ta2/s2tEAIFteHpCE=
X-Google-Smtp-Source: AGHT+IEU7KJ39NI92CGekwYYWjzZPdnkSGyo9Wz4aLkbPspsnv7H9jMz7k2oi9jxgPGupqgYpMNaAA==
X-Received: by 2002:a05:6808:98:b0:3bb:6dfc:c0b0 with SMTP id
 s24-20020a056808009800b003bb6dfcc0b0mr1805604oic.37.1703280726655; 
 Fri, 22 Dec 2023 13:32:06 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 dm6-20020ad44e26000000b0067f6ec98ae9sm1623096qvb.32.2023.12.22.13.32.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 13:32:06 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Kevin Chen <kevin_chen@aspeedtech.com>, Bin Meng <bmeng.cn@gmail.com>,
 Nikhil M Jain <n-jain1@ti.com>, Shiji Yang <yangshiji66@outlook.com>,
 Devarsh Thakkar <devarsht@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Baruch Siach <baruch@tkos.co.il>,
 Michal Simek <michal.simek@amd.com>, Qu Wenruo <wqu@suse.com>,
 Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v3 6/9] qemu-arm: Get bloblist from boot arguments
Date: Fri, 22 Dec 2023 13:31:06 -0800
Message-Id: <20231222213110.660402-7-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231222213110.660402-1-raymond.mao@linaro.org>
References: <20231222213110.660402-1-raymond.mao@linaro.org>
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

Add platform custom function to get bloblist from boot arguments.
Check whether boot arguments aligns with the register conventions
defined in FW Handoff spec v0.9.
Add bloblist related options into qemu default config.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- Remove low level code for copying boot arguments.
- Refactor board_fdt_blob_setup() and remove direct access of gd->bloblist.
Changes in v3
- Optimize board_bloblist_from_boot_arg().

 board/emulation/qemu-arm/qemu-arm.c | 30 +++++++++++++++++++++++++++++
 configs/qemu_arm64_defconfig        |  3 +++
 2 files changed, 33 insertions(+)

diff --git a/board/emulation/qemu-arm/qemu-arm.c b/board/emulation/qemu-arm/qemu-arm.c
index 942f1fff57..e225011bf0 100644
--- a/board/emulation/qemu-arm/qemu-arm.c
+++ b/board/emulation/qemu-arm/qemu-arm.c
@@ -4,6 +4,7 @@
  */
 
 #include <common.h>
+#include <bloblist.h>
 #include <cpu_func.h>
 #include <dm.h>
 #include <efi.h>
@@ -102,6 +103,15 @@ static struct mm_region qemu_arm64_mem_map[] = {
 struct mm_region *mem_map = qemu_arm64_mem_map;
 #endif
 
+/*
+ * Boot parameters saved from start.S
+ * saved_args[0]: FDT base address
+ * saved_args[1]: Bloblist signature
+ * saved_args[2]: must be 0
+ * saved_args[3]: Bloblist base address
+ */
+extern unsigned long saved_args[];
+
 int board_init(void)
 {
 	return 0;
@@ -144,6 +154,26 @@ void *board_fdt_blob_setup(int *err)
 	return (void *)CFG_SYS_SDRAM_BASE;
 }
 
+int board_bloblist_from_boot_arg(unsigned long addr, unsigned long size)
+{
+	int ret = -ENOENT;
+
+	if (!IS_ENABLED(CONFIG_OF_BOARD) || !IS_ENABLED(CONFIG_BLOBLIST))
+		return -ENOENT;
+
+	ret = bloblist_check(saved_args[3], size);
+	if (ret)
+		return ret;
+
+	/* Check the register conventions */
+	ret = bloblist_check_reg_conv(saved_args[0], saved_args[2]);
+	if (!ret)
+		/* Relocate the bloblist to the fixed address */
+		ret = bloblist_reloc((void *)addr, CONFIG_BLOBLIST_SIZE);
+
+	return ret;
+}
+
 void enable_caches(void)
 {
 	 icache_enable();
diff --git a/configs/qemu_arm64_defconfig b/configs/qemu_arm64_defconfig
index c010c25a92..418f48001c 100644
--- a/configs/qemu_arm64_defconfig
+++ b/configs/qemu_arm64_defconfig
@@ -69,3 +69,6 @@ CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_PCI=y
 CONFIG_SEMIHOSTING=y
 CONFIG_TPM=y
+CONFIG_BLOBLIST=y
+CONFIG_BLOBLIST_ADDR=0x40004000
+CONFIG_BLOBLIST_SIZE=0x4000
-- 
2.25.1

