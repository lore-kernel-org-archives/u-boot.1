Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3494C54734
	for <u-boot@archiver.kernel.org>; Tue, 27 Aug 2024 14:21:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A423188363;
	Tue, 27 Aug 2024 16:21:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="PnKgqmI3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43F4388A1B; Tue, 27 Aug 2024 16:21:25 +0200 (CEST)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D0E988753
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 16:21:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukasz.czechowski@thaumatec.com
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-533461323cdso6338330e87.2
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 07:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1724768481; x=1725373281;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=txIbHRFGHjd72HIGU/+wubRrmZkpV1UoWE754Mkw3KY=;
 b=PnKgqmI3+N7klIgd627YAt8SWFN6RmYQZX6qVNvZygCjrwKYIkwOdMzLItNsbkzJpE
 n6SVeiLC4QzMbUvg3UAJoBeQ5S9qQWAznQ360xCQ4nytFeCK6fuaPvsMpw/tYSe/kwTr
 +oVE5fgMYH0/MEcwCvYimyPnuuio0Tk5qGxy8jcJsyPaBvwKMIvfEqte8+STFwlv5pMP
 +DDhuDPbacvMJTjy13f6RMvYhDAz5702ZVEhZml85/9MAKUrrV1Zt+RJMIWiJIYcTHBP
 8xbKL/qJ+yA9NXl+5j17fAJOMAgQTnKJYzuyE50Mr4mvkmfpe4PH1q3HIkpM3cMi215f
 Fixw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724768481; x=1725373281;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=txIbHRFGHjd72HIGU/+wubRrmZkpV1UoWE754Mkw3KY=;
 b=qbOstqy5R33Lnllzy2gMGC21LExPy9V93zXC0p3WWHgN0VXjsXvVhithJRByFCN2RC
 WKLyeic92A33uTuqhHwcgpjv4WZrFcJ5/Lq5nQJ/dnAgahp9Os0pLqIe00Qd303n2ToU
 kds7NgzYIWnWwlXcBodziqCfEz9X1ppwPgcVeVVtygm8hWTjCwLZns8UBojrgNW/a61V
 4ncmXYKwaoXtTBtZRNZd5Ii6/2cXaObzl6CGmO6Jo3AA+v/NT3yM3TNKfkhnSQbZeSXD
 +0WXH57q38CM9w59rfU6pOHtWb1ZBUTgkP34pWqia3E3SlKR+bcyOVaCXpYyu5bfVj9F
 Nsjg==
X-Gm-Message-State: AOJu0YzOVeebZROYrQUfsvEib2gXutzXRjBSPLNQQQBIOt7Cr+CSAtDI
 3kaawYYhqSk55LpSdNOsNqL4aJThERkU1u4iHczV/iaFDgf5RyA8HWd6PV7xpGQO5vyGQ6vl0VO
 R
X-Google-Smtp-Source: AGHT+IF8Dl5wxZPYtw6q+FhtG85Bqxccx7urop7I3gTRJyhQNCJ2ZK1rhlllRANbqf7gi3lGHcabCA==
X-Received: by 2002:a05:6512:1111:b0:52c:def3:44b with SMTP id
 2adb3069b0e04-5343883a2ecmr8020459e87.31.1724768480954; 
 Tue, 27 Aug 2024 07:21:20 -0700 (PDT)
Received: from localhost.localdomain ([91.90.172.13])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a86e594e809sm114854366b.219.2024.08.27.07.21.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 07:21:20 -0700 (PDT)
From: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, philipp.tomsich@vrull.eu,
 kever.yang@rock-chips.com, quentin.schulz@cherry.de,
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Subject: [PATCH 0/4] Rockchip: Allow to silent TPL/SPL debug console
Date: Tue, 27 Aug 2024 16:20:54 +0200
Message-ID: <20240827142058.594556-1-lukasz.czechowski@thaumatec.com>
X-Mailer: git-send-email 2.43.0
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

Currently it is not possible to completely silent the debug console
in i.e. PX30, what might be required in some embedded devices
Disabling DEBUG_UART results in errors, due to missing symbols.
In particular, rockchip sdram driver performs calls to debug_uart
functions (i.e. printascii), defined directly in serial driver.
This patch series fixes the dependencies in Kconfig and provides
dummy implementation of debug_uart functions that are linked in case
serial driver is not used.

Lukasz Czechowski (4):
  debug_uart: Replace debug functions with dummies if CONFIG_DEBUG_UART
    is not set
  ram: rockchip: Kconfig: Fix dependency of RAM_ROCKCHIP_DEBUG
  rockchip: Kconfig: PX30: Weaken dependency TPL/SPL serial
  arm: rockchip: PX30: Fix hard dependency to DEBUG_UART_BOARD_INIT

 arch/arm/mach-rockchip/Kconfig |  5 ++---
 drivers/ram/rockchip/Kconfig   |  2 ++
 include/debug_uart.h           | 16 ++++++++++++++++
 3 files changed, 20 insertions(+), 3 deletions(-)

-- 
2.43.0

