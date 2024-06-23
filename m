Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB270C27C4F
	for <u-boot@archiver.kernel.org>; Sun, 23 Jun 2024 20:30:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE2D488327;
	Sun, 23 Jun 2024 22:30:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="c+A1NbxV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2405187D10; Sun, 23 Jun 2024 22:30:40 +0200 (CEST)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA73687D07
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 22:30:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-7f38f5584ebso120397939f.3
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 13:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719174636; x=1719779436; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=02kH5fbssxZPV+CMxhJUpCxJVlosxneGWxXtZ+1mYNE=;
 b=c+A1NbxV/ZUPL2rQnke00nuhM6x9pbQt0K56dvXYe/0z+6OMBj5WKDI0UrJHaIjgAz
 OpPhGXC9yvyhkL/ud27fd9Ywgcp2i0KynmF8JcXmKiYKcc3S+GH7ORTYxEm9RAUvC75b
 Ebr3ardwH2PhqmHzcsboZyYSc+MtgMuEeYfqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719174636; x=1719779436;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=02kH5fbssxZPV+CMxhJUpCxJVlosxneGWxXtZ+1mYNE=;
 b=S8Nwb4Fnr7mqFG7GAMh+yT/K6b5OcS9Jr9uuIm5uZPTkODeI4fq20LQMSenaU0CmN1
 z4mCpUJ1i14V6tBUVi3k9dFlFP08oxlhJl416c3Bx2r9AmQOjz9c96VRnVVmCivVg7iy
 4BLjitOuxCOg+l5lnIYk9bywCpLSmb+ba8Ch9hQKXMuuk+bCAOHHamfmNS61uWqcARl5
 GZX6jbIyDHE7Bn/IUrya16uy5yE5oIlCiAEqIPZrpg3YltSI2ybhlqqexn59FMUvtGiu
 KwNh6yr4GOr4hu5DBsVkmz131DsNzVcvcI7m94rFjp1eww2q2HlzBirnTygpxYnmdceE
 Vj9Q==
X-Gm-Message-State: AOJu0Yzglxl+PJOLc3vNiaxEBeDi66c9y4C4BPdgFj6Pykya9Z9ACk16
 QDe5/aBpzZJ1p0GDeQp2Zet0FePoDaYKEoCJXuLuDlCVq4l58tx6WuNeIVeXscaApo0k+w7Qq0z
 WJg==
X-Google-Smtp-Source: AGHT+IFG2O45FRONHY8f336gydDkuy0V2P8Aq9sfdDlBRoz1u1ZhNkAo047RJqHqFyf0LOcJ0zPitw==
X-Received: by 2002:a05:6602:1688:b0:7eb:7bc9:7fc2 with SMTP id
 ca18e2360f4ac-7f3a4e59c7emr321165339f.20.1719174636443; 
 Sun, 23 Jun 2024 13:30:36 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4b9d110ffb6sm1627335173.58.2024.06.23.13.30.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jun 2024 13:30:36 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alexander Gendin <agendin@matrox.com>, Allen Martin <amartin@nvidia.com>,
 Andre Przywara <andre.przywara@arm.com>, Bin Meng <bmeng.cn@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>,
 Michal Simek <michal.simek@amd.com>,
 =?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>,
 Neil Armstrong <neil.armstrong@linaro.org>, Nishanth Menon <nm@ti.com>,
 Pavel Herrmann <morpheus.ibis@gmail.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Trevor Woerner <twoerner@gmail.com>,
 u-boot-amlogic@groups.io
Subject: [PATCH 00/14] testb: Various tweaks and fixes for Labgrid
Date: Sun, 23 Jun 2024 14:30:19 -0600
Message-Id: <20240623203033.1566505-1-sjg@chromium.org>
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

This series includes a number of mostly unrelated changes which are in
service of running U-Boot on a lab using Labgrid.

Changes in v2:
- Add new patch to update u-boot.cfg with CFG_... options

Simon Glass (14):
  trace: Update test to tolerate different trace-cmd version
  dm: core: Enhance comments on bind_drivers_pass()
  initcall: Correct use of relocation offset
  am33xx: Provide a function to set up the debug UART
  sunxi: Mark scp as optional
  google: Disable TPMv2 on most Chromebooks
  meson: Correct driver declaration for meson_axg_gpio
  test: Make bootstd init run only on sandbox
  log: Allow tests to pass with CONFIG_LOGF_FUNC_PAD set
  test: dm: Show failing driver name
  test: Decode exceptions only with sandbox
  test: Check help output
  Update u-boot.cfg to include CFG also
  smbios: Correct error handling when writing tables

 arch/arm/dts/sunxi-u-boot.dtsi                |  1 +
 arch/arm/mach-omap2/am33xx/board.c            | 18 +++++++++++++++---
 configs/chromebook_link64_defconfig           |  1 +
 configs/chromebook_link_defconfig             |  1 +
 configs/chromebook_samus_defconfig            |  1 +
 configs/chromebook_samus_tpl_defconfig        |  1 +
 configs/nyan-big_defconfig                    |  4 +---
 configs/snow_defconfig                        |  1 +
 drivers/core/lists.c                          | 16 ++++++++++++++++
 drivers/pinctrl/meson/pinctrl-meson-axg-pmx.c |  2 +-
 drivers/pinctrl/meson/pinctrl-meson-axg.c     |  4 ++--
 drivers/pinctrl/meson/pinctrl-meson-axg.h     |  2 +-
 drivers/pinctrl/meson/pinctrl-meson-g12a.c    |  4 ++--
 lib/initcall.c                                |  6 ++++--
 lib/smbios.c                                  | 10 ++++++++--
 scripts/Makefile.autoconf                     |  2 +-
 test/py/tests/test_dm.py                      |  5 ++++-
 test/py/tests/test_help.py                    |  6 +++++-
 test/py/tests/test_log.py                     | 11 +++++++----
 test/py/tests/test_trace.py                   |  6 +++---
 test/py/tests/test_ut.py                      |  1 +
 test/py/u_boot_console_sandbox.py             |  2 +-
 test/py/u_boot_spawn.py                       | 10 ++++++----
 23 files changed, 84 insertions(+), 31 deletions(-)

-- 
2.34.1

