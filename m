Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCB91FEE4EE
	for <u-boot@archiver.kernel.org>; Sat, 28 Feb 2026 20:21:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FD5C83F4C;
	Sat, 28 Feb 2026 21:20:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kkyUUbmE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA0D183F4D; Sat, 28 Feb 2026 21:20:36 +0100 (CET)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90D8B83EC6
 for <u-boot@lists.denx.de>; Sat, 28 Feb 2026 21:20:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7d4ba9abbecso3976057a34.1
 for <u-boot@lists.denx.de>; Sat, 28 Feb 2026 12:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772310032; x=1772914832; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BAdPrqPIDvw71oCGXIQsQjoY63VM7seEdRzzv5qkOHg=;
 b=kkyUUbmEeaIa58REqnV1QjMJGPuZ48xs0Y/XfGZ7HU+8m07pi+9VTee0KDV9d9Y6xA
 KolHup2UOX7MTflvjH4DPgFwQG53wkKbIug/KTmVoLhOIZ918g3OzdPaGjHWc9IV/UEG
 +tY9rbD6qZaFPXaf5CEA0QOXZ5OoceEp5x7Es=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772310032; x=1772914832;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BAdPrqPIDvw71oCGXIQsQjoY63VM7seEdRzzv5qkOHg=;
 b=cFzJxzB2JeS/CFq6LNikomEH3Vktjs56buvEXieGwxT79vt/mbxH3jwTB8NC8fMn84
 NdvFaxb/MgzhQnwJDn/fcTpZ3pngqrs8CTOdSjT7zTa0qo29Uny8lq8WVPrZiXyqzoio
 GDjE1ReNmm/dzmuGU8upGJfDSz/llzvq0VrkaLaUJWR2JW7HC47uNvEHSBHuBFUnQtpW
 oP0OnMk/ouZpVMP8yiDB/mRnkzQ4vBDoh8Kzo4zwcvdp9IP3TYEz8KmvA485EgB5dr9h
 m7lTtG4tNp3rwDvZFUjRJLRz/Cmm6x8JQjTvEg40Svrj2epP/IAopG+K5MMVMpoztVxz
 oz6g==
X-Gm-Message-State: AOJu0YylREl/ztr2JJeJ33kp9t5yRHCyafyowq84SOa19/kpaBNaVJc/
 GT/RgIm29N2Aq68heYumS6CIlYyGWdhfMAHAh9B8B8hecH6OLX89xNsVH9KFmnrllzxDuaeX4Ql
 p6MI=
X-Gm-Gg: ATEYQzwSuFxh7Hwy1Pno6HdpmIrOzH9NBnU8vS+zUxooFJ1Aipxzlgz47cNnTPtRF7a
 AvBXgljqf6UkGreR/Xl8X2lteHwayTsTqx0vj5nwomCmSU+Km3vTK89/1Ua3RP6W9ziXrFYJazo
 MyzH0fHjkCt3kjUiqQl6il7a21HiB7fZRvjKG0hsv6txUqwbse4Q7Yc8MM1dWysH5FLGyOSyZVH
 4wlopm8Cg7q8j0aswpjVD1Cyg9ZWXcS0keAP14uW4ETwA+Z3eSn1a0F/izN5h1RKv9KZ/mANBQL
 T1OQpVfGWdTx+nrf6mM3cYpSYkj5PDijKUbxf3QmKCbZwOj10+Q9+By/3FzML25vgyC9Kw0LieV
 gVv/LPcGBo4XsLYIJqsspk2FQxsxwvNS2eeQ7EqUrDkxY8HAIRCxN1hvVgyX87UYgw1MeLFxYX7
 kOxs4FJtt9lYI1UiIkbg==
X-Received: by 2002:a05:6830:82aa:b0:7d1:569d:ce7b with SMTP id
 46e09a7af769-7d591c0aa89mr3558569a34.29.1772310031778; 
 Sat, 28 Feb 2026 12:20:31 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d58644edfbsm6978361a34.6.2026.02.28.12.20.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Feb 2026 12:20:31 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Aristo Chen <jj251510319013@gmail.com>, Benjamin ROBIN <dev@benjarobin.fr>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Leo <ycliang@andestech.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Rick Chen <rick@andestech.com>, Sughosh Ganu <sughosh.ganu@arm.com>,
 =?UTF-8?q?=E7=89=9B=20=E5=BF=97=E5=AE=8F?= <Zone.Niuzh@hotmail.com>
Subject: [PATCH v3 06/17] riscv: Call bootm_final()
Date: Sat, 28 Feb 2026 13:19:54 -0700
Message-ID: <20260228202011.1834493-7-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260228202011.1834493-1-sjg@chromium.org>
References: <20260228202011.1834493-1-sjg@chromium.org>
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

From: Simon Glass <simon.glass@canonical.com>

The RISC-V announce_and_cleanup() duplicates the common pre-boot
steps. Replace it with a call to bootm_final().

Move board_quiesce_devices() into bootm_final() so it is available to
all architectures. Drop the RISC-V weak definition and header
declaration since the generic one in bootm.h is used instead.

Signed-off-by: Simon Glass <simon.glass@canonical.com>

---

Changes in v3:
- Drop udc_disconnect()
- Move board_quiesce_devices() into bootm_final() instead of dropping it
- Squash with the previous riscv patches

 arch/riscv/include/asm/u-boot-riscv.h |  1 -
 arch/riscv/lib/bootm.c                | 24 +-----------------------
 boot/bootm.c                          |  2 ++
 3 files changed, 3 insertions(+), 24 deletions(-)

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
index 9544907ab1e..bd47275b52e 100644
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
@@ -36,25 +32,7 @@ __weak void board_quiesce_devices(void)
  */
 static void announce_and_cleanup(int fake)
 {
-	printf("\nStarting kernel ...%s\n\n", fake ?
-		"(fake run for tracing)" : "");
-	bootstage_mark_name(BOOTSTAGE_ID_BOOTM_HANDOFF, "start_kernel");
-#ifdef CONFIG_BOOTSTAGE_FDT
-	bootstage_fdt_add_report();
-#endif
-#if CONFIG_IS_ENABLED(BOOTSTAGE_REPORT)
-	bootstage_report();
-#endif
-
-	board_quiesce_devices();
-
-	/*
-	 * Call remove function of all devices with a removal flag set.
-	 * This may be useful for last-stage operations, like cancelling
-	 * of DMA operation or releasing device internal buffers.
-	 */
-	dm_remove_devices_active();
-
+	bootm_final(fake);
 	cleanup_before_linux();
 }
 
diff --git a/boot/bootm.c b/boot/bootm.c
index 3a69cc0deb0..ac521094db7 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -1206,6 +1206,8 @@ void bootm_final(enum bootm_final_t flags)
 	if (IS_ENABLED(CONFIG_BOOTSTAGE_REPORT))
 		bootstage_report();
 
+	board_quiesce_devices();
+
 	/*
 	 * Call remove function of all devices with a removal flag set.
 	 * This may be useful for last-stage operations, like cancelling
-- 
2.43.0

