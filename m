Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC0EEC48260
	for <u-boot@archiver.kernel.org>; Thu, 25 Jan 2024 14:05:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06D5A876A7;
	Thu, 25 Jan 2024 15:05:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BZ5JrUGB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66AE3875FC; Thu, 25 Jan 2024 15:05:36 +0100 (CET)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53C4487447
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 15:05:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=o451686892@gmail.com
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1d75ea3a9b6so35842005ad.2
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 06:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706191532; x=1706796332; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=SsKxPiftVH2kq5bjTW/mjM0D5nFde6Gh8xr0vhsSeV8=;
 b=BZ5JrUGBCdxHQOliPuyrxmKmLxud3/648aGKfcTD4uCE30byqvJ+I+rZqDTkx15I6c
 wkJ3EW11c0qw/cXbkcK33fiyZnoRIOaed6jFdNxV4C1GIqB41Sj2b/IH+MzfujhlGkGl
 l9LP2pi/rOIYVCnBgA+p5AFEls2tSd9gXjgcPQTi/DDmsm9calYV6hsZNFDkJ2+KcnKh
 U8YuJenPKDv79tNE7pkXpHFzENVMuaml85B/38VB3AJnNAMfr6a+rgDSjdpkZ/q8HHHY
 Z+o00C2rDySWuG2sApwZR3rwAj0+PLx2Nd1ocvFVGEMYeAW8rK7297SVfWZMBcA+rL3w
 VKHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706191532; x=1706796332;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SsKxPiftVH2kq5bjTW/mjM0D5nFde6Gh8xr0vhsSeV8=;
 b=cItnOflIZ7Nsp48/gBGXzqKWakgb1EcfuP11hPIdr5lBaq6/bTLzmj2FcuzEWJ75uX
 GhsAyzdYE+uvK6rBcAgI5MHqMrsElpyvwkeoxqDF5DrWPVS33aQ8fpudkB++KYH9BoO4
 LUKNEZJgBN4KK97OmWAWBNmbEGrC8Ik0hMoqUxkcVFVlisP4UBBPTrUVkObhh0jZpoFD
 Z8xp5bLJNSamHcibPrZMnbR0o+W9tQJGz7MadF5c+uUOlqgdxyFFmWpY/pNsrigNm2xk
 9nDxAh4v84KY5zpm2oVMPkdujHJEzWC+0joV80yGhnYMRhCTEvhJgDdUXwQpuFWhF4lB
 f4QQ==
X-Gm-Message-State: AOJu0Yz8jbtnWXYYEzQUzMe5/w1uUUjkyE35NylPQrx8W4YLbTibymEG
 RnYNtHlCyoezSJsJUuQvEdtoB3urBlYum2IrwLD1HB6eYfAfiiUF
X-Google-Smtp-Source: AGHT+IG1hWX940GUJipCdVbA+vlQJpOOlfDhBOGjDxNrFSvp2m3zGaKnqKr9Vry2SVi/YqCw6Y1/Sg==
X-Received: by 2002:a17:902:e805:b0:1d7:8541:f914 with SMTP id
 u5-20020a170902e80500b001d78541f914mr1331462plg.26.1706191532016; 
 Thu, 25 Jan 2024 06:05:32 -0800 (PST)
Received: from ownia.localdomain ([8.210.91.195])
 by smtp.gmail.com with ESMTPSA id
 p18-20020a170902ead200b001d705836d0dsm11925699pld.200.2024.01.25.06.05.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jan 2024 06:05:31 -0800 (PST)
From: Weizhao Ouyang <o451686892@gmail.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Etienne Carriere <etienne.carriere@linaro.org>,
 Weizhao Ouyang <o451686892@gmail.com>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, u-boot@lists.denx.de
Subject: [PATCH 0/3] Random Number Generator fixes
Date: Thu, 25 Jan 2024 14:04:59 +0000
Message-Id: <20240125140502.22400-1-o451686892@gmail.com>
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

Weizhao Ouyang (3):
  firmware: psci: Fix bind_smccc_features psci check
  driver: rng: Fix SMCCC TRNG crash
  cmd: rng: Add rng list command

 cmd/rng.c                 | 15 +++++++++++++++
 drivers/firmware/psci.c   |  2 +-
 drivers/rng/smccc_trng.c  |  2 +-
 include/linux/arm-smccc.h |  1 +
 4 files changed, 18 insertions(+), 2 deletions(-)

-- 
2.39.2

