Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A0F6C47DA7
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 07:55:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3CC887A99;
	Wed, 17 Jan 2024 08:53:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="L62/Va9X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74C1B87AC9; Wed, 17 Jan 2024 08:53:27 +0100 (CET)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50F9A87A7A
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 08:53:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6db82a57c50so2005914b3a.2
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 23:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1705478002; x=1706082802;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lBKZLpkyqUzJWKpYTT64cJzwgLKzV6qe3fEWWFQTMuw=;
 b=L62/Va9XUDy6V1cosvclybrK0DnVryOUB3r4JWjOXQ7LWkEQB+YnDKlo8H0mmBgvZj
 3iTFZzpY9lnfEDmkG7TYstQYQsIILvBFrbF5z0RAowEUX/qutQ77OuiiVKeCU1ZMmh6u
 mgKzCwyxNyNFP5uI55PdlIvSmAIYSVAYLOsx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705478002; x=1706082802;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lBKZLpkyqUzJWKpYTT64cJzwgLKzV6qe3fEWWFQTMuw=;
 b=BtLFmaWxgtrPvcbX60tZXh5Pm5CAYguYDPbLu56HgLkaZEOoJ7SZlgS/J+ADJvuqcl
 C2FTinhiqdWhF3VU4a0gSQ8pyGoV5VCeREMx6xDrPn0M2Pj+K6d+bmb7wEfQRMTR9e35
 WTCqNqg3PWKXztZkQ4DH4SRXJF1Rq+tH24PwfYmWQTGIBUip7yFAGUk2Uoj17+n6xGbQ
 LL8CJo3UuSs2ASkSxW6zn4h+iEywRzD4720BTTdTmnNRyOauTqy47oBEgE2a8Va3Nj7U
 F6vhntizH8AVGh6Ik3dilfmBfBpYmHE4cVhZ59PRvGUj7ajjIZs1Ygux5wt2vigQrYdv
 t1zQ==
X-Gm-Message-State: AOJu0Yx8uDWWMF74VkDdr8uONbqhtXlkR/CoQ+iRidjs4y6d0Eyh2nmX
 IvBBzet/qFYY+EaGnKcpPG96QA0MnZksww==
X-Google-Smtp-Source: AGHT+IE9hABhdWBI+4RawAfzXDe1hySI5+ofCuoxnp7vie/m4i6K3iEegJUBVgkeLLYM280H+n+eZQ==
X-Received: by 2002:a05:6a20:438f:b0:19b:2d02:6966 with SMTP id
 i15-20020a056a20438f00b0019b2d026966mr2381335pzl.87.1705478002702; 
 Tue, 16 Jan 2024 23:53:22 -0800 (PST)
Received: from localhost.localdomain ([183.82.41.50])
 by smtp.gmail.com with ESMTPSA id
 e10-20020a170902784a00b001d5081be740sm10718624pln.62.2024.01.16.23.53.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 23:53:22 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Anatolij Gustschin <agust@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Heiko Stuebner <heiko@sntech.de>, Andy Yan <andyshrk@163.com>,
 Robin Murphy <robin.murphy@arm.com>
Cc: Da Xue <da.xue@libretech.co>, u-boot@lists.denx.de,
 Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v3 17/17] configs: Enable HDMI Out for ROC-RK3328-CC
Date: Wed, 17 Jan 2024 13:21:54 +0530
Message-Id: <20240117075154.58747-18-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240117075154.58747-1-jagan@amarulasolutions.com>
References: <20240117075154.58747-1-jagan@amarulasolutions.com>
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

U-Boot 2024.01-00901-g75d07e0e6e-dirty (Jan 17 2024 - 12:50:56 +0530)

Model: Firefly roc-rk3328-cc
DRAM:  4 GiB
PMIC:  RK8050 (on=0x40, off=0x00)
Core:  236 devices, 26 uclasses, devicetree: separate
MMC:   mmc@ff500000: 1, mmc@ff520000: 0
Loading Environment from MMC... *** Warning - bad CRC, using default environment

In:    serial,usbkbd
Out:   serial,vidconsole
Err:   serial,vidconsole
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
Changes for v3, v2:
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

