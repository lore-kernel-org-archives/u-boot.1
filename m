Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61AC7C83F09
	for <u-boot@archiver.kernel.org>; Tue,  8 Jul 2025 15:30:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE3698340A;
	Tue,  8 Jul 2025 17:29:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MdSMUTbY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E76B2832F0; Tue,  8 Jul 2025 17:25:13 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BE3A8338D
 for <u-boot@lists.denx.de>; Tue,  8 Jul 2025 17:25:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vtpieter@gmail.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-ae361e8ec32so897406266b.3
 for <u-boot@lists.denx.de>; Tue, 08 Jul 2025 08:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751988311; x=1752593111; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l/lPPO0E/5Qz4QjFXYKvJlr+YdtKSLO1x6QwruZyeBw=;
 b=MdSMUTbY947fhytlWcJp3NeKnB9NyD9BlL3QQvKIjxsMfezsacqidih8yrb0M+1Tfl
 llvBTGSRJoRc3Yu/3t/3vQWb/yuSdDtrpL3foFc0eNsIUfEJSJNeYWkAu1JdugiLE9Tl
 SIlVICRIhNOxhkvNf61xnHweETy5BfMdo9y4m1XdOPskl94sCseFtjxcBPTA4/2l8nMf
 7HR8b4qcPuiICaZp46ZFqWrKV8UiHYno1DRs+SvKwHHqtNPx6Pks8nLa0aVz6Dnn9U29
 5f8u1GpLVC+hPtHkgCtUswdvoWTS2fAbJ3ij/jW909VqvYAGlLs8ZrlhkLLoden/3jfE
 HJew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751988311; x=1752593111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l/lPPO0E/5Qz4QjFXYKvJlr+YdtKSLO1x6QwruZyeBw=;
 b=WGM7cmkg1vXIwKDC9hm89E4liT0J/RWEhqaSn1xZZfhCFnrTVimIO5owLytb5goH07
 XySAE+TA8MJBnS8SWmVf13uuaIN+mzIwcXgjk0dcMskysn6/egXd13xDXtst0E+PoJcY
 DPQNMBn7dGgXRk3gVQI3PUzJuSgFZgvVAbNmoNx8x5pAv0GS8lecKOHRAaP3owtNoGDm
 f7ZqCS+P8ljp+gOjUk7YqAPmtbUyxwD51oOlLF5F2llrFb+3UU5HLEZBRTKPxkZEq/Gy
 sICd+WbohaZSQhky9YcDWUnUC6ZVEnCFDuLsy8z8CqCrcxRU47XJ2eH3ZFRHGNtcy98k
 x00w==
X-Gm-Message-State: AOJu0YyNXYiueSj8YYVaiHty8DyPFX8P8eKYVDFrgEsb+GZEvSHDnI/r
 IbwuAlUr4Yh7Uaz5c+4uUFjvdZgNYypIMVpQPIkRQYJQ6kUFAtdpRpoPgJkWoIFO
X-Gm-Gg: ASbGncvTx/I+LWu6OgCK8han099UDPLrczf2VlSj9tVGhIIq6RNy9UNPpQ1ATF/e3Kw
 5UX1qMk/L295pQhT0wxbYe8EWqslQZf9qQSndAJPSF0BujB4VZ/CwjlZ2ihkQOEpVQlBUJQ5GgQ
 NjzIZyAUdQNZ/It4sROJ5zbTe/RiksYico0kq+P9wJgDqjqhg+pOw8falrEStGq4q7IvNx2cMjv
 cXPBEucSWB/28ejbGMMoeSARZzDnA6Mk2ZUo4br/FO+ZdSif32Zp3bQ5bEUZM8hQNglyNX6SHz8
 T6ZoZL65v75D1RYXsLCupkmDQrbJm+QOG9zae79DTiAuiA0jrJHxdThimuIMTUtVb5l1d60Vbzw
 =
X-Google-Smtp-Source: AGHT+IG7TKCl+lh7so+SNdD6rKm9y2WF2RrFadTD8oE3UYunozc+YHfSv5QMQGv8kfllnuYCTGe9KQ==
X-Received: by 2002:a17:907:9404:b0:ae3:ed39:89ba with SMTP id
 a640c23a62f3a-ae6b0b1e8dcmr373349666b.11.1751988311339; 
 Tue, 08 Jul 2025 08:25:11 -0700 (PDT)
Received: from lapsy144.cern.ch (lapsy144.cern.ch. [2001:1458:202:99::100:4b])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae3f66d931csm921950666b.10.2025.07.08.08.25.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Jul 2025 08:25:11 -0700 (PDT)
From: vtpieter@gmail.com
To: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Cc: michal.simek@amd.com,
	Pieter Van Trappen <pieter.van.trappen@cern.ch>
Subject: [PATCH v5 6/6] configs: enable FPGA commands and drivers at
 sandbox_defconfig
Date: Tue,  8 Jul 2025 17:24:51 +0200
Message-ID: <20250708152455.1214487-7-vtpieter@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250708152455.1214487-1-vtpieter@gmail.com>
References: <20250708152455.1214487-1-vtpieter@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 08 Jul 2025 17:29:30 +0200
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

