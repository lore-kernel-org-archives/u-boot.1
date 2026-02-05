Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADD2FECD998
	for <u-boot@archiver.kernel.org>; Thu,  5 Feb 2026 19:16:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0234183B95;
	Thu,  5 Feb 2026 20:16:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bnuY1a1W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F13FD83BD2; Thu,  5 Feb 2026 20:16:36 +0100 (CET)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFF7B83AA4
 for <u-boot@lists.denx.de>; Thu,  5 Feb 2026 20:16:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-45c715116dbso813650b6e.3
 for <u-boot@lists.denx.de>; Thu, 05 Feb 2026 11:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770318993; x=1770923793; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=eaGzU0wWTaRvI4NR7adYkulQQPxayTwgOx3n3tImsAA=;
 b=bnuY1a1WnlkePUPJjml7lZ7WbtZ/H3TYgN/G/9PDPZLbNUIv58N/Yrmk6P6+Llqx7z
 eXB+lcyt7K/vbT7DO+yR4/VWYVPVOFNJewQUUpr5qE1QBuN9dfaoBWC8olnwIr0T6H3X
 p0y+rI/rRoOf3/CTaEqT860LZiMYEdYSbd2pc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770318993; x=1770923793;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eaGzU0wWTaRvI4NR7adYkulQQPxayTwgOx3n3tImsAA=;
 b=kesf6F+fsmHesYlxPnkt16nvKYY6yUdzPTan6KH0SoAbX6nMqNYgb3RDhyeXALJQiq
 oHGslvu+uQUmT1VF19E37rzrdUfrUj0XQtkFNxJDAhbYKxaa6BoCToJwWbQMU35odx2H
 GH8DgMYfkMnSgTyWah0gst2pWD+lyeWFQcAUe0tkYSbggYhoKOUwu8b/oB6qvimIex3J
 WD647dqmUJQkb4Y58DWm/atH1LAMb0DHJYwAEg4t//2xI8hnDF6SOv1Nh8rCFvmZp/EI
 7KnrH2nZcZnzpIpeiodorUYG7r2vTag3zf3plOTvbBcq78TiDWrUViHRjVLum9MYpOqL
 o86A==
X-Gm-Message-State: AOJu0YwxEbjXp8NEoszLDzQdHtngGPVDQ65wvKmab3ZQagr/u7Fo+cek
 emesI/+8PI6Rd91Umib/LK1Scpf4inKwXk06odUJJJIEaBWiEag8lirkiWPl0gxqmjMVTY/t0XP
 u5V2Yf8E=
X-Gm-Gg: AZuq6aLoYDjTtVOlYjzrr4w0mZ7kr+ISu6tKHiqQIR3ok5Z0mr3G7igIkmpxdEVUrvU
 AIbr+dfndwyxClR7tTuE2HUQO/lMsWZiOFds5l8Dj0QQbdEX16xtF1xICVpZ1W/Kc7mQeKFmbmK
 Ob2LI7G01JXO2O3bVXBDMA5Rd1AfoqRjPX4M2pKPWWiWoaskO6ZJvCLCToDum9i5l+7+thBaHfH
 Afl5VogiPBpuGGW6MCDbRFZi8qchFEej1KGL9AWqnyHUI6R1rCZlCq1fYyqrrupiQBp6bIQWmSe
 /ZB0eZodV81lBmaxvyvT3/DnvPE/RWRSsY96D4oHck/oDSkbp1IfuTDjifO71WYX6C4Nwa2Iv8a
 1n48WLpTu98YykhglqJ1oxPB/W9Gj0P2wh6JJLsVhpNdA8WgLRJQ5PcQyvPovm/BpidJwiineCa
 1rCMu1qXDO6qhKA2esr0z6zNYA192mggoLmXGPGPofRNtBFlfWBD4GgKHTgPmFG6FA8nSIwjQVv
 2HC9L3ZkkxPGlefpWB7G6dB57mz3csHgqMisj92bzUTF1nYylxg
X-Received: by 2002:a05:6808:c1f1:b0:45e:c2a7:9151 with SMTP id
 5614622812f47-462fcb7284fmr143202b6e.51.1770318993464; 
 Thu, 05 Feb 2026 11:16:33 -0800 (PST)
Received: from bill-the-cat.. (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-462d6615ca2sm3494144b6e.5.2026.02.05.11.16.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 11:16:32 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Heiko Schocher <hs@nabladev.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>
Subject: [PATCH] defconfigs: Remove default COFNIG_SPL_LDSCRIPT value
Date: Thu,  5 Feb 2026 13:16:31 -0600
Message-ID: <20260205191631.3488262-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

These three platforms set CONFIG_SPL_LDSCRIPT value to what the default
value for the question is, once evaluated. Remove this unnecessary line.

Signed-off-by: Tom Rini <trini@konsulko.com>
---

Cc: Heiko Schocher <hs@nabladev.com>
Cc: Wolfgang Wallner <wolfgang.wallner@at.abb.com>

diff --git a/configs/axm_defconfig b/configs/axm_defconfig
index 0a4591413734..f62aece626fb 100644
--- a/configs/axm_defconfig
+++ b/configs/axm_defconfig
@@ -15,7 +15,6 @@ CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
 CONFIG_NR_DRAM_BANKS=1
-CONFIG_SPL_LDSCRIPT="arch/arm/cpu/u-boot-spl.lds"
 CONFIG_ENV_OFFSET=0x100000
 CONFIG_SPL_DM_SPI=y
 CONFIG_DEFAULT_DEVICE_TREE="at91sam9g20-taurus"
diff --git a/configs/brppt2_defconfig b/configs/brppt2_defconfig
index 7774f7b23884..305b5a40c0e0 100644
--- a/configs/brppt2_defconfig
+++ b/configs/brppt2_defconfig
@@ -8,7 +8,6 @@ CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
 CONFIG_NR_DRAM_BANKS=1
-CONFIG_SPL_LDSCRIPT="arch/arm/cpu/u-boot-spl.lds"
 CONFIG_ENV_SIZE=0x10000
 CONFIG_ENV_OFFSET=0x20000
 CONFIG_ENV_SECT_SIZE=0x10000
diff --git a/configs/taurus_defconfig b/configs/taurus_defconfig
index 524a89014541..2779ad21b940 100644
--- a/configs/taurus_defconfig
+++ b/configs/taurus_defconfig
@@ -17,7 +17,6 @@ CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
 CONFIG_NR_DRAM_BANKS=1
-CONFIG_SPL_LDSCRIPT="arch/arm/cpu/u-boot-spl.lds"
 CONFIG_ENV_OFFSET=0x100000
 CONFIG_SPL_DM_SPI=y
 CONFIG_DEFAULT_DEVICE_TREE="at91sam9g20-taurus"
-- 
2.43.0

