Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47313C5AD49
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 10:20:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0592F837B6;
	Mon, 26 May 2025 12:16:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gTjvOFXL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72BE383837; Mon, 26 May 2025 12:16:48 +0200 (CEST)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 469F3837F5
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 12:16:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-3dc75fe4e9bso9015095ab.0
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 03:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748254604; x=1748859404; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DonEmD7zxC2zcEWsrIYXoblQFl2TOJv5vX7t/vTPipM=;
 b=gTjvOFXLuLif1U3zuqZl6c59Co60hGt94iNjRg3fLdcqV8VV+vRRr1jgIRAET005uB
 j1cPVmkM77nzDPfWEBOzIyoN3XVBNH2uJWKSQ1dNcskeen70q8IXXNc7xdbQ2qpYvWRN
 6djdUw/mH6FEEXhd5IzOEBo6WTKrJlNIPafr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748254604; x=1748859404;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DonEmD7zxC2zcEWsrIYXoblQFl2TOJv5vX7t/vTPipM=;
 b=qQeKhX6nbftIuk/UE+WM7YC72cMjF+Yh7ZC3/rC+ukKqhBgB5PRtg4NOG+JBVJqiBN
 nSWfWG3+KQguHRjR9iYxmv3E7BI0utyHA/4Wt4wdmXC0QKpRvwb1wMW3fqW1SYtCNsvc
 UV4ePfP1sswKbVZFqGgiyczY40WvmFx459/6jym8rZdBuH0+JEMs1sh5ZxfijVp6n4Kb
 QP0Jnmq8oPrBsWUNeosDDDjmmChUDEi4lQ0YRKXaX9F3ncH4ZkKpJwNsOXnRK9WJi7GE
 yhonF7DHX4paUt2cVBiNeFSsmKEOXsBTEboyZh0lTu8oHxwAzVu8pJ9SfQ3W86sddkof
 yFyg==
X-Gm-Message-State: AOJu0YwZtqF2CHYvxfmF9A2qcWavs9Tr64a7QXpqrI8qCr7en+RI/27G
 yGfLZFEys6kb0CQVPmchgBLwFw0m7+/gBcHZ+yxTEiVtLdLU8c65l4am916LbkJAxziDVb7jhwZ
 5NEUm6U+K
X-Gm-Gg: ASbGncuy9IepqnaDGGGnX4zO8H6V0hDVqdBm91hNVD3wd7YdNzcrnWxlZGR9l67xBIo
 1IwRj+SIuFkMeU0p9yd51MKJp/ELF8Y0EgNfpEhNNytI28JusyerV/FWm8h+fD/OZvOEcKr34oM
 TVQizDE2zL+xaHZoxMbmqNZiQKLQcHAPpcG+UL0fJMjLtNIqDIMrMZkBAkF7BTUtniQwOY0rUVx
 3o0IdxvUb02CdrUh6pWHFeFQqKbdafTZmy3SAGUKXK34xctGXMIwCtAx0Eb+8jE3+WKJ6Gi8x39
 X8MQUeiMdIKSs8h9hzbliUixuUI3qtyNZ3rwpxvDOm/EDla4wFldkLleW0c74g7rL58KORF0EQ8
 V64HSHn3Mb8qSKm65OdPX4Fw=
X-Google-Smtp-Source: AGHT+IH62vVlQauNeTm1yFHN6Ya9TDEGrrslAsBCzkF0Bz9a+1OTjZPtOvCbygNzApt0zF89+eiMHw==
X-Received: by 2002:a92:b104:0:b0:3dc:879b:be95 with SMTP id
 e9e14a558f8ab-3dc92bdaa3cmr79858045ab.5.1748254604444; 
 Mon, 26 May 2025 03:16:44 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4fbcc3b19aasm4679249173.52.2025.05.26.03.16.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 May 2025 03:16:43 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Raymond Mao <raymond.mao@linaro.org>,
 Dragan Simic <dsimic@manjaro.org>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v5 24/25] rockchip: Relocate bloblist at the end of the SPL
 phase
Date: Mon, 26 May 2025 04:15:10 -0600
Message-ID: <20250526101541.3254628-25-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250526101541.3254628-1-sjg@chromium.org>
References: <20250526101541.3254628-1-sjg@chromium.org>
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

Where the bloblist is located in internal memory and TF-A's BL31 blob
removes access to this memory, the best option seems to be to relocate
the bloblist just before running TF-A.

Do this at the end of SPL.

Signed-off-by: Simon Glass <sjg@chromium.org>
Suggested-by: Raymond Mao <raymond.mao@linaro.org>
---

Changes in v5:
- Use 'SDRAM' instead of 'IRAM' in comment
- Drop mention of rk3399 since 64-boards always have TF-A after SPL
- Drop condition on VPL

Changes in v3:
- Add the BLOBLIST_RELOC condition as well

Changes in v2:
- Move this logic into board-specific code

 arch/arm/mach-rockchip/spl.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/mach-rockchip/spl.c b/arch/arm/mach-rockchip/spl.c
index 305373a161c..503e55dfc3a 100644
--- a/arch/arm/mach-rockchip/spl.c
+++ b/arch/arm/mach-rockchip/spl.c
@@ -3,6 +3,7 @@
  * (C) Copyright 2019 Rockchip Electronics Co., Ltd
  */
 
+#include <bloblist.h>
 #include <cpu_func.h>
 #include <debug_uart.h>
 #include <dm.h>
@@ -133,6 +134,19 @@ void board_init_f(ulong dummy)
 
 void spl_board_prepare_for_boot(void)
 {
+	/*
+	 * TF-A is executed after SPL and before U-Boot. It removes our access
+	 * to the SRAM. So move the bloblist to RAM.
+	 */
+	if (xpl_phase() == PHASE_SPL && CONFIG_IS_ENABLED(BLOBLIST_RELOC)) {
+		ulong addr = CONFIG_IF_ENABLED_INT(BLOBLIST_RELOC,
+						   BLOBLIST_RELOC_ADDR);
+
+		log_debug("Relocating bloblist %p to %lx\n", gd_bloblist(),
+			  addr);
+		bloblist_reloc(map_sysmem(addr, 0), bloblist_get_total_size());
+	}
+
 	if (!IS_ENABLED(CONFIG_ARM64) || CONFIG_IS_ENABLED(SYS_DCACHE_OFF))
 		return;
 
-- 
2.43.0

