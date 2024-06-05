Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EF1DC25B76
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 19:37:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4DD588354;
	Wed,  5 Jun 2024 21:37:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZjC6gWza";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BE4886F6E; Wed,  5 Jun 2024 20:10:49 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8D78876D3
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 20:10:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vassilisamir@gmail.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a691bbb7031so17533766b.1
 for <u-boot@lists.denx.de>; Wed, 05 Jun 2024 11:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717611047; x=1718215847; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OgvIVkhNDeCxbx69AkbToQjumF3TS66kdGDWpG9yB0E=;
 b=ZjC6gWzaZRcyjZz1QY+hexihrxFRUlLzuRnDgrR2k9GMrlInq7vZ3Q/4gUpILVORAV
 yvFq/zyCUjQiKIDq8pM2HkxfNcrCAHhZp56q4EnwF6u9UEl3vkOWh9VPmaGkvBM0BBSU
 at+9/kN4HSJ6KortSiNP9JypZB+bclI09xhNtYOLcjWxObXK4Lqt+mFjt042xCxzlJQ6
 LsEV+/Mz6FCVe8LKZ9U53Q/pYB5vjqGHjs7nuYabjtf0GUNPIiVgTVUhufUMgC4Z+1rV
 378A1dYKPBbGktSRJIBGsn5VOqeY6hisE0YEWsuoY05dqpTr3bruTBgsxjDCUTGhp1t7
 soXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717611047; x=1718215847;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OgvIVkhNDeCxbx69AkbToQjumF3TS66kdGDWpG9yB0E=;
 b=h9HH5MJL86tJ1T/aHTXcxb0G6LAO4L1g19ZjcOcBdgC7NmjAYaMxNTE00uKRa5QWMd
 G56Yycw1ojWbPMzpgNOTd1jCrjqqBl1LtJ9I47yKWd65sP3JVRMlRTaEDgkqnjHDUG0g
 /rcwvLclD0Y57kwJiq2rjYR2laz1gdTZPE2jNRUlwMm583Z6+WqEJOONFHEgOlNOXYQX
 KfjhhB90PrYHXOIWP8mU9QuzmiI32FTRIB95IDRH2nPYiWI65NXLwXZE3BnUd5o9hzem
 lzxtQDZKcI5W5mMJwc6LI1QbcvHzcEmudMNJUfUzuZwg4O8seQfs7kn3D5zUtoZRxyVf
 o1EA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUX5HTRJnqVpkDNhoLBEwLwhBaNMeMtTaQzKVEhhnprG5V8luOO8Y5Mym6h+HteCgmO2L9sb+A+eVO6p3W+DGXtsQTjEw==
X-Gm-Message-State: AOJu0YwUpgg1mjavCUcEWogVdA/3vm4pzBzuB58GSySe2sM/gHlhEl4V
 9Q/A8v6IwoT6wNKfltXQSsOPEOzfy0lrBhxelMC/gpTCeelqlXS0
X-Google-Smtp-Source: AGHT+IE3lkSxPsclfTsewGK3P0K9rTlm12Ke/m3rISOWBSDDtx+EOVcOOCZpXf2VaEVsQom9dkM5Kw==
X-Received: by 2002:a17:907:760f:b0:a68:ae1b:dae7 with SMTP id
 a640c23a62f3a-a699f671cbamr235341166b.30.1717611046865; 
 Wed, 05 Jun 2024 11:10:46 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:e157:757d:63e6:8b22])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a68a2fc6efesm701399766b.161.2024.06.05.11.10.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 11:10:46 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: trini@konsulko.com,
	hs@denx.de,
	pro@denx.de
Cc: vasileios.amoiridis@cern.ch,
	u-boot@lists.denx.de
Subject: [RFC PATCH 0/1] drivers: bootcount: Add support for FAT filesystem
Date: Wed,  5 Jun 2024 20:10:40 +0200
Message-Id: <20240605181041.68317-1-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 05 Jun 2024 21:37:35 +0200
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

From: Vasileios Amoiridis <vasileios.amoiridis@cern.ch>

This patch adds support to save the bootcount variable in a file located in
FAT filesystem. Up to now, there was support only for EXT filesystem.

The reason I put this as RFC is because the file "bootcount_ext.c" will no
longer represent the implementation for the EXT filesystem, but also for the
FAT filesystem. Should it be renamed? If not, wouldn't it be inconsistent?

Cheers,
Vasilis

P.S: Documentation has not been modified yet, I will submit in the v2 (if any).

Vasileios Amoiridis (1):
  drivers: bootcount: Add support for FAT filesystem

 doc/README.bootcount              | 12 ++++----
 drivers/bootcount/Kconfig         | 49 +++++++++++++++++++++++--------
 drivers/bootcount/Makefile        |  2 +-
 drivers/bootcount/bootcount_ext.c | 18 ++++++++----
 4 files changed, 56 insertions(+), 25 deletions(-)


base-commit: c0ea27bccfb7d2d37fd36806ac2a2f7389099420
-- 
2.34.1

