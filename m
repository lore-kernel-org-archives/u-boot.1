Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E92DBC25B7E
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 14:21:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B10088818;
	Fri, 31 May 2024 16:19:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NtuW7FB9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A7118872E; Fri, 31 May 2024 16:19:45 +0200 (CEST)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FB0E885AF
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 16:19:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-6c5a6151ff8so280972a12.2
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 07:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717165181; x=1717769981; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r/29uDjAVg0Z0ne48KLiD+dalbsEAx1v+I0EdfVvZF0=;
 b=NtuW7FB9bZePmxN1GWDrlKunuHec3Io+aEVd1O7DP98bDKZ6cMKvN2DVBsdr+x5Rhq
 3PEFSyeUCJU5Wgfp2X/eTOD7+V80O/hcJxs5RQFjSmttzNdA6LzlxcxzodbU1PAcDQDO
 ko4b0+DhNoqg/uW/TYnbeRv82WCppeIkP5F81LoOaqtPbJazuowF1JpsalaT7BFYZXVn
 uYNzgTuR1aa3rHdKEjKc9gxOnJ72iQCvVybYM2zs+VapTRNTrCSk7hTY/8wGTdy/zovG
 FHZ1Zu/fj/hzpnmOxKQVYF2zWRbc2qvxHI+JrM1uvN5QR3dcm8QYt3DUL7LofScqSwp3
 WQWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717165181; x=1717769981;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r/29uDjAVg0Z0ne48KLiD+dalbsEAx1v+I0EdfVvZF0=;
 b=GnU6e+ZO6Qpa55Vwc/aaMhTGj/GKWSKpVRrH8itaS1F+nrVlvwRHJqzwWHtXJWx989
 P7QtAPOR55617LQv2+78FyL9D3OCYPz70r/POKMqU5TQVwi0t/WD8WaUeIX9RPteHN7a
 Ts6Zy7cwkMBL0ULhmRooTppaIAQAQiOe+iBT9Nyu74y+fwlxIbr3bA+kDX5N17XEKpVr
 s19nmNfCWWP4ezMFI6plzQydyFx9MW/Kdp0eBpv7ALP6YqpaskoaYuF9aGKPEyo4qn6X
 FFb37GtGWFPsdOyVDQkF5+wFGpbS/gp4+atYEdO9J4oSyFlT3aV8osiJtWCk4c77D4jE
 cw+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhLc8SOZQAlgRsddJsmQeqb4JsGmxLIYLD/BzuG6e2iuFUUOzQwxrBuwL2Wd0XpD/QW6YthHWl77o1nO4kqTYDNY6XAA==
X-Gm-Message-State: AOJu0Yyg0b58v2NTS5q3M48QSuXti/4NRCm/cwKl8zby43W0T7m9HBHr
 jgl7YOmJZmlRmMkOqQQTeCjRSOvTyfilVzNnx4eskaa6Sbkn5gya
X-Google-Smtp-Source: AGHT+IEcMYrUjb5CduNksI2ghGt/l2rwpnW8LWgbXDV3Hpe8NhG/IA5fbKIRErmNApSCfDMKoIFxsw==
X-Received: by 2002:a17:90a:eb12:b0:2c0:3384:b2f3 with SMTP id
 98e67ed59e1d1-2c1dc57da9bmr1713482a91.13.1717165181030; 
 Fri, 31 May 2024 07:19:41 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c1a775ccedsm3563935a91.1.2024.05.31.07.19.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 07:19:40 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Kever Yang <kever.yang@rock-chips.com>, Jagan Teki <jagan@edgeble.ai>,
 Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <quentin.schulz@cherry.de>
Cc: Anand Moon <anand@edgeble.ai>, Anand Moon <linux.amoon@gmail.com>,
 u-boot@lists.denx.de
Subject: [PATCH RFC v2 15/23] rockchip: RK3308: Enable display cpuinfo support
 on all boards
Date: Fri, 31 May 2024 19:48:29 +0530
Message-ID: <20240531141837.13189-16-linux.amoon@gmail.com>
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

Enable DISPLAY_CPUINFO options to support on all RK3308 boards.
Its used to determine the reset cause of the board.

Cc: Jagan Teki <jagan@edgeble.ai>
Signed-off-by: Anand Moon <anand@edgeble.ai>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 configs/evb-rk3308_defconfig       | 1 -
 configs/roc-cc-rk3308_defconfig    | 1 -
 configs/rock-pi-s-rk3308_defconfig | 1 -
 3 files changed, 3 deletions(-)

diff --git a/configs/evb-rk3308_defconfig b/configs/evb-rk3308_defconfig
index f4c2ea12ad..4622b2b2d4 100644
--- a/configs/evb-rk3308_defconfig
+++ b/configs/evb-rk3308_defconfig
@@ -16,7 +16,6 @@ CONFIG_ANDROID_BOOT_IMAGE=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3308-evb.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_PAD_TO=0x7f8000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
diff --git a/configs/roc-cc-rk3308_defconfig b/configs/roc-cc-rk3308_defconfig
index 862ea4301f..cb5a868944 100644
--- a/configs/roc-cc-rk3308_defconfig
+++ b/configs/roc-cc-rk3308_defconfig
@@ -16,7 +16,6 @@ CONFIG_ANDROID_BOOT_IMAGE=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3308-roc-cc.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_PAD_TO=0x7f8000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
diff --git a/configs/rock-pi-s-rk3308_defconfig b/configs/rock-pi-s-rk3308_defconfig
index c15ba3d8a4..d888cfaa36 100644
--- a/configs/rock-pi-s-rk3308_defconfig
+++ b/configs/rock-pi-s-rk3308_defconfig
@@ -16,7 +16,6 @@ CONFIG_ANDROID_BOOT_IMAGE=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3308-rock-pi-s.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_PAD_TO=0x7f8000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
-- 
2.44.0

