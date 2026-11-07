Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7E3606A326
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 17:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=y7G/ceQB;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eILR3iQL
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5186F6066D;
	Sat,  7 Nov 2026 17:55:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YMvZEZU-YLF9; Sat,  7 Nov 2026 17:55:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4F57660664
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794074104;
	b=cXz/mOqqNFe1cI5MP5K76UFuW9OWVAnIilrFG0/hwqveIL9GexstW4eBQDaCPl/PAn1e
	 zXCf5RGBp3DgMRtrA1r8IHHkXbIKKKNcYWj+4Pu+pfij3i+rI/TLUmBeNok30zbDfMr8W
	 M4j5G019U6ZZvM86Chkor7q0hK3faPTJDiSVMw4fNa9kdRvWiFNw5+4S+3uSS6j9zhh97
	 0/+H8s1omnhlZt/fbU1pQ++okU4qxHg+WF0RzFoUARHaJ3YbnB5n5yNphud7TTHwIlfoK
	 vNW96ihZrGgYARB8tjTRmdv7eeUpmYk9kGzmoYkPQiEsligE8uVuciGcpGxCsHfv2zw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794074104;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=5iujmV33S/M/QJqsMxp3jhUyMiaxF1wGB4uuQVi6+4E=;
	b=KfoeAbIq0K8iTW6t4x1cxqI7mNS04EDYVoybIlRKQ4vBYVVbJ4kQoASEdwavfdi2rACT
	 q+3SPeS2ilNUGvxwVHRp05Q+VvDQ0XRAUjM5PHaUyKgrhIc/j6KblmkSOxyTJtI7KKBL+
	 sTUiupZv6K2so6nIrysgksuujeJUxIolF3TnckhJ+hacoy2R6oElQUllupk1leAG1Qcd4
	 bjJQEwC6/bTe9FzQmZvCTs0OsA1IbY7a2p8GZOOx4Qm7QNb/C9PRf4mAjyxcONQ3EQ5Ap
	 D93Qo/xT40g3MjPlkBlStQ5dSy6WhO9QAXVOTlZsroQ6R7ixINeRjHYFNwwA9OU7ysQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794074104;
	bh=5iujmV33S/M/QJqsMxp3jhUyMiaxF1wGB4uuQVi6+4E=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=y7G/ceQBXvWhzBLwRVLPjQbfWkkMAb8V3484P3ReXpL86jV7f8BsujydPOdnuSxqF
	 Lo7mDWCjE+lcwhICk3hNW2JZxfE52Rx3Q6eBOTuio+gnfoTvXHLvvO1Dqtt1bic/Lh
	 3cAE4eNDvW2T0jMZdcDA6QJiMWhdQ6NwFQpzGIOoaYjSKH47zttU7oLmNhGMTPk5X2
	 jebtPBQDL3DFSIPhiUC5MPkQNGmx3eINpZED3BISguusDX49VU/EdBZwPsye6mRdhk
	 ZkUi8k/7bQcks+jlGakNLhZKlKGQPcCSetCLgAJRt3mDxO7DdLtCrug/cGpu1U+6tI
	 kTpNFs3gb8/rw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4F57660664;
	Sat,  7 Nov 2026 17:55:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id C913837D
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 17:55:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AEAEE400A9
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 17:55:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v1xeN04RMdX0 for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 17:55:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 6EF744009B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::a2c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::a2c; helo=mail-vk1-xa2c.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=eILR3iQL
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com
 [IPv6:2607:f8b0:4864:20::a2c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6EF744009B
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 17:55:01 +0000 (UTC)
Received: by mail-vk1-xa2c.google.com with SMTP id
 71dfb90a1353d-5ebf39def3aso591728e0c.3
 for <u-boot@lists.u-boot-project.org>; Sat, 07 Nov 2026 09:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794074101; x=1794678901;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=5iujmV33S/M/QJqsMxp3jhUyMiaxF1wGB4uuQVi6+4E=;
 b=eILR3iQLFvEWCCdejMlr5lLCIMJvGcc+FJmIVeJW7bDBM+/cQGusshg6j7fEA1ThTO
 8ENzoyvJ8yTsUeziCmLCPYF/ZOP/qS4pQvRdwlq+yLZ20JiyTZ5FLajmSvFOD6GQtJ7U
 fHIqcH02G0x22MQXC8hkxeF32ga21tOZztGBPPW1zrGwjIb8hKF7vwzK7lAj5Vbmp6f7
 464kaeIkIWX9Y/RuJjtUKQpaSd36ubYvLwv6SRok8WMFSSnwqX2rcMJla7djTL9qujDz
 rbqJzwF6zJLAhwg9Hme3ZSP7wEBEj2KbS2+VHA1qA1vsAo4QAT+Q6tQYKPtgajK+gVKN
 1YhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794074101; x=1794678901;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5iujmV33S/M/QJqsMxp3jhUyMiaxF1wGB4uuQVi6+4E=;
 b=YRfdIxyOD/rEwJty0iU49WERfQj/G+7eizrcPm58OufygmnE51CmkzaszyWgZDowrH
 me6D1bhYS5zV3p/+/a+vPkQn6dZvXztQwXQmnNp57zoF1G3KdkHnIyAdProdDl5v+X/A
 HHKzqNqG1BxOhvqVTTqjXps6EuJKmPYNf1FeWE3mquF4sejpb6Qmy5XDFoEqlSbZyJla
 jytsfFqN+Q7f1+RcK3Md96GNtbSAvkY8wQaTNTXLZByaOiXQzZCGoHA20jUZqCOPHDwc
 S6SgA7RkXXefjpk4cEuOVA2+iioxaLHimsK/1BL/nWWGxUgMFFU6wcYhWvMtTwcWPnyn
 Zozg==
X-Gm-Message-State: APuU4Z/QG+9CX7NKuOI6p92jOVfBiy9f5e1C/Qwfnz+8yRnJ6H/3/z6i
 k16AgndTBxYi9RkdqNbTUq9Bnat1nfbsU1yYZ7zBYhuZQ43/pMzFzx39
X-Gm-Gg: AYBFou0Y9Ihzc2uW0ITERMcfQ3YPAYZBNVrAJt/TSAKxw07F5IMszVbSBKGRMrKWsav
 zyhwKUN74fLf/iFGEHbs+iJXEHsTueNJyQ8JBS+/pFNAEUCKgjTX8sKSf4xLNnO5bs6CNge5W+K
 V+D/vFM0biZCBQNpYQ34PqYAJek87JR4u/cX+UgIsBSx/JogWwYkUQ23FrmvnmPUz4pICXIHGms
 IfUSwZIXeDuMx/vRWCNNaGDDgT0mqQKOVECCp1SMq/Yyrm0pK9HMWWE0Jye9573PGJZ6IExs27Y
 YRWW7U/Q1pVTknFFm9nAtTFnj+zgoPGvnjv+pPOxRWUCmlPlAlxEfj2jZy9RUwHvJHd8cMPyuDk
 SSOzVRCa/6Xtjt8FxsOFQGyGWFyiLVoMONtJ2OsdMgjP51rJmAfIt9ezl5LYtSFe8uMn2wBfheS
 q740hJy9oUcIe9aTRlisdS5moE20Nmo1wdnva3wsLF1AtLvEGMicvM7fuOZBKTy4qhYEVYUGt8r
 lz/EupGE1sdSLGM5aWq/0i6E7FJRL8hHt3ZVpcHDzFILPamFTFA+IsYSkFN9lsiWU5JtnOyBwke
 +H6Sl2bBawG6kx+oGN+yonfsSvPmz5JExqKfmjTuQ4Te8MexMX+VHGZp07DjTLJsR8mlcW65nUV
 Dj7McrsIVq3xqOp9a6n1GMr8=
X-Received: by 2002:a05:6102:54a4:b0:7c5:4da3:aefb with SMTP id
 ada2fe7eead31-7d2a16eba5dmr2352333137.34.1794074100488; 
 Sat, 07 Nov 2026 09:55:00 -0800 (PST)
Received: from fabio-X870-EAGLE-WIFI7.tail2bb604.ts.net
 ([2804:1b3:a802:b7f6:dcc2:7737:acb0:b2d6])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-99c029dc1fdsm2770241.3.2026.11.07.09.54.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 09:54:59 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.u-boot-project.org, atul.akella@gmail.com,
 ddrake@baylibre.com, dario.binacchi@amarulasolutions.com,
 francesco.dolcini@toradex.com, jeremie.dautheribes@bootlin.com,
 primoz.fiser@norik.com, quentin.schulz@cherry.de, tomaspaukrt@email.cz
Subject: [GIT PULL] Please pull u-boot-imx-main-20261107
Date: Sat,  7 Nov 2026 14:54:51 -0300
Message-ID: <20261107175452.9295-1-festevam@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tom,

The following changes since commit feb8913982e4462c01fd914271f92254a25dc101:

  Merge tag 'xilinx-for-v2027.01-rc2' of https://git.u-boot-project.org/u-boot/custodians/u-boot-amd (2026-11-06 09:59:06 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-main-20261107

for you to fetch changes up to 3333824b70df2709de00edaca178436a1c337ba2:

  imx93_frdm: prefer fastboot over regular boot in recovery mode (2026-11-06 16:49:30 -0300)

u-boot-imx-main-20261107
------------------------

CI: https://git.u-boot-project.org/u-boot/custodians/u-boot-imx/-/pipelines/1880

- Add binmam support for signing i.MX93 images.
- Keep ddrmix_initialized out of .bss to fix regression on i.MX8M.
- Make room for distro kernels and initrd on imx93_frdm.
- Adjust the fdt_addr_r and initrd_addr location on i.MX8MP Engicam.
----------------------------------------------------------------
Atul Akella (1):
      remoteproc: imx_rproc: make bounds check overflow-safe

Daniel Drake (2):
      imx93_frdm: make room for distro kernels and initrd
      imx93_frdm: prefer fastboot over regular boot in recovery mode

Dario Binacchi (4):
      board: engicam: imx8mp: adjust the fdt_addr_r and initrd_addr location
      ddr: imx: keep ddrmix_initialized out of .bss
      imx: fdt: drop the cooling devices of the disabled cores
      net: dwc_eth_qos: Support external RMII reference clock on i.MX8M Plus

Francesco Dolcini (1):
      toradex: apalis-imx8: Disable PCIe B without on-module Wi-Fi

Jérémie Dautheribes (Schneider Electric) (9):
      binman: add nxp_imxcst base etype for i.MX CST signing
      binman: nxp_imx8mcst: use the nxp_imxcst base etype
      binman: add nxp_imx93cst etype for i.MX93 flash.bin signing
      imx93-u-boot: wrap SPL and U-Boot nodes in a CST node if AHAB_BOOT enabled
      doc: imx: ahab: add AHAB introduction
      doc: imx: ahab: add i.MX93 secure boot guide
      binman: test: add a helper to mock the cst bintool run_cmd()
      binman: test: use the cst mock helper in testNxpImx8mCSTSigned
      binman: test: add code coverage for nxp_imx93cst etype

Primoz Fiser (1):
      imx8m: soc: Disable OP-TEE CAAM job ring in kernel device-tree

Quentin Schulz (1):
      doc: imx: mxs: remove link to Denx's mirror for elftosb

Tomas Paukrt (1):
      net: fec_mxc: fix double free of shared MDIO bus

 .gitignore                                 |   2 +
 arch/arm/dts/imx93-u-boot.dtsi             |  54 ++--
 arch/arm/mach-imx/fdt.c                    |  58 ++--
 arch/arm/mach-imx/imx8m/clock_imx8mm.c     |   5 +-
 arch/arm/mach-imx/imx8m/soc.c              |  10 +-
 board/nxp/imx93_frdm/imx93_frdm.c          |   7 +-
 board/nxp/imx93_frdm/imx93_frdm.env        |  11 +-
 board/toradex/apalis-imx8/apalis-imx8.c    |  55 ++++
 doc/board/nxp/index.rst                    |   1 +
 doc/imx/ahab/guides/mx93_secure_boot.rst   | 297 +++++++++++++++++++
 doc/imx/ahab/introduction_ahab.rst         | 460 +++++++++++++++++++++++++++++
 doc/imx/common/mxs.txt                     |   4 -
 doc/imx/index.rst                          |  14 +
 drivers/ddr/imx/imx8m/ddr_init.c           |   2 +-
 drivers/net/fec_mxc.c                      |   9 +-
 drivers/net/fec_mxc.h                      |   1 +
 drivers/remoteproc/imx_rproc.c             |   7 +-
 include/configs/imx8mp_icore_mx8mp.h       |   4 +-
 tools/binman/etype/nxp_imx8mcst.py         |  60 +---
 tools/binman/etype/nxp_imx93cst.py         | 111 +++++++
 tools/binman/etype/nxp_imxcst.py           | 120 ++++++++
 tools/binman/ftest.py                      | 125 +++++++-
 tools/binman/test/vendor/nxp_imx93_csf.dts |  18 ++
 23 files changed, 1306 insertions(+), 129 deletions(-)
 create mode 100644 doc/imx/ahab/guides/mx93_secure_boot.rst
 create mode 100644 doc/imx/ahab/introduction_ahab.rst
 create mode 100644 doc/imx/index.rst
 create mode 100644 tools/binman/etype/nxp_imx93cst.py
 create mode 100644 tools/binman/etype/nxp_imxcst.py
 create mode 100644 tools/binman/test/vendor/nxp_imx93_csf.dts
