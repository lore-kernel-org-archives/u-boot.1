Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9F43CF259F
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 02:45:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B6E088C63;
	Mon, 14 Oct 2024 04:44:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XjrO7TPr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D33F88F0C; Sun, 13 Oct 2024 16:32:51 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59BF388F31
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 16:32:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=l.rubusch@gmail.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5c940512711so574587a12.1
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 07:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728829962; x=1729434762; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=usWkMELTSkVMjSiLrZWaESt+S9kt+PmU4NJq15fFVDM=;
 b=XjrO7TPrtkXdITxSj9rx5MShxCDd8xYivIrx7t9ZZOxLbJCrq8u9I5ib4FFEKefyAY
 GHc38XI3o7uN143vmxDfTJgPZw50QSTrziqcodO2mV+PVIA7nOwi+idUe4Fu+hVJYTl1
 Cw02ZJqDc3Tmq8g4hnBVTs1ISYh9Evp193jqu9dNPslQFUzFKEqRJRG64HUb/+fUMoHl
 C8f8KwDVlkFnxwuz6V5gYPXZOJeAx1P8zzMwGjzNJc3Nw9z4NAqVwi1UHGB6UQRp9odY
 +DXWeK4HiWvE/wC9KzviMAjiUNlURKt/qqiuBkexbuxeX2bz9kAyxFVYU8TadECdLkk4
 grDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728829962; x=1729434762;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=usWkMELTSkVMjSiLrZWaESt+S9kt+PmU4NJq15fFVDM=;
 b=pOso7qD9w5Puch5GBug0pj3R91BFCyZnHWuu+oCu5WocivCMoCzjF9lKPDwwURIGlM
 qvTpypu+j0/5T8w41LN54v62cmfqRhSLAFR1pY3zPviu9w7wHJfJiHLdH7r0xEmldMJ5
 Avl6Rda2a2WP93CCm7fKI4NT/Wa14+qdVqYhI1mOTa3agjj0cGtJ/lhZSvLNNV5SHiTn
 k3MIbF90YR0imXwQ/+buDk7jMrITmd9RxSYalGM1lrH97hCJk43NiPlfrOCrNpod1ytp
 4j7UFOjxupLad5M/Sgpxxqof0A7+SFOIU+P8iFQ/TxLzDMNTgV93DLLDjBFIVf6wCofw
 frWg==
X-Gm-Message-State: AOJu0YwBdFz2Gs+UDGw36kNVpnGZo52fjfL+/fzJe39ZnIpLQMnuBJS3
 rHYEFnpmewNI4veWvTkHLEzlVIVTCdROvxo46pw2vhk03x7YAxq31IunAg==
X-Google-Smtp-Source: AGHT+IHFly05ihzL2ZicifvjSIDlP2CMUF7dpgF3FKbwmTsQkhoZro9zR8uDndxhtaMu1ajN6pTasQ==
X-Received: by 2002:a17:906:4793:b0:a80:a23e:fbf9 with SMTP id
 a640c23a62f3a-a99b941f1f1mr300504966b.6.1728829961634; 
 Sun, 13 Oct 2024 07:32:41 -0700 (PDT)
Received: from e8ff02ae9b18.v.cablecom.net (84-72-156-211.dclient.hispeed.ch.
 [84.72.156.211]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99efcf15d1sm189886266b.102.2024.10.13.07.32.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Oct 2024 07:32:41 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: u-boot@lists.denx.de, trini@konsulko.com, marex@denx.de,
 simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com,
 sumit.garg@linaro.org
Cc: sjg@chromium.org, xypron.glpk@gmx.de, michal.simek@amd.com,
 jit.loon.lim@intel.com, barnas@google.com, l.rubusch@gmail.com
Subject: [PATCH 05/10] ARM: socfpga: add Mercury+ AA1 extra env settings
Date: Sun, 13 Oct 2024 14:32:27 +0000
Message-Id: <20241013143232.2090645-6-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241013143232.2090645-1-l.rubusch@gmail.com>
References: <20241013143232.2090645-1-l.rubusch@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 14 Oct 2024 04:44:22 +0200
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

Provide an initial environment for boot scripts to operate.

Signed-off-by: Andreas Buerkler <andreas.buerkler@enclustra.com>
Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 include/configs/socfpga_mercury_aa1.h | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/include/configs/socfpga_mercury_aa1.h b/include/configs/socfpga_mercury_aa1.h
index a5b63336e8..d9d169f6dd 100644
--- a/include/configs/socfpga_mercury_aa1.h
+++ b/include/configs/socfpga_mercury_aa1.h
@@ -16,18 +16,8 @@
 /* Memory configurations  */
 #define PHYS_SDRAM_1_SIZE		0x80000000
 
-/*
- * Serial / UART configurations
- */
-#define CFG_SYS_BAUDRATE_TABLE {4800, 9600, 19200, 38400, 57600, 115200}
-
-/*
- * L4 OSC1 Timer 0
- */
-/* reload value when timer count to zero */
-#define TIMER_LOAD_VAL			0xFFFFFFFF
-
 /* The rest of the configuration is shared */
 #include <configs/socfpga_common.h>
+#include <config_distro_bootcmd.h>
 
 #endif	/* __CONFIG_SOCFGPA_MERCURY_AA1_H__ */
-- 
2.25.1

