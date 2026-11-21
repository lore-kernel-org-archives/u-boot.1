Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B65F606A32A
	for <u-boot@archiver.kernel.org>; Sat, 21 Nov 2026 19:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=j9yZnDU3;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tlRbEh2S
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0F4FC80F28;
	Sat, 21 Nov 2026 19:58:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ePssMpIkT5id; Sat, 21 Nov 2026 19:58:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 29FD080E83
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795291119;
	b=qW/VE4YLxzc2ogQWxDJikkXH5xahkTCWTZQlK4Di4b7E6186Vdbb+ZHfBmh/3eZvF0cf
	 ukuRZwC67SYN1eSgwXkRQ1dX7+pIIujHh6tD151aoSV6kiOscWNcN6sPIAr1To4mDGolF
	 oENA9sCEzudXR/cObVOH7nRrAQ3+3hRUI5XELSvgcwdeoMisf/ucyB2Lz2LUPkMRgOOi1
	 DVgZeEhalZ26Od6bFj1yjLdVVxbbAdiufV4uxlXdA7rCBQuqbk7/78MrisuTX+aU/NyCH
	 Gdq/+hqXIq7eQOe10Rld+walgfU2MsANdw7vdCSWR2yEWBiZKJueUGa1H5oAOpftacA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795291119;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=HVtIIms540AzScnjela3ycbYNpDOKpnoF8ybKWB1yG4=;
	b=iogEU+wAPJUVjaKJkDZQ9VRxKG0LvVHXy8dJUBTPauWmXaQpTXhrqeuLz9+xTFPIOvov
	 WfmRHFNbWwcI7hZX+U/gHBDt3q9cIZ9Zxitreh2rHXJs5I4257U418KP5lZgrwTMdPiNt
	 ez5arTgwNaHjCVcxS/PNF8j894BcjbrciTSutzChdQhJ41eCn79IS5PKwMWQUTcUVnTAB
	 lceGpkPysBM2W5RWBfrgbQ++kwZFpn8QbxcRo71atrM3rwzj7/QNXSLo77jX8nQpA3trb
	 T9UYtPhtkKdngn2NwxL1h66NGFvJHe+1Gy9iIoT3eiLYogL1OMV0uu7prWH5bAuaBTQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tlRbEh2S;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795291119;
	bh=HVtIIms540AzScnjela3ycbYNpDOKpnoF8ybKWB1yG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=j9yZnDU3sXmEUxxFMPJfp4n0LKBzfN4Oy+5UQkz71L5jcMwoJWtg5MgmZvWXmSjt1
	 fgtTk1hVEQNoV7RMQrk2zy0OdZvnyl7sAqlC5TGv/fpCA1Hgm7VUDOZl8FE5ERluyj
	 2TzAPWzsDzLCtyQwC/0935g/8ExmOeU99//Z3jN05ZHUddUn76fv7s2i6wUz/JIouU
	 DAe385Kk7Fh8YL3J4q79FMMPN9ma/bpq6zg380VJmVX/FfK88eitlRgdMDosSxCNbk
	 AJb5tUmRhDcYdBHvZpUm4K+QJSNvI4qor7GV9BHZn0kS8oO4iEkcxAeKr3PFP4RT/p
	 KtZYW75Wfgbjg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 29FD080E83;
	Sat, 21 Nov 2026 19:58:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 69BA6759
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 18:58:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5B28A807B5
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 18:58:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6aAy_e2X-epr for <u-boot@lists.u-boot-project.org>;
 Sat, 21 Nov 2026 18:58:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9730B80715
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1336"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1336; helo=mail-dy1-x1336.google.com;
 envelope-from=thallescampagnani@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=tlRbEh2S
Received: from mail-dy1-x1336.google.com (mail-dy1-x1336.google.com
 [IPv6:2607:f8b0:4864:20::1336])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9730B80715
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 18:58:12 +0000 (UTC)
Received: by mail-dy1-x1336.google.com with SMTP id
 5a478bee46e88-33fb4680717so5394208eec.1
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 10:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795287491; x=1795892291;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HVtIIms540AzScnjela3ycbYNpDOKpnoF8ybKWB1yG4=;
 b=tlRbEh2SYw9hEpubpDLrG5wh47/intbr6mmxAYn0NDdDgt02JMNVO86Re59u8UorxX
 ecGRspSjQV4U0PJhEoWRnLItTEKBm+k/oiwZqqfpRmHjAunF51xiOvxfSeErCxvoNRVM
 Vo3706umNp/O2hQYtnFhzGYAsnCvZxBx9lV5T6fmQ+9FHy0VelpZMcLexERS7YAmIqwu
 RkRNlUigjI71eVCA7rHAfOh0//47mOu5101vr5jwQkfDYpHoqwL8LJOw9RIjAwpnpZUg
 Q+xQPZQmc4IfSh7+ZYTwRHir6K0qw/ODsbkTrbCfMn1/l/PRbNNeg+InLuGynm2hEznJ
 /28w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795287491; x=1795892291;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HVtIIms540AzScnjela3ycbYNpDOKpnoF8ybKWB1yG4=;
 b=VEWuYCeNtusSuyvlXWvTLHwuT3gvt8G9BTwW1ukS98d3pQxjwWL7lrAA3dbH7G8Eep
 bW48SXRgcuu3fjyIldGx96iDIuYOp9rDWYTrZUsOYjwrzYTcwjlHTgpZ4Qf7GpbY2l67
 ntdqpiTMbrsRRZ/P7UwvYI7IjH43cW3+OlqEb+xXreeK/bREPC6b1+cP7ogNtY2z4zuA
 UXHj9opCxlOc27bpi+jO4Hi4UTziW+W8IJ/DHsJnC05lZ8zHKRjXDQzU+9O+oygI8Js/
 Fu0LIkvC2+e6dfJVbZl0PXI8aXfcIVosBeQOXYdlu2O8qoKKI2XmfoHoefsFVru0Um/v
 1orw==
X-Gm-Message-State: APuU4Z91btOLAy3b8oJcXQ73XlsngmnLclE65APuvD2BIdyL6JjICOpn
 +OnPA9X+FNZF/lEo5ydW4n4HMxFXSgqcfH6OS9VEoe+9T62nujXndj5ykCutIaAl
X-Gm-Gg: AZFdTZdXFFPh3YPlEIywlAd/pp40dDd+fVsoUwOkuIJ2GGUME8Gp7hA9Vy7x0nkBY5j
 nT43ZMViPDOfb4Cg3pCkgvfrGO1GCr4gHEoMP3xj6kbSnE3e+9dfcMwtFUgHFA6hbtOrWSFHTHJ
 juVxbCEBPSxrKFhS/XeyVOlnrfWO7Vaz3Qa2Xhby7U9NnXscri2JTRrccbLouoybXxsXWcoeB8P
 DvEP+E6He1fAJK4NSj+rIxgeA7dBJecoa2GAUYqCanRJWACkLpattPXy8qOzTDaD/V5HCEpSS13
 iBb22D4b+Vbk7pewK68fHwnbELKZQ20BdMa7eLTmnVz4AMIQjl/MVYJb6xAr2kzyf+t1HsQReZb
 YH7bie5HWmyPpVYgA3d1opoPMxXnArniHffqPiRI9mlNK8B4ggeAwhuZ9SRU+3cHkPugK39FjEI
 ewB4WDX5zboO3iA8hyiYbq5YeZTPB60s7D+5PUpuBiWVGOY3pvkLjDcEPvzy2rvph+DErTZ6Vup
 LBCjWG+dsz7K0KY5T8rB+wXIxKrmie1P9AKsReATDjXESewj7rAwLmuVB108WbX/0MjW4MQ7Lbc
 IL/uwgnkhoFE1P6Oa6ndE2JK1ul4IWeZ
X-Received: by 2002:a05:7301:f23:b0:370:a11f:dcb7 with SMTP id
 5a478bee46e88-385707434a6mr7113675eec.41.1795287491209; 
 Sat, 21 Nov 2026 10:58:11 -0800 (PST)
Received: from qqlt ([2804:14c:5b81:8b94:5fa9:2af4:7818:7c81])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-38566cd4efesm20383004eec.12.2026.11.21.10.58.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2026 10:58:10 -0800 (PST)
From: Thalles Campagnani <thallescampagnani@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: u-boot-spacemit@groups.io, Yixun Lan <dlan@kernel.org>,
 Huan Zhou <pericycle.cc@gmail.com>, Eric Chung <eric.chung@riscstar.com>,
 Leo Liang <leo.liang@sifive.com>, Tom Rini <trini@konsulko.com>,
 Thalles Campagnani <thallescampagnani@gmail.com>
Subject: [RFC PATCH 2/3] riscv: spacemit: k1: use native SPL DDR driver
 instead of blob
Date: Sat, 21 Nov 2026 15:57:37 -0300
Message-ID: <20261121185739.531651-3-thallescampagnani@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261121185739.531651-1-thallescampagnani@gmail.com>
References: <20261121185739.531651-1-thallescampagnani@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 21 Nov 2026 19:58:34 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Enable CONFIG_SPL_SPACEMIT_K1_DDR by default in spacemit_k1_defconfig
and call spacemit_k1_ddr_init() directly from ddr_early_init() in
board/spacemit/k1/spl.c, passing cs_num, data_rate and the LPDDR4/4X
type read from the board EEPROM.
When CONFIG_SPL_SPACEMIT_K1_DDR is enabled, omit the external ddr_fw.bin
blob from the K1 binman u-boot-spl-ddr section and skip the ddr_fw.bin
placeholder rule in board/spacemit/k1/Makefile. Disabling the Kconfig
option preserves the legacy external ddr_fw.bin path.

Signed-off-by: Thalles Campagnani <thallescampagnani@gmail.com>
---
 arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi |  2 +
 arch/riscv/dts/k1-musepi-pro-u-boot.dtsi  |  2 +
 board/spacemit/k1/Makefile                |  2 +
 board/spacemit/k1/spl.c                   | 46 ++++++++++++++++++-----
 configs/spacemit_k1_defconfig             |  1 +
 5 files changed, 43 insertions(+), 10 deletions(-)

diff --git a/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi b/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi
index 3077cdee55d..2c35e23393a 100644
--- a/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi
+++ b/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi
@@ -106,11 +106,13 @@
 		u-boot-spl {
 		};
 
+#ifndef CONFIG_SPL_SPACEMIT_K1_DDR
 		ddr-fw {
 			type = "blob";
 			filename = "ddr_fw.bin";
 			align = <64>;
 		};
+#endif
 
 		u-boot-any {
 			type = "section";
diff --git a/arch/riscv/dts/k1-musepi-pro-u-boot.dtsi b/arch/riscv/dts/k1-musepi-pro-u-boot.dtsi
index d6299c96949..a14242297b6 100644
--- a/arch/riscv/dts/k1-musepi-pro-u-boot.dtsi
+++ b/arch/riscv/dts/k1-musepi-pro-u-boot.dtsi
@@ -144,11 +144,13 @@
 		u-boot-spl {
 		};
 
+#ifndef CONFIG_SPL_SPACEMIT_K1_DDR
 		ddr-fw {
 			type = "blob";
 			filename = "ddr_fw.bin";
 			align = <64>;
 		};
+#endif
 
 		u-boot-any {
 			type = "section";
diff --git a/board/spacemit/k1/Makefile b/board/spacemit/k1/Makefile
index a57af2e1f08..8bbd1bef68e 100644
--- a/board/spacemit/k1/Makefile
+++ b/board/spacemit/k1/Makefile
@@ -6,6 +6,7 @@
 obj-y := board.o
 obj-$(CONFIG_SPL_BUILD) += spl.o
 
+ifndef CONFIG_SPL_SPACEMIT_K1_DDR
 DDR_FW_SRC ?= $(DDR_FW_FILE)
 FW_TARGET = $(objtree)/ddr_fw.bin
 
@@ -26,3 +27,4 @@ $(FW_TARGET): FORCE
 	fi
 
 clean-files += $(FW_TARGET)
+endif
diff --git a/board/spacemit/k1/spl.c b/board/spacemit/k1/spl.c
index 0ce0a811830..b8e1432020f 100644
--- a/board/spacemit/k1/spl.c
+++ b/board/spacemit/k1/spl.c
@@ -12,12 +12,14 @@
 #include <configs/k1.h>
 #include <dm/device.h>
 #include <dm/uclass.h>
+#include <hang.h>
 #include <i2c.h>
 #include <linux/bitfield.h>
 #include <linux/ctype.h>
 #include <linux/delay.h>
 #include <log.h>
 #include <power/regulator.h>
+#include <spacemit/k1_ddr.h>
 #include <spi_flash.h>
 #include <spl.h>
 #include <tlv_eeprom.h>
@@ -80,8 +82,10 @@ struct ddr_cfg {
 	u8      type[I2C_BUF_SIZE];
 };
 
+#if !IS_ENABLED(CONFIG_SPL_SPACEMIT_K1_DDR)
 binman_sym_declare(ulong, ddr_fw, image_pos);
 binman_sym_declare(ulong, ddr_fw, size);
+#endif
 
 char product_name[I2C_BUF_SIZE] = "k1";
 
@@ -378,36 +382,58 @@ int read_ddr_info(struct ddr_cfg *cfg)
 	return 0;
 }
 
-void ddr_early_init(void)
+static void ddr_init_from_blob(const struct ddr_cfg *cfg)
 {
+#if !IS_ENABLED(CONFIG_SPL_SPACEMIT_K1_DDR)
 	void __iomem *src, *dst;
 	ulong pos, size;
-	struct ddr_cfg cfg;
 	ddr_init_func_t ddr_init;
 
 	pos = binman_sym(ulong, ddr_fw, image_pos);
 	size = binman_sym(ulong, ddr_fw, size);
 	src = (void __iomem *)pos;
 	dst = (void __iomem *)(DDR_FIRMWARE_BASE);
-	log_info("DDR firmware: [0x%lx]:0x%x, size:0x%lx\n", pos, readl(src), size);
+	log_info("DDR firmware: [0x%lx]:0x%x, size:0x%lx\n",
+		 pos, readl(src), size);
 	/* The appended firmware may overlap its fixed execution address. */
 	memmove((u8 *)dst, (u8 *)src, size);
 	size = round_up(size, 64);
 	/*
-	 * Ensure the just-written DDR firmware bytes are observable in the
-	 * instruction stream. RISC-V's fence.i alone is sufficient for the
-	 * single-hart SPL case; skip flush_dcache_range as cbo.flush may
-	 * trap on our current privilege state.
+	 * Ensure the just-written DDR firmware bytes are observable in
+	 * the instruction stream. RISC-V's fence.i alone is sufficient
+	 * for the single-hart SPL case; skip flush_dcache_range as
+	 * cbo.flush may trap on our current privilege state.
 	 */
 	asm volatile ("fence.i" ::: "memory");
 
-	read_ddr_info(&cfg);
 	ddr_init = (ddr_init_func_t)DDR_FIRMWARE_BASE;
 #ifdef DEBUG
-	ddr_init(0xc0000000, cfg.cs_num, cfg.data_rate, puts);
+	ddr_init(0xc0000000, cfg->cs_num, cfg->data_rate, puts);
 #else
-	ddr_init(0xc0000000, cfg.cs_num, cfg.data_rate, NULL);
+	ddr_init(0xc0000000, cfg->cs_num, cfg->data_rate, NULL);
 #endif
+#endif
+}
+
+void ddr_early_init(void)
+{
+	struct ddr_cfg cfg;
+
+	read_ddr_info(&cfg);
+
+	if (IS_ENABLED(CONFIG_SPL_SPACEMIT_K1_DDR)) {
+		bool is_lpddr4 = !strcasecmp((const char *)cfg.type, "LPDDR4");
+		int ret;
+
+		ret = spacemit_k1_ddr_init(cfg.cs_num, cfg.data_rate,
+					   is_lpddr4);
+		if (ret) {
+			log_err("DDR init failed (%d)\n", ret);
+			hang();
+		}
+	} else {
+		ddr_init_from_blob(&cfg);
+	}
 	/*
 	 * The DDR firmware leaves the CS1 map valid on single-rank boards too,
 	 * and dram_init() adds up every valid map.
diff --git a/configs/spacemit_k1_defconfig b/configs/spacemit_k1_defconfig
index b8f777e89c1..f99d5c7daa1 100644
--- a/configs/spacemit_k1_defconfig
+++ b/configs/spacemit_k1_defconfig
@@ -104,6 +104,7 @@ CONFIG_DM_REGULATOR=y
 CONFIG_SPL_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_SPACEMIT_P1=y
+CONFIG_SPL_SPACEMIT_K1_DDR=y
 CONFIG_DEBUG_UART_NS16550=y
 CONFIG_DEBUG_UART_SHIFT=2
 CONFIG_DEBUG_UART_ANNOUNCE=y
-- 
2.56.1

