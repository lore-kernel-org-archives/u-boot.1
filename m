Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B18C8109E527
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 22:33:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E365883FBC;
	Wed, 25 Mar 2026 23:32:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KuIsZBjv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 310D783FB6; Wed, 25 Mar 2026 23:32:58 +0100 (CET)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E9F383A1B
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 23:32:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-8cfc137464dso56303385a.2
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 15:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774477975; x=1775082775; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wUtF7QZNmeq7XwiIaMWthd1fe1oj7esP0jrB47x+Yi4=;
 b=KuIsZBjvac+4cbjwo5+1ILo0EqhJxFO+qDfZrkUuVMGWs60R3zVR8m0IL4X67J7OiL
 XVi2u2YrCdEgkv0cWtANsrzV+hmy80ZCKpLOdS+aN1gcYAV0uHm818AzlEq8h9q0qy3F
 po2C162YJlimGTrtzqrHd4Q8iP00PQhoCHTm25UrtvGKqPZEIRzZWcJC9pBJh/bl/FWT
 OjpegTi6ubwP5mkMFMFFZ7bKaUGj7Tl3YWvuqAT7xYwZVfKH0toHam/fl0C+2p8TLU8M
 s9uN5Lfu/Mva/YxJSOv8ON2hrD9bkQ0UE52puDed4BYm3l20vorg0F0xUcmTbclKOsoU
 lPFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774477975; x=1775082775;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wUtF7QZNmeq7XwiIaMWthd1fe1oj7esP0jrB47x+Yi4=;
 b=fhE+5o74PDf3Dx31rBt9+yaT7LG9sCkEt493s0Jaecm8HGm39TZC2z/+ymo9QN175p
 +R/uVxYYlIZbwaE+trJYr1OnQPVtoGhj65CAwS0BrZGIdT1trYK4xoHIICfwfvencHDh
 t6nN7XqHkkJir7gSmi6Lc2LKvEMMzMmoe/JR25KzaKKJ979WON6uVp3Dyn6TcImhNBK3
 Yzi/t5aXawJAlrp2b4afpMZ562PAX7NSEs/LswgMfgb9AJfpmONUF2vhThVR+KULhaMK
 fYQ7a8R8gkmaeF1F9K/mrLgQIpD9MRmzorqCyeVtcdCSVYVRVXZZO39NfWmsZyR4OBdb
 gW4w==
X-Gm-Message-State: AOJu0Ywd/5b6x11xZj9IA2dOK4YovJC0YNLy7Mpq3pLkogJ55WimqkCV
 yMvl4yFvjqlZR7Vm247igFSG8JJEcnxvFL60tNLtFhDmgOa7swaejqnQs/0eKG3R
X-Gm-Gg: ATEYQzy4OstxAsEqszbaanQBWmE0CyoN2AdLgS77oOijuDl7mMHfuyL8fp26mYSDCgU
 8h/Is8ri3qPsZ+suhrt50JHjUV6s567r0fNziv8qphUCAS8PlEKnYdz3Mic/JenewDS88TUCrw2
 z13R/h2TNry9nD6kgbaZQnbd5WxWUiSi4Igp9PP5D4hPpSdCKIBSmDv638eyb/Fj1xkb7M99sz1
 SgQQtketfHldFB4YAYXuE0WYbfU5tnS/dIBO+Um9yBMXO+VeJv2a0KShj5O3iiRYULc45FA+MG7
 AL8sqJSPbOtLzYUMUQ23h/cUxXI0p9hs5Bl+DLsaf64F40puEVh+2akSio9P76loFjHTejnY661
 CHEkQaek+DBPamnk9uPQ4Fn5LWliJJSZy/Rt8sBCbYSGNtOYnm02l0/evsiCrAhWstvDSj1R+BF
 UVYItG4Uq3Zc1Xr7ZuY+XJgnbOho6Zi5a4pmIuZOjAX3olddZp6KB/MJX6QotzcuXwGM0IO2xb4
 jEFFffLRD4=
X-Received: by 2002:a05:620a:31a4:b0:8cd:cd30:779e with SMTP id
 af79cd13be357-8d0010044e9mr719319985a.42.1774477974747; 
 Wed, 25 Mar 2026 15:32:54 -0700 (PDT)
Received: from ubuntu.localdomain (173-206-124-85.cpe.distributel.net.
 [173.206.124.85]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8d00e39fc17sm101540185a.5.2026.03.25.15.32.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 15:32:54 -0700 (PDT)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: uboot@riscstar.com, u-boot-spacemit@groups.io, raymond.mao@riscstar.com,
 rick@andestech.com, ycliang@andestech.com, trini@konsulko.com,
 lukma@denx.de, hs@nabladev.com, jh80.chung@samsung.com, peng.fan@nxp.com,
 xypron.glpk@gmx.de, randolph@andestech.com, dlan@gentoo.org,
 junhui.liu@pigmoral.tech, neil.armstrong@linaro.org,
 quentin.schulz@cherry.de, samuel@sholland.org, raymondmaoca@gmail.com
Subject: [PATCH v3 03/16] configs: k1: enable early timer support
Date: Wed, 25 Mar 2026 18:32:19 -0400
Message-Id: <20260325223232.1553212-4-raymondmaoca@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260325223232.1553212-1-raymondmaoca@gmail.com>
References: <20260325223232.1553212-1-raymondmaoca@gmail.com>
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
Changes in v3:
- None.

 configs/spacemit_k1_defconfig | 2 ++
 include/configs/k1.h          | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/configs/spacemit_k1_defconfig b/configs/spacemit_k1_defconfig
index 3cf199e4032..9d7d1041247 100644
--- a/configs/spacemit_k1_defconfig
+++ b/configs/spacemit_k1_defconfig
@@ -21,6 +21,7 @@ CONFIG_SYS_LOAD_ADDR=0x200000
 CONFIG_ARCH_RV64I=y
 CONFIG_RISCV_SMODE=y
 CONFIG_TARGET_SPACEMIT_K1=y
+CONFIG_SPL_RISCV_SMODE=y
 CONFIG_FIT=y
 CONFIG_SUPPORT_RAW_INITRD=y
 CONFIG_OF_BOARD_SETUP=y
@@ -41,3 +42,4 @@ CONFIG_DEBUG_UART_SHIFT=2
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

