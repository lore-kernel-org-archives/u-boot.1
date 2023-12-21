Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08BDAC3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 00:42:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7B3387862;
	Thu, 21 Dec 2023 01:41:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wSamU8vD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8985A87876; Thu, 21 Dec 2023 01:41:20 +0100 (CET)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E42D87877
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 01:41:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-42782692142so1566481cf.3
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 16:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703119277; x=1703724077; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vlbcJO9n0QvtUtggYUmrQfarrIRZDAGJa9u89F7tE+Q=;
 b=wSamU8vDyV4q/4w4vwvY8dNlvP5a2XUQ8ke/9Sq7L/vSK0RXjvQRtVcfZy/28tSlEw
 jtW14tynRrMG31uyWjLOHwY3r4SY0xdFM/6cg3j95lLDKqY531VGIx5mbQz60dlVY7CM
 ZKgOnNP96A8eSCNuWkEa/4EmebVj8OClmmQokNtWfaBS3Mj8s796cAluICH3YUKZkDz2
 KiUdwZ022T7GGObxN9Oi/OBkVC5DuO+r8hTp1ySXHTHJdpGDs830ilzrbIMTnZyDTXwb
 nvm+NgXb/t+4Z+8aNsSiVBB/gz1K1qth9QBZaebsB0IqOrDeR9peL2R8g03vejk5Qdho
 XiSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703119277; x=1703724077;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vlbcJO9n0QvtUtggYUmrQfarrIRZDAGJa9u89F7tE+Q=;
 b=QyYoVxgQx9lDfOVOU96Ubqtr38JznWObZrUevR+fdcUtTX0UzN7J9x1HlaWkEvE2v0
 eMQPu1UySni18YtWfQAlLK88Dyzri1k/a8dOW6zayo42WSpCF8QtjwwjF3b7YCFZ408n
 7fBJJXhIHNiG6NBWQ1/BckquyOUTgd0fSn25+IyZSJaLY90gq58QYW2EGqLhZSx0VkeY
 RuBP8R/FbChRSMnFGg2kFSIdyhFyYt4BFHuAIgBihp59uxlgXzoz+Sulx61DKZcuDTAH
 sjmpnLx2TjwafaRJY2p33Sr2f+/Z8WZCfvAknr/2qZb9D2CuOBY1QXGYrLzhCOYIxIwt
 ruvQ==
X-Gm-Message-State: AOJu0YwX7uYBE5X87n4hQjgd+gQoJYvuTVM8tL5lJ1J0gYi27aLaSNiC
 llPDkjCt84r3N6kmn7+iixz8hjVI5WyvSdMtrTk=
X-Google-Smtp-Source: AGHT+IEHrT5PDQ14065PfrziL2oz6R1r9+LDKKovPGUktyi0SvE3KxHEJEgNLEvUPxdR9kN3TwK2PA==
X-Received: by 2002:ac8:5c90:0:b0:425:4043:96e9 with SMTP id
 r16-20020ac85c90000000b00425404396e9mr29055853qta.118.1703119276886; 
 Wed, 20 Dec 2023 16:41:16 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 fv9-20020a05622a4a0900b00419801b1094sm354184qtb.13.2023.12.20.16.41.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 16:41:16 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Kevin Chen <kevin_chen@aspeedtech.com>, Bin Meng <bmeng.cn@gmail.com>,
 Nikhil M Jain <n-jain1@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Devarsh Thakkar <devarsht@ti.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Shiji Yang <yangshiji66@outlook.com>, Baruch Siach <baruch@tkos.co.il>,
 Michal Simek <michal.simek@amd.com>, Stefan Roese <sr@denx.de>,
 Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v2 6/9] qemu-arm: Get bloblist from boot arguments
Date: Wed, 20 Dec 2023 16:40:25 -0800
Message-Id: <20231221004030.581388-7-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231221004030.581388-1-raymond.mao@linaro.org>
References: <20231221004030.581388-1-raymond.mao@linaro.org>
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

 board/emulation/qemu-arm/qemu-arm.c | 33 +++++++++++++++++++++++++++++
 configs/qemu_arm64_defconfig        |  3 +++
 2 files changed, 36 insertions(+)

diff --git a/board/emulation/qemu-arm/qemu-arm.c b/board/emulation/qemu-arm/qemu-arm.c
index 942f1fff57..20801d0750 100644
--- a/board/emulation/qemu-arm/qemu-arm.c
+++ b/board/emulation/qemu-arm/qemu-arm.c
@@ -4,6 +4,7 @@
  */
 
 #include <common.h>
+#include <bloblist.h>
 #include <cpu_func.h>
 #include <dm.h>
 #include <efi.h>
@@ -102,6 +103,9 @@ static struct mm_region qemu_arm64_mem_map[] = {
 struct mm_region *mem_map = qemu_arm64_mem_map;
 #endif
 
+/* Boot parameters saved from start.S */
+extern unsigned long saved_args[];
+
 int board_init(void)
 {
 	return 0;
@@ -144,6 +148,35 @@ void *board_fdt_blob_setup(int *err)
 	return (void *)CFG_SYS_SDRAM_BASE;
 }
 
+int board_bloblist_from_boot_arg(unsigned long addr, unsigned long size)
+{
+	int ret = -ENOENT;
+	unsigned long reg_fdt;
+	unsigned long reg_zero;
+
+	if (!IS_ENABLED(CONFIG_OF_BOARD) || !IS_ENABLED(CONFIG_BLOBLIST))
+		return -ENOENT;
+
+	ret = bloblist_check(saved_args[3], size);
+	if (ret)
+		return ret;
+
+	if (IS_ENABLED(CONFIG_ARM64)) {
+		reg_fdt = saved_args[0];
+		reg_zero = saved_args[2];
+	} else {
+		reg_fdt = saved_args[2];
+		reg_zero = saved_args[0];
+	}
+	/* Check the register conventions */
+	ret = bloblist_check_reg_conv(reg_fdt, reg_zero);
+	if (!ret)
+		/* Relocate the bloblist to the fixed address */
+		bloblist_reloc((void *)addr, 0);
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

