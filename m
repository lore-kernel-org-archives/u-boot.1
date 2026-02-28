Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70597FEE4EE
	for <u-boot@archiver.kernel.org>; Sat, 28 Feb 2026 20:22:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6D7183F7D;
	Sat, 28 Feb 2026 21:20:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BJNznkms";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EA3183F7D; Sat, 28 Feb 2026 21:20:49 +0100 (CET)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 256FB83EC6
 for <u-boot@lists.denx.de>; Sat, 28 Feb 2026 21:20:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7d4c12ff3d5so3456374a34.2
 for <u-boot@lists.denx.de>; Sat, 28 Feb 2026 12:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772310044; x=1772914844; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I5CCR6Ipb8FkcduUYpNziE89tdmmWofCY3tZcWMyVcg=;
 b=BJNznkmsesAgc9R2Xs43bGV4nB8Qh5KXyRkHe95ZWc7Qr5yIdYYiatb1gcbOUn7P5V
 U6m8NRKVi/CvhTD8dNGxzJYhs9ULqTqCEld+WLoB49uIxuOkV4rwqBG1Q3NS5uCbwRPP
 C5N74hlxOP2vBTLu+jZ07CRit4YJ+Bx/Bn4Cg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772310044; x=1772914844;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=I5CCR6Ipb8FkcduUYpNziE89tdmmWofCY3tZcWMyVcg=;
 b=mzKyYaP1ElpWPuVIozzN6iHLzhjVsE1Ewxo6bRQGnDMfDnDLZlhzLsgSW4qyV1NglJ
 iRkecSjET5+jPon1Vz6+rG0ko4RAhVCxyCrhG/9TdZb6mi/cw3IM4K3O3sxXKW+P/LRP
 diV6oH8hRjpAiaH7aioJre7DNEdfV0DSxcwvkUNWfJakMQXAWIHhMMdVHhSIrV/y0ZPh
 bzRK4kFfNtgH31n7uj4VjA5JsSghfKpBPESLQ+lznofoCbN8OWsbEsvAfqFqTwqEdsGP
 ZNfWVZsDdmofSU/HACtIPGqWsa/M7Vj5ycU9PHd26Op96Oaxq8MvyxqHpZeVKRnEdb8S
 OGLA==
X-Gm-Message-State: AOJu0Yx9DWs7AZ8rEkCMlgNW+rBdFwY+DJb5qd9n6Hw/WiGL9CZg6qU1
 jhd1vdgb3vDK9DmrsjwN8aUC3WKDzI+pVj/dl6ZJLt22npR1vPBZtGp9BZHjsXEBecKhfMK+bVD
 78bI=
X-Gm-Gg: ATEYQzyR6/wO3Dkx8LQ0PT0rFzxHbygOGuk27YPVN97L1z85nYf9//bdZ76UD+n6oDV
 VHWizThtN5jVjydtR1rfJEI7vkoyMNEs2BXHdHfsIu7BDIhrUKO+/E9lhf5VCeWgWcdtrGJ91ds
 CZ5z4EajzVFvaEiD5ZrRoTkdcgEgFENZB2aAjzrMTl1uTPwWsg0LEZA3T/yQICjM/RGsM9Zxka7
 YOQ0EPiciGZUKjFzVcVduOojPjKwMPzFQ4Qy7Y9HG5hRXjvruUL0ALw9OSRZdRGOIZsrjjcHo5c
 Kd0KcKiD+2KrDXMmboWrNJNsO42MPl/l/StuT9+KL41SYCiBz8xye1uUhUipgR0CpQTEnds6AsM
 hEoMQQEdGtJ0EF5mOsOgcfzsQmVIHnrX1pu7yHHNpsl3jkUcATjEAhIPjnN4ADRZj4KdwmZu/QR
 lLBId1MIgNGg7jAmjzcw==
X-Received: by 2002:a05:6830:621a:b0:771:5ae2:fcde with SMTP id
 46e09a7af769-7d591b23b6bmr4323039a34.2.1772310043858; 
 Sat, 28 Feb 2026 12:20:43 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d58644edfbsm6978361a34.6.2026.02.28.12.20.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Feb 2026 12:20:42 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Andy Fleming <afleming@gmail.com>, Mario Six <mario.six@gdsys.cc>,
 Priyanka Jain <priyanka.jain@nxp.com>,
 Stefan Roese <stefan.roese@mailbox.org>, Wolfgang Denk <wd@denx.de>
Subject: [PATCH v3 12/17] powerpc: Call bootm_final()
Date: Sat, 28 Feb 2026 13:20:00 -0700
Message-ID: <20260228202011.1834493-13-sjg@chromium.org>
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

Replace the open-coded bootstage_fdt_add_report() and
bootstage_report() with a call to bootm_final(). This also adds the
"Starting kernel" message, board_quiesce_devices() and
dm_remove_devices_active() which were not previously called on
PowerPC.

Signed-off-by: Simon Glass <simon.glass@canonical.com>

---

Changes in v3:
- Add new patch for PowerPC conversion

 arch/powerpc/lib/bootm.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/powerpc/lib/bootm.c b/arch/powerpc/lib/bootm.c
index dc44bf3ab3a..f9351a17a48 100644
--- a/arch/powerpc/lib/bootm.c
+++ b/arch/powerpc/lib/bootm.c
@@ -54,12 +54,7 @@ static void boot_jump_linux(struct bootm_headers *images)
 
 	bootstage_mark(BOOTSTAGE_ID_RUN_OS);
 
-#ifdef CONFIG_BOOTSTAGE_FDT
-	bootstage_fdt_add_report();
-#endif
-#ifdef CONFIG_BOOTSTAGE_REPORT
-	bootstage_report();
-#endif
+	bootm_final(0);
 
 #if defined(CONFIG_SYS_INIT_RAM_LOCK) && !defined(CONFIG_E500)
 	unlock_ram_in_cache();
-- 
2.43.0

