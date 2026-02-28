Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 726A2FEE4F7
	for <u-boot@archiver.kernel.org>; Sat, 28 Feb 2026 20:21:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC05083F6D;
	Sat, 28 Feb 2026 21:20:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZnQba1LQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 027B883F63; Sat, 28 Feb 2026 21:20:40 +0100 (CET)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9045983CDF
 for <u-boot@lists.denx.de>; Sat, 28 Feb 2026 21:20:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7d4c3896e32so1720081a34.0
 for <u-boot@lists.denx.de>; Sat, 28 Feb 2026 12:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772310035; x=1772914835; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/RppRgguCdPH1vP221BaBabNcKa5/+5m6pjMnk4Hlic=;
 b=ZnQba1LQ5r74a56xhBjGObYXPdcZXCTrJ+xqSmJLTlv4tSbdoH7XVeitwvUCSmxQ2u
 iJEO01vCmxG0vAN+Xy1hS0TAdxDxe2V0SFsF5ZfjLSJu7eINLiMepwnPo/LAxG/C5dGD
 pIgKt1Lrr0sUzGaLIIO/1DXCpAjRZq5UNFGvw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772310035; x=1772914835;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/RppRgguCdPH1vP221BaBabNcKa5/+5m6pjMnk4Hlic=;
 b=s3x1pMBCBliof5T9Y5geS8jKWXytbTOpGsFkdiBZAzOg9hrtChdZUwwoHfdkJ8kuL1
 ieN7k8u3hQlnNkvEx8iUaa3HuuVMvmxpI8APGUrxhwVzblB2oldkFeSUoBHzzUEhcZck
 7kQZ/QPAiDimOWoj6irTqnD7BnY9qXeK9tNJd/ObVczrGsB9sGFYvNRmmSnmRsk1xq16
 gOmkI6jk7Ec73yTKptbuPALzmWRX4ycdLRAV5ofOVYZ/REJrpkj5SIgho0nTf1dJXZbH
 FidPWM24e1ZuxZ2UA6ewBllEE8lcO1T5PNK0445rNPx/iPyvmF5102LnD+rqsKkJEphh
 ej8g==
X-Gm-Message-State: AOJu0YxxCVpEM1HTr8U8kUVLG9mjfK/eIULxs8rsIKX5HTiee+uqY6TY
 KR0Dpnkj1RuWA4pCCpVfPWKoxavfCVVtlQhNOoiwaS/tMINzt5DKr1Ach3zoDupd4dFiSGqRAHb
 zB2Y=
X-Gm-Gg: ATEYQzx1RFI23Dy1vA1MycyHm5stM6JFUgo/OSVQISlSW8lFpTWsy3F3Mc3MzUtEIQA
 cWuy+97F822ragTKhB90WpxVlU3dXszdTG/V20JzP0ocVAeC6ZwWqQOUEqS+cX+XQ3jCWh5Zw+c
 21o4zjYAGzta0NpjdDCRs+5xROYpuF+SyVKJVn2kc+IHIKCp+8+uBTo2zHJ0HLmPGqNkqUvayb5
 YIL2bUWtvnFYtQIUKB/DFE2ZYFbW0+Bu4XJddfzH7o/VqJc6rjCJt2ImiFISXL9Xx+UGzwA7kBE
 J2kbjtM7PCfKTUenkWBZn7wUoNikBOovjKIxNQgDca+iPf86KP/YaPMouyAinFh61sOu53RSGu2
 qiz4b8A0UKfzF6Wk0UZMFBBtmZ6v4/Tln6XEOuIr0WeG/4fyNHewmLfzfpE1mgEbHqCaYsRuWoU
 Z07IBDCJUYSHlOaiDNIQ==
X-Received: by 2002:a05:6830:7103:b0:7cf:da36:4cbb with SMTP id
 46e09a7af769-7d591b02357mr3797685a34.2.1772310035632; 
 Sat, 28 Feb 2026 12:20:35 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d58644edfbsm6978361a34.6.2026.02.28.12.20.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Feb 2026 12:20:34 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Vishnu Singh <v-singh1@ti.com>
Subject: [PATCH v3 08/17] arm: Call bootm_final()
Date: Sat, 28 Feb 2026 13:19:56 -0700
Message-ID: <20260228202011.1834493-9-sjg@chromium.org>
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

The ARM announce_and_cleanup() duplicates the common pre-boot steps.
Replace it with a call to bootm_final().

Drop the ARM weak board_quiesce_devices() definition since it is now
called from bootm_final() and the generic weak definition in bootm.h
is used instead.

Note that the printf() ordering changes slightly: it now prints before
bootstage processing rather than after, matching x86 and RISC-V.

Signed-off-by: Simon Glass <simon.glass@canonical.com>

---

Changes in v3:
- Add new patch for ARM conversion (requested by Tom)

 arch/arm/lib/bootm.c | 27 +--------------------------
 1 file changed, 1 insertion(+), 26 deletions(-)

diff --git a/arch/arm/lib/bootm.c b/arch/arm/lib/bootm.c
index 019eca95780..aa772b62d13 100644
--- a/arch/arm/lib/bootm.c
+++ b/arch/arm/lib/bootm.c
@@ -42,10 +42,6 @@ DECLARE_GLOBAL_DATA_PTR;
 
 static struct tag *params;
 
-__weak void board_quiesce_devices(void)
-{
-}
-
 /**
  * announce_and_cleanup() - Print message and prepare for kernel boot
  *
@@ -53,28 +49,7 @@ __weak void board_quiesce_devices(void)
  */
 static void announce_and_cleanup(int fake)
 {
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
+	bootm_final(fake);
 	cleanup_before_linux();
 }
 
-- 
2.43.0

