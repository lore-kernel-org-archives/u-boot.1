Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5A89C54E66
	for <u-boot@archiver.kernel.org>; Wed, 13 Mar 2024 16:24:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E977387F19;
	Wed, 13 Mar 2024 17:23:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Qm3ygV5f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B99F87EA8; Wed, 13 Mar 2024 17:23:57 +0100 (CET)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97CEA87F07
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 17:23:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-513c8530daeso40616e87.2
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 09:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710347035; x=1710951835; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bjKrvGkOI7iiwRM0lPDhhs6RRG3TK0w+7djk6/pkbKo=;
 b=Qm3ygV5fkeUunLp8TNtPHmzBjlJfJw/4D5NV4bE0wUpwFBLqtS0GtbSLEISrO+lnfW
 LUC/bXbhULhmsNxDEFpSgcknRXnhK8AJEI+itFNU4K2HkOZPfhQyvGzEmdYYKBv51N6E
 O95XKhh0FujRKLyYT2GxJDYX8xkObM+A1Z6IIPR1GQDANQd+eRmC6m+eRDzqVya42Hmg
 GEhRzlP6aIAWRtTxCkXIcaMuKnJNCDVok2kjFGNcwm7XMfiRwAbLPSwPwogiPORj2usp
 u1N6PD4ON0PbjuN3f1l3860Pky2tWDftzTKjUEQvg9wgGkfoFQlZ6ihYmcZ6r+y37iH+
 jUSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710347035; x=1710951835;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bjKrvGkOI7iiwRM0lPDhhs6RRG3TK0w+7djk6/pkbKo=;
 b=kofjsN9OegjK+PcGXGxdtSGQjggTs6K0VvuYyg0oCd0o9ddCp9RQhkxa65En4u9M14
 Uuo+9MI53HGzyt/MWuvosHcl/9xoJg4vWHoUTO8uOxlJM/C5FpW6JoQuczN6aO2tulP+
 bytnXI1gJNuqI4IbzgS3Cp7tr+jpBU0FeCkFFwop0JYy4d4JaSfDoOeq8Uax8/IIQ0Fl
 a98F0NYbW1WhP5O3LLcFhVIumV2wlpMjng9h9Id1oAoIDHqSQNm8lHq2EkDK/CtJeOCV
 Eck9sU41rFPAznE/H3Ji414PtBKIohJUFwidN8KkXXLFgEwOYfQdS6T772ryiKgkTbVU
 M8xg==
X-Gm-Message-State: AOJu0Yzb7D5shxOFyDvuE9X5W2QkzbTEWTecU9rtADUgFSV7BWQt1Lf3
 Sw/0VmdkFYH+wwUzM4YjwsnQJoKzhLPUadcQSk38Z7rzv+RG182jsHZh1U4b2tvZR+iXGg/WlKS
 +9tM=
X-Google-Smtp-Source: AGHT+IFUTRp8yhTERs6WAIt16yT0R2rfAIXxZrF5NJ2bN6+fF5tbeW8MF7DCHRjHv8p5qDSIbQJP3w==
X-Received: by 2002:ac2:4d81:0:b0:513:80cd:e80b with SMTP id
 g1-20020ac24d81000000b0051380cde80bmr8927830lfe.29.1710347034685; 
 Wed, 13 Mar 2024 09:23:54 -0700 (PDT)
Received: from hades.. (ppp046103107123.access.hol.gr. [46.103.107.123])
 by smtp.gmail.com with ESMTPSA id
 bh21-20020a170906a0d500b00a44efa48c24sm4998860ejb.117.2024.03.13.09.23.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Mar 2024 09:23:54 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: u-boot@lists.denx.de,
	trini@konsulko.com,
	cfsworks@gmail.com
Cc: caleb.connolly@linaro.org, sumit.garg@linaro.org,
 richard.henderson@linaro.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>, Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Michal Simek <michal.simek@amd.com>,
 Yegor Yefremov <yegorslists@googlemail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Shiji Yang <yangshiji66@outlook.com>, Bin Meng <bmeng@tinylab.org>
Subject: [PATCH v3 5/7] arm: fix __efi_runtime_start/end definitions
Date: Wed, 13 Mar 2024 18:23:19 +0200
Message-Id: <20240313162324.2117909-6-ilias.apalodimas@linaro.org>
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

__efi_runtime_start/end are defined as c variables for arm7 only in
order to force the compiler emit relative references. However, defining
those within a section definition will do the same thing since [0].
On top of that the v8 linker scripts define it as a symbol.

So let's remove the special sections from the linker scripts, the
variable definitions from sections.c and define them as a symbols within
the correct section.

[0] binutils commit 6b3b0ab89663 ("Make linker assigned symbol dynamic only for shared object")

Suggested-by: Sam Edwards <CFSworks@gmail.com>
Reviewed-by: Sam Edwards <CFSworks@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Sam Edwards <CFSworks@gmail.com> # Binary output identical
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 arch/arm/cpu/u-boot.lds        | 12 +++---------
 arch/arm/lib/sections.c        |  2 --
 arch/arm/mach-zynq/u-boot.lds  | 12 +++---------
 include/asm-generic/sections.h |  1 +
 4 files changed, 7 insertions(+), 20 deletions(-)

diff --git a/arch/arm/cpu/u-boot.lds b/arch/arm/cpu/u-boot.lds
index 0682d34207fa..6813d8aeb838 100644
--- a/arch/arm/cpu/u-boot.lds
+++ b/arch/arm/cpu/u-boot.lds
@@ -43,18 +43,12 @@ SECTIONS
 	}
 
 	/* This needs to come before *(.text*) */
-	.__efi_runtime_start : {
-		*(.__efi_runtime_start)
-	}
-
-	.efi_runtime : {
+	.efi_runtime ALIGN(4) : {
+		__efi_runtime_start = .;
 		*(.text.efi_runtime*)
 		*(.rodata.efi_runtime*)
 		*(.data.efi_runtime*)
-	}
-
-	.__efi_runtime_stop : {
-		*(.__efi_runtime_stop)
+		__efi_runtime_stop = .;
 	}
 
 	.text_rest :
diff --git a/arch/arm/lib/sections.c b/arch/arm/lib/sections.c
index 1ee3dd3667ba..a4d4202e99f5 100644
--- a/arch/arm/lib/sections.c
+++ b/arch/arm/lib/sections.c
@@ -25,6 +25,4 @@ char __secure_start[0] __section(".__secure_start");
 char __secure_end[0] __section(".__secure_end");
 char __secure_stack_start[0] __section(".__secure_stack_start");
 char __secure_stack_end[0] __section(".__secure_stack_end");
-char __efi_runtime_start[0] __section(".__efi_runtime_start");
-char __efi_runtime_stop[0] __section(".__efi_runtime_stop");
 char _end[0] __section(".__end");
diff --git a/arch/arm/mach-zynq/u-boot.lds b/arch/arm/mach-zynq/u-boot.lds
index 3b1f0d349356..9eac7de0dcbd 100644
--- a/arch/arm/mach-zynq/u-boot.lds
+++ b/arch/arm/mach-zynq/u-boot.lds
@@ -22,18 +22,12 @@ SECTIONS
 	}
 
 	/* This needs to come before *(.text*) */
-	.__efi_runtime_start : {
-		*(.__efi_runtime_start)
-	}
-
-	.efi_runtime : {
+	.efi_runtime ALIGN(4) : {
+		__efi_runtime_start = .;
 		*(.text.efi_runtime*)
 		*(.rodata.efi_runtime*)
 		*(.data.efi_runtime*)
-	}
-
-	.__efi_runtime_stop : {
-		*(.__efi_runtime_stop)
+		__efi_runtime_stop = .;
 	}
 
 	.text_rest :
diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
index 60949200dd93..b6bca53db10d 100644
--- a/include/asm-generic/sections.h
+++ b/include/asm-generic/sections.h
@@ -35,6 +35,7 @@ extern char __priv_data_start[], __priv_data_end[];
 extern char __ctors_start[], __ctors_end[];
 
 extern char __efi_runtime_rel_start[], __efi_runtime_rel_stop[];
+extern char __efi_runtime_start[], __efi_runtime_stop[];
 
 /* function descriptor handling (if any).  Override
  * in asm/sections.h */
-- 
2.37.2

