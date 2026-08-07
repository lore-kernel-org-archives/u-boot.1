Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E089AC5AC7C
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 11:48:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9E6B860A66;
	Fri,  7 Aug 2026 11:48:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O9ubeBqn_3fk; Fri,  7 Aug 2026 11:48:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D08D060A5E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786103315;
	bh=4FNrsDx1ezdi/H05kGx6ZUmUU1YBkf52JpIDvFgo1Ak=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=HJ6/veZfBwFIo+qqiryk2gK7if4lewTQqkllhP8u6/6Ip7x035Pfu/bF72ZIErFdb
	 cEFgiF5zfWROeI0rqVxCiOZ5981pA0eYH0bcLuZGr1DhVfb8kci8UHFXp228+g+7Pv
	 uDM05boOQfYXQDbNUeMxTLQtE+nD/4t4e0pzF2Q0IkCJBK4kkelKbBIB7bdBv022iH
	 2tHxmuFoRjQOqwT7o4mn6d+1+2MffBZh3aW5GwcIlgKA3ZQR2vP5C3wFWDEmzYgonT
	 gI2HYqXDbIgxPk+GCdsvRI65pYEkz1mnQApY5TqbLJc88gDCp8eU7ZLmN8S9wgjZp/
	 2h4G0cPuJFO0A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D08D060A5E;
	Fri,  7 Aug 2026 11:48:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 78703259
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 11:48:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7637D403F0
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 11:48:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G66sdzsoSVAD for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 11:48:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::533; helo=mail-pg1-x533.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 9AD7B40105
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9AD7B40105
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9AD7B40105
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 11:48:32 +0000 (UTC)
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-c9eefcf9175so3104311a12.3
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 04:48:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786103312; x=1786708112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4FNrsDx1ezdi/H05kGx6ZUmUU1YBkf52JpIDvFgo1Ak=;
 b=TwU38B/XnA8dth4rVdTyHjIV7ttAsGgyYF12Zvia68YpIvgvdFiL3xH4CrmPYjBR15
 u7COfXvmGCug7Nbnl96Dr2rmwTKk6uXkUZ0jbXea7lhB6Kqo8vi98GrpR6aKeRKI6327
 aDiUWLpbeFdMqZkAUL0mzmXw6c+vSPtcxCeQe2f5Ncru+OBfHT62CWD1qMoSrtsCUJW4
 cLJ7iAoVj+ScJowu05awuTU1T0gcgHBtpO3I3SeCleNXNPBZXfG2+QshibXRsas09h1Q
 VTv99bsAeugxJoqzo51XzF40iHC3D5MNCQ86inbJHFAf31Ge8DPLvE+XZ27j8idLvwLz
 Fttg==
X-Gm-Message-State: AOJu0YxwasTu6+zld3g86dg4M3yc2aWPRuYsjtxYzMnJpHKjKzQ+VXb8
 Oz4kMuRTvTp1jrgrTaJn/dyv8YUF5RzWzUyrpknzlZfBL9cz0Y/z0CJO
X-Gm-Gg: AR+sD12Sk8rxe3YaHrXQUKawNVa/FnnL8I6nXzJu8eB9dKsyELLBjTJMoSvjjTGnpmO
 MG3IC0S4riJ3IaOU08c26ViSzsth7msqM5zefWezE7cklOuE178M8MBCszy20D7ehqu3bDATL+L
 TS1SwdUMm8ygoPaTqWGKAN/ZXoB/0KuEercREHIFHtCFI6zksoPCLNROPVD7Tjsf73C4lge+cVI
 3hQFR8Ea1lc5BIXjK0IAkNe/8l7pIQY+NpGzIL3nwI+mEa04nvT8nhk7P6nwumzVXy9i7zqezif
 FB2w4A6hyGZSJhdNsPeKY2hQRtuVos4Ef4YnDrs39rS09/8AsJItJgOTeBTJtS/66ROo2OBTel7
 0GF2YIlMdts+1Gp+JvKefl8HKanEGpQNO5G+ofDgAnHgR5gkC4lNWkphv4MOUchI5itNc/YRVVV
 RVDOZx5o1ECXNIsnpqUz81/8sREA6RP6JMcAtiRZ7xmWBTApMx3UIkxpLPaGHDcCI4pR2HQf4My
 9gXX3ywPJzLP/OPji0HAL/pYKwUFknjXSHY
X-Received: by 2002:a05:6a20:9f09:b0:3b4:8f57:3205 with SMTP id
 adf61e73a8af0-3cbc04eb981mr4500171637.36.1786103311824; 
 Fri, 07 Aug 2026 04:48:31 -0700 (PDT)
Received: from fabio-X870-EAGLE-WIFI7..
 ([2804:1b3:a801:e1cd:ebcb:49bb:7cdf:90a])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-141019b4244sm6401549c88.4.2026.08.07.04.48.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 04:48:30 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.u-boot-project.org, emanuele.ghidoli@toradex.com,
 franz.schnyder@toradex.com, ingo.rah@linutronix.de, qijian.guo@nxp.com,
 marex@nabladev.com
Subject: [GIT PULL] Please pull u-boot-imx-main-20260807
Date: Fri,  7 Aug 2026 08:48:27 -0300
Message-ID: <20260807114827.51236-1-festevam@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786103312; x=1786708112;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4FNrsDx1ezdi/H05kGx6ZUmUU1YBkf52JpIDvFgo1Ak=;
 b=pkwkPnO+956DPPPMJO/0vFqZA1kqE21CJl+F8DSZhzof1vbv6GljuK7HjRV9RWfR6P
 EHGYVGlcCY+wmzbk4FTBKS4NNkAtPRcjHbuQmVn2QsFKDfDC6TecMgTboGrNyujPmZG8
 BGxZh3QdktaLlPkLqcHp31mlnHm6soYLFeISMwb3TwcfvO9/xrRIfuGhnKaR1BdgRZtf
 BsHFej9nzghAwU+vW1MkghztPips/8T16nAkzHYztpXlJp7WfD4ZaAomXD2fapiqhH1h
 CTnqw3w0iJ1fPC/Mrfdcu3H7c7TuXFJd8oL8B9mY7k+GZElxQxexLxwvWaq96/rza7gI
 DWbw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=pkwkPnO+
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Tom,

Please pull from u-boot-imx/main, thanks.

The following changes since commit baa64b2f892890f00a377eac4a3e685472bb56b5:

  Merge tag 'efi-2026-10-rc2-2' of https://git.u-boot-project.org/u-boot/custodians/u-boot-efi (2026-07-31 08:55:30 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-main-20260807

for you to fetch changes up to fca58e8a08cf2ba2b09350732fd2b8d62b265463:

  binman: nxp_imx8mcst: Handle FCFB header during SPI NOR boot (2026-08-06 22:05:45 -0300)

u-boot-imx-main-20260807
------------------------

CI: https://git.u-boot-project.org/u-boot/custodians/u-boot-imx/-/pipelines/906

- Fix a boot regression on i.MX7 related to the system counter.
- Add Aquila iMX95 0243 PID4.
- Update phycore_imx8mm DDR timings.
- Add FRDM-IMX95 initial support.
- Handle FCFB header during SPI NOR boot and CST backend selection.
----------------------------------------------------------------
Emanuele Ghidoli (1):
      arm: imx: initialize the system counter earlier on i.MX7

Franz Schnyder (1):
      toradex: tdx-cfg-block: Add Aquila iMX95 0243 PID4

INgo Rah (2):
      board: phycore_imx8mm: update RAM timings
      board: phycore_imx8mm: add 1 and 4GB RAM timings

Joseph Guo (2):
      imx: scmi: suppress invalid origin/errid in reset reason print
      imx: Add FRDM-IMX95 initial support

Marek Vasut (2):
      binman: add CST backend selection for i.MX8M signing
      binman: nxp_imx8mcst: Handle FCFB header during SPI NOR boot

 arch/arm/dts/imx8mm-phygate-tauri-l-u-boot.dtsi  |   23 +
 arch/arm/dts/imx95-15x15-frdm-u-boot.dtsi        |   81 +
 arch/arm/mach-imx/imx9/Kconfig                   |    9 +
 arch/arm/mach-imx/imx9/scmi/soc.c                |   52 +-
 arch/arm/mach-imx/mx7/soc.c                      |    6 +
 arch/arm/mach-imx/syscounter.c                   |    6 +-
 board/nxp/imx95_frdm/Kconfig                     |   12 +
 board/nxp/imx95_frdm/MAINTAINERS                 |    6 +
 board/nxp/imx95_frdm/Makefile                    |   11 +
 board/nxp/imx95_frdm/imx95_frdm.c                |   24 +
 board/nxp/imx95_frdm/imx95_frdm.env              |   93 ++
 board/nxp/imx95_frdm/spl.c                       |   82 +
 board/phytec/phycore_imx8mm/Kconfig              |   65 +
 board/phytec/phycore_imx8mm/lpddr4_timing.c      | 1867 +++++++++++-----------
 board/phytec/phycore_imx8mm/lpddr4_timing.h      |   13 +
 board/phytec/phycore_imx8mm/phycore-imx8mm.c     |   18 +
 board/phytec/phycore_imx8mm/spl.c                |   56 +-
 board/toradex/common/tdx-cfg-block.c             |    1 +
 board/toradex/common/tdx-cfg-block.h             |    1 +
 configs/imx8mm-phygate-tauri-l_defconfig         |    1 +
 configs/imx95_15x15_frdm_defconfig               |  143 ++
 doc/board/nxp/imx95_frdm.rst                     |  131 ++
 doc/board/nxp/index.rst                          |    1 +
 doc/imx/habv4/guides/mx8m_spl_secure_boot.txt    |   30 +-
 include/configs/imx95_frdm.h                     |   23 +
 include/configs/phycore_imx8mm.h                 |    5 +-
 tools/binman/etype/nxp_imx8mcst.py               |   38 +-
 tools/binman/ftest.py                            |   33 +
 tools/binman/test/vendor/nxp_imx8_csf_pkcs11.dts |   27 +
 29 files changed, 1852 insertions(+), 1006 deletions(-)
 create mode 100644 arch/arm/dts/imx95-15x15-frdm-u-boot.dtsi
 create mode 100644 board/nxp/imx95_frdm/Kconfig
 create mode 100644 board/nxp/imx95_frdm/MAINTAINERS
 create mode 100644 board/nxp/imx95_frdm/Makefile
 create mode 100644 board/nxp/imx95_frdm/imx95_frdm.c
 create mode 100644 board/nxp/imx95_frdm/imx95_frdm.env
 create mode 100644 board/nxp/imx95_frdm/spl.c
 create mode 100644 board/phytec/phycore_imx8mm/lpddr4_timing.h
 create mode 100644 configs/imx95_15x15_frdm_defconfig
 create mode 100644 doc/board/nxp/imx95_frdm.rst
 create mode 100644 include/configs/imx95_frdm.h
 create mode 100644 tools/binman/test/vendor/nxp_imx8_csf_pkcs11.dts
