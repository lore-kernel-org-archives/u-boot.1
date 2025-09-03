Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A15DCCA1007
	for <u-boot@archiver.kernel.org>; Wed,  3 Sep 2025 05:39:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C41E783420;
	Wed,  3 Sep 2025 07:39:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fN2uLPlv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE05C8346A; Wed,  3 Sep 2025 07:39:47 +0200 (CEST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 715A583390
 for <u-boot@lists.denx.de>; Wed,  3 Sep 2025 07:39:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-5607c2f1598so2513399e87.3
 for <u-boot@lists.denx.de>; Tue, 02 Sep 2025 22:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756877985; x=1757482785; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=o6Cu/Wl5Ft4/jLQsHrx2J6klmEefWJrWeK7PH9/9oZA=;
 b=fN2uLPlvcb0mj1Xd1pzqP3L8488qxPqdRNstHsHVWGtYxFKanx6LvkvEAJXiXhOGMu
 EkIy2qqlaxIYbY03N0owNA1uSRODFYKf/9wMkjcryrfJAEnevR+NY6SYLYAklZgS5ZIr
 FQBAZZN+UpIgpzlJSE7jc5Ndr5kzeLWpvZVBc+TPX7AnsASYTz75JnV26StGsEPfB79U
 k/FOqnR0qqQIER4OyarO/+OaXLWb531wv+QAxZMI5SerEJwjiBWXP+rdQfkR9C+AEqII
 GH9YB+UjhiPwl71vCUzYza4UsPchwIqxJxzze0uerAQPs2W81RQkPPVKLlAWmk9yp+Fy
 OnVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756877985; x=1757482785;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o6Cu/Wl5Ft4/jLQsHrx2J6klmEefWJrWeK7PH9/9oZA=;
 b=N90rSHVHet1UyBMy9x/HmPzQ1wfucLR4Y2zzOUU/3Fr02joZshxQCeEiq8JAoGsOql
 wvq8kJTlWdoJSyXN8vvporxkDjib5UTynYlnUacebPB5nN+6vRi35a30CSwNqI4lXGsm
 jFrp1MD9wMnE0mPdG0A/iuEVcyXJDbWgWvP8hJJ88D5Q0NF6+0FSCCUM2jhaWgdyHOvc
 VctVbPhFMFutB6Ve6xsb2cW54iKsa0FDJOM7r2swJeI3bDszUA4NpppA2e5PX2vxYaJb
 HMYIQLFasC36H2srgHr6faMSrDyLYorkc5uGCJFlLh3zAxkdAfMmdTg+3wHASDAd8oTp
 XGCQ==
X-Gm-Message-State: AOJu0YyATemDQ8jlrXCUKg+lEC9Hj09VpFNpY/E8T0bfqSfaYWF9WbzS
 0kq7tGSwjWKp8tw+7c4oAD0eDV/Zif61lPLBe6ZLSq+hsG6pAkIrm7AG
X-Gm-Gg: ASbGncuqZ6WPoBHTjsIRXziwuHEIVwqLNt3cktIa3o0xMQI/eOWc+l7Z6mS0Mi3xWGm
 p0mXqEgmF3OA77ACq9jWjPdtuM0UW+XVQ87B4URh9OXI0o2ZN32uwMUFNpQ+FdLSm6kCe/ARvi9
 UK6i2hSYnwez2+LVQ0+lK8Utg40QvgMrkULjPlYc+Nxt7iZdYp8+FPNwdVH+e9j8hfgxovxWdae
 yiZ09gTFL6FYsern5rxG+IUDGezv5Rw94K4TtPyaBkBEYGD5jE5TL2f3GL1lBDSlb5bdd1PR+pl
 MIK7aJmrmvwDuIiX8nlFcI4KbRLQNlt5Aq4W83oLt7nwmeIq4yRX46Yvk4xvifV1uIbwO5ZaGk4
 1+eTIBIlEOqKfxA==
X-Google-Smtp-Source: AGHT+IHQ5avqObXz9wpnQJoSOaO7dyMxDKOwsOtY3YQuutLHmdBriPrDBgwgBx8anayqqGjRknw0ZA==
X-Received: by 2002:a05:6512:2212:b0:55f:3f00:a831 with SMTP id
 2adb3069b0e04-55f7089c26emr4287919e87.9.1756877984359; 
 Tue, 02 Sep 2025 22:39:44 -0700 (PDT)
Received: from xeon.. ([188.163.112.70]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5608ab5e28csm284649e87.17.2025.09.02.22.39.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Sep 2025 22:39:43 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Please pull u-boot-tegra staging
Date: Wed,  3 Sep 2025 08:39:24 +0300
Message-ID: <20250903053925.6190-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Dear Tom,

The following changes since commit 54fbdd408873413af86d86de03a490c5abf280f1:

  Merge tag 'net-20250818' of https://source.denx.de/u-boot/custodians/u-boot-net (2025-08-18 10:54:44 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-tegra.git staging

for you to fetch changes up to 392b5b426cfc40f94803688fe63f72d83d0a5e70:

  board: transformer-t20: add separate env for SL101 (2025-09-01 11:35:54 +0300)

----------------------------------------------------------------
Jonas Schwöbel (1):
      board: microsoft: add Microsoft Surface 2 support

Peter Robinson (2):
      configs: p3450: reduce size of Jetson Nano u-boot.bin
      ARM: tegra210: p3450: fix Jetson Nano SPI flash

Svyatoslav Ryhel (2):
      ARM: tegra20: transformer: fix Hall sensor behavior
      board: transformer-t20: add separate env for SL101

 arch/arm/dts/Makefile                                 |   2 +
 arch/arm/dts/tegra114-microsoft-surface-2-0b.dts      |  10 +
 arch/arm/dts/tegra114-microsoft-surface-2-13.dts      |  10 +
 arch/arm/dts/tegra114-microsoft-surface-2-common.dtsi | 905 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/dts/tegra20-asus-sl101.dts                   |  10 +
 arch/arm/dts/tegra20-asus-tf101.dts                   |  10 +
 arch/arm/dts/tegra20-asus-tf101g.dts                  |  10 +
 arch/arm/dts/tegra20-asus-transformer.dtsi            |   6 -
 arch/arm/dts/tegra210-p3450-0000.dts                  |   9 +-
 arch/arm/dts/tegra210.dtsi                            |   6 +-
 arch/arm/mach-tegra/tegra114/Kconfig                  |   5 +
 board/asus/transformer-t20/configs/sl101.config       |   1 +
 board/asus/transformer-t20/sl101.env                  |  15 +
 board/microsoft/surface-2/Kconfig                     |  13 +
 board/microsoft/surface-2/MAINTAINERS                 |   7 +
 board/microsoft/surface-2/Makefile                    |   6 +
 board/microsoft/surface-2/board-info.c                |  71 +++++
 board/microsoft/surface-2/surface-2-spl.c             |  42 +++
 board/microsoft/surface-2/surface-2.env               |   8 +
 configs/p3450-0000_defconfig                          |   9 +-
 configs/surface-2_defconfig                           |  82 +++++
 doc/board/microsoft/index.rst                         |   1 +
 doc/board/microsoft/surface-2.rst                     |  41 +++
 23 files changed, 1268 insertions(+), 11 deletions(-)
 create mode 100644 arch/arm/dts/tegra114-microsoft-surface-2-0b.dts
 create mode 100644 arch/arm/dts/tegra114-microsoft-surface-2-13.dts
 create mode 100644 arch/arm/dts/tegra114-microsoft-surface-2-common.dtsi
 create mode 100644 board/asus/transformer-t20/sl101.env
 create mode 100644 board/microsoft/surface-2/Kconfig
 create mode 100644 board/microsoft/surface-2/MAINTAINERS
 create mode 100644 board/microsoft/surface-2/Makefile
 create mode 100644 board/microsoft/surface-2/board-info.c
 create mode 100644 board/microsoft/surface-2/surface-2-spl.c
 create mode 100644 board/microsoft/surface-2/surface-2.env
 create mode 100644 configs/surface-2_defconfig
 create mode 100644 doc/board/microsoft/surface-2.rst

Branch contains minor improvents for ASUS SL101 and Jetson Nano along with
support for Microsoft Surface 2 tablet.

Thank you,
Svyatoslav Ryhel.
