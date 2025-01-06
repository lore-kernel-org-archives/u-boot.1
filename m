Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17A4BE77198
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 03:15:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E711D805FD;
	Tue,  7 Jan 2025 04:15:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Q3CcXDaJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CFC58058A; Mon,  6 Jan 2025 15:32:42 +0100 (CET)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5925801C3
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 15:32:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-844d555491eso491362339f.0
 for <u-boot@lists.denx.de>; Mon, 06 Jan 2025 06:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736173957; x=1736778757; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Aj+g+yRoLfGfd1QyUsv8Qq2iqm00YouL8/TJZ7Xwymw=;
 b=Q3CcXDaJwJoimNxQfzm2sKRcRTpRSr3kfFh7JifKu1U/njI7pkWcxO4puwls1oY0mV
 K0iGdm5W+LFwTerSRftK5iJc2tPmCOEcdBambG+V+rOk5ajByt92MpPSPWIIGbJDo0Ue
 r+XkWcD8XKt2fcgONu4J67lw0IU+68Q6Si+nY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736173957; x=1736778757;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Aj+g+yRoLfGfd1QyUsv8Qq2iqm00YouL8/TJZ7Xwymw=;
 b=CQnBG6rioWVojndT8fJDl7vJzSNzo2lSnAVPK0Vwgne7mB25Dwm7Bs9Flxb8uClxoI
 yZjs+pnRW5QYAotqdhAS0LWQd8gHAfK+LALcmU8nZ9w2Xo3fzZ03hqMg1Q97SqLaNWWh
 9dwvwf+2ch2Fyg34z/hS31BGREIWFP2fqF9nfE+y5ESL9Z67QLvBhsOURpclVMxfEp+V
 EFHeuXy6Uc6lsNUludGfeG+L/UOcKwnmXPjJvm3ZtBp/IoruLXkTqDwaJCpj8Im4zg88
 xkDoQdsRKoTiXViy2RNw3hrrRi1k9ODDN6IrWwvHLAGarf62ArO0QLUxyqlrFgLZzq1S
 BwLg==
X-Gm-Message-State: AOJu0Yx/YoA3yIjJ3a3eN5O5pB27XRQQ1oipt8t1OxYk8BhRAuilb2Ld
 vRngJpbFdJdwnqckGFvm1mwbikLlL+ZHuUqZ5N7sF/2H3pLODGoR5ebwnJGdOGxDPNgycRR/TEA
 =
X-Gm-Gg: ASbGncveRTDuW6DIaGXFr1kYBhF1XBBokUIvHtdntduklYcXenjAKTw687lUUMNYgpw
 VWBpzhR+3lcilfTYsiDZQbYaCWU5PhA1ZCuW4ZTT4aEiqSxBSdKFuqcMvufEipP57mn9xrr4gDp
 cyxJPsfgSyknnRp1pk98E1R9g0/r4+0XefATCpGr4F48JjbeaUpq90t37u0XFAnJvpKGh86tBoY
 ww4sV+RnxJCjF9epsvPVMkEKCpbGiFkhquF1vDoFFRvakIT//wE2uf1aw35tjvZNXQqdVE4wZnK
 EoSUjtakgatejD2q6Q==
X-Google-Smtp-Source: AGHT+IESpD7ZaR7EdeVsjoyDX5m12uc64Zbo5BtB0SHlIwKx3yS3/zRrRprxU6Nnf+L5iKS93g9XaQ==
X-Received: by 2002:a05:6e02:170e:b0:3a7:e701:bd1b with SMTP id
 e9e14a558f8ab-3c2d5916159mr500309595ab.20.1736173957490; 
 Mon, 06 Jan 2025 06:32:37 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3c0e47d6ef2sm97200805ab.78.2025.01.06.06.32.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2025 06:32:35 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 =?UTF-8?q?Ahelenia=20Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>,
 Alex Shumsky <alexthreed@gmail.com>, Alexander Dahl <ada@thorsis.com>,
 Alexander Graf <agraf@csgraf.de>,
 Alexander Kochetkov <al.kochet@gmail.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anand Moon <linux.amoon@gmail.com>, Anatolij Gustschin <agust@denx.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Bin Meng <bmeng.cn@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Chen-Yu Tsai <wens@csie.org>, Christian Marangi <ansuelsmth@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>,
 Dmitry Gerasimov <di.gerasimov@gmail.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Dragan Simic <dsimic@manjaro.org>, Heiko Schocher <hs@denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Hugo Cornelis <hugo.cornelis@essensium.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Janne Grunau <j@jannau.net>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jerry Van Baren <vanbaren@cideas.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Jonas Karlman <jonas@kwiboo.se>,
 Joshua Watt <jpewhacker@gmail.com>, Julien Masson <jmasson@baylibre.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Levi Yun <yeoreum.yun@arm.com>,
 Lukasz Majewski <lukma@denx.de>,
 =?UTF-8?q?Marek=20Moj=C3=ADk?= <marek.mojik@nic.cz>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Matthew Garrett <mgarrett@aurora.tech>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>, Michael Walle <mwalle@kernel.org>,
 Michal Simek <michal.simek@amd.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Nikhil M Jain <n-jain1@ti.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Paul-Erwan Rio <paulerwan.rio@gmail.com>,
 Pavel Herrmann <morpheus.ibis@gmail.com>,
 Peter Korsgaard <peter@korsgaard.com>,
 Peter Robinson <pbrobinson@gmail.com>, Philip Oberfichtner <pro@denx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Raymond Mao <raymond.mao@linaro.org>,
 Roman Stratiienko <r.stratiienko@gmail.com>, Stefan Roese <sr@denx.de>,
 Stefano Babic <sbabic@denx.de>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Subject: [PATCH v2 00/33] upl: Prerequite patches for updated spec
Date: Mon,  6 Jan 2025 07:31:56 -0700
Message-Id: <20250106143229.3023771-1-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 07 Jan 2025 04:15:55 +0100
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

The current UPL spec[1] has been tidied up and improved over the last
year, since U-Boot's original UPL support was written.

This series includes some prerequisite patches needed for the real UPL
patches. It is split from [2]

[1] git@github.com:UniversalPayload/spec.git commit 3f1450d
[2] https://patchwork.ozlabs.org/project/uboot/list/?series=438574&state=*

Changes in v2:
- Fix 'Emable' typo
- Enable the command in cmd/Kconfig instead
- Fix unbalanced {}
- Add new patch to move x86 tables to use SZ macros
- Use 4K instead of 4KB
- Add new patch to enable bloblist on x86
- Split this into its own function
- Split prerequisite patches into their own series

Raymond Mao (1):
  bloblist: add api to get blob with size

Simon Glass (32):
  bloblist: Drop BSD license
  bloblist: Make BLOBLIST_ALLOC the default
  abuf: Provide a way to get the buffer address
  abuf: Allow use in host tools
  abuf: Provide a constant buffer
  cpu: Provide a way to get the physical-address size
  serial: Support info() method in ns16550 xPL with UPL
  mkimage: Update map_to_sysmem() to match its prototype
  x86: Enable meminfo command
  x86: Show the timestamp counter with bdinfo
  ofnode: Use 4K for a default tree-size
  ofnode: Indicate when out of space in a few places
  ofnode: Update of_add_subnode() to indicate name is alloced
  boot: Rename fit_image_get_data()
  boot: Rename fit_image_get_data_and_size()
  boot: Update fit_image_get_emb_data to use abuf
  boot: Use fit_image_get_data() to get data
  boot: Update fit_image_get_data() to use abuf
  test: Fix inpected typo in upl test
  emulation: fdt: Relax condition for OF_HAS_PRIOR_STAGE
  emulation: Use bloblist to hold tables
  x86: Create more space for SPL with qemu-x86_64
  pci: video: Set up the pixel-format field
  x86: Show an error if video fails
  x86: Support jumping to a UPL image
  x86: Enable UPL handoff for SPL
  x86: Move tables to use SZ macros
  x86: Align the SMBIOS table to a 4K boundary
  x86: emulation: Enable bloblist
  dm: core: Clarify behaviour of ofnode_name_eq()
  dm: core: Provide ofnode_name_eq_unit() to accept a unit address
  dm: core: Provide ofnode_find_subnode_unit()

 arch/arm/cpu/armv8/sec_firmware.c      | 13 ++--
 arch/arm/mach-k3/r5/sysfw-loader.c     | 11 ++-
 arch/x86/include/asm/cpu.h             |  9 ---
 arch/x86/lib/bdinfo.c                  |  3 +
 arch/x86/lib/bootm.c                   | 18 ++++-
 arch/x86/lib/spl.c                     | 12 +++-
 arch/x86/lib/tables.c                  | 11 ++-
 boot/image-board.c                     | 11 ++-
 boot/image-fit.c                       | 98 +++++++++-----------------
 cmd/Kconfig                            |  4 +-
 cmd/ximg.c                             | 14 ++--
 common/Kconfig                         | 15 ++--
 common/bloblist.c                      | 19 ++++-
 common/spl/spl_fit.c                   |  8 ++-
 common/splash_source.c                 | 18 +----
 common/update.c                        |  7 +-
 configs/chromebook_bob_defconfig       |  1 +
 configs/chromebook_coral_defconfig     |  1 +
 configs/chromebook_kevin_defconfig     |  1 +
 configs/chromebook_samus_tpl_defconfig |  1 +
 configs/qemu-x86_64_defconfig          |  6 +-
 configs/qemu-x86_defconfig             |  2 +
 configs/qemu_arm64_defconfig           |  2 +
 configs/qemu_arm_defconfig             |  2 +
 drivers/core/ofnode.c                  | 67 ++++++++++++++----
 drivers/misc/qfw_acpi.c                | 37 +++++++++-
 drivers/misc/qfw_smbios.c              | 45 ++++++------
 drivers/pci/pci_rom.c                  |  3 +
 drivers/serial/ns16550.c               |  2 +-
 drivers/video/bochs.c                  |  1 +
 drivers/video/video-uclass.c           |  1 +
 dts/Kconfig                            |  2 +-
 include/abuf.h                         | 25 +++++++
 include/bloblist.h                     | 20 +++++-
 include/cpu.h                          | 14 ++++
 include/dm/ofnode.h                    | 35 +++++++--
 include/image.h                        | 39 ++++++++--
 include/video.h                        |  2 +
 lib/Kconfig                            |  1 +
 lib/Makefile                           |  5 ++
 lib/abuf.c                             | 21 +++++-
 test/common/Makefile                   |  4 ++
 test/dm/core.c                         | 20 ++++++
 test/dm/ofnode.c                       | 19 +++++
 test/lib/abuf.c                        | 26 ++++++-
 test/py/tests/test_upl.py              |  2 +-
 tools/Makefile                         |  3 +-
 tools/fit_image.c                      |  8 +--
 tools/image-host.c                     | 23 +++---
 tools/mkimage.h                        |  2 +-
 50 files changed, 507 insertions(+), 207 deletions(-)

-- 
2.34.1

