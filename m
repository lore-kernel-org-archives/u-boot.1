Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3731DF513E9
	for <u-boot@archiver.kernel.org>; Fri,  6 Mar 2026 02:38:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C90CB83FED;
	Fri,  6 Mar 2026 03:37:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UgKAkool";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2FD283FD3; Fri,  6 Mar 2026 03:37:18 +0100 (CET)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3DD683F98
 for <u-boot@lists.denx.de>; Fri,  6 Mar 2026 03:37:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-899fa7d0780so51738516d6.3
 for <u-boot@lists.denx.de>; Thu, 05 Mar 2026 18:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772764635; x=1773369435; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dUKo+DiyyJnvXFLCBiQCAB4IYoTuGSKATArzhlrRm8s=;
 b=UgKAkool7S1jbIopPvMR6OQW3kECMHDVPXpL5r+IVklAWeMuIZxZ+0zFkMDpTo/9Dt
 2016xlO++we21pHO670ZG+e9bg52mIdbOV1C1Vmgv1Q1t8YrDsG5IkYgxAOmAOUuBLVX
 PsGtzTenBtPT9rFVuFvSY90rv/s/7CwznWfs0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772764635; x=1773369435;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dUKo+DiyyJnvXFLCBiQCAB4IYoTuGSKATArzhlrRm8s=;
 b=JhI2QcNssiuK9c/IjdKQPbW3JUMgVl1uUs6uVLCdAvRWu9PVZgj54JZIme77FXcY1Q
 iYZZa76N6FCSflF8p4Krk0hghiu9jc5nETcdFVOkowpUa4nEfZWIJh8uXtIGg7rkfTOw
 1LI9XTBStPI8q30vMohA6ceq27AuESbbcOeSroe5zzyc6mDMlt8ApXURhw5UbkQe12bA
 QiXdQQrZzXH206r7+eSTi9+QGOoQDRYEU7DiB90Msxva+hmtDrRjHio6D/l6F+pQ1Rb5
 GvrvER9mFMZ9C1pff6WRSM+H6ptul1jtJcDSq83aokABtmIAaXErBTJzRTL6xuUM4G/Q
 ivuw==
X-Gm-Message-State: AOJu0Ywd0zMKpCZ5O34kvNIg7+Xo4lLIMewyt3Gy7GKxzzO1sNYS5VQu
 AnU6SSPUQZ6xY7/irF886q0y8jrUAurKaJXgYc5XRqwP/vMsroI5Tq1PV1PMMEZ5c8tCCfe0WFt
 tJKA=
X-Gm-Gg: ATEYQzxS5BnfuCYYgLavf/eH+8K7n5iJTH2f4tofSs2+zheMqYdywp4ZfzsnxQ3ex/V
 CJ/HDtkY7INSBPbks0UaA2t8EwU48UNiAxLvFGdeiPbGwLEYRyu7gzsItiz4XsrWJWuRSKRRoGR
 INulN4z4J0SrjaSSNSwR64pwhM83QCfVasw7LMaCCfYHL9bv00D4JkIPI96oek73FpLxFOPFcR3
 loeEFIshpbGyo8DTlOZ4IeGJvcfOI0DbZ0i03zKJQfdlbMXgWEM5NejDCUfhLqZWVaF/P4y3CoR
 mWmgS1ow3nruocQuyL9MCeWrz4o4xrbsuU9xG6eulC0EMUv615s9HwRk9i2pK7HyWH1LfaL7gkG
 JaI2mf4/kusVkf15gyF7HSjic1P74vFKjfqcV77TOxAaZ9EVMpdR6FfBp3qFO5GZ5j3my98Tox/
 EpF+Hrljt3wZo2UEyJzQ==
X-Received: by 2002:a05:6214:2a82:b0:89a:1536:251b with SMTP id
 6a1803df08f44-89a30a38ca6mr6943956d6.16.1772764635174; 
 Thu, 05 Mar 2026 18:37:15 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a316e8eb2sm1063436d6.35.2026.03.05.18.37.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 18:37:14 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Vishnu Singh <v-singh1@ti.com>
Subject: [PATCH v4 08/17] arm: Call bootm_final()
Date: Thu,  5 Mar 2026 19:36:17 -0700
Message-ID: <20260306023638.2678886-9-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306023638.2678886-1-sjg@chromium.org>
References: <20260306023638.2678886-1-sjg@chromium.org>
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

The ARM announce_and_cleanup() duplicates the common pre-boot steps.
Replace it with a call to bootm_final().

Drop the ARM weak board_quiesce_devices() definition since it is now
called from bootm_final() and the generic weak definition in bootm.h
is used instead.

Note that the printf() ordering changes slightly: it now prints before
bootstage processing rather than after, matching x86 and RISC-V.

Signed-off-by: Simon Glass <simon.glass@canonical.com>

---

Changes in v4:
- Drop announce_and_cleanup(), inline the two calls

Changes in v3:
- Add new patch for ARM conversion (requested by Tom)

 arch/arm/lib/bootm.c | 50 ++++++--------------------------------------
 1 file changed, 6 insertions(+), 44 deletions(-)

diff --git a/arch/arm/lib/bootm.c b/arch/arm/lib/bootm.c
index 019eca95780..727b9c5ca5b 100644
--- a/arch/arm/lib/bootm.c
+++ b/arch/arm/lib/bootm.c
@@ -42,42 +42,6 @@ DECLARE_GLOBAL_DATA_PTR;
 
 static struct tag *params;
 
-__weak void board_quiesce_devices(void)
-{
-}
-
-/**
- * announce_and_cleanup() - Print message and prepare for kernel boot
- *
- * @fake: non-zero to do everything except actually boot
- */
-static void announce_and_cleanup(int fake)
-{
-	bootstage_mark_name(BOOTSTAGE_ID_BOOTM_HANDOFF, "start_kernel");
-#ifdef CONFIG_BOOTSTAGE_FDT
-	bootstage_fdt_add_report();
-#endif
-	bootstage_stash_default();
-#ifdef CONFIG_BOOTSTAGE_REPORT
-	bootstage_report();
-#endif
-
-	board_quiesce_devices();
-
-	printf("\nStarting kernel ...%s\n\n", fake ?
-		"(fake run for tracing)" : "");
-	/*
-	 * Call remove function of all devices with a removal flag set.
-	 * This may be useful for last-stage operations, like cancelling
-	 * of DMA operation or releasing device internal buffers.
-	 * dm_remove_devices_active() ensures that vital devices are removed in
-	 * a second round.
-	 */
-	dm_remove_devices_active();
-
-	cleanup_before_linux();
-}
-
 static void setup_start_tag (struct bd_info *bd)
 {
 	params = (struct tag *)bd->bi_boot_params;
@@ -294,8 +258,6 @@ static void boot_jump_linux(struct bootm_headers *images, int flag)
 {
 	void (*kernel_entry)(void *fdt_addr, void *res0, void *res1,
 			void *res2);
-	int fake = (flag & BOOTM_STATE_OS_FAKE_GO);
-
 	kernel_entry = (void (*)(void *fdt_addr, void *res0, void *res1,
 				void *res2))images->ep;
 
@@ -303,9 +265,10 @@ static void boot_jump_linux(struct bootm_headers *images, int flag)
 		(ulong) kernel_entry);
 	bootstage_mark(BOOTSTAGE_ID_RUN_OS);
 
-	announce_and_cleanup(fake);
+	bootm_final(flag);
+	cleanup_before_linux();
 
-	if (!fake) {
+	if (!(flag & BOOTM_STATE_OS_FAKE_GO)) {
 #ifdef CONFIG_ARMV8_PSCI
 		armv8_setup_psci();
 #endif
@@ -340,8 +303,6 @@ static void boot_jump_linux(struct bootm_headers *images, int flag)
 	char *s;
 	void (*kernel_entry)(int zero, int arch, uint params);
 	unsigned long r2;
-	int fake = (flag & BOOTM_STATE_OS_FAKE_GO);
-
 	kernel_entry = (void (*)(int, int, uint))images->ep;
 #ifdef CONFIG_CPU_V7M
 	ulong addr = (ulong)kernel_entry | 1;
@@ -366,14 +327,15 @@ static void boot_jump_linux(struct bootm_headers *images, int flag)
 	debug("## Transferring control to Linux (at address %08lx)" \
 		"...\n", (ulong) kernel_entry);
 	bootstage_mark(BOOTSTAGE_ID_RUN_OS);
-	announce_and_cleanup(fake);
+	bootm_final(flag);
+	cleanup_before_linux();
 
 	if (CONFIG_IS_ENABLED(OF_LIBFDT) && images->ft_len)
 		r2 = (unsigned long)images->ft_addr;
 	else
 		r2 = gd->bd->bi_boot_params;
 
-	if (fake)
+	if (flag & BOOTM_STATE_OS_FAKE_GO)
 		return;
 
 #ifdef CONFIG_ARMV7_NONSEC
-- 
2.43.0

