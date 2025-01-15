Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 408AAC02180
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 05:37:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B8368060C;
	Wed, 15 Jan 2025 06:37:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CXjE22+i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8296D80657; Wed, 15 Jan 2025 06:37:19 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E91C580214
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 06:37:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=cnsztl@gmail.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2166f1e589cso135539585ad.3
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 21:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736919435; x=1737524235; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Z0Z6+io0CwIdWrwkJNL+et/nskeSXXgrkNUmglTxlMw=;
 b=CXjE22+iGbDXeo1lzMLY3XpNZIgtWmvhq40lVajvEqF9Iz9PzcB4usO4GYMtxZXOO4
 RVUfIxFehRRY0ydKhHqMZhw0I6PMxbzTjrUCKDCOwTTTYSocJOqGUD65+LjUV0Iqa2DN
 18Ku7E+4nnrCluwK6C158GS7L2OyvmbeocmtMc0eXpKFS/edP70h9W4+Lhv5c3+dYQA6
 oGVmq30MgW0Qbb1X70aJwQvBY0j4DtMASOKDNzUu24XsJJAieP365gIubaxqhvWGxniD
 O3hNJkSvQg4N3bU5Jxvzv6tRjc7ogz4Zz8FfNUlCBIhTzLegv1GZSVAFKRKtqF8QGtJe
 1KFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736919435; x=1737524235;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z0Z6+io0CwIdWrwkJNL+et/nskeSXXgrkNUmglTxlMw=;
 b=exixji2Bf5iKnkV/7/JJH/zCzdc1I9PZ79gKO0usdDkTrJkXkTWxyIP6O0TKMVSMEn
 TPr/sx9lHf+KIQkgmuM1vCLo1PSNGUv7yoB3irf9zng59En+uMhosCTOC6hR2mBhLLBb
 28d5jqa700KlC2lsf3zk/mIbV+wy6CWdU4hIgCaJVELKBMNy/I/OccbvEzlf0Aet/6vv
 vt4OBcVfOjFe9FyBxRAk5ksE9JWggym4WC3RT3C6Dyhv1iZlyi+PfEP4d1qPdDsGde+K
 Y70vctPQnLG5qgb3oSCogVEmYOJvUC7qhpdmLz4vnepj3MzlsPVtoeCFr6ceS/f/2zHm
 WJ6w==
X-Gm-Message-State: AOJu0YzMxZMwD9NK9x+SkrT1+Dqqhtx8sQn0do6H9jfirpIcYZzluP7o
 5uUnSsIs6ZFuaO9DfKZBkYlOmnJKA3je9Q5U4BX067/3tqasFnPW
X-Gm-Gg: ASbGncsm+T+0/0AL+FwL0CYLK09zl21FuLZdkVccp/+n3IsI4hDwm2FqjmqXL4F0Q64
 lre5SSb5kAIZGYK5e+SbCakOsHJyXMaXrkgk4oJSOMXkRfGLP9qOHt5+R/xU5RNYL9XoHILOkQ6
 O2KGJdp6hj8/VL+SaTcjuhZq3Z5JwZ0MLSMgNyPMAUupZkQvD8SjHzRa7vyP5CVTUNzNQ0TqTH2
 p/lO+Qg271gXzoUzR9OgklR4zeeAiiWSgS982leZlfZwPgb0xG/ZpHuat4=
X-Google-Smtp-Source: AGHT+IHxLXW/1RQLVgbNbYn6IPAGWeaK+8Ch/6D01U/EFTcjkVI5wZ+w2ezwcW1YssCDYT8s5ra2GQ==
X-Received: by 2002:a05:6a00:170a:b0:725:d64c:f113 with SMTP id
 d2e1a72fcca58-72d21f18064mr42426913b3a.3.1736919435080; 
 Tue, 14 Jan 2025 21:37:15 -0800 (PST)
Received: from CNSZTL-DEB.lan ([2408:8362:245d:4738:bc4b:53ff:fead:2725])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72d4056a5f3sm8669003b3a.58.2025.01.14.21.37.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 21:37:14 -0800 (PST)
From: Tianling Shen <cnsztl@gmail.com>
To: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tianling Shen <cnsztl@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de
Subject: [PATCH] rockchip: nanopi-r3s-rk3566: disable unneeded CONFIG_NVME_PCI
Date: Wed, 15 Jan 2025 13:37:05 +0800
Message-ID: <20250115053705.911296-1-cnsztl@gmail.com>
X-Mailer: git-send-email 2.47.1
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

This board does not have any NVMe slot, so disable unneeded
CONFIG_NVME_PCI option.

Fixes: bf4a33e725ae ("board: rockchip: add FriendlyElec NanoPi R3S")
Signed-off-by: Tianling Shen <cnsztl@gmail.com>
---
 configs/nanopi-r3s-rk3566_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configs/nanopi-r3s-rk3566_defconfig b/configs/nanopi-r3s-rk3566_defconfig
index 870613f690af..16e09753a72d 100644
--- a/configs/nanopi-r3s-rk3566_defconfig
+++ b/configs/nanopi-r3s-rk3566_defconfig
@@ -54,7 +54,6 @@ CONFIG_PHY_REALTEK=y
 CONFIG_DWC_ETH_QOS=y
 CONFIG_DWC_ETH_QOS_ROCKCHIP=y
 CONFIG_RTL8169=y
-CONFIG_NVME_PCI=y
 CONFIG_PCIE_DW_ROCKCHIP=y
 CONFIG_PHY_ROCKCHIP_INNO_USB2=y
 CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
-- 
2.47.1

