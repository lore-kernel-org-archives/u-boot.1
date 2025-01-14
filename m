Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A52A2C02183
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 05:26:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2498806D3;
	Tue, 14 Jan 2025 06:26:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A/dcYwpR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C7EF806C6; Tue, 14 Jan 2025 06:26:29 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4F7B8067D
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 06:26:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=anarsoul@gmail.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-216728b1836so88162905ad.0
 for <u-boot@lists.denx.de>; Mon, 13 Jan 2025 21:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736832385; x=1737437185; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/mF2gvPXlMDa2hdXSS+0girgx6VkU3augbdVKXGrIK4=;
 b=A/dcYwpRhvA417+tebd4KaLKcmNR08hv+SFanWb1GTSszB1xlfMEFumumtsNEpZeTl
 DmX1lnLYWQjbbD+gDdKZvTHjbjCr0ibQ9JDFydheWSPhfmd0nMfWHEMciN5MTlpbxesR
 9QRb0r1VmYIzgkYk4tZ2Ceb+qchEtmj6cDnhoBV890AxPTHQutTL0hTlkOEFYZRtGYxp
 yZ5N7RfaBove+n7pp6r2npyIE1h8J8oMgp1Ph8/Tx5vSvDhc5vLKJhvlGYDzFKP7bVz3
 u5MXZsoAvRkiEX2X+nefy8IwOicwpd6lJWjCPOiPI29PTgxzJ+e5jO8uM2mlsNK6lTvq
 +YsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736832385; x=1737437185;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/mF2gvPXlMDa2hdXSS+0girgx6VkU3augbdVKXGrIK4=;
 b=A6i+ypUPOyyzFbVpQEzZVnJfc+VndsBFcAO6d05Jy2TLc3zrKHJuboBr1V/x9l/fJQ
 bY446Rtx1jYPnUcaunjlmcBa+qiQMeUoQ5vFj0YlTCH/PIJTRSpbSKiqazp1VXq8o7rI
 TK0FLI5LOR65+47IBhh1a42qmCVS/y1TJ4r1x8nSvJW0WprxpnLpwBOKxb7GCHJ/9aq4
 dxQ57LGsZXjtlHQ43DdB8hQ5/rGuFp+xgVS/92vzZTDN9I74LAQbZrmb9Pa4CwXXW1Eg
 HQkfWxZsVjzfKqLL7jP9xU1G6UMdp3nNJv2iINE7oodJBoP5Pwd9m0Cwxx4XEMaelnGv
 RbXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhu+r/CYHIg4yH0i7I59uyYlqEr4dYjLHphz7A+xXPafuRydjVbXPVzqC+c8Y0nU7s4ey1CSg=@lists.denx.de
X-Gm-Message-State: AOJu0YyqLCaaSiPqf9J5+jKEjEjPQxQvDhEK5ot+1aBxHQfg2dCBSw8i
 4UAKavH7tpJTqxFcZXYq1f5kLGI+VXl2p0Nsri8DWOBeWeM5cvuo
X-Gm-Gg: ASbGncto83uv546cf5dzFfxTRmAwoWqeXRrmizf8puca2xle8CJmEJpnvJ+hmIgNlft
 WtcnLdulKofskCCOKFltEUEQMCrNxMKbx7w84lCwOwKvIfs18REhgNd364h36gKb+ALKWwxwBfI
 i8oYm1/RbZoIYdbGlY6cOBUz6HgxoBae0S/e4rwYrMYmr6p77dHym0aL+Lh0A02QB+QvH7Vjo4W
 S8zz21dI38PreZ6qEM0YLcUz6b03MZ4TgAF+ORK4GDL5Y5S1w==
X-Google-Smtp-Source: AGHT+IH8JkgwCiO7Rya6WaJX7DJpYC+bAn1jCgG2VIg7z2mO9DmfHPC79e44XG/ulrrApk0fT+V4fA==
X-Received: by 2002:a05:6a00:230a:b0:725:ef4b:de30 with SMTP id
 d2e1a72fcca58-72d21f4b537mr32944836b3a.14.1736832385248; 
 Mon, 13 Jan 2025 21:26:25 -0800 (PST)
Received: from anarsoul-xps15.lan ([2604:3d08:7780:1ca9::398])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72d40548922sm6713357b3a.30.2025.01.13.21.26.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jan 2025 21:26:24 -0800 (PST)
From: Vasily Khoruzhick <anarsoul@gmail.com>
To: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Anatolij Gustschin <agust@denx.de>,
 Dragan Simic <dsimic@manjaro.org>, Chen-Yu Tsai <wens@csie.org>,
 Christopher Obbard <chris.obbard@collabora.com>,
 Jagan Teki <jagan@edgeble.ai>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH 3/3] rockchip: rock64-rk3328_defconfig: enable HDMI output and
 USB keyboard
Date: Mon, 13 Jan 2025 21:24:21 -0800
Message-ID: <20250114052548.763611-3-anarsoul@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250114052548.763611-1-anarsoul@gmail.com>
References: <20250114052548.763611-1-anarsoul@gmail.com>
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

Enable HDMI output and USB keyboard on Rock64 board

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 configs/rock64-rk3328_defconfig | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/configs/rock64-rk3328_defconfig b/configs/rock64-rk3328_defconfig
index 6d00b52e62f..ae3512625cf 100644
--- a/configs/rock64-rk3328_defconfig
+++ b/configs/rock64-rk3328_defconfig
@@ -21,7 +21,9 @@ CONFIG_FIT_VERBOSE=y
 CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
+CONFIG_USE_PREBOOT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3328-rock64.dtb"
+# CONFIG_SYS_DEVICE_NULLDEV is not set
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
@@ -72,6 +74,7 @@ CONFIG_DM_ETH_PHY=y
 CONFIG_PHY_GIGE=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_GMAC_ROCKCHIP=y
+CONFIG_PHY_ROCKCHIP_INNO_HDMI=y
 CONFIG_PHY_ROCKCHIP_INNO_USB2=y
 CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
@@ -80,6 +83,8 @@ CONFIG_PMIC_RK8XX=y
 CONFIG_SPL_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_SPL_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_SPL_DM_REGULATOR_GPIO=y
 CONFIG_REGULATOR_RK8XX=y
 CONFIG_PWM_ROCKCHIP=y
 CONFIG_RAM=y
@@ -104,6 +109,11 @@ CONFIG_USB_OHCI_GENERIC=y
 CONFIG_USB_DWC2=y
 CONFIG_USB_DWC3=y
 CONFIG_USB_DWC3_GENERIC=y
+CONFIG_USB_KEYBOARD=y
+CONFIG_VIDEO=y
+CONFIG_DISPLAY=y
+CONFIG_VIDEO_ROCKCHIP=y
+CONFIG_DISPLAY_ROCKCHIP_HDMI=y
 CONFIG_SPL_TINY_MEMSET=y
 CONFIG_TPL_TINY_MEMSET=y
 CONFIG_ERRNO_STR=y
-- 
2.47.1

