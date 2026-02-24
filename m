Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73823F357AD
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 14:27:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3826E83F26;
	Tue, 24 Feb 2026 15:26:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GpnVYj3s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17E0583F20; Tue, 24 Feb 2026 15:26:37 +0100 (CET)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0717583F0A
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 15:26:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-463a0e14abfso3851124b6e.2
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 06:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1771943193; x=1772547993; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AmjzLBOpGWTouu1eCAp4J0pdLkYx1N2bBR/fRpbgKf8=;
 b=GpnVYj3sGNASuYV4qK2JvR+/famtU4eKb/4Jl53Jc+otC0LluImv4f63blVVWk/QEj
 4KaO7WE7sbYO5j7b2CTSR3mPJHmexfVqq24IGOHPbtmh6/+0EsiHKlFyqaLOwPZRspFX
 Dlxg6rduNn1q0gm9A1uOAVO8EJcFwNDeV8exM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771943193; x=1772547993;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AmjzLBOpGWTouu1eCAp4J0pdLkYx1N2bBR/fRpbgKf8=;
 b=HiiuXWW/WlmbkQSqNKfOd6iiDgLu9Ta3N+V1K06ce/vjhNBLZmoKKwb97/xysqt02Z
 e0i/elWcG5cbc0DcGhOF6v6NpzpIYxBiBFOiYau2BeApwyj0pl2dqv9c6XZ+ycno1cQh
 PdOT0RwbSxBIgch3RbJmEpPu4w1S3SHhSv11S1ZHFM3lD2NXzzqwbQwpzqki10MDbGSf
 iKNQa9txuLyliuAaRRGcLBlbc4pSBk98oMZrYRhcMacDXNnq5GSxyaVd+6smr9vgkMRr
 HW3ThNDwnsvZy1l5BgmdtI9+xT/6RKHzcPxnruwEQGTAqookMZ1f01hwwEzwKENZO2eU
 67rQ==
X-Gm-Message-State: AOJu0Yw8dav/mEvgI1sLr1mYP3Lzt9esZU72sWP5EIHBHBh04C8fwIUv
 5/hFhIFoURjn5L9eQ6NtXo5A9miZviEU4etA0irkCBmlnSw464YU4w6/5OPJNNWM+DidS4LEokC
 bnF8=
X-Gm-Gg: ATEYQzwE3nUQQHPT3h/fnBKPY2hwsw5sLLqRToShg4zbvoEK/nf/72/4B4l8IKU9lVo
 5RBZDkrG1ayF6nitsMD/y5heDqcDYAqpY07gNymiNuRflrKg2tjHXi/UNlz/ItOIoi0Vk5sINjl
 90qksFDZHFdF3BRGytQOE3NUEm/GSwlitYXh9daHAEcFMgBu2yJ+fDAJt6SKyCLH6ZKZJVNNM4S
 nbzPOwCThJq1E6tN0lOOLPYUZan+Ol+42f89kEkNS8jtHHD8Io7tRobCxRxGW4K1/kw9LhqzmF8
 lBiYnvdvZiJgsRdCk/HmqutdNUlaO2TIcXjhLiiHISboznM+8H567UAsGAcJkbZH4wnqLm+hO1D
 rxoc3DI4h/TaCAlDVCuXRVAJCcbJk5kxWJ8+InPGK2tvkpQKYuG0k/GLxZN8cE7fk9D9RzedB+k
 r/6+fGwcoSyBoDUXbvPxjCzZVp9De2bT8jm2psXRW/
X-Received: by 2002:a05:687c:4093:b0:3ec:4067:3d1e with SMTP id
 586e51a60fabf-4157b15f486mr7105712fac.40.1771943193068; 
 Tue, 24 Feb 2026 06:26:33 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4157cd5e168sm10199478fac.4.2026.02.24.06.26.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 06:26:32 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
X-Google-Original-From: Simon Glass <simon.glass@canonical.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Leo <ycliang@andestech.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Rick Chen <rick@andestech.com>
Subject: [PATCH v2 7/9] riscv: Drop board_quiesce_devices()
Date: Tue, 24 Feb 2026 07:25:49 -0700
Message-ID: <20260224142553.1608883-8-simon.glass@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260224142553.1608883-1-simon.glass@canonical.com>
References: <20260224142553.1608883-1-simon.glass@canonical.com>
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

This is not used on RISC-V so drop it.

Signed-off-by: Simon Glass <simon.glass@canonical.com>
---

Changes in v2:
- Drop the call to udc_disconnect()

 arch/riscv/include/asm/u-boot-riscv.h | 1 -
 arch/riscv/lib/bootm.c                | 6 ------
 2 files changed, 7 deletions(-)

diff --git a/arch/riscv/include/asm/u-boot-riscv.h b/arch/riscv/include/asm/u-boot-riscv.h
index 543a1688db8..3a8fdb57136 100644
--- a/arch/riscv/include/asm/u-boot-riscv.h
+++ b/arch/riscv/include/asm/u-boot-riscv.h
@@ -16,7 +16,6 @@ int cleanup_before_linux(void);
 
 /* board/.../... */
 int board_init(void);
-void board_quiesce_devices(void);
 int riscv_board_reserved_mem_fixup(void *fdt);
 int riscv_fdt_copy_resv_mem_node(const void *src_fdt, void *dest_fdt);
 
diff --git a/arch/riscv/lib/bootm.c b/arch/riscv/lib/bootm.c
index 9544907ab1e..c6a008a4559 100644
--- a/arch/riscv/lib/bootm.c
+++ b/arch/riscv/lib/bootm.c
@@ -25,10 +25,6 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
-__weak void board_quiesce_devices(void)
-{
-}
-
 /**
  * announce_and_cleanup() - Print message and prepare for kernel boot
  *
@@ -46,8 +42,6 @@ static void announce_and_cleanup(int fake)
 	bootstage_report();
 #endif
 
-	board_quiesce_devices();
-
 	/*
 	 * Call remove function of all devices with a removal flag set.
 	 * This may be useful for last-stage operations, like cancelling
-- 
2.43.0

