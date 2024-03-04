Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA5E2C48BF6
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 09:02:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A825587DAB;
	Mon,  4 Mar 2024 10:01:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="F/srCyH8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DBD786FCE; Mon,  4 Mar 2024 10:01:39 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02EC587DB7
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 10:01:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-412de18edcaso6959155e9.3
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 01:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709542889; x=1710147689; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uCjEZk+hn7YNvUHPw/I6m4Ni9W92nQmew7vxuOthRyA=;
 b=F/srCyH8fTcinHhSPgmUsvHmcyHxTdaRUW1Regp2yG7Fcs2eI+dNvyLpVPPg67AKxc
 olPogIpWkkvH3RdUDKTVkIcapqdPEoUTO40sXDfcubhWb3wWa5BZtItKCwyNJK0ojP4E
 jYk+KRRnWzZyMqLpeB3TLjGfopK3JEbksPuUkqGycfjsMHsjGh7gfo2ayNuGXsv/w4ZA
 Qpu+kD7B1Z8ivwhxJkREQ+PhMTBR2jYtKv04/+mSvjiVZsbjBfaK864RjdCYu4H64/mJ
 h2Jorm48L6xT0H/TBn8B7T5p32BJ4HJrc3H1nAiVwZ0mZLEGEW2W4zLKPGkTr97UX16Z
 SftQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709542889; x=1710147689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uCjEZk+hn7YNvUHPw/I6m4Ni9W92nQmew7vxuOthRyA=;
 b=cZ6YD65M/L4f3m90nJVAUk//OmqdGj1PRDo3DoECfXNAYwpDiCkyvHf7bA0Ueq1Gfa
 ll7ALZX28w32EPcb9FXjyObC14op5aA5/9JcA5NjwqmymGnces6Ws+wzI7u+qHU3OE5s
 HIcG5YZM3PQwAUqXMpNPUNxngiZ2WU3saDxRUM+gli5XH1bjenwh2H6VRQWT362JIPSR
 EHKeV5PUtZa2xB1ZgFhvzGdxv1DCuk6QvKiMBlXJI6MykLfXwT6ebxFhSMcuhzOaBGhd
 6dsLMuVyq4FnQAdqG/NnDJt4jy0ufIbVDnNDwAiWbGERwREj8EBI5r/Xe8+Im3aSgZ6y
 tkmg==
X-Gm-Message-State: AOJu0Yzwv9XZEzlcXIch8OYZxvO0+pxykHSkcdeDG3n6KbQu1++49PQV
 NJPCDFHwF88r5b2MW8PeaC8D06p8hW9/9famTI1SNdf0a/fYDQIT66d15xOtHZFSz4OaUb2m/KO
 Ask0=
X-Google-Smtp-Source: AGHT+IEAUhhjdZ1Ir11ata9a9IA4LPm4306RJQx1YOamyngshAjOuP5mj+zYdA0XM5SiyIitT3YI7A==
X-Received: by 2002:a05:600c:474e:b0:412:c2a3:4431 with SMTP id
 w14-20020a05600c474e00b00412c2a34431mr6750780wmo.14.1709542889369; 
 Mon, 04 Mar 2024 01:01:29 -0800 (PST)
Received: from hades.. (ppp046103107123.access.hol.gr. [46.103.107.123])
 by smtp.gmail.com with ESMTPSA id
 t11-20020a05600c198b00b00412c8117a34sm10281167wmq.47.2024.03.04.01.01.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 01:01:29 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: u-boot@lists.denx.de,
	trini@konsulko.com,
	cfsworks@gmail.com
Cc: caleb.connolly@linaro.org, sumit.garg@linaro.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Michal Simek <michal.simek@amd.com>,
 Yegor Yefremov <yegorslists@googlemail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Shiji Yang <yangshiji66@outlook.com>, Bin Meng <bmeng@tinylab.org>
Subject: [PATCH 3/6] arm: fix __efi_runtime_rel_start/end definitions
Date: Mon,  4 Mar 2024 11:01:08 +0200
Message-Id: <20240304090113.1410575-4-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20240304090113.1410575-1-ilias.apalodimas@linaro.org>
References: <20240304090113.1410575-1-ilias.apalodimas@linaro.org>
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

__efi_runtime_rel_start/end are defined as c variables for arm7 only in
order to force the compiler emit relative references. However, defining
those within a section definition will do the same thing. On top of that
the v8 linker scripts define it as a symbol.

So let's remove the special sections from the linker scripts, the
variable definitions from sections.c and define them as a symbols within
the correct section.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 arch/arm/cpu/armv8/u-boot.lds  |  4 +---
 arch/arm/cpu/u-boot.lds        | 16 +++-------------
 arch/arm/lib/sections.c        |  2 --
 arch/arm/mach-zynq/u-boot.lds  | 16 +++-------------
 include/asm-generic/sections.h |  2 ++
 lib/efi_loader/efi_runtime.c   |  1 +
 6 files changed, 10 insertions(+), 31 deletions(-)

diff --git a/arch/arm/cpu/armv8/u-boot.lds b/arch/arm/cpu/armv8/u-boot.lds
index c4ee10ebc3ff..eccb116d3cfa 100644
--- a/arch/arm/cpu/armv8/u-boot.lds
+++ b/arch/arm/cpu/armv8/u-boot.lds
@@ -115,9 +115,7 @@ SECTIONS
 		KEEP(*(SORT(__u_boot_list*)));
 	}
 
-	. = ALIGN(8);
-
-	.efi_runtime_rel : {
+	.efi_runtime_rel ALIGN(8) : {
                 __efi_runtime_rel_start = .;
 		*(.rel*.efi_runtime)
 		*(.rel*.efi_runtime.*)
diff --git a/arch/arm/cpu/u-boot.lds b/arch/arm/cpu/u-boot.lds
index 90d329b1ebe0..70e78ce46672 100644
--- a/arch/arm/cpu/u-boot.lds
+++ b/arch/arm/cpu/u-boot.lds
@@ -152,21 +152,11 @@ SECTIONS
 		KEEP(*(SORT(__u_boot_list*)));
 	}
 
-	. = ALIGN(4);
-
-	.efi_runtime_rel_start :
-	{
-		*(.__efi_runtime_rel_start)
-	}
-
-	.efi_runtime_rel : {
+	.efi_runtime_rel ALIGN(4) : {
+		__efi_runtime_rel_start = .;
 		*(.rel*.efi_runtime)
 		*(.rel*.efi_runtime.*)
-	}
-
-	.efi_runtime_rel_stop :
-	{
-		*(.__efi_runtime_rel_stop)
+		__efi_runtime_rel_stop = .;
 	}
 
 	. = ALIGN(4);
diff --git a/arch/arm/lib/sections.c b/arch/arm/lib/sections.c
index 8e8bd5797e16..ddfde52163fc 100644
--- a/arch/arm/lib/sections.c
+++ b/arch/arm/lib/sections.c
@@ -29,6 +29,4 @@ char __secure_stack_start[0] __section(".__secure_stack_start");
 char __secure_stack_end[0] __section(".__secure_stack_end");
 char __efi_runtime_start[0] __section(".__efi_runtime_start");
 char __efi_runtime_stop[0] __section(".__efi_runtime_stop");
-char __efi_runtime_rel_start[0] __section(".__efi_runtime_rel_start");
-char __efi_runtime_rel_stop[0] __section(".__efi_runtime_rel_stop");
 char _end[0] __section(".__end");
diff --git a/arch/arm/mach-zynq/u-boot.lds b/arch/arm/mach-zynq/u-boot.lds
index 8d3259821719..66a9e37f9198 100644
--- a/arch/arm/mach-zynq/u-boot.lds
+++ b/arch/arm/mach-zynq/u-boot.lds
@@ -58,21 +58,11 @@ SECTIONS
 		KEEP(*(SORT(__u_boot_list*)));
 	}
 
-	. = ALIGN(4);
-
-	.efi_runtime_rel_start :
-	{
-		*(.__efi_runtime_rel_start)
-	}
-
-	.efi_runtime_rel : {
+	.efi_runtime_rel ALIGN(4) : {
+		__efi_runtime_rel_start = .;
 		*(.rel*.efi_runtime)
 		*(.rel*.efi_runtime.*)
-	}
-
-	.efi_runtime_rel_stop :
-	{
-		*(.__efi_runtime_rel_stop)
+		__efi_runtime_rel_stop = .;
 	}
 
 	. = ALIGN(8);
diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
index 1e1657a01673..60949200dd93 100644
--- a/include/asm-generic/sections.h
+++ b/include/asm-generic/sections.h
@@ -34,6 +34,8 @@ extern char __priv_data_start[], __priv_data_end[];
 /* Start and end of .ctors section - used for constructor calls. */
 extern char __ctors_start[], __ctors_end[];
 
+extern char __efi_runtime_rel_start[], __efi_runtime_rel_stop[];
+
 /* function descriptor handling (if any).  Override
  * in asm/sections.h */
 #ifndef dereference_function_descriptor
diff --git a/lib/efi_loader/efi_runtime.c b/lib/efi_loader/efi_runtime.c
index 18da6892e796..9185f1894c47 100644
--- a/lib/efi_loader/efi_runtime.c
+++ b/lib/efi_loader/efi_runtime.c
@@ -15,6 +15,7 @@
 #include <rtc.h>
 #include <asm/global_data.h>
 #include <u-boot/crc.h>
+#include <asm/sections.h>
 
 /* For manual relocation support */
 DECLARE_GLOBAL_DATA_PTR;
-- 
2.37.2

