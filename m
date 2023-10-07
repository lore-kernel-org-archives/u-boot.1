Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F69EE95A62
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 19:37:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4BB086A02;
	Sat,  7 Oct 2023 21:37:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TF6Yf+/1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2657786ACA; Sat,  7 Oct 2023 21:37:08 +0200 (CEST)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C88D86961
 for <u-boot@lists.denx.de>; Sat,  7 Oct 2023 21:37:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-5a229ac185aso39570627b3.1
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 12:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1696707420; x=1697312220; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=NItRSEBr0QtiG7blGpCzc16od46YIQheRW57lGGnYk4=;
 b=TF6Yf+/18ShSXarSjKlWr0Nxb/ukU2O1Oj64nQRAuXXmojoHnbf4GsdYXlmshTb/nm
 PbLXdpSeqphUy7NwAWV1E5xzRfOM2qivqjWbAPRQCYW0R602XWOcYQg+xBBUKLkfPI8l
 ZgNYF2280qfRHMGQhRExK0T4BR9J6fEzXsgKY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696707420; x=1697312220;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NItRSEBr0QtiG7blGpCzc16od46YIQheRW57lGGnYk4=;
 b=gjJJLkGgauVzbvqYIJL+cgyqFsiiG3Nk9UhfsKEeMj0jZbUqYM4IZdNZ1BLP+O/SUO
 JEriaEro7HSy9h2dIfRj4n3ys2dLJ50s3w38iD5VqKHG+arll3GV6p7SZkzQvNNwaVN/
 ecLIGVTZqS1pHHorUrVd1ekk7macxE+xmR9xlUMZeZEWNbq2RA4vGIOWa/8NS+ap9Pxs
 JLubJLDsONuH/vO4NgBWXZTpNtyHGGArYHx1Gmy0l1jb/og05XqlOoiqwkslaCDXHfzD
 AnPX4GgsjNksYY+fBVHdp2ipyvIPnl0DZK0S8bkCEgGKaE5ADktg5YeM0JI92liiaUqi
 UrDg==
X-Gm-Message-State: AOJu0YwNeyzL6g2UXmr9F2KkAxH0XSnqBe+1nk5q97dHC6YHq1IetfU1
 BzipdsS+PcUS4U1QjiVEZIDCsPM5pxkFAMCe9+2WIw==
X-Google-Smtp-Source: AGHT+IGKdaPlE+piNCb25MpBIhk7nNtiukZrWv4hUvpq/CQC7ZkLN52pnX3ezu0PvuxXkKY2PXyaKw==
X-Received: by 2002:a0d:d94f:0:b0:59b:ff76:8d03 with SMTP id
 b76-20020a0dd94f000000b0059bff768d03mr11734235ywe.12.1696707420059; 
 Sat, 07 Oct 2023 12:37:00 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-3c47-81c9-6281-4dc8.res6.spectrum.com.
 [2603:6081:7b00:6400:3c47:81c9:6281:4dc8])
 by smtp.gmail.com with ESMTPSA id
 n75-20020a0dcb4e000000b005a1d51ce1aasm2269492ywd.25.2023.10.07.12.36.59
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Oct 2023 12:36:59 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] cmd/ti: Update Kconfig logic and Makefile recursion logic
Date: Sat,  7 Oct 2023 15:36:58 -0400
Message-Id: <20231007193658.2617151-1-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
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

- Add some dependencies to CMD_DDR3 as this is only valid on some
  platforms (which tend to select it as well).
- The proper gate for going in to cmd/ti is not
  CONFIG_TI_COMMON_CMD_OPTIONS as nothing under there is controlled by
  that symbol but the general TI architecture options.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 cmd/Makefile    | 7 +++++--
 cmd/ti/Kconfig  | 1 +
 cmd/ti/Makefile | 4 ----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/cmd/Makefile b/cmd/Makefile
index 9bebf321c397..be13e288ae28 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -235,6 +235,11 @@ obj-$(CONFIG_X86) += x86/
 obj-$(CONFIG_CMD_MESON) += meson/
 
 obj-$(CONFIG_ARCH_MVEBU) += mvebu/
+
+# TI
+obj-$(CONFIG_ARCH_KEYSTONE) += ti/
+obj-$(CONFIG_ARCH_K3) += ti/
+obj-$(CONFIG_ARCH_OMAP2PLUS) += ti/
 endif # !CONFIG_SPL_BUILD
 
 obj-$(CONFIG_$(SPL_)CMD_TLV_EEPROM) += tlv_eeprom.o
@@ -244,8 +249,6 @@ obj-y += nvedit.o
 
 obj-$(CONFIG_CMD_BCM_EXT_UTILS) += broadcom/
 
-obj-$(CONFIG_TI_COMMON_CMD_OPTIONS) += ti/
-
 filechk_data_gz = (echo "static const char data_gz[] ="; cat $< | scripts/bin2c; echo ";")
 
 filechk_data_size = \
diff --git a/cmd/ti/Kconfig b/cmd/ti/Kconfig
index db557445a890..9442c9993c19 100644
--- a/cmd/ti/Kconfig
+++ b/cmd/ti/Kconfig
@@ -2,6 +2,7 @@ menu "TI specific command line interface"
 
 config CMD_DDR3
 	bool "command for verifying DDR features"
+	depends on ARCH_KEYSTONE || DRA7XX
 	help
 	   Support for testing ddr3 on TI platforms. This command
 	   supports memory verification, memory comapre and ecc
diff --git a/cmd/ti/Makefile b/cmd/ti/Makefile
index 045593396b70..87f85b2c2323 100644
--- a/cmd/ti/Makefile
+++ b/cmd/ti/Makefile
@@ -1,9 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0+
 # Copyright (C) 2017 Texas Instruments Incorporated - http://www.ti.com/
 
-obj- += dummy.o
-
-ifndef CONFIG_SPL_BUILD
 obj-$(CONFIG_CMD_DDR3) += ddr3.o
 obj-$(CONFIG_CMD_PD) += pd.o
-endif
-- 
2.34.1

