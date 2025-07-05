Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4FF9C83F05
	for <u-boot@archiver.kernel.org>; Sun,  6 Jul 2025 03:51:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E61978303B;
	Sun,  6 Jul 2025 05:50:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="W7fJti47";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D271810EB; Sat,  5 Jul 2025 22:57:28 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9D9C82AF6
 for <u-boot@lists.denx.de>; Sat,  5 Jul 2025 22:57:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vtpieter@gmail.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-ae3b37207easo357053666b.2
 for <u-boot@lists.denx.de>; Sat, 05 Jul 2025 13:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751749045; x=1752353845; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l/lPPO0E/5Qz4QjFXYKvJlr+YdtKSLO1x6QwruZyeBw=;
 b=W7fJti47NqJ03J1smFioKoM5PYDpjKPKKm0jbNSbbt1xNTu+IRWBdIXnNePSHNmt9x
 d6YeZsd2Frq84gzs7t27syguWetOzCfxO18i5BnEajoA2kckvR5j1/huKRM+IMeNWbR4
 nxYDfn95HJzzUWdxhtxMelEyw2tvg2qICFdhOctjt5FNcTueu9/xCw93Vc5bttycuEUY
 3WDhpjVrYtGrC2bI98uybM/o0s4PP+AJQf8vJk34HljQohr31IIj6e6ZVQ3jyiKh3dIa
 Hwnoz1yYI/oQDZ+Z1ZyPuYMiUoVPP8bP5XZUu5XMIjmyL1+/sSD2iSEaVK/4+T7bm2LE
 5kPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751749045; x=1752353845;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l/lPPO0E/5Qz4QjFXYKvJlr+YdtKSLO1x6QwruZyeBw=;
 b=i8VWxjcRgyoaOsjp8a+sx5/PTg9xoTse/BMLlplLk3KLgEHHX5Gq2BtUQtue7EO2NS
 6fGdysDh89hB97P68cVlgTHCwqTUSR1a7zetgvnK9dtDCEVqqCy9EPTZNDUm5l1TFg4v
 r0k6bDtVnpdMA5bJBrZMhLo756rzWrUKK25tLKA98zVpm9hngcXXVYirxiIBDosHHeKZ
 IH0o2rAQYOSdygo8abKF7EvIB+P5eUC8K2esSJTHY8tqvddcPSe7b0lXzszWChvHVPur
 VzCvSSqNo9iL1m1QQsZsdFoQxGdduUOfRQZneDXLG79M3tTCKDBboND2e9AwePpWelXm
 Iu5w==
X-Gm-Message-State: AOJu0YxIJFakUW/gdsP62F9tKgaz0y8641GGdV9Va2KThF8cL9B+OAv7
 Y9mLLEY3gop19fIdiaxUbHlr1b1HB7dUp38cxsz8JjFf4pyGsMITrz4we8T1pTvLiIw=
X-Gm-Gg: ASbGncvvbDvBP4JfE9+OsSCgLCmsESSVqV7K1kuAY3ETR7LyFjMHI8o4Uff+U29N534
 EVbNFQY5bxR8EBdTICWX6GQcfWuhmp7IhPMyAaLq1D7Rk2ieunS0eEQbYm6AdUfjAcTUdzW20Fm
 SJSyYRuxu6PAmIuYIyC4fNJnzCDH54/2GBZeDb9ZXiW1CslrfWDfgLOfyizRqoLVU0cHjhNaTJj
 a63cncFojx3Me0eqrsuuy9yNaMKOW/waqm9AT2dWe+LZkH3cBYloBspT22idi0Cu9FR1O1zWgeQ
 mk3/zkRDV4ITIQq8V5gwv8KA3bWAjrTdBSF+wfbWRR/9cJZZqnarpEtvQlTmjjl5vo8tJPp5tig
 =
X-Google-Smtp-Source: AGHT+IGbzO8mO64rxKT5KDSaUpSI8tbb/MiDOxFtcEN/e8rU6wuCw+Re3kxBSPHxxFu6lONQReT6wg==
X-Received: by 2002:a17:907:7293:b0:ae0:c0b3:5656 with SMTP id
 a640c23a62f3a-ae4107dcd56mr284504166b.22.1751749045267; 
 Sat, 05 Jul 2025 13:57:25 -0700 (PDT)
Received: from lapsy144.cern.ch (lapsy144.cern.ch. [2001:1458:202:99::100:4b])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae3f66e6f51sm399423666b.8.2025.07.05.13.57.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Jul 2025 13:57:24 -0700 (PDT)
From: vtpieter@gmail.com
To: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Cc: michal.simek@amd.com,
	Pieter Van Trappen <pieter.van.trappen@cern.ch>
Subject: [PATCH v4 5/5] configs: enable FPGA commands and drivers at
 sandbox_defconfig
Date: Sat,  5 Jul 2025 22:57:06 +0200
Message-ID: <20250705205710.792370-6-vtpieter@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250705205710.792370-1-vtpieter@gmail.com>
References: <20250705205710.792370-1-vtpieter@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 06 Jul 2025 05:50:01 +0200
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

From: Pieter Van Trappen <pieter.van.trappen@cern.ch>

Enable to facilitate compiler checks on most FPGA-related sources.

Signed-off-by: Pieter Van Trappen <pieter.van.trappen@cern.ch>
---
 configs/sandbox_defconfig | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index 4f6943d1a4b..a64e208ad89 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -78,6 +78,11 @@ CONFIG_CMD_MX_CYCLIC=y
 CONFIG_CMD_MEMTEST=y
 CONFIG_CMD_CLK=y
 CONFIG_CMD_DEMO=y
+CONFIG_CMD_FPGA_LOADP=y
+CONFIG_CMD_FPGA_LOADBP=y
+CONFIG_CMD_FPGA_LOADFS=y
+CONFIG_CMD_FPGA_LOADMK=y
+CONFIG_CMD_FPGA_LOAD_SECURE=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPIO_READ=y
 CONFIG_CMD_PWM=y
@@ -196,6 +201,21 @@ CONFIG_SANDBOX_DMA=y
 CONFIG_FASTBOOT_FLASH=y
 CONFIG_FASTBOOT_FLASH_MMC_DEV=0
 CONFIG_ARM_FFA_TRANSPORT=y
+CONFIG_FPGA_ALTERA=y
+CONFIG_FPGA_STRATIX_II=y
+CONFIG_FPGA_STRATIX_V=y
+CONFIG_FPGA_ACEX1K=y
+CONFIG_FPGA_CYCLON2=y
+CONFIG_FPGA_LATTICE=y
+CONFIG_FPGA_XILINX=y
+CONFIG_FPGA_VERSALPL=y
+CONFIG_FPGA_SPARTAN2=y
+CONFIG_FPGA_SPARTAN3=y
+CONFIG_FPGA_VIRTEX2=y
+CONFIG_SYS_FPGA_CHECK_BUSY=y
+CONFIG_SYS_FPGA_CHECK_CTRLC=y
+CONFIG_DM_FPGA=y
+CONFIG_SANDBOX_FPGA=y
 CONFIG_GPIO_HOG=y
 CONFIG_DM_GPIO_LOOKUP_LABEL=y
 CONFIG_QCOM_PMIC_GPIO=y
-- 
2.48.1

