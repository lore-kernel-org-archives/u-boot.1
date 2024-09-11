Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 529BCEE57EE
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 23:25:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83AD58880F;
	Thu, 12 Sep 2024 01:25:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OZrwlKPw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC550886B1; Thu, 12 Sep 2024 01:25:30 +0200 (CEST)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 701818880F
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 01:25:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2d889ba25f7so236698a91.0
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 16:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726097125; x=1726701925; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bUAg6Ro5WEJ7ZW5NAVG6kvoKQ4WCJrwFt11OjV5tJkA=;
 b=OZrwlKPw+PQ/K2NwniAM7s8EjZ/VnpCPkCzbN9qgp8H4XPnzNeEG6jkD92+kC4aU+n
 wV0xXLObJ0amAAAOOqq7fsAbuYLtVYsnNoXN2ALE35EKgmH3dtiYp2Z9WBYmWoVOySdD
 dmIFZXXYbjtz7Gt97RnKIZRecN79sZGAnEL7nwvzCO6rDboXYYFzKlHnJTFTjioA5WPa
 8QE2NtztYPrtNTLSkzk2BCzjJ9+3nw1LsIxo+MZCQGl+1XcNtJhIPU/uJQVbH3TR7Hqg
 qilYl3neow4sGFz6TG2KEsOm0NV+uZbycKrGmWszBxRLMY9egVkC1BbdwYKhz2p6SOXK
 S8nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726097125; x=1726701925;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bUAg6Ro5WEJ7ZW5NAVG6kvoKQ4WCJrwFt11OjV5tJkA=;
 b=rjLZMQdqvg1bhJoiEjTlfrHJeO4x2NuCJ2/9RP7biSiULPpVazPpmo2EYk6EWj+Z7O
 2fPaVEdaM9jrA3MRPJOintz/aWP3huokwEgrBc8fHeFyw4NJ8zAzV/AAQ8AdFoo1v37S
 c0HKmEGZI8ctGPEIPJTXwz62SrTQRyIUUE+lakP0HESdoE0bV2bq1Dd9gZ2AFdE2Yjgs
 TV4MMQG9AyRR/ATAMJ13y5YalcLcnhUYKxnShsFn2bJR/BYlFN95K9kBssJ55EdPkgiT
 HZSEM2vjRMWRGG63qBMg2QJHyjfwNXkBFXIdtoiN0fu6SaUM6e71djuhRXr5OoBOTg0h
 61sQ==
X-Gm-Message-State: AOJu0YxZTyNyMkyuhWnxZhsbU8XPjZPS0azdg+gWsXyMmEhwF+MfY+va
 9hXHsMMA7z6YokWBU0BV/X1IZZcbWLPjFflbme/+xOT5CHuXpZpp
X-Google-Smtp-Source: AGHT+IEiQbc72/23N0CPP/BVw6N4XHAhSFJHpectg9BMsxISdBhELdDcN7tqYq6YNxeafMfc/Y+GzQ==
X-Received: by 2002:a17:90b:17c5:b0:2c4:b0f0:8013 with SMTP id
 98e67ed59e1d1-2db9ffbfbf2mr957515a91.11.1726097125548; 
 Wed, 11 Sep 2024 16:25:25 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:3d06:bc1a:52fe:9519])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7db1fdedae0sm511650a12.84.2024.09.11.16.25.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 16:25:25 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] Please pull u-boot-imx-next-20240911
Date: Wed, 11 Sep 2024 20:25:21 -0300
Message-Id: <20240911232521.1124639-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Hi Tom,

Please pull from u-boot-imx/next, thanks.

The following changes since commit 78d898eec080b02059c8dc09318b8761044fea85:

  Merge patch series "phycore-am62/4: Add more boot sources" (2024-09-10 14:56:12 -0600)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-next-20240911

for you to fetch changes up to 5748aa1e372d2db3db6bf3e863f4571bf2ffedb9:

  pwm: imx: Don't drop the enable bit once set (2024-09-11 17:02:36 -0300)

u-boot-imx-next-20240911
------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/22320

- Improve i.MX8M boot time by enabling MMU and D-cache very early.
- Don't drop the enable bit once set on the i.MX PWM driver.
- Enable DM_RNG so that the kaslr-seed property is set in the dt allowing
Linux KASLR.
----------------------------------------------------------------
Marek Vasut (1):
      ARM: imx: Enable MMU and dcache very early on i.MX8M

Miquel Raynal (1):
      pwm: imx: Don't drop the enable bit once set

Tim Harvey (1):
      configs: venice: enable DM_RNG

 arch/arm/mach-imx/imx8m/soc.c   | 47 +++++++++++++++++++++++++++++++++++++++++
 configs/imx8mm_venice_defconfig |  1 -
 configs/imx8mn_venice_defconfig |  1 -
 configs/imx8mp_venice_defconfig |  1 -
 drivers/pwm/pwm-imx.c           |  5 +++--
 5 files changed, 50 insertions(+), 5 deletions(-)
