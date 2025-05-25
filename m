Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04A7EC54E90
	for <u-boot@archiver.kernel.org>; Sun, 25 May 2025 10:51:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C928E83754;
	Sun, 25 May 2025 12:48:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bZEHW3J0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36D2383744; Sun, 25 May 2025 12:48:49 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44A7C836B2
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 12:48:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3a4c95fc276so1702855f8f.3
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 03:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748170126; x=1748774926; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mjOPBNgwVYMgccPhmd5aZhWnG5/TJNNslc4Q0Ug5MsQ=;
 b=bZEHW3J0Vc/D68y9HrkkjP/e4fb/izvZPGEA/wAKCUrpaPOvUD/vgwFzdOjIih6nW7
 /ds0IzrfaymJ1A7vG564rcguZAIfFBpKy3PMvyaVWTea15/QnoXfkfMMMhQIg38c9RMf
 00ZCgR3w2gqakVQTQdNlSqMv3ovJZSDlSe2/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748170126; x=1748774926;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mjOPBNgwVYMgccPhmd5aZhWnG5/TJNNslc4Q0Ug5MsQ=;
 b=I8U9haIJqzHUtFaDFeNuWIObJp0E4hdnb7txmX2ArK06Nd2F5Vkz0hKRWaBZG5hhtS
 sG6tKlrpU9wKMLPEJXqnwLBIMSCvERSI2p+r6gL4pV0uXfRUH5SBs3p1O99LFFvQJTWe
 iZUiMbxIGuSX+a34HCPCL46szo04cko57iYb9yak5pOxHDQVBI3WAHrBmYLRbOHYP3V3
 RxQL3L3acwwniiHoxQp/yjKjolxoAjhRJrrfeyp7ztvVV3wcI8d6fz9mnmSAlCjpv7Kz
 WTLcr1gpVX4jaoetapYR6VIyWN2GsVL+81+Q802lmfIdYBH/qi3cJDfuFdWxKJcD4aUC
 HB2g==
X-Gm-Message-State: AOJu0Ywcq9J+pew7kFyhL/1TAQJ0GBH4if56eCu7q0O6n/r8zeW+rv/J
 R7Uw2BChfJjHdf7tbgb1gU1Na515GdsfRA30Op6lEtQItsYzP6sVoXKkEnmTKtWldccyCIMjBAN
 QjmwCiD5H
X-Gm-Gg: ASbGncuf+mVbMUNCCvMBnwz/1HDgFJKjM268O3hV9ZeUczMhO7gL/YuDYI9YsK/EBO7
 3q6kFi0fWnlt497t4KrMUPDyuAwgvplvkmA9WLHDjk5zfEwIGb2+RAYqc3u3FdCf4G9AQ61xyWO
 ZeVks5f5HB3iGbT73utZNEQ2gon9R+lvgVwVHW7Jx5hujnQdtTF9Iz9SF+qfeITYXIA5c9iYL85
 fwx60LxKNKq8l6nVi9kqx9F8fQgzQveHI+aGz74G62vMNWZ3A+gq5XBz8pYHoNV11xRcNnqGjqG
 YGIO49wzsWLdDfB8oXtePOFWyW8+JqJ25z9qTMAce7Zrpisba5hTHtb/HoW78wIYhr4S3w0=
X-Google-Smtp-Source: AGHT+IFMIyvD+rs8xqXmyAgcjKSHNRxx0QiK1VHwbJCnMuLGSz4NO60Je+UKC+cWXd7T4VQ54HEWnA==
X-Received: by 2002:a5d:64e6:0:b0:3a3:620a:696a with SMTP id
 ffacd0b85a97d-3a4cb489b7fmr4670284f8f.39.1748170125932; 
 Sun, 25 May 2025 03:48:45 -0700 (PDT)
Received: from tasman.. (host-80-43-238-15.as13285.net. [80.43.238.15])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4cb450867sm5045047f8f.57.2025.05.25.03.48.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 May 2025 03:48:44 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Raymond Mao <raymond.mao@linaro.org>,
 Dragan Simic <dsimic@manjaro.org>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v4 24/25] rockchip: Relocate bloblist at the end of the SPL
 phase
Date: Sun, 25 May 2025 11:48:00 +0100
Message-Id: <20250525104801.1440260-25-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250525104801.1440260-1-sjg@chromium.org>
References: <20250525104801.1440260-1-sjg@chromium.org>
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

(no changes since v3)

Changes in v3:
- Add the BLOBLIST_RELOC condition as well

Changes in v2:
- Move this logic into board-specific code

 arch/arm/mach-rockchip/spl.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/mach-rockchip/spl.c b/arch/arm/mach-rockchip/spl.c
index 305373a161c..a919246c4aa 100644
--- a/arch/arm/mach-rockchip/spl.c
+++ b/arch/arm/mach-rockchip/spl.c
@@ -3,6 +3,7 @@
  * (C) Copyright 2019 Rockchip Electronics Co., Ltd
  */
 
+#include <bloblist.h>
 #include <cpu_func.h>
 #include <debug_uart.h>
 #include <dm.h>
@@ -133,6 +134,20 @@ void board_init_f(ulong dummy)
 
 void spl_board_prepare_for_boot(void)
 {
+	/*
+	 * On RK3399, TF-A is executed after SPL and before U-Boot. It removes
+	 * our access to the IRAM. So move the bloblist to RAM.
+	 */
+	if (xpl_phase() == PHASE_SPL && IS_ENABLED(CONFIG_VPL) &&
+	    CONFIG_IS_ENABLED(BLOBLIST_RELOC)) {
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
2.34.1

