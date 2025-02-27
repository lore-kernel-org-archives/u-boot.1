Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EE8EC021BE
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 10:30:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EADC1811A7;
	Thu, 27 Feb 2025 11:30:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jesLEXt6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA5A781197; Thu, 27 Feb 2025 11:30:20 +0100 (CET)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A082811DF
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 11:30:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2232aead377so14848125ad.0
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 02:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740652165; x=1741256965; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=J0grHljJheoK8BhLA8IspCi9R1Shn9cxmyE5J20jI1Y=;
 b=jesLEXt6mZbAv77yM/hXdRc3n/Fcq98TZcOfwSLRehBaMWSrsCoPA0W2vr39OnzKZS
 D52qIvhCfoVNoE0SAnTEoL8E3Zg5sGDZMK39OkU/BMqwOG0gBZ0Ob+U1rwVRuzwicWGW
 H//JcIa3fOo43KV9tRWBDB7R0WDvruawf8cpkZU6HvxND1Lr/SC12tE+lF824CzU948U
 FQLkqNa8cOpiICwjbSUZjHpBvaSm/ZaMcmAvKuG0iz02bqtzVSwnvoV46a46je8jP1ps
 /XawwvRPBsykoh2/apO9aR6kLOdioqrw7bW25e00EWhsShroMUUcKSCUik1h1RRYUVuH
 616g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740652165; x=1741256965;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J0grHljJheoK8BhLA8IspCi9R1Shn9cxmyE5J20jI1Y=;
 b=H/qYQXCIsLrb+wSv/DvloTlLditXpl66iqNKXu9ZUExiWq3L0L/rbOfpkMjEi3P2Nj
 M8fsBxR5etr57Vup1/+7W3l5pcE9+P8oAexiE3QU9Zs5W8lGX1JkGy0luoNsFcz8IA7h
 hZlZhdEyNQIm0n0iNs2HpgJxsF/HFziHxfGo9V2qkTfrAkj8f88qZ76REgUlYF2vPEeT
 Pnd2wMNGJIgGIe6FJYgFITRlOi7FUiqMZsK9nzlQ9IWyXwUrX2Jgaw88ALHjpVXStfN/
 rmFwn0bun95ID1FSqLMCXFa+/pesDpr/6VFesQu5aEAl4ZaQWNhhAOaOCL7QkTUMceEr
 h4Ew==
X-Forwarded-Encrypted: i=1;
 AJvYcCVaDyw+EUBaPmknOqcpHK7YaBRncv7RL+P4/7jOx6YObaqUIAfAFW3ONdQmUPjSkbsvdpmsAdk=@lists.denx.de
X-Gm-Message-State: AOJu0Yx303KVBUNfLGHDs8yt4ikXyxL9VFTXHVPkwmyE2z/A6p/Muor+
 I35jL1oDOVJ7puV0tMuDS6BNdY4hukoMrYv851OpfE8SBEtZmFLY
X-Gm-Gg: ASbGncsav7X3AbknM3j63Uv/Ie5p797Rs970V48MjkTgc7lvSz1HqDZnNAGBZe0DcOz
 u+BrFsOpKwlSgcxtf7Ui1aJzHkXZUoQ68pPPMeB2kCjz2P83m58B9ZKEtDKHTsJFYcVN40Y88fL
 UCuHWhu5pOVfpZueYfjSkCLLY4pA2BS1VEH+Tn7t0ZRlWpX4Z68MIKnNfFGXrCONDHLLB10XY6Y
 KxO8AcCoz4+7ZsdC8RjtXYXqnDk2IYq+A6hNjSCoAml2SwWbWcEeqh8GQeM1Tf2dbLsZFdQJ2BU
 BitFJpb3cDmxtFJOoOUKjEqOqm2sXcajd+chzL6p
X-Google-Smtp-Source: AGHT+IG5za/ci1N1lBC81z15B/bGwEn5PW29XmKbnEIfmn5C/4illm1lePwIYHZJVAGT4iTlI7JQPw==
X-Received: by 2002:a17:902:ccc1:b0:223:2aab:4626 with SMTP id
 d9443c01a7336-2232aab496bmr102165635ad.11.1740652164849; 
 Thu, 27 Feb 2025 02:29:24 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:5a29:6887:1512:7ff3])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22350513ac4sm10977835ad.222.2025.02.27.02.29.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 02:29:24 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: peng.fan@nxp.com
Cc: trini@konsulko.com, u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>
Subject: [PATCH 1/2] imx93_evk: Pass kernel_addr_r
Date: Thu, 27 Feb 2025 07:29:15 -0300
Message-Id: <20250227102916.164418-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
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

From: Fabio Estevam <festevam@denx.de>

Currently, booting via bootsd fails because the kernel cannot be retrieved.
The reason for this is the lack of 'kernel_addr_r'.

Pass 'kernel_addr_r' to fix booting via bootstd.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 board/freescale/imx93_evk/imx93_evk.env | 1 +
 1 file changed, 1 insertion(+)

diff --git a/board/freescale/imx93_evk/imx93_evk.env b/board/freescale/imx93_evk/imx93_evk.env
index f692f42f78ab..8c3aef6b557e 100644
--- a/board/freescale/imx93_evk/imx93_evk.env
+++ b/board/freescale/imx93_evk/imx93_evk.env
@@ -16,6 +16,7 @@ mmcroot=/dev/mmcblk1p2 rootwait rw
 mmcautodetect=yes
 mmcargs=setenv bootargs ${jh_clk} ${mcore_clk} console=${console} root=${mmcroot}
 prepare_mcore=setenv mcore_clk clk-imx93.mcore_booted
+kernel_addr_r=CONFIG_SYS_LOAD_ADDR
 loadimage=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image}
 loadfdt=fatload mmc ${mmcdev}:${mmcpart} ${fdt_addr_r} ${fdtfile}
 loadcntr=fatload mmc ${mmcdev}:${mmcpart} ${cntr_addr} ${cntr_file}
-- 
2.34.1

