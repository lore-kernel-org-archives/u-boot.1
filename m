Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E10AFC54756
	for <u-boot@archiver.kernel.org>; Tue, 20 May 2025 08:55:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CA6F82B00;
	Tue, 20 May 2025 10:55:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="bv3hQ92K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC18982B19; Tue, 20 May 2025 10:55:15 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1B1B82AE1
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 10:55:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43ea40a6e98so55803265e9.1
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 01:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1747731313; x=1748336113;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p9U0blKGXVXwmaC6hRcFej55AndVbW83uaN+gqIslc0=;
 b=bv3hQ92KDqvvXT5+ZqFZ7wYnpnNtk+ZGeXdihu3CnPdyWLjfAhIPTN7DFgpMg8qN5U
 bLfsB7Es0TxTJ40dNU5pTxfWydCV4vE7tZIDq3AE0DP+0DU93M46uaWoM+JuqLN9kKo1
 90RmvYhdCWKyoHxYkWvPZTEZlYpm72vEI9VqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747731313; x=1748336113;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p9U0blKGXVXwmaC6hRcFej55AndVbW83uaN+gqIslc0=;
 b=l1dZISdLNLXEw+wj8rNbtM3Y/YpH0FaCeFTPN357zVStVBpiJu/M0PGsTtiUu1RC53
 G2PtxG0jZAioWff1HoYo9xGpeykUXp5DsU4bWTejWFdMmzj8wCi5BBYc3D1bZ2OL1CCK
 x8VuCrC9sBzv1O/ZxEiKP5rg9t8id6J+ZDuJ7HE4qwfw9m/w0RyyTEok7F5uRFFZfNX+
 j5gAuonzkJDMn8uy42A09xePes/l/1vPLUFoIO/pdEC3l7j3jYW+azGHXaWoyM5080Mx
 tg8HMgfjGJzWAhFndcUFcd0PWyHhn6E2zxmRy4lYYi+E9PrVzL5CadS+486TiONssn2E
 EcKw==
X-Gm-Message-State: AOJu0Yxs2Z8vZVZyRaWzSbUcPZwynscrYFaVVa9RwiTdMYB2VhyV4KcG
 oDiI98Vi+o8pBHBhDFSdPsyNxYXdA5NjRb315vxQN+dXUGGl2TdOXcig/fIFov3vopWVTvn+xPF
 heASv
X-Gm-Gg: ASbGnctk3vAJkoMRNss5uqcGZlTRkArNRebNNaL+iA4sD/U5IjnsWu54xjfPOX2hu9V
 QwSVbRDNPImkhBJzdf10fI9lLJU/jO5rUsYnloc4zHyJ8Yh3Rvd1KVIcKlC2VArzrVB+VWdDK/4
 53v3B1p1J+FSbbDnoydUbOMR1D86vVJSgt2t6I4gm836pst45hUP5lEgZqZOBPakxsK06/RPUEa
 x0Yj+9qWXcHmcwSU5QnFJ00Pj9/nEOgIp+ZrbPIS7Mw/c7/p0toJaNF+kuLXS4f2uf344o9sZvy
 HlHQVKe/7c+kkNzYQzQHHyd/3Ku4KQgYuN915xH283tYAlYnLvVcwE9p1eYqYy040tW7dL+ifB3
 tgeNHf4/Fg7J8JVs=
X-Google-Smtp-Source: AGHT+IHOrOzvCjZ8VTG3jsPtyleRplkLGFYqoHRUAuYZatmdHJyfe28ysLzkNvr9yOYf6dkf6ojCZg==
X-Received: by 2002:a05:600c:4fd4:b0:441:b00d:e9d1 with SMTP id
 5b1f17b1804b1-442fd606ce9mr170365825e9.2.1747731313044; 
 Tue, 20 May 2025 01:55:13 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.. ([2.196.40.47])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f6f062fcsm21541315e9.15.2025.05.20.01.55.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 01:55:12 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Sven Dembiann <Sven.Dembianny@bshg.com>,
 linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
 Simon Holesch <simon.holesch@bshg.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 2/5] imx: spl_imx_romapi: support raw NAND sector
Date: Tue, 20 May 2025 10:54:17 +0200
Message-ID: <20250520085436.925901-3-dario.binacchi@amarulasolutions.com>
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
the boot of the BSH SMM S2 board. As stated in the dropped comment, "Some
boards use this value even though MMC is not enabled in SPL, for example
imx8mn_bsh_smm_s2".

Support load of the U-Boot image from raw NAND sector.

Fixes: 2a00d73d081a ("spl: mmc: Try to clean up raw-mode options")
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

(no changes since v1)

 arch/arm/mach-imx/spl_imx_romapi.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-imx/spl_imx_romapi.c b/arch/arm/mach-imx/spl_imx_romapi.c
index 3982f4cca184..b7008df8e35a 100644
--- a/arch/arm/mach-imx/spl_imx_romapi.c
+++ b/arch/arm/mach-imx/spl_imx_romapi.c
@@ -35,12 +35,10 @@ ulong __weak spl_romapi_get_uboot_base(u32 image_offset, u32 rom_bt_dev)
 {
 	u32 sector = 0;
 
-	/*
-	 * Some boards use this value even though MMC is not enabled in SPL, for
-	 * example imx8mn_bsh_smm_s2
-	 */
-#ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR
+#if IS_ENABLED(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR)
 	sector = CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR;
+#elif IS_ENABLED(CONFIG_SPL_NAND_RAW_U_BOOT_USE_SECTOR)
+	sector = CONFIG_SPL_NAND_RAW_U_BOOT_SECTOR;
 #endif
 
 	return image_offset + sector * 512 - 0x8000;
-- 
2.43.0

