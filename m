Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E482CC3ABC9
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 15:10:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D45482C0C;
	Thu, 15 May 2025 17:10:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="q1dd+Yo4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7548C82C2F; Thu, 15 May 2025 17:10:03 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5116782BE4
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 17:10:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-441d437cfaaso6755135e9.1
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 08:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1747321799; x=1747926599;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hcKIWhIr0d1PRc2yYCqhC8pwCdfs3NBC0ihNbHSP4Iw=;
 b=q1dd+Yo4eG26neRLbD2s04/l4jRXkqxaxPHU/F+dXKasi6QVpp2nNOCTpMKJ4CHyG8
 ECFIRxKo5zjqnrp6DCMG0sRSLnmojEo3aWyEKMB3ojAaisGTVN8VDBlLG0xQJJkONXek
 Uy36S7egtXlzJPFgi1GlsGPwBW7axIXTJzC0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747321799; x=1747926599;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hcKIWhIr0d1PRc2yYCqhC8pwCdfs3NBC0ihNbHSP4Iw=;
 b=mb19OaXjxFTXR2XyQ5LciZaVhU2FwcrIhtN3uWkUpFM77nWUHsWuoO95dd5mqZXWPW
 OglephrwUPaxeKss+pSPC7VDkFCZlEIVFBL1gpvOVVa5Dp/u75KyHu+DtujiTisE4/Uf
 7VSkK+VRlT5Uyr/cTubOtn7yUjn+YoJNqnovvTBpiP0zx5olBSf/FxF7I4ft9v35cDFJ
 7V8S2yFaYTwMyOi+cwOx3UynJ9BEQoTDCI9GDmAcrXTawkHbogUNEqSQteab9R/2GFPC
 HlcaXk/GYgA8ap1Hhnfkp7L6ur53cE2Anhq1a8zysAiKwHyiiebJ8oAbTfiLL+gfDVH7
 MvMw==
X-Gm-Message-State: AOJu0Yyadj0Qhx0bzoNIN/lyC8WJQGR7PItR17xCjkAC02mj/t2zMywz
 fBm5dl0MJnw9VG9sqNLho7I3eybN6pW+8LuCO7uUEg79SBTd2kIx1FmYmr+1vUlhyH/4Wn+ZM/S
 zMnw=
X-Gm-Gg: ASbGncucH18Puv3Aept3Kf7odJQV9LYtgc0Bjt52Vu71jok9uYM8juqDnJse8nKWNEC
 JEm4hp0CLI7FZeqz3m7yTSDZiKiT0C9euDYa2pXaz2F5kIOJzwVEVUiBQse+LnPS34hmgmsy7a9
 eeu+qqHh5tfDNQFBwi8tsxrugs7dJXsiX3C3ONNxKkkCsYJ5GUpDzuTUa/JYHUSFMZuUWY9b3Nh
 tJxICqFZ8fUkzM6Ga8W568ubvwZih5L7Nz4vLQL2UL2sSdzAdHo5hpTre0u/qL/qSmGO2hgWcG6
 IgjWb0imv5U61NsA4SKqwZMY0dhV5D9q1ARC1RDWGkQ/+4E6z2QncgzVbiLIpXykhhEFPfKSQn+
 Lat/ihs5jXYStKpPpvDhusnGh+INppiEo1Fb1CH991gE=
X-Google-Smtp-Source: AGHT+IFB5uhwBM3YvIROcwbC2YIUFpackI0ZoiI/ZFec6wE6vmn52pdEdIdlDCxTLvor+tzqsWEfsA==
X-Received: by 2002:a05:600c:4ed3:b0:43c:e7a7:1e76 with SMTP id
 5b1f17b1804b1-442f96e6f53mr25475415e9.1.1747321799524; 
 Thu, 15 May 2025 08:09:59 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.client.m3-hotspots.de
 ([46.189.28.43]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f39e853asm74793875e9.26.2025.05.15.08.09.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 08:09:59 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Fabio Estevam <festevam@gmail.com>, Marek Vasut <marex@denx.de>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Paul Geurts <paul.geurts@prodrive-technologies.com>,
 Peng Fan <peng.fan@nxp.com>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@nabladev.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 1/2] arm: imx: imx8m: soc: fix the macro name
Date: Thu, 15 May 2025 17:09:51 +0200
Message-ID: <20250515150955.926708-1-dario.binacchi@amarulasolutions.com>
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

From: Michael Trimarchi <michael@amarulasolutions.com>

The function arch_spl_mmc_get_uboot_raw_sector() was never compiled,
even when the option CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION was
enabled. So rename the macro SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION to
CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION.

Fixes: 2a00d73d081a ("spl: mmc: Try to clean up raw-mode options")
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

---

(no changes since v2)

Changes in v2:
- Add Reviewed-by tag of Quentin Schulz

 arch/arm/mach-imx/imx8m/soc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/imx8m/soc.c b/arch/arm/mach-imx/imx8m/soc.c
index 567e8e9e81a0..806adcf145fa 100644
--- a/arch/arm/mach-imx/imx8m/soc.c
+++ b/arch/arm/mach-imx/imx8m/soc.c
@@ -791,7 +791,7 @@ int boot_mode_getprisec(void)
 #endif
 
 #if defined(CONFIG_IMX8MN) || defined(CONFIG_IMX8MP)
-#ifdef SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
+#ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
 #define IMG_CNTN_SET1_OFFSET	GENMASK(22, 19)
 unsigned long arch_spl_mmc_get_uboot_raw_sector(struct mmc *mmc,
 						unsigned long raw_sect)
@@ -826,7 +826,7 @@ unsigned long arch_spl_mmc_get_uboot_raw_sector(struct mmc *mmc,
 
 	return raw_sect;
 }
-#endif /* SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION */
+#endif /* CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION */
 #endif
 
 bool is_usb_boot(void)
-- 
2.43.0

base-commit: 1b5e435102aa29a665119430196cb366ce36a01b
branch: fix-SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
