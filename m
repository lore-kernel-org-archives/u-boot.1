Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C304C54791
	for <u-boot@archiver.kernel.org>; Wed, 13 Mar 2024 16:24:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8F8187EA9;
	Wed, 13 Mar 2024 17:24:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PLm9rkYV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC7618272A; Wed, 13 Mar 2024 17:24:08 +0100 (CET)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C996287EE3
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 17:24:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-5131316693cso61783e87.0
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 09:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710347044; x=1710951844; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PeH0jtFq/Xmys6wW7yvXInFyA0E/rY6c14SEeWX+QjE=;
 b=PLm9rkYVG+St9FmZenFOhYJGeaB0a1VvQWXB2pikZOT2X5RvEEkvzWZyzCJPjCIYcP
 4mqhjZEc3xYnkI95ndDsSaX1xtXo+EzZaMFupWOcfoIzu+N1lir0ne+B/WrRnK+i0NE1
 ka3O58M2ZqsBJDRqaLyeucHQ4HqsGnlBU702Woi5XmDuW6++5GCEH9KvVr8cuJcTLmCm
 jtFaCkxHZIT+7qHnZagmSW+Jtac77VvpbTrG0jfh67/VZx9/aIG+gHO+vqr6Fk/X/1Bd
 unHc820+/oR3L0ZdbEQes0QK4X8Gwt0R7fj0sYwuwIXY1gr/EtsQx3uhasrRLjXXGXJg
 G4bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710347044; x=1710951844;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PeH0jtFq/Xmys6wW7yvXInFyA0E/rY6c14SEeWX+QjE=;
 b=PtD2/TNY6pCHvyO49fgGOoZF4qdkgll6nv+VlXl9cIYTLBI7JTgSa1M23eBrpYVq7L
 FyfkPfdrXn6pwkWHV10uGuG42ywddbpcHnoPt6YIIZRFU4RX2tFdgriKRo+Km25dIhKH
 IiJTOyePRSSreAbV3iPWubouMyLuNGtNrcJH32oBNsG1HW72hVqX/3V7GPIZxWvxp8SD
 c0o52CvC0H7MSsaKSZ3yHe1MQRTm/REyTOYrbRv/MPIBP7HFrwveLfhypLRslNmvWx5T
 AXwuE/q+W6fl4/DynadIgzBIeDtRnbYh5LzsgrBjiYfDfC+FN2k+aH6+CknCyQEe9ZFk
 gipA==
X-Gm-Message-State: AOJu0YzhvxermvluiNQ0OxQHg9c1LgxRVpxwAlQea4j5R5GHZX84UQYP
 gxkLohWASLzjuNVdXUGbAVUvTYwX+Y1U8Xyv8+8HK7l02kDAdCejqNgtEc7Bxzm9nDRJzJnBarq
 hm54=
X-Google-Smtp-Source: AGHT+IHsNU2BByTFgynaLpKPMjyg7GJq6dtxZuHp3kp/sS/nwXmpzLaK7Sbbz59P9/NOkz0OU7Xklw==
X-Received: by 2002:a19:740f:0:b0:513:cba0:1caa with SMTP id
 v15-20020a19740f000000b00513cba01caamr1016436lfe.36.1710347044722; 
 Wed, 13 Mar 2024 09:24:04 -0700 (PDT)
Received: from hades.. (ppp046103107123.access.hol.gr. [46.103.107.123])
 by smtp.gmail.com with ESMTPSA id
 bh21-20020a170906a0d500b00a44efa48c24sm4998860ejb.117.2024.03.13.09.24.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Mar 2024 09:24:04 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: u-boot@lists.denx.de,
	trini@konsulko.com,
	cfsworks@gmail.com
Cc: caleb.connolly@linaro.org, sumit.garg@linaro.org,
 richard.henderson@linaro.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Michal Simek <michal.simek@amd.com>,
 Yegor Yefremov <yegorslists@googlemail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Sam Edwards <CFSworks@gmail.com>,
 Shiji Yang <yangshiji66@outlook.com>, Bin Meng <bmeng@tinylab.org>
Subject: [PATCH v3 7/7] arm: remove redundant section alignments
Date: Wed, 13 Mar 2024 18:23:21 +0200
Message-Id: <20240313162324.2117909-8-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20240313162324.2117909-1-ilias.apalodimas@linaro.org>
References: <20240313162324.2117909-1-ilias.apalodimas@linaro.org>
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

Previous patches cleaning up linker symbols, also merged any explicit
. = ALIGN(x); into section definitions -- e.g
.bss ALIGN(x) : instead of

. = ALIGN(x);
. bss : {...}

However, if the output address is not specified then one will be chosen
for the section. This address will be adjusted to fit the alignment
requirement of the output section following the strictest alignment of
any input section contained within the output section. So let's get rid
of the redundant ALIGN directives when they are not needed.

While at add comments for the alignment of __bss_start/end since our
C runtime setup assembly assumes that __bss_start - __bss_end will be
a multiple of 4/8 for armv7 and armv8 respectively.

It's worth noting that the alignment is preserved on .rel.dyn for
mach-zynq which was explicitly aligning that section on an 8b
boundary instead of 4b one.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 arch/arm/cpu/armv8/u-boot.lds | 9 ++++++---
 arch/arm/cpu/u-boot.lds       | 8 ++++++--
 arch/arm/mach-zynq/u-boot.lds | 4 ++--
 3 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/arch/arm/cpu/armv8/u-boot.lds b/arch/arm/cpu/armv8/u-boot.lds
index 147a6e8028d5..857f44412e07 100644
--- a/arch/arm/cpu/armv8/u-boot.lds
+++ b/arch/arm/cpu/armv8/u-boot.lds
@@ -115,7 +115,7 @@ SECTIONS
 		KEEP(*(SORT(__u_boot_list*)));
 	}
 
-	.efi_runtime_rel ALIGN(8) : {
+	.efi_runtime_rel : {
                 __efi_runtime_rel_start = .;
 		*(.rel*.efi_runtime)
 		*(.rel*.efi_runtime.*)
@@ -125,7 +125,7 @@ SECTIONS
 	. = ALIGN(8);
 	__image_copy_end = .;
 
-	.rela.dyn ALIGN(8) : {
+	.rela.dyn : {
 		__rel_dyn_start = .;
 		*(.rela*)
 		__rel_dyn_end = .;
@@ -133,7 +133,10 @@ SECTIONS
 
 	_end = .;
 
-	.bss ALIGN(8): {
+	/*
+	 * arch/arm/lib/crt0_64.S assumes __bss_start - __bss_end % 8 == 0
+	 */
+	.bss ALIGN(8) : {
 		__bss_start = .;
 		*(.bss*)
 		. = ALIGN(8);
diff --git a/arch/arm/cpu/u-boot.lds b/arch/arm/cpu/u-boot.lds
index 798858e3ed6e..707b19795f08 100644
--- a/arch/arm/cpu/u-boot.lds
+++ b/arch/arm/cpu/u-boot.lds
@@ -43,7 +43,7 @@ SECTIONS
 	}
 
 	/* This needs to come before *(.text*) */
-	.efi_runtime ALIGN(4) : {
+	.efi_runtime : {
 		__efi_runtime_start = .;
 		*(.text.efi_runtime*)
 		*(.rodata.efi_runtime*)
@@ -146,7 +146,7 @@ SECTIONS
 		KEEP(*(SORT(__u_boot_list*)));
 	}
 
-	.efi_runtime_rel ALIGN(4) : {
+	.efi_runtime_rel : {
 		__efi_runtime_rel_start = .;
 		*(.rel*.efi_runtime)
 		*(.rel*.efi_runtime.*)
@@ -156,6 +156,10 @@ SECTIONS
 	. = ALIGN(4);
 	__image_copy_end = .;
 
+	/*
+	 * if CONFIG_USE_ARCH_MEMSET is not selected __bss_end - __bss_start
+	 * needs to be a multiple of 4 and we overlay .bss with .rel.dyn
+	 */
 	.rel.dyn ALIGN(4) : {
 		__rel_dyn_start = .;
 		*(.rel*)
diff --git a/arch/arm/mach-zynq/u-boot.lds b/arch/arm/mach-zynq/u-boot.lds
index f6c99a8ce218..3e0c96c50556 100644
--- a/arch/arm/mach-zynq/u-boot.lds
+++ b/arch/arm/mach-zynq/u-boot.lds
@@ -22,7 +22,7 @@ SECTIONS
 	}
 
 	/* This needs to come before *(.text*) */
-	.efi_runtime ALIGN(4) : {
+	.efi_runtime : {
 		__efi_runtime_start = .;
 		*(.text.efi_runtime*)
 		*(.rodata.efi_runtime*)
@@ -52,7 +52,7 @@ SECTIONS
 		KEEP(*(SORT(__u_boot_list*)));
 	}
 
-	.efi_runtime_rel ALIGN(4) : {
+	.efi_runtime_rel : {
 		__efi_runtime_rel_start = .;
 		*(.rel*.efi_runtime)
 		*(.rel*.efi_runtime.*)
-- 
2.37.2

