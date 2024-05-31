Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D63BC25B7E
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 14:22:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAFDA887CA;
	Fri, 31 May 2024 16:19:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RBtDs4cx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DB35887CA; Fri, 31 May 2024 16:19:51 +0200 (CEST)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 065B0885AF
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 16:19:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7024494f7daso828494b3a.3
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 07:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717165187; x=1717769987; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4AWX+a3danwXJxw0C2h1AHaIWUTXEtDLrKB2P+bsdZg=;
 b=RBtDs4cxljk6LNGq0jo2Xn0EyMh4MxgEEOsOeqcS/lKXeNbEexqp19sTem2TJ7cPa/
 sK3fnNQfFCumPGJGllDy1QQvCaX0ATCBg1oMeTYLeaptTsG6IqFAdiS5CA+yz8JejOk3
 0BiIsTexO4FV/lQ5P22UWfuSqRdtrmvtlbkGQs0uQdBcpxvAsVvymusY+o7N5Rh/g7Ap
 Bp2aolZW2knYxlU6lcqcmeErH6xu/wjZtBgzGD4E6YlXrnV89ITvTFws8L+wbgbb/6FB
 WZfdsvodhuEOUHVH94OmxbvdEoL0J8+0a03JBDh4Zonie1YDEdLGd2pDTtbN4kToLwB6
 IVcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717165187; x=1717769987;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4AWX+a3danwXJxw0C2h1AHaIWUTXEtDLrKB2P+bsdZg=;
 b=rHdAoGd1qZRkc0tHfryiN3J77oUqPLFFWQEJiVW4tePmf7tuoXKYmVNRxyEsCCbUnY
 8OWv0ruLOA/OzKemFh61dboA7XvNPCbtuN/aYBNVhY6rb5+ALGqTuzNUm2xQxYa0yCTt
 57/M8HTvZBJsKfiu1F8iro3tbaIIOih6p7y3+jxXKJOG3d+uwJJVudb9Da6/ZP25XdTd
 f1bve/LIG9rE4+JI8GLZEzQEggFDIGEgu8tzxZZ5rihQB7tKuQwhvDzfGwIMLPlmlz07
 ZMcdKG4jpblrHfEcSpLr6qZdE7Ol7JAypmOHiT15xHcR6WYCgFOSlenoOiVGt0P+YsQY
 IEKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8OX6lrEXV/gJW/8XkCF6X7ktMw6AAGxOGAzvoQVzZBc6F/JOIS7wtw2pzErqYxP77sTD6yPJmAzjTBG0eymqhgfQPbg==
X-Gm-Message-State: AOJu0YzaCtWKJGzaRqHl1kpngJKNMyeHcjGCkkSzpkq3Aw6Adxa6dIW2
 zeqNpk29EzgibrHYalxYTTdUjfz908Fk3X+8/DRW7WTbyddQIy55
X-Google-Smtp-Source: AGHT+IFczivMPbf2K/LDv4TgxUjb52+A4Od3z2cHROZ+A+rVi0DJlbGZevC9V9lYy9UPh6V60RSWFQ==
X-Received: by 2002:a05:6a21:339c:b0:1af:cfc2:8069 with SMTP id
 adf61e73a8af0-1b26f0f19f9mr2491757637.4.1717165187440; 
 Fri, 31 May 2024 07:19:47 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c1a775ccedsm3563935a91.1.2024.05.31.07.19.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 07:19:47 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Kever Yang <kever.yang@rock-chips.com>, Jagan Teki <jagan@edgeble.ai>,
 Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <quentin.schulz@cherry.de>
Cc: Anand Moon <anand@edgeble.ai>, Anand Moon <linux.amoon@gmail.com>,
 u-boot@lists.denx.de
Subject: [PATCH RFC v2 17/23] rockchip: RK3368: Enable display cpuinfo support
 on all boards
Date: Fri, 31 May 2024 19:48:31 +0530
Message-ID: <20240531141837.13189-18-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240531141837.13189-1-linux.amoon@gmail.com>
References: <20240531141837.13189-1-linux.amoon@gmail.com>
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

From: Anand Moon <anand@edgeble.ai>

Enable DISPLAY_CPUINFO options to support on all RK3368 boards.
Its used to determine the reset cause of the board.

Cc: Jagan Teki <jagan@edgeble.ai>
Signed-off-by: Anand Moon <anand@edgeble.ai>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 configs/evb-px5_defconfig      | 1 -
 configs/geekbox_defconfig      | 1 -
 configs/lion-rk3368_defconfig  | 1 -
 configs/sheep-rk3368_defconfig | 1 -
 4 files changed, 4 deletions(-)

diff --git a/configs/evb-px5_defconfig b/configs/evb-px5_defconfig
index ccd3883153..9be143487e 100644
--- a/configs/evb-px5_defconfig
+++ b/configs/evb-px5_defconfig
@@ -37,7 +37,6 @@ CONFIG_SPL_BOOTSTAGE=y
 CONFIG_BOOTSTAGE_REPORT=y
 CONFIG_BOOTSTAGE_FDT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3368-px5-evb.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_PAD_TO=0x7f8000
diff --git a/configs/geekbox_defconfig b/configs/geekbox_defconfig
index 8f4be79831..de526ae14d 100644
--- a/configs/geekbox_defconfig
+++ b/configs/geekbox_defconfig
@@ -15,7 +15,6 @@ CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_DEBUG_UART=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3368-geekbox.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_REGMAP=y
diff --git a/configs/lion-rk3368_defconfig b/configs/lion-rk3368_defconfig
index a4a7f1a5cb..e5bcc13038 100644
--- a/configs/lion-rk3368_defconfig
+++ b/configs/lion-rk3368_defconfig
@@ -34,7 +34,6 @@ CONFIG_SPL_BOOTSTAGE=y
 CONFIG_BOOTSTAGE_REPORT=y
 CONFIG_BOOTSTAGE_FDT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3368-lion-haikou.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_PAD_TO=0x7f8000
diff --git a/configs/sheep-rk3368_defconfig b/configs/sheep-rk3368_defconfig
index a591b2741d..5e58877012 100644
--- a/configs/sheep-rk3368_defconfig
+++ b/configs/sheep-rk3368_defconfig
@@ -15,7 +15,6 @@ CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_DEBUG_UART=y
 CONFIG_ANDROID_BOOT_IMAGE=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3368-sheep.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_CMD_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-- 
2.44.0

