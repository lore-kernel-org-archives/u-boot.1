Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EC9AC35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 19:14:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9662F876E4;
	Mon, 18 Dec 2023 20:12:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="LLJDv9A6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18209876B2; Mon, 18 Dec 2023 20:12:37 +0100 (CET)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCE3E876E4
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 20:12:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-28b4a73d3c7so2160841a91.2
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 11:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1702926753; x=1703531553;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tkl2xjhNbU+/Z96JONqrrgk/K/xB/OqIVuXi1bWVXRA=;
 b=LLJDv9A6VGRkxTo18mqyLCmf+M75rLHjoeFzn9ZkRpUxfP1XbwEEx3hoaCgLL8OtZY
 6qq5sAyDgZ0SvWUphYa0hMfOdHpCRTP1M5JjpIqhjQ7k/xGIMRZ3mCtQT/ljS0x6LpXZ
 nP0isNY1YhG7die3Bp4HoO7ozO5VKGtLYGNb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702926753; x=1703531553;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tkl2xjhNbU+/Z96JONqrrgk/K/xB/OqIVuXi1bWVXRA=;
 b=C5f1zljbG7IrlNep6Jtv6FiMqES/IjGav9EU3vMFf5IpS9i8WZB4UhoRHRLJG+rYaV
 fn3AH7cOGNrD5jScqGYwus+rTtcpfymXmi9WAcU7IlCzp9bTRXNnw8XVOa0i7plAef7O
 xmq+9ZILZcejjd7DvE3ODwyjGsCrG7L5LH2vSWu13TKH7zmvOSSydNiyBI3tF7V65jkQ
 br0Nua3o8eFqTKymsAYF6l9rS7+xRc3h1lD+dqL6dSZaucL8VjW1wj3ocxSAHUKR2Xtt
 egZ8Ng8XWS3IxfqVpj0uczTc5PeO/qGSeYaqW0oDIxanBQQRhUnu8z+E0zgrg88l6iHi
 97WQ==
X-Gm-Message-State: AOJu0YyAwfCStBg2zcQaloeLx3cuW1CDmiNAm//UCKe4ofoXDqwVNYCQ
 qa/cD1ljKxjjVOBBSD2/xqeJaA==
X-Google-Smtp-Source: AGHT+IEM/e84JKNx6BHzPsqV/iDYSy1mxS9F01UbSBLq/uWAYN1cQ8dqwVKGEzlQ7caZVRneT/SKgQ==
X-Received: by 2002:a17:90b:2389:b0:28b:8460:cfcb with SMTP id
 mr9-20020a17090b238900b0028b8460cfcbmr1314551pjb.1.1702926753049; 
 Mon, 18 Dec 2023 11:12:33 -0800 (PST)
Received: from localhost.localdomain ([49.205.242.204])
 by smtp.gmail.com with ESMTPSA id
 pt10-20020a17090b3d0a00b0028afd8b1e0bsm2873941pjb.57.2023.12.18.11.12.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 11:12:32 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Anatolij Gustschin <agust@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Heiko Stuebner <heiko@sntech.de>
Cc: Robin Murphy <robin.murphy@arm.com>, u-boot@lists.denx.de,
 Da Xue <da.xue@libretech.co>, Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v2 17/17] configs: Enable HDMI Out for ROC-RK3328-CC
Date: Tue, 19 Dec 2023 00:41:14 +0530
Message-Id: <20231218191114.129329-18-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231218191114.129329-1-jagan@amarulasolutions.com>
References: <20231218191114.129329-1-jagan@amarulasolutions.com>
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

U-Boot 2024.01-rc4-00053-gb9f7cafdd9-dirty (Dec 11 2023 - 13:18:15 +0530)

Model: Firefly roc-rk3328-cc
DRAM:  1 GiB (effective 1022 MiB)
PMIC:  RK8050 (on=0x40, off=0x00)
Core:  236 devices, 26 uclasses, devicetree: separate
MMC:   mmc@ff500000: 1, mmc@ff520000: 0
Loading Environment from MMC... *** Warning - bad CRC, using default environment

tmdsclock = 148500000; chipversion = 1
In:    serial
Out:   vidconsole
Err:   vidconsole
Model: Firefly roc-rk3328-cc
Net:   eth0: ethernet@ff540000
Hit any key to stop autoboot:  0
=> dm tree
 Class     Index  Probed  Driver                Name
-----------------------------------------------------------
 root          0  [ + ]   root_driver           root_driver
 firmware      0  [   ]   psci                  |-- psci
 clk           0  [ + ]   fixed_clock           |-- xin24m
 syscon        0  [ + ]   rockchip_rk3328_grf   |-- syscon@ff100000
 serial        0  [ + ]   ns16550_serial        |-- serial@ff130000
 i2c           0  [ + ]   rockchip_rk3066_i2c   |-- i2c@ff160000
 pmic          0  [ + ]   rockchip_rk805        |   `-- pmic@18
 sysreset      0  [   ]   rk8xx_sysreset        |       |-- rk8xx_sysreset
 regulator     0  [ + ]   rk8xx_buck            |       |-- DCDC_REG1
 regulator     1  [ + ]   rk8xx_buck            |       |-- DCDC_REG2
 regulator     2  [ + ]   rk8xx_buck            |       |-- DCDC_REG3
 regulator     3  [ + ]   rk8xx_buck            |       |-- DCDC_REG4
 regulator     4  [ + ]   rk8xx_ldo             |       |-- LDO_REG1
 regulator     5  [ + ]   rk8xx_ldo             |       |-- LDO_REG2
 regulator     6  [ + ]   rk8xx_ldo             |       `-- LDO_REG3
 video         0  [ + ]   rk3328_vop            |-- vop@ff370000
 vidconsole    0  [ + ]   vidconsole0           |   `-- vop@ff370000.vidconsole0
 display       0  [ + ]   rk3328_hdmi_rockchip  |-- hdmi@ff3c0000
 phy           0  [ + ]   inno_hdmi_phy         |-- phy@ff430000
 clk           1  [ + ]   rockchip_rk3328_cru   |-- clock-controller@ff440000
 sysreset      1  [   ]   rockchip_sysreset     |   |-- sysreset
 reset         0  [ + ]   rockchip_reset        |   `-- reset

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- none

 configs/roc-cc-rk3328_defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/configs/roc-cc-rk3328_defconfig b/configs/roc-cc-rk3328_defconfig
index 4ac3c9403b..4eef9016dc 100644
--- a/configs/roc-cc-rk3328_defconfig
+++ b/configs/roc-cc-rk3328_defconfig
@@ -79,6 +79,7 @@ CONFIG_PHY_REALTEK=y
 CONFIG_PHY_GIGE=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_GMAC_ROCKCHIP=y
+CONFIG_PHY_ROCKCHIP_INNO_HDMI=y
 CONFIG_PHY_ROCKCHIP_INNO_USB2=y
 CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
@@ -114,6 +115,10 @@ CONFIG_USB_DWC3=y
 CONFIG_USB_DWC3_GENERIC=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_DWC2_OTG=y
+CONFIG_VIDEO=y
+CONFIG_DISPLAY=y
+CONFIG_VIDEO_ROCKCHIP=y
+CONFIG_DISPLAY_ROCKCHIP_HDMI=y
 CONFIG_SPL_TINY_MEMSET=y
 CONFIG_TPL_TINY_MEMSET=y
 CONFIG_ERRNO_STR=y
-- 
2.25.1

