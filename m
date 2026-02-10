Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4C15EA812C
	for <u-boot@archiver.kernel.org>; Tue, 10 Feb 2026 15:15:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA2F583D7D;
	Tue, 10 Feb 2026 16:15:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IiNDH6sx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50B8D83D7D; Tue, 10 Feb 2026 16:15:24 +0100 (CET)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 490FB83CF2
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 16:15:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-5028fb9d03bso45503201cf.3
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 07:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770736521; x=1771341321; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F3ucj//R6RcaXoZ+/2SJMfNMHVdH25VOi7qK+LloxN4=;
 b=IiNDH6sxvIiQIdU1zOAw6/cPDxUGFLdvbsKmZwBffQYbAH5DfFEZA1iNj1AJpJ7NXX
 FjFSjWDwXxqLcVLfGGrmKgZjM4AOyXP5zqc1QQY9cKm0sE8KsR0dNoim/uKFXaRXg+uG
 jINSjkquirYFyMhWsiWiyJDae9F9SXCDetb6xb5n6W82sR3EShtMRDaT/dqgTVk6MWfZ
 qVGdvBaoy6i0+vyKUJJR4EwsNgRN87xPGu+X8b7YZ9kV5sFNVaXmjou3rkgJsZVRZ6OJ
 h044pD2b46RY8uSoTAj5iOMbiDewNsQHRl45Un3t/ZtOz8Mc34JHEG5DkDGblup4qloq
 XkTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770736521; x=1771341321;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=F3ucj//R6RcaXoZ+/2SJMfNMHVdH25VOi7qK+LloxN4=;
 b=syJ8M3Bz9LnjyjlClhvWWtDvR9VvwWXPV36zaPVqMKn/s86gAQJlo3OtutrD+WKU0n
 TMkSndz9RLDVX6JqKPZcbWtvgAdYcfY0mmZRFf7twS0lFD+sl/PCOMxdfr+uGpMwtokY
 rnDyirol36D61MiPsizFayayy/7MemumOwp7CwGgjRcqdWgAv2+vusicpm4tE6AlBm6h
 /S6vD1XpvXORagHgDOWVd5rRS6vQHFg/ACByKodNOMS9DDfiuHubyCWqqa/Tj/CXkCZt
 gBQ3RKg/YIkRYL4Dq/3sJpn67MNXJ/DsJD7G8BYAIbz2VfBfGNZvraKbFYBXHm/lf/ZH
 USFQ==
X-Gm-Message-State: AOJu0Yzt5cg4nqsw5LcZdmOnwRBoNRfnyZhFiqLWY2V9ScyalvwjqbFm
 Ab3/GH0A6W7w2rIM6DPoDISFcdEyEc6frYzM99bp6XcdSFbYD6nWag0kFHrOLA==
X-Gm-Gg: AZuq6aJCzFVrrWwU/KQk0OkU5vDyDtc73M3sTm/KqjaoHPPJdqOuv/fUNBFxMaXEn9G
 1EDhaJ0mppqeYGD2HqzhzNq+Tn2upPjyBKnS9/1tDgNHiMaJqdR6oDOEKpCUTBf0Z2xd269RYeW
 wMcikKpChp3H+pbB+8EJIZowRDf3VzC0a9l5qcrEJHO9pyS4vGfVTvuc8sMfL/43gOgq1sDnSqi
 h1CG9bUtzYUkNqXvoizL3gnzBCeIfGldbLzVaPzQN7959IkCSDnhkWKSy44XjUB8hcfCrjv497e
 +1+d2uu7y72iVYo8iB3NtO9rtneIb0pJZaUJ9612DsgmKJ3lfW5WMD3hOtgsRzb8x39XaBj1NyY
 zOFckRH/7TFkXNwn80roD+X+v+4w9RAv8XwaeAjAcueMwJjMfyOETgSpif5ysJGbJ1fzSfCf0qd
 i5wERj430+vyD6htP51UqCJH4gZY51jOidFUH5zWV4ZNa4o5vijA4tcO69gChlPWJ9PD4i
X-Received: by 2002:ac8:7f0f:0:b0:4eb:a192:de99 with SMTP id
 d75a77b69052e-50673da1d7dmr27650441cf.76.1770736520589; 
 Tue, 10 Feb 2026 07:15:20 -0800 (PST)
Received: from ubuntu.localdomain (174-138-202-16.cpe.distributel.net.
 [174.138.202.16]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8953c057751sm101019286d6.43.2026.02.10.07.15.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 07:15:20 -0800 (PST)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: uboot@riscstar.com, u-boot-spacemit@groups.io, raymond.mao@riscstar.com,
 rick@andestech.com, ycliang@andestech.com, trini@konsulko.com,
 lukma@denx.de, hs@nabladev.com, jh80.chung@samsung.com, peng.fan@nxp.com,
 xypron.glpk@gmx.de, randolph@andestech.com, dlan@gentoo.org,
 junhui.liu@pigmoral.tech, neil.armstrong@linaro.org,
 quentin.schulz@cherry.de, samuel@sholland.org, raymondmaoca@gmail.com
Subject: [PATCH v2 03/16] configs: k1: enable early timer support
Date: Tue, 10 Feb 2026 10:14:46 -0500
Message-Id: <20260210151459.2348758-4-raymondmaoca@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260210151459.2348758-1-raymondmaoca@gmail.com>
References: <20260210151459.2348758-1-raymondmaoca@gmail.com>
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

From: Raymond Mao <raymond.mao@riscstar.com>

Enable CONFIG_TIMER_EARLY to allow udelay() calls during
early initialization phases. This is required for proper
timing operations before the full timer driver is available.

Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
---
 configs/spacemit_k1_defconfig | 2 ++
 include/configs/k1.h          | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/configs/spacemit_k1_defconfig b/configs/spacemit_k1_defconfig
index d794170bc5b..617fe9d2aae 100644
--- a/configs/spacemit_k1_defconfig
+++ b/configs/spacemit_k1_defconfig
@@ -20,6 +20,7 @@ CONFIG_SYS_BOOTM_LEN=0xa000000
 CONFIG_SYS_LOAD_ADDR=0x200000
 CONFIG_ARCH_RV64I=y
 CONFIG_RISCV_SMODE=y
+CONFIG_SPL_RISCV_SMODE=y
 CONFIG_ARCH_K1=y
 CONFIG_TARGET_BANANAPI_F3=y
 CONFIG_FIT=y
@@ -42,3 +43,4 @@ CONFIG_DEBUG_UART_SHIFT=2
 CONFIG_DEBUG_UART_NS16550=y
 CONFIG_DEBUG_UART_ANNOUNCE=y
 # CONFIG_DEBUG_SBI_CONSOLE is not set
+CONFIG_TIMER_EARLY=y
diff --git a/include/configs/k1.h b/include/configs/k1.h
index e0b05c50b70..8e148803dea 100644
--- a/include/configs/k1.h
+++ b/include/configs/k1.h
@@ -13,4 +13,7 @@
 #define CFG_SYS_NS16550_CLK	    14700000
 #define CFG_SYS_NS16550_IER	    0x40 /* UART Unit Enable */
 
+#define RISCV_MMODE_TIMER_FREQ	    24000000
+#define RISCV_SMODE_TIMER_FREQ	    24000000
+
 #endif /* __CONFIG_H */
-- 
2.25.1

