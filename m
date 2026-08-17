Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42B04C5DF7E
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 18:18:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0A377811DC;
	Mon, 17 Aug 2026 18:18:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0ttxFzuzo5cV; Mon, 17 Aug 2026 18:18:00 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2752A810D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786990671;
	bh=dU4nGrOCs5k9OFxI21N/JRkk8KfChc5jPzMDlD8OPaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FaeyoqBQbuqnS7gACVgfdAAzzUivhRzIprLMaFoFheykLkxDjh4OF/pVpw0aCU0aI
	 jqq8mOuzlVfhkGC5TGN+yJvVbZdHDZLQYrJjNhViiGwMiGdyFGhJ4uUgTqsEwJWv0h
	 W/TKM4xQkYoFA01tDcBPbaIwdd0AYgZn2a8xSYy/Hxoimyz4ROgP7XpZAHuGdZR/lF
	 8BQS4kf++Jw88TxXEPWwfVAcfxPh5I9J4qxbqYrsiMdshtNHJZh4sC2exiryu9lN6o
	 VCJr0wnwqIrkC9VyKEGRdPaq6qrBuXcgvqKrM6lXAFVVaVCO1EOrE/fSw+KnfjQGvP
	 r4UaIEAd7zIuA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2752A810D1;
	Mon, 17 Aug 2026 18:17:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9AE1F282
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 17:16:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8C32A40589
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 17:16:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AJpMFwfPI1tO for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 17:16:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::735; helo=mail-qk1-x735.google.com;
 envelope-from=sanderson@brivo.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org BB93140566
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=brivo.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BB93140566
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=brivo.com header.i=@brivo.com header.a=rsa-sha256
 header.s=google header.b=zW/OcvOL
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BB93140566
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 17:16:37 +0000 (UTC)
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-92e50a650a0so204144585a.1
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 10:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=brivo.com; s=google; t=1786986996; x=1787591796;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dU4nGrOCs5k9OFxI21N/JRkk8KfChc5jPzMDlD8OPaA=;
 b=zW/OcvOLzCSSYiFalXM5Y4yisz2PvBB74oG3kdvwx2xG/wkLxE/0LQod3izLSd6dQg
 UHqGbQf6K12E/4Ix31SHopyogJ2SmfSgUdpsKu0S4eHU9zAuBnMyHChPkTIrRItj3Xff
 dEOoa4SbfjPTM9r+hWidahzQdJxA8hQFSvTNqhNcoZhxEJG/JeOr2T2kC0cxsV9yFar5
 PlvVZZ7iwgcr+w4qJrx5BZzq8qvK4DHj59iApRoXe45CV02HzMcrrXH0QVTXN9pTpnhR
 vmklCkR4S84AEVabBDmaiZbjXxRHw3cNGioFEzPYKLzy/04yBPewXyBQLfrclZ6duCgB
 obZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786986996; x=1787591796;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dU4nGrOCs5k9OFxI21N/JRkk8KfChc5jPzMDlD8OPaA=;
 b=kPONYyZYkJuZ1xh50yuFkiXstLGsmIKYyZP+LkfHDoVP87GT3bxGXvjmZqQhFdoAC6
 IIsSwsQ0Z2iTOqB+D3TdyZe8My1EF0UpWX5wECHxLIsTSs+jkZcxvJKB12MdetyGRZqw
 NwX1KvUI+jkwcRLNgUpkAs10gk70fYAcFXywzQgavKdkRf5eb+v4Jr7qPOKEg0mKvJVH
 ab8nqy4yfxAXv+qv3AjDcLlZZBolTRF8hKj8gujA4nPPiz3FJf3pGEAaPLnqHKZjtgRY
 2FGOAZxFOMr/F26ky8XEpZw3X1sLY9OP8fL8uoy1rowLE5LWc2++fa9ImaeBGvuZ3Xz+
 A6yw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp22FaRtloPYLKhgafbab5gXLdR0PDv95RjgiGmDlx4bLff3wPkdGtGYg574Tvs+iooaQ92Syw=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxdvjD/du+TmBaflgsjy1HsnS+fDMp/FT47pYQXefrrotIRo0x/
 EX2Qr9FeZDRJFf+s5CC808eoVFAPNM41pcBiNvqU1Spbrolz/ZNASbZQYrhG00QbwUQLKDK1qGq
 5bRwlFvGDn0gPAIB2MRl2mxXiW8e7Tc4hfg3s3spQvm8r3f4JI1pWUtVyhUJiTs0=
X-Gm-Gg: AR+sD11wnGhbDHcELJ41VZqNyh8GZVJa2y1kfBOzD3vyrAAanQiz+wqULPJTEjRPUu8
 hvrJfyvB7+a9KKhF9tcA3EIcAEruDEhvd/HAK3X0DAEApDyXdS9vN1vjuOpQTsJPQOeOb5VZHoP
 NRAf8w91p3uGShv4zPeO99XDC51PgiJTfOlJGyx5TXweeclEyU1rdxBef0Q/IfgVUB6mym4ci2p
 KJRCJc2yMV+U9pzPHcUIiMR4Rr3h6q4ldjkNiEefMwGPGlBCRLnX6Ofv/aClRG34F6SKMxlTODN
 fjpXhMdlAeVvO514hkrr/Gc3Sf5sx9Bk21kBidAEvE4oQ4M16CvT9esUeuujoJRBA6ESYHgo3aF
 XNikrQFpNcJONv0SI9pyv/W2JtsNfbYb0ZweCfSEQgih07y2ws5pNXLJi6viyF4d+FLTplJEhC8
 ZkriVXLELqoGiJMee5Ean1O7IP++TMvKYgOpWgoQLu60S6WfyKgKyP1lsunYUwxQeuH3of6utsu
 J+LA/2Gxyo3JIuOZdt6l8+WOhd64zIj+YiddL8=
X-Received: by 2002:a05:620a:800f:b0:936:41fe:2350 with SMTP id
 af79cd13be357-93704b1a810mr288061685a.4.1786986986613; 
 Mon, 17 Aug 2026 10:16:26 -0700 (PDT)
Received: from strozzi (ec2-54-236-161-35.compute-1.amazonaws.com.
 [54.236.161.35]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90c459783a9sm13637976d6.43.2026.08.17.10.16.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 10:16:26 -0700 (PDT)
From: Sean Anderson <sanderson@brivo.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.u-boot-project.org
Cc: u-boot-amlogic@groups.io, Tom Rini <trini@konsulko.com>,
 Sean Anderson <sanderson@brivo.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH 1/9] arm64: meson: Add s4 SoC support
Date: Mon, 17 Aug 2026 13:15:12 -0400
Message-ID: <20260817171623.1943847-2-sanderson@brivo.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817171623.1943847-1-sanderson@brivo.com>
References: <20260817171623.1943847-1-sanderson@brivo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 17 Aug 2026 18:17:15 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Add support for amlogic s4 (S805X2/S905W2/S905Y4) SoCs. These are very
similar to other recent SoCs, with the exception of a workaround for
some BL2 (mis)behavior.

Signed-off-by: Sean Anderson <sanderson@brivo.com>
---

 arch/arm/include/asm/arch-meson/boot0.h | 14 +++++++
 arch/arm/mach-meson/Kconfig             |  7 ++++
 arch/arm/mach-meson/Makefile            |  1 +
 arch/arm/mach-meson/board-s4.c          | 50 +++++++++++++++++++++++++
 4 files changed, 72 insertions(+)
 create mode 100644 arch/arm/include/asm/arch-meson/boot0.h
 create mode 100644 arch/arm/mach-meson/board-s4.c

diff --git a/arch/arm/include/asm/arch-meson/boot0.h b/arch/arm/include/asm/arch-meson/boot0.h
new file mode 100644
index 00000000000..7338171be15
--- /dev/null
+++ b/arch/arm/include/asm/arch-meson/boot0.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2026 Brivo Systems LLC
+ */
+b reset
+#if IS_ENABLED(CONFIG_MESON_S4)
+/*
+ * BL2 copies some keys to the start of DRAM, clobbering anything in the first
+ * 2k aside from the initial instruction. I measured the actual data clobbered
+ * as 1076 bytes, but I suspect the amount depends on the configuration, so
+ * just go with what amlogic does.
+ */
+.skip 2048
+#endif
diff --git a/arch/arm/mach-meson/Kconfig b/arch/arm/mach-meson/Kconfig
index c687ef822a2..91d1e8342e0 100644
--- a/arch/arm/mach-meson/Kconfig
+++ b/arch/arm/mach-meson/Kconfig
@@ -67,6 +67,13 @@ config MESON_A1
 	help
 	  Select this if your SoC is an A113L
 
+config MESON_S4
+	bool "S4"
+	select MESON64_COMMON
+	select ENABLE_ARM_SOC_BOOT0_HOOK
+	help
+	  Select this if your SoC is an S905Y4/S905W2/S805X2
+
 endchoice
 
 config SYS_SOC
diff --git a/arch/arm/mach-meson/Makefile b/arch/arm/mach-meson/Makefile
index 08a24d4b24f..2157c35c2d5 100644
--- a/arch/arm/mach-meson/Makefile
+++ b/arch/arm/mach-meson/Makefile
@@ -17,3 +17,4 @@ endif
 obj-$(CONFIG_MESON_AXG) += board-axg.o
 obj-$(CONFIG_MESON_G12A) += board-g12a.o
 obj-$(CONFIG_MESON_A1) += board-a1.o
+obj-$(CONFIG_MESON_S4) += board-s4.o
diff --git a/arch/arm/mach-meson/board-s4.c b/arch/arm/mach-meson/board-s4.c
new file mode 100644
index 00000000000..7d0bea9924f
--- /dev/null
+++ b/arch/arm/mach-meson/board-s4.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * (C) Copyright 2023 SberDevices, Inc.
+ */
+
+#include <asm/armv8/mmu.h>
+#include <asm/io.h>
+#include <linux/compiler.h>
+#include <linux/errno.h>
+
+void meson_init_reserved_memory(__maybe_unused void *fdt)
+{
+}
+
+int meson_get_boot_device(void)
+{
+	return -ENOSYS;
+}
+
+static struct mm_region s4_mem_map[] = {
+	{
+		.virt = 0x00000000UL,
+		.phys = 0x00000000UL,
+		.size = 0x80000000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+			PTE_BLOCK_INNER_SHARE
+	}, {
+		.virt = 0x80000000UL,
+		.phys = 0x80000000UL,
+		.size = 0x7FE00000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			PTE_BLOCK_NON_SHARE |
+			PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/*
+		 * This mem region contains in/out shared memory with bl31,
+		 * hence it's marked as NORMAL memory type
+		 */
+		.virt = 0xFFE00000UL,
+		.phys = 0xFFE00000UL,
+		.size = 0x00200000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+			PTE_BLOCK_INNER_SHARE
+	}, {
+		/* List terminator */
+		0,
+	}
+};
+
+struct mm_region *mem_map = s4_mem_map;
-- 
2.53.0

