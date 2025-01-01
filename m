Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E14EE7718B
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 22:37:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0385880107;
	Wed,  1 Jan 2025 23:37:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="T6liQKnY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D3C280352; Wed,  1 Jan 2025 23:10:35 +0100 (CET)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10C7F80317
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 23:10:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2165cb60719so147873815ad.0
 for <u-boot@lists.denx.de>; Wed, 01 Jan 2025 14:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1735769430; x=1736374230; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=u17oYJyPcSA7PjkICIosPowE1l+jBRhSV+PxOBEUQ9s=;
 b=T6liQKnY2JEjB5gurazEgkrr3PglyHOuwjsCqw7lo+mBWfrWDIP5L7QssL06r6bxsa
 5NhDH8pQsaT67PhBqpdoeFD9o+JUXTuAF+wO3Zlsi/KpfNIUUp3g0+fX0rA70b6Rv62a
 KTkUaZgCvo0IP7xNmtF3AcmtbiroZgNIQLvZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735769430; x=1736374230;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u17oYJyPcSA7PjkICIosPowE1l+jBRhSV+PxOBEUQ9s=;
 b=YOajBs45Ugia1vBVf05KSNShGTzl/edDTTLg+sfzyg/IEJ0KBBe89YExN/vC+A+hmr
 I0pu5C9h723JbIPKgvGJkvAHGwJNxdvVmzqCAInXQSqI4sb9xu/tir9FB3Y7B/6Mer2+
 eSYbqODYK9MmOOZJvB2l6iRJ1/vNaZyNtkeIyC4xEm0ab4ZjOfe6B6qm5efPGwVSeH5O
 IiSLXSHpGpYT/TkByeugMIPi8KFaiyVzamS6VwelGNRdvhgyQm41y67MFSvV72sQ5/Oi
 Ws4x+hMW2JaCqSZ7k+itnQx7Tsjy4oRhOXXqRQWI5LnMVHbJUhTpaz+hYfpe0esFDPZA
 UdHw==
X-Gm-Message-State: AOJu0Ywgw6saE08/AKIWAGyfQ/haTlZHT0feKaw0dM8XY0Sg7U//B7H4
 KwFbuz6HC1A5S2Boa/GBqueAUai+og/gbwt4uocvOjEIJ3udJ0DRQKxsbNtkhVVftLFASukqw4s
 =
X-Gm-Gg: ASbGncvoQdcmJlfBRJJowhWlgVbRgMiDNCKeTrGAkBL9aTxilanujSL1P31Aje0TRYL
 Hek1K9/4OsTc8XdWq5ebkgcDmfccyw3tSIXvrmTPmfwoyu1TYeCz5UFkIAj1zbt1TdLZTGeBCws
 e1dCj0brY2lT/dy4TnY25a9C/Bkv+kt5d5QDCF1h8q+2mKL+/B9IBOpgPCtOz388CBHCdPBn7O2
 wfFlir252StatldnNjuNYKO2bQroGLVDKcnoBeW0Kq+uPuoU+VWeC8=
X-Google-Smtp-Source: AGHT+IGlswKj8XeGo2DoL16RgZfnWPLg/zIbmphAMdBXMxYcuiASlNU+PYEPksNM71e9zY1avhP+FQ==
X-Received: by 2002:a05:6a21:3381:b0:1e1:c26d:d7fd with SMTP id
 adf61e73a8af0-1e5e081c4demr68869821637.37.1735769430562; 
 Wed, 01 Jan 2025 14:10:30 -0800 (PST)
Received: from chromium.org ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm18873947b3a.154.2025.01.01.14.10.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jan 2025 14:10:29 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 =?UTF-8?q?Ahelenia=20Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>,
 Alexander Dahl <ada@thorsis.com>, Alexander Graf <agraf@csgraf.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anand Moon <linux.amoon@gmail.com>, Anatolij Gustschin <agust@denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>, Chen-Yu Tsai <wens@csie.org>,
 Dmitry Gerasimov <di.gerasimov@gmail.com>, Heiko Schocher <hs@denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Hugo Cornelis <hugo.cornelis@essensium.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jagan Teki <jagan@amarulasolutions.com>, Janne Grunau <j@jannau.net>,
 Jerry Van Baren <vanbaren@cideas.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Jonas Karlman <jonas@kwiboo.se>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 =?UTF-8?q?Marek=20Moj=C3=ADk?= <marek.mojik@nic.cz>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Nikhil M Jain <n-jain1@ti.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Pavel Herrmann <morpheus.ibis@gmail.com>,
 Peter Robinson <pbrobinson@gmail.com>, Philip Oberfichtner <pro@denx.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Raymond Mao <raymond.mao@linaro.org>, Sean Anderson <seanga2@gmail.com>,
 Stefano Babic <sbabic@denx.de>
Subject: [PATCH 00/67] upl: Align with the updated spec
Date: Thu,  2 Jan 2025 11:08:46 +1300
Message-ID: <20250101221003.1944600-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 01 Jan 2025 23:37:11 +0100
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

This series addresses various issues, with a goal of having U-Boot boot
EDK2.

There is still more work to do, but this series gets to the point (on
QEMU) where the ACPI tables are required. Further work will be needed to
relocate the tables out of the QEMU firmware-filesystem.

[1] git@github.com:UniversalPayload/spec.git commit 3f1450d


Simon Glass (67):
  bloblist: Make BLOBLIST_ALLOC the default
  abuf: Provide a way to get the buffer address
  abuf: Allow use in host tools
  abuf: Provide a constant buffer
  cpu: Provide a way to get the physical-address size
  serial: Support info() method in ns16550 xPL with UPL
  mkimage: Update map_to_sysmem() to match its prototype
  x86: Emable meminfo command
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
  upl: Create a function to create a memory node
  upl: Update add_upl_memmap() to use write_mem_node()
  upl: Update add_upl_memres() to use write_mem_node()
  upl: Support writing a UPL only for testing
  upl: Drop enum upl_serial_access_type
  upl: Init serial and graphics alists in upl_init()
  upl: Move serial and graphics addition-code to upl_common
  pci: video: Set up the pixel-format field
  x86: Show an error if video fails
  x86: Support jumping to a UPL image
  x86: Enable UPL handoff for SPL
  x86: Align the SMBIOS table to a 4K boundary
  upl: Require OFNODE_MULTI_TREE when writing a UPL handoff
  upl: Drop the argument to spl_write_upl_handoff()
  x86: emulation: Enable UPL
  upl: Correct comment and condition in add_upl_memres()
  upl: Add addr/size tags in the reserved-memory node
  upl: Update upl_add_graphics() to return framebuffer
  upl: Add a function to write a UPL handoff to an abuf
  upl: Use a 64-bit value for a memregion base-address
  upl: Set bit 32 of the address when using ISA
  upl: Add RAM to the memory region
  upl: Add a compatible string for the upl-params node
  upl: Move buffer_addr_size() higher and rename
  upl: Factor out part of encode_reg() to new function
  upl: Move decode_addr_size() higher and rename
  upl: Factor out part of decode_reg() to new function
  upl: Correct name of upl-images
  dm: core: Clarify behaviour of ofnode_name_eq()
  dm: core: Allow ofnode_name_eq() to accept a unit address
  dm: core: Rewrite ofnode_find_subnode() to use ofnode API
  upl: test: Show the handoff FDT when debugging
  upl: Use a reg property to specify the FIT address and size
  upl: Update and tidy writing of images
  upl: Make use of alist_for_each()
  upl: Correct use of sizeof()
  upl: Drop acpi_nvs_size
  upl: Improve uniqueness of log_msg_ret() strings
  upl: Add PCI information
  upl: Handle serial on an ISA bus with /chosen node
  upl: Add missing word in comment for upl_write_handoff()
  upl: Add a command to execute a UPL payload
  scripts: Update qemu script to use 64-bit on x86 always
  scripts: Update qemu script to support specifying a UPL
  upl: Add reserved memory for the ACPI and SMBIOS tables
  upl: Add an 'addr' property for Tianocore

 arch/Kconfig                           |   2 +
 arch/arm/cpu/armv8/sec_firmware.c      |  13 +-
 arch/arm/mach-k3/r5/sysfw-loader.c     |  11 +-
 arch/x86/include/asm/cpu.h             |   9 -
 arch/x86/lib/bdinfo.c                  |   3 +
 arch/x86/lib/bootm.c                   |  18 +-
 arch/x86/lib/spl.c                     |  12 +-
 arch/x86/lib/tables.c                  |   9 +-
 boot/Kconfig                           |   9 +
 boot/Makefile                          |   1 +
 boot/image-board.c                     |  11 +-
 boot/image-fit.c                       |  98 ++----
 boot/upl_common.c                      | 191 ++++++++++
 boot/upl_exec.c                        | 130 +++++++
 boot/upl_read.c                        | 220 ++++++------
 boot/upl_write.c                       | 464 ++++++++++++++++---------
 cmd/upl.c                              |  36 +-
 cmd/ximg.c                             |  14 +-
 common/Kconfig                         |  15 +-
 common/spl/spl.c                       |   2 +-
 common/spl/spl_fit.c                   |   8 +-
 common/spl/spl_upl.c                   | 114 +-----
 common/splash_source.c                 |  18 +-
 common/update.c                        |   7 +-
 configs/chromebook_bob_defconfig       |   1 +
 configs/chromebook_coral_defconfig     |   1 +
 configs/chromebook_kevin_defconfig     |   1 +
 configs/chromebook_samus_tpl_defconfig |   1 +
 configs/qemu-x86_64_defconfig          |   9 +-
 configs/qemu-x86_defconfig             |   2 +
 configs/qemu_arm64_defconfig           |   2 +
 configs/qemu_arm_defconfig             |   2 +
 drivers/core/ofnode.c                  |  57 +--
 drivers/misc/qfw_acpi.c                |  37 +-
 drivers/misc/qfw_smbios.c              |  45 ++-
 drivers/pci/pci_rom.c                  |   3 +
 drivers/serial/ns16550.c               |   2 +-
 drivers/video/bochs.c                  |   1 +
 drivers/video/video-uclass.c           |   1 +
 dts/Kconfig                            |   2 +-
 include/abuf.h                         |  25 ++
 include/alist.h                        |   2 +-
 include/cpu.h                          |  14 +
 include/dm/ofnode.h                    |  15 +-
 include/image.h                        |  39 ++-
 include/spl.h                          |   3 +-
 include/upl.h                          | 211 +++++++++--
 include/video.h                        |   2 +
 lib/Kconfig                            |   1 +
 lib/Makefile                           |   5 +
 lib/abuf.c                             |  21 +-
 lib/alist.c                            |   2 +-
 scripts/build-qemu.sh                  |  28 +-
 test/boot/upl.c                        |  72 ++--
 test/common/Makefile                   |   4 +
 test/dm/core.c                         |   5 +
 test/dm/ofnode.c                       |  19 +
 test/lib/abuf.c                        |  27 +-
 test/py/tests/test_upl.py              |   2 +-
 tools/Makefile                         |   3 +-
 tools/fit_image.c                      |   8 +-
 tools/image-host.c                     |  23 +-
 tools/mkimage.h                        |   2 +-
 63 files changed, 1445 insertions(+), 670 deletions(-)
 create mode 100644 boot/upl_exec.c

-- 
2.43.0

