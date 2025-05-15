Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87EC1C3ABC9
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 14:56:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12D7782C10;
	Thu, 15 May 2025 16:55:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="QtMPVN9H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67AB382C44; Thu, 15 May 2025 16:55:58 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1CF782C0C
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 16:55:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43edecbfb94so11281655e9.1
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 07:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1747320954; x=1747925754;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dBZMkU0pjeY/K2xj84hlOGh4yDk5pW0FPdReRpQNzNo=;
 b=QtMPVN9HZgfZQ4/D6slEBLk4BHR4WfTq0WjO8i0P4yK92MOvlfFRLHYeInR7co9xje
 ffMLYMFJ5sh+LxiAk/BDokmjy2XsKEMJnyxawEZeebmhQgaUQarCDo6lFkYS5f7dOfxv
 wBaCmDHG58yPF85DIA4TrbcQqS9Qvcuu/xKes=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747320954; x=1747925754;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dBZMkU0pjeY/K2xj84hlOGh4yDk5pW0FPdReRpQNzNo=;
 b=tMA4uM6t3DLk+4sU9Dz1Y0IutTWwGitqEHxnbENn86SW0PiTdxZAaU7KXiYhadT6Ld
 6JOBKobDt0BX696sOXHGjlhDAv+2B0Cyv7EQ8gMN/SGrHJuhgU/nS+RAwpT67GgUUybe
 snt7ntJ4ZR3kHwI2U7qqEbnnavBZwQESsZc3rml5OhbxHAnOjtpyProj+okRzdamVGRE
 9/Xi0Be5LwuBKHOlwx9HzHDmewzdEKPX24AO6fVYLYxZTFJFyHRuQn1KoHdMRTaayH5Q
 0TWMlnFkbUgmiOk5xE+HwhBgymHYFqKqDhmXLUXBRWFQjZAieVg03JUnf1PgxE7wE9MN
 M3AQ==
X-Gm-Message-State: AOJu0YyLWu6NWFsiEpcfk/12gp0bqMOUCrJt8U4R9zGle9i+Kyogxg+4
 vq69pE/VsZbg4gVXpkS617PnUHIcjp26KhJor9/jevqyQzl+7BzLNzaDI6niOALeoUrEJHiW8bN
 isKQ=
X-Gm-Gg: ASbGncuRNcBYrprhdoHWa3sxiktuXvmGiHac5eBeLP53amYBUYNftARl+Y2UEKC70c1
 xvUJJgfdm2phYRarMBg5HbICTYzce5U65/nbV08/a9xIOWEzkNvA3a6OOdn5KccY+R1tzLimG2R
 Emnrq+v5nHECCK+cVPvbyuyN3hgwVaUm0d7UrNe6hhGiYu0mk4PxI4rpHXO4/Jg7Y7lxiT0Amgl
 JB9aFnajNlMpcVloWnSGGAyjUXZ6OXE20jkprjA06TynzTAewScOTVysJ0J9NsSGtLPjyf59K8S
 D/kdJlWWhJqEU6BTaA5QUxRZwghcdrmCbHZsN15Uf5vGnN/hsvi3JcU25L3yaWsyIzmmvQBx/im
 n/P3KmFBSj7NKtke+/uSGo1i2OR/002Cwmgz7HhSUa+A=
X-Google-Smtp-Source: AGHT+IFeXpQ72db/guDLALLc5zUkYc899TpFd4QypjhKEe7bgyMcGVQd5ICqRQYhS/ID1Yt8Z/cU0w==
X-Received: by 2002:a05:600c:c0c3:10b0:442:e147:bea7 with SMTP id
 5b1f17b1804b1-442f2178383mr46764265e9.29.1747320953889; 
 Thu, 15 May 2025 07:55:53 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.client.m3-hotspots.de
 ([46.189.28.43]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f3369138sm77030235e9.8.2025.05.15.07.55.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 07:55:53 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: michael@amarulasolutions.com, linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Anshul Dalal <anshuld@ti.com>, Greg Malysa <malysagreg@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marex@denx.de>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Paul Kocialkowski <contact@paulk.fr>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Trevor Woerner <twoerner@gmail.com>
Subject: [RFC PATCH v2 1/4] spl: Kconfig: support U-Boot load from raw NAND
Date: Thu, 15 May 2025 16:55:34 +0200
Message-ID: <20250515145541.886857-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515145541.886857-1-dario.binacchi@amarulasolutions.com>
References: <20250515145541.886857-1-dario.binacchi@amarulasolutions.com>
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
imx8mn_bsh_smm_s2".

Support load of the U-Boot image from raw NAND sector. This is equivalent
to load from MMC raw sector.

Fixes: 2a00d73d081a ("spl: mmc: Try to clean up raw-mode options")
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v2:
- Add SPL_NAND_RAW_U_BOOT_USE_SECTOR and SPL_NAND_RAW_U_BOOT_SECTOR

 common/spl/Kconfig | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index aa3a85eea54d..77cf04d38ed0 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -974,6 +974,21 @@ config SPL_NAND_SUPPORT
 	  This enables the drivers in drivers/mtd/nand/raw as part of an SPL
 	  build.
 
+config SPL_NAND_RAW_U_BOOT_USE_SECTOR
+	bool "NAND raw mode: by sector"
+	depends on SPL_NAND_SUPPORT
+	select SPL_LOAD_BLOCK
+	help
+	  Use sector number for specifying U-Boot location on NAND in
+	  raw mode.
+
+config SPL_NAND_RAW_U_BOOT_SECTOR
+	hex "Address on the NAND to load U-Boot from"
+	depends on SPL_NAND_RAW_U_BOOT_USE_SECTOR
+	help
+	  Address on the NAND to load U-Boot from, when the NAND is being used
+	  in raw mode. Units: NAND disk sectors (1 sector = 512 bytes).
+
 config SPL_NAND_RAW_ONLY
 	bool "Support to boot only raw u-boot.bin images"
 	depends on SPL_NAND_SUPPORT
-- 
2.43.0

