Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34B2BC47258
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 11:12:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DEFF87BA1;
	Wed, 31 Jan 2024 12:12:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nsvKnngj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A227D87727; Wed, 31 Jan 2024 12:12:40 +0100 (CET)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8910A87727
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 12:12:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=o451686892@gmail.com
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6de2735151cso1997755b3a.1
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 03:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706699557; x=1707304357; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=f8Empo1aoOcGERYd6j1UR9uibTMEMCWJTtTRX7feB7w=;
 b=nsvKnngjW/CbdVi5QQi6eIdoSTXJ1i3e6MTEorXQj/BgtmhG24xyfQgN52/Fns0yGA
 re6ie7NsIs+NmhEB/FB+xY+mrshmI/yKtKnfNYXjSCoKUAO1dAcdHel1LrwPcJui0b+A
 K0A6KwSwGNKWLf0Mg5ZDnub03Y0BAR6ZHL0VeNIyjB7BMbpN02GEtq9oHrtmISsbTApH
 eAQ74PO8i3xISaevhI2vNP/pDzGvliVHCFVY39Yt2y5/27cRWqglKJ9ktvo81YAnRI+f
 W5q8qB/mVID9xtYjhAjEskAKHIOfyolmArGMUWPce/r2BJlXzdmVuAkEUXpbZOtxgpAh
 i7JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706699557; x=1707304357;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f8Empo1aoOcGERYd6j1UR9uibTMEMCWJTtTRX7feB7w=;
 b=INNolECS26Zvuv3/AYJmnfowdSQKOvuHl2/v8SttFjs0i3si7HNDZCN4AimjGTipAy
 AF3Zcj4qyO6mlCSZqXqRqEHrWbCC1FC7EHhGrwQAk0Q5tIzSP1qkEGtzaPuet7byYhr5
 K1LFnVnqx+nFVNRcDqOZav5zZ1e/vThAhJaA3erafN5CmFbX4+Cyg6KUeeXYYesYJFrT
 tC4rvnIF1Ptn1bR22gk/8kT/3eNusNTZYBGI8wMLlV8POI8BQY0QzMcO6foQPNlcAFKL
 2hpPXCXS3Ck8b09RlFCfjZ5R9nKvdCZw2laxvZQgCi+rlKV1ENI7kV9OcL+9bcs8Qnut
 XctQ==
X-Gm-Message-State: AOJu0YwcF5Q9Kmr/EeOAwRO04x9i5gpfIMc4Yg/uYQPhQHJJePvzguXB
 ctWVOZZGtDAeeyfrkcb+CkGtK8pyTuPrHCI+uWHw8r8qRPFBUkoY
X-Google-Smtp-Source: AGHT+IE3G0MNxvWs7P/BCbcl8etaNpUiK5ksa7K7+bORR7iFEGTv+mzYvtS1Lpvje4+lsGMtN0kHLg==
X-Received: by 2002:a62:d402:0:b0:6db:83c8:453a with SMTP id
 a2-20020a62d402000000b006db83c8453amr1168670pfh.23.1706699555877; 
 Wed, 31 Jan 2024 03:12:35 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCV7HPauw3eMRJ32jn+hC1+ZhBfjHBgeW7FV+zxqxg2BKXO2F56bBffZApeMlIAdGIZ8Xmq7Bh6E2mS/Lwf2nOwz4QtdCRghC2WLfRQXoL+7z0QoBcmdQro5ntadZFOVHKNwjn0dby2UT1qsh7xlDZxQ/LvACHmdJehunHtaNdwDzg0wDWBvb/oy4iejZx7cT+mmVr2r1gLnDIxnUe1J283UEvv5K7hDPJVFxbBtHb/Loo7VKPczZw3kjO/+WgbyaWfNbJhvndhOP6RPaWCJbTX2uW1+ETKDDx7mx4Jyks4CIaugbxNCb2R9kqgsua50zkk4tytJpzvl8p9ASg==
Received: from ownia.localdomain ([8.210.91.195])
 by smtp.gmail.com with ESMTPSA id
 m1-20020a62f201000000b006ddc03c425bsm9535007pfh.180.2024.01.31.03.12.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jan 2024 03:12:35 -0800 (PST)
From: Weizhao Ouyang <o451686892@gmail.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Weizhao Ouyang <o451686892@gmail.com>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, u-boot@lists.denx.de
Subject: [PATCH v2 0/3] Random Number Generator fixes
Date: Wed, 31 Jan 2024 11:12:14 +0000
Message-Id: <20240131111217.30124-1-o451686892@gmail.com>
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

v1 --> v2
- check SMCCC_ARCH_FEATURES
- update commit message and rng help info

Weizhao Ouyang (3):
  firmware: psci: Fix bind_smccc_features psci check
  driver: rng: Fix SMCCC TRNG crash
  cmd: rng: Add rng list command

 cmd/rng.c                 | 23 ++++++++++++++++++-----
 drivers/firmware/psci.c   |  9 ++++++++-
 drivers/rng/smccc_trng.c  |  2 +-
 include/linux/arm-smccc.h |  6 ++++++
 4 files changed, 33 insertions(+), 7 deletions(-)

-- 
2.39.2

