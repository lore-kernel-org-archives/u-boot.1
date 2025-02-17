Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 115EBC021A9
	for <u-boot@archiver.kernel.org>; Mon, 17 Feb 2025 18:15:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A495C80CB0;
	Mon, 17 Feb 2025 19:14:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="RnvgeFkx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EE718083C; Mon, 17 Feb 2025 19:14:49 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48FA0809A4
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 19:14:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-aaeec07b705so700357666b.2
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 10:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1739816086; x=1740420886;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nVeYERuBLpaoP3rJO6LPZRy7aF+Q3PWiJkTgunLLnoc=;
 b=RnvgeFkxAS6MCbxyo9UaKSsPrD3F+QVI7iCr9c1SxnfjlGOVUUrTvGClSNPD86YIc3
 jNi9Szd6vLv/tm6T/KSN+PBh6qP7Q8vksxiQWmXC50WegADcYgG07i0BeJzqkIbk5iS7
 ja6hXvfRuf8+gjZxon6sPrZFEToG1Bum0Qe9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739816086; x=1740420886;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nVeYERuBLpaoP3rJO6LPZRy7aF+Q3PWiJkTgunLLnoc=;
 b=r4xZ8Ci3FH+Uy8ZOUDUbEVj6Lu1O2UpdSzBMBspl7s+O4CHgEP9JDQO5/U+q2Q4cLY
 vOjV5M41oQDBbilsecV3sfxGT6ZC+ksrIfH51PftivufgqkOezJwb9o2u/qpVQIdxArF
 GQ59liNvs4H3/BZbLPx+kcWSbhC8Iz+9H1i92PNA16Y+CaEc32QKtfDNgDGMZlb3Mecq
 9n/8NXP1gAT7W9l87aiIoY46yswJ+83XVGhUMAJzYSAPvmtBSosgoFkALL0N0t/A7WlW
 CnVynlLaE9R0yAuan50B/9SRAO9Cc9pTiTszgpcsNmunsUkdUNjcvxPXaVMXWkHe6TwS
 SbRg==
X-Gm-Message-State: AOJu0Yzu7Oj6AvS947vZmMal5IJU901xx6NzA9kmH8bDT5DqEDLwJaAZ
 Cq3qFNd3mZm2FDCp0yxgC1zgzRxogw0rIjj8vgL+ZCPTYP3nERKu+9lf29QLR7rIaDtbcMAV5ZW
 G
X-Gm-Gg: ASbGnctE844AStPvb0+yrie3ZlKGyqYjtg23xlN3x/YTlSyvuKb/N+8KdGxbxUb6Joz
 hbnwzAeip73ROhteIRKBNZuUgqvkehpjpZlGAIgQ7oiB3KajPNkOzJKWqIVlSU6QiTrhL9SkLUs
 X4DhQALsCetIiOH+bGH9+xHt7ovT0RSy1UNEEj87BPVgpWQn/BY9M1s5WumZfBrwMNYMdbj30g5
 fwFjLvVchSZ1MLvgnKM9OLzGgntSpQXPzMLqS2uIS67oMUY0w+CPV2y1lYNBqwEdrlbdLEwYtmG
 aYq3fIURcTWUsJdMqzNwc3ukayjqQOHrHXpJbN+5aR+az68CNaZ9P/ki8g4ZtjRZq7RYeU2P61d
 GrY0+uZDCmJOjS6lo+2erLxapxw0EILGk/2bk1h9AojEniCv/g8lv
X-Google-Smtp-Source: AGHT+IFpRSFVJ77aIdRK9ud3VReP0o/FClyibIft/D3q1bNce8/4xFGIkBGNo+vre05mVAIiYu9YxA==
X-Received: by 2002:a17:906:318e:b0:ab7:5fcd:d4d9 with SMTP id
 a640c23a62f3a-abb70d96dc0mr847037066b.43.1739816086451; 
 Mon, 17 Feb 2025 10:14:46 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it
 (host-87-4-36-33.retail.telecomitalia.it. [87.4.36.33])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abbaa99f283sm113616666b.32.2025.02.17.10.14.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 10:14:46 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Vikas Manocha <vikas.manocha@st.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 3/3] board: stm32f746-disco: drop board_late_init()
Date: Mon, 17 Feb 2025 19:14:35 +0100
Message-ID: <20250217181439.1157972-3-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250217181439.1157972-1-dario.binacchi@amarulasolutions.com>
References: <20250217181439.1157972-1-dario.binacchi@amarulasolutions.com>
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

The removal of the "st,button1" and "st,led1" compatibles has emptied
the board_late_init(), so let's remove it along with the configuration
that allows its invocation.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 board/st/stm32f746-disco/stm32f746-disco.c | 5 -----
 configs/stm32746g-eval_defconfig           | 1 -
 configs/stm32746g-eval_spl_defconfig       | 1 -
 configs/stm32f746-disco_defconfig          | 1 -
 configs/stm32f746-disco_spl_defconfig      | 1 -
 5 files changed, 9 deletions(-)

diff --git a/board/st/stm32f746-disco/stm32f746-disco.c b/board/st/stm32f746-disco/stm32f746-disco.c
index 72f479cea66f..07bc8a5f0a27 100644
--- a/board/st/stm32f746-disco/stm32f746-disco.c
+++ b/board/st/stm32f746-disco/stm32f746-disco.c
@@ -76,11 +76,6 @@ u32 spl_boot_device(void)
 }
 #endif
 
-int board_late_init(void)
-{
-	return 0;
-}
-
 int board_init(void)
 {
 #ifdef CONFIG_ETH_DESIGNWARE
diff --git a/configs/stm32746g-eval_defconfig b/configs/stm32746g-eval_defconfig
index 4346ecd6e42b..bd3a48b20a2b 100644
--- a/configs/stm32746g-eval_defconfig
+++ b/configs/stm32746g-eval_defconfig
@@ -21,7 +21,6 @@ CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 earlyprintk consoleblank=0 ignore_loglevel"
 CONFIG_SYS_PBSIZE=1050
 # CONFIG_DISPLAY_CPUINFO is not set
-CONFIG_BOARD_LATE_INIT=y
 CONFIG_SYS_PROMPT="U-Boot > "
 CONFIG_CMD_GPT=y
 CONFIG_CMD_MMC=y
diff --git a/configs/stm32746g-eval_spl_defconfig b/configs/stm32746g-eval_spl_defconfig
index 2756ad5508fc..d47d059d23b1 100644
--- a/configs/stm32746g-eval_spl_defconfig
+++ b/configs/stm32746g-eval_spl_defconfig
@@ -30,7 +30,6 @@ CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 earlyprintk consoleblank=0 ignore_loglevel"
 CONFIG_SYS_PBSIZE=1050
 # CONFIG_DISPLAY_CPUINFO is not set
-CONFIG_BOARD_LATE_INIT=y
 CONFIG_SPL_PAD_TO=0x9000
 CONFIG_SPL_NO_BSS_LIMIT=y
 CONFIG_SPL_BOARD_INIT=y
diff --git a/configs/stm32f746-disco_defconfig b/configs/stm32f746-disco_defconfig
index 35a489c34e00..f6fbf83f68f1 100644
--- a/configs/stm32f746-disco_defconfig
+++ b/configs/stm32f746-disco_defconfig
@@ -21,7 +21,6 @@ CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 earlyprintk consoleblank=0 ignore_loglevel"
 CONFIG_SYS_PBSIZE=1050
 # CONFIG_DISPLAY_CPUINFO is not set
-CONFIG_BOARD_LATE_INIT=y
 CONFIG_SYS_PROMPT="U-Boot > "
 CONFIG_CMD_GPT=y
 CONFIG_CMD_MMC=y
diff --git a/configs/stm32f746-disco_spl_defconfig b/configs/stm32f746-disco_spl_defconfig
index 6826b1cb7559..dcf077dbfeec 100644
--- a/configs/stm32f746-disco_spl_defconfig
+++ b/configs/stm32f746-disco_spl_defconfig
@@ -30,7 +30,6 @@ CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 earlyprintk consoleblank=0 ignore_loglevel"
 CONFIG_SYS_PBSIZE=1050
 # CONFIG_DISPLAY_CPUINFO is not set
-CONFIG_BOARD_LATE_INIT=y
 CONFIG_SPL_PAD_TO=0x9000
 CONFIG_SPL_NO_BSS_LIMIT=y
 CONFIG_SPL_BOARD_INIT=y
-- 
2.43.0

