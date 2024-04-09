Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F378BC67861
	for <u-boot@archiver.kernel.org>; Tue,  9 Apr 2024 14:49:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3A51879A0;
	Tue,  9 Apr 2024 16:49:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="E6NXNR83";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F2E1871A5; Tue,  9 Apr 2024 16:49:31 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 751CC8811D
 for <u-boot@lists.denx.de>; Tue,  9 Apr 2024 16:49:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a51beae2f13so357208666b.1
 for <u-boot@lists.denx.de>; Tue, 09 Apr 2024 07:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712674169; x=1713278969; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zKs4JT+m2KCkJOqgG6C5kt9r4QRZhsfdeXlX04Y/UsA=;
 b=E6NXNR834buWx4I7HGDhq9exWcm4+Fh70Q3o5a4RiH3Sj1qUoeZ5MkXXxsWtX9v0Dh
 rOk25c/x1RoW3atV3q0gW9pI9tNh8DhPB17HdrQnWIxFbJQXZ0iA5YhU6afNrUhdJMeU
 LtFg7YsQXE04ov3lW7vf847od6a4jcy/IvbQakWyJeF3snGSduH72oChM2XzN4s62qFy
 wp6xqTbABRUJiswnvFKo4BvQlnJkXbgP/iwxnAEd6PK73YbU3IYsepUkFdQT1qhk1agh
 2aiJH9Pe6C8zi4YpFhFhwlGfp58fr3F0OAaVjs4c/DXEMO3rQApILfOWP29BN6x4MpWX
 p1uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712674169; x=1713278969;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zKs4JT+m2KCkJOqgG6C5kt9r4QRZhsfdeXlX04Y/UsA=;
 b=cVVs0c0GCJiPUQ5BOql6p8BNYFESxkvT+8xlibfRNC7l0B4eGUMEkmQHRwRraLstme
 JcXQcvZYnx5eknbjaNmQbja6ro9EIdu7dc2EpyH0WCQ0fL7q8n9A4g6d+xwdF+8d5Vow
 5CX29AVhMse0SgS1TIWTOWCLLCjD52/wxRHObiTmZ6WG2YHKMx//EMIVnJggDn1JU6ik
 snZli7GMrIWOq6AxbbSBDboXB5r0T7VwDdFpunYrjrJ5MGhWK6iPAVb13g9r6HOG4tRG
 WhjRwki+QFg9s+irowVtGZhxNDuSm1piQ+6rg/sB+VDVPfISQqmk0V17Eb+mBCkJZrn3
 Eiaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+9LKTnt5ykwecmmMcAQnBDNaTg9b9G4gIzLBIMAAYNCsRQRgZyHdG3Va+ZcziENimQOC2GEMilYflY0Ct5Iw4+VlwLw==
X-Gm-Message-State: AOJu0YzM1QbfVYCNY/A1rczKHHh8Y18iFcNAKlXWjUkzLlprh7S1iiVq
 IdXAo8XNec84ZcAMJSmnnSqZVa+e7uKquZgyicB0FoO7oOHvwOJoND47EyidILj6XrRJQ6160wB
 2
X-Google-Smtp-Source: AGHT+IFhm+V5/ZMto/9FhoeQoEbSx4P2kVv4j9fj0ENS1nQcpjwYh5rZP7G38Wy6GwD/Cy4lPv82kQ==
X-Received: by 2002:a17:906:195a:b0:a4e:2777:37c7 with SMTP id
 b26-20020a170906195a00b00a4e277737c7mr7577876eje.49.1712674168959; 
 Tue, 09 Apr 2024 07:49:28 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::570d])
 by smtp.gmail.com with ESMTPSA id
 c27-20020a170906d19b00b00a51a00142bdsm5776947ejz.212.2024.04.09.07.49.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Apr 2024 07:49:28 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 09 Apr 2024 16:49:25 +0200
Subject: [PATCH v3 2/2] dts: support building all dtb files for a specific
 vendor
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240409-b4-of-upstream-build-vendor-v3-2-f096de0c513b@linaro.org>
References: <20240409-b4-of-upstream-build-vendor-v3-0-f096de0c513b@linaro.org>
In-Reply-To: <20240409-b4-of-upstream-build-vendor-v3-0-f096de0c513b@linaro.org>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de, 
 Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2528;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=lFINIkt3mPUDg930k4h55ttVmUyWegfEw9o+thWATTw=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmFVV1MEXAeU1bV0/LRmbVqo/kVsFndzbwDv+v7
 Q8Nt04y7meJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZhVVdQAKCRAFgzErGV9k
 tk3fEACGlV+hw6HCCCyonqOo13wREuAY8sYkkTUPYwmL/EXppcR6ph5A1HCgWiFaS1q7qBue2ii
 aazEUO6A61POVn0cqBmlIUzO9bZGov0/cC4rUBXruMZg9T1MacvuFWYijx+JR+jR0NSw2k5EAgE
 YzBwyS7Md3qEdZsuNjQX5GWC4S4b2iDAm7HvBoJ0ES86OYs1YpWZFthgJfNuaaX9X2QrDuk5iXY
 Q44dNpQ3gUhCbtz3s0RFY2njzWlMcPCZ4mQrGyDuoYUj1Z7+gBfAjx1M0LxFthyyrdJtwvEzLGg
 5sH2evhbLVWRZ1keKcYSHNYNJZE9aEmcFBjBGoCDxp9gBwM4ZV6wdHlbXSf3CM9fat8CBDuGOkk
 VBh/wosxrbf4qxrruRX2xE22T5cOdRdRsOmgGQdT4jQJa58DyvRAkrAEwwGnnniAi9qy4PfVMj4
 r4tVE6UAaz+2pLk55Yy0MnYTQpUbkydKy5IW0In/xdBNyTtM4XCMdE7eDTLZJ0ymfug2mcZqc7U
 IrM3Phg6sGhqOTWi7zVNapbO1nAKkFGzXsKxZ0bEfw4kj7fJP+iMtYllgVRNoOsnwhVsCoovhyu
 budrgGEEcai08DuU5YfOkpuo/jY7fE3NktjFejK0IFk71psBpbzYDbQVlzh6NBCmHO1T+WYk9Td
 pxVbRn/0ed0T8bg==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
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

This adjusts OF_UPSTREAM to behave more like the kernel by allowing for
all the devicetree files for a given vendor to be compiled. This is
useful for Qualcomm in particular as most boards are supported by a
single U-Boot build just provided with a different DT.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 dts/Kconfig          | 24 ++++++++++++++++++++++++
 scripts/Makefile.dts | 13 +++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/dts/Kconfig b/dts/Kconfig
index b9b6367154ef..6883a000a052 100644
--- a/dts/Kconfig
+++ b/dts/Kconfig
@@ -100,8 +100,32 @@ config OF_UPSTREAM
 	  However, newer boards whose devicetree source files haven't landed in
 	  the dts/upstream subtree, they can override this option to have the
 	  DT build from existing U-Boot tree location instead.
 
+config OF_UPSTREAM_BUILD_VENDOR
+	bool "Build all devicetree files for a particular vendor"
+	depends on OF_UPSTREAM
+	help
+	  Enable building all devicetree files for a particular vendor. This
+	  is useful for generic U-Boot configurations where many boards can
+	  be supported with a single binary.
+
+	  This is only available for platforms using upstream devicetree.
+
+config OF_UPSTREAM_VENDOR
+	string "Vendor to build all upstream devicetree files for"
+	depends on OF_UPSTREAM_BUILD_VENDOR
+	default "qcom" if ARCH_SNAPDRAGON
+	default "rockchip" if ARCH_ROCKCHIP
+	default "amlogic" if ARCH_MESON
+	default "allwinner" if ARCH_SUNXI
+	default "mediatek" if ARCH_MEDIATEK
+	default "marvell" if ARCH_MVEBU || ARCH_KIRKWOOD
+	default "xilinx" if ARCH_VERSAL || ARCH_ZYNQ
+	default "nvidia" if ARCH_TEGRA
+	help
+	  Select the vendor to build all devicetree files for.
+
 choice
 	prompt "Provider of DTB for DT control"
 	depends on OF_CONTROL
 
diff --git a/scripts/Makefile.dts b/scripts/Makefile.dts
index 5e2429c6170c..790f3c508f19 100644
--- a/scripts/Makefile.dts
+++ b/scripts/Makefile.dts
@@ -1,3 +1,16 @@
 # SPDX-License-Identifier: GPL-2.0+
 
 dtb-y += $(patsubst %,%.dtb,$(subst ",,$(CONFIG_DEFAULT_DEVICE_TREE) $(CONFIG_OF_LIST) $(CONFIG_SPL_OF_LIST)))
+
+ifeq ($(CONFIG_OF_UPSTREAM_BUILD_VENDOR),y)
+ifeq ($(CONFIG_ARM64),y)
+dt_dir := $(srctree)/dts/upstream/src/arm64
+else
+dt_dir := $(srctree)/dts/upstream/src/$(ARCH)
+endif
+
+dtb-vendor_dts := $(patsubst %.dts,%.dtb,$(wildcard $(dt_dir)/$(subst ",,$(CONFIG_OF_UPSTREAM_VENDOR))/*.dts))
+
+dtb-y += $(subst $(dt_dir)/,,$(dtb-vendor_dts))
+
+endif

-- 
2.44.0

