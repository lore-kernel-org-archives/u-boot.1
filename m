Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56174C48BF6
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 09:02:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E74687F8E;
	Mon,  4 Mar 2024 10:01:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zC9cYwng";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB46087F68; Mon,  4 Mar 2024 10:01:47 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5193187F65
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 10:01:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-412e4619e5eso3612425e9.2
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 01:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709542897; x=1710147697; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BKKm1T6gVHFqZLotspT9wUJpiU11Yz1hR1t56PvKfWo=;
 b=zC9cYwngfgBTwbjSKmDZUO5gA+/uW6FoeER6ILr4yLYqstNw7Wtbao/D4V8HKpOtRZ
 k8hI1fu7Mgg7+xWXOUj8zfe/MO0Q427XLiCfD2UU6k0WQrHpt/jpHQhOGtq7e0xZp+C+
 C1kuZEjRtp4GEpG1RAqQYZermOaW0kMMFns2ALX+sMSbZ7VhAevGEYNRV3BRVoU8aQXt
 c9DawkSBX2lmDtpbIo7G0NEHNAtHdV9Q6gIq/4ovyeNON3wMt/VfYsQ1kaKrutPJbbkp
 nE2GXfdvGLwgwT0F2kOnDobxItO+9snXgjUh92qd2m9SYWSOoWChqlYihXhoS+QbDsjA
 BHwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709542897; x=1710147697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BKKm1T6gVHFqZLotspT9wUJpiU11Yz1hR1t56PvKfWo=;
 b=e2RtoYiXX6OjujBiCzTDYwl7ucFoNWH05qDQyfSoWrX80/lpRHmglpRAY0I5DOyKT5
 hOo8SzMamKek77thbc1oE4sZeSxv1T54SEtfLCRvIVZnXQsIfidTvyOirPEwzj+zxQwG
 i7F2GQJxggaZ7K9MB9AOQiZgaFXLjRTg050olF/1J6H2enwxCbKlhkKILR9TdMWmX67b
 AwfRH6MH0Bvw2YZvv3Ups87H4AuaGumXs2TR6m4zPJuRudtt5gs6fmf5r9Tl8DlLJgyi
 y/g42Pq/BBPvJDUNoIAI75kn+otKCbU/RD1jxYAv0HCcE1lZ6CI/Cy/5UbTs5n9wim4w
 Ad7A==
X-Gm-Message-State: AOJu0YxiNfCStvgxKKclNO2ibOLp78CEEBGHHshDkbuVaAB3kuiQhSMc
 da6GLaZZV2Q0Aoegb3fET1c2kFVZ+3tLFXNxcS6RDshQ3KKiik/peNhyW7MrxXWGff1hIX+gNtW
 VhRE=
X-Google-Smtp-Source: AGHT+IHwQGdNJLJpeXD26Al4WYq3iezsTKd+LM9U87r9efW+mNysCOVP6/yvVnEln1H6T2+ewSM9eA==
X-Received: by 2002:a05:600c:1f84:b0:412:aa6f:83d3 with SMTP id
 je4-20020a05600c1f8400b00412aa6f83d3mr6734291wmb.14.1709542897593; 
 Mon, 04 Mar 2024 01:01:37 -0800 (PST)
Received: from hades.. (ppp046103107123.access.hol.gr. [46.103.107.123])
 by smtp.gmail.com with ESMTPSA id
 t11-20020a05600c198b00b00412c8117a34sm10281167wmq.47.2024.03.04.01.01.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 01:01:37 -0800 (PST)
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
Subject: [PATCH 5/6] arm: fix __efi_runtime_start/end definitions
Date: Mon,  4 Mar 2024 11:01:10 +0200
Message-Id: <20240304090113.1410575-6-ilias.apalodimas@linaro.org>
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

