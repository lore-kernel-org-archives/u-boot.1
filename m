Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11327CD3427
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 15:49:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3E6F84974;
	Tue,  5 May 2026 17:49:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nb9AgNPp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D66218499C; Tue,  5 May 2026 17:49:00 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E21D984974
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 17:48:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-488a14c31eeso41370555e9.0
 for <u-boot@lists.denx.de>; Tue, 05 May 2026 08:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777996138; x=1778600938; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=I2OmZXEoOxZI6gYtrg54DIJD+O+jiPDwykOSrl2KBQA=;
 b=nb9AgNPpfxB5XOR0xJ+BVvW1S9+hgPVUS2U8QYEsxV5vtHXqEm7fMMNlPXL/AGMQBQ
 TLWE1SEujHJCbX8u/eHRnQ1vQsQsrHRJvNstx25D6xBePxTW5fBRuUJPPOPp9i0QLXLh
 zrUTd+Y3u3cXWm5/xktxUZRk7zblpjq4O8YyHQKD4ocz3K+GEsRbS7s0EMzTxkg0pzgJ
 nQUto+H0aJZlYd7cu4V6ULtRCLPOodHu5fgNKeB7dJl5f36DtT+z9GR3vUCHAnzQl2BR
 ACWHUjeB8jcYIW8dYvPnfCGojgJCKhdrUkHoo5cU7osovHQpM4v126KvdiqbaLuo3giy
 SSjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777996138; x=1778600938;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=I2OmZXEoOxZI6gYtrg54DIJD+O+jiPDwykOSrl2KBQA=;
 b=tEfDX4UFqOJUvYzgZWPxpjRBVCFFkcHgHguYZXO1piYM3WpO/duE7KGWy8WA8KY6Fg
 vSilX0t/vK230TIBsHs+USNZEiU1eZCTp5hbJpIuR5chLowsAc7b+cEAM3ZFUzXqYdE4
 hWF4BlJGQLEMON21PZ4ADx3qkkOX3M1bVDoKyF4QPznLzc94RHD+M7zRWJ9fb3TQJNUH
 mff/b3RLJGtQDUImaXwFaBilq3gEq0tFAygMNVZVVsHfMzF/vOE2h1sZLzr1MlKD3ZY/
 8fQPw754LAxPjXnH4aoopZ8EaLpWKl6TDrFEOuGyqEmBsS4eMsk5WSSPpUGFltLLebHC
 VipA==
X-Gm-Message-State: AOJu0YxBMAB9KNe71wUg/VFvR8eZ/4AuhsZBYXjNeAR0azExUVrVjYLh
 /E0sIycEHqd/GDjsNURTSpS+UTxljepm64L7QmePCB56k/q8KhEh0/UgqLOjyx/c4m4=
X-Gm-Gg: AeBDiesmqgB8bwx/8iJFZREm2fxuDKkKpNv1J35aVILeN9V5Wi7rKemwVfKpkb+faRB
 8blrqzr1IRZ1DieBRIx33n2h0GsgI1NK8YPOpBIKFxRxz7Dqay1Wcw+PBq1KXjWK3mcOeBHxi92
 9t4+x7epA3TvhLvuoXGA8o1gSHfryRX8ed7exzbrUkaMSw3FlGutZqqSFrD08WWSVm9IXFartS5
 96mOYBagOfH6PsMCONgHAmnk7tLNWnsQI1u0UoQDFk/1SIXKbqtWQAdfgS2rWSUPBSvZH4WpSum
 T8cP6WGpiejs9BurU8i3TExZ4gzzeasOq90zm13oI3bnwHuUehTvlY2PxG6C0BF256iFax6Nocy
 rSyJTk2tAyM1d3k4sB3a7TF36OvgScY9LlVsAfnQA38mHgZc9fM6AN9goCx7mwZ4ohq760ny8L9
 9okiiQ3thzHNC2gG9dkgagrgB9yaDAWFnvPPrXU4RZ2wrlu13Mxh3SM64H5AGAA1QDIXwy/vuzp
 34NmtY=
X-Received: by 2002:a05:600c:c082:b0:489:1f3e:5f69 with SMTP id
 5b1f17b1804b1-48a98894fa7mr167537655e9.18.1777996138053; 
 Tue, 05 May 2026 08:48:58 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd86.dip0.t-ipconnect.de.
 [79.195.221.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48d182ee923sm20305955e9.27.2026.05.05.08.48.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 08:48:57 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Tue, 05 May 2026 17:48:46 +0200
Subject: [PATCH v6 6/6] configs: qcom: use mkmbn and stop building ELF
 files
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-b4-qcom-tooling-improvements-v6-6-a5fb673f4af6@linaro.org>
References: <20260505-b4-qcom-tooling-improvements-v6-0-a5fb673f4af6@linaro.org>
In-Reply-To: <20260505-b4-qcom-tooling-improvements-v6-0-a5fb673f4af6@linaro.org>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2999;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=nSd7DZadIEO+0FtRs7mFkwtAbxIVT07bvsetRt9ENkc=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsxfgrFKfTdEmh+3vn85YWf5BKf3u9ZMjr4gWcPDrlfBc
 31z1BPWjlIWBkEOBlkxRRbxE8ssm9ZettfYvuACzBxWJpAhDFycAjCRhkMM/7MEZKaURYTa5XJM
 Ua//cvednrxRa997tfrG3z2VPnOLFzH8lToTUyb5+5VozqqkuN64DVs7r+2Z+CjLzmnO/IIuDpH
 t+gA=
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

With mkmbn integrated we now no longer need CONFIG_REMAKE_ELF to then
run qtestsign and can instead just enable QCOM_GENERATE_MBN to have
mkmbn emit an MBN file directly.

Tested on qcs6490 and sm8550.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 configs/qcm6490_defconfig          | 2 +-
 configs/qcom_ipq9574_mmc_defconfig | 2 +-
 configs/qcom_qcs615_defconfig      | 2 +-
 configs/qcom_qcs8300_defconfig     | 2 +-
 configs/qcom_qcs9100_defconfig     | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/configs/qcm6490_defconfig b/configs/qcm6490_defconfig
index b088367f86c0..56ec771ba1e4 100644
--- a/configs/qcm6490_defconfig
+++ b/configs/qcm6490_defconfig
@@ -9,9 +9,9 @@
 CONFIG_ARM=y
 
 # Address where U-Boot will be loaded
 CONFIG_TEXT_BASE=0x9fc00000
-CONFIG_REMAKE_ELF=y
+CONFIG_QCOM_GENERATE_MBN=y
 
 CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs6490-rb3gen2"
 
 CONFIG_FASTBOOT_BUF_ADDR=0xd8800000
diff --git a/configs/qcom_ipq9574_mmc_defconfig b/configs/qcom_ipq9574_mmc_defconfig
index 6592d9de39da..98614f6196b2 100644
--- a/configs/qcom_ipq9574_mmc_defconfig
+++ b/configs/qcom_ipq9574_mmc_defconfig
@@ -11,9 +11,9 @@ CONFIG_DEFAULT_DEVICE_TREE="qcom/ipq9574-rdp433"
 CONFIG_SYS_LOAD_ADDR=0x50000000
 CONFIG_DEBUG_UART_BASE=0x78b1000
 CONFIG_DEBUG_UART_CLOCK=1843200
 CONFIG_DEBUG_UART=y
-CONFIG_REMAKE_ELF=y
+CONFIG_QCOM_GENERATE_MBN=y
 # CONFIG_EFI_LOADER is not set
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 # CONFIG_BOOTSTD is not set
diff --git a/configs/qcom_qcs615_defconfig b/configs/qcom_qcs615_defconfig
index 27666a8129d7..f4760703c94a 100644
--- a/configs/qcom_qcs615_defconfig
+++ b/configs/qcom_qcs615_defconfig
@@ -15,9 +15,9 @@ CONFIG_DEBUG_UART_MSM_GENI=y
 CONFIG_DEBUG_UART_CLOCK=7372800
 
 CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs615-ride"
 
-CONFIG_REMAKE_ELF=y
+CONFIG_QCOM_GENERATE_MBN=y
 
 # Address where U-Boot will be loaded
 CONFIG_TEXT_BASE=0x9fc00000
 
diff --git a/configs/qcom_qcs8300_defconfig b/configs/qcom_qcs8300_defconfig
index 5fffcddc16e9..8ff790f2889d 100644
--- a/configs/qcom_qcs8300_defconfig
+++ b/configs/qcom_qcs8300_defconfig
@@ -15,7 +15,7 @@ CONFIG_DEBUG_UART_MSM_GENI=y
 CONFIG_DEBUG_UART_CLOCK=14745600
 
 # Address where U-Boot will be loaded
 CONFIG_TEXT_BASE=0xaf000000
-CONFIG_REMAKE_ELF=y
+CONFIG_QCOM_GENERATE_MBN=y
 
 CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs8300-ride"
diff --git a/configs/qcom_qcs9100_defconfig b/configs/qcom_qcs9100_defconfig
index 082106157bbc..84b2b9a1bd1b 100644
--- a/configs/qcom_qcs9100_defconfig
+++ b/configs/qcom_qcs9100_defconfig
@@ -6,9 +6,9 @@
 #include "qcom_defconfig"
 
 # Address where U-Boot will be loaded
 CONFIG_TEXT_BASE=0xaf000000
-CONFIG_REMAKE_ELF=y
+CONFIG_QCOM_GENERATE_MBN=y
 CONFIG_FASTBOOT_BUF_ADDR=0xdb300000
 CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs9100-ride-r3"
 CONFIG_ENV_IS_IN_SCSI=y
 CONFIG_ENV_SCSI_PART_UUID="71cb9cd0-acf1-b6cb-ad91-be9572fe11a9"

-- 
2.53.0

