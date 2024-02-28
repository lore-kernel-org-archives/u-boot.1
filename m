Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CCD7C47DD9
	for <u-boot@archiver.kernel.org>; Wed, 28 Feb 2024 10:50:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD5598808F;
	Wed, 28 Feb 2024 11:48:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YMtrQtOR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54C7A8807F; Wed, 28 Feb 2024 11:48:55 +0100 (CET)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CAE387D6B
 for <u-boot@lists.denx.de>; Wed, 28 Feb 2024 11:48:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2d23d301452so72888781fa.1
 for <u-boot@lists.denx.de>; Wed, 28 Feb 2024 02:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709117330; x=1709722130; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BKKm1T6gVHFqZLotspT9wUJpiU11Yz1hR1t56PvKfWo=;
 b=YMtrQtORRocxykgDgayKmDy63p7afPYKA1YiwuX/v8/PI4FcO7d6bcieLiIdFTATU2
 OhdqrTzGNaidDAmUn9lMG8UQMaWXLRWMg6A+Zgh9WXfmTovQSzTRsa82L/WmgK8Pvje4
 m3Sf1MORlsncc0QIcOUU2ta+mkMACmlYcwOvFgYbr6Iwi4LA4kIIho0e+YkJ7WSbPQ7h
 Zgoo5O22hMcIe6WnFWO1ZegNzLwaSF5GUKFjAE/hmIMJbvhD9AzVnPNU5AdRni9xQ6lA
 3SOHXd6AhfIm7dDwJV/97Zl61eP6Ik4NO4Y+J6rwvLR9jMLBfuwUrnl+3tg7L/jl9q2u
 rShw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709117330; x=1709722130;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BKKm1T6gVHFqZLotspT9wUJpiU11Yz1hR1t56PvKfWo=;
 b=SfT2nP4cylAZO1ZeO1DwLtP3KUN8Q9Y/Mq0AtoLfFDf6vhV3B/eMc2jP3qU3x3iIoL
 zjeYYXtLPrjcgiLjBA0k1ts0JDbXwShVtWa45WQyGrF9hACvSyDVhvIYhXc2C3HPGN34
 PoVCTQosL90YeX3V3VSQUfLcCavIsKVCNlBeSZf/8NHxeAkto5li8U6yJp7xXbHl8mlT
 oz3knnSl0fkBgLXt+d+79wHSj6FcoLWXHQv6qySVwEVMAUUpgV1nTwTtydRDfvFw100r
 cv4iwMpmr+vRfhJDwSUd4HkpW9I9PNoUPLRouZtduBH06pA4QSYlX5x2kJVlEWKDGV1s
 LWDA==
X-Gm-Message-State: AOJu0YxfRB8TByXaMglY5LI4NaGsyn2BZEYUsmeRcD7xWoVv1CoDKzyV
 cvm878MWcqVbPjsnOiZgC9uy+W3tyT9/GHnwHf4ojgwi1qzjrT0XEfO6cifQghL0NlNaZ5dBN4l
 Z1Iw=
X-Google-Smtp-Source: AGHT+IFebRnXs1KjQ4xPAJf1bMsDlr3HTpnsTThiRTs3VWRfUycfESQ2yzOtqSPmpv/DeFZTtYCh9w==
X-Received: by 2002:a2e:9586:0:b0:2d2:b68f:661 with SMTP id
 w6-20020a2e9586000000b002d2b68f0661mr1096927ljh.28.1709117330199; 
 Wed, 28 Feb 2024 02:48:50 -0800 (PST)
Received: from hades.. ([78.87.146.252]) by smtp.gmail.com with ESMTPSA id
 x1-20020a05600c2a4100b00410dd253008sm1680314wme.42.2024.02.28.02.48.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 02:48:49 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: u-boot@lists.denx.de,
	trini@konsulko.com,
	cfsworks@gmail.com
Cc: caleb.connolly@linaro.org, sumit.garg@linaro.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Michal Simek <michal.simek@amd.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Yegor Yefremov <yegorslists@googlemail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Shiji Yang <yangshiji66@outlook.com>, Bin Meng <bmeng@tinylab.org>
Subject: [RFC PATCH 5/6] arm: fix __efi_runtime_start/end definitions
Date: Wed, 28 Feb 2024 12:48:08 +0200
Message-Id: <20240228104811.1366694-6-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20240228104811.1366694-1-ilias.apalodimas@linaro.org>
References: <20240228104811.1366694-1-ilias.apalodimas@linaro.org>
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
those within a section definition will do the same thing. On top of that
the v8 linker scripts define it as a symbol.

So let's remove the special sections from the linker scripts, the
variable definitions from sections.c and define them as a symbols within
the correct section.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 arch/arm/cpu/u-boot.lds        | 12 +++---------
 arch/arm/lib/sections.c        |  2 --
 arch/arm/mach-zynq/u-boot.lds  | 12 +++---------
 include/asm-generic/sections.h |  1 +
 4 files changed, 7 insertions(+), 20 deletions(-)

diff --git a/arch/arm/cpu/u-boot.lds b/arch/arm/cpu/u-boot.lds
index 7c6e7891d360..df55bb716e35 100644
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
index 71dea4a1f60a..fcd0f42a7106 100644
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

