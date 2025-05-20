Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3692C3ABDD
	for <u-boot@archiver.kernel.org>; Tue, 20 May 2025 08:55:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B74982B54;
	Tue, 20 May 2025 10:55:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="aedsl3N6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2982582B34; Tue, 20 May 2025 10:55:17 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 419C482AF6
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 10:55:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-442eb5d143eso53026125e9.0
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 01:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1747731314; x=1748336114;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gLm4tGRqCLOh2QJZWpm0q8R82rqb/yjH59893ajRa4w=;
 b=aedsl3N6jiMCx4Y3+IRcWxfpDXWcA5pgijhvvU9U0JRIgfQvRvRuaRmBxlMFsG8KHg
 w9C9xeQ/v01LOkhznP6sJ2BtGau3T7B8fQT4ss1Yf20xy1uCAed7sttD0tdJBlPO3t9x
 rwelXSUo+cE5j3DbPYVwEyXOJxtpsOQsOfbyc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747731314; x=1748336114;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gLm4tGRqCLOh2QJZWpm0q8R82rqb/yjH59893ajRa4w=;
 b=H04/pHaLVg5yhYaPhRqKeR7g8Sqd2tYGsxFpEIPKRKuVGMKxXzq9QuZWtgU0fQYRUx
 /ah69mfs2Qw5d1+gPrUAtEIqNmA4/SLa/PNl0NgdtNgcSTGN1POWpjw8+IYYYgyEn1H+
 8kbCX49iKe61Rva1XZPskFK/YdJreoPRiouSlSj3COxoH0BIOAKn2Ww/sY74OS6+3+bn
 wvF9MUiNqrbBtnomuxYEhPoMOM6IjtRorlwQ6cASGhgjOfZr96zpbQCYfhXFacio/+0Z
 A6VmPgL38LudzoPU2TegBdIyp+XQ1vDxfy73dS10wG7/r748cuO4+v+F61hnNjzv7eW1
 1fvw==
X-Gm-Message-State: AOJu0YxZnHfwY3pm/yUn/xBsV1gxFqKs1VRoqpIQlm2Pc+sRvT0dMUdu
 BkwR89wWFAZy15+JYSuUZ7Ln7LZGakoDKWtlXxy1PYjuWlS68m1koy8KSU1AeO3F4toQHY/RnUB
 AkczO
X-Gm-Gg: ASbGncvL7N+8EXMywwfv8uLQw0shmd2QeQ1yp2oQZppbKDNMiRjDn7NrKz/re1/oCbW
 Kk5GwMDoHI2mJb4EUfprr+/udx0DO4L4wJWAz4VlTtNjMoIfhoFYVD6+SALcRqYOQANzBH/s1d3
 mQxmMho014098sFZoEHCavhxo9VnIIOP6ySCqcnw+UsgYLt/EXvmA3hECaL/VKpLh/qJmisKICt
 CHJ/xhnQrp713c844JImQM4VMchit1xVJQ/b9GyPRAxPH5f3X7ew38imWUpXI/BrR971WpIUEwA
 sT86Xx24b1v9SSPQxykBeTtuJYjISmOKYGIEfE/JdS920XFz0mSUbJi9Zvq38bNUb5GHib2UYWn
 ZTKok2Oa/P2ZnarhZ9HggqghZzA==
X-Google-Smtp-Source: AGHT+IETUoF2X3b/dSjZoFWYbZBxuIt991U/wPmkV7NVw1GuzGgFEIZ/kAkRZNgAj439H/AonMkExw==
X-Received: by 2002:a05:600c:4f42:b0:442:f4d4:522 with SMTP id
 5b1f17b1804b1-442fd60a5bemr145293495e9.5.1747731314521; 
 Tue, 20 May 2025 01:55:14 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.. ([2.196.40.47])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f6f062fcsm21541315e9.15.2025.05.20.01.55.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 01:55:14 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Sven Dembiann <Sven.Dembianny@bshg.com>,
 linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
 Simon Holesch <simon.holesch@bshg.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Patrick Barsanti <patrick.barsanti@amarulasolutions.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 3/5] configs: imx8mn_bsh_smm_s2: load U-Boot from raw NAND
Date: Tue, 20 May 2025 10:54:18 +0200
Message-ID: <20250520085436.925901-4-dario.binacchi@amarulasolutions.com>
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
the boot of the BSH SMM S2 board. Add options to load U-Boot from raw NAND
sector.

Fixes: 2a00d73d081a ("spl: mmc: Try to clean up raw-mode options")
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

(no changes since v2)

Changes in v2:
- Drop CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR.
- Add CONFIG_SPL_NAND_RAW_U_BOOT_USE_SECTOR and
  CONFIG_SPL_NAND_RAW_U_BOOT_SECTOR options.

 configs/imx8mn_bsh_smm_s2_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/imx8mn_bsh_smm_s2_defconfig b/configs/imx8mn_bsh_smm_s2_defconfig
index 9ffcd3b221c3..1c11d4705419 100644
--- a/configs/imx8mn_bsh_smm_s2_defconfig
+++ b/configs/imx8mn_bsh_smm_s2_defconfig
@@ -47,6 +47,8 @@ CONFIG_SPL_DMA=y
 CONFIG_SPL_I2C=y
 CONFIG_SPL_MTD=y
 CONFIG_SPL_NAND_SUPPORT=y
+CONFIG_SPL_NAND_RAW_U_BOOT_USE_SECTOR=y
+CONFIG_SPL_NAND_RAW_U_BOOT_SECTOR=0x300
 CONFIG_SPL_NAND_BASE=y
 CONFIG_SPL_NAND_IDENT=y
 CONFIG_SPL_POWER=y
-- 
2.43.0

