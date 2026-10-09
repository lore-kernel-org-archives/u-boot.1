Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D8D1CA601F
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 19:55:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 66AA681549;
	Fri,  9 Oct 2026 19:55:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0QAWAvMPAtdQ; Fri,  9 Oct 2026 19:54:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F09E581539
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791575691;
	b=d6xncSFuE0GZT1EUHPxwDa47kI7zQi1HelDv4lplG2E5KsItV/vguLJqxi5yqYgYthnA
	 +MD65XDcrVGTi+Rrpnb4esiQUps1PisptcNtCkykw/srR/O7gLtSBud8gRNL644NW2NDb
	 gq4JzpNoTqcGNb1YJx6AJ3MgtZWzkAJJZQA1gvO0MYyABxt/u9rm6EwSnjmijiiMMgoLU
	 sK9stNqYfJbjtScYWiqYtlRyT+rScnXn9EGy+dG3hcqjaXtNG1IOHSvsvKiLuP7Lc3q6x
	 4LIVhjsxnT2ISGKAc/kdyO5S4BzciJNH3MZsJFIbn+Z1+RD2cr/47KiT5cdGQPCEj7g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791575691;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=h3/IgD1rI0VBx6NoIz8GtZypwmKWHoP4Mf2QCOkbbsI=;
	b=d5FdE/TFIhs8n8xB6DYdRzn4NFg7zQ1jtKIVDzVdrw0Qk3lE/c1ebZ3D+hQjk4t7z5TY
	 3NyH42XdR4Ia0p6zo+pNXX4+Mq1wOutq/afCsX6USfDg8NgSsXPqpSA2ysAHkvhUMsp6H
	 IzwYDzbKgWTllhq1R6r8lALSP1tbClWojkb5uqBz7chV027IE1ib3gGWoVNcYmVln//lf
	 uki927KQvsmMl3VwpKv1K1xDgt32ApXyZ/SiPLaSgeVr05jZPuU6618MFJEBWiwhlje1z
	 hTGfBlXXblEhZHxQ44RC898rgfnIZSJfx8nyg3D22FuJ3gwqnEMpivPi84RP8ziAvLQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791575691;
	bh=h3/IgD1rI0VBx6NoIz8GtZypwmKWHoP4Mf2QCOkbbsI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=o0PUxI45/YZcpFFidWEg2UWPGRPlJm4BB+c0z8JhdDMhgdBJ66jAGaI7Fhc8FsYVr
	 s7TFaKqoF/Su6XkBA+uzYZ22Sx7eKFjJEPe/Ib60IoEh1zAExvUOOqHYkgsK97hIUy
	 Paw8swRRcwfP0CiNGDd16Z22YXeWBvKWMQRTgY/hit/fn/QEVv8N76g8iiXWajWFZy
	 sRLfEYuEv0AONXi1UNf3V0ITq4NkFxAX1KxGLc21CupRDi0GufVaDqETYvY4rVPwHd
	 skiYrLxIt375lrrN/5oVEXV3bCoLzSqEp9+JScCu9HKcTPuF7jap/fkH7/WLRxG8+L
	 UZWdg7VGtUxNA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F09E581539;
	Fri,  9 Oct 2026 19:54:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with UTF8SMTP id 80E7F356
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 19:40:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with UTF8SMTP id 7E6DB40053
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 19:40:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024)
 with UTF8SMTP id cdvRKqAcIy4A for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 19:40:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 2D16140080
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791574818;
 b=EgxFWVCfUDMdTm1pBRbYfRQYIZboMF2ACAIPwXb44Dwb5GpGK/iKbBsdhrCArUza7UAa
 IkKDM7qHgHLs21cpL4gy05+e8J7HGEpMbv405UpHKERwkyVUsc/BvYjBn5tJT63i9MlQ1
 JsZ7bYr54EzWivrmKNNM7coUMmDUwcQxQFRnLtYsdHlQIUfZ2JpsUtRwg36Zb8Atrxa1a
 +1hX2NOEg9QxH6yoOLy3ttLRL8znqEeFqbYr6BS5GE3tY0dEGF2QIOzueyjY1oUyfQDic
 Ap4+BsAjCuFRsa4VyUoFxLkfbJLUb/aXNdrkFKWYYrH/rn1y2CFfm0OepIHUPW2lxrQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791574818;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=h3/IgD1rI0VBx6NoIz8GtZypwmKWHoP4Mf2QCOkbbsI=;
 b=QOeJC+IkqIwxBGSnrXWde7fxShwb+aUB9ObOiwojoQuE8C3nfHai04r08RZUc3aGumHW
 g6u7WsI6q0u5NMQoWwYjiWnxROW8m5xlC6skOk2Lww7UjZyNj21qCakp+mFuzqBjWjf1z
 LuVzkU61UmYWf6tEJjUn2gZ+GOVF0nTZmdCZurA9KRZO1Fa1qbx2OuvGK2WgzL0VtQaGG
 JhTGmsvIXgfYum4+j1YZ6lM9t9uUxhva3MG0i3tchRkVYdj59s+nctruHzxOBmBzl6+NE
 LaBUypWSJ8X1Sf1XuwSr3OfdnSo+gLsGyw1mpvYeB+WQ0oLx8KTt+exX2MqZt83XeRQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b=bvEcuY77; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=4FZgZ87g; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org
 header.a=rsa-sha256 header.s=202507r header.b=bvEcuY77; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=4FZgZ87g
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp2.osuosl.org (Postfix) with UTF8SMTPS id 2D16140080
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 19:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1791574627; bh=h3/IgD1rI0VBx6NoIz8GtZy
 pwmKWHoP4Mf2QCOkbbsI=; b=bvEcuY77S3sBVwbBX9OIiTl+hcsa6vbeTugaX9wwn4+gzlvj0j
 69MxahUASDcRSSoFNLCpsTE9KnlGTX5IFEFYhXJEj5dF3T/RsCPy3yhB5SO74T319gZSxB2lMW7
 /vkOBhDniM8PIKSWpCd1huuSecaoGYvClE9Uv9lmoffDxDLxHQg939NHHid1Qjt2rPe1OOQyCzs
 KpDWBBu05PtInw6GYPTimsQLCtPnbyfyk7lFLcGpfkqZwK1XvHEq2lS3tmAlTeJ7tZ3g7njOFJc
 PuYcepN7NLWy0XUIrVFYb2qT8ueBkHMZPYT8+qDHJxE3lGbfza/myEjHb5Tc3AmH7Lg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1791574627; bh=h3/IgD1rI0VBx6NoIz8GtZy
 pwmKWHoP4Mf2QCOkbbsI=; b=4FZgZ87gp0knqZVf4Kc0TkwuLq0ENoDX6WXvgaLjXT1PoNCw/a
 B5lhLrOZUUOfDVnufmKyDsD8eBZN5HQGkpDA==;
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
Subject: [PATCH 07/26] board: powerpc: Remove T1042D4RDB support
Date: Fri,  9 Oct 2026 19:36:45 +0000
Message-ID: <20261009193704.13061-8-brads@mainlining.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261009193704.13061-1-brads@mainlining.org>
References: <20261009193704.13061-1-brads@mainlining.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The T1042D4RDB-PA is obsolete and no longer manufactured. Remove the target and its board support.

Signed-off-by: Bradley Morgan <brads@mainlining.org>
---
 arch/powerpc/cpu/mpc85xx/Kconfig           |  10 -
 arch/powerpc/dts/Makefile                  |   1 -
 arch/powerpc/dts/t1042d4rdb-u-boot.dtsi    |  12 -
 arch/powerpc/dts/t1042d4rdb.dts            |  89 -----
 arch/powerpc/dts/t104x.dtsi                | 148 --------
 arch/powerpc/include/asm/fsl_secure_boot.h |   1 -
 board/nxp/t104xrdb/Kconfig                 |  12 -
 board/nxp/t104xrdb/MAINTAINERS             |  13 -
 board/nxp/t104xrdb/Makefile                |  13 -
 board/nxp/t104xrdb/README                  | 386 --------------------
 board/nxp/t104xrdb/cpld.c                  | 116 ------
 board/nxp/t104xrdb/cpld.h                  |  45 ---
 board/nxp/t104xrdb/ddr.c                   | 148 --------
 board/nxp/t104xrdb/ddr.h                   |  56 ---
 board/nxp/t104xrdb/law.c                   |  31 --
 board/nxp/t104xrdb/spl.c                   | 131 -------
 board/nxp/t104xrdb/t1040_nand_rcw.cfg      |   7 -
 board/nxp/t104xrdb/t1040_sd_rcw.cfg        |   7 -
 board/nxp/t104xrdb/t1040_spi_rcw.cfg       |   7 -
 board/nxp/t104xrdb/t1040d4_nand_rcw.cfg    |   7 -
 board/nxp/t104xrdb/t1040d4_sd_rcw.cfg      |   7 -
 board/nxp/t104xrdb/t1040d4_spi_rcw.cfg     |   7 -
 board/nxp/t104xrdb/t1042_nand_rcw.cfg      |   7 -
 board/nxp/t104xrdb/t1042_pi_nand_rcw.cfg   |   7 -
 board/nxp/t104xrdb/t1042_pi_sd_rcw.cfg     |   7 -
 board/nxp/t104xrdb/t1042_pi_spi_rcw.cfg    |   7 -
 board/nxp/t104xrdb/t1042_sd_rcw.cfg        |   7 -
 board/nxp/t104xrdb/t1042_spi_rcw.cfg       |   7 -
 board/nxp/t104xrdb/t1042d4_nand_rcw.cfg    |   7 -
 board/nxp/t104xrdb/t1042d4_sd_rcw.cfg      |   7 -
 board/nxp/t104xrdb/t1042d4_spi_rcw.cfg     |   7 -
 board/nxp/t104xrdb/t104x_pbi.cfg           |  36 --
 board/nxp/t104xrdb/t104x_pbi_sb.cfg        |  38 --
 board/nxp/t104xrdb/t104xrdb.c              | 159 ---------
 board/nxp/t104xrdb/t104xrdb.h              |  11 -
 board/nxp/t104xrdb/tlb.c                   | 132 -------
 configs/T1042D4RDB_NAND_defconfig          | 144 --------
 configs/T1042D4RDB_SDCARD_defconfig        | 138 -------
 configs/T1042D4RDB_SPIFLASH_defconfig      | 141 --------
 configs/T1042D4RDB_defconfig               | 114 ------
 include/configs/T104xRDB.h                 | 397 ---------------------
 41 files changed, 2627 deletions(-)
 delete mode 100644 arch/powerpc/dts/t1042d4rdb-u-boot.dtsi
 delete mode 100644 arch/powerpc/dts/t1042d4rdb.dts
 delete mode 100644 arch/powerpc/dts/t104x.dtsi
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
 delete mode 100644 configs/T1042D4RDB_NAND_defconfig
 delete mode 100644 configs/T1042D4RDB_SDCARD_defconfig
 delete mode 100644 configs/T1042D4RDB_SPIFLASH_defconfig
 delete mode 100644 configs/T1042D4RDB_defconfig
 delete mode 100644 include/configs/T104xRDB.h

diff --git a/arch/powerpc/cpu/mpc85xx/Kconfig b/arch/powerpc/cpu/mpc85xx/Kconfig
index 8a37191bea0..7fee93862c7 100644
--- a/arch/powerpc/cpu/mpc85xx/Kconfig
+++ b/arch/powerpc/cpu/mpc85xx/Kconfig
@@ -167,15 +167,6 @@ config TARGET_T1024RDB
 	imply CMD_EEPROM
 	imply PANIC_HANG
 
-config TARGET_T1042D4RDB
-	bool "Support T1042D4RDB"
-	select ARCH_T1042
-	select BOARD_LATE_INIT if CHAIN_OF_TRUST
-	select SUPPORT_SPL
-	select PHYS_64BIT
-	select SYS_L3_SIZE_256KB
-	imply PANIC_HANG
-
 config TARGET_T2080QDS
 	bool "Support T2080QDS"
 	select ARCH_T2080
@@ -1473,7 +1464,6 @@ source "board/nxp/p1010rdb/Kconfig"
 source "board/nxp/p1_p2_rdb_pc/Kconfig"
 source "board/nxp/p2041rdb/Kconfig"
 source "board/nxp/t102xrdb/Kconfig"
-source "board/nxp/t104xrdb/Kconfig"
 source "board/nxp/t208xqds/Kconfig"
 source "board/nxp/t208xrdb/Kconfig"
 source "board/nxp/t4rdb/Kconfig"
diff --git a/arch/powerpc/dts/Makefile b/arch/powerpc/dts/Makefile
index 3f5473b80af..4bc6e9085f4 100644
--- a/arch/powerpc/dts/Makefile
+++ b/arch/powerpc/dts/Makefile
@@ -13,7 +13,6 @@ dtb-$(CONFIG_TARGET_P1020RDB_PC) += p1020rdb-pc.dtb p1020rdb-pc_36b.dtb
 dtb-$(CONFIG_TARGET_P1020RDB_PD) += p1020rdb-pd.dtb
 dtb-$(CONFIG_TARGET_SOCRATES) += socrates.dtb
 dtb-$(CONFIG_TARGET_T1024RDB) += t1024rdb.dtb
-dtb-$(CONFIG_TARGET_T1042D4RDB) += t1042d4rdb.dtb
 dtb-$(CONFIG_TARGET_T2080QDS) += t2080qds.dtb
 dtb-$(CONFIG_TARGET_T2080RDB) += t2080rdb.dtb
 dtb-$(CONFIG_TARGET_T4240RDB) += t4240rdb.dtb
diff --git a/arch/powerpc/dts/t1042d4rdb-u-boot.dtsi b/arch/powerpc/dts/t1042d4rdb-u-boot.dtsi
deleted file mode 100644
index b50b922aeb2..00000000000
--- a/arch/powerpc/dts/t1042d4rdb-u-boot.dtsi
+++ /dev/null
@@ -1,12 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/* Copyright 2023 NXP */
-
-&serial0 {
-	bootph-all;
-};
-
-&serial1 {
-	bootph-all;
-};
-
-#include "u-boot.dtsi"
diff --git a/arch/powerpc/dts/t1042d4rdb.dts b/arch/powerpc/dts/t1042d4rdb.dts
deleted file mode 100644
index 0230d3ba675..00000000000
--- a/arch/powerpc/dts/t1042d4rdb.dts
+++ /dev/null
@@ -1,89 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+ OR X11
-/*
- * T1042D4RDB Device Tree Source
- *
- * Copyright 2013 - 2015 Freescale Semiconductor Inc.
- * Copyright 2019-2023 NXP
- */
-
-/include/ "t104x.dtsi"
-
-/ {
-	model = "fsl,T1042D4RDB";
-	compatible = "fsl,T1042D4RDB";
-	#address-cells = <2>;
-	#size-cells = <2>;
-	interrupt-parent = <&mpic>;
-
-	aliases {
-		spi0 = &espi0;
-		serial0 = &serial0;
-		serial1 = &serial1;
-		serial2 = &serial2;
-		serial3 = &serial3;
-	};
-};
-
-&soc {
-	fman0: fman@400000 {
-		ethernet@e0000 {
-			phy-handle = <&phy_sgmii_0>;
-			phy-connection-type = "sgmii";
-		};
-
-		ethernet@e2000 {
-			phy-handle = <&phy_sgmii_1>;
-			phy-connection-type = "sgmii";
-		};
-
-		ethernet@e4000 {
-			phy-handle = <&phy_sgmii_2>;
-			phy-connection-type = "sgmii";
-		};
-
-		ethernet@e6000 {
-			phy-handle = <&phy_rgmii_0>;
-			phy-connection-type = "rgmii";
-		};
-
-		ethernet@e8000 {
-			phy-handle = <&phy_rgmii_1>;
-			phy-connection-type = "rgmii";
-		};
-
-		mdio0: mdio@fc000 {
-			phy_sgmii_0: ethernet-phy@2 {
-				reg = <0x02>;
-			};
-
-			phy_sgmii_1: ethernet-phy@3 {
-				reg = <0x03>;
-			};
-
-			phy_sgmii_2: ethernet-phy@1 {
-				reg = <0x01>;
-			};
-
-			phy_rgmii_0: ethernet-phy@4 {
-				reg = <0x04>;
-			};
-
-			phy_rgmii_1: ethernet-phy@5 {
-				reg = <0x05>;
-			};
-		};
-	};
-};
-
-&espi0 {
-	status = "okay";
-	flash@0 {
-		compatible = "jedec,spi-nor";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		reg = <0>;
-		spi-max-frequency = <10000000>; /* input clock */
-	};
-};
-
-/include/ "t1042si-post.dtsi"
diff --git a/arch/powerpc/dts/t104x.dtsi b/arch/powerpc/dts/t104x.dtsi
deleted file mode 100644
index 2c7e5b47185..00000000000
--- a/arch/powerpc/dts/t104x.dtsi
+++ /dev/null
@@ -1,148 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+ OR X11
-/*
- * T104X Silicon/SoC Device Tree Source (pre include)
- *
- * Copyright 2013 Freescale Semiconductor Inc.
- * Copyright 2019-2020 NXP
- */
-
-/dts-v1/;
-
-/include/ "e5500_power_isa.dtsi"
-
-/ {
-	#address-cells = <2>;
-	#size-cells = <2>;
-	interrupt-parent = <&mpic>;
-
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		cpu0: PowerPC,e5500@0 {
-			device_type = "cpu";
-			reg = <0>;
-			#cooling-cells = <2>;
-		};
-		cpu1: PowerPC,e5500@1 {
-			device_type = "cpu";
-			reg = <1>;
-			#cooling-cells = <2>;
-		};
-		cpu2: PowerPC,e5500@2 {
-			device_type = "cpu";
-			reg = <2>;
-			#cooling-cells = <2>;
-		};
-		cpu3: PowerPC,e5500@3 {
-			device_type = "cpu";
-			reg = <3>;
-			#cooling-cells = <2>;
-		};
-	};
-
-	soc: soc@ffe000000 {
-		ranges = <0x00000000 0xf 0xfe000000 0x1000000>;
-		reg = <0xf 0xfe000000 0 0x00001000>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-		device_type = "soc";
-		compatible = "simple-bus";
-
-		mpic: pic@40000 {
-			interrupt-controller;
-			#address-cells = <0>;
-			#interrupt-cells = <4>;
-			reg = <0x40000 0x40000>;
-			compatible = "fsl,mpic", "chrp,open-pic";
-			device_type = "open-pic";
-			clock-frequency = <0x0>;
-		};
-
-		espi0: spi@110000 {
-			compatible = "fsl,mpc8536-espi";
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <0x110000 0x1000>;
-			fsl,espi-num-chipselects = <4>;
-			status = "disabled";
-		};
-
-		usb0@210000 {
-			compatible = "fsl-usb2-mph";
-			reg = <0x210000 0x1000>;
-			phy_type = "utmi";
-		};
-
-		usb1@211000 {
-			compatible = "fsl-usb2-dr";
-			reg = <0x211000 0x1000>;
-			phy_type = "utmi";
-		};
-
-		sata: sata@220000 {
-			compatible = "fsl,pq-sata-v2";
-			reg = <0x220000 0x1000>;
-			interrupts = <68 0x2 0 0>;
-			sata-offset = <0x1000>;
-			sata-number = <2>;
-			sata-fpdma = <0>;
-		};
-
-		esdhc: esdhc@114000 {
-			compatible = "fsl,esdhc";
-			reg = <0x114000 0x1000>;
-			clock-frequency = <0>;
-		};
-		/include/ "qoriq-i2c-0.dtsi"
-		/include/ "qoriq-i2c-1.dtsi"
-	};
-
-	pcie@ffe240000 {
-		compatible = "fsl,pcie-t104x", "fsl,pcie-fsl-qoriq";
-		reg = <0xf 0xfe240000 0x0 0x1000>;   /* registers */
-		law_trgt_if = <0>;
-		#address-cells = <3>;
-		#size-cells = <2>;
-		device_type = "pci";
-		bus-range = <0x0 0xff>;
-		ranges = <0x01000000 0x0 0x00000000 0xf 0xf8000000 0x0 0x00010000   /* downstream I/O */
-			  0x02000000 0x0 0xe0000000 0xc 0x00000000 0x0 0x10000000>; /* non-prefetchable memory */
-	};
-
-	pcie@ffe250000 {
-		compatible = "fsl,pcie-t104x", "fsl,pcie-fsl-qoriq";
-		reg = <0xf 0xfe250000 0x0 0x1000>;   /* registers */
-		law_trgt_if = <1>;
-		#address-cells = <3>;
-		#size-cells = <2>;
-		device_type = "pci";
-		bus-range = <0x0 0xff>;
-		ranges = <0x01000000 0x0 0x00000000 0xf 0xf8010000 0x0 0x00010000   /* downstream I/O */
-			  0x02000000 0x0 0xe0000000 0xc 0x10000000 0x0 0x10000000>; /* non-prefetchable memory */
-	};
-
-	pcie@ffe260000 {
-		compatible = "fsl,pcie-t104x", "fsl,pcie-fsl-qoriq";
-		reg = <0xf 0xfe260000 0x0 0x1000>;   /* registers */
-		law_trgt_if = <2>;
-		#address-cells = <3>;
-		#size-cells = <2>;
-		device_type = "pci";
-		bus-range = <0x0 0xff>;
-		ranges = <0x01000000 0x0 0x00000000 0xf 0xf8020000 0x0 0x00010000   /* downstream I/O */
-			  0x02000000 0x0 0xe0000000 0xc 0x20000000 0x0 0x10000000>; /* non-prefetchable memory */
-	};
-
-	pcie@ffe270000 {
-		compatible = "fsl,pcie-t104x", "fsl,pcie-fsl-qoriq";
-		reg = <0xf 0xfe270000 0x0 0x1000>;   /* registers */
-		law_trgt_if = <3>;
-		#address-cells = <3>;
-		#size-cells = <2>;
-		device_type = "pci";
-		bus-range = <0x0 0xff>;
-		ranges = <0x01000000 0x0 0x00000000 0xf 0xf8030000 0x0 0x00010000   /* downstream I/O */
-			  0x02000000 0x0 0xe0000000 0xc 0x30000000 0x0 0x10000000>; /* non-prefetchable memory */
-	};
-};
diff --git a/arch/powerpc/include/asm/fsl_secure_boot.h b/arch/powerpc/include/asm/fsl_secure_boot.h
index f12830984c6..10f8b0fcd09 100644
--- a/arch/powerpc/include/asm/fsl_secure_boot.h
+++ b/arch/powerpc/include/asm/fsl_secure_boot.h
@@ -17,7 +17,6 @@
 
 #if defined(CONFIG_TARGET_T2080QDS) || \
 	defined(CONFIG_TARGET_T2080RDB) || \
-	defined(CONFIG_TARGET_T1042D4RDB) || \
 	defined(CONFIG_ARCH_T1024)
 #undef CFG_SYS_INIT_L3_ADDR
 #define CFG_SYS_INIT_L3_ADDR			0xbff00000
diff --git a/board/nxp/t104xrdb/Kconfig b/board/nxp/t104xrdb/Kconfig
deleted file mode 100644
index fb26b7c9256..00000000000
--- a/board/nxp/t104xrdb/Kconfig
+++ /dev/null
@@ -1,12 +0,0 @@
-if TARGET_T1042D4RDB
-
-config SYS_BOARD
-	default "t104xrdb"
-
-config SYS_VENDOR
-	default "nxp"
-
-config SYS_CONFIG_NAME
-	default "T104xRDB"
-
-endif
diff --git a/board/nxp/t104xrdb/MAINTAINERS b/board/nxp/t104xrdb/MAINTAINERS
deleted file mode 100644
index d0b5709df81..00000000000
--- a/board/nxp/t104xrdb/MAINTAINERS
+++ /dev/null
@@ -1,13 +0,0 @@
-T104XRDB BOARD
-M:	Priyanka Jain <priyanka.jain@nxp.com>
-S:	Maintained
-F:	board/nxp/t104xrdb/
-F:	include/configs/T104xRDB.h
-F:	configs/T1042D4RDB_defconfig
-F:	configs/T1042D4RDB_NAND_defconfig
-F:	configs/T1042D4RDB_SPIFLASH_defconfig
-
-T1040RDB_SDCARD BOARD
-M:	Priyanka Jain <priyanka.jain@nxp.com>
-S:	Maintained
-F:	configs/T1042D4RDB_SDCARD_defconfig
diff --git a/board/nxp/t104xrdb/Makefile b/board/nxp/t104xrdb/Makefile
deleted file mode 100644
index cee574aabb9..00000000000
--- a/board/nxp/t104xrdb/Makefile
+++ /dev/null
@@ -1,13 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0+
-#
-# Copyright 2013 Freescale Semiconductor, Inc.
-
-ifdef CONFIG_XPL_BUILD
-obj-y += spl.o
-else
-obj-y	+= t104xrdb.o
-obj-y	+= cpld.o
-endif
-obj-y	+= ddr.o
-obj-y	+= law.o
-obj-y	+= tlb.o
diff --git a/board/nxp/t104xrdb/README b/board/nxp/t104xrdb/README
deleted file mode 100644
index b852f72998d..00000000000
--- a/board/nxp/t104xrdb/README
+++ /dev/null
@@ -1,386 +0,0 @@
-Overview
---------
-The T1040RDB is a Freescale reference board that hosts the T1040 SoC
-(and variants). Variants inclued T1042 presonality of T1040, in which
-case T1040RDB can also be called T1042RDB.
-
-The T1042RDB is a Freescale reference board that hosts the T1042 SoC
-(and variants). The board is similar to T1040RDB, T1040 is a reduced
-personality of T1040 SoC without Integrated 8-port Gigabit(L2 Switch).
-
-The T1042RDB_PI is a Freescale reference board that hosts the T1042 SoC.
-(a personality of T1040 SoC). The board is similar to T1040RDB but is
-designed specially with low power features targeted for Printing Image Market.
-
-The T1040D4RDB is a Freescale reference board that hosts the T1040 SoC.
-The board is re-designed T1040RDB board with following changes :
-    - Support of DDR4 memory and some enhancements
-
-The T1042D4RDB is a Freescale reference board that hosts the T1042 SoC.
-The board is re-designed T1040RDB board with following changes :
-    - Support of DDR4 memory
-    - Support for 0x86 serdes protocol which can support following interfaces
-        - 2 RGMII's on DTSEC4, DTSEC5
-        - 3 SGMII on DTSEC1, DTSEC2 & DTSEC3
-
-Basic difference's among T1040RDB, T1042RDB_PI, T1042RDB
--------------------------------------------------------------------------
-Board		Si		Protocol		Targeted Market
--------------------------------------------------------------------------
-T1040RDB	T1040		0x66                    Networking
-T1040RDB	T1042		0x86                    Networking
-T1042RDB_PI	T1042		0x06                    Printing & Imaging
-T1040D4RDB	T1040		0x66                    Networking
-T1042D4RDB	T1042		0x86                    Networking
-
-
-T1040 SoC Overview
-------------------
-The QorIQ T1040/T1042 processor support four integrated 64-bit e5500 PA
-processor cores with high-performance data path acceleration architecture
-and network peripheral interfaces required for networking & telecommunications.
-
-The T1040/T1042 SoC includes the following function and features:
-
- - Four e5500 cores, each with a private 256 KB L2 cache
- - 256 KB shared L3 CoreNet platform cache (CPC)
- - Interconnect CoreNet platform
- - 32-/64-bit DDR3L/DDR4 SDRAM memory controller with ECC and interleaving
-   support
- - Data Path Acceleration Architecture (DPAA) incorporating acceleration
- for the following functions:
-    -  Packet parsing, classification, and distribution
-    -  Queue management for scheduling, packet sequencing, and congestion
-       management
-    -  Cryptography Acceleration (SEC 5.0)
-    - RegEx Pattern Matching Acceleration (PME 2.2)
-    - IEEE Std 1588 support
-    - Hardware buffer management for buffer allocation and deallocation
- - Ethernet interfaces
-    - Integrated 8-port Gigabit Ethernet switch (T1040 only)
-    - Four 1 Gbps Ethernet controllers
- - Two RGMII interfaces or one RGMII and one MII interfaces
- - High speed peripheral interfaces
-   - Four PCI Express 2.0 controllers running at up to 5 GHz
-   - Two SATA controllers supporting 1.5 and 3.0 Gb/s operation
-   - Upto two QSGMII interface
-   - Upto six SGMII interface supporting 1000 Mbps
-   - One SGMII interface supporting upto 2500 Mbps
- - Additional peripheral interfaces
-   - Two USB 2.0 controllers with integrated PHY
-   - SD/eSDHC/eMMC
-   - eSPI controller
-   - Four I2C controllers
-   - Four UARTs
-   - Four GPIO controllers
-   - Integrated flash controller (IFC)
-   - LCD and HDMI interface (DIU) with 12 bit dual data rate
-   - TDM interface
- - Multicore programmable interrupt controller (PIC)
- - Two 8-channel DMA engines
- - Single source clocking implementation
- - Deep Sleep power implementaion (wakeup from GPIO/Timer/Ethernet/USB)
-
-T1040 SoC Personalities
--------------------------
-T1022 Personality:
-T1022 is a reduced personality of T1040 with less core/clusters.
-
-T1042 Personality:
-T1042 is a reduced personality of T1040 without Integrated 8-port Gigabit
-Ethernet switch. Rest of the blocks are same as T1040
-
-
-T1040RDB board Overview
--------------------------
- - SERDES Connections, 8 lanes information:
-	1: None
-	2: SGMII
-	3: QSGMII
-	4: QSGMII
-	5: PCIe1 x1 slot
-	6: mini PCIe connector
-	7: mini PCIe connector
-	8: SATA connector
- - DDR Controller
-     - Supports rates of up to 1600 MHz data-rate
-     - Supports one DDR3LP UDIMM/RDIMMs, of single-, dual- or quad-rank types.
- - IFC/Local Bus
-     - NAND flash: 1GB 8-bit NAND flash
-     - NOR: 128MB 16-bit NOR Flash
- - Ethernet
-     - Two on-board RGMII 10/100/1G ethernet ports.
- - CPLD
- - Clocks
-     - System and DDR clock (SYSCLK, “DDRCLK”)
-     - SERDES clocks
- - Power Supplies
- - USB
-     - Supports two USB 2.0 ports with integrated PHYs
-     - Two type A ports with 5V@1.5A per port.
- - SDHC
-     - SDHC/SDXC connector
- - SPI
-    -  On-board 64MB SPI flash
- - Other IO
-    - Two Serial ports
-    - Four I2C ports
-
-T1042RDB_PI board Overview
--------------------------
- - SERDES Connections, 8 lanes information:
-	1, 2, 3, 4 : PCIe x4 slot
-	5: mini PCIe connector
-	6: mini PCIe connector
-	7: NA
-	8: SATA connector
- - DDR Controller
-     - Supports rates of up to 1600 MHz data-rate
-     - Supports one DDR3LP UDIMM/RDIMMs, of single-, dual- or quad-rank types.
- - IFC/Local Bus
-     - NAND flash: 1GB 8-bit NAND flash
-     - NOR: 128MB 16-bit NOR Flash
- - Ethernet
-     - Two on-board RGMII 10/100/1G ethernet ports.
- - CPLD
- - Clocks
-     - System and DDR clock (SYSCLK, “DDRCLK”)
-     - SERDES clocks
- - Video
-     - DIU supports video at up to 1280x1024x32bpp
- - Power Supplies
- - USB
-     - Supports two USB 2.0 ports with integrated PHYs
-     - Two type A ports with 5V@1.5A per port.
- - SDHC
-     - SDHC/SDXC connector
- - SPI
-    -  On-board 64MB SPI flash
- - Other IO
-    - Two Serial ports
-    - Four I2C ports
-
-Memory map
------------
-The addresses in brackets are physical addresses.
-
-Start Address  End Address      Description                     Size
-0xF_FFDF_0000  0xF_FFDF_0FFF    IFC - CPLD                      4KB
-0xF_FF80_0000  0xF_FF80_FFFF    IFC - NAND Flash                64KB
-0xF_FE00_0000  0xF_FEFF_FFFF    CCSRBAR                         16MB
-0xF_F803_0000  0xF_F803_FFFF    PCI Express 4 I/O Space         64KB
-0xF_F802_0000  0xF_F802_FFFF    PCI Express 3 I/O Space	        64KB
-0xF_F801_0000  0xF_F801_FFFF    PCI Express 2 I/O Space         64KB
-0xF_F800_0000  0xF_F800_FFFF    PCI Express 1 I/O Space	        64KB
-0xF_F600_0000  0xF_F7FF_FFFF    Queue manager software portal   32MB
-0xF_F400_0000  0xF_F5FF_FFFF    Buffer manager software portal  32MB
-0xF_E800_0000  0xF_EFFF_FFFF    IFC - NOR Flash                 128MB
-0xF_0000_0000  0xF_003F_FFFF    DCSR                            4MB
-0xC_3000_0000  0xC_3FFF_FFFF    PCI Express 4 Mem Space         256MB
-0xC_2000_0000  0xC_2FFF_FFFF    PCI Express 3 Mem Space         256MB
-0xC_1000_0000  0xC_1FFF_FFFF    PCI Express 2 Mem Space         256MB
-0xC_0000_0000  0xC_0FFF_FFFF    PCI Express 1 Mem Space         256MB
-0x0_0000_0000  0x0_ffff_ffff    DDR                             2GB
-
-
-NOR Flash memory Map
----------------------
- Start          End             Definition                       Size
-0xEFF40000      0xEFFFFFFF      U-Boot (current bank)            768KB
-0xEFF20000      0xEFF3FFFF      U-Boot env (current bank)        128KB
-0xEFF00000      0xEFF1FFFF      FMAN Ucode (current bank)        128KB
-0xED300000      0xEFEFFFFF      rootfs (alt bank)                44MB
-0xEC800000      0xEC8FFFFF      Hardware device tree (alt bank)  1MB
-0xEC020000      0xEC7FFFFF      Linux.uImage (alt bank)          7MB + 875KB
-0xEC000000      0xEC01FFFF      RCW (alt bank)                   128KB
-0xEBF40000      0xEBFFFFFF      U-Boot (alt bank)                768KB
-0xEBF20000      0xEBF3FFFF      U-Boot env (alt bank)            128KB
-0xEBF00000      0xEBF1FFFF      FMAN ucode (alt bank)            128KB
-0xE9300000      0xEBEFFFFF      rootfs (current bank)            44MB
-0xE8800000      0xE88FFFFF      Hardware device tree (cur bank)  11MB + 512KB
-0xE8020000      0xE86FFFFF      Linux.uImage (current bank)      7MB + 875KB
-0xE8000000      0xE801FFFF      RCW (current bank)               128KB
-
-
-Various Software configurations/environment variables/commands
---------------------------------------------------------------
-The below commands apply to the board
-
-1. U-Boot environment variable hwconfig
-   The default hwconfig is:
-	hwconfig=fsl_ddr:ctlr_intlv=null,bank_intlv=cs0_cs1;usb1:
-					dr_mode=host,phy_type=utmi
-   Note: For USB gadget set "dr_mode=peripheral"
-
-2. FMAN Ucode versions
-   fsl_fman_ucode_t1040.bin
-
-3. Switching to alternate bank
-   Commands for switching to alternate bank.
-
-	1. To change from vbank0 to vbank4
-		=> cpld reset altbank (it will boot using vbank4)
-
-	2.To change from vbank4 to vbank0
-		=> cpld reset (it will boot using vbank0)
-
-NAND boot with 2 Stage boot loader
-----------------------------------
-PBL initialise the internal SRAM and copy SPL(160KB) in SRAM.
-SPL further initialise DDR using SPD and environment variables and copy
-U-Boot(768 KB) from flash to DDR.
-Finally SPL transer control to U-Boot for futher booting.
-
-SPL has following features:
- - Executes within 256K
- - No relocation required
-
- Run time view of SPL framework during  boot :-
- -----------------------------------------------
- Area        | Address                         |
------------------------------------------------
- Secure boot | 0xFFFC0000 (32KB)               |
- headers     |                                 |
- -----------------------------------------------
- GD, BD      | 0xFFFC8000 (4KB)                |
- -----------------------------------------------
- ENV         | 0xFFFC9000 (8KB)                |
- -----------------------------------------------
- HEAP        | 0xFFFCB000 (30KB)               |
- -----------------------------------------------
- STACK       | 0xFFFD8000 (22KB)               |
- -----------------------------------------------
- U-Boot SPL  | 0xFFFD8000 (160KB)              |
- -----------------------------------------------
-
-NAND Flash memory Map on T104xRDB
-------------------------------------------
- Start		 End		Definition			Size
-0x000000	0x0FFFFF	U-Boot                          1MB
-0x180000	0x19FFFF	U-Boot env                      128KB
-0x280000	0x29FFFF	FMAN Ucode                      128KB
-0x380000	0x39FFFF	QE Firmware                     128KB
-
-SD Card memory Map on T104xRDB
-------------------------------------------
- Block		#blocks		Definition			Size
-0x008		2048		U-Boot                          1MB
-0x800		0024		U-Boot env                      8KB
-0x820		0256		FMAN Ucode                      128KB
-0x920		0256		QE Firmware                     128KB
-
-SPI Flash memory Map on T104xRDB
-------------------------------------------
- Start		 End		Definition			Size
-0x000000	0x0FFFFF	U-Boot                          1MB
-0x100000	0x101FFF	U-Boot env                      8KB
-0x110000	0x12FFFF	FMAN Ucode                      128KB
-0x130000	0x14FFFF	QE Firmware                     128KB
-
-Please note QE Firmware is only valid for T1040RDB
-
-
-Switch Settings for T104xRDB boards: (ON is 0, OFF is 1)
-==========================================================
-NOR boot SW setting:
-SW1: 00010011
-SW2: 10111011
-SW3: 11100001
-
-NAND boot SW setting:
-SW1: 10001000
-SW2: 00111011
-SW3: 11110001
-
-SPI boot SW setting:
-SW1: 00100010
-SW2: 10111011
-SW3: 11100001
-
-SD boot SW setting:
-SW1: 00100000
-SW2: 00111011
-SW3: 11100001
-
-Switch Settings for T104xD4RDB boards: (ON is 0, OFF is 1)
-=============================================================
-NOR boot SW setting:
-SW1: 00010011
-SW2: 10111001
-SW3: 11100001
-
-NAND boot SW setting:
-SW1: 10001000
-SW2: 00111001
-SW3: 11110001
-
-SPI boot SW setting:
-SW1: 00100010
-SW2: 10111001
-SW3: 11100001
-
-SD boot SW setting:
-SW1: 00100000
-SW2: 00111001
-SW3: 11100001
-
-PBL-based image generation
-==========================
-Changes only the required register bit in in PBI commands.
-
-Provides reference code which might needs some
-modification as per requirement.
-example:
-By default PBI_SRC=14 (which is for IFC-NAND/NOR) in rcw.cfg file
-which needs to be changed for SPI and SD.
-
-For SD-boot
-==============
-1. Set RCW[192:195], PBI_SRC bits as 6 in RCW file (t1040d4_rcw.cfg type files)
-
-example:
- RCW file: board/nxp/t104xrdb/t1040d4_rcw.cfg
-
-Change
-66000002 40000002 ec027000 01000000
-to
-66000002 40000002 6c027000 01000000
-
-2. SD does not support flush so remove flush from pbl, make changes in
-   tools/pblimage.c file, Update value of pbl_end_cmd[0] = 0x09138000
-   with 0x091380c0
-
-For SPI-boot
-==============
-1. Set RCW[192:195], PBI_SRC bits as 5 in RCW file (t1040d4_rcw.cfg type files)
-
-example:
- RCW file: board/nxp/t104xrdb/t1040d4_rcw.cfg
-
-Change
-66000002 40000002 ec027000 01000000
-to
-66000002 40000002 5c027000 01000000
-
-2. SPI does not support flush so remove flush from pbl, make changes in
-   tools/pblimage.c file, Update value of pbl_end_cmd[0] = 0x09138000
-   with 0x091380c0
-
-Device tree support and how to enable it for different configs
---------------------------------------------------------------
-Device tree support is available for t1042d4rdb for below mentioned boot,
-1. NOR Boot
-2. NAND Boot
-3. SD Boot
-4. SPIFLASH Boot
-
-To enable device tree support for other boot, below configs need to be
-enabled in relative defconfig file,
-1. CONFIG_DEFAULT_DEVICE_TREE="t1042d4rdb" (Change default device tree name if required)
-2. CONFIG_OF_CONTROL
-3. CONFIG_MPC85XX_HAVE_RESET_VECTOR if reset vector is located at
-   CFG_RESET_VECTOR_ADDRESS - 0xffc
-
-If device tree support is enabled in defconfig,
-1. use 'u-boot.bin' for NOR boot.
-2. use 'u-boot-with-spl-pbl.bin' for other boot.
diff --git a/board/nxp/t104xrdb/cpld.c b/board/nxp/t104xrdb/cpld.c
deleted file mode 100644
index 038e40e2fae..00000000000
--- a/board/nxp/t104xrdb/cpld.c
+++ /dev/null
@@ -1,116 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/**
- * Copyright 2014 Freescale Semiconductor
- *
- * This file provides support for the board-specific CPLD used on some Freescale
- * reference boards.
- *
- * The following macros need to be defined:
- *
- * CFG_SYS_CPLD_BASE-The virtual address of the base of the CPLD register map
- */
-
-#include <config.h>
-#include <command.h>
-#include <linux/string.h>
-#include <asm/io.h>
-
-#include "cpld.h"
-
-u8 cpld_read(unsigned int reg)
-{
-	void *p = (void *)CFG_SYS_CPLD_BASE;
-
-	return in_8(p + reg);
-}
-
-void cpld_write(unsigned int reg, u8 value)
-{
-	void *p = (void *)CFG_SYS_CPLD_BASE;
-
-	out_8(p + reg, value);
-}
-
-/**
- * Set the boot bank to the alternate bank
- */
-void cpld_set_altbank(void)
-{
-	u8 reg = CPLD_READ(flash_ctl_status);
-
-	reg = (reg & ~CPLD_BANK_SEL_MASK) | CPLD_LBMAP_ALTBANK;
-
-	CPLD_WRITE(flash_ctl_status, reg);
-	CPLD_WRITE(reset_ctl1, CPLD_LBMAP_RESET);
-}
-
-/**
- * Set the boot bank to the default bank
- */
-void cpld_set_defbank(void)
-{
-	u8 reg = CPLD_READ(flash_ctl_status);
-
-	reg = (reg & ~CPLD_BANK_SEL_MASK) | CPLD_LBMAP_DFLTBANK;
-
-	CPLD_WRITE(flash_ctl_status, reg);
-	CPLD_WRITE(reset_ctl1, CPLD_LBMAP_RESET);
-}
-
-#ifdef DEBUG
-static void cpld_dump_regs(void)
-{
-	printf("cpld_ver	 = 0x%02x\n", CPLD_READ(cpld_ver));
-	printf("cpld_ver_sub	 = 0x%02x\n", CPLD_READ(cpld_ver_sub));
-	printf("hw_ver		 = 0x%02x\n", CPLD_READ(hw_ver));
-	printf("sw_ver		 = 0x%02x\n", CPLD_READ(sw_ver));
-	printf("reset_ctl1	 = 0x%02x\n", CPLD_READ(reset_ctl1));
-	printf("reset_ctl2	 = 0x%02x\n", CPLD_READ(reset_ctl2));
-	printf("int_status	 = 0x%02x\n", CPLD_READ(int_status));
-	printf("flash_ctl_status = 0x%02x\n", CPLD_READ(flash_ctl_status));
-	printf("fan_ctl_status	 = 0x%02x\n", CPLD_READ(fan_ctl_status));
-#if defined(CONFIG_TARGET_T1040D4D4RDB) || defined(CONFIG_TARGET_T1042D4RDB)
-	printf("int_mask	 = 0x%02x\n", CPLD_READ(int_mask));
-#else
-	printf("led_ctl_status	 = 0x%02x\n", CPLD_READ(led_ctl_status));
-#endif
-	printf("sfp_ctl_status	 = 0x%02x\n", CPLD_READ(sfp_ctl_status));
-	printf("misc_ctl_status	 = 0x%02x\n", CPLD_READ(misc_ctl_status));
-	printf("boot_override	 = 0x%02x\n", CPLD_READ(boot_override));
-	printf("boot_config1	 = 0x%02x\n", CPLD_READ(boot_config1));
-	printf("boot_config2	 = 0x%02x\n", CPLD_READ(boot_config2));
-	putc('\n');
-}
-#endif
-
-int do_cpld(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
-{
-	int rc = 0;
-
-	if (argc <= 1)
-		return cmd_usage(cmdtp);
-
-	if (strcmp(argv[1], "reset") == 0) {
-		if (strcmp(argv[2], "altbank") == 0)
-			cpld_set_altbank();
-		else
-			cpld_set_defbank();
-#ifdef DEBUG
-	} else if (strcmp(argv[1], "dump") == 0) {
-		cpld_dump_regs();
-#endif
-	} else
-		rc = cmd_usage(cmdtp);
-
-	return rc;
-}
-
-U_BOOT_CMD(
-	cpld, CONFIG_SYS_MAXARGS, 1, do_cpld,
-	"Reset the board or alternate bank",
-	"reset - hard reset to default bank\n"
-	"cpld reset altbank - reset to alternate bank\n"
-#ifdef DEBUG
-	"cpld dump - display the CPLD registers\n"
-#endif
-	);
diff --git a/board/nxp/t104xrdb/cpld.h b/board/nxp/t104xrdb/cpld.h
deleted file mode 100644
index 0384202fbcb..00000000000
--- a/board/nxp/t104xrdb/cpld.h
+++ /dev/null
@@ -1,45 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/**
- * Copyright 2013 Freescale Semiconductor
- *
- * This file provides support for the ngPIXIS, a board-specific FPGA used on
- * some Freescale reference boards.
- */
-
-/*
- * CPLD register set. Feel free to add board-specific #ifdefs where necessary.
- */
-struct cpld_data {
-	u8 cpld_ver;		/* 0x00 - CPLD Major Revision Register */
-	u8 cpld_ver_sub;	/* 0x01 - CPLD Minor Revision Register */
-	u8 hw_ver;		/* 0x02 - Hardware Revision Register */
-	u8 sw_ver;		/* 0x03 - Software Revision register */
-	u8 res0[12];		/* 0x04 - 0x0F - not used */
-	u8 reset_ctl1;		/* 0x10 - Reset control Register1 */
-	u8 reset_ctl2;		/* 0x11 - Reset control Register2 */
-	u8 int_status;		/* 0x12 - Interrupt status Register */
-	u8 flash_ctl_status;	/* 0x13 - Flash control and status register */
-	u8 fan_ctl_status;	/* 0x14 - Fan control and status register  */
-#if defined(CONFIG_TARGET_T1042D4RDB)
-	u8 int_mask;		/* 0x15 - Interrupt mask Register */
-#else
-	u8 led_ctl_status;	/* 0x15 - LED control and status register */
-#endif
-	u8 sfp_ctl_status;	/* 0x16 - SFP control and status register  */
-	u8 misc_ctl_status;	/* 0x17 - Miscellanies ctrl & status register*/
-	u8 boot_override;	/* 0x18 - Boot override register */
-	u8 boot_config1;	/* 0x19 - Boot config override register*/
-	u8 boot_config2;	/* 0x1A - Boot config override register*/
-};
-
-/* Pointer to the CPLD register set */
-
-u8 cpld_read(unsigned int reg);
-void cpld_write(unsigned int reg, u8 value);
-
-#define CPLD_READ(reg) cpld_read(offsetof(struct cpld_data, reg))
-#define CPLD_WRITE(reg, value)\
-		cpld_write(offsetof(struct cpld_data, reg), value)
-#define MISC_CTL_SG_SEL		0x80
-#define MISC_CTL_AURORA_SEL	0x02
-#define MISC_MUX_QE_TDM		0xc0
diff --git a/board/nxp/t104xrdb/ddr.c b/board/nxp/t104xrdb/ddr.c
deleted file mode 100644
index 6c066480b46..00000000000
--- a/board/nxp/t104xrdb/ddr.c
+++ /dev/null
@@ -1,148 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright 2013 Freescale Semiconductor, Inc.
- * Copyright 2021 NXP
- */
-
-#include <config.h>
-#include <i2c.h>
-#include <hwconfig.h>
-#include <init.h>
-#include <log.h>
-#include <asm/global_data.h>
-#include <asm/mmu.h>
-#include <fsl_ddr_sdram.h>
-#include <fsl_ddr_dimm_params.h>
-#include <asm/fsl_law.h>
-#include <asm/mpc85xx_gpio.h>
-#include <linux/delay.h>
-#include "ddr.h"
-
-DECLARE_GLOBAL_DATA_PTR;
-
-void fsl_ddr_board_options(memctl_options_t *popts,
-				dimm_params_t *pdimm,
-				unsigned int ctrl_num)
-{
-	const struct board_specific_parameters *pbsp, *pbsp_highest = NULL;
-	ulong ddr_freq;
-
-	if (ctrl_num > 1) {
-		printf("Not supported controller number %d\n", ctrl_num);
-		return;
-	}
-	if (!pdimm->n_ranks)
-		return;
-
-	pbsp = udimms[0];
-
-	/* Get clk_adjust according to the board ddr
-	 * freqency and n_banks specified in board_specific_parameters table.
-	 */
-	ddr_freq = get_ddr_freq(0) / 1000000;
-	while (pbsp->datarate_mhz_high) {
-		if (pbsp->n_ranks == pdimm->n_ranks &&
-		    (pdimm->rank_density >> 30) >= pbsp->rank_gb) {
-			if (ddr_freq <= pbsp->datarate_mhz_high) {
-				popts->clk_adjust = pbsp->clk_adjust;
-				popts->wrlvl_start = pbsp->wrlvl_start;
-				popts->wrlvl_ctl_2 = pbsp->wrlvl_ctl_2;
-				popts->wrlvl_ctl_3 = pbsp->wrlvl_ctl_3;
-				goto found;
-			}
-			pbsp_highest = pbsp;
-		}
-		pbsp++;
-	}
-
-	if (pbsp_highest) {
-		printf("Error: board specific timing not found\n");
-		printf("for data rate %lu MT/s\n", ddr_freq);
-		printf("Trying to use the highest speed (%u) parameters\n",
-		       pbsp_highest->datarate_mhz_high);
-		popts->clk_adjust = pbsp_highest->clk_adjust;
-		popts->wrlvl_start = pbsp_highest->wrlvl_start;
-		popts->wrlvl_ctl_2 = pbsp->wrlvl_ctl_2;
-		popts->wrlvl_ctl_3 = pbsp->wrlvl_ctl_3;
-	} else {
-		panic("DIMM is not supported by this board");
-	}
-found:
-	debug("Found timing match: n_ranks %d, data rate %d, rank_gb %d\n"
-		"\tclk_adjust %d, wrlvl_start %d, wrlvl_ctrl_2 0x%x, "
-		"wrlvl_ctrl_3 0x%x\n",
-		pbsp->n_ranks, pbsp->datarate_mhz_high, pbsp->rank_gb,
-		pbsp->clk_adjust, pbsp->wrlvl_start, pbsp->wrlvl_ctl_2,
-		pbsp->wrlvl_ctl_3);
-
-	/*
-	 * Factors to consider for half-strength driver enable:
-	 *	- number of DIMMs installed
-	 */
-#ifdef CONFIG_SYS_FSL_DDR4
-	popts->half_strength_driver_enable = 1;
-	/* optimize cpo for erratum A-009942 */
-	popts->cpo_sample = 0x59;
-#else
-	popts->cpo_sample = 0x54;
-	popts->half_strength_driver_enable = 0;
-#endif
-	/*
-	 * Write leveling override
-	 */
-	popts->wrlvl_override = 1;
-	popts->wrlvl_sample = 0xf;
-
-	/*
-	 * rtt and rtt_wr override
-	 */
-	popts->rtt_override = 0;
-
-	/* Enable ZQ calibration */
-	popts->zq_en = 1;
-
-	/* DHC_EN =1, ODT = 75 Ohm */
-#ifdef CONFIG_SYS_FSL_DDR4
-	popts->ddr_cdr1 = DDR_CDR1_DHC_EN | DDR_CDR1_ODT(DDR_CDR_ODT_120OHM);
-	popts->ddr_cdr2 = DDR_CDR2_ODT(DDR_CDR_ODT_120OHM) |
-		DDR_CDR2_VREF_OVRD(70);       /* Vref = 70% */
-#else
-	popts->ddr_cdr1 = DDR_CDR1_DHC_EN | DDR_CDR1_ODT(DDR_CDR_ODT_75ohm);
-	popts->ddr_cdr2 = DDR_CDR2_ODT(DDR_CDR_ODT_75ohm);
-#endif
-}
-
-#if defined(CONFIG_DEEP_SLEEP)
-void board_mem_sleep_setup(void)
-{
-	void __iomem *cpld_base = (void *)CFG_SYS_CPLD_BASE;
-
-	/* does not provide HW signals for power management */
-	clrbits_8(cpld_base + 0x17, 0x40);
-	/* Disable MCKE isolation */
-	gpio_set_value(2, 0);
-	udelay(1);
-}
-#endif
-
-int dram_init(void)
-{
-	phys_size_t dram_size;
-
-#if defined(CONFIG_XPL_BUILD) || !defined(CONFIG_RAMBOOT_PBL)
-	puts("Initializing....using SPD\n");
-	dram_size = fsl_ddr_sdram();
-#else
-	dram_size =  fsl_ddr_sdram_size();
-#endif
-	dram_size = setup_ddr_tlbs(dram_size / 0x100000);
-	dram_size *= 0x100000;
-
-#if defined(CONFIG_DEEP_SLEEP) && !defined(CONFIG_XPL_BUILD)
-	fsl_dp_resume();
-#endif
-
-	gd->ram_size = dram_size;
-
-	return 0;
-}
diff --git a/board/nxp/t104xrdb/ddr.h b/board/nxp/t104xrdb/ddr.h
deleted file mode 100644
index f9d667f6174..00000000000
--- a/board/nxp/t104xrdb/ddr.h
+++ /dev/null
@@ -1,56 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright 2013 Freescale Semiconductor, Inc.
- */
-
-#ifndef __DDR_H__
-#define __DDR_H__
-struct board_specific_parameters {
-	u32 n_ranks;
-	u32 datarate_mhz_high;
-	u32 rank_gb;
-	u32 clk_adjust;
-	u32 wrlvl_start;
-	u32 wrlvl_ctl_2;
-	u32 wrlvl_ctl_3;
-};
-
-/*
- * These tables contain all valid speeds we want to override with board
- * specific parameters. datarate_mhz_high values need to be in ascending order
- * for each n_ranks group.
- */
-
-static const struct board_specific_parameters udimm0[] = {
-	/*
-	 * memory controller 0
-	 *   num|  hi| rank|  clk| wrlvl |   wrlvl
-	 * ranks| mhz| GB  |adjst| start |   ctl2
-	 */
-#ifdef CONFIG_SYS_FSL_DDR4
-	{2,  1600, 4, 8,     6, 0x07090A0c, 0x0e0f100a},
-	{1,  1600, 4, 8,     5, 0x0607080B, 0x0C0C0D09},
-#elif defined(CONFIG_SYS_FSL_DDR3)
-	{2,  833,  4, 8,     6, 0x06060607, 0x08080807},
-	{2,  833,  0, 8,     6, 0x06060607, 0x08080807},
-	{2,  1350, 4, 8,     7, 0x0708080A, 0x0A0B0C09},
-	{2,  1350, 0, 8,     7, 0x0708080A, 0x0A0B0C09},
-	{2,  1666, 4, 8,     7, 0x0808090B, 0x0C0D0E0A},
-	{2,  1666, 0, 8,     7, 0x0808090B, 0x0C0D0E0A},
-	{1,  833,  4, 8,     6, 0x06060607, 0x08080807},
-	{1,  833,  0, 8,     6, 0x06060607, 0x08080807},
-	{1,  1350, 4, 8,     7, 0x0708080A, 0x0A0B0C09},
-	{1,  1350, 0, 8,     7, 0x0708080A, 0x0A0B0C09},
-	{1,  1666, 4, 8,     7, 0x0808090B, 0x0C0D0E0A},
-	{1,  1666, 0, 8,     7, 0x0808090B, 0x0C0D0E0A},
-#else
-#error DDR type not defined
-#endif
-	{}
-};
-
-#endif
-
-static const struct board_specific_parameters *udimms[] = {
-	udimm0,
-};
diff --git a/board/nxp/t104xrdb/law.c b/board/nxp/t104xrdb/law.c
deleted file mode 100644
index d34641c2397..00000000000
--- a/board/nxp/t104xrdb/law.c
+++ /dev/null
@@ -1,31 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright 2013 Freescale Semiconductor, Inc.
- */
-
-#include <config.h>
-#include <asm/fsl_law.h>
-#include <asm/mmu.h>
-
-struct law_entry law_table[] = {
-#ifdef CONFIG_MTD_NOR_FLASH
-	SET_LAW(CFG_SYS_FLASH_BASE_PHYS, LAW_SIZE_256M, LAW_TRGT_IF_IFC),
-#endif
-#ifdef CFG_SYS_BMAN_MEM_PHYS
-	SET_LAW(CFG_SYS_BMAN_MEM_PHYS, LAW_SIZE_32M, LAW_TRGT_IF_BMAN),
-#endif
-#ifdef CFG_SYS_QMAN_MEM_PHYS
-	SET_LAW(CFG_SYS_QMAN_MEM_PHYS, LAW_SIZE_32M, LAW_TRGT_IF_QMAN),
-#endif
-#ifdef CFG_SYS_CPLD_BASE_PHYS
-	SET_LAW(CFG_SYS_CPLD_BASE_PHYS, LAW_SIZE_128K, LAW_TRGT_IF_IFC),
-#endif
-#ifdef CFG_SYS_DCSRBAR_PHYS
-	SET_LAW(CFG_SYS_DCSRBAR_PHYS, LAW_SIZE_4M, LAW_TRGT_IF_DCSR),
-#endif
-#ifdef CFG_SYS_NAND_BASE_PHYS
-	SET_LAW(CFG_SYS_NAND_BASE_PHYS, LAW_SIZE_64K, LAW_TRGT_IF_IFC),
-#endif
-};
-
-int num_law_entries = ARRAY_SIZE(law_table);
diff --git a/board/nxp/t104xrdb/spl.c b/board/nxp/t104xrdb/spl.c
deleted file mode 100644
index e02a1f95d4c..00000000000
--- a/board/nxp/t104xrdb/spl.c
+++ /dev/null
@@ -1,131 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/* Copyright 2013 Freescale Semiconductor, Inc.
- */
-
-#include <config.h>
-#include <clock_legacy.h>
-#include <console.h>
-#include <env_internal.h>
-#include <init.h>
-#include <malloc.h>
-#include <ns16550.h>
-#include <nand.h>
-#include <i2c.h>
-#include <mmc.h>
-#include <fsl_esdhc.h>
-#include <spi_flash.h>
-#include <asm/global_data.h>
-#include "../common/sleep.h"
-#include "../common/spl.h"
-
-DECLARE_GLOBAL_DATA_PTR;
-
-phys_size_t get_effective_memsize(void)
-{
-	return CONFIG_SYS_L3_SIZE;
-}
-
-#define FSL_CORENET_CCSR_PORSR1_RCW_MASK	0xFF800000
-void board_init_f(ulong bootflag)
-{
-	u32 plat_ratio, sys_clk, uart_clk;
-#if defined(CONFIG_SPL_NAND_BOOT) && defined(CONFIG_A008044_WORKAROUND)
-	u32 porsr1, pinctl;
-	u32 svr = get_svr();
-#endif
-	ccsr_gur_t *gur = (void *)CFG_SYS_MPC85xx_GUTS_ADDR;
-
-#if defined(CONFIG_SPL_NAND_BOOT) && defined(CONFIG_A008044_WORKAROUND)
-	if (IS_SVR_REV(svr, 1, 0)) {
-		/*
-		 * There is T1040 SoC issue where NOR, FPGA are inaccessible
-		 * during NAND boot because IFC signals > IFC_AD7 are not
-		 * enabled. This workaround changes RCW source to make all
-		 * signals enabled.
-		 */
-		porsr1 = in_be32(&gur->porsr1);
-		pinctl = ((porsr1 & ~(FSL_CORENET_CCSR_PORSR1_RCW_MASK))
-			  | 0x24800000);
-		out_be32((unsigned int *)(CFG_SYS_DCSRBAR + 0x20000),
-			 pinctl);
-	}
-#endif
-
-	/* Memcpy existing GD at CONFIG_SPL_GD_ADDR */
-	memcpy((void *)CONFIG_SPL_GD_ADDR, (void *)gd, sizeof(gd_t));
-
-	/* Update GD pointer */
-	gd = (gd_t *)(CONFIG_SPL_GD_ADDR);
-
-#ifdef CONFIG_DEEP_SLEEP
-	/* disable the console if boot from deep sleep */
-	if (is_warm_boot())
-		fsl_dp_disable_console();
-#endif
-	/* compiler optimization barrier needed for GCC >= 3.4 */
-	__asm__ __volatile__("" : : : "memory");
-
-	console_init_f();
-
-	/* initialize selected port with appropriate baud rate */
-	sys_clk = get_board_sys_clk();
-	plat_ratio = (in_be32(&gur->rcwsr[0]) >> 25) & 0x1f;
-	uart_clk = sys_clk * plat_ratio / 2;
-
-	ns16550_init((struct ns16550 *)CFG_SYS_NS16550_COM1,
-		     uart_clk / 16 / CONFIG_BAUDRATE);
-
-	relocate_code(CONFIG_SPL_RELOC_STACK, (gd_t *)CONFIG_SPL_GD_ADDR, 0x0);
-}
-
-void board_init_r(gd_t *gd, ulong dest_addr)
-{
-	struct bd_info *bd;
-
-	bd = (struct bd_info *)(gd + sizeof(gd_t));
-	memset(bd, 0, sizeof(struct bd_info));
-	gd->bd = bd;
-
-	arch_cpu_init();
-	get_clocks();
-	mem_malloc_init(CONFIG_SPL_RELOC_MALLOC_ADDR,
-			CONFIG_SPL_RELOC_MALLOC_SIZE);
-	gd->flags |= GD_FLG_FULL_MALLOC_INIT;
-
-#ifdef CONFIG_SPL_MMC_BOOT
-	mmc_initialize(bd);
-#endif
-
-	/* relocate environment function pointers etc. */
-#if defined(CONFIG_ENV_IS_IN_NAND) || defined(CONFIG_ENV_IS_IN_MMC) || \
-	defined(CONFIG_ENV_IS_IN_SPI_FLASH)
-#ifdef CONFIG_SPL_NAND_BOOT
-	nand_spl_load_image(CONFIG_ENV_OFFSET, CONFIG_ENV_SIZE,
-			    (uchar *)SPL_ENV_ADDR);
-#endif
-#ifdef CONFIG_SPL_MMC_BOOT
-	mmc_spl_load_image(CONFIG_ENV_OFFSET, CONFIG_ENV_SIZE,
-			   (uchar *)SPL_ENV_ADDR);
-#endif
-#ifdef CONFIG_SPL_SPI_BOOT
-	fsl_spi_spl_load_image(CONFIG_ENV_OFFSET, CONFIG_ENV_SIZE,
-			       (uchar *)SPL_ENV_ADDR);
-#endif
-	gd->env_addr  = (ulong)(SPL_ENV_ADDR);
-	gd->env_valid = ENV_VALID;
-#endif
-
-	i2c_init_all();
-
-	puts("\n\n");
-
-	dram_init();
-
-#ifdef CONFIG_SPL_MMC_BOOT
-	mmc_boot();
-#elif defined(CONFIG_SPL_SPI_BOOT)
-	fsl_spi_boot();
-#elif defined(CONFIG_SPL_NAND_BOOT)
-	nand_boot();
-#endif
-}
diff --git a/board/nxp/t104xrdb/t1040_nand_rcw.cfg b/board/nxp/t104xrdb/t1040_nand_rcw.cfg
deleted file mode 100644
index 3300c184a1a..00000000000
--- a/board/nxp/t104xrdb/t1040_nand_rcw.cfg
+++ /dev/null
@@ -1,7 +0,0 @@
-#PBL preamble and RCW header
-aa55aa55 010e0100
-# serdes protocol 0x66
-0c18000e 0e000000 00000000 00000000
-66000002 80000002 e8106000 01000000
-00000000 00000000 00000000 00032810
-00000000 0342500f 00000000 00000000
diff --git a/board/nxp/t104xrdb/t1040_sd_rcw.cfg b/board/nxp/t104xrdb/t1040_sd_rcw.cfg
deleted file mode 100644
index fd3e8c5bbf5..00000000000
--- a/board/nxp/t104xrdb/t1040_sd_rcw.cfg
+++ /dev/null
@@ -1,7 +0,0 @@
-#PBL preamble and RCW header
-aa55aa55 010e0100
-# serdes protocol 0x66
-0c18000e 0e000000 00000000 00000000
-66000002 80000002 68106000 01000000
-00000000 00000000 00000000 00032810
-00000000 0342500f 00000000 00000000
diff --git a/board/nxp/t104xrdb/t1040_spi_rcw.cfg b/board/nxp/t104xrdb/t1040_spi_rcw.cfg
deleted file mode 100644
index fccde5e01fe..00000000000
--- a/board/nxp/t104xrdb/t1040_spi_rcw.cfg
+++ /dev/null
@@ -1,7 +0,0 @@
-#PBL preamble and RCW header
-aa55aa55 010e0100
-# serdes protocol 0x66
-0c18000e 0e000000 00000000 00000000
-66000002 80000002 58106000 01000000
-00000000 00000000 00000000 00032810
-00000000 0342500f 00000000 00000000
diff --git a/board/nxp/t104xrdb/t1040d4_nand_rcw.cfg b/board/nxp/t104xrdb/t1040d4_nand_rcw.cfg
deleted file mode 100644
index c1034b3dfa3..00000000000
--- a/board/nxp/t104xrdb/t1040d4_nand_rcw.cfg
+++ /dev/null
@@ -1,7 +0,0 @@
-#PBL preamble and RCW header
-aa55aa55 010e0100
-# serdes protocol 0x66
-0c18000e 0e000000 00000000 00000000
-66000002 40000002 ec027000 01000000
-00000000 00000000 00000000 00030810
-00000000 0342580f 00000000 00000000
diff --git a/board/nxp/t104xrdb/t1040d4_sd_rcw.cfg b/board/nxp/t104xrdb/t1040d4_sd_rcw.cfg
deleted file mode 100644
index e6f7585bb02..00000000000
--- a/board/nxp/t104xrdb/t1040d4_sd_rcw.cfg
+++ /dev/null
@@ -1,7 +0,0 @@
-#PBL preamble and RCW header
-aa55aa55 010e0100
-# serdes protocol 0x66
-0c18000e 0e000000 00000000 00000000
-66000002 40000002 6c027000 01000000
-00000000 00000000 00000000 00030810
-00000000 0342580f 00000000 00000000
diff --git a/board/nxp/t104xrdb/t1040d4_spi_rcw.cfg b/board/nxp/t104xrdb/t1040d4_spi_rcw.cfg
deleted file mode 100644
index cde862dff5c..00000000000
--- a/board/nxp/t104xrdb/t1040d4_spi_rcw.cfg
+++ /dev/null
@@ -1,7 +0,0 @@
-#PBL preamble and RCW header
-aa55aa55 010e0100
-# serdes protocol 0x66
-0c18000e 0e000000 00000000 00000000
-66000002 40000002 5c027000 01000000
-00000000 00000000 00000000 00030810
-00000000 0342580f 00000000 00000000
diff --git a/board/nxp/t104xrdb/t1042_nand_rcw.cfg b/board/nxp/t104xrdb/t1042_nand_rcw.cfg
deleted file mode 100644
index db4d52f397d..00000000000
--- a/board/nxp/t104xrdb/t1042_nand_rcw.cfg
+++ /dev/null
@@ -1,7 +0,0 @@
-#PBL preamble and RCW header
-aa55aa55 010e0100
-# serdes protocol 0x86
-0c18000e 0e000000 00000000 00000000
-86000002 80000002 ec027000 01000000
-00000000 00000000 00000000 00032810
-00000000 0342500f 00000000 00000000
diff --git a/board/nxp/t104xrdb/t1042_pi_nand_rcw.cfg b/board/nxp/t104xrdb/t1042_pi_nand_rcw.cfg
deleted file mode 100644
index 57de89ad0e7..00000000000
--- a/board/nxp/t104xrdb/t1042_pi_nand_rcw.cfg
+++ /dev/null
@@ -1,7 +0,0 @@
-#PBL preamble and RCW header
-aa55aa55 010e0100
-# serdes protocol 0x06
-0c18000e 0e000000 00000000 00000000
-06000002 00400002 e8106000 01000000
-00000000 00000000 00000000 00030810
-00000000 01fe0a06 00000000 00000000
diff --git a/board/nxp/t104xrdb/t1042_pi_sd_rcw.cfg b/board/nxp/t104xrdb/t1042_pi_sd_rcw.cfg
deleted file mode 100644
index bbce9a36930..00000000000
--- a/board/nxp/t104xrdb/t1042_pi_sd_rcw.cfg
+++ /dev/null
@@ -1,7 +0,0 @@
-#PBL preamble and RCW header
-aa55aa55 010e0100
-# serdes protocol 0x06
-0c18000e 0e000000 00000000 00000000
-06000002 00400002 68106000 01000000
-00000000 00000000 00000000 00030810
-00000000 01fe0a06 00000000 00000000
diff --git a/board/nxp/t104xrdb/t1042_pi_spi_rcw.cfg b/board/nxp/t104xrdb/t1042_pi_spi_rcw.cfg
deleted file mode 100644
index b1d8b4c65af..00000000000
--- a/board/nxp/t104xrdb/t1042_pi_spi_rcw.cfg
+++ /dev/null
@@ -1,7 +0,0 @@
-#PBL preamble and RCW header
-aa55aa55 010e0100
-# serdes protocol 0x06
-0c18000e 0e000000 00000000 00000000
-06000002 00400002 58106000 01000000
-00000000 00000000 00000000 00030810
-00000000 01fe0a06 00000000 00000000
diff --git a/board/nxp/t104xrdb/t1042_sd_rcw.cfg b/board/nxp/t104xrdb/t1042_sd_rcw.cfg
deleted file mode 100644
index d77bf189b22..00000000000
--- a/board/nxp/t104xrdb/t1042_sd_rcw.cfg
+++ /dev/null
@@ -1,7 +0,0 @@
-#PBL preamble and RCW header
-aa55aa55 010e0100
-# serdes protocol 0x86
-0c18000e 0e000000 00000000 00000000
-86000002 80000002 6c027000 01000000
-00000000 00000000 00000000 00032810
-00000000 0342500f 00000000 00000000
diff --git a/board/nxp/t104xrdb/t1042_spi_rcw.cfg b/board/nxp/t104xrdb/t1042_spi_rcw.cfg
deleted file mode 100644
index e8a3ad12804..00000000000
--- a/board/nxp/t104xrdb/t1042_spi_rcw.cfg
+++ /dev/null
@@ -1,7 +0,0 @@
-#PBL preamble and RCW header
-aa55aa55 010e0100
-# serdes protocol 0x86
-0c18000e 0e000000 00000000 00000000
-86000002 80000002 5c027000 01000000
-00000000 00000000 00000000 00032810
-00000000 0342500f 00000000 00000000
diff --git a/board/nxp/t104xrdb/t1042d4_nand_rcw.cfg b/board/nxp/t104xrdb/t1042d4_nand_rcw.cfg
deleted file mode 100644
index 9e0ee2795f8..00000000000
--- a/board/nxp/t104xrdb/t1042d4_nand_rcw.cfg
+++ /dev/null
@@ -1,7 +0,0 @@
-#PBL preamble and RCW header
-aa55aa55 010e0100
-# serdes protocol 0x86
-0c18000e 0e000000 00000000 00000000
-86000002 40000002 ec027000 01000000
-00000000 00000000 00000000 00030810
-00000000 0342500f 00000000 00000000
diff --git a/board/nxp/t104xrdb/t1042d4_sd_rcw.cfg b/board/nxp/t104xrdb/t1042d4_sd_rcw.cfg
deleted file mode 100644
index 9d9046d6549..00000000000
--- a/board/nxp/t104xrdb/t1042d4_sd_rcw.cfg
+++ /dev/null
@@ -1,7 +0,0 @@
-#PBL preamble and RCW header
-aa55aa55 010e0100
-# serdes protocol 0x86
-0c18000e 0e000000 00000000 00000000
-86000002 40000002 6c027000 01000000
-00000000 00000000 00000000 00030810
-00000000 0342500f 00000000 00000000
diff --git a/board/nxp/t104xrdb/t1042d4_spi_rcw.cfg b/board/nxp/t104xrdb/t1042d4_spi_rcw.cfg
deleted file mode 100644
index f1ec98932f8..00000000000
--- a/board/nxp/t104xrdb/t1042d4_spi_rcw.cfg
+++ /dev/null
@@ -1,7 +0,0 @@
-#PBL preamble and RCW header
-aa55aa55 010e0100
-# serdes protocol 0x86
-0c18000e 0e000000 00000000 00000000
-86000002 40000002 5c027000 01000000
-00000000 00000000 00000000 00030810
-00000000 0342500f 00000000 00000000
diff --git a/board/nxp/t104xrdb/t104x_pbi.cfg b/board/nxp/t104xrdb/t104x_pbi.cfg
deleted file mode 100644
index 51945b47489..00000000000
--- a/board/nxp/t104xrdb/t104x_pbi.cfg
+++ /dev/null
@@ -1,36 +0,0 @@
-#PBI commands
-#Software Workaround for errata A-007662 to train PCIe2 controller in Gen2 speed
-09250100 00000400
-09250108 00002000
-#Software Workaround for errata A-008007 to reset PVR register
-09000010 0000000b
-09000014 c0000000
-09000018 81d00017
-89020400 a1000000
-091380c0 000f0000
-89020400 00000000
-#Initialize CPC1
-09010000 00200400
-09138000 00000000
-091380c0 00000100
-#Configure CPC1 as 256KB SRAM
-09010100 00000000
-09010104 fffc0007
-09010f00 081e000d
-09010000 80000000
-#Configure LAW for CPC1
-09000cd0 00000000
-09000cd4 fffc0000
-09000cd8 81000011
-#Configure alternate space
-09000010 00000000
-09000014 ff000000
-09000018 81000000
-#Configure SPI controller
-09110000 80000403
-09110020 2d170008
-09110024 00100008
-09110028 00100008
-0911002c 00100008
-#Flush PBL data
-091380c0 000FFFFF
diff --git a/board/nxp/t104xrdb/t104x_pbi_sb.cfg b/board/nxp/t104xrdb/t104x_pbi_sb.cfg
deleted file mode 100644
index 98dc8e4c240..00000000000
--- a/board/nxp/t104xrdb/t104x_pbi_sb.cfg
+++ /dev/null
@@ -1,38 +0,0 @@
-#PBI commands
-#Software Workaround for errata A-007662 to train PCIe2 controller in Gen2 speed
-09250100 00000400
-09250108 00002000
-#Software Workaround for errata A-008007 to reset PVR register
-09000010 0000000b
-09000014 c0000000
-09000018 81d00017
-89020400 a1000000
-091380c0 000f0000
-89020400 00000000
-#Initialize CPC1
-09010000 00200400
-09138000 00000000
-091380c0 00000100
-#Configure CPC1 as 256KB SRAM
-09010100 00000000
-09010104 bffc0007
-09010f00 081e000d
-09010000 80000000
-#Configure LAW for CPC1
-09000cd0 00000000
-09000cd4 bffc0000
-09000cd8 81000011
-#Configure alternate space
-09000010 00000000
-09000014 bf000000
-09000018 81000000
-#Configure SPI controller
-09110000 80000403
-09110020 2d170008
-09110024 00100008
-09110028 00100008
-0911002c 00100008
-#Flush PBL data
-091380c0 000FFFFF
-090e0200 bffd0000
-091380c0 000FFFFF
diff --git a/board/nxp/t104xrdb/t104xrdb.c b/board/nxp/t104xrdb/t104xrdb.c
deleted file mode 100644
index ef4dfef4965..00000000000
--- a/board/nxp/t104xrdb/t104xrdb.c
+++ /dev/null
@@ -1,159 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright 2013 Freescale Semiconductor, Inc.
- * Copyright 2023 NXP
- */
-
-#include <config.h>
-#include <command.h>
-#include <env.h>
-#include <fdt_support.h>
-#include <hwconfig.h>
-#include <image.h>
-#include <init.h>
-#include <log.h>
-#include <netdev.h>
-#include <asm/global_data.h>
-#include <linux/compiler.h>
-#include <asm/mmu.h>
-#include <asm/processor.h>
-#include <asm/cache.h>
-#include <asm/immap_85xx.h>
-#include <asm/fsl_fdt.h>
-#include <asm/fsl_law.h>
-#include <asm/fsl_serdes.h>
-#include <asm/fsl_liodn.h>
-#include <clock_legacy.h>
-#include <fm_eth.h>
-#include "../common/sleep.h"
-#include "t104xrdb.h"
-#include "cpld.h"
-
-DECLARE_GLOBAL_DATA_PTR;
-
-#if CONFIG_IS_ENABLED(DM_SERIAL)
-int get_serial_clock(void)
-{
-	return get_bus_freq(0) / 2;
-}
-#endif
-
-int checkboard(void)
-{
-	struct cpu_type *cpu = gd->arch.cpu;
-	u8 sw;
-
-#if defined(CONFIG_TARGET_T1042D4RDB)
-	printf("Board: %sD4RDB\n", cpu->name);
-#else
-	printf("Board: %sRDB\n", cpu->name);
-#endif
-	printf("Board rev: 0x%02x CPLD ver: 0x%02x, ",
-	       CPLD_READ(hw_ver), CPLD_READ(sw_ver));
-
-	sw = CPLD_READ(flash_ctl_status);
-	sw = ((sw & CPLD_LBMAP_MASK) >> CPLD_LBMAP_SHIFT);
-
-	printf("vBank: %d\n", sw);
-
-	return 0;
-}
-
-int board_early_init_f(void)
-{
-#if defined(CONFIG_DEEP_SLEEP)
-	if (is_warm_boot())
-		fsl_dp_disable_console();
-#endif
-
-	return 0;
-}
-
-int board_early_init_r(void)
-{
-#ifdef CFG_SYS_FLASH_BASE
-	const unsigned int flashbase = CFG_SYS_FLASH_BASE;
-	int flash_esel = find_tlb_idx((void *)flashbase, 1);
-
-	/*
-	 * Remap Boot flash region to caching-inhibited
-	 * so that flash can be erased properly.
-	 */
-
-	/* Flush d-cache and invalidate i-cache of any FLASH data */
-	flush_dcache();
-	invalidate_icache();
-
-	if (flash_esel == -1) {
-		/* very unlikely unless something is messed up */
-		puts("Error: Could not find TLB for FLASH BASE\n");
-		flash_esel = 2;	/* give our best effort to continue */
-	} else {
-		/* invalidate existing TLB entry for flash */
-		disable_tlb(flash_esel);
-	}
-
-	set_tlb(1, flashbase, CFG_SYS_FLASH_BASE_PHYS,
-		MAS3_SX|MAS3_SW|MAS3_SR, MAS2_I|MAS2_G,
-		0, flash_esel, BOOKE_PAGESZ_256M, 1);
-#endif
-
-	pci_init();
-
-	return 0;
-}
-
-int misc_init_r(void)
-{
-	ccsr_gur_t __iomem *gur = (void *)(CFG_SYS_MPC85xx_GUTS_ADDR);
-	u32 srds_s1;
-
-	srds_s1 = in_be32(&gur->rcwsr[4]) >> 24;
-
-	printf("SERDES Reference : 0x%X\n", srds_s1);
-
-	/* select SGMII*/
-	if (srds_s1 == 0x86)
-		CPLD_WRITE(misc_ctl_status, CPLD_READ(misc_ctl_status) |
-					 MISC_CTL_SG_SEL);
-
-	/* select SGMII and Aurora*/
-	if (srds_s1 == 0x8E)
-		CPLD_WRITE(misc_ctl_status, CPLD_READ(misc_ctl_status) |
-					 MISC_CTL_SG_SEL | MISC_CTL_AURORA_SEL);
-
-	return 0;
-}
-
-int ft_board_setup(void *blob, struct bd_info *bd)
-{
-	phys_addr_t base;
-	phys_size_t size;
-
-	ft_cpu_setup(blob, bd);
-
-	base = env_get_bootm_low();
-	size = env_get_bootm_size();
-
-	fdt_fixup_memory(blob, (u64)base, (u64)size);
-
-#ifdef CONFIG_PCI
-	pci_of_setup(blob, bd);
-#endif
-
-	fdt_fixup_liodn(blob);
-
-#ifdef CONFIG_HAS_FSL_DR_USB
-	fsl_fdt_fixup_dr_usb(blob, bd);
-#endif
-
-#ifdef CONFIG_SYS_DPAA_FMAN
-#ifndef CONFIG_DM_ETH
-	fdt_fixup_fman_ethernet(blob);
-#endif
-#endif
-
-	if (hwconfig("qe-tdm"))
-		fdt_del_diu(blob);
-	return 0;
-}
diff --git a/board/nxp/t104xrdb/t104xrdb.h b/board/nxp/t104xrdb/t104xrdb.h
deleted file mode 100644
index 5825e69cdb4..00000000000
--- a/board/nxp/t104xrdb/t104xrdb.h
+++ /dev/null
@@ -1,11 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright 2013 Freescale Semiconductor, Inc.
- */
-
-#ifndef __T104x_RDB_H__
-#define __T104x_RDB_H__
-
-void pci_of_setup(void *blob, struct bd_info *bd);
-
-#endif
diff --git a/board/nxp/t104xrdb/tlb.c b/board/nxp/t104xrdb/tlb.c
deleted file mode 100644
index 7b2183da8b0..00000000000
--- a/board/nxp/t104xrdb/tlb.c
+++ /dev/null
@@ -1,132 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright 2013 Freescale Semiconductor, Inc.
- */
-
-#include <config.h>
-#include <asm/mmu.h>
-#include <asm/ppc.h>
-
-struct fsl_e_tlb_entry tlb_table[] = {
-	/* TLB 0 - for temp stack in cache */
-	SET_TLB_ENTRY(0, CFG_SYS_INIT_RAM_ADDR,
-		      CFG_SYS_INIT_RAM_ADDR_PHYS,
-		      MAS3_SX|MAS3_SW|MAS3_SR, 0,
-		      0, 0, BOOKE_PAGESZ_4K, 0),
-	SET_TLB_ENTRY(0, CFG_SYS_INIT_RAM_ADDR + 4 * 1024,
-		      CFG_SYS_INIT_RAM_ADDR_PHYS + 4 * 1024,
-		      MAS3_SX|MAS3_SW|MAS3_SR, 0,
-		      0, 0, BOOKE_PAGESZ_4K, 0),
-	SET_TLB_ENTRY(0, CFG_SYS_INIT_RAM_ADDR + 8 * 1024,
-		      CFG_SYS_INIT_RAM_ADDR_PHYS + 8 * 1024,
-		      MAS3_SX|MAS3_SW|MAS3_SR, 0,
-		      0, 0, BOOKE_PAGESZ_4K, 0),
-	SET_TLB_ENTRY(0, CFG_SYS_INIT_RAM_ADDR + 12 * 1024,
-		      CFG_SYS_INIT_RAM_ADDR_PHYS + 12 * 1024,
-		      MAS3_SX|MAS3_SW|MAS3_SR, 0,
-		      0, 0, BOOKE_PAGESZ_4K, 0),
-
-	/* TLB 1 */
-	/* *I*** - Covers boot page */
-#if defined(CONFIG_SYS_RAMBOOT) && defined(CFG_SYS_INIT_L3_ADDR) && \
-	!defined(CONFIG_NXP_ESBC)
-	/*
-	 * *I*G - L3SRAM. When L3 is used as 256K SRAM, the address of the
-	 * SRAM is at 0xfffc0000, it covered the 0xfffff000.
-	 */
-	SET_TLB_ENTRY(1, CFG_SYS_INIT_L3_ADDR, CFG_SYS_INIT_L3_ADDR,
-		      MAS3_SX|MAS3_SW|MAS3_SR, MAS2_I|MAS2_G,
-		      0, 0, BOOKE_PAGESZ_256K, 1),
-
-#elif defined(CONFIG_NXP_ESBC) && defined(CONFIG_XPL_BUILD)
-	/*
-	 * *I*G - L3SRAM. When L3 is used as 256K SRAM, in case of Secure Boot
-	 * the physical address of the SRAM is at 0xbffc0000,
-	 * and virtual address is 0xfffc0000
-	 */
-
-	SET_TLB_ENTRY(1, CFG_SYS_INIT_L3_VADDR,
-		      CFG_SYS_INIT_L3_ADDR,
-		      MAS3_SX|MAS3_SW|MAS3_SR, MAS2_I|MAS2_G,
-		      0, 0, BOOKE_PAGESZ_256K, 1),
-#else
-	SET_TLB_ENTRY(1, 0xfffff000, 0xfffff000,
-		      MAS3_SX|MAS3_SW|MAS3_SR, MAS2_I|MAS2_G,
-		      0, 0, BOOKE_PAGESZ_4K, 1),
-#endif
-
-	/* *I*G* - CCSRBAR */
-	SET_TLB_ENTRY(1, CFG_SYS_CCSRBAR, CFG_SYS_CCSRBAR_PHYS,
-		      MAS3_SX|MAS3_SW|MAS3_SR, MAS2_I|MAS2_G,
-		      0, 1, BOOKE_PAGESZ_16M, 1),
-
-	/* *I*G* - Flash, localbus */
-	/* This will be changed to *I*G* after relocation to RAM. */
-	SET_TLB_ENTRY(1, CFG_SYS_FLASH_BASE, CFG_SYS_FLASH_BASE_PHYS,
-		      MAS3_SX|MAS3_SR, MAS2_W|MAS2_G,
-		      0, 2, BOOKE_PAGESZ_256M, 1),
-
-#ifndef CONFIG_XPL_BUILD
-	/* *I*G* - PCI */
-	SET_TLB_ENTRY(1, CFG_SYS_PCIE1_MEM_VIRT, CFG_SYS_PCIE1_MEM_PHYS,
-		      MAS3_SX|MAS3_SW|MAS3_SR, MAS2_I|MAS2_G,
-		      0, 3, BOOKE_PAGESZ_1G, 1),
-
-	/* *I*G* - PCI I/O */
-	SET_TLB_ENTRY(1, CFG_SYS_PCIE1_IO_VIRT, CFG_SYS_PCIE1_IO_PHYS,
-		      MAS3_SX|MAS3_SW|MAS3_SR, MAS2_I|MAS2_G,
-		      0, 4, BOOKE_PAGESZ_256K, 1),
-
-	/* Bman/Qman */
-#ifdef CFG_SYS_BMAN_MEM_PHYS
-	SET_TLB_ENTRY(1, CFG_SYS_BMAN_MEM_BASE, CFG_SYS_BMAN_MEM_PHYS,
-		      MAS3_SX|MAS3_SW|MAS3_SR, 0,
-		      0, 5, BOOKE_PAGESZ_16M, 1),
-	SET_TLB_ENTRY(1, CFG_SYS_BMAN_MEM_BASE + 0x01000000,
-		      CFG_SYS_BMAN_MEM_PHYS + 0x01000000,
-		      MAS3_SX|MAS3_SW|MAS3_SR, MAS2_I|MAS2_G,
-		      0, 6, BOOKE_PAGESZ_16M, 1),
-#endif
-#ifdef CFG_SYS_QMAN_MEM_PHYS
-	SET_TLB_ENTRY(1, CFG_SYS_QMAN_MEM_BASE, CFG_SYS_QMAN_MEM_PHYS,
-		      MAS3_SX|MAS3_SW|MAS3_SR, 0,
-		      0, 7, BOOKE_PAGESZ_16M, 1),
-	SET_TLB_ENTRY(1, CFG_SYS_QMAN_MEM_BASE + 0x01000000,
-		      CFG_SYS_QMAN_MEM_PHYS + 0x01000000,
-		      MAS3_SX|MAS3_SW|MAS3_SR, MAS2_I|MAS2_G,
-		      0, 8, BOOKE_PAGESZ_16M, 1),
-#endif
-#endif
-#ifdef CFG_SYS_DCSRBAR_PHYS
-	SET_TLB_ENTRY(1, CFG_SYS_DCSRBAR, CFG_SYS_DCSRBAR_PHYS,
-		      MAS3_SX|MAS3_SW|MAS3_SR, MAS2_I|MAS2_G,
-		      0, 9, BOOKE_PAGESZ_4M, 1),
-#endif
-#ifdef CFG_SYS_NAND_BASE
-	/*
-	 * *I*G - NAND
-	 * entry 14 and 15 has been used hard coded, they will be disabled
-	 * in cpu_init_f, so we use entry 16 for nand.
-	 */
-	SET_TLB_ENTRY(1, CFG_SYS_NAND_BASE, CFG_SYS_NAND_BASE_PHYS,
-		      MAS3_SX|MAS3_SW|MAS3_SR, MAS2_I|MAS2_G,
-		      0, 10, BOOKE_PAGESZ_64K, 1),
-#endif
-#ifdef CFG_SYS_CPLD_BASE
-	SET_TLB_ENTRY(1, CFG_SYS_CPLD_BASE, CFG_SYS_CPLD_BASE_PHYS,
-		      MAS3_SW|MAS3_SR, MAS2_I|MAS2_G,
-		      0, 11, BOOKE_PAGESZ_256K, 1),
-#endif
-
-#if defined(CONFIG_RAMBOOT_PBL) && !defined(CONFIG_XPL_BUILD)
-	SET_TLB_ENTRY(1, CFG_SYS_DDR_SDRAM_BASE, CFG_SYS_DDR_SDRAM_BASE,
-		      MAS3_SX|MAS3_SW|MAS3_SR, MAS2_M,
-		      0, 12, BOOKE_PAGESZ_1G, 1),
-	SET_TLB_ENTRY(1, CFG_SYS_DDR_SDRAM_BASE + 0x40000000,
-		      CFG_SYS_DDR_SDRAM_BASE + 0x40000000,
-		      MAS3_SX|MAS3_SW|MAS3_SR, MAS2_M,
-		      0, 13, BOOKE_PAGESZ_1G, 1)
-#endif
-};
-
-int num_tlb_entries = ARRAY_SIZE(tlb_table);
diff --git a/configs/T1042D4RDB_NAND_defconfig b/configs/T1042D4RDB_NAND_defconfig
deleted file mode 100644
index 7ec5bfd2ad0..00000000000
--- a/configs/T1042D4RDB_NAND_defconfig
+++ /dev/null
@@ -1,144 +0,0 @@
-CONFIG_PPC=y
-CONFIG_TEXT_BASE=0x30000000
-CONFIG_SPL_LIBCOMMON_SUPPORT=y
-CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_SF_DEFAULT_SPEED=10000000
-CONFIG_ENV_SIZE=0x2000
-CONFIG_ENV_OFFSET=0x180000
-CONFIG_DEFAULT_DEVICE_TREE="t1042d4rdb"
-CONFIG_SYS_MONITOR_LEN=786432
-CONFIG_SPL_SERIAL=y
-CONFIG_SPL_DRIVERS_MISC=y
-CONFIG_SPL_TEXT_BASE=0xFFFD8000
-CONFIG_SPL=y
-CONFIG_MPC85xx=y
-CONFIG_SYS_INIT_RAM_LOCK=y
-CONFIG_TARGET_T1042D4RDB=y
-CONFIG_ENABLE_36BIT_PHYS=y
-CONFIG_SYS_BOOK3E_HV=y
-CONFIG_SYS_CACHE_STASHING=y
-CONFIG_SYS_MPC85XX_NO_RESETVEC=y
-CONFIG_SPL_SYS_MPC85XX_NO_RESETVEC=y
-CONFIG_USE_UBOOTPATH=y
-CONFIG_PCIE1=y
-CONFIG_PCIE2=y
-CONFIG_PCIE3=y
-CONFIG_PCIE4=y
-CONFIG_SYS_FSL_NUM_CC_PLLS=2
-CONFIG_MP=y
-CONFIG_FIT=y
-CONFIG_FIT_VERBOSE=y
-CONFIG_RAMBOOT_PBL=y
-CONFIG_SYS_FSL_PBL_PBI="$(SRCTREE)/board/nxp/t104xrdb/t104x_pbi.cfg"
-CONFIG_SYS_FSL_PBL_RCW="$(SRCTREE)/board/nxp/t104xrdb/t1042d4_nand_rcw.cfg"
-CONFIG_BOOTDELAY=10
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
-CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="setenv bootargs root=/dev/ram rw console=$consoledev,$baudrate $othbootargs;setenv ramdiskaddr 0x02000000;setenv fdtaddr 0x00c00000;setenv loadaddr 0x1000000;bootm $loadaddr $ramdiskaddr $fdtaddr"
-CONFIG_SYS_PBSIZE=276
-CONFIG_SILENT_CONSOLE=y
-CONFIG_SYS_CONSOLE_IS_IN_ENV=y
-CONFIG_BOARD_EARLY_INIT_F=y
-CONFIG_BOARD_EARLY_INIT_R=y
-# CONFIG_SPL_FRAMEWORK is not set
-CONFIG_SPL_MAX_SIZE=0x28000
-CONFIG_SPL_PAD_TO=0x40000
-CONFIG_SPL_NAND_BOOT=y
-CONFIG_SPL_FSL_PBL=y
-CONFIG_SPL_SYS_CCSR_DO_NOT_RELOCATE=y
-CONFIG_SPL_FLUSH_IMAGE=y
-CONFIG_SPL_SKIP_RELOCATE=y
-CONFIG_SPL_GD_ADDR=0xfffc8000
-CONFIG_SPL_RELOC_STACK=0xfffd8000
-CONFIG_SPL_RELOC_MALLOC=y
-CONFIG_SPL_RELOC_MALLOC_ADDR=0xfffcb000
-CONFIG_SPL_RELOC_MALLOC_SIZE=0x7800
-CONFIG_SPL_ENV_SUPPORT=y
-CONFIG_SPL_I2C=y
-CONFIG_SPL_MPC8XXX_INIT_DDR=y
-CONFIG_SPL_NAND_SUPPORT=y
-CONFIG_HUSH_PARSER=y
-CONFIG_CMD_IMLS=y
-CONFIG_CMD_GREPENV=y
-CONFIG_CMD_DM=y
-CONFIG_CMD_I2C=y
-CONFIG_LOADS_ECHO=y
-CONFIG_SYS_LOADS_BAUD_CHANGE=y
-CONFIG_CMD_MMC=y
-CONFIG_CMD_USB=y
-CONFIG_CMD_DHCP=y
-CONFIG_CMD_MII=y
-CONFIG_CMD_PING=y
-CONFIG_CMD_EXT2=y
-CONFIG_CMD_FAT=y
-CONFIG_MTDIDS_DEFAULT="nor0=fe8000000.nor,nand0=fff800000.flash,spi0=spife110000.0"
-CONFIG_MTDPARTS_DEFAULT="mtdparts=fe8000000.nor:1m(uboot),5m(kernel),128k(dtb),96m(fs),-(user);fff800000.flash:2m(uboot),9m(kernel),128k(dtb),96m(fs),-(user);spife110000.0:2m(uboot),9m(kernel),128k(dtb),-(user)"
-CONFIG_OF_CONTROL=y
-CONFIG_ENV_OVERWRITE=y
-CONFIG_ENV_IS_IN_NAND=y
-CONFIG_USE_BOOTFILE=y
-CONFIG_BOOTFILE="uImage"
-CONFIG_USE_ETHPRIME=y
-CONFIG_ETHPRIME="FM1@DTSEC4"
-CONFIG_USE_ROOTPATH=y
-CONFIG_FSL_CAAM=y
-CONFIG_DDR_CLK_FREQ=66666666
-CONFIG_CHIP_SELECTS_PER_CTRL=2
-CONFIG_DDR_ECC=y
-CONFIG_ECC_INIT_VIA_DDRCONTROLLER=y
-CONFIG_DM_I2C=y
-CONFIG_SPL_SYS_I2C_LEGACY=y
-CONFIG_I2C_SET_DEFAULT_BUS_NUM=y
-CONFIG_SYS_I2C_FSL=y
-CONFIG_SYS_FSL_I2C_OFFSET=0x118000
-CONFIG_SYS_FSL_HAS_I2C2_OFFSET=y
-CONFIG_SYS_FSL_I2C2_OFFSET=0x118100
-CONFIG_SYS_FSL_HAS_I2C3_OFFSET=y
-CONFIG_SYS_FSL_I2C3_OFFSET=0x119000
-CONFIG_SYS_FSL_HAS_I2C4_OFFSET=y
-CONFIG_SYS_FSL_I2C4_OFFSET=0x119100
-CONFIG_FSL_ESDHC=y
-CONFIG_MTD=y
-CONFIG_MTD_NOR_FLASH=y
-CONFIG_FLASH_CFI_DRIVER=y
-CONFIG_SYS_FLASH_USE_BUFFER_WRITE=y
-CONFIG_SYS_FLASH_EMPTY_INFO=y
-CONFIG_FLASH_CFI_MTD=y
-CONFIG_SYS_FLASH_CFI=y
-CONFIG_SYS_FLASH_QUIET_TEST=y
-CONFIG_SYS_MAX_FLASH_SECT=1024
-CONFIG_SYS_MAX_FLASH_BANKS=2
-CONFIG_MTD_RAW_NAND=y
-CONFIG_NAND_FSL_IFC=y
-CONFIG_SYS_NAND_ONFI_DETECTION=y
-CONFIG_SYS_NAND_U_BOOT_LOCATIONS=y
-CONFIG_SYS_NAND_U_BOOT_OFFS=0x40000
-CONFIG_DM_SPI_FLASH=y
-CONFIG_SPI_FLASH_STMICRO=y
-CONFIG_DM_MDIO=y
-CONFIG_PHY_GIGE=y
-CONFIG_E1000=y
-CONFIG_FMAN_ENET=y
-CONFIG_SYS_FMAN_FW_ADDR=0x280000
-CONFIG_MII=y
-CONFIG_PHYLIB=y
-CONFIG_PHY_REALTEK=y
-CONFIG_PHY_VITESSE=y
-CONFIG_PCIE_FSL=y
-CONFIG_U_QE=y
-CONFIG_SYS_QE_FW_ADDR=0x380000
-CONFIG_SYS_QE_FMAN_FW_IN_NAND=y
-CONFIG_DM_RTC=y
-CONFIG_RTC_DS1337=y
-CONFIG_DM_SERIAL=y
-CONFIG_SPL_SYS_NS16550_SERIAL=y
-CONFIG_SPI=y
-CONFIG_DM_SPI=y
-CONFIG_FSL_ESPI=y
-CONFIG_USB=y
-CONFIG_USB_EHCI_FSL=y
-CONFIG_USB_MAX_CONTROLLER_COUNT=2
-CONFIG_USB_STORAGE=y
-CONFIG_ADDR_MAP=y
-CONFIG_SYS_NUM_ADDR_MAP=64
diff --git a/configs/T1042D4RDB_SDCARD_defconfig b/configs/T1042D4RDB_SDCARD_defconfig
deleted file mode 100644
index c418c3064d4..00000000000
--- a/configs/T1042D4RDB_SDCARD_defconfig
+++ /dev/null
@@ -1,138 +0,0 @@
-CONFIG_PPC=y
-CONFIG_TEXT_BASE=0x30000000
-CONFIG_SPL_LIBCOMMON_SUPPORT=y
-CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_SF_DEFAULT_SPEED=10000000
-CONFIG_ENV_SIZE=0x2000
-CONFIG_ENV_OFFSET=0x100000
-CONFIG_DEFAULT_DEVICE_TREE="t1042d4rdb"
-CONFIG_SYS_MONITOR_LEN=786432
-CONFIG_SPL_MMC=y
-CONFIG_SPL_SERIAL=y
-CONFIG_SPL_DRIVERS_MISC=y
-CONFIG_SPL_TEXT_BASE=0xFFFD8000
-CONFIG_SPL=y
-CONFIG_MPC85xx=y
-CONFIG_SYS_INIT_RAM_LOCK=y
-CONFIG_TARGET_T1042D4RDB=y
-CONFIG_ENABLE_36BIT_PHYS=y
-CONFIG_SYS_BOOK3E_HV=y
-CONFIG_SYS_CACHE_STASHING=y
-CONFIG_SYS_MPC85XX_NO_RESETVEC=y
-CONFIG_USE_UBOOTPATH=y
-CONFIG_PCIE1=y
-CONFIG_PCIE2=y
-CONFIG_PCIE3=y
-CONFIG_PCIE4=y
-CONFIG_SYS_FSL_NUM_CC_PLLS=2
-CONFIG_MP=y
-CONFIG_FIT=y
-CONFIG_FIT_VERBOSE=y
-CONFIG_RAMBOOT_PBL=y
-CONFIG_SYS_FSL_PBL_PBI="$(SRCTREE)/board/nxp/t104xrdb/t104x_pbi.cfg"
-CONFIG_SYS_FSL_PBL_RCW="$(SRCTREE)/board/nxp/t104xrdb/t1042d4_sd_rcw.cfg"
-CONFIG_BOOTDELAY=10
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
-CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="setenv bootargs root=/dev/ram rw console=$consoledev,$baudrate $othbootargs;setenv ramdiskaddr 0x02000000;setenv fdtaddr 0x00c00000;setenv loadaddr 0x1000000;bootm $loadaddr $ramdiskaddr $fdtaddr"
-CONFIG_SYS_PBSIZE=276
-CONFIG_SILENT_CONSOLE=y
-CONFIG_SYS_CONSOLE_IS_IN_ENV=y
-CONFIG_BOARD_EARLY_INIT_F=y
-CONFIG_BOARD_EARLY_INIT_R=y
-# CONFIG_SPL_FRAMEWORK is not set
-CONFIG_SPL_MAX_SIZE=0x28000
-CONFIG_SPL_PAD_TO=0x40000
-CONFIG_SPL_MMC_BOOT=y
-CONFIG_SPL_FSL_PBL=y
-CONFIG_SPL_SYS_CCSR_DO_NOT_RELOCATE=y
-CONFIG_SPL_FLUSH_IMAGE=y
-CONFIG_SPL_SKIP_RELOCATE=y
-CONFIG_SPL_GD_ADDR=0xfffc8000
-CONFIG_SPL_RELOC_STACK=0xfffd8000
-CONFIG_SPL_RELOC_MALLOC=y
-CONFIG_SPL_RELOC_MALLOC_ADDR=0xfffcb000
-CONFIG_SPL_RELOC_MALLOC_SIZE=0x7800
-CONFIG_SPL_ENV_SUPPORT=y
-CONFIG_SPL_I2C=y
-CONFIG_SPL_MPC8XXX_INIT_DDR=y
-CONFIG_HUSH_PARSER=y
-CONFIG_CMD_IMLS=y
-CONFIG_CMD_GREPENV=y
-CONFIG_CMD_DM=y
-CONFIG_CMD_I2C=y
-CONFIG_LOADS_ECHO=y
-CONFIG_SYS_LOADS_BAUD_CHANGE=y
-CONFIG_CMD_MMC=y
-CONFIG_CMD_USB=y
-CONFIG_CMD_DHCP=y
-CONFIG_CMD_MII=y
-CONFIG_CMD_PING=y
-CONFIG_CMD_EXT2=y
-CONFIG_CMD_FAT=y
-CONFIG_MTDIDS_DEFAULT="nor0=fe8000000.nor,nand0=fff800000.flash,spi0=spife110000.0"
-CONFIG_MTDPARTS_DEFAULT="mtdparts=fe8000000.nor:1m(uboot),5m(kernel),128k(dtb),96m(fs),-(user);fff800000.flash:2m(uboot),9m(kernel),128k(dtb),96m(fs),-(user);spife110000.0:2m(uboot),9m(kernel),128k(dtb),-(user)"
-CONFIG_OF_CONTROL=y
-CONFIG_ENV_OVERWRITE=y
-CONFIG_ENV_IS_IN_MMC=y
-CONFIG_USE_BOOTFILE=y
-CONFIG_BOOTFILE="uImage"
-CONFIG_USE_ETHPRIME=y
-CONFIG_ETHPRIME="FM1@DTSEC4"
-CONFIG_USE_ROOTPATH=y
-CONFIG_FSL_CAAM=y
-CONFIG_DDR_CLK_FREQ=66666666
-CONFIG_CHIP_SELECTS_PER_CTRL=2
-CONFIG_DDR_ECC=y
-CONFIG_ECC_INIT_VIA_DDRCONTROLLER=y
-CONFIG_DM_I2C=y
-CONFIG_SPL_SYS_I2C_LEGACY=y
-CONFIG_I2C_SET_DEFAULT_BUS_NUM=y
-CONFIG_SYS_I2C_FSL=y
-CONFIG_SYS_FSL_I2C_OFFSET=0x118000
-CONFIG_SYS_FSL_HAS_I2C2_OFFSET=y
-CONFIG_SYS_FSL_I2C2_OFFSET=0x118100
-CONFIG_SYS_FSL_HAS_I2C3_OFFSET=y
-CONFIG_SYS_FSL_I2C3_OFFSET=0x119000
-CONFIG_SYS_FSL_HAS_I2C4_OFFSET=y
-CONFIG_SYS_FSL_I2C4_OFFSET=0x119100
-CONFIG_FSL_ESDHC=y
-CONFIG_MTD=y
-CONFIG_MTD_NOR_FLASH=y
-CONFIG_FLASH_CFI_DRIVER=y
-CONFIG_SYS_FLASH_USE_BUFFER_WRITE=y
-CONFIG_SYS_FLASH_EMPTY_INFO=y
-CONFIG_FLASH_CFI_MTD=y
-CONFIG_SYS_FLASH_CFI=y
-CONFIG_SYS_FLASH_QUIET_TEST=y
-CONFIG_SYS_MAX_FLASH_SECT=1024
-CONFIG_SYS_MAX_FLASH_BANKS=2
-CONFIG_DM_SPI_FLASH=y
-CONFIG_SPI_FLASH_STMICRO=y
-CONFIG_DM_MDIO=y
-CONFIG_PHY_GIGE=y
-CONFIG_E1000=y
-CONFIG_FMAN_ENET=y
-CONFIG_SYS_FMAN_FW_ADDR=0x10400
-CONFIG_MII=y
-CONFIG_PHYLIB=y
-CONFIG_PHY_REALTEK=y
-CONFIG_PHY_VITESSE=y
-CONFIG_PCIE_FSL=y
-CONFIG_U_QE=y
-CONFIG_SYS_QE_FW_ADDR=0x124000
-CONFIG_SYS_QE_FMAN_FW_IN_MMC=y
-CONFIG_DM_RTC=y
-CONFIG_RTC_DS1337=y
-CONFIG_DM_SERIAL=y
-CONFIG_SPL_SYS_NS16550_SERIAL=y
-CONFIG_SPI=y
-CONFIG_DM_SPI=y
-CONFIG_FSL_ESPI=y
-CONFIG_USB=y
-CONFIG_USB_EHCI_FSL=y
-CONFIG_USB_MAX_CONTROLLER_COUNT=2
-CONFIG_USB_STORAGE=y
-CONFIG_ADDR_MAP=y
-CONFIG_SYS_NUM_ADDR_MAP=64
diff --git a/configs/T1042D4RDB_SPIFLASH_defconfig b/configs/T1042D4RDB_SPIFLASH_defconfig
deleted file mode 100644
index f758cd9aaa5..00000000000
--- a/configs/T1042D4RDB_SPIFLASH_defconfig
+++ /dev/null
@@ -1,141 +0,0 @@
-CONFIG_PPC=y
-CONFIG_TEXT_BASE=0x30000000
-CONFIG_SPL_LIBCOMMON_SUPPORT=y
-CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_SF_DEFAULT_SPEED=10000000
-CONFIG_ENV_SIZE=0x2000
-CONFIG_ENV_OFFSET=0x100000
-CONFIG_ENV_SECT_SIZE=0x10000
-CONFIG_DEFAULT_DEVICE_TREE="t1042d4rdb"
-CONFIG_SYS_MONITOR_LEN=786432
-CONFIG_SPL_SERIAL=y
-CONFIG_SPL_DRIVERS_MISC=y
-CONFIG_SPL_TEXT_BASE=0xFFFD8000
-CONFIG_SPL=y
-CONFIG_SPL_SPI_FLASH_SUPPORT=y
-CONFIG_SPL_SPI=y
-CONFIG_MPC85xx=y
-CONFIG_SYS_INIT_RAM_LOCK=y
-CONFIG_TARGET_T1042D4RDB=y
-CONFIG_ENABLE_36BIT_PHYS=y
-CONFIG_SYS_BOOK3E_HV=y
-CONFIG_SYS_CACHE_STASHING=y
-CONFIG_SYS_MPC85XX_NO_RESETVEC=y
-CONFIG_USE_UBOOTPATH=y
-CONFIG_PCIE1=y
-CONFIG_PCIE2=y
-CONFIG_PCIE3=y
-CONFIG_PCIE4=y
-CONFIG_SYS_FSL_NUM_CC_PLLS=2
-CONFIG_MP=y
-CONFIG_FIT=y
-CONFIG_FIT_VERBOSE=y
-CONFIG_RAMBOOT_PBL=y
-CONFIG_SPIFLASH=y
-CONFIG_SYS_FSL_PBL_PBI="$(SRCTREE)/board/nxp/t104xrdb/t104x_pbi.cfg"
-CONFIG_SYS_FSL_PBL_RCW="$(SRCTREE)/board/nxp/t104xrdb/t1042d4_spi_rcw.cfg"
-CONFIG_BOOTDELAY=10
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
-CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="setenv bootargs root=/dev/ram rw console=$consoledev,$baudrate $othbootargs;setenv ramdiskaddr 0x02000000;setenv fdtaddr 0x00c00000;setenv loadaddr 0x1000000;bootm $loadaddr $ramdiskaddr $fdtaddr"
-CONFIG_SYS_PBSIZE=276
-CONFIG_SILENT_CONSOLE=y
-CONFIG_SYS_CONSOLE_IS_IN_ENV=y
-CONFIG_BOARD_EARLY_INIT_F=y
-CONFIG_BOARD_EARLY_INIT_R=y
-# CONFIG_SPL_FRAMEWORK is not set
-CONFIG_SPL_MAX_SIZE=0x28000
-CONFIG_SPL_PAD_TO=0x40000
-CONFIG_SPL_SPI_BOOT=y
-CONFIG_SPL_FSL_PBL=y
-CONFIG_SPL_SYS_CCSR_DO_NOT_RELOCATE=y
-CONFIG_SPL_FLUSH_IMAGE=y
-CONFIG_SPL_SKIP_RELOCATE=y
-CONFIG_SPL_GD_ADDR=0xfffc8000
-CONFIG_SPL_RELOC_STACK=0xfffd8000
-CONFIG_SPL_RELOC_MALLOC=y
-CONFIG_SPL_RELOC_MALLOC_ADDR=0xfffcb000
-CONFIG_SPL_RELOC_MALLOC_SIZE=0x7800
-CONFIG_SPL_ENV_SUPPORT=y
-CONFIG_SPL_I2C=y
-CONFIG_SPL_MPC8XXX_INIT_DDR=y
-CONFIG_HUSH_PARSER=y
-CONFIG_CMD_IMLS=y
-CONFIG_CMD_GREPENV=y
-CONFIG_CMD_DM=y
-CONFIG_CMD_I2C=y
-CONFIG_LOADS_ECHO=y
-CONFIG_SYS_LOADS_BAUD_CHANGE=y
-CONFIG_CMD_MMC=y
-CONFIG_CMD_USB=y
-CONFIG_CMD_DHCP=y
-CONFIG_CMD_MII=y
-CONFIG_CMD_PING=y
-CONFIG_CMD_EXT2=y
-CONFIG_CMD_FAT=y
-CONFIG_MTDIDS_DEFAULT="nor0=fe8000000.nor,nand0=fff800000.flash,spi0=spife110000.0"
-CONFIG_MTDPARTS_DEFAULT="mtdparts=fe8000000.nor:1m(uboot),5m(kernel),128k(dtb),96m(fs),-(user);fff800000.flash:2m(uboot),9m(kernel),128k(dtb),96m(fs),-(user);spife110000.0:2m(uboot),9m(kernel),128k(dtb),-(user)"
-CONFIG_OF_CONTROL=y
-CONFIG_ENV_OVERWRITE=y
-CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_USE_BOOTFILE=y
-CONFIG_BOOTFILE="uImage"
-CONFIG_USE_ETHPRIME=y
-CONFIG_ETHPRIME="FM1@DTSEC4"
-CONFIG_USE_ROOTPATH=y
-CONFIG_FSL_CAAM=y
-CONFIG_DDR_CLK_FREQ=66666666
-CONFIG_CHIP_SELECTS_PER_CTRL=2
-CONFIG_DDR_ECC=y
-CONFIG_ECC_INIT_VIA_DDRCONTROLLER=y
-CONFIG_DM_I2C=y
-CONFIG_SPL_SYS_I2C_LEGACY=y
-CONFIG_I2C_SET_DEFAULT_BUS_NUM=y
-CONFIG_SYS_I2C_FSL=y
-CONFIG_SYS_FSL_I2C_OFFSET=0x118000
-CONFIG_SYS_FSL_HAS_I2C2_OFFSET=y
-CONFIG_SYS_FSL_I2C2_OFFSET=0x118100
-CONFIG_SYS_FSL_HAS_I2C3_OFFSET=y
-CONFIG_SYS_FSL_I2C3_OFFSET=0x119000
-CONFIG_SYS_FSL_HAS_I2C4_OFFSET=y
-CONFIG_SYS_FSL_I2C4_OFFSET=0x119100
-CONFIG_FSL_ESDHC=y
-CONFIG_MTD=y
-CONFIG_MTD_NOR_FLASH=y
-CONFIG_FLASH_CFI_DRIVER=y
-CONFIG_SYS_FLASH_USE_BUFFER_WRITE=y
-CONFIG_SYS_FLASH_EMPTY_INFO=y
-CONFIG_FLASH_CFI_MTD=y
-CONFIG_SYS_FLASH_CFI=y
-CONFIG_SYS_FLASH_QUIET_TEST=y
-CONFIG_SYS_MAX_FLASH_SECT=1024
-CONFIG_SYS_MAX_FLASH_BANKS=2
-CONFIG_DM_SPI_FLASH=y
-CONFIG_SPI_FLASH_STMICRO=y
-CONFIG_DM_MDIO=y
-CONFIG_PHY_GIGE=y
-CONFIG_E1000=y
-CONFIG_FMAN_ENET=y
-CONFIG_SYS_FMAN_FW_ADDR=0x110000
-CONFIG_MII=y
-CONFIG_PHYLIB=y
-CONFIG_PHY_REALTEK=y
-CONFIG_PHY_VITESSE=y
-CONFIG_PCIE_FSL=y
-CONFIG_U_QE=y
-CONFIG_SYS_QE_FW_ADDR=0x130000
-CONFIG_SYS_QE_FMAN_FW_IN_SPIFLASH=y
-CONFIG_DM_RTC=y
-CONFIG_RTC_DS1337=y
-CONFIG_DM_SERIAL=y
-CONFIG_SPL_SYS_NS16550_SERIAL=y
-CONFIG_SPI=y
-CONFIG_DM_SPI=y
-CONFIG_FSL_ESPI=y
-CONFIG_USB=y
-CONFIG_USB_EHCI_FSL=y
-CONFIG_USB_MAX_CONTROLLER_COUNT=2
-CONFIG_USB_STORAGE=y
-CONFIG_ADDR_MAP=y
-CONFIG_SYS_NUM_ADDR_MAP=64
diff --git a/configs/T1042D4RDB_defconfig b/configs/T1042D4RDB_defconfig
deleted file mode 100644
index 6e53e581c81..00000000000
--- a/configs/T1042D4RDB_defconfig
+++ /dev/null
@@ -1,114 +0,0 @@
-CONFIG_PPC=y
-CONFIG_TEXT_BASE=0xEFF40000
-CONFIG_SF_DEFAULT_SPEED=10000000
-CONFIG_ENV_SIZE=0x2000
-CONFIG_ENV_SECT_SIZE=0x20000
-CONFIG_DEFAULT_DEVICE_TREE="t1042d4rdb"
-CONFIG_SYS_MONITOR_LEN=786432
-CONFIG_ENV_ADDR=0xEFF20000
-CONFIG_MPC85xx=y
-CONFIG_SYS_INIT_RAM_LOCK=y
-CONFIG_TARGET_T1042D4RDB=y
-CONFIG_MPC85XX_HAVE_RESET_VECTOR=y
-CONFIG_ENABLE_36BIT_PHYS=y
-CONFIG_SYS_BOOK3E_HV=y
-CONFIG_SYS_CACHE_STASHING=y
-CONFIG_USE_UBOOTPATH=y
-CONFIG_PCIE1=y
-CONFIG_PCIE2=y
-CONFIG_PCIE3=y
-CONFIG_PCIE4=y
-CONFIG_SYS_FSL_NUM_CC_PLLS=2
-CONFIG_MP=y
-CONFIG_FIT=y
-CONFIG_FIT_VERBOSE=y
-CONFIG_BOOTDELAY=10
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
-CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="setenv bootargs root=/dev/ram rw console=$consoledev,$baudrate $othbootargs;setenv ramdiskaddr 0x02000000;setenv fdtaddr 0x00c00000;setenv loadaddr 0x1000000;bootm $loadaddr $ramdiskaddr $fdtaddr"
-CONFIG_SYS_PBSIZE=276
-CONFIG_SILENT_CONSOLE=y
-CONFIG_SYS_CONSOLE_IS_IN_ENV=y
-CONFIG_BOARD_EARLY_INIT_F=y
-CONFIG_BOARD_EARLY_INIT_R=y
-CONFIG_HUSH_PARSER=y
-CONFIG_CMD_IMLS=y
-CONFIG_CMD_GREPENV=y
-CONFIG_CMD_DM=y
-CONFIG_CMD_I2C=y
-CONFIG_LOADS_ECHO=y
-CONFIG_SYS_LOADS_BAUD_CHANGE=y
-CONFIG_CMD_MMC=y
-CONFIG_CMD_USB=y
-CONFIG_CMD_DHCP=y
-CONFIG_CMD_MII=y
-CONFIG_CMD_PING=y
-CONFIG_CMD_EXT2=y
-CONFIG_CMD_FAT=y
-CONFIG_MTDIDS_DEFAULT="nor0=fe8000000.nor,nand0=fff800000.flash,spi0=spife110000.0"
-CONFIG_MTDPARTS_DEFAULT="mtdparts=fe8000000.nor:1m(uboot),5m(kernel),128k(dtb),96m(fs),-(user);fff800000.flash:2m(uboot),9m(kernel),128k(dtb),96m(fs),-(user);spife110000.0:2m(uboot),9m(kernel),128k(dtb),-(user)"
-CONFIG_OF_CONTROL=y
-CONFIG_ENV_OVERWRITE=y
-CONFIG_ENV_IS_IN_FLASH=y
-CONFIG_USE_BOOTFILE=y
-CONFIG_BOOTFILE="uImage"
-CONFIG_USE_ETHPRIME=y
-CONFIG_ETHPRIME="FM1@DTSEC4"
-CONFIG_USE_ROOTPATH=y
-CONFIG_FSL_CAAM=y
-CONFIG_DDR_CLK_FREQ=66666666
-CONFIG_CHIP_SELECTS_PER_CTRL=2
-CONFIG_DDR_ECC=y
-CONFIG_ECC_INIT_VIA_DDRCONTROLLER=y
-CONFIG_DM_I2C=y
-CONFIG_SPL_SYS_I2C_LEGACY=y
-CONFIG_I2C_SET_DEFAULT_BUS_NUM=y
-CONFIG_SYS_I2C_FSL=y
-CONFIG_SYS_FSL_I2C_OFFSET=0x118000
-CONFIG_SYS_FSL_HAS_I2C2_OFFSET=y
-CONFIG_SYS_FSL_I2C2_OFFSET=0x118100
-CONFIG_SYS_FSL_HAS_I2C3_OFFSET=y
-CONFIG_SYS_FSL_I2C3_OFFSET=0x119000
-CONFIG_SYS_FSL_HAS_I2C4_OFFSET=y
-CONFIG_SYS_FSL_I2C4_OFFSET=0x119100
-CONFIG_FSL_ESDHC=y
-CONFIG_MTD=y
-CONFIG_MTD_NOR_FLASH=y
-CONFIG_FLASH_CFI_DRIVER=y
-CONFIG_SYS_FLASH_USE_BUFFER_WRITE=y
-CONFIG_SYS_FLASH_EMPTY_INFO=y
-CONFIG_FLASH_CFI_MTD=y
-CONFIG_SYS_FLASH_CFI=y
-CONFIG_SYS_FLASH_QUIET_TEST=y
-CONFIG_SYS_MAX_FLASH_SECT=1024
-CONFIG_SYS_MAX_FLASH_BANKS=2
-CONFIG_DM_SPI_FLASH=y
-CONFIG_SPI_FLASH_STMICRO=y
-CONFIG_DM_MDIO=y
-CONFIG_PHY_GIGE=y
-CONFIG_E1000=y
-CONFIG_FMAN_ENET=y
-CONFIG_SYS_FMAN_FW_ADDR=0xEFF00000
-CONFIG_MII=y
-CONFIG_PHYLIB=y
-CONFIG_PHY_REALTEK=y
-CONFIG_PHY_VITESSE=y
-CONFIG_PCIE_FSL=y
-CONFIG_U_QE=y
-CONFIG_SYS_QE_FW_ADDR=0xEFF10000
-CONFIG_SYS_QE_FMAN_FW_IN_NOR=y
-CONFIG_DM_RTC=y
-CONFIG_RTC_DS1337=y
-CONFIG_SPECIFY_CONSOLE_INDEX=y
-CONFIG_DM_SERIAL=y
-CONFIG_SYS_NS16550=y
-CONFIG_SPI=y
-CONFIG_DM_SPI=y
-CONFIG_FSL_ESPI=y
-CONFIG_USB=y
-CONFIG_USB_EHCI_FSL=y
-CONFIG_USB_MAX_CONTROLLER_COUNT=2
-CONFIG_USB_STORAGE=y
-CONFIG_ADDR_MAP=y
-CONFIG_SYS_NUM_ADDR_MAP=64
diff --git a/include/configs/T104xRDB.h b/include/configs/T104xRDB.h
deleted file mode 100644
index 01db298f38e..00000000000
--- a/include/configs/T104xRDB.h
+++ /dev/null
@@ -1,397 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright 2014 Freescale Semiconductor, Inc.
- * Copyright 2020-2023 NXP
- */
-
-#ifndef __CONFIG_H
-#define __CONFIG_H
-
-#include <linux/stringify.h>
-
-/*
- * T104x RDB board configuration file
- */
-#include <asm/config_mpc85xx.h>
-
-#ifdef CONFIG_RAMBOOT_PBL
-#define RESET_VECTOR_OFFSET		0x27FFC
-#define BOOT_PAGE_OFFSET		0x27000
-
-#ifdef CONFIG_MTD_RAW_NAND
-#ifdef CONFIG_NXP_ESBC
-#define CFG_SYS_NAND_U_BOOT_SIZE	((768 << 10) + (16 << 10))
-#else
-#define CFG_SYS_NAND_U_BOOT_SIZE	(768 << 10)
-#endif
-#define CFG_SYS_NAND_U_BOOT_DST	0x30000000
-#define CFG_SYS_NAND_U_BOOT_START	0x30000000
-#endif
-
-#ifdef CONFIG_SPIFLASH
-#define	CFG_RESET_VECTOR_ADDRESS		0x30000FFC
-#define CFG_SYS_SPI_FLASH_U_BOOT_SIZE	(768 << 10)
-#define CFG_SYS_SPI_FLASH_U_BOOT_DST		(0x30000000)
-#define CFG_SYS_SPI_FLASH_U_BOOT_START	(0x30000000)
-#define CFG_SYS_SPI_FLASH_U_BOOT_OFFS	(256 << 10)
-#endif
-
-#ifdef CONFIG_SDCARD
-#define	CFG_RESET_VECTOR_ADDRESS		0x30000FFC
-#define CFG_SYS_MMC_U_BOOT_SIZE	(768 << 10)
-#define CFG_SYS_MMC_U_BOOT_DST	(0x30000000)
-#define CFG_SYS_MMC_U_BOOT_START	(0x30000000)
-#define CFG_SYS_MMC_U_BOOT_OFFS	(260 << 10)
-#endif
-
-#endif
-
-/* High Level Configuration Options */
-
-#ifndef CFG_RESET_VECTOR_ADDRESS
-#define CFG_RESET_VECTOR_ADDRESS	0xeffffffc
-#endif
-
-#define CFG_SYS_NUM_CPC		CONFIG_SYS_NUM_DDR_CTLRS
-
-/*
- * These can be toggled for performance analysis, otherwise use default.
- */
-#define CFG_SYS_INIT_L2CSR0		L2CSR0_L2E
-
-/*
- *  Config the L3 Cache as L3 SRAM
- */
-#define CFG_SYS_INIT_L3_ADDR		0xFFFC0000
-/*
- * For Secure Boot CFG_SYS_INIT_L3_ADDR will be redefined and hence
- * Physical address (CFG_SYS_INIT_L3_ADDR) and virtual address
- * (CFG_SYS_INIT_L3_VADDR) will be different.
- */
-#define CFG_SYS_INIT_L3_VADDR	0xFFFC0000
-#define SPL_ENV_ADDR			(CONFIG_SPL_GD_ADDR + 4 * 1024)
-
-#define CFG_SYS_DCSRBAR		0xf0000000
-#define CFG_SYS_DCSRBAR_PHYS		0xf00000000ull
-
-/*
- * DDR Setup
- */
-#define CFG_SYS_DDR_SDRAM_BASE	0x00000000
-#define CFG_SYS_SDRAM_BASE		CFG_SYS_DDR_SDRAM_BASE
-
-#define SPD_EEPROM_ADDRESS	0x51
-
-#define CFG_SYS_SDRAM_SIZE	4096	/* for fixed parameter use */
-
-/*
- * IFC Definitions
- */
-#define CFG_SYS_FLASH_BASE	0xe8000000
-#define CFG_SYS_FLASH_BASE_PHYS	(0xf00000000ull | CFG_SYS_FLASH_BASE)
-
-#define CFG_SYS_NOR_CSPR_EXT	(0xf)
-#define CFG_SYS_NOR_CSPR	(CSPR_PHYS_ADDR(CFG_SYS_FLASH_BASE) | \
-				CSPR_PORT_SIZE_16 | \
-				CSPR_MSEL_NOR | \
-				CSPR_V)
-#define CFG_SYS_NOR_AMASK	IFC_AMASK(128*1024*1024)
-
-/*
- * TDM Definition
- */
-#define T1040_TDM_QUIRK_CCSR_BASE	0xfe000000
-
-/* NOR Flash Timing Params */
-#define CFG_SYS_NOR_CSOR	CSOR_NAND_TRHZ_80
-#define CFG_SYS_NOR_FTIM0	(FTIM0_NOR_TACSE(0x4) | \
-				FTIM0_NOR_TEADC(0x5) | \
-				FTIM0_NOR_TEAHC(0x5))
-#define CFG_SYS_NOR_FTIM1	(FTIM1_NOR_TACO(0x35) | \
-				FTIM1_NOR_TRAD_NOR(0x1A) |\
-				FTIM1_NOR_TSEQRAD_NOR(0x13))
-#define CFG_SYS_NOR_FTIM2	(FTIM2_NOR_TCS(0x4) | \
-				FTIM2_NOR_TCH(0x4) | \
-				FTIM2_NOR_TWPH(0x0E) | \
-				FTIM2_NOR_TWP(0x1c))
-#define CFG_SYS_NOR_FTIM3	0x0
-
-#define CFG_SYS_FLASH_BANKS_LIST	{CFG_SYS_FLASH_BASE_PHYS}
-
-/* CPLD on IFC */
-#define CPLD_LBMAP_MASK			0x3F
-#define CPLD_BANK_SEL_MASK		0x07
-#define CPLD_BANK_OVERRIDE		0x40
-#define CPLD_LBMAP_ALTBANK		0x44 /* BANK OR | BANK 4 */
-#define CPLD_LBMAP_DFLTBANK		0x40 /* BANK OR | BANK0 */
-#define CPLD_LBMAP_RESET		0xFF
-#define CPLD_LBMAP_SHIFT		0x03
-
-#if defined(CONFIG_TARGET_T1042D4RDB)
-#define CPLD_DIU_SEL_DFP		0xc0
-#endif
-
-#define CFG_SYS_CPLD_BASE	0xffdf0000
-#define CFG_SYS_CPLD_BASE_PHYS	(0xf00000000ull | CFG_SYS_CPLD_BASE)
-#define CFG_SYS_CSPR2_EXT	(0xf)
-#define CFG_SYS_CSPR2	(CSPR_PHYS_ADDR(CFG_SYS_CPLD_BASE_PHYS) \
-				| CSPR_PORT_SIZE_8 \
-				| CSPR_MSEL_GPCM \
-				| CSPR_V)
-#define CFG_SYS_AMASK2	IFC_AMASK(64*1024)
-#define CFG_SYS_CSOR2	0x0
-/* CPLD Timing parameters for IFC CS2 */
-#define CFG_SYS_CS2_FTIM0		(FTIM0_GPCM_TACSE(0x0e) | \
-					FTIM0_GPCM_TEADC(0x0e) | \
-					FTIM0_GPCM_TEAHC(0x0e))
-#define CFG_SYS_CS2_FTIM1		(FTIM1_GPCM_TACO(0x0e) | \
-					FTIM1_GPCM_TRAD(0x1f))
-#define CFG_SYS_CS2_FTIM2		(FTIM2_GPCM_TCS(0x0e) | \
-					FTIM2_GPCM_TCH(0x8) | \
-					FTIM2_GPCM_TWP(0x1f))
-#define CFG_SYS_CS2_FTIM3		0x0
-
-/* NAND Flash on IFC */
-#define CFG_SYS_NAND_BASE		0xff800000
-#define CFG_SYS_NAND_BASE_PHYS	(0xf00000000ull | CFG_SYS_NAND_BASE)
-
-#define CFG_SYS_NAND_CSPR_EXT	(0xf)
-#define CFG_SYS_NAND_CSPR	(CSPR_PHYS_ADDR(CFG_SYS_NAND_BASE_PHYS) \
-				| CSPR_PORT_SIZE_8 /* Port Size = 8 bit */ \
-				| CSPR_MSEL_NAND	/* MSEL = NAND */ \
-				| CSPR_V)
-#define CFG_SYS_NAND_AMASK	IFC_AMASK(64*1024)
-
-#define CFG_SYS_NAND_CSOR    (CSOR_NAND_ECC_ENC_EN   /* ECC on encode */ \
-				| CSOR_NAND_ECC_DEC_EN  /* ECC on decode */ \
-				| CSOR_NAND_ECC_MODE_4  /* 4-bit ECC */ \
-				| CSOR_NAND_RAL_3	/* RAL = 3Byes */ \
-				| CSOR_NAND_PGS_4K	/* Page Size = 4K */ \
-				| CSOR_NAND_SPRZ_224/* Spare size = 224 */ \
-				| CSOR_NAND_PB(64))	/*Pages Per Block = 64*/
-
-/* ONFI NAND Flash mode0 Timing Params */
-#define CFG_SYS_NAND_FTIM0		(FTIM0_NAND_TCCST(0x07) | \
-					FTIM0_NAND_TWP(0x18)   | \
-					FTIM0_NAND_TWCHT(0x07) | \
-					FTIM0_NAND_TWH(0x0a))
-#define CFG_SYS_NAND_FTIM1		(FTIM1_NAND_TADLE(0x32) | \
-					FTIM1_NAND_TWBE(0x39)  | \
-					FTIM1_NAND_TRR(0x0e)   | \
-					FTIM1_NAND_TRP(0x18))
-#define CFG_SYS_NAND_FTIM2		(FTIM2_NAND_TRAD(0x0f) | \
-					FTIM2_NAND_TREH(0x0a) | \
-					FTIM2_NAND_TWHRE(0x1e))
-#define CFG_SYS_NAND_FTIM3		0x0
-
-#define CFG_SYS_NAND_BASE_LIST	{ CFG_SYS_NAND_BASE }
-
-#if defined(CONFIG_MTD_RAW_NAND)
-#define CFG_SYS_CSPR0_EXT		CFG_SYS_NAND_CSPR_EXT
-#define CFG_SYS_CSPR0		CFG_SYS_NAND_CSPR
-#define CFG_SYS_AMASK0		CFG_SYS_NAND_AMASK
-#define CFG_SYS_CSOR0		CFG_SYS_NAND_CSOR
-#define CFG_SYS_CS0_FTIM0		CFG_SYS_NAND_FTIM0
-#define CFG_SYS_CS0_FTIM1		CFG_SYS_NAND_FTIM1
-#define CFG_SYS_CS0_FTIM2		CFG_SYS_NAND_FTIM2
-#define CFG_SYS_CS0_FTIM3		CFG_SYS_NAND_FTIM3
-#define CFG_SYS_CSPR1_EXT		CFG_SYS_NOR_CSPR_EXT
-#define CFG_SYS_CSPR1		CFG_SYS_NOR_CSPR
-#define CFG_SYS_AMASK1		CFG_SYS_NOR_AMASK
-#define CFG_SYS_CSOR1		CFG_SYS_NOR_CSOR
-#define CFG_SYS_CS1_FTIM0		CFG_SYS_NOR_FTIM0
-#define CFG_SYS_CS1_FTIM1		CFG_SYS_NOR_FTIM1
-#define CFG_SYS_CS1_FTIM2		CFG_SYS_NOR_FTIM2
-#define CFG_SYS_CS1_FTIM3		CFG_SYS_NOR_FTIM3
-#else
-#define CFG_SYS_CSPR0_EXT		CFG_SYS_NOR_CSPR_EXT
-#define CFG_SYS_CSPR0		CFG_SYS_NOR_CSPR
-#define CFG_SYS_AMASK0		CFG_SYS_NOR_AMASK
-#define CFG_SYS_CSOR0		CFG_SYS_NOR_CSOR
-#define CFG_SYS_CS0_FTIM0		CFG_SYS_NOR_FTIM0
-#define CFG_SYS_CS0_FTIM1		CFG_SYS_NOR_FTIM1
-#define CFG_SYS_CS0_FTIM2		CFG_SYS_NOR_FTIM2
-#define CFG_SYS_CS0_FTIM3		CFG_SYS_NOR_FTIM3
-#define CFG_SYS_CSPR1_EXT		CFG_SYS_NAND_CSPR_EXT
-#define CFG_SYS_CSPR1		CFG_SYS_NAND_CSPR
-#define CFG_SYS_AMASK1		CFG_SYS_NAND_AMASK
-#define CFG_SYS_CSOR1		CFG_SYS_NAND_CSOR
-#define CFG_SYS_CS1_FTIM0		CFG_SYS_NAND_FTIM0
-#define CFG_SYS_CS1_FTIM1		CFG_SYS_NAND_FTIM1
-#define CFG_SYS_CS1_FTIM2		CFG_SYS_NAND_FTIM2
-#define CFG_SYS_CS1_FTIM3		CFG_SYS_NAND_FTIM3
-#endif
-
-/* define to use L1 as initial stack */
-#define CFG_SYS_INIT_RAM_ADDR	0xfdd00000	/* Initial L1 address */
-#define CFG_SYS_INIT_RAM_ADDR_PHYS_HIGH	0xf
-#define CFG_SYS_INIT_RAM_ADDR_PHYS_LOW	0xfe03c000
-/* The assembler doesn't like typecast */
-#define CFG_SYS_INIT_RAM_ADDR_PHYS \
-	((CFG_SYS_INIT_RAM_ADDR_PHYS_HIGH * 1ull << 32) | \
-	  CFG_SYS_INIT_RAM_ADDR_PHYS_LOW)
-#define CFG_SYS_INIT_RAM_SIZE		0x00004000
-
-#define CFG_SYS_INIT_SP_OFFSET	(CFG_SYS_INIT_RAM_SIZE - GENERATED_GBL_DATA_SIZE)
-
-/* Serial Port - controlled on board with jumper J8
- * open - index 2
- * shorted - index 1
- */
-#if !CONFIG_IS_ENABLED(DM_SERIAL)
-#define CFG_SYS_NS16550_CLK		(get_bus_freq(0)/2)
-#endif
-
-#define CFG_SYS_BAUDRATE_TABLE	\
-	{300, 600, 1200, 2400, 4800, 9600, 19200, 38400, 57600, 115200}
-
-#define CFG_SYS_NS16550_COM1	(CFG_SYS_CCSRBAR+0x11C500)
-#define CFG_SYS_NS16550_COM2	(CFG_SYS_CCSRBAR+0x11C600)
-#define CFG_SYS_NS16550_COM3	(CFG_SYS_CCSRBAR+0x11D500)
-#define CFG_SYS_NS16550_COM4	(CFG_SYS_CCSRBAR+0x11D600)
-
-/* I2C bus multiplexer */
-#define I2C_MUX_PCA_ADDR                0x70
-#define I2C_MUX_CH_DEFAULT      0x8
-
-#if defined(CONFIG_TARGET_T1042D4RDB)
-/*
- * RTC configuration
- */
-#define CFG_SYS_I2C_RTC_ADDR         0x68
-
-#endif
-
-/*
- * eSPI - Enhanced SPI
- */
-
-/*
- * General PCI
- * Memory space is mapped 1-1, but I/O space must start from 0.
- */
-
-#ifdef CONFIG_PCI
-/* controller 1, direct to uli, tgtid 3, Base address 20000 */
-#ifdef CONFIG_PCIE1
-#define	CFG_SYS_PCIE1_MEM_VIRT	0x80000000
-#define	CFG_SYS_PCIE1_MEM_PHYS	0xc00000000ull
-#define CFG_SYS_PCIE1_IO_VIRT	0xf8000000
-#define CFG_SYS_PCIE1_IO_PHYS	0xff8000000ull
-#endif
-
-/* controller 2, Slot 2, tgtid 2, Base address 201000 */
-#ifdef CONFIG_PCIE2
-#define CFG_SYS_PCIE2_MEM_VIRT	0x90000000
-#define CFG_SYS_PCIE2_MEM_PHYS	0xc10000000ull
-#define CFG_SYS_PCIE2_IO_VIRT	0xf8010000
-#define CFG_SYS_PCIE2_IO_PHYS	0xff8010000ull
-#endif
-
-/* controller 3, Slot 1, tgtid 1, Base address 202000 */
-#ifdef CONFIG_PCIE3
-#define CFG_SYS_PCIE3_MEM_VIRT	0xa0000000
-#define CFG_SYS_PCIE3_MEM_PHYS	0xc20000000ull
-#endif
-
-/* controller 4, Base address 203000 */
-#ifdef CONFIG_PCIE4
-#define CFG_SYS_PCIE4_MEM_VIRT	0xb0000000
-#define CFG_SYS_PCIE4_MEM_PHYS	0xc30000000ull
-#endif
-#endif	/* CONFIG_PCI */
-
-/*
-* USB
-*/
-
-#ifdef CONFIG_MMC
-#define CFG_SYS_FSL_ESDHC_ADDR       CFG_SYS_MPC85xx_ESDHC_ADDR
-#endif
-
-/* Qman/Bman */
-#ifndef CONFIG_NOBQFMAN
-#define CFG_SYS_BMAN_NUM_PORTALS	10
-#define CFG_SYS_BMAN_MEM_BASE	0xf4000000
-#define CFG_SYS_BMAN_MEM_PHYS	0xff4000000ull
-#define CFG_SYS_BMAN_MEM_SIZE	0x02000000
-#define CFG_SYS_BMAN_SP_CENA_SIZE    0x4000
-#define CFG_SYS_BMAN_SP_CINH_SIZE    0x1000
-#define CFG_SYS_BMAN_CENA_BASE       CFG_SYS_BMAN_MEM_BASE
-#define CFG_SYS_BMAN_CENA_SIZE       (CFG_SYS_BMAN_MEM_SIZE >> 1)
-#define CFG_SYS_BMAN_CINH_BASE       (CFG_SYS_BMAN_MEM_BASE + \
-					CFG_SYS_BMAN_CENA_SIZE)
-#define CFG_SYS_BMAN_CINH_SIZE       (CFG_SYS_BMAN_MEM_SIZE >> 1)
-#define CFG_SYS_BMAN_SWP_ISDR_REG	0xE08
-#define CFG_SYS_QMAN_NUM_PORTALS	10
-#define CFG_SYS_QMAN_MEM_BASE	0xf6000000
-#define CFG_SYS_QMAN_MEM_PHYS	0xff6000000ull
-#define CFG_SYS_QMAN_MEM_SIZE	0x02000000
-#define CFG_SYS_QMAN_SP_CINH_SIZE    0x1000
-#define CFG_SYS_QMAN_CENA_SIZE       (CFG_SYS_QMAN_MEM_SIZE >> 1)
-#define CFG_SYS_QMAN_CINH_BASE       (CFG_SYS_QMAN_MEM_BASE + \
-					CFG_SYS_QMAN_CENA_SIZE)
-#define CFG_SYS_QMAN_CINH_SIZE       (CFG_SYS_QMAN_MEM_SIZE >> 1)
-#define CFG_SYS_QMAN_SWP_ISDR_REG	0xE08
-#endif /* CONFIG_NOBQFMAN */
-
-#ifdef CONFIG_FMAN_ENET
-#if defined(CONFIG_TARGET_T1042D4RDB)
-#define CFG_SYS_SGMII1_PHY_ADDR             0x02
-#define CFG_SYS_SGMII2_PHY_ADDR             0x03
-#define CFG_SYS_SGMII3_PHY_ADDR             0x01
-#endif
-
-#define CFG_SYS_RGMII1_PHY_ADDR             0x01
-#define CFG_SYS_RGMII2_PHY_ADDR             0x02
-#endif
-
-/*
- * Miscellaneous configurable options
- */
-
-/*
- * For booting Linux, the board info and command line data
- * have to be in the first 64 MB of memory, since this is
- * the maximum mapped by the Linux kernel during initialization.
- */
-#define CFG_SYS_BOOTMAPSZ	(64 << 20)	/* Initial map for Linux*/
-
-/*
- * Dynamic MTD Partition support with mtdparts
- */
-
-/*
- * Environment Configuration
- */
-
-#define __USB_PHY_TYPE	utmi
-#define RAMDISKFILE	"t104xrdb/ramdisk.uboot"
-
-#if defined(CONFIG_TARGET_T1042D4RDB)
-#define FDTFILE		"t1042rdb/t1042d4rdb.dtb"
-#endif
-
-#define	CFG_EXTRA_ENV_SETTINGS				\
-	"hwconfig=fsl_ddr:bank_intlv=cs0_cs1;"			\
-	"usb1:dr_mode=host,phy_type=" __stringify(__USB_PHY_TYPE) ";"\
-	"usb2:dr_mode=host,phy_type=" __stringify(__USB_PHY_TYPE) "\0"\
-	"netdev=eth0\0"						\
-	"uboot=" CONFIG_UBOOTPATH "\0"		\
-	"ubootaddr=" __stringify(CONFIG_TEXT_BASE) "\0"	\
-	"tftpflash=tftpboot $loadaddr $uboot && "		\
-	"protect off $ubootaddr +$filesize && "			\
-	"erase $ubootaddr +$filesize && "			\
-	"cp.b $loadaddr $ubootaddr $filesize && "		\
-	"protect on $ubootaddr +$filesize && "			\
-	"cmp.b $loadaddr $ubootaddr $filesize\0"		\
-	"consoledev=ttyS0\0"					\
-	"ramdiskaddr=2000000\0"					\
-	"ramdiskfile=" __stringify(RAMDISKFILE) "\0"		\
-	"fdtaddr=1e00000\0"					\
-	"fdtfile=" __stringify(FDTFILE) "\0"			\
-	"bdev=sda3\0"
-
-#include <asm/fsl_secure_boot.h>
-
-#endif	/* __CONFIG_H */
-- 
2.47.3

