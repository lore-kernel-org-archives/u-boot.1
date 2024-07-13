Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0CBAC3DA45
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 07:07:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0908988549;
	Sat, 13 Jul 2024 09:05:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eDmKkfWA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9959B882B6; Sat, 13 Jul 2024 09:01:55 +0200 (CEST)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFC068855E
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 09:01:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2eec7e431d9so34428111fa.2
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 00:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1720854111; x=1721458911; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=M6wdVLICKlqDLK+Rb+sZunBwop637aRY1nOAOg2wMWA=;
 b=eDmKkfWAZrocl9Tmjv3CxBRXld62/Y0mY89uESeJuozdk9Xo1uRCJgA95eX0uNwpH0
 EZJnpQiBugs6FxqKZ3wSql/3Y65xz/bOBdxuuvFxfLywfbIMp3JQpt9go0k2cWjgF4wG
 kkuBJogKFNanHp5Jg3ToeOUQrye42ll4UJbpw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720854111; x=1721458911;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M6wdVLICKlqDLK+Rb+sZunBwop637aRY1nOAOg2wMWA=;
 b=lXM4uclKvTu7CvKZph6b0P64lNJ85sO8SFAJNbMyaEfd6n6T4mHSaGMzmw/2AUFnCB
 QHKHS0aM6ucI9pcjaCooHpXXFC9jOOWYYhCdojWGqAq3NxrlEvWAgekQJRl9C/cTwyS5
 pxONf1S6To4ZXz5QlMZgb4AOx9FK7zzcwbHlnrwaowpTCU+lhEfEMiNjGbUnR9WAQxdy
 Rn2NivgKXfk1KewZdkxv9j9vOQX9qRxe6MJIDTWIPppADH5zt3S53c4CURqShNhYY/Vp
 f7Izen7ISljuAHdERMUW8LWBWw+bDSs3Omy3SF1bvjBZk6940uWRAMjmmdQwPD883QbC
 gayw==
X-Gm-Message-State: AOJu0Yw0f9VndLdshCmc6hHTI0Og8Vtp2ZxeSyeTLl7K5xtnfkQBv+8G
 OWhuolDR7IxkHSEYlhmzCbW3AktQKkIt6Cx65lERgxus+34/LM6tDjWg4s3NSaGF1t+l1eSHZhQ
 =
X-Google-Smtp-Source: AGHT+IFwQcB6BU4nu3y+2xAn10S92JdK5BEAfftEawEIL35Axpz5zcf5z9vbDoLAvq5eRSZInQlpnQ==
X-Received: by 2002:a2e:9b89:0:b0:2ee:81eb:6bd6 with SMTP id
 38308e7fff4ca-2eeb30fd3ebmr80182091fa.23.1720854110649; 
 Sat, 13 Jul 2024 00:01:50 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427a5ef550asm9973165e9.46.2024.07.13.00.01.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Jul 2024 00:01:50 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Michal Simek <michal.simek@amd.com>, Sean Anderson <seanga2@gmail.com>,
 Lean Sheng Tan <sheng.tan@9elements.com>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Gendin <agendin@matrox.com>, Anand Moon <linux.amoon@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>,
 Artur Rojek <artur@conclusive.pl>, Bin Meng <bmeng.cn@gmail.com>,
 Bryan Brattlof <bb@ti.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Chanho Park <chanho61.park@samsung.com>, Devarsh Thakkar <devarsht@ti.com>,
 Eddie James <eajames@linux.ibm.com>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerry Van Baren <vanbaren@cideas.com>,
 Jesse Taube <mr.bossman075@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Joshua Watt <jpewhacker@gmail.com>, Kever Yang <kever.yang@rock-chips.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nikhil M Jain <n-jain1@ti.com>, Nishanth Menon <nm@ti.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Peter Robinson <pbrobinson@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Raymond Mao <raymond.mao@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Samuel Holland <samuel@sholland.org>, Shiji Yang <yangshiji66@outlook.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Suniel Mahesh <sunil@amarulasolutions.com>,
 Tom Fitzhenry <tom@tom-fitzhenry.me.uk>, Tom Rini <trini@konsulko.com>,
 Troy Kisky <troykiskyboundary@gmail.com>
Subject: [PATCH v2 00/21] Universal Payload initial series
Date: Sat, 13 Jul 2024 08:00:34 +0100
Message-Id: <20240713070055.2172883-1-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 13 Jul 2024 09:05:22 +0200
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

Universal Payload (UPL) is an Industry Standard for firmware
components[1]. UPL is designed to improve interoperability within the
firmware industry, allowing mixing and matching of projects with less
friction and fewer project-specific implementations. UPL is
cross-platform, supporting ARM, x86 and RISC-V initially.

This series provides some initial support for this, targeting 0.9.1 and
sandbox only.

Features still to come include:
- Support for architectures
- FIT validation
- Handoff validation
- Interoperability tests

This series is available at dm/uplb-working and requires the alist
series at dm/alist-working[2]

[1] https://universalpayload.github.io/spec/
[2] https://patchwork.ozlabs.org/project/uboot/list/?series=414642

Changes in v2:
- Put the upl tests under their own subcommand to avoid bootstd init
- Add a function to init the UPL process in SPL
- Hang when something goes wrong, to avoid a broken boot
- Add a runtime flag to enable UPL
- Add a link to the spec
- Add a link to the command
- Support CI testing
- Rework to use alist instead of fixed-length arrays

Simon Glass (21):
  sandbox: Use const in os_jump_to_file()
  sandbox: Fix a comment in os_find_u_boot()
  test: Move some SPL-loading test-code into sandbox common
  sandbox: Enable SPL_LOAD_BLOCK
  fdt: Don't overwrite bloblist devicetree
  sandbox: fdt: Avoid overwriting an existing fdt
  sandbox: Return error code from read/write/seek
  sandbox: Add ELF file to VPL u-boot.img
  sandbox: Set up global_data earlier
  upl: Add support for reading a upl handoff
  upl: Add support for writing a upl handoff
  upl: Add basic tests
  upl: Add a command
  upl: Add support for Universal Payload in SPL
  spl: Plumb in the Universal Payload handoff
  upl: Plumb in universal payload to the init process
  sandbox_vpl: Enable Universal Payload
  upl: Add initial documentation
  sandbox: Add a flag to enable UPL
  sandbox: Add an SPL loader for UPL
  upl: Add an end-to-end test

 MAINTAINERS                       |  13 +
 Makefile                          |   4 +-
 arch/sandbox/cpu/cpu.c            |   2 +
 arch/sandbox/cpu/os.c             |  30 +-
 arch/sandbox/cpu/spl.c            | 116 +++++-
 arch/sandbox/cpu/start.c          |  18 +-
 arch/sandbox/include/asm/spl.h    |  15 +
 arch/sandbox/include/asm/state.h  |   1 +
 boot/Kconfig                      |  70 ++++
 boot/Makefile                     |   4 +
 boot/upl_common.c                 |  60 +++
 boot/upl_common.h                 |  24 ++
 boot/upl_read.c                   | 588 ++++++++++++++++++++++++++++
 boot/upl_write.c                  | 622 ++++++++++++++++++++++++++++++
 cmd/Kconfig                       |   7 +
 cmd/Makefile                      |   1 +
 cmd/upl.c                         | 118 ++++++
 common/board_f.c                  |  22 ++
 common/board_r.c                  |   2 +
 common/spl/Kconfig                |   1 +
 common/spl/Makefile               |   2 +
 common/spl/spl.c                  |   8 +
 common/spl/spl_fit.c              |  22 ++
 common/spl/spl_upl.c              | 171 ++++++++
 configs/sandbox_defconfig         |   1 +
 configs/sandbox_vpl_defconfig     |   4 +
 doc/usage/cmd/upl.rst             | 186 +++++++++
 doc/usage/index.rst               |   2 +
 doc/usage/upl.rst                 |  46 +++
 drivers/block/sandbox.c           |   4 +-
 drivers/usb/emul/sandbox_flash.c  |   2 +-
 fs/sandbox/sandboxfs.c            |   6 +-
 include/asm-generic/global_data.h |  19 +
 include/os.h                      |   6 +-
 include/spl.h                     |  16 +
 include/test/suites.h             |   1 +
 include/upl.h                     | 361 +++++++++++++++++
 lib/fdtdec.c                      |   1 +
 test/boot/Makefile                |   2 +
 test/boot/upl.c                   | 436 +++++++++++++++++++++
 test/cmd_ut.c                     |   3 +
 test/image/spl_load_os.c          |  53 +--
 test/py/tests/test_upl.py         |  38 ++
 43 files changed, 3036 insertions(+), 72 deletions(-)
 create mode 100644 boot/upl_common.c
 create mode 100644 boot/upl_common.h
 create mode 100644 boot/upl_read.c
 create mode 100644 boot/upl_write.c
 create mode 100644 cmd/upl.c
 create mode 100644 common/spl/spl_upl.c
 create mode 100644 doc/usage/cmd/upl.rst
 create mode 100644 doc/usage/upl.rst
 create mode 100644 include/upl.h
 create mode 100644 test/boot/upl.c
 create mode 100644 test/py/tests/test_upl.py

-- 
2.34.1

