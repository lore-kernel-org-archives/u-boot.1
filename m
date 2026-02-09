Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46418E7E0D2
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 18:40:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC9B583C91;
	Mon,  9 Feb 2026 19:40:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AVaqVF9l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75C4883D07; Mon,  9 Feb 2026 19:39:59 +0100 (CET)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9199283C67
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 19:39:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-382f9211cbfso29417171fa.0
 for <u-boot@lists.denx.de>; Mon, 09 Feb 2026 10:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770662397; x=1771267197; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=aaLjalj6wp1DNvXOq7biU7TqzybLnBD4VZLcHxJ/WJo=;
 b=AVaqVF9l+9OFb3yRPNEkfHAVUZfPYLw+K2FU7m5VOLjfg0KTCU+j7vOTxGHh2gdlbP
 FZ5Nzhy0MWVBNicUA5NyWX9BEpGmdHJItbkMHth9M6MglLiCLwZ+BhQ75m+u9K9nWgAL
 RwcyzH6NErwnh7SCuRhuQqCbYBks0igCgty9TI2dvoN/DYDtKEWL46pSjs7sS5FOtRxC
 0IfNuRMP41itB/MxPVpHuSNfv7dwVL7NT/fSK2+pQm6qry86Ghm/T9PjeBzLeVQjMTbL
 75b27EVkTQZxAXvrjWG2tOSO7X7z2XzDZzhQYzs66ZrrddKBl1UZHsmDKVDcFG7HRKlW
 ibvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770662397; x=1771267197;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aaLjalj6wp1DNvXOq7biU7TqzybLnBD4VZLcHxJ/WJo=;
 b=mGiUqkAu0C2VV6q0zhBeR5iQsfPxqbwlA6O1z/jlP1k4NGN4wsf2fxBCiewZW3KykD
 SHuT9MYjZu1LvXSpvpxVEg6FOvYCymc0QcxPSYOIb7yQngU8ArcuVWxDYpVbt4T8Gv7C
 JJvIe+Yd+o0HpKUpZ3KxTZlTVA251IwqxtV9WVmtpeEJVeYoo/i+34kO6Kt97FCRss7t
 J497uhTdMIDzl/UHHy40xGCqEYNQwu6uvut34XakReB8KDq/7+qVz2z0gjW9pCONIKfB
 4AqhzUPgK8W1IDuDe8zck1DyIfIqhn7gfomP/vcV4tScx67lg6KNjWgNOdUgc2I7hP9Z
 dg+A==
X-Gm-Message-State: AOJu0YyPHVZi0Mq+srylm9ggGOl+QRmuDAzusmtJiHgILF23jSv9odpK
 9z4UGcFIUHsLhLNcf5biXu+KVd0Z1Ba2VSiJRClnM6JNOn2Fkq2EmIzV
X-Gm-Gg: AZuq6aLoLBkSZlCnSarxcIAeYByjtLYOiUWtBjRJZWYU4sdTE0ihoYjDO//3xwuqrZZ
 8ITDSo1JHU+fEJ07oeOLzWgrLain+/B2E//kU7FjBeRSPWl/2vFWMJvRuv5Ga0h74oYk5XsSrgU
 skh7ZH/i+qDCZXKRJ6SWHVvR4qnCwaPZhWX+re3HGiHdTA6C8kddXCpr9k7SX+URXhdl71ZLcfv
 4go2Ye4Oktfzs4spRGSWtls7uXjQBXn4rPY9nuWNCcNtSsCcFItoYAupZqJz0BQ47UYfZmas3n2
 Qp0pmSMnm/aZTqhV2EzR3XdOCY1hl0CVThf/n5n4eXhjBnn6wS8Gxh1uwpwjQVv0nN8FFdAvQIN
 2hFFbgB6bRIYTl4yumvsTNzyc1F0ZPswmz4q2YqDQ21UBkIVYx6mwFgiAg4LBvMkGzygRMpLP8i
 Ou
X-Received: by 2002:a05:651c:3048:b0:383:1737:5ae1 with SMTP id
 38308e7fff4ca-386b4ed29e9mr37346361fa.11.1770662396507; 
 Mon, 09 Feb 2026 10:39:56 -0800 (PST)
Received: from xeon ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-386b62363a9sm26554891fa.9.2026.02.09.10.39.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 10:39:55 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 0/1] power: pmic: enable sysreset function with device tree
 property
Date: Mon,  9 Feb 2026 20:39:47 +0200
Message-ID: <20260209183948.34807-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
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

Add a condition to enable the PMIC sysreset function via the
system-power-controller device tree property in addition to the existing
Kconfig dependency, provided the PMIC supports it.

Rockchip change can be removed if required since rockchip seems to use PMIC
in the SPL stage too and at that time device tree may not be available.

Svyatoslav Ryhel (1):
  power: pmic: enable sysreset function with device tree property

 drivers/power/pmic/max77663.c         | 4 +++-
 drivers/power/pmic/max8907.c          | 3 ++-
 drivers/power/pmic/palmas.c           | 4 +++-
 drivers/power/pmic/pmic_tps65910_dm.c | 4 +++-
 drivers/power/pmic/rk8xx.c            | 4 +++-
 drivers/power/pmic/tps80031.c         | 4 +++-
 6 files changed, 17 insertions(+), 6 deletions(-)

-- 
2.51.0

