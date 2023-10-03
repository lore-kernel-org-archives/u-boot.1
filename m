Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B66CE7542B
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 06:21:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC6A8871DE;
	Tue,  3 Oct 2023 08:21:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="js8pB4qO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4E16871BE; Tue,  3 Oct 2023 08:21:45 +0200 (CEST)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0351186E15
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 08:21:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2c15463ddd4so5498031fa.3
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 23:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696314103; x=1696918903; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=n5eqrGWDLFDu8LlztOJbrPA60JTfTsvrYKWRHN1XgxM=;
 b=js8pB4qOVPiVb3fHmIagU6MOtcrJZrXmdIvYfy6POq2+GOflR7Jby5ytDmnptKUC82
 1Vk9KVY5e2vyT8rVy5VEarmEslXk4IgXhqJMYiC8FkAiE+AkZus63MHXrNEtVcnA3bHN
 +VSaWvtrr+b0+lua7VbkjqF6vIJCiISPEyqVepawjxR886sqdgljt4cKwYNFav/+nmo6
 trfhPILFNrCDJJks4Z5zx7fgQ0qQNcAwT8Zm344t6uM4nLLyYVx3VIUbu3MGrLq7TjAp
 vjruvPaZAKZRrWsY+iFtEt2iHQ1wdgPIi4unC0g5RjAPK39oGeMiFOgme4ZxXQP9zQpt
 dofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696314103; x=1696918903;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n5eqrGWDLFDu8LlztOJbrPA60JTfTsvrYKWRHN1XgxM=;
 b=JhPEfS4Oi01TOTN+2Nf6tAjJSPTcNYyGjaptG3XdbdcsDbqGKxPI0yvZ5uHQp7UOSi
 9ziPgkK/Lh2AwRIAnWR3mnVa0/xnGAGg5EVigS9tKeDBSaOmOfiI6krfk8RF6HoXVl87
 HvflKu1P8AFz8hvxCcgyHAmt4vcgiqZALOTTNz90srekxKTOmVk8tVXHgM2PVYatvs8W
 bkS1SdEYRhJGvdAQfwQD/5AYAvgBXcw+/pvgGW3prbldXQgKMCVidVf8IqGNdD3M+7Zg
 mC9a8j6hwSyw+am/uXvh7O9xgxpV7kVr2jr6b1Sn93GVLzM0cKZGHGSTVhSDnwTrdOz/
 x4NQ==
X-Gm-Message-State: AOJu0YwRJ+mDwDIv8pznTzPbgwy+voAfGjB9o34YG7dsDJcYoo02X3Dv
 UZElScUEmsIB3VbYsEvR/oI=
X-Google-Smtp-Source: AGHT+IHuZqr3XhSC6v2R6OSuZ6bMi0Ofbu6/BM9gPw4YACSXDyPKfPuvNJU9ITUdrkhO27tuey/yEw==
X-Received: by 2002:a2e:8450:0:b0:2bc:e2bc:81ff with SMTP id
 u16-20020a2e8450000000b002bce2bc81ffmr11514622ljh.51.1696314102947; 
 Mon, 02 Oct 2023 23:21:42 -0700 (PDT)
Received: from xeon.. ([188.163.112.76]) by smtp.gmail.com with ESMTPSA id
 n4-20020a2e86c4000000b002bfba0d26bcsm103594ljj.8.2023.10.02.23.21.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 23:21:42 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Jonas Karlman <jonas@kwiboo.se>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 John Keeping <john@metanate.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v4 0/4] General regulator and pmic uclass improvements
Date: Tue,  3 Oct 2023 09:21:22 +0300
Message-Id: <20231003062126.42026-1-clamor95@gmail.com>
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

This patchset derives from discussion of TPS65913 bringup and aims to
cycle all regulator management inside uclass removing need of any board
calls for regulators.

My hw setup is Tegra 3 LG Optimus Vu P895 (PMIC is MAX77663) with native
spl u-boot build.

power: regulator: expand basic reference counter onto all uclass
Commit is basically expansion of 4fcba5d ("regulator: implement basic
reference counter") onto all regulators. My testing on hw has shown no
issues so far with both pmic regulators and fixed regulators. Counting
works as expected, dm test is set in test of regulator_set_enable_if_allowed.

power: regulator-uclass: perform regulator setup inside uclass
All regulators with always-on or boot-on are set to probe after bind
which ensures that essential regulators are set. In the post probe
regulator autoset is called so that correct regulator state according to
device tree is reached. DM test is set by checking regulators data without
pre-configuring them manually.

---
Changes from v3:
 - no changes, re-sending

Changes from v2:
 - dropped changes related to pmic (pmic regulator probing on pmic post bind)
 - regulator uclass changes are dropped to minimum to remain compatibility:
   - always-on and boot-on check is moved to post bind
   - regulator_autoset is called on post_probe
 - adjusted dm tests to pass with this changes

Changes from v1:
 - adapted description of regulator_set_enable
 - remove uc_pdata->enable_count from post_probe
 - added tests from counter and regulators post_probe
---

Svyatoslav Ryhel (4):
  power: regulator: expand basic reference counter onto all uclass
  test: dm: regulator: test counter in set_enable_if_allowed test
  power: regulator: Perform regulator setup inside uclass
  test: dm: regulator: provide test of auto setup

 drivers/power/regulator/regulator-uclass.c | 71 ++++++++++++++++++++--
 drivers/power/regulator/regulator_common.c | 22 -------
 drivers/power/regulator/regulator_common.h | 21 -------
 include/power/regulator.h                  |  2 +
 test/dm/regulator.c                        | 27 +++++++-
 5 files changed, 92 insertions(+), 51 deletions(-)

-- 
2.39.2

