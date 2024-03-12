Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35E5AC54E5D
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 14:09:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7991987F8C;
	Tue, 12 Mar 2024 15:09:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BvlxnZzR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C19BE87F4B; Tue, 12 Mar 2024 15:09:14 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB9DE87F75
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 15:09:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-56877761303so742476a12.3
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 07:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710252552; x=1710857352; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EJRs1vrJJ4CKMJShK+cbz2zWdTiiQf+L3+YxItkCyZY=;
 b=BvlxnZzReujRXFLr5ylhePJzTrJYB/Wp4wRgPIHXLB4NXq1kApFEdEQgGnTdnCjWkf
 GpHYvdE1SPyrnDibiKDiu7VKurcr6Jgl0iixa0/7hkkp9JgPCh56eYnwTzMVDoy6pO+V
 Y3PlmrVX2HcN1QFM6GiKOagrR1lBkg7UyigG1Cc8fzKRVQlNThDvAN7zqYanXVxSQMEF
 SKYfs/1P1jgk5naYd4vgjYLhCGpOa+t92RLHtg3gbC4fNhZzuOaJzCQeoQVy/d6PXmJy
 MTE95Bt5de6PmQPMg+2ujotMWX3P3Y55zMdfcQ+gEifJJ9UdFjrtZVAlAGgJQacaj0Tr
 BX3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710252552; x=1710857352;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EJRs1vrJJ4CKMJShK+cbz2zWdTiiQf+L3+YxItkCyZY=;
 b=IhiO+tYbdUOU01aOZxMiAnHT9jvGeb0mvDxc7wVKVO/WV8+tPcxTBOVTyWUw5/avko
 i3uacgcULtNq6cdPsxFxxjNnPoioQzIAfjjBbx81DEQXbYn6pr5Un4owcZpdDwlQ9sCU
 SvGTRGnBeH1Qb3zcFhpB8Pq65j03LCY/7Lo3UbslggpQ7pZWpYJy/3tDt8AxLDrodn24
 xlfOn17iAhFpZoGOuZypeqa+obGaYJwWXqlUrkIg3LzBcF9Dmhrcw2No0ht8jloddi+T
 2V1GuCCD6qPzgUjrL8x+54/cZpc5QvwHNKtWzECzESNJfOIm0G0ZptR0LHul99JVBiO4
 WAmQ==
X-Gm-Message-State: AOJu0YwoYaR4Ih8bMGbKGQqVEXVTj5G5dAROcPirdspQq9BFDlAdCQxx
 8AI+LnPQgkWP35dD9YMNhl1L5QJlm0SirWR5ahxcUy/r2J2U0hBip9EkIVQzRYDTs+imJaVp+YA
 /p88=
X-Google-Smtp-Source: AGHT+IEEG3xOpDF16Na675uxOjkfchkLhYvpwiDZ5ICR0qhrBJuDFbKDQnFHRCtE1Gi/41bYkXlS1w==
X-Received: by 2002:a50:9ee9:0:b0:564:5150:76a2 with SMTP id
 a96-20020a509ee9000000b00564515076a2mr1478384edf.4.1710252552063; 
 Tue, 12 Mar 2024 07:09:12 -0700 (PDT)
Received: from hades.. (ppp046103107123.access.hol.gr. [46.103.107.123])
 by smtp.gmail.com with ESMTPSA id
 d23-20020a056402001700b0056857701bf5sm2246086edu.81.2024.03.12.07.09.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 07:09:11 -0700 (PDT)
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
Subject: [PATCH 7/7 v2] arm: remove redundant section alignments
Date: Tue, 12 Mar 2024 16:08:29 +0200
Message-Id: <20240312140832.1968215-8-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20240312140832.1968215-1-ilias.apalodimas@linaro.org>
References: <20240312140832.1968215-1-ilias.apalodimas@linaro.org>
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
. = ALIGN(x); into section definitions -- e.g '.bss ALIGN(x) :' instead
of '. - ALIGN(x); bss : {...}'

However, if the output address is not specified then one will be chosen
for the section. This address will be adjusted to fit the alignment
requirement of the output section following the strictest alignment of
any input section contained within the output section. So let's get rid
of the redundant ALIGN directives.

It's worth noting that the only platform the alignment is preserved on
.rel.dyn is mach-zynq, which was explicitly  aligning that section on an 8b
boundary instead of the automatically chosen 4b alignment.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 arch/arm/cpu/armv8/u-boot.lds            | 6 +++---
 arch/arm/cpu/u-boot.lds                  | 6 +++---
 arch/arm/mach-rockchip/u-boot-tpl-v8.lds | 2 +-
 arch/arm/mach-zynq/u-boot.lds            | 4 ++--
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/cpu/armv8/u-boot.lds b/arch/arm/cpu/armv8/u-boot.lds
index 33f4624b561d..ccdd1966cfbc 100644
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
@@ -124,7 +124,7 @@ SECTIONS

 	__image_copy_end = .;

-	.rela.dyn ALIGN(8) : {
+	.rela.dyn : {
 		__rel_dyn_start = .;
 		*(.rela*)
 		__rel_dyn_end = .;
@@ -132,7 +132,7 @@ SECTIONS

 	_end = .;

-	.bss ALIGN(8): {
+	.bss : {
 		__bss_start = .;
 		*(.bss*)
 		__bss_end = .;
diff --git a/arch/arm/cpu/u-boot.lds b/arch/arm/cpu/u-boot.lds
index b6b19a4174fe..a9fcbbf22e96 100644
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
@@ -155,7 +155,7 @@ SECTIONS

 	__image_copy_end = .;

-	.rel.dyn ALIGN(4) : {
+	.rel.dyn : {
 		__rel_dyn_start = .;
 		*(.rel*)
 		__rel_dyn_end = .;
diff --git a/arch/arm/mach-rockchip/u-boot-tpl-v8.lds b/arch/arm/mach-rockchip/u-boot-tpl-v8.lds
index 8ff35b5c17cf..e67416c09c1c 100644
--- a/arch/arm/mach-rockchip/u-boot-tpl-v8.lds
+++ b/arch/arm/mach-rockchip/u-boot-tpl-v8.lds
@@ -53,7 +53,7 @@ SECTIONS

 	_image_binary_end = .;

-	.bss ALIGN(8) : {
+	.bss : {
 		__bss_start = .;
 		*(.bss*)
 		__bss_end = .;
diff --git a/arch/arm/mach-zynq/u-boot.lds b/arch/arm/mach-zynq/u-boot.lds
index f739d1cfce85..111410215072 100644
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

