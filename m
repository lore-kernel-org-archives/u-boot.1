Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2655AC3ABC9
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 13:13:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CF2382BAA;
	Thu, 15 May 2025 15:12:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="msCwP/yd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AE2E82BA1; Thu, 15 May 2025 15:12:55 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3869882B72
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 15:12:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43edecbfb46so7495545e9.0
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 06:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1747314772; x=1747919572;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WLMDYlc7XBPS/Fby7WYjjbe9uW9pf+KvNQavun0zEN4=;
 b=msCwP/ydTxwJNJvGdmlsY+MseqwP1r8fcNsbVKKDnacT0HyHJVcXK6KzYRqcrVWL8U
 772M2TDf5XoMdsJWsUROh2B8n4xXD32BcgqpGEo88rIFd248ZDtbJB762RhuMrU+7x68
 cXOJiLrna5DTQVM/ktVfqLkfHWZO8R0n7yls4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747314772; x=1747919572;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WLMDYlc7XBPS/Fby7WYjjbe9uW9pf+KvNQavun0zEN4=;
 b=QKombdHhRtEP5aqfL1AnJ6VRFQUMEatyjp0tLJmUgL5i7/myKiwK9NCE/686NXbk2H
 NVlCP77KKTmzg92zI+gXJsYQULlMn2+TnhHbWWh52cpWecz2Ivy8KC4vmMq5JDGIVbzH
 riQq72RuFoOgEPG+9XXYMaQNv6C0dq028kwGif5+N4II4y1EPhxV+ZMbkRz1XckppxbH
 stclyFn121BvjBeERnnVk/rSeMoJNDegwZRhHtbDU/DGOdLE60ZpPUvb8ycb2qIUkX9d
 kQaxIxqIw/69SMiVgJ9/XQsAcfhTP7b87fYiJDtd37g4/OSGw3hRydRW29u5cO0nahfK
 hE+g==
X-Gm-Message-State: AOJu0YzcDH+I/KTHhGmFnSgfRqD3OnwWhXsiq9H/LMiqq08hfNWeEMUP
 s9tBKrD+776wXPp+863CxHM2D65VHGQ7ZbaCE7HQI52AKC23QLsRp5oLs7ki0NAmFIFhVIBmFoW
 87rQ=
X-Gm-Gg: ASbGncsIJcOHMsnhiBBa+PlvJMneBoL5Ly4YNvg0yPF1XA7X0Cnr/HVo0CbpuTCGQOi
 52xUOD1qAvZt1nBKiP1iwLmp41FF3rQMQCQlqNYSh6an7hY3sJhGnG/3Nd8KXl/jqGGH/7Gl++V
 sRqQPALHza360BR+sLzI0j9+VVtfTvyApDBbslOW2COj/g5fz+QhWFIEngK+5TN0R6uSwmdgO22
 jkAkUzdY210zR7c0QqWuErzo6BRtT8Stou8XjAAwZ3hvPaEY31aEvmkKLFHlxQ88BcLyOAoy7RM
 whGFZD2BMXa04r2LSGkSsJV+gY+DWlXlmoEjcgYeHqauJweVTbm97a8MOEMqcF0BLD5Us4iESDv
 fmyYwk2jj/e2Sq6c5ddDwz90EMjZys6hgMZpSB2zxS/c=
X-Google-Smtp-Source: AGHT+IHwXN/QKEyvIrxhAwbknAIcDRlagwFQLLGYi2a0HsnBARjc3gYJ0GHdRKJnn2V4ClVROBN2+A==
X-Received: by 2002:a05:600c:3e86:b0:43c:eeee:b706 with SMTP id
 5b1f17b1804b1-442f9706006mr24406015e9.24.1747314772512; 
 Thu, 15 May 2025 06:12:52 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.client.m3-hotspots.de
 ([46.189.28.43]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f39ef811sm65516825e9.35.2025.05.15.06.12.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 06:12:51 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: michael@amarulasolutions.com, linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Anshul Dalal <anshuld@ti.com>, Greg Malysa <malysagreg@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Lukas Funke <lukas.funke@weidmueller.com>, Marek Vasut <marex@denx.de>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Paul Kocialkowski <contact@paulk.fr>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Trevor Woerner <twoerner@gmail.com>
Subject: [RFC PATCH 1/3] spl: Kconfig: allow to enable
 SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR for i.MX8M
Date: Thu, 15 May 2025 15:12:40 +0200
Message-ID: <20250515131246.784206-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515131246.784206-1-dario.binacchi@amarulasolutions.com>
References: <20250515131246.784206-1-dario.binacchi@amarulasolutions.com>
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

Commit 2a00d73d081a ("spl: mmc: Try to clean up raw-mode options") breaks
the boot of the BSH SMM S2 board. As stated in the commit itself, "Some
boards use this value even though MMC is not enabled in SPL, for example
imx8mn_bsh_smm_s2". The same commit makes SPL_SYS_MMCSD_RAW_MODE depend
on SPL_DM_MMC || SPL_MMC. With SPL_SYS_MMCSD_RAW_MODE unset, it is not
possible to enable SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR, thus breaking
the board's boot process.

The patch once again allows SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR to be
selected also for boards that do not use MMC, in this case on the i.MX8M
platform.

Fixes: 2a00d73d081a ("spl: mmc: Try to clean up raw-mode options")
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 common/spl/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index aa3a85eea54d..77bb21e74cd6 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -542,7 +542,7 @@ config SPL_SYS_MMCSD_RAW_MODE
 	help
 	  Support booting from an MMC without a filesystem.
 
-if SPL_SYS_MMCSD_RAW_MODE
+if SPL_SYS_MMCSD_RAW_MODE || ARCH_IMX8M
 
 choice
 	prompt "Method for locating next phase of boot (e.g. U-Boot)"
-- 
2.43.0

