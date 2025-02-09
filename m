Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 512FBC0219D
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 21:19:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71DC680A23;
	Sun,  9 Feb 2025 22:16:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LDlSL3Te";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5369480A55; Sun,  9 Feb 2025 22:16:56 +0100 (CET)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 287EE809A5
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 22:16:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-3d050fdf2ffso11074575ab.0
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 13:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739135812; x=1739740612; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WzVCNlmfPzd0Hf6p2tnvDEC2hsc33sQqzOrHt7xrNuA=;
 b=LDlSL3TecSpo9RtWBTBaQy3R9m+CjMHg2mYOqxpOD8UBIXJz3OPj0rQyCGXKqxgwK7
 NEH9cJM+qlRtKRPL2zfWyf8m3XfOmtJyxzxN5JMi7c6js7FY7ZWC/lRZQwXUrvoA0dS9
 oui0EZj6UYv+jI2XaMBwbtMspLnck6ojfXzBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739135812; x=1739740612;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WzVCNlmfPzd0Hf6p2tnvDEC2hsc33sQqzOrHt7xrNuA=;
 b=W7adjXpb0NAv0OrK2boEY+wuphUHNFvTkDI4doZA6La3IXqHRshBdf/ioFdDICd9PP
 BTNsbtbAAVMqfT3ZS7UWZxlx46mWKtgmAui70a7y05hQdPp/SOkDBEjrf9GstOMV3LsZ
 UEKexx5YNG4lJwGLtFZhVWQUaFwNbm2qZk9j++CJC4EbgzCMHgtzzC3Iawf1em6N0VzY
 gNzbctJIzmUzWRPQcrzhfkK8d0mVUsm6WKF33MmnFh44FBqnfSwEmMBloaHVHFevQZyj
 14bqChuYknhEkIaeSu0e+c+mzTPycEqJ5PSzVSjLqfuS7GT12hAZUKHbjUtN0Xg9GaEJ
 pwvQ==
X-Gm-Message-State: AOJu0YzT7sA0tBFoiH8//MKh04/Glxx6R2Yp5wRK7TIHSMFmmqHB30Pu
 7mOSVp1CSiDFw7spAN7zn4O/3OF9VBJrq35h8juv0Ah4tIfTm6TqGg7EGuqQDeNoI25i2sYrcKw
 =
X-Gm-Gg: ASbGncuTRbJ2qCy1VX65/rTHEkkh6vJLrgETQPew9Mx1BZ84iwIT/EPeRqnvyo250SZ
 gU3eEKAeSpWoLdrDUVa3y483FN7AH5zOzL3jdfHJvSJNUcPUc0R4F9gE0YLcnT1YFfOAYKzyg92
 NIQ8Zv3F+0wOQJHis5d2y+P6R4EVTs9wbD/s31V79kbYdNP5/RhtabeYyzx+OJOHv2J7vZt+TA1
 7mESa3/y1oWJVinlRvlAZxX7ihLQoqj4z0/I87k9tKBvauRXdWvxHjSqHb2m4PDzz0UC/n27ToZ
 Cdgr0gQ1qVHCjTdEIya/sSXgAWMDvfxA0AmVrSb8dvrKsPjraSh8
X-Google-Smtp-Source: AGHT+IFZ6tQ3i9AIZpCCFu64S6lb6pgLVUCV0A2eJfwXeIJ+wR0r2Y8+e68mlcic+QgUv2Z6tytL4A==
X-Received: by 2002:a05:6e02:1989:b0:3d0:23f6:2eed with SMTP id
 e9e14a558f8ab-3d13dd3f045mr76293715ab.11.1739135812389; 
 Sun, 09 Feb 2025 13:16:52 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d05e96f245sm18978655ab.51.2025.02.09.13.16.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Feb 2025 13:16:50 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Raymond Mao <raymond.mao@linaro.org>,
 Dragan Simic <dsimic@manjaro.org>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v2 34/35] rockchip: Relocate bloblist at the end of the SPL
 phase
Date: Sun,  9 Feb 2025 14:14:55 -0700
Message-ID: <20250209211502.2299245-35-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250209211502.2299245-1-sjg@chromium.org>
References: <20250209211502.2299245-1-sjg@chromium.org>
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

Changes in v2:
- Move this logic into board-specific code

 arch/arm/mach-rockchip/spl.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/mach-rockchip/spl.c b/arch/arm/mach-rockchip/spl.c
index 305373a161c..64f056c27e9 100644
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
+	 * On RK3399, TF-A is executed after SPL and before U-Boot. It removes
+	 * our access to the IRAM. So move the bloblist to RAM.
+	 */
+	if (xpl_phase() == PHASE_SPL && IS_ENABLED(CONFIG_VPL)) {
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

