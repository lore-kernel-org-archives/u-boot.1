Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBE52EB64DE
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 10:28:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B7A289017;
	Tue, 10 Sep 2024 12:28:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lj8e7XBh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F46989017; Tue, 10 Sep 2024 12:28:19 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 674598901C
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 12:28:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-42cb57f8b41so28401465e9.0
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 03:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725964094; x=1726568894; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wARXaWg6tLzBmXUfjS8MpABU+wrXkhyqtt5xJ/UdxsU=;
 b=lj8e7XBhc4u/u+zspvDslLLDXsBfGr9ntiJW/Ug5cP9epF+TwQ+hdEBTxN9NsZfajl
 HUMNz5Puj2qFU+HCwVxUKh5XeGe+eT4a8v4OSdoKXGniOlE4Vu7XcQpH2OJhrFKTOHc1
 M+uF5hN+YIP/kQ+rZVJg5y0Vo1PoI4yTo3gcG7XVbeELicU5OsTxX1vXbtCjLZuXJQBt
 MBRDNiXgHZcnTQP82hYhXNFrBMQJkqh9fpMdQoMQcIuaIuh7OEfVQ4XCrIPM05lViQlY
 10m2CYD5AgUpHhPdEkwnhN+7y2+NtLdiW4c9rJjYDPBjsTgpv28BQBeV09f7nwh2JHLQ
 9bLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725964094; x=1726568894;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wARXaWg6tLzBmXUfjS8MpABU+wrXkhyqtt5xJ/UdxsU=;
 b=AU55cb6ibQ5t6ECfUgXnFBhBiNuvz1CXLgeloTzH4NXeaQpPfCkezdCfWmOttghru9
 RrG9UtRJoIImZ/ubKt0iUVLsW+hUonOZvtLRqwwsW8PA/TAfielhniAdxttjpFxzJ2Ni
 xZy8WQFH/pNmjamlRMV04ijjjgGPfApa5afR6ds839K9PGMohUb3CVUgfanZ1FZ7e6fH
 MAQOi6P4zRDzSt7sEBiYv65ilXZuvWO28y/OmzMDtAYVjqFrxOXfNmzRGnqWxuoBmdSk
 J1JzjZFXTim5MkuJ2vhbndzV+qITRcMndyOoZ0JzmvzzmsrqTcVrglfhZ3RHDCqCkh5J
 h9DA==
X-Gm-Message-State: AOJu0YxzR2vK0Io8XqgWMTpKnZXb7krpYj0L4CmKMdl3K7sm36tPqWr4
 ivDmyJgGmECGTKr1y4Sp2WcmNdJmTUkk6be/Iq4iRC4UV2npxDJdyA484Tn4DyWHomN/1cEGO5v
 rEzbkSQ==
X-Google-Smtp-Source: AGHT+IHAk9mWrmnoOaHCVH0z3mgPtu9nGeKMK38S+ybB21QqVH6PIdnWxl+wRgTjToPI+4MJ3kTFOw==
X-Received: by 2002:a05:600c:605a:b0:42c:af5f:c00c with SMTP id
 5b1f17b1804b1-42caf5fc0b6mr99240155e9.21.1725964094232; 
 Tue, 10 Sep 2024 03:28:14 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:d022:7718:6b27:6851])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378956652ddsm8549593f8f.29.2024.09.10.03.28.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 03:28:13 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>, Jonas Karlman <jonas@kwiboo.se>,
 Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH] dfu: fix Kconfig dependencies
Date: Tue, 10 Sep 2024 12:27:50 +0200
Message-Id: <20240910102751.3182982-1-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
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

Fix link errors caused by missing Kconfig dependencies:

1. DFU_OVER_USB compiles common/dfu.c which calls g_dnl_clear_detach()
which is implemented in drivers/usb/gadget/g_dnl.c which needs
USB_GADGET_DOWNLOAD. Test case:

 $ printf "CONFIG_USB_GADGET_DOWNLOAD=n\nCONFIG_USB_FUNCTION_FASTBOOT=n" \
       >>configs/am62px_evm_a53_defconfig
 $ make am62px_evm_a53_defconfig
 $ make CROSS_COMPILE=aarch64-linux-gnu-
 [...]
 common/dfu.c:34:(.text.run_usb_dnl_gadget+0x68): undefined reference to `g_dnl_clear_detach
 [...]

2. With the above fixed, the same build causes:

 common/spl/spl_dfu.c:29:(.text.spl_dfu_cmd+0xb0): undefined reference to `run_usb_dnl_gadget'

This is because SPL_DFU compiles common/spl/spl_dfu.c which calls
run_usb_dnl_gadget() which is implemented in common/dfu.c which needs
DFU_OVER_USB.

Therefore add these dependencies to Kconfig.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 drivers/dfu/Kconfig        | 2 +-
 drivers/usb/gadget/Kconfig | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dfu/Kconfig b/drivers/dfu/Kconfig
index d034b501360..604386bb734 100644
--- a/drivers/dfu/Kconfig
+++ b/drivers/dfu/Kconfig
@@ -7,7 +7,7 @@ config DFU
 config DFU_OVER_USB
 	bool
 	select HASH
-	depends on USB_GADGET
+	depends on USB_GADGET_DOWNLOAD
 
 config DFU_OVER_TFTP
 	bool
diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
index 03fe3bca197..9921d3e0a77 100644
--- a/drivers/usb/gadget/Kconfig
+++ b/drivers/usb/gadget/Kconfig
@@ -323,6 +323,7 @@ config SPL_DFU
 	bool "Support DFU (Device Firmware Upgrade) in SPL"
 	select SPL_HASH
 	select SPL_DFU_NO_RESET
+	depends on DFU_OVER_USB
 	depends on SPL_RAM_SUPPORT
 	help
 	  This feature enables the DFU (Device Firmware Upgrade) in SPL with
-- 
2.40.1

