Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21B37CA5FAD
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 20:32:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CA366407E7;
	Tue, 29 Sep 2026 20:32:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TAwp8NVT0VSU; Tue, 29 Sep 2026 20:32:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org D5519407E3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790713972;
	b=NHBnxhyKXa10lHh0+r91wuKBWvek3OHGRpAekwNJHm053U1sYpKNGTi+D5wOtHL9rems
	 8mhYH47wqOcdOqxh4Lk+6Vgh3OpuenUC5Akpj+LfLCtQmlKx9YLaAT92uzy1nyP/R3XoD
	 1hEE9U78qzP6XQW/gAGFdr0Y+y6KkNvxaOXzqGWyTG/w/NWyuuhK36utdpylPXbgreDnv
	 3GF6NpjmBuRMvm4vb480pfNVqrR/Sl66KBBEp0fmfngGUhhxUFnylkRRyAWiFXuTP3a05
	 exNiuNy1bn6XrsEYfdX2pNLgIfczDNhBy5hP/Sd0IPOYrGnDuUdjP5a3kmRQpF58cHA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790713972;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=BgpZpsCumAAayqcYCfhHwv/BHePfOwBj0whUkaLwwUk=;
	b=kpS8/GvTbOjpcdPtFsD9isbVy5gmHxZCoaadOsbQ4QfQuSrRpR6I7e3Tb2hG2tzGu+pF
	 +H+jEJvyi5bRVps3Lwwjr4B59iAWa3f3vqZcLvwqwuIVKiB0Xt2gqQalc8n4Xdw7RDfO0
	 nLmGRXtnT9k1H+aFP1IyXE9NfGybhYmxMBc72XICNf4QO8kowG9XOC4qf7qsmLZmJkhiu
	 ytzkMk7KHhcvfQqJjfY5sUTCk1zHNlFA/uc+joUgVgllxg8Y4YSdjiab+6feUzR61OB2/
	 8ufAbZ/Z0lxrBUT8M/wc0O79/LVZ64AjXiozHBBRYIDSJm3vDebBo450pBc21SACTzw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790713972;
	bh=BgpZpsCumAAayqcYCfhHwv/BHePfOwBj0whUkaLwwUk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=athkF/diBEuLNoN9jZHbCIF4kl99o53o0dv5nN8pa9UL748paf0ERFiZD0+zCSGQT
	 20knEdKgzT9uj8L3c6o4AMDh6B8d6cvP3dFzsBau4T47NaUKy9yrlqZW2V8KiIYEE8
	 0WiF3aqMu7SLmJ/pEpb8euiwyplUOIfPt1CdHr6i6srzCPqQ9YmwutyrBEx515fYLN
	 NKxSf3KJZplgnzfgk0KW1pT7QkQ1MNL0+YTwi9SxIxlkSUJnHS3I9RYr5v21yLxuuP
	 QmWS5x9sgxhXQ+ZY30q8DHOD+bQtAxuzMaPDQNTvCHIaDE2Nj9AAQzGm1YYd4Yq1FB
	 Bwcds0n9aPTVA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D5519407E3;
	Tue, 29 Sep 2026 20:32:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 089AB32F
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 18:07:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E2AEE402D9
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 18:07:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mmWoNgXUnX9W for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 18:07:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 04838400CC
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::735"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790705247;
 b=qQ5Qyx9qdxeob7hsI5HeOrE95AcKgm2E34wV4r2Uwk32Xcx1X/SoTHzMnnYXdrTXRXz2
 McN/fsmQmkX7tG7IZKI2MuA6tn4nfr/Imemo3UU/8A1o07pDZGcuGXgcDRgVz0pTS6fdN
 T1uAOfnAYVcXcxhiu8XgLPz7VyCqjrUymP6rVLeJHn4DySrc5z5UH+Hl8QM+CJLzhEP4L
 QC2wG+U24fZWWecxpCkB2RASwhdLEoec0ZXCckEyAYRY489zrY0KPSo3pihVur2xHQEy7
 L47cFv0ATNVhuu8oQofCwoYj/KLIBJBqrSbbv0jwTUMZgmiTuHf2XxvfnT8TSSdwbiw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790705247;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=BgpZpsCumAAayqcYCfhHwv/BHePfOwBj0whUkaLwwUk=;
 b=CAuWw4UURw1G3owz14fEnuPZ/UfHujxiekxQJhA8TmWRrcoK/XyR72wZVt+w9FyaUgnB
 6zOJEQSkwjv2j/J7liKwCHuEWEGayfVqwEp9BLdZcJUFbiI7OX0TlQnNwPtVeRm8jR9VH
 dk5QJagEEn9jU5l6o4ElosQZDMAEYaYGJ+78f43Mg0yjv/s6EcO55ERhI+RAQheuSArxV
 BWLdI0NgkZIZ6tfDenHK+Uwq9L1nvDV6f88nq30oIjUZZn80OkgKLDBYFQRkH7RO8Yye/
 BwbEJBBfJuRY2xuVQO7nZOPOhH6g0pwqlaPEX7QIVGIj8xPjWNJ18k7GKXRb0Jypq0g==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=brivo.com; 
 dkim=pass header.d=brivo.com header.i=@brivo.com header.a=rsa-sha256
 header.s=google header.b=fu8K9Rrn; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::735"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::735; helo=mail-qk1-x735.google.com;
 envelope-from=sanderson@brivo.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=brivo.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=brivo.com header.i=@brivo.com
 header.a=rsa-sha256 header.s=google header.b=fu8K9Rrn
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 04838400CC
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 18:07:25 +0000 (UTC)
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-93a40a9a01aso120686385a.0
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 11:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=brivo.com; s=google; t=1790705244; x=1791310044;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BgpZpsCumAAayqcYCfhHwv/BHePfOwBj0whUkaLwwUk=;
 b=fu8K9Rrnn0sFKA33GHhlZHrVXdStYDX0v8qF7e+8uoisIdzwRvZhWe64SNB7P2MTBd
 z5wGQ4cXbfJ9424OfkGKX2kNE6w2BWWPK7ZI9zn5p18SUjRXtbJXgE69rc4X/d0rIzIJ
 3CqOlhZe9vj1rBy1iSiHj3A/BAeu0aPz+4jVEjT82e2KxTaTVNIUEbX01ZlzVt5Dg9pc
 +DiDYVNjTET2fo2TdkoW5RvMrwhM465IEAilhXrxxrLBOEvZ76IBgIDiPY4Ya5+BP/H8
 PkIblW385aFGWYgqepDChmLmrdZTIWyi+yBJVzOiFh4/1+HpJeXNxpxR1qlkcTmSog4V
 Szrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790705244; x=1791310044;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BgpZpsCumAAayqcYCfhHwv/BHePfOwBj0whUkaLwwUk=;
 b=x4KTUntWkRKAc7kXVldjVzOQH+vclHkYhP8IIo45HS05K1i2p8Wth4ZgVnwlOUajQw
 Lgc/tDjQ1nBDqyzb1IShakj0OEdu6wYK5t5gZxUnri41DZYqCOW7YTNomYHXg2zyXUGb
 NFpEz45v4EK1MkiKcUE5vsDjVKgC+l1aSkDMDsSuQNqyVTwsiM5RTftDogeIscw7aQQn
 GD6kJOlq0qvKf9KjRHjPEcYHX8ud/BhtCOhvLaSxEGG7NR39tcCTT9fxZuS84J7LBGpM
 wX+2PWqnmlS45vn94BUJwkdLMNYCXoYUvJyky4yXHLSGJ+aBWXLu3dZbGqz4U4MsadFL
 lpyw==
X-Forwarded-Encrypted: i=1;
 AKwUvBx7hd3ynt4d+PhR1JRiRu9Aq2uGVUR24/mS+OHqeIbXPa5xUauEyMsDbRQP8deSQgQnvckpaes=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nW+hO1ts1y4JSpzDHESLpsj7oAA+nIBifBJoGe7BWLLp3DBG1a
 T/e4iUzJLD+efRSfc7V0Odk8QoiakTIzXrah63H+sgNEO9e6x9KHuZZGZsVGz1QNkov5iZNtoBv
 AK2h70+kxauvOLpVz9fhI1pSRxxWU9bdRKSw8NN+W55jOlBFSfe3wAzBeDB4yG9E=
X-Gm-Gg: AYBFou0ct/QLh+ZzG2h7NI3RgeSvi72tJFOD8GmW5/Pa0O7NplwsV2Zi46YjHa4k9dM
 KDDKqI4iDJ/4AOw4ilIBjweH+aVtGYZDCp3Kzr19n4FqusURDnUT/c5DZ6qg69zE57Iali68hp5
 4hvUIA0Xt59iIVaKfzw7Pb5kWET7R7pmLnmSPsnAuaSmcaieytirk6Q74FcYcQLyjtJDUQXKJJb
 UtIKhcumcX9ftrQdttBJt8b6F9YCkyzTZL9yyiPR5STMXkMmJHAIOxEDZNIUJtwy4jZAgt3xbfV
 /7OKyn6/8540YvvTn35FzydX+fFxZ1HNN1rpHs9OyucNA1RZYeA//6sJp0TwZHpQs9xGOb9EHd5
 gxrGVRErPKddwYLPBUN+JTxvR4At2d8+5kxiXKabUnDIcngiN9vIIKoYEh06BrRmy0i1HAzy//B
 X+gMJFe9LhnJONRpaDre1LvBd5MXWJAeS1iOI7pHb89RTL52gC6X0OOpvdasvBncZs
X-Received: by 2002:a05:620a:2b42:b0:93c:7bc2:2599 with SMTP id
 af79cd13be357-93c8bf63a01mr670440685a.27.1790705244255; 
 Tue, 29 Sep 2026 11:07:24 -0700 (PDT)
Received: from strozzi ([71.163.254.246]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93c9f462b0esm28802785a.9.2026.09.29.11.07.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 11:07:24 -0700 (PDT)
From: Sean Anderson <sanderson@brivo.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.u-boot-project.org
Cc: u-boot-amlogic@groups.io, Tom Rini <trini@konsulko.com>,
 Sean Anderson <sanderson@brivo.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v2 1/9] arm64: meson: Add s4 SoC support
Date: Tue, 29 Sep 2026 14:06:23 -0400
Message-ID: <20260929180721.3440839-2-sanderson@brivo.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929180721.3440839-1-sanderson@brivo.com>
References: <20260929180721.3440839-1-sanderson@brivo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 29 Sep 2026 20:32:39 +0000
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
some BL2 (mis)behavior. Memory for ATF/TEE is expected to be reserved in
the board devicetree, so we don't reserve it in board-s4.c.

Signed-off-by: Sean Anderson <sanderson@brivo.com>
---

Changes in v2:
- Add S4 to meson board info
- Add DEBUG_UART defaults
- Extend initial padding to 4096 to match what Amlogic does

 arch/arm/include/asm/arch-meson/boot0.h | 12 ++++++
 arch/arm/mach-meson/Kconfig             |  7 ++++
 arch/arm/mach-meson/Makefile            |  1 +
 arch/arm/mach-meson/board-info.c        |  2 +
 arch/arm/mach-meson/board-s4.c          | 50 +++++++++++++++++++++++++
 drivers/serial/Kconfig                  |  2 +
 6 files changed, 74 insertions(+)
 create mode 100644 arch/arm/include/asm/arch-meson/boot0.h
 create mode 100644 arch/arm/mach-meson/board-s4.c

diff --git a/arch/arm/include/asm/arch-meson/boot0.h b/arch/arm/include/asm/arch-meson/boot0.h
new file mode 100644
index 00000000000..d098786e5f1
--- /dev/null
+++ b/arch/arm/include/asm/arch-meson/boot0.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2026 Brivo Systems LLC
+ */
+b reset
+/*
+ * BL2 copies some keys to the start of DRAM, clobbering anything in the first
+ * 4k aside from the initial instruction. I measured the actual data clobbered
+ * as 1076 bytes, but I suspect the amount depends on the configuration, so
+ * just go with what amlogic does.
+ */
+.skip 4096
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
diff --git a/arch/arm/mach-meson/board-info.c b/arch/arm/mach-meson/board-info.c
index d3807dc787d..379f6a42c22 100644
--- a/arch/arm/mach-meson/board-info.c
+++ b/arch/arm/mach-meson/board-info.c
@@ -40,6 +40,7 @@ static const struct meson_gx_soc_id {
 	{ "G12B",   0x29 },
 	{ "SM1",    0x2b },
 	{ "A1",	    0x2c },
+	{ "S4",     0x37 },
 };
 
 static const struct meson_gx_package_id {
@@ -73,6 +74,7 @@ static const struct meson_gx_package_id {
 	{ "S905X3", 0x2b, 0x10, 0x3f },
 	{ "S905D3", 0x2b, 0x30, 0x3f },
 	{ "A113L", 0x2c, 0x0, 0xf8 },
+	{ "S905Y4", 0x37, 0x03, 0xff },
 };
 
 DECLARE_GLOBAL_DATA_PTR;
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
diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index ffc58d663ff..909e5e4c5f5 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -537,6 +537,7 @@ config DEBUG_UART_BASE
 	default 0xe0000000 if DEBUG_UART_ZYNQ && ARCH_ZYNQ
 	default 0xff000000 if DEBUG_UART_PL011 && ARCH_VERSAL
 	default 0xf1920000 if DEBUG_UART_PL011 && (ARCH_VERSAL_NET || ARCH_VERSAL2)
+	default 0xfe07a000 if DEBUG_UART_MESON && MESON_S4
 	help
 	  This is the base address of your UART for memory-mapped UARTs.
 
@@ -573,6 +574,7 @@ config DEBUG_UART_CLOCK
 	default 100000000 if DEBUG_UART_ZYNQ && ARCH_ZYNQMP
 	default 50000000 if DEBUG_UART_ZYNQ && ARCH_ZYNQ
 	default 100000000 if DEBUG_UART_PL011 && (ARCH_VERSAL || ARCH_VERSAL_NET || ARCH_VERSAL2)
+	default 24000000 if DEBUG_UART_MESON && MESON_S4
 	help
 	  The UART input clock determines the speed of the internal UART
 	  circuitry. The baud rate is derived from this by dividing the input
-- 
2.53.0

