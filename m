Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C76DC54E58
	for <u-boot@archiver.kernel.org>; Fri, 15 Mar 2024 06:45:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C475587FDE;
	Fri, 15 Mar 2024 07:44:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EoDjQhXg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 310A887FE5; Fri, 15 Mar 2024 07:44:38 +0100 (CET)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A62987FDD
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 07:44:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-512bde3d197so1734404e87.0
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 23:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710485074; x=1711089874; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MRm70MaX0hCLjwZUUTejH8I4YuwL8Hxl9oz63TDtGAk=;
 b=EoDjQhXgCYJ4rj2Apgz/24rIqBaQo67uAANMseJMj9hY6HgX93BIUtloz1yEZeY+MJ
 7pgUG5XF1lPGb8Dtr/tTmbqxygsI25UIJjCdAZrf7URPyOj2NP6S2A4rbhkvzknhrI1z
 +BAt5iawVxsjs3gqaWDpuQSGkjfjwJCrTWd5qcB/4TAsNOX69DT6Nll2MjgmyGyanUhn
 0YGgAAUQps/Vfn0o3cLyJBJ0wzTvdmb+dIQziaFu5RDg2v40Okw7XI1YY9Q9XLA8JDUd
 e3P3MSzJLGdVC2eIRrHf66/FQBQNNkDOZbC37J0FypMSMACJxmHivK70R0P+1oKAEXk2
 vEQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710485074; x=1711089874;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MRm70MaX0hCLjwZUUTejH8I4YuwL8Hxl9oz63TDtGAk=;
 b=fSDg6/AQ7EpY4lIhCLO1Xl+qOGanLq1HAKxL1I6hg9pA71bU6Ropn01XUvz8elpuIk
 lqR0Gu0au8JQ4TajTrJgvzEcjDXOXb/fRZZm14ZbzxSge2RsVhMIFsjTepNCWLoSGtYa
 u6mOzZHXvyDrSp3TecmYLEBmsxPSABYUpAfmnAghIPLQ3C4CIj5o3HakTKQ65+j/3y5F
 ZFn7Pixkpaz/l07TmBZ4+z0kx0Nb1XaUwxSiEEslrVt3YP8uUQEXeICCZTckKTfELZau
 Qbw0eUZfT/wGmOuTNDATnfVaoX+2/IgBtTiMpm0UpFsk6+jFTbhT79asz2zLzHoCrrl8
 Md8Q==
X-Gm-Message-State: AOJu0YzCaXwtVBgIrqx693lsPe4qaMhQ6xUxS/kWG4yX11hSQ2WKCxrW
 Ikwlqz4XaPJWMtiuBRjp8BV1M15MPMfULveSwSun3sigMq9RXWBIrXzVaH0hS528Xc26r/bbDnD
 H
X-Google-Smtp-Source: AGHT+IFxQcsH4KufJwSigRw7yJwSqB0wHxdGMtxe7SpKxbxmWE0hWSDO+UnHZfUU3b1OUSvcdnG6Vg==
X-Received: by 2002:ac2:44b3:0:b0:513:7:fc3c with SMTP id
 c19-20020ac244b3000000b005130007fc3cmr2845360lfm.55.1710485074332; 
 Thu, 14 Mar 2024 23:44:34 -0700 (PDT)
Received: from hades.. (ppp046103107123.access.hol.gr. [46.103.107.123])
 by smtp.gmail.com with ESMTPSA id
 v18-20020adfe4d2000000b0033ec9936909sm2398658wrm.39.2024.03.14.23.44.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Mar 2024 23:44:34 -0700 (PDT)
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
Subject: [PATCH v4 7/7] arm: remove redundant section alignments
Date: Fri, 15 Mar 2024 08:43:51 +0200
Message-Id: <20240315064354.2215266-8-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20240315064354.2215266-1-ilias.apalodimas@linaro.org>
References: <20240315064354.2215266-1-ilias.apalodimas@linaro.org>
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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

