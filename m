Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2571606A327
	for <u-boot@archiver.kernel.org>; Sat, 14 Nov 2026 20:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=P+NwE+P+;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xKi20pFH
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6CC87811CD;
	Sat, 14 Nov 2026 20:39:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7cCfTbs52mx2; Sat, 14 Nov 2026 20:39:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5FB6F8102A
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794688798;
	b=OUImI5IHI4CPESMnY2gXqhMzJJbmuZN/3SaYki3xzAJ4G/+chm5C91tisPlPEDHuaVIA
	 6RaA7qswTEk4Sk3lLAQt5801C5uvPUAz935IUm75TQsEcoEFzWBZ9e0rwZQcXWvef6A6X
	 5ZXNRHsjn0eeetGjSGIMJDEFSQMo8gXf83S5Aj4f6DWIAgp4yxaQ6wLS+7T8NrIbuRUCp
	 N1dg+FHXNIVsEZbjZBhinn2ZDUusozcA8r3j8aoUQmYDWOlwwTma/VroRUi/tgTVL8aLg
	 Kbqkc8Qr5IRqu3Lr3F5V6ULumB4FyI4SHyZTpmFzuoLWkb4/Cl0qiUlKMr6kiZew2BQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794688798;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=jTfLXigS10goqIOWJzgOqsSfsgNhl44EgEWHtLDRk/c=;
	b=qDmdRknyF/T8Q+5D+ft0p2DVRrkO+LTz1t0GFnjB2EnxI+DrN6VG1vgy/+PO0vYRM0q2
	 aWm6j9dCnBr3hgxZcTk2cf5Rt/C6pxC5Rh0zr7WhFAMM2g/9Lj9oZ+RMpIqiXpg1+qcK3
	 CDqx6/uG+XdCPxHU1vJ8RQLnB9T6dukhmr6q/cNeyF3kl4vrNHZ3ENkeweSjLdW4ZVFsz
	 WNjwIvyeDrsArl19pJWcIh3nSeLZvz+dbxWRpjOVhm4OaGAwUuNbRTTyf94KvfDRdH3VG
	 da/uKkk3GmC4w3tsSiKuWaeXjp+MGZiGZWifCARrGmLGZipZkv2pjE4Hng2+zkpd3BQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794688798;
	bh=jTfLXigS10goqIOWJzgOqsSfsgNhl44EgEWHtLDRk/c=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=P+NwE+P+Bu42OtAk/fzmlShzxSfixKLprqFBUHipbHKaCRRWlSoMMVbWD5xwYOWt6
	 K/uR919fU7Hu2FeooAhbhEdhZp9aFhEeHRUrIMYBfRWC6pwBOBgazBEEcmy5J9idcI
	 YOhxxPVdzBWJxo1m0ft5aqWnBTljguHYA+rotihd/z8ek4nHOjoTX9qQlQOQxuFbyj
	 +NBKizq5a3rOgZLtzy2L5VN1ieHLWhgihhUpSifg6BWx49G9rJ+/UdjNCtHDs5dR3h
	 x++eg4HjBlTP/w8DdWVQ+4k0Mry8buMJ9Qhj/JETRpxyUTa8PPgHqokaMiGVNkZZSJ
	 gZaHxsbGcsHlw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5FB6F8102A;
	Sat, 14 Nov 2026 20:39:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6ABE872D
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 20:39:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 49A2240645
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 20:39:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ktJn9hOPFu6A for <u-boot@lists.u-boot-project.org>;
 Sat, 14 Nov 2026 20:39:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 60FA140639
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::132a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::132a; helo=mail-dy1-x132a.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=xKi20pFH
Received: from mail-dy1-x132a.google.com (mail-dy1-x132a.google.com
 [IPv6:2607:f8b0:4864:20::132a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 60FA140639
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 20:39:55 +0000 (UTC)
Received: by mail-dy1-x132a.google.com with SMTP id
 5a478bee46e88-36fc0a3fe93so4060826eec.0
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 12:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794688795; x=1795293595;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jTfLXigS10goqIOWJzgOqsSfsgNhl44EgEWHtLDRk/c=;
 b=xKi20pFHERKJ2ZXm0lGFHcfjMh4/CuDTUZIgLNfBqoZv7TVIDWqkQM+SThDJHcO9le
 Q8T8pQb7Ekd8L45Xk5jD4btmhjOs9NMBP/xnCsHL5x8RiLHmI59y+zWvLOnOvgRAdaUj
 Fmw7x7n8S5Wb5bwiSD1BsXxEfjJbTOJsAouHlikdBK3Sjh5AGqOMRTncPZ2SLy3CT1s1
 w2qn7Bs2n8mgBtBeEzurOyFMZIJ1951qHJC944RhdgI/jvQ8YTjzBncJ5EFwhnlj0Y3l
 zYB0TCL2y81vxCB5Nn6iywlUW/QqVKRUdoNe1VVcRrrFaVsgllhgnQoefJux5rbobm93
 ftkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794688795; x=1795293595;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jTfLXigS10goqIOWJzgOqsSfsgNhl44EgEWHtLDRk/c=;
 b=r8HZnYoXsFAtd7092sr3SP8W2B0Og2ESiN92QCDQFv1W1lnkYX4FVKemlTB68wiY+O
 P+vAHmFBqO03zreZWUh1JJ4GN3mqdXSoS67MRkHxE2FAU/SI2AfsvNJOWTsIL7rvi8pP
 3r3+Vp+KsVEyTpSHZSsEJbOpmNJtx4pDoVIxCVI7A/DPYbqIRu8Nd3FfVKt67PoKxQah
 rCy662pvmUWn6J3eYF/Y60KEXyUPPBvBfqaN9JFXnkicYU6m06WAGDI5wgEhvJpKd6kF
 Y4nLbE+vf7VIT09BKuUBnuOgIWIRJAFnlclP2K8b7Ag7Ugf8gGdwypu6nBeudiNxYP0E
 ymFQ==
X-Gm-Message-State: APuU4Z/B+8LJLkU/dJvC4brVhDwW0ggOJOsDlpIhIYNDCLTgbdQ7/H6z
 rcDRFpQKK8vtgnJxm+ax5TIcfTKAz5xUA/XcMEKqaKP+dW1y4yLVFMOY
X-Gm-Gg: AYBFou0S2mE9rIZW2yLyCjNimcZv6bwYu6sDZuAbY4Z3KNtLb/AMz+o540Tl/jQK77Y
 a/0OW7QvJ5osldAq+H4yQgydaumY9j0Uv71GY2LaGkGSK6hrelFSUWQJ1rD4aALINxg9/A5BWBb
 q8ewGvZ9cJKH91GcPzF4tUkUiEt2uMeFTb4BVZDx1fcXwCoDb5i4mGDlfE25apEtxCAWf1WqWOW
 CVlb16uyF+r3mQU0cqy53nAEHQW8EYylw4YZ4ccEECY6y+uVqkZhhrFpt5N5bE5gRBUslxoeojp
 aZkolr7tHLtdmWQWdeU6j4dEyC/KpRT/A66uMiEcQDqSt4fRqQdcLPjtc5x9GPa5ynI7plxlq4K
 z/sYTJEhe5oVMNsuQwmlNGaL+PW1JDmfDeOm0Zga/Pb4KmfFQvdpBScOn+adRNSSYr1L7J56gPG
 r2/kqdZw3RI6Caotn4c6ak7lGYrFHzTeuI6MO2CuOjCPoSxDocbnDoIxnjJvMiCaqgqmdU+F+3f
 ptIO2Fe0p8Na6SubplYa0u03Q+WOlyKoGGcaWYdjPHJ3sWrIUTSQabk6w7KWLKXeoEhi92AnYlq
 Xk2yEyAk4nVb1Zz4dbPD4leM+WU72CVpWt1oqyUOkR0keJGybM0rE9CQ6e+If6+AfnSo4iZSo2f
 jAtjqAEKw4eRAu/LcTHBKu6uu
X-Received: by 2002:a05:7300:e9cf:10b0:36a:75aa:33bc with SMTP id
 5a478bee46e88-37966a5a7d2mr6908360eec.24.1794688794687; 
 Sat, 14 Nov 2026 12:39:54 -0800 (PST)
Received: from fabio-X870-EAGLE-WIFI7.tail2bb604.ts.net
 ([2804:1b3:a803:1afe:bf27:fe9c:1ff2:8106])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3795378d73dsm19851452eec.2.2026.11.14.12.39.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 12:39:52 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.u-boot-project.org,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tomas Paukrt <tomaspaukrt@email.cz>, Marek Vasut <marex@nabladev.com>
Subject: [GIT PULL] Please pull u-boot-imx-main-20261114
Date: Sat, 14 Nov 2026 17:39:48 -0300
Message-ID: <20261114203948.1521305-1-festevam@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
	SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tom,

The following changes since commit 8ea02c99391d2d922810065206721ead2863f075:

  mailmap: update entry for Viacheslav Bocharov (2026-11-10 14:57:48 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-main-20261114

for you to fetch changes up to c26b629e58d053e3bc9cd3d2d1a034850ce58022:

  configs: colibri_imx7: add missing defined() in EMMC #elif (2026-11-11 14:43:47 -0300)

u-boot-imx-main-20261114
------------------------

CI: https://git.u-boot-project.org/u-boot/custodians/u-boot-imx/-/pipelines/2004

- Fix i.MX9 SoC detection with SKIP_EARLY_DM and add LPUART debug support.
- Fix a carrier configuration buffer over-read and several Toradex board initialization issues.
- Correct SoC variant reporting on Apalis and Colibri i.MX8 modules.
- Switch Data Modul i.MX8M eDM SBC boards to upstream device trees.

----------------------------------------------------------------
Francesco Dolcini (15):
      board: toradex: tdx-cfg-block: fix carrier config block buffer over-read
      board: toradex: smarc-imx8mp: fix always-false phandle check
      board: toradex: aquila-am69: initialize ret in spl_board_init()
      board: toradex: apalis_imx6: fix do_fuse argv[1] NULL deref
      board: toradex: colibri_imx6: fix do_fuse argv[1] NULL deref
      board: toradex: apalis-imx8: report detected SoC variant in board_name
      board: toradex: colibri-imx8x: report detected SoC variant in board_name
      board: toradex: colibri_imx7: un-nest board_late_init from CONFIG_USB_EHCI_MX7
      configs: verdin-imx8mm: remove empty #if/#endif block
      board: toradex: apalis_imx6: remove dead ldo_mode_set()
      board: toradex: colibri_imx6: remove dead ldo_mode_set()
      board: toradex: apalis_imx6: drop dead TDX_APALIS_IMX6_V1_0 Kconfig option
      board: toradex: common: fix stale #endif comments in tdx-common.c
      board: toradex: apalis_imx6: fix stale #endif comment in board_late_init()
      configs: colibri_imx7: add missing defined() in EMMC #elif

Marek Vasut (1):
      arm64: dts: imx: Switch Data Modul i.MX8M eDM SBC to OF_UPSTREAM

Tomas Paukrt (2):
      serial: lpuart: add debug UART support
      imx9: soc: read the SoC information after relocation with SKIP_EARLY_DM

 arch/arm/dts/Makefile                              |   2 -
 arch/arm/dts/imx8mm-data-modul-edm-sbc-u-boot.dtsi |  12 +
 arch/arm/dts/imx8mm-data-modul-edm-sbc.dts         | 997 ---------------------
 arch/arm/dts/imx8mp-data-modul-edm-sbc-u-boot.dtsi |   2 +-
 arch/arm/dts/imx8mp-data-modul-edm-sbc.dts         | 972 --------------------
 arch/arm/mach-imx/imx9/soc.c                       |  14 +-
 board/data_modul/imx8mm_edm_sbc/MAINTAINERS        |   1 -
 board/data_modul/imx8mp_edm_sbc/MAINTAINERS        |   1 -
 board/toradex/apalis-imx8/apalis-imx8.c            |   2 +-
 board/toradex/apalis_imx6/Kconfig                  |  10 -
 board/toradex/apalis_imx6/apalis_imx6.c            |  10 +-
 board/toradex/apalis_imx6/do_fuse.c                |   4 +-
 board/toradex/aquila-am69/aquila-am69.c            |   2 +-
 board/toradex/colibri-imx8x/colibri-imx8x.c        |   2 +-
 board/toradex/colibri_imx6/colibri_imx6.c          |   8 -
 board/toradex/colibri_imx6/do_fuse.c               |   4 +-
 board/toradex/colibri_imx7/colibri_imx7.c          |   3 +-
 board/toradex/common/tdx-cfg-block.c               |   2 +-
 board/toradex/common/tdx-common.c                  |   4 +-
 board/toradex/smarc-imx8mp/smarc-imx8mp.c          |   2 +-
 configs/imx8m_data_modul.config                    |   1 +
 configs/imx8mm_data_modul_edm_sbc_defconfig        |   2 +-
 configs/imx8mp_data_modul_edm_sbc_defconfig        |   2 +-
 drivers/serial/Kconfig                             |  10 +
 drivers/serial/serial_lpuart.c                     |  70 +-
 include/configs/colibri_imx7.h                     |   2 +-
 include/configs/verdin-imx8mm.h                    |   4 -
 27 files changed, 106 insertions(+), 2039 deletions(-)
 delete mode 100644 arch/arm/dts/imx8mm-data-modul-edm-sbc.dts
 delete mode 100644 arch/arm/dts/imx8mp-data-modul-edm-sbc.dts
