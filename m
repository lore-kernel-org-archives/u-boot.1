Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD2B606A31E
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 14:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=NryVDBRa;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=YpF7kvl7
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 66A8E80D8F;
	Mon, 23 Nov 2026 14:22:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A2Pm7ElWcmvR; Mon, 23 Nov 2026 14:22:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F0D2180D3E
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795443761;
	b=PfqDjVu33UQ5FbN3TG6OrbE0eO9oipZwzlScCkogfzKjS8jYOT4A3udt6ZM/qRl7BOFf
	 9j1NjggHZF1hnbiQV3N4VaOukx/Dt5PNDbXRBPtXz+9O8uhGNeAPnIH70CED2D+gdYL+u
	 GNorHTFvHxgQFWZATP5sJMm3K3/aSJlNr3U++QxDPIEjf5vHX9KB+K4TyTGfjcLp0kO+P
	 /keo3/U3/zkfHGHElZj84DPQnO1fK4xh1cidj9zSV+Yin8RQWF8ArpqbUOAoRq4CqaALY
	 VdqofdyBBkHQ0MOQdL+GL6CxT6HyWSUuKTjZj2e2MwHdwhdlxOzzjRUnQO2ncY3Or2w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795443761;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=bcPbDYiZgT7pxC4ehH6XEXAvCFtNxd2cCkNxWIXQg6E=;
	b=IPP7iqGuoTRRFlAIf6WaDHMf4NpEJvIIl7hgW55B3GbA0nQVSw6xX5ULLeWViiMkwsqV
	 5i+6ExCYPzHikDGLMv2CBTkSAiM5gcxYF7N/Qv25uXsaYCqWDnxZmJVi7Hhg6Z1Sgn87M
	 tBxZaF8U2oyfG0Raa8iGXjzdwrWaA37MLvxALn1haTQPsiuwH9yzwoaNzu5hDHVrPtx/v
	 Z5aKrDWCfmL623t2JiA7PELzlyBUTefn76s2tGIUskU/2wm9bWtdZYL1dYBHdBBkooE9E
	 RSrMkHZ8KID93B1ynu+xVACOMnMu/PyTRtk4xcRJeLl7JvVWuj8swY23luhLbF1iBtQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795443761;
	bh=bcPbDYiZgT7pxC4ehH6XEXAvCFtNxd2cCkNxWIXQg6E=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=NryVDBRayeIdqsrwjmmPVYqVbH/6nvEel/9DCdDC+mnlf/UvDRExKypHbG1PVROlC
	 8ZoLAQD4YYOhwrGoNx4zr6fKc1wv/Zy4Z715UyLcHStBjbNcwFBgmRHr1jAAXoAmTz
	 U4ln0ywD4lmt8YQfGSTMtgmHB/7Um+VtOOadSvgMzY8TbwEi49kIRRVecOi5pPHn0s
	 5sIlCytexJG1iZ6egh/Gun+J+Pl8rMsvpTnoypcf9dO6Rt1y2YL5F5dSUavPzNH7Lj
	 NtTn45nAlKYTwvXixfXz/Sp4l4v3VP3q5pyhPocIRFQLz+1yzXi5VDpmcRRka2fpv5
	 XLPFIg0RM6KjQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F0D2180D3E;
	Mon, 23 Nov 2026 14:22:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B2F903A8
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 14:22:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 98DD3400BD
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 14:22:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W5LWX5FMsGl4 for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 14:22:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D5D8940060
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=185.246.84.56
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.84.56;
 helo=smtpout-02.galae.net; envelope-from=richard.genoud@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=YpF7kvl7
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D5D8940060
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 14:22:36 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 4336A1A16D7;
 Mon, 23 Nov 2026 14:22:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 0F5F6601E1;
 Mon, 23 Nov 2026 14:22:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id DA5DE11E68F3D; Mon, 23 Nov 2026 15:22:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795443747; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=bcPbDYiZgT7pxC4ehH6XEXAvCFtNxd2cCkNxWIXQg6E=;
 b=YpF7kvl7g3CjUYW0/obVcs6Vh8yLAGpda2LcjC3nVElXWbhMFU8QMMVvJ0T0rp/D05msRl
 9D4DT+0lX8PKXm1OyLshSdS2ws3dnRa1HJ8Bgddeo3XCfgC5Vn7jNaUygo3xYHZPR6Tpmf
 GaYL0Fpc/6u79VYop79jo2Kuawwh0STDDrsgLyeNK4EmmEOaLSlv2GF2FsomwwqbcMAg7E
 /jmRvg5HgSEAriGL8qhUTHUWUOCNmxgA2aa+YxFqdpkQvyB8IlVD0J3g9NMc9VNXunoc5G
 5l+A7aiiuqG+GxaJm2VIoHIy24o7GZfYRJ1E0CfI89HZNTwdrIytObZuilYA2Q==
From: "Richard Genoud (Synaptics)" <richard.genoud@bootlin.com>
Subject: [PATCH v2 0/8] Introduce Synaptics SL2619 SoC and RDK board
 support
Date: Mon, 23 Nov 2026 15:21:59 +0100
Message-Id: <20261123-sl2619_base-v2-0-9e3b28c77cda@bootlin.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAdMBGsC/1WNwQ6CMBBEf4Xs2ZqyKIgn/8MQ05ZF1iA1XSQaw
 r9b0Iu3ecnMmwmEApPAMZkg0MjCvo+AmwRca/orKa4jA2rMU633SroYyos1QgpzS4aypiidgbh
 4BGr4tdrO1ZflaW/khkWxNFqWwYf3ejemS+9nRvwzj6nSihrUzu2yujjYk/V+6LjfOn+Hap7nD
 3fOnxa6AAAA
X-Change-ID: 20261005-sl2619_base-26beae3f79ca
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Terry Zhou <terryzhou05@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Johan Jonker <jbx6244@gmail.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Michal Simek <michal.simek@amd.com>, Linus Walleij <linusw@kernel.org>, 
 Michael Srba <Michael.Srba@seznam.cz>, 
 Chris Packham <judge.packham@gmail.com>, Adam Ford <aford173@gmail.com>, 
 Marek Vasut <marex@nabladev.com>, Lukasz Majewski <lukma@nabladev.com>, 
 Simon Glass <sjg@chromium.org>, Anshul Dalal <anshuld@ti.com>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, Peng Fan <peng.fan@nxp.com>, 
 Alexander Sverdlin <alexander.sverdlin@siemens.com>, 
 Billy Tsai <billy_tsai@aspeedtech.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Torsten Duwe <duwe@suse.de>, Ryan Chen <ryan_chen@aspeedtech.com>, 
 Guodong Xu <guodong@riscstar.com>, Yixun Lan <dlan@kernel.org>, 
 Jisheng Zhang <jszhang@kernel.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
X-Mailer: b4 0.16.1-dev-53874
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This commit adds initial support for the Synaptics SL2619 SoC, part of
the Astra SL2610 product line.

The bindings and DTS have been sent on the LKML by Jisheng Zhang:
https://lore.kernel.org/lkml/20261115102401.3520-1-jszhang@kernel.org/
But not merged yet.

For this early support, we have:
- DRAM declaration
- CPU reset via PSCI
- Generic ARMv8 core timer
- UART
- system controller
- clock driver
- reset driver
- pinctrl/pinconf driver

Note: checkpatch complains "WARNING: Use the livetree API" in file
arch/arm/mach-synaptics/cpu.c
But there's no livetree equivalent for fdtdec_setup_mem_size_base() and
fdtdec_setup_memory_banksize()

yet settled. In this revision, it's 1 for strong pull-up and 0 for
normal pull-up, like for:
https://elixir.bootlin.com/linux/v7.3.1/source/Documentation/devicetree/bindings/pinctrl/spacemit,k1-pinctrl.yaml#L73-L78
But in the next revision, this may change and use only the normal
pull-up since the strong one is not used.

Note2: for the pinconf driver, the handling of the strong pull-up is not
---
Changes in v2:
- rebase onto v2027.01-rc2
- Use N: in MAINTAINERS to match all files
- make ARCH_SYNAPTICS select ARM64
- add system controller driver
- add clock driver
- add pinctrl/pinconf driver
- add reset driver
- enlarge SYS_MALLOC_F_LEN for ARCH_SYNAPTICS
- Drop clock-frequency property in sl2619-rdk-u-boot.dtsi (now unused)
- add bootph-all in sl2619-rdk-u-boot.dtsi for console dependencies
- Link to v1: https://patch.msgid.link/20261022-sl2619_base-v1-0-ef20cc43d78b@bootlin.com

To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Richard Genoud <richard.genoud@bootlin.com>
Cc: Terry Zhou <terryzhou05@gmail.com>
Cc: Casey Connolly <casey.connolly@linaro.org>
Cc: Johan Jonker <jbx6244@gmail.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Linus Walleij <linusw@kernel.org>
Cc: Michael Srba <Michael.Srba@seznam.cz>
Cc: Chris Packham <judge.packham@gmail.com>
Cc: Adam Ford <aford173@gmail.com>
Cc: Marek Vasut <marex@nabladev.com>
Cc: Lukasz Majewski <lukma@nabladev.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Anshul Dalal <anshuld@ti.com>
Cc: Junhui Liu <junhui.liu@pigmoral.tech>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>
Cc: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: David Lechner <dlechner@baylibre.com>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Torsten Duwe <duwe@suse.de>
Cc: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Guodong Xu <guodong@riscstar.com>
Cc: Yixun Lan <dlan@kernel.org>
Cc: Jisheng Zhang <jszhang@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>

---
Richard Genoud (Synaptics) (8):
      arm: synaptics: add SL2619 SoC and RDK board support
      arm: dts: sl2619: Introduce sl2619-rdk-u-boot.dtsi
      Kconfig: enlarge CONFIG_SYS_MALLOC_F_LEN for ARCH_SYNAPTICS
      soc: synaptics: add sl2610 system controller support
      clk: synaptics: add Synaptics sl2610 family clock drivers
      pinctrl: synaptics: Add sl2610 SoC family pinctrl driver
      reset: synaptics: add sl2610 reset driver support
      configs: sl2619: enable basic drivers and commands

 Kconfig                                          |   3 +-
 MAINTAINERS                                      |   7 +
 arch/arm/Kconfig                                 |  23 +
 arch/arm/Makefile                                |   1 +
 arch/arm/dts/sl2619-rdk-u-boot.dtsi              |   9 +
 arch/arm/mach-synaptics/Kconfig                  |  35 +
 arch/arm/mach-synaptics/Makefile                 |   5 +
 arch/arm/mach-synaptics/cpu.c                    |  45 +
 board/synaptics/sl2619/Kconfig                   |   9 +
 board/synaptics/sl2619/Makefile                  |   5 +
 board/synaptics/sl2619/sl2619.c                  |  73 ++
 configs/synaptics_sl2619_defconfig               |  63 ++
 doc/board/index.rst                              |   1 +
 doc/board/synaptics/img/sl2610_boot_sequence.svg | 178 ++++
 doc/board/synaptics/index.rst                    |   9 +
 doc/board/synaptics/sl2619.rst                   | 100 +++
 drivers/clk/Kconfig                              |   1 +
 drivers/clk/Makefile                             |   1 +
 drivers/clk/synaptics/Kconfig                    |  12 +
 drivers/clk/synaptics/Makefile                   |   1 +
 drivers/clk/synaptics/clk-sl2610.c               | 438 ++++++++++
 drivers/clk/synaptics/sl-clk.c                   | 266 ++++++
 drivers/clk/synaptics/sl-clk.h                   |  29 +
 drivers/clk/synaptics/sl-sysmgr-clk.c            |  76 ++
 drivers/clk/synaptics/sl-sysmgr-clk.h            |  44 +
 drivers/clk/synaptics/sl2610-pll.c               | 127 +++
 drivers/clk/synaptics/sl2610-pll.h               |  12 +
 drivers/pinctrl/Kconfig                          |  11 +
 drivers/pinctrl/Makefile                         |   1 +
 drivers/pinctrl/pinctrl-sl2610.c                 | 992 +++++++++++++++++++++++
 drivers/reset/Kconfig                            |   8 +
 drivers/reset/Makefile                           |   1 +
 drivers/reset/reset-sl2610.c                     | 283 +++++++
 drivers/soc/Kconfig                              |   1 +
 drivers/soc/Makefile                             |   1 +
 drivers/soc/synaptics/Kconfig                    |  11 +
 drivers/soc/synaptics/Makefile                   |   2 +
 drivers/soc/synaptics/sl2610-syscon.c            | 118 +++
 include/configs/synaptics_sl2619.h               |  14 +
 include/soc/synaptics/sl2610-syscon.h            |  23 +
 40 files changed, 3038 insertions(+), 1 deletion(-)
---
base-commit: 1f5c6df1bc042b3342473e6ebc50fe20eeebd728
change-id: 20261005-sl2619_base-26beae3f79ca

Best regards,
--  
Richard Genoud (Synaptics) <richard.genoud@bootlin.com>

