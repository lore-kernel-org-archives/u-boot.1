Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B2FFC54E58
	for <u-boot@archiver.kernel.org>; Fri, 15 Mar 2024 06:45:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0055987FBC;
	Fri, 15 Mar 2024 07:44:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rUGbldvJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41CAA87FC0; Fri, 15 Mar 2024 07:44:27 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2BED87FAA
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 07:44:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-33e966f56c7so1808634f8f.0
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 23:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710485064; x=1711089864; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bjKrvGkOI7iiwRM0lPDhhs6RRG3TK0w+7djk6/pkbKo=;
 b=rUGbldvJ0cdBhzugyBCaf9WARmE5dcoqfXECUkgO261Tyxy/DpeJ4pV9mwc0oFtAK7
 u5JgMZqEeDHYKy/6/jPh9D4eF+59Gys+e/eJuC6/y7sjo1krEPl/Jip6IWHoDpD5sDMT
 JpPCF+UjweSPpdsMUz7h6MFuBzF9SD2FUTeQ6l9R2e2dITfOvuMbbuZFya6Zcge7BzrJ
 aFrHIsO3yATOmAIEy18VccAyNBYHFXA6T1WQ/r1PSV9tVg2iVaEOURfqWIhxSW1yo0fz
 fqHuLnVTeBWkF3f0D+TiDmVtbylXimNimQ2sBmYHRKAeggAjT20HrScgYU1Tzy8ACz77
 mVog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710485064; x=1711089864;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bjKrvGkOI7iiwRM0lPDhhs6RRG3TK0w+7djk6/pkbKo=;
 b=K81BaR+zlfWO+lzdwTeaIAd5395reEDVK5W8lCF7nbLk6QrwCR5Y7BiWGl98Qdl051
 b/E6zwUxvmX42UlxzdxayNN7hPGlPjekpdj8EonZws4921MnhHttW1FAigYX1GpjSaLr
 KYiiKN0IgPf40KqDdbYSeqUGhCPa7UaaLtEgcjCv6O78J9JNQeREGtgl3Hz+s+i953go
 wyJUAnnlewEfR5QJ1qP/rwIPkW97mMhRyqAr2tVnclfpYBlvl3/vnGChggtVG2U1p9hI
 LgXIyqK7zLoKIiweP0UaCPq/GuUu+SMSy56nWM36VRpWxcoX3zkDraXcjdxtMC54JeY+
 Gamw==
X-Gm-Message-State: AOJu0Yy829DxDn1tRpeOMLijG/eYuAD6qR/IqF/9JmDOe5vG6Xe+x1h+
 seZ5qhP9QShpCaJrKIKMdfEXGeii5l67+j5m7EDeqQgX1Zz7gmCnuxMvz/3LdsbwLpB+gAnnulF
 u
X-Google-Smtp-Source: AGHT+IGmnM0Vst+kD3zlMGFfk+zihOeLh4tUMnebgfB1SDUCcux3wcXKGMFFg8VRFG7hLgvKhq9Fag==
X-Received: by 2002:a5d:694c:0:b0:33e:7637:51fd with SMTP id
 r12-20020a5d694c000000b0033e763751fdmr1697868wrw.48.1710485064344; 
 Thu, 14 Mar 2024 23:44:24 -0700 (PDT)
Received: from hades.. (ppp046103107123.access.hol.gr. [46.103.107.123])
 by smtp.gmail.com with ESMTPSA id
 v18-20020adfe4d2000000b0033ec9936909sm2398658wrm.39.2024.03.14.23.44.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Mar 2024 23:44:24 -0700 (PDT)
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
Subject: [PATCH v4 5/7] arm: fix __efi_runtime_start/end definitions
Date: Fri, 15 Mar 2024 08:43:49 +0200
Message-Id: <20240315064354.2215266-6-ilias.apalodimas@linaro.org>
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

