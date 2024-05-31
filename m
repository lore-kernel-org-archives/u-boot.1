Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 190BEC25B7E
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 14:20:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B531887F0;
	Fri, 31 May 2024 16:19:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SSv0f/zQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E37DC88800; Fri, 31 May 2024 16:19:25 +0200 (CEST)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BECE885AF
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 16:19:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2c034676e02so1553182a91.1
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 07:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717165162; x=1717769962; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WnlwsBrKY0pMaH2AeX4v42/gEsBN+tiw/ok8UHOZQco=;
 b=SSv0f/zQgRDHMDP+9jwXUvYkBlnPd8Ptt1OMQZoCq1gosecMP+hAV4LVa93k1ABt+z
 R1Tgtyxj5P2lkXMSSs2GZSE/Xj1bEhtrfW4w2i9ktD6ngVzkdq93lUWt8TvpW3vQtJ+j
 5hUidN4pPV7fHH2/lA3aBTMMojyN8GzdLdkstrb75t+sI/MH3THmgDw6AOSwuOX8AwbW
 nN5rVWBfw4Caur8jTo5cYJ7TKcITh6CEbYZkMh7/KpiVNEpcrDA6gB7+QviM85pEEP4n
 8FXLJ+l1aQKsBq6n9vnGzIvLJfdR8VKcCQIBHIT51/dZj+At49EGBX3OXS8KPdevgX+z
 liAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717165162; x=1717769962;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WnlwsBrKY0pMaH2AeX4v42/gEsBN+tiw/ok8UHOZQco=;
 b=lj6QOsHBCdB2O1P2KHIVyG2Jwf9gYM5JPXsLmabOkRaGqzahKjt5+mgrZTXIcr3oV8
 hP3HgeTm9oHRBAvpC86p8bm5Km9GUw+dSxaL17V8WmMx91o5ZUwbBXez12pIKJGpK/YN
 g++EJVFWGvLr3GDdFsK9ri0rC1m3OHXFcuApCzChCdLdh+7lDXMTvHyo/WQy0AuTtCH6
 UoSTpclh9t8tMOAvNenxu63Cg9tfXkoecgmE+LQ9PjuiPbpgUKdMlEq762pTKrkdiyXu
 Qqf2JXH0+iGKR8wXA7HSQhMUxk54hldV+9rVIhZjGBjEsVlmKIWCRMbSCYC2emKiNUNw
 bR+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNdtA8NL75oECXjRoUsZk2YswVE3SJ4z3pP/esvm6Bf9ZQH/BkZ5eJkim9kcrFWXjuCk313JypMl3rcpkAf2WZik+MIA==
X-Gm-Message-State: AOJu0YzzMdupjmozWAAt6E657LmNyB58PQ3YmkCHhG3zpEU52fYLXgnI
 sShYJwHrnz3f447aZJUK2jeoYL5LvobvaHmHTrHYeZFNisEY65Qs
X-Google-Smtp-Source: AGHT+IG1HpUhMdeCqD5i9AVnPGfolwvtpntiRiU2CTw6ODwzXMhMApAjobnaRBlC5T7PCSEz/nFb8A==
X-Received: by 2002:a17:90b:14e:b0:2c0:238c:4ee6 with SMTP id
 98e67ed59e1d1-2c1dc5668aemr1943437a91.2.1717165162002; 
 Fri, 31 May 2024 07:19:22 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c1a775ccedsm3563935a91.1.2024.05.31.07.19.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 07:19:21 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Kever Yang <kever.yang@rock-chips.com>, Jagan Teki <jagan@edgeble.ai>,
 Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <quentin.schulz@cherry.de>
Cc: Anand Moon <anand@edgeble.ai>, Anand Moon <linux.amoon@gmail.com>,
 u-boot@lists.denx.de
Subject: [PATCH RFC v2 09/23] rockchip: RK3588: Enable display cpuinfo support
 on all boards
Date: Fri, 31 May 2024 19:48:23 +0530
Message-ID: <20240531141837.13189-10-linux.amoon@gmail.com>
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

Enable DISPLAY_CPUINFO options to support on all RK3588 boards.
Its used to determine the reset cause of the board.

Cc: Jagan Teki <jagan@edgeble.ai>
Signed-off-by: Anand Moon <anand@edgeble.ai>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 configs/coolpi-4b-rk3588s_defconfig      | 1 -
 configs/coolpi-cm5-evb-rk3588_defconfig  | 1 -
 configs/evb-rk3588_defconfig             | 1 -
 configs/generic-rk3588_defconfig         | 1 -
 configs/jaguar-rk3588_defconfig          | 1 -
 configs/nanopc-t6-rk3588_defconfig       | 1 -
 configs/neu6a-io-rk3588_defconfig        | 1 -
 configs/neu6b-io-rk3588_defconfig        | 1 -
 configs/orangepi-5-plus-rk3588_defconfig | 1 -
 configs/orangepi-5-rk3588s_defconfig     | 1 -
 configs/quartzpro64-rk3588_defconfig     | 1 -
 configs/rock5a-rk3588s_defconfig         | 1 -
 configs/rock5b-rk3588_defconfig          | 1 -
 configs/toybrick-rk3588_defconfig        | 1 -
 configs/turing-rk1-rk3588_defconfig      | 1 -
 15 files changed, 15 deletions(-)

diff --git a/configs/coolpi-4b-rk3588s_defconfig b/configs/coolpi-4b-rk3588s_defconfig
index 3d45d939ab..b094224f6e 100644
--- a/configs/coolpi-4b-rk3588s_defconfig
+++ b/configs/coolpi-4b-rk3588s_defconfig
@@ -23,7 +23,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588s-coolpi-4b.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_PAD_TO=0x7f8000
diff --git a/configs/coolpi-cm5-evb-rk3588_defconfig b/configs/coolpi-cm5-evb-rk3588_defconfig
index 5190d69c1c..382ee97fc9 100644
--- a/configs/coolpi-cm5-evb-rk3588_defconfig
+++ b/configs/coolpi-cm5-evb-rk3588_defconfig
@@ -23,7 +23,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-coolpi-cm5-evb.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_PAD_TO=0x7f8000
diff --git a/configs/evb-rk3588_defconfig b/configs/evb-rk3588_defconfig
index 1d5585677a..bfc505a4b7 100644
--- a/configs/evb-rk3588_defconfig
+++ b/configs/evb-rk3588_defconfig
@@ -16,7 +16,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-evb1-v10.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_PAD_TO=0x7f8000
diff --git a/configs/generic-rk3588_defconfig b/configs/generic-rk3588_defconfig
index 42bc2c9a76..ddb23b035b 100644
--- a/configs/generic-rk3588_defconfig
+++ b/configs/generic-rk3588_defconfig
@@ -17,7 +17,6 @@ CONFIG_SPL_LOAD_FIT=y
 # CONFIG_BOOTMETH_VBE is not set
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-generic.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_PAD_TO=0x7f8000
diff --git a/configs/jaguar-rk3588_defconfig b/configs/jaguar-rk3588_defconfig
index b69cf4cd05..712a936539 100644
--- a/configs/jaguar-rk3588_defconfig
+++ b/configs/jaguar-rk3588_defconfig
@@ -22,7 +22,6 @@ CONFIG_SPL_LOAD_FIT=y
 # CONFIG_BOOTMETH_VBE is not set
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-jaguar.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_CYCLIC=y
 CONFIG_SPL_MAX_SIZE=0x40000
diff --git a/configs/nanopc-t6-rk3588_defconfig b/configs/nanopc-t6-rk3588_defconfig
index 926267f93a..978c62aee6 100644
--- a/configs/nanopc-t6-rk3588_defconfig
+++ b/configs/nanopc-t6-rk3588_defconfig
@@ -23,7 +23,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-nanopc-t6.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_PAD_TO=0x7f8000
diff --git a/configs/neu6a-io-rk3588_defconfig b/configs/neu6a-io-rk3588_defconfig
index ac281e6539..6f2765c640 100644
--- a/configs/neu6a-io-rk3588_defconfig
+++ b/configs/neu6a-io-rk3588_defconfig
@@ -16,7 +16,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-edgeble-neu6a-io.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_PAD_TO=0x7f8000
diff --git a/configs/neu6b-io-rk3588_defconfig b/configs/neu6b-io-rk3588_defconfig
index c01e5fb0d0..13b542a752 100644
--- a/configs/neu6b-io-rk3588_defconfig
+++ b/configs/neu6b-io-rk3588_defconfig
@@ -16,7 +16,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-edgeble-neu6b-io.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_PAD_TO=0x7f8000
diff --git a/configs/orangepi-5-plus-rk3588_defconfig b/configs/orangepi-5-plus-rk3588_defconfig
index 138a633f32..c8c64bdeaf 100644
--- a/configs/orangepi-5-plus-rk3588_defconfig
+++ b/configs/orangepi-5-plus-rk3588_defconfig
@@ -24,7 +24,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-orangepi-5-plus.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_PAD_TO=0x7f8000
diff --git a/configs/orangepi-5-rk3588s_defconfig b/configs/orangepi-5-rk3588s_defconfig
index 33529d4cac..d71eb7c3f9 100644
--- a/configs/orangepi-5-rk3588s_defconfig
+++ b/configs/orangepi-5-rk3588s_defconfig
@@ -23,7 +23,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588s-orangepi-5.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_PAD_TO=0x7f8000
diff --git a/configs/quartzpro64-rk3588_defconfig b/configs/quartzpro64-rk3588_defconfig
index 06c5cff3ca..99422282bc 100644
--- a/configs/quartzpro64-rk3588_defconfig
+++ b/configs/quartzpro64-rk3588_defconfig
@@ -19,7 +19,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-quartzpro64.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_PAD_TO=0x7f8000
diff --git a/configs/rock5a-rk3588s_defconfig b/configs/rock5a-rk3588s_defconfig
index c09e6655f0..a64d8a071d 100644
--- a/configs/rock5a-rk3588s_defconfig
+++ b/configs/rock5a-rk3588s_defconfig
@@ -16,7 +16,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588s-rock-5a.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_PAD_TO=0x7f8000
diff --git a/configs/rock5b-rk3588_defconfig b/configs/rock5b-rk3588_defconfig
index fc118cea7b..234bc76bf2 100644
--- a/configs/rock5b-rk3588_defconfig
+++ b/configs/rock5b-rk3588_defconfig
@@ -24,7 +24,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-rock-5b.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_PAD_TO=0x7f8000
diff --git a/configs/toybrick-rk3588_defconfig b/configs/toybrick-rk3588_defconfig
index 5a190357e4..bd33c648ed 100644
--- a/configs/toybrick-rk3588_defconfig
+++ b/configs/toybrick-rk3588_defconfig
@@ -16,7 +16,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-toybrick-x0.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_PAD_TO=0x7f8000
diff --git a/configs/turing-rk1-rk3588_defconfig b/configs/turing-rk1-rk3588_defconfig
index e6e1bda7ec..0ca33e95d7 100644
--- a/configs/turing-rk1-rk3588_defconfig
+++ b/configs/turing-rk1-rk3588_defconfig
@@ -19,7 +19,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-turing-rk1.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_PAD_TO=0x7f8000
-- 
2.44.0

