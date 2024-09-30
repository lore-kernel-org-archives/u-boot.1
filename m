Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17D20CE835C
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 15:27:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A28C788E26;
	Mon, 30 Sep 2024 17:27:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dbR/L/+2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 272A087FA7; Mon, 30 Sep 2024 17:27:21 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A30D488E14
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 17:27:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-37ccfbbd467so2635746f8f.0
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 08:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727710038; x=1728314838;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=8S2rym8N/tWXzwaZGBmEVKHXmHSoia0TZKTs+ufPhLY=;
 b=dbR/L/+2F1NHlAUqiAdcNrx5sU8iMAg8f+mSYMc3iXzjGSCXqcLYOgFAbN5ZZl3/k2
 JTFRy9SWYnkEg3eujwQjkBi2vzH1VVMJIUQ0Gwn9MUfEScBjR4qKfqEguVMleOHAH+0z
 o9gGP3xK7oYkdCLYyLdMeQwm+1aDiEkvvNzvYha2+mRVQXZob8xwezdfFUknchgP4ODg
 XMjphbSXV8u+bHquRXtcyaoHj7BqasG/YMCIA1RRJsTvp0dTCrpmyiiGTODcOpbmZb8x
 HlrtRh0t8JIN5d2hXGk+KJioBTPsGohkgQbgshK8uVvI07HFAwZsg+pJKyAzBQEVJtyo
 GSPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727710038; x=1728314838;
 h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8S2rym8N/tWXzwaZGBmEVKHXmHSoia0TZKTs+ufPhLY=;
 b=E7HNFPrlfd97JhJZ1HNSVN7SvVykUSJdB66vyMXpKfcffAkhDtWulvdENaYBfbggyw
 jj75jQdJdME2porKSwxSHkZZYG2sMEGceFb3IK54FD+JV0UAYxRyDtwvjQnLdHyU4ebz
 Th1Qi1B3IkQa1dAmtsEC5iZtMb+syE4ydZTmF7BryjIPQMDJcqZIbPTXwWLsPIK2+Gy0
 RHNk7gSY+ci6YDOI8JQuWw9KEfXdKYXTmf5QGLukAzF+D6pR5UE5Yb9z1BgeZHH6myUl
 gaM/zyupFT6LD1iuzEeQHxHOXYW6gZWpte7Yj6h6xNP59JdHRXIMStD/av6GX+E/ex/U
 JjOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVidnghubhDiQiJXGd8G4wKCM13ADnZOhwXlTu7h6p6kSbvXkCrNAgOlZEMgb3HfskRjg2EP1o=@lists.denx.de
X-Gm-Message-State: AOJu0YyGj8q5VVDoPAFGXQoxHzx487okI5iIxfTuGSCHR4voMbLyQ1aX
 IeCg4DThV06kLNr8zSPdXO8TeRNEHH1FMUZ09fsIx+Z6GgmHi3AQeRuVHGkKvuA=
X-Google-Smtp-Source: AGHT+IGQQgJd4EEtPc0YnqTQf1IBxUpXtab5o/UiK4T1blq5iX7fnaPuyfOjXn4FJU7pun6jMMjjJw==
X-Received: by 2002:adf:f787:0:b0:37c:ca01:98e9 with SMTP id
 ffacd0b85a97d-37cd5a8305dmr6388866f8f.6.1727710038100; 
 Mon, 30 Sep 2024 08:27:18 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd5745696sm9233128f8f.106.2024.09.30.08.27.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Sep 2024 08:27:17 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Jerome Forissier
 <jerome.forissier@linaro.org>
Subject: [GIT PULL] Please pull u-boot-dfu-20240930
Date: Mon, 30 Sep 2024 17:27:16 +0200
Message-ID: <87h69xmaaz.fsf@baylibre.com>
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

Please find some fixes for master:
- Fix Kconfig dependencies for DFU_OVER_USB

CI job:
- https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/22468/

PS: I know it's a bit late, if you'd prefer to defer this to next
release, let me know.

Thanks,
Mattijs

The following changes since commit 5f044932413694475422d4b16607dfcf9aff8781:

  scripts/Makefile.lib: do not include CONFIG_DEVICE_TREE_INCLUDES in dtsi_include_list (2024-09-10 11:31:54 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-dfu.git tags/u-boot-dfu-20240930

for you to fetch changes up to 2f9c472dd7a91bc2d6e7840a550edcd257ff8b57:

  dfu: fix Kconfig dependencies (2024-09-13 17:41:18 +0200)

----------------------------------------------------------------
u-boot-dfu-20240930

- Fix Kconfig dependencies for DFU_OVER_USB

----------------------------------------------------------------
Jerome Forissier (1):
      dfu: fix Kconfig dependencies

 drivers/dfu/Kconfig        | 2 +-
 drivers/usb/gadget/Kconfig | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)
