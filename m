Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6770CC47258
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 14:14:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A4E787CE2;
	Wed, 31 Jan 2024 15:14:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cOXxPKTs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DC0A87C13; Wed, 31 Jan 2024 15:14:46 +0100 (CET)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24B0B87D1A
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 15:14:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=o451686892@gmail.com
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-295f95ac74aso223639a91.1
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 06:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706710482; x=1707315282; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=zmbp+lxO4xRS7Qv6pFOhNNWPAZgqH12BmKBXw7uUuAQ=;
 b=cOXxPKTs7OAm+F/ra187I8c1zuGtsXi3/IxU7jjnEf3Ps6vifQJN7D1tYEXDbL/oSE
 i2cSyzGz1Q0+VBtFvGgkqueRh2rKKW0iyBR1bInm24jWEw9kXBZqUTI0m3c42WHDxayf
 noz3KHoVSZa04r/bAQ5KlE35sUV3jHOita2v9BFzL71iHQG1KNXB2kD1v+lvptMGfSBV
 rlP62tYq6iXU0NIuSzI/1p89v1Ybxh/ia2nvC7n158acKCINH24qXCBLjhfSTR3s+S1r
 YragWjJFkbJJ/wvzixS17XCuWwApvnJMFhyA94Gfejz1WJaxnwTCp0dtFdZdRNFYrOOy
 sX+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706710482; x=1707315282;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zmbp+lxO4xRS7Qv6pFOhNNWPAZgqH12BmKBXw7uUuAQ=;
 b=QjYDcONKjvhNkHMvTCRPeeQmV5EwQAJTH+4UqIHB1uzEluGHkhF9k/aN/c6VmphdA6
 7yNxxnl2mY0osokfT0BpzqJrLZZ34fsKdSU8O/gAOj0DQKWRGyC5lTdnXpmvpmROYPVj
 EZr3Oz4fwc6RfSi5CbKCeu7LVrpsKVPT2kfdVOYdxDEQMBwuiYuExijVpkj1VVPdMfoN
 tDewo8UwrooRA9vocP0nheAvuPp+CcO2RxC8a5ZwopGqswEqlikRkyjhO6W5d26x/DEw
 5809tVXo2mx7TW80N9Fz2Pv+MnPS/SFIXDv7268kj5vIbuUieWJ/Mzto5iAOWG/iAgpi
 k5hg==
X-Gm-Message-State: AOJu0YwdO13oJMHlR27KS6ioncklx/pKPPcCRVzDmDS5XUx8TuDQ0MyH
 k5c0rG7QD20nKG+6MLolWQ9Yp5aVYBAMoPFFsPxP5SyVeUIRE/PY
X-Google-Smtp-Source: AGHT+IHcsnDz6P2jX5d8MPF5UdZeNTrAZDkmlXz5vJTtqwmMF5dzKesymXaOwtbeCnzuJhrrEe/v9A==
X-Received: by 2002:a17:90b:ed4:b0:290:6e2:1ee7 with SMTP id
 gz20-20020a17090b0ed400b0029006e21ee7mr1815765pjb.46.1706710481604; 
 Wed, 31 Jan 2024 06:14:41 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCWAT+RHApB2VLVLvghS3ZS+8AKe8kWRYVED7Q7EotMXroh2oSNuPPkxTFhJ/v6gwbJkkC9uXyb6B89mQ6Wml+G2+dxFgKdkvN4ZMkGaZsUOD98TrfZnmbGWhMXV2wJdTk47lNEpUxh+wxoWvr+0JRmhyNITF82+Jm1BoqCbFSxQ2nSHeh55yEMmdP3nILNOIycaPeSwK15rwK5XMHcdQ4ff24LCFspxQzi0a86acAOMwHfhHfEeaIknPZsYIrVuzDLysg/XzYIwXTZ6ogIbVlC2o60X1Q1mGz0RhjMzPeXO3pjNmlXAPOPhJ+P2upE1PINjFK0Lo79X1gvCZiBuW3Lo0eBbhIfVlVIg3dzCKSD74MENIqrn+/APiQ==
Received: from ownia.localdomain ([8.210.91.195])
 by smtp.gmail.com with ESMTPSA id
 mm3-20020a17090b358300b00295bafadb4fsm1534954pjb.57.2024.01.31.06.14.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jan 2024 06:14:41 -0800 (PST)
From: Weizhao Ouyang <o451686892@gmail.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Weizhao Ouyang <o451686892@gmail.com>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, u-boot@lists.denx.de
Subject: [PATCH v3 0/3] Random Number Generator fixes
Date: Wed, 31 Jan 2024 14:14:23 +0000
Message-Id: <20240131141426.34926-1-o451686892@gmail.com>
X-Mailer: git-send-email 2.39.2
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

This series aim to fix smccc bind issue and add a list command for RNG
devices.

Changelog:

v2 --> v3
- remove fallback smc call
- add Fixes tag

v1 --> v2
- check SMCCC_ARCH_FEATURES
- update commit message and rng help info

Weizhao Ouyang (3):
  firmware: psci: Fix bind_smccc_features psci check
  driver: rng: Fix SMCCC TRNG crash
  cmd: rng: Add rng list command

 cmd/rng.c                 | 23 ++++++++++++++++++-----
 drivers/firmware/psci.c   |  5 ++++-
 drivers/rng/smccc_trng.c  |  2 +-
 include/linux/arm-smccc.h |  6 ++++++
 4 files changed, 29 insertions(+), 7 deletions(-)

-- 
2.39.2

