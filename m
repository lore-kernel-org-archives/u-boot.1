Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 600BEC54F61
	for <u-boot@archiver.kernel.org>; Tue, 19 Mar 2024 14:43:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B800D88084;
	Tue, 19 Mar 2024 15:43:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cxrKCvr2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93B5F8806F; Tue, 19 Mar 2024 15:43:12 +0100 (CET)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 754FD87F46
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 15:43:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-33ecb04e018so3119007f8f.1
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 07:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710859389; x=1711464189; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=76v3v8feO+EszFhgLfZe8zfaegkR0etjMGAjlARF/Ts=;
 b=cxrKCvr2odFGqUqZpYscFpEoITr/ZKjTHeF9337n0IFEfBLjlLr+Uu4mZvrO/1tFWJ
 StjfLbbCH1OhLo/rOP1xZ1XHF8PGbYtw5oXynubDWP9VpCV/YHt2x+HIk8xOmA6bZc8Y
 S6VhqDyDXZvkb/wFZzhnRPqoZ6hU0VdukNXkMHCzq/eBJW8AqDubozgdsvaLMx0IF5Az
 z55iiDKMQ4cLL5o/kWoq/Hq2GD30lC4EzPMiDiZDjl69bTHwZaHBiBDZ1+CzWmovhkzL
 j6XVeLv7vJkJukVZpajcOFFuajEbwxyk1hCMWMrtfTEgw7Mr36F46W6SJzQgMT7YG/Pg
 h47A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710859389; x=1711464189;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=76v3v8feO+EszFhgLfZe8zfaegkR0etjMGAjlARF/Ts=;
 b=LCkO3DDZF6rXA/jNElaVwrnL+04fGdnMq+Ke/DLaZi/IKJnYjYeeAYwyWMR7HxNYS+
 BNctze0wfpIitMhzLy5q0IU5wZDkHUi+y7XHP9Vhekl2wZSHEKQ8iDfQp5itmr+lTqvU
 eO3w6ey6YoH4HOFeTBq0MwmHIJecuHvQQK93vbfoLwyfI/1Xwz1Pd2hMe1cNSHHat3a/
 f60KWWOl+BzXzURT+Nwjx3aI/gz0GFAOBfWA/VyvXW3gBIzWfZf3QVq9eVUuPxLAHvTr
 JtUskbw1mZlGKbpmByLwS01NOekg6dGeC/9EIdtTLD5cAaBZnZOi2VqEoI+c/3AQnkE9
 a+3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWB1Q7nw322HDrGL5D7YIs1eFJogyTNDIubaSk9jlG32pRkiZ2f2vZ8BGcbXt3STD4tvSEpTc4v+ihjVwwcF9/Lw3vx+A==
X-Gm-Message-State: AOJu0YyqYcO99QkUKnuk8BY5aIbalvwMv3KitqEcta3JceEnOmQNDyMP
 pHaESCsN7rQMcCTGV/Ad9n/f6oUM9IQBo9IPCduRH/CDXXvXas+LtnRTOTC2Y0g=
X-Google-Smtp-Source: AGHT+IFABVGTOY+FuYj27DwwNk3xWrX+yDwZKiqleQR3dnbF8vZUpqbHLjqS9OXIR8G1DZaXmPR0/w==
X-Received: by 2002:adf:db44:0:b0:33e:9311:5fda with SMTP id
 f4-20020adfdb44000000b0033e93115fdamr9959183wrj.29.1710859388712; 
 Tue, 19 Mar 2024 07:43:08 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 by1-20020a056000098100b0033e18421618sm9029036wrb.17.2024.03.19.07.43.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Mar 2024 07:43:08 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 19 Mar 2024 15:43:02 +0100
Subject: [PATCH 3/4] dts: meson-g12a: Switch to using upstream DT
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240319-u-boot-of-upstream-v1-3-f82bc9fe69c0@linaro.org>
References: <20240319-u-boot-of-upstream-v1-0-f82bc9fe69c0@linaro.org>
In-Reply-To: <20240319-u-boot-of-upstream-v1-0-f82bc9fe69c0@linaro.org>
To: Tom Rini <trini@konsulko.com>, Vyacheslav Bocharov <adeep@lexina.in>, 
 Christian Hewitt <christianshewitt@gmail.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=13964;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=yIWp+hdimaT0PQTeWWNMn9xYdEakVzjHc0K7R5GurQ4=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBl+aR32nQUxN+zTnmqILMuGvh0ZydJb1nLuiF3DywT
 5l8agGGJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZfmkdwAKCRB33NvayMhJ0a/hEA
 C/yDWav2/81veFq6HPqRd94rwncCQl5x1ZYXExOH6HUTpbjJA9qZC/N8yR/p/fOP44XazzO7E7X2xq
 t2/wC5juTRzOXROBUmp9K+aczvcny+XgaSxfFLM51FyRg51cCUJ1iwI0K619I422Xojl5ZUMLqqDIe
 pC+foit088UfwEdJXduqX5trr+IOECPq8GxRlG82+JUIE26lqKaPVdhhg+yQ/N4xAD9yQC0Dl7q18E
 89MSSKC44uVxE6kQqhiyg1GELObeTcwc6kY543J3yct3mvDc1lw6wgM9W9EeVDn5jP2/ZMWd/a+kkP
 F1c7w/wSTrOLmtX68CT0pw3AozTcSBhmnFtB+5gtXF5ez7EfguWwXifsCXsFlrjDRDF8owKzXQPxbI
 diD0Cxg09bTC91ZjRFtXuvG2FKHOt+a+IxZmNrNhWlaGm/DAjWwxSeqTtkY7qDTAc1YP8EoRM9z9IF
 qyrToaM4b7eijsoL/B3dMQcB5gXr2TlFAMoCArt5bOlD+NNb+mBNm0bZlJFlGwd/g6M1CQ+PEGYqQo
 MllrbQe5YXdyRMW3f8g7yO7mq7oP76FLMKD17jsGHhA+ywEIeve1MFQiTgjIRCOFlJWWaoUQb6YlwD
 LGm3AyWRMOc+OfA8tDkSUQ213Gv6EZqA4IGfBrBxBF84Py0GbLltYnTH7a5A==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

Enable OF_UPSTREAM to use upstream DT and add amlogic/ prefix to the
DEFAULT_DEVICE_TREE. And thereby directly build DTB from dts/upstream/src/
including *-u-boot.dtsi files from arch/$(ARCH)/dts/ directory.

Cc: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm/mach-meson/Kconfig               | 1 +
 configs/bananapi-cm4-cm4io_defconfig      | 2 +-
 configs/bananapi-m2-pro_defconfig         | 2 +-
 configs/bananapi-m2s_defconfig            | 2 +-
 configs/bananapi-m5_defconfig             | 2 +-
 configs/beelink-gsking-x_defconfig        | 2 +-
 configs/beelink-gtking_defconfig          | 2 +-
 configs/beelink-gtkingpro_defconfig       | 2 +-
 configs/khadas-vim3_android_ab_defconfig  | 2 +-
 configs/khadas-vim3_android_defconfig     | 2 +-
 configs/khadas-vim3_defconfig             | 2 +-
 configs/khadas-vim3l_android_ab_defconfig | 2 +-
 configs/khadas-vim3l_android_defconfig    | 2 +-
 configs/khadas-vim3l_defconfig            | 2 +-
 configs/odroid-c4_defconfig               | 2 +-
 configs/odroid-go-ultra_defconfig         | 2 +-
 configs/odroid-hc4_defconfig              | 2 +-
 configs/odroid-n2_defconfig               | 2 +-
 configs/odroid-n2l_defconfig              | 2 +-
 configs/radxa-zero2_defconfig             | 2 +-
 configs/radxa-zero_defconfig              | 2 +-
 configs/sei510_defconfig                  | 2 +-
 configs/sei610_defconfig                  | 2 +-
 configs/u200_defconfig                    | 2 +-
 24 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-meson/Kconfig b/arch/arm/mach-meson/Kconfig
index 1d837ae0f3..7570f48e25 100644
--- a/arch/arm/mach-meson/Kconfig
+++ b/arch/arm/mach-meson/Kconfig
@@ -53,6 +53,7 @@ config MESON_AXG
 config MESON_G12A
 	bool "G12A"
 	select MESON64_COMMON
+	imply OF_UPSTREAM
 	help
 	  Select this if your SoC is an S905X/D2
 
diff --git a/configs/bananapi-cm4-cm4io_defconfig b/configs/bananapi-cm4-cm4io_defconfig
index 116147fc9a..cb78dabc13 100644
--- a/configs/bananapi-cm4-cm4io_defconfig
+++ b/configs/bananapi-cm4-cm4io_defconfig
@@ -6,7 +6,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-g12b-bananapi-cm4-cm4io"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-g12b-bananapi-cm4-cm4io"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_G12A=y
diff --git a/configs/bananapi-m2-pro_defconfig b/configs/bananapi-m2-pro_defconfig
index 755bccb4a7..196bc4077d 100644
--- a/configs/bananapi-m2-pro_defconfig
+++ b/configs/bananapi-m2-pro_defconfig
@@ -6,7 +6,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-sm1-bananapi-m2-pro"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-sm1-bananapi-m2-pro"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_G12A=y
diff --git a/configs/bananapi-m2s_defconfig b/configs/bananapi-m2s_defconfig
index af8daced62..7b137d5e1c 100644
--- a/configs/bananapi-m2s_defconfig
+++ b/configs/bananapi-m2s_defconfig
@@ -6,7 +6,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-g12b-a311d-bananapi-m2s"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-g12b-a311d-bananapi-m2s"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_G12A=y
diff --git a/configs/bananapi-m5_defconfig b/configs/bananapi-m5_defconfig
index 6de5d5fe7b..99ed7c9669 100644
--- a/configs/bananapi-m5_defconfig
+++ b/configs/bananapi-m5_defconfig
@@ -6,7 +6,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-sm1-bananapi-m5"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-sm1-bananapi-m5"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_G12A=y
diff --git a/configs/beelink-gsking-x_defconfig b/configs/beelink-gsking-x_defconfig
index 99e36e970a..c1e60ede4a 100644
--- a/configs/beelink-gsking-x_defconfig
+++ b/configs/beelink-gsking-x_defconfig
@@ -7,7 +7,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-g12b-gsking-x"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-g12b-gsking-x"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_G12A=y
diff --git a/configs/beelink-gtking_defconfig b/configs/beelink-gtking_defconfig
index 5c21d8eeab..0b644f0e34 100644
--- a/configs/beelink-gtking_defconfig
+++ b/configs/beelink-gtking_defconfig
@@ -7,7 +7,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-g12b-gtking"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-g12b-gtking"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_G12A=y
diff --git a/configs/beelink-gtkingpro_defconfig b/configs/beelink-gtkingpro_defconfig
index 37bb4cde79..a694617a96 100644
--- a/configs/beelink-gtkingpro_defconfig
+++ b/configs/beelink-gtkingpro_defconfig
@@ -7,7 +7,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-g12b-gtking-pro"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-g12b-gtking-pro"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_G12A=y
diff --git a/configs/khadas-vim3_android_ab_defconfig b/configs/khadas-vim3_android_ab_defconfig
index ee62fe36d4..37b8d6a925 100644
--- a/configs/khadas-vim3_android_ab_defconfig
+++ b/configs/khadas-vim3_android_ab_defconfig
@@ -10,7 +10,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x10000
 CONFIG_ENV_OFFSET=0x0
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-g12b-a311d-khadas-vim3"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-g12b-a311d-khadas-vim3"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_G12A=y
diff --git a/configs/khadas-vim3_android_defconfig b/configs/khadas-vim3_android_defconfig
index cecbe50617..55d59dd481 100644
--- a/configs/khadas-vim3_android_defconfig
+++ b/configs/khadas-vim3_android_defconfig
@@ -10,7 +10,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x10000
 CONFIG_ENV_OFFSET=0x0
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-g12b-a311d-khadas-vim3"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-g12b-a311d-khadas-vim3"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_G12A=y
diff --git a/configs/khadas-vim3_defconfig b/configs/khadas-vim3_defconfig
index 5df4b92143..32579b8ac3 100644
--- a/configs/khadas-vim3_defconfig
+++ b/configs/khadas-vim3_defconfig
@@ -7,7 +7,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-g12b-a311d-khadas-vim3"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-g12b-a311d-khadas-vim3"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_G12A=y
diff --git a/configs/khadas-vim3l_android_ab_defconfig b/configs/khadas-vim3l_android_ab_defconfig
index ec4e0dc72e..95e70275cc 100644
--- a/configs/khadas-vim3l_android_ab_defconfig
+++ b/configs/khadas-vim3l_android_ab_defconfig
@@ -10,7 +10,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x10000
 CONFIG_ENV_OFFSET=0x0
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-sm1-khadas-vim3l"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-sm1-khadas-vim3l"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_G12A=y
diff --git a/configs/khadas-vim3l_android_defconfig b/configs/khadas-vim3l_android_defconfig
index 206f8defca..6372d11989 100644
--- a/configs/khadas-vim3l_android_defconfig
+++ b/configs/khadas-vim3l_android_defconfig
@@ -10,7 +10,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x10000
 CONFIG_ENV_OFFSET=0x0
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-sm1-khadas-vim3l"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-sm1-khadas-vim3l"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_G12A=y
diff --git a/configs/khadas-vim3l_defconfig b/configs/khadas-vim3l_defconfig
index de8fdd83cc..b9f4690045 100644
--- a/configs/khadas-vim3l_defconfig
+++ b/configs/khadas-vim3l_defconfig
@@ -7,7 +7,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-sm1-khadas-vim3l"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-sm1-khadas-vim3l"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_G12A=y
diff --git a/configs/odroid-c4_defconfig b/configs/odroid-c4_defconfig
index fe1f861258..4ef1e68166 100644
--- a/configs/odroid-c4_defconfig
+++ b/configs/odroid-c4_defconfig
@@ -7,7 +7,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-sm1-odroid-c4"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-sm1-odroid-c4"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_G12A=y
diff --git a/configs/odroid-go-ultra_defconfig b/configs/odroid-go-ultra_defconfig
index 49d628b76a..06437fe3ae 100644
--- a/configs/odroid-go-ultra_defconfig
+++ b/configs/odroid-go-ultra_defconfig
@@ -7,7 +7,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-g12b-odroid-go-ultra"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-g12b-odroid-go-ultra"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_G12A=y
diff --git a/configs/odroid-hc4_defconfig b/configs/odroid-hc4_defconfig
index 7720ab5eb8..60233fb9ce 100644
--- a/configs/odroid-hc4_defconfig
+++ b/configs/odroid-hc4_defconfig
@@ -7,7 +7,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-sm1-odroid-hc4"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-sm1-odroid-hc4"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_G12A=y
diff --git a/configs/odroid-n2_defconfig b/configs/odroid-n2_defconfig
index 9694f04a66..a4cc766f84 100644
--- a/configs/odroid-n2_defconfig
+++ b/configs/odroid-n2_defconfig
@@ -7,7 +7,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-g12b-odroid-n2"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-g12b-odroid-n2"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_G12A=y
diff --git a/configs/odroid-n2l_defconfig b/configs/odroid-n2l_defconfig
index 673e0cffb2..3f657d1881 100644
--- a/configs/odroid-n2l_defconfig
+++ b/configs/odroid-n2l_defconfig
@@ -7,7 +7,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-g12b-odroid-n2l"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-g12b-odroid-n2l"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_G12A=y
diff --git a/configs/radxa-zero2_defconfig b/configs/radxa-zero2_defconfig
index b795681b3f..92e0a8833c 100644
--- a/configs/radxa-zero2_defconfig
+++ b/configs/radxa-zero2_defconfig
@@ -6,7 +6,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-g12b-radxa-zero2"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-g12b-radxa-zero2"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_G12A=y
diff --git a/configs/radxa-zero_defconfig b/configs/radxa-zero_defconfig
index 103ff8a321..5179c58dad 100644
--- a/configs/radxa-zero_defconfig
+++ b/configs/radxa-zero_defconfig
@@ -6,7 +6,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-g12a-radxa-zero"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-g12a-radxa-zero"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_G12A=y
diff --git a/configs/sei510_defconfig b/configs/sei510_defconfig
index c4a49fbd6f..791979e744 100644
--- a/configs/sei510_defconfig
+++ b/configs/sei510_defconfig
@@ -10,7 +10,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x10000
 CONFIG_ENV_OFFSET=0xFFFF0000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-g12a-sei510"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-g12a-sei510"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_G12A=y
diff --git a/configs/sei610_defconfig b/configs/sei610_defconfig
index ae254c62f2..ce5374319b 100644
--- a/configs/sei610_defconfig
+++ b/configs/sei610_defconfig
@@ -10,7 +10,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x10000
 CONFIG_ENV_OFFSET=0xFFFF0000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-sm1-sei610"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-sm1-sei610"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_G12A=y
diff --git a/configs/u200_defconfig b/configs/u200_defconfig
index 21c90e7678..879ae0defa 100644
--- a/configs/u200_defconfig
+++ b/configs/u200_defconfig
@@ -6,7 +6,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-g12a-u200"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-g12a-u200"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_G12A=y

-- 
2.34.1

