Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92B77CA601F
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 19:54:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5AE7581155;
	Fri,  9 Oct 2026 19:54:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UWt_IBjxgwOT; Fri,  9 Oct 2026 19:54:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6E163812FA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791575654;
	b=FijVzLz5UvBAisW+NfHFrBVOc2GHv5mTVMRbswTFavWK0RJ5yfeqVvUCMjiMxZgKX+md
	 klxkx799hH36I8MEo1D1Mfz3h2MN9AqlFAW0jsInHdowt/KsVVViMOe0KrW8cUV6wl2lk
	 gihLHLQ2BD+Zk8hbinpAh30m1rexJRXiiPHb6SC2QlEJ7PPDZ/Bq0YhlF/65wg+ot+T11
	 yw4n8sRoP6SL635NtjtUYYaIhTuFMxGLdBFk+/5TA8gqreOdp5oeEblpjrPKEcT5gH4gS
	 fWXC+3iafXsYnMkURT3gWiPOrKDnYRWUtysq8WQOG0MVION+MCGk7iSz1UpoZyoJaFA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791575654;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=2dV5gWyYJkCO6wpZ8RBkYetC98qbt9HmUExufznl6c0=;
	b=ObifCrhRQ7M403fbJkBGktI5dninimrsCTs0nA+SLo4fmGaWurNRGQGczi8oI7XeO9HW
	 h4wudt4pfze0BLYcQF5TJBab5PGWU5MzJcL3AuxINbebIaXaLXV/J4wWfcgq6S9j/Idjw
	 g5VvKn3ck0U9tDM8S5FQRao6iNx+P85SaqDD6HU8/x9nyfL4d0xWcj/WKh66LbaxgB42L
	 z7pNkvME1kRQ1aRp1gednBU73+D99Q4uVOgs7its4CiqofwAJwTn4MEKuXDG7385VQXpH
	 yKdmtXCjPl3Y3GUWloOqdSnli2HOrJMZJ2PhyZUl4mAjeq+DyOWjXlKh+UleXi4luYQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=mainlining.org;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=og7UpCsb;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=NkBoSVzm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791575654;
	bh=2dV5gWyYJkCO6wpZ8RBkYetC98qbt9HmUExufznl6c0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=DgQw2S/qtyoUyh0GGpThjAoy4tyLRpzqo5UeGPSaTAACwsaKyRygw0dvBoAODusSP
	 scda3ZP6N7UDcV0lvlliKZMAuP5tt6h28W06oUyeOoQJvsODOsxALbGt21bCj4dXVi
	 L8KjXdJurTsTBsEqCDVTR9MOHTncQoM6WQAfZYboLwW5SWHPKsIHYiNLJzgaDSpE4S
	 73o3PRJeERd/QWO+OnFDLg9KjddqvCdWTJEpGdrcU1BVGQrPrzttUfaDH12kSnwwU6
	 Q1bv8OaQhucJj39kKTk0qiGjgQx6fdWQIhA5p5nrzbFzezmydP1OxmWVQz+/cdQ1t6
	 wEi79MuT3nbSw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6E163812FA;
	Fri,  9 Oct 2026 19:54:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with UTF8SMTP id 781A63B4
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 19:40:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with UTF8SMTP id 5D3D78148F
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 19:40:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024)
 with UTF8SMTP id mc6tvc66B3au for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 19:40:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A22B48148E
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791574807;
 b=qYd4JxBoza8iQ51NH7ltv04OfgRf7xK1KMQ9QdHswclz/wLYjs/+sR5H5Qbh7JryT3Lc
 epm0oKTGfB7Qt2xi93ILKVH+OHk8mDssK1Z+aoXj+5ynsoepgCg9+nI8dtR3POF8yimTW
 RHJU39w1FbyXij07teYaFIp8gSjnM8H8qpTUL2eOT/Jo5qMVLKp7F6PeMeCryRT8lAJyg
 d5Rn/XsPVnJv35RAADjpUdS0lTRrr3kz+f5MMZab2G0B47hygRO2s6yZEWFAl/2kxwQPv
 FmUnCSsPMCU8atffgprFPKtqJ96V6zv9M/s1lwP4CoWliZ3AC7Odo5XwA8cY3y0pnvg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791574807;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=2dV5gWyYJkCO6wpZ8RBkYetC98qbt9HmUExufznl6c0=;
 b=D+86AahF3VxBk62mPDJt6jrdankIUdJ/lP8NeU5qXjSE6Yjufo36ACsxzDBGMIdclfJK
 XOzNHaYIg0U0wz/kGPl2OZPZ8e8n53byBz+PgFs5qcssWwtJaDEuMxVpBDDv9Kvm9pKh8
 Nyl/u6kiFjAiutubtqHLaGqghbwP4R/d2a1wzb88Bu5OguaDuJ0Ct54+I2LQtVIXns5VZ
 GVyAWSLi9kN9ST0A1d3GmHjajW/vP2EAFffFCv80IWIIwxPsVi6/yyKnl26QeJZWlKdxV
 n0UHggzr3o/asFPhoIATkK5VJbQoG703qcfDZoB0jBuvPrGt1qRsFyZh8KAcG+W37Dw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b=og7UpCsb; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=NkBoSVzm; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mainlining.org
 header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r
 header.b=og7UpCsb; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=NkBoSVzm
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp1.osuosl.org (Postfix) with UTF8SMTPS id A22B48148E
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 19:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1791574624; bh=2dV5gWyYJkCO6wpZ8RBkYet
 C98qbt9HmUExufznl6c0=; b=og7UpCsbZzmdPmKAOPSLDada5dppGwdTcKzrPWCXoIclPhxdyg
 1hkBFo7edVVjhnErFLGEl0opKnwu4Zaa/Ag8OV/OmdIyOoweRr8NK0CmJogdlxyNL6l5r8T4dT5
 Z9U4fauxVP3MbvksuF4vXET4SpHazRkq1na3VU6M4p4idvr9kWISywxJbHm1HxnooKoO7IfjOTb
 wShU3FIgdlNBVbOT5Kh6Hkxq5HbTWWpQfO5NbyXEktqFEGuvXk9yQ8p69JAMlKWSKlM7tfflmZC
 cWgKfdIF3761GJznhmarIjOW6WR6+Q0R/EZG9W5LXMev4xt/buxqG+15ac3JaYC0Y1Q==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1791574624; bh=2dV5gWyYJkCO6wpZ8RBkYet
 C98qbt9HmUExufznl6c0=; b=NkBoSVzmuQUx4um/pdL2vaVoOKsXeVcn8e4ZFbL9dXkee0uz+X
 LUoQyNAT6SOnebsOKWaA+gFmKJ3vFrpPHKDw==;
From: Bradley Morgan <brads@mainlining.org>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.u-boot-project.org
Cc: Bradley Morgan <brads@mainlining.org>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 =?UTF-8?q?Marek=20Moj=C3=ADk?= <marek.mojik@nic.cz>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Alexey Charkov <alchark@flipper.net>, Anshul Dalal <anshuld@ti.com>,
 Daniel Golle <daniel@makrotopia.org>, Fabio Estevam <festevam@gmail.com>,
 Gaurav Jain <gaurav.jain@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Johan Jonker <jbx6244@gmail.com>, Lukasz Majewski <lukma@nabladev.com>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Mario Six <mario.six@gdsys.cc>,
 Michael Walle <mwalle@kernel.org>, Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Pengpeng Hou <hppiscas@163.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Stefano Babic <sbabic@nabladev.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Torsten Rupp <torsten.rupp@8tronix.de>, Vincent Jardin <vjardin@free.fr>,
 Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH 00/26] powerpc: drop EOL boards and SoCs, take over maintenance
Date: Fri,  9 Oct 2026 19:36:38 +0000
Message-ID: <20261009193704.13061-1-brads@mainlining.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 09 Oct 2026 19:54:04 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

PowerPC in U-Boot has been orphaned since October 2022, and a huge chunk
of what sits in arch/powerpc is ancient NXP hardware that has been out
of production for years. Nobody is running or testing these boards, NXP
marked them obsolete or archived, and having dead silicon files hang around
just gets in the way of treewide cleanups.

So heres a sweep to get rid of them. The first seven patches drop the
obsolete boards (MPC8548CDS, MPC837XERDB, P2020RDB-PC, P3041DS, P4080DS,
P5040DS, T1042D4RDB). Once the boards are gone, patches 8 through 24
peel off the dead SoCs and all the orphaned serdes tables and errata glue
that lost their last callers. Then MPC86xx goes away completely, and
the last patch adds me to MAINTAINERS so arch/powerpc actually has an
active maintainer instead of sitting orphaned.

Net diff drops about 12.8k lines of dead code.


Bradley Morgan (26):
  board: powerpc: Remove MPC8548CDS support
  board: powerpc: Remove MPC837XERDB support
  board: powerpc: Remove P2020RDB-PC support
  board: powerpc: Remove P3041DS support
  board: powerpc: Remove P4080DS support
  board: powerpc: Remove P5040DS support
  board: powerpc: Remove T1042D4RDB support
  powerpc: mpc85xx: Remove P3041 support
  powerpc: mpc85xx: Remove P4080 support
  powerpc: mpc85xx: Remove P5040 support
  powerpc: mpc83xx: Remove MPC837x support
  powerpc: mpc85xx: Remove C29x support
  powerpc: mpc85xx: Remove P1011 support
  powerpc: mpc85xx: Remove P1023 support
  powerpc: mpc85xx: Remove P1025 support
  powerpc: mpc85xx: Remove MPC8536 support
  powerpc: mpc85xx: Remove MPC8540 support
  powerpc: mpc85xx: Remove MPC8560 support
  powerpc: mpc85xx: Remove BSC9132 support
  powerpc: mpc83xx: Remove MPC831x support
  powerpc: mpc83xx: Remove MPC834x support
  powerpc: mpc85xx: Remove P1024 support
  powerpc: mpc85xx: Remove BSC9131 support
  powerpc: mpc83xx: Remove MPC8309 support
  powerpc: Remove MPC86xx support
  MAINTAINERS: powerpc: Add me as PowerPC maintainer

 MAINTAINERS                                   |   3 +-
 README                                        |   2 +-
 api/api_platform-powerpc.c                    |   2 +-
 arch/Kconfig                                  |   7 +-
 arch/Kconfig.nxp                              |   9 +-
 arch/powerpc/cpu/Makefile                     |   1 -
 arch/powerpc/cpu/mpc83xx/Kconfig              |  44 --
 arch/powerpc/cpu/mpc83xx/cpu.c                |  17 +-
 arch/powerpc/cpu/mpc83xx/cpu_init.c           |  24 -
 arch/powerpc/cpu/mpc83xx/fdt.c                |  47 +-
 arch/powerpc/cpu/mpc83xx/hid/Kconfig          |   4 +-
 arch/powerpc/cpu/mpc83xx/hid/hid.h            |   5 -
 arch/powerpc/cpu/mpc83xx/hrcw/Kconfig         |  82 +--
 arch/powerpc/cpu/mpc83xx/initreg/Kconfig.lcrr |   6 +-
 arch/powerpc/cpu/mpc83xx/initreg/Kconfig.spcr |   2 +-
 arch/powerpc/cpu/mpc83xx/pci.c                |   2 -
 arch/powerpc/cpu/mpc83xx/spd_sdram.c          |   4 +-
 arch/powerpc/cpu/mpc83xx/speed.c              | 112 +--
 arch/powerpc/cpu/mpc83xx/traps.c              |   1 -
 arch/powerpc/cpu/mpc85xx/Kconfig              | 443 +-----------
 arch/powerpc/cpu/mpc85xx/Makefile             |  14 -
 arch/powerpc/cpu/mpc85xx/bsc9132_serdes.c     | 101 ---
 arch/powerpc/cpu/mpc85xx/c29x_serdes.c        |  70 --
 arch/powerpc/cpu/mpc85xx/cmd_errata.c         |  43 +-
 arch/powerpc/cpu/mpc85xx/cpu.c                |  17 -
 arch/powerpc/cpu/mpc85xx/cpu_init.c           |  49 +-
 arch/powerpc/cpu/mpc85xx/fdt.c                |  28 +-
 arch/powerpc/cpu/mpc85xx/fsl_corenet_serdes.c | 665 ------------------
 arch/powerpc/cpu/mpc85xx/fsl_corenet_serdes.h |   4 -
 arch/powerpc/cpu/mpc85xx/mpc8536_serdes.c     | 250 -------
 arch/powerpc/cpu/mpc85xx/mpc8548_serdes.c     |  57 --
 arch/powerpc/cpu/mpc85xx/p1023_serdes.c       |  59 --
 arch/powerpc/cpu/mpc85xx/p3041_ids.c          | 112 ---
 arch/powerpc/cpu/mpc85xx/p3041_serdes.c       | 133 ----
 arch/powerpc/cpu/mpc85xx/p4080_ids.c          | 112 ---
 arch/powerpc/cpu/mpc85xx/p4080_serdes.c       |  80 ---
 arch/powerpc/cpu/mpc85xx/p5040_ids.c          | 111 ---
 arch/powerpc/cpu/mpc85xx/p5040_serdes.c       |  99 ---
 arch/powerpc/cpu/mpc85xx/release.S            |  23 +-
 arch/powerpc/cpu/mpc85xx/speed.c              |   6 +-
 arch/powerpc/cpu/mpc8xxx/Makefile             |   1 -
 arch/powerpc/cpu/mpc8xxx/cpu.c                |  20 +-
 arch/powerpc/cpu/mpc8xxx/fdt.c                |   8 +-
 arch/powerpc/cpu/mpc8xxx/srio.c               |   6 -
 arch/powerpc/dts/Makefile                     |   7 -
 arch/powerpc/dts/mpc8379erdb.dts              | 153 ----
 arch/powerpc/dts/mpc8548-post.dtsi            |  36 -
 arch/powerpc/dts/mpc8548.dtsi                 |  27 -
 arch/powerpc/dts/mpc8548cds.dts               |  29 -
 arch/powerpc/dts/mpc8548cds_36b.dts           |  29 -
 arch/powerpc/dts/p2020rdb-pc.dts              |  59 --
 arch/powerpc/dts/p2020rdb-pc.dtsi             |  50 --
 arch/powerpc/dts/p2020rdb-pc_36b.dts          |  59 --
 arch/powerpc/dts/p3041.dtsi                   | 149 ----
 arch/powerpc/dts/p3041ds.dts                  | 158 -----
 arch/powerpc/dts/p3041si-post.dtsi            |  43 --
 arch/powerpc/dts/p4080.dtsi                   | 148 ----
 arch/powerpc/dts/p4080ds.dts                  | 220 ------
 arch/powerpc/dts/p4080si-post.dtsi            |  62 --
 arch/powerpc/dts/p5040.dtsi                   | 137 ----
 arch/powerpc/dts/p5040ds.dts                  | 281 --------
 arch/powerpc/dts/p5040si-post.dtsi            |  70 --
 arch/powerpc/dts/t1042d4rdb-u-boot.dtsi       |  12 -
 arch/powerpc/dts/t1042d4rdb.dts               |  89 ---
 arch/powerpc/dts/t104x.dtsi                   | 148 ----
 arch/powerpc/include/asm/arch-mpc83xx/gpio.h  |   4 +-
 arch/powerpc/include/asm/arch-mpc83xx/soc.h   |  37 +-
 arch/powerpc/include/asm/config.h             |   1 -
 arch/powerpc/include/asm/config_mpc85xx.h     |  56 +-
 arch/powerpc/include/asm/fsl_law.h            |   8 -
 arch/powerpc/include/asm/fsl_lbc.h            |  15 +-
 arch/powerpc/include/asm/fsl_pci.h            |   7 -
 arch/powerpc/include/asm/fsl_secure_boot.h    |   1 -
 arch/powerpc/include/asm/fsl_serdes.h         |   3 -
 arch/powerpc/include/asm/global_data.h        |  19 +-
 arch/powerpc/include/asm/immap_83xx.h         | 123 +---
 arch/powerpc/include/asm/immap_85xx.h         | 253 +------
 arch/powerpc/include/asm/mpc8349_pci.h        | 165 -----
 arch/powerpc/include/asm/mpc8xxx_spi.h        |   5 +-
 arch/powerpc/include/asm/ppc.h                |  14 +-
 arch/powerpc/include/asm/processor.h          |  36 +-
 arch/powerpc/lib/bdinfo.c                     |   2 +-
 arch/powerpc/lib/bootm.c                      |   7 -
 arch/powerpc/lib/ppccache.S                   |   4 +-
 arch/powerpc/lib/stack.c                      |   2 +-
 board/nxp/common/Makefile                     |  11 -
 board/nxp/common/cds_pci_ft.c                 |  17 -
 board/nxp/common/cds_via.c                    |  95 ---
 board/nxp/common/ics307_clk.c                 | 149 ----
 board/nxp/common/ics307_clk.h                 |  14 -
 board/nxp/common/ngpixis.c                    | 247 -------
 board/nxp/common/ngpixis.h                    |  60 --
 board/nxp/common/sdhc_boot.c                  |   2 +-
 board/nxp/mpc837xerdb/Kconfig                 |  15 -
 board/nxp/mpc837xerdb/MAINTAINERS             |   6 -
 board/nxp/mpc837xerdb/Makefile                |   6 -
 board/nxp/mpc837xerdb/README                  |  97 ---
 board/nxp/mpc837xerdb/mpc837xerdb.c           | 242 -------
 board/nxp/mpc8548cds/Kconfig                  |  24 -
 board/nxp/mpc8548cds/MAINTAINERS              |   8 -
 board/nxp/mpc8548cds/Makefile                 |  10 -
 board/nxp/mpc8548cds/ddr.c                    |  51 --
 board/nxp/mpc8548cds/law.c                    |  18 -
 board/nxp/mpc8548cds/mpc8548cds.c             | 170 -----
 board/nxp/mpc8548cds/tlb.c                    |  87 ---
 board/nxp/p1_p2_rdb_pc/Kconfig                |   3 +-
 board/nxp/p1_p2_rdb_pc/MAINTAINERS            |   8 -
 board/nxp/p1_p2_rdb_pc/README                 |   7 +-
 board/nxp/p1_p2_rdb_pc/ddr.c                  |  68 --
 board/nxp/p1_p2_rdb_pc/p1_p2_rdb_pc.c         |   2 -
 board/nxp/t104xrdb/Kconfig                    |  12 -
 board/nxp/t104xrdb/MAINTAINERS                |  13 -
 board/nxp/t104xrdb/Makefile                   |  13 -
 board/nxp/t104xrdb/README                     | 386 ----------
 board/nxp/t104xrdb/cpld.c                     | 116 ---
 board/nxp/t104xrdb/cpld.h                     |  45 --
 board/nxp/t104xrdb/ddr.c                      | 148 ----
 board/nxp/t104xrdb/ddr.h                      |  56 --
 board/nxp/t104xrdb/law.c                      |  31 -
 board/nxp/t104xrdb/spl.c                      | 131 ----
 board/nxp/t104xrdb/t1040_nand_rcw.cfg         |   7 -
 board/nxp/t104xrdb/t1040_sd_rcw.cfg           |   7 -
 board/nxp/t104xrdb/t1040_spi_rcw.cfg          |   7 -
 board/nxp/t104xrdb/t1040d4_nand_rcw.cfg       |   7 -
 board/nxp/t104xrdb/t1040d4_sd_rcw.cfg         |   7 -
 board/nxp/t104xrdb/t1040d4_spi_rcw.cfg        |   7 -
 board/nxp/t104xrdb/t1042_nand_rcw.cfg         |   7 -
 board/nxp/t104xrdb/t1042_pi_nand_rcw.cfg      |   7 -
 board/nxp/t104xrdb/t1042_pi_sd_rcw.cfg        |   7 -
 board/nxp/t104xrdb/t1042_pi_spi_rcw.cfg       |   7 -
 board/nxp/t104xrdb/t1042_sd_rcw.cfg           |   7 -
 board/nxp/t104xrdb/t1042_spi_rcw.cfg          |   7 -
 board/nxp/t104xrdb/t1042d4_nand_rcw.cfg       |   7 -
 board/nxp/t104xrdb/t1042d4_sd_rcw.cfg         |   7 -
 board/nxp/t104xrdb/t1042d4_spi_rcw.cfg        |   7 -
 board/nxp/t104xrdb/t104x_pbi.cfg              |  36 -
 board/nxp/t104xrdb/t104x_pbi_sb.cfg           |  38 -
 board/nxp/t104xrdb/t104xrdb.c                 | 159 -----
 board/nxp/t104xrdb/t104xrdb.h                 |  11 -
 board/nxp/t104xrdb/tlb.c                      | 132 ----
 boot/Kconfig                                  |   4 +-
 common/board_r.c                              |   2 +-
 configs/MPC837XERDB_defconfig                 | 193 -----
 configs/MPC8548CDS_36BIT_defconfig            | 108 ---
 configs/MPC8548CDS_defconfig                  | 106 ---
 configs/MPC8548CDS_legacy_defconfig           | 106 ---
 configs/P2020RDB-PC_36BIT_NAND_defconfig      | 164 -----
 configs/P2020RDB-PC_36BIT_SDCARD_defconfig    | 145 ----
 configs/P2020RDB-PC_36BIT_SPIFLASH_defconfig  | 147 ----
 configs/P2020RDB-PC_36BIT_defconfig           | 125 ----
 configs/P2020RDB-PC_NAND_defconfig            | 162 -----
 configs/P2020RDB-PC_SDCARD_defconfig          | 142 ----
 configs/P2020RDB-PC_SPIFLASH_defconfig        | 145 ----
 configs/P2020RDB-PC_defconfig                 | 123 ----
 configs/T1042D4RDB_NAND_defconfig             | 144 ----
 configs/T1042D4RDB_SDCARD_defconfig           | 138 ----
 configs/T1042D4RDB_SPIFLASH_defconfig         | 141 ----
 configs/T1042D4RDB_defconfig                  | 114 ---
 doc/README.mpc83xxads                         |  97 ---
 doc/README.mpc85xx-sd-spi-boot                |   8 -
 doc/README.mpc85xxcds                         | 225 ------
 doc/README.pblimage                           |   6 +-
 doc/README.sata                               |  68 --
 doc/README.srio-pcie-boot-corenet             | 118 ----
 .../clock/fsl,mpc83xx-clk.txt                 |   7 +-
 doc/device-tree-bindings/cpu/fsl,mpc83xx.txt  |  13 +-
 .../gpio/fsl,mpc83xx-spisel-boot.txt          |   4 +-
 drivers/clk/mpc83xx_clk.c                     |  19 +-
 drivers/clk/mpc83xx_clk.h                     |  30 +-
 drivers/cpu/mpc83xx_cpu.c                     |  62 +-
 drivers/cpu/mpc83xx_cpu.h                     |  44 --
 drivers/crypto/fsl/jr.c                       |  14 +-
 drivers/ddr/fsl/Kconfig                       |   8 +-
 drivers/ddr/fsl/ctrl_regs.c                   |   1 -
 drivers/dma/fsl_dma.c                         |   4 -
 drivers/gpio/mpc83xx_spisel_boot.c            |   1 -
 drivers/gpio/mpc8xxx_gpio.c                   |   1 -
 drivers/mmc/Kconfig                           |   3 +-
 drivers/net/Kconfig                           |   4 -
 drivers/net/fm/Makefile                       |   6 +-
 drivers/net/fm/fm.h                           |   4 -
 drivers/net/fm/p1023.c                        |  72 --
 drivers/net/fm/p4080.c                        |  98 ---
 drivers/net/fm/p5040.c                        | 106 ---
 drivers/pci/Kconfig                           |   2 +-
 drivers/pci/pci_auto.c                        |  14 -
 drivers/pci/pcie_fsl.c                        |  23 -
 drivers/qe/Kconfig                            |   3 +-
 drivers/qe/qe.c                               |   1 -
 drivers/ram/mpc83xx_sdram.c                   |  14 +-
 drivers/usb/common/fsl-errata.c               |  15 -
 drivers/usb/host/Kconfig                      |   2 +-
 env/Kconfig                                   |   3 +-
 include/asm-generic/u-boot.h                  |   2 +-
 include/configs/MPC837XERDB.h                 | 218 ------
 include/configs/MPC8548CDS.h                  | 312 --------
 include/configs/T104xRDB.h                    | 397 -----------
 include/configs/p1_p2_rdb_pc.h                |  21 -
 include/dt-bindings/clk/mpc83xx-clk.h         |   1 -
 include/fsl_immap.h                           |   2 +-
 include/fsl_sec.h                             |   3 -
 include/mpc83xx.h                             | 319 +--------
 include/pci_ids.h                             |   4 -
 include/serial.h                              |   1 -
 204 files changed, 178 insertions(+), 12873 deletions(-)
 delete mode 100644 arch/powerpc/cpu/mpc85xx/bsc9132_serdes.c
 delete mode 100644 arch/powerpc/cpu/mpc85xx/c29x_serdes.c
 delete mode 100644 arch/powerpc/cpu/mpc85xx/mpc8536_serdes.c
 delete mode 100644 arch/powerpc/cpu/mpc85xx/mpc8548_serdes.c
 delete mode 100644 arch/powerpc/cpu/mpc85xx/p1023_serdes.c
 delete mode 100644 arch/powerpc/cpu/mpc85xx/p3041_ids.c
 delete mode 100644 arch/powerpc/cpu/mpc85xx/p3041_serdes.c
 delete mode 100644 arch/powerpc/cpu/mpc85xx/p4080_ids.c
 delete mode 100644 arch/powerpc/cpu/mpc85xx/p4080_serdes.c
 delete mode 100644 arch/powerpc/cpu/mpc85xx/p5040_ids.c
 delete mode 100644 arch/powerpc/cpu/mpc85xx/p5040_serdes.c
 delete mode 100644 arch/powerpc/dts/mpc8379erdb.dts
 delete mode 100644 arch/powerpc/dts/mpc8548-post.dtsi
 delete mode 100644 arch/powerpc/dts/mpc8548.dtsi
 delete mode 100644 arch/powerpc/dts/mpc8548cds.dts
 delete mode 100644 arch/powerpc/dts/mpc8548cds_36b.dts
 delete mode 100644 arch/powerpc/dts/p2020rdb-pc.dts
 delete mode 100644 arch/powerpc/dts/p2020rdb-pc.dtsi
 delete mode 100644 arch/powerpc/dts/p2020rdb-pc_36b.dts
 delete mode 100644 arch/powerpc/dts/p3041.dtsi
 delete mode 100644 arch/powerpc/dts/p3041ds.dts
 delete mode 100644 arch/powerpc/dts/p3041si-post.dtsi
 delete mode 100644 arch/powerpc/dts/p4080.dtsi
 delete mode 100644 arch/powerpc/dts/p4080ds.dts
 delete mode 100644 arch/powerpc/dts/p4080si-post.dtsi
 delete mode 100644 arch/powerpc/dts/p5040.dtsi
 delete mode 100644 arch/powerpc/dts/p5040ds.dts
 delete mode 100644 arch/powerpc/dts/p5040si-post.dtsi
 delete mode 100644 arch/powerpc/dts/t1042d4rdb-u-boot.dtsi
 delete mode 100644 arch/powerpc/dts/t1042d4rdb.dts
 delete mode 100644 arch/powerpc/dts/t104x.dtsi
 delete mode 100644 arch/powerpc/include/asm/mpc8349_pci.h
 delete mode 100644 board/nxp/common/cds_pci_ft.c
 delete mode 100644 board/nxp/common/cds_via.c
 delete mode 100644 board/nxp/common/ics307_clk.c
 delete mode 100644 board/nxp/common/ics307_clk.h
 delete mode 100644 board/nxp/common/ngpixis.c
 delete mode 100644 board/nxp/common/ngpixis.h
 delete mode 100644 board/nxp/mpc837xerdb/Kconfig
 delete mode 100644 board/nxp/mpc837xerdb/MAINTAINERS
 delete mode 100644 board/nxp/mpc837xerdb/Makefile
 delete mode 100644 board/nxp/mpc837xerdb/README
 delete mode 100644 board/nxp/mpc837xerdb/mpc837xerdb.c
 delete mode 100644 board/nxp/mpc8548cds/Kconfig
 delete mode 100644 board/nxp/mpc8548cds/MAINTAINERS
 delete mode 100644 board/nxp/mpc8548cds/Makefile
 delete mode 100644 board/nxp/mpc8548cds/ddr.c
 delete mode 100644 board/nxp/mpc8548cds/law.c
 delete mode 100644 board/nxp/mpc8548cds/mpc8548cds.c
 delete mode 100644 board/nxp/mpc8548cds/tlb.c
 delete mode 100644 board/nxp/t104xrdb/Kconfig
 delete mode 100644 board/nxp/t104xrdb/MAINTAINERS
 delete mode 100644 board/nxp/t104xrdb/Makefile
 delete mode 100644 board/nxp/t104xrdb/README
 delete mode 100644 board/nxp/t104xrdb/cpld.c
 delete mode 100644 board/nxp/t104xrdb/cpld.h
 delete mode 100644 board/nxp/t104xrdb/ddr.c
 delete mode 100644 board/nxp/t104xrdb/ddr.h
 delete mode 100644 board/nxp/t104xrdb/law.c
 delete mode 100644 board/nxp/t104xrdb/spl.c
 delete mode 100644 board/nxp/t104xrdb/t1040_nand_rcw.cfg
 delete mode 100644 board/nxp/t104xrdb/t1040_sd_rcw.cfg
 delete mode 100644 board/nxp/t104xrdb/t1040_spi_rcw.cfg
 delete mode 100644 board/nxp/t104xrdb/t1040d4_nand_rcw.cfg
 delete mode 100644 board/nxp/t104xrdb/t1040d4_sd_rcw.cfg
 delete mode 100644 board/nxp/t104xrdb/t1040d4_spi_rcw.cfg
 delete mode 100644 board/nxp/t104xrdb/t1042_nand_rcw.cfg
 delete mode 100644 board/nxp/t104xrdb/t1042_pi_nand_rcw.cfg
 delete mode 100644 board/nxp/t104xrdb/t1042_pi_sd_rcw.cfg
 delete mode 100644 board/nxp/t104xrdb/t1042_pi_spi_rcw.cfg
 delete mode 100644 board/nxp/t104xrdb/t1042_sd_rcw.cfg
 delete mode 100644 board/nxp/t104xrdb/t1042_spi_rcw.cfg
 delete mode 100644 board/nxp/t104xrdb/t1042d4_nand_rcw.cfg
 delete mode 100644 board/nxp/t104xrdb/t1042d4_sd_rcw.cfg
 delete mode 100644 board/nxp/t104xrdb/t1042d4_spi_rcw.cfg
 delete mode 100644 board/nxp/t104xrdb/t104x_pbi.cfg
 delete mode 100644 board/nxp/t104xrdb/t104x_pbi_sb.cfg
 delete mode 100644 board/nxp/t104xrdb/t104xrdb.c
 delete mode 100644 board/nxp/t104xrdb/t104xrdb.h
 delete mode 100644 board/nxp/t104xrdb/tlb.c
 delete mode 100644 configs/MPC837XERDB_defconfig
 delete mode 100644 configs/MPC8548CDS_36BIT_defconfig
 delete mode 100644 configs/MPC8548CDS_defconfig
 delete mode 100644 configs/MPC8548CDS_legacy_defconfig
 delete mode 100644 configs/P2020RDB-PC_36BIT_NAND_defconfig
 delete mode 100644 configs/P2020RDB-PC_36BIT_SDCARD_defconfig
 delete mode 100644 configs/P2020RDB-PC_36BIT_SPIFLASH_defconfig
 delete mode 100644 configs/P2020RDB-PC_36BIT_defconfig
 delete mode 100644 configs/P2020RDB-PC_NAND_defconfig
 delete mode 100644 configs/P2020RDB-PC_SDCARD_defconfig
 delete mode 100644 configs/P2020RDB-PC_SPIFLASH_defconfig
 delete mode 100644 configs/P2020RDB-PC_defconfig
 delete mode 100644 configs/T1042D4RDB_NAND_defconfig
 delete mode 100644 configs/T1042D4RDB_SDCARD_defconfig
 delete mode 100644 configs/T1042D4RDB_SPIFLASH_defconfig
 delete mode 100644 configs/T1042D4RDB_defconfig
 delete mode 100644 doc/README.mpc83xxads
 delete mode 100644 doc/README.mpc85xxcds
 delete mode 100644 doc/README.sata
 delete mode 100644 doc/README.srio-pcie-boot-corenet
 delete mode 100644 drivers/net/fm/p1023.c
 delete mode 100644 drivers/net/fm/p4080.c
 delete mode 100644 drivers/net/fm/p5040.c
 delete mode 100644 include/configs/MPC837XERDB.h
 delete mode 100644 include/configs/MPC8548CDS.h
 delete mode 100644 include/configs/T104xRDB.h

-- 
2.47.3

