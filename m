Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FB7DC54756
	for <u-boot@archiver.kernel.org>; Tue, 20 May 2025 08:55:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFD7F82B07;
	Tue, 20 May 2025 10:55:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="VIrdkocQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89D6382B19; Tue, 20 May 2025 10:55:14 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 232A782AF6
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 10:55:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-442ea95f738so43598935e9.3
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 01:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1747731311; x=1748336111;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NiQKVm5u89cdiqENo+fYKwV1flBpvFBWTrud/HFbHr4=;
 b=VIrdkocQC647C3x6wXWTHRJaPyO1b65a34+VramXkmgK6XvZiqxVd+Nf8Is4NbpovF
 nQ9URXUeOzRM7mG5X14AhX8OxzJ4XIPj9ti0OKx67cU2FpXv3mzbWVoLYfD2VRRq7Y9i
 /Yd5cPb2wFCks9tJLppJ24eNyWNR1UD2JzqUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747731311; x=1748336111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NiQKVm5u89cdiqENo+fYKwV1flBpvFBWTrud/HFbHr4=;
 b=dPwqcTAoBoS+EK6CvrimVdTPqm1zFwjCktjwh0UW9JU+Yown1m3W4enqW//DCStcVn
 mWJYfRKe4dELLWWbwZfkh/VRrxj/FGrHy2a2g2zR5cdZKYTvo44Zmhm66kITxfd+RQ80
 Go3lSmrNIvNC1daNnydVg76QTM74RcUkYSmHZs02OorUMnLE1SPYO5sHuuLKHux2JcEo
 ZmDgDlfQspqIuqmXUIAVnrO8fwvCzjs7PygbAddEVQ2dvt6BW8ThsCUvaFRX1a6bhL5/
 wyvf3NzcxcGOIBl5R/sxBmHk8gjPOZaoyzDjfV/eW7qX24O+yJleGPd6FuGsRWWFcetx
 J7uQ==
X-Gm-Message-State: AOJu0Ywjjf7L7RUtC8a87hngdYCTRKqYpOT1lFYpIZ7iS8qZ2WEfY1YP
 c5HDZdI+ALnXX3lcW3UkSBcqEDIDKPpSXmOdZ4RIhOMQ/vnVUxavCOvKf4eHPP5N2tmrkk02Glx
 pPFzQ
X-Gm-Gg: ASbGnctQA01dm/H6rZ8gR8pOvC/QhLJAacYYoBfIghWeI6L+HiU7sE/tQXw1sxrc2Lv
 Ep0zhoesHAp/YN3AZVOSrNqJ8C8rTLGR9NEB8Cf78CCxcMyoNHTAoo7uAA3zbZDj9oKdn8X3ACh
 sxsNfajVU95FdyJiguIIAt7VzaBQWvKX7ocGDGZLJzbUuVcllxJZDUnjY+A54hsZlsLUX+cywUe
 aD3g17Ku3VrY7wEU7Fy+CR2NAqpYJzRBYQ+i/637BkYHe09/FuEQCIjddqBUcgXwTlYIS+K9jBA
 F5fNlRz2xD6b0wG3TDg0kqJbd/OgSDieskbF4ywsyRRkpt+7S8bAGd23xgfH7dW2QyohqTC177z
 Jc3+AhawbO/G0vyReApojbwEgqQ==
X-Google-Smtp-Source: AGHT+IFkwEuNzb1MuL7/RzJh7uw2ns0Pvy9Dzm72boMTso3SPkwC488+id4PO6AcD/gCDkEGzC+oOQ==
X-Received: by 2002:a05:600c:1553:b0:43d:17f1:2640 with SMTP id
 5b1f17b1804b1-442fd665728mr131599885e9.26.1747731311416; 
 Tue, 20 May 2025 01:55:11 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.. ([2.196.40.47])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f6f062fcsm21541315e9.15.2025.05.20.01.55.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 01:55:11 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Sven Dembiann <Sven.Dembianny@bshg.com>,
 linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
 Simon Holesch <simon.holesch@bshg.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Anshul Dalal <anshuld@ti.com>, Greg Malysa <malysagreg@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Trevor Woerner <twoerner@gmail.com>
Subject: [PATCH v3 1/5] spl: Kconfig: support U-Boot load from raw NAND
Date: Tue, 20 May 2025 10:54:16 +0200
Message-ID: <20250520085436.925901-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250520085436.925901-1-dario.binacchi@amarulasolutions.com>
References: <20250520085436.925901-1-dario.binacchi@amarulasolutions.com>
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

(no changes since v2)

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

