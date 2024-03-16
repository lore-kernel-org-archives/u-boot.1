Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4159CC54E60
	for <u-boot@archiver.kernel.org>; Sat, 16 Mar 2024 13:55:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADC5D8804B;
	Sat, 16 Mar 2024 14:54:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PvG9X0S3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B61038803A; Sat, 16 Mar 2024 14:54:44 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E520387FC6
 for <u-boot@lists.denx.de>; Sat, 16 Mar 2024 14:54:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=christianshewitt@gmail.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-413f4cb646dso16502635e9.1
 for <u-boot@lists.denx.de>; Sat, 16 Mar 2024 06:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710597279; x=1711202079; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bWhWcKIn0pGCEzwEvQhFIBa9a12cgD1Rhhcfr7musaI=;
 b=PvG9X0S3SWbF7V4aPzVPnN9SnxtpsEC0wK6xXVTNZ2Ul+YE0f/hrXicfrfVxyH4aQh
 xq5Av4pDnJeJ/lAd54N/RLBvwqu4u6h419QOVNToMazUmkA3yzfhcY7/e23Z96K0nYsR
 eoSoyvLJQR3PEnMWNtsxEwmO5LDiGgfWBUro7MQY6eVKQoo+VuV5Fsrq+C+HbKl79wSK
 4wqoZ1Q7TlrDe7Dof5CDxc08iHJ2X6gAO8Mjx9QrUHdyTsztITiae7PQhjr+bKFC1gSx
 ZEZ0ElwzfJHj+O42wR8opJ+VCj8Jfc4iq8hBisJa+OfOqa8ZuDu13TqxAdYgbEVdV5lP
 0TvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710597279; x=1711202079;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bWhWcKIn0pGCEzwEvQhFIBa9a12cgD1Rhhcfr7musaI=;
 b=odVJvgKhoPnJ49KjUktsueGBVXex2fequn1uHoxylxmgpOtf4mcmHVHmP0ib0z9Ni4
 GFch6letCs5cgj0KkeedUt6oNWptXSPKbw6GeZBuK9Kt9By8cTcRj55+jySnRGIaQCNe
 tQNtd8zdX9w0noIFCLcBNP5kO4a+CelfWDXN4GnUsUVRoE8kKrCkgrNL236x3uwyChcQ
 44+zXYnnLyUr5Y74vE0vhE7JdZdh2sxx40JRALCuu20Mled0ni9AFIrrJa9cLTQY/MCL
 Ab95LEpswsr6X+qI7e5ES23LbKr5J5Fyr6qbEenMe8cO907ltucWR3s/3ySOfgwN+D+2
 XVJA==
X-Gm-Message-State: AOJu0YyOad1EiTvEUCqV+FCRDt1J2D6QgktpRNNZpHwMrN9FOZJ0xSiF
 EGcu8yjNcwYy/+T0xw5IVJHZBzn4xG0fj1AvXx3YF+EUokNxfcCO82oYuRXRhTc=
X-Google-Smtp-Source: AGHT+IGzRMqMtu4v9w5YQ8+ov6mybC3kz1cjjQ/1+F4ZvcVqewhFcpXSu7Iz69nZ890Fbbr22AshFw==
X-Received: by 2002:a05:600c:1d18:b0:413:f0d1:5ee2 with SMTP id
 l24-20020a05600c1d1800b00413f0d15ee2mr5842748wms.12.1710597279625; 
 Sat, 16 Mar 2024 06:54:39 -0700 (PDT)
Received: from toolbox.. ([87.200.95.144]) by smtp.gmail.com with ESMTPSA id
 r7-20020a05600c35c700b0041409fa57c4sm523963wmq.34.2024.03.16.06.54.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Mar 2024 06:54:39 -0700 (PDT)
From: Christian Hewitt <christianshewitt@gmail.com>
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 linux-amlogic@lists.infradead.org
Cc: Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 3/3] configs: amlogic: set board family to avoid random MAC on
 WeTek Hub/Play2
Date: Sat, 16 Mar 2024 13:54:30 +0000
Message-Id: <20240316135430.826898-4-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240316135430.826898-1-christianshewitt@gmail.com>
References: <20240316135430.826898-1-christianshewitt@gmail.com>
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

Add CONFIG_SYS_BOARD="p200" to the Hub/Play2 board configs to ensure the
factory programmed MAC is correctly read from efuse.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 configs/wetek-hub_defconfig   | 1 +
 configs/wetek-play2_defconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/wetek-hub_defconfig b/configs/wetek-hub_defconfig
index fd92b041e73..413bbfe9ab7 100644
--- a/configs/wetek-hub_defconfig
+++ b/configs/wetek-hub_defconfig
@@ -1,5 +1,6 @@
 CONFIG_ARM=y
 CONFIG_ARCH_MESON=y
+CONFIG_SYS_BOARD="p200"
 CONFIG_TEXT_BASE=0x01000000
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
diff --git a/configs/wetek-play2_defconfig b/configs/wetek-play2_defconfig
index b887419a6ba..dd98929444c 100644
--- a/configs/wetek-play2_defconfig
+++ b/configs/wetek-play2_defconfig
@@ -1,5 +1,6 @@
 CONFIG_ARM=y
 CONFIG_ARCH_MESON=y
+CONFIG_SYS_BOARD="p200"
 CONFIG_TEXT_BASE=0x01000000
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-- 
2.34.1

