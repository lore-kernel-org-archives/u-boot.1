Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4D7CC021BB
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 18:39:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C51B80F56;
	Mon, 24 Feb 2025 19:39:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="aRyfbKQJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71CDF80FB6; Mon, 24 Feb 2025 19:39:45 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CBF4807B1
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 19:39:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5e0373c7f55so7347281a12.0
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 10:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1740422383; x=1741027183;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LC9kjCT48lQxaMoZxrlHzoJSbY4yRMQoPJZRgzXaGTg=;
 b=aRyfbKQJFqseNgDSMGkUm6FrI1c3SrppVejzRCXoWe8Xh7M8lhfLBtEy50vq/7Plpk
 rq7CcZUX+VTcLCHoytyaOrTEzNzqNhf2ldO7ZkM0934JAF8/5Uls/P+7bjlPFzNHlx4j
 z96Y0LlO5jK9qXCo7uQLA51DW0NWEVh2xvHCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740422383; x=1741027183;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LC9kjCT48lQxaMoZxrlHzoJSbY4yRMQoPJZRgzXaGTg=;
 b=KuZVTZsYB4xNTy8+c0fQ9/9m9reJ9FqzbFv8xXbVL0j2+SHQSKH4s4a9eIbruhx5WH
 Ad0U9ce37YfrFrlmfl0uuzM/xulI3KMArIktdFv4LRf60fa5OdXKsqqFeq3DGlXTdVmE
 9FXXkPQREufrFm3lJRv821Yfw5M8yctT9YF1egY0XFqSHh0LY9iihRigoLK2s7sC01Jb
 59sYUNnmQM5gxufWR+8qIXBGIHm6sf6Q8bd4+K0kpHinBSXBF0a2tDsZl7UK0LKpezXX
 hgDpez2Twj9IpJXErOw/JAmuCdxO45cshO5h1N/cWcS3nRUjOoEtqXbC1QolnTrvcVf/
 JSNA==
X-Gm-Message-State: AOJu0YwGLhaZqTKU00kE3odfSIxgRLrQZwBouUfSxE4ufGWqD84obv7X
 Qd5I/S+vQrtAAe7bg7lR6yBrpOo0hgSAKw43w6J+aE7Sdt+vHD0MSNcme1z2fggFgiQfM4X/zPH
 u
X-Gm-Gg: ASbGnctd/dnEAl01/Yd2qGJ2sebx1nNM6ksrqp6Qblx5Fc4zQcMDAbzN72Ke1+WFZhM
 clPF+ESQx1nXl6sOOHkO2SYVaWUYqy+TC/vfySWkBpP1FKhM9YnkZN+DWM75gT2fH8LcT6rKghz
 GrcSr//qUcr1YfomZuORNj2udGozvhytcaKyYrQX542D7DoCF/yfzuYVzzlTyEjHWPOfN0KraA2
 TYnENCS0nJQT3/lkEtqsJwQOLm5J62kk+u+jZKUmJWFJjuFZJanG8QcL8nBLtTjiDMazWCtM6Lz
 AbDiHARuWPWMY0wIeqbbezyfVYifadO9VDNZIPcu+iMXuNF/RudMUywxmLNq8DAxR26Z709Rs2A
 NsYfgSRkQUqfcIwPkNw==
X-Google-Smtp-Source: AGHT+IG17HfJ1pzaw51w3LQoj0MxZAaO0hxEeFcS0SB6EX2xfgBJp632meNMhiLdKvWsxngYMgr+eA==
X-Received: by 2002:a05:6402:e02:b0:5e0:88f4:1bc1 with SMTP id
 4fb4d7f45d1cf-5e0b70cd6dcmr13503818a12.2.1740422382654; 
 Mon, 24 Feb 2025 10:39:42 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.amarulasolutions.com
 ([2.196.124.195]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e0a2e25589sm8046911a12.42.2025.02.24.10.39.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 10:39:41 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Vikas Manocha <vikas.manocha@st.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2 3/3] board: stm32f746-disco: drop board_late_init()
Date: Mon, 24 Feb 2025 19:39:27 +0100
Message-ID: <20250224183931.313491-3-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224183931.313491-1-dario.binacchi@amarulasolutions.com>
References: <20250224183931.313491-1-dario.binacchi@amarulasolutions.com>
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
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

---

Changes in v2:
- Add Reviewed-by of Patrice Chotard

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

