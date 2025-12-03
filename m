Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17853D12D6D
	for <u-boot@archiver.kernel.org>; Wed,  3 Dec 2025 14:46:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8177A83FAC;
	Wed,  3 Dec 2025 15:46:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MWmhrzG6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7341783F64; Wed,  3 Dec 2025 10:32:04 +0100 (CET)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6073983F5B
 for <u-boot@lists.denx.de>; Wed,  3 Dec 2025 10:32:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-42e2ddb8a13so1620188f8f.0
 for <u-boot@lists.denx.de>; Wed, 03 Dec 2025 01:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764754321; x=1765359121;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kop6KpRC0EIIKAbMeYUx4AHWMx0VHOM7/KNYaFj6of4=;
 b=MWmhrzG6fRg1KUK6+RyIyXn2g3Hsp+UYpNMPBIcWn9Mn0eBzep1MwERFB/OeBCuFHs
 y9TyOM9pCdMCKYrJ4mhlsVO/nKCUG5vRvfMo33Fdv8BAcL5bRdh4VpGa79Y2UwhfTEuN
 U94cYzzUDaaJTNYCgdAqVr5x5rOdD8etCZZFtA94gJTG71LKzyR+o3zUHqPTh5zJ4q+u
 6xaSp6H8Gs9wHruMk4HUxj+q0RRa2xfaXydkPtDURU1RlLY3NMdj7CL3tMGJpfNZ9W+Q
 HOav3BYCM0XeXQSN07NgAJmo5oipfrqckN94vFRBnBCHF+JzCIRKWXbVlUTGfB6yzftW
 rQGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764754321; x=1765359121;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kop6KpRC0EIIKAbMeYUx4AHWMx0VHOM7/KNYaFj6of4=;
 b=RWuH5Cc0s0ptuxDVEZxZ174uI59jkVRJ+/Oiplzg60yZjGCAIGydq87gcXb6KGOluP
 9+ad/ZDQAJKxpDoxxxKq5ZUIGs+JbJsItyDgZ/BnToj/oW0vZxq4CEEJf8c9pyOsSnvd
 HUf2lzeMezxhU0pAw+qJ579WiQZ1q0hxtHUgwo/F8RJUunzYf6i++RwdS/Xk8gA47S67
 QBPI+zrXIRIJZ7IO6UsPztzRFul5yweRUNw05TouVDDDvcX1Ca5LXpE8+kmOLoKXDmRi
 l41saunmbkDv17auwTB+xKDV7Zh0ddEK5pm/9+SzUnwOookVBxZkeIwEHLgvVqvhCvVa
 6arA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhlSKG7MvGgRPF4US11/yOuhHKQFTdBJgSWMpneV5lcyVEyFefACzIxTC3KOqAOQaTZXI1ndY=@lists.denx.de
X-Gm-Message-State: AOJu0Yy6IIEDJtAU3e/L+2XFcNmKxS+tPMMUQVwEY9vP9d/H2JJsUewc
 5afayYnuvJguNpp4uMAq4EsCwEkPRHigDKK/FkWistfqLMOetgjJBUciK6nfpZ+tSqk=
X-Gm-Gg: ASbGncvDRYSo+3arlL322vo+kQdjyfDwxP9cySEA19csDvdS7KGko0EGVGtOvTZ9vh5
 u0KvgB28uoux5Bh/qWRAZXPNWEob5BgPOB4RwEdlezhebpOKswCSA8R98Wc2EFAFsMokxEbaMlu
 IvnrlZKCMX9CuMhkcWG/av6y/zpcAq5rOUhPFkLsdwln8nL1YLALL9yFunwq8Zkkdu7yB2VlGlU
 CBB1igbJjxcVkDvW68+HLnVUuf6HcCghphdH7ey+2Pykyd4yw93WoybqD1krlZE4Yl1I2UA7D9Y
 o7OWoDlPqtKUeZQlLMGW4gCuTdEcQTn+5szRDddiphkrWGCMIlnEATk3htSG/x+dm8esymNp23z
 Rp+aN7/129qhwu+MK63/uzCZNqOK6wf87pFx+CBka5JaJi06bwAjbLhb4GVrVoSFzkdaJ0p//8V
 tgkg/WcpMY2DlaWH30V1f7VWmVAO1/uqvaROdns7dR+YREovXXwBSjtFcQ2E2UjZgnKOxYP4B02
 czPCcE=
X-Google-Smtp-Source: AGHT+IHODcg0LUEnncCRsBoXLwb4VdgnvAcOWuaKyWCbsT3x+XqGXCIsDLVJKbHkzDaf4CQCi+9Qig==
X-Received: by 2002:a05:6000:2004:b0:42b:3e60:18c7 with SMTP id
 ffacd0b85a97d-42f731a52f0mr1560240f8f.36.1764754321366; 
 Wed, 03 Dec 2025 01:32:01 -0800 (PST)
Received: from [192.168.1.64]
 (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net.
 [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42e1ca1a396sm37964430f8f.22.2025.12.03.01.31.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Dec 2025 01:32:00 -0800 (PST)
From: Julien Stephan <jstephan@baylibre.com>
Subject: [PATCH 0/2] Add support for MT8188
Date: Wed, 03 Dec 2025 10:31:51 +0100
Message-Id: <20251203-add-mt8188-support-v1-0-9a06ebb97734@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIcDMGkC/x3MQQ5AMBBA0avIrE3SKaJxFbGgHcwCTYtIpHfXW
 L7F/y9EDsIRuuKFwLdEOfYMKguw67gvjOKyQSvdkFaEo3O4nYaMwXh5f4QTp4oqZ1s9q5ohhz7
 wLM8/7YeUPgCOBRdkAAAA
X-Change-ID: 20251201-add-mt8188-support-b313dc72f04e
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Stefan Roese <stefan.roese@mailbox.org>, Greg Malysa <malysagreg@gmail.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Peng Fan <peng.fan@nxp.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Simon Glass <sjg@chromium.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, Yao Zi <ziyao@disroot.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Sumit Garg <sumit.garg@kernel.org>, Julien Masson <jmasson@baylibre.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Sam Shih <sam.shih@mediatek.com>, David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.2
X-Mailman-Approved-At: Wed, 03 Dec 2025 15:46:17 +0100
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

Hi all,

The MediaTek MT8188 is a ARM64-based SoC with a dual-core Cortex-A78
cluster and a six-core Cortex-A55 cluster. It includes UART, SPI,
USB3.0 dual role, SD and MMC cards, UFS, PWM, I2C, I2S, S/PDIF, and
several LPDDR3 and LPDDR4 options.

This series adds basic support for MT8188.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
Julien Masson (2):
      arm: mediatek: add support for MediaTek MT8188 SoC
      clk: mediatek: add MT8188 clock driver

 MAINTAINERS                            |    1 +
 arch/arm/dts/mt8188-u-boot.dtsi        |   10 +
 arch/arm/mach-mediatek/Kconfig         |   11 +-
 arch/arm/mach-mediatek/Makefile        |    1 +
 arch/arm/mach-mediatek/mt8188/Makefile |    3 +
 arch/arm/mach-mediatek/mt8188/init.c   |   69 ++
 drivers/clk/mediatek/Makefile          |    1 +
 drivers/clk/mediatek/clk-mt8188.c      | 1840 ++++++++++++++++++++++++++++++++
 drivers/watchdog/mtk_wdt.c             |    1 +
 9 files changed, 1936 insertions(+), 1 deletion(-)
---
base-commit: c5e6d2ab7eba68cbfb600cdc131c0c375ced2ec9
change-id: 20251201-add-mt8188-support-b313dc72f04e

Best regards,
-- 
Julien Stephan <jstephan@baylibre.com>

