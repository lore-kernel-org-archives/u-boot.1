Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB3C606A31B
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 23:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=GF61Nirk;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=AayKTq8x
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 39FCD6085F;
	Thu,  5 Nov 2026 23:46:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8p3C-pdFFsfY; Thu,  5 Nov 2026 23:46:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 57187608AC
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793922405;
	b=GALNRSg8mDsddDd0xfCEzbg7GEwyG7kBvtbzeoXjh5pOUGxALDuWJ6nHQNQ/MjZue4qH
	 Ogzuk3bFHslBjZBKhV9r19gP487EC9R0tgPxONyh+GDJt7+1h+Z8buTRrfsMfF8emyEnf
	 JhJb+bAPqSZf5hzcZHlbJN1ynG++hfdt0QPRBnBCR6l7qdabrzW5uXZPY6W2TE+dM1TEU
	 VG380f5/QJFw1Lu+UIh0/p7o4EDH6Uaznu6NZsceOOJ3U68Qqcd4lyPHewb9EH07iZjnk
	 RMbWGAI6YiwUjDZle6Grnf0SHiRrh4faYh3jyV5YtWZJ/tsFTLBMBk3VR1vBtlS/V9Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793922405;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=a6TLqdjfm7thWVBHOymAOZo+hYsOhnqLDB+BgV65+j8=;
	b=XLojbGG7bMpZQsT0dbZGixOcceo/wWhlec08XDJusHetomgJU4M66liQ5+Mf+l0/pJ7I
	 EmyNeAqN7nbXl8yIBpT6mEGz4RTx2vdnBlojnIIsNrRRhz4Hkam7BUaV4O2l0rHYH2Feq
	 iiyMF0j0l2dmdPi0q4fIZvz4NEpVCdOYj3ZmbD6jpYuYaG7wwOxO7/clBcleV5wJZP8cR
	 OFg1uOj5SrK22y+DSLklJ+NPp/jhVi+t5qSjr025WZcDxY9kc5Rj8jL3gCjlq0p2qDqtV
	 WBoXHhQkK1zidWE6wb+A/Axk9CvdPSBI+emSE6/LRbt4Jv3iRs99kMUBh+N4eqQdxrg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793922405;
	bh=a6TLqdjfm7thWVBHOymAOZo+hYsOhnqLDB+BgV65+j8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GF61Nirk0+XcPObeUHLvtnsDj3GWk/+IYv2npe6CBKlR3xO7+OTsoqq2Tt+VAy1xb
	 gEKM9Zr6fugARyCmHjogOvkWtcgbXP/hHuMNDKyeZ8XsKkDRAJwO/bMTGTMwVyOVex
	 E9QsUfWPcwNBQPSVxob4ZIJpVxeXTntJWBJhu1pgR6oPUJbvu87GEvb8AlIY3R6Mpr
	 aMXj8BiSe12EoKMb+HK7fiJvcZG0ISBPOFhtpKCiY7fQsS7swRdVVQ2NHWrlAFVxPY
	 0DTldKchKDA8QIgoaW+JxCEJ0+D+2S1h4DVnL3VxbiS7LTACkpEO2vaGONA5RRedJ3
	 YDSd/YliH619g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 57187608AC;
	Thu,  5 Nov 2026 23:46:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id DD4DA211
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 23:46:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CF2BF40378
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 23:46:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tDBgSOX3uqM7 for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 23:46:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 0785C4010C
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32a; helo=mail-ot1-x32a.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=AayKTq8x
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0785C4010C
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 23:46:36 +0000 (UTC)
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-843cf077f10so200545a34.1
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 15:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793922396; x=1794527196;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=a6TLqdjfm7thWVBHOymAOZo+hYsOhnqLDB+BgV65+j8=;
 b=AayKTq8xZzMKSPEiIEEh5zhoHE6wFVicN1AExE9617bLtsMAXx5F6aSgdjOtlt+9QP
 d8BhcqPuKJG5wyvZZin1trAXJ+zHPIcNkpJNxB16GzG5K3c4Q+x/1HBjhGRz0bYf1YVr
 t/7KLTf5dvys0ngljbBg9yhI0OKBDnIOecdaQ3MPFagJ4eQz0aCjsqyOg6xB395BSrwW
 UIva6MUgyNZkA9shPmQ3f4weczuu7ooXTdyexG//v/6eJ+JKNpjXyBaLfVlb+9vvfDrU
 c9nzLd0hIoXuLwkJTMdT6J0mjt3ZqfEvepugm95yr8ieymWL1Jn4Sn3jXfSc9bAv1fXz
 W6eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793922396; x=1794527196;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=a6TLqdjfm7thWVBHOymAOZo+hYsOhnqLDB+BgV65+j8=;
 b=AsReMn5iycijKjaaub6ynOt/xKQ6EJ4lLO5k7tsFuOKXqt18qNy0dowXTjKdChjl5Y
 D1GT2Cz3+Ff/EW2IRdyDgEOMqxvgZIZrXEl7mQ90anB/8hfYsPjvtPk5Gf7nRDKmjg/g
 BDAoi8VYBTNiCxEc+f+UGVPBYZQqk3kQ4QIwwRZQPQnRlJ2JKr364jrv5jJEPGO+aE+t
 Sv5onxiNw6zGwUZFlZLbWi+ZWne+f70YDQS3wo3aw7UsH+DibtrU0zGvHdtUV18LEtIZ
 4xkSWj5G+qXfrqwU9MkUTSdcCc33LzJLtpmdIGHR2n68KOpN5iIf6Em130Np53U5DlgA
 8/Vw==
X-Gm-Message-State: APuU4Z/xZ5bub4FZVgLa3VA/rTfIFGp1A4+afu800+TT/DDxk8WseV5m
 v71Orh3xXefx0fcNp6CTZFaGsPSdT7Noh0lm/rbhCVIzl1+YJYkY87bQYmfyNysnoIY=
X-Gm-Gg: AYBFou0KaOI4pKoj8CkwLiUiSumMTalB6jRJew7LDJuhnI5FgOYY7FzRT2zAMQ6tpGA
 IJ/EqHVd2PhHQQNVNKqLlIfAI3NxAnEBo/CsPai4PYln0IgvdZRnlnQV3xmnijswnwrDcacvRlB
 QNtCBffTGgd8v31UaUbc84pfR3oU8H+xfOLSlGvaCPWTRl//vJEjVjSLOKH1Hy0KDJ3mPKM/NFQ
 MnQIO6cXtS8LyuN+pBQupsrVHCAIPVBPoXJwlvy/aj6+7syr0aTTUzTn4gamFJqqumLyrjhvw6L
 Sl2lpBHzAVSYWYw+1fz49Sl0ViCfCNzPY5NYdISMoYGar4z8uhcEUvXz+RpfxAUSSph7Jxp7Elc
 EW0HUlhZazE2SHsmR1CfiB+qyCx66sQ/KRjhF0gILn5EYGfC3EVYeSWHya5IExiPCMY0BmOhOd7
 W9vwbB0p94dUbLaZCZIRFTGPq1S0dulodnMfJYTZvjga7VIrU9u97z3dkCID6gNgfXkJfjSFtsD
 G8u1U9krIU1kqq5Lg3tA2l9UH9OTjzuqNPev1e5860J+oTL851g6LLRH/RL30/sfC1wmHRD24z3
 EQID9QfL9//4U8hNowPBWRe6tcU+EkOjsw==
X-Received: by 2002:a05:6830:4490:b0:81c:37e2:2008 with SMTP id
 46e09a7af769-85f1cfe403cmr930048a34.14.1793922395675; 
 Thu, 05 Nov 2026 15:46:35 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7f36:1c5c:8ddb:3ed6])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85f1de4e53dsm592122a34.20.2026.11.05.15.46.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 15:46:35 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 05 Nov 2026 17:45:29 -0600
Subject: [PATCH v2 7/8] arm: mediatek: pass reserved memory on to the OS
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-mtk-mt8189-tfa-fdt-v2-7-c168a7b4041c@baylibre.com>
References: <20261105-mtk-mt8189-tfa-fdt-v2-0-c168a7b4041c@baylibre.com>
In-Reply-To: <20261105-mtk-mt8189-tfa-fdt-v2-0-c168a7b4041c@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
 Raymond Mao <raymondmaoca@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>
Cc: u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>, Carlo Caione <ccaione@baylibre.com>, 
 Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3808; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=wwFERJxaStdvTd9KI73egv4aCRmvoe+Mn5UEt/ekSWI=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq7RVFW49H3MU0WX63wm7bfRqiTMFdbuX1GADox
 deOuzfTYkeJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCau0VRRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/Ak14IAIJ4n97E/aWZcrgX2ctH3XnfJ+fNP7hWaDLRi6O
 BU1glOdMUoaeXjVL+slZ21xKgylWimI1IJ6GH6hygQkg26jnRhHUHS6GZD7UuhtV28b2hfT5Gve
 onCZQ8EZvJ0JUPb92wDS2ncEZFrmMpaS+5UIcxpb4nGtES92OutryMj4QJ8o5FTlG/pIQK+s1D7
 mDAOt+1VqN0BTYGHjS5LvkCuiXvJoeQ6gQfA1bV9K00tEJH45gwcqiaXvOf0KUWLFaJ3oDx2noF
 fs1Eq8ls6q0rXO4eKkvcCSUdeppa1sIrG18k/CBvdYbk50LCABGrTgBat26CYQ904dy5LQFHE9F
 wpG0=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Copy the no-map reserved-memory regions of the control devicetree into
the devicetree passed to the OS when MTK_DRAM_DESC_HANDOFF is enabled.

The control devicetree describes the memory reserved for firmware such
as BL31 and OP-TEE, and the boot stage that initializes the DRAM adds
regions whose location depends on the DRAM fitted to the board. An OS
devicetree loaded from elsewhere does not necessarily describe these
regions, but the OS must not use them.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/mach-mediatek/Kconfig     |  6 ++++-
 arch/arm/mach-mediatek/Makefile    |  3 +++
 arch/arm/mach-mediatek/dram_desc.c | 52 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
index 42868c9113d..98e95a11bf4 100644
--- a/arch/arm/mach-mediatek/Kconfig
+++ b/arch/arm/mach-mediatek/Kconfig
@@ -282,6 +282,8 @@ config MTK_DRAM_DESC_HANDOFF
 	bool "Require the DRAM description in a transfer list"
 	depends on BLOBLIST
 	depends on SPL_BLOBLIST || !SPL
+	depends on !MTK_TZ_MOVABLE
+	select OF_SYSTEM_SETUP
 	help
 	  The DRAM size and the memory reserved for the DRAM controller depend
 	  on the DRAM fitted to the board, so the devicetree built into U-Boot
@@ -289,7 +291,9 @@ config MTK_DRAM_DESC_HANDOFF
 	  describes them instead, with a devicetree overlay in a Firmware
 	  Handoff transfer list.
 
-	  Make SPL stop if it does not receive such an overlay.
+	  Make SPL stop if it does not receive such an overlay, and pass the
+	  no-map reserved memory regions of the control devicetree on to the
+	  OS.
 
 config MTK_TZ_MOVABLE
 	select ARCH_MISC_INIT
diff --git a/arch/arm/mach-mediatek/Makefile b/arch/arm/mach-mediatek/Makefile
index 661fc0b88d9..665909cf585 100644
--- a/arch/arm/mach-mediatek/Makefile
+++ b/arch/arm/mach-mediatek/Makefile
@@ -4,6 +4,9 @@ obj-$(CONFIG_ARM64) += armv8-mem-map.o
 obj-y	+= cpu.o
 obj-$(CONFIG_MTK_TZ_MOVABLE)	+= tzcfg.o
 obj-$(CONFIG_XPL_BUILD)	+= spl.o
+ifndef CONFIG_XPL_BUILD
+obj-$(CONFIG_MTK_DRAM_DESC_HANDOFF) += dram_desc.o
+endif
 obj-$(CONFIG_$(PHASE_)MTK_FIRMWARE_AB) += spl_ab.o mtk_ab.o
 
 obj-$(CONFIG_TARGET_MT7622) += mt7622/
diff --git a/arch/arm/mach-mediatek/dram_desc.c b/arch/arm/mach-mediatek/dram_desc.c
new file mode 100644
index 00000000000..1e66ea2a5a6
--- /dev/null
+++ b/arch/arm/mach-mediatek/dram_desc.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2026 BayLibre SAS
+ */
+
+#include <fdt_support.h>
+#include <fdtdec.h>
+#include <string.h>
+#include <asm/u-boot.h>
+#include <dm/ofnode.h>
+#include <linux/ioport.h>
+
+/*
+ * Pass the no-map reserved memory regions of the control devicetree on to the
+ * OS. Besides the static firmware regions, these can include regions that an
+ * earlier boot stage added, at addresses that depend on the DRAM fitted to the
+ * board.
+ */
+int ft_system_setup(void *blob, struct bd_info *bd)
+{
+	ofnode node, subnode;
+	int ret;
+
+	node = ofnode_path("/reserved-memory");
+	if (!ofnode_valid(node))
+		return 0;
+
+	ofnode_for_each_subnode(subnode, node) {
+		struct fdt_memory carveout;
+		struct resource res;
+		char name[64], *at;
+
+		if (!ofnode_read_bool(subnode, "no-map") ||
+		    ofnode_read_resource(subnode, 0, &res))
+			continue;
+
+		strlcpy(name, ofnode_get_name(subnode), sizeof(name));
+		at = strchr(name, '@');
+		if (at)
+			*at = '\0';
+
+		carveout.start = res.start;
+		carveout.end = res.end;
+
+		ret = fdtdec_add_reserved_memory(blob, name, &carveout, NULL, 0,
+						 NULL, FDTDEC_RESERVED_MEMORY_NO_MAP);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}

-- 
2.53.0

