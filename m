Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDA87C48BC4
	for <u-boot@archiver.kernel.org>; Thu, 15 Feb 2024 14:40:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1413487A80;
	Thu, 15 Feb 2024 15:40:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RXrwMv43";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3C2686F67; Thu, 15 Feb 2024 15:40:45 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 752BD87D6D
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 15:40:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-410c804e933so6890845e9.0
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 06:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1708008035; x=1708612835;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=NB4ta5gxmIWsPbziaps4DanaxPwkfEfKtnQvF9qBh4g=;
 b=RXrwMv43ahrKDiyr6nKyE6LHcycCSZVp62ya5uvHE9vckzbuUtlcGaXsnLFOlwXQc9
 4NaoXiM0E1uHjge0/ZTEB/xZWikmeEN9UK2r8x+xEsvvNvYyqclrfTRky2vo+1PC8c55
 tuaRBWlG+XRDTJa4uHlzJXJ/b0WT6hZG9vWPkv39p2qgTD2xwSuXXrm0gBx0gLSTHEqT
 RwG+a8ydq7ECzwqGm418XPyuBViGcEeR+Xjn03W9sYeKLgdt2lHj+EKuvXkujHRws7cG
 Ce+YtFC+UieWyq49x+zyZd0aLHjtJHi00/51uS34D9CROgM5Z7SJBptNsaXMA/2djYdQ
 lm9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708008035; x=1708612835;
 h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NB4ta5gxmIWsPbziaps4DanaxPwkfEfKtnQvF9qBh4g=;
 b=sPJDFfWRQogzxM8W+0B4NSCvfk8wX9kC5c4jijThXgG3/Ise+6wFTESEg5m+PE+6Eg
 97rPwS+wgNxS2/9w5wiFoZtdoqA1zsIZVYv/4/kOADrw4ByK7JWKd1jZcbfELQXwq2xw
 KKqXzDGlRl8IlSbYg7JaKejtutIWY4IU5+FpqArHsInE0Lquokz5toLH6LuD6LGflZDg
 9D925dsLRDw6DnMy623hJLngcvImtEoNHXM6MXHtyBUNi/Zzz6ZJi1xWpIMvyx55VUhP
 AE8rMEEuqhHI2nasp9nhW8raSCqILefzveyseIBUwuK+Au84D2uZPDlLkLGS1bVhSzRm
 1l9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLRjSFSPnaHcKqHGE7nNcdh4kItX1SzNYt0RYxeq0HqX4qz96Y/usnyGhW8Kqr0uaqKP0x6H+vSDxiZ6iIQbyPBauLzw==
X-Gm-Message-State: AOJu0Yw/2VU4b7vLPi6jEs847Ko6H2t+iSfzr7tmt2tii8WZdUmOLeYL
 6Q2lJv9T17JB+7HWpPElW+kQRMZsyyfcupVb1RViUrqsS0vFDahh2beEtAgR5hw=
X-Google-Smtp-Source: AGHT+IERzG8GcZIiMT6lcfN5OeB2QMh9DHcNQIkehHg5oobdjnZ+zkYUzEXsmhyy7kTxSVCIzpV61w==
X-Received: by 2002:a05:600c:5342:b0:410:8db2:d5ec with SMTP id
 hi2-20020a05600c534200b004108db2d5ecmr1543644wmb.38.1708008034906; 
 Thu, 15 Feb 2024 06:40:34 -0800 (PST)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 b17-20020a5d6351000000b0033b1b1da2adsm1990200wrw.99.2024.02.15.06.40.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 06:40:34 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Tom Rini <trini@konsulko.com>
Cc: Lukasz Majewski <lukma@denx.de>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 u-boot@lists.denx.de
Subject: [GIT PULL] Please pull u-boot-dfu-20240215
Date: Thu, 15 Feb 2024 15:40:33 +0100
Message-ID: <87v86pyen2.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Tom,

Here are some developments for master including:

- Fix avb_verify command with SD cards
- Add u-boot-dfu maintainer tree for AB/AVB
- Avb: report verified boot state based on lock state
- Misc avb refactors improve code quality

The CI job is at https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/19653

Thanks,
Mattijs

The following changes since commit 37345abb97ef0dd9c50a03b2a72617612dcae585:

  Prepare v2024.04-rc2 (2024-02-13 18:16:57 -0500)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-dfu.git tags/u-boot-dfu-20240215

for you to fetch changes up to e2f6270f2da844d598555702d3af4f2e3fae3f9f:

  doc: android: avb: sync usage details (2024-02-15 10:38:34 +0100)

----------------------------------------------------------------
u-boot-dfu-20240215

- Fix avb_verify command with SD cards
- Add u-boot-dfu maintainer tree for AB/AVB
- Avb: report verified boot state based on lock state
- Misc avb refactors improve code quality

----------------------------------------------------------------
Igor Opaniuk (8):
      MAINTAINERS: add custodian tree info for AVB/AB
      common: avb_verify: don't call mmc_switch_part for SD
      avb: move SPDX license identifiers to the first line
      common: avb_verify: rework error/debug prints
      cmd: avb: rework prints
      common: avb_verify: add str_avb_io_error/str_avb_slot_error
      cmd: avb: rework do_avb_verify_part
      doc: android: avb: sync usage details

 MAINTAINERS                            |   2 +
 cmd/avb.c                              | 173 +++++++++++++++++----------------
 common/avb_verify.c                    |  89 +++++++++++++----
 doc/android/avb2.rst                   |  16 ++-
 include/avb_verify.h                   |   7 +-
 test/py/tests/test_android/test_avb.py |   3 +-
 6 files changed, 180 insertions(+), 110 deletions(-)
