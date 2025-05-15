Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8414AC2D0CD
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 13:13:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9A4F82B95;
	Thu, 15 May 2025 15:12:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="g1Hdc8nP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D0D682BBF; Thu, 15 May 2025 15:12:56 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 534CC82B54
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 15:12:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43cfe63c592so9769945e9.2
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 06:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1747314773; x=1747919573;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xKE9jX7w0jOEfJrhDGgjuZE1QRlVotNFhAZ7lqe6MZQ=;
 b=g1Hdc8nPyG1HkrKIvcFB7HskkHid7A+bPVThMMVkJDigGWZiiAuFRynwDtCUf6rQPJ
 lyf63A1am/8lzBGGW5t4qLGGderAx0lq9d9BJUXbUyx2xgEyus7cmXqVnf+FdJHez3iD
 9/tNhgFPDNOOoWK95cNbUpj8NuSyXb8Eld2TE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747314773; x=1747919573;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xKE9jX7w0jOEfJrhDGgjuZE1QRlVotNFhAZ7lqe6MZQ=;
 b=TPK4u6Ko2pYRpLSS0sl88mqW/KGkBp0Chs/xLQMg5s7IfZCdISUQEdNwnO/EJt2TwR
 ITltnzhBl9/one5XRr7cKA7/vTdV9nLK8SeS5uu/8sZp4jTiWXCAQCpTmvMJtx0daAWM
 DuOpruK9AYoNYKIxVyF06U5aEXL7STuhk6zcj761aOTUBLwURK6GDci5ad3iy8GH02dp
 5xPxyC0ZO8q1VA/4q8b/mowNBvuNDluvGZTkGGUVMIeqZGmZl0G6MFbIf6MOFjrCR3SL
 eDfauceW3/b0rooM7AmQ/ScimpJ73usUOiBW6ZGFWxRlmaIYaDSE/cKL8a6P42klS+V4
 PI/Q==
X-Gm-Message-State: AOJu0YxlbL2vLE42RreaZAj5s+qQ9lfz08H8QTwJJ2hTSYKynqEUnJxU
 p0bA45Hn4517j3iGGSb/EqjeHm//Z86FTOgsO3Xt5wZ+20+S1Db28g6gOd7LFFVE+2B1NGpChse
 NbGQ=
X-Gm-Gg: ASbGncvjiuv5OowHgVSbiizjVE6blLek7cjhVlTOLq9fJZtdkXYCFewDsX5N5amPC1C
 wYCxIzs7S1YzSCzwH0sJFPMcnaotNEFc4gi/8VtGweKiQpsT0cjIOzk70kec83GUPsvrxg+B3Sp
 SCyCuLT85kf/GBZ3x6L1rvoj4Xa29zBJ63aCxf8JJIkNNlLA3YlFL8oJvN4keZ5jdASEnQ0qzBP
 Ll5ODtL6+K91Y07P7crghtCmSzZ8Baixj39f7G66/bOLvAUHQXpo7MLt289ETnWPR1tfIWp73+1
 LYUSg9OKxjZJiDFwESp0ldS7lsfZCBxAxCCevgdkaONa2wjaNzkDlHq05QJQqS+74Q4322C/lmn
 t97EVDgM6SBXtZ3YACVTA2pfGb+LwzgqnXStf6lRG7PA=
X-Google-Smtp-Source: AGHT+IGPuOgxveKQEwMo0gkbrOirYPACy/N8+hTGiKhX319LE1mFQHLsJ1QMDrDf0A7bLSkpPHqFUQ==
X-Received: by 2002:a05:600c:3e87:b0:442:e0e0:250 with SMTP id
 5b1f17b1804b1-442f21793d5mr64790515e9.29.1747314773589; 
 Thu, 15 May 2025 06:12:53 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.client.m3-hotspots.de
 ([46.189.28.43]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f39ef811sm65516825e9.35.2025.05.15.06.12.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 06:12:53 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: michael@amarulasolutions.com, linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Patrick Barsanti <patrick.barsanti@amarulasolutions.com>,
 Peng Fan <peng.fan@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [RFC PATCH 2/3] configs: imx8mn_bsh_smm_s2: restore
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR
Date: Thu, 15 May 2025 15:12:41 +0200
Message-ID: <20250515131246.784206-3-dario.binacchi@amarulasolutions.com>
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

The commit d892702080d4 ("configs: Resync with savedefconfig") drop the
CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x300 option due to the previous
commit 2a00d73d081a ("spl: mmc: Try to clean up raw-mode options").

Restore the option, which is necessary for the board to boot correctly.

Fixes: 2a00d73d081a ("spl: mmc: Try to clean up raw-mode options")
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 configs/imx8mn_bsh_smm_s2_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/imx8mn_bsh_smm_s2_defconfig b/configs/imx8mn_bsh_smm_s2_defconfig
index 9ffcd3b221c3..61aa0c6c0607 100644
--- a/configs/imx8mn_bsh_smm_s2_defconfig
+++ b/configs/imx8mn_bsh_smm_s2_defconfig
@@ -43,6 +43,7 @@ CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
 CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x42200000
 CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x300
 CONFIG_SPL_DMA=y
 CONFIG_SPL_I2C=y
 CONFIG_SPL_MTD=y
-- 
2.43.0

