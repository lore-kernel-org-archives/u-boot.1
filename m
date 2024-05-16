Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1F4CC25B77
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 12:50:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FB1A88329;
	Thu, 16 May 2024 14:50:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=edgeble.ai
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=edgeble-ai.20230601.gappssmtp.com header.i=@edgeble-ai.20230601.gappssmtp.com header.b="hLAhe8LC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6972C88258; Thu, 16 May 2024 11:03:30 +0200 (CEST)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC49C8824A
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 11:03:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=edgeble.ai
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=anand@edgeble.ai
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6f67c6fc504so773483b3a.1
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 02:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=edgeble-ai.20230601.gappssmtp.com; s=20230601; t=1715850205; x=1716455005;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MxyPqC9aSIWWPmXRx+q+mW2Z7ytOMY/xjaFmJ2V8V8E=;
 b=hLAhe8LCIcM8kRmyf2mr9W/cReY5wZd+m27caKGDJwELiQ+JN0+iku1LNTicjtgZ19
 mXSofUb994wD/TRhX5n2J2urvBS7XjRTn4UiSKIeG/mxtNNcG34IbRzCXQFpvaFG2+H4
 HK0b/iqN0VFgO8dXe8skeO/pudYi+F/cpBugiuT5tHTJCM4LyP5FHbIGTk0o7JTCyW0b
 D90LhIcVIrDS8pM3UYFc6FwtYOqdFmdRkiwABu90QTO4WWSPHQoBv9jMib8s81ZZLb2k
 pwzfM2jOxENab3gxvt0PJAcwBybbgf36auDrPhRi0pB5RV8WYbAVbdP5GbfYyOwyPFYq
 YjDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715850205; x=1716455005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MxyPqC9aSIWWPmXRx+q+mW2Z7ytOMY/xjaFmJ2V8V8E=;
 b=qj7ydcrzBcjxEg3DF9al/qJeIdv8O/lafaaYSB72fTMKe2Cfg8kZ8+v32SNIS3E4wx
 U6XHJxychYO8w3VhgqRHtg3oxYyJSKz9HqYg4erD21EAMD3D0e5dtK2qOILZlWzcBHBD
 55IiVVtaS+fLklLX3u7Pq+dS+jyvOVlnJpQWMAnkPD9wMgFFJ1nwkdg56HmaOeTLo80V
 BmM7EJ4QDgCoRqHKA5CwTFH91LW52l+CDep4Bx4HTzFVE7f8LQjBF+aGkErejTppdSxs
 pJ2trrClhpCw9jPv1prx2mJrwNB0n3qFH1mDN32kYaRp4851q3njV60g1gFmbU8bHrwy
 ekNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCco+MRnf1Gz7ibMhh9AVddM/MJTrNKXi6vlTwCuDw+4BCFefSxxSBvevynqg6Uri25ey0TV2BxAIGcBok1gXf+eoHJA==
X-Gm-Message-State: AOJu0YwPLBvUiwroLbouETOL1Ss/yXZDY/iBE61P6enl1vzWOvMSQId1
 zDUb8lGOwFhlTaE0+paYpNJkQjQ89MW8hpht7z4p5TKVZtHLg24IeWqF7YOZCZ4=
X-Google-Smtp-Source: AGHT+IERGe/WuAj8k3NTpRdR2EL/1d/MUvq4jWnNKyGdxZP9PE+JdRPymfKUhTE2UksRlzwc6y9EMQ==
X-Received: by 2002:a05:6a20:f397:b0:1af:d0bc:d149 with SMTP id
 adf61e73a8af0-1afde0a8d01mr18104297637.6.1715850205264; 
 Thu, 16 May 2024 02:03:25 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-6584e7897bdsm1325189a12.21.2024.05.16.02.03.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 May 2024 02:03:24 -0700 (PDT)
From: Anand Moon <anand@edgeble.ai>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: Anand Moon <anand@edgeble.ai>, Jagan Teki <jagan@edgeble.ai>,
 u-boot@lists.denx.de
Subject: [PATCH v1 4/9] rockchip: RK3399: Enable display cpuinfo support on
 all boards
Date: Thu, 16 May 2024 08:59:04 +0000
Message-ID: <20240516090031.2373-5-anand@edgeble.ai>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240516090031.2373-1-anand@edgeble.ai>
References: <20240516090031.2373-1-anand@edgeble.ai>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 16 May 2024 14:50:16 +0200
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

Imply DISPLAY_CPUINFO Kconfig options to support on all RK3399
boards, Its used to determine the reset cause of the board.

Cc: Jagan Teki <jagan@edgeble.ai>
Signed-off-by: Anand Moon <anand@edgeble.ai>
---
 arch/arm/mach-rockchip/Kconfig     | 1 +
 configs/chromebook_bob_defconfig   | 1 -
 configs/chromebook_kevin_defconfig | 1 -
 3 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index ba1474bb9e..1fd482e43b 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -297,6 +297,7 @@ config ROCKCHIP_RK3399
 	imply TPL_SYS_MALLOC_SIMPLE
 	imply TPL_SYSCON
 	imply TPL_TINY_MEMSET
+	imply DISPLAY_CPUINFO
 	help
 	  The Rockchip RK3399 is a ARM-based SoC with a dual-core Cortex-A72
 	  and quad-core Cortex-A53.
diff --git a/configs/chromebook_bob_defconfig b/configs/chromebook_bob_defconfig
index acfe393410..2c1a8141c0 100644
--- a/configs/chromebook_bob_defconfig
+++ b/configs/chromebook_bob_defconfig
@@ -30,7 +30,6 @@ CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_DEBUG_UART=y
 # CONFIG_SPL_FIT_SIGNATURE is not set
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-gru-bob.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_BOARD_EARLY_INIT_R=y
 CONFIG_BLOBLIST=y
diff --git a/configs/chromebook_kevin_defconfig b/configs/chromebook_kevin_defconfig
index 95fdb418d8..f6649804c7 100644
--- a/configs/chromebook_kevin_defconfig
+++ b/configs/chromebook_kevin_defconfig
@@ -31,7 +31,6 @@ CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_DEBUG_UART=y
 # CONFIG_SPL_FIT_SIGNATURE is not set
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-gru-kevin.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_BOARD_EARLY_INIT_R=y
 CONFIG_BLOBLIST=y
-- 
2.45.0

