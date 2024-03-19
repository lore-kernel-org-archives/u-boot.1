Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFC00C54F7E
	for <u-boot@archiver.kernel.org>; Tue, 19 Mar 2024 14:43:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 837A388048;
	Tue, 19 Mar 2024 15:43:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sGbLPcL4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89B3D87F6F; Tue, 19 Mar 2024 15:43:09 +0100 (CET)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF32587F13
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 15:43:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-33edbc5932bso2117360f8f.3
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 07:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710859386; x=1711464186; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RCEjeORdZrGPyygMQQ7rEIOwx/u2XgJDOvlmELopfjs=;
 b=sGbLPcL4BeJ1z/RDbDFLMZhUPqBsJRd8a9gb1oU/XIxZgmWbdoSLvJEp255FBC/4VB
 WLmhsCB1HQ/kAsjS612zJOz/BNBQLLWe7900P7DEMiRTQ6hFiR2zvTu1oUmH3EKmM5HR
 sGfUL8E8vPFMO9aZ00h53kxyMK+AXFxl1JnRB1Cc4tRZk6fc16rdDcn/yhOjvhjtsPCL
 tHOW6HUUSHQiuZT4N57lmfFDhtml9VcRwrEGQGnM7MQBH9zBhfHT95SL7U0x6fadeDEo
 7Xk+YB+XoUceeQRtJexWzwyIHpIJvSrRI9bkbVFK018MmIr34YHjzHk9E5vNQbApyYyf
 HZQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710859386; x=1711464186;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RCEjeORdZrGPyygMQQ7rEIOwx/u2XgJDOvlmELopfjs=;
 b=C1ud8yEXuJdJnzl0+WuEPKIH13+r3KVU2ONWsaZ4hcXvp7J93nJX/6BzlcBNDrtOHL
 5nJm6agSCQHGVBy121P2p7P4T76LHHSQpjR2CvwRdatLOUrhBtI0xhLSzP61Qkd1/RIi
 MNbbuVqa2yqXMLbK0rOc71W3LKw2YEDLCmGJMjbkpxI7yOsgDMi4YpPv/KXhlhCTxHh8
 CuHmyLJ263HPFbaU4nmESLeakQscs6a4/HgCTECRU1tQqn2TLKGLxqYz7Z6ZB6Fn0iRt
 6krg+pqo6/chx6jgYJvn3bY5MUaBZW5abttUEoHLLdEU5a7AY4TmhYfAx8lDMFtxiPsH
 i7ug==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHB1tjvVdF5iJWzVL1KK0hKlvw9lMqlLXykXpLJsDDZj9JEZc+Rf8C/sJMfufP2f49eJW3no3ZR+ig8eYv20JhT0XGHA==
X-Gm-Message-State: AOJu0YzH08vUGkUA6TLGsyLCjvzaGq75km47/7qRg1//8FrF9xbosH5X
 pQFOrl7sm45CzTZ56nq3uXe4HVCNYrYz2XoEadfhUBvfqKlAXIOASZarQn22ih8=
X-Google-Smtp-Source: AGHT+IGi3WdwktqxPA6R9AVH8RATCZXAPtMHOXLPNCcUEYhnJ//LGoDwpm3ZybxxMq+54YxXEzdO/A==
X-Received: by 2002:a5d:4147:0:b0:33e:8c7e:608c with SMTP id
 c7-20020a5d4147000000b0033e8c7e608cmr10613104wrq.13.1710859386221; 
 Tue, 19 Mar 2024 07:43:06 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 by1-20020a056000098100b0033e18421618sm9029036wrb.17.2024.03.19.07.43.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Mar 2024 07:43:05 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 19 Mar 2024 15:43:00 +0100
Subject: [PATCH 1/4] dts: meson: Switch GXL, GXM & AXG to using upstream DT
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240319-u-boot-of-upstream-v1-1-f82bc9fe69c0@linaro.org>
References: <20240319-u-boot-of-upstream-v1-0-f82bc9fe69c0@linaro.org>
In-Reply-To: <20240319-u-boot-of-upstream-v1-0-f82bc9fe69c0@linaro.org>
To: Tom Rini <trini@konsulko.com>, Vyacheslav Bocharov <adeep@lexina.in>, 
 Christian Hewitt <christianshewitt@gmail.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=8419;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=GEYqtt9Thu6VH8wcbXkftdQtC59Uu8TMsWvsstEdmYc=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBl+aR2eA72ZQ6R5Nc1uH9iYmvEbCLBuSr1cNVwJF5s
 fcEydXuJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZfmkdgAKCRB33NvayMhJ0fvuD/
 46VmLk64gm1tF6WjoOy1CN2rHmnHSGTjnYKJewVQ/R6eLjPsDphajeoERjVuvL+nJl7Y1RHtBYh4Ih
 wiPvx33WNDXyjVJtVAjsczKEUP0I/g9iT7HDwEEcs6IQACHIKJ2FmCeHFA07ob/XcLlgPsDi7hmdND
 3Q3HrzK487xt3YahdTo/fSNYfQXMhIAWCM1td2j7tRgOZUsjHsKJemfolyfJGc2yKfzl1jCbQVt72A
 Gcjzfer2XudUpUAJQqTgAwCekB7p+3+XRB8+9oCjjSVlsFhQM44zQiM4lcyqDeda2dK8bcziCNgfWx
 pStmeKstM4bC0VbHCOf4bGCGAlXxeZ0O71Wq+waExDC4q8CxOvM4nmjppPh1WMS6k7fhk0DBsu/Q2B
 eID6g7SytRbHY9DT3mRlr+ZUrygQ+Z+V8yJlUe9E6nx1a9By807Mc8Itxp1NsNlp7si5ZOYmN90h9X
 MQYXar4IUZ2Apw2hu1/vc2Y7XrW9VCF5huRA6iJktPiwPlniQYOQON1E4AqxOsBVFcPneUMKWLvKeQ
 IKtrlqRd0K14Fgb87lP+0qY+7YUHSz6tcyTA2IL/Mr5KX0DW43QN6N1QXpPrjPr5nHE+iHeCUgdhJd
 f1q3eIQBItZt8pBxUXAN/lFK8DpCCMDamBYPNNDbIJ2CfywhkFLtmZUpED2A==
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
 arch/arm/mach-meson/Kconfig            | 3 +++
 configs/beelink-gt1-ultimate_defconfig | 2 +-
 configs/jethub_j100_defconfig          | 2 +-
 configs/jethub_j80_defconfig           | 2 +-
 configs/khadas-vim2_defconfig          | 2 +-
 configs/khadas-vim_defconfig           | 2 +-
 configs/libretech-ac_defconfig         | 2 +-
 configs/libretech-cc_defconfig         | 2 +-
 configs/libretech-cc_v2_defconfig      | 2 +-
 configs/libretech-s905d-pc_defconfig   | 2 +-
 configs/libretech-s912-pc_defconfig    | 2 +-
 configs/p212_defconfig                 | 2 +-
 configs/s400_defconfig                 | 2 +-
 configs/wetek-core2_defconfig          | 2 +-
 14 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-meson/Kconfig b/arch/arm/mach-meson/Kconfig
index 95e7b019ce..1d837ae0f3 100644
--- a/arch/arm/mach-meson/Kconfig
+++ b/arch/arm/mach-meson/Kconfig
@@ -32,18 +32,21 @@ config MESON_GXBB
 config MESON_GXL
 	bool "GXL"
 	select MESON_GX
+	imply OF_UPSTREAM
 	help
 	  Select this if your SoC is an S905X/D or S805X
 
 config MESON_GXM
 	bool "GXM"
 	select MESON_GX
+	imply OF_UPSTREAM
 	help
 	  Select this if your SoC is an S912
 
 config MESON_AXG
 	bool "AXG"
 	select MESON64_COMMON
+	imply OF_UPSTREAM
 	help
 	  Select this if your SoC is an A113X/D
 
diff --git a/configs/beelink-gt1-ultimate_defconfig b/configs/beelink-gt1-ultimate_defconfig
index 00fdad8544..0e30e13c82 100644
--- a/configs/beelink-gt1-ultimate_defconfig
+++ b/configs/beelink-gt1-ultimate_defconfig
@@ -6,7 +6,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-gxm-gt1-ultimate"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-gxm-gt1-ultimate"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_GXM=y
diff --git a/configs/jethub_j100_defconfig b/configs/jethub_j100_defconfig
index 863245430a..9de6b4b44d 100644
--- a/configs/jethub_j100_defconfig
+++ b/configs/jethub_j100_defconfig
@@ -8,7 +8,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-axg-jethome-jethub-j100"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-axg-jethome-jethub-j100"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_AXG=y
diff --git a/configs/jethub_j80_defconfig b/configs/jethub_j80_defconfig
index ca0808f712..85306872f9 100644
--- a/configs/jethub_j80_defconfig
+++ b/configs/jethub_j80_defconfig
@@ -8,7 +8,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-gxl-s905w-jethome-jethub-j80"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-gxl-s905w-jethome-jethub-j80"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_GXL=y
diff --git a/configs/khadas-vim2_defconfig b/configs/khadas-vim2_defconfig
index 59ef33723e..50f8b30650 100644
--- a/configs/khadas-vim2_defconfig
+++ b/configs/khadas-vim2_defconfig
@@ -6,7 +6,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-gxm-khadas-vim2"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-gxm-khadas-vim2"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_GXM=y
diff --git a/configs/khadas-vim_defconfig b/configs/khadas-vim_defconfig
index 5ed7c1a408..ac00e8975e 100644
--- a/configs/khadas-vim_defconfig
+++ b/configs/khadas-vim_defconfig
@@ -6,7 +6,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-gxl-s905x-khadas-vim"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-gxl-s905x-khadas-vim"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_GXL=y
diff --git a/configs/libretech-ac_defconfig b/configs/libretech-ac_defconfig
index f0ab19580c..6ad0457002 100644
--- a/configs/libretech-ac_defconfig
+++ b/configs/libretech-ac_defconfig
@@ -9,7 +9,7 @@ CONFIG_ENV_SIZE=0x2000
 CONFIG_ENV_OFFSET=0xFFFF0000
 CONFIG_ENV_SECT_SIZE=0x10000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-gxl-s805x-libretech-ac"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-gxl-s805x-libretech-ac"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_GXL=y
diff --git a/configs/libretech-cc_defconfig b/configs/libretech-cc_defconfig
index bb1a37a0cd..beb919ca6e 100644
--- a/configs/libretech-cc_defconfig
+++ b/configs/libretech-cc_defconfig
@@ -6,7 +6,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-gxl-s905x-libretech-cc"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-gxl-s905x-libretech-cc"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_GXL=y
diff --git a/configs/libretech-cc_v2_defconfig b/configs/libretech-cc_v2_defconfig
index 8949e240c9..784a269fd5 100644
--- a/configs/libretech-cc_v2_defconfig
+++ b/configs/libretech-cc_v2_defconfig
@@ -8,7 +8,7 @@ CONFIG_ENV_SIZE=0x2000
 CONFIG_ENV_OFFSET=0xFFFF0000
 CONFIG_ENV_SECT_SIZE=0x10000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-gxl-s905x-libretech-cc-v2"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-gxl-s905x-libretech-cc-v2"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_GXL=y
diff --git a/configs/libretech-s905d-pc_defconfig b/configs/libretech-s905d-pc_defconfig
index a5dc3115fc..0adc0afdf3 100644
--- a/configs/libretech-s905d-pc_defconfig
+++ b/configs/libretech-s905d-pc_defconfig
@@ -9,7 +9,7 @@ CONFIG_ENV_SIZE=0x10000
 CONFIG_ENV_OFFSET=0xFFFF0000
 CONFIG_ENV_SECT_SIZE=0x10000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-gxl-s905d-libretech-pc"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-gxl-s905d-libretech-pc"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_GXL=y
diff --git a/configs/libretech-s912-pc_defconfig b/configs/libretech-s912-pc_defconfig
index 68f462eeff..cbce0cf400 100644
--- a/configs/libretech-s912-pc_defconfig
+++ b/configs/libretech-s912-pc_defconfig
@@ -8,7 +8,7 @@ CONFIG_ENV_SIZE=0x10000
 CONFIG_ENV_OFFSET=0xFFFF0000
 CONFIG_ENV_SECT_SIZE=0x10000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-gxm-s912-libretech-pc"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-gxm-s912-libretech-pc"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_GXM=y
diff --git a/configs/p212_defconfig b/configs/p212_defconfig
index 6b73607d64..9cf22ca4db 100644
--- a/configs/p212_defconfig
+++ b/configs/p212_defconfig
@@ -6,7 +6,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-gxl-s905x-p212"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-gxl-s905x-p212"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_GXL=y
diff --git a/configs/s400_defconfig b/configs/s400_defconfig
index 8e22c95f88..d75d296fa0 100644
--- a/configs/s400_defconfig
+++ b/configs/s400_defconfig
@@ -6,7 +6,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-axg-s400"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-axg-s400"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_AXG=y
diff --git a/configs/wetek-core2_defconfig b/configs/wetek-core2_defconfig
index 01ffb8bbd7..c4b126c2b7 100644
--- a/configs/wetek-core2_defconfig
+++ b/configs/wetek-core2_defconfig
@@ -6,7 +6,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-gxm-wetek-core2"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-gxm-wetek-core2"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_GXM=y

-- 
2.34.1

