Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00490CD343F
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 22:38:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CF16846D5;
	Tue, 19 May 2026 00:38:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="vp5uVe5b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F7D8846AE; Tue, 19 May 2026 00:28:45 +0200 (CEST)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E874C8465A
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 00:28:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=guodong@riscstar.com
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2adff872068so12347455ad.1
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 15:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1779143321; x=1779748121;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dMpW6Cuz6DOYXEMCHp1+o4AT/ZVt2cnUprakLffSiv4=;
 b=vp5uVe5bJVm7759BKRjp9Cb+HF9z304nxXOf3Tbm67iCD1CFg5ESQEy5DSYDcSafP8
 6BGLJVWYErEM3UBWYxV+Dl8zfspgwVs8zslsRqK9ZPdQjETdQaNGDprLWAw5GmoOB6jv
 4fyNVqG/NW3wvcg6QUK4ZqcUzmbU97EJi19A1yUeMshueVXpXkhpKsr9fBNmf0IjmgdN
 TppL8YuSw0WuDAGVy4WaTJKViKuuvm/5+cAGqVAj9HL8gQ8P6WCt1kt06lfEEw/tFknt
 CuZN1h5x0BZzPah5VcwFWQSVRXlrueOTg3JungcJo85f5SsGoDYDhih2CxgFYVt88DrI
 uTWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779143321; x=1779748121;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dMpW6Cuz6DOYXEMCHp1+o4AT/ZVt2cnUprakLffSiv4=;
 b=oNTPTVbzXXtTxl/V1YYLSlkCQtqSQLjc/B8LyPL0mM55agcNOWyskEHX6P+VntqEU6
 0eE3izKNo53KM35zZXOB5EeJ1Wx2qsVUse3vJnB3g64l+vVtrDvjXWO2t0jHTZf+MlAc
 3D/6R8R+Fs7UxToibU01nl+tGfcBDN99asAACiYvgInpW7uqFneN526lHj29x69DfsJE
 kD9eJSdquCkfB+prizTosvVLMD74A9O6iC/w4L/5TSyNzAuORc58NjNWFJygSZw/lYJ8
 15YIB3hLtTIfwqpBahF3QFFurmB/smsUujd+dNTY6I+bmhTH3i+3UeQPQ3wWUyCYU57V
 uWBw==
X-Gm-Message-State: AOJu0YymKUXBgxkEc8Ot23OxC8pB8immRJtbS4YbNLEPIEiJqs03AN94
 L53fQeT2xB7JHr5zar2N+gV8MTfmHdWBMAL4Ys2Eflgy0l8mD5X7nLHWy6ebSLZyZZU=
X-Gm-Gg: Acq92OEl2XDxmk8taVz4V7mzv3h4ikC4rXPVc3vjyoro9yd4Z2u1WD98GGQ1iXj0nAq
 uulx4I+L545Fqy4bMDiszi8Y1paAiom0Zi4vglcq3MXLRkx5RM2RQUwppTWSJZzHGvUYuFHXGeJ
 JSwRxHa1GZcJwc6gATRV8cqcR28fABbajWRxNvUMg8wFgTfkK1lWYIXJsEa9+w+J38YvP+h5+Az
 xy7lU0nxnHaoFgYaYMYcJwvX8WDAvwi7Iqw6QMEJFQOFNovqBm12LJdEWuWrp9lS8+0+vZQAh/s
 xLzFeHgFHyZ16dE5nU4Wve5YuCBGbPlv1IPGUtgGCMQvuVs6SL8nc6gSYHFMVohb1y806hRQW9M
 XHhMedJ6k5R3bY9R4ROCU/V+WMkG3p2uTTIQ8tWCMZu960JRzupixwJulX0FtaRewezJt3jMSPn
 xveT60dra/0kXjLQ+MTDaqHZQMEn2QFe++Afz6JirYZ3yjiD4GhWlo4w==
X-Received: by 2002:a17:903:3d4f:b0:2ae:450c:951e with SMTP id
 d9443c01a7336-2bd7e9040a2mr134426425ad.17.1779143321432; 
 Mon, 18 May 2026 15:28:41 -0700 (PDT)
Received: from [127.0.1.1] ([2a12:a305:4::4072])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5bd5ef27sm206379265ad.8.2026.05.18.15.28.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 15:28:41 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
Date: Tue, 19 May 2026 06:26:21 -0400
Subject: [PATCH v4 03/14] configs: k1: enable early timer support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-b4-k1-spl-bring-up-v4-3-3915a2a904c1@riscstar.com>
References: <20260519-b4-k1-spl-bring-up-v4-0-3915a2a904c1@riscstar.com>
In-Reply-To: <20260519-b4-k1-spl-bring-up-v4-0-3915a2a904c1@riscstar.com>
To: u-boot@lists.denx.de, Kongyang Liu <seashell11234455@gmail.com>, 
 Yixun Lan <dlan@gentoo.org>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Yao Zi <me@ziyao.cc>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, 
 Peter Korsgaard <peter@korsgaard.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Finley Xiao <finley.xiao@rock-chips.com>, Rick Chen <rick@andestech.com>, 
 Conor Dooley <conor.dooley@microchip.com>, u-boot-spacemit@groups.io, 
 Vincent Legoll <legoll@online.fr>, Huan Zhou <pericycle.cc@gmail.com>, 
 Jamie Gibbons <jamie.gibbons@microchip.com>, 
 Randolph Sheng-Kai Lin <randolph@andestech.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Heiko Schocher <hs@nabladev.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Justin Swartz <justin.swartz@risingedge.co.za>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 David Lechner <dlechner@baylibre.com>, Julien Masson <jmasson@baylibre.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Henrik Grimler <henrik@grimler.se>, 
 Kory Maincent <kory.maincent@bootlin.com>, Anshul Dalal <anshuld@ti.com>, 
 Bo-Chen Chen <rex-bc.chen@mediatek.com>, 
 Justin Klaassen <justin@tidylabs.net>, Guodong Xu <guodong.xu@riscstar.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Guodong Xu <guodong@riscstar.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
X-Mailer: b4 0.15.1
X-Mailman-Approved-At: Tue, 19 May 2026 00:38:07 +0200
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
Signed-off-by: Guodong Xu <guodong@riscstar.com>

---
v4:
- SPL_RISCV_MMODE (not SMODE); disable SPL SMP.
- Add RISCV_MMODE_TIMERBASE/_TIMEROFF.
- Enable SPL_REGMAP/SPL_SYSCON.
---
 configs/spacemit_k1_defconfig | 6 +++++-
 include/configs/k1.h          | 5 +++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/configs/spacemit_k1_defconfig b/configs/spacemit_k1_defconfig
index 29050ece278..fd0d228992a 100644
--- a/configs/spacemit_k1_defconfig
+++ b/configs/spacemit_k1_defconfig
@@ -17,9 +17,10 @@ CONFIG_DEBUG_UART_CLOCK=14700000
 CONFIG_TARGET_SPACEMIT_K1=y
 CONFIG_ARCH_RV64I=y
 CONFIG_RISCV_SMODE=y
+CONFIG_SPL_RISCV_MMODE=y
+# CONFIG_SPL_SMP is not set
 CONFIG_STACK_SIZE=0x100000
 CONFIG_FIT=y
-CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SUPPORT_RAW_INITRD=y
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_SYS_CBSIZE=256
@@ -31,6 +32,8 @@ CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_HUSH_PARSER=y
 CONFIG_OF_UPSTREAM=y
 CONFIG_ENV_OVERWRITE=y
+CONFIG_SPL_REGMAP=y
+CONFIG_SPL_SYSCON=y
 CONFIG_CLK_SPACEMIT=y
 CONFIG_CLK_SPACEMIT_K1=y
 CONFIG_PINCTRL=y
@@ -40,3 +43,4 @@ CONFIG_DEBUG_UART_SHIFT=2
 CONFIG_DEBUG_UART_ANNOUNCE=y
 CONFIG_SYS_NS16550=y
 CONFIG_SYS_NS16550_MEM32=y
+CONFIG_TIMER_EARLY=y
diff --git a/include/configs/k1.h b/include/configs/k1.h
index 15a40f2128f..e09c3594905 100644
--- a/include/configs/k1.h
+++ b/include/configs/k1.h
@@ -12,4 +12,9 @@
 #define CFG_SYS_NS16550_IER	    0x40 /* UART Unit Enable */
 #define CFG_SYS_SDRAM_BASE	    0x0
 
+#define RISCV_MMODE_TIMERBASE	    0xe4000000
+#define RISCV_MMODE_TIMEROFF	    0xbff8
+#define RISCV_MMODE_TIMER_FREQ	    24000000
+#define RISCV_SMODE_TIMER_FREQ	    24000000
+
 #endif /* __CONFIG_H */

-- 
2.43.0

